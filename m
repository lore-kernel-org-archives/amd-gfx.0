Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C004C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 09:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D582078D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 09:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YMFYF8jJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D582078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0A989CE1;
	Tue,  9 Jun 2020 09:20:27 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690077.outbound.protection.outlook.com [40.107.69.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E20A89F77
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 09:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3Dzm2cYWRPdpn74x15Ovg49o1Y5CYex81uXIUcZ3nB9Jvt/lALnLF8pIdrUAh3v4R9i18rDmdB8XLr2Mk1JX962nKN1IQVv7mJ4lysj2zJfh5zCIxgSIq0ozGDvU9QgjtTs2lpYx9/VN89xkb2sLb3k2nao6ji+LNMquw44M9kb03ViOFTJ1Brveitg2V+6FOztT1JcKukAG/NJDp4Xa3CsSfR+PhVJjsWSaNlVTWMHevvlNIxH0mI6avDnXU5JVckrVSaKAVzTWH8h1wtTdXEIyx6Tll+VTXNYRGiTrR1B41QsJIO5AKJdULERyEXe0ZDDe/FezI5VYrJkLzKSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00dzfbFwWbJkGumAAG0UeRJ4EY5er21fE3fNOvhxIvY=;
 b=kcHJElfzpLpeEu7dJhq0rPcmRgNSaMOnX1V/gCzq+HrgTsWdh4QaPWAtOeCJfR/CiNLaPQLMhUGKceZ07DCIW2Z4zRpq/5x0RmYrdBRgziQycCpyPyyVmqxSc4iI5o63jceMYxC3owZNB0x5fE2hKqy+NXFqI9J8inHVRA2iKKov1CGkibdKaqZNRrKn+ulaYh/DXJqpoiIXn4Z73Y1CaUk+36Uo/yfPXNaNJ68cVsCpANix1kZpUUyPmV5XTTilbX730rJ9sOE845cxgXIKZdEEmQYED1Wcpn7pw82W0jPhzZr8+98VCdTBv8B3BQ7nmwR76NswG6O+pb+yxenYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00dzfbFwWbJkGumAAG0UeRJ4EY5er21fE3fNOvhxIvY=;
 b=YMFYF8jJtpVtZQMv9e+7xjYIayA6JdIXMov5rW8vCbfqCd3RfYgm4H9ekn3RuL7FWBn/tsd84fznR2Vh0OYDSrH/j9l3mdAGFRHGikoniVhycb6++7v2iN/bkQMftSVZYDHM/7v8mGsCsstDweDMYCgAmpw6a9gbeewRKy5CR3c=
Received: from DM5PR05CA0024.namprd05.prod.outlook.com (2603:10b6:3:d4::34) by
 CH2PR12MB4102.namprd12.prod.outlook.com (2603:10b6:610:a9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Tue, 9 Jun 2020 09:20:23 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::d) by DM5PR05CA0024.outlook.office365.com
 (2603:10b6:3:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.7 via Frontend
 Transport; Tue, 9 Jun 2020 09:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Tue, 9 Jun 2020 09:20:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jun 2020
 04:20:21 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jun 2020
 04:20:22 -0500
Received: from chengzhe-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Tue, 9 Jun 2020 04:20:21 -0500
From: Liu ChengZhe <ChengZhe.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: handle return value of amdgpu_driver_load_kms
Date: Tue, 9 Jun 2020 17:20:17 +0800
Message-ID: <20200609092017.578945-1-ChengZhe.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(70586007)(186003)(2616005)(83380400001)(81166007)(478600001)(47076004)(6916009)(356005)(82310400002)(1076003)(426003)(70206006)(36756003)(82740400003)(26005)(5660300002)(4326008)(336012)(8936002)(86362001)(4744005)(6666004)(316002)(7696005)(2906002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6bdf552-5001-47cb-fffb-08d80c5656ae
X-MS-TrafficTypeDiagnostic: CH2PR12MB4102:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4102A450AC65E97E4D037DC793820@CH2PR12MB4102.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsIzZaHJqGVaVDGTq08w/QZnJV8Uuq+uSz3HRsSQZ9OFxkzoKMuhiWlhf/GiMn2ffLnbknV6+eypEdwstQpI68gj8nkN81tF+TnqXUuc55gX+OFhNvY1ivs16v5o1uV69iQF1JkRQbZSZJf3dYIJCWL0fx4UpkNyPjwx67OAvjfhFcnPnEZq/p61itiImGY+PaQx1eOGndWaZoDpu7U/gbvluhEWGEVqKV7SIZ2ht9VW+CRzdXJLrhUGnSVfEZ2XXZUJAM6iXEDoXy2IO0cXlSBpmMTh1WqtekLMyHe/TarVZKlYSN7CAU6yjYFXR66MEAjioiF/ulPkS9kqwLFShFqg+teoy+TBCLC22crMsJauxLCj+mV7aaiDJOJRw1gq/SzM9ahUkh6L5HxKDZwnGA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 09:20:23.3125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bdf552-5001-47cb-fffb-08d80c5656ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4102
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
Cc: Liu ChengZhe <ChengZhe.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

if guest driver failed to enter full GPU access, amdgpu_driver_load_kms
will unload kms and free dev->dev_private, drm_dev_register would access
null pointer. Driver will enter an error state and can't be unloaded.

Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 667aad1f15c0..9c81a3d0b546 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1165,7 +1165,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, dev);
 
-	amdgpu_driver_load_kms(dev, ent->driver_data);
+	ret = amdgpu_driver_load_kms(dev, ent->driver_data);
+	if (ret)
+		goto err_pci;
 
 retry_init:
 	ret = drm_dev_register(dev, ent->driver_data);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
