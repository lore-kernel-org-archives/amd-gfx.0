Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A676ED65C42
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 05:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266DE10E03F;
	Thu, 14 Nov 2024 05:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LuL5+LEv";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5215E10E03F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 05:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tty+6wmYTcMCUv9s4l7vOmCrbehg2yowxfrCzG3/TCsTgkssHiLRnHX13Rac/NjofDuXGb8ABMLtUsy6MSi+LbtsVbgpbR73hRI/YetQFoIvhs+FfWsZRTnzShikhUVzBEu3JodQHmYm74C5/8EXXTk8+k8UnjceiLxRhpJgfc5Y/Wi8KWDK4GcF354BQ+xPStQg1jeQF6JPbm04WtzRyexLcum5rpmgCzTbJWnOhboCUmmC+G02oBU1IQz9XCrJIGjd4SEmqs+wDoRL4vESkvfKcNrIzuyHGd3un4buErfTQ/jckKb285utr5A5EOg1BW2UmV9IhTKHuaVdkjhIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=HITF30TKh4C3dpqhnonxbL5ddRgptjLO3VaSbFFCI+f1cftihHqACZCoKG2BT2+GtJ1vS3lM7sQj/ooBBU6c8kYAps93qi0KBgMVB9P2ZS4ldeolm+MxG/FS4LA5NmSeQm2jlrONaApDGkX3V57UKt5pJ13zLJbjF1E6MdbJTfjwHr1WXaFVV7XX0bY0vigYknZZrRsZjz92xHWjn5gTBSnsa333ZWNIpAaIborw9S3GuTVwf7Zwaw+531GcwRoxB9Pjkz5lG85CJsoSb8dL3s783NSWSMKg6UklYLvWu9HsxPv9BRCy4+osfXL8RDVQBL5jTANsFY5cZI4Ap9IIGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYVfP+9TuOPgDl+HnxOspMnTF2exHbMQ+L9VvhVnPcw=;
 b=LuL5+LEvcqfEWkeeTpNJhAW1JvlW1onUp1qHTHOT8yS13EJmKzd6sGuQI/Gs9UFE89EpoOyBJcGOxggGssMc5OMoD3VOwtPQTV4UlbGDIyJHdgWfwLdgNhaeOwQuchVEME1wgewOrDBiWEA1vpLyME7xwotyZPtx5ndTk+NJrzc=
Received: from SJ0PR13CA0091.namprd13.prod.outlook.com (2603:10b6:a03:2c5::6)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Thu, 14 Nov
 2024 05:49:43 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::3e) by SJ0PR13CA0091.outlook.office365.com
 (2603:10b6:a03:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 05:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 05:49:42 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 23:49:40 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2] drm/amdgpu: Add NULL ptr check for non userq fences
