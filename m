Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C55C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 20:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228CD2065D
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RD3hbIvc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228CD2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6413C89F89;
	Mon, 17 Aug 2020 20:45:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2417489F75
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 20:45:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5kbuDWi5WCc7xGlue6DwrrpHIA9YuCK5lDgDQQuhvlJ7znQhufysKuX7+LY/G46nm04YApSuIWuVAGu3CYfIdY4IX0ccIfISvP/3oHhdBUsqDDO+3V8gMwu2N+JJ3RIehdYn82vF3u0o54mPbHdqeoj6mcrK9UpwnbFfyBlqJTPAdpc8ontm5Conldwgmo1oPDqnnKl2whyq0FoW69xnOBMfa8wdNCRfjWPBaAgsH2jFmTJ+DqfHjb7dme3HBrLIFadVIB5tFrEfh2s+L9LoGhfkL+aG3Y+XcjmR2oV/iUn4X+GVgwX4XovPJg+5A6mugJSkfwPHZ3X1smBmz/RiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hY6rqSY62jWvSjsY2vsUEI5k4Weqo96YwUn3EEcub4=;
 b=SMBqGTxMTdOrBl0mBOmchJOrXWONGq/k/CkZfaxOStb6+xLF6afNbod4pRL/dL+z3bNLqxzX3gfC7QjRz/dvXmnDtM6QRF/Y1fR15QjV7cJboLw+Ej2txdWuGddn3LJwPm/NebJuEpRFdZQMFRhcgCNeztm8qlObq2ukAvqh9kA93AYce3dY0YLM5Yzp7KV6eCHP4BDSQEk+Zvtn2lqqrn2H3e6/ygWOjaLbDCnTvYWYUum5htDNGO/GHug3jIxdy/itpCeeTLM1Ml6IGMujwM5JwZVOobzu+V04DhAoFXasKR0X7f4qy/cEQTn+7wmPgTx4RCV16aepEytnqSTBAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hY6rqSY62jWvSjsY2vsUEI5k4Weqo96YwUn3EEcub4=;
 b=RD3hbIvcsQoiYYmiUgxafo1XyCFNWZMtZvD79IMyf4e5hboANvDU/UgbSXj3zlQ4pgjn/SidQ1/n2mut/7dfbC9SzUeUewfkgW/ApElCZnltoyGk8WVHmkiLSamX9BxhMwzzcDmwvNEG80ieB5uLvh/panaaYrF5QGYfTmcvzuM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN6PR12MB1457.namprd12.prod.outlook.com (2603:10b6:405:10::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 20:45:32 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 20:45:32 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: sparse: Fix warning in reading SDMA counters
Date: Mon, 17 Aug 2020 16:45:18 -0400
Message-Id: <20200817204518.2827-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::18) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YT1PR01CA0109.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 20:45:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 693a97f4-2fa1-4279-1f74-08d842ee7bf0
X-MS-TrafficTypeDiagnostic: BN6PR12MB1457:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1457626D717405737F80023EEE5F0@BN6PR12MB1457.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wr+95VyPZ7IB1LtbzxFRo+auH9CJhrrZqQoaDpkUgKVP3hE2aZtspQ+9UuuV7s3N3YQ77XNovyCRxij2eKW8EqVphFxz+CUD8D5yvWP4OXB91Z3LEnJs5R3IQ1iaqr1UeVPUQlfoB3KIBVxvTwKDfuM09Eco489tIp79It7ZKiIFJKHO3hzrPxQxSAXbabEZB1n/tH1Eq4dAgp5D4vw2v+/O8PJPfmgGr9p5pB6SZPZTILfdpkSm+oKw3AM29abspi+GWAdH84MEGIKo4VJUNq2ZdZMPYZrZCPdy1qa/TZJ3YI8l5YGwy7j3m/kjIHRcfmaAGXrDeeMB1hGIvuT5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(16526019)(52116002)(83380400001)(1076003)(186003)(7696005)(8676002)(478600001)(36756003)(316002)(6916009)(8936002)(5660300002)(4326008)(86362001)(6486002)(6666004)(44832011)(956004)(26005)(2906002)(2616005)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iYyqxaSAlC8CxAPOIg1u62e3byX6JgMDSnfgPfWQ9G9fAC/owa5/8z7cDefXAMumu5Xs0WnP+4kr8Dz7Y6K8q5AakeibD40lL7DvaiAom24mzndcCsJM2+oKyyv+1L6eK2J42N9jw4S9FnrsHOlR6jDeCsMn5m6jQdCi15mLL2IG8gGI/ypxd8My4/DRy6r6aXOTQT/QcPjfIPZdnoj08sv0X1+ql+71HXvukAQA9Iawonm3iqu0zDmDx1d1eLzlZR7xjbWOfkGffWCuiUJHGOzfvZcuMsG9yAhHcqjVkJTiHPKNobrSPYQ3HssMS/r7lJQmZcBzavWcHq3Srm23XjZKQ0vtIDRcKX5yDoA5Bz+UUPMmUNc49rApYdf0tg2ShvpxaHh3XaVLcv86iCWkCubO/nbc8hHZuBc2EPUZ1SIroKiV1H/PfbSwEO3kKz/eYORxNQdi22LUoOYd184piRk5DYom/8piZwkeWDSSde2su/jFN/onJZF09IiSsDfHutdcbcM2lR7ALZnQuElq+Kp2Q2pt06zgcuw0XdNtk3Ay1oIhDwHT4nvBmoYc43EJZs4OqzhHM3IpPIpoKXWZjU+VxRHq4yKkWrEgq7lU7OKxdMt6ZBtPfg0w2ARiYCynIYzW6emF0rTZvEJrw/1jmA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693a97f4-2fa1-4279-1f74-08d842ee7bf0
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 20:45:32.3857 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XG5fN7bkJLTZOcWH5OFUOQa1Dwf6f8wDKkXW3WtcFRdrJiM5Q1OYJArrDwLpzwXLeHl4zShC6fHaJpm4RdDxpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1457
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
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0e60b0d0669..a6a4bbf99d9b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -157,19 +157,21 @@ int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val)
 {
 	int ret;
 	uint64_t tmp = 0;
+	uint64_t __user *sdma_rptr;
 
 	if (!val)
 		return -EINVAL;
 	/*
 	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
 	 */
-	if (!access_ok((const void __user *)(q_rptr +
-					sizeof(uint64_t)), sizeof(uint64_t))) {
+	sdma_rptr = (uint64_t *)(q_rptr + sizeof(uint64_t));
+
+	if (!access_ok((const void __user *)sdma_rptr, sizeof(uint64_t))) {
 		pr_err("Can't access sdma queue activity counter\n");
 		return -EFAULT;
 	}
 
-	ret = get_user(tmp, (uint64_t *)(q_rptr + sizeof(uint64_t)));
+	ret = get_user(tmp, sdma_rptr);
 	if (!ret) {
 		*val = tmp;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
