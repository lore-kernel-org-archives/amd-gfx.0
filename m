Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C79C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 22:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD0A410F90C;
	Mon, 20 Jun 2022 22:38:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BDA10F8F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 22:38:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzPNp7RPvmOrxPND181OMhj5Una5UWboR1shGN3HuVIACuwGFwR0EI/OwPvZgvsUheW5o8jy7XdQk/idGsL4Bo+ko/mUDtZn5RMJMnKWuzdPu9CoojmvIzxGsfPNOZN/myDqi7TDXwcKBA0dYogFtqFI0YS8MLoXv9NALCEQr6swrNl1ojTzzg8X+HJdWe69kC2FbBI7ROdhE36EF6mvBylRdKBe4Ew7mnYOH0cIoCOiesUCpzUe6zmHPZ9Ayp1/rCgYp/tDRQQ0E1Kt4ODENaM/WYIJ72bzWAwSZYN8CHcUmmnMkckt1QsNQj4MwYhoMgy06Tz6VTVoFO1pchYPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+Lh6vxPpFmeB1H3wLFohVt/calcI4B4/ChEhMFhx08=;
 b=TkaEyjlcBxDY1JUzzaJ0fAab3Nv0LTVFe+bwCH6DH5JSykQXQ2/spsg5y2ixMYk4MlW2cnaBvaaN1A/4lL1JCU/dDZyjCYECTkyuu/oimqcFaqdJD8sVeOzxt5wq+yTx6oif2yerVxDvktET5vmdSEjFQ5SJ73ZXbcONx0G749/J1GcUfGHD15uHc0LT49h6hhbdp1ZMTg/DcUgg5mztjFNpPI5M8t+M9SzcyNvOtUqtVqDyA9hPbu82a8IWsNwcYO0qXurEVjxndFPvSoFqd7egHrMujpot3sP/vHBrtULHOPDrKHeyUNkMcvr+TZqPA3S/RHHnYbwFEfWbdniBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+Lh6vxPpFmeB1H3wLFohVt/calcI4B4/ChEhMFhx08=;
 b=M75TLCNhA1pkILn2weZYoD9dKhRd1IeTQOL2eAZUH4A3gss4nGxVoevJ1D3uYUtJ0zG4b6ib7r7io5aYYfUweadQEinO4XitbWMF8r7EwqJJf101MJNMPtl3r3iEEKRE69pC3zR+Ob5Z9o+oMLkUvfTsCl1+rsTqksnA8FPbFHI=
Received: from MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27) by
 DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.16; Mon, 20 Jun 2022 22:38:54 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::e7) by MW2PR16CA0014.outlook.office365.com
 (2603:10b6:907::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Mon, 20 Jun 2022 22:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 22:38:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 20 Jun
 2022 17:38:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu/display: set vblank_disable_immediate for
 DC"
Date: Mon, 20 Jun 2022 18:38:35 -0400
Message-ID: <20220620223835.1038109-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1e0aba-3c80-4731-8780-08da530da794
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2472A4FC7FE63F69AC0EE24CF7B09@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l36PBicFNRrM8R2UpzgTrU8v98PnFXTnJHssk306ijT8YmGfZ8VuqgdvfS6HzJaSKHQ+u8C8nwE4dwL7rG/XwJje6DkDU3WdnFOBSGDBRUuE/rvAtFIzx7El7jV84pbKEQDjSY1A9wCXIVxT0nHh75RHl6K3N2b+8J9Z2GlE9xrfEphIccxw3SxOnZ+19abBHxADJ++6SCuhbxowq6xyq1ANiOx9gLp9SfLXGbJLNXsI5xZBmlOBOWN79MBHUWNfCLJyiZaV0lICsZOkDrA/rUntQjki+Nm+/4eNT6e9/CgVd4mIYqKTE6m+1SFm8e62xUCDYADcKqJfyt97h5IfMdaOK0RvM3EWeSLn7GcEgI8FsNDJcz7ScupLTsiyXsmrJieh4RGLL8Z5ln9NJKyyis3bhbUZLYMpX2/w9D3Z3ILGdN/jijMGT5zXQ2Fid1qmW8jyhrShjFf1p+p5oKkOrymakk7QW78uetu5XmiEmkZ2mA87qXbiJl9weVuuEn/pcGbCJuiUD/anpKkoyPHFYzPJKLoJUzDyJBZO3fMqrw8RIINAmiKiipxR47lW1N/IlYGDNx/7Sh96RG1Az5qPURTyjelJY1NECxmAh6TQCaZm2dRd3XxHfgmydVWPI5GJStVPCuixVlgYW9sxwI+eXPC0BNsHvPSKqopxqt9RhaWYgn55EePvp8/2wpU6hODp0VQJAnRhSjWO9PXYoh0YDnvYmHXkDA5hUUmCv3qCe/hqfnOGYHHa6G/WSZ+ppLKWhYa+XdMJxatAYohIX9HNvdsxney0ecGtbsa2Yu4paho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(376002)(39860400002)(346002)(40470700004)(36840700001)(46966006)(426003)(47076005)(40460700003)(16526019)(81166007)(83380400001)(336012)(5660300002)(82740400003)(356005)(82310400005)(6666004)(86362001)(186003)(36860700001)(7696005)(40480700001)(6916009)(966005)(2906002)(478600001)(316002)(2616005)(54906003)(41300700001)(26005)(70206006)(70586007)(36756003)(4326008)(1076003)(8676002)(8936002)(14773001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 22:38:53.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1e0aba-3c80-4731-8780-08da530da794
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 92020e81ddbeac351ea4a19bcf01743f32b9c800.

This causes stuttering and timeouts with DMCUB for some users
so revert it until we understand why and and safely enable it
to save power.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1887
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           | 1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index b4cf8717f554..89011bae7588 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -320,6 +320,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	if (!amdgpu_device_has_dc_support(adev)) {
 		if (!adev->enable_virtual_display)
 			/* Disable vblank IRQs aggressively for power-saving */
+			/* XXX: can this be enabled for DC? */
 			adev_to_drm(adev)->vblank_disable_immediate = true;
 
 		r = drm_vblank_init(adev_to_drm(adev), adev->mode_info.num_crtc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2bc7db85d7e..24959cb85c48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4293,9 +4293,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 	}
 
-	/* Disable vblank IRQs aggressively for power-saving. */
-	adev_to_drm(adev)->vblank_disable_immediate = true;
-
 	/* loops over all connectors on the board */
 	for (i = 0; i < link_cnt; i++) {
 		struct dc_link *link = NULL;
-- 
2.35.3

