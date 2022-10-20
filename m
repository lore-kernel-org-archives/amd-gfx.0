Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE79C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 07:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB7010E3C3;
	Thu, 20 Oct 2022 07:30:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B105510E3C3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 07:30:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwOZ0gvwcdbrA684c311IU91u2cbnYYMYH+lUzd10cvv2DpOvLJwUYmPJskyxzKPBsuQAWW5t1GI5Jp09d7nb9jQGd5QMi3zryk3H/QZs2UgxGxjE0d5Qn+6BlmnXf9J16XmvQ7WLBNDO9Qqwl6KJXTnM4TYGekUpXAS5+iuzOeihz5BvB58zJGfIl0skq7xiOlqeRXKMG85e+u9QaITooXyi5+SOUWXHmRqpPVuL7xe37d4E8f4gpCVZS/8H6lKNMwdy952KgoDkwUrJOnrb6XSBJzVelsIlyuUNYZasEdaCDnYAikDiNP5Zqf/YeyDBBq3KHRWMfEV9S31F06yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFY+GPLg+z4PAT6uFoPywgaK1c/EK2lzpMndRvTCAt8=;
 b=Ks42YwYyN5exbS+ZpGo9s8QFayaQsqKjg7+eSg9X5SvuNZVX19/68vLEphMa7z9WSGsfseJSi1Ou/7efWPykxAj59quiAn4zXun8+3+SHAoV5GVADypZuPm2kXKOMnnbw85vDcphO/t5XoxmNIfhrHuYBI9pPEjt7nOiinx8ObRxl0UbJXjcE6TCYvf0lAqo6mtP/RV7d1qsPPBodlNlIDuoawJEvpQMyA974pfK5mvzpgBkovupr6a2Sr4LhVkcaa9lpq1Tz9XCBgP5ZgZfhP3l0nRqL4I0HHjB4HnFPXJfBzhJn8tqUAfW3nBRKRmIjHc+08uKrnL26KUV/tSYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFY+GPLg+z4PAT6uFoPywgaK1c/EK2lzpMndRvTCAt8=;
 b=K0r8XcwWy71TPUEubZPxowhGwOtLe3FEHaUq6rjFfVNro2Ym7HDltGGm13ebFWCX9ZApDcbLFrc6aRTLWh+LKlZhb5PbQnpxtNL4nDRFmTBrg42+lZ8SQcHjl8gU6oT7ozFbj9apSY5QvLJEcnkMqhCVJ4XfOQDQPJRIvSdv6/M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 07:30:01 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::2a8:7b19:18a3:c12c]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::2a8:7b19:18a3:c12c%7]) with mapi id 15.20.5723.033; Thu, 20 Oct 2022
 07:30:01 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: allow gfxoff on gc_11_0_3
