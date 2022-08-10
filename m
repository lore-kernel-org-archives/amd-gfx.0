Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0AFAC19F2D
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 03:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7DEE58AD;
	Wed, 10 Aug 2022 03:22:10 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4007BE589C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 03:22:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWVdqZsXJlzco+RwN75PCGZh1ifKhZaBEaf42OPQ1bWPAmC6/99ROtFAayd6lO2Qhekqvky2fhHIlrSr3EOBAFU2ISqIhpF4jxhfunX4pfUjl5vgIb3Qjilcy3GzfbgaHWVKEIesk1dRb2mcl6TVDqUM/wCWrotviWlT2ydaznebW9lTNoSckBYPSDut+yh6zYwwhLT+lSgNAAsAlBBMaP3C6v65fepK1Jzlk2Qm9f7ZeejzhuWKJ77kw/cvq6BwqX3gxxhcHjA0rrmBLL2BT+rQvmuzlknLtehqtbYQUWtF0X402+ti7maCAAz8Rn7ZtrHUYYMDl74PcT1b5StpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeI+4jjo6gVj5P+Tc4KMqeZWSu+szRIj0Q0/Rfgb1qI=;
 b=B+EuCHjZyW4htfOkD6RBdyT45C8ovkznkNdy3lRplitxTn8y6ljEq0liSXNWtb06Yh74LbGaDjFIIeHkw1dIxgA5BSjYBGnZyDIZyvKvLZTEz+hgtpqVXAE0TGdzcw+SnrTV6scR3US+MaaG/nrs7JNhumk8Q3hIMrsKG4ouq9e6QaM3gv/hO0Bb4zx9AwL6hyr8LLL3vp0L1cI08vW6atdT2jtfqrf16u1gHcnNO2MoCi0jy1JD4oxD1Ce4N/fShmEWy+lZi2HgCQXnyqfwLg1MpwiGwillv9Xg7RakfKrfufJ2xkOpaaaSpB73nEtyFEwMzJlzL/dsv4BmvM5N6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeI+4jjo6gVj5P+Tc4KMqeZWSu+szRIj0Q0/Rfgb1qI=;
 b=18tKEdHJWEnrTWDFSKbUrdpT6nRqeyoWvm9HtnR37n4XpTONeI7RJwULQZn/BhtSIkLkT1niFbd/jTE+ZjbDUsjlWcEfFeaPFoz1hBUshei7ucXWoEwdnXKXk6PX3X3ULP6vuX0a9z0c4Nu6Uf0BjiFrfCw1uXfpLFcvpQ4XO/A=
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Wed, 10 Aug
 2022 03:21:58 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::1d) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 10 Aug 2022 03:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 03:21:57 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 9 Aug
 2022 22:21:46 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: add missing ->fini_microcode interface for
 Sienna Cichlid
Date: Wed, 10 Aug 2022 11:21:21 +0800
Message-ID: <20220810032122.1774860-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220810032122.1774860-1-evan.quan@amd.com>
References: <20220810032122.1774860-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52433c02-c041-4a25-e4de-08da7a7f7bb4
X-MS-TrafficTypeDiagnostic: IA1PR12MB6484:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 84KmRmIRSmAi7UtDLxiFcDyqaDjpETazMX52wU5zd4Ks5cQ17UBkfjGlLRhLzdmOz0z1Nmhzf4csj6gTqOXQTcT5yUMxiF3jxZGzz+BC2Cugnh5ileqot8Y+uRwf5cexxwSj+bezsneF8LZDOzSKqeJX2vx5GkzvvRwDBnL6GQTNAjHx8MfIoL79EnAcFZp0O7/F84grbLash14FxxTJeH4n5HGR+fnFx3667Vt6vcYMt0HbvxxdRuDztf5AqMWnYYglxkzS+jVKNTXdh17HTVAluGKZWqZ9kZzrw1QbMZt8m9uYCJk1/EFeU7E/u9mRy2nqERJC5nzWOeHARoS3+y2rYpLSfa4yS72MLIO5+RbWHeB09SrpNoW6jXq/HdIsCTNPAlrps2RSpKA+oyud/pJu7LvwtHOjKiWfrIDAJznucTC3UTzcHCgO04qa+4nfM+tceor/6yQ2LoQZ5Ym9PEQcCVrC/5mLtOVFudopq2CI1hyOwP3QmP+tAHuTjSYxcneU6gHro8tA5V27N9x1zp8TRZhhoc+4OLu3nFm6O+o4SvrwLXHt1g0fYbgSLmbdTCdlBnJnWidocR9AwJcwG/+/HWv4gQap0gJk83clqtYdxet73FMwZ0mv/HEeiXULWubgQZvHKSolP6/Pe9yjZgjKKYgeKTahcCY2ZxFa2lf4mRVZiSpg4meJrFm0TtGJ+KVS24olMAz6/4tMnVe+lRlhDKgD6eOc92mW7clxJd4DyteOBHabg2aD485StGWQbrwumtdTWAHhn5MI52DBk5BCZgtVPfSsFTcANac3+1+zHcGuKg+zx2wD2IXwD8H8s+a5BYUHPZrGfbF9RLHJPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(40470700004)(6666004)(478600001)(26005)(41300700001)(2906002)(7696005)(44832011)(4744005)(82310400005)(40480700001)(86362001)(36756003)(6916009)(316002)(54906003)(356005)(82740400003)(81166007)(336012)(1076003)(426003)(16526019)(2616005)(47076005)(186003)(40460700003)(5660300002)(8936002)(8676002)(70206006)(4326008)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 03:21:57.9515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52433c02-c041-4a25-e4de-08da7a7f7bb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid any potential memory leak.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ide94e85d862c10aae93e04e3ce64c0451e5e1570
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a73d241bb64f..7ed4d4265797 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -4335,6 +4335,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.dump_pptable = sienna_cichlid_dump_pptable,
 	.init_microcode = smu_v11_0_init_microcode,
 	.load_microcode = smu_v11_0_load_microcode,
+	.fini_microcode = smu_v11_0_fini_microcode,
 	.init_smc_tables = sienna_cichlid_init_smc_tables,
 	.fini_smc_tables = smu_v11_0_fini_smc_tables,
 	.init_power = smu_v11_0_init_power,
-- 
2.29.0

