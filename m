Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE4C77B73
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 17:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CE310E300;
	Mon,  5 Jun 2023 17:21:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E8010E300
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 17:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFhDRUwqJEb/RHxtwR5RQiC3Vq1emrIHoa4ekgq18xAV5ej9LhHfm4DpDw08OYhVjsYZsVr2HYh9HyQyECjYgMVi3TFOzSKClmA9sH6kZKK5IfPi3e4bzfCz9hUBcI4OQOZZUB2g8ylpsw79iizcqJpW8oxe/a5GZ76gz51LKSUbN4NC+lrVM96cKJvUvrIagnD8euGtMrs3fFZbh+KyvQBGGUjyVEbhkX650diocdN7r+ld0Ogzin1bNYpbM9ETgOPfQnmfTED5ZDzXgSpN88grLtMMcr1PjjmjaBZssxuEp7aV55KqYFGpnBbiT40mf5A4+cBTNyNxNfpm+fGDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNZj0s1Ft+u3li39X9+Cc8yOzqnZN/XPK1yIaxjubWo=;
 b=HG9wVgP/aeZ2eGNo99EmdH5jSnLTPCxLzdfWM4PemXCV1mGIO6fNFDzOFaqmtmLCiiKYHqYpOesWUtyBzUzPFpDZk4rvqkqO9zbkwrFw+sZ6qXDWnytxNnE0jzWUjoVU8fHsLUB5I3bzejKFAHjwL1fXUZBVFzIJpkjK+E0McqV8KZ3NdWv35MMJWmS9WQqTAKAVFn/qIrHSJrnaVS0TvhOCC3PyqnVFTazKK224SPPBJavNRBRPs/R9EJqWQqleEgqu2hRaIbXLHMnunNQaOR/h6Kl6ap5bwZiYsxiN/1XjCnLjzDzbLOzUoKeJ3JH/6HUuu7VjVbsAg3KeNX7Pfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNZj0s1Ft+u3li39X9+Cc8yOzqnZN/XPK1yIaxjubWo=;
 b=GNTkn50SRnc5uL94kX0tzsKLl3DIwV7TQDoCx7jOhWG3ixGOsRIEZS4K7wb1yJ0G4RHWzuVbowjb3sBijTc9I2f9Ag+vw6gWFG0W6KItT+RSYEGeTnDQn5ZnGxxvU+xDCRy3uMlsDZTQftaAhXH055IiKiE/oq7OOD0f1BMJoWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Mon, 5 Jun
 2023 17:21:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::43b2:55d7:9958:390e%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 17:21:35 +0000
