Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D88BEFB819
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 08:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC1C10E515;
	Tue, 24 Feb 2026 08:54:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4LMNPC6Q";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012052.outbound.protection.outlook.com
 [40.107.200.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E648310E517
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 08:54:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ustcum1TBq0Md3iOOhLq+DjDns7pHFLdR6E6WAE3zE6ISAJ+yc/lrrTePXKmUEoClc6ugRGu+SI64oaH/V2AcvbEjEWjLh8e80UIYSKSekOyh7ME9prhoUHDNC6KdsNIoCDS40JSC50tWjfwTa9lHr9y9hgJiVxJ5IrOuHoLEKI72eq03Knc34kCjenJDUFwf+GYaRnmFHESEn110g0Aip/tmFDd41llO1lZIiQE4JeeqcQMSoBUM2TRajB9CCDADTztXfdaIQQvj72pgKgOwuIfheT4CMJi0FwwvIjnkYIPAyZbgYiC5NdKUSDvSKJ576AdEHD1ig75bJtbH2z4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5G2brKVNfe715Bxp6byg6cp3jRo7UtaoVUwGHLjRlk=;
 b=RVDgfx8wy8AurzsShh40YElLrsyyExIKSnjjBREn3EN15UwXD7eGMmWJwNHGyv5CJFsT+4x+qkJK9E7N0Q3rNnzHnJ0m7s8LUPoXfjNj9jnjm/p36ZuiU6cQAN6WHU+54sWOhEGPclpgNwdUwwE04XbNvE2wNrzWSofi9SNWEZu3AzmGnGDFR8rS+0gfDre7QkH15uXbFqhwnvYnT+0d5Kw929DMmq6CzQW/24MDZC2f5gBB0E1MXuLFQsKUFoV8e64Uptt2fP4oPGNFh0bBbPvKpMPLlQrRNBHqDYPm3q++8CuIxcxVJu1R1hZAGTYuPOhoUqHpSpHHextmdATkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5G2brKVNfe715Bxp6byg6cp3jRo7UtaoVUwGHLjRlk=;
 b=4LMNPC6QgDu5K/JJbKVDFHvT/CJrxwLQGKDaaCQ+3q+FVPVx2HY98i0vDwD6rSSyO8qj6j+oiKmvimRM+CTRmnpuZIqhYfPxYejOh/gQW0VmPAXCA1FiF0gUcTnicQ2CCWWhpbqC4Sb8pRLH5jsP4U0lNHre5AgqxJa5x1RbNc0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 08:54:14 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:54:14 +0000
Content-Type: multipart/alternative;
 boundary="------------0KuaJiIcr88Tz2uHarhhqebw"
Message-ID: <ed4ad63e-0e09-4cf7-b3e0-5154053dc7a1@amd.com>
Date: Tue, 24 Feb 2026 14:24:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: add upper bound check on user inputs
 in wait ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <20260224082443.4002292-4-sunil.khatri@amd.com>
 <2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com>
X-ClientProxiedBy: MA1P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::28) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LV8PR12MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: b9685fe6-8979-4e03-b3ad-08de73824907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TThRRkRGY0l2K1RTR2hGbW4waTAwdTZja3ZXend5eVU4K3BGM1lYOFJlbVBO?=
 =?utf-8?B?TGwzRkF4VWpKRFl2T3VLaGxoa0RBVnM5ZEYzQW9DZDlmdnpqYisvVzdpbXJR?=
 =?utf-8?B?eXN6bHZMditPRmRmKzhoSTZiL1cvNkVkYU12NmdJZlZNNk5haFlQTSs4THdi?=
 =?utf-8?B?cG16RldhUllQQTc5OEFBYStyVWtLQ2hyWmZJOEhvaWVwNGtYNStJaVBMR25Z?=
 =?utf-8?B?MTJieTlYTlhnWWZNYVhLUUhmS0RCTmYvSEhtbUg2NC9uZ1A2a1laNXNXVXRY?=
 =?utf-8?B?RnVPMDhlTXU3TlRaSlhsckUzMlZrTjdVL1J5dXRMRVM2Y01QcUVhb2JWL2Yr?=
 =?utf-8?B?YnVyckVVa1pSUFVnOWZ5dXA3UUlndDVPUThwa1JDa0F6dFpzMUdxaXVMUXBL?=
 =?utf-8?B?M0c4SXR5Y05uVjlCei9ORzdtRzlzK3ZJVUhOVXJwREIrN09idkNRcGY2bEo5?=
 =?utf-8?B?cU5JdHd0TFIxOUEwUHBNU2o5K25UQS92ZG1JMHRmYlZOb0tlYmJselE5UWE2?=
 =?utf-8?B?bzBXdm9Rc096ZEcvN0VuWU0xK3o0end2ZFZMMlgxSUtTOTJaNW1vTGRUb2p2?=
 =?utf-8?B?Ym1yYkUvOEdYS2ttVm04b0dLdHdvbURZTDdJaCtJcWVLSFVBa2c3bmNucnZJ?=
 =?utf-8?B?Y1RuRTF1a1RvZ0VLZ09BeC9tTlRYbGlhdWtYYjRtR3dkbE1HazNLOFlVZDh3?=
 =?utf-8?B?aWdVdzFjZFY1Uko5ZGFvZENKWStDN3did08wQjJ2U2FkNTdMT3VCY2ROM2hJ?=
 =?utf-8?B?WjJlZ0J0NnBJUi9GS1VNdStaWFpFQ2hyeVh3VnVtc1ZFRkkzTTg3YXZjaVBa?=
 =?utf-8?B?MlRpNjlCeWlaN3llYWhNU2Fxb09jV00rZCtHT1dyaEp6aXBkZGxnNkp2UzZq?=
 =?utf-8?B?c3lwZHR3THpWRVcxYjRIVlpMSE1WUzcvc2QwcDVmSWZBeCtBN1h5eGpZWjE1?=
 =?utf-8?B?cGF6eHdPRUhid2VFVUVCWVRhaFZxaTZ4ZUxjOVlPRkd4SERaS01IYklKUytz?=
 =?utf-8?B?QmtwRTF5Yk5HVWVrUGV0TnhhY0FGeml2K3Y2UGRlaFZDWHZLbW9VbTUvdHYx?=
 =?utf-8?B?bHlMWjdRQXFaQW11TEFwbW1HNlRPQXZjWFJlRHNVaEVDVlVyMkVqQXZkWUZO?=
 =?utf-8?B?NWJpMWxxNm5Hd2hMTy92TXUzVk5aNVlkYzVXOUtBd3lKZ2hMNDVCSjZMcE9P?=
 =?utf-8?B?QTg3TVdBNnE1UFN5bkl0K21PVFVmeDIxT0Zsa21WS3BlQzh5V3VjVDNER3lP?=
 =?utf-8?B?M1JtNDN6L3NqL2hXMlZiWUdGUnkwRTBCL3psQTNXSDNJeXRoL1FKVDFwL0Zh?=
 =?utf-8?B?bVN4aDQvb0d3QWNuNDhKV1VNL3NGcm4vNDZ1U1FhcGl0bURpcUVUUVJWZ2pH?=
 =?utf-8?B?eU5HN2hqVUFCaEZXd1Jva05ubFJrRWxDR0ZPL2tmeDduZ0w5alFWNmkvTytO?=
 =?utf-8?B?OEs5eWJwZzVqMW9MSUlGMHN3NjJBZEFkcXZFcHZURjkrRFVmTjdaRjAzOTF0?=
 =?utf-8?B?SS80NmJiMjE4YUlsdmNBUkphNUVRaHVRTTB5Mmg2SDc3SmlMbGN4RitvTmYw?=
 =?utf-8?B?NThhVFZtbjRHak5HdU15YmtsR2Y3QitRdVpRMWZsYzB2R0ZhREFKTU13aEZD?=
 =?utf-8?B?SWxmK05mRE1vWXozdU1RdWxPcnltWnRZcVl6alAxY1dndUtyMmxYTmlBdTdW?=
 =?utf-8?B?WitHYWRuMnFGeURMZHRKYjh2a0IzYVhNTU5mckljT0xGTmZ6bTNIaDl4cmFu?=
 =?utf-8?B?L1dqVjl6ZUg3aDVKTGVyRjRTQVlvbnQxN2k3Zk5RcGMxaHFyeXB2SmozN2lU?=
 =?utf-8?B?Q21hTEhRdStFa1B5bWNDQllncmdKNEFzaWRPY0JvRW9xZExWOTI0UkdXLzRW?=
 =?utf-8?B?bHpEb05lYmg0WEdVd0tKYkp1aEkyK243UmdDOUFjRmJHTG1OeDJOcXd3MzZH?=
 =?utf-8?B?bXNTK1dkR2t6QUxEZEhpT05wRmZub3ZtdHQ5SFpVLzZYdjZoOFRtL09yVkFF?=
 =?utf-8?B?M21CUk5Uclp6aVU4M003Q3pGOGlFSTZYSUN4ZlVYMS9BcVNzc0ppMU15dzZL?=
 =?utf-8?B?WFFWZmVnU1VzM0ZHOURUVmRjZE10cVpJR0FGbUF2OENqY0pVditWODcrZDFR?=
 =?utf-8?Q?9arU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRNT2lVTjZwYlpQQWRoTUdPUjZGa082UXBxcGJyaXVVWEZwbWI0K3NMOXZy?=
 =?utf-8?B?WFI0eHh2RENrSmlDa2lIelFqY3kzT2grRnFqaTBueVlkTGdPWnhsNTRZN2Vn?=
 =?utf-8?B?cVVHMnpMaDh3ai9DVG1YUmx2TE95d3JrOEJGeHltdWdsSUs0aC9SS2RYaUY4?=
 =?utf-8?B?K1kydjRZa0pSeWtzcXgzcFpMS2FrY21mQk82K1JuZ3VKcDhYdENEU2lHdU1x?=
 =?utf-8?B?eXFhczhBTk1mUzk5T0M1TXBhYUVCUTV3K21sUkNIU1l2KzBrRUNRaTJ3Nmpk?=
 =?utf-8?B?Nzdmem1DVTJVZm1uVDFxNlNWM2t3UHBZd1JsKy8yRUxWSVNiRW5UOW5ScnV2?=
 =?utf-8?B?NUJ4Y1Z1VURhVGoyMytWWVczQTBFZzI0aEpFRUphc0lEd2hacHVOR1Jkb3dG?=
 =?utf-8?B?VGZQUTYva2FCWndiOWJOaHV5TW9hV2pFQ2lvVEZkK0RtZHpxSnJ5bG0vMHVT?=
 =?utf-8?B?NG1zTVRpV01sUHJ2L0FkZzRaZ1E4WEdHRGk5RDNUVGQ2dUFIWHpkSTV0bmpv?=
 =?utf-8?B?RGNZUzBKRFdVeUQ2dzF2U0NwTXpYSmIrODFOVE5FMHMwVmF1UWJBNnJOUys2?=
 =?utf-8?B?YUNINVNsd1NuZlRFaURNcGV4RTZldTRybmp5KytvVlFzREx6NVZneXBQay9t?=
 =?utf-8?B?Mlk1SjB6WkxCQ2d4WG5KMzNjcHFJbHZmTU9hajVrK24xY0pwTEZPVVJ6dUFh?=
 =?utf-8?B?YnpnNXAxeG5PMGFXWHp1YmlCbEJHK05GaUZOaytlTlpGRnlLMmpvdThxY3o0?=
 =?utf-8?B?Z3JYTkxrZHlVUm9UOW1KSC8rVlREbFMxOVY1K0FMMktWS2RJQWJXN0N1NVBD?=
 =?utf-8?B?Yk1WTDFpV2lDbXJsM1ByWWNkcHI4L3FDK3k3cXB6VjcweVV0dlBLTzlCalBJ?=
 =?utf-8?B?NnRRTXFHb0FQN21GZldKZDdwOFVQUGl3Z2VoRHFzRU93RGx6Wnc2YzNPd1RW?=
 =?utf-8?B?R2Y4aC8vQ3NSVFRjcW9FdGJKc3NVQXZGV1dZRTBpVTJFc3ZxOWN0VUE1dWhT?=
 =?utf-8?B?ZGxTaE1saXFEM2VRa3J4R0lZOUhZSUVpUWJCMUhrU0tHTG5ra2pUcnRqbXg5?=
 =?utf-8?B?VGRuODM2cURKOUVXTXJiV3pVQjQ5Y3FsL3lma1dNeDZpYzhjOFdCcUtyWThU?=
 =?utf-8?B?eTlLZUtINUF2VGJ2WnIzYjc1OEtHMVdmY1R2Vjk4RDZhZ0R2V2dVR0xvUTd0?=
 =?utf-8?B?QVoxUXhLUlFkaCtkanFoUGswTTZHMUVualI0QXBkLzlPTjlCMmhFdGlRMjdQ?=
 =?utf-8?B?V3RPM0pPczk2aDFrTVJwMmNobnFZSFRUbnU4Z3g0K3pRU2l6ZFo5OG9GUWdY?=
 =?utf-8?B?bmM0UmVMNGZLTWxqTnpnUnl4Rlp3ZW85WHBRUkFtUFUxd2NXcnRDZmZzWUFV?=
 =?utf-8?B?eTdwSE8wcjJzQWJ3TnR5d3pwYkZhcjBWajVUUms3anl3eVpBcmhEU2F5TTc2?=
 =?utf-8?B?T2t1Y1dEb1pNeldlVEV2TVRXbFBreE5SNlVUM0Z6cE1SYkZ3cGs5M1E2Lzlj?=
 =?utf-8?B?R3pEa3p5dWdYWFRHNldncHNUWkdZMHZneXVaRjJUSUZNQU93T1N1VnNhejMr?=
 =?utf-8?B?WFIrK2kzS25RVk9iS0JxenEzNkFic0ExSllGK2RYV0FzUHUvVVIxdTN6c1Q5?=
 =?utf-8?B?TGw0bnpUam1iLzg1OXRFd2VzdjY2MWQ3VklOb0hkalBlWmhOUlZYazhIZ041?=
 =?utf-8?B?T1YwRVRnRnIvL1U1NmtNQzc1S1VqUzFyeG1ycU9ETmFOVVczVEJhTGEycklX?=
 =?utf-8?B?amJkbUdJSWNONnpVcEcrQUQ0Y2J5cW1yT3JnZTREUnZVMXNRQ09mMFhwRWx5?=
 =?utf-8?B?ZmJGSmQ3czNwQ2N0TlZmem1pZ2FnakF0M25FM3hTc1pWMnZGa1lQUXFMTGNN?=
 =?utf-8?B?KzA4ajZadkVYcDJvNFBJRWRmVTB1UjdkOXNsM3BFbWV1aGxLeGM2T3haVUdU?=
 =?utf-8?B?ZTM1L1lDT0Y1SVAvanZVemY3U2lhN0tEaTRNTnFjbVYwNUpiUWorT0lZOE5Q?=
 =?utf-8?B?dVUzVFdGNFM1Qms2ZWRKWmJmVjZIa21tcTNVRWxsRnd4UEVTQitScklRZnFZ?=
 =?utf-8?B?MWdFK3pyZkhwWVFuaXdpZWdMYklRNWtLY3VEcXpWc3o1WGxnRHprYmgwbkpn?=
 =?utf-8?B?dHZJYVpja20wdkJvenBTdVFZWkI1eENDWHJXZmNxVDdVV2tRS3dpWjd5eitJ?=
 =?utf-8?B?TkdQU0d1bnlwd2NQMzg2d3hNeG1JcFdnOGRNNlNweUlzUk4zU3RYVTA2bWE1?=
 =?utf-8?B?VU9SUk9Iemh4Nkhlb0dHU2J1bEdaRVpvOUhPSVMyYXJVZEFmdExuejRmOElj?=
 =?utf-8?B?QXRuaVFqWFlQcVF3OEY5MFYxejZHUzkxQUxiK1pNSUNIQWtKblhkUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9685fe6-8979-4e03-b3ad-08de73824907
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:54:14.2212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +jH2oQYCQ/a5H2936q9trTglSG5P8oETs/s+X+2jFU68wBkbqOGcg+5do7TALftxVDkfTz8K4BKTZQKjbjgs1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689
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

