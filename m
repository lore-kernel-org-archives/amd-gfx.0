Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C44C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CB310EFF2;
	Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 550FC10EFEE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=milHjtjjBDXp4f1JC+h1AfUUHakAak1qmALXNWETzVBBXkM7vBv34K6yqyJZGA5nYqB94ddETtDuxAUxoNVxwES57bxoiQw3/ULpdBxbrFlYitevwHP8ymCXScjESlVwKu9tv0CCRQLMrBT8N6QdzT5qDXVpDUTRrGsMg+hlcjRhX2CqdSxeJ6nsVWFn9rkTZ/e/se3xWUfnK6rydu6LP5ymW3NfoLfGWqJcM7KNQY8YElC/kpQUpiCXIJH83m+i4Wetb14GS+vZYlg/WOMaXoGES1JL7vbDXvxcP4rwRcv0x/5j9hu93eR2up1UnEoP/jjP4q06CyGXBSUiHX/dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NcRkQHzbRkJWrca5GmlSlWdbJUmofQHw8yGcJA19I4E=;
 b=BOtvlBX1HeRrhXrE52Gng7jY9nKcY75tCWhIVawRADxzW4Raqu3SXvjmy3gbCTUgNarhJfg003YMxEsBhccB5GHnSSJlF7yjHCZMce83UXM4ylgM9JJAWF8n0Su3QL9bsv7VlKkTDP7XXrLbr49Ymq00DJcE9VtetsEH3wrhHnPhkaDJNF2zjtS9Cw/3uoleUtKLGevxDCOYWgsBa8XmnBkIoRc6Xe3Yzl6FoWrXon/VSVe4dNDI29VdaxQwfqIHPW3Pf64Vi6yo013Ns+BtqFq6zrBBoz4ltgHgCL2gv8R1yI5ZcGZeFUcKRYeC8enIW2W9+0uuggS8T5CpvfZuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NcRkQHzbRkJWrca5GmlSlWdbJUmofQHw8yGcJA19I4E=;
 b=vIVNdKMfUmLW0k/GegPl7N9OOOZ5SGTcick04L5YbiUCn6POad8xvqwkagAipHXm9Iypy6RDc6z4ujKZO9RMHsNM67uyShjvC74BVoe0UZHXmAaqZ1NUAYlmyHfo66K6MqyTdXMWqlEl5+BGsEQrwiAsHH9yD1YgktYAn+BaCZU=
Received: from DM6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:5:80::39) by
 DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Thu, 30 Mar 2023 19:42:55 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::82) by DM6PR08CA0026.outlook.office365.com
 (2603:10b6:5:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/23] drm/amdgpu: Fix GFX v9.4.3 EOP buffer allocation
Date: Thu, 30 Mar 2023 15:42:26 -0400
Message-ID: <20230330194234.1135527-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdc546c-43af-45ac-6f10-08db3156f535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSPcICZjc7T5Fy4s0tMr3GCRChQW6QotsvZZMX3sqRoUnMBUVbQZNoriMTpLQVS4w1cJRayVLczIIx5F3KsO/Qd0t3paTPJKpvYHV+EwDxnVRs421qHJdujWTuWQfRLE/LyN+qQi0/kxgBwC634CNiT6f4WDvoMRgwQuRGcidKccoH3p1fNNiGS67PClodMqs8yEdgsCmVUUzhVAxsfZ0ekmmtReHtzlWxjsTj11dxjdHl6E7+illAaShz11k2A/J5o7yAVoLun75NXAkdhKjrkCzsQ+rdthpSgaJu18VCbcEJsgN+Am+4sp7MTv7zB19eVdnvKpUqf04GjQFO2pV4fm+/CSjRlY1kXLciLUIkUF8CTfHsHMxJjM34miFHfKFSJEhDZX37KxhjXSdChCbRrmEUaXLJ9aSkwqdp8XZ8GPUBQMi/YrJjrtvRXqEXhkL+cXg/rujjeLWeuDJzLvlZpVXokdqdRJb7JyjKNzjnFqEYRcJAp/8fpJU1KSOovKZWFcPpvtgc0KufaYeE0A32K7cssGcv3OdyM7C4eOFAPdpV5vbY2+hhM0aDGGnYYFqjN04sfLpCRHXTSiRHMywipMlDpqjNpmAgs6OqZrcQC0WryrJJbRrg2kmP2Y52+ocB6iJaol+ovzaLeQ6FXJJ1SlJOiKtW2ikYIjWwmRMJ/rTqu/di7pCMb511cdPW5ZI8OFV6aZHUveP4MV3ZAT3QN1xQANEMC138BgRpNkF1U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(356005)(426003)(81166007)(2906002)(47076005)(336012)(2616005)(82310400005)(16526019)(86362001)(186003)(40480700001)(1076003)(36860700001)(8936002)(478600001)(26005)(316002)(54906003)(6666004)(70586007)(5660300002)(70206006)(41300700001)(4326008)(7696005)(36756003)(40460700003)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:55.3144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdc546c-43af-45ac-6f10-08db3156f535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Asad Kamal <asad.kamal@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Each compute cluster gets 8 compute queues in GFX v9.4.3. Fix the EOP
buffer allocation so that compute queue on every XCC gets a unique
address.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Tested-and-Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9ea8d4f268c7..f899f3f1f51d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -460,7 +460,8 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 
 	/* take ownership of the relevant compute queues */
 	amdgpu_gfx_compute_queue_acquire(adev);
-	mec_hpd_size = adev->gfx.num_compute_rings * GFX9_MEC_HPD_SIZE;
+	mec_hpd_size =
+		adev->gfx.num_compute_rings * num_xcc * GFX9_MEC_HPD_SIZE;
 	if (mec_hpd_size) {
 		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
 					      AMDGPU_GEM_DOMAIN_VRAM,
-- 
2.39.2

