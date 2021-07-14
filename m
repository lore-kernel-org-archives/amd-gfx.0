Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCECC11F6A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FCB610A7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 15:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FCB610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671556E40D;
	Wed, 14 Jul 2021 15:25:55 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1E16E40D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 15:25:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH0ZEY0OznfPOYfwGtXzsn+jQhO/pcTNX88gysaVH0qG3kqasKoVAaGzcT+OjON94TyIFCxme/F8stRicpcto+SnqyCdbRpZRjZoil07uSmj6yRrM47uSjRwUhNP26V2cpDIWNEEIdfzBoa9+GDliiedWUfFmZAG8GOkE4t2n3bULHU1Gl05yZEdLPMBvVgde42pADkkGcwxlxi9veIvdxBpv/mDmXUdaNzJ6DCf2i2/G7r9XulraORfVXuJbuvdV2HPxHhkw7CaEyy3nOIjm/+JtlQxOTGFN2PNlbSS4g1Owaxlvu6pzLQCDruTpZtKfBA49DaIVPPTdApLFMarHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvhXeu+HrsYmeONV4qRlK6nQbk+EeicD1R4A1XI4iCc=;
 b=F82JMWMYTCjGpLlYlSGyJ9+KlhutU64cmMy/Cs7kXrXPYmYqY/ujCQnhKS7JcgyWgb90ipVSOuiXreHfVgI/yLdMrtZ4FkFi1RdZqEay04hg7xeuqXW6HJ6uEqiFREKgbbLY47L+RneQNCj61ouRRI3WCNlSury8kDc1rRkM3rZN7WEhuXaRu+sYQiOfOaUQnnBXSXOlCv6/T3xt7DgRriBiSJyplS/4nEDMv1sTqLSw3YJ8gPEp5Gct/LjbiEWgRrCqpWmfjuQGV0If83C0HJkGOKCKw6xuYA/eaK4nMF8dEYs5LQ6tA6BJnHPE8GxbNg/U1jOBvAdmJkT2GS/jjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvhXeu+HrsYmeONV4qRlK6nQbk+EeicD1R4A1XI4iCc=;
 b=Mjah9C2d2i1wzhSjEP87YebaHf5HIzv8gcf7uhXiBDiVPS2ZgPEtvd9OVw3mp1DhWSDTxl745QSMmw+FADTzf+GQUux2PPH+cqrjFiq1A7fklXRUfaZFA3im3ZmJ33p3yWSlTQ8Tm09jQYqTk6QUihPcy8jZr7gsnvWj1ta4z8M=
