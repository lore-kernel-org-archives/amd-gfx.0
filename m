Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5465AC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BFD64F64
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 03:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BFD64F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D7CD6EE42;
	Fri, 12 Mar 2021 03:58:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78366EE42
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 03:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEyuZ5uWpXlN6TW6gmz3W25p5lvPCGMjpBXjuqa6rSDZQ9X3Ca/iVwsMBTEIHRmDb+NqdHQVD0yYN+M8IKBQJ6j95+DUtfzv1JhhsJmj/P6hw14GFiLotp2b3Q37wQyB1HA3Tyz44afRjucgPUiDAX5jbPw29suY+kL88xUI79iYCdCMHeWOIrSpHKwwQB0DF/V8oJKMmCQrN6K4H/zwFCl6bNrGJUxQ22i23LVBwISL+e/WsXiBRIOj6tQddO/vmmEdl27dfWAaeieT5+UHD6pVX48fPJqyV4hYn8EulrIp319Su/tP5xFirJx0lGtv1FWKe6x0CokERnEtlDaitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnVt3UnBO/mK/0xPPijvJUTQrIfhgoVa/Gv9f0u4LfQ=;
 b=VYS/HEh+fN4tPEpJWKdoBgzNDqnW4wGxDrtQNa9hmzU0nFj7X72AQf9cNJxIrUVM+E/zs+TAlbvyYvy+O+5lSpypY7BPXjgNbS3JnvImAKdEyp6UT3XrB7Xt1pG2eEhbzBw02u9Oa+/4su0P+++Wk5NB+96y5gmqIo+6FgB0+L0t8jcv0RuwzGEAPTyuVSOihoPML+8FIJIDgfpU9JHXCsc5Fb+8ab/uDxLsZrwBMxx9ffBMJ7GosKGIySgmcBR3RhA1bInsdF6/VJ4tmb0HVyY0YT276LebrdxCPf77ISO2zeTruZWXmCu9gGXEC1+bSTvut3DzuHleXto3/quGqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnVt3UnBO/mK/0xPPijvJUTQrIfhgoVa/Gv9f0u4LfQ=;
 b=J/JrnKB1iq1oHtZZ1Lh/Xaa7uEDgoqXi3ASkyeeKh4+XYa1/yUPbeNafwAoCk+M1FR+Qu0NsZwNzpu80AtewQV7tUb5KQqTLzEimqnXx97JOZsVnmQeCVCpBwqE+EHSgFOp1e9A/XR3ytwM1863Bkc83r8ylwdx8wliRsamLt/4=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 12 Mar
 2021 03:58:24 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%4]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 03:58:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: support query ecc cap for SIENNA_CICHLID
Thread-Topic: [PATCH 2/2] drm/amdgpu: support query ecc cap for SIENNA_CICHLID
Thread-Index: AQHXFvNRi5qWX7hrlkKZigKmEXL48Kp/uedh
Date: Fri, 12 Mar 2021 03:58:24 +0000
Message-ID: <MN2PR12MB448879B988827C2DC5A76EF4F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210312035316.2631-1-Hawking.Zhang@amd.com>,
 <20210312035316.2631-2-Hawking.Zhang@amd.com>
