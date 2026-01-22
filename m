Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B412BC44500
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 10:41:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E5410E084;
	Thu, 22 Jan 2026 10:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ToHd8i9F";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 449A110E084
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 10:41:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JdJankQqR/T0ohQuSl3/r6BWG5EUYYZOjgb548tq6vbWMpykDdpj/218i/6lw4cvuWGYEM0mLHbPDuUN3bbTsxtHy//ntCjf8730fT8oo3Z2QkoyeB26bkBrnkS3YmpVaeNCLGO0lHflvcpU1IT/2a43sdeXIenQ0ZC2Tf9sMESsFeTb0W0Eoubywv4eA6JJQIy4r6h62KjU6kFgBBJtEyYYSIRUQ2dwBeCMTr7S7lqNgw8wipre13mEFwG+xqvO+W5orHPdD5qd9Fx1KLecAkZhnXZJHRSiAG4lLPkRUjgDaA4GULFLIFexmXw2vfplIX184SnnlL2/UkD2INF2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMac2naIxxkyfKqEicC6ZWJmgoapvt6LiSMY6ppjMEE=;
 b=PSOjJZmHjk/9OMfS+Klf3rwsm0O6+rgt+FJfK7amtube4dn/Qc6KH1B53Zife21jwGoW6gIAi7sXOtCqH7Xsu9EiBl1aZocoXNGJi3IvW6OjQ9W76zN+zS3HfnJTa0IUoiO4Vf05o7VQX2CVhDeMlDXEFUREJZalW7SWkG/R5uivGdQ+VhVTbZkuIfjQ0OrZD1sIcO5CVxs0Mej7Gx4ijSUq1nzpFkF2inDy02+ztvlRCDf29WuHsf3SHjh/UXhG5O53OntJIZ/8rILEcjz1f2/PnRNgYnUNkGHQzYOE/h93rDxf0fu8PsKEyUIHYgk43qQnm8U3q+AfHRuZrmCgyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMac2naIxxkyfKqEicC6ZWJmgoapvt6LiSMY6ppjMEE=;
 b=ToHd8i9FoMO9XeaHpTjDSByQo1AzlA6EUhjdb4hPqCd279Wlj3BZFKEJG86mX7fy2gYspQw7DNnZRCfcgxe033WI+b4Sz0Esn9uImJ2CwzAfg+fsmVgTxKmZMXrv/dtw4WcosZRcylITKEEl9PisEpT2t3WrvXzoYljxtbJBCKk=
Received: from PH8P220CA0055.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::23)
 by PH8PR12MB6770.namprd12.prod.outlook.com (2603:10b6:510:1c5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:41:44 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:2d9:cafe::6) by PH8P220CA0055.outlook.office365.com
 (2603:10b6:510:2d9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 10:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:41:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 04:41:41 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <Jesse.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v4 01/11] drm/amdgpu: Add helper function to get xcc count
