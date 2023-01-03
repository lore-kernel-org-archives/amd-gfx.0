Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC61DC3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 18:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EE810E402;
	Tue,  3 Jan 2023 18:30:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D3810E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 18:30:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7FbnEfaWM/CLtr4Qai4NFbcvMXN7kNzcDAjD+0OOMf1W3QgldLfMlbMaHlk9GmtfWRZ9ykWVgKA7vRRAeCMe03Akph/IodsvvLEXRzp0SBRzNFq7BMZnIwPtOmc767ula2MH6CgnnTjyUS4bCLjS52mPPk8+FQVQKIa7S/RPE8LbwhksXtvQjVfC4yQY2B8JFISUl4WYWMvdbLoo8HLPXq+cXmMXAmL6gX/+tV9/5+3pyCvE5W6VamyG4+VbIo879dwA9thfFvJJQI/8UziEg7tKRT3JNbzZYAnosa/dP8hGnFEqnJeDg2l3oZNWGtuwZa/o0n/n9mTA5F8bs3AUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NFf5ULZJe45YnOa6GyFjJU3B24A8WSp4y3qkMiVB2E=;
 b=lrI2DzDJ/AtHsPHZnn7FzHkatDlNnX8bSDeWRO84PiibF3BvPE7dLmJkhn+w4hvS2V7LdBmB93n9PiV/6hl55t8LOJihuvAKZSkA7iTnhBdf2XrWdQcgIZS6ww/CqksqW7HyNQJGisAfrCThFogHNLGy2Ku221RAOHR/Riyb/ynQdkDzXcz7yhVpF3zdj3KvLSspe+UuZJNJMp/MtIHfWdzycvQ3jbcd9OrDROk3pUA4LjAWgocTZZggZT0Vmzy0ZwVzuL96JsBy3KMBtEyA6DxPCoz4M7nDCyrBo00vb/0hKasBAyaalSgrcKffG4dLoSYfETeGYqkWQBZqICbg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NFf5ULZJe45YnOa6GyFjJU3B24A8WSp4y3qkMiVB2E=;
 b=JTtULjMImcfqdrzwzO2z9d5CX24Z2Tzja+745pkibkiL0nWB7p9niMM9uiZ/8brr8GVc4UW5ValyfEkR4/EEyI4ZpfbZzzZSpu6FzD4anFwr55Rj6dzLc+xLRoxb8U8o4Hajoke6XauwNJeLGpkqHp+ysLbi0bsHMc+RFEjGxlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 18:29:59 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::c3f5:aede:fa4d:5411%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 18:29:59 +0000
