Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5156C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBF310EE6F;
	Wed, 26 Aug 2026 23:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cJo0Ie7T";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9854C10EE6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCi4lm89bSwTkI7X4cJOW8RD0GZXsRz4gLNZAhUOXvPm6TdS1QDu2qHUOelVaEPdAovIBFB/+58J/9z/1BdRgG36VILYzpAG21MgUSZm91WDZ4cDh98b6RJByTVAO3o9IZJdKG4DPJeWTElseUmPdsSnF/Sd/klM0vhIMkh9yqleUttmTWMV6n0OCFuFXdBhj38RTmhw8eLHMaNDpbUqsDTJsnTTQ3UogigBeIClKpQW+pC5TadrtWayFEyowak855B5jTtWC6NdWcECGO5gzmhjxWEJIXgYTRWadhjYBhoIx3ptHIQATHUxaB41qbiQ+/liAehC/Ko+W0q9aDOZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo05mqXZrH/42ZxaMWHLtNcT1Rwn82QW32Rqj8iuoxg=;
 b=Hs/AwlciaU1Mbb8tc3oZm8tqiJYZbUjddUkheqq8FL8La5/NG5qHM94YAtn3rsVhOQ6wXl9Joyzp829aJcoeCbqEg6xVM6/ay1mUWoB0xRWTQEc3zTdMZiifs2v02kM57N5v1uk4kLSx0WZvm0K9ZERtM3+aqQREjnQ7qzqZdxwCRNVODcm7lS5pJIn8vy17UHFzXKaDgKY5iTs0BitZMUCbXXTuYytXXzREhkLxDH39U6jHQoIckFdICdx/JZTkmuZcrvtO0fbtYRyNpt+kybwaBZGkac7LfE49oj5al/QPLfERRaKjQoFfHxxim0pBBXo5MY2gINJht7gjBTsRrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo05mqXZrH/42ZxaMWHLtNcT1Rwn82QW32Rqj8iuoxg=;
 b=cJo0Ie7TqWAW16p4BIE+7xRroD/kpOxtRzG3593LRALFWZ6EDsVhWPJr+6EW9DozIBsLPvW/RoI1/2+Uosb1DQJqfb61e1Qq2mljAuV4MQvsKNAuv48gsluC+1hnDSXTguIYVMwXEVvxBCyxoEvAPHQ9WdFewkRibauLV7O3his=
Received: from SA1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:2ce::15)
 by CY8PR12MB8316.namprd12.prod.outlook.com (2603:10b6:930:7a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:35:19 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::61) by SA1PR04CA0012.outlook.office365.com
 (2603:10b6:806:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:35:19 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:35:14 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 58/59] drm/amd/display: Restore the native cursor mode early
 return for disabled CRTCs
