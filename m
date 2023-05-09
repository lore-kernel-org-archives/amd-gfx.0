Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9124CC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3AD010E417;
	Tue,  9 May 2023 22:11:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C8D10E413
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:11:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XoYGKWZAMEIOLBnubK4w4sdfV/1JU9CRs6AwcSYw464O/TJ/enAKHSPRhpInWRMW7lKsAezpfem6xX7Mfcypupxa4iH8ZFp0v3rVmszooHYAP8By1btKpLa8lmK37Kx+HtHPtLHwv6gV0OQOZmy0+/Ja4/2Y86CoR0B7dPlDVKEGHF635TaB82vx2UwP6ottdgKuciWvw18LRHhSZZAiYOwyytMOFRQ5xDlY+nlRvHEMLf9bGqLEpv4o9KvaDvGcohMnh9RqO4O8Gfovy+XPO3twHq8ZZvoGbt3coeKR+G0W359F7dsPRVmcpwPP0qH79hLwViwGc1yGxSgvb81nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHhCebxtXcT2KIV0QTKzD+FrVzNRE2wcJTt32V+A+94=;
 b=Tx1dwW71xuZeaqvtpGR0ImO5AGyjNWwPhY7iep99XYBNlptwA22cQuMWgSeChF5zQmcLW8J2YTN2eo35DPv8uNCnQmIjm1vsqApn9iMMiBK0htPuuMnWdw+FCeawoBKlfMfdRXvenHTTVMf7WgABrBnu12PMeE9zJVcqhzURb1Ef5qvZMwCou2l7UxI3Gu+xdfcYFYZFxlAOpcLEL0aClef9OzBnncqn99v2YN5uEpaf0VvGmdLx9bC/ZOSDUAqSgV1qkuTJvOHUd60rQiahCXrnGESKuEnNZqBvuVQHIguUcZ6vBCYKk0D0KSJkInL78N7ckoqbiVq43LdXm1Nd+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHhCebxtXcT2KIV0QTKzD+FrVzNRE2wcJTt32V+A+94=;
 b=lHDnHK9mfsrGPP/IaXju2yw+xGqV2iX3VDJXdFv3pbJ97GFelbYgTwEqIyRUUfgXumsslpQq0mT/c7wsmqq3wJKmDjNOet1J7p7NIrCxZLROX3/TQ2wFEDzWomN9Cqs6X3DcALwEsFBaxzjrZtfXJ1bXZ4CtMrtK1aFCWLglS6g=
Received: from BN7PR06CA0059.namprd06.prod.outlook.com (2603:10b6:408:34::36)
 by CH2PR12MB4182.namprd12.prod.outlook.com (2603:10b6:610:ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:11:44 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::53) by BN7PR06CA0059.outlook.office365.com
 (2603:10b6:408:34::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:11:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:11:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/12] drm/amdgpu: Add instance mask for VCN and JPEG
