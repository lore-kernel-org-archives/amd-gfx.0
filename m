Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95372C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 15:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36DF910E0F0;
	Fri, 10 Nov 2023 15:08:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3347C10E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:08:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1FfSvjlX6QJHAbWSuxT+v8mNtRzBNV94tvCaQRcIPvFuKkgiNwbhPT+B9zxNRMLwwZuwQidFKBBGhCvxUtTpn0MAMlauL5YfY3Nei0JmKFkw1RQx6KVxJr3uNWtjUzXiPtNWOG5rfC100lOr75ar2qHuLBSu34owxMmHrM8VibKP2tvK3jUm6oa/zblyEYvTGd+SLlhr9nGOWUx/71ley6kA55/R6Vd4QA6OFRoPsPB2u2ZiDKCrvlY2NHmf0J0vhGHK+z2e60mnhmJVE4w2t+GTOOX/hvSL7swkN3QhXkogkSceTAnHKIvHE2Kc73oYo3MPDSxsJnu1yQ2gKBccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P630lw+KbV+hzjxNxDYXID8EV6S/bKcIvPOQpNYiL0E=;
 b=ZLgeGaj8qreMLuFBPbkpUEQYvs30a3QeeN0SFsRegdDkzSb1KM1C34830MA+Z7U0pyS8cHk+LanePlaiAMCreqMKvTsgLasO9lhmqc4Snm7cq9COmdhAkeFfbPlPuRyGz2Yjrx7JQ07SVrMO0ZFZgm3RsCivBatJxCIC+AatNQMDDSgairT08wHXadZlKyU6B5lPajJBrNmca/7cMCw74lRswhJ8j2TDAQJpWaY5J1+9+3JrU+g1SvfKzrqG3ULq4jOSYWV+hHxQ1CQD68BL7hCxopgzxmdQQjlZFE3LUvyfQukeExQyoFlZ6qCEqVj2toGCtYrMyHmXoBVAn2xgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P630lw+KbV+hzjxNxDYXID8EV6S/bKcIvPOQpNYiL0E=;
 b=BAGQpzioM4PF1yhwKn+OZvqFFZiCyjklx5YQ4D7bHGI7tpRBmUy85m/1AAuM0Fd6EO6mJXOPqNQTENqh8ET0ezuatCqbZEzR0Gw8v4GlWgQk33JZPKp17z1fYtbd1wgB+S082uhErQwl9shJUIbIbi3kDIoTu2+6L6GcaDfQaIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Fri, 10 Nov
 2023 15:07:58 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::c258:1e94:a85b:1510%4]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 15:07:58 +0000
