Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068EC43460
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 13:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EB661628
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EB661628
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9391C6EA36;
	Tue, 11 May 2021 13:49:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32006EA36
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 13:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq6euCuhbdaWx6AGrz+oXWxRlrAkl/+qNkSTeQuj7Mw84caTRxgixXMhiK1Nj0e8WT5bRXyYUkV8L5Qee/Ekq00nXPiqMagNPK7VMJrJGErOzhNzy/42xRpa/WjJ8z2wHrYjxVfIAw4J83TpcXm/YrCbYrJoKXHCVlCQ4t+4YRhc1GJQ560tiogbpCnvhhCXbRwc8AJfz1q5BD+eHyV0NhjX+anzwwrpSP5XEDBkfVKsKQeQbr9SSHYOtijvFcUvvNv6tDdyWMKDy/gkol74ipJ4Njhl/h0lth233yJDcmJZVJfR7wXO1grb6VlCKb7aY3H7FWG9zZ6/XUm/53ZY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb+4GBjKmsevwackCo9djWQVl/jh4yoE9OU1lDvlESs=;
 b=c47mkQskjljMbz8vuiNNitFf+bn3K1xN+NMwHHS0SLuRVsfx37r6GkpUQchg9G8Hy1wp5WlkGfvGsLaC1x4Hhe5lVAF4bKb1xykPAfQNIVL1sBXXwZOrWztD/uR7zBwggpn3tf92uwxup41eDVJH34HcLNU9Empg2Ivc64UIWLPjI47jT2t7cnEs9cjaw40ZZu3Mne4VIIQyTLWq4FI7/ebVpERcd/RpRyfQa63sdxJtSvhj8urx+0zP+00oS42Of3WYZSiGWtzKLzhlbAPWeoxVqzLC2V35nhynN9w+RJi8F3m6Jw4l06/nNlJV8ewzeejpNAP7qkdx636Qmky+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb+4GBjKmsevwackCo9djWQVl/jh4yoE9OU1lDvlESs=;
 b=gT4Jw+HpwKs4oMkJRZd9UuqAold1yIHwUXGYkpvLZ6GNACvZPKMq8nNE+zQ9Sew9KQvHkdS95oWTpXXX5VUGzcU4QRoblrde6HEgdLUJOwNh2XBcIoXUpFTtN6CM1XyVBHgocTqBzHpiKKVejTKBeA//DR6dz3Ozn6rPYLJQ9ZE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5133.namprd12.prod.outlook.com (2603:10b6:5:390::6) by
 DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Tue, 11 May 2021 13:49:25 +0000
