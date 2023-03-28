Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6558C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84B110E939;
	Tue, 28 Mar 2023 15:18:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83DE910E0E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPaKHyTaZMxfBxMyCJypcnHAJhy9BVx/eucw9mL030YCHPGmQXLKpgS1CidWbV/gaakSCmH1yOOrEklMuLj13YFyh87PUtrxuqsPgIeAJKBrULHVxMAN9xoHmW3YYrxjIVT5d4WU+Y0zYxpBcwRPrIm/UgQw8n5qJVKw+1h90nobMKDICBQEICNOJJRNQaGK5TSG5fcQBt7wDXRYU5LgyPdFGyzwbag4V+J0iuAPqst/Jw4ojAfZzMlcUSZZMzKFxjbb2c0myTWx6+N2ZXLm6tfM6nvLEhBF+Rzo6NnucOXJD56VZFqOU2w69Y0SaGhxuEsRBCrhTYqcg1SKhvU3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS5HIBitb0tqrNvogvZ+umyPcyOAcFuMbWPbfN331Rs=;
 b=CrjaVpWyvg0sL+JPOtavcREkiKHWDLt/0a59pwk+IRz1sG0buxEV+2/V3MnDXp5WDhsG/SUlglVY9CDxzkk8kXwh8lshggfxg73eXn/j/1DiP0lD/cOuG7ZXN3R+tZJ5OLR1mO0lvfShzFjRXPizr+Q83YCIv8Zf89BO3I4UNd0PMWIY5+6CanGVoLZvBkOI/ENLpn3e6phHX775pgbb3OZFNU6j2zCG1IMyA9IEQvW5tAlpgh3YDL7ECfeONL6DfY0YTPzM8esPfOoUE6LtWQ0dPqRjbcPXZNZN7MqL56oItUfk5yyU7JT5e5ToUWjKWIjtGjKued4cpc6sRua6iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS5HIBitb0tqrNvogvZ+umyPcyOAcFuMbWPbfN331Rs=;
 b=qtjriPtN7hdwzim1A9jv1ei/rojy5n09RUMOih2ZfuNxB3GgZb2GOI8b/SAV6BEGBNM/kLy8adjaHUop8b7AWxQodxRmxNExm15mZnmqKk3hnZvYP3u07lbKwbGMYNZfjxKNih+1pgClqXNj3uiDKCYkgitKnQU/SAr3mPigx+Q=
Received: from BN0PR08CA0003.namprd08.prod.outlook.com (2603:10b6:408:142::19)
 by SN7PR12MB8003.namprd12.prod.outlook.com (2603:10b6:806:32a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:18:40 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::15) by BN0PR08CA0003.outlook.office365.com
 (2603:10b6:408:142::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:40 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/6] drm/amdgpu: add new vram type for dgpu
Date: Tue, 28 Mar 2023 11:18:22 -0400
Message-ID: <20230328151824.1934600-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151824.1934600-1-alexander.deucher@amd.com>
References: <20230328151824.1934600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|SN7PR12MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 64be8d3d-2b05-4e08-7978-08db2f9fb63a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SqUBYcMvLUtJoFJ7o47JKQ8Qo26EV24+iGnTRMbIxCGAfBl+b7bQbD3WrMddr+xBDpcl63CWSF8wXrgzUWLcpGGNKFTbMsgfHVWdmPsRJQav9/2AAaBEr3OP+X3MdKxpQOYAIKFVw5ctBr3wP2XusweDSVM6MXas5woiwmxD4oHEkdlGh9xxe6t9TIUQ0gm2v++wMR9SR3Cgz5CfCY3xCJVWdu7obnh9FnYVAz3pa6GugjVG2bO5NBnomrUIeRV+dx9J62TBT3AXlLv2x5rcN4bmlgVgEccixkSBvAmqAflM6m7tBUYwHiLR3BIq5tl8axs1PebKA6pYxAGS6oRcjmKxIxvgSrlfeGeoqflY7mP/EN30abGlM3DpXNTugKIUWUFVTctM3jdUMz+UY+iUvmHrwVvhZLMp2Q/dq3CAaQibbrBo/bN/9niyOm/WH9RH39XGB7r5Wt93ca+/JMoUanHRMRplCrLoBi9UNObM0WMjkQlsAxNmn3aqeCgbLrBmGClMRrfb+icq+XEmBx1I9MkZkKjpMhTyH1qMC3XP4pG1Gk8NvkaNr8ib3gToh9OTx97rSF77YhSZz9KN5+hsv7DZn29bpcAbjdGfliqCIs2ugU7xK5p1wfbGpI1fEDsOHRqoITV281KfTZ5wEh190EPjF7oc61OmhZg6iKx7UX/0uqiTmlwE3oBiwzwh4aDv6iOJqYIMesXwczMbNSC/ONWZw7AXeQ+evcxXB1haiM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(41300700001)(6916009)(4326008)(8676002)(16526019)(70206006)(70586007)(2906002)(82310400005)(5660300002)(36860700001)(36756003)(47076005)(356005)(86362001)(426003)(81166007)(82740400003)(186003)(2616005)(336012)(8936002)(54906003)(6666004)(478600001)(7696005)(316002)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:40.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64be8d3d-2b05-4e08-7978-08db2f9fb63a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8003
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

hbm3 will be supported in some dgpu program

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 1 +
 drivers/gpu/drm/amd/include/atomfirmware.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index ac6fe0ae4609..ef4b9a41f20a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -272,6 +272,7 @@ static int convert_atom_mem_type_to_vram_type(struct amdgpu_device *adev,
 			break;
 		case ATOM_DGPU_VRAM_TYPE_HBM2:
 		case ATOM_DGPU_VRAM_TYPE_HBM2E:
+		case ATOM_DGPU_VRAM_TYPE_HBM3:
 			vram_type = AMDGPU_VRAM_TYPE_HBM;
 			break;
 		case ATOM_DGPU_VRAM_TYPE_GDDR6:
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index bbe1337a8cee..e68c1e280322 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -182,6 +182,7 @@ enum atom_dgpu_vram_type {
   ATOM_DGPU_VRAM_TYPE_HBM2  = 0x60,
   ATOM_DGPU_VRAM_TYPE_HBM2E = 0x61,
   ATOM_DGPU_VRAM_TYPE_GDDR6 = 0x70,
+  ATOM_DGPU_VRAM_TYPE_HBM3 = 0x80,
 };
 
 enum atom_dp_vs_preemph_def{
-- 
2.39.2

