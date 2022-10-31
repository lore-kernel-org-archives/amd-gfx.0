Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A277AECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614C710E2DA;
	Mon, 31 Oct 2022 16:25:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D1E310E2ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2ZsfNckhZIJZ/MRsFlOaK0X29DoX93OzGSs+qFkRZJjDkfjPiZdUgX1eYVg/7HoBPzgn6lqTUPHVthDwJ1pUdue+42Q5Tvcdn52+o1TY0F74CtIuNnGRHfOM3JEO7mPBd0vHIcFWuopI/Ii+ndpgM2cJiq9IkXWLvXmY6Zwadwh4wNtj+rLJwry11tkGLXHLkiad9TURcD5zaHQdWeMaWXkeAEVmNUoZoPpyRongkgl9J1KJ4rwtg+lYko5byK7mP2JGWR6WQu5GvLUQzelkAxKRBnXl+MyHOSErBThhmxtyxUPRcGFXgHj8f6XjOsk5B1rvui012WkWK2QraNrjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLIWc1vNGJyV4sFyDqqngxS/Vs1kugHUqa6X18YLD28=;
 b=UDgE8OaexrClbkRqq+333S1MM6YCER8nPnXtBhMHzPC/19oDmf+1ex/LGSG+arD2DDO4MhSlWbXHbd9FIMJxnqUpNHpBLX48VGFFF3kqcRvsydFRpQws3kbadeXiGVSdzJ1/rL0BxQaKGVu2olaySdzMn5FODYAacp7ymNtrJoAqnub4eXb0EsP29uafcHv1NPWd5zPVMKabT4B+0vDM0xLfuMzBzVvFLMXEYJ0e5FgJjDodHeh0tg6lwPb4iQ1iND0qmX4jDR1F03+fd3kh21RIuy5ysB3OFIGXSaY5mtZR8T/g3rpvXAXaXLQ//FCvA977aKNc8JaL+Uku3kHLjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLIWc1vNGJyV4sFyDqqngxS/Vs1kugHUqa6X18YLD28=;
 b=GnBFG33ZIgdDEzpzKc0joSaz990QUuqBUYigqyazLOiHA/Xp7Uoy8TY8gcKlyDYK53jjknA7vLGVYscFWw+NVIy3Xa6Soire7Vl2f66yo0FbijoWvJQqgYeDNhEw80yiLIn76SMdx24bPUz8AR2XxJn2U3SaIqzMKl8wFmw+rqg=
Received: from MW4PR04CA0098.namprd04.prod.outlook.com (2603:10b6:303:83::13)
 by MN0PR12MB6341.namprd12.prod.outlook.com (2603:10b6:208:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Mon, 31 Oct
 2022 16:24:35 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::48) by MW4PR04CA0098.outlook.office365.com
 (2603:10b6:303:83::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:34 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:31 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/29] drm/amdkfd: bump kfd ioctl minor version for debug api
 availability
Date: Mon, 31 Oct 2022 12:23:59 -0400
Message-ID: <20221031162359.445805-29-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|MN0PR12MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: cb53db52-3d74-4e32-eb84-08dabb5c6602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9d2WEEUVAcJrxGpiDyGGVnpx+Kaqq/DfP3aMPRLSlZh6XAwLRmAKD9Pf4cAHvbqryvsIjpW21fTQ1h4qh0AuqCRRnJ5ytkXN58accgMdFE8q8lOwhAgWR1dvmqux9Z65kf9bd2RiyNhSv4XU4+IZEmgW5Q/TGXJhfI6+Jaw1132DEJcx/JMTPcVHvlU66KjmdKkvD+oLpJhd5v9blpn15PNAXmvPOiOktpVAdwocGBD4y32ZlseBdeQwUVsuPNMfW64Kq9yQf/YZu2wwTD9P5NufGkW2GOVly4Xp0rl72kPQKEfwj703YHjOfintJcmGxjwxHGm8xTkGPSH1oXCQHqBPUf6d1OmciyONOeNF0g3n3EXEd/41fh7uy+EnHTvbGXx1w+WIU6IcEi1oJ38fbkAZEK681zYspnhA1SRIBpj4bqOxtt5m5UAuvv9fPTsHgUi9J/fWSZucIvMcs2IhvLrff8lXowBhQ7m+2Vy9g9kZJ6+ZnyRZxopgEdYDrgVyEab66QedzRSMk+1Te6UcGSJejYpEAwSRffRAZzRjRs9FQrT3+0RItTQnIeFt6OyKzQg9AFGj36UEYFyJrKJnsLSIRC/UTlxAGUjSvehmQeHbRS75M/vNkqPzMS4igkrLB2BtOP4aINFgy5eJdWZY5F05KT/OOhriBeplVZP50euxeLo23HfqTt4Qo6kjNZjHIiXYBHNV4MA3+rMPoJZlm37qPSoVu1CGK0fxXW+vo5fPFHpaOfcjD6/X0qZy+mZWae7u9hX9X9Tr8KW2FfvExC80SmB/l92Pl7HM1HlTOwM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(478600001)(70586007)(316002)(6916009)(70206006)(6666004)(7696005)(86362001)(8676002)(4326008)(36860700001)(82310400005)(336012)(2906002)(426003)(47076005)(26005)(1076003)(16526019)(40460700003)(41300700001)(36756003)(2616005)(44832011)(356005)(81166007)(186003)(82740400003)(83380400001)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:34.7793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb53db52-3d74-4e32-eb84-08dabb5c6602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6341
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Bump the minor version to declare debugging capability is now
available.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 1 -
 include/uapi/linux/kfd_ioctl.h           | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 115a80686f7a..2f7d8b230527 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2891,7 +2891,6 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		if (!r)
 			target->exception_enable_mask = args->enable.exception_mask;
 
-		pr_warn("Debug functions limited\n");
 		break;
 	case KFD_IOC_DBG_TRAP_DISABLE:
 		r = kfd_dbg_trap_disable(target);
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index bedf1b823f57..fe5acee2684d 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -37,9 +37,10 @@
  * - 1.9 - Add available memory ioctl
  * - 1.10 - Add SMI profiler event log
  * - 1.11 - Add unified memory for ctx save/restore area
+ * - 1.12 - Add debugger API
  */
 #define KFD_IOCTL_MAJOR_VERSION 1
-#define KFD_IOCTL_MINOR_VERSION 11
+#define KFD_IOCTL_MINOR_VERSION 12
 
 struct kfd_ioctl_get_version_args {
 	__u32 major_version;	/* from KFD */
-- 
2.25.1