--------------0KuaJiIcr88Tz2uHarhhqebw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24-02-2026 02:15 pm, Christian König wrote:
>
> On 2/24/26 09:24, Sunil Khatri wrote:
>> Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
>> could be exploited.
>>
>> So check these input value against AMDGPU_USERQ_MAX_HANDLES
>> which is big enough value for genuine use cases and could
>> potentially avoid OOM.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 4f9386677c47..c2435ddfbd49 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>   	if (!amdgpu_userq_enabled(dev))
>>   		return -ENOTSUPP;
>>   
>> +	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
>> +	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
>> +	    wait_info->syncobj_timeline_points > AMDGPU_USERQ_MAX_HANDLES ||
> That here is wrong, syncobj_timeline_points is a 64bit VA pointer.
Right, but do we want to set the value to be much bigger value for this ?
>
> The number of timeline points is always the same as the number of timeline syncobj handles.

So should i check only for num_syncobj_timeline_handles, or its ok to 
check for both ?

Regards Sunil khatri

>
> Regards,
> Christian.
>
>> +	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>> +		return -EINVAL;
>> +
>>   	num_syncobj = wait_info->num_syncobj_handles;
>>   	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>   					    num_syncobj, sizeof(u32));
--------------0KuaJiIcr88Tz2uHarhhqebw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 24-02-2026 02:15 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com">
      <pre wrap="" class="moz-quote-pre">

