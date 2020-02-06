Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272FDC35247
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D784920674
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wFOe86le"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784920674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84FAC6F9A0;
	Thu,  6 Feb 2020 02:35:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E27516F9A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCC2/UWrPxTnSYrxzG6emGvUNYX6Hg5bx/H+7d4m1WLmQOIobhpNdmhi2lr3VF233l2U4bBO15qTQ45HQfWAxGFUuYlGQbIEWG8VYUt9vdBCgvGvNhc2p3Wx6vWCa3T91LDmT3ari7uMGw85iixUtLavjq98x2reGoq9nK38gxp1hvrIx860O3Y6gTbXlCxUOa9ihekvL8qQYo+IdbicAkyqVoC4e3Y4mWOvxhz0r0+f6X/CNaHnNVUMHR9KQPrlOwGqRYGHj4/sa86XYn2kRZPWpeWr3gqXupUFrOmyAp0S1lWDyF+AEtuYW2h1HGfDOOsfZ/UZBVYk5fOVm8FBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwWvZ69YHHnFNmbO1bw+utw/HpYR9SOx8ZN9zsCp0NQ=;
 b=IkMYRAAxvKKTaEpHfcjIXOwkBblypKkwpZQVJDcfq8XDPBFmJbbXHYD49ZolQbeHtxKvYqjLQE5nSb/J6klr1pS7NQAfzTDDyt/D5A7l3QYs10lgau3UYBep3GUXSr/7PIMIUyk5oQnI5Wpn7fBUC/UMbar5ol4H1T7z0LV1n3eudPiSgOfbvm3V0XAPbK2WXVGJJObwOv5ZeRJP2BOfeFA2losc15/Mq0WWNOn0TNoyApDPNXDuhwScmvimWtMMuwYUFbGwwumStvrpkONCpaWUr5IjaQQec1ZvHpydIyp9m8crDdXitwBjjQ0s+sfrUcXQXtZPZUOVNe77mC8VCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwWvZ69YHHnFNmbO1bw+utw/HpYR9SOx8ZN9zsCp0NQ=;
 b=wFOe86lehQ/GeRcY4YlFk/OtUqpg7vTaCQRRVs8H5kXCOawC5x0sYvTehTj1rWX9tR76aUfXqgBG6xStNG/5S7WCDhH7+DtTUuNcRXkOU6EeFIT7BhmPOPxhlWk7AEd9t6+238Fp8c3ung/EGAddzy5bpwxX5Ex7BFyk6r20Bgg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4246.namprd12.prod.outlook.com (20.180.6.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 02:35:50 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 02:35:50 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: Use MAX_SDMA_ENGINE_NUM instead of a number
Date: Wed,  5 Feb 2020 21:35:35 -0500
Message-Id: <20200206023536.4417-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206023536.4417-1-Yong.Zhao@amd.com>
References: <20200206023536.4417-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 02:35:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a58d990f-73e5-4775-2bcb-08d7aaad46c3
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:|CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4246B9A59C93545109C9C232F01D0@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(4326008)(6486002)(1076003)(66946007)(6666004)(81166006)(81156014)(8676002)(8936002)(86362001)(36756003)(186003)(16526019)(478600001)(956004)(2616005)(26005)(316002)(5660300002)(66556008)(66476007)(2906002)(52116002)(7696005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4246;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/juAQsUOsmqKfqg/UbLxfUyOfl/i88yc4gw0S+TJxfzP0O/E6BlrgGvna/PDrp3V8QMUxudgiPsYbgeuDrOdVw4DDTeoYDVRnbJdV6JBuVqpwPxK/8boLM7SRG9JggjMGNWKSfIWEv3QR6bWwH2A07qJlileHRkBZmnrhist7riGhxS+O3wOtBmhRLLLgB4lAqS3Ty4Uj9KQ7LRk4jt5dIJZZ8B2m8ciGQqUqrOVqu1LBJga+RycXV1oa96n5s4t8tHAaIGYGjGmEg3YC9U44fY1AekIrG40vM2EvlLVsXrJd8X1j22LPwLHbbOo+eXhH/SITICamFNQg2hMSxK/dwg111YsPpmQiygLl0nknWSK+TYWkQNkBsVcJO7oPQ8Ye0LnHplEX/0f9u7RYsX1ib/6t6SK2D0zbC4mKqwKHRfc2egOB6ByB4NkZC7MLdH
X-MS-Exchange-AntiSpam-MessageData: NaiksBf/JNiTmt1n/DOm/THgCD5H1xucuqGgsjF+FYaZHp2173OOqKHY12MYxMZ3SzW8OgmRQCV47Jv2b+nwBpUQCkNF3D5kP9M8X77ZH/NXdVgNijFJjpKwcPdWkkyEr4dyzAuMRJ837sfc9O8wlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58d990f-73e5-4775-2bcb-08d7aaad46c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 02:35:49.1363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dK/LRQQJ4wHdQnhexGburzMAVMhRCPu+z5OOu7HNsAEBsUvogEN2akfgSMVxpcaD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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

MAX_SDMA_ENGINE_NUM will be used in more than one place.

Change-Id: I99c84086ee62612b373c547a9d29bc4a69e7c72e
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h    | 2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 3fa18003d4d6..9d41d983a40f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -52,7 +52,7 @@ struct amdgpu_doorbell_index {
 	uint32_t userqueue_end;
 	uint32_t gfx_ring0;
 	uint32_t gfx_ring1;
-	uint32_t sdma_engine[8];
+	uint32_t sdma_engine[MAX_SDMA_ENGINE_NUM];
 	uint32_t ih;
 	union {
 		struct {
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 55750890b73f..3709d3603fb0 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -35,6 +35,7 @@
 struct pci_dev;
 
 #define KGD_MAX_QUEUES 128
+#define MAX_SDMA_ENGINE_NUM 8
 
 struct kfd_dev;
 struct kgd_dev;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