Received: from DM5PR16CA0015.namprd16.prod.outlook.com (2603:10b6:3:c0::25) by
 BL0PR12MB2419.namprd12.prod.outlook.com (2603:10b6:207:44::27) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.22; Wed, 14 Jul 2021 15:25:53 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::3c) by DM5PR16CA0015.outlook.office365.com
 (2603:10b6:3:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Wed, 14 Jul 2021 15:25:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 15:25:53 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 10:25:49 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdkfd: Disallow debugfs to hang hws when GPU is
 resetting
Date: Wed, 14 Jul 2021 10:25:41 -0500
Message-ID: <1626276343-3552-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
References: <1626276343-3552-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5e58eec-f932-41ce-c2b1-08d946dbab30
X-MS-TrafficTypeDiagnostic: BL0PR12MB2419:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2419554633C8B773D6EB5DDD80139@BL0PR12MB2419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l31+1v6paGC+RyIvUlH5sxIEf2oX34SMGCwGknk/dBrO15PyUJlOKHY1kdxHiOSjtAu83fqCFtGmS6V42LAWLCGDz2So9jl5wIQUcJW/FTykV5XFH4VQYWgqhR5q4O779kHIQQeXFeQmFT+DxQUlOXwkci4mb2O5PbuDzhxDLzxRl0yESS8PaH/QxCgb00LKPeuRPJjXMx1n5kI7NGTLNyKaPbRXinRjcjWU9TVBRjc79BttaA2ZnjyYc87TYOqg6PWh8NtU/YuK8zSnYk00BIe5dayLkxdIphhNansyfh6Y1wPZw7oUfO4uVTSYzbm7MQUR/ZTA7ZYm69JmQSvAlmNbILsS0GygaMRlPZqkWcQ2VAHAdFGNc8Z9uXFCSdr7VN+l2baGx7xj7Pis5hnFQjPVpdcBIU9gyLDccIsMFrP9TWYsLd4aJq8iv/OvZQJTITKu30lFtcvUpC1P/W6ErSNMZzwwAVuy62tBz8ocyPKQkJVcTJtJJjnbc9p/mgDeVzsjqDakbvwJzqCaFP/9xQpZO2Ku0Qi6cUR1/QKMaUWj0OU4sG8dZedEVg+3n9cYVgT4qvBQPUwLfrqDlwwSzHA+M66X2c48y5YkyiNDkBpUdd1wmxwrK3HbgOztmFLjR8OjMwgUv5rUbYUtasqwqrasjzOO6fUiXeJFgg26eprIipelZCdWqsGz8F7igMoELF46pLFL9yqzfmVxqfLdDRTfXoOsU4WF1Df9Bs/tDYU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(36756003)(54906003)(186003)(86362001)(81166007)(26005)(70206006)(478600001)(2906002)(4326008)(82740400003)(8676002)(82310400003)(356005)(316002)(2616005)(70586007)(7696005)(336012)(426003)(36860700001)(5660300002)(6666004)(47076005)(6916009)(8936002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 15:25:53.2458 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e58eec-f932-41ce-c2b1-08d946dbab30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2419
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GPU is during a resetting cycle, writing to GPU can cause
unpredictable protection fault, see below call trace. Disallow using kfd debugfs
hang_hws to hang hws if GPU is resetting.

[12808.234114] general protection fault: 0000 [#1] SMP NOPTI
[12808.234119] CPU: 13 PID: 6334 Comm: tee Tainted: G           OE
5.4.0-77-generic #86-Ubuntu
[12808.234121] Hardware name: ASUS System Product Name/Pro WS WRX80E-SAGE SE
WIFI, BIOS 0211 11/27/2020
[12808.234220] RIP: 0010:kq_submit_packet+0xd/0x50 [amdgpu]
[12808.234222] Code: 8b 45 d0 48 c7 00 00 00 00 00 b8 f4 ff ff ff eb df 66 66
2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 55 48 8b 17 48 8b 47 48 <48> 8b 52
08 48 89 e5 83 7a 20 08 74 14 8b 77 20 89 30 48 8b 47 10
[12808.234224] RSP: 0018:ffffb0bf4954bdc0 EFLAGS: 00010216
[12808.234226] RAX: ffffb0bf4a1a5a00 RBX: ffff99302895c0c8 RCX:
0000000000000000
[12808.234227] RDX: c3156d43d3a04949 RSI: 0000000000000055 RDI:
ffff99302584c300
[12808.234228] RBP: ffffb0bf4954bdf8 R08: 0000000000000543 R09:
ffffb0bf4a1a4230
[12808.234229] R10: 000000000000000a R11: f000000000000000 R12:
0000000000000000
[12808.234230] R13: ffff99302895c0d8 R14: 00007ffebb3d18f0 R15:
0000000000000005
[12808.234232] FS:  00007f0d822ef580(0000) GS:ffff99307d340000(0000)
knlGS:0000000000000000
[12808.234233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12808.234234] CR2: 00007ffebb3d1908 CR3: 0000001efe1ec000 CR4:
0000000000340ee0
[12808.234235] Call Trace:
[12808.234324]  ? pm_debugfs_hang_hws+0x71/0xd0 [amdgpu]
[12808.234408]  kfd_debugfs_hang_hws+0x2e/0x50 [amdgpu]
[12808.234494]  kfd_debugfs_hang_hws_write+0xb6/0xc0 [amdgpu]
[12808.234499]  full_proxy_write+0x5c/0x90
[12808.234502]  __vfs_write+0x1b/0x40
[12808.234504]  vfs_write+0xb9/0x1a0
[12808.234506]  ksys_write+0x67/0xe0
[12808.234508]  __x64_sys_write+0x1a/0x20
[12808.234511]  do_syscall_64+0x57/0x190
[12808.234514]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e..fc77d03 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1390,6 +1390,11 @@ int kfd_debugfs_hang_hws(struct kfd_dev *dev)
 		return -EINVAL;
 	}
 
+	if (dev->dqm->is_resetting) {
+		pr_err("HWS is already resetting, please wait for the current reset to finish\n");
+		return -EBUSY;
+	}
+
 	r = pm_debugfs_hang_hws(&dev->dqm->packets);
 	if (!r)
 		r = dqm_debugfs_execute_queues(dev->dqm);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
