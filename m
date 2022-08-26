Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2AEECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 18:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA6510E052;
	Fri, 26 Aug 2022 18:46:14 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999D10E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 18:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jvj2NYPoDH2rKh+ra1b3yIFt+C9BkJ75lg5IizZkljeJjW3RtD2m9HGQBcvbGpZoC2zownep7vhJwMoLK+c4hwaG4xzmtTGtcCivEFEcUJlfhRtKSvrcxzQFcjz23YfO8Ke6xSOv8plh60xGWh1O5GtmXxxxxwQc8m7Kprz8qS6965SH9Yynol1q8e6IAD9JYnYWaxe49iJE69Aje5XPl7HK2r0sTAkZgAR78qHP34ELtUNn86Qet1/QqZknUIDomfnzhR9WoAJ3O0anG+Df3oDdtGbX3i09TF6Jo5hY9ubI2GHTJkQo1nD1C+bcNw90dvyABv/8geDNT3P79IQ18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2azTSrzehcKE+8eXFAC0kqs3IcIC1foPXaWomjDlt8=;
 b=TPaZFXFpK3A7kfK0MuYz6R/6gOIvfygqIC9xciLgj9gQjyrcjdeLqxzhosjrZUFQnfkA7PwcpQy6/IO/AFfwarZml5CoRoiYb7pzriLOq86QknPl42DYQUW68oTkikR0HrOjEbnVj8QASX/LTrpswZspWp9Cs/exIYHXWIxasWVT4i/L8OYig5i8kfKN3oX8yiRjUW7VAkCA59wywMzGQXsxDKszdMsXu6GBS2mMEkZlfSqr+T5ACOEMETDvdP+waP/0tPHpgXcvDdvgpnBALEyXcZX0zsc6LdX0+M7vF1Ept1LkYkErgc7zkYBvT4UCugEE3UZK/wxcMmqfs/ywCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2azTSrzehcKE+8eXFAC0kqs3IcIC1foPXaWomjDlt8=;
 b=R0EDEcHXLSIWyG9WNNxCW63IGyUPgYIlAdwAjyqz8V1obfdk3XLf6DjNJ29TWDSXjILSAqfcsjy8fg1kMaHtniNDhXVmVu3tKo4SJdLc2KZtFPs7CxkYrJUxidRCS0QE6LfZZ2vGjFlQ7I4LUd3KQ6ov9pALQWx3q0b2NcK15Qw=
Received: from DS7PR03CA0142.namprd03.prod.outlook.com (2603:10b6:5:3b4::27)
 by CY4PR12MB1861.namprd12.prod.outlook.com (2603:10b6:903:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 18:46:00 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::29) by DS7PR03CA0142.outlook.office365.com
 (2603:10b6:5:3b4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Fri, 26 Aug 2022 18:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Fri, 26 Aug 2022 18:46:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 13:45:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: add new ip block for LSDMA 6.0
Date: Fri, 26 Aug 2022 14:45:43 -0400
Message-ID: <20220826184543.855686-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220826184543.855686-1-alexander.deucher@amd.com>
References: <20220826184543.855686-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a46df546-2997-44f9-4283-08da8793388a
X-MS-TrafficTypeDiagnostic: CY4PR12MB1861:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztTU/LSqT7to8Bozy7/Ug7cGsSTzpGh+qu2F+7eP7NArIwZwJRmp5qcWIDkvgzuYYNvgO4AM4lFhpC2p5bOX42XJkUl0Wur/HwY9s/zHo55ISVJ3n/Y3cE+h0rqrVdtEjCQO/GzzgWSb0PBHPW7mtKIscY3BRTVNZjHKvc/CekxDwo4RVK1Wy+9zYB5Ef2juBQ0E6iAVyvFWG1P7NTZhGeBl875vlQek+JeOj5cFrQnJU6Uz1x2bPyLfIcuoFKW9G9tsCZKcUnW2R8WWfQ4gY0ipQQhUJrogyeqmkQMld1pGNBSdXYZFm0j24gEml2F8VZfcrKInaL+b7UyhyP8Qx7uD+lvZiFuXJtLf1b0sj96ixyG87YITnipoul1yxYsFldc53nyxknTtgP6RDOQFM2BiifW+LyjrnOpClau6przmSFKFtLanWxmok23usr3ZezRFRYACgedlOm2JmvXL74Tty7KStOYVSh+HJQs7Ds3WeJze0QYD3yh5LXSGnh32X51Y3dwQCJfLq31IRZUdzIMxFixPF4hjQtkWjkz7FRufhkclmRAPDts0BLSM1pwWK+9SP8jIzxVsl/oGKhpE/DuTQdHLkaO22rmDCU+mTXkIv60mCo9vdrZ35ZUAjirdSUJBlKvnL/xWAFk4YKPo6BRT/rCqkiuREjYtEXvKwJS4xCliV5pKOPZLJ1fLdTaiFDsn8ZBMHDtdGSmLE1x0Zh1g81GhKMOwjy16//9nmu7UFz70SH/W6LhyRv5xhNiSxz9WvNkIq1p7+ufY4A84OrjaVsLpPs5Rj2d01Gx0/Qo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(46966006)(36840700001)(4326008)(6666004)(40460700003)(186003)(70586007)(70206006)(316002)(6916009)(54906003)(356005)(40480700001)(81166007)(478600001)(8676002)(41300700001)(86362001)(426003)(47076005)(1076003)(2616005)(336012)(16526019)(8936002)(36756003)(5660300002)(82740400003)(7696005)(4744005)(26005)(2906002)(36860700001)(82310400005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:46:00.2998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a46df546-2997-44f9-4283-08da8793388a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1861
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Frank Min <Frank.Min@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add ip block support for lsdma v6_0_3.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index b5c979494c55..709fc61e3305 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2336,6 +2336,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
 		adev->lsdma.funcs = &lsdma_v6_0_funcs;
 		break;
 	default:
-- 
2.37.1