Received: from DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90]) by DM4PR12MB5133.namprd12.prod.outlook.com
 ([fe80::cdbd:bd79:d9b2:ed90%7]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 13:49:25 +0000
Subject: Re: [PATCH] drm/amdkfd: refine the poison data consumption handling
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com, christian.koenig@amd.com
References: <20210511080657.14628-1-Dennis.Li@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ad734f03-6015-011a-a15c-5d86449250b0@amd.com>
Date: Tue, 11 May 2021 09:49:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210511080657.14628-1-Dennis.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [142.116.138.207]
X-ClientProxiedBy: YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::41) To DM4PR12MB5133.namprd12.prod.outlook.com
 (2603:10b6:5:390::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.138.207) by
 YTXPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.31 via Frontend Transport; Tue, 11 May 2021 13:49:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8f8f53-0c71-40b6-22c6-08d91483967c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5414B2ACB352742705AC42E392539@DM8PR12MB5414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozq9ijBCzVyuPTm2o8mPrJVl1d4uceLKulUGQCRIB6/gX6fbP9Xg52QRylZbqCWA5BkOnEUD9Nu3eKDxq3d18uAmUoO+ag3WDq1Nyu2VqrZeBjsBEXY/mLe+Zq8M7sjhLlvLRG0PLc0g5u6uG4b5St15nxrXSHke/2w5VlMWDUz1l8Wkh9BZuYWZHPRC5PnizrDdzQ8O8okq0ZorGBXGLe17ZRpXvUn111n0kM9zStrnqpWs65I5SZfEt02WL0egtt2IVbmXMjbLlYCR12MO9kEK/mURqJ5G//rZzEI4n4r6GWxBxEP2fYR+p+1ItwM/0ATRGYKdY1nkm7FkG2PkPK/RMgEh3VyKkEAokHnxW348W3xMOrpvAwUtqP8ZgJCuV9kcNsIVOFknA1P53DD1OVLR23Y+f9VLWkIvrbp67iughHMcOpc6BK9hogimZbOcf+2QvoGUahj6XD+m/Joa7omFTE0PgwY7eWT0A7nVlN9hurvb1hs3sUjo+wn6H6T67F2k1y2Xx2hWnqM6BRB3E3/yMUojD58aVO+ilCIVb5ANKrCwv8TXJqoalmjIgb/QX85lLta++xK9BxF7z1dpC0ABDSZ4RjSEV5yvBLEVkP0UarsucvR7s+SSnqQxU9mASp9MsRgxFUMcAlUrwsLxWylDgkdxpW2ng+sBsv+RmlAK0Pg5HXHl1APUQw9vd8dH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5133.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(2616005)(186003)(6486002)(83380400001)(5660300002)(8936002)(956004)(16526019)(8676002)(31686004)(66946007)(66476007)(38100700002)(31696002)(316002)(26005)(36756003)(478600001)(44832011)(6636002)(2906002)(16576012)(86362001)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bWR0ckc2azNUU29xQ1NuUkRwT2h3WlB0dmFBS21nQkp0T09adVJHNkRpVFFI?=
 =?utf-8?B?Z2daMUk5YytFc0xRZVhnczJNZkFqK2tqTlB3STJZNEMvd1c2UVB6SDBnTWpT?=
 =?utf-8?B?WFF3bUZQbmcySURwSm1qRGxSdFpSZFkrU2prZnVQZlJlaHh2K2JlZTRESy9s?=
 =?utf-8?B?bDBXMXZLM3dtWHZkc1JhRElzYUNFRXo3TmsvNW5HM1lxT0grbVFQUmd5UkxB?=
 =?utf-8?B?bm01dkgrRnBySEREV1VpcmlQcWxQMkZyWXFIUXRoV3E3U2pwQlozRXJHeFAx?=
 =?utf-8?B?VFNhWEgvZ0piNEdWSW5MNVZNMGZFRHV5TmcraytkaVBCT3FvaElyL0RJQ293?=
 =?utf-8?B?eGFUbitIWXpnTVhwYkpycXNPYXhMbnZHeTFzNnFPOVd0ZDdIajEydEc0NTVz?=
 =?utf-8?B?aW5YWFpSWHpQc3lWSnE0VWh1b3FkeWlWWUxuSHVsOTBxZTYxUG9QNVJtZ2pi?=
 =?utf-8?B?d3lCNndwSTFFK0hvRGlsaG5LUXczN25GazhWRlhqVDdMR2dUMnRLdExBRFBZ?=
 =?utf-8?B?QVV1Z0VMMlkvcHlseDd3TTdzV3dKSHlIY2Z0RjVpSzRaREY2ejdlMk05R3hG?=
 =?utf-8?B?VjZPUDIzcmt0RWZTOTkyR3ZzK1l5MnpkYzU3Nml2cG5iMkV4bG85d0ZRWnhw?=
 =?utf-8?B?MTlvZHFNRnB2c2FQZStrWGp2by90SDY3NThCSm5TTWEzN1VtNTR2cGhMeEQr?=
 =?utf-8?B?dUhOQ3hDTktDQ3B4TFA5NndJOUtFcHc2R0pVeTVqSmNNWXgwTzdhKzhJVSsz?=
 =?utf-8?B?ZWpaQURKSmwxOXJqK0g2SXQ2NDJYOVIvTFNuTDRaV0VsQ2k0RlFqZXJVWWdS?=
 =?utf-8?B?YkpZclBKVUJBWlVKcGJ2L3Iwb2wvOWNkRHJCVDVPRzh4clp1TjlGN0V2WTlI?=
 =?utf-8?B?dlA3QXBFNW5VeGpScWFUS29tWitLZkdIR2N6Ykd6VHBadTB6OFlsbmtuTjVB?=
 =?utf-8?B?c2VmajBOMjUwUVJYK1MvWmhIaytHTDY4TWEraDFyQURsVUlqRE1LK01EV2pN?=
 =?utf-8?B?czFCTlR5b0MrZGVSUlU0U2lkcWk2ZTJCcHpadkRWWGNsMHhoN2VMT2FKN1Zi?=
 =?utf-8?B?bmJMUTNmQkFrSXRhTmxEZFJSUnhPUkdDbUpnNFBhSDVvRE0yWURiQTBaTE5D?=
 =?utf-8?B?dkhoZWo5WWdTWFM0SUg2L09rWmZtZWVOS05EbDNSUHFpRHVMMXhTZTBJTmox?=
 =?utf-8?B?SDA5UFVMT3YyUjBVSTFrbDk1akQ3bHJWY2tOWCsxdmtaZ3lONkE4LzRiMkta?=
 =?utf-8?B?K0dZVlZJUU4zek1sMkQ4YkZyWkkyUGRuckJkejIyOW1hbkVpWkIvd1lTNHlU?=
 =?utf-8?B?a3dNeThSNENTMlR6R01GeVF2NEh6SFNFVlRHZUM4clRNMEFVWHJSNnpGT04y?=
 =?utf-8?B?RjZWYkwrUU16MzlrV01NSitWcXZldm5LQW5DaDFxMHdCWkxNQVJ5MlgzVSs3?=
 =?utf-8?B?ZVNjWWFTVC9POElQK1RUdDNXYWNyTUkwN0w1ZTdDS2hDSHZxeDhzSWJPN3hv?=
 =?utf-8?B?Z0lFVE9Nam00cTB4NktreEZQZVU4aVMrUzhpcWM3dHFudDJocy9WcFppT0F1?=
 =?utf-8?B?SHZxY1g3b0V1cWJMYWc1VzFhTytnbytBTGkvMTArQjltZkIvUDhNZzJ5ZVl0?=
 =?utf-8?B?Y3RJcTZGNFg2N3FxaE1ya1pXZTFaOTd2L1h0VkkrZFRjNEhHc3k0RVBqUXBX?=
 =?utf-8?B?R1hkU21YVUVFOWI1U0xPbUl2c08vMEZORG13YW1ycWJKdjNVNnFBUEx6ZFNT?=
 =?utf-8?B?OWRZTkM3Y0FiL215Y2hzcGZWVm5peVdxNUl0YVBTbS9Rcms3eHFHK1kzTUQ4?=
 =?utf-8?B?NUJRM05qU2Vudjc2Y29Sdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8f8f53-0c71-40b6-22c6-08d91483967c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 13:49:24.9566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzKXHJz99FI0QZAxDiN6rQO+Si1lgUWrUgSiIWuUr25Sh4x3O39dJZAd3kudmyBerV6ZUmYLw5rKN0ZEmJiJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-05-11 um 4:06 a.m. schrieb Dennis Li:
