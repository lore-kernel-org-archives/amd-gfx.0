Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6501061B1B
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 18:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F5310E607;
	Mon, 30 Mar 2026 18:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9A6gPiZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012041.outbound.protection.outlook.com
 [40.107.200.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A673210E607
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 18:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gznfKgphkEuME3+0mDMiNGxF+kpBdkwsGF8AguWJ5zFZlfuOpwZY4k+zDY+47F3i3dJTIJ1YBdG7bbZRBMfQ+NAvvj+IuBzItt/LTZ2NdINw4RV03hmSkZebUAcQ9FokW0h6uhhesUE0GtV7Ry2T+Dc1aGn2u5FiNJIHZYnyT+aj6MgBvXwHlvjGlXUvF91TCJIctq6PqhYF8WfeB9qGWsq7P4U8Xw975LZD7NDEd+aQDDmIjk2ar5AByRr0OcvvGjculesF9MDaKmFCyTmm6dDEcuAeLZeBy3fRDDlIZ77ZB02g0XN8655ssnMA+zbFeqnzkqhnc/3fSz0mOelfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8QyjAQuYBqyw2Gwk2EqwL6OyKSDJhR004WxGEbeoXU=;
 b=wU+Uf9kxqH/PzeyI9V+TpGyH9ajyURjnXrR/nah+FSIpbGH6Ds4cXltWwxJSw9Zj4dVTBt256wLdomHCyIZ2zT9pNgl0oNSdHwiqSmaL26a3LRlGLhmUgIuMusbf/VTGIBKo5+0oviqcTcEaOJl0NLdmcmnJYUM55ItqpHYKuo6pwFVi/nRlJVQ5gV8Vs5u/r/PMvSAdDg25Gon6pF+44SQK5GOt8Dx2HsNcaojnCCk4TmXhViTDmyWZ8bESQz8L9VrIi8C8QZ3ZnFmRALO4DG6DBN91RV28MOQg5jIjNaUB4Fi2lsyu2KEY9Nbb0m8pj0NIpcF5pvGiplqBqCLrIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j8QyjAQuYBqyw2Gwk2EqwL6OyKSDJhR004WxGEbeoXU=;
 b=F9A6gPiZ6zlb9teHay7e9Bk9D1yfTGdQV2DnH0YfR8ilcZ0DoCdchK1ZjJVJtktTdK1Lr3jjTIWjPOQJVQiJNxsv7QxFITQcLCUH7P44efEJ91B8tQaJRrpbgivCIISH81hsaQP8L//eZB/Lq0Atfj6syijwNEvrvL7UzkoxyS4=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 18:36:31 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::4c) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 18:36:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 18:36:30 +0000
Received: from test-X10DRi.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 13:36:30 -0500
From: Alysa Liu <Alysa.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harish.Kasiviswanathan@amd.com>, Alysa Liu <Alysa.Liu@amd.com>
Subject: [PATCH v2] drm/amdkfd: Add upper bound check for num_of_nodes
Date: Mon, 30 Mar 2026 14:36:16 -0400
Message-ID: <20260330183616.5280-1-Alysa.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c89972-5be9-4881-a35e-08de8e8b42f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HvHafSavDaLt3vn3I2nYMlWjSP7yPQoOOCs28DcGrOCcgPrJYXMLgLsmMNFXa1JudotHRAM9qHCU4F+fHmUSo9oX0slUKLyPfhtneVPYXz6YFXiJ8+gpWDoyGfae/O63f2c4/YcHm5ZBcQEs58e9aM/ZCbWfIgvpHIapDjS0A7fh6a/2tKN6UkgIsaT5glrw8YnUI+b5EoXC8bSlXhu646hYsdObUekFOwRnMUsbc9pQvVcohg1l0rnCC1jG9vPbsmVIiuuOIqDi+Cd3WUqljP6euAC2E99YgQWknutJXuvjr+q9Q0QD988GG1Q6ZNp2tP0h1qpqu48JlWvWXPfaVDcpkvTdcCurNKCxjBF45Fffv1dwSi5IfW1oTXeLHK4ZBJLi28ErQSrrrk258mzRBxryhtZBtIAzEQY+DAGCjplQrq2ego6aNDJX3ALhdyrMcxa2b9Ge/b8WalQ/iSrcnvhwuMg9W72PIJd2kAgiZZ3NDMKkE5UhYgoRZeU5bdeJ1XGub3eVPOmZOKn+Kg42v37ENVp2LgQAjIRF50xOS6fZ+cy0kZSb8iIKbx11m/4Rki66T5k2FO5bPmJ9H8D0uQJSAo32QvI+0ddAa7Q8upyZPvnJkTZER9JWZraWIUWxMKsMNXbBNavqcV0LtAzTt0t6Gzo41CmDZ0MMDu9xYQC/V9USBYtY1jDcsGkldDYBOH1rgFmCq5EasUr4KBw6xCuk639e7bvJ3RzoCQKf7ZkLfOxJFTqKzbBNVKgrk/VfbXOXrlB30xqFb+FiTAinPQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZhthZKPYwwNfctdaYS5ASWly3eGug8kZyoK/fI9dCmX2KhGviyg6vRP37f3/h78pJYXQ/5X3P9Dbx//l4F4imMS+ZDDTxyInJ6cmgkdCHXCcgn4xwYJ4uiMbQI+/v9TRwHafHRfemkdE7uBKcVlxF5X93GMkJzGObHO5VBuCDaWOYi7hZwE+noBUMy3JyZxIKHkJftcMDxS+1xOkidipU2MhkJahZ4YQjuZ1Jti/UL9KRDphZH7pmvKSzcuLt2jnY0T9+vOwDuMv7heiB0h3X2sFoNJw+a1eYnhF3SHMdHJi1+5AQxttgMN8xbcHexIURwjUFLHWtzQaL3QC/QAraNS3+aU62tCqGNJz8/nLHGt+jWrEVyFp0Wid7PCwGVz7yRos51MAJrgmwDjm/q3P7V8v5r/9tOpsSAvgzSdRu/jGgIFsCWROQje4HSqwokd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 18:36:30.6908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c89972-5be9-4881-a35e-08de8e8b42f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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
index 1db565442c48..91f807c9e553 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 		goto out_unlock;
 	}
 
+	if (args->num_of_nodes > p->n_pdds)
+		return -EINVAL;
+
 	/* Fill in process-aperture information for all available
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
-- 
2.34.1

