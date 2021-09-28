Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0968AC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C976F6101E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 16:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C976F6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64FF16E8E3;
	Tue, 28 Sep 2021 16:45:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71C9E6E8E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 16:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYOLekPfn5hs0eLF5mBybLFhWyrMLlapN7+qjd/PphoXoz7P/Q6qXFwE9zsuCtZGZ6XpBEjrjI5Grn9iLWj0zX/0lk90K+IvG4gdpNX5Ym4JbwGuN4uzXYx8u4N32KMLn9tdQiccmaNOjK7stgrGshxaVVKCpjT/Z/Ca5AMx501dk3yS5utqss8747LDu6MMibhxEcehmKygGToRA4COMiqNrUWfQP2+CIyjVBfvYiTxUbXYyfSKx4AxI0szKH5gnaYx4HTuu6mrJ34tmZEjD6TlWwZvvZV2IT7lH5JeGcyv6PD2t9CCrWrhKORcMaDBI++cyoz71NhLhpBtdzPxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hjfHIYicjPKFHfcoPWt1VW3oOSWjoPDP6Q/x1FAv44I=;
 b=npMokLvQ8B8QeFZH6dXBp+6tIQdO9A0qGWrOu5FJOMJZQDhIpw2sulkwF5owJq963VRdZLAtEuOOWRV0L+oQN/3D+s3K2wVxjPPUOi8jF2+GfyT1R/QXy46KmxPzSSjGlPJw7YnNQ7nbHpnjvrW1NB2CRMVT0DwWYQI6992bVEdSvC+XfPlWb6i2481La1C9c+N3FhBfb8ff6r+HldTqLCQLp3Pv/pQaASWk1fnu/jLAoXbknQB1hXmkCv2FFVFE75Q6LB5g1fDzUYxyoZIl2ujPQD1nKIk07L9FgD9uZcwN9cCqhzYyboKNyBOBiOj/6GJHyh4a9g7rDBUS3qNWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjfHIYicjPKFHfcoPWt1VW3oOSWjoPDP6Q/x1FAv44I=;
 b=fItJHO7i3I9PdAqyKoSOUlIfCWzXTlMQg3oPQ8tIrvgedNEGPZL042diBIhLZ4ODh4PPodcKgHwb2mId7VEuBVWDsgtOQegoZjGKd9U9JpDNnhl6jAbXNkBPc1kWetHpGa0n1Rsp/+zsyQ7dEWr2iludyKPas+cLjtf6IrS+RvI=
Received: from DM5PR06CA0071.namprd06.prod.outlook.com (2603:10b6:3:37::33) by
 DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.13; Tue, 28 Sep 2021 16:45:50 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::19) by DM5PR06CA0071.outlook.office365.com
 (2603:10b6:3:37::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 28 Sep 2021 16:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 16:45:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 11:45:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 47/64] drm/amdgpu/vcn2.5: convert to IP version checking
Date: Tue, 28 Sep 2021 12:42:20 -0400
Message-ID: <20210928164237.833132-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210928164237.833132-1-alexander.deucher@amd.com>
References: <20210928164237.833132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bfc2c936-9de8-4704-fe0e-08d9829f6d77
X-MS-TrafficTypeDiagnostic: DM6PR12MB4107:
X-Microsoft-Antispam-PRVS: <DM6PR12MB41071D25B957759F354A9939F7A89@DM6PR12MB4107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: laF7KUxUh9vhG4/nlJBpyk9zIXl1zeghf9fQJqgC+/VpZQv7XQj+z8OjNF0+E7gKJ6OYjZWZfrO4aTr6dR+h1qRWXcd0fjqgf5Efj7M4LDW8ifya8XSbdh6GHSMnoveJAwIQwLj35vfHnh3HGUSW+fJVaw91zSgfpXQrS2PlUwMVoeAJisLnNbHsLfVUdP0GXc35RXAmbr2YsskXgpFfMkOCUd9zD6kPCiaWI/YzaPLwH7dP57/g9FE54quaU85Od5pYvW3gqu5Zb5vcyK/MsH2hLJTgDLaJn5IxICkkft17HJcbP62P2TN9bnWr7BjpwGra8txHfGMaX/Q4FqYDZDo1WDjMA6Q6inGbRtrmsnv8JEp+3HtMFGI3WepKBGZgMrs1+KVVTFBNdff9NoMrTTUVAyuzwZ1CtYhZt39Yr1ry1jtf0ZqLbLQjqekEOH8TwRSmbrr7XFnD7YJyZlYy1qtTzU9YSTdkLbu6knQTQaIFTkaNB6qYiUg6HrcWPKj5x4EZUpZSu6qpkyVRjWtOVJnY8a/hY+7m11pbsXezfW9N1Hd/a1gbjRbxSp5aoNrbKoCUBUmdbhe55lxkDhaQJf3BQvBlVxcpwQfitzfYdHod++Rk64X7Ff7uOUygcmV1fGODiODM4dpA+i0xrSEK+aQ/oyd0BVWf1x9xcXnJiPWzTDid0LguhAAMEcSC70G4xHp8VjiMpYKbBlx2K7dvRGNsUDHKvAwP7ao/XizMbv0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(82310400003)(2616005)(70586007)(316002)(4326008)(1076003)(47076005)(86362001)(2906002)(8676002)(8936002)(70206006)(508600001)(36756003)(83380400001)(6916009)(6666004)(36860700001)(26005)(356005)(81166007)(426003)(7696005)(16526019)(186003)(5660300002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 16:45:49.6817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfc2c936-9de8-4704-fe0e-08d9829f6d77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
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

Use IP versions rather than asic_type to differentiate
IP version specific features.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 1780ad1eacd6..b76d96559029 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1720,7 +1720,7 @@ static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		if (adev->asic_type == CHIP_ARCTURUS)
+		if (adev->ip_versions[UVD_HWIP] == IP_VERSION(2, 5, 0))
 			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
 		else /* CHIP_ALDEBARAN */
 			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_6_dec_ring_vm_funcs;
@@ -1737,7 +1737,7 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			if (adev->asic_type == CHIP_ARCTURUS)
+			if (adev->ip_versions[UVD_HWIP] == IP_VERSION(2, 5, 0))
 				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
 			else /* CHIP_ALDEBARAN */
 				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_6_enc_ring_vm_funcs;
-- 
2.31.1

