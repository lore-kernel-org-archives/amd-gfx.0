Return-Path: <SRS0=P3OX=CR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7CDC433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 08:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9133215A4
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2020 08:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eSrr96O5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9133215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B35D6E195;
	Tue,  8 Sep 2020 08:31:32 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ADCF6E195
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2020 08:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amDLjPRZCkHudjZWW9sHgZDClNdckAYwIxO0787a1mswyCVyLMjwBtITozVR6jQLVvKRSgLdTRNCPcHNF9HlwJK3HR7AW8URCzZJlK3L3S0Carth3V76jiQ4lyPCMe9uOj/E0H5ysBWDioENhksRXR+qu51myAbukXv9swYQmLhXcBrs7/yVy6qbPxrvZeXEpUXRYzB89ig0iJRBpMBPtrQnuLV8szpeneqmDLIcXIZjbJGdhVOpHeNdNQik8Domw/ssyljqblmHYXrP/tSHuQFycKseQTIQVYp00DlzNuoNh2eOaiHl3KJ0TzCAXoCwurejv7tAcRKrQ11glzlx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0LZDYyNzMaZ2ixuxhprC0DrT2aoFbG+m8m7ch8WRyg=;
 b=mFZY2xcsSZV1On9b1wRhsaS5PeFS8met2Kvj+3lcLRq0Vtk7cHLvyqNRQ1bhke1cA4up+EWL74T4YT1LdB3x92mGjT7KcJkktSW8m4DA1DXVIGax4JPLNtFhdGhGBjRbBeW7wdauhODedhTx5Gs496XiNiAQQZcZqrZ4vgzQgkpMvlu7F9DsYKw5QMZPJ86fOb0hrFly4ApPosC9AMBeCvFr3ymIvWriTSv3DRXy3PcxWqL8d+BSEldDke44ZwDeYufSQxHpxqJKDrKL4R3mWtwbpZRwZL9z194f/9Rawe2Q7tgBYpxRgfCHyjwN4mpE9bNCGmQOH4jV+eYGUvASzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0LZDYyNzMaZ2ixuxhprC0DrT2aoFbG+m8m7ch8WRyg=;
 b=eSrr96O5mGiI4rdZhSR6xnL66Pff017KZyzuncrqT7mLTNhNkgKH0YehqN7W1JHq/9OlQ4TYp5L8iEUnjkDWIwJws5GpIJgjkeMiA+823I1MTyT1NBgNOUeg75vqbl7ijv3RsC+LOKou4Kpk40HYk0wKt+yo2c65CresTYGKJzs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31)
 by DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 08:31:29 +0000
