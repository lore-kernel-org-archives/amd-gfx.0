Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92A4E6B261
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 03:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F78F10E00B;
	Tue, 23 Dec 2025 03:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2X3kqlSU";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012055.outbound.protection.outlook.com [40.107.209.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE66710E00B
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 03:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkqmwneOMV4nC21y0JtAT5qB3R5G5dH3mx2AQ3DCIz0UiRYUXk+ZRny8G5v14kiDD7WMqaH8VeHQwr0KJLh/tK8LMAxHTAkT39eT0W7X8/DQLb8MrrsS70BugE3hnOQknhgTVHfvijnihVsPAaJz6R5Iif/r3iqSXQEKHKpU+dOG9jtUXx8CTURr5z9CaEmHsGOeH1vARnx148hPE4PJpbWd36qI7qPU0+xbN2E3VhCuwpvJhRh1PnASd9PCzYUaOmAcLxQG3jbW7/EW0lYA/+TKQHwrwFzIWwz0tLVNzNCWQJm82JxkgpQUPjhNlFL741C5CGYsqUy9XFC0zC6lFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5+18rHB4RumW/NxzwQLH7fa58998PrxIXbEkS7pKIE=;
 b=TJHS+1BKcDGTF+hzgMnNNQ7xMb94b6WSCL4jZAp1FICq7I17oic+utm3TWuhgNIuxsbpcuPhmv3v2wFPG8OYi17V8BeSUc0B+OWowgTHZLLL4IWvI9JkIPJNXY5b990jy6DcHegU1LDlVdNgtyO7/tqAcuAOj81MgNTflO3C4xAWFqNu7akkui4o0E4iaOfNJpOWbpPN2FJBCFGHFmCklN801qlr5+hhhLgZosis+OTp+VIQNc0OqZdEaH6e3eJcxicLVdtSZFo5Rye2kNWM5SEtSBE+RlQ5Ie2kzfTYDiMItlb0UCjzJjTl45OD9tJzzxIwCcaUxfMVRh2G3JZ8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5+18rHB4RumW/NxzwQLH7fa58998PrxIXbEkS7pKIE=;
 b=2X3kqlSUdzor9WsRWpc0hG6apqo47g1NvohhBTEgcsG4s93vbOXuBsVStHTCsj0bMGnL0Jf1NTtWXCy3ar8OpCIatUNmRxoekWU+PZOyWYq0UYtXfqMlYrfSh4+MqIffw55NxUrzzn3bkaaZzEVaGqEy8/+sktF4L2/ll1yp3Wg=
