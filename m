Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE5EC43381
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70BC964F03
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BC964F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476366E09A;
	Wed, 24 Feb 2021 22:19:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E5689F24
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as2VAfL6tJsunHtSB9dK5AL7Zy95ehnNohR1unt/5T6bqPuuTcYra9gY2bTBahBgH+f+v6I1NYNtFZYSVk0pT9FLBJY8KtfHdKIpSs9TZMe92HWlzHhta4V/oaQFcrK8iMsWyNOOR3j/1nvI94v/i4/Oke/cLwc7vSP7fFZHdQZJL7p295YPjERvbeJeYl8aUyKgE6KrAO2p0oZVWnCTBwg+BVTIQ9k5bLsClRu1obqColV34ZdjYs2Ly3Dwt34AzSNPduX5MguDR9L0C1CSfeURIoU4dHVIySw97Dj438MFezUY58viKtcTiFpf/INlm6YqmSdd4ONJKEVR4L21Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0bhSrZwpIwDA1nWxAEpd0GDP0srhX1Yw2sPbML2Nv4=;
 b=fu1JgdNKV14FIZAmIRsVKZjbNAmBivL4eS70kFujFMdd3s2UFVt4M5N7NUFtYKv+5EKQYR+5vo7Ij4QkpZNVs4GyNMGjvWxmb0xSkx4DJV7bunQzTwAMkhQInOlC+tFzXcvl7f5nJ15tOFX7uFi5WkCVdxEb/c/viQZeo44bNKXx3KgWzAxSRNxr2j91esc/pimxqG9EO6arXQs94yy1SUCRMSs+uRQoVDYw/Ivd1+qDYzY2gzq+abCANT+LN+3I/2jOFt4y7jde8rceIe7p2yi//+hvJszUy6PpgUpz3VflaCnPU8zeHWzoQgyrjewvDU/IIoh0swQfwcORKxhNzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0bhSrZwpIwDA1nWxAEpd0GDP0srhX1Yw2sPbML2Nv4=;
 b=PnRnb0mS7BoCoj4kG4zX2qU7pHegIUwYS9VqpK/g3dkIItX/Yqk0l6LpgvgKthNk/XK01pznHLjNaEUce7BBVFr8oVsJOLvtQxeJa8G+IeR/6atlslKBwS6eQrEVH1pVSg4qp4kSgO/JeMTf4E8uRS9Q8leRPvc+wtcVmfKiDk8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:19:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 019/159] drm/amdgpu: correct mmBIF_SDMA4_DOORBELL_RANGE
 address for aldebaran
