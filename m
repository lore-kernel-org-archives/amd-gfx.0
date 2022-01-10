Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ED1C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jan 2022 23:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C1110E82D;
	Mon, 10 Jan 2022 23:40:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7312D10E464
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 23:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eY5YtE6+yUKK+u7IUw1l7YjT6GMXT9Gnl5K5WXAwnpCABuI4DYEjRue00NR4LpXoBqe8yfG+Nw6DLQG1Ugt6Rn2Dq1hMlyndekCbyM9o6QsfBs4kb2fgfuquGGDOsu+rqiqPpEbZt5TEhr6L4LIrZFxRqwp9mSQrUYpaMM2sNlav+3AIJo1lK5jXMj9Zo2ASXgfJkBJymRuJIweKbJWvh7/lI0/hRYa3zC2sEPSIC1c6wBDIbiI1ZeVGzHw8MMgViyn5rSDlFp9eYhDGtDuQ1M8XD/y1Du+n/lHvUbdZOZ7Db5ZSewn7KdRM+H7vq61f/6MEHABUYVDMzG7DQazKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUzZFXDGwHPMZHWXXgs2GJF8xE5KES7OKYbWR9rpqlA=;
 b=hC9UMRG1wr+9JKN7Ba6ITnD0+/qcrD2ARwV+XW9jEKVjMKeDNEdYX2bDs2KU87CtevTLJsTbEXPO3PgRUZTXckXR0H2eDWPDNmqGnufuiDim6sI3XK8hufRVRml9sPecUt5HoSLGURXwEFCixsHzsxaHmw6k6OlixsNud8Asm4TwyBjBajQG8aNvBjyQ8Z78br6/PYQ+imXI3E0GETVWmBAsHSz4+8Pl2OcIjNyA/XDPu2EBeOvaMhud4ek6yFVkhI7RTSurh1ERodOG7czDqt65CelcHvy/GuOq7WoUqFQEsjYdDKN4gi56PRRPmGlLke7iooywH3d2uoYA35//yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUzZFXDGwHPMZHWXXgs2GJF8xE5KES7OKYbWR9rpqlA=;
 b=TJlKvAHsUBPFRSFV8tdTXJGrWeo0V5bONMCHuRiFRlnV8I53sj0BlqatgqIHiPEZUJPetSVxZfnH/bJyLEpiuWQMQ12FqiiPSNj8rwbTvCqLB3UC46PSv2qL9nmrE8lE6EgKCGJ7H9VlKcGXXrqX9ehbphq00EMTfHYyd7X0MG0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 23:40:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 23:40:08 +0000
Subject: Re: [PATCH 1/1] Add hsaKmtAvailableMemory available memory inquiry to
 libhsakmt
