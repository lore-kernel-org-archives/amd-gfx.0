Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77F8C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F56661494
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F56661494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7746E8FF;
	Mon, 15 Feb 2021 18:16:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64FE66E8FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 18:16:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKsxQLR/9xNZAXn7YSx4Csjg1uSVhzAAYh1Z8zJ1Hgzsc7aYoHfAHmkWPWdfFyrUW1PfboZum8DHUcq26X8fvftjQ7imlVuNqJaXKi7OUnitQ+X0pPgK4i42YCyY5ZaAJf8ve9yJBBbiutv+rGQWCrwoskg5++E182ViTnKG8Jeb6O5bQatZFXO+XvqxshoLygAR0nUoUn16ycBGMbQJvMXDcT2tN2fQOAmZhfRvNh0GMdkzMU8Y2Ph+XKWOpejfVd6iu31Jg0D1q3LpdeeKmJz3aoXOUBx84AgtsnewCA9LPiizNxBD6/eq33ACZvmiNeL7G5HoiIvd7YuG5Jf9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doGo6ZpXy37/I2FFv6EqkgAYWaeu64MqihSCvjWK+kI=;
 b=FyroXy+7he5haa/qL9vmSj5aJ3cvM0hp/Zb4vnLtRMq2EGORISWRs7dD8Io1GkKjvaBo6LruBmkEbaQe8T6Lpqyi83tdb9UYzrLfCR3DcmidO4H0L24C05P91zcXvHoLz4zGs6QU7VRlRSt3jbt9qt4eQuWXKkhgP8fg/HRyAyMRzkuHdm83s9obn84SnrfyCmF3E3v5aaAzKFZSbVOCGPou6x4/ck/vEPd3Dbxqsz/jNNsS6obA0Oof4tr+GFaJtEhFdQPS3Bdd36jZP0Qqo6I0aC6sEdMlG9+H8mXBdJ567Dr3OEbhd++iA7cWBmiuSB1bXg5tBHcvebCgi9bu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doGo6ZpXy37/I2FFv6EqkgAYWaeu64MqihSCvjWK+kI=;
 b=wUMJGNjpUMsQnORLJM9TlaQWFCrX86cfqiiA8lnP+NZcaTd0/IHoxZH+uYkilxS90f4zyJfgYCMQqTZn5inC5SmRBVrCmgK0yjYD+hJB1wsC6+P/GPVuKICOsPrpPIPjzwB6R0+8Hzloz/MhlMDZKjHaPti3yv27T0Lo4g/Iu+I=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Mon, 15 Feb
 2021 18:16:33 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.039; Mon, 15 Feb 2021
 18:16:33 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/2] drm/radeon: add rdev in ring struct