In-Reply-To: <20210312035316.2631-2-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-12T03:58:23.036Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37a71abe-7f60-44b1-3b7d-08d8e50b1587
x-ms-traffictypediagnostic: MN2PR12MB3759:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB37590542B57238562E5DA912F76F9@MN2PR12MB3759.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZ+0ypsk5DQcsc6JbOnzWnBzfgdyOu4AHDhJM6hKp164DN4+bxSog3vQbLGfzSnpEhjyxhv5+d0yOe/YQIhzRBjzIsvcU57uDtrYPLEiDLUo2E6tbZLs6vf9/KwlpSYWfxs+MXO9VsZL1cwhPkGv6EGOJFfbX/WX+p+CJGuh2cMdzLf7ubQogMH00KkpgYwOA6MNm2sdpR4H5ttRbNUq2BRV6xNksGH/bCYPCXRmtI1a2It/sD++cBIgDagxFt6dGvxcIAvCVBr6qA3zGWjr6Jpd1lfoSwBXWx09MFvsZdF8yHBmENHcuETU6Jqd4IzEOCg02Mq1VmkKFs080CAJJJPkMJCuxlm2XHsXpL5ijMKFSzqEjMzleQDzlQUvqukbiBK1h73G862ZNCczlORmwxnOOlSftusRe0J93KtjafD79u29HBwfcmLX2YSd/jfere0Mynqr5bZyVXd81kv1XjviTnVEEaTUCWa4++WLfNPnX2I7UNuAAjN5xVy9A96VZ6e+eP5oSoMHmHhcaUAhk6DSVRfno1xD46Tz4fHcH5lmLfYgOaH94zR/p8j+ECns
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(5660300002)(52536014)(53546011)(19627405001)(166002)(86362001)(9686003)(83380400001)(6506007)(71200400001)(55016002)(66946007)(33656002)(316002)(26005)(186003)(45080400002)(2906002)(110136005)(66476007)(8676002)(66556008)(7696005)(66446008)(76116006)(966005)(64756008)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aBAOXenAinlscHw2twn+AXO+h/2L3gq1lL4yezVNS3w0djLU7NdbLvX4BeHu?=
 =?us-ascii?Q?h59TeTbLIZr+z52rDgrJL9u7ykngoYHupxiYx3C8Ml/Ba8Hy2XYhNZg10MAu?=
 =?us-ascii?Q?htF1qur0tSvjFneGWqblx6XIs1nyUHfE8sjiaiam4zj6PtQKa1N4TFHGT8FV?=
 =?us-ascii?Q?8VoKCwbB/qNXek2o7oqgzzLREHhLdsXnUW4cqFESDNNl3u4QsRgUykAvxEWY?=
 =?us-ascii?Q?SW07QJJ2xbZvKZ2sYbOFsxwxP24Gxw1X2TFZAxlorTHREOEZSAYeCpYkwzuq?=
 =?us-ascii?Q?uD6Ddu74vTWiDG26kXI00JR5Nb65YKu0VZY7dliZxhDkzJdRZ9Vew6KpeRDI?=
 =?us-ascii?Q?NBTzh/K8ZIBFB9sRy6M2KwuvvXCAavmuo54Dv1UwiEgK3BPcJrtfOfeI86sM?=
 =?us-ascii?Q?n0MArCuNC181ny0wU2ML/41qnhh/8uKDfCm+KeZxObwzv6K4my97QXyYz7Qd?=
 =?us-ascii?Q?Zclnrld5kjp6UWiyLRZpcvQS/r198Sh7MTwOhdXpryxxSzcoXJ6qYsho0uW4?=
 =?us-ascii?Q?OQ+bFu/wXIKmUre2/V+c7D4H65qiAw5FFoYSTGOpgvxkKsOh++zxLus0W57U?=
 =?us-ascii?Q?A+E21BIZrcrhH3AWbF0zKvMrOcVNbyAvf1SuGU54zPXX5eGk8imYeNs0kHgv?=
 =?us-ascii?Q?sWrSiEcO+90HdOtl6ge26o7+m9GJPxQv2JV4lNsGbdQp/q4dQcLxs6SiJitI?=
 =?us-ascii?Q?86jismVpYujUxN1cUB4mXpP024teTqNJF6mhzrdHikHzyOTBfvHvF/DZZ4KV?=
 =?us-ascii?Q?ntpn197k1vyKMGimTJi/4MNciOGb4OFviHXezKd6kWupqsAHykhmlyaEK7ei?=
 =?us-ascii?Q?TPLXxGJBwetnseFqshhuULbj/MP3/CatbdOBJ4zQS5he+fvqloFeZ+tmtHU4?=
 =?us-ascii?Q?wqRw6LAKR6yuKW2Vejax3b9fs/QZOAOEh9lKm5Je1M7pKIMg1nxiPmQo2CCc?=
 =?us-ascii?Q?v+XCr+pcUsg9e+hw4M+eI+n7fsk4mt2PessdRTEvp+fSXMFqyrcrJ4YkawBx?=
 =?us-ascii?Q?3tFhLmoHDU5kbGLrCcL7fHhmcYUop5XhnrpXAj0J8rTefvXj9Dx2y8PBMr55?=
 =?us-ascii?Q?/rz6DKg6Adq56GFxA2D9tqNIqMXGZeOv2jzaqUHM8rUVNf01PrnULPhBDzCr?=
 =?us-ascii?Q?tmlDYbJiDL/wDrzr1sPNbYx7s+6VC4ou2/b3GR/Odswlz47mNtu7p9N/bVvu?=
 =?us-ascii?Q?7v5J8kBv+Dse6HCk818Vgt6D55VrdasKmOJ4+1gCpBJGjFVOVp0GQSeMYu6F?=
 =?us-ascii?Q?gFiPlRDDPAGYFchmlJRUzig2ynf8mEmmD4xSTxwWRTIGegJoFtUrggzcr4M/?=
 =?us-ascii?Q?doul2V7DaVE8vpAq4ygzICp2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a71abe-7f60-44b1-3b7d-08d8e50b1587
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 03:58:24.0713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4WyTjKDqgMFUKJx1VrUQM4/Zpv9cNjTcQsz0Jx6cYpzrRyoGY7viMyPgYjnrbdrITjRGeey76BanYfMb0LdSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Content-Type: multipart/mixed; boundary="===============0254062749=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0254062749==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB448879B988827C2DC5A76EF4F76F9MN2PR12MB4488namp_"

