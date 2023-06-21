Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2327CEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 13:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A849010E474;
	Wed, 21 Jun 2023 13:19:36 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D569310E474
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 13:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD+86div9XwkdbMHrVwVrhSCFZTI5Wr76lWKs5ExGbBV3+EIH+r/e/p6HCZWyZzr6DuZTVm2XI0vtkRaENPCqTAcJhwO/8DXaicGA7Tgy+n33F9+63diUnv9UKD0KKetZzG6krfoT1Jmfhs+xs+TQSJ3bnGw9Yzz6mx5SqFilMCp4mGoSve5WRRnhJe/heJrfDkWbnP0Gh5eVpZfCzMr5cfLRMl59DBUdYBxIvKCpYrXw8KZQaH9FcqKH6w+S4ri1zXkvuweOL64zqS0IbMZUlntlBOj7LL9emrSmh+6LrhOLtj9dvrD1Jvfrx3ci+0tukme0BTMQJjk7sv5frMFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUwoxtnU4rCT6K8eqvwBeOkdoi+Hw9/vtfMj97pGaIs=;
 b=HwLtJjPuH3Y/O+hoXSilM8Q0g3jOljvHEuGvsaMiZQZlUKAzU3VE+rcQMyy5IJtNYmuBGBvCWPBVjJxTdM1Pb0cNg4BN8CLNPa3Tw0tCL6k9WV4UywlKGsy/uJsntLZhdyZPT/sUsr7JM7HgxZr1aVWEnas3o+yB6JDYRHDHvaUHTxFfJnR32mz1Viq2Q3hVMEfxPto3Pk5sFIbDKZ+Nqw0xnMOg36De5X0cEhjj6Lrwe/XZv/2mCEURlZlvS7u7tiQJuNzFgWEFXuDpQ8LTln5sj//5zaAUrrOka/R3sYUlexsrBvAGuH6WBQZTtoleESDhIs9RT95u14kbPWUzjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUwoxtnU4rCT6K8eqvwBeOkdoi+Hw9/vtfMj97pGaIs=;
 b=tbhjo2VuifpAlbclTWil15NaoFWFEo20wbbOVeEWMpOG6Ci3nccjSzSbdoS65ZWD0J/lPqtRjtnS8qGm1H578xDmg24O+/i3tYUGuHJmkr96DPBM0URVidv4NICyf8dW82EGcZutfZY9tX7j4TdCW9Bn/NJmBbpe5YLbi+M54XE=
Received: from MW4PR04CA0072.namprd04.prod.outlook.com (2603:10b6:303:6b::17)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 13:19:31 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::cd) by MW4PR04CA0072.outlook.office365.com
 (2603:10b6:303:6b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 13:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6544.4 via Frontend Transport; Wed, 21 Jun 2023 13:19:31 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 08:19:28 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Add GFX v9.4.3 unique id to sysfs
Date: Wed, 21 Jun 2023 18:49:14 +0530
Message-ID: <20230621131914.2116641-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|BY5PR12MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5ae916-2746-4799-8f0b-08db725a2629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSBqlvdHtrZ+ABixhdkJ0o8Do+aelKj7nUae48vw7hd4YRcS1NAPTrmtMHCTjaH0W7cPr4KTWSk9to1aU1yGf+qozZNGLJCqBqbPS5jho4G5ecCFjKyLqCA3SuUNwsE+EfQrvCwphQu3cPiOEJ219NTcvvtvaUORgdTAKby4Rj2ZWcdTmIdfwTJ0XSD6cDiPeT/6bBeJ9i4rnN1ttc9FlBXxQMJpo2PLcuujob4tduPpyFQS7ylr5dO3Y0GfSYMSzczE7zgnif+cDyk5Fp4gIokDMtLtvzSGbpHlAQYulY4Rcvh3kcFY1hrmJJ6eYk3c3NJua38gU57fRRLZrI3XO9k8bdDmLQRQUUtdqQwthtqX1sb4+5PtKPnmnsHGgvqYNhW2sw6JtmJcQXwTLJGUSbPxaMMvbnMVgHpfbfxgskxP/3wmNOwe7hnYVlbIahENKqtQWxNkJC+nwRnA/syJxajfMFWHk1C1DgCIup6raCH5vHDMoajrJD0Uph3ChFEDQyQsSTp3stJfTAqFJGee/PIvtAjSSQ2j07AEKW5+MMHwvqR0DS9fLeUHkhMmjLqjzBOXErq4LO+3ZlFm3X7qCTX6H1N5AMVmLkDV1Mj2ez97s0d1hAM9Z1xQJ1rWBJI8nOPT0ZnvU2fnJdZlibZvw+t2jf5KyiUFcqIZlXXAwrSiLnJNM7HD6DSASHFePQnQTaPvWkU2xc1DkHAwlWK13oXysWfHrcp5ErBY7mBZ9MtahAeq66Qr+k1JX5y7GG9q8qOeLIjGcpgytrbzGNFdqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(54906003)(6666004)(70206006)(6916009)(70586007)(82310400005)(26005)(186003)(16526019)(2616005)(1076003)(336012)(40460700003)(7696005)(4326008)(5660300002)(41300700001)(316002)(8676002)(8936002)(44832011)(4744005)(2906002)(40480700001)(81166007)(356005)(82740400003)(36756003)(86362001)(83380400001)(36860700001)(426003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 13:19:31.4375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5ae916-2746-4799-8f0b-08db725a2629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Harish.Kasiviswanathan@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Expose unique id of GFX v9.4.3 ASICs as device attribute.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 386ccf11e657..9ec51f50fc52 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2072,6 +2072,7 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
 		case IP_VERSION(9, 4, 2):
+		case IP_VERSION(9, 4, 3):
 		case IP_VERSION(10, 3, 0):
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
-- 
2.25.1

