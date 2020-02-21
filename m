Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AA9C35658
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FB42067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kLiwXkzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FB42067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F6A6F49F;
	Fri, 21 Feb 2020 16:03:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA906F49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFqbxgOxdtDH8f+0ckFNs6p0kuRzilm3eQE9KAgS0ZGQl5TZFcnkEwLR1x8/sVyTEWud1UBnj2a0VhqKW99riWTOhahSu/ZFbXXOHfxtlxHmmAkaaCOdAiwO+M5sMDKKeWyvMXcHS62OPGWzIJc4eU6ihIOBLNf6/E+9k6+YUTB/R078mUrrIP+3I1mTYEYqwEF7E5JdwjbxWv0dNBBSoDu8e6IL3h9G3zCRtZxqgBsjxe/57JeejWCEIQo5FCmlsiFWooqXi7lAofX9Mlu2YHfb6N7e1slcuVa1KN1FDtK9dxBPb4ld5T5h6xZ6RLyi7ICg/NUHPeWZi5MGV9714A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXhyaksnwoFVBNGg1i76dah1Fru4NwQBK6xmumqCpHg=;
 b=mNYHRsGz1/F7pVq9h6z3xuO04KhNlpANuU5mlcGpbvOxjqci00WY9nUHvzt1DCi0wZtV323KOhQ/1Uzdb3Oum9ZQcIlKTTn+fKatyf2nQLtXqpY9pZFpbtHoTfBPXaJztzmxpDkyw8bWNP6TT3Rhl65hHBFfC8NhhRH1+6hwk+hNYH/UcCEq6lOte3bGBgOdYpQfPu4160J4SPrThWTYkUkLZxLzg+gwFKraX6Sid9iChfmfD6ldMRKf6lkYrv55LbfRfVFBlDleT+/0LFblGySAwK4huci9+S+VXyceFZVcddVsSZnAh5XVXUvspuvcX7UyKA8Jz6DfkeUG1hYDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXhyaksnwoFVBNGg1i76dah1Fru4NwQBK6xmumqCpHg=;
 b=kLiwXkzLvqodGWllrAwt4BFU3DbOILcoCfGo7oFRsD1B7nD17uTCoFa2pYdLmAUCIHDPGYlFl0yI6iq1dSicCS7cfjL71Ozd0TMAdewrXQaqWuq0ZBTYYhPhNLqWNgTDnGJ/YUUe1Qz1xi9xrLsBiumuiZHP0Sk2UBnOVZwFuLA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/35] drm/amd/display: Don't ask PSP to load DMCUB for
 backdoor load
Date: Fri, 21 Feb 2020 11:02:57 -0500
Message-Id: <20200221160324.2969975-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:50 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fe3172f-9d5f-4983-aabf-08d7b6e7a46c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2572B5B91DB933B00FFD705598120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1r4w/zcqSOMFU1NlRS62dIPs0aei4VP8H9zLntfVrknfbLD82CvbERL35bh5pONrCgT6mD2r2VsByZqtR4l07ol+tnnkN6d6rGpGBNty/k9rheaGmDLzme1PrfqRSgPHVy+umVakhXBpHwE9sFFnVdfVmt8ib0zFAUBNYfc3H491iadD/01dUey98f4OpchLTS9wytkul+mYrfqPLWHxFphxAsM0WKxqtOJS177GXPgztQOaxWoGAPaDbe0LD/DfuEho6anvxMWxnwoJc6FWWHmkyRE7PynJx7dLJA5e/wCCk5zzhOH2kXygALVDLt7aNDOcMeVhHqP69DbYqf41mxnX8h460rFSjrs7NRshP7HPwVOxJniigKh0Zb57QlnGowU5HudXJvtRnlr+JcXWQg7dn6BY0rN/CFp/TyWpK2ACjHPMv0SXDW2618UhcH9
X-MS-Exchange-AntiSpam-MessageData: u9MEl2DWcPQU3gpQyfPasP9Rh1XxSTDTEePnRQw4OaS6zh8YHwzdF0few/5Q97bZXh5zNTyJzvN7PPcsSdakVUSTL09jK9B8nIrf4Jxsgdh0sdC8KZDzga/IAJpvYoAvu7KDoDNEcfuHwxotQIJE8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe3172f-9d5f-4983-aabf-08d7b6e7a46c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:51.0808 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17VEmXhn3e86+zyorWZePHOUkNuL75tbUqsEULvWy60CG9IkFgJOY+LkBkL11yM6hNo2jO7zZXDVWHJI3aI6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
If we're doing backdoor load then do it entirely ourselves without
invoking any of the frontdoor path to avoid potential issues with
outdated tOS.

[How]
Check the load type and don't pass it to base if we don't want it
loaded.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8bb022c91b8b..933bbe8350bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1202,16 +1202,20 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	}
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
-	adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =
-		AMDGPU_UCODE_ID_DMCUB;
-	adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].fw = adev->dm.dmub_fw;
-	adev->firmware.fw_size +=
-		ALIGN(le32_to_cpu(hdr->inst_const_bytes), PAGE_SIZE);
 
-	adev->dm.dmcub_fw_version = le32_to_cpu(hdr->header.ucode_version);
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id =
+			AMDGPU_UCODE_ID_DMCUB;
+		adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].fw =
+			adev->dm.dmub_fw;
+		adev->firmware.fw_size +=
+			ALIGN(le32_to_cpu(hdr->inst_const_bytes), PAGE_SIZE);
 
-	DRM_INFO("Loading DMUB firmware via PSP: version=0x%08X\n",
-		 adev->dm.dmcub_fw_version);
+		DRM_INFO("Loading DMUB firmware via PSP: version=0x%08X\n",
+			 adev->dm.dmcub_fw_version);
+	}
+
+	adev->dm.dmcub_fw_version = le32_to_cpu(hdr->header.ucode_version);
 
 	adev->dm.dmub_srv = kzalloc(sizeof(*adev->dm.dmub_srv), GFP_KERNEL);
 	dmub_srv = adev->dm.dmub_srv;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
