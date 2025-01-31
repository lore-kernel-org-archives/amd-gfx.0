Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F301C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D8710E3D7;
	Fri, 31 Jan 2025 16:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c4zgMIUa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 050FE10E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2ZJPqYtodB0U20gJwQ9C59ihEh07rAXwYgQmoqFEA7FXPGXpCEIgvPmDilfD3/uCEck40hLWYpAzkAVfjvYx9l/FCHPu6NrxQkiTrJt8aV9QKZBxf/fCTDtv2HtOlLsgXYFbyigUntb0hSjdxCJggAF+lsYSIvvGnOj0nVRjMAJgI3PoPmmKA8snfcJR/aWDofDPcEyho4dU30/eTMbxZF/Mksb4GCallRI/IP7HURfGLJ8eBhyS4eW1Mu+ncgm/80pNzk53iow/8nf6OAOH3+nwgWBh2XYfu1Q16IKHFvBmwsz53hjxcQEQ20qvF5Xa7PsAtmIuA95bTndpwg9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFp+18TCD0mMp3/+JB0/zb0NQ0PWN0q4sEC6tdb9umA=;
 b=iALpDWvg+xM5L8cpVtV/0roFw43aepFSu98xD6cJbaDXlKLY1Aest/RS5ZIWgpi/tPiOT+BY5WtuuDca3Ye8QQZYwj+mO4zOR14c85In//ogdR4+tvztBdVCjDnNzds64hR2Orm4miiqFK0B7F2Kl75PNRrsPb7yOxAme7gbKQiwTi+HRKCiVg2bVFy3ftGIJFmIPQkiqb4QsQc8z5jupYrbZdg8fzjxWOTPuN7Q4r3qKUoNJCjSUO8wg+VNXGdwBVu2qKte9YQheWNgAxoJrdnC1zyCFgcRok7JzIQuJkBg39Tku+zABoCPXOSQK0bbN34DjolwCBCKrWj//ehCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFp+18TCD0mMp3/+JB0/zb0NQ0PWN0q4sEC6tdb9umA=;
 b=c4zgMIUa8s7rMTrROgKMfQh7tp91ABfUy/PV3xFEPUN+fEPQueyH+lBFcTceUW+wMxX31L943S/yMEYu66iN+ULwdTbXViyNe/yRftrH/J8P6z/9p04/m3IZB8xeLooYBwzTXu1j2VPCa3JKOvIEsWy6T+Vup5oRxxhFLqghENs=
Received: from DM6PR07CA0096.namprd07.prod.outlook.com (2603:10b6:5:337::29)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.22; Fri, 31 Jan
 2025 16:58:17 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:337:cafe::51) by DM6PR07CA0096.outlook.office365.com
 (2603:10b6:5:337::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 16:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:16 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/44] drm/amdgpu/vcn: add new per instance callback for
 powergating
