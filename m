Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65485C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 00:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBF220888
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 00:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VLD6a1SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBF220888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C307789944;
	Wed, 27 May 2020 00:57:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B66F894D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 00:57:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW0IhuIM1yeawvFS/0EmU1ENsSZVeo++2kW1BMbY5jRchcW/gjJ5nnq5qYH9PTmQ/YKTe4IQnfDV2nbT+xVqpzJjdh9ZYM4w1Gtdrxt2JiiVezrYSblRXuNBwvlHVSzraVFJ7jowsJceyKaQCdbP6hy5Iesqtxe2Ltg0wOQUGNzydqZ8FZFJMLSdYU9lbXaGPXiRkKwsZfU5vs1IQnQ7ygNl3XlCKEkOY/08H1wIUlnDI9E4pqZWGWEyD2kmISltlUS/qaiwcQq29aysq9AxR2wpbnOunzDEf7XljMdrrGetnadctPVQ8qeIe6854SE2Ew36TM/NNPobC7OG7Nzk2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phraes6IF390OBILT6ugsMt7QnP9NJ/PsyL/mqETVVo=;
 b=KCGNnEU2wAqaeCcQXqIiYA+L7+iiwkzHEzh6QsbiK6LEkhf2MJQqQSB31iUN8t4WT2NIzloVprgyxtxzbe0YNRHb8uNqoHgH0gOhsGEnbeBdq+8Q0yhKYjp/YCMuxCiN/EpITMuwr/L+zG0EEuy32jBJB4Grf6zbD86BrpD3GWnM7e8uJ4O7yf8TldBSFeBFtMP2CFmhQ7PQn0OT4KGzFmfPSysF9HqWwXfx3tbnveTN9AWPhZFHCF4VZarpIht3tN8RGyodRIBSszd5blyiTvVvp/ksh/C/JMeiudrbKXREg25nYJFPOImmI0Eat8yWEFVEk5MdXhvIDUwSEUCahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phraes6IF390OBILT6ugsMt7QnP9NJ/PsyL/mqETVVo=;
 b=VLD6a1SSCuXmOFn2D14lPlWjsbv1yPhWy4KW4ids4R5zpDe+5riZrcVoyp3pp/plkouAhx03f9DiR6kmRnOWItRl+cOVqwTxv/juA9g02Z7tj+ilXhYrBgNsjI27sg6wtzSP75MI+zJSluRUXA7STRj0ZdMv0VGHuVTouyrWfSU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23)
 by DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Wed, 27 May
 2020 00:57:48 +0000
Received: from DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a]) by DM6PR12MB4482.namprd12.prod.outlook.com
 ([fe80::e058:9371:1bd6:9b4a%4]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 00:57:48 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Improve the MTYPE comments
Date: Tue, 26 May 2020 20:57:36 -0400
Message-Id: <20200527005736.29308-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB4482.namprd12.prod.outlook.com
 (2603:10b6:5:2a8::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 00:57:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d77e799-eaf6-42f7-5a0b-08d801d8f961
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4436AD22995CC9BCAEFF3215F0B10@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U3JkiZ4XS0JO1xJhKBsF+XsRjD2AK67MnrP6qNirFf5x5KNHkUDwItU2x6iGmA6qmuzoW2dKXDRy3bKs4Uw2mxbH0d/FU90h2/C2wiuvaOfhH9PxIZEnCMQGevOSlNeHIDRfBqHatzDVb/AidBiAFpeIjITWoKOfBI1c9UfPlIwWgweW2JP/gHna69+Nw1A1/YJW/35g3fpj9sPowO5f3kKiBzOFFYfM/O5C32BgeQY2hn9anuqhb+OrdyZggDfc8QYHo75mO9YXEUKtoXwNuwuzLGiXdGOEZBHA0fUIn74rNQ4b7L8M8govDpBh/rriFEzOSGEszgQBPdejUwSFwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4482.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(366004)(956004)(66556008)(86362001)(66476007)(478600001)(8936002)(8676002)(4326008)(6486002)(2906002)(1076003)(26005)(6916009)(5660300002)(83380400001)(36756003)(66946007)(2616005)(186003)(6666004)(16526019)(52116002)(7696005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DgoBwO+HuQ8yVkt+4YmOVNBVzcWK+qqhcKg1GKHHWBZEnlEjEaGDfDQGv9hxWGkS7jeajgq9p2QqOqPalm1Zhyxw7nMvTMgA8Ja8S+6u1Mg2h2avp5BAchHVTrNBwXHyJnRFrV5L+19f7QEnsLS1+Lnv6RHbSuiRVvpugxCphGf2QKwTentrKydJLc+zioPCFPloVb7NWTrh3Ds8F5Jccek8VVwCH10kgToRonxEQJaVUuALTX6Dw0nCtQgMvWHzQe1Kj/pH+8vXPUag7nRwIPDaADOQnHhbizaQLhJWEFysseZvsZqyeU/NiGyhNxaT19xhT1br9GZuP9hlhO4mUQ9Dacj8q1AI/jGCyQLCi2gbObTKKVJMpAwBD9svkoNQKc0/3IQUsT9BQ+jINJ3OQJjvrMVOMjtDHuEMfT8UNmgW4aBE/y48Pme2d0E7nCF9FMH+b+EoLWrF616pfeoBDgn9NWwIIvkwM4OCvr93uRnhvNlKbu57VXhEjBSWw9zC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d77e799-eaf6-42f7-5a0b-08d801d8f961
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 00:57:48.3167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJDxnBKGeg1e3L0/fvm5l9oyuVNPy0JGw8R4JPBX/TXN0YyNgLP2jTff40blrIfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use words insteads of acronym for better understanding.

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index d65f9b4ba05c..0072ddb59747 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -564,15 +564,15 @@ struct drm_amdgpu_gem_op {
 #define AMDGPU_VM_MTYPE_MASK		(0xf << 5)
 /* Default MTYPE. Pre-AI must use this.  Recommended for newer ASICs. */
 #define AMDGPU_VM_MTYPE_DEFAULT		(0 << 5)
-/* Use NC MTYPE instead of default MTYPE */
+/* Use Non Coherent MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_NC		(1 << 5)
-/* Use WC MTYPE instead of default MTYPE */
+/* Use Write Combine MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_WC		(2 << 5)
-/* Use CC MTYPE instead of default MTYPE */
+/* Use Cache Coherent MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_CC		(3 << 5)
-/* Use UC MTYPE instead of default MTYPE */
+/* Use UnCached MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_UC		(4 << 5)
-/* Use RW MTYPE instead of default MTYPE */
+/* Use Read Write MTYPE instead of default MTYPE */
 #define AMDGPU_VM_MTYPE_RW		(5 << 5)
 
 struct drm_amdgpu_gem_va {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
