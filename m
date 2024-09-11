Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AB8EE499D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 13:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4394310EA02;
	Wed, 11 Sep 2024 13:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JgDb/ejs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7621410EA02
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 13:07:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx4vxbUEwIFr8Jy6j/MexSG+j7E7l0AEzNdsLwAqc2F+EG9+xCVAqD5JaaHS5+Hm9pEFveAXkvHAafSEh+K14dS/Y3j8DfDA29OBM+6kEAL8Eotj3w/VknrOVoIbVDtzTRbtpecrswKrFLxPtfiVE6EWl6ssbAM7O9p2cqSdxtHPLrOg73exSd6MWnTl2BakhrDBH/v8+SaCD6CmqB96RI4JgKTRtt6RrMIkXnjlia0tLjC9zeRKOHRM3VNB0kYHkU1Lkg3b42PIgc6geaLLL/Jii8+swkKZ2+Hkgw5RixpWO3Nd8ZMFBAySr6NqCKH+8gplr8HAE4Mbaw2OJCpvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8aa630Zig3fypDsKXPCAeywuefARWqLd+x3/WYXlRw=;
 b=U00Kpu2AvKIhpRKecyXeRCizS93nArQJX/vdMSAg1h0oflvi3TPjwMDzwQqro80s2gyZL6UyiyrkQEo2zjX2jDdpPtO0hmUuNRgXL0zjgCul21i75l++RyuiZ+TlCT7jdiBvnlLC1wWx7VS5clQy+o03xUj3QrwmpWLbRiKOMHOm3SiVJ4ndzsV8aa368PALGShQUkRKjYbqslLpHhfLGPmPY/6624S2xpR93RrfhF/Xg8eBKFDys7lEFa8GdqiLXrOFUQr6ynCDILOdriDWH1Shr/W0ZojR0NhDY5Z+ltXLNArzXUkMXS3nhYmJN5g6VJ9WS5o84rky0D9JnGT2kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8aa630Zig3fypDsKXPCAeywuefARWqLd+x3/WYXlRw=;
 b=JgDb/ejsjjtst/vwah1OjUiBN/ioqvM3y2JUz4fNey79QHXcoJzWG8QBLttS+rFDsbzN7kl+iqeNN5td0KzHtvTOlfqbCcrE0ZpsKQkhF8/ktOc6Z/G3oHMiCEGD/Vkha4OrY6qZADWjpfVKDhXDxfV1zQgBYGY9D12XEFEFuxg=
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 13:07:18 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::2c) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Wed, 11 Sep 2024 13:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 13:07:17 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 08:07:15 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <hamza.mahfooz@amd.com>,
 <rodrigo.siqueira@amd.com>, <alexander.deucher@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] drm/amd/display: Add all planes on CRTC to state for overlay
 cursor
