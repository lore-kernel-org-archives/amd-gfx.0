Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4083EC369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 21:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBC410EA6F;
	Mon, 28 Apr 2025 21:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qDlwMurn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D88910EA71
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 21:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khsQIdEmfNm25GluzSLiUL8JaIv+IulHWB+gB7rDBeVnCJeNpf3i3yN5jjfsK3xzE6K3tO5kEOBDpktpIHzUK8BUPNOZvZIEVbWUC29doZBuDC8ECbTx9qya6/lQjk2l1FsMZRS5RH86g+t+gI4IGKwPcEbXR/wMPXCFLoAOqIcDSu6hye91/qbQp7D+7asuH3UV9vYEaEuj4qlsehFlXysK5MvzzPv79+IRc+czTc1dUmT86YceOnYXu5iXR6yF5fJjwxzSGaW0VQB1z1oG4psIArPM8NjLslVCzP+K6XtFxnXXrJ6wqrDnCWci68dndVn2tSq+9FrK/SVoyJJbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLa7RriOisEwNapeb9HiFJsO5Gu0dLGCH2D29ft3Gt8=;
 b=Qd1AnipqrGJbNScq9JcZErzTbePwqHPQM3blVRayR3pk9pm0yuyTUFq+JGi7mVaXb21PSEmk3JFJu+i3sR7qKxxtiskAZUgYck21akQTrOlCCi+FyBMI8RpI+yACGxNXJ9/bJBJ8ZeZ7DIhZKnGj0hu7HDH6iLzIlx5GsiaFRzL1uJOuAzpK+RoXw0L5gA9QENrHOg7Y0ePNNxPATG99chZet3CoaIkBMfdfDJdfwLQnPNZQWLjP07ztPI/Ef4Aq59xCqLiX3eX3GN545KWKwIatEk/UxzXp8DnTeTbUAnmwHEO72JgeXK0Xxe5Qsd1a8Amylo+ha2SSbRfJE4Vf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLa7RriOisEwNapeb9HiFJsO5Gu0dLGCH2D29ft3Gt8=;
 b=qDlwMurnSBOA0bstAKoXEIqA2Rw741Y42iSX/bo/SQUeVW3fyf9VBunbB5BVFk/sTRdY6pLmHBBxXfr7rA41K5A4N0vP/NFwwBtAjHMn2FcyEKNmKFaWe1H4uKEmXXSSzZijXYkvvNa0bcmZrm0RP6QbrYlWZheCpNtsbfb+Ilo=
Received: from BYAPR07CA0089.namprd07.prod.outlook.com (2603:10b6:a03:12b::30)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 21:21:10 +0000
Received: from SJ1PEPF000026C3.namprd04.prod.outlook.com
 (2603:10b6:a03:12b:cafe::8f) by BYAPR07CA0089.outlook.office365.com
 (2603:10b6:a03:12b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 28 Apr 2025 21:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C3.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 21:21:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 16:21:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 3/8] drm/amdgpu/mes: add callback for gang submit
