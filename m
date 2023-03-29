Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA26C77B62
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4D410EC5C;
	Wed, 29 Mar 2023 20:26:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E0610EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKhGXfDl4BkYFK9WtsySgtwNK1ur8vzZmpaIScfIkJjuKsFNCRWE7+AK/Xria7PcSxrAiGJj/SkmRpv+tEzEkE7N/OQTCLPTPfc4NeH63rhCz4cWVnmYqShd3XsTMffXMzWjwH3IM6hT5Yd7WQKjBHR9z3NAakw51RvCeKc+NzCmN2Ma6ra7HjGOkuZ940YrqbDlcyesybeVDttIQe63xNISgXQLpUN1DOtZtmZh+jwv6N2mWkvwq7RZdiZ0uc4Pn2E0F7XXtbXBf9rbtFSaHHKb8Jlw+DmDDfWxp85zBiJ9tgbsKY3yuoUBvHHWfaYny9tCpDtiifJGa2PVXsp+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0/hOg1uqmJ+lUhP20wceyu0bCowrQYHMZMdLMI7dVU=;
 b=U/Lr0w8vCMqxNmQOndEUZ0NM6W4p4Zn4tGEKadoh/cnSzOGWkREMtgunUZZ6BKiIfVlSEOXfXOgczOuMDC73AnL4ke/ssdDnXaAjKhi2JfyPBiA06UoWe4Fo9tp2kcgLAhScEFEgkZg0Oe2G+tW4+XxdkS7QCEs+206UcaOKKBvfAmttPQPSjpK+4i2bgA4Y9h2wvdnEj3jS4+SJ1K576wFI9o4XgCYYCBAlGiJtjZWLuxOm+y03hisT1kxE6MeTMLbBSukVFfWeA8uZuZfE99pH0K/wuOtt3/aO8UFXD0DvDFIh1OZVLuidQCntVowkObUfWyOKEp6PDOqppDc7AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0/hOg1uqmJ+lUhP20wceyu0bCowrQYHMZMdLMI7dVU=;
 b=rcjwLrZpj/MnN+4l8SVGCyJ+V5xPIYqD69U/ZWSFDew89ceBAoqwzaDgoEr40kSS2MwsaM7PAnvfqmIc78JxA/J5T/JJ+RUuBhIu4d1koU5Uz31ddwbRgZJ3aYsyXBMcmPPyTZ43it7UYzNdV9QleDV7kQ1QN/8x5ldf1A7Ty9A=
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 20:26:05 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::26) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:05 +0000
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
 2023 15:26:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amdgpu: parse base address from new ip discovery
 with 64bit ip base address
Date: Wed, 29 Mar 2023 16:25:41 -0400
Message-ID: <20230329202548.1983334-7-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 37642804-eccd-4ef9-9e4a-08db3093d256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PJ0OkSfwrcBinPlcch6kAGl3ZKRJfBzl3g51deuG9Sp4z67+hFuRJV7kNB54t2AQs9kWh25ViT6Rymtioh2ZNQHdxCUDvmrf/zIxnPGyjfE9bTvA1Qbz6O53JjF8tD7gYgdkoUStrSXnp3mpOe2n40vBzNfhYhLHLHVkYimBuMCZlpKgXHy7W6fp+SNqSEwMajTAC0SFTMRUxhgsls2eNjRmFS/MqvoioJqAjRcO+WpzR8Z5DkV5UKQmYrJW2KsK2ANEV3TBAuXsYOm8o7O4mw/2gEKiXxb3PRJNY7U83cTYsOAqcrGvkqW4Ohv0VzNzdWp0LDrgscEV9NgXFvlzcLcpT0iTTCqj/9aJVzwFmo9xbqtxDPSkMeVoN4K+WJibxRr0HHPUw6t90Pne/U5UVCHKIHDC5Fv/SCqkaYE5iRoDaIGsxS+LkUUY+Y2aZdZNXxwG1XeQCJx5QdnysOJd/3juLHuMPMCvjT25fLo2BGY0+sQi12IUG979WRW/SZZxKsX4qNwTK7FDR/42S9W3B35+xaUmu4GafydeF9uUZjRhm3hOF8hLhNwCkIcanj03HJ9GpwGASKXpAWeo3vPAHnh2ousJUviQKecjrjkN/QgtlgsHb6nBkqhPUs5/2ZKPPJnmYMT5gFRakfA4OUd036bv6tSdRUZs6VFaBUkgJ5vQ0mipH7gqENdjznMMX1vdQYHbHe65X/uYMhsDje60Nrc08Dxlpb26434oq9R8I9ilySS8W7F5HltQWwIzXIG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(82310400005)(36756003)(2906002)(40480700001)(40460700003)(6666004)(36860700001)(426003)(2616005)(478600001)(8676002)(336012)(7696005)(4326008)(70206006)(16526019)(8936002)(316002)(6916009)(82740400003)(54906003)(47076005)(1076003)(81166007)(26005)(83380400001)(186003)(70586007)(356005)(5660300002)(41300700001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:04.9493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37642804-eccd-4ef9-9e4a-08db3093d256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

Truncate the 64bit base address from ip discovery and only store lower 32bit
ip base in reg_offset[].

Bits > 32 follows ASIC specific format, thus just discard them and handle it
within specific ASIC.

By this way reg_offset[] and related helpers can stay unchanged.

v2: make comments more generic

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 54 +++++++++++++++----
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index e211cd687edb..700ac74fcfcc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -532,7 +532,10 @@ static void amdgpu_discovery_read_harvest_bit_per_ip(struct amdgpu_device *adev,
                                 }
                         }
 next_ip:
