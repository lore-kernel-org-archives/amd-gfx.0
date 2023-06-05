Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B436C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 12:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8723710E291;
	Mon,  5 Jun 2023 12:27:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D7610E1BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 12:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7m9z9FAxDsQO61dQ+JFgNl9Wjks/TUryNdns3SP/iDEogAlQ8CI6APDzqRv+MkItGM1xaTyxYueJAIS9YGfC5HiJl0XCNa0HfbjXtrpgL4VfUmPGtqG1Oeunarp1eLUmDt0+FPkhoYhbKLH9bW3mi4q2JzUyQMtBSQEoFmF6fGKu1z65lTSRzVrEj2iUip1X8p0qlcJA1xFR/0euX/o+IzRg8aID4tGUzqrp1sK6YNuoe6yHyXJvVcvwfevatzmL4iO8s5NWYWdWqGCdprL3O5KUzqvgi/eTs7nh38LGftcB6nyikwIkYsGdtlYewmFugXXv0rqYoC9uj5IBYX0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I89gqijYP2NJJ4kraHIRD2Fo1/kPPk3K6CIM/85oyhk=;
 b=igf52lj3luIKiHdvTu0hfMuFO425ZbgbGjzyXANlrYy4gn8UjExN8rxe9QGbOA4cM2Y/X0xf5XCxfspjRjq2xSrMe9UFNJ+k6mK+jHrG8PH23AqmPtxvAxIkvEUek/00BDWdFyj97BtnHX9AYxfioFwZL8snlsBMPIt+xsir3LzVsLeF7SIK9bzeawnKlFQaYfi1PrKHraEmBM3X+K3I+159fl+2NFoPiECfd96z1sOeWhKU72kOlemH7Tcfg8iqd/kj/0VPxPRYNJqAH3MAoc9P6zWs7pFsEfUAg3EIDXyN3SvgvjG0zAZ7yzKiIwELdfBsK6KSoe2gZ1va13KiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I89gqijYP2NJJ4kraHIRD2Fo1/kPPk3K6CIM/85oyhk=;
 b=rYFD6vcDFL7vShIxdUiWAxMfCkX6iVlbyAnbRLoUum70AzPIXWkUtL2f6NN7RnZDDlSDGJPA8iXkFQEjhX2zM2b0CHdizvsie8ogs+N6DsDEp67Vq28U1Uk/HSMa6C9ViLtbHAnE6xDWagbCj4udMmwyAw+jBrcAdiRrxUMq7bQ=
Received: from MW4PR04CA0180.namprd04.prod.outlook.com (2603:10b6:303:85::35)
 by SJ0PR12MB6901.namprd12.prod.outlook.com (2603:10b6:a03:47e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 12:27:50 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::d1) by MW4PR04CA0180.outlook.office365.com
 (2603:10b6:303:85::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 12:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 12:27:49 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 07:27:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 05:27:48 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 5 Jun 2023 07:27:47 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH Review V2 1/3] drm/amdgpu: pass xcc mask to ras ta
Date: Mon, 5 Jun 2023 20:27:42 +0800
Message-ID: <20230605122744.3484-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|SJ0PR12MB6901:EE_
X-MS-Office365-Filtering-Correlation-Id: ca565551-a48e-4c92-0e7d-08db65c0465b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejb2/C6zCjd8Pyih3hO80XEUzdfJCfgmHCc85f+mnYMJcaTk4rWz3OmdF2LD0xg+FRskYs6UhtmZfF4+ZUr1tDB5oHEfK3h58oCJFEsvTqWhYdbhvcGiL42LOyDF0P/XC6SLh7wDe/H48qn72iuFMvG1QV4Pc9FdAvQ4cuSLEKYBYmFTIMrNAImlvzpsJfaGcYFw4eZKhJDmjcvuBUmzsT1VCBjTlbSfz8WI33sV+Nf1PAvv8dj2UFUWxZNiX4j4BfvHL2ym5Yb2pILYpiEoB1dIVtOEuUGJSnQcljMCRyCgQSnncotGl8d63fhoW47k9BuaU+BvgYJFXolCY5JRhSo1W9+y6A8jrwH560+W/kzonePdlujduVwYkogH5uGZMqavobsahOlp1SVRLufAYrf0DC/MUZRN6hoDeVWeD7lFGnFZ+cdOFK1FJHJi7Hut7Trg9oa/Y4EHMcYHTPBBY7H8ExUykANRqy7qC0EwyH8g4LdbL1peJONfqyBB47hgrCZdVYTAJwevEdFDswKUn6dOL1Fio59bTP+51PsanmtN2gQkjf25S3aDlNZdCGFTG5NJubNDJ+bbHvjoitgj3LMeBhB3HNVXN6nKh1AA4NrnBLGI4qhdVtJbFPjjNXKTm7cjMQ5d6w4oznXyTMG3vaOfUtjXcpbOQj40mCzjPT14TtmXS7IOaQp6+giQUnDxu3Lgnc1fpaCvw3D1k5VTSyg6QK+RuGa3N9y9p+vP2YEeITIxqPXMWq1KCWi28IDKQyfgSg0s1O1kMuC7zFkIVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(336012)(426003)(82740400003)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(40460700003)(70586007)(70206006)(356005)(81166007)(5660300002)(6916009)(86362001)(4326008)(36756003)(6666004)(7696005)(2906002)(82310400005)(36860700001)(26005)(186003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 12:27:49.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca565551-a48e-4c92-0e7d-08db65c0465b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6901
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pass xcc mask to ras ta, ras ta will compare
the mask with the one from chiplet topology.

Changed from V1:
	Remove IP version checking.
	Set ras_cmd->ras_init_message.init_flags.xcc_mask
	directly due to xcc_mask is common structres to
	all the devices.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 2175bfc89e7d..2ad3b93bf530 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1662,6 +1662,8 @@ int psp_ras_initialize(struct psp_context *psp)
 		ras_cmd->ras_in_message.init_flags.poison_mode_en = 1;
 	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode = 1;
+	ras_cmd->ras_in_message.init_flags.xcc_mask =
+		adev->gfx.xcc_mask;
 
 	ret = psp_ta_load(psp, &psp->ras_context.context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index 30d0482ac466..be2984ac00a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -129,6 +129,7 @@ struct ta_ras_trigger_error_input {
 struct ta_ras_init_flags {
 	uint8_t poison_mode_en;
 	uint8_t dgpu_mode;
+	uint16_t xcc_mask;
 };
 
 struct ta_ras_output_flags {
-- 
2.17.1

