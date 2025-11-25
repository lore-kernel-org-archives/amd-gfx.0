Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7A2D0E6F9
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A67C110E425;
	Tue, 25 Nov 2025 14:59:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yD3L2H/o";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA7D10E425
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McQBZxVZ6ZVH+NFV/VXqbdlJSNm1BToutHYNYUxgCfsuj1GIPDRjMpDztSkDHXxJhyQH0O+/sth06CnaofK+bYlU64E68d/azRVq0H7j/vDN/dGMsOEUYmoBbTFEyiOJEk+umuCVsvE6xgBJ13IrJDbn/uZbNL+H1ZkuVoYkdPUzkhOWhmmseJYtY6tbUlv/9XiCx9PuyqkYsOoAQ5vZ7BaI60QQDjabUMLz+u2RSrIaetZf2ztDLhXjKlGiMm6U/+THM82v3drmQCP6srAJQyWTi+MePYrW1wy9gn4VbdKvAn2FXO7nRVK0SIT+ewe4kWZzl3fQFFsNXkbszmp3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdmZNocvuXVLjxSqCv3tlI6FgD7PzEe4Nh6s8bv5YFc=;
 b=zASdqEJXukbRtfiX+ZbJXZtSsGoqUe1DPvTu6M6lGlW42kuUhXvUd+MX0R7Ci07xySmLsPjGeZK6q5OqcbsrmAY8il8I6IwIu+KUA7JsQfZXQPuijoXIg0RKj9n0Je7lUsQwni5/KcFjcdyfa/MiYFVF4h5N/YDqaLA7UitW+sRPJwrI9diuKkNPO27Wm+5hqsSP6hm7xC4wRqSw55xUFTt5sqgw+m5y7x+8UZfaY0MXGGBIG2N359SkOZmhM1TYyAQ/J2eAvzZyBo4SV6rhBWkNNSkh1gf4++AmEjqEZhRuDZj2Ef/hf5sbjmOe+Ghd14swp+Vv8IVqL2t5kPzMvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdmZNocvuXVLjxSqCv3tlI6FgD7PzEe4Nh6s8bv5YFc=;
 b=yD3L2H/o1hzG3H0Thwd6VUR5C3vuu61ll14jZ4IyGJ4SG2eSroy5t8z3c4tP3BYsd8kX8EPTf3nLlfalKAmPl4Gsmxy/FPh4Nh1WwIBP1+CFXcO35wLQS43aLiI7Ej92nPFiExQkQ3kyORiAq/xedD1ncCbN6qgGSa7XMhGDkEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB8538.namprd12.prod.outlook.com (2603:10b6:208:455::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:59:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9366.009; Tue, 25 Nov 2025
 14:59:18 +0000
Message-ID: <e4a9486b-6488-4e68-8e9f-f8e46f2dedfe@amd.com>
Date: Tue, 25 Nov 2025 15:59:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Treat MMIO_REMAP BOs as linear in
 amdgpu_bo_get_tiling_flags()
To: Alex Deucher <alexdeucher@gmail.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251125053634.219308-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OQzsXJDzVu0M_xqLWxs2BKma8uHtkgnBRYrS+Ry=Yquw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_OQzsXJDzVu0M_xqLWxs2BKma8uHtkgnBRYrS+Ry=Yquw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0770.namprd03.prod.outlook.com
 (2603:10b6:408:13a::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB8538:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f8101b-ccfb-49d6-77bb-08de2c3335a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGp0RXNuL2lVWlllYkFKK2h2ZGtXV0xGUHBMUGRGeHduMDR1QUFyZzgyS1ZS?=
 =?utf-8?B?MEM5SGlVRytsdHZ0dTJITzJ3T0FkYVJubmxjaWhzeTZjdGo5b0lKbW4xdjEr?=
 =?utf-8?B?UGF1VXlGVzhwK1AyRmFpL3BKdjB3YVJqMXQwYTBFemRGYTlqM0V5WCtjK3Nm?=
 =?utf-8?B?M0FQbFllTS9rRlA1azR0Yk9nZ2FnMzUrbGpwSXVpaS85b1BkdTBYSGh4V0NO?=
 =?utf-8?B?emxvUVNtQWxIWCtwVmtJVkhpSFdSeFM2S3hDWllReFZJTVptamRndmZncFhR?=
 =?utf-8?B?akFWSDYybjJoVUg2Qmo3YWRUZUg3RlgzcThrcFk2Y2o3VXhuYVdIVHNwZFFP?=
 =?utf-8?B?UkUxMkVVL1o2M2tHVTh5dkFOSHB4ZlRJTU5DbDZKckpCSWhnVGtUUzRaSE91?=
 =?utf-8?B?YlowbS9renNKNWg5c3BpTG5zSmRkLzZ6UVVqMkE3dkxGcHhGeVVsZ3V2MkYv?=
 =?utf-8?B?VlR0UDJUSDVQTXJ1Y1hKRnVkKy8yVUJjUnJ3N2FRejl2bSsvaGJYa2s5Njhp?=
 =?utf-8?B?VlFyUFRQTkJ6Q1J2T0JXUXd3YzhLczU2M0s5eWhhZkVVMERoeTBmY0Y3K0Zm?=
 =?utf-8?B?TDRwQkNFWW1GeWNFeHkyU0R5RjFYZjg2RXVVRWphemg1STNsWWp1Y3J6YkI5?=
 =?utf-8?B?eTVpK1NnMU5tZ1FXTE9EZ29UN3lqdDlsb09xODJBU2VMQlBCTUtiRERCVGRi?=
 =?utf-8?B?WkV5czM0NEppNXBVK1B1bGRGTU90djRZM29VeGc0K1B4MjMzOGdpOVUyUHZm?=
 =?utf-8?B?WHNobkNWTWN2OGUvVXBoSUhObEJlM25xd0lQNG9OSWFyYkZ5UG54cnhxelNC?=
 =?utf-8?B?bFpzeGt1U2RRR0VKTHJQTkpBYnFSQ05pekJYRllneGVSVkNkNVU0Nk1FSWVN?=
 =?utf-8?B?SmplZmNteUpBYnZhWVlyZnhPRDlOM25jWkczbVNzcjNIQTlRT1BzZ0RsWXVL?=
 =?utf-8?B?dyt5eU9JeDR0OFMvVkM1Z1dwZkJIU0U3akFINHBwbHhwM0gyZUllYnBwdk9N?=
 =?utf-8?B?VmpxWWdKODJGOTZjbmlSaUR4Ym0rZkNQVGJSOXV0UXVNNWUwN1E5eVVlbHlu?=
 =?utf-8?B?SkFOOXZIUEZtSDB0eTVzMk43Q3JDSnVaNFFGd2FpZGxUNGkxdElMcE5kYW1I?=
 =?utf-8?B?dVEzTG83ZkZwa2FpamhsbGMyQUdlWTZ6bDBlK0pKckZEcGFQcEx3OThBZmlB?=
 =?utf-8?B?M1N5am9JYVE4Q0ZZS21rR05janNJbFVrUVJxNlZaWHZNeWx1U0ZmRmpTQUd1?=
 =?utf-8?B?cVFTRjQ2NVdyeXlsNWlxbVVzaGVtRFd6RjRKbldRK29PQ2NIeWhYL29NTU94?=
 =?utf-8?B?eUxKeXdBWUpvRHRuQnNQazEvbGpyRU4vN0FtSE96R2Z4MHpWNy9vd1d2UExi?=
 =?utf-8?B?bDJDVVFqZHJEa0JWWlhJMURWRkZNZFFoM21BVSt5cUJ3YnpnNmpEelE5WWZT?=
 =?utf-8?B?YlhlZTk1SHZSRnRzV1NpQ3E1QS8rSnJMbEI3QnVUZlBDMjVKV1gzQUgwSzRu?=
 =?utf-8?B?K3dQMGg4aW03UGo3eCt2aGdlTVVWMWp1ZTBxb3VWNGx0VTlXcUVaNEp6emQ2?=
 =?utf-8?B?M0VuQlNMOEZNOUNKVjZEdGZ6RGprOW9yd213Qi9kbTZBTVY3N2czdGszaEdX?=
 =?utf-8?B?bmdueXRGT3JkRHBIVUIrVXlHWWxGQVhIVll0aXRPd3VxOFpULzVReVdLeGhl?=
 =?utf-8?B?b2hmVEprUjl3cUlIMi9rYU13aU5vR0sycnNSSk41UGZrVjJScytMWjMzKzZ1?=
 =?utf-8?B?V3JzdElLR1RSTlQ3ZVowbFMyUmU5dTBrd0xLek50MGNaOTFZTXYvTlgyay9t?=
 =?utf-8?B?WXVPUzlZRXR6LzliNzd4a3BBRDJWVkVQb1VjaWUxK1dUcmtZYWRLV2FrUGw1?=
 =?utf-8?B?ZjFtMDNoM1dBeDNEbTI0MU1GNkkvditGTDJuWkpBRUhBRUtDNzZQL05OU2E4?=
 =?utf-8?Q?SmvJ1NeoPcdZaNbW+ifNH4XPfghI5VlR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXYwT2JUZldyYU9XR0VpTEhNT00wWHB4VEJrM0dpMCsyaXU4WXJXbGhOU091?=
 =?utf-8?B?dlRkVU1Mbi8xUUxZbjEvcE5LQnNoZkhZWW5hZ1hsYVBTbDUxeTRScEJ1NjJ1?=
 =?utf-8?B?OXpuK005Rk5CTmVEQjdzRklyOEE4RTM5aDZRbVMxc216a2Q1Ukg1WC8wTVQ5?=
 =?utf-8?B?Y0lybmdpVkZGODk1TUgreWIxbTdxQUl3YnJlWG1Sc0ZaUEg4NnROL1ZFRkxr?=
 =?utf-8?B?VEhpcmJXNEUwQmtuTWxWNFRlektzU3diTng2VDJ2dWlEVmtjUjN2cFVOYXpF?=
 =?utf-8?B?enZ5U0tWbnNyYmJwdTU1YzM4b01xa3l0OXZza3kxOWFhQno4WlV2K1dWcFRW?=
 =?utf-8?B?SVFUNktEa2tBbStrWDN0WWFITXJwa21WamdrenlKMUkxZXF3Nnc2SzZPVmU2?=
 =?utf-8?B?YTdCZkpZQXlBeUpPNVZVanh3OGVudGhiNlpRYW90dGZqQy9XR09ZdmhvMFJl?=
 =?utf-8?B?N2djNzhSRENCNERXSFBZZFpOU1FWNDB5cy9RYm9iaExzSlVIcnNhcHZNTDMw?=
 =?utf-8?B?Ykx5cEZSb1d0T0ZIbkhtc3FlNDUyNHRhSUV2dC9zdU4wc0lkQ1V6VkNKTDQ1?=
 =?utf-8?B?WXpRK0xFaXZzS1Z2MVUybndUaUl4N3I2K1JzazZ0MnZWWm1uTW1mMGR5Qkx5?=
 =?utf-8?B?VXVZZUMwOEp1T1B4SkhHQzVzYUZ5VlNpT2xpR3c1OC9hWjZQVGpiOTdBWWlK?=
 =?utf-8?B?enl0cXpmSGppNjRWMHI1d2pUc3Z0Y3ZBYlBRMTgzNjlhSlU4WklJZnd0cDlS?=
 =?utf-8?B?QnNCaVRUOC8wMjdCTGdnc1hMMHBiVjZkMkxFcXozcHB3MkluVTJVaDhCQVMz?=
 =?utf-8?B?MGNWREF2WkNDUXFmSEJrVllST0J6WndhaDJrNk1sRnE4NE5ibWpKZE9vVm96?=
 =?utf-8?B?U0ExNXU0OUpzM0RtRXNsdEdFbFJnek5pRVdtV3l0UnczMG9lZlREVVAvMnY4?=
 =?utf-8?B?Rk9TWmxRYTlVM29pcjk2UVA0SE1JdytIQUZwcWhadHpjVlVueXdmS3pld2Vm?=
 =?utf-8?B?a21JN1h5U0VKUnZPZi91REoxYWJWNWxjT1o5eTF6TjNHMEpvSEthZEptaVp6?=
 =?utf-8?B?eU1EZ3NqVkFwNXVJL2U0OWR5bmthWmNGMzhIUUVSUURKY1h3bkk4Ni8xWHJ1?=
 =?utf-8?B?MmM4SHViYndla1NHYU53enlITFVGS0lvRElIbUtUQnE0K3JleTFJaEJwTmwr?=
 =?utf-8?B?clBDRFQ5N0M3SFM0aUgwVFp3T3V1Sk5pcTcyczNOdG1IRGxKTWhBNzB1czgw?=
 =?utf-8?B?MEM1OHlpbFloZSsrQnFlbGVHb0pqMnU2UkJSakR2YnpmRitwZXhYc3c1bCtQ?=
 =?utf-8?B?ZGlOK0NUbkRVREJENGlFdXdRWjRMODd4dWtLb3lVNGVmbGRsMUlkbmZmb3cw?=
 =?utf-8?B?dnZXSU5KWVQrbVY3V0JoQVp6TFIxNlZsamF3dkl0SktFdFBtdGVQUFUxWXFz?=
 =?utf-8?B?dXNzWW5OYklVYVFobjBWSHEwMkxMNU5pKzFVNmpVL2JPMEpCYlI5ZXJBU3cv?=
 =?utf-8?B?NHhpYjY4WDNGZ0hLbkxLZjNEYXRxQ2QzMitLOEV3R0N4OUtYL3hrbHhhOG9r?=
 =?utf-8?B?cTRUTjJhYmZYcnZ2NlZiUzlqenRnZStGSTlCQmVGamdiSmJjeEI5KzhXZGZF?=
 =?utf-8?B?RTRtWXFWT0I5Z2VMZnpXRURQMUhESmFSZ2w2aVFBYVI4OWNQMzBoVUdYTzQ5?=
 =?utf-8?B?Sm1uRlFnSms0MUNzNEVOK25yU0ZoaW9DT2N0cnlGeEh4eHhaY1ZqdDAyUGdJ?=
 =?utf-8?B?anZyQ01GMERSb3JuSE94TTE5VEtQdDBnM1RlRjBSZ2FEQW5hd0Y4S21yb1BF?=
 =?utf-8?B?L3E5U05xWHVGOWdsU1ZGaTZub1ZTQjNOeHUrSjZPVFlkT0lBUExOZnJ4Z3lt?=
 =?utf-8?B?NU1NZzZybzN0TTNYZ0RjR1dZOUo0NEtEN0JWbTBJQUpuKzlUQkZGblJMWmtI?=
 =?utf-8?B?NEcxTjVVVXpJVlJ3M1Zsa2d1UG5KbTVxK2pjdW5iNUhocHFDSXRMRHJGQys5?=
 =?utf-8?B?OUVwTHp2N3I3TU1tUkFQSHBSb2tHSUVGY3crdDN4U0FIK3VIL083Slp4UVVy?=
 =?utf-8?B?ZkpwZWVYVU1oZUFNdmhHM0dBd1l0SGZFeHlGS0xsZUE4NEhXckhxTWJmS1hO?=
 =?utf-8?Q?mLwccTNHMjnIhZ0eLls/J/SOj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f8101b-ccfb-49d6-77bb-08de2c3335a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:59:18.9130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbTMCPvrNWraNDWmnv/YS6CKiow1W5mZCxe5Wru6owXT0bp1ve71g1seNKKzSnGD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8538
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



On 11/25/25 15:43, Alex Deucher wrote:
> On Tue, Nov 25, 2025 at 12:36 AM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
>>
>> MMIO_REMAP BOs are created for HDP flush and device<->device MMIO
>> mapping. They are backed by a TTM resource with mem_type ==
>> AMDGPU_PL_MMIO_REMAP and are allocated as a plain struct amdgpu_bo, not
>> as struct amdgpu_bo_user.
>>
>> When such a BO is exported via dma-buf and then imported, userspace can
>> still issue DRM_IOCTL_AMDGPU_GEM_METADATA on it. That ioctl calls
>> amdgpu_bo_get_tiling_flags(), which unconditionally treats the BO as
>> amdgpu_bo_user and reads ubo->tiling_flags.
>>
>> On MMIO_REMAP BOs this causes a slab-out-of-bounds read. KASAN reports:
>>
>>   BUG: KASAN: slab-out-of-bounds in amdgpu_bo_get_tiling_flags+0xbc/0xd0 [amdgpu]
>>   Read of size 8 at addr ffff8881a19a9ab8 by task amd_bo/4574
>>
>>   The buggy address is located 0 bytes to the right of
>>   allocated 696-byte region [ffff8881a19a9800, ffff8881a19a9ab8)
>>   which belongs to the cache kmalloc-1k of size 1024
>>
>> Triggered by the amd_bo IGT test:
>>
>>   igt@amdgpu/amd_bo@mmio_remap_dmabuf_loopback
>>
>> gdb shows that the faulting access is the tiling_flags load:
>>
>>   (gdb) list *amdgpu_bo_get_tiling_flags+0xbc
>>   1150         BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>>   1151         dma_resv_assert_held(bo->tbo.base.resv);
>>   1152         ubo = to_amdgpu_bo_user(bo);
>>   1153
>>   1154         if (tiling_flags)
>>   1155                 *tiling_flags = ubo->tiling_flags;
>>
>>   (gdb) p sizeof(struct amdgpu_bo)
>>   $1 = 696
>>
>>   (gdb) ptype /o struct amdgpu_bo_user
>>   ...
>>   /*    696      |       8 */    u64 tiling_flags;
>>   /*    704      |       8 */    u64 metadata_flags;
>>   ...
>>
>> So a plain struct amdgpu_bo is exactly 696 (0x2b8) bytes, and in struct
>> amdgpu_bo_user the tiling_flags field lives at offset 696. The
>> MMIO_REMAP BO is only a plain struct amdgpu_bo from kmalloc-1k. It does
>> not include the larger amdgpu_bo_user layout. When this MMIO_REMAP BO is
>> treated as a struct amdgpu_bo_user, the driver tries to read the field
>> tiling_flags at offset 0x2b8. But the MMIO_REMAP BO is only a plain
>> struct amdgpu_bo, which is exactly 696 bytes (0x2b8) in size. So the
>> read happens just outside the real object, because the field does not
>> exist in this MMIO_REMAP BO. This is why KASAN reports a
>> ‘slab-out-of-bounds’ error
>>
>> Fix this by treating MMIO_REMAP BOs as linear in
>> amdgpu_bo_get_tiling_flags(): if bo->tbo.resource exists and mem_type ==
>> AMDGPU_PL_MMIO_REMAP, set *tiling_flags = 0 (no tiling) and return
>> early, without touching struct amdgpu_bo_user. MMIO_REMAP BOs never use
>> tiling or metadata, so this is the correct behaviour and avoids the
>> out-of-bounds access.
> 
> I think you should also fix amdgpu_bo_set_tiling_flags().

And not just assume it is linear, but rather return an error code.

Calling those functions for MMIO space just doesn't make any sense at all.

Christian.

> 
> Alex
> 
>>
>> Fixes: 9e903e5bc958 ("drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register window; add TTM sg helpers; wire dma-buf")
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> index 24ebba43a469..3c8c2b64af83 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>> @@ -1148,6 +1148,15 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
>>  {
>>         struct amdgpu_bo_user *ubo;
>>
>> +       /* Avoid slab-out-of-bounds for MMIO_REMAP BOs */
>> +       /* MMIO_REMAP is a fixed BAR I/O window, never tiled */
>> +       if (bo->tbo.resource &&
>> +           bo->tbo.resource->mem_type == AMDGPU_PL_MMIO_REMAP) {
>> +               if (tiling_flags)
>> +                       *tiling_flags = 0; /* linear layout */
>> +               return;
>> +       }
>> +
>>         BUG_ON(bo->tbo.type == ttm_bo_type_kernel);
>>         dma_resv_assert_held(bo->tbo.base.resv);
>>         ubo = to_amdgpu_bo_user(bo);
>> --
>> 2.34.1
>>

