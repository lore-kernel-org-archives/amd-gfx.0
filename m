Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF773CAC5AE
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 02:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E5F10E824;
	Thu, 25 Sep 2025 02:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R4soAkm5";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013028.outbound.protection.outlook.com
 [40.93.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B32D10E824
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 02:28:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3RRqp63JggiPv5+o8yLFFioI4WIwmDH+5mB2A7zuDSHuy4cQthHg6PU5fE8nGYML2YQrD6NyjSXaCPPSpcuRTLC27Bh5mEpXI/hRA86aHJQZuXUFBSLKdVlpL3LPR0QQC8tchNZ+AxWfo35S2tFFbFuBZOeAGjXw9QiH+cz2QPFq/XbTvwQtvMkMYkAUzuCgC80eILB8shgucUV5G/iDZvjCZDgnNMABRGyK3GVZX5RZG7lX5ZcfqAWI3312BQ32bYxjH9+E1/l053oJnncpNUkGyKXK8yAlWA8rYok+RUvlxgVFCF4m2HoiJSZg09u2/fpC1apG2oLVR8OyrAmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AJHdkmwIKrm1Qr5mxe0nDLtU32w/6a1R5GVKbm0st+Q=;
 b=e1LydcyfpJXLNkDZtolBwO2lBaQdKqrUUQsisFg6urCwgAcBWw/It8vt14eS8DKJBqHTzR5sjJgVsrkpj0kvLaerqvMVpktTLRZyWqPKLn++TCHPIkkveps6l3KHWXb3AXgyTqJR04EK4apl2e9PIXle0ClMWq2adOC8XSl8Bv4piXNT+YOgq6XQvkqSKQsQFG0qoRqTC8BcZbrn95g97fZDnKDZ3GgpsFFgV1VFGFudkI50X3j4sPWn827oOsnK+poySBEW8sKdPyx7CZ9YFfKq4m3UkWgi+C3fxEZlSjK/mkWp+sOkhj5dDRAxjUchO9MEtGvagn+4Ke9mGsqJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AJHdkmwIKrm1Qr5mxe0nDLtU32w/6a1R5GVKbm0st+Q=;
 b=R4soAkm5RiJnT1XFwToGQfCiLHNJBDHNNSLNLjfWFWalPXXS/zF3C0fspKVnd6WYUrEWZ7ANbt/2pNTTZuvywGVJsSvZcU1t7DMfwH+qC5XLVf3lX0t2PbThjNERDIbojSfLTiPzBKfJLrw1FQSvDTpRkQe3J7NIKDdjJbSL3xo=
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 02:28:07 +0000
Received: from SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8]) by SJ0PR12MB6903.namprd12.prod.outlook.com
 ([fe80::e7ba:9293:d605:19a8%7]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 02:28:07 +0000
From: "Wang, Beyond" <Wang.Beyond@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] TRACE_EVENT/amdgpu_cs_bo_status: wrong total_bo count and size
Thread-Topic: [PATCH] TRACE_EVENT/amdgpu_cs_bo_status: wrong total_bo count
 and size
