Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CCDC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3D2861C46
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D2861C46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63D336ED9D;
	Wed,  2 Jun 2021 16:50:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297456ED9B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNgs08Wb93jZf0poGeo2pVv29rqVy4p75voDNlR9UPw17YaAwCnQp2o+BAhq7nLLGT9xA0ajjduDYJXDQNUjGTpfjHHj4gmeDxEZICTNFNyGIJ3qrEdH+ryWt80NF+oWCiRtyCyy9ceBRPEX5PqDPWR3T4AYp2sylUI37wpcgilP4kW6s3pWHUzPBQOskMtnWTOj1FS0OOJBt39K3arZ/yhqLTNVBBtc7gyFx+6rP99ORn99U9s1AkrwZAPvBgdTJanGbx37cP0QwX9ROuyQzTnpz+1jczbS08McT2VNZYxOHNm6kaxH7OKO4V36NzwM/rHvCPZzahuWadIoiCXpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoTJgnAZ5mvLbZyVja0KuUOGR2gbArp4veK8GgNpvq8=;
 b=J0Q0q3sls/Ph4mNVxe3AAsrpmQbumfSqBaLuahS13/jmLCXovju8A0OJxPWEMA3IwZ1fcmGTkiPjd9WIIJWHveOrQukzJZXFwfGiZfrx6mXvI3etnG1pIALaco/d5PiIig/u/Y3txlOMLY3J4yy/GP2LvvCjCo/hrWQ5kpoMyyTCQxobupxo9eTSw5WEel4hZfwR/Q8nHm2hyfLOMiVG/FRnKZiEiGy/AuJPqJPB4InU2XRIQWtN+AR6GMubziGDBrc6ql6wgCHz2vbvYyo7r45HKGZwCzhdUUTrGQbTokZK4a3k+qAt9LMq5xqbg5GAS6VLlIaDSGLStcaaEYzinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoTJgnAZ5mvLbZyVja0KuUOGR2gbArp4veK8GgNpvq8=;
 b=S4X9FHmYBD7+WvDbtJgsxCO7/2qs0FNk/gjuxiMwRuNRgUPxrpaUrROD0Xac7kCqWCjgqyf/HX37PDtmB5yuZzscfYZbENbXFhZoopKKHEDd+p3LSK7W2gw6wfU2zPdKs+H6B18RMZYllV1AGcV5QUNh+lIuXLmSwxVQBD/H6t4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 16:50:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/89] drm/amdgpu: add GFX Power Gating support for yellow carp
