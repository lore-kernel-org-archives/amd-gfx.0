Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA795C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC37D10E3CC;
	Wed,  7 Dec 2022 15:25:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5209110E3CC
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:25:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvRLJJ0zo+blAWKlooFRODgAqi3+me2BT7vIoCCkn7RAuFPJ+T6YhG9rUJVtNV23fw5H2b2Mz9rn3R+pJ4N+uxR0m34ckCh9dHMcWGbweI2oaNtDGVdAzOAk19zHy8e2PSTHsGiGrEtIaOKe35oY1RiJOqcHp520EHb7j/jgAG7O5xWTXCEvte2r+IDG2Z/4jTnh6G/u2M4piYwvDbKZSDKJXmsjNRbnVD5MALjvJIqEu/YxRFGKqo68h52v6wbScQLAYTtgUYEka5Aub7sP150HYB/MMyhOQHiVyneaAXlCH5bLFR3PNBocEYIhW8fspAa1Q5PlHBs3WBC5kE3eHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoffb9iHZYD0h2NhqvGDAbeUcO37njKEovUr+jiF6ts=;
 b=MZKjholMChW5jsEnyn/hTi5oVyvT8FmNIrZLSTtgXv2k/TVVYwY1S2OfCS2Zaoq5TAHnpP5gOI5Omg4E1f5Nufgw4g/FFoyOqtPTiYk8kTnota8oTlMn+hTHgH0wygsWkaTYYgAf79xco2XkJYleR6M4CcAKgBRzxq2RWcSJfYd9qtQIXuYI1vlpv7MhEtchy46EuuQPWhd09bvKyXKVRUDHoD7EtVexDYF0UVCgrzMvWUhU2h5hUYVDDZskYjnMkOSextVraufgvXS4oYITtw/0iPMw4DrNy/j4hZ9bys5Tn2EXg7ijSwabqwcw7h2phv0+AyTKrMLT6H/HW0RGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoffb9iHZYD0h2NhqvGDAbeUcO37njKEovUr+jiF6ts=;
 b=dXUGIPJSFxK5a3kP+qZkgTF60358Y5JevG7zM/2Y2EyMaHTDmWV1qAkd8USLloIvMGapjkHUwNF8t8B2PQ2jJ69L0XcyFqQrgBMGiLVpyhpAuZ3kZFzerTUNKVRvpiJJYnl1kfWdonBz98VzjchJXEwc/yRQwyW8NBdHmi/PiUs=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 15:25:18 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:25:18 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Yu, David" <David.Yu@amd.com>
Subject: RE: [PATCH 1/6] drm/amdgpu: inform PF if VF receives RAS poison
 interrupt
Thread-Topic: [PATCH 1/6] drm/amdgpu: inform PF if VF receives RAS poison
 interrupt