Message-ID: <97583f26-81be-f6e5-ac62-45a3bca40e43@amd.com>
Date: Tue, 3 Jan 2023 13:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC 1/7] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-2-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20221223193655.1972-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c33503-b136-4965-b8e1-08daedb8856a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ntc+CuvOKb0VhthhLx3tCIKr9APxaDtIs2ysrrl4ht6vZeqeBdIZ9PswCKaSFj2Vf+I8rJllfT5UkvOAu2WKMrRuLs4nzJ/yXqzwlChTfF8sbjy1BzJGEN1IaHIYupKc6mH1qf/8ttGKhg6Y4+kqQqbEXxBLXA4SpX4PiCqW1Mbwq7O1SCYy8zyAxL6oENYPvoejrlc8A1fDA7URBB9gtDqlfLQDYr/cGjM3E6pPbzm4ofNff2Xp1BWXzMKBv/mcbZiFP4OgNW8hGhmMuViOxcJUSMixaJPq8yu//Kuda0uPMXkXql4UVhfzNVxeI0hEt2rebx2NmBhud9cOKOc0lBgXBxDrpQIUAgvslDCwwGkCR37iS0BcPCx576iUMCftLKR67a6GqJMLMSaPr1enhEUwRPtBa3qGArEdjNaxQm753qoP6ntSfk/PbqmGsWBvx8jSlxXJvVlEy0bSBvpp3+OS2YW5zl/UqN6FPyDdSBQdcWzC8lr7AH0CPeIAoIL3n29hFjL+mAMO9ivaTjL8u+DSDhLBOJOcRSg4kcmhuwVBBKSEONJ+vkdZSZZnO1nFBVy7SCvLWRobdx55O9sddPY9aiKdnFB/jszqx+JnoOLJ8+R22dJkIvsYUN38QwbzVS9D7KtkObplfWHLL9GJqwcprpL4iLDzIRo0PesVdTNbnnRSb6vnGmGvqjAytimq5BTEBG5DINJUzTl5fFQhmiiT0Ubn6nVmHvYOAzfd5Sh4ng8/gcRAEbPVayP1g4+Y33w0TEnH4Gcv5iZnCjIcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199015)(44832011)(26005)(186003)(6486002)(6512007)(8936002)(83380400001)(478600001)(6506007)(31686004)(316002)(54906003)(36756003)(66556008)(4326008)(8676002)(2616005)(66946007)(66476007)(41300700001)(38100700002)(5660300002)(86362001)(2906002)(4001150100001)(31696002)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5ua0ZMUmYxL2pPWmNqUWZhMTV2UmFRYzZsQnNGdzFVYXY4NlN0NzVEb2VP?=
 =?utf-8?B?YVNYWDFibDJUNXhlWWFIQ1hxUWJ4UXEvRDFtTUZBOVRzRnRRWXN3SkpERlJm?=
 =?utf-8?B?ZUFucTBqenJPZXo5YmdYZW9xTlVrSi9tUXFDMllvQ1FuS09BeWFwNmFnRS9T?=
 =?utf-8?B?eXh6WG9rc2h0SXN1dmN0SGh3OVBHZy96Z1RQeGY2bXI5dWNPMEsrZ1BXRjJm?=
 =?utf-8?B?YzJiWFYzTEhxL29wOFpmYnFNbzdKOHF4UzB4L0tJNXU3OXlBZnpaY3VKOXdr?=
 =?utf-8?B?REoxZkxnRGpDOEg0NXMraVdxL2dqcjkvMGtlOXBIUy8yeFM4WVdBSUdHbm5K?=
 =?utf-8?B?VDhkWDlDMS9GWTJHbzBpUmI2bGpxNW8yVnNRcks4anFIbUJ0aGdqMUpualZ1?=
 =?utf-8?B?VnQvT1hiVC9DMnpYbEFNNmNFR0VEODJqSzhFOVZFVVZYTGZqU2hDWGhIR3BG?=
 =?utf-8?B?aGYrTTNrMlBjN1ZxYSs2TWtFK3Q1RFlYWFJrTkpJQjFQTDJZZUV3bCtZSTRZ?=
 =?utf-8?B?a0ZQUlpYSXJ0UXBPMFBGZmp1ZGlZRE9tckFEaGdKZGlTWVBLdXFKNnFSQ2RT?=
 =?utf-8?B?MWQyeWRGUkp4OTFQTXYyVWZkKzBMVmdub1UyKzYxajQ0MmNZSmo3ckJPSDl3?=
 =?utf-8?B?emhrblJqYkc4WlJxMW1JY2dlK0orTWNEOFFUeDBNeithNFhGbHZyM0dzeTcx?=
 =?utf-8?B?WU9HOTJnaEZRL2l0enRad0lSWUdHV1FQazJZRkttV0VaalEwTDh4anhQU3hE?=
 =?utf-8?B?cmp5aFBzelpQbkZZV0VzYTRiSW5NM1pKd1puK0dYMDBsa3I1MC9uelVDd0ds?=
 =?utf-8?B?WVlVcy9lSzhrWktmN3JNUDlyT3JpTk03Q1k4d0RFK1hQaS9qOHZqb0R6a0dz?=
 =?utf-8?B?REF2TG9kSFc1ZENKK2J4UUZEUzkzTG1wWGl5dnoram9vdFl5eTBldFRoZUdR?=
 =?utf-8?B?Q2QxY3VMNFFPelpqc3RtbEdjdEdCYURibE5IdDMzZ05WL0pNeHc0WTBoRkZT?=
 =?utf-8?B?WjkrN094OEVBWlBCZmRUb25TbURtaUtPUkJERStLMi95UThvZFpTaVlRa0Zx?=
 =?utf-8?B?ZUFRMVJGTlBwN2hwbk9iZm1ZeGs2Q01qSUtVd0dOZ2RqYlFiNWxWaTh3VnVU?=
 =?utf-8?B?a0s0Z004MG03eFQ0cVlOWVpJUy9MSTdDUGdVYXFpWHdoYWtXRGFPYm1yTEFq?=
 =?utf-8?B?VEMvZ3Fmb3dxZkhlVXVHZzM2VldRQ2pEY01TbkhwbFAzNVJJbFNra3pTMnBG?=
 =?utf-8?B?SlJETW0yQWw5SGxkMGZubGRLQnZCangvdnVVVzA4QTNkUHRiRW43R291NzN4?=
 =?utf-8?B?b0tzazVtdjIwOG1kaGRHemh1dEk1VC9LYmlaZ2VLQVFqWmJ5WDdWWjdHdmVQ?=
 =?utf-8?B?aDM1WHk4Z09FY1Y4eTJrV1RJS2lTTWc1dm1hQXB4WVkzbU5MY215K2d2b1Ir?=
 =?utf-8?B?L2pnMUVEejFRckZsZVdaYWxHT0V1YmtWbm0xRzNlc29Zc1I0NTg0NGpRRVF0?=
 =?utf-8?B?ODF5bzlrZ3NZU2F2aU5Ka1F0T2pXMkhucDY0bkZLUWZjaEFodWR0d0pRbFFW?=
 =?utf-8?B?aHlXdWQvRE1RcTVKejBHbHdlZHdCa2IrZVpoUDJNU0FsbVJGODhGaWRnV0pN?=
 =?utf-8?B?bVNka3U1SGJERm56S05wQkw3OW5lZi9GZ3hMQjdmYlU2ajhIU3h0S1lYamJM?=
 =?utf-8?B?SHZjbW9mR3hyQnVqTGJydlBkZzlGNURENDczQkRGVTJLTzJreFBPV2lxWE5j?=
 =?utf-8?B?eDQwNTZ4S3d3ZVo2U2tFcUl3YUk3WE11QXNYUjJONWE4aDJmY01MckFraVBX?=
 =?utf-8?B?SENzTkJsT3IxT1VsYVNGQzFUdjlOU2lhTWJIUkJlZ3lwUXAvUEliQ1huRnN3?=
 =?utf-8?B?RjVMN2RNa09HSll1RXN6WG9GNCtFUDVnRTBsYi9sREV3Y1dTTHV6dFJTTlBo?=
 =?utf-8?B?cFFmY0JpOHZtcnJURlpYTkJCSGtJOGpTajFxQVh5UmVhTjg3OS9CVmtURTJJ?=
 =?utf-8?B?WWdBb2tTczhUV3FWSUhKaHBpSEo1cVk2Y3pRN2xpcWl5enJmVWhoRWo4WVVi?=
 =?utf-8?B?SmlrWFFSZGdqUkdyYlRhMHVscXAyM3RLU3pFNHpjRk5lOW9Kb0Vmdkd1NXlz?=
 =?utf-8?Q?7ncDGY8+ksTWe9tw+2hhfWppM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c33503-b136-4965-b8e1-08daedb8856a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 18:29:59.6050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9ebAOAHcBj88u7cSKPrGRA4jEr3tI0UEW+WtC0uoINheeO13YVPMf1KwGuL04tfFtUN5sY1b0hMaPGjbbHG5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-12-23 um 14:36 schrieb Shashank Sharma:
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
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 52 +++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 0d93ec132ebb..a3d0dd6f62c5 100644
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
> @@ -288,6 +290,56 @@ union drm_amdgpu_ctx {
>   	union drm_amdgpu_ctx_out out;
>   };
>   
> +/* user queue IOCTL */
> +#define AMDGPU_USERQ_OP_CREATE	1
> +#define AMDGPU_USERQ_OP_FREE	2
> +
> +#define AMDGPU_USERQ_MQD_FLAGS_SECURE	(1 << 0)

