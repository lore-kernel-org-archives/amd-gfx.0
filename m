Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE311C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1416D10EAEA;
	Fri, 11 Feb 2022 18:59:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F031110EAEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wmh0WDibeC686ePsOlubS6upjnymClt1I+/CzccmHz+gP3AZ7Tfc7usYzgAszYwmwV8PkOpbEd9yTo+2FrQRn7VLyUdZo7YwYiojz0Ny1pTpteleLBtTpGzLRtzXgcrsKDIq7Qhc91S06PDFdJJcsb9bLqYcOsDRdAHIYHhAF/KafD3uMFTjdTgceLvBlVyF7qMAQyCGcjTbW/DnMl++dUjGqdHH+50Dtgf+n2JyverrT8muSo4HubmqNN1Op9M0j2aMx0Lml+Qkr8wLyFf54WSieTYF9WmrQtk2RHZRHdQ0uc0WH2KFVTOAraRbAUtZgVqssqTRYHIg1foq5nqjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F00QmsX3B+/K0G0DeBPXk70N8oahT+KiD4Z1DEDC4V8=;
 b=JCTKDznfANTNiFAxr6uAa3SsdQd8rizXOBM1Kw2JrKIZNxA/lE1Ig5XZ0+OaAh2LgfRKqkCKsYpisI2UKg07lmbfekdWXeJHoDHdRcv+Ezl4Qp9Gt/yCXtikh15w2wBJsc4sEHj1g9vnsEhOT+IRv0NwlZVXP7WrwIKOaKk8f5LFZlijQitegxihxyHsVpWkXOIp2hg6YP412WKYL+BKjlFC2B5Fk5tfpT+0rgGtWWcen1FMv+AvNR3BvVsY8xgYPWhNIm0cxf+MUUh6aP3uo+xRoJ/v4+R7MyxX/RPAii58kU4TXlVhRVNgy5Q6Z83Fn28Z8975pv73GFv01uOeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F00QmsX3B+/K0G0DeBPXk70N8oahT+KiD4Z1DEDC4V8=;
 b=wSq2klhxP4hDX+NJ9wwRiZQdASSCSVLYN9sYsgqDlnE/TbHjlUsJIVP9LJBqlHjOmeTSv56BZ29pHhqkJ/fl6M6joyXWURvIQwdjOr+23fE+fZ1OCWrdVb+WpNdPoGLSmFQx/d1rOU2gAovbKRWtbcNF6ADrFvOEoWWN7SRJIQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 18:59:20 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::38ec:3a46:f85e:6cfa%4]) with mapi id 15.20.4975.014; Fri, 11 Feb 2022
 18:59:20 +0000
