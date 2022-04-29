Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12F9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542FD10EEE6;
	Fri, 29 Apr 2022 17:32:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1C4110EEE4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:32:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csq780F02veiIgANT+tKNeKGruSmr8+qKZTuB/FKXTZt2NpxCHED9BDKEa3vw+CNMvmRJuc37RUjXnrMPUvcrByi30GLwyOTviJwJGn17kNQ5AE+jn6HOKHeiCrhfOReuHwdCxVoqfl69KGDmGejGDp7pfHaHalOowL4H25/UPy/Pe7wA+gMSE8Uji59jST/3zJCtej2R6g8IwHEmmkMOobqOvp3kQyIwZOjV0wykgFpKUDXo3esk2z0CkQnXCNy/c+zYcskpwEqVZ+ml8k4t28BFJ3YJlW5HctdFNPb825Y0RBKxD9mh82OYurAyxNgkESXAO+l0fB046xaSdyeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VFxUwry8kWqpeD33ofC/oNWNnIAiGqYrNLAun3sKQo=;
 b=NXakFpIOQTzUUSW0RJLMimBqlgfSoxJYwfQFIDB9lOObPXUqh8mLpRYfELgSiTrf0PMqEicH+UvM37oLOl41poB8HG5ebqXqOn6RM3mqPFKk+Tt5tg32CYCCjxycsB9qu9j3xW8BuTzkfMSGuA+CkFVnvM2yvBE6Ws+0XSSupamjoJGdJO4mGQLfRuqFfOCJZo8n5LwZzF2qF+3IeLBcZZvw6bY149QtYnN/FCBg9yZfLDvXvqwHp/tbLNgBbYFSAJXaTF5w6JN/pg9uSw5z0RQQYAt0Q+yN1lwYFrL+Y5xUNN6LIHm3KBNU9ET9G1cLiMTxMAyJvctw9PBCkBmU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VFxUwry8kWqpeD33ofC/oNWNnIAiGqYrNLAun3sKQo=;
 b=vNKYHazimzFbbumh8m9QuUPncAdvP7YLHLW0KJj/KGm/7FnpiI+kmWELwRN1lZjx8DjrUvFCwZp0GEz30+cs6wA1zHS14rQeOrp6Bf3BYIon0Bx1Jdimbw6UtveITb+4miQ15IskhLTcgkqjeJIRC9G1aBVosjDCiisxVtQ0k0M=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:32:34 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::29) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 17:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:32:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:32:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/discovery: Set GC family for GC 11.0 IP
Date: Fri, 29 Apr 2022 13:32:18 -0400
Message-ID: <20220429173218.433113-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173218.433113-1-alexander.deucher@amd.com>
References: <20220429173218.433113-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f1db89d-4f27-40d7-45d9-08da2a063f47
X-MS-TrafficTypeDiagnostic: CY4PR12MB1576:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1576BF221AE7A1280858DE86F7FC9@CY4PR12MB1576.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SP8VdI5h/UcSU17/qBHAJB7upyJ+k2Uxzq0nOKZv+eYwkRymR25PcAJ4EDNjMoQOv7FP5hcFRfGORAVzm5oM6hQt6kmXIFF1M5/sjMPQ1FwD68otKJ7THTpb4b5xomybi/fVZ1WJuDeLFVKNElDXhRmds2AK/HeIUlD+hncwTC5WLDo5b/UDCs2VhHnL8t+/6kNW8yOsz4pEYQjCkQcCZGm6A211AlpsF2R3J31pvUgT/BvJqR9bTdsT8tJTTM0QwcFIJxhnEDQZLigXw5+JauAIf9LxCp9pMRgnAaXgpUA8POAAk4BmS1x6SGCpJmZXMTM90jTN4BAK4x7EQ2xRTywhkGIj5IwgcorHtsKypdGeP/xPS8giPLcqEu+JIHeac9pBI2SiMv1FS6W8OfT0U8SiPZzGPe5FIkzn7MO3sDDrrqRVgux1tgYsgDnwxpXbRf6SmXXOPVWf5e7x4uurjK2laSQM3ag60jtWp9Wi2zeHsH66D72jA5rK3OiWNGx7ZJDMDYHEoC0iTxXH1rIPZdNWyEiyndczUXBc8fqyKWIW10Tzp1Nr0y2HnQwrn4iytoAdaRV1Cyk/UURUG86Wxb/Re3XuM91rfbwbrenWAVjSPUDZCMVPEhltzqG++Y4EzbmUiSmzZEaNaFKoOZJ7msfkf3kSfWfh0OtWhsFSfbgpQ8XZsRf9y0iLJkqa51DsJZGMGzPP67bgC1FTq7kCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(83380400001)(36756003)(4744005)(186003)(16526019)(316002)(82310400005)(356005)(6916009)(81166007)(47076005)(54906003)(426003)(336012)(2906002)(4326008)(70586007)(70206006)(7696005)(8676002)(36860700001)(1076003)(2616005)(6666004)(8936002)(40460700003)(86362001)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:32:34.4277 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1db89d-4f27-40d7-45d9-08da2a063f47
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1576
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Set GC family for GC 11.0 IPs.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2349617efeee..9c177ccc7ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2090,6 +2090,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 7):
 		adev->family = AMDGPU_FAMILY_GC_10_3_7;
 		break;
+	case IP_VERSION(11, 0, 0):
+		adev->family = AMDGPU_FAMILY_GC_11_0_0;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.35.1

