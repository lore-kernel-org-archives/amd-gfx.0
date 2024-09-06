Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC0DCE7B0C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 16:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3306B10EA71;
	Fri,  6 Sep 2024 16:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyHYhWwY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C88A10EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 16:31:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+/WSnV5v8fffFKIMCSK+TOe+KIrBeRYL8PdL/OIFK1I5+eY0dCa22miBGErJxBApdGx+oZ2BaUdwpoGhdw8K3W9NFr+A7pXKe0Ud/dpXZHp/gPpJYTzj3BuOb4jYIlKkbZ/n2UeXhbXeb2jpFCAH+5aHimM1EYmho9lFcxUnsVpFSkEFH0F9Bg/uKBuTRtD3Iuq+2Qp1YH0MxZtHli+ntneTMdi8vn+fONizFjV7Mdo8p2CegKUiwXEP8RjttJm4vCqA1c0K0NBYNhMeeQerfrd6mCTh8HYUnXRRHv6B4w7mDMO+XA+REX2Vz20qYuBx0PnfDmjc+CfsWkEfcWy6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCCEyjyaPxdZMMbiTHXSMvDyTxxWpXea3e4fz81/fRI=;
 b=j+6I78Rq2QGtf/jBKJKOrbE0w7yM8fqHS6URkBGOiMEvmzfu8akUTqvnEDoWHiSA5xfB0pAirJWh54Hr5R/Wt4XRoNWRIInUSxEkuHaWdIw6gIC3JOPqC0vtc94qge/U4FWGHtLW98LRDFWXQqWfCaGT1RVWjszkknZ4NhLMOvW8dYOjr7/8WQ3mPFV2pONiBKU5bwVb6RhHOlsxj0/igKamcywJDYU+jJiXwqCcn+01zVUefbLQGL6rfhO3w0sb0UALUwDIeYfgsHaI7C0hBxEegdYIEkUamlw7NlNnWVfaN6v0GaF84F5js62U2DCRJw9GS2F+G7C/0v7HdSUd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCCEyjyaPxdZMMbiTHXSMvDyTxxWpXea3e4fz81/fRI=;
 b=pyHYhWwY3eAJ1FnObu7MX8aBRmCZcBjWLDSuXhEFYThcmHcnmYfCLg3q+XGUX1bes4fBlG2bWV6OeQk+zUapu8q8uP9l9RtXPNfW5mE+7wsKhz1ErwIxPgJh0B6FPcjNBftEll8E4knfx/GikBoWJ1zcIS1cXwtasL7LvimBpHA=
