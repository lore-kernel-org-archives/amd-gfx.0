Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1695DC54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 13:13:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B95D10FB05;
	Thu, 14 Mar 2024 13:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zSNNTZua";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 895AA10FB03
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 13:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQFw30rrjyON8Dxw4sCxdKqq/PP6LyZH20pVSy5dEgFzBIVUkUfXfzNBnk0dbpnvHnQCjj8/g971a6IhGDudZf687VfYLBe97ZEQ0BoKP80jBi5u0xogOfExQbvbJwXNMby3ZmGkh9zmsAQQTGdvA1f6CZy6vJK9KHw5jQCHvagA4Kk0cHA5hrNdkj+uiyMa+YpVC1AZbtFxsW7/qjjQzTO/h0iST5MfT1ixCoJm+WILMa5k6IIydSWLHYiwg1paN7dG6zoSl4cvysTADducC7M2m+xRhSNjjT78G4+xx/e0M/l5BcUG+j1LyWsp/4rJlXSyWWYDA5z441j6AlwNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1UZMJ2zDHTGQ8SMilIsV6kWI45xd9b/IHxt7nmuNV0=;
 b=RBF0PH8TyU4HoQinsr4gBsJVRGnMgXaAn9O8rjOsD6afbz9mOCd5pWpNJMmNxtE9tFwXtsynWJPJM7MpUi8ie79disNQtMlhsMhTq4Y/nydWtE0b0HIebKxjajHw85jdLQwHqK68Gt1rlz/EqfWAvv2LQk36SHQ1LCxjpuJu2GwU0LgpkhVs8LtSAU8fgN6yYyWfPR5SaIjTa98VhBt8VI2PFBlyTKScjp+yI/Zqwnm5xZXshkgIy0plAFBoqkmv4Vme6gXv04V0TGFxNwRNccRaHK22SU+U2Mbtq9DhmiQi3v3idXCzg5NvCxh5fullBdRESqSJO7+nwIAcOYNPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1UZMJ2zDHTGQ8SMilIsV6kWI45xd9b/IHxt7nmuNV0=;
 b=zSNNTZua/pQXQ9JJvNqpf74QOom57YoM3NoWIy3zc/A0TA3/JCnIEQSe54YeaRnOm7m81OmyWc0tU0LSjSePfc1BOMO54b51IVbIazM7TjnhBL3+zrLxRJ3ov+OsUP+3NZjZJmEWlyv/9pkHbjvd2yZH1OnCKN2lESJYnPbE1CY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 13:13:30 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:13:30 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
Thread-Topic: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
Thread-Index: AQHadft+955yxBUZ9E6NS4nvb3LuxLE3DSMggAApgtA=
Date: Thu, 14 Mar 2024 13:13:30 +0000
Message-ID: <BN9PR12MB525748175C02F315C091751FFC292@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240314103620.27165-1-Hawking.Zhang@amd.com>
 <BN9PR12MB525734BED22935D8D3D8E20EFC292@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525734BED22935D8D3D8E20EFC292@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: KevinYang.Wang@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7ef0e691-cdec-4804-bf4f-46d1c2dacaf4;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-14T10:44:12Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MN2PR12MB4223:EE_
