Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89ECC433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565DF23AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565DF23AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757326EA4A;
	Fri, 22 Jan 2021 20:07:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC1C89CF1
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS5GOq+4g7xX+2j+ZPo/y7x9e3u0KkMWbORCjZuYjwBpnbpp3ubG8EIfTz7kXj/x2yaeKCgPwCiU5VFdFOA0FhyWVMCJgTkf8gG/tJVNdxgqKiD8cCwoyw9cN5tL4PEMq8BBDKd0yY7NYBVJjgtySyJ/mCuMbH3LE/PsbCL16Y8w/KT8rLCGo4vW6Q5iZGRM+xp+9SZ0ezN6R8preLuz22p8kIjqaSEY8fGz5eyrWMiSIOLoJ0eh+1y9siCaBDCMRy3yzUuNM+Jv7UwFCVluUC69LlxP5ri2QZa2auMkgvq2IDu2RL8Jf/qpWKy3EXejm3KuGWBM4Fq5QEOuMJbM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV7oFZ/8H1RrbvuehDMRPF+TfPso/OGH7lKjYFXGzT8=;
 b=be6jQI6iHjBdwTGBWMOqJLgoDwOa/xljotWHjOd0CSK1Ng+uNkoZYqwbmeFL3oA+TNkJIdwi/RNvI0L3uNh33imdY4ai1ExJTF++DDi7vJN2NjiBTgYg+I5VLgLnssKbVog+nmUIXqAUknp0M9WIRO8SZ34Gjhc+sRSBRG6FfTzOqB3CEGnd2GD5DcVGo+IXO6feFOoUKv22Jf+AM+TSRQVJzHQ+fmRLngbWxpH5nWZQE3jov65PA6k6j9NRfIKp64dRglcfCkKZ+81rci+/CWoRgTPt6D3fwdc8fX6XeE/97XMB5I89sw2fNjQdMqcK3nTkSJlwDnmkpriL2Ykbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jV7oFZ/8H1RrbvuehDMRPF+TfPso/OGH7lKjYFXGzT8=;
 b=ZRuq/Q+344jEtJxpR250RWEd7rXx34qyY8lT1thxWNxndrpZBOV2x67T3crC8pHA5osTiP0xnu+sQEAOjD1rjVWu/2I/fh6J0fXnConIlCPAQIC7mhcF2v7UwbMWvqZGR2AGTb+qxu6Gm9CtqbAS9i9hyfIkVpDiKBoTYCMHVas=
Received: from BN6PR10CA0030.namprd10.prod.outlook.com (2603:10b6:404:109::16)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 22 Jan
 2021 20:07:03 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::6a) by BN6PR10CA0030.outlook.office365.com
 (2603:10b6:404:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 20:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 22 Jan 2021 20:07:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:01 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 22 Jan
 2021 14:07:01 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 22 Jan 2021 14:07:00 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: initialize i2c speed if not
 initialized in dcnxxx__resource.c
Date: Fri, 22 Jan 2021 15:06:43 -0500
Message-ID: <20210122200652.197934-4-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210122200652.197934-1-Anson.Jacob@amd.com>
References: <20210122200652.197934-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f87e53d4-8cc6-46c4-2c37-08d8bf114844
X-MS-TrafficTypeDiagnostic: DM6PR12MB4862:
X-Microsoft-Antispam-PRVS: <DM6PR12MB486237A9781CEA18C4D72054EBA09@DM6PR12MB4862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z3XACliZ2SHPkIGKLfePb5vBvMQP2pvzLOw4nQpDr5uKIj2GxZMedbGdkAsE79br2ey2eD6VMb9rZzRxUJ9Esha8+mdPzyEjwxAPmMEmhVOe4RqFSzV/1lkqUAlTtEQHZ1QucMURzmuJ0jjyZwt0MRJb5deJ5yUWKCe8ObN/CLfsfIzhRR8kakbSfNqEU6+q3hcoPw+VOY5yWuctav3P67UwRQfykOnACvUeP5EytC7YQ1x19MK1Gh6tzjTZVcAAkpiskNnouEd5/gz47+I+dHVYC0+Ri7wfvaFgFxPBqeEeyIA2iU2sGX4UvG0nJZ0q3zxb9ckNoEQ5CdJv0cYuGsZFS7N981yIqhtZuKFDjQ7fnC001SLhJrUnDzzG38fHNOMLMRmncPm+GLQKL6UiFo7GfdgwXKBTgRWOCtpYAZnEoVODyea7708TqiGwvJ+HbfPSWT1mlgpLMUIr4Srflch5Boaatsgqe78x0R14wscCPbwF+1z6fFg4CLs2q8VMhfuFeODVtrrdN4PhoNwHvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(2906002)(6666004)(1076003)(36756003)(82740400003)(8676002)(86362001)(82310400003)(2616005)(7696005)(70206006)(47076005)(356005)(316002)(8936002)(5660300002)(336012)(81166007)(26005)(70586007)(54906003)(186003)(4326008)(426003)(478600001)(6916009)(101420200001)(36610700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 20:07:02.0262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87e53d4-8cc6-46c4-2c37-08d8bf114844
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: Charlene Liu <Charlene.Liu@amd.com>,
 Brendan Steve Leder <brendanSteve.Leder@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Brendan Steve Leder <brendanSteve.Leder@amd.com>

Some dcnxxx__resource.c do not initialize the i2c speed; this patch adds
the required initialization at dc_construct().

Signed-off-by: Brendan Steve Leder <brendanSteve.Leder@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aa9913092b92..aa89e521afe9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -761,6 +761,10 @@ static bool dc_construct(struct dc *dc,
 	if (!dc->res_pool)
 		goto fail;
 
+	/* center place to initialize */
+	if (dc->caps.i2c_speed_in_khz_hdcp == 0)
+		dc->caps.i2c_speed_in_khz_hdcp = dc->caps.i2c_speed_in_khz;
+
 	dc->clk_mgr = dc_clk_mgr_create(dc->ctx, dc->res_pool->pp_smu, dc->res_pool->dccg);
 	if (!dc->clk_mgr)
 		goto fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
