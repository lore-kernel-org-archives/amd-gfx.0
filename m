Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B344CD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 19:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6390710E8E9;
	Mon,  1 Jun 2026 19:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BlGKaevc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C3C10E8E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 19:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0+fLkb1GZJ+NnLMKbkR4IEktyWVbfJD9QLX8viuUmOBY0pUvXKusIlv2JPf6xiIdkAKIJbSjhRvfIVi3nSyUxtiGgN+9cutNDF7TaxAsMYmXrCYyj4LFwLJrnv9mKs78Sl1Ot4us0WnNw7REseFYkBfHmTy9+5793tprFpbg2zNO1znaX11DIaKTmShvTuhubb8qpL/2umoFzI+vBHkFJDKzED4DqEkEcmOavUncmcx9cRw5+PJP54D6L83EnSf7LNsemqCTC4GqSDn8uWDSGVVF0DssKkUPaCMsOX9/B8lPmyJAjKGnR3StNeREJ4Y5CrZHODRfuIv5pGuU6MOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUEypc4qN7fxDtaG/+YmM3u7qhNJ6SRzzdI5KZhcO+Q=;
 b=iaF1E+guSRZZJZ9GCSJNQ0vhAGJdyscon9Cs2M4eT6Y3vd7Bd9pU7MLPNi8zmhQfGPyz9JUhUYbKtXoxqM0tiWUH9x41PbNU/kIrp5hhpS2NNnalHeZQAAMmWwPCa5uaU6YlCmsfJxlrYYD6mCSgqlfbl7QjR1Ei2eCmjl8LiAN6F9tCQDH3puRcpDjRX3rmQKC9DSczZz09jyBdL/2Yq34n3hufi+n43vH8X7T8X3VD4tEVZWcFVlrCzKEa+Bxga7JLH0/KG85yBaetqAszDtawXJGhKoil1W0f/mzYJ3qCOvxu8PN+C2BHFTK3Jl8jsUkFsLyYelN+Vq/QXhaCyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUEypc4qN7fxDtaG/+YmM3u7qhNJ6SRzzdI5KZhcO+Q=;
 b=BlGKaevcExc0ACtI7tbdO5JhUv1KC5RENpN2UXcwCP4dp8crifNPL2ynWrGEJsKK77Fq1jxIPV/UE5/b3Pmk17p2IQMwkMCPkFGoM5RtMfrkKyi0bjqqcoLxhzhQ3vJJzcYTN7HU/MytQJk6BROCxv3avVX34oAE3QyRtiURivU=
Received: from PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) by
 DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Mon, 1 Jun 2026 19:54:18 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::78) by PH0PR07CA0003.outlook.office365.com
 (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Mon, 1
 Jun 2026 19:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 19:54:16 +0000
Received: from 0yonsun-linux-dev.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 1 Jun 2026 14:54:15 -0500
From: Yongqiang Sun <Yongqiang.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yongqiang Sun <Yongqiang.Sun@amd.com>
Subject: [PATCH] drm/amdkfd: fix sysfs topology prop length on buffer
 truncation
Date: Mon, 1 Jun 2026 15:53:58 -0400
Message-ID: <20260601195358.226233-1-Yongqiang.Sun@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d3c5649-baec-4b17-1226-08dec0179006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: 9vdfos5EBvHQJwDJG8RuDnP27Hxh+FbB7b0SfJw0eFXU0Fr+Nn3n+YuUK+jqoW0oxvVRWBPjy5eUt3k+tnzWDVA/h8dZW9Ore/st5KVLBRYoe37F1YU/BccMC5cwy98vkhLFKbbOQnUMCmKgYmjq71EBUH3AkLofFjT4xFg4qMtbUK9Y1pYQsrBDwsVvNJsj/9aivk/M+fZ1dKL2TSPCvUVSil0awclDqBEkeHIC4IHaNeZKI3EskIX33XunN6TCb9eT4nyeOvOcDYKblJfk3dftRsw3FsAiJ6s3oYn2G/jEUBBM5DAsB05HeciF53CuEx7Ipqf7UaBn+M0PVtwRSnDJbmXvcZyw3+0sFot4E/OVLBAxuql/kOYquau4NNXsk4DvYOME8mSNka5fOYCWmfJ69aIDVOhL4DlGoBOsM1RpcP3vBiuG1AU4suXzgt8hDemtG3d9wrCgRkiVDmm99AB9PhtIyLDtbgl0hbl21K6skbIoLG6/Ivi0O9g+BZPwKB+1ogAXkZeRq3GvVBgnMUOWQwgOeMp+hPPq3rfAIaDv/7rNFtwg5QMoFLnyVv2ZjavDdMwcd4GmH5Gachc/ChHck16W8EMVGnnTsQZ98I0G/EHaPpiWC2skYivt1jJJQO88eYkl9MjJw14+BwZcXia8uhj83FesmzH8p2XLe1ZC0mO2NHx5R2sTObqJNqRc+txA3KnWDAHyCi5OZ6qGcaip/2EOKFGjPLc4KrLVo54=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oNhdHoFs9zwvxmQuw0xU5WU5+IK2tcqC7ipJer0uJHvReQTmaVl7o8QJ0PLhU4Q80ONbXk+MCXfLOvYJsNiMy73EjXq8TkxPXIc9Iuo60c3KYzXSf2Glx2Arv+uNTm7TUqyG3WBcMVhcTF5QWaOHclVFMr1XVlQqBls7TEzy4PBm8ZM/iFApCqQ/4XvTVps5JANEacIm/esYFh4fF8WP4QWnyMWFTtt61xEVGbNFb+T3OphytzbRdt4C3374pRN4NSfXa3CRROuK5VMUBIe/mac/BiSeUAXVfiax68JaLlaemBbdIh4VCqXAmsZICHngYV5Ag+bM0Gpl8hECUp1bGKDjfIlFmWYd13IxAf6hyy9miBemmAeqtFyH4mYxmjj7dbfvb9fq5/Ji+/kW702r71qGHxQHgvUrJKb7mwFGbbQtQzZYIm5ejeh0xMdZ5CYG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 19:54:16.5399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d3c5649-baec-4b17-1226-08dec0179006
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

sysfs_show_gen_prop() accumulated snprintf()'s return value into the
offset. snprintf() reports bytes that would have been written, not
bytes actually written, so a truncated sysfs show could over-report
its length. Use sysfs_emit_at(), which returns only the bytes written.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index f57da088f1f8..0ff793a17857 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -198,8 +198,7 @@ struct kfd_topology_device *kfd_create_topology_device(
 
 
 #define sysfs_show_gen_prop(buffer, offs, fmt, ...)		\
-		(offs += snprintf(buffer+offs, PAGE_SIZE-offs,	\
-				  fmt, __VA_ARGS__))
+		(offs += sysfs_emit_at(buffer, offs, fmt, __VA_ARGS__))
 #define sysfs_show_32bit_prop(buffer, offs, name, value) \
 		sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
 #define sysfs_show_64bit_prop(buffer, offs, name, value) \
-- 
2.43.0

