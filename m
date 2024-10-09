Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2147CCEE350
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 21:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF56410E810;
	Wed,  9 Oct 2024 21:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VVoozzEt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E4AB10E810
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 21:20:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHAviD6FgD5jwmt+p2zdVnMK1YKMAkFMfTujzmEHnHQvNubXD2Yy+vzgOGyH3/gF/dkuW6dLh40ftdSGW98JLXrlQgkikDDv02S8ougaZ1HxdTvw6ITgxYiGnu5sRnxa88H3TY7ioQ4WUc0fkqHyI8n92GLcrMejtuwtIDyPzEGpaScq1N26/nFwgsHutc+KrY7k7LtJMFlSjD/6hq5QtaUc1dSeVEcrDczDpN7xXHVB0dQai7bmllNXH1fHkvEosu9r4QgTtX4SXqel+hO1USA1uWGwnjKxMxBHn3ffbsx95CenuUpOo/oFrYsLDvT9Omgp3wXkSualix3v9Q11qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIfN8RVrG5fbLEDDRE37xSfXCLWUtCRpl7YTCrva2Tw=;
 b=ugAUfZrhK0yw4QR4HYzu+3EAzC9KlDkDWIRNiCD5JlxBm7m6d0/iRZ+PxpXzb04b0ItINlsTxXsdKKA9skUmJOqJ3XnsU1/3oyTC6PPZOPfVWxQLiKwNNnwB3FUWtoaB5vLFYE3hu5s1qMfwisI5UfFF6NE1p8lXzdVKBjnayOD3e8aq/MxLm7yoaDMHPuyGERwFEDf5qpDJQzdNgQ61UF8EOlpbhPKL7UhJVoqp2OlSCn51nIAoSTZ3kNCCo7vVsdq6WExQO+DO2Vbuxc7+ulp3O3CCI+yTFYWG1B16GZKbJYcxW0Hxzza7/SKiNTBIAgmND/eqcgCHyFQ18fyufw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIfN8RVrG5fbLEDDRE37xSfXCLWUtCRpl7YTCrva2Tw=;
 b=VVoozzEtVVB7cQ+uUtlyfiNMM6PRjAZMeEc4ql+GOsPIhkFwHSNsMQ+k9dcgwTm/BMxP983HKXNn4z9YeIgPCUanipTLH4Mv7JpBOm7hGGmkEw7mc+AM/Js3sy7CUY+z698DnTLfPCAcjgymau1Ez1Ow41XCCbR7isT3cl+VgUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 21:20:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%2]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 21:20:12 +0000