Thread-Index: AQHZCiM6Lqz4Qc3aokydPwd8Up36U65iitzA
Date: Wed, 7 Dec 2022 15:25:18 +0000
Message-ID: <BN9PR12MB52574CB182BB724EC82C1D0AFC1A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
In-Reply-To: <20221207100341.15356-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5d4a204-64b7-42da-acd2-42d03fc878e3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:21:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB5124:EE_
x-ms-office365-filtering-correlation-id: f170b56b-fde1-4252-305e-08dad8673f95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGY815Oj4lLYwK79msgEaqJIb++ltWKRlZGbsD/uioDG8VMwWHsvAlZVWwZFSpx78XMCgL6KfylOsF9mckn1RpRMRMOayR2UXUpO55ngMxHqGJnQ3yzHoSEksvm2UgJJz/wS87cJglkORTofuziHT8naAWMvmoiMuuTrvNYNVNcRodzyi0xeme+kFQwA3uTBqKkkqZFUi4SqGBTQ9cUuIJpzRw6CSyYxwvuPxiHxzJsjZLmuszI2lS/7tMaB4v8Lnfz6H4UDmZ1zqGHI+0tHGHlUGA63T5G0y7nPZNR0gk6JN7SGkSiSLe2dI04AR3mSkn94FNQ3t1C5tJgjdhciBZaV/IwsAR7kQ5jvjBBZXmnpzCgbJchH323/b04111kGMtEgcn05JaAxBkH2OzWHv809qd3ouDcQSD8QirYTKVGnxuvPVRwHzvYmk26J+3KRjpA0uKrZnaOUkAVi/mP6p3x5eR7NtdNfLHJbcBc7i+fqBUHIxLWsU1LuZUkvmQn5MdAuZP2+ggmbSw13EKeQlecM/kEdJVuqQNrFe7OONSMhpFmLlOeQp9Qmla9ro0siS+CdivTWYEVp502wF8eQtj08pTCl2+nXcJuj4g3T5AUOzx+aMcObRehxFGudwxrni0UcZ+ji966zDbtz4iTqmi6FAifhHH+p9KjYuCofslln5HekF5idGNPT4HadL8qRuM2g35iyzhSSO77fGoNqSVtmBGnpaD1PwLis6Djz8Bc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(83380400001)(122000001)(33656002)(921005)(86362001)(38100700002)(38070700005)(41300700001)(5660300002)(2906002)(8936002)(52536014)(8676002)(55016003)(26005)(7696005)(9686003)(64756008)(186003)(53546011)(6506007)(316002)(6636002)(110136005)(66946007)(76116006)(66476007)(66556008)(66446008)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EbigTBSFOTrLeYHTCuguwormcZFD6u6AFBFYG/LwGmZykjtoWh03MdUr7arj?=
 =?us-ascii?Q?CSSYJeDnU52MATbkPbRepTkSkIqIhRYFlt5+Rq6haK0oSQrp1LZf2V3mYdeG?=
 =?us-ascii?Q?G3sofH7OklYWsW0hh+IIHOKrUQOoz/igVgc5RrD7airMrZNsknGZ8NBgMBhJ?=
 =?us-ascii?Q?CeKq3wrfNjt7Pj/e9jissThlqyWl6mUv5Kg23Bn+IRGsyd5ExG3k2RgoCW06?=
 =?us-ascii?Q?ZUj7I1SKAs9fvW/KYmz4sRKCrrJqMJWGGYDMPO2Hi6M4io/W13x3e7kF6FUr?=
 =?us-ascii?Q?Tiultw11y1ba2jugOzJgUoOiuVRt+GW153JoHwTAOEjPZB04l1n+8HcoIKKd?=
 =?us-ascii?Q?lvga7MWPZtjbXQ0Ix/+EKsfqtNGmXBGj5OSOKN3jWEavd0blh+97ImkhX3yp?=
 =?us-ascii?Q?+xfFzACiI767pDr9w4RmSWycib0U9HO1MSveP5/e0oLOOXeO502+lvE3bh5w?=
 =?us-ascii?Q?7Y5E8atb/AQeFB3BZAGNVayWpv/WiIf+ujWGXHMTcqssA7qQj6QvudzbIi32?=
 =?us-ascii?Q?pOkzD+qZsejpQyMLF8tzIZUGBMU6gDQt/DZw832vhtOUKo0Qmi5/2cn84cGt?=
 =?us-ascii?Q?24DtD+5pjiRDtwo3zpgexGt3ui2AI/LrzgedCVBBFi0zdf3hYHaM/niDYPW1?=
 =?us-ascii?Q?y1s9XhZrWXc/3mVoeWz24TiJmIz2K0hF2Oc6Y1o8YPlc/XIXIJX61bMRn9oJ?=
 =?us-ascii?Q?hvfOAxZQrlIZNh8I1IYiE+Tq2pEriGdLNg3RFU8c2+nwUaSk4QB0xrq/8REj?=
 =?us-ascii?Q?to63nEsZCyygst7qwFE9f0Dq/x4jDNeWM0SIYB3zW4rps8q/svC6mciA2vBU?=
 =?us-ascii?Q?v5HWeTModyA/4mm9rqjSvDcBt94vQ5A2fkjzwYo38hXo5eg4YNHUIOidjS2u?=
 =?us-ascii?Q?xNzdSwzLnKOVhPEdAF8myhFh8jy9AiQxgEzUX618RFBjcegcW9rQ4qNDEPNP?=
 =?us-ascii?Q?ydtOReshqFP6DEYA4lh5K+rt7OtggHwgsBmwi20GyvRDlzD8b7+dCRAhnHu/?=
 =?us-ascii?Q?dDSfXR9jcPQYVyYy2TlyrbPBToMxDRa/uyTvzXdrcDU7YNPMhjJDrvxpk/2u?=
 =?us-ascii?Q?RE4qKQ5J/NUExzNttryaSby5qglne2s/qC7jTT7cOg5HHcYDBTYTRFl5Cs3A?=
 =?us-ascii?Q?bWpE70FPOMIL4aCZsTXmRhkBbuj8e7DXsVpfyRIu9q45jTAWmidvALqcMgmX?=
 =?us-ascii?Q?XFzKJc3PRt4W/XyaWsGwTOi8Lrn5KS5eXisF+odVsKHFz0AkrXrB3b25leqa?=
 =?us-ascii?Q?QWye6qbAxB8qxZh0UamF6dpn46EOvI0mCf7xwrWOmamjPRpiL07hLliGDKfW?=
 =?us-ascii?Q?npFjZdVOVkJ02Ju9OQj7ykbtK+2r/Q/bwtNPjD1LeqidYjPIx/x/xTr3f29j?=
 =?us-ascii?Q?qhFVR4MBwIFvMxFU0U0StZxmbY8YmPrFY8cM9EY3zhdJ1RjSP9eqHe7b1Mtx?=
 =?us-ascii?Q?uiDao+/OGAd/+Xtw+Puz4ctdoelLpLEzgzj3ctU3LVzexWj0p9rXouZKBVzq?=
 =?us-ascii?Q?/L8t0Nigsdim3AysylnTpmjT0K71A5Jd7X5A9dhAZHmBMp77SLrnLHe47Q9e?=
 =?us-ascii?Q?3uTeppFqYaPrzunCCV4rymPGBSQqZtg/YQqMaJbd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f170b56b-fde1-4252-305e-08dad8673f95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:25:18.5849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rs1tCjBGuofd3+EUxaJ83DKy1LC3pxvU6J3MDq3Bq+oVxLSXjL/9WPDdkptAz/7yctUOinjbehJ/YwX7OZdh7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
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

