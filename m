Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FAB4C48BE5
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7BE61059
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 07:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7BE61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5916E580;
	Fri, 11 Jun 2021 07:05:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DFE06EE2E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 07:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6v6dTIBnOuEQtQ+W5YrxgeuPsJ/6SH4Q36J8n5iEmboYS256AEwYbCq/+gl5EjgRzNnOyWHiBKv2OifderlrCEaQcZUjGs2w7NwuKAHSqhVHoIpbdg0+/tp2rXoOxQsx9i46ZzF/F2iD9xX+4tBlInxmwCT1IJPREwDz1D5wRfEW6WIrW831NGsKBJFClIMBbfhvR2KcLIl8d4w3tPy+NAd3NLBz7KKkXn+YeNgIxYPgKJNuoXmFaLFJS2bn/5LsCVZ8VfyxIa+zQlJgEkKtiDSnQ71Lus098RSJ1mSaqmfmhzICBUHcx9aATo5Dt2GzI0NsiqKGLHurXFm0yhclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv5eB/mWjsTvFw/0NuOVBmWvR0UPZod5I5t+hAGZwq8=;
 b=WYMwfas0K26id4IUgTJWB7oNXmV869eyrXEDBSQ5gmdt9eWwnhdYkNENhYC9rRI3l1MT2EXR65QOKzDTCuDOadI1Y4TVlYQwf8i348kKl+Rfuj0MemvNtHbrVygX3015mvGTcILf8YdOLJWVOan2D9iRtQeBcthl3ZhXTY3BS0fPuqVtlpW6Saa+cNoeIR3GwYsYfCGrpV70BqKeLnXLdf8zMaYTDFL8i1AbaH24i+GJBr0xy0sAW1RblbQj+Zk3QE/T6QV4xwYYfC4PKcLY+5eU7o1zB1tSmJgrGcellhjpcJVX/UFzKM5FT8qv/dKJGm8LyJ5vb/rA7k/zPyDV/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv5eB/mWjsTvFw/0NuOVBmWvR0UPZod5I5t+hAGZwq8=;
 b=rNi3yW9/b8qeNj18f3vy99W5NUfEZSpn6hlMZo3h7/M6rNOjir3S5WnVtWK3riM9lAkvdrP6ift846lP1UoQWEv0G6H99qI9Xba7XuzguDUxkjgk9OghyructVMoKYUJgKOwXXfTa3FL45rX//NhSMD6HmLaSBqCnHw8WtSD4GA=
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by BN6PR12MB1169.namprd12.prod.outlook.com (2603:10b6:404:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 07:05:54 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::b5) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Fri, 11 Jun 2021 07:05:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 07:05:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 11 Jun
 2021 02:05:53 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 11 Jun 2021 02:05:52 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/8] drm/amdgpu: enable dynamic GECC support (v2)
