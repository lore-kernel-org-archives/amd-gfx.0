Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45E1D1CDC6
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 14:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D7D10E1DD;
	Tue,  9 Dec 2025 14:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Do/rgvs5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1492110E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 14:42:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnQjrN0iQy7/s3X2c0UmUCMUjFUWNpR1Mkyx2QMcjvt2N5l/jQJtttfSWLdVqX0wjVd4rxSPpWSJJ5MNqM5eFgH23NAkNa8ECgxxrcl4DJIb/d0S48ZdBtrDk7cAngxo77HRO/zwk+lNvdYi7IAMYiQY5Hk4S2mlH2Lq78eu901ahJMAy9VqTWCJlSDD9XQb4q3C0nbPhsTWu3e8dEHf2JsuCE5Kd2hgGccIgSbQ4kfmCUIKkidZjuqN+Coy5GeqgwT07Q2Vuc9qqEaQRDSagryh0qV8v15T0b6wU2cCNrVXvmrv7MCA4w6OY7J296waGOpzZxk2e+SqQvOMthb55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8lM+MHXsBPGmEyblvE5bSHjsVcAAuuVxCG7xpn9/X8=;
 b=oJYWVAx+XAQjM33L2WAx1dpb5BI/3SIN+sPQmb/PSLCG3v34YFovsxM8LrGwvNTcV3t5nBoniZK4VjbvWcnzSftQNd8s8FHM4aqqoQE0hMeRk364lh6y1WF5DEdDcGvOhWPflHdIp5hOqrM8QZJJBF9s2PjnpmAD1oqh0pV2neO4lCiUEqkhV/Tz7mnUSh4ffiNZWE9d92yQeBIlMtQQEkl5uc9ans9BBLkHF/7LStBieoAo/cWXZvehDsbLWgcxNZIMcR9ROGMDTUwcrswZjFeLqInSFNZMWgxUtAHBFd70qPh5O9DJ9fSMq5FpA/GkhWOjXPR6ZcaYvxEJrB+i4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8lM+MHXsBPGmEyblvE5bSHjsVcAAuuVxCG7xpn9/X8=;
 b=Do/rgvs5tbUetXnHk6YMjn/BdaMOukkZAlVRrZ6IEKN/NpLsaStoqiTN4ZG3KOzsnYLA9gOULJIh90n1xWqhe+mgSLWTk4FsjrJACIPq5VIwW7s1ZIVl1GBo7Nb0Tgbxk4LJTdOKixVfJQWaEQhsfzyX84pJrQneAWE2MU0Zsg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 14:42:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 14:42:40 +0000