Date: Wed, 11 Sep 2024 09:06:50 -0400
Message-ID: <20240911130650.6535-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 51cb7bbc-57f2-469c-5fd5-08dcd262a982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CXcNJ4ujtEgtU9FBDo4QPiR71YxaEeVV8nBfcye0jphXuvIx6dNjzr1EJ0RV?=
 =?us-ascii?Q?1f75lXUyHLv6ppE1T1EZdlwz5XL54bYwlfVPxnLRPGTmGBk+a6EfnTrYMLX2?=
 =?us-ascii?Q?+/RMz0BX3iSSrUmsQWFVKtCuo9ds1uYIKjbIfuczLg8fiIfyihnzT0NUYE1n?=
 =?us-ascii?Q?TAtaMgJ4PlsALW6E2QaKTZ96CrL4uw6GMfWO6/HO8ElTf3Qsw442Pg1GjgKD?=
 =?us-ascii?Q?JqT6QroqCDLTgqy8n+IQmYaEs1zVUklpW/u68FL7caRNKKUI/arlvG7oIb0E?=
 =?us-ascii?Q?tsfO0woR2mC9OEMpAIMKfhRVrhOxrDinm7/aLf6sVP3TcwnhkaqOv9ZeO7po?=
 =?us-ascii?Q?33IQfvTNxYzv+uQrWs0JMXSm5fWx/CaXncnkiNH5w6s526D6zUOt9PrgoJCp?=
 =?us-ascii?Q?5+th8k7oq6dXBF1mTLWnKbN2aNhozbHnCAZNI7JSYXjgAuXyIMPXT+EAfbnp?=
 =?us-ascii?Q?upxD6/EScWDDpdPLFZsyvSlTIY5x8vtAbWV556ZqzKGYtseJuzuyj9qXYmfU?=
 =?us-ascii?Q?W5wgds4bdVsKu0wm82rwkMaQ66xMGr0bBFxi/ekQTLSJxmJHr5IBilnmm0RB?=
 =?us-ascii?Q?q5qDG1S7m8adkNq8nqdvtLt7jzsQF3c51XUi0aOWaAErYiaqWXysuJ6JDvMb?=
 =?us-ascii?Q?4Ni/Hw4jW+pPsNYTdd9MOEKcUPLMjoEZ1mkn0xsrnxyZUKIp+dFxkoUpGg7f?=
 =?us-ascii?Q?KsC7DaG0IjWbtUj4lXG2mVeKGealNoDqvID/jiE1jHfr7hnZjEte/3l0Dofn?=
 =?us-ascii?Q?GB1BavXFDJpL9rY8QT/t2NxyAHXBXaMBuu674hT5DBwqj1U5Q8afAjuuAPau?=
 =?us-ascii?Q?68WwjsAdrXxlIUaqETGfVsF3vwmgJve9yr/+VdWEJzmvw1YR2yI42sZ+1r0w?=
 =?us-ascii?Q?GTdOtU3TYNFMQiSXR7sH/ESu+Sph32iQ4ijyAETPzvExR2ebx8VC0egQq6BW?=
 =?us-ascii?Q?16UK2x6xl3ULKATYD0VCs90CTcnhodWw2smgyfyzG23lDFFgslW53YGm0FQ+?=
 =?us-ascii?Q?uyrZ7Fv+4VVlARKqJJT+73X+N2RRt/6YU+EssNgjIkRMdBoLx25kcCcda0EY?=
 =?us-ascii?Q?5FKImz2/T1aX/xzCP07+rWhJwwJGUvmquQfpKybOnejudo//+IBRCdgr1H77?=
 =?us-ascii?Q?cSlp6UK6dCJic/byyOzkhweiagABil8JeF+RQrgiLV98jUIePcl8oHxfcauW?=
 =?us-ascii?Q?tecd+X3BejZ2ww65jPqTt7ZIEZro7xpwjrImCUQXBmQAOr4+QH8T50UMTQ3S?=
 =?us-ascii?Q?pGhTQJmtc9dKfzQlla1wYkNUpSoCskAuUSz0nv5Gn7UYCXeJKu5rR7nNbgrY?=
 =?us-ascii?Q?8CgrDUPINHs+67Mk0GkuT2JQhkZeUUU6bBgXWgPIM62HOEMkYZilf5ov1ODV?=
 =?us-ascii?Q?tPSZdelXvpYnP1JYwYr6eqXXPbK1ssTk/oo47t1ZbLmpORdvFY3PnFq4UCec?=
 =?us-ascii?Q?ht26WpaXIKnavM6A7ndBj4KEJt6zo6Gl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 13:07:17.0570 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51cb7bbc-57f2-469c-5fd5-08dcd262a982
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

DC has a special commit path for native cursor, which use the built-in
cursor pipe within DCN planes. This update path does not require all
enabled planes to be added to the list of surface updates sent to DC.

This is not the case for overlay cursor; it uses the same path as MPO
commits. This update path requires all enabled planes to be added to the
list of surface updates sent to DC. Otherwise, DC will disable planes
not inside the list.

[How]

If overlay cursor is needed, add all planes on the same CRTC as this
cursor to the atomic state. This is already done for non-cursor planes
(MPO), just before the added lines.

Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
Closes: https://lore.kernel.org/lkml/f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a3edaf658ae00..6b5baa3e20c49 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11427,6 +11427,17 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			drm_dbg(dev, "Failed to determine cursor mode\n");
 			goto fail;
 		}
+
+		/*
+		 * If overlay cursor is needed, DC cannot go through the
+		 * native cursor update path. All enabled planes on the CRTC
+		 * need to be added for DC to not disable a plane by mistake
+		 */
+		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
+			ret = drm_atomic_add_affected_planes(state, crtc);
+			if (ret)
+				goto fail;
+		}
 	}
 
 	/* Remove exiting planes if they are modified */
-- 
2.46.0

