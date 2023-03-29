Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00FCC74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29FF10EC60;
	Wed, 29 Mar 2023 20:26:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39BE210EC58
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Zf598Mm0P/FVYzTl0s+aG8qZlnLoPJdLZpIJ0ps2LpYUbesPaMzEIMJ00QI4UUFlDukqUiG4zRI9FwrPO0Ixj4xdmTSbefn2jYQrMC0A5FW7DOL81Effwr8UobYt6q+QNVdzx9l6YIFFrBfGr09qYxvfWeTE2bN+dCeA1y7WDQTCywhDplrafWqEMKSq8/pyfeEsudL6O5oax44zOKLsveyTRvAmfxamVTNl3XPiZIRf9b9NKM8FVrQq0k1Kx2xeWo+fY2X1WLE/ZPnpRXwvtZlY+arv1GN9V/DtRdxwUnHff49BhGZPo+tQkInUWKB9WwUtjEusKTyMepUPCQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTn4VO4YyS2lhbemNlREQrffLVA9tCb5rFvubkcB5DM=;
 b=PZc267P7XP4F54ai3xJwayyOkfI2tGJxynwrCPSM8gU1RnvxPMnmSpbXhId4rWu+hPKd5cVmc0LrSvRH6s0LvfIP/WF6UBwnykQN3N4n55V0rwsIKl9CkTdmIxiXSWCcVwM80FNQQwUKIROKcknW53obyXTYVpgAzyEJFiulLv0hPmucElWj9GAs8aPWir391VoH+EoqbPKb9BcNGsK153cNjykGtXeUsYlG2SLwYgG5+b4L08M+lAqBm/FzCROyVB6r8lAibsWoBNr0tqQWPWRaZwE9iOeqDzjc4jySRESNMIqSaKPnEndCaE9DHlT1UYof6fHSGt8zRFnXARMAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTn4VO4YyS2lhbemNlREQrffLVA9tCb5rFvubkcB5DM=;
 b=pdjE0VLbiYJN8/gdIfpwLqVDjH2Zm/hmZXsQeqamPTL0cCNcapyvtVbWiekxWKWo8CN3TSTBPq1mQ5cI/qb0UTkOA7nqG11HUqgKowrSwfuWlrPrpXOd9xhDc+2iZEqD5o/N3ufj6E87agYTpI+Ai49b5WC9juvaKI3duDrjRpw=
Received: from DS7PR03CA0140.namprd03.prod.outlook.com (2603:10b6:5:3b4::25)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:26:04 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::cf) by DS7PR03CA0140.outlook.office365.com
 (2603:10b6:5:3b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amdgpu: upgrade amdgpu_discovery struct ip to ip_v4
Date: Wed, 29 Mar 2023 16:25:40 -0400
Message-ID: <20230329202548.1983334-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: a00845d3-0cc1-4f21-3b5b-08db3093d20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cgd65oXoquNIGV37fXJLOsK6Sg/5w/5cAxYXki1cPsNARpoZgPVSMFpsFHv7FirkjuV4WBRJ00Hby/f9AdSBurbGJKbYSId+32wA8lPxU4CV1WE63Gv/e1ajM8t4gNYszio8AWAOYHZpHbsa4Uz7wi+GyQZ6mJsLyZ1ImWYM6ytK2/rAO47hhr3/3KNYG2jIykc9jVl23boSYxGpUumu37bAz08RtfOvggTsnoXc/Hs6PgqPNDh1tyn8391qXgmCwLFGd0K/3GIpH+7J2pTXEg/E9icufU5Mxw79wOsH8Ni4VKb0FdXmrb8Ug3ORPT6S+6Grzsa8trKh8fIfSecAo/viqZUASrhyKxz+7hbGe1xV7p6OjnMUbdHCRgoVouDPFhJA3r8XQMHBZUXjX51Kb3eK9V+M4rRLsRHbi4De/WpqTcCtWWvyaZIKWtbMp4PRKQq9QNuHcGiKuHarBf5OSLWLDZy1Zi34CEccmdqGgX23+VB3UPCd4PBylt5iXpfW5epyaMdssvr8cYo4wwNYPxUIcvWrdIB8MHhRvROevs89ZuzBaHeD2S2gPxBMw99qJbK8JpWZhdgSL0e+dYhBRAOUFmTdGajoXSdAv+01OBqzqQM+Mi4Vh1PPpXTpkqhRyupzfcggVY3IJd8RERYzoJMBbasPfL7wTXmgqt+cogEW06U3W/ezKjJjIpoIuSh1IO3h7oBDRPudafU6tXqok/YmFz3nF+G0Wv8Q6oCMgxI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(356005)(6916009)(4326008)(186003)(70586007)(16526019)(70206006)(336012)(426003)(40480700001)(8676002)(36756003)(47076005)(8936002)(5660300002)(2906002)(83380400001)(36860700001)(41300700001)(40460700003)(2616005)(82310400005)(7696005)(26005)(54906003)(478600001)(86362001)(6666004)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:04.4487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a00845d3-0cc1-4f21-3b5b-08db3093d20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

version 4 supports 64bit ip base address

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f5d146c998a1..e211cd687edb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -471,11 +471,11 @@ void amdgpu_discovery_fini(struct amdgpu_device *adev)
 	adev->mman.discovery_bin = NULL;
 }
 
