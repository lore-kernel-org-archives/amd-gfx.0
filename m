Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE02C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 22:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84CE910E027;
	Thu,  7 Aug 2025 22:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ip4Hd6zu";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12C9310E027
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 22:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4VBPj7DUj9/5BANxtCNdpM/TeEW446EgwMZYv3FURyFpPz6i3G5kNycaBEAeWvOKmXBQnwQmhjpWtrAetzVVndwHJE+oR5hZPmBDugJTdMj6p/xg4zjlLVt9S0Z4us82S4/9eRgniV4E3SHNezJ9F29wXthuC4XjjxO0244+K7bcmQVA1ZbIYzY8s//hmjamnBy0ocYidLu87kuK0xYpKfKS0IyJh3oVrGZzV7hP2uYWRMvuUGe5aNjDUn/oLpO5tqT20ose1a7ABxpAJpeSV8qadCU8frodTDmrlgHRlcaWo2EBI+OPEsgJldQsggFKowdD203pOnM0a2+l9zUHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKYsSnLXgvXMJ3IaJEboSEtazcNjDQ2qweGn67nwqns=;
 b=LtnGCGppjTFyKJ9tksmbXsRAPiqNGM8Ut+RzUVGq3MWmJz6RgqtDl7JsZJ8hiVXylpYuCMPWvgE9HuRFs/iXGmv/UFtnlPZeVhkq7oMKkfCPlFQn2mzry/T3j3O/pbyo6qiAl8vTPT2bkatSH+v1tfIf6+uhqWQXsArEYqzhN6/B39WW6unlp8TyYdzBWVsW5MhaKPe2CXDEhOhC1kO8Sq4kHwgy2doQDwANPTJ5Tj+1RnftvKjitpkBZy8bgzYlDUldQ6UOG4RbRlHgMIQABhlLwD1JAw+WBYUzRCQwZy7XMp5lRDCf52BTWn1sjToGlU0A98QzZuGnj9qE1pNhOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKYsSnLXgvXMJ3IaJEboSEtazcNjDQ2qweGn67nwqns=;
 b=Ip4Hd6zus1N5ovoan/zGJ0RdCJGWsPfSDhF4N2QZQBMTtyvlqL2ixM95bwGxf8s9qUL31LSrs9czRBisVsmeycFrnD+i0hq09btPkMkv6w/aOpT+8M0lK7OPS4+SeSLrQczz6rS1eQgFG+sB6WcTKEdIAnDMdPPmDt3/AjAxnNE=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Thu, 7 Aug
 2025 22:02:02 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::c8) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Thu,
 7 Aug 2025 22:02:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Thu, 7 Aug 2025 22:02:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:02:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 17:02:01 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Aug 2025 17:02:00 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>
Subject: [PATCH] drm/amdgpu: add to custom amdgpu_drm_release
 drm_dev_enter/exit
