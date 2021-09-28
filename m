Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F6C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB19361266
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB19361266
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C026E8E7;
	Tue, 28 Sep 2021 16:46:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0B36E8E2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:46:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEFf2staeYbgh5TxXEkhH89NuMeG1Qa9cMCbLYlQAo0bdTiFfmG1fQ6Ku0+3Wu6/fb9GUdAkPwAn1NG6EGqh5wQXOMgNowXvxe/dhCVMM+4A35hA3EJQ2SVI1ZoZFXwNh/diW4Tnwe11C8brRZ9opA5/fucZO3iwYorGjixc3hR7zO5ybChPZOVmp70/2y7bOBkNXlENxhHXBSTaDNMnWx4Qplk3GaCMTTDhE78oQM/0+fMKD9dy6+jTlWqIzvVBZoxfvuvwGhdFNneF8Xx1AnhEOelJ3Rgkt7opiELdpJY8n92lHpsJcPfYvjGROa3uW4opP3EOKojXE5tGpNYmZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Tu/nWHLO3/gcSz8DCcBtBoQtqWZi8DUNVDx6PsIO2rw=;
 b=NtO/gwSEuYqtzoC3sE5FexhBIHYkPjpQmooPqjVhHcSGj/1Cm+eMToA6U94OmcCbYhnh8V0jyQd6Uq+skeljVwZs+kcbGxMByRpCaacGy8yM1VafrNIhEuNKSnS48L5p/bhG3TLaBaZCmj2D06xcxBCYOEDNHzv/1nWMUQcD2jM9Q20Muls+hF4yLYGYBuYyUKisY2uL74dK0q5QrX0PuWLuovWe7pC11jSUWRpDHvLWPfAYYfqerlH6j4KaYQZL7w0/5YZCE5QKjTI0ScGnrZn/wtd8OPwHW+Te7RpW4BnPKXBhTEvFz9omuMXjmQbNaVxfrMZyxz+c3s+PKxAoeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu/nWHLO3/gcSz8DCcBtBoQtqWZi8DUNVDx6PsIO2rw=;
 b=P9AIBsa+d7EBCd4qy8guF+YqU8CRArKu4JXp6FNepuy6G/K210gk3KDQ4bdJYx8L9ENUm9r7LScgb0jJYd8L58Y9036yACBlWo6KmfG8I1cpVftvGlcfDiXeKh1t7jkhK3uD0Tgl5Zpl1UFF6lYguRpRoU0Et8CJcMGMfiLsp2Q=
Received: from DM3PR11CA0015.namprd11.prod.outlook.com (2603:10b6:0:54::25) by
 BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 16:46:07 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::12) by DM3PR11CA0015.outlook.office365.com
 (2603:10b6:0:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:46:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:46:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 52/64] drm/amdgpu: get VCN and SDMA instances from IP
 discovery table
Date: Tue, 28 Sep 2021 12:42:25 -0400
Message-ID: <20210928164237.833132-53-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd6a4898-1ca8-4cd4-a3fa-08d9829f780a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5226:
X-Microsoft-Antispam-PRVS: <BN9PR12MB522636FE2E448878621FD13EF7A89@BN9PR12MB5226.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yimFHDJC/vMfseEgVKEIQwp4d1sMNir6UEAw3S6iXJi0MGI85liu2CpgdQ0qUlBAChe8qyBLAaoaPs1wVRU5nvHGxX2xkxYa0BM6VLBgHtYa95cDNI/3rmgIcKcFE9KV/Lug7sHg+6hh1gcwzhRUv2fVeahgXHECXxFLTvjSFYv1lnQNh2F655RaDlWdr2KZ1OrTyizBKXb0TvfypD0UC4d08PGCrLsdACWm7SPtcNLDpM3yu26/Dz6TGZvkiauPAeFQYvVV3XoSqUEt+uybhlmhTd16uCTY4kXSSt3MsUNtLWbCPV1drQjv3UU0JnxPQj91mPzWPZsZ5vezjlt0KdBLW0GOFPxeJK+R/Lu8Qoi2SybFBb0Y7Tq2VAQNBz2uzMuZ/75Ls4icWVqoTeo5NAEZut4OLV5L9WjvdKF6XvuY2rJUhCViVuNVW0G8kkCuqyJa8H0I7oMl2Wet+s694LpCy5s/IBfCVY9npTwZzE5bmCxnHco8tp1kl6l3afnbwLY+9xOtQhW0DHyM5UTiegOKET+FOS2cGHphWHANFVGfkcmvy9ABXJgh595X0mHSCWkRcy6hRHvqH+ooU+JzIHPYz8qSTLWCyI5V/YpmZDXs/iSUiC9W6vxacwna1CQhjgelTLxaSxRMPX/w4lf9wHwHTL1DVp/Y2ekwqlic9WrOtqTKoubLDXXwzJ7Cut3Gn+/46TcoLfGb29ClAdeKFpzlRjps8f2XmfQMdPhFGlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(82310400003)(83380400001)(16526019)(8936002)(47076005)(70206006)(70586007)(5660300002)(26005)(356005)(316002)(186003)(36860700001)(508600001)(86362001)(4326008)(2616005)(7696005)(36756003)(81166007)(1076003)(8676002)(426003)(336012)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:46:07.4180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6a4898-1ca8-4cd4-a3fa-08d9829f780a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5226
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than hardcoding it.  We already have the number of VCN
instances from a previous patch, so just update the VCN
instances for chips with static tables.

v2: squash in checks for SDMA3,4 (Guchun)
v3: clarify VCN changes

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d3069841ff79..13cd814f2626 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -363,6 +363,11 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 			if (le16_to_cpu(ip->hw_id) == VCN_HWID)
 				adev->vcn.num_vcn_inst++;
+			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
+			    le16_to_cpu(ip->hw_id) == SDMA3_HWID)
+				adev->sdma.num_instances++;
 
 			for (k = 0; k < num_base_address; k++) {
 				/*
@@ -529,6 +534,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 0, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 0);
@@ -548,6 +554,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_VEGA12:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 3, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 0, 1);
@@ -567,6 +574,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_RAVEN:
 		vega10_reg_base_init(adev);
+		adev->sdma.num_instances = 1;
+		adev->vcn.num_vcn_inst = 1;
 		if (adev->apu_flags & AMD_APU_IS_RAVEN2) {
 			adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 2, 0);
 			adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 2, 0);
@@ -603,6 +612,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_VEGA20:
 		vega20_reg_base_init(adev);
+		adev->sdma.num_instances = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 0);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 0);
@@ -622,6 +632,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_ARCTURUS:
 		arct_reg_base_init(adev);
+		adev->sdma.num_instances = 8;
+		adev->vcn.num_vcn_inst = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 1);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 2, 1);
@@ -639,6 +651,8 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_ALDEBARAN:
 		aldebaran_reg_base_init(adev);
+		adev->sdma.num_instances = 5;
+		adev->vcn.num_vcn_inst = 2;
 		adev->ip_versions[MMHUB_HWIP] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[ATHUB_HWIP] = IP_VERSION(9, 4, 2);
 		adev->ip_versions[OSSSYS_HWIP] = IP_VERSION(4, 4, 0);
-- 
2.31.1

