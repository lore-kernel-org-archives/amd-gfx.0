Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9B2C12002
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CB8561245
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB8561245
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3EF6E8C0;
	Wed, 21 Jul 2021 14:51:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7266E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 14:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGf4+TS9kqq3r5yPfAu18nR+LRGd/4jkm38qZ4irTB4mjX7SXQtKQbbrrQc3xsAxXB+TLseXfAfDYwIYGnmjSoplchkcfL2k3hYPt8I0DuI5jae5DMijhB4jJjOjqjpAnK3b3D4zKOVc5v4CrEu73eUOanFk8zu4Iv8y2yJkniw97O45Of/AkUjrTDrVq1IXxHRS8kzEzycuP7y61B//IpuC/SG2zP2l/RjIhTYkkqn0dozHjGcewWgZ+ITUF10qmal6/fHJx3kx1tVX8eAs7XN2ly/d42JZREPCN0e7CAbxqWh8bQDm9bZ8aQqDukohmDWNs1AuHcqh9TtNSoL35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+VTL4GCZ32EEicTO9QNRKh70/QuTmtCqityCG4uto=;
 b=NXE2+atF04Jl5k8s/cryrU2BQO61R6hXbuOlplq7VLAdyqYxIN36bd821hlhByaCvy6fQwM/9ihu99+pvigYUyPsDVdvADkn1egXAMovMjQM7umWY37Yd680JO/JUwPoeuINW+UmPk7QkHteygtQSl8cqhStX0Avx1yfgtO6fvkGnKhm7Po3DN8URDyiW3Nane/oExZ5Z3TIquKxEfozDRpcJntUl20Xtw/Ag9+J60RDHIG7Wa0cnat26pm9zVQRQvQbse59Q3VSBFwrDpGAU2xKvBSab6pI0Up7vSudY5dKNIeN4CyMiaUUl1PjjebQf/SYZf53rs/nM1ILL5FyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F+VTL4GCZ32EEicTO9QNRKh70/QuTmtCqityCG4uto=;
 b=y1/D70dmNfS8xjZGpX9gwyCbnj1LlhSQbcnW9gYpUSe73RoEFCK6AwB1jdCpY5aKwPHGTCnTsRv6ZBqRmS5l1oKyG6tH9io/8z2AOHY3HRn+96w0HpEhKeuNwpeOxm60UVkpKrAtLzZB7xoSpUHJbCh7nooO2lpORP5ozaDxEos=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Wed, 21 Jul
 2021 14:51:10 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4352.025; Wed, 21 Jul 2021
 14:51:10 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add yellow carp pci id (v2)
