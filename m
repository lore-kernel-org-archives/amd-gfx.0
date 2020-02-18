Return-Path: <SRS0=rgj7=4G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE06C34031
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E22D206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2020 08:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zQpgQb4p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E22D206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3316E9BC;
	Tue, 18 Feb 2020 08:30:34 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690047.outbound.protection.outlook.com [40.107.69.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6F66E9B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2020 08:30:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yxx++VXI/mVevBzFokN/jiJiwCYRMVzOW5sY0pbT4uYrpAIYNNTMq1tuTH8l5l0KGsZ/ENTVpZrSdM1xHTduTIzw1fodJQeP4GJxxE3X7SPnBKNpIB0s4/hERIwOagYU9QZScDkvHO/IF2JyW/rBRxIOGwsru45LfaptWI55rsmq7VxW9p3yHG1BeVP1ZMXvvMHV/WLzKMeklpjskHjDrh8kGaGIazRyQWmMJMBxpfUIkAXwmyjcyWrfCoBy3KIvs2bFIo6Jg6oxeJd9S2Mkc8sR0LsZBM793JubaETQU1cEdC7D/a5pOw6FgPMT6S80Yc6YBw7CK82MIFeNWJ67qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aal51ltAXfbvE6i4ZIpWTzVXHdGPNppzpJWCReQmWi0=;
 b=PXrOwLH8Qdn6ot36q9JJIwhE5QZJYoiQl/Rt/e4NdWPcq+ZZnCOkGEHaun5+jnW9m7GUDlmLCteHXh1FkyVGp6kN3OcXACidDrjJbe1uR55a/UbxhuvgrOkY676MuKT1Wy7GPMFASPpY9fYm7VJM0ZKvyGST51lv0kwCnb3rpQMADYlIVvaHwXdTQZujRoN3ncQeUsgUkC50OTrfVvmyYN14+AdHONb1mwA4ltkatlmnzIh2+J2e/OcIx4m9UUkqg5GStxdRdfKOc1+KRkLyEOoZHwo0SBwCpESywFrJ+2mgqOGoeBxh8911VRrVz/t680hAogSCb02Dz/Yz9IhCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aal51ltAXfbvE6i4ZIpWTzVXHdGPNppzpJWCReQmWi0=;
 b=zQpgQb4pfnj497ZcDZaeJP5OX2ajFPVFcVadHh/itiD55a6bADMcuWnli284y5sdMgHkJ3LhTNDjlhVen0JnijZIHbSbBBpfIGklmmT0les3G1HFh89W6WBd6Ze5THdi0BxItLROHIKnyUVfr6vR3S6x8aICLLHp/HVMiWqIel4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4016.namprd12.prod.outlook.com (10.255.238.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Tue, 18 Feb 2020 08:30:31 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 08:30:31 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: fix the wrong logic checking when secure
 buffer is created (v2)
Date: Tue, 18 Feb 2020 16:30:00 +0800
Message-Id: <1582014600-7147-1-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: HK0PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:203:b0::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK0PR03CA0104.apcprd03.prod.outlook.com (2603:1096:203:b0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 08:30:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe1c6c8d-bfd2-4ea2-bdf0-08d7b44cd10e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4016:|MN2PR12MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40165E9302035C754FA88DE3EC110@MN2PR12MB4016.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 031763BCAF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(189003)(199004)(478600001)(6666004)(52116002)(7696005)(86362001)(186003)(5660300002)(16526019)(2616005)(956004)(66556008)(6916009)(36756003)(4326008)(316002)(54906003)(2906002)(66946007)(66476007)(8676002)(6486002)(26005)(81166006)(8936002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4016;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /yGPsvfh6FtuT9HH0oD5DguDiBUxrhulg1tA0N1F3dhp3gOwyFjyNXAqZErM9lrUSXLkjvqag3Wb2gxqDsL2HxlvckykLamGIyg3JMnhmFupu+2hcJhQNSdFS6GIUxoVYBU7zCC6ypH92pOIIJEdBZ9HPpG5sdLfUFsvl6IM5+ufWBS+5+8BdYbbFdrtreEP0QmaWnrbpPDGge6onm0UGINDgvd2RJMaqNuDFRwY3kDUKDvajeD9tIao4NguGxIhfSdwIFMbMVwD9It/jne4qhXmIHlltHEZNujuoMTjUAWSMvWL23EF85mEGm6/uq3BwgJDO5Y1bSuyg+mLy2SnAq6tWA48G7V1IsYC8dk6TIxYIY8SqZepUNPwg+8tetgVXcNQhLuX4+aZBYZZ78Pusszd8LTTT+SSX0gmpn4GdBH+h4siLNFafoxfHzJnSMsJ
X-MS-Exchange-AntiSpam-MessageData: B+hNNyxji2G5b6YufGy8n9ghL0+sIRGsHk65xldsZfxZ7nwLSPhXIW7zYZcxoOLUsRSzJZ6+/61slxjzDbFJT8wM1KL603pPxJZH0NT9aIj3/IjnZxumHEXUQ2uQxNIpMRrjp6BUte1CjEyGrD71sw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1c6c8d-bfd2-4ea2-bdf0-08d7b44cd10e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2020 08:30:31.8080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq4/GWJiKl98OzNlqNY1n2I6Z1zD8XF3jhLJpYe/CgYb8iJfZsFNIe/vcYHDtlexPdaqxYClulXPwswQgtZp4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4016
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

While the current amdgpu doesn't support TMZ, it will return the error if user
mode would like to allocate secure buffer.

Fixes: 17d907c drm/amdgpu: implement TMZ accessor (v3)

v2: we didn't need this checking anymore.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index b51a060..5cbc63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -235,11 +235,6 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	if (args->in.domains & ~AMDGPU_GEM_DOMAIN_MASK)
 		return -EINVAL;
 
-	if (amdgpu_is_tmz(adev) && (flags & AMDGPU_GEM_CREATE_ENCRYPTED)) {
-		DRM_ERROR("Cannot allocate secure buffer since TMZ is disabled\n");
-		return -EINVAL;
-	}
-
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
 	    AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
