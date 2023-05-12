Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72125C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 05:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3002110E61A;
	Fri, 12 May 2023 05:41:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C454010E61A
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 05:41:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPh5KeDOoN/tsoRdCwliX9/sSmsdIBfr7g6PbEO6PF1Xkyikj3s4gmoPAoJhIS6lC8Au9ahbD/7HB9IshNYsJTqNXCh2zEJtKAG2myxx+U2X2WzfXg+IQK71K0WxQsHNLuGBDA+rV64S5g1xuOD+yxZFZJU41p8v6AQMTFdgkTIowGn3hZHZL9znTlQxnip7XMZRR3HeMSaLtRM5UYcCXcvTrf/tqz05K1Ly+aYDilMI2qXX6QFVzVvhZMf3TLtkL8Ya4NUa6VqSYiGVbQ7d2fBGaDqPSt4iuFFqlTPGv8KY3WHbC6myMOG2kX1yg/fPiDOycYB3YX7pFMFdCL+9qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vz869WC4LNu62ytSw11/3SFvW2lhuvKpMoV+URkiBIU=;
 b=V+6LNubt3DI82jCTeQp6gLG63OwhalbI/LuzR1L+3ItmEf6XvUVmsU5hXG8Jo/XrfhGE4MIwNU3HW998fpNjhoXu1mhxPyyqWDeSQKSaTbZzwV53tt8lqjSAmL2q1/TsA7d/8F1ltZWDGRXFBVnx9X0EngPVm0FEsg3g1GtwNa26o5Lr/yLqPz4Mv7jSeYjHTmWnAAJOwbaUAR9K+3PYuYRe+h6vCOKP5H4g+VijsK4bi14n/ls4a2FrbfmdUzTcny+yTM/f6gEsFDmKoilLIJ13JaBG8ogCqcMXawgSG8ap7Cf2kpDzjFVCjQMC42VXygM8aZPtRM9pFLtSWWGlOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vz869WC4LNu62ytSw11/3SFvW2lhuvKpMoV+URkiBIU=;
 b=wwSBn49Ypw+avF+jOgb/YsCwzj4Y+fuCLcNFv/IOFimdRVDZfcdjcrlU5LyNRVIt4M8aPgpsgjzU77mBAFv5wCsaTJvgACEbWzTOeUKCV3RvK53qdlKx3/TLuzEI/mpLzgKKw/WK7jllYvbXaZwbouns7qLgNLlexihHj5oiLsY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Fri, 12 May 2023 05:41:27 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::5ad3:9c0d:b7f:3bd9%6]) with mapi id 15.20.6387.020; Fri, 12 May 2023
 05:41:27 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: fix possible power mode mismatch between
 driver and PMFW
Thread-Topic: [PATCH] drm/amd/pm: fix possible power mode mismatch between
 driver and PMFW
