Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1929BEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 15:56:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9E5A10E185;
	Fri, 30 Jun 2023 15:56:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E03010E185
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 15:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMdSbyHrkpX2U+4gNTOwx2U6B/7PK3qWT0QDxVzGK2pfu20bW78ootTjdH9KCxM5dvJaiTxMsrP6PQ7Jfwf9KdmgJxCSsL4neAS9RFOMLDZvATrozhlAYRXJt7NJXgMaK2E598vg9nZDJexqZM8amVEUaDd+W4uNG7GHRzFB2fy2QFcne9nALW1QPEY7R4uK09KfGX0Fx0K4pAqDulAH6NVf5Ljmuek2cSh0jIYuKl9w9RBGYUR2Es3hTL0PSWoxeLQn0nSK3RXqFCJyi1ndZuhWHKwUplE349ZV8Y8BhYnVZWV8nEShBpy3Joclf7f0tiyM3KhfGx5M2T74+EBVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qtzxw8OHsc9kxDFy2+yRQmtJUHnLPjxiUxjAxBWRvQ=;
 b=LPAnrWARlQN92LiI8BOA8OpHJt45bGk2z4mu+j+b1xExi8OKLrB29r61qDExljPbOD2K+gEvCAvLHsEEsgDoexj2fKgtXs6eWaHgq/Jbn1D1mpebHuNR5sI67MKkWypMRqolewINM+ZtEFLSKRVTvzrkk6WBrkQeDFP1TY7QajYtmroRa1/2ssKfoq2DUxJ40OIcjuiGXOyZzMNVbDw5jo5Bhe4GhlMsxcgj1WU0QzkFhNa2TLQ0Eeg23J1/Nvlz5j8m1ada90I+h9wyYPwmyDPcVOe+mnuOmxRvvRR0lBrh43iRjFYBmvQ8uJH8aLhM4XqxX2KEJ5qiE5xaOtCpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qtzxw8OHsc9kxDFy2+yRQmtJUHnLPjxiUxjAxBWRvQ=;
 b=JGYZNpWbJ3XhQn1pPPD/laPyFCfNOONzXYfYSnpk/jOEoinNsKJObSXMCwvrvIxIxD7XjWfh1ITyFgkqsr31QQwGbmptrpyrZt7FWzssgp1fbLunYMqLFAkvr3AhNe06M6jQZWRkFiFVLtps1R52c3q/mL4MHFy9nWX7J06MNb8=
Received: from BN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:e6::25)
 by CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:56:21 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::d) by BN0PR03CA0020.outlook.office365.com
 (2603:10b6:408:e6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 15:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.51 via Frontend Transport; Fri, 30 Jun 2023 15:56:20 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 10:56:19 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 0/6] Clean up patches in amdgpu/gmc_*.c
Date: Fri, 30 Jun 2023 21:25:57 +0530
Message-ID: <20230630155603.3388617-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf7c3d7-73c0-48e6-5b2c-08db79828c4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3GlDYfp3C5qDxqsYqbIcT0tIyMLZW7aX0Q7+7V7+ADYw1K/1eu9kYjrkxiHgyhxUD07X+3cv3Pecrvp9ggr6abrjDsIKX00OG26QphBEvHUB0S1hwMB9wsOgMspTO7U52i0VAUydECZs/U2JipLvHiRUnKt/f2B49k0qoyvdUYJsib+Huc6pR1ZS2WDipiRYQqpE0auyeoQVUFRaj7cXcSsZw/m0L+swieKmsRxaEGpZk7z3QcqYvwp6hlZo9mx6W+TMRM5NDue1VsQDuXrYAO6X7Tm1p0Tz7Br3z5WscLHzeYFYH/30iZWeuQLNyrEPBePy1LPKmEctxkwSfD5AH02BCeMxMs7AJwSecN6yYD8odi/R81Ed2+L6dk+EyGzaeG3t2V0JwS7RCuYM47jqGLuYmoNDxjh5Ic544iMKRR5pDoS43IMNbfDoKHxF7pq2tjBuoBuvbfBUT4bsmIc3LBAtAVkU+2I/9wPdFY4haJ1mubbhzC4ikUe7C4CwC3uKlcKiONKVWudDlLbBoujH/ABp3HhNtK6/RCU6BUFsBF7j1498wgaUY4vxX46x/j/gsjkWq1hbZNNedYqhwjZSq2Df2JfQOXgLrDJxCMhyIiEQnVvelBNP7jvXbA6qvwvYWbLcGnU89Sezad2mnitz6fYPSPOT2n//EwLV4CgjI0W3f2C4DBV7Ys15WPj0Q42FKquwUYi5tlpyY7mLYI3dZJb3suHQyhOWH5+w2AyHesFqHWLWdlgZ2DCC6NzdsJLaUs7JiP8t72TQ+LRSqV/4A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(2906002)(4744005)(8936002)(8676002)(36860700001)(40480700001)(1076003)(316002)(426003)(70206006)(70586007)(4326008)(6636002)(47076005)(41300700001)(16526019)(186003)(26005)(40460700003)(86362001)(83380400001)(82740400003)(6666004)(82310400005)(110136005)(44832011)(54906003)(336012)(2616005)(7696005)(5660300002)(356005)(478600001)(36756003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:20.9464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf7c3d7-73c0-48e6-5b2c-08db79828c4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Srinivasan Shanmugam (6):
  drm/amdgpu: Fix warnings in gmc_v10_0.c
  drm/amdgpu: Fix warnings in gmc_v11_0.c
  drm/amdgpu: Fix errors & warnings in gmc_ v6_0, v7_0.c
  drm/amdgpu: Fix error & warnings in gmc_v8_0.c
  drm/amdgpu: Remove else after return statement in
    'gmc_v8_0_check_soft_reset'
  drm/amdgpu: Fix error & warnings in gmc_v9_0.c

 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 35 ++++-------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 30 +++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c  | 52 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c  | 53 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c  | 86 ++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 37 +++++------
 6 files changed, 132 insertions(+), 161 deletions(-)

-- 
2.25.1

