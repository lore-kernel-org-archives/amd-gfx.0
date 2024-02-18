Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21D8C4829E
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Feb 2024 06:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FFC10E058;
	Sun, 18 Feb 2024 06:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TOIYZchm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E85A10E058
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Feb 2024 06:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOx9dVqiEjgge35I2b0su3As+mhJtIYGekie9bNec5ZV1FsNyJdqqvIIS4rxuL3a3rlKirUEKJey52EHiTVAzzR6fZ2uYEQ7bNtLxYsgELuSZfBIjWsRpjiFb+ibQUCQRD5KZLN64COjPOq0nbWNo9klI2DLUFNEDJpjgxb9XVM9liImVilIkYMkk5evZ1JmgN9tu6wRfbkWnVO4hhasL+XBGOoP9h6cV1iaNxJl9ZCg6T41UFUpLnndgBFEpxAPYmalKixnKCED0jKEeiAPuwMtc9u+ttkdU1P3Oc1CVI6rQKNR4Rro/75/QzL+zlmKQ0e/WnWzLX8ZBErig5zH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7OIZlca+/bgvUdwAMbsCxq9k3ghPs8QmBzOkByODUM=;
 b=WkvbiXQJdK3mhkpI9Mv0VMoLiLMn6YsfD48pkNY79ceqFM3FGx6QRDvnLJclVj2gsHcizYb5oZw+IWkXV58L075JRVULbT2fG2PD46JAFRCHk9UdlfHThX7M6l0TJP8RzWcuyn5n0uE7C5R32goHTqJ1oFo64TNBPSJf4c15RWpL3V6ZrbihDkkCLQB+1+MHUaS8JmBs5CJiY0T7vYU8lrXVBe//WQrUnmYmReLMl/EeB9ur2cx48i9GctZaMshVDEb3sRwzYLuh6D42sGUbhCwyS6z/7X1HUp/TnaE1wAyI1GwVwv7uEZneQTzEip9Oem2Qj00iCAzODoBa63hQaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7OIZlca+/bgvUdwAMbsCxq9k3ghPs8QmBzOkByODUM=;
 b=TOIYZchmx75ZHAUOSoz8ffBGW1sE3plQXfDTCnIJ8/kCpSduuOL0FEv8cL5+yRcI9h4TiCanvQr3UF3w0sF9iUN5O+vI50GgdRB61zAyZaSnwzVQSmFxQJXqI9fV6ZQ2Qca5u/rCsX+Q/64YDNck668Sd4JnbMp+e76AR1fzUB8=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.17; Sun, 18 Feb
 2024 06:56:21 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::9) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34 via Frontend
 Transport; Sun, 18 Feb 2024 06:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sun, 18 Feb 2024 06:56:16 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 18 Feb
 2024 00:56:14 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: add UTCL2 RAS poison query for gfx 9.4.3
Date: Sun, 18 Feb 2024 14:56:04 +0800
Message-ID: <20240218065604.313544-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: b68b89da-a1d6-45e7-be61-08dc304eb3db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VJgNm9OcghcIMgQRKa89SlY40RL/Ka/41DxNyavIkuMYXN+QH5rx3PLs0hyxz/i6khedJKIA3lT9Y+kW1bGJMwKEjR7h3Xw7Q0eoJZWPPEXnvbRFVmFDOrlBoopuh2S58F9t3XnXSm0bEN9trxojGEC2TyuXh0+v3/OrCQhnhFz+kxFXHqegqFj3jAKZvL01yFUPM3dQaBEB/NY65cPAEPBKTLl9EWz9zvw0IDS51kik3/Huh4fYG3iIcD178tkTZOmJHrXx9EGtNRziQOwocBKsys/8pdHCKXJd/mX2sDzB+UlVhw9HH3RLenKk0B07gVxbGVOy6hIzC800lvlOy8eR/ggxq8SLBx0Y80HbA0SJhYykBZ5xRcRIGo5htX8f5olj+OQBGqj7m/dyrDrMLZ7A9672DdcvM8vL1Bi3ElDnZzzVVH+OFmeOXBl4ItpQMwVC1BO4/x0q3SmpGmXCJ2GxnOeZ+BJ38FEFgDBm2/YKjyrTe9SrynPzF25HU2KAN7WDUJkVBc4uWwoM1C9mqHD/bGD59AxjCGwr9dOm0wJZEZbRp81zbjANCz4GbMz2BRdyuPvSLj69R88HdHsv8ummY+tB0GJBVHAQzasbz6NGdrEZ7/QciMIkHEohwrF09dMh89BhZQc53Ee9KEHBjMs90OzAZj4uuLMoEilGlw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(36860700004)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(40470700004)(478600001)(6666004)(41300700001)(2906002)(8936002)(8676002)(4326008)(5660300002)(7696005)(316002)(70206006)(70586007)(6916009)(2616005)(83380400001)(336012)(426003)(36756003)(356005)(86362001)(26005)(81166007)(82740400003)(1076003)(16526019);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:56:16.2248 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b68b89da-a1d6-45e7-be61-08dc304eb3db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

Add help function to query and reset RAS UTCL2 poison status.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aace4594a603..de04006f8db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4329,10 +4329,24 @@ static int gfx_v9_4_3_ras_late_init(struct amdgpu_device *adev, struct ras_commo
 	return r;
 }
 
+static bool gfx_v9_4_3_query_uctl2_poison_status(struct amdgpu_device *adev)
+{
+	u32 status = 0;
+	struct amdgpu_vmhub *hub;
+
+	hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	status = RREG32(hub->vm_l2_pro_fault_status);
+	/* reset page fault status */
+	WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
+
+	return REG_GET_FIELD(status, VM_L2_PROTECTION_FAULT_STATUS, FED);
+}
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras = {
 	.ras_block = {
 		.hw_ops = &gfx_v9_4_3_ras_ops,
 		.ras_late_init = &gfx_v9_4_3_ras_late_init,
 	},
 	.enable_watchdog_timer = &gfx_v9_4_3_enable_watchdog_timer,
+	.query_utcl2_poison_status = &gfx_v9_4_3_query_uctl2_poison_status,
 };
-- 
2.34.1

