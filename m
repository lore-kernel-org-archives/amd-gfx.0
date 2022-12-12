Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7DAC4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 22:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26683897E0;
	Mon, 12 Dec 2022 22:44:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C57897E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 22:44:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW5N/e6cHpfXVnWjZbGnYBFwzAXayofR0dn0EJnWOEyAacaIlbfF+M5xEloaTD773hOKQ7hVeu787y0yUQOz7S71tOXfuozglqef+KKksYD55J0hKr0XGYa0zMLWaCCvPXrTSyhCBDdUIak8qx1yYSBoXpoQIsu0MePv3ZuRL7wO/UphjHJrmVEAnw8HHfy0myX1xWlv3VuKVD/I+zDyCHMVzgM15Ap29XIy5Co7No7SGnjMFO51kVuBmiL9BKbqjHh7nHB/Ln7+P6ngRz43kMqX2aK+loaESHyqoEMCygVO3v5HnRcQ0N3xc8WdRorqkkeX7RDPIkdLCgdeg9HP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GZ3m6KEGPuZBjuxnamYkn7CeGBnjvOFoxa5E8fWDqQ=;
 b=HMyBmKCgpbCl7BznnmCSCh7d33EtClQkLbLqjwHn+iwwXpdvgKfvlrlCsma9oXlh+Mk8eCSHg3EzqhsZXjNAEhcLXymlYAeX+IkQENk1aFsh/90aWZH1Nfs48dRVjP7Ry70rImFjk/+5VR6GJsKTGZbA3GZ3yNMuo6O2INHaFqupsoeaBSzuSzyGVAIP1BfkDQXgcet6YLJlFhsr/B9oEP2G/9LVZhyD7PBXz91yJxzPjBNGz8PU3W19UcwllMtxQmiQgysZDXyUYaq7h9/pLDs7Wvn3Hvp2V8AKH7NiPCgawyhiMwgkuNXC9Qn3NOqzy0IEYemvk0rsKpj/ZqfLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GZ3m6KEGPuZBjuxnamYkn7CeGBnjvOFoxa5E8fWDqQ=;
 b=qMx/LzSwFWi7iR43iYolpaSVTO7tP7NYeXS7ZC0TSiayxzSxDOh8AAG+Gk2S47CfN6OFaG52fIGtxLwy9nt6kJzfbrcmgzYiEjCgixcv1U74HDyxod75YsnBoMfNvlFAObVc0QALKdDcmD7ZYM1aSrMJ56P6bA/R3OjWze4s8FA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB7987.namprd12.prod.outlook.com (2603:10b6:510:27c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 22:44:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:44:19 +0000
Message-ID: <ab5a0799-90a1-446c-c1dc-431343f56bf1@amd.com>
Date: Mon, 12 Dec 2022 17:44:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable IH retry CAM on GFX9
Content-Language: en-US
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221212171055.999548-1-mukul.joshi@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221212171055.999548-1-mukul.joshi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: d758bc72-c7ff-4177-b78e-08dadc9267b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A3zI4/s2qOVp0rSMtTQaz/a0Xu0XTJuFMsy97L2GmAJchxWEMJWrluGxW8YjGmP/u8NsIDo+HQSzm+A/IvPcsWaXEPvs+FUEFtQQ9zrUyyOrT7wbXWdcfnucHSDMKOpTIbD+atIO0+YIP4mNq8qxQS8hrlsL+NqlHUv2N69syiHjcqHZ46WewkKwWVH4uCFgekL0NFPUZYzYRON4Z5gj8kbKb5AARjo/IpbwzdMMQFsod4mUsyyuaC8d2T57AwVcsyww/v9fl8il9N3c84jrSZ/2AJTXj8kpYJgWMpbvrtXmjO5uLil6ttD7o8T16IfVCbO/KnYWqBSncQ06CKdlxeNaAoNTyAOtjbz7SsG+g9B+qbZaTFRdlKPiIa9D2ZSjL2pVCluonq7FnBO2ffETwSgaQFAJD24nHOA7ffbtiU3kgbaZWZNZNH7W6A31IKr5uXXIDQCJofyhL/drfmsJsoexI59fmsmWGiE9XyuAaDtn8d7+shzUpTsTGn67YmgjP8lsJcYxAQq4j+r8q32mO37Uz/tzuDKsuQY++cbRC5ol6apuKAaQEeNSQczQDGQ6hnryKuwE9XGZlgzRC73HtzA1mc+7z1MRJFsCbB6WGNTXb0IUhoL1CFIOEd4b/7B8f8XYelbNHCVfm1Uzc8ubXzI7USrVqVXkPq3VrYoAl6uIDsd145YDW8WT+xLk1C2eLaNl8OZmzDD0+s18Xiuqk+KK1ZkINqarii1vPVPEO+Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(478600001)(5660300002)(31686004)(53546011)(6486002)(6506007)(36916002)(26005)(6512007)(36756003)(8676002)(2616005)(66556008)(66946007)(66476007)(8936002)(316002)(186003)(41300700001)(86362001)(38100700002)(31696002)(44832011)(30864003)(83380400001)(2906002)(4001150100001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGdGZU9OeHZRUjNxMC8vaytKNmpBa1JsMmM4VTBZdmVualBKd3pKSDI1Unlv?=
 =?utf-8?B?WjBHNDZrVCt1RjJtdGRuRTRHcElzZU83QU9BdzdLbUJhRHZnQUdyV05sbDBD?=
 =?utf-8?B?bHE2ZmprM0tqSmhZMy9HcHRoNzlnTjIzTVMrcm1tdk1aVk1rQTg5VnovdXR2?=
 =?utf-8?B?d1FZS3dFQ1JqUm9ReXJkSGNVdlYxUXNETXM1ZmRTeFdOL0wvcFowMSs1cVJS?=
 =?utf-8?B?eHBka1RER2djTTB2bUN1MitRajN6ZkVmdWVacm1xSVBQUTRVMkhhaFRaUGZW?=
 =?utf-8?B?bms2RVZVUDNRaTZsMjE1VXRzckFsYzZKRkExZUN1UEJVNkIyblF2RUNJQlZU?=
 =?utf-8?B?S3M4MDFsNUxLUzBVOFltQkwxKzZsamF4c25ZMkpDMnpaNEpITURDY21EMTV6?=
 =?utf-8?B?Y2lGeTVpd0ZpR3I0Q25keEFmRHhLSDBOQ3E2WCtYenJKc29MSHRKZEV3b3ht?=
 =?utf-8?B?N2c1RDRuQlE2QUN4cnZRU2JEZHhMWlhDZjFVU1FEN1R4MUp3MTV0eXpEUVJ5?=
 =?utf-8?B?S1BneW5QZHBXVGlPRG45dnBnSm83cHNtdlZFTU9DMDc0b1Q1a09PQ0g0UGhl?=
 =?utf-8?B?L3FUTmdqQnNsU2Z3aUxvby82NmdMZGMwNHJzeFB4SlM4K3RoRmVVYmpSYlJw?=
 =?utf-8?B?MzdVOVFZcUthWVdLMk5xbFhVRWVVRElyWVczd0NQNGVETjRqWlJTaUwzMi9a?=
 =?utf-8?B?RmdIT2taUzdzZDVxbHlkZVpIeXRwQmltZG1ITlRJeGJHWllicW1ZNmdVVTVF?=
 =?utf-8?B?aHFSR0RUTVkxeTFlZzExYXVrRzJBRXBqbnVyZm1wcnd3R2JKcnF1NHdLTGFH?=
 =?utf-8?B?bmFsRml6dDJQdi9IVllqUDlHRXVlWFV4alU5amRPcWFXQUlXOEx0SzQ4UC9k?=
 =?utf-8?B?eURhNmNEamNSd08xdGtSNjJZd2hWZG01cTdJWEhCQXEzUWsyLytVakxkQnd2?=
 =?utf-8?B?WDcvd2RwNGloa3BwVTZ3N2kzOHlZSlVhQkxReFF2RzdjQ1NMaG1yTDhaaHI0?=
 =?utf-8?B?em1jOVBFNmZ1aWorSDlmTGdxejY2anlYc3p4Ty8rOXV0dTdqdUkwRXZKVUd6?=
 =?utf-8?B?RUxjMEVqN3FXYVczbGZ3TGhlQlV5ejBQWlZRZ0w2dXNhbHdOQ3RnTTdJSFJL?=
 =?utf-8?B?ZUtScitvWFJJbnZzdmhYRXRGZlJYbHM5UUNCQUIwM0ovV2lNWGNzcG5iZ2pB?=
 =?utf-8?B?TW1wMVh1K29ibG5oSzJiM25pZmllcFZPMmQ3SXdNb2xTZHFSUXJkNnpKVmtk?=
 =?utf-8?B?VkNGN2xKV0JMOVVEZWkwWkNaNi80akt4eWFhdHVCZHFIdko3WlFNT1lLT1ow?=
 =?utf-8?B?dUtQMXlaeU9wYndEZGg4a3d6TUo5cjJsS3U2aUxtNnZrUmQ2aUJ1cjZNVnZo?=
 =?utf-8?B?WkxLSDlzWTVMdDZSRndNeS9aS0ZJUFE4V2xpUmM1Z3d1bzF3a2hPa0prM2RB?=
 =?utf-8?B?RFZ6dEhlSVBXS1NRYlE0KzAvdndlK2g0STJMeU5VRTNUckpRRkhjZDNmek1t?=
 =?utf-8?B?b2NkVng1RWhzMTFCSW5sWllUNnpRWDNmd25qUW1jWm5obXRQa1hZclV6ZUlV?=
 =?utf-8?B?VUNsK1JPTlR4Q3piTXU1N3o3NndxUk5zWWwxWXNSeVppUW1jaU5Dd3pFU1Jk?=
 =?utf-8?B?SFRtQmcvd2lYWFhZV3owZllhekpVRStUWHFlQTJkRXFZaDN5cTg0eityRWFX?=
 =?utf-8?B?NUR5WlllRktPVWhJUmpwSytnTXZBU1ZnUy9GcmdQZlh2akxuUWgyeXpZL21p?=
 =?utf-8?B?RFk5KzYvdXNveS9EZEVDQSs5d2k1R2VzOEN1VXZuNTlvWnlxakVwWHhZZnpt?=
 =?utf-8?B?Ri94R2svZ01rSjR6TWloMzMyTUtLMGZscmc1cVFCaG91OEZ3Njh1aU9FVkYv?=
 =?utf-8?B?MnNDZXhpVGFMNHpTdENTYkJGdXdsUGhrNFIvQ05yaVZ3L2hYektpbVFhUjVq?=
 =?utf-8?B?eDM0VFh5ajhsdFI3OUZBazJPK2U2R3d2M2hTQmpWZ1A1cWFRaUxxcW9DRTVx?=
 =?utf-8?B?MUNtTlMwSjhqMnhCVmFaZEtQN2dBbHcxUW5DcktBRUlyKzJaSWQwU3dTcGY2?=
 =?utf-8?B?aXdQM2Y0WThCOGNpN3RwQ1VqSmdhTzRoNTdpWEFNVnovdkZsd1owc0dtTFZv?=
 =?utf-8?Q?dTd5DOymTy2hB4Bk61UgSv61z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d758bc72-c7ff-4177-b78e-08dadc9267b7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:44:19.0713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4S8Xa2VPBVHNzUOn0mN7+iMTGclCjpP56BkIT4Tyv1Hs+h9jL8JloxgrROFRAVj614N2vWKs2/potVTf7+ZJnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7987
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


On 2022-12-12 12:10, Mukul Joshi wrote:
> This patch enables the IH retry CAM on GFX9 series cards. This
> retry filter is used to prevent sending lots of retry interrupts
> in a short span of time and overflowing the IH ring buffer. This
> will also help reduce CPU interrupt workload.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h       |  2 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 51 ++++++++++++-------
>   drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c        |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vega20_ih.c        | 46 ++++++-----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
>   .../asic_reg/oss/osssys_4_2_0_offset.h        |  6 +++
>   .../asic_reg/oss/osssys_4_2_0_sh_mask.h       | 13 +++++
>   7 files changed, 75 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> index e9f2c11ea416..be243adf3e65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
> @@ -98,6 +98,8 @@ struct amdgpu_irq {
>   	struct irq_domain		*domain; /* GPU irq controller domain */
>   	unsigned			virq[AMDGPU_MAX_IRQ_SRC_ID];
>   	uint32_t                        srbm_soft_reset;
> +	u32                             retry_cam_doorbell_index;
> +	bool                            retry_cam_enabled;
>   };
>   
>   void amdgpu_irq_disable_all(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 08d6cf79fb15..e5ab84f3e072 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -537,32 +537,49 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	const char *mmhub_cid;
>   	const char *hub_name;
>   	u64 addr;
> +	uint32_t cam_index = 0;
> +	int ret;
>   
>   	addr = (u64)entry->src_data[0] << 12;
>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>   
>   	if (retry_fault) {
> -		/* Returning 1 here also prevents sending the IV to the KFD */
> +		if (adev->irq.retry_cam_enabled) {
> +			/* Delegate it to a different ring if the hardware hasn't
> +			 * already done it.
> +			 */
> +			if (entry->ih == &adev->irq.ih) {
> +				amdgpu_irq_delegate(adev, entry, 8);
> +				return 1;
> +			}
> +
> +			cam_index = entry->src_data[2] & 0x3ff;
>   
> -		/* Process it onyl if it's the first fault for this address */
> -		if (entry->ih != &adev->irq.ih_soft &&
> -		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
> +			ret = amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault);
> +			WDOORBELL32(adev->irq.retry_cam_doorbell_index, cam_index);
> +			if (ret)
> +				return 1;
> +		} else {
> +			/* Process it onyl if it's the first fault for this address */
> +			if (entry->ih != &adev->irq.ih_soft &&
> +			    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
>   					     entry->timestamp))
> -			return 1;
> +				return 1;
>   
> -		/* Delegate it to a different ring if the hardware hasn't
> -		 * already done it.
> -		 */
> -		if (entry->ih == &adev->irq.ih) {
> -			amdgpu_irq_delegate(adev, entry, 8);
> -			return 1;
> -		}
> +			/* Delegate it to a different ring if the hardware hasn't
> +			 * already done it.
> +			 */
> +			if (entry->ih == &adev->irq.ih) {
> +				amdgpu_irq_delegate(adev, entry, 8);
> +				return 1;
> +			}
>   
> -		/* Try to handle the recoverable page faults by filling page
> -		 * tables
> -		 */
> -		if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
> -			return 1;
> +			/* Try to handle the recoverable page faults by filling page
> +			 * tables
> +			 */
> +			if (amdgpu_vm_handle_fault(adev, entry->pasid, addr, write_fault))
> +				return 1;
> +		}
>   	}
>   
>   	if (!printk_ratelimit())
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 19455a725939..685abf57ffdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -238,7 +238,7 @@ static void nbio_v7_4_ih_doorbell_range(struct amdgpu_device *adev,
>   
>   	if (use_doorbell) {
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, OFFSET, doorbell_index);
> -		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 4);
> +		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 8);
>   	} else
>   		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range, BIF_IH_DOORBELL_RANGE, SIZE, 0);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> index 1706081d054d..ed41f96b251f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> @@ -251,36 +251,14 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> -/**
> - * vega20_ih_reroute_ih - reroute VMC/UTCL2 ih to an ih ring
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Reroute VMC and UMC interrupts on primary ih ring to
> - * ih ring 1 so they won't lose when bunches of page faults
> - * interrupts overwhelms the interrupt handler(VEGA20)
> - */
> -static void vega20_ih_reroute_ih(struct amdgpu_device *adev)
> +static uint32_t vega20_setup_retry_doorbell(u32 doorbell_index)
>   {
> -	uint32_t tmp;
> +	u32 val = 0;
>   
> -	/* vega20 ih reroute will go through psp this
> -	 * function is used for newer asics starting arcturus
> -	 */
> -	if (adev->ip_versions[OSSSYS_HWIP][0] >= IP_VERSION(4, 2, 1)) {
> -		/* Reroute to IH ring 1 for VMC */
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x12);
> -		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, CLIENT_TYPE, 1);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
> -
> -		/* Reroute IH ring 1 for UTCL2 */
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_INDEX, 0x1B);
> -		tmp = RREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA);
> -		tmp = REG_SET_FIELD(tmp, IH_CLIENT_CFG_DATA, RING_ID, 1);
> -		WREG32_SOC15(OSSSYS, 0, mmIH_CLIENT_CFG_DATA, tmp);
> -	}
> +	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, OFFSET, doorbell_index);
> +	val = REG_SET_FIELD(val, IH_DOORBELL_RPTR, ENABLE, 1);
> +
> +	return val;
>   }
>   
>   /**
> @@ -332,8 +310,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   
>   	for (i = 0; i < ARRAY_SIZE(ih); i++) {
>   		if (ih[i]->ring_size) {
> -			if (i == 1)
> -				vega20_ih_reroute_ih(adev);
>   			ret = vega20_ih_enable_ring(adev, ih[i]);
>   			if (ret)
>   				return ret;
> @@ -346,6 +322,16 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
>   
>   	pci_set_master(adev->pdev);
>   
> +	/* Enable IH Retry CAM */
> +	WREG32_FIELD15(OSSSYS, 0, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
> +
> +	/* Allocate the doorbell for IH Retry CAM */
> +	adev->irq.retry_cam_doorbell_index = (adev->doorbell_index.ih + 3) << 1;
> +	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RETRY_CAM,
> +		vega20_setup_retry_doorbell(adev->irq.retry_cam_doorbell_index));
> +
> +	adev->irq.retry_cam_enabled = true;
> +
>   	/* enable interrupts */
>   	ret = vega20_ih_toggle_interrupts(adev, true);
>   	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2dc3b04064bd..747adad7e0d8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2162,7 +2162,9 @@ static void svm_range_drain_retry_fault(struct svm_range_list *svms)
>   		pr_debug("drain retry fault gpu %d svms %p\n", i, svms);
>   
>   		amdgpu_ih_wait_on_checkpoint_process_ts(pdd->dev->adev,
> -						     &pdd->dev->adev->irq.ih1);
> +				pdd->dev->adev->irq.retry_cam_enabled ?
> +				&pdd->dev->adev->irq.ih_soft :
> +				&pdd->dev->adev->irq.ih1);
>   		pr_debug("drain retry fault gpu %d svms 0x%p done\n", i, svms);
>   	}
>   	if (atomic_cmpxchg(&svms->drain_pagefaults, drain, 0) != drain)
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> index bd129266ebfd..a84a7cfaf71e 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
> @@ -135,6 +135,8 @@
>   #define mmIH_RB_WPTR_ADDR_LO_BASE_IDX                                                                  0
>   #define mmIH_DOORBELL_RPTR                                                                             0x0087
>   #define mmIH_DOORBELL_RPTR_BASE_IDX                                                                    0
> +#define mmIH_DOORBELL_RETRY_CAM                                                                        0x0088
> +#define mmIH_DOORBELL_RETRY_CAM_BASE_IDX                                                               0
>   #define mmIH_RB_CNTL_RING1                                                                             0x008c
>   #define mmIH_RB_CNTL_RING1_BASE_IDX                                                                    0
>   #define mmIH_RB_BASE_RING1                                                                             0x008d
> @@ -159,6 +161,8 @@
>   #define mmIH_RB_WPTR_RING2_BASE_IDX                                                                    0
>   #define mmIH_DOORBELL_RPTR_RING2                                                                       0x009f
>   #define mmIH_DOORBELL_RPTR_RING2_BASE_IDX                                                              0
> +#define mmIH_RETRY_CAM_ACK                                                                             0x00a4
> +#define mmIH_RETRY_CAM_ACK_BASE_IDX                                                                    0
>   #define mmIH_VERSION                                                                                   0x00a5
>   #define mmIH_VERSION_BASE_IDX                                                                          0
>   #define mmIH_CNTL                                                                                      0x00c0
> @@ -235,6 +239,8 @@
>   #define mmIH_MMHUB_ERROR_BASE_IDX                                                                      0
>   #define mmIH_MEM_POWER_CTRL                                                                            0x00e8
>   #define mmIH_MEM_POWER_CTRL_BASE_IDX                                                                   0
> +#define mmIH_RETRY_INT_CAM_CNTL                                                                        0x00e9
> +#define mmIH_RETRY_INT_CAM_CNTL_BASE_IDX                                                               0
>   #define mmIH_REGISTER_LAST_PART2                                                                       0x00ff
>   #define mmIH_REGISTER_LAST_PART2_BASE_IDX                                                              0
>   #define mmSEM_CLK_CTRL                                                                                 0x0100
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> index 3ea83ea9ce3a..a0cc5ecfa161 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
> @@ -349,6 +349,19 @@
>   #define IH_DOORBELL_RPTR_RING2__ENABLE__SHIFT                                                                 0x1c
>   #define IH_DOORBELL_RPTR_RING2__OFFSET_MASK                                                                   0x03FFFFFFL
>   #define IH_DOORBELL_RPTR_RING2__ENABLE_MASK                                                                   0x10000000L
> +//IH_RETRY_INT_CAM_CNTL
> +#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE__SHIFT                                                                0x0
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE__SHIFT                                                0x8
> +#define IH_RETRY_INT_CAM_CNTL__ENABLE__SHIFT                                                                  0x10
> +#define IH_RETRY_INT_CAM_CNTL__MM_BACK_PRESSURE_ENABLE__SHIFT                                                 0x11
> +#define IH_RETRY_INT_CAM_CNTL__GC_BACK_PRESSURE_ENABLE__SHIFT                                                 0x12
> +#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE__SHIFT                                                       0x14
> +#define IH_RETRY_INT_CAM_CNTL__CAM_SIZE_MASK                                                                  0x0000001FL
> +#define IH_RETRY_INT_CAM_CNTL__BACK_PRESSURE_SKID_VALUE_MASK                                                  0x00003F00L
> +#define IH_RETRY_INT_CAM_CNTL__ENABLE_MASK                                                                    0x00010000L
> +#define IH_RETRY_INT_CAM_CNTL__MM_BACK_PRESSURE_ENABLE_MASK                                                   0x00020000L
> +#define IH_RETRY_INT_CAM_CNTL__GC_BACK_PRESSURE_ENABLE_MASK                                                   0x00040000L
> +#define IH_RETRY_INT_CAM_CNTL__PER_VF_ENTRY_SIZE_MASK                                                         0x00300000L
>   //IH_VERSION
>   #define IH_VERSION__MINVER__SHIFT                                                                             0x0
>   #define IH_VERSION__MAJVER__SHIFT                                                                             0x8