Date: Mon, 28 Apr 2025 17:20:45 -0400
Message-ID: <20250428212050.1098434-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428212050.1098434-1-alexander.deucher@amd.com>
References: <20250428212050.1098434-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C3:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: fb37d57d-45d7-4ae5-dbc1-08dd869a9876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OoUyybMOP4WDil95EJaQeoj2MTk+u9JM5yRgnTMQDSgvBQUKvopKaILWMvV4?=
 =?us-ascii?Q?uzYatMWoVCzDirKPDamTcsUb4H3IRJLq0qtbeomVitIraBnpzZaEGU3NlWlJ?=
 =?us-ascii?Q?4CcDrUVHKCsoSMuUm4THNBRvwyZvqd0uo+oGlqBeeXyAoWdrZaHicx7R+wfx?=
 =?us-ascii?Q?iops7C2jLs3PCCt/MLg4sd2Hs4P12ewLwt97++7jXttV6G7be753qWOWRSY1?=
 =?us-ascii?Q?JMUzILqwvDUTqHlI8mO9xqe6+lGfPTk2nn2lTDsIfJm8ipJaSnYxwj/wVKlP?=
 =?us-ascii?Q?6+ThNP/zYlXLawCpFJzH7Vd/pWzGJ+NWtwkk5Zc+gMtZdhoWgdxsl8MJEGIS?=
 =?us-ascii?Q?N8zrW4SxxHet5n9d9Usl+hdx8kiYXNcDNDK5vTJGzclGACUUUWsweDuZB7cC?=
 =?us-ascii?Q?a0qkeV+1Z2Yyxia/4XAlHTEUjFwtNPhaEfRZc1G6jbwqc4kB+Rqp385e9ps3?=
 =?us-ascii?Q?HAqEYt97VicC8er//+kBtqN7DIemQGqpVCiymQ2+J/KpQXxjoGWUGqOsDxCD?=
 =?us-ascii?Q?oy7J4dYHBoqmpNcxA7RRb9ac2BgbetgCkRIM4LA1H+5252Arq/SJydxb2JDB?=
 =?us-ascii?Q?rTsow2HLxbvHDRT/0FvZ8Z8vvU56fd4RHty7nDrHVcui2f5NoLGxJK1ephwW?=
 =?us-ascii?Q?vz1shDk+EY5DsMD7HXoTigjoDqd/oj22kBNRjpYgwXOnYXZHfjSqwnzopa3B?=
 =?us-ascii?Q?2kJo9ZIVMDFfCAHw94BXixhycEbmQkuvbCO48yZFeGVYDl4wi3XbT5bkdzbO?=
 =?us-ascii?Q?PCuC5qTZZGuD3s83HC3cQuYMjb5IaA/6KesWge8GeNCVnCxh9AdYt8HDpqC1?=
 =?us-ascii?Q?+roIFYp2i0kEKmKjxfZqcTwD8MdtJTtd0sgJN5G/s056jCIGEmZZ5oV44efo?=
 =?us-ascii?Q?Yz/kqXm1kkCwVLgD6BmzMPdI0wX+gamTdSYQXYV3xH8QMnULQGUpVOzl4XZa?=
 =?us-ascii?Q?gCJ7aCTbTHAbeCfOc0lnvOTs9XMVbGhEa/aVp4/8pEirHyolS4F6PR2nDbOc?=
 =?us-ascii?Q?K7nyQt6IYXOwI4vSQLyB1Grk16Olxjs+l1A0udvOFC0O5T2o6aqvpKBuoHGq?=
 =?us-ascii?Q?LXKhk/ni1K4tHpIpQlxcVpx8jAxBc6NFEWKxn/s/hbMo2+MwVDSEQ2eaXs3H?=
 =?us-ascii?Q?invs2ZHScsDrSoOAiUtwDCLQuorvseHOo7BHl0DxRoVq2XbsCVl47kKuhJTF?=
 =?us-ascii?Q?uhU44ttImm208ArhCsFpKGqHPxx4aG/YCv9XfIIGDp2HWQR3RQgM7jDIKm5T?=
 =?us-ascii?Q?YHyYub+KJaVJlCXTMsbSr2snsVRAz6wMMaXde2NsCYrnF6P99YybYmmop8Mq?=
 =?us-ascii?Q?CM2gSl2rtzytEQiZ80W6ihxrtbtR7ZSYngVjk80Zl/XnsVBV6ua5j/16Gn4l?=
 =?us-ascii?Q?Rn+odjhdgv7RHAhpHL4T8Y6vCebNLnPoAO5vPidwDF9MJfygPTjhTp8YncOz?=
 =?us-ascii?Q?yIs+/IpFK9/DVd07HuBOtQX/BEcifFrdm6890ZqsnzSgYwRgo9DI6MlP3L+z?=
 =?us-ascii?Q?EhGiRLFCWpG1aU/AgH6nkSgqof9wXahmUUii?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 21:21:09.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb37d57d-45d7-4ae5-dbc1-08dd869a9876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

Add function pointer for gang submit setup.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index e98b0d892a593..bd07b02521414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -279,6 +279,11 @@ struct mes_reset_queue_input {
 	bool                               legacy_gfx;
 };
 
+struct mes_set_gang_submit_input {
+	uint64_t	primary_gang_context_addr;
+	uint64_t	secondary_gang_context_addr;
+};
+
 enum mes_misc_opcode {
 	MES_MISC_OP_WRITE_REG,
 	MES_MISC_OP_READ_REG,
@@ -366,6 +371,9 @@ struct amdgpu_mes_funcs {
 
 	int (*reset_hw_queue)(struct amdgpu_mes *mes,
 			      struct mes_reset_queue_input *input);
+
+	int (*set_gang_submit)(struct amdgpu_mes *mes,
+			       struct mes_set_gang_submit_input *input);
 };
 
 #define amdgpu_mes_kiq_hw_init(adev) (adev)->mes.kiq_hw_init((adev))
-- 
2.49.0

