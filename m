Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F52C25B0C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 12:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0149B10F4C0;
	Thu, 11 Aug 2022 12:38:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDE510ED6D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 12:38:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEEdg9U2csLW2tlG5me79mmV8fuwkYGfpbwOTo/FYn+tzkLjybjwPsl+JJSz/Y3M/8RQiTX0X93L+TZOTfKS4o//2ZMoq/ISWfFBio60lcF4uM2+YtkQp5RlwHooy65lLioLTpVp7Nq9iCEv6NDNDe6U21GcLz4H3Nwj6clckc78M23XTZIDSIfZO3y7B5y4C00+rf6kUnqvModB6Ul9j2WS9HtyWutCeb1qQ5u7mUiaOaJAkEXcdHJ5u6JpKQAnt9a7ZgRU2z8rTMKcyY7cpUUcThdrxF8LVM594tz8QsXzU6YpURJLq0kiBnLyU3lN8KuDVPYfUtZOYZRoc/YDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saW8lj/X+uXSdlpN91fVLp4dTxZckPwqZ+ezuoCSrAc=;
 b=DB/KQgp+DJGmkrrM5hvECNCXvWapNPZLNsn5ZpLJDWie7OE7uzbFm70WHvPpnbcG7u37a/IDgF9Pj4utHnKbfFBjRqDGn3NxRzxEkHXMN0cSQWoB/2Lv3VWv3vNkEbhxpPqXujwtJO0SBCJNA3MyAeDWZJ50JbWp/RGDezdRiMtCgjA/1E1Ns/aTGq7wuwoBlTcOT0iAKHwz+Nc4A0EBBN4rVfLGeM/uMleO9u+HKOfpKeILsNFC8IAkNu2p5r0HIy9KiLPEBR4n4qy0HMzAqA4MWUCL0ilffDuOmW6ldWh7gLOnrc2+ZPFAabvZtBdBHzjQNN0WOWDcyDZ6fR96ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saW8lj/X+uXSdlpN91fVLp4dTxZckPwqZ+ezuoCSrAc=;
 b=5razdCuuxAOdQD0wZbvbJTpceRbSU6Brrgr8l4kz8yoiBnvNz2/WYuDAPd++U9F1zMOUrrtSNclXAtdmpEHuzpZIMMT83aC3A2dehsDY5KHb2Kz1fum+i/iC1mJmMo2DvqAeLtkDYNjv9hP5+BgejJJxKo6C6QHmK/sDrsGTtog=
Received: from MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26)
 by DM6PR12MB3770.namprd12.prod.outlook.com (2603:10b6:5:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 12:38:34 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::10) by MW4PR04CA0201.outlook.office365.com
 (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20 via Frontend
 Transport; Thu, 11 Aug 2022 12:38:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 12:38:33 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 11 Aug
 2022 07:38:31 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: reserve 2 queues for sdma 6.0.1
Date: Thu, 11 Aug 2022 20:30:16 +0800
Message-ID: <20220811123016.3958303-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23725f0a-ccad-4b2a-491f-08da7b966799
X-MS-TrafficTypeDiagnostic: DM6PR12MB3770:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WeJFmuULxeeQnoZrV5AnwhbKSwYCp1FKuRV1YB6/WRDpcDg4vHtxAMDn4CguNr1xwJb0AIOGM7JLqanp0ImQfnuQ7nDWs844B+T1+FSGnI58yPCR0rVWBbEzt+mhwtjeNo9eSSS1796Ns2PgCXOVqw+Ep7/aiiaTpfdJ+5vEBZ5GXb6SSTFnCcTlk0oHBWmev/kpSHSt6c5zM3fw0clW9kCSYtBmOFYycQKeapDUBH5k2dgMYMPXWYtxv/0wdOJBxxATBfL8cNBRvt8fBLqjPG36Pz8kQDqN9wN8MDQTwGm7i+n3a0BVxBrE/HUdywyxuk2Mnkhd+MZOcRcIXUNnmwHLuOLTRbsH3PJ4Rm38xOn/vDqu+Vagu1a1ZmTF/AYHTgnISToFm4J8m/RPo2k7uzjc6cisYeMON/z+YCF+btaIufMry3wtEtxO4ZxIlbu1m+IjZkheTQd+IZy6przxtqOalzpCBJEX7oxjLn48fx55hm6lQvfgvUW6XDQvetngshvr0ttsXn6RQ5SyiLaYCnVCxOKF53s3nkojUGEAbQpxZeNOPpsL/k+YWTVB6HtjGibwyRQOB6jmuivPJ4PrCGFpI28z10AWOpfCBVbLxSQBkt+L+EMypvVqdN3lgNIZJLrL/uboVzqZ9/KQ97OFytnrU+XyovJze6FNT2NrCT6sy0W8RNF0PsYMvX1sXM0yncYltArug7j4W9yXbD/wpBy4OD5xm/jZ749BlqBfVa7C0yFpdevYNpVQfa3N74VvS96/y3ePYwg8T6ZwbLpvuaIH1rfu3ulodURCipYQJvNP5h9nS1I7zsrL9F2NttFScMHsE076Vpyk274AkErT8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(40470700004)(46966006)(4326008)(70206006)(40480700001)(5660300002)(2906002)(8676002)(36756003)(54906003)(316002)(6916009)(70586007)(8936002)(40460700003)(6666004)(478600001)(41300700001)(26005)(356005)(7696005)(2616005)(336012)(81166007)(1076003)(47076005)(426003)(86362001)(83380400001)(82740400003)(186003)(82310400005)(16526019)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 12:38:33.7725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23725f0a-ccad-4b2a-491f-08da7b966799
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3770
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
Cc: Alexander.Deucher@amd.com, Mukul.Joshi@amd.com, Felix.Kuehling@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is only one engine in sdma 6.0.1, current code reserve 4 queues
togather w/ 6.0.0 and 6.0.2, which is not necessary. Shrink it to 2.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index f5853835f03a..a82ddea967f2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -102,13 +102,18 @@ static void kfd_device_info_set_sdma_info(struct kfd_dev *kfd)
 
 	switch (sdma_version) {
 	case IP_VERSION(6, 0, 0):
-	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 		/* Reserve 1 for paging and 1 for gfx */
 		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
 		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
 		kfd->device_info.reserved_sdma_queues_bitmap = 0xFULL;
 		break;
+	case IP_VERSION(6, 0, 1):
+		/* Reserve 1 for paging and 1 for gfx */
+		kfd->device_info.num_reserved_sdma_queues_per_engine = 2;
+		/* BIT(0)=engine-0 queue-0; BIT(1)=engine-1 queue-0; BIT(2)=engine-0 queue-1; ... */
+		kfd->device_info.reserved_sdma_queues_bitmap = 0x5ULL;
+		break;
 	default:
 		break;
 	}
-- 
2.37.1

