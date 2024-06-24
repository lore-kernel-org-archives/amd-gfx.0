Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0631FC2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 12:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C43710E41B;
	Mon, 24 Jun 2024 12:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BNQOJbfW";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC57910E099
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 12:24:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgjGBB3aK7yjG+dbKXF4RoP2FWGVSil1Ghj7J0w17kDvkAHFcvgJXivZgf/d6HWeLi5RW2cNDbpmFOl6YuKxWB9QJOKFBXxuVXD1VbBQZEE/1K3ZCnTxwxO0hp8qRyIqd85AQdD51eLbGM0v8A1QrE4ci0DqAjp0/v7YPdTi6J9kbtC2kowl7758XhB/6f5Kvr7L3Y7SzIqOJTZRzp/onfmyDhcl0T/4XcDaZSElAuvlK15NUmTCPKjMUz1tMNnDiO1JQ+Yk0RFbBbPAg2CRZ4ZOIThrkQmQ1/orY5W2jyUTvvZ76oH4iPvzr4Z+0KaFWJ5Xs9YodV/HBivSdAUB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nGTerl0RCPrgLiwAuVJ7TUfD7l/OPVmDdTL/hP1Hz4=;
 b=EU+Q5F+qXXZ1pd/o+WJjYtjJ0HpS0AWdU2mX223E7zKZdlLYuqPTV2EJ+chk9kwGMgM6t3WGq3i4dRqg+7dIyeJVx+Eb34/w7f6g0KHCkUmh+cLe238sD/f5yBo+c+jpHR8n7JBXr0fvf/vkgal6u7AwAaneaLWxVilOkKfN73/B5FAHANchTlpITURdwg5aJf+gzCkUqPui7nHY80/sFdyoZRTN6KFbVjYJnm86tfORMTHoGJOt9fZGIA0Yf//zeS7JWPSUENWVi+4a5A0/z9Xb5d/c7NSMkEtTL/LO2CuAG4JlkptKS9OxIZC4hOobC4MdpAgxEWTz2fPT1EeDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nGTerl0RCPrgLiwAuVJ7TUfD7l/OPVmDdTL/hP1Hz4=;
 b=BNQOJbfWQnwX5ksgKn30kbmCi81IqKbdiwxZmCnDvc2Xq2O+gC9/0lmphY2mv9mDRtxRQ8CSRpXRv0+rQ4VYMBcAi9S/Su+nY0zx7wrlNDecIXrDMzuRp6rk12C7dRThY7M9LNNfZRFh5GqvyhQx3vUmwzA0hZomjB4ZcBK8mFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.29; Mon, 24 Jun 2024 12:24:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 12:24:41 +0000
