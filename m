Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3708C3A5A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69C72074F
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iiUqLnL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69C72074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601896E5BF;
	Mon, 20 Apr 2020 15:27:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1343B6E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:27:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CENSyspyJX418F6+J/c228yoO0owf7blYESv9bOD/R5kDkSa8Wx4Ac++M7aWKO8vOApos5rNtfNRLy6w9MxMy2aeIqXIrakmOBFhB92HqfmDwmksci86P9Gk6QGhY0chzmG14Zwa1bhdrmp1yUCWomJEAQEg3oJxyfMGygVmrWDayE3WxWzTM3pDuPgbFSPqqDv8vfO/IeRYpyyFu2LJfagUbgjpzZOQWspjFhYxYvXpNlcfDJEveLc3ejZP/FQKWRdP2j2tvBs5pIyk0JfM+w15c6m8YS4K0Hls+b118qXOGBmk8Srqnp87JP/qdsgTdAQ4kqNiUJ22CqNkWiiXug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enHCHNnrBKMDboU4RHARUoULb+sLw4i+rzQWVyuJUbA=;
 b=PZ7ufFppdhmAhBJSIx2LDftuAWO+ItF6g1A5EnYwKPOUjdChxpTD9CXqDBwxEP6b7gn+JTOTkNgeqB8w/qi9ZEKJAYMrAyRqFKFJIwPX6l7TRaBofgoajtM3zLsUJVEg3Hruw7FBMTnyEQgl3WGwlDKXVzGkhDZbe8I8xbuey8L+nxC/i/WZ6fXa/GIvIubcdB19BB33JR6hZQPT2epe4MPTbrHOZU3kqBVCDBRVDu/BLIrnRyRFwgTgUBmrRKkm79EAWaJYjYFk/PkDbOaL2OiLnM+k5zJdY6uz+SL07lleND+G+fYXumNU+sX/Gg89vCVE4R7v8u8Pzrbcvk6HiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enHCHNnrBKMDboU4RHARUoULb+sLw4i+rzQWVyuJUbA=;
 b=iiUqLnL2aw/it5KRvKpl9+0OicA/VXjZGkk0SlyKMmmlJ9iMfamybMoM2icnS72RyDSyrjNTWuJc7wS1YDOxBOiZ4yWV595mh/av7SkRXaNxxataycMWwZ9czQ0iKB3HXqftrVuWhgJRSx1vYRUvEd3/hWo6T34eXMiktkGekCQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kevin1.Wang@amd.com; 
