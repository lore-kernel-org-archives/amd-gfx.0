Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02C8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAE310EB0A;
	Fri, 14 Jan 2022 01:38:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B8310EB0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:38:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPNolR3RDwMFw2t2y96zjv3XrTgr9I1HzAzxJA97/qRT+Ro0SWZfw4aRPrEEQ6nrTebXN67xAGCDhUP6De7G7LelReKjFq06r14GzTWMCf11D8SilV9G9DXwp2gHD5rHVz0G5n3Za5sNddJHwmonMnIY5zpi6pRHPJkJR2syl9lCwooA87vCbn/IspPz4MnWipW4qCKMKXTt0F0Gzngrncs7nuF658evhW1woPU1YwXMQp6my+ZH7p5Mg5m/RkzEbkeUJO6fQE3AnuC8uRKVjGH+uR/V+NzKr61xUP+a5pBn7PQ2zUD38mifTjnS+m6YiNBNVUPOUAgfbkVybGbzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obM5EfIUIylmgb8N7e0OZmU8PeWCVfQ9yK22SjhKugg=;
 b=el0CShjI1YHCqxo6GA6EJ+kVIttpElghjA5MH7krk2w396RgSi9pKgJdHrQCYCQy+3Qv1AA14yLg2USBtZHyHND/autfzVNvV+6QVCmA1hF8jIyGj9ztZB/MJBn1894iJ+p9vWHY/LqZgaqnWDb9XXy/h9AN+ZFHslcAcf4tMAK8pSLJMH/01YTWzP/oSOEqgDs+ZDUM68enr7H2h2dE8JXklmHQC9Becc7J8IYZvlHuZktLiIXe6bXdnDgT92W+tvFYZyrhkhKakIeTTBxhGk/OeEXTK/jhHD3ooKjN4cHwzndFHrtqZhqFcPxCwYs4sboSwWKkbn0kHU9TBuInAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obM5EfIUIylmgb8N7e0OZmU8PeWCVfQ9yK22SjhKugg=;
 b=z5jeHg45y2qtEFzi7ds1HwAP0DnI+yP083wxdvV2KyZskENMvDKi8LfoKWahdubZ6sNWWYu32wHGI8trJCvehCWwDV1dv8i9kan/h9id1HAhG64JKzJiktnQsrrhBa80aI5k2vVxF3ieFy7GHWWAyZGYzs5YANalX8CTnCYhhxU=
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 01:38:11 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::a6) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 01:38:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:38:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:38:10 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:38:06 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: Add signal type check when verify
 stream backends same
Date: Fri, 14 Jan 2022 09:36:55 +0800
Message-ID: <20220114013657.3119627-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77d85c16-744c-406c-74a0-08d9d6fe860a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4071:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4071743C6E17E5EB93B3EDC2FC549@CH2PR12MB4071.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYpgRTbhf1HIcOvG5Urw447BSMxT+gAKfsW2aptQ5PGtNzk9nLyKvGpbQB08hukFi0JQBVWhD1TnWLSkLpdS0bdtUo3qvB7hWmrKdn9THM87ERaxYLHGEREor3Em63RyAxkXwDa+mNSKRmiLxvXX0Dup7tnrnMef6DkDYo8/ErXNa+6Yrvp342k/7bml/UwkXXU2dvoSbenFhROqSkxFxiMwLCK0IJvcRt3i3ex+Y7EwY7nA6b1UvWxSZlmmjp8BceADVQY3AqzN/uTx+tVuUo05Q3oUFRq/ufdsF9zUeZs3RDCmvJk9+UhTXdMwKJ2RYdwYkNkCdSdlinhQyNFk5UrFySGo0sqAf8CMD1mN4Sbm6epgk9cqYhI5UlhPA7OCVWduf/XinEJ36TN5xWlAjApqRYzve+OOx88EY36hTC0nvOS5A3w47MALZ7DHcafd9JMCfdXCO91tFCGuG64z2etfxdCVJ8xfSi2+TnziuUYsG+/ROH+C+voGPclO1mOLlpmuF14AM8OQAB2ecTzXYRlRRSH2eNA7Bb8bQ5R6KlUEExyTtYFb25z/nEgcC74h/c+zOYGv9UQHdeEP8vZcs+qI1HPZThkKfz7Gpk49T3I04IOwbrpVbZtXt+Ro/zACTEz4ZMd9pDS++ofg8L4oGQkcCSOE7fNWoye+MwkYgMilEKXhsHPj+/ytIh2M9w7NIZpCRJ9sif0A2En0u33bYYtw2Essb+sjIaMQBr83ZpZDhk7BBJEVhQ7FoQWLx4xAF/KyjgVk5KJmptHxJvHB/quPHM+EwzaFHu+QJcbR95c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(36756003)(26005)(86362001)(336012)(47076005)(8676002)(8936002)(2616005)(7696005)(426003)(186003)(508600001)(36860700001)(1076003)(40460700001)(356005)(82310400004)(6666004)(15650500001)(6916009)(83380400001)(81166007)(54906003)(4326008)(70586007)(2906002)(70206006)(316002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:38:10.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d85c16-744c-406c-74a0-08d9d6fe860a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, Dale Zhao <dale.zhao@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
For allow eDP hot-plug feature, the stream signal may change to VIRTUAL
when plug-out and back to eDP when plug-in. OS will still setPathMode
with same timing for each plugging, but eDP gets no stream update as we
don't check signal type changing back as keeping it VIRTUAL. It's also
unsafe for future cases that stream signal is switched with same timing.

[How]
Check stream signal type change include previous HDMI signal case.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Dale Zhao <dale.zhao@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b3912ff9dc91..b34bf59cf54b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1640,6 +1640,9 @@ static bool are_stream_backends_same(
 	if (is_timing_changed(stream_a, stream_b))
 		return false;
 
+	if (stream_a->signal != stream_b->signal)
+		return false;
+
 	if (stream_a->dpms_off != stream_b->dpms_off)
 		return false;
 
-- 
2.25.1

