Return-Path: <SRS0=8txe=6Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C89AC3A5A9
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FADC2072E
	for <amd-gfx@archiver.kernel.org>; Sat,  2 May 2020 21:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fhbJ6WXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FADC2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B69276E0F4;
	Sat,  2 May 2020 21:34:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 132A06E0F4
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 May 2020 21:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDZHWAV1pa6qzurIwODrVwtfTDr1eEgpxDtI2WpONulYmpPw5W8PLnhi5XeMNRPr3DMw46vEpP1ayi2M5bNmjHVOL7D+y+rOaRandmRtcCIVtr1eM/PNl4tt1jkhF6Vy8QraPuFfay3Zk4gE07ZpQaaYvy/VFLX+0wrrYCLKPFc2OV9/uWTdx24CcRdz3aLN53GSqncAuO9mMUG0ahkHhHohikZc0NqXFSsZbSRtnTgZEdG1joKplhAveXxrngyZCXRNdtjlNRwQlOYIYxqulZyr7gVynUW0yl1rLIWs7Zsn7a88A7fYyp2OX5wNV1is65ttGVO1lW5G5/Im8E6/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7My++fud+fpPO3LRe4VWbTENLppI8klR5NRYvQyId30=;
 b=m4QGuE7gjnmhVwHu6wGvv0FIkQiJrzlTOu7GBdVtMaliVfDlBD9iCxnEeJjEpzkMs+7Ts8L1L0eqbDGjFJSLJyrafVIl2vM8xWCKeUoRjIMlg3FEOZapoN+N2EeVOTqPVDFVZhEoadsi9xhC3V6nXPk58SwpeGiRGhO7Yp5+ll58qVA6od1HPWPl6YMUGW8w3FLSY2NsPTL5E4zQ9D7XMpDyUGRZamplTkReOTLrqeF6jqorpUCQsIRMD3bqEyTYxbYcIOJUw307v626zX++PiOlAbL5b7HQalKO1CqzV8xjphO7wBoQJZur/mSTge1JA6MUnqZyuuQl1kWVquiIAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7My++fud+fpPO3LRe4VWbTENLppI8klR5NRYvQyId30=;
 b=fhbJ6WXCL71DV9Br18sFD5FgRV2biRJO4yAGrpQGo8geWIVN2N1Wi/4TImAVAvIAY4uXWw3WLFhQ8YxoiB7FmgQykkoJayBVH2nPefDgxKT764hQXEFyhFhKu+TA1D2KzH1Wtb+Os4K3GVN7PamT1uKbh9uia41KrhJFTQVwRAk=
Received: from MWHPR22CA0059.namprd22.prod.outlook.com (2603:10b6:300:12a::21)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Sat, 2 May
 2020 21:34:48 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::f6) by MWHPR22CA0059.outlook.office365.com
 (2603:10b6:300:12a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 21:34:47 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 21:34:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 2 May 2020
 16:34:46 -0500
Received: from sudo.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sat, 2 May 2020 16:34:45 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: update RAS sequence to parse TA flags
Date: Sat, 2 May 2020 17:34:28 -0400
Message-ID: <20200502213443.39232-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502213443.39232-1-aurabindo.pillai@amd.com>
References: <20200502213443.39232-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966005)(2616005)(44832011)(426003)(316002)(54906003)(70586007)(7696005)(2906002)(70206006)(6666004)(336012)(478600001)(186003)(5660300002)(15650500001)(4326008)(1076003)(47076004)(26005)(8936002)(86362001)(356005)(82740400003)(6916009)(36756003)(82310400002)(8676002)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efb386b5-8566-45b5-bedf-08d7eee0a349
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:
X-Microsoft-Antispam-PRVS: <BYAPR12MB314184BAF2D1A455631E6B4A8BA80@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 039178EF4A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttmBY/+5xd31zjCWMIPnAjcvdacAlwu1XSWiaKQzOpwtxV5QFqHkk+vXA/R7Oni3dtKxo2J+Mzi6y6trl0V4tEstKYx7gsRUC8mh+9hFizEDD4yHJnh0e83/AArjhYJ5D2He2WpHd7V3BCYyYDQAX7GnmoSCScvqIerQrCApQPVcAaN3WFAI5iyaTj4RkVBkyZXFkrVb+Ify0cb9F9KSs2znmPLjuhGSKjyOKwI9uLiorx+OyCfj0WmcBjNL4uDrrFXjBtHTsypSdYb7+P+0kRsU8vXIORExT0vB6jbMhic/8VnkpTU6HFc2860UYZTaEss/bWVRJtJf/q5xjODJAq7Sgn0EVrnQ0bkzasupI3x4d4DDeRiBZAvITcNdDKoeEb9PlGGbIiUpZRLJRsP+TpePQu4tPif0I4CH2brdEoAIHA/xGb3Kagn5N0WUu7Hc4t6do4wbYPEnY4pm+Of/OmfgmfAh6Vo99pP5uspyqbJUmRq4TUA/UCqBetO4byQm1wuvYnjnCHp8d0mhDP+mfA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 21:34:47.4119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb386b5-8566-45b5-bedf-08d7eee0a349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 John Clements <john.clements@amd.com>, Bhawanpreet.Lakha@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: John Clements <john.clements@amd.com>

RAS TA shall notify driver with flags of error specifics

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: John Clements <john.clements@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 29 ++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 730f98aab11b..f061ad6750ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -746,13 +746,40 @@ static int psp_ras_unload(struct psp_context *psp)
 
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 {
+	struct ta_ras_shared_memory *ras_cmd;
+	int ret;
+
+	ras_cmd = (struct ta_ras_shared_memory *)psp->ras.ras_shared_buf;
+
 	/*
 	 * TODO: bypass the loading in sriov for now
 	 */
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
-	return psp_ta_invoke(psp, ta_cmd_id, psp->ras.session_id);
+	ret = psp_ta_invoke(psp, ta_cmd_id, psp->ras.session_id);
+
+	if (ras_cmd->if_version > RAS_TA_HOST_IF_VER)
+	{
+		DRM_WARN("RAS: Unsupported Interface");
+		return -EINVAL;
+	}
+
+	if (amdgpu_ras_intr_triggered())
+		return ret;
+
+	if (!ret) {
+		if (ras_cmd->ras_out_message.flags.err_inject_switch_disable_flag) {
+			dev_warn(psp->adev->dev, "ECC switch disabled\n");
+
+			ras_cmd->ras_status = TA_RAS_STATUS__ERROR_RAS_NOT_AVAILABLE;
+		}
+		else if (ras_cmd->ras_out_message.flags.reg_access_failure_flag)
+			dev_warn(psp->adev->dev,
+				 "RAS internal register access blocked\n");
+	}
+
+	return ret;
 }
 
 int psp_ras_enable_features(struct psp_context *psp,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
