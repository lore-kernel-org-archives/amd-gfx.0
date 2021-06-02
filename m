Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DF6C47093
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B7F761C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7F761C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E30326EDA0;
	Wed,  2 Jun 2021 16:50:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961346ED9F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haJGFPrRh9EvELRHmmnsq2PwvLCVy6sQbbyLRZ4LBQk/lgZBIxjNtgOfS2Hl7LOJGwiA6vv4HX4V3bi8+tcm4M/MaI7vzRRQsAWp5WESezopZ2ueKJFKOuBFdQ2BSVsPTTsqYgXYbNc27L/ylGvJvMyqWnl7IDNuF5s+9pL1UgNW6+iHjMJpfzvD6EwVXWC4DZZE3TTXqQNWslKh0pnQLRWOwiPv7ytfdUg5Fvz0iRKVjBUUhgL3DuexfnXsixwwrk66e0Kf/X24kxmHjBPFvumevjc1h1Fg/Gb72vG22yKaRg+M1qYSVr+llXYgJ6iGJZGZX0fhQGm8lDqpgeAh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0q2OC2xJCWJsSQKms2zLn3LCbgmxqWiLrqxpkVGw04=;
 b=dO5zeEkFER2b9i7BdzqLutwuCcoEH474o5op3Z0DO+I1GttC6Mk+s9f2jyL1eLgHDj2bP1stzPxHz3U9/YOxBLjFOV16hGiOyngJ1vKIrxp8Ri+7+nDra76JurZDF2zU4O9v40bJTk3B8Rx2N773vhz1MIf/zHNkdWkOz5M22ZJEOa5tsMtlI9LRGjwhC+jmrtyb2pipWOnqjghLmrgGyiKqSIifX0MTNb7tu2kR4evmnczh9dGeMrlZDx49ECAe7fRMP1EL+8MdXS9N//57tyyc0x2wU/c5kg6s3Fu19TmSTNKEUAZBjOwv2mT+tx7gAn/7QhNVjIGVnJipG1RA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0q2OC2xJCWJsSQKms2zLn3LCbgmxqWiLrqxpkVGw04=;
 b=ZbLkmXMLmjt634h2TcPXc4WUfxb70avA93F6rpztHpKSA8lYvh+y8IUb4mFStFPtqGODi0n1bPBsQBKuhqtu4w2Nw9QYqLEQMI5kcl+nRE1N+VHu2GOYHvFV9CBDDlPTzhY/NiymGMLMqN/FvVZs1up0VR1fCFxlYGSU4vve4Mo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:25 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/89] drm/amdgpu: add HDP Clock Gating support for yellow carp
