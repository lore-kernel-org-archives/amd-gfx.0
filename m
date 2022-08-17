Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DBBC25B08
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Aug 2022 06:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572F610F309;
	Wed, 17 Aug 2022 06:14:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B233F10F320
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Aug 2022 06:14:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfPAPTWCSFdjlnHglvFplNU+jr7rhXmqfSbCzdtAaKCh96bEKBA2+xuvx3RiTsSpLvLIu2XpX8mv+4rYwkUr+ELSZnEG5PM1BM9HtOdNcQ8Q9Q9kXKdIEnvdg0KO03V1enFQkjvcGP87iI7Kcxf6BYCWE2t8bXZp1iZOU/CJBkYR9536AOStgh3ym/eqVmABClzd/cZ80F27nJL25VTJYk8kPGT558yNtx7T/nym/tJCI7pQ5Om6D6He+PpLRhpc8DXnouhud8YaqPJVEkKTdRrB5lGFPYYQO4DnCDXgCUZKoCByIQ/EMcMowv7enhlvGClm8GxpO6SSHWBfStjsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JctplWRfL+Ws+DQZoe+Q6aRRe7FSxA2hjx57rJ7a1QI=;
 b=hjBMzGEI47f2aCvas6ldXPlsCWqSNOG/h43VqiT9ZzqJZLUZ24f+XDEKdhW7UAA1vYNs3Rrnvv4A5QSV5JtmYCTL/dZR+5/NEU9lWc4jm4eqf9jzGkMx4sOw+FkTu+/bzjAaaSI6k5qUSDOMAJPiHPfBWiZN2cwE3k7GnYkgHFJrky4r7jXzhbuAiAal1l2z/jpZ8tBw/LzPk0TZKWvnnpak+FCbvTCY/LHNGfw66XpkwTNDNKKL948k7blxx1CldY4/6d/wOgVxJp3cnXgNBKzQ09Af8AwvKFZKAA1C/lXIHz3OKl2KEiLtDot3+RQL+OT7MyK6fKP2NGBy6TRB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JctplWRfL+Ws+DQZoe+Q6aRRe7FSxA2hjx57rJ7a1QI=;
 b=2ct4QQFMZehk3EwviHx4Rb6n2+uEyjL3snl7ZzV93ypAaJI3v11RO4Cspm02P1khdPBvpnj7ceKoRtYD3sP3MayiuR+nscmjEJ9VQHt/XkGkbQbbv18XdkLgJ1f3EEe9csLBZbu/JiAaSmzYhjLcqEDSz4TeDE2+e734Ihtjk0w=
Received: from DM6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:5:190::38)
 by SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Wed, 17 Aug
 2022 06:14:48 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::c9) by DM6PR11CA0025.outlook.office365.com
 (2603:10b6:5:190::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Wed, 17 Aug 2022 06:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.15 via Frontend Transport; Wed, 17 Aug 2022 06:14:47 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 17 Aug
 2022 01:14:44 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: enable GFXOFF allow control for GC IP v11.0.1
Date: Wed, 17 Aug 2022 14:13:55 +0800
Message-ID: <20220817061355.4046018-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f069ec7-5073-4781-7431-08da8017c94a
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5438:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sa7bdmFO8/6eAjsaETTAWOce/0zFk3yXO/e1o425GB9YBJrILDAkZU+9jXKPADCrPwXi4yfVzr1YmijBs3HuNkNvRc7bOeojhPEzOegqgewZew1Hs2uLj8vWLlIoWJFMU4ppZk25jJg2NuNJAiy/rPQd6626uS18D8vZi/gFWebmNZSluGe42c5gYgin9fYgUkyfRnVAcjJfJY4J8VvgLOn8bsKhSYBcTAK3V2fJ86hDDhdt/ySnnEunm2eYxF8xtXsdnJNrKN5fqfY92GCLRdXi4SJEiDkqeBJCk97TI4EIuJE2DmXwXyVn0ay8EyJ3MziOXvZ7Nku+qol7VXsgvlT9T4lhZNfHdFlBaX2JbJZ81g4dBOkZKTwUJafckh1lEFsRAazPRVMnOM2y1NiGkZtnsY+Lg4GTwg2PyhZtF7n+nkJgkfb+HbFEXg18vkO9LT9vE1IdgWclsmNRRoWPIF6WJViLAY4bdRhBajnlh1cwXKLNVPrh218Sq18RkrrkGVtMCpWYXMfYQt7Key57sZ+x3jlrvuHkNzxYX1Ig6eTkiIvwiieBwyCCTO81NBDltmqDYOYnh+rGkFQbs7w+chZcOERVikHy9+eBRtQEFkPeYXE+Ze9nO56d67s54X456yfxNyMYp4VMrAR1rw+Xia+JzcfeB2PtYBNV3oP8KdFEDySqvhQEbWpf8pznhQaou9hhaRnn5Zc60n5t/YsY54Ac1PY5x0eUMLwMPpw0Il1f+QYXXwXvYnKHLJjJCehJdYZX0NakQnegya4bNgGF/OmnK1G5pvdM4/QUwTGyL/ra82+im95zMgE1FJr6ZLcExQcVARgZgOCjnZUGW5bjLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(8936002)(83380400001)(54906003)(36756003)(426003)(47076005)(40480700001)(36860700001)(8676002)(70586007)(6916009)(316002)(4326008)(16526019)(186003)(5660300002)(70206006)(86362001)(2616005)(336012)(6666004)(356005)(1076003)(4744005)(44832011)(41300700001)(2906002)(478600001)(81166007)(40460700003)(82740400003)(26005)(82310400005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 06:14:47.4955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f069ec7-5073-4781-7431-08da8017c94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5438
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

Enable GFXOFF allow control when set the GFX power gating.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 158d87e6805d..f45db80810fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5328,8 +5328,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 		break;
 	case IP_VERSION(11, 0, 1):
 		gfx_v11_cntl_pg(adev, enable);
-		/* TODO: Enable this when GFXOFF is ready */
-		// amdgpu_gfx_off_ctrl(adev, enable);
+		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
 		break;
-- 
2.25.1

