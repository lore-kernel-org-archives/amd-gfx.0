Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946A4C47DDB
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Jan 2024 10:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6622710EB3A;
	Sat, 20 Jan 2024 10:19:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5306D10E275
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Jan 2024 10:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4GVGVOx6vHiai5HIQr4Mz3Zh7mbQY0BL+UZwGiB2Hd6MxMJqy0H+P8kqI+Q9J+m2/E7Ec7sy8NczzFpbDSiv7V0F6LyjaiqUdHrakp9MR5fNmWNHGZC1m61DkT8DXMCHYLTiznOeGSBAkcPskTWAkIuBx7FJAJp0mckXH/6rE2tWZoGmNb2LlMAJYWdlymrN6Vd0y7Pycov8SfKCU2350zc6m4AMzwGKilUguXJ+5PIS7Lm7Sjxkhmr+F7uI33PbvpNx9/pkKqecpNDFdIqC4rFERO28BsWY55sa1W+y/LJzJrtRhh8NLo6CRR8sVOJwt6t4Zk99aK33HIjv+tSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3WC+jPf5GXD5sQC78BoWXyl/MJ1uCqk6Uz5vsYSbew=;
 b=NxlFz6i7ssQAgieYXgd0JKCHKzCQ4kmudDqhRzJQUiz3ku70BfZ12r5ojskMNmtPCh5SipjKgKXiBOnacoYXcEI37WlsHH2W3gMjMSvKjpAXHeilF5tkL2fBhfpcS5Q2MsqGOvffxjpopEmvipPQv0VEm5eFL0eje6q4N8MParpNJEuSaITnNl6x4hBF2SyEwz1Wy1pr+Szy9Y2JIj14uk5sgqo6+uV/D1UCSrBe5T7COUgkaafNxrHEeHoEAGCd9BPOmJo1IEBu1FfxhSpKfKttXBwII5R4drGOE4FeABgboMXgoemHk1V2Ddkj68Bqyo0iUCp1gSnGhXW7C8GmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3WC+jPf5GXD5sQC78BoWXyl/MJ1uCqk6Uz5vsYSbew=;
 b=Gv7ToPFZML8Hq+oHrbH0m/a0T24RA+GiyyI71CQuNClOXHcvS1w1YPt/TeUPMuWngVljPuLHbRlcwUfyeqZMJty448rudrv8l6sxZM7vjZH4XqJW42efPBODi2M2Hc4NGiXnCnvQU2m4s4JAlIdqtp3zg31cZkEtTYv+50SlzOA=
Received: from PH0PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:e::21)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Sat, 20 Jan
 2024 10:18:59 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::a7) by PH0PR07CA0046.outlook.office365.com
 (2603:10b6:510:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27 via Frontend
 Transport; Sat, 20 Jan 2024 10:18:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Sat, 20 Jan 2024 10:18:58 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sat, 20 Jan
 2024 04:18:56 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Avoid fetching vram vendor information
Date: Sat, 20 Jan 2024 15:48:40 +0530
Message-ID: <20240120101841.175599-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: a7a194ee-9bde-4659-88d3-08dc19a13730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9RpBAxI8txYKt9M2AMQSWk1YwCOPPf2pfYRUFztzGvWbYdriaOL9NWdxmcGejHQ1GvSHpl56sOOca5YqvCSOo6982u3k6C4ARZVe0rFy0avlv9Qv7gSv995LFpZubBc+dtljaPUo8MXEWANfjRa8AQsJd/BAdBU7EXx16nJvrG2U9KDzmBGXLBfh9OxxE1yAHSf0xu4gmWiqe+ZEcFt8ckq8F14vu1Hp2beqkqj4lBrnVKSu32p9BtpEB+ninCfJVysafzvMBHbO6l/rRjLuJXtJhe4qj48EcFSl77/56OTMxGC1e+PWbl2X/4uV2+Ot314I1ekghiwq/R0L1vpEswak+NKFarqrWjBIivSIZdg72YckNe0tceTKIPE9JnVjFPDJ62aRgX6A0TKqz7Acz9aC9Ip9ez5Ry+Saqqj5Bf5w+pZKP2WZub5Pun3FsK5b2vi1FAoD00A+5OLkZes+3ek0gO5uC3OPHe8I2zYPaz0+ZXCcFpLJn8CKMeLeZsGwIlgxqlbja8n75yZkG2iESFnxlIVo9BgJQ3UnrHM1IPrPFyNaT0cqiF36Y0e9ly2XqXK8SwptVArNIujeSObXESsOZnrAtq7P7NFZ8aRojma0JHmKqIMi0IBjaOK//EfiOZxoF462kxS9/v8I2RthPVPzxwQNxggmHkPoBtprefODIgbdSvmXsspoSw6NYqFNcCSjYC7h5nDtKOV8I9cDJZDJddAwd6OsMlqtKIMj183LtSDgI/W/KK7jw1CaUaa1Alh9ckEnRm1mOMFEem2xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(8936002)(336012)(83380400001)(5660300002)(2616005)(1076003)(426003)(47076005)(4326008)(8676002)(316002)(6916009)(70206006)(70586007)(6666004)(7696005)(478600001)(44832011)(16526019)(26005)(54906003)(81166007)(356005)(82740400003)(4744005)(36756003)(36860700001)(41300700001)(86362001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2024 10:18:58.5499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7a194ee-9bde-4659-88d3-08dc19a13730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For GFX 9.4.3 APUs, the current method of fetching vram vendor
information is not reliable. Avoid fetching the information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 9bff72356a37..a3a11538207b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1952,7 +1952,8 @@ static void gmc_v9_4_3_init_vram_info(struct amdgpu_device *adev)
 	static const u32 regBIF_BIOS_SCRATCH_4 = 0x50;
 	u32 vram_info;
 
-	if (!amdgpu_sriov_vf(adev)) {
+	/* Only for dGPU, vendor informaton is reliable */
+	if (!amdgpu_sriov_vf(adev) && !(adev->flags & AMD_IS_APU)) {
 		vram_info = RREG32(regBIF_BIOS_SCRATCH_4);
 		adev->gmc.vram_vendor = vram_info & 0xF;
 	}
-- 
2.25.1

