Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C08C77B75
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 06:31:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF6410E3B2;
	Wed, 17 May 2023 06:31:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605CC10E3B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 06:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB8ukEQI0Zw/sDRvNjcNidPQspga8ApLFoFLLRy1Gi7PmQtLBKWvwChaitPQ95Fr2JM3Pxh9EqMYWF86csopRf+j/ftsMh79yD9Q8wa+jSf9wjU8wRrUzqfuDWmwPdr7TOqELNT7KPOpXvAGxZ1Xfu4Hc4ZWfgLuSzjTo5/FCKxfIWOQl/mA+ftquU487A+k7AAJNs5NzC2LDEhHJAGKCCTHp2y9QYgtz6A8czwYK8nzIAzkTZwZuWvB26yHDNNjTUlL+4uzsGKKHauv3spoqRDwdRDWy2JHk219S8f/taSS56nSWqvHzgz9Xcdb282sxZ7lt48Or7TTV5iEB/SWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIobGvHdS0eEbfmZw/d+lw3H1fB7ZmKjnOCFGSLOnsA=;
 b=XDzNkb+67gqkt2W3nuV3qJwjAm5TE1gP/MK419u9YvL2LbHsYrMIRTbhQOnYQGiTEZMp2tuDnMPeP3TVwEvbGCQefEmiB8cZbAYWoQK6DZN+0wuPZaa5F3oTYPdgnu2KAVrFACPIyAD+oKVmK0tCTpKnnswZyDojNWk3umAHE89LtseA/FQ6bkL0QLcMRepP1T165k00NUg15WYh+vCwhr3/S6Y9Dj/ZQcBT84m6MiziHEIWCHnOmIkAPjZ2ItQBZTCXqYz0khCRQUnTKcYsoocCGQovUcT1YyyGMz2/lhYKuYP/s5s1qE+gJD1bSz+4soybAl6fusc2RuQNTEyMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIobGvHdS0eEbfmZw/d+lw3H1fB7ZmKjnOCFGSLOnsA=;
 b=LREqYp/5L+VcExmI6J/BbN0aCa4HKw9/8qPbMy6OnL7Dw+UtT31KSYAOxgGg9TGj/U6Mcn7Y3ouFekqHYpBHZ3WoBkqQ904g4n5K6PKsyI5fp4zrM5x5Nhv7czjr4GHTSEb0cio1jTh7l6tYaqCx6y1iozDngjS4RbhAkZzl9oA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 06:31:13 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::d651:aad1:6b1:1194]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::d651:aad1:6b1:1194%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 06:31:13 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx
 v11_0_3
Thread-Topic: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on
 gfx v11_0_3
