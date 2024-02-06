Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696FCC4829E
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E91710FD8A;
	Tue,  6 Feb 2024 15:59:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2/GMj/9+";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9157310FC5E
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba0VMS7zAITIW5OOO+xS2iJ0KCfAyoLLLfYgN9AxH4wiKc5DiMmJyiPWyJW9X6pwJF3U1IdhaSFg/6DpcKdR9UUvPQ724jcQzSpl4LY5rJZQXHDM8kF2aVmpg2TKzhIoEwgjn5c8ZmLK0h9xGDhZG5IFsExeHxeG+1er8PijDdKt1NcSV1FWTMUSzWvDLJ8qx5CsyDPe6rcQzqZYVa+vMF7CwY8Hw649TpawzIx7exSgebHB0O+rmhT8BGAQ7+UMevRNT5jZhDfoTO/nPVPmH+5S6NmDLI9zvDVfxXmesoH9jslOhUtmUfGH+X4S/fdpQSq1K419Zjcu6OGTrXrh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=LkgXRLTNC99bFM2q1wvlBWKqL+iI2boQGwQ+EecQMJovZyHT15EIDa5nbnVYMJsAYhdiHwaJiKNk4ksVJiT67GEyctiPL5LlfALsNQNjWNFqPLIJIG1KbX4nyWDve60tmBd2x73Qp93ur+hIQrpyL2URvKyLF8p4ePTdUfRMWOOxaKwVKF4wjcRUiPma5WNz7iCPXqiXwizXVN4zIqS1ffi6QM4s02wOGq14vcpKwr9qfAJeiKqKQ+zHjRAh0bVOd5Q3Zt203i7JYxN8SxBuK2vmwsZR6yXZU9bcfUgC3jqJ4hC+5cXxFxtwSHnhGZTlqcRvfW/yfUAOV/agA19REg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJK4WY8oIG1140lsVM0IQoC0LVOQtWE0aloPghpZBMU=;
 b=2/GMj/9+Hz7F+Ig3asXLTi1oDKhgIdHxbFumOLz80CYVkEJsPkop8nniuAn4x6XKP9E4DqluCU+NO5q4F73oxlZrgwIyoRMwod42hv7X+oWoyP4j+11K5gp4r7wgHQnxpsLgMunRXZBoXqtNJAzSnfD94DIaESB81IQif4Oz2vU=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.13; Tue, 6 Feb
 2024 15:59:42 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f4) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:42 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:38 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 15/24] drm/amdkfd: trigger pc sampling trap for aldebaran
Date: Tue, 6 Feb 2024 10:59:11 -0500
Message-ID: <20240206155920.3171418-16-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: b223e9f2-028f-4ef7-ea35-08dc272ca1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkpBorKgLy6bzpHsRivN07VklzO99mFLAcRNmL9GJ4C2mXkpJaRknQ6uHJxhiqHdqoW9EFC7/QKKNwXn0nhUX+h1zJDLswbxXquWuKcWLlzJJFvvB3le/tWW5UtGm6qOeS672Vd9R76B+6A0fIvC8EwwvHP0ee3YKC1tDnT28538VMPJbdefyFuvo1keg9HGY6n/sUcOQ2hiWS8efpYJeuvfXU51sh9kT2uzM65nvM6SuScSTpF5H+RqX59lMjLeR/13KZED6jUOfy9SnIbE6AKo4KJ/xiH9gZ9CNiWqi3odEI5AnQwEzOV7ay160ksr1KtcRSD+t0nbH3GQIPe6Cai0Vgg1LdcGKjMuOnHUFwWtfaU4AhnVZZYIiB8Fl+/mhfuyu7Ub9C6zOb0UpWCIpWGILk8rK9BhDQs0d6BQfZMIJnBPWo6B5qKMhm5JrdbeAvGgKnVkF65GVC2KYRa/CIDQ2IRTj5BBOx/XL1xJqTUTPVQaPX+HxJAQYZ29jZeWND59+U3+nA0i9NhsUenfT6XgL8EYmankOXX9wDjcLvWPX69h7n2JVNjuDAGQgKjgSrnGwLSxMQCFaD/yWWjpzgxIJW5lo77H+NA/C7+l9lpftRI7U9QGCDjPnkg7yH2bR9hWgx6zTynApP9QhzHa45Qn20/rHoJJqG2NV7phPphHOcdnx4Faakgw+Xm5ehNPFxHXXRGp59yWtuqHk1wmnLYxm9v2TI94Npp+wO0mxHg6jb7KEkqsxkLUH01jVAgLrlXe8fprIjKrfTd/m/k2VA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(2906002)(478600001)(5660300002)(316002)(356005)(70586007)(70206006)(2616005)(36756003)(86362001)(8676002)(4326008)(26005)(47076005)(6916009)(7696005)(6666004)(426003)(54906003)(336012)(16526019)(41300700001)(36860700001)(1076003)(81166007)(82740400003)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:42.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b223e9f2-028f-4ef7-ea35-08dc272ca1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
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

Implement trigger pc sampling trap for aldebaran.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index aff08321e976..27eda75ceecb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -163,6 +163,16 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
+static uint32_t kgd_aldebaran_trigger_pc_sample_trap(struct amdgpu_device *adev,
+					    uint32_t vmid,
+					    uint32_t *target_simd,
+					    uint32_t *target_wave_slot,
+					    enum kfd_ioctl_pc_sample_method method)
+{
+	return kgd_gfx_v9_trigger_pc_sample_trap(adev, vmid, 8, 4,
+					target_simd, target_wave_slot, method);
+}
+
 const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -191,4 +201,5 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
+	.trigger_pc_sample_trap = kgd_aldebaran_trigger_pc_sample_trap,
 };
-- 
2.25.1

