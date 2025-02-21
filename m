Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8D9C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84BFE10EB10;
	Fri, 21 Feb 2025 17:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0UdSayhr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F4A10EB13
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:27:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwxIRSjq+B093UW4uDJMPNkTaMkjyxkVJ1QhlXj7ZKljiGhsE3IhPZqoo+8VqOmahgJhqbdvIZoUIa0lHXE2btKxXrm0ncLFgTmKeTMrOWBobR+8Eo64kq72e9sY93qurxORdI4utOBMAPuK7fCamrGAly3umbNx1NQzbOmgdRcoBa4mU0vuCZOiIwxCPyaMbe8yP92FNTTmH+F/iUNsd6sUXSyxTcYvF93gUiv4yk4XpeQ18tp4kQkoihpndjLRZvpzGzAJsmk2jIvXhxgXqs/QJZz5Ja1ngZORRz1Kr+8eWdLewEw8K+TXPU315MxyCAPldQP0RcUDTE329aDE8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgVETDEgmeAtGY7KfVLjCQsjB2jiW9BjTB1P+2m75Bc=;
 b=bycWRliiYUUE2X/gQiChvcDbjNbCl5bjU0HF97pTo5fp8SpZ9DN+msKp3DcUbTC82rMLVahUTRzH53m/clKAL6m2M2WNDQI7J7dpHIe6BwZVTIgmRb8YXSq+Rx3sc6rDld0wKsl6juEF1+EN9lOdtRxE8yDllqlPPNbS2iQSM7h4oYxS54BINiMzysomUsmekZRmgr7+S5kZMeSdYYAhB8IOH2WOXVyt+IqOCBBimzpnFyBbHwgxn1h/BuKkN/y2c3TGa9+/WxwOwxrPPrh2jU+YeALCz77FaAJaJRXbnFiq0/tnSAo+gtMIMeeYUzatxdKge8Y3soqlmNXQoLXbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgVETDEgmeAtGY7KfVLjCQsjB2jiW9BjTB1P+2m75Bc=;
 b=0UdSayhrcOMSBU3iCPhFptS+mNmPLWvU92ar5qMqokFZzTJcfazRCBUkBfa56k95JWxYcq/jVihEtcwsg6lYo3My1L5lYrpAIj8Q8ZNDAnfQz/Ihu9oR3hz8zOqerJChlmIjC7tKy0XSzZay6weRtYYBaSBl9xf4H/+zV6ZW+GA=
Received: from MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::10)
 by MW4PR12MB7359.namprd12.prod.outlook.com (2603:10b6:303:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.24; Fri, 21 Feb
 2025 17:27:10 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::c2) by MW4P221CA0005.outlook.office365.com
 (2603:10b6:303:8b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 17:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:27:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:27:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] MAINTAINERS: update DML maintainers
