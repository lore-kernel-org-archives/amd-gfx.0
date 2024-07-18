Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC6BC3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 06:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A0410E55F;
	Thu, 18 Jul 2024 06:36:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KJ9pZHhm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C70D10E55F
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 06:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItaICVPbXDcdeZKs7L/QzM/lV7YIeM+9HupXayxU47lQuQWbb7826bOoJImqxU6WSHcAgnzaOMONMNXqzBryBaGWj+JInQUZ0lLmQC6bF1g5oKJ0g9JFTd37hEE/pOqNpBwJMb6ZO+uFmOIcwuAfPGczbX/xVV5gBot/jNahf0NJqmPy7xcZEwRUlGFODRGOzWT4afwzzOHyLGiZsvRAYcnaGhfIrCCaVFQcqnWSzPZF5xKSHRcckfaLM/i+s2RQUUl0fY599fZW4LFP06REK0xDyVouWBs0+g0BhCJSha32mM0iS4YIgxdo7dHoKvtNwrvyfsdRkrvsgoCGeljYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBvh0XnfbrWhwSFqxP2n/RXInd+RUtraV/9j9QOhtw8=;
 b=JjvsrVxTXrkcxn4p2L4SD5uxXrRaRR+yjFwDEt5KlT4w4G8IncbmqgBWdqk6P39WJ2grFuEJ/+EtGxjTOjXwQDLfgrFoTD4uw6Wgj1GBNYSCHE+fjdf0Z/J8tOMVM5mYijGLmclLGUlia+sVxXNOGi237ye5r73Jz+uI2fkGS1Uxg5p0nUEC3Uo4nbGpLsqR969YuX9JwFlIZhAN3OwD7bNFl/tXwasrs3JltRK+Ncp7PmqpPlKoT68MklTdGp9hxzyN/KZV3l9TbRocOHDv3QOMkKOWZ9NNdyBFM0+hw0+b5HLgG+AUfkzR/TudgRhy+J1SHxMcNW2LtfANG6xJ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBvh0XnfbrWhwSFqxP2n/RXInd+RUtraV/9j9QOhtw8=;
 b=KJ9pZHhm8CZ1yrkX99k++AU54ofviExYSRvpu/uuhaJE5nGOjwDB/8i8A3TgaW9kOUIdE1kzSuUy48ZVDMZbP6hijzRMwBwxW25hpozcND+zLbkXDhgysq59RRGHHZqgDoHWjGeazg+QrRrXvpKznrCsXvGSk/0UGCAjjU9pMbs=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 06:36:30 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 06:36:29 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Topic: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info
Thread-Index: AQHa2CGZlu8rn/rGz0qvkKo/wpiqyrH7zCCAgAAJ6VCAABBbMIAAEuMAgAAITDA=
Date: Thu, 18 Jul 2024 06:36:29 +0000
Message-ID: <CH2PR12MB4215C842BBFE9EFC8023B894FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <20240717081547.224193-2-YiPeng.Chai@amd.com>
 <PH7PR12MB87965FE14B4B083B38E3CDBDB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
 <CH2PR12MB42159F3051B2254E1A5740C5FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <CH2PR12MB42151D081B5DA967A7F58B93FCAC2@CH2PR12MB4215.namprd12.prod.outlook.com>
 <PH7PR12MB8796FEA628053561D0046F6AB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796FEA628053561D0046F6AB0AC2@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7c3021fd-db53-4b87-840f-056fb3730b62;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-18T02:56:30Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH3PR12MB8484:EE_
