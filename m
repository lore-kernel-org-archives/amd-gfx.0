Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD2FEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 05:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D510510E1C6;
	Mon,  7 Aug 2023 05:46:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A13F10E1C6
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 05:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIkAtTHTFgAaRhro5UCKimlkea/Dem8EPmfPqInJ+HOcFbbKl7qkgVJWLeuPVxNOaHUlMM2qJi1Y8yY8OSxImr4QVyXWZJoVmHc4PFsPeqTvqJcxhSuspr0GdxNMIALbAwubQqiXHoTl1Q1lQhXwq3/fFWN/kMl0as8KVUIbdYBut1mf8BJuj26/4JD7WNRL5v6IKf/+VaI9u8YCaA2ANcIM+b7BMlCss4uQB6YokEcaSKZhXjH31ilcErLdLAoe3XB8Q9qVnHHbgsdASTj4HlJvrK1wPHsdv8Vg1sOwLioCV516fGh7vr9YcCihjGbVpOZyM6fssSINQNtbNMqx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMwfd4LQF8wVa7ZBjtaCEcdWEMGlUnbLcXaTaY55cUg=;
 b=VUE3loaUY4NfeAJHDGtINfNvQ1/aCEyb9nzGKmwS1IHyPTM7klgQ43Fy/iIhVfqiVt8XU0akizicNMLViaVrYroA1peiuOoHIIQNlb04D/FoiDrNMgOOdw3V97Ng2JbkidCm9YxAuuMuD/AKbWiDVNwQIRLvQ3Nbd5Ay7DeM5fyGtp4E8CNJZC46UKgIswka8R45UMFNY+k6K5bZQvHt4Ln3cYgqyRBPuP1bHIpMriWikHn7m+EceEwdobWs3Wft3bVqJ8qPxhao4kaBbpb2ZKlnjBEOi79QQjvb8gkjSa7gxY64zw9QVxwKMsL9/t+TIyEAaT3mPGJtEfffocUVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMwfd4LQF8wVa7ZBjtaCEcdWEMGlUnbLcXaTaY55cUg=;
 b=jlxPrgkGf4FSSfAmTRjkKvCfwLufYceYIX8hs7wVuNifXDziWTz7y60H1DLhnU4EfnBz0oW2/uCGSnbHuiRkdaZncbD8KGeYdgH+Z5NVh1kVvatUoBdgoWypnhhM13ncS8H4VuV5X3QmIZRulNcO9K/ZgBD+BJaSt6muqPApGYw=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 05:46:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 05:46:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Li, 
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add RAS fatal error handler for NBIO v7.9
Thread-Topic: [PATCH] drm/amdgpu: add RAS fatal error handler for NBIO v7.9
Thread-Index: AQHZyNwu99ROU/4lxkihNS/SDHWXyq/eUY1g
Date: Mon, 7 Aug 2023 05:46:07 +0000
Message-ID: <BN9PR12MB5257A8F849F4E6E91C3C28E1FC0CA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230807030623.21757-1-tao.zhou1@amd.com>
In-Reply-To: <20230807030623.21757-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c7b8c228-838f-4176-8997-d33e75b2185c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-07T05:40:13Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CY8PR12MB7363:EE_
x-ms-office365-filtering-correlation-id: 74bdab8d-e492-45d9-366b-08db970998a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYPzj3DoW0tlIFqU/2pxJL29Cp+TKhbCDVxeY5hIofI3MmDc+BZ/evslbVHXYffzhiXDib20BETL3xaw2bx+j7LLH6wiJ3CKqk/APTD0nPeap8SIcgzPPFWUyHxSAKBOx9aR6kXgi5AjNc+Zez0jThIaIYZ4SrmOFJoTqB4aDfXnOMr7QsWlUz+WbDV1ayeLb7IR9+fJezvdYICT6OA5QW0iazfLCNasi/iLQpo8ZO2NG3RyvifFfN+uTRhdZ5PfYiwXYV8QUU1lRjYmiikz4D0GnwJHdTRJqyAOmdrzXFtLrAG7wojaHAMKuJMFsVJb/KcHpEMqhQnUn1xgID5KCSnqpRRfuYWBbpRfqe2ek4IZcKdijGj0LQLcStzCjXu/NPKwgp/UbbEIbgt07sBsa4Tv60MiB+rTBvrON/p9YEUV6zZfzqvRCP5u4jLukmkof/t9/9dWv4oozKBALY/XeanG6hF2yultIIzmoOWUPiPsrwUPxEImdJwivGji4ye8owrSiGSJ11mqMw//T49mwF9u5db82cs2DE9/0b2T6XHAd5laUJoyz2PhNIVMerBJu9fDkPxE3y+oVNkEzdRKHn404dyG75l+orHfGOXJBUeFdrr7KCGz6hWVxdiLiGPR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(1800799003)(186006)(9686003)(55016003)(26005)(6506007)(53546011)(110136005)(38100700002)(5660300002)(38070700005)(52536014)(86362001)(6636002)(2906002)(66446008)(66476007)(66556008)(66946007)(64756008)(76116006)(33656002)(41300700001)(8936002)(8676002)(316002)(71200400001)(7696005)(122000001)(478600001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TWZE9UmBZ3G/8ZHL/y9O5G6Sworz4Of3XNBIq/2p7TPoQM6DUk6NfqirPrq2?=
 =?us-ascii?Q?tIsb/rOJw+eMFE+2S21hRWInXONImjV7EYBIEW1DdSkJOb1TzyO5sxoOTSTv?=
 =?us-ascii?Q?Y1QCynn8dLDJwuF4lec7EMIbz8Dh2csvI4PlL4DcKjpFBKw4P5Wf1Edi/hrk?=
 =?us-ascii?Q?sGgY2Ay66+gN9b5/myG1v2vWnAP2ujvzowvsePCCENv0oVabrpiBXGu1Qezg?=
 =?us-ascii?Q?EM3qXgIwCg36kpetiQWjO9vdLtJa09JSm9e1KImc7i4550sThKSeUjgN9PlC?=
 =?us-ascii?Q?6HvOA3MI2ZrkPxSpk0aUgc+uIGoRkS5p8F8g1Li5m8xkgzKQqrii5vY0zKep?=
 =?us-ascii?Q?7+OxgKupRx/FIU30JWuxLQfClbJ3TKMTpdZeN3Mmuetq+7hQGp6roAKMTrNS?=
 =?us-ascii?Q?740fzqk1Dzlx6vRsMlLVjIFfT4NFAgR1ByU8t0EsS91hSfGodEQ2MltNKmKf?=
 =?us-ascii?Q?CxKMbeXUz4YRvP68mVyvhUkdEfiKQ0WUxn44cUD6rwMP+RxjIb+hox7hhe1X?=
 =?us-ascii?Q?V5se5Qykv8hYCa6AhL3FtPSjWiwxqzch2bxgHmFnRUh1+irFitDEnqqACqyQ?=
 =?us-ascii?Q?zzQMfQiLqdySNGZkSHLuJwA2zjIqzONbNDWHipq43jDEoJuPsaqV2LJIucnj?=
 =?us-ascii?Q?Gs0Cyq5lXM4JH9ehtG5Hs4oot7LahHxW/q1ABOxzpRbLuC8qxZI19/BeAaMi?=
 =?us-ascii?Q?NvsEd81jhP+S2pJtWQWv+KkwxFwITi2T/QofAr6HE5M4CMSc75VthAbMa52s?=
 =?us-ascii?Q?KVT8pblfirIDJBz+6lbnkXgyT7SqsfnC9up+U56CUvNHjuhT4hOvsL94JJKY?=
 =?us-ascii?Q?+B0/06jOB6gpEp5Sa/+MYCNjbvtx95NcD1IaaoO3G2ub98CVUgsdeXfyjXKn?=
 =?us-ascii?Q?1LNXTzflVbXC8p4quDPElDHlxjRbpvQKs7z2p1eU5fCJc85MieZsFxtLuJp9?=
 =?us-ascii?Q?CgClTVDQXgHYVwqUUmlQDfNnM7+7GD2iVYK3jZfoWcuLfH0N7guhpLXSnUqR?=
 =?us-ascii?Q?iEob5pMkqPemzGJWP0UtynwtKiBEe0n61itqVjBAFr805qr07TlTnbv7tKCF?=
 =?us-ascii?Q?L3KEl2KLNeCq7zz2FyJz8CIgJoZ8A9e+QalNIYBofEVETaicz1KfVr2HXq59?=
 =?us-ascii?Q?T//FMUFyuDRvbYO2ouJwpG08vTVGRSfoDYmyCdYptV1rLawtQqvZ3RwBCZ7d?=
 =?us-ascii?Q?CpAdngywVpQPsxMpwauk8136Mid0qySz0m/tY4NdAn/METUiJNR0qDWmkFho?=
 =?us-ascii?Q?9XyQ029lwEFcjp5TAPAWF57zYBBkjaCLheC2Whd5wgrIb3fX+9NtpY3LSSt9?=
 =?us-ascii?Q?lTs13Lurp789YmLD6NtYKQkILm6B77Rw5QVjU/4e5xoN6K/pNQ9Z86K+XJ3s?=
 =?us-ascii?Q?sAL8XVvkATxW/u5WSJZxftxflgjZ6EPr/HDm7HO26WBW/vVldk7dzpZcrHRQ?=
 =?us-ascii?Q?gDjQqEnnlESiTvzMdThGREnohAgw2vHAhEzW8Iu6BmF7CEgphWXbQJlZM+h6?=
 =?us-ascii?Q?L0XD/jJtUs9L14k2n7mygW0wYkhXsOhV9/nSouOK194NiYO2o7K2n1cANtTw?=
 =?us-ascii?Q?BTZBkxFY34uSek6IFrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bdab8d-e492-45d9-366b-08db970998a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 05:46:07.3983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeQJOP97+/R80p2Ai2frrtlPiTbeDU1+CqsxCJEEmkoYNjcq45LFIvYxOc5zH0LdaLbTfj4U/+VFITm19pe7PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

