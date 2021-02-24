Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A94C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88E764E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88E764E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734DD6EB36;
	Wed, 24 Feb 2021 22:20:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 761166EB36
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVv1P+dEIhs9cwAX047+LSh1hrOBEZqLbzGL1WKMjkVLPFtiTCW8CWSh/uRGI5lWZRTqQO8YAlUUHufEVvZgcqI7kx1PjbY2BE5WgxUyshFLjYH54sNoL+yMS5icS7AP2TUvPQlIvppinxoMpGFtvd1JwArRZlWOraakMvuR/PsIh31db9MiZD77ohQHkI0tNWKwpOX+PRRYCgmMpLwcG1gkdsy1mR9+P7PSel+hayFRseuFuFESzKwhxR1+FsG9xqPt6+HVjFWkhYVBUgemabwk1aAYZqF2qKQuFMeX7r3f23YToxtF1OD0pSF/ravzS6Q+LxbK44eioJwAlfkGRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoHk5/9l1iTqtsBlphBBIBxv/uWvZ1shd4LqnjTFTls=;
 b=CalGrNPKo4Vl8jDxALk7O2Xqfd4Irxs+4cyxpNLYVlpX/+MMeIpp1kedpsdNKc7+wyIkyUlykm8EdfrfzzNuQc9bU5SIQohPV2S5iBlFogUEaO7Sv2NDyDSYG9LKTFykkEXPqSXn9Ekz/HD3r5YgiZxseiIEODdhLijpN3JO1V8DVxtAliTvLGBdbYhrC4aCaWTkuGiTZdfFlHxVZKJGKUTFooAc/Ocgjj/RWiSaVC8HfTaw3MnS1jouqNUwpt4gtNjeRuVqx0J7GnLNUZqEt+PsnPAvVJcSF3F/CkF0uv8nNwVd9crWi72Ks8uNqotlC9W/c+XUo2Kam2Y+1Sinow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoHk5/9l1iTqtsBlphBBIBxv/uWvZ1shd4LqnjTFTls=;
 b=hTiB3LvSy4yLj0XzN/4KEn1llHiVwzbusZSxN5U3zozRT4jnUIYFxUMOxX1w7EBWsmkvuIcMbtK+bcijS4kT9I8WoWlz24xAKzY83sLb9aGDITHhXqHSjYIJ4JO9qb2z9CDoIRRXe+i1qKd5KzFuxAv7bHO8FS/nXEXqDH5LHKA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 043/159] drm/amdgpu: add Aldebaran to the VCN family
