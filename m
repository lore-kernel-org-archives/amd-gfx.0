Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439EDEB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 09:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD83310E51D;
	Thu, 22 Jun 2023 09:39:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6CF910E51D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 09:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSQ+ZMLOUiL3I+EDQfl+jJFvCYbYp6U1W5mLLJYs8OA8CCiZ6GlT4vws3xsHyvpchel4nfr0ZbFrQYejpPfNP1fcvRQV2kWIZuCdET70iFIRViJofnv0Dgrz+/jmzx7i6/yEnmpsM6NUeXfPuZCElNxGyzOv/oFkSgNzh+Kf1duG4LuPHHiV4k+8RI783D/tvVi+tlTQl9OyTqBoa3OegYvP2aQXlhMAmfWwD/5XAgaKnvib8h26zRpVoQHMjepU4D5F4xDjciCaAry+XdsZfnMadLkcDRzDaJQzbuTtmaLCt8eDVD7E05ghhmIai9Jvh7q+o8fAMU0sQ687TryMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDfbKj6HbGZdBeDy7xqd5126AuW6i0RrZ2pivKs2CkI=;
 b=NIV0l3LLV2VJCItrhAgnhDa932oEunavw85QdP+srfconyoK9Yf/tRJekuEBxp5fwn7uDXKZK2SfIA9KhaZpR3IqC70GOVmQCwknXoN2LqbLKCxT8tx4V5Zx4k43SsbGksRkmtr3yrT2bd8KAWu0PwUpl7wLEMpD4OJECLTydOeT4+cqt0fSR8brTHTuDnVpuBDqgs2DQkgrYFQzgdSPG0JkguVCC9s97AJhgNTPgH75+JkSaz8ehyB8oD4905l4kHyBNy0SKyACHyWYG/VcS/omgmFyJjZy4zdUkpIcUvaV6J1ciq6ESFYGwAURPT2e2pDD7tEkLoPa0HxWru8ViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDfbKj6HbGZdBeDy7xqd5126AuW6i0RrZ2pivKs2CkI=;
 b=s1dtaKFFHY7+z0WazsLkevpcFS3whOmd6KgTGEtZyOfkbPST7BIDvoFB40iU1xHXnJtp1QGfpQwwgrVtfs1tZSKxVtS8Jns9z3sv25UqodpHozfOSfCtMeiRA+N2c8jyngjajhwf3d+mrCiFhFH+Qt0RYTeZsYke5camtcWBKOI=
Received: from SA1P222CA0170.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::26)
 by PH7PR12MB6633.namprd12.prod.outlook.com (2603:10b6:510:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 09:38:59 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::f8) by SA1P222CA0170.outlook.office365.com
 (2603:10b6:806:3c3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 09:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 09:38:59 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 04:38:57 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant braces in
 'amdgpu_dm_crtc_notify_ta_to_read()'
Date: Thu, 22 Jun 2023 15:08:44 +0530
Message-ID: <20230622093844.1088508-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH7PR12MB6633:EE_
X-MS-Office365-Filtering-Correlation-Id: 57daa6e5-5dc9-43e7-ebd0-08db73048190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RrqbwSZLVSjmnS8EYpG+6cfvQLZ9bTBVKdSPmFA4qjRsU1pOvaxEFNWiUt5Wobl9kEgRjdooci0F3zvavyx/L1Xo1PFtB2Wse/n+mbMguSo9PD2b31hz8/CYtMcysQiHNl6PtcgjN3rmEdt1FwOfDDQMnz96Y8h+N8CIsev69sdJ7ITrCOq6wfSafKZ58vUXw/403xsYxNvFFso+j1b7UOUai3ScqIx8iK1KAg8ZKvsm8Al4k/jmWggE6EOt6Mu1acHMufsIzQdcEaHlsqou0mXSjaDSU2joc1O+da9D1aMA19ah8EcQDzFAGUKBF1v8md7DLQXESaxyBiMITHYMtzwXHH8xjl5bcswQBCcrWjAEf+68U9UTZVsf5bbGPc0hIcpFqQXqsxdkg7m4wUsgJEed5bfiDMNdnqIo9E4hFGw/2cv8Y9RCuWvDnazQ4mMQa/ogH3aAgomj2Nz5k1YTmAQbdTVV955Tg9fUPU9ygRbuIz+zDusZb8vdq10fbfvQMgm6fX70ZPiafqHvpo+qe6/zNaijrz4G23DYgv2tYUcz4FRfBi4XEMBiTdjpIqhNBmTkLps5QQLkUN50I74J+fe95M6KMEQzjW3Lw29ymoZ1G8xrgOP9sXGLr0HWFREKNVUv6+/SKb9f7DkJBBi3AXzBYI7Zd+4RosJTt+cathzSPZrwFVTjNYRXCkdzRPG2bwrcz/9PgkLxYEfbLBvtfEy/rQjXItWIAkBQMcwCx+uivWSE2qg6YPNfAFepjonMOs/ExNZ60GkAkqWTq7KGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(26005)(2906002)(8936002)(8676002)(86362001)(44832011)(70206006)(316002)(6636002)(4326008)(70586007)(478600001)(41300700001)(54906003)(110136005)(5660300002)(82740400003)(82310400005)(83380400001)(6666004)(7696005)(36860700001)(47076005)(336012)(426003)(2616005)(40460700003)(186003)(81166007)(356005)(1076003)(16526019)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 09:38:59.3097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57daa6e5-5dc9-43e7-ebd0-08db73048190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: braces {} are not necessary for single statement blocks

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 0802f8e8fac5..52ecfa746b54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -123,9 +123,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
 	crtc = secure_display_ctx->crtc;
 
-	if (!crtc) {
+	if (!crtc)
 		return;
-	}
 
 	psp = &drm_to_adev(crtc->dev)->psp;
 
@@ -151,9 +150,8 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 
 	if (!ret) {
-		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS) {
+		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS)
 			psp_securedisplay_parse_resp_status(psp, securedisplay_cmd->status);
-		}
 	}
 
 	mutex_unlock(&psp->securedisplay_context.mutex);
-- 
2.25.1

