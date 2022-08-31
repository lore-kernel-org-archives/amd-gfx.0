Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2FFECAAA1
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 00:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DAD10E17E;
	Wed, 31 Aug 2022 00:56:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80610E17E
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 00:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxjTk7JZ8s+QBH6FJtPNTRTGw7TS/nQkn3Z/p2Eeg85KgDei6avQEHKeM3djdjQsXRRjxMZ5/DfW3aqKWoSbdssHkKTVKzCC6PGpCEhU7GAhIPwMqH0hc68iiMulvm9FsyvFVyQ7n7HXNs7Pw5mZJdhXeIV6Kx85FAeZqqJnsramQ1LnfWQj1KyEL/R01nhV76K0yN/xd9hv1TgWxc1n7Da7z4MP4EHGTIa4TUktpPxb+n3SWqUZHj+rvmAxJQOHoClzVdbaJfvBqoMisr4uQ3X7srSQ5lb5+7nJ8Qq01k9OAxkveMH09iT/ITIJ8W6RK7Fn5qawg6zIaGYXZ5QLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpfPPY3I1Tqh5iXX1UfkylrEYjs8Ehvq9grqB5EsJCU=;
 b=JT9lGDCJUSpqvq7UDJDNlZCPxuOZCsWZ6e8Bev8jrtY7dvS305DrP1iHtwDskJ+4gJTzhUu+8nc0+2l7zzcuSzClMN8kDb6CNSoySkhVmr2WhwIrIV2A3m891FUSE0eXjOv2aXhwoSiIe5mj6UGZMlh/1kkrNYVfHP3cWhWkfyS/5f7Xni6SrMdGNfJGSepHkg+BXGpgRMZmzlnRoNqVtiznztPNSNdA9B+vay+whiOdZiuXpTBvywWBS6cnhgpm+oRW7vSvo3h23NH43loW2u9l7oAIZJtxGxFHBybEm/zyp3ixVA/jVRQpv0kH/win9UlR2lkUP2+Zt4RkKGChqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpfPPY3I1Tqh5iXX1UfkylrEYjs8Ehvq9grqB5EsJCU=;
 b=WHnQ4j81vdnX+ODSm2DfxxZi78q/GLifIiK+i6JN6fRSulFDX3y2gmPjFqEPycFLLylF3BXeG0fVVY0SR0npmEV2ZMJU8r2g5Ejld1yk31r+P9eenYmHmGWfMuIBuLoNKeouyDd2PJF34D0nVpocLawCGxTaHUYwcH6Pohxvm7o=
Received: from MW4PR04CA0304.namprd04.prod.outlook.com (2603:10b6:303:82::9)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 00:56:26 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::8d) by MW4PR04CA0304.outlook.office365.com
 (2603:10b6:303:82::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 31 Aug 2022 00:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 00:56:25 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 19:56:19 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu/mes: zero the sdma_hqd_mask of 2nd SDMA engine
 for SDMA 6.0.1
Date: Wed, 31 Aug 2022 08:56:01 +0800
Message-ID: <20220831005601.3567776-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43e9b0d5-31c8-434c-0c06-08da8aeba19c
X-MS-TrafficTypeDiagnostic: PH7PR12MB5734:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zHuk1xmbnwMK9AbY6mznNmSjkR1evN3v+RkGjzlWalsC0kfOws1n20UGXzIy0GF49gNG0iEeaPloLYXl4AF6BYAzKb4XTK/LuL4/J+JbS0fE620Cx+0IiY0Piktd7830W2Qn0TdxbyOyCRrXiT7667Ub6f2gzOD0bARjmF1KPPtwk4dlOTVoGH9YGNAheG4gq815jlVvljjiPwZh+AZMfnFd6HiCWub6SuBEUUwTCCYamB0V2g74zPmRsb2oMn8tJjYR7SOzXpK3+KQz5sgM8b9QQHhi7sRINQ8peD+0XU/V5sPV5e2k1F2uW8WB+Qyo2+8WeaLvK9sAZPq4mHr+mrvpBdR4Xobf/IMzfmiTnGEEnz5H+kHAWmYeWPJQDrPoxWvKtnD3z7G0GMNcUiifqEPToAuaX6d2vNJqFPLAFPA7Y7zoWA60mIson7SkpRiqwJ9lcu2lNTj+IB+U2NiBRo5TFd4C50YKA5W/eWy4xO+FwXGVBigyc0CLR7mz/uUtahHej0pWuuo50EDm2nRmr2GdMTgTLzhbySYlgVyXjX1GrB1la3GWGCt3FA8tX9hAwLS1lbUPneuusb50IOfMp37tZT/FBc3aqc/rB73Ql/LdC1jVGZ9+OcdZggp+TgWz03RK5OvZe7ZTU+U1zHznGr73ChML/lAUBKubzwA6xTQ/0CnfHW8xdyqIQM1Txadiiv1QWJsNpR52iXedLeKe62y8EXXclwD0b7T0uRFXfGC6TiqnPIKFDz1WNpmp/8JCp4Fz+/V/nvabRV5R3sxLfI/csbMKUzRhuUhX7gnsxe9vTJW0PBmK5nwECAXFhwv
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(40470700004)(6916009)(316002)(478600001)(82310400005)(36756003)(70206006)(8676002)(4326008)(82740400003)(356005)(70586007)(54906003)(36860700001)(8936002)(40480700001)(41300700001)(16526019)(81166007)(40460700003)(5660300002)(26005)(1076003)(6666004)(2906002)(4744005)(7696005)(47076005)(186003)(2616005)(426003)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 00:56:25.7777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e9b0d5-31c8-434c-0c06-08da8aeba19c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Jack.Xiao@amd.com,
 Xiaojian.Du@amd.com, Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

there is only one SDMA engine in SDMA 6.0.1, the sdma_hqd_mask has to be
zeroed for the 2nd engine, otherwise MES scheduler will consider 2nd
engine exists and map/unmap SDMA queues to the non-existent engine.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index fe82b8b19a4e..0c546245793b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -181,6 +181,9 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
 		if (adev->ip_versions[SDMA0_HWIP][0] < IP_VERSION(6, 0, 0))
 			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0x3fc;
+		/* zero sdma_hqd_mask for non-existent engine */
+		else if (adev->sdma.num_instances == 1)
+			adev->mes.sdma_hqd_mask[i] = i ? 0 : 0xfc;
 		else
 			adev->mes.sdma_hqd_mask[i] = 0xfc;
 	}
-- 
2.37.1