-			ip_offset += struct_size(ip, base_address, ip->num_base_address);
+			if (ihdr->base_addr_64_bit)
+				ip_offset += struct_size(ip, base_address_64, ip->num_base_address);
+			else
+				ip_offset += struct_size(ip, base_address, ip->num_base_address);
 		}
 	}
 }
@@ -838,7 +841,8 @@ static void ip_disc_release(struct kobject *kobj)
 
 static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 				      struct ip_die_entry *ip_die_entry,
-				      const size_t _ip_offset, const int num_ips)
+				      const size_t _ip_offset, const int num_ips,
+				      bool reg_base_64)
 {
 	int ii, jj, kk, res;
 
@@ -910,15 +914,25 @@ static int amdgpu_discovery_sysfs_ips(struct amdgpu_device *adev,
 			ip_hw_instance->harvest = ip->variant;
 			ip_hw_instance->num_base_addresses = ip->num_base_address;
 
-			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++)
-				ip_hw_instance->base_addr[kk] = ip->base_address[kk];
+			for (kk = 0; kk < ip_hw_instance->num_base_addresses; kk++) {
+				if (reg_base_64)
+					ip_hw_instance->base_addr[kk] =
+						lower_32_bits(le64_to_cpu(ip->base_address_64[kk])) & 0x3FFFFFFF;
+				else
+					ip_hw_instance->base_addr[kk] = ip->base_address[kk];
+			}
 
 			kobject_init(&ip_hw_instance->kobj, &ip_hw_instance_ktype);
 			ip_hw_instance->kobj.kset = &ip_hw_id->hw_id_kset;
 			res = kobject_add(&ip_hw_instance->kobj, NULL,
 					  "%d", ip_hw_instance->num_instance);
 next_ip:
-			ip_offset += struct_size(ip, base_address, ip->num_base_address);
+			if (reg_base_64)
+				ip_offset += struct_size(ip, base_address_64,
+							 ip->num_base_address);
+			else
+				ip_offset += struct_size(ip, base_address,
+							 ip->num_base_address);
 		}
 	}
 
@@ -972,7 +986,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev)
 			return res;
 		}
 
-		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips);
+		amdgpu_discovery_sysfs_ips(adev, ip_die_entry, ip_offset, num_ips, !!ihdr->base_addr_64_bit);
 	}
 
 	return 0;
@@ -1174,12 +1188,26 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 * convert the endianness of base addresses in place,
 				 * so that we don't need to convert them when accessing adev->reg_offset.
 				 */
-				ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
+				if (ihdr->base_addr_64_bit)
+					/* Truncate the 64bit base address from ip discovery
+					 * and only store lower 32bit ip base in reg_offset[].
+					 * Bits > 32 follows ASIC specific format, thus just
+					 * discard them and handle it within specific ASIC.
+					 * By this way reg_offset[] and related helpers can
+					 * stay unchanged.
+					 * The base address is in dwords, thus clear the
+					 * highest 2 bits to store.
+					 */
+					ip->base_address[k] =
+						lower_32_bits(le64_to_cpu(ip->base_address_64[k])) & 0x3FFFFFFF;
+				else
+					ip->base_address[k] = le32_to_cpu(ip->base_address[k]);
 				DRM_DEBUG("\t0x%08x\n", ip->base_address[k]);
 			}
 
 			for (hw_ip = 0; hw_ip < MAX_HWIP; hw_ip++) {
-				if (hw_id_map[hw_ip] == le16_to_cpu(ip->hw_id)) {
+				if (hw_id_map[hw_ip] == le16_to_cpu(ip->hw_id) &&
+				    hw_id_map[hw_ip] != 0) {
 					DRM_DEBUG("set register base offset for %s\n",
 							hw_id_names[le16_to_cpu(ip->hw_id)]);
 					adev->reg_offset[hw_ip][ip->instance_number] =
@@ -1199,7 +1227,10 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 			}
 
 next_ip:
-			ip_offset += struct_size(ip, base_address, ip->num_base_address);
+			if (ihdr->base_addr_64_bit)
+				ip_offset += struct_size(ip, base_address_64, ip->num_base_address);
+			else
+				ip_offset += struct_size(ip, base_address, ip->num_base_address);
 		}
 	}
 
@@ -1249,7 +1280,10 @@ int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int i
 					*revision = ip->revision;
 				return 0;
 			}
-			ip_offset += struct_size(ip, base_address, ip->num_base_address);
+			if (ihdr->base_addr_64_bit)
+				ip_offset += struct_size(ip, base_address_64, ip->num_base_address);
+			else
+				ip_offset += struct_size(ip, base_address, ip->num_base_address);
 		}
 	}
 
-- 
2.39.2

