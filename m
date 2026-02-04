Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69538E8B393
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 03:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E5A10E5FD;
	Wed,  4 Feb 2026 03:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KsAer3pK";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D301A10E5FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 03:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhAS73oohtSJbXFDffPQtlAhKjmGyDqo0MiCpkxje7zGTgca3zPlvGY3w95uFosY7CJot/+8L0Br/iUDxlmSnkD1fsqga5Lrr84Gj0qHpZhelhbs0TD4Oz8e1Z5/Bwu6HDXlg0G9Tap/BA2FhXCbAnVIjtqy8jof9DqCuqmc+7EJRMIBcLW63AUbbi/vCvXW1m7b+PvAZ9ymaAko9JVkPnf7W8+ZYYYy75/Iafr50GTvE337/u8h2EVQUrCfRUQpbbfhQ0euOWfhF7FNivKGdkKmjDHy0mekaaHHbooIc4kurcGnN+nhf3idjqPRBAN1aav87pwNXzF73e4PU1DNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsy7fSXJbPqY7VKW3LAzmpErp7uRvvrnD9ePRw4w09c=;
 b=M48GsIG+NCgV+ImOhkS5qKwnuf0T46p2ZRccOTddliGSfa36a8CD+Gk4dQoOfYu3NPRtYFWC9o6BPNnniEzJ6zg9zTgZiDFXhaGy5tmP5diJ76QgUZGT1+qz12ZKfCI3HTDOe+SmVigL7ckmt85JDJw9BQiQUZyzlhYFWIFzch/PNpKWRrNLDIu6SBkCp21McOS2frnD8t+yYGOHX7N580ORsRCC4RTO2WTQ0Cbn4N51z8WsW6BfNllKD5vaP5oAIAa+Hvl5S2AkgokyRqRVkx5zAzDhaeDQWjYSR5lkSMKhvh7McmzqfF4FvlLv1B4Bp9P72OurwMTx2W0uGHO6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsy7fSXJbPqY7VKW3LAzmpErp7uRvvrnD9ePRw4w09c=;
 b=KsAer3pKKf+q1LnAvg+QkZoENQmaKM8NXunMLDiL47IyBRSj7v58LJ8Rxd4KE4Q6/a9SFUXMS2ZhcsBiwo4TzbjVUUV0B0pMmIIkgBWJ+RvgY4PiwKra4zvtKtVg9tBCh65es22GJhMU9X9I69vqCMxdL0RENinj18bVU4IgQoY=
