Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD3E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 16:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2997F10E5DF;
	Wed, 18 Feb 2026 16:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4CltdjdG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3764810E5DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 16:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrHUu1pMdvuPxQSbZL4KfQ65uUgUUpjKTuFuUwGcKKt03m+NbNTwjmuGOpQ5cL6Iw8C8IK5QHme+J9w9w2EMSO0ZltFY0E0mvtG3xXqE0wi6adqnD4obiLTDkhjyS+vLRYw6hrYQ3aXmEj2EiRQQhDJZ7vus0LSgDyXDlg7ACpXCgtUPU9AK1zKsUPz0tTym8JYeyidS0jqjiWq207Dvl/v8ASM6m1DOLdEgJ4DtjmVC35vaOg+0qmGJk0NLw3TMxuhO2NngyjgI4qkGKUhqZmThHQmQpevsOZ3w5d775sar8sjRh3kF3P+ExDIii6m3l8nLZ7/wM/zqiOVsKrHnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR7k/wUbp4r6RSOx9wY+Lh7OiofqRysmRgJfcBHWiQs=;
 b=EeApeROZbG/W/jMopubxI6SGBW6GPo0pFa4cvRmG+7gGZW7Uugr54gAhKKRvoci1XmX+K1ybqEXexS5w8w4MCaRjtg6redVA9K0llMEIoLSBCcLsiLVCHLRLDYTVcn97NchWT1uSIGLClhgYmawlFnP7afQ4f6SQrAuxN+qxOTZAtJZV7zeuHOT/IwfneoCMIlxsDcgk/i5dW4foUdus64x/IvJgXGtg4wZqdd/T0r5MOZn3bTZMKotMDtF6a/bPx2ld653+emZobnI3ALRbyL994lovt67yLdAOQsMm+se5bugnx4UVoBtW1OAlYAP2IxAsS068lyOFkIuSorrfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR7k/wUbp4r6RSOx9wY+Lh7OiofqRysmRgJfcBHWiQs=;
 b=4CltdjdGydnS32omwnSaq7bK2cnsK2K8eDe6ylruDSGrLVa3fzpCcTQJVbkoIODK2mb44gyXmCqPZyW4+ROO9mFXiNS0oQw+AeLop6N7tSVx4NbTQhEKYOOiLiwrukm3psBErtrIJsdc56vFzpsIe/o64lzOHgaBT/k5836fJwE=
Received: from BL1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:256::11)
 by SJ0PR12MB8166.namprd12.prod.outlook.com (2603:10b6:a03:4e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:11:51 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::d3) by BL1PR13CA0006.outlook.office365.com
 (2603:10b6:208:256::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 16:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 16:11:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:11:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 10:11:48 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Feb 2026 10:11:48 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Tim Huang <Tim.Huang@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH] drm/amdgpu/discovery: Enable DM for DCN42
