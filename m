Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E234FC433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 01:50:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C77210E1B6;
	Sat,  5 Feb 2022 01:50:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D7E10E1B6
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 01:50:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqaj3mAVDmnpWmQuX+iFeIv1rtjeBwbfJkUv1jhWWnKhr5gOjy62SYhhQZkuMNBFJlH2Vq3rkwes8tjn20UN66FuuHxnA1nQSOd9sAYATdtNWU4AQ4MKMdWEeuns9wME6YDJUeQM4FG747r0gqikxXpEZeWk7/uaRBthv6M1KdxLLIQxws7Y9OLFfeybBbQzSXj6FRS7VvRo1k/QJzOSLvh9NtetyQZ2bQysaovLpelunYjGoZMKsK183Pa2/BprGyyOrVtXmS3YLQ6HuNIUTThIsjnQG+AWWp/hs2PDTKuDOj7dFuW6NwXZjvRxvP4geN4aiIcCpR5mz5F9jqLYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=iy35BaD4F1Oun6vju8wDDPHfj93yBp5cUshX7DFGM4I/lnv6iAa12mPuLJ5TBNrMC3phkfFdAzO9FKF65FOCT/WlHkmOQV5JKlnqmqNEezU2xUG8LsYczF1YgwlWaXerjuGVlj/Cnlfv3oAGweSQE8FFwhVLkUpEp+GQ7LgUOV7JhQQlMoAnztGHmO1dQcE93JK5sgudyy4KJqnhVJpTctj28PEkmyyI04Y7Qhq2aLTNmCHWfAJ1CC9EDnw9xSSZ8SrAcvI/aPWcOJ37HvOkN/2VO15j0yzsyAedqp6alm/+conMUWfGs7U9m0lH0Fj+NlQDXi1TyrmFOyN5eLMoUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASo9lDomJio3oowD4+jH9I2CpFgbRFVdgCOYZKRmBLw=;
 b=oRiNDWY7UcQz0++47ekY1bx5XNRPaSVEP/z1qu0gocCzpwjfiEH9EqQXeLvzTjR/J01MD29F2XZqNIz833FgmR6alQhe6o3VqtcQi8hAfX2SVCkKid+G/LUmVVrzFqIUDFvANWUhfl2mcKKeyHmTo8MEaCmRmMYz8jGtbiUXYuc=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 01:50:47 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::29) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 01:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 01:50:46 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 19:50:43 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Fix for variable may be used
 uninitialized error
Date: Fri, 4 Feb 2022 20:50:16 -0500
Message-ID: <20220205015029.143768-2-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205015029.143768-1-jdhillon@amd.com>
References: <20220205015029.143768-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d80ae21-0ce2-46f6-9d38-08d9e849edd0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4240:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB424013628A9A9CF64799D52CFB2A9@MN2PR12MB4240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTQvF8sjORaWBzGhHQr7O5HxQtZ1jL2MltsM9sRLm8vDadXojIVmMJpm/sfEqyaYdlZJDY628A6gHhOixQreEGeypnfC1VLLb9qy8NzG3DlCVLYKLC6+BpZ9GC4PL9zf4PLaoFrNc1BLGd5NkiktZT0jFe0i72c2osMy0iS/zZuFj/NxN6RNRf6nGoWwV/PfShDWNwhOIClKnVVq8QV1PL6qvCPUNSGPy4mvjmjHt3yMk/2jSONR5PHjqgnJK277Yh+3rc/67ZZ8wqIQsWWBtlkqGa1xs053J12mUDnR76kpZfVsaoMjREqBa9AcSkT88RcjwnKY1x7cf9+sUNbm5I/BTM7Pjlkxi8uVAOeth9QUhhA8TZhmTfyQ1Ghjxc0NGnH6cYAUPdK1E2/yTZyHJLRcnUwgvwMmUW3jyzrvCcmgCRrjMrXwwIEML8d5s5KDaZGhjDe34SjG40dHWaQ4sxWHp05LvZqM2BUpdIOs+kvzHZrqixeOVFsyMK74xLvizayNzQDRJdu3Ptmh2vubjY2WPC3N+vHmVdAZ0r+sKpOH94H/tPiVuaC55NKgOn890IZ/xs8Tt/ULIgtW7x5mfm1+bGJVCyug9H3ybc/6YtRE0dazigH870j9FF2VG3EToRkuuRgMSebUqcXDHc+6wHnClmXFv/4xQktwVido6yqmvijE5a14HyR8DWprpyU/sT8wqKIIjcoUm2NaebGNnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(4326008)(356005)(26005)(8676002)(5660300002)(70586007)(70206006)(4744005)(83380400001)(81166007)(2616005)(1076003)(336012)(426003)(16526019)(40460700003)(82310400004)(316002)(6916009)(54906003)(36860700001)(47076005)(6666004)(2906002)(508600001)(186003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 01:50:46.7889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d80ae21-0ce2-46f6-9d38-08d9e849edd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <Wenjing.Liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why]
Build failure due to ‘status’ may be used uninitialized

[How]
Initialize status to LINK_TRAINING_SUCCESS

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 18fe8f77821a..d0cb40df60a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -3199,7 +3199,7 @@ static bool dp_verify_link_cap(
 	bool success = false;
 	bool skip_video_pattern;
 	enum clock_source_id dp_cs_id = get_clock_source_id(link);
-	enum link_training_result status;
+	enum link_training_result status = LINK_TRAINING_SUCCESS;
 	union hpd_irq_data irq_data;
 	struct link_resource link_res;
 
-- 
2.25.1

