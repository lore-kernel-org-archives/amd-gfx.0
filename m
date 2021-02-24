Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BAC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8107464E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8107464E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D454A6EB3B;
	Wed, 24 Feb 2021 22:20:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7952A6EB3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DngJoFwcQNiqbDpgflIQD5N5YLUrv5sdXPQkJ+Fj9K3s3Vc+NLIs2Pcs8Jec4tmfdNSYeYcqqpJXzvf2EmNI3opD6eKmAd9YJ8QSTVCT4LU8sSF+HFbRLG3pNpXNYuARKMugtSwj+9qbTmPrHNtiKzU1CThtv8d+YdO2WwFXjzR+Hk5GHoiN+1tPv1WN/EJZZgvgIJhvXjb/QiyKqteiXi+NX4HIQotenRyobGnjGyHrmRkcIQmmxCZEVf/Ovw/G596LBXMZFVgEgbz3c2oaBfWIkjYQDrprBkztVxDrDA3qsyOhHjn8bDLasyAkqLOq4+GDDeQuskMtLanOfjNE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j4VupAK5nrsnse1i4wVPu6rRODYKvVf7ImQum9Q0eU=;
 b=LsxFDb2bJ8FhugM+MTrcQNp4w5QfhQVKjz/V5eievwtM/a2fz312wh+fdC/iuYK4KYXHP0odFZGyJkahqfOMuGmolwn67ZfyPoSz2xUFUPJ2fyN/6Uv/c5F/YxDsTb3a0CLFliFpU5cL2nMA/GLSwbmUy/tqfP4Hd7MHLTIdSV3uS4GT0Mii3lvWGYUQoPwkQu6jalxrn3LeMFGxIhBqzpGNQSFTXTixtFnLUgJrGu9zlXlF26l8zaDTC2qpP5muZZOjxk2TqFLwgrlpibKjeoWmaFmQsAbt/8OchxjU0Qfyobyp+no4M/t1MCGywxG82SLBQgS7i3/loTDePiPMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j4VupAK5nrsnse1i4wVPu6rRODYKvVf7ImQum9Q0eU=;
 b=jneYxcREAsTOc1tIl5VkMvRTnJdMSbxw+Az1KF6DZowvMBqUCFUmiz1tOw4I3OL8Hbovu2knbxsFb01C3ngL4XVy2ErKOhvG7+fli26NndE+JunE9njbZX0LTGcMp+NwB6uW7okkGoQeNeIdYHKEe1QBy8kq+H8WBTTlO0+6llc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:23 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:23 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 054/159] drm/amdgpu/jpeg: enable JPEG on aldebaran
