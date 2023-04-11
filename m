Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CDAC76196
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Apr 2023 03:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB05E10E484;
	Tue, 11 Apr 2023 03:55:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4322710E47A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Apr 2023 03:55:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RsrCb8IxKIlIA/UofIXpp4nW5nz88PSKj6YUJqrNgl4k9bGwmJ5ysMf/UVuDcby0qbv25VEND9iCirfBcJuKbDim3EDE/RZw7WMy/DKRVaQxcIqJJh7bfaa2QSMF1f4FwmMG43WKvHSmKNoqgsh1S6UOuEz9tsrymhRHbIOWtPlMFqgE2q+qi0jLlQJ7IWLII+c7KFexacEBulR1mFrUGWh/UGthbIyU72cZ1YDSQpWOWDtNnI0aJgUIAGhDrCy4r9yb6uR7m2VBR9uK19ltCuiVRBUvaR+XYcRo1Q60ma6Tr7c1St0wFlEoX663btehDnMuO/5v2LqVNFPPMn3olQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L32APNRbdHIs1Tni3ncD0AnYBmRpriM9mPTp2JWqhXY=;
 b=O1WP6EZDWhmTXRUvyyAFPzQxDEBJ6dKdmFLreN2JuUG7PYT0sW5MDaM6yANZSXTwbi8YMHjuxsJJ2y+M6EUeZXu0Bfj4y+Gi5JpYfCAi2rvoDS2r52n0CDJCbfCYkbRKC/uBkH4+w4ijOauIxdSu4DXbCHkg9mo3/9FpXQpr8OCXFV78pPY023nGeAJ5nohcgbDZzYpZ+08u1aENNrFPp6O8yKDL5NP10SIAEHUUJGh0CmHOJXC+hziM6XMF40W9rgMT6bOri0BAz/yxT6MQeABrXIJw/foqpp+ArBmmOrMXy+YOAknRnzKM6UxccdJa2boj6T7HZHwKCvZ1g9AaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L32APNRbdHIs1Tni3ncD0AnYBmRpriM9mPTp2JWqhXY=;
 b=so7W6Iks54ciw6aTTUNgnLptoBaOR2yCwJNeOKFNds6KEWifiPb8vi5ztyijN8hWGGNV2WTTEA60BjJre9teFs5CksoACccEjDioS+sqQyXEjnw7nfAQFTqviS4lGXAAGxf3joWTSnhJjejuB07qr1tHbVJ1YdL1PXxrqil3es8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB5025.namprd12.prod.outlook.com (2603:10b6:610:d5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 03:55:33 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::95d1:b78d:686d:2ec6%5]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 03:55:33 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Topic: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Thread-Index: AQHZa6Jd3Y/gjgyqV0WnPFy563vtba8lcYEe
