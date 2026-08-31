Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED19C61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 16:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E8E10E28C;
	Mon, 31 Aug 2026 16:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HPQ/QLi/";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010029.outbound.protection.outlook.com
 [52.101.193.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E261210E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 16:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWjI2dYc+bWtbGgCUpcQQsvaquv+LZMrqSxOQmLI3w9wm2ge/9KFKmadqOJlgtibMAPVXyHtBbsfaGTg3ZGQYAU0ARVyVfMp6IHFFeJK8JLyumUua/VU239FhgidIh9FsRn1rXNPOr6Gk7WN3EImm3thUAaTAzSSqnhf7NXZzhEajYyYcWMNZCVqpS/z3pS2MnnjTtZKvsvxxoexontGwxMRa0Uod6NSRaVMzk29IkTjKzU7mQkuy1CyGCHpHlAcy4Etc8lieIhTiSeyTy4t7niwd4KYl53H1uduTDRreVIv4BqsN+niBFC23a4bzm7kWUTORJZ7J2IAYv8Y4VLhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du3XntTm7JY1uzcG8LUt1GsfH9El/fja71lQoq8gdEs=;
 b=tMWjfqUdqHMxz2kXDrodC6CqFtWwpvnlBjxmetAYOi1Alcxyw6zbkhBY4imjLCuoDkHkPEHEWZ4oOJ5Udxxld+a+hGyT6AcVOQXTqUaPn8G5G2lcaOy1h1GUjleEGmARKs00/mOGwxLObyy828udlB0DawH/ldHJW8USLFdBSKY5NhZz0nzJcIzJPNxssek6yiH0Z+PtIWsgyDCwC6VbI2QnYn37EHNr6gj94aGkk0l5eLFQAAWiqN7clbB+X0SE+JPDyXWS2TdcY3za9CIwFiBCglvHW11XDltn95xybYjXhOioSG7UKK/KM04zD+Toqn8Mf7sCNi7bGO1nrSJ5zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du3XntTm7JY1uzcG8LUt1GsfH9El/fja71lQoq8gdEs=;
 b=HPQ/QLi/pEtdcZS3/5HkWGfXDfDZW27qwinog8yuY7M3tER5LAhEy/Hv1cweSFz5Xo6ItdpzY2pb/qYl5MMrgHz68w7gu4WWxO+gpMcIiPBZM6hCZUqV4cQWtWtCAou8uLhE8dtC5DShvfpQqwxjpfcodo9J5yeoMnlo9KaC3fc=
Received: from SJ0PR05CA0203.namprd05.prod.outlook.com (2603:10b6:a03:330::28)
 by PH7PR12MB6491.namprd12.prod.outlook.com (2603:10b6:510:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 16:26:55 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::67) by SJ0PR05CA0203.outlook.office365.com
 (2603:10b6:a03:330::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.9 via Frontend Transport; Mon, 31
 Aug 2026 16:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 16:26:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 11:26:54 -0500
Received: from [10.254.92.68] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 11:26:54 -0500
Message-ID: <547d5fc9-5a46-4097-87f8-a1ca2ec26df1@amd.com>
Date: Mon, 31 Aug 2026 12:26:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix cursor disable with horizontally
 split planes
To: Yuling Li <yulingli@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Yuling Li <Yuling.Li@amd.com>
References: <20260831072841.2302952-1-yulingli@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260831072841.2302952-1-yulingli@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|PH7PR12MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: bc563254-468d-474a-bc3d-08df077cabf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A0CX987YVugZ2GpptK/cKKE+szAsWk+4neHDIPrwj14JyvkPHqhNYgzx1if1NA3eSkDLk5BmR02YX33hGRJK93hMy6suF6fAPraOY4AubDzKUsc5v+SjC2DDD5GZ3fcS0X85PEXCVDafN7EoI7Arg8IzHtG2BVs0DOlLmrBPCxZxWjKWDYUTtt0IkoxkjWLDGcAROZCo8l3BJ32oUi3bWGgX8vdPicT6tcYeLHAEMLcKN8Tp+wUoiA2JPddFGGc9o+ZC6DtEGxZ1ijjWh6ZMWVfYWEdtWBCliukYjYSR/51clnIwK4bRGjjdm8rTvjo1yMOBUSV4C4d3NWBfkucD1ifnSFe9TNjQGXgi9utimLAF4J49v08sasHo+OwKTlBDmxUJP9JOqIMmiF75+HRtzaLX06c3r5UDtgveXB26XcjVWf6e8cdLrW6NuFFLj2vHbK6oBAH3rjgqFHpvCBrk50jZ7f8KkpXYKmlgz56sfoyBBz53wh4txuTQpCdT5AspmIyV/tSeBhz2/dG/juLLHTaln2ghfZq05N+4arrRc4x7k9VNJJJifZgfQpwYZr/B9g5/+jBm0GPMRCQQvNt9187Bt9v/T/xp8EAwuYKjxOQlha7RcxAUqbeGCNPB8/pfmrtgP6UqrEfVAa7GARsd3cI/DmOpQqGCGfNJW3o7Ae6PLbYYnLo7T+mIDFB7syL+aQ+6mmJ0bpBt0hHt3acyNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kHWPwo2eaRHn/bpqBISyD8sH5vLmg61cP/s5sik7XJnSfsJLhdmCJy97b/Ei0FiEQXjDHH+mpzGc8uQ6QVUD2e0nAh3InGYULC7YqV7PYloQw/fzOqWDxXHEZtz8dQtNdgP1V67qT3UswE+O6weSIqOOTcw2954Ed9Yg7RkH+gcP4SACErDSNKN3i3AqwOisJm0Fbob4NqcbxRd92q3VIt5PyC0Ch4mSIdjHrPHQMMGpb3MuhpECv3DsWnH3cYqZnz7HDTvvgsZsCL+pxuZjzdPHsE6XXL7Fh/QLKTAWa6dWvnA1VkeKOz349GEaM+5Jh1FELtHKQbEWU33Dp1dB6ftgSpnt41Qait5FzhK8FqyFgK+QcjFDuL8MNzpxTv2hRh3yyO9dG6F/VW8bUVovYEv2NqJ/p2xAy4SJiMdXf89kJ2PBCE2wOAKiDNf0AxGi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 16:26:55.1103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc563254-468d-474a-bc3d-08df077cabf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6491
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



On 2026-08-31 03:28, Yuling Li wrote:
> From: Yuling Li <Yuling.Li@amd.com>
> 
> [WHY]
> resource_can_pipe_disable_cursor() disables the hardware cursor on a
> pipe when a higher layer fully covers that pipe's recout, to avoid
> double-cursor and scaling artifacts.
> 
> When merging pipe-split halves of the same overlay layer, the inner
> loop walks every pipe above the current one and looks for siblings
> sharing test_pipe's layer_index. Because test_pipe itself satisfies
> that condition, it can be treated as its own split partner. That
> incorrectly doubles r2.width and makes the covering check succeed even
> when the overlay does not fully contain the underlying pipe.
> 
> On horizontally split or multi-quadrant layouts this causes the cursor
> to disappear over overlay regions while input/coordinate mapping remains
> correct.
> 
> [HOW]
> Skip test_pipe when searching for a pipe-split sibling on the same
> layer, so only the other half of the split plane is merged into r2.
> 
> Signed-off-by: Yuling Li <yulingli@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index ac558e715b72..7bbbe118e365 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1801,7 +1801,10 @@ bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
>  		 * pipe-split, merge together per same height.
>  		 */
>  		for (split_pipe = pipe_ctx->top_pipe; split_pipe;
> -		     split_pipe = split_pipe->top_pipe)
> +		     split_pipe = split_pipe->top_pipe) {

Nit: add a newline here.

Otherwise, it makes sense to me: 

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Curious, what was the specific use case where you saw the cursor disappearing? Which compositor/app?

Thanks,
Leo

> +			if (split_pipe == test_pipe)
> +				continue;
> +
>  			if (split_pipe->plane_state->layer_index == test_pipe->plane_state->layer_index) {
>  				struct rect r2_half;
>  
> @@ -1813,6 +1816,7 @@ bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
>  				r2_bottom = min(r2_bottom, r2_half.y + r2_half.height);
>  				break;
>  			}
> +		}
>  
>  		if (r1.x >= r2.x && r1.y >= r2.y && r1_right <= r2_right && r1_bottom <= r2_bottom)
>  			return true;

