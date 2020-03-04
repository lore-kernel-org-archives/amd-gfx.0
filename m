Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B5C3F2CE
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 18:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329A721556
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hfMNMBsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329A721556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF26389C1F;
	Wed,  4 Mar 2020 18:08:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB8989C1F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 18:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhxTxtx7g27pycnRMm25wqhvEohxx0PQsIaseGCIZ7zKIeVwhEE8SGWM79K2D2+H1htfoom5m3FBGIlhyy1/rG7YpEds+cdjK9V1lXr1LBfxRE4aKDkx1810TK2yFPh9W4E+EceYdOY0HsVYwXO+nlDBvDITV5g9zIRA2o9WaY7rO5vufcpG8pjz/4h3xF6PcLuqS2yaRSV0psDSJ9RRJiX9b+DbZA9QdsjRX4uK/PFS2bLvMiMbb2n7LBiM8NZ1HHYzTH/swiZhdeuDwaigM5C3kk3EnFbVfk1MWh7/kGcbuaAtF4gK3qG/5zqbur4+iT2tWQFcR21M8mdLD57ZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIDDxI39RpwYRRWLEVsBhHaaYf0GJZX7YnJS2GnuKaQ=;
 b=YnnKYh2ioGh8orlkp9hWOOVqoYpkzc8rgfqNw+qjy4fh1UC3vFSE5QPnMPUQ7qRg6YfDTliM9RMf3Ozf+XtsFvmcj1H8+nlMKkhI6Hc57ntpRtd3PfbJ3FM9yvsXe1CsndCVF8h9TDmpYTUFG4ptycbjoLdjk/anjcnxMe/Mn0bJwUVTzPpFRIHX+uFzpJ1RtPNEba6hCBPn3rqERqB3fqWM7/nMKTPymFZ1POheGMsdu/oahMgxoxkxYFKlRvJb2Opuh61dyq1lJgdy68QGV6PWMynvEinJSDfpudqB08T12r02g1LGs3+QmM8PvQar/TtFslsNTqOckyki+Sc8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIDDxI39RpwYRRWLEVsBhHaaYf0GJZX7YnJS2GnuKaQ=;
 b=hfMNMBsTYUBuX3TwWFC/e2g/CSBL1N33PWZs0GFGBrg21VslWOO3k0kn/4qMYEB8CdsOtIpzYt5zGfVDMsXAi603iiwYNsbadGqMpOcUpKqMUvyONDfhaKzGNErveNSFqsUYnRX56uHBv8srOTJaubMXDncO9EZkLqvOwDqYL9Q=
Received: from DM5PR21CA0001.namprd21.prod.outlook.com (2603:10b6:3:ac::11) by
 BN6PR12MB1506.namprd12.prod.outlook.com (2603:10b6:405:10::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Wed, 4 Mar 2020 18:08:36 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::de) by DM5PR21CA0001.outlook.office365.com
 (2603:10b6:3:ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.5 via Frontend
 Transport; Wed, 4 Mar 2020 18:08:35 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2793.11 via Frontend Transport; Wed, 4 Mar 2020 18:08:35 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 4 Mar 2020
 12:08:34 -0600
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 4 Mar 2020 12:08:34 -0600
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Wrap clflush_cache_range with x86 ifdef
Date: Wed, 4 Mar 2020 13:08:33 -0500
Message-ID: <1583345313-23137-1-git-send-email-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(428003)(199004)(189003)(7696005)(81166006)(81156014)(8936002)(8676002)(4326008)(426003)(5660300002)(4744005)(54906003)(316002)(2906002)(6916009)(478600001)(44832011)(26005)(70586007)(36756003)(2616005)(186003)(86362001)(70206006)(356004)(336012);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1506; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db09cb09-3829-4a98-ce1c-08d7c0670e8f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1506:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15060C24CD073BB102A8F199EAE50@BN6PR12MB1506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0332AACBC3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zV4USIymJCPsRd4+hxe0rR1wApeUgUPYpRKVDY8q8JjSAFPN7SP28rPSFiDQq8I7RHnhFz0+AbrolGmmXY6KMSoVsoQsX/IEj/youvXJQON2aJHg2XavFTflFV5tYDgua9gh9UaistfvuDbW3iynaufG7E70ZlZvXH1gvx9GcDNM17UwZbXNQIW7WqtZHnljKYIWmILPrzoYzkLBNWHdsl5JtZcQUsJSqEMzFXtr0Cxx14h14JSvQ354EjHTMJAXW6BC0q3n9MJc4AzlgHrSsxoYbyAnOPEncr7oFgBMOweTgpFNkx4HpN9nK7BoAV1WHZYeY4ojREAHjrWn7E3sYkRKQXOQk9/D42lWWpD0Y9IhgvAszfPpp9HHqA7mgcHEUwfrAZ1Ih9oaNpqjiGgLdnku5lILIvnUN/09pczL1v3IbC8m1vc2Mvtx3Ebkrg10
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2020 18:08:35.3864 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db09cb09-3829-4a98-ce1c-08d7c0670e8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1506
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
Cc: Alexander.Deucher@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid compile errors on other platforms.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cff0fd2..3836acc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1883,8 +1883,15 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 
 	memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
 
-	/*TODO Remove once PSP starts snooping CPU cache */
+	/*
+	 * x86 specific workaround.
+	 * Without it the buffer is invisible in PSP.
+	 *
+	 * TODO Remove once PSP starts snooping CPU cache
+	 */
+#ifdef CONFIG_X86
 	clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
+#endif
 
 	mutex_lock(&adev->psp.mutex);
 	ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
