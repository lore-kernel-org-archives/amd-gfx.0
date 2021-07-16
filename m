Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A0BC636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2226128B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2226128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E5F6E8D9;
	Fri, 16 Jul 2021 01:34:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1896E8D9
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:34:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1Z7YlytfyqtiDZtkEU4t9vwZrPY2zSfi2CVlXOTPITnO/aGk0vkX34a6MrwrdguHYI+wb2sx3Xs/n8sSyn3sX2jIAqSa2ln8yFr/jkoaa15l3xGnkLv6g2gzEOVRvuFDemzWX5Fq8PLdaHUABi4AuG8qvJrNUCXXEKnPoW16T9TI8mN9qNY84hMublf4AH0rcqqqAG5zXvaxAAftwNhBcbzYNAUZW08sSlVorVvydrB0LAAkSUDprEXrKfx2eK68Q8eg2H/G7mZSeO6Ycw4xUIqF8Y9AmLGfVUqJbZzAXYUNXyrvHeFT72cLjCQhlnPiuy1W0neZsz/G6uaDVhKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLW7UnWNw8ZKA4ilTU9JJjNrcQGto2bw+gvBBGGp2CQ=;
 b=dDp+P4F7lFz/N4xseoDVsiu9ePxvR3z7fKI2GJkyCCz9r+dZl5qa81lyNwllblrwcTeV+/qnFCuIGP5iiZRIS7QG7mGnOd/z0UPRID2/YcAgtjgLSwRu86yDArQFLY8a0CtgWMvGLL7gcU3UvYvk24xB6DE5vE8jZ6azEPmuzIa1NZhLXssvpg5ckgkIC/mjaaUS8CLaFHd/XliABBNhgI3Y1YO75WrYYJuexvR7U/LxiQnymxuSTflJyzYvPQaGybvtTiFFf7YZ6zA2b7uPQ+dPhQxrizKCRtbfo5RZmKpvOYLTL8w31v+FlsPCw7dJjqcYQ9VquL9N0+kCsXWIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLW7UnWNw8ZKA4ilTU9JJjNrcQGto2bw+gvBBGGp2CQ=;
 b=Ls7JN4soGdC8pxbX3rgs6VmKQPndOl/jWYhGn8F83QjRT/xNhoIzNOd+dSe56NcGhFnSAcfzm+CgWAYWXCqL26lN9D+U+BrYSfkBtkihoWTHDCP5iynFqGt8SoRiILdkA+zsoyX/6/jEG7J8PtMa4BIAk5CmSNRefLOuMu5yo2E=
