Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB73C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 18:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BD960249
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 18:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00BD960249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F5E76E21A;
	Tue, 17 Aug 2021 18:26:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FCEC6E21A
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 18:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK4gFnvgtFxWo52O2iMmjJ9/RAYFRgSsCsAVk1dgmn6HcZlhScxcz6gY9npWHv9tvWGGQotsSnVKo1pmr97nIygaFeczUT8YwhyZX+5jkUTcelKy1YIJIuuS8DYgnNJ+CWlPmVGV43BCxQdHsbUBMfX2H4ouiC6G5woxEwRX0+VUvNzzDZwCrWXJGvg7u2yN2kNl274BBGS2PZkd6YlM9a8s00qZFR0OPhRU7BygOJ+A6G7RnRs2tswfs8ih6HFTGO6APwGEQVDU7wUXOu+gLy+NeJ47kGJZKb2sLYmzqgk+qP14v6EcoyNfffsu2gBHcq6DxZZOA1VIbe0Zrc8pwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaAl80ye88kv2glDbNEzprc6809ekLrsjVy3wNa17VY=;
 b=ZXdM0A3ogNfqNB65GcgQzr2uVxpUJoslfplScLqpDSac/11jb18HNtpDeskUV6rLe35t/UPlvIwkIaiauoNV7M6m8/gFE3Om5leIEbuhSt2Vu0qlhasLbfNvb7DKd0UVabSjh4eK3ZruJ2Xwnyv0cSOmS64Zumoam0f0zAFS6XiXp9Ejemn0FTvYOX4i1cqm9SevaEUZiOCx7SNbxCOx6dEO7hzCV7YO+w2sTTFz+KaoPFoQgXbOd7JKuqRPTd3WEwgxbyPv4z0197cQa+iTCzB45wTMSMCLmCvA0CQRgkCSn++naZ3V8GHML45yAlPmnNAp8afZKnxbjqQ7VQZTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaAl80ye88kv2glDbNEzprc6809ekLrsjVy3wNa17VY=;
 b=g/AAIZ2ubk/OX/9NXGQ09TLuamGAAZn6+Zaq01fNhHCOcgo2hN+Hgyudai45etGUDUdgvEReg3YKRjUNSJekQYgx0JP4lP++L+ErlKYfnBKq8xcc9JSTIFVFdYmDuh/Y5wfhRDhz4gMd2leK7MQ2LPtcdjwpAJaMZ+WUYRNzdes=