> The user applications maybe register the KFD_EVENT_TYPE_HW_EXCEPTION and

I guess the HW exception event is sent because the current handling of
poison consumption triggers a mode2 reset. If that can be removed in the
future, then we should not send a HW_EXCEPTION any more.


> KFD_EVENT_TYPE_MEMORY events, driver could notify them when poison data
> consumed. Beside that, some applications maybe register SIGBUS signal
> hander. These applications will handle poison data by themselves, exit
> or re-create context to re-dispatch works.
>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ba2c2ce0c55a..4d210f23c33c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1050,3 +1050,42 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
>  	}
>  	srcu_read_unlock(&kfd_processes_srcu, idx);
>  }
> +
> +void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
> +{
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +	struct kfd_hsa_memory_exception_data memory_exception_data;
> +	struct kfd_hsa_hw_exception_data hw_exception_data;
> +	struct kfd_event *ev;
> +	uint32_t id = KFD_FIRST_NONSIGNAL_EVENT_ID;
> +
> +	if (!p)
> +		return; /* Presumably process exited. */
> +
> +	memset(&hw_exception_data, 0, sizeof(hw_exception_data));
> +	hw_exception_data.gpu_id = dev->id;
> +	hw_exception_data.memory_lost = 1;
> +	hw_exception_data.reset_cause = KFD_HW_EXCEPTION_ECC;
> +
> +	memset(&memory_exception_data, 0, sizeof(memory_exception_data));
> +	memory_exception_data.ErrorType = KFD_MEM_ERR_POISON_CONSUMED;
> +	memory_exception_data.gpu_id = dev->id;
> +	memory_exception_data.failure.imprecise = true;
> +
> +	mutex_lock(&p->event_mutex);
> +	idr_for_each_entry_continue(&p->event_idr, ev, id) {
> +		if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +			ev->hw_exception_data = hw_exception_data;
> +			set_event(ev);
> +		}
> +
> +		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
> +			ev->memory_exception_data = memory_exception_data;
> +			set_event(ev);
> +		}
> +	}
> +	mutex_unlock(&p->event_mutex);
> +
> +	/* user application will handle SIGBUS signal */
> +	send_sig(SIGBUS, p->lead_thread, 0);
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index 97c36e3c8c80..9f9b1dfb9c37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -230,7 +230,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  					sq_intr_err);
>  				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
>  					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> -					kfd_signal_hw_exception_event(pasid);
> +					kfd_signal_poison_consumed_event(dev, pasid);
>  					amdgpu_amdkfd_gpu_reset(dev->kgd);
>  					return;
>  				}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 64552f6b8ba4..daa9d47514c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1144,6 +1144,8 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>  
>  void kfd_signal_reset_event(struct kfd_dev *dev);
>  
> +void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
> +
>  void kfd_flush_tlb(struct kfd_process_device *pdd);
>  
>  int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
