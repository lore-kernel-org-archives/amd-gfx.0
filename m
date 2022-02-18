Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F0BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 05:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0C910E162;
	Fri, 18 Feb 2022 05:11:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05FC610EA72
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 05:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5oDF7Pfa7pLYRu4WSgJR9Vq3yZj5W3q8cSN8dr39aaOu7BOnREZrVn5rWoQ0TgHofYIJ0HRmkD4aOnIuEUjW9JbOLg/ek8wBbuSVQMXl7wzNKGG7T3rEK2qWhj+jkR2nw45Pei64jiX6c1bbutFKJZWMq47wjSYrspYoqrKFi+7Lw8Glg0AUzEVNAPbA9LyMY6SlBAC6aDhyyM57grmdIpOROclEB4udNMs/bqmHli/JU8R4bAyOJ53Su6JPVm6cBW7Xviw7T8PV4wP4C0pZfHhQIJmNe8f3gaJDJgQOjQT3dBedT90ZQyCW2s4soLFVnKd95zYLsjog0X5i6mzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REj7+yCNS7AExRYZGV5tJ/3xesZu+Zf2BOtBg2W2P1Y=;
 b=Ijwj/Rn1tPNQf15uCW4O5MYEPlpFLRsYPCQkCtWEaqDEgMt0WXniJEgxwHxk0uiLw6NDaP/KrvS9WwBDqUgPTjbuXNaTdE2hkEbnVMsJ6zKkHYriaHzPoHp//IlLK9Fm9CloFk9KF3l6qoxuUCKt1HoBkgvh4moWid2r/jOBJ0wXw+DIRzxBJjoqNT36ZxMKLqbt6/kqiKt1NO1c17MHkW8U63NVWAXloSnzR/mbxUHnPU4nJZ0V1WRCtdi9YPofxZ+hTWoBGRgwqT+6TjFXSppPPpbuTq7d3HdQfJ7N8LGxMUa9i9AbDTIfIgk1YRYRD+Vx3wxbXga3jbsgCAn/6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REj7+yCNS7AExRYZGV5tJ/3xesZu+Zf2BOtBg2W2P1Y=;
 b=FAucLBPrX03IJ+um4J4EeuD9xRwe2a0+N+2kQpb40S/WKE7vLUIHh/iNIodoHc7wZDGJfbOiaSgvFljdZlc7aWG9GqqbrckOtd30ZTB0nCJUmFcpcE3v2bGvBGO8yMhmnWgcJBd1v40Q5d7xCOKvHAmGKvGqQG+65Q8TxIX0oOE=
Received: from BN9PR03CA0981.namprd03.prod.outlook.com (2603:10b6:408:109::26)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 05:11:51 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ab) by BN9PR03CA0981.outlook.office365.com
 (2603:10b6:408:109::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 05:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 05:11:50 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 17 Feb 2022 23:11:48 -0600
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <Yuliang.Shi@amd.com>, <flora.cui@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH 1/2] Revert "drm/amdgpu: add modifiers in
 amdgpu_vkms_plane_init()"
Date: Fri, 18 Feb 2022 13:11:28 +0800
Message-ID: <20220218051128.19323-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73277db-1e86-4304-54ff-08d9f29d2bd4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5783:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5783996A91FD790E26342A7CF1379@PH7PR12MB5783.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:211;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ae9HXIoDEOnjoFLTCm7wO63sY/wUXFsMCXS1451DaWnbkeMckZjflYrBrCAnXqTzAqk18+pYTJ7sZoUqNwWWix1LnKaWKY0Ew3EfKl1ovJHPibhb1+pfYAzNSipUGWMd3bX6IwrA2eItCNrBPv/SJCIGkbycAnZFv6HlSwvH3rTkqAtrx1m5CwOnobKnmnkZL5qjPs1dkqD+7wVsyYXchCf9/H2UXdQUffNOST7wowBIvKW7GwdRG5pK1XYh4e/YB/EFZ+OjF1CpPAwSHNich/i9hKAcHRElugP9r1Fm1vltTpsqNHEvAs5WL3mUdrfNxBDdrobkKJGbc5pd3hJjJO3BylMYgEC2WC0rGUuX6pK1VJhdN5+AVsK9PDUhkuvszx3a8vkX+qztfcK6Zh9OeWguDWvODCczvmCRwk2EthY3Qv6lwmOSEJi/6HPunhC/EfkSTIhoKr0FFf+m3J+VSHE98Ir4K0LrMYLjl6xfY1ILu7/ijDNh4SjZs9gVqKGFRiXs1+d1txKZIfd19YyLcyWg5cQVD8crT/tU/RehGZX8VYDr/6ulWh9OH+nt8OkxaDG5QWtsz6bXc3ztlCG5RML2q8jCXv9NGMLi3beBL075Zgdpsez5NlghfgWso5YvNCBPGEYQTsGey2rWFiBTHopmeodd0cA1QPc6DLKLrsoPPMe11cBJLbdX0haf2sYZrDjLWFMVtSiGNDB2/TMXt+CcCn26LFTGMU0UbOoFJJQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(186003)(40460700003)(86362001)(2906002)(1076003)(16526019)(36860700001)(26005)(47076005)(5660300002)(426003)(336012)(82310400004)(2616005)(83380400001)(8936002)(44832011)(508600001)(8676002)(4326008)(7696005)(6666004)(6636002)(81166007)(316002)(70586007)(70206006)(110136005)(356005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 05:11:50.7665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73277db-1e86-4304-54ff-08d9f29d2bd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 2f73d74ac4cd880beaa1c19fa9ef0296c3eb3b60.

No need to support modifier in virtual kms, otherwise, in SRIOV
mode, when lanuching X server, set crtc will fail due to mismatch
between primary plane modifier and framebuffer modifier.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index d99c8779b51e..5224d9a39737 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -391,7 +391,6 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 						int index)
 {
 	struct drm_plane *plane;
-	uint64_t modifiers[] = {DRM_FORMAT_MOD_LINEAR, DRM_FORMAT_MOD_INVALID};
 	int ret;
 
 	plane = kzalloc(sizeof(*plane), GFP_KERNEL);
@@ -402,7 +401,7 @@ static struct drm_plane *amdgpu_vkms_plane_init(struct drm_device *dev,
 				       &amdgpu_vkms_plane_funcs,
 				       amdgpu_vkms_formats,
 				       ARRAY_SIZE(amdgpu_vkms_formats),
-				       modifiers, type, NULL);
+				       NULL, type, NULL);
 	if (ret) {
 		kfree(plane);
 		return ERR_PTR(ret);
-- 
2.17.1

