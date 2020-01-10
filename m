Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D1DC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C6DD206DA
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 18:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c+yCbKR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C6DD206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B653D6EA83;
	Fri, 10 Jan 2020 18:33:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6B7D6EA87
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 18:33:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXT/fQHqG4aEypNEBxVz9/cdgiXaVRtg+BGvVmojlA28IhRbOcehzXOGgKvf+NNvOu05Q0E+SNkiFt+af3w3+bGppC/Rl6tcd5lA5AfdRvaMmgu9kffIJQCjanXQtBTtS4S9WiXTLHEP4y9TJH1PGNIVsrRqg8n+d/TgMazccGpHVvnfst58efIyExs+jsQKRfwHw3Mmrq3W5ocfcNMo410+aGMZFQ8hpYLzafhjlqlryMXQ49Okm3dWYKp0849ZD2ZD6pZXtp0wfHRd5/YySY0MqqOHLYXhhftZHTaDby4HLgeBAumX/imcJOJYeeuOTJ0M5hGNxAddmm/uKEEi6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaCty2Q774jXPzieEFQtQof+yk+0+oCYbkurAzWPBDc=;
 b=hl0tcrRW/MRYRC5M37AzilAjX+3GwP3aEAKKqoBIrBJSytMR1y6z2y2XzTaoseqbmy4VlKNDEk+d6kXdzmPzyYO1L+ahL/nE94BFG66GisGTxyoR16GPoJr/DiQwJH3AnmVThmmtQh3hS8bkKpLao2QfoQ6OZYEC5vy5yMqJHrauyV/fG1EZ1hW/ss44WW6j3u8mqBeBjPjArVQ+X8gWT2Hnz2NwctS6Fp6cpXwL/HWowXI1ZK/unBLgrISNMHrO1FIW1jsoINGgVpT3z9tCN2jUEKxlO//r70XTZ/Ck2rLx/qnSBkykDaQlv8jWGYb/ci5VGudaocaTw2DGvRVrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaCty2Q774jXPzieEFQtQof+yk+0+oCYbkurAzWPBDc=;
 b=c+yCbKR+Xa+Q0tgr1KU1L7pfaoUvLb87MqNr69e4laCG5E4PZgLdek/JZ2h5aNij07O3nVFcfc3lZml6HLOA+CotoSlI7nTF5COF6XG3iV/bC5eB5rriuXC+WaNOr+pqDjPLJTf/HKSJ4GlEEcttPQH/WhwLbUMalK3Emz9byh8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3404.namprd12.prod.outlook.com (20.178.198.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Fri, 10 Jan 2020 18:33:49 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2623.013; Fri, 10 Jan 2020
 18:33:49 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check rlc_g firmware pointer is valid before
 using it
Date: Fri, 10 Jan 2020 13:33:41 -0500
Message-Id: <1578681221-11093-1-git-send-email-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::36) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
Received: from shaoyunl-dev.amd.com (165.204.55.250) by
 YTOPR0101CA0023.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.10 via Frontend
 Transport; Fri, 10 Jan 2020 18:33:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1396f7c8-b673-4c44-77b3-08d795fba242
X-MS-TrafficTypeDiagnostic: DM6PR12MB3404:|DM6PR12MB3404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34042DD41FBB8D10A0037000F4380@DM6PR12MB3404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(199004)(189003)(6916009)(4326008)(8676002)(86362001)(66476007)(66946007)(8936002)(956004)(81156014)(316002)(2616005)(478600001)(81166006)(6666004)(26005)(7696005)(52116002)(6486002)(186003)(5660300002)(2906002)(66556008)(36756003)(16526019)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3404;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdCoxxLMGOdlPe+eCgry19nQS2y6s6IT5BLyKdeAjMuc2HQrwqxIa76roB129IE7jqLoqGqhnB8xxu3fdsFDRolF9ZgZKMZNgGcL2Z1VjYSWpU1d4J3imyimOcgfrxtS8mFYj4vXzfEygkuv0YiobzJmctfJ5zHLrFotWR69xrEIc4LeBsyKuHhtnklZqxCie00qIHLFhaUnEVgpRqBk/OQzmxyls3snUhRYihQIg9o2QVLQ6jXs01i5rbRrcTPx1G4BSRMMmg4ZbYciU/Nw4RW8pEtA9tidAmxh6IqIQh6PpKmcPXgQtbfkTFpjdJmpg60bVg5bRXtKrl7FCKjCZZsw6U08sHt38cWoo6s0q4qHxKZAgSUEK8Ls6ZePcS3MmQCCV8rLH2B9jact/aAQ9+spfqJD9KxIapMNKgOvNMwMSwrV39jq7YvtcnMuCWeSw25a4bKoVcjDhLZRxtkCW8RkJ7zeyRFONVTu0tmqXgw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1396f7c8-b673-4c44-77b3-08d795fba242
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 18:33:48.9558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP0BfjLoVo5n7W4/887dihmw9M3+QO9WgcTq8XyyeRQvfIYFIcxrtBgZk9rlrrDh5uG9O8TE8fzxqgbPqxZBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3404
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In SRIOV, rlc_g firmware is loaded by host, guest driver won't load it which will
cause the rlc_fw pointer is null

Change-Id: Id16f65171dd427d623af4c5bc75f674019e63dec
Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 379e46c..07e22f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -808,10 +808,11 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
 		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
 		info->fw = adev->gfx.rlc_fw;
-		header = (const struct common_firmware_header *)info->fw->data;
-		adev->firmware.fw_size +=
-			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
-
+		if (info->fw) {
+			header = (const struct common_firmware_header *)info->fw->data;
+			adev->firmware.fw_size +=
+				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
+		}
 		if (adev->gfx.rlc.is_rlc_v2_1 &&
 		    adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
 		    adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
