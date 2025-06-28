Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA591C7EE32
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Jun 2025 09:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF5310E0C4;
	Sat, 28 Jun 2025 09:01:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NlOex65Y";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC15710E0C4
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Jun 2025 09:01:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATPBZQOnI7VpU2z8ZADICck0heLolQng7v6//LMcreX4T1sejbcy9ukiBFtNw9iu20tH6iuAbifdZPpfDO1F+lf4O9O8QhCwCebQWaqpXl7+8BtTfMxd4+UnaWmmlWnOt0ZEW3fng/s1eH2oOWqgjBprMSRM+0BoUQk2kLVJwVg+B5O5GbfLv/MI/CisOSCbs2qzacWx3DanPrMazCPPm0nNeBKN5MustpP8+eUrBGsVLDTa4TSboBf/iTywOifGxuRrSgxtAnuJNfnlf1gMQb/iw4hXsP4EwAvOtc6wzdfi/9P0k4pOyFNkHK9y4sZRlZMgWxKwYcd9lROovVgnAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7v3dyD3W/atldNdhnQSOUnAzBjkLJsgkmgF9rEBQNc=;
 b=trK4h7VChWnUIs6E9p6YULz67pUCIMrlhKOrmBsAUbRZQQHR7u3xlCdpkLXIo/8p3y+Z1zKqhkacC3+IA5ZqH2rpJbIii0tojq8OqHY/7MQfDWwV0RQS05z/DfONA/UDKNuOa1Hhkyvt7348rz+lx8B8qfWS0E15G7+OHIl8UW0jEM/YXnGF40Wu4N4zrBgzW3ZOWA0Pnc64oDfQ3F5iLEOQ3c9NmmqMvJ5XSbNXEclSHIAURp82+lck1QfXkUbCpXSPHEwTk5wP74Wc0A7CzheQVFfKtfMPxrDfJw4Mh7vdNK+fqzUIkPMjQ35nDIOcRZih6ZH+dJtioOPVFrYsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7v3dyD3W/atldNdhnQSOUnAzBjkLJsgkmgF9rEBQNc=;
 b=NlOex65YABSIcEZBhK94p1z94uNMbI/ECPNTM3MHPRlF7ciBlXo7zkORebfrg4UdYkUQ8L06YvvWvEsU7w6My8keUAN/HzeVhdqnO+sVA3jNZhEYOqHFrjuDDtgejZgmkwxDbGsBkE1ZwPcp8umr6nsX/O+mmBgEnTA7/gCf9OY=
