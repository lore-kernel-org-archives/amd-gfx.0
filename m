Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D44C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAB661D74
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAB661D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C637D89F8B;
	Tue, 29 Jun 2021 15:55:02 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7330089F8E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVnHBXZij/RgQtOU5e8MablXQ08ltK6TviKdVK106vmQ1Yd2gDFIhPokWTuvM5uTq51Jna3S5+brXD2O8eJWh25uvB1WTPz7FZj2lt6I+DFxq591pxqMH7STmaHxVrDKrZBo3AithKWnndOnpofzrWXIzSh4VW+3SJlTg33Pf2U1bwIGPtbjzGvzqF9GXof4LNr/dfXwrGSZNtZaguZcWx6oD37f0ELZkwEALCODueuiVFzfdc+m16UZYv8kW9xSMi123dAFbeIlr3BqUqghppMYxIU0nN9qYMSn+aB7G5J5P5Oqbf9Oz3+xJf8pzdBlVhsewHB6pNPmFtbkQVQ9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mvr90gNXnLpDvyZGQG63wbNepj47RmU1juj2Di5oZ4=;
 b=XOMmAD1UkwyovWVjyGGy5snTwoF8u6KkvlMpvIogbylcd7rrUj+/43wAwu4BEAexL9am2Zy0yLTYXhO8ww5lRbIUuNSpM4qifSEsRm0y2+yJ2hySE6V3l5cjEHz2ukc7SdfM5kDbB/CgfLu31eAMCI57C4V9yYZ+F6B0d2CVsGpus/GwDr5TXLcamdhjGDDna/v4RTl10mSNHIeJW16IFINUTKbyP0tpYZtNKCg8pupdV5vramHR7dk/vK936OxcB2PMELS1tDoz+/ehjHXIZR+Svos2sSR0whSd7Zzf6ImzfBEjuxhSj8xJjxpudz9cyw2sVKb/IW+nf2pKAl/r/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mvr90gNXnLpDvyZGQG63wbNepj47RmU1juj2Di5oZ4=;
 b=dKiGU36XzOK/2t+pIwU3ABLPLwNwPK3bDB+EeEFP1L7dufzD+EBlj6NYmGaIGgvJXadevG42l2YC/M3tXmVBa5fzTHyx6xwQo9aGXgWKPVejLtfwzUCGBWP9AzwvpWchRHA7Au1xnvnarXKS9qy/rAzRu6INQnX9P4Hp144Mn90=
Received: from DM5PR13CA0035.namprd13.prod.outlook.com (2603:10b6:3:7b::21) by
 DM6PR12MB3561.namprd12.prod.outlook.com (2603:10b6:5:3e::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Tue, 29 Jun 2021 15:55:00 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::6d) by DM5PR13CA0035.outlook.office365.com
 (2603:10b6:3:7b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend
 Transport; Tue, 29 Jun 2021 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/12] drm/amd/display: increase max EDID size to 2k
Date: Tue, 29 Jun 2021 11:54:22 -0400
Message-ID: <20210629155422.26118-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 062a6644-0c8b-45af-5fd2-08d93b164021
X-MS-TrafficTypeDiagnostic: DM6PR12MB3561:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3561149810644E0A78031AD398029@DM6PR12MB3561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJBHCJ07VcWPkVaykUenBTRfF6e0C7j07POSg85qM6qZgi4x9UUpkfhN8EOavFh39FkHub7Cw+S8kooia+t2875d9ImKKBajskqsmykLoldGgIauJp82ba71B5GGfmNbXNX2KeuiEynBF9tDahQvFNQG8W89eWODaDhrKI049HuUhxVULJhZDogpLycfrlJzjbL7Xn4M4X/gWOZWQTDrc+Z7YOMgViVS/dMKa2avPa+xvHaI7kwRjhtamZLDIy4Nni+XgtAm6/EHy8XW97sUvpHX7vbRJIT+LMkRa+dEI/ovpo8hYFM2t9kC9FWVP3oahbcQECLnOW4ACVCAH/5lsC4vY9xSOYNcYmJsXQaOtotNxKXekL0WeoaGcinYYAiG988Wckw9gvzu0jfifrdoFcTiTOOXId+lGG0eYzgBtjAf/yRX8ohS1/8btdbBmnZeJ/mLITuRbY6T/GK1Ix9XCbMGckpey7NzQF6vhYfpJFemGOshoy0cfOLKIQ+aBrHRc54wIcwRmb8jsh+9U6TRPt9AN3VjlZvMyjWjAQiXgCF8b1bv5vkEM76v7YBuEM2sTFjpFzXDJF/5R4wxb38kqeYwK+EZNRL3H9ZzCyCLXgsYBvI+6XTiAoAJLRQFu/nekrMymZ3GnaFM/7b8ZZZqx1QIRaBtPd3PKQOuJOfORi3wE7j0ThP6pmgi2wcf1p+ZmKJjjSwYcmQP4P9d6fUoplzk27PnQWqPozhGdrMxgsY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(376002)(396003)(346002)(136003)(36840700001)(46966006)(83380400001)(36756003)(336012)(6666004)(2616005)(16526019)(426003)(81166007)(186003)(82740400003)(82310400003)(2906002)(356005)(6916009)(8676002)(47076005)(316002)(70206006)(36860700001)(86362001)(5660300002)(478600001)(1076003)(4744005)(8936002)(70586007)(4326008)(54906003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:59.9814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062a6644-0c8b-45af-5fd2-08d93b164021
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3561
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
Cc: Aric Cyr <aric.cyr@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
EDID CTS requires at least 2k (16 blocks) to be readable.

[How]
Increase EDID buffer size to 2k

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 8016e22114ce..d8e80107b7cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -123,7 +123,7 @@ struct dc_context {
 };
 
 
-#define DC_MAX_EDID_BUFFER_SIZE 1280
+#define DC_MAX_EDID_BUFFER_SIZE 2048
 #define DC_EDID_BLOCK_SIZE 128
 #define MAX_SURFACE_NUM 4
 #define NUM_PIXEL_FORMATS 10
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
