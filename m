Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DAFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Nov 2023 02:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302C110E1A5;
	Tue, 14 Nov 2023 02:41:06 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA8F10E1A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Nov 2023 02:41:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsSP278bINwLGTduHLWU5Efs138FMelfvRRFq2YYHO+GofIefuqCBUjnVkjadizx6+CMoZQUc5PN2biMhp40NGmtnGfujAYkM4xvH//8X165Mof2n4i9tESVF+GNlGCSMSV1uOzJa81VCr+C0Ri+wV7P759+qUnQViDnDg2FmgMubtUM3qrO8mmOXuCsp/3yBG8D+dtOj/8EXLYZDID78IdU/WnvXAhuoL440XAROGkD6Cf+ftvMBgq2tt6VHIXzZqTAS6yKA1hozEwuCmSvVz2I+E3qOcD4ktbbWBr1zoglpSa381wRGsOgE210pwrzhEkAdLN9/va8lMZooPRLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58p6RRui6FqCjU5BF82uUfbpxI5w+7sBm3OoRENmHmU=;
 b=i99ZNj5lRl4AP3WOs8YJkty/gkrSXt66SJqWDCrKtmTGT8XOfjIAtxxJcrTL2i1D/Y6tLcVoyO1OwVpzxuiFeXUym8ne+lVuRSQClG+cZpIIndSJn5x894e1Q+wppnX+D8IJ1AlQc75X6wMQe6TmlpvdbH50ivv7Vzsils9s2EKZRwIc4XfiBrRShkvdkADF+9W1SJ2yxw0OyR+Heq4Ac7MHv3irUnph18xwx2Cxpa4qvY6IEcmpmQrZzOeDaBJKEf6jLV+lCj5/11i+LSvi4lbe7ovD/sr1WtFgRSRLZS84s+CJ9g9Rg+13FEcLIjUeDRZ2ylmWaNA0FDNaP+utoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58p6RRui6FqCjU5BF82uUfbpxI5w+7sBm3OoRENmHmU=;
 b=DR96hFm2aQOYWFLaoqcgaBfw5wBMAbVB62PWBOi5URe/5Duc6WLQgE1r7SvlU39wTipYXZzT9Y9JZpoQGQpXjtIVRATyJMclGb+xoxvXsrlQMCVCPvFtSmM8R5eyevPOLGqR/SIaBBowLe7MBz3BLaLWJXjJWcnKx30mGC6GjaI=
Received: from SN6PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:805:106::33) by MN0PR12MB5833.namprd12.prod.outlook.com
 (2603:10b6:208:378::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 02:41:00 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::dd) by SN6PR2101CA0023.outlook.office365.com
 (2603:10b6:805:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.4 via Frontend
 Transport; Tue, 14 Nov 2023 02:40:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Tue, 14 Nov 2023 02:40:59 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 20:40:58 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correct the amdgpu runtime dereference usage count
Date: Tue, 14 Nov 2023 10:40:43 +0800
Message-ID: <20231114024043.1773120-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f351a4-8466-4350-d030-08dbe4bb22b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3ZyONbXuJQ0TqPtyrnptwjWF4UFSCqqlHDZ5+XSDE6J+29XhshAoEdCw8Cys4XlNxAweyduk+ajPSyQY3G8Fk7/pUIAR5JqIo7nWi+9OYd75vWl009EeCkW22gxCsXLz6aIFyV4HcDUYDMFM078qumddeQKj1iZF59R993dEmx4UCEHazoAMwuM4GcHGmulicVmmfRIgsOzJ3jn6rdsHOawnxERflcdBBgoXq8xbS9YVM8ozYoplolrUqzDWxI6q3s56U+kdScpqAdULe3XmfSSgOYpwmMIuPHoHuw+GxORbw3q4/bCDpCTFHrOm62YWPZm2VwbrnK6ISZNv0Ec0aj3O8+1mgpRXwmJbJWCK0I02YMTANlRqv75Vnfe4+ESaAKAqpIV0z6H5nrWLjNDjzSipJpeyqmrMdXeIT36+4EuHPOMWJc8T8nrTM6pGVFzHNGhemrhyhBuKERdh3RUuZtwbAST6+zJ/7f/uJ98PijIcil62gbzt8iZSFaafpEMyeBpjmKeotQb7G13ZJmdZH26DUQGzjiG3aQ4n3812QQacJeFY4fKJ8ccqk7Ge/UMCe/I7O3Q/TARZLodJwmNJIRBGCFQFJsLdz2zWzxwMlO7Roo3xcCsgD9t2dIkpPBqIzMr/Gi4/bp0+l6LJfNZRu5sGPzrKVs4ntHPRbtJwQHojJTgTKbTOP0c7sCMfG3u+UK6ZWz0CN+gHxpBTYXFKbnp2Q2osh3OL0wUye0vo4GWxHBvjEKSKPPOk6ZU+m4hbCaNIBsxNcVSkiuBVMTKuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(54906003)(70206006)(70586007)(6916009)(356005)(86362001)(81166007)(82740400003)(36756003)(83380400001)(336012)(1076003)(16526019)(26005)(426003)(6666004)(2616005)(36860700001)(7696005)(2906002)(4744005)(478600001)(41300700001)(316002)(4326008)(47076005)(8676002)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 02:40:59.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f351a4-8466-4350-d030-08dbe4bb22b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833
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
Cc: Alexander.Deucher@amd.com, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the amdgpu runpm dereference usage count.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 0cacd0b9f8be..4737ada467cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -340,12 +340,12 @@ int amdgpu_display_crtc_set_config(struct drm_mode_set *set,
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	 * we got before
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
 	 */
 	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
 		adev->have_disp_power_ref = false;
+		goto out;
 	}
 
 out:
-- 
2.34.1

