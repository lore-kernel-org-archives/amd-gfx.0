Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D5CC04A6A
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 17:20:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7200610E5D5;
	Thu, 27 Jul 2023 17:20:57 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FAC910E1DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 17:20:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWnYD6z6h7f+5EjumuA6uG94osjshGcsn03GTdZHx2x4DHBnhDVXroa4vcB0oOci4t2RomyYQtrC6+M1N3tBvxfxc2+hdCxx9ojni34hGsBk0Bnx3NykRj2n4Id8bwusFqnOGW0g25OFEqky6wT7XejWs78WfzRtWGrW6MIljBTVZ6YtO55EINx+Vpa4x8IZEfJrElGnHp7fYXqxGuR+CJoI/Q11EwoQdh2TXRqyMQLv9KDQSLgjWcq14Acp242svckw9Y6YuEULcyGq+bciL7422ruPHAKdqWKwUeK1Y4Q0Lq8A8QBFRheA1n99xusNt1OeI3s0y52D3+UWcGKvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RONNK4rC/BbJt30b6jcRFzSMS7W0FHCkn1D7uwdgZW8=;
 b=VIX3djar+ImfBqV9qujlxWZ2xzdpCB5rKjDjb6KDg8ErEep+YkuXhjxr6lkoFf+e5FYPaXZWMvpQ+fS7CavD3Q6Th54qW5FctlIXK0VPqaOwtwfKf+nJD992XSggiFRoawUpTDqpC/zdGKv0kYTPM8DOB6dwNvCOks2A/xP2debksGbiaU9j+Uvr/93RGJ5zB1gJ4aBVBJ6HG9XhpZXdDm7/64pfZlmdGANlPXn3C71hNlrZ3u56euicxlB/7j77WE4ZI1jjZIhwzRrruIgMGvnPFs8QKqfAdNTsDFV67BUZJuPAlureb5SDzAT9We8jZQf3rku6Tz+4ZK++5It44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RONNK4rC/BbJt30b6jcRFzSMS7W0FHCkn1D7uwdgZW8=;
 b=RPTObwjLQexC04CmjHFUaTpZb3bgCgOA46NXeLtoGRXuuMqJ+8XLQ117SUeVREf7V0T6UW/uAD+6H68T7GKS7KHj1LqRgq4DaYjNDofUZQCSiabm0SvqP+BAcAEPd4gYehMKrc9yl5CF0HtvlrAzOffrw2hgMYeOEoxk3mWxZtg=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 17:20:50 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::a5f3:e7b0:83dd:c832%6]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 17:20:50 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Topic: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Thread-Index: AQHZwH9wf09MPHNb00yu4l/jr7TGL6/Nm9uAgABAa9A=
Date: Thu, 27 Jul 2023 17:20:50 +0000
Message-ID: <CY8PR12MB7099B5BB2B774E7C9DD9BF698C01A@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230727114125.3891244-1-kenneth.feng@amd.com>
 <BL1PR12MB5144B27DEB701CD55D1F3136F701A@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144B27DEB701CD55D1F3136F701A@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-27T13:29:53.220Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SN7PR12MB7953:EE_
