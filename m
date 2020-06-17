Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C62EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687F120734
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgVdVQEg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687F120734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29FE86E1E6;
	Wed, 17 Jun 2020 22:00:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C296E1E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvsHUDz1NPfuva4FhzTvSCd7iXo0cf/7h3R9c4XrUy6K/5gDVJyOa57wVhFS1lQgEG45nwVXu378Vpsajrg6AT4rdy0ebKEgi0nr5XDGohv2mU2xGicqqIZMkuOKYQReQTsHwG6ouQEEfPXUbBGx18v7nfnh1i5sFZYzjB0YfJP7tAK5O5dMpXoAHBqCMVEXDl6wWefr7GrKHFC2D1znqxbEx/3QDXDXxDctxWe+MO0vtcBU0HnMPCOjxDQ0dU40ewvipydLttvGitiljuciizbc5lYz+S5ykIgaM4d8oxXVCmXQDa+wTKJc7pdeD1zFIZdR+wiDZ1sBo3wMHPYrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uupBC5ZH9S+Dr2OLdUs4Xzng+ULZCyf37fSiZT2Zk3w=;
 b=JAzQqusHBV7aUtBqRlhPPF8yj5SfYcLM/fKx9fFywagYoO4akiSW/eogZ0Qakb+a+WXERLa6fcGMJ5UKBIxduaA/6RjphZLXbWdTWVf4Dk/rU+dss0Aar/HiTQLUo1ZzQRmlKiM7k42qu20sbDjTrL3SAY8zOJn/UH+qPakWxbbVpjGwKdbKy08Q8z7CY7MMqkDxXjWSyFYNtr/p2sMwNz1ve0YDWRhSYM6D1Gx0lf7OMhd6gal9hXQmvayPl/2zD75umoQ0viQJFm47qF4HwuW3kSrOAfTwr+I9G2l7+4jNmBEGYIsujtyiJ8CZq7dJVlNwe2BRwO9K9UnM0pQbaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uupBC5ZH9S+Dr2OLdUs4Xzng+ULZCyf37fSiZT2Zk3w=;
 b=tgVdVQEgRME5G5qeQmsJTrjK7eS93IMMlH/evDx8P0A+i007IVGOYPA7iwWu23es+aC3EF+gB3jzwpNe5I+J7qbe+RBy7aw+troSChr/kx8kk4FBDlVObgVo1CGDGmixbfMkFgoX/58n67zjTQg3ELTOWcvPxZB7xPkNnUCZYdE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:39 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:39 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm amdgpu: SI UVD PACKET_TYPE0
Date: Wed, 17 Jun 2020 18:00:10 -0400
Message-Id: <20200617220016.4844-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: da9b55c6-2edc-4d65-c395-08d81309ded3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0185BE47F40A5114928F3BABFD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDX6eZekOeik9NjAWkjXodwoiyy2QPvyrYAVF27E9sIMf3iXawavW7Xrdq0H4pwfscN1qNCLnWqWByInSna7O10E1iMplbxDwHl5JAMH5QH0/z8xJsoKZ0RlnmTKl00LJ6nRuhp23nK94mGFEfGY7glnh8LU3MEpPbU5msZ45dcbdysJVHj8gsa/wuaQ6kUFecje+7dEKF+d3FGO6jru+d7YeP8YHnGUS/XgFfsC9iC75ymnvRxsZoD7nKqjlKT/I1+YPx7lNqcbuVn/Pt6LNz869HbFkjLbHZF7Z1XF47YCwNseTwiRtpd18DSAqyk3dVO259VFLrQKl9McImDV0sWtAOwYv3q4VvqHv/GQir1vcBAcExGH8HjK6OiQmftd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(86362001)(4744005)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: rnA6fUmytHra9s6F3T9HKLBGK1u25iRb9E/YEdPN5rAx898LLBoCabDeHkf7TWPaVBlDeFJ1++MZnBJ2fTIpDQAGbAVavwxozzZJG1nj2+3wRzv1bY2jxdG5JVdS5KZvQPfixNHGDO+bj+RLXClPMRATRLHnZALiyhSY628vYcdyDk+cCRY7rpONnAa7S6g4uQqEN9A+5a4CL7pQR+u+2xBUlQfqxkFUv3FUdf/lJdDxWiWqN60/1zHiRj7Vs0VDyl3IZffCvwc/lB3JvXiL1TbwqwLIUBwcQlRaK2vtHIvwbG9ItTfQJssgWx+E6MSzTbgK2GP63gJwD7AZfSK8GW9yKGDHBSKfBNCAveltko1+NoBDKLvpi4+E3RpDZkeh4bhtNMrGiEEEN1lwNkOa8TuZk3HmJhnBbQ6LMsKOW/87l0274inlUo7qKE62kD/loq7+YbOWI3sZeV9MuDokfw/yhilTnPEqcQd2AnQL5nw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9b55c6-2edc-4d65-c395-08d81309ded3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:38.9687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0wwW1lUAbS5weIG+/YNy21L78y1MtDW1MKf2O4stTEQSv3S4jRfHeJ+oQH3noNui/yJE30mcMtdYAmY0rMHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 drivers/gpu/drm/amd/amdgpu/sid.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 7cf12adb3915..75b5d441b628 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -1646,9 +1646,10 @@
 /*
  * PM4
  */
-#define PACKET0(reg, n)	((RADEON_PACKET_TYPE0 << 30) |			\
-			 (((reg) >> 2) & 0xFFFF) |			\
-			 ((n) & 0x3FFF) << 16)
+#define PACKET_TYPE0    0
+#define PACKET0(reg, n) ((PACKET_TYPE0 << 30) |				\
+                         ((reg) & 0xFFFF) |				\
+                         ((n) & 0x3FFF) << 16)
 #define CP_PACKET2			0x80000000
 #define		PACKET2_PAD_SHIFT		0
 #define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
