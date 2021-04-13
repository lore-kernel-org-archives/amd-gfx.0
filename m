Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051C2C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE784613B7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 12:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE784613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D86289D44;
	Tue, 13 Apr 2021 12:56:23 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEBF89D4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 12:56:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/KWKiVpVa2loS4twiBoSEIVCLyvzbZjTOR9cYWIFIuiiGYqgtDqDp7dYhkokUq9QEIYq+MWf66vu+5M9IqUwdMvMthGTnv0UUavJ6aA5M9JSdRpVDg7rJP/wW2iemxIVAZClvWmCPewBGTQe0VtmM1bCIdvDNkl3qG7LPr29SHAeNV+kQ3gcVmJWq4JBDhzHxUayBsB2XcaAYJr+3xbutNbsW4jTOjspGnpbcu4hGm/6trlqaLyIzrzesCaUZCyOIi5KNZR8S90Rl7qZqtyU4EEexxwgENW3iq6dNLsz3Y590I6C6dwtkoMjMN1pz4YVZRKKpK+vTmf8epXWf2LDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/CWylMP0XwLvrvMPv8vJD1xu6DvtY12ULH7jti+NwE=;
 b=Mka6Sm2/Wl4kT3SQwVAdMVbCIVDyTXlaf+lU6ZiesE7Dm+ow3j74CfTPFraRqEuoFKgg018BoqnOlS7Sub2RlnxdxLGI96Ur+Nrv1s3FJI9Hmc6gp0ibpBwOdIi0T9aRLJYw5GWzSF915lIHQ20/Y+RJm8P/Jv7jWV4NnGQuXZAhArZCLyvgpiIMinSB8Mjq/O3Dgj+rpf6guOyx8OiaiCZjA2/BQqzEBLJqExxC5Y2QPXWknn5Yinnfvj+DXOz83TtXf/J/Dk3Y4zCQI4gUQA/fkck6v3Vy72CekkiCvZTQq2mOE0Nlk1gpgEHNZX9VWkYK6tSvkqqff+dm14Dcwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/CWylMP0XwLvrvMPv8vJD1xu6DvtY12ULH7jti+NwE=;
 b=Ivf32XF/SIsTfqrU76H/udamIY7RSD/nDLkTRcgnIaH0ap8XMuPYcJGXLXJNzbr38cCkIKW0LbChLlP/3Y1K+JZFhTTjfRLT0HansebsiiP39eJE/zujxOrwAEqjGTX2Glk6SpvUNV6fW02YUNUioHBqHG5MO0lb0uNim+db7w8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Tue, 13 Apr
 2021 12:56:18 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::cc66:8fc2:7029:d660%4]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 12:56:18 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Fix a bug in checking the result of reserve
 page
