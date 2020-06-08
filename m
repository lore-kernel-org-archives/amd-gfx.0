Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313492072F
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3evb8he8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313492072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8F7B891CB;
	Mon,  8 Jun 2020 10:53:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B26689D63
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:53:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx8cltwSpu6XyMfkHw4BSUWtzljRm1QTKHCAa/FZo/iqu4Tnkmy4HiEDgbdJ+MCy3zqtHUHl7J+QWOYlBVxZPGG9xPDjPzl1hdNotjCcdFK3ZJPt2VuYnuwgBMLb6tG7fsiL5bh8eBGEvR+2Do1oxihY8ldl2qF00BQQAh7F4KxUHh2EhuHr0PmlvrWqk4JUliCA+n9qvYe2/6cxdMos55/wX0TaEJmzFh0sZCxCBasDcnuza29I78Yp1cQ5eUzytgurgDJ3MYjOklOehYtfd+1hiNIL/+FpGv/jMPNOYWtswCbcFko2dRS5UQeRUxLrdnyD2CZMpaa3dMeO0WEwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqGT8iHoTjo4DVjWLz8oVUob9l1LZoFlPl+Nq2iozDo=;
 b=dOnB9vwoyRjXmCLhQnPYLqMvI7DMN1jmuTVtIf9wdI/BUuS0YRIti5VUI2E8//0DETiIRGF6cHfeNoHo61MqRWj/RqxJDeLfuerPKGkSW9rhncqkrTrzklVvSf1crkSmr8DLXqdwI/CbVVbeC4fRn8a1Mm4DfXUn63HMMLd4EVPnGlKRwVskGb4U4zxEPUNiyZYoH+RtfjBh9ZwPiAzxVs77ukgpQ7QV2MfGP5fEZ0nLxNu3MP/y+NXYBLH+trhbeUV1rxioEShE2T9GvMi76WtG/MBXIXH17vjUI2o/EvGLOdHBe7hj2zVAvqH0+/Q6piWqyCMJ5Ym3F0Luh6/OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqGT8iHoTjo4DVjWLz8oVUob9l1LZoFlPl+Nq2iozDo=;
 b=3evb8he83nh2JCdRCu2Uihh8HLDuFWikYfEYgrqA0b2oorP5e9Couc/L+oPOCr4pP93x3JGZYx0SlBorZ8Xhyd7uztNcvClNUVm4aO5Kss3B51uyhkAnvc5F7wbRrm5IS+rxfgGBOw0aB+FoERHfa9thnmvVYUtLA/hJ8HvhZ1o=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:53:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:53:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amd/powerplay: correct power limit retrieving based
 on current power source
Date: Mon,  8 Jun 2020 18:52:33 +0800
Message-Id: <20200608105234.29864-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200608105234.29864-1-evan.quan@amd.com>
References: <20200608105234.29864-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0189.apcprd02.prod.outlook.com
 (2603:1096:201:21::25) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0189.apcprd02.prod.outlook.com (2603:1096:201:21::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Mon, 8 Jun 2020 10:53:35 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1aee995b-f243-4ef2-0711-08d80b9a3228
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546B2BEDDB2D95707A7F27AE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DtDX0lBCgkGM7mloLco2rF4kpghWwQqR5ioet6muVgKBJfj12mezPUw/gwhS62uDtwLuxUzUfmDukpZ/tppW1U/h/1lz0v4dZG2mTNtElgLS6irI4dVJh8kOecana3XVYFlGa+lMmjjlN3H3s9rBcU4Ue190EDhn9BFQaKMsPlbODre+Vz6E1tYSqmON46JhnofPhNvzM6rH6wnwUbEbdkVOjH9HFPSiqZyJszXZ+XEAjxs2dTK4XUIHIxCH2PtH+9ZDmL71csitAVrPUeP5Zki/J9wtIUCsTN8Zr8OR3Y8Qwgknd1cKKwBMGGzhNv5A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4744005)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(186003)(52116002)(7696005)(36756003)(16526019)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WdFZRr4ySyQwXwgID9VksyETPwEYaXAGF/Tin5zzRL8TF/pXewgeTz3mCUw9q7c175wRSiZZnYYpQMoM6vtBSUCy12rOwFpgt77xTIJfhlhwtsoI5F7NfBZXCp3hGUgc7EZp4adXTYeZDxkKElq5iUwD4OprfnUx7R2kAnUWP+uuGft/qeun3RGl7hOP6Uehkf0abijgca6HB/skVDLFoSZ/SxUSnOrv0nNFACTy2EHJcuGqr+HeckrfyELak4UhKcrQCijxgG0dMEPaz6516d3l5VK7+/EoMdVDv+6dXcXVgX5kJa2XM4J58Sw4/Qng+aXJrcNG1lBB8JlAnQDAbUt7D5+q+FSHxn/sssgCCBSqsXA/jWN0wqZvuG0o8ibc2VThI5lmbOS8Tr5osEgMnFM6wLwxBKOmizv2tuOJlfDHwkjnpuWXuuNu7YEhjlnh9pCRYeNqhzFkJHP4ievEUsH51ZzNXfjfpj7bzAlI7VapQPqCDURUQ06ptWBoyHXu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aee995b-f243-4ef2-0711-08d80b9a3228
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:53:37.1865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RG3sjk9GhStPZFjw47nWb7MV6cVAtI31G81JOUUyw96vg9tME3b9BJsK/3nGHvHU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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

Instead of hard coding it as SMU_POWER_SOURCE_AC.

Change-Id: I57066b2c206f8e1e2276f959ff2704dcbe6e5d77
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 34e9ae813000..06e3799aa923 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1065,7 +1065,10 @@ int smu_v11_0_get_current_power_limit(struct smu_context *smu,
 	if (!smu_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
 		return -EINVAL;
 
-	power_src = smu_power_get_index(smu, SMU_POWER_SOURCE_AC);
+	power_src = smu_power_get_index(smu,
+					smu->adev->pm.ac_power ?
+					SMU_POWER_SOURCE_AC :
+					SMU_POWER_SOURCE_DC);
 	if (power_src < 0)
 		return -EINVAL;
 
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
