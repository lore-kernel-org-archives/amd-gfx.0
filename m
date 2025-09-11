Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB82CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 14:46:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B0210E389;
	Thu, 11 Sep 2025 14:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cKDh47mt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95AC810E38A
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 14:46:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhPNQe9eTtSgkn5v9w7P4+6YrSRnLrYb0ERR8XWLHYjZyqUoVprFX0j1nHIHrCSkRvcSuucPdVMriepBnFJ4YiCs9chdIqn1uMzRikzTeHE7LTDPcYo8YBLEzCbWcG1vgZykiyH8QXAM6SRJmJGtidoioCWLfA1ZOEreSf+9i+Aq/GxSeivyf8puawuEaGTrAleooJca3dyRuqlzymX7oQbnPIqRkUqNsZ286TQga+8AGzaRgHmvt6GGQ0jcUEufdKuqdKx+qlOhOLQokmP9mOZy76NTEWVpBMM9M49Xps0QlcmQ2u/ImvGa0YIHUyZOldGi+W5gBTme93NwqyI36w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Fit6yhdpuXieN0vtQNoNFvy8D4duyyXiP7kWtxL67w=;
 b=rhk7iWY1CiQR8914BpfyTLxWLODc30bVImdWTTNXuIC1ksMPlwhoRI7msLJ6uB2qxNOMM0dhJ5MGAcnCmVp+s0j7fodiQfz515uNNTmv5VnXBafDbJIGD7LZ2Q5NM1eefELj8oQU6+ugQV1NVaexDBk+q7CilIy4jdcLd6Wab+M28ovWu20yCHBVfFN+ptwKYYyfsR3pAOOJqQ6qdAGdjW2GRLs6YafNWxSOTb0ev9BsGWP/miCegheAzkhHR6lB9M4Fcr237GTGuNxufBYsAGm/2Om3SOZENP0sMTHtpavva2mdHMUWyENMRgmPvxHIhdqC/ER3EV61kPEni+8pYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Fit6yhdpuXieN0vtQNoNFvy8D4duyyXiP7kWtxL67w=;
 b=cKDh47mtrJKahKbgtm/1mqc0lBoUo+J/vOQqGYcUaXFNPAG2DhUUI73rNs3shI0CXsroo/PWwU08K2jY+aRfgc1a9Ae9+CkwNtFlDHHiV4wLuH9O++8yYHeKzZg5StG7g0idqarHVDTO7aHGXQfk2FlKf5JPEJinVdzOj7zi9Ls=
