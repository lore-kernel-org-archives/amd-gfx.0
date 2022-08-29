Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEF6C0502C
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D839E10F339;
	Mon, 29 Aug 2022 14:32:38 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5410C10F2FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSkuEsZeXZxB/MjMPLUduA/ocS1FwSz8WwMbSgwuILzH4d9wsigTEPt4PmZQ4qf38W003q5pAGmIGC1mhy9A9Pm6WVfqO3PDVDP34hO0M3XD001MnQBRfy5u7VIg+Of8nrRUpQV0sQHA3hZdKdN1te9yRF6pfd1t9PjvS2QU6QxBZRKkNzB+Y1OcFbAEpi8bTVdFvfhI0+WNx9rXOOh8VB2AIADreAOlMkRZ6+2yBXKHqOSTKuUqIYcqxUr3UYZSMdADNIRzyyS+Mb22ZnmE4/OaPP2GhmpYouEnRR0S0Juh3pTSayRzF9aA4Tza0Hs7dPDXLM5adAayG1jw2g34gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ik7hHgDgHMpgfYgtnHjqkb4n06F51uYN0QbNmnafe9A=;
 b=Jp5Vc5/0a5nwt6cisayye12zJqjFBHhvo/g0uEyY5XP6THJOUJgjkjwj+lWg6+y9cbvCNNq3YDpq9JoVpCi2jPpyP/80x+9fNmPhG44bS612qbvWAMMBmlv1rbXxZHVjMxLz7CQiBnW1oFfelCq0++26sBDJXyaFuX4DMTCD5ACwhTkopNDMlAQbGQ7z0DxFU2KFyp3erQxtPlYfhBHDhZMk/l9trH/xD9CaxjscbqU9tSAKNay7zrQHerISj3OAz3Dwis0cuVxJNOQwMP/rKwSkpYn0k1LoAnztCihc4uuHCL1C6YKwBS5lwknb1+IJEHB7j519n2yTuRuenRBthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ik7hHgDgHMpgfYgtnHjqkb4n06F51uYN0QbNmnafe9A=;
 b=4t/gKnO49wYAzRHn1uzuedRGn056aNtXi3hSNAqTPt1kiyR3XCa4J+2O7TxBIoRJSJuatUef4YOSKYTBjvR1pR6aYn6x9cUd8r8EvpH+iCzHGBEHXbGnrU+yabX90nvsj9KtyeKxh/ENeZeLLfcPtMjNPlKQCk+rJwwCK9cycQs=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 14:31:18 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::57) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:18 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:13 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/29] drm/amdkfd: bump kfd ioctl minor version for debug api
 availability
Date: Mon, 29 Aug 2022 10:30:26 -0400
Message-ID: <20220829143026.1509027-30-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 64c5b3f8-c518-40b3-757f-08da89cb22e0
X-MS-TrafficTypeDiagnostic: DS0PR12MB6582:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JFyTZ06FOuC/v+vmVXargTr+dpTwVaz8E2UQWwjpxbi6P8orOjAjdc0aMwVMHLY19Kpw839HrdxUfQ0uqiKeMtjsie6dLK6q6nZpvLJvkC1+N0Kk71GWEyouv5V1Bh/mf6h4HobqjKoAaC1+a6Jv8XI2h5G714FX0a0lXNP60lGW4GSB9BNJGJxDoSPCahNo/lUX8CdURnkIp3Z7yjit2dTWA7/QP5vtH38wepMjA8guTyzkPC64KnAGczEIXFVRO6MlIf+rxC1ZxMYLWfErU8j6S8ZT2k2wNvDwEkuevh37qWZSyoEOlK/1rPwTM9qSIuUHvFBTOEE56AuTlgjcYMbP5jAj3SpW+SagyFV3sUfDTZwSDWf2/6n2qvAKjMMYymwDPDOtY/O5SiWE9BnGmDGj586l1cCaqF7Un/A7v9hZaSPWueuIesmBN0YxWPjMhbvT5oLqodboUjFs9HI5CKaKQoH3BXz/RScjUho45hP0bl2RyKw0DAN5CbgL1CiwqIBZAdgBqdzcMk5wwscureT0ZQZMlJwyxexFKOW6GTp5hWu8wz/vPbNYq+TzE/mWjOMgSXXhZJ8Ynwc0mC5/GBWgCdFsFmbxaE7t1WLWA9/Y4UU/kXOw1b0aU5Dh3fNePml6MGZcSfcFV4mA0PdIUz/ckaxrapdRoLQQ9CfBO7EOMnNHuCSM0zYRfSRzRKKO0/dH2YhEkESuVxhE08yl3y5vAu5GpIA5hRbxA3w5+v5FWyDya4tZ/iDRuxYHIG2QvCm/Mx5I7kjTuIsdtHjtV04ekKFEuAbsFayAukJhXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(36860700001)(81166007)(40460700003)(5660300002)(8936002)(41300700001)(40480700001)(16526019)(186003)(47076005)(7696005)(2616005)(86362001)(1076003)(426003)(6666004)(44832011)(83380400001)(2906002)(336012)(26005)(82310400005)(36756003)(316002)(70586007)(478600001)(70206006)(6916009)(54906003)(82740400003)(4326008)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:18.0348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c5b3f8-c518-40b3-757f-08da89cb22e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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

Bump the minor version to declare debugging capability is now
available.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 -
 include/uapi/linux/kfd_ioctl.h           | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 090fb902086a..52a8a9b36a83 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2860,7 +2860,6 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		if (!r)
 			target->exception_enable_mask = args->enable.exception_mask;
 
-		pr_warn("Debug functions limited\n");
 		break;
 	case KFD_IOC_DBG_TRAP_DISABLE:
 		r = kfd_dbg_trap_disable(target);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 5517dd28b974..701809d78082 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -37,9 +37,10 @@
  * - 1.9 - Add available memory ioctl
  * - 1.10 - Add SMI profiler event log
  * - 1.11 - Add unified memory for ctx save/restore area
+ * - 1.12 - Add debugger API
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 11
+#define KFD_IOCTL_MINOR_VERSION 12
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