Message-ID: <1195f786-e7ac-b93b-58c3-bf7276dc18e2@amd.com>
Date: Fri, 10 Nov 2023 20:37:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20231109073813.552664-1-lijo.lazar@amd.com>
 <a8e73966-e233-4ec8-9e33-9821da64e67c@gmail.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <a8e73966-e233-4ec8-9e33-9821da64e67c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::17) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: fec472f2-aa46-4c9c-69f7-08dbe1fed32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2lDC+sVvL1ZIfyGv4VAhrzw7E4DfFQKa8xEOb0kdXpiJ34kZMBfhTo1vbdDy+mU8f9cco6UOI/SNOvjhE5KwbImrnEq1FF3E+6XjHzKhhBZfWgb22vJ1GapXf8xPOghoYbAw7vkB9S2aucXjg+yOlsJ0DKErNxYavEiOpRPlv27bjqmZTFRa4D23hxH2kez/tzG+Rp6ntHJB2LLiS0l0C6baM1Iwu5g6K0/UqEEi13MWNG0ReeJUdBtdPzr0q+Fl9UMK1SBIDF/th5o3KN+HuuXUF8ZF4gBiiKk9RLXk6BB9qvfKCUkjopghw4zdTDhxEcZD19WfD+dRwkz7eQxHibtPrqVb2h/34rzH9QnGg7Q4f4KPLXJVhAqaA5OrPCcNBvBLsNMSVmzIHf+6ioC3gQ26rwR8dI1SW3LbL1o/5u3xn571niRpfg/n3e3Th5rfhr7A4+t9a+l2sd5u+WqoH5jLZai82B/G5MEk1Fawow8JXWyOa1roYU4gkdfChgAPj1WFAt4k0XAekv40h5lynCSSPNQ4LmBz4YrDWq0IKRfHbT06+qdnRPcmzC+88aL3gDGLNPa6lYkNLaqIBvnoibHcdgrcjDKf69CYRBF0ehTiHehdE1hkLHOG1Xbq/P4EagpVsNHXQAPjAWKSAIzng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(36756003)(4326008)(8676002)(8936002)(2906002)(83380400001)(66556008)(26005)(66476007)(66946007)(66574015)(316002)(5660300002)(6512007)(6486002)(6666004)(6506007)(478600001)(53546011)(2616005)(31686004)(31696002)(86362001)(38100700002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3hLNExWeUR1Wms1YUQrdUZRT1BkUi9HVVdsdThVNkhRSDRLcVNVWU9NOThm?=
 =?utf-8?B?THZqTU9OZm9JWmRWU2FHQTMrb3ZpZ1hoOFB4UVhYdDhTVG40TkpJYzc4a1li?=
 =?utf-8?B?OVd5Q25JTFhzZHBWWDVPb2x0TldRSTdxVHB4Ym9od05zUGVsRVhTODdPd2VZ?=
 =?utf-8?B?UkxUUEQxNkdmYnJGYzh5NDdVZE1OWWM5UlRCem8vTTM3eS96YWJjTG9aZVlo?=
 =?utf-8?B?aUZ5ZDV1ZjkwbmZ6bWhwZENDQkRCaU5rRUZ4aTdURHNrSkl2eEJHNU0rK1Yw?=
 =?utf-8?B?T0kwNWxDNVVzTmZkSm5yRHZ4UjdKZjVSRTNTZ2lBQTJDbEY2VkZ6L0N3andH?=
 =?utf-8?B?MXVuRjRBSFBYMGFsVDl3bWQyQnlkZnQ0REhuZ2Q5MzNZc1JTUHV0QmFiOUFv?=
 =?utf-8?B?bVNrR1g3TFJJeFI1dkNiT0ZxOXVtTnMvd1c2MjZucDRpSm12amtRNkR1OG1j?=
 =?utf-8?B?OGY1dzJyQVdBOXNEb1ZwNlFoZnR4RXUvMWRCeTNMZW94Y1VqOFN1bHRQeUlh?=
 =?utf-8?B?UExOVVpaK0N4dFo5aGNZa2lJSjFqNDJoWkFzdXVCT0Rxcmt5c3d2UkNtbTVx?=
 =?utf-8?B?QWJyNHdkbHVua1AvMUhqL25uanBIem1VRTV3Z2hicENPT3FyNUJ1UCtlOGdF?=
 =?utf-8?B?d0VkSjVRY2taa3RzV3IydE1aQjhEeWZHTitpRUV4RHZWamN6aStEV0hFZ3pI?=
 =?utf-8?B?M3FBRS9RcjR0RG1zSTRHTkF3L1hCT3p2K0RlYzBPRXg2bDZCMWRWaFJGb05z?=
 =?utf-8?B?Z2NmMnQ2ZDk0N2tuK0tGa1p4b3pqSklLSTVKb1AySDR3WU9oTHl1V0NPZzl5?=
 =?utf-8?B?a0Jmd0ZrK1UyUzBqNVkzaUVEU2pUNG5oT3RJZWdhVitBcnhTV0Q2WE02RmdO?=
 =?utf-8?B?ajVHZGJ4WHY1czFlN2VOSU5iUVVzN2piNDd3NkljU0hSWE8xVG04b2FBbDFC?=
 =?utf-8?B?Q2tqY1IyU3VXL2lOazNVTkJOR2VxQ2YyWHFaNUJvbWh1VnVBa3dhOEgxRHJ6?=
 =?utf-8?B?dVRLWnlVZ3RvUDcrUHliVW8xWU5aaVlSWXRubmNBcUxoV3dNKzVWME1YQWRx?=
 =?utf-8?B?VmIxcE5lOXJEbGI2YkU4QW55aWJzYzVZOWlhWXQrb3VZbDlGVTc0cCtsVEtz?=
 =?utf-8?B?Z0pYYlZYTGYrL3VaOENTRUpPeWpnY0dCYVprdDd0MG1Eb1ZrM21yeitjYXg4?=
 =?utf-8?B?czkzYkNqQzF1bHNsNFJOeWpBY3phOHkwOFpsNzFMNU11cXZFTGkrUUc2Yi95?=
 =?utf-8?B?S093Q092MkVubSt1dkVHYk9CQ1MyZWk3c0R1L2lGR1ZXMUZaOGN3V04wcHph?=
 =?utf-8?B?c3RKZmhaWFlTMWlyL2puWVNEc1lGMlhpUFRsN3VLRlozSVdFOE1vV3lrMTIx?=
 =?utf-8?B?SEtjR3ROekxtMDEwTmxkOXJUOVg4SERxNEIrNDg1NEdwUVhmZTRQWnNBakls?=
 =?utf-8?B?ZUZTemh4K3dPUEp2SElKRlJGdjEwVkRKeTVzZTU3R01WakxPOGtTWW43aEoy?=
 =?utf-8?B?U3Y4TFV3bENqNGw5WHJialUwL2s3SklqeW12aGpyT3BlWTlOb3Q5VmxyUjFJ?=
 =?utf-8?B?c1F6RjJYaFhySEZXb2s3UHZOdGhKN2hoK2dqaFZRZS9nVERDc2tMbEZnQUdh?=
 =?utf-8?B?RDZvcGdjS1RONFdVRUlSZWJpZkduekN3eWdWTEo4UlFhdXlvZG1DN1N4eUFX?=
 =?utf-8?B?VElVMFFjWDIxM2xWVUpmNDU0TC9jUVFTYUNmVjNmRjA5Q3U3V0hiR1BVQmR2?=
 =?utf-8?B?NmpOUitrSkhYUkxUYUJPNThxVXJaQ1hFMEpRcEgyUGdNdTMxYXY2QWw5M1pu?=
 =?utf-8?B?WlRlUkJEQWJDSGREMTVkeGhwV1Z6MUpIaDJxdmZZT01WaFhCWFV5V3FIbnVP?=
 =?utf-8?B?a2NMS2U3QzAxcmQ3dm0xc3MwS0VSaEloTnRuYS81dUhraENpL2lGU1ZJOFR2?=
 =?utf-8?B?ZmZxaWtxMG1XdEJxMEVDbFlManRISmdaM1F5TGt3UnJNcWpBbTl1dU1oUk5x?=
 =?utf-8?B?U2JtQ1BOVzVUOG0velo5Y1pWYXBVcURpQnBVZTdmci96dTZzejRXQlZtTmdG?=
 =?utf-8?B?WlFBM05wSDVDVWUxR1I0SURJdG91T1FiS0Uwbm1qYTNseGljSEovNU1rZ3pL?=
 =?utf-8?Q?1EJt1n1W1FN5IBUs0TtQl2FEO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fec472f2-aa46-4c9c-69f7-08dbe1fed32c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:07:58.7396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8nWcfLghEPJd8hq4aoJ21p1+/wdrXPPY0tNHPS48uuiJ1vdexwW++0+GUssm+ha
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/10/2023 8:18 PM, Christian König wrote:
> Am 09.11.23 um 08:38 schrieb Lijo Lazar:
>> cancel_work is not backported to all custom kernels.
> 
> Well this is pretty clear NAK to pushing this upstream. We absolutely 
> can't add workaround for older kernels.
> 
> You could keep this in the backported kernel, but why should cancel_work 
> not be available?
> 

As you know there are vendor maintained kernels, and all users 
necessarily don't upgrade to a kernel which has backport of this, as 
that could be total disruption of their current environment.

Thanks,
Lijo

> Regards,
> Christian.
> 
>>   Add a workaround to
>> skip execution of already queued recovery jobs, if the device is already
>> reset.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  9 +++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 16 ++++++++++++++++
>>   3 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index bebc73c6822c..c66524e2a56a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5411,6 +5411,8 @@ static inline void 
>> amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>>   {
>>       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>> +    amdgpu_reset_domain_clear_pending(adev->reset_domain);
>> +
>>   #if defined(CONFIG_DEBUG_FS)
>>       if (!amdgpu_sriov_vf(adev))
>>           cancel_work(&adev->reset_work);
>> @@ -5452,6 +5454,9 @@ int amdgpu_device_gpu_recover(struct 
>> amdgpu_device *adev,
>>       bool audio_suspended = false;
>>       bool gpu_reset_for_dev_remove = false;
>> +    if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
>> +        return 0;
>> +
>>       gpu_reset_for_dev_remove =
>>               test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, 
>> &reset_context->flags) &&
>>                   test_bit(AMDGPU_NEED_FULL_RESET, 
>> &reset_context->flags);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 4baa300121d8..3ece7267d6ea 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -120,6 +120,14 @@ void amdgpu_reset_destroy_reset_domain(struct 
>> kref *ref)
>>       kvfree(reset_domain);
>>   }
>> +static void amdgpu_reset_domain_cancel_all_work(struct work_struct 
>> *work)
>> +{
>> +    struct amdgpu_reset_domain *reset_domain =
>> +        container_of(work, struct amdgpu_reset_domain, clear);
>> +
>> +    reset_domain->drain = false;
>> +}
>> +
>>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum 
>> amdgpu_reset_domain_type type,
>>                                    char *wq_name)
>>   {
>> @@ -142,6 +150,7 @@ struct amdgpu_reset_domain 
>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>       }
>> +    INIT_WORK(&reset_domain->clear, 
>> amdgpu_reset_domain_cancel_all_work);
>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>       atomic_set(&reset_domain->reset_res, 0);
>>       init_rwsem(&reset_domain->sem);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> index b0335a1c5e90..70059eea7e2f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> @@ -87,6 +87,8 @@ struct amdgpu_reset_domain {
>>       struct rw_semaphore sem;
>>       atomic_t in_gpu_reset;
>>       atomic_t reset_res;
>> +    struct work_struct clear;
>> +    bool drain;
>>   };
>>   #ifdef CONFIG_DEV_COREDUMP
>> @@ -137,6 +139,20 @@ static inline bool 
>> amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
>>       return queue_work(domain->wq, work);
>>   }
>> +static inline void amdgpu_reset_domain_clear_pending(struct 
>> amdgpu_reset_domain *domain)
>> +{
>> +    domain->drain = true;
>> +    /* queue one more work to the domain queue. Till this work is 
>> finished,
>> +     * domain is in drain mode.
>> +     */
>> +    queue_work(domain->wq, &domain->clear);
>> +}
>> +
>> +static inline bool amdgpu_reset_domain_in_drain_mode(struct 
>> amdgpu_reset_domain *domain)
>> +{
>> +    return domain->drain;
>> +}
>> +
>>   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain 
>> *reset_domain);
>>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain 
>> *reset_domain);
> 