Date: Thu, 7 Aug 2025 18:01:52 -0400
Message-ID: <20250807220152.35899-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 84624cbe-1447-4b97-32d2-08ddd5fe099e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h2EAW6zNckc7sMGUpzwUi4tHGgFlvZ5IyPgbx1oDxgLUUllf4VzPWQlheEwB?=
 =?us-ascii?Q?+M3o0MV3Rws2gbjVxsssVoxE/HehWON3M3x4yOIxYSkF3IaSL+gRX6QGmsNp?=
 =?us-ascii?Q?75G1TOh1afjmafYfsqbAugXK/GsYtoHuPjj6p7W+GaFn18Qm9AFYrHUIuIja?=
 =?us-ascii?Q?lGxolpqgVJG3oYrClzWu/7VqrDsV9l3xgrAO+/C0//0kYE+gKTqsXB1Q3/yX?=
 =?us-ascii?Q?CQ3+eMna2sS90qQfoZ7j1l1BPeG0KnVH4r6TPCggiWOHXAUelxiD97GOtpUA?=
 =?us-ascii?Q?ncXglrcAerJF4uwe3k5pBJGKKuGIbA1f/QNW5+FyZQ+UfMWae0s9tyUNebTm?=
 =?us-ascii?Q?jpGW85pZl/YXASU87G3brMjdQRgr1FU+Ij4h+81XZaaH3baRIpcYVpcdhEfT?=
 =?us-ascii?Q?KRC0D0BkybAZ4UdTQ8uAkhMG9o7ecn2AxucgaQdooq0YRFjG//ChYrAABBm2?=
 =?us-ascii?Q?TWzWsAuTN8qsjShm05TiutuWcIKLrUgc4naF6VzQ/ZljIkkHuwrGbMQ6yZ5d?=
 =?us-ascii?Q?4zjwN1Trq2wSWZBeaYrEsebgsc59nLKIhjnlWw7E5rlBtLe2zQHh1v+QzHtf?=
 =?us-ascii?Q?Z7kMdKBB2MqLfdqTlHAdhOqvD5SovIS5yFn52Az2ISWNpZ5aTEkqXXSP+8tg?=
 =?us-ascii?Q?AVl2qacrg6XUbgOE5EXL3Slm9snqOWuMX6/2ngNmyLba5Sefn7UEs2BrTCRO?=
 =?us-ascii?Q?nFcsenRq/QAV0s/bxYUfS4XXbLmvEp7vk+0yXrVLHIep4RzR7YjMFNoXb3oV?=
 =?us-ascii?Q?gBKrO89m7t4eP+zmFQuRaaRTwncPNtUF+EVwbOPHbUJs8Ibc47kvvfF/8NGk?=
 =?us-ascii?Q?2TZghJtGWH4D4CgFb4P6U2Qg0ek1ZcIMJI7fu7lqINFvXwZF9Ony4CgqNf0k?=
 =?us-ascii?Q?EHWWJJPFqDnw7xG5fmxrvybWk06BGDlmT/QLXNFUzHoz0Fhn9EQRU5T9GVg6?=
 =?us-ascii?Q?33sWLJY7izV8AeqJuau3j8zzcOzi7b3Px3heRUWDPEq5IAlc8GmiG57Oadwr?=
 =?us-ascii?Q?TCB8HCQmb4MJZbGJCV4zAbXvDQnADorEdsf9Z6eDkevPatYy4J/y/xL02ChZ?=
 =?us-ascii?Q?VitphjuG5sjb0MWwqN7UKpz/Td6Y67rznH3U3U2nhxFhkW30oxo/+lQjrtQE?=
 =?us-ascii?Q?xZ9UMgWP8hHqeak6PhKkf0MKHM9a4QAZ5GNKv69JNkL4XXeK46OH6LgDW0IU?=
 =?us-ascii?Q?xIp8JP9P2e29/IOFxU9HG6rXgox7bRTis5qgLfOH/jkKxwL7IakocKE2oLNg?=
 =?us-ascii?Q?dgIYsdapHBtei2EWuQ3wpqpp92rmWgeATTjBs5i8ee+J+nNU4EkCxoa+bJjM?=
 =?us-ascii?Q?jWXxZidw0tuybiMaeeIomNNawZSEgpcOdwE1HqlNfsrHefMQdh1tMjiiAwhi?=
 =?us-ascii?Q?4CYiAMFQKc5ZS1y4xIQIz+3UPefWtnE5l7B3iQSXXVnxw1T5cf6ftu2q9l/7?=
 =?us-ascii?Q?NTUN9UF1sMtk0HEe1mXy+w6eHSaDXBFEkGo+AInQXY8YGVw/Op2vyibyzjLj?=
 =?us-ascii?Q?scFswRUNIOfRc1LARzR5bEfmzF+fde9VQYA0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 22:02:01.4912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84624cbe-1447-4b97-32d2-08ddd5fe099e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

User queues are disabled before GEM objects are released
(protecting against user app crashes).
No races with PCI hot-unplug (because drm_dev_enter prevents cleanup
if device is being removed).

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ff3a2eaaf55..32caaef522a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2920,11 +2920,14 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 {
 	struct drm_file *file_priv = filp->private_data;
 	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
+	struct drm_device *dev = file_priv->minor->dev;
+	int idx;
 
-	if (fpriv) {
+	if (fpriv && drm_dev_enter(dev, &idx)) {
 		fpriv->evf_mgr.fd_closing = true;
 		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
+		drm_dev_exit(idx);
 	}
 
 	return drm_release(inode, filp);
-- 
2.34.1

