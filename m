Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4930C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 15:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91F4310E2C5;
	Mon, 19 Aug 2024 15:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TvAg6ODS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2209510E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 15:24:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgW9CG2UPsdxAxqu2gagQUBV1S6Bt6Fd2dISyIG1DwRHNkBdgFm+pdK8v/tExuNOgkvU1s3Vcny2cW7A5/ko3jkPnhqT8lFuHX8kkHEOZbP/ol9gIFeDpCpRKHYnqpKQRq5ixwL5J2U/f9hbv5LjSI6CZBSCUzMF1GqWtc8WJJXZToRsSHRRcXVhlEN8NdZDiJ+KvOSc9wRYqJDE6IiMgOPpD94v3U20LtAIKQ7QYoHbzag1qR3XKNufCBvORJJo88mOL5R3m5XsvSfa7QDIqxBujgZSQYyju4HdWgcUekU6/8YFLTqCyZSona1vkH/z9zUB+gIn4M2l91ROmZ7ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhK4JClztw5pkQFU0VRHQr5VBLYqKORPiultUafCq94=;
 b=A+p3N3OT/ekTLMjACa5LlbUucdKFpulUEApK/rWZo8feYGuxqKytk2vggUpD0gIpDyZykufpeOoT5N53hRQwLs3XBedno9t433E0am6IIyMvMV5r1VIb1DmiEWI3DbmpJoDMXlWL7UO643sXBWCiCqaWEYYsmzVOanW5yj/ldkj2tBYnZpbXZGOS6DxyRZXfdcJncoo0q3W80fGGBvvmZEIkpWm968KxQzg9+vvjq14v1FRUoUgAoYZ6tiB7xuo8vbbjUz03GLyMGmF9OesT3cTxzoxzUBALl+RSKJ+FKgfn1TF/5+5vURLIj9Sp5UYI8cRQJ4SoWwkWWxuCGuSH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhK4JClztw5pkQFU0VRHQr5VBLYqKORPiultUafCq94=;
 b=TvAg6ODSTthh6DiWd1l2DqqQpE9va09DlimrdsRcJC9maHTLPgEQ9wGU/sJmXe+1/OOhxz/GMrH/IPBnKBubabzDUcsncu1LzNPWv3myrTaAUo3Pn+Y8XueXCYn5GZoS0rIQo6WWXZYjZ2P/ONJG71pCedQUHacKZID2IDcZcWo=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:24:09 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::75) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13 via Frontend
 Transport; Mon, 19 Aug 2024 15:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 15:24:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 10:24:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu: fix eGPU hotplug regression
Date: Mon, 19 Aug 2024 11:23:53 -0400
Message-ID: <20240819152353.233303-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: d981b307-9c35-40d7-df54-08dcc062f8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LANpvQVj/QZBN1gntYAgJ6LX5DTBEyiJk9yjHg5yFHGCdCDHlxvDyw0zf334?=
 =?us-ascii?Q?kBdfTbe1y0P+RT4OwiRlKz5qP9ll59DLn5GG51p5kDmXmNUtr9c/SY9HUa+n?=
 =?us-ascii?Q?4mSO2qg1WS7DGwVrSE6DnTIU3jbde2TDntH4lylRhcTo6J3phwbqMIw+mceA?=
 =?us-ascii?Q?+pXErYsbjy55ovZGchJUfdrKKH8kSuEtO+sq341hgEmvVihPy3u2SDl0DuXM?=
 =?us-ascii?Q?W58UBjdbWdQBDLNvfTtVBCwZ8jrx15yF9C2u5W4HL6bX8CGWz42UUfOTs1fi?=
 =?us-ascii?Q?iml8WX/flWEKD9V1sVFKMWVn7JYeu66LM4DgsCVfDjx9V/CfD67/B1TJ26jr?=
 =?us-ascii?Q?r902z6TzBNiS/VOLOuaSnAgNe8zBubz0eMVScgHD6OvAgRAdZo/opQYU9G0c?=
 =?us-ascii?Q?l0WWALrze8eEg8jpwjCRHHb462vjj7qG4Lt1oDZYzSYSW/uceYw7DGOqrgtL?=
 =?us-ascii?Q?l0BzVLrcOOpN9MycFgPN750capXpKiOGWHde4QLfefnIpQIB9b5E9LkSwzzD?=
 =?us-ascii?Q?YIJqn+Z+39bJAnJAKRYfoeylO4jlb5sSh3tAMjBtpLSH9cXX3Q/fNsjk9zPx?=
 =?us-ascii?Q?XVagV/BuvjJuCI29f7EJyAiXn+YH+o2zABvSnKYNE7McGI+W3NPsQ+ajUqc1?=
 =?us-ascii?Q?QGOBMxQRu/mJzIou4et7TN1G4MP92EMtuV+A1CsgWOEP/p9mmJO00S+efohk?=
 =?us-ascii?Q?HmKRFPv97jci0D9CMd1jEbu/9ZaELj/lhmcbKxghN52k+vjZuHA9uJtruvil?=
 =?us-ascii?Q?/uvsAL62d6ZLu0FDQMQmPqWoblmV0ckJkddCEQjfgy6MAntLkE7TJLbJcdeE?=
 =?us-ascii?Q?yDDXfPwUqYpxIC3t2s9CaEBLEOFNZ0M+N5NCSc+YRqoGTKuvlVZk7Cqf+N4k?=
 =?us-ascii?Q?Ov89BLBfb7/QlakWGB7hnDCVCYAY+0BOPkbbs8X41Bd5a6HL+1PNvnmsJkaD?=
 =?us-ascii?Q?5F8yJ6UFaX9dNAKR9qeYgNMab6c0fzDDjTt690rX0d4qZGpAka96UQ9Hm52o?=
 =?us-ascii?Q?L6lX4cdDuMMyUPms+kSqlaXwSBwto8zssDtSZgl4huZyJIQp03la/b38zPkb?=
 =?us-ascii?Q?lki9Q1Mz6QYX1rxgdkDKiXYBMAyJFMYlqYEJfkbxzYF57N5Kjq88fnjkXB8k?=
 =?us-ascii?Q?5h8LY/FcaoyQNh82FuI7oL/kVQ06prFt85pB8y4m4KVGmEIal3KNPOI4Z4PY?=
 =?us-ascii?Q?nVzjGAU2maJAr6905vzVcTMeh1jvwgEaMppDm5yEINO5uRPYuZa/U6nzIysp?=
 =?us-ascii?Q?uh2wYPtbniTTo2yLXy9jDDVZijroJXANJ4aEI88LVLYdQIT6VRTGCyYlcGb5?=
 =?us-ascii?Q?PjFfpl2y5CipegQT9xZcfEbw6bssMHVNng8KXCf5jryCkQX+dZS+8Bc3xcnt?=
 =?us-ascii?Q?tuS+RVmaBf1F1U87OFKn+vIYXvipy+IFfCPW4SHGg97a2LQsrg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:24:09.0695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d981b307-9c35-40d7-df54-08dcc062f8b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

The driver needs to wait for the on board firmware
to finish its initialization before probing the card.
Commit 959056982a9b ("drm/amdgpu: Fix discovery initialization failure during pci rescan")
switched from using msleep() to using usleep_range() which
seems to have caused init failures on some navi1x boards. Switch
back to msleep().

Fixes: 959056982a9b ("drm/amdgpu: Fix discovery initialization failure during pci rescan")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3559
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3500
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index ac108fca64fe6..7b561e8e3cafc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -278,7 +278,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
 				break;
-			usleep_range(1000, 1100);
+			msleep(1);
 		}
 	}
 
-- 
2.46.0

