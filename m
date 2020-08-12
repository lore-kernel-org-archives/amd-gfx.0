Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA72C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 09:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060E2206C3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 09:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SLEvEwF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060E2206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3136E2B4;
	Wed, 12 Aug 2020 09:28:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98D766E2B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 09:28:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsFjjrQMOeUG80nicJpcMijSyXofdphfXJL2w5LdioS5Sm87dfAH6xmjEjiWTHzMQz8MPcGlgE2zqpbOJfqGt31DaD/psGwesU6gRjsO3uS1a4OBO5uraNm3vrKEsTfNiMtQb0nXcp8/csJg6+PUkLy8oMRFpYP9klrTqGLO3tWpOTVzzLIJGlyNmHJ6+jcwM0HmazbLUOJZioR9o+4orW/RU/GPl1e16bC6YmFoJqzgkRfhuFXiLTL8XMIrJrARj1XYKFZH7IeIqT2at+YTzxP/7KHRynU4N269+TajsEwYi5OQVF0fVVrGOL7uJVebmKc/2Fq4/fC5Wjeke2EznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS0a27Eo72Hs+DNdorBJ0cnQuOwdKD2SkSiMNwBTPgo=;
 b=chGvNbzvw6xxsnncd1DeNpGoc87InEhEY27wvVvQaML9e2fb+z3BSdylzgvdu2y/rZEVPDefJMsVnHQgW3EKhs3AEuwBVRYIvjQW0Amr07Q9oMQYaYj3aOwQKj1wAEnwFYeEg72piUtJWqJa2m8y5uSLwzO+D6BTL3VKwVDrb0gk4M+5dHegE5fTLOmtxu6Km+e3UeUNWbxsDZfL463PLLwcUrgsL7CO49XM4f4qhVqHdDMQYEl7nUcIEUe7+UCbXwR/ztZ9YJEqeESQCOuo/Y65Mwhoywh2c3w0JS0n4BA7Pm4gfvfIG/yg1zVhz6HSAMfdcRB5ykCTyTJ2fIWRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS0a27Eo72Hs+DNdorBJ0cnQuOwdKD2SkSiMNwBTPgo=;
 b=SLEvEwF2XhnZ/3HSyx6eBt38mEjNpoc7XNF+FGZO0ccRRvcCFYSleT6Mq198ZAyGqbiOXIT9pbmLMlvPi/BrBXBn5+YTod3ZvPi6EROPTbzIVO2wCR/EkS/ealXnC6wiQOs8+YfHppG7sEDngkLAKhDw6lAOv1Q586v0Us66Gms=
Received: from BN6PR14CA0004.namprd14.prod.outlook.com (2603:10b6:404:79::14)
 by DM6PR12MB2730.namprd12.prod.outlook.com (2603:10b6:5:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Wed, 12 Aug
 2020 09:23:54 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::76) by BN6PR14CA0004.outlook.office365.com
 (2603:10b6:404:79::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Wed, 12 Aug 2020 09:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 12 Aug 2020 09:23:54 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 04:23:53 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 12 Aug 2020 04:23:53 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Limit the error info print rate
Date: Wed, 12 Aug 2020 17:23:45 +0800
Message-ID: <20200812092345.439249-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ae4e99-9f0b-48ef-1f89-08d83ea16ee4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2730:
X-Microsoft-Antispam-PRVS: <DM6PR12MB27302C25D8832E33A3CC0C788F420@DM6PR12MB2730.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oV4RwNrOHYn55gX+pC7+4Gfur/+SNIJztFuhcRJHU1QQqVj+z4gqLVK6dyDsIbKNeHo+SXfKaKs9nkzqmmCFd1Nnyp8CVvugUvVfTQfPS1AZNsyQKPA6QmgIqFpVv7GJXB4/tQOIo9hr22eFayU37H3u0Ykn2ALnh+BcfNlRnfS4w7ffah27NKgNqXk44znqB7/TepN3ya2nF/MDp8FrARdBwZgiblwkTM9BzhtWqhfQMXkc6N6zqp9uoCKzGvmOqv2Gm0Ue8F2u6OlJNsgaZx4m+yM2GufxAHdLAqMs/4EhqP8sHwLYd8MVIst3EdpLILIjGKt03j1YyC74n6rLcFkjsJun+AdwGY0WNZfwR3g/+yAcevIRkUtVcslS6ybF5zSIc2oCup1w+/oUn3Au/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(82740400003)(6916009)(316002)(2906002)(26005)(7696005)(478600001)(336012)(426003)(2616005)(186003)(70586007)(1076003)(47076004)(5660300002)(81166007)(4326008)(4744005)(83380400001)(356005)(6666004)(8676002)(8936002)(82310400002)(70206006)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 09:23:54.3596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ae4e99-9f0b-48ef-1f89-08d83ea16ee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2730
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
Cc: jqdeng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jqdeng <Emily.Deng@amd.com>

Use function printk_ratelimit to limit the print rate.

Signed-off-by: jqdeng <Emily.Deng@amd.com>
Change-Id: Ief05debe30d975cbcf88e473c9f486d70b5a202c
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a94b3f862fc2..727b909b4b9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1296,7 +1296,8 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_parser_init(&parser, data);
 	if (r) {
-		DRM_ERROR("Failed to initialize parser %d!\n", r);
+		if (printk_ratelimit())
+			DRM_ERROR("Failed to initialize parser %d!\n", r);
 		goto out;
 	}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
