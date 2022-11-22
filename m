Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA1C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 01:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C22B10E4C1;
	Wed, 23 Nov 2022 01:44:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9F510E4C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 01:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhfs8jzBJXX4+FdhE9gmz8/8qmWRVioYmeMBT2jHBMJBSiQeo9b/cy9yFAHatOhdQcVF2A/Jajvg6r4qPT4Oit8c3oNRm8Iq0NKTmGtXbfmnpcTKJcodJlvVrPPeEaXDjo9cMTNeXZjE801Zq20H5q11S4hiAXJFqKz8pWVs/aq5+3tJVh0dwVAgPbFYT4WP80tfDT1ifzaEEVMFFHTeCDJfFuz5nnSWK1/Eh9hV8Ka629nfDIPzFMz6vzjfbS8ilDlS02EfP3x1JhyUKH3zDErFhT886Qw7kUHIZrZiO/HyYG7IkqSn95onpzX7+72qIr/4TnL0PEIn5v0h7b2STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MaLYsOw20Qjtk47gVndEH+HC4TjoHWrzB2vsVp5oMI=;
 b=nlxZkFrQ15W1GMSK1OA3n8dJvVk7b82eaF06r9dc8kRAu8y7J1x4a2xLKbN8Hihc/78UvSQxgL35UIdbkxHdT9BD6JUGCZFvmF7HpelelupkjAhEM4MKHPykIIxZXYjlc1JGLAWlZOEDDFH0IHGflugHkcQOQ/cbUAEKWCYmQ5Iu4OguZGQAUgyZnLK5boGi1O3YTMaGEO7neD/FaIkZDuPjI050E+tRDPSoqO5dJAm+Mc6WDnD/sig6ni3qGkZ6TWkqg/3JeqszY1eleaLo05n7B3lZUmh25NX8lEko8JESEiqg9TPZL2F/w64ib5ikGZ/6XFcBfnuRHGGCCpvdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MaLYsOw20Qjtk47gVndEH+HC4TjoHWrzB2vsVp5oMI=;
 b=HW+kVfhQwXQUSIYiUGbj0/3MWx1EWIkhP5uxalMcXuUskyDdoHRKkg81E7pjj7nk29E3dlr/vpPIQPNOMGKafdP85cNAcDVCgKfQ+BjpMYUe3bWXxowNCKG3gKmMM7qZTFcQ4LWuEjLTAChiir1d4pdnf4H1Ce4/HBE5Wo7ecpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 01:44:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 01:44:30 +0000
