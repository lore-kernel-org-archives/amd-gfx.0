Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F55C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 06:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C7810E042;
	Fri, 19 May 2023 06:19:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A66E210E042
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 06:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJM1eL37lycknb4+rPAYz5msyYsbHzz4lauaQ5Om0Qequ2MX9C2aD5rMCTocAkYBppMjDfFYbWx3eB5aHoIuaNY9DfDzHu3sOrIXxWLBdxcah9uW6+dzueGOk7nSdrO8ezKxVxkg/APjI11PNc3dRiRrtlB3nlWQEf1b0sezMnb05IOiQB1CwoxV0WaiAK+LGPAbdVOS8cTfUyNwqvjWqR/Av1k8Jc8xnl/Mo5bYLVfM8kU+FXu/sNo4Tu/MihVHlsIaiYuDNp8U/DLz8oOeg/s7XzfTgDH8AQ4P16TUtS8cXQoayJSuKYO2nz6sfVqveiYMGDfvAaVtXzE8dileCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhrUVfhzl/kLKgt9xgoYnhqu0pVix9mJtnVbQU5gxtA=;
 b=nQrQ3Odax6Nb3iveQLiYvqx6QJHt6ZuY3vecva3OU0ZTrfHCv9OdheavUN46gULmTNYRMZ8iearm3orYEvyyN3EZ1xaa5aAFhrLs94dcSuGIulhZy94iIPl6EQW8SAU/X7n63KSPIYGD5OQJKaHKOi1w0+uHR3ZRO+HGV5J/aXX/xeitdGtlGsP2KHGekDO1llzLxo8lyYQfjp9r7YOKDePr8+62jcMpoAcGa0HG5igSTYQzh0ESnkzB1FOzuVyrbLSAeDcuoZk1VIU0L45VRWU/MbLduhPqJbgehdy22K2OjKpxiLAZq0shcz1gyS2q3oUrRafD9WvZjythSv25ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhrUVfhzl/kLKgt9xgoYnhqu0pVix9mJtnVbQU5gxtA=;
 b=yC24GuilngHITe1cGYaM9L2S2X+S0ymFRnTQL8MwI/7NpHA1Hu8U04ST3gBUBNSYbSGS2O0fsT7ff61aBdtimfDFh/XlLd63o/LxAOY58mHe/1OuUZ3ON1s4W2ufMlsx6GXL+GOz4J/WOXZ/bAPpJ3dvDRllxwUEMswzfmlk4ho=
Received: from MW4PR04CA0146.namprd04.prod.outlook.com (2603:10b6:303:84::31)
 by MN2PR12MB4581.namprd12.prod.outlook.com (2603:10b6:208:260::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 06:19:48 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::4c) by MW4PR04CA0146.outlook.office365.com
 (2603:10b6:303:84::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 06:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 06:19:47 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 01:19:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix uninitialized variable in
 gfx_v9_4_3_cp_resume
Date: Fri, 19 May 2023 11:49:31 +0530
Message-ID: <20230519061931.162582-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|MN2PR12MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f7ba4d-72db-407e-4fd6-08db58310b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kekw5fbLJHbDeT7Rr5zWxxS02GqhbkET47cS4FlJUcJOT4e1imB+ZNZF+h+v8FzaJu7Awirrh5NZvX7kS9kMow1Eg3DvZF++LEC/Fr50r1No5THBrF0jU8ymNOlyjtTzo64+HaibrfWSrvUTtDz4I8MU5EIJFKyJjUZt8tY5H2e5o0ALI/HyomSfkQRZk3Z4TEX5hEex5y3+6MsSUF2Kth5XdTZ6Ij2Nudojxgqf5UZfftE5LMlyBo7H8Gh0r9Fc8HdWPJMwZ5B6UkX67RqG/ppuBEk+svleYyWLmov00lxwHkC5XtvCHl2At//VzwQpGVRjSpnGlLETXSJIpwCd9FAQkB8fI2GTLTAQIwdOWYp47b/5WrwXTlA6YWADI7Y1pAAXyykjgmldRXQpW5waIFaWOJgKOdkxE0wOfhJvdd3x0Ic7JJmT5T71AigShFVicrxFPGr58dy4BMt3vKUYECvtfbW4+oJKdVO22twGq6pp6KslXqkUBNrJubeJBSyV/nhpjAhCSXuYRAbivmQFmLG2WJdFAZBxU89wsWAqJNmTcc5Xj4CT3l1adyD5H/axXE5HoDeItO7SKhPP7nRUH0Nyz6Rsxv5T33txuuigsDYdh4hG4gTYxhxQTcQmHl1B+wYBzUyGR3pkrHIIQHFp3vRA+b3to2iudzY5JO25bOiPi+ZID21365KcmZDi6pkM1rEzo3ag225pOWgQcpP2uura2M353K8ZEcs3+MQqELowF+HwOLcf1TLShe4qaGxOEGVnr5b0i5yCXCqRPtLaxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(316002)(478600001)(41300700001)(4326008)(8676002)(6636002)(8936002)(54906003)(110136005)(5660300002)(44832011)(6666004)(70586007)(70206006)(7696005)(1076003)(26005)(40460700003)(81166007)(16526019)(186003)(82740400003)(356005)(83380400001)(40480700001)(66574015)(36860700001)(47076005)(426003)(36756003)(82310400005)(2616005)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 06:19:47.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f7ba4d-72db-407e-4fd6-08db58310b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4581
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

drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:6: error: variable 'r' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1931:6: note: uninitialized use occurs here
        if (r)
            ^
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1925:2: note: remove the 'if' if its condition is always true
        if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:1923:7: note: initialize the variable 'r' to silence this warning
        int r, i, num_xcc;
             ^
              = 0
1 error generated.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
  - init r = 0 (Lijo)

 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index e5cfb3adb3b3..6a1a28df606c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1920,7 +1920,7 @@ static int gfx_v9_4_3_xcc_cp_resume(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
-	int r, i, num_xcc;
+	int r = 0, i, num_xcc;
 
 	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					    AMDGPU_XCP_FL_NONE) ==
-- 
2.25.1

