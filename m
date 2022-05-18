Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88736C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 19:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3650A10E343;
	Wed, 18 May 2022 19:16:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 581FE10E343
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 19:16:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ho8edZ+v/dHdq6FRV4m/X/WfXjgMl3j48hd3GpC5q7acNxuBEiiYjYWik/4w9v2VoeBeEGzC6zkKiO2PWPDHfUGzG3NKoI1VpnFwhQeDluAk/p3SVFSEqv219SjTa757CKdQJQ09YevpgC0/zLh+Zl+N/dwVlHeCZkVT8eicjjV+t32vU/3e9KWSyYFxIwja6fs/25KTTQdsM9kezR0gm1AV8Aj36RM43uz7JphduLuZrfpP90K88E3tkqod/FaWFZFgqL3YxeG+Z2/9+hUCV1pHPrwcscfrphha0Wf0pnHL9/XYg3ePr6D8kTos9ghUEegGJyWfKOiARqm8zSBlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtPPo507ToTuU5Kcr2lTgJZGpL4Ey2ZQVdx+DhddHx0=;
 b=E3UYnOgigTaYN0zbuBLr2L3RDtSiXs5e+cxAd7gH/ZyX48zi9UTmG+IFpUacHmq5xlOcuPuaFQqXuadFuQ8ziieLXMWSPWwDEiGPLv0hTKMh+3ptIJM34aBGs54eQ+Y9kIchfqK1CgaMPjNSl8zGPLX/GN2zsY4HSu27FV2AdQwO9YZfQ5Zhe14579kyUdNcWFrW30tD2YN+Hr0K7I3ow6MfGX2nxOWy+sKzXj4lEBA3qV9jO1uwBn0MYYriQVMiUfwUeLs4IWElgMSKxw/nzZWKb8t5v7S5xSNvd8ra8lPNWaptYRbP1cPl+tJ8WY9LkFaoEsAeog+NPnhVLlTyjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtPPo507ToTuU5Kcr2lTgJZGpL4Ey2ZQVdx+DhddHx0=;
 b=zNTCeWxVM6zOAa3+hdMfhErJA46sVNZ3Bm4iEfjWuLWHoHEnnoxR9PAQ4S+x5xAmjBzgNQaaseweYUYxuYMeFqWcplqyNF7ecVxO9qTspl6XY3+LhdyNU4w6ezcqlBPSLxVlNUdJ/SN388eVnllepOg34RdOMYQpqcrZsjZPw9E=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 19:16:32 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::8d) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 19:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 19:16:31 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 18 May
 2022 14:16:29 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] umr: Completion: Fix regex for PCI bus names
Date: Wed, 18 May 2022 15:16:00 -0400
Message-ID: <20220518191600.5832-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 757931a4-8f0b-47a0-d534-08da3902ea71
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43756C05403630E8EC9B0FA799D19@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pkG8CwQPPsNHaGLgPsXUmRIbzV479aDyvUn4bYrX/vWzbcW3uehdBbGYoW00wMkg/z2F5rqLu+U8fTBNyTTIyvyFhvt/PXdvyo4mBUBc1nVH8PzrTy/USqTcvk/hjw9nsJvkYnf6mEvEZRFLRrGjYOXABqlWUFxZ7kmGpfqjMBqCtSjWSbSdVjRopLjKQI/0Wl1iuoql2hQXMPVM3HsErpBDhdQQAICCOAPPENY2dDpBr0WsJV9IJMRFXLZOlfJC2m+F1WnBgB2HUB7+JVGHws1OoSG780PIbN4ue2+++73RYKgSjk3Jp5XdGFokR9mkHmQF9qBYqhA4o8oDz9fcuFn2L65VP2wiyXyQHvugWnnz2+zCpvtaV09um8hJhfD2xY2FBIqUO0BLjok1ryyRWsvlxyb8tgIPqZOCMSaEi7kB/zBJ8sfA/LI3YiKqYTJN+BAAJdJPPyfKxGH3sdZYxjo4efVbr7d+Xm8IYyb8+e00rIXhFV/u782mS91cNS50H075NyHN5zpM7WVRE0J34AuwvqMRNqxmISaiGQj5NlirWdpGU8mdFYPcXxuau65sJKeRY8+yZdWZTG+RwehlhK4BhZTLuI4dAiKcTzWOYRzFhf8HVeBaK9t47ngaPs5yL4sI/b2iHx88x7rPmhAcl6TY4/u/p6EYnceuT3y2SCGh1vXPiQNB/f/+YvhtGpRUh2aIddjVSDNZdQ50i18bQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(26005)(54906003)(86362001)(82310400005)(40460700003)(426003)(316002)(336012)(6916009)(6666004)(356005)(70206006)(81166007)(1076003)(70586007)(47076005)(5660300002)(83380400001)(2616005)(186003)(2906002)(7696005)(8936002)(36756003)(16526019)(8676002)(508600001)(44832011)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 19:16:31.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757931a4-8f0b-47a0-d534-08da3902ea71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
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
Cc: Tom StDenis <tom.stdenis@amd.com>, Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix regex for PCI bus names. Previously we may see something like this:
   0000:0b:00.0 master=pci:0000:0b:00.0
while the correct output should be this:
   0000:0b:00.0
This commit fixes the regex to do just this.

Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 scripts/umr-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/umr-completion.bash b/scripts/umr-completion.bash
index bd0b61b2d38831..0b8beab97b9aec 100644
--- a/scripts/umr-completion.bash
+++ b/scripts/umr-completion.bash
@@ -128,10 +128,10 @@ _umr_comp_gpu()
     for F in ${INSTANCE[*]} ; do
 	PCI_BUS_DIR_NAMES+=("/sys/kernel/debug/dri/$F/name")
     done
-    PCI_BUS_IDS=( `sudo cat ${PCI_BUS_DIR_NAMES[*]} | sed -E -e 's/^.* (dev=(.*)) .*$/\2/g' | sort | uniq` )
+    PCI_BUS_IDS=( `sudo cat ${PCI_BUS_DIR_NAMES[*]} | sed -E -e 's/^.* (dev=([:.[:xdigit:]]+)) .*$/\2/g' | sort | uniq` )
 
     for F in ${INSTANCE[*]} ; do
-	local PCI_ID=`sudo cat  "/sys/kernel/debug/dri/$F/name" | sed -E -e 's/^.* (dev=(.*)) .*$/\2/g'`
+	local PCI_ID=`sudo cat  "/sys/kernel/debug/dri/$F/name" | sed -E -e 's/^.* (dev=([:.[:xdigit:]]+)) .*$/\2/g'`
 	local DEV_ID=`cat /sys/class/pci_bus/${PCI_ID%:??.?}/device/$PCI_ID/device`
 	local DEV_ID_NAME=`grep -i $DEV_ID ${UMR_DATABASE_PATH}/pci.did | awk '{ print $2; }' | sed -E -e 's/.asic//g'`
 	TEMP_ASIC_NAMES+=($DEV_ID_NAME)

base-commit: 513ea1dc11b4c0fd0c94910bf09dd84517febcae
-- 
2.35.1.291.gdab1b7905d