Date: Wed, 26 Aug 2026 17:05:29 -0600
Message-ID: <20260826231519.881949-59-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CY8PR12MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4e7a5b-8c2b-4b22-dd26-08df03cab0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|11063799006|6133799003|10067099003|56012099006|22082099003|18092099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Kub+KYTmQzNVYyPelyu5m8c5p6Hu1qht0J/Xnku9IusNKpF6dD6KZn60ucjQ2T4xYY+13JOvILLuj+1sIXG4X0mm+CDfo+CQGbWX04AAaoFhgqjbeNG8Bux6tUyPZigadh/PvW17WconSFvwlQWm9TXoIvC1F5QAscO05inNyHMfTwdbg58AwXT0EAK0eI10F/4y1cbHn+hMFs6Ce4ky1CHv9mt3fBkp8b4uy67JZMDcZ04U9/GXZd8isz0gzH+AfiFeBfetSS5r1xVH0ZtDrI7GnlodMuVgfu2ap657quL0GpUosjmfAYfIBaCBdImufpy64yRejdfps13tu0Qr1bkFAvHk8lsw7uvxQxB8Q9KOP0qw6Ey15Afwfb/u3fBcjGNoT8knUrfoU6zs/YhbTlZp2DVVqXuVdYD1ExMzAPwKiRbRSokJla34mvr+EgC8BssGF7lTS/cWZoTMaMBIILMDrqGWGCTJxmLpvykrH/Gv1sD/6lipgBfn+oAMN6YpJXAMxf47N6jnZMzjOeIDQQ8LO2G6FXVNY+p6l7KOiqjK6quIcsYI+xc/f+gHOHCa4xNomV1ZK0gNUMzLoi2mlmyFKFkf6+yVHVtITPRrlZFZ+ZJ6eKNGYHjPrj6TXdbgNbbVP3+e6w7tR0xvaf6nq2vBzauNkKPezQPrhRTwJJIdHN4D44ii/IDEYU1pCuGvIjzuwF9vqweNXqcOBPSLng==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(6133799003)(10067099003)(56012099006)(22082099003)(18092099006)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yYS+/M0BO37tL7/bYQPnBzSy9JlTQB/kdxPJr3/OvKNeH1IZzrQW57hjGNGOb4EBwSSzzWP+Q8Uzl+pcGrTd6NsBudJtMFcA3KbVkSwXgV24CGducizDCCmsjDECiyNAOfdp6gg9lae0ut6SOoHwjcleEvLrohNnausGT8da/CWT93giPVls7J4rZhHju17CU0Xjrylhl1KRyY/yjzhN0J74TOQduOuKpoSV0JxZg//4DAgcHpJwtWZvPJKyInpbKkhjmJw6hzE2kmsrBGWr/zhtdQuhPysoq9sQF/meuytEtcL3RMOUixG2KNeZ6sFL0PRbdWbviEKkNnlLsC/ozpP7OfbI/4fki4nFEVSfp7T/rC4Pr9xv/h4iBtWSj7XxEp6dqng/6SmbnLQo4bAikiVmL2xq315fXn0i9UEZDesgfrM/eOSj3AoIug1oFMOO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:35:19.6313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4e7a5b-8c2b-4b22-dd26-08df03cab0f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8316
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

From: Tom Chung <chiahsuan.chung@amd.com>

[WHY]
commit c6417b87e7c3 ("drm/amd/display: Set native cursor mode for
disabled CRTCs again") made amdgpu_dm_crtc_get_cursor_mode() report
native mode for a disabled CRTC, by adding !dm_crtc_state->base.enable
to the DCN4x IP version check that returned early.

commit b7d7e714de44 ("drm/amd/display: Fall back to overlay cursor on
dcn4x when top plane doesn't fill CRTC") then replaced that early
return with a skip_fmt_scale_restrictions flag, so dcn4x falls through
to the coverage check instead. The disabled CRTC condition shared the
same if statement and lost its early return as well. A disabled CRTC
now reaches the coverage check and is given overlay mode whenever the
top plane does not fill the CRTC, which can make an atomic commit that
disables the CRTC fail.

[HOW]
Move the disabled CRTC check into its own early return ahead of the DCN4x
IP version check, so it reports native mode on every ASIC.

Fixes: b7d7e714de44 ("drm/amd/display: Fall back to overlay cursor on dcn4x when top plane doesn't fill CRTC")
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index c41fce07b8fa..8204ad4018e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -287,19 +287,24 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int i;
 	bool skip_fmt_scale_restrictions = false;
 
-	/* Overlay cursor not supported on HW before DCN
-	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
-	 * as previous DCN generations, so enable native mode on DCN401/420
-	 *
+	/*
 	 * Always set native cursor mode when the CRTC is disabled,
 	 * to make sure it doesn't cause atomic commits to fail when
 	 * they are trying to disable the CRTC.
 	 */
+	if (!crtc_state->enable) {
+		*cursor_mode = DM_CURSOR_NATIVE_MODE;
+		return 0;
+	}
+
+	/* Overlay cursor not supported on HW before DCN
+	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
+	 * as previous DCN generations, so enable native mode on DCN401/420
+	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
-	    !dm_crtc_state->base.enable) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0)) {
 		/*
 		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
 		 * skip those overlay triggers below. A plane that does not fill
-- 
2.43.0