Message-ID: <dfacdf0c-d608-b507-e477-1ddc1a8b7af1@amd.com>
Date: Tue, 22 Nov 2022 18:08:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 02/29] drm/amdkfd: display debug capabilities
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-2-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221031162359.445805-2-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc2241e-c492-4aef-6abb-08daccf4438e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1rlQQuxfr/7sqgQn4qEWG3CJyoXky1rccgAKl9WZ6Fp+ib8oKA87SbIYBXUmJ4kTpBTces9mlhosh8frAe0GdoUZD8ZFATggq2Sk4B550MnN8816ZcexTOIkPAXHRv07h5y4yQbj2fdrTWByq+sv1cmEh/Rb9VUEZML5slQSXN/6rr5BjS3OYK4sxvpn0UgLWuUqdePWHyXUs6CgHAI9h99ElOP9Q69XSRNAXXi7s8iO1FIHQ78KtNcxR+oZfpwqbEClNj4jJBmjjRV2fPj/JCsJfOVn3ZIur2IhOziLSqnXG7KZ/ey1E3cgqCyUzMUldMnkz+DARlet23NgWBo/SySXED6z+UBKJLW0gyudwi8Z+ZB6bJKMce+uxl4+FS1oBLuDYA7zD+7PupcIZOktveqFyFfjei9UEL1hNc0q3iasMo+A06kMzWnRPyoLELdQ0fBmZsm1u9PkyJkjFeV2lODRJFJjLZiGt/zxy9XkJaHlya4mOYDp4IUfIHN+F2m/NckJGmAiX85cZ6/RzUWNopRvIsgc+yl60cY4dpGt05wxoiMZ5DuaycQbwwI3EjzyVnLS7LAtX2kf69T9lxA83i0GSw7L/DeKA3BSWUofQiHzqK9e4y3z+dLnvLHSABUFsFiJx2uI6mnoBo6lGfakU0VoFHZb1K74dtxyHahftJkWzqIMVoFMytQG4DbuR/4IGc78cO62hq0nr6dsdGZKr2urDgdjSIiN4Ws+81sT04Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(66946007)(83380400001)(36756003)(26005)(6512007)(66476007)(41300700001)(316002)(6506007)(2616005)(53546011)(66556008)(8676002)(6666004)(6486002)(44832011)(38100700002)(2906002)(186003)(478600001)(4001150100001)(5660300002)(8936002)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFqdWJyOHlFZjVDZXp4N05uZHkwQldnaVBRYzhXbzJldWhRcUdCVXlXQjNY?=
 =?utf-8?B?MW1aRGUxTDV2dnlYMHZxcmVEUUNJQm10ZDZSMXg2U1VZRWRiZlFuSEo0OThl?=
 =?utf-8?B?NDlNbXQ0MUFDWlRhMTRpUkJkNzlac2tjQmhxRXJmNDdYbXVvTHVXdWVYdjZp?=
 =?utf-8?B?cmRjRG9GQ1U0Qks0VXdqUFNMdGU2TEd3cSsyaHdiVzBDVGdGUVBJUUhTZnA1?=
 =?utf-8?B?bHdWTlUrL255MUxFMUw0bVVYVWRHZjB6WWhQbmR5SmcyOHdJaFBWMmtQNzBQ?=
 =?utf-8?B?Y20zdWNhMFlQajVzS0JzamkxaEtqV2R2OEIzNThXSVgrMElSdVNtVjBiMGtk?=
 =?utf-8?B?eUQvMGdsdmQzZUwvdDFJOG1RRlc0NStDNU85UW5oaWE1NjFSQ0NpaFRzT09r?=
 =?utf-8?B?a2xRbU5NQkV5TXFRVWh2SUNEU3ZsRG1Fd2lkdXhEd1ZWcmxJQU5sSkhNM2w1?=
 =?utf-8?B?ZG9QeUxxQXBPa085TmtmUS9RN3dvMUVPZnpzbnJyZ3dmcmZXQjY0ZUs2azdN?=
 =?utf-8?B?TlFpenJVeVo3cHphVVF1RnZQaFF3V2lKK3hKaENMNDJZaGZRc0UwVFR5MTlX?=
 =?utf-8?B?cXZ3cys1MndlYmF5ZUx3ajI1SkU4Qm1URGJiRGNjVWt6NGNMeUhES0ZTNjFa?=
 =?utf-8?B?bWMrVUI3cHkxalZnNjFXU1h0K2M3RlNJUmJ1WXZia0Z1RUQ3TlVESkd6MGdM?=
 =?utf-8?B?R1ZpSWUxdTdEZ3k4aDBWMzZnc1d2OUVkcUovVHpZTElsYnEvVFRvdXY1WXpW?=
 =?utf-8?B?dkROeVVJaGVqK0pyd0kzanhhdnUxSlk1eTRvbG9WMldVTlpPQVUyeUJ5b0RR?=
 =?utf-8?B?aFJPVXhwaGRKK2pzZWtLNDA3cm5yak8vODBEWVlDWW1udWpTaFltY1RKWnVC?=
 =?utf-8?B?azN5MlVzUzJ4VllmbEdBeURremM0TDNQUWZaOTYyekljNnA5N2UxNG9BeFhn?=
 =?utf-8?B?UE93QkJWYUNPT0ZMVXA3eUxmbEFxNHhMdi9qR0QyT1MwRzF4NHE5MHVuVmlG?=
 =?utf-8?B?NTFPL2ZCZSsyOU5zZUhlNnBRTGQyWTNzdHgzMGRXRitybnd6MjI4eTZybTAz?=
 =?utf-8?B?NG5XRG1jb045Q2JoQnNBNHRBL01TaTYraEM5M2dsay9zQnF4Vm9XS281anNZ?=
 =?utf-8?B?SVJtS3IzL253K0QyeGpuSGE2VmNwdUhiWksxVGlldXl5NlkyeURTVjh2enVK?=
 =?utf-8?B?ZWlCejROUkluZ0d0cVRWTnNTazJVejNhbHVRbmJKSk5EeVVxSXpqTnM2UHg1?=
 =?utf-8?B?OTVGd0JFZGR1V25wOGppQit6b0xTUFFTM1lzNEtXaFFPcUF4L1VHTk9rT0hU?=
 =?utf-8?B?Tm1Xem43N1lNeFRjb29xMjBOMnFHdXlsM0lpcnZDbkdzRy90UWdQMGs0TDNE?=
 =?utf-8?B?Myt6L00yaHNENWlUL3QycUtYdWVrWFA1QS9HZFZndXZvZ2xwNmdlbzVXL0p1?=
 =?utf-8?B?R1l4OTh5cWR6aG9nSFhGN0VFTWxJRDl3eWhkdnJqQmtlRlNSYW0xM0xFUklH?=
 =?utf-8?B?VlFDL3p5andlaHVqTllRL2hxRXFCOFZLdmR2djZCRldDbTRjRVlGZnhuWnZm?=
 =?utf-8?B?SGljeWVDVlBTR3pzM0YzMWwweldQeXV1SjcvL2F3d0Vma2h5WXJnaGFhTVM0?=
 =?utf-8?B?NGNIRmV2WmtISkljcHU2bmN2bzdPbnl1a0dQdlMveXFvZWdJNWVJd2kya1d4?=
 =?utf-8?B?Z2tPVXBGWHM3U0FuR0RpUDdPOVJlTElKWFY1Y2NlZyt2eXRxZVJkRW9ZZ0da?=
 =?utf-8?B?ZE9Kd0tQV3kyeVQwSEU2eG5ITFErVkp0cTNzVlVZNFIyL3owUXYrYnVvQjhT?=
 =?utf-8?B?bCtrTitNYlR5YXBVSHR0THBSaFoxLzErdW5uY2RWbDI1MFZCY0puNDJVcW9F?=
 =?utf-8?B?WER0THZFdWhWU0RSazF6Rmo2UVVOQUlINmFJZm5DTEFNOE84dVhvSTFibGVT?=
 =?utf-8?B?OVRJYytHZVVHdFE3Sk9wUlFOeGFJbFNsSGlmL0txUmt2anRjTkhiQ1UxMEJj?=
 =?utf-8?B?dmZnZTRhVGhRVmJtNUF5OGNnbnNvR2NSNnBjR3NKajZIZ0JVazlzM1haMmhu?=
 =?utf-8?B?WVNjcEdzelBUSXZUUGNKWDZjaFJrK1dlMTRMZTQzQkFKQXZzQlhwNjRpOEYv?=
 =?utf-8?Q?khQh5CgFj7AbipAeDqM+HH5eA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc2241e-c492-4aef-6abb-08daccf4438e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:44:30.5089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OHJcNO8wjycMoP1A+RNGm1OdqPztd1tsHzQ3lnqrvteV+W2fe6iGy9WHjC/tXnQnaQPWISNBLzZ9h6ny7/H7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Expose debug capabilities in the KFD topology node's HSA capabilities and