Message-ID: <567633ac-2f46-6b76-c12c-b16b999d4500@amd.com>
Date: Fri, 11 Feb 2022 13:59:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdkfd: remove unneeded unmap single queue option
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220211171529.923453-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220211171529.923453-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTOPR0101CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e88fa4cf-caf3-4e65-3af4-08d9ed909bcc
X-MS-TrafficTypeDiagnostic: BL1PR12MB5779:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5779171CF7C9A52DB7ECBDC892309@BL1PR12MB5779.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJvbGrX3ajaXgVztTiJh1vayWvG7tQYxGpM/3jERvxE2ZCzodILgGe0lJ0JYrJoc8l39jzWKgVpZvONOIveLrLZLTkdOd6fl8tAefTgP8P9MKPFCDDEGWemCqeHtG1aygVCEAOezasPHHy/K1ySMglEZ465h//WzDaqif9zff8w8agAJ124QuKToZJ3u8Tl2+66QrrTScIoHJfDqJQp5NuxhmITpi+5FHIWyLhP2Eihe6QjmJp2eiS0N3C99+Lz+ktC84P2jHoK/85mHKVGMoo4T9eP46EhvYSASS0d2PEqjBHR4UeQOgavjT3NJanLcq4pS9hl4eUVgTSyUkeSD6EnW6WFULlisYECBw9FH8AXxrujgMgf9XA17eHbbuwJpoNjkbts45J4CE+L7GA9Zw9Hg1opPxv2/EPnblq9Jm366gZZ98kdOOBBh/Arlmtmw/WoGZo4m5x5zxOQWiC9SJmAoCzkluh6UrZpwCtcHduunvtxkSBVugysMM3DJszaBJqAsngs1m2In3aTyUxNrUnNwIK3U1vC+TA1qcoOfSEENdC1Y7J6NmJ00JwuOj9Fr93evgEfTNG2zed+iQjP59RlQCuEe8L6j/zb7A4Qig3pfxDDTz0x3SqBCxcds4lLg0HDOSRka8QawQ4X0jH0Hl577+xAd8ylnuOjqQ/2BSGKw1x/vvHhAtVcJG5PWeVq2/1a4i4UiyffnwLLS9x4NtactpNrQmFyNb8GQXAdkSvuxb1j0XP+tw+L7jgVIQgPV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(44832011)(6666004)(2906002)(6486002)(508600001)(6506007)(2616005)(66476007)(8676002)(316002)(8936002)(83380400001)(66946007)(5660300002)(6512007)(186003)(66556008)(26005)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmVMUG52UW5PWG5oR0tPMXEyVU9xa1FNYm1sbEU3Z2F2M3hrZ2Jhc1hNNHBE?=
 =?utf-8?B?eE1xQlQ3ZnRJRmFmcC9YVkFNMit1T0krNjVDNlBjMHVjSFVScUVGK3NNUGJt?=
 =?utf-8?B?cWJXZW1HcUs4TmY0S3N5ZzJBQmIraStlU1I1YXpwQm1pL1pNTlFkeHdGbHJZ?=
 =?utf-8?B?Q1dOQkVqYUVHcGtpYTZXbGlObWt2bWdwTSsyaUQ1UGtsemVaNW5ZUmZzRnJW?=
 =?utf-8?B?VmsydUVkb3dDWW1NMmppeFJ4ekhDbDc2bXZwRWRpd3pkRjNiall3MkhEbmlk?=
 =?utf-8?B?dWt3dlBjNHgzMHpoU1hWWmRhb0RSQkdZN2VML1o4MjhhSGU0WmRpY2J2eHZ2?=
 =?utf-8?B?QVFGbzl0b09CUDRVdDJkUW1FbW9wNytBU1hiMnNVM29jNkQzejVUbDNzSUVt?=
 =?utf-8?B?bjE4QmlCbVhRalh2bkh2emtsNkJaMWdOajhncEppeU9SemI0T010QTFRbUVN?=
 =?utf-8?B?NEJKa1A2bUFMMXFBYWoyRVU5S1Q3cWJnbW44cnBqNXdLSi9SRUpTYjBUcGxy?=
 =?utf-8?B?TmhTMm5YUTNBblQ3Q3hiU3grYVMxVnRJd2oybWN5U3lKZW50aDQ0Vnl2Q0lW?=
 =?utf-8?B?VXhBZFZQY0trcXZYck8zOGh6dEFxbElBajdOWXRETy9aeXZBdDdJTk80TXNC?=
 =?utf-8?B?OWdJZWF3YTNrQk9tNFNzdWFmalRQekN6MC9qWjZEZ2RJb25mbnBzZXRDYTV6?=
 =?utf-8?B?cmIyMC9WUWwrWE00L0Zla01yREcxbXRyZ0J4eFl3aStnUWYzTGFieFd1R1RV?=
 =?utf-8?B?NGdhR3c4b2tUaXZIa0w3SklpM2xHT2U3L2pWd1hHa0pGYnE0b1RyR0ZyRXcz?=
 =?utf-8?B?V2dHNU5iVTJkTGlTK2ZvOHdWWjBXZTVWNWhqcDUrTHUwOGhhcnlxaXN6Y29M?=
 =?utf-8?B?ZDk5T0V1RW9xd2FxU3pBc2lyYUtpL2UvQVk4QkpIdHFPdDJRM3daZE8rWGRB?=
 =?utf-8?B?R1RyYnkrOWxtUnJ6aE84Y3huSGQ1RzMvWFVjSXlJcVR0Q0JTRkZOWlBydGJC?=
 =?utf-8?B?NEQyeG9NanJySVVlQ242VnVGNnJLVTk5MTlsTTdpUE0zN3ZXWjFWU1JuTU5Q?=
 =?utf-8?B?bDh5YzBUMGNodnoyUUZhNGg4TFBnNnV6OExqQml0eUdxN0Vja2Z1NGkwUVdp?=
 =?utf-8?B?bHNBZ2NDTjVUbUhob3dWRUQ4MEpOVVo0U2ZDWVI2WTBtUU4yc0NVZHI0QzZo?=
 =?utf-8?B?ZVh5S3FmUGFkU1UrMXdUUjlmbTZwaE5CYWlGc0ZSUnRGK2lHSEJ3d081U000?=
 =?utf-8?B?ZkNCdjVqcGxEQ0pJNFJTMUk3cFV1RWI4cmgydEEraTRGMmIyeVVpbEtmSHdu?=
 =?utf-8?B?dFlrVG1rRzhpK2JONFNoczg5eEdXbVlaVDhZeldlZTN2VE9aRXY0M3ZQODJU?=
 =?utf-8?B?ZytnK1lSZjIwNWwvdTRoNlNkOHFDd1BuWmdKaTJsR0NnVnVFVXFjcGcrbGl3?=
 =?utf-8?B?Ny9hME9TZDVqdyt1U1FjWCt0RkFOSW5RTEx4NkZ6UXZpNVdEN1VNZUZUZ1N3?=
 =?utf-8?B?UEZ2WURSNUlJbHVSU1doemtRY1pFUklOenBjbm5wODFDbjVHYjBsMzFvaG81?=
 =?utf-8?B?ZzRPbFdFbS9NdjdlbGl1R3MwS3FQd0YrL2piUW45REFHVllkbUNKblFBRDk0?=
 =?utf-8?B?cVdwR2N3ZklxNzRvZllsMnVteGxaUTV4Q2ZocnpnaW85QXRlcjNlM3RIWU05?=
 =?utf-8?B?dGdTQlpUM2tBQ1BMUGhTK0s5alcrV2loc09QdWlrM1ZRTU05K3hCRDZvV2Ey?=
 =?utf-8?B?SzhQRDQrbzBvR0FBZUdJNmRnMFRMblFLclNXbGpPVGhUb0xXNUdaMUZRQlpj?=
 =?utf-8?B?RmI2dGN1T0FMVU9QRDgrREJ1WkoxeWRlVUpNdE9mMDJReW5NZk9ORHNGTDBi?=
 =?utf-8?B?eTZJZW5JcnhNN3hQT01HcFJvelJ5TkcxSnFSanN0TjI0SEdYSkV3ZEhlUldq?=
 =?utf-8?B?cVVRUnd5ZG05MitNaEVTYmlZN1FYc3l3MWd4dWd4SWJHUnVhcmQvTjFvU3hz?=
 =?utf-8?B?THlOc1pFbHowRXp6YU9xYlhCTHVDRkkrRFhKZXMvNFkrNkNrRWw1d0EzeEhx?=
 =?utf-8?B?bnRidWxHZ050VlpYMnFOdmt4YUFjR0ZvTFRRb0d4SUJGS0hGNndBMlpSbndi?=
 =?utf-8?B?YUtkVU14bWhianAra1hCeHFqREs2eWxwUHZSaytZazhOK2xuR0k1YmxGYWJ6?=
 =?utf-8?Q?LH8fWsw+Bs+FTY47cKjGcIM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88fa4cf-caf3-4e65-3af4-08d9ed909bcc
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:20.0342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ssW+QnP350Nm9SRm+oKFSXYPigjk+jzX2qsvWZ75R9sxsbL3o3QLLUCdoph1Kr5hvnz4QO3+fiWMqnVPNY/SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
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


