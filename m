Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B57FCCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 11:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B98389A1F;
	Wed, 29 Oct 2025 11:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g4QUfspv";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012032.outbound.protection.outlook.com [52.101.43.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3391D89954
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 11:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TF5LoUnCtI9Fs8kvouvkOhjB7AUTAY60PR742NE7hKuPlrijBDPHVjEqlLuTBQU87a4uBmT8iVXD4Y85nPOBU80rcpf2XqgoOqiXwPxxnQOYPH0q38FRsTJMWTyUfsqoUcL5RCHOL3mzR/RnfZ54/hRvNYUOn28PCV9bprRobSVlVzFeVSXS4F1MkBYgz2QTuLUqjJgMaAimZtX0/T3kDbC8uzaxaIMswz4RuJCFu7koMslevl4/Yxa18Ap19KDVAQtg876hGXlzUqV8+C792l973H5n1Gg4bMMfZI2fgeZg6EG0+E8ySjOFpJoyHtzp4MkhLu0syonAtNELAXmooQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKGD7cprMrdbauhRWa7J8Vvr80Dob5K9WpMXDTcTcXI=;
 b=HjNI0+rlHiLeJ1e3KlvBUexFs/1cWOt1rzbvvq84o3wzBmIf1NYs8pTsw9r7d+KJ8cNBY8UX4R395C0z3XaM4vJnJ6xPTJY6vH8p6SS+2N4SvvAKmeSN1lZpYLrW2TyVqYN3wy99WaHRRWF3jO+K/BkkpxyvMxvUV6bZn7q0p8w/4W3+qJ94gNEKwzkvp7J7B0JsocNBGkQ+5Q6g70rbjMXf3h+WR30CTqhVJyNMqFc2zi10rSAJBHUSc0TuwPtWAkPjcpGeu6DqMBeGU0CNXJBX987sHFa5zufTwJ2XzpydRf7bGlIqTP3PZ/lBY0DsD5RLmUGaPxrQV1h98ol1kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKGD7cprMrdbauhRWa7J8Vvr80Dob5K9WpMXDTcTcXI=;
 b=g4QUfspvEzYMQ85HBLaZS3idWdqzj7uKAoM/4Hr0XRKn4RfZW1G6e/ttBZrY6ygr8pjYgZIwWCnVs4AATmAU18ULm5RxlQgOnkxJ8PgZMnDAbLjpmvmH2TLqt3qBRJ1P0IhbGYrEaxK9yI1XDc61owSZYEz7Pp1ZwNWrc8pr2pA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 11:38:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 11:38:43 +0000
