Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD11C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 01:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8B6010E31E;
	Tue,  9 May 2023 01:28:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CBC810E31E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 01:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l//dw9ewZHZg6nCWXuFG4n/w/Uw5Gb5ZaMPrGi1x0MUNBjdzMUvWGnhceeaXfXBsBB4wjwow9FD9BbH89FTwXym5o9p8wsz4FHVikkiSHGJ13GCxPwHtIdyJFiDPtrqHdigQ2N1hRKRtNsN0KhYWDLjSWgrfhYEmtwCoQyCvWADYl2jQWZpfPPpeEhJBJoGR8AKlv6jx2vPRiIxXOATBzOeY9+ns2l8GU2tyskSN12XUcfZDFSpe5PJNtjzP5kNH+NNT4gUuSLDYuKBrjXP8Ch2F4gD3PKP2ArrSG9/spp+fdghIoTQfnWGI/ZL3i9Fb5SMCEDqs11ipWAV1wKknIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SWn9zh6Pqx81xXMMkzRorbs/FSrWof1s8B2D09EZE8=;
 b=fwD0ykbzf6R5IZcGvzhpIHxoo4vo9H/zSWkVyQzbokJv1/1GyU6rUzPNZ1hhnywkCBH1936LOB/avDmF3btNRNf38Vekkys/qAXqEHXBeXQOR+N7FkueHuOo04ImFaU/IApssISqkfFyZvL8l7CimVwLvh1AMJ1BGgFn53HmhdYUKXKLuQofuOJJo1aYUMzoFWAHh1sPOGobz4wvme5b/n4PRXVVfg37i8WD9rEateIOIc3jUBX8yauQibOUUC4NMVR01//D7b3naWTf8HWSaynrD96+9JXQ9HOLfBeXE9XiVGfh5pjOv+YEF04SfVzkmhIaTtrf4C9kZPJbnhLyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SWn9zh6Pqx81xXMMkzRorbs/FSrWof1s8B2D09EZE8=;
 b=HYAh+Y06gRdzMaSpA52JHGw3HrMcKCZow15mN0Xb6lymFlwLrqMOnBYOkqa6jjlogXQRd1bLeTYod9wd9aTjDi8lFQ8IK/VsTCl2vkWp1HLpswMOsccU4CDowLxTwneaKzTQIur8njLbdoOb4P3ouZB+XIhrhcN+YiTvgTlCd/M=
Received: from MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14)
 by MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 01:28:21 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::ce) by MN2PR15CA0045.outlook.office365.com
 (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Tue, 9 May 2023 01:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 01:28:21 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 8 May 2023 20:28:16 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <christian.koenig@amd.com>, <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu/gfx: disable gfx9 cp_ecc_error_irq only when
 enabling legacy gfx ras
Date: Tue, 9 May 2023 09:28:03 +0800
Message-ID: <20230509012803.2096152-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1e1bc3-4865-4ee8-7509-08db502cacfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhBkRBtGDMraBW69M5cruAnPU5hPRV8yrpwLtU7DFtOFn0Ukyr1wvtYcB61LMS15PpMlOqdoYt8OikqYS6K1Ik/EHHMFAaARtbvUyh6QjhXIStfnaj/1lu3U8N7vD3gCPrF8NP+aRpojZnD7kJOXuyjxpBFBpswIGXjMnZLs6Jtx6iZHPnCr6IGmEI5U99zamMfdUzxpSRMLx7XJhDrQQRR+ylb8krlkoDPtapugFP68IsGNW8gu/MzJuGK53xG7C1CfHC7nhwbUaBwmxw8/W5HC/JH205IJUS3IGuR+IgPBAR8VcDTUzdC+ydzFB/swQ0OK01K+GvzMMD2Vcur0BBkC0eC88ynnOXhKcFxGc96zqLbf5sMbPnjVHFzQ90yd0Wrg5dNs91GlYvORiS2XDZRvwjG9kE1GQySAAJDhjL9OAu4XqC3yZo6aD8Ci7eeo1KlK6zyoaNj1Ikr8//nbej1rxVkoOhTwQW9B3rcHzqPxh6MBLV1Wyy8d3EKkJictURqpqPxgF5FYGHoxZK1TKwBo6RE4LW2l4SNYvN15qrr/jWukW+5hhbROkzHFSIZcNkLPraHpwF389p7RzvvPl5lQGjfE5dZfAoAHurfkquPW5uobkJ7OYks1x3Ez+J9QvTFwJUvsAUYm2KVob/7UODWNotWyLU4lClohh8TmYkQacKXYqeSyLAvMLL1pyi20IGGfoGetsJVK3VwJvjxHLw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(966005)(40460700003)(44832011)(2906002)(40480700001)(316002)(5660300002)(8936002)(86362001)(8676002)(70586007)(81166007)(70206006)(356005)(6636002)(4326008)(41300700001)(82740400003)(82310400005)(426003)(47076005)(336012)(83380400001)(186003)(26005)(16526019)(1076003)(478600001)(7696005)(6666004)(110136005)(2616005)(54906003)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 01:28:21.3194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1e1bc3-4865-4ee8-7509-08db502cacfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gfx9 cp_ecc_error_irq is only enabled when legacy gfx ras is assert.
So in gfx_v9_0_hw_fini, interrupt disablement for cp_ecc_error_irq
should be executed under such condition, otherwise, an amdgpu_irq_put
calltrace will occur.

[ 7283.170322] RIP: 0010:amdgpu_irq_put+0x45/0x70 [amdgpu]
[ 7283.170964] RSP: 0018:ffff9a5fc3967d00 EFLAGS: 00010246
[ 7283.170967] RAX: ffff98d88afd3040 RBX: ffff98d89da20000 RCX: 0000000000000000
[ 7283.170969] RDX: 0000000000000000 RSI: ffff98d89da2bef8 RDI: ffff98d89da20000
[ 7283.170971] RBP: ffff98d89da20000 R08: ffff98d89da2ca18 R09: 0000000000000006
[ 7283.170973] R10: ffffd5764243c008 R11: 0000000000000000 R12: 0000000000001050
[ 7283.170975] R13: ffff98d89da38978 R14: ffffffff999ae15a R15: ffff98d880130105
[ 7283.170978] FS:  0000000000000000(0000) GS:ffff98d996f00000(0000) knlGS:0000000000000000
[ 7283.170981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7283.170983] CR2: 00000000f7a9d178 CR3: 00000001c42ea000 CR4: 00000000003506e0
[ 7283.170986] Call Trace:
[ 7283.170988]  <TASK>
[ 7283.170989]  gfx_v9_0_hw_fini+0x1c/0x6d0 [amdgpu]
[ 7283.171655]  amdgpu_device_ip_suspend_phase2+0x101/0x1a0 [amdgpu]
[ 7283.172245]  amdgpu_device_suspend+0x103/0x180 [amdgpu]
[ 7283.172823]  amdgpu_pmops_freeze+0x21/0x60 [amdgpu]
[ 7283.173412]  pci_pm_freeze+0x54/0xc0
[ 7283.173419]  ? __pfx_pci_pm_freeze+0x10/0x10
[ 7283.173425]  dpm_run_callback+0x98/0x200
[ 7283.173430]  __device_suspend+0x164/0x5f0

v2: drop gfx11 as it's fixed in a different solution by retiring cp_ecc_irq funcs(Hawking)

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index ae09fc1cfe6b..c54d05bdc2d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3751,7 +3751,8 @@ static int gfx_v9_0_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
+	if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		amdgpu_irq_put(adev, &adev->gfx.cp_ecc_error_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
-- 
2.25.1

