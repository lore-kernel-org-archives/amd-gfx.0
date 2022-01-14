Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3809C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 04:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF9510EB90;
	Fri, 14 Jan 2022 04:09:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F9710E85F
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 04:09:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeqY/e7+Ur9/ZwcqmZARqP9xDGv297TN7zlZ/SsDxBO+hveLcZy1tkI1JqQUfCo2lHrJE2B6NsIVkLhdEX9cHc49F/VSlmOgAsKDjR4nPBRDQx5N02Q+L1w2WArE8HOSQ2nK8UEenXTqy17hoWkRfTLF9ilfkRIV5EjANa73ZfzxPJW/Mq7KbKF/5wOVz0IkyPt5b6oGteuqAeruYL7CgkTZ/nhm8evk/YSJHk/qd1tpyYTKy6oVpDHsCp4pVkWVMSqnjUCH7jcq19fgHQqTu+eimoHMLuLAfcGC9qDKfrdMhvpPoj2h5pcDEMmpKRGQx+LxTkZjjfxx1cC6BvvPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dA3cfcIQa95NtUIyEvgxokNewyQOqjlIwrxTd6Rl6dE=;
 b=D9VLzwzE0jUfUKir3H4BHJymNYh5ssAprO55N4CyWKcSyHeQCakhpLttchj5ayLKZhi1ulZNsGeseCQIu9glgwvxrMAikRDN+2uPTKpIIU1NFJ5TkIlr9zscxHoCfPWSlYrRSvPcd2FBn3/s88ePiuPibuN9WGZafdx7IuHfrpdlqQMbhQUdTxfSlK30Q41AqU4GDfaNrrDmZx0GaoBrlQOYsQj5C0dctvK99X6As8drlYlYOBldCQyQNjZ8VOpMtAgCJ+oeofN14McfIljx5NcUcHtT3f4W6nlFT6stgAzmNF10EUXI6P2MwS+l0Y4LLlCMWHQfLjXd+LcQ+4ukRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dA3cfcIQa95NtUIyEvgxokNewyQOqjlIwrxTd6Rl6dE=;
 b=I4yy6rHntDJUsozTtHXeHCbC74l2Tn574a4N79m6iy7Td5pECXPXNJqcVf9GW11+JF9Q3O3eTsHAyiverhhTGRQVNO14l3fk8Q+j364Wx9nec/Ss39InoV6fDxE0pUuDd8uE9lLqw5NWZbAmbcJJEEuGOQsJNFGmO575Nuj0qbc=
Received: from DS7PR03CA0327.namprd03.prod.outlook.com (2603:10b6:8:2b::35) by
 BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Fri, 14 Jan 2022 04:09:28 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::44) by DS7PR03CA0327.outlook.office365.com
 (2603:10b6:8:2b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 04:09:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 04:09:27 +0000
Received: from wayne-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 22:09:25 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amd/amdgpu: fixing read wrong pf2vf data in SRIOV
Date: Fri, 14 Jan 2022 12:08:51 +0800
Message-ID: <20220114040850.113575-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef39e17-50f9-4c2d-e7d2-08d9d713a820
X-MS-TrafficTypeDiagnostic: BYAPR12MB2999:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2999D45CA46A2B772D1F8724B7549@BYAPR12MB2999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRrxihcY4IzKCsAKWcWnJQXTwiBvyQHbZ+LevdTEP9ntiPjE1YJCiz8ZuAGafHS+8mizlaegz+RrEa/KrudK7O/5ZOz7/+sVI4mYutCdnWQendItZ7evoF7avLsw7VeKiUdiuU/IE32T6JgXIjFISZWHGC1kaxwDY7GvCefKt3NmItUEv0eUTsqIyNVGPf4A7EqWja/jeXoWbOPK0qGTwMzsDjD/5VW5mgO61K6IdOWWsWv9FxIvikXSVYrwrqbgpmddvUkF5RrXPq/VRI0Yy4uu0mFHJUBuEqi0KftJ7OJsVt508A0n0a2TKfbYSPrKS0un+161HsxNKGD5b0BTtzBSehFZA+uIW7SKbg+TsbaMGH4SOTQeleoDa2EMEzpMNR+2cojFgnU+/BK7Uep4d943T0IWM/0imHPYIUaM0rcJW8g22tAknLwZwKrZAwc8+Q5u4X9GkXkrEph4Itj1zFDBotTqT7LmULDW8Y71aYfoFj2Sg/fOJdrV0IBFTk/IP9H1pzSYHC48MP38rvN0UcL/453n+Q2dDRenF3jZRhwHmYa0iUT4qjjPPoCV7gV6OIy/rOkCSTDSoleZ3KbBtJeXzMG8O1Ybj+I9vr8lspwz2rOb2XxpEFIzQZiWgA2SmmtLn9bNoezj65cJ5VMC5DGY+rDEpJ4mLGeuf0aAYQDWetverj4SXaJoFK74YAFUBQySzQAIXHKEXLKkeJh+yCY2WIXIIN2A6Px+iOAcVkLL2kHFWvyvw17P9ZCa38ba26pbDnpIUHQAKmknXKJoLqFKaVNEXmK+wz49hz1epRc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(16526019)(26005)(186003)(5660300002)(36860700001)(83380400001)(70586007)(2906002)(36756003)(8676002)(316002)(54906003)(70206006)(426003)(1076003)(4326008)(47076005)(508600001)(336012)(86362001)(2616005)(81166007)(6916009)(356005)(6666004)(40460700001)(8936002)(82310400004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 04:09:27.3933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef39e17-50f9-4c2d-e7d2-08d9d713a820
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
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
Cc: horace.chen@amd.com, victor.skvortsov@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
This fixes 35709bd76d229a51b0c571a768b741650ec47828.
we should read pf2vf data based at mman.fw_vram_usage_va after gmc
sw_init. patch 35709bd76 breaks this logic.

[How]
calling amdgpu_virt_exchange_data in amdgpu_virt_init_data_exchange to
set the right base in the right sequence.

v2:
call amdgpu_virt_init_data_exchange after gmc sw_init to make data
exchange workqueue run

v3:
clean up the code logic

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index da3348fa7b0e..5610eae8ef0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2353,7 +2353,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	}
 
 	if (amdgpu_sriov_vf(adev))
-		amdgpu_virt_exchange_data(adev);
+		amdgpu_virt_init_data_exchange(adev);
 
 	r = amdgpu_ib_pool_init(adev);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 894444ab0032..d83dfdc64d49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -625,14 +625,16 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 	adev->virt.fw_reserve.p_vf2pf = NULL;
 	adev->virt.vf2pf_update_interval_ms = 0;
 
-	if (adev->bios != NULL) {
+	if (adev->mman.fw_vram_usage_va != NULL) {
 		adev->virt.vf2pf_update_interval_ms = 2000;
-
+		amdgpu_virt_exchange_data(adev);
+	} else if (adev->bios != NULL) {
 		adev->virt.fw_reserve.p_pf2vf =
 			(struct amd_sriov_msg_pf2vf_info_header *)
 			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
 
 		amdgpu_virt_read_pf2vf_data(adev);
+		return;
 	}
 
 	if (adev->virt.vf2pf_update_interval_ms != 0) {
@@ -674,12 +676,6 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 				if (adev->virt.ras_init_done)
 					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
 			}
-	} else if (adev->bios != NULL) {
-		adev->virt.fw_reserve.p_pf2vf =
-			(struct amd_sriov_msg_pf2vf_info_header *)
-			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
-
-		amdgpu_virt_read_pf2vf_data(adev);
 	}
 }
 
-- 
2.30.2