Date: Wed, 24 Feb 2021 17:17:03 -0500
Message-Id: <20210224221859.3068810-36-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33f84a7b-db95-43d9-1b46-08d8d9124cef
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175C2B0A25A98BAA3E704E7F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c98PGdXwKy9k7wVxPjFcnTrw+Wz3D3Kbewpx39qVGjXA9qPSDQLR2mOcEEIQPf3Uf19eA9exvdDTROC/c5u+rFdsglrMKeft7Eirnt24N45lsM9covbYb0ntkik5nXLW4+3SUU5X4Lr+o34I7Q8tvpttzTGHPjUVq6I6gckHyki2jvKya48IhPvyZ1GXpbr/A6EudhoZuYCWGW/UAnFSmv2Rdywt4BmXek77G3oTD7oyvv8wZ2X80ZMdGU5pK2RKkAXQV9yk3499RKzq6jgq+aFsHYeeL0mryCEOyA/DQtUy/1+pq8TbkeCNW5dWKW+SIak86xqMh3/5gnmdJyuZcJRRUuG5wxvUF5Tm+Splh5tlV0fjuHHHvGVBhJUCDNx0GdvcMBJlK++N0Fu364zFxSB4OiTSzWhsA95S9Xvkva5yINgvIm2rqFD9InH+w2ZA6ICic8iUj5tHBzbYydLT+TN72D4kdTltn/ARO2RvrasJKWkY4/DQICRnPYFAJ+OxKTOeg6XMSUUEU6JQ5BF5m3T4sod135iTxZLSnqWPMmMDpHFcU675kC+hbQfTf5gpdVhtoezaCPpincM0kkOHug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U++Y4/XMraV43f5Ieee8L7+iP5MwrWM0tC151rH58ZkfKikyYiKsD1TuvrD4?=
 =?us-ascii?Q?SRywvNQtBOW6u+kyPG+1kxoInBLH/wXkRI3HQSwehbKKlauocZMY5jqQFIe/?=
 =?us-ascii?Q?hpH9qHfBXJAq9NaNhsNDOUXuvx+j6dcNcXOJPJ+AmKDLPRJ0pa3pFhfKI5gc?=
 =?us-ascii?Q?nV8g10Yb5puNPQZkZhqeBmlijBdK63H3TLj/yLumDKyrnhe+7O+1p221Q376?=
 =?us-ascii?Q?IBRti22tJevXZJge0N5toyUXazl0zILrgaL2iaV0XGMeXOGGDNIqXehAgXJ/?=
 =?us-ascii?Q?E+HHc6vePD/531YRHeeELMmmMp1FBJ/1yLB+un+WilA+dxwCRBuc27bgcuxw?=
 =?us-ascii?Q?CMiRBJSKfsvdg2mIvRzi0RnZI8Soxm+ojp1ANk9Z/eCY4jP5D6GGq+cYGv3c?=
 =?us-ascii?Q?j1y9RVYPvSy6rIgzWWatCR8iR9rul+cIJjRjSj+cLzJuuLHq4fWa9J6jibwS?=
 =?us-ascii?Q?LlZCO/KSTEh7vtmGr2IQKTahDyJKMewotiS++kOZ6M1tEPW4fD1dV8Kii/b6?=
 =?us-ascii?Q?z3GkaRQKKCocJkYs+eluaHyn/hAA0G1Aj+9qzugR9wnve/k6vDj9qEs1IOIl?=
 =?us-ascii?Q?srT/JPVHA6CzWH38/tZT4elLdUTbDuyiFQLIVXNjRlp2b69d/N49kuiafCdB?=
 =?us-ascii?Q?rwgUX7OKxZO71F7+c2mcDxQc9C3odtDgStr3sIs+Qoty0DlWjKASUEmyFLHX?=
 =?us-ascii?Q?60zyFE3M9WlPVdfD0DK8XW0A1FiuZw6EU8kuHCJn3heMzqV1UltkrYStvcis?=
 =?us-ascii?Q?clUFqXdxccOtve3zzBDKbbzNWRx3LkfqkJlnwiNbbifQYOl2nhizuJCFgthx?=
 =?us-ascii?Q?wf0yqYRvUUWyvELbMUNU4DU3awqMjmC+s1yL8/wDVXAyNNQBjTpm2P5dclIn?=
 =?us-ascii?Q?R3tQvqgOm2s5soWYPTmIBNiOC4kljHFZxGqFxYyrMQ7RzUhlZPBkBu7Klxr2?=
 =?us-ascii?Q?WuuZInVeeh4b9Y/mmhpnZzm9u0wBqfLqewO1eygAce0JMISgK/AbyFUK0lLi?=
 =?us-ascii?Q?RZhEsc49Hh8r+tN06e4ihfFpx0x+nPXBsfuAkJI52LsglcZzSjrn00+6SqFp?=
 =?us-ascii?Q?WDXQpMO7PXgV+Kk1EVNtFjl2dDI9YoN7kJeqeCJSW6DQjQo4cbdmFMptACFC?=
 =?us-ascii?Q?l3AeHcK/GIYNhtFJjNLmEyANBlvQE5lXjxP5l94tA5fFAzPyHHvoJiTuucfI?=
 =?us-ascii?Q?anz0upMoTzOQJLSqcEWHyq63VY52sFaq2aCGlpalGzI636b/YIuRvCJYhF1m?=
 =?us-ascii?Q?WawK+GqwUKbNzGtAulmygBwEdeMSdp58feGHxiIr5vaxylK+27XubE2X04rz?=
 =?us-ascii?Q?5CJS/y0brJIxeY+r6DpTahsG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f84a7b-db95-43d9-1b46-08d8d9124cef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:49.8970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPGSCX7pbxIzfIUwufSh2kfzW57QQQzXNvRueJJPcqV4L7LskJr1lakTwUZ+Co7vmhuXzdg/6//xXWpddfyvtw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

including firmware support etc.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 4a77c7424dfc..d872bf674aa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -47,6 +47,7 @@
 #define FIRMWARE_NAVY_FLOUNDER	"amdgpu/navy_flounder_vcn.bin"
 #define FIRMWARE_VANGOGH	"amdgpu/vangogh_vcn.bin"
 #define FIRMWARE_DIMGREY_CAVEFISH	"amdgpu/dimgrey_cavefish_vcn.bin"
+#define FIRMWARE_ALDEBARAN	"amdgpu/aldebaran_vcn.bin"
 
 MODULE_FIRMWARE(FIRMWARE_RAVEN);
 MODULE_FIRMWARE(FIRMWARE_PICASSO);
@@ -54,6 +55,7 @@ MODULE_FIRMWARE(FIRMWARE_RAVEN2);
 MODULE_FIRMWARE(FIRMWARE_ARCTURUS);
 MODULE_FIRMWARE(FIRMWARE_RENOIR);
 MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE);
+MODULE_FIRMWARE(FIRMWARE_ALDEBARAN);
 MODULE_FIRMWARE(FIRMWARE_NAVI10);
 MODULE_FIRMWARE(FIRMWARE_NAVI14);
 MODULE_FIRMWARE(FIRMWARE_NAVI12);
@@ -104,6 +106,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
 			adev->vcn.indirect_sram = true;
 		break;
+	case CHIP_ALDEBARAN:
+		fw_name = FIRMWARE_ALDEBARAN;
+		break;
 	case CHIP_NAVI10:
 		fw_name = FIRMWARE_NAVI10;
 		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
