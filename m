Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60213606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=o33Q8waX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB31E10E1C4;
	Tue, 27 Oct 2026 20:57:05 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E179810F82E
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WX8SHsZVwemswNkNdiBAsZIEWFmWl8coT2PWPU6EFAhvgeQ5HTzG3o0mJHVDYbLwuQ4CY+POBvQvm3Zl2k4UiH+YJSlZXDjCM9/Z+tQQr0+6oPm1KIXQePMLomoPoz1gm4p1uTnSTTHaywXWZQNfd0EbwYtQnJs7BvLePcqG86C8szjcPFVhFxygFp9N+4zB/gRXcw5eKN1/85AZZWKn6yv0aTLsJandcv1OF4qlbmjTGpwAxoo72dKpGQIJG7hvaNsyfLm32EP8d/ZWM4Kwzu6nerD0n9IpWeqZdCDMF/D3fNFCcVmbmAWXTCW5BaLca+0Y362UUklgQxau3DmZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoTrmEtB5xdyfgAycGohi96N6New6u0WVAuN9GE6KUA=;
 b=MttNpf/v4W5f4BQS5Xu8+h4dpFUpVOtkStgopglmKfD0sw7LxdAIcJv1WwiEjwCggsWe8XbeAfGCI0L5sUfTFtkY9LQR6Rg7KPbX4eh3nknI7X9CVOEPxm0xN6AYN7pGMYzhrQ3zPcv8ZVMvN5Yr4RogfUchDsNAF0UUH/JlmwK53Q8HpXLOrjyr3V8tuZnPCIrdjhhc4j6SsoRqgbGT3CaoNaH7u6OipwrCgOFrNFoLIQXWnWBL5C5rQ6KhesRVEzmao52rj5FwD/yVv1qSEBqQF25Y7tNn/yt90hjF5xWVfsW6oZ9b6z+tTN5kKFrbvsKb4smEFp2+TrTRz8BlZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoTrmEtB5xdyfgAycGohi96N6New6u0WVAuN9GE6KUA=;
 b=o33Q8waXewiANZxXHJrtUqKt8CqAxhBD7SLaPGg/KWkDj0mopcPYX/jJnNUD7jVB3ZhMuJ51n90rft8T8bFL7TqKV1INUUeRapmXGexB30rBXtPTmFYrLR3l/rCOVSIEsjhlsmgHkmUHcgaviWJffUjY6RpNmtDU8JFaoHS/M5o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by DS0PR12MB8479.namprd12.prod.outlook.com
 (2603:10b6:8:155::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 20:56:08 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 20:56:08 +0000
Message-ID: <da1f45b4-50a9-48fb-85d4-c931593dbc9d@amd.com>
Date: Tue, 27 Oct 2026 16:56:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-2-mukul.joshi@amd.com>
 <ee1e254f-c322-4a75-be7d-a05a67af0e9a@amd.com>
 <20f59956-e398-449c-a38f-742176937a2a@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20f59956-e398-449c-a38f-742176937a2a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0371.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::20) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: ef89a0b9-1864-4073-0197-08df346cb998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|10067099003|22082099003|261026121527099003|18002099003|3023799007|11063799006|4143699003|261021123027099003|56012099006|261021121427099003|261022075727099003|261009223027099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: FMyUnX/ju1EFBF3tOdU8vnHfx/LiGtiEfNRiSpulK9ncEZplyXblE1TJ2/KwrzJHZ8ec+FnMi1NnqasCcST9rkfjgl/xZsxKb75RUuA4Gg0U5XHXRRNfAAmaMlboZBJz0iAvYSvemLujuATIy95Ap7ugeK61jQs+MG72wLNuB2f9GF+EeS7pezJzd15aXGKG63CQAAbz9Ht3L0K53xFQU313dAA8IFJFZN1Qec8Vfa3uPRNPcJcxABjKugOLZBXwXuNe+XIXr14Rgp6R8cgV51lDvy1oEspuDhSrKzEtKtaqr81MMl/9ymKNU5Q7ZtG75grTkLLPAHIkdaUf5R7w04YEXY7a4VtbczMR0Ip+f/5/AfdhIMzTKV9ECzHcjKg8Cz/ewZkIDb2BAHj4r2Ag8KJkFRdcvvXDWBWGehOHWkF6YwYYq4f8/o4HvwbuTzhVUC99Q/RfSRuv4LWQTLt/95ySN+cpUrXydB7JtI6pSGQ2aoJaUzTSjLh6WWuhxBLFV4bSIvN58DF/tTlIf+qW8T1WMQh1ZHEgTM+kpH9yPyPLyu8L10IMDPtD27jxhLmDVfB3Twyluah5alRJYxJUTXMaQBuWJvxSGvDTLAqoUoiepWuzdiOMhDwnM0gi9qfxnlDczRrQTbL1yWwewpyOV5ptwY+e6TwV9jY/7IbsXwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(10067099003)(22082099003)(261026121527099003)(18002099003)(3023799007)(11063799006)(4143699003)(261021123027099003)(56012099006)(261021121427099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWlwOXFlQ2EyQ1Baa2N2eXBra0VnekJFRWN0cTBjOWdyK1BXalFoSjFqbEFR?=
 =?utf-8?B?YVB3Ri9MeXBMMEhIZHQ5WXBSdWN3NWtFd0dUdWFiQVQrZHhUQnN6U0RkTGxx?=
 =?utf-8?B?Uk5HOEhTYkpvZG5zamZqN0lDc2ZaTXRaNnJZNHpOcmp1dUVjY0tvaGlEbDRZ?=
 =?utf-8?B?Q05vT2RWT3FYdCs3ZnhpNmV0dHRzWkl0djhpdmd4dVNFSmdIVTJVMlhOd1Zo?=
 =?utf-8?B?NUxzajdyZjVLKytYVHJ6cVliWXZNV3RqcVNlWW1VQTczYk9RSStUYmtsR2tK?=
 =?utf-8?B?UklFcVMvYkdXKzJpQlc0V3pnMVgxQTFyVzI3dEtUVHhWZ20rZWgydGdkbk0v?=
 =?utf-8?B?a1FibkRFV3NiM0JTWmlBY3dtekQ3MlQ2Nm5HU3NBZTBCWC9KNnp3RXdvd3lD?=
 =?utf-8?B?aGtESTRhc25CSFM4RGNXNHRUMGV3YkEvUUlIc1B2U3lTTCs5bzJ0a1JQT1Z1?=
 =?utf-8?B?YzA2bE9JNldLMWt3Y1JQVi81VVo1Nnp4RFhWV3U2dE5UbndETjVmaUFGU3F6?=
 =?utf-8?B?RHJkeHg1Vjhab0QxUHJNMXBiMGhDRXg0V1NicktaeHBCUlRuL015YnVGK0JP?=
 =?utf-8?B?M0ltdllrZlVtRXVNcHRKWWR3UitIQlB5NmJHcFM0UURIc1c0TFRlS3FsZnRB?=
 =?utf-8?B?OWZodXZKN29LYVBLb3B6QVRsZ0MvTEQ1eHplSGxJZVR4cVZrZ2UreWkwcStQ?=
 =?utf-8?B?NGJDK3RERmpwTzRxeFAzcnROVzBTcXVqTG9IMUppWDFkQXhPclIxdW81aUZY?=
 =?utf-8?B?MzUxZ0dyWTlxS0JoQUw1dVFFQk0xaitQekpRNG00V3FTSVQxdTZYV2I4SWpG?=
 =?utf-8?B?eXhsZjlac21nWGt0L2dLa096MUdWQTB2dHcwYTlOK2VNMDh1R3dHb0p0eGlG?=
 =?utf-8?B?OSt4aGZmaGJvaDRINjkwWlRjSzNNdWRoTHV6SXJnUnA0RE5sNUZ1T1VlVkUr?=
 =?utf-8?B?dFVzdHRpUUJkTmxVUDhJQVM1T3hUNlMzUlhyVk9UWEdFNDh4UHVaWjZFZFRp?=
 =?utf-8?B?Snl1ckgxNHFtbEtOWmhpRjZ1Tk9mUUlQbEtkZXlyTGRVUkdjVzh2WFJCeGVV?=
 =?utf-8?B?UFhZY2R2dTBvWjUxc3U3N1drU3M5ZUJ4VWYyL0dxZFpJR2ZqZEtqbWV0TmtK?=
 =?utf-8?B?SHZEaGE5emFQUFBtSnRUblNzVERBcDArTnhmc0h6Q0xQVXhoVUJBcXVuMkJS?=
 =?utf-8?B?dFYrWWY1cVNSYVhiZWs5czdJZlRBN2szdk5xdXEzNGcyRW9QcU5meWRDRXlT?=
 =?utf-8?B?MVRXQzA3Y2IyZkNZRDBEZTQwNHlnVHZlRnFBdzJPSnlQRkIyakdKVy84bHM4?=
 =?utf-8?B?TEhRZlplRHZqY29yUFBYZE1JVmkzMjUwZFpqVTh2VlBzM0ZlOGE4MDFzTDhZ?=
 =?utf-8?B?UXdlSStUdGNzOUc5by9pT1NtYTRoK2pFZHlaQ3FybllHV2daT2lWZEd4bndX?=
 =?utf-8?B?bzhxbW8vV244VHQyUWhlY2djMy9qZ1dpc3Z3alhkN3VXZHhMaFdsWENKZXZn?=
 =?utf-8?B?ZzNMVlprWEhycU1zcDB3WE9IVHJzQzVoUDVQTkw2V21kTVhNOEhZSHNhbTdE?=
 =?utf-8?B?T3JQbGRUVjlxeE4wUkFEWkhvVENxNVlpSCsrUUNhL2JQYm4xdmFHTXNveXpx?=
 =?utf-8?B?Y3lkbW1NRUhxNGdOOEdnVzF4N1REV0thc1UwR3F6azRGMUtCTDFra0xpcHFm?=
 =?utf-8?B?NnFUc1dnUC90elo0bVVmaW5QUlBZb0R4Ny91Q1pYMDd2M1VhNUMxdUFHd3Zh?=
 =?utf-8?B?cEJkcDVUR2hVS0o0R3lWOXh3R0JBUjloVXNUWm9OalJzK0FQQTdIWlVyVjNJ?=
 =?utf-8?B?SmFaaUFDRE15b3d3N3g3N1oreWpubThySlJZenRrUVVQckIxWWwvQU44NjM4?=
 =?utf-8?B?Uk1wZnJnb3NVTDRNRVBSN1c2T3BvYUJqNzBtb1dDYnJUUjhuVjlydXQveE41?=
 =?utf-8?B?Z2Zzd0ZpcEVYa2JsL2xreEh2VGpSck9QVllUMzQ4RmphZXZMeFQySVcrRDd2?=
 =?utf-8?B?Yk1ib0NndURTRUlTaTMrOG9qa2gwN0hOcDQvb1lkL01KTzhOMXc1OXBYYUQv?=
 =?utf-8?B?Q2hZaTFDNTNoVm85cGVzU1dESnBNendyb2NFSFZsblJOdkY2YURCTXB2aDlk?=
 =?utf-8?B?TFovSG1qQ3l3RWJaNEdJQkJTL3o1YVFKa3MrbitWR1RSOGprNlh3cXdaM0I4?=
 =?utf-8?B?eDNOanAxN1hFb0ZqKzBrRkxqeEtWYk45VDVNZ3dZQkwyOFg3SEQza2dmZ29B?=
 =?utf-8?B?NlV5M2FHaTVnTEpueGdQTHdDOVlEdlY3N2xqcmRmQjJmU1NzOFF4NnhBUmtI?=
 =?utf-8?B?a0NzdGlUeWpyTk11NUNzaVdWUm12RHFDcTgvcDVoU24zSDJBU09NZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef89a0b9-1864-4073-0197-08df346cb998
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 20:56:08.6183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDuRfTtQVcgNf0pkAyfk8SBhxeR4+0c/QLC3oSm7zVTMqMvC9h/0Seh1FpzNMNIZEqgyuWexiMlLdUChJlsAFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

One more nit-pick inline ...

On 2026-10-27 16:45, Mukul Joshi wrote:
> On 10/27/2026 4:22 PM, Felix Kuehling wrote:
>> On 2026-10-27 15:54, Mukul Joshi wrote:
>>> Add the infrastructure for UALink loopback mode, where a single GPU
>>> plays both the exporter and the importer role under two fixed
>>> accelerator IDs:
>>>
>>> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>>>     with the fixed exporter and importer accel IDs.
>>>
>>> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>>>     ualink_imp_accel_id(), which return the exporter and importer accel
>>>     ID in loopback mode.
>>>
>>> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>>>     workqueue used to emulate exporter->importer messages, and destroy
>>>     it in amdgpu_ualink_object_fini().
>>>
>>> Loopback is not enabled yet, and outside loopback both helpers return
>>> ppod.accel_id, so there is no functional change.
>>>
>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>> ---
>>> v1-v2:
>>> - Drop the change in find_peer_adev() as its not needed (Lijo).
>>>
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 99 +++++++++++++++++-----
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 29 +++++++
>>>    2 files changed, 109 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> index ca6432610f71..2cd6dc71ab9f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>> @@ -89,8 +89,34 @@ static int amdgpu_ualink_drm_client_create(struct
>>> amdgpu_device *adev)
>>>        return 0;
>>>    }
>>>    +/*
>>> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
>>> + *
>>> + * Called once loopback mode has been detected. Allocates the ordered
>>> + * workqueue used to emulate exporter->importer interrupts in SW.
>>> + */
>>> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>>> +{
>>> +    adev->ualink.loopback.wq =
>>> +        alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>>> +    if (!adev->ualink.loopback.wq)
>>> +        return -ENOMEM;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>    static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>>>    {
>>> +    /* Tear down the loopback self-interrupt workqueue allocated in
>>> +     * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
>>> +     * pending self-interrupt work first.
>>> +     */
>>> +    if (adev->ualink.loopback.wq) {
>>> +        destroy_workqueue(adev->ualink.loopback.wq);
>>> +        adev->ualink.loopback.wq = NULL;
>>> +        adev->ualink.loopback.enabled = false;
>>> +    }
>>> +

This function deals with destroying the kobjects. Hence the word 
"object" in the function name. I think this loopback tear-down belongs 
in ualink_ip_sw_fini instead.

Regards,
   Felix


>>>        if (!adev->ualink.info)
>>>            return;
>>>    @@ -472,6 +498,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block
>>> *ip_block)
>>>            __amdgpu_ualink_activate_vpod_locked(adev);
>>>        }
>>>    +    if (adev->ualink.loopback.enabled) {
>>> +        r = amdgpu_ualink_loopback_init(adev);
>>> +        if (r) {
>>> +            dev_err(adev->dev, "Failed to set up UALink loopback:
>>> %d\n", r);
>>> +            goto error;
>>> +        }
>>> +    }
>>> +
>>>        r = amdgpu_ualink_drm_client_create(adev);
>>>        if (r) {
>>>            dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
>>> @@ -1028,6 +1062,31 @@ static struct amdgpu_device
>>> *find_peer_adev(unsigned int accel_id)
>>>        return NULL;
>>>    }
>>>    +/*
>>> + * Physical accelerator roles.
>>> + *
>>> + * Outside loopback a GPU owns a single accelerator, so both helpers
>>> return its
>>> + * ppod.accel_id and the exporter/importer distinction collapses. In
>>> loopback
>>> + * the one physical GPU plays both roles: the exporter owns the MP
>>> nHT and
>>> + * receives all HW traffic, while the importer is the (virtual) HW
>>> sender for
>>> + * the importer -> exporter path.
>>> + */
>>> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
>>> +{
>>> +    if (adev->ualink.loopback.enabled)
>>> +        return adev->ualink.loopback.exporter_accel_id;
>>> +
>>> +    return adev->ualink.info->ppod.accel_id;
>>> +}
>>> +
>>> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>>> +{
>>> +    if (adev->ualink.loopback.enabled)
>>> +        return adev->ualink.loopback.importer_accel_id;
>>> +
>>> +    return adev->ualink.info->ppod.accel_id;
>>> +}
>>> +
>>>    static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>>                         u32 accel_id)
>>>    {
>>> @@ -4487,11 +4546,6 @@ static bool
>>> amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>>>                     AMDGPU_UALINK_ACCEL_MAX);
>>>    }
>>>    -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
>>> -{
>>> -    return adev->ualink.info->ppod.accel_id;
>>> -}
>>> -
>>>    static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct
>>> amdgpu_device *adev)
>>>    {
>>>        return adev->ualink.info->vpod.addr_mode;
>>> @@ -4837,7 +4891,7 @@ static void
>>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>>    {
>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>        u64 timeout = msecs_to_jiffies(2000);
>>> -    u32 dst_accel_id = ualink_accel_id(adev);
>>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>>        struct amdgpu_bo *bos[2];
>>>        u32 n_bos;
>>>        struct dma_fence *fence;
>>> @@ -4956,7 +5010,7 @@ static void
>>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>>    static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device
>>> *adev)
>>>    {
>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> -    u32 dst_accel_id = ualink_accel_id(adev);
>>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>>        u64 timeout = msecs_to_jiffies(2000);
>>>        struct amdgpu_bo *bos[2];
>>>        u32 n_bos;
>>> @@ -5241,7 +5295,7 @@ static void amdgpu_ualink_metadata_fini(struct
>>> amdgpu_device *adev)
>>>    {
>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>    -    dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
>>> +    dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>>>        amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>>>                          &remote->rptr_cpu_addr);
>>>        amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
>>> @@ -5288,7 +5342,7 @@ static int amdgpu_ualink_metadata_init(struct
>>> amdgpu_device *adev)
>>>        }
>>>          dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 0x%x\n",
>>> -        ualink_accel_id(adev), ualink_addr_mode(adev), status);
>>> +        ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>>>          /* Alloc metadata structure for all GPUs */
>>>        metadata_size = sizeof(struct amdgpu_ualink_metadata) *
>>> AMDGPU_UALINK_ACCEL_MAX;
>>> @@ -5361,12 +5415,12 @@ static int amdgpu_ualink_metadata_init(struct
>>> amdgpu_device *adev)
>>>        }
>>>          if (ualink_addr_mode(adev) ==
>>> AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
>>> -        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>>> ualink_accel_id(adev);
>>> +        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>>> ualink_exp_accel_id(adev);
>>>          for_each_set_bit(accel_id, remote->active_accel_bits,
>>> AMDGPU_UALINK_ACCEL_MAX) {
>>>            dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>>    -        if (accel_id == ualink_accel_id(adev))
>>> +        if (accel_id == ualink_exp_accel_id(adev))
>>>                continue;
>>>              rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>>> @@ -5392,7 +5446,7 @@ static int amdgpu_ualink_metadata_init(struct
>>> amdgpu_device *adev)
>>>                                 ualink_tlb_wptr_offset(adev, accel_id);
>>>              dev_dbg(adev->dev, "init from accel_id %u to accel_id %u,
>>> rb_size 0x%x\n",
>>> -            accel_id, ualink_accel_id(adev),
>>> metadata[accel_id].rb_size);
>>> +            accel_id, ualink_exp_accel_id(adev),
>>> metadata[accel_id].rb_size);
>>>            dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>>                metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
>>>            dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>>> @@ -5806,7 +5860,14 @@ static void amdgpu_ualink_get_wb_addr(struct
>>> amdgpu_device *adev,
>>>                          u64 *wb_npa, u32 type)
>>>    {
>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> -    u32 accel_id = ualink_accel_id(adev);
>>> +    /* The GPUID encoded in the write-back NPA address is the
>>> routing target
>>> +     * the remote writes the rptr back to, i.e. THIS GPU. It must be
>>> the
>>> +     * physically-owned accel_id: outside loopback that is our own
>>> accel_id,
>>> +     * and in loopback it is the exporter (the only id the single
>>> GPU owns
>>> +     * and can receive on). The importer is only a logical source id
>>> for the
>>> +     * forward path and must never appear as an NPA GPUID.
>>> +     */
>>> +    u32 accel_id = ualink_exp_accel_id(adev);
>>>        u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>>        uintptr_t wb;
>>>        u64 npa;
>>> @@ -5981,19 +6042,19 @@ static int
>>> amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>>                               &peer->shootdown, &tlb_wptr);
>>>        if (r) {
>>>            dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed
>>> %d\n",
>>> -            ualink_accel_id(adev), remote_accel_id, r);
>>> +            ualink_exp_accel_id(adev), remote_accel_id, r);
>>>            return r;
>>>        }
>>>          if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr
>>> == tlb_wptr) {
>>>            dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same
>>> as remote %u\n",
>>> -            ualink_accel_id(adev), int_wptr, tlb_wptr,
>>> remote_accel_id);
>>> +            ualink_exp_accel_id(adev), int_wptr, tlb_wptr,
>>> remote_accel_id);
>>>            return 0;
>>>        }
>>>          dev_dbg(adev->dev,
>>>            "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr
>>> 0x%llx 0x%llx\n",
>>> -        ualink_accel_id(adev), peer->interrupt.wptr,
>>> peer->shootdown.wptr,
>>> +        ualink_exp_accel_id(adev), peer->interrupt.wptr,
>>> peer->shootdown.wptr,
>>>            remote_accel_id, int_wptr, tlb_wptr);
>>>          amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, NULL,
>>> @@ -6164,7 +6225,7 @@ static int
>>> amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>>>        struct amdgpu_ualink_peer *peer;
>>>        struct amdgpu_ualink_ring *interrupt;
>>>        struct amdgpu_ualink_ring *shootdown;
>>> -    u32 src_accel_id = ualink_accel_id(adev);
>>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>> This is changed to ualink_imp_accel_id in patch 5. I think we should
>> use the correct function here, where it's introduced.
>>
> Good catch. I made the change here and removed the change from patch 5.
>>>        u32 dst_accel_id;
>>>        u64 npa, flags;
>>>        int r = 0;
>>> @@ -6287,7 +6348,7 @@ static void
>>> amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>>>    {
>>>        u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>> -    u32 src_accel_id = ualink_accel_id(adev);
>>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>> This is changed to ualink_imp_accel_id in patch 5. I think we should
>> use the correct function here, where it's introduced.
> Good catch. I made the change here and removed the change from patch 5.
>
> Regards,
>
> Mukul
>
>> Regards,
>>    Felix
>>
>>
>>>        u32 dst_accel_id;
>>>        struct amdgpu_ualink_peer *peer;
>>>        struct amdgpu_ualink_ring *ring;
>>> @@ -6374,7 +6435,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device
>>> *adev)
>>>     */
>>>    void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>>    {
>>> -    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>>> ualink_accel_id(adev),
>>> +    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>>> ualink_exp_accel_id(adev),
>>>            ualink_addr_mode(adev));
>>>          adev->ualink.msg_ctl->send_halt(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> index 85c9a9634a4b..0b1e8dd38666 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>>>    #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN        0x1
>>>    #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN        0x2
>>>    +/* UALink loopback support.
>>> + *
>>> + * In loopback mode a single GPU loops UALink requests back to
>>> itself for
>>> + * manufacturing testing. The GPU exposes two fixed accelerator IDs:
>>> it acts
>>> + * as the exporter on one and the importer on the other. Loopback is
>>> enabled
>>> + * with the amdgpu.ualink_loopback module parameter.
>>> + */
>>> +/* Fixed accelerator IDs used by a loopback GPU. */
>>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>>> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID        0
>>> +
>>>    enum amdgpu_ualink_conn_state {
>>>        AMDGPU_UALINK_CONN_NOT_READY            = 0,
>>>        AMDGPU_UALINK_CONN_IN_PROGRESS            = 1,
>>> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>>>        int (*send_halt)(struct amdgpu_device *adev);
>>>    };
>>>    +/* UALink loopback mode state.
>>> + *
>>> + * When @enabled is true this single GPU acts as both exporter
>>> + * (@exporter_accel_id) and importer (@importer_accel_id). There is
>>> no second
>>> + * physical GPU, so exporter->importer messages cannot be delivered
>>> by the
>>> + * (single) MP nHT and are instead emulated in SW by feeding them
>>> back into
>>> + * our own IRQ handler via @wq.
>>> + */
>>> +struct amdgpu_ualink_loopback {
>>> +    bool enabled;
>>> +    u32 exporter_accel_id;
>>> +    u32 importer_accel_id;
>>> +    struct workqueue_struct *wq;
>>> +};
>>> +
>>>    struct amdgpu_ualink_mgr {
>>>        u64 npa_size;
>>>        u32 psp_if_ver;
>>> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>>>        /* For remote interrupt and shootdown */
>>>        struct amdgpu_ualink_remote *remote;
>>>    +    /* UALink loopback mode state (see struct
>>> amdgpu_ualink_loopback) */
>>> +    struct amdgpu_ualink_loopback loopback;
>>> +
>>>        /* handle irq from ualink client of remote GPUs */
>>>        struct amdgpu_irq_src irq;
>>>    
