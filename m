Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D634C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BD360233
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BD360233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358366E054;
	Wed, 24 Feb 2021 22:19:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C8BE6E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ie6/tAjYhLTKwbx17njS1JNWN8hC46Z7owmvrZM3qbUi4rB5ryK4nNK8FyUmyNJWiGiNezkfojr4ZoM27Aa+XiMT4lobHKEvAYR39jTmeASbeviiWy13hhrbhdtUmsQXDOT0Xbuttth1/KVwUVQzHW4TL3Sslo3BZ1Ig0j/ucMn0WLNpKFaFduU/ov2zeiIBFhT26+UIIXyc/YzKAxqd2/BWT9446DONEBaLsFONrZEYqRMWhXXdvS6byCni+EN1TsxZzgzsZDITuehKWYKzr44gfMy8coIxVrvr4Y8RN/HEo45Mw0G0/xe79zX989UzO/hWyuhJecw1c4wuHxXzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cixooq0/DTyx/gjO/zdK/vEevBmaHaThs1s88k3ldwE=;
 b=M+8yYlVBcFPiQ6rFG3+XjV6zj1DYKvnvZB4Gy8mf3k0Zrw/lchIwkRP/rLz7vkxkS7NKbUlhQghSqMRNZlHw6D62o+rfozu483TAv7+UJ74AgnnD851G53AgCFCGs0Av+AeemI/3pUKHCvAZYKMR4DT1BQbEtBciJ3tQlocYVl0+G8fUsy/2UkAVHK8KxsJHzbx55uF6frEtzK9FxYUvy/cJvWAPQgwCFQXWlSUlilKIuZm+iZ46hatC+/mRG8jJHGCqm+YWo+yguunx1qYCoAefhKLJ9odkk1K3ofPQikWXtXn3JSzQwMT7skmcNUrsRcmqM0/0RFghgvM/cv1NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cixooq0/DTyx/gjO/zdK/vEevBmaHaThs1s88k3ldwE=;
 b=1jSyq6rhZu3JAhmsD7EMmWT2ZI44yX4CEtm40QaZ7eyuQUfSiJ6tx78CzJTEEe/QzyiRK+FbWO2raVXfdNn9cGuYxbWSN0lOmbSAMNOSg590i+SdmVldBNMKcwSBfSiLDCsaecMBe9I2JGf/7yYoRGB5+vK7/p5zRoVQI6uZrVc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:19:42 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:19:42 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 033/159] drm/amdgpu: detect sriov capability for aldebaran