Received: from DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::b525:23be:f194:e4c8]) by DM6PR12MB2938.namprd12.prod.outlook.com
 ([fe80::b525:23be:f194:e4c8%3]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 08:31:29 +0000
From: "Changfeng.Zhu" <changfeng.zhu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ray.Huang@amd.com,
	John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: add ta DTM/HDCP print in amdgpu_firmware_info for
 apu
Date: Tue,  8 Sep 2020 16:31:11 +0800
Message-Id: <20200908083111.13901-1-changfeng.zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0206.apcprd02.prod.outlook.com
 (2603:1096:201:20::18) To DM6PR12MB2938.namprd12.prod.outlook.com
 (2603:10b6:5:18a::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR02CA0206.apcprd02.prod.outlook.com (2603:1096:201:20::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 08:31:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 984bfa0e-0d4b-4964-7a2b-08d853d19548
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0201:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02015837A45EB1AF5D5D0E09FD290@DM5PR1201MB0201.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUr0g2V9kSfTtBEbLsfhhte+a07UOblMzbu5P7FYVS3sjT8TqUM3zvgSu0FKyOR4MAFP6kXQ6Qktev1nbTVOsL6cET0xNjP8y0BNs4/awtU1TPQmt68T5o4y6YlE4hrx/PctV9ReNWtgn9LVv2l6mphV3UCV0AfQRyFzDORBnSyttP5FplSLQUigrTK37/Svsb/VxkasD5QY/WPBsxUD5gyT8Uxh//19l5A0f4RMaJfzR1XBS5h31bQ6oyjruNWXUhcls9BduQkYkHI5qUYGnz/O9C1XBlWzwD+jvQiw2DePKmr3axVJ05Q+c5p4z0rafwH9gk6vLibQQ0YYkK7CHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2938.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(2616005)(1076003)(478600001)(2906002)(26005)(36756003)(16526019)(5660300002)(316002)(6666004)(186003)(6636002)(4326008)(66946007)(66476007)(8936002)(956004)(7696005)(52116002)(66556008)(6486002)(86362001)(8676002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NgTBp+HEmCCWipJ/fZoXz7M/Rp8HYfxda7NWXGmHBOCzGFVC7zKVCaVZKdUjnxR/Rhq5Rm/Qs5DYG04qDHY7EOR7IgqkbNGA7rmrPqhK/RTdkxOy9BLehuWBDfckYRnwImId9E5mMKOToCpqsaMCo0lOLDhTQHP6YtPmQJ29ETZCHIUw41+9QW9LCfuWusWXjeQ3G1OkJCYYWKyRYPIEDRqj+zVOBX4hFVVWEsoKcx3n5SEqUTDOsiSxq+VjVTeK/QFjksiuESByJfDbsd438/AtEu0xAF/zxhoKIpQpuop1El60huG6nocTqQ2w1mJ5JMvEz+hMWAjVdyY2umvY80+j7giigumD/xTMlWu+bHBys/QiSR0503roy2GxzHFCV3PhE5DstKmqk9exthmIm4PGNhNHsf7UahQR6pekwBhRBgMHMerIQMIiXQVsyxOyjrNK5My9o3dZdcrWmZogycQL5Ucye4nrxIkAwFLG7MfojitnViXVbqP3/56b4kuaBg/LaSh/3AA6GMN2IlbEpEquT7Wdx6qh3aPgoQROervQspyKAeM1gRT3O4iOL0bAT1ce8u30Z8u7mexQqiaixWlhPhVb//FwjPkskYXwHaFM0340o4bUTnFPzIAdcM+1dE45OeJ2a/yiu5qZ2m+mRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 984bfa0e-0d4b-4964-7a2b-08d853d19548
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2938.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 08:31:29.2009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EH9BjGM10b7F4Df2Gwf4pBsSokyQafezAjGtL9UfzB2CPrEO7wewDisxIA81HiOSyh8w7T7KFWiG6sLTaq/gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0201
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It needs to add ta DTM/HDCP print to get HDCP/DTM version info when cat
amdgpu_firmware_info

Change-Id: I05f20d6868ce2cac06a8496890b766dbb61de671
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 27 ++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4f6b167fef26..3a6a881a4105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -282,14 +282,20 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->feature = 0;
 		break;
 	case AMDGPU_INFO_FW_TA:
-		if (query_fw->index > 1)
+		if (query_fw->index > 3)
 			return -EINVAL;
 		if (query_fw->index == 0) {
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_xgmi_ucode_version;
-		} else {
+		} else if (query_fw->index == 1) {
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_ras_ucode_version;
+		} else if (query_fw->index == 2) {
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_hdcp_ucode_version;
+		} else {
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_dtm_ucode_version;
 		}
 		break;
 	case AMDGPU_INFO_FW_SDMA:
@@ -1383,13 +1389,24 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
 		   fw_info.feature, fw_info.ver);
 
 	query_fw.fw_type = AMDGPU_INFO_FW_TA;
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 4; i++) {
 		query_fw.index = i;
 		ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
 		if (ret)
 			continue;
-		seq_printf(m, "TA %s feature version: %u, firmware version: 0x%08x\n",
-				i ? "RAS" : "XGMI", fw_info.feature, fw_info.ver);
+		if (query_fw.index == 0) {
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"RAS", fw_info.feature, fw_info.ver);
+		} else if (query_fw.index == 1) {
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"XGMI", fw_info.feature, fw_info.ver);
+		} else if (query_fw.index == 2) {
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"HDCP", fw_info.feature, fw_info.ver);
+		} else {
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"DTM", fw_info.feature, fw_info.ver);
+		}
 	}
 
 	/* SMC */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
