Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C49C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 10:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A016010EA6D;
	Fri, 11 Feb 2022 10:15:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 313A710EA6D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 10:15:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKLy6Ile9SoKVY8QkPtZ6rUAHaG61Pu8u1DjAn/oJd3WoS9fsQiUG7OtiQizAJlPx2jdu84V75nIvBIFhWT6vuwmSuQlTRaDA/vMFBaxyUXW2o54McsgTOW+UqL7AycNO2afTdPWuvpkre095mYvdU/weG5QDzvj6jLsHpq2dCtESYcDj0cMRgp+sVfl/dIAYlrN1fRRREujIZMqVCj7OtMLkUiE5z+9CeYC66LOs4ZJAu7Hx3tN2TJYHTULe4cXgbn33jbHwnpoR3Df9MxLUX4C3nQnaKEdzooMQ39ZJZ7Z/vYpXXDsVseeZl8WtAKwjeRbXv8hz0qckOTjx1qEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWy956jHXQ7krBxynkRYMKgFw286jVEG9xf1wEUvqhY=;
 b=np6xoKjq/t4p0dJZakC9UK3w9kT53rVf5Z2Tkbd+H0eGxIFbhKwt+AKhCWsZPwloHtC7Q2pWGoEtYlnuyrPLuG9jlrJfrFU+b8QVK2lR8o2TwvASjUszpvD4HU5BujSR8g3zj91gkvLRTWCnr/1pTkSDF56D795AHxH0hoKNUwKUAqxepdPPJIpb07A7R2kCeFr+TV/FxclkA7nVDLX29o2LcpLEICdG7ea6vVPtQUKVB9FN4YnYiF+OpHP0Vl1oytN1IUOrpa86GfoFdIPKg30MwJwPwbyzuIS0kR/iHLkCKVeqoth9Dq5qS690JjgTfA3QHA0sD+Mj+q9vxvo0sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWy956jHXQ7krBxynkRYMKgFw286jVEG9xf1wEUvqhY=;
 b=uqf/9Xr5u4JWMqyNFnavuKf6Re3msiIIZ6oS8BnRRLgxcqoeNeLIy6clfln/+Pu8GcI4rTmc4eI3BowAmKenTREO0YKL/XierCxgGC2lSlqlhYEyAWeSgbvxuO93qYyhEMrhosrR9y7rAzA05JYEtVzppSoS2d71mWkjpXtNLBM=
Received: from DM5PR07CA0053.namprd07.prod.outlook.com (2603:10b6:4:ad::18) by
 DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11; Fri, 11 Feb 2022 10:15:19 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::c0) by DM5PR07CA0053.outlook.office365.com
 (2603:10b6:4:ad::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 10:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 10:15:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 04:15:18 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 04:15:18 -0600
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Fri, 11 Feb 2022 04:15:16 -0600
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <John.Clements@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: adjust register address calculation
Date: Fri, 11 Feb 2022 18:15:13 +0800
Message-ID: <20220211101513.2189-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfb6f88c-d87e-41d0-a56a-08d9ed4767ce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4468:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB446830699A0E1FDBF492DEE39A309@DM6PR12MB4468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7MnbBLhNlFs65Adjfn/YC2csuVTYvAyPTEIUSrSAIVhCx1CmY/HvFUXmvnrYUmTV17IB1l7ZI1v57Xnedcw3JeM/QBrGOYjTIwMrbb7DOm06ULwrZrMhke1Bj5oC+0P/3yJaptpweoJvKTCJoKYVacog6dJrLai1cDc3H6xvvNLZjuXUKTobeliQY5SU8H1kPdwdHz/eWpdrR3AB3+NTpGtaN2YU1oEs64PT9SeiKlk0f7AmMXDSExEGOuKtTA9gMjDZZJGcXL/qxRsiUgJYvt0j7iUfOscPPI9vYFOVnlPVNRxMkQVNg/sfpi9RQPmN0A3IP3bUzHhKSuviK3jUyBq0p5vY4LK3nxFCmvT2O7KZYqXeSGLEWrVTwmaueunjlKh3/Wi7rRHX15sYqKKtcGuxcEp+Evxn+TdIlB8tE+sWdRVq/jYAw6/XR6nZngRtyGs4sqcakcYg9OmJpaRMj/j4u/J7zVpqH38dZXVY6MaSOMs4xBj/59IaGl+4y/yHpLYHuOGy0YhNhliefbC4+y4FnBML6REbSn5OY4t4vucJVbE0xFzKWcVm9upmqBJ9ZLf6dEviSTIyj/Y7lK5qH2G5CPnO8iwqKbSYU3+Qokhh1vqpt6s0Gaz3AIUoHHpQh+znuU1ZCwxlMbSnLs9pXHYHqKHk4wqqu7+GOm7w4qoCABqHoznDukJqbnoXFISyEY98TYP6xeaMq7+YFJr0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(4744005)(356005)(2616005)(7696005)(5660300002)(81166007)(82310400004)(508600001)(36860700001)(110136005)(6636002)(316002)(26005)(47076005)(70586007)(36756003)(40460700003)(336012)(70206006)(8936002)(4326008)(8676002)(1076003)(186003)(426003)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 10:15:18.8599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb6f88c-d87e-41d0-a56a-08d9ed4767ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the UMC_STATUS register is not liner, adjust offset
calculation formula to get correct address

Change-Id: Ic8926078301848330babf289c4238dc8cbcf313d
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
index e613511e07e1..87e4ef18e151 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
@@ -47,6 +47,13 @@ static inline uint32_t get_umc_v6_7_reg_offset(struct amdgpu_device *adev,
 					      uint32_t umc_inst,
 					      uint32_t ch_inst)
 {
+	uint32_t index = umc_inst * adev->umc.channel_inst_num + ch_inst;
+
+	/* adjust umc and channel index offset,
+	 * the register address is not linear on each umc instace */
+	umc_inst = index / 4;
+	ch_inst = index % 4;
+
 	return adev->umc.channel_offs * ch_inst + UMC_V6_7_INST_DIST * umc_inst;
 }
 
-- 
2.17.1

