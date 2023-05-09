Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1808C77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B89210E41F;
	Tue,  9 May 2023 22:12:49 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E3410E41D
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVzsADPHEi3wRIVxXcH1FrfKcP/WYa9fgJSyoX7lWYPR1B36JbF1IXuYGSJb9HCupMWIU9BccfDBLgLijldzknYC4Y3PHDmiZAThv0QNOhAOwPlkST3DE1DGy1LdK+aqmv4nuWQSPLzw/nRkHtdjsmk1/zWJXH4huExgbSpahkeD1hRhsejpWQK3B1onhi1+TF/+F39MoW/1BS7IUv0l8kqSI7edrkQlyx3uoQKRVmtDcbSLIaPLHl2qRHrhkBQBNlbkTME8m3BfzzP3xLNsV7Opqnnku1fGxT36aZMBDb+fzcJeBlDXetJj25Ta/knaPiy6E9/8oXN+eKjvABbeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b8A4i3T+F1zoAW9a7oYF4tNdcfLb/dK5Pb6ZaW9XBo=;
 b=g+VXlkvf7UzjISWESnHqAQIV+tBQDFtH5cmfoP/CYxiV8Skq+wkKx34ayADp1szmTJC+ixzb8zb6Ae2p7LfgIod5t0gZ8R+rvPUDoydC9Z3kGtcawcbron/64C8QchK3DeLiodQzCxjzcFee8/j5EO8e69tppc6q0Enol0uNCLBoHOVhcDJc41K3uJecoti83I5GrW/D88wQYsmFfQRE0TnepSxaetxC79ZrG1pfAVDlQzudHAho/1ddBNj5Wldb/IBPJxkc6gJxf6TrAsyr0QnyxYlgOcKuAQFkv/xooFbjhcFNRyk/pej6ITW+ulJHo9ShZ4dh/awPv5olAgrplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b8A4i3T+F1zoAW9a7oYF4tNdcfLb/dK5Pb6ZaW9XBo=;
 b=ptqUcLcWf+C2FHN9xrqhe3w5oR5qkXDBfBr7B2zNb+l4Cpqs8/Pon5YyMBbI3NYyOSj7YfzWjIHAENK4PV8yvAFCUeo68cmQxJDdKkFHhmNiY2PLiFJpK6AyFd6Le41H7vbF2FdJVKvstAUkYwSiHvmFAzvxuY8GurVZDCCQP6M=
Received: from BN0PR04CA0127.namprd04.prod.outlook.com (2603:10b6:408:ed::12)
 by IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:12:45 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::33) by BN0PR04CA0127.outlook.office365.com
 (2603:10b6:408:ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use GPU VA space for IH v4.4.2 in APU
Date: Tue, 9 May 2023 18:12:27 -0400
Message-ID: <20230509221228.476412-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221228.476412-1-alexander.deucher@amd.com>
References: <20230509221228.476412-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: db771002-8667-4d4c-9383-08db50da83df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjluuUXzfqHq+fGERQiyXf9IeG2WNWvVlmlKOGvSdN2XMnRorXtCIA5UHxWuDVVCUBCT9r7+2FbdowILfBINvk969ej4kgopImA/VYOB0EGnKBXTWfv1KzpvNCTPvaaO9xCWmrsO65IU/pK27YhHy1uZ7pv/tZwWb3B8giwRbEQVCo76QzW7Ynk0qtNMZ8LtCCpwgxad4aIHJwcC53kFb2DvV8bWJbp0RLnXUgPb/XYJUTQ+s/FNRuaAv+q1mi99IeuF874Ub4OYYWOqOaqg7g7YUQrNayAYgziBflQZjOHiaKha2EAGJ8GiiHHv3iutJyGdM3+LzQ1qS8VN47rKG38g4qD8qLAW8NlCfiAe54tWUe2FVJ9OA5Kn0lANRGXEThJJWoxOhEwbRXrl8Ir8UBtRNyDASFlPk5gOWYasupdsT3N/5W/Pyoi0kEP9IVwuMqeLtwex09N9nVpCBcuQAmrntGoDAXJXV+/vLmEUb0hqqzNyekrJs8bHX+u09yIKKm5y/chT1iXB6OwJUUVfk4VhmfU2CJNWYX7OB7qqGEortpDZINnyjAVF/47P/9KSbDkoI7nAPsYlzhJU7MAO0QRyjUG3eEwX7UIBYdL7IFIOf3JIyXw2IJGXzR7bXFX3s7P//MV6MyHYVySrORxotvoIfRHUHBkenPHGjRKtQ4Py96DjG7NFgB/AkQoI7Mp7pXJT+4yl/OFsws/jKb3KfgAJvK4PXkmqpTQyp/5e10o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(2906002)(8936002)(478600001)(316002)(5660300002)(8676002)(6916009)(54906003)(41300700001)(16526019)(6666004)(70586007)(70206006)(7696005)(1076003)(26005)(186003)(40460700003)(83380400001)(82740400003)(47076005)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:12:44.8148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db771002-8667-4d4c-9383-08db50da83df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For IH ring buffer and read/write pointers, use GPU VA space rather than
Guest PA on APU configs. Access through Guest PA doesn't work when IOMMU
is enabled. It is also beneficial in NUMA configs as it allocates from
the closest numa pool in a numa enabled system.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 536128447b71..17ccf02462ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -526,6 +526,7 @@ static int vega20_ih_early_init(void *handle)
 static int vega20_ih_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool use_bus_addr = true;
 	int r;
 
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
@@ -533,14 +534,18 @@ static int vega20_ih_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	if ((adev->flags & AMD_IS_APU) &&
+	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
+		use_bus_addr = false;
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
 	if (r)
 		return r;
 
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -559,7 +564,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
-- 
2.40.1

