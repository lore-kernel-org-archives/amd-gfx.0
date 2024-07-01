Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896AEC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A89F890FE;
	Mon,  1 Jul 2024 18:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OeCRGk+h";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FC810E4CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:05:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brpC2fFV4xO2ExrX9uPhJBPkjk2BVlLppbxtRRBPYecjD5TcMsf4XNzdhBvTpAbqsEDgi5Vm0ZwxlKoyFErDkhMAN8Kr9GqNb7VzMn6zVeqtmnFVy30YUbfcUp8EqfqttbwW41Rjlra8pe6kVBwQngi/lwU3D3fjuH3xGzWfzytj0vq5VWguoL/kwkQ7vSnQkg13qz38MTuwtsSIYzful2pX66RxT0K7ki13HIXvRrNi3cM7kXAmILR2um/XynjzF5fAN0Y4UBcXGxdKiHClG1tUG2mR9P05G6fCYhPldNR7Swp+jNGnK8VlQEPyxCh9692LBXdodT4AMVXDmhemWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+ps6r1YFbcKGJHEBhZdsR76ALE9y/tgUpz3H5eMxew=;
 b=e3UfXFXUuTwzWCjvkfm+PciDKHZ8FMVqMuazC77VnDCgLo5ighMmMnyzxgSDJcV57uDQJPz923IT40qBwPXyBHQOT7jD/chHM+yCdsR/kh1WmKJ7HRUcIPlee4YaiEcRTfbzAK2IWX0f+vWxNTfsR9JTzjKK1eIw9b4N8zBtaNUrAiGqL33tW0uhOy+Ona+vP434PbgAZRGnYxnBTxHCGJR8KUvlP8EuCbXwlr+hm+h+H58eMJCK+3TK6z87BhRKG3D69BCoub0ZRGBb2UEfF96Jnr677EnqNrE5NNxfNYOl+gviL18+TpSoT231VLqkxKf3KC3VOrlxmGCtpCIv4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i+ps6r1YFbcKGJHEBhZdsR76ALE9y/tgUpz3H5eMxew=;
 b=OeCRGk+hpCSzke1IQ1p3qyeyvdiL6ELg1ul3XOIvi2K9yzDtOKUT4UoLwL6SuPAfCamxg+8gHU+UbK9yCk0CjPCYtmloWVkFP0qNXm9p3i87hoFTji14uIt0Rp3/+b13h1x2IH0eZYjE7t8pithVwPUJYtedB2zV7hpe6bZv2dQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 18:01:55 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:01:55 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add firmware for SDMA IP v6.1.2
Thread-Topic: [PATCH 3/3] drm/amdgpu: add firmware for SDMA IP v6.1.2
Thread-Index: AQHayvw7u1hPbdIXqkuUEZW+FmuqWbHiK4H4
Date: Mon, 1 Jul 2024 18:01:55 +0000
Message-ID: <BL1PR12MB5144434EE9AE055B167762F0F7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630144521.2016551-1-Tim.Huang@amd.com>
 <20240630144521.2016551-3-Tim.Huang@amd.com>
