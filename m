Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF70FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Feb 2022 07:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E37910E723;
	Wed, 16 Feb 2022 07:25:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A531210E723
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Feb 2022 07:25:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHZ9TrJ2pE/WM8f90HE5zUf12N+ekGFf/0Xu8hXi6iiKPb38dzQ2E1tBmtCBNGRx5qS5Dvh6z+2zeZfKrZ1W5pSR21SQE/vuaflSciIxZh2/0iE5eoqT+HmADxb/M4BoL7Lpozcat+RnXRVWaPv8zEJ8HTX91VFmkQXMAS5gVGn1HUP/jMkWrH22gmdfaV8xy4Hi13xcnYrBfbZ7gXSqdwdcSAAkHx+/k6ywnTwWNbAEjDGyinU/am1gx5/q7VBdvv2Y8zvQCrH5n3047LpspvW9fq8Qp3SUmkfQpy/pS+k/D2Mvn0wKJPGwd7ByR9vER9AoFlJoHG47FUZxVJhvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APjdBIaLOuQLkAGxDqWYM/0k5w3JyZqV2bfzACy4y5M=;
 b=WHQkmBLGDi9SUQMcgTUsWGKyECcbbw/ii6Ttk3alyBO8hQ94ZH6RXqRZxZNkljEv4rR9kb0rgZttD3tYwjhA7x28jIGHCoY6bLrbE2cJv17ZZsXcuueqNvQl89U1o6JymzF0uVXbWzVHk2mGSDXWlMLTZ5B4rLp705AoeYWLZpnbtx5gZZrrjgqoaPmOoojccLoRxYKY02rskDEB59UdmYsR9OQtYP+Z/wXRKUu9D5pGsu+9ZYC3Vjhb9qGPl3cLKsIbQOCIvaLIphh18jApzEP2N45g0EnDwPC2BMAAom06qoE/8chF9/ICJe0fF2mJP1zuXaUhs54xi8bfvBvGOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APjdBIaLOuQLkAGxDqWYM/0k5w3JyZqV2bfzACy4y5M=;
 b=4ocbx2NhTZC/KZ59d3NTkC3GYpgp2ZCcLnlsub7qQzJV/AH1F70C/EdJSpBq+P8YjcH7m30vAo6qe5nEiecCJFovMD/XG0oW3DtvV3Smc5MgmkZsjHqA893R723SorfdYtn1ETZ+m+uNPPyF8HP65yJjSIWspAkI+aenwPQSZ48=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Wed, 16 Feb 2022 07:25:12 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::c2) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.7 via Frontend
 Transport; Wed, 16 Feb 2022 07:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 07:25:11 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 16 Feb
 2022 01:25:09 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdkfd: add return value check for queue eviction
Date: Wed, 16 Feb 2022 15:25:00 +0800
Message-ID: <20220216072500.17911-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9793a729-e5e8-44d6-4d5c-08d9f11d7815
X-MS-TrafficTypeDiagnostic: DM4PR12MB5119:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5119F8B6426BEFCC8B832F4EB0359@DM4PR12MB5119.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8ubr4KdpM/c/tKv92ywFLZve+23jCrb7AVhZqrS60v+dTBEMuaoOWtlqYxpGmqOGNoGmhz46N9CVyu/CMomR1Qif6GylZtHw3bZu57jQEvgAmFGpU3JTCjZTPe1EiZ9AZPAgp1LwsIxvhRqExIPv9kIi9UoLwzGWMKWTLwWiVzRgk2IkURzGIiNO9nvVvEmlSs6hjphfBXBl/OotjRsjCrUURt8BtcqT7/Dpn0IKG+BQ87mwya3HTO1H/ZlwmTPGt0I6Fu/Jff/UD97ds4KXNUDCSQLKZ4heBWDXGgGmwBnnQ3DSqr8CNjC5KDYfm+k33VBaS5axHB2KmuLZxhm3LepMgOKO2wfMl2/mMGJi6xjtG/mxHpUgeP6Z5wgWrLMe0P1joWocWqm00g6Xh9cUGxZb0bK3rXms8JVnb4NeqjlYse4O7UprnJIcxAXRhCRieAo90utg7lN0g0WdZFuMBxCv4QFpL+R9y0I1Y2dGmch3UOVZqSEK+lem7hlZhAPb+/+b9Y3OkWQ6UStvlS+zm3CoF6imMcUN3tIinsR18v9gGoWytqQA50Ofq5t7tI2xpS3HvMQ2HkmRqK2qmhBhE0LhwuzaaR9zzDbYWflZaUunqXFRKaKBSa8L36S3y56EmhydhRof6+oZ1E3WdmRZ9GG9ixrXfIdzKY50rHrVnCIGGG1C4PVCistP7w6jyOCHR6bjlyuQ4DScIoa4iN1Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(40460700003)(508600001)(8936002)(47076005)(2906002)(4744005)(6666004)(7696005)(36756003)(70586007)(70206006)(6636002)(316002)(4326008)(110136005)(356005)(81166007)(26005)(16526019)(186003)(426003)(336012)(36860700001)(2616005)(1076003)(5660300002)(82310400004)(86362001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 07:25:11.9549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9793a729-e5e8-44d6-4d5c-08d9f11d7815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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

Otherwise gpu reset will be triggered unconditionally in poison
consumption.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 6830a88f0326..7eedbcd14828 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -110,7 +110,7 @@ static void event_interrupt_poison_consumption(struct kfd_dev *dev,
 
 	switch (source_id) {
 	case SOC15_INTSRC_SQ_INTERRUPT_MSG:
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		break;
 	case SOC15_INTSRC_SDMA_ECC:
 	default:
-- 
2.17.1

