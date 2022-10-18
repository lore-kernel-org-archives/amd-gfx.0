Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 08:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F81310E054;
	Tue, 18 Oct 2022 08:45:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2070.outbound.protection.outlook.com [40.107.96.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B3B10E054
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 08:45:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLQ5a6be3w8/Dyoor+iblIxWl0Z3oXdZDKRu5BQZQD6sMXMjg7WRYf7HWS7DtqjJF34luxigrIh5JKvKJzJ3nVct2ZOzPvCCCtZlkmY/v74kJjvImeayUrGf2KMxrmguvM8adhFySHbMezrl8P+J/Gf1STPflfLGm0/NKj91RQdAPDhcnBtnsYa7aavZmQcKbSf8uCa6ljoSHPTrsUKORzL6tUhpIBwuN6ql7E7ffoFXDD73nZp9h81tREXID5jo49fjWcRGoLlD9YWaZgGBGFUuDqQbfeklBQSIBfyCCPm5BH5tB6D1+Daa6QoalGUGeS8SzTS74cFFU1t+LRlwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDAOoFyQzlzl9WC0i9pDHI66jaY7x792NWPLPwoM6qY=;
 b=J29nEoVAZPb6Ud5ovtoxk6dxguEURz/0QE8QHIprBR6pj0csAXnxZCqPksuRDzJtNgO/lofjLZe7ZFPEZjK42RRHUjeNcdWNXFs6iY9DO19nRn4m67sbT04cPu4zBRKyMYYK9d3Egrnl7aXTak/Rk7JX1wfCAFb2awxq6jL9OZD/QwIc+TXx4WdV7YL0SbbyhRItS3N/mnYO9Q+elF6lVonagoaETrPrl+WyzfMtuwTFyg5aoHZc3ymtouSXrBmQEcMysTyB/2XKwerOybEmaLYfqGJkUODM4pYM0iqEQvS0msK1AtJeAxLNtawsTDT75ARn0JLpnT/e8tFVY1EOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDAOoFyQzlzl9WC0i9pDHI66jaY7x792NWPLPwoM6qY=;
 b=gFPAVOZrdCMPdiv7zXdrodCzxQEilaiwZ7DvsJanY6DDzPkMinm9bw93s6WED5Kude9zyT/pjhNZU39+6gu4RvXC8oBEMKLCiF/rMSU5rymAk7HnV+VpTULCC86sf9gQhhkFumj8xJzGLPnAt45ogBTN6rTVPERg9nrpPqGMSas=
Received: from MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::23)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 08:45:15 +0000
Received: from CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::6e) by MW4P220CA0018.outlook.office365.com
 (2603:10b6:303:115::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 08:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT106.mail.protection.outlook.com (10.13.175.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 08:45:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 03:45:13 -0500
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 18 Oct 2022 03:45:11 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Adjust MES polling timeout for sriov worst case
Date: Tue, 18 Oct 2022 16:44:44 +0800
Message-ID: <20221018084444.884671-1-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT106:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d4b27c3-8b6d-4488-2b68-08dab0e513b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpmvdWNisZ2/TpSjfue5rdTZGlcL+bilb57x/WTj/kol6tq+RjAa8z7XB3WOa8zYBaohChTtXk6WbsjyrOL6jHGlCMwCRtQHiFHiQpJfgNOr5PD257J/gT5akSzRHmeVSvkA2Bt0y0XkeJKkMeCfhVj+ii7yrX1EJamvHDX7KuZsp47MQD4ky9UMjpIZOZcT0Jws95qrvUwGsDXuzBzlgPVhAcalNYyriXa0w0HJhdkTUunPM5ANsS4TJzULVos+wEIHgruxz8jxJXr6Gi+gkfwu0+bA2EX/5gRJH0FimYifH2zafZRJ67+IpC9CAFEvnVMGeNmK1Etl9ZPlDdzPPbpF+ifZRS513leWGS1/tZB5BcjJYoowvPMo0PNOL2VSp8ExtxnB/N8HO4xaGccM+dPwN4soeUz85hpJT3NMWZmcmm0Jhu+on2zZRnWFy1tr4RYp+vSrlS7qVblxPh0spLI/vfmXf2dYhP11hI5eEmuBlQnlMS7rBAiqiAGBJVcpu++zj0HyMckl+Lgb8kJ0fHOXtMnaHzERjr1w2nDlCNx7muTWyqKWlzQefbps55CoTld0ha+L6C9aZBMReKiC8kxJN0+DJRPymO4sqEchbR/hc9EN2B+f+KpsROGsj7SpUBJlFcSRcNSiCBA/zn/nrIlmOpgOLEizcJCxRE+gllwoc9PwUhUtWqXUNkvrM5gYGFkBm2lQ+x9XTdRN3MNqE9pWPpNTHjx4tLEsdmx3Pzy5ematddhWUfR1z8UXTZjWjezbFtelSjNbRCAcEXDTl/kW/QJzMK+hOW1aA3hhLtvBettvpt+AVN6FAhZbdGgO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(186003)(47076005)(426003)(36860700001)(336012)(2616005)(1076003)(2906002)(82310400005)(7696005)(6916009)(316002)(54906003)(5660300002)(26005)(86362001)(41300700001)(6666004)(82740400003)(70206006)(8676002)(70586007)(83380400001)(40480700001)(356005)(40460700003)(4326008)(81166007)(8936002)(478600001)(36756003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 08:45:14.9267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4b27c3-8b6d-4488-2b68-08dab0e513b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com, hawking.zhang@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
MES response time in sriov may be longer than default value
due to reset or init in other VF. A timeout value specific
to sriov is needed.

[how]
When in sriov, adjust the timeout value to calculated
worst case scenario.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 1174dcc88db5..a207b4f29e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -98,7 +98,14 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	struct amdgpu_device *adev = mes->adev;
 	struct amdgpu_ring *ring = &mes->ring;
 	unsigned long flags;
+	signed long timeout = adev->usec_timeout; 
 
+	if (amdgpu_emu_mode) {
+		timeout *= 100;
+	} else if (amdgpu_sriov_vf(adev)) {
+		timeout = 15 * 600 * 1000; 
+		/* Worst case in sriov where all other VF timeout, each VF needs about 600ms */
+	}
 	BUG_ON(size % 4 != 0);
 
 	spin_lock_irqsave(&mes->ring_lock, flags);
@@ -118,7 +125,7 @@ static int mes_v11_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
 	DRM_DEBUG("MES msg=%d was emitted\n", x_pkt->header.opcode);
 
 	r = amdgpu_fence_wait_polling(ring, ring->fence_drv.sync_seq,
-		      adev->usec_timeout * (amdgpu_emu_mode ? 100 : 1));
+		      timeout);
 	if (r < 1) {
 		DRM_ERROR("MES failed to response msg=%d\n",
 			  x_pkt->header.opcode);
-- 
2.34.1

