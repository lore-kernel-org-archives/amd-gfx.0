Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43ADC561E6
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 08:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E9C10F146;
	Thu,  6 Aug 2026 08:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Er6bQ5yh";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B59AE10E2AE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 08:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yw7SO5EmDtWrp3Ia2G7CH0INGdfUHbwkqzlXDDW+eQyc79FSqVYMi1BG6gJtWDebGt51Ge0MaPaG+xVrANjqTziVB5f7CEvxAXvFKzYC2FVHByLJiIcnrf+8J57AWRTnkHXg0GLAw+G0CiPU54FN9zLcUJ42HbVxySSSRpmKg456WiIxQq/ZwBNjub5rsIYeekzAQV6nxoQW/Sy6e8qqungbR7kEzqbNHgAiig9d89ALN4BV1w+21x62HapCf0bpcAMIJG7WKjdWS3dfDZJm2x+HkrieCvaLhbXYggml3JH5jF+ptUiuyDCiagyHYyEF/vpLlwXn0s2EyPNuV1rzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shV3GHhpWpDTDpQg9lNm7wHuks5kDsygyEu/byCNuUg=;
 b=DWkE3CMTl7E9SNs/FdWs5Y5y4mW1nGOpfq2H2n5RWkQIEh8V35AFnWA27YzZ9JBFW9h+W2yrTC0u55bcNPqn9ceucEqbXpWM5IGTWWLdbuta59bpYHRSC8dmSOr4B6CevHaBT18nZ2OxxFnQStpCClqa/mfvqJ81tB700bBKU7Yfzx+xpRLPBEQr4HwEGTcPtxpR8nncIlMZ0SHy96vHYex/XbGMZldLfiqXnPqwYFd2voDJDIrb6D/Xk1E+9V2835XznzJYhIUtC/hhBrnKvgIE3VJXJhZLeVRg+qTHGSxbYSfn3cDvyz7Z34uHWz7V8+6VCQCsdf7tESzWG2ghCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shV3GHhpWpDTDpQg9lNm7wHuks5kDsygyEu/byCNuUg=;
 b=Er6bQ5yhn7baMxft+CBrntsbC1bSoetmHm2HXfHAOPZlAmDJP10PsoigXnWSV0VJewr8C02imZrHHHbUA0fbI0e1sE2OA5KTBk6kKTgZcpP3EewptnmUi4DwTLe3RKhi82Jztk92hpZifpTxjN0HmHROxhH1c+rYBDz7s7AFszQ=
Received: from BLAPR03CA0117.namprd03.prod.outlook.com (2603:10b6:208:32a::32)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 08:43:19 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::1b) by BLAPR03CA0117.outlook.office365.com
 (2603:10b6:208:32a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Thu, 6
 Aug 2026 08:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Thu, 6 Aug 2026 08:43:18 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 6 Aug
 2026 03:43:16 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: allow profiler process reenter
Date: Thu, 6 Aug 2026 16:43:12 +0800
Message-ID: <20260806084312.79422-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: e5aebdd3-440b-43fd-9d98-08def396c395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: rQqBB8QH0ks5A5iWkUsAUvKROv2Hk+34MUJI74qqfDYx9rO6zNCHpQUVJ2V3Z1aEqqdS/q0tfsTmnJkhOWlM7Byp7Nz3y7FM0HSLSreVk2uqFx2WqLScgpd7iXTAQs92exwCy8qPnfcPLh/asqdsHNNVnQx1XQQabFM+JqpQ1Nz5Yz7pQwTG29DVkmre2w31jMAGmhfHlxrJ+9c3HtHC+eKW8kMeXGguTc/TAwxOqsd9GlMDCFvVx1IZZvefaWyRPI3M/EaDCbIBv7xlqWayPnltfrw3cUGIJqtN4q0SeLEqkOhYbSfFz9C18ZMHszS+czxyfpXfcuap6mJpiP53Qi1sK8p7IhF5wwqND6DTtr1EW5dsFrm+l0T6G5MWUOyk0xC7xZ372UM186kIygMEhTdr5nOm1UNcQ/oVDY5ZHHbnuQLWPA0igDWknkOdcDcl7y77DemnNNa93yCHrCZvwK8kL/oMDcW2g7aM9Jl+kXv5yKSp6HcBSlhd/2h0gLoAT7JTZ+GUb+Rs8iXgwKlWcXABkfOM0qpxla2RH0UElH6wF47hSIJC0y9Cgp+jQNpa46wljQg0pHPCs2m4VyQRLYNPY5mVDcH8kPZy0Yco3ZB5AV2wVDuS/jb16q7Xln5kIDTojo+lat5SWtjYf9M5cJR8hCIG43KwQ+GLpqH4zoq4lb/JJIxLLAnSd5FwM4nOTU/08DbIls47w02MUVUWdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AR+7y68z2k3wKDBRcE8I9Gr5c7yE8K+KdZC5s7bpF4YiasNGJ/50Wm4fNJUVH66RPeIjE6Gabk9HX4akDuUIjUXgrot1LseKxQ+JrDgCTTpAccnKDHrjvZpKtjUjdNEnLCw6kydC+USY+2oPwOm/I7hPjbkhHhISdymN55TRCBxChZS0tYiQp54+/fitdWBi3DwMBTXLTKyemSlwW+LP03kd3OrDYjhLstu+DUwg+zg9m6UaZel4hg5r56fqA3hCnv0TUKSHvMjMDqKKw/8prrdM/SDhn5g/1wQ1dzWhmLUI+Vodz6Y38OuFEsCsUhqPg9k3ckzxAGVq9+WvJluC514PX8pv5w3fAJK2OgT3y8Y971XJziQaZ95113u3U37slCZdKuxqqnbWsRbV/STgK299QweFfpOjUoBBjpSmalZgOMcnf56fG2t6XvoJqU90
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:43:18.4885 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5aebdd3-440b-43fd-9d98-08def396c395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
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

profile_lock_device() currently returns -EALREADY
when the current profiler process requests
to lock the device again. However any negtive values
here are treated as failure, so this causes rejecting
a profiler operation even though the caller still
owns the device locking.

This commit fixes this problem by returning 0
when the current profiler process locking the
device again.

This commit also changes profile_lock_device() to
return an int value other than uint32_t,
because it returns negative number when fail.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 309510e23315..9acd5c91e51c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3329,8 +3329,8 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 	return 0;
 }
 
-static inline uint32_t profile_lock_device(struct kfd_process *p,
-					   uint32_t gpu_id, uint32_t op)
+static inline int profile_lock_device(struct kfd_process *p,
+				      uint32_t gpu_id, uint32_t op)
 {
 	struct kfd_process_device *pdd;
 	struct kfd_dev *kfd;
@@ -3365,7 +3365,7 @@ static inline uint32_t profile_lock_device(struct kfd_process *p,
 			}
 			return status;
 		} else if (kfd->profiler_process == p) {
-			status = -EALREADY;
+			status = 0;
 		} else {
 			status = -EBUSY;
 		}
-- 
2.53.0

