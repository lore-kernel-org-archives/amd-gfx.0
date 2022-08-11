Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E9FC00140
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 01:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F42510E688;
	Thu, 11 Aug 2022 01:49:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8A598868
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 01:49:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnfEVzSdK5RkhZB2cVZ8FtR9xb/kA+sz+PVY9lu882peHtQnd0meNWaJveLmPw6yVcu75hJrzvMQtN4hpWuFldTqzYnNKhrLFHqbbMKH5t2FDYdrSZeRf78jK5Vy23eolLRtOR2lktDLTZ++feJE+XGA2fBVygM15iij0qsBGzwCQLqWjkpaxDmAYxnvplRPFOc97EqlsBcD+UZejfGRv7REAkViswg9NMtK5IQfo8D9JE6M4i9lheQGtKt78JY2qw03ixjBhJxzLfUS40y01Tzg5BsykLYjvtB0dlE47kg1KyStZBNhFlzHawPmRSmW5ZKxvF/GBxHN7MYMxw1iQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBRO7OUHSV2+Yuk8TQv4L7ujvXe2AaNAcWUDl9tqQKE=;
 b=fD26IFjnkzFUJ+Ph3tCQnxjyW0gbf2HHC0VamasvMs7oGTcELe7dXhSv0Dh4DkSYsOmRMGfoV95eK1qPXkPuiVD5gpvmqVJUP6yCeYHFWUgMExObjDirlMSj+z2W6INmfbGxOvmIMllY818Ro4J+Y7sLFZYW0CaHLDBHb1Xvh1IwG1g0GAE02jKzg6yphp+/fZ71c330ouFYYSbgCs5fAYuDBVJ5OoSKQh1cRhWJWDOBPRDtnIX5qWniqNEeF7ltP4fHIUJgreTmzJjkG/ru1AZlZ7DwC2EL1CCKggwrqm5O5wpvv1u9ozuhVV7ksaFZ3Ld6lS/EyBjuocydndwPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBRO7OUHSV2+Yuk8TQv4L7ujvXe2AaNAcWUDl9tqQKE=;
 b=uJ/+BD+sVUzcjb71SuoHWpdBKGS0EiQuRdAhIGclrlKsShRZZ8NOTyO9Yg4IzNQLFPIq/lZG0FmujHgQp30JOPf4cNOMsgm2iYpz+pLTLZjsD6DgNikm/FAuYw3hlkpRfzTB3QkBi7iYhjnam9XrInhdHPsI8K+TR8pn/HoJxbo=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 11 Aug
 2022 01:49:39 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::93) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 01:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 01:49:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 10 Aug
 2022 20:49:37 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 10 Aug 2022 20:49:36 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7
Date: Thu, 11 Aug 2022 09:49:34 +0800
Message-ID: <20220811014934.1140719-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29118856-0ac3-4243-829e-08da7b3bc09d
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DkOKpiefXeADVMIHcz4jqdcyEcCBmryGYFtmsEnYAplX61+2/DUNAEiHntV/4/JasPfYSaS6yF+HmNBubY0j5+KI9H20fBw1iffmq5sQWpRVdxe61CL+JR4l6cBMqgAEw1ivDzOfkjp9PvoauaLcFmI9CfavIWysrLKfVo38vvzgOEs7i406VlyLQL0iOkCySFPf6Ig1QId5br3F5ZoX93yvPvBLvoeoq9uLmoB6AbsbhZqPnfvLgGLr9K5Tp61wVv2vlv3Fk9hSee1JFmGnCZ5m6PcyRRjhpfdXu5uEkuy6ji9g8++d9XP4UlRVwhUu50u64+67hMIH3ojEg0SKJUIzH9ESh4lDPhv+5nCLpdYl1qoiOPtfQj8hSXlFwId79syPJ3WVhAQh/oFpi1q+Dfbn83UagV6sjX1KqSSJbHra7UDYjuoq8Ng5SHCmd4kf+UpskddbDqhDl2REh+VOnKV7ocb4H4XManmAjqQD0M94Ypww/38veLfU8O8AJYrBZYs+1tOObwGlvS2YABYBeJkFmIcZv3jum3JdTYyxG/BvZ4fTOuj6fPErZK9znlLcZv6nCaQXxKgw8QLUm+ZPXjClzyRswlLiNiBEwoZcLK6lB0uJVhK+hazRdEMJuekV4e6sQaURxa5yUa8mePfUrfDBeBII11mdiEYw+yQHy6Mot89JDeQz4jNlDwPumERDqRu9XMgjrkN5hfIGbGTnrTDwKXmBclSDyLoBblPO4ws3zMQLH18iaJMh+YOjJPJOJkw/TBUXH1i4srPuH/Lqeh6rp7YJlHSPjjNzuMM5XzyoJhXgP3kKBZC76RSOcZpdBHqK7R1fRTfomlk0MQ5+pA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(336012)(41300700001)(7696005)(426003)(47076005)(2616005)(26005)(2906002)(40480700001)(86362001)(40460700003)(1076003)(356005)(81166007)(83380400001)(70586007)(82740400003)(8936002)(82310400005)(70206006)(4326008)(186003)(36860700001)(6916009)(478600001)(36756003)(8676002)(5660300002)(44832011)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 01:49:38.9306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29118856-0ac3-4243-829e-08da7b3bc09d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
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

add ih cg and hdp sd on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index bbbf760f8ad2..686e17770c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -575,7 +575,9 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_ATHUB_MGCG |
-			AMD_CG_SUPPORT_ATHUB_LS;
+			AMD_CG_SUPPORT_ATHUB_LS |
+			AMD_CG_SUPPORT_IH_CG |
+			AMD_CG_SUPPORT_HDP_SD;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
@@ -690,6 +692,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 
 	switch (adev->ip_versions[NBIO_HWIP][0]) {
 	case IP_VERSION(4, 3, 0):
+	case IP_VERSION(4, 3, 1):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
-- 
2.25.1

