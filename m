Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA3BC433E9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 598E364E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E364E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 011CA6EC38;
	Fri, 29 Jan 2021 21:28:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2077.outbound.protection.outlook.com [40.107.102.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DAE36EC38
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRZTw/n4SVJzzOltQBI++YfXdgm0PxKf5Q0OpRQzlelOuCgCW+CN7pudZB+j1bY4nEzJJ1etElIDFwQzCAvmUSShGUSkYh97NuEqDmviRvgsEVb1zAACcYSnahzPuvHe8vjmb8ixrNrGKI7wudZmDHgKk44q6E5o7Q9NcNSRVUeswf3yXJWm0hzn+4clOaf0VXvQhjuDN+DJ6uxmB+k4c7G3DYcPjhfD4wi/WyKS9YyxQ1cpcM+YY2wB+9jtbJDq+sovAuvDOKcv0r51A+rtBIlTonQUWCDgIFjN3WKnCwwbnXdeO0pMEhC2ThgTc1ugItHoagvoB/lgZbFguEGe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXvCb5BFo82uOtvF02v7NJubxNRWa/qJWB2nBfiCdRY=;
 b=ZOhs+S3O3oXBZYoSe7Loaq6+I1aNevBXR2ngDQ3E3MVZZn09Lac9WaTALiatuWI7qeCd5RGZK/qDhKQzW0+xcjwClGURqb1RLdu2kcWptrD0KTA5Ne9FNHnTOvNRBOx3izHuPW33Y3ENgC5VzP+o+nCYv0dPqx1Q/sKR2f7IQ9/TAXDuhtH/fVuX28rh4Kd1evMpn87tBfMtzyhALsEgFsGZQ2giWoDMOafGS/t0DF4JDjd4BmBXxICIFuJaHSbvvLBhmLtqbohAwiIF+qVZoyZF6mZXgJL0PeTvy4p3LeBGLWqP/crQ+1xyknJIQtjlFjfYJs1d1zG+rA3OrklcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXvCb5BFo82uOtvF02v7NJubxNRWa/qJWB2nBfiCdRY=;
 b=xyPaUjD9xxj3PbD3dcaSyiMSJ1qTO6/q8mtgrOkn8TmOKFfTdhpiO8aqsWrKfCLX6Cj0AJWtwqvosOD12Xa3ktq/keUoDCXrU+MllTIqdbokh1IFqIy64T/XsZ+ZrDVWSg+CcmGvLsEaXGLHoAakPcx+HSjIa8dydGI/Sw9WGWI=
Received: from BN6PR03CA0096.namprd03.prod.outlook.com (2603:10b6:405:6f::34)
 by BN7PR12MB2612.namprd12.prod.outlook.com (2603:10b6:408:29::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 29 Jan
 2021 21:28:45 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::20) by BN6PR03CA0096.outlook.office365.com
 (2603:10b6:405:6f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:44 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:35 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:29 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/27] drm/amd/display: 3.2.121
Date: Fri, 29 Jan 2021 16:27:52 -0500
Message-ID: <20210129212752.38865-28-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d42968e-f123-4ffc-db6e-08d8c49cdb1a
X-MS-TrafficTypeDiagnostic: BN7PR12MB2612:
X-Microsoft-Antispam-PRVS: <BN7PR12MB2612A159E00C8F76BE4B223FEBB99@BN7PR12MB2612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2rMrvmlAjEEHDtr2EHY2bZcoYVFilytHT1KdDUDIKcjaYyii+/qQAeGPurVCxb8Sx7zQrozJhdwS+nP9w102dM8HuacxMhEYfG3mLz60pLHfhOkuZK3bxzIfg2RmuydtlvVPuFfC+EzDex/dXP1fJeSIgtwOaaXPgyk6xNGQ57m6gDVUgOZ31w/D0Il2zhVz7y7+ow/LkXzehhwgdHMa99YH0BPcjAoApC+rtZV8Qhhd7uomhczNjbI6wPA1W/6cszH5z5Y5F+i7SoYTWLt2xmT335SJTYIBLp3in9vzGp/51Ti2QmFxffLkQFQTZ7Np5740Z47m/QD3orZNvMcqqnmgGBxzTd1EVJ8PVVHApFHlqVCI8sg9QgEhi5+3o34MfAmSHTkKa1ICC6XRN3OyDMe2G/CVxOvGQlyPE8MaWtlNCExCQ9NrHgyARlV5TCkK9pY/ccC4bVaPc2/GBkJ4lokx5Z+FhH/1my56SJsEpMezZ8/m/bvMWwNZucEcts1ZEyL1M0Bss9+AN2nDnYsudCslwgXmdF4Wbffi7mYfOFZt1xw5coY1EnS20PK1RAVJaSMRXIxQDoMByrKJOgB5FcNq/B3tbFQLcPWC+jqshs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(83380400001)(86362001)(6916009)(8936002)(36756003)(6666004)(186003)(26005)(356005)(8676002)(70586007)(5660300002)(4326008)(82740400003)(81166007)(7696005)(2616005)(336012)(70206006)(54906003)(426003)(1076003)(478600001)(82310400003)(316002)(2906002)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:44.2398 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d42968e-f123-4ffc-db6e-08d8c49cdb1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2612
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- Better handling of dummy p-state table
- Workaround for some legacy DP-VGA dongles
- Add Freesync HDMI support to DMCU
- Enable "trigger_hotplug" debugfs on all outputs
- fix initial bounding box values for dcn3.02
- implement support for DID2.0 dsc passthrough
- fix calculation for the pwl backlight curve
- Fix multiple memory leaks

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index be9adddfac96..739a39eeb941 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.120"
+#define DC_VER "3.2.121"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