Thread-Index: AQHZiGVOTSyTnAn/KkuijcMl/ivqg69d0hUAgAAePgA=
Date: Wed, 17 May 2023 06:31:13 +0000
Message-ID: <CH2PR12MB4215EDBF0DD4E3807D353F0FFC7E9@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20230517021330.3096585-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257E58BA0FCBC45D870B6DBFC7E9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E58BA0FCBC45D870B6DBFC7E9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0f329b16-5f4d-4113-95ad-9b22bd404254;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-17T03:41:16Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MW3PR12MB4489:EE_
x-ms-office365-filtering-correlation-id: d206ff0c-2eda-4f5e-ed7b-08db56a04f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7+kRVmQoDFIVJbGuNUxm5O8wRKRvt5aykbqKtEwQ4br1mphYHcxRFRKdcgSiM52onx1uj78zO6v11Wk95sUEFTdat1UBxsbi6YQWISsGaP0vFZPLjC9xdv8OcnYPtTpQazrBCSMi7ga/ozQAVuHV4+gZDcOZ10pU6ysUcA+ZOFx9adT5XEgpkElQ7P4Aa0cc24Jm+a0PIl7rdPNH7R9ff2wGdYsGglXZyXphWmt0IlHLAuoaCXmXZzIWnfuE9Vp2RtRuLmgVys4jeGVxLv/xSKzUgaGiZpBrtmqAWu6KHvBAh3gnUosYEbtNNhY7r0lMj8L+v8dbdj76JY3EzJj3i6ddfqRX21k5hNiFvaDs0Jhp0FBxlted2V1OhpwrhDLHkwuI9s0IaB0tkiMbK2DMyQqlC4VdZnhVqAMR6AiP+IVlB3l9DWtxPCORgTIx6MWmilNvDrdsqk13T3KBvjPo1XJjVZWRk2Hjgg/+lcPAHYTjVi2jf9ip/JelYW50k1qH3eFuFS24AZ5N8bWk0x9cyDWy9X826pFBzl6NPcZ9GH34yw9tqmlBi1bM/Tz7J7VEJ+9MZUUAw1D0TC0vxUQd2qgD6uWjHyfepEyxm/JKg3s8vsBNJ3DElq3bQc+f4Bm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(53546011)(9686003)(26005)(6506007)(83380400001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005)(186003)(54906003)(110136005)(478600001)(316002)(2906002)(41300700001)(52536014)(5660300002)(8936002)(66446008)(76116006)(4326008)(66476007)(66946007)(66556008)(64756008)(8676002)(66899021)(7696005)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uSwPAR24NVNnkWlf4kF/J8NHUhURftF5s0HWDeDiZXpuLUGNL9WsJPKsR4Mo?=
 =?us-ascii?Q?VeUMdjudEGSUXn3e7E/cW8adLLc1r/u90FJghvISsEyh1eTIEOvi8olR53NN?=
 =?us-ascii?Q?HWzf0xIcePwdEJTPCwxnu1VTN5e5NowOAx0Te8zaxsJ3P0YclLY/6Rgn4Q1f?=
 =?us-ascii?Q?oaF1/Wkl/n/3baIhgKEf86Qh0zriYnkYCUDE8FtPxx3vJFnhVAQUBB2Lj4Nd?=
 =?us-ascii?Q?keUygQc81LLG8PYzIBy9cmW6pbi5iXK47dMccFa1pdlR6l+Sm0dGgGdMf+O/?=
 =?us-ascii?Q?v/p7s00boeP8N2Hsl5UVcVFBanCu/sMwtwKVKneFBwHhzPB/72ZstKv8+Pnk?=
 =?us-ascii?Q?z2TLe+cdee6Wd4T9kFSrVDawqFkT1CeeH8do9PCGp6AKBi0+mgXD02PhNlRb?=
 =?us-ascii?Q?HV74Lk8ID2ZTGZgY0W05SUYMvf9c9lJHuqlrnFqYCSmq+M3qtJVkNj9YU/2v?=
 =?us-ascii?Q?Dcw+ScfzAg6A4IiuWsB/2fg9QiVm196K96mjT8HeqRl5elvN47ihdkWcNLQg?=
 =?us-ascii?Q?G2pfh39g2b0kWQl90f9O+qZj6qUqKv6ZNoluy7+jeSRRWFiA1W//YpYNkpqe?=
 =?us-ascii?Q?PSlHJCYmqqR5y0tNN3uHAewygJAhU8kMOL5jNVrwO0UirDwb33HxPDS2tMJa?=
 =?us-ascii?Q?50ags/BqR0pEY6HqGvdFM9DHxHNC5VauLgj0bzmyDHuPmYGmRiPu/MFjhnzS?=
 =?us-ascii?Q?W6pBUPuWz2KV/NRtShZeV28nUPoS1OksCW/tAc5xtUyEeN1CpSA3jce0K3dx?=
 =?us-ascii?Q?xwyg/caBD/QaadDfLjDAA5Zm97btC19URIMMEqOIUyt9MauQeVYpe6hahLpK?=
 =?us-ascii?Q?Xkol9DgoMtHyOjF+P+XRAkXOsBmQPNFLbqMi0tZXUWVtibMEGL0bIZlqvHmR?=
 =?us-ascii?Q?dwMjpADGT3uDkuB6gcKbBvdoP25SvnITwynUlR+faRYXtd5G4G3yLs9/vwnZ?=
 =?us-ascii?Q?98JrO4F6UC6O6T//rfYdvxKIBeQWV8yY41S1i7DnIMjjIPy9PwjPwgNWgadE?=
 =?us-ascii?Q?ZG8kYY4+bH7C46wxSaHVzy46qlXU1A9IVDdHiuqk+PIdkUVC0yL40cC/eLke?=
 =?us-ascii?Q?g6nodM2Owe+qHLAcYNAcPPY/oPwi7eUzmICjnTX5P5QOxArTIF1ZjT1PgNxO?=
 =?us-ascii?Q?eVNO/J4ITEcdqO+9nCWFyzpd15q+N22hzY4ZPlvrxg/JE0ieFX3Hb8OvrEHd?=
 =?us-ascii?Q?9vtrqqyeq9aGsv7uVux9AndoWHVFyD2OwYNidPEQFXfF0XZMaLgtf8vYwcHc?=
 =?us-ascii?Q?4fDZxcIOJDNHIc/A37WhobfwYWnRpsH3wQScOuHzZMNtxVwLXrLAJRlNj+Px?=
 =?us-ascii?Q?RDkiW7AkIORPg8b+foWfSr4z9wlL7oEj2jZGmnILZgreWLidLofltW9hcAes?=
 =?us-ascii?Q?qWSWQRLQicLxT2umVjLumPhCPSQqUb1YOiA0OkfGoUItEFEmyNn8nsXC50Qh?=
 =?us-ascii?Q?WAMXIagg8i9J1Ev0U7MgY7xbWDRJe07BJsCp0dMl+ZMBWAFqUL9YBgHJQnoI?=
 =?us-ascii?Q?X0uf27a9GIx3IolGQRD4rfuLJ/fIZ8F9IFGLKpBBufRpbDWfJIVPaJjcfWyb?=
 =?us-ascii?Q?h92vLuYxXi6no7OUQss=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d206ff0c-2eda-4f5e-ed7b-08db56a04f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 06:31:13.1148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5o/1eUgfhfzx44p6ufIz1ezDOdjhtt4fL+Z7VP+/4LZB55XWvShe/CSlqiJqm5F4A5rfHHCVk807sSWElHlzCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

