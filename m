Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6194CC54FD0
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF4C2073E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 15:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mV4LAOKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF4C2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01D1B6E87A;
	Wed, 25 Mar 2020 15:40:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F206B6E87A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 15:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/VWCbsTY6HQEmimk2JVcmkvtWXhj2ZlIlI+2cXlRq4XVnqmWIwTRdQpr4ddlZAzNOzRnh/eeQTkX8aGofcGeMJqFuzU0ImgG343TVV0FJ51lrAxzn5CnNt6z0zW4pJ2JKMqQveV0VOCh03hydikkTEhekT3L2e++7cZtOm931goG2RRELDsbuJDu6LV+xujM6y4FfghXjrhNg823TdlUEMyXz7dycfjE2w0Wnyzsc+lWqOEFI6AVQGaAHmVwWqaHC2AB0f4dfIJjtZ6v0ym1LbJYGkudp1PDIRZVuYo+oROPyD+R3+OwNLtXolcK3moGexvjJzwXhbQLj+vVS45kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBZCWllE1Vvdely/5hVet4F6SvG53upgfvIQ6lZn5Mw=;
 b=JgnTJeSUT/NHQ19LeKK4+AK3J669tVmaB1TKpzVBufM4LKisq9pXwQMrcEZmzEDNbImk4NFiNNaq7BHvPxDhNMfZTBNMEtK2uAq+xgi9nH1fiFZPFyKB9y7MnLmAvKy7PKL9skpScsXYnQ7NhKAcdfZPgXVIFUjywGsjGAYxwABm+8OLNLLUpBdAdbiNoRYJ945ZTsqMGhqrWsYzmsW6TLsjYvW2pnuMT2DdIxzObRSlD4BSvvKFuGeR9PPjvl/lfDMPFr0E3/zKy82ZMFFsXC+KFGmtbl54qclxe3sWyLLUBovh25V2nsyoNa2V6Zfnc7x9H9R1CazgT3mFP/4t6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBZCWllE1Vvdely/5hVet4F6SvG53upgfvIQ6lZn5Mw=;
 b=mV4LAOKN1bLLiP8ry40eTV8/WUlYWjD2Fmt1u25+DfOAA6rMzwJ0traaEJIXAwvxNJv9Tet7sFnSblRIoGj3OfQysrnwzfLVtpuhY6n5g8q7rStTYo7j7ZmrwwfZF1Pivo2QeA9tpM6OnUcztzRHEf8tvTNiww4dc1BacUSNOAU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 15:40:12 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::6417:7247:12ed:1d7b%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 15:40:12 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix the missing braces
Date: Wed, 25 Mar 2020 23:39:56 +0800
Message-Id: <1585150796-21160-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR04CA0085.apcprd04.prod.outlook.com (2603:1096:202:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 15:40:11 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e6680eb9-713c-480b-0f5d-08d7d0d2ce8e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4358:|MN2PR12MB4358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB43589F0EC7F842F31334BB18ECCE0@MN2PR12MB4358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(36756003)(52116002)(66556008)(7696005)(66476007)(316002)(8676002)(6486002)(4326008)(8936002)(2906002)(66946007)(5660300002)(81166006)(81156014)(186003)(6916009)(956004)(6666004)(26005)(2616005)(16526019)(86362001)(4744005)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4358;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEtccDoVkYac/RuQjXEN2DIgJE/11YsAJLHM0nKasY+TJ7T39vNxsX25Rnw7fHCqjx98JKghDFwWCRCkkXSvVTx2FDkwwxNm0P0mDHpTHIo5h/HAY79vOkigwc0m1l6B4IBw4JMD7G20FUjRhVx5Dknxd0aiViUT7UcYDvQy/mrTFWhqPsHWabDTNzy9/3lHDJR6E8XJP4KT9ASX5eJpn3LqENlat4OgGIaDDcBk0XZUjJr4CBVPhecaCCtvVMu4M8PokUqUdDl8K3G/EOjKln8jK++ApuZjyI9Elhg7qRytL4ZjfuDBLaNJskuMkml85N9gWO4w7+07nGQwiAaf1umWssvjlLgSrP9L4YkDbv2YoywCnm898iPh1ejX9l/7B3LE77jMcTNd0T1V1pg76SEUcXw0GWSpxkkzD2QZ0XO+uVeBrFW9Bc+W64HEZaEx
X-MS-Exchange-AntiSpam-MessageData: Ho2Qc6FUbNoCgVOzvhCYCul/plhpYFdfZMUVCO+mH4XZgV4Q7hImcD8jPMP+J0PJdMDXwQQulHCnmUZe97eiEMfU4Ie5twofw5xtGIIaG8MHyZuqX6BZ3BhoxySxiUYvO559P5y7MPhIigeEZ8efqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6680eb9-713c-480b-0f5d-08d7d0d2ce8e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 15:40:12.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHrNdwG2KS2a8PXxREHw1AKvpAlEEY3XbcC/sSEb25E4xYa//VIsuygyqyw4oJhWlLiAezlemtTG7ty3qif+Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The braces are missed around amdgpu_ttm_training_reserve_vram_init().

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b397148..8afe62a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1938,10 +1938,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 *The reserved vram for memory training must be pinned to the specified
 	 *place on the VRAM, so reserve it early.
 	 */
-	if (!amdgpu_sriov_vf(adev))
+	if (!amdgpu_sriov_vf(adev)) {
 		r = amdgpu_ttm_training_reserve_vram_init(adev);
 		if (r)
 			return r;
+	}
 
 	/* allocate memory as required for VGA
 	 * This is used for VGA emulation and pre-OS scanout buffers to
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
