Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52067606A31A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wMiSJrsD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE42110F9C4;
	Wed, 28 Oct 2026 06:06:31 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E543110F9C8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 06:06:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdyP/LB73W9kYFOm35F7q/8TFxMxgX3gWPIyk8I8CHs4Y+pF1PPdLAYqIrLgtwkQRbSLzvIxBl4rv4XzdL+4glKzwF5bTbfYxrpb9q2h5UtgNMpeaeecK7lH23/Ji9TPdVHay+PyPF1RlSVQSCK9w6oRwRocukVDLiWrRqJHD1YNNY5UxCLmGG7PnO3U1EIv6ur/tUrix9DdYfH3f6G4IJ21nO2BTgL8CefSqI1aVNtFhAKjvThTg0CiT12gZR62JCyJzoKd2LAYspmceuM7h3ThamFGpbhznruIEAqAli3zTtDYqaaxWUqWpeuUUwemfaixDE8xbE1bi+Po/3kuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtI59aPjfisW9ITKciC8+9m90b0a6/7djMvWUGB3fp0=;
 b=y3PUcK641H9G3ZdenShgRnhqGLYB0KbAy+DbhTWJtvCMRxPL6QkK184P2ghXlKLei2C9Ck5dpp9CgG0hP2PacPyXV22PH4kwXrcQelk2aHnVKHPMGykMvGRMvnRQKosdrsC45KQC6KlSZSzpyqn1iIf07gx9cy2XTLSgsy32VGpK4AhNRps1o/qsz2SQAHauS0EaaM/gn7CuBIEBcixFdAhOQKfBzsNylUXR9HdYljTXdawjKLNkHg8ymai2dxKUaFRC7fM6zAU4lpxfShIZjJ7Lgoqn2ci/Vpav/F/yl3bjDr4dYpoCSRFhv84xVxadDDl9v83ELBWRAHWQPjpRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtI59aPjfisW9ITKciC8+9m90b0a6/7djMvWUGB3fp0=;
 b=wMiSJrsDHbmatD4drxH8bi8EWA9ecgaLttEUgh476kE40Lv+K3VzJPTXmh5o53GEHr81Y2IeuMoX2SZAjuT+FY9R6zF6Jd+q/2z2T5Tby3eSUmaSB/0fwCJArnm7dIviL+ojFEmV0XOHE2Qi24M2C3CDvNiYfohOXhcF/jM+K5Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com (2603:10b6:a03:4ae::12)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 06:06:22 +0000
Received: from SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819]) by SJ0PR12MB7082.namprd12.prod.outlook.com
 ([fe80::fcf5:4106:dc85:4819%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 06:06:22 +0000
Message-ID: <3b978d68-f65c-4252-944d-94aee9b43922@amd.com>
Date: Wed, 28 Oct 2026 11:36:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/8] drm/amdgpu: Add UALink loopback infrastructure
To: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-2-mukul.joshi@amd.com>
 <ee1e254f-c322-4a75-be7d-a05a67af0e9a@amd.com>
 <20f59956-e398-449c-a38f-742176937a2a@amd.com>
 <da1f45b4-50a9-48fb-85d4-c931593dbc9d@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <da1f45b4-50a9-48fb-85d4-c931593dbc9d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::20) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7082:EE_|DM4PR12MB5988:EE_
