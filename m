Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F251C87FCD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23F1C10E402;
	Fri, 25 Jul 2025 02:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tuqYzdn2";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DDB10E402
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQNOc1D78cdN7IsBQO9+R3ZFGJ4X61DvjT5QtKcLbNUpLBtVAdMn1WfepGbMFVA3F4xnoYJpQqM0A83QdctrWZVYCU91JilwfrL0CVjiGs2ab35CihnzDERIiPnoaK+DMxGh0N8kz9OJu8NmUlG4OJ4M2/k4KiChfXeRKARCcK0B/WwFpmzJb31NbSnOdUq7mkcjFahbnKadgZ9bstnDPdPOjtF21fZLUkOWdUAtdpI7Vx9F2gmdduK3Ey4tymK8zjW84TIDCzZvv7JV0j+smXrAwxMgjh+wyl3OshQnHu8brEX5q9LL6lRGYnQv2AbQ2IwoA4zEXZJJPj0tQSPQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QlYPmmNiXJ7GmrSoWzzU7Isd0TAo4tk9NQ6qXpmb8c=;
 b=A/uxUWPmoBdw2ZEnCrsBDw5gwkQacOB6HxxqR4Ye86e+nUQgdVld2siuwIkDM2ZC9Am8hlLHpUjinj4l+kyulBLGZMvIlXCmQ/iYfCdaIrABUf6KhbOEzP7br2Qj7GuacZz4ONB/JVAnhryFbP5BNXFikZFgr7s2tZDTPwj11JtLdhXjunBQpUnJAeFx+4H50gmbvEH077DEexjFGxlh0nsAZF32EoJXpdE1ASAfsn4LBivbunGAFtbiXhOqJAHVwIV8wfzL0G3BAtiZUANHEzxvirDVeQsZ+/dJNH7ukioJPIIKH9BhwK9vc0LQX/WRLIcpMhLh1fFZh662VEl2dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QlYPmmNiXJ7GmrSoWzzU7Isd0TAo4tk9NQ6qXpmb8c=;
 b=tuqYzdn2h8YJf8KP5Z6eEIGlilExevssPeEe2S+GZay9/f5T9rkgvymfyYANF+U2NYDvlSUMnMN1BDSHTvym1ZzyRhPyOgH0bLBAVdKwek8JMUyEqEpL652rotmj0tQmp1r6obeSRQ0A5XTd6RcETXA3GyZptedJt3nFV+3JNRs=
Received: from CH0PR03CA0098.namprd03.prod.outlook.com (2603:10b6:610:cd::13)
 by BN7PPF683A477A9.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 02:43:33 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::da) by CH0PR03CA0098.outlook.office365.com
 (2603:10b6:610:cd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:32 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:30 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 1/9] amdkfd: enlarge the hashtable of kfd_process
