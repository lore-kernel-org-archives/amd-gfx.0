Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0835C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 10:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB7A10E615;
	Mon, 21 Feb 2022 10:15:25 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2070.outbound.protection.outlook.com [40.107.212.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C60410E607
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 10:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5S2dORGaevfNlgb826hfDx2mQe3NjFeU3FsMeDqIKAlsoDj3FGK+mBRGYuog0Zd0KB1/yy746NgVEQGEuNsiRHbPdFo0gqAnbTQEyix36QJVV/3rGAceq+5/+qDn1d93LN1M+QF6b4kHpP+PrOZQnulswotYfbcpL8Pv26R1G1LBakKsYjYTm1uZaqz24tS4j+IxB8ED8b5k7bEUmBKRE8V+3Tbb/ZaRg/i9Go+34QSMhyvNE1lDUXEPILnZSRELsR03T6anyhbSW7sjnqDZ+hd6thuks2fgrKN/UBQxOAf0/LRq+pe+hwcJT9IamFhh7e5CUYou8O/y5PQt9uqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwKA2W4beSS3/4PWyjYZO76xxkh85Lm4x3z4YjIJmR0=;
 b=GPkQUsY09bMCaP8t88ZNYdw6xaKPOPrjGIUGbJmv5XcCcOXnaU0KSgzpg4C5f4UZhyPfZmtGSKILvtSTfA7plyvE/9TgSwBz+VjK0unMpO1i/65h+7/2SGxJJoY7tNudraJVo8d0lAcRYRalE7twshPAMxMTHVSHOYSc/pYiScut9Ij1nn2HD9Xb2tq2f6XIIzwe62FdWtVk5q5ht/1fRZ+JjqFBOrN4pm0CifuZb2+1d0toqeHmU5J01q2MJb9zsiTJ2Sabk9q3snkWZxBnzwNcOz6u9ogb6SMUIPbNHfJhfqGnb5RzH4Sxci0wlpxh0Y+MwlbeLvpsyMHQEi1Mlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwKA2W4beSS3/4PWyjYZO76xxkh85Lm4x3z4YjIJmR0=;
 b=oTidRdaIFTaB+fW0dCkUB8Rut0FLztzqH44WcoGEoqX9hrXoEEOvl7leOwZQV1hKdedBH09R3CyAFeKhhEWZwr8nxvtCP3M6yy6ZhUz8pQNPP2voGZy6iTFfWyqc8Esn6W8YcZLUmHywNL3nw2XDXS7er8YlsGx6BEx6VYgyLzU=
Received: from DM3PR12CA0047.namprd12.prod.outlook.com (2603:10b6:0:56::15) by
 BYAPR12MB3208.namprd12.prod.outlook.com (2603:10b6:a03:13b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Mon, 21 Feb
 2022 10:15:17 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::9f) by DM3PR12CA0047.outlook.office365.com
 (2603:10b6:0:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Mon, 21 Feb 2022 10:15:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 10:15:17 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 04:15:15 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: add GTT domain support for dcn 3.1.5
Date: Mon, 21 Feb 2022 18:14:51 +0800
Message-ID: <20220221101451.809067-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59ac5fa5-cf9e-41c7-eb9d-08d9f5230f09
X-MS-TrafficTypeDiagnostic: BYAPR12MB3208:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB320866980E4C29FC96F039F3C13A9@BYAPR12MB3208.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wx4+6I1+uzdlpLInKCuxWNWG7boUygLa7kICTImSa2DeahFwx+ttxgJ6nbKWFVUL9tb0ec4WuYIzb4htTGL7HXV7Hlo0goikRYJ/jhinOjCZVT5zP3Ue99njVQDtEh5irUl7dOHdxXHxkRo8krKZOb2+gGKxFzkJ2SZxRVjUgSdm6dGzGKOe8pW7A6FRUF4eY8478PWPkYH5DKP15UZu7mV1TGvWarcAqSPo+KMq40Xy5C4d7AyZB47eiTueF3ExKRfgJxp0BWQoVSOBVVoR/yA3TC2LmA+dYVbSzCOfY8HWQTopi/NZ4H+fqjSDKoQJo1AJ3VG6u7aAG9xiXh7FRHrE04OHeg/DvL4tf5a5rmnTMpFgIRiDm1Qh68JeA9S4mK9SbZfpjZ/PnW37ORmBvpTPAnEYa7yXY0L1uQIA5Z2bve7ZxKlJ7eo/YhlyRDLvp2WWSH6Uj7QWSFbXqUA1CEiFEjLBER/wW1+sNwrJeWeSRgK/1pCTysuhpdLRnJfbV8EFf7MgKEcKoH5QDXUleSCWsK360aHa4FH4FuUyYEaIp+iuLIhoiP/IcTDs/q6I50m5YAuiPllp4+M/26nkFzxooGPnzMUNT1kC6BM3wSiO3ndY/mKgBn/ZHpGKV9BlH3P1bKSvv5tqj3EfchBIK867aIUyIaCuAUSlpeMqM8oyurEp1XXVBsb/r5qWU1hy+fa7AS0GklPZno342uH8qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(7696005)(6666004)(54906003)(6916009)(40460700003)(426003)(336012)(4744005)(36860700001)(8936002)(47076005)(36756003)(5660300002)(508600001)(186003)(16526019)(81166007)(2616005)(8676002)(70206006)(26005)(82310400004)(4326008)(1076003)(70586007)(356005)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 10:15:17.3511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ac5fa5-cf9e-41c7-eb9d-08d9f5230f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
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
Cc: sunpeng.li@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 "Tianci.Yin" <tianci.yin@amd.com>, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Tianci.Yin" <tianci.yin@amd.com>

this patch adds GTT domain support for dcn 3.1.5

Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 9709368b4915..88ee1224541c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -523,6 +523,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 			case IP_VERSION(3, 0, 1):
 			case IP_VERSION(3, 1, 2):
 			case IP_VERSION(3, 1, 3):
+			case IP_VERSION(3, 1, 5):
 				domain |= AMDGPU_GEM_DOMAIN_GTT;
 				break;
 			default:
-- 
2.25.1

