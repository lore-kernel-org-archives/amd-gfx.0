Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED71C33CB7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1AA206D7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 18:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p6HJtElf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1AA206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C686EE94;
	Thu, 16 Jan 2020 18:57:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14C5B6EE94
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2020 18:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvGHqJmIQHYaolOv06W9Qf8DY62VRUqpp6r7SUTdkKZbo7U0UvURpjiZa6Gbzhu+9q4k4MHa2CiMAPO+wqXm2cNNyvAVxce/4Ri6kz5Og2lpVv21Y7J8MVGX5bpcKVkvNhpssiXCvLVlidsbYJUaYU5prNR9t00tB0bT4wiT98nGzJBlCVLPl1b68MxBu9eLoJpzx/oUAaz7S0sWE85+ZPQQ4oLb8hbOtxxB4RQlHMWTKrVuLe/BHA1ZZJOEwlpJsT+/JQTR3JmdteI1Oz/l3mIskqUqRJOmP9ktUTCutGfeS4DwQYh9tKzmc9wQpEXa5wGZ7V5DNGy/lnr1XzFyVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDNfeKjulRy2P/1JD4/TFCqOyg8ob5DX14yFcblrq/M=;
 b=ghNua7ajI5Oq3ZHfOmwDEYmFSjEI/nSQBeIifWPYGy9WX/jqDkwF3eAIHUy+FVk0a86NMn3SDCmOD3POczJUiE/GzfS8fPXMecpxqFIzlAuT7o3fnXDnO1EpRWZp8GgVfwzIEX/SZp3KgAXtf81OLZ5ukp947IC/LCPrTS5OEIti3OpOiGnl7C2ANe1PjmA6WmKNDpOtShPLuLTw7XNByVGrbF2P/koL5czKuQYYlZ44g8bUmwDFnL9pFOg4BXKvV3iV3b2vQLuQ7MAjgY9kvHCss+AACG1B9SCJFqZN86Bw293HupWT2lQj4H63S2ShXOktVSuJXB2Dlq9zPGh3gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDNfeKjulRy2P/1JD4/TFCqOyg8ob5DX14yFcblrq/M=;
 b=p6HJtElf2rbD/XPBZid/W07ws8QFukn5oz6aiWR0oH9hSJfb1GGcimnKRGMxtr28Q0idAaXXAb+jBPJFa8ZFvVJ0ojgDnIjozm7Daw+GcteifvoiVSVDBrFIae3BcvazydxPDzF3Fk9Yqakx4jiveKZMK5o8ZtDDyOLfy6ymXAU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM5PR12MB1418.namprd12.prod.outlook.com (10.168.240.15) by
 DM5PR12MB1835.namprd12.prod.outlook.com (10.175.88.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 18:57:24 +0000
Received: from DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db]) by DM5PR12MB1418.namprd12.prod.outlook.com
 ([fe80::c8ba:7e4e:e1c3:d8db%5]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 18:57:24 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Likun Gao <Likun.Gao@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: skip reservation of discovery tmr region in
 pre-Navi
Date: Fri, 17 Jan 2020 02:57:01 +0800
Message-Id: <1579201021-7109-2-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
References: <1579201021-7109-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::11) To DM5PR12MB1418.namprd12.prod.outlook.com
 (2603:10b6:3:7a::15)
MIME-Version: 1.0
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK2P15301CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2665.6 via Frontend Transport; Thu, 16 Jan 2020 18:57:22 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 250297ba-14f1-4415-a846-08d79ab5ec58
X-MS-TrafficTypeDiagnostic: DM5PR12MB1835:|DM5PR12MB1835:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1835A13AD3659CEF7642D014FC360@DM5PR12MB1835.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02843AA9E0
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(6666004)(478600001)(4326008)(36756003)(316002)(110136005)(5660300002)(81166006)(81156014)(8676002)(8936002)(16526019)(6636002)(26005)(66946007)(86362001)(186003)(7696005)(52116002)(66476007)(6486002)(956004)(66556008)(2616005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1835;
 H:DM5PR12MB1418.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6AN4sqyMZjFh9wdJOZ7MPXWFhmfXbjwqbcx53rvHTgmOOySlMcDcuXCpMBxGilzz/orE7RQnakupyrBeja4CL1Vhxrt802bppLYw9a+kIGDFfyC87mkXqqKzQG+oDubkrq5mbh95S8orwUUqNcIszu4dX+jdHd0y8VO/AJXkxZlITEJ7amhAzwloV4H2gvzFoGfDanCNp1AuTmVxr5VcNBun01AOKs4WiQQbkQXHqw5B1ZlreSFH0y912wt9G7Z1/RDYvHOYrqvRo+7Sciwr6Jf8O4NsYGxs6Z3UVuDCkmcDDzVVV8c9yksITSyZReY8+CjMUzWoGYR1Yk6tsWP+GwT9IH+QyhXAsMnQcj8cpqSPoXBu7Bxjs+OCX0UHlgIRqFpo4dz/ZlNV6QV0fGNrvZHc/JDow7GgXX6icbSDwavTH1DIKzXHad+W7NDPK7S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250297ba-14f1-4415-a846-08d79ab5ec58
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2020 18:57:24.6063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqBsLoxohkb6EEzKAO/t0K9f/oab4EAF2igDqAqbQAm10WRzPX0Nhj4NqENr42BI6j5Ek3MPuBsRczuuaZLJqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1835
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

IP discovery is only supported in Navi series and onwards.
There is no need to reserve a portion of vram as discovery
tmr region for pre-Navi adapters.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 967f6d0..f21fd8fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1822,14 +1822,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * reserve TMR memory at the top of VRAM which holds
 	 * IP Discovery data and is protected by PSP.
 	 */
-	r = amdgpu_bo_create_kernel_at(adev,
+	if (adev->discovery_tmr_size > 0) {
+		r = amdgpu_bo_create_kernel_at(adev,
 			adev->gmc.real_vram_size - adev->discovery_tmr_size,
 			adev->discovery_tmr_size,
 			AMDGPU_GEM_DOMAIN_VRAM,
 			&adev->discovery_memory,
 			NULL);
-	if (r)
-		return r;
+		if (r)
+			return r;
+	}
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
