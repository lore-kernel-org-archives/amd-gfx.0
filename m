Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E411DC4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 06:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E45A112156;
	Mon,  6 May 2024 06:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MrycWXj+";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3DC112156
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 06:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5NxZbFrWNByPFigQlWPgLmyuqprlw5O44z73K+dYMbQM/Hws8XD5Zzk6YcyZE0SXxz2jE1cq1C2oMLY9aX6Q0YxJfWDX5TEvtKhBC5IJ1+Loj8qF9W7Oj5WgUrXMm2bxn9xzDi1BnA4ak8yqX2ty0kl41Xni7sd9gieaa0+k7sAQLdQi/IR5lrkrvnydB3r8K4rBRKAVflqxfR2k01BtQmbDsNEBN1irCvUMHCKX710XwRt57HtAbeki08kLLRqIYQ822GZY8nU8Nx1JVf5zfExzYccvkHJuNtVSu5kKHDs/YJ+8XXKD1yXoeafBcw/GuItzn6DO/quD2E91xzYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbaQ4Zokuc62KkrBe3Ih7grNf3j9Oerw98vfe+8+VXg=;
 b=cLbxop70tDSe5i/oPwh4tHOjvu0Ysehdpo++3+SUPCaAP7r4OgDaIWuFQKLPEtpS0uDVEhkCh0nkYJfeMoWfZat+goZwOJD2BKdh8WybihJUXIRIzG90H72qOdx9MgOWVJOI+HxQlSmEbLFPH05A9C22cOXhypfN1QLO3gRTnVL6xJ3oRIf+spwZ5SaPH20ebPPeBxwhqD5PjlB/rPtsYm6Z843pxe/5QawTXYrlvHBFi+f65g+X8CVsySjkIY1IULhDpJ8JXYbRKndy7embn8ElrvyU3QTJzAQ89aOd7BA+5bOHWJE20hUQPK1wYN+67c3vXHFYy9Wl2jRbZYzQ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbaQ4Zokuc62KkrBe3Ih7grNf3j9Oerw98vfe+8+VXg=;
 b=MrycWXj+we5NIE+mo2jDMkmzBpWIOJTIbWMIxGngJQnIlMIF2ZRhyafhit0bGgXvDF2En4tTZs4y+VohH7xhYOoMsBgkRdTJyEdYXB6KIo1nOhs2JW4xIQ+3LS5yS7JS7dy0uoah6lHupaJKYFcJZgY21qDJAdHxP50zE22VIBI=
