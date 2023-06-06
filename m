Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6767C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A46F10E15B;
	Tue,  6 Jun 2023 16:00:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76FFF10E378
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:00:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9NJ4qf4HcfsziHGX02zZf16eQ/kiUozl3w3fKyngttv0LgkcqSh6LA8P3G6usUdhgEuAXsx4lNHTCY9PYuamVVE72YlDvJ1vNQFm/deH/JEkj2UJirhXJKTJVDmvU227TsaGnIfcZKRYgnVGlTek3LH+edfAn676cod6t0KaJOovdlyMB9RR09ZpiP5QVDVvbNAanVM0naW1wIznpBk7ppC4uwDIjZfTzC4sPIj9ISYb7cIhrqrwp4D5QXfQDws56rKaWT3N22WJ77xv5l9SbM9P9cvFZgDziaLSE/CKAofyV331nZcTXvQiBAt2oNGwHh9pQIzPCaeHzY80O3yAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8ddt60iPFQdcLfk6b2v2ZUw12a75xJnd++2c3RAxPI=;
 b=ZVEMwFgv5ah20A8Pt3JCWMzq0fN+bIb8w1yu5U9tkU2zEKjavWZRM/pDeTSxbiJkdF2xtAReS3rx3YAVNAJZNWErQ2Up+vbVu8A7f6UiiFyO7rb4+wes765SpCzLwBJGvSz0kOKlQZYs82gFZ6reDNyuK1ZNLC8s1hT+SQRPGLkkxhs/qV/5+48bWUIzFo11a6r6bIPSzi/cikKIEM2H2SxaGHFEEzN5E/1WegO1VnB4ZOMD6eh9CZKn1QTntYVlli2H4SjCXDaLBN6C/HV/in09Yc+y6U/+d/lSVKGsfzXn3NYAlZSx80zEjffvDF2aaUQv9yV2mSuA3F0+5d9d+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8ddt60iPFQdcLfk6b2v2ZUw12a75xJnd++2c3RAxPI=;
 b=J4vfdeBLTTdkoAV5Uk0C3kYu7FBFGnueZHD3AAB0Lxfm9xcEBHwuv8JCDWB8WKch8kClLKI+kp+DCgLOb7mFtRaOXxodedcIxVw4YV4dfC2+xmZ9yJ1pI1IPcOii+PVKSleqfbGhmv4xxgJejvws3JCfJ91KBTy9FdTytjwcl7E=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 MN0PR12MB6031.namprd12.prod.outlook.com (2603:10b6:208:3cd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 16:00:23 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::4a) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 16:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Tue, 6 Jun 2023 16:00:23 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 11:00:22 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] drm/amdkfd: new event wait support
Date: Tue, 6 Jun 2023 11:57:57 -0400
Message-ID: <20230606155800.1859694-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|MN0PR12MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: c4fc3e01-2b39-4aeb-a4e3-08db66a722be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKHU3nb3cvbVV7WOUoJV6hZ+QNPQs/bPciqbTljMFxpc2Oka6z+BIKM5KGXZSp6PpAr4SvozfgIZp8qDpbpDU4b6kEcoGugkEsr0u03UIK0JLX3t1pvhu1BGY3Ru3BxmA7A+BetZtpHySp/yo9HhkRQfx5cs6QemVlt9PR7HIunBcriDl73XUUgog2ONl3GUuayZi0virV4KUoIvfvg1xtZDTUmWFZwCMSUi2gKYz2OE6KpeP6lz2GMN0wE3EHnsqYTkXOOHcx+IikwbBhyWTB3TvIHhG8K6k1gMJvtxDLhzc9T3XyPOaHmoveTlwBE7otNQ3jZmFr/KSCeFI52Rad/lQlVt9u9XlEKb6D0ZbbVN6i9t4YBDPJAL81fT0rOkRKxmYWcG1LnZ3i9iInG5H69du5TjeJJmGKtdyJt1nmuRmx4028HI3bV8uwSeJOz/cUCwrFbTibgi2TfBuy7Ap5cNYoL9PvLGS4+AtA6/3ZYuvOcjQ6B/ig3qBSDtkKFhzGpxNWGDGBu8ZylDBRb/56nxFh3i9bPX+p53cEPtbV9e8kZcyf9W0GCNXlAXmpWIbXaJ9yxAshyY4dnQRxZz2ijBoLjko8K4uDBsqC0dCnbiUkd09AW2KkJh+UDIlfGzzi7n87u7VWn2n7MaWPZiw9lJPsV2ay6SvIn0J/+YfXydFz5rdKGYVWVQGhHuMAY9orlJKqQkwBdWXnkYxIP9NblC6lJfupWlIEULcgkjLsdt3rDIC+DYwFMZq1q1gJm+vyoXkiEI1o7uQ2qSEF8arX8uOg95Un4sg5lgF21ajlY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(426003)(47076005)(2906002)(336012)(83380400001)(2616005)(82310400005)(86362001)(36756003)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(6666004)(5660300002)(316002)(8936002)(8676002)(54906003)(478600001)(966005)(70206006)(70586007)(4326008)(6916009)(1076003)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:00:23.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4fc3e01-2b39-4aeb-a4e3-08db66a722be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6031
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
Cc: Felix.kuehling@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In kernel amdgpu driver, kfd_wait_on_events is used to support user space signal event wait
function. For multiple threads waiting on same event scenery, race condition could occur
since some threads after checking signal condition, before calling kfd_wait_on_events, the
event interrupt could be fired and wake up other thread which are sleeping on this event.
Then those threads could fall into sleep without waking up again. Adding event age tracking
in both kernel and user mode, will help avoiding this race condition.

The changes for The user space ROCT-Thunk-Interface/ROCR-Runtime are listed below for
review togehter with kernel mode changes.

ROCT-Thunk-Interface:
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/compare/master...zhums:ROCT-Thunk-Interface:new_event_wait_review
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/efdbf6cfbc026bd68ac3c35d00dacf84370eb81e
https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/commit/1820ae0a2db85b6f584611dc0cde1a00e7c22915

ROCR-Runtime:
https://github.com/RadeonOpenCompute/ROCR-Runtime/compare/master...zhums:ROCR-Runtime:new_event_wait_review
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/e1f5bdb88eb882ac798aeca2c00ea3fbb2dba459
https://github.com/RadeonOpenCompute/ROCR-Runtime/commit/7d26afd14107b5c2a754c1a3f415d89f3aabb503

James Zhu (3):
  drm/amdkfd: add event age tracking
  drm/amdkfd: add event_age tracking when receiving interrupt
  drm/amdkfd: don't sleep when event age unmatch

 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h          | 13 +++++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.34.1