Received: from BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 by BY5PR12MB3953.namprd12.prod.outlook.com (2603:10b6:a03:194::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 15:27:23 +0000
Received: from BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1d43:2e08:259d:67ae]) by BY5PR12MB4068.namprd12.prod.outlook.com
 ([fe80::1d43:2e08:259d:67ae%9]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:27:23 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: clean up unused variable about ring lru
Date: Mon, 20 Apr 2020 23:27:06 +0800
Message-Id: <20200420152706.37360-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.26.1
X-ClientProxiedBy: HK2PR0401CA0012.apcprd04.prod.outlook.com
 (2603:1096:202:2::22) To BY5PR12MB4068.namprd12.prod.outlook.com
 (2603:10b6:a03:203::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-laptop.amd.com (58.246.141.233) by
 HK2PR0401CA0012.apcprd04.prod.outlook.com (2603:1096:202:2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend
 Transport; Mon, 20 Apr 2020 15:27:20 +0000
X-Mailer: git-send-email 2.26.1
X-Originating-IP: [58.246.141.233]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a584b3df-504d-4b7c-ff80-08d7e53f5264
X-MS-TrafficTypeDiagnostic: BY5PR12MB3953:|BY5PR12MB3953:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB39532303D000AE8F1659506FA2D40@BY5PR12MB3953.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:39;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4068.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(2906002)(6486002)(8676002)(81156014)(478600001)(6666004)(316002)(26005)(52116002)(7696005)(86362001)(6916009)(2616005)(5660300002)(8936002)(956004)(4326008)(66946007)(66476007)(66556008)(1076003)(36756003)(16526019)(186003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dn2MiepSN65nOn08yY0Ni5XF+WwNr4ZvNtyWGU45X4ZUCpT+jp6JEeNbQbpkk73iUwYJ1MXawfYkUrgfT68axSe/vl8sHLF/4Vsm4g2TYYytlXQUnmFmvMPQyOFBKlCqS/YgHvf3hZ21kMMQTMIhUTEMaY9tC+N6FrFhTQj0GTEqEsorYz1rUm/slGmBonGYTolbGHLd9d0UKCdvJ7jg/GRk6DDu6Zt4xE2poXNP5/p4SQj9sRHp4u0sbz4c6Ni9D7emWVCulsg8YHn2lAUtq7/9eIhWKPMBLKJCk1uKa0MCitM65zFWjyLgvKudDSiUXiiZFYxbw9N8SF9ZWWFyydfqGTJFzeOnrke0OaJeOpa3co4zpSAIGqPXj07va1gaDO12PSLfFrh7P/B+ZULPhA8bwgy8/Pqudi2kh8a4ykYJo7T7u641DWF40EnqzJrx
X-MS-Exchange-AntiSpam-MessageData: anyyvF8yrKTTrTXGaYZp7353SA3SDmESfGZb3lnrKHM2MRR9Em9Aas8uUZ1IX65WLPWen3k+u6ymm2cQZvFk58gGEndlcxnSLtoz+hm18jSEfCyERPBt6XKut6e1JwZTWBhOlNYuJj5nE3mlxTdDwiCLnQabhFHQuruqEgXUZN3Nsyg+W3lY5fMqRYJK4DGWzYeVXIYL7u3e8rqfm3deB9tM74ecKORL/cdwN/45EQ/ip3zFHWvjHOmQeHeT8Ny0gLVXSNxE0EyhJfu602Aft9d/9sm66ATHVF6rGWf/6Yb8GU5h5eJFMMG7BQLsZZxwczS2f8GW1U0wz4IDHaj7e6SxQreS66Y88im5Mot+qGxqNx65MQNwnzA/G+Z4tlzN9zv3fv+JHML3DgzBNLwpZpppOIMbDxbdJvTXfWpprvdP5LmthbUEyVS86W7UVPPQfficJQbF6P9ImyJt5Z2mo4N10H0IorZ92docQ3lpudGiRlPTD4BG/4aBepiMAgnQsAY/+CMRQGgbFs6aZEybKUGIP8lzdLN0ZbT8m8N45NhyNmgx+vtF5QOSvweUBNz2bRENin4AkRWJYXXo+l1r+4EplcIqNBh34TB2ycG/E3QEjWLX2lcrV26dNzbm4B8hel8ow0m9eHcbUkEnmsD7mWBHmj0m7SwMRDuCAoHtO9Vpnd40cPITf9zE3v+vY66kf1oYZcEx3xjdNuIYPxdElzXMO56F8X/1FQKiti7K+HLs4woNsX6h3lPS/Oi/xQh+jrBjZX5lsQ/wJC0VjWYhpn9PKXwDUfV5k8rmuQmdv4U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a584b3df-504d-4b7c-ff80-08d7e53f5264
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:27:22.9970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guTrCJBYx4jGdmUyv0TgBPCniyMkTGMd5Rc2JbBJnp83vDZChpAqSuRhaFaYdeIN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3953
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
Cc: Alexander.Deucher@amd.com, Kevin Wang <kevin1.wang@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

clean up unused variable:
1. ring_lru_list
2. ring_lru_list_lock

related-commit:
drm/amdgpu: remove ring lru handling

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 94dff899248d..e8ab3dde6a66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -953,9 +953,6 @@ struct amdgpu_device {
 	/* link all shadow bo */
 	struct list_head                shadow_list;
 	struct mutex                    shadow_list_lock;
-	/* keep an lru list of rings by HW IP */
-	struct list_head		ring_lru_list;
-	spinlock_t			ring_lru_list_lock;
 
 	/* record hw reset is performed */
 	bool has_hw_reset;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71ea56e220ae..38eb736091d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2990,9 +2990,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	INIT_LIST_HEAD(&adev->shadow_list);
 	mutex_init(&adev->shadow_list_lock);
 
-	INIT_LIST_HEAD(&adev->ring_lru_list);
-	spin_lock_init(&adev->ring_lru_list_lock);
-
 	INIT_DELAYED_WORK(&adev->delayed_init_work,
 			  amdgpu_device_delayed_init_work_handler);
 	INIT_DELAYED_WORK(&adev->gfx.gfx_off_delay_work,
-- 
2.26.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
