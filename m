Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D94C352A2
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365AB214AF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 00:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="V4CiNVen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365AB214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B116E4AB;
	Fri,  7 Feb 2020 00:09:30 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40AC6E4AB
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 00:09:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWsN+UJXnzN055trNRJaJI9Wv/BZXOLLnwgnkp2qcKmzu9KTBQmQnMcZh4jhHJx1aXFCwOPO3oNEfx1rj1XFONKEu/AQJzMNdZnyGZ+AqEP0wowhIMli77vOqqj3+yKVOWllpKRQ33MjqYgUkC7hJ7lttPJUeFweiqQ9doKyN9qo5l1uMWg3jCugPkT8zAIX517aj/9rzEJL8YeEBpmLWAEab1UNBRmjD0KzMqZjvMQ9ZyI3vgVFY7pojC12iKJboM8C47c5JmpKGFetEa1PevTsBfSY2vGOTm2p6Wc8DkVpGLKkighwPlq0JYCoer1brLdmItJoqbqI7dpK4BbTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEbGFdpx3cU2RVgDDQv8h+Lklsj0SsHI0zTVZfsX59c=;
 b=jGdCod3aKv41IttqBJ1v28lWOqMyf7JPAU6wHwMgobbuxu6UKDv+76iWxy36QKMX+gJy48j0UpKDGfio7j6IGpvtZ+pCkqpGEZ8sPMzQ4XdCNNVcF/htVUJmUsMPn98qqqb088XANeZ7INpp7lyRgN9rhb8Sdbid0pJpbKwzJLifjG8twSz9zuToThGItSmPcFBpy6Eb1HGQ+2shDPNgZ8BfMzYCCBCnBASYKZBPal1/iAR8mRE/muJvs5F/pZZ4H8+YzKxYvcKng6s+0dMs0MqOG7DeGLJDdiUKtWHc/FCcbK6fkluwf98ZazhHL9GVfG0El8atTlQPIZm+JkpWJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEbGFdpx3cU2RVgDDQv8h+Lklsj0SsHI0zTVZfsX59c=;
 b=V4CiNVenI4SiwbQ/jwCwiQ3nlHXHfJx49ySql1kfs7dqFobWBbO9dAl6rt0Lk+Ci4jSwZsA2jqTVIIwk+Zj5A6QHj7MUAcuoPdoc7ouetcNJj5eqNYY0xE6ztS0+fT1HDtq8b/CUiMeKanf+D8Nxb1ny66RZU9IP0S0TN4+edvg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1530.namprd12.prod.outlook.com (10.172.34.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Fri, 7 Feb 2020 00:09:27 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 00:09:27 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v3 1/4] drm/amdgpu: Fix missing error check in suspend
Date: Thu,  6 Feb 2020 19:09:08 -0500
Message-Id: <20200207000911.19166-2-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
References: <20200207000911.19166-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 00:09:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04f859e1-ecbd-45af-a76e-08d7ab61fee2
X-MS-TrafficTypeDiagnostic: DM5PR12MB1530:|DM5PR12MB1530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15306CE03B87EE3D73542DAAFE1C0@DM5PR12MB1530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(189003)(199004)(26005)(15650500001)(66946007)(44832011)(66476007)(5660300002)(956004)(66556008)(478600001)(6486002)(7696005)(6666004)(186003)(16526019)(2906002)(52116002)(36756003)(316002)(86362001)(8676002)(2616005)(6916009)(81166006)(1076003)(4326008)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1530;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Mj5i/shiG+mJ3S6FGbUD/aUyIi52Guvyfx2fgeswlke4UB5gYWLrgSoTNNid/kvvJoSfH2tiaDf3vsC2PZOvJAX+8u7wB+fJGeaZ0J9UjOq8EU07ct458oTa0GP2hwrYcOGPmBXUn3SYf158tKYvi3nDcrz7Bktc1UppHQoaFPR5AcSlDPadX+ZJ+FcgxpbdflRkgBBd0r7Lq3o5sV56L37M7Q9fNQMvnFUPTRbUrFB5Y1vH67hMv3Uou/izXmNHpCy6IdjvszUn57rbzKKSXR2ohrEbsLFJwfA8+hjwzIVDuWVRdoIdTMQGJfgDspPl07u7McvH0e8P7HvclKC2S7Fo/X1iGsATBwQ128Tb7EJ+H/KugI2Jtcb2XuqVbTTA158nPhMcMHo3EG2aq4RlJKIhuiRQiOfKtNmQkGVnhbCryRLr4OABaTONxLCyfku
X-MS-Exchange-AntiSpam-MessageData: Tms0S1h7nPQJYHNcu1QjI4MiyKZeFI9pqXUAymdd507vKy3VM3zgv4zYVg0QgJi54EyGW2r0k2HvejO8TXvgs3F6c6jxZkgPxfQx2NSCQBjf7vTPnzSTc4Z1VhK8U2sdZ20iV7iFRq305+FSNY5whw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f859e1-ecbd-45af-a76e-08d7ab61fee2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 00:09:27.4407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJQ0BPcXskli8YwT+UjlAQNRVWPvRWF0FyU+YligQuXdAkqbNU2xKDNsX7in08E5UHHFqE465qIczzrQty15Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1530
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
Cc: alexander.deucher@amd.com, felix.kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_suspend might return an error code since it can be called
from both runtime and system suspend flows. Add the missing return code
in case of a failure.

Reviewed-by: Oak Zeng <oak.zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f28d040de3ce..0026ff56542c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1235,6 +1235,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