+static int nbio_v7_9_set_ras_err_event_athub_irq_state(struct amdgpu_devic=
e *adev,
+static int nbio_v7_9_set_ras_controller_irq_state(struct amdgpu_device *ad=
ev,

both functions could be left as dummy ones since by default it is vector #1=
 selected in bare-metal environment. Only SRIOV PF driver needs to select v=
ector #4.

Others look good to me. The patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, August 7, 2023 11:06
To: amd-gfx@lists.freedesktop.org; Yang, Stanley <Stanley.Yang@amd.com>; Zh=
ang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com>; Cha=
i, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add RAS fatal error handler for NBIO v7.9

Register RAS fatal error interrupt and add handler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c  | 219 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h  |   1 +
 3 files changed, 224 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 832fa646b38f..bef0f9264b4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -35,6 +35,7 @@
 #include "amdgpu_xgmi.h"
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include "nbio_v4_3.h"
+#include "nbio_v7_9.h"
 #include "atom.h"
 #include "amdgpu_reset.h"

@@ -2663,6 +2664,9 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                         * check DF RAS */
                        adev->nbio.ras =3D &nbio_v4_3_ras;
                break;
+       case IP_VERSION(7, 9, 0):
+               adev->nbio.ras =3D &nbio_v7_9_ras;
+               break;
        default:
                /* nbio ras is not available */
                break;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.c
index cd1a02d30420..cc2268b871e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -451,3 +451,222 @@ const struct amdgpu_nbio_funcs nbio_v7_9_funcs =3D {
        .get_memory_partition_mode =3D nbio_v7_9_get_memory_partition_mode,
        .init_registers =3D nbio_v7_9_init_registers,  };
+
+static void nbio_v7_9_query_ras_error_count(struct amdgpu_device *adev,
+                                       void *ras_error_status)
+{
+       return;
+}
+
+static void nbio_v7_9_handle_ras_controller_intr_no_bifring(struct
+amdgpu_device *adev) {
+       uint32_t bif_doorbell_intr_cntl;
+       struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, adev->nbio.ra=
s_if);
+       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       bif_doorbell_intr_cntl =3D RREG32_SOC15(NBIO, 0,
+regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+       if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+               BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_CNTLR_INTERRUPT_STATUS))=
 {
+               /* driver has to clear the interrupt status when bif ring i=
s disabled */
+               bif_doorbell_intr_cntl =3D REG_SET_FIELD(bif_doorbell_intr_=
cntl,
+                                               BIF_BX0_BIF_DOORBELL_INT_CN=
TL,
+                                               RAS_CNTLR_INTERRUPT_CLEAR, =
1);
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
+bif_doorbell_intr_cntl);
+
+               if (!ras->disable_ras_err_cnt_harvest) {
+                       /*
+                        * clear error status after ras_controller_intr
+                        * according to hw team and count ue number
+                        * for query
+                        */
+                       nbio_v7_9_query_ras_error_count(adev, &err_data);
+
+                       /* logging on error cnt and printing for awareness =
*/
+                       obj->err_data.ue_count +=3D err_data.ue_count;
+                       obj->err_data.ce_count +=3D err_data.ce_count;
+
+                       if (err_data.ce_count)
+                               dev_info(adev->dev, "%ld correctable hardwa=
re "
+                                               "errors detected in %s bloc=
k, "
+                                               "no user action is needed.\=
n",
+                                               obj->err_data.ce_count,
+                                               get_ras_block_str(adev->nbi=
o.ras_if));
+
+                       if (err_data.ue_count)
+                               dev_info(adev->dev, "%ld uncorrectable hard=
ware "
+                                               "errors detected in %s bloc=
k\n",
+                                               obj->err_data.ue_count,
+                                               get_ras_block_str(adev->nbi=
o.ras_if));
+               }
+
+               dev_info(adev->dev, "RAS controller interrupt triggered "
+                                       "by NBIF error\n");
+
+               /* ras_controller_int is dedicated for nbif ras error,
+                * not the global interrupt for sync flood
+                */
+               amdgpu_ras_reset_gpu(adev);
+       }
+}
+
+static void nbio_v7_9_handle_ras_err_event_athub_intr_no_bifring(struct
+amdgpu_device *adev) {
+       uint32_t bif_doorbell_intr_cntl;
+
+       bif_doorbell_intr_cntl =3D RREG32_SOC15(NBIO, 0,
+regBIF_BX0_BIF_DOORBELL_INT_CNTL);
+
+       if (REG_GET_FIELD(bif_doorbell_intr_cntl,
+               BIF_BX0_BIF_DOORBELL_INT_CNTL, RAS_ATHUB_ERR_EVENT_INTERRUP=
T_STATUS)) {
+               /* driver has to clear the interrupt status when bif ring i=
s disabled */
+               bif_doorbell_intr_cntl =3D REG_SET_FIELD(bif_doorbell_intr_=
cntl,
+                                               BIF_BX0_BIF_DOORBELL_INT_CN=
TL,
+                                               RAS_ATHUB_ERR_EVENT_INTERRU=
PT_CLEAR, 1);
+
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
+bif_doorbell_intr_cntl);
+
+               amdgpu_ras_global_ras_isr(adev);
+       }
+}
+
+static int nbio_v7_9_set_ras_controller_irq_state(struct amdgpu_device *ad=
ev,
+                                                 struct amdgpu_irq_src *sr=
c,
+                                                 unsigned type,
+                                                 enum amdgpu_interrupt_sta=
te state) {
+       /* The ras_controller_irq enablement should be done in psp bl when =
it
+        * tries to enable ras feature. Driver only need to set the correct=
 interrupt
+        * vector for bare-metal and sriov use case respectively
+        */
+       uint32_t bif_intr_cntl;
+
+       bif_intr_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL);
+
+       if (state =3D=3D AMDGPU_IRQ_STATE_ENABLE) {
+               /* set interrupt vector select bit to 0 to select
+                * vetcor 1 for bare metal case */
+               bif_intr_cntl =3D REG_SET_FIELD(bif_intr_cntl,
+                                             BIF_BX0_BIF_INTR_CNTL,
+                                             RAS_INTR_VEC_SEL, 0);
+
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL, bif_intr_cn=
tl);
+       }
+
+       return 0;
+}
+
+static int nbio_v7_9_process_ras_controller_irq(struct amdgpu_device *adev=
,
+                                               struct amdgpu_irq_src *sour=
ce,
+                                               struct amdgpu_iv_entry *ent=
ry)
+{
+       /* By design, the ih cookie for ras_controller_irq should be writte=
n
+        * to BIFring instead of general iv ring. However, due to known bif=
 ring
+        * hw bug, it has to be disabled. There is no chance the process fu=
nction
+        * will be involked. Just left it as a dummy one.
+        */
+       return 0;
+}
+
+static int nbio_v7_9_set_ras_err_event_athub_irq_state(struct amdgpu_devic=
e *adev,
+                                                      struct amdgpu_irq_sr=
c *src,
+                                                      unsigned type,
+                                                      enum amdgpu_interrup=
t_state state) {
+       /* The ras_controller_irq enablement should be done in psp bl when =
it
+        * tries to enable ras feature. Driver only need to set the correct=
 interrupt
+        * vector for bare-metal and sriov use case respectively
+        */
+       uint32_t bif_intr_cntl;
+
+       bif_intr_cntl =3D RREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL);
+
+       if (state =3D=3D AMDGPU_IRQ_STATE_ENABLE) {
+               /* set interrupt vector select bit to 0 to select
+                * vetcor 1 for bare metal case */
+               bif_intr_cntl =3D REG_SET_FIELD(bif_intr_cntl,
+                                             BIF_BX0_BIF_INTR_CNTL,
+                                             RAS_INTR_VEC_SEL, 0);
+
+               WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_INTR_CNTL, bif_intr_cn=
tl);
+       }
+
+       return 0;
+}
+
+static int nbio_v7_9_process_err_event_athub_irq(struct amdgpu_device *ade=
v,
+                                                struct amdgpu_irq_src *sou=
rce,
+                                                struct amdgpu_iv_entry *en=
try)
+{
+       /* By design, the ih cookie for err_event_athub_irq should be writt=
en
+        * to BIFring instead of general iv ring. However, due to known bif=
 ring
+        * hw bug, it has to be disabled. There is no chance the process fu=
nction
+        * will be involked. Just left it as a dummy one.
+        */
+       return 0;
+}
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_controller_irq_func=
s =3D {
+       .set =3D nbio_v7_9_set_ras_controller_irq_state,
+       .process =3D nbio_v7_9_process_ras_controller_irq,
+};
+
+static const struct amdgpu_irq_src_funcs nbio_v7_9_ras_err_event_athub_irq=
_funcs =3D {
+       .set =3D nbio_v7_9_set_ras_err_event_athub_irq_state,
+       .process =3D nbio_v7_9_process_err_event_athub_irq,
+};
+
+static int nbio_v7_9_init_ras_controller_interrupt (struct
+amdgpu_device *adev) {
+       int r;
+
+       /* init the irq funcs */
+       adev->nbio.ras_controller_irq.funcs =3D
+               &nbio_v7_9_ras_controller_irq_funcs;
+       adev->nbio.ras_controller_irq.num_types =3D 1;
+
+       /* register ras controller interrupt */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+                             NBIF_7_4__SRCID__RAS_CONTROLLER_INTERRUPT,
+                             &adev->nbio.ras_controller_irq);
+
+       return r;
+}
+
+static int nbio_v7_9_init_ras_err_event_athub_interrupt (struct
+amdgpu_device *adev) {
+
+       int r;
+
+       /* init the irq funcs */
+       adev->nbio.ras_err_event_athub_irq.funcs =3D
+               &nbio_v7_9_ras_err_event_athub_irq_funcs;
+       adev->nbio.ras_err_event_athub_irq.num_types =3D 1;
+
+       /* register ras err event athub interrupt */
+       r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_BIF,
+                             NBIF_7_4__SRCID__ERREVENT_ATHUB_INTERRUPT,
+                             &adev->nbio.ras_err_event_athub_irq);
+
+       return r;
+}
+
+const struct amdgpu_ras_block_hw_ops nbio_v7_9_ras_hw_ops =3D {
+       .query_ras_error_count =3D nbio_v7_9_query_ras_error_count, };
+
+struct amdgpu_nbio_ras nbio_v7_9_ras =3D {
+       .ras_block =3D {
+               .ras_comm =3D {
+                       .name =3D "pcie_bif",
+                       .block =3D AMDGPU_RAS_BLOCK__PCIE_BIF,
+                       .type =3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+               },
+               .hw_ops =3D &nbio_v7_9_ras_hw_ops,
+               .ras_late_init =3D amdgpu_nbio_ras_late_init,
+       },
+       .handle_ras_controller_intr_no_bifring =3D nbio_v7_9_handle_ras_con=
troller_intr_no_bifring,
+       .handle_ras_err_event_athub_intr_no_bifring =3D nbio_v7_9_handle_ra=
s_err_event_athub_intr_no_bifring,
+       .init_ras_controller_interrupt =3D nbio_v7_9_init_ras_controller_in=
terrupt,
+       .init_ras_err_event_athub_interrupt =3D
+nbio_v7_9_init_ras_err_event_athub_interrupt,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_9.h
index 8e04eb484328..73709771950d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.h
@@ -28,5 +28,6 @@

 extern const struct nbio_hdp_flush_reg nbio_v7_9_hdp_flush_reg;  extern co=
nst struct amdgpu_nbio_funcs nbio_v7_9_funcs;
+extern struct amdgpu_nbio_ras nbio_v7_9_ras;

 #endif
--
2.35.1

