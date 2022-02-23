Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4F3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 02:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AAD10E271;
	Wed, 23 Feb 2022 02:45:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696D610E271
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 02:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNFAje0A8zY5yNFeK1BDfXF+UyrV26cxaTNRUaBz52svx7nuGkPunqPpnl4QPM1xwcqQMpPPIKeZ5yD8wxxR/2EiRfZvubH+EKlCje0HAnmrIlC9dr/wjJxUF7uYgEB2zmDwZMnC5ieBhcgN1jeVpEeKnLtGenU8PoVRmLOghvwn5V+K6Ex6nH0OfSoSHzqrpvKaqGXt3+BAS+DFCO96azqdPgmS6VuiSLHnE+EsV8AD+GzMoc1cUqp/WccqrBNCP1dd7wwTcwO8kOUH8ciPMXTgbra0Y7niMAO1njH9NqIcFrYoP376GwvFo7xZ8aLx/iwOwKo1hRWMMs1U7bfhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWcP2+ELxqmBZE66aJTwQlPlrMR0QRrM4g6Irudml+o=;
 b=nQUyjUakQA1fLcp/oXvdmi68b0Esj5qpu+b2N9M1gFoLpFTP8lPo45IqaOACvVexXs4jgd780WQ8ebya7Art25n4MgsoNhYrPJcP22gZOnXSxfZglKpO2RlY21diJP1kWfYWeCk2ctJ+/NHOYvmDai7rrBVFlR+grIrj1K48bWuZbDuc4VU5HaXyzdkDZJxPsvb/xZjd9fQua9r5VGOlaFUoJdO3UUs3xZKv14fEsyISS8PgFKA0lXymP44uaJ0KSLuYVlJMGJdH47Nmrb9StL4YkAjfXzjOzpuL2OvKqPVTDxfZ6c9r2qSSt9R2GmjPqW7ynojIGMOCzd+LiENmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWcP2+ELxqmBZE66aJTwQlPlrMR0QRrM4g6Irudml+o=;
 b=TEM3uowUnJHUM49CY5YjsEMQEdkL2WyeYCHn2l344WzxsRQsg2vIeWRGFNm6gNjHYiEEQGARn5Vc/LAi1HXKUH7kAkRevV1XKTsZeTA4VgdCBhYBtHMK2qqOPEDluF9fW+ojzat3qnivVQ4sx1IL0x1YeK/v6oXjs5YJwtu/GiE=
Received: from MWHPR1201CA0019.namprd12.prod.outlook.com
 (2603:10b6:301:4a::29) by MWHPR12MB1327.namprd12.prod.outlook.com
 (2603:10b6:300:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 02:45:03 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::36) by MWHPR1201CA0019.outlook.office365.com
 (2603:10b6:301:4a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24 via Frontend
 Transport; Wed, 23 Feb 2022 02:45:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Wed, 23 Feb 2022 02:45:03 +0000
Received: from prike.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 22 Feb
 2022 20:45:01 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/nv: set mode2 reset for MP1 13.0.8
Date: Wed, 23 Feb 2022 10:42:35 +0800
Message-ID: <1645584155-20885-2-git-send-email-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645584155-20885-1-git-send-email-Prike.Liang@amd.com>
References: <1645584155-20885-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5042d217-8ad8-4788-17c5-08d9f6767e71
X-MS-TrafficTypeDiagnostic: MWHPR12MB1327:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1327AE9EFB52F56BCB9E92F8FB3C9@MWHPR12MB1327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoWDsVya5dFK4qTehqnjO7tk5IbqhelTm+8F3WBhKrNIJ2oSCHzkp/BRv/ouc348EnRjaYY26TYg7u9sJHnLWc0awHAraVtxPHQLZKDPouknR/OMk1tbuFkigJP70HAuLVPJBJCyJV03kAQy9jN6vZtZX4qdEiqEPcaSgHC/fpK3l5VgkQiO25NwlkZmQRqgG6RKnWuMZqF/ZcdMUYsb83o5g2aO8EEPekrRD4A2xR5sSWKvl0O4t5IhtSSYbBlNgGTOqckZlMAn4B8YS/uSN2g5HnACT2FblhpxTK54esdqTE+Na6MCZ9JtKEunxo6x2stt1NtwyWJ+0N3C0huyjHHn6PbTGi8ExN5XLmPLF39hcvX/Dk44LSlDiyYUE08tZguyRSM9HB71HE89KIZPnVItvyUBv8DWXbNUaIQBrrkRmE8ee36DPVFyeEJOOOlKT3Wux68KRc5s8AGatBkGI1rtNwakHugK53L+FlDXpNdS3eKEsI9B9qjwNYUKmdvR24qBY9cDool3EyaQTZxzWr+0MFFpwXv1Vo5cgSW0MNDFpaZ+vwwrGukID8fNi9Z5G+tQeyZ/QNy+FC/sOWfbos8U09j/bQFWZTKjJI1KvgR7ZzMykbIOGu5myrEwDM4jjNIkvAtj5AFc2WvSzFWBGfpooF0AcCaGsP23A6vU4zTdxtelwOocw9b+9Zka1v/2k/P055Eex4CNBsuyUndwbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(4744005)(47076005)(36756003)(336012)(5660300002)(40460700003)(2906002)(8936002)(426003)(36860700001)(7696005)(82310400004)(16526019)(186003)(26005)(70206006)(70586007)(81166007)(356005)(6916009)(8676002)(508600001)(316002)(86362001)(2616005)(54906003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:45:03.5363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5042d217-8ad8-4788-17c5-08d9f6767e71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1327
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>,
 ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set mode2 reset support for MP1 13.0.8.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5f375f3430e1..f414b7ca0ab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -454,6 +454,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
+	case IP_VERSION(13, 0, 8):
 		return AMD_RESET_METHOD_MODE2;
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(11, 0, 11):
-- 
2.17.1

