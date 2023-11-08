Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7D2C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 18:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF0510E80C;
	Wed,  8 Nov 2023 18:16:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C20210E80C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 18:16:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVPGMDxUt1biAdFSQINrwCH6GPV8SxCESSNQRy5qOsQrrFAFmA60uhfoFvTX/xDzlUZo3EskMFODoax8GP8Lg0JdjYj2KrvakTSo4z3vF0QFzUBM/4+avPIaqnQnI6zbMzWSOqFWboRtvKpZ7bJZdwnueTmUeaBwL9Jfz6xhw8Rtn1HqxEqGSOH2qUuS6/hhNIyGnNQnfLMTlP1k5agDlbCURNVZayqWuw2faDT5rxqhdgpvABWKZ/17FyDUIbpIM9YdAPkX9dyS6qXujrbXPEtI0RfFVXug2b6F5cGFCW+oY7msvUNLjKCSjRS/8yMTAZ8ny+qTvkR9ZOadSO8Z+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFLwa70FsCbxiXqCLs9kP+weJCz3Xj6fkyQYc6xlX6s=;
 b=AebFmwqy+oeGi+uSdSNWZG+WsHZAv/VmnGVIVFjdzB6tIZLGZ5vgKVIMeaO7/aLhXnECrEnIhkeZWFJGlIhCVaGvAUC6yVcEI+m9X7PwqHOmBiAmTOS1yS5hV3xhIpCtVxcF4qk0nXjZ7y3QMFm9GV/r9zfzjiZY0/CEya1VKDm5diDekP0Xj0qK7LAt5jPRTgMGpn2qR6iTD812JyDqNlDDUyhPQ9GlvV3wcm3aTJJX7HwhKMzMZiW7G03XelwVB7783/BGMB7NRX6znejR1ztuVMgrdAl2mEwQ65MP9FzEG9i5cFeF/B9Cmv7AdhlH8bNXxCA+ewfaDBCsr+43hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFLwa70FsCbxiXqCLs9kP+weJCz3Xj6fkyQYc6xlX6s=;
 b=Dc1j6rWShqDvgEdFwzGbxG1L/3qX9eruNHKgV+LROjZ85AuS+4gGllKTppQHMtD0OkfsE173Jphlz1LQ46a6FU3uI2dyjc8cENpdXciJATS8lfIe417iNm3yS2PZ+BAww6AZOhcp6tA9YtBR3IeM9sC8pRkx3w14sk7S2W52dAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 18:16:47 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::7bfc:e32b:f362:60f3%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 18:16:47 +0000
