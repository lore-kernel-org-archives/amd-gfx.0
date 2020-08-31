Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD7C433E2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95D620719
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2i/LPxFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95D620719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C1E89A88;
	Mon, 31 Aug 2020 15:51:04 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690053.outbound.protection.outlook.com [40.107.69.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A531089A88
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2020 15:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+DyONVdSXnPIvWiZomNn2uTqradwUxXARx41aYTiVAx10nqLF6PBW61HLS5R1533/sDmUV3tbGeN6Gmg52cVMW2nB2IlLaCzU1LwyhMkqtw78vLF6eFk5x63hajxn5zUHJeltCrhndZhSCtcBjSw0SpJgtJrM6m/ZXzD3LVE5SAIFUzqj/FywZXseU7f+DGhZfQOEv2Bg6vDxXxf7flRvoRglpBLJpCNWNt9qUVqWkF2wkz/gn7wmf+g/T97ahv8HaXI8OJkuvpMFQklLV0stgyPdovpMREecd5mw2YULM24ZN6Z16iABylINmE0TIlrbZTGeS7wRz6wwkwA2VvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njqfqAfE2T/C8HMQQoO4xS39I4xrNa4cW4LVRBiVcF0=;
 b=Cm/xu3PyxA+zTBYy6bmXQiCwcflCy19+/8FoYwQQr6mUItoD5TFQ+jXrEyX3XqnWTXOI/iiKOajAkpGDN3lfJBCiUVpDl2Nyku3Aqn4DR5WJlUdhN6PfjeN4JxcA/2bocnnq6bGhao3vgtVy5H0iwSTxSTlSac4Xay+r2eIuddOj7X23x5r94iV3mMRTePMYRJNxr7LrtwTQCoqJXW4hYelR+YUM+RRt3CqEmd4uC+XGxmlgFfOJuzDTV3vuoQ+2rpvshqnBJJ2KodFEu57SLsJyEBXPH1Ww21CHvncF+AG/SWMSOlagFPc/OF6QYFT8uZkVO82tSp4LosLiErlpdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njqfqAfE2T/C8HMQQoO4xS39I4xrNa4cW4LVRBiVcF0=;
 b=2i/LPxFNsybFhC22wWs2Dm0SXZd0klUPr4wdlaYIzVI1kupD+a3nA2FltvRFeluGw04UAGRn1fV9Ot8+BG/gFi2YnyMwrXO1fr/P3xw3ZiaKROfUmHnix1ftlqypGqH4r/dpyjP3WclACeuKpk7vYkXFtwQdlhi5ZOHubwAxg54=
Received: from CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21)
 by BY5PR12MB3859.namprd12.prod.outlook.com (2603:10b6:a03:1a8::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 15:51:01 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::d2) by CO1PR15CA0077.outlook.office365.com
 (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Mon, 31 Aug 2020 15:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:51:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:00 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 31 Aug
 2020 10:51:00 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 31 Aug 2020 10:50:59 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 4/8] drm/amdgpu: Fix SMU error failure
Date: Mon, 31 Aug 2020 11:50:45 -0400
Message-ID: <1598889049-28321-5-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1598889049-28321-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 664bab54-71a1-4423-c01a-08d84dc5a911
X-MS-TrafficTypeDiagnostic: BY5PR12MB3859:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38593B5F192A6D899A047890EA510@BY5PR12MB3859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WFB2gF4M+Xg7yXf7nNrP+aCtVunzg9N+7wh2UWXN5Dft5J9QRdFb/gt9p9XKiLa5k/ZRfvw4mwl9FRRgcb3r12f8gfbXIGK9wWrzbiNh4M6ZsqB9WFNd/PhrHlgMJcCnpk8HMqsaHr2CLmVmG7afoMreTSMJjHxitaHuBdBxkhM8CM6A+BsDvwNabQLctJI4Drk7grn2Qjid1tuBdazyOz1/AJkZHL5OkO4IULUK5H/rrGXRJXMO7s9GxSqo4g6hGenF0VA/oj5r4aoLIEtMFfIijzUMCCJahGlNeKi7vs47UoCScW5ZRxKYb5bb8xH54KxaVLwPMrs1ZEN+tKPqZRlyWMrzBjBtLKAvDU38FJCzMiB/pVdq1cAUcPjziCsw1rWwYZinIzpND6x5M75Zmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(54906003)(336012)(82740400003)(426003)(70586007)(2616005)(70206006)(47076004)(26005)(44832011)(81166007)(6666004)(356005)(186003)(82310400002)(478600001)(83380400001)(6916009)(8936002)(316002)(8676002)(86362001)(4326008)(5660300002)(2906002)(36756003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:51:01.1754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 664bab54-71a1-4423-c01a-08d84dc5a911
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3859
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
Cc: alexander.deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 nirmodas@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Wait for HW/PSP initiated ASIC reset to complete before
starting the recovery operations.

v2: Remove typo

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c569523..4a009ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4841,14 +4841,32 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	int r;
+	int r, i;
 	bool vram_lost;
+	u32 memsize;
 
 	DRM_INFO("PCI error: slot reset callback!!\n");
 
+	/* wait for asic to come out of reset */
+	msleep(500);
+
 	pci_restore_state(pdev);
 
-	adev->in_pci_err_recovery = true;
+	/* confirm  ASIC came out of reset */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		memsize = amdgpu_asic_get_config_memsize(adev);
+
+		if (memsize != 0xffffffff)
+			break;
+		udelay(1);
+	}
+	if (memsize == 0xffffffff) {
+		r = -ETIME;
+		goto out;
+	}
+
+	/* TODO Call amdgpu_pre_asic_reset instead */
+	adev->in_pci_err_recovery = true;	
 	r = amdgpu_device_ip_suspend(adev);
 	adev->in_pci_err_recovery = false;
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
