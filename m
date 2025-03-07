Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB5C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 09:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0AB210EB10;
	Fri,  7 Mar 2025 09:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wu54IaEm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B366210EB10
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 09:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SD594EEks988JbZydMmmtuRUSqGDym47gLYsdl2RaqC7i4jk/q5k/Sy4PZG5n9M8phvF2rahdM9Tds+jMualNeeimN9WRhmoq4HuBCHo//czXvSa8nvl/flzCOwMSgiO0cNulwY/hERv1ECiWAnXYZU7Zwvrr25row//KawGfNKYrfoQeiy0J10RNRYFYHsdLQOOSujAFSA4KowZQwAY+2HtqX9DZ2vOpar0Xw8G7fbYBvbKtP7yTeKZPspNSugFD9VFKrp3IQZx/lS9lUZcYewCNq4YPE5IAObXz1w3mjXR46QszW2cxaOIxvMkPSA6kGOaM5OOB7zoWGfzv9tXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aRm99dG6xM+UJJWcG3eJ8XuNIfgLYLIgaF7ZfP7wkU=;
 b=X9/gbi+OBJZ+QP2rXNH2Zlj7XRQtis/oHaAfYDpoovwc9rTERGWTX+kET+Lbe75szOwGX6lZlfSTvVSR7ciyV7cWCQ7FPRwdIiP4Iivsq/NdwvsFNHNZ6zJ5p986PpC4ILsPMB3X0z/yEPLEnLnUtQP7vxgwe/1xh8paNu/+7hhanypmNOE+lg4MDBUYlNvzcj6R7aEw0EwG3Q8hdsVK0zq+TGm8EtHVuutwez+6lVsj0toRRKwx3s4oYtb+zt2xl1+lBJ0JkSv/dwKv8ZGskO1YltdxHOKbDe5sVA0s43HGT6F0FvQ3uBXiFJdPtzqdYwL4OaGNQZACuisXpfy4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aRm99dG6xM+UJJWcG3eJ8XuNIfgLYLIgaF7ZfP7wkU=;
 b=wu54IaEmOzi8kp+4U4CnQDjhnPXgCBlZc2WkJy9QxBS1gvNh4A/WaSQEsXWgHAthkfTfwxoNjhwGOnYeFt4RUuFfjOVyCw7DBCzZxEoZEuwKmF66ClVEnq2ZRXiqyheiGaDP4EQK2S7dhf43OaTGwRQhavUSeHbjcE60Dh3smr0=
