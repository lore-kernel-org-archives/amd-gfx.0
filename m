Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E658C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 02:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C17661050
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 02:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C17661050
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A896E2D8;
	Mon,  2 Aug 2021 02:53:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4476E2D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Aug 2021 02:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1oo0mvzfQUUtgwN6Fl3O6yqDQ0olfaT+ASdPbLmG0nKlumHQQVNS1wVViqFrmAEiWI/5u2mQVABHWvFExnu9rOHGuRXsWESUnRxXA/7iOsr19Eickg0AUPyURNIX+dxIUQgaBR7M8L5Q+Ef+OR/0s9HJrVu19z/kYek2fHPlhmXoBU6tieF4CFB/44B+ZrDGBmK5FZPDl+XloJZXcVMdMjmQwnTPlD6J6TcfIxbViP8oi9vPPNprVpFZFjj93x25vwyNpmKwRB+TrAjQjtm/7Pptj3WYTWknFGuCH2D2LP+r9yJ9STst2iCpv2G5fvcLDiQMKqjZMKelH7OlMuuRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/XZdrnoxqn8nUibQw/eMhXpNCuJYwD5v8Nec968YG4=;
 b=NbbMTI6INYa/DZ8QFQR0RpRyXq79iE157p3EXU1YLrpoqf6Ah4HluJbuBJZbYuChgQq9CH7Exhc0iXOvwKM3ygYcyh6oOAl/wgM1sAShMxYaxssb9/URbV1ax/qu+htwivjoi534Uc2qhE+zxRj3MvzXh4DkW+qFIBHmz+UAP7ns5U6K5GgDPU6JKmmEld31nor1vqvgFSL4vabsCkaR/+AWzktX/JZD08FlE3/N77bhwN0GBkoGUxALVmE3ZV3dib2nw4p/Zb2Xe9+OiQ4Xld0+xxK0017yr0ObtGUtbWz9n35jBQl8nEgUCmO9zZYlAg/wzso/W0LpK82DatwWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/XZdrnoxqn8nUibQw/eMhXpNCuJYwD5v8Nec968YG4=;
 b=H47D5sWGvlLYjIcfAn15MPeVgrilUiSgw474rhqxNzRwa9jI5qM8VpMZsrUiuVEl412C5gwOxUlfSipJzOJe3xRumgWVdekExUMuNfdYczNrBpat4Ko9nwGoFrwHHckIlOOHM5yQ/PWorceZSPAZUkvFiaH0pW/N/WfOheKEWWw=
Received: from MWHPR14CA0042.namprd14.prod.outlook.com (2603:10b6:300:12b::28)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Mon, 2 Aug
 2021 02:53:48 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::ab) by MWHPR14CA0042.outlook.office365.com
 (2603:10b6:300:12b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 02:53:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 02:53:47 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Sun, 1 Aug
 2021 21:53:42 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH] drm/amd/pm: correct aldebaran smu feature mapping
 FEATURE_DATA_CALCULATIONS
Date: Mon, 2 Aug 2021 10:53:31 +0800
Message-ID: <20210802025331.727141-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f2bc9c7-d5f7-4e25-32e1-08d95560c00e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4462:
X-Microsoft-Antispam-PRVS: <SA0PR12MB446245D515E34B0ABBA77EB8A2EF9@SA0PR12MB4462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beHbpI3IEX9shgLwU3pVFKCm4FcRWlArRq0nUDJBkSH2KqFCkeAF3XSX+EVTAZ7+s+AvJ4MP8GWi6VrTJoc95i/cGDXSzX3do4GRLxI3PfH6NH4GoM4EVXRrKJEnO8Kol2VXlvYcVjG7y+19CNvZbYn+5bc2dS1avVgcxQaqqbRaNeQ58sb/0PS2A6VptM1T0+YKDmvxr9QKUsYrE1BKLAUZ3tWf25yfFrfUvDvVwO9reaL3mDKF3C+xnf2vbCMJ0egIPUMeRZpn0eTKu3M/noUtXK30xXfKTDZO1reJujqQ0c15Y42srvwLJOpJBfMJLDSUSPrRMkjmIDsJHG7aZMEVbI0ElnImWr9Tx4pU3DZJgdsK5V1wgPwP1TdcPopt2jfH4yupIm98p3jp78arsHR7YLShb04f7V+QXduNbTpiFKG6ExaFU7cdufCX2gtd4y/i6DoxpecR1PSWvvGRUpIeb5ES7qKdGBt0aDwK1n9Oce3k3ZfawhMWt6lR8JNnKruLqNR/GkbPaVQX9qX0jDVvEDKovBvtXzKoJlf4YLKHWV8hbWNOLbDFVAxfL9DDe1WH2nUfZ9ed21HeXiiG5cD53BaFdQ5N0VVtUpoRcZmatDreaQL3tv93jsT2IHfip1kccsUQEcRm7CcMWl3nbYNAGIk6PhG95PNadDCS8OUDRRIDysj9WXhYUxe1My5bhYy8lOwTxQMTPZZ4IfiR0ceC7yzaMjQHlRfPJkorTZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(36860700001)(186003)(336012)(478600001)(16526019)(8936002)(82310400003)(316002)(8676002)(47076005)(110136005)(6636002)(1076003)(83380400001)(6666004)(82740400003)(36756003)(426003)(70206006)(81166007)(4326008)(2906002)(26005)(356005)(70586007)(86362001)(2616005)(5660300002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 02:53:47.5314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2bc9c7-d5f7-4e25-32e1-08d95560c00e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

correct smu feature mapping: FEATURE_DATA_CALCULATIONS

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h             | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index 1d3765b873df..6239c30fcd5f 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -282,6 +282,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(TDC),                           	\
        __SMU_DUMMY_MAP(THERMAL),                       	\
        __SMU_DUMMY_MAP(GFX_PER_CU_CG),                 	\
+       __SMU_DUMMY_MAP(DATA_CALCULATIONS),                 	\
        __SMU_DUMMY_MAP(RM),                            	\
        __SMU_DUMMY_MAP(DS_DCEFCLK),                    	\
        __SMU_DUMMY_MAP(ACDC),                          	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 856eeaf293b8..4af602d6ee02 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -64,7 +64,6 @@
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 #define SMC_DPM_FEATURE ( \
-			  FEATURE_MASK(FEATURE_DATA_CALCULATIONS) | \
 			  FEATURE_MASK(FEATURE_DPM_GFXCLK_BIT)	| \
 			  FEATURE_MASK(FEATURE_DPM_UCLK_BIT)	| \
 			  FEATURE_MASK(FEATURE_DPM_SOCCLK_BIT)	| \
@@ -150,7 +149,7 @@ static const struct cmn2asic_mapping aldebaran_clk_map[SMU_CLK_COUNT] = {
 };
 
 static const struct cmn2asic_mapping aldebaran_feature_mask_map[SMU_FEATURE_COUNT] = {
-	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_PREFETCHER_BIT, 		FEATURE_DATA_CALCULATIONS),
+	ALDEBARAN_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATIONS),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 			FEATURE_DPM_GFXCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_UCLK_BIT, 			FEATURE_DPM_UCLK_BIT),
 	ALDEBARAN_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT, 			FEATURE_DPM_SOCCLK_BIT),
-- 
2.25.1