--_000_MN2PR12MB448879B988827C2DC5A76EF4F76F9MN2PR12MB4488namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Hawking =
Zhang <Hawking.Zhang@amd.com>
Sent: Thursday, March 11, 2021 10:53 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: support query ecc cap for SIENNA_CICHLID

driver needs to query umc_info_v3_3 for ecc capability
in sienna_cichlid

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 28 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 +--
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c
index fd1d2cface2e..0612300284fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -117,6 +117,8 @@ union igp_info {

 union umc_info {
         struct atom_umc_info_v3_1 v31;
+       struct atom_umc_info_v3_2 v32;
+       struct atom_umc_info_v3_3 v33;
 };

 union vram_info {
@@ -343,13 +345,29 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amd=
gpu_device *adev)

         if (amdgpu_atom_parse_data_header(mode_info->atom_context,
                                 index, &size, &frev, &crev, &data_offset))=
 {
-               /* support umc_info 3.1+ */
-               if ((frev =3D=3D 3 && crev >=3D 1) || (frev > 3)) {
+               if (frev =3D=3D 3) {
                         umc_info =3D (union umc_info *)
                                 (mode_info->atom_context->bios + data_offs=
et);
-                       ecc_default_enabled =3D
-                               (le32_to_cpu(umc_info->v31.umc_config) &
-                                UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true=
 : false;
+                       switch (crev) {
+                       case 1:
+                               ecc_default_enabled =3D
+                                       (le32_to_cpu(umc_info->v31.umc_conf=
ig) &
+                                        UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE=
) ? true : false;
+                               break;
+                       case 2:
+                               ecc_default_enabled =3D
+                                       (le32_to_cpu(umc_info->v32.umc_conf=
ig) &
+                                        UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE=
) ? true : false;
+                               break;
+                       case 3:
+                               ecc_default_enabled =3D
+                                       (le32_to_cpu(umc_info->v33.umc_conf=
ig1) &
+                                        UMC_CONFIG1__ENABLE_ECC_CAPABLE) ?=
 true : false;
+                               break;
+                       default:
+                               /* unsupported crev */
+                               return false;
+                       }
                 }
         }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 93699ea4860c..ce025aa4e332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1915,11 +1915,11 @@ static void amdgpu_ras_check_supported(struct amdgp=
u_device *adev,
                 return;

         if (amdgpu_atomfirmware_mem_ecc_supported(adev)) {
-               dev_info(adev->dev, "HBM ECC is active.\n");
+               dev_info(adev->dev, "MEM ECC is active.\n");
                 *hw_supported |=3D (1 << AMDGPU_RAS_BLOCK__UMC |
                                 1 << AMDGPU_RAS_BLOCK__DF);
         } else
-               dev_info(adev->dev, "HBM ECC is not presented.\n");
+               dev_info(adev->dev, "MEM ECC is not presented.\n");

         if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
                 dev_info(adev->dev, "SRAM ECC is active.\n");
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Calexande=
r.deucher%40amd.com%7C251d32240fad47e0dddc08d8e50a72e1%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637511180332375135%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3Df%2BVEfPyBMYdZ2Ig21CUJ2BK2X2kSk1IrXDTyc210Rw4%3D&amp;reserved=3D0

--_000_MN2PR12MB448879B988827C2DC5A76EF4F76F9MN2PR12MB4488namp_
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
Series is:</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Hawking Zhang &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Sent:</b> Thursday, March 11, 2021 10:53 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: support query ecc cap for SIENNA_CI=
CHLID</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">driver needs to query umc_info_v3_3 for ecc capabi=
lity<br>
in sienna_cichlid<br>
<br>
Signed-off-by: Hawking Zhang &lt;Hawking.Zhang@amd.com&gt;<br>
Reviewed-by: Likun Gao &lt;Likun.Gao@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c&nbsp; | 28 +++++++++++++=
++----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 4 +--<br>
&nbsp;2 files changed, 25 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
index fd1d2cface2e..0612300284fb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c<br>
@@ -117,6 +117,8 @@ union igp_info {<br>
&nbsp;<br>
&nbsp;union umc_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_umc_info_v3_1 =
v31;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_umc_info_v3_2 v32;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_umc_info_v3_3 v33;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;union vram_info {<br>
@@ -343,13 +345,29 @@ bool amdgpu_atomfirmware_mem_ecc_supported(struct amd=
gpu_device *adev)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_atom_parse_data=
_header(mode_info-&gt;atom_context,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; index, &amp;size, &amp;frev, &am=
p;crev, &amp;data_offset)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* support umc_info 3.1+ */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if ((frev =3D=3D 3 &amp;&amp; crev &gt;=3D 1) || (frev &gt; 3)) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (frev =3D=3D 3) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_i=
nfo =3D (union umc_info *)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (mode_info-&gt;atom_context-&gt;=
bios + data_offset);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_default_enab=
led =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (le32_to_cpu(umc_info-&gt;v31.umc_config) &=
amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ?=
 true : false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (crev) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_default_enabled =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (le32_to_cpu(umc_info-&gt;v31.umc_config) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_default_enabled =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (le32_to_cpu(umc_info-&gt;v32.umc_config) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; UMC_CONFIG__DEFAULT_MEM_ECC_ENABLE) ? true : false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 3:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecc_default_enabled =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (le32_to_cpu(umc_info-&gt;v33.umc_config1) &amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; UMC_CONFIG1__ENABLE_ECC_CAPABLE) ? true : false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unsupported crev */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index 93699ea4860c..ce025aa4e332 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -1915,11 +1915,11 @@ static void amdgpu_ras_check_supported(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_atomfirmware_me=
m_ecc_supported(adev)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;HBM ECC is active.\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;MEM ECC is active.\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *hw_supported |=3D (1 &lt;&lt; AMDGPU_RAS_BLOCK__UMC =
|<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; AMDGPU_RAS_BLOCK__DF)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;HBM ECC is not presented.\n&quot;);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev, &quot;MEM ECC is not presented.\n&quot;);=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_atomfirmware_sr=
am_ecc_supported(adev)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;SRAM ECC is active.\n&qu=
ot;);<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Calexander.deucher%40amd.com%7C251d32240fad47e0dddc08d8e50a72e1%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511180332375135%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3Df%2BVEfPyBMYdZ2Ig21CUJ2BK2X2kSk1IrXDTyc210Rw4%3D&amp=
;amp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dht=
tps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;da=
ta=3D04%7C01%7Calexander.deucher%40amd.com%7C251d32240fad47e0dddc08d8e50a72=
e1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637511180332375135%7CUnknow=
n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI=
6Mn0%3D%7C1000&amp;amp;sdata=3Df%2BVEfPyBMYdZ2Ig21CUJ2BK2X2kSk1IrXDTyc210Rw=
4%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB448879B988827C2DC5A76EF4F76F9MN2PR12MB4488namp_--

--===============0254062749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0254062749==--
