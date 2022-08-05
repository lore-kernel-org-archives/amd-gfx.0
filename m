Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BF5C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 04:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FD8AF94E;
	Fri,  5 Aug 2022 04:14:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3FBAF92E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 04:14:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt5R3zoa8OWpJ9oFVWPhnaxVzxDsRQOmTKCn0lyQSM1f3Zus2eHusREothD5g3rjJ3dAqVWuUD9JAORf4AGwB5WiJ6qUamztjMtoiGE8qax3BDkv0XK6Nwl5g4F4hvZy5FvIqhN4srYsusChNVxLiI6c2d0exc9IFcSaQbeif9MW8lG/8ClGFSOeiWLAoblLh4CIvA7qvQUL2/76sRc5za2JHlDA5qyEGYp9sK9RpnBsuP+eKah/5DbmzhsQKAGFbIrJM3fMWuE16aQZ7Iwj5p+Yo61auYpJxT86H/woHM6v17H28364MslnqSW9goNbPiw0EzEg8DyrR3aXqarLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETiuMbzTlp3T5Ck348WXQMlFF3md7ebMfU+5TWVzspw=;
 b=dzyYtZQfgYX2prt2E8my9TACW+NpJ/eqaV16HVZ5b7AtJYk0w93pqqC81mIhGZy1RuPZ1AMTPr0ydd1mfuLbD4KEuifAmYcXpC82VqDXEQxkIFqfZ/g0EKQaTmnhJKk5j67/mvY/LGMEl5rHwZXA3BnrI3Glj0UpPAJV0pQY6J7OqOIDBm0BhXFQTokbf/82YnEdc8rfmZ5neADk09SYotPWbYROMEJnWNkLBizUkpeyrAg3wUhctXu2etH2eYfgaoDPxUtixGKQPYjd/pmW1h1TiFNDtpojungI7Xu0ufr8PxXpx4QvHbXB1ZXd8wOipNuBuEXqw68HIv+gSHWLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETiuMbzTlp3T5Ck348WXQMlFF3md7ebMfU+5TWVzspw=;
 b=evrY4uRgRuaELErq3q8jiiKSFRHPWJCsEYGCHAoPzB8CbcZ4wdNvTjUVwtUJ4346/o6LJ3/I/Hfrjym09aLmqvIahGzsFsJ9/QrrUR6/viMRqwJI7vunQA1S4+437jx5jmJ7TF9wkNxINkw60W4kcugJR2y4ks5yigeL6j+9iFs=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 CH2PR12MB3703.namprd12.prod.outlook.com (2603:10b6:610:2d::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14; Fri, 5 Aug 2022 04:14:20 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::c2) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 04:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 04:14:19 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 4 Aug
 2022 23:14:17 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: add GFX Clock Gating support for GC IP v11.0.1
Date: Fri, 5 Aug 2022 12:13:26 +0800
Message-ID: <20220805041327.2621649-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e47531ce-c433-4a06-4297-08da7698f830
X-MS-TrafficTypeDiagnostic: CH2PR12MB3703:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPNL9MOVy3xlnCnqIu5SyweB3qXS04AtWlwiDFLG/98ecvTFkuQVLYGyuwhWVX12ubvqaEPo7lfSHml781xe6YS8W//5VwupfP0jv44q+iCwtmxA72hrMUt5squ3vSVvVj765V1/zQmRm5w+0Nlz0sPWWENKzyfJPd//9BhIycJ1APBhTNxJQBeiniOA/WB/09dcmMBPXFpw7FDclcdANjWXt1z+x/WXG5dnF3eLMi5EIRK2x2Te/udUp19LDeVYQ577X7OcLhmhNMtzfkxsPLbSOccUKAWhMtYAFyMskkgJ3dwjRLDjFpSTvAAiI8m3QkAR1uflMLVtOxI7sk2gOALRcAm8pbmQegJ/B5YoT3z0Hz7JGJG2PDPL2SAUFD8OYS4xBskIXxMkbJuzmxij1nruoC41ObRtEOKHnJ43RxSXZ+tXgbaktb/18wlO4n+SVMgxCiKl6CRV++x/l1/wpw4fFtgIEJEQrOIQ3bfqqKX+ykib16VkK5Pzwvsdb9nxoTTGnJYNbSXfuBP5FTPji/99z43fkXwdm/UW2oq1REA1H4yvlqgCBkbzZkpXc4MIX80zWMijCVICoN7o6+vsynzmwAd6jp1Ve5vTwoXyYHHeR/Wr41aE4rf2fiI76mj9lm5LOgLG65t+C/HwamAFJ5PKxqfX+zMvTKcMrWQ4hZolDN81OGu6hzxz/FgzbJBP+T2Gerrimod5khOUV+dF1Vm5NL8gJlKcbTFxeN/uJHo4I7qahrIhbvmMuzj+UWMWr+i2DiHCkyvu/j5FlsXCubYvkTMhzUtj8qpUyzFaDNF/TbBGiFTs+k5o2D6FKlbSAc6Ym3M2zazyoz3k/zR4Hw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(36756003)(4326008)(4744005)(44832011)(40480700001)(8676002)(5660300002)(70206006)(70586007)(54906003)(6916009)(478600001)(41300700001)(8936002)(316002)(26005)(2616005)(2906002)(6666004)(7696005)(1076003)(426003)(83380400001)(336012)(186003)(16526019)(81166007)(82310400005)(36860700001)(82740400003)(356005)(40460700003)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 04:14:19.6427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47531ce-c433-4a06-4297-08da7698f830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3703
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

Add below GFX Clock Gating supports:

1. GFX Coarse Grain Clock Gating(CGCG)
2. GFX Coarse grain light sleep/deep sleep(CGLS)
3. GFX Medium Grain Clock Gating(MGCG)
4. GFX Fine Grain Clock Gating(FGCG)
5. Repeater Fine Grain Clock Gating
6. Perfmon Clock Gating

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 52816de5e17b..b700c6cb14b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -586,6 +586,12 @@ static int soc21_common_early_init(void *handle)
 		break;
 	case IP_VERSION(11, 0, 1):
 		adev->cg_flags =
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_FGCG |
+			AMD_CG_SUPPORT_REPEATER_FGCG |
+			AMD_CG_SUPPORT_GFX_PERF_CLK |
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags =
-- 
2.25.1

