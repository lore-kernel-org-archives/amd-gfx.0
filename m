Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6625FC7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FE010E3DE;
	Tue,  9 May 2023 22:07:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B248110E400
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcLXb05NQkA19cHk1ptC3qxT6p4ccShKtAmUEMBak4HiTsT8IAIl/1BLlR7eIiXcbFAYZcgRc0KiVEYMBr0JWJEx2Jea4jdg7N+1Ghfo96EtZWGLMVnZZan3GzhN75S/rM49f4+jWnFaMBhHHEev0VYJcQgz3U9vdr0CN6B0hovqX7AWYLLIcGkq6ZuTmrDIxshPcTsyAXcw7320+O09rDcu5SDDS6dtM0DIMXLiBSh4pvVnxGgcLMujpxYpddeu473PfqfXdDZcDVM16z0Q4dii+x6H3C20K7ypqc1UFtyYhkuAbnKadT2tJfn+/CEsY5+EjNSmWn6dCvmjV1pVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7orqH+nQaFM4gxfsgMqPtx7Nn+SzuTEeqNb/5r3DVKo=;
 b=P7JN6bMDVfgMimKG2kSpC658I69NAoR8m4bWQCxR7CWWIj3Wft4Kwpr/mo62A6JPjczY/eeoQ3Q8pifIID5pMQX23V03C+4jGBw32SQ+LXBDk3aB+isUTwPSpOUbC2iw0z7GU6WYvW2uAXMkmKQrYFyQIit/GpTTvBcX3oR39Za1ZexSptfEFAc2TXP1A3MUCp1WlNVAZCA1SuW+4GO+NT6TNttZQsQiMHXjUhHe6Mt7hgglWTQ0YidA+eVoNeX85+pvDU6YGsBuKl1iiO6KXu2pad1P4F2hPGdngtMs6oQpd53aN/7MrS94YezzWsfwZS8yBT7gp3LvfR4yXplhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7orqH+nQaFM4gxfsgMqPtx7Nn+SzuTEeqNb/5r3DVKo=;
 b=IeD6Z3+wGhlYzt1zcocbm/sGu/KvaxtpsVWPi0lWdXxaXIQyD0Jxh6gNkOebUSBL/xoG+2xVb8BwlZ0r7MX4YA0D64WPnG9g2UI2Kx0k3VZ8M+0X2Q6vn+l7EjpmDXY8lzTeS+JkAcIMa1hoLAnHdmoSvHhCTgyMomiBlP4trHk=
Received: from BN0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:408:ee::11)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:07:34 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::7d) by BN0PR04CA0006.outlook.office365.com
 (2603:10b6:408:ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:07:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:07:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/pm: fix wrong smu socclk value
Date: Tue, 9 May 2023 18:07:14 -0400
Message-ID: <20230509220714.475369-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 62073d83-99b0-4ae3-459c-08db50d9cab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCDwdLBGlv9oz5TVorjFrj0T/cCijurF9mIhVYby44KretCFyhEN8p8bD9zsh/HOGTLuWxapzk8nE2flTMD0cIwjlKxZkGurT0G4vTJbWogt5Mc1xlUUpaZcPwc3+FTBar4gJjqNE/eY+3bkgkNjP9T1FeEQPppclzn9czs/MkLf+Qx3zDG/o2mHXQcmGivJw+MTmXz1yUUB36JylazPdkvblue+uXFsmOUQ7w73BrW1nqZhxp+oJfWwCVF06EJJH8Vl5CBoJgCGBykv4R5ThVLUuukaJWkvaLrDPbLTtjiOZZi6vGNqHuQypVOjqAy8rERn9n84GVokGzftraaDjSwWdGBiPEX4ci3kzn9Q3K1T5c7JigNRuyTHnHV+Jttbdy3rjqej/MZmYfUDXWFFxLUvd2+OzvbGkCsvXgH7DtxGGekMZzVhSN/TTyLjtSY7yrNj/QQnVTuX7xrfXzfhdlf0xUluXTMHFAg0O/LwKLSzA9OGmyuVi0O7lwaJA2ws2/GekOP7muwl2eIIS6S6Al8gel15Nx1JTwNuZkKVq1gLZOaESNwUfTyyXwIt5C1fDXVrCW8gh7/smMigFH+R95ouKKJEIU/XukMjPTbnLWkSAe8xJK4VUWWNO1JRlMUyCZ37p4Xr/ql/7beBmgcXdcb6D5FjEoSdxZKazHAAaMJo5aVWCkaBu1L8vhcitcieph9THxmW15Bf7T5GFe1iVt9nJ/mf0u0eRu0IJawXXKc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(316002)(54906003)(6666004)(70206006)(4326008)(6916009)(70586007)(7696005)(478600001)(40480700001)(356005)(82740400003)(2906002)(82310400005)(4744005)(5660300002)(8936002)(41300700001)(8676002)(81166007)(16526019)(186003)(2616005)(36860700001)(1076003)(26005)(83380400001)(47076005)(336012)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:34.1787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62073d83-99b0-4ae3-459c-08db50d9cab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Yang Wang <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yang Wang <KevinYang.Wang@amd.com>

fix typo about smu socclk value.

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 4b808c0addc2..a712b2bf2d25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -387,7 +387,7 @@ static int smu_v13_0_6_get_dpm_ultimate_freq(struct smu_context *smu,
 			break;
 		case SMU_SOCCLK:
 			if (pptable->Init)
-				clock_limit = pptable->UclkFrequencyTable[0];
+				clock_limit = pptable->SocclkFrequencyTable[0];
 			break;
 		case SMU_FCLK:
 			if (pptable->Init)
-- 
2.40.1

