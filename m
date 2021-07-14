Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45EAC11F66
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 09:32:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8460D6120A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 09:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8460D6120A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B29A16E1E8;
	Wed, 14 Jul 2021 09:32:45 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5E189F97
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 09:32:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdpnFJ+brm1BH4XBAxwQ1y4MklvWaWQHR4Dj2AYHYUFJPmngFfHD3xD79I6wmcLRSb/o3D4CgS5bDf6mOol3e47blM0pAofhwOiTh/304zIMvsp4G5ggHRPjxX1XGctcZrHCQpzvDsBvybMsOrflcDMO44F5iP7gi1j442+LRdQAOEypvns35O+FQJSKTF85FCJ07NpGfiWPBEs46uD8YxPaqrtTlMS+0ZLLo6SeQYIb7WYTFtX6fVYuz0CqBYXoHuRE/CYR/HOHIAnPfIATsNEopoN+wnaOJVf2PWUlodz/WVEMmfQ8mEdWPoxmmSaJOE2tX6S8MUz3bcOqEuHs1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPGfLc64NT/7qwcggzA45pOk9AYW22Zf38S4Oe7mvfA=;
 b=GztMRL4nQgo97sXpKIccKmhuYqxQkO7yoydW4aUSYpeei49yImHRq2K6P0gSQae++tdCO3W1mRE9fBqcIdHYj57BbebwbEfdWtwG78E0NNzRGpspUUiQrqtpEa22QgnVDO+YFPgWuDUsfw/gL7io8h2oLxl/qvJ38JgKB9Bm6x8KxWowd8am5WbAgCnDhI5NdddfQKlD6Xmn6xatE4GCNIt7v5K1/9RnXK63fRBKKGcmXVG/YaBhbARZOx9mapd5ZjLnhydmLlc2xx9DkZBBqWDwbxrErE+Shj1lCjpD664TK6HxuVlUdqNu6pEah4Z7f2ua81PRU7TRUs46BqyiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPGfLc64NT/7qwcggzA45pOk9AYW22Zf38S4Oe7mvfA=;
 b=dbPglYgMA2RKpaf9SLxw86mZ+1MTjX4WN2OZ8eLx3baRyHBS99lUk00MwCQIaY7683BVNpgHh0g9hLoRz74I/egVF2bL8lZVlehujeZzBza+n6QJdrlCf6uDPZSc/shiPs0WtoomcwXmvMUUP9NMrNN51Sxmku76EEvqeDTRgXk=
Received: from DM3PR14CA0141.namprd14.prod.outlook.com (2603:10b6:0:53::25) by
 DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.21; Wed, 14 Jul 2021 09:32:42 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::65) by DM3PR14CA0141.outlook.office365.com
 (2603:10b6:0:53::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 09:32:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 09:32:41 +0000
Received: from jenkins-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 14 Jul 2021 04:32:40 -0500
From: Xiaojian Du <Xiaojian.Du@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update the golden setting for vangogh
Date: Wed, 14 Jul 2021 17:32:03 +0800
Message-ID: <20210714093203.9191-1-Xiaojian.Du@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77bcd624-a77f-4398-1ea4-08d946aa5430
X-MS-TrafficTypeDiagnostic: DM4PR12MB5373:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5373C8F6398FEFFAF59BD1F2F1139@DM4PR12MB5373.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1X/gfR/xjn20P+WEYcjzx//bQqA6P8C6y1N7o9msmD7B3I0oMGnPiDn+n1+XNj7h1Wl7GSX1WFmyBgLcx7TMHv1UrFMEJGLCoDMI6gjXZk7T8g+WAr4I2DQ75lhdRyhjUDNPHu/dn1XKoHIvpMZfg6fo8kmXDa3uGT4Wij+hyNHbDge4vGcYfeTLskG13jLG5v9lcnfWw2zHPNysnye4YWpZfx3gFjtOO+22DkuWW26a14XkM4N39pr0iaA7tlhQswrA3/Eki2n+xPpgchOs1N6XYEJnr6sIDbADBJ4QA1Mkq2QaTuZ9u8S27DzKwGt2cvMUUqf7IELChKyCXFsZncoEr/8wfPSueSmx5Ymyp8vHo9KNIkhTHAm5VsD1YcaeAlV7gDaYDu15Lye2h+Xh2HZ0CELkpl2eLu0i6zvyEdy2MPJb+WetVIZE7b5cFHFMAXTnhhoeYSNeU+InZDSP/9uCbSy0OLeczccudGJpPMwS35n7eHRP6FcOi93yW/25o03D8dhL/v9i5J9iWEyHLuGa8AG6XkBiqHG4T6KslpERvW7pWCNYBjk6APV9B5AWYddhnCG+/kFHK2MVm+GZsq+m+xFmOlh/eTvnWm5IurRh8q+GX2ImOAtnQrLAcqCX++rx56r4+k7jpGkzGC4VzvwJmFKgHk/LlroROI/ssImx3uMVRRi1br/FnKZkJOG/iSyQ3OV+N3ya5YoKH7EwmuMzVub3gmxxMwaZi44jHOk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(46966006)(316002)(36860700001)(5660300002)(426003)(83380400001)(36756003)(54906003)(82740400003)(47076005)(6916009)(8676002)(6666004)(26005)(356005)(1076003)(478600001)(81166007)(7696005)(15650500001)(2616005)(70206006)(336012)(8936002)(16526019)(2906002)(86362001)(4326008)(70586007)(186003)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 09:32:41.9350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bcd624-a77f-4398-1ea4-08d946aa5430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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
Cc: ray.huang@amd.com, Xiaojian Du <Xiaojian.Du@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to update the golden setting for vangogh.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..9144836798c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3383,6 +3383,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1_Vangogh, 0xffffffff, 0x00070103),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00400000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000000ff),
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