Date: Wed, 24 Feb 2021 17:16:39 -0500
Message-Id: <20210224221859.3068810-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc2590f8-a6a0-45dd-187a-08d8d9124226
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB417591AA324526EDC5E8C46EF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mb0gSQ69L75dDwMVURAJA9UgykYnCKG7dZCNrt6uLSrMbZ+bmGnSqFeCWBcBVMJznPCo8GH70jGyPz4iSP2xntx4Elusc6BMQmBDyzwQUDKiEf6hqAtgzyUsrtrUKx4KYUS4RiZ+Wf5T0tdlYG3+W0noFYZ2wYAoixOJL7Fa83kd9qTC361VG0HVKEMO3+wpTK+Zt6Np4HpDOFGJEjUBdWTxkTOQ87beCzO/3S5X7AkAQydv/7dH9jXBZFTc/aGAjq+OkBRyxYAxGMc2wSWXC18LX5AoJ8ldd9VsWSgbrVCyALu8m54fJPSuQY6g8Ji3tDmOxXQPvMAd2UO+Nsbegy7FY7shDo2nouPJKPwG3lpgPNzlNoIkYiae9x7F/TQ1juuJ1M8/uYq/6YQTIr+F0IJ7MZNXfrUILee6SBhwZPxuVKbHZoFmiCckjugbDI+zGBxlfpQZupjAbDeGZbezzob27RS+cdhEyeOvDEq5urK6ckxf262c3b8HpB8cmAmMRu2DdXtyTJ+cvyTxtc0EzZchkkMZS2TsunRy/MsVhieOA0MeCXYYiygfKNdLyUi+9gYV2VF44HasZISCTI1tzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?i6IydiYQdtFuXhZHO63KrjgUWQ9fmhGxq6KyoNazZdnxYvfzQjOB4A9Ma8E8?=
 =?us-ascii?Q?mcy7w5aKWfDi2mtrP0RQ0lTtl9jCB1+KUbcy0btBIJGkng556YjoWQD8ZIgu?=
 =?us-ascii?Q?Kmzcz1DxdracJ5g2tcyMzGw+PNsqwT69bg6Xz4bZplmNxIe/qhOuiG/8IfKr?=
 =?us-ascii?Q?+u0UAYI78HMfru4npqLYaVsrJ1UXUAmLa9oOONd3QEQB8ROcRFIB5kesERE9?=
 =?us-ascii?Q?AXIWs1fWTC4p/ZpopQ2PFUfuijek2NHdZOl5JEv2LWmhCyKeW4bho+/P5hbp?=
 =?us-ascii?Q?uKY+LK5B8JbdMC4f7LuG0FMfIHZCjhtKIpvfNS1R7GJBdnUKslD5ABL+SuI1?=
 =?us-ascii?Q?7WF6fALkiqAA8rHUqZJCFafosmozH0YZXbLqgc3nzf6BoB6wR3ca/2zFhMY5?=
 =?us-ascii?Q?d5xzR6kc2vDTbkblzjuIBYhO8jj9j6ufWXXpKN+vTtul2q6sLSv/tZ5+SSvM?=
 =?us-ascii?Q?nG5z994SeEagOYu6fsaFcC5FQRULa0Hjje3J1sNFnpITdOncoy+EE4mgDz0r?=
 =?us-ascii?Q?aCogcacKErNXZSKM+rbchVBrdqxAudvSvbw5RU9agaJDD2FvW5sCR8y2Svm6?=
 =?us-ascii?Q?umWKAha/dsRqfUHkX7FyWO4Qeocop7U1vCt2Pw8yrj4B8uqU/b8cgEEmRpJ1?=
 =?us-ascii?Q?iM3ChjB6qsW4b6CsMcERdk406o7s+EQVTn6YJLUbzRyMTbqu+Qg181/ffxbE?=
 =?us-ascii?Q?9p5Zpyn2Oooi41Fw89xsWKEoipHXgMlP88LSA5X4enxwYHLNfeCEOHEJBuhc?=
 =?us-ascii?Q?qKdA7xotWmwCMplqtodc8itL5RFtmaKOPBuQIkjU3cLIQxDLVrZ47qwjof6C?=
 =?us-ascii?Q?gZztV0HcmS/IH0s/BUWh3fK1AfgrhGITIt80+loYQRmzS+x3sBxXWL/IhNgJ?=
 =?us-ascii?Q?aWLacZYdyTua2DhqCR9MTdEaT2UQ7czzSS1c6MGQPv5fPCi+AnKf1daVO92a?=
 =?us-ascii?Q?j23V7kagvLKvSUBU2+/HWm1Ii1CBdgLCJeYoUnVx+6g3QSoSRbh3v5c0giRW?=
 =?us-ascii?Q?okMXgVc4G1yJrZH6kvNAtS7+TttZIGZ/SHFC/4d+fcGIsPkT71bfYSdyp9Hs?=
 =?us-ascii?Q?o2397E8ncO0qcGfcJeJpfWpisuAKf8gvWFRXem3EMd8FwnPVSoXABJ0FSl+r?=
 =?us-ascii?Q?bx/h87vUexxu8mGQ0ZAeiGGKyEtpg6CqWlcR0w9M1jBagBZkT+BYDqd0acYE?=
 =?us-ascii?Q?SlBugdlEMpBOVII/hkXNyVTLXBnh5GCHRNlBD2adKDcts7YRWD4q+dD9VszO?=
 =?us-ascii?Q?yESQabZRlpVtCJrBMSLIfGQzaT6TQY/nxoss8t6SnQeRYaoqjeQ4c33N3DqC?=
 =?us-ascii?Q?VA9WVkO1YXSvAAS0ET9j5Ynb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2590f8-a6a0-45dd-187a-08d8d9124226
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:31.7089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sINUuYvWo+yzChl0Xj1Pa8FK/F9gjIaKy8nWKYyHz7LkRnE2G5H4TOop+m/hOvwT5JdUI1CigT8Pp0o5aqn0Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

On aldebaran, mmBIF_SDMA4_DOORBELL_RANGE isn't right next to
mmBIF_SDMA3_DOORBELL_RANGE.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 4bc1d1434065..5332fed91cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -92,10 +92,10 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 {
 	u32 reg, doorbell_range;
 
-	if (instance < 2)
+	if (instance < 2) {
 		reg = instance +
 			SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA0_DOORBELL_RANGE);
-	else
+	} else {
 		/*
 		 * These registers address of SDMA2~7 is not consecutive
 		 * from SDMA0~1. Need plus 4 dwords offset.
@@ -103,9 +103,19 @@ static void nbio_v7_4_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 		 *   BIF_SDMA0_DOORBELL_RANGE:  0x3bc0
 		 *   BIF_SDMA1_DOORBELL_RANGE:  0x3bc4
 		 *   BIF_SDMA2_DOORBELL_RANGE:  0x3bd8
++		 *   BIF_SDMA4_DOORBELL_RANGE:
++		 *     ARCTURUS:  0x3be0
++		 *     ALDEBARAN: 0x3be4
 		 */
-		reg = instance + 0x4 +
-			SOC15_REG_OFFSET(NBIO, 0, mmBIF_SDMA0_DOORBELL_RANGE);
+		if (adev->asic_type == CHIP_ALDEBARAN && instance == 4)
+			reg = instance + 0x4 + 0x1 +
+				SOC15_REG_OFFSET(NBIO, 0,
+						 mmBIF_SDMA0_DOORBELL_RANGE);
+		else
+			reg = instance + 0x4 +
+				SOC15_REG_OFFSET(NBIO, 0,
+						 mmBIF_SDMA0_DOORBELL_RANGE);
+	}
 
 	doorbell_range = RREG32(reg);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
