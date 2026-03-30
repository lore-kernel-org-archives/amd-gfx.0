Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4C61061B07
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 14:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A1A10E1B2;
	Mon, 30 Mar 2026 14:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M3lMwn4m";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 483CE10E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 14:57:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLgMPbMojXJOnZv3HiMfvlH3N2m1s7HZDrxSyksF5jJClkNBgKVn8v0bpAt/OfbauWgl1ePjfUK10h/WOlDNNHClT5KAUkdjVwdrQZ+U7Lt6k9B/g8DQGsVmK+Qq/k92/4yhGm2S/KfanW71sIce8F6tLKEPFWyE/FWcMXAZCWdGmNB5p9+7cEcKtd1rkcPDsSbnoRvZwHZuwHQAIOWUSeAEpcWF/9fZRTngrRlu6b3nEaO3vSXrS0QkcBzRJl2nT/4rEe4nO4cZLU6qOFbxAVNmUwGsCAD1SyzPWTuHyjUpf40xt3z5gz4bRKOENacVg8WhXOoaFqaRYL9Dnsk1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R33iQKJPMHGFKdpR30xwLviIKY6tlARd08Cgc8BgNE=;
 b=v7+9AWrWpFezmKe7Yef+HT3twBD9iUYweve1UzHUifR2QN5sffmQ7B7bLF5Hbw5gTljMJz+gyt8bq4IRzY3AIrE2uwB4s2IHJrPLu4RP9ngyvLQSMP6nlk62qlWmcFTAyp5CN2Zb5tTNHXqunXA0umyOcHCuURESC5iLxDkYxlmQOgM0rCOXlu2yOWax/gat3os32S7BT46q5BeogcspG1d75nhgnG6cOX8+sfjDZcLKu32XLgRH/iBaOa9ssYHbAjP9up1NOPbOp91u2rMBa6rkxWrDGF6H+qrzNDvubWZ2rrFfkUnjfq/UJng+dANK+oBMKB79gtRc/Rc3O7ZNeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6R33iQKJPMHGFKdpR30xwLviIKY6tlARd08Cgc8BgNE=;
 b=M3lMwn4mQ0wH28SB1yfnhmwMcWn3rtbMaA7iV5iyWa2J8jiEN6lwVMKzgiLLfmhfYbCdwXpOvdFtfvbN28xWFU3KwXWsTJkIyOZAY0AQmzitX3QGlSgJl0eQLdToXGhdW1wfOOkaJxxmhXOGnAWxwdc/ZZjidar7Fb8mtCSEZP0=
Received: from SJ0PR03CA0339.namprd03.prod.outlook.com (2603:10b6:a03:39c::14)
 by CY5PR12MB6371.namprd12.prod.outlook.com (2603:10b6:930:f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:57:36 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ca) by SJ0PR03CA0339.outlook.office365.com
 (2603:10b6:a03:39c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:57:35 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:57:35 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH] drm/amdkfd: Add upper bound check for num_of_nodes
Date: Mon, 30 Mar 2026 10:57:17 -0400
Message-ID: <20260330145717.63832-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CY5PR12MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: 59619c5b-cf83-4af3-d398-08de8e6cadf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: K8uYSqtbIIcvp3IX1Pno2KvEDDgfKS9SidGqDleFPlMRdUk+LKmqI48sTncPbHi3Nn590dUBV+fnElxZ/k/xoFdDbQhMK3aMOLlNUFhBOui2EZIcWi3J8gWKeoZQ57t041tRZytu66tZHRuUkWmb0o4rgIO0VqEFH3glHVL5nuKzNCK6v4vZEGU/AokGptzl8AiKMJ89zL3DvtuLAVwwDGazK6sr0YAiYLRcDeio3O1ZrSMuTSahFXFZ19/xuG/iqSRekEhmItlY4rwCBUCNZq9pm/82zEUABdgjeR+YwiywFrmkI7MsOvH1dy5oWfZZFCLQ/vH5oUGHAIgNH33sySy9YE6qhZVREsyFSzcbV6UpWYpBadohLZ7275c46BZVJwIk9z2ZwHLmK2+JRr+zreJtFUvKFop8foiyoBCYw+qo3VbtXYk0qV35oRLcZ7fJ8+EUJMB5MDv7B6v/5FO0h32hzCokixmU1CBkjL+mEOWcDP99B9CIt3g3rKgtWV1IaXtzGaQleOCPLhWTtciWxzGyDi+Tlm4d4OXtEs+5+9V5gkyTj0j0MGf8HeeCd0LVfCtr8DjpG4BQfsa/QstEw05mDIkXs9Q/8ccslYiTuOJPHEExOf0uqCv2ThmWR0VdHjPWjEu35kK8vsFuQwpYTb+bOpTKIiD4EYg76nJFLHBQxFtmri4qAeo/mvJ4BuoBNH2VUR/O3qx6E1lkrJ0qZ5BB9KQPbfq3zCw24LDoiUaFCZZ1IOLYyfhumEKGAxlwyVQGL/Xqt6HghvW0ISIWRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vJpjosW4aaHXXzgqhMAwWwv0Ra4LnY1VVm1E+Hu+HWao4TGRokZw6b0lkbw01VR9fHqdnYiTgeUGD1x9TTWGKVdzXrqbHT1GS44hxkhLbxDo5JJ+GSC+QfzEPu+qY+Kg6wdKWKXM2+a55FXHp7EWn8CsZL2T5ib+Q/tdn2kJzPop2rE+ObpWx7M3WrG4IGolPFwYp7LMIg+2HGIB1r3ox0zL0B3MjZB2vAU/tHJdWV7uP0/L+tOOqcJgYE035L43RL4DeXqo564wuvNFP15SLQX8AvIF530W/SY0cguwCc4zOs6mIi8/iMSF9LxU6gfrQC1AEM71+9kZkcJnNhG2H6cRinIs73x270c591dc7ibNjg1qlWbxd2KgtN5Cq4qCWW1iMUFj7unWZozArYZ/l9mmbzeyl4Qb391M+fsv5CfYrNo5q+1zmL+YUvJAKDmP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:57:35.8205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59619c5b-cf83-4af3-d398-08de8e6cadf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6371
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

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1db565442c48..9e37c2709083 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 		goto out_unlock;
 	}
 
+	if (args->num_of_nodes > NUM_OF_SUPPORTED_GPUS)
+		return -EINVAL;
+
 	/* Fill in process-aperture information for all available
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
-- 
2.34.1