Message-ID: <d2aac83f-4a2c-4f90-9c0c-eb471e1c5933@amd.com>
Date: Wed, 9 Oct 2024 17:20:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Accounting pdd vram_usage for svm
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241004202808.30740-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241004202808.30740-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6ccc14-afe3-4081-5141-08dce8a82900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGZkbEF3TytFQnR3NTkvNDVQVE10ekdqcEs0aTRtN1ZWREN2WXorS0dyNXNq?=
 =?utf-8?B?aU1nSExZUHEwQlJ1akJrK2FQaGVHOGFLS3d5UFFUQXNFQWZDWlBZS0lGaTRB?=
 =?utf-8?B?aGc2WjZvb3FCWlhBdGRVbTVnUVFpTnlnOUg3bjdTODhtYjY4cXlCWlNxTE5B?=
 =?utf-8?B?Nk0rWmR4R0tNZHJtTVAyaldzbnRJcklrblJpOWZFYU9nZ1V3SHExOWFaZnpz?=
 =?utf-8?B?ZTBuTmovR2tIai9KTUJBTHhJdFlSN2gvT0RRYlpZMzl2QVpuQS9mYW5FNUxR?=
 =?utf-8?B?cngydVZWVHpZNmF4djRVRWhnMUdVR2Rtd0ljWGJsNUFmQ2E0Z0I4Z1h5bFJ0?=
 =?utf-8?B?aGQwSnZjcXVBMnpsTkpXQVAxaU5VRzR3WmZoK2FDaXIwTFdhMG53NVQycjUx?=
 =?utf-8?B?L0dwa3kvSzNXandGbml1K0VMbkQzQXM3RXc1cjQrMkVyRVdLYllyUjJWWFFY?=
 =?utf-8?B?U1VNMjF4ZVJFd09wRUVHL0NuOVFlOEVkMlFpYklka21kL0UzWTFpTTRMMmpC?=
 =?utf-8?B?eENHaGpuUENnaE9xaEQvNlZ1Q3g2UitvZmhSa0J0ZlkyNEhSaVVsWmNYbjlP?=
 =?utf-8?B?Z0FtTTFxT0JKdkZjbmFZRkJBendpRnBtMElYSitFd0k1VlQvdTgrWGV1Q1A4?=
 =?utf-8?B?ZG9pUDg1SlE2WVpyRnlaalhXWnFEV0ErZGJaTzlGWjcrYzIxUVpIY1Fxc1BB?=
 =?utf-8?B?Lzk1LzI3RU9TY3p5VHRxNmtRb0U3Q0NlUjg5NC96VXhvd0xobU0zRi8xa2hl?=
 =?utf-8?B?aTlIWFo3cysxMUpKd0pCMVhwaituOXRFeVgvNlZTQUdnTis4bWJEOFlNSm5o?=
 =?utf-8?B?bXRsOFY2THhxQnN2R0JtMlBsNXkrZFVoYVNpT1dNUC8zcHJSR1lmMldrVHJO?=
 =?utf-8?B?cVZJUFZUa09HRG5UZGQ4ZkNEK0xZbllWSVdpWm5jWWM3TXJWQzBiMERBNkZG?=
 =?utf-8?B?SVZ6dkZDUlVVQk9nbm9EM3VpTDE5NXJYWUM0YXVPbmw4Ry9pRDhoUDNVK3Fz?=
 =?utf-8?B?dFVLSzRHL2h6Mkg0NEVrVUlqQnFsRUlab05za3BnSkRrYStkVkZwSkJ0dmU0?=
 =?utf-8?B?Z2tEVHRhM3ZMck9wYklldWNDdWVWMTBqZFlqZHdDUlFRRTR4bFBFaGJkYnhS?=
 =?utf-8?B?WFg4dnE1Unpuek1JaFlBVml5dTBUb3duSTlDQzZDS2tlaFJpZ1VSZ1A0M3lZ?=
 =?utf-8?B?eHBXQjVKeVFURWZkeG1RM1hnOFlsdmdTcEF5di9VUWRicTJvcDU0S1RwL2g4?=
 =?utf-8?B?MzlId0pRRzhITllrdTBBWVlBM1RIWGpYbWIyZkVXMGxIeUVZOGtpNTZQbEZj?=
 =?utf-8?B?YVFiKzJDeUZVMjBSWkx0V2xWdkpOZmtRdURMSjlvdTFhbzFNMFlkaWc2S2ps?=
 =?utf-8?B?TE40dkFDNnFJUTlybHdDYUtqRmZxcmVwTURyVm4wLzA0V1R0ejFzSHBybytR?=
 =?utf-8?B?MnRnVWVYaVlTM1ZyUzNtamY1Nnp5bkxZS0NoZ21MRXUwK05KSXJxcWlHZitQ?=
 =?utf-8?B?eldaN0RpelBIR2tMRlRKakdzZjlTQkY2NFJReGN1UnpwSjJOS2ZDWnByWGU4?=
 =?utf-8?B?RlNQYTh0MUd1RUcyYkdUa21kMy92enlCaWZoZVJ3Sko4SmwwaWRSZ0Ricnhy?=
 =?utf-8?B?Vkt1d0NMYTlKNGU0MlpQbFZwQ0RLNjZMZWNkWlZtWjZxNkJjTlBXbXdrY3g5?=
 =?utf-8?B?WVhFanBnZlhZd0JBbzNUNjVxWnJzblRqeXlLd1lncXZkUmsyRmFmMjN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enFYMEE2UnlCdkczSit1TjdFL1NYN0ovejFwR2FuZ2F0NnNteTlBeGw4Vmw5?=
 =?utf-8?B?WTY3dVAyL2tmV2pld0hGczB5VjRLYkpWek9xZzRvMUxZMStUdHpXc2hDMHVM?=
 =?utf-8?B?aWY1YUkxMTh5bTQ0eXdiL3lZenVZeitlYlZiRUFMczdNcHY4RTZaMXBZUlhw?=
 =?utf-8?B?QlVOVjQyK1dZU0pIcTVXQjRjbGthNjdsZ2h6cHIwcUp5bEROY2JuamltRXFF?=
 =?utf-8?B?Zm9SUXpYSHZlczNHdzNyWXlJNGFJMUxhaGlkelFUdzhwbkRPSW8xQlRlWkdp?=
 =?utf-8?B?dmM0OGdKZVBNclU2RmV3ZzFnaTFpUGZNS2NqYXk2V3VKdkxyNUZxRjdQMzNF?=
 =?utf-8?B?UTJ2MHl3WEN0ZWd1S2VrS0UzS0sySUczVE1UN0xtVzR6K3g4bnZWbGFvUHc3?=
 =?utf-8?B?eDZDalpOc0g3eVBMVzlIeEZzS3J5OUNJcmdkS2Q1THdBUW85YiswbmtKaDNR?=
 =?utf-8?B?U1B4RTFxbEVFZzNvZmViTHpDT1Fxb29aaUcxUitHR2QxZnJ2RmY2MVJUN25W?=
 =?utf-8?B?aFJoWkRHaVZIZXY2MXJpRlI1bVFpYmx4bkljb0RFazJGZnlSNWloYXg3SUFM?=
 =?utf-8?B?cG11VTJOUXVzWnM1ZlJERVExNlltbkVWRjBKRDJibkRwb3hFSHN5aDMyUEUx?=
 =?utf-8?B?WG05OWZDeEoxYiswMW5FbHFYSTFmRUhvWEp2QTlTem5aNUVmVkxPaFJTRDkz?=
 =?utf-8?B?M3ZES1VIZks2RUE5cTlqMzBIYWwvN3Q4cHVEMlRJQitkV1g0QjFoTXZ4SHBs?=
 =?utf-8?B?R2RMekdZN3VCOC9uNnNaUFNXTlNRK25IWldTN2RoYzNxd3F1MVZYYlVmZEJI?=
 =?utf-8?B?Z2ova1VrSkd2S1crNURNWnRHa0taeUR0OXloL0s0aVFCNzhJb0lQdE5iSFhE?=
 =?utf-8?B?L0hScy9rclFsSW9hcWNaVXhMYVFJVENybUQwcUt6cXF6SmlVZWExRTR5ckxt?=
 =?utf-8?B?Z2VKeGVwTm9PeVNOWWtyNU94TzVQWno1eHVMdkd6VG5WSDJHbWJCaDJQc001?=
 =?utf-8?B?NUtVemFvSGgvOGlxeUp2bmFqU3ptMU5BeTFIY0xnTDhiNFB0ZUhyRE0yaC9C?=
 =?utf-8?B?bWhLcjE2WHhIbUVUWFRjUDdQMFM2WjJjbXZCcFF1TGFqZlpmcHd5eENHUzFo?=
 =?utf-8?B?RHhRWkpsamZHUFIzWS9yNENiQWNheVVpc1doeVkzcytpM0hPWGNMVzU4Zkh5?=
 =?utf-8?B?dHBnQzdERWh4SVYxRDRkYmhIWUR4aFg0WFFOaXhrUUs0L2dPeE13bDlMWTRY?=
 =?utf-8?B?N1VqekF1NjJTb1R1YnhlT0EyQVVhbU80SVByT0NDMkRDWVRUUFdqMXROcWwx?=
 =?utf-8?B?N3NHWFczV2s4NUtuc3NqL0dWbE9PRGpGK1hNUDJhU2UvTzZQK1YwVFQrQ0Y0?=
 =?utf-8?B?YjE4UTIxSUhKVmlkcHpOMlB4bzRka296YitvNXExSlRRTVBCOS9LYWZwRlBM?=
 =?utf-8?B?U3JzajF4djJrVm1KR1R1NExoYWdyZ2kxczJvYlZLeXlIMm03K0N0NFdJbTFj?=
 =?utf-8?B?RXVVQVYxUDR5cWxaK3FsaXZiZFdUcTdPRHB5VkNWbURla1haQ01OOEk5QW9N?=
 =?utf-8?B?LzJoM1FaSDAvWmppT0t2QjlMVU5DQzZaRW80YjZkcnArbFNIM0hGTXdTanBW?=
 =?utf-8?B?NjhMdXZFd3B3c1ZxODV2NWJDTXRuNEZHbHU0U0xieHgvRTg1K1A0V0MvaDJB?=
 =?utf-8?B?bE82dnFybzNDWUtHdFlhV054a1ZkNFJFdVNMeUhHZFJJZXRvRkZVekRnKzVW?=
 =?utf-8?B?ZjRpSWZjRlBMWkpHbkFlc1cyOXNmRThyV2ZCajcxWC9ZcmZPMUJWZGNXd2xU?=
 =?utf-8?B?WE9QaGltd1JXaDdJOFNTZU5WTUhJOHBnN3BLSlk2R2src0t6VlBXV2NMZlRF?=
 =?utf-8?B?aEJ1OEMzMGZUZG5GUHREcTFaZXh6K3N2V1kzSVZaSHk4dGpXampRblhwUjdu?=
 =?utf-8?B?OHg2Y2ZrdFpHNGwvVFoyZUdiSTYxVUNXTnNManA1OEhobGRleGh1MTA0T3g2?=
 =?utf-8?B?SmxIM0dGR0kzM25vTmF4NVFOZ3crNkdCcTQyRytlaTlySlB1K0w3Y3lsaWFr?=
 =?utf-8?B?cFhZV2JmeWkrdTVnUjlndVNPVmdSOU5WT2xTWVM3M25SRmdqZHhneWdlbExF?=
 =?utf-8?Q?+5bM1wdPVLGTI/qP2sm//EiJo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6ccc14-afe3-4081-5141-08dce8a82900
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 21:20:12.0931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2o+293thBSVlM2LguxeBeTq2UghwdSuX+ef3Yxm+alGaz57Yb21omE9o2ivmaBJiFZz3fOJQ4kyJPLespQLIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357
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


