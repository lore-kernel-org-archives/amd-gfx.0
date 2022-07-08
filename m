Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5D4C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 22:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D1810EF53;
	Fri,  8 Jul 2022 22:56:06 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B039310EE7A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 22:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EENuJpIStPp86twpOOTjaFUd1wW27cAYLd0bs4lfamN0U7lU3nK0d/Zdw+K/e8eVT9Ug9HnBuG0nOkmnVq/hvWa+c77vhNtHR/lpdNFA6vNFIgWMj2bIHatQqNDmXAGGJ4Dui6tascQGxNPBhHuvz79jE7LIJmSUp5rSf8HZ+812oiPnaIiU/3MftyxbO0x5PjH3xvhyranzRg8L1oXzLsApENyV9VzaUacqzSpDAw+3vunixx9OPMpNmKsktBP3btLI4Ufd+NcDt6NuWK9hBAXGcjo5XBzEzkdS6VFQIjcJDtVXwDd+P0FBCbKHd3BFBv4ZWhvJ+vRoRJgbg9fyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ybAT7IpWMX/CJUzJ7FzWPqOsvilnfiH4oR7Ki745KM=;
 b=e+U91UPlYV2v1ATPbVvhhaLOzvmZG/LSHgVV/G5/aZyMTyzAdxgAbApgo1Sc/gZ0S3XlZ+JY8LDPuSjO0X3m/shcqBo2zCzh5pr0OZNxzsceqv03LlN1MKkukKI4v8d6NIan87Utf1U3iQaBEPGdlkZ+IXUfhS1JVJFzuTpsa8mt41nEOQK4JGDaVHJ1XQdnjK9Z/+9psOcWlIXe+k7XXxVhzMXcg8h7/im6HjKxqqTmVm6klUw0sHt3SuGYBpMhf5mFWIKHeQ55Qd8p1HdS2YnZT/YWNf4x5W6Bgy9eDPv5BXIKu+HipCPdBR2N1pYlZQqF/MFb9/obu1BJPm6zOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ybAT7IpWMX/CJUzJ7FzWPqOsvilnfiH4oR7Ki745KM=;
 b=2GHh1a1IFDns6anpCVI2L/UwDTM/obYu7g/rHz/jBjE/kbMiy4NxSvlqCvwJdgPpvAOqblmTm9IG7GJag8cWtmmop1Y6UNd9ZxeUtPTEaryY4Ehs1u5Py/RRwpXvzrEZhChPYGrL/qhMzGUA5pH48dAGLNEoC5Ve/jleFOTOdSM=
Received: from DS7PR03CA0309.namprd03.prod.outlook.com (2603:10b6:8:2b::7) by
 DM5PR12MB2566.namprd12.prod.outlook.com (2603:10b6:4:b4::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Fri, 8 Jul 2022 22:56:02 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::20) by DS7PR03CA0309.outlook.office365.com
 (2603:10b6:8:2b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 22:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 22:56:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 17:56:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add the IP discovery IP versions for HW INFO
 data
Date: Fri, 8 Jul 2022 18:55:48 -0400
Message-ID: <20220708225549.2061140-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1fe01a-d632-4c75-c52b-08da6135082c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2566:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdhquTa481CqLKF058j4B23udIve7fXXotFMSQEsGDx4wePHhXBGDfTbnfJBmO72domzHQY8kYViWufj9GRW10XhtdeRnvLMEXioXH/mfW7ipd7/5J2f273Gu19Xl3wZq0PhO51aUbLWkaampVAqET/JiW1q6hZ2Fkoq8p/ZbZ7nO0A+L/KMeQOBod5UvxmUUN2I1sVj9KvZEFXTc6kkGn1PZ0//ZIPDVs95Y4rrG6M+vCx/0kUv3HI+VaZpBvqwSJmWQFCsWGeAmCuj25utOMaa3N/kpkzEQEH8QzBGILZ+95bXM8hrXodnVpHKQVsFcs4mX7ph9uAi+CSjR+VDU7jrKh9f9vSnUGvvzjP4tKm6phRID0t2noPiHu2aPMwpovcaadOeb8G/uNqjnof2urOwUXOcY4dY+8RZMM1cB0wM/nGBVC313+CMtp0dfGTTSWuxX/CZy5GqDyEMTUZ6lf2/OQ1oY90SMgwQ58iXQLou6fDsnIDNxmEP9KWYzNrxV/63htmVf0syqw1m817DMxKV5f1hxhXmCrIc60O5R2m35Fl6WuVKyOia6/dFHcB3TBeOfaZNr7+/yC5PlRysXTwS0V0lWc013Lo2xaM0/zMjwTlluqxk9IF+XsWAv3n67o+yWF/p7TabR0kws6OFzqCtzNFVNn9ESsUFdUSSQfTeuGZiCONN7a6tdxO2REDFw7PxzKGAmmIoxIIV3s5g/O9HG5yarTUSE9lMspUIFzkFzAIKsMuLSZYc6rwVespXURq06KF98oE5CxnpYCoDcycWdLo/9l8rGqP23/5QVAO5/I/GdiqQqgOsd6KicPcJxENfuJxiUpNDTGvHY7/uJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(36840700001)(40470700004)(356005)(7696005)(426003)(81166007)(2616005)(16526019)(34020700004)(26005)(2906002)(82310400005)(40480700001)(86362001)(36756003)(478600001)(4326008)(41300700001)(966005)(82740400003)(36860700001)(40460700003)(83380400001)(5660300002)(1076003)(186003)(316002)(70206006)(6916009)(47076005)(336012)(6666004)(8936002)(70586007)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 22:56:02.3565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1fe01a-d632-4c75-c52b-08da6135082c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2566
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use the former pad element to store the IP versions from the
IP discovery table.  This allows userspace to get the IP
version from the kernel to better align with hardware IP
versions.

Proposed mesa patch:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/17411/diffs?commit_id=c8a63590dfd0d64e6e6a634dcfed993f135dd075

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  3 ++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4b44a4bc2fb3..7e03f3719d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -473,6 +473,30 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 
 	result->hw_ip_version_major = adev->ip_blocks[i].version->major;
 	result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
+
+	if (adev->asic_type >= CHIP_VEGA10) {
+		switch (type) {
+		case AMD_IP_BLOCK_TYPE_GFX:
+			result->ip_discovery_version = adev->ip_versions[GC_HWIP][0];
+			break;
+		case AMD_IP_BLOCK_TYPE_SDMA:
+			result->ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
+			break;
+		case AMD_IP_BLOCK_TYPE_UVD:
+		case AMD_IP_BLOCK_TYPE_VCN:
+		case AMD_IP_BLOCK_TYPE_JPEG:
+			result->ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
+			break;
+		case AMD_IP_BLOCK_TYPE_VCE:
+			result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
+			break;
+		default:
+			result->ip_discovery_version = 0;
+			break;
+		}
+	} else {
+		result->ip_discovery_version = 0;
+	}
 	result->capabilities_flags = 0;
 	result->available_rings = (1 << num_rings) - 1;
 	result->ib_start_alignment = ib_start_alignment;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 18d3246d636e..3a2674b4a2d9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1093,7 +1093,8 @@ struct drm_amdgpu_info_hw_ip {
 	__u32  ib_size_alignment;
 	/** Bitmask of available rings. Bit 0 means ring 0, etc. */
 	__u32  available_rings;
-	__u32  _pad;
+	/** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
+	__u32  ip_discovery_version;
 };
 
 struct drm_amdgpu_info_num_handles {
-- 
2.35.3