To: amd-gfx@lists.freedesktop.org
References: <20220110212328.3171408-1-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <b0639480-db15-22b9-90fc-34a4fdb1f721@amd.com>
Date: Mon, 10 Jan 2022 18:40:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220110212328.3171408-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b9a22f4-247a-44d4-af5f-08d9d492896b
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5130263549106F4B992EA6BC92509@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPwGatdiQPz7Rw+deE57Av0iRz5snDY7CC6CCGqDoFRwOS+8kPqaMWspTN0VABNBmexoZMYt0fF2f1pJoMP82dNIJvVZs+bHHvTX0mziNTJDgGMzpBJuoaaK09r8/0xHYASCRVyJjRSCjx4kqViwUwo2YSThMq2Ac1EU3LuIx4qwi2q7+zJK0lg7ZUeA/j80j3H1M0kTCeiBPYyqgYvONMgEzJPFBU1vG5OoutNDqgTnUqflH+dkCeFyCLYXEjhZwa0c5hHgItUVLo/WV9hdAxCWWooTAlw/mGzMhPHOfGmzsxgbwCBoDcAnf0QFDdqORBQ9ayMCD0WL5Wl1HS60vx2mtOLhCJHdtPAK77SPZ+mQOTRJIe8CY1apljB73fJMwL/qhHsLZTDJN06emxAYuJZr5arbuic9QEIa6HGk9hKGGA+O4MwKcpPDaobo9Qio7duCVTQLZmCk4Gh5A7WomiQDRuyoNd2MOpk70aMi5gXDMido09+F5RHSGL+qVKfAqKI//Kd2dPRI44UwiRIwjY4crA8lsujttBOTTz6tFJ5cUqVi2TvVpzkOorBURRSnK9gW0TQZe4sgFn3N3FSTTOKmNkAsgzYOwKlu3+1/k3Dq1hli9SwHA0UMjtcDL+3cf8mROaMeTpm7HYdrgEHnO20yMPFtA6rIXa5qgHdkjoXNnvQ2A9fVoGGZc6mp2D6/rHxT4Xc4MNk7LKYELFTA/XY98LU/HghSswqNFf1ki+KkqhXhYaoW8hqrhfQeBiJX/r2uZjkxGvZMxMeqLndq4kdtmFITm/R+1YSmvscc0MY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(31696002)(6486002)(83380400001)(38100700002)(66556008)(31686004)(66476007)(2906002)(66946007)(8936002)(6916009)(508600001)(26005)(53546011)(6506007)(6512007)(186003)(36756003)(2616005)(316002)(44832011)(86362001)(8676002)(36916002)(131093003)(145543001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlB6RjloQ3YvTW40bHdwbXFNTEpUanJjSzlzdTh3V0wySVh2ZUF0SkdmeG5Y?=
 =?utf-8?B?dmZSTGtXTm9Cd0gyUjJGM0IxQVNxT0x6OForWGl2VkFVazN6cmVvLzlreElw?=
 =?utf-8?B?c2Y0cjZEVGZMOHhyV0ZDRjZPQVg3OFVwVzF4bUEyNzh3Vi9PbVZsMTVuYzZS?=
 =?utf-8?B?RUhFc0JscFdFamR0MGtCUWdFeVlHNVorUndrWXZHbFlpV3pzZkJlTGllOHE0?=
 =?utf-8?B?SjJyV25odGV0S1BtdU4xdVNxNFhlWmw1ODJYNGt3b0ttZStmSEVoZHFwTkIr?=
 =?utf-8?B?eHB2cmlzT0FneGgwUW9nYUdLMEE4UmdvdFF2UThFbnVPMHpEeHRuVGpGT3Qz?=
 =?utf-8?B?dGhhWkZib3Jzd2N4ckhFdmI5TVJYdTVzdXFlNC92Z1RDZit1cGl2cHFXdTV3?=
 =?utf-8?B?STM0bGphbzk5LzJ6TjEyaWtab09XRlZkUklXcjBoTkFFQmtFWnY4S1B2NEhB?=
 =?utf-8?B?ZHpIMFBkekFjanI3Q1lCVTljRkVEMVoxOTVzNUNEcnBBZkJBcm1FL0N3aVNm?=
 =?utf-8?B?M2dVeUkxdlVpNmpXMVJNamlob1VJQkNscTZGQWx6YjBaQmtiMmFDeEh1bkFT?=
 =?utf-8?B?c1ZMcGI1b3JOSGhyVWhuTUU5R3JQWEZheDgwRlpuNzF4YkJQQUthZEx2WGZC?=
 =?utf-8?B?bU1sWE13L0IxaiszZEwrdFdyRGI0Um42UzJWMUhLNEJnY1NBeWcwOXFDdVdx?=
 =?utf-8?B?Zno2b29KcW01TmZ5N3NnaU5oMXl5c0JuWFJ2c1FMZi94L1lrdFdKUDhpU1RR?=
 =?utf-8?B?SlVRa0JVTU00VDgwb29Ua2cyS0x1RExlNnBpSzQwOXNwcy9vZXhKcTNOYlhM?=
 =?utf-8?B?TGNhSkp4NExBY1ZWV2htYVhUVEUrZjRrUU9IT2xNWEZnVGpQSjk5OFAwRFNY?=
 =?utf-8?B?SVNVRHRNdVJPUXFHcmdKM0Z0Q05HRkRGV3lvcVlDdVRzdUxxa056Y0xkeWkw?=
 =?utf-8?B?bE1VeTdwYmc5UFZMVzVPTWlRZXRjUFQyM2JGSmx0SzR5aE5uazZoKzRjMENy?=
 =?utf-8?B?dHZEY2pNcklwSG5BOTljNGtBUEhFMVNXYzFNTDBoY0o1amcwOXJrQU9rSlFX?=
 =?utf-8?B?Y2JDemhJZDJ2S29IRFZ5WTFKZTMvZUdsYzJML0RqN040STZOaVpwK2xSd1ps?=
 =?utf-8?B?V2tsTTJ3cWRFUmEwYit3ekxZRzFxelNtM0F1bFh3dCtFNmkwbmJDeHJyeUJB?=
 =?utf-8?B?cnp3MVlsWkRzb2l1ZFpRc0dLYzZ3amxDRlU0SWZ6TUY3S0wrMnVxWUlZRVpF?=
 =?utf-8?B?Nk0yMUd4c3FwU0hWZEthdDZyYnYzY0Z0cjVUdExMTFJVVHZzOHMxQmZEeGtn?=
 =?utf-8?B?dVNISEtvaWpzaXhpM2dKWCtwbFMvQTJ2b1VpR01RSlkwVGRWM29QNGI0S0RL?=
 =?utf-8?B?eWVPMkh2RkNUdis4TFF4SjczRUxBKzJpR3Y3LzJFc01xK0QzR0d1WkpCRDdF?=
 =?utf-8?B?V1hjL0RGdFN6MHR5eFRLYVBVeFdGM3JSZGVpSW5jaFdiRWRkakZxeUNSOUI3?=
 =?utf-8?B?SnhUcHNCczVNbXNKUlBoMzQrOVdpbTVHeitsbmY3SVhEUzJtWE1pVE9waU9r?=
 =?utf-8?B?VU5ja2RsN21TUDdlaGtaYktZaE5uZTVRUGhqLzNrWk9zTW1Cd0krOVFuS3BB?=
 =?utf-8?B?em1xTjBzYmVNVFVCZ1VEV0FjVVdjZWgyQlp6dllRQ2FkU0pGTllRaHQ3ZFBk?=
 =?utf-8?B?WXlLcWk1V1ovKy80UVNnV00xN05DNFJ4K2pha3JZOXVxV0JIbDg5emUxYWh3?=
 =?utf-8?B?bXpqM1Q3dm9PWFBRWHBJOEFOdUpJRFhvY2QyRDkzUG0vNmtkMGtyTCswYlF4?=
 =?utf-8?B?WU9KMjVxTVhXeXB6ci8wcEVRSy9ZYWFyWXpSY1VGS2IrOFAxMkRHNkFURW4z?=
 =?utf-8?B?S1k3cXJuOC9oS1JqUHRNRHVjcU40cklqdHVQQy9scjN0Z2FGNmljM09CVHlT?=
 =?utf-8?B?MEp3YTlqdGRqdXBMbWREMWVxdGJMSWw4ek16UVJ4RjN5OGowWVR1UFFZZ0NV?=
 =?utf-8?B?TXNMRlVtREIrcCsrbUlZVkNiYVpnbEZxZnVGU2RtQkFlMjdPMjJvZUhGYTd1?=
 =?utf-8?B?YlNOREhiWjduUHovTmxaNWNCNVY5MTdyQURBVHZDYlRCQ2NZYTVJY01vL1V0?=
 =?utf-8?B?Tk80ZjdHUTBCWk83ZXB1SzE3cVNnOTVDVVFoSVg0eHppZ3I0c0lzOEEzMFkr?=
 =?utf-8?Q?dF2bvSsnSYe4q55pB61/I9I=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9a22f4-247a-44d4-af5f-08d9d492896b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 23:40:08.6891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbJQ8NMb5hSH7K2/G1YhLZqBb3mylK/9KpObe2OdbEh7c9VkX/E9F4WcHBiLMl6JIO8McknphKt/Pt76pymlgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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

