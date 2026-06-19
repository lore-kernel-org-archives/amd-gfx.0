Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF983CDB466
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44CCA10F5D6;
	Fri, 19 Jun 2026 13:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OU5UkiUx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B208910F5E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 13:32:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vlLvIJpEzygP4T0yEa81yvmGzKupOfGrI+xgpHdunoUJWauOyoqObGKStZS9RDNV+mXUuG+S8t6jaa25l5OYDGQo9lUC2OOdXpjIQTX8iXDXwQ9MRMCn+/GAoBsv1sYa2x2/+BldEKHABHBogFIifJLc+M00LSWAdgnlbiSDoc50UC/zTychQPk5suUy9u/T7j8e758YcBQ+P3Qxe1jmr2BxbwApmPCuIOZKBQqrjT+HftDBvjZQkvj5Oic3mnAF0RaaI8YW+LjTVdXcsiDvvKhzmqZQp1+43EZALnFuoB/kHD/PKT8KzPOec1hIeBD2q9cZASsZ5y5bbusWknWhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gByG/teILZ+9kF+1MwyMMX0/5LZE9WaPjelbzuDqUTk=;
 b=hLuI2EX5ioqkYKLMGHEbZ+xjsFwUkSFPqTtfZTAFX1qk1ro3NKcQScqcdN6Ux3Brjm3kQg700u6dRGoNlna9B4ctGhm1fYP1LtF0MZ1smauPZifvt6zvtB3vFzwsn6q6oF4zEgp0FQQJfX54Y+G8DOtBkxO+3slXRWfbFVGJ0nsELpRqnJ3Ywf83gKaoxA7+YY/UitOkMXY2lXILgLSacq0ljijmBdsTlaVOi774lWvzDXlao8IU3q3NwhYcs6mtjPoxTUKr0TbHw9ZwZcpxdGY6KEuhTkwgD1CECyT9jaX+SwpG0v0Kqnu5uXVw/T5Dg541gUnQceBV/wQDUW2jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gByG/teILZ+9kF+1MwyMMX0/5LZE9WaPjelbzuDqUTk=;
 b=OU5UkiUx3TpueTEIFdu5JwsK17H/NadJWH0yFpWr+5MEsAW8aHjSn7Zzp3gFc0jMV3bxxJxC5A9WkfwwUik7GMMCrVAzRWssQFHciVeKvDLEQYHrzqUUdDsZsDvUrzBlVE/DChAJ+qVkpFfzHQ2p/Ecx8gRrvmSu/GokIFGwCOg=
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by PH8PR12MB6843.namprd12.prod.outlook.com (2603:10b6:510:1ca::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 13:32:29 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e6:cafe::16) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 13:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 13:32:29 +0000
Received: from georzhanmkm (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 08:32:28 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chandana G B <Chandana.GB@amd.com>, Chen-Yu Chen
 <chen-yu.chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Fix intermittently CRC open failure
 during active rendering
Date: Fri, 19 Jun 2026 09:21:29 -0400
Message-ID: <20260619133154.116746-15-george.zhang@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619133154.116746-1-george.zhang@amd.com>
References: <20260619133154.116746-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH8PR12MB6843:EE_
X-MS-Office365-Filtering-Correlation-Id: ba0144ff-dabd-4406-6c5d-08dece0735e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 732q7nQVoB6vzgBWAPott4boqYoHHmPqIvdvyjH/sMEZaArJHOdtKI3H+JLFvNDQzLEsciZDn4gCohvDpKRpynknGIa0pY2oqekhj8Ia5NgZbq9Q7lkd/aqhJKQINttP68Vd0fp5w/IOshHnqt2HGnr5q6Bftt6LO6uEycFwDS/AWard+agPK9zEX/ngv7guV5ygDpmSwOP3R58YT6G47eK+IkZLgQ7dbJowZeaGKybw+dl7GiaWgXUqwpgN2PXA9ZRsP/yADlHaf3PE9/eRBdp3DSIzael1PtZq1iUa/EsC4tE7eliMtwkGJh8+L21qc9qVNTrVRXRD0JrKP+6kW1JeGURtKj9DzmNSWQsqKM2kA2kr8qWAtrKqiYRBLkE4MzGB06M9DnXZxeS4UGUP8K2P9uWLXEcyOolZUuFaQ+UFizWkfOZ6NxgTRPbs//CueE8ZQeqt5lT6w2oam4su0GVBLS4w4fU5xP9rnPE40zVJBBpjlb6gXVYMWNnmphY1eprkJtNeYT0+bw6Av/pfG9unQPI7j0h3xZi7wV6AlDSjLXPtf+lW9XlhXiEVMqLuM8PQa4QvBJ9/e1BI7LqUOVIQli4Q83rF1Cw946OS8S7f3z4Zpx+efsHcLs3MTxFZ//ztUYzFwtRrnLVHVM7RcGxm1fT4h7hdUu0b84E3uMKqZUHRI6UCMwJ9h6R0u15YsR4fbZnksj1rC03s2iiWuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rWl5dRI95lNGuUtlvr0JPF/BnPK54a5/YJ7l6ouVrrKbDMo61DXnMfGoCK/maWLQ5Cy8rW4UM1lf5HIiVC/CRGwcV5lqLOUElYTjcS1ra+b1OKPb0K4TAYITvmMwVdF7+/bUju44jLc7HVSUpIIfQCs6IOzqwRaKwFz0RTT0qDOdnpf2OeDyEDxp39spf3vO5lscyIggWXE39T96ND4Rb3a5pB1k5SDYwrkfaHPhj6cd7faIWa2FQcfwBE6k69THVa/ceTzpOHUt739ZLgeyB2Wac0rU8CgQx2Grv2UVlZ7/Nz4sqqhWZlsheJSWHPyCjld0Uo9lqnxolwN2Zt8rK4EpFPhpw6e/QkQpcxk075I+VkcB2rTmGFwWqskooqzbaIloVT1yHS0NeUyj322+EC4Wu/YZQX1gZ4xvdWc2k5xwANJyj+XVBUuYUEmWR9qZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 13:32:29.7011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0144ff-dabd-4406-6c5d-08dece0735e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6843
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

From: Chandana G B <Chandana.GB@amd.com>

[Why]
Opening the CRC data file during active rendering can fail with -EINVAL.

Closing the CRC data file with ctrl+C (which will send SIGINT to the kernel
and if the wait thread in sleep, kernel will send the -ERESTARTSYS to the
wait_for_completion_interruptible_timeout)
resulting in intermittently getting -ERESTARTSYS. which will just do the
clean up without releasing the vblank reference causing -EINVAL while opening
the crc data file in the next iteration

[How]
Ignoring the ERESTARTSYS as this is a return value for the
wait_for_completion_interruptible_timeout()

Reviewed-by: Chen-Yu Chen <chen-yu.chen@amd.com>
Signed-off-by: Chandana G B <Chandana.GB@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 7b0604e9216a..47fd849c58a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -681,7 +681,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		 */
 		ret = wait_for_completion_interruptible_timeout(
 			&commit->hw_done, 10 * HZ);
-		if (ret < 0)
+		if (ret < 0 && ret != -ERESTARTSYS)
 			goto cleanup;

 		if (ret == 0) {
--
2.54.0