Message-ID: <9da7f3f0-58d8-4a7d-bbf9-1223e458e710@amd.com>
Date: Wed, 29 Oct 2025 12:38:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] drm/amdgpu/vce1: Implement VCE1 IP block
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-11-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251028220628.8371-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: caf76a2c-aaf6-433d-74fa-08de16dfb699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekxGcmZhN1V6S0pZemgvQVN3MHU0MjRRbUFINTlFeU1jSis5b09qUU1zU2lv?=
 =?utf-8?B?YkhvY3FvS2xpd0pIeUxtaVlzcThlL2pMdDNRYmkyZlJ4NldCM1dGbS94R2pn?=
 =?utf-8?B?M1hzSmhjM2RPZnhmUmI5a1dBcG4velYvR1ZSaUlnQWZXMm1hcEJBbDZLWVRX?=
 =?utf-8?B?R1Q2bHJkYWlvUHVYYUNqMkVUZGRiSjd0Mlo5MjBKSnZxUlhGM3R5UEI3K1RQ?=
 =?utf-8?B?aDd1Q2NXdmp0RitrVi9aOURJbVR1OXpRMHJ3bVhMd0thWnpZdUFPanJYYXB5?=
 =?utf-8?B?WWV1ZEgxVFZyaTdMdkJPMWs1T1BLNm1OOHREdnNlOUxQWDRlelNTYXRwd2xP?=
 =?utf-8?B?akhaMkl6bXdvLzZYZTZGQkNnb21aSXF0M1FSSXpYMS8vUWZvVnpuSFNxczBn?=
 =?utf-8?B?R2ZOSjR2aWt0Tjdkd0ZkNjZGN2ZLKzArNFJzeEQwOGJ2MWRKWXdCNUk5Z1VE?=
 =?utf-8?B?bythcXRRcEI1SEZwanMzOVJXVDk2b0NiZlVlQ3ArZmF1U2w2WC95WWNqRldz?=
 =?utf-8?B?WU5hWWJ3aWRrTEp1dm1EV3NxYTc4bG91RmN5L0l6emQ1NVZQd25wSGR1RkJs?=
 =?utf-8?B?aEtvajhLV2NQRTEyRnNtNFZYc1NIUjY5SVVrNlFROWhNVjNRVDYyd2ZOc3Bq?=
 =?utf-8?B?Y3V5QWJIbDIvSE0zQzlMQVMxZWpURkY5bE9VcGh4eXpzeWkyNTg3cHpqVHgz?=
 =?utf-8?B?V0dsa0ZVY0I1T2dlNUcwSXpJbFFWdnJ5K1pFQkg2aEhlM2VIaG5SeHNPckxU?=
 =?utf-8?B?VG9seTByQ2N1eldXL3pKbkY2ZlVMTjdSS28wT3VKaU1TM0lkS1AwYjZoU0Iv?=
 =?utf-8?B?UGtCbEpwQlhicFlnTXIxcFFMaHdpRnVxK2VkeVo3WitGbUJCeUljdFBrWFB0?=
 =?utf-8?B?TU94c0N6SHUrQTJpYmFQL2FEV0ErcTZncmdzWWdUN3lrUVlsMGJmcmtsWEpX?=
 =?utf-8?B?ZGV0dEt0TjlKQS9KdDY0NjExSWc4eDJOa01xVGJTRVBIS3lha3I0dEszcHpJ?=
 =?utf-8?B?dDRwZ2F4NlFXZ0xsUkI1S3ZQTkxkWEZIdS9tb2xNVFdqb2QxcW5SOU9seFps?=
 =?utf-8?B?NlBoQlBKS1FHZW8zaFU1ZDkzYXNXWUN3TzRWbjFHS003WU4wUktLUldGL2ky?=
 =?utf-8?B?NFUzbkJsNDZwTzBIb3ZCemRmdk5KelZpQ2c4K3g4MEllK0lHKy8xS1VHRWtT?=
 =?utf-8?B?UVI0S0JEUFRBcGcwTkV5MSsrUE9QVnlmTmNNaDRvTjRrNlVmWHI2cFNreDlw?=
 =?utf-8?B?N0ZTV1VDbmlsZUpsMUVQYlU1aXdVajY4SHpncXpMM3A0MTh0M2RIcE1BdUpy?=
 =?utf-8?B?bi9WaGllUEtYZHJMU0xFQ1gzdjVITEx3amRUQkJJdzJPcjdUSHQ5UXBZRklN?=
 =?utf-8?B?VTJkUTdkN3d1UDR3VWdhRmR2SW9VZDVHNU4zQzRiK01zbzJSOFJHOUd0bFV6?=
 =?utf-8?B?V0ZoV0RNZml5N3BxT09sL0tXT05iZXE3RVFUUzQ1c3JzWlRqZm1LT3RkQVJT?=
 =?utf-8?B?Yy9UYVdNL0VlbzdvRU1QaUJGR2tYVDJnVHZuZ3BBbDlDS2JtWHFHK0lvdXds?=
 =?utf-8?B?OVhDWnBVSUlCMmJMbkdMeDVYbTRkVHhsZjdldGRzd3VwRjQ2bU9oWlQySVJE?=
 =?utf-8?B?YjM5RXRBYWYzdlBhOGlJY3ZNU0djN3Mwb2Q4WDk0VmpZS0gxcy8rWmw5ajFu?=
 =?utf-8?B?RFU0Tzk1R1hqK0w1SEJvNHMyeFk2TU5YMDRqZktzUGVvdmhuVkEyeXIyVFN3?=
 =?utf-8?B?YWY1VFZWb2w5aEt5bWhyYUtuT0VFanU2Z1RQRnB4NUNCK3Zjd1lRM0F1ZDZp?=
 =?utf-8?B?d1Q4Z1FTZE43WTYyaHRFZW1mVGFuY0ZvZ1RNYlkvamQ2T1M5Y1Rsb09YeGpD?=
 =?utf-8?B?MGRDY2ZnSm1sMWh2ZGdBd3l0YUlpUUs1c1JrVDA1SVRGTjIxdHY4bXJRd2VJ?=
 =?utf-8?Q?ixGXAtk/T3fbBFlY2pak8cWZGufVawtc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0ppOFFETEh5WnJMVVhiOVdDNjBqUm1sUFRncUt5cWZYalBYYllZbVZ2K1g1?=
 =?utf-8?B?amppa1FmWkx1cXJNYU1TZHU5VUNMK2Yzc3NLQmdlS2NvdWV4cUY5dDVSdUg1?=
 =?utf-8?B?cG10K0pYTit4QVYzcHMwZTFEZ1U3UHpmbDIxYWovRkxqRm1Sd3JtQUFmR0R6?=
 =?utf-8?B?ZGVVOGs0VFBzejVMM2xOdGpGOW1BQTgxcWxoZm9jZWg0UWZPSWUwdlFmcEh0?=
 =?utf-8?B?Vkh6ditCRGo5a3M1a1ZiVjJ5OGxvMGNKZ3dPdmNxNGtmZjJPOE0yVkprVnRK?=
 =?utf-8?B?WTIwcG01WXNtUytyWTlhS0l6WVdLMEFDdUhwR2tqcXliTEZZa0dPaG5kcElv?=
 =?utf-8?B?OGhHelU2ZWgxMVZ5RVlwS3FTNm5CMXBqcDB4Mm9admczVkoxTlFma0VObUk2?=
 =?utf-8?B?NzIzYUVDZ1BoVmM0OTlSa2NxYXZKRUlJK1c0T1lYSW05d2ZZRm9qMkNZZDV2?=
 =?utf-8?B?YjZSa1d5U29veU1mc3dkRUFkVWw4V0tTUHdxUTRUZVoyMWdNOWl1SUluU1VT?=
 =?utf-8?B?RlZSeW1ST2t4RzNUYjFMc1NtQ1Nhc3RtRW10bE0vdnhzTDd6VFIwcXg0UWg3?=
 =?utf-8?B?OHhHQ2dIVk5YRGFZT3d6L2xrUDFLMTBLWXBpcG0xSE50Z2NwMjZuUy9VTFpL?=
 =?utf-8?B?elFXbVV5dzFBbXlWNjhYUHdtVGk3K0Z5U3hnV1dPU01YSkI0Rm41V3l4RDlW?=
 =?utf-8?B?YU16NUJUNXZ1UFNmQjRZY0lHMExXbTdsdE9rOXczQTNCUDhxK2JOOXY3RGRQ?=
 =?utf-8?B?dXROT3NoeVRiMmtXRHlZenI4dFNZTDdGM05HM0U5VXIyNzV6VGlDR29mN1Ix?=
 =?utf-8?B?b09Na1ZRU0VqTnNrNnlPR0FQUmo0VUptalI4UWQwZzR1SGhNNmk3bU8rTmJN?=
 =?utf-8?B?eFhJcE5DNEk2eXBvc3AwWFZhN2R3UXpGQ1BoSytyUUcvay9DOUgrck5kRE5n?=
 =?utf-8?B?MUxNZ3JVTVdIbkoydmtlTzZDd3dBMjhGZTVWTGY1c3BUK1EvbHFXWk52eFBP?=
 =?utf-8?B?ZGtuVWtqWlNOb0NjY0hEMGtLcFVYc0FhdTlBc0duc1lmNWExbjE0R3RCOXdh?=
 =?utf-8?B?bHlEcTMvSFUzL1F3a1B3RTVLaExsaWdiYmFnZkQxTHRZUENSMmpOVXBGTkJr?=
 =?utf-8?B?aS92UU0xTEZ3WFFTTXcvWjlMb3hFOUxWUzNLUVY1aTRKQTB2M2ppSVZNS0NU?=
 =?utf-8?B?b2poOWJudTNiY3lyU1I5TVBVT0Q4V092VTRrVHFxcmFPRjAxYTBHWHdGNzNM?=
 =?utf-8?B?czh5K2p2d01DY0VQc25xclVTUCtmM2lQcFh2WVFmM3kzYUNSdjhuaVp3dHVy?=
 =?utf-8?B?azN4VUQ1TWg5cTJSZE84K0E2MWp0dzh3Tk1Wa215YVZSdkxXeWpOVy9sTFgr?=
 =?utf-8?B?NGRMRXhYNFZkVG9sQWhpNzVYOHJDbjZ4QzFJcmNMNC9xRThmS0dITjBnckxy?=
 =?utf-8?B?dVVTS2dCN0FkOVlYcjhWYndZYUlGSFBaTUoyaWVnY293Myt5OTVYT0M5V0l1?=
 =?utf-8?B?RitDN253bUxzQkhnTzVRelBjZlJIN0JIYlB3SFBhcEtxZ0krOUgza1FtTW5l?=
 =?utf-8?B?WUtHdHBlMGMvYmxzd0JrM015Y2xjNVExNVlyUStsOTBuU3dUZkdKUlBUMjVr?=
 =?utf-8?B?N0ZnQy9KL2tJVTFTcUF5MHVaOG4rVmhPdDNLU0FlVkw2OXloUzU3c3hXcU9h?=
 =?utf-8?B?MmdVc0grYzYwbHA5d2QySUx4MmdtY1hnOTh4Z1lPNlFESHNudVpMVlJQV2xL?=
 =?utf-8?B?OWZkemgzTWc2OXdDNVNIOXlqTGRiRGVGWnFlWmQrWG95K2ZzeWlYRHZiSHV6?=
 =?utf-8?B?TDM1azlVWEYzdTRISTVqU2NRSjBEUFZtSlVqeC90UW5zN2w5MXVhdWZPL2Js?=
 =?utf-8?B?K21jMG5neHFXYnZhaW9UZjUyYlV3TUJaZFNGZGJkY1luQ2RZVGNUZzVRTjMy?=
 =?utf-8?B?QzczNWNLYWUxWWJldTJRTDUwaUNwK0Z0ZUxtNnkxZmFacGszWE1aUExhNG03?=
 =?utf-8?B?Y1h2ZkxJdy9IVXN1dzZWakhHdExRdHpMcnRiNHBVZGtCbE93c3IwaE9HQ0g5?=
 =?utf-8?B?clJIUSs4UGgrZWh1TlZPZFFXRXpVTGd1Z3RjeE1BMFlsY1Y2ODFWclc0TytY?=
 =?utf-8?Q?+HJfJS5TrwkBUjAH+iYK/rThk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf76a2c-aaf6-433d-74fa-08de16dfb699
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 11:38:43.2977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6haOQoJoYZM4x2sD0Ej515ywia7ZORzUvdI1NYl1uNB/ZZsppb1u8pwN52u/Lfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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

