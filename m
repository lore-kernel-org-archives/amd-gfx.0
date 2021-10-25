Return-Path: <SRS0=aCMl=PN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33DA560FE8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Oct 2021 17:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33DA560FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF8126E19B;
	Mon, 25 Oct 2021 17:56:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EABE6E19B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Oct 2021 17:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnL5yzL4SHg11ZzSrcBPx4rxw7jpnt7xwvRuuEI4jPBElIDGMI50Cokb8o1MWYxysUqeajZrcYTerykri4iWhTNlD8MPx1vVFyk3eMm3vvgJaSQGI6uvB9pgxzoq1oacgwQpbIgINBwLX7rJ8thH0rYE9Hot7KNlHO1f7x8D/+Y7LHpHCttzMB+OtdGBMViXLwWmyzdTV4XLdGtWoWeIs9KaaAVnz+CRYrROqjzbGxElXNtUBe8M9+M3UF2ma/HVnqTehd3mQWvY1CZV+HqYQo63m+zncMkp7KngJNnJvIdrBh07st3PeLciyKVa7TUxjmgW9CounXlUni2CDKx88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAw29t6j6F4E7ovVlBQHXf1jd5jrn0k0+6oL60PGorU=;
 b=dYV3dYAqwAunwnK+f6aUXHhACrz9J0CUf95QKoHTpFmrZAps4t90U/POmhOQtNxgvVUZIXXxgr8aQENgHzVATpeF5P08MeOxKQJGu2yNmKz7shjBj65xUlK9rgG8+8SjYStM+p0ixPPvB1nj+AjPJrIe4OTt9sra+VKgXnZPBET3TlclteX0l118wXUND1d8+XCleIn12qw4mLeQHXaCVA9a3aUu3+e0Bdao1myJivzNZEAP2MN/gnDXC3704XGTtervORW8XKKP6MithD8ds8JXGZDWF2thIa43nT1XIw87HdqwhtIsGonMSe2lYCsAVBDzoxEUcdWTwNEH2cZ0kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAw29t6j6F4E7ovVlBQHXf1jd5jrn0k0+6oL60PGorU=;
 b=mywmFUhlo5lH10Lh8TzncG//QTtt0OhahLl5Ray12sClEFVZUVCV30kAjN3btU2yrjuo5zmw5nBl5nO/Bhg2BjxLm3JHAjFA3J43h7wLtYJVOjsF5lleUNoqTiO0SdbyMuPtXAwJ57n70H0JftFjU7egQd6ucwwrRGUn6rBC1rE=
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by CH2PR12MB4279.namprd12.prod.outlook.com (2603:10b6:610:af::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 17:56:02 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4c) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 17:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:56:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 12:56:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Mon, 25 Oct 2021 12:55:59 -0500
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Aurabindo.Pillai@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 0/5] Fix USBC lightup on DCN31B
Date: Mon, 25 Oct 2021 13:55:52 -0400
Message-ID: <20211025175557.148601-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2abfbaad-7a78-4a5e-bfb8-08d997e0b567
X-MS-TrafficTypeDiagnostic: CH2PR12MB4279:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4279E2D6F3A3F5F79987DE2FEC839@CH2PR12MB4279.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwqNUk1q9/rb0JxJwKhhkYUHhyjXUPMwvgEbdDvYapPMQKuvM8bbwS8OVmIUFw8WeKxWf+P+Q18HeQeCyQ4dSnEBYG5bXhYBMjNgAFkLGJ6K4LKMYxwWPe6CFGhNuklDAMcWQvcsV+wCTnABSzRwQfR6uzn1azqRs6GBdoQfufgSjyWfGnUeoDUnFTkueI6r/gSTLd11/H1v0Vkvk9XYG4076aqGoNAFtgA+iyJsf89p8H8qdMwY3ser65sC1E5ABkHVH+pQT1U5l5YhbLV5c4J/OCxOAh3AbF4KpJDTweO0JPEhGZUaRe/fbmn7CzZa1A8Xu24at0lCcK9Olq2xW6VDELDRNuDi/1Kfk5wdb0oN+BCbKCrr5y4BazQq0jMvuNvV8cBvAXD74yDnL51vdMfrND1dplBL2mJ2XCnli2QZMUELjzmIDmzZszMTtOOpAPniZIJIVbMgxTaFs9cegxBOkzzInGHEL35dNgxbkd6E0XbYryc2mz2dXENn7/tjsGsJ7k5IC6aTALLIXL08G1R7OyZAXeIC8z0u/5P+W3BeQcLF9PPPZCwW+jWRTXBy5i/Yq3fCzTCjPo8xN5pegKWThkFjDyx1IT1HptjWpZLUtZDj2beGxAan/Xz1ThNW73w3GA9s6XFoGkX5goMK0cSFYwjHqsoVPk9Tle64JXNfN1UTjrcSq/JYglybxJrqHIaCOdrEaF7mYHDhY7woCWDCwWtZLNohW/e98w3gdEw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(426003)(26005)(36860700001)(186003)(8936002)(83380400001)(5660300002)(44832011)(82310400003)(2616005)(81166007)(316002)(336012)(2906002)(356005)(70206006)(6666004)(36756003)(8676002)(70586007)(6916009)(1076003)(47076005)(4326008)(508600001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:56:02.0030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abfbaad-7a78-4a5e-bfb8-08d997e0b567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4279
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

This patchset is a mini-promotion to fix USBC lightup
on DCN31B for both SST and MST displays.

There are five issues at play here:
1. Invalid clock table causing mode validation to fail
2. HDCP downgrade to v2 causes deadlock
3. MST payload allocation not being propagated
4. PHY mux selection not being properly indicated to DMCUB
5. Hang occuring during HPD on PHYF/G.

Jude Shih (2):
  drm/amd/display: Fix USB4 hot plug crash issue
  drm/amd/display: Enable dpia in dmub only for DCN31 B0

Meenakshikumar Somasundaram (1):
  drm/amd/display: MST support for DPIA

Michael Strauss (1):
  drm/amd/display: Fallback to clocks which meet requested voltage on
    DCN31

Nicholas Kazlauskas (1):
  drm/amd/display: Fix deadlock when falling back to v2 from v3

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 +++++++++---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 13 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 54 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 28 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 23 ++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  6 +--
 9 files changed, 153 insertions(+), 14 deletions(-)

-- 
2.25.1