Thread-Topic: [PATCH] drm/amd/pm: allow gfxoff on gc_11_0_3
Thread-Index: AQHY5FVehrdPZfyFgUmmiseDvtbGCq4W4rnw
Date: Thu, 20 Oct 2022 07:30:01 +0000
Message-ID: <PH7PR12MB599773D3046E618BBAFE386C822A9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20221020072647.870692-1-kenneth.feng@amd.com>
In-Reply-To: <20221020072647.870692-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=af0e9ba8-3bcd-4d71-9be8-3af8ad77dc9c;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-10-20T07:29:32Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CY8PR12MB7292:EE_
x-ms-office365-filtering-correlation-id: 4a99bbd9-6eb1-4804-4ce6-08dab26ce60e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ObZ3sQ8O+GX3ZbkD8h0tM+BYu3mutn9AuGg7kk8eJsMLAtQwh3qop14b5gGq6WvpbbbZawEQ7A+A8Kn29XTTvUyhkxHc35J1xAetoqP+Fs6U1aq96wPl9oMuTW89Y5WXOSdqwQnNsRZDgOjPgiUvt0VW2wNJL6Up4z4a/o3Ww6UFYkOz0T2at2DLvxP/rpjIfxDxBVuRlB/3iMtO1sWtEjEEoAye9oQ8tkYDctxVa8+ld3eFYLtZpqZhkCMF+/ZJ+/2T1ZvGDmD7T2UNUpYwKSHB6VrjYl8uNxvFx8NHyTySjO+NHli3Upfq8Kgn0WM2Na/6wTD/zFSeBSGVsPgWN2nQvRGVyyfO4PumfzPSINjy42yVCuxTpzl2oY78F7KkZf13WsAPsjSYdnOjemndHkJ9ikHe3nxQwJRZM4k22MGsld9yBu7PMvoYmJD2Qc7XUs7libafT7vwM3cK9uMZ/AzJwAjdRzLc/9yp2Cq3lgzm9QN0qokSFjxgRnJU01UlL7rzFpQD6faZhThOqaDMIBtGyAXPDe7C23txKLzUkKqqvbecSWUufmBXAj3QN2TxB3/4NYoskO1dquPhXUiCcCwP+XFjbCC1K/5TDPwe+YH2gdakzqTQCWq0+VGDVCp7iJi6lGC0xvSyoOlmXYBhDBkaxjuo7sZje6ijvPYiouVGy8dyQfnq8Ttjx9UJj8Luu1eB6cX8dhYuRXj9ReC2cEQHCqJ4HUfa2gPVCZCA1vxNIAIPNQJkLISIoxhhPijTHt6Ft1pHoqa0rvQLH2sXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(66556008)(38070700005)(83380400001)(38100700002)(33656002)(41300700001)(86362001)(52536014)(64756008)(186003)(4326008)(7696005)(26005)(55016003)(76116006)(71200400001)(6506007)(8676002)(9686003)(110136005)(2906002)(66446008)(53546011)(5660300002)(66476007)(8936002)(122000001)(316002)(66946007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vRmmIHIWMrh8EHZI7X51714vb/IIEUWIPnGFpdSQSM6yjN6FhyOMqsgvGMy7?=
 =?us-ascii?Q?MDzmkm2inZ/b/6ClCDlbR7zzKqjma0q6JzPrDi1OPFS1CO1Pq6OHUQeRV2V5?=
 =?us-ascii?Q?FhPPsm96rnVAmSsJHaZuFeKEN2WDSjmGR9Z6PFWaiskXDh0Je2ALeKGTk5v6?=
 =?us-ascii?Q?SixsSyC17jtdSiKm1g1o4qmLTI5wwz7QbkNBWdqGbn3J9tGioOsobM8acQlm?=
 =?us-ascii?Q?X5uaXdFK2t48vNwSM3orUyFkygnENJbf6xVoOjmMiEYf4GYsa7YjPC8CChOi?=
 =?us-ascii?Q?yLdzupVHt2MV6x5t90Jz7CJvaoX4ElxY/mwo2SZh3rtanQFNt9aprNWfBFoA?=
 =?us-ascii?Q?1q5jOL4VDaP2CSQ2rigz2393z7Tnu8D5dv1ZIjb0PtGG/hWsxcVrVX/XA32a?=
 =?us-ascii?Q?C/UknUpzlDo6ekbfe99yFfweSvcmwBZFY+FTpNvQO1/S7l9qKTAh/nZxRVOk?=
 =?us-ascii?Q?IdNt1CEm9BFAPy0yyV0iJSrAUqmalV290lzR34lb4yZ7HvCgN/hSwb2+poK7?=
 =?us-ascii?Q?ReAFBuUuA0/WJYfS4/43gCtqPNHdOkjSyteDlxLVf/B6ixS3LpUWP2M+25uq?=
 =?us-ascii?Q?iK/2OaPNBRo6wmSPWSV9bTiUeCWASLmmqcf4Go3DHU15J2CsYhK4i5194Rdn?=
 =?us-ascii?Q?fgPMVGfQHLPJ+k3KijgefVRU37t0JOc70Xch58EM3jUm5StOF8aumRML/YV+?=
 =?us-ascii?Q?aers0UWc9P726EHHB+VQrs74qYA13UxHD1Y3phPk0Ze1DcJH+XztU+GoaXuu?=
 =?us-ascii?Q?EroJRKXgD6okMa21NvYBlcOkhzejZT2W21PLsdYWGROWL6dAbnHq2f7QA/ae?=
 =?us-ascii?Q?/BrEiR8xPLN8exZImaDPYdSk0TLhZaiEqKgEH2MaiX3MYKHO8OoNMXGwvb6L?=
 =?us-ascii?Q?T2y07AoUA4w25Yp++LkTanmBCp8E2EJUDny8ax2U6hZww2sVLLJ+z7GjmgUk?=
 =?us-ascii?Q?SEO6zNFD0607oTxhC0jBRjpfGB2YMJak5O1NOYD+ZiG2Ysyqe4jcjQ6+hrS6?=
 =?us-ascii?Q?dNW7+Z+0rZ6fdiBA0xGbgc1NsDAhuHERb/Gkvb4Ypzmj6hQC/hG1Cr0MdSxu?=
 =?us-ascii?Q?dhk1TMNFm7ZQ9Pgd9K1uKcXSOe4YN0ZnTS11HA6PXEUcgNir8+99Jpt97R7V?=
 =?us-ascii?Q?EcijEFk2Xu7l6DhZ33uRQ+y6VObC1wVU9ej0CwU+Yd8duKnjT5OFMBMRm3dt?=
 =?us-ascii?Q?1vha9oItCnt3EpqGvjIgOcmbaD0VJZBt+eL4iQGavaAMq5XZes6uXrpY+ros?=
 =?us-ascii?Q?EXR56IifRIerbJHHMEq/M0wGgPPU2RqDo9VEKrkbPuUmxwbKUnCzrFlwf3Py?=
 =?us-ascii?Q?9FxjbSLzqvTT7i3VjzBihGJjlvqeM96nr+qSJwP/iSpAExha+xz5ObACA/r7?=
 =?us-ascii?Q?V7dWU+x87KI1p8c24xMYYduc/LRWawly4MS7fyTtC58xDdo8Fis8xeklF5rG?=
 =?us-ascii?Q?DdlwFJX4jliRvm79R4yNrZJY1sWQGfbrWE1ffVeM4CHNmdaXiH76FT4EMmWF?=
 =?us-ascii?Q?k8mUsRL+GlvUs7i6uSZaR5UCFwj4DnfVwWhAr+HOhvvp4Ed00R+/70uUcHWW?=
 =?us-ascii?Q?VpzI3g/K3OCn/uOmr/I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a99bbd9-6eb1-4804-4ce6-08dab26ce60e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2022 07:30:01.2099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTteCo8iDz2FvNXW5pgjyZdt4Xgr3IsHp0LSJMBto9kUx1+Jug/YVufNobMN9+LV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Thursday, October 20, 2022 3:27 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: allow gfxoff on gc_11_0_3

allow gfxoff on gc_11_0_3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v11_0.c
index e3842dc100d6..5eefba2948a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5051,6 +5051,7 @@ static int gfx_v11_0_set_powergating_state(void *hand=
le,
        switch (adev->ip_versions[GC_HWIP][0]) {
        case IP_VERSION(11, 0, 0):
        case IP_VERSION(11, 0, 2):
+       case IP_VERSION(11, 0, 3):
                amdgpu_gfx_off_ctrl(adev, enable);
                break;
        case IP_VERSION(11, 0, 1):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu13/smu_v13_0.c
index b7b59e04a44f..fff4d8307bb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -840,6 +840,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, =
bool enable)
        case IP_VERSION(13, 0, 5):
        case IP_VERSION(13, 0, 7):
        case IP_VERSION(13, 0, 8):
+       case IP_VERSION(13, 0, 10):
                if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
                        return 0;
                if (enable)
--
2.25.1

