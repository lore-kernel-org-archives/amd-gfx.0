Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B633EC3DA61
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 04:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A72810E2E8;
	Mon, 29 Jul 2024 04:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4Evre4s";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C7D410E2E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 04:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RovTKHRngrIDsQ5h6WtB5ltdLaPequz3u64V6sjxn1mR9vKu3T3oQGYhcX6Vso+LcgrwoO/dZEW2BJHVmzNTEz59UuPH2bEFfJRcG6uHhQuQcsfU+QOWEmdGx6dOe5oxJI27KHbEwtQWQ7JQGhQY/pxkd60DjqJ4dNtUDnZommtB6k+F6GUPiWjV1xJQE5vl6rMFvh9Zel5hJfxMJtgboQul53TyFSjHknA4IYZDTEMKSN8A0ZDnBuCEqDCMTxxf1fVtXYJ0ErFjfcxDmeN3DywCq4s4GBCu041/4bP+0WqyQCXP8EyfHKbAPPPf6DcAV6rI9M2mxRMhdjYdLqKoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/TePtHzaDppCu3fJ/TTbQ5+sVE3ZMUZcY4tOVlQXo=;
 b=dxnYC22rGGP5+csZNyORFWiWu7OZeE5Ptgo46IblKAf6kUpjO428TDeR/XxEMPrnTdHxHxYL3IFYNxMr4qcYEuEYQg7box7smQYScEAUqDdOJE8P+wWkwQHeb7SKgmsclzPR3SOhkIjdKLzZV8UR39EnbHP+tzGW0ItZZiUfRZhFBCHtezPn8JNp+zfokC1xPowmRUnVpXQHwTccRe+Ac2eUGqBGIn9HamdM5sAcldfZZNb6JeHdE68u8zBW9mooKP/h6FBdEnJOaw3YDrWAAQdcfz6rMQz3J+e+yPV6sHI94+SyoEc8DSgZzY8hMp/zhwXdjJGAn9gzv3dfNsfpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i/TePtHzaDppCu3fJ/TTbQ5+sVE3ZMUZcY4tOVlQXo=;
 b=t4Evre4sWYL72eVtIfOIScOl0xMxZONbQQrQVZKu9dGIuIgptUg/PxE8IwA81qqEcH7F4AVbs+SD0aMJqVO/RTa1jxuYfdQ2KCxdv9XNdHJ3Skc8QnQgmlV+VKAdJ8hb95Hsk9S1nGlAehjKNIYjdlkUGcSNY2nt3NOb5RBxEOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 04:38:42 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%2]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 04:38:42 +0000
