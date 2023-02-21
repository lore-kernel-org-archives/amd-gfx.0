Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12291C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 13:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3E310E128;
	Tue, 21 Feb 2023 13:20:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9514610E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 13:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULO7qiU2ViEF/+2h+8IglAOmT+6h0Dv9Jyfmv301Ts0izwucetNrU0Qj+58N0dpP7ETqD8dOpbXHhnQ8pPA5yRh4oayqMl/Rpd529r4NN2kN6APkXzU3YuESHAxEzdF68+X1lfB6WkWcZjr0htsBM032BCzBmJvSA55zWWS9XSkYVA1izRBhYS1Jh+v6PMymHis0byRIGJAUXninnyejvkYVau5pZCKdo38ve6ycoBjHGhF6NvoPd3Ih92XWp9LHwe2KF4238/kiPQ2ynGDAU391SkM4gKm0DAQXDHQa1iDmCvvi8mT1GJd4ShG6pEVgh4+Eq9/IFcCe+oe0G4R3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN43wFYSEgJMhCbHC4slaRhifp3oKHV8WPpidisqRow=;
 b=a0NWcmWP0kFNPfgUkQmWXfllHqpejWCjBnbIFoxJaTit98T91chiU6W/pxkHt8QGOd5kGO+9kX1fgCiOV8WnUXXm1nzwS6j7B79neqzKTrGh/Zvr7KKkrCgAsPkbeWrL6Txk2kwhWfg+XGS1CRf7JEcsrO0Ym14YJUxiCDtibzplCb3Z3mHfu1+ox6GTktIRQve0gh05UkIQztEwLpO/EbYsfALNmZyINV6tdVaSeeV6f+YrbtI/1HztE30r66nO10kDccxGSycJDr+6/ig0xBviLzvUHR0aE8XOveKkqDSvNeblRAo7b2WP2DZ2k4l0vkeL3PFQ/DVwQ7jKk5KO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN43wFYSEgJMhCbHC4slaRhifp3oKHV8WPpidisqRow=;
 b=bTtMlhRCj8NzlrMfFdaofah+AV32bzroJ3X8jhdadvXxkNdV753MNWg6y7R/4KB6/QFsnyMS1gOyB970+UUGh3eKOh8cKZ5gJPqRPfF56JgG5EH1V3Wi44y3J2mup8qkB6JFIZRcwztAbIQB8dSbrlutZj+c46Uvaa1Tu7HxcJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 13:20:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:20:38 +0000
