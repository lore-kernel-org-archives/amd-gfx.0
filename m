Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4869BEF06E3
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 03:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD22410E13C;
	Sun,  8 Feb 2026 03:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2r2YBrS/";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD90C10E13C
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 03:17:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn86zorA6JghrPy2VqW+mCH0t1vLHpBDbLo9u2fQdv7z00l1lfZlTEgAnxpYmTwKthysrB32w4U7ICMyQL5FtInCwbpjAg4J6QpVeBbd3oPvfF3D3bcSmgz19/AIbgJdioiZZbq4elA7V84YBq+F3AZKCap/f6+7D7EHN+ieV/HcP75wdlGqvshbuDER95BjgLdTZ9YG/74VWfuoRUSwMspPnaJSvaUMA+7oI3I8y2bYP6F6SgivtM32cB/OlEcfnMFJhI7mOdTwZvaq8y54Z0E9HTXGP8MkBHtONE6AJcefNCaU1l1DO+wYucHmDuhc0ktoEhPQXm3vLADYjtqSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MehctPPvxMWso/UNTBDExKy+YbZ2EORZNKv00912H6Q=;
 b=l6cXQHLr7VOx950GhgdLUt1NO/fkRuiS1wm2TgDv+FaswIJxMYDSNUZfNwGLOcklkHn8hPN6kwXGqJnI8VuvhutT9NBcv+Uh2dkXoJPdSrte/yHp3y13puMqf+uN1Oya+Qgxs3C6MfkE/XVcOyJXP332QTomsiyaM1pmbxNkZUBVsTtIaxaq3R9R2d3AfL1A4BZS4scu+C9gD3zFGZgXPy1cB6hE8QeptEqsbul8dIEZ9Rpug8hspDhcwZRD+jOIkXK7eK+0C+bWqTJPI5/fRNhIVBVkLlr0qPavoEfcvgiZcAgeaoVeQWkYZyjfYkgiDFd80/qq1RDimwEyMZdwRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MehctPPvxMWso/UNTBDExKy+YbZ2EORZNKv00912H6Q=;
 b=2r2YBrS/AuT0PQCkKBgyGj0i29Dx0/04j2XY31+1OnCBooUXiVOgynm020yDatlJpJEL/tN+a5DQdGVhF3Fx3ZMPgs2h5ntfljeF9ML0YKJ7xm+1gwbk2RPm4xb7He+ndtPwtStJNaUbSA+E7fKYGslrm4SqMj5zqw/dGhWQBCQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 03:17:00 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::c32c:f300:e4d3:ae19]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::c32c:f300:e4d3:ae19%6]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 03:16:59 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>
Subject: RE: [PATCH 07/22] Documentation/amdgpu: Add documentation for Peak
 Tops Limiter (PTL) sysfs interface
Thread-Topic: [PATCH 07/22] Documentation/amdgpu: Add documentation for Peak
 Tops Limiter (PTL) sysfs interface
Thread-Index: AQHclmvoVEdGbvLdWEGwrBmVZlfyz7V0omMAgAOCmsA=
Date: Sun, 8 Feb 2026 03:16:59 +0000
Message-ID: <CYYPR12MB8655C9D60BD760C1CC1124F49C64A@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
 <20260205065130.654921-7-perry.yuan@amd.com>
 <CADnq5_M59RNnzco4mSL90mfxKp++Z82ZyLBt17LtUKVkdxNEbQ@mail.gmail.com>
