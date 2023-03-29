Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B199C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 17:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DFC10E00A;
	Wed, 29 Mar 2023 17:26:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C8B10E00A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 17:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akln6vIf4N1BmrQI9qtEw8YWAaNFgCvU7WWVbAAPBaCzurkSFYshgmE81cAGL/gAjyXGLk5XWJRB84Lo8ZQUY+GRMDoDN2dgeQ2U9kKDBMsOQBTtYo14UMKa7PONZxA2Q2FePLOmSd7zNp+VWLh3mnmgbF7woi2m1msswrsGbk+Yu3kcIm41LZy3TlB6zGkIbih+4nB2boiqoQp+FgPHktyxgjhF2kRM/RDJnaDxaQ9QXpGMShvfWi5BmGp4sh3g71oOZUTnpLS4okIMiJwNKUAnwRZIrzNGbWN0h6sZ4x4EbYG8c+DYtWAmsZv1NSxK83P5233POOSLkpxDj5Qe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5vk8mHbvCzfddof+eoNhGsRvZNwtlk8NNJNyr04jxs=;
 b=FHlJpmvvNXqCLTeZMR7PUcZFeyJb57z+yzU7KFJFfaRlTLHom35g6lp2RFPJuw25baPOgCOwbM+IX9IibZhnUOhtioAn3VYaAGdWykTzUzNxFq6raWNir3O7Fds4HsNRujxxuKRVbe9/s8OJMuKUMzrXMfxd8TrZ2LUEB7k9b2gJciT5RFlQaNIy7PEhF9WYl4rs2tpQtj2YERrN7rEL9AG8dYKKlHd2wHork+TktsoUQyKZMckbUyAYC4Fw3QdenVIwY/sccePjbltQZ7KdzAJekR/ZXQd8AzQdBUSBVhaqJxFquj6a0qWkR75e3HMhW/UvUfBMgnxUF+B9eBSzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5vk8mHbvCzfddof+eoNhGsRvZNwtlk8NNJNyr04jxs=;
 b=4RcCo4kOzjdgdUlcAg0HzwEY6DUcz/zpMs1dwm+1f134+QFaB3dh/ejU0u5p6BrHRPYJJ/4QESGXuq1aZalrvodoVMl3f1lsg6lreSkUXTPPDq7Df2Zd0o1r3+xj+Hkra9nPMwridpQyC+M5wq6Bt12qGYbiJdEBwRxs4lYoXJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB8092.namprd12.prod.outlook.com (2603:10b6:a03:4ee::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Wed, 29 Mar
 2023 17:26:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6222.032; Wed, 29 Mar 2023
 17:26:01 +0000
Message-ID: <e4de001b-eeda-dbbd-5ce0-f3e646195182@amd.com>
Date: Wed, 29 Mar 2023 19:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329160445.1300-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4e83e2-2dcc-4230-9500-08db307aaadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYqZeWnqPaDeW6aCCwyW2fkcdjGG0UjB19tTm06ZtZZQ6yiktlXPpWRZ+AOWm/blnQUi6+fibMRAUoVPR6vZeewD/DidOWhl3VLxynJ/0kwFqmcj2sfLKRsrD4GdryiYB5omO05QQOjAFpht+Tyef26HFG3Ti2FDuR4mrWqMPvmKbBWAL+tx3xN6TT7Y2QaOqR7R1qz23Wi1cE42vE7hxvMsN+tLxhqkQT1cv9F9P5PrmGjJiaobm0UCr2fFxW03X11Sg8DXqIJFN4TJBIyeI7jxIOQ8fsXLYiyxK6soRcFtLB26DlC1ae0ehawnlxVDmzNdrhiaXsb2ue4VUuLmGhd7SfXe3mOBZreDHhWkpSHJvTaqvU97XbRRNARTh/Rabv+wGEtBBJhwAMarGZUGUC1AQ8GtCKE+O6NcPcGbgNDXhsgjYK5URjjt0Bzes6UE3BT5O682NkGg0zOzFhoEV80plHIU1/tRfjb2JhQ9fU+Q6jcArMJc4pbzscuRntYMqEQzMkqrLGGMsJ0nPRlEDIKRS3K3DmFxZ2C6pYd9HDeyYjNSj/NdT+q0s9ocA9pHS0NPNR5Pv75EnjoZqPVtaOzfcsVri8hWIgJA+Xq946KsGJx2gQBGSMLoa5PsjxyzfqAJzjDwKOFLBrbWz7giYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(66476007)(66946007)(86362001)(31696002)(66556008)(36756003)(2906002)(316002)(478600001)(54906003)(6486002)(8676002)(6666004)(2616005)(186003)(38100700002)(31686004)(66574015)(8936002)(41300700001)(6506007)(4326008)(83380400001)(6512007)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNHMmtIUm1SaWdmYzhWNXdBOUIzVUdjbzFERUl5eTA5RWU5Zm40Wk9Zb0Q2?=
 =?utf-8?B?akJXV244bE9vdkZJN2E0cXgxV1I2bW9WVmdublNOU29sNi9tMkhlMUdGMjMz?=
 =?utf-8?B?aFh0ME96TkpHTWVpQ05uTWNTTThIMmJWN2tkdGJCMmdRZWNoZEVQMERmdjlX?=
 =?utf-8?B?TVJpUmlXbXBwcWVOeWEvaXdrcm1RRFBSNVQ2aHE3Tk1wTVNXSWtEa29wRjFa?=
 =?utf-8?B?UGZ6SjEwTmJLZy9TcmhIaXpvUVF1WnpyeDNGRkhqbXBzQk8xQWk3dlNlVUUy?=
 =?utf-8?B?QkxXdkVuOWtQRnBLZGVYNC9HRC9hSGMySERwUXgrcjVNT2JMeTdmdWFjc0dN?=
 =?utf-8?B?WS9KdW5WcGJXYTZ6WFlVV3BPcmQxbjJEU1hlUmNVWkJ2Qmh2UExtcWhIb2Rz?=
 =?utf-8?B?RXFRTHNPcjdpSmh3L2lVcFl4TFVKQXFGUzg1RXIzbmhxVDEvaEpia3FHVnJo?=
 =?utf-8?B?YmRUSStvSlpkTStwYjV3b20rK2VuOGZOYjhPblAyVEkxMURIWldCbitRSWFW?=
 =?utf-8?B?SWJ6Y1BaL2pzT1VtcDhJNGdGcTRVV2pPN2xjMk95K2Q3QURzbWpTTUErNkFu?=
 =?utf-8?B?SVB0UU9YeDBXUWxEbTYreVZaQ3pzVnM5dVFtNEhoMkFEUkVSTXd3UGVNZDdH?=
 =?utf-8?B?dFdoSFlEVDFlWWFmakQ5bXRxeU9XSXAvUURmdkVOZW5rNUFyUkx6WlV4dUJT?=
 =?utf-8?B?dmRFbTBncm9ZQ0QyN08yblNoMzJYZUVqYXJTOVJrT29CekJDa0Frak9WU1dv?=
 =?utf-8?B?UHNtWHdLdDhKUXAwYmQ5QjVOZWFGMm5INHFndC9VaTNiY1duZGd3S0t6SDJ0?=
 =?utf-8?B?YUhqWEVhVkRUMmxkN3pmS1p2TjNFN2R3YXJNY293T2VmcGxjc0NWN0YzVmlH?=
 =?utf-8?B?RlFvb29RaHo3cUFPTnM1UTNQYytrSnpWbERkcFpOWmdJYll4TGlzb0tJbExp?=
 =?utf-8?B?bG1MRVVvbmdxRThZSWZqSzc5K2pRbFh0ZmVJUW9vd3crOThRSmtpbm5jRVRX?=
 =?utf-8?B?bEczRitibmt2SkRYa2crVkJyaGxaSDhEemFrd05ib2VMZS9uUGdqMGFEUC9s?=
 =?utf-8?B?aSs3TEwzSno2WHJQdTFaMUlhYkN1QjZLR3lJeFdoYUl3M09JamVyZFB5WmJL?=
 =?utf-8?B?Sk9MV242cHFNV3JNbWlDb3orazFyKzE2QlU1OGN5UklUcG51MG5ROXJJL2J0?=
 =?utf-8?B?SGp1OTlOS2dtUmlJd3NXY0VkU25oK1l1VktiaFIvR2JWMExUemcwVk9QMER2?=
 =?utf-8?B?RkwxR29wWTVMM0h2OUFQRmt4eVJkUDNHUE5kbmhicENyaGhDMVNpbDFMU0tx?=
 =?utf-8?B?UXNEQUVpQmc2L2FnNzNSV2lHV2pwcXo4Y1NVUk5OVE96WUM3K1l1SEdQUzZH?=
 =?utf-8?B?ckppQzlUaFZQdXJnV2kyOTVWMllGZzM0WjIvT2Z0VlhlRCt3dy9TR3VSa2Fp?=
 =?utf-8?B?OExGRGV5ajNhQUVQYzUrcjdxbExkOHRmaHZTaVYrYnd1bmlxNmtGOXIxeEkr?=
 =?utf-8?B?REF5SEFTMTZxUlRSOXVQT3BLOGt5WFJOR04rcFBWakpPakRpNzJtdmY2L2da?=
 =?utf-8?B?ZkxYOW0rV3FEanowM2NySm15QkpDZnF1Y1A4TmNUU3JIbUlORkFQY2NERE1k?=
 =?utf-8?B?SHJKbzh0MGhJalJoZEp2cDh6UFV2aXR2TVViRndzTitWQUJpUnhHVE5OM1pl?=
 =?utf-8?B?WEhZNHVnMnJtL3FBbTRlVXVKRS9WTDdUT1Z1UnpzTlozYzhKTmd0Q0RTczNB?=
 =?utf-8?B?ZVo5RWw5RzFhcnB6RGFnUGNhWkVCemxNcU1pUEo3RkFySzJqWUVLMS9uMkgx?=
 =?utf-8?B?QlJtTjlidFZMTTRrSXlnbGlFMUN6UHJNUTQyQTZoZWhWWTI5SWtFM3hJNW0z?=
 =?utf-8?B?SElQT3gyR2U0NERhUnhqakN2NWtVSzIrbHg4cC9nY3krRmNjbnQwSk95MzBT?=
 =?utf-8?B?ZWs5Vnkyemo2dFhmWG04NURmMW5vbWpvTXkrR0tiZDhOSmgvc0RxeU5xNGo3?=
 =?utf-8?B?eFBHQWNIYW1kNGNxOGJMcWtlZFFqeGFRMnJKM1Q4QWZkQW5qMHZSTlZva0t2?=
 =?utf-8?B?M2k2VGcwbFoyZE1aM0kxZEtESEZHM05ZZGtmMlBFWjZ6T2Y4UTdFaDJOUkti?=
 =?utf-8?B?ZGtDUlV6QnRHQjR4MUU0ZHRYZXhYMWlsSmVWOWw1Z1h3YWNHQmgyNWliK0Vh?=
 =?utf-8?Q?u3fJPm+ziwDF6qsz9WERVqeR5f5nCqNtspnenNWKkW2c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4e83e2-2dcc-4230-9500-08db307aaadd
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 17:26:01.6924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMab0sybIjfaepBzcQSvD21gSD+VgitgKYwQIH09yh5C6Gq12cS46deWSlPpFu1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 18:04 schrieb Shashank Sharma:
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch intorduces new UAPI/IOCTL for usermode graphics
> queue. The userspace app will fill this structure and request
> the graphics driver to add a graphics work queue for it. The
> output of this UAPI is a queue id.
>
> This UAPI maps the queue into GPU, so the graphics app can start
> submitting work to the queue as soon as the call returns.
>
> V2: Addressed review comments from Alex and Christian
>      - Make the doorbell offset's comment clearer
>      - Change the output parameter name to queue_id
> V3: Integration with doorbell manager
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   include/uapi/drm/amdgpu_drm.h | 55 +++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index cc5d551abda5..e4943099b9d2 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -54,6 +54,7 @@ extern "C" {
>   #define DRM_AMDGPU_VM			0x13
>   #define DRM_AMDGPU_FENCE_TO_HANDLE	0x14
>   #define DRM_AMDGPU_SCHED		0x15
> +#define DRM_AMDGPU_USERQ		0x16
>   
>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>   #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -71,6 +72,7 @@ extern "C" {
>   #define DRM_IOCTL_AMDGPU_VM		DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_VM, union drm_amdgpu_vm)
>   #define DRM_IOCTL_AMDGPU_FENCE_TO_HANDLE DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_FENCE_TO_HANDLE, union drm_amdgpu_fence_to_handle)
>   #define DRM_IOCTL_AMDGPU_SCHED		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_SCHED, union drm_amdgpu_sched)
> +#define DRM_IOCTL_AMDGPU_USERQ		DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ, union drm_amdgpu_userq)
>   
>   /**
>    * DOC: memory domains
> @@ -307,6 +309,59 @@ union drm_amdgpu_ctx {
>   	union drm_amdgpu_ctx_out out;
>   };
>   
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE	1
> +#define AMDGPU_USERQ_OP_FREE	2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)
> +#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
> +
> +struct drm_amdgpu_userq_mqd {
> +	/** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +	__u32	flags;
> +	/** IP type: AMDGPU_HW_IP_* */
> +	__u32	ip_type;
> +	/** GEM object handle */
> +	__u32   doorbell_handle;
> +	/** Doorbell's offset in the doorbell bo */
> +	__u32   doorbell_offset;
> +	/** GPU virtual address of the queue */
> +	__u64   queue_va;
> +	/** Size of the queue in bytes */
> +	__u64   queue_size;
> +	/** GPU virtual address of the rptr */
> +	__u64   rptr_va;
> +	/** GPU virtual address of the wptr */
> +	__u64   wptr_va;
> +	/** GPU virtual address of the shadow context space */
> +	__u64	shadow_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	/** Flags */
> +	__u32	flags;
> +	/** Queue handle to associate the queue free call with,
> +	 * unused for queue create calls */
> +	__u32	queue_id;
> +	__u32	pad;
> +	/** Queue descriptor */
> +	struct drm_amdgpu_userq_mqd mqd;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +	/** Queue handle */
> +	__u32	queue_id;
> +	/** Flags */
> +	__u32	flags;
> +};
> +
> +union drm_amdgpu_userq {
> +	struct drm_amdgpu_userq_in in;
> +	struct drm_amdgpu_userq_out out;
> +};
> +
>   /* vm ioctl */
>   #define AMDGPU_VM_OP_RESERVE_VMID	1
>   #define AMDGPU_VM_OP_UNRESERVE_VMID	2

