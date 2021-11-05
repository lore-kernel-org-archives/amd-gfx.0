Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA70C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 21:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A73D60FC3
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 21:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A73D60FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8062D6EC36;
	Fri,  5 Nov 2021 21:11:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F3389C3F
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 21:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZeoh1VfnpVsPvGNKloYeC2XszfnBGQLsRZU//KYmg+ABLmzmRGDOBkMqur+mh5RvOyu40/KVDhA6IlxcBUxSBXA9FHXb2ij24ryG8rw8AJDf1ZLXIwH8LheMBVMebw0cJfR7k8O7jviXz7DeKsHRXtIpnDisxEnV6pQoeP9VCf38543a5nQxKfAQ+WHkhEepDiLBBjZOgzOPqph3gmiJq3eEkSLqn56Y/NwnfeKBJRYcXNrUaT9f114uQCHQUorxLNJeE/SGyULSxznKCKxiI38GrZDH0qTA2sQF2qPADOK4+eMTdaJVVBG82mW6mY+Xt4tAryS8cnICrelO3AgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4SXhOJkZaepc8c35+chSlFzvk1XZeXVaCHYMsRf5Uc=;
 b=HHVFVTsrzTUuvkqGvzyXrMmVjg37tAQPR5qakDfDFdovkkFaJYGj2I/lxXhn872LeZlwUULmisiyivX1dVQYlShBjdStl5zEid5nYIvX8dmo9mRRc/scV8rqNP4wts+oRuxD8D7rBmPxgaLTaWVFURgrOEkDx5dR00DjdJaH3C77ODVCvOqSO3EPAL7284/7B/j64dkYBQHkqbHjEQh+jNmSFBMHFWIj1rYRpHrYf/Oi4oLDH6N2beNjXSVGocEf7LsdYmgXT6NQxK2+l+dwLwpwacVp/o1UAkJLLLOhEYDbcXWg/h1JOrRI+9VRg2e6bAOSo3Jq4oVqAdEcvaI+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4SXhOJkZaepc8c35+chSlFzvk1XZeXVaCHYMsRf5Uc=;
 b=2I9C1jNFIW/IEDQNSN5pHfCZ7BsCCEr8E/aE4NFIY5mfrvsBcOuRq/3xSxS3ewon8yrEiRq3D+BZFJXl0zrdh+ibUyIFW1J/dTQ0yehgxKjWcQh2B8H6PQhsELTV0jNdCssQ21nVf1aKoLmzz93zq/izARDLqorb0MAjNexwKHc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 5 Nov
 2021 21:10:57 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 21:10:57 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211105165741.2617-1-shaoyun.liu@amd.com>
 <3b5fe2ba-d03c-b2ca-df69-f7b27dfd4ce7@amd.com>
 <DM6PR12MB55345EA86293817DE5B71C6EF48E9@DM6PR12MB5534.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <124e31fb-de4b-d307-8919-353f61bd6b4a@amd.com>
