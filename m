Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36472C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 16:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8AC910EC0D;
	Fri, 21 Jan 2022 16:17:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E175E10EC0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 16:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyw2qhkjB0fx0W2OekFdoz1M0cikdU8Ey40PbUyED69RalZdP5nucdmIp9zYseH5haC0Vsc48n/QlMtazEi4XIpwq/lI5gxevCkY1vDfwdzLSaFkk8YoSeMTE4xBN6Tlg+NBwrBf58MF2cpA6FHUqMMlg+qUOiEQ9pSdDHQVEha2CwWU8lxhDqVxIgMkK7nBxF0qHlen53uKxkQiGPvsg82f8eVJKRgQN7oZakv9qBuEmTh1WqGxlkgOSc8eatFBCqANwaR3FVeMCX50N9zcEiCzy3md4nIpbe/hWayj/1SYZqK3WTxASqFt68Olp1JVPDcsyudQkjoajm+vQosleg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3O60h593+Jq7HDN2ewSkv2XN1Br0yY2/00482xc6uM=;
 b=eWCbTpEVA+9Objzoch1jDBlImDRyFdMPpqx6blyMTKPJH0CbT+c0i6PMkd+EnCtZCy/WW0L7tuLUUg0qMlCi7RRVVSvdATklFmSXlExAyiz1lXx1pbpByWpz2LM5V6FeHcYmhrtTG8hgoeecQLnxmNd/M7My4VaLCNOG6IBdoK9/CUF1tCIuuhW7s4D9jA7oXRHPnWkLAIKCDEfpl11Ozh+9Xwdw9mYZP+Z7LDO7SASwYIG/G0h+6fH8o+tZuQMaPFn5/48PyR8Ims/zyPlZvzUw2Y3z2cWXNlZjfQTGyTew0HcFmjVU+h2BJRWAmM81bdhVAEBDm7oP4Jp9GUMLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3O60h593+Jq7HDN2ewSkv2XN1Br0yY2/00482xc6uM=;
 b=NKzbUsGwN5veuXZ89myY2gHp/RM9EQ778Uuf/t6rVLf7qMZJiYBQU8FWvN+NAByv5AFmknJ3tbxWmpQDgTeYPFUu+3mF4BKOyXR9x13WrxjGH9R/yIInxlEg0uRDCGXiLRsvggUDG1msVD1qK/MFk3ew7KvurNSgRn012IDE0+Y=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 16:17:09 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::b8) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Fri, 21 Jan 2022 16:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Fri, 21 Jan 2022 16:17:08 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 10:17:06 -0600
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable heavy-weight TLB flush on Vega20
Date: Fri, 21 Jan 2022 11:16:48 -0500
Message-ID: <20220121161648.14729-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace21db3-fc12-472a-e4fd-08d9dcf9794a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4434:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB443429CEF79706CBA4B87BED825B9@DM6PR12MB4434.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqHEzNUqCDA2jv2CslTQZ4dqbyAy/xfy40mV7YebF71QFz6IVkdNWd1eh+xy10Vt6P/ggoMjkFDy5TFMWAGuOoc/0hzabUZrvlEkO3a/ET6f1q0MTUJBxKGRd7yoqhf9yP2Q/i7A/8C9O/77rSADXQ0FcdHOGkFjAfyCyHKktZMFFvJd9kq8uts50ivYJKydi3mRt8wDgrEbT8Q+IcE51tW6tePkOQCL5/ISoFPk+DTDeld9yS6jdBHQnmDAh7rY9iOdMX/AzeQRbzcz1ynF7VGZ9od6U7PwxwGUcIlCviG2912F+w/+ARqV0WgXgkFPuTDW5QTLRA9WlgMfUIK6Ot/FU0uhE9fGJaZjcXUuFsCCT3gzlSa8wZ4I9l3vmoz4Jx2UmiLGrDEAci1p9DPxuh9vwdsi+WyfIZ7gTipgAotYrqfqJ4LSPEMElI26/TUXI8/8Hnx4qTg4pjL5WjV4sgKrKiNVt4RW3PMO/fAY50t5JmH/7zKz+6e2fJ3Ovgll5Ea76aeQfkvyLgPkpqlNFyZjhGQUZR3QlGMi8Y/G0QeXRDZHI1kgpVBuSh8kFp+OnzkbzbDQg75wMroVgM331GvAAc6wEMBq5VcKEoRecGZ+g3zQhT47/ASsR+2GB9JGGaUuhoJcVhaF9uhjPJrw5QnH/zwlBYOkcOErmJXKUMnEdjZp69W75lwcxi2G6e48pIfsyZhW60xy8KlMcetMF9TqLhkXGZxFtQKFeBCne3OekFB3/O/bnXZMpzkIU1iX/5MK9rz12byhTe9YJbylvFZ7ZnTElATg4b5lbGGOMI4tVsItX8u2y5i2nJwhnMR04v0ZQvSzHetUy0WbMdv1lA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(36840700001)(46966006)(508600001)(83380400001)(6916009)(8676002)(81166007)(4744005)(70206006)(86362001)(4326008)(5660300002)(186003)(16526019)(26005)(8936002)(36756003)(36860700001)(356005)(7696005)(316002)(40460700001)(70586007)(2906002)(1076003)(336012)(82310400004)(426003)(2616005)(6666004)(47076005)(16393002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 16:17:08.9085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace21db3-fc12-472a-e4fd-08d9dcf9794a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to meet the requirement for memory allocation
optimization on MI50.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5b8ae0795c0a..d708f1a502cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1582,7 +1582,8 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev) {
 	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
 	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-	        dev->adev->sdma.instance[0].fw_version >= 18);
+	        dev->adev->sdma.instance[0].fw_version >= 18) ||
+	        KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
 }
 
 static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
-- 
2.25.1

