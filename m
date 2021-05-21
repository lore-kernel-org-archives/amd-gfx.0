Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A15C4707A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 032FD61168
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 032FD61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9E316E516;
	Fri, 21 May 2021 17:37:03 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0636E51C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vf7rlvdHCunb1Efp1sxI57qFr+HFsHBrDvsy9gypMoss0+9X5LJ03we7Ixk5ia7OxSm6UtK9iutD1Yk1+LpmYI/koaVtI9pBzhOZdENrJ8iweAUWlqEkpHnO6+66apAXSrodqiBz2G8ax1wNN6MQHkiTnPXjq8zXK2SLdSj51+3NrdkCasGxzleuJUn6DCRyN7CvbgE7e/F1d3O+bqQuKsOLNKKDAa6dtzqIPsw3Q0XEzhLQ4S80Tpq54MnYSqvPDn5Cs0Dv4AzTfU9CNiQ0HdVwzPWR/zEL8X7wjF9MWOMGoU5mRlZmR5Jrlm4xl1Tzq39SOJY5TE6PqTYwGQ+KPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD3HenVq8h2cx1PxFFivj1WuhyrbVioM2Sm2KqW3FEE=;
 b=ZAVSYsGH2E4npBcrmf2TJJDmE5XT+m0BN1YGx/s7/3/8e/CUIWV7yiKh3mo9kW/JFBMUe+2hJQFpG+/z3ndTdMeV38LBN4pUoysMEJ4Jc5+LVjRnfxwC1IaouxcPGlxpI7BgAtsz3Hbg89PuocjFfH2rM38xYMlMG6Z9OWZnwwffDFd26fIiwBIWxIbMirnbn8U9+fm1PgDk0pfi69bU/RNOjTx0sHi8nTUgpy+yf9ldHGoZOhNZm1VQVwbSscYrLN2k0q57I/z7Ep/YlW6RtmagWa6m2Yvr1bmq0vJAOahiLzYWJ5MJUu8E5GONAWGkfmESztb4RGxvG6SdCZ2rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD3HenVq8h2cx1PxFFivj1WuhyrbVioM2Sm2KqW3FEE=;
 b=cfYrNvJKkV7VMX534emDvZ/Bbfn/Nkekzs9GafmADP6jFiTOaliOuCQxe6sITtoqZl2IdGEAcYtIESEMGcHq0ux32hBTwD77YR2aiB1cZWFTOxsIhWiEWl6ZEKXGbYhy+iib+RyMv7c+w9Z7rqYr7OOHjzeh9k4jm1MmzLTDsb8=
Received: from BN0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:408:ec::22)
 by CY4PR12MB1414.namprd12.prod.outlook.com (2603:10b6:903:3a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:37:00 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::6f) by BN0PR04CA0107.outlook.office365.com
 (2603:10b6:408:ec::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:36:59 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:36:58 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/15] drm/amd/display: Retrieve DSC Branch Decoder Caps
Date: Fri, 21 May 2021 13:36:34 -0400
Message-ID: <20210521173646.1140586-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a4bbafa-137a-4d4f-3b8a-08d91c7f09c7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1414:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1414E2DB326A4AD1FC4A0F60FB299@CY4PR12MB1414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mhX0Iq3hRloo30jjltpHJCAXrbqjb13iFogQ9+F32/6ueaYfyqvNNTG6Znu/BaoOcx9wIb0e0UCyB8NmOYimZL3cvKTRP16/xpqkMBW/vyy+WP0KKhyh8N5kah3Zv5lTcSLgEq/ka7/3msKdCLRwyvJEDJ/FQi2jhQX0Nm5AITXokOQ/PlzKRW5w+9qgg/2TbAFlbnzxAR4++mSPnpVtJokUGFq1J1/OBu/Z+vCS70NV6ot9nW9tglRuJV3qn+i1fZQFo+FFg3HcO+NvT4o4eTgj3/BM65Yj8rklNTi1q0j/48jjurPsJ3zkOoy1ydlVZ6lGTqaeu41Q/PKKaYhEsGTdVEliNBoKy/z9lKp8/h95MQZWaqx47dvrysgS57Jz1es8imiKzfRdowEt2L4WfLP0GEFJiA3EbochAf35o5XE4Cynx4rZqc8sRpum+TKibf2W5xqcadtOcDWxGrMqSVAWpnEdiintldZAosQHn15S/8vY2ver63iGv0JMJLRc5gfXw0rrAjvAaSn/XnbXHVxt4zpTsM6a379Ed9OtPQszo9m7R4+3/w9p8fdkpz+3Zs2v2YaD0vMz31//WqBe+n2xBm2p16xfxyT4ur6A9Q4ybrP27te+uqAb+uZJYxAZ5iXTD+/hPvDNWbHzKqpXxd3l469J2M3f6vtgfrTGeV8hugJ+x1V4kfpH8cUnfjXe
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(36840700001)(46966006)(36860700001)(1076003)(70586007)(44832011)(8936002)(478600001)(2616005)(70206006)(47076005)(5660300002)(54906003)(356005)(426003)(26005)(186003)(83380400001)(81166007)(336012)(6916009)(82740400003)(82310400003)(2906002)(6666004)(8676002)(86362001)(36756003)(4326008)(316002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:36:59.9652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4bbafa-137a-4d4f-3b8a-08d91c7f09c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1414
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

DSC extended branch decoder caps 0xA0 ~ 0xA2 is read from dsc_aux.
The dsc_aux is returned from drm dsc determination policy with the
right DSC capable MST branch device for decoding.

The values are all zero if DSC decoding at a MST BU with virtual DPCD;
The values are meaningful when DSC decoding at a MST BU without
virtual DPCD or at a DSC capable MST endpoint.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index f3a9bc828b91..0fca1e842552 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -160,6 +160,8 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	struct dc_sink *dc_sink = aconnector->dc_sink;
 	struct drm_dp_mst_port *port = aconnector->port;
 	u8 dsc_caps[16] = { 0 };
+	u8 dsc_branch_dec_caps_raw[3] = { 0 };	// DSC branch decoder caps 0xA0 ~ 0xA2
+	u8 *dsc_branch_dec_caps = NULL;
 
 	aconnector->dsc_aux = drm_dp_mst_dsc_aux_for_port(port);
 #if defined(CONFIG_HP_HOOK_WORKAROUND)
@@ -182,9 +184,13 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	if (drm_dp_dpcd_read(aconnector->dsc_aux, DP_DSC_SUPPORT, dsc_caps, 16) < 0)
 		return false;
 
+	if (drm_dp_dpcd_read(aconnector->dsc_aux,
+			DP_DSC_BRANCH_OVERALL_THROUGHPUT_0, dsc_branch_dec_caps_raw, 3) == 3)
+		dsc_branch_dec_caps = dsc_branch_dec_caps_raw;
+
 	if (!dc_dsc_parse_dsc_dpcd(aconnector->dc_link->ctx->dc,
-				   dsc_caps, NULL,
-				   &dc_sink->dsc_caps.dsc_dec_caps))
+				  dsc_caps, dsc_branch_dec_caps,
+				  &dc_sink->dsc_caps.dsc_dec_caps))
 		return false;
 
 	return true;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
