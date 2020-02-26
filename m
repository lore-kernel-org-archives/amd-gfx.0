Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80284C4BA06
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 01:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A90B21927
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 01:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bXbGJgGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A90B21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE33892A6;
	Wed, 26 Feb 2020 01:01:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770079.outbound.protection.outlook.com [40.107.77.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F22892A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 01:01:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDV9UFZW2QRzf49VsYN4G1qNOknw6P8WJQmrTISHEx85iRuKzfcyx6cuRZR5wiXRIuDmyvCfmwewM0m0K7zkUncxShxzErFf8OPFquO6S/0ezgSIWftxywuMPNRFgfTtWTZINujr9Rrje17OE1oKawcj3ZhqlBKzgsPfa6wIN9PFGx7kwRcovO6StUEIsxz8j1gGnaUgOu8rgUjKNSng2YOWW+XvhMD05otjPZ3CVYPHNLIdoTCycBNhmgsPDtJf11L0L2dvQryryxd5Rgdf+czVKq36ATMoNXOTDS7KN+povlgwDid6cAeB1bUIGQMsNzcYUuI6s+o7mG75PFKI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ram9rdUPxnah8DQ1fe6kWRJZuLBTm2QzkJhahBuz9Wc=;
 b=E0Hiv1aUlFBpOgOEJnE+ld+abvHvylHwxIaCFs6ecBN77X4DjN24IeCGEWOUKm4LiyUso3tmKCQPjVfaZFQ375KQ6XzAPS5Jo46YKvP8zfAQpXRCrRchDo+LF/4bj7UfyAlklTLZOG0iGUjKDILPev8hlrQF9MpSU0qZ4bgnAoug6KWxX8CkNPAou5iy18ticOIQKlRq41Iu1EYE+Z53EWsrQvTj3c8Eieo3XT43jnQ8BMmxQB230Qf1MNeXcAMR/ISuhVcG5vvV8KH/ZERa/BSfVNjtRzmZn/eG28+3I+ItY4VKEq2LuNHnWemV1BGd2gMrtnqnHqwEtbCjCvmAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ram9rdUPxnah8DQ1fe6kWRJZuLBTm2QzkJhahBuz9Wc=;
 b=bXbGJgGMHo/fQdh+9SCnkm1GpWmcV9Yz6zHwzfYA1Xmrkho3ysySUkwfj0aGbkAPMLDP64FhIVzNJkdeuvOCxrhBSkKW7Lsq74KH7dDoUNygksCRxbEwNtXCaky4XMbgoZZ20kXFxbhVnea9izf7dezpevmMLj25sP5UpS9iztc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Wed, 26 Feb
 2020 01:01:31 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 01:01:31 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Increase timout on emulator to tenfold instead of
 twice
Date: Tue, 25 Feb 2020 20:01:18 -0500
Message-Id: <20200226010118.30936-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 01:01:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04ed4f72-423e-43e6-887b-08d7ba576aca
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:|CH2PR12MB4183:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB41830C869206A906FA8A26EAF0EA0@CH2PR12MB4183.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(66556008)(478600001)(66946007)(5660300002)(66476007)(316002)(36756003)(2906002)(26005)(4326008)(86362001)(1076003)(16526019)(8676002)(81156014)(186003)(956004)(7696005)(2616005)(52116002)(6666004)(6916009)(8936002)(4744005)(6486002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4183;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKGAOCr2MgbDisWGIAc2aMct0MDjlm044yDJOEuELEtrjqtJDc0HcCvIe16ek1Fxr1gWX770QEdrBuS0TuL7pZIRU+QzvxY8AaR+imIjZHAGiAdknWSmgL1Z4adSW/N500emh2V+xjjsAx+XC+vuk0jUbLpMlWG6I2yLw+L+o+aWFgS3dNi/xLy6riP79GZAz7LdsSNHYGEUBa+ZoSJdD6K+qgG+h1ZUrMo4ybm/7MIOtlo/KGc2wAm/YCG1YMvU3qBiFaP6Dx+lBpbDeYMELscaDbcU9CbJvgbBgAMg7Csr18vidpuQOOnUzyiyDhZA84jaNtIOwiT3z/+1F8DJTV1h9fZjcOzP2485FKsvzRDcipUE9KCraKaoUasinfPMrRR+dQXp3olBQRpmY8pAtlHWGnZjC0rPj6oz/i6I8g2ZvC44nIGfFSLQknqSVYBH
X-MS-Exchange-AntiSpam-MessageData: H8tHUbBnGOAh3ErvDFEKGJRQH0jz+A4kJvNfOI3CzZA4+hyF6SxIHBtw0SXMAHr7e9EsXn2dtsNuZ5ArPji077xZZsuUiFjgSesDdD1c+GlB1TPphpN5sQjbM6As1e6G8fmeH88nxmvUfjdhQw2u9g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ed4f72-423e-43e6-887b-08d7ba576aca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 01:01:31.5062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFwTeWPFTINY3jdxuegsmn9kUPo6JLlVMffa/qFYWgy9R4bhVWl4/qcUhEKMcP+7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since emulators are slower, sometime some operations like flushing tlb
through FM need more than twice the regular timout of 100ms, so increase
the timeout to 1s on emulators.

Change-Id: Idf1ff571dd2fe69d3a236d916262ad65f86c44e8
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 28a86752567e..8ef8a49b9255 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2834,7 +2834,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
 	if (amdgpu_emu_mode == 1)
-		adev->usec_timeout *= 2;
+		adev->usec_timeout *= 10;
 	adev->gmc.gart_size = 512 * 1024 * 1024;
 	adev->accel_working = false;
 	adev->num_rings = 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