Message-ID: <b572a287-4ce3-447a-a211-c5caf9ec09cb@amd.com>
Date: Mon, 24 Jun 2024 17:54:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop kiq access while in reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jeffrey.chan@amd.com, zhigang.luo@amd.com
References: <20240624063109.655690-1-Vignesh.Chander@amd.com>
 <6f21496a-282c-428e-b66d-92edb82b21d8@amd.com>
 <5d63de6b-0d46-422f-bc6e-6f59fce6104a@gmail.com>
 <ddc93078-bebc-4414-b6c9-07e01d663838@amd.com>
 <543fd667-6e91-4efb-b3e2-49d0c9a5c467@gmail.com>
 <fae5960b-b782-4f7f-b8b2-64a1af62f61f@amd.com>
 <95ef35d7-4056-42a7-9e81-46e84eeed315@gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <95ef35d7-4056-42a7-9e81-46e84eeed315@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: c5b5f35c-ba01-45e4-2063-08dc94489f7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmZjTTVZUFpvMnZEelcybk1KellQdGx2dVdacm9TNXBRcCt2WnU3YUs2NU9z?=
 =?utf-8?B?NTl0MDNndXRJMkFxMmdaR2tuVUZWc1ZKT0tYYW14dWhEUENhWEt5QTBzUXpE?=
 =?utf-8?B?WC9Gb0FIKzRONDY0YUVnc2h5dlc2dzJKVVNOL1NMeHFaaUsyblVtQVJxT3hW?=
 =?utf-8?B?VFNKU2RNV0MrV3JjZ1NqWE8vSGpiYXdIMjJJZjhHSlhwZnBtTXlOZWZ0blNn?=
 =?utf-8?B?T2ZoZWNlakNtQ0hYK3pKU3ppRXRrVHpWbTFldGZqRVY1bmMvSjg3dlNrcUdT?=
 =?utf-8?B?b3phQ1U3MURhMlp6cGRnMk1ZYTFyc2c5a3lGZUpDRThIaEZBYk9MMDROSGFG?=
 =?utf-8?B?dzE4ekZnL1h5MVJUck9NSnNVOUI1c1JWb0gyM2d6aUFSdy9hMlZ5aWNyOUZq?=
 =?utf-8?B?YzRLeDhyc08xT2ZYV3c1RDNyQVA1d1RHTTRkWFB3UnQrM2lPMyttM0dub1NL?=
 =?utf-8?B?L2ZQNVcvNnpkTWlCMDZWZGZDRGxvS2V5dUNmanIySEdZNnpoSXRUQjQzOUNY?=
 =?utf-8?B?VDMyM1V5bk1tWDhmcWZuVGhpUEZTTURvNEI3NmtFd1IvN0M2NzhWVG11eVl0?=
 =?utf-8?B?ZFdDU0VjV1NZODZhelVFQjN1ZUFqMVhmZ1ExKzV5M3FJZ3FHNlVIaEdBREVF?=
 =?utf-8?B?dkFhNzdMeUZMNnhvQmw2ZzduMDQwUiszWHpJY3RGZE1KYmlaQW9MY2VuYmhV?=
 =?utf-8?B?YWdVbkZPbEUyamhQODBHdXk4MS93L3JUZ0pYbmF6M2Y4OHQ0cUYxQmtVQkk4?=
 =?utf-8?B?cHh3ZG9MeEdlTDl4WE5ncXVpVUtUNFZwVmlYM1lHRXRQRGdiaE9Cb254dk82?=
 =?utf-8?B?bXlGY1RVR2hBdFJQV1Q4bEo0TmVWNFhCZjZoUDZIN0lrNlpyNkJVd2x2bnhn?=
 =?utf-8?B?OEZsM25XR3M3Sk92SFhjS1ZYQkpRMVIwVlpjMDdnWFd2eVBtNkRlN2NUSXho?=
 =?utf-8?B?cTI2aTRGVDVGSG1kT1hBRWFNVkorbG1xQ29DZ2NINlE0cjN0cVFxaWpCNVhv?=
 =?utf-8?B?QTREU21MMFRWTVdqWWdxb2tCU09nNHBxK3VPbXpHQ2FUbHNCanVNK2JzQXoy?=
 =?utf-8?B?MEVxU3FqTE1lQXVqeDA1NEZKMFRPR3YvOVROZ0ttMFJGcllxS3J4OFladnh0?=
 =?utf-8?B?MkJ4VUpBM0xTL1Q5eDRiQ082N3VpVWdCd3FIQ0NDdi9rMXBOZyt0NWRmUWkr?=
 =?utf-8?B?MVJEYWh6bGVROEpId3huSEpuWnpJa2IvZ01JRVBVZ0E4Z2lYQlk0dlhCaEdE?=
 =?utf-8?B?REsvb0VzWlJTY1ZrUzA2WEtWNlVnVGw5WEdoM0RQYWhTRlNQc0g2akM0T0xT?=
 =?utf-8?B?cDdVVmJDVm1ZYkRlb2oyRTlQSUpYZEhUMStkdm15clFuMG05cHYrRG01MGpQ?=
 =?utf-8?B?TDh2eFZ3RGd4Ukt0N0xqbkVSUzBVZlp5RTFNeFpyNTZMUVJKQjVveUdtQ1Nh?=
 =?utf-8?B?SktGNjUwRUZIQ2s1anR5UnBPaVI2OXVRRWpjYTZjWFgxR2RYSnkwYlViUU9M?=
 =?utf-8?B?NjdHelZkcW0yWFoxYnVGT24xUFRyQytkbGJ5SE92elRrRmdZc0RrOXpKRGxn?=
 =?utf-8?B?Zk5CK2pqem5FQkZReTRQbFkzN243cDJsaUZSMmwrWnJKNi9GVXozZlF4Ylox?=
 =?utf-8?B?VkFkd0YzNmJvYnE1L1JxZ0NLM0wzTGtQeUxNU3ZWam9neE9KZXl0aWE1TUUz?=
 =?utf-8?Q?IvA4WRQS7uwcG8/piqLR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amlhbE9TSkx4NEhCTENvSm9ZUFZJb1F3SzhodFo3VGtDVWVHdHhxZDZ3am03?=
 =?utf-8?B?Ujh5eGVCbTlMNVExUXJObU5ncmhQYm9DaDdBZnluUnQ5cVdnNWxPWmhWQzdC?=
 =?utf-8?B?MzVYeEFXdDhXWmtHNm9lZ0JneFZ1RytZY1JWZ1VxMXMxRmRVTWdUUElBcWlP?=
 =?utf-8?B?Z1hnRmxlbUlIU0QyZ0lTNGdVUCt0QTh6QUdLcGNjUVlLU3gxQzE3WFlOZGNs?=
 =?utf-8?B?dmcwTkNrOEM3NTJiYXFSTW4rKzBtSTJRK3BCRTJiVTVtVUJyZWxjV3BNOXdF?=
 =?utf-8?B?RWF6MWVZQXRGSDdhakI5ZEV6Q2pCaG5VRjdVdmd0alpmRkc0d0w5QTMyQlFQ?=
 =?utf-8?B?MXROTXdlWk5WRUF0bE85c3NSOVNLV3kyb3FJNURJcEUzOEtFU2FlRGc2SUFt?=
 =?utf-8?B?UHRUSG9QWm1HeG5EcnJTOW8zcTRGYTYzRHlPaE1DTUJNeDFQYkJZSmZBeTdX?=
 =?utf-8?B?YXJzME9CU0lISG1JL0RrbUQzeEZscVRKcWFrNGNiSXo5dTNVa1YrQ091R3Q3?=
 =?utf-8?B?N2o5clJyZXB5YnB3TGlJcE1QTzJrNWtIMHF5K21vU2tzZ08rYnZsZ3EwaUxG?=
 =?utf-8?B?QUNGS1pFdktpR29xYkVMT0Q3dzZxR1ozcUJLMy8zTld4dzhHT0VzK3dNNE9I?=
 =?utf-8?B?M01Zbjh0OFNYRytlSVo0Z1hHK2JWVVhmTGFYRXRVemE4bmY4SVRJUEowZUZt?=
 =?utf-8?B?WmxMQWlpQnR6c1dWeUtOMks5SVM5MTZmcHUrMmMvMzkwVTRqMVNLYnFhN295?=
 =?utf-8?B?aXdEMHhlNkNZenUxODBSNjRudmZXK1c5VTV3cTZOVUplWit4R05rRlF1Ymhr?=
 =?utf-8?B?YWt0MXAxbXkxdC9wTWJXdFhqMjhUR1JsU1FycWRoS2d3czFkNVlUcG9oRENt?=
 =?utf-8?B?bTZ1dmFXSkl6Q2FEOXFCa255aDVYMUF5RHhRUGZQU3drVmtuZC94R3kwamZk?=
 =?utf-8?B?cGhURzk3eEtCMDh4Z2RuVSt3NW5oWU1FNHdqS21lSTJVRlRmdjZ3YWkxbmJG?=
 =?utf-8?B?SE8xK3dOSzRKOG91UmplT2RGMzF2eGRKWnpHMU8yTUZuSlNQUHN0UHYraGhr?=
 =?utf-8?B?SkM0bFI0WkxSZXlTOE4xS0FFeis2VFRrWTZWTHZWSWxRSUZRaHhlYkNJTFBC?=
 =?utf-8?B?bFUzWWFMQTdrUlg5dXJ4ZmxUT1RtUytnT1J6dEhYMU5yMzVBbmRTa2VpSGpY?=
 =?utf-8?B?cVJvRitVb0s0dzUrUDZmSlFJQjlBZHprWGZEK2xzbjZGdkwrcWl4a0p6aU5s?=
 =?utf-8?B?elJuMDR2MUFIQU5mR3NjblIrM3YydDRRVFp1cCtHSWlNNXV5QXpkSHFWM1R0?=
 =?utf-8?B?cEIyWGF4SU94bmZYSnFzNjUrK1VhTXRrOWw3Z2JPM3IrUWxncHpFQ1A5cGdn?=
 =?utf-8?B?QXlVNnh0NWdqbklpSnkrUnpiWk9aWFBpMVlPaGk4VGpRWFc1ZVhjRG9COEx4?=
 =?utf-8?B?QytlNTdUYStpd3FZNUZtb3pHYnJHakdaeWZyeGxFY2xPTHBjdDdPWElFUm1w?=
 =?utf-8?B?ZlJkbEZ0L1F4RGRSbW45cDEzbGNFS2hPZDlhQndOcm01UVdXeWh2VWxkWUFN?=
 =?utf-8?B?am94UnZBYlNkZlNINEs2ZzJpNFhsTitnM08xU2ZqRDFKNlNoblA4dktHMEFM?=
 =?utf-8?B?eVNWUFh3bUVPenNaOGZLQ2JFd0paUjRmczV1eHF6bDkrMUcrYXcwek5DcFVn?=
 =?utf-8?B?Z3QvWHlOSXJ5c09kM1BpYU04Z3JvbFo3SkdKM2YwaVYxTTFMWDh2bURWb0Iv?=
 =?utf-8?B?clZRb0lZblJjVStNdWp3czRRVEVNeUVNcnMvWmUyM1Y0ZjBFdWh5TnZ6dHpx?=
 =?utf-8?B?Q2doVVU4cTNzQWszc1QyY1R2U3V1ZDdNUi9QR3ljMGIyNkErR2hwUUtzQ09p?=
 =?utf-8?B?VHdLcnVyNStmeEZCamN6K09ubmc1VnBPY1dTY0FZQlEyc05ubG1LeVpuQU95?=
 =?utf-8?B?UXRWMFZ2T1ZxL3pSbGJhT2FKZUtGK3RwV1lOL0diS2ZYN1pxVFpZWWZoRGJV?=
 =?utf-8?B?QWNZVmtyR3hMZXRKZnBSOUxzaE9YQXV1ejc3enJFdFdIbE4yUW9SOW5lQmFT?=
 =?utf-8?B?S0Y3Z1dtYmNZa3FRc3dkTFFkYVVLeUwvZlZ2cFIyYnRYK3Z6S0hEWjVxSzMv?=
 =?utf-8?Q?RAQWviyIgB+vqQ/86d9WjWBma?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b5f35c-ba01-45e4-2063-08dc94489f7f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 12:24:41.6113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VESCu4vF73t3MXldhrHx4TFZWx2k/4672ZwKHu3onujTSlABBSCYT27PGnKWAgmU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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



