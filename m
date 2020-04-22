Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD06C38A30
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 05:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511B22075A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 05:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MgKlVZRQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511B22075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2E96E271;
	Wed, 22 Apr 2020 05:57:02 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 914A06E271
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 05:57:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbGCC2g6r2e8c4h7KldIWKpvDmtMgQkrHxyVwLsAMHEcnITt7nu6CoqmuPmSxrOAvaKBWmpZ8Sk2hGklj79Hz+L8mdLNDeLRLpIs4UGj6E4sAyHWWeR4P5OblRr8TV+JlDMCo0s18pQ55UoBPf4JsIV6GaC04UzH3NhPCBo1j9gqnAsbn6ofjlfuFWEQ4WIIMoNOFPJ9t3BsiZsH6KztMYYfcT/fP/egBaQ5X28UQDEbMBPr9sLIpopHlr71Vax1Fs/9iA2+ephnP65z/NIgNvgIKXuXgD5w5z7kh4Zwikn8Iu2g1tFRV+j9Es9fgHWXuGn0NLNUP/oLcvd/xWwFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNYKlx5gmALq9dzabhkOYgGCVF/MUQVf091T4SzSX/s=;
 b=PjXrGeCxtPDv2MesGhoNLahSIMNfgcNxO/Zxb4wo1dXHSN/8Icph/p9+UVhWVAHdvl+5ZBpHMIs8gPpQJ3SfHJ0Up4Mk+uQZvuPEK6r/zfY1bl0h/FSYErSFiE1vm7MB11Qx+5PItn3571PmGoTl2sDzXQfPCro8EJcSar6FM/Uk2AZMl7ZkepmBtpGJ5s/jSk+rOaGbpNG3SmuD4e40bPsUE/PWLH3xQuBr/GezKor3xkOV+FPdE5Pgx+7S4M8vdTlxjDYtnPw/kJFtcMRWZIh3WF8Rq2Qph83B2qJDIJADVcFx6CMEkxrQYT+M51bwJWEcNKDkbKAItTiA06KGXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNYKlx5gmALq9dzabhkOYgGCVF/MUQVf091T4SzSX/s=;
 b=MgKlVZRQzyQU0y/NuDNllfBTrgAKqo7HUQ1PZFxuFTpK9U5htf8OoZXClS1afdEQTR4wopIC06pTQkNeMCP8f2d7iw5lj8rgpH/tNZZ1AjyZyBAdRAB/vHkF5nAQzLPlUe8IZJoUtLhkf9XrEPO6XPCXLKPYdp77SCMUsRyWAYY=
Received: from CO2PR04CA0143.namprd04.prod.outlook.com (2603:10b6:104::21) by
 DM6PR12MB3227.namprd12.prod.outlook.com (2603:10b6:5:18d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Wed, 22 Apr 2020 05:56:58 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::22) by CO2PR04CA0143.outlook.office365.com
 (2603:10b6:104::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 05:56:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 05:56:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 00:56:56 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 00:56:56 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 00:56:54 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH v2] drm/amdgpu: set error query ready after all IPs late init
Date: Wed, 22 Apr 2020 13:56:46 +0800
Message-ID: <20200422055646.30347-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(136003)(428003)(46966005)(110136005)(86362001)(478600001)(5660300002)(4326008)(2616005)(8676002)(26005)(426003)(82740400003)(81166007)(8936002)(82310400002)(81156014)(47076004)(2906002)(336012)(1076003)(356005)(316002)(186003)(7696005)(6636002)(6666004)(70206006)(36756003)(70586007)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6502c71a-e1c7-4b05-4b2b-08d7e681f7fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB3227:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3227538C75FED37D6E3746CFEDD20@DM6PR12MB3227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJBIGWeEl9rvgQ67DGwbNDaNX7SPaWZfWPoA8RLk+kSvAlr4EockABHlu/zuE70EyNbssQvPr6eB/Csamigtp8nsAF5bnQ2Y40RRe+bf+cgBN4++Djd2ag6d1XKatXIx2VecQbJljT8jt+j74S7v4uOE9VgwATsDhA86zh50knswWEz60rI2BJccSa7JhyRYOOPnZ1N/dQ38Q0duBEeZY7KfW7DbKescaIP+DsaCBVKde1033mt5D+6U+LX7AnbMtWdWBH+AymEYWgxIAR6FfnvQYlYgB87M7bncrvvXACrrUUlvYHz+DSHYDcqPw42ThlURDQ4VF1Fs4DnF8X6RerulxO0KvWgV5JqcvIAIVGhD7t7SG60KwTOqOI5MxpBBiyvFzuGyUo1hmFcD47vQU2O63ePmGW/SeLuh9XC8awk/i2zAfykXfCZa/QxAXSdAXtHWTR+atD9cF9eQvtenTS1XbAuOGWgLpkxWuZDjwwTAT1ChSJ1iq1Fo4HC360e2prWJoNL/tnRmqXUphQ/XHXDNDdm74G9qdGoyvMvLN8c=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 05:56:58.0267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6502c71a-e1c7-4b05-4b2b-08d7e681f7fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3227
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If set error query ready in amdgpu_ras_late_init, which will
cause some IP blocks aren't initialized, but their error query
is ready.

v2: change the prefix of title to "drm/amdgpu" and remove
the unnecessary "{}".

Change-Id: I5087527261cb1b462afd82ad7592cf1ef73b15bd
Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 423eed223aa5..e37e0982cd46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2218,6 +2218,8 @@ static int amdgpu_device_ip_late_init(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.late_initialized = true;
 	}
 
+	amdgpu_ras_set_error_query_ready(adev, true);
+
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 68b82f7b0b80..8b14aee370c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1921,10 +1921,8 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	}
 
 	/* in resume phase, no need to create ras fs node */
-	if (adev->in_suspend || adev->in_gpu_reset) {
-		amdgpu_ras_set_error_query_ready(adev, true);
+	if (adev->in_suspend || adev->in_gpu_reset)
 		return 0;
-	}
 
 	if (ih_info->cb) {
 		r = amdgpu_ras_interrupt_add_handler(adev, ih_info);
@@ -1936,8 +1934,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev,
 	if (r)
 		goto sysfs;
 
-	amdgpu_ras_set_error_query_ready(adev, true);
-
 	return 0;
 cleanup:
 	amdgpu_ras_sysfs_remove(adev, ras_block);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