Thread-Index: AQHZhIBpVuCtTTMyrU2j0Xwp+URS6q9WH5QQ
Date: Fri, 12 May 2023 05:41:26 +0000
Message-ID: <DM4PR12MB5165A511213C674B1AEB21958E759@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20230512031801.471234-1-evan.quan@amd.com>
In-Reply-To: <20230512031801.471234-1-evan.quan@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f44d9d2a-6a66-4934-9fbd-9c1b28d45f56;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-12T05:40:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|DM4PR12MB6373:EE_
x-ms-office365-filtering-correlation-id: 77dad5ed-7dfc-4f8d-fc60-08db52ab876e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZhHi2AXKrO7MufkmhwWAxNPOrYSqBTocGKa2+WOA2ccX5F9mN6WhyeVPfm4vdF/ByYuGKtj006HpLTHGdqfLeTC0CLMbaCf6zIEjdalms4aSsO4m3Rq7lAhRheDtni+4h0zj20k/G7U9GDVdxJZJh5YATzEqQ9gF8LIIlSA9bXWQeCllGx9TlU/9CbM7Y/RTcRURSgiRg5fuzRIv2pPCAnshINV7v40lQJjl1SmqoRO/QVOKr03n4Gu3v+BbgpsLD64chg2zQo+Q4DIA1FqyQXOtaRvov2FCD8xPbsfdvicroyE1OtHsBpa2uUQtCluEBJx2rHjayxGjJ4rGubZzH5ZpqbXNzs9e8UiRf31Hr3P5V1n29lmFFsxINjVQorXH3ryH+dxp+e22XlRSSYRzvVBZHtn2FLAi1uUuL8LnQGP+UzWnh2bXN/g48rl1E6rbCM826za086wndOGa5Ksioamic36ZI3HRPV0F8N/n99NycFdHnLyQpggLGUGAleImocxGBGsyzfSvlj3HGRFfre31f6LUuHdwMjw6YYn68lVP+okqBMgAhnp6rLdfKroeaq11pHctI35yeB5z9P2B24/z8xYhFwVEXIvvSbNpFQVFup9JtmJFqHxbpHHsRZQr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(478600001)(7696005)(55016003)(83380400001)(38100700002)(41300700001)(9686003)(4326008)(53546011)(5660300002)(6506007)(52536014)(110136005)(122000001)(71200400001)(64756008)(66556008)(66946007)(66446008)(66476007)(86362001)(26005)(38070700005)(316002)(8936002)(8676002)(33656002)(186003)(2906002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S1JHdV/BqbZbiOWwXw7+HplXIlREMHVcGYj70DhPpwcMGVn5TwvFLVpgbg/y?=
 =?us-ascii?Q?qnkhQnv+bcdY1KvqA0LYfP3x+KaeALyqgzyybWcz/gOaLpL8GFHGkh2DGxSk?=
 =?us-ascii?Q?tkLO/Hw3E2PJ9keSoDNfOUWu19eoVncbTXZBFKCR022giGQq1DmguCIKfcqd?=
 =?us-ascii?Q?QRHRvXnWAkVW5zhixcsN40QXPfELn1I2XicEriqNlq5fccHmHJWX50pyYTh4?=
 =?us-ascii?Q?k7Bd4e10GNL8pZGgOoOGh9914TxpEyJKbPbsdK5tZaV8pmfMH+lrpIZlLw+y?=
 =?us-ascii?Q?6rng1Dx6qjrX4KUDW6cRPE+/z0vREJgLmJ4SU2URwwaCtNIKg05ItIDitCij?=
 =?us-ascii?Q?q5WdGNFA/VIehUzbv7ZwtkR/nql5nD/Cobq36K02+0YiHQ/bwIr4TWGCVjvu?=
 =?us-ascii?Q?vAJUiFNma8yUcNnucLL+r6k4gLBOG518wDvvIqegANykt4A16RUCdgj62jKu?=
 =?us-ascii?Q?11aOPGVlVOI9ZcwpJ/hrjLILv1hF2YLzPjhVQNHZPWLwag+qZK4Wit+BHWvW?=
 =?us-ascii?Q?LCWo2ro1wFtVXj/ltejn1kuIKrjuPIqqmLSwqqM/EFLlPd+VaTpzCtaQJsHe?=
 =?us-ascii?Q?BMMpYhTgFdVf0oSAN0yjHxG24jtKCp+Hm4xFDn+9SLi1GWZu6aXVr0CtDaKc?=
 =?us-ascii?Q?Ht4GPLAxW/KCx9Y7USLSfQTL5PBTucYTeeonwAfM78EGlsQtbEy+5reVNyTe?=
 =?us-ascii?Q?juzU3oOYzYnb+pXH9SVqP98F1HmeQ7q63SNGh1bhSJ2lr/BYOiLC1YBjvhwC?=
 =?us-ascii?Q?lkh1LLOTX7Ti28fEpbWlhusZ3J+yGAbIpXqw+aMIKb8FvTXbNOCa5coS+hcn?=
 =?us-ascii?Q?+j+I8ZbAJvKsCEpoRCorKr8TF3JU8mA5K9UtqFtTDM/6CdY9w7ZBBOec7oOO?=
 =?us-ascii?Q?EVbl0Sfh/pkAY7BxEfFQ/XMCccsIIBZnxEyxIzVTQVw4UHEs/NfxVraR+Dal?=
 =?us-ascii?Q?GdFyuRTq9876i4zafBebgkNak7+bHhWZghntqRWqybKudnrD4+yGW7UVYgSu?=
 =?us-ascii?Q?dgbTv0I9ImlFeGkjXJKmWlGSVKQbdpetdAtpC8Yj8/jj/4dDIf1+wPXeeSD+?=
 =?us-ascii?Q?cW1M8jDdvBZEJsoickdt/llqLnBeU/70nx9lKFOjpvMWn3bykTQr492cnINR?=
 =?us-ascii?Q?E1lBOvRlWa1IJYe7vL7GPbODazw9WwaAca1kUkj91j2r8edM6dOpyMTXsCoe?=
 =?us-ascii?Q?R4dHamkD04nZCPCKOdIJV2fc2GAO2wPJpNiYeaXjxPXtRpf3lueJKX2b5I+D?=
 =?us-ascii?Q?9x95ckCfiUmpK7wkAgrE93jcvaVmLxGa/fEP9+rIibDkUTGgnRYfbNaLmrKC?=
 =?us-ascii?Q?xNOUQYRA/uTVItALy/l9oLAVpJuTaEOY/qpaaWQ1SL3dyPucqBKt2rjMgv3f?=
 =?us-ascii?Q?6orn6Fza2smRVytidJmugyYep8gRO/ymAPh3UmlUXb0o6X/LUqZe136qI4GB?=
 =?us-ascii?Q?Bp0itckA7UCuCYy6Z+ETKWgcNdEVUmG8EECHFInAOBcBPLlThe59OGwgHgNk?=
 =?us-ascii?Q?AALw4opd3iJcSQcNEuwxPHwI1liErio7QkxzR2w2pAtWMyMHHFJTfVSfWkvI?=
 =?us-ascii?Q?vLaIBrnhq1uRQQrSdFM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77dad5ed-7dfc-4f8d-fc60-08db52ab876e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 05:41:26.7541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLO7Q9wPBDNN9Y4M92ti6Mob07AB/r+oTTjiKPDrmbewkn50dXjazjqd3psrJKFR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Friday, May 12, 2023 11:18 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: fix possible power mode mismatch between drive=
r and PMFW

PMFW may boots the ASIC with a different power mode from the system's real =
one. Notify PMFW explicitly the power mode the system in. This is needed on=
ly when ACDC switch via gpio is not supported.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 18 +++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 20 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index 5633c5797e85..2ddf5198e5c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,6 +733,24 @@ static int smu_late_init(void *handle)
                return ret;
        }

