Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EB6C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 825E6112C9B;
	Mon, 29 Apr 2024 14:34:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="40E+JbFW";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AED2B10E70C
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWS1GZDU2irKjNzukMiTv8aqmXuC4UYbvUu11RtosqEdVjVv704BZ7LE5K6JsBFnrqw4HN/H+M1cDSkvcL0q+P41E7Lhj7AbGlM1/jwU/iiy+iFlpWBGnj1qiQkMP5xNeg8duTWLNX/YyHIJWIttD+gf4e/LQAJ63boL+ZldceulOaVsU/XodqWffWtdwFKPSPB9XBZetutVm7d5X3nij3XaMWZdjr6TvwWZWilMSQat6uF8gcZh2xFEumtHl+mUw2IBWmCBs9GzWglej3M+BS6liRA89bIYAdNWkrpN4XW0ri4bP02JBdCqpqaoK8/tBieJwAubfHrk5waejnB06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBE55fN97cEPXZleaSptoBM8NGdt2XHS7tWYvxPym3Q=;
 b=hduTM4mKhhhq01cwvcjJuEfNQgMd2dskTM8xpJuWfCDRuMiHOQXvAb5H4QzAdxY7g4Mf4/Q+hOiZJrpPVIO1LRJBFDGAaUVfUvi5Qpnki6aOLE7nap5BUDKaHhvR8v1UVtukwG27WyyiL5Aem5B+qAa37mseU8vv+2FzgLsIdDzwBN+Jo/lFGKVLhCqH0i3eL23iXBRxi3DpHmdPT7ZO3iDwwSJnD8lroWzpEdaSB+ge2SFR5WRK4SlBpu7apwOA8NZDSqJIwXqweyHTbN6QX9dszsS+DXCOeEr18w2vpjuRp79c7eOOVU4zHi1Cd6CxfOoCVrzlZeqDW3cuNIGRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBE55fN97cEPXZleaSptoBM8NGdt2XHS7tWYvxPym3Q=;
 b=40E+JbFWtixdRotiXnbz9mvPtnRUAQAIh7sEUTemuDnu9IifYgi26UN4VrYcKpzv3dXVnmRzwKup3X1Sye+aCIrN2TSH7ViVWPqzVCbAxZ10f2cte8suwMmbYh3MOKQ97odXfO08H89OvDg4jtMX39GBGRGXPO/lWt9EXULcSGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 14:34:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::d895:b707:1189:dfd7%3]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 14:34:14 +0000
