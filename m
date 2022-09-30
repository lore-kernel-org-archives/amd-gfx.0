Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F52C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 20:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7574010EDA3;
	Fri, 30 Sep 2022 20:27:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D3F10EDA3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 20:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzOC0YR0TPfeyiltIJzXQMXzLPWuN0PlFPxLARmm7Wq3TDpbGRiwktC9j/EeFKP9kyL3SAuMZjxbMpMAb1b1Dn8TrOgfuprDIg3KYhEsMmAR+CAE4G99mIxvj18Ht6uU8ctBpT4L/tTh0qfB7WolDSAGEC/w6Q/UtV0l3Mj6IzZjMKp9AVz/oS0ufEd/0QVkQesHPlT68e0wFJl2+E0EPDEdRf0155oZ4NgqoDNqDLoo5eaDg86y7PEWs5/IzFnp8seUu8s6ew2FkIOveg4k0VTZoP4S5oLD+5AWKgckgsfBV5pEGJ/BqYL1B7m7mihBm8XrEY9ZW0P+h9ERp+GSJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18uBLlaDDqar8xDAdIxBMKh0cE5laHQ21TdlIDFaxiQ=;
 b=ktlw6TimleeD59wyuDr7oGe+rWhnTHU7Da5btB/LSyMh1v+9C+l9wSUwbzotsccg6rNPIQpAJZ57QWWy4foPpoRVjSBLyrTc8kVO3CaQ0xeTGJhfWE93hyrFg1I17xlnjSuknDWPBm+wlC74YUjt5S4WNc7FiVnGhQdeejQG62i7v856YlCRYUihVZJXP+Fq1rqyrfDIZB5K0tO3b3YCqwjaHnQ+LB30wqYmGBUGnqQHYi+1A8N7kzwwoBdu2EK9zVtooXfue/tasbxnBR2CvnraMXtGqsTehq5aFZ1g8w34NhJa5z8xeglFNvu9KVe8iY3iBIN/oufKNFc/6fe3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18uBLlaDDqar8xDAdIxBMKh0cE5laHQ21TdlIDFaxiQ=;
 b=rznOd28yMU6Rv9Myo2R39l/8DLgwXxO7DAO8bhhhM0M7yDR1R2+qwN+FuSh0pv0lhAInHmKqtwCqYS7K4bYi0HgxMTWtKTXBNn/LsWMToRojDaH7XgEnN/IjuzZTGBcF3yJNvyW5og+SsYKY0THWf5B91R9q0sAtBGzyN//zTPQ=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.23; Fri, 30 Sep 2022 20:27:11 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::4c) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Fri, 30 Sep 2022 20:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Fri, 30 Sep 2022 20:27:11 +0000
Received: from sonny-TP67XE.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 30 Sep
 2022 15:27:11 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable VCN PG on GC11_0_1
Date: Fri, 30 Sep 2022 16:26:50 -0400
Message-ID: <20220930202650.9550-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 90fd8025-9f50-4101-b2ce-08daa32227cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tJH4k62cX2yBr/2GSNC2mQZ1nV6MdOw8WgfX46qdvloBoLAs76LEc+LRGbRJBp3BLLm9zZ194cJaKUHELJh/BSe2v/DIPABXCRa7VhvGAAhRM8UE8i7Uv5s3Z7ejX9AMIzoQx1rEyQ4NwuTOFpHFJ6RCa2SXT1FqOjTxfhArKn7MEyCLY/5Tfdbz+BiYF/JnH1ETP3dnLKsszCdDFVTHwIQaw29KmahvusxARfe7+7d0rKxW3+AE+r+hpOXeC6UifveahdELHzLkuQlJgZYlQ4LMKEJI2l33udrp0Wp2XGTYN89uvMo40FIkjPuulSLpwdJt7e129la+DRKLk34HoZcMsnR2+LaKcyefiZi4B8TheeZuJYpwnm+tEyCk0gFU5X8CVafJvuqlPrGeK/JXtXf8Yx72d51nDQlTfLimORhAuEXPB4IfyHVnCkJeYqcZLBbdkvWxt8+rjaUI2LL5srV7oamLry5boAt1QptBF3JQlR96tiz2P552IgcsEfcK4iLe2Y20p/mZE7mMGMubAcuM/mS+A7qc7AeRlsIuOWGjGA6ofoOUGTR2GxoTQh3fgB9silPEkkBrIYK0fNHDq2jc93w2Udi+z6T4WGJm+cKsFmtJWuzYVFMME79YLjnvd3E+zaimWLxpxs0A9xlG4HyPEtdubHFysZJWv7Nw133G8xQi8gVRyNmnDdb2lGn5q/YvSntI8Eo1yAr0m8CLqo9elOQWBhJ5INCbDj/3RLE/CkwIPoIeDSOZt8tAu0wJvYD09zT21OOxxKLFluzdbfozRGU+ZcNRyQWIyj3wNIseSzDf5DwF6ZPZPZotDOlu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(40460700003)(316002)(6666004)(86362001)(478600001)(6916009)(4326008)(2906002)(356005)(81166007)(41300700001)(82310400005)(8936002)(7696005)(36756003)(82740400003)(36860700001)(5660300002)(1076003)(4744005)(186003)(16526019)(26005)(426003)(40480700001)(336012)(47076005)(44832011)(2616005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 20:27:11.7260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90fd8025-9f50-4101-b2ce-08daa32227cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable VCN PG on GC11_0_1

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 16b757664a35..795706b3b092 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -629,6 +629,7 @@ static int soc21_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
 			AMD_PG_SUPPORT_GFX_PG |
+			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x1;
-- 
2.36.1