Date: Thu, 22 Jan 2026 16:09:50 +0530
Message-ID: <20260122104118.1682154-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260122104118.1682154-1-lijo.lazar@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH8PR12MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: c563cc30-a8af-4824-e54a-08de59a2d5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B3C2dR/7axwmXlTFSItjuoVRtQR8HeO1YUHtS+dnqf9jgCtvTGrTW16GUznT?=
 =?us-ascii?Q?/fcsAHfYtk0cqmli41wljuOH3aCgGz9lVvJApJMGsy4/yQxNZ69IF1P14tuy?=
 =?us-ascii?Q?xvuW6neY/x+8H5MWQ/GotW5MEAHFl2Tou/pZDRdKrhj+qdL4W2Z3XMsx7Eg/?=
 =?us-ascii?Q?YCMVZAoB2G1R4ILIVFin2yJAiAoEZfnP8fMbdes9cvCeglXpnPPjhDUe5SdL?=
 =?us-ascii?Q?sjY/88WMQ2JFZG+57z4u4rVaQqW6UW7X7+wuMti1W7+dXTf1DI3pKPdOFrhO?=
 =?us-ascii?Q?LgSLdXCUNXmZIV11sSDJ3eQy7vVjtwaY+ErQiCRbuAk/rHKJylt62sgnpsiU?=
 =?us-ascii?Q?49Dx8P9LlovDDVDVWSuNgT5gvE8OS3DEk8g4enHFDIIgfFKbnZGHDlwDfbe8?=
 =?us-ascii?Q?iUbz723LxoWYfNbK0e7xiDDKdzexkXkcKq6b2NaOZUh3gQ3wBU3UjKLWsBFb?=
 =?us-ascii?Q?IPLxZrmf6nvYmhGpEJWxeELSt3CVhz1ESXUIhwoFYdRyLbpNZwZMfEaWiLfv?=
 =?us-ascii?Q?VDyuXjtWuPvUO78mcbjM+fSBkG/93NnXyzeRaWeKoZ02IhY9lBmN9th1T9o9?=
 =?us-ascii?Q?OmT9fSa877ncp33Cc4RJIy6MdMEqATDeNSrB6X63PgS/odKnBX7oR/3ApL7M?=
 =?us-ascii?Q?wMXOheUMWpzRNZ1vLsipoTVlPm6EmsfuV31w2sh0h8Y1nZqc4sORpZxpetng?=
 =?us-ascii?Q?Q1zDjx4xR4FoQmodnzcO72WHo7Hjich2xihd+ezn/DNMhWxwM96pYnfHYM5Q?=
 =?us-ascii?Q?YOHDYk+6tM21oKNhnNPoDZLrq0wemrTX0Rp+AV8Zv03j7bX0ow9LSFbBVfJ7?=
 =?us-ascii?Q?PoCy1+5v28Ytd8hG8OsDqrPSPNbjm6A3w3oW2R6zdSHlRDEvKf08FLYsw2vr?=
 =?us-ascii?Q?Hh7igvpRIL1e1fSD8mxLwVIx6ZYFOKBuSc4V6Q1Skm/j6uxUmDJaqCDA/fH8?=
 =?us-ascii?Q?r0xXc648QSyIwsrkFtGdNNveDq5t3yHar76ABzMxI1lMdT8jud1xPy1dn1/v?=
 =?us-ascii?Q?Slh2mt9DANfVq3vKeFBvTfwqprhWZvsmk9FmHIS7MzM81shoTg1pbxk0dpgq?=
 =?us-ascii?Q?gP8WNM7JORH2UHV4Y1ICpTqAXxO8zA3gk1f74pXw5bRvP0TDnRF0qFvVmjn5?=
 =?us-ascii?Q?jBAwXq/9P6JEXIo7XZAfUGb+1sjSw2fQQLcwps1bMZvthbtv8rQgqDUaYpNq?=
 =?us-ascii?Q?cQuI1eBad52TD0CY0GYTo89bJplfP/f3JDPKx+hCJlJ6IY8lPEInIopyx98v?=
 =?us-ascii?Q?oVUKuvQtXjhZ2ftFn5lDwScHsrkHGm761GjHjW0JVNbFGEG3gXuvrC54oGLQ?=
 =?us-ascii?Q?CoSlrgB8+IBuY54lBgahg8i6j4oZe2OIJ/Q2yGYS5brEn017XX9typxKhVeP?=
 =?us-ascii?Q?OAYEpP9/+9O0uH4uCuXbBqFTjDY/kVKAGUHNUWbigM302GI4CsBZIyceJizg?=
 =?us-ascii?Q?2+sf0vRvi9M1IkwD8QR5EzhdZEE6athd+J/WmnVTHZ/Gqg+xLLEWTyaiR8kl?=
 =?us-ascii?Q?pMM45U9NV7YuRV3iMl22h3lyKLTM0N00T3uSGWc6ziugbG6ifpXLVnmywrMh?=
 =?us-ascii?Q?VP+UrP9gQgRYb5qW1RXzW2h/l56EwOnRQlcCaPHr+ahw7bJU8tS/oE2pSbpf?=
 =?us-ascii?Q?z16Fnc8vkFj6vf+62+OqXYeDonfBdZNaqbXfk0bG8FOclMW6VsB5wCVUfyiE?=
 =?us-ascii?Q?N6bWfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:41:44.1356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c563cc30-a8af-4824-e54a-08de59a2d5f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6770
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

Add a helper function to get the number of XCCs given a parition id. If
there is no partition manager, return 1 as default.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 8058e8f35d41..b780c12b07e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -217,4 +217,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, int *from)
 	for (i = 0, xcp = amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
 	     ++i, xcp = amdgpu_get_next_xcp(xcp_mgr, &i))
 
+static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
+					 int xcp_id)
+{
+	struct amdgpu_xcp *xcp;
+	uint32_t xcc_mask;
+	int i, r;
+
+	if (!xcp_mgr || xcp_id == AMDGPU_XCP_NO_PARTITION)
+		return 1;
+	for_each_xcp(xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id) {
+			r = amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX,
+							&xcc_mask);
+			if (unlikely(r))
+				return 1;
+			else
+				return hweight32(xcc_mask);
+		}
+	}
+
+	return 1;
+}
 #endif
-- 
2.49.0

