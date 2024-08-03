Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F56C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sat,  3 Aug 2024 14:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B2B910E040;
	Sat,  3 Aug 2024 14:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMzDr2nG";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD91110E040
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Aug 2024 14:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6Zz0IzAKtq7HyE4KGQD00y8LlJpDLCfIRN5oAaAa9zGBlDSSH/Ff6lm6YbUmIYdOG/th1HQqF5+lOk6f3E8XtF13oBZCWph1OpABC7YJW6WNoJck/roxrenD7o07nyfw94H24HL/AS3A0dwP69xFbS/dhHsdxx26KiyzdkoJUkBVWwHPp8fZBbf5LC56Noqh+8Cxkl4A3/2DdByEB+E3GLdQxZlyaGYRSnboeImj1wJ+pRsNyTvlHra2VxIUO8uGe2lkApTaf/QQ5O3Kuc3uIX+gUBFvROsgNhNN0BFBrTmPXpSmVcrbnEGmJGp8SY4I8r2SkpZqYdjH1Wg0xiAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FOCpXQ/EBF61ocJ8Twds3/SS/uwUzovKlJt0DBDYxRM=;
 b=FH5DBD4T8BI6cCBOan8bsUAfuk/OOMja9CdyqkLScA1/dEn/2uugdmbkGv3zwLoNgkakdYKVShPlC17VxqeAACMQQ+NOlxldJ85HvlNFXWrKKqxmkiUg+KcyryeSD9z8xRjbQgoGrh4RhPEr+Sr+QY6s/WzDsRmgLsM/tQ34jpcm7jqno1z+phFOfe670T9/2OjDhEetg7iSGM8seAA0qP4RoxByqCENe13c6tAjxUywOttQaK10udsK5wdQKWFFbczGlANNNbJX1K9aiElMPwXQ2sYnZudc6LsqBXKP/8QWD78WBU6JB5B5gLLfIT2Qnb/buTVX7NWMOjqes1EeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOCpXQ/EBF61ocJ8Twds3/SS/uwUzovKlJt0DBDYxRM=;
 b=pMzDr2nGJiApWdcm+feFNyUfpbo+I/R1rU6tVC5JYULIuBMbqKxoqtCUrzNcTzbSlTzJ55RWXITP70WqtdgB8ObQII1Opm1j3qbqwC7zvv4N+sn+PYtTXeAoHdvZxTBWyTjYUWquUtewtFJuwSZqjLfFSVIqPxEyd1fvDv4yej8=
Received: from MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Sat, 3 Aug
 2024 14:13:05 +0000
Received: from MW4PR12MB7482.namprd12.prod.outlook.com
 ([fe80::681b:3798:247a:34d3]) by MW4PR12MB7482.namprd12.prod.outlook.com
 ([fe80::681b:3798:247a:34d3%6]) with mapi id 15.20.7828.024; Sat, 3 Aug 2024
 14:13:05 +0000
