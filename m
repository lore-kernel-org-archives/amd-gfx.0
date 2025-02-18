Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE33C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 21:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6F910E100;
	Tue, 18 Feb 2025 21:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZayORTPZ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04110E100
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 21:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0CyXs5CWHkQCn70mkerlL34xOZxjiQA91GVPkWGkX2ly0so5WqDKy5Su2ww/WLwKMsivFWrAK5AfvT5Tf9We7OXWRxyUnQOa079s/kCArOSVVwa/srYgw4AvTJqcqXEpgvH5cXBxsIWhy6aG27YMVQUWdFyUiZThrvf+gxJmu5Put1+yvPM+L9F48P+5fOsXcAYhhc42Eeys5/LgqYT/salugUQKckPQNwbtPW3e5VqvBUhEW+E+MlNKXJu/UCQ8NxQQCjB5M+Ov7mvowMmRLOZlKjr2TtWU7zSaS+MM9M9BIE7GqsAXcAcaXqxUFv8ieWEFpv+m5kkHu0wdOM4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMehoFV9X2v3ljMfFVukEOFC2IfhlVMXSyItS1+KU9c=;
 b=b6aXyXjiiGgsf1wqLAfiENFw14sdS5rtYgii2dS6noYTAewy6G8l0kbGTGKSyu9k5I1ISNExqCijItxAjUh+g136CCvzJ2vVV529LqdnQYFYqYWK+BnUsAkwAGgsIeinNpLdPCGX9JZthilMJ3rlriszr82JX+mg3K0nhUwgibOO53I1sH69jyY3IqQCjOquJh56LtiO8VlqFqQZZ96SfLl9dZJxyVawl9c5GeR0rBdpcMRy1+w3QiNzUsMCmfvzuNX6NZ1vn+0lfKMAXk0mnuE7s7Z2A57gq8iFHmSLkPg7e+oa6iSNJEPWeq2NdJpz7A5YSMU+TJuOS5HMR8jCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMehoFV9X2v3ljMfFVukEOFC2IfhlVMXSyItS1+KU9c=;
 b=ZayORTPZolCCBFDlUxrwRqfOkVi8RB9XoLul0+KBzsKyl6yTHS654iLKJt9YY+g8Vkei4sEKCSSef4bCJVquS7dLj94GxKbVdaE5aeT1sdMqP7Uz2pBHBANHCWCOGDu4leeHTHpo9yl7ts0LUD+qgwnl1Fw+g8Bxw29iFjnixvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 PH7PR12MB9104.namprd12.prod.outlook.com (2603:10b6:510:2f3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.18; Tue, 18 Feb 2025 21:04:35 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%6]) with mapi id 15.20.8466.013; Tue, 18 Feb 2025
 21:04:35 +0000
