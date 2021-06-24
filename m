Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA143C49EA6
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFABC613CC
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 06:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFABC613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276DC6EA52;
	Thu, 24 Jun 2021 06:47:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3846EA46
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 06:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHY9rfp9Wq4g0PNEXOWINxcUOJqOlA//c301Cab5nN6OzFCEDH00QjutpxdoPYXCuds75n/ohWzl5twNlNcH2dgFWQRwiXmr0a0u68NnAS2ZUtunY5423v8rVTcL62rQkysUVpXT/OLa4PBFNOKpypVFxCfxi82xNiF3dSSsHEXC85t5hG40BHBAc5cZQzg8n4v78nmpqtJPV1gCuq6U7v2cKVuw7fz1rwyGztGKU1Crz/ZcXW4B6hoxtZIcAYmDn60hAmUt2caQpH3aPXArVgftLtgWrmU0lHEs2c8p+ySdVPhd/AsYBQn0XLdnt42izr+FYt/BuJlaZD1+t0M4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7XGJejPoovXGL7XiQjEDytwXF7L3FXLE0qWA5unKUA=;
 b=fBEUhb64nbMyDA+QMXjuEXly0Uk4zCX/Mc65nojwJRcZUGES7qE6OCr1+u+z/F5C8T4CGuaoxJeed2vlSRsoS5WNd80ayvGq3/QGdJCDRIFVJ6t8oN4G01p/eOsUH1xIz4zE7QwkpMwGWcVhwpi8rckWZ3EbTt4WrfpeOpRiAJB2UrDVFfp8qCQv+7xGppkyDbWicy/qii0+cYp+HXT4Jw/cucxQYqxpfbOFeTaxtcrY4gDBBGaJlIWOoc1g6PxLSKkf4c5/5ofj82PR4VHj8BzQkuPQpGIthWHSGS8Crd7Z8stXTqc+G3JJ0t+SPf5jaJvbo8WamBboeyLEOj+9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7XGJejPoovXGL7XiQjEDytwXF7L3FXLE0qWA5unKUA=;
 b=PZGdbBZRL3X3tPN9TgNEoHsW9RjrNWLx0/2ym1c46TAAuSQKguwdRcLHSY6Hyvt79E6iv/soqijL4bnb7FI2WVBelywgy2nSsUg2Bnms7eGn+mtXAa6N8cojm3qVduON0tEjR0iWJyB43Ud7IEeGWs4Zo26/psaZnXy7dLGwaZc=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by DM5PR12MB1945.namprd12.prod.outlook.com (2603:10b6:3:10f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 24 Jun
 2021 06:47:42 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::b5) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Thu, 24 Jun 2021 06:47:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 06:47:41 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 24 Jun
 2021 01:47:39 -0500
From: Lang Yu <lang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add function to show ucode name via id
Date: Thu, 24 Jun 2021 14:47:22 +0800
Message-ID: <20210624064724.77436-1-lang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10be507-b296-4fc3-48a4-08d936dbf6d7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1945:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1945B309ABFE89CF168D780FFB079@DM5PR12MB1945.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2tfn9nttyI0Tk4ib2orpFVEd2rQuBw9bSniEelnicoaFl9y5Yu5iRn3j7+R8rvDHBdGNSCxYDH/M2qSQWN2QajsrIW2/rYzUER2SCHHgHAtSdt/TAL0KAuj0qDHRrUl0YnXZj22gZYAz254MlfYnqb+dOvBC1g6Lsr5cXdclkqMheBphWCkR5Lo45atSBSR0Y+Z8DjXOfpcCmKRnu0N4CGHQ9vWbeLUGmFw+vfg8WLacsHMv+4ymarKdyOcQ8BnrhISRSZJciePiJdKOz8LLn1x3l0psQb/0zt54he0NOnh3jk+OECP+F4cZYuABk/vYrzrgKmr4od5JYm/FZRuxnvAj/2/0xPWaeEWvk4D1h/A33Vwmgmc+QBIo0X8gBxjv9QB5bKXoyiDYhSwz9Jc3S9q3at4RKZhKjgTckGhQIu5goGW+4AZli5vPbEbqLce90J0NX4cUBC5Zc+WSvUriivpndDcnDmzrcxaqJJnCBCX8xknYo6YJTGXjRjmGC5OuhkvaOAtvP9c0ANOVT6N+O/H5rgotJE2K3VH680NIQ5Ocs+JVzOQRKqfxWKAjfnRib1dBOQZFAofFP++FA2r1WBriIhc4yy9cRVBHVJfxJVOIDyvB5HrkVEz6/RuS93EqDQ0Gzk7Ekw+BzIyGu6ekQ19p+tl0OcVFU1YDiLwhKOv/yipBuqHUoSBpOOx4MyzNM6qufYLMymGsAtF3CLDqTpQbbHHtNspAdB+S8GA1zI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(2906002)(82310400003)(6916009)(336012)(36860700001)(82740400003)(70586007)(4326008)(478600001)(8936002)(7696005)(356005)(186003)(36756003)(44832011)(81166007)(8676002)(16526019)(6666004)(70206006)(426003)(83380400001)(1076003)(316002)(5660300002)(86362001)(2616005)(47076005)(26005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 06:47:41.5018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10be507-b296-4fc3-48a4-08d936dbf6d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1945
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lang Yu <Lang.Yu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Implement function amdgpu_ucode_show to show ucode name
via ucode id.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 78 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
 2 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 2834981f8c08..6a03abb009ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -416,6 +416,84 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 	return AMDGPU_FW_LOAD_DIRECT;
 }
 
