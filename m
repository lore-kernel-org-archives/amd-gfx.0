Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902E4C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 10:44:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B2810E598;
	Thu, 14 Mar 2024 10:44:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GTMCvRkZ";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216D810E598
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 10:44:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTTOJqcz5V4ACHgou2TASndUVgDwjRtmPGtRkdW3HQ4WfNM88X0V3PAk5ogEfDd+yZKNcLmoXGEk3WavlgrCjTf08Vc3KPwGVIU9uYQ5Y/GKHcaMPG5G05Xc98iQ3wx04WHRZjRN5mr89g6pU/kFvhuFNC7DPMKGHfd7kzK1amDgOefLuX671M56hLn4LWNceQJlfkMc3sOtYi7RS6wY7mcaPr3TVqW36OORlhPe8SZFfXzcoMgQb0FEioqpgs4YJFKbBsCE6qy1gjtHxEtEg+EhABM9I+0Iz8w4V0sfAoG5kdP3hkdloP5O1Z0fNSst80tIecJZmtfwOLtYB1Z/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/nRf3EX1MtCMz2xJ9mm1FqhRAzZyYYgbQHcC3Zp4m8=;
 b=OuwwoocCUn31eSIpnAev1G+ubpwDXaTz0WZGZXZ5bVuLqCyjLpxGCxW3SgfMCDcC3V3OZyiiSkTJhwCddffTdcxBz/RVqkyrL73GspY+LMv58Duz3AvrWoj3x7uKcg1nWZDF8t1M8oNz5HKF5MiI4RpYVgx4soXo4LXn/qRg3/9ShKwQ6IADRjdAdPIxQtPKIjGqLRBhTjPjzZbp38bCzJ3jlxIuO667snFGaJcV7bcuCV9NOSdtYRLzuYUW1z2p8d5jDHcpx5HzQJzQHORPHqffftYsooxPGlzvwVlIuWw470ZU9yaSDpajkgbY4kTo0dwH4Dn9bCj4IbQ8XRutyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/nRf3EX1MtCMz2xJ9mm1FqhRAzZyYYgbQHcC3Zp4m8=;
 b=GTMCvRkZlZoDfut79M4LN2bTyDRP5QiuXGinBARSm9mrr8+7vpkJCbu8oaAwt0TWaetUIQ2JXqzGxRCmToBMGGQLp9ccHI3IsvdJN6ALoalpoiK8jqxnt6Prrmq/eqEmd9ppjhmQEBXfMsfXzqBGfMMUOqaB6hkUU1TPc6t1TB8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 10:44:40 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 10:44:40 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Pillai, 
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
Thread-Topic: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
Thread-Index: AQHadft+955yxBUZ9E6NS4nvb3LuxLE3DSMg
Date: Thu, 14 Mar 2024 10:44:40 +0000
Message-ID: <BN9PR12MB525734BED22935D8D3D8E20EFC292@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240314103620.27165-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240314103620.27165-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
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
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|PH7PR12MB7870:EE_
x-ms-office365-filtering-correlation-id: 40de0f1c-11a7-4f7f-767d-08dc4413c08c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nT3hVZh8NSid6h3WOJ11YNxoT3nG0rsswKhnjhThIVJwFPaYOZxmwV/20I+WshcFMwi8chlmDmHi4cC4QXw38504NAbwBqQ0EYV/H++SUAD+I/ZY93e7kQoV6gbLnF9s8lNmAKbesJSBjU1V0/w7ab31YGNHSQQqJuBxP5QaTs5tQCiTBokEjyl20Hd4Lsf93iQw7vm1iwsacAtCCIuuxN7qjdlPDxDn60vxSRNNSgs0dp7GFNXtLWvHfgVDAX4Lle5vIuIngiducMMvHqde0JpPabLw1jaUaIc+9Hsn/357yq0XzraaK+qcR61HttyIgE4UpHJ7cr/rpYQFJdCBVUAKYMqUltXQK2FeIu3n83+u25KRRCx7XD7Q5cBSEbsVQU2f4sS+3wJNi5bVnm52fRM3+7Oep+z/iu9djrrHAgf4soFakObBWFu+krpdrZHb5sPfiXpKq6aSWJBa3kG6TLov3Taq/d7JnrZ8Gu97LpOOyrAsuysuNohpCkBNvZhpcTx4UsdWoAS+yiB0IEMpG4MZvLOL8upr7NGP78GqqLWj8rb88Nw5rW7uEp1epMqdebZjZvKMJCl8ysYiB/PW98osbQ2Ex26+TO8LmAgSq56roZkayUHcqKjuQte2jzRHh6zhaZ6D4z4FRNNSTTJWNQxxHk0owQzomTX+jA6nhzUF/d+sposT6KrMaG6YGSIW9xDUnH9zWvAyawZ2Bt3uhg5Dapk/8NuXxOgW1SKfxiU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LZ+UZJ0iDpkCdwuNfdywB9hOL85qUpH7tZGrAgN8d8ld2vHZch3PDVWZkkhh?=
 =?us-ascii?Q?/pbZSFofWY4we/BuSqLQDXfusI1p+n6SXveKzHGVrFLRtmAtg6DlwVnKc8D/?=
 =?us-ascii?Q?kzBRV/Df0rkbKONr6j5ct8Ph0HErDxAuGo3l6by54h2lR+wYVYV9xhcdHi39?=
 =?us-ascii?Q?kCA8UHZzYvWGOFyqENl0mw7wy8fWeZSSysu7oLJJfKhySYT8qlswa3QRcCkv?=
 =?us-ascii?Q?5B8MJaVWwWy3Rl5aIvo6XJ5c/Wyn1Hfk1bLYbaaK2KE5fpKugNkISVKBnS1a?=
 =?us-ascii?Q?0LIEHADbio+53LEoEajIOu8NJ85ChX+Fg/PBK/8ANSA9AxbQ5tAGgnHG3Zgx?=
 =?us-ascii?Q?WS25/vRD3OoadIVNVsRDBU+M2quaeo1mZfw5r3puIrfGV0b93R8OQAdXZmTU?=
 =?us-ascii?Q?txqBv/gc0boKEmZ4qhi7C5vPCSssjEiGXs8Z6J7b8kAo3K1dpe925vW7ZcCv?=
 =?us-ascii?Q?kMGLqb+4wylsxmJmZNyxTeMJvUI5QSyJjm5hxZkxzuD4by0WzOZ/s3kzSKjG?=
 =?us-ascii?Q?mk9hYjOM4D42c2D/mBAO6sDRvVxPN1x1pT4QVxYPjZpj9y96OrnP8q6a78yW?=
 =?us-ascii?Q?hGJnmByqL1ZBy8SnYs+TLgQRQMhrqUbgmRWqk5cGCaJN80CgMBs8I3KaiwFf?=
 =?us-ascii?Q?zqHyRJVBEtc6zHESaaaTBJSYkMCVca7LbieHhDpbQUUjgz8CIsF3/SJ+7wnx?=
 =?us-ascii?Q?O7hc5SyeeyISriEjfOZj55cLghQ2l93LV1xSpyX056aArKT9el3FmkpYlMoz?=
 =?us-ascii?Q?q048EcPxtzFjWIwqgXMg+1zdtd3nkgaTjtaTfFBotk7hRHiWkUZfm7X9eDRT?=
 =?us-ascii?Q?4U4bYsIayxQxv/cEJq+sVs3EXOoawtCpwmRdSuK9EISRGJ7D/bKSungWhzQC?=
 =?us-ascii?Q?pgTDwQRKSu2b2hcCeQCaIkvxhNYYeUWIdhiG+/NsVrs4r0dL1kryPqddG+xi?=
 =?us-ascii?Q?pyiYnDwL1qgQS6YrrUJJRlkasrND2eV9c1DKX3H2PY6EwlLze4vPbFyvj0zq?=
 =?us-ascii?Q?bRKT2EFlICFJu+ICR6dN4x2GWYLQQr0fQe/bj9vKXnArIrl1pULrb/MYTAi+?=
 =?us-ascii?Q?GHcGLIEKzswjlI4+bC7lqPTCEEaSL23G80EjIvGFD2BqY37ACJcxNqPwH7ax?=
 =?us-ascii?Q?0zDuKGBeMVe/ZNVxwNP3qFTCYGBsFOiasSddP0GaR/PIv55r3T5iKB2qIki7?=
 =?us-ascii?Q?bBCOPeaF9XGutKQuUhxkoIISFOIyVNFit0lhKCBMq5ptPPWDgOi27D7622xW?=
 =?us-ascii?Q?lVamjboUjDSug8v56LeonQch6TAWbqt/YzfFhJAol75Sn+d8GStXG8QOg8AG?=
 =?us-ascii?Q?GnRcLg38QBstREZBHwDQI/Po/VKN5DpsyPll2tyBu5NScbE7uEK18RhL6QH1?=
 =?us-ascii?Q?CKexwjW/1wyOr8lpg7YqT58RFIHhGq7M/aL+KjanaykTBmU9l0H9XvGFblo4?=
 =?us-ascii?Q?A1XkwdzYwT++UrP+4wF1n49aBmrsJBbj/DvEUb0WJ2k9PSiKDayxxO+o0ylt?=
 =?us-ascii?Q?RXgF0cM6mEoWt6R3noy2yAf04D2WHqiVXTxJ34UoMosipx9jfR0mhUuleF7w?=
 =?us-ascii?Q?FWwfJwhDRqWN9CjgfuY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB525734BED22935D8D3D8E20EFC292BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40de0f1c-11a7-4f7f-767d-08dc4413c08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:44:40.4775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZ3XCbfCbaN3Za0l91/NWw/h1E6wB4QCgtiuDA7/y+AzfFAHfAJt0+VERSuWKaX7iNOXCKXF2kOgeOw/bW65/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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

