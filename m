Return-Path: <SRS0=Hu2c=BR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496DEC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 02:36:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F672177B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2020 02:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aJ39G8M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F672177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29E26E954;
	Fri,  7 Aug 2020 02:36:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3B06E954
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2020 02:36:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQh1eDQ9cc6GKGmpu6BlUE/1HFcE+hwshoT85SQbzWpS2lgNV0GRVOXnuvU+EOJPDXeMw8lzewfQ4r/6jbD2GAfpI5aGbChSxVPSqj0AJEf2Z7indTDR16mqxBB2JA9qlzWJvBAvTITavD6THZV/bmvPNrxHd8Ds0iK5EeZO/OQ16NpPuahWehIWc/QnIJo6fnKAzXT61ohtzPXOF+mUZNIjOVmx1uSwf8XLV8nJC3SaaXnHbVQDEcDNeL2dkSfbev/r8Kqd6RFzQ7UAFQHdAs19SUSq9YdpY6NhExM+N1OhUXAa8icFyIMx/gDCsRqUzYVnZ3mJb0vHhzDXb1neCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR+DWrtgt6u9IndJxGptNsQBK9S/YkQSxE5Jeposa5Y=;
 b=j2uwQQCQ1YO4g5GnNuoa90kM7qPgUL0j1w6ubAWOIf9pz/ubCB7f762GIEE9vYYn/awpEZXWYHlgU48KpzE4Eh6y5gSnTurSZ3xHJ3ock3KC8J54aZcm4TKTU4yufywLpay/NhdtfQMRDaF6zzE86j16eHKyOSXEbod6I9AalaUxc4/qJg50cnCuRL0zG9zp940j4AUMZyGrBsoVlKl2RFBTLY92XutEKkpJfIf9pVqwkf32uy3fMIG328es6roCa4nubTbvkPd32f3BsYFv1l4Hg36GxjoBq46aNq6MpeM05hq50INqHO/PhZWHcaJKUqXnpDvXVkX5zB+530ODnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR+DWrtgt6u9IndJxGptNsQBK9S/YkQSxE5Jeposa5Y=;
 b=aJ39G8M5lgUGyozeF3kZ1AEfbWDH2JcnkE2vYPO212GJYEIZGv5ICXWJI2qMh3plLnuC2mHrQ6T/1X/nKN+08mlA75w3YmjjeIxJa7jjsJ1GYkzN30wbOkYxT8/tzPn09kpl6WFPcyUxmGXRbMt+oDEuIMLbw+P2ufk0S82DFWA=
Received: from DM3PR12CA0122.namprd12.prod.outlook.com (2603:10b6:0:51::18) by
 CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 7 Aug
 2020 02:36:47 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::d7) by DM3PR12CA0122.outlook.office365.com
 (2603:10b6:0:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 02:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Fri, 7 Aug 2020 02:36:47 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 6 Aug 2020
 21:36:46 -0500
Received: from rico-code.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Aug 2020 21:36:43 -0500
From: Tianci Yin <tianci.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit(v3)
Date: Fri, 7 Aug 2020 10:36:33 +0800
Message-ID: <20200807023633.5949-2-tianci.yin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200807023633.5949-1-tianci.yin@amd.com>
References: <20200807023633.5949-1-tianci.yin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 135e9a15-3704-4a6e-52c8-08d83a7abb54
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0038:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB003868088E1B43F0255B228B95490@CY4PR1201MB0038.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INXI9PL4NdWksWaU6P6Tv1WHagh/WdnXbYp0rfhiCAn0NEI4ENIkMAOwYDRFQXf8iBJ9FIZUCIpkQvfWa0GmHandQ+OpDWmmagR19E6D1H4llU/S/CAlVJQW1XpM8VmS8m/AgfX1FSGiu6AWxJMd9D2Oz+CzfU3eGS21WovgNJo5ECZyldk6Al4rlMJmdEvAleM74teN1PG5bS3w5h+ieLxdzHM8PCjyz8PwdYL8+13Mgx5xK3ZjNJqurlbAfS3m151ic8zLACVtmseISVogDJC8zThJGlRb+jSIFqJGGfKIPky514k66sz34mVRJQ3knxU2c9cUTh1/w9005viAJNJahRYGuw6YLX4UGHCR6v2ngVnr0T10EF9H4n43L43gA3GTv22+VaGlqIvNrXuUnBe4rmpph7TR90fI5CgFeHo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(46966005)(6666004)(2616005)(4326008)(70206006)(5660300002)(426003)(70586007)(6916009)(83380400001)(1076003)(82310400002)(36756003)(8936002)(47076004)(54906003)(81166007)(2906002)(336012)(26005)(186003)(498600001)(7696005)(86362001)(44832011)(8676002)(356005)(32563001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 02:36:47.5372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135e9a15-3704-4a6e-52c8-08d83a7abb54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
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
Cc: Chen Guchun <Guchun.Chen@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Tianci Yin <tianci.yin@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Swamy
 Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>,
 Feng Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

On Navi1x, the SPM golden settings are lost after GFXOFF
enter/exit, so reconfigure the golden settings after GFXOFF
exit.

Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8eff0173360d..9e133fd0372d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -571,8 +571,14 @@ void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable)
 	if (enable && !adev->gfx.gfx_off_state && !adev->gfx.gfx_off_req_count) {
 		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, GFX_OFF_DELAY_ENABLE);
 	} else if (!enable && adev->gfx.gfx_off_state) {
-		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false))
+		if (!amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_GFX, false)) {
 			adev->gfx.gfx_off_state = false;
+
+			if (adev->gfx.funcs->init_spm_golden) {
+				dev_dbg(adev->dev, "GFXOFF is disabled, re-init SPM golden settings\n");
+				amdgpu_gfx_init_spm_golden(adev);
+			}
+		}
 	}
 
 	mutex_unlock(&adev->gfx.gfx_off_mutex);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
