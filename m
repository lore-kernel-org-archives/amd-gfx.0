Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 07:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F4010E3C1;
	Thu, 20 Oct 2022 07:27:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8E7E10E3C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 07:26:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2qFBuyk1sWmG4DChF24izL3neLyyqB1DHv3yN0semLdUrcBavTXnvZtaAd6JWWg0h9SRTtvVvTlLbARbTWx5J5XMIfWcLQbUJMYgrsOxoSK546vAsuPVvyC6CIJhs9xvHYXlVUgNKJJMjQhnf/w89sUkLsEEMhxTMMEyJdnL/7BnRg2bLqIUvh+dRulrcGN1mLkix/d/bdehWIb0jvcEmLqzX76Mj/UBsIwCFVV+ZWIqGo49aNWqek4XhyJISWbXP3owsHGWvwpYHx1Zx9gcfeBALfbdww2LeY1vIl2KLTcAjiAsoHs4PfMEg8z4p/OAP4XSc+myg2xsQKr1m3RTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPnRYQj/T0MKsreEkIfx1S6aXhXtzLof6FhX5HH8Yi0=;
 b=ad10O9S7p/tzW/mZmDr5Z4LgNjn/BZNXcaTWmR0/0jUdVuoKoc7oQH1/sfc5FvR3o/eEShsJTeGss1LW6H177XNuTJsao4Jknyqv4k+tqRLKsh6k43IBh9SdTNMO3WWKegGZHjchDd8Y1r5WA+PGBCCMzwfZcKe3jFoN9W2Mmf+ep4NRmJHzmmG2GyfHqCJbI9qsEUH+J8N3AzdQtsKRtq1UguAdOChSiUlZbUc/kRFOhJ/fZoyVFzMq+P/d+rBtZyKIM1bfvRAGnAbg+xesjayMtg0/rIGFZpWqqI1jFraGid3YjWYZOXdedw0n7jhFG+jB9X8yNG8FsBYNgvIG9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPnRYQj/T0MKsreEkIfx1S6aXhXtzLof6FhX5HH8Yi0=;
 b=i9pX2wmWZ9DL99bGrBu27nr/Ha2Q7BQmJlToAMuK0sXlnKJfxXZHgp8z2KqWidy5lwY8cFxuIN+PZ3tR8ozBk4jhyCnG5kNs3rCsZayKEOzz3ObbWPu46bkAcLsJcCUY3LpQlE7HN6lmlUNwLKRxIt+hrNxkDCAtYpvlZNcittQ=
Received: from MW3PR05CA0007.namprd05.prod.outlook.com (2603:10b6:303:2b::12)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Thu, 20 Oct
 2022 07:26:52 +0000
Received: from CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::c4) by MW3PR05CA0007.outlook.office365.com
 (2603:10b6:303:2b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.11 via Frontend
 Transport; Thu, 20 Oct 2022 07:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT083.mail.protection.outlook.com (10.13.174.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 07:26:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 02:26:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 02:26:51 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Thu, 20 Oct 2022 02:26:50 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: allow gfxoff on gc_11_0_3
Date: Thu, 20 Oct 2022 15:26:47 +0800
Message-ID: <20221020072647.870692-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT083:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: b08ff311-7f0a-4a08-2825-08dab26c7571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3CviFQnIWm+sWRtzD8JFBqzCKyeHfaIvagOu3ionV9sBO8TjB+CKLNkpvH/QCh5/svG2pioXs/q6F2A2jRwG+GWUZEuWZPacDTQz+IgkyHu/CyLxaM3dovl7BEggdS5nAdunobsbQcdACucAWIZWllditSyVXOH3oW+EM1kUcNxntkMkIXJ4U58KTmKYQHHaQY82T/hzRBNOF9nLVo3QmhwZQpLLYNXFbJbEp3Bft7H5bGNB+xX6Y2uX/ocsAt005qHN28+HZbkD3eZJ8lSdIKeCc6HAXt1vtURqonmbquULXOJuMl0umSsjnbagcCHb0Y2RRHuMKTOx3Af3jx4YZGnf7NBOZe7yq500JerzKvp7vetfB8r4DX3OyQ2H7b3eK67gXvZdmVV1RJKh4bK1oyUP7n8m6K6nnvc2qYR5w/5GaLjFffTKjBC096KYEytn+uQREg+/iaSWAJNtW6jJyx8+tDYNbZSXvBI5yxBXar9nEvkFviG0/pfGzKTQS00YMPtcNkz/q1uJE1xI/lrO3pTMRSxMQV8+9NmgbcHM1Y4Wm4u57Wj8TNaTWlQTeqKS7FHf2DYTQfj9gMZo8Y4ceTQEEJXdqLjOaQZZRjeEKqp97PcN9kxVcGihhFNIDkavw8S+7b6VTMhAksRNomLzyqzr9L0lECMQaYsyG9LyXSxzTD99cBjM0rGTCW45uoAY/NqWHxkF7kWm6mgfOs6TETCavugEXNx4NoZJP/QD49HfmpYgsJme89nUBnsUSP9Ke6qZq1zhDimiNgjhC287iB++mJMUy/7sXptsqQ5SKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(426003)(26005)(336012)(36860700001)(316002)(1076003)(82740400003)(2906002)(186003)(40480700001)(40460700003)(356005)(81166007)(44832011)(6916009)(82310400005)(36756003)(478600001)(2616005)(5660300002)(41300700001)(8936002)(86362001)(7696005)(70206006)(6666004)(4326008)(8676002)(47076005)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 07:26:52.1190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08ff311-7f0a-4a08-2825-08dab26c7571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

allow gfxoff on gc_11_0_3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index e3842dc100d6..5eefba2948a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5051,6 +5051,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
+	case IP_VERSION(11, 0, 3):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	case IP_VERSION(11, 0, 1):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index b7b59e04a44f..fff4d8307bb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -840,6 +840,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
+	case IP_VERSION(13, 0, 10):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
 		if (enable)
-- 
2.25.1

