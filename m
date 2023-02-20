Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EA4C6379F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 20:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37C1D10E793;
	Mon, 20 Feb 2023 20:16:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B83D10E297
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 20:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+dWCelx2UNuw0CKcj/dr2pOwhiAb80lzk39WgHRlbWRYN0LqBCe9WEKo0DdI17noiEOAgNQ6yKGIzdkzxBo7ciqjPLGcvMF0uww6tGHTVPx/gLO/pXaVmdVa87aH9Aj4Bfqa9Kjeef6cph1zzzO3LVBWlGI4ZopsYp/tObHniuCCfq7fWP3TTQSa87Hq+vTHP3G3X0m/pgAWXbl87dZiCMEVGPIOHnqJHIhXXcvEJe5ro0+uGh0y7klYG3yGQAkCa4NRPta0AWiCy4BJRJK1S4rW1FRCVguGuTVuVUOlycaaGkp5dd7cy5qtH/h0f4Orei0OI+NDAzDG8s4JrwGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbQFCxo+0iGIabEMmBUBj9fkrYg2Goe7P/4GyZZ5u8Y=;
 b=dEtX3xKwe9T6kHnTdiTnOZnj3e88n1MUDUj9oe+eJa1AeXQw5cY+hwTRAKxXW6BP9OsJ9K786Ceo/QlLe+hQmQGV6CUgsWYExO/Ir3UBhEvEnOhCclvFMcGht1FxIGWQaB+FSAPbZGzBzjZtiPXPckdVycwwI0+2719xaL3qGb1Vi5rXzPg/1dlRmIEA7O2myGri+lb7o2SPsLFW2AwrdLsdmGw/lqVVxtqJyVxhkXBGufesEkX9GGE4MhbY+klyaxAhnxdGRCOOE2m0F49BbNDDW/9UakSIqQ/slfQhf89b2ihSBpQRLAxnt+x6WWMESEq+VWEyicf2NjHXiw+wpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbQFCxo+0iGIabEMmBUBj9fkrYg2Goe7P/4GyZZ5u8Y=;
 b=C4M4pdNaELx1Dsa6XFm0+NuDCmepFAXqHvW+4CpZprtduUdkjjlhiTwt0i3S4KgCHtSgBqfpzDxuQofDfg2QecqrUiO09VcWDOG+dI3khJgbSQSh7O8uiqAznt6P/y04gqxe1HzWYB8eqUNtENLqyDo9WQnIK6zE0oD0W8kIjU0=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by CH2PR12MB5018.namprd12.prod.outlook.com (2603:10b6:610:6e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 20:16:47 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::76) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Mon, 20 Feb 2023 20:16:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.17 via Frontend Transport; Mon, 20 Feb 2023 20:16:46 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Feb
 2023 14:16:43 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd: Use runtime suspend in lieu regular suspend on
 supported dGPUs
Date: Mon, 20 Feb 2023 14:16:17 -0600
Message-ID: <20230220201618.25962-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220201618.25962-1-mario.limonciello@amd.com>
References: <20230220201618.25962-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|CH2PR12MB5018:EE_
X-MS-Office365-Filtering-Correlation-Id: 28402a02-5920-411e-a0e3-08db137f6461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CWPL+tbraA2tIwwBLrYq6euZGMoeW6XrZuBkwAJTvpzGt7QjWbDcZrlH0l/X5Av5OFjPrG+v99tkmQpOdgBAPxQaWa4EICQYwEAdG2rk5DSRjymOqYqP1O7nsVCpxYFktLaUbnPTSOSn1k1y13mfVRLjG1lXfPqzm40FY9T/qlQXe+rp0oXi4ll0MOXkJIUJkpJxnpcfRIvw3wQE3FCWpYFTmieabWv6tKafWiyOoNJ+GE4IDITQp4pa0QSzit76lyDAboSmmEI6ckSRYavw31UCtLgSMydGfTv6wVIleKpooAn46h+M7rfOOj/TR3OzEfWgn3WctVESoF9shcSEqAEEHsHpldI4UuXU9uJxEFmvKs+33zBLfIYPodBWj2FHfZ174swYLzaAcQ/YbylbGdad2M8Pg/qwNJSFJiemOiQuHyPemK3Mco9qJ7HXk+EVAZvStwHPJV7MK5yxiq7T3pwk1uY5S3yDTf4DXctdiaqMxoLIFRjJYSv7YMJQG0q7Qc86W4/lpqjcaYj/b0wuZxpTm1YBYLfNVManG8aDYUxPXYcKtcT4seVwQPlbO4PcH+UcXu1/3znDebqBBzImKdZESKrxmFw+LZncOsak01MWxrgF+gjJF22+G6w97YunW6zLCG0LcqGiF+wfeKv83sNInUTubCH8Oikd4wPzL6HOmAift0JKUXUkcpVy/VanV0DZhyhftD/oxM48SfaWldWZJFJpWrd9ePM8rThuOSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(7696005)(44832011)(36860700001)(40460700003)(83380400001)(54906003)(316002)(36756003)(6916009)(8676002)(4326008)(41300700001)(336012)(478600001)(47076005)(426003)(40480700001)(70586007)(70206006)(356005)(6666004)(1076003)(26005)(186003)(82740400003)(16526019)(2616005)(86362001)(82310400005)(2906002)(81166007)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 20:16:46.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28402a02-5920-411e-a0e3-08db137f6461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5018
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
Cc: Peter Kopec <pekopec@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The PMFW on dGPUs that support BACO will transition them in and out
of BACO when video/audio move in out of D3/D0.

On the Linux side users can configure what sleep mode to use in
`/sys/power/mem_sleep`, but if the host hardware doesn't cut the
power rails during this state then calling suspend from Linux may
cause a mismatch of behavior.

To avoid this, only run the runtime suspend and resume callbacks
when the dGPU supports BACO or BOCO and the smart flags didn't return
to skip these stages (because already runtime suspended).

Cc: Peter Kopec <pekopec@redhat.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c3d3a042946d..fdc1cbf8ad10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2418,8 +2418,11 @@ static int amdgpu_pmops_suspend(struct device *dev)
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
-	if (!adev->in_s0ix && !adev->in_s3)
+	if (!adev->in_s0ix && !adev->in_s3) {
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_autosuspend(dev);
 		return 0;
+	}
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
@@ -2440,8 +2443,10 @@ static int amdgpu_pmops_resume(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	if (!adev->in_s0ix && !adev->in_s3)
+	if (!adev->in_s0ix && !adev->in_s3) {
+		pm_runtime_resume(dev);
 		return 0;
+	}
 
 	/* Avoids registers access if device is physically gone */
 	if (!pci_device_is_present(adev->pdev))
-- 
2.34.1

