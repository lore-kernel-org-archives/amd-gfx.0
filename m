Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9EFC4363E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130C861417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130C861417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D9C6EC68;
	Wed, 12 May 2021 17:31:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F876EC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD01AFUNY8PkgZB3zjsAUgcqOiHjCAfIa/ZFGYaBtlThvIjvFxQ2PT8nJSkujh5F5Mt54AFQRLpjYEk9Ze5X0qSdDQM5HAHMowihV9JnzAnYRTKFXg1PjblTgVXZuEXGLvEVXG2Kfga2wiURvsY1iene5uqgQWgY6zp1DTqoZu03Khgz/vinI05jQ1PBQ903TT4o3IEHYVIBqx4uzZ3XKNzGurxOzWV8XaXqQz/Bo5x3rXbit9HY802WfT6inJRCOEA+yFDmBDwneS/ZtEIGv/p/94yGojcQD3MnTxztWptb8v0oKFJfZ1cWajR4sa8qv4lHZRvrT0eab0iMrTM9hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McztzCNCD/z7F2XtATY26sdExgpnSQfRjWE1tmGVGh0=;
 b=dReejQZNWeOVbiYWypbi/qlumx9L0c0ixXgO6KFM9WniHWsKUMgKJKI5odVqrm/u0DoK1C3R1uZEZ0RZoL66r3KLI8KKrS9+BnTMo/ELoB9GPeZH0pRQl/DooxTx3O1bZ8la17E5t8FGCrqNm/JOsqVEaBNhYaAR1TtUe3CMM+hH8ZlOT+RDAj/+s13K1lNGncURp7anCupE3LzRs4TSyBKEwVjd7vyLAS+95SBgwtOBDUK0hCZEDW5veFGwMIcm4i0feCuFX4XjR2SSW2VdAAks4sHd6pGm6LdXjAnPFigrfafLId9VB343eMuy4T56Bqg0Pntk1IRCHJ108T2GGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McztzCNCD/z7F2XtATY26sdExgpnSQfRjWE1tmGVGh0=;
 b=twK4csVAVWuJyrDJKq0eAJGKdEY0yQvPdx1XJWceE1GJDTRPlU6lcweXmyrKqhpbB0zMMZqBYv0yLmJ+M9DVmafoLvupSIAHZ3+DVKeNpiUeeu7+wUAxUZAeQ0tthWgwSUaMS5se0/Rth7X6aZLR2en4e9BJSP4upiGEAAVKzA8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 17:31:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/49] drm/amd/amdgpu: add ih ip block for beige_goby
