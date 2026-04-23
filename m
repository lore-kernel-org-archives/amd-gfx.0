Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CEAF589DA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 14:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA16210F14F;
	Thu, 23 Apr 2026 14:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sm0DBKqi";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED9810F14F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 14:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3KtJUt6znjByASz2Qv+moRCe4xtwAi23ESZ8FwgosK3CgIf2RsqMTh3ftKc/wV+YmYMf0Hc9ecMYkypx0I39Q2TALZ+leIEYB91w7mzP5wbXYWj8WKfLYyotD5MTjKQ6DQh/UEqoBYmRxCpXTwptg2zJLg9IwIBuwSkp+niNq+QTuoCXddojbWgVtrP/gEv31G95Ea+KAoO2G9OCFkO+vmN9uBE+zV5PakZNgdQSzr3sbHgLogRPHJkzYmsWE/QzfwT5Ta5dIap8e4+dLyVOqQkw9tR1bVOLK4NNJYC8ngGAlwZVbmiRjr6tYurjR5GhGdUh8QIo5urCWBYUB2dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QHijmEI+mweI+n15hbyjThwNlt5IGPcLpU9ifFyXAo=;
 b=mG/NCB9/YHPk8JGztEYFeOVndCyMTJ9I0j3rJiBveEOgd9QDULXnv7m35ph21iwSCVM1TT96PFkD6mxW7Dr4T4CNsKIq8+EhYUxwjb0NvC5yPExbWGs7BE/16ym3J11QbOwZX+ShEA3epmcUjrZgLNeEn7NqHkuQ5EmCUvxAyxbpnznTSDU2/F3RAY+FWnmRDuuMp4q7nr6oZb7JAOQeDqTKSP2voChQLeOMVejvR8aT7MLEAIIPvj8JroGGhNzHiWVdAjWZmjMwKx/Iq0+xTeb+cV8pFMts8JZHt5Q5BUu4kuMHbFQ3tDgsyj+SXv3rhILooi1H7kS3zy5iPnI40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QHijmEI+mweI+n15hbyjThwNlt5IGPcLpU9ifFyXAo=;
 b=Sm0DBKqi/cc/hIsftWoZg0abuqT+SfgJN/2pl5aoGGSxKdLHjNfKwppTl09B/jaFqsVXO5rD2iuJl/HbQ8MOYQDEggoiy85OfJUtF4/DOyoV9frfIt9r0HhemJQ1lxOm6dowXc7r4N8cwxhUBXnd2pLkOkU0bHjEDxBj/usNeHw=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by PH7PR12MB5736.namprd12.prod.outlook.com (2603:10b6:510:1e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 14:09:12 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::35) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 14:09:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 14:09:11 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 09:09:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Apr
 2026 09:09:11 -0500
Received: from [10.254.93.51] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Apr 2026 09:09:10 -0500
Message-ID: <a3d7c4e2-3aec-4cfc-a56b-96271f44c569@amd.com>
Date: Thu, 23 Apr 2026 10:09:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix divide by zero in
 calc_psr_num_static_frames
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Ray Wu
 <ray.wu@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Dan Carpenter <error27@gmail.com>
