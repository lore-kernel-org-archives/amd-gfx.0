Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE42CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 01:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAB3610E036;
	Tue, 26 Aug 2025 01:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RXn8nxRD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BDD710E036
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 01:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrwVEg70b54KixFaUIoEujo7mUpcALI8cuTUMZh6LtNn+4CbEVoueJEYfCZySuvbWK+jrws+srSbNg9FJltFicwrnJck4Tz6lnVBXCbLi2lb4StEvTJeSkq6XWbQzSniWfH52Ele7gyh1wSOnZXpYz/7rmgVNj+uYn8MdToNZvW8M4incqHthqAC9ED+leLdFcLZSaHNqrRBivU5YfyFoTEsibEfVZx9DwQQzx+GyLtOqT8W7jUj37a7S0hPFCPM7o7byhWUN239tqqBi+zjB5poOb8hxNXgMKy1xzmnzY/O0V4ONl3pJe+7oHsfV0ktzp58aasKJXEmljPmZNBS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=obKTLyYj4YkM2rRF3qCM/KJVidjOCio7nvi9O+K/3jvSK212LQNbd/qCB6a5cxckcZo50X18Dn7La2coKjpbtwSPK0BrJa4Ofsl8tQ6XN5rpRyYSHn2F4EcjOPm6nnbwLTJGDjqzYEVdkOiGHDHMLqKrZEwji+9N3qUJK/C5Ei9TEgneH2jXFdBAiSPL/J+DYienL48QnPobJI/brLAy0TIE+15hfkVQrKZ2mED0Fta1mryTAqCuXDZ4Q1J/d8OhEN6+/uxTqUVydt+TB88FZkpSJbWwCFofvP8/BVmJ6bwMuYjZqa2jGLUCu1Y4aEFkXER2bUMyGNk0g3+iAfdNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=RXn8nxRDXP3IGEP1WOVnk0Wa5zeBAf7Aa/lNfbTOvgIpI9cap/g63hNm/zvCeWIIiCZ/FSt81N5+Jkup7W2uAXf1+BmNbdxzjPKefpgzaVlQ84Pa8Q5o0RlcbsPtwiZ+S81JaUdq0rxZnx7u96Jg0xkv/YwhCaSV9skMWBrza6Q=
Received: from CH0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:610:32::35)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 01:47:01 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::e4) by CH0PR07CA0030.outlook.office365.com
 (2603:10b6:610:32::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 01:47:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 01:47:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 20:47:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 18:47:00 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 25 Aug 2025 20:46:54 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Tue, 26 Aug 2025 09:42:11 +0800
Message-ID: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: b31a240e-806d-4895-e861-08dde4427360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2/E+RolX4Tf8NaQ65g43XQpHRTBCCOLGlH7GzxkhpWEDaq7X+IL27A4MDJ6Y?=
 =?us-ascii?Q?9EkfKqALE2OELER67hdfVHx+OcVr7+xGSD5zsXS2ACMd9IqnsTZ5nINCl2KA?=
 =?us-ascii?Q?9SCXsbPd5Rg4bDSkXaNMuAM7/ZdXMeOIbS/wxtnKF2eqKffBaQUTpXSw9QsR?=
 =?us-ascii?Q?Lwen6/b3UWJ/FVO0Xp5QnAp82bHQq09OlMD3lmibEnTrlLn1wJUvxqjDdRu8?=
 =?us-ascii?Q?eRoORl8wAiHBElrIVXmynxzgYJkZpWrQ9prBo95uh49/xzlrYxoQvxEwly0e?=
 =?us-ascii?Q?GFgL87tOHCTPCJJhDmApXCH3hCKntg8lQ45CJaza8ieiTPCSEG+qscg9srEu?=
 =?us-ascii?Q?lwHArKI9rzvKdwE2juLZoySt3Ch0Myvd/bptURf0QIW1GbOisChHTDRBvk3C?=
 =?us-ascii?Q?A1srUo4E0TePxfWBlXCvGZ+oAH0LbGRQtQQnL3zt2FlPKW/pvcqZjmO3BcOt?=
 =?us-ascii?Q?NfxrA1SiKwa92qu+3DxydZWjdrk/RlRwgeb7IY2508JFhd6531koR3ARv+Ml?=
 =?us-ascii?Q?Jm0pWpB05R0wmjA65v4O6mP1cNQBrrwhQCPphGg3Rvg5GfQDPSN1xSm5Y0NW?=
 =?us-ascii?Q?bdmxO/Zq9SPNTDySFaHDanWKcaOe1XQ7Jv4KK+CPWY7D4UEoNVV+eQPfah5O?=
 =?us-ascii?Q?p8PE0nxEUHsZh7FJUHH0ul9RvCj/DUkugFmpIxh/bheEU+dPgDyX7QivzFXz?=
 =?us-ascii?Q?C7rJkMP50Z2AnLhVFIYM4y+L9fzFRHmROkY2Cuq7WruZXE/1ZOSmSDv0LakQ?=
 =?us-ascii?Q?yxIT+h7arCKZOQuAsyYUOLTATgI9KOv/aXQvZX66OQrUtogPrLpw0VyrhkR/?=
 =?us-ascii?Q?cSLeq3d1MK5H3qz0XtltrsN63nlVcjhS51bNRq6UJjFdGdaa7BlmGAFNtd80?=
 =?us-ascii?Q?uXjRz3TN4nloeN8BUnMp6/d5ev/WV7B/qoFNUysYNO3fkoPnAB8fMiPWogtZ?=
 =?us-ascii?Q?xd2I7e+jMp+2JYDinNYUdPYXa2kvup2uHhziHnCKSe3vFUM0dRIm5CcnjSAO?=
 =?us-ascii?Q?RgfLZ+T9fVBkmMcD1ZvdDHOp0SxTs3K4XvQIfgfHTVVYwQtOpPLu0e3C4N1f?=
 =?us-ascii?Q?RrHwy7pGkPGhmaCoH1BaPd6I93z5d/5PM3+olLMFWp73Ssq8TG0FZeJn+Nia?=
 =?us-ascii?Q?kB8CiDeJZucxU8dcFSfxOIN7rynDcjVNJX/V0hCoq8Niz1eCb5KjpOxUL+/4?=
 =?us-ascii?Q?hzF2a39yN1tIK1JIAP+UKVaOEO334d8uaWa8wVKHrgL++0/qxdMMTTFmgazg?=
 =?us-ascii?Q?zhmel+DzjVGLTCEWb5S+E+7cUGgg6XsuXkaY53oOFJfOjyc7mbCOtfDdYqnI?=
 =?us-ascii?Q?r7GIvViRjMoiqoxlbXmVG2Vhb+9k6LIlx0ZGrjFLJYTCOJlAqDSLAkBfD6W3?=
 =?us-ascii?Q?FBt4Q2DpPjBoGJlRMUh0kVRQJjQbrqlwe61Rqsx3h83AWnehLbto0Nyd73D3?=
 =?us-ascii?Q?uLVXL4Ro5nFOb3cudCJbzx0/seDyTZ7NINa/FCuuJzorlNZxn01lj3nr7vFM?=
 =?us-ascii?Q?j9PiHlxi4yLM/GU113S/Ai+8vgdR6ucVSmAS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 01:47:01.0643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31a240e-806d-4895-e861-08dde4427360
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

