Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F7C3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 06:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B248724697
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 06:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BHX9SCxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B248724697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D14C6E0AB;
	Mon,  2 Mar 2020 06:57:21 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760081.outbound.protection.outlook.com [40.107.76.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BF26E0AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 06:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAaOHbMSmfnwRkRfgAQoEbnqV5+j1ZL25YAp8c9YPFRWjsDF37gv2LhL+StSUbcCi4o3FMuTryhAsp8a6OUen8vnYCnMk1Uqv/94wQOMltodptOtFGr1H5V9tYYiSIXslIXwZ2TOC3qFTfIpMtOzdja7DR3AILBJ8THMhDomc5PCp7JMVbWG4gzSd9lxmIcJ85SAG53deDG7v+6mP/rth/dRhhUDYeYU0whJqFyj5mT6hNVOIDTiTPaDSDtQ1FSS2zyoRM08yZE1QDI6eJk83cDtTvrI/cjm/HkmtRXeg5S5tHji+LXTZFBv7zyCNxhpjjfurdtTOognmRQD0qTtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+UcXbqNq1Il6aYHxh9q8e+4du9dpoRr7nwFGqIuBfg=;
 b=V0ufRBPwLjvoabF7BmMnobJGmxPLNAiUvzgjWOMG2GHQO5gC+pehDqa6bNpP9mXDWcxCIYk5FIG24e+G42Q1xKTu/kRrp2wwnAmwBp4wj6e3nmonO2UcAwGqO2LrxUYhDWe4pPl3+CtSs6qdWhY0fr5gT/lgHqNvseeijq9Hn2VJBsXsHFyEyf1iT63Mf3Xr8a3uQJWJb0WHFYgRwXEeWo10DfociH1VSl5ONqmPMMJdmEDhFE7OrTBEnhn0xnvY5OlQtPmmEDDka4ZehletsqnrwzUq0UaqA5/3W+zXhu8S9YKucDq4tzKvtDH1NozgZ5xKc30xp2Pi+7FG9l3C3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+UcXbqNq1Il6aYHxh9q8e+4du9dpoRr7nwFGqIuBfg=;
 b=BHX9SCxZPSnzBhGWmMuI+1N5PZPt3JdgR9jUh3PU6VPCL2q/ciVROl5Odn3bCyatMIggcU/3vRoxvMTajJnLjoDhqMHHfsSIu0uSB86InG/l2rOvPE0Z26R2lzDhw7RXA4VMzCI0XcxQQorYdGjY5dzGAd38C2SHFAmHRIOoO6Y=
Received: from BN6PR21CA0010.namprd21.prod.outlook.com (2603:10b6:404:8e::20)
 by MWHPR12MB1741.namprd12.prod.outlook.com (2603:10b6:300:10f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 06:57:15 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::43) by BN6PR21CA0010.outlook.office365.com
 (2603:10b6:404:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.1 via Frontend
 Transport; Mon, 2 Mar 2020 06:57:15 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 06:57:15 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 2 Mar 2020
 00:57:14 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 00:57:13 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/runpm: disable runpm on Vega10
Date: Mon, 2 Mar 2020 14:57:11 +0800
Message-ID: <20200302065711.5899-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(346002)(428003)(199004)(189003)(316002)(1076003)(336012)(26005)(426003)(2616005)(70206006)(70586007)(5660300002)(7696005)(4744005)(2906002)(186003)(4326008)(86362001)(36756003)(356004)(478600001)(8676002)(8936002)(81156014)(81166006)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1741; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 466dd5cf-df69-4b8c-43f5-08d7be76f0d5
X-MS-TrafficTypeDiagnostic: MWHPR12MB1741:
X-Microsoft-Antispam-PRVS: <MWHPR12MB17412726D86FE20311817385FEE70@MWHPR12MB1741.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 033054F29A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z65wyHCMXtuxGVppyJm3Vitt+/maIWjb2D5VrukJEati7fMDcdhVy9m1BXll5amyvZXFZth4pxctAxENWoYNcdLg/Vetu0NOiHPs0sWpBA5T3i3UtRy5c0A1AfpXwVvWRoCaknK22rPYRqpDCWYj2adJkH4qmfE/RhiNTj2Ii1cErcEnXfvKkPzrdeVkvfAPRbqGnLTtSs/drRGwHZWYeDRA+eYGSdMYAXYL2qxPhni8oyKCjfIbrLKxWfUElzc9TM4OshkrP1hbhXmtJHSHPNBasvEG2bMalxBR7mr+hRmX/ZqFkNyk58p5rLfscRcDS3zAfqXAjJcVBdkm8EJJ88gVcdSQtI+HpmpVQVwMsQ/Du/QRqxCe+lfCEiSxNLvtBLYU0loyo8niEwYzaq+2bGaARVcF4MqKfC9fbhOIgkS2ewahvZSpyIRd1p9Dj/wW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 06:57:15.1701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466dd5cf-df69-4b8c-43f5-08d7be76f0d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1741
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
Cc: Feifei Xu <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some framework test will fail if enable runpm on Vega10.
Disable it untill issue fixed.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Tested-by: Kyle Chen <Kyle.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0f3563926ad1..7c1e0d9f2c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -175,6 +175,7 @@ int amdgpu_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	else if (amdgpu_device_supports_baco(dev) &&
 		 (amdgpu_runtime_pm != 0) &&
 		 (adev->asic_type >= CHIP_TOPAZ) &&
+		 (adev->asic_type != CHIP_VEGA10) &&
 		 (adev->asic_type != CHIP_VEGA20) &&
 		 (adev->asic_type != CHIP_ARCTURUS)) /* enable runpm on VI+ */
 		adev->runpm = true;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