Message-ID: <1af604b6-dcbe-48f7-97b6-1bf70592e7ab@amd.com>
Date: Tue, 18 Feb 2025 15:04:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: harish.kasiviswanathan@amd.com
References: <20250218172440.127224-1-David.YatSin@amd.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <20250218172440.127224-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:806:27::26) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|PH7PR12MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 960a6fe2-4c54-4127-4af1-08dd505fd8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnFLS2drSzJVOHZDVlJubFNDQTQwYUo4OWZ4UG1McWFTMjVVWmxOQ0Mrb0Ru?=
 =?utf-8?B?THlaNWRHWmwzYURGYkU1OE1FWi9uQ29uZ1B2WSt0bHdydzRaeWJZTDV5OFd3?=
 =?utf-8?B?ZkJYRnNQVjlDSmZBaUE2NC8xS2FudGZPdXZBaWRaQnhMS0tXWm9rckdVOFdh?=
 =?utf-8?B?ajUwc0JqWTlZNDlCZDQvbEZsMjJJWGlqc2thTEZKcHRvU0FkVGlsOWprUW1h?=
 =?utf-8?B?U2R4VXA5dEY3UkZ2bmVTNXR6UEZrU0hwNWFCTU9lUVZMOEVNTnowSmw1RUxy?=
 =?utf-8?B?S05zbnVoZGdkbmJrbi9jRkV4L1VDbElkVzJvMnJtc3hoZHVZMHlGUjNKWm80?=
 =?utf-8?B?a0lLdVdaTUN6QkRZK0d3MDFhMlBoMkJqSTlqWWZHaGpYdDRqbEpRUzBLMmJz?=
 =?utf-8?B?UzlKLzRSbjBHSWZaMHNuZmhjZzRZZG1uRGY0MU1FYWFEUEpIRmpjYTFmc284?=
 =?utf-8?B?OTd2WThSY3NCc3lXT1hkcm5IeFhKVXo1Z3JCVzZsNmduVnArU0NvSzhWVkNK?=
 =?utf-8?B?USs0RW1nVlVYTGczL0c1QU5Pc1NWalNYWmFMOGlwSzdZSzlNZHJubHF4am5V?=
 =?utf-8?B?OTQwZE1ORy8vL0hTM0NEdnNRL2RZRE9DVnJ5bnUwd2pBajJGam1SaE8zYU95?=
 =?utf-8?B?NkZPR0o0OE5BSlhwNTUwZityeFNsNEhKRGtycWwzZ2pURjFiZUUxTVFwSmlF?=
 =?utf-8?B?UHhuZFFQY2N3RHhUdDJLelh0b1V4S0JTVUN5RjFDemhmVVV3RElKSk1wVEJz?=
 =?utf-8?B?Uk5XbkRFSnBZNFlqSzllT2Rrc20xMzhxTHZPdU16b29KRHpNNG5YRHMzeFVk?=
 =?utf-8?B?SzI4d0dERWlwaER6LzA5VGN5Y2hnNUdHKzZNMU5JUVQ3RDVRenM1MU14VmZH?=
 =?utf-8?B?TmRIOUtnTEI5eU1jc0pRM3Z6VFd6RS90UllHbjlxN0JSaUNGdDYrRzhOVUw3?=
 =?utf-8?B?cUV2aWNYUU9WLy9xUjB3YTN0RS8yTXpKWFlBS1AwUll2dkJkSTFzYTVNNTA5?=
 =?utf-8?B?dGl4Q1dSWDNBc253UzkvSFp1b0ZuQ0hjMzlUN1dsVytBRVVvcWpkYWU1MHl0?=
 =?utf-8?B?KzhiUmttclU5L1RIWWxzbysxd0JSYUtGMGIvN1ZNVE9ncHVjY3J4NlV1dGJP?=
 =?utf-8?B?c0cxRFJSZU5odEdVU1IrUlEvcnlrd0w2aWdTWGtVVEYyOENnNHg1dWVqY1k2?=
 =?utf-8?B?ZTJQWWdkRkZORDNkc1J5MzJ1bGlJSGFJUjh1UHVvWkpnMCtiVDk5bklXeFdN?=
 =?utf-8?B?TTBPZ1F1L0lOMFJXb2J5SDJsaE5RWmFKNlUzc3RaaTZza1ZXaERzVm04bU5s?=
 =?utf-8?B?L0FQN3RVR0c2LytZU0h5WjVWL0ZsY3RnT21BZWVqdWJuNXhuSUhTai81NXg1?=
 =?utf-8?B?UnJrNEI1bUwyVTNkODNhQU5IanhmMFZBbkxBdzUzb0FJZ3dNaE9yZVY4R2dM?=
 =?utf-8?B?eVNMSjk2aUlvZ1BOSitBck1HMG5lRklUU0x5bzlaR2ZRNTlXMjc4ZXZEYkJj?=
 =?utf-8?B?QmJWK0lGVDFTTmFpR1phcGJwZHFQeHIvRVZ2dnFiZFE3SGg1cE04UFE3eUwz?=
 =?utf-8?B?Qm5xVXB6NkYzUk01eWQ5cmVVQ3JsNHhLLy9IUmc2Zy9aVFFXSGd2MXdYV3FS?=
 =?utf-8?B?ZmpFTnlaclRuckNjRDBlR1FJZ1NMd3Y2ZWNhbEEvejhLT3ZodTlyN3VQdDdn?=
 =?utf-8?B?M09TRk5mUFRtYW5HaTQ0NlN1bXZjKzJuTXovNjA3VUtPZkdRS1NQSWwyemNZ?=
 =?utf-8?B?L3RVOFh6dHZYek0xbmpkZ21MdkdjL1ZySFVHemJzdm9GR2lQYUxwMlpVMi9B?=
 =?utf-8?B?MWVlOGc5ZUhsekQvZklXaTR4TXNEazh6cUg1STh3UnZzMmxkRGZZRUZ5OU1T?=
 =?utf-8?Q?Feb352N+wHBeD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQ0YVl1cGdZaytQVjR4ajZob1VnVlIrRkowWFVETS91VmpNTXFoZnFydjVD?=
 =?utf-8?B?SkV0VDhSVkF0aWZ2KzhjRm9HSURrS2Vtblprc09vZ0w5dEpZYmxxQjlyeHBt?=
 =?utf-8?B?bjh6ZldkSllCWVA3YXdReTZQaGdLYmgxV01JOTh2UDZybmE5M1gwcVZUa0JB?=
 =?utf-8?B?ZmZ5eHd2bzBzV1FwVGtMMXYvdWRXK2JuTTdiQVNnMkhUTGpIaitsYnE5RnNX?=
 =?utf-8?B?UFVOY3N4SUNuNHJOTVRid29KN25TVTBPU0EyaW0rNjRNYkJ0RkhSMllzZjY4?=
 =?utf-8?B?WlZTRXFYWDFuVy8rZHYzUFlVeUQwQThhWkhpWXVSdjJ3TU9TMVFpMk1JaUpt?=
 =?utf-8?B?TjhJVWp2WU5Ud2F2UVA0S2ZGMGFuTmVGZFA0WElzazRucTRnSk9KSGRlbkU0?=
 =?utf-8?B?d2twb0YwZDlLQUZsSnZBQWN2WFlYeVpBTmJUL1kzMGx6ejloYjQ3UHJMUmtN?=
 =?utf-8?B?ZU5UTjFaYyt5ZlZOY094T09oRmtoOTZaMkEzQ3BwbjB3a2JPYUo1Zk9QUVlC?=
 =?utf-8?B?SWk0T3RoNW5kVGZoRmJNYXFCdUppbkM0Z0diY0JYUGhyUDZMSnEzdGR6eFc3?=
 =?utf-8?B?ZkhiREFBckFmTmMrL2FhWEJSNS9lOGpDcFliVUd6bTZQRmYrZUxWaXBFLzBu?=
 =?utf-8?B?SVlJTloxbVVPcVdrbzZMV2xkd2ZuOExnMkxwb3RjUmJkRE9mQzJxUkkzRTJi?=
 =?utf-8?B?S24vZGNxdDJ3SmM3M0J0ejJldzJVc0xWaFFIWGZqMHMvaW5PdHpkbndLSUJY?=
 =?utf-8?B?dlBvT00xcVh6aFRZRFo1V3F3VXFVeEI1dTJHWDlWbk5uQVVvWnlNSE8xNFNO?=
 =?utf-8?B?RllmOGhyeTJWRG4xeGxMUXhISExJL2hZYnJDSk5hbXpQejdwOVhacXluRDBS?=
 =?utf-8?B?Mk9KSEtkZWVvV0R4L1dhd1RwNzB6VEsyZlFRaE1EckNNRmo5bys3ZjRXNG9J?=
 =?utf-8?B?eTNSdlhqWS9wMDhzTTQyQ3NrYmlod2dVYTdIRVZ2ay9ySmlEZVJ1Um5Bc0o2?=
 =?utf-8?B?YnAzVG5jUzZPd3NWdjh6NklPcTV2SWNRclNKa3JNaFU1NFZJY1ZucXgrT1JK?=
 =?utf-8?B?M2FScDV4WllTUzZzTVVBcUlXalBvTFBvUlVDTDNiMUdVb0tkbkNTZ2hSeldD?=
 =?utf-8?B?UnR3ci9haHU2SWJuQ1lRRythLzBlek4vS2FKS1M5cHVvbjJXa3BrZms4WHZC?=
 =?utf-8?B?MDVncE5zd3RFZHc3cmphMVhCR0V6K1FUVkV6SnBOSzZmaU9uQWozYWxzSGp5?=
 =?utf-8?B?YThrSlVjRWN4bjNxSmRtZlp3c2FjNXptay92L2src1dNVVlwMG5hTjhrN0JT?=
 =?utf-8?B?Q3BWU0U2SjlZR1RyR0hRdUhkeEdJdW42UVRzYTUySGJBb0poZHV0UStRL0RP?=
 =?utf-8?B?WjIzSnFVNzZHUkRkeGhZdzd3N2ZMY1pQWlR0cVc2Y1I3U2Y1RzB1RWFJVS82?=
 =?utf-8?B?TFMyV2Eya2dvZkNrNmFKRERlcDBhKysxSWplamZHU2JIWE5kN2VHb1lVNy9t?=
 =?utf-8?B?Wlo2cXdneFJNWTI1MWlMQS9YTGJuYzBYb29lSFlwck9MOUNNYVpqbnBzbUN5?=
 =?utf-8?B?dGp6MVNFWWxPZmllL3hhZE0xM0V1N1ZxejlLR1lmU0VYa3RRUDlsaDd6ajJx?=
 =?utf-8?B?alRHM3FHb2s5a2ZqRnJaUlFxRU1GbmhONHBaTERoYVRKZ2szVlkxMHM5VjIz?=
 =?utf-8?B?cktCazR2MzJHVzhjN09IZ242RWlWenQzR3JGWk5OaWh5MVJIWkZzM3dpcHA1?=
 =?utf-8?B?VVF1Q3NqRWsybW1STkhRUnpJc2MwZlVsUXdkSFhweWRyamhGaFhNK3B0OWd5?=
 =?utf-8?B?NGVPTVd6VVIrUHk0OCtjWlpNOHRNbm5xK3A1MEV3UEI3Z0V3S043cWtxRGhu?=
 =?utf-8?B?cXA1YmwxZEtzcTZxYjRkTWQvTm45a21sTFVlNHB2cWQvNW5ENmU1SFhhOXFQ?=
 =?utf-8?B?Y1J4LzFTUUVwWTM4VUFncHVFd2wvNnJvQTMva2hPNm12NEovYnJjdkQ0UHM4?=
 =?utf-8?B?L0xGY3g1YjFuNTVsa0Q2MFI5TlB4NUx6a3ZkYzdxSVhiZnRQSHllNmlYd3hS?=
 =?utf-8?B?cnBNVXVKSHV3V3IvYUtjSGp3VGRjZ1Rnc0tueHh5TmQrM1FVOWdwOXhVUFZO?=
 =?utf-8?Q?PHDpfa2ur0BVFr2oxIkw7dzzo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960a6fe2-4c54-4127-4af1-08dd505fd8fa
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 21:04:35.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DaxxUKkzZ+30ZJ88xY44rskUguZBxsXWKEgKcqtujPNbo3Ngy9clPTTRNhfs5Kyg7BYSvQFohDawNegPECuHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9104
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

On 2/18/2025 11:24, David Yat Sin wrote:

> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -167,7 +167,9 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   
>   	m = get_mqd(mqd);
>   
> -	m->cp_hqd_pq_control = 5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT;
> +	m->cp_hqd_pq_control |= (5 << CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE__SHIFT) &
> +			~CP_HQD_PQ_CONTROL__RPTR_BLOCK_SIZE_MASK;
> +

This would cause changes to the queue size field to OR with older 
values. I think it's not quite what was intended.

I would move the constant field initializations to init_mqd and change 
only this part:

+	m->cp_hqd_pq_control &= ~CP_HQD_PQ_CONTROL__QUEUE_SIZE_MASK;
>   	m->cp_hqd_pq_control |=
>   			ffs(q->queue_size / sizeof(unsigned int)) - 1 - 1