Received: from DM6PR07CA0054.namprd07.prod.outlook.com (2603:10b6:5:74::31) by
 DM6PR12MB5568.namprd12.prod.outlook.com (2603:10b6:5:20c::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Fri, 16 Jul 2021 01:34:40 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::16) by DM6PR07CA0054.outlook.office365.com
 (2603:10b6:5:74::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 01:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:34:40 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:34:38 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Change a few function names
Date: Thu, 15 Jul 2021 20:34:30 -0500
Message-ID: <1626399273-21347-3-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
References: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41b44b1-85a7-470f-25b4-08d947f9e185
X-MS-TrafficTypeDiagnostic: DM6PR12MB5568:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5568B464A7FC1DD3718B62C880119@DM6PR12MB5568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRp+htbQ2Gncm10AYahdq5jLFl9RIGlT6BmKpMs6KEgtZ7qFuwR/uvDPcnnXqcrsrzLbhThKf3LbIJ3JFujzaB1alxoAHIcyJsWwR6kTdR/+ox0BKi4g1h/lQzy2FnPbFwEolxxXRn5EsFL8AxNxTlZ/x7JRdaltwvvoWxqzTtR5YSUcFsbBEEL/jqo1OqYmMHg4EaMuAFgviPW5/Lz4LrVLFn1wkaxFQozoLBb5tHcNBrbalfeA9bju3GiwaPwc7JzVgcu2OTYIKMVW/lK1lHJ0opF+lR6AzG69MOlK5qr5z3IGU8jT16eyNAcZStMpfqYb8OTBjghVUY+jRR8DzU4WCDVlr7NjxR4PhdtzvponX73L7/uOQ7BW/Q8GJ+XAaxSX78BQSzHytlhcyrye1doyONd2pV5Y6go1ORTudPJ4uxYCQsK+t1GuSjT+rT7UMA2eqBgSTSdu0CcGe4tZ1jXY8qRarGjsh6QFrMxByg9NIYb/7N5fc0I+mS5qpO3tvkjd3F+chU20xaJTh7/FdwCAx5eFAMN+SmStYHbywADERmXfsnw4chJYDo/L41/6VQP3kaH4vjkURMD8y58kmFCWh3ZwW6YAQIuq8oriTBgL4CvR64vabsmGM8RiC6eHFHlPuRteTMY4Sv95s+tpcEt55qCRBt7S8QRvQO9bHRIhQtd9pZtgqm0O/93mHMwEypkOsr2L7lfV9v1//Vhp9HQ7qaLjDorUbqVD3bdK2iw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(86362001)(36756003)(81166007)(2616005)(82310400003)(54906003)(16526019)(426003)(83380400001)(186003)(316002)(5660300002)(2906002)(478600001)(8936002)(47076005)(7696005)(6916009)(356005)(70206006)(36860700001)(336012)(8676002)(6666004)(26005)(70586007)(82740400003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:34:40.4624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41b44b1-85a7-470f-25b4-08d947f9e185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5568
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Function name "psp_np_fw_load" is not proper as people don't
know _np_fw_ means "non psp firmware". Change the function
name to psp_load_non_psp_fw for better understanding. Same
thing for function psp_execute_np_fw_load.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d9ddb2c..8d1e2b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2351,7 +2351,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct amdgpu_firmware_info *ucode,
 	return ret;
 }
 
-static int psp_execute_np_fw_load(struct psp_context *psp,
+static int psp_execute_non_psp_fw_load(struct psp_context *psp,
 			          struct amdgpu_firmware_info *ucode)
 {
 	int ret = 0;
@@ -2387,7 +2387,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 		}
 	}
 
-	ret = psp_execute_np_fw_load(psp, ucode);
+	ret = psp_execute_non_psp_fw_load(psp, ucode);
 
 	if (ret)
 		DRM_ERROR("PSP load smu failed!\n");
@@ -2442,14 +2442,14 @@ int psp_load_fw_list(struct psp_context *psp,
 	for (i = 0; i < ucode_count; ++i) {
 		ucode = ucode_list[i];
 		psp_print_fw_hdr(psp, ucode);
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 	}
 	return ret;
 }
 
-static int psp_np_fw_load(struct psp_context *psp)
+static int psp_load_non_psp_fw(struct psp_context *psp)
 {
 	int i, ret;
 	struct amdgpu_firmware_info *ucode;
@@ -2488,7 +2488,7 @@ static int psp_np_fw_load(struct psp_context *psp)
 
 		psp_print_fw_hdr(psp, ucode);
 
-		ret = psp_execute_np_fw_load(psp, ucode);
+		ret = psp_execute_non_psp_fw_load(psp, ucode);
 		if (ret)
 			return ret;
 
@@ -2565,7 +2565,7 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2765,7 +2765,7 @@ static int psp_resume(void *handle)
 	if (ret)
 		goto failed;
 
-	ret = psp_np_fw_load(psp);
+	ret = psp_load_non_psp_fw(psp);
 	if (ret)
 		goto failed;
 
@@ -2863,7 +2863,7 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 	ucode.mc_addr = cmd_gpu_addr;
 	ucode.ucode_size = cmd_size;
 
-	return psp_execute_np_fw_load(&adev->psp, &ucode);
+	return psp_execute_non_psp_fw_load(&adev->psp, &ucode);
 }
 
 int psp_ring_cmd_submit(struct psp_context *psp,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
