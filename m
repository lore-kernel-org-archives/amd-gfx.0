Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C99C43219
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE7C10F01B;
	Wed, 25 May 2022 16:20:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB36410E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjcS4ZMt8qlX8C46cLFQw5PLTINCESmqjLS0nqpnCF+KGU9JHeuOj/pfniZGRPslec9koOMOuosTcMB1H0z/8G9A+DdYqVJVPbpYkb56w1WymQGhsxMQ4NMiMIYGf1fsN+lSD4YdMTceb4oDIUINM06x+V8TZ5hrdJs4QUt5dTSy8SxWR0KJ1iQkVDVSMEwui4E04vW/2Dg+hu5n7l60nHhzyAThnSLqbHMC2A2OFfbGciUuEtV8+WvEjLccwvSs7oPkEfCe8isXS3fF4pkH53mavJyjqycQx0wyut52IztlqOi07FL8gQxPmUgCRCldhDtmIZ3geOE37zKK8vVzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG6cZarKgWfguWEgH2itSrSDk+27/6O5fFn9+4DJl1Y=;
 b=hvdH7q0jfp+t3VtZsnle4vfGbqV2QxZuy8x6FfiwzuML7Hs4hBG52v5lNE02CSZbctWRfBbOndGGKFoal3e5f9Ru0jzdyRcEn2HaXHkPkXwWJvdthfvZvRL5LoKs2LBYszDm61DbJTIu2/dEfeDVuPV+MrfsvaCyznpWUcU3DKqoxFglnL2tsjnMtyAmrX/KQr3+mmSvM1dW36/F4CfwWbwn68OS2uY0njd6OF0KjrQ6YJrKGIqYexaI5uA+mXx8/QpDsz8m/muPfku2FheLjMH75aT81DS123Lp1WDoZk9nyqzMTDxKVJ3zLhlBEjyXOJbqTvOUkwG/es98R6P/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG6cZarKgWfguWEgH2itSrSDk+27/6O5fFn9+4DJl1Y=;
 b=aTesh1nSpvwG5b1hzVDFediZ8dtklO4Ew4rkDrdK/tgWpAhXCKJR+55OJKxzJstg4YYSY782+OwduclPqe5VyOgqKYedmSutdwMX3uY+HOqlQRMoZ3At1i9vuB0nNreMM0YyOq0o0b5+NHYYUQ5BHexVjmnD/o4WBTz3MmOqfyg=
Received: from DM5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:3:d4::26) by
 CY4PR1201MB0183.namprd12.prod.outlook.com (2603:10b6:910:20::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Wed, 25 May
 2022 16:20:21 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::78) by DM5PR05CA0016.outlook.office365.com
 (2603:10b6:3:d4::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 34/43] drm/amd/display: set link fec status during init for
 DCN32
Date: Wed, 25 May 2022 12:19:32 -0400
Message-ID: <20220525161941.2544055-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fe364f7-9065-4659-e6cc-08da3e6a7708
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0183:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018399A248C27B930D4EA9D2F7D69@CY4PR1201MB0183.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PauBlxwei698Gy212bQwkYi6cPOJ/mB8K7ULKL2V6O6kd46osAeScMxT9ubSVNBTGm8UTSHdbl6LLJvA8N/7spS9k3/oaYqaQvweogUtIadeANvJzbJ4lgtj0toXe6Z8VQcxlJUBxoz3C9prlWqWuIRKiFnvf9YMS1gb14zZzKpgcD1Jc2fojWladsZBueFYheiPkUIEhXg4VNx62M/J7l32ACG7SW0gDCi5fbL4UT51Bq6gyTKgm6mN8tntBw60QgwfFM2ycFO6RGG7+ylYECH0oDquiiMMiyQRDhoXfI1zIlotr8wIF2Q1TNbWswFWKB3fvZbMhRv92OttPvjwShiZcGY03mhyjQF1N3U3mr7CM5Drz9uB2OsRlNcK5WkeHKCB3n6wVP2o6bIRGiutFEqVyS5MHF5OUb1jfItSgqifl2Y4D+qPq/1lx0KI3Cj0sSlTTXOOFxSpU/y/nC4n0+GayZ4w4rxTheAy0qCPF+ZSHTQakgAYECAnwrQueR1BrCcpxRSLSvPk0ybxUkXrpwYEx1t6QlFcWiFT8WCD7mcZFs2AHwk34eHbX6QHhNTQhxkxvccAdOcvCs7yw89G6MP2PEfMJ5BlKN2H/iYdzi0ii5NszqROc6GBK9btMu4pHXy0FL9cbLUAkv9WFuYaJiB5gspLdmzScf+Y6nriZP7ZyoAT01BOAwgm8TNXG6SLGAXvvIuXfRH8M9M5SLGBmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(83380400001)(5660300002)(40460700003)(26005)(54906003)(186003)(1076003)(16526019)(6916009)(2616005)(6666004)(508600001)(356005)(47076005)(81166007)(7696005)(36860700001)(336012)(426003)(70586007)(70206006)(4326008)(8676002)(86362001)(2906002)(316002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:20.9780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe364f7-9065-4659-e6cc-08da3e6a7708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0183
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jingwen Zhu <Jingwen.Zhu@github.amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jingwen Zhu <Jingwen.Zhu@github.amd.com>

We can now enable FEC.

Signed-off-by: Jingwen Zhu <Jingwen.Zhu@github.amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 5994edc3dd0c..04360553a43f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -635,8 +635,12 @@ void dcn32_init_hw(struct dc *dc)
 
 		/* Check for enabled DIG to identify enabled display */
 		if (link->link_enc->funcs->is_dig_enabled &&
-			link->link_enc->funcs->is_dig_enabled(link->link_enc))
+			link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
 			link->link_status.link_active = true;
+			if (link->link_enc->funcs->fec_is_active &&
+					link->link_enc->funcs->fec_is_active(link->link_enc))
+				link->fec_state = dc_link_fec_enabled;
+		}
 	}
 
 	/* Power gate DSCs */
-- 
2.35.3