In-Reply-To: <20240630144521.2016551-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:01:54.946Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6778:EE_
x-ms-office365-filtering-correlation-id: 4102ceb8-1b65-4225-682b-08dc99f7e4c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?k6jhtav4gLKYNN8cp61ltDZ3yTpqL1oXBbZshvGTnStyPEvuoLYJKd6//tzK?=
 =?us-ascii?Q?SVt4VdW8PVT/3SlvtJSz5oAzR17M9wxSEUj95YIKcuk25AppyX05tU4ihpXo?=
 =?us-ascii?Q?mSQy7RhPchkzFwzbarFA3d92dOQTBLHP69Ya7Ir96/kwEMsr9IWhxd8VmvnE?=
 =?us-ascii?Q?+ApAnEgxp+UPYsDAXqjQ/bkZmK5Yglr4H0RCIDhrqUH1+5kWO2kYVj1Tgugy?=
 =?us-ascii?Q?30ZnqEHNEdNU7jC3mQCBZKbGyk1OKa6FBI16WV+BLrcqAZVhYJTD7+B9Oy1+?=
 =?us-ascii?Q?jFpt5xfH0IgZ8yUj5r19vvVuv4G4Qs4AVDKEL8A/N66BDjGxvAL472B2z+cZ?=
 =?us-ascii?Q?sA+BYhqIUvFBb4xKexZDk3LReTspxziIj/s7F05w4ugMZ5i7jOlw+GD9y2tw?=
 =?us-ascii?Q?IVd4n9FUWEjYcyRzOrEMIX8VT/MbmffpGfKLZ0hjCRYvuW1JikT6U60Ew3zg?=
 =?us-ascii?Q?VOBuCrQJjQyIVOGtQSnPOfjZLvWK/ILNsVg3GDorBwgBpkKfe6tDzMbGV5sm?=
 =?us-ascii?Q?iOj44vPDZC2H7Mqo1qkHf1Yl0RGgVBTkwykl/bO974NWcAE6Gg2thR4JAozH?=
 =?us-ascii?Q?j8vGyFe5wx0OfqO31w63t0oaJwnxgOqQhZzjsXZ69M/opA9xA6AnD2/P/en1?=
 =?us-ascii?Q?trreVCiR0xpkUsr7qqVCMoKtJ/+niZv69J7YIOk0ntBa2FMTe1QjJPIFw0XN?=
 =?us-ascii?Q?ucwQMCECP4o8IukDNEC0vixYFX1YQjXnQk45BbV9SurNkcP/mRNLLanofRGX?=
 =?us-ascii?Q?qh+X6o9SegpnSnEhg1A5OtGHXVhMkgViez4ZjbstuoHWe1NiN2nW6YtFoD7m?=
 =?us-ascii?Q?gxT3Qs/TbL+nJXhbCaL2YxbtQgBxDlbwl4Ppx3FuH7SSEekUr1Kg73mvhfPE?=
 =?us-ascii?Q?4KYkyVZ4LAQhNUUA5qsav58Coc0+oLYizUKLagQg640sOxIFLINVzvtiIRoV?=
 =?us-ascii?Q?uJMxFkmnqBV7jqSJ964wEVfqGjAcRw92iT8pE6CnRH5ZS0Z/L1NWQndeLPCV?=
 =?us-ascii?Q?zFGXvcmEh9eXpq9u4TnWbLQuckhFZia0plGq2jYZKdvu+ni9dRYQVXyL/4Do?=
 =?us-ascii?Q?a8R4Q/j/wcMpfALSxDj7F24587sf3q2z6y4mz5Sm8esUlTEZrLfmKCoZp2GB?=
 =?us-ascii?Q?4DukrXFZKDsBBm1HeOlBaQm4RcQauuqoj2+rqk5sNxE8TmEWlXYd3Odyghlh?=
 =?us-ascii?Q?yP0Ybbf3HCNFoA72q3/VM1vY3hZ+tGl1HgLvPUxL6ywjduyY8IseMPEQWGEi?=
 =?us-ascii?Q?lezbMtY3HIEFbVIPqnUOjvyurttmhcQTA9t0SZaBCN2uEvWs+NuDt+SD0nGA?=
 =?us-ascii?Q?XuOF2kju4qxLvcQZ4AplhSv8mFgWv3ZJxtc7s9y69SWsfxTxh/kPLCXd66EJ?=
 =?us-ascii?Q?i0KzoqbwjGrTFfkAejrZos7nJjxD0QEPiS7ICRmnr2oyzA12yQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gRkH7PFqPwCdblDxiu7ZZJrdFBk+JYpNyX3UBOdbQPX0YrJ5SajeS4gpb4Bg?=
 =?us-ascii?Q?JcZB3HtYtag9CY1lDyrSu+Lki8YzxnX9STtvLP/boA1LrQFX6hR0FT04zexT?=
 =?us-ascii?Q?h9AXFHyh6S7Xjs0f09+ZG1m0tAE/GFwHIqMQtuNk54iqkZ712SYJj9bX6sbW?=
 =?us-ascii?Q?7ChVEPQV8IPRGEet7nn0LDmBEIQzRJfMEv4G4htV+PO/wfjfH0Olz6NeUmf8?=
 =?us-ascii?Q?Si9MB2nCblF1Zx4mhM/5+IBM24Fx8MNWawyE8uQs4eHELQ0/tGDJWtyqncIK?=
 =?us-ascii?Q?vCj9reuc1ls+lcEgYpMDj2C+tTNzCxHZaNOV6R4GTWsnVH1B/flSDWjNN4Fq?=
 =?us-ascii?Q?0U5a+3utUtAS/glQhI+eUxtHFYbCPeJLdnoWXRIiq77C8onyfjecbsVz7Up4?=
 =?us-ascii?Q?t2OHjQi+iCLG7mZDLtQNhuTvpkACtgfqtl/RMOXqdPenXxdvjlOnFpQczzdI?=
 =?us-ascii?Q?x2efC44KIfmzpw9zQfQP0j8cBoEDr8nHXfiSXrEFLZTU7XFIyUaL/tTSQsqK?=
 =?us-ascii?Q?P9hZZg1342sjqJOuZxJAbDY2ekbwtV/CK0IIzskiVNDK9oO69W6jfNyhwsFQ?=
 =?us-ascii?Q?iEwjn1jdtCf8oYDYckxPvUspAJPlQse9gOt4M7Dq6/S9kyv03zzkObHy44Nj?=
 =?us-ascii?Q?Boy7BJ7WSDzWTWI4qrgiP90F2wuSTUnUEw6uYLiS/hYdy9tj8YbRVPhqQ9O2?=
 =?us-ascii?Q?tOs0jcyfwzDfQwD3hA6nuLfzcvXLSL/h+daFI4xquJwcEYKWdr0uaqwZuxgw?=
 =?us-ascii?Q?hljxO+0fNYAcfKRLO9dFkKF6t2oiga8hlMd2fU9GfwY6z/y4EmfbgKN41bAA?=
 =?us-ascii?Q?AF5xwTXVdiUSP0mj45n5vn3ztZqqv2e1f6TKeoXridi5kvnsDyrqsSxglPfp?=
 =?us-ascii?Q?PUKmEhd3Q8eZHALRsyeALek/QR8D6+DsLckWaFvTgkTswxrfcxdiIOw2Bk7s?=
 =?us-ascii?Q?V3wI2inBtY7LZUQf8Z7PfrZlfi7E3kgL4w/Syarcx19U9QplTVgedjYi1yen?=
 =?us-ascii?Q?5a49pIfy1v9FXjOpwupdjsk1DBZ5b3HiwsgIzkWzI3gtW2R4XOfKXfRGMgAf?=
 =?us-ascii?Q?1H1Xklltdd8M9zW1ibGqtcwCJNUXECc/TRHnORsHjVglZQBU92uB3W64o4cM?=
 =?us-ascii?Q?PmliS9WcuP19smMm3VYAJogi/86guNdC9/798Yyj8mxMlVuRP71OBhDSJFVM?=
 =?us-ascii?Q?MTNni5ZEETu8FJzAi7rlrIXkOeZL0dMh5JATlKAkQAYTyu7DjXPuoxD1EsWO?=
 =?us-ascii?Q?z2HiOo3pwb7herUU6ndyYI3vM8XA0pN4tCJR9gnqfQxMCzymz3nNxdOLpFwk?=
 =?us-ascii?Q?AyPpwIMo9LLpEalacy6mCIEq9rbG3mGPVNHlZ9NnoWcvCJq9rAD+amnHdCXl?=
 =?us-ascii?Q?543azoyFiJzzVZF7TSkqrBJnA0NpCejZuvTR88r7VjbG84SzYXVoc5Jp9VLz?=
 =?us-ascii?Q?1V+XC+OYDdV001e9VhNdK9JpI+ehxBNqVwbxenFrlWpm2AdbCyg4LODdStAc?=
 =?us-ascii?Q?q3J9SBjXz9+3irJQgYhcKhZAcWraTLyukLjyZouxR7ibtupbksjzpdGQxFeL?=
 =?us-ascii?Q?mHXD+XPVscW9fIw74aE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144434EE9AE055B167762F0F7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4102ceb8-1b65-4225-682b-08dc99f7e4c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:01:55.3577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xHDvbCBdHg13PVointJ5jLuUBRx5KN2jzBEuUFOkyg3U+XJJARTgwFL+OG/9exGc178JHYJk+IAyKTfcLrby4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
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

--_000_BL1PR12MB5144434EE9AE055B167762F0F7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 10:45 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 3/3] drm/amdgpu: add firmware for SDMA IP v6.1.2

This patch is to add firmware for SDMA 6.1.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c
index c833b6b8373b..dab4c2db8c9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -50,6 +50,7 @@ MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_3.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_1_1.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_1_2.bin");

 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
--
2.43.0


--_000_BL1PR12MB5144434EE9AE055B167762F0F7D32BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 30, 2024 10:45 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhan=
g, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: add firmware for SDMA IP v6.1.2</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add firmware for SDMA 6.1.2.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v6_0.c<br>
index c833b6b8373b..dab4c2db8c9d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c<br>
@@ -50,6 +50,7 @@ MODULE_FIRMWARE(&quot;amdgpu/sdma_6_0_2.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/sdma_6_0_3.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/sdma_6_1_0.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/sdma_6_1_1.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/sdma_6_1_2.bin&quot;);<br>
&nbsp;<br>
&nbsp;#define SDMA1_REG_OFFSET 0x600<br>
&nbsp;#define SDMA0_HYP_DEC_REG_START 0x5880<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144434EE9AE055B167762F0F7D32BL1PR12MB5144namp_--
