Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6CECCA490
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 23:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9639110E0A2;
	Fri, 16 Oct 2026 23:25:33 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0FC610E0A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 23:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODGG8XIccYjhM+XtasxW8761c90chkXaGhcj4HIy0agh+MXpdNgIAOZYiVL0R+PEfZY1jEPICc7YWh+YVUoUqOoJAi9RtieoECAtIv9G2DBE4tBnFHHt2HXHtSPWaDF5bqUmkUosQgCDNDXjoxKOlQVY5/nNV3MBK7POl6Jz2gqxE4a3HpTrELVwe4LnhVtGw2pHJz+/vM2K1hrqXNTNDTp1q6lkdJNKXp0UjaDCeWG+YIcEHwAZPFSih2mMon5Zd4njb5Zlr1OcQWX7Ef3I388l0L4xaMUxtyAaJX9tEVrwjgWG0yPGsCXhenE6kubcZVElxhqYPG2hmTylRtUC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6f7ivo3onvJsI+A1QkxCxVtd8xTRmixhrtyTXojsRM=;
 b=rw8HCHkB3vM5xPY40KcArzdmtktOyNnc8oxSt66wyaUXLCDBAkw5b/jNWTT2YGwC0+zOCtA3ujgSQ0JbNFb1X8O+iQl33Iq2N8mVjAQ3QFU5EIorinxJCZpkSfCLujOiP75QGNM2MwC7OVO3F6FWshtU2BWxMdk4zTZcDgbp82eGB4eExXJ0PYANDqztjVXCI+CP6KVdd06IsLpuoixOSsEvVp8IX+iVhtzgGHjFVS86GgjRhlbHSvUXC6wkfIix/kxvwrGssl5w4yoO8KPjGmf2pNHKYFvtuEwKw2p7hmKnO/lTO95/UHgXmDPduoFu9GBSfXXQ/WJxwFJIHhxwzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6f7ivo3onvJsI+A1QkxCxVtd8xTRmixhrtyTXojsRM=;
 b=eZXoTcpg3Lu40vkBwWdQs6mniyTs2GmwEQDLB9XuGDox5eJOIIA/k2aiO5/C3cr2d4Vzn264K1aycQwDtR5gARjIx5RZrthz79Y6S3LzA9nq6xeV/VYGOtLu/Y63o4V2YfASHKu5+kTo7Jn6GVS7xDW5zPDQVHJzeU7ntGV3CJw=
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by PH8PR12MB6865.namprd12.prod.outlook.com (2603:10b6:510:1c8::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 23:25:22 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::65) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 23:25:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 23:25:21 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 18:25:14 -0500
From: David Yat Sin <David.YatSin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, David Yat Sin <David.YatSin@amd.com>
Subject: [PATCH] drm/amdkfd: Bump KFD ioctl version - SVM no access
Date: Fri, 16 Oct 2026 19:24:58 -0400
Message-ID: <20261016232458.3343066-1-David.YatSin@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|PH8PR12MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: 21574697-d7aa-43ba-b6f3-08df2bdcbf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 9OldIwd/9GOL8dk4OB4Wv0ipf5JFGF62826k6AtmXwc0T2QnofDQN2jE6su/n1Eyj0I8yiMymzOiImFPAJaif4wMuDNxmWGG+S+XdeQYP0bEG0IGRUg77y1R1SlVtNFC/M71XwjyYxm9HLz9HJnnsCc1aHxG6IBSfVtNbIgioFbJXQI+GBv8rQ0IXMo8xCFPbqf8sz11p1dc5ST4ih46a2fUcxTDAzHRxVB+AG0ED4EEFo8eivR3SxuxChAz4obi6pSsjUZftNpXLCC9lAVGNrhqNwa8WM41ODf7m3BU0R7KmrXHDiHJYpyg5naXP4fWZ3RFb3Qnd8JjpLmkrGtciJwEupGzW+LQKZx+67/BJiz1QtZ6TMIJVqqI700JwBaxcpfC6ybBm8OmQMPNaCsFBDh5n694D3vm8EJgeuXf6Lyrhf4CpbruZTDRIlffELCLsE6xI40R8qcXgn0bONz6RYCAiR7Z2NHyaXqj0doNt2PfckjG96rJgAC4LzQHUVfoxnK2D69R8eUI++00XP8+JcQUaF2wottvHoS01hauR7rV97/xUi9PkUl2p2s9+DYFLTthsN79T5h0gNolUOn14N5ksqr5ncJo1xaBx8iHCkzzu9E88FW6+jn2XRN8eG3z3DJ9//w7dvCua4JGkRf3ibnoGH2KGOdyFYHM7EX0stp3aYXKmXzHzfIa/jaJwIY6JLZw2r1+Iqn3dnZpUsDFjA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BubO4jiVWnPPUujMFW7H4lIvELRfDL+4/TGu58kUi/a/4Y64u3ip5JhlZMBrI5jvoDhWYJmtdwTUwXhAUEuudK55m0C3p0YK36cf42alsmHdCkICFacRYMO4IcQeFPYHngrvsTmOcwY4O49gnEpZKLtkUAt8GGwsxi9EQXtEuDUmvWwVFLBRBxLI3HHzLk2pJG8bCml5pEER05rwzTcUyadgstVMiHP964Ra7PqlKf0y8IjbcgwtUY/jNfxcBkEDCxG2k7RUeWpue/inHyVdNxID9HKmAD2W8YN1z7/6kzvg7RiXwOBlWMtBp/LGZoxqvjbVYrTJCgzioZcvFd08FlJ39yDKqMt55wgutuB2kBc0nUcKSUwNXBh6TH9th468kMNQrB3s03zBIczKif1Ll34g5gQWt1+m1ND4CnvJR9Tqlu7ukFhIqY4rv28MeJNF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 23:25:21.6145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21574697-d7aa-43ba-b6f3-08df2bdcbf8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6865
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

This is not strictly a change in the IOCTL API. This version bump is
meant to indicate to user mode the presence of a number of changes and
fixes that enable setting the SVM no access attribute.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 749d196e2114..564faefe6978 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -49,9 +49,10 @@
  * - 1.21 - Debugger support to subscribe to LDS out-of-address exceptions
  * - 1.22 - Add queue creation with metadata ring base address
  * - 1.23 - Add profiler control ioctl to enable/disable profiler on a process
+ * - 1.24 - Enable SVM no-access attributes
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 23
+#define KFD_IOCTL_MINOR_VERSION 24
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.34.1

