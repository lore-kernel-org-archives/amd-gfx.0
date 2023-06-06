Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267D4C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 09:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BF7B10E315;
	Tue,  6 Jun 2023 09:17:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 844B610E2F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 09:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2cSPUf0ABgUN1vAomoLAfuljev66DQ9uCAagaEBoknKN1QHpaH2Y7yPLLDbK/dkCt7jpwP6wnjFlss9USX23C9ILrORhpG0NTombQTr0880DuayZZUdKHI5mc/VfXQTqA8u6cvvu7ilNjRsT33ww0hTYrh+6BLjZmag8YoikuvI4L/Oa+yyhtTp0/U8EJoI/6Er/2mknUMbIlxlQceRl1/g/jMRrpxPk+ewg7IzBxHpOiiuoO7NCU2ryp++zC0umuVB9akZ1+dRlgzRZtPh9+i8pFuZedKY2UIaoBoJzh8aKnGKoxQkP5ODm7uM5Kf2w8/0cWRHo3h51VDaBmC9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/ZyqH3jpA+kutmzXbkhTwelwLnlfA58ecCFLDQWA30=;
 b=G6/fObhaGuCJKYpg2LsmxOtcEfiAj+AN8vy8Yzvrwm/r4NL0bTps0wtdI7WPEwQ56g/4rWBHdr9Ti+CQlsmiVeaqSowB5eAU2dor503dxJ0tnelqr5oR6C2/2RwxnvYquCnxbRnJNqGIJgqHksNTO37zun/fTT93WNNtSmogi2am83FVHmsxCpGONcOz3ojrNOp0vUyV3e1wNetpZVoGvflHXB6MwuuqTE0TXWFqgcNEJ4OiCBE1/q9zNx3FmkV1ZurxhMclTBzUwQZmFpm4VgXPbO0Z5HQ9+xv/nh0ccrrvsVdDw2/roj7KsqnO/JY/6WvzDguQn4oY3u9x6YtpKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/ZyqH3jpA+kutmzXbkhTwelwLnlfA58ecCFLDQWA30=;
 b=nESUz1W1H2jkLrzd8S9EzlFiwphtttlPCtb+V0MvzF95E/tfqyAWqFBaPTwHkpdxoqT0CoRL8xWlfLV8L/Y+VMzpYXrjSGaqTSV9OdMI1tVQ5rC+AZVwsJgVNynDgcyBEiaIjrtcJiaxwERYEvgXfJMEO+N0bo7BS1LGRKDB3ao=
Received: from MW4PR03CA0066.namprd03.prod.outlook.com (2603:10b6:303:b6::11)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 09:17:50 +0000
Received: from CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b6:cafe::66) by MW4PR03CA0066.outlook.office365.com
 (2603:10b6:303:b6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 09:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT080.mail.protection.outlook.com (10.13.174.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Tue, 6 Jun 2023 09:17:50 +0000
Received: from kullatnunu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 04:17:46 -0500
From: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH umr 03/17] Silence a warning
Date: Tue, 6 Jun 2023 11:17:11 +0200
Message-ID: <20230606091725.20080-4-nicolai.haehnle@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230606091725.20080-1-nicolai.haehnle@amd.com>
References: <20230606091725.20080-1-nicolai.haehnle@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT080:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 96cd782e-03ad-4b94-5459-08db666ee691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2SGEHrtyN7fIbF8XzlLN5iHiaXqk88uiQQZmMfSrE9H4fjw0a8VBjhHBmpYS2581MV/2cN1oqMxq9cIb5i/qaO1gQwfl6poWbH11/bdLo/gXyr0LbPMco4/5CzWcAUMP9AnzrdjiWkFbx9/XjPBhk64HDaKbqLfMtClwzTNZVqlwBvVXf6tc+pfJHYNkrDzVWuBK0zao5uLTCw5N8AuJrvRRIOOMeQhcq3CJu+zu1n8gybYwrY3jmxrmvWJxwT6tJRv1/ubdBuGnJ7QWDYUjd3mdN7smgEJsQlKBbB4DtFCWQ0qNl0wPVwbrdLMFq2KmTbeJNK+q2D/BTrVJlPi/7zrE74IaJDa8TwmbnBp+1Qi63kj/yUI27aAnjPpHKahGysQG7KGrIgFujKQ0puKHW6GSNhs/afLyDTYorr8LD8SJcCUvkdJC43gU1KMHtiYwbPxVJaa2xhaNONEdZcxo/pD1zkGUtmoxY6blNdxbgeCgS0DvP7ilh1CPkUpxOSTU0/whIFC/Aw/oxFxU3lnOUMRmMEmXxzn4LC1dsO19R8/c/lvQ1kzigcNW2dYOsz45qDEBexR6GTQV+MH07Lj3c4crAhoq6iAGdAn1U2/jXj1JICCyBJxfxaPS6YkaQ5K+F/b7iMCywWPrQvhDQv97gbmQbk1T1E8okjIc3LoaiPL8rInjg3McDHWJ5EZy0lEyVafRJSWhH7khG99ZMlrOss88e/Pua5ulrFYp8AFMbnC8izh/pQtOklHRbvYfp3FgbSBOz5cQwT8yYt752FXRdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(66574015)(426003)(47076005)(2906002)(336012)(83380400001)(2616005)(82310400005)(86362001)(36756003)(356005)(81166007)(82740400003)(36860700001)(40480700001)(7696005)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(110136005)(478600001)(70206006)(70586007)(4326008)(6636002)(1076003)(26005)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 09:17:50.2214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96cd782e-03ad-4b94-5459-08db666ee691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
Cc: =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function has a code path in which addr isn't set to a meaningful
value, but it is still written to the test log file. Write 0 instead of
garbage.

Signed-off-by: Nicolai Hähnle <nicolai.haehnle@amd.com>
---
 src/lib/lowlevel/linux/read_gprwave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/lowlevel/linux/read_gprwave.c b/src/lib/lowlevel/linux/read_gprwave.c
index 86320f5..e861ee4 100644
--- a/src/lib/lowlevel/linux/read_gprwave.c
+++ b/src/lib/lowlevel/linux/read_gprwave.c
@@ -359,21 +359,21 @@ int umr_read_vgprs(struct umr_asic *asic, struct umr_wave_status *ws, uint32_t t
 			umr_grbm_select_index(asic, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
 		}
 		return 0;
 	}
 }
 
 int umr_get_wave_status(struct umr_asic *asic, unsigned se, unsigned sh, unsigned cu, unsigned simd, unsigned wave, struct umr_wave_status *ws)
 {
 	uint32_t buf[32];
 	int r;
-	uint64_t addr;
+	uint64_t addr = 0;
 	struct amdgpu_debugfs_gprwave_iocdata id;
 
 	memset(buf, 0, sizeof buf);
 
 	if (asic->fd.gprwave >= 0) {
 		memset(&id, 0, sizeof id);
 		id.gpr_or_wave = 0;
 		id.se = se;
 		id.sh = sh;
 		id.cu = cu;
-- 
2.40.0

