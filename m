Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9474C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jun 2022 05:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D24610FC86;
	Mon, 27 Jun 2022 05:04:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A997410FC86
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jun 2022 05:04:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE2dM99R0N4RZJH9gJt6PxW+L7WJq47tusHwxBLWiQ6wB61Bh6XQbv7SKLMhQdUApcrM2ajWvLv4nGAcJlj2zyKus6P+9rtO7D5hUtCuNWphMQ1wkNkqH4Ny2Tj839JwSjbj5eXw1S32A3wuqrB8mtEBKxI3NkOeywnBxFdhcmAxX1s8i661eFAoH/1x62p/hoUYiJzBuga0alkqxv6uQ+CQaOleq2ptNBTSEsfHYP2qPsy/0Pj2XS5IJnscvmGv4VSYKUruFVYqfICVdUo7NSaAP8Ps7N9bK2PwUGPIaT7JQZaY5kpFdrN4psunPRts+Z/o2UENY/jAbiIZnpOJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLqWOYRVPfl7GzVnL03iF3oO5kdptbTDkwZj1bHUbZQ=;
 b=hqh9yBJShsbyA296VJCQ5emvPzDPIdmvauVc+SNK8axliZhwQB47nG5+SN2W8B5LMZFjRc25LMne1vuQlbnhG4BVyr1KEvC9J0c9MMz4dLe/1tTHv2e2sIMFfuMW9UIUSUS+5fgAvNx8qOgvFJT/R0aIzlu6cPhnT3gKEuZpSPS0QDJAxmY+9UZ3hUNJ6AvLL9qXji+8cCJCU9E6SljM4q/G5B2mNAB+jFmtbBiEAj9Fz2/WVE9spYbok18vJoSuo14DKgDfz5OvJK6jwnOR2RgU2TqQqIIggD5UlRLVvZrCMzShAWqXlcICB5NCiGks9qEDaahZs8bJcn5UOOYKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VLqWOYRVPfl7GzVnL03iF3oO5kdptbTDkwZj1bHUbZQ=;
 b=MhGlP1GncaLwfWettda6WzYSMpjgiCjHMnzD2d0xyS/fuEeDR7r9t9/tA+dpQx1VKyEQbIKPcRIXGDr2cJIIK5iqDtYnZs5nbMCOBaDv2ztrCqRGoHhPMekuamZB08doRXE9Ff5tA9tm/p8ZsFfjzg4G3iO+IgDbufBq5xed0NQ=
Received: from MW4PR04CA0038.namprd04.prod.outlook.com (2603:10b6:303:6a::13)
 by DM6PR12MB4812.namprd12.prod.outlook.com (2603:10b6:5:1ff::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 05:04:54 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::f1) by MW4PR04CA0038.outlook.office365.com
 (2603:10b6:303:6a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Mon, 27 Jun 2022 05:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Mon, 27 Jun 2022 05:04:53 +0000
Received: from syl-dev-machine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 27 Jun
 2022 00:02:20 -0500
From: Leslie Shi <Yuliang.Shi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove useless amdgpu_display_freesync_ioctl()
 declaration
Date: Mon, 27 Jun 2022 13:02:06 +0800
Message-ID: <20220627050206.1415724-1-Yuliang.Shi@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc8cc924-3f2b-4a01-ed7c-08da57fa92a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yf60gaweT2KM84+tc2GUV0af7GfMVDntchHPV46VTXWJHDu3p0ucUtzi1UtILeRC3u8BAPK3R6RwfIWPVrYArFUQGafOi9BIsfkurO0oXwc1r2EI19TiVV+4FiBJrzehp1RuPxRKWQK9UWOs3pAsRWZxS2Qgbol83+fEnfHfUFPqMyoSiv2geCMlRnQ56MIYkgaEmEow87qZ/jSk7+Gj7yFbLTXYWkDlHD+MbU0ncF038EqOSqXMkfkoMUodc+kx7QfcnWpJI6wlWWCIvGBR69qbs6JAqt7T4Y+ceh3h2G0en67M1QiURH/cBQ5lfMpR8foiS852AMhqWz0n/Gw9xXPPObbLVSwe63qq1u9Lo+/0+qdJeMogCSV9zyTPTGoAhSiqJNt5h9VzQsGL+3+8dhiWHl15+7vbw6Xsc5ewsBdAdeuBnv7DlWsHhAEDqeMaRGmErloblh1tofkeMz+y1GGcdOlRNgNywFP4IbSVe6iNwZ1oqOYQazAjMncKFzCZYH+aixhssPJ7LdJu9BnvLkEqcrA+YeTLg1gKlMum6n7YAE2yfZm0UEh+3STiY4WoZDNn+LIzED6Q4d/Wty5Zw7Jg56D5gTfrK29ShbW/R96gPDs8sGnschgvirfn0MJZCmw8Zxt273PKQhBHRpptiNuxXb3LTLs+LrZpxgojBfyoixoQ7Ig6vyhxoZkJD1Jg9XuYNZ1xITMfqCKStxYm5xFQomSod4iu8KItzPGoGhM05WqDYijKytYzDavPKRbF52kNLXw8ID7YHoCesbOO9oinLpIlLl7fgijSfgZZV0SW72Ej2Jdj3Y6gZ4uIxI5ilPMLGwOjf6SEpxxEa8lavA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(81166007)(47076005)(54906003)(7696005)(6916009)(5660300002)(6666004)(83380400001)(82740400003)(356005)(36860700001)(426003)(16526019)(186003)(26005)(336012)(4744005)(2906002)(316002)(40460700003)(82310400005)(1076003)(478600001)(70206006)(41300700001)(8936002)(4326008)(8676002)(2616005)(40480700001)(70586007)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2022 05:04:53.8325 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8cc924-3f2b-4a01-ed7c-08da57fa92a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4812
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
Cc: yuliang.shi@amd.com, guchun.chen@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 7b6d83e2b13c..560352f7c317 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -35,8 +35,6 @@
 #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
 #define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi), (h), (r))
 
-int amdgpu_display_freesync_ioctl(struct drm_device *dev, void *data,
-				  struct drm_file *filp);
 void amdgpu_display_update_priority(struct amdgpu_device *adev);
 uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 					  uint64_t bo_flags);
-- 
2.25.1

