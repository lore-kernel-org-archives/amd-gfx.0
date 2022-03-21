Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D74C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 08:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D16EC10E279;
	Mon, 21 Mar 2022 08:21:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E152310E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 08:21:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwGI/gHdjV1I+T93APFmtK2OMrF/nfCyQ9md7EenAbGcitGGs1iTrRNvJ9OLepBeeHWFZQlb61DQx/KyCfu0CEa8BmKkN3LFnfneWnVRD9txYsWDtDQ3jb7ye+ibAyCQZAcSkelokBJX9j/4rewfJjnrYPglRc3NCZGU4tTl+Y6dZwUfvnhmQQryEnQ6TS3TwVJ7pDJD9xrO+MeY2TIJrnjvnk5Pt8zv1KCI8sxOorhYAVg2gd4bhuOjSNiYrecgvg5rv/i2nDTtFz11blAjAvrZ9DIawcBRIfh5DLO9g1hkFx6qW3skXKoMBrHPNYLX0IvjMX85yBjZ6iJJ1id/1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hld5ANLKHBh7wce0DfdlkwlS6Bl5UeGtZDOsdqIS1D0=;
 b=OLnbl4ZfGhU2uchOnwxV4AJbgi5lZvOs3tjpXyQVCgSzeg08w4c4HG5A5WQhba+3np27PVrHmyRYUuevdvxfde6NwMWy6+6vs2ENNLA9yo197U+9cHLv43xae8ZggSugHn2tiDgYqbANzhCS31wXsMqkBBcvngRXv5SEN5g9FoIh04nzqt9xf6l7ck1nDTCjGWJ+xkRJyNvcrbrB9g+VGSdlHYNMxajlUnGjD1ylDH3Wewo7iKvaO8YDGRNJBp+X4qAw+xYgGuT6Hp0zPPF2vHbnHGRQ1bikVUZd3WnBk5rOORWBj2UTteSqYLpdEQwOkYfovjhmD1CbapJeyz9hDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hld5ANLKHBh7wce0DfdlkwlS6Bl5UeGtZDOsdqIS1D0=;
 b=UonTvTXy9HR8wJmr7sI9a/l9U7TguaAk6x7fRC5i5NjTAlJnDOt5WDpMimHgilZrn0nPUbNYuQS3eOjsxXQ8DYLAJTk/IbKYKMWaf+eAiYWseENa/qh8hVJMl5YixRhYwQxdVtJcGBqzTWD6HTMjAAgg4qRGDoq77893xk0jWdQ=
Received: from DM6PR06CA0023.namprd06.prod.outlook.com (2603:10b6:5:120::36)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 08:21:24 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::21) by DM6PR06CA0023.outlook.office365.com
 (2603:10b6:5:120::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 08:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 08:21:23 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 03:21:19 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Felix.Kuehling@amd.com>, <stanley.yang@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption
Date: Mon, 21 Mar 2022 16:20:59 +0800
Message-ID: <20220321082059.22573-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e08cc08-b712-487f-7b49-08da0b13c96b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB34013A5127549D196EE2CFE6B0169@DM6PR12MB3401.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BDhd/pu7axtB8uxqdpC+TkhLTTVCH1QSSdjXHC3NaapwSeTfFaVjzmQl5U2ssRMI62bTOp4if3soSXkAhtGfx9UDpFcvY+3Fo3s018QDc0L0aMUMHTVnqjES0qlmv9/Ch3y77wzrjemrnWS8sVXyjudQe5brhK6cTcUn2mcEdtCQ4mp4OHmD4tPRoXcC+438lQwX7SsTQcuwnSZyXdjPX2iNHQdoKS3loGiYavm/In6cr5E3mb3GhHqekGOBCo4uIC5CQf7FULtQA189o5C3rTOGh8aVva2VfIhRQhOB8y6jllUf4U0NqUUT3pURrBKcmV2xAKLLmmJHxO8mtUiiWTKCYP0KagtNsqTs08QLZ4dYMQbhfBcGBdWOm+AP+u4BRy158c6eX/MSmyzj7VU9/Nav4rfd0dtVTxmxUNvDgGZv70ZCSeRizAnM3uIhoe7VT5h/UdOyVQb6oGgKUmiEGHqKn9WwKqwh3ymoBRepyT2i83NyxcK16AWjYRntJ+Siytpg6KQAjrUsd3dzmkbsGIj7JdPi15PsnVLufSJwyWwUiJr/1oU+3zaxFeAq0xJkIgrptCasgb7xDm1KnXJUcJrD8BDBybjeb2TQI3vYQyfdjW2GcLV6jnpoZQ5g4blhbNZdB4ze8ZzCUpo/nqwOIHxZZrxPPfPZ6rtpojspxFpKtwDD4GOo2qsElbz9nfXMpDX1cynnHRC3d2zHC+Y2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(82310400004)(7696005)(316002)(5660300002)(356005)(26005)(186003)(81166007)(6636002)(16526019)(47076005)(36860700001)(40460700003)(336012)(86362001)(426003)(1076003)(6666004)(2906002)(36756003)(8676002)(508600001)(4326008)(2616005)(70586007)(70206006)(8936002)(83380400001)(110136005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 08:21:23.6801 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e08cc08-b712-487f-7b49-08da0b13c96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print the status out when it passes, gpu reset message can be observed
when unmap queue fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..c2560f468a04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	if (old_poison)
 		return;
 
-	pr_warn("RAS poison consumption handling: client id %d\n", client_id);
-
 	switch (client_id) {
 	case SOC15_IH_CLIENTID_SE0SH:
 	case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,14 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 	/* resetting queue passes, do page retirement without gpu reset
 	 * resetting queue fails, fallback to gpu reset solution
 	 */
-	if (!ret)
+	if (!ret) {
+		pr_warn("RAS poison consumption, unmap queue passes: client id %d\n",
+				client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
-	else
+	} else {
+		pr_warn("RAS poison consumption: client id %d\n", client_id);
 		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+	}
 }
 
 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
-- 
2.35.1

