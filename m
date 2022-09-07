Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB1BC54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 19:43:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F5510E859;
	Wed,  7 Sep 2022 19:43:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B3AF10E859
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 19:43:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjK5HBuIdJsW33Dt1ORX84iG7x9A65Z7CTNQGwp6s2Ng7OQauGq8Lncf94s1ZolIiGK+AIBKSAkZrAkLzGKCN5rhROXMLGpmQfnIdU0B7Lq64xZqjLfHSrFDmO7WZhFFluUhT+TAvap0FwPudOg+cbMb3waKYD9tdsJPGJVGFngNkIabKncjijv8DSlkw8cZZEP/23VQHISTu9uWKYFOYX+mFh/uSESDT7KmseaIeEz+9P6klZFACz4tNL0ihG3wgLQHT6L6ZJKPSoxGM3tJfjLeMbExkswNkzfH9TGFBmQn6ofdPkFDHDSr6uqnMdDKbH//E6xtqwlA0TCsdYaa1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pi9u/GGQLJWVK6uhevKfjBkskjxD/QVGBNJ0ABEmAU=;
 b=mkYv+VztuVNTHhDexcIIPAZmt5Fv7X/tVi8hc7WJJZIncQUmAX7Y6I1yV2S4IaeTuaWKQgiXAWbtxNpIIMC83hjA01SqSCWjP8fDYKhhHRB6zrQvfHjPkWgphKdAmFSlJbXYs0a/v2iGngfkstXOnjGkpSHunqbGSTWyBG0LC7ObrwjwaQDw7f0dGFjE6PONLyncGhwgJaL8NpeTDfy/cyPtjDYgdeYQ3vUTR0q4qO6uwwqrn35vZQQfxXfM7P1e0NI+bD/jQaiKVZ890E0r7/4a7Rrhhogu5Kzk2h+XBp+FQWnOfV+CUrVN2K/pxVcEmZQs+VsobRFYsZv/iJ9WqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pi9u/GGQLJWVK6uhevKfjBkskjxD/QVGBNJ0ABEmAU=;
 b=Oqm9nF/CGsNkdNKfupVdiWue3HkIi95Vahg3eiOzgANmyNE7amxL5kYPyl40QWYwXxhoRiVVdmviFlSNDsbAYPvbgUdoMVUDVDTBOxrxHVgonZg4TuHv3f/HwlFNiIpa12Rg/R/Z9REKFa0R/l9Pip1hzvH/n6Hd12Y5Z7qqa5Y=
Received: from DM6PR14CA0041.namprd14.prod.outlook.com (2603:10b6:5:18f::18)
 by CH0PR12MB5371.namprd12.prod.outlook.com (2603:10b6:610:d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 7 Sep
 2022 19:43:37 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::68) by DM6PR14CA0041.outlook.office365.com
 (2603:10b6:5:18f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11 via Frontend
 Transport; Wed, 7 Sep 2022 19:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 19:43:36 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 14:43:35 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [Patch v2] drm/amdkfd: Fix CRIU restore op due to doorbell offset
Date: Wed, 7 Sep 2022 15:43:24 -0400
Message-ID: <20220907194324.22235-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|CH0PR12MB5371:EE_
X-MS-Office365-Filtering-Correlation-Id: 18455850-d6cd-4c86-f2ba-08da910941b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mL3nrqJB2TuMBcqYGiPOVVonhqzjv2Db5tK9JKcIicU+KiKXGK3wcsis2XlOleAxry5WtdI9fpoaS1fthhiN8VMWmvlKlfrETXPJSBBnBM2bZ5ZdwRrnaLl1RyWXXarNMOV4PpgIlYG+Sg8bM5uQN23DF3duJ2JIrTlLZ80BLualJ6zgcWGOLZnnfqxBhuxvdxFl5AMxzVh5MWVVa4p31/GcnU8duReCntzlvIzf5w9yzt/gJoLYpZ70fttJtWObd7zMw4FgBTWkmWNzRtuj6qia857EvFy01YIF/gpmofRaYO/gd2EnBq9IjWyRnjIcEN81hZHe6TEXdyyajow1rAeUuwLTTXDDF8av0DneG/+4yanaQaRQWuLYt3+oY3kFcJlHYAxDcyiqmDB7GNyiH7c2/zizWTs2cTdLz2tYwhuiZ2ooFa7MjjDKzCwJW28VEC5aeD9YEcItqT9jBHx3KHV4/fmHWgu/KKStHd3qyMeTxpS2FUtYaXo2xH4Mf9f9qyG/WbjTqnX08CXr3Jqs717vxJDLoSYyOtyCOD0+LkZoojjSA5zj/tXpcBQqxUMZ/C0P/TA62Yy3+rNyhMT2d+7RsYPOgFPeBsUWyHPM4g+/eGUhveVXPVEE4/wLzQ8TJXDPJt0apbvKYV9FHaFSOr9IZAR+NgTdALxSrFLd1CVRbxIC/D3XcnTprMZvDRwNwVBMHi+eCFf+WD9WuCsUiOo7YaVUrBUvZc/WXlnrfAVhLQCpdCXWjsTG4lC+IQ5fIdtihAQ4FpYl2YzunBa1IzxaUpqrzRL40J2FhdSIdpP6fDY8KOftvO+rcimkwGdL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(40470700004)(46966006)(82740400003)(40460700003)(36860700001)(81166007)(8936002)(44832011)(2906002)(36756003)(8676002)(4326008)(70586007)(70206006)(2616005)(6916009)(6666004)(478600001)(86362001)(316002)(54906003)(40480700001)(47076005)(7696005)(26005)(1076003)(356005)(186003)(16526019)(336012)(5660300002)(41300700001)(426003)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 19:43:36.8298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18455850-d6cd-4c86-f2ba-08da910941b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5371
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Recently introduced change to allocate doorbells only when the first
queue is created or mapped for CPU / GPU access, did not consider
Checkpoint Restore scenario completely. This fix allows the CRIU restore
operation by extending the doorbell optimization to CRIU restore
scenario.

Fixes: 'commit 15bcfbc55b57 ("drm/amdkfd: Allocate doorbells only when needed")'

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---

Changes in v2:

* Addressed review feedback from Felix

 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               | 6 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c              | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 84da1a9ce37c..56f7307c21d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2153,6 +2153,12 @@ static int criu_restore_devices(struct kfd_process *p,
 			ret = PTR_ERR(pdd);
 			goto exit;
 		}
+
+		if (!pdd->doorbell_index &&
+		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+			ret = -ENOMEM;
+			goto exit;
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index b33798f89ef0..cd4e61bf0493 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -303,6 +303,9 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_inde
 	if (r > 0)
 		*doorbell_index = r;
 
+	if (r < 0)
+		pr_err("Failed to allocate process doorbells\n");
+
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6e3e7f54381b..5137476ec18e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -857,6 +857,13 @@ int kfd_criu_restore_queue(struct kfd_process *p,
 		ret = -EINVAL;
 		goto exit;
 	}
+
+	if (!pdd->doorbell_index &&
+	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
 	/* data stored in this order: mqd, ctl_stack */
 	mqd = q_extra_data;
 	ctl_stack = mqd + q_data->mqd_size;
-- 
2.17.1

