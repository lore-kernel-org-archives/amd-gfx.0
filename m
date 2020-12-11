Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B244C4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (unknown [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20A38249A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20A38249A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD9E76E0D0;
	Fri, 11 Dec 2020 14:52:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65436E0D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 14:52:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVVNgFXNw98YKPKSjQccLyFSrHb5EOMLoumuDZ5AUN4SJd4cpORtencMHJcyNtNL5i4HS0hdKjE18sv9OddI+rxUXNIlT9I2nw/oo4PNV43PKbLfSajKLvK2NheQmDDQEMcxL0Po5as5nczXslFtKkPoYBuo6HUhY6Ebg/PcOxYludthYSzCo7h2yueE9K/tqpLiKQz8WoqcMQJXN3EuRAk2owk9FmtKAq95BI6eScg/7DBLWvTJtghju8Eyh62WqGKfEN/wZUVnhXG0ys5V1Hw4ZiiSYnVpnfnf8lXAcMi/b2ZKZCZU7nnw/HUoys656M9+HUkKtUHyn943g+Vqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmu0qlJVIDQs3M674i7srz2pEU1ne5F+cxYGkSvkDT4=;
 b=WMx0hoCf2MyIsVjlzslxWAizvpMUrLcKmGnSAAyGSh0QNuOoTpsFRjnwxczbVDpU4B/nFwr54yDuPXkO3MJ+q0cPYbxMrs24Giy2B9T8InVvqqzKI9rtHeTeANpmIyqgailJAwGwqvr/YtNRbt33+TCATm1UI2TgsZYVolASlRyFIR0Q3ZXIe70D6fi6xIBWdUKeuXNuCvVE9nUPmkKPFpnRiOWum/+98pUi/RQau5ryN9oKkYt2s5NwFmnMzYh61Lv+d7kw+iBqlZqPA0D+QElgsWtdZFriV6x4y+V60J59pQ8G6AhZM4ZvYtvlOjHM4e4JdwgI4HOO1kTC8duqtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmu0qlJVIDQs3M674i7srz2pEU1ne5F+cxYGkSvkDT4=;
 b=dB6yGhxtaVrcUv79FF6VR6Ch7Km+BVo8UICg6v/BrXDr2F1BK25lwDtv3Sgv6y1yaLCCIg6GuwkMoZPFptxW/Hu+AHMC7vvREUHwc3YaE5QREZ2W3HIgmEGr/xdK59WxceTkwiDw5lbC8luY3wBe1IsTFM3IzvziWznQelSrXsA=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4991.namprd12.prod.outlook.com (2603:10b6:208:a4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Fri, 11 Dec
 2020 14:52:34 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::fca3:155c:bf43:94af%5]) with mapi id 15.20.3632.019; Fri, 11 Dec 2020
 14:52:34 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [V2] drm/amdgpu: add judgement for suspend/resume sequence
Thread-Topic: [V2] drm/amdgpu: add judgement for suspend/resume sequence
Thread-Index: AQHWz5w/iL9X1r/NZEepk3S8gDgLOKnx+zmg
Date: Fri, 11 Dec 2020 14:52:34 +0000
Message-ID: <MN2PR12MB4488E073E832E8550023C9E8F7CA0@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20201211090113.110283-1-likun.gao@amd.com>
In-Reply-To: <20201211090113.110283-1-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-12-11T14:52:33.846Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.78.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6edc444-f648-4f20-a658-08d89de4650a
x-ms-traffictypediagnostic: MN2PR12MB4991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4991F23DE305BFF4EBB28067F7CA0@MN2PR12MB4991.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k2F7Sb4NhyT/8G43aqzsp3H1KWHMGXMqQHgvT8NHfPdO3pp9EhLZ835NehcS9aVqfM+bIj/BZRG4YsDVGneG1mgiGac17BTsryanRgvIamI5Re3asgVXKZv09Rol9Ca4liFl7s8PqZTpzPgQQKOj7PtgHHpyjIos22vvTPKqxF2cmkfOXKNZNsFjnigtvzuWe9oBR12/U147sIt0JjQv3bCeZnCH714g1LWBb6EH3w6fx+7UHFK7ZDKBFUUj7EZnrSLRAO0IlKWtUVOVQbLgyeSHqOg06BJPHka6mo+qSAXYkgl0jOEyJkijmpIuJHjdprbIjxKPaGfSusNf2UCGGuK1mudcCT5xoOIGkhn1S2M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(45080400002)(19627405001)(8676002)(110136005)(4326008)(54906003)(55016002)(2906002)(9686003)(8936002)(5660300002)(26005)(71200400001)(6506007)(508600001)(966005)(66946007)(83380400001)(15650500001)(7696005)(52536014)(66476007)(186003)(66446008)(86362001)(166002)(66556008)(53546011)(64756008)(76116006)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/djuS1mhmwFWMsKN3na6WbJ36MX7GApAjPJ2BCRbuosVXewQbly1sGuLBdUr?=
 =?us-ascii?Q?YYO8205hDeBY3uat3wFBnVcMdJmIlfNjF0T+Oj9r2T6xZmWARs5GIoBG9gCp?=
 =?us-ascii?Q?XFYq3PjDDxbdOHGDkya0cNjc4HwYefBRCTKi3hkqdOxoHexeBqjPatgb5hs6?=
 =?us-ascii?Q?DLcVubB997b12C5Mp1d74aqZMVxMuKknylUcfxFKP4y9TGJb1nH71xtYae6N?=
 =?us-ascii?Q?9GGH0FMp1IMvv62PiU96wcgXgZXVPU9fd8sCA5uBB7w41VxT2xQ330tG6UDu?=
 =?us-ascii?Q?2LN0SfeiQJRFROJDs5TyWOcXw+jy3nPewggA7zGu4GLFZKFK8qTCZic8U209?=
 =?us-ascii?Q?8dCoY4I3wW6LzmnHn8aM+vmHBh2YSpx1cnjtS5FzzINDjfrD6AvadDPB+x7T?=
 =?us-ascii?Q?EC4kqz0m/i3Z/OU1Sni7gJGp8WVrTLQ4Dw2CrDUC0gYn9XHH1fipQwwUnDZZ?=
 =?us-ascii?Q?IJw0qijGzftVp3A7y3lQZbHsz8d33e1h7aXaC/p/vSNmkOJgGgdrPCfZBmx7?=
 =?us-ascii?Q?R/2DmDwOoAPs2+LE6pKczr5qpt3zyRGqqllONl2eklgSZcZPpu2QyHZMJfTf?=
 =?us-ascii?Q?gQaMpDPyxGlO6L3qQwBgjMEtTkl9XFjfO7depvZfUiG1cemadwkzYWvD15MW?=
 =?us-ascii?Q?6MHeK3NuOA1IPgHV9yWBXqyuqlrCx7gX7c99/pgIfSenkxdCE+M4lIOwVkLC?=
 =?us-ascii?Q?dR/Gc7uhbf+39xCAeQ4gLnvFxOgeyn6lgSbcqey3kVlJ8TDo+atb2b0oVXrT?=
 =?us-ascii?Q?B84tP1nxY9teIKCpIIuj7qytRQFqzfrkfZP/mpAI97Qb6lwBhVhsAEhdGZoZ?=
 =?us-ascii?Q?/cHNGfwdLHJp/92ROMMcPQOX7+d0XmNGth8zADYVTsM8J+aFcEwhO3+qDDb3?=
 =?us-ascii?Q?nyqJ2DZrB1sT/MTMZyWS5+ZnTyw5SNW7kB7F6fpi40/wQ7sHuxt+KXp95Pii?=
 =?us-ascii?Q?FAGBXb4mRg9ThahEXMcG39ByuZwu9fHYCDncCFKGTqE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6edc444-f648-4f20-a658-08d89de4650a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 14:52:34.4981 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZTICiJzFNMkDva+GrDLZyyJ2nxzzcBhlst90Utqdo/aj38OfwpApFDu/VNGNdiQkFnNeiY9PeHna90WijPOKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4991
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============0177962015=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0177962015==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488E073E832E8550023C9E8F7CA0MN2PR12MB4488namp_"

--_000_MN2PR12MB4488E073E832E8550023C9E8F7CA0MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Likun Ga=
o <likun.gao@amd.com>
Sent: Friday, December 11, 2020 4:01 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Gao, Likun <Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Z=
hang, Hawking <Hawking.Zhang@amd.com>
Subject: [V2] drm/amdgpu: add judgement for suspend/resume sequence

From: Likun Gao <Likun.Gao@amd.com>

S0ix only makes sense on APUs since they are part of the platform, so
only when the ASIC is APU should set amdgpu_acpi_is_s0ix_supported flag
to deal with the related situation.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: Ic89df206734fa7e6ce3e5a784171f149a07edc80
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 8 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 83ac06a3ec05..eed5410947e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1314,11 +1314,11 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amd=
gpu_device *adev);

 void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,
                 struct amdgpu_dm_backlight_caps *caps);
