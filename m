Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82AF1C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 14:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21F010EDB8;
	Wed, 12 Jan 2022 14:27:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3497F10EDB8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 14:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luehg/1qrTWUIgyGjga4fi1+NQmex0mdYD9x6Ma8u41ga14rjBAumQ9RvZblHZWesSproQQpJxUZa+2pLUYqyck3z06UXpR1HWIZua8TMSnA78gxQ94I9Hcs19BtD2VxgmdbDcQxSXfoiHKUcJF/MvDhCtPwv65ZgrHDCQ2+cy8KzjRG4PPG9jkW5h0PujkGQuWO4KkRnq97RtyXF474KSGINj2SrQTFE/ovzeMybUF3mSZaKX8eomXDZG4liqzI0xtcoi82ahYl2fHyApCdZ2bKne6pAvT4O5uGhs3aWBAj+O5Bgn1fpqJYT7Sf2oqlyIQdmWMP2emnIAZ0ce9KSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8AdQSHsj2IZAvW5RRbNOVhGhqmy1N0b2ieTUQWGyQ=;
 b=ByK/cbhia2+gtGZpdUpdu/3pA0OIGqyI+dHay8YlBb8h4kLnBFFyESqqywAFkuyCbeGuAt7l4wRlXbDQkGUMv3H/SIxuzzJElzwYQSiLFjkAxi6VFhMuLhRW3V8Z59N8NRBjhXvgfeVQkQIheV33xlz4rrl+5dva8LqZNutP1ZIAzyeDCJk9R8CXXvya1kh+H5oUfbm/KTeShqAS5/JTNsmNs5DtSEg9pvxhYDHUpt36ZMjaMGBwvSLfKt/qAfPKKixl7ezu4bQ1K04u07fT6YfjgnhkbQI8KaTXz05wdy3lyemzMHfHBFGCBewRM4kF5ouQ5EkXvGZ/7K8XRHvSHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8AdQSHsj2IZAvW5RRbNOVhGhqmy1N0b2ieTUQWGyQ=;
 b=n5/5Q+9g/4MzTI4Pr40llHr5swhCG6YbmwiGfm7k6zk9IXD0aQF4x8LL0l8pjMDhdiIyYhx7b0mhEI3QmWoTHjZcvru/RitHtDd7r2eqDlxGXYeMpuK+W9s5cqWoRiIV1Cc28ssEYiCPj+wVwnIOb2NcGEPxJvuR0yFLAL2iw6k=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by MWHPR1201MB2540.namprd12.prod.outlook.com (2603:10b6:300:e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 14:27:45 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::80) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Wed, 12 Jan 2022 14:27:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 14:27:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 12 Jan
 2022 08:27:42 -0600
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 12 Jan 2022 08:27:36 -0600
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Fixing bad merge in OTG synchronization logic
Date: Wed, 12 Jan 2022 09:27:25 -0500
Message-ID: <20220112142727.16295-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3609e697-b74f-4763-461b-08d9d5d7b301
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2540:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25403891E69986B6C5A13AC88C529@MWHPR1201MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIRxkGIq9lcUAqACisHM0ZMMFMgwVRLUk1fGO79xGmKRaFzf8jEo5BWW3sm8pXsmXnRdM8guNGJi0MRfSNeUn/l5ewlIrljYZfE+UFtKWhioG2eJsq4az3ItSXL+5VAfO2ywn3l5I3jQ/7Cyp1sRODHhXqdbvBujLugcSCJ6YVViyTDqGbDs7g48lugyr38sgSZt7v6Uc62FzWCgIPd7b404SyAnCQP7NRDKgefptRN7sGGd/YiRaJ2i+oKpMbePIyA5+zie8RZHxWPYptvh1TcliB1CpA8sKk8MTN48dZxkaD5Do5mWUSnpJs9f3HH7+N9RmASrtwRKW/uiHmQi46mwc1sA6C+dXluXts5wWQZplBu7wfS42eSyCZClL0vL3szw4aMEJCkQOotOOXIRm7avRGcgi2dCwGxDsfzxgYL9ZpG4GtWBOp50EczjzzHWm+ZKuaBjddzS0NQFPVu+KHVAjEAck1v0sHS2IhU+ubdu0e4b31bDLj/nBQHl2BlA1C3piDi9qHw8ltUxOTYq1wnLqBNOtmGqI+IYp3c0Rr+gKpmIKK/qWWS6w3YOdEMxPu5sB/W2+k8QRN/RhQ7JfkNhWfJjoLkzDqART32qbBS666SJxy3/JbAkIukBOttxuAA64yFjmEPbHYl0oZRyyqKGeayZORgUWPJu84PB6PTT5Xz6FMX6UwUXg0ov8LUuagmSD+M0cvEmsBL/LlJ9YHb0aGFgL1qp+p9f2weUdX68To3p2ntmGI7IF22g9UT7rthaVWYGEjC+CYNhsM25c+HZi3ZqxmItHlyxXaVlUXE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(4326008)(186003)(508600001)(7696005)(4744005)(6916009)(36756003)(8936002)(2616005)(81166007)(40460700001)(36860700001)(70206006)(26005)(47076005)(86362001)(44832011)(6666004)(83380400001)(316002)(5660300002)(426003)(2906002)(8676002)(1076003)(356005)(82310400004)(70586007)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 14:27:44.7213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3609e697-b74f-4763-461b-08d9d5d7b301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2540
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
Cc: Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A bad merge of
1abaa75bae9e ("drm/amd/display: Fix for otg synchronization logic")
caused Linus to see a lot of underflow on his two 4k displays.

This set pulls his revert and fixes up the original patch.

Linus Torvalds (1):
  Revert "drm/amd/display: Fix for otg synchronization logic"

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix for otg synchronization logic

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 15 +++++++++++----
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

--
2.34.1