x-ms-office365-filtering-correlation-id: bfabf62b-49d6-41a9-9b78-08dc44288b5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a+qa1OFl1td+wU6d5exKSF41nFdv3Ifyyqms+Gph6OoUEe1JLgbTd8EIsKt3PWtKyS84PhdeK0Y8jBT8hTTqqslPjiKk4ZdZaLbaaBegOSUe6M3+urSRayWHcldEuQKtqeUB94gMkX6LZx2T1rhKNaxmY6Voo38o5oAIMW9XOhfVrqdpWhLhCe7be2FKxZAC+eoRvtWVhL1ZNTwlKc7uK9HsNLgr4bgQ05piH29bZX1h4LZN1kKHiJ9Lq/k59FrdSnHGicuGhVjcA2/2ET18aWwgTuB0TnWx53FxGYH0k3rmo8LlSUgwaw+cO99H15gOwJdWomQPVRPOzlV8+mBQ6MezMPCGO/XPpywfsUNjabc/rSQ4KtlnU1JXS9V7n0gm7if1uOWoP3w5fDRkGcjGn9OzZjzlgj+T1nPMK97y+IKhYxwuZe0DwOpBwjf44ZAgHI+wR6jUPszBtDNcqoXxO+n7rh67pFugXTtrGcRfYT4Xo0s7cG4XHGzWtk9woiOS3UqV8Xxfyd8zwC7ZO4+ynA2UGLUCjXZKFzDznKYEYBZeePNE1Yr6uhZHJ++9k8L9k/a8m0ECpWwu5M6qGx3nzeIKyZd0Qmi00Wx2EAQrUr9PzasSCL5i61gHQiNtXroh4cGoi59EULJzrgLNU3z418Nl3VdNCaRpy8DktVtrXdIImTyxb6hvypmEnkiByHHXHlAlCCIPbVnJqUBuwVTlLsWl/REsJwLNDariL/LOa54=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009)(921011); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KFDigp0kZ2S2mhG9xoAT8qhmVf/TYEYwRtOS17rcAr7KSKOruVT9zurIMyT+?=
 =?us-ascii?Q?O1VAmDWY7TxbCTSHLPOxr5ypmx/bQJ8xl/S7WA1l8PtQQx2wXcR4wj+ZH4x0?=
 =?us-ascii?Q?QH7KqyTX837t6YGLx7p+g6vu5olgz5mxLSP3S3kd8i+7i8Y48XrjTuAduNVT?=
 =?us-ascii?Q?AGoXswQPD3nm9kzC9p7pw5lDq6/1HQYOUpQ4eV9SqjA3EimN1TeNV3DD0rGM?=
 =?us-ascii?Q?m2OYKj5TjfXEucRkBXMi0mnl/sfCGEm51PPZ7wc8wz1s1DtptYa/BzkGm6os?=
 =?us-ascii?Q?T4XiLM/OvSNiRjKugns4zUlPNPxChrcK+Yp4DhBIK7WjSpQWlifeAfV8jVHM?=
 =?us-ascii?Q?HpZGm74V8nWva8ZpuJ/fmzmMU4l3jNJSTe7Wrv6VX4sdksZ9eX9GMtQRbW45?=
 =?us-ascii?Q?BN2OLa3k7qyk6l6z+rdM7pjV+uBnVW6fWTrl6ybQ7m1CizizuSh+ObCaBQIN?=
 =?us-ascii?Q?kSBXmpxER/4AJPpB9e0sjJGhw5oigQcznWb1ixv5Hftx8Fh/DzppkQF6bUvG?=
 =?us-ascii?Q?EL6AVZjuZoSR/iTw3Jq6SKpRoZZxLsUccERgNZGaTLkNUmKhZilOsr66j05h?=
 =?us-ascii?Q?ZONMslhp+YA98k8L9xYweE+vEafsqM97EC0+sw5U39orabDJLvZKFgBIETs3?=
 =?us-ascii?Q?O4sfKQfdi7t/0ehTd1SSU1zr7z/Njsg2TiLI2ExXmkvItYtVC8PnVNdyesTH?=
 =?us-ascii?Q?NP4XUZm8XoJ7BqwtlPSme0qpY5DWYzn6kcpwlaNohrPBp16ySsZguiaMQj9y?=
 =?us-ascii?Q?cHkz01kIYLQltuBircgnHW4c+srdo7MM2HAvAm765JQpRAq2cqSLMb6bEiz4?=
 =?us-ascii?Q?Hh4QnUgbCrkWa52HlBM/2Pfl01ElRq9Vc9hdcjYyD+5C88qWCwyPle+jBOI2?=
 =?us-ascii?Q?H00HhuYhu4AxrdCxD9AdIWPosTWyRbehkSyC81xoUJgdb/Vpu7zexObLlDU4?=
 =?us-ascii?Q?fxlO7PZk7ZLPUmKb1o9PXTKdO1FxXGIChhrYa/pdGQ0KaviRCQdQkqq+mJOP?=
 =?us-ascii?Q?5maYQpoiWzsf/awqsK9OfrCvTMReptqLNpU5Yqvm3JQOOYLVtMRzI1BMMyBE?=
 =?us-ascii?Q?/L3UZZ7ZLT5LEwPiDYyPGHbWjbfV6KlQRP5kIIV4MrvF07UJsPE5tdziawuU?=
 =?us-ascii?Q?UvvCvXugSa6QzWc10Dx1LGw4DNztB/3NLCnidWwdiW2EFURQDBUULyPoaghu?=
 =?us-ascii?Q?WZUwmG+q9U8J4VS20WxOIe/e97xkbujh+pLUxyYaGDgLVpvy/pMGAT7J/3Wt?=
 =?us-ascii?Q?HJnUYq2MV8dv8t+8a11q+Se8Prls1m7h2FkL5BztdzvSXYDj0S2Mwii1z2jr?=
 =?us-ascii?Q?OekRybDtUDvyArdjvO0/vaHgbdH3XEWQaRUDvVEIdG/TUUFX+NuReT32H9WM?=
 =?us-ascii?Q?cRjjpGCNPiYpF8LALTZEnfKdVswZlTI6v4dCtjApqOJgJKrD7r2twhwTL5Lm?=
 =?us-ascii?Q?ilFE0E0bFYC18mpL7xo78qE/nXITnXaBTrHM9KMRtFxZvhVz+W1/QDSx4p9B?=
 =?us-ascii?Q?N77EyjQmKz8ahLAtAFNk3seRRm7/mX1JQXwnstWVP0DCmSV33h7ul8XGL1T1?=
 =?us-ascii?Q?hTyPK4onJwgVSQ9tOr3bLFOzgkKFAba0F26X18Nv?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525748175C02F315C091751FFC292BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabf62b-49d6-41a9-9b78-08dc44288b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 13:13:30.7398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWSfyP8dPZTKpumB6h3A2GA/LiDSAJABIf/gbnZE6ZKy5pdfSnTn9oT0LlXZHcMe1ElmTBm37egxtuJXqbIvCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