Date: Wed,  2 Jun 2021 12:48:16 -0400
Message-Id: <20210602164908.2848791-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba33bb30-c381-4c6a-471d-08d925e67278
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45341CF61CEB81CDBDE4960DF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC3JVNPD3JOAmcSrOUtWPUKmXrC/f2CUwtucpRTBK3RomT1QhgoRbD+GmGMzjyeZtP2AoGwGCMvsqEzXTBe2KJl65AgmYsrnctYgmBV4NBU2l4FRL+xAQAr7ocHkOQ0ZQuTRVIl867Bdzs/CFF7QrW8j/uz1x6Yu4eCvi6CVXV/kGZHq0QTSkKleH9paYnqEjBb8qZw2AvUgsrAmXnw6UvSz/lpmW3oRaq5TFgYRuXRsOdON2MLxlTLfLndhogzMldrfsBx/5mnEbSYpTF2vXGnDZoisWRL3OnikVOgdk3zuG+w2OWcBxSRUxNmMQARtvyhE4O+Rwz592dvFwBoYgA2Dk4GCexo104kK9SaGt7M0YwJhU5yMu++9fMMVq8KdX/El2qC0rsBPL1rkRIC8k//YemtNYU1Yf8vEjQD70IRqjCowKQaY5NOD27Bido2kOjE42eICtcHhH3ToeYa5yccuHcexZcLUpW5h5UTt1hCZnY423C06JJqNnuElMzusgzGQpPC3+1QWP75L+yx9FEZU2DNun5P2XJPm1VLcFl131O2F7LOMjgJ2N+WQ6Fw6YUz1d8TEiFGKjlEEiSc8Aalj8XM8qx2wUVVZ+OTD2Jevk9+bfdQNCXA2HS1WL6TIKiEAA/vEue/7q36q0LZQExap5l2EsS9MInE3A8Ltm/51bWobZH1rAyM3LY2pI7Ib
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(4744005)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LRi1UObyWD/nmlJ5ET4D4YxFgNzzCC+EpktZo5rpeXGoAT0Y3vb1C0vWVrFt?=
 =?us-ascii?Q?kITHltVU5IbxuEw3FF8k9HoJ0cZzWo+h62IIBwUDH79rWk2aHosjFIjxRjvT?=
 =?us-ascii?Q?yykbLJvLU/eNKgBs34oj2HaaxrKeU5RDQAIQ4ZkTZ7lUPKSAgBCEJiQzRxcN?=
 =?us-ascii?Q?AT/pdAE4E+GCpKJwm+7bvxo5Ap7sFRjR4STU6zlOphJXgsMHstrNgzxUD0z5?=
 =?us-ascii?Q?0YNobdCFDbWyf5hPXl4p4rrTLCnmKfFfPASdLJBYqHgIjbgTtZWJn/MlqZFp?=
 =?us-ascii?Q?ZL+AMu6zCKiQKVqjBobXMreix3cAyWVP1qgtOEG7raNiIeyqI1whWKOmZU8c?=
 =?us-ascii?Q?TT6b44q6jfHcPlOA68X4+5GiRYBTQXzJh1/tEvEFCh8lKEHcgMLiNqKzqob0?=
 =?us-ascii?Q?9u18QjhKuEpORL4eBwC2L9WRTuXh3tCpE6WVUqAxqB5aLZ24X3f+nSxxJbSM?=
 =?us-ascii?Q?J7x3WMgeY5XBqMrRr7TzNMdIqgJDzepQuhIBL54IqMNhkrz+odMfQTNVG1tf?=
 =?us-ascii?Q?gKidNh5CnmC36B1HWqyYzmTi+Grq6FvMDhjlklFUCeTgnXInoV7fcFWZ1x0E?=
 =?us-ascii?Q?JdUrYUGXglAO6O65JicAvhe7AbWbw2eWNH9HeObPbhgT/s7mgV5OLXnG08Ob?=
 =?us-ascii?Q?5eBHBK0QfEDVNMd+NU1BJMWxPgk9tbU1ZLqXFbOQMQ/6bbuYi9n/ue3i3p7Z?=
 =?us-ascii?Q?iZxLwyWKlDm7IU5YeRPR8JmXziaYhrorAR/URdzPI/NHw1ZAHs66E9Os4qoC?=
 =?us-ascii?Q?ZzfDM05iPuAEQASwpvYKTL/ssK4i35Evz+bLcwx3obk4JMqVjN7V1VEDUfgw?=
 =?us-ascii?Q?PqQ5L2tfNlk/Qh8+2vj8Rd4Xm0SrnVLkGV+NyHi34W02XzK8gbbAYLgWky39?=
 =?us-ascii?Q?iJDv3VC7uzjSUAVPlL+M5oPqEpsuMRvpca+ws4BKC49WUWIHVAqembn3WP8K?=
 =?us-ascii?Q?mMy4RV+kxjt6v3vY38eanYpyz8TN4jEfA/REXj2vtRF2o6Bsnv901Zabj4G2?=
 =?us-ascii?Q?WA35/uJmE/WDd2BIHR24mXt0bJBY7s88Y80Z2yitBRALRKAw9A/b6oAreU5O?=
 =?us-ascii?Q?FYcGczIzFN3X11oW4ox34Dr4ACRtDjXC+hVoXloHVESv8vryPUhWDQc8Qca/?=
 =?us-ascii?Q?0l/j+PtFng/DXjmwcN4982VLrwjeW8kg2o5pNCRWfElMv09Lqu11BpKPg2CL?=
 =?us-ascii?Q?4vdPxVDK5unCsuW0xiIWnIRHT7Xs8hAINnu/xJVsy0OMCBHsQO2LDPY3+YwQ?=
 =?us-ascii?Q?fuKf6k8WF6TZaunI840sWb+8/2xkpUoPR91LJ8kz2wRt9OyOubaxd6ja+M17?=
 =?us-ascii?Q?Epvc0q08uxpEafeS0AtGA+sS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba33bb30-c381-4c6a-471d-08d925e67278
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:54.4867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeB3GESSx/f7EcVbhXZTDjua9Pef4NrMESa+Hrb8xP2H/PWsffO/xGhL9rI93kWNdomjv3Dz3p2gmXp3USOQiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

HDP MGCG is enabled by default.
Adding AMD_CG_SUPPORT_HDP_MGCG to ensure hdp mgcg enabled.
HDP MGLS need to be enabled by driver.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 3e20c40766b2..edf4cfa0ec72 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1336,7 +1336,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS |
-			AMD_CG_SUPPORT_SDMA_LS;
+			AMD_CG_SUPPORT_SDMA_LS |
+			AMD_CG_SUPPORT_HDP_MGCG |
+			AMD_CG_SUPPORT_HDP_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
