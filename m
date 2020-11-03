Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16124C388F2
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3CE22277
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 05:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BXOAVLpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3CE22277
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BAF6E027;
	Tue,  3 Nov 2020 05:54:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760075.outbound.protection.outlook.com [40.107.76.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3ECC6E027
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 05:54:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSKCEf3v9qMyOsQadSKu44rpziuJPIbEz1/kdGxkco47A6TTIfUtGMnyc169+2lwp28XnN6dKI7sbk0zfzrArF388mhopSclzu1yGWKJsFDs+BYTMeX88QJySQR8BjDiB59AOzLNETPag5uKcRUGQ5MY1QfbWFJoRsLm6Vbcly4Epdp6mfrNNUYvuCEzECOxTXHAu6FUcibqcleVR/A7LErf3BNimzXTkC4OnH63Ag8WAmG9gk7UDGQx6y/LKo0TTvTLp/P3/C5sXzsUS/mOpdrc7yZ97yjSgtyg6gsrgAtpao73QWyYp/f8sUSTwbybsAQelfjZ7t9h+xHIIcKQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oxAtgmT5FoXAxotHSw/R4o6rh1e/lOtAHUb3Lu7PGU=;
 b=Hv2YIqVyfJrGzxcKgYDTrA/2A7O5DBLygKzqvhfA1WzxgtseUh/rUtRoGdn+joG+uSEoXD3TNGP5HIS/oyqr6mDqjWNmszDiWN8J/l4EJ4HI3kVZZtNwTwvd9MUPWvRH6UhImR/+0NWUIzVaGMe85GMW3Qy/B3Xyto5r0NBom4x8Hk1lednZ0usC+W9XiskHJli/IyJPY3zP7jqRboXpJhHinbl//opFay1shRaInS7M3ZGjRFOf1oUM01//0rlrmZAW+W55NT0xHKmuysXETfq/lersWhYgpEbz+XvErf9i7nTc01abHDnybb+ZxT99iKw/P+LrTT2BXbqmUFexyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oxAtgmT5FoXAxotHSw/R4o6rh1e/lOtAHUb3Lu7PGU=;
 b=BXOAVLpFa/gNo/na+FnIiEvxW3bUEJxJP42xkvRjdwqQ79A1XDGKC8lYOdZk/cdi+5lLoxANxkKYCHLxXgtycMuk07fUCZDIzu7MdoktGboxL3NL+7rxCeLEWmRf0ZsLyw//INg8DwmoPgzJLRKsxKrov1GAybk+BTg3YvoQDZk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3293.namprd12.prod.outlook.com (2603:10b6:208:106::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 05:54:40 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Tue, 3 Nov 2020
 05:54:40 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: update module paramter doc of amdgpu_dpm
Date: Tue,  3 Nov 2020 13:54:11 +0800
Message-Id: <20201103055412.19169-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0149.apcprd02.prod.outlook.com
 (2603:1096:202:16::33) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0149.apcprd02.prod.outlook.com (2603:1096:202:16::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 05:54:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f2372a92-bea3-4842-ee57-08d87fbcf468
X-MS-TrafficTypeDiagnostic: MN2PR12MB3293:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3293A74CE60AD7E7BFB15EA8A2110@MN2PR12MB3293.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbKkEI+nezQC/mhwzyObOwrNAQS2XPcCibkZVq1BeKtSUeB+GtAfU5yUnPWUbmp6j1q92r9PU1CzGntBCUTE/AlyEAUJEabjcJL/dRGXp86SMSe+g17G7YkIrDgeoY6tMJbyhcpiv+dMgKyy+djuYCQT7PFUqn+i2OdK/rwYOB1u7bz95GWp6fQ7Oog5dysCcTzyKpqyl1BY6YXW6PDF/6nKkA7vHG9uc+4uob4+8vFSM9NWBj7iTnsi+LoltzfpU/7AFN+el50PzN0PlxSZdlv0SRy5FRgJNyDnQjrPWvGqrMWJuia0pDiYPjwxm1wXvKUKGDGGheBTLdE/50Dd3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(66946007)(478600001)(186003)(16526019)(8936002)(66476007)(316002)(26005)(6666004)(6916009)(5660300002)(66556008)(956004)(4326008)(4744005)(6486002)(2906002)(7696005)(36756003)(52116002)(83380400001)(8676002)(2616005)(1076003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: s2zQwfajeVXxKRZnxeQPuMHSc3jAklcU/LBZ49Y2Aa9QfNst56GBWfkSWb8t5NXTNcsm6Ct0eXT+ZKTK4gSTFIaVHj+/u8SzCpb0+eu9+KH/1OEMjcOIm/zwWl4MbISsYufMEdZs901w6t0NDhHLmMMXd4wghDJQNJtnZxrOF2o2Y5zzuewePJDNoKr2znWwXipH0NYZMEayP4pH3vGI0sllx7CBxs7Z31xHt1RwJhfm+b9+Q7eIe17A55e0CkDi+QHrA3NKJ1p+XN6mkh77wEt0fRb8MzBaVQdtu66DhgFgQbUFfR7NXc92ObpYkFMTfwwGOgXvzYCdcJUmNN/3LOTSBAFrzz2dbwtx4t4gI07yF6wkS5ipepwJioVP+wlU3aUDV4WrB2PCUnXigXhSlghobF4U1IP406wPhWe956GP5UU45pXbZetAY4XZyDFgQq50/sBSfwxGFqYK8FODom2/iRzDDI05Qfu+XYGjL+fVy18jwbjN2HGegmVJxMRmxyi/x9qfeolw4V4jF/GA1cejYNylqvW94OyXh300fNJWSyxsK9MtyUerrWyprf8oMBaHZvYSkOwlKxEx4jG+bAVCrM0v4lwHMNVeRrpauspxY7y0eqkL/qv0F4Hf4m6TIIlO3qFf/nw5aZsxOvCJkQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2372a92-bea3-4842-ee57-08d87fbcf468
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 05:54:40.8579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UJcn0t3jDJNS6dZFXuU8BR5xN1Bn0+6HJx9mw1JQZXS79lQxp89r3CYPNAiBrJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3293
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
Cc: Kevin Wang <kevin1.wang@amd.com>, kenneth.feng@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

the vega20 isn't supported swsmu.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03f4aab1fe99..9d28054b8aae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -279,7 +279,7 @@ module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_
 /**
  * DOC: dpm (int)
  * Override for dynamic power management setting
- * (0 = disable, 1 = enable, 2 = enable sw smu driver for vega20)
+ * (0 = disable, 1 = enable)
  * The default is -1 (auto).
  */
 MODULE_PARM_DESC(dpm, "DPM support (1 = enable, 0 = disable, -1 = auto)");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