Received: from MW4PR03CA0051.namprd03.prod.outlook.com (2603:10b6:303:8e::26)
 by LV8PR12MB9182.namprd12.prod.outlook.com (2603:10b6:408:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 03:01:58 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::cb) by MW4PR03CA0051.outlook.office365.com
 (2603:10b6:303:8e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 03:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 03:01:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 22 Dec
 2025 21:01:57 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 22 Dec 2025 19:01:56 -0800
From: Alan Liu <haoping.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <lang.yu@amd.com>, "Alan
 Liu" <haoping.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Fix query for VPE block_type and ip_count
Date: Tue, 23 Dec 2025 11:01:52 +0800
Message-ID: <20251223030152.143593-1-haoping.liu@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|LV8PR12MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f908159-4623-4ec3-c47f-08de41cfa2ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DS6Fn6wz73q5GM93ohgiweTrGpXEf696u3qWI+J8llt2RFuzkpyTgSVqrIdw?=
 =?us-ascii?Q?B/IT9GN+DFjLjzieE2aJ+Ww8GfunFd3e9bXQQtP8kGNIxlfT45zJk3sUKPev?=
 =?us-ascii?Q?IRVRQEbFz2xus7+DQaiHwuPV+u7oE6vnJY0Pdn7kZErg/jfUWZ0eKjDVbO2i?=
 =?us-ascii?Q?Ols0XTEljBX5h3//eXHaElSGXCk/8DycU2SN14AN/HvyLkhM4OUkXlb54S70?=
 =?us-ascii?Q?EEjmRGFqKUyi6OCfB63rtGxm4UAtPtXXmrEBCKD/MBZR0V7VgX55Hwhdsria?=
 =?us-ascii?Q?zjlGvBpRDaX6he7vvirxLOgVJD6n/PZp0fUHgSwI5Hjh+YjBEV3pYFuBiznF?=
 =?us-ascii?Q?D8PLW/pamUrdWjoYn8soD1SuXu0Pfg0+bQm3UMhDKE5N0ntYbYUaWqD+ZYN2?=
 =?us-ascii?Q?X8EOG0U2i8E2V4PRme5t7FPQaweSktTk+Ued0EBgg5YixvrkqWXNYka/5o0m?=
 =?us-ascii?Q?xY+GLyhEzdwjDENLRPCXq2ks4PFJw5GtM3KGG0jnphQ2B3FwfpBl8er418T5?=
 =?us-ascii?Q?spmdJE8Ns7WkUYaqfnzhgvmb53SC6YynZs5FM1wXdUozdhnk9OxijccSTzK2?=
 =?us-ascii?Q?cj4hT5WMzhjpwAuNv47oBjy143cD9R8jypnZeRc3SVi38czaZa32hlwpg2hH?=
 =?us-ascii?Q?EYZVVtUj7wM9SuWtY8puRV1L2eB43t8P5aHEdjI46W0zA1Zny89b8YHkyNgo?=
 =?us-ascii?Q?McMjxfagEGwTWniVPA3XRgJHdekf29FG9gOjvr1sZ04b5BHRYOrjMoCc/LYN?=
 =?us-ascii?Q?6EU2Q+6eWhDkJwQqn3cBIuhCS/RBrjrcE9/ASjzSP3CtrUNr8zHpe39r+CUs?=
 =?us-ascii?Q?kBzovNmh4MZXBc6myA0EvMdnBVSqD0Ot1HRPyIteYLL2qoupG8w1oNK78z47?=
 =?us-ascii?Q?fETaKNtYyYI9W/IxMUMbpOcSyL1kIg01ShlCa7DdQJDof5aOTM4K3w8lKkZj?=
 =?us-ascii?Q?NpzSbDltvPMy9WAV8G44N66Be/L5cQeBU74p2SBPnqQTmal6tW+lECGGrZj4?=
 =?us-ascii?Q?XCO8WLr9nvzrUuqDWmPJ6pMHJ2g9dJcODJOqPif9ZFrLfPWdmQ3cUEt9st1R?=
 =?us-ascii?Q?nti07kHzTlVGnyZwqsthWgW+WoplmvUJuiyC1epPafjk1mLcDuKe0vIYQ5oI?=
 =?us-ascii?Q?pobiB+sod+pWGwvHC3meQHUrZKEm5m8ljF5BI6VfAnOTAFOBTRLWfpnwJzwd?=
 =?us-ascii?Q?tlc9zvGCCGBC+XD+z4WwfK1E6hNzzO1OCBKzbsMWb2DZYBCHjHejBIu6nSET?=
 =?us-ascii?Q?kofluDijWUsoyCym+nsvfq3gaO+tAlywiQJS/yIpAXu/XnWX9D0GU2u72QnD?=
 =?us-ascii?Q?/RMFkwHvsXS5upZ//EehJQRKVa8hpZt+SnBW5McgyOh7Gmvw+bpLVIbGS1ss?=
 =?us-ascii?Q?hlKtE9R1mLxhY0ambkO2jM67R8Tcc2A1FAPlR9k/na2S88rLZe+anLzxpPcM?=
 =?us-ascii?Q?Af9KB4GBc0wMlh6E17DiFwuwhzaYlY112dr7kYcDNo1gK0WAEAhMW6kfJ1qe?=
 =?us-ascii?Q?xHEPMGtr/zYI9xCHWRclmo2vw4vJMWMjJAuFYx29TSlYDF9J+stCxv8VzkH9?=
 =?us-ascii?Q?GehaWgy3NfhJIeF4TtI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 03:01:57.9989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f908159-4623-4ec3-c47f-08de41cfa2ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9182
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
Query for VPE block_type and ip_count is missing.

[How]
Add VPE case in ip_block_type and hw_ip_count query.

Signed-off-by: Alan Liu <haoping.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3d286913e9b6..728033a88078 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -201,6 +201,9 @@ static enum amd_ip_block_type
 		type = (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_JPEG)) ?
 				   AMD_IP_BLOCK_TYPE_JPEG : AMD_IP_BLOCK_TYPE_VCN;
 		break;
+	case AMDGPU_HW_IP_VPE:
+		type = AMD_IP_BLOCK_TYPE_VPE;
+		break;
 	default:
 		type = AMD_IP_BLOCK_TYPE_NUM;
 		break;
@@ -757,6 +760,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		case AMD_IP_BLOCK_TYPE_UVD:
 			count = adev->uvd.num_uvd_inst;
 			break;
+		case AMD_IP_BLOCK_TYPE_VPE:
+			count = adev->vpe.num_instances;
+			break;
 		/* For all other IP block types not listed in the switch statement
 		 * the ip status is valid here and the instance count is one.
 		 */
-- 
2.43.0