Received: from BL1P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::32)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:46:29 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::6d) by BL1P223CA0027.outlook.office365.com
 (2603:10b6:208:2c4::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 14:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 14:46:29 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 11 Sep
 2025 07:46:27 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/sdma6.0: adjust SDMA limits
Date: Thu, 11 Sep 2025 10:46:13 -0400
Message-ID: <20250911144614.3338953-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911144614.3338953-1-alexander.deucher@amd.com>
References: <20250911144614.3338953-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6323b0-450a-46a6-7b2b-08ddf141fdf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zaSQEKzUNNKuT8uLo4hSG8j8Rw1tO0vifrDeLaPZAdlaFoWT5evEfhuzKsSJ?=
 =?us-ascii?Q?TuyerKOEoQqbu3YKySrEFDgMh99j0Ktu4tS00A3IEs6PzpP2bBWTJR3sGz/+?=
 =?us-ascii?Q?SMAPDWOhx3++Mk77My0p7z5As+fwEp/JtClL57O2JxPBJVCooyqMmLVsfTb3?=
 =?us-ascii?Q?b7yEnYJ1SP9WsHByqajAVQWbKfQKPAXAVUE1milJtrQM7JeSktoaYZHGy/A9?=
 =?us-ascii?Q?wMW4msR10xR0raRMjjgBO/J3+DLIZL5A46WtcsYR8UZvGMKIk5p6QRWvgcVO?=
 =?us-ascii?Q?6STCujs60BgFlGPPcD+q+UrprO3BxrmLYgFeszLaOM2Zn9huHL/MziMXhiYt?=
 =?us-ascii?Q?FyWFsKYifR9M3K2+/NPZvcV2KOs+C7nnGuMJq5CXHTIKSDGodplCjQZr3dVf?=
 =?us-ascii?Q?4AXoWhBAZJ+emPHgKEBC9cUy14sRTlQTldDoUm/IjyOY4zZjR3s0HV8bYVyX?=
 =?us-ascii?Q?JLsytdiKuDYy/GMlfpd/dZDgTGwSyLbG5bHX7DIN5qWD9hBcxaXW1C5hDbjv?=
 =?us-ascii?Q?QofCiyIiOVwhULA6L42SAK4Y427FlXDR4XFX7jsLOTgpiHmBSM5ceHBKfCr3?=
 =?us-ascii?Q?DDct6HRUkU8LjN+LdQHA169dh3uVQ/2Wg2/HTh5Up6jcv7pK3c1185Tt8JO3?=
 =?us-ascii?Q?WwzBm5sRlaLaLfq6EG/n09NUM9WNv3b0cC5Vf8wXzMDQ6I71X/yUNg15c5ag?=
 =?us-ascii?Q?puHPQWZ8F1bi1IRi22dKFx/B78lNOqYT+KwAd1hxC7N+Kk9JOgCv1S1Qk7Xy?=
 =?us-ascii?Q?tBtxps0EmMugjyr4SZCj0LyTg7p7n6eMEivGu+3pqNoOZ42LeD7v0dtm/3Fe?=
 =?us-ascii?Q?9ZvpFTH8SbJUsOKoxOFwoCPr1IO1k8amEJdlVMUDAN+ZMm4rX482WrAv1vSP?=
 =?us-ascii?Q?nMBK6QeSO3RF2jOUqTQpNTZXp0nRGcpCLVOj472EyIufi+IrdZ+1jwqd9dEl?=
 =?us-ascii?Q?4ekBcuK4DIGbfI845w4J7boJGNP7wMoCF0iX/kjpgFAdgvaLhKrkSFwNQ0V1?=
 =?us-ascii?Q?SCv6Q+Kz/4kZQYRNCdnuaQ3ljAQEUYKqG1/AYCXH+5eUCXNk/rKqsb7U8E5b?=
 =?us-ascii?Q?y94MbjT36b8+zpq2pr6NWhBYm14HsaiZdD6vCp75G6+RufPhBtq1gA+ta1r0?=
 =?us-ascii?Q?qm34EGvGxwyXhdsgei+Kbi+kQsGn0Cg/7b93F7Ise3xTnp68jwb48MfDPe13?=
 =?us-ascii?Q?c5xMrbNz0gD26YgCQ3QiJB/GL+H3yzKAPTKIJ+DIWQZu741MK5jjsL01X+gp?=
 =?us-ascii?Q?frP1IviMTgAIqLAkzRkY5xuhaHG2iTVA8n6EMEAU3o0WjXCT4MVDuHrYSA3u?=
 =?us-ascii?Q?Gt50kQxSj1NWYnDGU+Yb/GfdfXMGuN0byHmqKRNNSja/RZ0RgF2daitflQVx?=
 =?us-ascii?Q?F3bCQswgrY+PZO0huBSu1WVYhp4UBwHEVrPJAdN+p4N5e4ZKoUKaMijtKnDZ?=
 =?us-ascii?Q?NNuWPfJFnwlrJHYYkh61bEwUxoK0c+eJt9R52rdYvccBbcKGEAFguELL9PP+?=
 =?us-ascii?Q?jCfsJLhCJN6TSsgVN+dCScKj6Kb3O7VBLBzg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:46:29.1934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6323b0-450a-46a6-7b2b-08ddf141fdf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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

SDMA 6.x has increased transfer limits.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index db6e41967f126..fbaeecb5f5233 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1873,11 +1873,11 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 }
 
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
-	.copy_max_bytes = 0x400000,
+	.copy_max_bytes = 0x4000000,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v6_0_emit_copy_buffer,
 
-	.fill_max_bytes = 0x400000,
+	.fill_max_bytes = 0x4000000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
 };
-- 
2.51.0

