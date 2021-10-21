Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8293C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6D16108E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A6D16108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4D06ECBE;
	Thu, 21 Oct 2021 16:01:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76E96ECBE
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3A3hRtFb58n5xwerWq/OflsGtlRE1zyK1ZMXCP39zrBWmkzmA3upm6bRVi6b8vrPSkwrKkFl49pEv++xaFxgIuTaHiIinDR9wAP5xGzntPDG32MaBcjzLZtN3AyVAM7bwmoPmMoAJO03iWYHdGUIMgHTWN3D1sbb2X2gqfT3JLMb5ORkqq80Y8vsakt89rNHDpupqVGpKUnhfdfZcafrwOLZ5jEV/Fy/Q7vLrEoGj8XroC6Re8p6N8IvqTTC7aelnDu9pI/rSFwCupq7bx2va9IoMOoAYdcUlh9dA5mr0liOzGjh8qRoVxUwa1npic17KHxCSXKh0mRlzWuPeibCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNOmlhZG4e8sSV+ki9PqFyTyI2u6hIK3m6GtW7XrrIc=;
 b=gQpz26dmMWVssmznm0evtIVq+7P7tj/FpcM8Cd9EXemX9gNV6Xqitmj7zUbJ2r9AZDIa/OfnIaiEKOBbbKH5PM21PzNRBDJI1WeKz/rgFVZm5knWTeLwh+g/kBudQy/nDRHbat8M4V3E7oxXDCmDq5THRlmEezN+z9O5InfDanXBMeijymHuCxT7tia/JzK9hy6RTWv3bamM5d1wioPAysTi2DBbec3bdY+k2NTA6yI2+FtN4xD+3wy7Y0twkKtWE45F2BIONojuLq7V+BKQsYwrM7GJQqJ0Rx9G9lu5qZgPVh82Bng6lWmf/wASuGCB+Qf6RjhvAqaVKsZD5L9T9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNOmlhZG4e8sSV+ki9PqFyTyI2u6hIK3m6GtW7XrrIc=;
 b=a6B8iWTfTqdFcSqHo6IF7pkyYQ58CtteofmdKP2vlL/Aadkk/dWxIY1dNGCgA+jPQaYH70B15rV0MyjBLWyWTLr2lsAq+j5s62biiwmy3BQWAb70pmQXKpQE+O2NFFnct0mqBo88fJ7wU/ikCW26Ny/ju+qnpmX4lYSv0LfdWEA=
Received: from DM5PR06CA0086.namprd06.prod.outlook.com (2603:10b6:3:4::24) by
 DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 21 Oct 2021 16:01:32 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::29) by DM5PR06CA0086.outlook.office365.com
 (2603:10b6:3:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Thu, 21 Oct 2021 16:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:01:31 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 21 Oct
 2021 11:01:30 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kent Russell <kent.russell@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, 
 Mukul Joshi <Mukul.Joshi@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add kernel parameter support for ignoring bad
 page threshold
Date: Thu, 21 Oct 2021 11:57:11 -0400
Message-ID: <20211021155711.1191830-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211021155711.1191830-1-kent.russell@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3ac25d-b2b1-4c6d-84d0-08d994ac0cc0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB14334C2075F8D35C11FF157885BF9@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoGHMKun8N9XUANTc/ihb/A7APXH7Up8jUqTBwqEi/5sUpOPQ+f5rnCOp9w2iKpVYWvOI7MdLtR3//2Cpa4b6I9pvuuTsXQQ4iR4k5jIwY/KRC3xEtK08ITHPizgrGxEQLkt5xhB+AQ40483EwGqqRAhafWY83/L0Oxm5zfaD7dQ9gQEEbv3236w2euGJnAdPyjxUPJ+hbuYXRZiPl5Zr3+ObO4yxRiHqKLj1NCWdsxJWTeZo2zy4Ny0cROxqzeVH32Afnl1j4nH37uiBQJvPsAZiN1ZEBqkYbBGjy14+D4XxZkbzVReymSaHnoYHp9WCzHK41bPFMQ8/3Ymp7IQAHx1cFhe1nfsUEZUs9xMuGMTMu2E5WuGUD7bcgkbsRAUvT/cy54DpFCAQqenjRZ6PyWPLcJ5vQLRD2kKT1tXdbiJu0aThkYqdUsFBGsFcWd15cvPROAjuY7+WSEJb/yENBUfnujabsqb28IY0d3g71xcR2Q0PPevaUGJxsHgpAghaAPW2yRMc3YYUU86YwKa0ITf1KKSqcwc1dLn0K6P7obkzJlBu/WuNvxXdvrwqSGRBkZzVpu5c2TeAEnbs9aVMqk6TVFjLHvVcERsGWKeR0X4sSGtex5FB+10rb7BJJ24GO0/84NMiaq4xXNBONoB48U/mWznPPwNvAnetmQMV9RFo8O3/iKFS9tKzpDJhmKLm+9VK6ake8cVKgJK7LURrmDzJp9cqt+MypGJSqRXvbI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(86362001)(81166007)(82310400003)(356005)(44832011)(1076003)(83380400001)(47076005)(36756003)(2616005)(36860700001)(4326008)(8936002)(6666004)(7696005)(70586007)(70206006)(2906002)(426003)(16526019)(336012)(8676002)(316002)(54906003)(5660300002)(6916009)(186003)(508600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:01:31.8045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3ac25d-b2b1-4c6d-84d0-08d994ac0cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When a GPU hits the bad_page_threshold, it will not be initialized by
the amdgpu driver. This means that the table cannot be cleared, nor can
information gathering be performed (getting serial number, BDF, etc).

If the bad_page_threshold kernel parameter is set to -2,
continue to initialize the GPU, while printing a warning to dmesg that
this action has been done

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: Mukul Joshi <Mukul.Joshi@amd.com>
Signed-off-by: Kent Russell <kent.russell@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 12 ++++++++----
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d58e37fd01f4..b85b67a88a3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
+extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
 extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 96bd63aeeddd..eee3cf874e7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -877,7 +877,7 @@ module_param_named(reset_method, amdgpu_reset_method, int, 0444);
  * result in the GPU entering bad status when the number of total
  * faulty pages by ECC exceeds the threshold value.
  */
-MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement)");
+MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default value), 0 = disable bad page retirement, -2 = ignore bad page threshold)");
 module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
 
 MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index ce5089216474..bd6ed43b0df2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1104,11 +1104,15 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
 			res = amdgpu_ras_eeprom_correct_header_tag(control,
 								   RAS_TABLE_HDR_VAL);
 		} else {
-			*exceed_err_limit = true;
-			dev_err(adev->dev,
-				"RAS records:%d exceed threshold:%d, "
-				"GPU will not be initialized. Replace this GPU or increase the threshold",
+			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
 				control->ras_num_recs, ras->bad_page_cnt_threshold);
+			if (amdgpu_bad_page_threshold == -2) {
+				dev_warn(adev->dev, "GPU will be initialized due to bad_page_threshold = -2.");
+				res = 0;
+			} else {
+				*exceed_err_limit = true;
+				dev_err(adev->dev, "GPU will not be initialized. Replace this GPU or increase the threshold.");
+			}
 		}
 	} else {
 		DRM_INFO("Creating a new EEPROM table");
-- 
2.25.1

