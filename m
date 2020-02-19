Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DE1C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA569208C4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Uyk9Z5K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA569208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F6D6EB81;
	Wed, 19 Feb 2020 15:04:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C996EB81
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zxs2PK4Khw+7s6+qsotoWb0bgRNZ8X3xnRqMgpkJg1xt6oy7MwTlwxMywDGidQay428bSaSOODPbidXOw398FvU1svC+B8UgYZn4emSDYZK5ryfnDSFWVNIiI88PhAVoU/yeXbYGy7zF+eX0NUjwXPRPWpLc1ZiBoWRl6wsyYfl/801sJ4mDzhjuowTsC2WSuH+Lr5qheOxQE9pSBQyqZbh3C/Qo1HP385uarYNKuh9hmM8Kggmw0GRtmqmhBot+Bo7XW7/MmmiCNR5ee4rG7rl1D8c/v1GcxrSnhK+YtwvjJIXz10IJCW1iehS36fBUBaa04EktGpufZ/7zBEoQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/805SYCuls8Dn7ZnQjbLgEdMX6SKZc5FLRQEWOEmK2k=;
 b=IisCL9ISXFPDzxRyNG1/3oe+9VxP4sn7xTapPQJQnrCjrczK5q0eWkgtiVW/ak3/UogAIdgMeV0U017CwbhYdZuBgk1cDtBA3ItgOlxi2VEwH4jz1YjDnOB8OJ4iwbyvB9awUtGOmSgHlThPUddjLmzornIwts9VoD814DpgzTzO0DHLHeLbId/0W0+kAjbz1/uk2l9c34y2qGVZsu1Uw8QGqlfiqOYlU66+eQlEz9NWuQdYsRCxd/bl0NeVFxSDHieNqZLWICM69Bd3q17st/4fr+m3gNo5iWnTXUr7ERao8+mUVWMADnnJOUw2fg19dl54TTJWgOfDPjhWNnupYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/805SYCuls8Dn7ZnQjbLgEdMX6SKZc5FLRQEWOEmK2k=;
 b=Uyk9Z5K7opyaGlyhDOZXxI90RyT3qd6fCFWERhrAnKGf25kSGwLUQxwKmhXCra/owNq2x44Lse965bZqVSyZBHbNXcmYsxr3JAYsY5o9AfdXuEasWRmGODR2JYyAjU6HYUk2XlVR+nLYTAZjROqGzybKut76CNKltLxggE7091A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Tom.StDenis@amd.com; 
Received: from MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) by
 MN2PR12MB3821.namprd12.prod.outlook.com (10.255.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 15:04:27 +0000
Received: from MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c]) by MN2PR12MB3935.namprd12.prod.outlook.com
 ([fe80::a984:d7ea:2dc8:387c%5]) with mapi id 15.20.2729.033; Wed, 19 Feb 2020
 15:04:27 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to MMIO
Date: Wed, 19 Feb 2020 10:04:17 -0500
Message-Id: <20200219150417.510884-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To MN2PR12MB3935.namprd12.prod.outlook.com
 (2603:10b6:208:168::31)
MIME-Version: 1.0
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 MN2PR03CA0016.namprd03.prod.outlook.com (2603:10b6:208:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Wed, 19 Feb 2020 15:04:26 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 60e4735b-58b0-40a8-0bd0-08d7b54d0359
X-MS-TrafficTypeDiagnostic: MN2PR12MB3821:|MN2PR12MB3821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3821CC72E1BA422133909B52F7100@MN2PR12MB3821.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(1076003)(2616005)(16526019)(956004)(66946007)(66476007)(2906002)(8676002)(8936002)(81166006)(4326008)(6916009)(52116002)(186003)(81156014)(7696005)(6666004)(86362001)(66556008)(26005)(6486002)(5660300002)(316002)(4744005)(36756003)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3821;
 H:MN2PR12MB3935.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eb7XKM8g5NgbqxPNOn8JwsSfu3e6zRmpPD2rroduNMYmfce+/gLa+1nDbhmo4qbTYMehWVGg5S64naGrB274WNrDrwKCxWMu5KJ57AxKVNYWACjncF8ZaiLwweJBXD2qFoZ2l0rWiIwDm6ysWGpDxyt/+3w4JRqcI0MUhFv3wOUmZDwrYybabbzbg8qZwdqCGKdYww0xbl49I5JA/5YxTA81Jpk5ccblpdhXZZL2LxLpwd/knpIAJg57S1feTvtzdbtHUl7bmkDJGxnRiYWE7dByp0FYEf/2+TQLKxDSqJkKEn0o0WSc3HdHsoWlM/9MOy+mShcp/aVd7L3uzV8k9ZsIGaZydu3fjLINH4Zt+o5pYVYztVkiSzPpv0qOdRM8urLoffy0kfC5xvmdkRUcXZQH01qHSgp7h9puPZIYIH9pFTqQ4Tolq83aZyZb5YXt
X-MS-Exchange-AntiSpam-MessageData: 88xsOrox23ovSU3VKaGneB87Ykr9X4W4x/qO9P1hTT2KANASRgz9q22t+kAt+KKGpSNhzlcraTuqH2EiTnlzwhfqrbdwSN5HqHfzyfsVYOwb5oDgSy72+kjTdtfld5D+tHmgQLshDT3CFt+r+uWZsw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e4735b-58b0-40a8-0bd0-08d7b54d0359
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 15:04:27.4118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaeCdazuLbuOTcmjm8/cyXB4IkbKUnBD8+wHpO+WPvH6WVu+MUDS1PuRtNuZYPFGHTP1udYtewN08tYUCP9fVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3821
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 7379910790c9..66f763300c96 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -169,6 +169,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	if (pm_pg_lock)
 		mutex_lock(&adev->pm.mutex);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	while (size) {
 		uint32_t value;
 
@@ -192,6 +193,8 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 	}
 
 end:
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	if (use_bank) {
 		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 		mutex_unlock(&adev->grbm_idx_mutex);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