Message-ID: <9497af41-7b32-4c23-93b6-30f8883568dd@amd.com>
Date: Tue, 9 Dec 2025 09:42:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] drm/amdkfd: Map VRAM MQD on GART
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
 <20251209012538.3882774-6-Philip.Yang@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251209012538.3882774-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::24) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f1f012-8142-4b58-b5fa-08de3731345f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1BVZVRTTEh3dU9aZ1A1UXhWNEttYkVWbmU4K0h5VU9zMmptYmVnaW40VUgw?=
 =?utf-8?B?bUQyK2puU3lBRkQ1SitNWGJYZHJjQkl0Z0JYWjE5Z0VucXFxdm45ck5xaHd3?=
 =?utf-8?B?WXBUSHBvSjZZZEpnNUlodDEyYnViT0JoUWZJV0Y5VE9jMzVLa1hvUEdzZW9P?=
 =?utf-8?B?N2srVStmMUdBczhoRmRlVDlHQW5aWGhaS3Z2c3pDVEd3K3FDNzJCdkdmMkph?=
 =?utf-8?B?TDh3OEhGMkZBNkpRd2U2a3ZCVnZxdnF0RzNDSExhYW9WaGVadTZpenhJSmx3?=
 =?utf-8?B?dzFSQ3ZUeUg3RjZ2b3E2WldIbVVrWFFTdngvZnNCYStFV21XVCtmZjRYMENE?=
 =?utf-8?B?b0xCbjB0cUt3M0huOEN4RGdwenE1NEtVTXZoRHg0bEhKeG5LcHhvYlpQek5E?=
 =?utf-8?B?L2VMTlZhQ0NNRTI3eGRYNXIrclRaTmdFZSthODNBRHhVTmVxNnFFNjlHYm9w?=
 =?utf-8?B?TDdZa2NRcmsxUUcrM000emNDc0hIM3dkakYzMHBFZHlqRCtZNWs2RUMyNGRC?=
 =?utf-8?B?T1VuMlZhNUVSRjNpc0grZUN6bGc5ZDJJUU9MTXhKOUw4b3BuZjQyRkpxTFMr?=
 =?utf-8?B?Nzl6MCtpOEcvK0hLS1MyaWZnMXJybFFSQ1lOR2dxZ3N3dElRSjZiZS9UNFpo?=
 =?utf-8?B?VEFHQUN6OEZwalF1S2QxT1JNaUxDVHM4LzhybnJhOFFEYzUzc2hGd1ZxUzVF?=
 =?utf-8?B?OS9mSEcwMm9xUC9MV1VpRU5hOGEyQWZ4U3FFWCs4eWxGdmFLS2hlaFhtTllv?=
 =?utf-8?B?QkoyY3gwdFNhOUQxYmkwWmcvMG5DUnJkZmtNZlNXbTM2UU1LSnVjUDhxNzBV?=
 =?utf-8?B?WDRKak5hN1paN3dIbkVoT0dieTdoZ01UbGR3VVN3b2xYa1RVVVJtL2dzT3NN?=
 =?utf-8?B?ZDFiQ2lGQ2NqRTV4ckJwMWdxT2lvbGZyRHlGeGdpaXdaYUIwekgzK2xvaFJV?=
 =?utf-8?B?K1JuS0VEeFRaMmdXNjhVRDJpaE5xVXlEak5RQWVvUzJWWUpLckZhbkE5R3VL?=
 =?utf-8?B?LzZVN2lzeGVwVTA3aERaR29vd3ZOU2FuYWVuOXpqdnpoVHdnQ1hXYVJPRXh6?=
 =?utf-8?B?K1M3bnVCcHpnL0VRYUJRamR6OHl0VTQwWWNMRGxjMVBrc1NsN0RSL0VhTUJY?=
 =?utf-8?B?aE15V0k4WkFEeXFuZVNkWUY4U2FIRms2TVBWZGZnWFJ3Ulg5OGtieHExc2tW?=
 =?utf-8?B?SWY2V1hGTGIrTU14ckRITFJLMjRkTjhDQ0pwcXFRU3JnWnd0MGxwdFJZMERn?=
 =?utf-8?B?a09zdm9CRnpRUDBIUzlUeXB3VzR1ZHZDVWx0dkV5d2NlK0V4OUo1Q0w5UHY4?=
 =?utf-8?B?N2swRXAzQXpWa3JId3lucnVrb3pRRkFZMlYxZGlmeUJaVFhKRzNJMVRzdlkw?=
 =?utf-8?B?SUVlWUVnRE1yckd6d0RycWxkOWdMelZYeUVhNWhJK0xZN3hqaEhDRm80cU4y?=
 =?utf-8?B?NHZKRElpdDUzMVJxaEhqa3BKbE5YU2I0RjFjK2pkSWR5Zmt6U3dhU2FTMk4z?=
 =?utf-8?B?WDdCekZrSzRkTllLNDJPWjFLNmhRYXB0aE9qbUxidDlkZVpNRVVrKzU1alc2?=
 =?utf-8?B?b3pYL0Iya2RSOVd2bEEydjVPVDljUXl1ZktlL2h6RzNhdU12d1NVdFRyQ0l2?=
 =?utf-8?B?OFkyWXh1M1l4ZnJDWjg3V0Q4d2E2T2VXRDNJWnJVOHYwanVNbkJmS3p0UHg1?=
 =?utf-8?B?Y0JNRFNpd3RsbTJndzRROXdNTGFQY2htQVkzYUZKa1R2Y1hQbXR6b0kyQ0dI?=
 =?utf-8?B?dDc2U3VETVNwdW9EeFYzTnJCUTdSN1liZjMzRkRPOWM2dkZ1OHJQeFdPb3NO?=
 =?utf-8?B?Yi90ZTJDbW1NUC9PblhpWDkvYm9jVmRCSU1WQTFwNGlxUlhSV0ovc1NqV0JB?=
 =?utf-8?B?RlArWm4xd2t4UFk3LzkrZFNEbjhqWEpjS3ZhcFM0a2lLb2Z5M0hRcTdLN0hV?=
 =?utf-8?Q?YDhSy9oqAYgbkry3ll+Zx9utnl0JyBQk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2J4VllpL1IvWURIT1dlUXZJZEs1R0dqTThMK3FIZW1uR0U2bE1ZTWRVMGpm?=
 =?utf-8?B?SFp0TnBaY1lwcWhDb092ditxNDAwMUNpaFdsekc4MlcwYUt2ZXFUeEtLOFU0?=
 =?utf-8?B?WVJ6aytPT2JDS1dJZ1dUZzVuQjAzajVCOVQ2SldlZnJtbE5mbk1haGMxRUZr?=
 =?utf-8?B?UHVNOVNHVHJuS2NGVEJYTXRoOVJGNEQxbVBaTFl3M1FiUDZsVGgxM0Y5VjR6?=
 =?utf-8?B?cVJybnNkWXVXNGpRVzNUQml2aDJGeVpCbTZHTkFoYVp5NUp5STRadDlPNmxr?=
 =?utf-8?B?TUs2Wml5Si9UVkF1RSs2R0w5Rzl6WGhHN3hINi8wNkpucmNDcHJKbCtwdm9R?=
 =?utf-8?B?cHI5R2N2OXRQUjRMMTFzQzZJbDUySHNUNy9BeHNWY05jTnJMdlFobElod2V6?=
 =?utf-8?B?Z2NoTUhDdGFnWVFYWWRSZW5qcmdHc28xRjFpVWFPV2NKRHBzRVRmdWtkUDl6?=
 =?utf-8?B?bStyU0grOG9lUUJJcEJDa2I1c2piNEFZM3lYNE1WaUJGZGMwa2pDaGFJYW9B?=
 =?utf-8?B?SmZPTzhnMjdGSzdpaXB3MzZ1eEVZYk4waExCMXlpaEo5Z2lCU0g4WVFLa3p0?=
 =?utf-8?B?ZmFRRTNJaUZITk01b1B0amxIQVdSeDNEbXRrYXo2TC82MHBaRkdFSnUveGR2?=
 =?utf-8?B?eWoyVE03ckxZK0M4N1NaeERRMkgxRHJKL0hsb29NRi9pSkthZ3ZhdTBHQ3RY?=
 =?utf-8?B?MCtheExieVFGZzF4ZDY2dXNSTmk3MTJJS3hMby9xdHpqTXhkck9KRjNFb1Bj?=
 =?utf-8?B?Tkh6eStuWW1nRXg1UE5wM1hDMllqSDdhV3IxU3l6N3pVdDFaNllMTVEzeEFu?=
 =?utf-8?B?bGJqZGRad1FId1JSem9UK0NGZkZCRlp2Z0xmaWsyRFZ1Vzg1NjNMWk0xQzU3?=
 =?utf-8?B?bHR6RW9qUllpTUp3UEFNQXA0SmlLR0c3ek5TRzRUK3NQdzJCNVFyVWNKQlhE?=
 =?utf-8?B?MXFOc1hRT0taWFUxRjdESHcyV2ZCTjJZdWc4bW5XSHRsK0dCbXR2aDJKWDR2?=
 =?utf-8?B?WndQMFdMS0J0eGhuR2NDUEFBdFIvYWc3Slo0ZWJOK1lkdDJheUFEWDB6T2xh?=
 =?utf-8?B?N3ZEVm9iWmIzODNtZGVCeFRsTVVBanpwdmxyTitWSGVzaWdIZk9VR2JwU0o0?=
 =?utf-8?B?S2VoWGJRdUFZaUF3QzlCdWY5QkJtNHJkQmowYVhBWVhQN3BnekRYQjRHUHcr?=
 =?utf-8?B?aWZ0SHMybWJ5Rmt3d1FtQUxncXJFZkVQaTJJTVM4ZGdFcklKUWxVZlRzQ3Nu?=
 =?utf-8?B?NS91Rmp4RmpuMjVWcGpFTXp1V3d4NE50YVBDTUhPK1VzT09KR04rQjhpRklW?=
 =?utf-8?B?UWJXakRGSitWQjJsVzZPWnY0RnBoTGtQMFcxbkpjK2dndFZYWU5TQW9vZHkv?=
 =?utf-8?B?QzNGamJML0p6aTB2VkRGTGU5ZlJSKzRrOXhaZmhTeHhEUjdNeFY4MXlGbTZJ?=
 =?utf-8?B?M3NMdGRGNDVQTEhucTdMMHc0REtyUG9OdytyRXlXUDRXWkpMcXFHVTRrQW9N?=
 =?utf-8?B?bkxMVFcvTTFmeWhubHl5dzBNK1dubDZ5TGZTbEpmVXBXRWR2T3F0SS93c01B?=
 =?utf-8?B?MTNOVktRK2F0N1dJVGowcHlWUXhzME44aVA4VjVEcFBqcWRWeGNJdy9MVSsy?=
 =?utf-8?B?MlV5QnhZTVhNbG5Qc1ZZRlR4MUMyZWdxNURQdGhubXUzaFVxa2ZiT0tweEtG?=
 =?utf-8?B?ZkozT05JTkkxOTY5MmFoRmdxZVVDeGlZcVBjOE1wbUNPOFBlV2hBQnY1NFRy?=
 =?utf-8?B?bTE5ZGxobGhzSHptbHNubHYvWTdYa2I3WnNhRE9IUThpeHVneENpV1hYTlg0?=
 =?utf-8?B?OE1ZSExCUU1DZ0NrQXhkZStadkQ2dUUrN0NmWUdNRXlDYU03aTNRZ2RLSmFD?=
 =?utf-8?B?S1l5V0ZkUnNNYkFhV2ZBMXBSUVNmNTd3YStmalNaVWs3TlV3RVB5YXJydVR1?=
 =?utf-8?B?YktHM1JDK29DSFp3WTJGS25EVCs1eVFFRk9SQXp1NERRU0dQUU5EUnNYeUdk?=
 =?utf-8?B?SjBZY0Njcm9jRSt6RVIyWDZZenhPOFBBUjdTZ1ZlNmIrZWlSaWR3cDZQTXZM?=
 =?utf-8?B?Y0g4d3AvR3ZZMFQ2aHMwY1VTTjlXOE5zSXNENzRBUU1BV1NaTnNyVE5Ca3R5?=
 =?utf-8?Q?YjOU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f1f012-8142-4b58-b5fa-08de3731345f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:42:40.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T0oLvyeWpEiKsxo12uToNz41FsHsU4Jj48/fEJQ5gAKCJPkWWQhQUNTwx7S5+ZTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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



