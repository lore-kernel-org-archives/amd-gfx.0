Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A45CC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 22:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9058B10E84E;
	Thu, 30 May 2024 22:36:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zX8jU30A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E0710E84E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 22:35:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kclz1Rs19SuvnPOWkecf04KElrIcClzkdo8ehVybCUs6JWtwkD/zQj0qaIytDm+doG1SmMaE1QcM9KPkcGnlgtEaCJg55r/4/gPe5r/qCmsgtbeoIdceARJda6QUedHaXazM3YCIXUTKC0m6T4EGObUIcCr3KgHrNSqNWVYBC80v8BgypX39ytHBqTS/2gX8t730BALmZgWp57/qsS+VzTRgeL3tPeRv3j/HTbV44guJbXAx9MHRNnwZUnxgBfazdi0jPR/Q3XTd6iBoF2Zmx/v17z6b6Mm9vuilbruHOK/R5e1GfXjbzPQgRxR6/Ozp87krjZiIEyGM2kH1eSH2uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jCWsd3uwPNCb67tfhosPSkzb3DYxP4nKq8ulSi/Bxk=;
 b=QhWMsISuI7Z/jcJSGhInis4+HsDNUWn8B9gbpqFRQ+aGzs85YvZau5ArYg2lYzKBP5EKmPr6VqF45qCTVDobtZODjr4k3H5PsvHT8eiKlaL6+n22m0SxA0hkYW1BGb+i9AUc0bQJpE1sbVnRwWGD7CkWeAfdvEHmF2DOubqBQ7KF59+iohpzZkkL9/ExsafCx1auxqbe6tYlOQw6jnAJaC+ppgs1D5KEuerdGeYvDsEKEdavCG7BRXoLlYVql67X401CRYwKJtsJj89fWfMQfAEcSB4rimHCbB2vuSUbz92YtnNtgBtq8HPvg78NHqVhR+1nijKCOktZwjYz/07g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jCWsd3uwPNCb67tfhosPSkzb3DYxP4nKq8ulSi/Bxk=;
 b=zX8jU30AybQpYF6krE92yZ78MKb5mKHNxnTzW/j2u7iEQ6mqY2wJaK0Nz7a6LNmj0qP2PIh8TfroPp63VlCVFOb3kpblr0X5ajy3NLPGmuR6jH3ExNmzL+FbWWfT6W4SodfFLwEgm1gITcEXZRq4wJX5EfjjNtEYZYAkUJbLoHU=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 22:35:56 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%4]) with mapi id 15.20.7611.025; Thu, 30 May 2024
 22:35:56 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Gao, Likun" <Likun.Gao@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
Thread-Topic: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
Thread-Index: AQHasSPnfnkU4y0qpE+6/oMQ8ECeVrGwV7mAgAAHzPA=
Date: Thu, 30 May 2024 22:35:56 +0000
Message-ID: <SA1PR12MB85995FB40E4D14C7B990982BEDF32@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
 <20240528172340.34517-10-Yunxiang.Li@amd.com>
 <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
