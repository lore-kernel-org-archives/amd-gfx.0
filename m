Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FB5C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 14:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4CDB10EB2F;
	Thu,  9 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ejSqLJM";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FAF10EB2F
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 14:15:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wr6KQxfEeJKqF5Y49s8R7y4LvFb+jZb1hJNKwf3hMQL1VE15agYotGCxij+1SKEEuy/gLE9WSv/UcsV0BD7us5PqW2POh1izB6eWBYMxEI5uUiJvtl3HCAFjcdJrFTXzvNauI9cg4sQzfPxF2erSMc3dj+1GzKOPIPKZW9Wi9+1r80X7jajQRNfZpXu/FkJTWJR9LEpDkiUlXcscx+KwyFPjMNznzQ4UnxqTU2AHWb09KYaYAyAy8GyWmUL5lFpEHHfsNYU1wkUtoYVnj4yOiSahvOZ2fDzZ5ql0/hkNqFEEbewJoMjoyl7W2zGp1zvI231+k2xGxBVbffVmhwdx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP/I5lQqAoWQUnD2PpKa7XfuDLdufrTSi09/7s7TclY=;
 b=M7MylyD2GWMqa0Nh+pH0HeDRobphGpsUyT7Oo3hzmH/yVyKByeEf4mcwY/7h/0UYl9z7ufXZHTBMzmc5ZCXMsXQrhInnIL1NMyhVR8gePsrf6/adw8ooo+UpxBN1q38XnTm97WFJYUFJ/Dj6ykGgG6Y+gQ+pDzH2fqGfBLWQ1x1nr7y/YrNnYwYQYKy5JSYHtAmuPg80xIiXnXhBRFas0bLI6yGxfb49FLC1pvs9i4ECMTYYD1dq88CP7mIZNn13nrrd/m9ZmwktwcgZz+PZOGvV73sGOb7IQ9ketmVK7J+IgdomLctFjRmhug9el196DP/gnb82CyEkdVYWpEJpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP/I5lQqAoWQUnD2PpKa7XfuDLdufrTSi09/7s7TclY=;
 b=3ejSqLJMFiNFPImf1lNlCFFTmsr7D0w2ecdJnbHvyFVORV/gTgQ3duhvp0ndyNu3c8H80l3xlEivKIPleCVo6NT8RpCpIKGnWQk0pKiSSPixRMk6ukFMnDwOr3W7J363vFka71QV0KhZTAHf/GHCvBCnD+2sikNJ4XlLG5qZwIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 14:15:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 14:14:53 +0000
Message-ID: <394ed4eb-f0c0-44a1-9707-e6cea071147b@amd.com>
Date: Thu, 9 May 2024 09:14:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amd/amdgpu: Add ISP driver support
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, benjamin.chan@amd.com, king.li@amd.com,
 bin.du@amd.com