Date: Fri, 25 Jul 2025 10:43:08 +0800
Message-ID: <20250725024316.9273-2-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|BN7PPF683A477A9:EE_
X-MS-Office365-Filtering-Correlation-Id: facead96-d181-418e-3d66-08ddcb250ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SxJCDq8XVnjK5ptVoVza8oWpn+kYyYOu1Nxj/c2w2BUdqagG9tJglrg+59pW?=
 =?us-ascii?Q?dNeZ0/iylYzsY3PjDYM7L6/Z/78gQKW4i90CthO93ZXGrGqmM7G8TZPxVT8G?=
 =?us-ascii?Q?IW/F+t48NOSEIOKTEJNM2ZrJILIikbaHGxO6ZilTf85JprdDaAPF84AAEA0d?=
 =?us-ascii?Q?VfcSZTS1cNGNePpWLwQkd9tO5WfIAcVtRSD3lgqiKYswPtloslUkgj3jELjh?=
 =?us-ascii?Q?2oMz24ShUKXN4UEQmBfVV6NxuENqS/5xnUn3WkXoWoui8dM0alYazFMT6+9Z?=
 =?us-ascii?Q?sSWbbwcYlMV1IR5nJf5N/2XwRu4At+b2c3UkJPXLaEQi9U+Ykofh+rwG1W6X?=
 =?us-ascii?Q?8a4nZCA+ShTqp4FsMPRBKk3sBeWbMltyhVCsExmi+7u6wgf5h+Uz2NxBeidP?=
 =?us-ascii?Q?EMyAHL3214v8MS1ax7BOaySYpoYG6GsUPPm8Bxmf9GRlXpSxItBUiaBC7dNP?=
 =?us-ascii?Q?YS5Zc3izpKCMThQgTAYhmQO12sVnXYToP+RzDGvz5fOpw3TuKu0q5aawWBiK?=
 =?us-ascii?Q?PEc38C4RZXm1jO79Uo2fz0oHW7d7jJ7XEkNl9FqMSkzstNFIjSC5MI+ZAHHO?=
 =?us-ascii?Q?6FDvv/8Nmcootr7+PaDN+NDnOWhnVR3Ug3ixo7P2KLpWORfioF/MNAkcoJWI?=
 =?us-ascii?Q?p/wrgp2OB9G07HRoDKRTEQqfc8BWkQ9RPybYwXk7McWUtwY4Il6lfxZBkHYM?=
 =?us-ascii?Q?5i+1XBOUIlqyU0+nWxhteHJwtGzyV6imBDDqZNk2VO9/LZBktnPpgpAdyKBb?=
 =?us-ascii?Q?m+KYVRWJubwuaDWE+PpqdUshHhC8x+LuUzv711w+khNGW1z5609j2tM/dbgW?=
 =?us-ascii?Q?HfIBc68BD4LRdYkqrrWkg6IKvthcPLUHDbR9uNvBWpMq8xeUV69rJAG8Mnyx?=
 =?us-ascii?Q?Ecj0KKTbiEBOIp/mKpk2JQ6fbLrVjR8s9He1Mtn43FnjRuS4GOfqoufGBeiy?=
 =?us-ascii?Q?ffBNNWzdYRb7UsrRtQqLjR9/FH1+Z4y2oGJxc8FRUn9fivpXUQGjxVfPTtep?=
 =?us-ascii?Q?gSDdQAhECPL9OvcAnYGCdFsDBMHIfwe1CzrkEr9bsKU086iEM3D4BiMy2hLj?=
 =?us-ascii?Q?nVsSvdU32NtxsMtFbslFtkpyxVWEphPBC80k9JLpBxRei6YNijHSvT2qYyRy?=
 =?us-ascii?Q?r9GXqh0pGL3Kk3XqWmhlsiEqIWl1qsKRILKvca4MKQHk0h+8tKmJLDmo/aZ3?=
 =?us-ascii?Q?+88Em/rKYyq/HVX89JwJXcd08T2OiCvnqWst8AufYtrxy+l/v0wByGHuVla6?=
 =?us-ascii?Q?a8ZSg4Pv+asQbP4miqVlDMAcBrz97Y8deaGt9AimNSUd4J11/JMOKnDGPMQu?=
 =?us-ascii?Q?JYdYxrAyyvhtU5t+QRjZD2lapRIwvrRJ8Z7UOWwbHjMIw6ymags94tpZ3aKZ?=
 =?us-ascii?Q?tAx9I0WjCkG7wLqVeUpRvnQhtbDMTOtHSKKbEis8h86+ucpf59VBCl07JmXc?=
 =?us-ascii?Q?L2WiOUd5hy70P3jMx+7GCQdUkDE1wYhBT6HuEvKYROE6a8ahPPBlhz5FmHKf?=
 =?us-ascii?Q?QCZvbKQjWzSwyiQs+rQSfU6Os4A9qZGhbd2+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:32.5266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facead96-d181-418e-3d66-08ddcb250ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF683A477A9
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

This commit enlarges the hashtable size of
kfd_process to 256, because of the multiple
contexts feature allowing each application
create multiple kfd_processes

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d221c58dccc3..38a20ba61e24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1008,7 +1008,7 @@ struct kfd_process {
 	bool gpu_page_fault;
 };
 
-#define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
+#define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
 extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
-- 
2.47.1