x-ms-office365-filtering-correlation-id: db114c09-85d9-4253-4f23-08dca6f3f516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?seqxy7ESkgsEDDA4IWdisxfjC97/JzqQWpYuv1YnZhuOrhwCeQGrS9gTuW4Z?=
 =?us-ascii?Q?8uxt3xXc0VvcJ3P0lEYLmFcgrfhPWNRcKTvLmoJr6xyWftpPdDJJLGDQQM+W?=
 =?us-ascii?Q?oML9vKx1qT7+JtElQ0FkgGztsvfeSzLcMf3yZxgGJ0KY84YXmCQ37aBRir96?=
 =?us-ascii?Q?tJaG3KusQ6kIEbxXZebV4+EyqarUlvMJmwX1+rlnDRkhUhE+qClWF1EWlhig?=
 =?us-ascii?Q?TCBeVw44DZ42KUXWf4R14GkBOg76eT9F+gKdGX0TsdHn9h2Qg3zIE0htSNp9?=
 =?us-ascii?Q?HodMX2Le6LioM27FmO7pL8Ia80S1iR1DFwbocNxqkT6SJNa9GBeGNkwcm2rr?=
 =?us-ascii?Q?VO0qZxaHCHopt3O6WSdI9LdHUs3/5zy5wJj4AXS8O4MSrlQtsJumOzucFkBj?=
 =?us-ascii?Q?oK5wB9AmQb6MjK6FBizlVXeRc2dZP1HcXAsWMtd/pmY2rMBEaTgM5GvQHyPS?=
 =?us-ascii?Q?y8kfIIGStGmA8VwvdXT7moI5Z5R+UAjXa3nZP45e2ZsshnOc4gdAah++Bw1y?=
 =?us-ascii?Q?UWSEAfVjNKwAGC1z1N1szIMu4HPpJJyVY0rXRLjQ31fEb6pT6TIlhqCvNSfj?=
 =?us-ascii?Q?PIzj9CsCzaLkPk0+Kx2jcmRr9ytXkaIb8Zaec0sv8QOHXmMcPbBER12rJhrc?=
 =?us-ascii?Q?usqMC77zyY/ZvkLP/tJPH/Uldbv6H1eUURJ1gwYpEXg7qstrAiTfoicsiku4?=
 =?us-ascii?Q?xSKmUQ/IsGFCDUX/ndkMtpowxQEpMN7xSakKsVxRgluz3u9K2JY5KoEVSlkd?=
 =?us-ascii?Q?x7DHYgZGgzERQ5i8AcgDZTRdncpd7q3ng1vZBCBuMRnQ3ickVwq7cFaLy8p9?=
 =?us-ascii?Q?eoCymddws3EteZ6aqjlO6p4Zcno2EFat9y+rSiTSVzpVyyAovraSUva4c553?=
 =?us-ascii?Q?MmiSaWNEDJLLou5rlhH0wJQjvuo4jE2PlbCngbBMNn/DBx+a2pVx+WjPs43J?=
 =?us-ascii?Q?EgORMehIwZIgfurP3B6zJVmUyOdVl4cwx3AW0KLHGD4ZQ1FAA+0KjZeI3gum?=
 =?us-ascii?Q?msEz8lCOnpvARAEf5xf8fhXTYAozjvNa4qTcMMsXTbWtiOYsPAtXiF01MB/8?=
 =?us-ascii?Q?hJfxixCEajBkhBdPRjYEZTj4TNSKxRfl2RdMCCFDupXH4KhnogJG4f7VsiWJ?=
 =?us-ascii?Q?wCP8b7MPx4j0sUnfPTkrcbgSSf5mHPDp8lXiakcGisi9xQUn9tVI/1LrJ9Ze?=
 =?us-ascii?Q?2MT03+DZQWBm8MX2urU5bAJAliyZkzDfw3O/8AWOkqQqnHaX0SaKQ5bfucmE?=
 =?us-ascii?Q?Vdz1s5sh8kQmJdLEtJUt/0QCGxrX9YMONNTBB3M1+yCUZ7rY9Xjl6EA5+7fe?=
 =?us-ascii?Q?sUCPVKe1JDU4sL5fhn4GH9BNmeLGglt4LJu5GYQpnCWJpRC0dzonUagAwyYn?=
 =?us-ascii?Q?/xGzGpwsb3HGGa1DdcxUFcEDI93wvUFvOKMI2qPtQsHPNGkOWQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mr0Gw480le4zmePEtQh6HeaXaTphS0wLUxg9eVvzeP9fy0iXBMyKMgmnKlgR?=
 =?us-ascii?Q?ii5XUy1M+/6n8Us7WNXu/Phaq2hs+oOeevR8U25gBm2AsS5clFw2bcwphWFN?=
 =?us-ascii?Q?C5cF3a0w81WEC5t6FzVSmGkLj+bAcuPhz9UoJ6XaBwMryEEbIVxLvQBNT/5/?=
 =?us-ascii?Q?PZYH3VQc6iR8H6jzrf6hOl6M40sqok0NtB54P27Tho26elFpRnOlo0N/PINL?=
 =?us-ascii?Q?OUEnW9qZy51zHKKmLL2463h7UET5FTz7KlKkXVaZ6cwzeqyfMaq2I3MQXtgd?=
 =?us-ascii?Q?SeuH+y1PU7OMP7xnOMR10XEr3FrHqqKZP1PJ5qDDtqI+xjvoEXuq/bnfFoVJ?=
 =?us-ascii?Q?JiQIHU/qYzA4VNclkxxTCyDc6EjS4NrAGdU+wDovjk+OJ5LpWAT3b5birHqV?=
 =?us-ascii?Q?l+V4r+0BOVAOE40CqYBjdavELZAr9JHNQpHqzpwMYu0UyW/eKgXt//2WRJ/T?=
 =?us-ascii?Q?IQ5Vt70OYTYXNHF4UloabBmbSDk65/z1kn7JEBEV5CwWAANfWE08Y15q221H?=
 =?us-ascii?Q?HpliNlBnQbLsHZTIErgdcE1s+W5r8mG04oUxhHovbSsQiAHSanjF57uZUbG9?=
 =?us-ascii?Q?Q/7BPb+EMFOIFHtBVsXIbu9MWg2BM+jfqMlGof/EFKqoBk3hF+EEEsD3QAFG?=
 =?us-ascii?Q?TtRB1RB+PBiTknUVNizJBlZK+ln6Xk2mhenSMi2OvPTfY3QjNkaW+F+dNeW0?=
 =?us-ascii?Q?LE9nCSNvvbtYmTi3Y7J9NV6dD30G5Lq3/Oo5bt3gx9cWaPlaxRwhBYKV5cmC?=
 =?us-ascii?Q?qqsprb6+rx/7sjMG2wahEXzT+YtpkpwRh12kvfk/CaVkSCzStOk08qFDsviA?=
 =?us-ascii?Q?7HRs30rKsz/cDVSVXPLXGu/PbM8SlrymekxkEfDPYjSeFZDvrXek7BGCB5CL?=
 =?us-ascii?Q?vtNtG8OZu+eJD6Vwx+NwYCCSUi0yOB2NNsGJ9+hysCRntWGmjQbAZBrRNtjo?=
 =?us-ascii?Q?nFv9jXtPYD2+wWnNQ8fRGGnTEpC1fajWm2a2lfOh9A2Mwdt/l7A4pDMawTB4?=
 =?us-ascii?Q?dzo5cySYWLPtQh7bVWV97rJeubQD3xpAl7sYEw2woXIXJQgCcdVtSKMBkwVF?=
 =?us-ascii?Q?zCTBN5WCQ5g5ekBF4YVzvfvO/j4cJl8YHlNRzFcnJrim4ysxn+HKOKvc+dJe?=
 =?us-ascii?Q?eqyOAWzo8jRrojiHmY0ADC5X2qTjBRLCK2+jfrGcrv9vDDED5LJSVbFtcmKC?=
 =?us-ascii?Q?ILf6zLYvL4ZS8775gQXqHDJrRYW1qVi3ycfu94vp128EKettSiuD1dUBEO9v?=
 =?us-ascii?Q?U3Eke0Ar1yCrZu30ILZOM9gkU3gM5C5KVYioMcVH3+BQOCEzYfi7IrfVgJaY?=
 =?us-ascii?Q?9jik6Q1oRQm8L/r0HQlDgGD0ao1it77c0w6hUtC2FpEMVfk7ZriLuRrqvn53?=
 =?us-ascii?Q?64DcOJHTDY6eJJrv+8aQd2qRAoYRiXymswQRXMhLUb0HSyJas4G9BsT0b2+7?=
 =?us-ascii?Q?er3BBIGnlmWKFgIfhC6SjFMiJrxLpwFzyzUSDVetnTitij7KMU+G4Zv8g4Uv?=
 =?us-ascii?Q?uk9aPr/wLma+lDZeTonut4sxbogtHQntVkIqItvRCxiPpDjMw1pxvJ2SlJc1?=
 =?us-ascii?Q?lRI2RJUXU6X9okb1fBs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db114c09-85d9-4253-4f23-08dca6f3f516
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 06:36:29.8486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z50F4+KxoUGZ/8c+y3w6JlM+jvqHP2jPso67vPEI5B6BDYK4K28tRIZZsspHP0QvWwHe1V3eDVNEiaI9hZ/SBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, July 18, 2024 1:39 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@=
amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error info

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Thursday, July 18, 2024 12:34 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error
> info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Chai, Thomas
> Sent: Thursday, July 18, 2024 11:35 AM
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error
> info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Thursday, July 18, 2024 10:57 AM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: optimize logging deferred error
> info
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Wednesday, July 17, 2024 4:16 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> > <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,
> > Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley
> > <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH 2/3] drm/amdgpu: optimize logging deferred error
> > info
> >
> > 1. Use pa_pfn as the radix-tree key index to log
> >    deferred error info.
> > 2. Use local array to store expanded bad pages.
> >
> > Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  2 +-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 14 ++----
> > drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 65
> > ++++++++++++------------- drivers/gpu/drm/amd/amdgpu/umc_v12_0.h  |
> > 5 ++
> >  4 files changed, 40 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > index dcf1f3dbb5c4..f607ff620015 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> > @@ -476,10 +476,10 @@ struct ras_err_pages {  };
> >
> >  struct ras_ecc_err {
> > -     u64 hash_index;
> >       uint64_t status;
> >       uint64_t ipid;
> >       uint64_t addr;
> > +     uint64_t pa_pfn;
> >       struct ras_err_pages err_pages;  };
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > index 5d08c03fe543..2fc90799bf8d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> > @@ -523,18 +523,10 @@ int amdgpu_umc_logs_ecc_err(struct
> amdgpu_device
> > *adev,
> >       ecc_log =3D &con->umc_ecc_log;
> >
> >       mutex_lock(&ecc_log->lock);
> > -     ret =3D radix_tree_insert(ecc_tree, ecc_err->hash_index, ecc_err)=
;
> > -     if (!ret) {
> > -             struct ras_err_pages *err_pages =3D &ecc_err->err_pages;
> > -             int i;
> > -
> > -             /* Reserve memory */
> > -             for (i =3D 0; i < err_pages->count; i++)
> > -                     amdgpu_ras_reserve_page(adev, err_pages->pfn[i]);
> > -
> > +     ret =3D radix_tree_insert(ecc_tree, ecc_err->pa_pfn, ecc_err);
> > +     if (!ret)
> >               radix_tree_tag_set(ecc_tree,
> > -                     ecc_err->hash_index,
> > UMC_ECC_NEW_DETECTED_TAG);
> > -     }
> > +                     ecc_err->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
> >       mutex_unlock(&ecc_log->lock);
> >
> >       return ret;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > index eca5ac6a0532..f2235c9ead29 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> > @@ -524,9 +524,9 @@ static int umc_v12_0_update_ecc_status(struct
> > amdgpu_device *adev,
> >       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> >       uint16_t hwid, mcatype;
> >       uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> > -     uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
> > +     uint64_t err_addr, pa_addr =3D 0;
> >       struct ras_ecc_err *ecc_err;
> > -     int count, ret;
> > +     int count, ret, i;
> >
> >       hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
> >       mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@
> > -559,39
> > +559,18 @@ static int umc_v12_0_update_ecc_status(struct
> > +amdgpu_device
> > *adev,
> >       if (ret)
> >               return ret;
> >
> > -     memset(page_pfn, 0, sizeof(page_pfn));
> > -     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > -                             pa_addr,
> > -                             page_pfn, ARRAY_SIZE(page_pfn));
> > -     if (count <=3D 0) {
> > -             dev_warn(adev->dev, "Fail to convert error address!
> > count:%d\n", count);
> > -             return 0;
> > -     }
> > -
> > -     ret =3D amdgpu_umc_build_pages_hash(adev,
> > -                     page_pfn, count, &hash_val);
> > -     if (ret) {
> > -             dev_err(adev->dev, "Fail to build error pages hash\n");
> > -             return ret;
> > -     }
> > -
> >       ecc_err =3D kzalloc(sizeof(*ecc_err), GFP_KERNEL);
> >       if (!ecc_err)
> >               return -ENOMEM;
> >
> > -     ecc_err->err_pages.pfn =3D kcalloc(count, sizeof(*ecc_err->err_pa=
ges.pfn),
> > GFP_KERNEL);
> > -     if (!ecc_err->err_pages.pfn) {
> > -             kfree(ecc_err);
> > -             return -ENOMEM;
> > -     }
> > -
> > -     memcpy(ecc_err->err_pages.pfn, page_pfn, count * sizeof(*ecc_err-
> > >err_pages.pfn));
> > -     ecc_err->err_pages.count =3D count;
> > -
> > -     ecc_err->hash_index =3D hash_val;
> >       ecc_err->status =3D status;
> >       ecc_err->ipid =3D ipid;
> >       ecc_err->addr =3D addr;
> > +     ecc_err->pa_pfn =3D UMC_V12_ADDR_MASK_BAD_COLS(pa_addr) >>
> > +AMDGPU_GPU_PAGE_SHIFT;
> > +
> > +     /* If converted pa_pfn is 0, use pa xor pfn. */
> > +     if (!ecc_err->pa_pfn)
> > +             ecc_err->pa_pfn =3D BIT_ULL(UMC_V12_0_PA_R13_BIT) >>
> > +AMDGPU_GPU_PAGE_SHIFT;
>
> >[Tao] why address 0 should be avoided?
>
> [Thomas] When address is 0, it means the data has just been loaded from
> EEPROM, it should calculate  pa_pfn.   This will be useful for the eeprom=
 new data
> formats in  the future.

> [Tao] better not to rely on this rule, R13 shift requirement comes from H=
BM provider.

[Thomas] Currently, pa_pfn is only used as a radix-tree key index.  non-zer=
o value for pa_pfn can help distinguish incorrect values.
                 If xor pa_pfn does not work for all HBMs, we can discuss s=
olutions during the "eeprom New Data Format" patch review.


>
> >
> >       ret =3D amdgpu_umc_logs_ecc_err(adev, &con-
> > >umc_ecc_log.de_page_tree, ecc_err);
> >       if (ret) {
> > @@ -600,13 +579,25 @@ static int umc_v12_0_update_ecc_status(struct
> > amdgpu_device *adev,
> >               else
> >                       dev_err(adev->dev, "Fail to log ecc error!
> > ret:%d\n", ret);
> >
> > -             kfree(ecc_err->err_pages.pfn);
> >               kfree(ecc_err);
> >               return ret;
> >       }
> >
> >       con->umc_ecc_log.de_queried_count++;
> >
> > +     memset(page_pfn, 0, sizeof(page_pfn));
> > +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > +                             pa_addr,
> > +                             page_pfn, ARRAY_SIZE(page_pfn));
> > +     if (count <=3D 0) {
> > +             dev_warn(adev->dev, "Fail to convert error address!
> > count:%d\n", count);
> > +             return 0;
> > +     }
> > +
> > +     /* Reserve memory */
> > +     for (i =3D 0; i < count; i++)
> > +             amdgpu_ras_reserve_page(adev, page_pfn[i]);
> > +
> >       /* The problem case is as follows:
> >        * 1. GPU A triggers a gpu ras reset, and GPU A drives
> >        *    GPU B to also perform a gpu ras reset.
> > @@ -631,16 +622,21 @@ static int umc_v12_0_fill_error_record(struct
> > amdgpu_device *adev,
> >                               struct ras_ecc_err *ecc_err, void
> > *ras_error_status)  {
> >       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_erro=
r_status;
> > -     uint32_t i =3D 0;
> > -     int ret =3D 0;
> > +     uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> > +     int ret, i, count;
> >
> >       if (!err_data || !ecc_err)
> >               return -EINVAL;
> >
> > -     for (i =3D 0; i < ecc_err->err_pages.count; i++) {
> > +     memset(page_pfn, 0, sizeof(page_pfn));
> > +     count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
> > +                             ecc_err->pa_pfn <<
> > AMDGPU_GPU_PAGE_SHIFT,
> > +                             page_pfn, ARRAY_SIZE(page_pfn));
> > +
> > +     for (i =3D 0; i < count; i++) {
> >               ret =3D amdgpu_umc_fill_error_record(err_data,
> >                               ecc_err->addr,
> > -                             ecc_err->err_pages.pfn[i] <<
> > AMDGPU_GPU_PAGE_SHIFT,
> > +                             page_pfn[i] << AMDGPU_GPU_PAGE_SHIFT,
> >                               MCA_IPID_2_UMC_CH(ecc_err->ipid),
> >                               MCA_IPID_2_UMC_INST(ecc_err->ipid));
> >               if (ret)
> > @@ -674,7 +670,8 @@ static void
> > umc_v12_0_query_ras_ecc_err_addr(struct
> > amdgpu_device *adev,
> >                       dev_err(adev->dev, "Fail to fill umc error
> > record, ret:%d\n", ret);
> >                       break;
> >               }
> > -             radix_tree_tag_clear(ecc_tree, entries[i]->hash_index,
> > UMC_ECC_NEW_DETECTED_TAG);
> > +             radix_tree_tag_clear(ecc_tree,
> > +                             entries[i]->pa_pfn,
> > UMC_ECC_NEW_DETECTED_TAG);
> >       }
> >       mutex_unlock(&con->umc_ecc_log.lock);
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > index b4974793850b..be5598d76c1d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
> > @@ -81,6 +81,11 @@
> >       (((REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo) & 0x1) << 2) |=
 \
> >        (REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi) & 0x03))
> >
> > +#define UMC_V12_ADDR_MASK_BAD_COLS(addr) \
> > +     ((addr) & ~((0x3ULL << UMC_V12_0_PA_C2_BIT) | \
> > +                     (0x1ULL << UMC_V12_0_PA_C4_BIT) | \
> > +                     (0x1ULL << UMC_V12_0_PA_R13_BIT)))
> > +
> >  bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev,
> > uint64_t mc_umc_status);  bool
> > umc_v12_0_is_uncorrectable_error(struct
> > amdgpu_device *adev, uint64_t mc_umc_status);  bool
> > umc_v12_0_is_correctable_error(struct amdgpu_device *adev, uint64_t
> > mc_umc_status);
> > --
> > 2.34.1
>
>


