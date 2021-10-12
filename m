Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA417C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8858160EE5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 15:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8858160EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1334389C59;
	Tue, 12 Oct 2021 15:53:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A5D389C59
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 15:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWM9EpPpGUmRuT+rLCcHMvhdF3OYWCy39bhW9EtSlpY81cCViER1ZpdYvIfCA6dh8Exsf3ZRvSu0PqVgktwWw0CFzX3cDsorpvV4hP8Qox8EStHxh5K7fsMoSJIPNaS3khFQZctr22S/8jh0/9Bq429X0Qx7eWCDnpMG9FdzjbvFceHDbUm7dj5IVMzSbHNlbTsUE7jxiO/Isfd5dxhoG8q8wMRrQIe/rpK2DsSUhqNbvUSOThZEoJG3LGtla3wXcLk0gVSfF7TDKI57OMyU+6OujNiKMWWScK/4q8rfqvIuQC7nHJAICW5WcS2nsGqBKZ04QUA1BYhhzqs9kvECww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5AyYdUsVgh/jneh4ofXt5LdnM8AfAiSeutrzgqtzGs=;
 b=f9FIQ/abriMPmeFi7kaUydyC5Tho93IRBUdMoSOeX2rDYRRI/2If+sIitbqtO3Rk0kNJ5CMnW/wh59mFzkTJGiMBL386psU4wuw/5xIsYSL7GTsQGvQcskoWWhGreuPwG6E0wSEuyaPGt2Yf/DSmAHL9VMCdZfcWpPyz2hq4bUx1nfiqDR24QDrBmhhb9i1ZvpO9jmJGLwaJyHEX9yp/wyoWmpQIbhvXFiiNpHmFMiCq4gChBNZkiqHUrNHGWzbpEJB0neazpNexVvzJLG8DF/c3h5WcDPFI2h+WCkc63oJj53bZLWNdZLrRVQWK5zkzA/ojbOAWtZhsqB0D+PtJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5AyYdUsVgh/jneh4ofXt5LdnM8AfAiSeutrzgqtzGs=;
 b=Yz2Wnkum9hoKFmqttwXIn2RNJhSLFmERV/3h1V7cHedF5/vyTBwluOc4/fsFN/b8tZJtcnIhlpNio5U92Wn5IMpz/SHyRsX4S+six0stjfrukloBcy7c3f08GSKQFV2Lz9pG5VkDPUmhTlGbhZ2kMvTgiUxXvWi3uNnhT9n24iY=
Received: from BN6PR18CA0001.namprd18.prod.outlook.com (2603:10b6:404:121::11)
 by MWHPR12MB1343.namprd12.prod.outlook.com (2603:10b6:300:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 15:53:34 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::2d) by BN6PR18CA0001.outlook.office365.com
 (2603:10b6:404:121::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Tue, 12 Oct 2021 15:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Tue, 12 Oct 2021 15:53:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 10:53:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/smu11: fix firmware version check for vangogh
Date: Tue, 12 Oct 2021 11:53:05 -0400
Message-ID: <20211012155307.1059170-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a918dafb-2df5-4523-8317-08d98d987236
X-MS-TrafficTypeDiagnostic: MWHPR12MB1343:
X-Microsoft-Antispam-PRVS: <MWHPR12MB134387AE2939CBF1AF897F2CF7B69@MWHPR12MB1343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9UGj53FdNgVhO8Ml772IZoDY3+uR3sb2lk+9ulRz8nEjE304vTE/Ty2Rqt1XR8ejrz2OEGdskh5enQF5JVh+ojrk5gkSGNCu6Ea8n+EaRBLgL3pWBVKFhxdX40iodaV8GFZcIhaSkqlfXmYHbTHAQxSGXjbEz3J1nmlwzANspb7hMqMhudjd7IU1IHWl//bFI8JmLH/tg0uBLi2YeXEjcBL7M2fZQSX4KvNNXHfwHeKuvRbO1EMn4WaInbV+M4hv6dfinkrhjTSW0W+ATU1gBhYXklDrgq0PPYjdbUMUytkd8QqJSgv6Gv4hAPY9oTXlQSnTRl0eReYXwAibi/hplGbUbJtb0ryp7UDLDeqGGL/HR1xA93wyYaVA9jhkIo8SUCWl2yyWgBNSUQwMQX/I9oK4zKQXMFR4YeOC2Sk5RuY7U0F8gaN60tlqBmzqEn29aRew1xNRwt1aAomF5CccJv2V+26s/EVIM04yC908AmQADbHyKeM+5g49/kl3yYJjlErsgXjRAFeja8n6E/60Lzfjr8DPpoL3+RmZmFjwHU+4H0ofd+Y3+uN/ysoCI5rpI3aNAaxlOc3dc2EdCmv+ZzcC98owHP1UOMz2gBonuJWb/AbYRWLD3Mi7eaNkaikm9yu/9o9KRA0XFc9zJnd6mld23GbNqtEl6pOPZod43lPNrPpxx8+Y+/lEsaxq+GUVgdehYAY9cvDM9smZcfUZan+jwfZ9wtbcf+zULdH39A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70206006)(70586007)(82310400003)(83380400001)(86362001)(36860700001)(2616005)(47076005)(356005)(36756003)(81166007)(16526019)(426003)(508600001)(6916009)(4326008)(186003)(8936002)(5660300002)(4744005)(8676002)(7696005)(2906002)(26005)(316002)(6666004)(336012)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 15:53:33.9656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a918dafb-2df5-4523-8317-08d98d987236
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1343
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

Was missed in the conversion to IP version checking.

Fixes: af3b89d3a639d5 ("drm/amdgpu/smu11.0: convert to IP version checking")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 3470c33ee09d..6d008e9c2f65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -255,7 +255,7 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(11, 0, 11):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
 		break;
-	case CHIP_VANGOGH:
+	case IP_VERSION(11, 5, 0):
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
 		break;
 	case IP_VERSION(11, 0, 12):
-- 
2.31.1