Date: Wed, 12 May 2021 13:30:16 -0400
Message-Id: <20210512173053.2347842-12-alexander.deucher@amd.com>
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
 Transport; Wed, 12 May 2021 17:31:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81f4929e-1643-4b90-0dd5-08d9156bc142
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23701470665CC041ABF8DB68F7529@BL0PR12MB2370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /g6Pvrevad0d3BwJsNrcwfH6Rg5cZO5gLQlmFJZjHLzINxLE0GoHbM07OwNMPaGrCWpcogsJ7g9j6OJm3vSHnPojxBJJjpWZiN7rdzSZANVIARLhflWIZpT5LUG78LES5dFXxUGJ3z4wU4vYO7/Z1C480MQfM/cpJj1yMhUIMTSH9DVHWDHtjvv4rSlnrmqSTLOsTdESAMMN07jMEFfqFBhDDQiE5c8POksV82wCmAbyKGMOs0mqXccAClQqjf75RiL5q4SITtaqfJ+KWT5a1tdDFjgcIdQ7GvRbPsIE93aLGoZzYLNUiCVWDl8erYyrVUaXvfT1dLe3lhSRuBoYf7PZZ1nAE21f8KmxUIJFwfVrBiL5t5yHNqCx6pjtms1SAjJk+TTssC/OY1QX70ER66KiEVmlz3mF2P0xvHczUm1KPIXmWg6BdwsStQSTI3PYXoSFbAV1R/HDyBVWmTH2cB7IN29KHUGOM/+kIgUYK4t1Fyvl55OJGtrqz52llgQg2YonGHty2QG7f1YoW8lYCDfbvhwbZ/xvJpenG6lyb7MCvpSkKZcvw7XwNwX8xIZl03bXYAPT5kTwpwLhWg2pHuuWM1xiHCkK4yv0o0N14eWdY9ApEvbN2LR5PXr1oz/G4cOKXmDTN7YpYQ51QLUy4yGpVEfGmvfB4t5GYajth21Wvh1+v9GWfLGmpjIsNiw1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(2616005)(956004)(6512007)(26005)(1076003)(66946007)(4326008)(8676002)(478600001)(316002)(54906003)(66476007)(2906002)(8936002)(83380400001)(6916009)(52116002)(6506007)(186003)(6666004)(16526019)(66556008)(36756003)(38350700002)(6486002)(86362001)(38100700002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w7BvO1IPmnyOBfPFdRgwLjUVCs7LCqnuZ2IyJ3U75F1TR8HhH9iyOlRVA5mv?=
 =?us-ascii?Q?5B+2oQJIDmPoCD8e6xr6YCulZrhZXmPuZwcY6n79nl/2LHClojE5EnaBilsN?=
 =?us-ascii?Q?Ru+2C1WfvafxPpsxjk4IdAYCU4Jtjr9pDI978196nSsiCpig0uDBTHRHp4rf?=
 =?us-ascii?Q?NdOhLoBjdjjpS3SQ8pSpIJ/tgeSxJAKZduEbKouzrooXX+SnDa4HaHQ764li?=
 =?us-ascii?Q?yTMwvCPcYMMg3SAw4gVg038R64WFQsMUMMT6R/quS1p5Joo+l5yapUx8Xp5L?=
 =?us-ascii?Q?s41p7e9E2bHZxYuYK+dJ1/5uIM2TjU+OwxithO8TOqFKkMINs+DMs9W2rruQ?=
 =?us-ascii?Q?vq3eMukrdHPXgpX6jzbk6OPrDXSkOg/QVi4WQquElwpjTPwlR6q0J1gQj4xd?=
 =?us-ascii?Q?2qLso6REBjf6W2UA9K+DYJ+hHau8ITbLFDcK8Rfbm+Hri3k/IPUwlD8o1vvk?=
 =?us-ascii?Q?kGQjiYS3J/JfDAtIgmGQNViuUu7BZXy7YZt0eujg7zFEzMH9A2uotePaK/KX?=
 =?us-ascii?Q?eW/Bupgacnj3GtLaq/KieZpQN+12hjy4rnK9jC0sY6M36ftqDRs4JAqJik6N?=
 =?us-ascii?Q?LXbYmRcSKD7gWr25ZfR/6iQRicdjtWSA366f/yq6yQKdwDIMhHE/yAuxywnC?=
 =?us-ascii?Q?AEoz7qnxwI61BVbXOiZ6uTkErhUaCd8eW/sd8YM0dSm2tJ/3UwDQxwUFTXZH?=
 =?us-ascii?Q?OdsclblzeCsaEdtPmHsXKVRNqx0J9gyo9qKUIUiFO1dH0Gl55/+liDRxYjaW?=
 =?us-ascii?Q?ylQC7nVd3WgBAgseGZEFe7sT2P7T7lYXVxsiDC0coViaRmXEjgYM5f4erD/V?=
 =?us-ascii?Q?+5uSrZgrrS9lApQC/4ci2sewDu/z1cLhGmiEByODJceO6+6OFlEJz3Zepljy?=
 =?us-ascii?Q?cBuKFeGXlecHc7f8lxeDsIOwRa7wgLZu2XCdgwF/TOmvzUiI6rGS6ZWVh0OP?=
 =?us-ascii?Q?LTFye1xPC0307fVN+Dh9tzRoBgTbQ+dXCRuixlqFSBBkkfcmyuA17L0J94da?=
 =?us-ascii?Q?sqRozDQaCOLHsvXeBtjqV99xoukfML43EhrkxRi/oJRiGPlr8PmW7aadt5Au?=
 =?us-ascii?Q?+q0kySujFvcaAG2utA7lE1RSEyz8patriZFO0qMaTvZcJUqRCqtLe7jcbjfw?=
 =?us-ascii?Q?rwIVXzJVQ3Ch6aDlBD4pa4lGgaDjYOPWe7qVfQbqzlcCdhKzGM65EE6ymAzZ?=
 =?us-ascii?Q?lMq49CcpzwktD2j//Tqzp0x6M44hOWQXMguslkTMBPAzVzYPssZRWF3ftG8T?=
 =?us-ascii?Q?MYoyfOJux6k0Svv5JEY071sSQd1BANjA9rmcdZSCJw42oQ6ZkqO3+Z1nxiXW?=
 =?us-ascii?Q?Ofg1DnsmCG5vzHD/by83Jnx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f4929e-1643-4b90-0dd5-08d9156bc142
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:19.8786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IPAoS7H6SNacIPUzugK1Dc4rXWL+AlXIAf3nvhmGDrUo9mxaPAG0uPaOkr1INOYcnHrHtkOVJ8vf7O5hJPFGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2370
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

Enable ih block for beige_goby, same as dimgrey_cavefish

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index f4e4040bbd25..6eb60bca9f43 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -311,6 +311,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 			case CHIP_NAVY_FLOUNDER:
 			case CHIP_VANGOGH:
 			case CHIP_DIMGREY_CAVEFISH:
+			case CHIP_BEIGE_GOBY:
 				ih_chicken = RREG32_SOC15(OSSSYS, 0, mmIH_CHICKEN_Sienna_Cichlid);
 				ih_chicken = REG_SET_FIELD(ih_chicken,
 						IH_CHICKEN, MC_SPACE_GPA_ENABLE, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 316d9583d813..ccc534fc4109 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -848,6 +848,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 	case CHIP_BEIGE_GOBY:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
