Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECD9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 13:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E9C112E5B;
	Tue, 31 May 2022 13:14:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4D71112E5A
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 13:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvWx/8KDUto6FobCAEDMSHqJXH6U5DzqpFFIK540uqyLX0qK+wkoOS+FsC1cFXh47NdXN4YT8kC1c4cE5v4ZzWf/zF587MRL7/BqiKwQmNndxXh0F8ofVz1Ica45JmRoTjG7p/uTSE01AFwUhD5Zp7pdpIhQW8wAxsvdHUxnSCib5wL6N0V78wM+rVDf0Im8ld4/Xa9CJaBXUgz2CN6bloQ8LM8xbl4/EaJTbLhV0fqX/sPjw1tDyD1bM3otN7S3L6M10OIWB44qX0+1ZpzQtRhYdW6BKcQDsC46amlxz4T3opWsCTE/lrXIYZncQiLBqCKWne64h95CvTqwABzdaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE3DvC+ABZlCfDAZTxsUXKEDH+uFHz3gPB97p02Xoh4=;
 b=ibAkoBsPIQPx74MHLxBRajFq47RxOAgI5PZZB5tBZq3IKi7IJ9GPr1mL4r3CWdRmpbYkkyBM2qqVemsiazjxz8K1o3GtXzlz510m2bo5qU1a5pWACGEk8Sm1EskmBm+rhqj2jx+sK+773U4FVD0zv09uOE6b2+x0mSSMaKIXLa3n0arw7Ebdf1acASlMRMipV7iD+o+zhEgP94IHez6OppMiUCqBDOt5uyl85d9rrccCPJ1AmVzcT+ENcCEo0rkU8XYLGl/ahd+TMiWEpI0J11NSwkmuwGlcwUhZDu45JklnmL8+3B3Ugj52GgyTWbLDDcbMZMFVgNYO/MUYT1FCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE3DvC+ABZlCfDAZTxsUXKEDH+uFHz3gPB97p02Xoh4=;
 b=IlnslXcqyiEtYMELzGQD6PJlDWT+207O5mecbvCtYhCg0sTR/z9cS/RiqAmT/Fvu4AMXVS+Dq4fpPgM1+G4pevIvdf8eOcSOb6KSFY/HMBbrfN5x465biqbOXEwW5jbx+QcLLWpTJ2Y8PyId/SxjPfLd6LiyhIyXYHB54MomKvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by CO6PR12MB5458.namprd12.prod.outlook.com (2603:10b6:5:35b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 31 May
 2022 13:14:35 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 13:14:35 +0000
Content-Type: multipart/alternative;
 boundary="------------mjEkzWdC695k9lmB6VxnjXbS"
Message-ID: <69b98a2e-95a6-1772-d445-6072764c9689@amd.com>
Date: Tue, 31 May 2022 18:44:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220526094839.36709-1-Amaranath.Somalapuram@amd.com>
 <20220526094839.36709-2-Amaranath.Somalapuram@amd.com>
 <CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com>
X-ClientProxiedBy: PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::32) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4334923c-0603-4887-f73e-08da4307820e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5458:EE_
X-Microsoft-Antispam-PRVS: <CO6PR12MB5458F4273FE7AAA395AAB95DF8DC9@CO6PR12MB5458.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KnEToxz1xPHHgr7PzYxUtubBdSOpFkftW/AEj5lC057YU+cRGke7ANTZzY0ghL7vWmqUZA4nvAdimWmCHQh2757KlVm37tF4bNTHJ8PP3T4AwpV97/ITIaOXBa1IBzNNeX8NxkcaoEDATCJYzWPd5mqiKQhhWyONf6jJjiJwj5VNP561NjebCVwKbE5WGzuyWepCmb79C0kJaR2O/FV0OaVQZloF/z3MBJi/gR5uqblUa0ySLx1Io4I7ngYPb6V5vydlYVP+cvSkWXm12WXR0D6KeMoLI51BevbqwJXS/+LHI+L9r5IIOIh2ugYdDDFdrAkTDumluPgr3fudNmKrOHE8Kjb/TDgbaN0CbhsR9UhRjqo5HxIBzLOXApnLBJS5Ws2KL0V87GSYKMjLdeHbJ38NKlRNMb1GNEBey0IhfUEoH5kM+zGdsFAMaZuORi2LwaBRei0LgW8hMWPNW9jw5JNzYUYsg0TBRtnF4t+05KutiVIG7BLHZyk7xlYJ8TZ3NGdDK82OPcD/LPPzF9w1fuEKB5jPFBOlWW9Dw1Q2NJEFspWeuiHMv12zqJ4CQn5upbCtm9wpnuN4NPyVvgVOcctPzqbowCa2nEns2cD2eA6AaSmtk+Un9Wr6lCmmkLjGOkHlUa2D30hmJ7Sc6kM30aedjH74fbNbHnLdvQczsHe92PTe9JnnMsUFffkRl9WoLB9FSIKJLk555vir72JsQaAxqdWy+Ou45DaEEuA87Kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(6512007)(19627405001)(33964004)(53546011)(6506007)(66946007)(110136005)(66556008)(66476007)(36756003)(316002)(8676002)(4326008)(31686004)(8936002)(6486002)(6666004)(54906003)(38100700002)(5660300002)(508600001)(2906002)(83380400001)(30864003)(2616005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T25pUWRZM0pjenZUakhkOFVJSkptNEMvbzVpeCttdHI1QzRpekUyb1lrYUQ3?=
 =?utf-8?B?aERLdFJMdDRCcnR2bzFNSnZJQkN3WmRJbGg3ZWNrQkxuaUlqcWRTOUNOL2dj?=
 =?utf-8?B?YU9vaDdlYkhWdW1LZTh4Z3JBVHpRLzBpNmRldjkwa2xTMWRvWEV0TURlUXhz?=
 =?utf-8?B?bDRvdXlQNWRab3NCaDlIS3NPdXhDRndUcFZzZ2lUc3hWSWlPV2dYWEtKNW96?=
 =?utf-8?B?ajk1ck9UK0tHQ2ZTbW5DVUUvMW9QVlA2MU1XNUpMNEpRbU1QMVE0SkVVbmZ0?=
 =?utf-8?B?QkRtQTZQUEtXUTB0OWpIK0xRNEYxY3Y5WFBCTkJlVEswZER5cnZNbmFROU50?=
 =?utf-8?B?MGg3bWtzejdrSEZEMWh2UlJsZ3Q2bmY5MERPdWRRNVVWR210Z3BmeGRiK0FP?=
 =?utf-8?B?aktYRVBpZ282VUV2VnpXeDI3SEMxRFNOSXBKdUZlcmsyMjNOZm5rSzRaaUcv?=
 =?utf-8?B?UXd4aTZYRzA2Nm16dDRzc0dmcjU0T1cwcHNQWWhybWF5Z29qem5iaHNEWkdv?=
 =?utf-8?B?RERGcnpCWFVNdFU5YU01THpJUHFnMGZkd2F1UWFVV24zdmhjSlYrZE1pOHFB?=
 =?utf-8?B?aXBZbkRpZTRIelltUmd1RzVyZXQxVUFlZmMxTFEvS3dMelBKczRGbTZMNExI?=
 =?utf-8?B?U2dhYVZOcmovRm0zcktPdkp1OHJqWEJTNW9aYjlXbVgzMW4rVVpOVVFDeFdN?=
 =?utf-8?B?YWNsS2Y5NFpHd0VvdkdIL01sTnhFekdDNnFuUnQ2ZWRLUEY1eEgySHZNZm1O?=
 =?utf-8?B?cG1JQnlEMUxtYnlDRGRuS3ZzeTM2TTJSUmh1a2k3WmluSk10eGJDcFZyUnJk?=
 =?utf-8?B?aHNkNGNGQXFCYjk2bHFXSCtZdGx6a1htQmRsRzFPS2F2U24wWUlmQ1RKaUYz?=
 =?utf-8?B?aGd6QmE2VE8wVWhhZGRCTkZaRG1LN3EyRlJmYS9oK0hEVXNTTkhBTEpSMlBn?=
 =?utf-8?B?YWNiT2ZvNFczOTFMdTNNNVgyOHJhQlRQeWxXbktSWER2bTYvNFZ4cVZHZUk4?=
 =?utf-8?B?aDNUcUorNHVNcjRNMjR0WDgwTVFYRmJ4cmhMZHcxOE5SeEc5a0J0Yk81eDJN?=
 =?utf-8?B?SW5zenhkeVQraHFrUkV5KzJURjZ3NjNRcDJsT3U0NGd2WGhsVmlRQS9XVk45?=
 =?utf-8?B?cUZ6NEdIeWZMTUFDQW1jNE44Ny9vTDRPaDFuUlhKSmVjL3ZvTUZaQThWOTRy?=
 =?utf-8?B?cml3TlByYVh6TFlLK0owb2hUNFMwc1FlcWNLODJIZ3lsTTc4SStNZDdTeWMy?=
 =?utf-8?B?UWorbXFHTWhzdG53bnByNU1FMDl3SndXa2ZlRzZZbm90YktGLzJjYkNmWk1o?=
 =?utf-8?B?QklJanNwZmlnVXRpK1Nic3dFTndueUx2djN2R1B4N0UzVWcxSFBjWWdtOGdW?=
 =?utf-8?B?d083b0ZqSnhxU1BIMzZrY1UxR0pieDEyNzJGVjhxcFRHSk1sZDRYNG5zcnlu?=
 =?utf-8?B?VUxKdGVLdVBlNjlQOVkyWUxaZDlDRmV0K1BRdXlMcFBVVGxnUWVGcmQzUXlP?=
 =?utf-8?B?STMzT2VpRUFteFdQRkYzMVMrT1EzSytWSGhJYmZnbVpBVTVCVGtxTGI4QnJl?=
 =?utf-8?B?VTBFQThneElHUWNoUzlRQlpGWlllUW1UeC82WkJxUXJUcGx5b2J2eHZDTmtS?=
 =?utf-8?B?eGpNSU42L29pTUx1RzhDSEZMaVBMZmYxNG5TTDdFSFZVOEpkK0JTeEhHblBk?=
 =?utf-8?B?b0NpMWc5a3N6SFQwbjBCRklsOTBmRkljRGFGSWhla2lvWnFEMDcydTN5aUE4?=
 =?utf-8?B?UXVLd1JUZEFxNXZZY1hjaFRWeCt2dit4NnBWOWtlVGpIZ0ZKNjVFdjZKbytO?=
 =?utf-8?B?V3RqUURsNUl3bVYyL1lHM2poYWJxTUh6YVdrNWF2M1NOZkVuUEhyVEVyUU5i?=
 =?utf-8?B?MWtqK215a2xlckxiWGlRb3lZN0V1K0RDaGt3UTRUemVFWDkwSUlhNm1TTTI4?=
 =?utf-8?B?QXRVZzdGM1F0Z2xLOEpZQUJFQTVpcnp3R2c3ZTZIem5aZm5nZWtndzdWZFNa?=
 =?utf-8?B?VjZ1Skd3U3BoZ1RqdU5NVW1GKzdOV2ZVdGNFZ05SS1VocXhjYndBME4wbnNl?=
 =?utf-8?B?Q0M0MTVQOWZ5TG9ObGU5WkJpZDlYUzUxTFkrUmttZHhHZGU1bkVKbUhDOVNV?=
 =?utf-8?B?NWpqeVlFck1oZCt4cmhzZ0tzRTFVMm8yVVFtd3dvM3RDSWVoRzlNZEIwWE51?=
 =?utf-8?B?YjJRaUt6cjd1SDA2M243RlhleDg4MWh1OGZtczNxY2thZ3dScWhXYVBWZ2x6?=
 =?utf-8?B?RkZ3RWlvQUttZ3FjMExITjExV0k0aXIzVExMRnpGbXc1OU5hdDQzY3JWemVV?=
 =?utf-8?B?N3MzcWNZSVJRVGdJVjkxdENVVy9xUVo2VE1tSHZvTGk3Qm5aV3A2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4334923c-0603-4887-f73e-08da4307820e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 13:14:35.5790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLx4/g1fzOZj+AvBvGPosQ6wORLD8AUXDbgfWxqvaFbTC5uJQYzECCrTwHmOXWZqmZqlngzqL7eUaRb4N3XO7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5458
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------mjEkzWdC695k9lmB6VxnjXbS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/26/2022 3:56 PM, Wang, Yang(Kevin) wrote:
>
> [AMD Official Use Only - General]
>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> *Sent:* Thursday, May 26, 2022 5:48 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
> *Subject:* [PATCH v2 2/2] drm/amdgpu: adding device coredump support
> Added device coredump information:
> - Kernel version
> - Module
> - Time
> - VRAM status
> - Guilty process name and PID
> - GPU register dumps
> v1 -> v2: Variable name change
> v1 -> v2: NULL check
> v1 -> v2: Code alignment
> v1 -> v2: Adding dummy amdgpu_devcoredump_free
> v1 -> v2: memset reset_task_info to zero
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index c79d9992b113..25a7b2c74928 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>          uint32_t *reset_dump_reg_list;
>          uint32_t *reset_dump_reg_value;
>          int                             num_regs;
> +       struct amdgpu_task_info         reset_task_info;
> +       bool                            reset_vram_lost;
> +       struct timespec64               reset_time;
>
> [kevin]:
> the CONFIG_DEV_COREDUMP check is needed for above variable to avoid 
> compiler warning when coredump feautre is not enabled.
>
Agreed.
>          struct amdgpu_reset_domain      *reset_domain;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 866b4980a6fa..ca97afe5be63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -32,6 +32,8 @@
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
>  #include <linux/pci.h>
> +#include <linux/devcoredump.h>
> +#include <generated/utsrelease.h>
>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_probe_helper.h>
> @@ -4734,6 +4736,62 @@ static int amdgpu_reset_reg_dumps(struct 
> amdgpu_device *adev)
>          return 0;
>  }
>
> +#ifdef CONFIG_DEV_COREDUMP
> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
> +               size_t count, void *data, size_t datalen)
> +{
> +       struct drm_printer p;
> +       struct amdgpu_device *adev = data;
> +       struct drm_print_iterator iter;
> +       int i;
> +
> +       if (adev == NULL)
> +               return 0;
> [kevin]:
>  this check is not needed, because this private data is passed by our 
> driver as below:
>
In my testing if the reset is unsuccessful amdgpu_devcoredump_read will 
not be called.

Shashank: Any inputs on this.


Regards,

S.Amarnath

>  dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>  amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +
> +       iter.data = buffer;
> +       iter.offset = 0;
> +       iter.start = offset;
> +       iter.remain = count;
> +
> +       p = drm_coredump_printer(&iter);
> +
> +       drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
> +       drm_printf(&p, "kernel: " UTS_RELEASE "\n");
> +       drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> +       drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, 
> adev->reset_time.tv_nsec);
> +       if (adev->reset_task_info.pid)
> +               drm_printf(&p, "process_name: %s PID: %d\n",
> + adev->reset_task_info.process_name,
> + adev->reset_task_info.pid);
> +
> +       if (adev->reset_vram_lost)
> +               drm_printf(&p, "VRAM is lost due to GPU reset!\n");
> +       if (adev->num_regs) {
> +               drm_printf(&p, "AMDGPU register dumps:\nOffset:     
> Value:\n");
> +
> +               for (i = 0; i < adev->num_regs; i++)
> +                       drm_printf(&p, "0x%08x: 0x%08x\n",
> + adev->reset_dump_reg_list[i],
> + adev->reset_dump_reg_value[i]);
> +       }
> +
> +       return count - iter.remain;
> +}
> +
> +static void amdgpu_devcoredump_free(void *data)
> +{
> +}
> +
> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device *adev)
> +{
> +       struct drm_device *dev = adev_to_drm(adev);
> +
> +       ktime_get_ts64(&adev->reset_time);
> +       dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
> +                       amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +}
> +#endif
> +
>  int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>                           struct amdgpu_reset_context *reset_context)
>  {
> @@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct list_head 
> *device_list_handle,
>                                          goto out;
>
>                                  vram_lost = 
> amdgpu_device_check_vram_lost(tmp_adev);
> +#ifdef CONFIG_DEV_COREDUMP
> + tmp_adev->reset_vram_lost = vram_lost;
> + memset(&tmp_adev->reset_task_info, 0,
> + sizeof(tmp_adev->reset_task_info));
> +                               if (reset_context->job && 
> reset_context->job->vm)
> + tmp_adev->reset_task_info =
> + reset_context->job->vm->task_info;
> + amdgpu_reset_capture_coredumpm(tmp_adev);
> +#endif
>                                  if (vram_lost) {
>                                          DRM_INFO("VRAM is lost due to 
> GPU reset!\n");
> amdgpu_inc_vram_lost(tmp_adev);
> -- 
> 2.32.0
>
--------------mjEkzWdC695k9lmB6VxnjXbS
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/26/2022 3:56 PM, Wang, Yang(Kevin)
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Somalapuram Amaranath
            <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, May 26, 2022 5:48 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Somalapuram, Amaranath
            <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Sharma, Shashank
            <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH v2 2/2] drm/amdgpu: adding device
            coredump support</font>
          <div>&nbsp;</div>
        </div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText elementToProof">Added device
                coredump information:<br>
                - Kernel version<br>
                - Module<br>
                - Time<br>
                - VRAM status<br>
                - Guilty process name and PID<br>
                - GPU register dumps<br>
                v1 -&gt; v2: Variable name change<br>
                v1 -&gt; v2: NULL check<br>
                v1 -&gt; v2: Code alignment<br>
                v1 -&gt; v2: Adding dummy amdgpu_devcoredump_free<br>
                v1 -&gt; v2: memset reset_task_info to zero<br>
                <br>
                Signed-off-by: Somalapuram Amaranath
                <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a><br>
                ---<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 3 +<br>
                &nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 67
                ++++++++++++++++++++++<br>
                &nbsp;2 files changed, 70 insertions(+)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                index c79d9992b113..25a7b2c74928 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                @@ -1044,6 +1044,9 @@ struct amdgpu_device {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                *reset_dump_reg_list;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                *reset_dump_reg_value;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_regs;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_task_info&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_task_info;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_vram_lost;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct timespec64&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset_time;</div>
              <div class="PlainText elementToProof"><br>
              </div>
              <div class="PlainText elementToProof">[kevin]:</div>
              <div class="PlainText elementToProof">the <span style="background-color:rgb(255, 255,
                  255);display:inline !important">
                  CONFIG_DEV_COREDUMP check is needed for above variable
                  to avoid compiler warning when coredump feautre is not
                  enabled.</span><br>
              </div>
              <div class="PlainText elementToProof">&nbsp;<br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <font size="2">Agreed.</font><br>
    <blockquote type="cite" cite="mid:CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com">
      <div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText elementToProof">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_domain&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *reset_domain;<br>
                &nbsp;<br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 866b4980a6fa..ca97afe5be63 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -32,6 +32,8 @@<br>
                &nbsp;#include &lt;linux/slab.h&gt;<br>
                &nbsp;#include &lt;linux/iommu.h&gt;<br>
                &nbsp;#include &lt;linux/pci.h&gt;<br>
                +#include &lt;linux/devcoredump.h&gt;<br>
                +#include &lt;generated/utsrelease.h&gt;<br>
                &nbsp;<br>
                &nbsp;#include &lt;drm/drm_atomic_helper.h&gt;<br>
                &nbsp;#include &lt;drm/drm_probe_helper.h&gt;<br>
                @@ -4734,6 +4736,62 @@ static int
                amdgpu_reset_reg_dumps(struct amdgpu_device *adev)<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
                &nbsp;}<br>
                &nbsp;<br>
                +#ifdef CONFIG_DEV_COREDUMP<br>
                +static ssize_t amdgpu_devcoredump_read(char *buffer,
                loff_t offset,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count, void *data, size_t
                datalen)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_printer p;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev = data;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_print_iterator iter;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev == NULL)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
              <div class="PlainText elementToProof">[kevin]:</div>
              <div class="PlainText elementToProof">&nbsp;this check is not
                needed, because this private data is passed by our
                driver as below:</div>
              <div class="PlainText elementToProof"><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p>In my testing if the reset is unsuccessful <font size="2"><span style="font-size:11pt">amdgpu_devcoredump_read will not be
          called.</span></font></p>
    <p><font size="2"><span style="font-size:11pt">Shashank: Any inputs
          on this.</span></font></p>
    <p><font size="2"><span style="font-size:11pt"><br>
        </span></font></p>
    <p><font size="2"><span style="font-size:11pt">Regards,</span></font></p>
    <p><font size="2"><span style="font-size:11pt">S.Amarnath<br>
        </span></font></p>
    <p><font size="2"><span style="font-size:11pt"></span></font></p>
    <blockquote type="cite" cite="mid:CO6PR12MB5473648915874B1A5D6C2A9C82D99@CO6PR12MB5473.namprd12.prod.outlook.com">
      <div>
        <div class="BodyFragment"><font size="2"><span style="font-size:11pt">
              <div class="PlainText elementToProof">
              </div>
              <div class="PlainText elementToProof"><span style="background-color:rgb(255, 255,
                  255);display:inline !important">&nbsp; &nbsp; &nbsp;
                  &nbsp;dev_coredumpm(dev-&gt;dev, THIS_MODULE, adev, 0,
                  GFP_KERNEL,</span><br style="background-color:rgb(255,
                  255, 255)">
              </div>
              <div class="PlainText elementToProof"><span style="background-color:rgb(255, 255,
                  255);display:inline !important">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp;amdgpu_devcoredump_read, amdgpu_devcoredump_free);</span><br>
              </div>
              <div class="PlainText elementToProof">+<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.data = buffer;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.offset = 0;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.start = offset;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iter.remain = count;<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p = drm_coredump_printer(&amp;iter);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;**** AMDGPU Device Coredump
                ****\n&quot;);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;kernel: &quot; UTS_RELEASE &quot;\n&quot;);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;module: &quot; KBUILD_MODNAME
                &quot;\n&quot;);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;time: %lld.%09ld\n&quot;,
                adev-&gt;reset_time.tv_sec,
                adev-&gt;reset_time.tv_nsec);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_task_info.pid)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;process_name: %s
                PID: %d\n&quot;,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;reset_task_info.process_name,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;reset_task_info.pid);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;reset_vram_lost)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;VRAM is lost due to
                GPU reset!\n&quot;);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;num_regs) {<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;AMDGPU register
                dumps:\nOffset:&nbsp;&nbsp;&nbsp;&nbsp; Value:\n&quot;);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i = 0; i &lt; adev-&gt;num_regs;
                i++)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_printf(&amp;p, &quot;0x%08x:
                0x%08x\n&quot;,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;reset_dump_reg_list[i],<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                adev-&gt;reset_dump_reg_value[i]);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return count - iter.remain;<br>
                +}<br>
                +<br>
                +static void amdgpu_devcoredump_free(void *data)<br>
                +{<br>
                +}<br>
                +<br>
                +static void amdgpu_reset_capture_coredumpm(struct
                amdgpu_device *adev)<br>
                +{<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev = adev_to_drm(adev);<br>
                +<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_get_ts64(&amp;adev-&gt;reset_time);<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_coredumpm(dev-&gt;dev, THIS_MODULE, adev, 0,
                GFP_KERNEL,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_devcoredump_read,
                amdgpu_devcoredump_free);<br>
                +}<br>
                +#endif<br>
                +<br>
                &nbsp;int amdgpu_do_asic_reset(struct list_head
                *device_list_handle,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_reset_context
                *reset_context)<br>
                &nbsp;{<br>
                @@ -4818,6 +4876,15 @@ int amdgpu_do_asic_reset(struct
                list_head *device_list_handle,<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
                &nbsp;<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_lost =
                amdgpu_device_check_vram_lost(tmp_adev);<br>
                +#ifdef CONFIG_DEV_COREDUMP<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                tmp_adev-&gt;reset_vram_lost = vram_lost;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                memset(&amp;tmp_adev-&gt;reset_task_info, 0,<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                sizeof(tmp_adev-&gt;reset_task_info));<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                (reset_context-&gt;job &amp;&amp;
                reset_context-&gt;job-&gt;vm)<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                tmp_adev-&gt;reset_task_info =<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                reset_context-&gt;job-&gt;vm-&gt;task_info;<br>
                +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_reset_capture_coredumpm(tmp_adev);<br>
                +#endif<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vram_lost) {<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;VRAM
                is lost due to GPU reset!\n&quot;);<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                amdgpu_inc_vram_lost(tmp_adev);<br>
                -- <br>
                2.32.0<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
  </body>
</html>

--------------mjEkzWdC695k9lmB6VxnjXbS--