Date: Fri, 5 Nov 2021 17:10:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB55345EA86293817DE5B71C6EF48E9@DM6PR12MB5534.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:191::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 21:10:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b146ee2d-de16-4918-2307-08d9a0a0c2bb
X-MS-TrafficTypeDiagnostic: DM6PR12MB4009:
X-Microsoft-Antispam-PRVS: <DM6PR12MB40092753AB5EEEEC13737F6D928E9@DM6PR12MB4009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fVLQ0rQJKX5792Uz09fgG7UR5Y4NMigub+dsOHsUaXi5yDgBJTmdUOWuGNNaatFBd6KbXl3mSQc9hgNf81HasRbKsGx0K6ZFLxV2yaT8IFDvpaNFjxAZjrkfJV5bWdhPEUzmblbZjGhy4H8Be2sDthYJ4kVtPTzQbbBD5ULOZh6Yu46OCR/oInD36zQUJoOV0bh+AUSEZjsPe0MeJ0VRZp0bYxQZMSIwi/BBVmHLnh/6P9a63EkT5W5p4gtCWdZFh+Tws5Ihl328EB5JX4fEKODH43raOyuuti7v702AuOSTu4cQPypozfF+n4yGHIy6YXWikEM1tRDNhOYAkrf4NRXE2/oFnaO1qtbD26Bl2IjBjviVgNSx6NbvERUfu72KrZRUBMX3cB4bFs7GNVupKEpM/btILBCGSY5lXssodHhpBdOdYLMn573siD7jFu84AzVL2Gul9ybPzDfBFeXrbBiwMn+r/UyZ4st52qzpfkDFm/daEUJB71cQxFEGm+Y+nPrz+Rpc4wbkFSzYQIDN1LAMw+DjI/vlmSBebW/8CwwFt3A6Xoc8ynD6VBDuCLF68JDYdUayi27j6B+YZFDfBJZjyUahL8OZaN98hnJo9jcHBFJRfWHKR4D9Sh56vSawN7uvEhObjSDFpajBQzE/GmEHYrl5BfeXQ0AeclNIYLYI4Ze7Zk67D7M6cyHkx24kayJmxSDdzwhVC3XtrK41gA8rOf1qkLThlXXmcHACVnWFUZXA6eRTQ1LT0tvNiinX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(31686004)(86362001)(31696002)(8936002)(53546011)(44832011)(38100700002)(508600001)(2906002)(8676002)(66946007)(6666004)(6486002)(66556008)(66476007)(36756003)(5660300002)(2616005)(83380400001)(110136005)(16576012)(36916002)(316002)(186003)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFEzVTlzaXFDNk9vL2tJWWR5SVF1WXpCajBDZVJNZGVJYW1rNjVyeUZCN00y?=
 =?utf-8?B?L2xCYWVnUnBwaGtaK1c3Sk1XdTc5UnRrK0RzMU1xVDhzZy9FOGFKWUo3WTk3?=
 =?utf-8?B?MnpmSmVNNFpkUWlPd3BvTGExL2VHQUt2cWNxeFloczlmZ2RmWWNabWJvZGtH?=
 =?utf-8?B?ZFUyQSs5M3c5VjlQVmhrMG5SRzhXWEEzN0VtTVNuZklWSnhvblR4cTNKcVlE?=
 =?utf-8?B?MWI2dDFlaUprZENUcTNMellVZ1pCRVM1R3VUMWYxRTlERGliMWpKY3hrK1NR?=
 =?utf-8?B?Vm0yZUlaMzJVSnVYblBZSDFIdlp0MUJDMnRuNUVhSW93N3hPRy9EUzhzZndG?=
 =?utf-8?B?d2k1cXlkejVTNnQ1U09mV2tDSHU4VS9oVmN1Sk9YanJPTHR6L2YzeXlhZ0FG?=
 =?utf-8?B?SVY5Vm9vL0YwV0FPQ0g5b3NuSEkxeWpzeWJ5VFkvSmRsQ25kTnhMbVAzSUo5?=
 =?utf-8?B?NmgySkltYUFlLzNneE5FbnhBR2hSZ3huSXpZNkI2Q1oxTDFKMUNXQlNIRnp1?=
 =?utf-8?B?K21oeEs0V0JyTTVrSXQ1dkRYYXNHY21SOTRyM0ZoTVdITnY2MGMwUmFzRXhM?=
 =?utf-8?B?bmlieEpCemtpaVlEbmpGdkkvVzRFUDgzUE8zUHdVdnIvOXN2b0x6R2Q3aXc0?=
 =?utf-8?B?VU44T0Y3bk1qbGc5dXNvOG1ncTlRdGhQTEhRVjFrVWdRNHhQZWt2djBpTHJT?=
 =?utf-8?B?M1ZRNU5HL1BHREI3RFVwQjFLbWhSYlR6dnVMNnZ2SHZWRGFMTlkyU3VIOXVj?=
 =?utf-8?B?eTFNNDhJS0pDUGJaZEpVSXJTVmQ2VWdIQ2h1bkFwb2RWUEdRL0dwTGxFVzA3?=
 =?utf-8?B?QXVQQ1VIY3NkblVUczZ4U0xOQ0wvZHRMUEpPeUtxSWM0endzZ21YVGw1NEVX?=
 =?utf-8?B?Y0tCcnY0RnhuS2psK2hSUEJTWGt5MEwvdHBwb21vSkViQTZlTC9zb1VuTFov?=
 =?utf-8?B?eXZ2Y21TblpYY01KK29ja1REUlJyRGs5cS82UkpVa0c2Q2JIbXJoNktpeW5F?=
 =?utf-8?B?ZHhRMVFGYUcrTmFPSnk2RU03MkNaU24vZ0hGQTJMTXZOcWo3MW1acWxmcjZu?=
 =?utf-8?B?SDIwejJmbmliUm8yS1l2UGhTeGR3d3l5REdwWVlGend1cGpFY2xFTkVydFZP?=
 =?utf-8?B?SGNVR1J3TFpPK054SjlobFpSVVhuQS9JMmlidnZjRlpxeXNvWGxXMzRqa0VL?=
 =?utf-8?B?TUxJV0FwczRkcVJDdEVQM1pGckFwNlZtL2o3TkUvU0V1eE5KaGVqNEpFTjIz?=
 =?utf-8?B?WUloMCtucll0Ykw5QlZwUHVlazBoR2lUbEZuUGh0bjBqYkpHNHE2Tk50RVBB?=
 =?utf-8?B?OEN0Y04vczc3b09xWVhBUjUyTmNaYUdObDF4NXdjWTNFWTIzZnRoR2o4eC9q?=
 =?utf-8?B?eTV4a0RGaE15MXpQWFE5RDJiemFOczFKMzIwYzhtL1l1MENDK3pXMG93SVA2?=
 =?utf-8?B?dXkvUFN0ZzVnbXRiZUdUbllUTWwvUWptOExlMDJyOHdiLytlMEk5cEIxZHFH?=
 =?utf-8?B?VSsraTlmai8ybVh6cFRTMUxpY3ozWFh1eFBQYVFETktkVHdDaTNoMzV3WDBu?=
 =?utf-8?B?bWQ3clZnOGJNZXNILzFuNVQ2UTJJcE1tT2hkazh2VGhFV1BKMTRNcVQ4NVNK?=
 =?utf-8?B?Szd2VUc5QnNNTmMrajFSRjEvYnhpSlgxKzBFR2xiYkdFa0lBK2wrY3JxSFVQ?=
 =?utf-8?B?c2w0N0tHbnhqYmhpSFQ0N1B5aGFsVnk2ellRMnlGNThTV2FLbGdCa0Y4cTBt?=
 =?utf-8?B?NkRka2xBN0hYb2VvNk9WVXpWY29QSTdHNGR0YjRsMVZWNzdwTXdyNFBEK2hn?=
 =?utf-8?B?S0wvcDAzZXN0S1JlVkpJY21jaGl6Q1V3dE5QUXJReVRtL3hLZURCUmRvbEE0?=
 =?utf-8?B?b3I5N3poZTFJVzVYK0o4NXpVNjJBK09CN3c4T1hJdjRxNjV6RlpHdm8wUG5y?=
 =?utf-8?B?aXluTld6K1FCVzNDbFVWb1orVkUvWUE2K1F0enRQeHVyc1N2MGdmZHpzOGx1?=
 =?utf-8?B?MTIxcFphbEJvVFI4WlgwbjFVT04vTlR1aUVUZnFkY0I5aWYweXl0T1hWR1ph?=
 =?utf-8?B?OEdpcXJBTFAxSjFGZlJFQU5jUWZGSnNQTkRjMS9UcVBUSmpTSGtubXFxTDVq?=
 =?utf-8?B?d2RyaWE3ZkVuREFYbnBIcTRZL1BaMVYvNnRnekljeWpTcS9WWVhDQWZZZFdp?=
 =?utf-8?Q?Pc6wJu0iG3OrLy7D4G8wris=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b146ee2d-de16-4918-2307-08d9a0a0c2bb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 21:10:57.3660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NzZFybL+C12l2Hf0N+K0h0BPNmopzvqesglQBi3Mbx7mGStRP1WOTaUV7zDtSgJNWVizKd3BboL7UO7uhqpB4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4009
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