From: "Dandapat, Soham" <Soham.Dandapat@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "Ramayanam, Pavan" <Pavan.Ramayanam@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] check for mcbp 
Thread-Topic: [PATCH] check for mcbp 
Thread-Index: AdrlrtTFHO16c964Tua8+Q4DpV36XA==
Date: Sat, 3 Aug 2024 14:13:05 +0000
Message-ID: <MW4PR12MB7482EF2FD5ECF7101A593E5180BC2@MW4PR12MB7482.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d7dc63c5-c3c5-4848-bc90-23360f25a223;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-03T14:06:04Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7482:EE_|PH7PR12MB5976:EE_
x-ms-office365-filtering-correlation-id: 07f21f5f-506f-43ff-6b42-08dcb3c6649c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?V53w6gsThhRONKsQGIHqEnXwlIhEvNSx21Ffg80aH7Xy5qy1+GPG2LqwRUaM?=
 =?us-ascii?Q?d0itgo6uAEiXN8Hsp5BHWdDjV7K81lGZmbZeI3OVk39HufPLwzV4SHmmELP2?=
 =?us-ascii?Q?N5Kbsef3y/O5cNFyWOB2CoWYDr/Ef9ai2Gckiky6ocpajcn37aGdcgJx8plb?=
 =?us-ascii?Q?zVeXTt9lOi7mJRL91c4s0fWbHxmAET0T3h+hWAPnKwqBVbECMmV4q2+sqbLT?=
 =?us-ascii?Q?ZnHOljT+FB8y1wEzYwWM8nWe34a9cyxl3DEjMLcJVEovCXf60KvtwR2dOl3q?=
 =?us-ascii?Q?Gl/Y7toV/i8cikRkib8E8QWt9M+ABsiIJsNAbhOZcI1ZlIzC4vvrzzSIQ8KF?=
 =?us-ascii?Q?3eENEIR2ZdHUQmCUoZn3ubwBVdPSY/f1LS5Indcj6OcpJx0XZ6WZG5cBQAYh?=
 =?us-ascii?Q?fa1KT8fkGdyTbiCUQvdCvjQaSYLdm4cspas0NZBUgF5wUlHYv/YhzB9osFdz?=
 =?us-ascii?Q?mvoCG36rYw1ZaGc8tErTt40JDV2P0gE5JrBhk+SNijsstQSyhjPAL+ojQFYK?=
 =?us-ascii?Q?UFog9/WrRXNyIe2qoBh29dZ91Ey0HzfRSS0Kqd0leO3SnOnaJ4sz5HCCJ2ZK?=
 =?us-ascii?Q?SJ3ZBoZCJff6LdDc0yKdAPfQkG3T6rkeGFBvY9EcyyhFmsor0UkIwQfFZ09u?=
 =?us-ascii?Q?WwbQ8djR1YBqNix/Sm2MCqZCnPvhBld7anI6BGyudpfF2ooxzh4YTenWTvo2?=
 =?us-ascii?Q?tWEIJVX8OV30nnAjn+bcuPu9N4RvG1iyJjnXQrKxz86piVXYNx4/ttNOITsX?=
 =?us-ascii?Q?emGE4xcJSiKMIv4hW00qbqChvrqAdB4ycDriZsEwGxNXlunQI046sKmolW1w?=
 =?us-ascii?Q?ABXq22oCaCFOsH6q2w2b/ZU/IVA8gvxGLysDLKs8sU09N24n9WVsBz+ThfvQ?=
 =?us-ascii?Q?FgqdgTCHln9OXGLnDkSNdYSxgNuPHmEN/kaAmbByu2FPElDwUpS7ylNZspcf?=
 =?us-ascii?Q?idcoFBs6uAfg7bHQ22tZkZWJxCDEe1GDjlxeJseHbDLZiL+fRIGxtWTvvEgq?=
 =?us-ascii?Q?0JaVaE80czyp/JZ/5XW03iA25bUFszYkDNCAv6vPDWBCtJrhvoShjd/PWuBc?=
 =?us-ascii?Q?T5z/d3XEf2KgHPZWGgvXTbJ73hh/s2JjhisiE3lZ1JJRAMf/iN933X3CxDZm?=
 =?us-ascii?Q?o/tuCBKz0LNuTDlsUTTpO4UFg9Y/xnnCeGAGENL3WiArNJ3um4pYEj2gGfH2?=
 =?us-ascii?Q?f8BktxaSTObAJ2bsNTlGCVxdUITJrQ+xN5myoTg6XdALo1WfyKeE19SzL0kf?=
 =?us-ascii?Q?LC4hImq+rIESOlGSS5OftTvOklEf9V5MkARGC48niACuetqNC2fngbkf1Ya0?=
 =?us-ascii?Q?Qz2+TJfWScHg+KuR5LAd6VfnejQOJXeA+MCYtU2dJgMdIlGq8bj+mAWjKG6W?=
 =?us-ascii?Q?9geQNrvOBSK6AYkm++OlY4g3CYhUaYPj7D6D5AoCQwQUv67xlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dip194KjYqDVyLz/iJwOEgGrcpxtQf0hHVVQF31Gsaqa+GtEbJQTtiCZcxDh?=
 =?us-ascii?Q?29bCLzi4oJCN7hHppjZ33gF+GQYgkNcw+pJsA7l/gouc/wNWrcF3IUm9tBCC?=
 =?us-ascii?Q?5YEjQXOoSUmGbw1nE1er6yb23XiiyaC5y0lE7aCvkkQPiUBb2onzWPFwBZ1Q?=
 =?us-ascii?Q?v8QQWSYJdsAiyezlGZiPK14iXlz93QQPjEUDa8+H62uU4bT9rGbdy5erl9X7?=
 =?us-ascii?Q?+8+vAPV36oO0hLazC9tIqwmvSC03cO/ddh+2598islTnJJStYMUp6gwED+XJ?=
 =?us-ascii?Q?DQN+qBzb7BDHmz1dl45nTQ21XFP/6mdrXOegOK3BbmVwAzGg/ggMeYGIYwS9?=
 =?us-ascii?Q?eMxJNFkNXWxaX4u3cxdtb5EJgEb4C4IW4rOq1WULSrO6J9Sqtv+VHnmzNP5S?=
 =?us-ascii?Q?M2NKMPgxZyxN8IiuyMrjw5PC+gBUwMdswVhg3ZyhIY56RiQHjj7/qZPrfdpC?=
 =?us-ascii?Q?rLLg1oAoMbHgGvuvZoXi/VM8cG6onwRqN7N0YQXNLH5BRNhFsOhia/C4h/iV?=
 =?us-ascii?Q?Z1ahMwKPAJ+9Tqj4D3et8F7M1wTPy71Pnn6PWsgsKXbP2Oupau/u4jKg8eEk?=
 =?us-ascii?Q?64wTA6rD1Hudxoy17eqe5gDqNwTOwVelmAA5n1IP/j8HShZ4eftWiqIfCfkT?=
 =?us-ascii?Q?hqNWkfI5fjE7bprSlP97RjPd4YjfMSgNDkxydhd5aGT7fpsFfCoICLtjxQmR?=
 =?us-ascii?Q?+4JzlbofSviidNQBMMjbUDc+IMuOtGO/LyidtLSrz+pw2K+lrCquoO7xXUnx?=
 =?us-ascii?Q?Kq/G2x92eIGuPKMyGUrN58fmUffJMHSjgSLHjGSbyXHv0btv28vkMyRn9zj1?=
 =?us-ascii?Q?38540I5FzVGWGie2r+9nRQUOml6kUmdgVU2GSJiOrhEC712wB1W6R8mk5atF?=
 =?us-ascii?Q?PqUxgl/oHSfvxU11MuDYFPI6LuUFlcUw2+WGYgrYwCgLbGXy3iE4UZF1MkE6?=
 =?us-ascii?Q?/UjLfd7SlejiV8h4u5Yn10Hbrv9wof2aVctjPQ/Wk0Vzn0ZYsdE0aiV0vSaC?=
 =?us-ascii?Q?CvOBFZ9qr/yvJWeyiHhDtWjT8DlAI9UxNBEfrZ6698Af0svJ8rvoGgQ3P/eU?=
 =?us-ascii?Q?X4IQSZGmwf+z5FvrbG4a9yxElEz9WR/OejW1mnhkJsb6WJ5aEh08KvhKzLBZ?=
 =?us-ascii?Q?LRtxrD46oiPgTEwYwYWqs6GfC5cSj1ooInb8TwJwJl7oWU8X+7SnFkxxedlH?=
 =?us-ascii?Q?vkiKyIWiCylJyC3GxvzDsNlGgMsuDuScTJUA0+JC7p3PheNqXcgrcr6qY8fv?=
 =?us-ascii?Q?QfxLhoGyMOrBMOw8SD6D0Sjly/AnyEpfOpQQ/AMwCjI8VHeKwUF3/mcH+dmV?=
 =?us-ascii?Q?57kmQMIX1Ub3VPf9Exv/XrrXF5lCS11FEL4/mIkQ7QDO7HW5R2E1cuFtUlSt?=
 =?us-ascii?Q?0UgdHyojC0Wokei4OuW2Rw8cdamy+ftIqwvYd7HRAWvJYhpBskmBWeCxGwnk?=
 =?us-ascii?Q?CW+wJoiBPNfPv/idh4lPYFI17OHhongiXSwnDJTl3q7Dn99mAMmFdkMD/UnW?=
 =?us-ascii?Q?Lg+YyB3KkYK8i7psEvXMarGcTv94ncK+oljaCOxVZVzUcf+3ajrjRGafStj+?=
 =?us-ascii?Q?WTyWlNfLdKn8SrY1cig=3D?=
