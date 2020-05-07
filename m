Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBA6C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 10:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6222075E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 10:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZJLIDlFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6222075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCD26E96E;
	Thu,  7 May 2020 10:26:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E3E96E96E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 10:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJI0CheqHSxRUhA0lROz2IDP913KQtFG+I4cGCSEf2x8nziJH3uNWipKH9eEyC0Vqlce+M3TDvXeA9DrL9ALuuRiWP3NX1GfscRaa90ByfzhZAG8rsk/Wok/1AR9aC4ZsMnhHyjBXEcJxj/SOcSVQYO6oUym5thJ2cTzIAhWbWsvi8jXzSLN+9KLpTjsCb0DDs7ibIJ+8/T++c8aTIeTEOfn7iiylaz4LRAtQlk58Ngd/XZ1AwPmVnpaCZZQ6ssqLTIS+TyB6RnYmLA7Arq4HqSNQX51UJC9y0GcrUUn0d4PXDapn7t2HS5X8D7ZYspMeTy/ZpMiGxj+pI0gyMf44w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw+mLtR7N418E4Bqwo8HwZ04Q3U4NgeXiUvo6Of5yRo=;
 b=NNHxB+9AwPCVrGnnRirAXI5wNRcg9VWNjupvgKryY57JxHstIjcEy7nmaTclm6TbYOAygIcVtmMrAEKldf4JtIKX3Zol/yRWy1AwRz8IrVH+nFFh0epcNlYI8+kyEItBFqjwY4vKW0tMVXAjo/g4dnCwce5HIrJvzXUp4/gQaiGQqNEplan+yQ1biFfhY3J0yRidq4jcvs/d7IcYXlv89qJBKsh7D/0SkKKro98TxcM3gLTk6edo2xVUtEMoQM8v9JhEKra93tqU3UxyEF6jun3XsIxkgIVmmoKS2fAooIYjFypt41VAHGR4e3C2Yc0lGR8Wwf8IhvwBFskjOf+YlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vw+mLtR7N418E4Bqwo8HwZ04Q3U4NgeXiUvo6Of5yRo=;
 b=ZJLIDlFpPOc384oQZD2Bws/s8EaDBh33zfzLSHkSd+uRm8rKL0iIP3By2Bvj5ZtrExkgbkauofb7n+FmB5GUhT4Ks4oCkddJHuuzbfTm04+4sKmhUNw/YuC6GWr2eADW0/VRxW7ZFNZ057lDgXRMS5x2uuWZlPHLBba3cO5AdQw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2874.namprd12.prod.outlook.com (2603:10b6:5:15e::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.30; Thu, 7 May 2020 10:26:06 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 10:26:06 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: enable hibernate support on Navi1X
Date: Thu,  7 May 2020 18:25:44 +0800
Message-Id: <20200507102544.6915-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR06CA0011.apcprd06.prod.outlook.com
 (2603:1096:202:2e::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR06CA0011.apcprd06.prod.outlook.com (2603:1096:202:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 10:26:04 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32758a1b-2e7a-449c-7967-08d7f2710d0e
X-MS-TrafficTypeDiagnostic: DM6PR12MB2874:|DM6PR12MB2874:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28746FFE28467B5840E0B430E4A50@DM6PR12MB2874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2662nAUEGnSVqI30qWIvKaQkK1NzMvcuxay9jXqqH+XBTH0LwsaPTWLK2F6luGFZVa8qemZ/pUR5FA4haRVVjBOEs0nJ5aiummdlBPzmnXlZTWJDbPcs+evTlp9FamMjkaFop/iU0ewbhUgoLGWdAL5o2jBKXnMs8wrDPkEyMbFrmsPqUE+AEaFShpwjm5fRGWOUawNaDsXPL+BQ0Al3nUEhaNZKeV4XwPSFvX7C3/yO8MKLrxf06+lWpPMALE5nvUZt9A0HH9TF/BiqJdMExjKgSJaZiP6DZwoeY6tdLWUhFd7o47Yo6lH1PBGGNMRzf8hxAmknth/bFt3Cpo+NAyYkmLcfEnIxY16ZlRLM/TW133PRFs5NvKetiy2aaaKjkjgL2o9y1Xx2KqyBITV+SDP2XoAOsF3paFFJVQD2dXlnIaHxRJa28mLKt/Vo6wCsNubUC+quGuXOVrUXRQvQEGF4kimdgg8eKUQGkN+KIn/YeeVM6rKuDQr7hUQNfbXGW1HEvOCuelhNEzewZjQZXAblODIs9yWBGF5F/Wq5jWoBi5E1DZezVd3xDgdy2XDv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(33430700001)(44832011)(1076003)(33440700001)(66556008)(478600001)(66476007)(8676002)(6666004)(8936002)(83290400001)(66946007)(83300400001)(6486002)(83320400001)(83280400001)(83310400001)(316002)(6916009)(5660300002)(86362001)(52116002)(7696005)(2616005)(956004)(26005)(16526019)(36756003)(4326008)(2906002)(186003)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Sd3WBgcvib/IZpKZXbpjSURqQB2bKwhzaR163JD5zi4PeziOiQ7cfOM2/9884AQ9zpMPelqvs4SHrwWlHIJMDRfPIZCSGCt78DCu7ZC5nef/Tn/vOuo3FTC6SgvGE4jOTw7iRJsQR3JOUE67LpAyD0LxKA5BmslAbwQAnVqXkJAgvl2C3o1rSiISLelACwWU0WoVJRpsVZH/9RK0GpJ4QeHffK0R8gaRRKL2MXb6y+2YbJpyZW2bfM5N+pZEboKvSdGhNJFmxMrCkMVrfIjePe4qm0v6j5LRi/EaMaDFWHzryorkNAnq9UGR4FPk2YJaKLY3jxaUFhIZwD8/QuRMoHT9RbP5Z1tJq2+DHTpLXMIg8dJBvKT84db1BVuu0Q9U1jG3bZv8OBJgWLtSlRj3+rLOGu28FOfS0sfH9hGqEQI6JyebnzWndEmbJKMIbdBzPdpDyYa8dVwbpkzfXJ9dfx+nSzmyF9wyyMCew70gRy43tP43eXG48lO+AFL0bfRAkzfTC0IrPb1wcXUmMaGVih0DeNy9iSBiQb6i4I956v5t1P2Km9k1yMHQW5o2UKf7j5lcbJ0ICpvAb/bjLmwoyzgtA+0dPWYoY5J5A4FapB4nPoPClki8gngm2+pYEX71DJIutwfagboQplgB/sMv24ki+OykNPYRgyIYM/1y4FDWrMFnls694N0S3TMEQ8+RA/b9DZGHnf0bOi0+HAnSL1SGJVJy0wBAkjZq3dwwr+7CZNEnFc/jrJ7johYKvQ24dw5ut72L4REdl061zGm0GKH/pJnde1OkkY5pRxEim+M=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32758a1b-2e7a-449c-7967-08d7f2710d0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 10:26:06.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lwRRRAf6Dep3H90VjbvKeLzdwj367J6UeCcDStuUWgSnADPN21zrvrgtp1WfLoh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2874
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

BACO is needed to support hibernate on Navi1X.

Change-Id: Ia283612919e9a5b4e1e198ab2cc0bc15f7f94760
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5bd213f88ae5..e649a3d3fd7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1010,6 +1010,7 @@ struct amdgpu_device {
 
 	/* s3/s4 mask */
 	bool                            in_suspend;
+	bool				in_hibernate;
 
 	bool                            in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index eb351844e46c..5eaa5ea83d0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1260,7 +1260,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_dev->dev_private;
 	int r;
 
+	adev->in_hibernate = true;
 	r = amdgpu_device_suspend(drm_dev, true);
+	adev->in_hibernate = false;
 	if (r)
 		return r;
 	return amdgpu_asic_reset(adev);
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 8a0c37dc5182..f1621147db61 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1500,7 +1500,7 @@ static int smu_disable_dpm(struct smu_context *smu)
 	bool use_baco = !smu->is_apu &&
 		((adev->in_gpu_reset &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 (adev->in_runpm && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
 
 	ret = smu_get_smc_version(smu, NULL, &smu_version);
 	if (ret) {
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
