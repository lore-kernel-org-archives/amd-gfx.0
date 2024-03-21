Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81895CD11C2
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 08:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E4910E22B;
	Thu, 21 Mar 2024 08:16:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QoNRlGk4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A29310E211
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 08:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFr0DobLzijVk0tPbkSDqTuE8VQvKOioyLFqllLIPdDrjfBhowJ4/i7H4ZsE9smQwN0a4dDoRjEhEGmhUi3EIt9PuYRXnKYngjz8wuGWtyYAcnwKYSWGYT8bnNLVqgI1ACCa3o5FRXtaPgRAFtUXTwwgmIDqPYBu9g2rDdB7tZ9nFHLXTJChnljjj6PrTX7TilP08jxJ4iQCNvFdRDDofCbUc9lA1ydT7ZgqkroRaMXM6/JjXH5IevW/xdfVnYMh0xhfB2w2NqBXosHtv64qLTqWzmpaObPIZnncnpFA1MTbLvRojn+l6BAPxYJC9QQKdv/bt1V/zwb7OSV6ZekoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqRzYsSlfnZnrpDIkbAC4cDXtawxqs5gNzGT8iJ04Yo=;
 b=PkmGoDMdiCD0Jt6p2wiU/DI9F4VA7347OuSkjcwAcji5+CdOaOaMr7ARr3ZRfxJOuLrLMRimRXdfZXoQqF2d7jaeVnLN3v86AKgXIXRAHNJB6SiLBnnvRUPgtk0o9/Hnb/YahjgaQyHELzmKfC3/1xUe8B8fxON4liy6uNHi2bSCagpdjxjrQ1zl32OOSTLL4ZZkcsdXaIUCPZxGqZMpxAjrfsNAvHL7zYuBGI6s86UlztmciLQ4ShWc8L0gpSBMX49x/tBLGzB10KTFkbP/MN9+yBKyINjFGjLZaAPx/989ngfuorThByJmtR5b6ddPiD+LRQgVmTdVK7iwmydcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqRzYsSlfnZnrpDIkbAC4cDXtawxqs5gNzGT8iJ04Yo=;
 b=QoNRlGk4gT4vfmjNOti5Njb+OvhOkJla85BsM2fNEZaCdOQCWHlN62PP4Ofuu/0ORz6oyrDPazYTF2vGnB/IQ9k3HmrPEIQAlvY5us6Ebc2Qgu6FELrC2Is+VC9QCA9zFCGq/OSLYCx/3wvqGCKXFMSDSU3QssT1QM1a1ToP/aQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB6795.namprd12.prod.outlook.com (2603:10b6:510:1c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:16:16 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 08:16:16 +0000
Message-ID: <91e5dfa1-f092-4931-9d21-424c5e5ebd78@amd.com>
Date: Thu, 21 Mar 2024 13:46:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix format character cut-off issues in
 amdgpu_vcn_early_init()
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240320084513.3026222-1-srinivasan.shanmugam@amd.com>
 <20240321045932.3444080-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240321045932.3444080-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH8PR12MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca621e4-60e7-4384-7c45-08dc497f2dc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdwcA6t0vC+/z+0YFYRCX0ZxMkbmB9+oxXbQquC9Pmp8hD6WI2i84qKTH75O9jjTSc/rsCS7se9A47Ckfjv5HvQeiFuo9chp0FCpx7uZnH6FDxWv49SXDVBOjTSdoFQ2m2cu7/CN3UoITsElBlVfZhJ+HJHQstf2QHlnQXKqZNQ7RC0ojJWX+kQRjVSIQDZiSAtemy/b1SbhortCKdTAYcwPDhZlxwVtModm3Aq+QpuDDkkrPGBq1ms/TJ8XAhWKdYweqNe06YKnJDv74d416fvoEK8IT0E+ygtg1eMOWZrcO+4Bp9jbsq31FHRU72E18d2rbbCQ8+9hN6Y47Jvhwe5Fnz00+xH0Cx6gDk4c+gx1DcvUv6V1WyKQqqM3ldiSaqjy3JEBImpTwLX63C/IOYvlZCj9MuUvbl/lP0fJbH0EGvkiez3DsMgZDW+IGRy4LKqlNp/hQXlVmWJlD0YwsHHVzUiL3DQq2/+VmjBrfEsAHCgyBQ0E5cHjaE168/vzFQ+gvW13SHNPwBXVVjrqTLpXW+SyP/UwikwPIT3dv9dLLmvVIsG7i5ZVFwHFhb0/Bgpo6zi8SEXCWZ+r68hZ2CGAAF+86caTgzL+YMzFomjc7qjg3R5LXbygNe91U4GVDwdmd2BRwASqP7D0ZCOfG7CkOTnDuG3YVL29RyutflQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXhmMGFzdzRCRmRMbFhMTUJ1VGpyZHhLeGNxMUt5dVhzQ2dQNG1CUHNnZnJS?=
 =?utf-8?B?dU9VRDhRQ3p0SEZ5WnBLTWVEQk53SHBtRnhOVUY4TU1hazFCWFhaR21HOGt0?=
 =?utf-8?B?eXlWa1pZelhCbldNMTN2RnZnNUYvQWtwYmVoajVua3JoeG4rTHhSbXA0MXYw?=
 =?utf-8?B?aVB4ci9DUFF5S243cTZ5YVVkQVlST1VFUmMyRzhjOHdMWEFvaUE1aEhIWS9G?=
 =?utf-8?B?TUZwRzB4SW1yelJldm92Sk5NWEx4OXFSbWNibllvcjZvaGpvdXBtUXF6TS94?=
 =?utf-8?B?azh2T0pmTy91cTRWdVNUd1FiR1BZOTExNTRHNTVYVXhPQ1BEUk1jSVd6cHJa?=
 =?utf-8?B?TUZwOVNQYjRxTmpGbXJqazdJYmhBUHdyWXpmcXg5dzEvblA2RktCMEVWTUxa?=
 =?utf-8?B?WWtjWFREb3k2ZVZIQTBiS0xkWWx6RXRlRkxXY1ZtYy96NHlFRVFzRkJtb0Rl?=
 =?utf-8?B?OUFzTmxNZDRGOCtjcUlrTHJRYVVybjROUjJOcUkrOW9VU1pZWVkyditzRFRF?=
 =?utf-8?B?c0xkb0tZNkxvRnZRZDhJWHQramV3TnZSQ05DM0pDRTJCeUZhZTRvTEdRck1F?=
 =?utf-8?B?ak05cXo0bFNVdWNNZlU2Wm5LcmJJelVOdkdVUExpM2FtMVh3MDJmcTRld0FR?=
 =?utf-8?B?cmJKQlY5NGVxbzU2S0tzbVFoUmlwOGNLRnZ1VEZOQnlGMmlkRG95Y0ZaUVRZ?=
 =?utf-8?B?V0RSR3IwT1JhUEMyUW8yeTRtRHhYdlpPejdLeWc0VUp4ejUrZ0F2aERmeHNX?=
 =?utf-8?B?V1BseFQ2Nm9KV0hoY05XK2s2WTkzOWhUa0RVTHhOeEcrQ3BQWnd0MjR6THpw?=
 =?utf-8?B?ZDQyWThPakR3RXc2VjNuRDJqd1dWZFZ4UythWjJzUlJqUVY0cmQ1ZEFTaDkz?=
 =?utf-8?B?K0JuV1pPa2xsYXhNbzVvQ3BXZzVMWUJhT3dRRnZmMEVsU21lTUNzZHVSaVZw?=
 =?utf-8?B?Qk94OG8xNGNZdm9ualJlVTNVTlRxTlFnWjQ1UkxNa2JFZFRpQmUzWnlPUjZW?=
 =?utf-8?B?bWgvLzJ4d1c4Sk1ManVBTUxFeTc1VEc0dUFZSUVUNVhVenNkVkdQN2FVUFhs?=
 =?utf-8?B?cDNUS3BQV2N6NjBIYUJYNUpSaSt5RW9SVTFobDJ0MGxjSHh0aWZlVlp2S2tu?=
 =?utf-8?B?TnJkaVI2S3pndmlKYlBxZDNsUFNKbzZrZGhqSkI3clMwT1R2NGxaL2dIYy9E?=
 =?utf-8?B?T1QzUmUvL2d3Zlp0c2lqOXJwcVZpRUwxbmlCYTZkWVgxemdSQ2xDT0dVN2xz?=
 =?utf-8?B?SFdJZTlITGJMSkxIOWF4YWlJd28vUGRURzlRSzdjb2llTWx1NWxhdmpML21Z?=
 =?utf-8?B?SlJQMkJES2NUY0NLZUt2OU9TQWQreC9BaXQycy95RDF5NTYwZkV2SXJsZW9i?=
 =?utf-8?B?U3RTQVRxenJzcVZwa2hTMytabUF6ckU2Sk93bmgyMzJnRENGOUpsZC9GYThM?=
 =?utf-8?B?OHdIMExEL0x2c3RYWWN4eVVBcndPdHZCenpoY0JTMk5hUVdjaEw3ckNPUHBO?=
 =?utf-8?B?VWhlVGd1RnZVSnVJazh4RjBFZmMwVENjYyttYU9WNlMwOTlOeUUwcDhIZ1Y0?=
 =?utf-8?B?NEE5QTdnVG52TzJQRGxjcXFIWjRydlY1T3NCalNCNUt2cDBEU3R6K0FEdTdm?=
 =?utf-8?B?dFJDZkFuNDROOXhYNEk1YWtERmNZbk9pRDYxbkw5UkpBU0wrTEpRdWVINDZN?=
 =?utf-8?B?bktXdUxaNVpTVFR2TlUzQXEyMVVCVHBSbThGZC9pV0ZWNVNoNlA0a2JSRitk?=
 =?utf-8?B?RGJvUE1PN3h4YThLczhhM3UrbGtVSE0rbnVNVmlWdElvaEF6SFBMbFJleUYr?=
 =?utf-8?B?cHdGMTNxZGk0Z0syTmhYMTJEb0ZiNDRHSUQrR3V1Njh6Y1h2cmhDRDJhVEZI?=
 =?utf-8?B?aG54S3MzSU15Zk9HOVZYTysvWkFZRmkxS3piZzJWdXFOdEt5SDVlZEhvNW14?=
 =?utf-8?B?dldEU3hHMjZoaHJReHlTSzRXY1Bqa0l1aGtHUWNzM3FBNU5NRTZSdkJuZlRj?=
 =?utf-8?B?QUxEaEdsL1FLSWU3SXJ5TzQ3V2l2b1Z1UDJuMmdFdDN0THNKY1pPckVJTzBy?=
 =?utf-8?B?L1BhUi9heHlYYTdYeHJtQnk4ZnFaY0hya0hBc3ZsYkJjdzk0MjBqYlJGSmh1?=
 =?utf-8?Q?/mWIplQagKMbFm9v7RyJTLl/B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca621e4-60e7-4384-7c45-08dc497f2dc9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:16:16.1263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66wy9kv97SUruTldNF1iHRknwvIfClP5I0OKorWFOdPLQjT2TB0uY1yTD8FUGrQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6795
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



On 3/21/2024 10:29 AM, Srinivasan Shanmugam wrote:
> Reducing the size of ucode_prefix to 25 in the amdgpu_vcn_early_init
> function. This would ensure that the total number of characters being
> written into fw_name does not exceed its size of 40.
> 
> Fixes the below with gcc W=1:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c: In function ‘amdgpu_vcn_early_init’:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:66: warning: ‘snprintf’ output may be truncated before the last format character [-Wformat-truncation=]
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                                                                  ^
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:102:17: note: ‘snprintf’ output between 12 and 41 bytes into a destination of size 40
>   102 |                 snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:73: warning: ‘.bin’ directive output may be truncated writing 4 bytes into a region of size between 2 and 31 [-Wformat-truncation=]
>   105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>       |                                                                         ^~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c:105:25: note: ‘snprintf’ output between 14 and 43 bytes into a destination of size 40
>   105 |                         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_%d.bin", ucode_prefix, i);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
> v2:
>    - Reduced ucode_prefix instead of changing fw_name (Lijo)
>    - updated commit message
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 9c514a606a2f..bb85772b1374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -93,7 +93,7 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work);
>  
>  int amdgpu_vcn_early_init(struct amdgpu_device *adev)
>  {
> -	char ucode_prefix[30];
> +	char ucode_prefix[25];
>  	char fw_name[40];
>  	int r, i;
>  