On 2024-10-04 16:28, Philip Yang wrote:
> Per process device data pdd->vram_usage is used by rocm-smi to report
> VRAM usage, this is currently missing the svm_bo usage accounting, so
> "rocm-smi --showpids" per process report is incorrect.
>
> Add pdd->vram_usage accounting for svm_bo and change type to atomic64_t
> because it is updated outside process mutex now.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c |  4 ++--
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 22 ++++++++++++++++++++++
>   4 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index a1f191a5984b..065d87841459 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1148,7 +1148,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   
>   		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM)
>   			size >>= 1;
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + PAGE_ALIGN(size));
> +		atomic64_add(PAGE_ALIGN(size), &pdd->vram_usage);
>   	}
>   
>   	mutex_unlock(&p->mutex);
> @@ -1219,7 +1219,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
>   		kfd_process_device_remove_obj_handle(
>   			pdd, GET_IDR_HANDLE(args->handle));
>   
> -	WRITE_ONCE(pdd->vram_usage, pdd->vram_usage - size);
> +	atomic64_sub(size, &pdd->vram_usage);
>   
>   err_unlock:
>   err_pdd:
> @@ -2347,7 +2347,7 @@ static int criu_restore_memory_of_gpu(struct kfd_process_device *pdd,
>   	} else if (bo_bucket->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
>   		bo_bucket->restored_offset = offset;
>   		/* Update the VRAM usage count */
> -		WRITE_ONCE(pdd->vram_usage, pdd->vram_usage + bo_bucket->size);
> +		atomic64_add(bo_bucket->size, &pdd->vram_usage);
>   	}
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 6a5bf88cc232..9e5ca0b93b2a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -775,7 +775,7 @@ struct kfd_process_device {
>   	enum kfd_pdd_bound bound;
>   
>   	/* VRAM usage */
> -	uint64_t vram_usage;
> +	atomic64_t vram_usage;
>   	struct attribute attr_vram;
>   	char vram_filename[MAX_SYSFS_FILENAME_LEN];
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 7909dfd158be..4810521736a9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -332,7 +332,7 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
>   	} else if (strncmp(attr->name, "vram_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_vram);
> -		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
> +		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
>   	} else if (strncmp(attr->name, "sdma_", 5) == 0) {
>   		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
>   							      attr_sdma);
> @@ -1625,7 +1625,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	pdd->bound = PDD_UNBOUND;
>   	pdd->already_dequeued = false;
>   	pdd->runtime_inuse = false;
> -	pdd->vram_usage = 0;
> +	atomic64_set(&pdd->vram_usage, 0);
>   	pdd->sdma_past_activity_counter = 0;
>   	pdd->user_gpu_id = dev->id;
>   	atomic64_set(&pdd->evict_duration_counter, 0);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 857ec6f23bba..61891ea6b1ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -379,6 +379,7 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
>   static void svm_range_bo_release(struct kref *kref)
>   {
>   	struct svm_range_bo *svm_bo;
> +	struct mm_struct *mm = NULL;
>   
>   	svm_bo = container_of(kref, struct svm_range_bo, kref);
>   	pr_debug("svm_bo 0x%p\n", svm_bo);
> @@ -405,6 +406,22 @@ static void svm_range_bo_release(struct kref *kref)
>   		spin_lock(&svm_bo->list_lock);
>   	}
>   	spin_unlock(&svm_bo->list_lock);
> +
> +	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
> +		struct kfd_process_device *pdd;
> +		struct kfd_process *p;

Move struct mm_struct *mm here as well. It's only needed in this block 
and should not be used outside.


> +
> +		mm = svm_bo->eviction_fence->mm;
> +		p = kfd_lookup_process_by_mm(mm);
> +		if (p) {
> +			pdd = kfd_get_process_device_data(svm_bo->node, p);
> +			if (pdd)
> +				atomic64_sub(amdgpu_bo_size(svm_bo->bo), &pdd->vram_usage);
> +			kfd_unref_process(p);
> +		}
> +		mmput(mm);
> +	}
> +
>   	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base))
>   		/* We're not in the eviction worker. Signal the fence. */
>   		dma_fence_signal(&svm_bo->eviction_fence->base);
> @@ -532,6 +549,7 @@ int
>   svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   			bool clear)
>   {
> +	struct kfd_process_device *pdd;
>   	struct amdgpu_bo_param bp;
>   	struct svm_range_bo *svm_bo;
>   	struct amdgpu_bo_user *ubo;
> @@ -623,6 +641,10 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
>   	list_add(&prange->svm_bo_list, &svm_bo->range_list);
>   	spin_unlock(&svm_bo->list_lock);
>   
> +	pdd = svm_range_get_pdd_by_node(prange, node);
> +	if (pdd)
> +		atomic64_add(amdgpu_bo_size(bo), &pdd->vram_usage);
> +

Would it make sense to save the pdd pointer in the svm_bo struct? The 
effort to look up the mm, process and pdd in svm_range_bo_release seems 
quite high.

You could replace svm_bo->node with svm_bo->pdd. Then you can still get 
the node with svm_bo->pdd->dev without growing the size of the 
structure. This assumes that the svm_bo cannot outlive the pdd.

Regards,
   Felix


>   	return 0;
>   
>   reserve_bo_failed:
