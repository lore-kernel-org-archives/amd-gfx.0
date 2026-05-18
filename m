Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB62CD343F
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506F810E0DF;
	Mon, 18 May 2026 06:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O7+m3L42";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010025.outbound.protection.outlook.com
 [52.101.193.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685B210E0DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sk8hHoxk4W822kkwxmLM9lKQ8CDBS1oBjHGSvvnplnt+cOq6m2BqZb6D8/S8PlGAKrv0ENDHSuZu8+1Msx/T4a+4dfq34NDOI4vSt0VcYq751cJgWLKbEoT/1K4YEJlzjIXATGdEvEKbV7Gx6cjZ2PKiQTbFN7at6vFVXN+Cm1HEL7M2o26MtRO5gtHmEDQPZdhr6iZTtnH6uD7vEYRXHmRDsYzQBvaZOs2NA8e1uiee0G6BUvwjwfcnSc+K/kbad1CYMNdr3E8SPjHFtBpeb52HNzB0BJL1h5A0Ke5i0p+WtEwR+payAtTw2fAbNz7MRj8xdchWscx3pm8Gw6ztKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tfp39mQeoup3oddZDcpbWkhr1oMRa7EdhXVIIDxz7Q=;
 b=OiDMqCTLyDVQWPCb/jwA/UIJiDTYNne9rQ7SsMh960nJ3I+Ps41MGCD+XBbUFxOCR5YgHaiaenygIyHy+lAXqwKnK7TyRGcCe2CVBW+D2a2iQVoc74xjpTon06D5CfTKnPpBCAwRVDnn/eDOEe1xZrcGtFMmRB70VS/NwjzkM1E9TGUT1w8tm8K5Iem+yk58fgR21mhz+WMnIoRIYaBMILyUAIX9xryj6X+A4ymQOqCpqTRtFMLh9mzJzKPJCFFcKQsd6C2ShEKgcD6aliLJDy6eO6g50FCEmZuURUUWz5zvvtiIErs8CvX1O0it5I1BjdKstnhpy71U8X10Ey1HWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Tfp39mQeoup3oddZDcpbWkhr1oMRa7EdhXVIIDxz7Q=;
 b=O7+m3L42WIFh+eu6jxmwqSw3gciJfx2lEhyIzyUR/6AKPrwDJSb7MhwSF40kfeojlPFosQrdJ9hhXIaoEpBcQ2GpECmF8eYogLZHOrQCKetmA9RXFnvgBsoyPI16hqh8rmm4DF7h08FRSK4WxVmX6SjsiOICVoQPBXYuRTXIPJY=
Received: from SA0PR11CA0175.namprd11.prod.outlook.com (2603:10b6:806:1bb::30)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 06:41:33 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::20) by SA0PR11CA0175.outlook.office365.com
 (2603:10b6:806:1bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:41:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:41:32 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 18 May 2026 01:41:30 -0500
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, Gangliang Xie
 <ganglxie@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: add first record offset check
Date: Mon, 18 May 2026 14:40:51 +0800
Message-ID: <20260518064053.2778626-1-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: a505d481-72ef-4a34-f7f9-08deb4a87ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: giblDn2HlvDce136sSFgBmslRp7gOBSfSX7nn9fhhaY8MmOGqFnbsTyD/LhG3gooH2HwcJHRZVCbjVGt7sjDyuMGvmEIA/s3a7Z6I05Y2RTw+dE3V3O3BVBrWr0z2D4QBG7eE1RTNyeyoflbq2cpo6MX2d1hi7lOcm1xMuCsYq+7B1zq4bz/wFOonj4KfykPqeaiMZ175a156v9Kb3zJpyl4Kgbt88IKnc00AXrnu0qwkfL9MTG28nGVHTzIheZlO3fkcHOuKdrrk1INXXMh4tGgr64TfunRjwsd30qS5itJ8i7AmsVvUmN+Z4oEOiAXhhf7w7GDNiBfedEfNebukh5QENZa15n/h2SOF3J9vT+n0nutdDNMo4lHkqoUyJ7zWQWmUpP4s3Lj2y9mY75hvsG5z9jhJoCnumUrHi+6nmFN/k50ULtWn1j4oggfeoEpEH8llAB9kYfvYLSobolfPpy6QdzzxQmMPcrNcrvDn1aTz0689HB6hOsKavpAcc5hJDh1bi+j09e39tRQ6MJSQtNWkQyUvtkl/w6X7W1C1+7RhmMBrAcf5MKh62pGGOwWoz6okrE+ycBG9xonCkeo49GOIapZhbmt5foj5evICuEetNk//N6/DUfAPoe+/t/OK1OtdW5AUfGNF/ScwVJk87y0J+5GCXTJGKhK4y1RG2b9Qnr5N8H4bT+tQJY63eYudr37Mj+zO375SMzg1x7IdZcHavKOC39aFXE21Si8SC8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1dPRIb0Y8fVkdkam69d9evuByWz3v6QL9Aoanh92torMhZACIiuC68HfH5UFV9jf7Q4y3ZBNyfJQJ3t2VNab93m3kczGCRHlz3SWISv3CvBY0n86a4vuE0JaZpRkPqJR3MWUe62P8OwBuBTW2w8bhXfKsOUEZvf2xLVS+aK0RU6HukEswSrgM/LvnajkeJyJNu2c0OvET0nIfY3pQFqQJsH2tySCbG4y/KOFrRym1/KKWDj/uXUyIVITinik0PQA3Gu5llymZ+c4gzTp6sv5IQZkv85ZfrnI3jvL1Po2Ba9vRHK6RMaoLPbQ/mVtXWEDp0LfxuhTd4aBmgPGauxD32I9Ed47eSsob2+mI48MWWZb6lIIOVqN9p2e+FHqgkgHksHqMFXZhBrMUDVv6+Aa46Hzzw54Mup//vf0q07fjSeMPLZTObyeSaQImdzxT0FQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:41:32.7117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a505d481-72ef-4a34-f7f9-08deb4a87ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

check the upper and lower limits of first record offset

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 0c57fe259894..33a251979042 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1632,6 +1632,14 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
 	}
 
 	control->ras_fri = RAS_OFFSET_TO_INDEX(control, hdr->first_rec_offset);
+	if (hdr->first_rec_offset < control->ras_record_offset ||
+	    control->ras_fri >= control->ras_max_record_count) {
+		dev_err(adev->dev,
+			"RAS header invalid, ras_fri: %u, first_rec_offset:0x%x",
+			control->ras_fri, hdr->first_rec_offset);
+		return -EINVAL;
+	}
+
 	control->ras_num_mca_recs = 0;
 	control->ras_num_pa_recs = 0;
 	return 0;
-- 
2.34.1

