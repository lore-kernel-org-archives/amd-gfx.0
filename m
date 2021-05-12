Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A5AC43470
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DF361419
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DF361419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F746E198;
	Wed, 12 May 2021 17:31:17 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F388F6E090
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwado+3DRhXlqPS54WnHdXvmB9zG1l848VDHf+r1dVbSNds4YwTHx4SLiOrEWiTxBrCiMCuOSmNCfwKJsLDyMZwjlB8brGTaweeliXKg/gMjQqr3d2MBdFVCNz0g+kRpexq2zyoO8nLA1sKvzuxyEOHg2rkdcWPzpsMJhDVoldHHWOT6WSQL1vBo8OF/7zSVJMgO87+2wDBpWoJOpyT9jaGWR5YlKHtVtYNmEcDtiIyL3UxVhT4NJkVMVSdu82cb07Za3XWg5VIH4yyEJq8kwBzHPvk1aSj58YrPH2jZos0CjZrCC4NN9bSOjxhnTFH82LpzTYi5sSBQlL6bVgHQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHlZ23BNe+j1g4pikdQtzSz9SESX90l7m4sIjmgpgYc=;
 b=UJDECcIajAdhZew1VG1Y1x/0bIrtfp1vRXofyXZ3Z0vm0pr91YxSxX/aSUo2u7N0v9Gj3ynsKD/YzlLQvCHJMOd0Z62UlH9PwCh5iKw5egwlmuwpjbZOpuT3dfHCu5HNLJ1CkwRgkBo+6oNKw2IOIhGt+GaTlR3HnExD/P3qphnOV6PrmZsqRMpQmNSY4uxXlP8spYi0U8WZv8Vduq1VIZ7iFRH5FXMSV4ud27Og1U7HcsEluWGxQieipw6wRhif8PdHuscGb+Yy3tEAsNDoRCH4AaKwrIsw+aN979MRpcp56d6z3mut7q7Ksh9EFNQwAb/Q51pderVRr/Oe+zP5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHlZ23BNe+j1g4pikdQtzSz9SESX90l7m4sIjmgpgYc=;
 b=TUCbzAqFmKF/ydBogtQbZjya7MiZO7HDaFrdmyT7wNeMpwyPOxTU8AI0HdMyhOYNjkx4SQAR3CMFTXlYiDqCA2j3IYtgUt0nFJ17zCviq7vi2e9gr86qdqJ4Ke47pvnEWL307tz2EqLXtsXQNSSEUOKTNDVge3YMohMh692OXVs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4915.namprd12.prod.outlook.com (2603:10b6:208:1c9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/49] drm/amd/amdgpu: set fw load type for beige_goby
