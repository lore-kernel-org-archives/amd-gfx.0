Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6355FC4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2077206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R4SUOmXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2077206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F2D89E05;
	Sun,  4 Oct 2020 17:20:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4DC89E05
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oo7wmtScNn3Iaf9tm+n8zX/CeuTb0/NsKFtSMF1O3F1k42U8f+vciCmaOED8+xq0A3uCqwvNGs9vfsqGUS4uKpRwUZVB33MeSCzDzXl9bCTfqCci0CiiSW3ZbLZZobd1eHmsXwiOqkDgUouAcsVAjRDkW1LhHson69gRWj+pkmNA7PGL3uNJu75ed11XiZlaecvlmgWNizT/4I5jRuidie3qrIAiArlaBeFAazAx20tJI/HUdGE/LislihRLxOAOKciwBkPU3PIunh3CYRgN0//YoDHKRdXKQTyPAYus93+ljH16Lg1xnvi9xI0IGZhwOtNoq2V/BHJwH8ya+abNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fnMWnZzHCauo0RWeCGAJJD1YmQC23ndBuGwrCbVHRc=;
 b=N82ubKHemHgDyrw1GWypBEXjUX5cleE0QuDTbM/nprpA7M8QCTNoqUipEUC+EReimGUfGBd4E5ZkNFFE8fu6dLtrsK/RXwge60gW2GMocWLUj8jHCdSBhj73VQdYi0H7WPzAjKCRfdATWK7xCBVo5mXpc2LPu9ZBsSAswe3iL3X5YIbgCfBBy1dMvf/zDCe/NTQRvBRn64hm0UfprZeN2Of0gHKanpokiEH1MRImbAoEISqdW+cV85HrNpIRu0xmQAtdhhRmmuQ1qqGCcBgpyu9qatkxzfVfXczqhxVcv4UhXWK604gq/wIfhPmeV8sRx2oHWG75dGlOW3crjcKkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fnMWnZzHCauo0RWeCGAJJD1YmQC23ndBuGwrCbVHRc=;
 b=R4SUOmXm3/P2Fusg6VO1M5UsF78QG5Lt2NU53Tnpo7SEVUt3QGlKHy56/2misYgX1TJxZvLEpWMCPDpNe87J2s8q7ZjxG0zqYRGOmSJ1jNuxDCIwRUYv6Ud4YS3xoDbW6qNoh66mzCbDaQNshAwxMiPfybTbT+xq4AHnDZQGSTE=
Received: from MWHPR22CA0071.namprd22.prod.outlook.com (2603:10b6:300:12a::33)
 by BL0PR12MB4900.namprd12.prod.outlook.com (2603:10b6:208:1c1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sun, 4 Oct
 2020 17:20:18 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::27) by MWHPR22CA0071.outlook.office365.com
 (2603:10b6:300:12a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:17 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:16 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:16 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:20:10 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/18] drm/amd/display: Only flush inst_fb if backdoor loading
Date: Sun, 4 Oct 2020 13:18:10 -0400
Message-ID: <20201004171813.7819-16-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: feecb645-c568-4913-784d-08d86889c3f2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49005978B89C45B8602CDD01E50F0@BL0PR12MB4900.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ns7lB//OOZqBH1DemhK9Xcqn+iVwSbeQVXiXeVik16bP3l0FWpd+tkvD+ZF+vlXQWVIMATzHmhwiD2cEN0XL6L9e0GsrcMsSp76hAHowTBnF9kXmz0WucDGHNXgjr9MjvunCdHPZ/J7rUMjxtdhcWEPi3BDC8yC4RjztCZQRbTFQc0povU6vQDh6/74mV+VTSb2evk6sXaGKTnH/G/5yLfnI85eGbGEAuJuGY0MvhNjXSoCZelV6RlHml1ftkBuRbc9E0X0KcWB7O5ojWd9giOBCm9tTt6nnkH0Gv2/YhC7ZneYvgP5i3TClDUh/hYACpc0O1NQQokxzN+Ugc+Nj9pDhSUjNRC4IF2Ck442x+Zw4G8DpL+thGDLPgi2JRXAgr7b+jxWLkqqbDfErz3O21A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966005)(478600001)(316002)(6916009)(82310400003)(356005)(81166007)(70586007)(86362001)(82740400003)(2616005)(4326008)(54906003)(426003)(44832011)(186003)(8936002)(70206006)(8676002)(2906002)(1076003)(26005)(47076004)(5660300002)(336012)(83380400001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:17.8452 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: feecb645-c568-4913-784d-08d86889c3f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4900
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
DAL resume from BACO time is longer if we always flush inst_fb

[How]
Check if backdoor loading to flush inst_fb

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 08da423b24a1..033ace4be445 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -404,15 +404,16 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 		cw1.region.base = DMUB_CW1_BASE;
 		cw1.region.top = cw1.region.base + stack_fb->size - 1;
 
-		/**
-		 * Read back all the instruction memory so we don't hang the
-		 * DMCUB when backdoor loading if the write from x86 hasn't been
-		 * flushed yet. This only occurs in backdoor loading.
-		 */
-		dmub_flush_buffer_mem(inst_fb);
+		if (params->load_inst_const && dmub->hw_funcs.backdoor_load) {
+		    /**
+		     * Read back all the instruction memory so we don't hang the
+		     * DMCUB when backdoor loading if the write from x86 hasn't been
+		     * flushed yet. This only occurs in backdoor loading.
+		     */
+		    dmub_flush_buffer_mem(inst_fb);
+		    dmub->hw_funcs.backdoor_load(dmub, &cw0, &cw1);
+		}
 
-		if (params->load_inst_const && dmub->hw_funcs.backdoor_load)
-			dmub->hw_funcs.backdoor_load(dmub, &cw0, &cw1);
 	}
 
 	if (dmub->hw_funcs.reset)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
