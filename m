Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80419CA6004
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 13:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178E410F5AF;
	Wed,  7 Oct 2026 13:14:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l4/pW0cI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B797010F5AF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 13:14:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4mACD36Bw6vSwqXF1+oxa6kN+GOVpYz+mZPi5ebZk+GjDs38k0tI038k6BmRELGJYYyCXej2tIr9RQQv9qX4HdCErv7A596qRabne5ypsyhuboeV6sAB4dbRgHe3BAJBpR+704dCfNGnKDc9uhFyXI4CnohjoCwEqCiX0NhdUpT7YpKXthh3Mdo9KDqdYLg8JzoYITNv9EZRc/Vy5iwvPyrrrf92r4xTHRUEyPcDMi7SrccC0H9icASO0ihqWy36MePHgZgcyGBy+WvaTZ+to2+c6XY2Q8pgwliA5rkGuDIheyBZs4OknaQvmqr7ApwOZest3uh8nmhlRwrC6z37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jmi5smuMhOf0Z5QvX6zQQcCAMDwoMZrl9PBmitptBM0=;
 b=aCyKXCdSh9i92uQwDKUxYYWk56Af9+k2oloUj0Dr2Tr/vnvUdIC8PctaLflZ3DbDik7f1Oj7Xfd1xF9jRgZiizpIPiPBsTaVYrDwCdr9NvdCY+Yg5sUcWOHFLHsyXV2i9xeM6qaF3rFbuSW217gst9N4Xr4g8wFNlXdX9gzSTmpD+g7zHxaQutWsVQHY0dMMfmuE77aGgxf2Bo1rV13ROLtl98lI+SEsDhF9BNP3sLYhmIpmu1OiMTqXbG1x54wQnBBxEfI8KwvqjGLRLPn9lyTUy1EIsSRSkXE9/utH8kI8f1Wr4yxs2yuo4iJdN7FsAqIqU30E2zzTfUtZYCSbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jmi5smuMhOf0Z5QvX6zQQcCAMDwoMZrl9PBmitptBM0=;
 b=l4/pW0cIVLSoTb44HW3RfXlZzKgsBWKGAhIulLTZ1XpPAW4CEEF7weHfPX6hgywWOe7yESrkNPF8Y41iC/eAzFDDxfqPdx91RkybTQVnzPHnpeuHs1JfiWVZh2XM+N7p3FFPUSiTmM9lRUZ2/0CNqgwMdbAaao+h2vHFvEItjt8=