On 2021-11-05 1:59 p.m., Liu, Shaoyun wrote:
> [AMD Official Use Only]
>
> Ye, a lot already been changed since then , now the  pre_reset and  post_reset not in the  lock/unlock anymore.  With  my previous change , we make kfd_pre_reset  avoid touch  HW . Now it's pure SW handling , should be safe  to be moved out of the full access .
> Anyway, thanks to bring this up, it will remind us to verify on the  XGMI configuration on SRIOV.
OK. Assuming it doesn't break in your testing, consider the patch

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Regards
> shaoyun.liu
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Friday, November 5, 2021 1:48 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: fix the kfd pre_reset sequence in sriov
>
> There was a reason why pre_reset was done differently on SRIOV. However, the code has changed a lot since then. Is this concern still valid?
>
>> commit 7b184b006185215daf4e911f8de212964c99a514
>> Author: wentalou <Wentao.Lou@amd.com>
>> Date:   Fri Dec 7 13:53:18 2018 +0800
>>
>>      drm/amdgpu: kfd_pre_reset outside req_full_gpu cause sriov hang
>>
>>      XGMI hive put kfd_pre_reset into amdgpu_device_lock_adev,
>>      but outside req_full_gpu of sriov.
>>      It would make sriov hang during reset.
>>
>>      Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
>>      Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
>>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Regards,
>     Felix
>
>
> On 2021-11-05 12:57 p.m., shaoyunl wrote:
>> The KFD pre_reset should be called before reset been executed, it will
>> hold the lock to prevent other rocm process to sent the packlage to
>> hiq during host execute the real reset on the HW
>>
>> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +----
>>    1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 95fec36e385e..d7c9dce17cad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4278,8 +4278,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>>    	if (r)
>>    		return r;
>>    
>> -	amdgpu_amdkfd_pre_reset(adev);
>> -
>>    	/* Resume IP prior to SMC */
>>    	r = amdgpu_device_ip_reinit_early_sriov(adev);
>>    	if (r)
>> @@ -5015,8 +5013,7 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>    
>>    		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>>    
>> -		if (!amdgpu_sriov_vf(tmp_adev))
>> -			amdgpu_amdkfd_pre_reset(tmp_adev);
>> +		amdgpu_amdkfd_pre_reset(tmp_adev);
>>    
>>    		/*
>>    		 * Mark these ASICs to be reseted as untracked first
