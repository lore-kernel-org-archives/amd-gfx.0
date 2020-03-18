Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34E6C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35D620772
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q85K0zOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35D620772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361F16E89F;
	Wed, 18 Mar 2020 21:15:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197676E1F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCDVkM99VxpBRoFFm3keMooti2jZwgOqppqFXmfmrO4sW2R/IIkQH3ES/vWIdcfVSSD41vlzGJJ+AOEtAcNIKSIy2Z5zQ8TacpNO2xzCTKmFAzg6keUm7kM0jDJUVElRU/R+hq5kVFu7N7A50RHqpwKlFs35qmDktK+/otJdr+QHhlyAcpnIS7yOKQodyR4pVFdxzTLRj9nWZ7ouL7AVdaQYpy2TsMqcS1kbM6Dyw3ILTZP6yfZxzK4o+r9qVFcyxt9jzGFsFaprWT6F7dkJQiqEqjIWOAYjknljaI5beT6NzB5VIvFDr4RBZ5xOntOZZPASYFx9cpOOkHT6SADWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMqeJAtyS6gZgUIzL98R5xmDTiIMGBy5UPQ/sOFYouI=;
 b=agfhr4/gj7/eUEXcPfT0K7y8XTW/1CCbu9+UMozgYoJ4DdfaMT28/ikIfh2uhjfuFwu6ao6SZTwoogONmugDwu6yBqwVT9LKt9UXdv4z1JoBrXfI2yxYCesTYaW96ed/RPFDVWi/Zj/1ZVLPHHQyZDTwhnXfpEDrrfCanh0DIxxKUslDKCHVE1plDBkyNTetWNYZ2+qWPz00jRd60aWSSm0vQN61A51IcgICT/iR8sr4advWtgR90VrnidqG2JX2SpevuM/AkDZ54XscGGEjW/gm42L7hv4YpR0Gkr4ylpKL7/taLQqUTKv9GAxehF6V3F7qt2Q0q8hZfBpOHqaUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMqeJAtyS6gZgUIzL98R5xmDTiIMGBy5UPQ/sOFYouI=;
 b=Q85K0zOVznqsoZf/mpDjcYt/M3QILATPR9mL1Sb/dV8enwmzXjKhIa+UJp6FR5TKb2yBmdw/gNjG2rxUINUTFYNuW+mRfvA057MI37DXH/vjS3QDx8HOgcGmfzz6VdLpMw6ugfkH/d9K4r9QZ2yqzIvyVXlBq2aCRhd5ZxGNzbw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (2603:10b6:a03:134::14)
 by BYAPR12MB2998.namprd12.prod.outlook.com (2603:10b6:a03:dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 21:14:53 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::7827:1c37:4c53:b74b%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 21:14:53 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: fix typo for vcn2.5/jpeg2.5 idle check
Date: Wed, 18 Mar 2020 17:14:44 -0400
Message-Id: <1584566084-23428-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
References: <1584566084-23428-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2835.19 via Frontend Transport; Wed, 18 Mar 2020 21:14:53 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 922d4e0d-6ee5-4708-cc37-08d7cb816703
X-MS-TrafficTypeDiagnostic: BYAPR12MB2998:|BYAPR12MB2998:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2998533E61AD781402F879B4E4F70@BYAPR12MB2998.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(199004)(186003)(7696005)(66476007)(52116002)(26005)(66946007)(316002)(66556008)(5660300002)(6486002)(2906002)(6916009)(6666004)(16526019)(478600001)(36756003)(4326008)(8676002)(86362001)(81166006)(956004)(8936002)(2616005)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2998;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UrT2cxSOG6r285UwvlLbn2bzPUSQNjzvXWNABHAgLpxf36b5qy6i7kusoSF/RnzfOiXEiroE9eycNx6LnRHdOAmosO6SW4QbHMF72YZ3xpiUHPuOhuS7KPKoUy3ev8a9/U5oopC6jpKm/zSgpGl7pGQSmuXaHvONl7hygSo5/uq3HE6lLDOK78gfmuH9b2O1zsXj01kA81XIfb+UfviKIR/4DJU5Drr4d6FSLEv3LEFJ7UZVQdycj3sMm6tBTxVO5Z+AxQBhaYMe/p6KPqQzYF1Z/5T3jYLmG0/NiYOEca5QKHG+KWAHxZeaRHUGZsbGr6J3DspbGY6B70g9xP89qUBVktUEKeYPA5xopXgZBtKQBsIo2Z22tR0OkoTTFvSYrbSulAJe+zgbSOsVYtMynrtTtmA+RM8x/GKGMs+OhoKoeyeQM461vKkKmbfvILEv
X-MS-Exchange-AntiSpam-MessageData: 3tXraCNIFO+bEAbSKE5MnnF9JHXAjQJknPT2QOPhkDaYGTHaMOX8uyVlSc2rPWH4ikdvcH/ql/z7gaUiVXlr9yDCYkvdrCRjjhDHTxIAOw6JBnNbagCYEOCyiDq5urz+OSz91GVNvX+c2/q8yQfY1g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922d4e0d-6ee5-4708-cc37-08d7cb816703
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 21:14:53.7905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2c5pspWkn5MCXh4a5EdVyrsaT4tjsFMV70JS7mu7Cd6wl1o13eq35M/wAR7I1RyD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2998
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

fix typo for vcn2.5/jpeg2.5 idle check

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index c6d046d..c04c207 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -477,7 +477,7 @@ static int jpeg_v2_5_set_clockgating_state(void *handle,
 			continue;
 
 		if (enable) {
-			if (jpeg_v2_5_is_idle(handle))
+			if (!jpeg_v2_5_is_idle(handle))
 				return -EBUSY;
 			jpeg_v2_5_enable_clock_gating(adev, i);
 		} else {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9b22e2b..c6363f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1673,7 +1673,7 @@ static int vcn_v2_5_set_clockgating_state(void *handle,
 		return 0;
 
 	if (enable) {
-		if (vcn_v2_5_is_idle(handle))
+		if (!vcn_v2_5_is_idle(handle))
 			return -EBUSY;
 		vcn_v2_5_enable_clock_gating(adev);
 	} else {
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