Date: Tue, 9 May 2023 18:11:18 -0400
Message-ID: <20230509221128.476220-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221128.476220-1-alexander.deucher@amd.com>
References: <20230509221128.476220-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT015:EE_|CH2PR12MB4182:EE_
X-MS-Office365-Filtering-Correlation-Id: ab5ca405-04e5-451c-159e-08db50da5fb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Thi8Vn1sriOqYR93zTRJk2skTKOXIrLnyU8re2MbzxvZ71Vop3e6ARyi5tfWyo0snMU231s+DKDUrhTBBtseQN0UWxqkaiM4deJowoa70Bmnsp2RL+N83PB3Yzwvi9D8XM4lcTY6fpSxNOnGJPSTwB8iHjUeKFwyNOjnWuhFGVox7drGZLgyZwkmGpXzpr9E1ceC1o0ZxtHRHk8RrTcdvs1phIzXIpHhj6q+Q3AOhuHFZcasw4+38tqs6E1/L0a3RJ8sZ2tNMsCiOCddEd0eeSh45i0ifHsVxqcrNJnlWy+voSzrXHBpRmwDbS9UeX8UFExfmC2nfgRV4DhKtDpUL5q5johA5asRO6ZCvh5IFGs8I4mxZCVPF7NPZe4RUvqXeQXBp4FRjto+CksbYkQiC4/Yw51KVGBLqd7yod7a9F6y8RrLf4IqI2zWMUnHijvrATcPgH8m/Er7clBCBLOfBl2a5bV3WEt54h+KtwH0dV3k3CJHmsmOapX+zDmCJ2glUROj1V/zpy1x9RcToZdzlLJxXlyxo2jdNPafGUG+meh+1JYSqn0evd90lW0Ydp+Sk+2/NviOh2QsBb1bo9IOZyLnWj84seN5x57u/XSLynkQldXWaLvrSMclsoajUdTif7ZnfuSJlUpnXeVFt8+9xFUtCNTXJwwmqnJzrVWiHAMdRV9Y0liNYhrvlgaWSuM5gbuSdj74/D0emyBudE9oXhHtNG9M+He4oXF1aZESNTc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(2616005)(6916009)(4326008)(2906002)(70206006)(86362001)(478600001)(5660300002)(6666004)(7696005)(70586007)(40460700003)(26005)(36756003)(1076003)(41300700001)(82310400005)(186003)(16526019)(81166007)(82740400003)(40480700001)(54906003)(356005)(316002)(8936002)(8676002)(83380400001)(336012)(426003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:11:44.1580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5ca405-04e5-451c-159e-08db50da5fb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4182
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Keep an instance mask formed by physical instance numbers for VCN and JPEG
IPs. Populate the mask from discovery table information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Tested-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 30 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h      |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  1 +
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index d81b2e1e8aee..ae5852f80549 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -549,10 +549,19 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 				switch (le16_to_cpu(ip->hw_id)) {
 				case VCN_HWID:
 					(*vcn_harvest_count)++;
-					if (ip->instance_number == 0)
+					if (ip->instance_number == 0) {
 						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
-					else
+						adev->vcn.inst_mask &=
+							~AMDGPU_VCN_HARVEST_VCN0;
+						adev->jpeg.inst_mask &=
+							~AMDGPU_VCN_HARVEST_VCN0;
+					} else {
 						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
+						adev->vcn.inst_mask &=
+							~AMDGPU_VCN_HARVEST_VCN1;
+						adev->jpeg.inst_mask &=
+							~AMDGPU_VCN_HARVEST_VCN1;
+					}
 					break;
 				case DMU_HWID:
 					adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
@@ -601,6 +610,11 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 				(1 << harvest_info->list[i].number_instance);
 			adev->jpeg.harvest_config |=
 				(1 << harvest_info->list[i].number_instance);
+
+			adev->vcn.inst_mask &=
+				~(1U << harvest_info->list[i].number_instance);
+			adev->jpeg.inst_mask &=
+				~(1U << harvest_info->list[i].number_instance);
 			break;
 		case DMU_HWID:
 			adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
@@ -1188,6 +1202,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 
 	adev->gfx.xcc_mask = 0;
 	adev->sdma.sdma_mask = 0;
+	adev->vcn.inst_mask = 0;
+	adev->jpeg.inst_mask = 0;
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
@@ -1235,12 +1251,18 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
 					ip->revision & 0xc0;
 				ip->revision &= ~0xc0;
-				if (adev->vcn.num_vcn_inst < AMDGPU_MAX_VCN_INSTANCES)
+				if (adev->vcn.num_vcn_inst <
+				    AMDGPU_MAX_VCN_INSTANCES) {
 					adev->vcn.num_vcn_inst++;
-				else
+					adev->vcn.inst_mask |=
+						(1U << ip->instance_number);
+					adev->jpeg.inst_mask |=
+						(1U << ip->instance_number);
+				} else {
 					dev_err(adev->dev, "Too many VCN instances: %d vs %d\n",
 						adev->vcn.num_vcn_inst + 1,
 						AMDGPU_MAX_VCN_INSTANCES);
+				}
 			}
 			if (le16_to_cpu(ip->hw_id) == SDMA0_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index bb700a2b97c2..90516f623f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -59,6 +59,8 @@ struct amdgpu_jpeg {
 	atomic_t total_submission_cnt;
 	struct ras_common_if	*ras_if;
 	struct amdgpu_jpeg_ras	*ras;
+
+	uint16_t inst_mask;
 	uint8_t num_inst_per_aid;
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6ea3f076257e..47463ef10fce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -273,6 +273,7 @@ struct amdgpu_vcn {
 	struct ras_common_if    *ras_if;
 	struct amdgpu_vcn_ras   *ras;
 
+	uint16_t inst_mask;
 	uint8_t	num_inst_per_aid;
 };
 
-- 
2.40.1

