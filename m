Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEF6C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 17:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF9AD10E107;
	Mon, 27 Mar 2023 17:28:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E71510E107
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 17:28:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrVi8If+ao+KUGGtPSEshisb+BIGLLElSN/Bi2OFtRH5Tuo55rIa8lAg7UAtgI1d6UAHW93r8TezBCWpIOIwTEDyz/8fPT4ZAB028IoUZkKVqHONrPTLPMY7q9X3Uq4x5apoJ+RxwuQwafezMbC1iA4Nq8ci7cksG8ndmQ7k6+0D4sQVP7a0RWoxiY5jCBiSJvpSWcKFRvKeA3JbzZuUipzyhdtZXbw7wyqDIRqg8pwSe+CcZ7sXwY7PI0Jmu0Dr8EKRufAXlX6cGf5Nel6MSh637IZd4ADyNEDMqCN6Bhf1W0j1+ZkdzeM2eshWxnJIbNlHbTre45JBCi4i8Zf/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPLKhLFH4p5BtjAhVZrygk/g4QBsHGLUcbZ6bpWT3RM=;
 b=IA8MDWGhShDfqjy7/ADb0fF++xADrlQcFx0o1dKfCSVr4rROK+MZPmMbmp8XUZjXgqO4KXgR1nrPbzbTavY449ADrGulE3knVQvK7NlhMoUJfo4OX97flbGkCaKlDNwg3WHewziN8NcHMIxZ6gBEPRf2aGdxLy0oJlC5Nk6zK4ZEh+lEk3PCj9EAODUeJqYXN55sIRk9ijaU5Gf7Y80h6zo1KXLLtYfwyZ8R2SD0iWIvE2PvzoGvaqbeZztN2FxaVOyemLHZ9YvdVOnNVhhyrHc3/6wfP3OjuMaqqJJ4fipF95PgYZBWKWscL9Aj2to4e630r2Gxh0V0KatY+ZKNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPLKhLFH4p5BtjAhVZrygk/g4QBsHGLUcbZ6bpWT3RM=;
 b=uTx5udes1ZArV0iiO594lhkfWzpgbEpkF9Y+fyQl+ZyOC0lqzgoilgVm+cVecEAu8YWo9AK/Www2mPIY7yzArZX3FxGHFNXsRmohgg0k6vN6w9oIyg3M/TvYohxN4BSgljifKCGNlRoR2nr6L0MUIq79HtK1W5MRCiGYMPtIIRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 17:28:12 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::cdcb:a816:4bc3:a83f%9]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 17:28:11 +0000
