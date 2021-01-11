Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E147E22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E147E22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A5289E03;
	Mon, 11 Jan 2021 19:56:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7467289E03
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCtIbJ7gh8kTiEPURggNFL6rkcCBw08KRYKiSyZMrvR6iloAflC42oqkxcFo4AgJxzwLjLsTPo0bQEqiPsofcPsnA0V7JgIg7w+iIph6H90V5lcE0fDcK1xslGkaSPVU2IHkWyhCbzBS7xXu6ERRUazG4wkeL3CP4nmsAPbcJx0MOdlmcZhjhxYeT0el9wFz6cjF8v99kqdhufE0ftQYyxKH0KH8Mt6G5kTe7dYWk++C+rtQrTgSP91GOJVAHTyLnWR+bcprqn7n71MyWjtG+BONuTpsTPzGoe1JeUmX3VUp9c1t0BQZ5B5ez452qI7lyZ2w+SNhK88+iii3VwEvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1m4A7A2STmOhcdgBaZFN5tcyso97dceDVqUzBZyjaI=;
 b=dgjp0WR3b9SAvO9o+WsLHrsNK8foa00ksebNfJGGjybexa9LMmzJj2ER4Uy7HgqST3sx0c2uqCRW+DRrtM4tWcbwXrW0n1TQbUqXYWw2mByuFgM4+q3fNEPg1tobwl+SW4kLdBjFx4u3ty1EnzP+1kyLCyVdf5kzAsghVorRRU97cBbae7ondU8cVax2Mg3jku2NG/s9Lmv+4WWdbG71wEEkV48voHYR2oQO05lxvQiDTIACBeJbBvke+UtEv75mKM1RfvCx7f4vQ0VhNQRw+SYqRBZ/hPhd/SzQ8bIPdvT1NcmFzsPgA9VpHUdQh7GYYKi5p3C7lGigCP9zjpXU1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1m4A7A2STmOhcdgBaZFN5tcyso97dceDVqUzBZyjaI=;
 b=NNqYHGo16Rw3j9KCNu1tFHyEPP+/CS5bn2Ej3JEjWGEf/8EG7woDjuA8axI7wqnaiR1+Zo+heSQtmZdCrUZkqUuUnnLkpCRXdq0n6Wx+VJIQn1TdGvlkzxFzZGn/x96s5K2SjnrKS8OpWOdqtOUvcLhqbERDxX0gDWiT/zsTc2w=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by DM5PR12MB1914.namprd12.prod.outlook.com (2603:10b6:3:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 19:55:57 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::d3) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Mon, 11 Jan 2021 19:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 19:55:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 11 Jan
 2021 13:55:55 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 11 Jan
 2021 13:55:55 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 11 Jan 2021 13:55:54 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <Guchun.Chen@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Fix deadlock during gpu reset
Date: Mon, 11 Jan 2021 14:55:35 -0500
Message-ID: <20210111195535.3102394-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a89ff7c4-0b5a-4e99-a8d0-08d8b66ae8c9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1914:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1914E4E243CC4EAD1746D289F9AB0@DM5PR12MB1914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6gWrm9lkzdBGTCCPxM4gb1mNIaYkCDJTwkGE3ePqe1DMHMsKVJS7faGhjyo2feICHj6/yfZ/8BdZEynG/Q/843QEMxhyckQjQc+fMQRPYgyqo5478ZFpnCTIEL/WZ6SK2XY/FX+v/wbMfzElEGHx3D63lnsnXRY5WtIPddmmOb8+epAVg/7i47FO6H6OX3tLBEkyzGtxQ6b6jDrLoBaKx9sVMeyUv+d1kG12DXBFG11F33pSKVEeCefCc81zT2FjnaLr8JtLCz9zKrAS+4/THgy8bTBb36c6rCUBdOpJnCqPJIqZIAxzvdT501XSLq1jgAS+jTfK5/A8YJussQnSv0m1tdtipTgrngTxjaYBwj8sdx7w8Bryf0vIuB6PfWhyDtvJsjOrwEz7U7JcT3s2ie3S/7+xogGhXZrbJyuVeyXqJw6Ma8IGn/+ez4pCtloyv4/GEtfMXHVp2rWdPlhd6ghDYpJNTgUbplrGvdVT2M0BZ5ZbkWTMzThqcIE6Xyls
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(46966006)(6666004)(47076005)(1076003)(36756003)(478600001)(81166007)(8676002)(82310400003)(70206006)(70586007)(34020700004)(82740400003)(426003)(356005)(4326008)(54906003)(5660300002)(26005)(110136005)(7696005)(2906002)(6636002)(83380400001)(8936002)(186003)(86362001)(316002)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 19:55:56.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a89ff7c4-0b5a-4e99-a8d0-08d8b66ae8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1914
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
during idle optimizations we acquire the dc_lock, this lock is also
acquired during gpu_reset so we end up hanging the system due to a
deadlock

[How]
If we are in gpu reset dont acquire the dc lock, as we already have it

Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 99c7f9eb44aa..2170e1b2d32c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5556,7 +5556,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
 		return -EBUSY;
 
-	mutex_lock(&dm->dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_lock(&dm->dc_lock);
 
 	if (enable)
 		dm->active_vblank_irq_count++;
@@ -5568,7 +5569,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 
 	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
 
-	mutex_unlock(&dm->dc_lock);
+	if (!amdgpu_in_reset(adev))
+		mutex_unlock(&dm->dc_lock);
 
 	return 0;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