Received: from PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::32)
 by CY8PR12MB7681.namprd12.prod.outlook.com (2603:10b6:930:84::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 6 May
 2024 06:12:53 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::6d) by PH7P220CA0115.outlook.office365.com
 (2603:10b6:510:32d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 06:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 06:12:52 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 01:12:50 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Tim Huang
 <Tim.Huang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: fix uninitialized variable warning for
 amdgpu_xgmi
Date: Mon, 6 May 2024 14:12:06 +0800
Message-ID: <20240506061207.2017901-2-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506061207.2017901-1-Tim.Huang@amd.com>
References: <20240506061207.2017901-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CY8PR12MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: cb48bf86-bae6-4ab2-a8de-08dc6d93905f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bajwngwM4RLvmuQtGbbJmIzbzTkcZ2k2Qjk2wTb6MogM5HlW03fdS34MxqRy?=
 =?us-ascii?Q?Wl8vPTdeH8kBGVNL7G4TQklg7ZzDlN26kPofO8szN3FDrUVHrkSQ7FsEh7cc?=
 =?us-ascii?Q?ZWvUffgt61N3qieXAA0330FRsAFSk9X/LK56ZnhVic1pfk4g5Hhz+wmknc5O?=
 =?us-ascii?Q?bUJf6HgQ+EtVBPWXDvuI00unocPjNnA8u118LsmVApjqYdVm7Bk/StxjhFFk?=
 =?us-ascii?Q?r42smMFdxdLyDuVaDh/AmVzOJDlvC2iyaB5z8ulleRPsZ9BUme6Dzh/dUoLC?=
 =?us-ascii?Q?7sIX2aR+mOF0ebW2cwe29Au/KrpOrBnh4cZRj5xfBurNlkpIH9YDStIr+qdL?=
 =?us-ascii?Q?O83G/mgx0U5BnKaO0wRohyEN9HBL5TbqH/HU5dsSEVS1Wt9iA73enwnR+eel?=
 =?us-ascii?Q?8Vf8+xRK28ihKVoGYRslkI8neWNfSHKJTcbxqmgzXkaOx13Puy9RZ40Bk+BW?=
 =?us-ascii?Q?oZD+2/zhq7s6e9wnUi8fFaI2soA1ojcXSi+Hfdax/cEUDcvDY7U0KVSHn2fV?=
 =?us-ascii?Q?MGwpDeE582eZ54kJ1tvq1Xzh0hwZQh/R3L0+m3Bqzwk2dUPrL25xu1/B269p?=
 =?us-ascii?Q?4sieUUnkO7tA6kcTsxDo4cECit31PSM2UL1+9BU4mOZjxL4vuflg8C8k683j?=
 =?us-ascii?Q?NVhmO6vyxh4zwqPoxzp4Um2zk4+82HoXr6Mtjou2gtj8sqcUjz9EuuHspuzu?=
 =?us-ascii?Q?z6K7sQdJl0ckZ9JOzoLPnj1NoG3BjLdPUOIG79+rZ3eFCF1mp3E3hoza85b+?=
 =?us-ascii?Q?nqkqXMMsD5nJhobqdcRjOTKYCdln3QzRIw6ldCaWioMTyPHdqyxYu57WI1NS?=
 =?us-ascii?Q?uTkgULL92GUsVULWOLSaw+LPWtf9cdpcwf0el44jsHONynGF2Wvym95yLYas?=
 =?us-ascii?Q?mXJ+Hgtg75qU1H2mCi1F3o4nLEpcg+2pOONupBJGNASur/VFrnQpdx/FOy4o?=
 =?us-ascii?Q?IRMxIbj3NbQyAvlH6hjHiAsm5ieiWvzvpTal98CN/dNbJbs/95wLdv1iegEi?=
 =?us-ascii?Q?XAoRZgPgD+YL1ByDWYrZns3tU3zQWzPwgFvr4jm2zpCHqiCr8MFNBxgo91EZ?=
 =?us-ascii?Q?hEKF7xWnKwEj4+EiGGagKKU3eRzub7H7pyGW0HDIbPmGDGi90mtdinFQ5a7d?=
 =?us-ascii?Q?qh8M3sirk4yTAN168SnIJHFgVza4TAilvXlfazIj/v2T7gm5gtUCSNI7XQcB?=
 =?us-ascii?Q?YEHXPTbsIeEoyeZ2tgJ3LWezhL4ZmwXIIOoB9bpYuQbuyORzsNjq1dJ2m0oR?=
 =?us-ascii?Q?UqKFeu97QJAtprjkBnZCbBy6WjKXrm/+bQOivwEv9+E3I9+fRzYRyD7jw0+f?=
 =?us-ascii?Q?XBW1T8z/U9XqXOZAzzHE54glTsyuG7XC51ESbLp3+AeRg4YierZxHk/8J6IF?=
 =?us-ascii?Q?U8EXMEbpd5IA3dP6AKcLljIo1okS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 06:12:52.8482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb48bf86-bae6-4ab2-a8de-08dc6d93905f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7681
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

Clear warning that using uninitialized variable current_node.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index dd2ec48cf5c2..4a14f9c1bfe8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -434,6 +434,9 @@ static ssize_t amdgpu_xgmi_show_connected_port_num(struct device *dev,
 		}
 	}
 
+	if (i == top->num_nodes)
+		return -EINVAL;
+
 	for (i = 0; i < top->num_nodes; i++) {
 		for (j = 0; j < top->nodes[i].num_links; j++)
 			/* node id in sysfs starts from 1 rather than 0 so +1 here */
-- 
2.39.2

