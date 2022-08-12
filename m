Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E554C00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEE99AE25B;
	Sat, 13 Aug 2022 02:13:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 607ACAC64C
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T55xanA5vZXcWNMoZiAyhlKRBWUx6hHlz1p0FTGx6El7c8Q+kysMg5XZcIRaBEUEAiLbNdMneSrE+HpkfmDJPqFoBNkFOnlG/aINRQYN0OvTkL0Be9jvFxtAlt81FFE84oUTvgVitByVSO0DDCtxg/YPcJthLgoomXeb8wZoDAJnWtHcaipRXpH+In7tpG5DXR/O/grARYCyvAmmm9zprJ6GGQ0O92eGrQIENa8X8ifR7EFOr5/LGuUY49ST9hX1OUxT5usVBXd0xlwaw2OKl1i6Bh5UqPeDxsE2MFSYyZqSxsQV2ITmBgdg/irmNaeRJ6fVXbppkQlQvxETBJ/L3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgzwnbWpm9T0c3EapGbXwLPHKNYq49B3sWgXWR3qACg=;
 b=I1LKRKMNwualAhJ3YBzig+D+O+qnV9DOfGHknXNd8M1WtLDC50j4j5QOZ8f6zHocgxkTX6pp+d9rdUB/HGz09+r973Wpb5Wc81775xFRy/yH/1fk3Icr/rY/Lb5s8hhWXjHEEXaeAdRXoLbFRRQnWYMTZDNrp3HEMm99+l1iZyqG/MVVBrl64NB6r/NfJv6gpmn5i0eK0lToZDMO4thFPWZe5qqQHWDKzRw37o4nhkejXEbtH70NJ9J4e3DamQpi0oA07592CgTPRwxuJkii4iY4jsIWgY6IwJU7wRMJ3QCklJockMgsRG5Q0uFuc+O+domGpPMGpHIulTGzliag6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgzwnbWpm9T0c3EapGbXwLPHKNYq49B3sWgXWR3qACg=;
 b=DqtNUGTjo1IkbIfxAa1P5R0z9T0r8d5SLYOC1QOwafoCM/lKN6mVhcpPXSdq83/gEwXJv/eZmRS5Yr1X6pawadgKorkl/OulbzZIzIpa8kz4udQ3BHI0l3ROS353v3zm0h+tqUdVdMDM8Oz7CLW5AIJx99+QxYIHxYS4LcjeotE=
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by BYAPR12MB3544.namprd12.prod.outlook.com (2603:10b6:a03:131::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Sat, 13 Aug
 2022 02:12:49 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::3d) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:08 -0500
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:05
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: 3.2.198
Date: Sat, 13 Aug 2022 06:12:10 +0800
Message-ID: <20220812221222.1700948-3-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a771a52-7b06-482b-3600-08da7cd151de
X-MS-TrafficTypeDiagnostic: BYAPR12MB3544:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+brlWbUYCZvZ14dR7gzqytEZkBSOLlyh1pCePpmhxXL6lH7DqGo8muKiR/0spkdg4iExJEdzeqhQEEnbx5A2Kyv4FBOBAv9c8erfLE6kQrkeNsOGvrsj+e/co304ZjaDH98njC9d8yKRCwBmsUvaO5sU+e4vcDoulYYbGFP0B/NTdTRmma0NgZf0k20eR2F6PW2lWQWiGBQai/sPq/2NJ6DCUXjZT/SEts22cR3fiWqk+fEHzoVGmUcjjCt7k31nXVthpPcvQpqekOI4mLSwkQtbfL+NQMkls9CbVz+BoR0lmsDlFGtZVeuD5sAqt3iHp6120JU//l77UIzDctJcZKHck7aG60HIQfBpRiys5lHoBpC2Jceo4O3zrh8p4U6L8onxQzf+GuzBIy7FN+TDbCUwr5ABHyV2ncML2tu8O5aR0AjFt40GqWB4Xk1FuAwXgl1wKSVtrbnvZ3oJ5jRJkytjsEQ+VKqXOoS66dFT55ASPBavwLu2kEzkKhWsG31yILxx9mk7G7KvcnNmGlY3DvKe9k60yeEbhZoBGBlukWccySswvotpPCo6xRh9pgSemvkpeKkmYYyOBgZ9lJN8RwvmmMdhgdLLzECidtEjETruTq4+6dUSc+DMrKXJq1SbkIHem5IVzSZnvILiR4+9UXlVuaBGRuL1Iq05DDCts50N5FnWMrM4IkKzYgy4O3vg/e6PfySCLv9EQdESwclSSNT9xzoe5vYYMoy4N9WpDNZ4PBEvztrgkPdQB090pTiEjCfVTPojZ5T0p9OKGhIACmsLiO9zvUUFrY8l0SYSAf3NMvEvUjPACVgXII19tCqJs4fRlup3ZI8wTXzmTsEXI0CN97Tyb3fRxwxoK3qAm0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(40470700004)(46966006)(36756003)(36860700001)(2906002)(83380400001)(1076003)(2616005)(426003)(40460700003)(47076005)(82740400003)(186003)(26005)(41300700001)(86362001)(8936002)(5660300002)(81166007)(7696005)(356005)(6666004)(40480700001)(70206006)(4326008)(70586007)(82310400005)(336012)(8676002)(316002)(6916009)(478600001)(54906003)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:48.9091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a771a52-7b06-482b-3600-08da7cd151de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:

-Fix edp panel missing event
-Set ARGB16161616 pixel format to 26
-Fix dcn32 interger issue
-Clear optc underflow bit after ODM clock off
-Fix issue with stereo3D
-Fix DML2 lightup issue
-Correct DTBCLK for dcn314
-Revert for a regression
-Fix clocks and bugs in DML2
-Enable SubVP by defalut on DCN32 & DCN321
-Corret boundary condition for engin ID on DCN303
-Fix FRL encoder override registry key
-Fix VPG for dcn314 HPO
-Fix Linux compile-time warning
-Add new prefetch modes in DML for DCN32

Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index eec3c7832fd9..5de2c445ac31 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.197"
+#define DC_VER "3.2.198"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

