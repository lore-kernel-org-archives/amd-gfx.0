Return-Path: <SRS0=Q5HU=6B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7217C2BB1D
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C1621D82
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2020 06:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PDQSL9fW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C1621D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C626E348;
	Fri, 17 Apr 2020 06:54:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BCE6E343
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2020 06:54:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXfszwYlEQM0OIxr6qkrw0yEo/id0MsvqsxY/hIsUCko8IuX8eLSVYnkVI8L1Yitd16XwH99CNRYNp4XW67H9HvGg5L/hMZ13x64HG7YIEfsBCktlnS5/PUzSTGZ0TC6NKK5CD4G/2E2l5ry/aOnPL3Oks19sdjNN0t4d0JCj+yXE2yfpy5B92ZRYiQwUrDFxikKkamYDv3+F7JtzoEnIuEa45a799RbLl3y1w6Q5VxCXy5KjGiESxW2EJWaYIwcuYyiLVipGFPSmuUDKBFZnwbf6kkwmvBqbD5dNJ1/KD4iYBAFJhTyMs1WQWA7kUIoFbQKaYukrYplVL5wdbdM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=E4rtlh/E809K9Su/V+PfvHwW7VVULK/khKGdjplSSb8FS3cyymvO3LIv2prjhbWgPUdW30QNOxTYc3D0Qy6KSGNf3Cyl/sV9NqOYpwB5qlcVUe0s1SyJp/eK/SygAFtq7mR/jBmlWqw+fZiuKEP66p9UcJtolPcSl2CUO72HCu1+T7lWDlYiL0+X1NEIvF/ei8nTYHIei1C6NdOlZ/FQotr8akh5N/GLGm6CKTFaQtZk5Yb0NMWITdTX2LwufV05fsnpvIYmIr82yTo+1S+yytxwnk/ue63cmvZ5XPDCvD75czFAbdlUFN5lbJXrONK/6I+hitnYYw1S6eJC0WcP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS5d92X6nMPqhXvhBZVq9NUEKnSMiJNZfBAEztCX9C8=;
 b=PDQSL9fWEJ1mKCUdSylrpEF3FSJwxtasCxVyTuO0MNjGS1rM9+cZawJixqu5efKeJxQcZ6t5ZFrz+OJCo+DUkXWbXh5+IXqJFXnhoDgjGXqKeOQznJDye4qk/AZOZ/f+Fn8auwvBoc6X8vm4oo2sHrJ8Zqgj2kWuGtFH0dpjsbU=
Received: from DM5PR18CA0069.namprd18.prod.outlook.com (2603:10b6:3:22::31) by
 DM5PR12MB2456.namprd12.prod.outlook.com (2603:10b6:4:b4::37) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Fri, 17 Apr 2020 06:54:39 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::25) by DM5PR18CA0069.outlook.office365.com
 (2603:10b6:3:22::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 06:54:39 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 06:54:38 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 01:54:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Apr
 2020 01:54:37 -0500
Received: from jenkins.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Apr 2020 01:54:36 -0500
From: Yuxian Dai <Yuxian.Dai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/powerplay:avoid to show invalid DPM table info
Date: Fri, 17 Apr 2020 14:54:33 +0800
Message-ID: <20200417065433.17944-1-Yuxian.Dai@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(46966005)(356005)(2616005)(70586007)(36756003)(336012)(186003)(86362001)(8936002)(70206006)(316002)(478600001)(426003)(7696005)(6916009)(81166007)(47076004)(4326008)(8676002)(1076003)(5660300002)(4744005)(6666004)(54906003)(2906002)(81156014)(82740400003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83cd581f-c71e-4c8d-fda8-08d7e29c327d
X-MS-TrafficTypeDiagnostic: DM5PR12MB2456:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2456ABC0C1C68789AFEC90E58DD90@DM5PR12MB2456.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: As1vVXUmx44xM+hIwHLuPHY6p4L+q5V+xSRDaMEXy9y/R5Vh3hv4DIqdbfdrnWUHGvUErbRxJBOLBg7vc0sB18jej6Rh+IG5Xb4jFnuHX0Bplk4H73ypgOO/9n5xcs1KbmaByFhbRh/ua/5X+U7f7b2sWxSUCmM5Epv6O7bM0n2/1wsTSqMMUst7yxZHIA62GNDOorNeDxn0TeRato+MuH9xZP0esdnhq2cv3SwKWEkAAUJC01dgZWYe9gtmmDIQkoqPf9nDOwXl0y3Vi9Wh/YK3NCFCWt5QLVFbSgv8svuOdInQaUFPZRevEM54y81tLvsbQMa+pec3xHt+hRGIxzzpIQ5gtOdfIPoAO7zrQ1BO2vYOyADtaJEmjjXTQeP9s7xq0APzFDHMqAMvefzTz3G0/s6Odq6ZegHSkVJoBDHqjbT0kVQwNaGaHPmy1ofOPYAizsDErctdiAXLeoSIpz7MqszNlUI+cQsKh3iEWjpmHhdNWTsJqSl/nXWgM/XYFYtuQZ3mQnYr6prFL/yRJw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 06:54:38.5268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cd581f-c71e-4c8d-fda8-08d7e29c327d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2456
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
Cc: Ray.Huang@amd.com, Yuxian Dai <Yuxian.Dai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for different ASIC support different the number of DPM levels,
we should avoid to show the invalid level value.
v1 -> v2:
	follow the suggestion,clarifiy the description for this
change
Signed-off-by: Yuxian Dai <Yuxian.Dai@amd.com>
Change-Id: I579ef417ddc8acb4a6cf15c60094743a72d9b050
---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 281b7b6cf1a4..e4e7a352d032 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -296,6 +296,8 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 
 	for (i = 0; i < count; i++) {
 		GET_DPM_CUR_FREQ(clk_table, clk_type, i, value);
+		if (!value)
+			continue;
 		size += sprintf(buf + size, "%d: %uMhz %s\n", i, value,
 				cur_value == value ? "*" : "");
 		if (cur_value == value)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
