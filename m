Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58636C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 11:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197A760FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 11:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197A760FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799626EB3A;
	Tue, 18 May 2021 11:58:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC726EB3A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 11:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBajSkcNszKHG6yi78zqv+6ypOs20tbuDtZh5Mf9TnmHy5YRG1mwjQfxZ4JAFKo24k/MzKpb0nFUJUHeUzbrYIP5IUAlR9C18zy4d3CSeNA0rVFc8S6YkE7nEYLyB6AlkmBdwBE6g9GteiV3s8w0fGmYwJsnXZHXPqtNlP+V21NXqZZ6QRWjw/+iv+wL7Sv5fiFiZetVesbzTG94WlPl4M7xlLbsf+qQMDwCOVVcj4s0Rq/NBs/s5TTxOKBS/c945Y19GrYtDpTWXCy3WDEuhK0/X0F7LeqiSOO4A24EsoD4LiO1w2O9ILU2CyNz2HBWmAvptGyaHtMrxzB4YKpFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TBzv2kG/zhxZC/PBIlJ5vCEGxnkV/KtBl8yCEFTfYs=;
 b=d6dDpRKpMFTIqJoPV2wfbvH0megv5U5DmTxACT4nqv8t3KR5nNOoqKw6JFwArjYodahvKiNIsYOiOfuRlV8DPmPaotDnH0sshe9YRPOBB5VZdB/YBlDejwVQmSoPSA9iF6lrGcZj3I34DyxkQ1DbWwtDniDHQDqILhcOI1YlEbPfOWde+QgQtzpAoSwk1zNY5C6DoID0IWLRDqjVbEQAUd91Nw11a0cBkEXbc4j1fYmWP3N7FrhwgZ8Mj3ORRvxh21nlGqdYSxjOyDVDCUoSi24T6gYgJFPjaWEYW8J3LDZphiiYSI26CfR1q4XLDup3triJmAVmqtdLSePkbAlGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8TBzv2kG/zhxZC/PBIlJ5vCEGxnkV/KtBl8yCEFTfYs=;
 b=h/3txnjNJdpwuMu5nAvDxZeeRxTZimleN0ZvDQIw7tS2NsufJTE8gc6EXWYIDAI04bdy4fTAu+xxmrn6yRzy7Yc3uSF5B8Z+/b5DyJ2w1QpXDtRDRKMur6aG3g81aBBJhUl+FbBKNKw1XZ9A6S14G9DFVF64JvEtKlQ/fhfKKmM=
Received: from DM5PR16CA0003.namprd16.prod.outlook.com (2603:10b6:3:c0::13) by
 DM5PR12MB1691.namprd12.prod.outlook.com (2603:10b6:4:8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Tue, 18 May 2021 11:58:56 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:c0:cafe::f6) by DM5PR16CA0003.outlook.office365.com
 (2603:10b6:3:c0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 11:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 11:58:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 18 May
 2021 06:58:55 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4 via Frontend
 Transport; Tue, 18 May 2021 06:58:54 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdkfd: fix a resource leakage issue
Date: Tue, 18 May 2021 19:58:45 +0800
Message-ID: <20210518115845.13010-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40ecde76-cc0a-413c-cf02-08d919f450d8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1691:
X-Microsoft-Antispam-PRVS: <DM5PR12MB169133B3ED68355D358A5807ED2C9@DM5PR12MB1691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/sitISkw5O7hj0EejFOu1mWq5HCkwtNe2oPtfGxA3pKkzUAWelBDajocjzcHGpwZ170oRFh4eQaotOdrVw+4tHkM94W3QYQXMT6J8bB1GAQZTbw8HFh63dRt7cI+c/S3nnvu2eLiI9aXthNYJPpAl8vCwpa3MXcm3kOCHE7rtHDXC8oJ+3SKye4Wu/RbaX9gRzsXnFYeotJohgDE3acMqGtkU48S+4l16ojQ0lQwLWg/yewu7z7GcE8f9GoT7Ka2t1/EcwZUVZ/tU/oLKiSngYIrT3cYA9qJ95cnTXW2gVDQt0W+G3dc5OmeQLHEyKdLrgnw7kFSoxwHVJzTfnWLASkqJS2y+mc2qeiWAP1i7JKR8kvJO1cThsSs8wpJ6gNN4PiDojYO/XS/XlG++UmRTQmE6Qm1y+A0IB4BEo2RkxM53WdPDEJA+4mcWDK9cn8+Gdt6WoO7GlMReO6tSkC15nJ+RVUu4rPcCvBJzniXrMx3BgYBIonf3pyiWIEm6jQ+PHaSlE8kAFc05CWOOVvPR5FNd61mqIbJn1PiiHRYRYIEKZ4nL5fE9/QcuySVpNBlq2aAtdfpXRerDK1xL9Y6a4rIqar07V3iwVVwhlDwYI/8pGGQsmRIiGkebCm6U1CU6LNWb0Q2JprNKexDNL4IbESOO2CJ4p42Ire8Q4Bh1N/LglyfHf32E3bNKBu1eRFo4xlod/xenkHH09I9Oi1+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(136003)(346002)(376002)(396003)(36840700001)(46966006)(86362001)(70586007)(36756003)(82310400003)(336012)(2616005)(7696005)(426003)(36860700001)(70206006)(478600001)(4326008)(6666004)(8936002)(47076005)(26005)(356005)(8676002)(4744005)(82740400003)(81166007)(1076003)(2906002)(5660300002)(6636002)(110136005)(186003)(316002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 11:58:56.7597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ecde76-cc0a-413c-cf02-08d919f450d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1691
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The function kfd_lookup_process_by_pasid will increase the reference
count of kfd_process object, its caller should call kfd_unref_process to
decrease the reference count. Otherwise resource leakage will happen.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 3c9fe078334a..6cc6afb96a45 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1100,4 +1100,6 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
 
 	/* user application will handle SIGBUS signal */
 	send_sig(SIGBUS, p->lead_thread, 0);
+
+	kfd_unref_process(p);
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
