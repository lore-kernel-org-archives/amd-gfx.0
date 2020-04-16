Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C1C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A31520732
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 15:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kKHT86iU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A31520732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F144A6E30F;
	Thu, 16 Apr 2020 15:48:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77CC86E30F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 15:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8O5JEIKfBv0HVwAdTrT+3JmntjBiLc3BWwkND6zQefyeYY4Aim5uW4q0gV4o143pDDYrOLBIwwkB33bo/6w9+g4GwPUlaULohje2qvzs8DNZYMa0wJJDNliaem5JY3zsKsVXKiJgSiPmg8p76zrYFe8lz/VhIljirz9cBleHuATtvHwSGN3LIdR/h7oJnDNld0DQyPAAcNIiOPLQo+2Gqcvp4ojVraHenF2fbNt51+Jk0RWNQwUELnumtIk0nGmp4fUKRBSXc73OzpoQR4/uQjJw2kqpTbt9LFEtp0vMmkhCmVkcPI0uMUFwrV8ib50elyBJXMSiIAu3W1gjCBbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miL09MSgwOGQMc5LEpIomxlWHv2eVh5uBgmkO1HgoVA=;
 b=BGt3E25txNqXYo5x9np0pO7sM+KF3nKcWiSNlO3Y8vfTTPge1EkJ0en24JBHJLFqG8xTuQ8+yzYIj60HqUKRadLItJ+3/V1GsY51Ib6fF8Sac3OgM8yZyEWhVtp5lTrVAZfKS0a+LixoPr1niPuN/X/t14Tm8qB5TmQwycxkYk7gLmDa4qoTkqkAsIJhBQteGNDss+qysdMUwqW+cfr+MbirAFPRNwnOZGLWoG98B4asJOtunG+k5FkOjIeDXdqeH/HTYJiNQIgdP0rsWzW082YDrZiSem+otpCVNYeI+miJJ+3mILX+OxxwiExsbUURn+7inYjlN2MThnuysMo3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miL09MSgwOGQMc5LEpIomxlWHv2eVh5uBgmkO1HgoVA=;
 b=kKHT86iUMFHn21x0RAX42Ij2UcuZP1PqI9neU4QECHgifKtrG0xEBePg1ny2DJQUlaOgzDEllT5yx0TNbetGlwP5YMLP3FGkien9N42TcBOzxwekeX73YlGLc2ibAR/eTkFvb8fW0z5Zxq9L2MnnDuGAomhDRrl/RCmoenjz6lU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1528.namprd12.prod.outlook.com (2603:10b6:910:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 15:48:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 15:48:07 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: fix kernel page fault issue by ras recovery on
 sGPU
Date: Thu, 16 Apr 2020 23:47:48 +0800
Message-Id: <20200416154748.32138-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0211.apcprd02.prod.outlook.com
 (2603:1096:201:20::23) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR02CA0211.apcprd02.prod.outlook.com (2603:1096:201:20::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 15:48:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ed9e2cfb-5a91-41fa-3021-08d7e21d8e8b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1528:|CY4PR12MB1528:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1528B9F66AD61E483FC4A7FBF1D80@CY4PR12MB1528.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(6636002)(81156014)(36756003)(6486002)(6666004)(8936002)(4326008)(478600001)(1076003)(86362001)(2906002)(8676002)(186003)(26005)(52116002)(7696005)(44832011)(956004)(66556008)(316002)(2616005)(16526019)(66946007)(66476007)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: la6PCHA8ShoS25roD347JfotO17mx2UMIbZaOf0BEixGHF8Qt9bOcf52NmhqCl9/YdRi+UoDNWwsKl/ZUGKSmCoJFF+vTYuUaagoS+prZicHI3wt2PxL/gI7Cu1IHYp9kLrGU1a6jb4VmHofghxLbDApbinWW4xD9TW11NmWzmH1UE7/I1UhJIgJuV91Wv20yWMoe8opbQwmrJRxNKG9Le5Fbhi/2oRXZaq0YQ0MAfU/T7FLE8HPmGjs3i0ZxxONH3gsIGNnT9XzZitUoU4l1h6CgXz+kRevZrgB3eG9UQYUMs0CbgTDPJWai9f+RonoO6A1030YDpTlA/b410zcC8trLoel4bmAPn1FCNhe0G4KC3eXt571AJBFITwXF9yvYv57df5UrVq+S2glKsLhbkWWanonHojF4PqiRHaHcMGCayfhJIs5XqrL8SFBIGsb
X-MS-Exchange-AntiSpam-MessageData: 2JyqB82zcW8xxHHkw9sM0jppjyD8T8IVBlq9/n1Jxr3IzTyOPoOCEN/BEgXd58lM44ArEa7pUV8ALulv13sWOvTFNMVg/6SJbG9we9tsjwTIEJ8FphQVcUf5OhhK8YmVYy56vgaGBs6kBYv/4DIHZg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9e2cfb-5a91-41fa-3021-08d7e21d8e8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 15:48:07.3228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuwgGHFwO7h+L9NMrGBOKzRG9uWvq2pszTxy4mJud6cVwUMjrH3dbFp+xmAgdskcrlbfqTWpShRWOfkCjU5e7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1528
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When running ras uncorrectable error injection and trigger GPU
reset on sGPU, below issue is observed. It's caused by the list
uninitialized when accessing.

[   80.047227] BUG: unable to handle page fault for address: ffffffffc0f4f750
[   80.047300] #PF: supervisor write access in kernel mode
[   80.047351] #PF: error_code(0x0003) - permissions violation
[   80.047404] PGD 12c20e067 P4D 12c20e067 PUD 12c210067 PMD 41c4ee067 PTE 404316061
[   80.047477] Oops: 0003 [#1] SMP PTI
[   80.047516] CPU: 7 PID: 377 Comm: kworker/7:2 Tainted: G           OE     5.4.0-rc7-guchchen #1
[   80.047594] Hardware name: System manufacturer System Product Name/TUF Z370-PLUS GAMING II, BIOS 0411 09/21/2018
[   80.047888] Workqueue: events amdgpu_ras_do_recovery [amdgpu]

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index b27d9d62c9df..260b4a42e0ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1448,9 +1448,10 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, false);
 
 	/* Build list of devices to query RAS related errors */
-	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1) {
+	if  (hive && adev->gmc.xgmi.num_physical_nodes > 1)
 		device_list_handle = &hive->device_list;
-	} else {
+	else {
+		INIT_LIST_HEAD(&device_list);
 		list_add_tail(&adev->gmc.xgmi.head, &device_list);
 		device_list_handle = &device_list;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
