Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E1AC3A5A7
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 11:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E3910E1E3;
	Thu,  8 Dec 2022 11:55:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F0B10E1E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Dec 2022 11:55:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxryDKddg3m9SRsUrHNxNwzWCa9iTn1tL/tTb6bkFwKhAZi1isM4ORoJZMxcSFb9bdiwNrFN856vXN/vnB630lnNXxgwQII3qdGv1EVi8FBP42xVKsAC/yHFcv2CVqlAIVDrZ/BgZyeoPeuwElId8wjABhN5gaTdUswI/Nie7GKJnJSmG+OQkIMd5D++1XqO2qt/8qlS91l+0Worv2ltoMlGYXBGAi3OQ70mRFFFmak3VvYMsxZ4LZQJgDE4zwuhNyTv8y/37eCnhh3m7oWrKhDP2/nHI15HVxldGH20INffXTU2I/++us5GUzODgVgGQC/NsMFHuJyds2AB9ozEfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1gaJVWog34yqBkzROiQQShW7vDXmbdW2Kg5VAxNbC4=;
 b=F4xmwPs3l6YjXmo4y1eIuG+K2yfoGiPsmxzzG5v0bm7ghSlCx1Fyl4bHvtzBP4xCilRzVVh0WpmFFk9k9uATCu9TnTCpceG20TmMkSZdThwwmlU+67lCDZBQL2rfMlh/FCUw5FTP0vbsiEWrryzgYHR+BHZGZu0W+Kv0MCHo4tLGscxJmWlhP3ZiAh7smONePT4LH7b+GBsgVv14EUAied15JC9oVwgpE5EHq4DCo0zzFPEI6HS2eqGgFyJwjRK36BSPNhze6GoWoEUTZbYZ7uIdsXhK2EUCBXjfptjLdUvak0R+42ff2NqglmuAocC3yd35yXwcbxrUjV4rZkhgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1gaJVWog34yqBkzROiQQShW7vDXmbdW2Kg5VAxNbC4=;
 b=GPbVe8g5PPRVmLGTO+4mwDPbFc61adNIwe2le+l5udrJYux6Pn6IcMmfRg4ovg7T74FjoCkdEfu7JizT86W3ZjMI5ohXH1Ps97irBdjg6cllG2wrlmd9ONarbOCHRMsBLEuG7KCiHamJyeelbhFlNRanH0xP4BBGr6nLKFi7+PY=
Received: from BN7PR06CA0038.namprd06.prod.outlook.com (2603:10b6:408:34::15)
 by IA1PR12MB7664.namprd12.prod.outlook.com (2603:10b6:208:423::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:55:41 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ad) by BN7PR06CA0038.outlook.office365.com
 (2603:10b6:408:34::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Thu, 8 Dec 2022 11:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Thu, 8 Dec 2022 11:55:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 05:55:40 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 03:55:27 -0800
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 8 Dec 2022 05:55:27 -0600
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add an extra evict_resource call during
 device_suspend.
Date: Thu, 8 Dec 2022 19:55:16 +0800
Message-ID: <20221208115516.7280-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|IA1PR12MB7664:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdac1f4-902f-419d-504f-08dad913211a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7mnK5U9T+dfLK9rN+g4VZtVk4Nslzx7Jh3W6oIiaXocRUWL1zVnuGqSAi+rnoMvkHjW3u4/TC8t+25v5g8eAaEL1ur7y18sadfzgb+R4IbXuFdWNx5UPkBA6+WWIZmO5PbHTs+faYr/PGyvXXfEangf6ZiovVnCnsvaBiBqcqc/74uVTFeNcQ9y7q8OtSey6KIOlkk5PrKZF6ao8tZb8KpUr5ZEieYCXH0ESqRqhrLd7LBApprkr20z06cIVdg8mXr2uNtkC1PzkXW74UDnTL6iPTlPDZbGibR1KpQ31vFqtWXVW0plfrRNN8x6lCnXCPNp1okzjo/R6hGLC1mqTvb8csCbF+BCI6U1lyrnMuMazEET5nwHSLOb+KjcoB2CjbyXv9QpJRQmeqsNOpv9NtmM0rGmfFRRMpViKeNO/gi33qMV8OjYFwWipiE57mYBD3uOPFPN+4Zgl3iRvBJhpBHUqT/dgp8/Jye4zxX5yKLbCKkobqu6gj9k0acS09GggcJCTR99uhVTDGj5G9XWlHJtTxk0psl5lEjYpfIO9M+qdVIcnq58udVqnyf6Ddgl+llu3U8/F1KpXGueY56jlo9Uu+Y2RdIPCfd9GNROM4G/ieJkLaoNskbGRB+Q36hvMwYofNZw+3akSegYL+o0YbKUKIQkhAphU/D6Qw0EiYmDzROr5J/FP1XaZ44lRLkCj7HlWCItGKtkDrDV09v+e/IqyTQJA7vRtqidFeU4bvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(36756003)(40460700003)(86362001)(478600001)(6916009)(186003)(26005)(5660300002)(4744005)(4326008)(8676002)(6666004)(44832011)(316002)(70586007)(41300700001)(8936002)(2906002)(70206006)(81166007)(36860700001)(82310400005)(356005)(82740400003)(7696005)(2616005)(336012)(1076003)(47076005)(426003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:55:40.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdac1f4-902f-419d-504f-08dad913211a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7664
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
Cc: Shikang Fan <shikang.fan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- evict_resource is taking too long causing sriov full access mode timeout.
  So, add an extra evict_resource in the beginning as an early evict.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 818fa72c670d..b76e8fdfd266 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4111,6 +4111,11 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	adev->in_suspend = true;
 
+	/* Evict the majority of BOs before grabbing the full access */
+	r = amdgpu_device_evict_resources(adev);
+	if (r)
+		return r;
+
 	if (amdgpu_sriov_vf(adev)) {
 		amdgpu_virt_fini_data_exchange(adev);
 		r = amdgpu_virt_request_full_gpu(adev, false);
-- 
2.25.1