reset_context is a local variable in amdgpu_ras_do_recovery, if gpu_reset_f=
lag is not used, read regRLC_RLCS_FED_STATUS_0 register and check sdma fed =
error field may move into amdgpu_ras_do_recovery, which may corrupt the cod=
e structure of amdgpu_ras.c.

amdgpu_ras_do_recovery support various mode resets, but the order of these =
resets is fixed and the driver cannot specify a reset type.

gpu_reset_flag is like the input parameter of amdgpu_ras_do_recovery, which=
 allows the driver to specify a special reset type.

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, May 17, 2023 11:41 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang,=
 Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on =
gfx v11_0_3

[AMD Official Use Only - General]

Shall we just force the mode-2 reset if it is non-fatal error mode? Is the =
gpu_reset_flag really necessary in such case?

reset_context.method =3D AMD_RESET_METHOD_MODE2;

Ideally, driver decides either perform reset or other error handling approa=
ch (i.e. unmap queue for gfx) in IP specific handler, while keep the amdgpu=
_ras_do_recovery as the unified entry for various driver mode reset as ras =
error handling. Is it feasible?

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, May 17, 2023 10:14
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang=
, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: perform mode2 reset for sdma fed error on gfx =
v11_0_3

perform mode2 reset for sdma fed error on gfx v11_0_3.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |  8 +++++++-  drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.h  |  5 +++++  drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c=
 | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 6bb438642cc0..f2da69adcd9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2053,9 +2053,15 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                /* Perform full reset in fatal error mode */
                if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
                        set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flag=
s);
-               else
+               else {
                        clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.fl=
ags);

+                       if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MOD=
E2_RESET) {
+                               ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE2_RESET;
+                               reset_context.method =3D AMD_RESET_METHOD_M=
ODE2;
+                       }
+               }
+
                amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
        }
        atomic_set(&ras->in_recovery, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index bc43f7db17cc..46bf1889a9d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -339,6 +339,8 @@ enum amdgpu_ras_ret {
 #define AMDGPU_RAS_ERR_STATUS_VALID    (1 << 1)
 #define AMDGPU_RAS_ERR_ADDRESS_VALID   (1 << 2)

+#define AMDGPU_RAS_GPU_RESET_MODE2_RESET  (0x1 << 0)
+
 struct amdgpu_ras_err_status_reg_entry {
        uint32_t hwip;
        uint32_t ip_inst;
@@ -427,6 +429,9 @@ struct amdgpu_ras {

        /* Indicates smu whether need update bad channel info */
        bool update_channel_flag;
+
+       /* Record special requirements of gpu reset caller */
+       uint32_t  gpu_reset_flags;
 };

 struct ras_fs_data {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0_3.c
index 068b9586a223..26d6286d86c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -84,8 +84,20 @@ static int gfx_v11_0_3_poison_consumption_handler(struct=
 amdgpu_device *adev,
        /* Workaround: when vmid and pasid are both zero, trigger gpu reset=
 in KGD. */
        if (entry && (entry->client_id =3D=3D SOC21_IH_CLIENTID_GFX) &&
            (entry->src_id =3D=3D GFX_11_0_0__SRCID__RLC_GC_FED_INTERRUPT) =
&&
-            !entry->vmid && !entry->pasid)
+            !entry->vmid && !entry->pasid) {
+               uint32_t rlc_status0 =3D 0;
+
+               rlc_status0 =3D RREG32_SOC15(GC, 0, regRLC_RLCS_FED_STATUS_=
0);
+
+               if (REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA0=
_FED_ERR) ||
+                   REG_GET_FIELD(rlc_status0, RLC_RLCS_FED_STATUS_0, SDMA1=
_FED_ERR)) {
+                       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(a=
dev);
+
+                       ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
+               }
+
                amdgpu_ras_reset_gpu(adev);
+       }

        return 0;
 }
--
2.34.1