Message-ID: <4d565f16-a67b-64d0-27ab-199b655cf84a@amd.com>
Date: Mon, 5 Jun 2023 12:21:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: drm/amd: Drop messages in init for radeon, amdgpu
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230605142823.62123-1-alexander.deucher@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230605142823.62123-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0055.namprd13.prod.outlook.com
 (2603:10b6:806:22::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 6796881d-a695-48c8-b751-08db65e95087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XklZwcP9DDC9yE+zpAd8zUagnoNPvL3UaJ7zEsAhL9MJfpWawI9Ir3AxMi0g5lUPVS3G4rVz0oF0VHBM9uS7jYvROjZKMLxi/3IivFSbzhgrmk6Uk0Zr8trs6bAKFmIVT/ScdlS6yXdhHPE3TRAffGHr0qf6+5v08KTuSFboiXNvIPgpajBNCMOrg7IbAMrvZjOL3PefwFxs67TZNMGmjGN7ItTdsjgYk/QxDzzncyMRvpZ1ucLk6gXhjfsf8sqy9++S1LrHOKCM/wzxN5gCxFexBbHBe2LTNjdH1WfDTB05EKKOIpfXZghL3GRydMUPZjr5Z+a3Se9wjR7atx+R8FFgXhcD00h4PfYnqM2A8kFWE6q7MAyx40mpJABVcFX3ucRS1S8+HUzArD1++0pFSmJVdp15TJ9jU9QItGOG40po6oHCzAaS48XBvEPwT3JFNTCjwVD1fjVhsWr8fpRGWaS38WozXTC8EkU5K1BVdosxWXXZZn5+bPc5rTh1Oh4v3sxXNclSO9p9lPZdJJZqmUgFgpxJbwhnGgZovHlaSNDj9orORwq+n5xWAmPZwNscY9v6z5QSySn91st/Ds2qk++/gO74PDPxq5XN6UIU0CY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(53546011)(8936002)(8676002)(41300700001)(6512007)(66476007)(66556008)(316002)(478600001)(38100700002)(6506007)(26005)(5660300002)(66946007)(31686004)(186003)(83380400001)(36756003)(15650500001)(2906002)(6486002)(966005)(2616005)(31696002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDNIMUR6ZGloS3BqdmdjU1ZIcGUxR3ZKMko0Q21tb2hET2pKL3RwZG5lUGpJ?=
 =?utf-8?B?dm0rRVgzVjkvaThxMWhOdkI2dmg3aHhZZVVidWVua01oeC9WMjVnUjZRNnhH?=
 =?utf-8?B?aVlIUk1hV0p6RUVFMGgxY1FTNGZrcjR4eWFHVzV1SHc0WGZXZzVXUEoybW5i?=
 =?utf-8?B?OGhZdDAzbXRwOXJ0M3cvWWtvOTEzd01wVEFmaVZvTUQ2Z3dpaVEzV1lLSFd0?=
 =?utf-8?B?MC9lN29UR3RPNWtEdURjT3U1ZXA0QmIxamNvWjBkaWZIdFNWWE0wRTNPb2x2?=
 =?utf-8?B?MGZUcnZOeXNQZE5jZXEwNnlaQm5kVjF1ZFBVZTJNcERiMTVnYmUwWStFTzZn?=
 =?utf-8?B?VGY5MG1Ycno0QXBRNUlEWWg3cGhkc3NvNFhQbEFyMzd0eVZ0YUowYmk5L1pq?=
 =?utf-8?B?Nmp6TU0wVU9kMDFORnpTcm16dXNkMStTNUljYVRrYjQzUElxV1cyMzZqTVVY?=
 =?utf-8?B?Ym02bGNTTnZSZkJGdWF4VnU1T1hwVVVmZERpKy9LTkFXTGk2ZUo2RnJCTUxv?=
 =?utf-8?B?YmZKSG8xaTM4cXQzZVJCTENpK0dOTDU1WjdUN0RtcEgwUllmdVhRY0dyYXRN?=
 =?utf-8?B?ZVk5b1g4Z09aZ05lUzNEbWMzOXFtOHZaSC9yK0E3VEMvNEQ2V0dNYlFoaTRY?=
 =?utf-8?B?d1VmZFkvVEMvdXNwRjQzdloxRzh1L2xnRW1ZdWJmWkpsM2N0WXpPUEg3T1Jl?=
 =?utf-8?B?bUkyeEtEaTdFOWVwVXNpMEFCblRpM3ZNMTF5WXlDdkpNWW5DdjFJYVB1bzdt?=
 =?utf-8?B?TkZnbTIwcS8zNCtaWXBoKzREL2xtTTVlNmY3RnhKMEdCTXpvWmQwY3U4ekYz?=
 =?utf-8?B?SmFHM2R2WW9ZV1ZoZytQMDdXTVB0L1Y5K2JSeE9hU1Vhd09wNFFSbGRYbTFK?=
 =?utf-8?B?VVIzb2JCZGJjMU40aENlV1NGWnozdjh3RVg3YmJRYkI2N3dGOUxKK2hwL0Ji?=
 =?utf-8?B?anViLzllYXg0YjNPSXNmb1IvSGNhNEhHS2VtMUw4S1hycU5QT2ptUDY5QUtJ?=
 =?utf-8?B?ZjZTWDF3T3ZkNUZzajR5Q2hOcUZhcGt0ZktiK1RCZDVpSy81WDNuekxGV2hz?=
 =?utf-8?B?N0Z5UXA0V2txZTVTY1VvRUQzM2xOUUE1a3FYYnJ6TmhlSkgwdXQyVTdMUjhq?=
 =?utf-8?B?ejVwTWJRSFVlL2c3ZXp5VnoxZHg1T04ra29BdC9SNFVsUFd0UlNJT1E5WTN5?=
 =?utf-8?B?SFFOdWVDR1oxVURSdGsvVEdyVjdwL3d3SXpMazdjMTQ1Y3FxaHZyc0hiOWJa?=
 =?utf-8?B?NzZVRWVrOFl3bUdpdXo1a1dJMXcreVo0SjRsQkNFTVVNUmNqZ21kMWlhS1R3?=
 =?utf-8?B?S3FTTHhveUVIbkVqS3NGVjFjVzYwRmJKcVI5SkozMHkzVGNhaTV6Tk1RaUd6?=
 =?utf-8?B?YytSbzRiY3B3UEJ4TWJhSmtkRUlyMzR2UzhKUXhBZFJKWXZBaFptdmlaWnVL?=
 =?utf-8?B?aDM5MWpCZUppeUVSVXdLZFVCOEc2U25JOUFJZnFzTHVBZUIvSHNlSHRQdGFH?=
 =?utf-8?B?MWNTYnV3bjBrekFXZDB0Z204OWNKSUhiakJYUndzbi9jU2lmeDgxUmtmYkNs?=
 =?utf-8?B?Qjh1eWNFckFpdDROTDR1MGF1N2xGSHdudDBGcjVhMUk5UXlLSWpKTHZJd3Bo?=
 =?utf-8?B?dEtXenBGNWFCb1VPNWt6bmxHRWcrRkhPcmNwRkFYL3VXUmgxa3lHdms2QnBw?=
 =?utf-8?B?dDlDR1QrSTdFbXhhcHgwNUErSklpMXYxMjN4aUJIUVk2MHoydmRLbEJXN1p5?=
 =?utf-8?B?eExESGZxR09JL0I5bXVIMW5wMXdqbzRYMHd3ZmxvZHozT1hkekFGKzlSNXk1?=
 =?utf-8?B?dGE5NTAyZGNNd3dMVUtiUmtyaG5HcHc4d1JJNHVUWFBRQ2tkS29yNzF4OGZ2?=
 =?utf-8?B?RG1DRjY5b1BLQ0FqcEJSeHpuWHFJWmVySXNOMlZPeG0vaTBMMnZUT1ZYbUt2?=
 =?utf-8?B?aXY3VXlaeFg4V0pNQUoybzVNdHdIdlNhNG1nS3B3MzRvUHVYVWttNm4xV3ps?=
 =?utf-8?B?bmJsaXdTaU5yeXZ5NmN1Qlc2bnNlREJ2UnAxakh1cXlyUG9WcjNtT2xIbndx?=
 =?utf-8?B?TjloZ2xuVFFmbDUyR3FYS3dheG1DOE1uZXJXV3pKSjV1RDJGMVE5aTdaQ3Iv?=
 =?utf-8?Q?tuW/BwIcx242BsLlKGzIb+UX0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6796881d-a695-48c8-b751-08db65e95087
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 17:21:35.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH2EXuEHIQH2KbG+/fjM5PlCc1OORh5BXxTa9x8CJnIS6Ffipdk9jvUptCjWDCS1HGYc8iJaCsme3yb6WxUrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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


On 6/5/2023 9:28 AM, Alex Deucher wrote:
> Since there is overlap in supported devices, both
> modules load, but only one will bind to a particular
> device depending on the user's configuration.  Drop
> the message in the module init function as this can
> be confusing to users.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2608
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 -
>   drivers/gpu/drm/radeon/radeon_drv.c     | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7eda4f039224..94509b76fa6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3065,7 +3065,6 @@ static int __init amdgpu_init(void)
>   	if (r)
>   		goto error_fence;
>   
> -	DRM_INFO("amdgpu kernel modesetting enabled.\n");
>   	amdgpu_register_atpx_handler();
>   	amdgpu_acpi_detect();
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index e4374814f0ef..16b9eab90185 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -634,7 +634,6 @@ static int __init radeon_module_init(void)
>   	if (radeon_modeset == 0)
>   		return -EINVAL;
>   
> -	DRM_INFO("radeon kernel modesetting enabled.\n");
>   	radeon_register_atpx_handler();
>   
>   	return pci_register_driver(&radeon_kms_pci_driver);