Received: from MW4PR03CA0208.namprd03.prod.outlook.com (2603:10b6:303:b8::33)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Sat, 28 Jun
 2025 09:00:55 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::b) by MW4PR03CA0208.outlook.office365.com
 (2603:10b6:303:b8::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.25 via Frontend Transport; Sat,
 28 Jun 2025 09:00:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Sat, 28 Jun 2025 09:00:54 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 28 Jun
 2025 04:00:51 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Use correct severity for BP threshold exceed event
Date: Sat, 28 Jun 2025 17:00:18 +0800
Message-ID: <20250628090018.327806-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: c0767a84-0cbb-43ed-1131-08ddb62249e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0fNWmWI7KqparonW2HBwx964r/pQwLsrToAeSA4OPg1eeUWCSGNqL9a6NYy5?=
 =?us-ascii?Q?IredR0x1KfWSfc3rBzM9YMQ2/fHm1m3SEuFcY5BAo8DyZOmuJPEajVdLKbXy?=
 =?us-ascii?Q?A5NsTRoCs9tKt+L7dKQ6yFda6L4jMkaq58JFX125h694NWrjOwGv8Vqn1di7?=
 =?us-ascii?Q?WqTxlG/eKatjQQa5EuIc3Gp5GuaUgTaP3lCqubGWKeHCDhEALafVeMG3rdsB?=
 =?us-ascii?Q?/yk6cIuWUBdEyKP+3vAh3944n0855w6FIgH8tIWV5QTs4Se5ev+Sx31G9WaN?=
 =?us-ascii?Q?lVbERnAw2Yc2uYzc3R8+qAg5I/Ex1G/7unFvhd/16j/rvdy5QPeU0izv8yy+?=
 =?us-ascii?Q?Xb1n4Spp5YHw/+d+X6dqxjJD4HQ6FRvpJemJGiJwYRIujIHVWOYdSwcJiY/t?=
 =?us-ascii?Q?F9Z4fzsMWDq8s146BWNjAaGF1+iQo3P1yMV+2IrLfpRauVagsg469htfLU1E?=
 =?us-ascii?Q?n20xHNxcAZBu3KZhMtd60g3ohjPHJZ/1TTThJP2ohxErIjfi5VISWzz4FIwL?=
 =?us-ascii?Q?XrkckDFp2jNKmAS2SDDjOD7R9vK84xQtB1H162qhvVbN+TDjscIsjUDBBC/+?=
 =?us-ascii?Q?8C+XadYHQETbG5eZARWzypDnHcDC5LBDPIACu2pWuV0ogXMiAUbMXnP+Xmmy?=
 =?us-ascii?Q?5c65QuSDo8nBzbQTmHAsKRxxDQaNmZGo+CuriNyMUyh5aDBekk+If0AkFALW?=
 =?us-ascii?Q?1vSm/ClK3QDSV6Zf4QTof9kpLcFkcvpEREZmspDt2AQJbVYw1HW5e6DOgf8c?=
 =?us-ascii?Q?qHuklnZ+zxGiQHqkoY1oWfkoGqD1vbsw69lcjiTb868dt43FJN80daL/ofZU?=
 =?us-ascii?Q?S7mz0MUTTPHG73t2V5tyJ9AVm2Nu0F5zl0bHXWU4QDxSqrdPVNcAZQpkm3wY?=
 =?us-ascii?Q?W5m2sGkgGQf1kK5qbshSs5SWm2eBmpJuHAbvAXP6ePL++4QimRstBINYoYfA?=
 =?us-ascii?Q?Lb3LkPp1BrzBeMFKPwAiNaFhkpVtr/URIeLvg/6v1KH4JTwQ69ipABgnooXw?=
 =?us-ascii?Q?T8O0vaPjcIX5fqvISZMDlMagd/KDb1aacWPd8bUVKHP5GwcRlcsadTNNuVZB?=
 =?us-ascii?Q?9unrWGSCyyMIHeBhVdTaWygOmXH+S6CCdqmj+kLLDAsrz4ZWYOm5uPwUAbCZ?=
 =?us-ascii?Q?7A3/t7DVNRlNoxXFbkJzgrw5XPdbX/92dxnsELc5X0lPcK1MZFF8hP1GZ/ic?=
 =?us-ascii?Q?Vh5fPilkvyRaXqtvAKlgE7okbTq44vQutlcCj8Ib3MD0qXu46jSUjAuXIh0W?=
 =?us-ascii?Q?FH/FK7eKpkUuD+JMZGRDugwIpARvqeYw46UoLlu50ukMqfXPsBDIoY/s6xJ+?=
 =?us-ascii?Q?aw4I8fg8YgiuGoUUWmKOnTeGaPOqX1kGQskFHmKBv52xj0ExSeM0OoWbZ6II?=
 =?us-ascii?Q?DfkZ1ZoO13Ps25r4OVX6P0ZBGuH8Zsw8/mQQh+EGjzEDBf0O66RupthWtCE4?=
 =?us-ascii?Q?gxsOG8M9xH5JXKJD3IAdSqWXvDQaXMD6EZRzUfagO3rRTnTgqb3ZACIe3xSk?=
 =?us-ascii?Q?Nkxl3peJjqrZCns0FPfkgr3ndacymnkJksL3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2025 09:00:54.0285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0767a84-0cbb-43ed-1131-08ddb62249e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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

The severity of CPER for BP threshold exceed event should be set as
CPER_SEV_FATAL to match the OOB implementation.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 2f15d654bea2..8efaf7492fa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -212,7 +212,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(struct amdgpu_device *adev
 		   NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	amdgpu_cper_entry_fill_section_desc(adev, section_desc, true, false,
-					    CPER_SEV_NUM, RUNTIME, NONSTD_SEC_LEN,
+					    CPER_SEV_FATAL, RUNTIME, NONSTD_SEC_LEN,
 					    NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));
 
 	section->hdr.valid_bits.err_info_cnt = 1;
@@ -325,7 +325,9 @@ int amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
-	amdgpu_cper_entry_fill_hdr(adev, bp_threshold, AMDGPU_CPER_TYPE_BP_THRESHOLD, CPER_SEV_NUM);
+	amdgpu_cper_entry_fill_hdr(adev, bp_threshold,
+				   AMDGPU_CPER_TYPE_BP_THRESHOLD,
+				   CPER_SEV_FATAL);
 	ret = amdgpu_cper_entry_fill_bad_page_threshold_section(adev, bp_threshold, 0);
 	if (ret)
 		return ret;
-- 
2.34.1

