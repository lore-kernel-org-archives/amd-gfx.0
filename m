Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD28ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 12:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F67110E3B7;
	Thu, 27 Oct 2022 12:19:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F2EF10E270
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 12:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT5rhd6wxpVEO1OUXSqRCuPlJLpOBWZ9CfYENL01BCbYJWImkG4izlZDI6EwXD7K70xuBu/54teZq5H4Mt9kG9QH1kvSTR4jtMYuVVdEZ06wImbFgT1zaUfWHhbQFK939b1csbTRVKTDftVm3KevhSzU4M5ruvqmPdLxejIfOBJMZ+YLiIFe9qGj9c2HK53Es/XOjwYg+fJ2sUnI0PjWgRIt9zucPN9wJhzjSD47fBGQRPZRhIB9sVPk2G3b+K5/XSITHainWVSqdtAND+90JFOw3fxQkYPP6TdW8BWdZPXdnwrbMx3EO6D3lE0Vr1I1114sbujfTPNk/Dghp7BNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoQt+Mlangla59rvjMPZ+RgLCGDCdSLHh3TfC4W0qAw=;
 b=Pd1nhRGmIb8uIwUXiGKygh2j75M/mH+kOAJqZTsDfjlsd2fYOXc9SGs7/OLe/PhVe65bD2kQFPPLBaQSwjKCG2vl1epZkKZgbc9xDz9ehC6+LUAMC0/OrBp8+2S+1BvhwiPpHF2Js2Hhg0sE30NKVm1InbhvkSmrJp73JcdpwQdOQwqywnQx+/Zqv6MX+AyPgdKn0ck6O7kUvPisPJFUiAq1fXIeTncbEcxXCbUeylHCfkUXuwLcRZKJOr69ZoLPOb7PGqGYVGeu3s+nZmiR5kR/g2aZV6ljSB2Rl4swa1T2bQdBvrd7Uwzr68GE7GE66Fo1A/fLGJJWIfJmakN2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoQt+Mlangla59rvjMPZ+RgLCGDCdSLHh3TfC4W0qAw=;
 b=xbj7Tpt0m4menwP/HWVg6aqggxBLcVEiBmSt3zm69jVM/oosdVwoy6bedTnHnt01qWbwwUx34OHW+sCtb4Vh9cuF5d8KYxQBVMOSnVjmiB8FxWO1v+q9CyG1H85KHw884gjT35ZXNv053JCvtNvwsSUdVJ3GA15irBqb7tJ9yio=
Received: from MW4PR04CA0127.namprd04.prod.outlook.com (2603:10b6:303:84::12)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5746.26; Thu, 27 Oct 2022 12:19:39 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::9e) by MW4PR04CA0127.outlook.office365.com
 (2603:10b6:303:84::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 12:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 12:19:39 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 07:19:37 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable GFX RAS feature for gfx v11_0_3
Date: Thu, 27 Oct 2022 20:19:21 +0800
Message-ID: <20221027121921.3652-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|DM8PR12MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: cec22620-4070-4c68-81e4-08dab815852b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZemqFV8NYnkYrTnDfVw6oCK0xmOze0UIiKxfRL4OGaUQQ+7J9ffiJFMivxBxgWkW6vDwQKqlswJZVURdX0aswN8MEufG4HgLesbN2CrMU4sFqy7JHtlPDbccDl+ek11Mnu4MAOmqdPneN/f+vRqMOQSnhfHmHds1WP3QNBD/iwbQECpqIcpkZJ1nBf+jGBy6Xcfcvkl2FcMlETU6Fi3hURSQAzre73y3+xhjtvcFuMDph54jxwxUE2xveg+m6qcsiMFiIgzDbqwXXK4J+CSe3KawhCU+09H6KlUcEtRYHwJXl9BPqNTu8nWM59kyZrrTvfRMxBPWLSXkQRhVy2jVeu/iFniEkBZcD1wyevktmFGK7jzNspxWdFcaOe3/OsUojyyoRtVL5g3QNXufNcw0dCvjgpK9LelktTQQNlTY/t8Tpe/xGHAXLrCvng7SZY0xQdxty8P3wq1UHGwaoems47AYOcW8eeiMpSq4kMQC3RdziYm8W2pC9qya4CHfM8BuedCzlApNQrXAuwmb8Op1dj36pz86knbTnAruvhc3CfnSCts6OQB50WRJuRd/QfU3D4akW/8v4KAPVtbfYZpY7bnSzHSUXY2+VNXRy4VP6XJV6SBr1sAiNaOtsSkrb1ybmEvvnF+KosWTfYQeF8k4RzP/44Bf2HCtoeFvCi3Qtum2xQuB3NCzBwWyOI76KZOmFUI+b4ZJfTxgaxg5qGvg/KSma7VeIJ5tkezJh0uyMQliAl0kgih8BsCHlSgLVIpms2Vh2A45wxocamWSg4pXVXWI+JNDAHRVb1bHVyRqQYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(186003)(336012)(356005)(81166007)(44832011)(8936002)(5660300002)(70586007)(36756003)(70206006)(47076005)(36860700001)(426003)(83380400001)(2616005)(86362001)(82740400003)(6916009)(40460700003)(1076003)(16526019)(40480700001)(26005)(478600001)(6666004)(2906002)(82310400005)(4326008)(8676002)(41300700001)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 12:19:39.2829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cec22620-4070-4c68-81e4-08dab815852b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

v1: Support gfx ras feature enablement for gfx v11_0_3.
v2: Update function name and error message.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5eefba2948a552..443ce664b6630f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4673,6 +4673,26 @@ static int gfx_v11_0_early_init(void *handle)
 	return 0;
 }
 
+static int gfx_v11_0_ras_late_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct ras_common_if *gfx_common_if;
+	int ret;
+
+	gfx_common_if = kzalloc(sizeof(struct ras_common_if), GFP_KERNEL);
+	if (!gfx_common_if)
+		return -ENOMEM;
+
+	gfx_common_if->block = AMDGPU_RAS_BLOCK__GFX;
+
+	ret = amdgpu_ras_feature_enable(adev, gfx_common_if, true);
+	if (ret)
+		dev_err(adev->dev, "Failed to enable gfx11 ras feature\n");
+
+	kfree(gfx_common_if);
+	return ret;
+}
+
 static int gfx_v11_0_late_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -4686,6 +4706,12 @@ static int gfx_v11_0_late_init(void *handle)
 	if (r)
 		return r;
 
+	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(11, 0, 3)) {
+		r = gfx_v11_0_ras_late_init(handle);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
-- 
2.17.1