x-ms-office365-filtering-correlation-id: 082f3533-eed4-495c-af4b-08db8ec5d331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 554zi+P/d5r2pw3FCv3TLv7yjgJEP6GdhgT7+wZXdwhqzHd3VJDWPoJFrpQERf7kcTmWfy1c2RnSNT2xa+/r/6lWOpTq7/A1kQ71t0F9K2viHq5co4cpAOXAwZ2CP7FlM/HPsq822GaNqhWi0MroferKvaE8ur3tTRtjiZDXDz5qWWJjsYnpALGSVx0pjFzM0r/JyTQdpk8GkRl8xp8UylA1VTbJJ3LubqIjScHzkmV2kGKljfKzJDD7kYT5kGNOtBPeWCMi8Gudj+rMa0s9Nx1N8eRrapQofX4paCbAoIEr2OS/XjV1X7/JriO9XG+W89m36YwNUgc2sEjzuuKQhTHwkjtxuwRxYbzbm0eKUHrQ5O93/LoQxJ0DNJk9Kkj4qRCZH2IrvBZMGRnmAhF5Wb2J6kVsAqxuqS3LIo5CQJCmPzLKHsOxVNdAzjTbK343Vv5vmXUY8NIKxH5TBxZzLnGn8l9Mb8zNEHBwQo+k2Hu4vZSmB8iscn4yu6767y+eRCPXhxBqQ+fHpPuoC9DfzQg15Y/rkeZxFsalbXlJnewSfZaivzgpuvtZdCdu9w7OxLnpcppE4uBzZ0fES4uh6FiDm3Lczb2lWlSsnezgSYk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(316002)(41300700001)(8676002)(8936002)(6506007)(26005)(53546011)(55016003)(33656002)(66476007)(110136005)(122000001)(4326008)(66446008)(64756008)(478600001)(66946007)(76116006)(66556008)(9686003)(71200400001)(7696005)(38100700002)(2906002)(38070700005)(83380400001)(86362001)(186003)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9WDMQUEY+jqyaqrEbiIT3jq7X4v9xvGAUpZ/ZIT1ZfBuiSUBeyDVcOPPw+3y?=
 =?us-ascii?Q?kfF2EbI3faFQePd0k5VGyyQx06UmAkOHdplTqnoOS3qkOimqZGC+URMQQf6A?=
 =?us-ascii?Q?6c8iGaXmDb6mCx041/9LPAfOSOyp1hFFd0qLfOzhrGER7CuaVM8VllGuczFS?=
 =?us-ascii?Q?wmWlEDyGilcfm5iuy8JONQaY+nbvNsUkM4r65EuMZT/0XsAA+BT0nD/1EDnA?=
 =?us-ascii?Q?j/adePHKZu1I0ZCorlS3DpwGrmOQ7AiiIJtxwYn9Q0M0HVjpYhkc2bGcUOKf?=
 =?us-ascii?Q?WUVvzCUwaySiEGcRxGfbfAfgFzips3ByYDqJkmMx/kJxM1HijooPNSWQ4Oo0?=
 =?us-ascii?Q?mIuefnxYrHOljJ61JOo8W922odos/X12O9C+W3riow3xewGGP7iVIAzBe2OP?=
 =?us-ascii?Q?SisQdbRJPMsTzwYPZGnamBIFmYZgQZS4B+UU/jr57r9MqIIM2xbKx+DFtbeg?=
 =?us-ascii?Q?Ln1FI1DcKJccvB+W024iOmYrTRxlbfNUVSSEN9IeU5mxIdYlOE83iM/gtb8g?=
 =?us-ascii?Q?Vcd+W8QI9Lc+a0FZbsUhAqHXF8uACYJmf35Bo0q9thKg2AFupYZjjkzc6Syq?=
 =?us-ascii?Q?Cx9X0nddLyO4kRy1qIHUZpX+eWxSCExnKib0reDOnpj4TzOEsLC8HPjZSYZS?=
 =?us-ascii?Q?D1+8OpyzlTCR+dvfDrsHxgvUHtv3OqPKL51uzmLVnJS1G4CNDdwpfZ2N/uUy?=
 =?us-ascii?Q?LXbsL6Lbu9+k3aGKsjS77s7n4AHb966OfSLs5+7lVtxOcNylXsclkwEMJrDM?=
 =?us-ascii?Q?o4P7hRy4XoBQ6zRsy+OXHAgTksx2c7lXB+qQDnThFtKbc8z+e2gjRD6bE5i+?=
 =?us-ascii?Q?bROvQCNMHPIExnoTCPcd8xdAkQArzP3Qtg1qSiYCuxqhAkm/bpqCjOEQXVq3?=
 =?us-ascii?Q?bJXvwQvc69OlkGCl40+s9vxd3snWkQR3K4gvo8h2PZrnk8vPev6ttNHOWkp9?=
 =?us-ascii?Q?fiNI0fDK1l1NamVq0IN2wA4RAi2rsZwqEYXQYRFRmGjj7StP9pT8grGTv1YY?=
 =?us-ascii?Q?K7dHCTv7MiKfpPU7pNEmtvgX9+LbMxgeN9YEzLE8kQ0acCcco0ba5bJ+mxgl?=
 =?us-ascii?Q?XBd65mI7PHCS9wdR49b3W3emArYV/YHIGC/BNWqPCglT4CsLFvQ51+RRoJNt?=
 =?us-ascii?Q?Sit6QlLpBJA4DUm1HfTzBiEAABAgt7rRcr0Ka+qzzc5mbJK0x/sPKI6TUEbI?=
 =?us-ascii?Q?eIQNiKir62oHl5oBEjBduQnuduayKwph3X7n4H9TynalQLKTLn4cjPg+If/U?=
 =?us-ascii?Q?9ZKKdFn7wq58pMc3sTIT5V8FcTVg2zC+ySJK415jCQuSv9c/r8jReaHe//0h?=
 =?us-ascii?Q?wThleSFcatwIVMiWlKjO9HAF2VFGuuMrYXdgqfBS60qqHfT2Z5QD/IoCYJsL?=
 =?us-ascii?Q?I31j845m6FIeYIiUHv/xe601wMyq+wcKtS9hu+Oe3ExRt+S3kG4aSbQNg97W?=
 =?us-ascii?Q?kAk6KxcwbF6hroapwbeI4lUHzb4Jz2+WJTEdyn6HeX8CCsaGZ7Gh3n0AeUj/?=
 =?us-ascii?Q?SEIuiNLq9HsEWpkUBsIHPrZrkbw8JD5G1kERRJAxwLq5eCw7VjnblqzpD7xE?=
 =?us-ascii?Q?jaqYJmUwOjoCWKElsmA=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB7099B5BB2B774E7C9DD9BF698C01ACY8PR12MB7099namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f3533-eed4-495c-af4b-08db8ec5d331
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 17:20:50.5782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fdI13jCWK7K619H0vBxQzkbYQdeN0spF/l5ahmVqqOIATyC4Xa8UDYqTE8GkbS+vnXNUEdZbyiPg3ypfOX/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CY8PR12MB7099B5BB2B774E7C9DD9BF698C01ACY8PR12MB7099namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Deucher,=
 Alexander
