Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F56C18E5B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B85B620663
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hzMl5WNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85B620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C5546E11F;
	Wed, 25 Mar 2020 08:14:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B64E6E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 08:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2Mw5ujq9Thk3jtbkNDVA5biCY6o6Lqwmamk45hh95wRUAFIozKa5jE8/L4/2UZ+MMNDXXTEtHGm3fb/cNn35TNNTvl/gBy2V6spSo9W1HccwLojYCVvYEBdf9a8bjXwYq0PUowdA4CrYU16LOfDBBK+foETRWv3eT7VXm+cHT5X6y06o9ZczU+PLbGjgAIO9e2ID1Lqe6zAQ38/Vuv5SilmY1+7w+rGigcAviB/zA3xSTKX9YErojbkyA/iUbPYAcJNB+j8CiJwhnUaZ7TuqIxl+N3gknc2tohfR6Ohdk76dPHXyH3x7QpXqMWoq2yhCk1LTfJf+N/4uVq7yf5frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP8nhh5mA37QDIzAuQjNQS2/fq5yE+gHmMnBaUkQKII=;
 b=g292DK6xX7+HTLZJfWE7G3F9zkM3JU6eqxF2KyhOdpzjX36klOfAYO7gqcjj7RuOlRzm+GbrElP2J+PeLF37+zfe1jwzZ/1U/oFQePhEFy/lMCaQ1fQuHaLqjGVQLJCu5yX886TXVpJb4ROppkMmX4PffSEZbz+I0A14LDXkow6AeZCys3FnEDwc7BscBOXYmlI1u+Yyoe6Xb3jiEPyqrT7quYg/+s2zYW621cHDlnFivFJp4Rrju/SeRkYuQ3nC1yYzKFeFdzfUVG/jbhet8uTIjNco8usl4GSFIzhimKXRMFjIdV4VZzyo9dB4KHM9FUa39ZFdfp/C8lRMF47wag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KP8nhh5mA37QDIzAuQjNQS2/fq5yE+gHmMnBaUkQKII=;
 b=hzMl5WNyXwCvduyyNok/pjx2N1yqLjXRLRnuWK/37zpwC80F7zN4wYXDxAXeesrK6k1zFzZfM2BHpHAMPVi2m53y3P5oGLqiInnbp8OMHvH5Zi5RWNDyXu4dYYnh4O4UKjzz3APtZiqadE6KD1yLYz0mfEGFuO7bT1HIxEFl0E4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Wed, 25 Mar
 2020 08:14:43 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Wed, 25 Mar 2020
 08:14:43 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: unload mp1 for Arcturus RAS baco reset
Date: Wed, 25 Mar 2020 16:12:08 +0800
Message-Id: <20200325081208.10110-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0002.apcprd06.prod.outlook.com (2603:1096:202:2e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:14:42 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f5d3e62d-0cba-4466-de32-08d7d09492d0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3552:|MN2PR12MB3552:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB355283481B104B53072E1DA0E4CE0@MN2PR12MB3552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(5660300002)(478600001)(1076003)(186003)(16526019)(86362001)(4326008)(52116002)(7696005)(6916009)(26005)(6486002)(4744005)(44832011)(316002)(36756003)(66946007)(2906002)(2616005)(66556008)(66476007)(81156014)(956004)(8936002)(6666004)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3552;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cS001vysXtVhGEsDONM9mPeJfRQHR8gsTq5EIwN0sCujF5e6E93ZaTzwOJNzzxYdjJuHvW/2WOB/w+nnjHZTUdZzVxql7qKZIagBgJ5/KkfohKbc+VD3j5wd4GX9gktaZlYXV8vNXo9+D8YAJlFeD0J9N/5y8R8pd1nog2kyBDK9ygvG79NA3RWOnDAMB0IuAif161K3eamr9bBM6SeNKTdf0voZsRVBvDKmJ55LNZrz+jYComgiasfmAivAGozrowa5fSNemBjBMBICJUp4C5LAJP4mMG1UlBF/+96XYONpYi08uN518iVeTINcFoPHK+G8lQMVmReAsPOlKgPFOjQo54HjaV97yb1hA5nAiNfavvrAD4lgqsncENV+l0liijar038ckVA2JWmF4eaLudUhyKLXCaG8UfiQeeKilwJ5kC72pq3kgC62TI89jm11
X-MS-Exchange-AntiSpam-MessageData: YiZPeo2OaA1L+CCHB3alggma8+citJh/Pwsn/CMgN9qLyeGiUmkUVBE3gLfc8BWmUD9U+lraZvIvTfB8Ij/ZDPj5zaDMg9SRGFhtx0kp54xJb19m4gSEnkvn90JmekYyyb6URcBjuctKr0CccNWAFw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d3e62d-0cba-4466-de32-08d7d09492d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:14:43.7071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syM62JapaRlZlCdTo9hnmvpu9vRJDwzNXie+UIWC8tD1tvtAeu8b0U0hE3qwoaUN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This sequence is recommended by PMFW team for the baco reset
with PMFW reloaded. And it seems able to address the random
failure seen on Arcturus.

Change-Id: Ic5a83ad46466a12533e9f704ad06348852156e78
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 4fd77c7cfc80..914c944d901a 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1719,6 +1719,12 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		if (ret)
 			goto out;
 
+		if (ras && ras->supported) {
+			ret = smu_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+			if (ret)
+				goto out;
+		}
+
 		bif_doorbell_intr_cntl = REG_SET_FIELD(bif_doorbell_intr_cntl,
 						BIF_DOORBELL_INT_CNTL,
 						DOORBELL_INTERRUPT_DISABLE, 0);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
