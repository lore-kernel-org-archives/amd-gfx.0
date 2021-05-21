Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E869C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E03611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E03611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857556E5CF;
	Fri, 21 May 2021 17:37:19 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555B96E56A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tgzs8qXYzv2Es8oh1qwUgxNreuES2jBGE1KUqhuBiMbUhRikh4aD4+S4f0yMIZfXcEo1uDM2Ci9CsGwtHZCAkdnNjqcHFHi+5U3lFJsrhTbk00lUQ4IpUMT709fRoygFZF+yeis3Et36TKS0Spzg3OFT3GYRHXpBBKasjLuhENHeK1hWyFthoW6GAZ8aFbIq84YZuVHXGxyoAuk1VaonXnPwNTvbmYQccMVBGOwbQJa7fzKTAQYm3PA8zFMOSwNXJSdrsNGwbWLGVlcBUyjBxIESSvsFpgyvTwnTybZglbwprVsffFrDC3GJ0UAh0V5iCu2egWXYKzCjqbr/DMTw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L9/6T357sZ6UbvJ1VVZKSc62vUrXvCi0dnUOEUqZNk=;
 b=P/+9spEHpaIxkrVuyRvwduCoC3MC3WcSZDPwGizLcN0mmpYRin7YymDVngmXbyrfJyFMcb1+MW8DZlrfE1uQayNzsGxMMTys8nREBajbtasW9IaseX08j0uGR73raR8ut5k11qL+xhcNG+rE1UtumwE4bTLUnJej94DvRE8ggS6AEf8+ql1qati57o+6X7iBQF778xQd1MxR2RG+pCtrMig2NGLgPUSEEgmNQwOt9FcLvEm/YJRfm1S6e3S5SJjXufz5ogkuwzdlmZjPqIU4OQc1AMxpyawDA/Z/y1HAljfFrChBIKTYJmAPi6cRN1eN3za3GHPAqP8l8TX7Ff6JmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L9/6T357sZ6UbvJ1VVZKSc62vUrXvCi0dnUOEUqZNk=;
 b=QJC/tp9Pv8Zuas5BqmF7ndtcRSdlKLU/OrGb6jziorRbfjLRzmk2hmZ1ogRV0LW5CUuaS9cOHwizXmBWfNz2Ifqhg3fI0zsdq8wSjoT2hBg6FbbxpxmzJPdP+nn4ipGfcwaWdV0pToHPxHvUEHPpCTd3R5V9O1vP+LdPiyfyGCA=
Received: from BN8PR15CA0062.namprd15.prod.outlook.com (2603:10b6:408:80::39)
 by BYAPR12MB3366.namprd12.prod.outlook.com (2603:10b6:a03:db::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 17:37:09 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::db) by BN8PR15CA0062.outlook.office365.com
 (2603:10b6:408:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Fri, 21 May 2021 17:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:06 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/15] drm/amd/display: Add Log for SST DSC Determination
 Policy
Date: Fri, 21 May 2021 13:36:42 -0400
Message-ID: <20210521173646.1140586-12-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac45fde-aada-4b0c-db51-08d91c7f0f21
X-MS-TrafficTypeDiagnostic: BYAPR12MB3366:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3366389CCDF1168B45315779FB299@BYAPR12MB3366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tyKlQ/rYki+x3qlYzEOhdLlvfIEFBP2b2nCOBruU4c2HtOVTfxMD+0SB+7BLotX2pk3C/dnHTAI+NV7zwHOGQgJpjMRyYRAw7DuIGH356yO6vOEV82NiI5NmrcIeZcYkNF0d/tpD0i7NCJu6iIScpla/msnh2lrq61FnNDgVCWjgdgr0A6DDhK6/lbX2Q/WzdFgu0Fi+c7KCcGl99ZeMFwjNukU2ab19HqFq6i2zQwr/DPDw+/RKgHMVwZmzW1wm5PRtyYV45P3q/TUlyLXHTgpsEKCXNrexS0TuKPFGulg4RjEtvVo3jaAfn4zXKJ14bzZAyFRxvirbUOHXOg6dNdHMosrc7DFCO1XjwVv68Wmrm6JnCQ+i/6WO2F/a0n9lOz+4XF3wXlJfr8YGzjFlLdR43pXCHppAwFpzd0ClbGMfpwJnlco/ZH30gJY/i81jF1fUFdui3E5u4FMsvtl9LwREPN5kPjRpYKnZZhbr2PenFXPV/61B1blLoPivqMxze3op1mwXwApOygh9+dM5vua4W1yFxPpXa1xTI4cpm9rPnbSOiDBZ1ZZPRsXN5mfYVBMaZ4pp1ohmi7v07dr1hJ9HCa6W2yjqGW8y7bsgwLDiN9gLsz2/LdrLbOYDFynYYgKS/V9r0PBkMkISAgCtFpsC+SGNti7OiQgvXc9Q/g5BdKhIIVzS9YAFCy7+g82K
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(36840700001)(46966006)(82740400003)(70206006)(70586007)(8936002)(1076003)(2616005)(426003)(336012)(81166007)(44832011)(36860700001)(8676002)(26005)(5660300002)(82310400003)(316002)(478600001)(86362001)(47076005)(4326008)(54906003)(36756003)(356005)(16526019)(6916009)(83380400001)(2906002)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:08.9517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac45fde-aada-4b0c-db51-08d91c7f0f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3366
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

[Why & How]
To facilitate DSC debugging purpose

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c582c424460a..ac8dc341d956 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5791,8 +5791,10 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 						  0,
 						  link_bandwidth_kbps,
 						  &stream->timing,
-						  &stream->timing.dsc_cfg))
+						  &stream->timing.dsc_cfg)) {
 				stream->timing.flags.DSC = 1;
+				DRM_DEBUG_DRIVER("%s: [%s] DSC is selected from SST RX\n", __func__, drm_connector->name);
+			}
 			/* Overwrite the stream flag if DSC is enabled through debugfs */
 			if (aconnector->dsc_settings.dsc_force_enable == DSC_CLK_FORCE_ENABLE)
 				stream->timing.flags.DSC = 1;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
