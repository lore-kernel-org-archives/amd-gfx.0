Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BBDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0247F61074
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0247F61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEBC6E8E1;
	Wed, 20 Oct 2021 09:19:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 157B26E8E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 09:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSjIhpbnX9afEG2NbIAh2/2uXVrsYdiQpnjfT0pf/u9JxwBMRqx1fzqUckP6ezC6jridFhkjbHSfJVjha9NJScEOAF9KKq30DIJR0hG5ljeskUBNkJEJv3b3SrOvIP2jjEy9+BHSO9ZaLkudfo1VT5bmUSfp2uKUV7O2+LnxalWnGdtkkuQNBgczJGzvbVvbzLZHAPd1bbuFRUsIl+o6nT19PKMM8IQuSYQP17tFnbHxTkVML9YO2Qel0DSGWG2WSim9P3YzYgv/7QCwZ5lU12u42F+DYPjRettrqS3AFxtcxAsUC8+pGrkCByBZejG/8y5je4WLGk4LnOCxObpNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4l/DjNBhQvae1JxfiR76Fnuq7x2KwmCM5C36Ryg+pWQ=;
 b=KeMd8TYFNI0uJO1otTZqfiA4m9G0ZmJPqwu/K43pE0REZb3RbRQEcKlXb5wbS6F9oA7B3IGJB9ds/qQ5ZTYDzcz/6hlhS0fybAotl1Swpc5NXV18YHw5Omzs+JBWLrA9LGP0VuibFJEV0bpCUZ2llLHXNM0HsK2zsjVJC+OjUC8q3NQxYuu5Xtv8R3A8zuy7ulFE5G0T5c1LVeaJasC6m4d640zw+HX95iSICMST5HqveQap9FDwebfI+cJriZ53L26RL/mXkvtOgAdTqPF+JsWho2xTzJ+7YpSZ48PrlS+fmrycJPqism55JqgZKdKYK0nazHqqxQ07S4ZwC23Z/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4l/DjNBhQvae1JxfiR76Fnuq7x2KwmCM5C36Ryg+pWQ=;
 b=YpKEQcaEtKpucLQzt+YHzT7Jw13DStNp68bydNoBVsl2uYc3JDaIpmWHZ7mhxSq9MhID95gFam2icIAwEpGjNNpVxKn53T5Afg+wr4K7AM69PhM5ELauCxj8XKQV6/1f44OmiSJL8pN/mv3cP04xPotzNSpiRUy6i9rjF2y4O44=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3836.namprd12.prod.outlook.com (2603:10b6:5:1c3::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 09:19:42 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 09:19:42 +0000
Message-ID: <9737857e-99a2-682d-35ea-f8e5737cff40@amd.com>
Date: Wed, 20 Oct 2021 14:49:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/3] drm/amdgpu: do not pass ttm_resource_manager to
 gtt_mgr