Date: Wed, 18 Feb 2026 11:11:35 -0500
Message-ID: <20260218161135.803653-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|SJ0PR12MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba3d62b-e6e9-4064-f5d2-08de6f086c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gkycT+0omLMGMCSLJjCwdNJqBSIKKm/tjBNGZwyiWTM2edUTifjpcLaVCwBJ?=
 =?us-ascii?Q?bwp8McVtIuHZDtTsXAFW/EvqshPiShGcmfOIoRKLapCthdpHXaXseHNOtUly?=
 =?us-ascii?Q?hxJVIChLPTxfZjVgHxESLtg1aM3im9Ft1PW4F/Azydvzjxr+bx5d5niH6+24?=
 =?us-ascii?Q?ZFQB2KljOjYkzrsk9/vDCbsguhWNv50cU2btuDNGsu+37IKlZ27m2Tf2ATkl?=
 =?us-ascii?Q?7U7qXhTCjGn4GWijN/Mf5vGRzbGE3NOgvk0g7F/ni75s7Usl9M7KwE1B9PuA?=
 =?us-ascii?Q?wktlqH5n/bMWvq+iiq8mQaKbCkOkaiJwdI3hJsJhV79eCvJzf1S1VTtRrehX?=
 =?us-ascii?Q?K5iDQlsIfXfZdAO0QCA6Xo6IG1A8SX2BQD/b+TvoMFEX4Fr0a/XebQwpGiUt?=
 =?us-ascii?Q?IRNkPklDwlYKg+xdaC4q8WQ9P5EIhSbwEydYmzAZs94wUGzZC+fztogNjtsK?=
 =?us-ascii?Q?skGJilcbs2N6o6NbQ9l9XWMteLMgBWOcbniXzhtW4oYeUT5eE5rH9oQAbr6a?=
 =?us-ascii?Q?ZAa+sLl6E+y+IbJ1vaYqUZgSXPenkuzLyM9Quey0vJjBeyVb5hBNE0vPCw2q?=
 =?us-ascii?Q?gqtL7k31JBAz5yCKEsG3akL8GEN8V21TdRx/ee1nwsXKIPslExtq5JRgGuTc?=
 =?us-ascii?Q?G0IAZN4TxDy/LaE0m6+xXV1rORBIMBuBK+oj29oTfO/Y8d7dlGANHeA9ikXc?=
 =?us-ascii?Q?KF53VN0opq+PuYYDV09lpxEWOQ/6R6P5wVnehdhckNi7DFUaaSg60KHSawJY?=
 =?us-ascii?Q?Xp7vA7rHEY+yO/ky2RQySsCJ7k9IzpeorqjIGMxiXXvBtWKrRcMVYWw7EbqR?=
 =?us-ascii?Q?rbUaAvv3OS+jhTgo41xrUK+FzQrSn0rMvUEFVQfSXtBoFURdCAUOvK72JzET?=
 =?us-ascii?Q?CwazU4GitEzoQIkgNYGuDsayw4dPunKjHE/RFMTs1FBi+bEc4oD2OdjG34YI?=
 =?us-ascii?Q?xwl2ZiCDw/gx+80U2QXxe1JRqkPyyM7xc6+Aviv/XXwam0Z+01oPxyhi+ZRd?=
 =?us-ascii?Q?y1rE3LpnpfEHGr6eUkONgzeGSamKBa8a6T0Lbe7GulfG9xEue0bQdykZO13w?=
 =?us-ascii?Q?l+d7Ae5szg7VfxeAyt0NQUNh2+bW9ZRq4xM1hOCtWldxIB4xImxXyad8Mj6Z?=
 =?us-ascii?Q?88yg7sd6MrKpUw993cimtfzOHdpf+Xlzi1H5Nork1AVMSe/e/cT7wPvQ4Pfo?=
 =?us-ascii?Q?1h3aSsMc780HmIu+lkUQWv1oIj39BQIUX9cco/JXluE1pF/PxJabRACi0Qhi?=
 =?us-ascii?Q?rzvOCEIfJ8sV3a1BKKSDWPZQbwHT0pYTQvO8sSLShvkO7M4tIIE2ewqlGeME?=
 =?us-ascii?Q?4msD0ReA2WO67HyGwco0jWzNxep/f73v3a0lzGq10tygjm94q38Qk5WsolxK?=
 =?us-ascii?Q?nOU0nCAM4xDhbE4YMwnMHhayeHTR8NIvhGGowdKHKckZE8Z0XU6ODvZ6A4W+?=
 =?us-ascii?Q?1jwz92BwE66z6Lz/wKizwpIE95pvOVwd87fbKVzQpaNq+Cor0elXwqHiRDoO?=
 =?us-ascii?Q?uAzx8W08DMP0+NyTz/RJhUVyhi9M/11x+NyMmvBZgOSI0NI7gKiGJ7RHmMdi?=
 =?us-ascii?Q?G6cCuKVUki3K4ksVXHDdW4wJk8cgMn0DCzpDRY0zxdGdz7c4G8oYClyatSGL?=
 =?us-ascii?Q?L9z1i08riw7zvbV1svZ6yRGScuhPHgYiK2SwcnQP3LaBjOIYmhtipLfmeLbA?=
 =?us-ascii?Q?/xLAOQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nqJ1yydeWTv2dQ43R48F1/T7ytd2Tz8McDkdIlH83FhDpUQXW6GPZ2qrOjdc1OOt5TjrSxt6zyYwZawoIEGwUAbupy+F3BG5Ow21vcZRyWeszro71yX5FOU1mTD9wENrCXiipkMcqlybRjx2aw+BId2WsPXUYxaYn76xmnoojq3miNc4NE31Xxwsh8Y4vcLJJIMOtnQ//cLycKGDnOXKBUwk3FECWiEGeaFmnlEIu//uPUyt2XnCkp54Hs1YnsphPNE62Mpvo6dqcf4PY5UVmkpRhYv1ROdfbPt8de3bmuuxxcjpuI3xY9dPWglELxpQTX0ctL6NZKx1LhaduX2TXoWNbddVcvj2mwm7xb/zy7XMt8cpZAnbQG/aXPrt6qGtXVm5j0hMN6Tj5N0gKYm0H/ehaNsu4MtUwFpS4/crXvbFBKRebL98xFVwB1GL/dFH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:11:49.7539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba3d62b-e6e9-4064-f5d2-08de6f086c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8166
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

From: Roman Li <Roman.Li@amd.com>

Add DM ipblock for 4.2.0 DCE_HWIP

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fc8c1f36be58..2f032a7d8e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2301,6 +2301,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
+		case IP_VERSION(4, 2, 0):
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
-- 
2.34.1