Date: Fri, 21 Feb 2025 12:26:52 -0500
Message-ID: <20250221172652.3970985-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|MW4PR12MB7359:EE_
X-MS-Office365-Filtering-Correlation-Id: 9906f5be-f0ad-44f7-64af-08dd529cf8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4c82jLuEjKrZ2JspIk9gzgx/itG6dE+D1NDaqWK4l0xBVZzYmNhFThao0LNw?=
 =?us-ascii?Q?awF9aOahv4XhODvsZD42TIS8CbRbNN0Aw9yIcmUK1MHYZTU080Y22HDLu87p?=
 =?us-ascii?Q?0WV60m3pPwI1UdJWeM+3aTAIR8D0nWt7LmVPuzvk7a1JB1i3lSptzFBjET2q?=
 =?us-ascii?Q?0NfIJha5MZRDz0/dquEOSvRv7MdvkW2RNwaDX7ed4qivzGUcXIsRq6UN5xFt?=
 =?us-ascii?Q?RGzuWOCEWg9JqxNB13BkeIRnd4tN8c3OjEj/SKEl6p8FEAZrXmKR2x+fRSVR?=
 =?us-ascii?Q?HmS4++VLDWMr4J4R46jQwlqhAnZW4wckLASQASw9cqP8C1krzcA3DWolyoXN?=
 =?us-ascii?Q?PKkFmT+539P/ws/8/EsNjc9mEhQ3ZUIqRX2VPSw9job2ga+SsUwN5vPyAafv?=
 =?us-ascii?Q?m8G8JKWpceOQyOuCL/9H4wlIWfYIx+0KKMXDOsgik7lW+9sjilyf3AD4zjoS?=
 =?us-ascii?Q?WjOYF+gg5iX2rVGNUQITljKc4kQiwMXmUbVXdw69hMwQy/dAqGxVMyX414aT?=
 =?us-ascii?Q?nkcEtCU/+TsmQuJL2TPdnOyLrt9uwCG9WcZkzgfxDFNeaoHUiooFiGyWYwYr?=
 =?us-ascii?Q?KdVqu7r+2o0Zz8J9yc/JZtdx0htT3WdOiyQCrs9VRv2I0nREoRP9Y/FwfOMd?=
 =?us-ascii?Q?H1+asWm06vIpDV69eazApySqG2l0RFB+I0eyyzg8DugUGdYZkp4lb4q7O5Ff?=
 =?us-ascii?Q?1e0V9lgNprL4kFksZ4tBPrlH1uJ40BDvzox/DFjqWLpHm0pmr33837t3bTEv?=
 =?us-ascii?Q?cjMflzx+lzYJU3KcH20EqBUwga5CUz94V0WaD7sAxgH+1N9kSGZgTiGU+0WR?=
 =?us-ascii?Q?js10hza6LO35ZXAdgPTiJpPWuH2TMTmJvOdTrr/GRbUbjXST13cDU/0tYzBz?=
 =?us-ascii?Q?p5vad+XCFfnI2gORwjjYcxt1fslv23sw5hjE5pA3Moo6a4SYFbeK4LTe+rUk?=
 =?us-ascii?Q?SIb77TssdJ7EPeyZEB5517uODdDaXtTWIHd4BW5K8Ryv8OzrApvKssMOT/dQ?=
 =?us-ascii?Q?ZlHidJuCrJ1PlXXVUIs1HJTn2NvquZ6UHKokt8nRl1TPFibxJ7yD1Jp89FhZ?=
 =?us-ascii?Q?iIRwyHcs0ev1QsPr6cXU65kax9EFqWVhSokX4u2IQEA0B0Zh761BvW4fYjFb?=
 =?us-ascii?Q?AX0nvWci/QytTqMHDPzZZqlQzb+13zgkMPNfWfBCrIfkOBL4qmbUBjWxonWh?=
 =?us-ascii?Q?xrtZWh2S+GsWxTcR57MK4JNwFSd0VmAbl3fBLnm3+3fKLALcsb1X4NPSQGx2?=
 =?us-ascii?Q?NZozQOzUCKDqntm+pDWhp5+I8MPK92w+r6BxCO2g7oJtLxqINyV+AxpDoyMq?=
 =?us-ascii?Q?w9qaA7CrbRjao9dhabxGklPqs1bHZ4Mw1kYLsdELGJnvOL3lfxGQoCjE4RKi?=
 =?us-ascii?Q?YrNo58bYSrGYcHGImFhQ5J6IO+rc6wOE02asXksYVfbxhkXtsTg/wY/G8eg+?=
 =?us-ascii?Q?CjdTXIEUhBY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:27:09.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9906f5be-f0ad-44f7-64af-08dd529cf8e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7359
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

Chaitanya's email is no longer valid.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0845a8521e929..b37fd9fd5d551 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,7 +1031,6 @@ T:	git https://gitlab.freedesktop.org/agd5f/linux.git
 F:	drivers/gpu/drm/amd/display/
 
 AMD DISPLAY CORE - DML
-M:	Chaitanya Dhere <chaitanya.dhere@amd.com>
 M:	Jun Lei <jun.lei@amd.com>
 S:	Supported
 F:	drivers/gpu/drm/amd/display/dc/dml/
-- 
2.48.1