References: <20260423131900.2441526-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260423131900.2441526-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|PH7PR12MB5736:EE_
X-MS-Office365-Filtering-Correlation-Id: 024708cd-0c31-4838-2a75-08dea141e4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|36860700016|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Tp4zwOqUcjHgXjGJr6ZY1a32qJiZviADWUBYXtZQrkBIM7mCrKZmklb7tZkAeDfdsLx6+cLMS9HKuF0Fsw7XnbZ8vpWZIjMxLg9hYDPe6qi05rMvJai/Qjcq4yhXyXPYigh2GQUZwDjLTyi7ytrXGjqG+tuRMaM7yzo/AUxzm5ac5vuf+PrxCAJJgYL8C6yWKPYVbDPABpoECExKwKYoGQlNpdtoykDvNDkCl6/RrsEf1idMilxlmXB8XXUgyBMfomB0HObnRj0GLcinelv2+vPWvbmcLgp9NsY8F0h72GqdEPSD8NAeFZyFIbs9uHWgaJjKPZVx/ZlPGd1mxTGNImfaFr6QZ6kxFEJvl9fpMcg9NPXuNI1+tWYZ0nZKlQEXDC2Zk3Q6dOT9o7k/U2FsjtLxGVDCrhfdH7l/RpY3Cvbch+ipk5t5IjRkfgsVRebJgdbTBooDkNMQ9Hf5YHhfVUfb6+atMnQXW8hdFC5FM4Ig1qgFIBKSLZt94ZTe0/LqhMPemdY7gpHFGfmiCIKSV05norm8PlT0Dp6Cr2PeWH77wv7iGELg1BLaQubk1n1cA4iujEEq8nT4y8plFZQGMHCO/+l7BydvbVgQmN60+aj9kUqiASV6kMeUHko0dK3BAqUkH7ea+OrfGEA2EhPxgoKwXQklRJuAS1trtPqlDJuz4lBm7q1oo7uYXutAQLjiUJmKAr9MEuzdxR5nXD3wzv0K9FbeVHd7f/pwT9diNdAM4NFt4CYym27tuVXvKRfrFeKCyBjIYWuxTSvnxhb38g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h31Hkc1xCPmyEE24jNl5Bvxgp1+wWdTfiD0Mx1iS808F8e92bXEQlx7AqYg2cRpJjcLXVlEVjmhsCMAEJqXPHSWghygJwzQmr7t8f7fzcry7Va4KJaJoEQ0Dl7Z+H6o3NCaXnbJNgz6Xp8Ha1FZKcuDqSVjy9uqrG7viyK5bfuBLH1LvI3DN4eF35kXiGktDe3FjNSCjfwptwRxofrWNMcKZbwPc5eT1CpHjuO1nuRuvKP0QZqOC8yiaTCQAf/6tMQHGS3M58RJcuZzspYdmi9P7+y0JDzWNNM0dPGaKXAousuSd5rQgg8ztd7fFCUIGMLZOcnNxNq+qC8kOzxwqRSYjRJ6Dhr974NFACG6kgiaKB36XRu9WknOGTwOcExJjtyS9Fu9rJRdh5LzcxmYfZwXPvdd3JSNEPz9KuV84+n3I++fRIbPq4Rx59hZFpSZw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:09:11.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024708cd-0c31-4838-2a75-08dea141e4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5736
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



On 2026-04-23 09:19, Srinivasan Shanmugam wrote:
> calc_psr_num_static_frames() divides by vsync_rate_hz before checking
> whether it is zero:
> 
> 	frame_time_microsec = 1000000 / vsync_rate_hz;
> 
> This can trigger a divide-by-zero bug if an invalid refresh rate is
> passed in.
> 
> Rewrite the calculation to directly compute the number of frames needed
> for at least 30 ms using DIV_ROUND_UP(). This avoids the invalid divisor
> and removes the temporary frame_time_microsec calculation.
> 
> Keep the existing fallback behavior of 2 static frames when
> vsync_rate_hz is zero.
> 
> Fixes: 55676843f4b3 ("drm/amd/display: Introduce power module on Linux")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Ray Wu <ray.wu@amd.com>
> Cc: Chenyu Chen <chen-yu.chen@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
>  drivers/gpu/drm/amd/display/modules/power/power.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power.c b/drivers/gpu/drm/amd/display/modules/power/power.c
> index 6c73fecf57d5..81d15a51e045 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power.c
> @@ -157,20 +157,14 @@ static const unsigned int default_dc_backlight_percent   = 70;
>  
>  static unsigned int calc_psr_num_static_frames(unsigned int vsync_rate_hz)
>  {
> -	/* Calculate number of static frames before generating interrupt to
> -	 * enter PSR.
> -	 */
> -	unsigned int frame_time_microsec = 1000000 / vsync_rate_hz;
> -
> -	// Init fail safe of 2 frames static
> +	/* Initialize fail-safe to 2 static frames. */
>  	unsigned int num_frames_static = 2;
>  
> -	/* Round up
> -	 * Calculate number of frames such that at least 30 ms of time has
> -	 * passed.
> +	/* Calculate number of frames such that at least 30 ms has passed.
> +	 * Round up to ensure the static period is not shorter than 30 ms.
>  	 */
>  	if (vsync_rate_hz != 0)
> -		num_frames_static = (30000 / frame_time_microsec) + 1;
> +		num_frames_static = DIV_ROUND_UP(30000 * vsync_rate_hz, 1000000);
>  
>  	return num_frames_static;
>  }