Sent: Thursday, July 27, 2023 9:30 AM
To: Feng, Kenneth <Kenneth.Feng@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: Re: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0


[AMD Official Use Only - General]


[AMD Official Use Only - General]

Acked-by: Alex Deucher <alexander.deucher@amd.com<mailto:alexander.deucher@=
amd.com>>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Kenneth Feng <kenneth.feng@amd.com<ma=
ilto:kenneth.feng@amd.com>>
Sent: Thursday, July 27, 2023 7:41 AM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Quan, Evan <Evan.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Feng, Kenneth=
 <Kenneth.Feng@amd.com<mailto:Kenneth.Feng@amd.com>>
Subject: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0

correct the pcie width value in pp_dpm_pcie for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com<mailto:kenneth.feng@amd.c=
om>>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 232274423f9e..4bdbd3910e1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,
                 (OverDriveTableExternal_t *)smu->smu_table.overdrive_table=
;
         struct smu_13_0_dpm_table *single_dpm_table;
         struct smu_13_0_pcie_table *pcie_table;
-       const int link_width[] =3D {0, 1, 2, 4, 8, 12, 16};
         uint32_t gen_speed, lane_width;
         int i, curr_freq, size =3D 0;
         int32_t min_value, max_value;
@@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,
                                         (pcie_table->pcie_lane[i] =3D=3D 6=
) ? "x16" : "",
                                         pcie_table->clk_freq[i],
                                         (gen_speed =3D=3D DECODE_GEN_SPEED=
(pcie_table->pcie_gen[i])) &&
-                                       (lane_width =3D=3D DECODE_LANE_WIDT=
H(link_width[pcie_table->pcie_lane[i]])) ?
+                                       (lane_width =3D=3D DECODE_LANE_WIDT=
H(pcie_table->pcie_lane[i])) ?
                                         "*" : "");
                 break;

--
2.34.1

--_000_CY8PR12MB7099B5BB2B774E7C9DD9BF698C01ACY8PR12MB7099namp_
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
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
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
span.EmailStyle20
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Reviewed-by: Harish Kasiviswanathan &lt;Harish.Kasiv=
iswanathan@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Thursday, July 27, 2023 9:30 AM<br>
<b>To:</b> Feng, Kenneth &lt;Kenneth.Feng@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0=
.0<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Acked-b=
y: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@amd.com">alexander.=
deucher@amd.com</a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com">kenneth.feng@amd=
.com</a>&gt;<br>
<b>Sent:</b> Thursday, July 27, 2023 7:41 AM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@am=
d.com</a>&gt;; Feng, Kenneth &lt;<a href=3D"mailto:Kenneth.Feng@amd.com">Ke=
nneth.Feng@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0</=
span> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">correct the pcie widt=
h value in pp_dpm_pcie for smu 13.0.0<br>
<br>
Signed-off-by: Kenneth Feng &lt;<a href=3D"mailto:kenneth.feng@amd.com">ken=
neth.feng@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--<br>
&nbsp;1 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
index 232274423f9e..4bdbd3910e1f 100644<br>
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c<br>
@@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (OverDriveTableExternal_t *)smu-&gt;smu_table.overdri=
ve_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_dpm_table =
*single_dpm_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_13_0_pcie_table=
 *pcie_table;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const int link_width[] =3D {0, 1, 2, =
4, 8, 12, 16};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t gen_speed, lane_w=
idth;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, curr_freq, size =3D=
 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t min_value, max_val=
ue;<br>
@@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_co=
ntext *smu,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (pcie_table-&gt;pcie_lane[i] =3D=3D 6) ? &quot;x16&quot; : =
&quot;&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; pcie_table-&gt;clk_freq[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; (gen_speed =3D=3D DECODE_GEN_SPEED(pcie_table-&gt;pcie_gen[=
i])) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D DECODE_LANE_WIDTH(link_width[pcie_table-&gt;pcie_la=
ne[i]])) ?<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lane_width =3D=3D DECODE_LANE_WIDTH(pcie_table-&gt;pcie_lane[i])) ?<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; &quot;*&quot; : &quot;&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;<br>
-- <br>
2.34.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB7099B5BB2B774E7C9DD9BF698C01ACY8PR12MB7099namp_--
