Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DEDCC6B19
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 17:44:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C342710E85A;
	Tue, 13 Oct 2026 17:43:56 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011028.outbound.protection.outlook.com
 [40.93.194.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C0F10E709
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 17:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apHAp5ruzhAIdNeiU+xyr6+KTKZ3puCsWy3oa2pHoNDTzcmmxhTTibovoLe1zcbrTZnQ5Qd98dC9ly6loS/OjG+0PfBV7xoYVH0prnebVCO92C7JSQgQ1hz0QAtjyv1NRJa4k4s60ZzFhCPqhyheDXbS20EtWKHUAbNHlBxWRRQH48ri+ji+cH5fS9/nN018GwrgFeI/yOzfJYXsMikwnUti4Wn1lQgp79302M8Ml6FysYzeZZP9hZs1JsAYieZi/tZXLSt7IbpHc3jYpksFALaLMu+PqwrtVMGx2irNR6fPOuLyAwSdryAq/XZ1TDwxJ+fiNnzWQFNsWIc7DMBhQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K07QNTpyqfT+zTtBtbkPr3rG3vSCRzoOXiGUwSuv+A4=;
 b=vxiAaUHQkpf6aF0d0AlSJaaT4vpG7s4U8MybJig4rdqXSIa6FHXss3HUptjOF/i7p/FtE9y/FcL4Ik09tS/vz928WiP6DKfgCNkAL+7kj+4k2RImvhRv3w8tcUetzy5GqpCEWgcS69oReFUE0KqPyrJfNY59rG76ZdM8s+gP0mZtbUUdxLWTYANk0GV1BeGe0bVeDPX5nnSeENPjYe3wN9WnfI7++wlxVlWLt1pG7HZ1stLk5DE2HAyMkY2xaLdu/RpgGIzOgjikFRaGOqCP29TGLCOC1L5Uc2Of9TbYhY4kk3O8dyzIeokqxIKZZOmL5Nsr0o07gcbPa8gG8Wv0HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K07QNTpyqfT+zTtBtbkPr3rG3vSCRzoOXiGUwSuv+A4=;
 b=UT/4u0Qw9xcdM0X7RGhzTDlJEAz4ri80UjElqKtF1rhudLqqL+VC1N+97OsS6N2tithREHsioLddSmpj8FocftpIpUFhnmS/qp/0Ny31aEhsF66ta+DTusHv2ZnFmJ2jaWarPWm8luaSsWQxxzVgZkG/f8vP/8MBuonZFyzAeuA=
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Tue, 13 Oct
 2026 17:43:45 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::a4) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 17:43:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 17:43:44 +0000
Received: from MKMWIAITKEN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 12:43:38 -0500
From: <will.aitken@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Will Aitken <will.aitken@amd.com>
Subject: [PATCH v2] drm/amdgpu: Ensure fb-sharing is enabled for xgmi same
 hive check
Date: Tue, 13 Oct 2026 13:43:30 -0400
Message-ID: <20261013174330.20307-1-will.aitken@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffca83f-2491-4ab1-3cda-08df2951871f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: A5iL8NTA/GLhMyksmK4PxnlSM1HJrwSllruoM8Lab7HO/Vn2RVVxSs4WcLLoOPKXQI+qo3PiCRWOdGpUA+2I2XIaYofYkxtBd/yXWd0yMNin4pD35bQkIwAIxC8hEpfVYIUlDOqP9LMz9f9fW3aZtW7xF6n+wFo4TJidARQ3DF1uk2MtEWfvxZlDKwc5pP/fyx6yWIm1TQ87qv/+gG/M3hrmq2IDY2IQvfI3Xn85a/+osE3VU9gBVLo2sPtqqCiuLdcN4zyMsVtwfKq/vrqutjF+YEfjsN2+1RBoDylaHpXkaVFcyuIUeenM3mmeuEND0U9lx8w45eh66GmMrYmEJlskO+pTVajfaZaZSpYZxQDT34gZ7RI92wcINkBVo4r2gNi8YdAGunLnD6LoHUTObEMfp0DHyjl2p5rb41sn4oZm3pX2BeQD/cNh+tlFe2xWhvJkVV1IEj12//f9RA4F5jG1HIw4LFpGVQi4XfyjTLYgjSR3ij07OliIH4L2i5+nKnD8IJUzE14rDZBBUJjyKbH9LSWjghukhNYMOOZL7L5yi4DYv1yAkqGcqnXXgXmWAF0JVAXcnSRoq9Q21GanUgQ7M15Ni71u0R0cpZRkDOvMx1/DdfDMjsGteo8uvMZoODpA7oX4Lr3bVyOVhJp6WAQ+sncK3UhwdXlEshX+M3QbcZzeQSipt/RsW22fHyU+B/yeGUWmxrgliONuAdRiQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PZwIukHD8ZmCMt51o9pjistMbNg8r4eje3J2lNfQII6gbRT+OvqIOlczLY1/ZMck7/3zDK/ytml3OxODZ9Wm4DbTd1sH/liyrSVTQMoo+2Io7iTWyBT9YGAPWMGeax/RvCxo7g6Wr0oKeaUSTvDM9w3Y+WlA7EOhVYx/9vpz6zvHm+EN/SneTdBnTZEWr+mhAtAtur078dSupc9fvN2qnxi+4ofy+p7W2oOsE1F9k1Zi28PJHKtWlaNhzGRnIoXN5AuBRw8AETH96Rb8N2S+greKGuS44viQ271/4wmVpyKRWS9nZQiem5u6Qef3bYGmXdC41Nt9g9umU9Pp/xBznAU47B8c0r6kA+Sqq58StgMouAn4Lu57ushTG/g8eMj8maA5ci9JOE8zc3erK7HGYxObrhb/GW3X3Ydo3BgUwGCRBa/zkrvDwOsUk1mKrI0b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 17:43:44.5399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffca83f-2491-4ab1-3cda-08df2951871f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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

From: Will Aitken <will.aitken@amd.com>

In sriov, fb-sharing can be disabled via the xgmi ta. For this scenario,
hive_id alone is insufficient for determining peer accessibility.
fb-sharing enable flag needs to be checked as well.

v2: Move fb-sharing gate to amdgpu_xgmi_same_hive from
amdgpu_dmabuf_is_xgmi_accessible. All xgmi connectivity checks need it.

Signed-off-by: Will Aitken <will.aitken@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 45e31b3daf06..ccd6429ad7b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -349,6 +349,9 @@ int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev, int global_link_num)
  * The XGMI memory space is built by contiguously adding the power of
  * two padded VRAM space from each node to each other.
  *
+ * Note that even if multiple GPUs have the same hive ID, sharing between their
+ * memory spaces via XGMI links can be disabled in firmware, i.e. hive
+ * membership does not guarantee connectivity.
  */
 
 static struct attribute amdgpu_xgmi_hive_id = {
@@ -1484,7 +1487,8 @@ bool amdgpu_xgmi_same_hive(struct amdgpu_device *adev,
 {
 	return (amdgpu_use_xgmi_p2p && adev != bo_adev &&
 		adev->gmc.xgmi.hive_id &&
-		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id);
+		adev->gmc.xgmi.hive_id == bo_adev->gmc.xgmi.hive_id &&
+		amdgpu_xgmi_get_is_sharing_enabled(adev, bo_adev));
 }
 
 void amdgpu_xgmi_early_init(struct amdgpu_device *adev)
-- 
2.43.0

