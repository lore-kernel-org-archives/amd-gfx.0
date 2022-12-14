Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF91EC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 485F710E4B4;
	Wed, 14 Dec 2022 22:17:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAEF10E4AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIdsDwJbbVnzAEeZonF8rdhiUnfrNhEBQYd1mQHd80ERvFnfUP5gUmzXI5EOWgVK5QJMCaEvDvxEJXFdGcidmzy+uAUdQNatFbGfW6F13wgNQcAtHRzpMN/XwvpNRUVWeOt3ih1iykSF/F12I/AEJG3z8rMsAMuK5oghrizRrq3XAae97CF0T6zho9XPLAlyd0O7YLeja/4w5dometcgSzCw0H29MkxiTxd4YKl/2N4yDoncbI40csT6idY2CPoWXNLEny4dUvDSrerdNJQWXoiHC5ErvfsPFWUGhio6QIDxSPnUDS8Erzg8oFU9hDUUb1TN4hnfEfoUnitYbj0aHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g3ZD+va75tdyGZvpRUQrvViovRdwTlNp6syFqdCUyM=;
 b=jJcctGXyQgyZXq1vyn6bAixEAY2230ELYle25yorX0iKHK6kd+fzwAbNsTBNv7+T2Yqvy5fJ5MQRuhiVcbeAd5sxFMxXxKoQUTmnI575USAOr/93dGjntLVe+GRo25VEzqoEpvLtWEViXGH2B0i8kumBsEKtazPeE1XCsdmWUzqLn6gxBlYPp401hHtg0uxqpe9D0w1EaNCJz1C8y8pY2vizqu08+eoYLG+osfddaCAR5q6Nmc6QgEOH/yJG6OmtDcYedYUBh8oq+oyYbEyl99iEf9XfBHKtu9Majase5YmWgLfoMNbKR570fhV2CrjPd1sXjzR4Ms84rGBNTVS+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/g3ZD+va75tdyGZvpRUQrvViovRdwTlNp6syFqdCUyM=;
 b=AGcFaHabawFTzZQ+9FCGMFCs+CDCaOx0FT3Gy1FvCGmlLiVhXTRpRdbHIwLc+YvJFbzZoSN6DfOpOzgY1LOvecR4QFdThxmJjPeoD4iVCB3ukTmlrh7HrlRcTNsdrF3GE1fSUZedPOqBvF48KdbEVxzUCjYjLmmEJxP0+DWJuWE=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 CY5PR12MB6060.namprd12.prod.outlook.com (2603:10b6:930:2b::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.19; Wed, 14 Dec 2022 22:17:14 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::58) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:12 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] Revert "drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume"
Date: Wed, 14 Dec 2022 17:16:53 -0500
Message-ID: <20221214221654.1625194-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214221654.1625194-1-alexander.deucher@amd.com>
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|CY5PR12MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 77647542-650b-478e-30b0-08dade20f400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OASXYb+VxE3zgQIlvyX4hbRjiZRmtMp3A/F8fgZNB9Biwlkh0MzZD8Fc6yIchzq1jCehz7Vv4g89XFsJM9CfIlE/+zIIPzkf4NqgRTxpXS2f5KUQo9K/XYsRhcGF/3pcOI/i0PrdCqwQNRJ2hHRdLpf4znluXTMgiESEdL6O781NbtR7mxKpcWFg8iVnFuQkZJIjvcSXCQ/E9gvh0f1+mN8V1WzcqEL60d/qCLqsTiqViT93dVhDWSW10BwWaPXHtBANJ1SA5nQ0klgiVqqro8E+f1wwkgunW9Qk61zZ8PCgpM5TqfniEeqM2UxKQIpGkF1MmnVJZkkVNT3sNsYMrJc1wUodv0p5gS+KJQQNR9cRb4ZDhG0R0gxYqX+79wlfEjKeeMhx73B2ZrEfpYZzXZxTFNOfsSDPjCCGx/5p8rpjsuludcH2LVx/8Z9qpOi+U8pdR4J8oc5ZENuj2WtKrgH4Prp+sp6G671usfQUauoSDn9r9mIPWceWzx2EEPNlBlnnQs5n6tppHtE4VkUlIyhCGzMscSpAN0oIMAi9cdJQ4IO2ACFETWrWns86EzffYb5qILb7lzCKVYgdmFyvcbDgxtDw1P8ODurcqRzhTQfSSw+y+KPr2sRni9teBtuztu9DpNkCd3WohbdW/Jsjl8xfiqX2WoLr3VZUzQSNoh/sI4NWr4ztC14M+0TAJ1Wuec0hwG4gm95wggJaPWUYWRKonmuaDgsBj8++LnLmnDU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(316002)(8936002)(5660300002)(6916009)(70206006)(426003)(8676002)(86362001)(26005)(6666004)(41300700001)(336012)(36756003)(70586007)(82310400005)(7696005)(4326008)(2616005)(16526019)(40460700003)(83380400001)(186003)(1076003)(478600001)(47076005)(2906002)(356005)(36860700001)(81166007)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:13.9694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77647542-650b-478e-30b0-08dade20f400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6060
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit f543d28687480fad06b708bc6e0b0b6ec953b078.

This is no longer needed since we no longer touch SDMA 5.x for s0i3.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c0719c03c37..582a80a9850e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3234,15 +3234,6 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 			return r;
 		}
 		adev->ip_blocks[i].status.hw = true;
-
-		if (adev->in_s0ix && adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {
-			/* disable gfxoff for IP resume. The gfxoff will be re-enabled in
-			 * amdgpu_device_resume() after IP resume.
-			 */
-			amdgpu_gfx_off_ctrl(adev, false);
-			DRM_DEBUG("will disable gfxoff for re-initializing other blocks\n");
-		}
-
 	}
 
 	return 0;
@@ -4230,13 +4221,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 	/* Make sure IB tests flushed */
 	flush_delayed_work(&adev->delayed_init_work);
 
-	if (adev->in_s0ix) {
-		/* re-enable gfxoff after IP resume. This re-enables gfxoff after
-		 * it was disabled for IP resume in amdgpu_device_ip_resume_phase2().
-		 */
-		amdgpu_gfx_off_ctrl(adev, true);
-		DRM_DEBUG("will enable gfxoff for the mission mode\n");
-	}
 	if (fbcon)
 		drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
 
-- 
2.38.1

