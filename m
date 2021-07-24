Return-Path: <SRS0=oGIb=MQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9B8C4338F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3A360BD3
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Jul 2021 04:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA3A360BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666E36FE5A;
	Sat, 24 Jul 2021 04:04:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 225146FE59
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Jul 2021 04:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYtMnTnjujQ2YofkPs0eZ1fAoXUkTc13uY/xQ0W8HttVyOK4fdnau9eQ5GwDP6QeewRWkDiJuONUBoMh3kipcjhIIkw/s+RdlQPu/KMPoQCvKgV7FG0lhcsvklavRVya1ip1moexlaVDUdlH61sf+BnByZUmEGfYfqJJboXAIPW0K2IAKwBcAfYYsGnss9otukA/6rs9/60sOM9nszC/hlutIZZKqz0nheRzeJ0lg1h5EFFTlvErOq7k/pvHsw395pVarMUphiVEjYrY0uJJg/PKLr7VeQ777z7LA+c1mmtoTMOW0wftUnC6MyN9So7ya1lEaXkuOiPrVm6XyvMn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGF1JVFlvtgUEwvCEX1fZxZrCOUEn/KWeW04F+cof0o=;
 b=oKIGz4lGSs/iPjZ+cSYSzGftFHnjLPlMV5Pd/LPM5GrxelKvQ43W/UVJLSGOa7095bdWVZZtpSgwLajoJMlfeptOEvOLze76oB/MPCRslVVS22Oab0PAQuruhs5h2+qJpMWbD8Ie9a3he3h0Gor23X9irIrdpqX9xSFws7sz7+GduDeQFl4XbiUg1BzUIFFJMwdEvmXagL5J83+lFYNorFFCcsp1EzRO9mXQq4OxpyVn9iQdEAE17fQSytE79loPk8TPFyUXgxFpvqw4+qt+1HcBuc3tH0xwA+BBefuOExhC0gQ3IICceKYt2rjRxEWytm36nTmTtPg35vCQNwto5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGF1JVFlvtgUEwvCEX1fZxZrCOUEn/KWeW04F+cof0o=;
 b=ptX6m14wP4KVm06GLL1QX2mj5P4KecnYQMJrd3mvFN/SmKP5kPE0GXGLYkCVZQ/aadwhIff+0ETyi+MihrO71hhaFdyg9NiyE7Ic3NvTdwejnqPy6C43o4GrQV7MmVgctsFe8nmB4b09rVpGm77YJytDTP2V9bvg4ar+T5uIcq0=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by BN7PR12MB2754.namprd12.prod.outlook.com (2603:10b6:408:2b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Sat, 24 Jul
 2021 04:03:58 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::2b) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Sat, 24 Jul 2021 04:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Sat, 24 Jul 2021 04:03:58 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 23 Jul
 2021 23:03:55 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/14] drm/amd/display: Add missing DCN21 IP parameter
Date: Sat, 24 Jul 2021 12:03:02 +0800
Message-ID: <20210724040314.3865608-3-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210724040314.3865608-2-solomon.chiu@amd.com>
References: <20210724040314.3865608-2-solomon.chiu@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1adb0405-7ca3-41ce-bfb0-08d94e581052
X-MS-TrafficTypeDiagnostic: BN7PR12MB2754:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2754F1924814262B89ED031097E69@BN7PR12MB2754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d+KP+3aQGXNYU5JLdBlZqJfj6QPr454CSESN1tUViQ8szyeEhZJeHmKRWm5yonOaEZSPTKWxZpkCRq2U+wJy1EPEnDGwp7dAU273R7/5pW9zqXtRj+QjWCDw2iGeTNNC2lYwe6heO7MdFHECTE4nq6nB6cAd3rrvu5lj2YxQKOvZfUtq3iUL6Qg/nALEmyyyciFiXnm58AhfiIZJj6PKMnjZtVK/niQaWbbIWYdUCIFaphcJSQ3ow/aaRodW5Uh0wlcaaMUmjb/a/kk8G5iPqvpSMMqAfntyIe/V5K7KLKn0Jb8ziPahDvbJ5/wgbDEtW6xmkxLz+bkIzfxqYnwdCjYI5oCSc8d7Ps+Bbccx2JuDRBLQmUWH8tZH3SQiBR0DOxdB36ISdf2MtFU07dp9Idet1s1KCyvuwRWONMgJNjyzxhtALruBDZhqSj64JpX0RT4MPoz+apMsNB68QC2f9JMX/NFNF88eTeb0+YQVwKgW313/I8GX4FgD40NoEyAxQcAPxHT0AjdvJaUL2v3srIILFam29q2Sg0loZBhaniYnxLnGFnt3wA6f+BvwWKRlFb8hxRUql8xuarx70b+Mc7Dkw/+nGi7QckOIfX9X2g/xe/0CGe0N/vjD9zATKQMlZ2eLMSz5lfQ9JYT8Z9DD0ciJbGZQGitnZAdFWeoQlwn4I416LaXnlbWbf5spbao0jJFWzqwJ/8XWN70HFt2MaGa25xq2Rvhrr926a2gO2zk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(4326008)(8676002)(36756003)(1076003)(356005)(54906003)(82310400003)(6666004)(70206006)(7696005)(8936002)(6916009)(82740400003)(2616005)(81166007)(70586007)(478600001)(186003)(26005)(86362001)(16526019)(47076005)(36860700001)(5660300002)(426003)(316002)(44832011)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2021 04:03:58.7053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adb0405-7ca3-41ce-bfb0-08d94e581052
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2754
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
Cc: Laktyushkin
 Dmytro <dmytro.laktyushkin@amd.com>, Solomon Chiu <solomon.chiu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Victor Lu <victorchengchi.lu@amd.com>,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Lu <victorchengchi.lu@amd.com>

[why]
IP parameter min_meta_chunk_size_bytes is read for bandwidth
calculations but it was never defined.

[how]
Define min_meta_chunk_size_bytes and initialize value to 256.

Reviewed-by: Laktyushkin Dmytro <dmytro.laktyushkin@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index a5dd97a2c5a3..f27fc2acac57 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -109,6 +109,7 @@ struct _vcs_dpi_ip_params_st dcn2_1_ip = {
 	.max_page_table_levels = 4,
 	.pte_chunk_size_kbytes = 2,
 	.meta_chunk_size_kbytes = 2,
+	.min_meta_chunk_size_bytes = 256,
 	.writeback_chunk_size_kbytes = 2,
 	.line_buffer_size_bits = 789504,
 	.is_line_buffer_bpp_fixed = 0,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