Message-ID: <7d614a1f-b2a0-56fb-dd42-0101c2262b94@amd.com>
Date: Tue, 21 Feb 2023 18:50:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/3] drm/amd: Use runtime suspend in lieu regular suspend
 on supported dGPUs
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-3-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230220201618.25962-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 61984ffc-2d20-47c7-2e79-08db140e6c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xYDCETjqHkNH2rZG0iqWwngZXx6kOhvD25ujSBR4d/wKvbMy8MQJTyglWkcXOMmKOHfVG8SxBcaN8XMfJJjj6X9j9o0UfhC1Mvoez5vsv1Ywfl/iNimESLUIUeLhi1UXm0fco9gxEscvkfCJd41L/nSqhKFMQ1M4aSc4n85gBz04LSkQOj3ObY3IubSUunMJnr6Z/p7JmSmn8oH9a5/kerLZstLPgFWmaTC/Txw/6nLz8UNBXK6enGAoP7CCAoec5UnHs5wfXd7/c3ZS0DOvNWK/48GOaI4NyD6GUuyRtDZ+uFwzG/kqlLrN7QL3kHHK15ZRcF3jKdS/pWpBAyaIAFK9UR269mltmNN6qHiotZmznEQ2/5XAeI/gVo2rx4eGplwtg5gXbzPTrSIDqhr1DyLB3PcTsCQdxDX7Y9Ku3SEl9eCUD2P0GrEojNZrdaS+yd3rNsuX2MrY6ydEWfWukoddhHHxFET9ZgdLk/NCsFh0uExuNsmV6QHfVJZlPu5pf6uv32D9z3pw4zVlEXQpXzxR5C4Vq0D+Qx4kneH/cJ9JI4y16ORQiJxTEtcSjGz3uUGHOvJaeYYCACxxWg5u5xylrNlVJawRnG4v/Wn6NRXfRRCbAYVBcfWpKVc9Yqzo3ACxFYm4s1Oa6rrN1taJLnHyaab9QriMxlRZyX1mJIcnkHhz9yMdqa9FfTUvgNRSvibggusVjodNcvu4HSKtCMMUe24NBgp/gSPziCdFkEA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(31686004)(31696002)(86362001)(36756003)(15650500001)(5660300002)(41300700001)(2906002)(8936002)(38100700002)(83380400001)(66476007)(66946007)(66556008)(8676002)(6486002)(478600001)(316002)(186003)(26005)(53546011)(6512007)(2616005)(4326008)(6506007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFg4S3pGa0NocUdNbERZemdadnA1S09jYkZpVkhNSnc3REY3RHd6WXBQOVNK?=
 =?utf-8?B?c1lsdDBmaytucTNFb3JSN1c2Nmx4dFF1SG9DVXNjdFM0Qk5uY3BtNytzZ1A2?=
 =?utf-8?B?cVVmZEUyaTJDRmh3MzVSUDJ6YkZvbmdFTGx4NjR2enptWHU0ZEVVcUdNOXJP?=
 =?utf-8?B?NDVRTEVMMHUzejZ0dUJSYTNFVEVuaFkzRE9yTXBtZEpVOG84WSsyTXZiZ0s4?=
 =?utf-8?B?eVlFZ2RmSERvQWJYdnRuMUdqam10V0ZGMGJCMDNyZ1N4OVBiYnBjM1ViWlp5?=
 =?utf-8?B?V1ZhQlJmSmY4UnhiZmxvR0xQMmN4bDlwc0lHSUI3dXMrQjJHdERJOFdvYTdV?=
 =?utf-8?B?MDZwMGFSc3F2aEZ1bHdIbDQyQUxsa3RrZ3c0c3B1bVlTZmRxYXZaUkVLTW1W?=
 =?utf-8?B?WUNBaDBWY0V2a0liSlQwM0VZbDgzRUlBOG5uS0Z6ckVLN2w0amdCUEFqUUEy?=
 =?utf-8?B?ZlZzVHZlREYwVmVQTDR0WUxMdS9iRW1hcXNoZTFTcW5tRWxUU0hvQngvTTdl?=
 =?utf-8?B?V1BhTWhON3A0c1dIcFMwdzlaN1RsM01BanBSSWoxSE1aZUtnVWJzUWpPWVR6?=
 =?utf-8?B?T1JkL1ArSDBMU2U2WGkvU1RMSi9GQWVvamdjWFZUazE1UzVKaVBhWStnVzRp?=
 =?utf-8?B?TDZGclFvSjkwY3N5VnRoaEpUbWl2UkU2cjlnZEhXZUxtY1RzSWQ2blIwYjVT?=
 =?utf-8?B?ei9vNjJwWjBXTFgxcFFHTzE5SnZINVg1bkw3MGJFeHAwVGhnd3VuSVNpVE1t?=
 =?utf-8?B?RWlBSXNFbk5oWWpvck43ek1NU3h5ME1QbTdBOVRlVmw2bEdLMjF2TmwyOU9j?=
 =?utf-8?B?NG5tOTVOODlpUEFBSnZQUnAvbDBkOXVFYXVxaUUxbHNpZUNGRER1a3ljcEty?=
 =?utf-8?B?SEp4Y2ZxK1FUY3NuOUhNNnJHaFZobENRYWd3KzYrRlB5YlFEQ3IwMjZuTGtT?=
 =?utf-8?B?K2NrOWNyZ1IyOHhvaWdYWjhQeXpNN3dLdjZPZ0tERlVDVFJ3VE9sT0Fma2xM?=
 =?utf-8?B?QjlXVHVRcDB3eW52MGVCSFg1ZGd3VFdxQUFJaWFsYUVtZUw0bmdpaWhKTExZ?=
 =?utf-8?B?b0JqM0RoVXdBR2tCMklVSFpuTHZ5MkRKUTRkbEJINXFiRW84UThWMUhtWkZ5?=
 =?utf-8?B?WmkydTN1OGd1WStVRWJlc1Zpd2JITFF0SnZhaHYyYlFmYW14a0JXeTkzaWJo?=
 =?utf-8?B?ZkJZSU1nTUZPUjk3MGppYnJ6M1poRWNPdkZaN0YrVmV1MkIrdGZZdENqdEZ0?=
 =?utf-8?B?QnZVK0NmTXZXY1Jyd1REcTduRE5BRXJQSlFCam1LcWFWb21jTU5UUEIvc2ho?=
 =?utf-8?B?dnY4Sk95N3hHK0s0TkJqK3MvVlRDaU5WUDBOY3RFWWVWdVpsQ3BiUC9NcEZx?=
 =?utf-8?B?N3A3eThPSndBbFVHeHk4MjA5VEtsTklZZXM4YWF0bVhwaURKQjNoaEt1QVFJ?=
 =?utf-8?B?Y3pzNUhVL3BteDV2RmF3dXpLV1gwbmV3eFY0WEVNYS91U3duY0dibEFRUWk1?=
 =?utf-8?B?MExWWGd2MkZpdnZmcUNueFpCUUFsOEwrKzNCc3NTbnhXOXR0MDRocmJrTVhD?=
 =?utf-8?B?bUpCMlhHWG5nbVAyYWo1S1k3dzk1V0wzdE5xTlY5dWxHdnVKZXRUTjd1a2ZM?=
 =?utf-8?B?cDlRbnI3WUh3NVNNNE0rbGE5K3lGRk8zdERPOGdZa1QvM3FGMFA3bDJHaHhI?=
 =?utf-8?B?RC93cEFXc1FhR1gvUnhRNlRuQTdWelFiZi9vLytkZGJPUW10MjR3UEV3YWc3?=
 =?utf-8?B?WnRuTWhmMHoyZGhRd0V0bEExQjNCdW01dVRtalVZYU9IaExKTVF5Y2lScC94?=
 =?utf-8?B?SUV4VXFFYW53VkZmdFpqQXlRQ3FUeVIzb3FES2hMMUJ2S3ZyUFhMb0JUVzJL?=
 =?utf-8?B?bEJqVUxkL3R1UFdXR05lSXpqaGI5bW9wV2JxUmxFYjB2cnIwQ0ZXV202TVYx?=
 =?utf-8?B?WG16YjNQeFdITlNveGpiVEFrcWNZeVdRR0RhS3RGZDg1bldmNWVDTXRrL0RD?=
 =?utf-8?B?QWRpQ3ZIWTFQMnRNRlVrbFZiR3NYVFJHZEdyK1FzdjVJK2tHY3NneXZjNHFs?=
 =?utf-8?B?bzNqYnRNSGE3ekVyWFdoeDQ0K2xzN3VJL1NndmpjNmt0bHgwV3NpT3hZMVBZ?=
 =?utf-8?Q?tZufkVdLvRl2z77Oz5VkCsIr6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61984ffc-2d20-47c7-2e79-08db140e6c17
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:20:38.2206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ceAiiuz5VnQbMkCLaBqTfvlimvWNORSAL9qOtp9MIRXskESiE3DqWCZG39twhX36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/21/2023 1:46 AM, Mario Limonciello wrote:
> The PMFW on dGPUs that support BACO will transition them in and out
> of BACO when video/audio move in out of D3/D0.
> 
> On the Linux side users can configure what sleep mode to use in
> `/sys/power/mem_sleep`, but if the host hardware doesn't cut the
> power rails during this state then calling suspend from Linux may
> cause a mismatch of behavior.
> 
> To avoid this, only run the runtime suspend and resume callbacks
> when the dGPU supports BACO or BOCO and the smart flags didn't return
> to skip these stages (because already runtime suspended).
> 
> Cc: Peter Kopec <pekopec@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c3d3a042946d..fdc1cbf8ad10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2418,8 +2418,11 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   		adev->in_s0ix = true;
>   	else if (amdgpu_acpi_is_s3_active(adev))
>   		adev->in_s3 = true;
> -	if (!adev->in_s0ix && !adev->in_s3)
> +	if (!adev->in_s0ix && !adev->in_s3) {
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_autosuspend(dev);

This is asking the device to be suspended (from a suspend call and that 
sounds weird).  Runtime pm handler will assume D3cold scenario and 
explicitly request BACO entry. Wondering what would happen if the 
platform doesn't put it in D3cold under s2Idle for dGPUs (BACO/BOCO).

Thanks,
Lijo

>   		return 0;
> +	}
>   	return amdgpu_device_suspend(drm_dev, true);
>   }
>   
> @@ -2440,8 +2443,10 @@ static int amdgpu_pmops_resume(struct device *dev)
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   	int r;
>   
> -	if (!adev->in_s0ix && !adev->in_s3)
> +	if (!adev->in_s0ix && !adev->in_s3) {
> +		pm_runtime_resume(dev);
>   		return 0;
> +	}
>   
>   	/* Avoids registers access if device is physically gone */
>   	if (!pci_device_is_present(adev->pdev))
