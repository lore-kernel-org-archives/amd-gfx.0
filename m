Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16120CE7A86
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 21:35:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F44E10E717;
	Fri, 22 Sep 2023 21:35:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55EED10E717
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 21:35:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPLoPPqxsRYhGANWdYPXKcqBN/a3l9QL1jh/WQa4oSJqExsuDssblLxFK/mpTETtWV4ffsxpBXCXCrmJfJWeckYVy9f7U4DXB0GbkxTi6atY6EkvKZeAnqaXEKvHdOdJhEy51EnDpLce3diEYU/kKVh0OuUIotD4V0JdgrgiY6d23jx3Ygq+3QBYJ6IHdGVqBHOrFpXrV6bQwlMAtJxAMdpnlF608FrEQ89x/6lgeGaWPHXejk7snG11OAMf8uk4SPpY3oU5YLwGwXI1NA8vYd++3wHwMtNYOKcryZiirCR6CFfuTO5YAgY3lJO+1OAjkwR4F8j2TRhOd/WepKg93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPr7f0LVaIpomgIB5lSohpBqQBPTEalIt4L0OWCp7Mo=;
 b=kUstcLU3F8FuQ9A30wR9Nssb0kIuhWctJvewVNrQuv2VdL//5ZnfQ/cEZZ2X1jE80m83iHSbuNC30u+tTDV+5nqfzauMc9o/AsmlIBhXFEkKUBYEKAKlBbxTG+8CMylPApBzMzFPskbq3iHrdMMljgC8fGEsXm+Znwfi05Ldl5Tg4b8+PZxw3bEb5dW2f/98Qjvz/wN6DHZRGB/h3hXmzG34gSNrOA6bN/FG0h5Z3JUh/CLMy+TFDLYk9E+R7FIIN6Rj6EG2mETn4E3OcGpLxn4W7RvbWtPmdAGh3Mt/Fo5+kY13mMez1NDakerdYugyvaX/MBUZSbqN1BUjBtzs/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPr7f0LVaIpomgIB5lSohpBqQBPTEalIt4L0OWCp7Mo=;
 b=yOofRAtDGI+0zsX7rhtbqlJBBPOZ/SE0POkuQmwb2DlNOUsSCo59uAf6vT/D/zQP8g2eBlbkpU8abXru6chs6+ES8oNWp1ZXx3PTcpryMCtdH6dMm54IAdtAMBq/FWg/AlDGr6vfAfba1KU947MiP+H3yOwMyexOTYT2xVTT8ew=
Received: from PH0PR07CA0009.namprd07.prod.outlook.com (2603:10b6:510:5::14)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Fri, 22 Sep
 2023 21:34:55 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::d4) by PH0PR07CA0009.outlook.office365.com
 (2603:10b6:510:5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 21:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 22 Sep 2023 21:34:55 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 22 Sep
 2023 16:34:54 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix a memory leak
Date: Fri, 22 Sep 2023 17:34:19 -0400
Message-ID: <20230922213419.51846-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-check-string-leak: v1.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 78af900e-f994-448a-eb4d-08dbbbb3c357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hes5zZjL/6PWtkfhym1ZfRSPLdyMTWYNkOAL2SC+qQKC7s4cld7zIW0Om84AWQLUb/TwYlcCtkRIHpYqUTzC9vO4GTi3nImpOVDukHhdpZNhZ7O/YixVxLbPk7Eq/gxGG67mH5Pjpgm/tj1sZ3C8DVUgeSlgiLM34kKfht960k4Afbz+DR5Kig6gbG9+vqVy50sGqyS1pe3auGulvcGUyinxTLboUJSghha4MxvTUWOd5jgbYHWuKEfLN4Rv/Mk6+xxi3gypn4DdgbhKUwgqBHU1njW2Nmxiyxsyxt9fKUG+mLrXBS8dHufDeDlnP3/mOrM0D0F6DpNwhMeQos8oPIXrpBw0yvRUUwe4kiEov90FF6coKCh1FlyOZ3IQFVMzmKDQCp1y72AdXgtiXTTUGBBW52kqIGl9A/NS8EANjk/EC3DYBm7nmITWgujs2GrPgIu19lNq2SDxZ5KdRkVV0LJnbhHFWz5yLWx1iMRJJGAYqkyEML0sNtTrBsl29rz4xdibsuyun/bbN2kLjyfjtYnqDz+/aWWzhCKvdzQ29ZTVm0CKtGrZIC/bugoWvFiaQJdjYMYiQTZaJ2sx8KnqJS2e/3RREAc3s38msr9ekXhhRK65kQJO8yqlhtVFIkN2NvYkWleouzVHEa8yIFdRvEpPHO4ldOZ8404GOm1hbJg4J7WJhxR1svxn3yKHm6jzWlkiek+CIVH9RrDvI9IyJ43kYLihKxs7dq4pb/P/cuKc4Y72zNuNg73gE44a0WzhAIZF4Xkv2qJbTMsoKpv4qIqOOM25P8JbiXKYY7y2L2NvLgYH0We6Nu0NbqCtVzki
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(1800799009)(230921699003)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(5660300002)(356005)(26005)(82740400003)(16526019)(81166007)(2616005)(8676002)(8936002)(36860700001)(1076003)(40460700003)(36756003)(47076005)(336012)(426003)(2906002)(4744005)(86362001)(4326008)(478600001)(44832011)(6916009)(6666004)(70206006)(54906003)(40480700001)(70586007)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 21:34:55.3291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78af900e-f994-448a-eb4d-08dbbbb3c357
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a memory leak in amdgpu_fru_get_product_info().

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Reported-by: Yang Wang <kevinyang.wang@amd.com>
Fixes: 0dbf2c56262532 ("drm/amdgpu: Interpret IPMI data for product information (v2)")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 9c66d98af6d86a..7cd0dfaeee206c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -170,6 +170,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device *adev)
 		csum += pia[size - 1];
 	if (csum) {
 		DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum);
+		kfree(pia);
 		return -EIO;
 	}
 

base-commit: 14d13f757d369c9873ebbe34d02d0896f5de565e
-- 
2.42.0

