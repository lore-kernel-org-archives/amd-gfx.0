Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785ECC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB0910E6D4;
	Mon, 26 Sep 2022 15:10:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F20310E460
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArM6lgkQyTV0neu1ODQlMW5qHW8Re7s14lwAS2B6OJ6ennc0uThIDmVp2Hrgd+iPGO22t/O8KTn3krSWEUT+HrI8EkQpcM4Q2KZprRte3piQN87D5kXfvMI1cW5oVj0VX/yrzLCU1bBA611TxyoAgEyyDuMquIFRXNptKrrshJFlRtfRdNQuHElWhYNd6/3d00e5qVgWMZqJ7yFWPIEnbRpvNeAsWrccCj/irZjvgOsS9/f+VsjjbggNGn25uoLWj0xXBVuccSSETF3jZuyipSb11vuquacwFlwKZs4iRvH+el947SflIQAtklJqlbowBSb7OJSsx8ossHskLTCQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mOE45McHFZO5XkYNYA5WJvtyOHLIU5/dqlKnPmWnG0=;
 b=XhuyQx8R69GSj1GOSrH2alBboQZ8Lx4hSC8CLMngA4Pv6OnSd9zX+yHpbmfTuRQvC4j7dgT8mr93SbQ+aCKDlfqJhRLYMaoMMOm0G9RV8qFEkZDOHtZ8Z5r5MTGOwcbvVgZ4C7kAJpURhIFaMrn/dnyF1dLhGdPQ1c18YfZV+PXo/gykAkwqf86TqPfBh3CGioVHPqKWfsmK2YVkthPRrm9TyGcEwq3TY1wlJPheCuRUuIke3j6QEXBkb+dd+GkK7Q5yVClOBiYWCGPPVtwR6wzatftUhYS1+ntnAEnqE0N6rGJmZfNp2Mb9+0942G+dgHPJcNeKh9NhshA5fLGIcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mOE45McHFZO5XkYNYA5WJvtyOHLIU5/dqlKnPmWnG0=;
 b=Gbbl6etV63Dkz7RAdEYZeN0Zz0CozQ+9wlOCK6ez1jQQXTWlO9VXIhtlHxTTRAyHbfjKV8jLOar0Pz8IKiaZHv8+j3XeSk1MqgFyP92gD6nvHkVBhsM1bjNByUBRyVYAH+i44NXCwwRUh0Uaqsiuv2U9wRxYwLRuvUB0zLKLdJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:10:26 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 15:10:26 +0000
