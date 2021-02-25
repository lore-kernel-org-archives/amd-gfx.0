Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5685C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 08:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4392464EF1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 08:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4392464EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDECB6EC5C;
	Thu, 25 Feb 2021 08:07:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ADC56EC5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 08:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYm1ShfE/K12y+6vd/7/4FQCxP2xAh6wFoAp5b/tmiv05VBR+3JP5WCfwlnRC2YBG6uFqbWbfdUkiMIOm8zBnCqv1EjQLZlCaNj1wu7pgN250/h0LwFMXrbU5vCGlmDJhVDTngxy+pn4uFUZd7yRnvYm+LNgtZMQ7ZbeV9V79fTmZWSfS0GbDsJVNREC06RusW0AvHCOTb2CDoqK1hfp+woaMv3Dcvq13N93siOnaV32IY+0YqEF4+WkyrqC0cnfArL7b5TMzFD010JgaQ2o2aNfgndr2df+Pug0doxndBbB6HRGy5He7iPtMKTl3GUpKdhLtY5iLKnKBdJVgnw/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw/C2NUFT3iNMX9UknPoD+XNOlVCDYGMQs0eWamU4AU=;
 b=P2SmMTvrLxrEwhvlA9jjFGe0d6hn3uzFtikk5o1Q/mZ1rAw0WLkWOjrHrJV0SnfOYwfZiWA/kh64DO3sMd+qzoIsdS+1nu8KRH98UWTteta438pllC7qwMDfaN4tTRwIB8uV3eJfca7CJAf/oXngl3NY6p1MdmX0dKDG7+0f4LA0dUBrRlNGHkWc9PkV+U/PudUxvCoutNftnNyG3TtsW3RjyPxH3+MkpzCy4NL6AwRglEa/r3Oz3j5me07l+L92oIh6bPDr1TOYGYEKUKwUNxVxYA+mycALr6M3e8cEpBNp1ZSI09hjpErCvRroam8JUpmRsB1p2491675bATbLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fw/C2NUFT3iNMX9UknPoD+XNOlVCDYGMQs0eWamU4AU=;
 b=KVr7MBlTkWKMGvUrlxsrYnibdNFMiWjQ7UXyDv09FydLjPK390Ffj2kK/afXF8dRfYRF3r5PdjDHDx8CGFw4rd6BGiKbyxX6bqVwr5TrO6VnTf9b7hkK8lLe4CQawyMLGmLzm4p5UOrIs+OQN7JH/lnbxRfndMx9lTrGP87H/UU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4945.namprd12.prod.outlook.com (2603:10b6:208:1c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 25 Feb
 2021 08:07:49 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 08:07:49 +0000
Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
To: "Chen, JingWen" <JingWen.Chen2@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
 <20210225052724.36412-2-Jingwen.Chen2@amd.com>
 <f8ce84fd-ff98-026a-c424-28338fe9e225@amd.com>
 <BN6PR12MB1267D1DBD20FBE72527B03BEB79E9@BN6PR12MB1267.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <57564da2-19ea-75f1-6f2d-9b014b89ef12@amd.com>
Date: Thu, 25 Feb 2021 09:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <BN6PR12MB1267D1DBD20FBE72527B03BEB79E9@BN6PR12MB1267.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:fc8:43:f4c0:95af]
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:fc8:43:f4c0:95af]
 (2a02:908:1252:fb60:fc8:43:f4c0:95af) by
 AM9P192CA0003.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 08:07:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a51bd953-649d-455b-68b7-08d8d964713e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4945:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4945E97CA9D2529CD7F64507839E9@BL0PR12MB4945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25qcjzrTi1BQBBoIYL11YENvkNMtf4gnlldkOWcmD55BP3WJqPRheACCImfnFwrFTfHgIffGRVW7uTPi7RhFiNgHZBDTjG5camWMyr34V0fOW8sTANP5HRy/+2hmks0bUBx2Ch3P4qZ4D6nIcs4kmjr21CS5QMwaERhzYOIp2Oow59lUCoKDJYjQB+tt1pcb/MqjWWk6HElhu4g+23ZG5vk0abVKR7yJmPwAA2+D8s57DcHHMxEnqV4jPfKaq+2xLW3SVe984uSsnHeegFGVF1E1w5ZFne0MrM3pYctXmJrUTHDyUAvxwYo6w+2gohEREttvNFVacZYf9ut6fWL9jPF+SJsjz36DDaR1SbjB0SwxtoS/eVAo1Ec1k3dzOLM6b56OMP8qCG7PVFt6bdfSoxezh5/b0kNIoNmOJwAhQEAF3cT6xkjn9H4fpqlRfXh35DHjszgwXMDzptM6xKIuA2QZphIjUTX1SoQR0COApOjptLeL4vLIMTsFZRuSRH9s256+EQWrkmzu9HX98VKRARDPNaKhNMDaIMkW1XVzd+WDA1RL2nehd/J0yxnCacjRbzj9x63nnd9ZvJ2KBrqSC/PEbvnaxTfn8Bwaclyhzkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(6666004)(110136005)(6486002)(316002)(31686004)(4326008)(66946007)(8676002)(53546011)(52116002)(83380400001)(36756003)(16526019)(66556008)(478600001)(8936002)(31696002)(5660300002)(86362001)(2906002)(186003)(66476007)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Qmh3NXE5ais1ekNMOHZxK21xdktVdStPYTBCV05wWkdJNTU4MnJPb3hFSW9E?=
 =?utf-8?B?M3ZGeDlwRmsrZGlCVmZjRmZSSEVGVlpmL2ZNdGFZQkxIRW03eG5SalFRNGVh?=
 =?utf-8?B?cXFHTkRHb3dkeHY2dkFxNVFkckJpV3hhQVQ5R3R6eGl4djBHREJPNi84WHJt?=
 =?utf-8?B?OCt5QXYrd1d5SGRrUW5ybm5QVzI4azFxcis1Q0JWM1RSTVQvOXZ6RzBQc1Ft?=
 =?utf-8?B?OHpLUWVmM2QraW9wYm1QMHplN3o4OGZtYm1hMmRjelh3cm9jR2lnTjc1TVVE?=
 =?utf-8?B?UklvYnJEb2hjc1ZYSWRBcSt1RTAxc1dHYnpLOEljbXJQQzQ5MnUwM1Fseml0?=
 =?utf-8?B?ZnlleEU2bjh4TDZKRTBSRExJNkREbWFleFFyMUJtNTFWUWZXYVV6Y0JMM3p6?=
 =?utf-8?B?K3ExbGhDMncxMERtOHpSSW9hUk9wOGJONWlIUm5BbENMem9jdys4S3YyZUE0?=
 =?utf-8?B?dkg4ZDhrakNtUGcwZUtGNTNJWG1GekRqVlVmbmo5VGxiUGlUZjYyOXZBRm9K?=
 =?utf-8?B?RE5YOCtENjdYMWQwc2tJRUdxWUx1c09QMmVnM05rbGg3aVh0UVpaSEZ0QlU3?=
 =?utf-8?B?OUR1THB5TDd6b1crZ21Ea0pQUitZM1JEQzhlVDQzSCtjWW9MbFhGRTdFb2FD?=
 =?utf-8?B?eDZqWWJBbFUwRHJUd1NxeVEwZlhrckZhbG1YZ0VCN2dOTGlVMGZkWEw5UWhy?=
 =?utf-8?B?Ty9reGo3eEpudU85dTJtWU9DcjhPRjFJRFlndm14bytLakNyUGRtb21yVDRa?=
 =?utf-8?B?UzdVTi9xM0Q4VVZicVYySWRVeWtuaW05bEQ1VklyZ0NFdlFmMGxlc05aVDBo?=
 =?utf-8?B?V3VpM3dIelZPYzhXTXI1U3BaT0dCVFJYUzV0NUlhL3NaVkcrZkxTSzJjeENm?=
 =?utf-8?B?QTB3cnFVa2NkUVFPbjVPV1hMdjV1VzFYc1l1YUMvajZGUkVVQkVqVDlscFRh?=
 =?utf-8?B?OFUvTDB1SVJHdjRtb2syYmpLc05zdEVwVXgyMDNGenJCL2xubXp0WGJja2lm?=
 =?utf-8?B?a2pLc0pTdkJHL0xJUEw0dUdFM3dkUHFLV2F2RnlITCtDTkdTQ0w5RFVPMi82?=
 =?utf-8?B?OFkrYjN1cFdZSm51cVV1QjA2Q0lkaDY4Njk4akpQZzNnbVk0aWx4MU9zYVRP?=
 =?utf-8?B?dHRDcWtScU4vd2lSTXgvVmdCQm5hQWFOUXoxTnE4eDdSQ0RObGJ1RnZxNWxh?=
 =?utf-8?B?WFNxSEZsM0dFL2ZaSzVqNjM4ZERqQVBPbVhZc1g0NmVHUWtIajF1UGZZU090?=
 =?utf-8?B?NlU0aUhiVUw0c0RGOUdSQjJpY1gwNFNkQlljZDJSK0QrL3dTbFZrWUloWEdi?=
 =?utf-8?B?eGg5a25uVnY3dUQwRDF4c1R2djRQazl4NmYvZjNGMXlDejlUaE4vRjR4WEZI?=
 =?utf-8?B?dWhQeGI0S0Z0ckpjRTdKZnlhK3dJZHpmdDBPYS9jSFZjMks4M0V0cm1YUkdR?=
 =?utf-8?B?Y3dLRFV5YjFlNEkyZm9wRFFna3pkZ1dHNGVxNnV5bGpCUFJuSGRqTEtjRHox?=
 =?utf-8?B?K3g0bEtpMk5TdFVkNFpDS2hmTHJzZm1RaVF0ZWhaS2tGL0ZBbFVaZzZsd3ov?=
 =?utf-8?B?OXlORHBBRURzU0ZwMUgwRGRXRFVvTXZsQy9DMUVEZnE4aGJ1cTFpQkRLdTdW?=
 =?utf-8?B?WWJLcEFKK2M0MUwzOGczV0NGL0U4eCtJWngydUV5NDlQc2JJek9DY1Y1WG5R?=
 =?utf-8?B?QkdYcVBraTVkVktWMi9XSmNid3FqT0RHMEVodURUY1UwNnZHY2dOWkh4YUlr?=
 =?utf-8?B?WXpEeHY2RWZEMEhDNnNiVENJSlhjTDgrb3RuZDYyTGxmOE1VNXVCUTArdXd1?=
 =?utf-8?B?b1ZDSW5yN1NHK1gyU1k4YkdnTHgyYTV3dGZwME1wdkdqdlNGaU5mMThPM2dB?=
 =?utf-8?Q?lu76YQWWIeSEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51bd953-649d-455b-68b7-08d8d964713e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 08:07:49.4586 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJx61eoy9+AeF417qPenGqK6q+iv4iGrmnZKPUDrFUnalRtcIqa3m5jxgIX03UUU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4945
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good catch, but the approach for the fix is incorrect.

