Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB61C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 14:59:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B402010E2B1;
	Thu,  3 Nov 2022 14:59:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3300710E2B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 14:59:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/k3/jhrxH4QIRjtPfP4uFX5Vc8hRea0SSXoQGDX+P4syIfrJLyrcId2EnMfGHg/BPSYje5pq3f/jKolZdWXXGt0yiIcHiVcUPHjqzGG6u3IpqAWu5CaUQcIXl8YFN/ZbW6e337mJTur83PARe2QbikfuVUFW9kN+L3S/mYMqK8O4rClhlvidOYxwzP7B6nNUQdQTYC+hG8Inr7FkV1rPUlq6LZw97RXaJtIoA5V/i/e2ZSbaON3uLqGtkmjWO0HfOKzJWpioAWAq/1XM8KZUI5hI47xNh7yX3qC9klk9B5JJ3zVuO5Gg9MXQIKFQ8O22zpkqIozGgq3w1TXDmKtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbq3uEeiKOs14AeDLB8r1yNWzYyLWsukw7V2GV3ODF0=;
 b=bv3LCTBiXY/IOFGBuEj4z6rwZxW3IqEUSOSiigIQbvc5P7DcdRN5ofMtZN+shAgYCOhUQy5hnaLJMUZKpUt3iK3mOmBGUljKgifCM32Vqyziz/uU6vH65HjBvibKf7ZQGH1FHNT67u1yeHIZmqGcji2DCzvtVZVGCQp2pxbyuOko//o01NurKjo5kCEYHvysgXOwMzyzNDqYXzJqhrCTHMoDIRF065afZEjYW9dzZAkap5CxJzfm0IY/x5bDhudqGFz7ZcGLf9um9HLnLO2BhzrDXpxnwJ/xFxzMZ1ZKeCddCg6f6FROVVdhw7cs214Ryjkzf9PIKuBh4eZhJhTevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbq3uEeiKOs14AeDLB8r1yNWzYyLWsukw7V2GV3ODF0=;
 b=Uyid5IUtvNlIO0KfRQSCAg4pydw9wYrPI4f+Q+qIbHejkTzvnE91cnBvp+2r1KNVfVId5Ipw7VCuiIE+ux3VpRSfbsr9SiN9WWY1jCzFLebt30shQ4Nr9aN/Vs03epjfVc8GX60mujU0l8yul+rL5QAA/WfZgxAdn/GOOykSYpI=
Received: from MN2PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:c0::37)
 by PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 14:59:31 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:c0:cafe::30) by MN2PR05CA0024.outlook.office365.com
 (2603:10b6:208:c0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9 via Frontend
 Transport; Thu, 3 Nov 2022 14:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.17 via Frontend Transport; Thu, 3 Nov 2022 14:59:31 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 09:59:30 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Unlock bo_list_mutex after error handling
Date: Thu, 3 Nov 2022 10:59:05 -0400
Message-ID: <20221103145905.20222-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 8757d551-760f-43bd-531f-08dabdac0330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl6U4sNE2f8z8qo3ybjPPs0aEbMQny3R43O7wQDtzgHyopePeAWWpZmoUC0RheAND5X4Eu5l+A7Z/0XR9IwafA28Ai8kbB3uApxv9HxJR4dsYwwxnO2eAtEac+YBUiiZUQKCGsFIFRb0VCR/hluNJZ198mqDhcOwTXiT9w8zFDnk+TQZmfQdSOApBuDNg9V9Ou/SXQ3AINJ1YItYDvqDaQhMgc+S8kleDfE5egHDAD1mT+dFKrdd5CBfi+pZKikzBvwSmmVhqhssx6uiRDK6dPgqtuJLUicKVxpZ6NLXS3rnA/TLvuXU03vAaqralFuUkq7BYAUhbNP5dMtB3qjdAHZEn0frGjEKQ3HbwKkrBYx4sXNxuHHyXTGiyiQwtHtQn++cv6Ng6UQisyVZOV1561idMB/3ZZ4q12Zkg1UoiC1U3yxc5QOblc/s13t4C7HNgQSvmjMecuGez8Vi9l+3XJvQagnW3U2dY6Nz89cj2rKtHqv+RQdO15wKosm0dCHUcwwgFSD4Zj319psCIKqfhI73hXNcfOZCBkJNjxMPqswgIaxCxtNZoz/7OhP73h3KMI8igG7DlG/WPNSTvUFmrKZYeNyXV9+3NoWen7zX9PEADC/o96MROFdwqcuxx1aMr7RFZy8A61kClX9iVXl5eFhkLm9pilfbAo5/M0IVDX46wJO+nVghnPgJaJiVkRj2KceNaxhnKuxf6I8JRNr7A3uiIs+nHv4/W9XNjgfXCB2YWYcK7XkIhouc+dJrsRrU8yc2C9BuQuK5h06fK84gQyQR7NrRi0zFYGdL6eKNQ4c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(2616005)(478600001)(47076005)(26005)(7696005)(83380400001)(36860700001)(336012)(186003)(1076003)(40480700001)(16526019)(40460700003)(426003)(2906002)(316002)(4326008)(8676002)(82310400005)(70586007)(8936002)(5660300002)(70206006)(41300700001)(6916009)(86362001)(36756003)(82740400003)(81166007)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 14:59:31.1557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8757d551-760f-43bd-531f-08dabdac0330
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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
Cc: Philip Yang <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get below kernel WARNING backtrace when pressing ctrl-C to kill kfdtest
application.

If amdgpu_cs_parser_bos returns error after taking bo_list_mutex, as
caller amdgpu_cs_ioctl will not unlock bo_list_mutex, this generates the
kernel WARNING.

Add unlock bo_list_mutex after amdgpu_cs_parser_bos error handling to
cleanup bo_list userptr bo.

 WARNING: kfdtest/2930 still has locks held!
 1 lock held by kfdtest/2930:
  (&list->bo_list_mutex){+.+.}-{3:3}, at: amdgpu_cs_ioctl+0xce5/0x1f10 [amdgpu]
  stack backtrace:
   dump_stack_lvl+0x44/0x57
   get_signal+0x79f/0xd00
   arch_do_signal_or_restart+0x36/0x7b0
   exit_to_user_mode_prepare+0xfd/0x1b0
   syscall_exit_to_user_mode+0x19/0x40
   do_syscall_64+0x40/0x80

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1bbd39b3b0fc..d371000a5727 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -992,6 +992,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		kvfree(e->user_pages);
 		e->user_pages = NULL;
 	}
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 	return r;
 }
 
-- 
2.35.1

