Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73246EB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 20:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9814910E00A;
	Mon, 19 Jun 2023 20:13:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C368B10E00A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 20:13:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=arpUKRD7gqnWAmONf9MTdOmdsuDOkxJyQ4Jk5xggYfXXiod18/OBaO3kIe18qzZwdFwNnWL3TVeVFl38X/rqgY0D11gOidh/acBdpmZGjkkCg+IYnHA7xbvkXvlTlaPUbdxnhorIq+aLzW//FEZN0FO0AlCMcRbQALWqZ2lAiZ9dcwKvfaJh76yNBmIf6MxYQ7Wh3GTnfMfsqg4mn2eIsXSwBaGu5kuWSnyHFJkf3jo5QBxERarpxoeOz0yz5HWxK9BQT8mdcar6athsjbJBJCRbAY7HnsZMuU+V2+PV038/LznEQxidcTXDZZ14Erv7lNfO3MmRgKPQd2jewnnB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gHFFHzlSYNt2rZ7/tYFicj5c8fndeVj1JN2uWKF+Eo=;
 b=XlXISNPGJGHMnLS4Gwkosm45qXBk6gr9KGrKWAXTbxpCRlQ4KX/53skQOW5LOLhxiZjnw5FV8TbH8cBMeF9QE63H9v8QMETST9oFdUO7UD5lrRQdVwUYo3r+xMvE7c2L2E1EIk9GCBRmPxxiaG1azBssP12u9c4WOVWBYXx88b0oYtie+GAEyaqSykfRKi5FVpGRtFxhEOxJh+F6IPy0+7QZszrXVNB88MyK7K4Q5S7l0PM2kegoQefKXm06wIZ86JuaKdPOyj8b4MKrrWAF4TFdVOkH7HpvmDC0vd6B6XujWKLRc2x4sNSecQWDI8NO4v3JL7Gf0l5Gd8VhmaQkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gHFFHzlSYNt2rZ7/tYFicj5c8fndeVj1JN2uWKF+Eo=;
 b=BL+C41lQcL78l1e1438I8xHNKE4toRBDJuDdDx6nMzzYPodIPuyHLHEQWSC4fUceqULb45S8CmY+kZ10yIQo6TsgD8WRMwervvHgaqmXN1QgLehhuKFJ7ttg25phhaNDJ/pI+pg51lL1PznNLdJWQtejksxRq3iynQQRKVLFWJs=
Received: from DM6PR06CA0004.namprd06.prod.outlook.com (2603:10b6:5:120::17)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Mon, 19 Jun
 2023 20:13:40 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::d2) by DM6PR06CA0004.outlook.office365.com
 (2603:10b6:5:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 20:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Mon, 19 Jun 2023 20:13:40 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 15:13:39 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Disable PSR-SU on Parade 0803 TCON
Date: Mon, 19 Jun 2023 15:13:21 -0500
Message-ID: <20230619201321.18882-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a416627-7d49-4ddf-ecf2-08db7101ac6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7YyzfqKR9eBMuRvc9wtSPXAhz+xMbh25OSFGLfF7GzGu9xEu4k59HOaxAKBhJFAUa3FD40f3uDL0fuaYKATn4bjCfpvzpFGI9c0Y6XLxBzXE2slFbR0yDzA5fat0VnAm5GA30pNlAMKs+zJz7RhzjzYZ9bkE479KGDCi1mx1i6DNYMFMBuEafDXJ4U6eAHhGZlR4GEActZX2vSpDLxCryiugr8FwHc3AkcyZS3QYfW5qe8KCOwKAMap2A5HoC/GswuUs7+QEyUoPPIUtWe+r88x6XLGRFzYIZcTfR18Tp5ZRPosdjFe5dMtgbUKyz+6mbuMo+gXArd+MZeNR64q2u8TX6gLgby5jH/79mSdaYRC3WZf028nCkJ6g5OkDLl1qPr67AKG64NSHZM8pSbyGjOZ9jGaFoYrKnOTtFv46NHD0GzBi4dxzuk+iT1i9Ajp2ZnolB16tjjQyApC+KxkldqBexBa4hldgufDJrTSI9+nrqcpI+EHy/JWTYq0VbjW+p4gq/ODyl5/gmiksK/1mJLrFFBx+jpe02ZKtgkFrLz/bTKaFK0Nhvf14DfMyQDEiz7iN/1GBOahvX4/pt9J62quhdpGAMbZBVKin+1bRwQL8wxnx6i3ZoaYSvJ+IbJc+6pouSCX9MalBoVmoFj1TPLbA+gOLTTMLjxL6SSk4In5nzHIrGCUZuWzdxQOPHaiz3ljDk89nK3Y49z4cebBOCp9MWMVIanSXTapgdv4mYzI9HxiLRmL5bDAHWR0DbVC+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(356005)(36860700001)(8676002)(82310400005)(86362001)(81166007)(82740400003)(5660300002)(316002)(8936002)(41300700001)(44832011)(336012)(6916009)(4326008)(70586007)(70206006)(47076005)(426003)(2616005)(54906003)(186003)(36756003)(478600001)(16526019)(1076003)(26005)(40460700003)(7696005)(966005)(2906002)(6666004)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 20:13:40.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a416627-7d49-4ddf-ecf2-08db7101ac6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A number of users have reported that there are random hangs occurring
caused by PSR-SU specifically on panels that contain the parade 0803
TCON.  Users have been able to work around the issue by disabling PSR
entirely.

To avoid these hangs, disable PSR-SU when this TCON is found.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Suggested-by: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
index 30349881a283..b9e78451a3d5 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
@@ -839,6 +839,8 @@ bool is_psr_su_specific_panel(struct dc_link *link)
 				((dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x08) ||
 				(dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x07)))
 				isPSRSUSupported = false;
+			else if (dpcd_caps->sink_dev_id_str[1] == 0x08 && dpcd_caps->sink_dev_id_str[0] == 0x03)
+				isPSRSUSupported = false;
 			else if (dpcd_caps->psr_info.force_psrsu_cap == 0x1)
 				isPSRSUSupported = true;
 		}
-- 
2.34.1

