Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB5AEB64D8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 18:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB18510E09D;
	Thu, 22 Jun 2023 18:25:27 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AC8410E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 18:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2aq59Y66mUXdrIpgyTCcmj4wd6mJOEYUy4KEnuty8QfC6WmJ9Ozfd/ebJp6v/lBFeakJmLviat8hKQJ1j92BeLjN9gKINpMW5LXEzGt/spCI0u6mCBdsvZCdcz+kAlTzmohifwGTAatU9YS0xFIj4NeyTAI6vUvwLZPiwqwILXwXu7q+vllSBejiyJxby2VR+bpI18DTY9QfqK3U5SjYRY7zVP5AyAmwLa7nNxMP6Kj2cK1xyZGjAo0QpYCVkXkh0/2ap2AW+4uT1vB7Fpi+bVxYjmEKF+dkmIY6cWElLHCi/P7k+rpt2FP0pjIlVt0jwbTEZxzuO8EqDRhHaMvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnGOtRyeMpY4qtcvuTCunJ40zSbDJ1G1XDfNYOPgqus=;
 b=NCalBWu5oWCCKsCfJOUA94AXa6fxXfaTbAAkUnAi0t969Jy08qNasOyPAythDlMdqcZZNdKjm9R+mS9Exf35U9m7Bz8qIIyOcb7E6QGcWg+TJtNWD30atg2gofokVmi9ZWCRjvI13ezGU81qbeZnbiGdI2vUQP0OS0qn0JEXfB7II+/6DUvTXAVqad/j+cA/M4pXbd1Wowj5HG/FClChvj6Ig6fXFVgDP8vPUhxcnBnRKiVXBLktyg5uBHZm0C1Nhj96c3jTjH54/JrvOffvpXnzpHvFk2O/bDEc91iwXRnkohLpIVhuIutZl3V015WhMSRG9tPZ+yenycWe1wi4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnGOtRyeMpY4qtcvuTCunJ40zSbDJ1G1XDfNYOPgqus=;
 b=4jaATxuJ3nVBH3H4WRh6B0xnaNUhrFOhXre4vf5mu7nWM4n+rojiy2WrYLn390iVqZnnkq1lX6tXie9piDaUtU+Q1acszw6rSJkVyXswCNKb98oV1Pg8uEjjL5sPdIkNehUsL0EkvZJ+t+Xcesb0c38txmqOeJ2td5AfuHvQh4w=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:25:23 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::1) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 18:25:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 18:25:23 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 13:25:21 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/display: Correct `DMUB_FW_VERSION` macro
Date: Thu, 22 Jun 2023 13:25:04 -0500
Message-ID: <20230622182507.25531-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622182507.25531-1-mario.limonciello@amd.com>
References: <20230622182507.25531-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 33d62cce-0568-46b6-17a4-08db734e0b36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQ/rRFxYcpRc0Z1PuMh8RU4vpTU1OQJvAa7PG9Z/4Kf4xYg5Xsj3JMGZt9W2eVjgBTt/10K87/EyB68X7PRSPKogrUuP3pixQtYuOAkYJWQadmCPcw3lpRLHOcfdcfmMK+SHm508rvnIP9auEcFylKhxu5+Te3ZKV7l8T4OokJm27xzWXlA4HYFkQmvXxrQLoCx3CstO5gRk992tG3GjmgwM1The/oQyY9/oYJhFXM6MzQyweHsFSgimBhVzRei1WZl0iXgworeEFQpEV9LuCtOk8h0X86qKFJr293kUZNWypAJ//E6TDpQrU0R2dJGoefgwXvnUV70uCgzDKNWmnZTB2h6fuHp9yUf5GPKjznQUCTXTe/Vxl9LcwBBMSzJfqOhU3KoSXbtmPD4Oow18HtlNd3QyTPKv4xAtCPXvyqHgh489Nse54pFdpFns4Tzz0ZaSPOBctmbpsZpNvvkeUBdq13uF+VqpHUp+xtpiCBGbpKV1yw9lKSihbD4oY37YaUzrrZ1VfOmshuhTt0jFfylrQmYDxi/sC3sJaQMiNJN4c72DCXDPF1rCxFiIMqtHLSZXy1TCNKbXAzqfX6yEDayl61uIcNBApcuDD8t+a1KQ3CbZlo630Nh3Mw65UM6A90M0xcAU20Tp51tk1JjTE9Dq9hzJVaZ/VNHfE8fF3bViAJ2dFyOUgTLHQiEc190WSnwEakVP+4O4c85VM0eBhC0ns7qkRj14e6Xreq47Zd95a4asacA48SWpWuDTGsupSF66Dj2+Nyn/R46EDp5WPbjvn4SSpIfKztpr7juiGU0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(70206006)(4326008)(6916009)(316002)(70586007)(36756003)(5660300002)(44832011)(2906002)(8936002)(8676002)(41300700001)(40480700001)(7696005)(47076005)(54906003)(86362001)(478600001)(82310400005)(6666004)(40460700003)(16526019)(26005)(186003)(36860700001)(1076003)(2616005)(336012)(82740400003)(81166007)(356005)(426003)(83380400001)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:25:23.4232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d62cce-0568-46b6-17a4-08db734e0b36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The `DMUB_FW_VERSION` macro has a mistake in that the revision field
is off by one byte. The last byte is typically used for other purposes
and not a revision.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7c9a2b34bd05..2a66a305679a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -492,7 +492,7 @@ struct dmub_notification {
  * of a firmware to know if feature or functionality is supported or present.
  */
 #define DMUB_FW_VERSION(major, minor, revision) \
-	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | ((revision) & 0xFFFF))
+	((((major) & 0xFF) << 24) | (((minor) & 0xFF) << 16) | (((revision) & 0xFF) << 8))
 
 /**
  * dmub_srv_create() - creates the DMUB service.
-- 
2.34.1

