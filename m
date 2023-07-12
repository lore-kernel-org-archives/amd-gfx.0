Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7203AEB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D9810E5A4;
	Wed, 12 Jul 2023 17:12:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8C710E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvTz6s2uQHhoBx4dPrxqFpzjzMLXflX1w0rtdpXFgOS+gKUC6MRDDbF7vG3M4iy6P4L8OLVkCdPyuc4s853PCrxXA/j7FtST+x/bWkDbCmratDOXIAzcN+8p+RPf9+Po9AJxgZ0ajsinsH5qaWgEOERAV4nAB7+gCNgyzEfmtdCC8BwTLUhxemNBCtFztjV5Y5wjW6kHUOpLw7WI/jHVCpHFWluyw9THVMtrWKE1gAGhV3lm2fGy8k+eDMZfgpxVw42FoTv8sEDjhb1lIR8uZ+5cnTB4mzLYDMk1NWzeQgt65QbEhFcZIT/OF/2E5qqVdJO/lcddERsvgMG8g2wxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RK1ST+ENciAAPW+LhyoAaY+Y6/JlBKGMA9frk5Xr/ZY=;
 b=KEP7CtxS4hxB1D63Wa0XjejCRsbt8tvrWdJWN8/1J9osHXQL1wSDH7+PuUbyiMqhYHd0CGspwNjxJ+be0wzpCV4YOcFdVOaWEjm0Dirv2BVPC+QHyqV17VbaVg3enmdYKa93MbV6FAQb5JtW9VIek7/Qq+haH3OdRrv1H6wDlrnTZ6n2Cow3gMLfYzduQaT+3thOdte3mgaP0IxzE6DtWf20ZWs/+m916cDrkavDil6mVxE5iBOzfctJgWK1dN6o+uydiLFC8VFduucyLib+AxKxh/VXOzTEOqaa6SgFLdSFHSRAU9fFyhT/Pg0zsqM1HMG93cthm+6BtfAtnZLMDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RK1ST+ENciAAPW+LhyoAaY+Y6/JlBKGMA9frk5Xr/ZY=;
 b=WdVsz0oyGyQl+sN62Lp75LFfxmYXUN+p9AbNMCLvcC13X0MIVxso3g54n6uHCt+PHTIgUwCRTb47YZt4SRMpDpyseCP3qI9z1MUXRL9/L99jJ7G0sc3Y7JRacfCKOqyMIvqPxRkK2ovZBsw4laF0Kpx76LqJExtUoX3vkPkX5EA=
Received: from BN0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:408:ec::19)
 by LV3PR12MB9401.namprd12.prod.outlook.com (2603:10b6:408:21c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 17:12:33 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::48) by BN0PR04CA0104.outlook.office365.com
 (2603:10b6:408:ec::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:32 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:12:23 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: Remove unused function
Date: Thu, 13 Jul 2023 01:11:10 +0800
Message-ID: <20230712171137.3398344-7-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|LV3PR12MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: cac91de8-0347-43d9-c05f-08db82fb2e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg6KcHycO4KjYR3CrsICizlP1r8YuSYma1x+ZS2wevz+ZusGobu+PEs4UURHzGDaO7a85N520Hz/UIlJvmTabzm2xch/rxVSUV/lzGmPUKIxBJQaal7ZcI/BdzPzrdthptb/GvRF8mPczDvZYTYTCIVQT7R51VMtt6uoX0Aensmw94M7pmg6FXHFDtmT++6KsNYHXe8j+jTAhd8fMQIj28B0Fh5dcwyMcVZHmXucsiDWntGrqpYENsXCiPE2WslVaYffBH8kpLPrgFP2PBVrnY8sOkX8TL6jDsZ6YnlXWeNc1Eqhr16RHvwJy34Kasrl48kCSmoc37qhZhGX7OMtvwmTm1VaHrU9TlDxSKrY38Diae8A31ILt0e1m187xZwAjHIns6m1Az2lEuKqJehd1qZkTATf/kd4R3agha0WLu5ZzG4quyfjvHLiR9VqQivVIXpy0IKESDeZJdrvryVxLLY1UpD5CWTGWTF/l1MTgWSWYI56cQJi17moZSzt1RhsRYdN8/pC0sw7T3l8dGf/iZ6okuma1uYPvyC3m9MTaNhjIcCtg24GoP8ki9sbqp/ORr7D6TmDqW/JJ1gZrk3TDMYJ+8JvHHSAKFYFIflYUaNotH/vTXE8S0RBiX8mMi4VPaj4AH5OD91lFW/dQZNvJkw6vldtfEyADtkpMJlxDcm8uXXWIY5k3dI0mEviXageYPZY+l29lTv4YsfMwYHxGS07O+ISVX/NmgMlY6NeRhLo8G64x+F8QaUuFUlKGhsnBBy2m5EakvHpr+5NG1wwMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(54906003)(6666004)(478600001)(7696005)(186003)(1076003)(2906002)(4744005)(82310400005)(336012)(5660300002)(26005)(70586007)(316002)(4326008)(8936002)(41300700001)(6916009)(81166007)(70206006)(8676002)(356005)(82740400003)(86362001)(40460700003)(47076005)(36860700001)(83380400001)(426003)(36756003)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:33.0091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac91de8-0347-43d9-c05f-08db82fb2e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9401
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

The get_engine_type is never used in the code, for this reason, this
commit drops this function.

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h b/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
index 7254182b7c72..af6b9509d09d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h
@@ -172,8 +172,6 @@ struct aux_engine_funcs {
 		struct aux_engine *engine,
 		uint8_t *returned_bytes);
 	bool (*is_engine_available)(struct aux_engine *engine);
-	enum i2caux_engine_type (*get_engine_type)(
-		const struct aux_engine *engine);
 	bool (*acquire)(
 		struct aux_engine *engine,
 		struct ddc *ddc);
-- 
2.34.1

