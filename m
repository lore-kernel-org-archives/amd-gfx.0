Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76CFCC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 07:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B1C210E297;
	Fri,  7 Jun 2024 07:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vSR8nSSk";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E54610E297
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 07:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ccm6YFl4ucKXf2SeiY4E458vN56g10hIXy7u82Ck6n4rk+IVx1zUiPLWtZNgYO9IhjLLfYi0+dbJu4MOoqQIQvugqWNDAik1Hnri5PS1EUCyPiVDTy8cqS4dh+zeny2TUEA4ODh1mtq1wbtBfihu2WJy4sw9Mta0f42HX2zDkUDJ/9DPHyfxejnb3xdbilD0GNSocP4FcYOTLe+q5RY6o8/nnhRTUk6JvzcGpRuKCY3JgrUeftqROLzcXxNcfek2VNw+nZ42OujKlHV2UsLC6FNp+aEJl6O+m7IooiU+cwKpj0ySeUrrqqcI1Zg0sX7CdYypOpk/FsI5tJjCqutxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUxBa5sOwiIP4uqypahKZIpp0q/2sLGLlcx21vjNXJs=;
 b=VA3mfxjr3bZCsor/c/Cd/b5Hqz7XrfpEyR4ZelG+gPKZkAJkw9Nrf5iPbf7krfGl3EMfvtGNYhTquJGl3lBeZIG6+FtP2p3pC4qRRETlXiHY14zBj3USJJuaN1RM7YtLI4B2SDfeE4V6xBWyVuAH0APq7jQmBIV4MPWmS+SpcjhQaMozskWQIDwsI9XaZhbA7RMC+DWxhskDtR9JNaAbb66mu9lqkDIBzcN6pXwFHRPJbbx8iY+kApvXqbRb67nDJKuk0RKQqmiumF0xuoWLWW5ZE3in6K9UOqHk+T959lhLTZfQ19EWG/pxMhYaS72+7BHn7TKuJMrLaTobPQRG5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUxBa5sOwiIP4uqypahKZIpp0q/2sLGLlcx21vjNXJs=;
 b=vSR8nSSkn84xsV+XTumRg37ThlaiiUJznWNCDcZ/JA9Pr6pyShq8S3uAHvyKxpbiUAZoyCCwXloRPZfF1s0i/Te4tsegKUANQfoFyVyaerP83KO7jvHkCaubeSgxt0jHz0UXqbf5qxSrLJdaKmW0NSdo5eD2IUzaxpIlY9ONPb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN2PR12MB4096.namprd12.prod.outlook.com (2603:10b6:208:1dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:03:39 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 07:03:39 +0000
Message-ID: <5cb4eb83-ad63-4f8d-9aba-c0c9f132f4c1@amd.com>
Date: Fri, 7 Jun 2024 12:33:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
To: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
 <f189a0ed-2c3e-4e66-96fc-36f2e2ad3bc8@amd.com>
 <bbe45522-eada-481a-92dc-d1b53bc89911@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <bbe45522-eada-481a-92dc-d1b53bc89911@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN2PR12MB4096:EE_
X-MS-Office365-Filtering-Correlation-Id: a04ce238-7553-4ab4-2f3f-08dc86bff55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWxpckJrdDZXd3ZNOHlSTDRQUzVHcEZzY0pTMC9aMWlldHlPVnR4bGIvbXZs?=
 =?utf-8?B?RUUxenZlS0Noa2M0VEhINjkyNEI2ZkdveFZJV2lQTklLNFNuTWtwVVl6MjBE?=
 =?utf-8?B?aGc5b0NLZjF0aEtyeE0wRXZTOVQzMjEzaE9MeTBWWGN4Z0RrTTJGMnZza1I5?=
 =?utf-8?B?UVpsT3h6TlJXSll2cytOT1lsWVIyV1JWSzh0QlNiTnJ2dkJsVkhhdU5WSysz?=
 =?utf-8?B?R0hGTk82Smx3S2g4Wm9sNExmQ3k1WktXZys0dW5XdHpoR2FYZjc0L0FXNFBi?=
 =?utf-8?B?UVIvcUMwL1VjMFQrTENEMmlhV0Y1RFFKYnQwRDVITWZab24zNFQxR0FyNytC?=
 =?utf-8?B?bVVaNW92MkNILzBUUkdSUURKenZ4b0djMnZib3B3M25tUERHSmJtOWVQYVdi?=
 =?utf-8?B?UENESEdaemdHM2NtTXhkWUdGY1VLZnBJcjRYMGttVHUzMDVWb09ybEk3cFlK?=
 =?utf-8?B?QkdzTlRWWFU4UTBsTVJiTDFvLy9xOEk1Z3oxeWJlZVA5dGF3YWFJMmJNUWow?=
 =?utf-8?B?TjZPcVFudythT2xWTnk3K1BIbVU5ZThlY2IwNDZXNWh2RFM1YWM0eGRjc0xZ?=
 =?utf-8?B?S3RNcEFZTnp5RWZNQkIzRW1zbnJKMmpSYjNVcXhLclYrMmdyWWM3anorQ3cz?=
 =?utf-8?B?U0hlNHBGdDZiOGhyUHp4YXU2eWRYS29zcVd6eUxDTUo2WDlOMjVEeklkeHlD?=
 =?utf-8?B?alFVckpWcEY2K3o5ZlJ3cmFWdWpxQjNOYjhqN3J3TnpaVld1UFZJVzhLOHdX?=
 =?utf-8?B?bnRSbEVMUGRzNlFtMTRJbmhHdGNOYkpHSVp1d1ZwTndMTWRTSmxHb1AxejRs?=
 =?utf-8?B?cXVMNWRBWnp4WkMzVXFJdFlJSEFaTVZ2QnJvZ3FLWkg4RUpuTmE4Uk82emxX?=
 =?utf-8?B?dEYrK0ltUlVwbm1nUllZNXE3MnpMVHQ4dDE4Mmw1aHZmcFNma3ltcUUvSW8r?=
 =?utf-8?B?VDJTbmlyTi8rc0lVK21zNGJTS2JkUHlzNlpOWDZNNVppWG9wUWVVSytPUmtZ?=
 =?utf-8?B?M2tDREd4cW9BUVhIbEFFVnkvLy9LNWRydEtyZjF5RkJPMzN5QS9lTWhYZ2V5?=
 =?utf-8?B?cHNVV1JoSHkvOVgxRHVDc1pCbnRnMllUblVydEZHN3FzMWdjbDdqVXdJOGt0?=
 =?utf-8?B?ejMzdVNiTEovaVlMOE9xYSsxV2dNOVcwRGVGSERWNDJzZEp3MktvVVhwc3JY?=
 =?utf-8?B?M1BvMzFVSEVVTFpvRWMzRGY3a2RHRnBQSzM3REVLcXZvL2ZsTXFYRXdsUEQz?=
 =?utf-8?B?blVqblo4NUphZmVJdjd4VUxiZW5kdEpBUUMvcjROaFJ4VnROa1pzVWhlbVdL?=
 =?utf-8?B?WGdxZFRXaGd5NFRRT1VvbGRONG9QM3VOMXZLQmUvczV5aWNXQzI2dFd5cDRw?=
 =?utf-8?B?UW16YjBoNkhPNkVCZmFrcm05SEJRbHZ5V3hkTDMzT2QweEJETS82dWZWT05w?=
 =?utf-8?B?STY2ekcydHlqZ3FNN0xMdUNFdkdCVkM1S2ttRk8rY3hXTy9pS09MVGtUVkVD?=
 =?utf-8?B?OTB0L3lLZXR6R0VSU2UrbXZNL0VMa0oydmpRK2xibTZrZFNnV1VZVWhxZXU4?=
 =?utf-8?B?SVZIaU9RWXd3LzUvaGloTmxNOUUxWURsUHhvbkkxOGZ6cWVEQjNveVJxOW13?=
 =?utf-8?B?RzJSQ2pjdU9iZ2QyYUJCVFg3UVBUNENMalhXalcvdEt0d0FPZkp3NkxpelV3?=
 =?utf-8?B?VlF0QWlvWkhEdndPeGVQSlBSdWFjeHE5cW1BbUcyV2xiWjFUTTZLSDdYOGwx?=
 =?utf-8?Q?pqwZ2UywQZUKxgVXXVWAg+1Z1pWN8JPUKa/ZCPO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1RVUTJpTXZQdTZXZVZzRTRDdEMvMG90MGRaZnB6Q3lyRGJoSUhYYVVNOUhv?=
 =?utf-8?B?cHNwYkNTZzNXRlB5eWtseURpZVJBVHlhekJWWDFYc1VFUGYrMlBRN2UxVVU0?=
 =?utf-8?B?MjVPaTRkNEZNeE4vNHN6eWhwNGRac0xPdTBHczdEY04xcTdKemo2RXZoLzRs?=
 =?utf-8?B?OEc1OU1DZ1FMeG1VRFBPR0EyTnhFWVVHWHBsWnRHTVdNUElZMklhY0RyenRW?=
 =?utf-8?B?RjluN3Joejd1YWZhL3U5SjFTMlZ1ZDZvQ2tXYndUWVNCakV6TVV3eVErL3Fx?=
 =?utf-8?B?aTE3LzFuRzlQdmx5NVdxZTJoamw1YmpydTc1R09ZZlV4ZnlNamdyT09vR2Vh?=
 =?utf-8?B?YTJmdm12UXVWWFVDLzJEdm45SDBJeUoxeUlyL1lsamwwQVB0MmJ0UWZnU0Jy?=
 =?utf-8?B?Zkk3UEdJeGZYT1hNbVB4N3ZGRjE4bGppMWgzdStHNmRUdzJmRmdScHhLSnhQ?=
 =?utf-8?B?cXpEUGVxTkVYMUxxbEQyR2g0ZFAxVnN4d21ra0lwRlM5K1RqZ1dnWWpTbmJZ?=
 =?utf-8?B?SWxuMm9yTXlYVm8vamdQc1RRRVBaUnFKbUh6eHV0U08rSGRWMFhseDFBRFJu?=
 =?utf-8?B?TG9LM2FIY0V5cFF4Y1pNUkRaK0E4RDZhV2JwRkM1LzVZTnF3UXhVZXNoSUg3?=
 =?utf-8?B?ZE15ZXhVclcyUlhrWHZ2MlNnRW1uak4rZGl1T1hlWGg1SEk5aFB1K1NRd2VF?=
 =?utf-8?B?U2x6ay9RZFhndm0rcjFxUUpJZm9SVS9naEVodE9JS2lPMnUzRG5KVXJyUzN1?=
 =?utf-8?B?OTlTSXpFcDQ0OWswd3RTN1YxOVh4M1FIMlRWYW1qaWNiT3RsbTFSZFV5Ymcw?=
 =?utf-8?B?TVpXdzBwUElWT3NyVUVyazBGV3o4NjNRMFhmTWVxb2ZtL0c0NmkwMUlCZVRU?=
 =?utf-8?B?WHR0RWdoYTRZYzNuOGZLR0FpbUNGQjZ3UWlTbW9RbXB0N3RvVjFuREdmenZw?=
 =?utf-8?B?WkM1UXMxWlJ1eU1SamFWazdwOXNPaUV4M2FCMk1ncUM1S3MzaDRFbVJPaWY2?=
 =?utf-8?B?Mm5zWHhSSGVicm1vem1XMmtBOHJvSFJ3OTJ6MWN6RnVJZDA1ZEpuRitqbmVr?=
 =?utf-8?B?b3RJbjhZLzRtVUFaOU9XbDRNWElwczdFTytJYVAxMzhxY25KY3RSbFE0OVM5?=
 =?utf-8?B?dXFqKy9PMHgxK2w5Szhsd3ZMaEs2R1pHL28xUVJrb2IxeEVieUluL3lSTFdB?=
 =?utf-8?B?SFMvdXduTWJVUjJVdjZlM241UkVnVVJWeE1DM2pwUUYwL3U5cjdCZ3VMR3Jn?=
 =?utf-8?B?UWZzMW91bHkxVCtZaEJFV2xXZ0NpMzlyb0hrUWd5OS9MYXR2SjVXRXJ6VnVJ?=
 =?utf-8?B?R0xBbGhqdU5NNEVrMWZadlVWYjRKWGFyRVY4V3NseURIbWR4dkEyTzFCbmZ4?=
 =?utf-8?B?VnUwcDBqcFN1Qk5GZS9YZXBESzA5ODM0Mm1nVGE4Q09pbEU3TGE3bkwzL3Ex?=
 =?utf-8?B?WlRFb0h5a2xkT0tZYzcvMjJZSml1VldSVUhUbFdxSUEwWXZUa25pbk9ndFZX?=
 =?utf-8?B?WldHMnZybnRuMnJMblJWb2RzZmM1ci9KNVRYWHpWdHJvMCtIaVpzeDI1ejRk?=
 =?utf-8?B?ZXREcVRtd2tpbWpZSmNLR3RFanJESERlVTliUmFQdVBJMngzWC9FaklOUkt5?=
 =?utf-8?B?TnVzSG5vbFZlWHlpQTkxay96MkN5Z3Z5ai9sQ1BsTmsrQ1hyWkhMMHNCblJp?=
 =?utf-8?B?M2t5RTN2NCt4YVJodWwzbkh0MDRHRmRIRzV0aDl3VjZkSFNMeGJIbmphQkFO?=
 =?utf-8?B?ZlZ3eGJKWG9CbUJ4emYwWVdETG1WZjdmQ01zNEpnNUkycWlmdzNMTUhkTGVD?=
 =?utf-8?B?aVRXK3Z0c1owK2RPbjAwT3lXNitqUCtCNWdQZlQ2bzlHVHp4THRIb3dwMzRE?=
 =?utf-8?B?bU85dXV4dm5hQjVISmxwN0NDN3AxelJYL3RFNUxjVHVtT2VrZWVqN1ZMT0xU?=
 =?utf-8?B?S2ZTOVdrN1pKK0pyT2tOai8wK2RxVUU3cjl2bEd5eHpXMjB3K0piQ0N0elA3?=
 =?utf-8?B?VE05T2ptTlBUWHRRNmtVZ0RUc1dZc3hpM2dpcGlxSXIrNFpiczhtTGg2UE9U?=
 =?utf-8?B?Q3pjaTc4SzRZVlRTSStjeCtmL0ZQUWNYTy9CcTZCYmpRZnh6eEFiNmg5NElX?=
 =?utf-8?Q?C3oXgWxaSRt0lqaQ4rRHDbmhU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04ce238-7553-4ab4-2f3f-08dc86bff55b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:03:39.7691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoW+dM6u7tQtC3Z3FRZzK/RizCC4a8w3y+qRj41dJWJnr3L/dsFgNZob1ieo81W/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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



On 6/7/2024 12:31 PM, SRINIVASAN SHANMUGAM wrote:
> 
> On 6/6/2024 10:58 PM, Lazar, Lijo wrote:
>> On 6/6/2024 5:35 PM, Srinivasan Shanmugam wrote:
>>> Previously, this check was performed in the gfx_v9_4_3_sw_init function,
>>> and the amdgpu_gfx_sysfs_compute_init function was only called if the
>>> GPU was not a VF in SR-IOV mode. This is because the sysfs entries
>>> created by amdgpu_gfx_sysfs_compute_init are specific to compute
>>> partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
>>> mode.
>>>
>>> By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
>>> function responsible for deciding whether or not to create the compute
>>> partition sysfs entries.
>>>
>>> This change improves the code organization and maintainability. If in
>>> the future the  conditions for creating the compute partition sysfs
>>> entries change, we  would only need to update the
>>> amdgpu_gfx_sysfs_compute_init function.
>> This is not correct. If this has to be true, this will reside somewhere
>> in amdgpu_gfx and you would also need IP version inside this one. If for
>> a new IP version say gfx v9.4.5 this needs to be created for VF also,
> 
> In this case, how about below?
> 
> int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev, bool
> check_sriov)  
> {  
>     int r; 
>  
>     if (!check_sriov || !amdgpu_sriov_vf(adev)) { 
>         r = device_create_file(adev->dev,
> &dev_attr_current_compute_partition); 
>         if (r) 
>             return r; 
>  
>         r = device_create_file(adev->dev,
> &dev_attr_available_compute_partition); 
>         if (r) 
>             return r; 
>     } 
>  
>     return 0; 
> } 
> 
> In gfx_v9_4_3_sw_init you would call amdgpu_gfx_sysfs_compute_init(adev,
> true),
> 
> to perform the check, and in gfx_v9_4_5_sw_init you would call
> amdgpu_gfx_sysfs_compute_init(adev, false) to skip the check.
> 
> This way, we can control the behavior of the function without needing to
> put condition in IP code version.?
> 
> But would like have Christian's view also, onto this "a new IP version
> say gfx v9.4.5 this needs to be created for VF also,
> 

