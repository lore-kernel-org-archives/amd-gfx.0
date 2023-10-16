Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98806CDB465
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 23:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036E810E1C2;
	Mon, 16 Oct 2023 23:20:58 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 353F510E1C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 23:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki9e6KdPvU32h55VZ6lC0Palc48hg7KdrcvtzbyMy4st3e86lR7fDf3TIR/cvd4XrQiKAKvQog2BJpIwyiVpOXcder53kbkHe43YJBpAmv4FlWB+ukxUzm3Xnv3oeuC9n/krW7jqzYKZ9Ix3IPk9M1kBQDppBcEtff8KwCm1MArT52a3ugT2ihHlq1Q1j3Y/d1kKJbfxL5UMa5ta7MBhG1LLyjbijrX0OwWwgjJe1uEkkgGLBkx9m+9UFum9aZMxXvAKZRUd4hfbjBpyaSGTw5O5dczW+ujl3Oj+j9ZTXOKSPMS+UdcUCqZQqZSvgJnt+fhMZuQwC//Ccx5kzkZCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p52U8C54CXWVxKuk7vBp842rDn+KJDZc+CjjB91Ut4=;
 b=RoctNe9Q967PQhGi2Z0LcmoDmxkvzg36kSOo7rKpL4/uW/e/UYO7Szx/CyKIgj69GpUb4/GS2e2+pDBusIkScTrdObgA+EGEUAHJ60y9b9OZwzPGMaymyQrtVEsKQNGfE2jfB4hSftGgcH7nkedkmAyMJnSmg6mVD8t4dBC5prrnxzmcyxbmO7RZvoy2TjKc4JVlPXnbo7y1PD0dKDheljXo1UndGZA+iE97czELUj5igRzBsAfGntINxF86DPf4yMcyCkYAnXf1/g6BNT6w4Q1rsy32PCajAj2sLjvTUk9bbeyiqg2LmoRWemrpW8WT3jXEKG8ryjFhV6hOL4UrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p52U8C54CXWVxKuk7vBp842rDn+KJDZc+CjjB91Ut4=;
 b=QiWT6EQus+iyeGhZf536eeeONJYB/GxvSknA7CBI+z9Fe6mf5Rh9m27y958IJm4dZuzgGBEuOy2MPqGz/+6GF41BFIWPje68j0lyYFGx0FVO1r4tBZgh8H4XH19OZmMcsOxMap+8G4SoJuyx52XKEEZDsuWVvjQ6pFON1Wdb764=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Mon, 16 Oct 2023 23:20:53 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::ee90:6ffc:283d:8130]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::ee90:6ffc:283d:8130%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 23:20:53 +0000
