Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6151461106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6151461106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5DC4737A2;
	Thu,  4 Nov 2021 20:52:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D637379E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLl81oBz1O5AkDr93XckmeNlwo8NDFq4Q2h4OzWYskmL43evEoybBeJ1OqVF06fraIFo6Si7goVMDX58uDbZ45rP+vUHNyhfCPF7vUU4R/UcrLS7wuewqB5puoTR3UGEOr/LLWiwBoKvccROGCgu4IpP2KlCnoYrMgqSDHLXiaiR+uP72rvyV/BNcxawfCFvhHYhOQZb8ad/GCJTDnSusn/xlmFWfFXrEgDBL5LF/VjCKm6AnbP5JBw0M+/IGT1nN5csIGbuU7DlW+Xwc8AstVfRQUEljmINt33TEcSESN4rmhMXZTfz0wYau78PFGYOq6yERdQwI6WolVeIFNzRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7Ej3uXRU3t/djvl5MxIDz0vv+Lk9gDLKiEXx6bYQIA=;
 b=I9LsEjhaTD9fz+ByNOg3obf92c7NChCA/gpyl5gqknWKhv1FkxYgNlq/W7Tug2WcVk0eGZhHJkuc8xTsHOEmF2JRFRJdf2f5Ggh8wMnb2fAc6tDXTKHHcsMDwve5zuk3+0j/95O6p+Yr5wEFMIAFuwnctcFDIBeJ9oOS+VPISrs+xPMB6bFL827Y4J8EfI5tWPunYpWiNrgSqFNY650nh7xVr5IiA3mz8K8dkaK69T1OvY4oSF1m7EKMSccvTNto+jIPJnMWGDISUjU/iE2akc23zHN2OgIq/UnEgIvZccrGtGoP3enyuYITjIpVxHGiNHHcJjfJdwFt5KchKeLqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Ej3uXRU3t/djvl5MxIDz0vv+Lk9gDLKiEXx6bYQIA=;
 b=0iN75iUO7blCgyfTCog7y0LFVTWmtvlTa0scBlijii+lti/kiKiGWvNtQuloMW4fRYEISZ3ulCc0d/vHS01/w7ojizuRjs0YKdeMQrIUaaEsR9G9cjDmhfC3t3GQIUvio6mR2DhQWy+UndfEiZG/lfYMx96nP4851ERln2yv57A=
Received: from DM5PR10CA0002.namprd10.prod.outlook.com (2603:10b6:4:2::12) by
 DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.17; Thu, 4 Nov 2021 20:52:46 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::f1) by DM5PR10CA0002.outlook.office365.com
 (2603:10b6:4:2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:40 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:39 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/22] drm/amd/display: Don't lock connection_mutex for DMUB
 HPD
Date: Thu, 4 Nov 2021 16:52:06 -0400
Message-ID: <20211104205215.1125899-14-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78bb1da5-a1e9-44de-d0ed-08d99fd50dc8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39635D4A860FE6D92781050DEB8D9@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I38MfOg1lPh57w9oWpbpvrsjHP6mOzMClvSFE35vXP7aaL5e/Wdp5Mt0JFLiAD+bb/hBVgrqE7MiWqnG3s2PWetv6pCadUiTXrKRLUoTfcoKpOzL5npW0PXf0vEalKzlfuq0hboqrrC3qWouwhLcuLimrLEV5+4rh+YYENjiV4ineM5Gagdsx9NHkE/prEHnb7n1siCgLtdKfWJtx62qyaObdT2PgXzN+Av0qa6c9Ai7MEcPEc6ogj0nfSZ6Ve2FiHGHKaFuW+2A8tjy0784fI3U7GR/HrR/i+OqRWU0q5DtdVRED7dC6xS+sGUHaI72lypnT8cZnVpcPkvrCWoSs2pyKLS2CUEH1PmqEBPgD5ru0RtlBG4gOkEpPHW5HAKrLv6VUUBvNs8ieCUpHZJtefJORdwBFQi8hQzWvhwIc3IUXPA+peaFO2YFKH9Gsyz79Qox1gV8Cqzw0PMOB/H8c9YnxGnCq2OJIFkMYTc0s3/0M1hWM+5b/uzCgRXYPHJ4n9rsvGY+Kxm9NNFbrhrjXnwLpy8ME+kAzPUI5nhHxwziXdZYRdEbFg7tnyUBDCL4I1TFxhOg4H1/Tms9u8x2O1gDZunvGGCTUITCP8nDH/7n/SOYQOshf65MaE/PX8RtGtvmYtIOhEQRyHxK7sn1xg0ZlPE/vtMwbE4ub7Ul6f1rbTMobo06mBLlLkv9ZcG1x61E/m3eY0d+hSeJ2t7vL8yJo/JnMG8uzuv0kVfiUqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(26005)(36756003)(6666004)(36860700001)(1076003)(186003)(2616005)(7696005)(426003)(336012)(47076005)(70586007)(86362001)(70206006)(8676002)(6916009)(316002)(2906002)(508600001)(4326008)(81166007)(356005)(8936002)(82310400003)(54906003)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:45.6911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78bb1da5-a1e9-44de-d0ed-08d99fd50dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jude Shih <shenshih@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Per DRM spec we only need to hold that lock when touching
connector->state - which we do not do in that handler.

Taking this locking introduces unnecessary dependencies with other
threads which is bad for performance and opens up the potential for
a deadlock since there are multiple locks being held at once.

[How]
Remove the connection_mutex lock/unlock routine and just iterate over
the drm connectors normally. The iter helpers implicitly lock the
connection list so this is safe to do.

DC link access also does not need to be guarded since the link
table is static at creation - we don't dynamically add or remove links,
just streams.

Fixes: 00be4268d32c ("drm/amd/display: Support for DMUB HPD interrupt handling")

Reviewed-by: Jude Shih <shenshih@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d646acd269d..0fa0c7bb07a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -669,10 +669,7 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 		return;
 	}
 
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-
 	link_index = notify->link_index;
-
 	link = adev->dm.dc->links[link_index];
 
 	drm_connector_list_iter_begin(dev, &iter);
@@ -685,7 +682,6 @@ void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *not
 		}
 	}
 	drm_connector_list_iter_end(&iter);
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
 
 	if (hpd_aconnector)
 		handle_hpd_irq_helper(hpd_aconnector);
-- 
2.25.1