Date: Wed, 12 May 2021 13:30:07 -0400
Message-Id: <20210512173053.2347842-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6e44329-d03d-4ee6-adcf-08d9156bbd63
X-MS-TrafficTypeDiagnostic: BL0PR12MB4915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB49158302451E6F0940BADB7EF7529@BL0PR12MB4915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGPNPkgnOUJqWM5wiLwL4dqqd1NoEVdK4GK5G5B9Pf7N2VqVp95mqrBx973wifmXT0SsnMFZioBFAoIwibPb8lqcuxpXxLn5w49k/6FJc7yTgFjSx9jyUUwopwjm1/WHYavTDGwBlIrI/l3tlzSd94v1tNDQxRXio7gLIPE/ClPT7NWqjVZN444nQyoDvkY68whSLixQSP2RBghWu7OygcADLhvqBdcGImZT2+fsGUt65xaBJze/o9+JjvbpkLHB/q98IyOH/+p8+dmSVRmdW62HIN61+kpr6PwJzNaWZrEDwOdLVbMp2H8XGEuDNg+864inKnUIHrwHFJQOGXXOFL9Zn2SJ6A1HMRYnwWT+G891E0ROjOUhZWcMkRGRKp+Qi1KIwtbJ3Dc9XbDhF3saNCvttvpKoCApYbliPbkc5v/YhBSPICuUy8AMDjfGFprnX7LSZddVVAlsfneI1xbiKoQAcu4GbaOZs2m+8F1OpopkJbH41mgrvG7v9RpnILTALJYAOhJhkeNMlblOcaci5DaeuOFH7GxbqH7LF7TC0JtacXTkWCC3bpD/uyO7qwIyNp39am3zGHhzRhWPEXpC+mrIG4ncGPXAPRYqT+ijcTt97YTqRUb3dXq4bSM+ZQa47eQR58WXwgsqYrXAsf95lidWliOXQ4sESYOVlK9QEgc6ZYFMorhKYVlWI97hHHmk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(8676002)(186003)(16526019)(8936002)(54906003)(6506007)(66556008)(478600001)(52116002)(6666004)(66476007)(38100700002)(6486002)(4744005)(956004)(5660300002)(6512007)(26005)(36756003)(66946007)(6916009)(2616005)(86362001)(4326008)(1076003)(2906002)(316002)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n57qiGcHsc4ldjHaiE+s3yqXYqIaX85aOofBRCQ3Qy7OZmGLdYm/IjQh1AC6?=
 =?us-ascii?Q?U5uz7JZQS1Q/2X+4LgOceQh7mQ8raPhoKbWorIjeFpJjz2qrCgJQf0eDUc8n?=
 =?us-ascii?Q?jbXjYPYCHG9L/ZxFmZYM52VXgo5BK9Be5LNL5mtXgRE/o+H8qlcq/LL04zXJ?=
 =?us-ascii?Q?4Io6ssNnp7mmmzMPytc2MLBqqnLn64RC2ZIg7+DN4EF3sHKRI646HaaCSjl1?=
 =?us-ascii?Q?wGhS1gL5eyd2OtVvI2CvreiolK+v+e8wKyAkN5hXe9FQg2bJZRgeGGIPn/55?=
 =?us-ascii?Q?djMACBN5GU5/K4tTMJDGKAYsdTHAALwnN78lUBjH+wAEhiOIkNQ5BDB6wTld?=
 =?us-ascii?Q?3LjOqGSrTqDP8C4lf/SNuDkN3c2P9Wnbb7Ud/3PnCeAKf3MGTpfs+z0aNRHS?=
 =?us-ascii?Q?1i3gKzHa9x9gK1sQSppcPUVgHAFWdPpYbv5x3f0yjcKTeYGm3rrPrpAXWgKu?=
 =?us-ascii?Q?/AAyUgYGA36Vt7e70U6C29wg+e97YAdA8AvgdQ1DcpQuwMla6T3p+AozkqRF?=
 =?us-ascii?Q?71Uv14iXsqsV9OtsJCG4z8oNY1mB7N2pCNPxYTRMhTXR4Ot3XW6/JEw6Sd28?=
 =?us-ascii?Q?9bSeWTQkNB/y7FqtZBradceG3rIkj4kdI9Jcbx6Ld2IPCLyoZwUCZiocYqsw?=
 =?us-ascii?Q?BZItTtVHNwAU8NJEAeGrPg2P34uZ9u33hjcXiq6lDSug/jpznbMqFR7U/q6h?=
 =?us-ascii?Q?YdcrVfG6vDs3XkUSckA2QvaAFQpgznBsI+/HAVxbMVaidYIgwSgXvXsKZTYT?=
 =?us-ascii?Q?QIRmyrDl8qlc97MWN3WkI/4W6KLI37toq9Jihq5xBkr06UeArhlybDhNjueo?=
 =?us-ascii?Q?7Nkdi3/63iG6FDJcEPKFAJ3phwlF9AT/RyYCbGL1OBZUxPqrlhfe9bhPWFR6?=
 =?us-ascii?Q?7WpMm2Pw0iA5/irPGQ+ON26KhqHPXutWdwDvsOvzNVw3jLLBtxTPTX3ebvfh?=
 =?us-ascii?Q?X3AetK51YcA1v16qbwmwMcXGi8eN2dcutEYjGmj3jGD9CK40CNVAQUE+2DqH?=
 =?us-ascii?Q?rYXixBpiQY7OUyM0GEshDihHfpGrJDaeJuMrjAYPvCiKVG8mSN6cFjYsn/5I?=
 =?us-ascii?Q?+6re7IqX6Dhr94Rp6CidMJOIoxjqzx4lD32LhthaiCa1KSke5tAP/68r8m/4?=
 =?us-ascii?Q?kZr2FvBKf4aCN6eh6i30TwD+KsgkHOB7BMmo7CE4Xr4QQwR6xrYKXNORsBjW?=
 =?us-ascii?Q?cA4vZDogI7L4DiwGkQT/KgaDMErEOOeC1KSVXPJTeOTlGogMI4D58rgXsm5q?=
 =?us-ascii?Q?wtvWHlQPKfoUXuCUeDJ43mvDkrM4QAw3YehvAvXiLb+AYn8PBRDz1iy2GctS?=
 =?us-ascii?Q?UTjk8SV2hDsAVxs7N2210+/M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e44329-d03d-4ee6-adcf-08d9156bbd63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:13.5016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4D4lPWAZE38oeEufUbLqQZCA7aEB4U7TfhZ6WxhnIJPaBNFSZVevxLZAxqvlH2LPUjX9g2aV3PNoupzeyULZIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Use direct load for beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 9733224117e3..47119f91c817 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -407,6 +407,8 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
 			return AMDGPU_FW_LOAD_DIRECT;
 		else
 			return AMDGPU_FW_LOAD_PSP;
+	case CHIP_BEIGE_GOBY:
+		return AMDGPU_FW_LOAD_DIRECT;
 	default:
 		DRM_ERROR("Unknown firmware load type\n");
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