In-Reply-To: <CADnq5_M59RNnzco4mSL90mfxKp++Z82ZyLBt17LtUKVkdxNEbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-08T03:13:37.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA1PR12MB8360:EE_
x-ms-office365-filtering-correlation-id: c65ed4f2-7188-4b04-dda8-08de66c085ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UFNZdnpBbDBZUnZFL0hUOTlDNU1wdVk0bEwzRmtPcDk0MUtVcE8xTDh4NTV0?=
 =?utf-8?B?YWZiOTFJRUZpMDFEb2pwMnRTN3lWaHc4T3Ayc1pBckRWalFtQ1JjTGQ0RW0x?=
 =?utf-8?B?T3Ricm5wekR6cmtCdnVWR05RbzY3WEJyTmlUemw2UGhhWVVQNk1nazhySVJq?=
 =?utf-8?B?V0dNUjhpb3RBTlFPeVlKN09ybEU5UkxPZ3dVSzJkcER1NjUzZDVoQ3BFVmRH?=
 =?utf-8?B?aGpyUHNVZmt2TlVlejJKeXpJZHdXcEpLVGZObEhNMkZ6cFhuRlVjK1dFSFBt?=
 =?utf-8?B?bWdDbUF3V3huNEp4Qmk5TkZmcWZkUE5iQi9rZkZhOEU3V2EzaVNqZi9LcmVT?=
 =?utf-8?B?dHBUVjM4SmFsdUhLYWhpUVZpZkpFN012WG5xbkI0bTdjWEtrVmhiWVJRWTV2?=
 =?utf-8?B?eUtBS1ZYMGNCMnlONmdLdlhUaWNJTnYzckhlSUhZQUJSWTRiemkrNllmZDlU?=
 =?utf-8?B?ZEkrdGVDVHBuVVI2VWdKWG9zWU1pa1Z3WGVLT0RBajhRWXMraUhveWowWXly?=
 =?utf-8?B?a2dlT1lzdUpFNytaUTBDd1BVdVdrUHlhTmtOaHhNSUV6UlMyN0tMTG52c3Az?=
 =?utf-8?B?MDhnTEs2SkwvVCt3dXdVd1VGTlhnU216eE9tTTcvMjdVRGJ1WXMrWm54Q0hr?=
 =?utf-8?B?amZObk5ldVVBT0dQQTRTQWZTNkRjUVFlZU1SUytTMjBvY3pDeUpXS2g0eEtt?=
 =?utf-8?B?LzJaeXg0M2xLTlJZTy93RmtmdTNGRjRqbGZyYUtYbXhHOEZ2YTNLbk1zRjZv?=
 =?utf-8?B?Q0VLbWxIZE5oZjJMWjFZQi9iZlFnSWtqcG5ZQ3h5NUwzZWVUdHhuYk1nUS9p?=
 =?utf-8?B?cmY2UDE5Q1NsYlVxUzlFbSsxbyttc2NTbGJyUzh0cGZNNVpoQ3BpWXM5blZu?=
 =?utf-8?B?am02ZjdqMVNMTEhCdGVaZTFzOWZ5VWF0cVpONExkNHoyc1NrSHQ1ODRKV3Fa?=
 =?utf-8?B?d0Nud3loUVc0UUhHbUU5TlorMEtvRXRlUEFKQjBHTWZBeXhDUU41L3oySElF?=
 =?utf-8?B?UVRwVlBqRlovSmNrempKa1FaeFlHODZBNzRtNXFQQW1DMzV6TVpmd3AxTHBH?=
 =?utf-8?B?VGVBZmhRUHVCWWFjS1I4aFRSY0JtM0c3RXNMS1JGSVQrZEM5NHN1Sm85WFhQ?=
 =?utf-8?B?cyt6d3pWR3JncVhaazZuK3ZXRnlVV0tMWGh6RTNQNWpOVm5kOVVQejFlbnNy?=
 =?utf-8?B?UW44dEdaSWlZem14bkNiOFExL1JQRTY4dDNpVDZLakk1dkRYS0VyUktnZzA5?=
 =?utf-8?B?RU9BSjZaYnFJcnVBWk9BdU53ZDBBdUY5Wk82b2ZEeWVwbFdZdVhYVVlMRm1I?=
 =?utf-8?B?bUhyeG4zUkJaMnFHb1ZKamNibnlYOXZadzkveDJaSzRpSy93dWJCNWZJWHV1?=
 =?utf-8?B?TmxjaTlFWHEreDlhZXZnRUxCbTIyUmwxNGdiYjJOT1YyVTIrQkl0UkZjNHdV?=
 =?utf-8?B?SmRRUmQrelE3cGdjaXBrbGRla0Vpd2tGalZWTy9qT21iZ1BKNjFxU2hYaE5u?=
 =?utf-8?B?RVhhQ2ZjSmFrSE00dGp4cmczQW5lREdzd0JmSjJHaC9ZRndMcXJPZnc4SElQ?=
 =?utf-8?B?YUVnNTVWMm5tdkREZnRBMm12WFhpVU9LQVFGeVJ0U3g4N1QxMHdWZUY1QWg2?=
 =?utf-8?B?dGpORnZ6ZEZsaXJxamswOXFvc09CZEF4QlVKdDRCNUIrelJQNzc0R1hpNjlL?=
 =?utf-8?B?dnVZTEIybmIrSUptcnVjWC9EajhFQWR4bTlqUVBrd1pyVkFoVVJXeW1WZlFm?=
 =?utf-8?B?Q0wzd2xZdEJLTVlqQXJDTFhCUzB4T3JoYjluVEVZVXplNUd1OGNOWi9SUmgy?=
 =?utf-8?B?T0tSWHJwR2JZVnJzU2xnenphSmVYdTVoOENUV1QvSFpnTDQ3QklmOFkxeHh3?=
 =?utf-8?B?Wk5rYnQyQkJLSDhtS3pPak15dmg2MnR2OHpkUVp3WDBMWTJDRjBMMS9WNm4r?=
 =?utf-8?B?aG8zOU1ldnV1S3ZSamlnT2NaSVI5T2wzeGNaeUxVcnNkT2RPbUV6KzBNY0lO?=
 =?utf-8?B?SUlHU1lEMGpEOHNmYy9lYld1NHRlOUExdkVTSkpyTGxlMHpKaGhnNlM3UWtY?=
 =?utf-8?B?K0JhMm5SaTg4eHBPY2ZmTGxnVVBhSjg2cS9jZFoxNVFvdUlqUHJOZ2x6ajFH?=
 =?utf-8?B?cEdYN0x6M2pvZGMxNFJjSVhWeGpBNWNxcHhpcVhoZkVYRmM2VC81OGNxemp6?=
 =?utf-8?Q?i8g4SlT1ve5o/xxVhWjLY2k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8655.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnVOTkg2a1J3V1lRa3dXOHFiWG01eEtReW5yeEtMTVV4cC9sTHJRc21ab1ZK?=
 =?utf-8?B?OFNoVUpkOVB3bkx3SFprS1cweDZqRmx3R3hXYURKQVphSTlKYkFVdm5sM0hj?=
 =?utf-8?B?elBoYlM0S1JGOGZ6dWVQYkxBajM3ZFRMUW1haEdDaHJZSWZhRWlnZ3dRZ1Rw?=
 =?utf-8?B?emJJNHg4Yy83WHVubG1KWnUxdEFFRG5yazR5Z3ZnY3Jpa3ExczhYSDN5T1hL?=
 =?utf-8?B?L0NrN2ZDYmJranQ1STRnN3NYcTBZRExHdXJ4Z01NKzR6MWdPVUFsN3ZEVWM0?=
 =?utf-8?B?a2hBWTlONzROV2lUZWc0OWNScmc2RkJ3SHRPL1poREJCNlhZRlhWanJwbUhS?=
 =?utf-8?B?Z0twNlJ0bVB6N2dETHFQRVk5ZEdscHpqV2p6aTRKR0U5ZlI2ZmRaSXdDdWRw?=
 =?utf-8?B?YjBwd0FxeWNETEY5WWZyUTY2amVQRkVadmtqQ0pQNlVORjJmTkE1b2lnc0xP?=
 =?utf-8?B?cWI1T254WU9scGkrZXdhVTJsc3hjcDN4NVRtKzZwMFhaanhJSUp1QW1OMk1i?=
 =?utf-8?B?Y0lobExDMnhvMUdLU0l3MFN6YXBBamdSWU55d2R0eXVYOXRjZWN0N21DYzJS?=
 =?utf-8?B?QmZZdTg5U0cxV3ZpUDhRSUNjbVMyYm1UcFBRZGRyOWdueGZMc1h1Zm1Ydk9W?=
 =?utf-8?B?ZkJQdmxCY3UyVklIbldQT1lBclloYmM2ZWlGeFRGdE9SNlVEaDdDbXUyVUht?=
 =?utf-8?B?d0lrOEM1NXFEOGp6a05pa1ZkK00rN1lGRzdrUDBCMlIzYTA3QWNkQkFUTzdr?=
 =?utf-8?B?bDNBTjJsSkNCYzk0aTJkMUIwSFlPdmh2QWhOYkU1b3NkVjBNeDVSeU50TnE4?=
 =?utf-8?B?NVNXclRlSGFLTURJT0lQVGY0elJVc0U3NmFCSUtmR0h3cjBaYjZsVnZDRjJj?=
 =?utf-8?B?d0x2bndrckNDcmR2akV2MTJHMVZwbFF4VENuY2drWjZPcUUyT2EzVTVQdzd3?=
 =?utf-8?B?Zk0rdGRhVFFYSFUwVjRnUjJPZEx4Q2NuZmV3UlYrSS9BVk10NXBiVEJaWVpC?=
 =?utf-8?B?RFEvdTgxVHREWEtRcm8vNWJDK29jYzVUaXlGek5DTUpTbFlEb2lGNmVnSXpI?=
 =?utf-8?B?Mk9xUDB6d2JWTUVYb3pDcTFtdjV5L0NBQVkxQlNMSURNMHVXWkZiQnBmYXJu?=
 =?utf-8?B?MjIrRDZrSEJYUFlQVVZqcTRTLytsYnFvN2FwRkV2K05wdkUzRFRqS29pSkRu?=
 =?utf-8?B?aHI2U1Y4K3c2U2cwNGFlY0lqOU1sa24zQWFKSmJLL3A3cE4vSUxBQUJubE04?=
 =?utf-8?B?WVV2ZEl1eFN0QVRqVlR2TGZJNmhYRlgvWTEvQlBISkk4V0hWNmkyOXU3MkxP?=
 =?utf-8?B?STEwbmVZUkduREthZGRiZ2FKS2JJOHJSNmcxQ1RZRW8yWm1DQ1FSRHNWOUpU?=
 =?utf-8?B?OHJzZDR3cDBjRHJCYU92TFFYSjlnZldKdFR1VjNaeTJ4Y2pKTTFaaE9keUlR?=
 =?utf-8?B?cE5RUmVHOXp0U3poWlFkcnBhTDRsdG9SbzlGSm5ldmRpQ0lyM0tEd3MzRUZj?=
 =?utf-8?B?S01hUVRDWW1PTytRQXh3THhXZkozTnRMZkpRYklOZGNCejk1eEg5MXNXOTMy?=
 =?utf-8?B?Y3V2TGhLWEV1Z2xvYng5U2M0eEFSaTI5R1gxZjFPTE1ZbnRpdVFKekZVMWRD?=
 =?utf-8?B?SEx3Ykp3R1hzL1hHS01tdGYrVjc4Und0OVQvUkFkcEVQUm04d09sRlQ4S2Yr?=
 =?utf-8?B?VVhGdlpheXIyS3BtbFpNRW9KWVdXOXN1NnlkWVRibGZKb1YxUHR6OE14QmtX?=
 =?utf-8?B?YVh4c2JXaTN4RFI2UUZpU3hIMXBOT0lpTVJ0SFlzNW9tT2lZVEZlZHFheHV2?=
 =?utf-8?B?aC9rTUJ6clJQSGQ5YTlJUmNlejMrdnFPL0FmdUpCUzY5Zk9kWjZFQnBHSUta?=
 =?utf-8?B?WXU1S3JJcHMwSXpxZHNyVjh1UzNKNFpwdVQyYkljcUxQbGtUZzZSY25hV0pD?=
 =?utf-8?B?TjUzdFF3d3NHSDdaM3Rmb21XRko0RWoyMDJCUUhMczFRc0lKQ1ZFNGtTVDYr?=
 =?utf-8?B?bG5EZ2xnbFE0L3YwOC9XSGhMNSsxSDlEazdtWDBpRk5MVkhsTllLZzZLem9Q?=
 =?utf-8?B?ZklmbzJWdzh2UmxFTms5VHZlYVY4bG9oNjd3Ukg2Q25WY3VmdmhlcCs0clo5?=
 =?utf-8?B?cGlEWldOV1BvdzhDbzFLbzRJK1Y3cERiK1dubVJ3cWZkRVV6UHJYWitBWFpP?=
 =?utf-8?B?UUtwd0NIdWUrRm9IZGN6MTZCNnp4TXRXNWtjbTVzS3FyNDNzTlBXRGc4SDMv?=
 =?utf-8?B?RlQvTWZLd1dnN3hXUkFtdncvSDQzS1lTYkMvRjdBK3lHZEJEbDBQb2tmeVd1?=
 =?utf-8?Q?tm9tGGtPOb0v2hb+PI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c65ed4f2-7188-4b04-dda8-08de66c085ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2026 03:16:59.5306 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svZT2vRO82nNps3bWB4ZLxhOrpHNFa9ebWwbPdHviottepFsEoFw1zO2kBcyb82y7Wz3inkVuAV5jyVrC4c/7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KIEhpIEFsZXgsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxl
eCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgRmVicnVh
cnkgNiwgMjAyNiA1OjM3IEFNDQo+IFRvOiBZdWFuLCBQZXJyeSA8UGVycnkuWXVhbkBhbWQuY29t
Pg0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsg
YW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywgWWlmYW4gPFlpZmFuMS5a
aGFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDA3LzIyXSBEb2N1bWVudGF0aW9u
L2FtZGdwdTogQWRkIGRvY3VtZW50YXRpb24gZm9yIFBlYWsNCj4gVG9wcyBMaW1pdGVyIChQVEwp
IHN5c2ZzIGludGVyZmFjZQ0KPg0KPiBPbiBUaHUsIEZlYiA1LCAyMDI2IGF0IDExOjU34oCvQU0g
UGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoZSBQVEwg
KFBlYWsgVG9wcyBMaW1pdGVyKSBmZWF0dXJlIGV4cG9zZXMgcGVyLUdQVSBzeXNmcyBmaWxlcyB1
bmRlcg0KPiA+IC9zeXMvY2xhc3MvZHJtL2NhcmRYL2RldmljZS9wdGwvIHRvIGFsbG93IHVzZXJz
IHRvIGVuYWJsZSBvciBkaXNhYmxlDQo+ID4gUFRMLCBjb25maWd1cmUgcHJlZmVycmVkIGRhdGEg
Zm9ybWF0cywgYW5kIHF1ZXJ5IHN1cHBvcnRlZCBmb3JtYXRzLg0KPiA+IFRoZSB1c2FnZSBvZiB0
aGVzZSBzeXNmcyBmaWxlcyBpcyBub3QgYWx3YXlzIG9idmlvdXMsIHNvIGFkZA0KPiA+IGRvY3Vt
ZW50YXRpb24gdG8gZGVzY3JpYmUgdGhlaXIgcHVycG9zZSBhbmQgcHJvdmlkZSBjb25jcmV0ZSB1
c2FnZSBleGFtcGxlcy4NCj4gPg0KPiA+IFYzIGNoYW5nZXM6DQo+ID4gICogZm9ybWF0IHNob3cg
d2lsbCBkaXNwbGF5IHByZWZlcnJlZCBmb3JtYXRzIGluc3RlYWQgb2YgTi9BIChBbGV4KQ0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVycnkgWXVhbiA8cGVycnkueXVhbkBhbWQuY29tPg0KPiA+
IFN1Z2dlc3RlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9pbmRleC5yc3QgfCAgMSArDQo+ID4g
IERvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9wdGwucnN0ICAgfCA5NA0KPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA5NSBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2dwdS9hbWRncHUvcHRsLnJz
dA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9pbmRleC5y
c3QNCj4gPiBiL0RvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9pbmRleC5yc3QNCj4gPiBpbmRleCA4
NzMyMDg0MTg2YTQuLmIyYWIxODIyMzZlZiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2dwdS9hbWRncHUvaW5kZXgucnN0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1
L2luZGV4LnJzdA0KPiA+IEBAIC0yMywzICsyMyw0IEBAIE5leHQgKEdDTiksIFJhZGVvbiBETkEg
KFJETkEpLCBhbmQgQ29tcHV0ZSBETkENCj4gKENETkEpIGFyY2hpdGVjdHVyZXMuDQo+ID4gICAg
IGRlYnVnZnMNCj4gPiAgICAgcHJvY2Vzcy1pc29sYXRpb24NCj4gPiAgICAgYW1kZ3B1LWdsb3Nz
YXJ5DQo+ID4gKyAgIHB0bA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dwdS9hbWRn
cHUvcHRsLnJzdA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9ncHUvYW1kZ3B1L3B0bC5yc3QNCj4gPiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzdmMTZkZWE3OTU0
DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZ3B1L2FtZGdwdS9w
dGwucnN0DQo+ID4gQEAgLTAsMCArMSw5NCBAQA0KPiA+ICs9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0NCj4gPiArUGVhayBUb3BzIExpbWl0ZXIgKFBUTCkgc3lzZnMgSW50
ZXJmYWNlDQo+ID4gKz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
ICsNCj4gPiArT3ZlcnZpZXcNCj4gPiArLS0tLS0tLS0NCj4gPiArVGhlIFBlYWsgVG9wcyBMaW1p
dGVyIChQVEwpIHN5c2ZzIGludGVyZmFjZSBlbmFibGVzIHVzZXJzIHRvIGNvbnRyb2wNCj4gPiAr
YW5kIGNvbmZpZ3VyZSB0aGUgUFRMIGZlYXR1cmUgZm9yIGVhY2ggR1BVIGluZGl2aWR1YWxseS4g
IEFsbA0KPiA+ICtQVEwtcmVsYXRlZCBzeXNmcyBmaWxlcyBhcmUgbG9jYXRlZCB1bmRlcg0KPiA+
ICtgL3N5cy9jbGFzcy9kcm0vY2FyZFgvZGV2aWNlL3B0bC9gLCB3aGVyZSBgWGAgaXMgdGhlIEdQ
VSBpbmRleC4NCj4gPiArVGhyb3VnaCB0aGVzZSBmaWxlcywgdXNlcnMgY2FuIGVuYWJsZSBvciBk
aXNhYmxlIFBUTCwgc2V0IHByZWZlcnJlZCBkYXRhDQo+IGZvcm1hdHMsIGFuZCBxdWVyeSBzdXBw
b3J0ZWQgZm9ybWF0cyBmb3IgZWFjaCBHUFUuDQo+ID4gKw0KPiA+ICtQVEwgc3lzZnMgZmlsZXMN
Cj4gPiArLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtUaGUgZm9sbG93aW5nIGZpbGVzIGFyZSBhdmFp
bGFibGUgdW5kZXIgYC9zeXMvY2xhc3MvZHJtL2NhcmRYL2RldmljZS9wdGwvYDoNCj4gPiArDQo+
ID4gKy0gYHB0bF9lbmFibGVgDQo+ID4gKy0gYHB0bF9mb3JtYXRgDQo+ID4gKy0gYHB0bF9zdXBw
b3J0ZWRfZm9ybWF0c2ANCj4gPiArDQo+ID4gK1BUTCBFbmFibGUvRGlzYWJsZQ0KPiA+ICstLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiArRmlsZTogYHB0bF9lbmFibGVgDQo+ID4gK1R5cGU6IFJlYWQv
V3JpdGUgKHJ3KQ0KPiA+ICsNCj4gPiArUmVhZDogUmV0dXJucyB0aGUgY3VycmVudCBQVEwgc3Rh
dHVzIGFzIGEgc3RyaW5nOiBgZW5hYmxlZGAgaWYgUFRMIGlzDQo+ID4gK2FjdGl2ZSwgb3IgYGRp
c2FibGVkYCBpZiBpbmFjdGl2ZS4NCj4gPiArDQo+ID4gK1dyaXRlOg0KPiA+ICsNCj4gPiArLSBX
cml0ZSBgMWAgb3IgYGVuYWJsZWRgIHRvIGVuYWJsZSBQVEwNCj4gPiArLSBXcml0ZSBgMGAgb3Ig
YGRpc2FibGVkYCB0byBkaXNhYmxlIFBUTA0KPg0KPiBJZGVhbGx5IGBlbmFibGVgIG9yIGBkaXNh
YmxlYCwgSS5lLiwgZHJvcCB0aGUgImQiLg0KPg0KPiBBbGV4DQoNCkNvdWxkIHdlIHJldGFpbiB0
aGUgY3VycmVudCAnZW5hYmxlZCcgYW5kICdkaXNhYmxlZCcgc3RhdGVzPyAgV2hpbGUgdGhleSBt
YXkgbm90IGJlIGlkZWFsLCBjaGFuZ2luZyB0aGVtIHdvdWxkIGJyZWFrIGNvbXBhdGliaWxpdHkg
d2l0aCB0aGUgYW1kLXNtaSB0b29sIHRoYXQgYWxyZWFkeSBoYXMgYmVlbiByZWxlYXNlZCB0byB1
c2VyLg0KDQoNClRoYW5rcy4NClBlcnJ5Lg0KDQo+DQo+ID4gKw0KPiA+ICtFeGFtcGxlczo6DQo+
ID4gKw0KPiA+ICsgICAgIyBRdWVyeSBQVEwgc3RhdHVzDQo+ID4gKyAgICBjYXQgL3N5cy9jbGFz
cy9kcm0vY2FyZDEvZGV2aWNlL3B0bC9wdGxfZW5hYmxlDQo+ID4gKyAgICAjIE91dHB1dDogZW5h
YmxlZA0KPiA+ICsNCj4gPiArICAgICMgRW5hYmxlIFBUTA0KPiA+ICsgICAgc3VkbyBiYXNoIC1j
ICJlY2hvIDEgPiAvc3lzL2NsYXNzL2RybS9jYXJkMS9kZXZpY2UvcHRsL3B0bF9lbmFibGUiDQo+
ID4gKw0KPiA+ICsgICAgIyBEaXNhYmxlIFBUTA0KPiA+ICsgICAgc3VkbyBiYXNoIC1jICJlY2hv
IDAgPiAvc3lzL2NsYXNzL2RybS9jYXJkMS9kZXZpY2UvcHRsL3B0bF9lbmFibGUiDQo+ID4gKw0K
PiA+ICtQVEwgRm9ybWF0IChQcmVmZXJyZWQgRGF0YSBGb3JtYXRzKQ0KPiA+ICstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtGaWxlOiBgcHRsX2Zvcm1hdGANCj4gPiAr
VHlwZTogUmVhZC9Xcml0ZSAocncpDQo+ID4gKw0KPiA+ICtSZWFkOiBSZXR1cm5zIHRoZSB0d28g
cHJlZmVycmVkIGZvcm1hdHMsIGUuZy4gYEk4LEYzMmAuDQo+ID4gKw0KPiA+ICtXcml0ZTogQWNj
ZXB0cyB0d28gZm9ybWF0cyBzZXBhcmF0ZWQgYnkgYSBjb21tYSwgZS5nLiBgSTgsRjMyYC4NCj4g
PiArDQo+ID4gKy0gQm90aCBmb3JtYXRzIG11c3QgYmUgc3VwcG9ydGVkIGFuZCBkaWZmZXJlbnQu
DQo+ID4gKy0gSWYgYW4gaW52YWxpZCBmb3JtYXQgaXMgcHJvdmlkZWQgKG5vdCBzdXBwb3J0ZWQs
IG9yIGJvdGggZm9ybWF0cw0KPiA+ICthcmUgdGhlDQo+ID4gKyAgc2FtZSksIHRoZSBkcml2ZXIg
d2lsbCByZXR1cm4gIndyaXRlIGVycm9yOiBJbnZhbGlkIGFyZ3VtZW50Ii4NCj4gPiArDQo+ID4g
K0V4YW1wbGVzOjoNCj4gPiArDQo+ID4gKyAgICAjIFF1ZXJ5IFBUTCBmb3JtYXRzDQo+ID4gKyAg
ICBjYXQgL3N5cy9jbGFzcy9kcm0vY2FyZDEvZGV2aWNlL3B0bC9wdGxfZm9ybWF0DQo+ID4gKyAg
ICAjIE91dHB1dDogSTgsRjMyDQo+ID4gKw0KPiA+ICsgICAgIyBTZXQgUFRMIGZvcm1hdHMNCj4g
PiArICAgIHN1ZG8gYmFzaCAtYyAiZWNobyBJOCxGMzIgPiAvc3lzL2NsYXNzL2RybS9jYXJkMS9k
ZXZpY2UvcHRsL3B0bF9mb3JtYXQiDQo+ID4gKw0KPiA+ICtTdXBwb3J0ZWQgRm9ybWF0cw0KPiA+
ICstLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICtGaWxlOiBgcHRsX3N1cHBvcnRlZF9mb3JtYXRzYA0K
PiA+ICtUeXBlOiBSZWFkLW9ubHkgKHIpDQo+ID4gKw0KPiA+ICtSZWFkOiBSZXR1cm5zIGEgY29t
bWEtc2VwYXJhdGVkIGxpc3Qgb2Ygc3VwcG9ydGVkIGZvcm1hdHMsIGUuZy4NCj4gPiArYEk4LEYx
NixCRjE2LEYzMixGNjRgLg0KPiA+ICsNCj4gPiArRXhhbXBsZTo6DQo+ID4gKw0KPiA+ICsgICAg
IyBDaGVjayBzdXBwb3J0ZWQgZm9ybWF0cw0KPiA+ICsgICAgY2F0IC9zeXMvY2xhc3MvZHJtL2Nh
cmQxL2RldmljZS9wdGwvcHRsX3N1cHBvcnRlZF9mb3JtYXRzDQo+ID4gKyAgICAjIE91dHB1dDog
STgsRjE2LEJGMTYsRjMyLEY2NA0KPiA+ICsNCj4gPiArQmVoYXZpb3JhbCBOb3Rlcw0KPiA+ICst
LS0tLS0tLS0tLS0tLS0tDQo+ID4gKy0gUFRMIGZvcm1hdHMgY2FuIG9ubHkgYmUgc2V0IHdoZW4g
UFRMIGlzIGVuYWJsZWQuDQo+ID4gKy0gSWYgUFRMIGlzIGRpc2FibGVkLCBgcHRsX2Zvcm1hdGAg
cmV0dXJucyBgTi9BYC4NCj4gPiArLSBPbmx5IHR3byBmb3JtYXRzIGNhbiBiZSBzZXQgYXQgYSB0
aW1lLCBhbmQgdGhleSBtdXN0IGJlIGZyb20gdGhlIHN1cHBvcnRlZCBzZXQNCj4gYW5kIGRpZmZl
cmVudC4uDQo+ID4gKy0gQWxsIGNvbW1hbmRzIHN1cHBvcnQgcGVyLUdQVSB0YXJnZXRpbmcuDQo+
ID4gKy0gUm9vdCBwZXJtaXNzaW9uIGlzIHJlcXVpcmVkIHRvIGVuYWJsZS9kaXNhYmxlIFBUTCBv
ciBjaGFuZ2UgZm9ybWF0cy4NCj4gPiArLSBJZiB0aGUgaGFyZHdhcmUgZG9lcyBub3Qgc3VwcG9y
dCBQVEwsIHRoZSBQVEwgc3lzZnMgZGlyZWN0b3J5IHdpbGwNCj4gPiArbm90DQo+ID4gKyAgYmUg
Y3JlYXRlZC4NCj4gPiArDQo+ID4gK0ltcGxlbWVudGF0aW9uDQo+ID4gKy0tLS0tLS0tLS0tLS0t
DQo+ID4gK1RoZSBQVEwgc3lzZnMgbm9kZXMgYXJlIGltcGxlbWVudGVkIGluDQo+IGBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNwLmNgLg0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+
ID4NCg==
