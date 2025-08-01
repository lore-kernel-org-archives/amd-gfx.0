Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE7BC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 06:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1327B10E3B5;
	Fri,  1 Aug 2025 06:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtrRBoS2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C3610E3B5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 06:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqN90i4LphVeq1EGF0cG0DTN2wsymsdHu8CReRr2T1b8WyJwtsLKNyiZAbaLUUN2wzf2YGnGmG1gs27Y2qiE6nTckYcqVRQE7EbdOXD1izAxcUBB140QWLcya26FZ2BfbSBcpql0HWhME33MuR6OGZpzz0KvNEPnz0G1fK2KTIUy1cnZWHxOfV1X+7G2ALZ4ccvTZH1zCita17BuOUUdFdSsP1NZX0KnwBr8tDAriBIAhrCdaGc3uGCWHS9QqGMmKXjbE/deiAIpK81yw025FhYbWvxhqrceqWIDtt8HgbPG6wpcvuszZOnX/girdWDQbh7l9lmDPgVwBxc4BaHm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLEHp137JDTtIfPTPhQKpb+io7OkmfOspE07H5L0o4s=;
 b=MRzwzmEdmcT6Vms6X9SROwB3mhM/HPmOROzcjZ+Kj+5mYlB0rBWARSpVQZAcfmE1MgW/XW+uUQptQFv2LXUWuxUa69wz5hq0kfnTq2dCMBOo8J+i7vP50QgorQ+Ri5P764R01vbsBsrk/qc+DFeXhZWYidCLC9sl1dHUjIXx5vDMyjR2qw1rVrSYAVjUfVQnn7VHz/vup0/xwKMnkBP9G9+6YkmXYHOzkFLZZh2533aNe2TK1A5bheauWEmZh6U0bkFVTN+oTdlusGxQbqBDBI2QcZ1tljk211Dd154oDWXIl5zu+ZbH+Xaw0dOzMdTVTiHOPNHVKNph78QTLnISTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLEHp137JDTtIfPTPhQKpb+io7OkmfOspE07H5L0o4s=;
 b=TtrRBoS29BGL1uAj3+1hqseTfog+LVqUSUBsRDWBs06/Y0uXiqIDwqG4V8BKTdvtu+hxQY3lOCgBNUcA/T50LgrmSQPC8z3LkWAo6/a4ym5ibamdwm+3rUFZ+zW91zAJK/lj5Dc6NMPy8iGclDmYq4Z40znA5af7yxPoO1rO4Wk=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 06:26:18 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::64) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.16 via Frontend Transport; Fri,
 1 Aug 2025 06:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:26:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:26:18 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 1 Aug 2025 01:26:11 -0500