Date: Wed,  2 Jun 2021 12:48:11 -0400
Message-Id: <20210602164908.2848791-32-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a343d8-b4fa-4c46-de5c-08d925e670a0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4675:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4675599BFF9238784628FCDEF73D9@BL0PR12MB4675.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZOWkoB/2OxF8e5MRTLyrTtrSnNQ10Cdl5B+XT4a60FTyRG4/fm2KWnJj4r3FSCEUE4T9amSC3KgU8mywAJM/jQBKcn7EqydimWPmpvfCKvpCB0E+SE2VDkL+5vY25waF8PBKoPq1EApM1t0VgfPON918UeW6gxijvb+8Spd/eyH6cgU2pctqVeWVM/iE8TB93AhdFG+GnqOOR1mhNvGH1MxE+qQfZCzyKnADUaB1V9ipBxpl/BVeafSoNVUQ+T+DYo4JeaZuof9s9WXqd5k5wVGFzzP7a7QcmtJyCw4LppywLOmqX1EvO6nBFtozhw8Le49Al4u6kpkW7HdRDRGjBJFY4yiufyQRf0pf2vmbyw8r2liXqeNhzoZ2Q9p1KygTcpZCTnM3hFIPxPR1wdBekdnqC3ZP0zstgqm8JRsHk65QEP2ZXEePwKTqqyme93t5V4z35iE8uMWIcRv4qbTCXu/YlCuUl5SdKji093ajZRkFFl6pLpGF4A0f1tineR1qUwmk7oOzRBEiY7loYEjnYTa0m5TFpvW4qVJ4v+0sauaIhb6gmi/IHah1fZ6D9tspPoCoZjm9xJ4VyQeYBmAa+Ubwl2VLkMcRemWHbNXFPzKxmMiRIZDvANFkPxfh3yQctc0i63Kbi+xKhqiEiiWwqovTUUaOIZ0yO9QePlogJhtuNCzXuVZrjnB9ls8FoKy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(52116002)(6486002)(956004)(6666004)(26005)(5660300002)(6506007)(2616005)(36756003)(4744005)(6512007)(478600001)(38350700002)(66476007)(66556008)(83380400001)(8676002)(2906002)(4326008)(86362001)(1076003)(16526019)(316002)(186003)(54906003)(6916009)(66946007)(38100700002)(8936002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0K9ABoJUtockTJ6XUPYmaclT5t1D6sNhck/ZTeoNap39P8OMoOk482ONqlJq?=
 =?us-ascii?Q?aV+hcIRjzo+Nk9SvNFVYoktwgTNa8KOuZRYz6MFWr64lB0JuBJoMUkg/hIk7?=
 =?us-ascii?Q?pbGejkQBHW29ZZwuWgvIahfuA1SpNxfFrUbtKpdMiCM7v8Ki15T/VFcOrLXz?=
 =?us-ascii?Q?L+UN9AJFH5fzFJfaIlIGQPVRCkmzJ0yLFdQNtXFn+lnmwzJyz8bHmjZeS44K?=
 =?us-ascii?Q?inXn3UT4Zq7WHvKt1yf70OBMDwFoO1lihGIZZknO98Tgjvd9EQAYVag5rXjw?=
 =?us-ascii?Q?hEyaAqP63Tt63RaRGjnk836CRt28exiRARpAOCf0S96TASHUjvFSARsrj7ls?=
 =?us-ascii?Q?OX71+lW/tQswa12UO5uAbyLE+7P5ZMfD8YK3QLsJF87uvPNuS03djccTvBw2?=
 =?us-ascii?Q?yxz1XHHhCEdCx/4w49boUT0hI5Av0VhTmqQGNDQF9CeIg76HW5+MhntCEgdU?=
 =?us-ascii?Q?Us5JpvzMr0IlVlIJWYXyGETJC5tJJI00RYQzE2wE2Cadu7Wse28etv5TYVWi?=
 =?us-ascii?Q?NAFSMcL6D5pY7y6rw+uognXKlwzis66hKFCy2a6VPesY7rtKXe31BcS3zjea?=
 =?us-ascii?Q?Zj/g7de9JgK7s6O74615psynYgnJ2beqXUL25q1iU3o6T23eyM4xd5hTZ4JI?=
 =?us-ascii?Q?Nc1hyPlE6hvS/vJoh9Hw24xDGjyRAAyuUhRGDxjaeXM75Mypx6bTbJU0hl89?=
 =?us-ascii?Q?0D3HYCgQq5IkItrazIIojAV73e5+x7i0dbqP7L5CzvRBjneHZ0BU2Xe2MXQk?=
 =?us-ascii?Q?d5fH9ljFwpzi1TRYYtn60t5aqvR/cQqQRoL2XnvWtb/b6JWlnyjFL9Q4JlS8?=
 =?us-ascii?Q?APalcfsBr3H82K5BbOj9ps54swDI3Pu2tAITjRo1IGMaZmkuHMcPE3Wyzscy?=
 =?us-ascii?Q?9HDlXrWAJSnfST78BHpEU27OHyAwMDDiyqzbdv746hEsczI2SUSvrd0eQlBT?=
 =?us-ascii?Q?Ir5Di0EsVGMqN+PPcb/ulF+W5tL/AzA1QDXW/NiWLxUNoFlVmWdJs64vaIh9?=
 =?us-ascii?Q?v0IMB8gU3goZiDB79SStslZauCmsHnp9eMZlEBnDEMQcKHUrYsas9ZEsJqJm?=
 =?us-ascii?Q?5OGmpQVQKBjU3mlUnY8ZTJNjvLctcmqfVtWtFtUu035gKJSfX+EEWMJGJPaf?=
 =?us-ascii?Q?0vzP6QgsDM2VclxleZ88xUNke2lFih6YbcRYqiYuN7PIGifFUrczN+FdvSvk?=
 =?us-ascii?Q?rNdXXQZaimx072hzz25qJV8tpQ05CL1yF2xiaKgE+Ah02jLB5ivINTVj4mcK?=
 =?us-ascii?Q?KM9SydoQqoZqbHxLYjBsAu1oULw0/Hdqnf5YJY9uzE3opSXO2iQ9UEb3mZj6?=
 =?us-ascii?Q?KX0KebYlu98ZxltE4S2Jx99/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a343d8-b4fa-4c46-de5c-08d925e670a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:51.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5W9t7jVCRmLcLJ9XKDMEEcKQRG/k3/4Vagd2Y0hR+Z0GlTBdDRHsxoVeXUqPtiDR31bDREKIy3MY9f1Jc34LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4675
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

Add GFX Power Gating support.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e9e6ac40e75b..3ffb8095fbb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1336,7 +1336,7 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_GFX_FGCG |
 			AMD_CG_SUPPORT_MC_MGCG |
 			AMD_CG_SUPPORT_MC_LS;
-		adev->pg_flags = 0;
+		adev->pg_flags = AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	default:
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
