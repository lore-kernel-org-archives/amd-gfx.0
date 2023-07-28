Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C3FC0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 19:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CD3910E77A;
	Fri, 28 Jul 2023 19:16:13 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2040.outbound.protection.outlook.com [40.107.96.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E0210E77A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 19:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGgkpMz3bAIZQpmDLZmvoErW3ZiffvAXZHWWvgU6UFqaJo0g3/xwdDqlEUcy+UGXaCx56NkqtSLUE6TSTM4Lj9aAwjy53QTwonuSTofXUYS4OKZgQUeIkenpN4Tra7XiIifXP7t78vaN9lUqTgVlznX5NtROSlw4Wct/2x7gLQVgAc/3mY59WD0MPQYbM3kIrXSRgeFngup92p5GHir8GZOB/J7VCrRsg/C040x8aiYVWKn3Kzg2Rf3tjzPS+BqCEW4PaOHZQj/j6zMhLRPFBwR3vKfSjmKovBfywR5+CXsFj/bTe6z4apHLSJCJDYuDzFYxyFF3/bIE3CivzmEgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=mwvVFIAwq7Vfej3nqmoIcS5nbTcRTrWxxQGZkZ96JhWCD+ZbY9GfSOjr6eXJheOomRbiQ9KPSF66tPiJpc6dUx6D559umWUnY9lvdgcwOvs5extcf/JGbxOvSIzo7osHpFBqa85gWXCASyTHGpxUZkMnkCrjWkg5QnGiQZtseHkwYKfDB4Uo7fQ0r84P4ZkPt46TnfaTnftrUl1SjdlBGm3qBBP8XW4gQBmspWu2t0XN02KeGCCqJTNUJGIff4yXnURd6xASWUA4Xze9Y2cNJRK2sKbfXVT5UIOZHFO9iVGrlAYftXoUevgFrJBnr5zCbIvzM1yO3zYyUFVyBv+Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvBKmCbhYtTor+74ioYXQIK9BOnnxLuL6DkvSVQqqmg=;
 b=e1x5slSS5wFroceKkW/nTXilg+M+3W9aBIiVeKTPrOqPGe4H2eavEsZFZgeTDs/YKeATQN3d6MXULdYqB+4lxvu4DxZbalrilMK3U/ujtVRBGiP0effx12t1h7l7P7DfBSRF0+d4ODCawAjx7c6FbWGFwZY629ArarZnpc+Sl70=
Received: from DM6PR06CA0084.namprd06.prod.outlook.com (2603:10b6:5:336::17)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:16:08 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::a2) by DM6PR06CA0084.outlook.office365.com
 (2603:10b6:5:336::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 19:16:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 19:16:07 +0000
Received: from sdhume-SYS-7049GP-TRT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 14:16:06 -0500
From: Samir Dhume <samir.dhume@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 2/7] drm/amdgpu/vcn : Skip vcn power-gating change for sriov
Date: Fri, 28 Jul 2023 15:15:36 -0400
Message-ID: <20230728191541.1778424-2-samir.dhume@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728191541.1778424-1-samir.dhume@amd.com>
References: <20230728191541.1778424-1-samir.dhume@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CO6PR12MB5460:EE_
X-MS-Office365-Filtering-Correlation-Id: df79a11d-058c-4c62-7cd4-08db8f9f187d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ncF7prLraK0eY4gk3MSgfChmsVHV6ilfm+tOf61ng2XcnGv3RdYB8ftYeY8xGLlndbqKMpMXLu3TkWzG5ZL4W1vfHlnpJqyK/NFrmY/NEroSpfzDVyuywXRtxCk1/H/9NC6xkUmiMuWs8CDomwYhwEctoR750MfP67dpYnJxG7Ob4nmcUPQrbgEx6YhBkiFrf1U03Cn0U99ARWN5WCq+yym1vTnQkPhmNOes/rrZc4CG9zkYDwvlPJbJYb4ymCRDri+V+GwXKIrUnUkFV8Q5XPAZu38H5wOpM0m2QoBV9aet96ro8gCzkk4U16vBGDfbxmbjpaoHY2M7ffUjq1An8Lz00WiJloCu0kL4vt2LJAxsw5g7XMoI0/dJfSmxCzvPFmGSlc5FLmcd9MyjO13SFeugl4MC+GpRIpEb4Hp7r8zbS4Qt3Fy1f40QZi54lv575lkt7y+jC2dt81QfQD5nFEHqbKt6mxoP6PyjSN7PIG0oLyI3Priw/AFrKMrWmwRLBHzGXG3NR7qH2UJUTtOWiPp3Z5olGe4c/ri7NdR1MfbymRfvrjLVrA/8Mo7/fTpQjsuoIe3HLS/iYtMTJxCkMuo2m7N5gzvqM+SSsGH/IYRUsRpaDDGOIeCWaGNlEz0hc62jhMAIPFREk7m4BuGpYKa6tqqqonGU0flJNorPWzdLrA41W/o1ueyF9WQX6CRxYkFUXvBQiQtSr9zUJC3gDCfCkjhQIuGj5vLvBZOXXNzTjUaN5GuvL1OXvU1FXQbhjyIFNlxcdn7/V3/W+zZcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(478600001)(6666004)(7696005)(86362001)(8676002)(2616005)(44832011)(426003)(8936002)(16526019)(54906003)(5660300002)(26005)(186003)(2906002)(4744005)(41300700001)(36756003)(81166007)(356005)(82740400003)(1076003)(336012)(6916009)(316002)(4326008)(70586007)(70206006)(47076005)(40460700003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:16:07.5725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df79a11d-058c-4c62-7cd4-08db8f9f187d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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
Cc: zhigang.luo@amd.com, guchun.chen@amd.com, gavin.wan@amd.com,
 lijo.lazar@amd.com, Samir Dhume <samir.dhume@amd.com>, frank.min@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Samir Dhume <samir.dhume@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 550ac040b4be..411c1d802823 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1317,6 +1317,15 @@ static int vcn_v4_0_3_set_powergating_state(void *handle,
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int ret;
 
+	/* for SRIOV, guest should not control VCN Power-gating
+	 * MMSCH FW should control Power-gating and clock-gating
+	 * guest should avoid touching CGC and PG
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		return 0;
+	}
+
 	if (state == adev->vcn.cur_state)
 		return 0;
 
-- 
2.34.1

