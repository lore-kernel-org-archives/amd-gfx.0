Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B9FD43359
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 22:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3514C10E2C1;
	Thu, 11 Dec 2025 22:56:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5MCX5XJS";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1A810E2C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 22:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkItwnnLCgXdK6tWx5lYBG09QNvSxj90wDFrE3rdjFgzpoG7It56zS+YxcilttuPkhRZ+qIYku4mTnRuqHNeaGAJ2VNoKvsA5++huJjbYXCYAAzCsRytS8cir4WpkvLH9UASaf38gxM7kjAdm0uV49Zsg5hwYzUp4hOjH5R46MKD/ZTO8bWJO4vFgUUcaCqRzZYWQd56yyuBslMPnfsM9DKhuDOLrkusAw5kVbkZDSTOv96+yzRy9Jirqo53h3DbCmZnRltvssH8tZ/QxRmfNtX8tQj3Gwoe3/B3TPlLVbulwCwj85D03ZQndp1ZfZ7NOTKGgsU1jtfHPg8Sm9LHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jdFDcfmhGHCG46Cygc3Zr4mi7nwOw+2U/cIeYjTvYI=;
 b=VZ7/J0TbMRQ3GyOXmQu1bFhJh185hB2FwZW8U4/Mzmuo4UmypttUVZmzA1TFu6JmzQm7IrvvTsDvFPzzazmnPvzn4ewxoxTdselvg0Wlw7OP1MjrFodetEzjT+765GHF9FVB3aBFjnsSY10AkuHWAZyDj+HKFL9/XHvmBd0t1l4+wwgVSpLL7X722s/fu8wc0UA88MutC7UU/IWnOgf1Uqc27ekN0NmR0zcOBebAIPfN+pA7vJVqOxYXJQ7Onha0NOh96rqZSTMsAfFxc/vSrSBRRgc2E7J/M+CLojkk/UXt+kbaenA4tedSa4uePQfqQj29hyJKHNSta2qDl7EKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jdFDcfmhGHCG46Cygc3Zr4mi7nwOw+2U/cIeYjTvYI=;
 b=5MCX5XJSJ7+MjtDEQSjYe7etJvL3qCgqisW2J7veciRRnkehBYus+w68ZXgLxP42RV0EhyV27zwpiH+yNBChnPeYn0mA33K+TPcwK5ZMD9IVss+npoQ8/c0T+IaWrjZOiDojfQQwv4MkwxDmJ3AhK9rZI58hZbj5PEoNS8bqU/Y=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Thu, 11 Dec
 2025 22:56:06 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 22:56:05 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
Thread-Topic: [PATCH] drm/amd/pm: fix wrong pcie parameter on navi10
Thread-Index: AQHcal1gEKM4VfzGLk2//sF1mErudLUceISAgAAYBYCAAHxAcA==
Date: Thu, 11 Dec 2025 22:56:05 +0000
Message-ID: <PH7PR12MB5997C6DA1BAFFFC73808105182A1A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251211051635.652412-1-kevinyang.wang@amd.com>
 <CADnq5_Owz_0ywh5Q_AxWwRn9zeeuOgBeFuyE9GqF1-8DvkA96w@mail.gmail.com>
 <CADnq5_MLib=LpFkHUWEFH5CuHQr0OCJHRbxnsemg5JeD-hLoPQ@mail.gmail.com>
