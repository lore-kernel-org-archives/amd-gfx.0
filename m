Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861FAEDF176
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Feb 2026 16:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231C110E819;
	Fri, 13 Feb 2026 16:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W8fUrCv5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011057.outbound.protection.outlook.com
 [40.93.194.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3531E10E820
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Feb 2026 16:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpUtKx3B8M1PaDzzvfjbhPqeuL+3tJYMvpb6NY+vdWj93dEobXSmzflGf7nrSF9yWWJorVpISiAOswSNo4rUWNCRJtI+aZvC05RXeFI1T5N9C06eC+95820rGQ5I+xLCZQnQODa4P9CxVTPZUCgvQJTc5z2A3ZeJdE1rqBzWqTiis8SSI+pdmgbNsDR/MBWS8B/mkFlVqC4k8bP1nWkvSwVKLaBUH15caF5oBsKxCgwiVKCrA/iTGX70YDpDzyGWgYelLpSZfAaIMmlCEIxDokmm1dddqUAZA86cX1tjcdaHBNhOCzpqphRpkZDW8h0EKlW8QvgtEdbe3fBzTypW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2SN3fwDsW3ZJJsZuPQdw89B9XOnOLi93g4HPkuM3qA=;
 b=dyaM8Jj/t5xCbpI080Llndm0Ym/+qQGe7nM4jMoFXALcxn9AKz9ABduk2heWpgEun8emYyAYikn2NHkFFuKZqT/C90WU9A9JudSUvSEfJlnPlZmb3i2Lmi/ylNwePYd+45u5o4dK1pNsXZvBVGy4/SIbnEaBAbu0BPJcZu4lPwolg9HXfwNoRJxhD7tOxWldrrYZFHygvLYBSwm+ETfVWnNZ/2klC/zsOxiqBHHUy7kNED9ZMUBUXg28P3xpE/ZZFLzZxeWwsoBuq7Ad2ANhrnQwWNj/bcfMTzM2q4UHkirm+0T3gnCVVr9Nbm7t0TSelVyShCdl0JJnSDdAB5700Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2SN3fwDsW3ZJJsZuPQdw89B9XOnOLi93g4HPkuM3qA=;
 b=W8fUrCv5OwEh87nG+PCcPpC7E0qo2ol7Q3JU12k+W1tYCQvQJ/hjT7QvxcVGPTgmHwPDzTdd5BCK/frp/y97WjkeoXIgtN6Bpr/y9SzGj8BSnSqOEZXclAMOn2f00Ux9ifJD88hosCUi9cKn4nNpmeQxYAnwY7sYFn1PjhRhWFk=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 16:06:18 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 16:06:18 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Greathouse, Joseph"
 <Joseph.Greathouse@amd.com>
Subject: RE: [PATCH v2] drm/amdkfd: Disable MQD queue priority
Thread-Topic: [PATCH v2] drm/amdkfd: Disable MQD queue priority
Thread-Index: AQHcnFfUIGbOTMOt50e7UmJaP0boRrWAyp2AgAABZFA=
Date: Fri, 13 Feb 2026 16:06:18 +0000
Message-ID: <SJ0PR12MB8138EA9CC81348CEC9AAD0EAF561A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20260212194256.33118-1-andrew.martin@amd.com>
 <cf04d6f0-641f-4084-a74d-9128f58c2c83@amd.com>
In-Reply-To: <cf04d6f0-641f-4084-a74d-9128f58c2c83@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-13T16:03:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|DS0PR12MB9037:EE_
x-ms-office365-filtering-correlation-id: 79216144-7d07-40e7-6e0d-08de6b19d286
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?N0tVNVRMdEx5NFJLdkZWLytacXVUNHVkbGowcTd3b2twV21odC9FUll0Q3Zx?=
 =?utf-8?B?RUNnc0VpU1lBUzBzQ0l5YmlYdVlQaWsrWWtKeWhXVklzdVZDTUFoanN6ZjMv?=
 =?utf-8?B?Q0p1Q3l6aWhBVVZQSWk1NE9laEp5bG9rd3QvODZOdnhEUVNPR0V4ZzNZenhP?=
 =?utf-8?B?RE00RkdIVGN4WjhDWisrM3NTRHVzZ1owUHE1K3I2MjRTOTZ1QVlqTmszTnRC?=
 =?utf-8?B?T0pnVmJtaU5waXhVZFJnL1hPMkppR0JHODRhSndjT05KWWlrU0phbFNWdzhP?=
 =?utf-8?B?bElnMldqMGs3WUZPa0FvWXZrSlhFekpETG51MUFmYkF4ckdMSFdoNWd4eEZG?=
 =?utf-8?B?VEx4VllFMzJxZ0s4MUI4VE5YTlZieFc3RXAyZTk2elIrS0xmSWlSYy82ekQx?=
 =?utf-8?B?eERINXVuVEVGNmNQSEhGazQ0RUZJZjJpWVJLTDgwUVZEN2ptR0pROUpOLytz?=
 =?utf-8?B?TUlxa1BPcUNnMFNrTTgyWDUyUUl1NmwrY3gwSldlY3Z1a05LVi9DWDVGTWpv?=
 =?utf-8?B?SmRyak95NXBBT3hEMUFJem5IaXZuRkZuZmNEb3RPTGkxaGM3bnJzdlpBd283?=
 =?utf-8?B?d2RDeFhHVzh4N2JaS1dBLzFWTUFSUzJzTDVtRGxGOWh3OHVTRmxtWXV5NHJJ?=
 =?utf-8?B?Y3V2RFNORThiMlBBbzJNK3VCYmZ3K29UdGgzb3JhV29RL29NbHk1U1kzNWxy?=
 =?utf-8?B?ZFkrbndQemlvS0NUa3k5M2dYT2xvS3lwTVRPWTd3NFYyWE0zeUJ3RGJYZkN1?=
 =?utf-8?B?bnI5R1QxL1UwMHhjZ3RoQ0gxSVQ3UnBhNGJNYjVxYXJFa2hHREM4NnBJbmZG?=
 =?utf-8?B?SHorUER3UTF5VXJ6cndNUHVuZzErcU4wdmgzUnJ5d1E5Vk14SjVyb3RxN0Fn?=
 =?utf-8?B?RGorb2dyUDc1N2QxR3F4TnNnNGlkWjJwRVlOTzh1SGxiS0xtdFJVd1RHWDN5?=
 =?utf-8?B?RDlRcFVVbndFNlh0dGtkaWRUY3RWMzRjR0YyWVZnR1QwYUZxUUp3bFJVNE44?=
 =?utf-8?B?Tm8zZFVPeXVvWlQ2UHFCbE5FMml1eThrYVl2UFhDNzlTVGJjekdSa0lKZG54?=
 =?utf-8?B?UngxTzFORFRrOTFnTmVRb2JKMzJMWlkyWGFmQzlKMzlvc1V4Y2orSjJXaTZD?=
 =?utf-8?B?VU1SOHFxNEZSRTk4dlg2YUFuLzJoRHp4NlR4NWZsbzZSb3JBUE0ydWwwZmw5?=
 =?utf-8?B?NnlYU21oMHJ5ZTBVWEd2dk52OVFrTytaeHF2MVp3dC9UaDh3MGg5RlRZbWV1?=
 =?utf-8?B?VVZnd3V2VUludmpHanBkMm94YzZGekprSG9YczE3VkVSVmtoQWo1a2NmMkhS?=
 =?utf-8?B?RElRV1pLNElaTkxHcGVGVGd2eGozaDlBNGE2amdUbm5UeC9TT25vUEdOM1NW?=
 =?utf-8?B?bFFSM0FMdnRtNXhYNUIwdTJxQmU3NkZ3K2dPcjVRMUJNMXVUSUJGeEZTZ2h1?=
 =?utf-8?B?RjBiOGFJemY1Y1FTamg3am8rRUtwTVJJUUE4QVZIN082YzZTcVNYZHMrSmNN?=
 =?utf-8?B?TU5MMjRzSlk2R1pUc3lSUHI5cUZrUXN5TGZDYW1tcndHcG5JVkFjejVSbUw1?=
 =?utf-8?B?NWJZMmZqYXdwcWxhcW5JcjBNR0dDMlZpTm5LendhWFhJNW8rWnFNdUdUWTNj?=
 =?utf-8?B?T0pNdU9jenJZTm5rNVpRb3k3eFVzWVVvWmEvUHIxd25nRmo2WEx6SWoyTk9n?=
 =?utf-8?B?V0VkV2pNL0tSdko2Q1dUWm1ndUZMbGdJMVhrSDhQOUVCVUowMUNzSW9HTkhD?=
 =?utf-8?B?bmhzaXN6bFpXTHA2TWZtV1BDSEtNWHA3UUhCVG1hdEtSdUZoK3l0ZjdVUEg3?=
 =?utf-8?B?aE9ZRzh6MzhrcHZDYUVwRUt5eTRqRlB3bGxvUlRUc2FjR0w0SlpxQVpjdE5W?=
 =?utf-8?B?UFJLelVHUHBlRWFWYTZhSi9WYmZUaklybGJDd1RwRzhNelVzVWlteGhVKzBn?=
 =?utf-8?B?Z2syZEZYNmlSQzA3OHlPa0RGeEpzZW1POS9jd1U2ckV1QzVIcDNHbTAvM3dj?=
 =?utf-8?B?UzJQeWlDRlBoWkN0anBKVlRpbmt2MllOc1BPNXVObWZodUtUemhCMXlocFJa?=
 =?utf-8?B?UWZHTU5XR2JFM25qczVJS2tuRC9EYk56U3I5UG8yRWtkM0dGUEdkRGVZQnA5?=
 =?utf-8?B?WmNpNUZWRjBWTEo4dFlPWGFkZ1NYU0RHV2p0UDNrV2pCaUxEOWxWY2swTHpi?=
 =?utf-8?Q?6Mnwe5jfh0UyQMJd7XrmbHs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1o3VzR0TjRIVEs5b3NxZGV3SGM4aWMxL04rdnF0U0FkSm5xWGZJSDN3QlVj?=
 =?utf-8?B?WHZ3WERNQ0lib2FJU2piSWMrZnhIWWJjVHNMNS80T2hTRjR0YnRxYnptQk8v?=
 =?utf-8?B?ZFNDWXR6S2VHd2tYTFlGVzY2QWllSnNHMEhzbkY4RGowc2F4aU5OeGwyUHhI?=
 =?utf-8?B?Y2tyQ3pkMTFsLzdrb2sxY2l0V0g3TjdxQXFLdUZneG5uT0tzWitGUWJTWXRu?=
 =?utf-8?B?UzU2cGhZOGxieHIraVlwTjIvOFdSdStGUTRJbnNwQ1FLK0pjNDJyL2hDVWhD?=
 =?utf-8?B?bWVmZTZQZ1Bic3EwR0pwUGt4ekVKazFrUFU3V2h2aW5qTGMxODRKTzdHWnpl?=
 =?utf-8?B?bzBtUjU3YVFrMU5YUEJxd2I2YUh0TThRNm5TdDJoTXRzL0hkbGpwYTYrSmpJ?=
 =?utf-8?B?ZVp6M0tkTjJOV0MxbzVuZHBNWEZYcUljNHczUnF4MmxpYzVlTWtIcUNaOWw2?=
 =?utf-8?B?dDNyVXpVQVJ1QmhVKzFscWFuV1dFRDNjVENoT1ZoZG12N1BrYXorNCtKQTJB?=
 =?utf-8?B?cHN2K3o4TlpnS3FPdWRORUVEU0I2YVVGYkVpTUVQN3BRNWZmN1krVC9GVG8w?=
 =?utf-8?B?a254RW04czNtZS96SC9iUDhXUmlGS2cxTjdRY1NjUGhxRisvVy9sVktyVHdY?=
 =?utf-8?B?dGxiL1RpaXdjSU1UZzh2Z2UwSFJhdlRIQWthMEFtbGhFd1FLRGZKcnlpbjFZ?=
 =?utf-8?B?OVM5bm5iSVROMGpteFg3UHFLS2lmSVRZTEd5aHp1SzFOYm5qRFVib3ZMRW1X?=
 =?utf-8?B?NlQzT3g0cFVxV2dsS2dDL0pVYUZWaFpXb2lJSUZaOExjN0tUeERGNFJxR0FV?=
 =?utf-8?B?dHVnYXplWmYwckM5Z3orVk5BemdyTjNHQjZwWnR2RUx4Vi8xQWFVL1RDR01v?=
 =?utf-8?B?S005Vm5xRlNpdkw1TVlDMHFOL1FvZ0d3SXFwcWpPTEk4dWIweXlOT0J2K2xL?=
 =?utf-8?B?Qy83eDgvTTc2ZitMdi9aak9peFpTbEg3a0JmOXVKbjdTalhGTWhjUjd4RXNn?=
 =?utf-8?B?U2dSYXUxV2tSbEJpVzFJMlVNeXFNSjdYWm5MaHBneHpmL0RoSzBmemhMRFRB?=
 =?utf-8?B?eUQxK2JPcFJwMWFXZUZvejBwV1MrbGVqcFc5WitoaW5qdW5USHNLbXhwTmJj?=
 =?utf-8?B?Z2pwTWJsS0NGUUc1NG1lMGc1ajB2V2hRRWd6b2l5UHVML3g3ODVtcXRDNUFN?=
 =?utf-8?B?OCt1S0l3OFphc29WdmhPc2Y4NEphSHFPS296a0FZK1Y0bGFtaW9NQWRjRERp?=
 =?utf-8?B?bFBhaG5qaVJJVy9lRjRKeklRZDNhcklZZ2lsWXJkY2pWN0ZiUkwwajVYOFJS?=
 =?utf-8?B?QlZCWlBYR2h2V0cxTTJFRmU5ZjNxRFNsanJpQlZnUkExSHUrRENjcDM2azNm?=
 =?utf-8?B?UnNJRk5QRWlBWWtaSzViVW1kSHBBVzN0TzhMWmo2d2t4Q3I0NVowN09YSTBv?=
 =?utf-8?B?VEFRdGt1aE5pazlETGh5MWduREdWVnJRck1wY1dRd0tUNjMwdzZFbHNSZUVD?=
 =?utf-8?B?U2l1eW5IMTNXTDhsbGxmZ2RBR2lMeXRvTTFoQlBSS3JaQmh5dFplREMrZHRM?=
 =?utf-8?B?czd3aStDdjcxSVppNk9CRUhlTlQ2aUhYL09PZ0kvQ1R1elNUcGFueXZHRllz?=
 =?utf-8?B?ZXhrVGlWRWFXSEF5VzRpQVprZnZ4NHJIeUdtdlBIY1k1a25lOVlENGdrUXVm?=
 =?utf-8?B?eitmNWVzQlpxSXMzTE9Rb0VmTmNSdTJBOWUybkxISGxCWkpGQlNsUXVmUzZj?=
 =?utf-8?B?d1F3OTlENnRXYndhRHpDenBaOEI4VFZ2Yjg5ZmlpbkFid1I4TTk0dmY2cEN6?=
 =?utf-8?B?REFielRCZEllQU9IUGRPSjFheittcGlHYXNOYUcyeGowYzM4NjhIL3A3WE9i?=
 =?utf-8?B?N0krYjVMZFUrTGt2RWtydXNCQnlmL0NzQ1NNQmZta215blVuOTBjS0hXMzd0?=
 =?utf-8?B?YTN5Nmp4WjhTanNmcEZNZU5uZ0tsUVhUZUpzZCtDQUJ4M0p1VVdKTWl3b0c4?=
 =?utf-8?B?UHZxZjJHanJhdnlsYmYzKzJFeTdyeVhmYm50S3lNZityQitjOW5kUnEwZGUy?=
 =?utf-8?B?RnlGSzZDTVBuMHBQMWREMFIranVtbGRKMTI2RHZXQ2tUMVV3bFBTL2JiUlZT?=
 =?utf-8?B?amxXalp4RTNJZzVWdGN3by9kcTVNRWZzc1d3elRIbkV5RDZCSGdZdUp5WEs4?=
 =?utf-8?B?eFp3V3dGbWgzOVZHV1ptMkhEaG9UK2tPUUdaMUFMUC9pbDQ3VU1kbGpDYTA5?=
 =?utf-8?B?S0dLdmU1Rm5DcDNsa1kvQzQ3bUxpaWtNSWZtdys2RlB1ZjAzc0JCVVpLTzdk?=
 =?utf-8?Q?7rAmSkaT7L+WsvemnB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79216144-7d07-40e7-6e0d-08de6b19d286
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 16:06:18.3117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7sKD26aEoKQpgMxcYO8J56mcnYK3p3pjy12Ob7lF/P823gwxNDZl2i90xLKUqjLckgyyVYc/yGNCJ+HIZWxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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
Cg0KR3JlZXRpbmdzIEBLdWVobGluZywgRmVsaXgNCg0KPiBQbGVhc2UgcmVtb3ZlIHRoZSBjb21t
ZW50ZWQgb3V0IGxpbmVzIGhlcmUgYW5kIGluIHRoZSBvdGhlciBmaWxlcy4gV2l0aCB0aGF0DQo+
IGZpeGVkLCB0aGUgcGF0Y2ggaXMNCj4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxm
ZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KDQpUaGFua3MsIHdpbGwgZG8hDQoNCk9uZSBsb3ZlLg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAxMywgMjAy
NiAxMDo1OSBBTQ0KPiBUbzogTWFydGluLCBBbmRyZXcgPEFuZHJldy5NYXJ0aW5AYW1kLmNvbT47
IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogQ29ybndhbGwsIEpheSA8
SmF5LkNvcm53YWxsQGFtZC5jb20+OyBHcmVhdGhvdXNlLCBKb3NlcGgNCj4gPEpvc2VwaC5HcmVh
dGhvdXNlQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRrZmQ6IERp
c2FibGUgTVFEIHF1ZXVlIHByaW9yaXR5DQo+DQo+DQo+IE9uIDIwMjYtMDItMTIgMTQ6NDIsIEFu
ZHJldyBNYXJ0aW4gd3JvdGU6DQo+ID4gVGhpcyBzb2x2ZXMgYSBwcmlvcml0eSBpbnZlcnNpb24g
aXNzdWUsIGNhdXNlZCBieSB0aGUgbGFuZ3VhZ2UgcnVudGltZQ0KPiA+IG1ha2luZyBoaWdoLXBy
aW9yaXR5IHF1ZXVlcyB3YWl0IGZvciBhY3Rpdml0eSBvbiBsb3dlci1wcmlvcml0eQ0KPiA+IHF1
ZXVlcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNYXJ0aW4gPGFuZHJldy5tYXJ0
aW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF9tcWRfbWFuYWdlcl9jaWsuYyAgIHwgMiArLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMC5jICAgfCAyICstDQo+ID4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjExLmMgICB8IDIgKy0NCj4gPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTIuYyAgIHwgMiArLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMl8xLmMgfCAy
ICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjku
YyAgICB8IDIgKy0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFu
YWdlcl92aS5jICAgIHwgMiArLQ0KPiA+ICAgNyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX2Npay5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4gPiBpbmRleCA5MGFjM2EzMGU4MWQu
Ljc2NDgzZDkxYWY5OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtm
ZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfbXFkX21hbmFnZXJfY2lrLmMNCj4gPiBAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMg
dm9pZCB1cGRhdGVfY3VfbWFzayhzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLA0KPiB2b2lkICptcWQs
DQo+ID4gICBzdGF0aWMgdm9pZCBzZXRfcHJpb3JpdHkoc3RydWN0IGNpa19tcWQgKm0sIHN0cnVj
dCBxdWV1ZV9wcm9wZXJ0aWVzICpxKQ0KPiA+ICAgew0KPiA+ICAgICBtLT5jcF9ocWRfcGlwZV9w
cmlvcml0eSA9IHBpcGVfcHJpb3JpdHlfbWFwW3EtPnByaW9yaXR5XTsNCj4gPiAtICAgbS0+Y3Bf
aHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7DQo+ID4gKyAgIC8qIG0tPmNwX2hxZF9x
dWV1ZV9wcmlvcml0eSA9IHEtPnByaW9yaXR5OyAqLw0KPg0KPiBQbGVhc2UgcmVtb3ZlIHRoZSBj
b21tZW50ZWQgb3V0IGxpbmVzIGhlcmUgYW5kIGluIHRoZSBvdGhlciBmaWxlcy4gV2l0aCB0aGF0
DQo+IGZpeGVkLCB0aGUgcGF0Y2ggaXMNCj4NCj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5n
IDxmZWxpeC5rdWVobGluZ0BhbWQuY29tPg0KPg0KPg0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0
aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9tcWQoc3RydWN0IG1xZF9tYW5hZ2VyICpt
bSwgZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9t
YW5hZ2VyX3YxMC5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21h
bmFnZXJfdjEwLmMNCj4gPiBpbmRleCA5NzA1NWY4MDhkNGEuLjAxODZiM2RlNjdjMCAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEw
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJf
djEwLmMNCj4gPiBAQCAtNzAsNyArNzAsNyBAQCBzdGF0aWMgdm9pZCB1cGRhdGVfY3VfbWFzayhz
dHJ1Y3QgbXFkX21hbmFnZXIgKm1tLA0KPiB2b2lkICptcWQsDQo+ID4gICBzdGF0aWMgdm9pZCBz
ZXRfcHJpb3JpdHkoc3RydWN0IHYxMF9jb21wdXRlX21xZCAqbSwgc3RydWN0DQo+IHF1ZXVlX3By
b3BlcnRpZXMgKnEpDQo+ID4gICB7DQo+ID4gICAgIG0tPmNwX2hxZF9waXBlX3ByaW9yaXR5ID0g
cGlwZV9wcmlvcml0eV9tYXBbcS0+cHJpb3JpdHldOw0KPiA+IC0gICBtLT5jcF9ocWRfcXVldWVf
cHJpb3JpdHkgPSBxLT5wcmlvcml0eTsNCj4gPiArICAgLyogbS0+Y3BfaHFkX3F1ZXVlX3ByaW9y
aXR5ID0gcS0+cHJpb3JpdHk7ICovDQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1Y3Qg
a2ZkX21lbV9vYmogKmFsbG9jYXRlX21xZChzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCBkaWZmDQo+
ID4gLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEx
LmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEu
Yw0KPiA+IGluZGV4IDdlNWE3YWI2ZDBjMC4uYzllMzk3MzY2NzgyIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTEuYw0KPiA+
IEBAIC05Niw3ICs5Niw3IEBAIHN0YXRpYyB2b2lkIHVwZGF0ZV9jdV9tYXNrKHN0cnVjdCBtcWRf
bWFuYWdlciAqbW0sDQo+IHZvaWQgKm1xZCwNCj4gPiAgIHN0YXRpYyB2b2lkIHNldF9wcmlvcml0
eShzdHJ1Y3QgdjExX2NvbXB1dGVfbXFkICptLCBzdHJ1Y3QNCj4gcXVldWVfcHJvcGVydGllcyAq
cSkNCj4gPiAgIHsNCj4gPiAgICAgbS0+Y3BfaHFkX3BpcGVfcHJpb3JpdHkgPSBwaXBlX3ByaW9y
aXR5X21hcFtxLT5wcmlvcml0eV07DQo+ID4gLSAgIG0tPmNwX2hxZF9xdWV1ZV9wcmlvcml0eSA9
IHEtPnByaW9yaXR5Ow0KPiA+ICsgICAvKiBtLT5jcF9ocWRfcXVldWVfcHJpb3JpdHkgPSBxLT5w
cmlvcml0eTsgKi8NCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIHN0cnVjdCBrZmRfbWVtX29i
aiAqYWxsb2NhdGVfbXFkKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIGRpZmYNCj4gPiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTIuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMi5jDQo+ID4gaW5k
ZXggYTUxZjIxNzMyOWRiLi4zYmJjMjY0OGY1MWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMi5jDQo+ID4gQEAgLTc3LDcg
Kzc3LDcgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21hc2soc3RydWN0IG1xZF9tYW5hZ2VyICpt
bSwNCj4gdm9pZCAqbXFkLA0KPiA+ICAgc3RhdGljIHZvaWQgc2V0X3ByaW9yaXR5KHN0cnVjdCB2
MTJfY29tcHV0ZV9tcWQgKm0sIHN0cnVjdA0KPiBxdWV1ZV9wcm9wZXJ0aWVzICpxKQ0KPiA+ICAg
ew0KPiA+ICAgICBtLT5jcF9ocWRfcGlwZV9wcmlvcml0eSA9IHBpcGVfcHJpb3JpdHlfbWFwW3Et
PnByaW9yaXR5XTsNCj4gPiAtICAgbS0+Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3Jp
dHk7DQo+ID4gKyAgIC8qIG0tPmNwX2hxZF9xdWV1ZV9wcmlvcml0eSA9IHEtPnByaW9yaXR5OyAq
Lw0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0
ZV9tcWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwgZGlmZg0KPiA+IC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMl8xLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92MTJfMS5jDQo+ID4gaW5kZXggZDA3
NzZiYTJjYzk5Li4wZDZiNjAxOTYyZWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3YxMl8xLmMNCj4gPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjEyXzEuYw0KPiA+IEBAIC0xMzEsNyAr
MTMxLDcgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21hc2soc3RydWN0IG1xZF9tYW5hZ2VyDQo+
ICptbSwgdm9pZCAqbXFkLA0KPiA+ICAgc3RhdGljIHZvaWQgc2V0X3ByaW9yaXR5KHN0cnVjdCB2
MTJfMV9jb21wdXRlX21xZCAqbSwgc3RydWN0DQo+IHF1ZXVlX3Byb3BlcnRpZXMgKnEpDQo+ID4g
ICB7DQo+ID4gICAgIG0tPmNwX2hxZF9waXBlX3ByaW9yaXR5ID0gcGlwZV9wcmlvcml0eV9tYXBb
cS0+cHJpb3JpdHldOw0KPiA+IC0gICBtLT5jcF9ocWRfcXVldWVfcHJpb3JpdHkgPSBxLT5wcmlv
cml0eTsNCj4gPiArICAgLyogbS0+Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7
ICovDQo+ID4gICB9DQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1Y3Qga2ZkX21lbV9vYmogKmFsbG9j
YXRlX21xZChzdHJ1Y3QgbXFkX21hbmFnZXIgKm1tLCBkaWZmDQo+ID4gLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYw0KPiA+IGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Y5LmMNCj4gPiBpbmRleCBkY2Y0YmJm
YTY0MWIuLmJjNGNlYmEzNTkwOCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdjkuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92OS5jDQo+ID4gQEAgLTEwNiw3ICsxMDYsNyBAQCBz
dGF0aWMgdm9pZCB1cGRhdGVfY3VfbWFzayhzdHJ1Y3QgbXFkX21hbmFnZXINCj4gKm1tLCB2b2lk
ICptcWQsDQo+ID4gICBzdGF0aWMgdm9pZCBzZXRfcHJpb3JpdHkoc3RydWN0IHY5X21xZCAqbSwg
c3RydWN0IHF1ZXVlX3Byb3BlcnRpZXMgKnEpDQo+ID4gICB7DQo+ID4gICAgIG0tPmNwX2hxZF9w
aXBlX3ByaW9yaXR5ID0gcGlwZV9wcmlvcml0eV9tYXBbcS0+cHJpb3JpdHldOw0KPiA+IC0gICBt
LT5jcF9ocWRfcXVldWVfcHJpb3JpdHkgPSBxLT5wcmlvcml0eTsNCj4gPiArICAgLyogbS0+Y3Bf
aHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7ICovDQo+ID4gICB9DQo+ID4NCj4gPiAg
IHN0YXRpYyBib29sIG1xZF9vbl92cmFtKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KSBkaWZm
IC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJf
dmkuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX21xZF9tYW5hZ2VyX3Zp
LmMNCj4gPiBpbmRleCAwOTQ4M2YwODYyZDQuLmU2M2VmNjQ0MmIzNSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbXFkX21hbmFnZXJfdmkuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9tcWRfbWFuYWdlcl92aS5jDQo+ID4g
QEAgLTczLDcgKzczLDcgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2N1X21hc2soc3RydWN0IG1xZF9t
YW5hZ2VyICptbSwNCj4gdm9pZCAqbXFkLA0KPiA+ICAgc3RhdGljIHZvaWQgc2V0X3ByaW9yaXR5
KHN0cnVjdCB2aV9tcWQgKm0sIHN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzICpxKQ0KPiA+ICAgew0K
PiA+ICAgICBtLT5jcF9ocWRfcGlwZV9wcmlvcml0eSA9IHBpcGVfcHJpb3JpdHlfbWFwW3EtPnBy
aW9yaXR5XTsNCj4gPiAtICAgbS0+Y3BfaHFkX3F1ZXVlX3ByaW9yaXR5ID0gcS0+cHJpb3JpdHk7
DQo+ID4gKyAgIC8qIG0tPmNwX2hxZF9xdWV1ZV9wcmlvcml0eSA9IHEtPnByaW9yaXR5OyAqLw0K
PiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgc3RydWN0IGtmZF9tZW1fb2JqICphbGxvY2F0ZV9t
cWQoc3RydWN0IG1xZF9tYW5hZ2VyICptbSwNCg==
