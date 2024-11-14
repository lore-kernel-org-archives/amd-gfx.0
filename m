Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6ACD65C42
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 06:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F3C910E353;
	Thu, 14 Nov 2024 06:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ICbeEXEG";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B81810E353
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 06:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6MTGabNWiBRB2ang6M3fTVuYU7zuuGcBsOv023N4A2EWlJ7pzOOqBiNLg2iIk3hXdF13vkrXPwtnOnBk086fkiZzFzWdUignmJkcovIzrSmxLBRjUz+Wxt63Pxec/fLI+UlebffxMpM5k1bAl/hTeu0YAzFrnMNsDWqtwbc1SCInpvzv45sXRYQwW2N93uiL55ytwS5j7IAkpvzGZ0yp01x5H/qQKomZ2HC/txzykIn851OgtmrBWNCHUquytS+r72TPQF8LMIWr+RmlYZN8JEy7M+SUSOyaTFGVXfdNAb/q3cP2uMaQZuv/vPcbbAaYGVRal69ZaGQwRKYJcIr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0c4GXGOR06f+GzjUE9pIMSS9s8eOBqiH6haxqoXJWM=;
 b=Nhv/Y+wBNNVfa+GQnO79UwwgqWfjs3STLnIzZHQtZW/DYLb8C7CvF1HuPMceZLZnoKSB5e03yJ7YVCtGPiC/MFt5Fa7WUdAQmgBP4Q+nfdztNmmUbMzN7IfnwN3RZIbswLdcStgJMFN7I2HbLZsekDLqYR3Psi11RVGaxUxwuzFe8NRwoUj/QaygKhNdRnRCyloj1aW7aEVBey4L7Z4bJHsFuiyhCxJi0s1GbylDuCR9n3c0BMvhMNKLE8xTcXo1pCrqoKDe8Tfp/ZEjNfuMSQ2ykqaYkFV+kqqOTanOQlmtoE9fafqlulh3JD8YFUryBskjxwXyjCzzZ7ITHLIiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0c4GXGOR06f+GzjUE9pIMSS9s8eOBqiH6haxqoXJWM=;
 b=ICbeEXEGDbaN+7Rj5Is0YsOfAo8grGViRGctr4+JdGd2LO8V+xafvQ40w7YOYyGZrDk4kstd1w/IaTv2S8WcgKw8+rbT+uhIjn0/VNpq4TzGaxb+R17ea7w1+O7VD4fQimQcqF3oe9MObvvpVHEguHCyKxs3Ytm9ep+m2lFU27Q=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 06:34:32 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8137.021; Thu, 14 Nov 2024
 06:34:32 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: Add missing kdoc 'gpu_addr' parameter in
 amdgpu_seq64_alloc()
Thread-Topic: [PATCH] drm/amd/amdgpu: Add missing kdoc 'gpu_addr' parameter in
 amdgpu_seq64_alloc()
Thread-Index: AQHbM+OdbMwb8iPAu0C8j7dpo/ZaK7K2VliAgAAAUNA=
Date: Thu, 14 Nov 2024 06:34:32 +0000
Message-ID: <BL1PR12MB575369E4DE6FDD2BDF5139A2935B2@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20241111024350.1881077-1-srinivasan.shanmugam@amd.com>
 <IA0PR12MB820816E11FCD0F92AFD8E8BE905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB820816E11FCD0F92AFD8E8BE905B2@IA0PR12MB8208.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5c166ec2-605d-4168-aa81-0e73534ee870;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-11-14T06:32:57Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CH3PR12MB8187:EE_