On 10/28/25 23:06, Timur Kristóf wrote:
> Implement the necessary functionality to support the VCE1.
> This implementation is based on:
> 
> - VCE2 code from amdgpu
> - VCE1 code from radeon (the old driver)
> - Some trial and error
> 
> A subsequent commit will ensure correct mapping for
> the VCPU BO, which will make this actually work.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> Co-developed-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |   1 +
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 805 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/vce_v1_0.h   |  32 +
>  4 files changed, 839 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ebe08947c5a3..c88760fb52ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -78,7 +78,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o \
>  	dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
>  
>  amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o \
> -	uvd_v3_1.o
> +	uvd_v3_1.o vce_v1_0.o
>  
>  amdgpu-y += \
>  	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index 22acd7b35945..050783802623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -51,6 +51,7 @@ struct amdgpu_vce {
>  	struct drm_sched_entity	entity;
>  	uint32_t                srbm_soft_reset;
>  	unsigned		num_rings;
> +	uint32_t		keyselect;
>  };
>  
>  int amdgpu_vce_early_init(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> new file mode 100644
> index 000000000000..e62fd8ed1992
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2013 Advanced Micro Devices, Inc.
> + * Copyright 2025 Valve Corporation
> + * Copyright 2025 Alexandre Demers
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + * Authors: Christian König <christian.koenig@amd.com>
> + *          Timur Kristóf <timur.kristof@gmail.com>
> + *          Alexandre Demers <alexandre.f.demers@gmail.com>
> + */
> +
> +#include <linux/firmware.h>
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vce.h"
> +#include "sid.h"
> +#include "vce_v1_0.h"
> +#include "vce/vce_1_0_d.h"
> +#include "vce/vce_1_0_sh_mask.h"
> +#include "oss/oss_1_0_d.h"
> +#include "oss/oss_1_0_sh_mask.h"
> +
> +#define VCE_V1_0_FW_SIZE	(256 * 1024)
> +#define VCE_V1_0_STACK_SIZE	(64 * 1024)
> +#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
> +#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
> +
> +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
> +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
> +
> +struct vce_v1_0_fw_signature {
> +	int32_t offset;
> +	uint32_t length;
> +	int32_t number;
> +	struct {
> +		uint32_t chip_id;
> +		uint32_t keyselect;
> +		uint32_t nonce[4];
> +		uint32_t sigval[4];
> +	} val[8];
> +};
> +
> +/**
> + * vce_v1_0_ring_get_rptr - get read pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Returns the current hardware read pointer
> + */
> +static uint64_t vce_v1_0_ring_get_rptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		return RREG32(mmVCE_RB_RPTR);
> +	else
> +		return RREG32(mmVCE_RB_RPTR2);
> +}
> +
> +/**
> + * vce_v1_0_ring_get_wptr - get write pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Returns the current hardware write pointer
> + */
> +static uint64_t vce_v1_0_ring_get_wptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		return RREG32(mmVCE_RB_WPTR);
> +	else
> +		return RREG32(mmVCE_RB_WPTR2);
> +}
> +
> +/**
> + * vce_v1_0_ring_set_wptr - set write pointer
> + *
> + * @ring: amdgpu_ring pointer
> + *
> + * Commits the write pointer to the hardware
> + */
> +static void vce_v1_0_ring_set_wptr(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +
> +	if (ring->me == 0)
> +		WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> +	else
> +		WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> +}
> +
> +static int vce_v1_0_lmi_clean(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 10; ++i) {
> +		for (j = 0; j < 100; ++j) {
> +			if (RREG32(mmVCE_LMI_STATUS) & 0x337f)
> +				return 0;
> +
> +			mdelay(10);
> +		}
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int vce_v1_0_firmware_loaded(struct amdgpu_device *adev)
> +{
> +	int i, j;
> +
> +	for (i = 0; i < 10; ++i) {
> +		for (j = 0; j < 100; ++j) {
> +			if (RREG32(mmVCE_STATUS) & VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK)
> +				return 0;
> +			mdelay(10);
> +		}
> +
> +		dev_err(adev->dev, "VCE not responding, trying to reset the ECPU\n");
> +
> +		WREG32_P(mmVCE_SOFT_RESET,
> +			VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
> +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +		mdelay(10);
> +		WREG32_P(mmVCE_SOFT_RESET, 0,
> +			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
> +		mdelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static void vce_v1_0_init_cg(struct amdgpu_device *adev)
> +{
> +	u32 tmp;
> +
> +	tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +	tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +	WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +	tmp = RREG32(mmVCE_CLOCK_GATING_B);
> +	tmp |= 0x1e;
> +	tmp &= ~0xe100e1;
> +	WREG32(mmVCE_CLOCK_GATING_B, tmp);
> +
> +	tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +	tmp &= ~0xff9ff000;
> +	WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +	tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +	tmp &= ~0x3ff;
> +	WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +}
> +
> +/**
> + * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * The VCE1 firmware validation mechanism needs a firmware signature.
> + * This function finds the signature appropriate for the current
> + * ASIC and writes that into the VCPU BO.
> + */
> +static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
> +{
> +	const struct common_firmware_header *hdr;
> +	struct vce_v1_0_fw_signature *sign;
> +	unsigned int ucode_offset;
> +	uint32_t chip_id;
> +	u32 *cpu_addr;
> +	int i, r;
> +
> +	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
> +	ucode_offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
> +
> +	sign = (void *)adev->vce.fw->data + ucode_offset;
> +
> +	switch (adev->asic_type) {
> +	case CHIP_TAHITI:
> +		chip_id = 0x01000014;
> +		break;
> +	case CHIP_VERDE:
> +		chip_id = 0x01000015;
> +		break;
> +	case CHIP_PITCAIRN:
> +		chip_id = 0x01000016;
> +		break;
> +	default:
> +		dev_err(adev->dev, "asic_type %#010x was not found!", adev->asic_type);
> +		return -EINVAL;
> +	}
> +

> +	ASSERT(adev->vce.vcpu_bo);

Please drop that.

> +
> +	r = amdgpu_bo_reserve(adev->vce.vcpu_bo, false);
> +	if (r) {
> +		dev_err(adev->dev, "%s (%d) failed to reserve VCE bo\n", __func__, r);
> +		return r;
> +	}
> +
> +	r = amdgpu_bo_kmap(adev->vce.vcpu_bo, (void **)&cpu_addr);
> +	if (r) {
> +		amdgpu_bo_unreserve(adev->vce.vcpu_bo);
> +		dev_err(adev->dev, "%s (%d) VCE map failed\n", __func__, r);
> +		return r;
> +	}

That part is actually pretty pointless the cpu addr is already available as adev->vce.cpu_addr.

> +
> +	for (i = 0; i < le32_to_cpu(sign->number); ++i) {
> +		if (le32_to_cpu(sign->val[i].chip_id) == chip_id)
> +			break;
> +	}
> +
> +	if (i == le32_to_cpu(sign->number)) {
> +		dev_err(adev->dev, "%s chip_id %#010x was not found for %s in VCE firmware",
> +			__func__, chip_id, amdgpu_asic_name[adev->asic_type]);

Drop the __func__ here. It should be obvious where we are fro the message.

> +		return -EINVAL;
> +	}
> +
> +	cpu_addr += (256 - 64) / 4;
> +	cpu_addr[0] = sign->val[i].nonce[0];
> +	cpu_addr[1] = sign->val[i].nonce[1];
> +	cpu_addr[2] = sign->val[i].nonce[2];
> +	cpu_addr[3] = sign->val[i].nonce[3];
> +	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
> +
> +	memset(&cpu_addr[5], 0, 44);
> +	memcpy(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes - sizeof(*sign));

That should probably be memcpy_io() and the direct writes to cpu_addr modified as well.

> +
> +	cpu_addr += (le32_to_cpu(sign->length) + 64) / 4;
> +	cpu_addr[0] = sign->val[i].sigval[0];
> +	cpu_addr[1] = sign->val[i].sigval[1];
> +	cpu_addr[2] = sign->val[i].sigval[2];
> +	cpu_addr[3] = sign->val[i].sigval[3];
> +
> +	adev->vce.keyselect = le32_to_cpu(sign->val[i].keyselect);
> +


> +	amdgpu_bo_kunmap(adev->vce.vcpu_bo);
> +	amdgpu_bo_unreserve(adev->vce.vcpu_bo);

That can be dropped as well.

> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_wait_for_fw_validation(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < 10; ++i) {
> +		mdelay(10);
> +		if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)
> +			break;
> +	}
> +
> +	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)) {
> +		dev_err(adev->dev, "%s VCE validation timeout\n", __func__);
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__PASS_MASK)) {
> +		dev_err(adev->dev, "%s VCE firmware validation failed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < 10; ++i) {
> +		mdelay(10);
> +		if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK))
> +			break;
> +	}
> +
> +	if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK) {
> +		dev_err(adev->dev, "%s VCE firmware busy timeout\n", __func__);

Here as well, please drop the __func__ arguments.

> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
> +{
> +	uint32_t offset;
> +	uint32_t size;
> +
> +	/* When the keyselect is already set, don't perturb VCE FW.
> +	 * Validation seems to always fail the second time.
> +	 */

Coding style for multi line /* */ comments! checkpatch.pl should point out when that is wrong.

> +	if (RREG32(mmVCE_LMI_FW_START_KEYSEL)) {
> +		dev_dbg(adev->dev, "%s keyselect already set: 0x%x (on CPU: 0x%x)\n",
> +			__func__, RREG32(mmVCE_LMI_FW_START_KEYSEL), adev->vce.keyselect);
> +
> +		WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> +		return 0;
> +	}
> +
> +	WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
> +	WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000, ~0xFF9FF000);
> +	WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
> +	WREG32(mmVCE_CLOCK_GATING_B, 0);
> +
> +	WREG32_P(mmVCE_LMI_FW_PERIODIC_CTRL, 0x4, ~0x4);
> +
> +	WREG32(mmVCE_LMI_CTRL, 0x00398000);
> +
> +	WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
> +	WREG32(mmVCE_LMI_SWAP_CNTL, 0);
> +	WREG32(mmVCE_LMI_SWAP_CNTL1, 0);
> +	WREG32(mmVCE_LMI_VM_CTRL, 0);
> +
> +	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
> +
> +	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
> +	size = VCE_V1_0_FW_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
> +
> +	offset += size;
> +	size = VCE_V1_0_STACK_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
> +
> +	offset += size;
> +	size = VCE_V1_0_DATA_SIZE;
> +	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
> +	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
> +
> +	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
> +
> +	dev_dbg(adev->dev, "VCE keyselect: %d", adev->vce.keyselect);
> +	WREG32(mmVCE_LMI_FW_START_KEYSEL, adev->vce.keyselect);
> +
> +	return vce_v1_0_wait_for_fw_validation(adev);

Maybe inline wait_for_fw_validation here, it doesn't make much sense to write START_KEYSEL outside and then have that in a separate function.

Regards,
Christian.

> +}
> +
> +/**
> + * vce_v1_0_is_idle() - Check idle status of VCE1 IP block
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + *
> + * Check whether VCE is busy according to VCE_STATUS.
> + * Also check whether the SRBM thinks VCE is busy, although
> + * SRBM_STATUS.VCE_BUSY seems to be bogus because it
> + * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
> + */
> +static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	bool busy =
> +		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK | VCE_STATUS__UENC_BUSY_MASK)) ||
> +		(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
> +
> +	return !busy;
> +}
> +
> +static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	unsigned int i;
> +
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		udelay(1);
> +		if (vce_v1_0_is_idle(ip_block))
> +			return 0;
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +/**
> + * vce_v1_0_start - start VCE block
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Setup and start the VCE block
> + */
> +static int vce_v1_0_start(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ring *ring;
> +	int r;
> +
> +	WREG32_P(mmVCE_STATUS, 1, ~1);
> +
> +	r = vce_v1_0_mc_resume(adev);
> +	if (r)
> +		return r;
> +
> +	ring = &adev->vce.ring[0];
> +	WREG32(mmVCE_RB_RPTR, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_SIZE, ring->ring_size / 4);
> +
> +	ring = &adev->vce.ring[1];
> +	WREG32(mmVCE_RB_RPTR2, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
> +	WREG32(mmVCE_RB_BASE_LO2, lower_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
> +	WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
> +
> +	WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK,
> +		 ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +
> +	WREG32_P(mmVCE_SOFT_RESET,
> +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	mdelay(100);
> +
> +	WREG32_P(mmVCE_SOFT_RESET, 0,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	r = vce_v1_0_firmware_loaded(adev);
> +
> +	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy. */
> +	WREG32(mmVCE_STATUS, 0);
> +
> +	if (r) {
> +		dev_err(adev->dev, "VCE not responding, giving up!!!\n");
> +		return r;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_stop(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ip_block *ip_block;
> +	int status;
> +	int i;
> +
> +	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	if (vce_v1_0_lmi_clean(adev))
> +		dev_warn(adev->dev, "%s VCE is not idle\n", __func__);
> +
> +	if (vce_v1_0_wait_for_idle(ip_block))
> +		dev_warn(adev->dev, "VCE is busy: VCE_STATUS=0x%x, SRBM_STATUS2=0x%x\n",
> +			RREG32(mmVCE_STATUS), RREG32(mmSRBM_STATUS2));
> +
> +	/* Stall UMC and register bus before resetting VCPU */
> +	WREG32_P(mmVCE_LMI_CTRL2, 1 << 8, ~(1 << 8));
> +
> +	for (i = 0; i < 100; ++i) {
> +		status = RREG32(mmVCE_LMI_STATUS);
> +		if (status & 0x240)
> +			break;
> +		mdelay(1);
> +	}
> +
> +	WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_CNTL__CLK_EN_MASK);
> +
> +	WREG32_P(mmVCE_SOFT_RESET,
> +		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
> +		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
> +		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
> +
> +	WREG32(mmVCE_STATUS, 0);
> +
> +	return 0;
> +}
> +
> +static void vce_v1_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
> +{
> +	u32 tmp;
> +
> +	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG)) {
> +		tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +		tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +		tmp &= ~0x1ff000;
> +		tmp |= 0xff800000;
> +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +		tmp &= ~0x3ff;
> +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +	} else {
> +		tmp = RREG32(mmVCE_CLOCK_GATING_A);
> +		tmp &= ~VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
> +		WREG32(mmVCE_CLOCK_GATING_A, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
> +		tmp |= 0x1ff000;
> +		tmp &= ~0xff800000;
> +		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
> +
> +		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
> +		tmp |= 0x3ff;
> +		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
> +	}
> +}
> +
> +static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_early_init(adev);
> +	if (r)
> +		return r;
> +
> +	adev->vce.num_rings = 2;
> +
> +	vce_v1_0_set_ring_funcs(adev);
> +	vce_v1_0_set_irq_funcs(adev);
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_ring *ring;
> +	int r, i;
> +
> +	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 167, &adev->vce.irq);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_vce_sw_init(adev, VCE_V1_0_FW_SIZE +
> +		VCE_V1_0_STACK_SIZE + VCE_V1_0_DATA_SIZE);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_vce_resume(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		enum amdgpu_ring_priority_level hw_prio = amdgpu_vce_get_ring_prio(i);
> +
> +		ring = &adev->vce.ring[i];
> +		sprintf(ring->name, "vce%d", i);
> +		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> +				     hw_prio, NULL);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +static int vce_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_suspend(adev);
> +	if (r)
> +		return r;
> +
> +	return amdgpu_vce_sw_fini(adev);
> +}
> +
> +/**
> + * vce_v1_0_hw_init - start and test VCE block
> + *
> + * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
> + *
> + * Initialize the hardware, boot up the VCPU and do some testing
> + */
> +static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int i, r;
> +
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vce(adev, true);
> +	else
> +		amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
> +		if (r)
> +			return r;
> +	}
> +
> +	dev_info(adev->dev, "VCE initialized successfully.\n");
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
> +{
> +	int r;
> +
> +	r = vce_v1_0_stop(ip_block->adev);
> +	if (r)
> +		return r;
> +
> +	cancel_delayed_work_sync(&ip_block->adev->vce.idle_work);
> +	return 0;
> +}
> +
> +static int vce_v1_0_suspend(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	/*
> +	 * Proper cleanups before halting the HW engine:
> +	 *   - cancel the delayed idle work
> +	 *   - enable powergating
> +	 *   - enable clockgating
> +	 *   - disable dpm
> +	 *
> +	 * TODO: to align with the VCN implementation, move the
> +	 * jobs for clockgating/powergating/dpm setting to
> +	 * ->set_powergating_state().
> +	 */
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	if (adev->pm.dpm_enabled) {
> +		amdgpu_dpm_enable_vce(adev, false);
> +	} else {
> +		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_CG_STATE_GATE);
> +	}
> +
> +	r = vce_v1_0_hw_fini(ip_block);
> +	if (r) {
> +		dev_err(adev->dev, "vce_v1_0_hw_fini() failed with error %i", r);
> +		return r;
> +	}
> +
> +	return amdgpu_vce_suspend(adev);
> +}
> +
> +static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int r;
> +
> +	r = amdgpu_vce_resume(adev);
> +	if (r)
> +		return r;
> +	r = vce_v1_0_load_fw_signature(adev);
> +	if (r)
> +		return r;
> +
> +	return vce_v1_0_hw_init(ip_block);
> +}
> +
> +static int vce_v1_0_set_interrupt_state(struct amdgpu_device *adev,
> +					struct amdgpu_irq_src *source,
> +					unsigned int type,
> +					enum amdgpu_interrupt_state state)
> +{
> +	uint32_t val = 0;
> +
> +	if (state == AMDGPU_IRQ_STATE_ENABLE)
> +		val |= VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK;
> +
> +	WREG32_P(mmVCE_SYS_INT_EN, val,
> +		 ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
> +	return 0;
> +}
> +
> +static int vce_v1_0_process_interrupt(struct amdgpu_device *adev,
> +				      struct amdgpu_irq_src *source,
> +				      struct amdgpu_iv_entry *entry)
> +{
> +	dev_dbg(adev->dev, "IH: VCE\n");
> +	switch (entry->src_data[0]) {
> +	case 0:
> +	case 1:
> +		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
> +		break;
> +	default:
> +		dev_err(adev->dev, "Unhandled interrupt: %d %d\n",
> +			  entry->src_id, entry->src_data[0]);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_clockgating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	vce_v1_0_init_cg(adev);
> +	vce_v1_0_enable_mgcg(adev, state == AMD_CG_STATE_GATE);
> +
> +	return 0;
> +}
> +
> +static int vce_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +
> +	/* This doesn't actually powergate the VCE block.
> +	 * That's done in the dpm code via the SMC.  This
> +	 * just re-inits the block as necessary.  The actual
> +	 * gating still happens in the dpm code.  We should
> +	 * revisit this when there is a cleaner line between
> +	 * the smc and the hw blocks
> +	 */
> +	if (state == AMD_PG_STATE_GATE)
> +		return vce_v1_0_stop(adev);
> +	else
> +		return vce_v1_0_start(adev);
> +}
> +
> +static const struct amd_ip_funcs vce_v1_0_ip_funcs = {
> +	.name = "vce_v1_0",
> +	.early_init = vce_v1_0_early_init,
> +	.sw_init = vce_v1_0_sw_init,
> +	.sw_fini = vce_v1_0_sw_fini,
> +	.hw_init = vce_v1_0_hw_init,
> +	.hw_fini = vce_v1_0_hw_fini,
> +	.suspend = vce_v1_0_suspend,
> +	.resume = vce_v1_0_resume,
> +	.is_idle = vce_v1_0_is_idle,
> +	.wait_for_idle = vce_v1_0_wait_for_idle,
> +	.set_clockgating_state = vce_v1_0_set_clockgating_state,
> +	.set_powergating_state = vce_v1_0_set_powergating_state,
> +};
> +
> +static const struct amdgpu_ring_funcs vce_v1_0_ring_funcs = {
> +	.type = AMDGPU_RING_TYPE_VCE,
> +	.align_mask = 0xf,
> +	.nop = VCE_CMD_NO_OP,
> +	.support_64bit_ptrs = false,
> +	.no_user_fence = true,
> +	.get_rptr = vce_v1_0_ring_get_rptr,
> +	.get_wptr = vce_v1_0_ring_get_wptr,
> +	.set_wptr = vce_v1_0_ring_set_wptr,
> +	.parse_cs = amdgpu_vce_ring_parse_cs,
> +	.emit_frame_size = 6, /* amdgpu_vce_ring_emit_fence  x1 no user fence */
> +	.emit_ib_size = 4, /* amdgpu_vce_ring_emit_ib */
> +	.emit_ib = amdgpu_vce_ring_emit_ib,
> +	.emit_fence = amdgpu_vce_ring_emit_fence,
> +	.test_ring = amdgpu_vce_ring_test_ring,
> +	.test_ib = amdgpu_vce_ring_test_ib,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.begin_use = amdgpu_vce_ring_begin_use,
> +	.end_use = amdgpu_vce_ring_end_use,
> +};
> +
> +static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev)
> +{
> +	int i;
> +
> +	for (i = 0; i < adev->vce.num_rings; i++) {
> +		adev->vce.ring[i].funcs = &vce_v1_0_ring_funcs;
> +		adev->vce.ring[i].me = i;
> +	}
> +};
> +
> +static const struct amdgpu_irq_src_funcs vce_v1_0_irq_funcs = {
> +	.set = vce_v1_0_set_interrupt_state,
> +	.process = vce_v1_0_process_interrupt,
> +};
> +
> +static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev)
> +{
> +	adev->vce.irq.num_types = 1;
> +	adev->vce.irq.funcs = &vce_v1_0_irq_funcs;
> +};
> +
> +const struct amdgpu_ip_block_version vce_v1_0_ip_block = {
> +	.type = AMD_IP_BLOCK_TYPE_VCE,
> +	.major = 1,
> +	.minor = 0,
> +	.rev = 0,
> +	.funcs = &vce_v1_0_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> new file mode 100644
> index 000000000000..206e7bec897f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + * Copyright 2025 Valve Corporation
> + * Copyright 2025 Alexandre Demers
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __VCE_V1_0_H__
> +#define __VCE_V1_0_H__
> +
> +extern const struct amdgpu_ip_block_version vce_v1_0_ip_block;
> +
> +#endif

