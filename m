Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EE3C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A2D210E512;
	Wed, 26 Jan 2022 04:09:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB07510E512
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:09:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRkv2KpoH/+drPqfSU4UAzLotWcI7NRxkOMxo+kTWtPdwY3rsqeKXG6rsfe9i79zNe2EKNGJN2y7KrjRPQyjzwggA0gvrpmRLovUFd88zKQGhJyU+sk7a6MkxrDczEPOrdeYVlUiLVwEQUHtF6p4AUbnhBSlxXwbhzpKjC69o31LMvpTpwIh77xpQDR+JAQEp8kdBMeB1Hvg1C6XlTDd8TucWhhhxYcnCgyQnEWADVZ9B1WebG24B8uCZi8a/Hhol8nGX0AOMV6JqFTN7X1IsRkmeoEw3KWMf4FqSO9rniw/aQiT7f4hj2FX9DFDOM7uDAMaso/IXwNjAfyX8kFM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeTMDDKhDMqy+lF/BOaQf7FRltyOhWdWhdc40r4+rX4=;
 b=MoDl+m5T6h1zUOAiettfvqxj7+KNyPHcq9v5EAJA8XiRORGdQWAPKyKhcEQvi00QucnFmiqrPlYouWlZQoKHbd1tmIT1rTHwMM7XD3PkrpUICKS2Dl0avca/NLjADQRxwg4weT+zJTWNLUwLR0eikZWSfIYmsaH2wC/AG+wInicJ2d/NLvV/gBeIHG7UIVkz71F8a0QcSSZmEzihY8tjbsg93yq9lVdbYgKVipcUrWbHQVm/6JpMfSJD178FLlhxkS09wUzXUfZPogmYCMSe+Kw/8Wpx6p9+/M+itJYHgbz4J+ZNwvf/aGY5mYnkpU386onXTEsk1+js2T1oGRU4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeTMDDKhDMqy+lF/BOaQf7FRltyOhWdWhdc40r4+rX4=;
 b=YizxPn0f5XMtwlVMZcA+zB3hyAvva+IJjc7BBAQZIIEOg2gnC9FtMvyOf/vAAMnT5i6kFrIZoJ0upSZMBLYzpFKDVBoOiuiPz0HSVOr6TuG4E68iN0LETNZ/CN89saiP51Wktaa3tzE+ERQVLiqRiR8XA3jBwPEDVrZjAvuPrRI=
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by DM6PR12MB5551.namprd12.prod.outlook.com (2603:10b6:5:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Wed, 26 Jan
 2022 04:09:43 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::30) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11 via Frontend
 Transport; Wed, 26 Jan 2022 04:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:09:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 25 Jan
 2022 22:09:41 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 4/4] drm/amd: don't reset dGPUs that don't go through
 system S3
Date: Tue, 25 Jan 2022 22:09:44 -0600
Message-ID: <20220126040944.4324-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126040944.4324-1-mario.limonciello@amd.com>
References: <20220126040944.4324-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6367f2-8df1-45c7-e810-08d9e081ae9a
X-MS-TrafficTypeDiagnostic: DM6PR12MB5551:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB55515C1235B7CD76E1B9A962E2209@DM6PR12MB5551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1/f/yO8mflBq9QAERKzBoz7DaFuHDP47eC41oM3jaxhteuTHNnHy0KC4QSzyvG4mAsEKSnvvLhp3+TPa3CK6Wr+78ptKPVPvUSpI6nYak/Cp4p5ipHJAl1L1A13tYCkjxOAvQOWxMgKhG66/INYodDc8wuOiqzCf/jQzWN7lgie/KxHqRaDDL2H4d4gVjXT2bT1R1HeR83pVaW49eCJxonzZSUvNYcMVgHkkDb3sGIelqx5oKaruZ3VC6XFR/AcEvgHehBZJ9I9mg4GzSAOmvsQ6UkKWB6jXe/CuQ93nhhE5yaPNIGCK+e5BW9Pf8oOWiO+rI5HZFgyWgfKMWhZcepxDPkhU0rwaBa75xApXYRPXxBrha1q3cxLouSKy0He17e4sURbH1XYr9zzSZMxHOJjZmTM/B3JbIfzqdZ2kGGdNPRSpSj4IW6LBulr7YimRMBuxvIvdB7TzQlGQjqT0SrSACWoJJMQ8EZzYuN7VySaRdvfFxb4qbEhBspFMiL/RVFsqJOEJTvZvDjQJhdHPRQqMuQ2kFzKKs3XL1Wic7KRXqDgFrETkQHC2oRvPkEz/8D5oufIaALWhty/o/F57FqPb4l37HcUmRzhmflq5914fQCa4eeEAxUoZW2lI6x8m1IDVNcPHpjhTqwMIRQpQl0g9gz3cRZKSU8cHKyXZlg+e/Kqy9Zd6yNlzAgNGdCPmSYorFO7vNcpEl+rcoiAj6SNMXVzK+emXh+Gd5hn0cX8U+Ya+AdRbNiQkto9y9G5gCwt0j5d5uezwa490g5QbXhC7wZBpSajQWUdHPkYFOc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(54906003)(4744005)(36860700001)(5660300002)(508600001)(4326008)(26005)(6916009)(70586007)(70206006)(40460700003)(316002)(186003)(83380400001)(1076003)(16526019)(8936002)(426003)(47076005)(82310400004)(81166007)(36756003)(7696005)(86362001)(336012)(44832011)(966005)(2906002)(8676002)(356005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:09:43.3645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6367f2-8df1-45c7-e810-08d9e081ae9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5551
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
Cc: prike.liang@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

dGPUs connected to Intel systems configured for suspend to idle
will not necessarily have the power rails cut at suspend and
resetting the GPU may lead to problematic behaviors.

Fixes: 6dc8265f9803 ("drm/amdgpu: always reset the asic in suspend (v2)")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1879
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 123ec5a07dd5..66290f986544 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2319,7 +2319,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 		r = amdgpu_device_suspend(drm_dev, true);
 		if (r)
 			return r;
-		if (!adev->in_s0ix)
+		if (!adev->in_s0ix && pm_suspend_via_firmware())
 			r = amdgpu_asic_reset(adev);
 	}
 	return r;
-- 
2.25.1

