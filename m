Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C37C9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 16:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F71710FB7F;
	Fri, 25 Sep 2026 16:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jiOEQI6+";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D12C510FB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2026 16:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nieJfrhmAsctYUacmMScnnCyUqYv7YjWBtowmbYCPIQJI96S76s0y8kheomJZ+CDzjiPBI+lBkrDe7fUOnu6FgeNhucaJp77LD9MM1Xz1PNpguTNZhVlQgVCNC5mOrsjQePx+LOU8l3s+NerTDMeTl3BS5Vf+LdVauP2s5sQlgrC8dyDw1vmFH+xFq7q3ZkudR3i/VRyZRiqYz9FhYzvj8yI7X6M2/7cnxVTW5GySTGoxvwXSg3Ze2i/DAsUMCCayXGTpDHsQJ7svt9zgn5IBXkvEi1MaW0XVGsBeySyALGgCsIEk+vw7yL1GOMWxy230qkYDuFNZckjwRUcRLFaYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYgpqDLnqazdlaihK2wNf0SQ5fQQTfNxVJ3wYmQFd54=;
 b=TvbZe4Z2joneGqRrbju08SMa7rgYaUbhpFpybQ5knIQp4CrhBcB+RCkan/PX3aO6eyL78PaUeYy+/c5ilRWrUTBzyEKecDr9R1ik9TZSU/aFMUohn6qrKlzP7t/FQpEQvEcXbhaCP+uf9tK167+uyWchl3WOQmvbGfalCYUTDJTLj8sUqs0sABZcNq2Zt/NhYtgaAYv4F2cOAmL7dSc6PsJhkhhXSPGy9IkZZXsmQSbGGI0HPhoucGk/Zg8ezXXW+XNJ8YZ6gtBjY2FodPlVXqrORvgbyUBpCUE+weJMSblUFwWy4YT5rqMXuBaBKb72Ej4odhAfQ/PO32HIPetDNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYgpqDLnqazdlaihK2wNf0SQ5fQQTfNxVJ3wYmQFd54=;
 b=jiOEQI6+FPR8lPiCxjtWXOiiHTw4jvt3uu615rH4PJBVYCCNxfObQMTuVJMNIcVNCZWe7mdYz4w370wEg4bAESiO2HoK0BPNeqyfBmTVEVBo9Khfvc+mALCeA4AbS44E8Wo8upX8QyF3c5SzzD1m6mz4COQSweuiTrCN2Z9uMjU=
