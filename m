Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA52C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A9A10E36B;
	Tue, 27 Sep 2022 14:29:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EA110E36B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:28:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUCgrbheM4qYSP55kF69PoXzhdKP6COlvNnwNsUTIidqg4Do6ZmSQ6G8TnhyxWBe2ENQLdQfVyyJeMVZevKEQXkvR4KKGVgnocMvkLVx22QWltY3gLEDpKXcMue/VN/gmxoRIFRlKqNaJmYGanBDkPyEis8HpitulEKy/cWFakS//nXzg4LZCHXbVSKPESp203wbp5ucbzFKsdvBPVTZrgBsnWP1XNxHzIkdbklXB1ABlzhgfBV6QbbnRr8FSQanmCPFjsni11HiK56aqk9xAb0kaF9wA7cwbjw9oWgeZkqZDPFRI75/Mk1qDnVI5jtrBSpxs19cey3gziW0gZBvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueABOdNOFqw+q4iOQLYCacfcZY3UC/xYN+7HVHSr200=;
 b=Hljrh4EIPLbqlpXnqJQq+OT+UQ+mjhCSwMOqyuXheqCEDOvTeAZgs1PpgLV+BoFTNwFywi4qM/vJ65mqD5ysUTCtNmkVeUH+J1zrvCybrJY9+qpqIVper6T6OqlAqy1OirDxk8PsDsnotla9aLrTls3Diwj5o2O118sDBlq4nAqOwhiFjAEE4WLr0hgyjR/duY4KWwgRYMw3Jr4SajYNWMl41eZ/ewUDBFTiFGRmRBIWORhOcvIWMcVfpHjAIm1nq6LoUCsDJzkJ+d+jHwf1wBuJF3/mhcJ2etgdUOdm4qN1mFTwI4STbOqGWAXG1IxgWDbjYrg6ARNu2Htxl/kXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueABOdNOFqw+q4iOQLYCacfcZY3UC/xYN+7HVHSr200=;
 b=f3Oi6mRDwxNK3J/rPJ9PaimnSUqWmdaSGVgs5vBqfoMvfBKSCU5r4IgUGtCR56T4RRVU9acvIiweS2Q66+BISrU+yidK4TMumwQJ36tm6V4oxVSc9VqMIid+Wp/K0FYNb1glSy2i7jpULBILi5cxwelWD/qgeLf5Vj9lOt1NHBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 14:28:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Tue, 27 Sep 2022
 14:28:55 +0000
