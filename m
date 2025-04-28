Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F1AC369DC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 13:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B551110E576;
	Mon, 28 Apr 2025 13:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oaKs6rx8";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 346D510E576
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 13:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AizecbMdys/NXvkQ0G1NtpTVzUZ6R4zNNA+dYphecMYnBpgRGNSEwoZeCOA8W1qiX4to1Xw//YKCyBYnBajEOjiFkBg7UcZ8MSuhoCkg8KqrubIMm3OlL/q/GgoOiJIOtLWMvAaPj7CuoACQ4nQt17PkhjpbErQSzOJSgOTHaJbx4Kut9b8K2PtyEm3HZ9AjArV6B6YDAG2DMARPpNTkDAEX8ElSt1HI1TnFNb9lf7F1YLQyaWXQE8ojBLheFBcfJ7jysp4J5ADuvOd0L5/QCIlxeY4CkmD3OBupnNwhEsnOu/WTZmA5tnOq/IHbMdH3gk9IvzJsPodi9NOZY8TlEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbmYA5sanUIVL/4NGHHZO8r+4QuiXfauRu76vFEwKp8=;
 b=U6txW5GxFnucVBJugfZxMGyFLkp5a9bazrG9f6NKVUFVNXdZYXf2mgiuABk6X13MtAknk9gmSJcT4Y49R1oKR0uJesjJXpz0SLQiYR2Zw3tLaGZS1fmnB2q0+NZza2Yh+ECqJ7zAddb70DsUOuEwXjzmjI29lwGyycJdPixZQxvcwh4Ik3N062d3KHdo80qGK+LVLmDJ6hHvgDJBSkDo15awCdUIyBq3G9zzheqq/cxf+g1TBWtbMZjIrO5/cuzclT4ds2BKID3S9SuipESdco0N3EqcsQneURNKz2+GJrOSsfhfnHpzWkomckQEWaB7Bb7l0X2BlC2ru1AB/hA1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbmYA5sanUIVL/4NGHHZO8r+4QuiXfauRu76vFEwKp8=;
 b=oaKs6rx89/FN070/DGybl4DV3bar67ijzN+/w6IsIaO68bgqEPBZ5JNcs0Y93VkgFFyayEeabQJOgK83ywlsNIZUfPgcRL0yJzstHkwx679RI9gCW9ts668bpUFRpeJ9tdYg6SYiJVqw6gseA/GbSMO3mg6R3HCX2BX0RGvb/sw=
Received: from CH2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:610:38::35)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 13:57:42 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::24) by CH2PR05CA0058.outlook.office365.com
 (2603:10b6:610:38::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.31 via Frontend Transport; Mon,
 28 Apr 2025 13:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 13:57:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 08:57:40 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Apr 2025 08:57:31 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, <stable@vger.kernel.org>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 25/28] drm/amd/display: Copy AUX read reply data whenever
 length > 0
