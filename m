Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF61C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F29B20826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="I4/YRQa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29B20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416E188A72;
	Fri,  3 Jul 2020 08:33:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0378B88A72
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccguyXnHta/Gq/WZtz3PVvjbQmlS0OEH6jTbYxucnz1fg0wERvAWwgUEGXvYHReRAp6zpv4i2D+1I9KABK2Y+EnAdh6y1UfSJHxiSxJ9thrvy6jSoxZTlhPeYUOyqVrUUBUkCxBSz620lP5YyamO/8dwMp12P5uXC/iu73hASnASYPBYz+DbyJiCxJZ1ObDNdlGSMNsjUJuroIWr+Ee7hGkZNctM966abaQrkiNe2eZbP141x/ox0CY6PDOuAO+g4yI0nhjZXdUCB2w7ssVq5M8a+lEpFIsLyzshhRe/gpHntWp2Iu8naBxOGUIXjoOUGL68QXJubqqjLVW/0fScTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzIocWF22eFHTpuFDZfyflom+mB8XbrBLjG5vu4aHEU=;
 b=DEgt/evLowcCFs7qCTJ+4sWUAseVYOb80eXVXsIudUgArPr/DgnvQKqQ7taqsYDLi/eDNv1oOba1T8ED58HxzxWJyCR8WU7SqQjYOGWnCWNA8islAWu37JXWf5RxU+e6ESrO6ywlo9mTYwsszbYEeo+cRFP1M2oGIT3a7RTwm/radeK+xzgbPIUTVDAz4fxamWGLoEUPuIaxm5uyyjsQFmEvXHLru8u5HHrRJEXk1qc9KOWSI8L56Vjk5iW8oZom4np85ZayMtqf8b2VatQuB+MMfW36ErS5MArPNNDUQwgQ4TZVeva8GF6if9B5nERTtyhGYh2TwfiL6y+b65XjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzIocWF22eFHTpuFDZfyflom+mB8XbrBLjG5vu4aHEU=;
 b=I4/YRQa8zXswRU4ahz+ZHr2563GE8X+JAgJwcxrMNKjHy5VVFVR3MpaNKCTTKkgEBKMsmbEiPk8OlzCdT4LMDorrQ3JNJjjM1lb9OJgOBIXW0pfeF1efuIoqhVHybSBCZySNcXWKYlbngvYLbiK2xJS8XyW2W7kG0vd+sBvjtlo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:27 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amd/powerplay: add more members for dpm table
Date: Fri,  3 Jul 2020 16:32:50 +0800
Message-Id: <20200703083303.478-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:25 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67435b9e-77cc-4fdf-686e-08d81f2bc194
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396236F30FA771D7B31CCE19E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbd9p6Q9Q+gv4tdRuyIzwV0XWbTxTbrsvHGh7QLQ9hNoLKhWMGcjyOFdZqh3dCS+VlV6ocCI/YYJefRVlQsny+8UrD5ivpbAMhtfA/gpOld/rfO8pnCtVkxZlQ/2GNb6Hi/Qez2zX3jYg1QBKhhZrMnOFOL3UPFwjxA4ZKct3sokgaz1c12rFY/AxEYj8HJvl+92WGNFT4mVAqJBYS0bfzGsbM9LCz4SiBfEXuU7BKebuwiWceenYnoph+W0KCxZ9Vof4IGlkJ2HVSK626qieskeEHChCsMMvHGi9tRjZyC5xVlb4KRd+jKzjRfCVBA/x0TZMjg3ugR9R5cIJ+iXRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(6666004)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sDBsIhfjm9qJyDR4kYXa0Ye4Dl6Efby3VEIOS+TWP77z9I8J+/mUyWd27TJZFwNnku65faTUlltHJswwwomwEkqJf8LdnKr/OFKS7VLePtnGs/JRIS13JNp5WqIQB7D6fmpDDBuDqrUmWPrjwO0OcWhfLKhNUea+bFRrZGl2lS67+ZvnkMFxY+p+wp/NFJOVyFbEeno4LMxRcjcpRJV/RsxKRvwrSfdUzqR9tMDjCrFn02AJrdeHD2ilsQakmbgXB3SAfckhhIOuBpE20yeDFeHoXO2GCBqNDm6HAZjDB2QPUo9oQJZmwWKYHTJOWliriy7DJnQBaYhNLWC0pOoYLY46pnR/PQ4weGgYKyKdECKclv1deDFIhXrYDpCnIMJbQOfzS9shu2p2zneRBH9/guV/psQm+yYPzqkCFyxityKt2BgQlEYDtf4wpnUnSYA2AD7LOPMzNXrmlSheTYfeFId1TBh6J6clmk9VHkm2brmGQcZtimVkrCPlRF4Rcqwe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67435b9e-77cc-4fdf-686e-08d81f2bc194
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:27.1275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cvHWxLjBNYuvBpvSnL2k9vF8Pui5wrS6u4BVtwqVEEyO2Kdzf8++00Pw4PRTL5u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These members can help to cache the clock frequencies for all
dpm levels. Then simplifying the code for dpm level switching
is possible.

Change-Id: Ic80359adb8c0e018f306782f24e3f8906436f5e2
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 3d746b75396e..289c571d6e4e 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -48,6 +48,7 @@
 
 #define SMU11_TOOL_SIZE			0x19000
 
+#define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 2
 
 #define CLK_MAP(clk, index) \
@@ -91,9 +92,17 @@ struct smu_11_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
+struct smu_11_0_dpm_clk_level {
+	bool				enabled;
+	uint32_t			value;
+};
+
 struct smu_11_0_dpm_table {
-	uint32_t    min;        /* MHz */
-	uint32_t    max;        /* MHz */
+	uint32_t			min;        /* MHz */
+	uint32_t			max;        /* MHz */
+	uint32_t			count;
+	bool				is_fine_grained;
+	struct smu_11_0_dpm_clk_level	dpm_levels[MAX_DPM_LEVELS];
 };
 
 struct smu_11_0_pcie_table {
@@ -107,7 +116,9 @@ struct smu_11_0_dpm_tables {
 	struct smu_11_0_dpm_table        uclk_table;
 	struct smu_11_0_dpm_table        eclk_table;
 	struct smu_11_0_dpm_table        vclk_table;
+	struct smu_11_0_dpm_table        vclk1_table;
 	struct smu_11_0_dpm_table        dclk_table;
+	struct smu_11_0_dpm_table        dclk1_table;
 	struct smu_11_0_dpm_table        dcef_table;
 	struct smu_11_0_dpm_table        pixel_table;
 	struct smu_11_0_dpm_table        display_table;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