Drop the patch. As you see, the patch is just adding more complexity
with more variables rather than simplifying anything.

Thanks,
Lijo

> "
> 
>> then this check here won't work. This is the specific reason why we put
>> the conditions inside IP code.
>>
>> Thanks,
>> Lijo
>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Suggested-by: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
>>>  3 files changed, 22 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> index 19b1817b55d7..72477a5aedca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>> @@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>>>  static DEVICE_ATTR(available_compute_partition, 0444,
>>>  		   amdgpu_gfx_get_available_compute_partition, NULL);
>>>  
>>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
>>>  {
>>>  	int r;
>>>  
>>> -	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>>> -	if (r)
>>> -		return r;
>>> +	if (!amdgpu_sriov_vf(adev)) {
>>> +		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
>>> +		if (r)
>>> +			return r;
>>>  
>>> -	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>>> +		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
>>> +		if (r)
>>> +			return r;
>>> +	}
>>>  
>>> -	return r;
>>> +	return 0;
>>>  }
>>>  
>>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
>>>  {
>>> -	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>>> -	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>>> +	if (!amdgpu_sriov_vf(adev)) {
>>> +		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>>> +		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>>> +	}
>>>  }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> index 6b0416777c5b..b65c459b3aa9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>>> @@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
>>>  						struct amdgpu_iv_entry *entry);
>>>  
>>>  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
>>> -int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
>>> -void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
>>> +int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
>>> +void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
>>>  void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>>>  		void *ras_error_status,
>>>  		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> index aecc2bcea145..07ce614ef282 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>>> @@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
>>>  	if (r)
>>>  		return r;
>>>  
>>> +	r = amdgpu_gfx_sysfs_compute_init(adev);
>>> +	if (r)
>>> +		return r;
>>>  
>>> -	if (!amdgpu_sriov_vf(adev))
>>> -		r = amdgpu_gfx_sysfs_init(adev);
>>> -
>>> -	return r;
>>> +	return 0;
>>>  }
>>>  
>>>  static int gfx_v9_4_3_sw_fini(void *handle)
>>> @@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>>>  	gfx_v9_4_3_mec_fini(adev);
>>>  	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
>>>  	gfx_v9_4_3_free_microcode(adev);
>>> -	if (!amdgpu_sriov_vf(adev))
>>> -		amdgpu_gfx_sysfs_fini(adev);
>>> +	amdgpu_gfx_sysfs_compute_fini(adev);
>>>  
>>>  	return 0;
>>>  }
