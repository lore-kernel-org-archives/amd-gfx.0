Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBDEC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jan 2022 07:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7461410F885;
	Sun, 30 Jan 2022 07:38:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5585A10F885
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jan 2022 07:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buSXjyKCHHWt471oKKap/Eus9lMuVgW3K8wQxhPFdNsZYu+PkmTwndCcHXkbrHdQEsEdYbO4U3d97W6WnrCEkKKIeA9eNG5RIlNb7u2umaNFBrM57d41Z9Yxg9nf73y4BKOD4NIt/c6TGka7OgB1L5i2fQeT6YjcgF3DG91Ru+GZ7SqsdGiCxEipkr5Eq8vGQTpT1ees8lmzcASyC06KQGBIgURJhoGoc+mufwrXQj15UX+1rxgMPARWImXmMSrzGQBLGRIlgg5jzx2KXc9LefZDEw+Z6CSqmFdgwRRVuRr+Fbau40wxNoftEVtxW1H2GZAXgdWheN+wFzPospgfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUeEUHxYH3lsJ41DpMtLl4dhFKoHWJu9HlfrHo7Kjrw=;
 b=U4FzA+eRXf18FBXXTvpd+F03JWtpoURfJMHl21JaK+bFOyJn+Buvsk+E6fcG9V3Kgus1ayvSDwy8om98uoGe4KZ7EQp5gcelMoG6jduc4tQ7mcBI3O08ct9/4AbObOFm1gr50zooJJ8SmiMvQdDAaWmTX0I8BX/aZYLKPEEfV/5eeUa6lLUMmrciqeekkJ0oWpd3USzCpFbVVSQTlyQjWYc/qbt4gMl6w65uqGMsL7urKOic3u/WQwOe5jNdmMkd00ReEdM0bBCbRG8ULerVo4lT4WCfrOlnNcqByxGyt32tCrP0hFkmAU7R5t4erMWxwoazujgvgxb1HzmfeeAkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUeEUHxYH3lsJ41DpMtLl4dhFKoHWJu9HlfrHo7Kjrw=;
 b=MI/SukHOLTWLG/3J6iiiXTQn4keDabyBaA+ZS0W9X1nY672P39ytnLag2O4I4ZMKk1gxZj2NwubuKuVtnl7A2ngG6DQHcqmCa1+1CVjI/38HVwrX7soukzlG8PQeuSsBSQHPfmKCkkHtjOV4A4IeDjUF+rH3pZkOVea4BYLlYy4=
Received: from MWHPR13CA0043.namprd13.prod.outlook.com (2603:10b6:300:95::29)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sun, 30 Jan
 2022 07:38:45 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::51) by MWHPR13CA0043.outlook.office365.com
 (2603:10b6:300:95::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5 via Frontend
 Transport; Sun, 30 Jan 2022 07:38:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Sun, 30 Jan 2022 07:38:44 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 30 Jan
 2022 01:38:41 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <yipeng.chai@amd.com>, <john.clements@amd.com>,
 <Jay.Cornwall@amd.com>
Subject: [PATCH] drm/amdkfd: use unmap all queues for poison consumption
Date: Sun, 30 Jan 2022 15:38:32 +0800
Message-ID: <20220130073832.17226-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b748ee6-5114-43c1-0f86-08d9e3c38b49
X-MS-TrafficTypeDiagnostic: MN2PR12MB3263:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3263F5A037C664C1B4ABC2FBB0249@MN2PR12MB3263.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7nCwZwXQ7YmXdpIxFdfUxMBomNgxY8+fHrQCv2ZrfyweNx0hUjybVVDcpx5ShDatonLRdADRqtQld5KIysLDr3qj++LywugK592mHnY9YKiTsoNZzybuvZ4rGL8D6gQOawBWxaEzJlAYb7wIiH6Uxw0+dUXLrg+/g0IAG9xvtTMWkqon0udJsEmkQ7JzXR1eIDWg71MfSNKZaWKKHCKnT6AOW3bJF9CmiBizL+S4wWLjpwScKAcrJiK+tVYAM5QF8LHrEGRvTe/OcmWfovREA8ceqxITQ/FGUt0c/HqtWKegsWRPshaRHP7C5nriWA5maRWr92Tl/4C2FhPn4m/WHc8+q9ZwrSVnTFjXpJ0u3bqBI7UFIkDGel+I9239oMRRBf6sa1tzuzzKi1gA9FVumjQ1VdwItQa5M4my6PklqOXrDSCbyyf0IfEDfFqWE0b6qQdD2f5abCYT5F+lKH6Y7v3/mXjRarLIZ964gnZrKhC7DoQ2SddN3CnAa457Eci+1qbpAaUwwhklsXvZAcbss183nx9mKPhKw65vOmP/OmACOCBsN4z4UFA4Pzx56aSy02tMFLkGAF3iH3zUMyshHtcMtZGEb39guzvd0IEhOzZdiprMAGVeLnP0iglEov5ZlVOkfGOkjlWf2ooJVLrX7f7iaHjY+MZTSk5F0p1DOo987vauwM45Fb1VwHFNZapTR8vn34Xf4XdlbxRT4/qRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(70206006)(86362001)(70586007)(82310400004)(4326008)(8676002)(508600001)(36860700001)(6666004)(316002)(7696005)(6636002)(110136005)(83380400001)(426003)(336012)(1076003)(26005)(16526019)(356005)(81166007)(2616005)(47076005)(4744005)(5660300002)(36756003)(186003)(2906002)(40460700003)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2022 07:38:44.2866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b748ee6-5114-43c1-0f86-08d9e3c38b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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

Replace reset queue for specific PASID with unmap all queues, reset
queue could break CP scheduler.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e8bc28009c22..dca0b5fac1db 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -109,8 +109,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 
 	switch (source_id) {
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
-		if (dev->dqm->ops.reset_queues)
-			ret = dev->dqm->ops.reset_queues(dev->dqm, pasid);
+		ret = kfd_process_vm_fault(dev->dqm, pasid);
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
-- 
2.17.1

