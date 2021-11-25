Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFDFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 03:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB036E029;
	Thu, 25 Nov 2021 03:15:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E156E029
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 03:15:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGibpGn3hx3nddKMC4QrUP1rt8TdDMoan2QhHxcmtjTQSCPrkzY8kVL9Z25ERMFuofS0r9U/4YUlTGTud2Mt9tEyfGriBjt0zbl/ZVj+LZPxzljMI+MJPo9+TWusseGLgS/nW4dkEcHy5MHfoh9GBeyaPW2CnSwhCC0pFCWt31y3XpjNlRwyxNwS2114WeWIUukZEaxRNFN7oTJy+/e3MyJJuf4gnmh8QJdp5of6ekUrUGEhB2RTpCcw7iy4cQdJUmRpWlkL111hWQ3VOZMqAubHoOEHYNAXYMDgVIEh9ksCw2oaEt97xWoGi4MgS2k6jeXv1tbq1egZkJZjcGI/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD+41ysOYXS+bzYq+0hn1uDoSLehHg74cgcf2wutZOI=;
 b=af4OgwirYwJPPdSz5Xfx5FIe24cZlaX03Swg1L6dXbQaRjrrJQee2F+FynJDFU3M7R5rEoFCGTBuiGUMY7wiKM0bl1UTkyuKdbY8XzE0YOx82YKyEeGsReUkiz96sF689yI3uXapAl6NifR7WgAIYbZ6CEt6zp19dzZ81ISv7kmaCfLSNWVRKqtdPOT4gUqyC/MDaEQe4jP8/no0wdN9PkhXJ0m8ELRQ0rhu6hfQOLxMHok3x4RAQ3oVud+scruT4ujk0XSHoatYjy9wlqo998S9KUaqy3gsKaFwpqb30I8EBQ3Zv0RKRuPKYrn61dlm5fS380iMfB3DWcnIp55cZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD+41ysOYXS+bzYq+0hn1uDoSLehHg74cgcf2wutZOI=;
 b=Dkp+d1mO4hNNNCjWFTyRn9aknZmlb+5+C79xOSC6wi8fXLp0b+/NA6EKxx4CCTIIanQGgYRI0jGzI5sDEeDdx+wVzXcpJAMmgrEvA+blisNkJzIbKPxjJsGu41kMX4NhqarsxVRNWO9TPcnFHXIByfCu5UzCscrzgbb9FDAIHEE=
Received: from BN6PR20CA0065.namprd20.prod.outlook.com (2603:10b6:404:151::27)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 03:15:08 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::ac) by BN6PR20CA0065.outlook.office365.com
 (2603:10b6:404:151::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 25 Nov 2021 03:15:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 03:15:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 24 Nov
 2021 21:15:04 -0600
Received: from jane-X10DRi.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 24 Nov 2021 21:15:03 -0600
From: Jane Jian <Jane.Jian@amd.com>
To: <Alexander.Deucher@amd.com>, <guchun.chen@amd.com>, <jingwen.chen2@amd.com>
Subject: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip init
 for SIENNA_CICHLID
Date: Thu, 25 Nov 2021 11:14:47 +0800
Message-ID: <20211125031447.5998-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d528eb04-3681-4578-072d-08d9afc1c732
X-MS-TrafficTypeDiagnostic: CH2PR12MB4101:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41011031D4F69C2283018658FF629@CH2PR12MB4101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c6YpH/RaVx0hGJTPYmaq7QGvRgMUqAJT/+EptxIrdPo8I9Jod+FREFnTrET0WqEDOnR+rTMsK48ovue9UJikC8fYyiDsdKwmRpeDZpV/5N3DzryqfrDU4DulO1pHE6lc5hxguoVuVz+kLNPqo0HRMZQJyEqlcDn9fU9qq3fDEvIVrVkIGjwcX5OxkdA6NUG+6545grFiWQiwkUuLHNpYgNCvpcLMSQPAFfWoRJp8tPQqqtNHSKebyrhItHn4LYzBS6N7poGbH4LlqoFioWpCaJ4pkRvUIMpMtbVP0uWkUP40KA/MZApgTTbx0enW9pZvibjmJOMw8bCR8MK3ToJgvSlIQbhqkuX1z2Dw5MB9MOBISrdVmRTVPmcvkMyetgwgdHRtLZc3ziXk7WQN6AsydbkuaoG9NkJPjJcjETLJ3tYnXftBnrecidlMAcXsCRboi5Gu8B1uP3MDLPzcdFxDfXNUyGyOKi/BMu+n53XdlxCz+/GjVXCXJDdcGtzOTM3zD9nbgkOugh4A2jFWnybAq/Vi7wTRfhFhX8OKI+bXTm4fEyGSlsaHsE7xfchYtuiuW3UllcJ6fDpYKZYIrllg4DMLV52nzeSZpEeIOe6srp0CiUvwIUCCbZnHn9xAecrGtpgjI4/iDkIos71or4GSDEFfnRK8PqKEabJvGayRFhmbZ0lnB4u/kaPL13RekNxRq8qDfPbgETY1ogrrHVPvc86tywXwSsyfXiAvAfQCIvg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(2616005)(36756003)(2906002)(36860700001)(82310400004)(7696005)(70586007)(5660300002)(26005)(316002)(8936002)(8676002)(1076003)(81166007)(336012)(86362001)(70206006)(54906003)(186003)(110136005)(47076005)(426003)(83380400001)(6666004)(6636002)(356005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 03:15:05.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d528eb04-3681-4578-072d-08d9afc1c732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101
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
Cc: Jane.Jian@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[WHY]
for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
which will be mismatched with original vcn0 revision

[HOW]
add new version check for vcn0 disabled revision(3, 0, 192), typically modified under
sriov mode

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 503995c7ff6c..f6fae79203ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -918,6 +918,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 64):
 		case IP_VERSION(3, 1, 1):
 		case IP_VERSION(3, 0, 2):
+		case IP_VERSION(3, 0, 192):
 			amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 			if (!amdgpu_sriov_vf(adev))
 				amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4f7c70845785..585961c2f5f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -135,6 +135,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(3, 0, 0):
 	case IP_VERSION(3, 0, 64):
+	case IP_VERSION(3, 0, 192):
 		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
 			fw_name = FIRMWARE_SIENNA_CICHLID;
 		else
-- 
2.17.1

