Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF1C2D0A5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD8C20BED
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 18:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1gN3IpQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD8C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CB956E4FE;
	Wed,  2 Sep 2020 18:42:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4376E4FE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 18:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY1mGNspKMSdV4BZ9zVxy/0sGJfKGaTYuZZCkN1ZH6ZAs0HngP9XY0CtKUR+9xFTWuDZW/2s5aaBpUPC0gu7kN8TI2QU5ObiJ16Z3dZj+KrZ9NsgdwE8qOXawmXGTCwNP6vV7Fw75RrkZiyM3b+OJQEeRl9xJQbMeWc31yvY5MS2DJxdr/njyoNkOYpg1kkTMzFaMOppWMIGQxb3aojXluf5CjCR8OO2TV+0SCaZbPzuFqkYHdFP2wH76J1e6kVXLSRjHhw6sbpD4wdH4Y9666K3+O3m/9zhLG0JgzNfLuOxuE/BRpyFcVfjYXLG3M90s+4f4YHeZMziGnmnFtVZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCbKvBEcraY10XDQFhaOo+ma2huZAcWakhSf/Lt3X0U=;
 b=RFKLSp4cPigTVxscya152Irtwhob48nBWiL+fJz7eUslF2vhKaOdPkNO3Ir0q3jhNqpBQmFNRBy6WgGI8xsAVzeNFHIWRI1IBuc1e1FYD9q86wPSc7E02SQhf7c6HpWHyUnYIuYa3RN7J8PlxjR8IvBtCRGjmZmdmMdOLfd2hj8QbyqRshYLvoVUBKT8Va/B+cqFdExDCphXS/im2JbS3PwIXGpu1J1ptzhL//ullFI5qUwmpWwQTTahMeir7yiotn1tSnBEXPPyYUA3A1mvkFzmfkJoLKFqyusnLWRX+FhfuYtuM2TwkgSLI6MwzUWMETTEOq24IQwTvS2c6ivfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCbKvBEcraY10XDQFhaOo+ma2huZAcWakhSf/Lt3X0U=;
 b=1gN3IpQxdUdWecsnydbwksmNDcHtdnrl+8SfP9GkPPGSq2N389I0eZ+N4R8VPqEaXBefqAasT0us/x84EaIB2YCDPTz91wNHKtCAwjTV0LRVZ5sn6bObwg7bCS5/ozNfpX2ACpPbWDBdYLN9kl1wJKjkh2kL07KiRoD08+QQKHE=
Received: from BN6PR04CA0091.namprd04.prod.outlook.com (2603:10b6:404:c9::17)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 18:42:47 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:c9:cafe::fd) by BN6PR04CA0091.outlook.office365.com
 (2603:10b6:404:c9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Wed, 2 Sep 2020 18:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 18:42:45 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 13:42:44 -0500
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 2 Sep 2020 13:42:44 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>,
 <sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-pci@vger.kernel.org>
Subject: [PATCH v4 6/8] drm/amdgpu: Disable DPC for XGMI for now.
Date: Wed, 2 Sep 2020 14:42:08 -0400
Message-ID: <1599072130-10043-7-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 657fbfd2-a64e-478a-acad-08d84f6ffbfa
X-MS-TrafficTypeDiagnostic: MN2PR12MB4045:
X-Microsoft-Antispam-PRVS: <MN2PR12MB404592E137852264859C4677EA2F0@MN2PR12MB4045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYjCfQlcTP+SbmPQFaMQ6kru7w9zGOrDDdCRE1xQxDhi43IbW1HsXUMrxPt20Om+Q4WEcTHIPANjcqCmLHRalNBKDIH+L7QD68LyWvoSsIkIMdTSHY2E+83PW+0AbIS9ONl36TnEk6Jw6HmjOMl41MahnZVincqx1KxFi+2Iv1fwO8eJEjDis5107SIA8lQCuef7SxaGASqZ+5ipP33ECsjd2zEYhjvhHjSsyh9Md5zsC9q88eNArJd52EsKtXG/kMROzr10lu3YCZ+OSl68jNqOKmkqM4mKsvN/6WembjunEY8Psco6IJTI8eAPrtq/f+ED4tQ9kfXXVUOvk6HnWB3bhlb9rNZcdguZtqbMxaIcNA/mMc7bwPvCiceZB2wEDWziGKSbXYc+PS7DnjtZFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966005)(336012)(2616005)(83380400001)(8676002)(54906003)(110136005)(82740400003)(81166007)(70586007)(86362001)(70206006)(478600001)(316002)(356005)(47076004)(82310400003)(36756003)(4326008)(8936002)(186003)(6666004)(7696005)(5660300002)(26005)(426003)(2906002)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 18:42:45.9969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657fbfd2-a64e-478a-acad-08d84f6ffbfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>, nirmodas@amd.com,
 bhelgaas@google.com, luben.tuikov@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Dennis.Li@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

XGMI support is more complicated than single device support as
questions of synchronization between the device recovering from
PCI error and other members of the hive are required.
Leaving this for next round.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index c477cfd..4d4fc67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4778,6 +4778,11 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
 
 	DRM_INFO("PCI error: detected callback, state(%d)!!\n", state);
 
+	if (adev->gmc.xgmi.num_physical_nodes > 1) {
+		DRM_WARN("No support for XGMI hive yet...");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
 	switch (state) {
 	case pci_channel_io_normal:
 		return PCI_ERS_RESULT_CAN_RECOVER;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