Message-ID: <373ce770-8021-452e-a067-5a1429d039b4@amd.com>
Date: Mon, 29 Apr 2024 10:34:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix pinned GART area accounting and
 fdinfo reporting
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20240426164355.1563-1-tursulin@igalia.com>
 <20240426164355.1563-4-tursulin@igalia.com>
 <a60dede1-8e81-4c79-8058-257391930621@amd.com>
 <fe80a8db-3ece-4818-8b23-2ccf5293a6c2@igalia.com>
 <494956d9-7055-4384-a569-1381bf0380b3@amd.com>
 <1fc124cc-e8bb-4a0e-80c9-55244451df19@igalia.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <1fc124cc-e8bb-4a0e-80c9-55244451df19@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 398a1aff-47c6-4bb7-f79d-08dc6859716c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnpjaWpjRFlId1BlREljWERyVkEvV0huWVhtWFdCMWE5TFkxYnhmL0ZWdklO?=
 =?utf-8?B?L09HN0VmQm11RUdaQlhLQnhkbWNaSXN3Z3BSSnp3SUdoSUNwNXozenFxVDhk?=
 =?utf-8?B?ekNRWUdRTExleGhpSXBzVS9TSmtLckYvVGNWa21zSWx0WS9BNEZ2RFRyZmt1?=
 =?utf-8?B?U1RoTVJrMEd1Y3ZyS3l4Y1VYTTRyNDgzRWRiZEtuM2h4K0JtOWF6T3pRbUdD?=
 =?utf-8?B?Y0dNVDg5V3lRYlhKKzBuakR2MkNvQlp1UDcrZWY4aXovTFo3ZTF3L2hORENY?=
 =?utf-8?B?K0JiTnRFNFl0b0JvSSs2UkdjNTVDNFlIUkVuZmZPYVdMYjJRaVdSUkVxckFo?=
 =?utf-8?B?TmphbWs1TjR6YURIbnFiZHpPUTlXTWZBSFhBWGtsek0wWUZuL2xXOTlVM3Jj?=
 =?utf-8?B?akQyN1FnU2gzV2NMd3JGbUMwYzJZNDNtQUpmOFZMMzkycVk0M0NQQWdLR2VT?=
 =?utf-8?B?QmRSODZSTjU2dHdCQmNMVnlSOXFMd3BGM3BTWkM0b3ZaYWdDVmpTNTRQN3gv?=
 =?utf-8?B?QWwxTlJqOVRrcnVVc0Q2enFDRTVWbm95RWo0QmFWTWlzRGJKUTB2RkZSZVBk?=
 =?utf-8?B?REo5cmVCTTdsSzVwNlFwQ2dJdVJtWnRNTHIxZVVQOUdKbEpUSitaUGdqZkhK?=
 =?utf-8?B?N1ZRZzVRb0NiTmRjc2JOU0c1ZzU3NjdKa3RadmFrRjA1Yml0WW1yQStDbVo0?=
 =?utf-8?B?MG1Rb2hxc0RrZVkxb25kNi9zZzJRd2Z5dnhHY0swdEVIWnpsN1cyekJFMndX?=
 =?utf-8?B?ZTBpL1l0YVE5WndCVnpNWmNlNitkZlBVeUJpVFJsVCs5SHY0cVJDNDhyRlRV?=
 =?utf-8?B?NFpuMTNMYW9rZDI1NExhY1RYMkRvTTM0YUpDRTZjU2ZYOC9oRXppeTB3azM5?=
 =?utf-8?B?RXVhK0w1TGxSODZMdEJJUno0Yms0dTkrZkJLU0swTTN5U24wQ1pLRFF0ZW5K?=
 =?utf-8?B?dXVPaGV6WVMzbC9RV1FzSUZoVlZrak93VGtyY2V2OENmTUw4TzZSamEwVmVk?=
 =?utf-8?B?STB1dkJrMDZBRTU4R1ZxZ3MxYWk4ZHNPVlRxV1dycEgwS3pIbWhPSmRLa25o?=
 =?utf-8?B?bitQVU5oNENXQitYbk9DUThIamNDK3FDd00yRTFBMUFTOG92WGt3S1lOd21Y?=
 =?utf-8?B?QTVhQ0tlbWkwLzFTOVZkMVVwQUdtV3VaamQ1MFdhdFZLd1F1aFIxdWFyWFVp?=
 =?utf-8?B?N3djTWhGeWxSN285QU5qdXh6SzdJdkZTMVFJUW53RlJhUGNGaG16Y0dvYnhj?=
 =?utf-8?B?ZFhNVXUrak1Ya1N1RHBWVXJYVkdTSzVpeGo1NXNtM3VJdFBMSDFLQnZCTXJ6?=
 =?utf-8?B?a3VJNklWNW1DMktQRnJRODkzVzhPd3UyN1RyaEhqaHdLWTgxbElGelZYTkFS?=
 =?utf-8?B?VUNPdjc3WmxyRjRYcGVQVGRDQjlHVVNPaG1KdTkyblZPT29KU1l3R1RDdElT?=
 =?utf-8?B?UzhTcWwrVkk5eXh2eHFHQWdZREhoVUxDejdLWXB2L3VkczVIckI2VDNkU1hM?=
 =?utf-8?B?dTg2WEdjUVVDN2Evb05kM01lMHpFNnFyRVlqVVFJR2IwdVkxbFFtbXVqcmhp?=
 =?utf-8?B?b3p3eXVnb0h0MzJqNy9TYjA3eDZIdEV6end0S1lpOWFHa2pzVDFCcmg3WTFa?=
 =?utf-8?B?eDFFNjV4V3hPUy9OSFVrYUVHQWM3UFNhL2wvNnYxSWxuNjRUSm1CbWxLMVdW?=
 =?utf-8?B?QVNMOGVIcFJYdjNDanBtenZqNEw1TjlIemtOaXF5b0xwemhQNm40SGdRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWJZbXpWeXBoUlBURXBtNG5OYnRldnBXRU8wbXJzQURXc0h4a1g4bFdoM3Bu?=
 =?utf-8?B?cVhmWlA0RmMwS2VNSnF4bmtabVdmZWRQK0VrZUI4U0xEeFIyNGtKREhvZzhn?=
 =?utf-8?B?cFFqdnF2TTRsUTRlKzlqSmtOWVpTdjUxOW5Hcm4wR3MzV1JzNVBZNlNNUmJ3?=
 =?utf-8?B?aVVudzVLWlJCZFdoL0hBNFZZRSs0ZzJYL1dNL3hsMWd2end3UnMyV0VmRUZV?=
 =?utf-8?B?YVZqN2Rsdk1NbHBha1pQbE8ydEtaSVRqL3FSN1N6TGdxT00rZmxVZldpS0t0?=
 =?utf-8?B?eW83Q0ZnTEJsNGVHWStDQkFSTUlVSjI2dVVvUFdUc2lGeEMxMFppTFZYeDdi?=
 =?utf-8?B?VmFIdlBoRWUwcmV1b1Q1RXJnZjl5andhMDNGNEw3djdBS3VLWUdHWGFtbEh5?=
 =?utf-8?B?Wnh0YmJidGp5eGdlVEl5N1NVdDFVRFNhVEp5Y0hxTGVDQmxMcFJoSWpyZnI1?=
 =?utf-8?B?UUtoSkVWc0MySHNQVzRFQjN3YWN4aFFCeFFDNmZYaGpodEtoQUpDL01LbWV3?=
 =?utf-8?B?TGI2OTRkT00vSENZNU5yaGVuYlBLV09mdlZISEpyYzd5QURYbXpmMnlSUEE3?=
 =?utf-8?B?Vzh2dmIrSGpqSHJJNVJFd1BGS2FrRWpBUlFWTWkzZ0FjUW1vOUorbm1KdjlX?=
 =?utf-8?B?TWtFLzJ4Q21XRHlycXZoMDZUY0cxMks1WFdydm5QclEybW9Bc2FTWSsxRyti?=
 =?utf-8?B?N0JRcllqSWRzSkJRb1pXZ0UzRmRlQ3ZmbUhWQ0lHWE82SG8zS2Rwb3BhU0lJ?=
 =?utf-8?B?TmRKLzRqK0VhbzJWQnl2elRUN3ljV0RWSG1vcFQ3VU5PSVJGcVI5ZjdjWjlG?=
 =?utf-8?B?TlB1ZWJVWnBpSXJhK1Y4WSs2Y0FpRGhRSUJ2UUV3VDlsZGRqNGpYVUJBMXZX?=
 =?utf-8?B?Tkd3TXI2bGdjR3g3NEFlOW9OeFNEYUYra1ZzMkZIMDY2V2RkU2xPVXRWRWdp?=
 =?utf-8?B?QWdrV1hFN1IvWTJYNlJ3aCt5b0pZNnE4OU54bkpWeGlXeGR5bXRNV05SUFNa?=
 =?utf-8?B?aW02SUh3OFVuQ1BDOS8wYmVKOTEwb2lFN0hhc1BYRlBzOGtTM2R2eVVVTUti?=
 =?utf-8?B?bHJqUW1xUktnYkptQW82V1BtWlNOVnh1dmFmWStZQXhUdnhON0huaDErVnQv?=
 =?utf-8?B?cjNMVG9vZk5VVHZyWXZOUXhRbS9TUTYvMEpFU0dIdFhLdzZkTTZKODhETjQ1?=
 =?utf-8?B?KzU1OHRaMnUwc2g4aUVyaXN4UUEwTmJtVEVJelovRWExVFFzcnlLZld0dTdh?=
 =?utf-8?B?OWw0TDRLZGpxUGJ6VG5JeFNaMzFKYXoyYVc2bmNxSDlnSHI0UmdzL2xDcVA2?=
 =?utf-8?B?TU5Qam1Ub0lpUDJqQXUvbzlEaTJLTDFiaG5GMlAyeTV0azd2ZHdzQmJXUzZz?=
 =?utf-8?B?TFI3em5UN1NKSmhmbXJ3RFdVYzlYZ2FtQnpqWnFnS1RHQTZMemZ3Qi8rN1hE?=
 =?utf-8?B?RStTNVpmSHZPS0tQaTNMcnBZLy9NQWFiZ3VyS0VZMEZyeDlsZVM0Umtld1pi?=
 =?utf-8?B?aUgzaEs3UXg1clJEaGthQUFzNXVIWTVUMTRKUm94MUJQNTB2LzNVNDllVC9l?=
 =?utf-8?B?ZkxWWGNqa3JwT3ZLYjZ4YTlpdFVHdFI5MkdQcGdibkFNSVlMM2w0aW16OXFu?=
 =?utf-8?B?UlJGVzhja2tGZjdwVDlvaUE5MXRZR1ViVlZLNmlPZExKd3laVHRPWW5VeWRj?=
 =?utf-8?B?aW1TcUZOZ2pBbXpQV3ZCNzVuTU96WERBQzl5aHRkeHIvRTNmUmt1Um5HYk43?=
 =?utf-8?B?MW9NbDEwbHAzZWR0VzM4dVVoVVVkZDdtTUpWNEs1NmFFazRCS29HY2JNck9s?=
 =?utf-8?B?Q3FFdTVwaHg5Y29LL1N2SXd5bmJKcWpjd1JnWVplTjAwQllZenRDT29MWnZq?=
 =?utf-8?B?eFNQajJacFhJT25sVEpMeGxKbURoU3UzQWNLcVZMdVU5WklENVliNllHbTdQ?=
 =?utf-8?B?WmlKcGpVZHRJN29vMG5GL0FCVHJHNUs3SVVCMlI4MmZudGsxN1hDU085VnJJ?=
 =?utf-8?B?eVBoaEJWNGxjSHFULzBHQTkrSkFLYThyMklYU09meFdpQ05UdEcrcnVFVEJ5?=
 =?utf-8?B?YjFJRTJDejVWQVpuVlZPRHQ2ZDFaaDZCdjh3VGFCbFU1RHJCcFp5UDRYMkZz?=
 =?utf-8?Q?bYi9bjQ0+TxpXCZaymwaqw7SK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 398a1aff-47c6-4bb7-f79d-08dc6859716c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:14.5457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bga/Cj665YgyQc00ESa2GjL29kJTfDoSEcmsF+ZeV2hZ2rUOQ7ZadQrPYRMMvSRzg8QsG++IDz2jveB+Bd4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
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



