Return-Path: <SRS0=mx+S=6H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24988C55193
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE3A7208E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2020 07:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="u+NGkuv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3A7208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B817289EAE;
	Thu, 23 Apr 2020 07:02:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E10589E9B
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2020 07:01:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVu9ky4egyCnfVZHL8zpH0BXOTXIeN8DSzS3UHwYBD+moxmMaZj5ibMUgxKG3trUywXo4MMpRGrlBU40nsAE9d6cIyPKJJY6Jw60Kg1YO8aCRDGTyWv7VGRg4LknkzDzi/V0GAbE1UyiGK9zhvQkRtDuEj01ZExSazhAZhtTE5okMWLMplN/V/Tm2WBwZTd+1/GEO26Ujj1JatrVhcBeQHVsyQIDnBUZWTP5/ZjJEf8mQl21PGe4ugjf193SZzkDQ1rVgXYLeZMXSQWAT+qXZAjSKxJ6wdZzdJZ3sVZAuWKUOdGgAY4Z1lX05rKEoaU6wOiUqcazV7mGZw6HaGbCqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yFdEkpMpQ5lU201rU59fQVFsvo8aIlgnZWnVQmla6o=;
 b=Ob9OXsyJqbxWw4Zk5WOJkkT3EVL3oTtb8ZV1d0oTLm6mDzuJNfqoGGf/F9nr/tU8EM9p0jV6vuHDVQBseg/z1asHH2i4ISTTO4gZGBcVOkl7vozkP6SFX8t/f05u5lxymt7s0NRVUwxY/WJLhQTJyrrVsUrtaFR4TqhS6zYzxhqCqoYVy4Ga+8mElhkw1LBeXLGVVHouIS5Jdweu01Ri8wsEBGWymvT42p7uTfKzWI6z4TIepX9lm6eQM6v5qyg0JfMGeqHFhC2JV/csesrA73tAZ706LNSerLfmkbcZes1iEFdvV6s46Hi2g31rq2Se9c6mVZz2AWiJ4VGCY4E7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1yFdEkpMpQ5lU201rU59fQVFsvo8aIlgnZWnVQmla6o=;
 b=u+NGkuv8pf0th1ziUhtB6HVEYYVvCTofrDW5jHIj6SEN+t44V/46WdIFQ/B8Nr2M8TjJsqZ6xh9g0AlJ/ruIZQx4b4Wg+oXVZ9hadTxJX1UvsOl3G24JHOVgbfWVZNQgSst0yDDlz6oKuHy+kG3ppWOzys7/ZouKyF5xYigfMbs=
Received: from MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10)
 by DM6PR12MB3706.namprd12.prod.outlook.com (2603:10b6:5:1cc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 07:01:57 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::22) by MN2PR16CA0041.outlook.office365.com
 (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Thu, 23 Apr 2020 07:01:56 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Thu, 23 Apr 2020 07:01:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:53 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 Apr
 2020 02:01:53 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 23 Apr 2020 02:01:52 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: provide RREG32_SOC15_NO_KIQ,
 will be used later
Date: Thu, 23 Apr 2020 15:01:42 +0800
Message-ID: <1587625306-20704-4-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
References: <1587625306-20704-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(428003)(46966005)(356005)(4744005)(8676002)(82740400003)(5660300002)(316002)(7696005)(81156014)(26005)(8936002)(81166007)(36756003)(2906002)(478600001)(47076004)(4326008)(2616005)(70586007)(6666004)(82310400002)(70206006)(426003)(86362001)(186003)(336012)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6a7410a-40f7-4e04-7349-08d7e75435fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3706:
X-Microsoft-Antispam-PRVS: <DM6PR12MB370628F24AD0946E7A972B5A84D30@DM6PR12MB3706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 03827AF76E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDBA+8Mxl3B7oTuy0swE6zrL0IELG5dBTqOKbJqo1Fa+TkMCQFiVHD/6UyJSvHXpVyzNAaAoUlmpsz8JkKu5m5IIt1UsmlofhTbEOFPX8dZTHmYAzaQMFWjpmB2xTZugQGlTScFnGB0mvE63XjdZ5hCJ5MKhIiUp+nvt06JFWWkwvZ3I+0JO4UnbnU6JhFa4/W0jd8i99jTq/LD2/ajaJWzNJw85aasWbKyPu02wbZJ5kFoKdby2Zin4a04E5tdragSuohWRqnPOEg8MSn9qWhBrYj9QZ1T5HzAcvObix1OPGqS4VuEioSPacNg6RJxQOE+u0ttKsD78DiIGIo42ZIqMK2Eng9avFBmG4WGBE6FjWmL2TlhZy+g1Rc+sXElysfl1TBeUZAo2y59IuZZ6CWN3m2frQhBkyqlfg4sSoKRla6xVZF5tz0xDyt2jwB0j68mrPpSa7FJxmHUosqVpxXX0H7l8qymZBSUrLik7vCQYI4td0ng7FQnwghT/HsYOmgj/8Tdrccz7ReZy9ISEWQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2020 07:01:56.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a7410a-40f7-4e04-7349-08d7e75435fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3706
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c893c64..56d02aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -35,6 +35,9 @@
 #define RREG32_SOC15(ip, inst, reg) \
 	RREG32(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
+#define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
+	RREG32_NO_KIQ(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
+
 #define RREG32_SOC15_OFFSET(ip, inst, reg, offset) \
 	RREG32((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) + offset)
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