Message-ID: <9912aab4-7168-1eb7-5018-e2b140397741@amd.com>
Date: Tue, 27 Sep 2022 10:28:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220926214014.5450-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c30d6ed-60b0-4615-4832-08daa0949b6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjqOcnyxDKkraLUIWNm/idP3NOxElB8YtwSXS6M7ZU4BLS3jBPSwT7UjU0IceWwMNjCMEyqmuGWKR2jpHjDH0PEFF8iouSkPpWNqxf9xxtNBL5TRBGn3D2zT4OpziKvRLo6kwRj7ri3QaM2Flj4ymLb0GABa3TIQPGvjDSZQvBxFXs7P9D0GMSHSCk2qTbGb8EmSoP4W1H9QsG//b2yhSuafAhkltgzhu8rBaI28dtz48MGzurpYqD4dPZo58moqLQeRShE3K9zAM81b/xZSy5ek7W4xfeoBBgyt2mXw0oSwahYQdJzqSn7ABT1/Pc4iZSjdjLAKbeE5EaP0lPKEQ4W6U1YwbIL++KtVBCeodm2KgSWArl1Jmo0zJZof8AP34k0J80tCWNoL6+BPBjkpOTIYSz5nQ0dHgJAyv55saO8nXmQWMo2ERkQSrNqoCcls/Fdx5+mrurXAU0kAFBC63f0tqSJbynRdn/ywUB4XTMgZCsK9rkgUdBVm2X5WvMKs7nqEFP/V3WaMZYNZ7D4H0yXB7gJQw4QZIx/YvvWOvKmbom5vRUSy0BCysqnIiMTHe5BQjdKqZFMB4GSBBw6gYmVCYKthGKItuDe68GAckhiVi5YQ5f/adrdrux2C+cNyluQgS4KxmrpIbywyt7X4HmEAnrCQVGLRCxVXkLjjmsIsaEqq2FtCDDX79VzMiWsYO2nXN//UNGxtn86B7EsiMumZwsX1eNB4K80dFoZd7nTs/WKGc9VNY0n2eV4uLI1ZSrqocADYJnpCz4n5VQAOb5XmSGQwWXzjXTKDavTIOqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(186003)(2906002)(2616005)(38100700002)(36756003)(31696002)(86362001)(66476007)(66946007)(66556008)(316002)(8676002)(478600001)(6486002)(4326008)(44832011)(26005)(6512007)(5660300002)(6506007)(41300700001)(31686004)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlcweU1vamtmV21aRjdpdlJqQk41OHB1ZEhpcWxEWEN4MjJiQy9PVHRoVFlW?=
 =?utf-8?B?dXUvSHQ0c1g5VVg4SVVPOTlNK1VZMDhueVhka1h2cHQyVlVsd3ZQcUxVMUV1?=
 =?utf-8?B?ajE2TU44UHdTeEhON0lGMFZlT2NUN1dUTVBlQmVZR3l1Mmorb0FKOWR3N01C?=
 =?utf-8?B?Mng4am5qUlJpeXAwbzhkVXFzZzdFT3MxTUxncExkR2t4RFpVM2RoY29qRVht?=
 =?utf-8?B?RVluSXR4SEpwcXlOTE4wUTdsSDBhWWsrWnZpWHRMekNZS2ZCdGxnMkFVeHND?=
 =?utf-8?B?alVQR3IrUFluWW1EZFZZeGJjWlY5b1lDRDdVYS92TDVVY0hSZ1lDbGVVMjhz?=
 =?utf-8?B?Q0h6T2RIOUpBVlZQME9aQ0NqWUo0UHZpaHpFT3lHdllJN1hBOU5FYjd6akRx?=
 =?utf-8?B?UnUzZVRFYVFTT2xCTlMxQkFpb0dldmRCVjd4WGlkaGR3YWpnRzkyU2kycVNt?=
 =?utf-8?B?VWJnK3BVd3NBWldzdHRPeXRvYXdQTVczUXBlUEhwb2JIeXJhdTJmNnhVeUpa?=
 =?utf-8?B?aUoxRU1CcE9UWS9mTFdMNVB5Y1hzTHJ3SXhCNCtMM1prNmpaTEJwL1hiRnNH?=
 =?utf-8?B?eUhVTU1IWFdXMTh0OU0xZHJvd05RMldGaHU2MXhxU2xLcnVnQ1hkdy94emlR?=
 =?utf-8?B?emQ0bk16ZmVlSUNkRE9tMnFrKzl3d05ZOWFteEM3dzRnMVU0cTErU2IyT1JL?=
 =?utf-8?B?OVVZcGtKVm95ZFlQTW16NEVqSGFpV0hNbFdwYmFzaVZvVEN2eVNEVmJGYWZM?=
 =?utf-8?B?cTBuNmdkTG55M3djYktvd2FmcFZkQ0JMYXlITlhzMEZ1dzd5R2VtOE1DZ1Bj?=
 =?utf-8?B?bjQxSDE5WHZXQmlSRkxWenp4Mmc4WFZRSmZNKzgyYi9ucVJnVDZWWlpxQU9n?=
 =?utf-8?B?SDVkYTJnamlZaUlhTzFzMmgrUGF5VHMyNjFXdDBJVVZ6VkozWVBFQjR3RE9I?=
 =?utf-8?B?VkRlMGV2WGQ0dWkrVXJwV1NMZG9RV0xNVnZOWjFDWC9PQ0JHZmhOTUIrNkdG?=
 =?utf-8?B?Y0RPV1NqbzVwa2lzaitvaEo5V2x3cDdIQllyY3JVSkRQbXNyQkhnVDFXSE9T?=
 =?utf-8?B?NGpIUmp6YmxGRE8yM3cySUlzMnUwai8xR3VDcFcyQ2dhM09DQlJSWmFLMTJS?=
 =?utf-8?B?T0loSWRyb3psOXN4OFQ4S1pvRkNmci9IUzBmelRYd001YVhFeTFZYTJlSlBW?=
 =?utf-8?B?YlQrMnVaMjdWb2dFSTlSbmQwL0xHbzdpU0EwTFZmNVJMdjE1WUczOXlHeVV1?=
 =?utf-8?B?S29LVEViNUNrWlMzdGx2am9OdDNUQWZMamh4Z2JYR1IrNEorOXFXbngxTHBv?=
 =?utf-8?B?emxXTGVsMXFSK1NvZHdTMGFheGkxR2MyL0M1Y0xoZmZ2dk1tVGJ6SXlwUXhs?=
 =?utf-8?B?ck5HOVh2aHdCMitjVVdyRE1qYTV1UjU3RitCclJ3UXVKdnlSS2NkSThuV1Fs?=
 =?utf-8?B?bTd3SXowMHd2eStvY1Vnd1hMckJBajZlWTEycUlzRDdINWhDdWxHR3pQY0k0?=
 =?utf-8?B?SUNGSkVUOVk1VFVDb0graHR4RktHbXlUSVNtaDhKaWZvSGZON1VwdS9yVzVy?=
 =?utf-8?B?M1lNRzA3YkdqL05tbFo2ZUJySDN1cUoyVy9NRFhWckkwN0RHK2p1KzVBNDVX?=
 =?utf-8?B?alpHcmRJWXhOSnhZNnJDQVRaVW81NGZnOTN0ODFZcjZ6dHJjNWJmWmVTVzNo?=
 =?utf-8?B?Y2sxWDZ0WXozL2h3WHlqQllPVTFPK3kzOHJ0V1ZFVTh3Vk9tY2l6amhlNUJj?=
 =?utf-8?B?SUZpK29YeFJzb21mcFpXVDNoZXVrSW5yK2YyU2IyNit0RUx3WG5oU3JVMEZY?=
 =?utf-8?B?UzlNN3hNMXZWdWNuU0lhUUYxNXFoVFZ3bzJEZHUzSk03bDc1d0lMZkhjbkNr?=
 =?utf-8?B?ZGJtd3lsM3FUeG02QUR6NjNLTnJBKzFaNHFjRjI4QzdDTGtvb3dmZlhycTZi?=
 =?utf-8?B?MFJjbTdMSk5VTjBMMVNYd0pkc0FWcTFyTTdEUW0vZDJReU5iZVpudTVtcy84?=
 =?utf-8?B?NlVPSEJGT3F3c1ZTK2NWOWJLN3UrZnRUY2Z6Nm5xbHpSRW0vb0FhbGExd0lZ?=
 =?utf-8?B?WTVua1NMajVXdURwVEZKSURxOGtnZUwyTDZja1FlM3dkMkxva095R1lDYzZB?=
 =?utf-8?Q?I++7vlDH4D3ddX9rqtdMdHkzX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c30d6ed-60b0-4615-4832-08daa0949b6a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:28:55.0946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfPh/hRm8/R1wzwYlOvR74goRNLj+HS3wQDj006QFsvvqfRoOgKovvKNLCOg32zfyJeRktXiUr4Bt/6tB2mZUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-09-26 um 17:40 schrieb Shashank Sharma:
