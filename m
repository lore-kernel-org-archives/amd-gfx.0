Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FAEC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:45:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CE410F33E;
	Fri, 31 Mar 2023 22:44:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EE110F33E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUfDDKmktbijmrW3kUroePV+FFVDh1Ki1Y5tG6lhGZxtL4DiZAq+vk4C9nVUuqfUSMmaIg0WornkRjPngDPxGjoU0n7/qWEOsXTKlzWkjOIgU/QrgL/+9DYOgow3Ruzl2QkVxGqxSImEUTVabtj8uR/pOUT5Bw8F5SlokOyjr2Vp+/Grs5egQaHzlB9/y6L6F5rc3S0hhkYT+cf4bTch8uJi3Oy399W6XpycRMBuNqM7JRVi6g1reUUSI7iK+AsBihQ8pVvDW/kuQg5F0O32AjQVQEcV15ZU+4qZxpVbkHQw2hNVVv+lxtLSPb43s3wzicL1TWEuA54UYWBYoLJW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMlF+PtDxxVk/muyb1jt4oO4XL2Sd4W4uMckFCcmODk=;
 b=efDhZLsk76xjxW7JNFCVHOqvFXi6dfhmGkZehez1R4ka2Kv9sXayMKSAoJgFxL0S6hdm4nD4wpi5hM+1IjjbNnYdH2S4siKfkXSldlEIubkxqzU61vMsOmMqUeLb4VjgTV3Uqa/6fqmsbsaLJtCG9a55VC+Fcj5edgHq8wb3gLyZsAdEDRYJnTqlKtIplCG7ncgEx1e+YBvjXN7k8x0lMuBNyeLhvCd1ryvZ7QsI22rzVrEcr3uA/ZXVlqSzOwIwGSceiS8GFv6LWQ6fANWHNom1x2G+cqh+mXA936xd8nTXBbN5B9NQbtRkUJsBkgMsnJwlUc0JHnBjAKWqqj7Rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMlF+PtDxxVk/muyb1jt4oO4XL2Sd4W4uMckFCcmODk=;
 b=dSnBBXcTTBRqr/lF36+kWeL8tbz+4p7CprVLg/WNSZhomf9t1sQGnupBaSBjzRFuYjq6hahwBC+xRVEYKDn9G5ZyEvAGimVuY76UXIWj9INZ73FudXGF7h18B7LxINYE+a0xAmGVZ6kvdM6+ei45EipRTh0QpLSSKbn08uhw+wA=
Received: from MW4PR04CA0381.namprd04.prod.outlook.com (2603:10b6:303:81::26)
 by PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.24; Fri, 31 Mar
 2023 22:44:47 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::35) by MW4PR04CA0381.outlook.office365.com
 (2603:10b6:303:81::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amdgpu: Add reset_ras_error_count for mmhub v1_8
Date: Fri, 31 Mar 2023 18:44:23 -0400
Message-ID: <20230331224425.8755-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|PH8PR12MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e1d390-a513-4c2f-87d3-08db323987ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTDKhQ6MgWMiQoZYrOG31lvWucHNa/YORqwDUUDMXFEkIcRW9NeEmN55RbKzqzk0pfxrbbIBv0PVx7UePbTENIQnm/352mcz6ZPpA4DVs89/DsCk+MQRpsFAUH0GYXyZaO2t0xoC5MvHyLeMH8PIdjdOvTqfigBFXk5UsAPi6naa1u9TgNizbXun4QPlA0XIpwiMsyBKDShDuQXhtBLteSNAIketuYIjjPWxfkQqJfevHblEB2fJSWoQB1bMurOoKLkmeCWx1ZD6jdQ/8NS7tdDLk0GfvcLVWPqjUCv/vIWk9hrS/Qi3GL4I0ux/m67bnF56BOEFLVrKIzBsa4mkG9J6EA+QTot427LMNtojSpkIsw0043KINVTH3k2cGW3B4e3cVuj/1scAcZu6yMre07NmPu9bHAIR3hut2sw1xihcAeOHDtabtrBG/eAvtSPqulu+V/yekaPjJ5XU7wQusLtfHzERIn0vRyahLNZJ2ZgDTGzfKu7k4UIAUDU8RZHStWwvEYbotSuQn6OqdY6PQ7y+PJj9tG96cDfil55FsOnVwzNiBxunyt2XZ2UOFd2mq12nDwFeZ+XWCKOp75/n7Axp1Uru22LDo79+htPl1zkEPLWzDME5ThpnVUOElO2SiI5wrCA+A3NOVAqNly1al50EYTuSeUrcPubiKP4jmGChcXuztVMfA/Ip9S8bWpiR/6nTd//fpAjIcFn9DndIfII2B5fzMK208v/psFxvXdg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(4326008)(70206006)(478600001)(70586007)(81166007)(6916009)(356005)(5660300002)(40480700001)(82740400003)(316002)(8676002)(36860700001)(83380400001)(47076005)(41300700001)(54906003)(336012)(8936002)(426003)(7696005)(40460700003)(2616005)(6666004)(86362001)(26005)(1076003)(82310400005)(16526019)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:47.2381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e1d390-a513-4c2f-87d3-08db323987ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6962
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add reset_ras_error_count callback for mmhub
v1_8. It will be used to reset mmhub ras error
count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 650f9351182e..57eadb83d5f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -672,3 +672,31 @@ static void mmhub_v1_8_query_ras_error_count(struct amdgpu_device *adev,
 	for_each_inst(i, inst_mask)
 		mmhub_v1_8_inst_query_ras_error_count(adev, i, ras_err_status);
 }
+
+static void mmhub_v1_8_inst_reset_ras_error_count(struct amdgpu_device *adev,
+						  uint32_t mmhub_inst)
+{
+	amdgpu_ras_inst_reset_ras_error_count(adev,
+					mmhub_v1_8_ce_reg_list,
+					ARRAY_SIZE(mmhub_v1_8_ce_reg_list),
+					mmhub_inst);
+	amdgpu_ras_inst_reset_ras_error_count(adev,
+					mmhub_v1_8_ue_reg_list,
+					ARRAY_SIZE(mmhub_v1_8_ue_reg_list),
+					mmhub_inst);
+}
+
+static void mmhub_v1_8_reset_ras_error_count(struct amdgpu_device *adev)
+{
+	uint32_t inst_mask;
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		return;
+	}
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask)
+		mmhub_v1_8_inst_reset_ras_error_count(adev, i);
+}
-- 
2.39.2

