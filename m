Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC6C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691AB10EFFD;
	Thu, 30 Mar 2023 19:43:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86DA910EFF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpOyAL9HPyEIMALuoFv/AW7J7AiIPlAdGnBr5sefRkazjFVl9TAoyzgMXEzIKFaCt4AZAJTvdSTlJL2OTi6vCfTrZdgf0IeJXGJcA9EZDvgXHMRiXNOIbdvYE9fWy97ORno5frj65mQ8GLoMCPGi+QKl6Q/AnmkMDz7cMCVo1bNlE/9unxipvxboOkJbF0oR9okuei+ooseWYF6y0g6LklQrzEMIQuK/2Dg2zkugL9sRKGtGVZQy9yfwZ2MJ2s100dErKUY8gLmayrts6qKDdy4JSK79wojnXM9U5Tut05LKKdhHoQzDKxqDPhHUuUElZSFRXl9C/a/KaOfF1FJagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nsak9SCOGHonjNdzx6/L53q9xIhM4kNSxNqwnO3P/bs=;
 b=b2mr9ml67SYnbSiceEAOcckrj+WxEjkVYV55D8gUguOUXtdp1w2iXE4WIkRf75quArult5Pd46Vcft+0/EReM0U2zBv2e4PBf2if8jKqPqbtg2OH0JNjNTOSvtFBxJWMkXeQQgCOcdsPIEobVGlaLaZI/amb1W92ADZEALaeUTUaSlrGJzbmpT8vzSyqAKNj8e7ZQy39708Ufmyb8Mwc5NQNYxuzNC7tww+xdIV0TQxzwzLmJ6xTk+Sy9Q9w829UO39gbJQwHsJjNhKuv4Y6RSQypQoOdIl9Y3SYsWbcP99rjdgiROf8qMl16poHhlw1Yo1PEDYkSqkFHwnQ1hxVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nsak9SCOGHonjNdzx6/L53q9xIhM4kNSxNqwnO3P/bs=;
 b=PQqVqyqKZ8IesWA6BOtp6ixkNNqKyS9y7fC9XPSqbpocfaVwYUnliHTDJhqBBNW1MchKM/TDX3gFIvtZExR4F9cXQ9wUPu6J+ZCmgA8fhAnGM9bmhg/KfdyPEoLRQu1ane9q5SoXRpymw1u3p5VlAiPSr0pImdqdcI9tsKxJtmk=
Received: from DM6PR03CA0075.namprd03.prod.outlook.com (2603:10b6:5:333::8) by
 IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Thu, 30 Mar
 2023 19:42:59 +0000
Received: from DS1PEPF0000E63C.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::17) by DM6PR03CA0075.outlook.office365.com
 (2603:10b6:5:333::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63C.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/23] drm/amdgpu: Use discovery to get XCC/SDMA mask