Content-Type: multipart/mixed;
 boundary="_004_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7482.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f21f5f-506f-43ff-6b42-08dcb3c6649c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2024 14:13:05.2076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnS/NWpQul5l+7eM/9UzklZ9EOnVGZOw0wbxZE84XAs1NlvoLTY3hBw5n//S2O5P/uXxNnIPYtgK6MxOjR4V2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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

--_004_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_
Content-Type: multipart/alternative;
	boundary="_000_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_"

--_000_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

This is the fix for below
we don't need to call amdgpu_ring_mux_start_ib/ amdgpu_ring_mux_end_ib if a=
dev->gfx.mcbp is enable .
we could return earlier in amdgpu_sw_ring_ib_begin/ amdgpu_sw_ring_ib_end i=
n case !adev->gfx.mcbp.

Thanks,
Soham

--_000_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_
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
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
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
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This is the fix for below <o:p></o:p></p>
<p class=3D"MsoNormal">we don&#8217;t need to call amdgpu_ring_mux_start_ib=
/ amdgpu_ring_mux_end_ib if adev-&gt;gfx.mcbp is enable .<o:p></o:p></p>
<p class=3D"MsoNormal">we could return earlier in amdgpu_sw_ring_ib_begin/ =
amdgpu_sw_ring_ib_end in case !adev-&gt;gfx.mcbp.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Soham <o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_--

