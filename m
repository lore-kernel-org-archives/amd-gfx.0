Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B537BCCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 10:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C7B10EA6D;
	Fri,  7 Nov 2025 10:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c8Jh3THq";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28F110EA6D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 10:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QClMXbJDuW0nidowsLUEmGf1VdxVBa24eM0c87T3uWeWuU0wcktyTQAF62ha9oOi5aj7m0ZoePzoxLTuKPFCqaBl2EkbaRGii7a5H9Ds0ZWBvKSNpadQ1pIWmiuUfeC1hYZXR8vnzNs1F+SCvpBo2g0aFDr3XGy+fCj/5xNZfruYUxLfZJQLXL0V1ZO+/IHGbAyzvrdleHGVXUN+XCJB7Qp8xJqL0rT9kMigNWBUOinmhIk1G1SUamKWb3Ob+vj+xgb2186Lq+LP1/zjgVfGaRw9ommnEj+67J3LXKARjrmKsr8lrmly1ENeF922ouEydjZ2Pm1FPK9cSdg1IrKrnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjLmxs0TSnwVz6JATutQdCwHIYBzKvbeNP9tTU6kscM=;
 b=az/O30f8IKQDC/S60dJ6r55+nMqzsr0klKvU3YKKH9F/t+kKCsTGAlqQfTpt+g8JizqzYpGhJmoNJXuwG6lGnNAlWcU4b5ollQabYAtIrgB5RX3oUIU7MU/PnK+jJgluqwx+V1i089kWmtYJ82O8mcLz6770f92NBFYz+t5pZxY+jbugLPXcA47qIZbqBwJrmVwKJ2muX99gBbeKXHG1A8oED+a47CGVDZhtm5UT022AHkqNqHYzz/elb/o2rBFEvPmaAPAM2Y9EJSum39MfFu1DDFHPTTLzpi96KmPl+t6SHjljuHmOldzVsBjY/ZKWCd+Lrf03U9j9dAwOEGGD7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjLmxs0TSnwVz6JATutQdCwHIYBzKvbeNP9tTU6kscM=;
 b=c8Jh3THq5V5WpBZ1pJ9ytS4kUKQDFraQSbQB5Aen/FhEB7dClEigjvuYPuzjTe2MwLF1YZ6bXdR5T510U3oPxyYK6UGquM11zsYFtGTFfZw+NKP0VTT5MEaYuqt20p0OMqivH2D1qoRvxhzGHReak/9YXZi6m+S9uHF5EsggYnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:35:07 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 10:35:07 +0000