On 2/24/26 09:24, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
could be exploited.

So check these input value against AMDGPU_USERQ_MAX_HANDLES
which is big enough value for genuine use cases and could
potentially avoid OOM.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 4f9386677c47..c2435ddfbd49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
+	if (wait_info-&gt;num_syncobj_handles &gt; AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info-&gt;num_syncobj_timeline_handles &gt; AMDGPU_USERQ_MAX_HANDLES ||
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	    wait_info-&gt;syncobj_timeline_points &gt; AMDGPU_USERQ_MAX_HANDLES ||
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That here is wrong, syncobj_timeline_points is a 64bit VA pointer.</pre>
    </blockquote>
    Right, but do we want to set the value to be much bigger value for
    this ?&nbsp;
    <blockquote type="cite" cite="mid:2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com">
      <pre wrap="" class="moz-quote-pre">

The number of timeline points is always the same as the number of timeline syncobj handles.</pre>
    </blockquote>
    <p>So should i check only for&nbsp;<span style="white-space: pre-wrap">num_syncobj_timeline_handles, or its ok to check for both ?</span></p>
    <p><span style="white-space: pre-wrap">Regards
Sunil khatri</span></p>
    <blockquote type="cite" cite="mid:2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	    wait_info-&gt;num_bo_write_handles &gt; AMDGPU_USERQ_MAX_HANDLES ||
+	    wait_info-&gt;num_bo_read_handles &gt; AMDGPU_USERQ_MAX_HANDLES)
+		return -EINVAL;
+
 	num_syncobj = wait_info-&gt;num_syncobj_handles;
 	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info-&gt;syncobj_handles),
 					    num_syncobj, sizeof(u32));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------0KuaJiIcr88Tz2uHarhhqebw--
