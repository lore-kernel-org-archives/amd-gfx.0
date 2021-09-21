Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23504C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F5B61184
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 18:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F5B61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D80E6EAAA;
	Tue, 21 Sep 2021 18:08:21 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 790506EA8F
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 18:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhzJWJvhsYv1f1d8dPaZWDY2VQLt5WwbCtV5LPoktncTzAZLodgcS/ofLX2oNwVycgJuGh99womdaasv3hAlxKeziSGGkYX7EWjPUGqisG69v447ukoN4t8VRwA8rj9WwcRr7ETtY57KEQbOBVu4CBUAHis4NBrNgVgFC1QGJU+ORc0X2VIyCkGPQEV2Jnazqbo2AYeEChtj2ILl+qzy2fl59EYxJrwmdTBmvn5tN0x6I6d6JJTvnC6uBn15y48IuDz3EJtlcgQ8f2akMtwsDwR+V3PgqrX2bUeGC/b35ZWMl5aNna3UUEzCKZ8aOrNVPMELNkt3r7nPaglRIJx5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=T5FJnNqCAOWRk6uyr5X/6bJC12DZWL71mjqh4JMnhRw=;
 b=Nb6TyPnU9XVcZagRfAMifb9Zgb6E1Huz/+4GDsh64bFXOT+pgh/3xfeO7NfNd/pZdPtFaW/TV64jvVukZ3QJ0XYHFjdt9YVWudxcODraXZISMz66g5KkekdUbiW4k89IcCY29WfgCIVnVWoJMlRoy4kZkA9bRO3j0SaRmwO1d2Dr6gpFSRHWEZxtnzAHiUEWKxLPQocwpbV9kzdGmWibKPnIm/FIyUKn7x3NY4z+GEn8hl6hNtcXCmuv1XKhsZM6OZiF7LiAH7846PR+OyLyTLjBjGqTrfAHshFtMvCyWqZqmH+hfnKUxPw+J07gHzl7cDkZqDpbNd3eGUJMp61wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5FJnNqCAOWRk6uyr5X/6bJC12DZWL71mjqh4JMnhRw=;
 b=XZ2TjSlE8OctwOFEImWbdP7SLyVa97N3OMvKgMSN0Dwlf0T9wHSB4dBFsGr9ogd6B3ju0I2l1ibMtS3ZoU7M7CxkpB3lvc/PrXllPEEHXinxCDiGI3W9ULQrc1rDyNZpPSx5LNlGSrHtHQ15vaDcJzJdVpzqbh3CqViMTbCfdh4=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 CY4PR12MB1221.namprd12.prod.outlook.com (2603:10b6:903:3d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Tue, 21 Sep 2021 18:08:04 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::e9) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 18:08:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 18:08:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 21 Sep
 2021 13:08:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 48/66] drm/amdgpu/vcn2.5: convert to IP version checking
Date: Tue, 21 Sep 2021 14:07:07 -0400
Message-ID: <20210921180725.1985552-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921180725.1985552-1-alexander.deucher@amd.com>
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5fb1687-4aa7-4552-0888-08d97d2ac191
X-MS-TrafficTypeDiagnostic: CY4PR12MB1221:
X-Microsoft-Antispam-PRVS: <CY4PR12MB12218448127F7B337805EB1FF7A19@CY4PR12MB1221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuKZIrxq4SKcoKF4MpcgdL91QeqMWZreo77/hTN1WLRCPdz80cnlGaGwjRL+kf5gJ0PuBtn45E+BFA3IdLkhxTcKuflyP+06YPciqmbnUbRAhJWKVaiZ7wnXN1Fe2e4cRNRYAuQq52xmC3M3r3mW42RfC4GNyCuJYrAj1Eve/VK4I5bMsVSNVkUVcQ2yNfxUJaDXB5/q9t9Zw5qIQGcf3cjugEHesFq0ND8fBPs5A3qI5HcboriNrwWv/oW3mqm/GHPg00vBBfGBIlY72JbLybfKoSLhaNyxz7yVk2hN2wwxwhcP74JHEo7oOUz2fsBCkzkKy74IhGHPF0E+x29wf0MguCm6BgU7iox7mhL7G+hRZ5hD0gZ1ItdrWSKzsA2EjcE9APQklpeZtx0PBiaM6BipYYYdiLu2h2P4mskVC2wQWLZ/PWmCaBi0Ob26vQfnvQEkqnvlp4AlsSbwO4BhP4w9EUZGwymbhiEnRYcmC28wB5zpmx1Ub19kF2o9iQjUo7QupR8imligt+D15Ay1nirMyi9/44j3Sxa4pl1aOwliKYJDFa9SffSjDVJwLWmXo92kCsB0y+31GM4YZcKWcvImUJ8YhwZeDCezs2qr9ArdQiCQa10Irzok8w6zRuGixlweRSaGY3H6Tk5u4vAo4RAQGarJEoND7z6snOqYwgjUVJuSOp9rAljBAeydw4afihX4Co2qiv0WP6L5KrSD9adBC56AaTE150/wcfPiR7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(47076005)(70206006)(6916009)(7696005)(426003)(336012)(5660300002)(2616005)(16526019)(8936002)(70586007)(186003)(36860700001)(316002)(83380400001)(26005)(1076003)(86362001)(2906002)(81166007)(36756003)(508600001)(82310400003)(356005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 18:08:03.8382 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fb1687-4aa7-4552-0888-08d97d2ac191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1221
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

