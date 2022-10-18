Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119D2C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 12:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D73110EF31;
	Tue, 18 Oct 2022 12:28:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B703A10EF31
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 12:28:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMrkYf9MP+ggKsDkVDUzEYpAqtXmf/TSNt/G1Mck5L8SbsDJWuF2tUzBK7JJ5hoZfZZct2hLGqOwULwXP1hj6ZoZRfr/feoT2rIKEOPwTlaSfs785NJyJucZUD+bZnPw1Cobb8R2r9QnrdRNp6zFUV/15TXtrqDNb7GpfKJNCBmz6WdG4FkVp71c+jEdngG+kWFRPyDKV/I7jIfJGLjcc7UyO6unK9lXBJrj3sJAZ/j6fclMpdfZ4Zp1QlETx7isKJI5G78VaCjScaZzK8gh1wbPuAP6Nu42eR+NEJkNsheQJ7igEaa7bPIVkPd2p19nWb1b68cvfe5eUmmj6KOeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZiGgG75NUcdJ4WUNceugtrW5ZixVDqalQICaEfuSgM=;
 b=HYbaFoluc+TmzBpbD2az1UxBWh4tWU7/jT/aGuHHs9lqcEsqs6pPe7NX/i/nPgnzswdMJQta8kQbTz3W8aRbWI9wmcc5SnvVyomuRCEFTBBYqbIzmj76OR8eIaMdo+/aJXZXzuuho7FlYtHIPBL9ZTYRCCLfDSYt+Oiawbc4zKlwBPdEow+jJ3Uts74HOwYJf+LnTODkfYgKbdtULrYTNIzIN/qJN1dYhFG8Lna3MLmcV0Q1RadgvKPNJCY/wxHgYm0D37oS7s7xkQqjLjpTOPou2JAo1wGfeAc3ocXTCsEg6uXieBaNx+jWkNe6OzmTxNpuvXLS415UYZPc5AbpMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZiGgG75NUcdJ4WUNceugtrW5ZixVDqalQICaEfuSgM=;
 b=jQqDRQ/WPOpO0QhnIJMqRDXzkwGlpxgRXlo4fGZCmoQj0TL2iCWUvcRhVpAbrAjBLij+bkeXc5Cb8r8lA7MlM/HiKWGTRij/iH4MVn4NWtLCF3IxoH5SXBVZ85CEEoCO235LwD5Wc1/Cah9UBNx/ctXoHsCCllO0DpF1080gFSI=
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 12:28:50 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::1b) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Tue, 18 Oct 2022 12:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 12:28:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 07:28:48 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via
 Frontend Transport; Tue, 18 Oct 2022 07:28:42 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 11/12] drm/amd/display: Use update plane and stream routine
 for DCN32x
Date: Tue, 18 Oct 2022 08:28:25 -0400
Message-ID: <20221018122826.1790114-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT057:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 06499e8f-dd45-4e8d-d368-08dab1044fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fvYDKFRxVS1E/MM43BguD0MpK0pDRcX2qyPLUtqvq9uZu95QY7VcWuQgrXhnZybykPMWlcuxpbWTFSblqbBV3JDzk35hA2XvCCs5o/4LxtvOekyE3pG6xeIFpUfek90Qjn+fzcHndmrdLAc6NUAf2qNrrxhNTlPnU/MGrFquvs4pRFg1HiMYLWLs8sobgZesKnKLiscQ2gV4+ioD3rd/KwiqU49t/h24krjmHXWZGegdCOaFsucKgUWN4ixx73sBIStOqycKj1VpXc6BAlDbclWTzl0HIZL/Jpga7lHMJWNzhr51wcHIuDi7fbJuKyrHB48goqQc5k9QiOI3QoxgI3G9IPUxQG64cXWYncHxzDqVZIg9OV46jwWCB9RkrjgyehDFuxwp+V+6IwgHrBkYg1+v0PM+7xDN8ejd62TrqSqvAabFCsoZvbiQUSi9iKJ6JEi3ons3sb5/BxlGONST1EMeVrBGbEj8kB6124rOKdxt8uX0ARgFM5hzxghPCYkHC2H80CtsJM1rpeLjIwehdEOdnus1uRglevPmFCrfFaGG8QAXDcgRysH/yy9CYUDSveEBDl7ZPeDTIGXLfVJ/442u1W2Q+FalzRYbSGthsGm5aRzhbkQThy18SknxahbIeJEpH1NAI8MQm7fjn71g8PgqFhem4eEyc07/ayj5lxXLWfBg4PEeuTeoj/icYt6svrhWCXnNJGghwjTqB6O+MJld1bndrB4z6HFODhs/epcdC8xnO9ye5KYkYiroNB55EmImqzgFbMXq5hpAC4cZdGtT8Jsiqh7yB163H0upqQMrbbTaei+i0QyNiHdiKbls
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(46966006)(40470700004)(1076003)(5660300002)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(4326008)(26005)(41300700001)(2906002)(2616005)(186003)(8936002)(83380400001)(82740400003)(356005)(81166007)(426003)(82310400005)(36756003)(47076005)(336012)(6666004)(478600001)(40460700003)(40480700001)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 12:28:49.5065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06499e8f-dd45-4e8d-d368-08dab1044fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sub-viewport (Subvp) feature is used for changing MCLK without causing
any display artifact, requiring special treatment from the plane and
stream perspective since DC needs to read data from the cache when using
subvp. However, the function dc_commit_updates_for_stream does not
provide all the support needed by this feature which will make this
function legacy at some point. For this reason, this commit enables
dc_update_planes_and_stream for ASICs that support this feature but
preserves the old behavior for other ASICs. However,
dc_update_planes_and_stream should replace dc_commit_updates_for_stream
for all ASICs since it does most of the tasks executed by
dc_commit_updates_for_stream with other extra operations, but we need to
run tests before making this change.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Co-developed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 375439c51cd3..56629197a6a1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3904,6 +3904,18 @@ void dc_commit_updates_for_stream(struct dc *dc,
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, j;
 
+	/* TODO: Since change commit sequence can have a huge impact,
+	 * we decided to only enable it for DCN3x. However, as soon as
+	 * we get more confident about this change we'll need to enable
+	 * the new sequence for all ASICs.
+	 */
+	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
+		dc_update_planes_and_stream(dc, srf_updates,
+					    surface_count, stream,
+					    stream_update);
+		return;
+	}
+
 	stream_status = dc_stream_get_status(stream);
 	context = dc->current_state;
 
-- 
2.38.0

