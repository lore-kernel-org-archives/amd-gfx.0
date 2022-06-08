Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6DD8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CF410E149;
	Wed,  8 Jun 2022 09:05:54 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C0910E22C
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:05:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ4ZsrOwUaMyoQ07NDC/ZiLRJA4RqQ+BlujvHyK4anB6SOn955NWCqZT/3zvcsNrj0XWvXw3LkUOrl1TMH/BqJBs/mu1FbePLWJPq1n8vzLwaxoEpWi2ier6UbgEesYK7oyUTpv/95IeosKGsFwTyELI4LyQ4JhbfDncFWLITBsku07aV12XMbse15yF8CWLnw7rhaCITl7rJlXfJHu/6W3ZrysiF9mxtKoJAcYwNDlx1RztktKy7pcoSekhuhilza7ILbIp8tZ6QSHw7u1a/5gs+DjvzCfG0czr5+pHxFwBqUuzdiqrfwNWjDoBpoq9z/VmWvyBbpd09gKQ1aMCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Se/s1H8L8e9tFCVv7nLQN9RIUe3S6O5IaJiHf61AO8=;
 b=BloEBGHuI8z2V9ALbUfrBdwbtftU+SR+EBr5X+GNYIqKdHhoKdZScszucRZLRB/FwBrJGjsvpBqI4NH0D5M/qzulLYPEu23NYR3ociv/L1RafQsZMdNXQWZZvOU5jK5O2YENehv7y2+AWiLieLz5mYf73TjbpN2VWyptlyGtjwr5SKLa9E9AZ2dSjgUZ/MMCNOjGe19NAM1o7/313yU7bvSyZ9UkJBqt7hMxnUQaDe8rtDM6VF/rK+mYlAZSySxmKQBKgvMMnAQBmOpcllRBW2tr4bwbKybPztTCKzDo0PQbrgCJg+E48Q03PilkNcOwEjBdd9uyi/tCwPdyYTrXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Se/s1H8L8e9tFCVv7nLQN9RIUe3S6O5IaJiHf61AO8=;
 b=y7fwdR90Y+6Dhpy6RA/OLj+XbL/4Ld+C7r0m60wGCB2p0063/caw5EZny8EoG7dtcNWaKHW8jJg9WVJw62RWqz0OoDcduqKMSVt/LQvtxGOWUwWZ5qFp3YJLitngi/+ikRHgkcg0XDKoOjmipA+IjKC1wjcUs7kpG2rxQ5ZXE0o=
Received: from BN9PR03CA0851.namprd03.prod.outlook.com (2603:10b6:408:13d::16)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 8 Jun
 2022 09:05:50 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::10) by BN9PR03CA0851.outlook.office365.com
 (2603:10b6:408:13d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.16 via Frontend
 Transport; Wed, 8 Jun 2022 09:05:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 09:05:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:49 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 8 Jun 2022 04:05:48 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/pm: enable BACO on smu_v13_0_7
Date: Wed, 8 Jun 2022 17:05:33 +0800
Message-ID: <20220608090536.1969621-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608090536.1969621-1-kenneth.feng@amd.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d52bc7d-a714-46c4-dce3-08da492e1574
X-MS-TrafficTypeDiagnostic: BL0PR12MB5540:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55400C37EB1989FB8010ECFA8EA49@BL0PR12MB5540.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yjyFl6oA70nv+iJ5J+MreKb92CLZf/1Adh4jiZJRBKUZ8nDEXvnkgZ2Tska+8ei9OfMYbf4D53hve35I+wU8/HFspyAi5QBhWgrfmi1EANoI2YMoQDbp4MlaJ2nqPb5xmr2WEj/EItglMme8GX/KjbwiGPxMiTchMzgC+I64wm/OO/rArSPFzHW+zpZnFh1vNH+VdJMTw4ARcxfhyVLiTJcGoS/33H/TnH4QeEKrBtAAvKjWIT6zG8foFhofYhe3z4Sy5+4R5Vs51lhQtsroQLNDtOl5/FIV7jzvkZNcXMI4TqyLgbRRSBr1pUdBolP9M+2NFZWrvwz3CUSl+WlfMtwwvqRbgXc9T1mwuIxiZ7SyvTEe3UZwy9SiSOnDmCuX/3hnez6Q7bvi5242MT+7zgRH4p/0y+wI9rFKXhHLjExx3e16CuNKcvdsT0vedg/Ix2NDiSSRz9gTbinR9fRJyERiHq6PQcrXmTBvBSZOl92crIXVJ0HQzvTXZB1Y1zxKiisBMD0qYuNkhWfX6n1ezlpJYQN0IVN4eXLyvLodfsnCU/Ff71VjYXOJdrIzd061hoQSFKd2w7QroJEsazZXXJgiTxXQbKBhfC0LQ8sjQFUT7lEe1RBP+XXKTzOE9STRzcZz21RfSPgWi3Es/O5uFxikxLXI6eLEgSb459kw4D9fetvEzu+SYzI80Ex3s9jMfiPxta+PZe3OLkfRPV1MlZR3bRRERsQE9fBY1N+L/LYQlDj++6yRwQlbsD8jc7R1czdNgZiFDWhPTGZQoM6xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(47076005)(186003)(4326008)(81166007)(36756003)(508600001)(2906002)(70586007)(6666004)(70206006)(8676002)(82310400005)(44832011)(5660300002)(356005)(26005)(426003)(8936002)(36860700001)(6916009)(2616005)(1076003)(316002)(83380400001)(7696005)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:05:50.3025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d52bc7d-a714-46c4-dce3-08da492e1574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

enable BACO on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c            | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fb04d82f66e6..f57710790b8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1456,6 +1456,7 @@ static int smu_disable_dpms(struct smu_context *smu)
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 5):
 		case IP_VERSION(11, 0, 9):
+		case IP_VERSION(13, 0, 7):
 			return 0;
 		default:
 			break;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 7da42cae5d6e..dc614befcdf5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -97,6 +97,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(UseDefaultPPTable,		PPSMC_MSG_UseDefaultPPTable,           0),
 	MSG_MAP(RunDcBtc,			PPSMC_MSG_RunDcBtc,                    0),
 	MSG_MAP(EnterBaco,			PPSMC_MSG_EnterBaco,                   0),
+	MSG_MAP(ExitBaco,           PPSMC_MSG_ExitBaco,        			   0),
 	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
 	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
 	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
@@ -281,6 +282,7 @@ smu_v13_0_7_get_allowed_feature_mask(struct smu_context *smu,
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_MPCLK_DS_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_GFX_PCC_DFLL_BIT);
 	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_SOC_CG_BIT);
+	*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_BACO_BIT);
 
 	if (adev->pm.pp_feature & PP_DCEFCLK_DPM_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DPM_DCN_BIT);
@@ -1584,6 +1586,11 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.baco_is_support = smu_v13_0_baco_is_support,
+	.baco_get_state = smu_v13_0_baco_get_state,
+	.baco_set_state = smu_v13_0_baco_set_state,
+	.baco_enter = smu_v13_0_baco_enter,
+	.baco_exit = smu_v13_0_baco_exit,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