From: <Alexander.Deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v6 06/12] drm/amdgpu/userq: add a detect and reset callback
Date: Fri, 1 Aug 2025 14:21:04 +0800
Message-ID: <20250801062547.4085580-6-Alexander.Deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
References: <20250801062547.4085580-1-Alexander.Deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Alexander.Deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e423a4c-5b65-479e-985b-08ddd0c4534f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PYZd74vCdkLnbmmAzr160AQsNPfqA82HEk8TEnrbt3mZCeS19biJsHbURnTP?=
 =?us-ascii?Q?kAhKmn2QGv3FgoZuxfJ6koQzkm4ZCezZrx9vMGMIENmEuhWvygcK2cO93vgo?=
 =?us-ascii?Q?9w9IHhha9CeIXiqmeefAeA5ZuGB0dgoG1kAVbH9QgKwTYlZFL8j4iwEGnJAr?=
 =?us-ascii?Q?VnZXu7MkQ4oev4mjXC74YuQfjfMls/VUrgTHAKit85xUfrCd3FZZqGf9x0qJ?=
 =?us-ascii?Q?O3V7QblicCTt08VugYKEDbkdODD8MHfaiQDYCJ9r4RrAGr+qDU9zmT09LF1t?=
 =?us-ascii?Q?1PhDQLna342W04JRz9quENm2lQApVErUk54yTB+TqbDFlHHN5TaIyE7m1TQH?=
 =?us-ascii?Q?TV07+JL/ZoO1ra/tFq7Ya/UAsFsQXKX0GnK55oJpMFQsb5iDr6z3sun9h1+O?=
 =?us-ascii?Q?l0RVOaVuxxBsZiM28CpOacA1P+2PPjtg9xNJ/GgegTPoEKr/S1vlotJeKzIl?=
 =?us-ascii?Q?XYe3zA0TMfF9XcOt/yiCRhA2ucH5pvr0Cim8OvILzYkrSFkcy1LIJW06xxPh?=
 =?us-ascii?Q?6srMyMt2WPVE1poyJGNNGYL9MBlU7f68J2MSergTp0mQnwbwpkcmIHDm7glt?=
 =?us-ascii?Q?AyirMFcJh9o6N7rdAjx/VscpFnRWQ9bjm+OOd/90vflyDhVv66fiN0Bd89cc?=
 =?us-ascii?Q?7d1yK5dQNWaCzUD0n/MslLmCjQHfjty8TuPHIM5V5sXvJDX/Vpd4UnlRoNUw?=
 =?us-ascii?Q?WIaujP8QxdSJlybCtSjEWzT0caOobErL6PHJDf6L4p8irCWLAPBm+D+/F/83?=
 =?us-ascii?Q?ejTMmDU3Z4GUQaM7iaOrZKuFyuoBOOh0knJavoD3EqCxJEbKmO3siQIxUvx4?=
 =?us-ascii?Q?5nylQAFi0ixKY+5rHf++e2uWR8/n17jSXVtTZ1+rwKm4n04d/bxl++VbrTyB?=
 =?us-ascii?Q?59B2cWCSKBV8pn45Yoj5I1ih3LmrwT3mDlA67OtGeDJzQAGiluXfItSLrY22?=
 =?us-ascii?Q?IyGVuUhTVtSZ5kjDNSsG5Pt80Bdqea3dsMInVoPQLCusDXHcwibVQLe6dTPy?=
 =?us-ascii?Q?LVm4QkwXyj/EfupFOg+n8FLxbOUtxio1IsB/LpBNULUwa282o91wydzLj7uM?=
 =?us-ascii?Q?xFc2W6JPdYBXTHJdsfN463bk3LuEnoSbqsRjXTAwnyPqf25G0LqFLXerBKrK?=
 =?us-ascii?Q?8ziNq1nMhXGf5dGkvzJgL/w5G974IXIRbQIXkVL0CZGm+RUmllz42IhyZ5g7?=
 =?us-ascii?Q?/oz7xqu9HggTd/yVqEepapvyhISoHbBONONSSLOSLRh9LfaUMzjs9is3WYyK?=
 =?us-ascii?Q?66IaWqadcewLupWscka3md/G9RkISKUgirR4UUerJCxsAmKjr0jlmBtDkZXG?=
 =?us-ascii?Q?ul25+uL0f3kscgTDlplvwAHPjSljGq8N9Jds48PzkHom4yv9mhFy8TS1jGDx?=
 =?us-ascii?Q?CLjhKbAcxveSiovCHOFFPPbkTRX6o7GfwgnNeSFz5vRFKzx5LUq6fbr0P5Mj?=
 =?us-ascii?Q?GEN72u/YJG1NfI5J0NF2G6i5pDMK5KrBnI+PlUimAWqywlMat6nkK3kg0zkD?=
 =?us-ascii?Q?cEDLXGNhq/KH9k7VbbGMa5Xo+SURhnO4C0dC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:26:18.5947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e423a4c-5b65-479e-985b-08ddd0c4534f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
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

From: Alex Deucher <alexander.deucher@amd.com>

Add a detect and reset callback and add the implementation
for mes.  The callback will detect all hung queues of a
particular ip type (e.g., GFX or compute or SDMA) and
reset them.

v2: increase reset counter and set fence force completion
v3: Removed userq_mutex in mes_userq_detect_and_reset since the driver holds it when calling

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 ++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 49 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..0335ff03f65f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,9 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*detect_and_reset)(struct amdgpu_device *adev,
+				int queue_type);
+
 };
 
 /* Usermode queues for gfx */
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba..a871bac71e1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -21,6 +21,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
+#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "mes_userqueue.h"
@@ -198,6 +199,53 @@ static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
+				      int queue_type)
+{
+	int db_array_size = amdgpu_mes_get_hung_queue_db_array_size(adev);
+	struct mes_detect_and_reset_queue_input input;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	unsigned int hung_db_num = 0;
+	int queue_id, r, i;
+	u32 db_array[4];
+
+	if (db_array_size > 4) {
+		dev_err(adev->dev, "DB array size (%d vs 4) too small\n",
+			db_array_size);
+		return -EINVAL;
+	}
+
+	memset(&input, 0x0, sizeof(struct mes_detect_and_reset_queue_input));
+
+	input.queue_type = queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = amdgpu_mes_detect_and_reset_hung_queues(adev, queue_type, false,
+						    &hung_db_num, db_array);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
+	} else if (hung_db_num) {
+		list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+			idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+				if (queue->queue_type == queue_type) {
+					for (i = 0; i < hung_db_num; i++) {
+						if (queue->doorbell_index == db_array[i]) {
+							queue->state = AMDGPU_USERQ_STATE_HUNG;
+							atomic_inc(&adev->gpu_reset_counter);
+							amdgpu_userq_fence_driver_force_completion(queue);
+							drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return r;
+}
+
 static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				struct drm_amdgpu_userq_in *args_in,
 				struct amdgpu_usermode_queue *queue)
@@ -352,4 +400,5 @@ const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

