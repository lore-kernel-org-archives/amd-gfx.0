Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C172C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 14:35:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6DD10E5CF;
	Fri, 16 Dec 2022 14:35:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B00010E133
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 14:35:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOYPeXWnY3L6hSdnUrr9a+7iETQq37gJ0CuuFAYNBfJ158u0Yh6DeHMTty0BmnM7ONbkknJg4ikwTUAWXPPlWWdjYEcO8L3pUnG8plq1K7ooG6/Bx/8ctifiyjgve8Px2T9WIOpXlhicFMhSVyidp8ENEewd6nETYaEgJIrfY8FFec1YpN54O1R52fBnrjoCYsrzjYPcy1EAK+WUGB13Eetp7GVVGvv/raryb3I0EW0rYGEPxp9iWBHqNPPLam8JSyzfetsNMqszza9No9Z5PanwKd4eCSHy7CzG1+737XJa1r+ZgoM340Uv18CrAHbQ8Ow7ff7dKir2GcZa45y8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jnvz+jOkm7sWrkUy1p4GQjJ/5dV7+R7MzyuPDGOL6HM=;
 b=DUyCYCuufabBpLNDIFCyKx3sF2vEQVMVXEYDqaDkUxW+sR7vS70SOd4j9ngoUIuPBaGU5ogifjFvxqb9QCr3VYll70iHEKPLhksAozjRVKEzz/z9fhZ+wJanvewvRHVr8jgd4n+QWb47D2QsMOIJ/c47Ix1WhMXyGIpBzuQ2OoooNbkugV9fwbMdNcWQRG6lSjds6kvirQ6BJ30x7naYwKe3oB49iDjkhJDsA80Mq1DZjGrWJgzS7/5qQvkqP1EZegt6HOiG41USkCMpJhqr9hKjIYhqiJHL4C3RYhes6K3msIemvnJq4HRA26xVRm56dAcPiXLNTcJvLwoDWT5Pxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jnvz+jOkm7sWrkUy1p4GQjJ/5dV7+R7MzyuPDGOL6HM=;
 b=neDXUyWtTua1BXQPVxqnHwdRrwfmSvgKANUshDxKI/abQaiLpXtnxtzE2fFrNDq3AgdRexI/SO6AIz+uCAjZAPIRD1TmoA340FkzwvkJXnK96yxp3wGJq1XC0QuMgbr5QSjNotyq2frwpIScW7N34bmeDbsOSYnR5udCTK0HxXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6743.namprd12.prod.outlook.com (2603:10b6:806:26d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 14:35:26 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 14:35:26 +0000
Message-ID: <5379267a-6035-85bd-23cc-d0c22893e6c1@amd.com>
Date: Fri, 16 Dec 2022 08:35:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 "Huang, Tim" <Tim.Huang@amd.com>
References: <20221215221059.509565-6-alexander.deucher@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221215221059.509565-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0062.namprd05.prod.outlook.com
 (2603:10b6:208:236::31) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: 36043bfb-75e7-4bee-6c7b-08dadf72c576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akRuzOqu3L14j7Tw/uAgIZdMGhrtSmkuAsn+RZPaYC5ZBKptyhGytSJY38mbUzxo5FJ491umy3JmStnus/twRyb2RxetEJ3BZqg1crxnovSM464Z7UKnqv4gizHPHEeUrwy2SvMy1AL4sm9M8ZhcmUzv8NXDHGLxvGEMxFpGU6CcXk6GxlTGz28jEMoyHBO/Dn/HfaVqHdCD14Y1fQnaUpbh/S7D6Yj4bS6XErF1+voaWIV8/lkHeDiC4qyX2xeZoK9FmYqJNPALCEKMoXzfwJCIDTEQjA5bMhizOunG2FYP8Il/e//ioM8v+ZO4ZjDMjhLpHquK83l5FG3Uk4kKxPLjF1y5mI1zvE4uCwhtOTBtF0CFu59e9l6FUHyls74CfIXY/DPakadP+2UdT2WPRQzfpIFgPVTAbN8RCD/dYehQ16y8xxE4DoMJ0mqQvo1+0bOrfJCuseNjVzOiifbV4MormuQk2VxEuSJigrMEdzzlEpIKoukXyhd2djKutJ88XEfttTwhiC2Cfl6bpOo/KUiV6tfCmbsqVQgcU6UlfaCR/r+nzc5KHKTHZTXPtMpyWPaqHnJiv8uYp7lT3XNCPGp0BC866jf317U1/d7AR2nrwe5zBdMQlLfgOwY2z52p2EUB1twUrIruqhOkY9G0XcD3/F5gsaU4X6Ffn4AWDt73j+y00Hi+BgvLsCog1AAuq6Z/np/q2yjESG6j+dgGfjKmreXQvSnXojP2sOyDMbYROGS5WPGt8CTRXAUbbkQVlZ1uoArCLogHEC+54fkzawJ/GWfEClQqmdTEdkEPDjk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(38100700002)(36756003)(31696002)(110136005)(86362001)(478600001)(6636002)(316002)(6486002)(2906002)(41300700001)(66946007)(4326008)(66556008)(8676002)(5660300002)(66476007)(8936002)(53546011)(6512007)(186003)(26005)(6506007)(15650500001)(2616005)(83380400001)(31686004)(32563001)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRWQUMrNi9jWFRKMERnUFFBMkh1c1doSldRME9BNHFDTlRRcG1GRWtJbVlG?=
 =?utf-8?B?NVlhd3M3N2V0MGNXTndFbFpOVzNKaXBmKzd3dlhOeVBmeVNUTVMrOWJpV0d3?=
 =?utf-8?B?M1BzNGFGZ1V1bDZubEpld2w5ZEJ4MXFrTythZC9ZYjZYWDVXblA4aS9DZ04r?=
 =?utf-8?B?eDNGNjF1R0RDUS90QjNNKzBubkNMMXluU0RPR3YzZFFkOFVpT0RQcExUNkZP?=
 =?utf-8?B?eWFsZjJGYUx4eXJyY2pPVGIrVDJSeHRraE1PVHRTbnU0ZXRaSFVHNVZJUkNr?=
 =?utf-8?B?V1VmN0gwNVowWUkzc0JJb29LWlpkdGlmcW1KaVJkWVo5QW5wU3VTdDh5cWI0?=
 =?utf-8?B?WVM2d2ZLekpma1ZFZmZDdTZ6d0dhZHIrV2lWOG1WL2hRbXVuMFVGTHVZVm1Q?=
 =?utf-8?B?dnlpRGNKR1hoakdXQ0ZiKytmYW9kcmtTa0MxMWZoTVdyUGNHbXdWdEt2ZDhW?=
 =?utf-8?B?UEU4MGJRQzhUb25RRWQ4VmRVN2hLUGpkRGpKdEtzYVpDMitKK2cxdGxZYWk0?=
 =?utf-8?B?NXBoejhJZkpMMU5hVVVqdUhlbFJtcFBUUW1RYzJ2bDJxUWlKOVVBZlpSMXhk?=
 =?utf-8?B?dno3NU5Pb01KQm5oWkpkSU5kSE1kWVJuK3hMMnVlOU0xMWZJWEJhYUUrZ1JF?=
 =?utf-8?B?Z2d1Vm5sSFRsdmNRQTQwcGp4eHNnSHNNZnQxRkVoSWo2bk01VkVTRnhGL0Nu?=
 =?utf-8?B?aTIxb1BlMjJmWTNJVHI1QmxnV3o5bENWV0t5RXYwN1FsQXRJZVBURkMwU3l2?=
 =?utf-8?B?SU9adWpOVzdzeVkwZjRhZndEUXlhRzVQeDFZV2tLYm1oeFE2YkdERGgzRHVT?=
 =?utf-8?B?MlN1QmpVK013ekVQZEVUZ1hIZnM1dm1uekJWNnMzRkhDdHBINWFoTG9DQW9B?=
 =?utf-8?B?TUc3T29TQmZMVmRHNVBQVm9iWGI1ck40TjBWRVJ5VlRXbE9xZFBvU09ycXlJ?=
 =?utf-8?B?MEgvZzlIclhqQjc4MjA3VjM3NXhEek9weHYxYW8wcU9zZFcrUnM1cHo0VVd1?=
 =?utf-8?B?Z1pyOE1ObHlWRzBuTm5FL3ZaK0JTK0ltYXNrMTh4Ulp5OS9wOEIxMjA3eE9u?=
 =?utf-8?B?aG9tWXVMQWlGQ3lZODVqV3FNM2d3U1R0T0krejZSQmNQUmRFNjNOdWNYaWtl?=
 =?utf-8?B?YzI1S2ZpT0VpWng5Tlp3K09jUHNOa1lnY3A0emI3bW5OV0J3REF1Wi9mUVd5?=
 =?utf-8?B?dVlrYlR1WWwvNUpNSHkvb0x5WkxQL0hPajR6a0VsUkxQejZIQk1YMDZlRTda?=
 =?utf-8?B?RUgremM4ZEExdkh2YW5sTHhGcFFreFlTVm93R09IZWdPNFNEOXZSYSt6UlNu?=
 =?utf-8?B?am54blVzRkVqblVuUmVEdmJXU2FESWwrY0RiQWQ2ZHlEY0ZaRmVwd1FJdjVa?=
 =?utf-8?B?aG92Zjh5UlhJaEE0K1duYUtVTUg2SG1ySEt6aUdPT0taRVlHeVN3Q01KSi9x?=
 =?utf-8?B?cURxd2dxa24xYjlHMzZaRnY3UCtDTW1FOE9PTVRuOXRWcEd6NUZ3d1VTLyta?=
 =?utf-8?B?SDRSUlY1NUtaK2dRT3BxWS9ueWlGVVNjYWhJZjFXNHlKTkFqUVFodEVlN3dr?=
 =?utf-8?B?Uy9YblMxNmdSNGtzYjhQRWNNK0E5ZWE3a2FSbEpNNEYwYVJqaks1MjN3R201?=
 =?utf-8?B?QjVaSm1FcDYvYWNUemx2NkZ0aWhIOWhBdnQ2YmFUZ1dLclVNZ3VhM0xJY2hD?=
 =?utf-8?B?SW5ZdGsxTzRvVUwvQy9wR1FidHhyakFpanU5WkFSbEZmS1l2QVF6SHJMbjVy?=
 =?utf-8?B?ZlhTWkRvWW1DK0dlNmUxSGVRc0JYWDZqaS9lNXAxTktWcG0xdGlGRGJuaXND?=
 =?utf-8?B?U2VmY3E2cWwxTUhycEFKN0tiSVhZSGNFVDNDQ25uWHRjRzVNOFErQTdGQ2Nx?=
 =?utf-8?B?KzU2ZzkvSXE0M0lsTGVHOEMzZytGcnJRSVpVa1hpMTN5WWVrMHRvc0RSM2tT?=
 =?utf-8?B?WDZoaDl6cUNOVTVwaXRxUFZNODQvRDhtR2s4blBwZTFiOFRRb3loVnBXT1ZU?=
 =?utf-8?B?MDRDM0tUTUwrbnZmb1FLYkxqSk9lOTZOZjJmL2hnR2h1ZUNOSTZsbGN2VjRl?=
 =?utf-8?B?eUx5dG93MnpJYVU5UmxuZW8rMmJKUXQ1L2d0YUs5OXRNRkRtWHBhekxOMStq?=
 =?utf-8?Q?dc3ikYE6KV2FX9OrMxPCZkm6I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36043bfb-75e7-4bee-6c7b-08dadf72c576
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 14:35:26.0984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Fa9boG+1MBIy79FSJr6TZEXjMP5zDHi21vyABYVvmf0Ms4GQOGnyyQEVi7N4ltjDQBksF1SZVfZC+0mIR+pow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6743
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
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+Tim

On 12/15/2022 16:10, Alex Deucher wrote:
> SDMA 5.x is part of the GFX block so it's controlled via
> GFXOFF.  Skip suspend as it should be handled the same
> as GFX.
> 
> v2: drop SDMA 4.x.  That requires special handling.
> 
> Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index a99b327d5f09..5c0719c03c37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>   		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
>   			continue;
>   
> +		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
> +		if (adev->in_s0ix &&
> +		    (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
> +		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
> +			continue;
> +

I think we want to also skip MES here too, right?  That might be a 
follow up patch though.

>   		/* XXX handle errors */
>   		r = adev->ip_blocks[i].version->funcs->suspend(adev);
>   		/* XXX handle errors */