--_000_BN9PR12MB525748175C02F315C091751FFC292BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Never mind. There is helper function to check if display hardware is availa=
ble. I will move to the helper in v2. Thanks @Wang, Yang(Kevin)<mailto:Kevi=
nYang.Wang@amd.com> for his reminder.

Regards,
Hawking

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Thursday, March 14, 2024 18:45
To: amd-gfx@lists.freedesktop.org; Pillai, Aurabindo <Aurabindo.Pillai@amd.=
com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass display ta if it is harvested


[AMD Official Use Only - General]

[AMD Official Use Only - General]

Copy @Deucher, Alexander<mailto:Alexander.Deucher@amd.com> for the awarenes=
s.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Sent: Thursday, March 14, 2024 18:36
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com<mailto:Aurabindo.Pillai@amd.com>>=
; Feng, Kenneth <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: [PATCH] drm/amdgpu: Bypass display ta if it is harvested

Display TA doesn't need to be loaded/invoked if it is harvested.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@am=
d.com>>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++
1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 867397fe2e9d..bb4988c45ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context *p=
sp)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

+       /* bypass hdcp initialization if dmu is harvested */
+       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+               return 0;
+
         if (!psp->hdcp_context.context.bin_desc.size_bytes ||
             !psp->hdcp_context.context.bin_desc.start_addr) {
                 dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is =
not available\n"); @@ -1862,6 +1866,9 @@ int psp_hdcp_invoke(struct psp_con=
text *psp, uint32_t ta_cmd_id)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

+       if (!psp->hdcp_context.context.initialized)
+               return 0;
+
         return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context); =
 }

@@ -1897,6 +1904,10 @@ static int psp_dtm_initialize(struct psp_context *ps=
p)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

+       /* bypass dtm initialization if dmu is harvested */
+       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+               return 0;
+
         if (!psp->dtm_context.context.bin_desc.size_bytes ||
             !psp->dtm_context.context.bin_desc.start_addr) {
                 dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is no=
t available\n"); @@ -1929,6 +1940,9 @@ int psp_dtm_invoke(struct psp_contex=
t *psp, uint32_t ta_cmd_id)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

+       if (!psp->dtm_context.context.initialized)
+               return 0;
+
         return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);  =
}

@@ -2063,6 +2077,10 @@ static int psp_securedisplay_initialize(struct psp_c=
ontext *psp)
         if (amdgpu_sriov_vf(psp->adev))
                 return 0;