> Allow the user to specify a workload hint to the kernel.
> We can use these to tweak the dpm heuristics to better match
> the workload for improved performance.
>
> V3: Create only set() workload UAPI (Christian)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>   include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index c2c9c674a223..23d354242699 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_OP_QUERY_STATE2	4
>   #define AMDGPU_CTX_OP_GET_STABLE_PSTATE	5
>   #define AMDGPU_CTX_OP_SET_STABLE_PSTATE	6
> +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE	7
>   
>   /* GPU reset status */
>   #define AMDGPU_CTX_NO_RESET		0
> @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>   #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>   #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>   
> +/* GPU workload hints, flag bits 8-15 */
> +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
> +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)

8 bits seems overkill for this. Are we ever going to have 256 different 
workload types? Maybe 4 bits would be enough. That would allow up to 16 
types.


> +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 << AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
> +#define AMDGPU_CTX_WORKLOAD_HINT_MAX	   AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
> +#define AMDGPU_CTX_WORKLOAD_INDEX(n)	   (n >> AMDGPU_CTX_WORKLOAD_HINT_SHIFT)

The macro argument (n) should be wrapped in parentheses. Also, it may be 
a good idea to apply the AMDGPU_CTX_WORKLOAD_HINT_MASK when extracting 
the index, in case more flags are added at higher bits in the future:

     (((n) & AMDGPU_CTX_WORKLOAD_HINT_MASK) >> AMDGPU_WORKLOAD_HINT_SHIFT)

Regards,
   Felix


> +
>   struct drm_amdgpu_ctx_in {
>   	/** AMDGPU_CTX_OP_* */
>   	__u32	op;
> @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
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
