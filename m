Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0C9C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 05:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E959320BED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 05:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X41FxFi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E959320BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281086E03D;
	Fri, 23 Oct 2020 05:41:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 188B36E03D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 05:41:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTptUp8Bt02LD6V2Ji8vxz2YhOPMJFwHXYSNndOxVJFyksKA3DKrS3qLpIQMsSZtKHiDPvdi53pvzMtbHr8JbPHefje5yxILhIB2v+I1nF3BkqVHLpgyNFFuNJaUVrUUc2PqKYOHQJZn1YQ8hkO4rD+t1iUKbWq8LzKzD0QjV6i5dYwXWj9quCSyS35lUKsqlQvKdomRwE50UN6W8/J7Y1LipipULO5W+SgVcWAmy8TtbReAB6UGUx2l3xOcFyCRMJzVyTh4cOse9IOsj09d/iOQp2OMMwz+tsnqKL21Bey5/8ALVQh62P6pvL/080MILFJEnwXmf0xiRIP8hM5UQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruo71TtrmJR3BfCW/Gry8SIAtm2rCJNgvn264EXA6VI=;
 b=j5CezIrnsdGmkohT0Pj3mj4tITpkHExo4EOvrpDozd/Z8vLxnZc4porjso64DgxsJySm5dSVS3nHd2y/5WHYoWWWW8UJ2kb62JtmqUucu1BTmVymfH8uReteNZSzngrZdCT6LUDMAi14Sb/m3aewLU9of71ovasv+2FqkapQGJzNvB+Hl+yf0rq7xxDKSTCy6QWKBZGJ2ZKWECVODEEgICc45+EfOtzRrStyKXyejUqNQoIEmdOAM52C9V0nQjwxaFYrJvpzRLKwm0GC2tGG8Zy4zfIzImp94Fuud0gzMuo+vG5sBDQy03cbzFnlid0+72U/VVBgF1EtVf4188OOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruo71TtrmJR3BfCW/Gry8SIAtm2rCJNgvn264EXA6VI=;
 b=X41FxFi/NSiS9Bzi7wZEl4TrVOe/Glhm01McleZ9FtikLXodnDo5LDtUfzj47+NmZlhGFBnq50iYtJ9fWmdc5xA/yXNPsn2zPFLInqqdkkgYmDbmApJzXqVYBrk+ihXUDLArXEYcPk4c6HUPbok6hHLR0hQV2Br2WtvYoaLXREY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) by
 DM5PR1201MB0059.namprd12.prod.outlook.com (2603:10b6:4:54::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Fri, 23 Oct 2020 05:41:30 +0000
Received: from DM5PR12MB1609.namprd12.prod.outlook.com
 ([fe80::fd1a:2714:59f9:b8ab]) by DM5PR12MB1609.namprd12.prod.outlook.com
 ([fe80::fd1a:2714:59f9:b8ab%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 05:41:30 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix size calculation when init onchip memory
Date: Fri, 23 Oct 2020 13:41:12 +0800
Message-Id: <20201023054112.3307-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0024.apcprd03.prod.outlook.com
 (2603:1096:202::34) To DM5PR12MB1609.namprd12.prod.outlook.com
 (2603:10b6:4:10::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (58.247.170.242) by
 HK2PR0302CA0024.apcprd03.prod.outlook.com (2603:1096:202::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.9 via Frontend Transport; Fri, 23 Oct 2020 05:41:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 983cf002-044d-4d33-a9e3-08d877164a82
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB005928D5D1168029E3CB3B88871A0@DM5PR1201MB0059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRlAsDFz8uWVDCVweTot9UUTZII2YQkyBpgYnMCjiJMUsc5E2nSB00csL/syWo1t/VOa48iWtDZN/isl/i6Yit8L3Zreo9DdKBxvC6+ouGTFdUgj0k8ftq+FXU8uxztjiHbt/B9EwUpeDKXWwRsImqMvngOd9Xf4DE8nvleR8ju8iFV9qpVI3LkpXswkzBbMFoG+Z85WNgRwzOREkAz/zn7T/AowpztW/F0z4WpD7B6LKS14LBSXH80bylKIRpXaQNDSgbRfkSyEoGbUZ3V/flrJP5gjaj+4eI3Tq4rOTerDBD9zmtRGQQPhC/jbOVlgr4o3HO4kalgtAkbTe3V3/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1609.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(6486002)(86362001)(83380400001)(8936002)(4744005)(4326008)(6666004)(956004)(2616005)(16526019)(26005)(36756003)(6916009)(8676002)(316002)(52116002)(5660300002)(1076003)(186003)(66556008)(66946007)(66476007)(2906002)(7696005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: qbCW3siQrnrvN5JVwwoWvmMoCJvZqgkuDbOnA0NhzFLl6U9KC9d4LaNf1z+hU8iKemxdRyMUTMCEsEM/MZqWaNtOejqDIQjfYOodS21rLwoEbNBmQ3uaRk6FbK3IqfgaWiXcNjHSIwtRuu1zULQ2JK2tMTmOsUsDTXy2NXb3iJu2rKTiwfIRRrSqO0/Hig8xECc94XepPz59RO7Gu9jJJyRKoJqyFl4osKP1whXEWLHiLolkpZIY36E4juDH/oJbMubjsgHVMIGArj2hHJw0b5D3e0fUOPZlXE3jah90766WqAU0aaMPTi/1yrvMXxMxaPg/CQcl6f5+o/oN1UaKtg69HhogvtXeciilmtB9cGJ5QnNMFKXkEJ/Zx+7t72Ql5QmkOgSmMN2ZKiKYZzEmbKF9MbB8GbyE1hNcQ3C+ZVAvuCoYmNEDFdrvsM1vozaoZ8wO7yh6VzFaOzCJtDgK6H7iqZXWFV9Mjcd5Ssrdj9z47323G9Qx2zEGkP8qxzkQ5zBzUopL2ukeKYyJcc9Iq37Qw8rLoFbUAonD3CgdIK5FtoW645Zjnc3XWnMfZCDTfZ342pw8DG92OukYCu54rCRU8QLWDn3XxtZZR/hnLEdeGsuUnUH30NhIAAWtLSR0C4HC6U/dwAbSqdt3mfYW5Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983cf002-044d-4d33-a9e3-08d877164a82
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1609.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 05:41:30.0136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NWSaDFD011BGD7JpoI1IXItHPbp90fq64AeEFfcQb07yw8kuOHfchgAIxPenfC6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0059
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com, Guchun.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Size is page count here.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4a85f8cedd77..11dd3d9eac15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -65,11 +65,11 @@
 
 static int amdgpu_ttm_init_on_chip(struct amdgpu_device *adev,
 				    unsigned int type,
-				    uint64_t size)
+				    uint64_t size_in_page)
 {
 	return ttm_range_man_init(&adev->mman.bdev, type,
 				  TTM_PL_FLAG_UNCACHED, TTM_PL_FLAG_UNCACHED,
-				  false, size >> PAGE_SHIFT);
+				  false, size_in_page);
 }
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