+       /* bypass securedisplay initialization if dmu is harvested */
+       if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+                return 0;
+
         if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
             !psp->securedisplay_context.context.bin_desc.start_addr) {
                 dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta =
ucode is not available\n");
--
2.17.1


--_000_BN9PR12MB525748175C02F315C091751FFC292BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Never mind. There is helper function to check if dis=
play hardware is available. I will move to the helper in v2. Thanks
<a id=3D"OWAAMD74DBE4E02684F81976DCAE242A41156" href=3D"mailto:KevinYang.Wa=
ng@amd.com">
<span style=3D"font-family:&quot;Calibri&quot;,sans-serif;text-decoration:n=
one">@Wang, Yang(Kevin)</span></a> for his reminder.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Zhang, Hawking<br>
<b>Sent:</b> Thursday, March 14, 2024 18:45<br>
<b>To:</b> amd-gfx@lists.freedesktop.org; Pillai, Aurabindo &lt;Aurabindo.P=
illai@amd.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Bypass display ta if it is harveste=
d<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]</span><s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div style=3D"margin-top:5.0pt">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Copy <a href=3D"mailto:Alexander.Deucher@amd.com"><s=
pan style=3D"color:#2B579A;background:#E1DFDD">@Deucher, Alexander</span></=
a> for the awareness.<span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<br>
Hawking<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">-----Original Message-----<br>
From: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Z=
hang@amd.com</a>&gt;
<br>
Sent: Thursday, March 14, 2024 18:36<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a>; Pillai, Aurabindo &lt;<a href=3D"mailto:Aurabindo.Pillai@amd.c=
om">Aurabindo.Pillai@amd.com</a>&gt;; Feng, Kenneth &lt;<a href=3D"mailto:K=
enneth.Feng@amd.com">Kenneth.Feng@amd.com</a>&gt;<br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawking.Zha=
ng@amd.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Bypass display ta if it is harvested<span styl=
e=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Display TA doesn't need to be loaded/invoked if it i=
s harvested.<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,s=
ans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">Signed-off-by: Hawking Zhang &lt;<a href=3D"mailto:H=
awking.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;<span style=3D"font-size=
:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">---<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 +++++++=
+++++++++++<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sa=
ns-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">1 file changed, 18 insertions(+)<span style=3D"font-=
size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<span style=3D"font-size:10.0pt;f=
ont-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">index 867397fe2e9d..bb4988c45ca9 100644<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<span s=
tyle=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o=
:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -1830,6 +1830,10 @@ static int psp_hdcp_initializ=
e(struct psp_context *psp)<span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(psp-&gt;adev))<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass hdcp=
 initialization if dmu is harvested */<span style=3D"font-size:10.0pt;font-=
family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;ad=
ev-&gt;harvest_ip_mask &amp; AMD_HARVEST_IP_DMU_MASK)<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!psp-&gt;hdcp_context.context.bin_desc.size_bytes ||<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; !psp-&gt;hdcp_context.context.bin_desc.start_addr) {<s=
pan style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev,=
 &quot;HDCP: optional hdcp ta ucode is not available\n&quot;); @@ -1862,6 +=
1866,9 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<=
span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(psp-&gt;adev))<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;h=
dcp_context.context.initialized)<span style=3D"font-size:10.0pt;font-family=
:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn psp_ta_invoke(psp, ta_cmd_id, &amp;psp-&gt;hdcp_context.context);&nbsp;=
 }<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"=
><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -1897,6 +1904,10 @@ static int psp_dtm_initialize=
(struct psp_context *psp)<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(psp-&gt;adev))<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass dtm =
initialization if dmu is harvested */<span style=3D"font-size:10.0pt;font-f=
amily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;ad=
ev-&gt;harvest_ip_mask &amp; AMD_HARVEST_IP_DMU_MASK)<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!psp-&gt;dtm_context.context.bin_desc.size_bytes ||<span style=3D"font-siz=
e:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; !psp-&gt;dtm_context.context.bin_desc.start_addr) {<sp=
an style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev,=
 &quot;DTM: optional dtm ta ucode is not available\n&quot;); @@ -1929,6 +19=
40,9 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(psp-&gt;adev))<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;d=
tm_context.context.initialized)<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:10.0pt;=
font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn psp_ta_invoke(psp, ta_cmd_id, &amp;psp-&gt;dtm_context.context);&nbsp; =
}<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif">=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">@@ -2063,6 +2077,10 @@ static int psp_securedisplay_=
initialize(struct psp_context *psp)<span style=3D"font-size:10.0pt;font-fam=
ily:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(amdgpu_sriov_vf(psp-&gt;adev))<span style=3D"font-size:10.0pt;font-family:=
&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass secu=
redisplay initialization if dmu is harvested */<span style=3D"font-size:10.=
0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;ad=
ev-&gt;harvest_ip_mask &amp; AMD_HARVEST_IP_DMU_MASK)<span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<span style=3D"font-size:1=
0.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">+<span style=3D"font-size:10.0pt;font-family:&quot;A=
rial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!psp-&gt;securedisplay_context.context.bin_desc.size_bytes ||<span style=
=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; !psp-&gt;securedisplay_context.context.bin_desc.start_=
addr) {<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-s=
erif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev,=
 &quot;SECUREDISPLAY: securedisplay ta ucode is not available\n&quot;);<spa=
n style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">--<span style=3D"font-size:10.0pt;font-family:&quot;=
Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">2.17.1<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<span style=3D"font-size:10.0pt;font-family:&q=
uot;Arial&quot;,sans-serif"><o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB525748175C02F315C091751FFC292BN9PR12MB5257namp_--