On 2025-12-08 20:25, Philip Yang wrote:
> MQD BO on VRAM access via FB aperture is mtype UC uncaching, map
> to GART as mtype RW caching, to reduce queue switch latency.
>
> Add helper amdgpu_gtt_mgr_alloc/free_entries.
> Add helper amdgpu_ttm_gart_bind_gfx9_mqd_vram to bind VRAM pages
> to GART entries.
>
> Add GART mm_node to kfd mem obj to free the GART entries after
> MQD mem obj is freed.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   | 37 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 71 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 10 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  1 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  9 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
>   6 files changed, 129 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..c83e1cf1f02d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -321,3 +321,40 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>   }
> +
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color, u64 range_start,
> +				 u64 range_end, enum drm_mm_insert_mode mode)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +	int r;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> +					alignment, color, range_start,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
Here should use range_end, fixed locally.

Regards,
Philip
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node)
> +{
> +	struct ttm_resource_manager *man;
> +	struct amdgpu_gtt_mgr *mgr;
> +
> +	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> +	mgr = container_of(man, struct amdgpu_gtt_mgr, manager);
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 4f8bc7f35cdc..43009d3809b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -880,6 +880,42 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
>   	}
>   }
>   
> +static void amdgpu_ttm_gart_bind_gfx9_mqd_vram(struct amdgpu_device *adev,
> +				struct ttm_buffer_object *tbo,
> +				struct drm_mm_node *mm_node,
> +				uint64_t flags)
> +{
> +	uint64_t total_pages;
> +	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
> +	uint64_t page_idx, pages_per_xcc;
> +	uint64_t ctrl_flags = flags;
> +	int i;
> +
> +	total_pages = tbo->resource->size >> PAGE_SHIFT;
> +
> +	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
> +
> +	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
> +		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
> +
> +	pages_per_xcc = total_pages;
> +	do_div(pages_per_xcc, num_xcc);
> +
> +	for (i = 0, page_idx = 0; i < num_xcc; i++, page_idx += pages_per_xcc) {
> +		u64 pa = (tbo->resource->start + page_idx) << PAGE_SHIFT;
> +		u64 start_page = mm_node->start + page_idx;
> +
> +		pa += adev->vm_manager.vram_base_offset;
> +		amdgpu_gart_map_vram_range(adev, pa, start_page, 1,
> +					   flags, NULL);
> +
> +		amdgpu_gart_map_vram_range(adev, pa + PAGE_SIZE,
> +					   start_page + 1,
> +					   pages_per_xcc - 1,
> +					   ctrl_flags, NULL);
> +	}
> +}
> +
>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
>   				 struct ttm_buffer_object *tbo,
>   				 uint64_t flags)
> @@ -1017,6 +1053,41 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
>   	return 0;
>   }
>   
> +/*
> + * amdgpu_ttm_alloc_gart_vram_bo - Bind VRAM pages to GART mapping
> + *
> + * call amdgpu_ttm_alloc_gart_entries to alloc GART dynamically
> + */
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr)
> +{
> +	struct ttm_buffer_object *bo = &abo->tbo;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
> +	uint64_t flags;
> +	int r;
> +
> +	/* Only for valid VRAM bo resource */
> +	if (bo->resource->start == AMDGPU_BO_INVALID_OFFSET)
> +		return 0;
> +
> +	r = amdgpu_gtt_mgr_alloc_entries(adev, mm_node,
> +					 amdgpu_bo_ngpu_pages(abo),
> +					 0, 0, 0,
> +					 adev->gmc.gart_size >> PAGE_SHIFT,
> +					 0);
> +	if (r)
> +		return r;
> +
> +	/* compute PTE flags for this buffer object */
> +	flags = amdgpu_ttm_tt_pte_flags(adev, NULL, bo->resource);
> +	amdgpu_ttm_gart_bind_gfx9_mqd_vram(adev, bo, mm_node, flags);
> +	amdgpu_gart_invalidate_tlb(adev);
> +
> +	*gpu_addr = mm_node->start << PAGE_SHIFT;
> +	return 0;
> +}
> +
>   /*
>    * amdgpu_ttm_recover_gart - Rebind GTT pages
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..eff536f12cb4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -140,6 +140,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color, u64 range_start,
> +				 u64 range_end, enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_device *adev,
> +				 struct drm_mm_node *mm_node);
>   
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   
> @@ -185,6 +192,9 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>   		       u64 k_job_id);
>   
>   int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> +int amdgpu_ttm_alloc_gart_vram_bo(struct amdgpu_bo *abo,
> +				  struct drm_mm_node *mm_node,
> +				  u64 *gpu_addr);
>   void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> index f78b249e1a41..0bf9c35112fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -225,6 +225,7 @@ void kfd_free_mqd_cp(struct mqd_manager *mm, void *mqd,
>   	      struct kfd_mem_obj *mqd_mem_obj)
>   {
>   	if (mqd_mem_obj->mem) {
> +		amdgpu_gtt_mgr_free_entries(mm->dev->adev, &mqd_mem_obj->mm_node);
>   		amdgpu_amdkfd_free_kernel_mem(mm->dev->adev, &mqd_mem_obj->mem);
>   		kfree(mqd_mem_obj);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 14123e1a9716..5828220056bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -148,6 +148,15 @@ static struct kfd_mem_obj *allocate_mqd(struct kfd_node *node,
>   			kfree(mqd_mem_obj);
>   			return NULL;
>   		}
> +
> +		retval = amdgpu_ttm_alloc_gart_vram_bo(mqd_mem_obj->mem,
> +						       &mqd_mem_obj->mm_node,
> +						       &(mqd_mem_obj->gpu_addr));
> +		if (retval) {
> +			amdgpu_amdkfd_free_kernel_mem(node->adev, &(mqd_mem_obj->mem));
> +			kfree(mqd_mem_obj);
> +			return NULL;
> +		}
>   	} else {
>   		retval = kfd_gtt_sa_allocate(node, sizeof(struct v9_mqd),
>   				&mqd_mem_obj);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 29419b3249cf..fdde907836fb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -252,6 +252,7 @@ struct kfd_mem_obj {
>   	uint64_t gpu_addr;
>   	uint32_t *cpu_ptr;
>   	void *mem;
> +	struct drm_mm_node mm_node;
>   };
>   
>   struct kfd_vmid_info {