Date: Thu, 14 Nov 2024 11:19:17 +0530
Message-ID: <20241114054917.129992-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 214564e5-a3a7-4e84-bc4d-08dd04702338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LkgkWMyccN3FmCblBVc4YUQGZctR6Lfi5FCyFoPmEi8sk1oB9plyVEUwR20h?=
 =?us-ascii?Q?iqw09IUagCcwI0WAluDVlbGHKSnVUjEFGo3X4Rf5DsJbw5aaXrHFf0SS452t?=
 =?us-ascii?Q?2zyTIsWsHLARfF2NBrV4ml44aUKh/Q8SD3OQ83kBdrXexz7+Kfu6oUOx8LUU?=
 =?us-ascii?Q?MG4Aq0oURAAQ+czqa99ZXTBOZR8Q8sgz0jKusqwIkGUL89Bx+Ve2tzzmgk9V?=
 =?us-ascii?Q?2x5rz5u6gg0cm9e4DbdyUbACinkjY6NoM7ucZ2JsmOCvCia3HXZVFpHLjR9F?=
 =?us-ascii?Q?07xGEl27Aa/idsNHOHCoYa/2kD9WjWol846pJUVxAc3bOsDvWGrwVJl+SnqQ?=
 =?us-ascii?Q?l3QyvoebnPKqXqa2wCRIujoo1k79ggAGb80Abo9XOcyJ3nqfFMWLpCe2RLvj?=
 =?us-ascii?Q?NhmNSxaWqe90NBsAmql9cabpJBbUanT8KnjEZLH4TRKPD/2LKX7Jd+B/qiIb?=
 =?us-ascii?Q?+ulc/rqeYEID/3wVPGY4/DaaD6WPPH/fnvPxtA3Z5wZVBwmfyOg6KatmezKQ?=
 =?us-ascii?Q?zfP77uy4q1d9/BMsM46qGtwAUiz1abfWZOENhzlROCvZUqN69JjMFSm4sd5V?=
 =?us-ascii?Q?/br6Wt8tFVfNXgYwumN9buHghMofAaHNAxZt6UVGqdBua+szpH8Zw2kdE0nm?=
 =?us-ascii?Q?RJIaZn/wQPxPtQbRGRY9LuPfDFVA+saDrINhZcOSCuODNyZFWxlNgXOX3UDH?=
 =?us-ascii?Q?wnNqnuwCCW8Jlq2eNNbDEqy/k4NSA0beLFhYgRkONXoT7gGpG0pOsucQYt37?=
 =?us-ascii?Q?YK6cZefHidOL9Mh1avxb6Y0sTSm2H0HkAU7KnsmuUzKlsFpmH/3BxuXRUYdn?=
 =?us-ascii?Q?npkXpbxeHorwDZVQg7A6GS8hDDGKR2iUvvsKeImfYH6vqKYVBety6kIbioi7?=
 =?us-ascii?Q?z46RVMSbuBNdb6fJFV7jxQQ1lblqCGu1cLO7iSIiffTExN3BZwweXGfPK+4J?=
 =?us-ascii?Q?0VJefJaBCqlxwjNtmA46RHU1//rIJO/BJevd2Q+kSgkABz9Q7QW4tBcXqVc8?=
 =?us-ascii?Q?gsmx98iN4vXk55QCeY2e9t26SM+aGury9n1/39toDmm5dFV/wZSa2Ccrymiv?=
 =?us-ascii?Q?zVAoJ3Ry37O3a6L5nItkhdImty1Z2hWcb4KkXqZXGM1zsQ6YMCc5H1yq8vTn?=
 =?us-ascii?Q?uOffeGkyKESCQtxnhWP/b9IV/WAMHd80L3iJpOgQ5ipm5OMO/CF5Lg9lKNVi?=
 =?us-ascii?Q?uM/qcUkvQ0SVIsZgKJwPEuV78psV3Dfd0zVGvBwL0bDbvWZ5LMRFJd6ShMWC?=
 =?us-ascii?Q?zUrUQNYBjT4Y+S62fowFWmxnPnKA3BxHwitjCXpFgNGcYCcRUU3P5Cugg8hM?=
 =?us-ascii?Q?2GpUbWe+ObK9pNgDb3vPWczsfOwckiz2zCsqDiJVb/L77qinZqGkoMQQTMou?=
 =?us-ascii?Q?PcsdThL5FjoHJSNtadnyNJSynkyne28yafdCsnPbM9j1Jb2k+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 05:49:42.8528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214564e5-a3a7-4e84-bc4d-08dd04702338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124
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

We are observing a NULL value in the non userq fences,
thus added a NULL pointer check just to avoid the
NULL pointer dereference crash.

v2: Moved the NULL check above the non userq check.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 6157a540c929..76f7babd7a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -815,6 +815,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			struct amdgpu_userq_fence *userq_fence;
 			u32 index;
 
+			if (!fences[i])
+				continue;
+
 			userq_fence = to_amdgpu_userq_fence(fences[i]);
 			if (!userq_fence) {
 				/*
-- 
2.25.1