In-Reply-To: <29490f15-eb5f-4438-bfd7-ffdebff6e678@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f0baca90-f78a-437f-8c10-f154a685a197;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-30T22:29:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|CH3PR12MB8971:EE_
x-ms-office365-filtering-correlation-id: b98dbb5e-62d1-439f-7422-08dc80f8df67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?alhwNWJ0czdORHU3cEU1cUZMbC81aUhpS05vOVlUbTBRbERoWjVxVEN5bGhk?=
 =?utf-8?B?UU1uOGczSDE0T2VvVEQrMVlTdkliMXJDS3dEYUdRVW4zK2lJeW12SENtbjM0?=
 =?utf-8?B?SEUxZ3orRS9RdnV3SlBlYUFKUFplYy9waVMyaXY3MTN4dkU3LzRCWGtWTDVo?=
 =?utf-8?B?S3RaRE1oOTdRakRJcUVZVzNjWkE4Q1orLzdQQnRaTHN4UERiT2lKZ3RDSHpw?=
 =?utf-8?B?Mm1RUU1oZjJaOWwrVmVra2ZZMTFjU3lRSVZ2VnpadmxSeWZ1cVFtek1yQWhk?=
 =?utf-8?B?RmdMUjl2Nk82QjZBSjBXbHFCZUFEVVE1ZWM0VXZMeWRaeUlVdmZVYzVzd2JJ?=
 =?utf-8?B?a2xHdnpybVBNTTg1WEJObEsrNnpRRXhiRk1saEpoNDBYUzdnb0d4Z3Qybi9G?=
 =?utf-8?B?MG9NQlgvemdaYnZmZWJIbEpKYXM4KzFVbE1vVUJmOGJXZnpseWFRWUpoZFlD?=
 =?utf-8?B?amZ2YzZVZDVmNC9lb3kxaWdlbGwyZnd4aGtaR3ZLVUE4bzZHaXFQOExVdGFv?=
 =?utf-8?B?NExRUTAxWk92ejlVNHFMWHpiRU5QcnNnSkJRSlMrc2RzZjlKTkRIUzI3VWJx?=
 =?utf-8?B?WDFFVVVrWk1HakJTaVh1czdzWVhKNG5nQjVZcFNqeUVPb3VTeXFidTdEQXJv?=
 =?utf-8?B?VEJWOGFsSGcvS0pJSDBrRTlFRkk3bGg0eXprYWIxb1h2UUp0MUo1bDBKWmdi?=
 =?utf-8?B?NVJ2ZVlVd1F5Y2ZxZVd3QS81N1BqS1hBU3hWS0pFT3Q0ZTdmOGFENWVSYmlX?=
 =?utf-8?B?aGhNUjBmc2toL1dMUGtkbnRiZWVZYk5EdHg1QlZ4K0NZdUUzbmZtek1MZ3FC?=
 =?utf-8?B?ZVpOWTlpY25ERGM1YW41OXJGSEZEYUZuRE8ySmdRWitNb3ZaeThrNlBtS0wx?=
 =?utf-8?B?ditmZWloMU9LM0hPc3FaUURhazBQNWU4bUU3bGtmWVdOTkxiNEUwUHBsWUZu?=
 =?utf-8?B?VloyMnZ2RXFieHZDNnVzVVNuWnIvbUlCRElKd0JScmRoRkZ5YkdrUEdpWkQv?=
 =?utf-8?B?aEdPdnJVU3pHY002RU5rYWRqbHUrbkJZdEt0bTkwSXhYYVBkZXV1WDhOdGZI?=
 =?utf-8?B?a3FUeTVzYmQwcy9uRHA5cHlPWnFnVTFZTXV1WE9iSkc0U0U0Q2ZNMkNXMGt3?=
 =?utf-8?B?NHdYdm9Bb25Xekl4bEovaU0yMGR5UldCbVVJaWdZNjdWdWVycGt3R0w1Z0lm?=
 =?utf-8?B?dGhzc0oyTEV3cWNqdEZBakVGclpRODY1OVFUNnd1UVhORXlXalY4eHYwMDRN?=
 =?utf-8?B?ZlQ1akVtd1ZFQW9teVQwblpTVWxWL3B5STEvVnJmQ1RpVXduVXpHN3Zrb25j?=
 =?utf-8?B?TTRtUC9LZG9ubHRHYnFvaWdDNDZVbktCSHJFWkdpR3kyTkw2dGxzYk5jNUpE?=
 =?utf-8?B?QzdQUGJZelcyTTNKWGVOeVdvMENvK1ByTDVWOVVzZk83K1dWSE5QSy9SMHRK?=
 =?utf-8?B?aDRNSGFVRGh1WDMrS1pueW9aYlU3Z3BQbEx1eXdPRVd3bUJmY3V2UnNnTHBE?=
 =?utf-8?B?MXRVaWRKUExUSi9yMmZvcjBHWWZnc3JTSlQrN0RnblJiMVFGMVloMDNhL0k3?=
 =?utf-8?B?RzRoUG84S0ZYMFBKd1NqYmY5a2g2aklQTXNxSEdWemYxL1FRQ2dSSEF0bnV6?=
 =?utf-8?B?SzVEaE9wRHVkYWppaThxalQvdG5jNXl5SHQrQXhLUU8rblBESmxIdWZHdWNh?=
 =?utf-8?B?VFJweGV5bHdXVUdhV0pDemFxQ2l4cm1pYUtiUlltczdWMlU3eWlvTFg0M2F2?=
 =?utf-8?B?N1N0SW1sUjFqN0MvR2IzeVNxd3ZpaEF1SkJyZXBmbmVraHNqTm9DdWw2OFQr?=
 =?utf-8?B?dGhlZzdHSlp2aldQNElTUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjRvZHRLbVd1SGsvdDdTZytkcjh5Q2JXV0I2d0Nsc3NjNTBSR1lzM2xYckJ4?=
 =?utf-8?B?bm03TUJ4SWdTOHhKdUVxRHRUektjNnN3bndlNktDQk5lM1hRN1d5OC9qTmpN?=
 =?utf-8?B?djVGN1gyMTJuL0tpVDF4b2t1NWd1YVlQdTBNNjA4Sld1dTJzbTlsZWJqaDBx?=
 =?utf-8?B?SVN5eHhPUTZqUkJZOGMyZUJKRHpKWitNQldhM2szWkpqaTNzTVB0QWp3TnJk?=
 =?utf-8?B?VGtFcGNKdm43WFh2VEIrWW4vckxianI2MkFDaVpmUXlsaE04RGlqU09Db2lQ?=
 =?utf-8?B?UENIbVZ2VXNaV0cvMUN0R1ZNdFJsWkZmRHRwNVhrOHR6T0UvQ1FrZmYwdmcz?=
 =?utf-8?B?MG9oZGRTYi9MM2NSKzR5ZnlGSkJHdU9UREhQUFY4ellMdENPT1hwaDBaNVVu?=
 =?utf-8?B?blFQODlNUERBVkF4UkFrMzhvWFJKMzVEb0d0ZG1wVkhObWRHdXBuK2dTV2s3?=
 =?utf-8?B?ODY1elVGbFRMNkFYbUFaLzdkKzd4VjBKRXU3NGhsYldST0ZVdC81NzJXMDdY?=
 =?utf-8?B?TE9CQ3cxMS9JajVRM3NnejkvSzhYUzNKWmFldXh1WndFVTJjQmlyVEFIRkgv?=
 =?utf-8?B?V05sRU1BUTZ4aVROYmNUVlczNGMyU3lIZm50TmZJWnYwWlJIL2JNb1Yzay95?=
 =?utf-8?B?b3dOaEF4RjRJYUtsSlhTSGZKSUY2T2UxdHdydGdkcVUrcEJGcnRGUjUxckdZ?=
 =?utf-8?B?ai9jYXExTFdZVTZNWHZ0V1NNMmFXRll6VnZybHppbDJPaTd4dXlUWTVPOFRI?=
 =?utf-8?B?VCtBTkNBT21TN0ZaeHRFKzI0cFZ0TGs3UjYxWmN5NmpNZVNUcitxVFI1WkQv?=
 =?utf-8?B?TURQMExnQ2VpbVRJZzlBNm5nd1o3MTRuM0U4aU1xNXBCYTQvVTlkSE9HY0ZE?=
 =?utf-8?B?b0pLcXNEb1E4UlE4SFh4eFFxaDBQMzBKOXpmWWtjK2hLTWUyTGRuRmI2bk1x?=
 =?utf-8?B?RnlJSHVYSkFSNkdOUDhVNWJ5Qyt3VHFWOFl0L3pTNmFBKyt4cjdmbjBLUUJE?=
 =?utf-8?B?RnZjNUM5L0ZLb1lVVEduTnZFTWl1U2tramowZkdUZFVlWG1JTzV0UU1BZUhH?=
 =?utf-8?B?TGJOblVRQ0cwY0VWUmp4MDA1by9iWU1ZSktpS2ZZRkVNZi9za3BaWW9QbTJi?=
 =?utf-8?B?b1c1ekZmakZVWXBjY3ZhNEJHK0tDYVhibXJCSXZqRFhrYUhlOXluTmF2eFFi?=
 =?utf-8?B?eWRjSHVNcnZLL1dPRStodWVyemt5ZG1UbVN0VFZZb3kzYWJmakZLWEJNbmtF?=
 =?utf-8?B?YUE0WHVyQ3NRQ3RQcitLQ2Eya3FKd3RHL29QWisxQ2hYem5jMTlSZEJyRW9W?=
 =?utf-8?B?TWtCbmpNK3hUdkJCSFVxSTBIVWFXQk9ON01wWE4rOGhBcnQyQlpRNEdDWDNC?=
 =?utf-8?B?TGJUaEFBS2IrWnVtMWR6Ny9aZmNObGVYK2JvSThra0Mxd0xibEpQVmpwc1hE?=
 =?utf-8?B?QW9GSEJIR0xydWtMdTFEV215RDZSYVh6WEtwajdmenlRK3lOYk1zS2xybVFl?=
 =?utf-8?B?ZXRNWXVINFVwMWNXLzBOT1pTZXBRbEdHVFFqRXllVUhHNmxoSXBwNHJNWVJN?=
 =?utf-8?B?bk1KMENMaUVZN0pkOWNHcmV0RUFFcjJiNjdWY1ZWZWJxN05NVW5yZVpwaUZ2?=
 =?utf-8?B?ODNQeFlDeS9rY1ZnbHdCVWxTa2FrZTBydWxzL3lWclBZL0pTSENVWnZ5aEx1?=
 =?utf-8?B?bjBzaUsrcGlMNUFKSWMyVXJpWmgzaDVSWEsvT1ZLNUJrdFJCR2pXMmh3Ymw5?=
 =?utf-8?B?bVlnY0dKT3pFOHZlVXhRcGc3d1pLc0Q3Z1pBUzV4TGhvVXFFUWU5ZG5GZ3g0?=
 =?utf-8?B?TzVUaUNtL2tVU1pNWGRHMzJlV2IrZ2pCYUJxY2NxT2N5UDBzOUZxV3VSbmFL?=
 =?utf-8?B?RllBZnN3TXRQWkQ5QTJKc3lrMEFlMmozY0tHZ1hLNkFXTVlaVUcvOFN3MzB6?=
 =?utf-8?B?QUhjbmVqZm95cWlRbVBVdVlHL1BUN3Q2eVJBWlNlZXR4SnluSWcyS3RiVGR6?=
 =?utf-8?B?S2ViZUlUZXkzRmpEWXhYRHB4Zk05azZUdDBIajRRWFlSS0FrT0hrMGlUVUls?=
 =?utf-8?B?SHRUbnlGUzdOUVRaQUxqcG0zR0N5WGxVTm16UmYzWll3WVZqOHJuMjJhTnJU?=
 =?utf-8?Q?lr7E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98dbb5e-62d1-439f-7422-08dc80f8df67
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 22:35:56.7656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4iwu0kbP9EXIiTOUjvKGV0LW4xazDpB/r9zQROOhMGrcwOL7DgQx0zKFJnhcA7hetDl9PLDxJ0+INNUYRyVLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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
Cg0KPiBJdCdzIG5vdCBjbGVhciB0byBtZSB3aGF0J3MgdGhlIHJlcXVpcmVtZW50IGZvciByZXNl
dCBkb21haW4gbG9ja2luZyBhcm91bmQNCj4gTUVTIGNhbGxzLiBXZSBoYXZlIGEgbG90IG1vcmUg
b2YgdGhlbSBpbiBrZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYw0KPiAobW9zdGx5IGNhbGxpbmcg
YWRldi0+bWVzLmZ1bmNzLT4uLi4NCj4gZGlyZWN0bHkpLiBEbyB0aGV5IGFsbCBuZWVkIHRvIGJl
IHdyYXBwZWQgaW5kaXZpZHVhbGx5Pw0KDQpJZiB0aGV5IGNhbiBiZSBjYWxsZWQgYmV0d2VlbiBI
VyByZXNldCBzdGFydCBhbmQgaHcgcmUtaW5pdCBmaW5pc2ggb3IsIGluIHRoZSBjYXNlIG9mIFNS
SU9WLCBiZXR3ZWVuIHJlcXVlc3QgZnVsbCBhY2Nlc3MgYW5kIHJlbGVhc2UgZnVsbCBhY2Nlc3Mg
dGhlbiB3ZSBuZWVkIHRvIGxvY2sgdGhlbS4NCg0KVGVkZHkNCg==
