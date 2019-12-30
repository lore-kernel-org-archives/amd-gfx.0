Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEAC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1722071E
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rzx77emb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1722071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A63891B3;
	Mon, 30 Dec 2019 10:40:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59898891B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 10:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VldZFjPKxYCZLPnvASCiJu6fJ7pell+7KelWkUCHK7+cus9lUE3i9lgo7jq4DRWtc2pvSPsLy3C+xe7Qk2iEy0VUVXPVx6N6mOw19y+RT+h7V83Kn5uMKexkNL9i+vxAdptcULFUJuQf8Mm3EkTOBDmyQzeLhhCc+uxlfBMacEq87OTgt154BaruSQAQ5Mvx7/KsDY36DZhMaRw0QmJAaeBhGhUPkLN488kYtLbX4TQWMSHaZdLBZkjxNsEK+srxjuEO7PBHi2EBRK4Wy5rKjEpGixFFd4I3BVYUmNjYS1/Us3SvLVWJ1kJSYWAVvp31aXZKk8VaWyOCncda4NiY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJIKwcfnYPjKVA/m1/pohGiiZw5rB5vMy/vIbQBchBM=;
 b=d0B1QCkHr4yWPrhSw1caYUmYgPYVeAfERD9CF6IQgBXc12M6S9QWrqB85DAdmxrxmaEc0fPjBHxO770n47rW23p8KMGhFkZZ0BnQifxprtr/8LfsYmXiqXr4c39QfSIuLnutxSVbEqhwyOUlsSVDQDPgG83EO4cIxf/hJap5qL1sN5b1p+ATdVJkSVZCjS+CnxNfRe8PRy77Ctg2yhJdwb2HkfFDDzMc5VfkafQYtEr+IcxAJi1dbNM6HqWIdK2d1dXqt78kHe+8K6BLDUqXGew61ESkxbgiccZgjSjvvxWGXrTYXqh6QswNGEwAxg2W/Z0/+v7qMip8L4kH0tTbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJIKwcfnYPjKVA/m1/pohGiiZw5rB5vMy/vIbQBchBM=;
 b=rzx77embUevxjO0QOEr4NEStOXy6J6V9mhFZIoQM2gfAB2oQ9gQc96/l/9L04j2eB1OKL6LnmNIGKHacA3u+KhDHtmItAfLoFQFtJl5BxdM8sHC8JPgkR36aOzSGdrEZElv98gE9fbl8KnBtC9I0/nzChT9SevlAAkzfHHWFm7k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3039.namprd12.prod.outlook.com (20.178.242.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:40:36 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:40:36 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: avoid deadlock on Vega20 swSMU routine
Date: Mon, 30 Dec 2019 18:40:13 +0800
Message-Id: <20191230104013.28093-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:202:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11 via Frontend Transport; Mon, 30 Dec 2019 10:40:34 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d58a832-e45d-4d89-2966-08d78d14b44f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3039:|MN2PR12MB3039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3039F94B43A3BEBF940FB842E4270@MN2PR12MB3039.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-Forefront-PRVS: 0267E514F9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(189003)(199004)(44832011)(4744005)(86362001)(81156014)(6916009)(186003)(2906002)(16526019)(8676002)(36756003)(1076003)(8936002)(5660300002)(4326008)(81166006)(2616005)(6666004)(956004)(6486002)(52116002)(478600001)(66946007)(7696005)(66556008)(66476007)(316002)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3039;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GH97+FAipKM0tcNQncqtidXZgL/UQaT7PfUI8g7UTXCUQOYacAhvKpY/gFIIJXqVHol6db+4KYu8QA8L6c94hn6ayTTM3AQYoUr4nBafYHhIkJ/2m2WVPXb40EVzwrRo6EHHlwsbvimdJ5OZIqDwXHI7Mdy8khqBzBG//wu+C6pE6MZuzaw4/z4oabCad324m7v3xr6mjdFo+/DBkaUZuK2Q+AhNYsbVc9RcLfHEW0KLf2nJtsqYXFIVgbCMPIQ0F/YhfFWFWm/b3RUPDLxZgik3K5k2AbVbxzkzzNURkA2J5+9xR15NcHkZJ5SjC7g+bcmSST8am9fnERMaz/UP9S0ZZ/7nyFYfB3w2rGNZLJVsqlzdezToOK/lAsGD3o7b5njZTj4Z38ta0cZBkvUHJSuNuusyJB7llW3ZE52E4n1shbr7lWY4UKj/k8C0y+ne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d58a832-e45d-4d89-2966-08d78d14b44f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2019 10:40:36.4741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBBEDQjDd5NCRH7cikSZPk+EmaHYwA0bevlWTAUVcQcYnIdyd6w/WdgbW8xcLBCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3039
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The lock required was already hold by its parent API.

Change-Id: I2ffe63d2016a2e274d54634cd8f8c51cca8b3a1c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index bd3dbd1a0ad3..4b686f0af538 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2279,13 +2279,9 @@ int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_active_display_count)
 		ret = smu->ppt_funcs->set_active_display_count(smu, count);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
