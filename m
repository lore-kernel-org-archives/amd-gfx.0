Return-Path: <SRS0=gBm/=OQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E437CC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 13:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9736261019
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Sep 2021 13:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9736261019
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F2F6E520;
	Sun, 26 Sep 2021 13:13:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 562766E520
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Sep 2021 13:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZogEJwQZ7+T1g6exkCACp6Ev+AfUfWpOFbj4o9eDPRpaQ8BJaFdPk2bbSKfFmAQx+OTsn6/fzxq0c8Bzlo+nk08AekHLD25ToQL4/AVgPAgrp9sdhzRpUEwtPaATB5VpUTjNDGazCKuMRBGdQEBpo0jHu+6u0c17kIG2k5+b2vVL608btsDr6glxaSlKtEeW+0T5I4NbpHWF29PdUv3bgE1PfpmgDiJ1kBirDApAu/g8PQnVoo1ePsNDYAhHxLkApaMeCMrJUBZO/Omjk5MV6OsG+zauefSGQdWtlDegUa4L9a+eYinRwDmUZFluhb5BZ/6Z73W35WHlM2+s9FKcUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=s5Hj3wtuRE18ZuWuD2lZ5TaKYzDuk9KERQC/lfSHIRk=;
 b=iOmKfYRJRYxY6SWvTvxvD+8xxSPqFJEGYOkC+R8DTkqfMQwOshAxtrhRJmwXr0IqE9ieuSs28pAXBA3rKz+raBLeSqfKFvk2ChSnaffayGTSWxPUIml9WqTucFzdgNZ2g5Pl79Ec1YPFXFtCGGdQdlQJJQkkCWSlE6AwUCx/09HyuP+PuAWdlvvYXCldn8NIOgKgc6QLdUp5FEJi2CKzfdQNCj2vgnNi5ngDyhWJj6PkXtdkYWdN8Aj3RiQmg0Rq4S/SHTKhPdxzVmFb198Ie06g24xDQau8BfE5H3MRWRjZlG9I+UmU117lIWhxaaqHQyqHst3exjAtRDRGvKrmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5Hj3wtuRE18ZuWuD2lZ5TaKYzDuk9KERQC/lfSHIRk=;
 b=HpbPfxLw3ZcyYSTuAO8cOC7kZobuhMeGd103BRs2qIPA+JVJkzPzyYralwpIJvlF87yjy7MapueK9SJLRhI6tmkl1Cz5QH0JjZ+xeiOdXnkpUWaIsZ+ciqxG2rRzqboerTh6hjAupvx+Fsp6qoadKPJT43762csrvVnIm553d2k=
Received: from CO2PR04CA0053.namprd04.prod.outlook.com (2603:10b6:102:1::21)
 by BN8PR12MB3059.namprd12.prod.outlook.com (2603:10b6:408:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Sun, 26 Sep
 2021 13:13:53 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::42) by CO2PR04CA0053.outlook.office365.com
 (2603:10b6:102:1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Sun, 26 Sep 2021 13:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 13:13:52 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sun, 26 Sep
 2021 08:13:48 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <ray.huang@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix
Date: Sun, 26 Sep 2021 21:10:43 +0800
Message-ID: <1632661843-3923-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0989942-f0ff-405b-7229-08d980ef7c7f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3059:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3059A6A83908B3A601710D52FBA69@BN8PR12MB3059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4L1WlRVnqhurTzlXjmg8eDm7HdZmaymY+g1pcLIRUfDEakg6t825dFZrAgd7mCkDx65NvCClryJi+4WEcgh14kRkNcayROl26Fbwb2YzIWeU6f85p0mp1NSJWGm0v5L9CvcEmwWZrv17CcYOW1l1qRZpREzLZ3lXxcXZBjTny1Jy3eCM0k5k5S3FqMq7ZGQ5ZfU8uOjJepgM0XYp7O3M4n7R3RfvGOHDH4Sz/4k2hUU7Ogzr7zqvN/oG4cYlKDhN2Gw+xx6roODAk+OKri5k+MRyGZhkKe30y8J4VJtKUIM+UUGeAqn45vcl/0fJnwSLzgQSqLSceMkaiQBdRM5heB4olyPUuH8W7sRiuz/T+dVtg0H1USSugyT96ERNbif5Shy5IKoLl7W9JrVuze0S4OiVN08gs6R0b93qpRiKMr9GAjcWA2o+yuNEm6nVOJapBDQ52EqenxBAEQyhBfHmXiGLM1JhkuBQwtRuxuV1O/Vyrk43+/nutEnLkjLTWNjLBiDWhNWwJjCKqZGwVXsMdgChLFBeuVoXWaEA57wryhxwhquLxcRlZ7PNt6MrtcQLm/82JoBS/BBG6lLJtPKAHbhyuZSHuSw5NsKJPRIck9gsOGnJTPBg0qYXNUYOjXhszvt2jsYhuYe9ubdIKC7Xsmx5GSSkpq4nG9xcz/Ec3SJfTjVSG80Kf1ojaPeJEVhm/O/ZVOjPH4JXmblfxtBA8D567pfTI2tdTWzUMNpBHjFSVY9nCb09dUHOwoAoQoDk8u/ItgBVlPElj0TroGjJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(508600001)(186003)(316002)(82310400003)(36860700001)(16526019)(8936002)(70586007)(426003)(54906003)(81166007)(8676002)(47076005)(70206006)(2906002)(356005)(6916009)(86362001)(83380400001)(26005)(336012)(36756003)(6666004)(4326008)(5660300002)(2616005)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 13:13:52.2392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0989942-f0ff-405b-7229-08d980ef7c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3059
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

In the s2idle stress test sdma resume fail occasionally,in the
failed case GPU is in the gfxoff state.This issue may introduce
by FSDL miss handle doorbell S/R and now temporary fix the issue
by forcing exit gfxoff for sdma resume.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e4a96e7e386d..81906955ef52 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -868,6 +868,12 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 			msleep(1000);
 	}
 
+	/* TODO: check whether can submit a doorbell request to raise
+	 * a doorbell fence to exit gfxoff.
+	 */
+	if (adev->in_s0ix)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	sdma_v5_2_soft_reset(adev);
 	/* unhalt the MEs */
 	sdma_v5_2_enable(adev, true);
@@ -876,6 +882,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 
 	/* start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
+	if (adev->in_s0ix)
+		amdgpu_gfx_off_ctrl(adev, true);
 	if (r)
 		return r;
 	r = sdma_v5_2_rlc_resume(adev);
-- 
2.17.1

