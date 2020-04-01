Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531A2C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277BC2074D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 05:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E8FpkGRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277BC2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4BBE6E235;
	Wed,  1 Apr 2020 05:54:13 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam04on0616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe4e::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2520B6E235
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 05:54:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUpIsZAdOAcgF6JXsoU8Qt1cLRC8u+o1wWijGD5ekldIhN7PDqpMNDn0K4w2KNqiGjxdbV5UF0Qqdl99zT4VHfeVCqFLV1eq035poBpUeublw7/Pw7GtSnKPEYQd7OAm3A9FshyVs4Km9f6qY59/QCtWyv47nxblH5BqKUzWV0x7xmKj/PI/sEv+mzGywTSGZZt5ppfcz7k/V6lG7O/e+DTyJcJPyinVrYX8oFwduJ6BAEuPh6RoWLhaNVXBt89r29vSH6qR0NhEhfSySY+WQrmYLdUN3JKAYtRRckSfKyrdWiJQ+EBM+cUCwNwvcihnvrMY8qKot4NH9aOkdETGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFsPp8h8dmSnXSbK88ewUiPL7LgMl8SiEqTWL0ZNTOw=;
 b=JF9LwT9J18TJt0bKAy+H6CFwq/gv4T2nRFA7ZZlCzbD8ZwO1k6oVmNHB3wvO9z+LiWVKTHwZ394CBxgH3yPe5g3SIJ78v0zcvxpmxrEFPLOTCv8+RD+u9c8Ttf9p3io/MSgSGSHtQq8mCi/96EdqGXC5Lyrg4ZxNYjLn8njJlJp6wXLSlzA3F1cnMqXrr0MLHYMkztsLBHS9dfiq6jnzFQ/niRFrBqjVKes0L0wGInFTspBGhVT84N/JPJrWa19SX2qkNFr+7ean9xhgkxZ6j2UJloeVjuuS7tcKC1a/rwWSuY4qZs2wwd2aoTr3bGxWcl9pTlmjXD5OgucPXJoj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFsPp8h8dmSnXSbK88ewUiPL7LgMl8SiEqTWL0ZNTOw=;
 b=E8FpkGRecr6q/OzJCJI/LD4I5OxX+P6a6cR4wktFtF8GO30384we+Ux8ozXrjYFVIG7UIZ84LaGS+YQFTFGnEPsQ/ju/VRFzLHVB6ib/TBMU8NoZLzKC2998b8uPMU/Oc/SiMpbuDxAiEGK7wkSh8KJzNnwXSDUcvmTJzuWgHcM=
Received: from BN8PR15CA0026.namprd15.prod.outlook.com (2603:10b6:408:c0::39)
 by BN6PR12MB1123.namprd12.prod.outlook.com (2603:10b6:404:1b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 05:54:09 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::f6) by BN8PR15CA0026.outlook.office365.com
 (2603:10b6:408:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 05:54:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 05:54:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 1 Apr 2020
 00:54:08 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 1 Apr 2020 00:54:07 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay: using the FCLK DPM table to set the MCLK
Date: Wed, 1 Apr 2020 13:53:58 +0800
Message-ID: <20200401055358.15794-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(346002)(428003)(46966005)(70586007)(6916009)(36756003)(70206006)(6666004)(478600001)(82740400003)(356004)(1076003)(47076004)(7696005)(186003)(5660300002)(426003)(316002)(336012)(26005)(2906002)(8676002)(8936002)(54906003)(81166006)(2616005)(86362001)(81156014)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e57f7b08-a7bd-4a2c-349a-08d7d6011894
X-MS-TrafficTypeDiagnostic: BN6PR12MB1123:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1123F497B79952AFFCE78F8A8DC90@BN6PR12MB1123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03607C04F0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt8zFkXD4y+VFh7mhwmMGTcv7j8CLT7xB3Ds6ukFngOcjxKqUpaz9AEzcMuxkTeRre1G4uN8uVDFU+X7DGivhtcv6u7cCVEpIPybLVyaXluZs+SpPsniGTEKxZQBL7HmoJzpcwYvK3nFHYjHzbAKV2fvPl/FQypNshCJ/arjzi9vBF7bBlACHv6ZAwXQ585rSTurBUD+wr1rjgRESE1Un/NEzKXC5dRu8bS9uPgW4YAdIJ2ZUBdXfOzrPdjBLxitJWf2Y/6ehGFk9//AantYZPAcbdP/qf0umNcE/FZ56EvKwn+GkZAANets7kEoxUmeefoQeewm9GiDZOpKou14fVAcqFfVNSCCQF90FTncYf01Zn0wG3keim9Dnn03uf9lDL6Gic0NTSqpdaYQs0CNvMJ7MunL8kEVnmxQMBRat0upYrQq2bAu7Qr5Y/UGY36TJuug27eS3z5Qjzd0SUi1qPkJGg6DdM49J+i8nRMpZqRKvpfw5ZwQtFF7Kg/kU14LmvDCuFsIBVcz2oZmEphrTw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 05:54:09.1462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e57f7b08-a7bd-4a2c-349a-08d7d6011894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1123
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
Cc: "yuxiadai@amd.com" <yuxiadai@amd.com>, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "yuxiadai@amd.com" <yuxiadai@amd.com>

1,Using the FCLK DPM table to set the MCLK for DPM states consist of
three entities:
 FCLK
 UCLK
 MEMCLK
All these three clk change together, MEMCLK from FCLK, so use the fclk
frequency.
2,we should show the current working clock freqency from clock table metric

Change-Id: Ia45f3069fc7ae56db495cb5a3865e2c50c550774
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 9 ++++++++-
 drivers/gpu/drm/amd/powerplay/renoir_ppt.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 7bf52ecba01d..32e7a3c05cd4 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -239,7 +239,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	uint32_t cur_value = 0, value = 0, count = 0, min = 0, max = 0;
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
 	SmuMetrics_t metrics;
-
+	bool cur_value_match_level = false;
 	if (!clk_table || clk_type >= SMU_CLK_COUNT)
 		return -EINVAL;
 
@@ -297,6 +297,13 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
+		if(cur_value == value) {
+			cur_value_match_level = true;
+		}
+	}
+	
+	if(!cur_value_match_level) {
+		size += sprintf(buf + size, "   %uMhz *\n",cur_value);
 	}
 
 	return size;
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
index 2a390ddd37dd..89cd6da118a3 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.h
@@ -37,7 +37,7 @@ extern void renoir_set_ppt_funcs(struct smu_context *smu);
 			freq = table->SocClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_MCLK:						\
-			freq = table->MemClocks[dpm_level].Freq;	\
+			freq = table->FClocks[dpm_level].Freq;	\
 			break;						\
 		case SMU_DCEFCLK:					\
 			freq = table->DcfClocks[dpm_level].Freq;	\
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