Message-ID: <9207d6f4-bc51-428f-bd19-01d059880f4a@amd.com>
Date: Wed, 8 Nov 2023 13:16:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Change extended-scope MTYPE on GC 9.4.3
To: David Yat Sin <David.YatSin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231108172524.2366960-1-David.YatSin@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231108172524.2366960-1-David.YatSin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXP288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::44) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5230:EE_
X-MS-Office365-Filtering-Correlation-Id: 638f7028-2e24-4560-e5c5-08dbe086df0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jOudS3xB6sskRgVVunBSkia6nDqiIT3lAGb0cdb4tT2czugRqgsxViAZ2vYliaPx+4zdizIozip9hbCJxbsmAfH7szOgUqq0Tvv6eJwGKXtLnAJhz23oaggS++phXOiU9Fuy3mCVR7ky7VlPlUn2z4JfDXpbRF1W870hbpTg4sY/RuykLhnHu/6F7PFwiCK5/P0pnl/nmv+3q78xSnP6Gmtjqxw4r2jxsM4eu4mCw0t75jHjjfgWZUdBsxRuiPj54Kj60jdm5zaGzb8c1rDfpfkjeLqJMB43Zhj/2fSNCjSHJHtW+MzMDX0k8HF32bnSIhUwZG+ewL023qjRS2QKE4hMMTRr+MpvWJm/+JguyiDepS3fkW8uupafP6kRtOOh4Mm/ESeKrv9EZeNwsN0TI/sWJpUnBaF+ekRB0AKLRQIsldwvlW+dxrFO4NxJSgBC6TrQ7ipX+jYADHrTl89fIvf8C4WszNN9knyYmZ2zNInr4Zqrk8gP2SA+4qHntdrTUOAt0Z0OV+g6w/AGeHFZIXj1vTy71Gg2dQFBeMVppbRwcSu2CDgkgV/qNeHm5VQN/nKugTQE3mK82NOUmwmo3g+tTDVpA8vQCQVx+2iS+kZA/lQQ1gzxtPwtnyjvxbhDwt7sgIEfz+/YJiXcsGxGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6486002)(478600001)(66946007)(66556008)(6506007)(66476007)(53546011)(2616005)(26005)(36916002)(41300700001)(6512007)(8936002)(5660300002)(8676002)(316002)(2906002)(44832011)(36756003)(86362001)(38100700002)(31696002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1pTQ0Z1SzhNR3owSnE5UkY1TUY3Z0Z2YTlwMkNDQ08rR0lpeU5KcUM4UnR2?=
 =?utf-8?B?UU5yS1A4UDRWZEFLbkRKTUVuNGI4WWNUNHp0Q1lmdGRYd1JLZVh6andiN3N1?=
 =?utf-8?B?Y3hDeG5oN2FneTh3OVIyS0tGV1gycU5BN3FRZjdhK0kxRmI1ZGRlaTlJZ052?=
 =?utf-8?B?S0N6UkdhTHJvWE9hVFFUNmNocnJmUy9lQWpocW5KNnJydmo2MWNROFM5eVAv?=
 =?utf-8?B?SzB2aWpxajNTbnhGYS9PQW12VVVlUXdQZDFVMFBOKy9qdDhUQjBpUFExM09E?=
 =?utf-8?B?bEhQbmtwR2xEbWJKTHdDa1ZEbnQ3L3lKOUlSSVJOWmI4UExXZUs4b0pURlgx?=
 =?utf-8?B?bEdxeWpYR0diRmRrZjQzbVdpbktCbEFGbW5meCtqMS84K1c0bjY1MkxxTk91?=
 =?utf-8?B?WlBwQllWQWZ0TFpxUmdrekQ3VHh1NTVIdzl6bnFJNkViQjhkeVMxRHQ2OVhu?=
 =?utf-8?B?bmN2Q3F6d09ka2ZrQUZCUVk5QzNUS3VPY0l1ZUtUV1d1c1AwUzYzWmtDM3Y1?=
 =?utf-8?B?ZEN4RFh2K0RiTnVUbDdYd0ZIYmNpemJYS0pOZUFFWkIzYyszS3ZnaitjVnBi?=
 =?utf-8?B?WW9vckp6aFA5NTRRKzl3ZDV6L3crNjBCVFFjQ0VDTDg1TXBrRUFrNG8wOHVh?=
 =?utf-8?B?N0pGZVViSGZlOWlEd1dyVXVWL0JkQVR2VlpjZ1lLdVk0NDl6NERRYXltejRD?=
 =?utf-8?B?YnVWbWtwUWtROXBCc2V4NHBjZUVORXZOYWdLYWc1bEMvemZ4Mi9XSkxLUXlt?=
 =?utf-8?B?RHFMeW9kYzRJalVMejZ6REpGSXRCUWkxSlp3UkhHd1AzQ0thbVNBa0Q2YTls?=
 =?utf-8?B?ek9qN0daU2xhSFpCQVlraUJudGNPbHhKb2JYalBZQzRCQnZqa2VXZ1VhdVRk?=
 =?utf-8?B?NEF3cmdSQjJ2NmhabFpTM1h3bUhXdEJLbEtWZ295eFU5S2k2RDRWMkZJazU2?=
 =?utf-8?B?R0UzRitQbnhsaWo1U3plK2s3Z3B2eVJuRHlWbUs2OUd0YU1UK0tGdFVVc2hZ?=
 =?utf-8?B?d0kwb0IwVEFLUVJ0dS9Kd29GVXRybzBTYUdyUlltMjNBODhoNG40OExWSm5Q?=
 =?utf-8?B?QzVRS2ttbEl1SDNReGpOOTdCMHRWejBLZVhTanQweU03ZUQwNkVNZ211VUFR?=
 =?utf-8?B?ajd2bVdoVHg3TXRyb0lscmRpVFhPcDB6WWorMHk5Tm1yekdNaFZhQU51SDYy?=
 =?utf-8?B?YUYrK1JMNGhLTXBnMGUvTWpwM1hZSTcyTnpoVWpaK0tjWTY3WDVUazJmdksy?=
 =?utf-8?B?WTJkcWcyVW91WFdEUldBc2pDaTUrem50VUVwbTVPV0VGaGt3bWxuZkdEUTNM?=
 =?utf-8?B?am1McXBkSzVxNUxRdS9WbTY5ZEduWVFGWG1JcU4yUFMyTFdpNE1tcUYweHdm?=
 =?utf-8?B?bXNJT1I5dkMxaEdPdkgxN3Badk84M2hrNHRadW9NMHVxTUloZXU2UkJ0N3JR?=
 =?utf-8?B?MWtsdWdURGlxNHJvQlBLYkEyUnhrZlJYcE9MemxvTDl0QUZJQW1Ba3FoNThE?=
 =?utf-8?B?Qk9kZjVpRDUydXJEd1ZrcURxUjFzS29VVElncGtsVGM0TkkvR1Bha1ZKMWFm?=
 =?utf-8?B?VmgvdEZkRlhkMVlOOHpWS2p0RkdGL3YvUllqWHBRUUtpcmp5bElWZFIzM1NI?=
 =?utf-8?B?eWVHcVhidkFWSjlnRTI0akdWRGpCVnpBY3J5MGg0OWJKcStmU2l3T3JKM2hY?=
 =?utf-8?B?QWE1K0VGQ1FvUG9PWEtzTU5hU0liS0dFbkFjUk8vcFd2V0M0MFRTMFZFRE9L?=
 =?utf-8?B?dG1TR0dEYm5Fc3laL3pQRVRuNzFhdHZvTEpKZGJCMFlINVhGM25maWpNNVdG?=
 =?utf-8?B?MzZha0phL2c2eE9SUHpZaGZsaUNzcFhweVFINDNmbkRSdGtzWWtqOUc1V0FW?=
 =?utf-8?B?L1JZSHNDOTdpTnVEcExnSGliellUTzl5eFFkUVB5ZWh1MGdXWVdTejlEMXJM?=
 =?utf-8?B?UXFGWDBSZG81L0RMTllYSllnSGxYdmZEOWZpd0VhbkxudWtyYU4wMVZMemww?=
 =?utf-8?B?WTBZOGhkWE5TenRNejdPTlZGUjhRS00rQWZsait0eFlaa0ZGTzVtTlRjZ29m?=
 =?utf-8?B?SzlZbkVzc1Y1TFE5bGdJT3RKUTYydVFuZ0Frd3BTa0dVWnozUWI2aVdZRlJx?=
 =?utf-8?Q?SuLC8dmpLy6goBbh9Z3ggG+Jh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638f7028-2e24-4560-e5c5-08dbe086df0f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 18:16:47.7388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKHkQclFJoBhHCSXGZhbcr8OPsKY/NwScm6LgUKEurDAHnbHnOxregQvZWxCNj/xyiVUS4B4G1siLcC6TXKy6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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

On 2023-11-08 12:25, David Yat Sin wrote:
> Change local memory type to MTYPE_UC on revision id 0
>
> Signed-off-by: David Yat Sin <David.YatSin@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c  | 8 +++++---
>   2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index b66c5f7e1c56..5ecddd08c363 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1176,7 +1176,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
>   		if (uncached) {
>   			mtype = MTYPE_UC;
>   		} else if (ext_coherent) {
> -			mtype = is_local ? MTYPE_CC : MTYPE_UC;
> +			if (adev->rev_id)
> +				mtype = is_local ? MTYPE_CC : MTYPE_UC;
> +			else
> +				mtype = MTYPE_UC;
>   		} else if (adev->flags & AMD_IS_APU) {
>   			mtype = is_local ? mtype_local : MTYPE_NC;
>   		} else {
> @@ -1297,7 +1300,7 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   
>   			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
>   				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
> -		} else {
> +		} else if (adev->rev_id) {
>   			/* MTYPE_UC case */
>   			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
>   				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fe937670c927..b23ba92a794c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1253,9 +1253,11 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   		}
>   		break;
>   	case IP_VERSION(9, 4, 3):
> -		mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> -			      (amdgpu_mtype_local == 2 || ext_coherent ?
> -					AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
> +		if (ext_coherent)
> +			mtype_local = node->adev->rev_id ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_UC;
> +		else
> +			mtype_local = amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
> +				amdgpu_mtype_local == 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>   		snoop = true;
>   		if (uncached) {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