Date: Fri, 11 Jun 2021 15:05:42 +0800
Message-ID: <1623395146-2162-4-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
References: <1623395146-2162-1-git-send-email-Hawking.Zhang@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58e6d0d3-4672-4a5c-76e2-08d92ca75abe
X-MS-TrafficTypeDiagnostic: BN6PR12MB1169:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1169CB12AE7D01607B133938FC349@BN6PR12MB1169.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMdS7o/Ce16MnIVgwOYie7G8phOEm/68qkEH6GsH2pPgtOS7WVdkxnfDUIoaQY2QE2K1D4yN1ITJ+ZgoAxsw4y1+FOdHuoC7LnZQYpQkmGfDVQsEVVioNASJR1QHhLbN5k/hXFM6EAa0v4MZTUNDEDrA+QZXe5jnB+4g0RTyQ58QjEOR4ooAs5zY93jYvnP1G2jVuuOURetnmi8TTAHdqOFKfYYyuCFiW1LEWbBzNI+xpqyRYJHDZOY/wKaiEfA8aq9gquP/RB97dsM2Nj29ywfZ5b4C99D+ljFqKOL3K8/0GS2QKEKvb2X9lMiOELcnURdchFUVgY4G+LaVMxwmYgs/8m8TJ/QGuKlqhuuwFKDl025h7ND+g9dmbN9GJJKGUINEzPX6rKiGIRNzAeuV0zfJAUUEZ7jKUy1dTzQfd0+LWjjwfRajDSZE3jB/oXssT/I+KRzlGkuivjjdgeRxc1xNsoyMHfDAlhvywnmYGN2TH4+QC1IokQpVajwqlTIrcDNRPZS4TbftCLDWV5LzJqyaUmTQIV4Io2Drr/FptoFxADW5CWHN8OovEXaidRQIccZmBxMM0z/6GFAI6FZtUoK0cCkMXL+5WJ72/YfwYkPkR8qvgAEONGCD8uh+ax50vNEZVMgW15qz+BNLrEnsPM3mN4hkz9NNOOTUITG6SLDsLBQTDvwBZ0qaens7XydR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(70586007)(426003)(8676002)(70206006)(478600001)(2616005)(4326008)(8936002)(316002)(7696005)(83380400001)(6916009)(336012)(47076005)(36860700001)(82740400003)(6666004)(186003)(356005)(81166007)(26005)(86362001)(5660300002)(36756003)(2906002)(82310400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 07:05:54.2788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e6d0d3-4672-4a5c-76e2-08d92ca75abe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1169
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dynamic GECC allows user to specify GECC enablement
status, which will take effect in next boot cycle.

v2: initialize boot_cfg to 0xFF

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57 ++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d509d52dd235..ab4e89186186 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1220,19 +1220,62 @@ static int psp_ras_terminate(struct psp_context *psp)
 static int psp_ras_initialize(struct psp_context *psp)
 {
 	int ret;
+	uint32_t boot_cfg = 0xFF;
+	struct amdgpu_device *adev = psp->adev;
 
 	/*
 	 * TODO: bypass the initialize in sriov for now
 	 */
-	if (amdgpu_sriov_vf(psp->adev))
+	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (!psp->adev->psp.ta_ras_ucode_size ||
-	    !psp->adev->psp.ta_ras_start_addr) {
-		dev_info(psp->adev->dev, "RAS: optional ras ta ucode is not available\n");
+	if (!adev->psp.ta_ras_ucode_size ||
+	    !adev->psp.ta_ras_start_addr) {
+		dev_info(adev->dev, "RAS: optional ras ta ucode is not available\n");
 		return 0;
 	}
 
+	if (amdgpu_atomfirmware_dynamic_boot_config_supported(adev)) {
+		/* query GECC enablement status from boot config
+		 * boot_cfg: 1: GECC is enabled or 0: GECC is disabled
+		 */
+		ret = psp_boot_config_get(adev, &boot_cfg);
+		if (ret)
+			dev_warn(adev->dev, "PSP get boot config failed\n");
+
+		if (!amdgpu_ras_is_supported(psp->adev, AMDGPU_RAS_BLOCK__UMC)) {
+			if (!boot_cfg) {
+				dev_info(adev->dev, "GECC is disabled\n");
+			} else {
+				/* disable GECC in next boot cycle if ras is
+				 * disabled by module parameter amdgpu_ras_enable
+				 * and/or amdgpu_ras_mask, or boot_config_get call
+				 * is failed
+				 */
+				ret = psp_boot_config_set(adev, 0);
+				if (ret)
+					dev_warn(adev->dev, "PSP set boot config failed\n");
+				else
+					dev_warn(adev->dev, "GECC will be disabled in next boot cycle "
+						 "if set amdgpu_ras_enable and/or amdgpu_ras_mask to 0x0\n");
+			}
+		} else {
+			if (1 == boot_cfg) {
+				dev_info(adev->dev, "GECC is enabled\n");
+			} else {
+				/* enable GECC in next boot cycle if it is disabled
+				 * in boot config, or force enable GECC if failed to
+				 * get boot configuration
+				 */
+				ret = psp_boot_config_set(adev, BOOT_CONFIG_GECC);
+				if (ret)
+					dev_warn(adev->dev, "PSP set boot config failed\n");
+				else
+					dev_warn(adev->dev, "GECC will be enabled in next boot cycle\n");
+			}
+		}
+	}
+
 	if (!psp->ras.ras_initialized) {
 		ret = psp_ras_init_shared_buf(psp);
 		if (ret)
@@ -1956,12 +1999,6 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	if (amdgpu_atomfirmware_dynamic_boot_config_supported(adev)) {
-		ret = psp_boot_config_set(adev, BOOT_CONFIG_GECC);
-		if (ret)
-			dev_warn(adev->dev, "PSP set boot config failed\n");
-	}
-
 	ret = psp_tmr_init(psp);
 	if (ret) {
 		DRM_ERROR("PSP tmr init failed!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
