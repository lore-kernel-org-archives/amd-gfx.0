Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DA0C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BDC12065D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pn8EpP7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDC12065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FD089EF7;
	Mon, 17 Aug 2020 19:33:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B48789EF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 19:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMAyfimcOmxWU4/NyoS8JVikO4p8HIKdQ4uL3xnIiyFCsU+tr3jKMElse1zIePGas5AJWnOuA4v/L3Qxcev6fDTiCv4+IQVO/nsUVT1lAjRHciDuZ0lft/5sww497n89EgtMAMRp+9M0ggyFQimWLUpkf8ck4fyKZ0Das4kx1Vfqqxp5b6Ofocr+uCQM6qyPgWIU9Q7dhpCSJm8HBsVO73bPOaEVccSUcSnrXN6TXvpMdibXp14f5HUB0+SDGfWgfcI0xDbg5D8WUS4v+KXFi51z3Fcc743/51WmCdOzzMFMulTkZpEczWtgu7xHhvZUHa6H36Ku+PcFUQcwTlWr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE0BAX5PE0gEN8c9vqT7a8bK7jvZfc0RL84di2dDpnQ=;
 b=m3dR62cdJ0sfwKKMTq727x/ZxnOk/JTXyxNoc6J8OxHIuMjc9wVrHsnTPCkRnHANk9P/YUMKtRcmqEigFtK0FsWYQeyokKgpjyzHCy5GNtXRPORJ8qsirbu5qgpkUSEUnOsela8JxH6AjNVJs3dd7H9Vy1rhdCBJGyDHcUOeA7mC19hdue52f7TFTNCX36aV0QnxMk3GKrHohw75td7zA5CqF46nbmMW9tkS2Q/GexpujA2FQNg0Lg7SKyZgH/3JsFj5ex7dL2wXWIAnN3dlR24YBnqQ/9bB1u4HHcMqSJDrIWgVp/Fi0MlY+pZa0Idfq92bb9nGNeEXy+RWglWdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE0BAX5PE0gEN8c9vqT7a8bK7jvZfc0RL84di2dDpnQ=;
 b=pn8EpP7/LZOnI3PGeH+gFApehNY02LtBsep3/4r4P+uPKJL5yhP0wDgvDL4j8ha/+KecSZY48lEiviTZdKY269BktImp2tlGfdkQeXxZA2yXO+aAGfH5W77fNoMtjvbdwPZEEgi49T5+AxNG0yADiWVQrDaxjAvoWWHHV4uTw+Y=
Received: from MWHPR1201CA0011.namprd12.prod.outlook.com
 (2603:10b6:301:4a::21) by BY5PR12MB3748.namprd12.prod.outlook.com
 (2603:10b6:a03:1ad::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Mon, 17 Aug
 2020 19:33:48 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::a8) by MWHPR1201CA0011.outlook.office365.com
 (2603:10b6:301:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Mon, 17 Aug 2020 19:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 19:33:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 14:33:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 17 Aug
 2020 14:33:45 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 17 Aug 2020 14:33:44 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Add dsc_to_stream_resource for dcn3
Date: Mon, 17 Aug 2020 15:32:53 -0400
Message-ID: <20200817193253.24385-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7b2d3c6-4bd0-4a9c-7e50-08d842e4759e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3748:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37487416943ADFD736523C71F95F0@BY5PR12MB3748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVH9tN6s3gRIp3FhIsz7LDZjtArMEP1cQkJduyTxD952WDgE83EZ1S3wH4jFvAbIfHSMWGpnfmFqlZXM45z44ZJGh3xahFD7luAQAhPFPaSnkCYA9zzv6vnn72jSSWat3qudTIuxs+/m+7UKrW90J5MrpBsJzFNRoJXblI1AMhvs/JHANAHvhC66QWEkcfM32RWEXroCQf2MU0MnN0igAEYvMxWn1eqUMtYGF7LGocTPkY7Xg5OWByDnmVWaOB/CCaO/ZIJkpjvKKKoW2H1FZ1cd81mJodHG3mW1YGbHz8PyQYS/3LDYIGneQ34ATAAG1kzIlt1TEntU0yc3Ny/fNSB+p19q1GDi/VPEl8z+LauqJXwWvCLdTU1cbaqO0azi0DdgIhbPqxWOBY1WCGX1mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(46966005)(6666004)(36756003)(6636002)(47076004)(26005)(8936002)(2616005)(336012)(4326008)(1076003)(82740400003)(7696005)(478600001)(82310400002)(356005)(6862004)(86362001)(81166007)(426003)(70586007)(37006003)(5660300002)(316002)(70206006)(2906002)(54906003)(186003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 19:33:46.4654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b2d3c6-4bd0-4a9c-7e50-08d842e4759e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3748
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
Cc: mikita.lipski@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Without this, enabling dsc will cause a nullptr

Reviewed-by: Mikita Lipski <Mikita.Lipski@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 1ee9087eec76..957fc37b971e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2424,6 +2424,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
+	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.populate_dml_writeback_from_context = dcn30_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn30_set_mcif_arb_params,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
