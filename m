Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E036CD4F48
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 07:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2D910E6A2;
	Mon, 18 May 2026 07:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yGMgQLJv";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B219810E6C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1JY5oBewtnXARg0Lis1hOhccDQLdeExCrXG64uO2Vn7luY9sybf9ps8DIxGX0PP0HEgm36PRVcPArIAwBDYuunCHmliWJ6R/45KU7lV4ix5WxDZIpXwS22YaGxADtnEhEmh1Z1yU4m0Gm3+kMRYd2cE7hmhL4al5uhZYM8+Vl4fAsiMuDRfg4XdRjJ3KWzQUMqDqJNTwjxlL897OxZ9TMMt/ag11+WyY8+5yCn29tlst6Waio8VMmWHabF9+L42Mbq6xAdOBfq8kCZJ9qFRTHTP5ptgSb5DGwa1/cK9xRJGwhnjbcnJ3oMYPMlEpEYkZvqcFvxnd1cg4HddZO89sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUjKHoaXLflhmUTrwB+pPDcRCi9atB6wnOaPr0K5+Lg=;
 b=GP+tz3cPIRoDL1K7AWXb6figvjglpq1abKImoXha30gdUO29u55JTujpeGu9pV+oUatA37xCQqGtCO8o6A2dgdK/vzzIHZCFoyaStfplh6uQ642XgJBEPKAcuwVEOBDK7cv2/yzz1WUovgWJ2fvICXAShWzu0sP6FbezOZU948m8b6rY8yGLIsb4tMck4tajbAmK+USmhxoy9S4h3Cz21hx1UzPOLjw7RZDx53sS7NT7U1np8dbwsKP4mh+RYD0xuam2uuP30LNEHV6QAWN06/J+DTiwyZApMVd7hbTA9hhEj/4OnB+nYL3XkTpY+fYHHAw4gzxcGYCfelkQ+o9lIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUjKHoaXLflhmUTrwB+pPDcRCi9atB6wnOaPr0K5+Lg=;
 b=yGMgQLJv5hOFKtvz8wrWXtxwakQSMp27r++7Y/9bBgUZYtpj2zk/zcX7qM5cHq8FyKFlyTG8H1B5+ixs8abq/1vvngURM7dSzKykjwVbveROFbvc4U1RvWqz1D7ldiYaZ4L3Fs6FxQ2BGUd7X5Sn2CeU7BzEDIc0XH8FhR33Em4=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 07:23:26 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::ba) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 07:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 07:23:26 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 02:23:24 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yipechai@amd.com>, <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 7/7] drm/amdgpu: check and drop invalid bad page records
Date: Mon, 18 May 2026 15:22:15 +0800
Message-ID: <20260518072215.3647120-7-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
References: <20260518072215.3647120-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: be5de2a2-cd7a-42c3-0f63-08deb4ae5a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: l1jSlD49WE0UWM+lGzmdVYCzup3qPzi8v1UcKSOpxBvnNLrjTW0tNzywvTPrBqPhIuM434LSVFzc7gWKTbzr/qClddo4sK/7Z5blhUuBoEcN2sx4bmTwmcTim1BGWHl0nYmi6emzoLYDrLPxyfSq9Gb/AJf/iptDUpDfTK4RjNPRaf8fTfTOIKl1d9ODRmOm8l88SKz5DWYTI92EyuTFgojh5gJ7YbngbfH+tp9a6ylHVR0vg5ZBwYgknIA4wR4Y+ym21zOXVLVlsPdQV2l8lkw10VQ9kvjmmz7k53BfZDOWhurcBsWmoIkaebCu5r0fpMxKMqE7MDTgyGjekHrbUm1IzGQQjeuwNmQP//WyusnB97IDIgShyK72NoRl7som718GCej3kU63j7jf8ZdGI3w9PbF9nMmsRos64KOMvYppMSVXHwiytAFCoB3bEXngq5V9iOQiGIvNwMLZcOMb+iMF5da3F2c+AzHTkFSmDDjtq07kPFehXznFZdZNPgG9/WTxAubczk/OyUxfjsEjvGBJVzNXEbOSVBaRK+mehwcGGx00nxRhgbHzaohoAJ2Vfk/XML4fpF3D6rIYVtekISLatyuUzx+MrRWvARBS8nAO+PHmJbnmFYfzu1yvs9n5rFNiEYLThIi3UCGdRnu7bmw584sh2HjAhAdwFP5cleTiMqOkdp7m1vcKsvT72lfuh/zduaSDPi5g50nJvwlYkFT7TSO752h2Ee+1MD6Nugo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vwdFrgdctJP3rIfUmEEMJpH9E5EsWXtbz7QXC0QAv5UWwqJbVVfwJ61E4DWwPGPy7U/+O3oHnNGMSUvb9XwAzrjYp+BtkpGjoprASbYDt8fXIq5w0PjK3wwxwnVzVFlSyXvJEZgLx7Fixqc5WqVamC8NB4wz+gJeoUh7p8qSMuLvhGpOKgupunxe4LGc6K1UzT2VsEtPcSfdgasTG3rj4gHfS0AxQsL/74+IGTbwyT+6ImrwVDLVQOCle4/gL3c4BRqD7xPdGImsC/qxhyMhbQ3FuXXjncVCfyvrqCzapdv4LYrkSsqM4ktZs5r1mAFyRJXFHHDqPKSK7Xh1H7NCCBUwmFEbMQHdZeNBYHbbyygpzKnRFiMwr29T8fZWU7ZJQXPZwFiSUCcWl2dEmghoatkos1CPbZAg1o3Wj/qki9fkChx1jD1rmnFy2jokGLYM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 07:23:26.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5de2a2-cd7a-42c3-0f63-08deb4ae5a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583
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

Check and drop invalid bad page records.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 27 +++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 57f13ad5605a..b0ef0800b380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3094,6 +3094,20 @@ static int amdgpu_ras_mca2pa(struct amdgpu_device *adev,
 		return  -EINVAL;
 }
 
+static bool __check_record_in_range(struct amdgpu_device *adev,
+			struct eeprom_table_record *bps, int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++) {
+		if (bps[i].retired_page >=
+		    (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT))
+			return false;
+	}
+
+	return true;
+}
+
 static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 					struct eeprom_table_record *bps, int count)
 {
@@ -3101,6 +3115,14 @@ static int __amdgpu_ras_restore_bad_pages(struct amdgpu_device *adev,
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct ras_err_handler_data *data = con->eh_data;
 
+	if (!__check_record_in_range(adev, bps, count)) {
+		dev_warn(adev->dev,
+			"Recorded address out of range: 0x%llx, 0x%llx, 0x%x, 0x%x\n",
+			bps[0].address, bps[0].retired_page,
+			bps[0].mem_channel, bps[0].mcumc_id);
+		return 0;
+	}
+
 	for (j = 0; j < count; j++) {
 		if (!data->space_left &&
 		    amdgpu_ras_realloc_eh_data_space(adev, data, 256)) {
@@ -5642,6 +5664,11 @@ int amdgpu_ras_reserve_page(struct amdgpu_device *adev, uint64_t pfn)
 	uint64_t start = pfn << AMDGPU_GPU_PAGE_SHIFT;
 	int ret = 0;
 
+	if (pfn >= (adev->gmc.real_vram_size >> AMDGPU_GPU_PAGE_SHIFT)) {
+		dev_warn(adev->dev, "Ignoring out-of-range bad page 0x%llx", start);
+		return 0;
+	}
+
 	if (amdgpu_ras_check_critical_address(adev, start))
 		return 0;
 
-- 
2.43.0

