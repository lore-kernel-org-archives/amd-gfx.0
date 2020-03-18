Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48030C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF19920772
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qt4XE9rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF19920772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF2F6E1F3;
	Wed, 18 Mar 2020 21:14:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C466E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwYBIdgNUOXQ9SmLB1Avf+/RzF0car0vlHTbT/4ChTzPjvUVeLvLhR/Jt/qF6f1QUPu8FznOISMyFh09TmSz7b4kWnv7X8YvDRbcqpRwuDGn0HgDWmo994nCwY9bqxNMM4goy7MM9kNWt5DedaZd3PyExT/zWqQCFF1vaFUKOyJLQs1XTK236srqDBzyFoAz9D55ZxjvuMnnx+piu1nhJD0VcNCIGxsY0RUfc7V4tVVh/bsZKrwNODd8uBNZHRTZsjyvycuHCXwsI+UasgwDi5PdkilC61oh67utLVkZ/1poI3bfCSG2sjzLoEB/7GxA7gsQE3D1CItSrcVA7mTt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnNG3F55+L/Xo+1Mwk9KWKT9Yzeck7U96jehkfNjfaY=;
 b=WqjA7QgRFncJf9uCLRahnInQT/FswrLB/rF6XInGGsPqprK8FZd+4WpOkEIQVp1udl6VzvtOQaUnRzfK7v85pBds5XNj9tY4sm1heNuben4Gd7j0BHPnKMJuN+kLRbnr/Az5zN0h7ct9btnNEY9IrvgoB7gYr1fzks5/d6f++PadjgO/9e1gD9v3sofrCLY7x3GIyZVLyFzUaKjgUUOgLzpqdE6/TLnmGzBEXtr0Yliujen2IbtD4OdZGwq6nBO0VUTronQ2OlVJxaDV/MLYDMx7Ob2OU+OckZ6ihods1ZC1uEveTjrX0XYaZ74LgmqU8k8iG6l+uizgG+qNxpsaCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnNG3F55+L/Xo+1Mwk9KWKT9Yzeck7U96jehkfNjfaY=;
 b=qt4XE9rJxfHnK+1WJD0Q2gzLIh4xmO10G1XkJY8m1WgVuLsZv6zGWzVDIZJhTzzRJ0TOnU9nPaA71JWoLsS+B5Mz3Z8/1ZqGO/s116oQvY7BkmCGIKCmCXG9wB3flvAwJ4t850nJ4MkTuYig7AS/QkP6hWY2XHHn3jOlfLqrXmU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 21:14:53 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 21:14:53 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: fix typo for vcn2/jpeg2 idle check
Date: Wed, 18 Mar 2020 17:14:43 -0400
Message-Id: <1584566084-23428-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
References: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2835.19 via Frontend Transport; Wed, 18 Mar 2020 21:14:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 900c9b63-d2b0-40b4-fa70-08d7cb8166a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:|BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29984E5F2CBA7A6BB20C5202E4F70@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(186003)(7696005)(66476007)(52116002)(26005)(66946007)(316002)(66556008)(5660300002)(6486002)(2906002)(6916009)(6666004)(16526019)(478600001)(36756003)(4326008)(8676002)(86362001)(81166006)(956004)(8936002)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2998;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cm6IJ0cGk86RZ1cccMSqSYpHlZf9s4ftMppKvyDyLhkVkznm08m2OdDchAdc/iKnw707AoV1OtXOGuDbaS2KkCd7RUgcLLhIZMmt2RDU8nsK/WGbreMy5nY4++6HANQpEhDYok9Eo7SUh0AJOmDN1b5RCbDUtBM8b1ksA9HvY2vEfBE9RqxAc7tR0NxDiA74ILJoUhQQOA0atZPgGTAeBmXObyCuefQyDuUPm57Ph9FSrqAxBGce0nJBgdT1mIDNyCkYdJyeS8J8LTNFQ7zY3Z5fUkKCbZfJgr04/jgnqEDfMiUZbeZXZezhZottxQkQA1/HKBOFEz3pBUxT5/VzVjE807pGP+xjsAu3IhiEErird55wkE5rWZF7J8NxLC2qy7RTDg8qxyLVKuL0ebGEZRaVZLoO0mMN6D9BUQZPVLjQtgINKsuIWs7K8ragjoVI
X-MS-Exchange-AntiSpam-MessageData: s00pbAocZh3w9O4kGvxBZGgxr86U3zRVzOWtszLc3IbHtkObShhXjADu4Hwm/gm7Fu8vL0OGfmavUyuPBXZO5pwgGeyyXo1sLH6tk98aYVzqJ9ChD7voq6HiceiEWJpQ8NXFXdTISHsEbgh49DhKNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900c9b63-d2b0-40b4-fa70-08d7cb8166a0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 21:14:53.1418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1iKcT7Sli230gVBeiSOmBDmhIG21DmzWWSGp1OFPASb1eQUSZ9tTqakBi8aQgAA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix typo for vcn2/jpeg2 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index ff2e6e1..6173951 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -693,7 +693,7 @@ static int jpeg_v2_0_set_clockgating_state(void *handle,
 	bool enable = (state == AMD_CG_STATE_GATE);
 
 	if (enable) {
-		if (jpeg_v2_0_is_idle(handle))
+		if (!jpeg_v2_0_is_idle(handle))
 			return -EBUSY;
 		jpeg_v2_0_enable_clock_gating(adev);
 	} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f2745fd..ec8091a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -1251,7 +1251,7 @@ static int vcn_v2_0_set_clockgating_state(void *handle,
 
 	if (enable) {
 		/* wait for STATUS to clear */
-		if (vcn_v2_0_is_idle(handle))
+		if (!vcn_v2_0_is_idle(handle))
 			return -EBUSY;
 		vcn_v2_0_enable_clock_gating(adev);
 	} else {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
