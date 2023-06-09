Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B72C7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 19:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5264610E6DA;
	Fri,  9 Jun 2023 19:34:32 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D48B310E0CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 19:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMmPnHvR7zr45LUbq+fqRuFyvcnlyTPqiW4oe7UHdoxqZACvUX54LBMtAyOQKjoQoEJiGpXpGRWwgldvtgCvXQKyK2LxSEtyTNKxoZ5QtJKfue3TxMUCROwyg939xzNziAQ462Hn1p7iAYhJvJ6zsZLE/GppKrPCKO8It1rGN8ulY26l8ndEiOZuVjqAEWifFdf2KTNItVesLszTIa37Uh9XPDyq/MoRrBveWTTO1f1V1nrQQRvVSVRpRaHGu/Dva+UZBgvZa3r+VErJvGZoCU2O0Tn1r/Yn9WaxC1TYrQyWU0jiBl3TZHMW2lFBBk3YJkIDDZ1IWcHxRRToQGdrLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47qbcxdjnHmvTGjEUQZkWC8ZjrtU+GVf5MGJdATavOA=;
 b=THGVkIt7ufh/516bUXSueiZWbcFMcLNR+JDk0fka0T0/7KwYhLnod83vU/9MPCMScm/g5wjCqHf8ekleRJibwA18cuYA4lhyq+4qprgxNzR0U68qlaU+m1DSLKD1EQRMbfJxjoF0flKKhztBN0OwzCGdsVbAmvBL/GrHlGkk6JMtixKmUXmkcnXLdOWjHh5irI4vZAhwpKcmJUdXlEhGzorFsgMbG2kbHEnCjdrxhJiqasIoyrXdc3sa+hpVhbmK1dl8577F1LSE0ajjve/TVt8MGfbwjhRSii17DVyGRged2s3weIWVE8qO9fip3gzMWuxYWXdt96oqhVxyJCO0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47qbcxdjnHmvTGjEUQZkWC8ZjrtU+GVf5MGJdATavOA=;
 b=UQoFhe5sq+uu+v/0FM9nKiYs3+CIhEwibrmQFFgYuxFz1DlFMBDN9dIt2uneyDI55eJLhegM12eNxqUEiGziMD0AaRpk7o7b91KC4wDfMdghOh+bvsL8J6xhtz4Fdex+eNn/I8VnAAbg/81VuJkGtals42VPmmi+u9D6nl+scHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Fri, 9 Jun
 2023 19:34:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:34:27 +0000