References: <20240508145058.254306-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240508145058.254306-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0109.namprd12.prod.outlook.com
 (2603:10b6:802:21::44) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: a8465433-5961-4398-b81e-08dc703265a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1ZKZ25pZDFBZ0Nyc3RtS296bTB3aGs3MUdaczVZN3dkdkp0dGp5UThoS3Ri?=
 =?utf-8?B?YlpiTzF5NnpXSUorQ1RxdXhCYkN3SitndVlvTjBlb0g2OWFtRFpZNlB6VkZM?=
 =?utf-8?B?SUNQVnNJb3BORjl1aTF2V0VsSlBXZmpDdmVRdGNRNkFsWlcyMVltVFdwSFFI?=
 =?utf-8?B?U1hLQlp3bnVldFZBRktGZlFCcUxBVFpYckNuQUVucnJsbmhlRXhnVmJJRkdB?=
 =?utf-8?B?RVZjYmZHZVhqdzNOTEcvRUpnQTFBTU9helAzYm1tZ1FFKzMxMGlJTHJZcjEr?=
 =?utf-8?B?Q2VaMFhKVlRBSUhCQXNWaUNwNk11d01SemhMZGJ1cGRTZk1Wc3Q3d2h6UlQy?=
 =?utf-8?B?TjJ5RTZ5S0ZkdEo5ZVMzSnh6L2NCdlExaVhRVmsvRk1WRWNuc2NyVHJveFJC?=
 =?utf-8?B?TDRYWjJQTXJONy8zZTFyVGtnSmVtQlNNZGcyL1Ruc1VsZGFIWlFRV1FUYXBv?=
 =?utf-8?B?VW9OcDlFU2d0ODBuOUZhaE1aaUViYzl1ckxjenRRc2pNQVcxbHlYSURpYzQz?=
 =?utf-8?B?R0FUdGpta1o2cTNvZVZpd0s1aUozUm55TS9PL3JtbDlseGc3TFRPT3YvQVhT?=
 =?utf-8?B?Y0tsQ3F6U0RwMWJQbVBCOS9pU0FDbVBBMG1oZUhTQ0FUQkt0NGg1RmJWVEd4?=
 =?utf-8?B?TlByZXlteE15NGVjOUFoVHBaN1JCR1h5bTdoSnN1dndheG9wS1FKQzVqYk9k?=
 =?utf-8?B?MVpGNWN1OFQrQVVYRWw1WGNJQ2t0OHBSK3VVOUlZcnVucGN6aG9DQWEzc2JB?=
 =?utf-8?B?enpQZC9ZZFVXSlp5akZRSS9TcUdmV3o1K1N6bVBLMGZNLzF4Y1ZtQ0xPWERK?=
 =?utf-8?B?UExFR1dyWkg2TDJqS09KeWhHVmtkM1VuZjJyd1Jaa0JaaU9aT21QSjNCN0Ux?=
 =?utf-8?B?ekVmaGk1TkFVbHBkY09KWG1ka1JXa08rYjhhZ2RDVGRMRTErQmYvS013dGQz?=
 =?utf-8?B?Q3NKeVA2VmVlby9KcW1yN0JHVHYzVEhBOHdZdGtqNDMwcDR3R2NueXdqTW0v?=
 =?utf-8?B?SEY3T3c4eTlKY3M4bkxTdU9jUUQwbnFwZ0hVZHlheEE4RVZ6OG50TGpRaUR5?=
 =?utf-8?B?T0dHTy9DZkVxeU1WRlhsd1Y4NkIyS1BYTHdBT0Y5MnE2amgzNHg4V210SEVJ?=
 =?utf-8?B?Q0h0dFZRbTVBVzZXbjFiQi9xRzNMN29ISUkxc1dkcFFmYXNQWEh5Q2FNUVhE?=
 =?utf-8?B?ZFVCbTh1RkFJOHlYSHdJODhPRW50Q3E4eElKWjNJMTZVb3lwRlllOEwyUEdq?=
 =?utf-8?B?bXZ3anhJTncrTDZaSE5tSVFBMitGK3Z6OFEvT1FpbUQ3STNxSk9ma3hNWHNX?=
 =?utf-8?B?bS94aVVSZFlWSEV0dzlXcUZkRkp2OUlmekRhSmdndnU3TW5Qa2JBaVFwZUhu?=
 =?utf-8?B?VXBicXV2Sit3bTFROVRkVURJaXd5WWZ5OTVWQVRvZlBsT3IySGNJWVB4Vk1D?=
 =?utf-8?B?NmczNSthdlR1alkwSmowOEo1UzlYUlkxbUJ6VlpualFJc3ZxNWdIRmJ4T2k3?=
 =?utf-8?B?TVIvbWYzT0hyL29FWDQ2cGRucTc1anFQNTVTOTF2SC9vWHBRQStJVTJPZTFM?=
 =?utf-8?B?QWJZcTV4WkNGL1FQWTgySDZVTlRXSTNyUXRLUytCb1o3QkVxNWNUWXFhUmQ0?=
 =?utf-8?B?QXZQbjFrc24rNDNSdCt3QmRDQ1pYakNlaFlGT1BrNVhPMVhvQjY1bFNJQjBB?=
 =?utf-8?B?NTZINm14VGFmYTlBeVppL3NLalRrQjJjMVNRQ2FWeFAwekN2ZXV0ZC9nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2M1ZVorcUJlQnN2UGFIVGJ6bndaQWlIalROMTRuOFJxb3lSOXFEenhXR3V2?=
 =?utf-8?B?cDk2V0g4MHEra2ovR3RQRXRlOFk1d0xiUldyWTRWU1NOZWVLNEJHMk9GdGtp?=
 =?utf-8?B?dU1uNHM4NFptMjBzMVNDZlFIajNBNVcyQm1TODNLTmRaYkVVYVhiNTB4R3hV?=
 =?utf-8?B?ekR3QjkzUkRnTDQyZnhrZkxvUmNaN0tMS1BINGxxSWlPSmNiKzh1a1BvWUV2?=
 =?utf-8?B?MER2amdqWTNLQ3Q4QXZpU3kxK1lqbWRCbDN2T2VHVzQyVDBsSDZLZ3BpR08z?=
 =?utf-8?B?MGphbDNUWGlTUmt6NW1pL0hISE96RzY0eHJlL2JhQ1Q0QXBIMjdCbHZuRHZG?=
 =?utf-8?B?QWsrcFc5cTVGdjIzbzFwZG9iZ3JJUTJ1cmlRTFVaQ3VtandzVU5sa3JoZE0v?=
 =?utf-8?B?V1o1dE1zREwvOXVFTGZRZ2l1WEkvMmNjVlV1U2lQT3NpemdSckRKYWZuUnZH?=
 =?utf-8?B?WGszNkxGUWFxR3lFZmJrK2x5RHgxQ2FWWU0zak9KWWtoSkt0U2RNTGRGWWNV?=
 =?utf-8?B?NkRabTVDd3J1c2ZHakVFNStCMERuNTluUDVQVlQ4cGlvN1pmT2drMVRhelpu?=
 =?utf-8?B?OEg3Skc2ZHFqd0RwWmFKMU1xU0NOTUR0RnAydFVteDhhM2tXQnpOTXRCTnBB?=
 =?utf-8?B?dlVJemQrN0R1YW43NUNQY1E1dGpUUFh6VkwyVFBkNFlVNUYxd0Q3YlB2Z0Jh?=
 =?utf-8?B?cVQyc0p4a0lmK3AwbmdYYkdDd0RiSWxkYVZOQjZSVHRQWGMycWc2REppWk5h?=
 =?utf-8?B?aVlwZlo0QjgwcVQ0Y01pMDlINnU5OG96WDU4UE1iRGdXNDNTc0p0Z29xZjJD?=
 =?utf-8?B?d3VXK2VHdW1hNmE3L2FjT0ZrSGQ3RDl5M1hBb3NkTWJNczA4bVdJakYreUl5?=
 =?utf-8?B?c3JjcU80TjJzaFdCUVA3UlZkTXhZUkczUGFDc0xxdEZKNU5URHhPQit3V2Nt?=
 =?utf-8?B?UDMra21tOTgzdXNOdWI0cVdsaWZtNjF4eTdNMDlLK1ZXaHMzcThadk80bEQz?=
 =?utf-8?B?QmtPTkJyWXRaTVRKN0pGVjVBVkVFUzlxVjFwb05PV1FHc0tBMzZaS2RSNGFp?=
 =?utf-8?B?elZJek81ZE1rOEdySlluVGVDOFBlYzdiZ1cxeEZwOEpPdVJHRU4rRkZITWpW?=
 =?utf-8?B?eHE4aHpaQ0V1YUFxWkdLVHMxTVAxdTd3clBPc1VnbGp2NFZyWE5WNEF2ZjRB?=
 =?utf-8?B?NDJ5dUpMcWN6N1VWQ1NGa0VtS0hmN1hXRWZZUFVQK09ZNWk1ZEdmeTF6bVcy?=
 =?utf-8?B?Z1VYbkxLWk4vN2N0NlljN0pVYWxoYTdxTTdUREZHQXFQUzViQ21Za0w5SUJW?=
 =?utf-8?B?eXZXdmQxL0FPZXNHWDREUzZ3NjBaMGZYVm5iYnN6aVVuZklablI4T2hyUHZO?=
 =?utf-8?B?UjdTMzU5Z21iV3JuOEhJejJaZzlCdEtaNnU5UVNFa1U4dTNYV2FLYnU1c2JV?=
 =?utf-8?B?bDdGVG1raE9XSTBIeUhaMExlTkx6bGpLTDFPVms5MERsekRaWXU0RkVyTEYw?=
 =?utf-8?B?Nk8weUhZRVZENXQ4MzU3UXp3RjNYRUFyRlkrRTRhYVlNQmV1ZXZlUUJTdkdB?=
 =?utf-8?B?d3BYSDl3QjlHSG9ld2gwSitYcGM0T215a3VUeElsUDRkMER1ZGNVRHZjbXZ1?=
 =?utf-8?B?K0JEa3MyeDFxNXZOcXNLUFBEQmcrWkRoblFweU93SE02Um1pamdrbE1ySGVZ?=
 =?utf-8?B?dFlwVUlja21tdnlTTk12L3M2TGdaYW5EMXJuMVJzMXBCek1xZ3hTOEVEWkVO?=
 =?utf-8?B?S21xMHY5RmdmblF0b3YzVFdJNzZCRnNQT2Q1UWtVT0RlemFHalFNcWNEYVJF?=
 =?utf-8?B?ZndYdDNxbVgxQ2FiN1FoeUlIdVJONGEzNDQxM21WandIWUtvempFZFIrRnVr?=
 =?utf-8?B?NWpQdGw2WUhnaTZsTW81VXdCM24yNHNXZGpIemVzL05kWUtKZGhObXlFZ3o1?=
 =?utf-8?B?RFlnYjhjb2JIWlhxKzF4NnZTUE40cENtUGk0b0xKOFVycERXY0YwTXFRb2RB?=
 =?utf-8?B?bS9zZWJranBJUGdwT1Z3NEdMYllIcTFLZ0Ywam5iMGJ6d09xMEZkNVlsc2FD?=
 =?utf-8?B?Q2U3ajg3eVQxL2FNdis1RE5GMDZaTlZ6a1dqV1pwMFNNZVlzUXo1WGFjQzhT?=
 =?utf-8?Q?aPbDkZcomZcJqlyQtKm3bNl8D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8465433-5961-4398-b81e-08dc703265a8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 14:14:53.8624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OANZzRJEat//I8MQsD90MNb3jCXssXQl6VN3dLB9zDok6VYehyR41EcTsvM6Kb9UPZunc4ENEdP2z4HXabYhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
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

