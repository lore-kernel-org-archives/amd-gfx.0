Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1454C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7429F20658
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 09:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xtrUIq+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7429F20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E02089B00;
	Wed, 19 Aug 2020 09:59:14 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DBE89B00
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 09:59:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Tj+pyO5HDz9hmD7v1aOL5w9/0jvxQmzTveDo8FXSsLX3DuYJAcNO6PO0udGAl4CguNfUinXe3IIo8Ak4UccDJZGf8F4P/LVMr1MxCx7cKf23VmEKgSJ+pnQmK31/iO+/67Gc5nHHW5V0Hfj4DmYa0kC/E5//+RjIIgLTL0RKU8fII6K00+7SJn+k5c00RSM6JZX7NoMXOxjVDWIilLYWyBnImsPZnK2A1YWdObVq4i9+Usc0v1W1xoFE6r8ZHYf4A85m8jF6kVxEvj54hK2OrAlFH6W/KWtyp6pNt301Gid01PWZy1nCWgocdfI53W0Ii46UhmcTA3p44Dj/ZCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4A3eXb5kYKmVMcFeMSZ5D5h3KhT8T5CMVaeGsTBmDY=;
 b=fqgfI/hl2hS5ryJ8aHkJ5yJjozXbzH3fXCcc/ODq6uounQv9HC2DZeyvduWAtLblJYo/fEK0EVGz0ZHB4yK3GxKPNmaqpzKb/UnxQsCj6KC2VrAoICpaGyqLMA1YeslOp9gzgBUDhDrMOcrok6VmuBDsVEIXc9jm1i4nmmWxdJ6Tvz2YRKovIef99hvvA5ZNGLusAI3yg2tSpClvCS04xWXYG8GT+oEt+RKZ998P1IPVKOrkLLq4RKuUyQpqbN9uhI5mR5nxUKjxkD/t4yb1NW4g5k9A05AdRVa6WOtMdrYFvSBNWxbg4uTtFt8PqGrDJq1DANUfTDwzvr2hf8I6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4A3eXb5kYKmVMcFeMSZ5D5h3KhT8T5CMVaeGsTBmDY=;
 b=xtrUIq+NfvVBioLlhsAPZH1cdqR6Y74a+p7AsBdJzj2oGYiCEGtEObC8MFqiqp14R9RANvsgq//ml5zojxmYOC8GIw9+p48CGp/U1k7Q/Jeui2MBlivahe2Bh8nD+gQe9FD1eZkX+qPzDmip0Mj1x2GCMgcfDc2LCBNf78putVE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Wed, 19 Aug 2020 09:59:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.026; Wed, 19 Aug 2020
 09:59:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: fulfill Navi gfx and pcie settings on umd
 pstate switching(V2)
Date: Wed, 19 Aug 2020 17:58:33 +0800
Message-Id: <20200819095833.11420-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819095833.11420-1-evan.quan@amd.com>
References: <20200819095833.11420-1-evan.quan@amd.com>
X-ClientProxiedBy: HKAPR03CA0009.apcprd03.prod.outlook.com
 (2603:1096:203:c8::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR03CA0009.apcprd03.prod.outlook.com (2603:1096:203:c8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 09:59:05 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba9db0aa-1fe3-4ec7-4da8-08d844268291
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23605C4D82A2C03B58B26B1CE45D0@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPquBl8QdHZUpWWsDHAbMLfNZogazMS8zGeyhSb8Po/9ehwPu61cLZtf1BYrQCra1eJZDIhaPVdCgIxxHv16l47YPItkTrbUI9dFMpgp6yntL5XIfC1uTC6J/jESGkc7YTD1VDRkgNht1WiIw+/1mYOm6a8ALQSavWdJquRE9hC3veYNEoAp0dHhIIFkt80a2H6b3H4uJC47FytWqPT5uNHEVaj3qc61TmbpuOapMa7bos8aKAwagbnhWB+8Fg7jmD2FFkEuHdGi+yX/2lTVDa9Dumyq6SGnTQUN4NEL7T7Qw+7CiqZr5QWIwCLTDb3g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(316002)(36756003)(16526019)(44832011)(5660300002)(8676002)(186003)(83380400001)(2906002)(66946007)(66556008)(8936002)(66476007)(1076003)(6486002)(6916009)(956004)(4326008)(7696005)(52116002)(26005)(86362001)(6666004)(2616005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: hg7EiI/XHXgxK2DnxtNtwIY1SaD6izmA0OJBKGIo8yc22+aGDH85FtEmmbAcqjxhO9S0qg+b7ubsCWll3ATORskgrh1ZPzA9G0suaBxzgcVfCvHffyaH4/FHYsdbKVV0pG9I4f/fPUhXW97045usBDss9uT+NHRWRVxLCnJVSB5CoeTl6rx2BTmXyehm1MdGz1RFMKB54freq37ppMOxnPQORZ5gECV1dHr2Rz8vNvtVjRQZBC4lwrCBsESDlyUEK6ED/QmBQrUvAbqu/vCFP902vRDigqnAY3JjntDU+SsufwylVStN23gfdkL6pfHEGbyFUCxTINRM+TSmSSFLVGbStUa2V+kDG9QupStMdA3zglQJUElysru44zw7/FylESBCOr5VnON0gxBPRSSm6LU5XHO8p9zAkS2LbJC5pnLbqU12gqDNA3A9hG2qvQ69oloNc1/g89MJJHRIHUUX+li42JL3inPea9U3UL08FXGDp/G6VUOlT4xm+n5M4hICYlqdUBm2ffsrIXOa9i3vUAPVrBjdA3E70YZphTgc7y/ac8g/cxyzo4C1tDN4AGf/uBPAvzF8NCfAQji8aFj3hIzQR3PXDFTtQtKKvjPujipkTdIdbYRR67vgOvZ1sDtQkjNdhIqcnvSCN908PwEOXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9db0aa-1fe3-4ec7-4da8-08d844268291
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 09:59:06.7779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Aww7LgkbeZ/Ka8MQ8j92v0Fnm81UItONoDCYqpSCyZHrtxktQqShcXpHAeSfiVY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fulfill Navi gfx and pcie settings on umd pstate switching.

V2: temporarily skip the pcie ASPM setting considering the ASPM function
    is not fully enabled yet

Change-Id: I8d746d4c25f890665feeffddf64164ed2b1f5ccc
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d07c84a7543d..36e59c735a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -694,6 +694,23 @@ static void nv_init_doorbell_index(struct amdgpu_device *adev)
 static int nv_update_umd_stable_pstate(struct amdgpu_device *adev,
 				       bool enter)
 {
+	if (enter)
+		amdgpu_gfx_rlc_enter_safe_mode(adev);
+	else
+		amdgpu_gfx_rlc_exit_safe_mode(adev);
+
+	if (adev->gfx.funcs->update_perfmon_mgcg)
+		adev->gfx.funcs->update_perfmon_mgcg(adev, !enter);
+
+	/*
+	 * The ASPM function is not fully enabled and verified on
+	 * Navi yet. Temporarily skip this until ASPM enabled.
+	 */
+#if 0
+	if (adev->nbio.funcs->enable_aspm)
+		adev->nbio.funcs->enable_aspm(adev, !enter);
+#endif
+
 	return 0;
 }
 
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