Am 2022-02-11 um 12:15 schrieb Jonathan Kim:
> The KFD only unmaps all queues, all dynamics queues or all process queues
> since RUN_LIST is mapped with all KFD queues.
>
> There's no need to provide a single type unmap so remove this option.

You should also remove KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE from the enum.

Other than that, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |  3 +-
>   .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   |  8 ++--
>   .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 40 +++----------------
>   .../drm/amd/amdkfd/kfd_packet_manager_vi.c    | 26 ++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 ++---
>   5 files changed, 16 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 7f6f1a842b0b..c8201638fca5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1554,8 +1554,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	if (!dqm->active_runlist)
>   		return retval;
>   
> -	retval = pm_send_unmap_queue(&dqm->packet_mgr, KFD_QUEUE_TYPE_COMPUTE,
> -			filter, filter_param, reset, 0);
> +	retval = pm_send_unmap_queue(&dqm->packet_mgr, filter, filter_param, reset);
>   	if (retval)
>   		return retval;
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> index 1439420925a0..9a44b34abaed 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -368,10 +368,9 @@ int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
>   	return retval;
>   }
>   
> -int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
> +int pm_send_unmap_queue(struct packet_manager *pm,
>   			enum kfd_unmap_queues_filter filter,
> -			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			uint32_t filter_param, bool reset)
>   {
>   	uint32_t *buffer, size;
>   	int retval = 0;
> @@ -386,8 +385,7 @@ int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
>   		goto out;
>   	}
>   
> -	retval = pm->pmf->unmap_queues(pm, buffer, type, filter, filter_param,
> -				       reset, sdma_engine);
> +	retval = pm->pmf->unmap_queues(pm, buffer, filter, filter_param, reset);
>   	if (!retval)
>   		kq_submit_packet(pm->priv_queue);
>   	else
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 7ea3f671b325..ed4f2d3c6dcc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -246,10 +246,8 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   }
>   
>   static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
> -			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter filter,
> -			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			uint32_t filter_param, bool reset)
>   {
>   	struct pm4_mes_unmap_queues *packet;
>   
> @@ -258,31 +256,11 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   
>   	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
>   					sizeof(struct pm4_mes_unmap_queues));
> -	switch (type) {
> -	case KFD_QUEUE_TYPE_COMPUTE:
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.extended_engine_sel =
> -			extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
> -		packet->bitfields2.engine_sel =
> -			engine_sel__mes_unmap_queues__compute;
> -		break;
> -	case KFD_QUEUE_TYPE_SDMA:
> -	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		if (sdma_engine < 2) {
> -			packet->bitfields2.extended_engine_sel =
> -				extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
> -			packet->bitfields2.engine_sel =
> -				engine_sel__mes_unmap_queues__sdma0 + sdma_engine;
> -		} else {
> -			packet->bitfields2.extended_engine_sel =
> -				extended_engine_sel__mes_unmap_queues__sdma0_to_7_sel;
> -			packet->bitfields2.engine_sel = sdma_engine;
> -		}
> -		break;
> -	default:
> -		WARN(1, "queue type %d", type);
> -		return -EINVAL;
> -	}
> +
> +	packet->bitfields2.extended_engine_sel =
> +		extended_engine_sel__mes_unmap_queues__legacy_engine_sel;
> +	packet->bitfields2.engine_sel =
> +		engine_sel__mes_unmap_queues__compute;
>   
>   	if (reset)
>   		packet->bitfields2.action =
> @@ -292,12 +270,6 @@ static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>   			action__mes_unmap_queues__preempt_queues;
>   
>   	switch (filter) {
> -	case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:
> -		packet->bitfields2.queue_sel =
> -			queue_sel__mes_unmap_queues__perform_request_on_specified_queues;
> -		packet->bitfields2.num_queues = 1;
> -		packet->bitfields3b.doorbell_offset0 = filter_param;
> -		break;
>   	case KFD_UNMAP_QUEUES_FILTER_BY_PASID:
>   		packet->bitfields2.queue_sel =
>   			queue_sel__mes_unmap_queues__perform_request_on_pasid_queues;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> index 3c0658e32e93..131f685acf41 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
> @@ -197,10 +197,8 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   }
>   
>   static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
> -			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter filter,
> -			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine)
> +			uint32_t filter_param, bool reset)
>   {
>   	struct pm4_mes_unmap_queues *packet;
>   
> @@ -209,21 +207,9 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   
>   	packet->header.u32All = pm_build_pm4_header(IT_UNMAP_QUEUES,
>   					sizeof(struct pm4_mes_unmap_queues));
> -	switch (type) {
> -	case KFD_QUEUE_TYPE_COMPUTE:
> -	case KFD_QUEUE_TYPE_DIQ:
> -		packet->bitfields2.engine_sel =
> +
> +	packet->bitfields2.engine_sel =
>   			engine_sel__mes_unmap_queues__compute;
> -		break;
> -	case KFD_QUEUE_TYPE_SDMA:
> -	case KFD_QUEUE_TYPE_SDMA_XGMI:
> -		packet->bitfields2.engine_sel =
> -			engine_sel__mes_unmap_queues__sdma0 + sdma_engine;
> -		break;
> -	default:
> -		WARN(1, "queue type %d", type);
> -		return -EINVAL;
> -	}
>   
>   	if (reset)
>   		packet->bitfields2.action =
> @@ -233,12 +219,6 @@ static int pm_unmap_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>   			action__mes_unmap_queues__preempt_queues;
>   
>   	switch (filter) {
> -	case KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE:
> -		packet->bitfields2.queue_sel =
> -			queue_sel__mes_unmap_queues__perform_request_on_specified_queues;
> -		packet->bitfields2.num_queues = 1;
> -		packet->bitfields3b.doorbell_offset0 = filter_param;
> -		break;
>   	case KFD_UNMAP_QUEUES_FILTER_BY_PASID:
>   		packet->bitfields2.queue_sel =
>   			queue_sel__mes_unmap_queues__perform_request_on_pasid_queues;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index b6790a637f5c..5989b5df8402 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1246,10 +1246,8 @@ struct packet_manager_funcs {
>   	int (*map_queues)(struct packet_manager *pm, uint32_t *buffer,
>   			struct queue *q, bool is_static);
>   	int (*unmap_queues)(struct packet_manager *pm, uint32_t *buffer,
> -			enum kfd_queue_type type,
>   			enum kfd_unmap_queues_filter mode,
> -			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine);
> +			uint32_t filter_param, bool reset);
>   	int (*query_status)(struct packet_manager *pm, uint32_t *buffer,
>   			uint64_t fence_address,	uint64_t fence_value);
>   	int (*release_mem)(uint64_t gpu_addr, uint32_t *buffer);
> @@ -1276,10 +1274,9 @@ int pm_send_runlist(struct packet_manager *pm, struct list_head *dqm_queues);
>   int pm_send_query_status(struct packet_manager *pm, uint64_t fence_address,
>   				uint64_t fence_value);
>   
> -int pm_send_unmap_queue(struct packet_manager *pm, enum kfd_queue_type type,
> +int pm_send_unmap_queue(struct packet_manager *pm,
>   			enum kfd_unmap_queues_filter mode,
> -			uint32_t filter_param, bool reset,
> -			unsigned int sdma_engine);
> +			uint32_t filter_param, bool reset);
>   
>   void pm_release_ib(struct packet_manager *pm);
>   