Message-ID: <0311dded-20e1-7430-b3ce-41bb55e43ba7@amd.com>
Date: Mon, 27 Mar 2023 13:29:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix error do not initialise globals to 0
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20230327171953.1910597-1-srinivasan.shanmugam@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230327171953.1910597-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0350.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::24) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b4dbf0-2827-4a16-b10e-08db2ee8a35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c9MQ/TrX+YmFCZR60drlxPm1T41vcA2ZzDSr5Y33zjEBCJuDqKkC2FNRb04JM8hh15Okiqvdwv+HQUT+LdwQ+a5tKKJZJtdgVLzhtf1ajT9uJafRcLnz2DsuavDO2CTkXo8IVjcjJizEtianBNHIL8TzsZe8IzEQf3xGIo9UVTQJ+3Vfd7+/fgycccFxz5Ne916peo6R6NvivIlLavWXNFpcWB84DrPkx53dZ5UWr208w8hTyqoTEhg/rFjnQ8EzYM8rxpWplLiCGREFip/X/DdlhzVrRFiS+zpjdx+9wA8qw523b8ojrm5lCHlMzZO91fow62IVd4EH80ijNP4gjVhH+/MTy/u97cmK+BRhe+xxmmsi3lpt2UUe7I0m1zCAzEyE06g7ZVtjrizHVZAv0axPZVZ1/JpLWfkLlaWapJZ9Vk4wAGFGI+yORNccpSy3BpIQBWv7o5nwcFZ9kVMiTxseZODCuuqwyd1k4EyT8wnPQaDlbpTs3ye2sSiHpAmkHSa0phMBoGWHzVT92LjCcF+9ponoFKRaSGhcrHRvdxJD45zZ+/otAzup5NpOYhNSakCKZZPVtFvOHFYZqwQO+IzppBM/zHXHzri5U51HUpmRWt7y4LImNb0CJnjTI6KFl0t7/meDpgNtm/FTaFw6PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(31686004)(38100700002)(2906002)(66574015)(83380400001)(2616005)(6666004)(6486002)(8936002)(5660300002)(53546011)(86362001)(6506007)(26005)(41300700001)(6636002)(66556008)(36756003)(6512007)(66946007)(110136005)(316002)(478600001)(66476007)(8676002)(4326008)(44832011)(31696002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG4zOThZemI5c0dEYkxnekNsZ0VEQU80WlJCYXhzbllKV2dyU2VaRjc2ZExl?=
 =?utf-8?B?NWVXVjNtNmVYZ0J4NjVQeVhxbDd6UjR1YXdWZEhJUCt1aWIvTm9NZFQxSWVN?=
 =?utf-8?B?STF4U05SdkhGM045Yzd1cVd3SGxhRjZGbm5yaXVRcTVic21TUVhFOEt5cFhB?=
 =?utf-8?B?Nm00VDFUWGhObGRrTlltQklucTFRNDdMamZ5bTd1VWxkZUExUlFGamR6elAw?=
 =?utf-8?B?Mi91dDBmZUFaYVR6Z2pCOU0vbXh1YXVKSkkvbEJwMDFZQVNlZGF2Wi9GYWsv?=
 =?utf-8?B?RUpVanRpdWhPc3hQN0xrbDk4Wi9yVlNOakNxZ3ZCME1XM2VoU1N4bVJxYlQz?=
 =?utf-8?B?RTY4L1FkcndqVTl0ODllV0wwbzlDMGNoL2R3YkxYUmMzUyszMlNPeVcvVXds?=
 =?utf-8?B?NDRRSnIrR1hkalVQN0t6dHBxRm1PckNuNlFXMzFxUlpQV1lRaytyZFNrdkdD?=
 =?utf-8?B?dXoveVdBcTVxVUJqQ0NMbTRoOXlIVnpqNjl2WitWM2VEMkZXVEhpUE5BZ2JU?=
 =?utf-8?B?R0JsYy93aVRNOW9ZUE5Nb3F6R2pubXFnSGNwRFR0azF5K3E1T1FXSUl5Y1lL?=
 =?utf-8?B?d0hXRzMwY2sxL2xWYVoxS2d5ejM3MGJ6S3hTQTBGbDl4NGRIUitNWVJpU3Jr?=
 =?utf-8?B?WDBQVEJFY3J3N3VUYkIwbXV3OWdLSitBRnNxRklpbHNXNmlRN1Z5R1VyUmRT?=
 =?utf-8?B?enAvQVFxOHB0ZjZhV3c0OVcxamFuUCtWcEVQYmxPWmFMczZSTWlhc2hoRm9L?=
 =?utf-8?B?Nk5CZ2dLdG5zbm12elJlYUhSSTdlRmNNTG80UjF1OUFFenVkRjZoc1NnWTU1?=
 =?utf-8?B?MG00K3BxL29BaDc2ZVlsRW42R2Zwc3RLR2ZuRis3NFh5bzRhcXcrZzBRK1FI?=
 =?utf-8?B?L281K2t0TlFMdjN0VzQ5cGZoZkw0aE5UaTdYRnhUTzVibWhuUGNVUklIb3FL?=
 =?utf-8?B?QjdmUkJQVzE2TS93RVRETEd5M3VNMEdxZTc1eXcwaWRNWnlMN3ArQ0VSajUv?=
 =?utf-8?B?eTNrV1pkMDd3dmQrMzdJNWNXeHB2RXVhL3JuWkQ1UWNmUHVqSjhXNVZLUWNN?=
 =?utf-8?B?ZDlqOWwxcHd5eVUzWW41ZDhUd1h5eVN2Z0UyT0FYU1RlTDZ3VVUvRmVqZ2NZ?=
 =?utf-8?B?RnpoU0NoMVhTZ3NNM1FzcnpONnBlWkE5ZUpiOG5ISW1DUmphdjFPb0h5NGJN?=
 =?utf-8?B?SG1LbUVUVE5OVmVqU1cyK0NjUXpMTGw1WTdTdDF1RUZHSXJ4emptaFlOc3Bx?=
 =?utf-8?B?aGJIMkdwd3ZRNEFBcU5VQ3RDM1FNWE5kUWtxVnE2SkNEQkk4bXFpL21UU1hp?=
 =?utf-8?B?TWZtb1NtdTZEdVovYVRxVWRaenhJVjdMREpra21TZUplZ1lHeEMrVGZFSnNk?=
 =?utf-8?B?d2o0UVh2NXgwZEhQNU94aEhSczlod3g4ZmNrbGtJR29vREtlVUdFV1lYRHY4?=
 =?utf-8?B?WE10V3RiM1d6RGQwaDVaTWR4Tm84QjRsdVZESkZzUjlPaW5MVmpkQXZaSjUr?=
 =?utf-8?B?Y2pHblIxNVBSa1B4bXEwUGRGbHRORWx1SWhjZUp2YUJJcDgxelZ2N1BrY1JS?=
 =?utf-8?B?T1N3ejhzS3NWR1dlYnZEVFA2emM5eWF6S0J2Sy9LUmFLNmlmRHd5UWdkSWZC?=
 =?utf-8?B?Z2E4Q2xOVzNyVnZ4bHBzblMrRE1zaVViZ3g0NUhEcVZ5ZmNONURPYndrMkNR?=
 =?utf-8?B?VzRiZktNRnAzRWUvMUZ0NHU0ZmNrNlNTZHdQRGF5RHhrSGFHUmN4WDk2ZDVT?=
 =?utf-8?B?Umg4WGhWcm96U0ZveXowcHlLanczaGxVYitEMEhnVDNiVFdJRFBJMFVualkw?=
 =?utf-8?B?S3QwSmtmeThLM2tqUmVjQ1MrUUZnSXZkQWtsb0E2SXZPcnFJaDJrcFpmWjEy?=
 =?utf-8?B?Y3FhSmVvdWZSU3VSMWJyR0JhOGpXRlFycllYL0xEeFVxMG1zcEQ3eU1uRm1t?=
 =?utf-8?B?c09LK3dRZFpGa3Y1eXY5MEU2VmlJRGdjOVh3NWRDNmFmS3lLTnRkVUVVYUs3?=
 =?utf-8?B?Yy9KdThSMlI1UjZuRDVtYU5aRDhGdEZ3a05xZ2c4UWNwdkN4OUpRU0NWUjVY?=
 =?utf-8?B?dHNUNHAyTlN3RUxBTENOQjNyZjBYM2tNaXVwY2NoYS81VGd3UUc1a3ZkNHBk?=
 =?utf-8?Q?IvwcxdVR8yTmVVO6Y5nI5QyAm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b4dbf0-2827-4a16-b10e-08db2ee8a35c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 17:28:11.4401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JatsTUka4b9ubdwlwg/Zo6cUPt0PxNORwx4IzbMw7RXTXpKrOrENRC9tooRJbbvT//83Rt33ichnEV7YM5Ctmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/27/23 13:19, Srinivasan Shanmugam wrote:
> Global variables do not need to be initialized to 0 and checkpatch
> flags this error in drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:
> 
> ERROR: do not initialise globals to 0
> +int amdgpu_no_queue_eviction_on_vm_fault = 0;
> 
> Fix this checkpatch error.
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 917926c8dc5f5..67dbac87202e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -823,7 +823,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
>    * DOC: no_queue_eviction_on_vm_fault (int)
>    * If set, process queues will not be evicted on gpuvm fault. This is to keep the wavefront context for debugging (0 = queue eviction, 1 = no queue eviction). The default is 0 (queue eviction).
>    */
> -int amdgpu_no_queue_eviction_on_vm_fault = 0;
> +int amdgpu_no_queue_eviction_on_vm_fault;
>   MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
>   module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
>   #endif

-- 
Hamza