On 2024-04-29 9:45, Tvrtko Ursulin wrote:
> 
> On 29/04/2024 12:11, Christian König wrote:
>> Am 29.04.24 um 11:43 schrieb Tvrtko Ursulin:
>>>
>>> On 26/04/2024 23:24, Felix Kuehling wrote:
>>>>
>>>> On 2024-04-26 12:43, Tvrtko Ursulin wrote:
>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>>
>>>>> When commit b453e42a6e8b ("drm/amdgpu: Add new placement for 
>>>>> preemptible
>>>>> SG BOs") added a new TTM region it missed to notice the conceptual
>>>>> imbalance in GART pin size accounting as done in amdgpu_bo_pin/unpin.
>>>>>
>>>>> That imbalance leads to such objects getting accounted against the
>>>>> resource, but are not un-accounted when unpinned.
>>>>
>>>> AMDGPU_PL_PREEMPT is mostly used for userptr BOs, which cannot be 
>>>> pinned. In any case you should make sure that the accounting is 
>>>> consistent between amdgpu_bo_pin_restricted and amdgpu_bo_unpin. 
>>>> This patch breaks that consistency.
>>>
>>> You mean amdgpu_bo_pin(_restricted) and amdgpu_bo_unpin do not run 
>>> for such objects, or something else?
>>>
>>> If they run, then at the end of pin there is:
>>>
>>>     domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>>> ...
>>>     } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>>>         atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>
>>> And unpin has no handling for AMDGPU_PL_PREEMPT.
>>>
>>> Ah I see.. does it rely on amdgpu_mem_type_to_domain returning 0 for 
>>> AMDGPU_PL_PREEMPT? My confusion was I misread the pinning check as 
>>> checking the domain as stored in the bo at creation time.
>>>
>>> Although I am still confused by the statement userptr BOs are not 
>>> pinned. It is not needed to map them via GART on AMD hardware for GPU 
>>> to be able to access them?
>>
>> No, a GART mapping is only needed if you want to scanout from them or 
>> otherwise use them from the kernel on the GPU.
>>
>> Background is that the kernel doesn't has VM with page tables..
> 
> Got it, thanks!
> 
> Presumably somewhere else in the code then it is prevented to call 
> pin/unpin on those?

