Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F117C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 06:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FC6010E3A1;
	Tue,  8 Feb 2022 06:35:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B781510E3A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 06:35:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZmie+UQ6yYaRsOUoRTV9AYvI6aEKwDVWF+RDcjckOUw7mU8u8rb2oTtz7XfxRCUXJYyqTZUtK+FmQLX52e9/1Lw7MiGuQ4Ixb7v9L62eI+nAKnUlFG41mOyBQ2Kq7pGE+Un+EjIkzPl9FVt1nGer+z/5Kf8VSxL5Viky5E3WSyqSwpQD97m1A5u4T4KUWlnnBdrtINyydBJYjejEWAMsmGqDOS02A45ynh/KeABNxCFvL2Q7StKmNApXiUq3/zhhwgjGa3wdQmG7fOAc1Z/vA5J7nGUkPY8Evnk/8HRnRUAOXcemk/yo/acXffGEQDLGJAySJ0lHkdEIHwyTEr1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGJBLkwtZfClgGsSjFOyozREpx/ek2cvscfumCI0KoY=;
 b=hrsZGifFg/NSZuntxxomsO2aOubvy67s+UTriuouPOIzCXLkjUvuhQFGKwvPJ5EuZCSGROg7J4bZM+FCqdtQXfqsVlBZKDH/QBIwO/64rbi5hYA7koNZUeDFw89nh1bZK4eCTIK2budwOIZDLNYOBwDz2M6vM7HdVWBBVy/7R/fQSNgum0h3AZO6kP96hedExxSpGi+jFq0grq4wVO1JWULwtFebeGNTuROTJeG2PFU3Yo+w4pJ6vkvUxDt7rDufUrur3e4zQcZUY1N9Kb2sUpuTWAbHM13gzOGJoHfE+zNPRtaGqLnNoBLxNRImsutO9mS1pf0wu9SU76FMzkTG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGJBLkwtZfClgGsSjFOyozREpx/ek2cvscfumCI0KoY=;
 b=tudWS7sMj60eG3fWFrxUh0EFJyOl4FVNtCgvF2J7KqtAow/6qm6bhk+RgRy9+Ywzw4BCxLDiDAvq6mkTKIiTx8bcf+f0q0IE+wbMQZbRosbSMTaBkuG15Wr5aKwv7UFCb9GOGzMgYQbSmLOfXsEflQHibJCRNj2cj/lYjJqTgpY=
Received: from BN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:408:ee::30)
 by MWHPR12MB1133.namprd12.prod.outlook.com (2603:10b6:300:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 06:35:46 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::f9) by BN0PR04CA0025.outlook.office365.com
 (2603:10b6:408:ee::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 06:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 06:35:45 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 00:35:43 -0600
From: Yang Wang <KevinYang.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix hwmon node of power1_label create issue
Date: Tue, 8 Feb 2022 14:35:17 +0800
Message-ID: <20220208063517.330344-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7956b6f8-6843-4e7d-6ebd-08d9eacd3c87
X-MS-TrafficTypeDiagnostic: MWHPR12MB1133:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB11337FCDA12EBCBAE80812D9822D9@MWHPR12MB1133.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXQ1DLYdTjRqKwpojTfKv/HMGdcHnSOjviqArOFQLXBJxsAWWbHgKj0PJAaHiNnYbNsghbXv4Zc0wpg2PGq/xn8NNWrXPkjBoLRR/nIW8D/yfATCJsvgaDN3lDmwhHuEMhhaOxP6KtwOauSur9TLYD8Jq64muypRrLIIUl6CnHkj92Dk7WB3prCA7kAyjMO30f3UNdt6CzjsAPwWqzk+SspbNONILNqgNKSuBIZB0ZAt4Jq1DS/Py6EwsPiH5lF/fCfl/inI6O5aSAwvwxfuwK3kNC9gcYIg38iqkhR+pMTtx9Cpj5W3uF7pKiah/sUfLtaLYNxeSO3KKj/iakFSqByIh/h739UkhZpJsqqzjRoMoPoxoUiXA2lwhr/Kv1PRqD3BMbh9zrOBqydzsT3upEcTMdahAH2iyD06r2Rzslqm/3ydhGotKvzsPNPOuDYJeKQCTK9TKUf2LJ60ivjPH5I9z6ybxB5Foa4xig4WeekyY28XeICF9eDbgVTy8e3lesRpia/PGdWUKR6CgiSmJvaB5ekoSFJejgRsXyev4tjKHM4YLUWVJJhOLYQnz9PpAvtTyB+gxgxy4ltwLj4DhoPNGEM5CI1T+odACBqnM17uKH+CVpxfM//3WISBOTVv24b3lXPc6/ELIojDJMHoOz8TmuUQn5EoYrgYuDxqYbWPZ9rni8mYX41nh9DTjc8iQtOYCvSbUjZp9gtCJKbItA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6666004)(4326008)(8676002)(70586007)(70206006)(8936002)(82310400004)(6916009)(54906003)(316002)(186003)(1076003)(2616005)(426003)(26005)(83380400001)(16526019)(7696005)(86362001)(4744005)(40460700003)(47076005)(336012)(5660300002)(2906002)(81166007)(356005)(36860700001)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:35:45.3558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7956b6f8-6843-4e7d-6ebd-08d9eacd3c87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1133
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
Cc: xiaomeng.hou@amd.com, lijo.lazar@amd.com, Kenneth.feng@amd.com,
 Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix typo issue about "power1_label",
it will cause hwmon node of power1_label is not created.

Fixes: ae07970a06 ("drm/amd/pm: add support for hwmon control of slow and fast PPT limit on vangogh")

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d68e7132da2c..d6c01c59f32e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3288,7 +3288,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 		 attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
 		 attr == &sensor_dev_attr_power2_label.dev_attr.attr ||
-		 attr == &sensor_dev_attr_power1_label.dev_attr.attr))
+		 attr == &sensor_dev_attr_power2_label.dev_attr.attr))
 		return 0;
 
 	return effective_mode;
-- 
2.25.1