On 5/8/2024 09:50, Pratap Nirujogi wrote:
> Add the isp driver in amdgpu to support ISP device on the APUs that
> supports ISP IP block. ISP hw block is used for camera front-end, pre
> and post processing operations.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile       |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h       |   4 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c   | 298 ++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h   |  54 ++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   5 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |   1 +
>   7 files changed, 368 insertions(+)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index de7b76327f5b..12ba76025cb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -324,4 +324,7 @@ amdgpu-y += $(AMD_DISPLAY_FILES)
>   
>   endif
>   
> +# add isp block
> +amdgpu-y += amdgpu_isp.o
> +
>   obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index eb60d28a3a13..6d7f9ef53269 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -112,6 +112,7 @@
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_seq64.h"
>   #include "amdgpu_reg_state.h"
> +#include "amdgpu_isp.h"
>   
>   #define MAX_GPU_INSTANCE		64
>   
> @@ -1045,6 +1046,9 @@ struct amdgpu_device {
>   	/* display related functionality */
>   	struct amdgpu_display_manager dm;
>   
> +	/* isp */
> +	struct amdgpu_isp		isp;
> +
>   	/* mes */
>   	bool                            enable_mes;
>   	bool                            enable_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> new file mode 100644
> index 000000000000..dcc01a339a43
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> @@ -0,0 +1,298 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include <linux/irqdomain.h>
> +#include <linux/pm_domain.h>
> +#include <linux/platform_device.h>
> +#include <sound/designware_i2s.h>
> +#include <sound/pcm.h>
> +#include <linux/acpi.h>
> +#include <linux/firmware.h>
> +
> +#include "amdgpu_smu.h"
> +#include "atom.h"
> +#include "amdgpu_isp.h"
> +#include "smu_internal.h"
> +#include "smu_v11_5_ppsmc.h"
> +#include "smu_v11_5_pmfw.h"
> +
> +#define mmDAGB0_WRCLI5_V4_1	0x6811C
> +#define mmDAGB0_WRCLI9_V4_1	0x6812C
> +#define mmDAGB0_WRCLI10_V4_1	0x68130
> +#define mmDAGB0_WRCLI14_V4_1	0x68140
> +#define mmDAGB0_WRCLI19_V4_1	0x68154
> +#define mmDAGB0_WRCLI20_V4_1	0x68158
> +
> +static int isp_sw_init(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	pr_info("%s called adev %p\n", __func__, adev);

This and other pr_info() statements are too noisy.  I guess they were 
bringup code that should be torn out now.

> +
> +	adev->isp.parent = adev->dev;
> +
> +	adev->isp.cgs_device = amdgpu_cgs_create_device(adev);
> +	if (!adev->isp.cgs_device)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int isp_sw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	pr_info("%s called adev %p\n", __func__, adev);
> +
> +	if (adev->isp.cgs_device)
> +		amdgpu_cgs_destroy_device(adev->isp.cgs_device);
> +
> +	return 0;
> +}
> +
> +/**
> + * isp_hw_init - start and test isp block
> + *
> + * @adev: amdgpu_device pointer

Wrong argument for the function.

> + *
> + */
> +static int isp_hw_init(void *handle)
> +{
> +	int r;
> +	u64 isp_base;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	const struct amdgpu_ip_block *ip_block =
> +		amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_ISP);
> +
> +	if (!ip_block)
> +		return -EINVAL;
> +
> +	if (adev->rmmio_size == 0 || adev->rmmio_size < 0x5289)
> +		return -EINVAL;
> +
> +	isp_base = adev->rmmio_base;
> +
> +	adev->isp.isp_cell = kcalloc(1, sizeof(struct mfd_cell), GFP_KERNEL);
> +	if (!adev->isp.isp_cell) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd cell alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_res = kcalloc(2, sizeof(struct resource), GFP_KERNEL);
> +	if (!adev->isp.isp_res) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp mfd res alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	adev->isp.isp_pdata = kzalloc(sizeof(*adev->isp.isp_pdata), GFP_KERNEL);
> +	if (!adev->isp.isp_pdata) {
> +		r = -ENOMEM;
> +		DRM_ERROR("%s: isp platform data alloc failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	// initialize isp platform data
> +	adev->isp.isp_pdata->adev = (void *)adev;
> +	adev->isp.isp_pdata->asic_type = adev->asic_type;
> +	adev->isp.isp_pdata->base_rmmio_size = adev->rmmio_size;
> +
> +	adev->isp.isp_res[0].name = "isp41_reg";

Although first being introduced for ISP 4.1, this file is "generic" not 
for isp 4.1.  I think the names should also be generic.

IE "isp_reg" and "isp_irq".

If there's a strong need for having the right version in the name, the 
string should be built dynamically.

> +	adev->isp.isp_res[0].flags = IORESOURCE_MEM;
> +	adev->isp.isp_res[0].start = isp_base;
> +	adev->isp.isp_res[0].end = isp_base + ISP_REGS_OFFSET_END;
> +
> +	adev->isp.isp_res[1].name = "isp41_irq";
> +	adev->isp.isp_res[1].flags = IORESOURCE_IRQ;
> +	adev->isp.isp_res[1].start = amdgpu_irq_create_mapping(adev, 162);
> +	adev->isp.isp_res[1].end = adev->isp.isp_res[1].start;
> +
> +	adev->isp.isp_cell[0].name = "amd_isp41_capture";
> +	adev->isp.isp_cell[0].num_resources = 2;
> +	adev->isp.isp_cell[0].resources = &adev->isp.isp_res[0];
> +	adev->isp.isp_cell[0].platform_data = adev->isp.isp_pdata;
> +	adev->isp.isp_cell[0].pdata_size = sizeof(struct isp_platform_data);
> +
> +	r = mfd_add_hotplug_devices(adev->isp.parent, adev->isp.isp_cell, 1);
> +	if (r) {
> +		DRM_ERROR("%s: add mfd hotplug device failed\n", __func__);
> +		goto failure;
> +	}
> +
> +	// Temporary WA added to disable MMHUB TLSi until the GART initialization
> +	// is ready to support MMHUB TLSi and SAW for ISP HW to access GART memory
> +	// using the TLSi path
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI5_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI9_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI10_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI14_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI19_V4_1 >> 2, 0xFE5FEAA8);
> +	cgs_write_register(adev->isp.cgs_device, mmDAGB0_WRCLI20_V4_1 >> 2, 0xFE5FEAA8);
> +
> +	return 0;
> +
> +failure:
> +
> +	kfree(adev->isp.isp_pdata);
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +
> +	return r;
> +}
> +
> +/**
> + * isp_hw_fini - stop the hardware block
> + *
> + * @adev: amdgpu_device pointer

This is the wrong argument for the function.

> + *
> + */
> +static int isp_hw_fini(void *handle)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	// remove isp mfd device
> +	mfd_remove_devices(adev->isp.parent);
> +
> +	kfree(adev->isp.isp_res);
> +	kfree(adev->isp.isp_cell);
> +	kfree(adev->isp.isp_pdata);
> +
> +	return 0;
> +}
> +
> +static int isp_suspend(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_resume(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_load_fw_by_psp(struct amdgpu_device *adev)
> +{
> +	const struct common_firmware_header *hdr;
> +	char ucode_prefix[30];
> +	char fw_name[40];
> +	int r = 0;
> +
> +	// get isp fw binary name and path
> +	amdgpu_ucode_ip_version_decode(adev, ISP_HWIP, ucode_prefix,
> +				       sizeof(ucode_prefix));
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> +
> +	// read isp fw
> +	r = amdgpu_ucode_request(adev, &adev->isp.fw, fw_name);
> +	if (r) {
> +		DRM_ERROR("%s: failed to read isp fw %s\n", __func__, fw_name);
> +		amdgpu_ucode_release(&adev->isp.fw);
> +		return r;
> +	}
> +
> +	hdr = (const struct common_firmware_header *)adev->isp.fw->data;
> +
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].ucode_id =
> +		AMDGPU_UCODE_ID_ISP;
> +	adev->firmware.ucode[AMDGPU_UCODE_ID_ISP].fw = adev->isp.fw;
> +
> +	adev->firmware.fw_size +=
> +		ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
> +
> +	DRM_INFO("isp fw <%s> load success, (base_addr, size)=(%p,%d)\n", fw_name,
> +		 adev->isp.fw->data, (int)adev->isp.fw->size);

Considering there is currently both an ERR and a WARN if it fails, this 
is probably too noisy and should be down to debug.

> +
> +	return r;
> +}
> +
> +static int isp_early_init(void *handle)
> +{
> +	int ret = 0;

Since you don't actually display the error code at all, is this variable 
really needed?  I would say either show the error in the DRM_WARN 
statement or drop the variable.

But also think about how many messages happen in the failure path.  I 
think you should aim for exactly 1 WARN if it's missing.


> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +	ret = isp_load_fw_by_psp(adev);
> +	if (ret) {
> +		DRM_WARN("%s: isp fw load failed\n", __func__); > +		ret = 0;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool isp_is_idle(void *handle)
> +{
> +	return true;
> +}
> +
> +static int isp_wait_for_idle(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_soft_reset(void *handle)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_clockgating_state(void *handle,
> +				     enum amd_clockgating_state state)
> +{
> +	return 0;
> +}
> +
> +static int isp_set_powergating_state(void *handle,
> +				     enum amd_powergating_state state)
> +{
> +	return 0;
> +}
> +
> +static const struct amd_ip_funcs isp_ip_funcs = {
> +	.name = "isp_ip",
> +	.early_init = isp_early_init,
> +	.late_init = NULL,
> +	.sw_init = isp_sw_init,
> +	.sw_fini = isp_sw_fini,
> +	.hw_init = isp_hw_init,
> +	.hw_fini = isp_hw_fini,
> +	.suspend = isp_suspend,
> +	.resume = isp_resume,
> +	.is_idle = isp_is_idle,
> +	.wait_for_idle = isp_wait_for_idle,
> +	.soft_reset = isp_soft_reset,
> +	.set_clockgating_state = isp_set_clockgating_state,
> +	.set_powergating_state = isp_set_powergating_state,
> +};
> +
> +const struct amdgpu_ip_block_version isp_ip_block = {
> +	.type = AMD_IP_BLOCK_TYPE_ISP,
> +	.major = 4,
> +	.minor = 1,
> +	.rev = 0,
> +	.funcs = &isp_ip_funcs,
> +};
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> new file mode 100644
> index 000000000000..2adcb4b4dc6e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#ifndef __AMDGPU_ISP_H__
> +#define __AMDGPU_ISP_H__
> +
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/core.h>
> +
> +#define ISP_REGS_OFFSET_END 0x629A4
> +
> +struct isp_platform_data {
> +	void *adev;
> +	u32 asic_type;
> +	resource_size_t base_rmmio_size;
> +};
> +
> +struct amdgpu_isp {
> +	struct device *parent;
> +	struct cgs_device *cgs_device;
> +	struct mfd_cell *isp_cell;
> +	struct resource *isp_res;
> +	struct isp_platform_data *isp_pdata;
> +	unsigned int harvest_config;
> +	const struct firmware	*fw;
> +};
> +
> +extern const struct amdgpu_ip_block_version isp_ip_block;
> +
> +#endif /* __AMDGPU_ISP_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 37820dd03cab..b4bd943a7cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2539,6 +2539,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
>   	case AMDGPU_UCODE_ID_JPEG_RAM:
>   		*type = GFX_FW_TYPE_JPEG_RAM;
>   		break;
> +	case AMDGPU_UCODE_ID_ISP:
> +		*type = GFX_FW_TYPE_ISP;
> +		break;
>   	case AMDGPU_UCODE_ID_MAXIMUM:
>   	default:
>   		return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 75ece8a2f96b..a9de78bb96e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -712,6 +712,8 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
>   		return "RS64_MEC_P2_STACK";
>   	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
>   		return "RS64_MEC_P3_STACK";
> +	case AMDGPU_UCODE_ID_ISP:
> +		return "ISP";
>   	default:
>   		return "UNKNOWN UCODE";
>   	}
> @@ -1411,6 +1413,9 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
>   	case VPE_HWIP:
>   		ip_name = "vpe";
>   		break;
> +	case ISP_HWIP:
> +		ip_name = "isp";
> +		break;
>   	default:
>   		BUG();
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index a3c04f711099..db745ab7b0c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -523,6 +523,7 @@ enum AMDGPU_UCODE_ID {
>   	AMDGPU_UCODE_ID_UMSCH_MM_CMD_BUFFER,
>   	AMDGPU_UCODE_ID_P2S_TABLE,
>   	AMDGPU_UCODE_ID_JPEG_RAM,
> +	AMDGPU_UCODE_ID_ISP,
>   	AMDGPU_UCODE_ID_MAXIMUM,
>   };
>   