Message-ID: <4ad48c16-d023-4be2-8d43-a0428ca00eaf@amd.com>
Date: Mon, 16 Oct 2023 19:20:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV - P4
To: Bokun Zhang <bokun.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231016165437.2865-1-bokun.zhang@amd.com>
Content-Language: en-US
From: Leo Liu <leo.liu@amd.com>
In-Reply-To: <20231016165437.2865-1-bokun.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::27) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5399:EE_|CH2PR12MB4875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7790bf5c-86e6-4202-1506-08dbce9e8aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LEnurmcI9B9rY9xqKktCWkD9dijGJ8MIYkuHQQ2Q+M1K8mTrKnFFtOsHFdZKqQ2SpXLLBqbEZf5M14MhooX6E8suTMpbmCc7mT6rzBokajL8bjZUG2BBJbtSP7zIKByTNTlZaS+7eTOQ5f2MjbHlPa+xF5iVikWxJ/kN/cTIx+7gGhe5+iLKFRu7ZMzLMzOHA9zz6xfi40LjJSLI0DWpn18x+jKELv7fmIvj8woEpX+ZFT0aD2GlnZCD5GcbTS4mGC7hI5NQHBpyFCPCxjcdOu2dn19aBvMlAPi0LyfPewSV/6RPcQpUioSC1oV+OUpmjRwfqilzixaQdJD4rv+NycazzWQPtcAKPw1nHZFte07t0hYwwNTaxWWJVlEQ7uStR1F0s4jD/jUcO0RlX2y0clWQbFZERGsvL1zC7r/Y05BfgU7VuH8Ah05EkZO8xOhlwrobSBMHCUqEC9TV5QVPYu455ENwaAOzoU5bg6uidpe9J3FewZ7j50WkOZJhSGOo68LM9Rn0sr4v2Uix/SMBH8eRHdB9Pyp3OtP1xfdtEqKjxVHbmNgXNq+78MJ7WMqC9b4cq7QFJDNpPjS/enlMNNfmxu2ZOhGxeP2Dfh9mC/WW1FG4LWceTpM4+z3gu1N5fk4eIsW+7kY+q2T1k1aK1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(478600001)(66476007)(6486002)(66556008)(66946007)(2616005)(53546011)(6506007)(26005)(6512007)(8936002)(8676002)(2906002)(4001150100001)(41300700001)(5660300002)(44832011)(36756003)(86362001)(31696002)(83380400001)(38100700002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUp6N1RMbUJIdXdUcGJsOG1kd1VBdm9qNm8yUGttWFJmNTBVRkI0b3ZlcGFT?=
 =?utf-8?B?SHZFUllJcHg3SHlwelArZTlDMWVtb0NCUXhXanAzcEVUckFTdGp1UERBdVR1?=
 =?utf-8?B?UjVIck9lNlgrWXR3YVlxMXJHQjBBUGNRV1ZabUdMbmxjRy83RkJNM3BiTzhE?=
 =?utf-8?B?a05lV0VodjZ3eitQckgzM0JDQnJuVUlHUzFWQndDOHJXS3I1U28zaVRMa3hM?=
 =?utf-8?B?L28ra3RBUWJnWmFzRTl4MFNkdVljTGU2Y0pWTGxsVFdISS9TRFZQY3pFbjhL?=
 =?utf-8?B?Q1YxTHB6MzJtY2ZGT3NDOFFYUmVUV3FqQzRQUmpwQVdUaGFuYWh2dnpEbUc3?=
 =?utf-8?B?UTFkYmoxQjdHbm1tdzIwS0hjQWhOL3BWQ2ZPc3prSlltK0dTVDFnS1kyTFNi?=
 =?utf-8?B?QmxBN1ZRLzNJOUFQM1phUFRXVVZva2tqMlNNWjVmVHNHdnBXSTAreUk1NWN2?=
 =?utf-8?B?NGJCSVFUL2VzK0d4SFZkRFZoa1NDSjNwVEUwVE5RamRRZStrS3VkUC9yYWdt?=
 =?utf-8?B?b09FSWNTREpGTVR2emwwVHdXZ29xbWoxSlRxSmhrU1IwRjRLSFdCRkRJa0Rv?=
 =?utf-8?B?MTM3WFdMRGs3T29MMWZsNHVSY3cvMjBieWhOaG1DT2dpTFhHcEdrdFVuYytE?=
 =?utf-8?B?VnduQlpGTXBjZU0xMDgzcXAzN1cyaG1VaktvbkdYN21UdFdGVkxXc3BzU3JO?=
 =?utf-8?B?a3pWdU9GbEwyNG0xcVpLbjRMNlMyQkhLcjBHeGpjUUh2dlgrcndxUXNnRjhl?=
 =?utf-8?B?aGNMNjhDUTV2NmNmY3lsUUdYUFdzOHRQQWNUMHpZSHZSa2V4U1ZEMm9KMDJ2?=
 =?utf-8?B?NEUrbEh4V0lDeFIxaCtJRm9uQWx5RUZ3Y0xoQ1ExVXJVcW56MTI3WXpkNzlI?=
 =?utf-8?B?WnVLREkrTEVUK1dlRWV0K0F0WVFJTGRQMVNmRGhTR2RJSVZxRmovZEgzc1dV?=
 =?utf-8?B?bk50RHE3V0RaUXJwbVBXTUFEWlBCS0gxTjBQckkrNmM3dkdxaWRNU3dkbzJq?=
 =?utf-8?B?NUc3Q0IyeVRpVXpncW1ld0Q5TmJqYy93dWgwcWZaSitkMWlwRXdBNU1uMlg0?=
 =?utf-8?B?MEQvRC96K3RnaDl4Unc5QzVaVDhiQzJvbUtEa0lKMXMrcml6c2pVOGgxdmxj?=
 =?utf-8?B?ajZwK0ZvanY0M3ZuYzEwcjd1ZUdYejRkUitrSWpwbnFhNUxkVU1VSHFqVkdz?=
 =?utf-8?B?Ly91U01MS015dy9MWVlscllDcnE1aGVESUFDVWVjcmQ4WWFmTkt0WkNGTlRn?=
 =?utf-8?B?UVQ0SVhVNFhPZyt1VTExWHdvMmwxeWV1aGRuckpKaTBORllzSm9oSlBxMzk1?=
 =?utf-8?B?SjFKL3lYTTl2MmNhMWJwUUdkYmtGN1BOR1JOVnhGNFJqUzJxWG9hWkg3dE42?=
 =?utf-8?B?VkJCYnNoUnpjUHpuTlRINDMwT1gyK0dCdnJaaFVrR3BxS1AxN01MdlJxdS9o?=
 =?utf-8?B?bjRTTU43RzFRYU1BZ2xCUHF3aFBUZkpUVWNoZGFKWkQxOGRRa2FkTnFWRFEx?=
 =?utf-8?B?YVpBZjNzZ252dEJMV3N3ZGF1QWViNTUwb3NBaHN0dEVhK2JwZWd4TzQ0dmdn?=
 =?utf-8?B?Zi9jN0t5aTUvUnZyaTBNNzlsMzFCMzBFbWhPZFhpWUJUd04raVUxUFQwRGxT?=
 =?utf-8?B?NTcrSHloUE41UmsyaklPMmZGbktnbUtWUmk4YndEOHdXSjZXdHY2bFdqVXU1?=
 =?utf-8?B?djZpSGJZUitveEIyRVUzTmN0UVdqcXFlTUFBa0xFcVNrU21RemFqenlrWk1u?=
 =?utf-8?B?bU8zSXloU2M1MmVodVJzOXJhRzRZL0RycHFwZGdkV2NaNTNkT0prLzIrd3FS?=
 =?utf-8?B?VjlvY2RqbzFOc3dhOFNPbURhVWo1eGxKRnAwTlRWSDVVTmFMK0VUY3BlL1Rn?=
 =?utf-8?B?bXJhQ1A5MEhOQWdIalFBampDcDBFTVZ5THpOcjgvK1ZnNjlOQVBaMGZDK3NB?=
 =?utf-8?B?LzBzU0hMY2huVER0bWVqU0ZDVXQxUnhoRTVhTVFlNlN3QlBQVWdoRUpkZ0hk?=
 =?utf-8?B?SkRDYU8zL0V1dEVEdTNLOWltT3hsVUlXZlMzWmh3N1J0cEtoM0t2eXdEQ25C?=
 =?utf-8?B?bkZKUkxCK0pmUDNEMEMxaUN3c05XSkxjNE9GRUpIQVgrcDRkVFQ1QStDTTNo?=
 =?utf-8?Q?EuwHTI6DlJ/FHn+UL/F4R/UTT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7790bf5c-86e6-4202-1506-08dbce9e8aaa
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 23:20:53.1537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPtrZ9SEZZ2Es2Rg3XcPLNfArUrF1FwcBMWP3Zx+qO42m5JeQX+BZVlaHJVazdYr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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

The set looks good to me. The series is:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2023-10-16 12:54, Bokun Zhang wrote:
> - In VCN 4 SRIOV code path, add code to enable RB decouple feature
>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 71 +++++++++++++++++++++------
>   1 file changed, 55 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 88e17f5e20b2..bf07aa200030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -176,9 +176,6 @@ static int vcn_v4_0_sw_init(void *handle)
>   				AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSHAKING;
>   		}
>   
> -		if (amdgpu_sriov_vf(adev))
> -			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> -
>   		if (amdgpu_vcnfw_log)
>   			amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>   	}
> @@ -1209,6 +1206,24 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static int vcn_v4_0_init_ring_metadata(struct amdgpu_device *adev, uint32_t vcn_inst, struct amdgpu_ring *ring_enc)
> +{
> +	struct amdgpu_vcn_rb_metadata *rb_metadata = NULL;
> +	uint8_t *rb_ptr = (uint8_t *)ring_enc->ring;
> +
> +	rb_ptr += ring_enc->ring_size;
> +	rb_metadata = (struct amdgpu_vcn_rb_metadata *)rb_ptr;
> +
> +	memset(rb_metadata, 0, sizeof(struct amdgpu_vcn_rb_metadata));
> +	rb_metadata->size = sizeof(struct amdgpu_vcn_rb_metadata);
> +	rb_metadata->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> +	rb_metadata->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
> +	rb_metadata->version = 1;
> +	rb_metadata->ring_id = vcn_inst & 0xFF;
> +
> +	return 0;
> +}
> +
>   static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>   {
>   	int i;
> @@ -1334,11 +1349,30 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
>   		rb_enc_addr = ring_enc->gpu_addr;
>   
>   		rb_setup->is_rb_enabled_flags |= RB_ENABLED;
> -		rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
> -		rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
> -		rb_setup->rb_size = ring_enc->ring_size / 4;
>   		fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
>   
> +		if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
> +			vcn_v4_0_init_ring_metadata(adev, i, ring_enc);
> +
> +			memset((void *)&rb_setup->rb_info, 0, sizeof(struct amdgpu_vcn_rb_setup_info) * MAX_NUM_VCN_RB_SETUP);
> +			if (!(adev->vcn.harvest_config & (1 << 0))) {
> +				rb_setup->rb_info[0].rb_addr_lo = lower_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
> +				rb_setup->rb_info[0].rb_addr_hi = upper_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
> +				rb_setup->rb_info[0].rb_size = adev->vcn.inst[0].ring_enc[0].ring_size / 4;
> +			}
> +			if (!(adev->vcn.harvest_config & (1 << 1))) {
> +				rb_setup->rb_info[2].rb_addr_lo = lower_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
> +				rb_setup->rb_info[2].rb_addr_hi = upper_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
> +				rb_setup->rb_info[2].rb_size = adev->vcn.inst[1].ring_enc[0].ring_size / 4;
> +			}
> +			fw_shared->decouple.is_enabled = 1;
> +			fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
> +		} else {
> +			rb_setup->rb_addr_lo = lower_32_bits(rb_enc_addr);
> +			rb_setup->rb_addr_hi = upper_32_bits(rb_enc_addr);
> +			rb_setup->rb_size = ring_enc->ring_size / 4;
> +		}
> +
>   		MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   			regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>   			lower_32_bits(adev->vcn.inst[i].fw_shared.gpu_addr));
> @@ -1810,6 +1844,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
>   	.type = AMDGPU_RING_TYPE_VCN_ENC,
>   	.align_mask = 0x3f,
>   	.nop = VCN_ENC_CMD_NO_OP,
> +	.extra_dw = sizeof(struct amdgpu_vcn_rb_metadata),
>   	.get_rptr = vcn_v4_0_unified_ring_get_rptr,
>   	.get_wptr = vcn_v4_0_unified_ring_get_wptr,
>   	.set_wptr = vcn_v4_0_unified_ring_set_wptr,
> @@ -2023,16 +2058,20 @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev, struct amdgpu_
>   {
>   	uint32_t ip_instance;
>   
> -	switch (entry->client_id) {
> -	case SOC15_IH_CLIENTID_VCN:
> -		ip_instance = 0;
> -		break;
> -	case SOC15_IH_CLIENTID_VCN1:
> -		ip_instance = 1;
> -		break;
> -	default:
> -		DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
> -		return 0;
> +	if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
> +		ip_instance = entry->ring_id;
> +	} else {
> +		switch (entry->client_id) {
> +		case SOC15_IH_CLIENTID_VCN:
> +			ip_instance = 0;
> +			break;
> +		case SOC15_IH_CLIENTID_VCN1:
> +			ip_instance = 1;
> +			break;
> +		default:
> +			DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
> +			return 0;
> +		}
>   	}
>   
>   	DRM_DEBUG("IH: VCN TRAP\n");
