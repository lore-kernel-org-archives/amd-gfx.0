Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C5DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 05:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3E810E2EF;
	Mon, 21 Mar 2022 05:45:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 663EB10E2EF
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 05:45:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY/JjIoP7rIp28eZNT6+N4F7zyD9HvZcy3s4sQ8ZcWsaiqCVLkGOyJwasnnr19wtiJTWHKG+sC0yVH4wdmWw8nMZKAScDYaXjAFRd2POkCt87hmFa41cl/Y+ozBF3JIcWYOL1NyfoTbKzwY06Nh9yozKrZNKgffYr9B7KrwzuCtpf/ykQPXl6aRHz7ZAlCADHkaJDI7K93IWbiZ7JQYF9c2IRn6t8I/3crSL84WnD+BqCGyTHdC6ZoJZyy1f4F/fqa9P0PPOFBKkJKhITxh2EhLnqIKyx44iQlM0oqhK+QnQNWrO6lRC5a4CcSzLK3n5YAEbTKTFQAwVinSoMnzNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKTvmXrqcrmjhxROic77Bx/0mb/HMdqEF0IvCtfZ3zU=;
 b=JeeKG2f7QMmrppOtpf090qfFrn59MYSxOCh8pevQMWp+I2yLAgcGpkmAb/KKkTee83r1Gb1epcGIEo0847IbJm4Wzx7WWHvkKeAXa8E7hlW3tTeLL6InZuqB0m5bktkjUUTSSaQlWrcoO6ehMJNIWj9W42x57+J7Ng6etRsU3HD+Rl4RAgX5rTtdxpUspC08JBF4q8n2npahTGucWd2FWp+IivyPNoufkkyB4tT5fXdGcmbKffCVfIPa1c9GSTEAQeTpOl8Lpj68aBUGIMLb58aK4sP+Kf5TdESR643x6fXFHTsk7SXOGKSFGg/BhL7HUO+Py9xka0n9n5bYeiaFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKTvmXrqcrmjhxROic77Bx/0mb/HMdqEF0IvCtfZ3zU=;
 b=ivQOlaB/UkuHhI9wokSkpF7ittsuDndUEJdiUjhrqSXA8H27ZWKi6mNHE5420Yu3oHCVkxyQMmdn4O0bDa9N7R4FFWMmTXiLmlV8RkO9wGfvhjmkcoLnTlnIULRQ5DaKliiWSoz4ZxolCZzUZzFJy/vonRxPefJ+8+AmjoWyITg=
Received: from BN0PR02CA0009.namprd02.prod.outlook.com (2603:10b6:408:e4::14)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Mon, 21 Mar
 2022 05:45:37 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::c3) by BN0PR02CA0009.outlook.office365.com
 (2603:10b6:408:e4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17 via Frontend
 Transport; Mon, 21 Mar 2022 05:45:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Mon, 21 Mar 2022 05:45:37 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 21 Mar
 2022 00:45:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sun, 20 Mar
 2022 22:45:36 -0700
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Mon, 21 Mar 2022 00:45:34 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>, <Evan.Quan@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu/pm: add asic smu support check
Date: Mon, 21 Mar 2022 13:45:33 +0800
Message-ID: <20220321054533.15218-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95bcbd9c-92d5-4b44-a9ee-08da0afe0691
X-MS-TrafficTypeDiagnostic: MN2PR12MB4112:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB411227C8D001F64F1D05B94C9A169@MN2PR12MB4112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBZSush9nyvK4hv9JeL/F92N3CusZjqyWtM6gc0fHZQ6a8D/uEnqvPRLvRQ3AKHsc+iw/mAqluUXyT43D5/DxnsekkFhEsxS8SdcHGfhNsxmfA93eRV0REnpmX2iXZhLTe4mS6oKM9S9UHexc890ZE+7Xk4i27tYovEYCOfSyIwKzYR8pMxZtR029fd6ARylX+qDKnHJ7fJwN7pGIfszQKihI4RRFksLiTGPmFWHzuXBxaHgdKyr+lXtWhW07fJSNX1aHVAijdCd50+szJ3r8TYBSU7fxzTXZ7IcAy+CZSrNbiyUJWlINCbmq8yy61vkRyfFz29/p3hskLeJMG8JvZ6SV3qv121iax44OS9jEGpHwLPFaQWYybnANCEvFrowKjiHinfhXBRDgOij0z3w8bXYoaCWSbRNdRc0W/h8wU5EGQbsyoPKQ5bPCWleWVG4OB43py+AQ+CxJmdRqCS68Bw11W7oXxeKPz4yae7TJIfM/KV6noBCpm+pcGnqcwvgNIukC/8nxUy6sC4fO8AQ0GZxKaBumj2j8Iw4seRpK/wW8aPRXhfcqBUmhC3zDu7R7WyORkdT5fli3NNGWz/MZ6kT1aJlMy4Y8vOrgO0CaWlXG5sC/Pfga7WAZeX3ufcuQp5L7rhWsavvnTZEX6HGUbnyvNXrgplZn4lSrKVCTnuOjtS6cR6P/pEF7FeALR1bOMBPTWG5IrIaaqVKT4tVkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(81166007)(426003)(356005)(83380400001)(40460700003)(8676002)(4326008)(508600001)(5660300002)(36756003)(82310400004)(316002)(7696005)(86362001)(2616005)(6636002)(186003)(26005)(8936002)(1076003)(47076005)(70586007)(70206006)(36860700001)(110136005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 05:45:37.3901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bcbd9c-92d5-4b44-a9ee-08da0afe0691
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It must check asic whether support smu
before call smu powerplay function, otherwise
it may cause null point on no support smu asic.

Change-Id: Ib86f3d4c88317b23eb1040b9ce1c5c8dcae42488
Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 89fbee568be4..c73fb73e9628 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -500,6 +500,9 @@ int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, uint32_t size)
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&adev->pm.mutex);
 	ret = smu_send_hbm_bad_pages_num(smu, size);
 	mutex_unlock(&adev->pm.mutex);
@@ -512,6 +515,9 @@ int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, uint32_t si
 	struct smu_context *smu = adev->powerplay.pp_handle;
 	int ret = 0;
 
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&adev->pm.mutex);
 	ret = smu_send_hbm_bad_channel_flag(smu, size);
 	mutex_unlock(&adev->pm.mutex);
-- 
2.17.1

