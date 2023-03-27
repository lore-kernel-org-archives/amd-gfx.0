Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09431C76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB1310E706;
	Mon, 27 Mar 2023 19:30:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DE510E6D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:30:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQ/7AjkjZLnVW2MsIBDD6V48BBiIt4BTPYN9mrskDIIW375UaUQqJc+tEYMBf5QNU1TrwA04xfledNj+DkgnQLFjxQzt7zVo7MBHo7EZ3qT0muUb/NmsVF23wbV22CU4toO+jsvRGrtn5ztZsfenE+7Hidkn/ak+l5jUhjnTD056q0E4LD6IZ+plFAKejVTaLv3OSoTmQBb9QlhZeJpyS7w81mg37EFrK1t8EyMY1ePMphUSSV2gd9cmKwjJHbhMx9u9FiIdV6bbOjdEnDpEs64kjpFIBARBdpRQaVFE4tzDL2UgarlVayuiX7XjiGPtvpHWcyu3Ipcw3ez9wVeqYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Wgo0QXD8q2qPgucCyiYm4h/vy1SLk7DU+2aWnx8Qg8=;
 b=iNGpnOgBQTd5zdVJim50NP3eSSOUmQHhCyMlzdZTnIZuwIPlRz4OgWtF3SETj1rCR60+mo4ZQwJ5jiC7bl8NXrtQrr+iwkUeSRwLwz4gPLnqaANv3LXhNFFYI3UDL0/gvCxM/7tSlXhucUUEhmoyd+JIMTiLZ7jN2c2uMlUqw4gKBAM1QttMcfzN+NmxIMG4gQEVhPccF6DJhsI4URTkcdoaUfxgTkh54VAc5tjeFOd0PULfNFfzrIuKBq0JSZ9uFze6iMSK905izRIp4rRgjsDVH5KzgMyfhbZpRkbOmyk92i3K0faLwnL08Af2DqHOdE8H9z7u9sSxWQp8iU4Pyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Wgo0QXD8q2qPgucCyiYm4h/vy1SLk7DU+2aWnx8Qg8=;
 b=pdAJOr60qISwpcWwWbkPu+amyi05jRzIzqFVcyIa3a2+eHKbuHgBF6E1e2cgN0Zd+xB06svDWQuxf6mNQTh3LmhGfz/kn2UFARS4It8mWtm5NyyAhGpPT03DjS9ModDyOQnlr4J3Cj0KZ0mRHj744678u1QCTmyFC0puKheCwXI=
Received: from DM5PR08CA0049.namprd08.prod.outlook.com (2603:10b6:4:60::38) by
 SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 19:30:21 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::c2) by DM5PR08CA0049.outlook.office365.com
 (2603:10b6:4:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:30:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.17 via Frontend Transport; Mon, 27 Mar 2023 19:30:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:30:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/10] drm/amdgpu: add common early init support for GC 9.4.3
Date: Mon, 27 Mar 2023 15:29:52 -0400
Message-ID: <20230327192953.7756-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327192953.7756-1-alexander.deucher@amd.com>
References: <20230327192953.7756-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c93832-0b3b-405b-3619-08db2ef9b48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1bU7IIZ+TWGmv+c+UZOLi1zu+Mc3c+NeCDI+iLtiIXEE5w6J6bouzttAMTFgttaswWztFL4e4xxmhI4XyoFXC/dcWArmykUrnQG3qJqzvvE1fyIu5pyhhEv3+Ue+kg29mbnpEf5VfAVvtAyF6caGpsryNcyxvUtjJN/jCukN110gkRvJ25x59htm3R8boMhUSsjjv6Gym6OPNwUG6UwUytgbHPOVL3GKfVCyPt0P0E9fZBOggkWeFFnfj3tEi0VN+fmzhwH5ZjlTBasALLKqW297zWkYuOEEghQhdQix6wMELNg6E/7gLKRTvUuA9Tk9JJA7qBLpH8qtL3aOZnBo0QheuIganjAI4RUm9XkwBmcRzeLrFFNwy852+Zlvgd0Kg+rwkrjolFZgaSqNcPtqXpOjWZW3JhOhlS8HFct8zRqSmWh/u5gs1zUA8mYyB/w4hqjl3kVHhYDaSMxlCa6Tb8RhOzwGQv6KvmrK8nOaPrqhLonmZjNvq8YLIrcvPR/gCFxJwuriBZzI2vHbH3RtxU2C0GXHaGmIv+oC9CGrMRxEU5RExHdPXDM/1S9aWLpwnmX14NWgijB2TkDXLgi3AXjxE52gGO/tq7ROA11aDqXijOgpfK14So85bOc0lKP2d6n5V/5rU04AVfL4XXUqpAkracUTterEUf9jGbkaGRqC6OEQFVr2117Yso7MjQnt1IhqJb07kzacv9JkzpTch3QNAUbEo8d/wh7gfMXNf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(36756003)(2616005)(426003)(40480700001)(41300700001)(70206006)(81166007)(70586007)(86362001)(8936002)(356005)(82740400003)(8676002)(6916009)(4326008)(40460700003)(36860700001)(478600001)(7696005)(316002)(336012)(2906002)(186003)(1076003)(5660300002)(26005)(82310400005)(4744005)(16526019)(6666004)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:30:21.3229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c93832-0b3b-405b-3619-08db2ef9b48e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

init asic funcs and cp/pg flags for GC 9.4.3

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7d04c39332ad..d760ef57e421 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1101,6 +1101,11 @@ static int soc15_common_early_init(void *handle)
 		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
+	case IP_VERSION(9, 4, 3):
+		adev->asic_funcs = &vega20_asic_funcs;
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.39.2