Received: from CH2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:610:54::28)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 09:04:03 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::45) by CH2PR11CA0018.outlook.office365.com
 (2603:10b6:610:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 09:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 09:04:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:04:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Mar
 2025 03:04:01 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 7 Mar 2025 03:03:59 -0600
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Hawking.Zhang@amd.com>, <Felix.Kuehling@amd.com>
CC: <haijun.chang@amd.com>, <Horace.Chen@amd.com>, <zhenguo.yin@amd.com>,
 Yifan Zha <Yifan.Zha@amd.com>
Subject: [PATCH v2] drm/amd/amdkfd: Evict all queues even HWS remove queue
 failed
Date: Fri, 7 Mar 2025 16:53:23 +0800
Message-ID: <20250307085321.677381-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Yifan.Zha@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: dba83b1d-4342-4b50-9635-08dd5d57019f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DmHvlyaFvMk4zeUe7vbMOjLjq0R6BTJSGfHU7ooQbOp/iuXxbl6na157iFgW?=
 =?us-ascii?Q?rJISDhVoHWJIFRf6ZotGQBuQvhQ/+am06Lmi+2Ohefk+Gp+Ukbd1651OU/91?=
 =?us-ascii?Q?+rya0dT+1x/406KvKTUgqPs+dmJfyL1/Q9mVz9TDzsRJrRLSLgL+jQ+vOmMk?=
 =?us-ascii?Q?9Z5xI8bEXFOKVbHeHg+vIOu/Jd/+hSJ1kno6YnxbsBksIDeVM2LpVfHwBZES?=
 =?us-ascii?Q?TQrVAhX1pLpaeMup0G+1/NKj+z97vK/0IDrtYQ35SGEW/6pLpA3BQ4C3EC6q?=
 =?us-ascii?Q?Us3Sbq8l7LTWmALoHS/EMXobgfC5+COwsdZllU2omDnTO2lPnwHS/Cz08RdP?=
 =?us-ascii?Q?ocHgE+Th+iixSt1sCS32EDiu2vF2OfPOx7JMmYt1G0E0uGuA6yhsLaM1djEq?=
 =?us-ascii?Q?YY8Kuo9MbfU1xu+xvILrxT08sEOto9iMp0xNgD7P3/vIYCFNSyQ+OEKT28Dw?=
 =?us-ascii?Q?plju9tg/1IbOxxXE2qWMFsCoen1kcjKzQi1znogFgpRVDNWG6DsOnMbTBohW?=
 =?us-ascii?Q?SkuuHZNPdYciXuqDfn0+0daZ/T2Np6eQOIsu9gv5qlUztHytNGSjsBXQEc0p?=
 =?us-ascii?Q?0IMQRMeRMnRG+0KxELReOLq0zNsClkrqBs0f92k8xSEx0d9U5NeQqsAqqc0F?=
 =?us-ascii?Q?ntPTTIIjdo2I1fqrLyxe29sIXnu0T8qkzwmH3lDnfXZ8wdvyuoTTer3Dl1+q?=
 =?us-ascii?Q?ZGRYSyIWSG1KLpNatMv2lPrTkSy1bGDXka9hbSEYOOJDU8BFlcEOvde5gVOI?=
 =?us-ascii?Q?PMysY1OPj5qY8GvupKtHPnbRQ7QAWVXlbzaOmks712URAoaG7rH8Ygtqf8D7?=
 =?us-ascii?Q?OIT8OOgmXmIDjahb/6z7/n+2yBfGe9wJdNe/SIeNicQALVbbFpBBZtxC4HYb?=
 =?us-ascii?Q?6fZnHSZCejrocBIu3z+dfDocuLmQUCVTzcSiOLTV2Y9XRHZ1TExylVyvUMNp?=
 =?us-ascii?Q?pqzvvezB2RZ93jh8KWdIQHEHIRpZaOpN8yT36aGNLGQ06RZKqknomL5jgJ3g?=
 =?us-ascii?Q?fGeVyb2RO758q5jDcmfISHrANXWZft1ZlNPBy96lU2wa+/1BwYq7QDYljq31?=
 =?us-ascii?Q?CPXA3UKaCmgUKWtd7pZXOalVYWrHiuIjvz5w3OZPgtjm7uqBWCxTfjWYdmTM?=
 =?us-ascii?Q?0s6LowiehTkcrL8R1At2WlDfL6zNw7/9r5z3SrWSVXJ/6UAphcOm3IscUppi?=
 =?us-ascii?Q?OAkRTSCj8pd71SxLKgFlQht5Yr4lvf1q5qw3tjaFs9uerk98WLK2Hhy0bvFU?=
 =?us-ascii?Q?ZC4Q91MCMdXyVYUP2mdt+JDdQOevRxXtm9IEhHKtWqAD3zyMOqdPlASNboxb?=
 =?us-ascii?Q?ur5Esv8u8NCzUWGhDGf+M4u+eHSMYLkw0l7EoS99xrnLIM28m8vPtdPhnbOZ?=
 =?us-ascii?Q?I2IxsAle76DzXquw1mxHMWb6FXr5lNNKvYT7Dr1krZYNOUEki9+yDHrBa1fW?=
 =?us-ascii?Q?riMOVbnJf3t9aCN7f/oBcxLJm4x/RTNh1wR2yiWiB9gJK4+rm+FzYpNx/+AD?=
 =?us-ascii?Q?bymU767NDmNSB20=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 09:04:02.6314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba83b1d-4342-4b50-9635-08dd5d57019f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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

[Why]
If reset is detected and kfd need to evict working queues, HWS moving queue will be failed.
Then remaining queues are not evicted and in active state.

After reset done, kfd uses HWS to termination remaining activated queues but HWS is resetted.
So remove queue will be failed again.

[How]
Keep removing all queues even if HWS returns failed.
It will not affect cpsch as it checks reset_domain->sem.

v2: If any queue failed, evict queue returns error.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f3f2fd6ee65c..b647745ee0a5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1189,7 +1189,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	struct queue *q;
 	struct device *dev = dqm->dev->adev->dev;
 	struct kfd_process_device *pdd;
-	int retval = 0;
+	int retval, err = 0;
 
 	dqm_lock(dqm);
 	if (qpd->evicted++ > 0) /* already evicted, do nothing */
@@ -1219,11 +1219,11 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 		decrement_queue_count(dqm, qpd, q);
 
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
-			retval = remove_queue_mes(dqm, q, qpd);
-			if (retval) {
+			err = remove_queue_mes(dqm, q, qpd);
+			if (err) {
 				dev_err(dev, "Failed to evict queue %d\n",
 					q->properties.queue_id);
-				goto out;
+				retval = err;
 			}
 		}
 	}
-- 
2.25.1