-bool amdgpu_acpi_is_s0ix_supported(void);
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0;=
 }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_is_s0ix_supported(void) { return false; }
+static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *ade=
v) { return false; }
 #endif

 int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c
index fd66ac00c7f5..8155c54392c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -901,10 +901,12 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s0ix_supported()
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
 {
-       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)
-               return true;
+       if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
+               if (adev->flags & AMD_IS_APU)
+                       return true;
+       }

         return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 52d6f1fbe890..66b790dfb151 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2651,7 +2651,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amd=
gpu_device *adev)
 {
         int i, r;

-       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev)) {
+       if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) =
{
                 amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
                 amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
         }
@@ -3712,7 +3712,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)

         amdgpu_fence_driver_suspend(adev);

-       if (!amdgpu_acpi_is_s0ix_supported() || amdgpu_in_reset(adev))
+       if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
                 r =3D amdgpu_device_ip_suspend_phase2(adev);
         else
                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry)=
;
@@ -3747,7 +3747,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)
         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
                 return 0;

-       if (amdgpu_acpi_is_s0ix_supported())
+       if (amdgpu_acpi_is_s0ix_supported(adev))
                 amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0Entry)=
;

         /* post card */
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7Cf91d4568bfcc442e773808d89db36073%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637432741044140311%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DsxM%2BF4tq7x73lRdc%2FftMGE8yrN%2BoBgs3syxFoK0q8Cc%3D&amp;reserved=3D0