Thread-Index: Adwtw28oG/on92TFRWerNtADhWUcsA==
Date: Thu, 25 Sep 2025 02:28:06 +0000
Message-ID: <SJ0PR12MB6903CF64FDA3505EA8A067C0F71FA@SJ0PR12MB6903.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-25T01:33:02.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6903:EE_|MW6PR12MB8999:EE_
x-ms-office365-filtering-correlation-id: e6265f0a-67be-497e-b54b-08ddfbdb2997
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?IEryt0S8H59wQ5vRd+tCh6iof52YkkIlyQxwStOlErJj97dXGstOqFEd03np?=
 =?us-ascii?Q?U9IBZU855O5b8xIoIYgYEhNuxSTsgNnG1H70LsDosKlEkHL9IXjud6XD6+aa?=
 =?us-ascii?Q?9orjjJTz+qR/0Naa/yWsOb753W1MILW04VNXYvMo+7gr8T1bPTKKz8a14rnY?=
 =?us-ascii?Q?5H+q+t3J1lUAI/kUeJWAMKc1SOakMtrPevuuKwAePCbX3atWQaiylRXgjzff?=
 =?us-ascii?Q?lYOx32ZSBhKD/FJMzquETYh2khc1yS2naciBftlEnKMiwtoWmP2xFZLbullj?=
 =?us-ascii?Q?L02SbyfgvvenoUsbHOmxgIv57YhEqIz9gZ22mWSYs7y3awJHkmr3ZHFsuoMt?=
 =?us-ascii?Q?BnJVp1WFY5aUD0bnWYYyTlE8MP2IwZmT3VA+6r11wZrmnU9k9QLgcXpEkZ7X?=
 =?us-ascii?Q?zNAJjIa4Zsk+DeTmqrVJ+5qdmpBRRfoqRr+xFJVGxZiFDqeGQFbv/pniTnPa?=
 =?us-ascii?Q?WzinMS1zHCTAwsCa5JOwifconcHQPS35ZJaf9IQ+XO0BNewZ3MNfonwjZffT?=
 =?us-ascii?Q?xI8JFw+4x+CR2+j8S0zkkMpFxD32clZX8x7O1fuvOa55vy+zs4dttovbFKPN?=
 =?us-ascii?Q?WfthEqKjU4ZiSuSdlM9XleHhAyCfKn1IadYWpmah/nNzqvV96nXIl57bR/mi?=
 =?us-ascii?Q?ATQBl2wEPYbmr910M9e5I8oor05HX1hGzechm2ozZgCNGfFhDCFLHAqVDNr1?=
 =?us-ascii?Q?X4iL01O8wOt8k3NyrnrHBctoDdd2LEakZpHNJVRq17vTWXtnbDWZDJAO989U?=
 =?us-ascii?Q?BcaNqX04BaLOIhxOKkqHhkqeeuKc4kVUa+Yv2YKR81QmeqyBDGWDPl3JDcFu?=
 =?us-ascii?Q?CeMXmeHZNJdutyRFiCf9e/WbhFm01nP6YewgaaBMYJN03vZAKh7fcnuBxqPZ?=
 =?us-ascii?Q?90AXhTOTtAcGyqzdfSfoEhHZYjySFSVMoHp+7IEliKbxQ2iDjJEruCDT0l74?=
 =?us-ascii?Q?/EwKUEDKVXgMi73ll04fwj5bblmTVHVUoyGYZltzeNW6Ro1gG7pHlIU9Elkh?=
 =?us-ascii?Q?D9o2lX02EtK6kUOiYNu7c0oRxnJIOmpNQc8qvtWJ8lrDBPSIhLyjx6HqgOkT?=
 =?us-ascii?Q?MhY2OifU9dr2QxvAKzLW4wgL/65F2mda52HG3tHKYjkQN7JzBbnhiz9V7Ucq?=
 =?us-ascii?Q?opuJBWoVH5DnPvX4YCY3IHPF5DDnH6DUcSZ1Z7ayjfwOg34wicKLbb3K9XMg?=
 =?us-ascii?Q?gRNipHCHLFVOcE+LlaD24My1gr3OjnQsvkvD97SDKyIP1ri4bueV44ulDX3e?=
 =?us-ascii?Q?IDTt4P3GDXhhP9s8ugcBLkPYfTeoXOL6eo64xiAcXjqFupTV52HmLJCdf7DB?=
 =?us-ascii?Q?sGhDZrLIZ0INM7tBCSMD9ezwqFPJoDQkd8NLiu1KU7aajRWhRoyN9/wrIIDX?=
 =?us-ascii?Q?VnHmDFvV9hBHmZpvJiT233YQYQpf4BLuuA5s7+AYFMgizxLHtzUY/qgOk5wz?=
 =?us-ascii?Q?/D6okZB00TpfjaDWzGIsMdKtk07A500BLezlKHZuA6+Z7SKEW+U4Xg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6903.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IpKGoneNKFswG7vvJk7l7uoe3tlAX/mfI13X+KZWnsBb7A+XCav6M6Q3iRLw?=
 =?us-ascii?Q?5mtUkPi4vJJhCL0ZJxTdRR7+oGGhimGgKD/+RQBlo9YQOOrA0pMj0obKezHH?=
 =?us-ascii?Q?y+g2FZYKa+/Na4TQceoj66r+RIHxSOacGG/Q8jABlFc/MhVoN6PO8Nrty01i?=
 =?us-ascii?Q?uxraFAdLHMUqp2Q5Md5T2dRqpCpqKv8gkgHBgc/xEDs9yO9l+dh9ZR0yNL1E?=
 =?us-ascii?Q?IOO9xVHF/2mENc4iBMwa6ewzl2RbBl6kqtVIREsCJBg4pA0GQTYBNlgUeHkZ?=
 =?us-ascii?Q?xaIXlavKRdJfHzDGLZTiSdDdiAoRltjIrIcc0IVrs1aW5NMSP2bmyg7+iSLW?=
 =?us-ascii?Q?AFrbkkezq7LiR7YmumaFmofz8p+GVX663L+OK6r7TPDLx91SF7qtU4AOXe2y?=
 =?us-ascii?Q?QgwXOtjZobdXsvXn695xxNYuIO+wmqypm8RbFOLcGCASLFFEpDLfsdcN0F7L?=
 =?us-ascii?Q?+g2fS7jL2JwQ8LXRkc6xqFdqkxdMDpUk1326GK46z/duV26yZA+0ob4qpdWm?=
 =?us-ascii?Q?2R6F4kVtH7WHpq5saW+xJgbK398zgC68lKMbNl17Z553AsGeJdaxwHOycnyU?=
 =?us-ascii?Q?ql6e4fK2LttmINx7PE/Xrd2b0OubD/NfU1w2iQ8i8A9GjZQ3aws80VNkHTSQ?=
 =?us-ascii?Q?HY9mSwSKNrurwYHekM5VmYZ3NJCEILmW43+bM6hDkDNpJWpHAhln4qOyJI6G?=
 =?us-ascii?Q?blC4+azcjU1IQlsVGTxH8mHfJ+fz3/De9xb+TgX4rn5Lb4Wg1xkOCYgw9Y11?=
 =?us-ascii?Q?dR6OpTvWP/A6lNkqhxGB8Z6KjYSFuIcR1NLiHPnllZ0l8N3Atx5W54/BthJR?=
 =?us-ascii?Q?2vI2WCM5Y+F1rg9Jr01CzF9mbomWgqZn8QhUOb89lHrB0wCgDBzTz+tfPz5X?=
 =?us-ascii?Q?djdONDmAh7VtzwRY9EIu+1NWNDsKq3qIci/3QfjcYgUABGl8BDzicw1TKykQ?=
 =?us-ascii?Q?umnmBnUjEYwzyD60ue7z7y7OJsE2TukjEfJVfAPsUyyRKXAHH6/3Uzpiazqb?=
 =?us-ascii?Q?SIot/D1zvinsDT5lUmqi9zNyZQuWFgCAjlSdMtXutnMc5MhbpORojRAVoFI+?=
 =?us-ascii?Q?m0oSUmLa740jitQ/dhRnRKAvE99dpPZYG0H4ScS0A7GtMsFEncn5XZ7RF1vG?=
 =?us-ascii?Q?uG3zGybipJSx50yP5jCEMUuOuWTEjF04walIF6ZFfi8RDYMj+PT16NDaz6JG?=
 =?us-ascii?Q?g9zSHyO/2kzsZT8eEF041Atq1ggnsOMkidHn5iic3uuEDUIKFzpu15sNrJpZ?=
 =?us-ascii?Q?G+OqTPak6whII7Sa2WnYEKRKfdA8dwbd58G6S8tJ9FZX1qsjQvp1cLrKAdrr?=
 =?us-ascii?Q?R+HuYQmK0lIWZpEVnSaClwc4wgel0ig6x70YKaFnZJ00d+uahOb+ZE7f49TS?=
 =?us-ascii?Q?S2HMerZ2DMcgCs2Ije9dZtX581Yc/ObpM01JahT7wGOO/WPzQAZeB33BmnEF?=
 =?us-ascii?Q?cHL608sSyQpiTtplynydxDxJICELF02SPnzjpzMC8rEhT6RVUh/gu2wfrmJc?=
 =?us-ascii?Q?nUt5QBE/JsY67zYnzi4qbayrUjeFYYq+Bc8BoFH3g6UDGctQjb/8yBf56w6h?=
 =?us-ascii?Q?N7VSrpoksXWbr3bHNKg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB6903CF64FDA3505EA8A067C0F71FASJ0PR12MB6903namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6903.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6265f0a-67be-497e-b54b-08ddfbdb2997
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 02:28:07.0153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVIV7qU6gyoONQiMb+gNCFDHmGNVCmT9FgmNOyYQHVZFOyMUyzHHwdQHvnYtma/qXIm3MdEJLz6ArTWauY70hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

