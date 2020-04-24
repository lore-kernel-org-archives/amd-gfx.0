Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D62C2BA1A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61DD620774
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 08:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R7huwpdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DD620774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 691136EA8A;
	Fri, 24 Apr 2020 08:06:10 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09C96EA8A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 08:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYAs+jRHBSeJguG9xTTfRXiFpFVk3wXWCTsYv3G7M+rxddcZ68JXUKRO4d54ZkTJhabCYTojJKO+6lmAUv7PNSi9XRZZUGeDaBFG+rtM5Zlm5bQIWL9CQbS8Z6sd7tTHQF+zGwzOwEUZA3uO0WNBAIYwKVKOsP9/I3NDKEa4b90Ic7TvfDTBR4NqrEC46dfc6xnVca0ot+LS9YMCmWiCgv+ArkSnude0jYj4rY/ZSDTVu5aaYn/9TCKMGjsuZ2BaDbvfwNvEY9hbWRD3C5Zj2VPvd1Ojc7FBBV+eREIvjlVy5lkWfXpxqLDckSDC65Z7Q2Y+fDvXrXvKIjLbdyRVEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kPJg0o6cyTTxUozeNeRBFOonEaYFernRY3qpG+NUu4=;
 b=mUz5aNjyJW7yTG+uSnKHtGGFvIH6xjeiHdRpJ/k7qd73R82VG5onk12LhYYtoY2NbO2HTF6n7FW3uKF5W7vfepwePjtUy13UD2AjwRP8mGABKMsVMBJ94hPAvgYFpXyJT7UDmEeO87dSWClaVqNKLRjX9AXAdIXaR+9L/KptMieZiCR5CMNJMWU7LZOMz2aOvL8PEk4kbIpe1eWu5S4dKpAiKrUVkzJGrTWDXYbwNfMy5AjtSqfoZZPbYOxoI1hbJIMainx5pE+87X/4Ah4Yq8lyLWiWHOKIJf0n/VyuH8X61ZNpslreoHrTcVh4H9eDoOsLxonR/Ts+uWTi5eDJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kPJg0o6cyTTxUozeNeRBFOonEaYFernRY3qpG+NUu4=;
 b=R7huwpdVsSX9q1zS0wWPGOWvTgfx6xjDN/RqX61fdOMD46/e36Ye3EuCyehCL9kRnQVuJOhEfIA2ugh0dqwr0sy7q0C/6+tIVNRIgw/EP3p/Vm+l9XSJO620+jOYwXGSkjmsOmyMW4hT5WYtdgIDsvkS/gwH8NIUPR1kFcEn/ug=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Fri, 24 Apr 2020 08:06:08 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 08:06:08 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: move kfd suspend after ip_suspend_phase1
Date: Fri, 24 Apr 2020 16:05:46 +0800
Message-Id: <20200424080547.25599-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0004.apcprd04.prod.outlook.com (2603:1096:203:d0::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 08:06:05 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c32f54e8-234e-4242-13a5-08d7e826579c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:|DM6PR12MB2890:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2890FF324025D4A26BDF5D0DE4D00@DM6PR12MB2890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(478600001)(4326008)(6486002)(5660300002)(6916009)(1076003)(15650500001)(2906002)(6666004)(26005)(956004)(2616005)(66556008)(16526019)(66476007)(86362001)(316002)(186003)(36756003)(7696005)(52116002)(8676002)(81156014)(8936002)(44832011)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QVj4/OZ4LPnd55fVuqUcw/k7+KG5WIw+uJkd+bpE0XReydNt7oO4XlSN9vsIveVRMYfmV1KPV2//cy3TIIZMMJ17tSlthJ5HwJg6A4DsjzN671ETTbVhBA2CXDqDGIWJtMDd4EC29htjbGEwVuJIqAcVne+qy3DbuNDzsT0N6OpOvhcej8SeEOpqPmRL9UkrmNfghK62ckXGkOjxy+SfUSdEMHm+8gSrKNMNfVpua/ixsycmUMrzl8ZYXQX8Bmao1b8iyqfST1B9T1V6JhtptcYfhZ8zIpPCGGioed494cLRi/hNnfVp+OKc8GimQLQkF8LSiA2EFWxHGt1cy1bpV8ulUQYcqzOehDNgKkMI58Ga/San8NkPR53wPSO3Y1keqVzQz7rJazuVtS9liqUcG27RI+N1cgcYxOiTcUmjPaDwj9DnskE9P4wiWNzUVji
X-MS-Exchange-AntiSpam-MessageData: FjYh0rIv1CuscmkSv+9ltV3E544GjsD1UVkTv/jlp+1eUV8C7r9PsCSQP+QbPF39xuApf1No5ujoUqBnGMj4DeqaYl5I+Lova9JdvGlcq10Y7pKphWBe0rDQcxEXHA/heWatx5leSBQXWngzZvtWCg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32f54e8-234e-4242-13a5-08d7e826579c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 08:06:07.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OX7PY9OEW5BBWIUq5wOBY2eYaAk0Gy8neyT19gfAU7t7XbWYNGoCwvTZFDHmN9wX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Evan Quan <evan.quan@amd.com>, prike.liang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This sequence change should be safe as what did in ip_suspend_phase1
is to suspend DCE only. And this is a prerequisite for coming
redundant cg/pg ungate dropping.

Change-Id: Ie125e234f8f743d327cf8e0389e4872a312184c0
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8eb339aff14d..08eeb0d2c149 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3456,12 +3456,12 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
-	amdgpu_amdkfd_suspend(adev, !fbcon);
-
 	amdgpu_ras_suspend(adev);
 
 	r = amdgpu_device_ip_suspend_phase1(adev);
 
+	amdgpu_amdkfd_suspend(adev, !fbcon);
+
 	/* evict vram memory */
 	amdgpu_bo_evict_vram(adev);
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