Received: from DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) by
 DM4PR12MB5312.namprd12.prod.outlook.com (2603:10b6:5:39d::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Tue, 17 Aug 2021 18:26:01 +0000
Received: from DM4PR12MB5245.namprd12.prod.outlook.com
 ([fe80::74cd:6cc2:dd29:1780]) by DM4PR12MB5245.namprd12.prod.outlook.com
 ([fe80::74cd:6cc2:dd29:1780%9]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 18:26:00 +0000
From: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix radv vulkan fps drop after s3 resume
Thread-Topic: [PATCH] drm/amdgpu: fix radv vulkan fps drop after s3 resume
Thread-Index: AdeTlPNYoVeOHL/DSvKqaEtc3toehA==
Date: Tue, 17 Aug 2021 18:26:00 +0000
Message-ID: <DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-17T18:25:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=978b27d4-7d21-46ae-8c51-07f9f59696ab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e0f26d16-65eb-405b-dabb-08d961ac7702
x-ms-traffictypediagnostic: DM4PR12MB5312:
x-microsoft-antispam-prvs: <DM4PR12MB531238B01BC4B4766632C7DBFFFE9@DM4PR12MB5312.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wGv+K5HWxje4FH87E+rkElTFLL6JMp81Wr3k+nmEt/jvpoaShrQZYimyszFDH3Rl1sZyh3lLhIj9BUCPpaUxe2FTHL5P94l4C9IK592nHT9Mjt5SpJUycZDwheGNgtWy2cbGALTGctY0epZOhiuhIQD3imHkmSLy++BoSilUHjhsPtKapuLPR56IeEMI31waYBBUJQFw/oGwZKzs+J5O/hsTEZ32VGw2iMH3ie7jraDk4PFjqhsk4l5pe04nYmgYz8HJnTrnFkclVMGpn902br/z2R5nhzn3dEgV2tREBgJdYvG8BsajXma07LmLT8XTnat0NdOxcrr29A7vizd8WTWX44n7mVd945JOdTRM7LCoCZ9oyQywvEh6LpVDi9C7zbDfPeuEonHMrMiFHeZFq1IhpxmDmWFok1A96ikxFs/MCujaTksV2GDF7G/kjjqDXQqXFnk5I7cwT3kk1ddqwaw1Gdf6xktrwvU/WjGVhaIsAxzo7iy+Lcn8ohK0WR+OLEEKLN+v5yW0XzCai2EXzkafMN2PT9iDSv33qhohIg+uQDGRkgMSQ8vSLzwRklI2BzumFH8av4vZTLztDqqdLG8yycAwpJwnKkftiEystXOveOzRpR+DVLN+Os+0Vjrqg6BFC1mbTsN/eiaOlAd5kRAHN1Fd4/IeJup13Nw47M9EItosFl5L/Me3gJA7deoTbp/wvebFa0vtjDD/vf8wUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5245.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(7696005)(83380400001)(6506007)(76116006)(66446008)(316002)(55016002)(71200400001)(5660300002)(38100700002)(186003)(33656002)(38070700005)(8676002)(9686003)(66946007)(122000001)(6916009)(8936002)(64756008)(52536014)(26005)(66574015)(66556008)(86362001)(66476007)(2906002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NWUO0YkOJBbTnDcFbHa6N1vNrr0/CvuOFhpkC/m0kTLOO4+x7wvZV8koFN?=
 =?iso-8859-1?Q?rK/TPY8L3CASPWseuTY/UqdSbARJRDlFonPQeF76PtpYFyzGBO57taeahr?=
 =?iso-8859-1?Q?ae3Ik7jQim6E8+fum+BSisKBtbwDUU1+q+ftkaIRJunD+/yPclL6p91Ool?=
 =?iso-8859-1?Q?CJuko9G1+Q/3CVMmeq1TQ94XZWvHQvn+cYsWxO3qjV4K2KbrrVkBrPyHzY?=
 =?iso-8859-1?Q?I127Yu2NIDUhEvM4VyCTKao7YUo7uyNYD0gU7JyU4Xie+W63SVUmzfFkYY?=
 =?iso-8859-1?Q?yQyJ+wcMxHwL7b2Tk5daWGMfgkLrSziuUwDoNAnE3aWIPcDuYhhpcl9UWI?=
 =?iso-8859-1?Q?fIybNpnpzF3F2Z3S4hVrHz1vo1DaOSkNNuO3ccIqfwU+AkKkLFBjE4cxO4?=
 =?iso-8859-1?Q?uVik2kKXRJ+P3X1IQBXyDe66s0kKNLjvT4afU1KrJdNJfnxGjdzk+u+gJl?=
 =?iso-8859-1?Q?ZxHC842ivFbnvfV1UV8fKxn4/pdqmNB9lpoAYVkTEqHd+bLgVlr5e+54XB?=
 =?iso-8859-1?Q?zH/lod4EACU1Htw9axv/gT8crCGnvOc8OmCpEYOmlAUsNEp7ZhVtPD3TgP?=
 =?iso-8859-1?Q?bbyG6ECugLNuZ/e+hhstBLwlHXmjiAdT/mKahZDZFjN5dJhgdjE6Sr0s8P?=
 =?iso-8859-1?Q?+S6xOu9zzuAhURIo+kB1zYCxRxpiaVE9fI1ApgTZgCE2DyuPw9IBaGpxcE?=
 =?iso-8859-1?Q?SseRAiI3ZvWim/Bp5MyrLP+DvzEkBJq3m8K6Z71sW8h6zLYL0KnG8HfLn5?=
 =?iso-8859-1?Q?Y2l+5tQZ8wZ9vrKTnfVzRNGt1IqPQe5o9dwM2gQJNcCUvNREfFG3GIN8yP?=
 =?iso-8859-1?Q?KzClrLOlIl8cz+JsGcH0YOgDAZHOZ94DN4ZOa8dDTmLkcDX7TEUq+kFwxs?=
 =?iso-8859-1?Q?q7yJUEPtNn6RTjsamAQi340nbEWK4enB0/Gjbu2tj1kyQ7SqHkVyuBbkd6?=
 =?iso-8859-1?Q?f/+tKvEk9lrx0UNWBbUYXV5C1yHcGZCsDnU3WFiENSOJQGubxGCauNuZuF?=
 =?iso-8859-1?Q?jHadndk0PXnr0IoHcuc93+rKzOMo63ZxnCl5Jh8WSkml7bVtWxy0ruMXhF?=
 =?iso-8859-1?Q?771NCVS04s22aRM+loxWt+S9RKihUnzKc5Ejzp9icjTaZBBTmCQJF/5R+X?=
 =?iso-8859-1?Q?S0qZnoySz/nMkSjpuKJrJmt7YFz2f+8M4W8WYg9LXj/D1AeUo4vBtpdfB7?=
 =?iso-8859-1?Q?8IvwdqoemuEUlQT3/xymfdVXkaanYSzlvXTYhWAHE7a7vohS/iKIYhMo0+?=
 =?iso-8859-1?Q?cgU9RyjgrQ+iuJWE7fiELB+d3CodJbJ0VrJmx75dY7gTS5533hJNbUfasN?=
 =?iso-8859-1?Q?1yeTwpnp5Gp0mMw9s+kaKlLDTRHgc4iVkFsvmGOvZrrDF/Lrx9hxRZ/Rh8?=
 =?iso-8859-1?Q?0DN1k0Cu2p?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB52454BBA711B61BA2BD03033FFFE9DM4PR12MB5245namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5245.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f26d16-65eb-405b-dabb-08d961ac7702
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 18:26:00.7206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJhNdqt8gUCpf7nRouYSV/YHnGsOMoM6wjdxE8A7+MuBZ3IOsoaQ5XHT7jMBqIx9MVf7cjpCjRYi3i2+wdeQ6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5312
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

--_000_DM4PR12MB52454BBA711B61BA2BD03033FFFE9DM4PR12MB5245namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

[Why]
After s3, In radv there is huge fps drop in games. This is because
when memory is allocated using radv_amdgpu_winsys_bo_create()
with both AMDGPU_GEM_DOMAIN_VRAM and AMDGPU_GEM_DOMAIN_GTT domains
set, the kernel memory management after resume fails to move the data
back to VRAM. In kernel memory management, ttm_bo_mem_compat()
function returns true and hence data is not moved back to VRAM.

[How]
Implement the idea suggested by Christian Koenig. During suspend
move the data to system RAM instead of GTT. Due to this ttm_bo_mem_compat()
will return false and data will be moved back to VRAM.

Signed-off-by: Christian K=F6nig christian.koenig@amd.com<mailto:christian.=
koenig@amd.com>
Signed-off-by: Yogesh mohan marimuthu yogesh.mohanmarimuthu@amd.com<mailto:=
yogesh.mohanmarimuthu@amd.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-
1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ttm.c
index 446943e32..44ec59998 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -136,7 +136,13 @@ static void amdgpu_evict_flags(struct ttm_buffer_objec=
t *bo,
                            return;
               case TTM_PL_VRAM:
-                            if (!adev->mman.buffer_funcs_enabled) {
+                           /* Move data to system memory for S3 so that wh=
ile resume
+                           * ttm_bo_mem_compat() will return false and dat=
a will be
+                           * moved back to VRAM also in case of bo with bo=
th
+                           * AMDGPU_GEM_DOMAIN_GTT and AMDGPU_GEM_DOMAIN_V=
RAM domain
+                           * set in bo->preferred_domains.
+                           */
+                           if (!adev->mman.buffer_funcs_enabled || adev->i=
n_s3) {
                                           /* Move to system memory */
                                           amdgpu_bo_placement_from_domain(=
abo, AMDGPU_GEM_DOMAIN_CPU);
                            } else if (!amdgpu_gmc_vram_full_visible(&adev-=
>gmc) &&
--
2.25.1


--_000_DM4PR12MB52454BBA711B61BA2BD03033FFFE9DM4PR12MB5245namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">[Why]<o:p></o:p></p>
<p class=3D"MsoNormal">After s3, In radv there is huge fps drop in games. T=
his is because<o:p></o:p></p>
<p class=3D"MsoNormal">when memory is allocated using radv_amdgpu_winsys_bo=
_create()<o:p></o:p></p>
<p class=3D"MsoNormal">with both AMDGPU_GEM_DOMAIN_VRAM and AMDGPU_GEM_DOMA=
IN_GTT domains<o:p></o:p></p>
<p class=3D"MsoNormal">set, the kernel memory management after resume fails=
 to move the data<o:p></o:p></p>
<p class=3D"MsoNormal">back to VRAM. In kernel memory management, ttm_bo_me=
m_compat()<o:p></o:p></p>
<p class=3D"MsoNormal">function returns true and hence data is not moved ba=
ck to VRAM.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[How]<o:p></o:p></p>
<p class=3D"MsoNormal">Implement the idea suggested by Christian Koenig. Du=
ring suspend<o:p></o:p></p>
<p class=3D"MsoNormal">move the data to system RAM instead of GTT. Due to t=
his ttm_bo_mem_compat()<o:p></o:p></p>
<p class=3D"MsoNormal">will return false and data will be moved back to VRA=
M.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Christian K=F6nig <a href=3D"mailto:c=
hristian.koenig@amd.com">
christian.koenig@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Yogesh mohan marimuthu <a href=3D"mai=
lto:yogesh.mohanmarimuthu@amd.com">
yogesh.mohanmarimuthu@amd.com</a><o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-=
<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 7 insertions(+), 1 deletion(-)<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c=
 b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 446943e32..44ec59998 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></=
o:p></p>
<p class=3D"MsoNormal">@@ -136,7 +136,13 @@ static void amdgpu_evict_flags(=
struct ttm_buffer_object *bo,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TTM_PL_VRAM:<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_enable=
d) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Move data to system memory for S3 so that=
 while resume<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ttm_bo_mem_compat() will return false and =
data will be<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * moved back to VRAM also in case of bo with=
 both<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * AMDGPU_GEM_DOMAIN_GTT and AMDGPU_GEM_DOMAI=
N_VRAM domain<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set in bo-&gt;preferred_domains.<o:p></o:p=
></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_enabled || a=
dev-&gt;in_s3) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Move to system memory=
 */<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from=
_domain(abo, AMDGPU_GEM_DOMAIN_CPU);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!amdgpu_gmc_vram_full_visibl=
e(&amp;adev-&gt;gmc) &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.25.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM4PR12MB52454BBA711B61BA2BD03033FFFE9DM4PR12MB5245namp_--
