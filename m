Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4F5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AB5619E7
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 14:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33AB5619E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6486EB94;
	Thu, 30 Sep 2021 14:02:33 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15CAD6EB94
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 14:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRo88+840DK+z6UHPz1ZVs9pGzNTqtO9Iy9Wl96EbyWUqjaL/54HPl3PFWCHKh75i8TcO+U3dZL14q1wG+uKgTF5yVMgvdR9I7Ho5JDAdbZzKqMcMcKCWFfiqsBfO0NSBWSb5Q2nJ+kbOGmKm3Dh8h6ahsjnHqUAjSNrQ9uZB5XfmFFWqIgKv+PGon0L1wD966d5deITjRBVvmfsvNvmoiaUFjRobNDxANsTDcxrj2TJ4UqvsN5YvMhJ5SZmA1qzGTCDiQoJb9WBUXdpGQJn4UaZY+djLg+PA5JUCzktDvBbuGvcUvPTv/f3y2MwDXeXqazGJWwDw3m4gI+Lrpmz+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=T4CsPx3+702F69HFGYEqAiXQ71PWMKvrrQf9RiNMaks=;
 b=T9IrazGlb/tYXmXjgej04VSOdFu/hzVMKVB/J23CFZkJerjFaU8f5gWVRw4dOIKPzOGfDQp4qseL47KYxDE4EV1qQOgP08XEqfVNIEsZcz1HELIfLSEnxJThH68OriWDoBYl6elX5Wb7V7H3/+6T1F+tioPspX44bWfIQL2TKCjDHDKbvlUG4vNNzfQOqOgoFEQxJ9QGnzgH/Xk8PglyDyqCjVvnYmtXL9cdsvK7SiEb5RDU1YCXvgb7Zzvrq4GH8tUNuOcuHnHSfdN71y5QJtEFIs7OhLG3PyBU5IlPdLh52LMUJgIyE+HJoYtPcC2VtGylkbZXnM4+aQVep9FEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4CsPx3+702F69HFGYEqAiXQ71PWMKvrrQf9RiNMaks=;
 b=koJWwPm4h76xzt0NXCHI6oQeZh73RSCUVbI9vYT/wkNtKQuKHB1qVc0RZsKtRiig1YjTXGQgvUmK1AJeq+jyL7gRd5tvGTTQ26IRSmvy6MbBgTYcREd1128GLyQAjBXwvHi7LQedM+C7wYhi6RCQNfhyy7chHl9zCydqLsra6ms=
Received: from BN8PR04CA0033.namprd04.prod.outlook.com (2603:10b6:408:70::46)
 by DM6PR12MB3129.namprd12.prod.outlook.com (2603:10b6:5:3b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 14:02:31 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::59) by BN8PR04CA0033.outlook.office365.com
 (2603:10b6:408:70::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Thu, 30 Sep 2021 14:02:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 14:02:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 09:02:29 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 09:02:29 -0500
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Thu, 30 Sep 2021 09:02:29 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Zhan.Liu@amd.com>, <Alexander.Deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Don't use mpreferred-stack-boundary for
 clang on DCN201
Date: Thu, 30 Sep 2021 10:02:27 -0400
Message-ID: <20210930140227.64818-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8d8332a-c414-4e49-5fbf-08d9841af189
X-MS-TrafficTypeDiagnostic: DM6PR12MB3129:
X-Microsoft-Antispam-PRVS: <DM6PR12MB31292B951C257E2E9C6FF50C8CAA9@DM6PR12MB3129.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBAzecJ178qqPY2EjchH1a4D16BcJuZ9/aHtCjKdNPLS0R6k7WM0tWOvgc0WlK3yFxyMfL/Tuo5DworvV/+ZnnoO9ld85Sy3xVlYWtC0kEdn7zi2XCXeYwh0QjxQukFI6mhApX0RqdbJQMEtHjcPXqu26RTSEurxxRkBHXqwykP2fsAjuqCo7z2MgkpX8eloTgfBQkLLjk9ddKmFnhybp0RZSO7d0oFS7b0yag1TFnXScZzNDCmF7FSzZ5aw0I6WMoZHEorzr1PQ9w7/Ky6M2oGr9iDXP/DUsiKYIhNJITqqF6+w/S5eZ/laUvD64MvqeyyMpKrC7Yv7I3/QOB9kenpycPkryYrCSs9Yvr8M2UbP+1lXoPzTIcU62znTbd0XQkC5QVxQfDQor3Nt9zNwbYz52gTgATF6R08hA7sVus/+2vzy8Nw9vQ8tAT+nVqUIm+3m9ddQW+51CQ00x5Dqfw1FEcisgxTDSmJM8cfufbg5oDjzgo5ERl0fAtVlEpWIapcRxtndXl5SJm/oVu4i8g7ukvVPXzIY5bvbj90J8ru5o8iic0vk8cNCARysAZhwBnzsZWpttrYv9/tno484Xngflfa6WvRxZ4hmy3ZEvgh4geK2svQXnmWI0Hbe0TrnWwEj0yxmvInzSiPB9c9J5hljzmF/ZrLYsn2fYjJ72fTlCK8htjgsJpCHWOIhCB4NVhjMyYe5ExN7p3FtfUu9CTBVxvU11POMublU/eJqyXA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(36860700001)(70586007)(316002)(6916009)(70206006)(7696005)(4326008)(356005)(82310400003)(54906003)(5660300002)(336012)(1076003)(8676002)(26005)(47076005)(81166007)(4744005)(2906002)(36756003)(426003)(44832011)(2616005)(86362001)(186003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 14:02:30.5260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d8332a-c414-4e49-5fbf-08d9841af189
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3129
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We were erroneously setting IS_OLD_GCC for clang since we didn't
check first whether we're doing a GCC build.

See dcn30/Makefile for reference.

Fixes: 4ac93fa0ec12 ("drm/amd/display: add cyan_skillfish display support")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn201/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index d98d69705117..f68038ceb1b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -14,9 +14,12 @@ ifdef CONFIG_PPC64
 CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
 endif
 
+ifdef CONFIG_CC_IS_GCC
 ifeq ($(call cc-ifversion, -lt, 0701, y), y)
 IS_OLD_GCC = 1
 endif
+CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mhard-float
+endif
 
 ifdef CONFIG_X86
 ifdef IS_OLD_GCC
-- 
2.33.0

