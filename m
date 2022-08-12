Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C0CC00140
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Aug 2022 02:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A438CB1D12;
	Sat, 13 Aug 2022 02:13:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F21AC64C
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Aug 2022 02:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ir9zk4ppZnRiNvtbDQAvCUMIobl2RLq37ebMF4or0iMDIhtRjwS//m/t7NoZI1L5+nEE6Kl12QgwCLUQcn/g/q0QJBIcS+a/LQgG5K5ze16UzcWACVSg7+qU/P/IfAlg1kk1h9qwPuORhyEIFkIhlXu1ZW63eGsrmLiOT/aS7BtA7RZluBbnYeUhWptICQ0AjdzAwPwqRDlYvMsllM3bnUG9jD2sAjnXcXUZVkQmoIhljWIUOMp6g93lUF52H5y6mTiEJqi1p8se3qdXl2RQ0QlN2OiqZDCDFPotdxg5hEmtu+EX1Wr8XE/F+LsDpHAXH1ytJjzqLQRCgSd4p7Tccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzf1cBBraX8WQPe8SvlGVd/bZkDpsd7qFzN/PBiUAhw=;
 b=hUjuJoSWEW9yCZXUgDYbsKsVH+YjKX8zY0Imdo9Ie+9t15rqvzLLgHzfQkRDz4sRecI7Hrr8mnyP6iA5wNjttRTv2jX8H3WyGIgvSyLRE7ZBzlj2mNZ83feFYdO2NQZRMLrGyRBjBnlLKEk9GnbHUsDj0jsYevbhIqAB+toXN2yLcAND7plXOxzVmsp+xWCeBhkC6xoeKH0R6VNQi5AipkHOyV8wyovjXTiW8C9ywtj6ocvGXl3Sl72dTo/ov74SghkWcTlpgC1N68nB+brDDAuGjoWYeiX4p+WKNHVwOoR3VlzL2KUzznbwocQjYEsVuOaNLRTEKHA7ffQXgTAshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzf1cBBraX8WQPe8SvlGVd/bZkDpsd7qFzN/PBiUAhw=;
 b=oFC7/mvipY0zWHSv29YQ3E37FpnQo4wH2Tyb2hGdK1dWLYurJ5Fx9YMRQB/TwUyU5HvXoYxLytHAu3vPan/wGz0yN2DLVc8F5hlCmnyDUshaq7b7d5ksP6polK2ksmKTrahH4tRBW35uhJ3aofhpSOQYwbsnG6nH0T0Wh16KKw8=
Received: from BN9PR03CA0107.namprd03.prod.outlook.com (2603:10b6:408:fd::22)
 by MN2PR12MB3374.namprd12.prod.outlook.com (2603:10b6:208:c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Sat, 13 Aug
 2022 02:12:53 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::3d) by BN9PR03CA0107.outlook.office365.com
 (2603:10b6:408:fd::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Sat, 13 Aug 2022 02:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Sat, 13 Aug 2022 02:12:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 21:12:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 12 Aug
 2022 19:12:40 -0700
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 21:12:36
 -0500
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/14] drm/amd/display: add chip revision to DCN32
Date: Sat, 13 Aug 2022 06:12:14 +0800
Message-ID: <20220812221222.1700948-7-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812221222.1700948-1-Brian.Chang@amd.com>
References: <20220812221222.1700948-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a9404b5-8ce0-45c8-1dd2-08da7cd1549b
X-MS-TrafficTypeDiagnostic: MN2PR12MB3374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2xDAPO9C33D1wlWWfAX8wTvIShLPZ5no6/SRZ+4d8JE2J4VzF8yELXH+kAJTuDNrwMJZi/Fv8XqAMb6FHaXR6mrbzFl4Dolgj5id9Wr2CcCw/qOGUpNb4+DXx+PEpURpT2wQFfnkgE/Sm/7BmXwhRqi1Jyk04GEBwQvp3YxEqHn6uJyZLzV5wyAl8wPesAqKP1tiPq6sKnOCEpfpJjioLhi11M2mR6vVXrFUtWASzRaFzuMnfEeZV99UOi6LfGwMiItHWA9CfZRlj+a1Xi9+k+Ie3UezzTJ/mmuMnOrBq97hTyzsIz97XD+k0/OJbobkGCn/kBnYBEoa4nd5+9zAz6jS3LK9ypUfi296YKVJwx4w/vthZyuIBlmY0Nxe8SuwPZ53xu6Ydfn6e3zSxDIaAWacGv0N9HVIknD9geHzSYFHsYzxWmHl3OeSeJDz2uCiWUHgl7goPmuJC9tpTDOMteD/kHojLT9nFz0IaqBzlWvFrwpwvhP/HKLeeBSd/HSU6GNnjFzLtZYbgtUkxJBwZopuXxSTFrWiiu4fwJQemkHuGmoGHUErd4arC8UW4hWckfhBYmEQWufs83ryzFNBUwpktt5gJztbHa+ZFTnwPDo+Y5WYMAATY+IR4tlCogZFrXln457jJlIObsQQ7uZ6CyZnKoONCII73DgR9TKvRCV/X6MSTcwMnKsIKU/UtkTl6i8V3ONu4gIRIkddPT3FknG/ge6vxsjwFXWdi07Vum9bJyXwlK2Jp0G+X1L5az5FxRDctuxGrdMoFeRWWZTqitjy+jkl3c4zyht7PmKWXgP7cTbKovpE7x0jMc5ghe3QBoNuZEt30zko3s7f0SPYPpWzNwtsNT3A37HzvXd5BE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(36840700001)(46966006)(40470700004)(81166007)(356005)(70586007)(8936002)(8676002)(86362001)(426003)(40460700003)(6916009)(4326008)(54906003)(316002)(478600001)(70206006)(47076005)(186003)(5660300002)(336012)(7696005)(2906002)(6666004)(1076003)(26005)(2616005)(36756003)(83380400001)(36860700001)(82310400005)(82740400003)(41300700001)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2022 02:12:53.5026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9404b5-8ce0-45c8-1dd2-08da7cd1549b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3374
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
Cc: stylon.wang@amd.com, Brian Chang <Brian.Chang@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why & How]
Add GC_11_0_3_A0 as a chip revision to the DCN32 family

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Brian Chang <Brian.Chang@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e054f3494087..9f3558c0ef11 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -247,10 +247,12 @@ enum {
 #define AMDGPU_FAMILY_GC_11_0_1 148
 #define GC_11_0_0_A0 0x1
 #define GC_11_0_2_A0 0x10
+#define GC_11_0_3_A0 0x20
 #define GC_11_UNKNOWN 0xFF
 
 #define ASICREV_IS_GC_11_0_0(eChipRev) (eChipRev < GC_11_0_2_A0)
-#define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_UNKNOWN)
+#define ASICREV_IS_GC_11_0_2(eChipRev) (eChipRev >= GC_11_0_2_A0 && eChipRev < GC_11_0_3_A0)
+#define ASICREV_IS_GC_11_0_3(eChipRev) (eChipRev >= GC_11_0_3_A0 && eChipRev < GC_11_UNKNOWN)
 
 /*
  * ASIC chip ID
-- 
2.25.1

