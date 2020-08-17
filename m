Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAD6C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 23:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9674E2072E
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 23:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mcSiqnmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9674E2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F292D6E150;
	Mon, 17 Aug 2020 23:58:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam07on2084.outbound.protection.outlook.com [40.107.96.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B796E150
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 23:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzHmgFqWSJ468hox1ZPdiPtwrSoTYijnv1kPOZfIw0bKjDH4Q88h9D57hxQGk5QMfShBq0j2M6khC2nZ6TFQ9/0yHjT9ACNjq7chiz/XYw6hOKNFUVu8lgKoVqDZBP+VcdJud1H8vmnX20VX2t8aMMPyTCxHGwT5ztif/J3H4M6ooei5lgEUdDHIPxeXf0RN4VeOpbU921U0VqM3Lq9kveKKJtZG/SS+MyNuL5SNeSMkosilBfO4iqg2je/MSJu8fx7ujCZ4GczIYBAjbiNS5HBB8axrPc4Qjw44/pZ7szKp0ciu1gk/PunshutQkWf26gEId+IXnR3G5BC3lS7UJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+ptouE+OH7W+hby2+O/c9Hh/QW6g9V61UclAVzKWpk=;
 b=YCukECidDY0pqP9kOS2G2fFJ58PCtITy8dbhWS0q3uRo9OQVK4uPTrtjWXDq33rkd3+N/VQF0JE1N1imi6PrXDDJEmuum1ltJjE9oqUorxkaSNSpseBuYZjelSnZmco/ehvrdi3FIocJzTthYCm2CnZhlgTrAZswUn4WzhnB0jUWULGoZRGjSXgNs886keIlFJ9Y1M3k2S5sFb/GRx7/W2Uns/kHDux83s7y6dpzE8o0zuno0JqkAwGm50tpqqqiNfSJkLj9/+ct2pBwQvUuRJ0h0Pv9t7cVkWIx5KUXV0tTqjSNBD/MTgbHnNSCvg9kYWa8jXDlmVXJ/Ix1ciJ+HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+ptouE+OH7W+hby2+O/c9Hh/QW6g9V61UclAVzKWpk=;
 b=mcSiqnmzlXCukBZqvAmDyogHBxTqsEl4q+n4lqvIID8o7Esy0TbG3NUYmzHY67dsNE40ysuvgGebJnrdcagF6eQqiNHWxL9gMiVsfaH+NLuXjs1HSY7XqMq5YDcr4VpbSUebQzEvSssic0NQp8eZIHUcJozupFu88jZs2F4omfY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN6PR12MB1700.namprd12.prod.outlook.com (2603:10b6:404:108::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 23:58:26 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 23:58:26 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdkfd: sparse: Fix warning in reading SDMA counters
Date: Mon, 17 Aug 2020 19:58:12 -0400
Message-Id: <20200817235812.5518-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 23:58:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03c98b42-8f06-4c08-b422-08d843096e71
X-MS-TrafficTypeDiagnostic: BN6PR12MB1700:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1700BAF5444B26A82517E8F2EE5F0@BN6PR12MB1700.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncnpNmV56rZXy6kEP0CJIIrwG1BR+2I8Kk4KCWqBYaw34R/7ZFoqnAAS6fpiUicXFaIslaYTIghJ/qwaww1uZTVKC9X4lViGqDHgJSzgxfzZJNzOpXSNK55Y7h/F0wYgjdwyshj7jVDDK5UirSWmzB9or/R0HMXCX/fzV0s1xK0EH9T0nOapaHrP6DrHpwyPOjPhCNfDRWbBDSn1o69vcVf4iiZoVHvnqunjFOgK6J0E+Mh+qo9sKxCBzm5k5C5N5pAU/0Irh6oHGoiplGEDSVjLWG0155UXdXZYfKfLuLhXgg/4O0VoYA8frvOahms42Z6zZKzOwjTu++h26CtzxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(36756003)(83380400001)(5660300002)(66476007)(66946007)(66556008)(1076003)(8676002)(478600001)(6666004)(186003)(86362001)(44832011)(26005)(956004)(2616005)(6486002)(52116002)(4326008)(6916009)(7696005)(2906002)(16526019)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3a9PtqwlZnv4SmLIPn1zcfN9fnbhXEHqpvbnWrtGvhCKALknymAAWoYrXq/lbtp1c2UdqIv5G/3jQdQR91fVLOoA+BoRBqaWmnfJ4iw9Lt5PNwRlqoR5+8L55nwdAO1ACCetsA1KiqS7C5FZoS0na24dQpEbAmt09G+05IbSrWIe2Sz0Va5PZcBOGEFpicEPhhe+/O1hOhOORdJ/itXSEW0nzYwUjC3o2f64ekg2W8N1jFHIDRx6cHw3KzK45Dpt3sofG6S2nkqglH6qLETwwTU2ULZtqgBOLES/Z5IZ8mOVdPV/o9KPXYim/BZT9PWchIy4AAU1Ws5gn+8qPenQ6jNbyyh2sKk2y/rBjL2pptA5+Xricqgiv4BlZSEdGfhdc/xFIMUMCsZ2JD+zhJl5dWQqLS4SddanroUNOmy4zzsMNCLR/SjLR+/0UfXCBBAFBxUQ/ngd08BPGXklkJLwatdNZ6r5DJA7RolnqIt+hvQpBBivW0lFZnYXiCIcsbhbZvlkCUxkvcfX1h06T6F38pE7hqcEl5Ptt2ZFDTgVviE2oWeNtYh0qdReyUFCU+ZF2wPFVYoC8jVCXDr8S+f49bO7eHDyBy4v2pQ8DMsEl8AXhuNYUHiqnEqdoqApjDgdEFzJBDwNu81vRuyFx3zMZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c98b42-8f06-4c08-b422-08d843096e71
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 23:58:26.1566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZqmWCm+qGwTR4z4wg9f3kFPniSYpUmgCJczDF+dAAvNOJyz4HAyAboF78G6bxibMBmkXAVLpD2wsYdwYxL0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1700
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add __user annotation to fix related sparse warning while reading
SDMA counters from userland.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0e60b0d0669..e2894967c372 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -157,19 +157,16 @@ int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val)
 {
 	int ret;
 	uint64_t tmp = 0;
+	uint64_t __user *sdma_usage_cntr;
 
 	if (!val)
 		return -EINVAL;
 	/*
 	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
 	 */
-	if (!access_ok((const void __user *)(q_rptr +
-					sizeof(uint64_t)), sizeof(uint64_t))) {
-		pr_err("Can't access sdma queue activity counter\n");
-		return -EFAULT;
-	}
+	sdma_usage_cntr = (uint64_t __user *)q_rptr + 1;
 
-	ret = get_user(tmp, (uint64_t *)(q_rptr + sizeof(uint64_t)));
+	ret = get_user(tmp, sdma_usage_cntr);
 	if (!ret) {
 		*val = tmp;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