-static int amdgpu_discovery_validate_ip(const struct ip *ip)
+static int amdgpu_discovery_validate_ip(const struct ip_v4 *ip)
 {
-	if (ip->number_instance >= HWIP_MAX_INSTANCE) {
-		DRM_ERROR("Unexpected number_instance (%d) from ip discovery blob\n",
-			  ip->number_instance);
+	if (ip->instance_number >= HWIP_MAX_INSTANCE) {
+		DRM_ERROR("Unexpected instance_number (%d) from ip discovery blob\n",
+			  ip->instance_number);
 		return -EINVAL;
 	}
 	if (le16_to_cpu(ip->hw_id) >= HW_ID_MAX) {
@@ -493,7 +493,7 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
-	struct ip *ip;
+	struct ip_v4 *ip;
 	uint16_t die_offset, ip_offset, num_dies, num_ips;
 	int i, j;
 
@@ -510,16 +510,16 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
 
 			if (amdgpu_discovery_validate_ip(ip))
 				goto next_ip;
 
-			if (le16_to_cpu(ip->harvest) == 1) {
+			if (le16_to_cpu(ip->variant) == 1) {
 				switch (le16_to_cpu(ip->hw_id)) {
 				case VCN_HWID:
 					(*vcn_harvest_count)++;
-					if (ip->number_instance == 0)
+					if (ip->instance_number == 0)
 						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN0;
 					else
 						adev->vcn.harvest_config |= AMDGPU_VCN_HARVEST_VCN1;
@@ -852,10 +852,10 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 		size_t ip_offset = _ip_offset;
 
 		for (jj = 0; jj < num_ips; jj++) {
-			struct ip *ip;
+			struct ip_v4 *ip;
 			struct ip_hw_instance *ip_hw_instance;
 
-			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
 			if (amdgpu_discovery_validate_ip(ip) ||
 			    le16_to_cpu(ip->hw_id) != ii)
 				goto next_ip;
@@ -903,11 +903,11 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				return -ENOMEM;
 			}
 			ip_hw_instance->hw_id = le16_to_cpu(ip->hw_id); /* == ii */
-			ip_hw_instance->num_instance = ip->number_instance;
+			ip_hw_instance->num_instance = ip->instance_number;
 			ip_hw_instance->major = ip->major;
 			ip_hw_instance->minor = ip->minor;
 			ip_hw_instance->revision = ip->revision;
-			ip_hw_instance->harvest = ip->harvest;
+			ip_hw_instance->harvest = ip->variant;
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
 			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
@@ -1082,7 +1082,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
-	struct ip *ip;
+	struct ip_v4 *ip;
 	uint16_t die_offset;
 	uint16_t ip_offset;
 	uint16_t num_dies;
@@ -1121,7 +1121,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				le16_to_cpu(dhdr->die_id), num_ips);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
 
 			if (amdgpu_discovery_validate_ip(ip))
 				goto next_ip;
@@ -1131,7 +1131,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
 				  hw_id_names[le16_to_cpu(ip->hw_id)],
 				  le16_to_cpu(ip->hw_id),
-				  ip->number_instance,
+				  ip->instance_number,
 				  ip->major, ip->minor,
 				  ip->revision);
 
@@ -1182,7 +1182,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				if (hw_id_map[hw_ip] == le16_to_cpu(ip->hw_id)) {
 					DRM_DEBUG("set register base offset for %s\n",
 							hw_id_names[le16_to_cpu(ip->hw_id)]);
-					adev->reg_offset[hw_ip][ip->number_instance] =
+					adev->reg_offset[hw_ip][ip->instance_number] =
 						ip->base_address;
 					/* Instance support is somewhat inconsistent.
 					 * SDMA is a good example.  Sienna cichlid has 4 total
@@ -1193,7 +1193,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 					 * example.  On most chips there are multiple instances
 					 * with the same HWID.
 					 */
-					adev->ip_versions[hw_ip][ip->number_instance] =
+					adev->ip_versions[hw_ip][ip->instance_number] =
 						IP_VERSION(ip->major, ip->minor, ip->revision);
 				}
 			}
@@ -1208,13 +1208,13 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
+int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int instance_number,
 				    int *major, int *minor, int *revision)
 {
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
-	struct ip *ip;
+	struct ip_v4 *ip;
 	uint16_t die_offset;
 	uint16_t ip_offset;
 	uint16_t num_dies;
@@ -1238,9 +1238,9 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int n
 		ip_offset = die_offset + sizeof(*dhdr);
 
 		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
+			ip = (struct ip_v4 *)(adev->mman.discovery_bin + ip_offset);
 
-			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
+			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->instance_number == instance_number)) {
 				if (major)
 					*major = ip->major;
 				if (minor)
-- 
2.39.2

