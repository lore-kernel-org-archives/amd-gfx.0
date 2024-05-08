Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CE5C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96AC0113123;
	Wed,  8 May 2024 17:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jkkbmcBm";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC29E10FCF2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:18:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpzL/t/+3lKD1nKPZ/xXVrek0/kY8pZuD4sF4iiQMQVYyD5Ln1T/Q/0O7h8Y7l/kDIpN76xx29SqkwR9Mm4hQgqFJLtxNuFeoclmYw38evw+i9OSJ+V4A+YnCvkXP9Flb9id7pRaDaTCsnw9UmqhmZFuIJqiz705gUkOKg9Ap9E8d7lkTl/u/PGjLQ6oarydywxDj6Ozsh6UaSqr2abvOB5FCy2G+Kr6e5khEr/r056HiFa2hktbcCxOHEUXHLALI8rMzIcAxZY7kZ41SWMqRyyF8gprdADzGf/e0xlI1qrNcJu/Db+Bninda3jkQCdQQpDupu72wXC+mxr/iGPhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AIrjuq8A7Bt0R1Hmb9+82G1yRDZplmlo4zPlKB6QmU=;
 b=f8alS4SnAfDLFODc35l7XIAIHxBYP1KgtgQrpDzAaix2V6YwKp26FKm7DAROZmY8+ULCmataU5PbBFZ66WWPZj4vJV5qjGy/LruNTrUxzSp2YzbIqF18IDPxZjpX3pNoKLyftE2Tmbg+Nq0Q1h1AckjT5uxiQ5Y7UaE/P7hmz2mVtLANzVzkBnbBrX+RDf0SVZScaZ6SxbH+WEguCeHOQeW2I2drqIw7VSME9M0RVAKjj7oQ1sMxWY9iWfPwYPQUTzYsvjjmlBLruGvXgpxQ9104h+hio4T6n7UOcAtuc+x976kTq9uBGLX1YMqJR47UPfifUQeLBLmVMXgkgJF+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AIrjuq8A7Bt0R1Hmb9+82G1yRDZplmlo4zPlKB6QmU=;
 b=jkkbmcBmzQFfRcWgrR+fmt3FRqJUWnp536gJnSqEGyZQGdgFPQgSo2iNariyw1D4/Uae4w8BbR/ibkwg9qCRC0E9kyFf+Trg0QeZNgxwkFQnmGpZT23bYo4PAfhND3oVCwlyxF7ChTP2GuBqMzSOd+9RxSKen2qMJMebiI9WhIY=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 17:18:14 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::dd) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Wed, 8 May 2024 17:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.0 via Frontend Transport; Wed, 8 May 2024 17:18:14 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:18:07 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 Chris Park <chris.park@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 14/20] drm/amd/display: Don't offload flip if not only address
 update
