Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE049ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8722510E823;
	Wed, 14 Sep 2022 03:58:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA1C410E823
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:58:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LP9Zm/0FPYgqt0wkdjiGsOF4mNK+FDVjURoidyTcD1NDWXNWmiKhgbYtTgjaA5jlqglxj/gqLJCoFyRG2Nnoq/SzFTTLPSBhwsdVQijDnZT+wTUaeJjPGUjZ0bd4piRRQ7u5cUjO/I11ovCbp7CkNdmMsa7lD6AiIgLfLQ4dL3txP3l4yZQkeew5CcMRrysU+SOo/ZfFR474ORAL5Jvklwj7SvePURFrQIQxcwfZsCp8FUOzGH06Hy3hqjm2nqmrUmP1/wP2Xb63inQr2FE3fVNvtYU3eAwOZaXmSkHi3G9b857eG3ZRgTrdokcv3CA9iKUuJhDqxBfA43K4qJelew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDzVgp1Hgr/5HX4jZ4ykuVE0QG4hWoD52N/C/1U+n5c=;
 b=RtKz+RC0UfR32C2Rkd+K1VCBLVJ32vvdvyRZh9kemcgr6X+AwqWMhrMV1+WNR+izl1ZUlNgWtBIPhXcbCHQ8YOEP0Xc/o+g+BR05bs9gfA+1IUS/UAvjrEsrXiLZpIqsUdbXIYVa7dvucF4uQbiaBAeksGKoW5wr4UBS8LvIDg6wTA0fzbkXbex0IShN0M5cNgcZ0zncKv3mTjIIXjTsfok0z8O38/Mw2o4ejOS+g++cLjvyLZS4FkrFAfsC/zcM/QASEg7bRPl96UPisnbgcaXp35chTd0mQ4AhNv2RuqSc11vKCsrtSsyNGRk/bhSI9IPGImjVvMClYn2gE8LASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDzVgp1Hgr/5HX4jZ4ykuVE0QG4hWoD52N/C/1U+n5c=;
 b=uBOVQjYNT63tzbiyansGcqTgmPVYY3iH4nS7YAOSu/1bYmTZp3b/4xW4jTg3fEbCpfOKvtjY6oQPNBI4cxvhFeoBwFftdcuCesg6RaO3idz/vdB5TKrCa4bavLcVwlFjqOgjA1zOkPBW34BgXudhIopZpnX8gcaTTYDHQwPCYFg=
Received: from BN8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:408:c0::29)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Wed, 14 Sep
 2022 03:58:03 +0000
Received: from BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::fd) by BN8PR15CA0016.outlook.office365.com
 (2603:10b6:408:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Wed, 14 Sep 2022 03:58:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT077.mail.protection.outlook.com (10.13.177.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:58:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:58:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:58:00 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:57:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 45/47] drm/amd/display: correct num_dsc based on HW cap
Date: Wed, 14 Sep 2022 11:48:06 +0800
Message-ID: <20220914034808.1093521-46-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT077:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f2f920-e996-4a8b-d7ff-08da96055264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ATYZpt+GfYg1d7PwywksVGAYEHW3N5PE2JlZiQSq2sJelRqGz+kvCsiyTkx5fW2QDByEU3/LrsoB9uSH4UkfLJ7TilG3GnMG/aHtLmHoZk4uK3iaFgaPZVtkYTiuDQygKS6lS1t85liEssJqKlJ6Pr1fqZ0RqEW5fJ1DLCU7Xy50pvxG/je/AIOhujCkwH7juYGvtJj9BjdPWzuPQFC9uwq9end2CB+K750g4svZAxYbVffNMDWP8v47OxAnGa5N0otsue83w+lVp85mUchZlEfRrDlMv+BLttpZfTWaHXBDfXzYvfYeDjwTzWIFulJoC1UOHfob+5DQUr+USdnJ3B0y2lx5HCqkcUQhF9/dtXEopzEqpNPaL7c3Q+1fLKftU9PPY1xP9n6XCB+XM/MnDTj+ZS/Jj5pBNvvymEaKZBNyIORP3ViWAvHwozDfWyGuOC68MuNYzDwdBfSMRjlVPPUi1OhmzEPAK5sLTmRYT/HIbtnZz6Wq+0nU7LgkLEkP03bEl1C5yXo6t0dBnsYJm4XPY5aAJiwEl3+U+T7pzFySmNA+DRHDKVokCRyZ1RmFxzrkk6lq00+pHOwJVXYKt525PPdLqHTEux62TpgXElIFyzCVL4rx8P7VejiASLU22U3JjGJBZJdRNTSQgSFhqSwV6A8uV0M5JNxj30YwHtNyyjlxquWWGM8jU/Ao5VcVu3HIBzVU/hKt+66qTMctUW/0gnRvxxp8E/MGIrKyk+2UBaBWgCokxq6PWrK0Ds3GkYXQ4DDeAvZjhFsaglR4lucXITC8VNr9sQB0QlTum/twzIkJrCZ/ehUzGafEF+3k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(7696005)(1076003)(70206006)(83380400001)(82310400005)(478600001)(186003)(6666004)(426003)(6916009)(81166007)(316002)(26005)(70586007)(41300700001)(40460700003)(336012)(40480700001)(4744005)(36756003)(8936002)(47076005)(5660300002)(8676002)(82740400003)(86362001)(54906003)(2616005)(356005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:58:02.7065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f2f920-e996-4a8b-d7ff-08da96055264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
num_dsc is 3 for dcn314 based on HW capablity.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a6c5ad9b67db..24ec71cbd3e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -847,7 +847,7 @@ static const struct resource_caps res_cap_dcn314 = {
 	.num_ddc = 5,
 	.num_vmid = 16,
 	.num_mpc_3dlut = 2,
-	.num_dsc = 4,
+	.num_dsc = 3,
 };
 
 static const struct dc_plane_cap plane_cap = {
-- 
2.37.3