What does "secure" mean here? I don't see this flag referenced anywhere 
in the rest of the patch series.

Regards,
   Felix


> +#define AMDGPU_USERQ_MQD_FLAGS_AQL	(1 << 1)
> +
> +struct drm_amdgpu_userq_mqd {
> +	/** Flags: AMDGPU_USERQ_MQD_FLAGS_* */
> +	__u32	flags;
> +	/** IP type: AMDGPU_HW_IP_* */
> +	__u32	ip_type;
> +	/** GEM object handle */
> +	__u32   doorbell_handle;
> +	/** Doorbell offset in dwords */
> +	__u32   doorbell_offset;
> +	/** GPU virtual address of the queue */
> +	__u64   queue_va;
> +	/** Size of the queue in bytes */
> +	__u64   queue_size;
> +	/** GPU virtual address of the rptr */
> +	__u64   rptr_va;
> +	/** GPU virtual address of the wptr */
> +	__u64   wptr_va;
> +};
> +
> +struct drm_amdgpu_userq_in {
> +	/** AMDGPU_USERQ_OP_* */
> +	__u32	op;
> +	/** Flags */
> +	__u32	flags;
> +	/** Context handle to associate the queue with */
> +	__u32	ctx_id;
> +	__u32	pad;
> +	/** Queue descriptor */
> +	struct drm_amdgpu_userq_mqd mqd;
> +};
> +
> +struct drm_amdgpu_userq_out {
> +	/** Queue handle */
> +	__u32	q_id;
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
