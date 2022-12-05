Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D32FC4321E
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Dec 2022 09:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61EF110E194;
	Mon,  5 Dec 2022 09:43:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C3710E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Dec 2022 09:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvFz3WkhzjWUVTq7C3Ab6lgYxe3EfeOmTj0+4mGTJPAt5Jox0NRccBajzvtOAr2x7IID692qavk/LlWJO+cebUn6l4sVc/wZc7kC1x17XN6SQyCdYBvxpnYWmr4dCuavYafQJ5VTH7wY1x+BfOt+VSTn5lNdpuCO8ITWAZ/mCANnWNqHMb3NSDI0by/MvEGlctP+Ug6gkVF5A4lneWqRxUMD0H6l4OqmPWyqRKj71QzGw5ACgZx6srJIymQeRBC1EsyMlWir8IoAQUQ0Og1S5xD0JoHIoHHSy0rv1aiTllLOqyr/RoIm3vQznWe42qy+X/5ls8VHT02FMA3ABIi02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahidOOu6YoTiwKJ/2JF8BFJVhVwMACM6BI8dXr12kkA=;
 b=l67YIzdUoYLEILOIEzQOw/9ixhNITJsrjhVb665PD68R3A/tHN0qFiMK1EOvarbAhz4LhvCkGnk4zguZAAyWv5eed9tY/fWw6PGP8ZIItqQSk6fN42p2ba4Jc8Ub32xpIRYz1wVhdrCPIqtrjPQbaAopqMLoJ5naCyRqqA00bd14F8fzg+imh/4CMNTrV6UUlaAsJ4YdhlslsNF1U6pGmCdWEE6kXnK2Sexkp0GC42kOK5Tz/R0z8e2Yj8U/bXyTOE01eVATz6bQmo0KloKftV3oImZojtMDBksePFW0yBkBjJcUVZtukHI1k3jSf86kAknj5nflL/LLiTO9sCtrvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahidOOu6YoTiwKJ/2JF8BFJVhVwMACM6BI8dXr12kkA=;
 b=L1WYyU0Gco4Qy0FFchhAtFor2V7dW9IrGYxvF38lyOiWlTwwdEnK4HCTkwV3psM5cZg25uNVe8lzgh3gq7offotkPtiXaLT6PoQLWMKv6naDwdjOTpLl6qPHDZVLoRYDEpMaQhdW74OMmKtYajRqbaYbwOclZoED/l2LN0rc67U=
Received: from BN0PR10CA0025.namprd10.prod.outlook.com (2603:10b6:408:143::22)
 by DM6PR12MB4925.namprd12.prod.outlook.com (2603:10b6:5:1b7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 09:42:56 +0000
Received: from BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::6c) by BN0PR10CA0025.outlook.office365.com
 (2603:10b6:408:143::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Mon, 5 Dec 2022 09:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT090.mail.protection.outlook.com (10.13.177.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Mon, 5 Dec 2022 09:42:55 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Dec
 2022 03:42:53 -0600
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: enable GFX Clock Gating control for GC IP
 v11.0.4
Date: Mon, 5 Dec 2022 17:41:25 +0800
Message-ID: <20221205094126.2190885-3-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205094126.2190885-1-tim.huang@amd.com>
References: <20221205094126.2190885-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT090:EE_|DM6PR12MB4925:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ce6d1d-02dc-4c0b-a8ee-08dad6a51640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xB03g7NJJfEzEhG3Ni8wwvybrNRONHWbBZXhOApfX4rFxYHDo8g5FeJ/rM+55DHxxsCLpe7kP+ekDzDQkLEXPunqxXw2cGHQ8iQWolE/RD2EorGoU7/iqrQsXzO+lF/H0B3BeI3+Pd6nTrRGu1v/isj5dD9DXU/ZjV4KoZTrOcpdmeMAo6S+e2IIsTFHqjKLnIYGy+03zxpSEM+hCMChwIzP+0Xb0yIBUDnb77S2b/iX52rZFXO0q8l68D19ssOyYhPycoSxmCopBRI4mmqTjySWhyh7gkWWKkHOEfkKrMeWZ3f49eUCeCNn2qEyLAEEhyJaoALj6IKpJLWKbQclzcEXG/PA26Bruk2Edt+HSiFpVVghrpRbEeeuWfG+Oytyzhbst9X4smF/RHVVXtcSgxDGTsZ4LgGoeA1PdpNixqADuwdSzOpnSf4w5wivJAmO9Qjq3XDlhI/55uSmvFt8euXtwhJap0MeMmVl3MK1YSoxcxrCWVvlVoQlqUOGj66hvDHAj3Z6AxMhOFdQMhntjrQSo2OJowc9y36Oa32OLAi4zbKmunQ207U3/YJe+dRVq6jAvUIR8jf1erhJS+pyqWRjab9YqS7rLknl+WBZ4xVNVsycHqKuKdCwed//PXI+hVNgPzJ7Cf5EyBt9dlq/TiWZl8XCAoF/Qn044Ksi023fTDLgH6rldicYTd12y6ntJ/nE/4tNYhOlAfOJQG5N0mFm7H5epDmN9OImkLVfJyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(356005)(86362001)(81166007)(82740400003)(4744005)(5660300002)(44832011)(2906002)(41300700001)(8936002)(40460700003)(4326008)(8676002)(82310400005)(40480700001)(186003)(7696005)(26005)(336012)(6666004)(16526019)(47076005)(426003)(1076003)(316002)(54906003)(2616005)(6916009)(70586007)(478600001)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2022 09:42:55.7161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ce6d1d-02dc-4c0b-a8ee-08dad6a51640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4925
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, li.ma@amd.com,
 Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Enable GFX IP v11.0.4 CG gate/ungate control.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 506c285d5f49..a56c6e106d00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5116,6 +5116,7 @@ static int gfx_v11_0_set_clockgating_state(void *handle,
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 	        gfx_v11_0_update_gfx_clock_gating(adev,
 	                        state ==  AMD_CG_STATE_GATE);
 	        break;
-- 
2.25.1

