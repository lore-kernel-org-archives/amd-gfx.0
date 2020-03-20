Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD2C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C072076E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N8ogZQF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C072076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23D626EB31;
	Fri, 20 Mar 2020 13:24:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BC36EB31
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 13:24:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPxcdVrcrQnhVXUxpyG8Gkql3p+5Ymm7+m5hUmNXBLaZ5kUSV/tChLQ9GEsCTXuWpFaWTV5KluOHklCsk73zaa9IUg5d1mlw/yQ0oyjCXD8nQUQjryqPdB6pp2qq45p0cNiXx1nbS1DUyQOefs+ygsSxNHXLPkbc52yYbmZWf5acSj3dvVrPxTW1kXCp7h6nA0L2cJo2nV2NCE3eWzuFgz/nahodl50g9EPn57MVckId/Spr4uYI57XTperTaoEQzExg6Y3EuJrpJJtFVlFq9NAOq9eE3BeimQQl+stwa0QwltJPBF+dYSu93ppPpN8eEDGnpZQ3Z1jozZ8cf8FZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpySs0/1BA+YvBv5HrRSsGXUFqGVZJADgCLth543dmc=;
 b=TV6ALDplaDvzPdz++bQmuLG5O6Wf+9OEAFoW/K4YuFgyP1gKqgwqQg0SKGmqO2ikkldMyiLfDpwkgKpTC14Ke4zqlABSgc50/WdbyygRZL/uYij0DOnnVG2myTFlC0osMumr3TOOH3Xe2nofhXKIMuBe0rkEAYXRXorOVb5cfH0QUrjaMCgJ9XtnWDw+ZaxJgzkaWhJjdA/xO0PLo0XyGuQ3NJ5izo2lpPi8yv5Oxxgfrgyidiqa3QDMFqu/Epqo23UrkpoudwdGXfBUKyFW4C+aJLweoScPsCEI+l4H+XCo8DVUjV/Rr5+ISQKH+LTW6p6rwfnnmFQpKrGwyGN8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpySs0/1BA+YvBv5HrRSsGXUFqGVZJADgCLth543dmc=;
 b=N8ogZQF2m5/mLUxCsA1uVHRNVHzdU5rbqY0HoVQw2W4uSdOMldrdhX/Rv5YMFcmPt3qpXnsWAba/qotakDWDypTr+dhTvUtxt1za2HcO1VToAvC2mY+2Gw42gjtyd8lESoEZHUyf460SjQxur/KWwHHYnHt1x9sJVT/fJEK6iDA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Fri, 20 Mar
 2020 13:24:25 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2814.025; Fri, 20 Mar 2020
 13:24:25 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Add documentation for PCIe accounting
Date: Fri, 20 Mar 2020 09:24:06 -0400
Message-Id: <20200320132407.9902-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320132407.9902-1-kent.russell@amd.com>
References: <20200320132407.9902-1-kent.russell@amd.com>
X-ClientProxiedBy: YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0003.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.17 via Frontend Transport; Fri, 20 Mar 2020 13:24:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26354188-62ed-472a-59a3-08d7ccd202a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:|DM6PR12MB3178:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3178457FC448914884E73DCA85F50@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(199004)(44832011)(16526019)(2906002)(26005)(66476007)(52116002)(316002)(7696005)(956004)(36756003)(2616005)(5660300002)(186003)(66946007)(66556008)(8936002)(1076003)(6486002)(8676002)(6666004)(81166006)(81156014)(15650500001)(6916009)(478600001)(4326008)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3178;
 H:DM6PR12MB3721.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZFGzJTfZGTOBe+wHqNp2PVzEbeCHltxkIg6mp23SiiobThFcOh9Ql7nbHQYtX7rmqIqjZzhYBvTGeP+KWnFS4pYZulh9vBjlOPVE/2dqjJoxwP3DMFHiaZp7fdvI8LkxyOl2akGuxbINJs+4RlkVtjMC4Ct5lmE267jhVdqMd64AQDOOPLK5J1G05uBf/MEchNHdUESTVym6UJqTcG7EIqT1sQuCugkg9TRQZ0m/I6O1urhjatHOk+XOk0Sp+1EJ4O2diUar7aS8t4eTe6GacD14JAVdAOURnoAmqJs3eUPxEk4u9fhFKdJuX0cFy8f0pPRnASNVtiZy0aixK+p//Q99iAD39iJJuYUt2TAGCUz9yFNLVg4txVI3/cZuCSBjRDN4B7QDGXu1J8JUuenUyMVONhV4uyKxmitmaOFF1R/nZt5zjTEajJIIM7iUI0d
X-MS-Exchange-AntiSpam-MessageData: h0ej/ygf2dtjJW9Ky2GLXtDUnu0Ri2Pe7J2EHNSj58J2j8MuPROE0uk5+SAMtkinSNnFBv1RCez9AaCcl9LYxImjVOF5NxUKW0Gky9Wu23e7QrwXskC15OGAHwsfHhk8AmeOCN3uq6Q/LTJRS+hTvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26354188-62ed-472a-59a3-08d7ccd202a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 13:24:25.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TatfkgI0uOEeFos0oXQckWr4RN7w50QXYoxEcpKYQcsZSG2sloZYCj8pgVssAY4zmULXLN0BinPePuv4mh5f2g==
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

Add the amdgpu.rst tie-ins for the pcie accounting documentation

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 Documentation/gpu/amdgpu.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
index cb689fab94c7..9afcc30e0f42 100644
--- a/Documentation/gpu/amdgpu.rst
+++ b/Documentation/gpu/amdgpu.rst
@@ -257,13 +257,30 @@ mem_info_vis_vram_used
    :doc: mem_info_vis_vram_used
 
 mem_info_gtt_total
------------------------
+------------------
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
    :doc: mem_info_gtt_total
 
 mem_info_gtt_used
-------------------
+-----------------
 
 .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
    :doc: mem_info_gtt_used
+
+PCIe Accounting Information
+===========================
+
+pcie_bw
+-------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+   :doc: pcie_bw
+
+pcie_replay_count
+-----------------
+
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+   :doc: pcie_replay_count
+
+
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
