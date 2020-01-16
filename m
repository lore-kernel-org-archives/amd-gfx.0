Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E9FC33CB1
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A742073A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 10:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aqRhvtiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A742073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8FF6EC7E;
	Thu, 16 Jan 2020 10:01:12 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910466E218
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 10:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/gl58YVNeP98d0xFR1IpE5ZNRKGvgfnGKPa/KrMc4cRRrqGhUwskdFK6sJLGDxEKnXyp5v/m4jn4UhA8P5qBrS15ETaJol+CFMR7xvHrILq1zhFCVdzdnYK+xPqxuCfmCS4m8Vu2+FZOq7pMsaPRNSzBNlQ0WKif+orHVDA3uV9GzM68nfeTUgtA89uMRkOWXojC4Q8uoeTfnVOwAVYnxI30WHbkBUdevBnQVK5Iu4JIsVmRFkvh3Qy4ejL/1b4eJyk3djx0MMqy9V4Wn2YdcWEaeax3anK9qfco33lzEVCbo7J3LoZEkXCkzGKyK0ykhFtqe73r8hACIBc6rtfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOaLcpT4JmrlGXQkojs9kwu/e1bD4W7xEr/nTkDamYs=;
 b=GCltwpfa4VFSWRhYy5V8pvy56whBJ2ZjubeAfDLYKkw9iUw3JyuHafIwGYeAUD3sETJZJJcpXhsE4STwFK8xWU0kTY0J1/nlFY2BZoMkbQm/gmz1UQAMu/ujx/k5fs3H785HiAiwmIaWve2v3jfsM7aeq+al67+NFG7H2TpBCSfqZ0xyVMjbI51pmSsnVZnfVDYuwXsJYfIgUg72dWhyImNm/VPbrVbN76jZyF2YZBzI1uKES7indTdM47a55Cu6QtgowqsA/yas+JI5cpqEnZDNIAmjylEcu7mJKVuff2RNM6dxsFulz0/1fkUk5/cJ6e2MhmaPJqiEchBgYp5Lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOaLcpT4JmrlGXQkojs9kwu/e1bD4W7xEr/nTkDamYs=;
 b=aqRhvtiLYCcHlUQjl4413z9S8r7SrUbPzWR1WnfgAW6PDpn5RNv95B1PN83FWJj4pfqNKk8kuZZkX/8iwmU/dfyQjm//RhMFqzFphxzPgQxN9CqW8MNcD1urQjggdrZ/r/qwwtmzQ7gvPfHg/xuqQDdnkcIS9v+X7tIBRLYGFR4=
Received: from BN6PR12CA0039.namprd12.prod.outlook.com (2603:10b6:405:70::25)
 by DM5PR12MB1196.namprd12.prod.outlook.com (2603:10b6:3:74::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.14; Thu, 16 Jan
 2020 10:01:04 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::200) by BN6PR12CA0039.outlook.office365.com
 (2603:10b6:405:70::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Thu, 16 Jan 2020 10:01:04 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Thu, 16 Jan 2020 10:01:04 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 16 Jan
 2020 04:01:03 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jan 2020 04:01:02 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add kiq version interface for RREG32/WREG32
Date: Thu, 16 Jan 2020 18:00:55 +0800
Message-ID: <1579168856-6437-2-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
References: <1579168856-6437-1-git-send-email-curry.gong@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(428003)(199004)(189003)(186003)(5660300002)(478600001)(7696005)(336012)(86362001)(426003)(316002)(70586007)(70206006)(6916009)(81156014)(356004)(4326008)(8936002)(2616005)(2906002)(36756003)(81166006)(26005)(8676002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1196; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51eb2cb7-9db5-47f0-c2dc-08d79a6affc1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1196:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11969224008DAADC89EF38189D360@DM5PR12MB1196.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 02843AA9E0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QbAJ1DX7CxUKmz93pr48KGAHSVjXWLmpOVhe4/ezg/x7UNp7XrNWE7H7PhsbQHYWfq3w91DUvFb25YAVNvOPcuiW+qXN1MTMKUEQWLCD/4jefTz90VWpZzrQFYbH1xzgUOjGaTvsEv/oou5ztlFXcbtmZUqI/VpYQbL/lAaQZItgjSGCGTSgkg9hL8KrwSprrfghj5wb7/UV6zFecrX1aTZ2jI6vQTV/VbgFNDb8ItxOdEhVtTs2Slw9aB2ojNBPiJCdQFUkOK21B4TyvdW1zI2mwamM2ygyAH8HRUdW0Hz4kgH0RMkhDoWFFcWqHLHeBooCIFa3RrHz+m3OEbBfzN/Zk0h0eicNfJX4HMEhkAIa77+62y+IEoPlTdIldkSVa4fHVNcDqmAhcDAN4XES0Mzvewkw6pdghbjLrfRevMXkYGYNp+LN8rBIh7qkU+m3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 10:01:04.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51eb2cb7-9db5-47f0-c2dc-08d79a6affc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reading some registers by mmio will result in hang when GPU is in
"gfxoff" state.This problem can be solved by GPU in "ring command
packages" way.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 63eab0c..b4b00e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1016,10 +1016,14 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 
 #define AMDGPU_REGS_IDX       (1<<0)
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
+#define AMDGPU_REGS_KIQ       (1<<2)
 
 #define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
 #define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
+#define RREG32_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_KIQ)
+#define WREG32_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_KIQ)
+
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 963ea46..36c0f9d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -217,7 +217,7 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 {
 	uint32_t ret;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_rreg(adev, reg);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
@@ -295,7 +295,7 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		adev->last_mm_index = v;
 	}
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
+	if ((acc_flags & AMDGPU_REGS_KIQ) || (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev)))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size && !(acc_flags & AMDGPU_REGS_IDX))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