Message-ID: <a9cd3162-e844-4725-850e-a2fdcdf39a2d@amd.com>
Date: Mon, 29 Jul 2024 10:08:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: trigger ip dump before suspend of IP's
To: "Khatri, Sunil" <sukhatri@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Liu Leo <Leo.Liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240726124751.3121312-1-sunil.khatri@amd.com>
 <20240726124751.3121312-2-sunil.khatri@amd.com>
 <CADnq5_NdYiwGGvyVvg3_0aUuH9YLL_kUgNUpjEad8z8E1xWfMQ@mail.gmail.com>
 <57660e1e-1aad-4ba6-be90-abda2b377e3f@amd.com>
 <f967ce91-dd88-4542-8340-1e61813eb780@amd.com>
 <d49c682a-57ea-4061-8b42-59764f603164@amd.com>
 <77bb2c37-d906-4c76-b87d-effbbe6064e4@amd.com>
 <23d1ef60-5756-4c4f-9fb8-04ff0dc31821@amd.com>
 <CADnq5_OY_Zoqcrk-n6JvLt8fQCQifAfMX9r8a0qyRu0i9UEEaA@mail.gmail.com>
 <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <5d3f962c-6efc-4aee-99ac-5dc48c43235f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::14) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8044f8f7-2618-4ff3-f921-08dcaf885268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVVrRHR1c084OWZTRHdsRkVHMEsrb0p1ZC94OFB5LzNYamF5SUY5bHl0Rkx4?=
 =?utf-8?B?UFQyTDFuTGNBdERjMXdZb3JySiszRUZneXFJVEJkdFRwLzBRdytwQzRHZUFl?=
 =?utf-8?B?ZE1Xc1pZQ0xSZFpQT0ZoZGFKRm5UZzNpSE1uaUlsNzlFOU5ibU8wUjZyY2NJ?=
 =?utf-8?B?dnVIZEdaOEtxdFlxZXV0dXExMTJpelFLZk84Y09jQmlaRGdzUGRscitlSDha?=
 =?utf-8?B?eEMrQ2FLK1dkVW9PNmlYNWpnYXpwNFJ0RDcvUEtUZ2pLYlUyMEZRSHdaMWl6?=
 =?utf-8?B?NktvQUxjRkNzU2lENGdHNGp2cTRlbkp2NExZVkMyUEVOWVdOOGtxeWROTVlF?=
 =?utf-8?B?Wk1oZnVNUjhFYTd3TG04MVhFQ1FXTEVWYUlKeWYyZENXa3hKZVNCdU15bjdI?=
 =?utf-8?B?Y2dDeVJDL2xoR2dhdG5GczVUV0d2cnR4Y1BkRXB6L0tXaFZlZDcyS3RnM2lv?=
 =?utf-8?B?UDFySWgvNE5vVzJZbmYwUFJkSlQxcHpMSE9ISjkrMFN5V1h1QjQzMytEUDlK?=
 =?utf-8?B?RW1jTkk1aUlLYXk5M3ZJMCtHNitxOUkxR3VGTGRxUmhFb0w0OFNUaUQrMXFy?=
 =?utf-8?B?SHFyb2ZJcy9GUEpadkc4K21FdFpXdzhibTNIQ1BFbXF6eFRmNnpMOGlUdU8z?=
 =?utf-8?B?RGh1RkdQcEJUZ2lZSm9FQVBMZ3E4Qk42SUVSbW4zZVZpeDRYclgyL09SV1Nt?=
 =?utf-8?B?OC9FWlZhcUg5NmdxNlI0dFBaTlpOQWM5WlE4L1ljYURoeHVwSDl2OGZrTXhp?=
 =?utf-8?B?Q3QyMk5Fbjk5TmlsNGV1ZGo0YXNmLzRWUWJGZzhPZ2RtanhhTGloMk5tNkR0?=
 =?utf-8?B?WVJQZGRvNlhkQU1sZnZNWDFIY1djR1JpajlhWEVaWFJkdDBLdEJ6cW4vYW5z?=
 =?utf-8?B?QUFGSGF4Y0Nzd25pYnBQb2xSWC9FM2EyTnlGSFp3Z0tBMXp1K3hQTmE1UFJa?=
 =?utf-8?B?U01mNHNSTitGZWtSQ1EvNUtYTjdaVGRTSE1hM2VJN3Jrb21BNTlESzhBN0c1?=
 =?utf-8?B?SGpoNUtsdUhPRWxKSWZSaUNKS1VLZDRPNjArbXU0TE8yZmVUai9MVWlKREsr?=
 =?utf-8?B?c2l3TW1NeGZZTzVwN09zTGV5bFFUdWJqdFFKTWlxdG9zMlcxam5VUVQ4eVp6?=
 =?utf-8?B?dzBITUJlVHJSa3VXWldsc2VKeW0rYmM1cjFJQzFiZkdhTCtRdWt5eW8za1Qx?=
 =?utf-8?B?QW1mSFRweEliQWpIVG9nd0dubUMrc3lPN2FDZUdHSUsvaS9ld1BveGtuZytw?=
 =?utf-8?B?Q01kNVM4SmlxQXNkakZYN1BQQmwvQW9wdmhRZlJWR09xTE5sOUtvVlBTT2hm?=
 =?utf-8?B?V1M0VkhYS2ZjUytIbk41UVUxUW5VajFiU2trOVBDd0JnaDVhYnlVQ1F3STY5?=
 =?utf-8?B?NWoxTUdHdGRTMnpHV1NmNkJuWmszN2xWNUlRNTZtZmtGUHgvbFQvL0Y2bzRj?=
 =?utf-8?B?UFRYb3NJR1B1R0J1VTVHdlR2TWRlTnlBem50VURWMDRjV1YrWTZwcURVejds?=
 =?utf-8?B?ZWhtSVRBZmlRMlhMTEpGMHV6QUlDNVRyUEFzS0prcy84Z1I3d09NY1dpa3ZZ?=
 =?utf-8?B?MXRJbno4VDRzRi9jb1owaXEwaDFtSGc0SUFvZWxoN1RVL3RGSFdKMERVeGhj?=
 =?utf-8?B?c2FHWk5qMGJteVVIczhCM3BCZVUzeXlyRmZ5NG84SFZ2bks2dkxWQm5FUnlC?=
 =?utf-8?B?cUxLbTQ4OFJaSUZ1Z2xTakQ4MEdEUUhhTXdiOHRRblJVZ3gxYk1weVVNUWUx?=
 =?utf-8?B?aGkwY0psMUFsTER6c0VLemxVZjlUclhoNllMeHVOUHlub2x5dnBPemNCaGdo?=
 =?utf-8?B?eUQ2Y2hPMHNwL2wyWk41UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWpibnhlWEcrVmVSK0VrRWE4MlhGRE1LSkFiVzNhZGUwUloxSWFYUjlZSHIz?=
 =?utf-8?B?Yld6cmRndk9JQmxycTlUQTVkNEFIa3NnL0xGZ3JQTHJ2TVJuUitqY3lQa3ds?=
 =?utf-8?B?QVNIK01VTDMyOG92RnRwcW5LSzUyZ1ZpK1U4NTVoVWtFQmowU2VnUkFKc1hO?=
 =?utf-8?B?RFl5T3Z6Zkpwc2Nnem5EU0o0ZTdzc2ZhYi95Yk5HWi9FOXd2ZFBlcVErVDgy?=
 =?utf-8?B?eG12emFjV0E2a2I0cE9PNjk2MVNWcFBSQjVuY0RlRlUxVy9aazAzemlMN3Jn?=
 =?utf-8?B?a1hpRWxWdkJmWlByUzU3UG4wMDQ1ODBoQmxGbGRMRy9KeTVnbHU2SHNxaUJp?=
 =?utf-8?B?eTNPOTZtYzlGSG53Q1lOSStram5VQ1B4K2RBWTdkay9odHlYdWJjbzI1TTBW?=
 =?utf-8?B?ekEyTS9lSlNhQlhhaXZWUE1Lb3R4RFJ6cUxHVHY4dFhLUmFTSTZGSkJFZVd5?=
 =?utf-8?B?RklqY2lKY1NHYmh6SFQ2dE9TalF0c24rN3NoNStiMTBLVEJiZDdMdC8ybjVQ?=
 =?utf-8?B?VUg2bm5Ub1RuQUpybmlZQzM0a3RyQ2tMYlB3UEg2YlpWdGNNYmtxY2JjMnJG?=
 =?utf-8?B?TkorV05zS1VLNUlwcSt0YWJ2NzV3VHE2SzRMdUZ3RWlOV3ZTdzcwdFJXMHpu?=
 =?utf-8?B?Z09kNDFIczBOQVNUdGU1NEducUIwTUhnS3E4VkVyelhvU29MZG45SnE1NDBx?=
 =?utf-8?B?ZWRTZllGN1MvbUxtV3FlYytXUTRaSkV5VnQwMmdVWnZPUGxWMlpKcHk1WDFQ?=
 =?utf-8?B?NTZzSXdmTExVQkhCaWdKSktMdjY0ZVFuN3BPNFdpaGx0dTg1WHVPVmpqakRK?=
 =?utf-8?B?Y0dITzlRVlFBN3FYOWE3cGh2ZC8waklJaTN2bG1VdElaNjQ2Ym5hYnR6WUwv?=
 =?utf-8?B?dU5nS1FxMklKUUE1TmdJQ09nb0RPVVZVQmVmUGxpeUZtSkpvaUFxbDZsaTND?=
 =?utf-8?B?SGR3aWNSN0xFejF4KzBHaGU4OWo0OFFna1I2UmwrTG1PQjNxckZHTjVmTDBW?=
 =?utf-8?B?dEVjUVpCbjVYVy93N3NwdlJqYmMxdndPcW1MNkdvQnJLQnNIOEoxUjZPNity?=
 =?utf-8?B?RlBkekZoeVJONThZWFkxZlBrckNVMmNBUGYyMEo4STNsUmwzK1Z3ZjFpUTU2?=
 =?utf-8?B?Yk5QaUtLUkNJMWY4TE1DZkVoOENRZHVFQk1sMjRSRVpFVFpxeGMyelg4cWdW?=
 =?utf-8?B?c3VSQ2hwODB2eFRyNmc1MTZrVWtUdFUxenczOFlNS28zSzU3cEhsbzdrVS92?=
 =?utf-8?B?T004THhpT3czeHUwTWNHbU9LbWxWb2ZGaXI2R0czV2VFSXk1U0FDaEVyNkk0?=
 =?utf-8?B?bDhUODdwTE84VDNiM2ZyR0lrYVhoWi8yMHlYM3FLOWZQM3N0WmUrQ3FTSVoy?=
 =?utf-8?B?Z1ZkZGJocGVYcDZQemFESno5b1BFU3NXczRJZGtBNEwxTUVmR2prVG5DdmpX?=
 =?utf-8?B?QmVCd2lnb0ppVUtpNkh4SVVBcUJnQll5djVDUGhyRURyamdIcUJBZHlWcUlN?=
 =?utf-8?B?c1dRN1dLcUdpdHhoVXdpdDVid3VvNlpzYXFwS1B6OU1IZWRSVFF4U28rbXJC?=
 =?utf-8?B?dERvUVU0b1JVcEZzRndqOVlnMkRvU2lMVU9kWUo1aWkyb3ltZk9uQ00wWlVr?=
 =?utf-8?B?MjNNdVJPZWc4NnlJVVV0V28rakRWMEtNNDRKWXdTRGFQam45Vk9QbjdVa3FF?=
 =?utf-8?B?NktvN2NwTERYWnlQem5kaXA5ei9Kck9SUlhqTFF3UmRic1dQbU5PdXBJSG5i?=
 =?utf-8?B?Z1JrR3Rpc3JKS2cwZDV6YUFURTl5ZHMvTDZlMnRwNk9kTkNMdVk4ckpSMTVo?=
 =?utf-8?B?K0hiMFIzaWNSc0k2bzlPdmQvSnVWdURYYXk0UGg0WjRsdVNCREVSbmQ1RjJp?=
 =?utf-8?B?WWdlNHZXOGxJNGNpc3l6M1M3c1NNRHJ4Nk1TL1Y3VWFrNW51clpXNW4vYnpN?=
 =?utf-8?B?cXdRK3pWQ3NTYUFPK0JYenBoTkxxZitENVZ6ems3UTVzYXBpMGxTbEpsWHM2?=
 =?utf-8?B?VkQ4WWt6UmZLdXRjR3pESCtmNm9TTjQ5Q2U0VWVFZm52VThPbkxRZU5OYTZF?=
 =?utf-8?B?UTlTUnc2eUNxbGhoMUVKS3VaSnB1K2tWSklHYU5ZVWU1ZWhuRVZuci9tWUNP?=
 =?utf-8?Q?FKARvNLiq4o+4gM3VAm06Gcpw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8044f8f7-2618-4ff3-f921-08dcaf885268
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 04:38:42.6052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp8J0Shs+j+zH0VFudyQPAxAZDP+nBz5EG6QIyvmbcuErLYqHD4ZkVqCBEjmKaM/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316
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



