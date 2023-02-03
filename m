Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD39DC05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C1110E7F9;
	Fri,  3 Feb 2023 15:25:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D1210E7F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1TFSBI+rDUiMkhej+zJEQhftMA7uym01fxK2vt2x37dhZkNwBWsjgmOnkXJ7vCH3MrnTat5TMXQii5PW2ia4TbQzEc5qHhhmd6NQfBFoG4l4YyM6XoUNgYVTksXEor75S6RW4OR9lh+BIJGQnUMnFnIipWDX1JznqlGPpbju2cdC70Z6v+PYKTTgjybwQ19suu0Fec9grjLgDBQ5DBX8HxZikD2rPRxqch74Bmo9ItZIGPu3CejDUUGBLYw47Ie6biuxmH2+xQBSC8xQi6Z1WCn2UghqPhn8SYLAKzeGY/9F4jULr43el0bRSSNofZasGaRHbUTqG7uJYftJQswAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCt9e1OciKjWttTHwSIxq5+vTG85T0MgQbfZhltDVqk=;
 b=PobSanvj8J+8ZYJHepNDfUTHSvKafi81QvTsDOCmrE6MxbBYYmXNhTVxn11iCQG7lfUF6rpkF+P9wGxb8b5JAATNcaAgvUcRaIhUp3xdJ19lOSrOuD+bc6w5A2j66C/dBRHutvrQEUb9vyeWmnXzNn7sB9AWkgCpAbOkHCTLjaEOcJzLRt2Idz8qytyEEcUsLrKOD2SHG1VikoxjByZ56Ud19RnFc4y41yTtQYUZH/0irkjFmzlYVQDpC8fzdepUnHXp0X90iaj8v5K/I0x871rQjIQRBnrLrASoqTPcRc1pwnDxEOY3qvrHbM+R42wy2+NoO/WUpzEYfV9G3KYkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCt9e1OciKjWttTHwSIxq5+vTG85T0MgQbfZhltDVqk=;
 b=0xS3DgyVxnQF2GCJy4PcfjS7g/uGtCnd0TZWQjmWjlYTCXQqtaA16Ka6yVBt8Ju60S4HgvMe7fGOktJGs4Fuyd+9fYtqc8jDNk3cOA2zNn3TnSmjmRqaIgIn96nq7wVMxVvdCRyWYz4xxl1LJVsP11mNn1V3k7foSPMpthqESNY=
Received: from MN2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:23a::25)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28; Fri, 3 Feb
 2023 15:25:36 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::60) by MN2PR03CA0020.outlook.office365.com
 (2603:10b6:208:23a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:33 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Drop CONFIG_BACKLIGHT_CLASS_DEVICE
 ifdefs
Date: Fri, 3 Feb 2023 10:24:49 -0500
Message-ID: <20230203152452.1441747-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b0ed1b-abd9-4338-8112-08db05fae5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHFW3/9i5NZwGwZEIPIZ4eSyX8yWU6hUMX7GCdOHHCuAn+f1qWWLgtijFOuJ3j17NnUorv20e65dV7XBAUko2H1EIJ9XOWtEKTpNmxdTM7TRobmRy2ACx2ylYXJrN+3cMgxi2cIV1gW/ukJPfyWBRhslvdHO3g75ClSYUPgFyUDl82zNUvFa8bbBJcvN86oDcJTUgVyJI1Gnbbb1do6RDSpbi16UtwWC8ExYT+Ujq7+IIpPqoMt3Agv4hV/lQwdQoSnnnT4UrxzAABZMU44Ctk6B3RtZ8KYkm/BpXsru++IkXMsvyyGvLLDPRH9TXZKTE4lU5LO12FNqD3S7ld7GyJKjrZ8+hamtZ+DfaES1rJLjVBc6pgd3qIHy94eyPzBZ39IVd/tfS9a+t0Jvvv5K3+JYX5bogum618Arp6A69uIDbSvCKsDDKcWDpRE/45Pfaw4nuiGf4bUXHH+4vSDjwmHBk8ZDX5oJNYEEo6akg1k4c3JCG87Z/Vags3MauhZrDhzUBBZiAReE+zUo5anQJrr1EW9n7ozxbRaD8XT0XB/GHMhh5+KdRXJZRhgfBCwRiEYMAAHtzOROx7yYxtbfllnhuGRRcMS1trb+afRbipUog7h2hmFS/2IrH3Nt34dFdnOL9gvbL2TvnJPJr7Af24gwiLFZW2Wz34fpcsqjoHWhM9IIJV5DmNGwUJg8OpsYORdT6bfTP+987ZW17dAyCBjof1vNYT498G2SyEZmUnI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(40470700004)(36840700001)(46966006)(26005)(1076003)(336012)(426003)(83380400001)(70586007)(70206006)(186003)(16526019)(81166007)(36756003)(40460700003)(86362001)(356005)(82310400005)(47076005)(36860700001)(41300700001)(8936002)(40480700001)(316002)(4326008)(6666004)(54906003)(2616005)(6916009)(8676002)(478600001)(82740400003)(5660300002)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:35.8268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b0ed1b-abd9-4338-8112-08db05fae5dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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
Cc: stylon.wang@amd.com, Hans de Goede <hdegoede@redhat.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hans de Goede <hdegoede@redhat.com>

Remove CONFI_BACKLIGHT_CLASS_DEVICE ifdef
that was accidently introduced back.

Reviewed-by: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 143dfa899a39..9942e0e4beb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6151,15 +6151,12 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	if (aconnector->mst_mgr.dev)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
-#if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
-	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if ((link == dm->backlight_link[i]) && dm->backlight_dev[i]) {
 			backlight_device_unregister(dm->backlight_dev[i]);
 			dm->backlight_dev[i] = NULL;
 		}
 	}
-#endif
 
 	if (aconnector->dc_em_sink)
 		dc_sink_release(aconnector->dc_em_sink);
-- 
2.25.1

