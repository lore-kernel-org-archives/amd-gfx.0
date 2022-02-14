Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005ABC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 09:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C79E10E2A9;
	Mon, 14 Feb 2022 09:17:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C049710E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 09:17:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wxf/kfBGMNjtm3FFXofrjdEzmWOdwLxBg+jrjWO02WmqR8am50EZEwCypyEEwpE8SGMoOe6KBdVmF8u8/kishLN/CV7QNXLL2YzLM5j56gkmmCk/WomRzqDsc3F/hxpoaOP0mPZE3HYo/eJSFXIp1Ki2K5sFF5qm9Acz0h6Lw/b/B3Xxa3VvQxhgLJ6FskpH5VzQWYetU2Z3+bzwgVrocNqbxPdpUtBbhYgW9s9ocuvv1r/j3DCq6hmfb1iAUhDin0xndkoh2oF7IsoUUcJNU7FiEPu/lIhqEZokKPbYoN3skb6F9XxIf98jKucxBEnIPP+qeG7bZE9JIGrVv66grQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+lO9sBBqUJQMpQA9erwXf92AnwiqaAQaZiuvQpR6Bs=;
 b=YQ+lGqtCwyXrzHvr7qUcTKgwOo3hnTviq+ioxn030r6VhJqa/rFHGYNdcBTazlarPwIH9BD4xvpoYV9vLsVVkFlapTy5R2LGz/GB707YpJbzlBtY7wGt5Lwa1q3oFlAPdYME/gVh7NgfLfbDyBhZM9eJy6LJiJ+Vt1jynPA6LNuU032jz20ZQ7a58Vdm2Ebpb61pky6P7gLKp5HL6UESVBft34jvq4OrPtrIDQTVUjclpt5p4t+oEhCbTzWAtku7Ea8TnI3RHC1Ni07Sv76xn0p1chzRxMZlRxwYRAZeNk6VpBZlci3UjntPJs/FXIdocsxIP6afAxO8Kbk9mRBZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+lO9sBBqUJQMpQA9erwXf92AnwiqaAQaZiuvQpR6Bs=;
 b=RqTcK3aXyHtvd9Lr33ghE3eEqi3pjoWha7ggzoySvC7Xtugw+ax4fTaPXGjzqFTOhoUyDRDfImnMwu43yGSb881pGWm6tScRMHd5jietvVvqV+MmGkkZhwoTviTRkJQUIlxVSuQNUuG0oq8+P/Hv10cfbCo/aHs80CV/Cge9XMg=
Received: from DM5PR07CA0162.namprd07.prod.outlook.com (2603:10b6:3:ee::28) by
 BN6PR12MB1617.namprd12.prod.outlook.com (2603:10b6:405:d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 09:16:57 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::75) by DM5PR07CA0162.outlook.office365.com
 (2603:10b6:3:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 09:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:16:56 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Feb 2022 03:16:53 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/2] drm/amdgpu: add reset register dump trace function on
 GPU reset
Date: Mon, 14 Feb 2022 14:46:19 +0530
Message-ID: <20220214091619.2820-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
References: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af9ac476-050e-43a5-20bb-08d9ef9abf86
X-MS-TrafficTypeDiagnostic: BN6PR12MB1617:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB16170188CBD12C201D054B8FF8339@BN6PR12MB1617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QB2wdFHrG2/ZXYi2e79AQtT/QZdJWpfUFWwy4veNq67ziMTZq0N8HGDNTrk8sbNE3Nw2PfXoRRvu0u2Wp2/ClHbhkDkSuPwCJ1MBQPzMbXWBsUDTCaQHiR1pyxkORX0ryOam/o3qclhKsy9lmLR7PDfjb7PMab6Upubiv/QoKHrw3v27+bNTu3oZh6SaNW76t1yBkG/uZxkKBl9VL20tbJEQQV/Fmn0JRrlJoIqeUgZiaSKWW6Rkjj6MySzxxWTnBreilPddEMOOL2gzMdA3IkU9S0RPC/KUG5xVnQuIzAkCIvYjZs+x0kvZJHabBQzvDKLcUdxqgITI43JqpeWRWCWsK8/UDT7q67tOe2zIcdZmUCjzdxBv4zXwkbcW8XmWcSOoqF/UK7OMIe/wsyKBFIu8g+4e8ixX3/3CpwTRriLPT9MfX4Gr5I4c8CgwIU0deuY2AuUah9iKZl9zaYjKYnDcr+U8PPY0xgoTDKAJPvCcdtsgWoBajOqyZwbz6MAnqF55nlxJMcCYfS0ewulX1+/E3hUaz1e1yE1KIILBcxYQPNyg8xR5hC+Yef4dndjh4+VIaymmKzvh0vKBi8aSJCTBCN3D+MwLYPj/dEW8SlTJ2D984dp3G1VAfq1lQMTlO+l6MtJ5ifMPeAb5Fekvv/8hn+iZESNZuJBoQygRRFkYT+7dkHJZDunsxwdqYNvp01FYz1VbwiX5KPDphPjYkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(5660300002)(426003)(2616005)(336012)(8936002)(1076003)(83380400001)(508600001)(6666004)(36756003)(186003)(16526019)(26005)(7696005)(6916009)(356005)(40460700003)(4326008)(47076005)(82310400004)(2906002)(54906003)(86362001)(316002)(70206006)(8676002)(81166007)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:16:56.5938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9ac476-050e-43a5-20bb-08d9ef9abf86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1617
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
Cc: alexander.deucher@amd.com,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 christian.koenig@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dump the list of register values to trace event on GPU reset.

Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e651b959141..4e11a93134cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t reg_value;
+
+	for (i = 0; i < adev->n_regs; i++) {
+		reg_value = RREG32(adev->reset_dump_reg_list[i]);
+		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
+	}
+
+	return 0;
+}
+
 int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 			 struct amdgpu_reset_context *reset_context)
 {
@@ -4567,8 +4580,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
 				tmp_adev->gmc.xgmi.pending_reset = false;
 				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
-			} else
+			} else {
+				amdgpu_reset_reg_dumps(tmp_adev);
 				r = amdgpu_asic_reset(tmp_adev);
+			}
 
 			if (r) {
 				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d855cb53c7e0..b9637925e85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
 		      __entry->seqno)
 );
 
+TRACE_EVENT(amdgpu_reset_reg_dumps,
+	    TP_PROTO(uint32_t address, uint32_t value),
+	    TP_ARGS(address, value),
+	    TP_STRUCT__entry(
+			     __field(uint32_t, address)
+			     __field(uint32_t, value)
+			     ),
+	    TP_fast_assign(
+			   __entry->address = address;
+			   __entry->value = value;
+			   ),
+	    TP_printk("amdgpu register dump 0x%x: 0x%x",
+		      __entry->address,
+		      __entry->value)
+);
+
 #undef AMDGPU_JOB_GET_TIMELINE_NAME
 #endif
 
-- 
2.25.1

