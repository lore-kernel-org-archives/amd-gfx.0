Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF879C35640
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 06:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B14E208C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 06:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l5sIEIcW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B14E208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A96A46E213;
	Fri, 21 Feb 2020 06:55:31 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BAF26E213
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 06:55:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsklD8nX3lJgt/5jr0GCI4vERq8eHtEd63NK6oZpIaFBg3flXMynHF31RX8DioggGI1jwBGRhbYtLC0jG7QC2mwUGg5cy5MQus6UNOfDe7Y0mlomWSe4vmTyWtz/JWZiN+Evzp0khCoU1+y2Hbyv5X69uYU2GUmZ9i+i2+2JwK8h/F/sXmMPWP6PYKs9tDB8evDmFd0L2csZBn8TDCx9qh+QkmPTBgyhzyDPyN7zXn3vsjqWfYGInhylpxH0O1KLIirreojobOfKVp4uYD26ZikzoEhqzuJOvStVaqc9Y9bsxtkuLeaMtSmKBzblO3y/k2YhLFb6AKnN1Od6aCCqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEfcoBBJufAF+hRPgHjqQhgfm/Kq7h/otq2W/4TXhlg=;
 b=VTWDjJv7RjM2COu0Q6DiGw0dw8vgpBqvtd5ensSboBZqudmFMNMnv6Ytx5I5+d9gd2PkH0NZ6pDpjV2FwRsDfyoRohCzYBLMwq8dC/dQbP0GVmDXP9/WAr4Wfa51kYJDh207BvHd49jOS9AwLu1BdshtMsK83ahR8zBsBufhzpfiWrnImX8qOnf3ajIsD9Y9ek15Z9WwstK6bImwWfC8MaXduyeVe3Ry1tq2CgxTcSGoyFSI/80wJSw6UrxpgKvcfoCf7ovQiaEc+ksVZYDUKd0P/hr3Hbsd2JTEvOxjsslSwMhF2aFKM42AWHDV6F2lOeXBVNtfpvzcJAkVECU/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEfcoBBJufAF+hRPgHjqQhgfm/Kq7h/otq2W/4TXhlg=;
 b=l5sIEIcWowzKvsKNu12sLxat+mFFM0KVDOIqNFobqfZ/lewc14YJQ2qQNRSPZC06+8e+kdhuL5DBaAAs4wNfojKPN7q+IavZVMeuJZfcKG4RjG1qtVdRgdtnh5a4vGW6Ah+VNMR6nOcxBCnnJWeFyXkFpAPHXF+nihq0qkCgntQ=
Received: from BN6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:404:4b::22)
 by BN6PR1201MB0067.namprd12.prod.outlook.com (2603:10b6:405:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Fri, 21 Feb
 2020 06:55:28 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4b:cafe::37) by BN6PR11CA0036.outlook.office365.com
 (2603:10b6:404:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 06:55:28 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2750.18 via Frontend Transport; Fri, 21 Feb 2020 06:55:28 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 21 Feb
 2020 00:55:27 -0600
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 21 Feb 2020 00:55:26 -0600
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix psp ucode not loaded in bare-metal
Date: Fri, 21 Feb 2020 14:55:24 +0800
Message-ID: <1582268124-31292-1-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(136003)(396003)(428003)(199004)(189003)(2616005)(70206006)(8676002)(2906002)(8936002)(70586007)(336012)(81166006)(4326008)(186003)(81156014)(7696005)(356004)(86362001)(6916009)(26005)(5660300002)(316002)(36756003)(4744005)(478600001)(426003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0067; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f3045b4-4fa9-4b3c-b2ac-08d7b69b08d4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0067:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0067A93199748E0BEB1FBB1C84120@BN6PR1201MB0067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0320B28BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WIVxf0D+QbvKVD3sa53pZlel4yrGwrYaDCTZS2g6bgFPKqcK4C5ZI8+3S1oq5N+9l3h8HGgzQ7Axl64T9KBP0We2l9aqHxLSmr88Vg+SKyMGKL6m5ECKHr/cMlHQbl3RB1RlhjMG+A70DxdmRSuLyEpLRllfA8b8xXY4h2jNPsxmivJ8z6m0Sv2WdQB99bjH0J+SnjVynU0oqr1YN+Y4JiJVA3FNo0wNAFgPIqnDt/PJkMa8xEyuHpPqmG4Fnbn3yh8bQywpzPEkv7ABZHRbjiRQ4CTD1FB80pMJO1CXHzY38m00wvGsJT9ZuS6FdzQA93g1YZ5Yq01NFqPesXu/DVfq1sKZbxWGHIqsQ+ZDt6AtVNxH3zs8gnV+XQ1pw4qRAQ6MofVjoeJ0T8DqOZ3CS6BcCDFHXbjjLME8D7kj9CcHznQOOQNKzvU/ZS+qSVac
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 06:55:28.0137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3045b4-4fa9-4b3c-b2ac-08d7b69b08d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0067
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

for bare-metal we alawys need to load sys/sos/kdb

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3494966..51839ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1081,7 +1081,7 @@ static int psp_hw_start(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev) && !adev->in_gpu_reset) {
+	if (!amdgpu_sriov_vf(adev)) {
 		if (psp->kdb_bin_size &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