Date: Fri, 31 Jan 2025 11:57:18 -0500
Message-ID: <20250131165741.1798488-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1289ff-91ee-466e-ebc4-08dd4218753b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HpcZoeqiWtmxmhL+k4PQu1IXXwsQkGe2o5TmIDifaGSkGO/i7OqjHhD6e0vS?=
 =?us-ascii?Q?E0CIGBklCPjTnZHcHmEbLtDQFJjlC46zvHzAlPB9Mjol0XZKrHaDrYOO7oyX?=
 =?us-ascii?Q?xCPCZ5t6nNdCXRfFQrLr7MkDVN2TZNpoV6DgYeVsBQs+WQXSht+m9MvJBeNI?=
 =?us-ascii?Q?GvLKhX7v31GBBbQjFPpEbHKhJUt8teDdO0x5+iYA/+4KAr+QTIcbQ6TFQn22?=
 =?us-ascii?Q?EKXAIQawflnZpgaN5ZC2zoih6/6UciYiQtfPMWOVml3/SOtohkrOV5E8VdYN?=
 =?us-ascii?Q?GNMzvxSnSSeyyZizLb9BdOdVko9aZa8pp+K1i7oWL9HwjZ7CWKGnxP1hsBtK?=
 =?us-ascii?Q?cCsmIKfRWH/4QXJ3Cr59273Md17n75LL1N7Tr8PsBa3quXv9LSOabAmPBXwO?=
 =?us-ascii?Q?26oPOdhxczKQdAriqFbyTL+Is6+DTdkWnoVM1hNdfeYQkdky9iF2HZ+bjqQq?=
 =?us-ascii?Q?5OdtAzJdGFMWzZ85Gu4HHYEzr36b62B+mxNDw1yb6FPlPXNP8kRnN7X2vEvZ?=
 =?us-ascii?Q?kdgeplBiPJt5mryJypIVWCB9gqsFfJ+tZA9xoqmU6iqTCO5dxb1mr9BMzmNA?=
 =?us-ascii?Q?ou5eNT+yjJqOlMne9a9ykB3wayS06YMacAzjPd5vqD15gAWkNNgS4rOtSSlC?=
 =?us-ascii?Q?xFvkj9c0l2q1JnSVoP0DUXnszpxNT1i8MApfvNz7vbu0VePp3YaQgLx5cNSM?=
 =?us-ascii?Q?GJVUCTx+UYTh8x5UIL29j/uf37Fcwf2Diqrxs2m3owZxDLY/Py2gPqyZSMLK?=
 =?us-ascii?Q?e1vb53vIJxg8KgpFidJ0QFInoysSgEoaFhm0N15lj0O4GLpSCvY1Jj1iS4QR?=
 =?us-ascii?Q?pGtL50j/1jmYqE+vvdJRSUOQkE/KkA16iOfOMRU/WugxlUwN/+3WYkgJa2Wv?=
 =?us-ascii?Q?V148sq701vDoy/dD+2mvSz8g0cMY2zFNWwh1CUKjERTISqBiLRmjat3Nr2PL?=
 =?us-ascii?Q?GxIFLVtAWM9Ja3i/7CMNVn32mxlphEKR4zwQDNkWQd/ketsM91rC9u4pOxCy?=
 =?us-ascii?Q?Z3C6AgFMBNULSLJMOzB6ATLDkaXtkNDus7/ebd519pkVFvqDD7Si66RZonpK?=
 =?us-ascii?Q?ypfCKo9OD8HE3BInG2HEGv3n/IxmvLfIZ+i+uzyB5XLepjjl9Ldf4oTVD2sa?=
 =?us-ascii?Q?83AKteXcqpwAAqfY6LQ0aYd7xSdIWtZQFGaJngXD0M7dTEbsH3OJwfY8GkW8?=
 =?us-ascii?Q?Ngz3Yv3yonerJC27d5PUFZK29msskazz5WEU0/CBchaUceXS426cwEEDuLbq?=
 =?us-ascii?Q?h941OWLBPBZHe+tsyJTuxpTIjfi4q7I3mYj1FGV63c6wL98t245mr5k8Nzh+?=
 =?us-ascii?Q?mgnpgzDX19yM6/p0grclg3aPDopx9sJLjcy3YsxHWojbu3y5WIm2HRfSsFG3?=
 =?us-ascii?Q?kXMe4+ohxgIHnI0QZNS/MQXoFQlrVYmv2TPTcli0puhMfCNk+HSDy4TDUKUa?=
 =?us-ascii?Q?mMVf7mZfQ1Xlm3XiclFJiZVqfxN4AiZKAYR63G9I9X5c8RlfPQghvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:16.8894 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1289ff-91ee-466e-ebc4-08dd4218753b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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

This is per instance so add a new function pointer for it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 8d34e3814ab19..508fa022df78c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -329,6 +329,8 @@ struct amdgpu_vcn_inst {
 	struct mutex		vcn1_jpeg1_workaround;
 	int (*pause_dpg_mode)(struct amdgpu_vcn_inst *vinst,
 			      struct dpg_pause_state *new_state);
+	int (*set_pg_state)(struct amdgpu_vcn_inst *vinst,
+			    enum amd_powergating_state state);
 	bool using_unified_queue;
 };
 
-- 
2.48.1

