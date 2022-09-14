Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028EFECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E3CF10E811;
	Wed, 14 Sep 2022 03:54:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B5C910E811
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:54:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yh0tjRaPP2c3LFb7sEV87fR7rPF6onyIs2IpASs94By7POG/D35YjZKZAko4UMgFfh2TvpdlRC270BCfVxRA2D2GlJldqphT/0+RRPJdUoxOqBnxN8IvqcxjrALzcuK6ZfNJzcqnpE5wwj3uk3KxZQQBl0nzSlA0C3+PwKX2BxJEqwdNBDlOAuHL+NZGz65y864R4yb7I/koJgtlCTCn2bCzN4uyWFyfc6UTuzHYiBYQZyVybeRfNyqQ2nYWScK00I3WWjdMEhtEKXlzM/o12DVKm2AL8XacDPtd7NXKXqtlmfI3CQcZNYLxlrxxWFyy4R+HnkyK06qPZCM/nvW4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=clvvzVF7Ad4weErbq6ouhOk9gFiYwm1/p8zPsBiaYigt/g3IT3IubQBvp03KMQyLxAZ8bL4nuPPvUnFXX7mAoXyljkCzP+zO43oFMeryT5cUr7iVPLUtgArJ1Jy1Ro9PhI0FWUsVO3gfUQiifEKVER7o7+omXiFThF15RJzf4Na2tlKtg5rIn4E8vfWimE2i2AvNKO+5lX9PMkBygols3lMVKQ+fvBouk6M89q/yQRgXwY6sdo99gt13IEHX35sqt7NIdLtVfbGZRToGRbZgs4P3QXrvD+9QgO8lXJ8gAFISKO7u8AqeNmvKEkBbS2TG0krZ3tahiw/SuoLapt9cbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8moY3LDdRL700blhswLKYPgDUqM5zVJ7gO7NA0jCQw=;
 b=Hhzz9eDAUu1FI5ULBz6uHJQImbXIG8OUd7Qxv/+mc0BjDWRk4YNguo/WZ+pFbudji+lQZJcp0rZRUyuTVjkiKLENtDA0guw3UgL3npAv6m2e69DtARA592fDAYn+sVh1GYm5syXdB86ZMVtLSA7LBQ5z4gLXCbwYKco5aIaIOd4=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:54:18 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::19) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 03:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:54:17 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:54:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:54:04 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:53:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 25/47] drm/amd/display: Added new DCN301 Asic Id
Date: Wed, 14 Sep 2022 11:47:46 +0800
Message-ID: <20220914034808.1093521-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT065:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: aa2f5d25-70d4-4557-ff3e-08da9604cc4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMkE9aOs8lg/xmKoVTx0pm8EviKb1zlJKDBVWtD95G4eN12qVllEybDQ5g9v7xT0yuhN9qGZoG2yvT1f3z/L1VYrG656lfk0Rtzpby+CIaDmXInHcg1ZOSfMCZUjxlhYO7Tt8NGhU8QjFBZScqvAxEF+T74EXPN/AbbN8ey4sSHwiVZcA+OTzMOVaOdG6RZucekAsD9SFEv4Hnd+bFmxvaCWMuQpM51NmLD/3oViskkvvGvX8p4jSb5O126aMmQhalKwO7m8JYU4Xn8m9y8a2n3sDTy+1z/i+qJudTvYsYpHgKT+G00OYH7/fzs3PLR/1IGH5K5b2umZtVTpkZcnzYZ4iaHrHd6ht8iBcK9485ZrJ3j4vzI2KcHkjVr1tzoBgQfNnyfbsNwXizaWhfqWv9n42c8PgeznGZ6EIdDm5VPJlbMLTITyBivo6OgkFo1Ti9D7/6I6nObhnuOke9xv9rqNuPrzqsfcklQi8n4DX7fCy/xfWoaMhydMhRq3jMr53p3WxgX3zYE4hRnfy3S6JYxBkGqBjKUkvSE5c9LNDWyG5eEOTFgOpJx/ZfweDaQbGm/Aadww5dM6lXPIvLROVAfY4KhcJDoiosT0o8Zhwx3muYEy/oFLC37NOY6XuhTsaVNyQEX8l+7hFQHHQ18fBpAhZmIei/6tcGj6l/IOeZRKFBz3UxEGrOPs2gkFomYISTAU6r1fTMHuzze/NsY9EuqjeKOLrKDwVKm8ZcaMLd/ZnO5VyZjsxc6EtkBQjXmcJj5VuTpgFSvc4iq5PQrdGEcmpcOYDcZgSKi2HpAPKaIpCNozDg4Tpzm3O6UmUTd8
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(70586007)(336012)(4326008)(7696005)(4744005)(8936002)(316002)(70206006)(2906002)(26005)(41300700001)(478600001)(40460700003)(8676002)(1076003)(40480700001)(86362001)(36860700001)(6916009)(6666004)(356005)(54906003)(186003)(5660300002)(81166007)(47076005)(426003)(82740400003)(2616005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:54:17.6301 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2f5d25-70d4-4557-ff3e-08da9604cc4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Pavle Kotarac <Pavle.Kotarac@amd.com>

[WHY]
Adding new asic id for dcn301

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index 9f3558c0ef11..c3089c673975 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -215,6 +215,7 @@ enum {
 #define DEVICE_ID_NV_143F 0x143F
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
+#define DEVICE_ID_VGH_1435 0x1435
 #define VANGOGH_A0 0x01
 #define VANGOGH_UNKNOWN 0xFF
 
-- 
2.37.3

