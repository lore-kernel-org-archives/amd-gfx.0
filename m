Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D6CC433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D75122AAF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 18:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D75122AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56216EAD0;
	Thu, 10 Dec 2020 18:48:28 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED66C6EACF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 18:48:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hp8rnwbmTl/15PwUVVa9loAEDkEQxzyjhPnCpccwvvIkAz3MV1kV/O9XPMJ2rRKueedXo0xTsGG89s82K03pjmuF8otqLjI2sk1ahY8/+2Zm+sQSyXpYViadVo7EisNr6VypQ6uUdns2bSBmZNdDCKps0LM6qWlUvbzqjFSZwV8vx6zIrDIsqiO6MhpmWMMdVGYNJjnGqzw1Z4K9XCnj9oFhs/9xqMXXrtMPPalK140O3WsM2juFNIpqDe772kEwRmcd18dhrd32OE55ad7fvpMQw4BbphqlNasVF9b5rzaOmXKFw86v6Ix5XZaWcDHpAVNmcuqYzViYKYAmvBiSmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtLjlFsxIF+CQp4VUs+jJ2Vu1kAEPiXJ+7HWjiz5Cs=;
 b=mp2G/eHnxyXFTCipr0SyehPPr+wBAeUcJQoZCE9H6V5BpcviWPjMiixwWGYMb8HiCIOzXLXG8zKwFBYbFEx0jPYLvLtlDETFY24zYsnarcAWjsdQKWzxLm2IM49k0SEoAu3YTZb4JmKM5ilzqyz83xnjHbDVXwKuTncd0tjrJV2beoHwYk8rDizNHJqj0VClzP+2iYNLTTFtl4pHt9ZEXsUzkT6C53XaUkBkDY77pz2pOaYc7O4m8mIBAgoB/iaVc0B+D/zQ98woOQuDl5efz5icN9Vm91nwFDjK95kR09NPLR/uDD9GDVrstcWs83YjEjG+34bdsgIh7AdHGKdsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xtLjlFsxIF+CQp4VUs+jJ2Vu1kAEPiXJ+7HWjiz5Cs=;
 b=QBLIruIKTMlv75lMyJyZyVkDCLJv/oW5ezeH0ybZpmZ7/KXaz8wnYfvi7ne4Fw3LNvRU69HI5I+EVL1iNs3F/cxj5S+I8VxeQfKavLtchyxFc9IAOef6LW0sVyt4JWshNZbepkjV8Hd3w37sv3+C+zOplQ065SE6gTS0JSK8hyk=
Received: from BN6PR2001CA0046.namprd20.prod.outlook.com
 (2603:10b6:405:16::32) by DM6PR12MB4121.namprd12.prod.outlook.com
 (2603:10b6:5:220::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 18:48:26 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::8d) by BN6PR2001CA0046.outlook.office365.com
 (2603:10b6:405:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 10 Dec 2020 18:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Thu, 10 Dec 2020 18:48:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:26 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Dec
 2020 12:48:25 -0600
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Dec 2020 12:48:25 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd/display: Add module parameter for freesync
 video mode
Date: Thu, 10 Dec 2020 13:48:21 -0500
Message-ID: <20201210184823.285415-2-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210184823.285415-1-aurabindo.pillai@amd.com>
References: <20201210184823.285415-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44504163-4fff-44f5-a09f-08d89d3c2dce
X-MS-TrafficTypeDiagnostic: DM6PR12MB4121:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4121B25476224CA7AB9B67858BCB0@DM6PR12MB4121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpZF//PtcB0VLHq1XFQ/Eh0z+WGp3bhUR+fJqt2Lq3kIGCJsFc1E5XwuUclt8aeEw+E0Td0b1lqfxrpjb/dmPzgya+7U4L+l42Tva47pUv5cBysk8zIJ9gGPUDSSfKDMDyB0pkLczUf0AKb4WGi61M6PEr6Kirn1wLxjqfziazkPvAxFSjOpycB0/gzuUtv7+8m9ZGTJN/O/GF4iFSt6i1K32SXOkRuiWL1DULVcdY+5ieDcmgM+giRFpJVQSa9EPJEnPYUKaex4E4T5jg2VcUzcXd5rLC9H9ZUqT6L39kocy68GqWgUyij5KjBjy/74/41SrugmZZWRmNLc1qt2q3wiMRwNQaNy4ER8ALYy0YBxXYcy9aQR1J2oEM2ar/La9MxssE+Szoa0aJyA6bWgwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(46966005)(8676002)(70206006)(6666004)(508600001)(356005)(186003)(70586007)(81166007)(1076003)(26005)(2906002)(86362001)(6916009)(5660300002)(47076004)(7696005)(36756003)(4326008)(2616005)(83380400001)(44832011)(336012)(8936002)(426003)(82310400003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 18:48:26.4590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44504163-4fff-44f5-a09f-08d89d3c2dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4121
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
Cc: stylon.wang@amd.com, shashank.sharma@amd.com, thong.thai@amd.com,
 aurabindo.pillai@amd.com, wayne.lin@amd.com, alexander.deucher@amd.com,
 Harry.Wentland@amd.com, nicholas.kazlauskas@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Adds a module parameter to enable experimental freesync video mode modeset
optimization. Enabling this mode allows the driver to skip a full modeset when
freesync compatible modes are requested by the userspace. This paramters also
adds some standard modes based on the connected monitor's VRR range.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 83ac06a3ec05..efbfee93c359 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -177,6 +177,7 @@ extern int amdgpu_gpu_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern uint amdgpu_dc_feature_mask;
+extern uint amdgpu_exp_freesync_vid_mode;
 extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dm_abm_level;
 extern struct amdgpu_mgpu_info mgpu_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b2a1dd7581bf..ece51ecd53d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -158,6 +158,7 @@ int amdgpu_mes;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz;
+uint amdgpu_exp_freesync_vid_mode;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 
@@ -786,6 +787,17 @@ module_param_named(abmlevel, amdgpu_dm_abm_level, uint, 0444);
 MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 = auto, 0 = off (default), 1 = on)");
 module_param_named(tmz, amdgpu_tmz, int, 0444);
 
+/**
+ * DOC: experimental_freesync_video (uint)
+ * Enabled the optimization to adjust front porch timing to achieve seamless mode change experience
+ * when setting a freesync supported mode for which full modeset is not needed.
+ * The default value: 0 (off).
+ */
+MODULE_PARM_DESC(
+	experimental_freesync_video,
+	"Enable freesync modesetting optimization feature (0 = off (default), 1 = on)");
+module_param_named(experimental_freesync_video, amdgpu_exp_freesync_vid_mode, uint, 0444);
+
 /**
  * DOC: reset_method (int)
  * GPU reset method (-1 = auto (default), 0 = legacy, 1 = mode0, 2 = mode1, 3 = mode2, 4 = baco)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