Received: from DM6PR12MB2684.namprd12.prod.outlook.com (2603:10b6:5:4a::33) by
 DS5PPF922753E5F.namprd12.prod.outlook.com (2603:10b6:f:fc00::65a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 16:34:22 +0000
Received: from DM6PR12MB2684.namprd12.prod.outlook.com
 ([fe80::72f6:bbe4:fe93:7bdf]) by DM6PR12MB2684.namprd12.prod.outlook.com
 ([fe80::72f6:bbe4:fe93:7bdf%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 16:34:22 +0000
From: "Samoylov, Alexander" <Alexander.Samoylov@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Topic: Re: [PATCH] drm/amdgpu: Add pci_domain to struct
 kfd_dbg_device_info_entry
Thread-Index: Ad1NC1MawecUgzpzR+CFQNOBEV3I2A==
Date: Fri, 25 Sep 2026 16:34:22 +0000
Message-ID: <DM6PR12MB2684222733E7665632520C0D83802@DM6PR12MB2684.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-25T16:30:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2684:EE_|DS5PPF922753E5F:EE_
x-ms-office365-filtering-correlation-id: 0972fb45-f580-4709-6491-08df1b22dac6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|38070700021|10067099003|8096899003|11063799006|56012099006;
x-microsoft-antispam-message-info: CL8SAH6zK1QGmuQ+H4IAwYs2UNi+tQp58Rt8EAhkmRswu8uBuAZrkPN1D48TIIHBShBqx5s7vDfxEx2uW2l2m2GMxc5iu3LJfxXBcsz7S9Nb31fRrFQu+T/ZW6lmbnDIUx8uy1ichlbKC8o1ZbP8CoNvc/1/tzrO36NU4gcd3V6q1ln6A5bw8KN/fZhC8DF+Pzkr2/WcGwF9OirwRWvuiZLfKQELTFmNJ0S04bJ+nUkt6ljBgFQZU1UTIC/3I8kU1zo3cDXGSgfqEWswE2C++GJMHiCNDDkt0VowM/Cd6IP+jRedGQ+ln/wP8YbL9hlPkHi4ibnFkJnovrDtbdPVvra+qeYPnuUek1qbWg+bQLdGiZ8pSNzWdN3ijeg7Ln7+6/XCMw6SPVo0ylDSEkATGalqM32ezE16FW9AII2g7m8asmN3oUjnbMS+1HzXWv00IbOmGV7YsHs/a5TT4ZEF1hH0odOhCQH6CRQxI3xSzYpDagMZiMsbJdEW8EqRH57AXWaSAg0rIhqRnNtaAklf6og9bzclqE0xkSMyVamw3Cp4GoreLs7C2nmv7GwIygmMRX+Q+cHmOFtOPfzyEsK3xEEcotKXMT7zM9vdYLBKekhCxnj9ZGRDsvPZPDPaVR6Q9iJTAjFIGjnobWcCCSy1o81qrNjRdiisIVICNbiMTJe5I/kISxkSCJ5Y9aAeV/W2nNA0o8N2oW0MKm5x2FC+bZ+qOiewYL5Hj3gIj8deZW4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(38070700021)(10067099003)(8096899003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cQ51WRHuidBrDDjl6cqckInIeU9iCg8SjykJHmjAs7ayZnx6zpKXSNUBQ3UT?=
 =?us-ascii?Q?F+GHM3bYCoHTQzOdXHl3R4G2j29nRB4h1yNNAd08XzE9tiv75YZ08oAXoq5n?=
 =?us-ascii?Q?ObQcCFzU7bZOsNn536NQaGqdTDP9ha0s/5M5DwBcX2lkTfFKD2SMsU6lmrlV?=
 =?us-ascii?Q?lMm9nRRiFzAJArR6t1XOy458si8DoO+28NmBbOi1nLKjWkZoypKccZmjPoh9?=
 =?us-ascii?Q?nWNJcmV1CBIn/25ioU9Rc4h9yPalkigV1o689V85QDoSAEsC0d5WpuW+CBWT?=
 =?us-ascii?Q?OsmLSfNxBSE/QI5+S4B8CyayGAIqi0ONFZrJ9zYMLCNI5D4WWTPSzETuj7Hk?=
 =?us-ascii?Q?Jh3tTjdN0NYvGnQPtuTmtwe+weVw6XDD9y450rm1b8QZ3SeUN3cC9G5kpZ90?=
 =?us-ascii?Q?zIPiWQlKmP//Q+V+TqY6Lh8v+hm4Bj4CDG8G2G1qfqmuVcbCpJRJevxTK64X?=
 =?us-ascii?Q?cZCZb+kRur0Dw6tKfcYyvLLkn7llmL5CTLnhXsPugNCxArfEBWdT1imsM1Nu?=
 =?us-ascii?Q?k84w2dTjnLo5UwGkr0672nAqZuCil7XRUL8WN7XcIDL7pYtCmOjXTqa2+Hdx?=
 =?us-ascii?Q?iaM2sH9vl3HDqPwbY76L/TFgTbzBK4B9qaWAlDQ7YfsdayisvlbGxOYSfamK?=
 =?us-ascii?Q?UNR8a7qOjtWJu1wXrz6tMV86L9ph32l4HtpOc396xGb6368+28p+auzLgiDr?=
 =?us-ascii?Q?+2Al6F7T6G/uX1Ixjq5U/1+nuwZZL3gLO+VJIk+QSMZkYFD4MzVgOaJNCXD0?=
 =?us-ascii?Q?oh+YlI0YkFRRQa6B3mH4k1fQWQAcJaU72MqaHznt4m661iRcwhETnFKvvf9X?=
 =?us-ascii?Q?6shlKOLvtBg7bKxE5nYvGhAgChG9XTaVFU8e7jyEFuwIWZ5gRlqBlnugL8GX?=
 =?us-ascii?Q?fnsMhGbabjLnaWjzuyjeAi7LCGtWPrwpcoxQ9f3gU9xyYHKfoS5QeQUHqj9B?=
 =?us-ascii?Q?5ol8LV7UEB0/Rl3nnrIrw5UihaBTL1+PFo46skLmy5ayVkbP/LjMkGBlnhbI?=
 =?us-ascii?Q?VLp5lgPssoRvBzymPHKNLPZXCKNy0Si72RYOQYAXE3HY4VpvfSPC0tUfmzAV?=
 =?us-ascii?Q?XpmdSFwwvL2czxle51Vrq/hKRgnqsJrmGig8W/KdN+6umtOzr5HUm5YbKDO/?=
 =?us-ascii?Q?7v44DUqzrm/UGip2638GZ/Qr9oJ2ZyckC1kvP15yx81Gbs1Hmfr8KaSfY5DF?=
 =?us-ascii?Q?vuG50NUBVQ1IxZguj52EbJDVhac9opN4LAtt8kbh135EMya704wxaZWCKL20?=
 =?us-ascii?Q?Hmjd6518B/WygEk7i03EU6qPbNuNR2smtQE7XpGJ426hk8ar0BGvIUATCrVd?=
 =?us-ascii?Q?/fdJ0q4qEYxFeUAIMFUAAQsiY22UjKtvfq1QLYUjbWWAmtehNNt5FAvMIw7M?=
 =?us-ascii?Q?9fJ7Foq24yL8SgzC6BN8H7MTDQiGFdaCVd3O3BckTGKNYztzEZQmR8zgqc3w?=
 =?us-ascii?Q?asJMG2CdQASTigCRSyh8oYp2ueoTQRPxScaLI80R0U7yHC0fyeVCLwMu+tfW?=
 =?us-ascii?Q?h2b6EiqKyUFuVnGwKMWPX5vijnNFjRd2WcAPAaGATJl0Kfmp71yubdRf/Heh?=
 =?us-ascii?Q?JUv2xCTAh47HNm4/bl9YIyeb/aaDLe5d+JjfeEE35ui8V/l7BKLH5aKIt67x?=
 =?us-ascii?Q?XZW3c545vVll06fiyfkNPSQd0J+CISoZGN/Pgf0UMocn1OeI7vUwj5tRbhEu?=
 =?us-ascii?Q?fPu8W7A46yDOBHxBP3NyPL+1GZ6Y8A+/mdwl/mLllhpWtiJz?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2684222733E7665632520C0D83802DM6PR12MB2684namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0972fb45-f580-4709-6491-08df1b22dac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2026 16:34:22.3091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KiP6sWQHV1G/ZUe4DKe/SA5x0D0Mob7owpwLCXByKUwOM+r8aAKSm7ost0sHbvrxPa2ItPKt0vXPZ3CEw4hcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF922753E5F
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

--_000_DM6PR12MB2684222733E7665632520C0D83802DM6PR12MB2684namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Tested-by: Alexander Samoylov <Alexander.Samoylov@amd.com>

Thanks,
Alexander Samoylov

--_000_DM6PR12MB2684222733E7665632520C0D83802DM6PR12MB2684namp_
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
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
AMD General<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Tested-by: Alexander Samoylov &lt;Alexander.Samoylov=
@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Alexander Samoylov<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB2684222733E7665632520C0D83802DM6PR12MB2684namp_--
