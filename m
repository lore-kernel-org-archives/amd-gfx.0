Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828ECC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C86AB10E88E;
	Fri,  1 Dec 2023 13:29:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEABE10E8A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk9T5eAlTvpkuzWa2srdABWHNsNHubba+gNcPjH/H0f9RLkuiRtkOODpw/w1Aj+kn1BKZWx99kv3a3rHW9+OqTS+gLCTJjvUoUiacoIpusFhJHrQtFElr3ww/HvNEfvEnscEEEHc4/t1IToPDZgXfgFVDT3feW7ihM6rRpBsLUnECZotXvtOWxwaCkEvCqgdmejd6I/fA4EMUSd98UjGBs8SCvBpYuJfADvhK0dBbi5T9RySMCEM3f79wLaqBJFlEjgw4POUqsaHS1BhHdmtjTxAZbO8RDGuyVReaoyIGO1kRZmjk/LwkDW9sD512fJdKT+8nCZMoupqWmbfOMv5mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfGgy3TRN1WX5jstpaiMPhLbFRlgKzsNkWw1upUGFSo=;
 b=QbFihObYtvkp8bE7Wj3tjESr8s6bSC07ERic/30bpJLeP6hhcOKIceRZOr3VelBlMGB0fKVjxirDUwuD3zWWLC/2EY4Hjvl5W9TUunlieC1OJdO0bEk5Ik2iJoxWLCif8AmapA61Iq2NI+9uJMca85gqtiMhnTSRDIwdcyAmoZvJq2tRK+hDvLODSwlqwWiX6tdA0moom9hHDkedf1NAhfKwlRtL/DKfACKU/qmBtMwi78Q0BMp3yKd1AztpEFEFlf0HzdH5igWuw9joJCbj3DCfnMEB7YLX/geU1i9ZLyIpRAELhL81Sg9SrqizNynC6GncJSA47ug6K9wMRwaR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfGgy3TRN1WX5jstpaiMPhLbFRlgKzsNkWw1upUGFSo=;
 b=UvHvAGB4R+86+xnhlKK7yLRueS0ZB6e/WiA0ohbgXOf2h3pgghXBzMeejpaSlQMLp2sKyl+GEa3eEToFf3QUKghzUJk7n8f9hHf7W8bMSEcj3dAs48Zqbdd8H3CSJOC9oZXcMfpmKYVi8md0+NFWkLdR0/JEOeSWpYUXzVnLnYM=
Received: from DS0PR17CA0006.namprd17.prod.outlook.com (2603:10b6:8:191::22)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 13:28:38 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::53) by DS0PR17CA0006.outlook.office365.com
 (2603:10b6:8:191::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:35 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/47] drm/amd/display: Add monitor patch for specific eDP
Date: Fri, 1 Dec 2023 06:25:16 -0700
Message-ID: <20231201132731.2354141-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|PH7PR12MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 139c47f2-1880-4da0-c7f3-08dbf2716d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIHW6Tbhpekxnui8VHIpOnZi4QV62ucImFNbu+K9KgEOxnm5wkDAFK7nhtO08OxP6MYmxtM616Du/4QtnvIv1ABTzWBQ/Bg7A5wuPZUo3aeBdYlvYimGEMwMz3r9KH4KPUXa7KuahJUo3UnI/j7HQuuGd/YSIGlKlKjff3BuMMDOsi6PARTsX8NHU/le1as094jKEw5/MVUgUP6crw8/8LyNTyWnmzEd3kkV6S6vnJbeHnTjk6v4Y4g15GlD/cgAMmmshwqR6+KWVLhNUch81Bu4dLnlTrBN97eO4bZhpA39ppqYgvrXi5kYAa5iU2VzKh6ZmoYauuyS5DM2qrNOZ4QvAnSyqHbhu6w3yTsXzz4I6nFxW9zFmSw8DmKOPxs9vCMiLl5zeCOZP2T2uPvFye7G0LYhtibXA70svntRA0xa2pUVhEz5BTww6DnKVFN4jwIPCI7ti3B5wvjdozuaNKNoIPQElKWisU/V7H4ZR8R4wyEXJqZIdhEOalCessQSACI3G+KYeONeMNMMLO0qJhYuXjwRUmzLsr3F9yaFMsbSSctwVRes3VtWYku3JRMbxCya6d9KR86J96KptoV4/3GDiamztesSLtcG2UDSNp21+WYEQoXKeJrN5bZL4T8jyQozBiVPb2WDEEO/qABglhpHU6Gn/GmOr6+MCtRn3m/ponYMrH9iSQsjY+AIePRBeZ5NCFKyMrvv9Kwbe/SQylK441HwLlG0iCust5Hzuu2bvBQDcZRh91RuRp2jCdEHs8MKR6UB4d0cF0vbCWlk6Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(26005)(40480700001)(40460700003)(36860700001)(356005)(82740400003)(81166007)(47076005)(1076003)(5660300002)(2906002)(336012)(16526019)(426003)(6666004)(2616005)(478600001)(70206006)(316002)(70586007)(36756003)(41300700001)(6916009)(86362001)(8936002)(4326008)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:37.6269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 139c47f2-1880-4da0-c7f3-08dbf2716d00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
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
Cc: stylon.wang@amd.com, Ivan Lipski <ivlipski@amd.com>, jerry.zuo@amd.com,
 Sun peng Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ivan Lipski <ivlipski@amd.com>

[WHY]
Some eDP panels's ext caps don't write initial value cause the value of
dpcd_addr(0x317) is random.  It means that sometimes the eDP will
clarify it is OLED, miniLED...etc cause the backlight control interface
is incorrect.

[HOW]
Add a new panel patch to remove sink ext caps(HDR,OLED...etc)

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Ivan Lipski <ivlipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index e44ba5c1c48e..d3966ce3dc91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -63,6 +63,12 @@ static void apply_edid_quirks(struct edid *edid, struct dc_edid_caps *edid_caps)
 		DRM_DEBUG_DRIVER("Disabling FAMS on monitor with panel id %X\n", panel_id);
 		edid_caps->panel_patch.disable_fams = true;
 		break;
+	/* Workaround for some monitors that do not clear DPCD 0x317 if FreeSync is unsupported */
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xA7AB):
+	case drm_edid_encode_panel_id('A', 'U', 'O', 0xE69B):
+		DRM_DEBUG_DRIVER("Clearing DPCD 0x317 on monitor with panel id %X\n", panel_id);
+		edid_caps->panel_patch.remove_sink_ext_caps = true;
+		break;
 	default:
 		return;
 	}
-- 
2.42.0