Message-ID: <a1d6a999-c031-4767-be1f-69f423124dbc@amd.com>
Date: Fri, 7 Nov 2025 11:35:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix lock warning in
 amdgpu_userq_fence_driver_process
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20251107102232.4066722-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251107102232.4066722-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0923.namprd03.prod.outlook.com
 (2603:10b6:408:107::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: a420478a-b020-4d39-2a76-08de1de951e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHJEOHFJSHhWWXdjZWplemhSclE0VEJWWjQyc2ovRC9VMkt5ekJVTTVqbURl?=
 =?utf-8?B?NmNWWi95L0RmRkp0N2lQMzU0cEdEUENNWCszM0hKak50MUF0b1NDOFhTOThu?=
 =?utf-8?B?ek4yVWZhTEF2SFluamVSVFdqbVh2R1p4QmpOa3djUGtXNk1vbmJ0ZXZFUmJz?=
 =?utf-8?B?b3h6SXNiT2tKMk1TTThnRVJOTkhaOEZUK3ErVWdtaW44MWtLYkl2SThycFJ5?=
 =?utf-8?B?Sk5vYUdGUGF4M1NYcW02V1kreTRJMWh4bklldFZwbkl3WmI4K2JpeDQ3MXJX?=
 =?utf-8?B?a0szYlJIYzF2TGQzZ2g5MnovMUJUOTM1V1U3WmpxNURoN2lJTnNsQXl5S2pK?=
 =?utf-8?B?WG16TlZhbXQ0MFZjVENLWHJ2OWVLdEV3R2lxMktFTWU0aVNOdWlZQzllcENx?=
 =?utf-8?B?eHJwTzM3ckd0bWZtV0o5QmRxd0hCc2xFcnV5WThFUjU4OW5kU215U2IrbVA3?=
 =?utf-8?B?VDZEKzBUcDRidVpXRnlndXU1U3ByS2w3dUszTzBnWG95bTV0QVQ3MnF1M09L?=
 =?utf-8?B?L1FnQnhsYkRzMHhWRTl5NFVESysyRG11VDhTK1FpVk5kRHJZQmhoU0xLdGRS?=
 =?utf-8?B?d09GRk1HaUNyVm9tNHBnSFNzZnNBSzl4VDJCbmVILytKc1VMWDQxbkw1VlpW?=
 =?utf-8?B?OVJuRWhRTVpGVXlZbCsrODRReHk2QVpVUG5NZ0xLSjFKeVZvcjZFRDdvMzhj?=
 =?utf-8?B?L1NBc2tJcnA2eG5vaHI4Mjdocmk3WjdDdzdkMFRHSmE2MXVpenVKd2R2UU5w?=
 =?utf-8?B?SnY5Rys2Vk01RVB0OVRhZVJqZUZYZU04VDBGQklTaUUrbTdFakV1WHpsZG82?=
 =?utf-8?B?ZkFaYzBDcTJodGZyK2lRWHQwQzhyZ3ZlejBIMnMzcndwZVJQdUdMRksyNHV1?=
 =?utf-8?B?cFlJL0tyc3daU01LSkVuTkpkV0dycUw4R3hSMC8wZGVZSEtnSmIwMk82cWFj?=
 =?utf-8?B?UkVqZXFRTVlHYlo4YVZnSjhRU1FwN21aL2Q5eThRUWUyaEg3TnpHYWozbkZ1?=
 =?utf-8?B?V0VHeFdkVGQ1SVpucEJFcmxpZDIwcnd3VTdrTGNGZVlIVzRHYzhBNVQ3Z2R3?=
 =?utf-8?B?Y0ltYTZGMEp3WUljWThYWW1NUWFreEw0ZkJWNW1DSDFhMjBNMzBWR1ErRFln?=
 =?utf-8?B?Vk1aVy9GajlvUk42UUwvbFRFSTB5TER1OWRFcE9WZ1JpVnpLLzFlZXBnNVBw?=
 =?utf-8?B?eUtBQzRNNmdvQXdlSHZHNVVpRUJWcndVOVhsd0swVU9IanZtRlRCZEZlRzNo?=
 =?utf-8?B?TlZRUGhiUE54bHZUSU5MMWlRcTMyeS85ZVFKOEo0Y3YxamhFZ0cxVktoaDN4?=
 =?utf-8?B?Qm5tTERYQmVJQTAzU0RKdHVPSWg2dElZdXJwMnJ2dVRDbFNMbWxEbWJJcWx4?=
 =?utf-8?B?NTRscG1FY3FmeUJDT1BZVmIyay9QbFdZYzE2ZHZ4ZWQ2U1VoMFc1bXd2SFZz?=
 =?utf-8?B?SFlSOHljOXNjVjFIYVphTG1MMStPcXBYcHBsd3VFRFdPbk1ZVitmRUdrM2li?=
 =?utf-8?B?eDJPSjNKKzFxd2UydmJHV2JnN0RyT1FTZFArZG1aUG9iNjVZT21kUW1KZUZn?=
 =?utf-8?B?Mndzbyt1UXdrd1ZWZ05NTE1QUHJzNXh5RzgvTmRHaHZYam1MVEd1enpwekxh?=
 =?utf-8?B?SjdjK084bEtQQ0JreklnTGxralVwYy96aUY2ankwUk01dGM2cWVXWmZvV3Js?=
 =?utf-8?B?ZnNwZVFWNHhYWEI4dngwdFlGRW5iN1c1T2EzUjZuaGZianRxZXlRNDlxckFF?=
 =?utf-8?B?NHk0WEVxLzI2Qjg2VUVSdDVBTHJISEdRT05yZmxHYno2VmpZYVhYKzk5U29r?=
 =?utf-8?B?WjN6elZDYmpja2ZSK3F0REcvQnJlblZrSUtaNUpRVmN2Nzl0bzRRVHJyNDhn?=
 =?utf-8?B?TzZUYVhtdS9IYWVrbEdBdW1HdjFoQmxrT1pEZStlUVYzUWNJQ1ptbzBHeDA4?=
 =?utf-8?Q?4+5LNqLxadaleujTg86PusmL82D+jAK2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW1ML0Z5ZnQ4NzZiOHFKUzNmQlRPS2xrS3lyci9BREVueUlId2ttVGVIQlAw?=
 =?utf-8?B?dFhiVUY2K01DcDlQQnpFb0kvckVGSU5VNmovQm1sYllLaTJxcUxEQmJQRUJM?=
 =?utf-8?B?SGRTRklTZFQxc0swTXdpR1V3R0xGYWtxMTZRUnV6N05TbG4vOEJhbGxQbTNG?=
 =?utf-8?B?WVNydjJqb05Id2NkekowdjIzdWZNM056S3pNejl5dXR3Z3I2U3prdUJFK3hq?=
 =?utf-8?B?bnl3djRSTnR3T1NWc0xTdDhiYzF0RU9PVG5LdUtCNXF5QVRrU1AycVBQbHlx?=
 =?utf-8?B?L1lWRWZxb3g3Tmh4M1NIQmxBdXJiY3JSQ3lFU2VrUk5zZFFoWHIrUldWUTVp?=
 =?utf-8?B?Z0NacEpMaW5UVW9HUE1nbXJkOUt1TXk4T2JpUGRXc1F0eHFKVHpzUkMrUGtu?=
 =?utf-8?B?MndJWEZEem5ybDR2aDNWNHYrU2dFRk1qWW1LOHBpczg5dE0xSmZHa3NCQW01?=
 =?utf-8?B?Q1RrZGVEZ3dBK3I4ZVZuU2xwVnkwSHIzNERTK2IzVFpEYlpKbE5nVVRWcEc3?=
 =?utf-8?B?Mm9qYVpkKytGV2lJUUJ4ZThCcWROc1FKdmltUHEvM3lDd0puSGk0a01hN2VZ?=
 =?utf-8?B?N2d4Q3Jpb2NsQjVCMzZUdFpwRStrMCtQaHVTYmZLMWxqSitybENoMEY3aVp0?=
 =?utf-8?B?ZnpQYkx4ZDFEdUlTbkhEYkNhWUZ5WXZhbGdYaGdJRDVDYk5WbW02UHViTFpR?=
 =?utf-8?B?MFJuSWNHb2RldTBqTEd4WFgxbWFEazJHWmpBSFFKa2hEaVIxV1RZYk82aTJT?=
 =?utf-8?B?UTF1a0wzbTVHLzhia09GbDE4WGgrOWMybEtkZHZNeFBMYmRoY2VKN3VDTW1v?=
 =?utf-8?B?NVR1MWxuMllQRFdTQm9uZWhORXhCay9NdFJEQVNPRDZGbzlxdnUvQW5kbkF4?=
 =?utf-8?B?QWd0K3poMzhNY3JoUFVRZk1TSnF1M1RaT1Z5bnFTNkg3SlJjb0lSSmxwRHBQ?=
 =?utf-8?B?UUZhN2lxQ1BXOGh3SmVvWXB0V2hGVnpRYUIzRkhjM3h3YXZXV2hsV2lDaUdV?=
 =?utf-8?B?Q1FUb0RZTVphTXd2a3R5dm11cDMza3phMDV6eVZWRjZTRSt3UWdnYmxMakU5?=
 =?utf-8?B?VE9DeEFRaWdCN0FBWmNRQlBuTFlvWGVVaDJtZHIrM1QrWngvQ2gxSnFqdnFo?=
 =?utf-8?B?c1Y1cEhkMStvNDMwZk5BMzBNTVZObzlGMzhlQXg4SUxXT1RuRWN4Y0RKVW9q?=
 =?utf-8?B?Qy9sc1NoZGFtaXZ2a2ZzRFJ2S3p3YkM3dGQyOWZJYVhiMVNoMTBpNGQrdGFZ?=
 =?utf-8?B?N3Ixai9aWHUxTytldkhDeWQxQUVFVVRkWTdGaGZ0TmVvWDYzbmJvTFJ3TTdD?=
 =?utf-8?B?bG9aRlFpM1N4c0htYlJ6K0hRQzREeW1Sb3JldXVTNzBOOXNpZnZYNWNLUDkv?=
 =?utf-8?B?b1lReGllTWpvaWh3TEtFMytoaUJicUp3Q3pBRldXWnBzU3JNKzhVK3F0eDU2?=
 =?utf-8?B?VXI5OEs3ZWFqQ3pRaEhMSVZ0QVVVNzRIQUl0SXhhUDR3ZytJNlI2RFJnKzBX?=
 =?utf-8?B?R2ZhbWovUHJaK21aUllqdjZ6bGt0cXZFSzRtNWJIOHdYVitobDh3L3dGMXJv?=
 =?utf-8?B?UzdETUZrV0lOR2srOUNraXk5UTdnb0h1MWRLRWxnZ2pMLzJkZERPcHFOeVNo?=
 =?utf-8?B?S2lqSlBEdHUwNXpjdmZNek1HWVRWTzQ4UWNNNkpYR0xXZGxvc0xsSWZqdXhr?=
 =?utf-8?B?NC9qR1hUYVZORWxZeTRGUHcwenhXb1VuZEVxSTVFMnMrVDhJTC9SalU3TFVL?=
 =?utf-8?B?MitmSHBUWGxIdVllbEFGeUszb1ZKWllFVDRmU0M3UUdhVUxmU011aTFLWEQw?=
 =?utf-8?B?cUViYjdqV1JHUnA4aTVuR3FHMUl2MzVJZGxWK3JUd0FyWDRXelgwaENtZi8x?=
 =?utf-8?B?bm9lNmVwSktseGRTTVlDaUwzN2VGVUFWVzhqdkdFKzNqK2xrL3FOVTdtakg2?=
 =?utf-8?B?NDBHZE1KRSt0YkVCdVpKWFp5Q1BaQitHTml2NnVUVkUxL0FubkZJTkVNZW9q?=
 =?utf-8?B?d2ZGVDhlWFVYQXZlNXExNXlMZVRyckEyckVxbWFYZGxwYzFNWFhkQXBCU1JD?=
 =?utf-8?B?elhzL3plSHRpNXdTL3hEVUhYdXBTSFk0ZjMzMUM3aC9CM0xWR1RMakdXUVhq?=
 =?utf-8?Q?QEUYH6i7BP+x8Bgj9bom3mChb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a420478a-b020-4d39-2a76-08de1de951e0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:35:07.4007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5LQwT1qwcbfa2jN5oIwT/Oph6wkz+D8ABNY8k7ngozCI9aPEKzB/xxfJDa9m1pL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
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

On 11/7/25 11:21, Jesse.Zhang wrote:
> Fix a potential deadlock caused by inconsistent spinlock usage
> between interrupt and process contexts in the userq fence driver.
> 
> The issue occurs when amdgpu_userq_fence_driver_process() is called
> from both:
> - Interrupt context: gfx_v11_0_eop_irq() -> amdgpu_userq_fence_driver_process()
> - Process context: amdgpu_eviction_fence_suspend_worker() ->
>   amdgpu_userq_fence_driver_force_completion() -> amdgpu_userq_fence_driver_process()
> 
> In interrupt context, the spinlock was acquired without disabling
> interrupts, leaving it in {IN-HARDIRQ-W} state. When the same lock
> is acquired in process context, the kernel detects inconsistent
> locking since the process context acquisition would enable interrupts
> while holding a lock previously acquired in interrupt context.
> 
> Kernel log shows:
> [ 4039.310790] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> [ 4039.310804] kworker/7:2/409 [HC0[0]:SC0[0]:HE1:SE1] takes:
> [ 4039.310818] ffff9284e1bed000 (&fence_drv->fence_list_lock){?...}-{3:3},
> [ 4039.310993] {IN-HARDIRQ-W} state was registered at:
> [ 4039.311004]   lock_acquire+0xc6/0x300
> [ 4039.311018]   _raw_spin_lock+0x39/0x80
> [ 4039.311031]   amdgpu_userq_fence_driver_process.part.0+0x30/0x180 [amdgpu]
> [ 4039.311146]   amdgpu_userq_fence_driver_process+0x17/0x30 [amdgpu]
> [ 4039.311257]   gfx_v11_0_eop_irq+0x132/0x170 [amdgpu]
> 
> Fix by using spin_lock_irqsave()/spin_unlock_irqrestore() to properly
> manage interrupt state regardless of calling context.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 99ae1d19b751..eba9fb359047 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -151,15 +151,16 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>  {
>  	struct amdgpu_userq_fence *userq_fence, *tmp;
>  	struct dma_fence *fence;
> +	unsigned long flags;
>  	u64 rptr;
>  	int i;
>  
>  	if (!fence_drv)
>  		return;
>  
> +	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>  	rptr = amdgpu_userq_fence_read(fence_drv);
>  
> -	spin_lock(&fence_drv->fence_list_lock);
>  	list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link) {
>  		fence = &userq_fence->base;
>  
> @@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
>  		list_del(&userq_fence->link);
>  		dma_fence_put(fence);
>  	}
> -	spin_unlock(&fence_drv->fence_list_lock);
> +	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>  
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)

