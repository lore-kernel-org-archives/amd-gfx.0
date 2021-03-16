Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB474C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 23:50:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770FD64F0C
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 23:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770FD64F0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C35989824;
	Tue, 16 Mar 2021 23:50:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756EC89824
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 23:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbJwnF2SNSLWoEp6RG165CRJ1eogJUaIpptiu3zop2yBaQWI+rxe9RSKOTi8638qct5HD9ho38SopJAYaAWGRN/Ud//ty8RAe9t5cM+o4FrCUNDn3Mjjxd8mcdB2uq+i5NxXEA84JcjhGTgLxJq5G+BVCnnzE+dR30CPlGnksXuaKhK0Cu2w7k4PFNNXcP0u3YoJoOl+F0N4R+yjFR+bQoBXSSX6DI18ugOexMYw3GNrjN05e9uUhLBWpBGyrTs5Barvk26b2MC/fHoTjqziH4Lqvc8DLArCBTy9pWKdQ1Gi5y6p7nC8tY0VRJN2NGBkezodtsuYLYWau/eZXN88TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf90yGH2KhTWScfROBIsNVWuIpSfWEJy/OWtRmKMdAc=;
 b=TcEOEOe4tiRBq4haiNVnbjWyh9kllc5KStpSwPEYTwVK9VfRxesAqrlEBsgmwkNJ64oRWkXU3bocLQB8KbFu1Qiw1HCKLKOA4V7zRGk1qjrT/gptwdIwTSv8tm37we5f455NqRX2wVf/p5j4J4pDuVAbzufOubqvMnyXWEyCRDYaxSv1y0HYg4Fk/LuKtpKjDBLC/ZGOBWDzZv3H5hREJ95bhR8gl8sl2U01h+pqDR/iBxfMfjWzDjczAzId6K8OE5PhtrnD8ARVRVWU7lESG2oY+xLkegoZZExtbYssS1Fd3kqFym9SFPpfKvI73/Sexyw1QJRunsN+frCgeL5/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf90yGH2KhTWScfROBIsNVWuIpSfWEJy/OWtRmKMdAc=;
 b=lnZFv7a8beOubY/lYkquEWTW3fAQgbqkDq8t8Sg56CdgHA2Yy4YfKvv+ygLFdul9s9ur4VTCwUkB8I2LLseaMlHfXpl/CkFrZ62lqnK5qYH8t9dxgEBVrYeFugvOlbuWzuPG7DvlqebgA3YUIFK1m2FOL1i4gDU/QWj3JAm4xaU=
Received: from DM5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:3:7b::14) by
 DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Tue, 16 Mar 2021 23:50:12 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::4e) by DM5PR13CA0028.outlook.office365.com
 (2603:10b6:3:7b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend
 Transport; Tue, 16 Mar 2021 23:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Tue, 16 Mar 2021 23:50:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Mar
 2021 18:50:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 16 Mar
 2021 18:50:10 -0500
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 16 Mar 2021 18:50:10 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Date: Tue, 16 Mar 2021 19:49:52 -0400
Message-ID: <20210316234952.254296-1-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3966f2d2-cacb-4dea-440d-08d8e8d63d65
X-MS-TrafficTypeDiagnostic: DM5PR12MB1595:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1595EE527599739E54B69DBFF56B9@DM5PR12MB1595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:196;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IG+9PjIKbAXIBQvtoRC/YwErcmRu3A46ThxVHGjFhrdUsGthEJeutq6EPJeJzEHNOLGfzg1QypYSQgS0KX5uNbEQ+FuaOuC43FyCqvtOVzAVTzuSrbUED7u93YxHhACEoAVbbxGtBu7P93Nv7aaLIOQvWzhvrzVYQ54DNBXWEnRjP1MXp5ljbrkuKaYVv/YcBa4Cy3ljp8bImdIn71lXnCyP9Sgb499CIRkGsHOwLwBMU1X+B4yRbAV4RJBmDqpGYR+8FhPcmBofExhlrZ7JxdsdyEjDePhOUKIPX1SHMdH4LWzvGDCnDvWS+7I2b/XEz6SFKRlv+7BZY5g5/IescpeGYN1Rn4DUuO28TV+/l27aaZPtFm+SZXH+geF81K5FEImCx/iPpQfejvsFqEpzsJw0kPSL3U+KEhRUlYR0iDx5IHoMDaIgGASQqO1DgKcye2uT+a16k3rlGLu7l1/kfMeUBXTBpDFsghuGJf+GYdAofh1dD83orNL8pLVoaK5EBGvB65InMYc3tHbcI3yClEf0sJcd+mNFsS3iWEcw2uEYb2my5MnvbX2VqOKxypMG5sszij6M0iKHrNoJumckQVQZU++0voUlA4qqsaEQC9PH7FsZ48M5uM2VYnNiEbIWkWmbQ90j40lx4ImbEsNPe02ljwFb8YJOA2Ah8lvomGCXVWmml6a7r5mKxsC3K3Yo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(46966006)(36840700001)(356005)(82740400003)(4326008)(186003)(316002)(70586007)(81166007)(6916009)(82310400003)(8676002)(478600001)(336012)(426003)(36756003)(8936002)(54906003)(86362001)(83380400001)(1076003)(6666004)(2906002)(36860700001)(5660300002)(7696005)(47076005)(70206006)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 23:50:12.2597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3966f2d2-cacb-4dea-440d-08d8e8d63d65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
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
Cc: alexander.deucher@amd.com, Bhawanpreet.Lakha@amd.com, tao.zhou1@amd.com,
 kenneth.feng@amd.com, Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
idle optimization was being disabled after commit.

[How]
check vblank count for display off and enable idle optimization based on this count.

Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 553e39f9538c..56a55143ad2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct *work)
 
 	if (vblank_work->enable)
 		dm->active_vblank_irq_count++;
-	else
+	else if(dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
 	dc_allow_idle_optimizations(
@@ -8694,7 +8694,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		WARN_ON(!dc_commit_state(dm->dc, dc_state));
 		mutex_unlock(&dm->dc_lock);
 	}
-
+    /* Allow idle optimization when vblank count is 0 for display off */
+    if (dm->active_vblank_irq_count == 0)
+               dc_allow_idle_optimizations(dm->dc,true);
+			   
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