I suggest split the patch into two

One is adding ras poison handler for mxgpu ai products, similar as patch #2=
, including

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  6 ++++
drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  1 +

The other is adding common umc poison handling path for sriov, including

drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 44 ++++++++++++++----------
Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, December 7, 2022 18:04
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Chand=
er, Vignesh <Vignesh.Chander@amd.com>; Yu, David <David.Yu@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: inform PF if VF receives RAS poison interr=
upt

PF will do page retirement, reset VF and inform VF to reserve RAS bad pages=
.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 44 ++++++++++++++----------  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  6 ++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  1 +
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index f76c19fc0392..1c7fcb4f2380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -169,25 +169,33 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *a=
dev, bool reset)  {
        int ret =3D AMDGPU_RAS_SUCCESS;

-       if (!adev->gmc.xgmi.connected_to_cpu) {
-               struct ras_err_data err_data =3D {0, 0, 0, NULL};
-               struct ras_common_if head =3D {
-                       .block =3D AMDGPU_RAS_BLOCK__UMC,
-               };
-               struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head=
);
-
-               ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL=
, reset);
-
-               if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
-                       obj->err_data.ue_count +=3D err_data.ue_count;
-                       obj->err_data.ce_count +=3D err_data.ce_count;
+       if (!amdgpu_sriov_vf(adev)) {
+               if (!adev->gmc.xgmi.connected_to_cpu) {
+                       struct ras_err_data err_data =3D {0, 0, 0, NULL};
+                       struct ras_common_if head =3D {
+                               .block =3D AMDGPU_RAS_BLOCK__UMC,
+                       };
+                       struct ras_manager *obj =3D amdgpu_ras_find_obj(ade=
v, &head);
+
+                       ret =3D amdgpu_umc_do_page_retirement(adev, &err_da=
ta, NULL, reset);
+
+                       if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
+                               obj->err_data.ue_count +=3D err_data.ue_cou=
nt;
+                               obj->err_data.ce_count +=3D err_data.ce_cou=
nt;
+                       }
+               } else if (reset) {
+                       /* MCA poison handler is only responsible for GPU r=
eset,
+                        * let MCA notifier do page retirement.
+                        */
+                       kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
+                       amdgpu_ras_reset_gpu(adev);
                }
-       } else if (reset) {
-               /* MCA poison handler is only responsible for GPU reset,
-                * let MCA notifier do page retirement.
-                */
-               kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
-               amdgpu_ras_reset_gpu(adev);
+       } else {
+               if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+                       adev->virt.ops->ras_poison_handler(adev);
+               else
+                       dev_warn(adev->dev,
+                               "No ras_poison_handler interface in SRIOV!\=
n");
        }

        return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 2b9d806e23af..b9e9480448af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -88,6 +88,7 @@ struct amdgpu_virt_ops {
        int (*wait_reset)(struct amdgpu_device *adev);
        void (*trans_msg)(struct amdgpu_device *adev, enum idh_request req,
                          u32 data1, u32 data2, u32 data3);
+       void (*ras_poison_handler)(struct amdgpu_device *adev);
 };

 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index 12906ba74462..63725b2ebc03 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -404,6 +404,11 @@ static int xgpu_ai_request_init_data(struct amdgpu_dev=
ice *adev)
        return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);  =
}

+static void xgpu_ai_ras_poison_handler(struct amdgpu_device *adev) {
+       xgpu_ai_send_access_requests(adev, IDH_RAS_POISON); }
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
        .req_full_gpu   =3D xgpu_ai_request_full_gpu_access,
        .rel_full_gpu   =3D xgpu_ai_release_full_gpu_access,
@@ -411,4 +416,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
        .wait_reset =3D NULL,
        .trans_msg =3D xgpu_ai_mailbox_trans_msg,
        .req_init_data  =3D xgpu_ai_request_init_data,
+       .ras_poison_handler =3D xgpu_ai_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.h
index fa7e13e0459e..0136bd059f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -39,6 +39,7 @@ enum idh_request {

        IDH_LOG_VF_ERROR       =3D 200,
        IDH_READY_TO_RESET      =3D 201,
+       IDH_RAS_POISON          =3D 202,
 };

 enum idh_event {
--
2.35.1