Date: Thu, 30 Mar 2023 15:42:33 -0400
Message-ID: <20230330194234.1135527-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63C:EE_|IA0PR12MB9012:EE_
X-MS-Office365-Filtering-Correlation-Id: c31bc465-b6ae-4935-9caf-08db3156f7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NYvCuMRDyqKwpwuWZquL+1iMDeFnsaWTo3sJ+HkLCsOOQnyo53BCQl4uh/idlURxAPh/jk+FePPRTJqUafi93voOxJhIhss971xt+gfzUns8+A9taoDgOvYgCsRn85F0/Y4OfosStj0yuSevTozgCWPGrOmbYdZpWfSf5QxD8ovnIH5GOUirhm8FiP51wThlFvOqpMQqhpv0mi+hYxp0RQhZTiBqeBnKILdT0WL1wQIjLmIYF8va7EQfK5UGXnAiY5zKhw+3eter85rkhPmmhYx9gDwW9nH8r8tgsbNewWWWvaNetZ6TciWYprIYFTldzIUeho0oiNDWlgFx8OOawWCLB0lfNSxLHgFChkNsBLKPNX5fPvDr4znd1HDVdKD177DmE+Q0ahoYPtc26kigJMH91nsZgYjFm2UzbANviEqMoq/PyhCpYT7LyHhiYWnyGxmE7rR8gL1KKde1orjpA+gjx7j5x8tsXBoaqeADCUUvmDBN0OsmQY32as/kBu9CmTQtzbBtqWvM5O0qd4Rrh9jgdfiaGp8nBupv24eYk9QCKqOYNkCcqSPA3bYPVtrD2pmkXnuqaGZtx788dA6XTTLVOAUMVh+r36Uq36m5rU/t5XdL9eLXY7RYSI3/JQjWkz/3COCcYoC4Wp5FDE9O7MIKsxclJsZ2kAXHCavJZK8z12t2CDWembz/IKzom4dXs59ABf5VzqsUn4XenVyJOBcJCb21M5NPh57o5iKfrGo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(426003)(83380400001)(336012)(2906002)(47076005)(2616005)(7696005)(478600001)(316002)(36756003)(40460700003)(54906003)(70586007)(70206006)(186003)(4326008)(41300700001)(6666004)(8676002)(6916009)(81166007)(1076003)(82310400005)(86362001)(16526019)(82740400003)(26005)(40480700001)(36860700001)(5660300002)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:59.3919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c31bc465-b6ae-4935-9caf-08db3156f7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Get information about active XCC and SDMAs from discovery table.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 25 ++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cbdea32e40e4..5dc89cfa86ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -574,6 +574,14 @@ static void amdgpu_discovery_read_from_harvest_table(struct amdgpu_device *adev,
 				1 << (le16_to_cpu(harvest_info->list[i].number_instance));
 			(*umc_harvest_count)++;
 			break;
+		case GC_HWID:
+			adev->gfx.xcc_mask &=
+				~(1U << harvest_info->list[i].number_instance);
+			break;
+		case SDMA0_HWID:
+			adev->sdma.sdma_mask &=
+				~(1U << harvest_info->list[i].number_instance);
+			break;
 		default:
 			break;
 		}
@@ -1106,6 +1114,8 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	adev->gfx.xcc_mask = 0;
+	adev->sdma.sdma_mask = 0;
 	bhdr = (struct binary_header *)adev->mman.discovery_bin;
 	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
 			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
@@ -1164,12 +1174,16 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			    le16_to_cpu(ip->hw_id) == SDMA1_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA2_HWID ||
 			    le16_to_cpu(ip->hw_id) == SDMA3_HWID) {
-				if (adev->sdma.num_instances < AMDGPU_MAX_SDMA_INSTANCES)
+				if (adev->sdma.num_instances <
+				    AMDGPU_MAX_SDMA_INSTANCES) {
 					adev->sdma.num_instances++;
-				else
+					adev->sdma.sdma_mask |=
+						(1U << ip->instance_number);
+				} else {
 					dev_err(adev->dev, "Too many SDMA instances: %d vs %d\n",
 						adev->sdma.num_instances + 1,
 						AMDGPU_MAX_SDMA_INSTANCES);
+				}
 			}
 
 			if (le16_to_cpu(ip->hw_id) == UMC_HWID) {
@@ -1177,6 +1191,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				adev->umc.node_inst_num++;
 			}
 
+			if (le16_to_cpu(ip->hw_id) == GC_HWID)
+				adev->gfx.xcc_mask |=
+					(1U << ip->instance_number);
+
 			for (k = 0; k < num_base_address; k++) {
 				/*
 				 * convert the endianness of base addresses in place,
@@ -1294,7 +1312,8 @@ static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 	 * so read harvest bit per IP data structure to set
 	 * harvest configuration.
 	 */
-	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0)) {
+	if (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 2, 0) &&
+	    adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3)) {
 		if ((adev->pdev->device == 0x731E &&
 			(adev->pdev->revision == 0xC6 ||
 			 adev->pdev->revision == 0xC7)) ||
-- 
2.39.2