Received: from CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9a1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 03:07:02 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::ca) by CH2PR17CA0018.outlook.office365.com
 (2603:10b6:610:53::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Wed,
 4 Feb 2026 03:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 03:07:02 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 21:07:00 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, "Kanala Ramalingeswara
 Reddy" <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH 11/13] drm/amdgpu: enable mode2 reset for SMU IP v15.0.0
Date: Wed, 4 Feb 2026 03:06:18 +0000
Message-ID: <20260204030621.33369-11-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb2629b-1929-4165-e9f4-08de639a77f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n3k719llgzSOUwkrMTH0oamE4NNYNKKk1/iFKRBf77jXk9UTJodv+rSdxYGA?=
 =?us-ascii?Q?FXP+u5sHD+6Evi7EHStGHWDb0ihRt1Ehve9tgFUWaVhkxfqZoIW/mXWXyhEr?=
 =?us-ascii?Q?VlmICcYDjdG1nk14rAXoXyl3LIusInxmc0x8E1ff431/XKEjXVqM9D8pDR2p?=
 =?us-ascii?Q?+CNQ9abTPBGydtwPIHXabs+4MEMtQX4L/mKkhNRUGAqMgr193ZwipKQzM//b?=
 =?us-ascii?Q?eC2t31YQ+OUqB8LHw9IQHHfXw1DDGmMUuzTl6eIxAW3TJ9Kx3kjbpPPHs+UY?=
 =?us-ascii?Q?8bFHXtZTM2LtSzKCiix5x0HFiyXMmHbntzMy9FQ+wHyLHvDnZcbNRjgchH/R?=
 =?us-ascii?Q?osiTANmEbglINI6VefPv54rUSmUw+iRu+8cs4VXcEH1z4j3wh+0RohLMztab?=
 =?us-ascii?Q?ItOSsP6LWrVCBtxrqUkL3Mvs2LHbuheX+kkFqAv2QM1I7ihi6PjyTue5VuYd?=
 =?us-ascii?Q?md9jh6Bor7lvydzROZU6CleXLF9xITv+a47o+q6AHImIfvUVQyqp1QYmgoCR?=
 =?us-ascii?Q?OBx1mILZ1ngiovOnmq0xajEGHWmQT3QoQdCGkt4l3Cu0Ujmt9tYCcl+H8O+m?=
 =?us-ascii?Q?eSRP440zdjssdNlmEOYyiYoNoMrL6ZVZp5BYtKDTBe49AZYBVcJosonYDm4j?=
 =?us-ascii?Q?H8sut4Q6s7p/nquXUH2sCO/gLuRNpT+LNjV/uljM3ZLb/Jm1iENTQDzOqASY?=
 =?us-ascii?Q?gPRtj7t+hP6qKxZ9Oe3wxTwfUl+ziMimUJkrVQKxzxb1eASxfIYv7pg8p6Qs?=
 =?us-ascii?Q?empC+Ibv3SDkPmnu+r0Bdm/Stv1aHbQ/E1lBk81YVOTjR1FjEJ2svw7G2NzD?=
 =?us-ascii?Q?X9QGAkXgv95UXKaSdcKv1F+Y6AdG7CnkkopyO6heKDZlnM4rqMB8QnK2/XZa?=
 =?us-ascii?Q?FIXVAaoN5ICmjYw+jiVgCOMAgvn80KyJMUxWyzHtYpXrq3NeIqY8xd0pPBRT?=
 =?us-ascii?Q?SvF0qBKR+WlARL/AmI0kBk3CcGWVrQqeuSzmuBR8MQKs1LnLlEhklgA/jeNN?=
 =?us-ascii?Q?qpjcDq5qjPoNZHUWOUocrJ6zXa3AWxH0rJPCZ5HCXj5FtxfY7rmWe18UYWQq?=
 =?us-ascii?Q?jFB84v/iPBYvPG4f3Rllu0YvyRlLx8kUdsv8rM7cRrquY5BGXRMX56hI2jia?=
 =?us-ascii?Q?sXYVrMYt/yFpwQ1+Ue458f4FlRk0QfdtZW/QR5yKKPHrnDBbqA248/PrViY6?=
 =?us-ascii?Q?S3Xn1z8ULKYYFqlDAcoMzVKZRJyVmbrJpI4QFlD/TKdS63jkNLNGtzxMGvov?=
 =?us-ascii?Q?51Aacv3ipsWA5pjw2G0GBSGafXvs+4PYFl/ltpj9VL1CuORXlMn0q6nvCpPB?=
 =?us-ascii?Q?E5TzyVizBXzclKPi+ZHxokKih9oiFFGo6BYQmSG4xMxSvnVTRa4molJZA3GP?=
 =?us-ascii?Q?9AneSHj4IK402azqQWt6MiwKoOXK73ILHB15rBXNQsjp4xXbDsw2Dny5cxUC?=
 =?us-ascii?Q?aM1/Vo5rqNL/f/a0QtxrkJ/ufti/6G5d3COyID+N9+nTdoQsK80IKXmFKZJx?=
 =?us-ascii?Q?GyR+e2oorg+RSI0rz5MbOkpqcQRSdnqXkpGKgXotZRKx3/w7pLazkMHaoTSB?=
 =?us-ascii?Q?hStTo22r62cUvKoPzAgxi+9G4nUUxvfHElSVThsCDSBvr3yTDEHqulOeLHOe?=
 =?us-ascii?Q?diHDM4mf69bXBlMSu79mPf8Hh7HcGw7k5fQub7T2zxecrw65AuuJREjrxI0T?=
 =?us-ascii?Q?3gNrKA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: C+etrw70Z9B9ZZVHK/nJga5Zc4abIZGMA3YBDM7jNSt7/pE3o4vR6qAvqTxeeMPMft/1Kj8p0CckawOwLQDR3FVyiNX35LEoO003Pb62dvzGrpIfp7KqB0sJyTp4/k1XFJl/ACFOt2uFXXqQlj8Zdv1/pX09oF84Qhze4SKnTaSTRv/ELf68JguUIhazj3kZJh+cPLa2rRdpynlVJ6aoOXPHWOQHw2FCH7LspSnB4bku+x1XIZ7GJVIRxLOIJqSPJVvvIjZjlRpZqjc8xhImqIRcS0DZzJDWLtslhjvtfAim0ZiTICzszUZnOnRjMNgb0846iM2XW1peEnTVqIlKBoACB3iQ3Zi8Ut3vok1txKwxjIXaLvMdnaZXq9JABq9e/9U57VMDFl26x0c3yEO3bVLT20kNMw00CVeZhjZb8Qe8eBAGyNzyxSwYDcuxbAKK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:07:02.1121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb2629b-1929-4165-e9f4-08de639a77f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5
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

Set the default reset method to mode2 for SMU 15.0.0.

Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index d9cc649d81ad..79d132fc8ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -422,6 +422,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 	case IP_VERSION(14, 0, 4):
 	case IP_VERSION(14, 0, 5):
+	case IP_VERSION(15, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.43.0

