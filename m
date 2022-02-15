Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6605FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 10:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4DD910E43C;
	Tue, 15 Feb 2022 10:13:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBF710E439
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 10:13:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwsBAQ8zz83jqd9i/1S/OvcM6TJKAom0Q5nzitWdIgP0dx5gFiu/FFsn8h8nfYSsR3RNu0hw3LEreLg8D2oLER/zsP8r4RHRTBKvQAt23IK3J4yncdSbxAIysdcExNtoZ5XNERzsf/r2iFkTYeGZiUOdUt51SES8kARRPCEoIHPCWrF450wG72SAlfZhBf1lXz2RPr8Y4egfHGIzcKaf1dE3GT62BKaEiKSrfjz6ZNV2/F/oeK0HVOFS8LvVxuWKKE5JJIqQ+hI8vRDZBHeJQr1jNyvtslOQV9G4QOipmDci1nZJTxTtgFycYrciGvQ+G0t5XM82oFxKAJ5oUA6T2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1XhvrH34p7MSgascxfewsRtR3gRzQNoz88uUL1J9pQ=;
 b=CsM/V8Afh4z3A/E0U9MO5QGrRMxAD4l2W4I3FFmcRC/fBo/bMKYzbqFI3lZxURi58itf4x+GG3/ITPXvE1Y48ERqcs5N7+QnLEWaWgvvokVGAW/juWE6oudtX8ybPHHyqDGBDp+uKSE5bjh1M3FZHT5/4D7D0glI+YAogv9SjdxpzVEJyeFuJPfLs/q7Wpw7HWp5NSBnBImW4EjQHCr9L5fvQBMDs3BO9vEK4WjDle38qtxoXUGwpBJIiFenr1BmrAMF8nViFEyiM/fkzNWZB9eJNn6xt19mGlXwZwDTyZhBndh3YbJvgkoLoohqLS6k4iGMm27cda7g2VZjQvkmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1XhvrH34p7MSgascxfewsRtR3gRzQNoz88uUL1J9pQ=;
 b=ntYx0L7c+y3mqmOfogujqAVotIVfhmg1i+9gcGUGGxmes5lu8qNkS8GIZNtdcNWb1G7dSllpOPnbLjw76nhYaMDYJZH+QktHv7g+zw78iPNFeNb++5E16pDK4iMioatU5V6lHQOYqnuEombzSFZVDrx7cC8d3XSo8IeMM2IaD+c=
Received: from DM6PR01CA0020.prod.exchangelabs.com (2603:10b6:5:296::25) by
 CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 10:13:07 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::4) by DM6PR01CA0020.outlook.office365.com
 (2603:10b6:5:296::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 10:13:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 10:13:06 +0000
Received: from amar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 04:13:04 -0600
From: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 2/2] drm/amdgpu: add reset register dump trace on GPU reset
Date: Tue, 15 Feb 2022 15:42:28 +0530
Message-ID: <20220215101228.9433-2-Amaranath.Somalapuram@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
References: <20220215101228.9433-1-Amaranath.Somalapuram@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c1460f7-383c-4d09-5813-08d9f06bc2c1
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18293B22E13C5253650F1EB1F8349@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYKasHGlZlfjK6hzSz71XQ7bYJQMaJjUx23gFeL5HfRwdMh6keLo1ni7yegw2KU8A+DbrSmsm/bAcMJ10C1dS83w0jHe8SgHEnuvLiPQQhp5KdDTFrBwVEB6abXo4Ys2fAZlo6o4yc2uhE6dLjBjbILQRKoQDkvpQYzRbuVJYkOT8l6NAK3N2iCnbnwPviEf7BsjMydSB7cMJJ/qQFMtbGdWFoOp4p0JZa+aGOwuMHhbRUTCDgx/iswS5v8wLjgPXRLHGcqPU7eZ4sBqE2ZK58cXCnojkuWtWeB+g1HMJDq7a93tRvUukgSWs8DZFf33kdQZ5No8KsVp2jqqcsMHXGpotEp3FEOyrZcs1xm/PLq8PgiugWvXcwF35to53/AvORFDwA1xVMaHyZPfNOOsH6JJikshqXl5b9lv/bKLdbHb8Ce6W3/O0eQ0VfNbetjy0LkDFH5p5gGdF3W2WY7oJgrIAxVQE1SgKTJGEtBoM8Wv+zqSVaQtTuwqnLJ51iXMy8SSnDk9zDl+23qixt2v5iKcAVzfuHnK+/egFtFdUqfM+o/h5nb4gAyg07TDnRCga7pc74wybYtUVlhbx5wKOQyD6E3FiLzrBOA3rnJTFF3GVMrCx+z+FHtXD5O3OJxe5dRWElgiauU5CNHZpHqsZ7kKHWWHK7EX0D+jbjEkjTvP6/QM+iNtiOnv1k7ObHInV8+kG8Fp2ZVdAWrEhVAtKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36860700001)(47076005)(2616005)(7696005)(508600001)(83380400001)(82310400004)(426003)(336012)(26005)(1076003)(186003)(86362001)(8936002)(4326008)(8676002)(356005)(70586007)(70206006)(40460700003)(16526019)(5660300002)(36756003)(2906002)(6666004)(54906003)(316002)(81166007)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 10:13:06.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1460f7-383c-4d09-5813-08d9f06bc2c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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
index 1e651b959141..ff21262c6fea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
+{
+	uint32_t reg_value;
+	int i;
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