Date: Mon, 15 Feb 2021 19:16:18 +0100
Message-Id: <20210215181619.69377-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [93.229.46.81]
X-ClientProxiedBy: FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::14) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.46.81) by
 FR2P281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.11 via Frontend Transport; Mon, 15 Feb 2021 18:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5f13717-7ca5-48bc-9ec9-08d8d1ddd2b9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4911:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB491121C432CF54DD2D010FB18B889@DM6PR12MB4911.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 86lmaBYidVVhD2Xs7kTqDWhvBq7NHg/OZGdDVB+ttpEO5ugP743w/QjQTrtqPmrXB4eeCFjOQWRo6FnbxLKyPaV5agwTbAtDa/V4Of8iJrBkxIAsMEcHsHy/eonERrhFD/9wum24G3mB0QFHc3Qp7xTj5uD5oF73xrCVbVVWgyTwRAoiSlZOBn0nUCBVLTFb+DGoWDzaxVTnNvdj6A1KdJdCvpSjwcrhza6dER3JL839skGuyxSIEQb+g9U1rs+wE7ggcAiUESwKeKOfXPQOj/gDjjN/k/6uVuewWh6A1CwFptVq3Tu29ZJ9dBXqVkGtuMNSSjJ1BrNWil/ykPLLU7JResjCPcmWmZMZyIIKx0nm4Vxarn5K3gh7TQgzehRLOFmhtws2M97h23iC1nuX3CsTYfVkV7zmhQqCLDFN/fm3QlPMnCY6Skuv0CQQB1ypn2qDf9JJ83aDMyqA6/ef+endmVlnxPnxK5hzTBW8X027Frp7BkY3/d7Riu5axYbuJcqV4EhoQu8ZynOOBQ1P1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(478600001)(37006003)(6486002)(316002)(6512007)(5660300002)(6666004)(66946007)(36756003)(66556008)(8676002)(1076003)(6506007)(26005)(44832011)(52116002)(4326008)(956004)(66476007)(34206002)(186003)(86362001)(2616005)(6636002)(16526019)(8936002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L8NJCz493XKF4azNH1qSupCOREmU44ZdAL08incs36jug2JyBSWsLMjnlL85?=
 =?us-ascii?Q?hZTrF/VJ0qM2OgYu3iWSlwT4oO7V1moxYOJUjjxai2UVG3a56vSMgOLTp++y?=
 =?us-ascii?Q?vqrgH0R5uS9N6aF9xf/XCXNXp14B83ob7Ra33cMpZfCO11DYfRHATVS/z3OY?=
 =?us-ascii?Q?KbY+fVEf8X4yPY6x8xSY1wDlsOgV42F94kZOVaiwuBCaWJV0ogvw9rLi969V?=
 =?us-ascii?Q?g0MYKp4i+UkqcT5137PGwrzt7PLTFRHZaZjJLGctzmL/psJx+h5vlaBoX2AV?=
 =?us-ascii?Q?eSU9/mxa17XP3Rhl9uYgN5xxeu8rBEYYAz4/hoY2wXmDUMRFhKFANNSAgRDb?=
 =?us-ascii?Q?/bpEKvjGYwiYlFxfSouudIEw7A+IJzOTkmnPsDIIgAOkyT0qjI2l7qgvb/g/?=
 =?us-ascii?Q?QhWik1TTybVSsHvVEvLXyDJDU5KOZMr5VvF8PbQHZxZIQT8nwjQ1cnRnVXvJ?=
 =?us-ascii?Q?OFPbtFygItzPnGevS7sf5IhjrMFLrZN/nN/R6Ni2CHK6godiJsPi8DU+TVZ9?=
 =?us-ascii?Q?tB0r3CnCeXZEmhOGJ98fR4CI4D86VrabVR86he/SS1rLegJexb6WwHVgnG37?=
 =?us-ascii?Q?SIT2vjNKHHFBB2jou1DUTzZUTRtyd/BwUjg4dS6EzhmkhM19Bt1/Ejcp3ma1?=
 =?us-ascii?Q?9n4Lg9CM5S0WayqC1QEH/mtUOlYxSm036Dd+NwgH6pt20URCgrEi8IZL34un?=
 =?us-ascii?Q?mwFErklT/aOg3qTDKdtEoV5Ax0lPhX35kOvuaHTwtSOzf9mITD4g5yoBXir7?=
 =?us-ascii?Q?ATQfbsCO826YvtTrHTNURaq/YZ6towL+7AZdBP9gYV4UU+y8HFuMQ/uxERbg?=
 =?us-ascii?Q?kHjkaQ9xkekbY19bYb4QZ+J194fBm1d1remZAZ82h0yMlAxiPn5OuUtxTzmj?=
 =?us-ascii?Q?km7Ve+KsD9eblMrP+DtvOOD2m2FOHZItbpaHCuEQOuL1XILarbxJiNoKWUdl?=
 =?us-ascii?Q?30+PY/x5hOsiqRL/1xGJZ/rCfJjAg5QmHKHRNW2pj1VUZZ471EvE888Upaop?=
 =?us-ascii?Q?rmk/RiXL/nVCYQlLrDZ/RwavCKPTd/kHKQnl5OmrWa8bnmNoQrL/g+mHVLqd?=
 =?us-ascii?Q?Z5TbkWa/dz12QvFT5FfX6MPC83vIS6TtVLkzDXXn6VX+3lQdlwRq7VQZ4Qt0?=
 =?us-ascii?Q?RrSSzWAlvHgqHNIsPpSOUnsedWyNLo7mA2w2IopHdXRviMt/ZGtknugxqosX?=
 =?us-ascii?Q?Sts2/n4DNhEEEsBC6yyaKRlux3ERpknkbcBd1i9pD0XececMg66gI8MVnJ2N?=
 =?us-ascii?Q?NPTIQ/EGlC21pj9Z+7Cs4bFNfArd3xoxQaYQKqhr0cdRvHPbweE1dFK/5u5c?=
 =?us-ascii?Q?szfT3wSHBUQ3gopPc78vMGrM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f13717-7ca5-48bc-9ec9-08d8d1ddd2b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2021 18:16:33.0590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N307+xXRLRNolcXMBDQwLd/zILURMbeeDHwpGp8W9uB/O/VLiSOEBof8g1wboCyFIFRFDnjLDqwMK92TtpP6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Retrieving radeon device struct from ring struct will be
used in next patch where debugfs's show function can only pass
one private data pointer.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h      | 1 +
 drivers/gpu/drm/radeon/radeon_ring.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 2c0e3e7c294d..eaa9223d6f52 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -831,6 +831,7 @@ struct radeon_ib {
 };
 
 struct radeon_ring {
+	struct radeon_device	*rdev;
 	struct radeon_bo	*ring_obj;
 	volatile uint32_t	*ring;
 	unsigned		rptr_offs;
diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index c3304c977a0a..41ed8aba1313 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -387,6 +387,7 @@ int radeon_ring_init(struct radeon_device *rdev, struct radeon_ring *ring, unsig
 	ring->ring_size = ring_size;
 	ring->rptr_offs = rptr_offs;
 	ring->nop = nop;
+	ring->rdev = rdev;
 	/* Allocate ring buffer */
 	if (ring->ring_obj == NULL) {
 		r = radeon_bo_create(rdev, ring->ring_size, PAGE_SIZE, true,
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
