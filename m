Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED6C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 19:36:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF7410EAEC;
	Fri, 20 Jan 2023 19:36:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E537A10EAEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 19:36:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVyKyOADd+uegwjpj7y54mPQe6lDpLEdgpXJVt+PjHxCKriiUCh4U1GjybJpYJFfEbLdW0tklIR8d2N59HrCL6lPNBscnDMle8OIyBrV0rS2AmHaTNhDQMF2cZDtlLbhecvsg9GxfNtGQk+nmeTER1aD0qZ0Yaq0Ez5KHUpiC0OFz7RLjRdXPvH/Cn87cg75lCahB/3QjFtGEB3Nhuo2uEN6gnpeawCTCP9mJ6zANyf0M1pRlKPzcFZcgZKLukRKZhV+wwkJOBSLXhPVcO1S/dzurPlCb0376yi42Atb84AT8rFVXM0zrXDAxGMmrypWTrFP7fbYNFl7/RHT+pqYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mK+fNDV3La5JehxeYEiCuLgYsc4AtHniz8D8U8Wkd5g=;
 b=mLtrLEjMlIHz3MZxE12Ps66YFoVI3iJqsl05ucfO5Ps9/wakDS36/5XJ3tyNXaYnjm9BZ3qvFSd7xTebej0/8bXfPwdPWWVmSMvRQxOY4oqogaoyDkdvCP8BPWYObj3hsilLfyslpUuDlqF/pF3oH6Fz8yX6WHb1zQfsD3qu1c+v2MYz8lNxRHZNnq/PHTK68cgMq61gyrH1p8y93UABcojfa/RKZCmCpjU5BtMdLURDFoaD3H77Dw9/JTcIChBbG03vl0eeyYWXGrIrfcvWmGgNlINxWU4KJ7Frxlkbi9wPswC7OQ7/Rc5vXnG8uiJGb2lywPfWdEZeufoQhmrmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK+fNDV3La5JehxeYEiCuLgYsc4AtHniz8D8U8Wkd5g=;
 b=ow0rlSpN6auwpBpoEOy9jrQtuZvspAwgnLQgmSrU1qon343iGKDuqifoJKpP4K7NdIgb1/Uv+xV7ZnxgcV/tQFddc2Wkf/Kbgc91BqRwh0gqEGMUawR2SyJU9Pe1TqbxTCkWcYZVkn76KctV4W9v3naU36a7bekKA+4t5QTGyVE=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Fri, 20 Jan
 2023 19:36:22 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3c) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26 via Frontend
 Transport; Fri, 20 Jan 2023 19:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 20 Jan 2023 19:36:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 20 Jan
 2023 13:36:20 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 20 Jan 2023 13:36:20 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: always sending PSP messages LOAD_ASD and
 UNLOAD_TA
Date: Fri, 20 Jan 2023 14:36:17 -0500
Message-ID: <20230120193617.47673-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230120193617.47673-1-vitaly.prosyak@amd.com>
References: <20230120193617.47673-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT018:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6828bc-588a-4363-ea27-08dafb1d9bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FK45i2OEqkdOAt9i6sO17/wo4WUQA5J5oTBn1VFknKAV3uxC9rs603JqsbtZzPOi5GSU/C5YTBkYJqOhc3JbbuNwoHVRSjWJZEqgqglWrmeZTY1JU0Q+o5dwfJUiwXRAo8t0KGz7ItkLvANrAUG9aRl4kqfTSYjMv0igQsS3VtyFekuT6GPITmRfNX1OHotBbLhSebxdAUxHFOTASmtDD8EHxr+2i9I7sgQrVXFncTwL+NNJGlbhMBNzQmdj/SeOUUCpjhwOiNQdQ3sixhIfyXzTErSWD4RqbET1XRXpV5/NrkNBpRL08xR/ad9IvJMqBp94np+knGNXoPWHsvGLIKdBIvrTwd92HkVTciPSeU26T+H3cLGto9Sl/my6PIArhT4r0XR7kEaakOebCHrZGeZphM5eU/P9ktabYG2SX9gGT4I/dNPWZ6aPUdRDvzKc61K3Jp5ep6Rcad0OucVmRS+dqdw3nv6wR66nj81KWjXIhc7++lhl0y6/nnU7w5xm63Bx+PA5r0zqD4obIuJ1mr/ivdln6sZHUZEst4m6a/B/pSsjao4+Ta9fHqrYBYC3NexvmVyFXLm8+5QaWHKIy1s2J5mWhDUmNQoXprtGEONz3/cwxrVh4x7yi3OXbBQrSE86bq+mjvDeHTEIw8gmHOmPjcT0U88+B8ygJwtJsAUjbk/7IUYncTvKD2xQxC715e+IG9t3FrLYd534Lw3WnPQmrB+TAJyd3AV8y3rNRuLlKelZfasAED/A0ZJMhZGL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(26005)(186003)(316002)(110136005)(6636002)(2616005)(478600001)(36756003)(7696005)(15650500001)(6666004)(86362001)(81166007)(1076003)(40480700001)(356005)(40460700003)(82740400003)(47076005)(426003)(336012)(36860700001)(83380400001)(41300700001)(2876002)(4326008)(5660300002)(8936002)(70206006)(70586007)(8676002)(82310400005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 19:36:21.3513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6828bc-588a-4363-ea27-08dafb1d9bdd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring a lock
in drm_dev_enter during driver unload because we must call drm_dev_unplug as the
beginning  of unload driver sequence.
Added WARNING if other PSP messages are sent without a lock.
After this commit, the following commands would work
 -sudo modprobe -r amdgpu
 -sudo modeprobe amdgpu

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Reviewed-by Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a8391f269cd0..7ef18e062c0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -606,12 +606,21 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	int timeout = 20000;
 	bool ras_intr = false;
 	bool skip_unsupport = false;
+	bool dev_entered;
 
 	if (psp->adev->no_hw_access)
 		return 0;
 
-	if (!drm_dev_enter(adev_to_drm(psp->adev), &idx))
-		return 0;
+	dev_entered = drm_dev_enter(adev_to_drm(psp->adev), &idx);
+	/*
+	 * We allow sending PSP messages LOAD_ASD and UNLOAD_TA without acquiring
+	 * a lock in drm_dev_enter during driver unload because we must call
+	 * drm_dev_unplug as the beginning  of unload driver sequence . It is very
+	 * crucial that userspace can't access device instances anymore.
+	 */
+	if (!dev_entered)
+		WARN_ON(psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_LOAD_ASD &&
+				psp->cmd_buf_mem->cmd_id != GFX_CMD_ID_UNLOAD_TA);
 
 	memset(psp->cmd_buf_mem, 0, PSP_CMD_BUFFER_SIZE);
 
@@ -676,7 +685,8 @@ psp_cmd_submit_buf(struct psp_context *psp,
 	}
 
 exit:
-	drm_dev_exit(idx);
+	if (dev_entered == true )
+		drm_dev_exit(idx);
 	return ret;
 }
 
-- 
2.25.1

