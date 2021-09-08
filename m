Return-Path: <SRS0=RbrA=N6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F47C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6643860724
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Sep 2021 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6643860724
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DFF6E1D3;
	Wed,  8 Sep 2021 14:54:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16416E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Sep 2021 14:54:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiYxPF4yYURrMP3Sk+jR4WPensCdYfUVrb6+1jAaXq05r2ovWycluIoXNfQehmg5Hbha1MOnf8sAn+vpGMkvakytR1U7QG4BJYlqsV5MhHIR4f4jVRJBgTZDvBgFe7XmjzrCuyuQOKlyiuO3dVz8p3fi2Nr71fjMQVTUziIjokfYxxPMEI49irRaqM4Hd3GaxRHwuEdhgdNLN7+Q2xoJTvtFIi3CtFpOgIb6y1LuaTOX51ijrBqUbeo3K0GRks7Tr9nYjKEF0CA9qK5u0WQQi4FEFzWSUCmW5QLfMlKUw+gIJIOOrbZccdlvFpQAm+3DKyztQupQU1v6KItKEW2U5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=v3gQVnxFnlhjPUEuBOHNNj0FFbMsYubwCbJvS+tQM8E=;
 b=T/2xuLq2hAHgp4NESKtepSYhsDOux/AiFTAyOEhICU7w1qPQlHCc8GSLQ+can67/3CNfF5jKn7RAqp4pz+aE9IdXbsG93dkaJ7CCOzgw3Z4E9b30pgVog+mTxWDknXuN2RDUVmi7bSxjj1NmmRnCxR73XJAQohW8n3cMFA9L31jpSRZ8sFHeHWJK/em84pbaA5xDyMqQxwX+wV1HXia6laNjfRAv+PgCa7LUmE1xix9CFwxBW/WT1yEPjBWw91fAPkIkxHegiRDM81iZqcS6MRM5QiqNs0SL2V37jUvoXKaiuTjPmid56meQKst2l77l1/abh5wZqZNuxV6KGzvPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3gQVnxFnlhjPUEuBOHNNj0FFbMsYubwCbJvS+tQM8E=;
 b=IG3LSioPF3wqZXaQmtSuu0AyK2tiMCsrJ0mKK3jwsYSTQfmBd+FlYnM4msVnAUm98QeaIftKKM1FHgXvnE53KZ3qxwYAY4T7wjNw9PveS5CChseaT4MA69mWoZ3hWqa2RvFILUSVsLuBeXSAtJtuPCTpZcH8EZGBVjeUfh07Qa8=
Received: from DM6PR13CA0070.namprd13.prod.outlook.com (2603:10b6:5:134::47)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 14:54:54 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::51) by DM6PR13CA0070.outlook.office365.com
 (2603:10b6:5:134::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 14:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 14:54:54 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 09:54:49 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Anthony Koo
 <Anthony.Koo@amd.com>
Subject: [PATCH 12/33] drm/amd/display: [FW Promotion] Release 0.0.81
Date: Wed, 8 Sep 2021 10:54:03 -0400
Message-ID: <20210908145424.3311-13-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210908145424.3311-1-mikita.lipski@amd.com>
References: <20210908145424.3311-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e5d096-dc25-40f4-c6ec-08d972d89e90
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121E475652D2B4493CECA37E4D49@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: roLZu+gNm2AP21OsZ7PTyOkO13OFA5MqKdCo7gL7GujfNBQuerV46RMLwZn2CsSwBPFxqoPI9KkxcfYkUrRc2BSaxo1+7BDEuXxHFD2X0m0WSY5w4SaIFVN58IzAApk4JM0Z70hD8xFwlYB8qkgbfhYQTAxlAGXlgpTZDFTs0bIxsEQCkPGF1+tE8/E3ydz4bYIYMe9Y3GiwIQ0Wqd/g10dKpMcrtMJU8WGMYK5zhFpeWy2M5JtR0oq4nRe4yizIcpF/zZeOPdcaYpDWyXokZNhHZZtWR8cVruIKrneectvnjsLLfPiyFuBEpjo5JA7oH6ip2HpbkNgHdrbPK9GpjoR4YLcfNZ/aLt+iJi3AgPP5S2DzViL8JhElUtdqD6p8NX7x09JyjZBIJsGMIffcBzf9COQEBcVNUf2Awv+y8+1865b6XC1kR5iHRDfv1FIshyeCC43V0bxfXAkt5bLMIiRg4jh7E/Xi2Lw/60BqDH7N1/53L2+7pDNyy8p7y18RBwvVgoCqIM4dcp++QwB77NobM914LaqjdarxLExkJ5s21AHLKrFqMvWxrF63fu1D5SJFBf9EDANtrmJVZOv/YvTPi79GhDrK+GWoRcLphc3lcFEKkUD8I2fNT0Hn1MbAPu/xBh9em8Qw2DI1hNzFno+OPvTe1oDre4deweaM7BG3yQwcVY31NgRIU2IIiomSHwMP2POtts+HUzSqAZPe9+aB23HnkElzaOF8n6pE4ZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(81166007)(2906002)(47076005)(2616005)(82310400003)(86362001)(5660300002)(316002)(83380400001)(1076003)(54906003)(356005)(70206006)(44832011)(8676002)(8936002)(336012)(478600001)(70586007)(6666004)(82740400003)(36860700001)(4326008)(36756003)(186003)(16526019)(426003)(6916009)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 14:54:54.7377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e5d096-dc25-40f4-c6ec-08d972d89e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
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

From: Anthony Koo <Anthony.Koo@amd.com>

* PSR optimizations
* add support for ABM when ODM is enabled
* Z10 with PSR fixes
* Increase trace buffer

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 3388188701d3..8cf86f7cda41 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x591aacca1
+#define DMUB_FW_VERSION_GIT_HASH 0x8ebc06e16
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 80
+#define DMUB_FW_VERSION_REVISION 81
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
-- 
2.25.1