--_000_BN9PR12MB525734BED22935D8D3D8E20EFC292BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Copy @Deucher, Alexander<mailto:Alexander.Deucher@amd.com> for the awarenes=
s.

Regards,
Hawking

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, March 14, 2024 18:36
To: amd-gfx@lists.freedesktop.org; Pillai, Aurabindo <Aurabindo.Pillai@amd.=
com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
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
                dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is n=
ot available\n"); @@ -1862,6 +1866,9 @@ int psp_hdcp_invoke(struct psp_cont=
ext *psp, uint32_t ta_cmd_id)
        if (amdgpu_sriov_vf(psp->adev))
                return 0;

+       if (!psp->hdcp_context.context.initialized)
+               return 0;
+
        return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);  =
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
                dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not=
 available\n"); @@ -1929,6 +1940,9 @@ int psp_dtm_invoke(struct psp_context=
 *psp, uint32_t ta_cmd_id)
        if (amdgpu_sriov_vf(psp->adev))
                return 0;

+       if (!psp->dtm_context.context.initialized)
+               return 0;
+
        return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);  }

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
                dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta u=
code is not available\n");
--
2.17.1


--_000_BN9PR12MB525734BED22935D8D3D8E20EFC292BN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Copy=
 <a href=3D"mailto:Alexander.Deucher@amd.com"><font color=3D"#2B579A"><span=
 style=3D"background-color:#E1DFDD;">@Deucher, Alexander</span></font></a> =
