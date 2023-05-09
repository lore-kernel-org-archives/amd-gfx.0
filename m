Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F252AC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95B4610E408;
	Tue,  9 May 2023 22:10:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B78A910E406
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:10:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOStcU5k0FifVDZgj0oc1JkqDP5SLZSkJ2YycPQ49xc7/oQTm8J58N3TUZfz9imo9jMPv/vEDKlWVAlf8PczOslplZG81JijdY4S82OX29Bfq/QKeRYIPLSldjZqnzLIxR7QfFqCYe0V4xZtxX/RV3KDB5iOm+H+KRNiwucpc4c4sTjH4pnKrLEtWnx6ZZMGCm3yZv8HdFbATfEe79mHfvQ4yBIoVOsSyXpEKBnTEEnzk7YRxICVdVorpJ0Yf0ybP9rmtpDqTxEQHJwGX5vDDsIFqYueloMsaR5i0+8XTdtgfXSs6z+xzIbYYytgsl26sF0GksVvAoIHUctNWJjHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B32/fK0dQGVdM39zjrzDMuklTofyTtg5hcOcIdWzJQo=;
 b=O+LdbXhs6g9bpUNubN0y9uwZqd4aUlkVE8linOoG22jWIjP+yT6fRnRuEL7JcUSQD+0NysvXJkFxpsrXkun7fB2TrF/K5yq/9sr4Rm24R4sObMvmFFbu+p02IjLfZ04bun7EkD95to/DcAjHTiGpQBJsmDmEc78eHdowgtafu8724gkZKJuEuOzyVtst/plUjF0nesib23BXm2kmDoWjT6JjCvM23726qrgyqy2tT7GVpZNahOFayE1W4p5jIFcmjZopXKhuDtfsgfwHNNpD+dn7Rr/NZzRuV+2LrSNosFhbmH560QRcsO1BaZhdWZVVLnX2lw7UMlWDGNHQUxrVIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B32/fK0dQGVdM39zjrzDMuklTofyTtg5hcOcIdWzJQo=;
 b=11TNy89Dc//GuYA3q/QYAsDpMK39veirD78Hzp9hurepzoG2KHtmTnj7k8LeFLHUIhd9bfmHgtCp2IabjkBjysb3OlT8+2FTIzuj7cOQH0rqUu5PNE8RJlv0hoLc+MBmolTAn65QWiD2ZDvTP3va1phvgDvjo6w1zDSDv3h/RCM=
