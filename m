Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994DCEB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0809C10E1A2;
	Mon, 26 Jun 2023 15:00:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886E910E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NncpVLFrnFsMhQh8qYvwNk2uBJPJK8QUFOdSES9Z9SompI6a6CXWPITUNyTDUYPx29KGUXDPHxyWhrWdRrk2zeiUuk+c3+SPW+MeLdLco1dnCXWFOFzFBEyEopwHkg/7t4Uqwun0KMedzVowyXC22+n6jhS3S8pFkGLgswLryLE+FMJs71ZFyv+x1Vy2Tqy78hCa21vyC/KRGp8YYicjbf1kMue/sYFou9fPg8ERejfU4Aqrd2HElRRdeAgniceWNm6KsCUaRA4k+OZFF95vqUCEB9U/KrRU1lK4sec5CAbMzM+qET7i/D2HT1P2f9I6vB6GFneGz0SLa9DFhJLJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bP2xGFZ8zUIS0SJzSxf5NYXiAgYXwR+T868NlJcO6VA=;
 b=Iy9bEv/H+/997k8f/xKt3fsTa9/ukmmikGW13Ntbh2pOeSFsaqVlK83frz0LmRAobuBV+RB7dWZGhlGUVxZ+KqUSjDf6I7vpFsdWGXZ7LRhP33Gibr3y43UPFbGCUQtRMnZfX6ydA2bM/Ofqi3V74X4Kt+cCvpQSHEN51KNO1CRSRxecv5QzCvL6ygdByEjphhM3Um4SmMCzHpNsKZLl7glKCpRuJW9ceO58zC6LlMt5DG8RYMCOoYxM+53ZbtZg/Y51bMTSMHjHhF8xhIEctqIozrKiEgY//s7CiOICy3O7H7RWlAbGwj/3SDGTIsSZrTei+dbEAki1NKtWhTOX1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bP2xGFZ8zUIS0SJzSxf5NYXiAgYXwR+T868NlJcO6VA=;
 b=hytmN5MM1AazC6o5dZNI1T/i6o6bFiRZQYpjRwWvkt7rA8l8DQQydfPXiStuwNRXlCPcceuuVjNyf8kv9gtBTulPSpjCNFsBUxtFtNoOIA8o8PoEkLKdD4J0SCU6BD+15fM0UTT6rI+4R2u/9WJJ0T1M1ziU+vcrC452dMtb8vg=
Received: from DS7PR05CA0055.namprd05.prod.outlook.com (2603:10b6:8:2f::15) by
 SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Mon, 26 Jun 2023 15:00:00 +0000
Received: from DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::fb) by DS7PR05CA0055.outlook.office365.com
 (2603:10b6:8:2f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15 via Frontend
 Transport; Mon, 26 Jun 2023 15:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT086.mail.protection.outlook.com (10.13.173.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:00:00 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 09:59:59 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix a documentation warning about excess parameters
Date: Mon, 26 Jun 2023 09:59:38 -0500
Message-ID: <20230626145938.1393-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT086:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 20aaa4b6-751f-4e09-166e-08db7656039d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx/xpBVGZEfhXmXlpJgxhT5Tg2HeqbM44UapCUVIaZqrjFvDnuPgdjo0L6gxRVDiEKdC3jurR4dKC3OtaWac46PjYknc1G6GEDxwdwfqOYfDi7VESFphGKIFBdWEgYPmQMXsVPjiNZUaATBEmeLVvZi9WjrwJGJiP2J/1GJ7uSHzq0L1xR1374n9I5/XBK6w+G0LGbRH2sTZKzdxJwlxxJCVD/JcElVHQFByNQ6Nf/piqZoOXsa8Br9sM+F+JhL2Q0elNDBWJc3X90m514tCqqBpgqfe4aUxMzPDSFiiUAc55U9+oSsOrd0R4vPhJgDrzFiVgW/e+pihmAhqFx/NIu3fbg+YkJwtmdMdsQfhCvYXH0gfSqGRDCF1gIU+ARh3gRMFftxUfEjJsyUL6hjz6jQE5s3+rBN+eSc2yqVQ9g0YDIP12KcZcqw1mRXTL2aawbQWs2UZyWWuONJ6+wZO8ZU0nHJRVLiX38GGEszxfID7CA0h/N206x5j0nVWPtLiAcC359xLZ3oSskSJxzakEQJWe9lpbv7x8HK37YhVLJta4evSIFc3sy7ij+bafYcK5GOejK9EDhFNo2Wg6vDR6nAMWA7he2IZvEZ21p1GnrYBKcyAbeGg6tAuQLWkEDkes1HInhp+uZRrMGnS+MD6QeARX80OdMl0yQiGRHvBpCzhwzKIQ2S8mhuM18W2YkyMT67AUOKk5oowrnVuAOSHVUxf4kMjys6mLGeXNWawP5xDFD43d8Zj835WhYZI30ywRuYpWT6G8aQqYZaL244AKg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(70206006)(70586007)(478600001)(40460700003)(86362001)(7696005)(4326008)(6916009)(36756003)(6666004)(316002)(336012)(426003)(47076005)(36860700001)(26005)(83380400001)(2616005)(356005)(82740400003)(81166007)(8936002)(2906002)(8676002)(5660300002)(41300700001)(44832011)(16526019)(1076003)(186003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:00:00.2164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20aaa4b6-751f-4e09-166e-08db7656039d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

`pcie_index` and `pcie_data` aren't used by
amdgpu_device_indirect_wreg() since commit 65ba96e91b68
("drm/amdgpu: Move to common indirect reg access helper") but
the documentation wasn't updated. This causes a warning while
building documentation.

Fixes: 65ba96e91b68 ("drm/amdgpu: Move to common indirect reg access helper")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 65fe0f3488679..a3dae8ffbdb10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -747,8 +747,6 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
  * amdgpu_device_indirect_wreg - write an indirect register address
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register offset
  * @reg_data: indirect register data
  *
@@ -778,8 +776,6 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
  * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
  *
  * @adev: amdgpu_device pointer
- * @pcie_index: mmio register offset
- * @pcie_data: mmio register offset
  * @reg_addr: indirect register offset
  * @reg_data: indirect register data
  *
-- 
2.34.1