Message-ID: <ed23c69f-ab34-86ed-4df7-1590430ce441@amd.com>
Date: Fri, 9 Jun 2023 15:34:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/12] drm/amdgpu: remove unused functions and variables
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230412162537.1357-1-shashank.sharma@amd.com>
 <20230412162537.1357-11-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230412162537.1357-11-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef1edd0-ecbd-435c-ef0a-08db6920896d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/W0CG1JyPzWyWg7lWeROSS9jRucDH4bpmekcp0Med5/K8/z3XADwTqYwuSQJ4nxDLvsymGoVKRzNVQMG/1I11+jQxBmQ9QFxEjjobbDt+0sRbolVI6vSNJ+PxKXlLtfWQ+7spAkOqmtapwxosF9maZUlfWL/rVFXcJGrPooQ3M9HjoNmJpGL37tHL+jlu7MYCI178R+iiIttbqB5xsaxek1O5f8/iHuTWLOFCVlid0KGnD0KcEmlWvltxO+pDOiGIfFLEnf2F7dT6rXhbbojcSQQsSwqWo3/HAx5f9ppDCXlSyXBMYlrk0ZsjdT70uMCkW1o+4Pq6EW2D567MXiaH4e/zCZVGMVek+jc/XM271HbDg7Pq8T5jrL+Fq0B+r2eCDVqBcLTN20Z4c4znstZnT7uz21HE3CYzECekU0IbDU5SO1x6iVrFR7yIKWhgmVTSGxMDlVlRubOsQxNNgxT34y7DyHNTv8taO5aE5GCS85+IMZK6i3hZ62UEb9Q3WQ96zqpL7/7l5R+zr2WrzQsZNDi5RbUmKFNRGze6QtNoJYwoNinuSlwiu4BYAJhfQVmKP9OGaOfn2snJYRyxKevsBeEDTbwXwYjHRBrQgIUPt8wefz/GmXuk6Y+vL4r+GSA+6AEuxY4OMYeGa8+eRlxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(66476007)(31686004)(66946007)(66556008)(8676002)(8936002)(36756003)(5660300002)(6666004)(4326008)(478600001)(54906003)(36916002)(41300700001)(6486002)(316002)(38100700002)(53546011)(26005)(44832011)(6512007)(6506007)(186003)(2906002)(2616005)(83380400001)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b09xNjd3eU9ZY0JjdndYbkxERzJMT0xrN05aeXQzRzZseXVjUUFyMHBQdXJz?=
 =?utf-8?B?TEhCSTcrUnhQbjFkaG1PY1JQUk0xZ0xOZlQxY2gwMEFQVXA3NW1yY1JTWHIv?=
 =?utf-8?B?K0FORGd1aXU5UXZCRFpqRFEva2dLSUx2MnloOUdPeXFSaW5ydFRCSHF3ZllN?=
 =?utf-8?B?VllTQnBkUTB5MDRZM3drWkVyV0ZRNldJb0x5TzI5bDdiREFRZ1RpMU81VjhS?=
 =?utf-8?B?QWRZVjdOL2x0c1ZCeEhkOUErMWhMOGozak51UjBrYWh2SHFDdCtaNFdLM3Mr?=
 =?utf-8?B?cG9RaStuQzFNY09lS0JnUFJrTlVXOWRYKzYzRlV1QXlEajNmVHNpYXE0WEZO?=
 =?utf-8?B?RHllU24yUTd0UDdscXZGQWVEaXhwZytXU09BU2M1NitySGh4QlN4SWl0WS9t?=
 =?utf-8?B?cFZGcDB2eWZLQUMvbFRKMzFHZFRzUUpRc2JkU0pDTXAzQVpjTENWd0xzSmNM?=
 =?utf-8?B?d3hERUtPUjNiQkl1b1JHQ3dxWmR2V01uU2pSQVdpSFZWNjdpa1pZNzF1dGdm?=
 =?utf-8?B?eUptWUlrVG9ZTHZhK28ybzBvR3ZUWUxEVU5WMmlqSGY4R2N4ZXYyaWZaNHpN?=
 =?utf-8?B?Q2k0VUZHVEx5MEIrUXdDYjd2Tm1CQzVGMHlpbnlDeTZaK3YvemtRZ09oNVMv?=
 =?utf-8?B?bmk5d1ZTRE9maTVVUVdhWndjS3EyZWJReDh5Z29ZaERMa1BCZlczY3NVUUxE?=
 =?utf-8?B?SXB5cVgwemc1Sk85YndQQ0QrWG56RlUyRlEzTFZOOS9nNFVuMzlxcVltN1lB?=
 =?utf-8?B?T0p1Q1UxVGFROW5haGJacGtheStVQVA2WHlkQW8rODB2bTFIdkwzOElrL0th?=
 =?utf-8?B?TE90V01idmRhbi85amJJMnhIejArOFc0S0FOelU1VExqRzk3MWNBcEJzb3Vm?=
 =?utf-8?B?djdEcFd0NWNiY3A2aDdZQ0NiTHhJeUYzMlYzMitBZVhIY3N6c240dm1GVnFC?=
 =?utf-8?B?VmloM3ZneVFNanpKMUNoS2dLRGNCYnlXOUEwTlBsb3MzVmNaRVBxUjNYZEFO?=
 =?utf-8?B?ZURrcUhFKzRFTlpvRUJSTmNuQWtRaVVnOEh1RG44T09Sa2RheHdDTzk5R1VZ?=
 =?utf-8?B?ekRwRjFCTE4rUXJ3Smg1ajBLYmQyVHRrKzNUSEljKzQ1NVhyc1Z6YnJwN1g1?=
 =?utf-8?B?MXZIb3lYTzBielVkdGxocjA2R3FlWlQrMmdhY1ozYkZNc3JhQ1pPRVRidzNI?=
 =?utf-8?B?MGZLMXhLREFCR0U2VHJuUlJFYnlQZlFjVEFTL2FHMnlpQzJpNUJDOVQwakNR?=
 =?utf-8?B?dCtzUnRVQ1hiZVFXZmVpM1BMY1FaTUE4Rm5BTmZxR2lDZXNNcXcvZDVvQ0hJ?=
 =?utf-8?B?d0JkMEJqeGtFUzY2dStFYllVMVNjS3plMTRaaVpBa21qcUFDSmU1UEFyUFNI?=
 =?utf-8?B?YmgwM2VTT0xjejVidXpjR3FRRUZna3JWQTlBdXJMODBtMTJZekd6N0p3MVg3?=
 =?utf-8?B?NjFNa2tKRVZaSDJ6V0h2M09QOWRnS3FEZlRidHQ5b2lJUHF1RWxpNHdGdmh2?=
 =?utf-8?B?UTlMcjhnK3UzQ2tYSldiZGRaNjlHRm5lbWdoN1NXWWE1blo3NkZLRk8zRVND?=
 =?utf-8?B?djhjN2JXdnNTWGZnWEJ2SkdwNk82bmJJbkpRNHlodkpvSEx6ZHRCYWZrNlBL?=
 =?utf-8?B?VUo2RWVIQjE5dUk2Y3d3M3RVUCtwZVQ2bVV4SVU0VlJTclN5N3NoWUFtVERZ?=
 =?utf-8?B?ZU5LODN1cGk2MzdQdlkzL0hhTEl5SUMzSDh6ZGIvZENGdTEwYVliYnY2dGVD?=
 =?utf-8?B?R2ZLZVFpdE1NL0U2RGJBeFg5cGdjdlA2ZmtNS2U3eG5NdDhJZjVNY1MyQU1Z?=
 =?utf-8?B?YUZ3ZUtGY2I4UXlaK05Ia2g3M3lJSXJtQUZjc2tEZEpkRGt4enBsQUNpZC9G?=
 =?utf-8?B?SkRmTm5UN1IzZU9qVHF0enJzL2pnekpEM0dCNXZWR3k3bHRSWTkvN1hUbW5l?=
 =?utf-8?B?MFZqMGRSeTNSV0NkL3lwVCtlSEloZXRCWElJclRYU0JWWERGdHNFYitSRWpo?=
 =?utf-8?B?cFZ1cTN5Z3BTRVVBVXNzcnViSTl2V1ZaTlpVbHFxRCtWajFXTXdQVGxDZEVp?=
 =?utf-8?B?SDRMaXcrMENBcXhLOXBJaFNNUEFITDBicjJBU01hbTdzdEhFT3NKM0RhcWln?=
 =?utf-8?Q?6HxQw5z74BUtEdj4Y6qF1PHuZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef1edd0-ecbd-435c-ef0a-08db6920896d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:34:26.9898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gn3QbfDnQgKaede4AnueOwhbFuNDeeiRfG67yX+C95VbIFMfaIEndOISxsNhPjex54XoW5wAubz7IicjM0K+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828
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
Cc: Alex Deucher <alexander.deucher@amd.com>, mukul.joshi@amd.com,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>,
 arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-04-12 12:25, Shashank Sharma wrote:
> This patch removes some variables and functions from KFD
> doorbell handling code, which are no more required since
> doorbell manager is handling doorbell calculations.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 32 -----------------------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 12 ---------
>   2 files changed, 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index 718cfe9cb4f5..f4088cfd52db 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -193,38 +193,6 @@ void write_kernel_doorbell64(void __iomem *db, u64 value)
>   	}
>   }
>   
> -unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
> -					struct kfd_process_device *pdd,
> -					unsigned int doorbell_id)
> -{
> -	/*
> -	 * doorbell_base_dw_offset accounts for doorbells taken by KGD.
> -	 * index * kfd_doorbell_process_slice/sizeof(u32) adjusts to
> -	 * the process's doorbells. The offset returned is in dword
> -	 * units regardless of the ASIC-dependent doorbell size.
> -	 */
> -	if (!kfd->shared_resources.enable_mes)
> -		return kfd->doorbell_base_dw_offset +
> -			pdd->doorbell_index
> -			* kfd_doorbell_process_slice(kfd) / sizeof(u32) +
> -			doorbell_id *
> -			kfd->device_info.doorbell_size / sizeof(u32);
> -	else
> -		return amdgpu_mes_get_doorbell_dw_offset_in_bar(
> -				(struct amdgpu_device *)kfd->adev,
> -				pdd->doorbell_index, doorbell_id);
> -}
> -
> -uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
> -{
> -	uint64_t num_of_elems = (kfd->shared_resources.doorbell_aperture_size -
> -				kfd->shared_resources.doorbell_start_offset) /
> -					kfd_doorbell_process_slice(kfd) + 1;
> -
> -	return num_of_elems;
> -
> -}
> -
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   {
>   	struct amdgpu_device *adev = pdd->dev->adev;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index dfff77379acb..1bc6a8ed8cda 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -257,15 +257,6 @@ struct kfd_dev {
>   
>   	unsigned int id;		/* topology stub index */
>   
> -	phys_addr_t doorbell_base;	/* Start of actual doorbells used by
> -					 * KFD. It is aligned for mapping
> -					 * into user mode
> -					 */
> -	size_t doorbell_base_dw_offset;	/* Offset from the start of the PCI
> -					 * doorbell BAR to the first KFD
> -					 * doorbell in dwords. GFX reserves
> -					 * the segment before this offset.
> -					 */
>   	u32 __iomem *doorbell_kernel_ptr; /* This is a pointer for a doorbells
>   					   * page used by kernel queue
>   					   */
> @@ -276,8 +267,6 @@ struct kfd_dev {
>   
>   	const struct kfd2kgd_calls *kfd2kgd;
>   	struct mutex doorbell_mutex;
> -	DECLARE_BITMAP(doorbell_available_index,
> -			KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>   
>   	void *gtt_mem;
>   	uint64_t gtt_start_gpu_addr;
> @@ -754,7 +743,6 @@ struct kfd_process_device {
>   	struct attribute attr_evict;
>   
>   	struct kobject *kobj_stats;
> -	unsigned int doorbell_index;
>   
>   	/*
>   	 * @cu_occupancy: Reports occupancy of Compute Units (CU) of a process
