Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC7AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Nov 2022 17:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AB410E0A3;
	Wed, 23 Nov 2022 17:05:23 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C79210E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Nov 2022 17:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rwqwh5p1fWDoEklhWu41r4jMilPGtcwyFWQ8gJGvFF3r9FhUDTJi8ujbsFcPmiz7dQbSa/i0CLLSPmWQc6TOC+bAEtjf0SBQgwePzIZTKrVvGIcqdlAXyrDkkyhPC+uuyYdyYfyiOYEqRk4PREIsEIuDpbiYprTLiKW/lif4jva8HgkNfDWM7j0FnVYzhV83ZgHcPf9s6spihiqG+xzAmV9w7cVEgRF+P10oYDqKoj9MpTcNZtgzTk5Uff9bBqgDsxMTXF+m9OwRW9S5iPJr0JUC/8hrte5sPfNf4pQRbXVYY0CZ1sFlgmeL5Beal0UWhBRp0lXv5mGhLY8cXfzdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/83j5aeKAslI8Q3C4x31wwaBFDkPzZlyZkKSLdwK38=;
 b=MZ7FxXB6rriREwNWPIK8SD9BtuN3zB8vthnvkQi4O7U36SD8gvwS/VVHqGkqdsmDw1bRuPF2IGPIE72yNjsXb/Bisw//k73uaEWnabt3FQqkZHCDzdSmKC72he799ZGTSmMoc+7m09FHSYeZbsN//IILBOncAm51ILyXp6rmg0GETJ1F+tJ2IZ+tUqWYZQWykph7/D6v4b8h4snPoXHmjVXGijSw1nGnMNecucpmaIPcTGPqqYV2205dkxQwq8bMfm7+EMjsnCc0y5o6w1kUFpdLtpTP7XWjnZIZQnv0GPPbIG3iyA+2a8IubKSYjWUllDwwPPK7PSTv/UqYvKuYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/83j5aeKAslI8Q3C4x31wwaBFDkPzZlyZkKSLdwK38=;
 b=0Ad30mXW8Jl/9fE74obC+U1BzhVcO4T4jZLZ6mBjb9i97MAmGoLJFCoCowJGi4VAwM800gyBDN9ZtJ/pTG5Oig7hUIOBJMI4YSbH8sBKheTFEqTV8Qs83UaxIOUWZIrsMrDoRtUl+gYXrTRbIjNRPu7okB2aKakHQCaIDHS2NTo=
Received: from MW4PR04CA0194.namprd04.prod.outlook.com (2603:10b6:303:86::19)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 17:05:17 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::28) by MW4PR04CA0194.outlook.office365.com
 (2603:10b6:303:86::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Wed, 23 Nov 2022 17:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Wed, 23 Nov 2022 17:05:17 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 23 Nov
 2022 11:05:14 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] CI: Fix VERSION_REV and VERSION_BRANCH
Date: Wed, 23 Nov 2022 12:04:52 -0500
Message-ID: <20221123170452.27927-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT038:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 12153f7e-ef79-4d2c-0f9a-08dacd74e536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gdR6PaK5cIWUosuA4KbXAJ5ZxQM5WDIUeMrBf9JHKZCzsTbqakUNtayzZgH9kTTIOZajqXpLakPgVYtSQiYbxcyqUhyj0lRnT5m0w8LUrY8IxQOlmXJ3Ip16IYxZ/NIbV2JwPVEB7qMmnWC5M8HuS7udMYpTW+ZqY5uMvHsULqQFqVQpHY5EGMZm6lPQPdDF6sxbBhCgQdrGRFeghnYj2cJ1++dT7VboQC66F6yKtDKzdMGMm+4PNQAfZfhMWb2fYCMz26kfzUUtnuAr2MyVXdN5bLsrCFW4A6v6MuanVvIO3YfKzaTAgCXobuZoBs0woTsNIvbra3RBqsSkkVJ6BZbgXvWQDL8PSz73mVtD7v1ARDrK9immPBYm2JRx1zmzT0534Rz26xB9M7Mec2zW1aj69MCSKve2yq9pOk2+0pxth8NuGp3/pM0N80ZC2hNwA9t7O26VHMp5y40BobmFowRPBSVN09Ec0TOAWYN/zZ5AL3CwTmrnwJW7q0WerKgcM1phNIiw/2ZqR1QKBsQJpcwF92Za0ITD/D/Xxbbzrgped0XY119CVk0SdoH3lTDaZB81cUrlTixxrVgjpVP9DXWvJff9njue3qLL+qdEz7TB7LNhybG238Nt22JJ/ZdIb04TMVtqrT8uZ/Yxi9XimHCQIVDUCnf2ba+OY+FIUnFnEXyoCXwW50D0flG5WHlo2IIO7yNv/CFLP9uI1T0TFCUlelKf2j/caitif6VjfIo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(1076003)(4744005)(2906002)(83380400001)(356005)(336012)(186003)(426003)(47076005)(36860700001)(82740400003)(16526019)(2616005)(81166007)(36756003)(6666004)(7696005)(26005)(54906003)(478600001)(6916009)(40480700001)(316002)(4326008)(70586007)(5660300002)(41300700001)(82310400005)(8676002)(44832011)(70206006)(40460700003)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 17:05:17.0053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12153f7e-ef79-4d2c-0f9a-08dacd74e536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
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
Cc: Tom StDenis <tom.stdenis@amd.com>,
 Dmitrii Galantsev <dmitrii.galantsev@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the output of the version revision and version branch, so that they're no
longer empty after the listed change below.

Cc: Dmitrii Galantsev <dmitrii.galantsev@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Fixes: 7facf591681772 ("CI: Release RPM and DEB packages")
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 cmake_modules/GitVersion.cmake | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmake_modules/GitVersion.cmake b/cmake_modules/GitVersion.cmake
index 7db3ab32130bdc..44c0a67bbad3b0 100644
--- a/cmake_modules/GitVersion.cmake
+++ b/cmake_modules/GitVersion.cmake
@@ -137,9 +137,9 @@ function(get_version_from_tag DEFAULT_VERSION_STRING)
         "${VERSION_MINOR}"
         PARENT_SCOPE)
     set(VERSION_REV
-        "${VERSION_REV}"
+        "${GIT_TAG_STRING}"
         PARENT_SCOPE)
     set(VERSION_BRANCH
-        "${VERSION_BRANCH}"
+        "${GIT_BRANCH}"
         PARENT_SCOPE)
 endfunction()

base-commit: ae9fc1ded740af789ea56c93a7a946b6206fed9a
-- 
2.38.1

