Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52747C3064D
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 03:19:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C301B10E0FF;
	Mon,  1 Jul 2024 03:19:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZTA6Mm90";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A26E10E0FF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 03:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH/cZFejt7dE6gdvoWJc377VKt3mdRL4bB2T9OAG22bc5NeU04S6budRIcY0ofbcd0ZdI4Ud46i1gpI2pWycAXaBKvOCi9GI+RhS5egqg0nvfEky0mXf5TjL5e+Dc3lHkgXBDzdSfKufwqdK9wuZCPsA2hR6TxOrZts1AX1mu1IZJnLc/uSAq4tplrZaJ88R39xRJDy7kq8qoNQY1iRBo0q1bIva/rU9mSmBIXTEJmtSdnjqpdECQycBjagY+NgJlupm/iSCP4pKQMJpUBAtqbHDM2VdpkIYEQ5P0HcMmIZQ8e0MgwvC9J6Z1GrfNLM63OdSS8p5QkyU0ecGfA4L4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Py4BPqKeQfOdJ7nrUlTPW0YyJ+jGLNTopFxYtLZlWlE=;
 b=kCZFLER9smkv9tgyy8C42LwYl9XqIpBoopmgMT9FoGnPD0RJinxzMYEzJvp1E2TSkOuRX6VdAxG8MCk/v57jens1ssYt8xLMLqlu04ciRIZ80YpP6cxOzGyzF+CF3AHuDA5lnJct75LXqh/SI4AkXJd1qMnmrUhpB52JRLTOoaip2+3pOYFvg1sjvwI06gO0UkmpBoJlExJRLn+4mgWa/TlWfKZ9GXC+CNg4qARv852kPsbix96Z801jj8q7YtcOixP1A9Trvop+VvZ9IAL5+Z+4jfMuGO4AUh45q9fxszZLUVBwb6+SJveFSrRM3smW/4NkdMEu2P7fURPwYi/Ctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Py4BPqKeQfOdJ7nrUlTPW0YyJ+jGLNTopFxYtLZlWlE=;
 b=ZTA6Mm90uT5+cTV5TIlt98xZZt9IMHvJG20BNll8nsoLu57go9vVMMSc+pgEK4uCFjvW9aLxHNWV04mbaiF2eiql4t/kOW9wGpLzIx18ZNVOeMKG3ZIpSY+ZU0vVb7Y6LmE2n7lZHgF5Wj222kyG9LCuizyh/Se8VQjec06OOC8=