Content-Language: en-US
To: "Das, Nirmoy" <nirmoy.das@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <6c3e8c81-480f-ea2a-a98b-69866e6f3ff3@amd.com>
 <0cff2a61-0637-cf31-2a60-5326c6bd40f7@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <0cff2a61-0637-cf31-2a60-5326c6bd40f7@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::24) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 BMXPR01CA0084.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 09:19:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf8647f7-85b1-4bdb-367b-08d993aabfcc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3836:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38366352556AFD6535CEBDC497BE9@DM6PR12MB3836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 32XLXU8k8J0MICOCtbSScMt58Yvw5SnnI8/oCqRQOtYWtazu6l9QaR6H5y+jeu3MFgBsw7kIbYzpKPYd6peHVRpljN6yrMkptlTYJobxS6FKznkq5468QbUvhPmlcNB9JyPaLpuC0T9UrIX4tKdfYXUE6v8i0dmdF9uqlTCeGE1EzX9htOVPeIDLjetaqP432uJq9vpX8lsMpskuLI2H6LhBIeoXtgXVvSL5Jie2IJYX9FqNfXS3/erQIje9KEoUVFqfEFTjHo6PONTjOHtlxhSf4ngi3v9SeIavWonmYGdsvb2QqMM+wGbQwEoUBb1N1a2gahtZ8sB/Hhpdmeyeu8ajdUq+Fw+ADnKDQOUpdReoglnPsOJ04odkzY4nzdKVG6qmhZLyMrAkDI+4lN3Hdo876S4glSUcMT4el6PhGSJ3deo0gSrVrCznhyrzMKWrrzkHnSOGW1EriULJSWQo4dVgFfJGBRt9OP4+jTcKcDQxvQULN+vgiwePBRm7cmVl1gRyteVfZ65uuRMuwWM5VwYamubfcwPr6D4tSlSvgVyDdf51UjZdbc1RaKNWEplEJ6g3bnukiLrHx3onLieuc8NHPPgARzYLlaDcZ2YSD2AZjz1boWweaukikFueZ6RHAM4kmcbkv3t6Xq6Xh2CXWEsYTD1ZE8MAcRKyd+f3v9IJhfsWOLh1vN7ZXNwtepRai/QOvwukSwy/Y9/9J6orMHBlbYU8zNijNdiebQeCDv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38100700002)(26005)(186003)(5660300002)(2906002)(4326008)(16576012)(110136005)(316002)(53546011)(8676002)(6486002)(956004)(31696002)(66946007)(83380400001)(2616005)(6666004)(66476007)(66556008)(66574015)(31686004)(36756003)(8936002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yk9OOUV6RldmRDZ1TmhEK3NvV0p6SUZTWkJqSFZ3MUY5Ri96WFNEM1BiS0lo?=
 =?utf-8?B?L2h0SU54UWFjU1BuVDNrZ2hEcEV4cDlnWHAyT3hycGdjL3FYUGJIYkRnSHpL?=
 =?utf-8?B?T3I2S3BGcjNBTFZYa0I2ZHJOK2NYWHNVRktPeExiU09MdFpFTXZaU2RneTFL?=
 =?utf-8?B?RVhFRlZzMWp6OTZQdVdtWFZ3a1pqajFNTWxSNmo3Y1JVUXhRTGo3TWl1MzE1?=
 =?utf-8?B?MWxocDJWdmFpN2hkdWFONnU5eDVabFFmWXppT0N0aGlNcTZLblFiT2VCTFRC?=
 =?utf-8?B?ekw4UUZCQU9hdWxuR2hXRWVnYnM2c3JsUTZxMzNqZmxrY1RGNHRnb1BlQzU5?=
 =?utf-8?B?V2FnenphMFEyanNQR3NzTXBUWG9ya0lOL0FNMEcvTFl3L1BIaWhodjE3bThy?=
 =?utf-8?B?U2sxbW1xaHdDWXJ1MVV1RjZldkZUaFdob0VzUC9IMlhpRDcxUWMzVDBMTCtV?=
 =?utf-8?B?R2VPSmNsTjNVZi82U2FtNjU0QXpFdHRVcHRtakpBU0pnWnBkTXk0UFI2bEtJ?=
 =?utf-8?B?M0N3QWdUcnFmY3dlT3IyUlFBdktKMHgwVFRGck9rY2lreURzWXFnVDhOUFc4?=
 =?utf-8?B?SCtRM29tVXJueE1PWTFYWkpMVE5oQ1ZwazAxRXRrbVdUVW5hZWJhcU1KYVln?=
 =?utf-8?B?UktDZUp1S1BaL1FQSXVvYUJSdkx4S3NmTkd6cEF5NnZSOFFQNWtmTzBDbTNH?=
 =?utf-8?B?RzRDMnd0VjUzWE5oN2ExbjdpZG9yM21QOFo3dk5uTk9KTzZ3L3E0WGFnZlVI?=
 =?utf-8?B?NFlnZXVES2lRUGNCT2IwektWL2RRdG5NWVBOc3FJYmZqQW5HcXRrOVlibXUv?=
 =?utf-8?B?TzNsc0lncGk0bVdBV2RQdjh6YStsMTU4N3FZZSs2VFlHRW9VMjVFR2puY2Rh?=
 =?utf-8?B?TUttY3c2dEJ0UHpKczk5YTdqV0I1N1UyTjZvZ2ZBems0QnhOMEpZTWNUbVk0?=
 =?utf-8?B?NVpkeVNrcDEyb1ZZc1BySTFRdnBKbTZnY3Zpa0JvNmhtT2RuS0JHOE42ejNB?=
 =?utf-8?B?VnBqS1J4VHFLa1lIdENqTTlMNVhMYlNpMFNXbVhkR2t4dmZNS09zY0VLZ3B5?=
 =?utf-8?B?bHErNzNBb2p3NmJZVFBHNTUyR0t5RVR5aE5nRDA4dnFWT3Z3Y0YxSEhWNTA2?=
 =?utf-8?B?U0p2ZGRhUG53RzBuSTdudVR6dGpweWJJanczRjVNR3dJUGZhU1Z3UHBuNXNB?=
 =?utf-8?B?VmVqNTJSTmdhZjJna2ZyL2hZVVkzMDlmMG9XRHJxdlN1UkZTdFUvS1pBTWlk?=
 =?utf-8?B?Rk5NTEkzOGdSVnorVWlFTmQ2a2VZTWRTT1BQWW5KSGk1VVVUWklxM3FSWUJp?=
 =?utf-8?B?SGtpemF4ZHIvVFJsQkxVcllKWUZEUVozemJCMTdvZUlKcWhNb2NVZzVZZWRO?=
 =?utf-8?B?M0tIdmtGOTQ2dWlXWVNsN0dnbUxGK1g0YkdwNG5WcC94Nlp1YlhKVitDR1hX?=
 =?utf-8?B?TTdkNWkrc0NBVUpUWG1odEFSY3lwcURPYnBQbUhHcUtaVTl4c2p0N0l4RXhi?=
 =?utf-8?B?YmlJbkVtZGRjWEh3VW45ZjBsb2VQY2VuZ1hKbWdpMWZBMUFHSnFwa1h3d2t1?=
 =?utf-8?B?MXZvM3hkWHZFYlBlRW9CUmJGbUxPQlF6Qk95RHVsS2tEMEVSYWk4SVVmSm1J?=
 =?utf-8?B?Q01FR1A3QytjSk5uM2ZCRXNCWkVXN2tFTXdYVzZZeXRZc3hvMWYwcDM4T0hX?=
 =?utf-8?B?TVBiNnp2SllpL2pYMWZNZmpHTGtlR0p0cEN6SGhwcmo1dHJGQnNUY3pjT3Uy?=
 =?utf-8?Q?dDeNGSVyMYirJlqdmbPIDLuIZwkvw6JR+Kv3dIJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8647f7-85b1-4bdb-367b-08d993aabfcc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 09:19:42.5358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3836
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



On 10/20/2021 2:18 PM, Das, Nirmoy wrote:
> 
> On 10/20/2021 8:49 AM, Christian König wrote:
>> Am 19.10.21 um 20:14 schrieb Nirmoy Das:
>>> Do not allow exported amdgpu_gtt_mgr_*() to accept
>>> any ttm_resource_manager pointer. Also there is no need
>>> to force other module to call a ttm function just to
>>> eventually call gtt_mgr functions.
>>
>> That's a rather bad idea I think.
>>
>> The GTT and VRAM manager work on their respective objects and not on 
>> the adev directly.
> 
> 
> What is bothering me is : it is obvious that  the amdgpu_gtt_mgr_usage() 
> for example should only calculate
> 
> usages for TTM_PL_TT type resource manager, why to pass that explicitly. 
> I am trying to leverage the fact that
> 
> we only have one gtt/vram manager for a adev and the functions that I 
> changed  work on whole gtt/vram manager
> 
> as a unit.
> 

Don't know about the functional aspects. From a sofware perspective, 
amdgpu_gtt_mgr_*() operating on struct amdgpu_gtt_mgr *mgr seems more 
logical.

Thanks,
Lijo

> 
> Regards,
> 
> Nirmoy
> 
> 
>>
>> Christian.
>>
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 31 ++++++++++++---------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  4 +--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  4 +--
>>>   4 files changed, 24 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 41ce86244144..5807df52031c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4287,7 +4287,7 @@ static int amdgpu_device_reset_sriov(struct 
>>> amdgpu_device *adev,
>>>         amdgpu_virt_init_data_exchange(adev);
>>>       /* we need recover gart prior to run SMC/CP/SDMA resume */
>>> - amdgpu_gtt_mgr_recover(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>>> +    amdgpu_gtt_mgr_recover(adev);
>>>         r = amdgpu_device_fw_loading(adev);
>>>       if (r)
>>> @@ -4604,7 +4604,7 @@ int amdgpu_do_asic_reset(struct list_head 
>>> *device_list_handle,
>>>                       amdgpu_inc_vram_lost(tmp_adev);
>>>                   }
>>>   -                r = 
>>> amdgpu_gtt_mgr_recover(ttm_manager_type(&tmp_adev->mman.bdev, 
>>> TTM_PL_TT));
>>> +                r = amdgpu_gtt_mgr_recover(tmp_adev);
>>>                   if (r)
>>>                       goto out;
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> index c18f16b3be9c..5e41f8ef743a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
>>> @@ -77,10 +77,8 @@ static ssize_t 
>>> amdgpu_mem_info_gtt_used_show(struct device *dev,
>>>   {
>>>       struct drm_device *ddev = dev_get_drvdata(dev);
>>>       struct amdgpu_device *adev = drm_to_adev(ddev);
>>> -    struct ttm_resource_manager *man;
>>>   -    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> -    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(man));
>>> +    return sysfs_emit(buf, "%llu\n", amdgpu_gtt_mgr_usage(adev));
>>>   }
>>>     static DEVICE_ATTR(mem_info_gtt_total, S_IRUGO,
>>> @@ -206,14 +204,19 @@ static void amdgpu_gtt_mgr_del(struct 
>>> ttm_resource_manager *man,
>>>   /**
>>>    * amdgpu_gtt_mgr_usage - return usage of GTT domain
>>>    *
>>> - * @man: TTM memory type manager
>>> + * @adev: amdgpu_device pointer
>>>    *
>>>    * Return how many bytes are used in the GTT domain
>>>    */
>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev)
>>>   {
>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>> -    s64 result = man->size - atomic64_read(&mgr->available);
>>> +    struct ttm_resource_manager *man;
>>> +    struct amdgpu_gtt_mgr *mgr;
>>> +    s64 result;
>>> +
>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +    mgr = to_gtt_mgr(man);
>>> +    result = man->size - atomic64_read(&mgr->available);
>>>         return (result > 0 ? result : 0) * PAGE_SIZE;
>>>   }
>>> @@ -221,19 +224,20 @@ uint64_t amdgpu_gtt_mgr_usage(struct 
>>> ttm_resource_manager *man)
>>>   /**
>>>    * amdgpu_gtt_mgr_recover - re-init gart
>>>    *
>>> - * @man: TTM memory type manager
>>> + * @adev: amdgpu_device pointer
>>>    *
>>>    * Re-init the gart for each known BO in the GTT.
>>>    */
>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev)
>>>   {
>>> -    struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>> -    struct amdgpu_device *adev;
>>> +    struct ttm_resource_manager *man;
>>> +    struct amdgpu_gtt_mgr *mgr;
>>>       struct amdgpu_gtt_node *node;
>>>       struct drm_mm_node *mm_node;
>>>       int r = 0;
>>>   -    adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>>> +    man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
>>> +    mgr = to_gtt_mgr(man);
>>>       spin_lock(&mgr->lock);
>>>       drm_mm_for_each_node(mm_node, &mgr->mm) {
>>>           node = container_of(mm_node, typeof(*node), base.mm_nodes[0]);
>>> @@ -260,6 +264,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>> ttm_resource_manager *man,
>>>                    struct drm_printer *printer)
>>>   {
>>>       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
>>> +    struct amdgpu_device *adev = container_of(mgr, typeof(*adev), 
>>> mman.gtt_mgr);
>>>         spin_lock(&mgr->lock);
>>>       drm_mm_print(&mgr->mm, printer);
>>> @@ -267,7 +272,7 @@ static void amdgpu_gtt_mgr_debug(struct 
>>> ttm_resource_manager *man,
>>>         drm_printf(printer, "man size:%llu pages, gtt available:%lld 
>>> pages, usage:%lluMB\n",
>>>              man->size, (u64)atomic64_read(&mgr->available),
>>> -           amdgpu_gtt_mgr_usage(man) >> 20);
>>> +           amdgpu_gtt_mgr_usage(adev) >> 20);
>>>   }
>>>     static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func 
>>> = {
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index d2955ea4a62b..b9b38f70e416 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -678,7 +678,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>> void *data, struct drm_file *filp)
>>>           ui64 = 
>>> amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, 
>>> TTM_PL_VRAM));
>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>>       case AMDGPU_INFO_GTT_USAGE:
>>> -        ui64 = 
>>> amdgpu_gtt_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_TT));
>>> +        ui64 = amdgpu_gtt_mgr_usage(adev);
>>>           return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>>>       case AMDGPU_INFO_GDS_CONFIG: {
>>>           struct drm_amdgpu_info_gds gds_info;
>>> @@ -738,7 +738,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, 
>>> void *data, struct drm_file *filp)
>>>           mem.gtt.usable_heap_size = mem.gtt.total_heap_size -
>>>               atomic64_read(&adev->gart_pin_size);
>>>           mem.gtt.heap_usage =
>>> -            amdgpu_gtt_mgr_usage(gtt_man);
>>> +            amdgpu_gtt_mgr_usage(adev);
>>>           mem.gtt.max_allocation = mem.gtt.usable_heap_size * 3 / 4;
>>>             return copy_to_user(out, &mem,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> index 91a087f9dc7c..6e337cacef51 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>> @@ -114,8 +114,8 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>> *adev);
>>>   void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>>>     bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>>> -uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man);
>>> -int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>>> +uint64_t amdgpu_gtt_mgr_usage(struct amdgpu_device *adev);
>>> +int amdgpu_gtt_mgr_recover(struct amdgpu_device *adev);
>>>     uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>>
