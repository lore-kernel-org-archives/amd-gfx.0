Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB3C32771
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5382F214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cja9gPd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5382F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179B76EC49;
	Tue, 28 Jan 2020 01:30:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC966EC46
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJriH9MM7pojtISG4I/PHxt+wbIKDR/qjI9bgjoChT0CFtBOKgDonLRBVdmjNMcIaT2YiuZQE84ecLsF1XY00Gtcgqjj0WQAnXfud5U+mrLSF4RHjQTr7T8ohc1EAt5XwWSOtive5yZOBsN30+LaQAFlVoVg00KMrAFF/3MGSYybaNG8irmdDLxKLp6NuxOm/JQNMAI6tUqT75zSNdH37fnKO3MW0FRIp/qv6+mOVqzkV8vxrRM+37+HtLEKXTy96//bhbd6o1XyLF6LJkbPhAVc5LieAqQfP67VD5RlSdxL2Y/KwTGAVqnTB9knd+Tdfw4/pSwv8zdb0OaIytfgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrIuCKuRw0j2hTJoKouZDxDqw2F/W4o6kJe8fCjCAGs=;
 b=Jvd6EcDc2RPsWZUIvpPgEtpxlM33uSf860qZCEcOLgHsKQMZrKqEteNXSJmJUPwaHW/OLnOYhpb99WU4CAHELXNM1UrAlcy6mSnNEYhanRhiShuX4GUFO14XFtjNBj+fsty20k0SNnb7r0FOYzJRFYouKIuBktuXFDC4/fzfy5cIiIRkTstq8JpkFAkGGHs9Md+3BK3U6LHGIeJhXRf1SbBB4qJUFvjgESVv9SsgijGUwAYPPHoZ2W+/VGcgcNaP3wxRHe+hzgxR1hboAQiwaouNS3rvKVInapzVT3rjJC7TCUaDX2iILYrLUqkAWSeb8OfiQlotuwgU48j+q/mWVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrIuCKuRw0j2hTJoKouZDxDqw2F/W4o6kJe8fCjCAGs=;
 b=cja9gPd5iugMYMY8AO3+DKSjmUqy9v17iU6XoSgGGqXz2tZWweVC1ynr4UxWfpy8HdxLJMu0iWXp1kZlJv4eKI+74HeobrKxL4UPvtnlJRIm2fk2c7Clla1dLlIbJxadZBZR6ZzHaPlHyZ96acrUlxocSA6bjwvAkHY/+l7PXSU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2592.namprd12.prod.outlook.com (52.132.194.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:30:05 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:30:05 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 2/5] drm/amdgpu: Fix missing error check in suspend
Date: Mon, 27 Jan 2020 20:29:20 -0500
Message-Id: <20200128012923.25536-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:30:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0815ef3a-bdad-4235-c137-08d7a3919a95
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:|SN1PR12MB2592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2592456509F44DDD7907433AFE0A0@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(7696005)(52116002)(66946007)(4326008)(15650500001)(478600001)(6486002)(8936002)(44832011)(2906002)(5660300002)(6666004)(956004)(2616005)(26005)(36756003)(86362001)(81166006)(16526019)(1076003)(6916009)(66556008)(81156014)(8676002)(186003)(316002)(66476007)(4744005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2592;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4oECJKbsjtR3H/Dyfw3ou70Iw4gLhy3gNhSYpGNQy9a/poNtjVXqy+jMTJIaME3GBOrbneZSxC+5hFZ7ekf8D6TL0G03pH2DRsL1sjEs3eE92migdva1m77byJT3vNBKgctlvzWYIl3tfeeWnN0TAnARb3/CSLRtwRcrfRjQO6Zqa3Y/XAsqjs6ho8TZA8OannsQYPxtS/i0ZLs5bVyt738OoYY6iAiUXx2q0MiLXcjjDM/tRI58qnplnqQMjK6wdyAQ+RC/07Zrs6VUAKiSna209lzXwI6sL9p+5JoC6WBeJN5hvV4aNgVE0Ha9FEnKcljMPoKG6JGdpKQgGFY+yTX6jlguZVi8Nl8224nR5b0JNUSj8Fj944r8O57WQJaO46jOPnnvu7whYFlh3umdK32egUKqR3FpogfEtTjgIsD/Jh1kEZM0C06dIU3tsMy
X-MS-Exchange-AntiSpam-MessageData: bW0j4srmkAGiv81TJn1WjtGeVp/uq9vzkMyJPCc1pq/AFo02PH9s+P+GTcM8KYyg8lW9vjhzY1EwYS9czlAyidb15kzJcig/Zwh8pMQnH6iVsyCbnrgp3gDYHrwT+YfeJ+u19m1dW1/4RHcFG6dyDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0815ef3a-bdad-4235-c137-08d7a3919a95
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:30:05.7324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdUw7PTBcg8BzpI0I+0xuFKUHk6bXTQjhu3eooaXc62UKLb5xOx/BHdo2MN7uQdv4gWhU+j7fWgqdhALWMup7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_device_suspend might return an error code since it can be called
from both runtime and system suspend flows. Add the missing return code
in case of a failure.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 137e76f0e3db..71466df6dff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1236,6 +1236,9 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
+	if (ret)
+		return ret;
+
 	if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