Received: from CH0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:610:e5::30)
 by MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 03:19:44 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::ac) by CH0PR03CA0265.outlook.office365.com
 (2603:10b6:610:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Mon, 1 Jul 2024 03:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Mon, 1 Jul 2024 03:19:43 +0000
Received: from amd-02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 22:19:41 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, YiPeng Chai
 <YiPeng.Chai@amd.com>
Subject: [PATCH V2] drm/amdgpu: sysfs node disable query error count during
 gpu reset
Date: Mon, 1 Jul 2024 11:19:21 +0800
Message-ID: <20240701031921.10239-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|MW4PR12MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: f7ad3a09-6ffc-4eb6-78a4-08dc997ca736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ItcLkeBGPUvb3EEXsUKLDOp+n7yAcEaV9Y+V4bTDGMRjibSs3Vg8slauHoao?=
 =?us-ascii?Q?+diQIu0pX+SuWAdxT2E8ZhV9r2Dmaxidun9xL3+hZOC9a34iU+4vz9AhrOPM?=
 =?us-ascii?Q?laGw29vvE8QTnEY5b4JlFztZGYLIfOSzzfUDnh1Ygw2/b1STAlpILglC0sFg?=
 =?us-ascii?Q?WmEhNLIEhChPc/oiIqr0a2Q58rcCdc/KFej3icgMRy3oMByPaoP3sHCgB2Mv?=
 =?us-ascii?Q?9ztwplRNqKqz7LzU7vGCx+1DEyGcHiIBZ0vRVf5mQ25Gia3kDeBf1Pa2zPMv?=
 =?us-ascii?Q?pQeNncwpgxvbzOKRmmgpaGvq9h8+RI8muAcRwsuNs4/QJwT9FcgSUl4EuBDj?=
 =?us-ascii?Q?hqxwSHbj0zhSGQE7vPMitwwXGXa661y1fZq3SdJ0wtSxya+LWSaVTTXHyolX?=
 =?us-ascii?Q?WCKwayIamSXH6qaInshXriZ9QTEDqkTqA5DjM+8/xJHZzEDACShNqN/I2sQs?=
 =?us-ascii?Q?kqJcm7jhSevnDV9sbB7XCZFOlZ0YxMEt9jrbIqNsQcjcllsMSb/9CbMAVsS9?=
 =?us-ascii?Q?bod6I7YyZzVo7TuV2MShBj/umkEbkO5mFS9NjZ7XF7jUz2Hq9K0cQUd/gfWD?=
 =?us-ascii?Q?Is0mskINpes3SE4Q0sakakeds82MBfGsqrrmRlRuwAKsK729rdu97fUy7u6z?=
 =?us-ascii?Q?nR7HroCs9Ope5jEXJFlvfiFHMnzXLVWDIieLb7PZqTxRQJ7237lPzSHBY97Q?=
 =?us-ascii?Q?ys35XXMl56/+hJD6iKq5avhCUnj1VxQzdlnuSrs+6/eUON6oBsTVrBfPaaFM?=
 =?us-ascii?Q?GP71hb+aKiEsnohxRMBfcvrTGIZispV4k27Ao9yg7aK/LFAfRwXjxJ84YBb2?=
 =?us-ascii?Q?86eb1X8tVnvTp0Vf8oiaG+4te/o5BfZKXdXBGS+xgwVNQCbO7MHPHnYBbNW8?=
 =?us-ascii?Q?QkCMk9ZxgmDq8UxBfFZxzFw+FBsAfC2MmTeSb66QhL75GjM6svgLK/c7IPc7?=
 =?us-ascii?Q?wv+HEZ7F06hwPJMPUvD5DNlqdaW2k3KMYPwL+sHrulezoqP9vS+MYFL1E8Bl?=
 =?us-ascii?Q?2uomCa9W8CkdBls9of40ZhnVkzVxjtaqhwnJJ2hmAbVkjKGo+YkTQvmRCNjv?=
 =?us-ascii?Q?1aTJP1xjG6P9MkJrudahD9Z6xMkQEUXCPN0g/0+iy8H43NeeNA1nT49/sOfC?=
 =?us-ascii?Q?N/YBYVnpv+32gD+GeW5YZjkjqDjwkAQmdHqp0VdXsSPFEG2RiJOvo0HkKGsO?=
 =?us-ascii?Q?s0bTXo32G2sM41MVXppfmYQ+Fls9kBIHRWGwyomBOzBMVUdej5as92f/y42K?=
 =?us-ascii?Q?NOkLFvGLdwiN5Fi1JkP24ZWx02s4245HyBadrAtYYMMPB6eTgMdClbtimeKa?=
 =?us-ascii?Q?Hs7DRkH0QWlqQCev9cibZzjlun8DubSOMbzrAMSLxOrzBkUyj3xAVjY7YGWi?=
 =?us-ascii?Q?Hrm6MN43+p6+oraEGky/x0fob5iTo0s8s6F93khwAC/F0kYt1IRTleq0bLe2?=
 =?us-ascii?Q?Jo2lJgarcesWrBNwN0rprm5o0/PD2XW1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 03:19:43.9189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7ad3a09-6ffc-4eb6-78a4-08dc997ca736
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6875
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

Sysfs node disable query error count during gpu reset.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ac7ded01dad0..a65b5197b0fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -619,6 +619,7 @@ static const struct file_operations amdgpu_ras_debugfs_eeprom_ops = {
 static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
+	int ret;
 	struct ras_manager *obj = container_of(attr, struct ras_manager, sysfs_attr);
 	struct ras_query_if info = {
 		.head = obj->head,
@@ -627,7 +628,10 @@ static ssize_t amdgpu_ras_sysfs_read(struct device *dev,
 	if (!amdgpu_ras_get_error_query_ready(obj->adev))
 		return sysfs_emit(buf, "Query currently inaccessible\n");
 
-	if (amdgpu_ras_query_error_status(obj->adev, &info))
+	ret = amdgpu_ras_query_error_status(obj->adev, &info);
+	if (ret == -EIO) /* gpu reset is ongoing */
+		return sysfs_emit(buf, "Query currently inaccessible\n");
+	else if (ret)
 		return -EINVAL;
 
 	if (amdgpu_ip_version(obj->adev, MP0_HWIP, 0) != IP_VERSION(11, 0, 2) &&
@@ -1290,12 +1294,19 @@ static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum amdgpu
 ssize_t amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *attr,
 				  struct aca_handle *handle, char *buf, void *data)
 {
+	int ret;
 	struct ras_manager *obj = container_of(handle, struct ras_manager, aca_handle);
 	struct ras_query_if info = {
 		.head = obj->head,
 	};
 
-	if (amdgpu_ras_query_error_status(obj->adev, &info))
+	if (!amdgpu_ras_get_error_query_ready(obj->adev))
+		return sysfs_emit(buf, "Query currently inaccessible\n");
+
+	ret = amdgpu_ras_query_error_status(obj->adev, &info);
+	if (ret == -EIO) /* gpu reset is ongoing */
+		return sysfs_emit(buf, "Query currently inaccessible\n");
+	else if (ret)
 		return -EINVAL;
 
 	return sysfs_emit(buf, "%s: %lu\n%s: %lu\n%s: %lu\n", "ue", info.ue_count,
-- 
2.34.1

