Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55948C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 02:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0DE10E0C3;
	Wed,  1 Mar 2023 02:42:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927E610E09B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 02:41:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQyKwhscHMhzUNTFj2JzcFqjz7tM3eMCXShLysv8fuYd6yKKtHolqTz40m7FPfEj7ECn0o9YKAyZywLbAzvQX1RFJSUc7w/LgPwrKEJ3ni2rTBxl5yzchsnZctP+oYd7SFkr7a8QHf2RynjQ0Oevps0QmIhvr0XLvMJixinoP/R/3AB/Se/VEaI0s+qAcVK2qkYcWqUfWHb08SALOe8ZA7eECDsykTFRTYdBFWXwE1PllxFq/tw5iKFNMg7eN9HEeAoM14ab2+qHTtToyYzRxMayoCDhXyd41QhZvP4w4vbn7j7r1nmMujlOvfkg/kimpjTYPwXpYAkU527RmzyCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QboZkmCOl3zOm2LLq2OQn5ORKSp3S1BTOBh4zO4TTGY=;
 b=cj8iNPTLmy0qqS1lrD7xKIWHyaf1PLBehwxs7shtHnn3qQzuSJIYDv84OyJMRb1syQrfvssop+0RYoeuPN/7c73jkDH2N3OJ7cnPI9m81/5fUgHPPjvCIYADTR9w882Mrh6AuFcrmJDGC6L2AP9ZLXjsUPT7KQ3T+D9QPBr8PH4o6wZKLjWxahXLV5ILyRv50LntvBnE+dza1Y6uglPL2iOH0yz6GCgts9mFjz7hy3vC2FvK9sbE9IkI2HbyJXmb1clJExTHsLVM+78Ja2qUnK9j1BRVMAo6r46k9hi7Do+rVYkKkAoad9tmUFsZaNIf1Mi7uAs7XWSPW5pXqBX7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QboZkmCOl3zOm2LLq2OQn5ORKSp3S1BTOBh4zO4TTGY=;
 b=OY3z1VqlPgZsu9+Y5cvI8dQwrFJWZsQUwYXPxG+IYLv+99ruENWY7WrGwBNifPiSFMhhAX544wUL5YcYqKoKul+6QZhB8R98JfgssDLXIJopQw+0VeJQGyo0b5bUayVnk8F9vvPKzbcy9PnKJdqXamH3/6auq2WDDqylQjFhgBs=
Received: from BN8PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:70::33)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 02:41:56 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::c0) by BN8PR04CA0020.outlook.office365.com
 (2603:10b6:408:70::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30 via Frontend
 Transport; Wed, 1 Mar 2023 02:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.17 via Frontend Transport; Wed, 1 Mar 2023 02:41:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 20:41:55 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Feb
 2023 20:41:55 -0600
Received: from vads-PC.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 28 Feb 2023 20:41:53 -0600
From: Kun Liu <Kun.Liu2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <evan.quan@amd.com>
Subject: [PATCH] drm/amdgpu: fix no previous prototype warning
Date: Wed, 1 Mar 2023 10:41:52 +0800
Message-ID: <20230301024152.1351060-1-Kun.Liu2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f21a1b-7b9a-4e44-ee33-08db19fe85d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RWWjcw8LWtrDxjI/3h9/99Dsml+S/R28xs6fCvEQ05nKmDBIFyK/yqian5cTmxiAsLZHiWGkXCcAbaa1F2bV+VeQJ6fh7afSNN1srFe63A97xiMuMlf5KkRXcTwYVIZMSmjVQaovLHT4F/6/+g1slNKT0q12c5nicKhOkrGmARg8jPE4xBb+jkKYDkz0VL5xQw3OUC4SxQCzy7iS8zACqDLvYzsORmUXdqlQ4eVmmbtTtb5IGj/ur9AQ8P7UVemFedswh4ZYHgPe1VUKczx35DnvZlQR+ksqofFAHvVc+OT3WtoYRwikEhH6mtqwwMISJ/9taWxIWnFbMqHdkovnW4PSkEjuTdXBWDGWo9s2UdYeVPlps4sG+CZjjLpiIk1cfugbnPO6/lAFQool7xSjqH+jbdDU06/capHynMUR8Ms+wgdI0G7loi7h2TGYxJZAZbY02i+0C8ennJ+Aty6Cs/i0/u1dqr92xM0zo1TZk7r0cg4UMcoFDBBa+5bzRl5ZmHpfaRuDuvddH8b/FLMM1HPvhh+hr55WKbwqE9BhlPoxaaoh3CO8rgh7DDg6hXP+aTabdDyvxxjTBsQsvUC8ha4aQbpxsPWaAULVD+ab5i3IEd+Oo6JJCa6UR78wemFJqBmjUKOpxq69DmuoQpUlHs4o9OAZL1FQU/W8o34QEevkzY0R/ZHIcDKGrFYCOWHoCsQXRcT0mF3QSQP76CTZLq8ddlg2TZl+z/awigUuzhXRSKvEJW7v0XskY0OZlO8b+apX4O9T4IQBof0CbODSbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(36756003)(47076005)(83380400001)(36860700001)(426003)(40460700003)(1076003)(4744005)(7696005)(2616005)(41300700001)(336012)(186003)(26005)(40480700001)(86362001)(8676002)(8936002)(2906002)(70586007)(70206006)(5660300002)(4326008)(478600001)(316002)(82740400003)(81166007)(110136005)(6636002)(356005)(54906003)(82310400005)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 02:41:56.0103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f21a1b-7b9a-4e44-ee33-08db19fe85d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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
Cc: Alexander.Deucher@amd.com, Richardqi.Liang@amd.com,
 Kun Liu <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add static prefix for vangogh_set_apu_thermal_limit function

Signed-off-by: Kun Liu <Kun.Liu2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 016d5621e0b3..24046af60933 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1597,7 +1597,7 @@ static int vangogh_get_apu_thermal_limit(struct smu_context *smu, uint32_t *limi
 					      0, limit);
 }
 
-int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
+static int vangogh_set_apu_thermal_limit(struct smu_context *smu, uint32_t limit)
 {
 	return smu_cmn_send_smc_msg_with_param(smu,
 					      SMU_MSG_SetReducedThermalLimit,
-- 
2.25.1

