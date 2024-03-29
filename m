Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02151CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 10:21:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36C10E7A2;
	Fri, 29 Mar 2024 10:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d/sbhqs6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FBD710E7A2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 10:20:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxQ3wMPspqdVQ9JCdcCEdVCK2o/iEkUboW2NMbnq9zqpIPxLlZ1K2ycAduGIZk+kvPtNy6RCbZzFu/Ev0NAbBA7IagY71vSmtA1OFZJJyaQ1LK/h49gQTQAXfHv+uaEPVlMBl701COUbcYrb7eNdzMZH/YdanJig0ujDrVXP5qVT1vMrKF52InLf4UiJSKHywGoG2ypq4XecmrdYdHr/fN7w5/HaYTfTY5bOYsY7k55Fa+VeEJFF7MfcUvcZTCkaaSD0ZlJHVXTNywxauuQ6LBnr1aECKSEkATRCLqbBGRLfzAxSKx0noyovN9F3thxZQ93BGg1HBLwD+mJn8RYRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1BYPhbNtskJz/iyWFKoMH4RgrYtmOO7dgiL7rtWp8E=;
 b=lt0zGWcYu0Wm/nRd5iNizCgaLWUH4h0bKXn/CirOWGbkBmp8QjzcnpcfuMsZpQtXd+7bAzAmjBdXb3W/DQ9bCDiR5NnY5F50Ung/Oh0Aztfnv2GJ0pz1jveOOPI89ULWQo3vVMLQmJmgDG7x5ZJXi/6yvxvyGrfqWn5AbasTiwVtc67TuzNIk1MjInrQB9oGg9KZCjec4jzFRCphyfpMuopg5u/AkfGJ/Ted2KvIhelGgQZr4a4KMfM8sqqNbl6w6H24q1AePZuu83P++9qegxY8B2sZQ1bftuMn6Idbn8wwCGH4Nb9MbeA0tyhGbQO34Jje/rOCK8gSO5g1ggsOkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1BYPhbNtskJz/iyWFKoMH4RgrYtmOO7dgiL7rtWp8E=;
 b=d/sbhqs66uBTSVEj5GQ0U4Ovo8ag39EPIXLOOnldG4CRr8guCmNs2SiS4vt8GzujWpJ1x1vdpJ+PsNTRwQpKXeS51wlL4TsKxGmm12xv7BF50ze0KPuZ5CZGdL7CULjt9EtIXO4nOcoMvTA7NQQExCmKJ03gLGu455wcHxiRYBQ=
Received: from BYAPR07CA0082.namprd07.prod.outlook.com (2603:10b6:a03:12b::23)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 10:20:55 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::4b) by BYAPR07CA0082.outlook.office365.com
 (2603:10b6:a03:12b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 29 Mar 2024 10:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 10:20:54 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 05:20:50 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <richard.gong@amd.com>,
 <yifan1.zhang@amd.com>, Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
Subject: [PATCH 5/8] HID: amd_sfh: Update HPD sensor structure elements
Date: Fri, 29 Mar 2024 18:17:47 +0800
Message-ID: <20240329101748.3961982-5-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329101748.3961982-1-li.ma@amd.com>
References: <20240329101748.3961982-1-li.ma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: f8c2fde8-5518-455c-3cba-08dc4fd9eb0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vxf8PylS47qBhjYnR5eZjgloMfG5tIzR7LeJ0vrLsyi63n7WTKmSZ/3s5qKoOT6eq4kQ8mknSV+wlT/6qC7W4LwkjqSNrKlRolAVU258Tgs0LewjAj+fE5smi93n0MXzeO/rHQeptiwnPGrWPVAyX3DuVqXpo2bQTePO2Lb8Dbg2wXctRmXN9TNDcNobTlLZklqLU1cbXy7FVJLxa8j5G5i2lWP5aipvI24yYZKbBXKEwglE/jxj1PuCuXSdudUlsLy+2KGJNhcp44uCka+tLSw6H9LenIXoZzMyOq7U7I2GRwBw7hoIn2eQOGQsK2OUCcoXXt6GW6y+FAB/RBYa98Pf/UX9cNlWDqdbiqjrlclexj4rj1PnIGZX2lE0etc3cd6S4fj9ME6F5NrpmUtQ/PLu1SikTMwxen9W2WsMbdbcyHY8rQ6qIPBO2SrjB1AxRhBIxYgOwkyxJFMOvJqBeE9XTlyNz4rNjUymN15y1b4YMDUTw2zK4EXwgKo9F2OJ4z1bmlk5jvBrFAV3FmiMi/LEFjgCRoLITKalxgVOsWr+w8JJVCcnt52ZwwMwUHR37NDFRoSDfx6/kdPUTktFC9OOHzvpa1kiT2AS1fXwf0xNyblEVQSZjbb8+nWqkiNoYacV/NL6Q2kXflkcn+YMV9hsTwhwkz1RrumVDrmhH+2qvVycormYeDvr94Zg5fhbwwueEqzFCl+Dwp0t6FatBHZeZ2fOKYzbDS23aop5ZqQhcDJHP7PhVQHbMKn+kjPJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 10:20:54.8332 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c2fde8-5518-455c-3cba-08dc4fd9eb0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

HPD sensor data is not populating properly because of wrong order of HPD
sensor structure elements. So update the order of structure elements to
match the HPD sensor data received from the firmware.

Fixes: 24a31ea94922 ("HID: amd_sfh: Add initial support for HPD sensor")
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
(cherry picked from commit 8ca9ae7d61b322df7158d07d03509d6c483b8d70)
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
index 70add75fc506..05e400a4a83e 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
@@ -90,10 +90,10 @@ enum mem_use_type {
 struct hpd_status {
 	union {
 		struct {
-			u32 human_presence_report : 4;
-			u32 human_presence_actual : 4;
-			u32 probablity		  : 8;
 			u32 object_distance       : 16;
+			u32 probablity		  : 8;
+			u32 human_presence_actual : 4;
+			u32 human_presence_report : 4;
 		} shpd;
 		u32 val;
 	};
-- 
2.25.1