Message-ID: <5e13829e-369b-80a1-5226-c3f0b62534a0@amd.com>
Date: Mon, 26 Sep 2022 17:10:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926150252.18635-1-shashank.sharma@amd.com>
 <20220926150252.18635-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220926150252.18635-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR04CA0175.eurprd04.prod.outlook.com
 (2603:10a6:20b:530::26) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 302a2594-e8be-4051-8e22-08da9fd13dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +LG9GSbicJoFbywEdZC3fNihRuGOnuCLQ/12ks3oqg7EQHjf6TKHLPImvvjPxTn+uG8ys6OK9dEYDvSC3/5uDEKixqUZkP9cWpF6kjRP7Lb3oo0Yy4yg1vFyRhIVNy66+WBBz98yRD9aW3einC079C+8J5TSTEJhbPrn/lUqd1DLC3+BwE+6fWpcekrT89eNRS9eyLask1b6hMi0gXl/nvhIAui1D9te2fUJIVfujJeXdfKZebYA35w6SNqq4ICZBmVt6QxJTatMGdYNILYgn+R9eCDg75hUQ95KbsKq1czOr+6XVrrjXorhy3Jt8T81PLh22eBa17tKzUOzdup/37NUCX8VG7X6YKW+Wr0NrFvCW6NIEt3iN2qxNc17C+fkMugLmuoKDYEAm+SH7EAA3a+ELBVG47JPaBjOzAlOvkyNrvrGSTcTmr3U8Mrdvz3syK5shy2GPFakBFDkmCYi/sMVCEHuCh6VfOdf01lYxJLwiaBbLVxb6ziynkm5Tb6bpvd98ZNWkcIpVtlasu5Go/+zA0qmfXtNCQaBA6b/s3zkR6HCNDnNfkkiwDEBvfBlaZBv+qC8lDm3krnId83FbaonOvhK+o/nNyXP8ZAnugZIvRYMUkC029xGd7+O+DD6qxMQX3Am0p/EXMIp6M6rFHzzsu4JjAqlBZGL13o5ii9738ZzqOMIYMJiw8w+59/0Hj9FUkr/8gMH2yFFChljvoaJ93Ikmn792lSl34K7OOCL8h5YchwRNCrABxqN8WIXKOiCUVV55qHr33xKy3EFmUCVqRkTwrf0PJ1beTCKLbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(86362001)(31696002)(8936002)(316002)(41300700001)(8676002)(66946007)(66556008)(66476007)(5660300002)(4326008)(38100700002)(6666004)(6506007)(478600001)(2616005)(186003)(6486002)(6512007)(31686004)(36756003)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0Q0ekg5alNLeGg2ZnZYQmVaQVBQdU93VGxZcW95cUdoWmpuTExaWEVpTEJv?=
 =?utf-8?B?VVZUdDdKckZZTkdtMiszYjhBMUk1bUN2cVB4ZXZNZmxzWDdwaDBhcCtValoz?=
 =?utf-8?B?L3YxS0UweHpMYnNTNzBhS04zb1dpTUIxZUZmUFdLTzZvNGdhMk4zUi92T0U4?=
 =?utf-8?B?OUFKNU5zSnFZbFdOWUliQ3h1OGxmb1NTcmFBOThLdUl4UlpybmZ1dkwzSm8y?=
 =?utf-8?B?UVZWLy9qenVYN2lUa3hXZnVTRk1QbXpPeGhFRTNwWllZaFRzbHFCaDZzOG1F?=
 =?utf-8?B?TDZ5cUdoZjZFS1M2MUdxSk5rVHNZRWVtQWFBWlRKRDNTb3FmTEowcUptRHEv?=
 =?utf-8?B?U3JndlR4WUlCejRSTS9vOWtQTC9LSmJVZDNOeEYxY3d6QWFrRlE2VVZOaHl0?=
 =?utf-8?B?VXdpQ2JWVFplRWVzWjRSUkhlVkU1cTQ0dUt2di9HZVcyTmRVdGM3THY3NlFC?=
 =?utf-8?B?UTlaT01DVElvNkdraGJFSGFaWmcwQ3pBYTZpblcvZUZLYUlqWjJmcHBTbklJ?=
 =?utf-8?B?Q0M3UVl0SjViQjQ4VlQ5RnRtN3pMTzZVWTlGeW13TksvSUFDWGNkY3VNZ2pq?=
 =?utf-8?B?TGJlaVNHdW1WakFVdERMQytwSFprOUhHWUVuUzE2K2xDMVplUlkxVnRJY0U1?=
 =?utf-8?B?SUR4eVM2bEg4T3VKU0wzZ2cremNGeWFOeFpGbDdLUmJxcXpDMnVNSFlQU3BG?=
 =?utf-8?B?VWZ1bmcvY05COUptYVFiTzU5NmpkSU1KUHdXNWtMUGFNdkJJR0VheWdUUEU0?=
 =?utf-8?B?aVNSc3ZDc3h0RkZoMDdnd2NUZksyWnZVZ0ZaY1BRMS9sMkpIdk9xbUo5TnMw?=
 =?utf-8?B?VHJCMlppM1pHUG9Dd3dOR0NMK3Q0VHVLbEFzR1E5Q2kreEZGWk1MUHdjU3c0?=
 =?utf-8?B?UDFrbFROZHVUZytmTE12MUg4WkM3NUlsb0FUNG9POEJJVU9ERFdnZTFoYnVG?=
 =?utf-8?B?TXVHNHNTNWVmNWtXZ0toeGpoOWdJRDVSQzNKYnVqaUJpRU9GSWhuM2ZONzFE?=
 =?utf-8?B?cS9iMDA4OGJiZFBlSlFJZXFTNmN6eEl0K0RkK3dtdGowQmFlV3Z4cW83VVNS?=
 =?utf-8?B?UW94SEJ4WEJQTlQ2RG5sbWsrNlFGUVJFRUZhY0F6dEdHMmZsTXZURDROK2dr?=
 =?utf-8?B?M0tpQW8zWFhyZU0zNU8zMVZ5dHJGUXVvZm0vNkhvZW81ZEpEUCt2bEh2RkJ1?=
 =?utf-8?B?YmNKbkFUWWtnTzkwTlZEVm9scysxWENCL3hkZEViU2hubzZONWRPeXI0SGJS?=
 =?utf-8?B?YXlJelQ1bzBIWDF4YWpXR0R4eXNRWlZyZm15TjNrV2YwMWhudVNpU2lhN2tD?=
 =?utf-8?B?bFoycmZGR0JmRlFIRFB4RlpsM1l3ZElaVTlaMmlUckhpRDF1VnBMeXpwYWtY?=
 =?utf-8?B?c2VZZGtrQlBHYVRJMkdUYXBJSG1CVDZFRjIyeG50WXZtS0J3M3I4eDJnSW1m?=
 =?utf-8?B?OG1TTTc2WVhscmtvd285T1BEMWJZZGhqZ3cxc0pEQ2dDVy9UdGdXS1kvZnds?=
 =?utf-8?B?RThBMW9ZcTE4Ni91bXJpVThocmdIOWF2ZkZETUpGdGJKVi92NXJWVE5WUkh6?=
 =?utf-8?B?N0lEb2tGdGU5aW96M3krSUVXNmhIdHNyc3M1bGYxTE9vbmYrR3RSUXdIdFNY?=
 =?utf-8?B?VVVWYlZLMXlvOGRlLysvVEE1TXlWVE5PbUhxeE9WanpvSFVLODY4TENTdXVP?=
 =?utf-8?B?M3RDZjNLNVFtVjYxS1NxTm84UXBNZ1NoRlNlTTRjRis1OFIyL3JiUWNzR3Qw?=
 =?utf-8?B?VGxSQ2plTVhzdXRkbnErYnRnTldLOVEyUjhBWG1rbmxjR3NFUzFYL1VpeEdv?=
 =?utf-8?B?djlHSTV5MG51QW82RENCN1g0a3pUYnQ3dmhxQm43RUFTNEtzMmw4dXRhVlp6?=
 =?utf-8?B?dWFGOEpJTDR2Ny9KZENIb0VmMmRlcGVtL0xhRVk4cjFqaHpVVnVJbUo1T2xo?=
 =?utf-8?B?SXg2ZlNyWXUrRHBBRWRGMGVtbGcwbUx1V2N2VkJrU2NPYTFQN01GWVdKRCtJ?=
 =?utf-8?B?Vkl4SDIrOWxCNFFFVmxpL0Y0ZlpTb3ZOZHJNMkxGeU4ranlhdHc2M3RpS1JK?=
 =?utf-8?B?bjFkTE5MVWQyUW5LRnlISEk1K3pvOWMwRlNSZ0lhSWhLeHJVM2dzclVnOEpM?=
 =?utf-8?B?VFhTWENXVk5mSHJ1V0d2dmlNK1ZaUzYwTnMwMVhhZ083K3prMHVkcFBkaVdT?=
 =?utf-8?Q?kH2ik5sc3nrb4Kgb4+o2EY3i20cwkilVgmwZ3qdw+PeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302a2594-e8be-4051-8e22-08da9fd13dfc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 15:10:26.5476 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPllwe2B7jRYB5RFozsT8nD+VjRjP8Q//conP6KJPJ/UvwQ80zMK+UdGFfMTCvZz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.09.22 um 17:02 schrieb Shashank Sharma:
> Allow the user to specify a workload hint to the kernel.
> We can use these to tweak the dpm heuristics to better match
> the workload for improved performance.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c2c9c674a223..da5019a6e233 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -212,6 +212,8 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_OP_QUERY_STATE2	4
>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
> +#define AMDGPU_CTX_OP_GET_WORKLOAD_PROFILE	7

Do we really have an use case for getting the profile or is that just 
added for completeness?

At base minimum we need a test-case for both to exercise the UAPI.

Regards,
Christian.

> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	8
>   
>   /* GPU reset status */
>   #define AMDGPU_CTX_NO_RESET		0
> @@ -252,6 +254,17 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>   
> +/* GPU workload hints, flag bits 8-15 */
> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX	   AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)	   (n >> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +
>   struct drm_amdgpu_ctx_in {
>   	/** AMDGPU_CTX_OP_* */
>   	__u32	op;
> @@ -281,6 +294,11 @@ union drm_amdgpu_ctx_out {
>   			__u32	flags;
>   			__u32	_pad;
>   		} pstate;
> +
> +		struct {
> +			__u32	flags;
> +			__u32	_pad;
> +		} workload;
>   };
>   
>   union drm_amdgpu_ctx {

