Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B77C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 09:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3776BA39D3;
	Fri,  5 Aug 2022 09:45:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7CE2112EF3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 09:44:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6hA7tKPzqdwwBnVeuEWNUTu8OpQB0sTKqg5121bm/mKNeCZpOugFQ4tSvWsQHhDuDD//VO449fXkb3qDVrrC4eVY51myPWLro5gXk6yShJ53/92hl7ZFYWD/0Hut7kuEacmjH/9H1eq5YV8qhIBaokjJadea7gf6ujOYcXMSVpvtdL2hhri2YJ3dKLgcxCIJCvJju1ApM2BF7vyFDVPi/XoTVxXJh6sxkEpaTBUQHyu0JXIxwpf8/OG5a8wO5OqX0RoGYzPXbI4qeqi+PiiFDk0cpe6OJpWYzUHUgZR5yxUJwG01VTjcbJ/mlChYyTVg7Zv1eKsOBSAUxIiVZs/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyyWAVtICT1hzquEoenFwe8HWanTFs4d3hMz9Ic6mcQ=;
 b=P8JHuak0N2SjGg39/XbyJChpUbORVk8ZGOLcPXJedDl6vULtSncvEDEsnWn0WaE2rYv6n4sgCbbkbDEgB5YnQ6tHl3LXMTFC6pulXlNJDCYYltIOkWG/pXTvPNDScJkxXSPRw8PBdlCsh8p2u1eJvAqunrsm/Kw9HEH2GlX8YZC8YwFAc9IkQ1S+v4dLUVB7FWlgQY6uF3l6qayhsCE/1XTOp4KbgLCO0IRAzmiWwT6+fgcjzwkn+wHY1JpFFdvEiNBBN+pPukyb8/BCbRNIDhr7i3lMAeGvbxY6F+2UPzVhIUg0pDIL21+2dKbZOlBZkoGO067H82rmvDpGm0CY7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyyWAVtICT1hzquEoenFwe8HWanTFs4d3hMz9Ic6mcQ=;
 b=zLcZmacSJMkItnS/GRqQe8FwFGUJNWL7qWmVRSoFkBVN0/RbLn/Upac/Sk995t1kh+5qVKdJoYgGSv2SzaSUje/nIVa3ClSjf50KysM3KRQWTi9AOaTUCTE9olcHlmC4gFM+LVpKMThs/kVCUfJUfEqoo83zxVbnEe2x8itIKF4=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 09:44:41 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::fe) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Fri, 5 Aug 2022 09:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 09:44:41 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 04:44:39 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu/pm: update smu driver interface header for SMU
 IP v13.0.4
Date: Fri, 5 Aug 2022 17:43:49 +0800
Message-ID: <20220805094350.2665868-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07867fe9-f537-4bef-2aa8-08da76c71f04
X-MS-TrafficTypeDiagnostic: CH2PR12MB4908:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zK5NlxnVuUMn+oJFF+Ii3bYRGj5nd7vB9ibqX22pu14E1gSsURdR/dmj94uLobxz7I5yooCYu0TuIdodHLKUhqUUvOesZlw7epWDiiNOB6c5Mm2h0D7ubTpnjchBhi6lfJnuBBb9WgDItlIuahPEGObYLzAiGuuinVXAC/1BNhCnrvvyYtCkjgAkI4H8GguxP25Ev8nqSEdWpJxanPGgNCKs6TIkk8Qobz+AlMKvY9FHKiKElQDVyizdpIYhHgnFFUOK9hdIPaqwoGEZwhhE98NJ7ewiT7ZR9ekt5I6u+6QwkAGIbSoHafCp8My/uVFLQg6IiLwpji9zFF28SaDf7PyIADMKWVaYyUBDAh/PcYzYap6IPs/8a/jQGXy9Whk/P/Fl1nufskpYiXmiDNq2voFjIvXRbn65Yr7jhR7iDtFDDPRnatvwQqkianLkW4hVOaIP2th4BnsefvUuMJPKaeLkndHn2VvUYpSRRtkuR//bjNq6LJQelB/z42vUunWSJw+VToAw94wD3ctuqt1mZPWBJD++zwJC9WEP2/N4fJ7qgqAIn3EufuYR1MJdNfslozhoaxo60kuJUWxDH+6MPn0KG1V0GjP3zEDYVf6ITn7chVLarwiP3b0RVh02KAAEBHqfaehncP9w/DcHHQxvPXGZScuxFrMhvRmNXcobQSdpHwlDF/mE+Z4YCouiQu9z/LQ4QIo/99dCKEMA+vIv+lKv7EVRwBBPb0ctbFihaduVv9OR7cq7IBkvavwwOg4a1c43GNUJiAeH6rTdzVhedddvKO3eSFOGIa2ZPAamADzJO3IjzMofrlt4po6+xlF3GKqsXKCYhF9d18WwVqTC3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(40480700001)(86362001)(81166007)(15650500001)(44832011)(82310400005)(4744005)(70586007)(82740400003)(4326008)(8676002)(70206006)(6916009)(316002)(5660300002)(36860700001)(7696005)(47076005)(426003)(336012)(186003)(2616005)(26005)(1076003)(36756003)(16526019)(40460700003)(54906003)(478600001)(83380400001)(356005)(2906002)(8936002)(41300700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 09:44:41.6189 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07867fe9-f537-4bef-2aa8-08da76c71f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the SmuMetrics_t defination and SMU driver interface version.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
index 76f695a1d065..ae2d337158f3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 4
+#define PMFW_DRIVER_IF_VERSION 5
 
 typedef struct {
   int32_t value;
@@ -197,6 +197,8 @@ typedef struct {
 
   uint16_t SkinTemp;
   uint16_t DeviceState;
+  uint16_t CurTemp;                     //[centi-Celsius]
+  uint16_t spare2;
 } SmuMetrics_t;
 
 typedef struct {
-- 
2.25.1

