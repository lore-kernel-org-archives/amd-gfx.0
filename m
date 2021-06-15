Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6097C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7879E61443
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 10:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7879E61443
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F65589C1C;
	Tue, 15 Jun 2021 10:04:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4AF589C1C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 10:04:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/5oSbDGzQIRqv5ucspJQpL/CXb/aJUegoz3NViAEzmCYeN/AzWYRU278DyvPLss2PEP0MebsILbBy7IJP+f5O1k83zypoM0KeZpoVE3h3uzX/o3t1uknWaubZ0uFuzszkXxkpVKM4M0RpTXPVyvrUe7mKk4kYoxJ9Yx7usaKeNEuTOAxjdVup/686pENkZrw0CRQIv0lM1q9uO4ifNtqnKydZsY9U5jTBiZgA37PSaUlRxZvpnwXQlxQbfKstcsvoY6QmX3WMNttL7qI9lCOfOr8HNn1sF1PDvrRjrPv027O66SbvYbOwef5JUcIjfCYzNswmDWr6n/l9XjwZqMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfkGAPy2yZQ80ZgrI15lM6xfoXL34KRcS9mB6jVjo9o=;
 b=KTiC+m3uWOJFBuHLEcZ5EFvDp8yFmfUlNNlSwvbmEN1WM5h1Ui9Y6nU7655/6G5LPPCUluiablYFThY/FvqN6yF4ftOw83XTfugUHixRFA5FfaXBbtUw7MtYH+Lfs/jpvR4BPtIKQDdZXvl5XULnwjKIcO+dmpspkO/kINfwfFVDyhBt4f6plZTDtXDHosVi2Tj5FJS5LF/o2h5Xom3KrS9O8EoGLkxDGE6qdeZXCjGSXNNKbILxoDVis0yZO+rfXJbvF/3UuZuVCeao8DHPh8NGoqnh8Hlh68wf7HfmwXc6TkNYxmbhV1812HSFX8ZvsQ423RpVMb7/oB2FvoB2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfkGAPy2yZQ80ZgrI15lM6xfoXL34KRcS9mB6jVjo9o=;
 b=hZFemaMwHg1tN8JqQyCmQabJ9EXjlpEbd+wnFMgqRfJzsB47N7C9vfkvNfzMSDl5Y6oHZYD9jCFbbzbXOGd/gxudDq0COqJrQN4edd+SL4ovg6Eh8lnqL29q1AoqLDf2cWrzi9rvMyiiP7smErEFNKNqLNFDy9E/cYWUsJpJ2gU=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 10:04:18 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::4a) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 10:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:04:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 05:04:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 15 Jun
 2021 05:04:17 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 15 Jun 2021 05:04:15 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: fix the doorbell missing when in CGPG
 issue.
Date: Tue, 15 Jun 2021 18:04:12 +0800
Message-ID: <20210615100412.1334220-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4613a77a-7b5f-465c-cde8-08d92fe4f03b
X-MS-TrafficTypeDiagnostic: CH0PR12MB5108:
X-Microsoft-Antispam-PRVS: <CH0PR12MB510897B98F23E836806EE103C1309@CH0PR12MB5108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uL/AkVurmrofi3NDRlSiI26mOW0PTn+RPOL3QkJeAqDcUarqI9EP9u/gAS30HPhQrgCNnoQ7jjXpadJKQxzt4R3T+H3RAQJnH6Q1sMYBbLYXNktaiI9X8sxijNF9VuK6tax1V73FtK9SWtoum2h34DRESNcxpXer8vKFbP7urQLc3uRM7lfEAJxjbZPrVBMPrpDCXshBQROfTIVgO9HQu71n0X287kPtdUM0HHgIWna/iUZyXv3ZjioLiGXXc2cQ+TKxkZJgkdTOfl1u9CIzYc5y9UV/O6oKEY8FJ7gD6O2aLRPMAmPr4wHkSQFN3A+RZxGawUbtUjriD1bA98Q45WQVha3iEx7V861MweytmzgCI7bUAv6irN4iBi1hUqb6nTP0oLcoh7SG/NlWX7eHnA9NFvlPRBoQudJmUzRXMPmPUd6oiOuu6qG7cCfadFmo64YKTyzl2q6Nt/HK18MoYtXIOV6vCF5+p7JDK5fAs5UW6hQ28ehHummDl0G9LURrZkg8QWTyl2TXvw/lW5MZch5D9A9L0h4VUBx+/O7tEVKHcvh2Zjdr0zt/Y9R5P0vVW/EWUZFfP4OSbgngGW7+oY+b4VPfwHqIRlxOOMRTKwT2KjK8/fjb/vRyK5W+17sKDRa/gz74uHNcznwW0z26OkL75mOZyV4wJ7lOSIcUATsjsUI7Q8/MMfN5I6pLQFY0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(82740400003)(1076003)(81166007)(7696005)(36860700001)(86362001)(8676002)(54906003)(6666004)(316002)(2906002)(82310400003)(5660300002)(26005)(70206006)(186003)(36756003)(47076005)(6916009)(356005)(70586007)(8936002)(336012)(4326008)(478600001)(83380400001)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:04:17.8696 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4613a77a-7b5f-465c-cde8-08d92fe4f03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: Yifan Zhang <yifan1.zhang@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GC has entered CGPG, ringing doorbell > first page doesn't wakeup GC.
Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround this issue.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..922420a2c102 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3675,8 +3675,12 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 	if (ring->use_doorbell) {
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
 					(adev->doorbell_index.kiq * 2) << 2);
+		/* If GC has entered CGPG, ringing doorbell > first page doesn't
+		 * wakeup GC. Enlarge CP_MEC_DOORBELL_RANGE_UPPER to workaround
+		 * this issue.
+		 */
 		WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-					(adev->doorbell_index.userqueue_end * 2) << 2);
+					(adev->doorbell.size - 4));
 	}
 
 	WREG32_SOC15_RLC(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
