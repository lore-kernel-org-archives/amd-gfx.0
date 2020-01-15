Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CB1C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1B02081E
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 09:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="si3anSL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1B02081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BD7889581;
	Wed, 15 Jan 2020 09:20:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88CA89581
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYf2egnU0wytcrBAmjTkuDlMXwqEGzXMlvHwE/FEA/U1iXL4Aw+u8y+TnISxybLHZBhvtjhctoI33LWi/YDRa/0rCur1qLBPHhvvfaQr4nKdp7FqI3aOJG+Lf/PPrkmg8Cy+Fk2p+VkM/9OmzvVE3+09Zn6Ti66ZWSEusYpC3KgznilkgxHmzphtmU98oMQNXBCQRqiDJmeoHKGQxfodhC7gEWuTw6LeiAzmjSpSAjlne4uGn4PnvMb3F24qSSRQPr2BcPJHvE/cutsvWEZxQPiSd96afVZ+ueRgcDx3yTR5dtnyYsridPoLCiPnDV+cAxyXPItmsPsCxZdp8rca+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uutB64SDTgv7ZZz05/Az7mgIlYW7BgNv00iHel5U378=;
 b=fA3TRHTQLKd4pZXf8qYt8mKjHaQqZ944OMuNoLGx8cYzcLONB74UIruFqJvF+nHHcQP7EMM7xmnp0b8UmjRH5jkruawklmShI+AC5pfUN2grOq1eyJvtwVElvS6nrVfCa6pftckFh0ZjWAk56+MEHO3toP7Ij5pDZOwBIPUkJU16YJEY2qQboHc8xcUc8UTeegZZ8X3peTpSvXDeYebe/wqKN5mPEjBFTbgTXE973+msLwa1AzzREbTm/j66QD7WagEDhniSDcH//3ZWNLkCJv0ztIMYOnh2cZ0V6an3zD3i4Tl3bC9ABymE/44eaG7sOBCfMXg0AC7Pd3ugpWeVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uutB64SDTgv7ZZz05/Az7mgIlYW7BgNv00iHel5U378=;
 b=si3anSL1DI6cgmdu62rSgmvNF1aO0vmtZTcBMEWyiuzuFRoLL/5/fwwbAySTWTpYDVf9WxdfF7J82aXaI7iG7CBvoxT8btDjYP33i4iXdPMf41P1Wt1QXi/dK4YAcqJxl/ZPU0PCdZCmsYa6euXN1BBB8sP9meWgWoDQO+gfwwI=
Received: from MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29)
 by DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Wed, 15 Jan
 2020 09:20:33 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::201) by MN2PR12CA0016.outlook.office365.com
 (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 15 Jan 2020 09:20:33 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Wed, 15 Jan 2020 09:20:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:20:32 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 Jan
 2020 03:20:32 -0600
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 15 Jan 2020 03:20:30 -0600
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov skip the update of
 SMU_TABLE_ACTIVITY_MONITOR_COEFF
Date: Wed, 15 Jan 2020 17:20:28 +0800
Message-ID: <1579080028-27730-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(136003)(39860400002)(346002)(428003)(199004)(189003)(86362001)(70206006)(5660300002)(70586007)(6916009)(356004)(26005)(36756003)(316002)(426003)(81166006)(81156014)(478600001)(8676002)(336012)(2906002)(2616005)(15650500001)(7696005)(186003)(4326008)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB4124; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eec7e470-86ff-4ce0-03db-08d7999c2c10
X-MS-TrafficTypeDiagnostic: DM6PR12MB4124:
X-Microsoft-Antispam-PRVS: <DM6PR12MB412408F3A10A1E10EE39D93ABB370@DM6PR12MB4124.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-Forefront-PRVS: 02830F0362
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NOCAkzvfpNVm/rEgjbBe7DHYH6J3txSOTzo70WQhEIYHzKQXW/et6bHj+BboWWwcFQTBp3be8Q+3E5IyGGqB1MGJFIwAij5Nb+efnA7tzBbsgrWD3Y0R3CBXdziJa7mtUDaEizYZPuEhut1KTanxdxoH0vHqn4FvCsvNWmidqgmc5DHcBsfZgxmFGb6SRMTMMwWsMvAnfuoC1vFqnY0JZFVG74LCI4ocLNbSPp/91VFxwaehCPQcjOzqqxDIe5wa2p37SEal/umBCewHXpm2cM8JJL2tWLH1abcyp4eSoGwN1tOGbQFI/jCdLfItTypPqAqqTTx/kbbUQM+Qiwte81+pGqJAznWErzthCZ0GOGskfY8Dx/VDOco7mXd/pHamHk7alVVKED6eZ9A7iEHhPOqtEBkdqHcp73i0UY7TdRJkGl75aAuvVhNpGfbl3CV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 09:20:32.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eec7e470-86ff-4ce0-03db-08d7999c2c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

There's no need to dump ACTIVITY_MONITOR_COEFF under VF.
Therefore, Skip the update of SMU_TABLE_ACTIVITY_MONITOR_COEFF
under SRIOV VF.

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 1c15c6f..14ba6aa 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1318,6 +1318,7 @@ static int arcturus_get_power_limit(struct smu_context *smu,
 static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					   char *buf)
 {
+	struct amdgpu_device *adev = smu->adev;
 	DpmActivityMonitorCoeffInt_t activity_monitor;
 	static const char *profile_name[] = {
 					"BOOTUP_DEFAULT",
@@ -1351,7 +1352,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 	if (result)
 		return result;
 
-	if (smu_version >= 0x360d00)
+	if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev))
 		size += sprintf(buf + size, "%16s %s %s %s %s %s %s %s %s %s %s\n",
 			title[0], title[1], title[2], title[3], title[4], title[5],
 			title[6], title[7], title[8], title[9], title[10]);
@@ -1368,7 +1369,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		if (workload_type < 0)
 			continue;
 
-		if (smu_version >= 0x360d00) {
+		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
 			result = smu_update_table(smu,
 						  SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 						  workload_type,
@@ -1383,7 +1384,7 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 		size += sprintf(buf + size, "%2d %14s%s\n",
 			i, profile_name[i], (i == smu->power_profile_mode) ? "*" : " ");
 
-		if (smu_version >= 0x360d00) {
+		if (smu_version >= 0x360d00 && !amdgpu_sriov_vf(adev)) {
 			size += sprintf(buf + size, "%19s %d(%13s) %7d %7d %7d %7d %7d %7d %7d %7d %7d\n",
 				" ",
 				0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
