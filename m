Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE1FC001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 20:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278C10E5FF;
	Thu, 10 Aug 2023 20:48:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A62310E5FF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 20:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOQUjflzPGXwvb0BkkiG3b+iAYkeapLBZ7kOVu6k0O2LUM6yBivMAsdDI430vRpedHQ+lpv27hJBNIsncFqwPZ7xod0WBwrkSZwy5ez6lPjiY5FLRyEc4HX2NCo8c8lPb/WoGFUSMbJVLidG0XRikUfspk/1fz0mCaEUFNX7DA2kYKYms0bMlVmt2UM4QnwDAj3IKGAWHekXIi/JdCg4TGr6aY5jHzr90mCLkg2fPGhpexYu26JSTpTNotk0TVAPiU+11pxwAm7k1523AImciKilZ+DPFQAv3Lhka34XEBZqxcQSSY6AnjXSVSud+srllMjZbYnQoFtBwBSNH6WUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDNFHpgbwd07Ec3vGgND0dDaYTlR2YFDQLNllSwucu0=;
 b=kG0H8+U2cifHuKg1UGYhgvUzsfHpM/cBJ75FS5ctmQwOkfh3NHh4hERhMcC6cELubPkyRDSneG8JuZCI1y/hxffgqpxNBr/xHm2EhFVQepb5ArIFssgp48yF5T54p+rvXnHMM64SpjV02kcwoj3s6nEb1Hic8DdmFwagRKeR5DnugRTtwXxixXgSIwkRLcHZTEnT/9w50iK+aBrsRk+Pj9e4GWvoJG8bbA6EShUkHIVVVM0VYr7ivLTms2aSwCfn/hpkHxMFbrCYsWex+H8ygNcVGFsVClrxgTySisiTCi4uuhA3vNob0Dt/Dh9cZaPNgVyD1YkjPwwMDxZbVxMK2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDNFHpgbwd07Ec3vGgND0dDaYTlR2YFDQLNllSwucu0=;
 b=md+7r5rmioUJDbP071QLpfCzZpEM3ALY0163p/XtIW5HHeMPNSskHa8YpZaRzntaE6VH4LwfogWzM3/UELjLCKumeji7k0//DTIk0mMMetY72GJi29a8Vdd67ZDWEtT9RC4H3nJp39iBTZsWcCMzbqPn01F00y6/JXZ9HKJm7Wk=
Received: from MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::26)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 20:48:09 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::c1) by MW4P220CA0021.outlook.office365.com
 (2603:10b6:303:115::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28 via Frontend
 Transport; Thu, 10 Aug 2023 20:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 20:48:09 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 15:48:08 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: fix address watch clearing bug for gfx v9.4.2
Date: Thu, 10 Aug 2023 16:47:44 -0400
Message-ID: <20230810204744.195416-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 085a8dd6-ee19-41f3-c4f8-08db99e31b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qG76PhpeKqsh3AF2aAjX3RCEm7VQSTz0BESaZpc9ZyAgJK4GeISNJALLdGot44f+/M5ENPuxk0MufsShyxl3sJveLI9dSIiUlCqZcje/gRP7Bg7QBMCDkv0BbS3JxUY8X00wCBzvbALJrN+z8b1lUdxG3HbpW3mXKvJ5sXEd0+HFvcBJCN9Ru+adYivBX+FLBaQ0oGqVXArlVL70jeObMLPuHzjnCV8C1aJ4jG/zBexbqS/ccQLleBfyfd/z4GOCLYl8w8eINJ2n1bsXBO3NVWEbvKzvGctxg8BWD/eOEo0zbNZsE/D7LA85iwcTehVE1uEjfM6ecXkeyQ73nwK/QrjZbORagHqJ3Ce+Ahmkm/Nm0XXTqLeDzC8GaOBM/h7GYobuc89yPv8IWlEP90i3wD5sGv2LxQyQ7KnCfvkeprHUTJDy4dEjHMH1zVgbpfwlv8LXwVuvicz3XNSf/J+whpPxaA8rg/pUCSfYYzn7bdwqHQw6qv415z5zsliXn/O7k1yVpSU27y3g3O3HGcZVgvOBXQEeybFSCV6uk9NVqaf+PFhVqp7DO0RjV9QcoA9IzdxjwA66gxT/DE0IpFHveLt+kBt/x6opaUmPWfwk9R0L+nMkc0i6VX7BeIbCcmHNlIsHEvgYB8TVvfY56ZfMyanZa64fB5nAKKhzi3qrLLdwtqNijHpImmxskRR+U3AuQ1Exw5puaQOTQ5ohvEnJKtAP1trGisZo+OGbTpp7I4sVWnGidapgHRrDr+mjqki/YPcE1GKokVY8kgedfz2vDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(40470700004)(36840700001)(46966006)(26005)(1076003)(8936002)(8676002)(41300700001)(40460700003)(36860700001)(36756003)(47076005)(426003)(2906002)(83380400001)(2616005)(356005)(81166007)(82740400003)(86362001)(16526019)(336012)(40480700001)(4326008)(54906003)(70586007)(6916009)(70206006)(6666004)(478600001)(7696005)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 20:48:09.4956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 085a8dd6-ee19-41f3-c4f8-08db99e31b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

KFD currently relies on MEC FW to clear tcp watch control
register by sending MAP_PROCESS packet with 0 of field
tcp_watch_cntl to HWS, but if the queue is suspended, the
packet will not be sent and the previous value will be
left on the register, that will affect the following apps.
So the solution is to clear the register as gfx v9 in KFD.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index e2fed6edbdd0..aff08321e976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -163,12 +163,6 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
-static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
-						      uint32_t watch_id)
-{
-	return 0;
-}
-
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -193,7 +187,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.set_wave_launch_trap_override = kgd_aldebaran_set_wave_launch_trap_override,
 	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
 	.set_address_watch = kgd_gfx_aldebaran_set_address_watch,
-	.clear_address_watch = kgd_gfx_aldebaran_clear_address_watch,
+	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
-- 
2.34.1