Date: Tue, 13 Apr 2021 08:55:59 -0400
Message-Id: <20210413125601.50387-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.0.97.g1424303384
In-Reply-To: <20210413125601.50387-1-luben.tuikov@amd.com>
References: <20210413125601.50387-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::48) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YTXPR0101CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 12:56:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9afff800-920a-4d87-a18b-08d8fe7b87b1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1836C07B08525E7BC17EDB82994F9@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vV8remDvM0XuCj0MFIJteqtKVnf7GN4Z9suoyxD5miXya8Peo5yynWKXzPF3H63KSdGAF+lBuwssD3xLsjX212tnVqCMbplhEfOGJ/OJqB3a82NZ3bviuiglSCva6YVy0ip74YxRBEqWB6p799pIW7rt02J8O4b6RtJhmZDsxkd8qwawVi+6wGi7r9NpfoRCS/qDVbzfLZqMUcW+De0Oa/JtWORJK4877UGpNTo0sPUMs+RqNfgRLoRvwV3OMcR5sL5nwh9gC9N5biq8H910BmibcSiXFlTM0mSBvRJNRwZiM92TC0tC84GsWTTIKslFLXP2tucsWVdYFQ8Td3POPV+OisvQ8jQD13Vv+0+zQlwvU0mVIreM66Jry8Twfa/wDlaUQp+P4t7FLWrwb/6HfZGRLVCdsYjPK5N+9b5GEk9hJ/7I006q1x35rt1akUZOLClm3DkjQYtdtMg2X/LiHIV2wLt8ZVxf5jDYPGQWRFD+pt21/Z/ehJadMB54H9MsAyNWBN+G8vo3JtpnMqsKUe7I3S7McfJiCiWK0rS7aDzpcUsOYE/0u7F5lIbR+JBTZ03y/xBOmLp78CWcyW+FC2kYLHzkej0/2lhJW/CNdAzO9wWNl4X6mO+rk65YfKcUL7ykIUcgphAoaEo962Ez3zXJKZc8YvrZF6s5D6lssU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(8936002)(7696005)(44832011)(6916009)(38350700002)(26005)(4326008)(38100700002)(478600001)(5660300002)(16526019)(8676002)(86362001)(6486002)(66946007)(316002)(1076003)(186003)(83380400001)(52116002)(66476007)(2906002)(2616005)(54906003)(36756003)(66556008)(6666004)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6KqLoLRa4gkLL+Ttya08b7SfJxaELKDSCFONte9sZCU/i3cyYRAFFU3JpZ+E?=
 =?us-ascii?Q?hIkNsdRroMD0i1VGi+onGGMXA+9oLkXY+G6avcmiuUNCHdI+cip377Ug0KBr?=
 =?us-ascii?Q?HkICEOpYIeEc6mVMi3hamE9hHgS7eWPW9Useakq69rBTlEWt2z983SzxDLJ0?=
 =?us-ascii?Q?afcbAx9TKW3XpZmfLReYJX9kuJcRzun0AIFXh9qiAul81CSbnTo/SsusrGVM?=
 =?us-ascii?Q?Ac6pN5EZJkKbPgUWXQ1my8VMTMZWKDBSi2FTXLnPNhIiSWZ0XxRX3eHHk2AS?=
 =?us-ascii?Q?yVRJvczl3XXjRx0K0+fkEmW+7Ig1GW5k0Htx04TYsOSwJnxWYjuKsusaI31z?=
 =?us-ascii?Q?c5JPx0Yay2QMiTjmbAJElnon5TJoco2vtAGZo63aBQEMB6+Qw1xqVgApDqVI?=
 =?us-ascii?Q?ZkS86eZ7hotAfY9tw8bcXVWdPnk6VmAKpcePY/z4JrZFbssqrsOixvCMnfIq?=
 =?us-ascii?Q?HTEfyFgOrxxeb3cE07L8+oGThkzhJGslLKLINCzbGSaHmjb+ZPMWg8iig4Ot?=
 =?us-ascii?Q?iFFWslJ2nU8t9vRubQGdA3lbGjNIOT9hBOvEIoJKe3kvGtICdH52Iq0tQGYj?=
 =?us-ascii?Q?kxxoUTLy19xesJIOGN5EobdBYHzpdspGhZc42VZmsKHFBwNVkVufBw+raCaH?=
 =?us-ascii?Q?qQKOQSWNTzpS0mYJv82cO02j5XgfeKvbRINFsdp1Z4yz4/zTPTtWyc+LDE2t?=
 =?us-ascii?Q?5dupMfdcTHmOqHDZHxYFqEi1mG2k5QKjItOTmFBT50UUlHJayw5iCDngItLU?=
 =?us-ascii?Q?kP2okazDHOImw6slyKblXYUv9nYxVdLit0/JD0C+bLW/2scNWHwLcDDZ1fNK?=
 =?us-ascii?Q?pIejcSm8RE4H0D+ad2CkYvnzqvfdNoDZHEbsgcsW4Z1l1qGb2cLxMbX2iLCN?=
 =?us-ascii?Q?Q3HtcUrJtW3HfWjBD6CREsC4oFXlEvAfnbFoiZxSz2iNpSNw71HO4+7wSCnk?=
 =?us-ascii?Q?7UGae5c+wmqKfBFAEE9lUppRMW+3vLZQMSCY8vTbwUZTSJqjOSplzjlpurkJ?=
 =?us-ascii?Q?qqg4fc2s7FiKISv66HIjMYjsPPbbc+CeM6Pg0bxBBhGausrI42pSyhP0jpRL?=
 =?us-ascii?Q?397hr++mI0hIVFs/vmxUlL+NWf4PDThz3/yf+0T21GZ5jqbJbCG/L3yzOJ11?=
 =?us-ascii?Q?H3a9c4bDrmPsvUgziLO+R1mcARePtkERdW4KUq5vtgWyhyUcZEUWGZ2VxcbD?=
 =?us-ascii?Q?3YRQ6wsEIDigvgrS/Sc9rBW3A34OCdV0/bl25tHGQkpJ48zEd4Lzxr6A9r8m?=
 =?us-ascii?Q?xiVwKp9mKwVIAARdusuMkZBUNN7pkCBTiE3lEZ5BipVv9wJWHa8Eck/lJWAI?=
 =?us-ascii?Q?GUBY3zwpM/E3xhkISYDIYuDe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afff800-920a-4d87-a18b-08d8fe7b87b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 12:56:18.6971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsBY/djd1NfnS20WweQAyvzZu7OA2eQaRfEU8XQCSzyNUhJ87YojxXeaw6W29c/V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix if (ret) --> if (!ret), a bug, for
"retire_page", which caused the kernel to recall
the method with *pos == end of file, and that
bounced back with error. On the first run, we
advanced *pos, but returned 0 back to fs layer,
also a bug.

Fix the logic of the check of the result of
amdgpu_reserve_page_direct()--it is 0 on success,
and non-zero on error, not the other way
around. This patch fixes this bug.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: John Clements <john.clements@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 9041453465f1..3ca6b51f0c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -114,7 +114,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 
 	if (amdgpu_ras_check_bad_page(adev, address)) {
 		dev_warn(adev->dev,
-			 "RAS WARN: 0x%llx has been marked as bad page!\n",
+			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
 			 address);
 		return 0;
 	}
@@ -228,7 +228,6 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 		return -EINVAL;
 
 	if (op != -1) {
-
 		if (op == 3) {
 			if (sscanf(str, "%*s %llx", &address) != 1)
 				return -EINVAL;
@@ -364,11 +363,9 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 	if (ret)
 		return -EINVAL;
 
-	if (data.op == 3)
-	{
+	if (data.op == 3) {
 		ret = amdgpu_reserve_page_direct(adev, data.inject.address);
-
-		if (ret)
+		if (!ret)
 			return size;
 		else
 			return ret;
-- 
2.31.0.97.g1424303384

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
