Return-Path: <SRS0=Nkia=FE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A88C63777
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 07:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B25320709
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Nov 2020 07:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HC6rM/CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B25320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD7189ED3;
	Mon, 30 Nov 2020 07:55:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F180989ED3
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Nov 2020 07:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdmlWScCH5TAj5rjYkF5VJ8cWwfAOdoTeuINx5+fmv/9BnAf9kBkNviZq30SXIbtBDAxVfiiKy+46qVUy3JX/P5psA/2kXXcsuhL+5sYQgy5kIPIGCOwrFe8t/NynjprWeOKvDzUIzrmeL3PCXKnjcC4njTkXmYwpI3coiKgyIvJ1pFeCoHwmo6doVKyADdPITXPS23bLIxbHwCqOqxdRc0alasmrcaus/h9K6SpXjy8DUz/jzUqGVFUCNAhIZGNjKxso9K/1t+fdhIbQN8cj56rC3VY/MbV+WEkl+Zs/fvBbxdFbo3KA2/IT8bRDAO4G5c3rjV8uPnfesDlqUcbcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbmeDZtYEBOeRSJloJdaRDmLqkqbSm995OpDywg1pXo=;
 b=WsAe81GyMkIgXyozQgdsqo4P0saLvTqvnBy7JaTcZzU8eoQL45Rvkx20NPwBxituU1B1MSlshvAQtIuayDUfyjqG43EfgNmAj+UPk1Ez7F4uyatapqHqzOL2IKqqLt3lKTOTCCaDbKfhHJG/AEabUQilwNF84+qbD5TzKxFDAf5eSe/e2xFf+AlveROKXoqt9NZ7gSifCImO0V1jjdhKWOEygqjlT/VxcWCWSDjoTNWbZkzDeSoNmgX8g8RBiGRyrN0lTQB+9Sb7NWaW07gbbGtMEvk/WX/bv5bQIUsrf8LORE1JFgLN6TkiW113CLUCv2ZFoKjXv3YY5+k7wmVLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbmeDZtYEBOeRSJloJdaRDmLqkqbSm995OpDywg1pXo=;
 b=HC6rM/CKVA/RnI93ybFC8C23F6wUFxuJ83+SzIT49xQXW+/sEdX/80S6OBFlHufK5nl5Bn3eljyim9mObKxcj3dlKlcHOAAZn3ifKanX94nlZfDnRea6oVTzKOorUQ6fKvN3Ek24U5TLwQgbu6bHkOu8If7uc2ilD9HWJpAjcW8=
Received: from DM5PR07CA0097.namprd07.prod.outlook.com (2603:10b6:4:ae::26) by
 DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.21; Mon, 30 Nov 2020 07:55:16 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::9d) by DM5PR07CA0097.outlook.office365.com
 (2603:10b6:4:ae::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 07:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.25 via Frontend Transport; Mon, 30 Nov 2020 07:55:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 30 Nov
 2020 01:55:15 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 30 Nov
 2020 01:55:14 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 30 Nov 2020 01:55:13 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix compiler warnings
Date: Mon, 30 Nov 2020 15:54:21 +0800
Message-ID: <20201130075421.3118-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d88c83bf-d891-43a7-0d1e-08d895054634
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915871F200E29FE9B55968CFCF50@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi2HBFNY5JHIlzGGM61g2LYGEDZ/M1n4WqSFmKShkZ2tFpiuxFNCTvLpX/hVvOnvCAe7OY+LRVFLUuBqReO7/dxb/kX2vDsgxplVUR1eOLz+3MDonXPjkv8151KHUo9L/2qBdIIDF7oR+w0IFxJZwd9Q8wJnvBT5ojLkcRlomAXsC7LWSLAo/3QwyKkTvRCrscVuaNYgWg7dgSMwV3/PZxlC5JYTGpkL5HAUcpoLRXvcL86XJmFAxw5Fuvfw1zFUcTV3SY2o8j5/ru7ZmSA3mDojvVVBvIcdbKagTqIpwZroVrfZf2zBjhoKwfspbHLtjNU7ci1b54wFxCBZqraJGdiZO6rw4L/4VzJYBqkCjq6HzfBRl8Jg4ywp30m2ZP0UjIscggthSJbSHlapbB9kNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(83380400001)(356005)(6666004)(47076004)(36756003)(81166007)(336012)(478600001)(26005)(8676002)(8936002)(54906003)(316002)(1076003)(426003)(4326008)(2616005)(70206006)(70586007)(5660300002)(7696005)(82740400003)(186003)(6916009)(82310400003)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 07:55:15.7137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d88c83bf-d891-43a7-0d1e-08d895054634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
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
Cc: harry.wentland@amd.com, rodrigo.siqueira@amd.com,
 Nicholas.Kazlauskas@amd.com, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes below compiler warnings:

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5374:5:
warning: no previous prototype for function
'amdgpu_dm_crtc_atomic_set_property' [-Wmissing-prototypes]
   int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
       ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5374:1:
note: declare 'static' if the function is not intended to be used
outside of this translation unit
   int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
   ^
   static
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5398:5:
warning: no previous prototype for function
'amdgpu_dm_crtc_atomic_get_property' [-Wmissing-prototypes]
   int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
       ^
   drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5398:1:
note: declare 'static' if the function is not intended to be used
outside of this translation unit
   int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
   ^
   static
   2 warnings generated.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/amdgpu_dm/amdgpu_dm.c b/amdgpu_dm/amdgpu_dm.c
index 1818d9392..f42046d04 100644
--- a/amdgpu_dm/amdgpu_dm.c
+++ b/amdgpu_dm/amdgpu_dm.c
@@ -4975,7 +4975,7 @@ dm_crtc_duplicate_state(struct drm_crtc *crtc)
 }
 
 #ifdef CONFIG_DEBUG_FS
-int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
+static int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
 					    struct drm_crtc_state *crtc_state,
 					    struct drm_property *property,
 					    uint64_t val)
@@ -4999,7 +4999,7 @@ int amdgpu_dm_crtc_atomic_set_property(struct drm_crtc *crtc,
 	return 0;
 }
 
-int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
+static int amdgpu_dm_crtc_atomic_get_property(struct drm_crtc *crtc,
 					    const struct drm_crtc_state *state,
 					    struct drm_property *property,
 					    uint64_t *val)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
