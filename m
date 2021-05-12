Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E341C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974E4613E9
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974E4613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27FF26EC6F;
	Wed, 12 May 2021 17:32:07 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4741E6EC6F
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzUhvVmU5E/jpMpYEEDhCzSt/1HU77/c2eCLs4MgeMahdfxJl+PC36D075UCSAemdnBb5nxvwI+T+edIyuwJGVKMHnGoutPt/SKQZiD+krldLjo3y1Fu/YCDLqPBtmhUDEuArj3+Dh6aVUUQKnD0j/ksqWxrhzDTPBgNWuOQkb2xqaER1xjco5g5ug4psiwYFZ2DRRo6fO5YaPuiVQSbFEV0FcXUXHfUn3tyUjC2M8Ei08JtpRfMbC14bIJz4emVSlrnrow+w5M1p05Kjfv9z27vvsK3htdyAeCgrjrUHgjdNQas1daHkMRjeoEz2xMfYAbNX0pP4y5rvkX0AO3NYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dn9NGHlWzU5VJpYTA/QrzFi66gZuLTeYma3/lde5n0=;
 b=C4fMm13soOmxorPiwzOCwX/SIPCvdQqtcoaxqrsSqyHk4nx8O1PGPNXK+hPn3ZzAP0YaHVE08xjyq+QfIiFB1BY9ckqnA+ZoZBthPSm/C8mucWARpPxjGbVww5hL8v02hGKSl17nqPS4gC7WuXhWV6DK/f9YZcqPxiAEcddSanpg9YeiIGN1iIyG6ldYeXZ2xA8azH5bnabB84O1oO40ajPNpRZbiyEw5Nfd3DDPHb7VzawgQuUqOntqW+UHr95u82yQXH+K1gGzl16juS0py6LzHWOVXCKykmcDVDM0UhEXF8qu2scy/O5A42LXyCTK37knFkQZxq6ndVIdBuBa3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dn9NGHlWzU5VJpYTA/QrzFi66gZuLTeYma3/lde5n0=;
 b=DFvaKcSkciNYZnZQ76iyd4gvAoLApfB7XT3gjqbrp+ecbe0H57Fxx25XYF8dg7FpJ1sVyi0GF4gK5eTO74ZH07hjeGdOb3cWxJoPELlbaM8sheCqSURmtzlK1wpVEjYGF5f1O+fidu8g+xoOEN4GP3ErrYOjtC5wX0lQMdWt4OA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2564.namprd12.prod.outlook.com (2603:10b6:207:49::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 12 May
 2021 17:32:04 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:04 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/49] drm/amdgpu: support athub cg setting for beige_goby
