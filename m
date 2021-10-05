Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D852C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41036137F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 08:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F41036137F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98AB86E342;
	Tue,  5 Oct 2021 08:02:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6321B6E342
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 08:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyHIGkf+OEH4bMoQqzXm4zaJf9hL97R2epl4W8/ZKIlpB07tklI2oq5nCWmfLugYKa5UdzcsDttMpgYedqGzkpdGgHOpSMD4awA8Wipen5eb2AmXQmWhO/a1/PMotX5GPeixeXc01mBhjTT3WnL7qJa96j4U7jHo9w8OIjH6DJuBFYnAqHE+1yD/ezYfCG1jBEKntdrslraLG/Cyts+NhZaNp4VOfTMRkkoGEPu/z50/F8WZiETlUG1MVZ0KjpM7BdfVS84mZHC1Cxy5l3pmfLo0zijEncdSuA4ZcwwYdyggfLE6KiS+gpmqAfQUrpHVvbpXmckBkQDxPeOgEVcb1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgnWkr4YPdXiBUZw8/4Q4ptIwbpvbcteSmZwkEhRVD8=;
 b=ZstijazyJxDoHhPkLBxxqUi0cTwSyncYEDlWPsY7JceE/rgjEc6XGBJldxzP410m8kWM4mFHxy4uI2OijZO0/9GvMWEQOLK7VN5mZOhVNRy6qEhV4PCNWFnVGJ86S99yI+YWlTIE4cHf/KGdZa4Yj9NmYxZ/ffcDrb+e79W1UNKVHxm6YkDzbF6fKqeb9O0NRipqN0Wpo458jfEwMs39jfPo4QdzxHKlRCbX2kWvq+7SgI1H63MAQaUcsC0jRrdGPsLdglpmiWq1NTi0cGT1Ak3zg3O82spFXzAhTdB0sT1QJ4w3nNT/GYwoNb2bOMbZsYFQQGf4/8lm7wwmzpqZUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgnWkr4YPdXiBUZw8/4Q4ptIwbpvbcteSmZwkEhRVD8=;
 b=0NNxB/oYWdKTvCpi8kkF3kPxcQN2nFcuVNuKaOT3VcqvD2XGun9my2H5Vttpql6LgNtMfEUQfvW5rJYoaZJemgiIoCgDLD2hAXo0hkv6Y2ceTzEaTa0yXQgvhqqZoECiHQ26AqBSGzXa5g4qgktZUkPLsfr3x92DsaTC+CGRRw0=
Received: from CO2PR05CA0084.namprd05.prod.outlook.com (2603:10b6:102:2::52)
 by MN2PR12MB3917.namprd12.prod.outlook.com (2603:10b6:208:166::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 5 Oct
 2021 08:02:08 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::73) by CO2PR05CA0084.outlook.office365.com
 (2603:10b6:102:2::52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Tue, 5 Oct 2021 08:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 08:02:07 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 03:02:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 01:02:01 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 03:01:53 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jude Shih
 <shenshih@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 23/23] drm/amd/display: USB4 bring up set correct address
Date: Tue, 5 Oct 2021 15:52:05 +0800
Message-ID: <20211005075205.3467938-24-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 058157d7-ea92-4537-e667-08d987d66d43
X-MS-TrafficTypeDiagnostic: MN2PR12MB3917:
X-Microsoft-Antispam-PRVS: <MN2PR12MB391729C2B2B5293D7645B5DFFCAF9@MN2PR12MB3917.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfO1LwcnT39YFyBhQ62yv2bi8Nk/lvAdY2K2B1Jp67CIMqL16RNmiXgLA59vPvDEFxQ+wMq4s4Eeyb1zojI0uDGkMFCfDIMObUT7kAl1DymzX7JRyP1AK206RM5EPtI4BLkK9BxPKy47dGw0VBXjygwcqsZRQoqG6zN+9hom/X6JqpjcmhMpRHHiXmmMQ/YJIbe52kkoY8wrUOe/f8xn/A+sFzqMRPKr2C5zeHlD+QAyUM5Yxs0r+tjwkRQog0l8jkeS2BQTs/eu8wtX3wf8jYO2n/yjc5IDDYbAoYR3Qf3abywOmxr5T8S7JnhW5douyDG6Abck6OXO0ZlQEkrFBAehkfxeT8DYtsJNleDvqXgeCkDAge5lK4eK93CrOhwvajl9sSlBFg5e3w3HqlAKXPtEPOsphc1SPLSCfQj/nTiLkqGEAm5Uc47vDBTnbTX7R2JW88i0H6pxk8NRda7HZvlyu7NC+gpg0mpviuEzkluVEGPEfCxQd4qbENNKGR34s7YGJhIs6SyDAri1gHfhy739MsPh1R5To6gTWHE7mitUAmMOruhH3VwS/OLHrbsqqHib4atP4RBENH4wxfD51ctKZSgzDZkaiuMriN27p7GfbqyELCAfRcR6LRxrHZko6rWhSdrI9+66PZprYooGAezAqW7cHIlzTRNi7X67M6yyhRV42Q8D+IvutsyapUQa7le4D4UqE3/DPci7SfOPPfZy8OqN0tAgb/IMD8W7Fl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(6666004)(4744005)(8936002)(8676002)(54906003)(5660300002)(7696005)(86362001)(2906002)(508600001)(83380400001)(70586007)(316002)(47076005)(82310400003)(356005)(36756003)(2616005)(6916009)(1076003)(81166007)(426003)(36860700001)(26005)(336012)(4326008)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 08:02:07.4016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058157d7-ea92-4537-e667-08d987d66d43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3917
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jude Shih <shenshih@amd.com>

[Why]
YELLOW_CARP_B0 address was not correct

[How]
Set YELLOW_CARP_B0 to 0x1A.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Jude Shih <shenshih@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4a2dfacab4c..a9974f12f7fb 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -228,7 +228,7 @@ enum {
 #define FAMILY_YELLOW_CARP                     146
 
 #define YELLOW_CARP_A0 0x01
-#define YELLOW_CARP_B0 0x20
+#define YELLOW_CARP_B0 0x1A
 #define YELLOW_CARP_UNKNOWN 0xFF
 
 #ifndef ASICREV_IS_YELLOW_CARP
-- 
2.25.1

