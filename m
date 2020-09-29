Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0180DC4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 04:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F5E207F7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 04:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pplO13JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F5E207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01CDE89C08;
	Tue, 29 Sep 2020 04:55:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4CB89C08
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 04:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3P6eOtfG9DF63qpH9PEM/a7y2CGZOPEMz9iTp0brOcrtpylIXcaXw1UBm0ki4vXviAzqi89hg1sjSx5H6ppuJhJTpk3Zka8/vYBFTkWf6lg5En+BZAuQerQcvgx/GRCmo3qNvX21igkGnSPQchymXSNfKU/zvykQAdrHIIv8ydNw1VUSUZwahYCeX92wD1OEFchNeO0ykx3FoLRLUiX1k/YWGv5We9D50d919QaveBHG7E6/L/kYo0SbI2d4h4eNONEJ4ZyblFeo8jx5MXPj/pPZGroQaxjBGrQ4XOKJbmARnkQhiPPZXG2lN6OIWPc5nyO98REDLUKITcYEM8T+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWnn3vlsYDq9tptCavPMqYBQnZWd3Go96qn4mUn83bI=;
 b=cwVFO16qZ3yhQ4Kx4Qii31sp6KOtJY0TKLJTjhoT2yI37lfdyqxBAXL7+mq04gg87XvUAnykRxyEXz4DIDYQNCCqwCiCuweUmjzRXASSWCNrQf1M/1el6bmAAXH1XnzOG0rq1SXMSWzHWBIbZCv368RQCtmQxcHrXMLf60LF050Wq4Og201h2fGBwgtEZ0NpZKemUpXHsRU2yh3o/UnZ4g5RFOMq+S7xb9gwKZ46hn0S+OC4sXQDrc7b79r0w1wXqGeNoaFZ9/nmiAqreP0uXRpqtqZxPHurih4BHl4cQdS7U8XfdnyZ1cGO2hU9yLYaL7nHrT9bIAxyCNQrwuej4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWnn3vlsYDq9tptCavPMqYBQnZWd3Go96qn4mUn83bI=;
 b=pplO13JCr5LSVTacakQyWvyhSb0pYr2qpTh8reVvPMcJGaioRSuiKuxPoF//fX6vkTFEL+b+JMA778pROZ3k1/MF3dRlzuqtx3NpL0fveWYCfQKOmKhjaf40OSH0jNl6yaFK44hyhAURgOrhtdvPtiGAa5cb/Tk6cFIRLfflK9E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0182.namprd12.prod.outlook.com (2603:10b6:910:18::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Tue, 29 Sep
 2020 04:55:22 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 04:55:22 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH 1/2] drm/amdgpu: fix incorrect comment
Date: Tue, 29 Sep 2020 12:55:01 +0800
Message-Id: <20200929045501.5810-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0173.apcprd02.prod.outlook.com (2603:1096:201:1f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Tue, 29 Sep 2020 04:55:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa8427cb-6edb-415f-43c3-08d86433decb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018255D9ADC623BA97F9919AF1320@CY4PR1201MB0182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FFIjX/DFHqfYcxOVHQvHijsSkfJY8JfCKqVYEu1Y/LVlLZxvun9FLYwGYDxOIZCziK36UUF24qxlKngEP/7KdqnkAbHP9fjAbXwDkfO+gpak17GbyKUQx3RAZKWpZsJE0Vz1VDhY4rG01GY2dL59psOmJhWOB13FtZiJLA0rwUrm0qahlrwsL6AE2x7pfzIRyy+OUxbcKSXBHGTQrpGSLZYSMWTDF1Pv0L+PO8eSKaBqwa3/L8xASOsBYVuyt65BaaDo1qZZaw+dmx8uYttAPuL3i5uDho3ttqxmnN6NYs+8ia9zcv3s0ubcvQmCwgH9K/fbToNTqgLooWRrMe7YLHht8NhDznzbA6uLcAg4CQlALqado7yfV28TIRfeg+Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(86362001)(8936002)(4326008)(26005)(6486002)(956004)(6666004)(2616005)(4744005)(5660300002)(66476007)(36756003)(66556008)(66946007)(44832011)(2906002)(1076003)(186003)(16526019)(83380400001)(478600001)(316002)(8676002)(52116002)(6636002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MBYK0oYo83reNH//RxG837FOG+Bi/r7GxviGD5jR5G+y8Rjyk7H9KXW8I5EWsRbiu7L4TLz0mVm0+b3kocXr4R0oF/0yk81OyuzdJUatR+Ye/4P2jmo02eKFgprTNpmjn9DDlOzFrDh2KsYwd1WFGVDJFfPp+erwQZS2luF/cgnNrKeFibiTXFqMcxaP19D9cgrbhbWU118z6pw8NgGw1zYQaYZq0fEKd6FhZ0F+RKsmMOwjnXqFNojQUuIIyRLAFmot1uXpkwUk3x6ERzLNpeVOy6dXcY84wRH5bgcI8P2K6tuMyPYRQdYpQB6f4JAtuwvpCNnvR1YxiI9HdWydw8FGNsGrfEZNUQxrYWhqz8mdXIQu3Ei5evR1zY7TunkhEVj703ImxGFYnaEpCIQeQxq4icwyIz2qaABPOGklOW11i3EeKAuNS3VhHqQy8JnS5P75cKYuDoXfcPA7S7HF1achHxEWjIed0vBWvZkPHI6e9JCwfENOoV56EOwHll9KCFY/RsxUrOGYnDo2aZWN9MO5L9h/vX166G1QHgKwWTpa1Rax+zRRXlK7eGQQIJqks88vD9vXJDMB1w7bw1hJHKIF1MsncpVwJ2tS7p1VC7+3/eOZeYdVSrX2f6O7Bw7wMxKT3mRw+/Q3feosQDghrw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8427cb-6edb-415f-43c3-08d86433decb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 04:55:22.1505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQbt3NdJhaqhsCOaKYQHe6PldZ2b10TKVq8bfTZ69tSVTAZhcRRMavQv2dKZFMwP3BIhv1A5JHQ9YKJX1+DKLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It should be one copy-paste typo.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index f29a8611d69b..1308d976d60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -26,4 +26,4 @@
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
 
-#endif  // __AMDGPU_PRODINFO_H__
+#endif  // __AMDGPU_FRU_EEPROM_H__
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
