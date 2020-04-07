Return-Path: <SRS0=Z8oe=5X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C4DC2BA16
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B19A206F7
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2020 08:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3q64oyvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B19A206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F8F6E5CE;
	Tue,  7 Apr 2020 08:14:12 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EA86E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2020 08:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwEEgH9Ri7NHQr5TkTl0uq+IOHLKKvBIFo9m7Ysu9xeyoyn9M5ZAheUj8viBiWmARNvQc0TNaZRdhjQHcEcSJvY6yVA+FIJmb9RcyAmyDvD1sGRm0HtEJX/zZTHcO8wheJnjNE2/kaKPPW18Bokm9pk+qG4T913KVsszKACEIiWk8Wt8VyvE3OTMCWuGJpDIhkbk16OMHRh5CUv/YAyROrJCABenWXHrAKrefRbZ1CW4OD6id6BYB4V9FOq7uC4L7cmw/b+fyby9dgFtCTA+Ae3HVw/zsivxRbi05nDkp5/HrYGHOUNYtZYUo5IDg3Kldwb0EhAE0ly07wc3+eCY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIuInax0m9jgfjRMiHPZM44hLb7a4cGLjGSqCg4ROxg=;
 b=YSvtwMUlkmuSzqdVEtDEevggnPR9zYq2E/N5xZLU/s1Syfj9g2UUFm2zJ3eut8JMQ1433W8LBMarCRAnPqbjm1QdJISE6/6elR86qnl2dB6bmc4FXNEiMuCrsiJ/WYI5c3MDUVFURtBuFmojZYp6DimwGYr20+66SrwQ1r3ef9oCllmPoCauYzrrWDkV6/rUWbp4I5izvp62YNU38SLBnu1Z2AA+EXZsx0mN4pwSJTToZcvSZIE5Kw8+JSRRDj5RltkvdsijRPG43Utx9cb1hzzG33Miqo11ee5HPP88So5jlSfULRbriIEy+1YyirUx+ieGX954LSSv2pqf1rWdLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIuInax0m9jgfjRMiHPZM44hLb7a4cGLjGSqCg4ROxg=;
 b=3q64oyvxC8EuUWefPdfASy6Kn6bmUV10vEmgCIbeLxXZNwxAJe5TU7sk5Ifv1QInuYvjXJAKRTA3B7U2xl76xa3Oq2JD2P2YozZgPtVCx1wQqH9O4Kr+UdK+qVWVMRCHS+hDspr115GC6vtqSr2E9ZyOVpc0e8RzlEF0JQC5X2E=
Received: from MWHPR2201CA0059.namprd22.prod.outlook.com
 (2603:10b6:301:16::33) by MW2PR12MB2537.namprd12.prod.outlook.com
 (2603:10b6:907:6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Tue, 7 Apr
 2020 08:14:09 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::50) by MWHPR2201CA0059.outlook.office365.com
 (2603:10b6:301:16::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Tue, 7 Apr 2020 08:14:09 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Tue, 7 Apr 2020 08:14:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 03:14:08 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 7 Apr 2020
 03:14:08 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 7 Apr 2020 03:14:07 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Date: Tue, 7 Apr 2020 16:14:06 +0800
Message-ID: <1586247246-823-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(428003)(46966005)(26005)(5660300002)(7696005)(8676002)(81156014)(81166006)(478600001)(186003)(47076004)(4744005)(2616005)(36756003)(4326008)(2906002)(70206006)(86362001)(426003)(8936002)(316002)(6916009)(82740400003)(336012)(356004)(70586007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8f6965a-ab75-4ae5-2711-08d7dacba605
X-MS-TrafficTypeDiagnostic: MW2PR12MB2537:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2537AEE9D0F26FDCCCBC8DB9BBC30@MW2PR12MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 036614DD9C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sDMsrJN0VlEB9J6Ye0m+ie8D9FDS7rJN+I97DxHjZCvYBh4H02lhVGF1d+TpwoAXxt3+S37waFaXJyeQR90GBl1RPcuIWbmzx0x82ADwD0Z7aaOgNUpFES3YCXG6IPMGOtsEHpwEnjjFx6NnAnnMblrqmVLmkwoFImtrWW6G1Zk9D1eWJhAVY+Fz2qlJ3+8qoXdXNiiGw5uEdsqdhlvPr5YPYVpG4UIbbP+jX31Dc1yzFqRXOCqNR10VD9fRB/zmXiD/ojrCAOIlEb7q+dvxBUIT7nUaccujrPdLwIJ6EEyTgNHOM7Ur2EvjKS0JBChad4iax4wiQrN2wp9IEd8WHVg12awY9WBMOduwEz6/w4xeQcvYio6Z999RHibt9OtJHW8UO9fnDUKNOwfHVxm8d1YMpn0hfqKw/OKzvd1MxkQxaZvkRCEm5p46ti1wgIGa4ssJCSeSWx8N+5Dp7qpLyA05cee9pzPj9Nn1RnVLZ1D/K3mFck71OL/NdGnPa90lU19oVaRlIfT5uFWnWkHTQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 08:14:09.3217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f6965a-ab75-4ae5-2711-08d7dacba605
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2537
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

[PATCH 2/2]
kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those
allocated memories and get memory leak.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d94eff9..2e1f955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3852,6 +3852,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
