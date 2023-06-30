Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFDEB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 21:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE4410E197;
	Fri, 30 Jun 2023 21:27:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800F910E197
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 21:27:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arnHAUMVnW0ribpjzoMb2i+Cb+Q7IDuwEdcpdQWYnLQrd7DMHQRIjz0AiCuDZhN/TQ0k6GQY9YieVqZn4VYKq+ecGNFQ5Q0YZdlDgoLP2mCwBt3Fil0uVwX/7tbhJyjudmlm/V/myvsAC46MzuNJfEi41UufUbuZArRapflApkugjinXumHUggJSpVR4UnYn2fqZiU23XxkSRMAtW+Me2x4+12wvaaEAFZJ4KgFEgCYaVmDWGv2yprrzoYGjoGIIn4Zwafjgr0G9ttxdARA/PZsSz77Raad7A8SW9GuCxadJbkfJHK6k4/N4KaoRUvq4CzM3CFT6XZ99yO9H3Za61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3UhNqIR3yy7B93PVRyHLXesDZu144qkiMQnujW5v8I=;
 b=Ny41aDYGxdUZQH9trzcOMQzpAE/nL1c87BCvhWknvkymkERPRZ3GjvKpvGHrgy2tAAamU1c8zUIen+YMtblzAmr3PU/iW/ZL7Im4IF8IZvyk7HEkiWm5osPlkTNg0cSpAeJ1eA4PhocJ/lg2lkksyO504pnEDpnCiZ7PObLEPaj5jul/kf45BoJA3Gd8GNnE3wZHbAskSY7ggEIsYZ9c6vnJ7pRQQSfTd/6z6vb/WIBaSH6XlvPJzQ3IPY8Mylchpflphs1ntcoikNuJsn8OXI46sG9920tjhz2fsbsFuUeomvj6iPvNS7K2LAfRq4A9m+/WGQvh/V1n162kZtljvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3UhNqIR3yy7B93PVRyHLXesDZu144qkiMQnujW5v8I=;
 b=klWLDHa3+6xJ7X1xEagROAyJrTYt6XwTcIF37r824EieAc44qmlQLyIv/4fsVxlBVygP1DwsEP5DxdKWDOUy61zrVGUQo5lrIwflofl5L4rQcfF5CdLerwQZP+sKW/sLQkJpv78V+QabQsrbvs5IN7c4oSEuuiNcO+PJ5Lxa+1k=
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 21:27:20 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ac) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 21:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 21:27:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 16:27:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Restore flashing support for PSP 13.0.10
Date: Fri, 30 Jun 2023 16:27:08 -0500
Message-ID: <20230630212708.19954-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT067:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: cb084803-adad-40db-849a-08db79b0c8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxmQYCD3iagK5V768lzLYAFv5Guh84W0RUH8JNfjSKueulM3hc5CKj8nakGa0jnAIlL8cPn05tpdb3Bx0yLDgYSURvuB4KEIR2EZddxwGyCEKJGycZ3eGVi7y/NtSGZSDtia1sxpVE/juHRcDHS0t1PV9/wXQS5sY06+PfCmscK1shd4Ruc2hV06UVigFSvgqHxdaIlPtw7E2p2/SPa0HRvjleVc4b5VyDGp46SaMqRGqPpXO7XS5rpxZro0IEQzqef4Qjp65wINaaqss71gwN9EF3PixAFC0qw+toQOZLUYpFa9GYvHflBPTxhA0Lw3NlGa6+TDyjYzfSfiwSePlwa3htu3tfZm+BU+/dm2YBLF/O4n+J7C0rXjlPKae/Mq3mdd1OaT4Y7c5Ks9pRiIZIvnVAgJOb73HxjJB6K870JYZo+h/fw0i2C2MFipGgA1iVQe4Ga3eOkjxLwXJIAgNd5YMNRcFXgrgv9WTkNO/pD/kCN0JCQ21HSg50jbMh9h3xgjR1pxyXlBalRticOrce04bJGM9e09eipYvdcr+a4lbvXvDpn7WaZ4Uc4z9rvouXFw0L+5J2sO49CN+4Fke4JAroHJ9noTHJwmY8WYCzaeSwEhWVANpGMMKSg7grCW7nDQoYeJegsRoXei5tETtFdK9xx5RTiKboeug37cD+uT2BveHlyFmlLl9HAtGHPZStSTXEscxL3Nq812KZwq0UH+9F1XqBmExWiYxyW9Ptscel6VKJ4hmRr+O1JqK0GkZBXI/89LE6o5XKav+myqfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(46966006)(40470700004)(26005)(16526019)(6666004)(40460700003)(2906002)(186003)(40480700001)(82310400005)(7696005)(86362001)(83380400001)(82740400003)(2616005)(81166007)(426003)(336012)(47076005)(356005)(1076003)(36860700001)(41300700001)(54906003)(70206006)(316002)(36756003)(4326008)(6916009)(70586007)(44832011)(5660300002)(8676002)(478600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 21:27:19.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb084803-adad-40db-849a-08db79b0c8d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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
Cc: Likun.Gao@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This was accidentally lost by commit e6e3bee0bc9a3 ("drm/amd: Use
attribute groups for PSP flashing attributes")

Fixes: e6e3bee0bc9a ("drm/amd: Use attribute groups for PSP flashing attributes")
Reported-by: Likun.Gao@amd.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 270b5b5a3a6d1..c2508462e02f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -201,7 +201,6 @@ static int psp_early_init(void *handle)
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
 	case IP_VERSION(13, 0, 8):
-	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
@@ -214,6 +213,7 @@ static int psp_early_init(void *handle)
 		break;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 10):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = true;
 		adev->psp.sup_ifwi_up = !amdgpu_sriov_vf(adev);
-- 
2.25.1