Date: Mon, 28 Apr 2025 21:50:55 +0800
Message-ID: <20250428135514.20775-26-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250428135514.20775-1-ray.wu@amd.com>
References: <20250428135514.20775-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb84ddf-9f03-4a7c-4a90-08dd865ca505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i3K/w+1IM9XNWJ4mIhQ4d0fwa/97G/Jcm6a1sTG6uGow0ZNP05bHD+0IqOCL?=
 =?us-ascii?Q?KKPbu4Jqp6MDNEDepV7imDCdrk+LyCbLuEFvLC2pPrsQ1+fV8UkKaPnTOkkH?=
 =?us-ascii?Q?uKei4ZTItMQTQMZ+uwn34LnzXSXIgID1Yp6FmEVyCMZM+3iarEaobsi5hDgo?=
 =?us-ascii?Q?LQABn9Kg4kZYpaQFRQ4nbUSF5SxpxV93FGPN4RFDNgaOBRTbR9ksLuHBDS5c?=
 =?us-ascii?Q?5tHICyugwJz9ZG0xGnGXmUTyRMWORgZYRim8+mn1OKQYcZ91tD2H9CNm8shV?=
 =?us-ascii?Q?QE+HtlkRDZu0e8eupbFdcQzUr+x99/XhmHfYcCp3aprVsNwmugHlAQH9EWkk?=
 =?us-ascii?Q?7HY4RnWFWJls+J2R/QHMndDD9Afpipowt2ijYa9oFts+icGLwjWxmepVFqlS?=
 =?us-ascii?Q?SwLerbgsiofuCG0L/xjx/leUcyRBsy1ojt5xAejD3TIkc2DWSQTIp4c/u71Q?=
 =?us-ascii?Q?LRYoSvogA0UMa0B3YLcypkAP7K0u57w2PpUlKY8p5Zz3S3D5WB6gsmFxyUa/?=
 =?us-ascii?Q?mZBInQ+KNEPUQ8U1txL0mHmM4OfFPel2ZqbqggMVoC+f8FCa2bOfmbZ4NCPy?=
 =?us-ascii?Q?poikjNwV5Lub6tffyTQwIBW93DrZ15DvPcs7dC/1RubsJWjyVMHjeh3Chg6j?=
 =?us-ascii?Q?9e2lRE1bcXQu6gLjcuRN5/Rfn5VILZKiXgMuyhX1WXTYExu/Sv43Irk2BVCF?=
 =?us-ascii?Q?tITszxZzvEEU8bUfp5rX2HjIxthS/j8qExwXyFpkdIxoB/T/NcsEiCKGdTmI?=
 =?us-ascii?Q?zk34CnoyXvKs9IZ72wWQEoCiNlgV7AmJn7o6V0upZdhd7QC2kcl7cSWYffiS?=
 =?us-ascii?Q?JvRwxsgRFUuD3cWBQKNvvYi78bsxRs2mU5Szm78PEmvmqnkY5VTRlhCFi1h2?=
 =?us-ascii?Q?gin5XieK51sV5ma9BL+LvU2sfQyHuivbZuwlnaztX1JYHEEHRzFz1M7Uv6NN?=
 =?us-ascii?Q?BCH3rQG9eefap/vbiXPNq13C+PqJLBM5HNnBQSO56R1SFbfIX7ZRqnl1Cmss?=
 =?us-ascii?Q?oTQVK5b7tslEfNIotr7pDs9wClhalwJEWQWPOoVddkkd0zeBHmUy+Kk3Url2?=
 =?us-ascii?Q?jMbUZMYPhc8nVPfm3/rL/7Zq+fg+O/bB7ql03UyjJwbIG5B6RUCVzcekFkZS?=
 =?us-ascii?Q?zULP+0zOS6prK6QSKmiQViJPJjVQjtQw+hCvGMU0eoXcOkKDtLGJ9Ipq4wTC?=
 =?us-ascii?Q?SD09TyyEQvHY4clJpU39YyAVAEg0SMlJpBm6pqelDF841dAFD9TCQCb1i3mY?=
 =?us-ascii?Q?VAPjmca+k9LEzAWIM+VMpa/w+4ZcQFxhe64BTxr+6MvG5G4YMgepD4hNvPU9?=
 =?us-ascii?Q?ZsVbcKREuZ60X6DsaMKGZ2c7UuDXX3mpSeDtR8TjjuJ6tpiJfmW9FNMse4cA?=
 =?us-ascii?Q?EdjkCJnYSubznO2Ync3++82ZpT//FMsrCmPLu1J/MsGr+pRXYLyExVmQrCPz?=
 =?us-ascii?Q?rFbcuJTswBS6fl6BvomG9KO8oGVSlMqzGdjCERpCOzdlcPBj966XOaPvAYuh?=
 =?us-ascii?Q?oV0TC6D46KADY8Q2As+dw8OaRO+uO25TK6YJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 13:57:41.9547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb84ddf-9f03-4a7c-4a90-08dd865ca505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
amdgpu_dm_process_dmub_aux_transfer_sync() should return all exact data
reply from the sink side. Don't do the analysis job in it.

[How]
Remove unnecessary check condition AUX_TRANSACTION_REPLY_AUX_ACK.

Fixes: ead08b95fa50 ("drm/amd/display: Fix race condition in DPIA AUX transfer")
Cc: stable@vger.kernel.org
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d9c18e0f7395..88b390609c9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12857,8 +12857,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		/* The reply is stored in the top nibble of the command. */
 		payload->reply[0] = (adev->dm.dmub_notify->aux_reply.command >> 4) & 0xF;
 
-	if (!payload->write && p_notify->aux_reply.length &&
-			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK))
+	if (!payload->write && p_notify->aux_reply.length)
 		memcpy(payload->data, p_notify->aux_reply.data,
 				p_notify->aux_reply.length);
 
-- 
2.43.0

