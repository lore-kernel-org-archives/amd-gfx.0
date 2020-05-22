Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC978C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5733320723
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 19:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mfYIWsJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5733320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E79F6E0F0;
	Fri, 22 May 2020 19:39:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C47D6E0F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 19:39:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtdgmDlnI5MRQjBmcEJh29Aq0RiE/R+v1XUTbq9TKhScdG18QE6RLlG5ocr/anHoBIuXtcx35ByDqRFP33cBSp0NSufx9eXK7IgDPdgnoBzR9L+57ZZ9czma0w5crEnbrfYxaxJsaHgN+hcnWvJ2c3HJnN9rfxv6eCHd+mmYgloeos4ycL2mFvCdpp8GAlbzEh3YvZwyi6r/DzrbA/JU5Yfma1IWjca4XzJ7Z/qYVVzXgoJTNpAJ8Id3AKx5xFst55TSMRsFaYqzYZJP9oCb5T2FcNsXQMydn48X2ncNs4FQn8mdhQE3Pf8swqjeFsZC4isVgxA6QVbQlNc4yheqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9uMZFWrOBHVUjURyhA6Qz8Oa4Zd0jZJFrfz8nD5IEQ=;
 b=BS5uvkm6zSOXlAhqOMmIIjdPsfwqgtC3LJnoOT9VwFxoFFwWALpqomJOueDVge9+BQ2zEpT6uWa4tVR02l0FNaBgcwCcFjxpH39IvlDA09BJxOMgasiM66dAALnWN/FArkG1gDtILbbigjbi9BrNuVyzjpxShPkLfMrlGo/JOavDn1b7hBoqGOM+2eGZ6SJuN0Se222af61w2O04ikPyAnpE8guGbIBMYDl1E+mF5x+CwHJX1i0caeNWKZB4hYt9ctRUIJsTLSyCN2dNIH/Ql0rYvD7UzpEb+vpm6JuJhoAyszIErQ6OZIgZG8ZqeqWvKE0sbZWoUfNq3bseILMXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9uMZFWrOBHVUjURyhA6Qz8Oa4Zd0jZJFrfz8nD5IEQ=;
 b=mfYIWsJF59QyY3iOhLj88DNuJHmb7C1wIPaGNJs/IRLmbSyxWrFdpLodPdjW2Oj5679g7JRAxYaWJ5GpoOts6GSs1shh3HkeYvTAVngRszRWuUp/0aat0s1afKRwQVPXDLxYKU+5TWcNlI5iLceKKvblxbByngXZhMEaljR6mWw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4121.namprd12.prod.outlook.com (2603:10b6:5:220::14)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 19:39:39 +0000
Received: from DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c]) by DM6PR12MB4121.namprd12.prod.outlook.com
 ([fe80::21db:6afc:4193:872c%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 19:39:39 +0000
From: Gavin Wan <Gavin.Wan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Fix the CGCG setting is overwritten for SRIOV.
Date: Fri, 22 May 2020 19:39:27 +0000
Message-Id: <20200522193927.278795-1-Gavin.Wan@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To DM6PR12MB4121.namprd12.prod.outlook.com
 (2603:10b6:5:220::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Gavin-Ubuntu-00.amd.com (165.204.55.250) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 19:39:38 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04ec70cf-629a-4964-c84c-08d7fe87dd9c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB457932B8822FADABA95CD81DFCB40@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xk5cjgfb4ILh6j6nt0icmSyy0fSZAQPlzQ14q0zvQgrrfnQXjcHiXkyCr7eFqSpF8/97d9aPckwcdBbYF8HxuD3QPNBCLQR07iaqfTyD0o7CApM5awdymq0in98gOTWAyfTeLFWHi1bWtQla0ICp3sDua6lsCfkjKb/k4Z0o5z7sgmn509xubKbswl5WDc4pba0HVqtCF6YSxngoT6bVIHMyh8nlY0WrflXhC5xkG+e/Y50+NjYWPlP/OvMisUdlVoB7p3RUeoRZYETYEFb/Q2Ftb7juFpdCnkZNMAH4GUFSzWpcHGxZNL0KiIl+Y+qOsn6R12oARg2DzxS4FI6zlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(956004)(2616005)(316002)(1076003)(52116002)(4326008)(16526019)(186003)(26005)(7696005)(36756003)(2906002)(6666004)(4744005)(6916009)(5660300002)(86362001)(66476007)(66556008)(6486002)(66946007)(478600001)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uc5gFzBsZt0c2kwjHf7j69KW3Pa79Oq85cqJXAwozjyFdIKrlSiS0FxKZXl9fp+/wmILNwWdpUZL8/tdH/gxRmY9pvQ5ghmEXoG0ayWhc1NVgCqtV5ZFrOS9L/MeRgCX129bkmLWoEha+MqpX2bkzj50h2isnqfrN7CaHjCl6ySeuXXDx6JO9V5yowo1r9kxFSZQDxqfzzM33AfF31Ynik8c0J4wlvUCHpmI/dGXgOj49Z/9UlL8ZIDXdGKfVyAphcX0/7a0FyiLRiW6Ze1wpY7YOVfp/oiojCxHK423Qw0FwOWkbXNQP74y/jvBPQfuFUvjbIO1lSFbHSoALg+WCDn1E1Fmpdy0abNfrLzIBzPKdea4fkgn3VsBgsh8bmhD0+ezMIEXIqZJNSN/QkD6IiXsCgUTwM7hKL8ZkYqXUN2FvJpIcMTcUMzMw+2Pxu2WsTNQ7nbpfZhhTktYIQxxGlIIqzLj2uox9gueVqQaNUSsbtNYiHWSc7cWyo8rCb50
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ec70cf-629a-4964-c84c-08d7fe87dd9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 19:39:39.0464 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yUG0by2PzfTYhTDrBqMXHJBrPBrXmuR97Hc7nqvITBcurF5EJyPiNbzXlQp4iYEi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: Gavin Wan <Gavin.Wan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For SRIOV, since the CP_INT_CNTL_RING0 is programed on host side.
The Guest should not program CP_INT_CNTL_RING0 again.

Change-Id: Ic336fab3b23b8371c9e9e192182a3ba14a8db8e1
Signed-off-by: Gavin Wan <Gavin.Wan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index bd5dd4f64311..4d6928cfc269 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4558,7 +4558,12 @@ static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
 static void gfx_v10_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 					       bool enable)
 {
-	u32 tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
+	u32 tmp;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	tmp = RREG32_SOC15(GC, 0, mmCP_INT_CNTL_RING0);
 
 	tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
 			    enable ? 1 : 0);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