On 6/24/2024 5:31 PM, Christian König wrote:
> Am 24.06.24 um 13:57 schrieb Lazar, Lijo:
>> On 6/24/2024 5:19 PM, Christian König wrote:
>>> Am 24.06.24 um 11:52 schrieb Lazar, Lijo:
>>>> On 6/24/2024 3:08 PM, Christian König wrote:
>>>>> Am 24.06.24 um 08:34 schrieb Lazar, Lijo:
>>>>>> On 6/24/2024 12:01 PM, Vignesh Chander wrote:
>>>>>>> correctly handle the case when trylock fails when gpu is
>>>>>>> about to be reset by dropping the request instead of using mmio
>>>>>>>
>>>>>>> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
>>>>>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38
>>>>>>> ++++++++++++----------
>>>>>>>     1 file changed, 21 insertions(+), 17 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> index a7ce8280b17ce7..3cfd24699d691d 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>> @@ -613,10 +613,11 @@ uint32_t amdgpu_device_rreg(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>           if ((reg * 4) < adev->rmmio_size) {
>>>>>>>             if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, 0);
>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>> +            }
>>>>> What has actually changed here? As far as I can see that isn't
>>>>> functionally different to the existing code.
>>>>>
>>>> In earlier logic, if it fails to get the lock, it takes the 'else'
>>>> path.
>>>> The 'else' path is not meant for sriov/vf.
>>> Yeah, but the read or write is then just silently dropped.
>>>
>>> That can't be correct either.
>>>
>> These are void funcs. Moreover, the drops will happen if there is
>> concurrent access from another thread while a reset is going on. That is
>> expected and those accesses during a reset won't help anyway.
> 
> Nope, Teddy has been working on that for a while as well.