for the awareness.</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Rega=
rds,<br>

Hawking</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">----=
-Original Message-----<br>

From: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt; <br>

Sent: Thursday, March 14, 2024 18:36<br>

To: amd-gfx@lists.freedesktop.org; Pillai, Aurabindo &lt;Aurabindo.Pillai@a=
md.com&gt;; Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;<br>

Cc: Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>

Subject: [PATCH] drm/amdgpu: Bypass display ta if it is harvested</span></f=
ont></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Disp=
lay TA doesn't need to be loaded/invoked if it is harvested.</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Sign=
ed-off-by: Hawking Zhang &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawki=
ng.Zhang@amd.com</a>&gt;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">---<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> dri=
vers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++</span></font><=
/div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;"> 1 f=
ile changed, 18 insertions(+)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdg=
pu/amdgpu_psp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">inde=
x 867397fe2e9d..bb4988c45ca9 100644</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--- =
a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+++ =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context *psp)<=
/span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;ad=
ev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass hdcp initialization if dmu is h=
arvested */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;harvest_ip_mask &amp=
; AMD_HARVEST_IP_DMU_MASK)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.cont=
ext.bin_desc.size_bytes ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&=
gt;hdcp_context.context.bin_desc.start_addr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev, &quot;HDCP: optional hdcp =
ta ucode is not available\n&quot;); @@ -1862,6 +1866,9 @@ int psp_hdcp_invo=
ke(struct psp_context *psp, uint32_t ta_cmd_id)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;ad=
ev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;hdcp_context.context.initial=
ized)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_invoke(psp, ta_c=
md_id, &amp;psp-&gt;hdcp_context.context);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
1897,6 +1904,10 @@ static int psp_dtm_initialize(struct psp_context *psp)</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;ad=
ev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass dtm initialization if dmu is ha=
rvested */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;harvest_ip_mask &amp=
; AMD_HARVEST_IP_DMU_MASK)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.conte=
xt.bin_desc.size_bytes ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&=
gt;dtm_context.context.bin_desc.start_addr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev, &quot;DTM: optional dtm ta=
 ucode is not available\n&quot;); @@ -1929,6 +1940,9 @@ int psp_dtm_invoke(=
struct psp_context *psp, uint32_t ta_cmd_id)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;ad=
ev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;dtm_context.context.initiali=
zed)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_invoke(psp, ta_c=
md_id, &amp;psp-&gt;dtm_context.context);&nbsp; }</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">@@ -=
2063,6 +2077,10 @@ static int psp_securedisplay_initialize(struct psp_conte=
xt *psp)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;ad=
ev))</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* bypass securedisplay initialization if=
 dmu is harvested */</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;harvest_ip_mask &amp=
; AMD_HARVEST_IP_DMU_MASK)</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return 0;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">+</s=
pan></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;securedisplay_con=
text.context.bin_desc.size_bytes ||</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&=
gt;securedisplay_context.context.bin_desc.start_addr) {</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev, &quot;SECUREDISPLAY: secur=
edisplay ta ucode is not available\n&quot;);</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">--</=
span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">2.17=
.1</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
</span></font>
</body>
</html>

--_000_BN9PR12MB525734BED22935D8D3D8E20EFC292BN9PR12MB5257namp_--
