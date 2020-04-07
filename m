Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98213C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C28B2051A
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 06:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IBjwK9E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C28B2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2793E6E39C;
	Tue,  7 Apr 2020 06:11:00 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750040.outbound.protection.outlook.com [40.107.75.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E638A6E39C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 06:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mf/oBJ6hiVFc+hbhGzLzHCwcD31mWupCYx6uWeX8M+go95qpdxNmSL0C9DJNpYv8yI5mlX4DC2XpPHxeCx7ZmJNif3CHTIiE/Rapygc39eo+CBcYeEkovYSg1fyMPUGt/yjO4/CeGd0LmMAsA5Wcd3B5Njjt1NJ41HJfpdP8SVF2yQWSlSlV+5eV1PSah2l8hmWoHQ95WsdQLCtrnDQ8o2+HH6DkXzU717WDXh4zDMlsUvYwYAY3+k/pk8/YnulvcyJPSRZLTPNN93DFs9XlncOjJF+mVGuU7jiUpdeyEkDsgI4AjOIQrQtDbNtsyunkzxYQDssrEXDNLVp21jgjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0OlZ+vyQSLRqpoR/nvBPVyumPxFIbTZ+WYOoR0z73A=;
 b=ODG3L5C9U1KLKJu/9Ckv0GISe/VnjGCZvauMYlb1/RBAU/HanLKA9N8SPN3/XggJXDqZ4DqkjDIw/X7Q0TNOokZ3MtVbo10T1ysL8iE2Y6GvgziUMCt+JttVsXugNq7q3vsrnYmhAa/DpyvRXbNTQL36QNCR1twqLBapoj8DWUI0C66uJ/C9wDk7L4f1xcN5nR5cOUp39OvMS7ZdVJ2n7PyHh4N+SrVEyDm4EmNh+41NTm/AOJczzdripQBJi36GhhOM9qV6WuRJ05Yf77an50VtqnN8z02j6zFt1dLADqoo3tLgrcOCs72La3sYF/lfNl9sqpw85DEgjgzie2R8MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0OlZ+vyQSLRqpoR/nvBPVyumPxFIbTZ+WYOoR0z73A=;
 b=IBjwK9E/QYYhwmr7J+yEfqALPlQnA55hUi7K+3CqK6IF8tHkBiTQUKHAfGe1RxLHjJHJ1pADBHankf1AhTDqQDgGiL6fZ4SyaB1Mm4pABWt+fZvpFcnx3m9lRYQDyRrYTxAeYLY27yBHf2YT5rAOMpPSqg8yhO2o+rsLhuSXi6I=
Received: from DM5PR17CA0060.namprd17.prod.outlook.com (2603:10b6:3:13f::22)
 by BN6PR1201MB0242.namprd12.prod.outlook.com (2603:10b6:405:57::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 06:10:57 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::8a) by DM5PR17CA0060.outlook.office365.com
 (2603:10b6:3:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Tue, 7 Apr 2020 06:10:57 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 06:10:57 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 01:10:55 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 01:10:54 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdkfd Avoid destroy hqd when GPU is on reset
Date: Tue, 7 Apr 2020 14:10:52 +0800
Message-ID: <1586239852-30479-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(428003)(46966005)(5660300002)(7696005)(426003)(8676002)(336012)(82740400003)(86362001)(26005)(47076004)(2616005)(478600001)(70206006)(70586007)(4744005)(186003)(4326008)(81166006)(81156014)(316002)(6916009)(8936002)(356004)(36756003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a33bece8-4278-474b-770e-08d7daba6fe1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0242:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0242E0707CEA35A4190308C0BBC30@BN6PR1201MB0242.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:95;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XHyAjf1mSayyiFR2NlKA4hDF+HCCtMkt62g9Beu+JeQVJH+LsDj1+bNID6hgv0AIsRx53qxUNgsKuQAkQlpynWCE99nPldxC7sUYloUDWlkV1InPQ4OB/y1h3ekC/dsAvc4mjkRLZ4y1ZTxKTcB5gvbpEne6aA3KhNupt3r4GQz3A0Fz2oEteHHBKI6adLMvKCKFmBTdl1JvpnQjIiGQIBMwHOOCEQG7l778hjKg/AAnP9GL6uB6YLqGaQzb+8TC8QRwXlMTi8UfGNw4XXYfbrSm77j00icsp1Rrd/fbR/WKZ+fQ8PlT91qxXIMOaCOKf5RHumfxdWeeovAm95qqs+VW0HfOwBDw58SkcYapi7mc6VYuR6kWiBS5gzeY8d+uFfdaEM3J6La60OUSisr8V0AE43YCpmmTvc7HBqFOPAMYJEwLT7dGWJhS41FbFztlunhzQsYT9AoAv5w0JdnlNiaWCgdYh+OzVQ7rNdOcfxfKccdb0ydOTqpxCEv20WedrvrxqAwWsVSgFLpI3SOKg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 06:10:57.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33bece8-4278-474b-770e-08d7daba6fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0242
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

porting to gfx10 from
commit 1b0bfcff463f390c4032ebe36a4d5fb777c00a4c

Originally, MEC is touched
without GPU initialized first.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 4ec6d0c..691c897 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,6 +543,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
+	if (adev->in_gpu_reset)
+		return -EIO;
+
 #if 0
 	unsigned long flags;
 	int retry;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
