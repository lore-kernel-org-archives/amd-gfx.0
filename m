Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78464EE14C3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 03:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65AB210E852;
	Fri,  8 Sep 2023 03:40:37 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605FE10E852
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 03:40:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON+AbK2jSTG0+erlgx2g4KwZuuyxTuf0B/6TkvCIE8DmHqppSklaaMIAPL/nxhh5j34b/zcKpmtkDcLLcqT3hgdTyzJhoU+cQcsqJ7ihI/loBMq4YO5zHXTeD4hUc8vfwzhyOJPfOmXuXBUq75EiYhS5GgHLEuM3W957rCdyx3HEkT5KpwNQi10/dOzSZRjHB+++4bl+NsqcN/uXrBsqipP6tZCtTzqdWKFDKbX4fvViE8kTTZpnk7NIesh7HIXV2N8CpK1g6pcgs/WlJE2+5+enOPH5f6Y7C3UOyiOI9aX6+bnnbqvCTnAgZbtI95dydYxrdTFH0DAMDmBWdMvgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J33mG0WG1BnPH3TCGWFTX1F37sQch/veASfiAEC7+HQ=;
 b=OapbheaI84KTKNSn/6dum4eCa0qAj+uvWbPTg6+K+BRSNlat0O/DSsZjiArPpztGjH3XasziZEVdayKCPRzjqE6bPOSRT7YYFqgEZgzS8jgymJsPlNKRgKs00NZyBIHmRE8N+ghbx8NVjO2n02cfv5uKj1BHoPGBkKeuhoy5nUFTRVW3AhQjVycuQRmQYxC3UPv1mnhKh/7NsS9/5wLicuGKtzu9ESI6PpnY+ksjni5zCReQDutvyp9rAgvvDBhLgCIrsZIdvuKeqxyvZKoJyD7BFxqO1PZ9fBz+SEWb2HggWXfh8EAGiLfYsScHtsjPoVf+67QGQ/JMp0DPq2SNeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J33mG0WG1BnPH3TCGWFTX1F37sQch/veASfiAEC7+HQ=;
 b=DLfzBRT2kjUoei4llYbfCFXawfBVD4rvsZ+gzb03Y4+F7nB34H/ogRREbOAN85NLdnaeALd4g3RELqCXKxz9XWTpb8Vhr/uTfypT/Syv5k4Nr6grDId0hqR1aFpqZwlduiObIFt3GcCrBjbqh027ebDJ8HAD9E/2MTL/wJ0rEOQ=
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 PH0PR12MB5630.namprd12.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 03:40:33 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:bc:cafe::d6) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.10 via Frontend
 Transport; Fri, 8 Sep 2023 03:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Fri, 8 Sep 2023 03:40:32 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 7 Sep
 2023 22:40:26 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Ignore first evction failure during suspend
Date: Fri, 8 Sep 2023 11:39:52 +0800
Message-ID: <20230908033952.41872-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH0PR12MB5630:EE_
X-MS-Office365-Filtering-Correlation-Id: 95967dc1-321f-47a9-db2c-08dbb01d5ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uEWXMXS+nKrqf08DkYcbAQK8r4WiLfHsFOzK6cZstezenn2rWgS+cNBKvp4P64iYED2AIwOYGCkYHCGYJqWjOLSdQUhxPwGSJhJdIfjkS6lrlEffWNj9pSqhO8lUaw20rCdU+1IZ8PGHR06BLbBpq1fETs236dNKuZGGW1ZslmKbFoZmJE3Zq1x/NwjxrG5b740SF1Cm2RTsulx26n4GB5nAcso/QHLL5W7o9+99yQ2xeFA9uCEwlMRluF9o/V/OHsW7c/ZufQL/gM8sJHyhrfzWk6bq/t2o22mJS1I3EUHuLxRPpZxgdNyIWEHhAKYdY3c3Bz89rEByxUOPu16wBlBmsADkZUYDiFc6noPhz6uVlYR1a8YqM2FGJNFVr6iVZRp8P8Y5TjYfMcRxn8OWzJ7vzTMCIcQsEYK1jcUrCDKqGzuZxwvRgZVIYh3R7fh7u7ZFxaAvRH1ExF3uOkWJ2JSr+QsGCcAnB6rMmi4/A+817e/cQLP9fC01u0m4nlo8UrWdv3CSglbOxHYJ+dv4sTvRbpAceuNnbXNKQhKsqd70BQpa+4fROQBbGPOBYv+aUTB8+xwx4RX4ZamUW0hp1IG2Qukp1oo4ykCWPgWzzG2S3R28CJqk8fVVMXV2mhrYyjcR+03pWoXb+CeouHMAZ4chC8la/n6LJls/I5Y8rHKuD0SBqJendqiexiDSFJZGiPo6LKM8cnTphxacBfLmDQdGJkbXSkxGg17r+jjZqXAnRcfHpB/beHr9NMqApeiRSqYoi4ys15XPq3ZTArirQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(15650500001)(41300700001)(36860700001)(5660300002)(86362001)(6666004)(478600001)(2906002)(316002)(8676002)(4326008)(8936002)(70206006)(6916009)(54906003)(70586007)(26005)(1076003)(81166007)(16526019)(7696005)(2616005)(40460700003)(356005)(336012)(426003)(36756003)(82740400003)(47076005)(40480700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 03:40:32.7345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95967dc1-321f-47a9-db2c-08dbb01d5ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5630
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com, shikang.fan@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some BOs might be pinned. So the first eviction's failure will abort the
suspend sequence. These pinned BOs will be unpined afterwards during
suspend.

Actaully it has evicted most BOs, so that should stil work fine in sriov
full access mode.

Fixes: 47ea20762bb7 ("drm/amdgpu: Add an extra evict_resource call during device_suspend.")
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5c0e2b766026..39af526cdbbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4148,10 +4148,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
-	/* Evict the majority of BOs before grabbing the full access */
-	r = amdgpu_device_evict_resources(adev);
-	if (r)
-		return r;
+	/* Try to evict the majority of BOs before grabbing the full access
+	 * Ignore the ret val at first place as we will unpin some BOs if any
+	 * afterwards.
+	 */
+	(void)amdgpu_device_evict_resources(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
-- 
2.34.1