+const char *amdgpu_ucode_show(enum AMDGPU_UCODE_ID ucode_id)
+{
+	switch (ucode_id) {
+	case AMDGPU_UCODE_ID_SDMA0:
+		return "SDMA0";
+	case AMDGPU_UCODE_ID_SDMA1:
+		return "SDMA1";
+	case AMDGPU_UCODE_ID_SDMA2:
+		return "SDMA2";
+	case AMDGPU_UCODE_ID_SDMA3:
+		return "SDMA3";
+	case AMDGPU_UCODE_ID_SDMA4:
+		return "SDMA4";
+	case AMDGPU_UCODE_ID_SDMA5:
+		return "SDMA5";
+	case AMDGPU_UCODE_ID_SDMA6:
+		return "SDMA6";
+	case AMDGPU_UCODE_ID_SDMA7:
+		return "SDMA7";
+	case AMDGPU_UCODE_ID_CP_CE:
+		return "CP_CE";
+	case AMDGPU_UCODE_ID_CP_PFP:
+		return "CP_PFP";
+	case AMDGPU_UCODE_ID_CP_ME:
+		return "CP_ME";
+	case AMDGPU_UCODE_ID_CP_MEC1:
+		return "CP_MEC1";
+	case AMDGPU_UCODE_ID_CP_MEC1_JT:
+		return "CP_MEC1_JT";
+	case AMDGPU_UCODE_ID_CP_MEC2:
+		return "CP_MEC2";
+	case AMDGPU_UCODE_ID_CP_MEC2_JT:
+		return "CP_MEC2_JT";
+	case AMDGPU_UCODE_ID_CP_MES:
+		return "CP_MES";
+	case AMDGPU_UCODE_ID_CP_MES_DATA:
+		return "CP_MES_DATA";
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
+		return "RLC_RESTORE_LIST_CNTL";
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
+		return "RLC_RESTORE_LIST_GPM_MEM";
+	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
+		return "RLC_RESTORE_LIST_SRM_MEM";
+	case AMDGPU_UCODE_ID_RLC_IRAM:
+		return "RLC_IRAM";
+	case AMDGPU_UCODE_ID_RLC_DRAM:
+		return "RLC_DRAM";
+	case AMDGPU_UCODE_ID_RLC_G:
+		return "RLC_G";
+	case AMDGPU_UCODE_ID_STORAGE:
+		return "STORAGE";
+	case AMDGPU_UCODE_ID_SMC:
+		return "SMC";
+	case AMDGPU_UCODE_ID_UVD:
+		return "UVD";
+	case AMDGPU_UCODE_ID_UVD1:
+		return "UVD1";
+	case AMDGPU_UCODE_ID_VCE:
+		return "VCE";
+	case AMDGPU_UCODE_ID_VCN:
+		return "VCN";
+	case AMDGPU_UCODE_ID_VCN1:
+		return "VCN1";
+	case AMDGPU_UCODE_ID_DMCU_ERAM:
+		return "DMCU_ERAM";
+	case AMDGPU_UCODE_ID_DMCU_INTV:
+		return "DMCU_INTV";
+	case AMDGPU_UCODE_ID_VCN0_RAM:
+		return "VCN0_RAM";
+	case AMDGPU_UCODE_ID_VCN1_RAM:
+		return "VCN1_RAM";
+	case AMDGPU_UCODE_ID_DMCUB:
+		return "DMCUB";
+	default:
+		return "UNKNOWN UCODE";
+	}
+}
+
 #define FW_VERSION_ATTR(name, mode, field)				\
 static ssize_t show_##name(struct device *dev,				\
 			  struct device_attribute *attr,		\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 270309e7f5f5..4b0d34f1d450 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -449,4 +449,6 @@ void amdgpu_ucode_sysfs_fini(struct amdgpu_device *adev);
 enum amdgpu_firmware_load_type
 amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type);
 
+const char *amdgpu_ucode_show(enum AMDGPU_UCODE_ID ucode_id);
+
 #endif
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