Date: Tue, 11 Apr 2023 03:55:33 +0000
Message-ID: <BN9PR12MB52575ABC741DCE29EDD466FFFC9A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230410114822.750-1-Stanley.Yang@amd.com>
In-Reply-To: <20230410114822.750-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e0f974b4-d4eb-4f01-aa68-8f7ef49dca94;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Privileged;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-11T03:55:30Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB5025:EE_
x-ms-office365-filtering-correlation-id: 9a5df349-ac3a-4aab-d8e9-08db3a4099aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i2iyj7mOAq1WcDf/a8eM3ezdopEKui7JFhVsv1wpcDKh1gTE0KkieYH+n8+EpdB2SVHipHdrDAkbtUnh0IVypBondwgV8l1N8lZ6Zhce8B7wSeyqoJJRBI60iW7KIKP8xc/pgT+aFNsMLJf1DbJJSXBcJA94CE408Y4MZzGJIDJT5W/0aD3KZ9vnFnJAJvrmpVTFJKeaOo0lBbfIdMh6uztqtbPeo2rkrmP+2pPFVGsuTZvS/e3Dl6AqhMcML9s/u4KFTaiIT1Rykjyd7kgiFayP7AUq/hPiJtFYKy4tCDe5U4JLh2rzUZwoLfY+Bfuigw4FF9TrbWL/Ef3irYJ6Uu9mhnShvBDrf7SP81z6oMa8L2baNJddvnJKZxo6NcAyvgBYiDaIqFbeVGTG7NkVAqlX6s4H1e4QfR7tzeXux0qxK3rcf5n+1+BF0TTzM9LrUbBAQZgwFua58ks1ctj7cVrdSTalAQlhZnegT3+Rbr7JrzhmrX4dJIvgiah7e5rfBnsjr2W9r6g/e0L0hpfadv6TMwAdEoTlGo2JTTTqFD7akJQp3Gl+F8ydBT52MhSTPHsganT7m+Qm/aFWkXIZzjwRgdvja5AezMRlgiOl7w6o/xUyKrPVtPSEEEnLRNWN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(71200400001)(7696005)(478600001)(316002)(110136005)(53546011)(9686003)(26005)(6506007)(186003)(6636002)(2906002)(5660300002)(4326008)(66946007)(76116006)(66446008)(41300700001)(8676002)(66476007)(64756008)(52536014)(8936002)(66556008)(38100700002)(38070700005)(122000001)(55016003)(86362001)(83380400001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hdHPx08P0uKQRemuiVZ2whudRpF5YDNvQH5PaMYVvjYxmDyzlCklOs9TUtXn?=
 =?us-ascii?Q?J9M/t1Ym6tM7/FQxJdq92wQBvsM959MVwhG3Z//4TDDwzJMkzKB0DApYrsh6?=
 =?us-ascii?Q?8SpxeX+R6d+//f19MC+qTeXYd/tB2lUBi/+6yk/pXUM0hC6VhtApm9/0vOIn?=
 =?us-ascii?Q?3OFmMi0MZhFyvZYT20Jv1s4qsyWA7TJvfyTXTKKaKl1clRYWFAAYnbE7bSwj?=
 =?us-ascii?Q?k5qqFmLAHg/c1riLNgwBtviG+B5FeMqV4/VpXFfMvATPjajE5UVj5Cc9IWoA?=
 =?us-ascii?Q?4v8Bq16YxGZ5zMUDtxMtuqjW+1DDLm2Yczqn4Sruxj53NHO8beq8zwHYGBvU?=
 =?us-ascii?Q?up7VNDbHt+PK1TLHecaGQWUupJb/GWxKP83LDvCQuuue75IvZmgy/i28t1FF?=
 =?us-ascii?Q?OdxRsqC4YhgR/VoAwEWlhVGidcWzUIUSJrpxsyl82aWpVlNqs37E9s4u2ia4?=
 =?us-ascii?Q?nAuoc3Sn+YX9/sK7BhMbNEkWVp563nf4GkW+7n8GZvx0TE0eg3pp8hHt+oZD?=
 =?us-ascii?Q?teaI8qB2Fux37inWzvufx1sajiBkeKwU4hQya3rUyn51wd3YFcv9TDmW6G0t?=
 =?us-ascii?Q?5WljtRtvifU3t5JcPnmpQTJhiNYMZ9bpraffvnAiUv4g652PdNhoEAEKMIvf?=
 =?us-ascii?Q?LiCv7nItUeUoDQ3+GGrsO9+swznQFoehampVlaHooaH4MyG7Xj00UQw05hyR?=
 =?us-ascii?Q?79bcCixm/Zc2SNQicqDQJnvVKUB4tb1Bv8f/ffIDF56wF0uNjZOF7/3mKk8w?=
 =?us-ascii?Q?siU3jjKjsRj9mGLTZ7pQVVgngbuYBFSfOzqXx6168mTsOBTGOYEi2FXpkTNm?=
 =?us-ascii?Q?cUOEdVonXJBkUm5hrhIlXYpj1wlGNWqirk2p4GCEpfP8/EjakC0kCYNrR9u2?=
 =?us-ascii?Q?ZPYjz5INd5U78FdhDH8i7ZNItIbuIAnpiRaSmvtlIkILtwBMlWDOQzvoxg4y?=
 =?us-ascii?Q?pkhoalPbn0ysm3c8hnGLaAcBcK3sEJ9HYVlzWkvC+FPp6MpNx2tA0M0ZTBJe?=
 =?us-ascii?Q?z4jZBf+v26KgdBwG91YgA2QkdPYZe6hAZ/uYmVoWkXAWUzJMFWX3oG5isbMz?=
 =?us-ascii?Q?mfL442SV6kLK71OXpQbHIMb5IyFAyjKUD1Yj7R3t9rNkmoCvV4p9hvLyTmg8?=
 =?us-ascii?Q?0c9mv+LQgEyCJrd9T04l4cYmroCT6Y3uOzlR8CpbdGwF1ufkxGND9D66ckwP?=
 =?us-ascii?Q?Biq91e3Fyiqto0FrFVlL83bM9ITX2carADUppSOCv1VJ8W1JTVWse8XUB7Xx?=
 =?us-ascii?Q?iZ60it5Tn1tg/yRkmoO4F38ZWNznbKb2SJkIvK/KbXXv8dVjRGxe2HQosZca?=
 =?us-ascii?Q?4Cfl1c/3rfYia2PQPymqRc/WggKIUmAzRfdRt/KXv4R2kx8VKxvkevWjdsbJ?=
 =?us-ascii?Q?CktaebV/1AwggVcHLoGJTkk9dd3MsbiQ6RCfa77sF3FAJSnYssvlvT5Zb27+?=
 =?us-ascii?Q?TRQz6haow2HGCRm1GhxeOPxOqEdQzStYAZE5IthZnfikfIges73kdwvcL/s2?=
 =?us-ascii?Q?WT25mYJB3fWa8qTlCQVy+cdic/piiOuxKe05/wJUfPF/krCXN10Un/eelEzk?=
 =?us-ascii?Q?KTxPjysGvZEHmADE1Bk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52575ABC741DCE29EDD466FFFC9A9BN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5df349-ac3a-4aab-d8e9-08db3a4099aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 03:55:33.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+zWgHijbORCIw8GIxoB7KXjUKpS/1HyBOhYfxhuEwRLAYPx8hBOIqNAfG1rGoJ4BVT1hOmHnDVlS/cGDYy7RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5025
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BN9PR12MB52575ABC741DCE29EDD466FFFC9A9BN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

From: Stanley.Yang <Stanley.Yang@amd.com>
Date: Monday, April 10, 2023 at 19:48
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>, Zhang, H=
awking <Hawking.Zhang@amd.com>, Zhou1, Tao <Tao.Zhou1@amd.com>
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/2] drm/admgpu: fix unexpected block id
Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index ef38f4c93df0..17b3d1992e80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
                 return TA_RAS_BLOCK__FUSE;
         case AMDGPU_RAS_BLOCK__MCA:
                 return TA_RAS_BLOCK__MCA;