Date: Wed, 12 May 2021 13:30:35 -0400
Message-Id: <20210512173053.2347842-31-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18274639-6a68-4ae3-63cf-08d9156bc919
X-MS-TrafficTypeDiagnostic: BL0PR12MB2564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25640BB536C003C42B11AF1FF7529@BL0PR12MB2564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1S7z+DUthepij0FbILzByvU2Sf2B4ozw2X6khZl+pxD6tM/yNexeaguMuNvWWYYTw+s2i32joThTwVe1lrFYkOEVGk4QTDGgo6Z2Y7G+7go4UqDAKjKAPP4kqT35tFJ1XGKX5kaWOTrEiD404MBtu1hWiBM/aAp2RuKPFBZ3Yi7OZCUKESrtqnKDCKyB0K+vCWH4oO8SfVwG60hgfHOkzCFmsRsPvyBrNRhgg/dkIpep3NttQiVeEpymZpAZM7R9yBl02QKhbuk1s9yEaLpDuIDcVLKmX86pNeUGWapsoGAyu8t7EWRiDymR5V7G2iF2gyILSUObHzAl5wACTO9e6ERiRl/ajcK5ijKBh0L4AZAAtPrjBZ3SOXP0oQhDu5qzA81nSOPlOQdnRMSBs6gwdFWk7Y3xD3Iwtf7FsldtICrpbgaSAhkKu5r2z0XzWdkzJDBN4GjUWpSijsd1w3aaKWf0fSqnuPHgTBXmE1wwX0bKXFK6zJtM/Ok3yH68krWQ9tCdvjONVvhzLpIuwAeQVI24ZGdQ/tJ+HVVlr0zE0oKQ8Si4mFW2HGF5qwMt6uXKM0+lTXhA/0K2pe2mefWwYtWZIuQjLmDCzqGH/1QtmZJRo/BOmRJl8C+GbodKLWmb6r/QDqoqdBuWTjmtKQxtVZn7L9YIgG4aSSQ8SPydW4PDss3OUhkHhpWpPGXJuBwv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(5660300002)(2906002)(6486002)(1076003)(66556008)(54906003)(83380400001)(186003)(316002)(38350700002)(38100700002)(52116002)(66476007)(2616005)(66946007)(16526019)(6506007)(26005)(956004)(86362001)(8936002)(8676002)(478600001)(6512007)(36756003)(4326008)(4744005)(6916009)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GNhhCCQzcBmMn+w7ImvmRqLvX0bPoaByoB18+uroDMbK3PbtjfWqoaZNalch?=
 =?us-ascii?Q?s8NGEt4vQo5etw+4cJ05ZaUqXiWZUgkcPIzKgzsAzrEFIvlgykW4mq91mAVu?=
 =?us-ascii?Q?PkFTiAz1SnDBFSO7+N375I7jxVHxV+6trqxCpP9IsHecOplDYsQaJTPdSSkp?=
 =?us-ascii?Q?E+i/anRWm/PEdj43SGG8idEWVr6HFH0Cnl0wIGXhu1OOIIXOd5Gd/MT+vsCi?=
 =?us-ascii?Q?XMkYTvyfY3clsGGxCsAqrcUZA4s5IQkLSs8Ohrv5IqaYV2/vFJhBsxe16ICU?=
 =?us-ascii?Q?mGZxpYtyt5qaaTqqFXbDq6tcn5UO/xZ3PKlzbjJQ6kkjClWLUNVpQwW7y66z?=
 =?us-ascii?Q?t8AUEaCV6ZiSVAjAtlDX/AFXMT5wJn1mvbVmPv5iPxbXmPLrj77Wwumkh2Cl?=
 =?us-ascii?Q?XDLxbuf09AL2YiArJAcu+oqvm6E45RN2bBmJ5z+FHXRRzDoxfGiePfE+PYi6?=
 =?us-ascii?Q?WO8GYosODr0ZQHoGmvwETJfO3d3zyvE95WblSIcqJkbJO5Yyp5CxfjAgMpOJ?=
 =?us-ascii?Q?GCorfFxXOzFQnxblWLLacDjDRLv3MlAl3kRWY+muX1me6P3ikW6UK56JoVzu?=
 =?us-ascii?Q?iNj7xUa4SK916TOkaIChSuAcEG1QdrJRInwHvIGdlP4C5Xk5+cU5ITQr7te9?=
 =?us-ascii?Q?hP/xK2R4+oXE4C8dkh+kKhXTQTPboBMje6ZooPkQYE7KfbL9OV66XnbP04ty?=
 =?us-ascii?Q?8Zso8ynSE21lBLEW+9FWjjWD1laRsxcxO8DTL5U3CoQmmjJyOsj9bt4Jp5PV?=
 =?us-ascii?Q?WdKO9rmJwkInv/90ns27BxVCYrtkv6hYLB47BOE82b8o8CC02HxDUIpAdgBb?=
 =?us-ascii?Q?jexvHKtzm2WH82sdD8g5Dr74JhMLNAsm3Wh5Yhw1XZewEKjfeHO8y0DquqxW?=
 =?us-ascii?Q?NA+pamXoaySIWbfxdrLfDcMerY7oSaWs22v1xhoxxOlKw50u9gQLfXH3PNcy?=
 =?us-ascii?Q?wk7BpeGHJDvvfs7d1D7p5AGz/GcJ5VcIg4h7s/26HYCnEKH7WrIRNkp8nGx6?=
 =?us-ascii?Q?P/9A1MyeU0tQOGNuIadm3M/5B2OPu/vFEsbi9322FV28LZwOcSRX2bva1TbE?=
 =?us-ascii?Q?29MXDU6q5uXujq/GjTC1FCfCp3M5Qcf0b6g2iEfpU6efXuSt3+HLAy87Ni7x?=
 =?us-ascii?Q?62ayDL1UHDwaOTFwDk5h73C5/vhzxTobXJo8XNmwO2CZHoJkad4S+M5GsJa2?=
 =?us-ascii?Q?tE5S7BnNcWSI+s9Nn5yve4ZPsb4awUFy6agSGOjWaW5Sdvbe5ZB9IuEwRJMi?=
 =?us-ascii?Q?+ojsmFZb/xkDVKgce5oGdt4InKmvFBRqvl4QY+jsxykzlOoNwpZBgNajN0hP?=
 =?us-ascii?Q?oPd3ut/pKsOtcJUh6IqJo6bX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18274639-6a68-4ae3-63cf-08d9156bc919
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:33.1215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6uF6v7KVl1cjBRfdMeAUQtuBhrjNz2Z2mpEu8AfqfAWTdgHc9WkYDhIkpPIDOIgkqFeavLzcEiJWyiMQ+X8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2564
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
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Enable athub cg for beige_goby.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
index 2ac4988ea0ff..c12c2900732b 100644
--- a/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/athub_v2_1.c
@@ -74,6 +74,7 @@ int athub_v2_1_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_DIMGREY_CAVEFISH:
+	case CHIP_BEIGE_GOBY:
 		athub_v2_1_update_medium_grain_clock_gating(adev, state == AMD_CG_STATE_GATE);
 		athub_v2_1_update_medium_grain_light_sleep(adev, state == AMD_CG_STATE_GATE);
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