In-Reply-To: <CADnq5_MLib=LpFkHUWEFH5CuHQr0OCJHRbxnsemg5JeD-hLoPQ@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-11T22:51:59.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: 7bfe9b6d-31f8-4ed0-37a8-08de3908774e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cncwK0wwMGZOVVA1bjdoaGh0N1c1NWlKYlczY1ExUVVVTVI5RndkcktBRS8w?=
 =?utf-8?B?a0JST1FXQ1FHQ0xqUGN0UU45NENOeGc3TVVwbW15SmkzNzM2MFl0K1hiWThE?=
 =?utf-8?B?Y2g4RHBaYkNwWTkwRlhVQ0NJQlNCalE1SWFTZzNaRkNXeEsvS0JhVmlnTmNu?=
 =?utf-8?B?R3k3dURHKzNTTXJta0F4M2VmUk5wWDZqMEZjZEJLYUtUU0xTb0JUK2RNOUZ2?=
 =?utf-8?B?V3Q2UEJBTjBJV1ptak1zaUxWOUQ1cXpNdDFrbDVrUG9SLzBCTVRCMmIvWmRa?=
 =?utf-8?B?blJmekN3VXVleW1GVFRwZ25NUVFHUHJLWVAyK2RJL0t5cDJtVlgzSWpWU2lW?=
 =?utf-8?B?OEtRd3IzNGVNNzZodVdidExpMXNiQytVdWtDQytzUzNiR2E2cTdmTjRMeDZB?=
 =?utf-8?B?dDM0Y1VXb0F2ckFNdi9NeEhNZ2ZRbG9WNFA0ODgvVUF3KzJaU2pHS01IeFB1?=
 =?utf-8?B?OUw5eDB4UUl1YmVRUmtheGwyM0FnTkYwdHR1a2k3OUg2RDIvdlhWTTNxdUtQ?=
 =?utf-8?B?cmkzcVc0R2ZhZWlMOTVWV2lNUXE5NExSc1RjUzAzVS9GanRCeDhVYys1YnIz?=
 =?utf-8?B?RU9KRk9xcTAwNHhldjFHMGQyV2QvUEFWT2ZDOFkyZWw1bnRUWjJmQUZ0WUxn?=
 =?utf-8?B?MVc1dHhrL1N1TnlKZzJxRlRnZytIQmN4WWtGQ2VKTXppMFF3NFdwMms2K3lX?=
 =?utf-8?B?K01oWW9uTjdqMHRRdC9JMDZKQkhNR2xTY1VkTEZVV2JZcnVicktOdEZ0OTJj?=
 =?utf-8?B?MnlRYzRNYUo5THY1QXVaQ1NkT1plT0h0MWNMeG1QYzFqcG83NlBUY3lPTkpB?=
 =?utf-8?B?WWhwUXBPNVd6dHRmRllVNWVDR3BGMHZ0SjNWeXdNU1Y1dDB6Y3VnbWlEOExr?=
 =?utf-8?B?VlZEem1OemVxNjhtZi9sRjM2YTFndE11eUpBWXZFSTlGdUljdi9zMVI4eGxM?=
 =?utf-8?B?VGJwRnp2NDF1QjVkTTlCMkxEU1YxRlJGVnBuMG52bHIyYWlXYlhZOUpmRitV?=
 =?utf-8?B?eDM2SVVsMEo0VGZVVDdLemUvNVloQXpwb3JXR3J5a2hnZFZET1R6RjMxQnhD?=
 =?utf-8?B?OS9NaGZOVzQweU5XekNLT3BVUzhNaDExbnJWTDVaT1gvWDFZNXB3QXRqdngr?=
 =?utf-8?B?ZnZGSzZWYTFtQUpCdUZhbzFzTDlXcWFSQnYyQ0xWNjZXdGVwbXV5ZzluQlpi?=
 =?utf-8?B?QURPUGIyWFNEWVdlZE1zb1hZZ1h5bnJRbHplMk5HVHFwNGU5ZXVlSGhFbkNI?=
 =?utf-8?B?eDhRR05BeXRQelp1b0NJUEt1Ylc2eXMxTjZNV1d0amlkdnd0bDVlRXc4ZFJs?=
 =?utf-8?B?YjNMajFsUG8xek4wUFJGYm02WXR0VkREQStxdjYxcGlOWk1ac3U1d0srNFZi?=
 =?utf-8?B?dTF2aHA4clpkd3dRK0E4RVVUeExORDB5OUN2K3VPNy9ZWGRjeUNpcVdLRHdy?=
 =?utf-8?B?eDkxOHkyVkcxcmhZN1kzK0lObGJBY3ovalNaS2NBeGVhRVk3dGNMMWFmUnZS?=
 =?utf-8?B?Wmh6N3NvcVRITHFqZW1EblRPTU5PUTRnR29UQ1NsenpqUkU2RE9ZSjE2LzdR?=
 =?utf-8?B?MUJpbXpSMmY2T1V1c2pWS2lYNTVQTHVLbTA2bUJ0cndQcHFPVHZ0WjgwVGN2?=
 =?utf-8?B?SStkQ3UvdW1KTGpmUVdtamphZ1VoZEduaTNxUWVYVjN4SHdFK1J1WFBZVC9I?=
 =?utf-8?B?TEhVZi9mUi9wR2toY29NQVJkZytyREFQS0RkaGwvM0ltaTA2L3J0TjlTRCtk?=
 =?utf-8?B?RnhLc3dnMnZBYkpyeVU4Z2VOZDIrTTRXaVVOUEY1dmpWU3NLMHZDdkFDUTlj?=
 =?utf-8?B?SkRpUU5QRjJQTTB4Z0VFNU1WTlMrODN0Z0QyOU5rQ1JRSXV1OWVIbXFtempE?=
 =?utf-8?B?VWkreG1qV0U2UjNpODhrbEVqS0JieEM1YzRoNEYzMDlkWVI1KzVmNGpCdndl?=
 =?utf-8?B?TDJqelAvLzgySkhnSFF2ZzZIVkFndDVSclVBdGJHSWxrSDJ4bkJMcTljZXlh?=
 =?utf-8?B?alNPV0dvL01BN0FJSkk2ZmtYRmxUdU1mVGovMHNEd0gvZUV3aDFRK3pveWl5?=
 =?utf-8?Q?Gi25xb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzl3RzNMQTdJQUpmWWtRQ3cxTWVKTzNVUTJXMHZ2K0V0MDB3T3ZRbGsxRC9U?=
 =?utf-8?B?ZUhIS3J6Qm9YWkVhMU1VbTU0QkUxc2NLU3cyU3YxVEZVakR6N1JhaWVSd1hz?=
 =?utf-8?B?aVg1YTBRZ1VnUHFlUlVvNTZrTlV4VDRJSGJiUFJOb1BRZi9SYWRFaDBQMFdQ?=
 =?utf-8?B?aDZLMVU3QWVadDc2VVhPd1hYUVByazZFdW84d1ovOHhJcEtyNTIzWjNUK1NH?=
 =?utf-8?B?UkNMU0tmVFZSYWVmZ0tQbUhVTG5ib2xCVnlzc1lUZjhUbzk5TTVFazZpQndJ?=
 =?utf-8?B?REdzUzFhY3ZGbzFhbFFYcmJuSW10eER0cElUSHZzL01LQ0MzaENMRWptNWhm?=
 =?utf-8?B?YmhQWWlPS2hrM0xlN2NhSHJkMGVSTGppaWxGeEdqbnc2SXk5VHlZeW8wZnpz?=
 =?utf-8?B?YnFITXd4b1pXcC9WQzdramgydkJ3OC9TUlNFcEdKQXF1OEVMM3lJbDVOVzVG?=
 =?utf-8?B?SWYxYWJENUVNUzhRalo3NDBVb01wVW9iMFM3dWZqNHNFVlZIREpOOEpZdUZC?=
 =?utf-8?B?eUFMZXZRNU4wMWhmWjl4M3dXSGZBOEszbzVHaG01VU4rR3BRbC9vS2M1V3do?=
 =?utf-8?B?YzZseXBIdnkwZmtqQyt4cWt3MUVKTjYxUzFjRXgyYW5pOVpMYlVpekNHa2w1?=
 =?utf-8?B?Yk5jTkc2NVJzbzVuaGhQQzE0a0RudVFFUTZYbVBla3dYOTFNRm52VEZQQkEz?=
 =?utf-8?B?dkNnSi95RVdTU3JlaERkS3UvY0htYzgrQjltQytQZFRHdnpQSS9idEl4czVB?=
 =?utf-8?B?c2xVZEhndHNzWlc5Zm9aN25YVVA2M2RrdVBvV0hpNUFxTkpDRmZrVk9DK21M?=
 =?utf-8?B?ZXpHdElySUFwRWV1SE80SVdRRDNjUGg5eDh6RWRiWUozVlZnR2lOTSthSWhS?=
 =?utf-8?B?TUFhRFM5NEZlNkIyakR5Z3Y1N2FJRnZ2dXN0Q1p4VVJhdEVaOWhVci9SeWlw?=
 =?utf-8?B?MlZtYVRlZjY5Rk9zcWRHaVlBVUc1cm5mbjlTYmZCMVAzNzNwRVJObzNSRHVY?=
 =?utf-8?B?cVBjQ25aY21iSTFIQzMvWEpyR2lzd2RlVnRKVjV2N0FKN2lNaXdZTmtsTUlG?=
 =?utf-8?B?OFArTmowY0RNdHhmNGNuelg2cjV3cWZoSHNxclMxZlB4WkF5cEEyVURxU2N3?=
 =?utf-8?B?dnhkZTFQYU5mOFVlTUZQVHZ3UEdwNmR5bDdOUVh3VEdDT2R5MG9LVXR4NFpO?=
 =?utf-8?B?ZDJ2anZaR3crZlV4OFpPSjVtQ000ekVZbVZhcUVrWUdBODlxdVpjeDB5QzBK?=
 =?utf-8?B?WUxOQlRQMkgwOGpaNnJ0SlNIUjBPbjE4TWZMUlhRSnMyMUV4U2JEKzdGTVc3?=
 =?utf-8?B?aE8zQVhFaFdQOGxlbnVIdkVKT3J0OWs4T05ydFZJYlBERXJsRUFZV2xzV01B?=
 =?utf-8?B?VVdHUFZnOWRWMzRmSzI3Tzh5Yk5ORmNralJncmN1b0ZIaDl3NXhEZDB1M3k5?=
 =?utf-8?B?enRjNnBINExIWUN4MGJqYXBISUlGaGYzdExXZjY5SFdrYklucGxSUHFmSGww?=
 =?utf-8?B?VjBSaGpETzZNVStkczZUVVVUVzVGdm1pcmhNOTF0eXNKb3VqU0RrRW1UQ1ND?=
 =?utf-8?B?M2NsYzdmajIzMXk0MlZJWi9PZlYzUVI0V1hBS211ZHVSVFNpWEg3T2tmakVU?=
 =?utf-8?B?QVRkTVg4bThwak1SVldnZHptL004UlZHaTZ5QzY5TXFSOGtGU2NJQ1lXYTQz?=
 =?utf-8?B?T2J6Qy9Cd25nYURNeFVnaHBxRFlDSUxHREJUaGEyNWFDbkhEYWRzUzEzNjgz?=
 =?utf-8?B?TjZWTjlhakREdWEyNGM4bFlCMjNReC84ZXJibFlRNmQ5cnBRdStoMEZia011?=
 =?utf-8?B?UjlGTjB0UHhFcVVwZzV1TkJ0VENZMlFHN0NSaFJKWTFkTkdkMS9STUloTzI0?=
 =?utf-8?B?Y0VjTWFFcVMwUU5pa2wxMkVxSFlXN1dsQUlTOXRBTGpnNVhya0FCakZ1SlRU?=
 =?utf-8?B?MktTeVpHWnI3ODVPa0dhdHpJdDd4WVc5L3BPRllnZDQyMHhaUlNTdmxKejY3?=
 =?utf-8?B?Sy8vZVdoajNNbnZ3VHJMaCt0S0liNGN5M3p2ZTJESElMVWdLNURWNTU2ZVFl?=
 =?utf-8?B?cUp1ak5GTEZIekZ2RVdST0UyRDcraTg4Ym5VbDFNVUJ0SlJsbkx6Sk85Z0tY?=
 =?utf-8?Q?0XJw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfe9b6d-31f8-4ed0-37a8-08de3908774e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 22:56:05.6859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Disuy71+sf20Pgk9/kQiMt+vMBsranroU7xXYqd0gELBLME7XljnOHGirUF2DqAx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cg0KSGkgQWxleCwNCg0KVGhlIG1hY2hpbmUgb2YgWDg3MEUgYW5kIG5hdmkxMCBpcyBxdWl0ZSB1