On 2022-01-10 4:23 p.m., Daniel Phillips wrote:
> Add a library call to inquire memory available for allocation per
> node. Uses the AMDKFD_IOC_AVAILABLE_MEMORY ioctl available in KFD
> ioctl version 1.7
>
> Change-Id: Id770fc2261e9e076f2fbce7dcdac640a6354ddbe

This patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   include/hsakmt.h          | 11 +++++++++++
>   include/linux/kfd_ioctl.h | 18 ++++++++++++++++--
>   src/memory.c              | 23 +++++++++++++++++++++++
>   3 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/include/hsakmt.h b/include/hsakmt.h
> index ff2d023..abc617f 100644
> --- a/include/hsakmt.h
> +++ b/include/hsakmt.h
> @@ -374,6 +374,17 @@ hsaKmtFreeMemory(
>       HSAuint64   SizeInBytes         //IN
>       );
>   
> +/**
> +  Inquires memory available for allocation as a memory buffer
> +*/
> +
> +HSAKMT_STATUS
> +HSAKMTAPI
> +hsaKmtAvailableMemory(
> +    HSAuint32 Node,
> +    HSAuint64 *AvailableBytes
> +    );
> +
>   /**
>     Registers with KFD a memory buffer that may be accessed by the GPU
>   */
> diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
> index 039b30b..a81ae37 100644
> --- a/include/linux/kfd_ioctl.h
> +++ b/include/linux/kfd_ioctl.h
> @@ -32,9 +32,10 @@
>    * - 1.4 - Indicate new SRAM EDC bit in device properties
>    * - 1.5 - Add SVM API
>    * - 1.6 - Query clear flags in SVM get_attr API
> + * - 1.7 - Add available_memory ioctl
>    */
>   #define KFD_IOCTL_MAJOR_VERSION 1
> -#define KFD_IOCTL_MINOR_VERSION 6
> +#define KFD_IOCTL_MINOR_VERSION 7
>   
>   /*
>    * Debug revision change log
> @@ -761,6 +762,16 @@ struct kfd_ioctl_free_memory_of_gpu_args {
>   	__u64 handle;		/* to KFD */
>   };
>   
> +/* Inquire available memory with kfd_ioctl_get_available_memory
> + *
> + * @available: memory available for alloc
> + */
> +struct kfd_ioctl_get_available_memory_args {
> +	__u64 available;	/* from KFD */
> +	__u32 gpu_id;		/* to KFD */
> +	__u32 pad;
> +};
> +
>   /* Map memory to one or more GPUs
>    *
>    * @handle:                memory handle returned by alloc
> @@ -1240,8 +1251,11 @@ struct kfd_ioctl_set_xnack_mode_args {
>   #define AMDKFD_IOC_SET_XNACK_MODE		\
>   		AMDKFD_IOWR(0x21, struct kfd_ioctl_set_xnack_mode_args)
>   
> +#define AMDKFD_IOC_AVAILABLE_MEMORY		\
> +		AMDKFD_IOR(0x22, struct kfd_ioctl_get_available_memory_args)
> +
>   #define AMDKFD_COMMAND_START		0x01
> -#define AMDKFD_COMMAND_END		0x22
> +#define AMDKFD_COMMAND_END		0x23
>   
>   /* non-upstream ioctls */
>   #define AMDKFD_IOC_IPC_IMPORT_HANDLE                                    \
> diff --git a/src/memory.c b/src/memory.c
> index 6d2a4f4..b2cd759 100644
> --- a/src/memory.c
> +++ b/src/memory.c
> @@ -199,6 +199,29 @@ HSAKMT_STATUS HSAKMTAPI hsaKmtFreeMemory(void *MemoryAddress,
>   	return fmm_release(MemoryAddress);
>   }
>   
> +HSAKMT_STATUS HSAKMTAPI hsaKmtAvailableMemory(HSAuint32 Node, HSAuint64 *AvailableBytes)
> +{
> +	struct kfd_ioctl_get_available_memory_args args = {};
> +	HSAKMT_STATUS result;
> +
> +	CHECK_KFD_OPEN();
> +	CHECK_KFD_MINOR_VERSION(7);
> +
> +	pr_debug("[%s] node %d\n", __func__, Node);
> +
> +	result = validate_nodeid(Node, &args.gpu_id);
> +	if (result != HSAKMT_STATUS_SUCCESS) {
> +		pr_err("[%s] invalid node ID: %d\n", __func__, Node);
> +		return result;
> +	}
> +
> +	if (kmtIoctl(kfd_fd, AMDKFD_IOC_AVAILABLE_MEMORY, &args))
> +		return HSAKMT_STATUS_ERROR;
> +
> +	*AvailableBytes = args.available;
> +	return HSAKMT_STATUS_SUCCESS;
> +}
> +
>   HSAKMT_STATUS HSAKMTAPI hsaKmtRegisterMemory(void *MemoryAddress,
>   					     HSAuint64 MemorySizeInBytes)
>   {
