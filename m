Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4428C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74134221E5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 11:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CV1XgkCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74134221E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C767C8984C;
	Wed, 16 Sep 2020 11:34:27 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760071.outbound.protection.outlook.com [40.107.76.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7619C8984C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 11:34:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFCP5XqhuBFTn7VluX33xqhGa7nsENzDn13wWwUXuE1kRq56K7i1xcE7p27Liq8mdtkREfdcxlXuB6p0UcyEPV+DILBztYX22x/0LdTv+gGx7FuKiDSTwGRcqbCkDEPa4ZKQVjc9aqAFUGU1u4jBRhtiwF9LlRBGORcd672lNSDs1xnX5KMHb0SzGbSLli5L/5OIwBS5hJ8nlEki7iZq5NH5WY5mP4OMUeHiCPs9ts6rQXXB3OxqL+yM9EYcxF2zcarPFHFz+QQkUImS6fww2A021nZ/GTQu39lhpUx3gr4Rcbsj4A/Y73yODbxM4+W0BT5S58gGxGia/IPYtwKfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6nhKEd+4V7PXl5pxw/60ELBbITGuK84elP0cNWsXCE=;
 b=ZXqj53w1NcRksA17SzTZx+Uzeaz+g+iVDx+Ztc9RJDRXzPyP6x1adOos3KowgzWvW+/yyGjOHXFfVrYrB5pfo2/pVtU2P/IXJBZNpYtjzSvnqKcCgPAV18A98bf0HOp9lWavdTh0R31axykwzPDpiFWOHV7RG8UiBTRsSXMSTDo2HnIP8BWqWL7o+2BovLtHV/EiGV4WYFgZ/tg2Cxqa/971FSEOlffvDGTI2slQG+Z28RqlULXlLQhQz6WNlHZLY9koGqmw5Vlle2lWA8DOVyWC4GHFcfFHlKdSlOd23OBqhMW8TlU62Kd1cmeCTdwDPNd6n0LU/L47Hl6Fjr5p5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6nhKEd+4V7PXl5pxw/60ELBbITGuK84elP0cNWsXCE=;
 b=CV1XgkCZujZgTWlszbHt/hVh1vj7E3nlrxg3ToVXleNT8JYBQv9G7RCRYq1j6lAjJX8BzUlK9g+5u2B3JOoUp2VAlinE3qF+oA25TOCBd0t1CNg8hus72a1jUZsPpt4jmDi5Uio4WDbO0vON+hctyVSnh9k2k+/nLQ/fnxv/Jxs=
Received: from DM5PR19CA0037.namprd19.prod.outlook.com (2603:10b6:3:9a::23) by
 BN6PR12MB1554.namprd12.prod.outlook.com (2603:10b6:405:3::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Wed, 16 Sep 2020 11:34:25 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::85) by DM5PR19CA0037.outlook.office365.com
 (2603:10b6:3:9a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 11:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 11:34:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 06:34:24 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 06:34:24 -0500
Received: from navi10-sut.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 06:34:22 -0500
From: Jiansong Chen <Jiansong.Chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: declare ta firmware for navy_flounder
Date: Wed, 16 Sep 2020 19:34:08 +0800
Message-ID: <20200916113408.19088-1-Jiansong.Chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4569df50-989e-47a3-7832-08d85a3476b9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1554:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15540F6B1BF28856D34C5A5BEA210@BN6PR12MB1554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoMyV2PQcYPuWKHYBOKVjMJAvCy5yFiebP98VRv2GZ6k/YUEHrpWVbVaDeFlKJsbjiglSh6rnhyEcVbYJIxLJenSEO/n1JuKcyolsB6xf5dBEIFHZYIUNfCY8qjJekxS3t23sNRGoZd3aQAnmxDFyb2eTqEPXxr5KA4NrB4c40+Z9SKCKWPX022ss5SfEaSD3MJ4yyWjlcLPpk6LY+BVR3mygzpLAqq18atagF3oyATCBNRSwjDDheBAsxxYVJuomRBfA1dcK6xCDUlxODww/fghxZ+1hj5rCw6+8QiXGiSZ/2+v4qFQiAw0nwYZPw32jWGIeMBNM8OuRP4s7cOuqeI6ZkRNcHe5fo9FM9oWrkeOH3O0BHfHhgPMOyx1AkAdHNbI6rDkbWpFeAaaQMnQfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39840400004)(376002)(346002)(136003)(396003)(46966005)(426003)(6666004)(1076003)(336012)(54906003)(478600001)(186003)(7696005)(5660300002)(356005)(81166007)(86362001)(6916009)(2906002)(8676002)(70586007)(47076004)(70206006)(4326008)(36756003)(83380400001)(8936002)(316002)(82310400003)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 11:34:24.8741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4569df50-989e-47a3-7832-08d85a3476b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1554
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
Cc: tao.zhou1@amd.com, tianci.yin@amd.com,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The information provided via MODULE_FIRMWARE appears in
the module information. External tools(eg. dracut) may use the
list of fw files to include them as appropriate in an initramfs,
thus missing declaration will lead to request firmware failure
in boot time.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Change-Id: I0eb0231d0e4672ee00ebdbe0bd8e75245a8c1698
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index e16874f30d5d..6c5d9612abcb 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -58,7 +58,7 @@ MODULE_FIRMWARE("amdgpu/arcturus_ta.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sos.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_sos.bin");
-MODULE_FIRMWARE("amdgpu/navy_flounder_asd.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_ta.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
