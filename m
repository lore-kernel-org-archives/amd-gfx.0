Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB43C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 18:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76E010E191;
	Mon, 14 Mar 2022 18:41:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843F210E191
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 18:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZlRfoxa+yYGBZKGJF1RFp5rQ8D9ebtx3pIgy9TDE0QnCJDEZsuiBt/DArZB/ACD4MX4tg7xBBEcpNZaVjBQgPbzIaE/xJPB9Vdm/GNe5XM0B2MBOtLu7pY3pTm5+prsCtxz8+Rtp7IH9SPDII8J0hBAJ4dtWm76lAT9n8UokJ/u6tIrrfvV3Wui2ive2ELK/dayfIzwyuP9EeGfpx+ww+VqYjBJA9nILwceLOowsFqNI+SGX6Q74YM1SW0lmX74xvRtcoQjUvVLFM8Ox/iCGA40gk/vu6UZVICbLzv1kPM5kppZY3TvZ8rtZwTzlYE9r/hQ8JTBDbgzJGeMQME59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7m7lk5YQCJtChzTUaIyW+R5x3uwg/k4Rt8K9hORzd0=;
 b=AOrJOw7/RVHgvDlUJ19FxyztSAxQ0pcZX/oUtd1m50EgKM3gmoCt+lZZxJgCHHmSKIO2E9FonuwNQjaalLwyxIS4xZsUKGBb2eJa9kQHxTr3tkiq0nSfDIBF17C8dLc1NZWRDHJyCCBPZQF/aYJ+fTQsMZVjsw9Doq0q4vay5e+ah8fUz9qk8XO0kObLI7HVNo4tz472fGF1B+A8egPcNKzYseEn3NyQJqLcyLfF01B8diJWXjXE5rlFfttBfidp5GEgR3cskygXFPowHRN/m4Q2WzCbYg9/U7LspGdRgFZk5XS2KoY/wC6KfFqY/EIjBha1uNpZO4FAAXQ1f6yptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7m7lk5YQCJtChzTUaIyW+R5x3uwg/k4Rt8K9hORzd0=;
 b=rggvq0B9AnRCjg77F4vpN5VZROsZq46XkQfboTzbOKF+LrBBdx9ZT3K2FKC5xAE0tS4yfWfsgt640w6QbQNmZ8zmQYIGMdI8JcF+rSnVYuSlqG21ugsWiHX2CBeEVD00SP0aimfd2iiS7gmo+070KujPBb71dUFcYT3c70e4o5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB3736.namprd12.prod.outlook.com (2603:10b6:610:2b::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 18:41:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 18:41:27 +0000
Message-ID: <e4752fcc-3018-87d8-5053-2a82341e9d09@amd.com>
Date: Mon, 14 Mar 2022 14:41:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, yipeng.chai@amd.com
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220314070326.21828-3-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 434996ba-2194-4d8c-5616-08da05ea3f41
X-MS-TrafficTypeDiagnostic: CH2PR12MB3736:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB373699B10AE067E7CFFB5661920F9@CH2PR12MB3736.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYPbqVFZk2JxTaFxc0eyBLR6JCiI0ZwmlAphnez3tIBtBBG84EDCUa2/oaVARPtXSDRAdlA8DIMCsii+DzqHEQjygLH3FkGIvazCR4eLXD7ofTskHRioIu/aRR8atd66gy6fzEpcQFiHbJQxlyNpqzOT+3FNlNwVuqKW57k2drax0vrRcSVvGSBMbzG4oStYGmRWhlFXljjZA2tS76bTvKKkedfCS7+g9dA4Uy6d49YoHRkzfFbKTv8xy39gMJ9P5FOPWPsLs77GSzyL6IFhRz7Kd5ADv82eSeg+be10XWCWu4yBdvN6KQOxQLZQdsvfBP0GtZVDqNNiZ6J4h6ZdQERWr0ZbHvngP1TUkW9E8rFY5V6XwE0hi5MDMKs/cHt5hQYSsI9Ipy5F6fkD7qptHuNCJLKUegtl7ps+Aw3cXbWgv//bU/X4Wlfff2KTK0UPghSDNKktCUOuDXV87EF9v8AdCXUwQB/mX1DXRl1/l6wCZfabG0QIFDBSi1rChHUyr381d+QWTaTOfc+L7J0Fa5F+E63HphqLLhC4v0JsgQm0k9tTFG7mXNUFXb8G0WW05BOMS+IY7m+t2teIJVteipzcS1P6TuuRayDXk9rc1vfDeyPrWKaMYwuK6wV4zv9kp/yZPrsK3oX5zkf0hJDKv82EGx4IR+7vNGsvttM8csMMvJkACNEZt347ibtLscVt7PNJFqKgTJchYiqihVlDF+GoQv9dSL5DKBAfq1e6978WhvXUrHU7Dkq3I7tNtBAh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(2616005)(6512007)(86362001)(6666004)(2906002)(6506007)(6486002)(38100700002)(31696002)(508600001)(36756003)(8676002)(66946007)(66476007)(66556008)(5660300002)(31686004)(44832011)(8936002)(6636002)(83380400001)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpBck95cUpURnpFMDRWSHVuVE9HRzRoS2dvbjRCblBxb3l1UjZkNzA4WWwx?=
 =?utf-8?B?c3IrZzJWMFpOempjTWgycUtFNHUyWVRpalNSUU9JRFphNU45b2JXUGdUVEpR?=
 =?utf-8?B?NWFkRlZvTGRNTGFKNHRIUCtjTGxLMi9OSEd2b3ZsSzJMVUpsd21UanVSNlRx?=
 =?utf-8?B?WTB5YXBydVg2WGYwQ1pYTGozcW1DTVJqaGpoWHBYRVF2VUVJK2dLMXlmSGVL?=
 =?utf-8?B?OUVhYnhMelBldmRsK3Zjc1ExQzBoV2R2OVpUelcyQlFzNU8rVFp5SzNkbktN?=
 =?utf-8?B?bDFyM2NROHozTnk5TEo2bEV2MWZ4aWRaRFU5d3UxU09oNGkvWHNuUldaY3NZ?=
 =?utf-8?B?ZVRSdnVyZHFKSUtnK0IzdGhOMHBuNWkrdzV5cUFmUGZLWmRPZFUzWmhObTQ2?=
 =?utf-8?B?ZXRwMDAydzBQOEh6bXg3VGhyS2JXU3AybEJ1M1VRbXpXSEl4QVptUWZEcFNL?=
 =?utf-8?B?UU9XSVpPaWphTWNFSlJvTEIrR1VnNU85NzdPRkJFd3U2eFFybzJ0Rndxdmc5?=
 =?utf-8?B?RlZka1BrK1FVY0hITHVkZ2hVRXBLTDZraDhDSjlDQ2I1SkNvdGtBbDV5Nk5X?=
 =?utf-8?B?S0VOWnc1cE14MUs4RGk0QXBPTFAvM3M4SGw3R0t4aHMrMkJPbGVtTG4xSnFv?=
 =?utf-8?B?clMwVUJ1REJKSDlneEFBR1grN2t5di9LZkdpODlBWExGRmdkSy9PSlVnYS9C?=
 =?utf-8?B?bHphOU1KVVM0aU5yK3VITklFYnViWXVXKzBOSFdhK0UwMW8rcFZVeVMyakV4?=
 =?utf-8?B?ZmU5YkJsQTdLSi9mY0JIWUkrNEo1RVcwVXA0SGZKanBzdmJ6ZUpWNDB0NlhU?=
 =?utf-8?B?NG51VEl1NFhWOTRlWEhDSW4wWW1tNjcycjZDWGdnejFvOHJlblVCWFRyS2NQ?=
 =?utf-8?B?dWlYaE5BemFGZ0IycFFkeEp4MHVoWUxMbnZTaDluYzJ5ODBIdUdlQ1plK2hj?=
 =?utf-8?B?MHFzbnB1cjVwUmRqckxvd3AxNjNVMDJkSlJoVS83dzJDVE1oTXo1NktXOVpD?=
 =?utf-8?B?LzQ5elpmdlVxMjZOZ0VFODd5ZXFqTStCOGNTMHlCQUZiUlhMVTZ2KzBTcUpv?=
 =?utf-8?B?YU1iMG44MUluRjRIQUFqMHQ4R296dExtQjl5SWhIV1ZnZ0k3dTIwLzdCMGow?=
 =?utf-8?B?SmU5enZIaTFrRTNtN29oOXd5NDJrWXdZYThTU2pwMEc3OEEzSlRLa3BaMWVk?=
 =?utf-8?B?QW02ZFExdGdRVWhDVUZnL1djMXlMRUEzVUlxOUNpN1V6ZWlLMnVRVUNwRXcz?=
 =?utf-8?B?UXFPQWxzeU1Rd3ZoYm1qeXptL1c4dGpZVjRtbkN3TVd4NklWb2tSTEYwa3dt?=
 =?utf-8?B?Ymp3aGF3NTNSQmJmd0wwQXh2ay9QQ1g5NzdMb0VDb2l3ZWp2ZUFtZnVqVHAx?=
 =?utf-8?B?RGJEZndGUDN0WGVNdVFRSmxwcVpIYnl5MzJENzVkVjFyaTc2Q1Mya2FrblFU?=
 =?utf-8?B?YlNvZkVrOHNKVS9SanhYNEx0azVFbmNuYXJjRWtrKzBnODZxUkxYZ2VmS1dF?=
 =?utf-8?B?M0prdXlodUpSR20wMjVYam9qWkdjSEJZd0xpS0FSdkRJaVBHWnJReWtZSFhW?=
 =?utf-8?B?R1p2aE5nRTVVcWRzVlN1V1RGY0FSQ2pxc2xRTGQrNVRLaTFJMlNrR2RYL01L?=
 =?utf-8?B?WWFramhkWWJEQStLYldkZU1NRmhaem9KWUNMM0VNeFVsRlpUUE9DcjZqb241?=
 =?utf-8?B?dGxwWEg2VVZRWm1sMTVEclBIRVEzbTJ0eHZEZzNZNzBKSE9mVkdYeWFaMjRo?=
 =?utf-8?B?OFVkOGFhVTNBSjlkMXNxTzZZUVlvdWJGQWZFakxwbTBHL3JyemtkTW05YTdI?=
 =?utf-8?B?ZHM1LzNRUDhxckdMclhMR3VWNC9VYWxGZ2p5NkRreWo3U3RnbHFFSFJQamk3?=
 =?utf-8?B?bXNMckRnSklRL2x4S1dGRG1HVXBmM0lhZnc2YWJKRDc3RHlzZnIvazBmNklK?=
 =?utf-8?Q?k4+a5yfisRQPGcEWt4pUZsZAKLfJ69+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434996ba-2194-4d8c-5616-08da05ea3f41
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 18:41:26.9953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lztBR/talNHfJoYu2FWku4gOWsRfmcbH0vZgXRNO7ezmWDQHcfZeu0SBZ7cM7GERqD6LJkbWdoKqMMzvEpNUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3736
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

I'm not sure I understand this change. It looks like you will check the 
RAS poison status on every UTCL2 VM fault? Is that because there is no 
dedicated interrupt source or client ID to distinguish UTCL2 poison 
consumption from VM faults?

Why is kfd_signal_poison_consumed_event not done for UTCL2 poison 
consumption? The comment says, because it's signaled to user mode as a 
VM fault. But a VM fault and a poison consumption event are different. 
You're basically sending the wrong event to user mode. Maybe it doesn't 
make a big difference in practice at the moment. But that could change 
in the future.

Two more comments inline ...


Am 2022-03-14 um 03:03 schrieb Tao Zhou:
> Do RAS page retirement and use gpu reset as fallback in utcl2
> fault handler.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index f7def0bf0730..3991f71d865b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   				const uint32_t *ih_ring_entry)
>   {
> -	uint16_t source_id, pasid;
> +	uint16_t source_id, client_id, pasid;
>   	int ret = -EINVAL;
>   	struct kfd_process *p;
>   
>   	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>   	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>   
>   	p = kfd_lookup_process_by_pasid(pasid);
> @@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   		return;
>   	}
>   
> +	pr_debug("RAS poison consumption handling\n");
>   	atomic_set(&p->poison, 1);
>   	kfd_unref_process(p);
>   
> @@ -119,10 +121,14 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
>   		break;
>   	case SOC15_INTSRC_SDMA_ECC:
>   	default:
> +		if (client_id == SOC15_IH_CLIENTID_UTCL2)
> +			ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
>   		break;
>   	}
>   
> -	kfd_signal_poison_consumed_event(dev, pasid);
> +	/* utcl2 page fault has its own vm fault event */
> +	if (client_id != SOC15_IH_CLIENTID_UTCL2)
> +		kfd_signal_poison_consumed_event(dev, pasid);
>   
>   	/* resetting queue passes, do page retirement without gpu reset
>   	 * resetting queue fails, fallback to gpu reset solution
> @@ -314,7 +320,18 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		info.prot_write = ring_id & 0x20;
>   
>   		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
> +		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
> +			event_interrupt_poison_consumption(dev, ih_ring_entry);
> +
> +			if (dev->kfd2kgd->utcl2_fault_clear)
> +				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
> +		}
> +		else

Else should be on the same line as }. Please run checkpatch.pl, it would 
catch this. It's also good practice to use {}-braces around the 
else-branch if you have braces around the if-branch.


> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
>   		kfd_signal_vm_fault_event(dev, pasid, &info);

If you move kfd_signal_vm_fault_event into the else-branch, you can 
unconditionally send the correct poison consumption event to user mode 
in event_interrupt_poison_consumption.

Regards,
   Felix


>   	}
>   }