--_000_SJ0PR12MB6903CF64FDA3505EA8A067C0F71FASJ0PR12MB6903namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Mismatched order on total_bo_count and total_bo_size

Signed-off-by: Wang, Beyond Wang.Beyond@amd.com<mailto:Wang.Beyond@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_trace.h
index d13e64a69e25..c3321ebf3333 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -517,7 +517,7 @@ TRACE_EVENT(amdgpu_cs_bo_status,
                        __entry->total_bo =3D total_bo;
                        __entry->total_size =3D total_size;
                        ),
-           TP_printk("total_bo_size=3D%Ld, total_bo_count=3D%Ld",
+           TP_printk("total_bo_count=3D%llu, total_bo_size=3D%llu",
                        __entry->total_bo, __entry->total_size)
);

--
2.43.0



Thanks,
Beyond

--_000_SJ0PR12MB6903CF64FDA3505EA8A067C0F71FASJ0PR12MB6903namp_
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
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Mismatched order on total_bo_count and total_bo_size<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Signed-off-by: Wang, Beyond
<a href=3D"mailto:Wang.Beyond@amd.com">Wang.Beyond@amd.com</a><o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">---<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 2 +-<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">1 file changed, 1 insertion(+), 1 deletion(-)<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.=
h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">index d13e64a69e25..c3321ebf3333 100644<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">@@ -517,7 +517,7 @@ TRACE_EVENT(amdgpu_cs_bo_status,<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;total_bo =3D total_bo;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;total_size =3D total_size;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ),<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TP_printk(&quot;total_bo_size=3D%Ld, total_bo_count=3D%Ld&quot;,<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; TP_printk(&quot;total_bo_count=3D%llu, total_bo_size=3D%llu&quot;,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; __entry-&gt;total_bo, __entry-&gt;total_size)<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">);<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">--<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">2.43.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Beyond<o:p></o:p></span></p>
</div>
</div>
</body>
</html>

--_000_SJ0PR12MB6903CF64FDA3505EA8A067C0F71FASJ0PR12MB6903namp_--