--_000_MN2PR12MB4488E073E832E8550023C9E8F7CA0MN2PR12MB4488namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Likun Gao &lt;likun.gao@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, December 11, 2020 4:01 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Gao, Likun &lt;Likun.Gao@amd.com&gt;; Feng, Kenneth &lt;Kenneth.=
Feng@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [V2] drm/amdgpu: add judgement for suspend/resume sequence<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
<br>
S0ix only makes sense on APUs since they are part of the platform, so<br>
only when the ASIC is APU should set amdgpu_acpi_is_s0ix_supported flag<br>
to deal with the related situation.<br>
<br>
Signed-off-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
Change-Id: Ic89df206734fa7e6ce3e5a784171f149a07edc80<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; | 4 ++--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c&nbsp;&nbsp; | 8 +++++---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---<br>
&nbsp;3 files changed, 10 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 83ac06a3ec05..eed5410947e9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -1314,11 +1314,11 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amd=
gpu_device *adev);<br>
&nbsp;<br>
&nbsp;void amdgpu_acpi_get_backlight_caps(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_backlight_caps *caps);<br>
-bool amdgpu_acpi_is_s0ix_supported(void);<br>
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);<br>
&nbsp;#else<br>
&nbsp;static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { retu=
rn 0; }<br>
&nbsp;static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }<b=
r>
-static inline bool amdgpu_acpi_is_s0ix_supported(void) { return false; }<b=
r>
+static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *ade=
v) { return false; }<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_acpi.c<br>
index fd66ac00c7f5..8155c54392c8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
@@ -901,10 +901,12 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)<br>
&nbsp; *<br>
&nbsp; * returns true if supported, false if not.<br>
&nbsp; */<br>
-bool amdgpu_acpi_is_s0ix_supported()<br>
+bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &amp; ACPI_FA=
DT_LOW_POWER_S0)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &amp; ACPI_FA=
DT_LOW_POWER_S0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 52d6f1fbe890..66b790dfb151 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2651,7 +2651,7 @@ static int amdgpu_device_ip_suspend_phase1(struct amd=
gpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_acpi_is_s0ix_supported() =
|| amdgpu_in_reset(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_acpi_is_s0ix_supported(ad=
ev) || amdgpu_in_reset(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -3712,7 +3712,7 @@ int amdgpu_device_suspend(struct drm_device *dev, boo=
l fbcon)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fence_driver_suspen=
d(adev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_acpi_is_s0ix_supported() =
|| amdgpu_in_reset(adev))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_acpi_is_s0ix_supported(ad=
ev) || amdgpu_in_reset(adev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_suspend_phase2(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3E=
ntry);<br>
@@ -3747,7 +3747,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool=
 fbcon)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;switch_power_s=
tate =3D=3D DRM_SWITCH_POWER_OFF)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported())<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_acpi_is_s0ix_supported(ade=
v))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_gfx_state_change_set(adev, sGpuChangeState_D0E=
ntry);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* post card */<br>
-- <br>
2.25.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7Cf91d4568bfcc442e773808d89db36073%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432741044140311%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DsxM%2BF4tq7x73lRdc%2FftMGE8yrN%2BoBgs3syxFoK0q8Cc%3D=
&amp;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D04%7C01%7Calexander.deucher%40amd.com%7Cf91d4568bfcc442e773808d89=
db36073%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637432741044140311%7CU=
nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLC=
JXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DsxM%2BF4tq7x73lRdc%2FftMGE8yrN%2BoBgs3s=
yxFoK0q8Cc%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488E073E832E8550023C9E8F7CA0MN2PR12MB4488namp_--

--===============0177962015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0177962015==--