--_004_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_
Content-Type: application/octet-stream;
	name="0001-drm-amdgpu-Return-earlier-in-amdgpu_sw_ring_ib_end.patch"
Content-Description:  0001-drm-amdgpu-Return-earlier-in-amdgpu_sw_ring_ib_end.patch
Content-Disposition: attachment;
	filename="0001-drm-amdgpu-Return-earlier-in-amdgpu_sw_ring_ib_end.patch";
	size=1212; creation-date="Sat, 03 Aug 2024 14:06:06 GMT";
	modification-date="Sat, 03 Aug 2024 14:13:04 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmMTMyYjljN2Q5MTliMmJiMGEwYTEyMmExNmMzZjFhYjVjNmFhMTBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTb2hhbSBEYW5kYXBhdCA8c2RhbmRhcGFAYW1kLmNvbT4KRGF0
ZTogTW9uLCAyOSBKdWwgMjAyNCAxMTo1OToxMSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWRncHU6IFJldHVybiBlYXJsaWVyIGluIGFtZGdwdV9zd19yaW5nX2liX2VuZCBpZiBtY2JwCiBp
cyBvZmYKCkFzIHdlIGRvbid0IHRyaWdnZXIgcHJlZW1wdGlvbiBpcyBzdyByaW5nIG11eGVyIHdo
ZW4gbWNicCBpcyBkaXNhYmxlZCwgc28KcmV0dXJuIGVhcmxpZXIgaW4gYW1kZ3B1X3N3X3Jpbmdf
aWJfZW5kIGZ1bmN0aW9uICBpZiBtY2JwIGlzIGRpc2FibGVkICwgbm90CnJlcXVpcmVkIHRvIGNh
bGwgYW1kZ3B1X3JpbmdfbXV4X2VuZF9pYgoKQ2hhbmdlLUlkOiBJOGNjNjQ5MGQ5NmViNzczZTkx
ZTVkZTE1ZDZiNjEzNTE0ODU3OWNjMQpTaWduZWQtb2ZmLWJ5OiBTb2hhbSBEYW5kYXBhdCA8c2Rh
bmRhcGFAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmlu
Z19tdXguYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5n
X211eC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3JpbmdfbXV4LmMKaW5k
ZXggZDIzNGI3Y2NmYWFmLi4xYzY2ZGExYzNmYjQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yaW5nX211eC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9yaW5nX211eC5jCkBAIC00MTAsNyArNDEwLDcgQEAgdm9pZCBhbWRncHVf
c3dfcmluZ19pYl9lbmQoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogCXN0cnVjdCBhbWRncHVf
cmluZ19tdXggKm11eCA9ICZhZGV2LT5nZngubXV4ZXI7CiAKIAlXQVJOX09OKCFyaW5nLT5pc19z
d19yaW5nKTsKLQlpZiAocmluZy0+aHdfcHJpbyA+IEFNREdQVV9SSU5HX1BSSU9fREVGQVVMVCkK
KwlpZiAoYWRldi0+Z2Z4Lm1jYnAgJiYgcmluZy0+aHdfcHJpbyA+IEFNREdQVV9SSU5HX1BSSU9f
REVGQVVMVCkKIAkJcmV0dXJuOwogCWFtZGdwdV9yaW5nX211eF9lbmRfaWIobXV4LCByaW5nKTsK
IH0KLS0gCjIuMzQuMQoK

--_004_MW4PR12MB7482EF2FD5ECF7101A593E5180BC2MW4PR12MB7482namp_--
