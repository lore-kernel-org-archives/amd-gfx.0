Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE76C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 22:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6082E10E60A;
	Wed, 29 Jun 2022 22:44:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B57910E60A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 22:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjCeHuYbX0kbxkEhkea4n5VyY9glDGTll0w4G/kR+ZYBgmOtYQZTZKw24S/P1mPB2q3kQAv+68cGPWiGwTuwb2UCCLWin4IxzMICqSpaLHJOqbvYDGTa5gjnXPGE5xmqQ3d/KPxK+xYOTAd6kq/5vpvN8Zu/3rBXx3zWKVpBEW7xdpGvBQ6zhqlR1/x8Pp6U4JZrKUM735QCm7MD93BF3vvu3UA80tKrAlKqc1JhwPLOs1H/Ei39x+ZGCbp8cKymlUWkw73lfPAb2e9MSqVv1RXENP3o6UQIpDhHuAViQeNgieuyE6pylfcBtc+EPphKEzBFFNMlp79EfzOcUfpv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuIUmOfEQTEK2qqmjmHAUELdfXnxDoOP/1n4++BmI1M=;
 b=a8VWKkRKRI/wjmB22a3I0kAxNp8pW+hPLZST3RX2frdd6T7/ZKPK9M+BTglB4vMdEmeceRoHUzDZnRaHD8n6hntfEHAYSNuzs392owSTLrKLiGORmXVyotafzI9APJhWn9T8lZifi6gJKPCiNjF0RdBFP2wj5kN8Q58nH1hisn1mm/iKjDkARDxLvhIdA/wX3Hx2PcML1vP7BVuS32/xIyUUSMKZw5HA40bgy+wsBoL1w1U1EefZw7sepUlESzFJUfhama+jYul3tVYI3iIiq4d3ZeIG8700baA4cwKTQvS6iPCmie3kdSJ7PcFKJViqgf3liphdXFA86Jq23fAfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuIUmOfEQTEK2qqmjmHAUELdfXnxDoOP/1n4++BmI1M=;
 b=yz8PcdBPVLmODwn6s1m9cV2iySDZflACtUT2iM0j5WSEtK9hNhUH6yrzf6mQDJJqIIoRhMLW/cR5HzRnZ8glu1+ZlMUDPF+P0gBV51hSKZx4uVIqmPHLFI6yMDDvYPCc5AriGtRA1LOb8+TEyUKIvVTd6QjQSW/TPO5TlgaaoHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5387.namprd12.prod.outlook.com (2603:10b6:610:d6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 22:44:34 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 22:44:34 +0000
Message-ID: <77ea2262-86f2-9ef0-b99d-14de2c772a50@amd.com>
Date: Wed, 29 Jun 2022 18:44:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdkfd: fix cu mask for asics with wgps
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220629181623.741918-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20220629181623.741918-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0044.namprd18.prod.outlook.com
 (2603:10b6:610:55::24) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27e63ce0-9b86-4277-ed53-08da5a20f037
X-MS-TrafficTypeDiagnostic: CH0PR12MB5387:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NX6UDxMqacwqN/qQb/XAyUvBAFzQ3JpuQ3HN4wMBHEVoHkf9bfcg2tdPtYfkUUBNRi/qtLDApU6osJ3QIFb7lZTxRZpN1SChy67sujfXgwWO5AqwKhSloazMLQjoK0fC3/zRQK69nHttGZK6eK4LSffRTW+JSKXV+b/8sBVWULDAQejEU1QfrMWICjAYq5sw90ziTvpmQAJJwK3eJNRzUcahbakHGv2YXatvqafoz0aQXUjndRtipaC1f5oH+KfCQY9TXvJYla1RtfQMz39vwLHudZtYgdAkADtQNwJM3l+CW+jaOLQKLsjZ12IjQ3L9LYRUTwtYjYUXlO2U2rSIH71LTLVko47WTR/fo7TI1Z40ycexP9tF846GQhxKmuGHnEYg/JfqrNnZM1aGT4SlrtALeEwX7Jm/ZYvUQ72M2aJBCbkUhkmEdQGIBXFqgi057djTAZCfhAnvZ/dNM/Y52B4mWXL02hCPpQ08p30ZNCFazNL+/rM+gtsOv5cxYVY4y+1U0Twd3HaXLIkuAMc8/zyLRlgnAvmw/TV7UlvmKyzFs3TCW2aT2+8S3yj2U5zcmkfEthZXDqCg1vBUpF3FmFQaS+2SJ7VYvvHkrIG46fVrMenAjROuEPMqW+IK/xFtscuXYhSPv3E8uGFrLplEpcLitpe+eCpMmpAMzX4s40UWmhOmJ6ECOG2GLJforXgmjWeODbW6Urq6EpBUKOgBFnKNC2lHTHtFVYN6X2leKJ3MyYWZ4LJZxN7c8iXNwdwEiV2sA7YXIT6dGjk/gG4cF5FQwNK82vwxw4ZJccb6PTO3eH2kABe/lGbP3qpXnqpqMjL1z1YeHeGPA/TwnR0Xmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(186003)(8676002)(66476007)(66556008)(66946007)(6512007)(26005)(2616005)(31686004)(36756003)(83380400001)(6506007)(53546011)(36916002)(38100700002)(86362001)(31696002)(2906002)(41300700001)(316002)(44832011)(8936002)(6486002)(478600001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlVYVlV6UGpubk5henNZRGFaeWZDSDRkekh1WldhLytsVkJVdmZTM25IaXFr?=
 =?utf-8?B?elBIbTMvWVRBSUxPQVBkU0o3L0lsUUM0Zmh1K01CUnRoS2xnRFc4NXFvd0h2?=
 =?utf-8?B?a2FyY01OcS9WMU5waEYzd1pCZFlqdGt5bnR6S3U5eHZFYzFVeXdUN09NZnNn?=
 =?utf-8?B?OGh3K01QbnpGYU56dzFIUFREbWx4cE1kUGxrNU9jN1U5VFdES1dIWmpUdGls?=
 =?utf-8?B?K3R2dzMwVlF1NFZvWmhwL0N1QjhWcVlQRktWa0h6d3hIRFZzWEJtb3VuSGpF?=
 =?utf-8?B?Zzl6SkNXZys0QzNUU1J6clo1WFA1bzhUOUdsYTZ4WUhoQ3ljVUdLN2FDQ01U?=
 =?utf-8?B?QTBob3JKWUF6eW1CWnJzMk9yT2VkRDhKK3Z2Qk8xTlVqaVNyZjlmMGNDSDRn?=
 =?utf-8?B?eXNCUUdqOWx3VjYyZXRTbElzYzI0Ni9jWnVnZ3l0cHVNOFdJeVVVZ21VbjFP?=
 =?utf-8?B?Ulk4clo0elo5OFpsdTJ6SHNoQ1pRSnZ5NzN5b1I3LzdITDgwbUdvMTh3RVJt?=
 =?utf-8?B?bXIwSlowd3hHeVRlU0hVc2VuZFczanJCa3JYSHMzRWNROG9FNFhZTzNKMWRn?=
 =?utf-8?B?QUkwVzFyMzk1ZXB2NExja0FqZjh5VE4ySjRHQ0txYjVJbDhHRTcybklIV0p0?=
 =?utf-8?B?SmlxdHVsaGNtZWFubHBYaGQ3SzVqNjlBMXVMUXc2aDBTYm9vUXlDV1NiZU0y?=
 =?utf-8?B?Y0FvTzB0alFJQi9xd21pZWxSWWlKR2EyK1F5WEdhWXJkSnk2bWx0SG9UVzlh?=
 =?utf-8?B?djVtQ1NoQzU1cHN4SGZDNHMvVitPUFNacnN1d0Mwc3JRZkRzQU5GdzA0SVR3?=
 =?utf-8?B?K2IrSjVDYk9aeGdHdldkSk9TakV3Z2tkZzVVZmsySHR5WmY2SElTQk5pOG5v?=
 =?utf-8?B?QlNISDMwTFd4T3hEVWc3K3lqSDFZUVRaY2FzY3Y2eXNCN1J0WUJaQVVFUitT?=
 =?utf-8?B?R0FlbzhUSjJyTG1KN25tYjNRclpIeEd3dEg0clpaWmgxOUtkV2IzSzluSTMv?=
 =?utf-8?B?RHhpVGtUSTNpWjlEUHB6c3o2NnVMZkJDb0NRdXhnL2V6UnY4Y21XaEhId2NK?=
 =?utf-8?B?MU5QVVBIdTRwT3ZEUWREc1UrYVZDaU1kSlZIUUhEbE04em82a29DdzBhUFpD?=
 =?utf-8?B?OVRYUDFvaVJDZ3cyRTFLclNCU1B3YVNJcmtQSzA5WFh5Y2xaWlc5WFFwMGRW?=
 =?utf-8?B?NlBEOUtBZ3JLVmNhOTNoOWJoOFprYU9vcmZUMmJ2cTEyMFVKNzhKTFplK2Z4?=
 =?utf-8?B?M0Ezd0xISTl6ZnUwcSthVCtSSURpSmlLR3ViZUtQWWlScUdFSXY0bWVybjZ0?=
 =?utf-8?B?VGNaYVBkK1BhNk1URkoydWUwS3ZsSjdyQnhvOEROajJKOWl4YU40MTdpSk8r?=
 =?utf-8?B?ckoycG4wZjVRU0Y2cVRNNkZqWlJQTDVsZkFzSWw2YkIwMEZqODM5Z3ZGRi9o?=
 =?utf-8?B?MXF2TURJSFhYZXdOVGx6bTJPdWYwTUVSa3RqZjdmTWtJd3hmV3A0VmhzdmtB?=
 =?utf-8?B?bjdqeW5RV0xkUEx6R0dXc21jUnFIeUFPanJMb0pzdjkwaHg2S3BOMDB5RDBq?=
 =?utf-8?B?USs1SmgvU1F3d05hWW4vcG9rN01lelBCakI5UVNLVnpObC9rSXR3RVdwOW5U?=
 =?utf-8?B?SjNnT2VaZGdXd0xRMjZ0WUdScy8rYXZndUhITHBGTDlyM1ZmcU16S21CaElq?=
 =?utf-8?B?QUhRYzFHL1RFdDRzUHY3T0U0U3FCbTBUZFpTV21rdHE5RDBWa0Z5WlFicnk5?=
 =?utf-8?B?UXArSUR5VXhuYTVDTkExVzZyem50NElwbnJLNzJUVS93WEFJcVFjVWpkdWpF?=
 =?utf-8?B?NG54dmdzY2dwS0lNYXI4dGNNV0VCWXFCYWpURm1pcU10OUFPK2NiVExvWHF3?=
 =?utf-8?B?UFRhaUlSS2tKenQ5RlhsdHc4UVBZQ3VqOEozeUJjMGpWb3Z0aTUySSsxZFNL?=
 =?utf-8?B?WUtiVWM4MDdpbXBpVDgrNy8zR2JWVmdOcjFlSFB5dHIxZ2s1SjR4dXVWcHg1?=
 =?utf-8?B?eTVJQkNmWlhwL1VwM3hYZStGb2JWU0RKQnY1aW5QOXlISitoWGp0SHBEY05y?=
 =?utf-8?B?cGJNcHZjYnZqOUY0V3pvenRQZzlrUWhmUUZMQ0RCdXU0TitiL1NPVHE4Q3hK?=
 =?utf-8?Q?HuhiXAHOmHJsFzSgxI0LDFyuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e63ce0-9b86-4277-ed53-08da5a20f037
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 22:44:34.3715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycFo+kg3CY2e+Orj3ExFpoQP32pcuYOb1U9PDGaC0Dh7AsRySgvgxvZoeI8kN03HAEcnUVySONL7lYwMkifNHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5387
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


On 2022-06-29 14:16, Jonathan Kim wrote:
> GFX10 and up have work group processors (WGP) and WGP mode is the native
> compile mode.
>
> KFD and ROCr have no visibility into whether a dispatch is operating
> in CU or WGP mode.
>
> Enforce CU masking to be pairwise continguous in enablement and
> round robin distribute CUs across the SEs in a pairwise manner to
> assume WGP mode at all times.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Looks good to me. Three nit-picks inline. With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c      | 12 +++++++-----
>   .../drm/amd/amdkfd/kfd_process_queue_manager.c    | 15 +++++++++++++++
>   2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index 49a283be6b57..7febd1e69d13 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -100,7 +100,9 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   {
>   	struct kfd_cu_info cu_info;
>   	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
> -	int i, se, sh, cu, cu_bitmap_sh_mul;
> +	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
> +	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
> +	int i, se, sh, cu, cu_bitmap_sh_mul, inc = wgp_mode_req ? 2 : 1;
>   
>   	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
>   
> @@ -167,13 +169,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
>   		se_mask[i] = 0;
>   
>   	i = 0;
> -	for (cu = 0; cu < 16; cu++) {
> +	for (cu = 0; cu < 16; cu = cu + inc) {

cu += inc


>   		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
>   			for (se = 0; se < cu_info.num_shader_engines; se++) {
>   				if (cu_per_sh[se][sh] > cu) {
> -					if (cu_mask[i / 32] & (1 << (i % 32)))
> -						se_mask[se] |= 1 << (cu + sh * 16);
> -					i++;
> +					if (cu_mask[i / 32] & (en_mask << (i % 32)))
> +						se_mask[se] |= en_mask << (cu + sh * 16);
> +					i = i + inc;

i += inc;


>   					if (i == cu_mask_count)
>   						return;
>   				}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index c9c205df4a14..fc0416f6f83e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -498,6 +498,21 @@ int pqm_update_mqd(struct process_queue_manager *pqm,
>   		return -EFAULT;
>   	}
>   
> +	/* ASICs that have WGPs must enforce pairwise enabled mask checks. */
> +	if (minfo && minfo->update_flag == UPDATE_FLAG_CU_MASK && minfo->cu_mask.ptr &&
> +			KFD_GC_VERSION(pqn->q->device) >= IP_VERSION(10, 0, 0)) {
> +		int i;
> +
> +		for (i = 0; i < minfo->cu_mask.count; i = i + 2) {

i += 2;

Regards,
   Felix


> +			uint32_t cu_pair = (minfo->cu_mask.ptr[i / 32] >> (i % 32)) & 0x3;
> +
> +			if (cu_pair && cu_pair != 0x3) {
> +				pr_debug("CUs must be adjacent pairwise enabled.\n");
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
>   	retval = pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
>   							pqn->q, minfo);
>   	if (retval != 0)