Date: Wed, 21 Jul 2021 10:50:55 -0400
Message-Id: <20210721145055.2619181-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721145055.2619181-1-alexander.deucher@amd.com>
References: <20210721145055.2619181-1-alexander.deucher@amd.com>
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.10 via Frontend Transport; Wed, 21 Jul 2021 14:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29cab443-72a5-4c7f-82f9-08d94c56fa3f
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB55544B21773DFA86E2503DF4F7E39@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:118;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvXzQxmsj5isasKBH5NiMbE47wovaXXJ54YxntoCCUS6bs6OPKAYgOso5rsND9HQEq+COQOEFyWyRB8AaikFFkqbLqeWCStJAdePi492uViVhFroj2vqmDcbcu3iWUyCoKcK23CslfQt+1jjbq7wP4bG5GQliPBX/xQN/Vr4o42gT8wF3IyaRsMPwZEhIT9n+arPGBuJGoi6G5B+ZfJa5Xx0+CkYb/BbigLalhZ0D/LYrTG7dpsgMS1Qj+fDOzDe4snSdwSXPM2u+Ks0XtkDgN8aihcP9n2ox827xAFv5UBzJGG4kQqk/G1bAGYZIcG/88GLTYcSp8v1tpJFniuRTYmczg3Mez10behjhsUBHBYdAT4SIKHMbNnlVKIJ2tA3HxCZ6oybYq094v4HJemWYi0BQawtH+COI9h0sgDchRUvHGeIZjVCn6t061rJ9bMQPJ+MChfnP2jxmunnhJv2MVGN8Siu9v+xwrzN99dh3lrY+qoKdShfa5iJ9QuoMO7JpP+zRkepbb4OeVoy+1CkJlaX8/qH0d3lgyAUs/QOtMCnlgEQEN8GpHTo4qmW5rhparfUNx1J3L2r9u+stV9v2f+QC5PDxTfVkNpXKjpg2bRmvr2f2un9i02k56S+PiqwQQ09O7niTwt2pZ8DGFdyDGoanyJE3CkIqvm1Nj675kk0aT1/tmajyKUEtp5YGtcpBRjpToPxLm0ail1Zb/GgTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6512007)(316002)(6666004)(2906002)(38100700002)(38350700002)(6486002)(186003)(36756003)(54906003)(5660300002)(8936002)(66946007)(66476007)(66556008)(956004)(508600001)(6506007)(2616005)(86362001)(8676002)(6916009)(1076003)(26005)(52116002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bXyJfFjH1rZfJHPeayr3pb2tqHfHsOjILssbM9pWRRtx2plIhyWAY1fOvO4F?=
 =?us-ascii?Q?EMAZbtxnAK/Gc+D8fTajG6tbYutSCv9b0x7NR+ibakY6SZBfSg1iOvXWks5T?=
 =?us-ascii?Q?0wAcwUSIY3s/4CJuUfHG74cYOue6iLbt74h2GXULeMVc7b+ecJ+81Hu9CRSg?=
 =?us-ascii?Q?pn2U7LdzHD9Q5LiRZlO1fWnbJlGqYKQlQlE65LbBcmqHPidZr8s87l92haVP?=
 =?us-ascii?Q?qdbjT9QSnFHImmgKm5Z4A2TWhzvGSor2rsZgFAEaKQLB5F3JRn+84a5AM+zd?=
 =?us-ascii?Q?Es494IuvsI0lCWK8DDKL8RTgGAVc+OxZbupjgCmS8IKzbZbr6mU9gyEpE+Kw?=
 =?us-ascii?Q?Lm0kOcNW96yGik5+VJVD6/VtA5AKYiqa5kSIxd0RsAYeHQPwUx7RJT06qMjA?=
 =?us-ascii?Q?B2+xt7YO1nehIjQmCWswmH1mYV2AhxS2Uo7QAlEs10gtgXCGneqAz+C3VJF8?=
 =?us-ascii?Q?yFT6ce3+KQCVZxQuT74PJ3U1ummBnq+8UV83RNB4dEpMtLTIpA9pRklkzqNx?=
 =?us-ascii?Q?MzxaOG0JR1d+Gk+0q9yhpYHCJz1omxjOVUdMBslHNYYcNdgqgWXs//GCH3Ea?=
 =?us-ascii?Q?EWYpuKMQ5X6DGSgBkSceuZEYOwIvF9VL/zOGvHT11OhVon3zHjnI6k/UwQUg?=
 =?us-ascii?Q?xPBR8RxDs7IZ6mo+3zVF114aBTpaPyP15fyptkVfCtrp285SzpVmkBcaKWtn?=
 =?us-ascii?Q?Sy4FzSFeFwZfkEFE2JvfZDYpZjdEz6HibLVvf6nXQGmiMolzUdXEhy5g8yUV?=
 =?us-ascii?Q?4mecWVcmk9BTTKdFm0P0sc9/1zVBjd9iERbQdBcQKK+IJ5F1+u3f8kIozxss?=
 =?us-ascii?Q?QqAB0mikZnTG8EPyOyUbuFNcGAaXWXTkMNqhTru2fkNRO0dpHm+nsqhThXQ1?=
 =?us-ascii?Q?VInLOnRLFPi4eU1bdSeJXJLtqjsattqmOIGAGu5bBclKHH6/+MJHLXGvx9p3?=
 =?us-ascii?Q?mslNJxQI2kAqiJxcRWUooTEsGLlWGFmDbTkoAWgED3DVhNwbiNsaMlqN9afQ?=
 =?us-ascii?Q?QdbOW03hPQtKX2hRYRA+y/lkfPIPBieEHSicR2Ji3VOtBL1AHIhft06VebMp?=
 =?us-ascii?Q?xga6+jL6eepTO2FZrawrARfDj653BMyra4nzjyMtF1FRj8mL1SC3FBL1ER8U?=
 =?us-ascii?Q?yTY/IoR8C/XfqNuHA5I2OJV2vZiYHsY7gphcaSS255xQpF/5P+SiM3GmJGD8?=
 =?us-ascii?Q?j65BPcpL1zX0Z54hXwuZ5OQJUr+qhtnj3iUVSHp/xdUzoZO89otsP8J3jIOU?=
 =?us-ascii?Q?cmJDsDnP+dgGDzRax43g9iDoP5auV+h/qKvnmrHOiIEs7grrGgXTrrpfi+v0?=
 =?us-ascii?Q?qN0+MvSLdHzadbH9poFoAS9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cab443-72a5-4c7f-82f9-08d94c56fa3f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 14:51:10.0872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GNHmk7dtC0PJjtECkf9FbLAJnxIyo1R6fJVLmHZiSxNAlEaCCryxwX42/2+5XaT4kwpFB6Rsotnx72sppo84Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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

Add Yellow Carp PCI id support.

v2: add another DID

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 1db106b135f9..503a5fd0abaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1188,6 +1188,10 @@ static const struct pci_device_id pciidlist[] = {
 	/* Van Gogh */
 	{0x1002, 0x163F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_VANGOGH|AMD_IS_APU},
 
+	/* Yellow Carp */
+	{0x1002, 0x164D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
+	{0x1002, 0x1681, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_YELLOW_CARP|AMD_IS_APU},
+
 	/* Navy_Flounder */
 	{0x1002, 0x73C0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
 	{0x1002, 0x73C1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVY_FLOUNDER},
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
