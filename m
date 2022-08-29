Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFADC0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6E810F335;
	Mon, 29 Aug 2022 14:32:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F19910F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjxdFLl+vy5HSk9PtwOraVfEKZii5PrlSCXu4zIzdL8QXpJZv4unEWpF8YZ4lPjMyxY2zoqSYgVLF20WWzF3kgW7ZJXgU0BtlISXdslWk5shQn6u3I77fGsxntVuLXWK6YYtFPhrY4LSv42IS0K9e1sLJkQoojJ9KFSxXRaYM3/A5Rx7qrub/yBMQ142PEp0S3mvcMxDNm2jsi0NXW0hm7vVtdCyFStJaI57N+eHA3f9HJt5Qnvi1aF8TZ5jEJ9qIjsRFV90VhmcddI8Au8Yr4P1dpd+RxeAtdxoBZYcLVntpe04meHJsFYspEIIbPgqki4V2mo3scF9mjxoE/S8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4N07NuZEmZNeWv7Eh7DOqcEBSChBLNDOu5/ixaadLU=;
 b=lTJSiTfAKu3PKKJC0agUTcX1TPD9oJSUFMdx5fyhRd4jC6fOpR9O3Jr7X0fwlg1aZhCMB8ym8S3KY07SidZCu8mJos29/soZ7q7qoaZ7AA72QTUoi4vrNjna1OcvpLTT/R3deUwsZezixo7m/7L/QWUMITS3ecvTmHkLgROM4NEnoMhnSOBazaw7BR+2GoYEdNYbbXiSEP+DyKy8f6zY8y/DaegeQfMHH2Anr5OJ0x9M2DsJbLgulpox0zEphJ4cc7a8zYSiIrtk9mlH49WiTyfRbg35tpOS7NVNhiaRwi+LeRi7fX48W3UYbbiHVDUO/fivudJLS83b7OtZt6W0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4N07NuZEmZNeWv7Eh7DOqcEBSChBLNDOu5/ixaadLU=;
 b=PqLHsa0504w+4UFN/jBFzCNjBr9EAAvcM+K4X8GiGJtBYwMJVYdZCpgBHkxlUJAC8Fv0Gg2oZyvXdA6iJA2RhBV7IoNcXrdcN2ijblhqH7xCPv7SrawgyvU//BCtjTY6zIqezqLRdVHkeQ+sZMmJf9hqm+bCsnhQ/GPTZcZWmfM=
Received: from MW2PR16CA0009.namprd16.prod.outlook.com (2603:10b6:907::22) by
 SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:31:14 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::6d) by MW2PR16CA0009.outlook.office365.com
 (2603:10b6:907::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:14 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:48 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/29] drm/amdkfd: Add debug trap enabled flag to TMA
Date: Mon, 29 Aug 2022 10:30:14 -0400
Message-ID: <20220829143026.1509027-18-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c905e6-3d84-450f-c2e9-08da89cb20c4
X-MS-TrafficTypeDiagnostic: SN7PR12MB6863:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIiNP36G0+XigJcsBAlv84QzHFdQSB10EMEIOTH0Ik3fX2+1oBgtw5DRx0VbDc8Co+rbNWoF+vpuORZNphkriPwK96W9SAdvxClZcFmuDZvv7Jeb3QD8pjrNAnTxPmrN1dUZOf7AKeDBrSsRXkwfkw56IbQ62GOyVj8ayM3aeBXlV5LFL5QD1Kd8tn6xhAXbPLWjlRI3MF1Tg1XTJZFzOplwqU0+GD40TABj5j3TUn1/CTSjEYXgGYQrUmyOYxL0gfBTHUgvbejAefS0Zsy9x2pHA/J+FloLQoElDCcC1vqnObdS6FuDpA5DUcfmWi9CJ9wsVFYX5AY7Lj/r4Ai588Qc2Zd7ejDa2NQ1QhT9TS161cFsawliCkacbn9WXLIRD/hwxOp7OtbE9/xGsE5FEuqd56AvkMY1fkpW6YzOxF2KWt1ZXF+dPAKwNdojjCvr9P7Iwj1/fZfDalFfbsXdbxnEqr20vXB9Z5fCiYtEv5V/sLImmm0IEiW30CmAQlBWaR2HuaGvFTHAKfB/tTUufZm3m0l0f0nBglp/TlbrT4Y1jf/Ti9+AVwduZxOiU3gUkkIXaFUhHmuExLDixvHnlQYw13QNJc2lLT2ZOjq6d6XNCS2162eosfF9Rr7npSCkV7Eu0cAV6BNz/haNOd6AWTbAh6s6CswuiRQIaZjQrc1/+NqpHaoERARDjlGocKipW54841MO2zbeGSoJrb4FFgPBDI/owVOgJBqXDzxktbL/ZlzCdqYkb3UWV3MTJEVJRHBF+75pIS1CzA5fGcY/pBvVjGr3fKbyStxHBOzb+JQX4aJUXNHCyjqcCOURHSC9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(40470700004)(41300700001)(40480700001)(478600001)(336012)(4326008)(8676002)(70206006)(70586007)(40460700003)(16526019)(36860700001)(2906002)(83380400001)(7696005)(47076005)(5660300002)(26005)(8936002)(426003)(44832011)(6666004)(82740400003)(316002)(2616005)(86362001)(81166007)(54906003)(6916009)(356005)(1076003)(36756003)(186003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:14.5603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c905e6-3d84-450f-c2e9-08da89cb20c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jay Cornwall <jay.cornwall@amd.com>

Trap handler behavior will differ when a debugger is attached.

Make the debug trap flag available in the trap handler TMA.
Update it when the debug trap ioctl is invoked.

v3: Rebase for upstream

v2:
Add missing debug flag setup on APUs

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ae6e701a2656..d4f87f2adada 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -193,6 +193,8 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 		if (unwind && count == unwind_count)
 			break;
 
+		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
+
 		/* GFX off is already disabled by debug activate if not RLC restore supported. */
 		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
 			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
@@ -278,6 +280,8 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
 		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
 			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
+		kfd_process_set_trap_debug_flag(&pdd->qpd, true);
+		
 		r = debug_refresh_runlist(pdd->dev->dqm);
 		if (r) {
 			target->runtime_info.runtime_state =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9690a2adb9ed..82b28588ab72 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1101,6 +1101,8 @@ int kfd_init_apertures(struct kfd_process *process);
 void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 				  uint64_t tba_addr,
 				  uint64_t tma_addr);
+void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
+				     bool enabled);
 
 /* CWSR initialization */
 int kfd_process_init_cwsr_apu(struct kfd_process *process, struct file *filep);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 19c6863e124b..c7d0ecbf2f57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1252,6 +1252,8 @@ int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 
 		memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
+		kfd_process_set_trap_debug_flag(qpd, p->debug_trap_enabled);
+
 		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
 		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
 			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
@@ -1288,6 +1290,9 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 
 	memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
+	kfd_process_set_trap_debug_flag(&pdd->qpd,
+					pdd->process->debug_trap_enabled);
+
 	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
 	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
 		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
@@ -1374,6 +1379,17 @@ bool kfd_process_xnack_mode(struct kfd_process *p, bool supported)
 	return true;
 }
 
+void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
+				     bool enabled)
+{
+	/* If TMA doesn't exist then flag will be set during allocation. */
+	if (qpd->cwsr_kaddr) {
+		uint64_t *tma =
+			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		tma[2] = enabled;
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.25.1