Date: Wed, 24 Feb 2021 17:16:53 -0500
Message-Id: <20210224221859.3068810-26-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2b2b81c-4711-4bd7-09d9-08d8d9124867
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486581F9B59C830DB3A413D7F79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Xg/IetBp/MKlYVGGAUo/t19K69kf0pgCTWA0Pr656sE/Gac532vWMmWfVf69ox423EgF3utWc/sKAmJlX7nTyV3DPNbDXhoznUFBE9ITZqu8+nKatnY2ztVenWb/R2Cn1/RQgt0spLKl1NiwwiVMUtSQoNipPGlPicIXeEvBF1MIPZ8fKjs3+XK2PjStCu42GRIvPQRHNhCCKZ4RUSRodLmkt4hQ330NMVKOBoGNE748tov1BUrOjxvjDRoQUbqglTtXK1ZWF2+bNOUHPzeqH/iIF+edJ+TG/BE1zAwsCoqgSKlb8N3yVd9YBk/ZzqX1CWjH/gp292tiUz+hol4q/axdRraNqoHbhej2pXemJEkI9M6NQGempV31s1vBocOcIKgbb1Xy7+T94MarNAoASSt4elTckzzIKoyvnk4KQiLf12fRS26IJPtLj8qLC23EYk+2PhBVmU1UY09wSNGfYYz+A1MNeUS8ErB433SwsrJw6VOkkCEtw3ouSi/P55dV7V5HXoIjkz9Emy0BXzb+9va4qC4IVb7cvbvehgDqLR+CAGG6RNPluJM5SpVztt7KJ+/ThVLp1NgJoxvSZ0EOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(4744005)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eTv5okPvyj9SNTk0D0M9vue0PZC1K0hr8wSvNgHgFSlAgBfUPU8hCqk+dDvt?=
 =?us-ascii?Q?dDvQd5WJD7DEE1mcHUP+0iqddFleq013CJMUSymTJ5A9HjvG/DiHrcYmgNyu?=
 =?us-ascii?Q?OeYuy6T6o6aoTU71Tl81hyaMUnpPjvD++aduNxQWpiYaA9TsfMMlFhYw1h9e?=
 =?us-ascii?Q?RmPUo0ugOew59mhsF4xjKnYNQ4nyL/96aDg9SgrWK4IAGFKof1zC3Xa8jFLd?=
 =?us-ascii?Q?XjvPA1Z/9fcWNb3KZZDXVA9yxg3cHshdk5KO5MY39F8Ce5izliAOPCZuyrCz?=
 =?us-ascii?Q?f/cCBP+of9/gFUs6Q4lJNjnfZBh0N8HFPwJTtGpD8ANA+r2xuH+Af26tYuSF?=
 =?us-ascii?Q?SeYDKoRJ3JW1uWKb3PSMjjmZ2kNm1G5iSjrHqAN+cfULilezyP+WZz6LaqHf?=
 =?us-ascii?Q?irkT8gWlNZl2REbQKf5OjRkBuG61AfCzeuSQCilAsvendJSi7/RTG6F6thk7?=
 =?us-ascii?Q?akQXdHURimTSTkIo5nJ+nNvQSPWhaYbsKlAaD1V9V7daTZSrAy8eXECZ/0Mu?=
 =?us-ascii?Q?scVDoHHYOFyZBBASukExtlWV1svWkucwZ+KE8c5D+inU+Yy8/UD0GHivnlS1?=
 =?us-ascii?Q?d9xQmKMEPNr6HUHWIpLVegekogoXhK/UG/RV9NwXD9ss5tj8gvWVuAWijpaI?=
 =?us-ascii?Q?fnXXiaDP98yCA3DudZv2oqTz56NmA7aqOkp4wPzsch2QpTYlxK89s6xY4BJD?=
 =?us-ascii?Q?W6ZaUqZS3FTeH7Bsp7fHj17E35We/1JZMaHEjotZ4M0ke2u+K04g2orSvDfO?=
 =?us-ascii?Q?AFi8oODJVg9Hd3WP3iLFFvAAX3zrwVLvByC+gTCRdW7i+zTOkIv6Pwul2Qyw?=
 =?us-ascii?Q?pdrgEz1HXQiRPboSePJ17gHYuMdtR3uVG3RzjEnra38B5qqrrXsVVrpG6QcT?=
 =?us-ascii?Q?VlRiMxoQYcdA9W5CqtwVy4CRJLWUYrePv7tm84MuRWlmDV3K+k1EujDyjEhC?=
 =?us-ascii?Q?NFpccdmmdwAKRi0ikCVHzOW3qW+PU5zCZFQnoCfUOKZ21qc9LtMbzcMLBbm4?=
 =?us-ascii?Q?OfFGFtLjMxxuzAcvI1SsmR9+DUaPbo0t1a7tpXcBh+ovgOD8F3EtnVniKEuy?=
 =?us-ascii?Q?a+Bxmbmujsf1sLJungFT6Dm4PiuCawkhW531YG6q9WDAUP8VHBH+hSQkJ7mh?=
 =?us-ascii?Q?wSXARtEqm7HyCOfIMM1RrWpfcNiUrwJrlFJvu92QUL06mw8M1U2kDqN/oLt6?=
 =?us-ascii?Q?viqfRcnw6SmyZJ7uHdaJDFB4abGLqSm9zmJ9ESyd8sALjkmMFg6RmmXJ7agQ?=
 =?us-ascii?Q?mUCv5IPCPlxguuWnNfVQrzV72XAFTBY/LmCUcP1pdCZeNC1HSaRByRyRi4In?=
 =?us-ascii?Q?yTMG6mTc38/TkZjDQ2qyZ8mA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b2b81c-4711-4bd7-09d9-08d8d9124867
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:42.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2M9g3n3Px1x27Z09RspPcB4WGzsg2T8zSUgEaTi7Cv2qI866YF7Veq8VnVdkyYBtBFisauMyF2Y3ktbHhd0dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

SRIOV pf/vf function identifier regsiter in aldebaran
is the same as the one in arcturus

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3dd7eec52344..41e7392e22bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -638,6 +638,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
 		reg = RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
 		break;
 	default: /* other chip doesn't support SRIOV */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