X-MS-Office365-Filtering-Correlation-Id: 0963faed-4c16-48f0-9f4e-08df34b99738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|261009223027099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|56012099006|261026140227099003|6133799003|3023799007|18002099003|22082099003|261026121527099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: PuqM2QJdXUqdvqbkmNLDFOZJ/lZCqw0jGFYLdCPkVrXiWmKEzsCDPU+SfEkMPMvDJqv8v/cmGjDmijXtZXAqbhD8VJDpqQjVisPcNHNOyeBMSM+KwG4tUyDRsEnvtr+lL5SXGYFFX/O7ebK8MqVW0oXnjU03V8uUZJYNmOL2/GvnwJyG5W4RJ2cV88H0xAaxAHWjXU5LhY+ZkYT0lS7UZEu9g59FR0IfyBw/hXuMD5PG0vS3CQbWL5Od4WOv5Sbu24xo/ZlHUa66RSg2p87tf4pd48YKqBZUhC0MxW/B9lHDpVXILzozGtuPw1iyU/8geDptF8s8qEvAfi+n+ilRtBb0N9HaaGBROul8otuH+IqMgl6GbWrnIavQwdv742tF0a4745Sudu0dexp71z/0AQZomhdS0Jmmf9Tcs5+avyJdmu2Ml6TvK+oAMzZmMruZz0ekrjQ5/HhDTAUX0CD7yIXdR0iLr51trPpCgqxsrDesRvlfDAm5cqM8MRNdjCtZ3+qs8d01QmPaGfnxSwcWCoSAWOiR4OnIH8JOlM6abHFtudaGTpI2QgQ69eIZWXgfLOmaPx6liyToDY+pjNM6zD7CxzXX+FyWhO7HCP/UYMxO0s/ExBTy+klcSxEJ/+K0h8uAL90GHcftJS3BrTyyuAG3AxNYC1nCNcGIWD4p9o8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7082.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(56012099006)(261026140227099003)(6133799003)(3023799007)(18002099003)(22082099003)(261026121527099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzBaYWVheUhaZ3BLYVBDdFM5VU9aR0ZXL0wxMGZqR2FnQTYrZm8yYnV1NjFj?=
 =?utf-8?B?dFNJZCtGaHRaNWlnOEluSExLWjRHazErUWpGcEY4OHNuTERxSU13RlJxc2Rs?=
 =?utf-8?B?TUdvK3habjNiMlFleTBrakVOTXYzdE52UXFXMVQrc1R4NjZodlR1enR2NFNq?=
 =?utf-8?B?ai92YVFDY1ZVejVyNzQ4ZjNNekRiYzNvdlA3SzJoWVNsOUxyTVFFek5rT2Fn?=
 =?utf-8?B?Q2Rna0pINlduM1pQWGhDYTdxbEd6YXQ3eFVobVkrbS9RSkRxaXVYR2ZSUHMz?=
 =?utf-8?B?Umx2ZkUyQytXRzhGaEovbmZhWHZ3ODZmbzdGTCtkV1ZkdFlROGZoVFVhWE8y?=
 =?utf-8?B?c0RSaFVLa2dxNjl2c3dpSkNHZ0NBSGxoQklzTEllU3NjVzVnTmZsR0pNRERm?=
 =?utf-8?B?a2N4TElKNnNGNm1udCt4enhFcUc1REJDMy9oV2N2cnNTU3VEb1ovM1J5T0FG?=
 =?utf-8?B?OXpPR0p5Mit0RFRrNyt5UHZOY0lCTzRJdnlMNHkybmFibmZFZktCQ1hHc0g3?=
 =?utf-8?B?aVZieVN1MEdyUGRIU2ZkSzk5QmhSRnpxelNhKzJudk03c3lDcnNnRFNjM2ty?=
 =?utf-8?B?REd2MGZ1OHd2VUhaUEp6WXBUNndrTG04ZUhTcnh0T09EbkgxZDZVWDBvTmFa?=
 =?utf-8?B?R0pYSDk5S2RUMVM3UWlVK1BKTEExVVRKaUE1V2F5NFJmTGswUWFCdUtxVDNQ?=
 =?utf-8?B?YmNxYjA5ZitlMjJlRFNCM1NoQnp4emh6djNXWU0ybU15WFZ2aWlqdktPdzh0?=
 =?utf-8?B?V0xUempXRXR3Tk9zRlozZjFnNEpTL2FoS21RS1FlbXdzc2ZBNDVyVWw0OUdt?=
 =?utf-8?B?NjZyUFFON04rNG8wQnJhK1RZNk5QeHhLV1ZEejdFamNNM0l0alBxekJ5Nlky?=
 =?utf-8?B?a0NJb2hPVGhSYVl1dGVtZlh2R3pmK1UwY09YRExwb09DOTBuYld0aHlZV3NN?=
 =?utf-8?B?eEh6dlhlOFBYTndGdTF1TVVhY25MbEpOd2pQRWJDMENJSGgvczQxRHVPMDIz?=
 =?utf-8?B?NWh5R0lVMVlwamZQTHpDZFVFZ0NMZUZBQjdFeHJnMmQ1ai9RMDhMcVNOSlVZ?=
 =?utf-8?B?Rm9TNkJ5MnlLWGtZNis1QkZDYmgvRUlMT09uVWhrNXRGOFpUZ1I4cVhDekdL?=
 =?utf-8?B?NXlmbGo1UkdjaW1YbjAwOW4ydmJyZW9Od3N0ZGtyTVVrWUppK0N6N0w5UWpu?=
 =?utf-8?B?SjUxcWVBR3A3R2pyT1RCbUhiYnFZT3J1MUZEZ1ZCMFVMeXVDTVZOZURjWkhI?=
 =?utf-8?B?MUFNTFIxeWdwa1RiZzA3TDZQRld1VXBETFpXaGpIT1ZRQ25RZXNQVm4zZHpu?=
 =?utf-8?B?VVhPRE1TSFlSdytodjRFS2ZjcFoxOTg5WkEySGRKUzZkWDN6VVdaTERYeXZt?=
 =?utf-8?B?QWVsMDNTcEpaRmxDRWlpejhvdTZPMHJ4SFJsN1VEczdLcEZUODVUVDlmQVhl?=
 =?utf-8?B?eE1JQVd3TGI3Qk1UKzUyai9UeisrUDQwNWxtelpUVkhwTG16Q016bnJzWVA1?=
 =?utf-8?B?Nldyd1JLRVJNbEtKVlV2Rm9TeTJ0MkpZZDIyVmF3OTc5SHptS2tBRHZ2emxZ?=
 =?utf-8?B?MHJOcjJQcndTeXAyb0FNOEFPZHlhL3FnNnpZdFdzMkRZYTNKMHpiUGhlMWRw?=
 =?utf-8?B?ZnBKSjZBemNQanlJY1E3Wjk1NVpVeXRKOFZVY3JrdjZNNWx2Ukh0ZVNkN1JZ?=
 =?utf-8?B?eFlydlJBdUtpWkNpRHVWMlhhVlQ1Zm1UNE5hQ3ZOem43MldPV3R6Nm41V05D?=
 =?utf-8?B?VWthTm1GVjI3VmYrZUhMdEV1UHFaMDBNWStyVnJpRWQ1Q245US92c2cyUklh?=
 =?utf-8?B?dnhTNUxUVTdzNDE0RVJRT1lRSTlWMGQ2YVpOVnVYQXZpWnlpcWpyUUpSVzBn?=
 =?utf-8?B?RjhDT0EvdlhYVVZXRTBSbVdFbVQzR3lNWVlhaTdlREZiN3MxTFdqUjhsVVJL?=
 =?utf-8?B?aHJOTGV6Y0lKbW01ZFZGS0NSNWNWNGViMTRZcEtyWnU5VmRXU2w2bjVUY00r?=
 =?utf-8?B?eEdaOXRxZ3BQTWN1VXNUaDIxNU9nNUFQaGVIRnltS0FIMVprNGQvN0ltcldB?=
 =?utf-8?B?Sk9jOEx2eXVUQS9ZZ3hYUGdVcmlCZWtlOWNqbHc0K1hJZkxhdy9udUVLcElo?=
 =?utf-8?B?MVpxSEY3MUVtZDdyamtxL25xMGJtWmR3bUx1MTQ3b0hOSHo4YkR4dTlxYXJJ?=
 =?utf-8?B?Q1ZMUENMeW41UkI0ZUJHR2ZOU3ltYVpBOW9NL1U4OFd0VjAveklGMWtyZzB2?=
 =?utf-8?B?M2NSR3lIQXVmUm9zczZJWVdtZnB3Vk1wQ29Sd2VJS3cvdW5lVnJRWkRWK2xP?=
 =?utf-8?Q?Z97BNsvpQPIg1+CzrK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0963faed-4c16-48f0-9f4e-08df34b99738
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 06:06:22.2589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/sl2s9CH2a+AjXISLITb/6dT7y/JpUeLlIkL6RYkAR4Con40FafUmRjniSCW7ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28-Oct-26 2:26 AM, Felix Kuehling wrote:
> One more nit-pick inline ...
> 
> On 2026-10-27 16:45, Mukul Joshi wrote:
>> On 10/27/2026 4:22 PM, Felix Kuehling wrote:
>>> On 2026-10-27 15:54, Mukul Joshi wrote:
>>>> Add the infrastructure for UALink loopback mode, where a single GPU
>>>> plays both the exporter and the importer role under two fixed
>>>> accelerator IDs:
>>>>
>>>> - Add struct amdgpu_ualink_loopback to track the loopback state, along
>>>>     with the fixed exporter and importer accel IDs.
>>>>
>>>> - Replace ualink_accel_id() with ualink_exp_accel_id() and
>>>>     ualink_imp_accel_id(), which return the exporter and importer accel
>>>>     ID in loopback mode.
>>>>
>>>> - Add amdgpu_ualink_loopback_init(), which allocates the ordered
>>>>     workqueue used to emulate exporter->importer messages, and destroy
>>>>     it in amdgpu_ualink_object_fini().
>>>>
>>>> Loopback is not enabled yet, and outside loopback both helpers return
>>>> ppod.accel_id, so there is no functional change.
>>>>
>>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>>> ---
>>>> v1-v2:
>>>> - Drop the change in find_peer_adev() as its not needed (Lijo).
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 99 ++++++++++++++++ 
>>>> +-----
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h | 29 +++++++
>>>>    2 files changed, 109 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> index ca6432610f71..2cd6dc71ab9f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> @@ -89,8 +89,34 @@ static int amdgpu_ualink_drm_client_create(struct
>>>> amdgpu_device *adev)
>>>>        return 0;
>>>>    }
>>>>    +/*
>>>> + * amdgpu_ualink_loopback_init - set up UALink loopback mode
>>>> + *
>>>> + * Called once loopback mode has been detected. Allocates the ordered
>>>> + * workqueue used to emulate exporter->importer interrupts in SW.
>>>> + */
>>>> +static int amdgpu_ualink_loopback_init(struct amdgpu_device *adev)
>>>> +{
>>>> +    adev->ualink.loopback.wq =
>>>> +        alloc_ordered_workqueue("amdgpu_ualink_loopback", 0);
>>>> +    if (!adev->ualink.loopback.wq)
>>>> +        return -ENOMEM;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
>>>>    {
>>>> +    /* Tear down the loopback self-interrupt workqueue allocated in
>>>> +     * amdgpu_ualink_loopback_init(). destroy_workqueue() drains any
>>>> +     * pending self-interrupt work first.
>>>> +     */
>>>> +    if (adev->ualink.loopback.wq) {
>>>> +        destroy_workqueue(adev->ualink.loopback.wq);
>>>> +        adev->ualink.loopback.wq = NULL;
>>>> +        adev->ualink.loopback.enabled = false;
>>>> +    }
>>>> +
> 
> This function deals with destroying the kobjects. Hence the word 
> "object" in the function name. I think this loopback tear-down belongs 
> in ualink_ip_sw_fini instead.
> 

Adding to this one -

If loopback mode is through module param or can be detected as early as 
sw_init phase, then loopback wq allocation may also be moved to sw init 
phase. That's the place for one-time allocations, late init gets called 
during runtime also.

Thanks,
Lijo


> Regards,
>    Felix
> 
> 
>>>>        if (!adev->ualink.info)
>>>>            return;
>>>>    @@ -472,6 +498,14 @@ int ualink_ip_late_init(struct amdgpu_ip_block
>>>> *ip_block)
>>>>            __amdgpu_ualink_activate_vpod_locked(adev);
>>>>        }
>>>>    +    if (adev->ualink.loopback.enabled) {
>>>> +        r = amdgpu_ualink_loopback_init(adev);
>>>> +        if (r) {
>>>> +            dev_err(adev->dev, "Failed to set up UALink loopback:
>>>> %d\n", r);
>>>> +            goto error;
>>>> +        }
>>>> +    }
>>>> +
>>>>        r = amdgpu_ualink_drm_client_create(adev);
>>>>        if (r) {
>>>>            dev_err(adev->dev, "Failed to create UALink DRM client: 
>>>> %d\n",
>>>> @@ -1028,6 +1062,31 @@ static struct amdgpu_device
>>>> *find_peer_adev(unsigned int accel_id)
>>>>        return NULL;
>>>>    }
>>>>    +/*
>>>> + * Physical accelerator roles.
>>>> + *
>>>> + * Outside loopback a GPU owns a single accelerator, so both helpers
>>>> return its
>>>> + * ppod.accel_id and the exporter/importer distinction collapses. In
>>>> loopback
>>>> + * the one physical GPU plays both roles: the exporter owns the MP
>>>> nHT and
>>>> + * receives all HW traffic, while the importer is the (virtual) HW
>>>> sender for
>>>> + * the importer -> exporter path.
>>>> + */
>>>> +static inline u32 ualink_exp_accel_id(struct amdgpu_device *adev)
>>>> +{
>>>> +    if (adev->ualink.loopback.enabled)
>>>> +        return adev->ualink.loopback.exporter_accel_id;
>>>> +
>>>> +    return adev->ualink.info->ppod.accel_id;
>>>> +}
>>>> +
>>>> +static inline u32 ualink_imp_accel_id(struct amdgpu_device *adev)
>>>> +{
>>>> +    if (adev->ualink.loopback.enabled)
>>>> +        return adev->ualink.loopback.importer_accel_id;
>>>> +
>>>> +    return adev->ualink.info->ppod.accel_id;
>>>> +}
>>>> +
>>>>    static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>>>                         u32 accel_id)
>>>>    {
>>>> @@ -4487,11 +4546,6 @@ static bool
>>>> amdgpu_ualink_vpod_membership_changed(struct amdgpu_device *adev)
>>>>                     AMDGPU_UALINK_ACCEL_MAX);
>>>>    }
>>>>    -static inline u32 ualink_accel_id(struct amdgpu_device *adev)
>>>> -{
>>>> -    return adev->ualink.info->ppod.accel_id;
>>>> -}
>>>> -
>>>>    static inline enum amdgpu_ualink_addr_mode ualink_addr_mode(struct
>>>> amdgpu_device *adev)
>>>>    {
>>>>        return adev->ualink.info->vpod.addr_mode;
>>>> @@ -4837,7 +4891,7 @@ static void
>>>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>>>    {
>>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>>        u64 timeout = msecs_to_jiffies(2000);
>>>> -    u32 dst_accel_id = ualink_accel_id(adev);
>>>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>>>        struct amdgpu_bo *bos[2];
>>>>        u32 n_bos;
>>>>        struct dma_fence *fence;
>>>> @@ -4956,7 +5010,7 @@ static void
>>>> amdgpu_ualink_metadata_npa_unmapping(struct amdgpu_device *adev)
>>>>    static int amdgpu_ualink_metadata_npa_mapping(struct amdgpu_device
>>>> *adev)
>>>>    {
>>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> -    u32 dst_accel_id = ualink_accel_id(adev);
>>>> +    u32 dst_accel_id = ualink_exp_accel_id(adev);
>>>>        u64 timeout = msecs_to_jiffies(2000);
>>>>        struct amdgpu_bo *bos[2];
>>>>        u32 n_bos;
>>>> @@ -5241,7 +5295,7 @@ static void amdgpu_ualink_metadata_fini(struct
>>>> amdgpu_device *adev)
>>>>    {
>>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>>    -    dev_dbg(adev->dev, "accel_id %u\n", ualink_accel_id(adev));
>>>> +    dev_dbg(adev->dev, "accel_id %u\n", ualink_exp_accel_id(adev));
>>>>        amdgpu_bo_free_kernel(&remote->rptr_bo, &remote->rptr_gpu_addr,
>>>>                          &remote->rptr_cpu_addr);
>>>>        amdgpu_bo_free_kernel(&remote->ring_bo, &remote->rb_gpu_addr,
>>>> @@ -5288,7 +5342,7 @@ static int amdgpu_ualink_metadata_init(struct
>>>> amdgpu_device *adev)
>>>>        }
>>>>          dev_dbg(adev->dev, "accel_id %u addr_mode %d fw status 
>>>> 0x%x\n",
>>>> -        ualink_accel_id(adev), ualink_addr_mode(adev), status);
>>>> +        ualink_exp_accel_id(adev), ualink_addr_mode(adev), status);
>>>>          /* Alloc metadata structure for all GPUs */
>>>>        metadata_size = sizeof(struct amdgpu_ualink_metadata) *
>>>> AMDGPU_UALINK_ACCEL_MAX;
>>>> @@ -5361,12 +5415,12 @@ static int amdgpu_ualink_metadata_init(struct
>>>> amdgpu_device *adev)
>>>>        }
>>>>          if (ualink_addr_mode(adev) ==
>>>> AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS)
>>>> -        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>>>> ualink_accel_id(adev);
>>>> +        wptr_gpu_addr = remote->rb_gpu_addr + rb_size *
>>>> ualink_exp_accel_id(adev);
>>>>          for_each_set_bit(accel_id, remote->active_accel_bits,
>>>> AMDGPU_UALINK_ACCEL_MAX) {
>>>>            dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>>>>    -        if (accel_id == ualink_accel_id(adev))
>>>> +        if (accel_id == ualink_exp_accel_id(adev))
>>>>                continue;
>>>>              rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>>>> @@ -5392,7 +5446,7 @@ static int amdgpu_ualink_metadata_init(struct
>>>> amdgpu_device *adev)
>>>>                                 ualink_tlb_wptr_offset(adev, accel_id);
>>>>              dev_dbg(adev->dev, "init from accel_id %u to accel_id %u,
>>>> rb_size 0x%x\n",
>>>> -            accel_id, ualink_accel_id(adev),
>>>> metadata[accel_id].rb_size);
>>>> +            accel_id, ualink_exp_accel_id(adev),
>>>> metadata[accel_id].rb_size);
>>>>            dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
>>>>                metadata[accel_id].ri_rb, 
>>>> metadata[accel_id].tlb_inv_rb);
>>>>            dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
>>>> @@ -5806,7 +5860,14 @@ static void amdgpu_ualink_get_wb_addr(struct
>>>> amdgpu_device *adev,
>>>>                          u64 *wb_npa, u32 type)
>>>>    {
>>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> -    u32 accel_id = ualink_accel_id(adev);
>>>> +    /* The GPUID encoded in the write-back NPA address is the
>>>> routing target
>>>> +     * the remote writes the rptr back to, i.e. THIS GPU. It must be
>>>> the
>>>> +     * physically-owned accel_id: outside loopback that is our own
>>>> accel_id,
>>>> +     * and in loopback it is the exporter (the only id the single
>>>> GPU owns
>>>> +     * and can receive on). The importer is only a logical source id
>>>> for the
>>>> +     * forward path and must never appear as an NPA GPUID.
>>>> +     */
>>>> +    u32 accel_id = ualink_exp_accel_id(adev);
>>>>        u32 rb_size = AMDGPU_GPU_PAGE_ALIGN(2 * AMDGPU_UALINK_RB_SIZE);
>>>>        uintptr_t wb;
>>>>        u64 npa;
>>>> @@ -5981,19 +6042,19 @@ static int
>>>> amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>>>>                               &peer->shootdown, &tlb_wptr);
>>>>        if (r) {
>>>>            dev_dbg(adev->dev, "accel_id %u read remote %u wptr failed
>>>> %d\n",
>>>> -            ualink_accel_id(adev), remote_accel_id, r);
>>>> +            ualink_exp_accel_id(adev), remote_accel_id, r);
>>>>            return r;
>>>>        }
>>>>          if (peer->interrupt.wptr == int_wptr && peer->shootdown.wptr
>>>> == tlb_wptr) {
>>>>            dev_dbg(adev->dev, "accel_id %u wptr 0x%llx 0x%llx is same
>>>> as remote %u\n",
>>>> -            ualink_accel_id(adev), int_wptr, tlb_wptr,
>>>> remote_accel_id);
>>>> +            ualink_exp_accel_id(adev), int_wptr, tlb_wptr,
>>>> remote_accel_id);
>>>>            return 0;
>>>>        }
>>>>          dev_dbg(adev->dev,
>>>>            "accel_id %u wptr 0x%llx 0x%llx sync to remote %u wptr
>>>> 0x%llx 0x%llx\n",
>>>> -        ualink_accel_id(adev), peer->interrupt.wptr,
>>>> peer->shootdown.wptr,
>>>> +        ualink_exp_accel_id(adev), peer->interrupt.wptr,
>>>> peer->shootdown.wptr,
>>>>            remote_accel_id, int_wptr, tlb_wptr);
>>>>          amdgpu_ualink_get_wb_addr(adev, remote_accel_id, &int_wb, 
>>>> NULL,
>>>> @@ -6164,7 +6225,7 @@ static int
>>>> amdgpu_ualink_peer_remote_init(struct amdgpu_device *adev)
>>>>        struct amdgpu_ualink_peer *peer;
>>>>        struct amdgpu_ualink_ring *interrupt;
>>>>        struct amdgpu_ualink_ring *shootdown;
>>>> -    u32 src_accel_id = ualink_accel_id(adev);
>>>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>>> This is changed to ualink_imp_accel_id in patch 5. I think we should
>>> use the correct function here, where it's introduced.
>>>
>> Good catch. I made the change here and removed the change from patch 5.
>>>>        u32 dst_accel_id;
>>>>        u64 npa, flags;
>>>>        int r = 0;
>>>> @@ -6287,7 +6348,7 @@ static void
>>>> amdgpu_ualink_peer_remote_fini(struct amdgpu_device *adev)
>>>>    {
>>>>        u32 rb_pages = AMDGPU_UALINK_RB_SIZE >> AMDGPU_GPU_PAGE_SHIFT;
>>>>        struct amdgpu_ualink_remote *remote = to_remote(adev);
>>>> -    u32 src_accel_id = ualink_accel_id(adev);
>>>> +    u32 src_accel_id = ualink_exp_accel_id(adev);
>>> This is changed to ualink_imp_accel_id in patch 5. I think we should
>>> use the correct function here, where it's introduced.
>> Good catch. I made the change here and removed the change from patch 5.
>>
>> Regards,
>>
>> Mukul
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>        u32 dst_accel_id;
>>>>        struct amdgpu_ualink_peer *peer;
>>>>        struct amdgpu_ualink_ring *ring;
>>>> @@ -6374,7 +6435,7 @@ int amdgpu_ualink_sw_init(struct amdgpu_device
>>>> *adev)
>>>>     */
>>>>    void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
>>>>    {
>>>> -    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>>>> ualink_accel_id(adev),
>>>> +    dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n",
>>>> ualink_exp_accel_id(adev),
>>>>            ualink_addr_mode(adev));
>>>>          adev->ualink.msg_ctl->send_halt(adev);
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> index 85c9a9634a4b..0b1e8dd38666 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
>>>> @@ -97,6 +97,17 @@ enum AMDGPU_UALINK_PROTOCOL_MESSAGES {
>>>>    #define AMDGPU_UALINK_LIGHTWEIGHT_TLB_SHOOTDOWN        0x1
>>>>    #define AMDGPU_UALINK_HEAVYWEIGHT_TLB_SHOOTDOWN        0x2
>>>>    +/* UALink loopback support.
>>>> + *
>>>> + * In loopback mode a single GPU loops UALink requests back to
>>>> itself for
>>>> + * manufacturing testing. The GPU exposes two fixed accelerator IDs:
>>>> it acts
>>>> + * as the exporter on one and the importer on the other. Loopback is
>>>> enabled
>>>> + * with the amdgpu.ualink_loopback module parameter.
>>>> + */
>>>> +/* Fixed accelerator IDs used by a loopback GPU. */
>>>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>>>> +#define AMDGPU_UALINK_LOOPBACK_IMPORTER_ACCID        0
>>>> +
>>>>    enum amdgpu_ualink_conn_state {
>>>>        AMDGPU_UALINK_CONN_NOT_READY            = 0,
>>>>        AMDGPU_UALINK_CONN_IN_PROGRESS            = 1,
>>>> @@ -319,6 +330,21 @@ struct amdgpu_ualink_msg_ctl {
>>>>        int (*send_halt)(struct amdgpu_device *adev);
>>>>    };
>>>>    +/* UALink loopback mode state.
>>>> + *
>>>> + * When @enabled is true this single GPU acts as both exporter
>>>> + * (@exporter_accel_id) and importer (@importer_accel_id). There is
>>>> no second
>>>> + * physical GPU, so exporter->importer messages cannot be delivered
>>>> by the
>>>> + * (single) MP nHT and are instead emulated in SW by feeding them
>>>> back into
>>>> + * our own IRQ handler via @wq.
>>>> + */
>>>> +struct amdgpu_ualink_loopback {
>>>> +    bool enabled;
>>>> +    u32 exporter_accel_id;
>>>> +    u32 importer_accel_id;
>>>> +    struct workqueue_struct *wq;
>>>> +};
>>>> +
>>>>    struct amdgpu_ualink_mgr {
>>>>        u64 npa_size;
>>>>        u32 psp_if_ver;
>>>> @@ -333,6 +359,9 @@ struct amdgpu_ualink_mgr {
>>>>        /* For remote interrupt and shootdown */
>>>>        struct amdgpu_ualink_remote *remote;
>>>>    +    /* UALink loopback mode state (see struct
>>>> amdgpu_ualink_loopback) */
>>>> +    struct amdgpu_ualink_loopback loopback;
>>>> +
>>>>        /* handle irq from ualink client of remote GPUs */
>>>>        struct amdgpu_irq_src irq;

