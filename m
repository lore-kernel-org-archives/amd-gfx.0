Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999BC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2F760F48
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 05:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C2F760F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5836EDDE;
	Fri, 24 Sep 2021 05:21:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87606EDDE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 05:21:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCdujvovbwMf+FJWY2U5G2G7igiIjoeWq+6mLhXmvNYxWv0VsziMU9EGkaX7/xEuKUGSM5y9dkB/NkpdpBHjJ9iN0yQTzDbbp1DaKRwXq+z/23JEfJI1XtaV2/CE16adokRKp4SURwZ+ZUxKrj/2OB4IgnXLmbs7wxNCxjJTDzdjH0LqAf6Izbk//Lr5ErSbC4K1tbXWBWwk6uI8QnPgvcklUOVu/lZDM/t8yaPfT320BpwfAAPJWnY/591Qz3qHjMYsLWzjfibCaOs6sF93FjWvrO04KzxwYRj9ZB8kEfOoHnqwyO+rcFxTxTc1LS1s8+heBS5TeFGkxHyu6I6uqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Lc6lyMpkGo0V8b0EdtVqLbaIzY1Ue825iDAvaYWikKY=;
 b=SUJ+TntGDsz7mIb5WKwDlDRhUxtoytFyjZ7s28+LijA69LGKbst5Cp4KgiDNscN5UB6rwp92S44Q1qErQ7RVBVxet9GXoHjyNia05zsSxw3+c9W1Q+ziek5Ru3PrNRXdYs4br46ddkDrtpmpV2OMvj2WqbSj6ywsTF+ybOgL0jTqzo5z63A29zvHvuEqwmceCedo4JZzss93aL1kBS7pkPRXgCFRKt66gTWRXZkQeEueRI8kaMFh0hamOBCtz693AQQtflkYQLwxag0xo9h1zEDO85JrT2Zcosak8ToTua5z6wKxjl17S/Q+Xg/uTbcY+4zhw7WxEoQxEYS7I2lCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lc6lyMpkGo0V8b0EdtVqLbaIzY1Ue825iDAvaYWikKY=;
 b=mbezprM19KpCNb72jyMdZt9n5Df0NEG1ZX4mzoTf+e2rhcvKOdDrMJp1Y0v3f+JLJDOCNhVoiWscHIq0dfnhNqzakWosxcJfWk0GLN1eRWGEKzE8m8tPEwEvdj6hsvIX2yZVa46bVSHAXZUgBjE/VHdJetJmZVMGEMhfWFDHxRA=
Received: from MW4PR03CA0339.namprd03.prod.outlook.com (2603:10b6:303:dc::14)
 by SN6PR12MB4765.namprd12.prod.outlook.com (2603:10b6:805:e4::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Fri, 24 Sep
 2021 05:21:05 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::96) by MW4PR03CA0339.outlook.office365.com
 (2603:10b6:303:dc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend
 Transport; Fri, 24 Sep 2021 05:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 05:21:03 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 00:21:01 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <ray.huang@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix
Date: Fri, 24 Sep 2021 13:18:00 +0800
Message-ID: <1632460680-2225-1-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ced19750-83ce-4b53-0961-08d97f1b1ad1
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:
X-Microsoft-Antispam-PRVS: <SN6PR12MB476515806441E1794F2DA59DFBA49@SN6PR12MB4765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o959kJSkHeXR3+yLMS9VdrfG6yxODsey/O6YTImklHq5L4LY6SuzX0LBA0fzFMbPO6iwmduhXlB2YwagXXGXxzOeBjwvZgS8EeyTa3BpQ2z2nb7J2lxi12kwNLiM7SUea6ISnnNCdIJjLPl6QwnWkDikvTvL1PBzmlirwIjPdgtQrdcdOW+Zi++D0xlWj2sVDHyPGQW7GxFaI3LmT0QNF3cPG7Yj5kBChTzXn10wc9dZtqm55FylgesqYP/1ewYMQaXKELvIJMKjORw1e6eUddlS7E+O2O1wP0hcR0U2DZk64EChoHYUIbJYukqXAGdM2i1N6OB0ILqnM04FjEhkCteM9n9gILGsF9DxojWDghXShRrSr9CeEKel/D1E3zmrJ0XILeJW5qIvg3DXSEdGZQS0ATedFuhCggrz4HT7R2tPaz53Vx5SH/uArRJTZaq1RqKPEuK9UNrLAWShNg0qOIuia9qEMYaafnCFFkfJtNekoGN2fTKQK/kj3jZOKz1IJDUJrteCAlyKPWPsTkXs3gp3G7HdRHWqi1TBZ2MBBd5TBpffJhw/6JOA5WX6z6gOo2FEb0c4m1up7YY3kEuK81gVXDmEoE9riuOJ3uDoL64wJ0ZUpIUHQVUi2KkTJvuutGu/ngjDCRz8kVi9Bh5pzkSo3zfbxLeVbnNNUgeCm1t4fplNTD6G8h3nEsDJJOYW+g2TEEE0JpYf++j8eqP189v8myTjbMky9ixUj4ONZ9S4kYdxXyAKY8tVZZsLd+VlgnZ6OtFAo/Z1I9/pwIK3BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(7696005)(36756003)(186003)(83380400001)(356005)(26005)(4326008)(5660300002)(47076005)(508600001)(16526019)(36860700001)(2906002)(86362001)(426003)(316002)(54906003)(82310400003)(70206006)(336012)(81166007)(6916009)(8936002)(8676002)(2616005)(70586007)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:21:03.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced19750-83ce-4b53-0961-08d97f1b1ad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4765
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
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 24b0195..af759ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7608,6 +7608,14 @@ static int gfx_v10_0_suspend(void *handle)
 
 static int gfx_v10_0_resume(void *handle)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	/* TODO: check whether can submit a doorbell request to raise
+	 * a doorbell fence to exit gfxoff.
+	 */
+	if (adev->in_s0ix)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	return gfx_v10_0_hw_init(handle);
 }
 
@@ -7819,6 +7827,9 @@ static int gfx_v10_0_late_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
 
+	if (adev->in_s0ix)
+		 amdgpu_gfx_off_ctrl(adev, true);
+
 	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
 	if (r)
 		return r;
-- 
2.7.4

