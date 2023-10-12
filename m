Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF34CDB47E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 13:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156A310E4C9;
	Thu, 12 Oct 2023 13:14:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4B310E120
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 13:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atnt8E+CXguCOnTLRSS3VzowlQe6vF8LPEjV9cp3sjD1em52O6Gb85tuyu4fnNj7ZSpkZFgvaFb7LUi5ORw8Faye/Z9gA/ILBUc7+7m82jV5LdQu39T1ZUI7ZH/qHZTDqYOCwqZtg30IfTac1GXyqvc4jj1ZLVZIZITbSvYk3QjQ5PF9X65BQzdsTUHcKVDetqmoMamdgfysLY7Jbm/RqZkVO7c4F+Y/UJtpEnIF7wPDUAGba03Dzdp4LWlxDeifaDcdTE1rrM3iwSFp7NEKJKthV/hHiLvjYFeMgearqvrqivG+nig8NuizMTK58mn0o8u45wQZJ2c9PGW+xXwr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xsmr7lpacJB3IJS1LoE10JBPyJyevcC15PT9viD7IiA=;
 b=Uf2WoAUAxSdnOWfNRj5+NhXvEcJIm8Kc+5jYSZJzz6v01CxcFeRQHuFCuTZmzO9qVV2ANvdtsK/MlSkAh8k4qM3xRPPb9h8GXBDCHVOECsjuF4p0b1mLpXPOkQJv4zxBIBSfkSp3iKn9fbtRfmfv+44OZ073Ut5PWTjVETIweSrC6rMD2CnhlhiSogDllu/erO6MnxFwcIOvCHp5RQE9Xpj1HiAje/ObR4qQXefuEP5xzSIUUll01ADzlgjC3zUduGrHGwpMcbJWtOhthYD5IA1Azefz1B2O3G8fROWZhSG7qtXFMBirkCwh5NpqCwEKeAzE0Cag8AtWC3+SFYYQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xsmr7lpacJB3IJS1LoE10JBPyJyevcC15PT9viD7IiA=;
 b=mzhxo2+NmWBIK8IMMTJETB3e5hbg1DgdtAhkGRvs1saJIGlONY1I9uayl+t30NGb9YrKhsRALos/B06cycWipoTr6UR0BPxMXh/H3exJFcXoqH5agrC70HZx2pDB2zNGBaWVZaYau2U3df/vcCxlUW6gX8ylN3y5aAlg006QQrM=
Received: from PH8PR22CA0001.namprd22.prod.outlook.com (2603:10b6:510:2d1::16)
 by SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:14:24 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::6a) by PH8PR22CA0001.outlook.office365.com
 (2603:10b6:510:2d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 13:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 13:14:24 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 08:14:19 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdgpu: make err_data structure built-in for
 ras_manager
Date: Thu, 12 Oct 2023 21:14:01 +0800
Message-ID: <20231012131406.61101-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SA0PR12MB4445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2617ef08-18ae-475a-32f0-08dbcb2527a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5eMzhbQdnvTIuSC9FLnTWP5HUeFnCqha5xbEHjZeqqlOS0wf4spYH/xe8zJpIajcWtA7lTx/k/h+x6M9a83Rh0weVBU99cyAimdKNVxSj0KN7PksiZ3CVx19rJ6OwU1DoscPyfpspqnvNZZQf9ZCwmso1OAlB3iOTY4UmH5iGtzU8gkllBwEAycUK9ccI2NYCeGvQlhwHeqK41z+dlYPvmz1Zr0LlSLk5kVDnuVnYheNZCNaVtr/TEYz4Qw8fAMtu3aYbo3K9VwwHZk8rD6LgkkcrBKjNgRaXbH1CyTJhi9X3lW1oZJPZEhBB7GFbWyM507zUUMIaAP1kIGD21QX6rEov8yxVZfRaecd/mOGFdijQsBJ2hoiibCDjcp2oWc3hvBqs3DKeyIP7lwr8moPzA4P18FkFILBxmg5GoxD627oZaCsahx3gSZTnakaS0foanrxDyhF3jEVCtyP2HinfFDn4SsJxEwZfT5ZskVzfbfL4UHe/PqLzP8eznP4ffEQGt6kL+airRavMkFzZknvyIJPeox/uEWTtpfdaXO07iLWB2LAo4JyyRCRETD3BKYPZL9sCurSajia75/9HMCGx3hqjVMtAYt+SdxYx8Kpxrr5xdnfmf9ek2jcqj80QuNLQIbqzJ56vNEB+nDPHfgEjj+N4/uWy6tkCQznOGImoguyXjrQn8WOQwUWwApyYw1zGeKBVQW4MDee9ndQUW4eC9fw2BwRfH05CTS8dAlJPrW1hJciZ8UMDoWLn/jKeleworE1XPeiy5mBeYn8S7R7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(47076005)(40460700003)(356005)(81166007)(36756003)(86362001)(82740400003)(40480700001)(2906002)(5660300002)(8936002)(8676002)(4326008)(54906003)(70586007)(70206006)(7696005)(6916009)(316002)(6666004)(41300700001)(1076003)(426003)(478600001)(26005)(336012)(2616005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:14:24.1667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2617ef08-18ae-475a-32f0-08dbcb2527a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

(No effect outside the ras_mgr data structure)

Since a new member was added to the ras_err_data data structure,
it becomes unreasonable for the ras_mgr instance to contain this data,
because ras mgr only uses the 2 member information of ue_count/ce_count in err_data.

This patch changes the code err_data into built-in structure members,
making the code directly compatible.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 728f98c6fc1c..46b0dcf846dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -496,7 +496,10 @@ struct ras_manager {
 	/* IH data */
 	struct ras_ih_data ih_data;
 
-	struct ras_err_data err_data;
+	struct {
+		unsigned long ue_count;
+		unsigned long ce_count;
+	} err_data;
 };
 
 struct ras_badpage {
-- 
2.34.1