This silent drop is already there in bare metal.

https://elixir.bootlin.com/linux/v6.10-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L738

> 
> Trying to make those accesses while the reset is going on is wrong in
> the first place. What we need to do is to grab the reset lock in the
> higher level function so that the whole sequences of reads and writes
> are protected.
> 
> What this logic here does is to use readl()/writel() from the reset
> thread itself. Dropping that is incorrect and could lead to broken reset.

This doesn't change anything for a reset thread. This fixes an already
broken path for sriov where it attempts a direct readl()/writel() if
taking the lock fails. That is even more broken.

Thanks,
Lijo

> 
> So clear NAK from my side to this patch here.
> 
> Regards,
> Christian.
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards,
>>> Christian.
>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>>             } else {
>>>>>>>                 ret = readl(((void __iomem *)adev->rmmio) + (reg
>>>>>>> * 4));
>>>>>>>             }
>>>>>>> @@ -681,10 +682,11 @@ uint32_t amdgpu_device_xcc_rreg(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>                                  &rlcg_flag)) {
>>>>>>>                 ret = amdgpu_virt_rlcg_reg_rw(adev, reg, 0,
>>>>>>> rlcg_flag,
>>>>>>> GET_INST(GC, xcc_id));
>>>>>>>             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> -            ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +                ret = amdgpu_kiq_rreg(adev, reg, xcc_id);
>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>> +            }
>>>>>>>             } else {
>>>>>>>                 ret = readl(((void __iomem *)adev->rmmio) + (reg
>>>>>>> * 4));
>>>>>>>             }
>>>>>>> @@ -740,10 +742,11 @@ void amdgpu_device_wreg(struct amdgpu_device
>>>>>>> *adev,
>>>>>>>           if ((reg * 4) < adev->rmmio_size) {
>>>>>>>             if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, 0);
>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>> +            }
>>>>>>>             } else {
>>>>>>>                 writel(v, ((void __iomem *)adev->rmmio) + (reg *
>>>>>>> 4));
>>>>>>>             }
>>>>>>> @@ -812,11 +815,12 @@ void amdgpu_device_xcc_wreg(struct
>>>>>>> amdgpu_device *adev,
>>>>>>>                                  &rlcg_flag)) {
>>>>>>>                 amdgpu_virt_rlcg_reg_rw(adev, reg, v, rlcg_flag,
>>>>>>> GET_INST(GC, xcc_id));
>>>>>>>             } else if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
>>>>>>> -            amdgpu_sriov_runtime(adev) &&
>>>>>>> -            down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> -            amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>>> -            up_read(&adev->reset_domain->sem);
>>>>>>> -        } else {
>>>>>>> +            amdgpu_sriov_runtime(adev) {
>>>>>>> +            if (down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +                amdgpu_kiq_wreg(adev, reg, v, xcc_id);
>>>>>>> +                up_read(&adev->reset_domain->sem);
>>>>>>> +            }
>>>>>>> +            } else {
>>>>>>>                 writel(v, ((void __iomem *)adev->rmmio) + (reg *
>>>>>>> 4));
>>>>>>>             }
>>>>>>>         } else {
> 
