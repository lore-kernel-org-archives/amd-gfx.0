Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA98C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B8960F41
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 08:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56B8960F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B0D6E0DA;
	Wed, 11 Aug 2021 08:33:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F06D06E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 08:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNmMa3/Enx4d5L7BenwP2TzdJXFBabh6ZZzt8xyG2823WQxn/bJqVTCszeu62wD9Lw2RwPnxsoQjQWRf0CVhlx1qbzXKKoiRWe87+eknf2ymjkBoMG5roxik/FfQt5C8sFpGn4pcRkKBSVaUZ3LCHQp4qw4yP+Z1d6iOr+sJCgtUTGa0k0LrQnQprowY1k8hX+E7abmJaCTeAKelW1hkHvemiWTcCdUnzOqdWlw7yS7x2i92GWdx7OkeUqQRAOsR9M1crb6ZAxM6GVUqu+UN/A7fy5HnzpfcxewIokvQYs/NlwkTECNSXX70h2vWyzcmOsjlRRmcAritsg7Y1bPGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbXdCKfQM+H+Z4lGhD0m0WxUlhxz+/YLCNkuuRmS7UE=;
 b=h4AtMd+Ol5xrdCPVhJB2yTvb9St0GpBvqc6L8f/QoesPNsepnLo+4Ky1OirOVqHpV9ECjnav/EEogJaG7SIlIVTTuybowEF+OhoNJM8iAnWwaWM7Ha3JS+g9nePyl49Yyf5eOUb+NKrd7MZ3fzb5ZueWoHb5EO3dbyKf4wYMAOuym98DITsGpwK/e9llFHYUVUJ8ifPF4y1uOWFEfxkeCAbOVcnO7313GMH2LF5g2HS05cl0r5Oj+KrFuqccGfwLJIIFOuu3wfpiqvHNrq1VaM0OkbVo+0Jfs3mQfa8dZsKBfKNViZZSgBXy9xNzgGMkNAbYdzBIcN6H2ylR7P2zdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbXdCKfQM+H+Z4lGhD0m0WxUlhxz+/YLCNkuuRmS7UE=;
 b=sWzyVY5dCz7ti6lUvaqxV9we0yPftzURElYvoLuw1mE5dBNmhC+zVJ9NcIxWiTCS/Rp+WCeBvL3NKMLjtFfPOYZrSTz8fnxOk/nslkNqftnoCkE8io873FZkvpZdyuxXbv1JmsOG7ml6dgYy769QFNVOOiXgtiD8JVVxY7/Pf5U=
Received: from BN6PR2001CA0038.namprd20.prod.outlook.com
 (2603:10b6:405:16::24) by DM5PR12MB1324.namprd12.prod.outlook.com
 (2603:10b6:3:76::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 08:33:39 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::b3) by BN6PR2001CA0038.outlook.office365.com
 (2603:10b6:405:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend
 Transport; Wed, 11 Aug 2021 08:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Wed, 11 Aug 2021 08:33:39 +0000
Received: from kevin-ws.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 11 Aug
 2021 03:33:37 -0500
From: Kevin Wang <kevin1.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <kenneth.feng@amd.com>, <frank.min@amd.com>,
 <hawking.zhang@amd.com>, Kevin Wang <kevin1.wang@amd.com>
Subject: [PATCH 5/5] drm/amd/pm: change pp_dpm_sclk/mclk/fclk attribute is RO
 for aldebaran
Date: Wed, 11 Aug 2021 16:33:23 +0800
Message-ID: <20210811083323.1084225-5-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210811083323.1084225-1-kevin1.wang@amd.com>
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05216906-e9f9-452e-7d20-08d95ca2b846
X-MS-TrafficTypeDiagnostic: DM5PR12MB1324:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1324935DB6894F076C26BB58A2F89@DM5PR12MB1324.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjKqYqwODW1tDiaoQCHP3VSJTsnnKavNEbWL/IvC9/BX1T1I+XG4SaYvVlQzl/2tAzGA32JCnuWCsi4UkkunTTnZT9fg1MCOXDQ6VnoCSi1bhFJCJdbhzxchM8ks17B71V2EFRrlFf2c4NyyWSexHNIYz05451XZwb6fdS/UkMhzfBTOzDDli85d2/VaVsu1DvELKj4D0Eqgc5FmnCbVBOFSA/0iCDXaBrBF9qFqUy0BmJkCxJ8XJiXNWlce6LwiHK5AULpycr3kFNWvDaFNB8JsbcGp0kKV2sFWLOkc1/46ZpzWZve/V8EwLY8KPi+7sFCtSZ/TMjFutDP0HYTEeBZenOPCUzvhwoKDqPayhUx2rAb5F5S3+SE4KTcQqw0xdsqoV2ncY7JnjoOn4fF9SWltszCrQdZ6MIDlnmA7n9kP32KJZeUOPzb9OGKjar7eLDhoEWOeRqpU1tGSYERi+XdU6YiwG7CDEHcICvFeHdZCw91V1M/cijdq3OYVBX2PLJYybG1Ra/rSYtZ+A6qJnd49SYCWr+exNSyI5MlwMyVPcQpQnYRVICFjTGc2q3NMc2ZfP5U974Vht1WD435hQGetBQB5r7hsxEnc73y+eVmF57kDWm+cb3JXY96YujpEKO0xA9qyMD29bWDlkgQm/12RaMBvIW6Vo4APacv2isOPPRlGDD4oqo1S47pjQgViXKtuIfoP0Y6DiXnPD7R/rZem7spnE8kZY1/KGPK9Z1+tifApstqKfZR4LSOe9iyjbKKsln9zsVbROwGYVYBqRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(8676002)(478600001)(336012)(5660300002)(54906003)(426003)(36860700001)(36756003)(34020700004)(7696005)(82310400003)(86362001)(316002)(16526019)(26005)(186003)(2616005)(47076005)(6666004)(83380400001)(70586007)(356005)(70206006)(82740400003)(1076003)(81166007)(4326008)(8936002)(6916009)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:33:39.5300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05216906-e9f9-452e-7d20-08d95ca2b846
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1324
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the following clock is only support voltage DPM, change attribute to RO:
1. pp_dpm_sclk
2. pp_dpm_mclk
3. pp_dpm_fclk

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 769f58d5ae1a..f894b34418df 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2094,14 +2094,19 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
-	if (asic_type == CHIP_ARCTURUS) {
-		/* Arcturus does not support standalone mclk/socclk/fclk level setting */
+	switch (asic_type) {
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		/* the Mi series card does not support standalone mclk/socclk/fclk level setting */
 		if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_socclk) ||
 		    DEVICE_ATTR_IS(pp_dpm_fclk)) {
 			dev_attr->attr.mode &= ~S_IWUGO;
 			dev_attr->store = NULL;
 		}
+		break;
+	default:
+		break;
 	}
 
 	if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
-- 
2.25.1