> debug properties flags.
>
> Ensure correct capabilities are exposed based on firmware support.
>
> Flag definitions can be referenced in uapi/linux/kfd_sysfs.h.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 88 +++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  6 ++
>   include/uapi/linux/kfd_sysfs.h            | 15 ++++
>   3 files changed, 104 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3f0a4a415907..cd5933a594de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -551,6 +551,8 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
>   				      dev->gpu->mec_fw_version);
>   		sysfs_show_32bit_prop(buffer, offs, "capability",
>   				      dev->node_props.capability);
> +		sysfs_show_64bit_prop(buffer, offs, "debug_prop",
> +				      dev->node_props.debug_prop);
>   		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
>   				      dev->gpu->sdma_fw_version);
>   		sysfs_show_64bit_prop(buffer, offs, "unique_id",
> @@ -1593,6 +1595,84 @@ static int kfd_dev_create_p2p_links(void)
>   	return ret;
>   }
>   
> +static void kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *dev)
> +{
> +	bool firmware_supported = true;
> +
> +	/*
> +	 * Note: Any unlisted devices here are assumed to support exception handling.
> +	 * Add additional checks here as needed.
> +	 */
> +	switch (KFD_GC_VERSION(dev->gpu)) {
> +	case IP_VERSION(9, 0, 1): /* Vega10 */
> +		firmware_supported = dev->gpu->mec_fw_version >= 459 + 32768;
> +		break;
> +	case IP_VERSION(9, 1, 0): /* Raven */
> +	case IP_VERSION(9, 2, 1): /* Vega12 */
> +	case IP_VERSION(9, 2, 2): /* Raven */
> +	case IP_VERSION(9, 3, 0): /* Renoir */
> +	case IP_VERSION(9, 4, 0): /* Vega20 */
> +		firmware_supported = dev->gpu->mec_fw_version >= 459;
> +		break;
> +	case IP_VERSION(9, 4, 1): /* Arcturus */
> +		firmware_supported = dev->gpu->mec_fw_version >= 60;
> +		break;
> +	case IP_VERSION(9, 4, 2): /* Aldebaran */
> +		firmware_supported = dev->gpu->mec_fw_version >= 51;
> +		break;
> +	case IP_VERSION(10, 1, 10): /* Navi10 */
> +	case IP_VERSION(10, 1, 2): /* Navi12 */
> +	case IP_VERSION(10, 1, 1): /* Navi14 */
> +		firmware_supported = dev->gpu->mec_fw_version >= 144;
> +		break;
> +	case IP_VERSION(10, 3, 0): /* Sieanna Cichlid */
> +	case IP_VERSION(10, 3, 2): /* Navy Flounder */
> +	case IP_VERSION(10, 3, 1): /* Van Gogh */
> +	case IP_VERSION(10, 3, 4): /* Dimgrey Cavefish */
> +	case IP_VERSION(10, 3, 5): /* Beige Goby */
> +		firmware_supported = dev->gpu->mec_fw_version >= 89;
> +		break;
> +	case IP_VERSION(10, 1, 3): /* Cyan Skillfish */
> +	case IP_VERSION(10, 3, 3): /* Yellow Carp*/
> +		firmware_supported = false;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (firmware_supported)
> +		dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED;
> +}
> +
> +static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
> +{
> +	dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
> +				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
> +				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
> +
> +	dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_SUPPORT |
> +			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED |
> +			HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED;
> +
> +	if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(10, 0, 0)) {
> +		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9 |
> +						HSA_DBG_WATCH_ADDR_MASK_HI_BIT;
> +
> +		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 4, 2))
> +			dev->node_props.debug_prop |=
> +				HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> +		else
> +			dev->node_props.capability |=
> +				HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED;
> +	} else {
> +		dev->node_props.debug_prop |= HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10 |
> +					HSA_DBG_WATCH_ADDR_MASK_HI_BIT |
> +					HSA_DBG_DISPATCH_INFO_ALWAYS_VALID;
> +	}
> +
> +	kfd_topology_set_dbg_firmware_support(dev);
> +}
> +
>   int kfd_topology_add_device(struct kfd_dev *gpu)
>   {
>   	uint32_t gpu_id;
> @@ -1737,13 +1817,11 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   			HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
>   		break;
>   	default:
> -		if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(9, 0, 1))
> -			dev->node_props.capability |= ((HSA_CAP_DOORBELL_TYPE_2_0 <<
> -				HSA_CAP_DOORBELL_TYPE_TOTALBITS_SHIFT) &
> -				HSA_CAP_DOORBELL_TYPE_TOTALBITS_MASK);
> -		else
> +		if (KFD_GC_VERSION(dev->gpu) < IP_VERSION(9, 0, 1))
>   			WARN(1, "Unexpected ASIC family %u",
>   			     dev->gpu->adev->asic_type);
> +		else
> +			kfd_topology_set_capabilities(dev);
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> index 9f6c949186c1..c089c26a0e77 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -31,6 +31,11 @@
>   
>   #define KFD_TOPOLOGY_PUBLIC_NAME_SIZE 32
>   
> +#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX9	6
> +#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_GFX10	7
> +#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT  \
> +			(29 << HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT)
> +
>   struct kfd_node_properties {
>   	uint64_t hive_id;
>   	uint32_t cpu_cores_count;
> @@ -42,6 +47,7 @@ struct kfd_node_properties {
>   	uint32_t cpu_core_id_base;
>   	uint32_t simd_id_base;
>   	uint32_t capability;
> +	uint64_t debug_prop;
>   	uint32_t max_waves_per_simd;
>   	uint32_t lds_size_in_kb;
>   	uint32_t gds_size_in_kb;
> diff --git a/include/uapi/linux/kfd_sysfs.h b/include/uapi/linux/kfd_sysfs.h
> index 3e330f368917..a51b7331e0b4 100644
> --- a/include/uapi/linux/kfd_sysfs.h
> +++ b/include/uapi/linux/kfd_sysfs.h
> @@ -43,6 +43,11 @@
>   #define HSA_CAP_DOORBELL_TYPE_2_0		0x2
>   #define HSA_CAP_AQL_QUEUE_DOUBLE_MAP		0x00004000
>   
> +#define HSA_CAP_TRAP_DEBUG_SUPPORT              0x00008000
> +#define HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_TRAP_OVERRIDE_SUPPORTED  0x00010000
> +#define HSA_CAP_TRAP_DEBUG_WAVE_LAUNCH_MODE_SUPPORTED           0x00020000
> +#define HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED  0x00040000
> +
>   /* Old buggy user mode depends on this being 0 */
>   #define HSA_CAP_RESERVED_WAS_SRAM_EDCSUPPORTED	0x00080000
>   
> @@ -53,8 +58,18 @@
>   #define HSA_CAP_SRAM_EDCSUPPORTED		0x04000000
>   #define HSA_CAP_SVMAPI_SUPPORTED		0x08000000
>   #define HSA_CAP_FLAGS_COHERENTHOSTACCESS	0x10000000
> +#define HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED   0x20000000
>   #define HSA_CAP_RESERVED			0xe00f8000
>   
> +/* debug_prop bits in node properties */
> +#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_MASK     0x0000000f
> +#define HSA_DBG_WATCH_ADDR_MASK_LO_BIT_SHIFT    0
> +#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_MASK     0x000003f0
> +#define HSA_DBG_WATCH_ADDR_MASK_HI_BIT_SHIFT    4
> +#define HSA_DBG_DISPATCH_INFO_ALWAYS_VALID      0x00000400
> +#define HSA_DBG_WATCHPOINTS_EXCLUSIVE           0x00000800
> +#define HSA_DBG_RESERVED                0xfffffffffffff000ull
> +
>   /* Heap types in memory properties */
>   #define HSA_MEM_HEAP_TYPE_SYSTEM	0
>   #define HSA_MEM_HEAP_TYPE_FB_PUBLIC	1
