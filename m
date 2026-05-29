Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0030FCD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:38:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE8610FC0A;
	Fri, 29 May 2026 09:38:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tUnFtd47";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E5A10FBE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBPdbR4g+kcoVAogrX/ML2tNP+5Fu/dyeWsKe5E5O8Jf8t223yw/QswwMW1SX+TedWFTqqv0boMk2G8Ej1YLEWVNSJlEfYi7R7ghQ7wrzLJG3m0FX0VPLQCKWsTrUidnjle39HgOkqqk8qn9Kvu1aOowvej54x0vVViyD8Dc5tNU6RTBVwrDTXVBtYEEsyUZ17MEqe/h2jp7Gt7o2rYNZroqNT0/epvtA3xlvx62b/62Cv+XYAxYgppCc/E4MIxoPq7LnI0rUMSHdViOJYKFNqb7Rw+oqXOqWEH7GcwvenRD3Vw2KnFJq37khwViegEf4UwpoP8okRTP/SxxAAz8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFqhx1RDR4VNZ0fu2QrirEuUDT3k1qQv/JHdah4rz/4=;
 b=SIiHuQrJjFfLR4msONoQrmQ2UlNT8sUq9OrAVmfmG5MISuGzZ3gqB0XkWx8PZEaFB+1k8YEoO6IBQjryB9uyW9/Zfv1IL5oWGdN/Ut5wY6cqZp/1vng8s4p62pRw5f1TAfpcBF1OhVMN7wldfOhFqMZfUItz9TvO6qPTWDm45UHw0aat9Q5d1ZQ6ywF9uSnfVq2pda3shLXpoRJhcPTl46Mh2YDGNZj/OtoPCvYqBDoGg6gwclEbZ/j/Oy2dX6fpqDuiodsdW9Y6l1DKNE5XpQyU6ioDCoOtkSSEdSbCaFegY4H/FIh6vlt6i7Hb1ijr4GrKvIFmrvEhRN2h8Ol20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFqhx1RDR4VNZ0fu2QrirEuUDT3k1qQv/JHdah4rz/4=;
 b=tUnFtd47B0SuNuF3xMvE4pLS1IR2YbEQTuOeCoDwDqS26/a/4jc/Dm3oNf+IsNZfBOQcwTJjkSPdjeYoWlfAjhEPX1v3aNHEMuWKsA6kWweyFc3KZ5L/uIXVq7dcahhJIf+Glz9H8DYdtl/+rctt8dZyr2M3LbXR0cc69ySX+js=
Received: from DM6PR02CA0155.namprd02.prod.outlook.com (2603:10b6:5:332::22)
 by LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 09:38:41 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:332:cafe::1f) by DM6PR02CA0155.outlook.office365.com
 (2603:10b6:5:332::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:38:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:38:38 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Use strscpy in profile mode parsing
Date: Fri, 29 May 2026 15:08:19 +0530
Message-ID: <20260529093820.1134317-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|LV2PR12MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: cf067f86-cc19-4549-90a8-08debd661121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Oox/zRIHuxC1Cac/F21LTGKfCMSfu8X7nHIAWVZxdklM8FUjYV7vxtTTHhkjNtgdt8FSrAEGq+4ppC7CovOcKGXvaq86J2gyY0EQc2Gy/5yMz3rxHyk0K5hoX4YMBFkwN1Tx7YnF4VwynufZyLNq7QMkpUAN6uPveZlH7Uwa618yk4Shhy5PpaxhuM9zb9SqC4FK9kZJvIFJvsqIxS6lxJWBWigUKzRMtDjkmaswsKvsC70w7nhtAtJ84oghc3z+2Den4jzuuiYOHUxxTRWIeAfnPtlarQPejB1DBvInSDHx4nTFDOIbVvUhWpZ/fwA9ansxp5OAV631aNPRi2zG9Muiyeif+zEW/BDvspIAvvV1uKl3DUkUhZSHeCHkyjsrxlOHxvVKp7WyDV2TS1Na4QIoG8l8puYmSG83M6Z4OT6e/0PhFO2D+nroFhAykFYfrP4HadA/YKz/ZC4lrGDzpkcZQTCFB2uVJ9es4wlF0v4LQaeTdWJmx+eDuwi6cs+2IO7uSwrPVadAA21+YIur4DeLI+UyWFsJ7c925A6jMpkPqkMGXCyPEWCedQyi6u9yZT/M/H3mjWdr98WqC19Qg1vNyT/+cOJLYZu/zAXT/UGzQMSCvywCnBs1lg/jyvvEp5ptU7/DF0Wu1eWUt3ffkqXYLILvLghCoqq8Aa92cZpx/aJqfjuzaGRAG5ZVfihOrk6IkZFP7SbB/RmgAZHymT/gzoJ+EraO1/r6OqRDJQI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QCJBKmgsXJu8jbvXeDMqpTrSFI44oRa2spOxoLrNujCaxOGnby9onebyZolklGebMq/EgXW09Y8J4lknApCUtFD+j7pB+QCi6H/RNsB2l8iiCGzS3B3Vn/mkrrmkWr7XI2xT1G5KeSC7Gr6cZ4PVzhv22DR0pzr0eBImqyi1fNuusfTxz4XkPBB4C/wTy7RSpTGl6ojxB2u9vObhELemfp5Msha5Hj5d0kSCTMAn5AFDWEZ23tZP9S/NMYxkOx0tins0qMRRNPMfRox9a/vDCKMQ7hMl6xyH5E+z5+0mtCeRugpl6l335hWmq+MdKbXeQ8hwcx6t2NonGQKO07IqvZ6eNBnMee9MlLGNyuVq1UO1D4qCKnjOXY4Ezj4dJu2q0iihyVDCvu3+ij/irkfyWZUmvt7V+GrEbaNeTYpx412sKsBdWbx7VH1BbFNaFhGT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:38:40.4364 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf067f86-cc19-4549-90a8-08debd661121
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5990
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use strscpy to copy the buffer which makes it explicit that a valid NULL
terminated string gets copied. Also, make it explicit that the source
buffer can be copied safely to the temporary buffer by checking against
its size.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 450ecb188aed..ebe0b320ca4f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1375,26 +1375,22 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
 	long parameter[64];
 	char *sub_str, buf_cpy[128];
 	char *tmp_str;
-	uint32_t i = 0;
 	char tmp[2];
 	long int profile_mode = 0;
 	const char delimiter[3] = {' ', '\n', '\0'};
-	size_t len;
 
-	tmp[0] = *(buf);
+	tmp[0] = *(buf++);
 	tmp[1] = '\0';
 	ret = kstrtol(tmp, 0, &profile_mode);
 	if (ret)
 		return -EINVAL;
 
 	if (profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (count < 2 || count > 127)
+		if (count < 2 || count > sizeof(buf_cpy))
 			return -EINVAL;
-		while (isspace(*++buf))
-			i++;
-		len = count - 1 - i;
-		memcpy(buf_cpy, buf, len);
-		buf_cpy[len] = '\0';
+		while (isspace(*buf))
+			buf++;
+		strscpy(buf_cpy, buf, sizeof(buf_cpy));
 		tmp_str = buf_cpy;
 		while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {
 			if (strlen(sub_str) == 0)
-- 
2.49.0

