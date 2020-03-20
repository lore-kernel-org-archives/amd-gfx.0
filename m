Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3AC6C4332D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68BB2076E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GCbsRvBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68BB2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84E866EB33;
	Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 398546EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 13:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX2loa6Hif9vS6I2ZbBY8878aGCFu7m9lSEfVgVrg6kBlGx3Mz5fRKUKYLBZR9cxBO3Fka5mYAsRWTUQGNLWYwxseql6JzvTqD7oT+Q0flGiCQw+2KNuFaJrWT7ad9RxfkPnji5RISSYr1AyoTv2uEhJGVI1D1Ipc1bj9Hg18c6nI3PzxtZMUSTjJUK/68j7jybODmSMX2oIa+zGxTIjYBza2/Mf9vxh+DvvcZF1wXClRj9Z3gQ7GvrSLr6Lo/b+wECeOJBDhj+y948XojphBMspHxxKfBW+g4PFbWO8ozCMja4IKih8a5DyLboV1jT2q/OzQEewQVUBtZVpxZrHzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tCfrtY8qm1GKs7ESFkmvQFBEz16AeT2kMSmmgBb8c0=;
 b=ntyfz0jjo9MMOIl7d07YZpMbHBcHCFpozsWAGppg4e4MMI5iQhVWpdYkq7cGN0vpo6JNlRv6J/zXGeY+duRlwcYo7hJswjqcY7dLm8H90We7TBRpA8YP5EMLVycV79XpbPHl4PTIGB+CzCwZieSE4gLfW3cyzsCUW2/Ce+lj5tU4wPPUfwcr1tTlnXtwAREKc6rY+KqGIrWazoAcHvA7ZbsxL9JB4dRkVJyERBewlgBeambO18PR15nMaXmvcBg3h68V6quZweIuSCbZQc+XPB5JNFDFtcQ5W2F4GE6N5/psiWSbFP3b0IGbJymjW+vHR4/VLShERn4+5EhjWf2Jzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tCfrtY8qm1GKs7ESFkmvQFBEz16AeT2kMSmmgBb8c0=;
 b=GCbsRvBwoIksLGxRv8+KaHGWmRk+w5grdchxSL8TfEQlwNXpt78dEMi2dn2va8tW8JBmE5IH3MM8+6zofrTT1OOpOBkSd6NDBHSMArjAe/dtYSLQXaIW03ipFiEbDW2WDzosaYKJHDlD+XdCLRNjHUxw+4ZX2k21BD/TtG2hwEI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 13:24:22 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 13:24:22 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: Add documentation for memory info
Date: Fri, 20 Mar 2020 09:24:05 -0400
Message-Id: <20200320132407.9902-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.17 via Frontend Transport; Fri, 20 Mar 2020 13:24:22 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da556a6a-7a4e-4e8a-d536-08d7ccd200b1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:|DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB317898E9A22C0CBF07C3D39A85F50@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(44832011)(16526019)(2906002)(26005)(66476007)(52116002)(316002)(7696005)(956004)(36756003)(2616005)(5660300002)(186003)(66946007)(66556008)(8936002)(1076003)(6486002)(8676002)(6666004)(81166006)(81156014)(6916009)(478600001)(4326008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3178;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LVlRS+10Bp5dBkdrlEBTG4VXz5vEFCDvzFA8/iX4M5GI8Yl6oxyWf5+EwoBNbrtjXKJJlujZ+A5CpyMau3e8qZIfFXf7WaNO5Og82r10QVHkFixkq/trxRX9D91Foof0juR/fBfJEeVeKkXS5rjDN59BJVsyk8Ym20cJg10gm7xutQlsQFfvDqmdDxmREkyTRM5r8FXzdg9R1pcVL4mnc6GpiBrxc1xKzVfuqB6nR/uvbAIya92NSuj0Fra8mhiip5Qs0T5Wel/M0JLMjjm7IZMw13I8ES7EZKs54d8wiJTza0Oa6X8VDsAaOXyvqlgIbVahkyZfjPt/irXBtYFbOClg8AXbokbTyJMoEKKNPH8t2dyDIwtPp7V7stZEGc2NR1ub+DJIkccQXuOtyCNHBvU5B4AVXq1YKXF5YTZlj6wt1Tw054uGG24+hmIup7sL
X-MS-Exchange-AntiSpam-MessageData: tMCB1kmpYIKFTqIteD+XvaPlIPfqxTkg2HgB5/MBYvE1jppvP0xZfaFuue6TQeHo737+IMW95M9MT2RZbDF83KcnVywnwJQ+L1PtEQzqhpmSpQ2r7HFoST+2uZ6g9YsQ1xPmqzXIXOvAwaJdcUnAqw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da556a6a-7a4e-4e8a-d536-08d7ccd200b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:24:22.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/8Cyhykf0NQ4hn1ALtqMQhl2mMIxyndIlaOZYwlu7PjDvkg703ypXf/MdcgSJa+NrU7G0+OwX2DMpF0tlrmCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add the amdgpu.rst tie-ins for the mem_info documentation

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu.rst | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index d9ea09ec8e24..cb689fab94c7 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -226,3 +226,44 @@ serial_number
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
    :doc: serial_number
+
+GPU Memory Usage Information
+============================
+
+Various memory accounting can be accessed via sysfs
+
+mem_info_vram_total
+-------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+   :doc: mem_info_vram_total
+
+mem_info_vram_used
+------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+   :doc: mem_info_vram_used
+
+mem_info_vis_vram_total
+-----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+   :doc: mem_info_vis_vram_total
+
+mem_info_vis_vram_used
+----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+   :doc: mem_info_vis_vram_used
+
+mem_info_gtt_total
+-----------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+   :doc: mem_info_gtt_total
+
+mem_info_gtt_used
+------------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+   :doc: mem_info_gtt_used
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