x-ms-office365-filtering-correlation-id: 63ceff56-ed47-499d-9fda-08dd0476666b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vk13Mkk5azljbU93RW1uYklPSUdBcDhaYlJBVmREYVcyREYzVGkzWTdqVFZj?=
 =?utf-8?B?OXZiQWxXNGJ5UVlHRFNFblpiR0FvWVp5S2tNYWtITzdjOUtSMnV0L0ZKUWpm?=
 =?utf-8?B?L1FMOVJseUl3TEZBSWFrdDV5OHpta3JpNkE5UllsRGhCNElXYVBQVkpzUlhn?=
 =?utf-8?B?ZEFzbXVYVnVXZjhwcWJVK2lvSVEzWlFTajgrQmF2NlZRSnpyRlE0REhYUzFU?=
 =?utf-8?B?cHdqZ0cwNTFGQnFPRitxUG5vZjRFVVdtMU5GY3UwSHpsbjZNbjlhdFM5WmZa?=
 =?utf-8?B?RUZJckdSMlY1eHRpUE83SlhFSTFYVWZ5Nk40c1p5dExRY1BGUlFLd2Q2cmZJ?=
 =?utf-8?B?SWNZWTNaWVREbGZTZnhVelZCU015R3NXQjdVZGkyVHRET3dhVENscHMyTjhi?=
 =?utf-8?B?eExaaENLOUUyM3dXeE96OTJ6SCtuRFJFUEtmUjQ2OXAyeG5oRCtzN0lJVzVk?=
 =?utf-8?B?cUFoeml4RU9WakFzMFoyNUJjVkFuSSt0NEF4RWVoelRjSWxnSmtTNVZYMUdm?=
 =?utf-8?B?SWRkODg4b2pWZlNZLytNMklLZUVGSUlpblgzSCsvenRJMCtpdnlkZHVEbkF5?=
 =?utf-8?B?RGEwSHBiWTlqOGNnSnl5MFp6WENiWllZdUJSTGxOTXdBUkZ4UDZNQU9seTRY?=
 =?utf-8?B?SVlWYmwyd0tScm4xVFIvOFlwOXNCbjFqWks4MEs0OE1vb3dVNkdUOExCOWJa?=
 =?utf-8?B?MmdWZUY5QjBsSDFOT2xCcmVENnRUSUNlSU9LMlNxRzdjYk5Bekd6Wnc4UkMw?=
 =?utf-8?B?WkNQaE15QzZ3Qit0SzVXbmw3L2g5d0ZubHNEVDY1MTZRa3oxT29ia1V6NVpq?=
 =?utf-8?B?eGd3S3VnQkhDOWtoazZvTTZSa3NQV2ZkQmJwQm5UUWYxRUkzNXRzWWZRWW9U?=
 =?utf-8?B?cXhqR25YTGdOZzZDYlNNZFhqckNiRk1ncEFDNkcxcmQyMnRWZDVveFZxem41?=
 =?utf-8?B?QXMvUHVTNXVpQjQrc3VPUDdzQ3ZTcDN1K1c2N3I1SzNoRjl3ekxkcEFkT0Rw?=
 =?utf-8?B?cHJHUVdNRHBqUHlrNngyd0NNRHJlc21YeHZja0c0dm0zMVJBbVZ1UkZVa3RW?=
 =?utf-8?B?Si9FcXJmZ2UvUWJ2TDZLWmR0SUpXOUllcU1kWERmdVU3R1pLVmhzNTU0OVdm?=
 =?utf-8?B?R1REU1dqWnF6cWdDZkZBeTdPK25XM3RKUjcxQitPc0JnRm5mOWtvdTJvZzFt?=
 =?utf-8?B?ajJSVG1MQS82dWdxTzROY2o0Q1g5SXNRZ1ppUTdERHZyUjF2TE1RM3BQQnJK?=
 =?utf-8?B?Mk4xU3FCZWwrTkNzcFd5NWZyMHA1dEVaYnZDMU0wWDE5cGNhZFZxVUhNMG5X?=
 =?utf-8?B?c3hUOUlKb0JlL1VFcHpWcUJwRjY3cDVpSnJmU1RTZ3phYlQ1cmtyNWVxamdh?=
 =?utf-8?B?azl6L3o0b1JmUTBBd1VKRzhBUUZKajVzTlBKb0UwbFF5aHcrUlVQdlUwd0NT?=
 =?utf-8?B?TUV4elBWdG12cXZ0VEFTc2kvTU9JNkVpQzRzN2pDV3h1OTJzeUpNYkF1WnE5?=
 =?utf-8?B?SDAxMWw5b1orVlhIVXQzaGJSQUFmaS9YRHBIMmlueDI4V3RkWG1hVXFDTk5T?=
 =?utf-8?B?QmZjTEhNOVo0WjZLbFlwK2Q1Q0FheDRvSkVqZHo4cnZBRzhoaUowS3FiVkZW?=
 =?utf-8?B?b2RSUW84dVcxZmNEV2NYdUkrQ1BwL3VaNFF5T3FyUmlEVWk0bkx2TjIvR3dw?=
 =?utf-8?B?bk1talM5M3I1cEg4YlI3Z0lQOGpXbDJaa3NISXBlQjJ6Rm1MYmthSXBZaVBO?=
 =?utf-8?B?NlFPbUJ2QllQTlQzT2IyYnVlQ2dJM2dqYVNPdW9GM0lLTUtVa0RJRENhV21G?=
 =?utf-8?Q?5UeSQ91CnI/Fn0viz/G6HgN/dyGMS4Us0r4Jc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGtHM1QvQ3NRWFBDN3VJRDhBMWdzdy8wUS9wMmNSQTJPWmV3aG5zajJyTDlo?=
 =?utf-8?B?NmtpWmxwVUlJTUtTK3RyYmJnWVQ5QzlraU1BY1N1WGdSUGlsVXBnTUgxTTFK?=
 =?utf-8?B?bnVXSHVpYUU4L2FXQTJHeTZsR080aGQ2RGtFbFVudkxvamZHNTN3dUoyNytM?=
 =?utf-8?B?bTVSSnl6b21GUG8wbzM5M1RsZmxGYjFEYjVwR1ZOcHlXZGxnTlJxYW51MXJY?=
 =?utf-8?B?WWVCT1FUYmpPRzR3VWs0SHVUeDZqcmphaUFrNG9IZnY3dDhnd2YzV3J6eVJ6?=
 =?utf-8?B?Y1RGei9idndWYm9mb24rL3BjTjhsS1pLTHpZUFo5eTFwaGRkM0JTcDVuR3Ro?=
 =?utf-8?B?UXQ1S0p0WkV3eG01dmtFUm44ampKTTh5Tkwza2E4VzBmbHVEYzZrQmN1ZTV6?=
 =?utf-8?B?MDZ3UVB2dk5GSHpteTN2SEZJTUh4MU52aXZwdDBnMFNnSXpIMkhkcXNNRGlT?=
 =?utf-8?B?YkZsVTFYV2VjOE1ZN1g1ekg0QzJyWk11Q1lTM3lnT0VabUVRUkpVRStpVDlV?=
 =?utf-8?B?UWo2dGlPUGJ1cnMrOWh6UHNRTWVWNGMveGIzSVd4ZGQrWVdHcXlSKzVnOG5W?=
 =?utf-8?B?YkJIdTVtS2lxc2twWjJDYlVPdC9jaWRxL3llK1pZdEdYREV2bWJ2Rk1sNjVo?=
 =?utf-8?B?Qm5KankwMkhZUTAxN0ZCNEd1NDJ3ZUdVQStOSzhEa1h3WXFWMWRsSEVRQXNN?=
 =?utf-8?B?eVEwcGRuUDJtRjUwVHpDdjZxVVZVK1NuVlFURVp6REZlcDFaNEI0a3JoVCs3?=
 =?utf-8?B?U3B5MGlYT3FkZ2QyVkVKRWRsUzBWaHhiSTZiVjZiZnhGMjhFS2c4SlcvVkUy?=
 =?utf-8?B?dzBTNkI0RDc2eXhCamR4My9iVXI4dzNXY3JwV0xlcWs3VjJFODd4QmNOdWh6?=
 =?utf-8?B?NFFZbWhscngyY0F4UW5NSSs3OVpTRElTWG8zellFT2s1L25CN1lrR1gvT3RC?=
 =?utf-8?B?dWRYVUVtVzQ1S09QMlczWlJscTkzcG9DQjdqL0hEUDNjQy82SDlVUG14Q3Zz?=
 =?utf-8?B?V0Q5VmtObWh2ZUNPQXhjb2hTUERtcFNERTBqSHN0dUh4SlFqT3phSllZTWpT?=
 =?utf-8?B?V3JwclJ3dVlGbE93cGhKbmxuNUVtSVorQUNaNjZzSC8vTVpCaFlJTTBlV3Vs?=
 =?utf-8?B?c0FIR0xnVUdhcUt3ekZWZGVYUVdhd1BDYzZKL1F4WXJndHlmQXh0VnZrVnBI?=
 =?utf-8?B?WVdsREpKTEgyVHQ3c1RhUFJjaStNWEhJaHhuSm9ha3loaktqcEJIREV1NVpS?=
 =?utf-8?B?WGpISHI4RXVwYytPb0IzRWErN2J2NTlxd1N0NjAyeWNGQ2IwSE1oQWRkbVJF?=
 =?utf-8?B?aU5CMU9na1daWTdScTM4TG9OVjBLRnQ5aE44d2QwQjN6dVBCay9uaHpmZTh2?=
 =?utf-8?B?dDUxdXlWVWsySGNKR0czQmdzMWdHVGNjVFZ0L2FDQjRFU1JWdnRUM2g2NG9E?=
 =?utf-8?B?bEtzcGxZRVpWMUtOblpDaXRtZHczR2RRZWJ4L3hORmlxNzFFQlJxTlFjaFJF?=
 =?utf-8?B?ZzlaNFR5WUIxOXFGZ1U5ZVdGV0dOaVdLeEVJaStxcGNlRU1pSHNnckVYU1Zs?=
 =?utf-8?B?NU1qZVdJN0lvSEhNeGlCS1BiOGZMcXhCYnBBUFU3UmJLWlN4M1kwQmRLZEV3?=
 =?utf-8?B?d09jSTVtSmYxUUIzUXVCc2djQlF6OEk1WjZQSCtlU1k5eS8rS0NMU0RBeDcy?=
 =?utf-8?B?SEtPVHRtQVY3SHNzN0swQmRNWkZZN1gxNFNUSXBuY3hFWUhWNmRmYTJJdmdn?=
 =?utf-8?B?ajYxZVh0MkozZUNFbG9zdmVWalMvMHhaTW8rTGoxaS9UcENDcjhlTks5d2N3?=
 =?utf-8?B?WnpyaEtrVkFoYWY3cU9aeEpGcm8yc0wyOTRtNUd1VERXYWk0VjhleFlGZEx2?=
 =?utf-8?B?dG9qRmVJYzBoTTE1TW5nQlJaQ1V6cEp4MUJRYjNpbmxFbGRkU3ZWUjQrZzN0?=
 =?utf-8?B?S09nK01NSHpYRFNPdmN5TlAyelRuQmNzdlhuSGc5ak82Zlc3RjhDRGF5bGQ1?=
 =?utf-8?B?WjE4N3dPeTRzY3lqV2gwTnQxc1JOeTZVYkZOM2piOFd0SUdFUWVkdEp3TzVM?=
 =?utf-8?B?VnNzc0FkV2Jsa1J1T0xEbWRTSURxNVNycTJ1ZldYNDRhSGpaTWV1SmRCY3RG?=
 =?utf-8?Q?FoRo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ceff56-ed47-499d-9fda-08dd0476666b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 06:34:32.7232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1phk0VYjn9u873QlHeeacNvYsAUWUKiHddBBdm9L7zWNlAQ9dxnarCF/lmPhBmzj8WinFST4qrPJoX1fIMAvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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