+       case AMDGPU_RAS_BLOCK__VCN:
+               return TA_RAS_BLOCK__VCN;
+       case AMDGPU_RAS_BLOCK__JPEG:
+               return TA_RAS_BLOCK__JPEG;
         default:
                 WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block)=
;
                 return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h
index 509d8a1945eb..30d0482ac466 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -84,6 +84,8 @@ enum ta_ras_block {
         TA_RAS_BLOCK__MP1,
         TA_RAS_BLOCK__FUSE,
         TA_RAS_BLOCK__MCA,
+       TA_RAS_BLOCK__VCN,
+       TA_RAS_BLOCK__JPEG,
         TA_NUM_BLOCK_MAX
 };

--
2.17.1

--_000_BN9PR12MB52575ABC741DCE29EDD466FFFC9A9BN9PR12MB5257namp_
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
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Reviewed-by: Hawkin=
g Zhang &lt;Hawking.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Regards,<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Hawking<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Stanley.Yang &lt;St=
anley.Yang@amd.com&gt;<br>
<b>Date: </b>Monday, April 10, 2023 at 19:48<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;, Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao.Zhou1=
@amd.com&gt;<br>
<b>Cc: </b>Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject: </b>[PATCH Review 1/2] drm/admgpu: fix unexpected block id<o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Change-Id: Icceb43556eec802f11c2077c1c58a1e92c9df599<br>
Signed-off-by: Stanley.Yang &lt;Stanley.Yang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 4 ++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/ta_ras_if.h&nbsp; | 2 ++<br>
&nbsp;2 files changed, 6 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index ef38f4c93df0..17b3d1992e80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -583,6 +583,10 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TA_RAS_BLOCK__FUSE;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RAS_BLOCK__MCA=
:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TA_RAS_BLOCK__MCA;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RAS_BLOCK__VCN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return TA_RAS_BLOCK__VCN;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_RAS_BLOCK__JPEG:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return TA_RAS_BLOCK__JPEG;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WARN_ONCE(1, &quot;RAS ERROR: unexpected block id %d\=
n&quot;, block);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return TA_RAS_BLOCK__UMC;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/a=
mdgpu/ta_ras_if.h<br>
index 509d8a1945eb..30d0482ac466 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h<br>
@@ -84,6 +84,8 @@ enum ta_ras_block {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__MP1,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__FUSE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__MCA,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__VCN,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_RAS_BLOCK__JPEG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_NUM_BLOCK_MAX<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.17.1<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52575ABC741DCE29EDD466FFFC9A9BN9PR12MB5257namp_--