On 7/27/2024 12:51 AM, Khatri, Sunil wrote:
> 
> On 7/27/2024 12:13 AM, Alex Deucher wrote:
>> On Fri, Jul 26, 2024 at 1:16 PM Khatri, Sunil <sukhatri@amd.com> wrote:
>>>
>>> On 7/26/2024 8:36 PM, Lazar, Lijo wrote:
>>>> On 7/26/2024 8:11 PM, Khatri, Sunil wrote:
>>>>> On 7/26/2024 7:53 PM, Khatri, Sunil wrote:
>>>>>> On 7/26/2024 7:18 PM, Lazar, Lijo wrote:
>>>>>>> On 7/26/2024 6:42 PM, Alex Deucher wrote:
>>>>>>>> On Fri, Jul 26, 2024 at 8:48 AM Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>> wrote:
>>>>>>>>> Problem:
>>>>>>>>> IP dump right now is done post suspend of
>>>>>>>>> all IP's which for some IP's could change power
>>>>>>>>> state and software state too which we do not want
>>>>>>>>> to reflect in the dump as it might not be same at
>>>>>>>>> the time of hang.
>>>>>>>>>
>>>>>>>>> Solution:
>>>>>>>>> IP should be dumped as close to the HW state when
>>>>>>>>> the GPU was in hung state without trying to reinitialize
>>>>>>>>> any resource.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>>>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60
>>>>>>>>> +++++++++++-----------
>>>>>>>>>     1 file changed, 30 insertions(+), 30 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> index 730dae77570c..74f6f15e73b5 100644
>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>> @@ -5277,11 +5277,29 @@ int amdgpu_device_mode1_reset(struct
>>>>>>>>> amdgpu_device *adev)
>>>>>>>>>            return ret;
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>> +{
>>>>>>>>> +       int i;
>>>>>>>>> +
>>>>>>>>> +       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>> +
>>>>>>>>> +       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>> +               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>> +
>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>> A suspend also involves power/clock ungate. When reg dump is moved
>>>>>>> earlier, I'm not sure if this read works for all. If it's left to
>>>>>>> individual IP call backs, they could just do the same or better
>>>>>>> to move
>>>>>>> these up before a dump.
>>>>>> Suspend also put the status.hw = false and each IP in their
>>>>>> respective
>>>>>> suspend state which i feel does change the state of the HW.
>>>>>> To get the correct snapshot of the GPU register we should not be
>>>>>> fiddling with the HW IP at least till we capture the dump and that is
>>>>>> the intention behind the change.
>>>>>>
>>>>>> Do you think there is a problem in this approach?
>>>>>>>            amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>>>            amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>> Adding this does sounds better to enable just before we dump the
>>>>>> registers but i am not very sure if ungating would be clean here or
>>>>>> not. i Could try quickly adding these two calls just before dump.
>>>>>>
>>>>>> All i am worried if it does change some register reflecting the
>>>>>> original state of registers at dump.
>>>>>>
>>>> I was thinking that if it includes some GFX regs and the hang happened
>>>> because of some SDMA/VCN jobs which somehow keeps GFXOFF state intact.
>>> For GFX and SDMA hangs we make sure to disable GFXOFF before so for
>>> those IP's
>>> I am not worried and also based on my testing on NAVI22 for GPU hang
>>> their registers
>>> seems to be read cleanly.
>>> Another point that i was thinking is after a GPU hang no where till the
>>> point of dump
>>> any registers are touched and that is what we need considering we are
>>> able to read the registers.
>>>
>>> For VCN there is dynamic gating which is controlled by the FW if i am
>>> not wrong which makes the VCN
>>> off and registers cant be read. Only in case of VCN hang i am assuming
>>> due to a Job pending VCN should be in power ON
>>> state and out intent of reading the registers should work fine. Sadly i
>>> am unable to validate it as there arent any test readily
>>> available to hang VCN.
>> We want to take the register dump as early as possible in the reset
>> sequence, ideally before any of the hw gets touched as part of the
>> reset sequence.  Otherwise, the dump is not going to be useful.
>>
>> Alex
> 
> Sure Alex. I am also of the same view that we dont want to change any
> power status of any IP as it could change the values.

There is a debugfs interface 'amdgpu_reset_dump_register_list_write' tp
add registers to reset_info.reset_dump_reg_list. Presently there is no
check about which registers are added to that list. For ex: if user has
added some GFX related registers, this is going to hang while in GFXOFF
as ip dump state comes later.

Also, all IPs don't handle dynamic wakeup; therefore, regardless of a
reset scenario, direct access to powergated IPs could result in a hang
and that will make things worse.

Thanks,
Lijo

> 
> Regards
> Sunil Khatri
> 
>>
>>
>>>> BTW, since there is already dump_ip state which could capture IP regs
>>>> separately and handle their power/clock gate situations, do you think
>>>> this generic one is still needed?
>>>>
>>>> For whatever we have implemented till now seems to work fine in case
>>>> of GPU hang withotu fidling the
>>>> power state explicitly. But Calling suspend of each IP surely seems
>>>> to change some state in IPs and SW state too.
>>>> So i think until we experience a real problem we should go without
>>>> the generic UNGATE call for all IP's
>>>>
>>>> But i am not an expert of power, so whatever you suggest would make
>>>> more sense for the driver.
>>> Regards
>>> Sunil Khatri
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> What u suggest ?
>>>>>> Regards
>>>>>> Sunil
>>>>> I quickly validated on Navi22 by adding below call just before we dump
>>>>> registers
>>>>> if(!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>>>>>
>>>>>       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>>>>>       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>>>>>
>>>>>       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>       dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>       /* Trigger ip dump before we reset the asic */
>>>>>       for(i=0; i<tmp_adev->num_ip_blocks; i++)
>>>>>           if(tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>               tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>                                       (void*)tmp_adev);
>>>>>       dev_info(tmp_adev->dev, "Dumping IP State Completed\n");
>>>>> }
>>>>> If this sounds fine with you i am update that. Regards Sunil Khatri
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>>> +
>>>>>>>>> +
>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>> +
>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>> +       }
>>>>>>>>> +
>>>>>>>>> +       return 0;
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>     int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>>>>>>>>>                                     struct amdgpu_reset_context
>>>>>>>>> *reset_context)
>>>>>>>>>     {
>>>>>>>>>            int i, r = 0;
>>>>>>>>>            struct amdgpu_job *job = NULL;
>>>>>>>>> +       struct amdgpu_device *tmp_adev =
>>>>>>>>> reset_context->reset_req_dev;
>>>>>>>>>            bool need_full_reset =
>>>>>>>>>                    test_bit(AMDGPU_NEED_FULL_RESET,
>>>>>>>>> &reset_context->flags);
>>>>>>>>>
>>>>>>>>> @@ -5340,6 +5358,18 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>                            }
>>>>>>>>>                    }
>>>>>>>>>
>>>>>>>>> +               if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>> &reset_context->flags)) {
>>>>>>>>> +                       amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>> +
>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP
>>>>>>>>> State\n");
>>>>>>>>> +                       /* Trigger ip dump before we reset the
>>>>>>>>> asic */
>>>>>>>>> +                       for (i = 0; i <
>>>>>>>>> tmp_adev->num_ip_blocks; i++)
>>>>>>>>> +                               if
>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>> +
>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs->dump_ip_state(
>>>>>>>>> +                                                       (void
>>>>>>>>> *)tmp_adev);
>>>>>>>>> +                       dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>> Completed\n");
>>>>>>>>> +               }
>>>>>>>>> +
>>>>>>>>>                    if (need_full_reset)
>>>>>>>>>                            r = amdgpu_device_ip_suspend(adev);
>>>>>>>>>                    if (need_full_reset)
>>>>>>>>> @@ -5352,47 +5382,17 @@ int amdgpu_device_pre_asic_reset(struct
>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>            return r;
>>>>>>>>>     }
>>>>>>>>>
>>>>>>>>> -static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>>>>>>> -{
>>>>>>>>> -       int i;
>>>>>>>>> -
>>>>>>>>> -       lockdep_assert_held(&adev->reset_domain->sem);
>>>>>>>>> -
>>>>>>>>> -       for (i = 0; i < adev->reset_info.num_regs; i++) {
>>>>>>>>> -               adev->reset_info.reset_dump_reg_value[i] =
>>>>>>>>> -
>>>>>>>>> RREG32(adev->reset_info.reset_dump_reg_list[i]);
>>>>>>>>> -
>>>>>>>>> -
>>>>>>>>> trace_amdgpu_reset_reg_dumps(adev->reset_info.reset_dump_reg_list[i],
>>>>>>>>> -
>>>>>>>>> adev->reset_info.reset_dump_reg_value[i]);
>>>>>>>>> -       }
>>>>>>>>> -
>>>>>>>>> -       return 0;
>>>>>>>>> -}
>>>>>>>>> -
>>>>>>>>>     int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>>>>>>                             struct amdgpu_reset_context
>>>>>>>>> *reset_context)
>>>>>>>>>     {
>>>>>>>>>            struct amdgpu_device *tmp_adev = NULL;
>>>>>>>>>            bool need_full_reset, skip_hw_reset, vram_lost = false;
>>>>>>>>>            int r = 0;
>>>>>>>>> -       uint32_t i;
>>>>>>>>>
>>>>>>>>>            /* Try reset handler method first */
>>>>>>>>>            tmp_adev = list_first_entry(device_list_handle, struct
>>>>>>>>> amdgpu_device,
>>>>>>>>>                                        reset_list);
>>>>>>>>>
>>>>>>>>> -       if (!test_bit(AMDGPU_SKIP_COREDUMP,
>>>>>>>>> &reset_context->flags)) {
>>>>>>>>> -               amdgpu_reset_reg_dumps(tmp_adev);
>>>>>>>>> -
>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State\n");
>>>>>>>>> -               /* Trigger ip dump before we reset the asic */
>>>>>>>>> -               for (i = 0; i < tmp_adev->num_ip_blocks; i++)
>>>>>>>>> -                       if
>>>>>>>>> (tmp_adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>>>>>>> -                              
>>>>>>>>> tmp_adev->ip_blocks[i].version->funcs
>>>>>>>>> -                               ->dump_ip_state((void *)tmp_adev);
>>>>>>>>> -               dev_info(tmp_adev->dev, "Dumping IP State
>>>>>>>>> Completed\n");
>>>>>>>>> -       }
>>>>>>>>> -
>>>>>>>>>            reset_context->reset_device_list = device_list_handle;
>>>>>>>>>            r = amdgpu_reset_perform_reset(tmp_adev,
>>>>>>>>> reset_context);
>>>>>>>>>            /* If reset handler not implemented, continue;
>>>>>>>>> otherwise
>>>>>>>>> return */
>>>>>>>>> -- 
>>>>>>>>> 2.34.1
>>>>>>>>>