Received: from SJ0PR03CA0145.namprd03.prod.outlook.com (2603:10b6:a03:33c::30)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 16:31:26 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::34) by SJ0PR03CA0145.outlook.office365.com
 (2603:10b6:a03:33c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 16:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Fri, 6 Sep 2024 16:31:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 09:46:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/atomfirmware: Silence UBSAN warning
Date: Fri, 6 Sep 2024 10:46:38 -0400
Message-ID: <20240906144638.2464367-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a7b208-4af9-46d9-e3ad-08dcce91580a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4R7vXc1guEzfXjB80jekIofqhDi+7Fla6MO3/KGyG9CljBu8aR9VMmv/y0fM?=
 =?us-ascii?Q?qT0nVd9+kV4M/BKTU+LG1CrEYWZ400YdqzUZBAQzztm7smqOBoUNj1qDNjp6?=
 =?us-ascii?Q?JoG0neeCJ9Td0jtmDKRhhkzsAMhlRdWM1XMR1YK5WgF1KLacToQaHxEYwiu3?=
 =?us-ascii?Q?bygVlsSoHj5CLAXvY/pRHHJT412UC4dTYwdcIL8sfSVOq2xD8rCSAWNNgVWC?=
 =?us-ascii?Q?8gQBHjDJeqmVmhyR9JXSEAMKh0zzYgEOVBcvev8bGenhYhoZ26ggmU/TDuMO?=
 =?us-ascii?Q?ezQDEAT/Fc1JpvmY/Kj5NbHHPHzNZo32nMWr594OCm2gvetevatYwdKfJhRc?=
 =?us-ascii?Q?BsHCh+K/TIHdU0Y72PRyRk7s5YN9xnFWgIyESKmdYEvfw62RqpZ3hhdO4SUk?=
 =?us-ascii?Q?03ZKvOBL01M1ej8grUMXKcES6NG4MOmC5o+ZhOOdVvaN5h8JpXiPD2QRuvM+?=
 =?us-ascii?Q?Outjc0H9E85WMOtULFk8y59ttHI9h3cKt/TEHXc3sANObY20LkBDV1Wkz2ho?=
 =?us-ascii?Q?VAqpRLm4d0AMdaA4AzOuKGcRtzOyuis/FKXxICr/jMDa4am6cK1VrUMvgoUl?=
 =?us-ascii?Q?cKNUExldSKKxK70qtC4mf2i243CxjzUZOZ11XiAYsywM5Q97QahYI9wtOdsZ?=
 =?us-ascii?Q?nGvOISmej31cdWuAgsJW75OmpPO5L6beaSbVqF65iVRnkhN/glVA9FGATUvm?=
 =?us-ascii?Q?5dCSPDch3WxFxY/E4O3SYndBey3L9CBbuOrpHHcfINtdRFW6NwxWPvpmsdtr?=
 =?us-ascii?Q?2e7Vb0sHwwfcZ+SmpqBzlEDSspNJaYyRyo8bc36lGGcfeap9ZSBQ0UwHcl9y?=
 =?us-ascii?Q?FxKayZkzpSY70FTAvDrgPwITIY1R/NF4YkJeEGzEwKzR74DF3SJEMea+WYZ7?=
 =?us-ascii?Q?h6ulFbHMXfAfIrqE/dLAnrIlHSw58ICLiWVxQT/yJiodsdJumuMMI4Ss6DZd?=
 =?us-ascii?Q?I5HKpGdzwZnrVcHUy9z0Oqt+PLff9aHW0VibnM/zS+WabjgQN+7IrNqw+zrT?=
 =?us-ascii?Q?8aBDZo+Pp0iz00pCN0YRU6A4gyfxgYS1s4RdhJm0kdKiXj3ZAG+cgv+l4XCK?=
 =?us-ascii?Q?ZGA2nryvdeEFZSqiA7tt3iHYX24EWL90BMm3U7xA5+22r2mDGWRwehDFSdq1?=
 =?us-ascii?Q?8eDQi8OTMOKp+wRmT3zRbgIa0feAYvIm42rwWJz/jyX8Y3kND8CC+b/ospbg?=
 =?us-ascii?Q?nKdYM+hM+XIn18BEGZHdXDPsgXzVXlaHv3yTRtHf8/a1/LuMQrgEa24KWBGN?=
 =?us-ascii?Q?DTx7ZzuusyR1TUxrNnwiToI38eAVHE1X5la/cv4Y6DNOpssxMI4yLHF5cCXb?=
 =?us-ascii?Q?6fFniQMfkpKIeMbceWGmEXjA2jmPXtvU6Tf0rXOcL+crdbF8aavdM15y9yb2?=
 =?us-ascii?Q?tYGaODODn+KmNO8aauhMMPzhEU3P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 16:31:22.1049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a7b208-4af9-46d9-e3ad-08dcce91580a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
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

Per the comments, these are variable sized arrays.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3613
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/atomfirmware.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 09cbc3afd6d8..b0fc22383e28 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1038,7 +1038,7 @@ struct display_object_info_table_v1_4
   uint16_t  supporteddevices;
   uint8_t   number_of_path;
   uint8_t   reserved;
-  struct    atom_display_object_path_v2 display_path[8];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
+  struct    atom_display_object_path_v2 display_path[];   //the real number of this included in the structure is calculated by using the (whole structure size - the header size- number_of_path)/size of atom_display_object_path
 };
 
 struct display_object_info_table_v1_5 {
@@ -1048,7 +1048,7 @@ struct display_object_info_table_v1_5 {
 	uint8_t reserved;
 	// the real number of this included in the structure is calculated by using the
 	// (whole structure size - the header size- number_of_path)/size of atom_display_object_path
-	struct atom_display_object_path_v3 display_path[8];
+	struct atom_display_object_path_v3 display_path[];
 };
 
 /* 
-- 
2.46.0

