Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0395DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D17A10E130;
	Wed, 11 May 2022 12:03:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE6C410E130
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foPQXUjQG3ishp8BL2laV3obPGm9ttXNTCMxdlENFT4hm2AjbIBTFZ7zJZUKQyhy8I4u3XrkDOqNjeabHpxb825YjuvuuVQ0bjYCEh2JKsnqnPKTpmxsVpJzHZ8kwnLl5Moaz126ZmdGVgvw1EVD8agmJYfq03z4+j98JfnRftH4fiJElQIC2k+fjELss51+wcrGPYeY0z9/feAB+4VcSC6USkCJFWlQwTVaB+ufQembzGRh9ZOfo915wdsbokABhyXpEw83Kfnv2/XIO35XTtL+1rgivk9/gkc06C9RK8w67ZK1KEd1O333TaQZf+2ZrBfnNvhediiMcOY2MUocOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH/ziabvz3ZSHIjmdtsbOkZoXLg0R5s/SR0ntx/ivRQ=;
 b=iWNcKkWpB4U6Zwe77nM45nlE3VLr0GKH06OBlxXMFwrrMJo1hFr2iXFShRoiEsvsMiMb9+eA7ac026JP5+I6slTMSYZdFGF3pUsq8NA6rymMP5o2+WTwhk+9PkasABOLd8YNXwXC7bnKiVjvek7ef9/1kku/qoaoPC8yd+21pLJv0EZ2HN/7ulpvU13EeATvr0ER8nYJZwhu1520VnDZQv67uqIRRvL8XGc9hzuI6GF5EEqNniskvFnyjC+uqUn6Z+krfwkdvC0cJ4NLYLyBo3udVFfGyoEQrNkWPBRke5CbwE2rAS8tnAZDsH/kS6eX64FAbHncFVqWuiKM2fNJJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH/ziabvz3ZSHIjmdtsbOkZoXLg0R5s/SR0ntx/ivRQ=;
 b=2feA9zYyKMnEUJ9exeO6WpRhG8a6Yt2oSQy2Og+bgoxMiU5Nt+fLIUeltOnK7BJERCWUAOHPov/ouKCaKsALnz6F2b9xt37IBCtRYL5yxEYglNfNeuAoLh2lVFAQyBKDeYFW5FYjaA+5uGEcNWR/WE6prFFOVWHgYqGakLdhZ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1943.namprd12.prod.outlook.com (2603:10b6:903:11b::7)
 by DM6PR12MB4028.namprd12.prod.outlook.com (2603:10b6:5:1ce::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Wed, 11 May
 2022 12:03:50 +0000
Received: from CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::bc8d:b8b1:ae83:788a]) by CY4PR12MB1943.namprd12.prod.outlook.com
 ([fe80::bc8d:b8b1:ae83:788a%9]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:03:49 +0000
Message-ID: <78bbb31c-ad1b-a0a2-5890-5dd9b332b58f@amd.com>
Date: Wed, 11 May 2022 17:33:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amd/pm: update smartshift powerboost calc for smu13
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220511114628.2542190-1-sathishkumar.sundararaju@amd.com>
 <ad73bd91-ff2a-e1ff-a4e3-4c4b4a634448@amd.com>
From: "Sundararaju, Sathishkumar" <sathishkumar.sundararaju@amd.com>
In-Reply-To: <ad73bd91-ff2a-e1ff-a4e3-4c4b4a634448@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::17) To CY4PR12MB1943.namprd12.prod.outlook.com
 (2603:10b6:903:11b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a9f1a1-f01f-40da-b615-08da33464f11
X-MS-TrafficTypeDiagnostic: DM6PR12MB4028:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4028EC232BD68CEE1E6094259DC89@DM6PR12MB4028.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Jps9DnfE4su6pqKXGXhbRVjcTj69nr7KVvATHw3Dol4K0Q630lnuj8J+prhmCKEQpIYWNPAQ7q9DbGFkvLJJmG9i3D34ww/wf+0VPJHRvT869ixqmR23Jw+ZKbGGtsb2HT1KJr8jk6MdZwRYlibhwB3GVlEjp3yNdlQxPqWF9Yd1pTC6J999+hGaUBS39Va2GZCCB2buJsp9eQbsmHUE9d0DMTunM3Eb96Hd+ZX1lh0Bi93iicdLCai8H5WdIoXDnIdN4fma8iHj+VTrMzdjnN9xZySp60YE55xrIBhGQeAh/NJcM4GDFMgY7+HV66foQ3fX0xupmMqRzQkP1zUSXesdpqmQzyL9st0hrBW/GAhQvwP66Y6ULzWP5dPbMZCrWxVYrnQCcXyAaH2WbktYc7WEVKtBv8ljPn0vceJ/I+10ahxZB04r9EKKNqaifDsiU9PPt+OGaA96wXmLBMH5U0JnzIaewBoRz/HTMwfIDXzMxG6bPVt/C0WMT1TaDhdzZFYoFwaKfr/tIQ1qvdQwBxpuds3qInlwoD5wdvt+R6URktB6nL/IE+qTNzUZBClqFIuTBe84R7N2O20n/srEIfndvNVAdsv/GKjK+Ciqiqyk1RV/NXKpeBMeJYcAxynUI2SzgGmfzTpHHb9/QPSwnkSJoPQAAJYQLMWxNQvFVUA2n/icRLyalX9iOFYg6aGwnOyutJzJ8VU+Rib0FbCDogJvQvnrgdSDATntgyijND62ZC1NqCBMQshZkXvaIT9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1943.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(66476007)(2616005)(66556008)(8676002)(4326008)(508600001)(186003)(83380400001)(6486002)(86362001)(6512007)(6666004)(26005)(316002)(53546011)(6506007)(31696002)(31686004)(8936002)(36756003)(2906002)(5660300002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW9iYktncGhYZm96KzEyRXNxbDZkM2xSTmtxbHMzZXRvYU9rWXp1TGxXai9p?=
 =?utf-8?B?Z2RmVU1zdWp2SE8xYnR0NWN4RVVzYXpMYklmdi9pU0xqVS8wTlBZRWVEbDdz?=
 =?utf-8?B?MHBlM1JBNll1UkFvQm5vN093QzJ0eGRVRGFQY3FPblFNL1R1azdZZVB4SW9T?=
 =?utf-8?B?YXRDc0VJZ2drWU5uQXgzZ3RzQUFOUDhHN3FzY2pjRkRHeG0vREZPd3dndnox?=
 =?utf-8?B?Slp6RnVuYzFRZnV2bEM3d0FXYllhKzhRcUVab2RGZTlmcjZvQmpnT3RNQ3R2?=
 =?utf-8?B?bm5RVFpRM1oxR05vakJZWmFxa1RSUUVFUmZOdjNjZjhXTGU5STZjUkU3MHAz?=
 =?utf-8?B?NXhFTUtmdlpOT0hHbnB2TW5kR09Vczc4UGc5VVRGVlhzZGdUZUJ1NWN5UGlt?=
 =?utf-8?B?OWd5dlUxektyUm1LRHZwVEltRjlaTjZ3SlhYOVcyN3NMc0NtYjAxZjdyM1Zi?=
 =?utf-8?B?NWxRbkFCSjdmaGdzVjdpN2JTSnN5UHVqcHNTTEZFUnhCK05tVDVNQktFWjgw?=
 =?utf-8?B?SjZwRWduQVhuK1pIeDlRc3BnTjhTWHVUM1o0NlZhT2txWU1tWDFqVHYyNTdn?=
 =?utf-8?B?MXo1TzlsOSszN0x3NnNZWlZHYTErSlpId1lHd1dpWXJ3KzJRYi9FYVhWeGNY?=
 =?utf-8?B?L3I3eElFclFodFVWUDdKNnNZYURjL1BFejd6T1FHcXhtTkJUZU5HTjVpcSt5?=
 =?utf-8?B?RmRVNjFLTGJEVmEwd1lkYVZPM3hkSDVmWjc5VzJNcWlsV3JOOHdoTnEyL0l4?=
 =?utf-8?B?K3dMYWNsZlZ0eDQwRXFpQ04vS3ZiTUgyZ3RaSDRFMk9nYXBNVFo4eHVQa0du?=
 =?utf-8?B?ZDVGdXJFR04yZmU4VkpNL2xVbDVGRm9QL3ZHb29rY3VsWWlWdjZ4ZkRlaith?=
 =?utf-8?B?eEJhYnU3TTJ5NlN5UTZES2U3RjRmOGtFSFpKWXlIclhnWVFxNVJ2Y1VWZFFR?=
 =?utf-8?B?cmx1WndwckMxeG9pQ0dnNjhtU095WU4yN2NmdnJHK1ZMUFJEeG91U0gvUUdR?=
 =?utf-8?B?eGl1MWE2OGMrVEhIYzRpU0djVFlDSC9jWUwwS3RxZWVVSDJiR0hwUEdPYUZI?=
 =?utf-8?B?V0dEb2F2WWFGV01LWWhGN2V1RXN1Z1I4aHc2U0w0VnR2WEtCakpKSE9sTm1M?=
 =?utf-8?B?NU5qY3JGeCs2Sks4azdyczJuemRrNytyVFlBdElNZFpYb1NDL29OVHM1UDZM?=
 =?utf-8?B?aGFuUmpMVFVLbmtVNytmaWwwbC9sVWM5ZkQ1VkdXdDRsYjBaa2c4OU5lTUpC?=
 =?utf-8?B?ZjB0SkF2MXcyUXBFOWNpUmtzU3o3LzNWeVlXREJ4NWJMalgrZVZMRnR2cHh5?=
 =?utf-8?B?eTV0cDZlNG82czJZK1k2emEwVE1paTcweVVKRXU3Tk9sSW9wSEc1NnFXdG5I?=
 =?utf-8?B?ZEFTamJHTzFQTkJRTmNmWmxyTU5sTFFPU2hyUkVpSWhQaHZ2OEFCRllGK3Fn?=
 =?utf-8?B?ZDFISFdIdmZRQSsvZzM2bUt0YWpjQ1p6ZzdmQmV4dVZ0eGVHQURoTFpZK2VL?=
 =?utf-8?B?NStQL2ZGYWgydTA5UmRtOGlYVHNnTGtROVZIVDlKTDZqQitpRGRqbjg0TlBO?=
 =?utf-8?B?UVZ4TFVhVmF6bHFJQ2o2c1Fzckw1UlVaUXZBREZsUTg3UHZoRmVRellQdmlN?=
 =?utf-8?B?WlRGaWI5UG05RGpDeDJEKzFFUU5JRkFUQVJXOXEyc0tvK0xIRzhvRGU5THdN?=
 =?utf-8?B?Vm16STVZbkdZL0tOMC9leDUrN2loMjIvMVRrai92djBZR3owdGlCQk1zUVVs?=
 =?utf-8?B?QXFlVnc4VytzU3NUcGoyZjJrZS9tMmRoWlVuUDMwMTMzTnlXbTZyR2RrSHU5?=
 =?utf-8?B?NW4vbWdJajM5V1FqbmRRdzFuak9LRmlLWEpySVJwVE5nM1FiQTNVNFd0ZSsv?=
 =?utf-8?B?ZUhxcW95ZHJWcXZVaTd2bkVKVVdaakIra3ZGTDhqS0xRdnpBWnc1NitUVjBO?=
 =?utf-8?B?QjVaM05XWnFkUUhpMmVxRkRkYnZUd2hUdE5YTklSZFlqNzlMemdrcDI2WVZr?=
 =?utf-8?B?bzEyWnRrNnlhcVpqSTV3b0xmRGdZK3NJcEhtQm9DRWpMQkVJV0twYjliZEl6?=
 =?utf-8?B?RUF1RUdJYVF2K1V0QjFsQXdNSjZTSjJua0UwdCsreTU0dG1aVnkvMzZOcklT?=
 =?utf-8?B?Y3NVL1NVOWtJZnBxZXNSbHNEMzJJZThtb2lXYkFKSDVBend1ZjVCbjlqaHZU?=
 =?utf-8?B?YW5hRGJaNWRYc2FGQTQyVlJhc3drRys0cGhBaG9UQmk5Q2tSMjVwSkI3NCs1?=
 =?utf-8?B?QTc4VDVlOEs2QjlTQ3ZVNE5HV2FMeGE1K0U3V2Z3ZmV0U203N3RmU1lyem5K?=
 =?utf-8?B?OXBZWThQRnh0OVFMRmdaTTBSMTA4VG5aNjlOamIvd3hSVlcyZ2xQdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a9f1a1-f01f-40da-b615-08da33464f11
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:03:49.7540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjcB9ChZvVv9ibbpT8w3YgREmu/4B2ZPHZKtY59s4mMBSJ9YO53bodBTci53BWQL54GRTuot6m5gfV5N0+3g4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4028
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 5/11/2022 5:27 PM, Lazar, Lijo wrote:
>
>
> On 5/11/2022 5:16 PM, Sathishkumar S wrote:
>> smartshift apu and dgpu power boost are reported as percentage
>> with respect to their power limits. adjust the units of power before
>> calculating the percentage of boost.
>>
>> Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
>> ---
>>   .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 60 ++++++++++++++-----
>>   1 file changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c 
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> index e2d099409123..35fbeb72c05c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
>> @@ -276,6 +276,40 @@ static int yellow_carp_mode2_reset(struct 
>> smu_context *smu)
>>       return yellow_carp_mode_reset(smu, SMU_RESET_MODE_2);
>>   }
>>   +
>> +static void yellow_carp_get_ss_power_percent(SmuMetrics_t *metrics,
>> +                    uint32_t *apu_percent, uint32_t *dgpu_percent)
>> +{
>> +    uint32_t apu_boost = 0;
>> +    uint32_t dgpu_boost = 0;
>> +    uint16_t apu_limit = 0;
>> +    uint16_t dgpu_limit = 0;
>> +    uint16_t apu_power = 0;
>> +    uint16_t dgpu_power = 0;
>> +
>> +    apu_power = metrics->ApuPower/1000;
>> +    apu_limit = metrics->StapmOpnLimit;
>> +    if (apu_power > apu_limit && apu_limit != 0)
>> +        apu_boost =  ((apu_power - apu_limit) * 100) / apu_limit;
>> +    apu_boost = (apu_boost > 100) ? 100 : apu_boost;
>> +
>> +    dgpu_power = metrics->dGpuPower/1000;
>
> Before submitting (not expecting another version here), may add a 
> comment that APU/dGPU power values are reported in milli Watts and 
> STAPM power limits in Watts.
Okay, will add the comment here . Thank you.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
>> +    if (metrics->StapmCurrentLimit > metrics->StapmOpnLimit)
>> +        dgpu_limit = metrics->StapmCurrentLimit - 
>> metrics->StapmOpnLimit;
>> +    if (dgpu_power > dgpu_limit && dgpu_limit != 0)
>> +        dgpu_boost = ((dgpu_power - dgpu_limit) * 100) / dgpu_limit;
>> +    dgpu_boost = (dgpu_boost > 100) ? 100 : dgpu_boost;
>> +
>> +    if (dgpu_boost >= apu_boost)
>> +        apu_boost = 0;
>> +    else
>> +        dgpu_boost = 0;
>> +
>> +    *apu_percent = apu_boost;
>> +    *dgpu_percent = dgpu_boost;
>> +
>> +}
>> +
>>   static int yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>                               MetricsMember_t member,
>>                               uint32_t *value)
>> @@ -284,6 +318,8 @@ static int 
>> yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>         SmuMetrics_t *metrics = (SmuMetrics_t 
>> *)smu_table->metrics_table;
>>       int ret = 0;
>> +    uint32_t apu_percent = 0;
>> +    uint32_t dgpu_percent = 0;
>>         ret = smu_cmn_get_metrics_table(smu, NULL, false);
>>       if (ret)
>> @@ -332,26 +368,18 @@ static int 
>> yellow_carp_get_smu_metrics_data(struct smu_context *smu,
>>           *value = metrics->Voltage[1];
>>           break;
>>       case METRICS_SS_APU_SHARE:
>> -        /* return the percentage of APU power with respect to APU's 
>> power limit.
>> -         * percentage is reported, this isn't boost value. 
>> Smartshift power
>> -         * boost/shift is only when the percentage is more than 100.
>> +        /* return the percentage of APU power boost
>> +         * with respect to APU's power limit.
>>            */
>> -        if (metrics->StapmOpnLimit > 0)
>> -            *value =  (metrics->ApuPower * 100) / 
>> metrics->StapmOpnLimit;
>> -        else
>> -            *value = 0;
>> +        yellow_carp_get_ss_power_percent(metrics, &apu_percent, 
>> &dgpu_percent);
>> +        *value = apu_percent;
>>           break;
>>       case METRICS_SS_DGPU_SHARE:
>> -        /* return the percentage of dGPU power with respect to 
>> dGPU's power limit.
>> -         * percentage is reported, this isn't boost value. 
>> Smartshift power
>> -         * boost/shift is only when the percentage is more than 100.
>> +        /* return the percentage of dGPU power boost
>> +         * with respect to dGPU's power limit.
>>            */
>> -        if ((metrics->dGpuPower > 0) &&
>> -            (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
>> -            *value = (metrics->dGpuPower * 100) /
>> -                  (metrics->StapmCurrentLimit - 
>> metrics->StapmOpnLimit);
>> -        else
>> -            *value = 0;
>> +        yellow_carp_get_ss_power_percent(metrics, &apu_percent, 
>> &dgpu_percent);
>> +        *value = dgpu_percent;
>>           break;
>>       default:
>>           *value = UINT_MAX;
>>