Cg0KSXRzIGFscmVhZHkgbWVyZ2VkIHllc3RlcmRheS4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IE9uIEJlaGFsZiBPZiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4NClNlbnQ6IFRodXJzZGF5LCBO
b3ZlbWJlciAxNCwgMjAyNCAxMjowMyBQTQ0KVG86IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3Rp
YW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJF
OiBbUEFUQ0hdIGRybS9hbWQvYW1kZ3B1OiBBZGQgbWlzc2luZyBrZG9jICdncHVfYWRkcicgcGFy
YW1ldGVyIGluIGFtZGdwdV9zZXE2NF9hbGxvYygpDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9ubHkg
LSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNCltBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBBTUQgSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldDQoNClBpbmchPw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZB
U0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU2VudDogTW9uZGF5LCBOb3ZlbWJlciAxMSwgMjAyNCA4
OjE0IEFNDQpUbzogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47
IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCkNjOiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZB
U0FOLlNIQU5NVUdBTUBhbWQuY29tPg0KU3ViamVjdDogW1BBVENIXSBkcm0vYW1kL2FtZGdwdTog
QWRkIG1pc3Npbmcga2RvYyAnZ3B1X2FkZHInIHBhcmFtZXRlciBpbiBhbWRncHVfc2VxNjRfYWxs
b2MoKQ0KDQpGaXhlcyB0aGUgYmVsb3cgd2l0aCBnY2MgVz0xOg0KZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3NlcTY0LmM6MTY4OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3Igc3RydWN0IG1lbWJlciAnZ3B1X2FkZHInIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdwdV9zZXE2
NF9hbGxvYycNCg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+DQpTaWduZWQt
b2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5tdWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZXE2NC5jIHwgMyAr
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfc2VxNjQuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9zZXE2NC5jDQppbmRleCAwZGVmYWQ3MTA0
NGMuLjQxYWIyZTJjY2VmNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9zZXE2NC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
c2VxNjQuYw0KQEAgLTE1Niw3ICsxNTYsOCBAQCB2b2lkIGFtZGdwdV9zZXE2NF91bm1hcChzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV9mcHJpdiAqZnByaXYpDQogICoN
CiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyDQogICogQHZhOiBWQSB0byBhY2Nlc3Mg
dGhlIHNlcSBpbiBwcm9jZXNzIGFkZHJlc3Mgc3BhY2UNCi0gKiBAY3B1X2FkZHI6IENQVSBhZGRy
ZXNzIHRvIGFjY2VzcyB0aGUgc2VxDQorICogQGNwdV9hZGRyOiBDUFUgYWRkcmVzcyB0byBhY2Nl
c3MgdGhlIHNlcSBuby4NCisgKiBAZ3B1X2FkZHI6IEdQVSBhZGRyZXNzIHRvIGFjY2VzcyB0aGUg
c2VxIG5vLg0KICAqDQogICogQWxsb2MgYSA2NCBiaXQgbWVtb3J5IGZyb20gc2VxNjQgcG9vbC4N
CiAgKg0KLS0NCjIuMzQuMQ0KDQo=