Date: Wed, 8 May 2024 11:13:14 -0600
Message-ID: <20240508171320.3292065-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM6PR12MB4185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4e4e6c-0d46-4029-7f57-08dc6f82d82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xrmxaOZiXt9FZGj2CEosPd2CNaBJe4SRRo2OsvhhAQoBtM4+jaohiKVkUWVq?=
 =?us-ascii?Q?06vlzJhYyJ2w8Ir3LOLsPhKBW5ylPPE/ew7zFWCCxsB0urxoVSp7krZGibJZ?=
 =?us-ascii?Q?9bTYZjPawihZpYUV0Ro1UN3cotjA4O/XTpEXQgEH7Kw+ji5nGyzIbKLaeUNR?=
 =?us-ascii?Q?Oo3oGOzwmVz1afsrpoBFxEPwByKhdkswnd57N0GHePyJgu5T2yg7MXnflUPQ?=
 =?us-ascii?Q?wQtxbd+c2uqjTxYn11vBqFHH+4x5wC8ILlWFRBUNZbXYju/Dv6abmLvU5GYz?=
 =?us-ascii?Q?Qe77EWQgEcpjgftP07fiVbRkK22X1XrmOS7/6Cec1vE61BBfh2/Yr4lsDUNN?=
 =?us-ascii?Q?hja5rnUg+n0NYH4m5CETBcH2B3uOzvpBQxmu7c/FcdNe4KxkwE3sM5gczDhr?=
 =?us-ascii?Q?mBEyCcYvEeAzgwLiqwBwaYOBkQIXo+3gcsomim1LDbiNgLQuJH33+5YrEJnS?=
 =?us-ascii?Q?0gsY/py7Y9OrABWd1/vjaMISKhz62ZVHNVEROH/n62aDSX9fofZrOCrt+m+t?=
 =?us-ascii?Q?gaZ9TfnvuWnJnyWaYSumUuNWhWW310Hg0n9xvS5RPd1BrzPhpPy8Y14bTQRI?=
 =?us-ascii?Q?SVOA6TSQK1ZD+IlYg6Yo/o/OKBX8qjCG58/a1ZTq+sF4vG41p5mKN6IMH+a/?=
 =?us-ascii?Q?GbFg0Rf5y4oyAyFzCN/pGvNbiOdn8OJKyUKE1M/F6gGSwmJvRFjXEHOt0qx/?=
 =?us-ascii?Q?XhZnQ67Nw+e9MBJpxRutMRnxA/+FjH7s31JgAIwkGUgCVsJKxmzt1ur6HONF?=
 =?us-ascii?Q?buYXkb3/BXgXHNY7RKDlMCEpBz6F+pwV+qbRJ+GL/3pT3hDFpzRDbXlF6feH?=
 =?us-ascii?Q?jFT8RxYX/MCekq8BO/9V/lND6OAH51j+rb66FoEFqegEUFEKS6/gkaqcvuR6?=
 =?us-ascii?Q?S+a+qGfugazBrVw/gx4TLKz0PlL83T2tD95lgeXcUbNUE1iDV93R5hcLz6Hw?=
 =?us-ascii?Q?yazYZP/tokvgPumpuWTguULzUng52d1AzEP3BrSJIyvKcOihpW3a7wEYF6wp?=
 =?us-ascii?Q?QFPAc3Do1DNE+WWBcr2DxZkTfSqjqb1shZC1Sj659krn3XmZZdSA0xZL+rrH?=
 =?us-ascii?Q?gz+UULxZSdSzRCg0098/HmQ2mqx2S4Oh4M2KjLv8ZaXHB6pU7cPrvNEZYWjx?=
 =?us-ascii?Q?qdD76VtIgLyzsX7l1CR7AzC5jDcO9OTsvqDPoVjkWZ9m+aB4Y8IsWz9bFaY1?=
 =?us-ascii?Q?rjIrV+FC06r0OCd6OwV4ueCPEN+duC7jcnO2CxqSIXoOqPSx+OtEXuuaNRt5?=
 =?us-ascii?Q?CrbVDPb/3KDJiq8CCaDmLskN0NDzV64Cih0crKHaUjSwsyKYBTHy33LpIPkb?=
 =?us-ascii?Q?aRXqiqcAykOYtxnc5ix6BD7dpv5zYwv5zgx24Qn2LvPL5PTSx/LvYadORVsj?=
 =?us-ascii?Q?mMhxosZDyNz69Y1hR0xKMMynLMMa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:18:14.2616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4e4e6c-0d46-4029-7f57-08dc6f82d82b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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

From: Alvin Lee <alvin.lee2@amd.com>

[WHAT & HOW]
Fast updates can consist of some stream updates as well (i.e., out_csc).
In these cases we should not offload the flip to FW as we can only
offload address only updates to FW.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0f20a3d96d93..0208b28517ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3664,6 +3664,10 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 				break;
 			}
 		}
+		if (stream_update) {
+			/* more than address update, need to acquire FAMS2 lock */
+			should_offload_fams2_flip = false;
+		}
 	}
 
 	dc_exit_ips_for_hw_access(dc);
-- 
2.34.1