Date: Wed, 24 Feb 2021 17:17:14 -0500
Message-Id: <20210224221859.3068810-47-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ab90a0c-cabf-4ecf-8c56-08d8d912514d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4175E58FFCF1C27B1E601CE8F79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fp1EwsVTOkB51yqaUefYuTeF8manvrMV5gyztA7Uo/eZPyhRBkuHnHOBYIZdKkcllbHN1c9SgmDhCStvLIdS5tRs06CT0ZzpuWW69unJTVrEpvc55CCQLkTojFEfuiSEt+qhcF1ZMFSRDkIdOjWmCqOTOhGV/DUEQ1Ijgr23hE9raSKhoq7g7PYHD9xUD0uzxsMxk6IkyxfMtVoWlfXTpnsTPIq/qzZ/eJePKovKWDW90URQmSdmKg+c37R+nIKNgqYSOGUStAv2oWNk9wyo2AnHdkpG+G0pd05+vzFxvCPVNfh55fGvkfl6DY1ecyWXicAyyGDayMpiX2faEqpv19AJKYj6s1A4uYSR8g3aBef0ToA0N6ErPjEwpOqSAKLZbywE+o41+wQgK+bjuAfRwf3rE2HnbfWoT/bsPgo5T1J/xygTZKHGrTeAVogsYBE4Gs9uX59jToLG1b2egPvybjZmym7q0TwBdH50r+xIkQHW1xy0nQBAIGQrs7RncRXM64cnqbHBOJ4P/SSK5II3lC5sqg2aieRuHQ1ildN1w4m3lrciaDQnnaAOROgVUbApQ/ednOHBQrNw9QpzByd+Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(4744005)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6s4jQAbK4m3YkbWKwOBecMehYE6fr45NMajIqbOsjU2o93skV5AsD8PmmdUq?=
 =?us-ascii?Q?NBn54S1vJ0mTwHdVJvH8VxbQIN9odYxD4c4nLF4MdMrc316uwlK+XMnbZad6?=
 =?us-ascii?Q?r+R7a8bAou+FBrEAT6Ntl4ZfVF+CFgmmUuS0UYccU7OLzknjOs16fvW6d9LW?=
 =?us-ascii?Q?OMCxSxu1NBUnftCekRIztqlb1gynYBjWvhc4mbhAjH82nk+I4Fh9NXq991if?=
 =?us-ascii?Q?gsRLGJbTcME3jGq1nT2ZRprRLf9txpax0AF6fuKatXg8WaF/fuBGqMwxsnnf?=
 =?us-ascii?Q?viG5QA8m8jMFxQUbsl0XLybuMo1+YPswxgQIJ6rMipQd7hg4HyCOY21uAx1L?=
 =?us-ascii?Q?orpdjN8rFaF3Lmw+Hksm1Olg+71I0ejHbvWdlP4XjORUlG97fO9u8TOMht70?=
 =?us-ascii?Q?KWaWoweE7I2sziPwrQ3zVmeJ/vf5i2dUNDzKVS96pT3dXdlLj0hX+Bxo/zfQ?=
 =?us-ascii?Q?I11hUS/71+UyqEkNG6xjdG/OpCYHNL+/kHWf8nSwmamcd+4DP8RgW33d8N9F?=
 =?us-ascii?Q?DHtmOajK/dCKmGtxWnZLlho/WFHCuGskJ80tbEIVIvUw/xqPoi8I+V2jLU0t?=
 =?us-ascii?Q?tnK/qW+ryiOxjYWcNSqpGnzSVva8xAh+FtZWD1WC2dC7ZbptHChAoMusYff2?=
 =?us-ascii?Q?BH7/dQq5mt9ZdRlK7gLoBvscZfPf53gCG+wcaRPJFDy/Y4jAYqgLWc5j8O4I?=
 =?us-ascii?Q?JBysD8AMziYExM7YQ74rNAQCCZeoXMvsHQfyicaCn3UyzqavpaZLyOWxtQVd?=
 =?us-ascii?Q?0jd61Dpc+tlx6E6LOAApT1qHzVb5Q8d+a85dFm27fW3qmrLLcrGr8628HMkr?=
 =?us-ascii?Q?Bc5TwEbxDYtRIlGuvHAXoCucYupM8IZkwYbxE1ZNngM8FINIaBOSYWAOtQjJ?=
 =?us-ascii?Q?A8OfTc20zTSXbsES/YyuELfnQ9vzjRiIoP05GDmzYMdSFhanbs87Rdy5pIPy?=
 =?us-ascii?Q?W1ewnY4+kgHat+1X4Umw3VVFy0FtQoBTExGpuEuIcNSGCb2tFGQL0PF+zUFK?=
 =?us-ascii?Q?6zMftdYkm6CcsvqjiYzlOz8cyuCJyWa2o3wrILGk9RhubQ7RtACOvIKdx947?=
 =?us-ascii?Q?EpCJO0tt/8uspby3b6ZtO2vvEZNeqsFS53A/5VtBqBF0K7nltc+yc0wbGa2S?=
 =?us-ascii?Q?2w4mdyWorTDgTV1DSmYi4c/vdM+XGNJyknT87SyyCWSplBLo0JMMY9mMeu8u?=
 =?us-ascii?Q?x6DQWcpUnQJcxK+iLiIoOhFIqLE2YZpH2N2x7lrwrzAiGrhQjz4PLI0NO9gO?=
 =?us-ascii?Q?qTKRqT00dTrKZdmvOYQ4Wr6Thiroz7CtigAQcChc26gOdqx01TWXZatNbpmn?=
 =?us-ascii?Q?Cf41RmKFq1vMd9nZV+Um5ewr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab90a0c-cabf-4ecf-8c56-08d8d912514d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:57.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h9DIKOEYs2FjPgOIt7xaokNAVRJU4O8pzYJLtMW7Km06RyyGXRN8XO3WlYs6YN5rMMrlZZblLWo4MTqtPzP8iA==
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

enable JPEG on aldebaran

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 99c254700fd7..67bfeecf62f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -850,6 +850,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v4_0_ip_block);
 
 		amdgpu_device_ip_block_add(adev, &vcn_v2_5_ip_block);
+		amdgpu_device_ip_block_add(adev, &jpeg_v2_5_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