+       /*
+        * Explicitly notify PMFW the power mode the system in. Since
+        * the PMFW may boot the ASIC with a different mode.
+        * For those supporting ACDC switch via gpio, PMFW will
+        * handle the switch automatically. Driver involvement
+        * is unnecessary.
+        */
+       if (!smu->dc_controlled_by_gpio) {
+               ret =3D smu_set_power_source(smu,
+                                          adev->pm.ac_power ? SMU_POWER_SO=
URCE_AC :
+                                          SMU_POWER_SOURCE_DC);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to switch to %s mode!\n"=
,
+                               adev->pm.ac_power ? "AC" : "DC");
+                       return ret;
+               }
+       }
+
        if ((adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 1)) ||
            (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 3)))
                return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c4000518dc56..275f708db636 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3413,26 +3413,8 @@ static int navi10_post_smu_init(struct smu_context *=
smu)
                return 0;

        ret =3D navi10_run_umc_cdr_workaround(smu);
-       if (ret) {
+       if (ret)
                dev_err(adev->dev, "Failed to apply umc cdr workaround!\n")=
;
-               return ret;
-       }
-
-       if (!smu->dc_controlled_by_gpio) {
-               /*
-                * For Navi1X, manually switch it to AC mode as PMFW
-                * may boot it with DC mode.
-                */
-               ret =3D smu_v11_0_set_power_source(smu,
-                                                adev->pm.ac_power ?
-                                                SMU_POWER_SOURCE_AC :
-                                                SMU_POWER_SOURCE_DC);
-               if (ret) {
-                       dev_err(adev->dev, "Failed to switch to %s mode!\n"=
,
-                                       adev->pm.ac_power ? "AC" : "DC");
-                       return ret;
-               }
-       }

        return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3d9ff46706fb..98a33f8ee209 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1770,6 +1770,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
        .enable_mgpu_fan_boost =3D smu_v13_0_7_enable_mgpu_fan_boost,
        .get_power_limit =3D smu_v13_0_7_get_power_limit,
        .set_power_limit =3D smu_v13_0_set_power_limit,
+       .set_power_source =3D smu_v13_0_set_power_source,
        .get_power_profile_mode =3D smu_v13_0_7_get_power_profile_mode,
        .set_power_profile_mode =3D smu_v13_0_7_set_power_profile_mode,
        .set_tool_table_location =3D smu_v13_0_set_tool_table_location,
--
2.34.1

