Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A74C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 18:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A6F10F892;
	Fri, 29 Apr 2022 18:02:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3C310F890
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 18:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgiN0xxVg0Hkq8NDgv+/ZImGd767+vRiYsJ/g9wj5kI6jlHN6SmuMJOaCaqs+CzHabVKlk26XJ+aEjwrO3z6EIh2znu3npu1X69ZR+xKOCbNmoT9U0cVX+K/CJ9s+92zJ+dyR0tTjlpjEoMXpeAwS7ULu/RFT+VF+D70/JNdToTw3QFlLJLw86Tv1nDAd2uQVdNeaU1S4w77+1SkwokVq52e3u+iaLDa/vilEQnP0GXCnhbqiazMVGcSOLry93+YODTXhmLxFh40rSm2/iq8jwcfLqslb/+DUXKIKB3viNubrsJ4OGCj6fcqRagdhcTvk8ASjTJopg4jNRu+hHdr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kr/F10sF2CyK10J0XH6w0vtkPphhe3IavlRttwz6wvg=;
 b=JdjqS7Yj1Bh4ecau1bnG7BlDDKu0oG4Bs50Ei44f9bhkgXe45fYkEUDdzN2QDWqYvmi2whcX8knhGmWf+YWFZCEBR4HMSApf61jGviUTuXCc2NKZwZfGpRKbvL13mOCrkgbyzdzsZPFfl+5f+LtQkeKwykO/lXkf1I8LIwt6nr5eVowoNXwn7QEuFM+bCsoXebzB30YsWnu7HhOl/JbXpDwRWvYFWUbiufGTZS8RcR11YZzG6HfGZ65BID2Ou0XW6BvGh1H7/Ioc0EfjR+w0QosZ0slnmhfDg48lv0zA9c23LLtG5tTxyodI4RTBmacuTrHwgUwqIp/rFPFTuO15zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kr/F10sF2CyK10J0XH6w0vtkPphhe3IavlRttwz6wvg=;
 b=gDzCiFWSE3IKIA0vfpEbBO2QWnT98JbGTjUQGfuH5lyw6G6vp0k3XycKFEdQa8aIpG2HjhJ2GuBB2xKmnIWGHqd1Q2LSdB0DjqlNQE3dTALGVEUhrN6qKKeE59f50d4RwjlvukqW7szyLYlynJMgXa+pMk1VBRJxZ5SpWHYlvDM=
Received: from MW2PR16CA0021.namprd16.prod.outlook.com (2603:10b6:907::34) by
 BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 18:02:41 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::6b) by MW2PR16CA0021.outlook.office365.com
 (2603:10b6:907::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26 via Frontend
 Transport; Fri, 29 Apr 2022 18:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 18:02:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 13:02:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/29] drm/amdgpu: support RLCV firmware front door load
Date: Fri, 29 Apr 2022 14:01:59 -0400
Message-ID: <20220429180226.536084-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429180226.536084-1-alexander.deucher@amd.com>
References: <20220429180226.536084-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c2da068-d27f-40eb-4550-08da2a0a7444
X-MS-TrafficTypeDiagnostic: BY5PR12MB3873:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB387310BB369A696EBFF68823F7FC9@BY5PR12MB3873.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SEnFgrgNYgFjdjurhT6Bpf1sKBAWdiB8QuBpS9kd6wI+NumY7KPip/6lfQxyT9tbrfYpmUOnu9vPgb9NGdCwuhkhVMs80nbKzp+S3Eed7X7HKl7e9ap+qf6wkquv3TiaObIihLXPccytJ+k2pI6LWJhgHlTUY3wO22/L2LRgsIlMQ5V8G2Rx/eU0NQih0+X+16v0ibm9X+Tv6zghSdwTPi4qSNGerC4Uq0W7h8o1nuIHAHLdIVXFuSdJ+8nhZBeCDeKVczpNXAw5ZAn5gTCLZtpaExIbOWvbOzBxfLum26zGhk/1/RFuvIzaZBNtA7ype/OLkJFRuHCxEe+scDw8rrydCqsKwTkRyzVUaRTAByMmrE+HgPvDR2GQByiSAEOhVDxersTeTadWf7ZhKarWj0iRfQJIuvDeDNkeenom1QdQvrCtheLV9a4RcsDFwrYAuLBTY1U/xkaUzifkPlp4Jwj8o5N7qvzn911XZJQcKww20Y7iRzBArfhqQM+Tb90zvpDwHZuvI6oos0gyDgdbxUkG5aTaj7AqHncb9cmavpr2pTcaVc8HsS7/ybyAGBJq42uBmEyk2MGeRZJCQnELmH3GkuCr9Bx0iiWvX+neol+OV9Vxn1Aq79dSdp+uxlXJPK1BH10jkidmpc7aiLU/QBcNyLN7JgeK8pV7dPKnk4sVUXpKGZtm2qyLefrhAf4o0mtFGclTE0Ik/oM2IVwlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(8936002)(6916009)(81166007)(70586007)(2616005)(6666004)(316002)(5660300002)(70206006)(2906002)(86362001)(4326008)(1076003)(508600001)(7696005)(356005)(336012)(8676002)(47076005)(16526019)(426003)(186003)(82310400005)(40460700003)(36860700001)(36756003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 18:02:41.3142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c2da068-d27f-40eb-4550-08da2a0a7444
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3873
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Support RLCV firmware front door load.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9b3c23a22059..4c91efb695c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2220,6 +2220,9 @@ static int psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_RLC_P:
 		*type = GFX_FW_TYPE_RLC_P;
 		break;
+	case AMDGPU_UCODE_ID_RLC_V:
+		*type = GFX_FW_TYPE_RLC_V;
+		break;
 	case AMDGPU_UCODE_ID_RLC_G:
 		*type = GFX_FW_TYPE_RLC_G;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 7af9ca069570..8cc059482007 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -705,6 +705,10 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode->ucode_size = adev->gfx.rlc.rlcp_ucode_size_bytes;
 			ucode_addr = adev->gfx.rlc.rlcp_ucode;
 			break;
+		case AMDGPU_UCODE_ID_RLC_V:
+			ucode->ucode_size = adev->gfx.rlc.rlcv_ucode_size_bytes;
+			ucode_addr = adev->gfx.rlc.rlcv_ucode;
+			break;
 		case AMDGPU_UCODE_ID_CP_MES:
 			ucode->ucode_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 554a4a0521bc..c3018eea4ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -401,6 +401,7 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_RLC_IRAM,
 	AMDGPU_UCODE_ID_RLC_DRAM,
 	AMDGPU_UCODE_ID_RLC_P,
+	AMDGPU_UCODE_ID_RLC_V,
 	AMDGPU_UCODE_ID_RLC_G,
 	AMDGPU_UCODE_ID_STORAGE,
 	AMDGPU_UCODE_ID_SMC,
-- 
2.35.1