bmlxdWUsIGFuZCBJIG5lZWQgdG8gZmluZCBhIG1hY2hpbmUgdG8gdmVyaWZ5IHRoaXMgaXNzdWUu
DQpCdXQgdGhpcyBwYXRjaCBpcyBuZWNlc3NhcnkgYXMgaXQgaXMgYSBjb2RpbmcgaXNzdWUgY29u
ZmlybWVkIHdpdGggS2VubmV0aC4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5m
cmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IFRodXJzZGF5
LCBEZWNlbWJlciAxMSwgMjAyNSAyMzoyNw0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllh
bmcuV2FuZ0BhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFu
ZywgSGF3a2luZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgRmVuZywgS2VubmV0aCA8S2VubmV0aC5GZW5nQGFt
ZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3BtOiBmaXggd3JvbmcgcGNpZSBw
YXJhbWV0ZXIgb24gbmF2aTEwDQoNCk9uIFRodSwgRGVjIDExLCAyMDI1IGF0IDk6MDHigK9BTSBB
bGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IE9uIFRodSwg
RGVjIDExLCAyMDI1IGF0IDEyOjI04oCvQU0gWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IGZpeCB3cm9uZyBwY2llIGRwbSBwYXJhbWV0ZXIgb24gbmF2
aTEwDQo+ID4NCj4gPiBGaXhlczogMWExODYwN2MwN2JiICgiZHJtL2FtZC9wbTogb3ZlcnJpZGUg
cGNpZSBkcG0gcGFyYW1ldGVycyBvbmx5IGlmIGl0IGlzIG5lY2Vzc2FyeSIpDQo+DQo+IEFzc3Vt
aW5nIHRoaXMgZml4ZXMgdGhlIGdpdGxhYiB0aWNrZXQ6DQo+DQo+IENsb3NlczogaHR0cHM6Ly9n
aXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDY3MQ0KDQpwZXIgdGhlIHJl
cG9ydGVyLCB0aGlzIGRvZXMgbm90IGZpeCB0aGUgaXNzdWUuDQoNCkFsZXgNCg0KPg0KPiBBY2tl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogWWFuZyBXYW5nIDxrZXZpbnlhbmcud2FuZ0BhbWQuY29tPg0KPiA+
IENvLWRldmVsb3BlZC1ieTogS2VubmV0aCBGZW5nIDxrZW5uZXRoLmZlbmdAYW1kLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBfcHB0
LmMgfCA0ICsrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L3NtdTExL25hdmkxMF9wcHQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvbmF2aTEwX3BwdC5jDQo+ID4gaW5kZXggODgyODMwNzcwYjc5Li4wYzI2ZmU2ZmI5NDkgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9uYXZpMTBf
cHB0LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL25hdmkx
MF9wcHQuYw0KPiA+IEBAIC0yMjE2LDggKzIyMTYsOCBAQCBzdGF0aWMgaW50IG5hdmkxMF91cGRh
dGVfcGNpZV9wYXJhbWV0ZXJzKHN0cnVjdCBzbXVfY29udGV4dCAqc211LA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBwdGFibGUtPlBjaWVMYW5lQ291bnRbaV0gPiBwY2llX3dpZHRoX2NhcCA/DQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcGNpZV93aWR0aF9jYXAgOiBwcHRhYmxlLT5QY2llTGFuZUNvdW50W2ld
Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHNtdV9wY2llX2FyZyA9IGkgPDwgMTY7DQo+
ID4gLSAgICAgICAgICAgICAgICAgICAgICAgc211X3BjaWVfYXJnIHw9IHBjaWVfZ2VuX2NhcCA8
PCA4Ow0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHNtdV9wY2llX2FyZyB8PSBwY2llX3dp
ZHRoX2NhcDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzbXVfcGNpZV9hcmcgfD0gZHBt
X2NvbnRleHQtPmRwbV90YWJsZXMucGNpZV90YWJsZS5wY2llX2dlbltpXSA8PCA4Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHNtdV9wY2llX2FyZyB8PSBkcG1fY29udGV4dC0+ZHBtX3Rh
Ymxlcy5wY2llX3RhYmxlLnBjaWVfbGFuZVtpXTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNNVV9NU0df
T3ZlcnJpZGVQY2llUGFyYW1ldGVycywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNtdV9wY2llX2FyZywNCj4gPiAtLQ0KPiA+IDIu
MzQuMQ0KPiA+DQo=