The device reset count can only be incremented after taking the reset 
lock and stopping the scheduler, otherwise a whole bunch of different 
race conditions can happen.

Christian.

Am 25.02.21 um 08:56 schrieb Chen, JingWen:
> [AMD Official Use Only - Internal Distribution Only]
>
> Consider this sequence:
> 1. GPU reset begin
> 2. device reset count + 1
> 3. job id 1 scheduled with vm_need_flush=false
> 4. When handling this job in vm_flush, amdgpu_vmid_had_gpu_reset will return true, thus this job will be flush and the vmid_reset_count will be set equals to device_reset_count
> 5. stop drm scheduler
> 6. GPU do real reset
> 7. resubmit job id 1 with vm_need_flush=false
> 8. Job id 1 is the first job to resubmit after reset. This time amdgpu_vmid_had_gpu_reset returns false and the vm_need_flush==false
>
> Then no one will flush pd_addr and vmid for jobs after resubmit. In this sequence amdgpu_vmid_had_gpu_reset doesn't work.
>
>
> Best Regards,
> JingWen Chen
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, February 25, 2021 3:46 PM
> To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Liu, Monk <Monk.Liu@amd.com>
> Subject: Re: [PATCH 2/2] drm/amd/amdgpu: force flush resubmit job
>
>
>
> Am 25.02.21 um 06:27 schrieb Jingwen Chen:
>> [Why]
>> when a job is scheduled during TDR(after device reset count increase
>> and before drm_sched_stop), this job won't do vm_flush when resubmit
>> itself after GPU reset done. This can lead to a page fault.
>>
>> [How]
>> Always do vm_flush for resubmit job.
> NAK, what do you think amdgpu_vmid_had_gpu_reset already does?
>
> Christian.
>
>> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index fdbe7d4e8b8b..4af2c5d15950 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -1088,7 +1088,8 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>    if (update_spm_vmid_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>    adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmid);
>>
>> -if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>> +if (amdgpu_vmid_had_gpu_reset(adev, id)||
>> +(job->base.flags & DRM_FLAG_RESUBMIT_JOB)) {
>>    gds_switch_needed = true;
>>    vm_flush_needed = true;
>>    pasid_mapping_needed = true;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