Received: from BY5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:a03:1e0::17)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Wed, 7 Oct
 2026 13:14:51 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5d) by BY5PR03CA0007.outlook.office365.com
 (2603:10b6:a03:1e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Wed, 7
 Oct 2026 13:14:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:14:51 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:14:48 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <Kevin.Wang@amd.com>,
 <asad.kamal@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: Add store npm limit function
Date: Wed, 7 Oct 2026 21:14:28 +0800
Message-ID: <20261007131428.351196-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261007131428.351196-1-asad.kamal@amd.com>
References: <20261007131428.351196-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 007ab281-3810-49b0-2549-08df2474f861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|10067099003|18002099003|11063799006|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: E28C7+zzNgpCrBe/fX/GWjGeMymI7X7G24Ii0uL7M0jVrBm72tcb9ypAl+zjF8h/f71xMYshvAaqrwDGG91c6oWYg1zqZn9DkgaUtsebP4QhJoprPR5kVMtvN505x0NTLmSC23+acF5d9RW5Wn3a7WjAb7iQ+f+1fGBQpVX+3zTjQzqu5Ppz2FoUqavZ30CMmWRosda/epdXfgqMlkV+R82QO06ObMi6pFJjU3+cee93fhbdOn29DgYXhsCMsgFDD2cEGsNjGnEjnnOVsNQ8bx+zNY1W9iJbnjaH7pX/mUcLgZ3cLJ9b3gUf1mkB2mLp2WwvLxavWjxnSfcYQb+Ek83XAgmRbNhWJdxAYIu5WCtNxI+iHSeJDdH5BCiuszncLUxGU5d1TkMn784EVPhwYalPikEc9c0hbnTAcnbXUYPMy6mQTD/6i7Ph/4MW5BSV1aM5VqjfSJC+otcQAckEOP1GLGsjZqBJ+DjJtQgBXKq5ffhlDAsZOGLHekPByO9h4cJV5Q1lZPAwghI7aBmo0BI6drIyShkQjS+0RZk0Da0sQj8cMJiE9d4YY7U65U+cAl1BSWx9XRaCrZwyTFvy3vEiy5wpFZAtPCYsnfC6GQQM65QpXhazd6/J7BNAlQ4XxTCRKcz6dRdtfU+7K72lkDzfPNXhsvqPtGwOgxhjaOBUGMpGMvnGA/aZhHZTHjVkN5K1mPnkhLzE7GNGXOJNlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(10067099003)(18002099003)(11063799006)(6133799003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KF3ceZmf44pXbMzpkEBKbNw8ZqQmwnoxSKxv1BGkjsEL8A2AHptN9xuCNepZeI+wwTrphV57ChPWOh6C67Ra02w5AJvN1En9NL5jbn+h7+6CNMMieyU+6G7509+LHR/milt4gLeWy3uC6wW6RDgJc3UmOHsxCCaBhot8BR9rCUn0cr/w0qJSF5gMqYKTo7iJu6vUrFwNaGBMlxvqpPfy9LH0QHqBS18ZYauZFNpPUTx5bPrP041uOXvc/kPHK/E7TbrRAiVxWPaltM2AgV22b714YXQ/rFEosXLyiBKknD/tuh5teHQqJ0Kd9yznraLmQoD/rFcp+3z5MfIaC1J313lRPeCFBRXsggmIW0YLj189XowiCeeKlOijeNW5dN8Q7/dha4tZ+6D5Uqid1iqH8PcYnsGAHPPvL6QvxqB0Qu5ke79FyvF+R/MXOlzStJz8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:14:51.0545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007ab281-3810-49b0-2549-08df2474f861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091
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

Add npm store limit function and use it to update current
power limit

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 33 ++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index c6e3748bb11b..48c52ac0fc77 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2211,8 +2211,10 @@ static ssize_t amdgpu_get_gpuboard_temp_metrics(struct device *dev,
 /**
  * DOC: cur_node_power_limit
  *
- * The amdgpu driver provides a sysfs API for retrieving current node power limit.
- * The file cur_node_power_limit is used for this.
+ * The amdgpu driver provides a sysfs API for reading and writing the current node
+ * power limit in watts. The file cur_node_power_limit is used for this. Writing a
+ * new limit sends SetNpmLimit to PMFW. The file is writable only when the ASIC
+ * reports the write capability bit for this attribute.
  */
 static ssize_t amdgpu_show_cur_node_power_limit(struct device *dev,
 						struct device_attribute *attr, char *buf)
@@ -2231,6 +2233,27 @@ static ssize_t amdgpu_show_cur_node_power_limit(struct device *dev,
 	return sysfs_emit(buf, "%u\n", nplimit);
 }
 
+static ssize_t amdgpu_store_cur_node_power_limit(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	u32 limit;
+	int r;
+
+	r = amdgpu_pm_get_access_if_active(adev);
+	if (r)
+		return r;
+
+	r = kstrtou32(buf, 0, &limit);
+	if (!r)
+		r = amdgpu_dpm_set_npm_limit(adev, limit);
+
+	amdgpu_pm_put_access(adev);
+	return r ? r : count;
+}
+
 /**
  * DOC: node_power
  *
@@ -2259,7 +2282,8 @@ static ssize_t amdgpu_show_node_power(struct device *dev,
  *
  * The amdgpu driver provides a sysfs API for retrieving current node power management status.
  * The file npm_status is used for this. It shows the status as enabled or disabled based on
- * current node power value. If node power is zero, status is disabled else enabled.
+ * current node power or npm status value. If node power or npm status is zero, status is
+ * disabled else enabled.
  */
 static ssize_t amdgpu_show_npm_status(struct device *dev,
 				      struct device_attribute *attr, char *buf)
@@ -2371,7 +2395,8 @@ static ssize_t amdgpu_show_baseboard_power_limit(struct device *dev,
 
 static DEVICE_ATTR(baseboard_temp, 0444, amdgpu_get_baseboard_temp_metrics, NULL);
 static DEVICE_ATTR(gpuboard_temp, 0444, amdgpu_get_gpuboard_temp_metrics, NULL);
-static DEVICE_ATTR(cur_node_power_limit, 0444, amdgpu_show_cur_node_power_limit, NULL);
+static DEVICE_ATTR(cur_node_power_limit, 0644, amdgpu_show_cur_node_power_limit,
+		   amdgpu_store_cur_node_power_limit);
 static DEVICE_ATTR(node_power, 0444, amdgpu_show_node_power, NULL);
 static DEVICE_ATTR(global_ppt_resid, 0444, amdgpu_show_global_ppt_resid, NULL);
 static DEVICE_ATTR(max_node_power_limit, 0444, amdgpu_show_max_node_power_limit, NULL);
-- 
2.46.0