Received: from BN1PR10CA0030.namprd10.prod.outlook.com (2603:10b6:408:e0::35)
 by SN7PR12MB7273.namprd12.prod.outlook.com (2603:10b6:806:2ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:10:20 +0000
Received: from BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::ad) by BN1PR10CA0030.outlook.office365.com
 (2603:10b6:408:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT033.mail.protection.outlook.com (10.13.177.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:10:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:10:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: Fix discovery sys node harvest info
Date: Tue, 9 May 2023 18:10:02 -0400
Message-ID: <20230509221003.475858-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221003.475858-1-alexander.deucher@amd.com>
References: <20230509221003.475858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT033:EE_|SN7PR12MB7273:EE_
X-MS-Office365-Filtering-Correlation-Id: c06d6cc2-94a9-4fa2-1991-08db50da2d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8q9XEu0K3wduE7ycnmozU7TmIErirJTBOObutM2gxMFU66mgEtCYVTAjkNT47RocS9aorYwm7S5JyGwqr7WK9/rRvAMu31t/ImcBSit6NIOYCVa9ZI3wr6f9lSWfZGYnht2sJreCcxtmJ+Enzzi15BDCDkukT8hTGLwmuBrcVICkoVmz+TJkOFvRTjBYwP99x5ya5TrigedMh5fQhtsz/QmoYmm2RKPTw5OWkMWYMIMV6gTn7HHAXYK1SSBp2pY6EfKib8duEifEcV6L2fcL2HM7OguzMXM0M2WZJcqBV00g9PjgHKgv048djj8/6jJn/Ihwkx09F8hFNYeGNRKnhaFciI3D4NTwbgR3xApgo5F7L0v4Z3Y9nPcGW7GblJ266n3KHYskrD086zi3BrLIdeeEaFIjW/5weBTuY2Ty8+EyFFEYHAsjkx8fdpqJddpVdPS6IPSlPSGdMQk7gstidmq/oNecbFeQIUjIGG61n0aObsyrWzCDMBRC2k/9vgk1rlBqGVH6pii7XtnfSY3xq6/ymKIFgK9Ypzdhk829Gj3GBltxKxZETwSHt9ixVxPZf2V2GMECnVkJW07a3fdkBaorQ6N1UXknH+LU97/EzSDRHxoerSjSMeCr1eJojB7ThV/cB2SbLiiUpkEb0gb44RkMLNX2MSils/Pe7BuveR6Hw/Z29mQk59+WWitU93bBsRzvdKxuVwnRSkn5tdJJxaJpI/F30p2bPx9Fj3K57Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(2906002)(8936002)(478600001)(316002)(5660300002)(8676002)(6916009)(54906003)(41300700001)(16526019)(6666004)(70586007)(70206006)(7696005)(1076003)(26005)(186003)(40460700003)(83380400001)(82740400003)(47076005)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:10:19.9902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06d6cc2-94a9-4fa2-1991-08db50da2d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7273
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

From: Lijo Lazar <lijo.lazar@amd.com>

Initalize syfs nodes after harvest information is fetched and fetch the
correct harvest info based on each IP instance.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 41 +++++++++++++++++--
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 01b21988c1ae..d81b2e1e8aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -877,6 +877,36 @@ static void ip_disc_release(struct kobject *kobj)
 	kfree(ip_top);
 }
 
+static uint8_t amdgpu_discovery_get_harvest_info(struct amdgpu_device *adev,
+						 uint16_t hw_id, uint8_t inst)
+{
+	uint8_t harvest = 0;
+
+	/* Until a uniform way is figured, get mask based on hwid */
+	switch (hw_id) {
+	case VCN_HWID:
+		harvest = (1 << inst) & adev->vcn.harvest_config;
+		break;
+	case DMU_HWID:
+		if (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+			harvest = 0x1;
+		break;
+	case UMC_HWID:
+		/* TODO: It needs another parsing; for now, ignore.*/
+		break;
+	case GC_HWID:
+		harvest = ((1 << inst) & adev->gfx.xcc_mask) == 0;
+		break;
+	case SDMA0_HWID:
+		harvest = ((1 << inst) & adev->sdma.sdma_mask) == 0;
+		break;
+	default:
+		break;
+	}
+
+	return harvest;
+}
+
 static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				      struct ip_die_entry *ip_die_entry,
 				      const size_t _ip_offset, const int num_ips,
@@ -949,7 +979,10 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->major = ip->major;
 			ip_hw_instance->minor = ip->minor;
 			ip_hw_instance->revision = ip->revision;
-			ip_hw_instance->harvest = ip->variant;
+			ip_hw_instance->harvest =
+				amdgpu_discovery_get_harvest_info(
+					adev, ip_hw_instance->hw_id,
+					ip_hw_instance->num_instance);
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
 			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++) {
@@ -1035,6 +1068,9 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
 	struct kset *die_kset;
 	int res, ii;
 
+	if (!adev->mman.discovery_bin)
+		return -EINVAL;
+
 	adev->ip_top = kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
 	if (!adev->ip_top)
 		return -ENOMEM;
@@ -1282,8 +1318,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 		}
 	}
 
-	amdgpu_discovery_sysfs_init(adev);
-
 	return 0;
 }
 
@@ -2224,6 +2258,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	}
 
 	amdgpu_discovery_init_soc_config(adev);
+	amdgpu_discovery_sysfs_init(adev);
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 0, 1):
-- 
2.40.1