I was referring to this condition in amdgpu_bo_pin_restricted:

         if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
                 return -EPERM;

However, when I look into it more, I see that AMDGPU_PL_PREEMPT is used 
for other SG BOs that actually are pinned, specifically BOs created by 
KFD with KFD_IOC_ALLOC_MEM_FLAGS_DOORBELL or 
KFD_IOC_ALLOC_MEM_FLAGS_MMIO_REMAP. These are very small BOs (one or two 
pages), and only one per process, per GPU, so I'm not sure it's worth 
adding special handling for them in the BO pin accounting.

Regards,
   Felix


> 
> What to do, if anything, with the attempt to address the asymmetry in 
> the accounting criteria between the pin and unpin?
> 
> I mean domain based on pin:
> 
>      domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
>      if (domain == AMDGPU_GEM_DOMAIN_VRAM) {
>          atomic64_add(amdgpu_bo_size(bo), &adev->vram_pin_size);
>          atomic64_add(amdgpu_vram_mgr_bo_visible_size(bo),
>                   &adev->visible_pin_size);
>      } else if (domain == AMDGPU_GEM_DOMAIN_GTT) {
>          atomic64_add(amdgpu_bo_size(bo), &adev->gart_pin_size);
>      }
> 
> Versus placement based on unpin:
> 
>      if (bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>          atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>          atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>                   &adev->visible_pin_size);
>      } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>          atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>      }
> 
> The fact amdgpu_mem_type_to_domain never translates back to 
> AMDGPU_PL_PREEMPT means there is indeed currently no bug.
> 
> Is 2/3 still desirable to convert the check in pin to me mem_type based?
> 
>>>>> Fix by extending the accounting criteria in amdgpu_bo_unpin.
>>>>>
>>>>> What also aappears needs fixing is not reporting their size from the
>>>>> amdgpu_bo_get_memory, which is used to implement fdinfo stats, so 
>>>>> they are
>>>>> not mixed with the regular userspace created and driver owned objects.
>>>>
>>>> I think that's true. It's a very fine distinction. AMDGPU_PL_PREEMPT 
>>>> does use system memory and it is GPU accessible, just like GTT. The 
>>>> only difference is, that it's not subject to the GTT limits because 
>>>> their eviction is handled by callbacks other than TTM evictions and 
>>>> doesn't need to wait for fences.
>>>
>>> As in you think those two hunks of the patch are correct?
>>
>> I think so as well, yes. But we still need a name for preemptible BOs 
>> while printing them in debugfs.
> 
> Currently it looks the name is 'CPU':
> 
> amdgpu_bo_print_info()
> ...
>          case AMDGPU_GEM_DOMAIN_CPU:
>          default:
>              placement = "CPU";
>              break;
> 
> 
> Also, where to account them in struct amdgpu_mem_stats?
> 
> Regards,
> 
> Tvrtko
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Regards,
>>>
>>> Tvrtko
>>>
>>>
>>>> Regards,
>>>>    Felix
>>>>
>>>>
>>>>>
>>>>> And also amdgpu_bo_print_info for debugfs reporting.
>>>>>
>>>>> Note that the patch depends on the previous one which broke down the
>>>>> relevant checks from the domain based to placement based.
>>>>>
>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>>>>> Fixes: b453e42a6e8b ("drm/amdgpu: Add new placement for preemptible 
>>>>> SG BOs")
>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 ++---
>>>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index fb984669fc3a..5a2bbc793953 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -1032,7 +1032,8 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->vram_pin_size);
>>>>>           atomic64_sub(amdgpu_vram_mgr_bo_visible_size(bo),
>>>>>                    &adev->visible_pin_size);
>>>>> -    } else if (bo->tbo.resource->mem_type == TTM_PL_TT) {
>>>>> +    } else if (bo->tbo.resource->mem_type == TTM_PL_TT ||
>>>>> +           bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {
>>>>>           atomic64_sub(amdgpu_bo_size(bo), &adev->gart_pin_size);
>>>>>       }
>>>>> @@ -1298,7 +1299,6 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
>>>>>               stats->vram_shared += size;
>>>>>           break;
>>>>>       case TTM_PL_TT:
>>>>> -    case AMDGPU_PL_PREEMPT:
>>>>>           stats->gtt += size;
>>>>>           if (shared)
>>>>>               stats->gtt_shared += size;
>>>>> @@ -1599,7 +1599,6 @@ u64 amdgpu_bo_print_info(int id, struct 
>>>>> amdgpu_bo *bo, struct seq_file *m)
>>>>>                   placement = "VRAM";
>>>>>               break;
>>>>>           case TTM_PL_TT:
>>>>> -        case AMDGPU_PL_PREEMPT:
>>>>>               placement = "GTT";
>>>>>               break;
>>>>>           case TTM_PL_SYSTEM:
>>
