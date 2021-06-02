Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BED3C47096
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6488261C39
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6488261C39
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FC06EDAD;
	Wed,  2 Jun 2021 16:50:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C557D6EDA8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixG+yi/3FJ0rWix2QQ9ebIHHd+1d/oUX94AeWjc0g2rMtEm6I2TQ/W9wotIkkQwDxPhFdcfMHVBpjgN28ujBVbpUxvqzy1/WpOnZlzP2p1K1mo4oJexhmDKhD334SPqZb5LiiPu03K7E7do4t6yzgolep3kCOjRzOvnmOWDjFDDi3jKgTSnOxOsPV54SYUEBVXbIR7zGsV3CN6oCbJoK5nkSwIYFRUoE+8TO+ZofxrmdhNFRVQNgdyt8k7FPxi3zLKgP2Mb7gVGkh0tONwfNuhJznNm2RWpJ3hpnlat9xaDpuXw3dGpF3CICKD1ZpW2a/YY426zyDwM9lOaUkW0f8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N99Cvi42hZkO1s/+OS4BYP1XEL6KEo9qz2jM2vebQuU=;
 b=PMArES9tEL97qEgz+GPHW7x8Les/9t/eYh8tJL9P+ENQn1xpiC5xAD9XqToHluIs+bfXsaVl6G0N8Xm3x+idY61FrreYKhA5AL9E+uimY1LvDYvjU3IpCQX/qg6CqTDJGRqHe4ygjtCJD9IRUl0UH6CH/f3p9JlQjiqkRPyPN7CIixHSAN3FFSDq0XAdBCl5G8qf4wl1xYmxrCzRXJqbe46A85Xu+ylYI2YGzBlf6mWDPEVrjzNMFR+67nG/J7ph++HnZnbn60ZemETyZUzUd9gzOEPFl9Hu1RLQeR8rUQCYZsqRg98Xc2vcLDIZw6lqomwf9Iwk7E8CMLVSCazj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N99Cvi42hZkO1s/+OS4BYP1XEL6KEo9qz2jM2vebQuU=;
 b=MxjZDi6iuuLNnUAKC8YXlZb54Z27Ptf58f9Hv48tx0m9EcNkZbIVsdqesK/RDfFw7qbT/Cvrz+dhC8Npaah24+YnxI97JQJn/QT8ucW2Et7CRgxckPZ77ieDpr646wUcPq5RoIsVTGzSQTLlLkFTjHU3kmCfkoYLiGulyv0Ayf4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:50:32 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:50:32 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 46/89] drm/amdgpu/pm: support smu_post_init for yellow carp
Date: Wed,  2 Jun 2021 12:48:25 -0400
Message-Id: <20210602164908.2848791-46-alexander.deucher@amd.com>
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
 Transport; Wed, 2 Jun 2021 16:50:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e37fc0f4-5e07-4f31-182c-08d925e6761b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453424A91EE02761AECE364DF73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r4mNF79VXPd/1epcwcfCv3e437PQpVdGU8DMICVRO38+PbdfUt8Fh0aRo2bAI4aNRw7dSzQ0flOzAV+iaEgAJFZTCqY2ozhnDF/BB+xLIprjmX7UMird6Fao3a1YpKyPOBBW/ntc/KrPyANf0v1OGfreNpxIZVkjvqrNi7cBib69uFLkCFdB6Fo/kZoJci2/9DA255pG1xcXe52RL9xvTwbFOHLBSYUO0h5eey7J5IOuSFa4e65CD62GTvWFejsL31bJhRBgcOSeurgZP1XjoRhySPMbJjjyBOCnrDPxHmndPWEwcleqLNskFkbpItu1zd6FKeKkPkUa6UtZgkqw5MFClOelCkz8G+5Owc41YOGGVMnyKTo7H8brcwMcMVnp52svEPZRPKSpkZoo4DFVyXAs+q5GzgoqXEfbw3UzrV5ReEjZXLYaYM5Y4p59ANRoVA/x/ybwwCqRLgj6lk3ETZy1dDqbV4Di8LMtvI7hy309SFNxG2sJjLyFcTlliF9eJcu0zJi6WhLlRbqHWTK6vcDPtiEDX/npEXJKWL19cosEL8/bFY5ndkcg3bIr7+8q0UK46abEAT4GLrMTiwkhssV+T3IPjZ+up2+Vb3BrUZxIXKha373A16cNLPmsCK7kc6nw8Bo1OPjV3p68E76CBv/N2sAqjqMe8zMzFZ/IfqAfzKG1lxV/ZxaBQ4l1l2pt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(4744005)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(83380400001)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8V5bhKgTgCGU8tqucRrd2cgmr2nCRUJ2wczN+X13dT61hREquHjsPDi7fwzW?=
 =?us-ascii?Q?EkzYPgW40vYU9HZUHQFpk8JJjNino2880VJP8n3fF7VWF94hMmXj6sEawKlJ?=
 =?us-ascii?Q?NdyGVsOr0KjhMKBvOmWn7xQY/+eag6+GOHCFTVV7pun0xc+1RCQANzZAET+B?=
 =?us-ascii?Q?+bvtWUyWtW7dCqMfJyMJYCv13ddJnCxF/qi2enBbjarKJ+YN+XEYjWzhFrUy?=
 =?us-ascii?Q?n9uY/ZR5hDSYReuLSfCFlrPhX8GCoCEu9YbLdBeW3Pc8g/mIDTjWBctupnFU?=
 =?us-ascii?Q?G/AiHglvUo8QfohtYj19TJ2QbwTAwu4REJwVqPFZ7mLrPCLtx9WnTnXgijr3?=
 =?us-ascii?Q?OOn4sMTJTX0vdQJ8jVwahoAQXAXeAh3v+lG7/eJ1CNsgl5gFWMsf1AgosHQL?=
 =?us-ascii?Q?BQuNclc121sRag4stQ/VcMqmOYLKJy98b5MM1H8YJzLga/iez7picXJDCFbj?=
 =?us-ascii?Q?Dz8VQV8ZmFI4zatJ5A6Jc/4riTlqGBJToynVM5HSBEBYokAuv06WJJ9b8Rbw?=
 =?us-ascii?Q?cUa4QJeU31dmyezm1pVZmfZOEHU+FfFl8IUcR2u78nsevSm5AgkcSeUp7nnK?=
 =?us-ascii?Q?85bEr8/AVb+kijlCCDbXrL4RFrVtQq4s4QiNuKy/tRii/I49CxIeO2eorZ9X?=
 =?us-ascii?Q?jXM/f24pc3IPkbjvu2m19JIGNWBVhuDb8TbWYiLP3ggsG1zqXvVJ5taGGGTZ?=
 =?us-ascii?Q?naNrkp9VlyxH49o+SrC7zH8QT57WMwYihHTzoWfcxkx3rCvoedRSM9VTtAu9?=
 =?us-ascii?Q?pGo1kaTzNojUhctRPeCGRYWpCqERGZCHKWwvD6WAyxM+07vMLCYCQWveXOUA?=
 =?us-ascii?Q?l3J2cMAdilb+TT0OvdmJX4yMOGsSCSDSmFAMY+sAJM7TgHYR1Pk44gYrjRWl?=
 =?us-ascii?Q?3VSmZP5wL/qr/NSS/5YQ6UV3rNRA3Pkfl1v91YbWOOFcsUEzqBtJRRsr0jOB?=
 =?us-ascii?Q?2ny0GpqRyq0NPQxXHujIrEak2MKthKpgETuR5e/K+1yQ1H7E07MU8xOdxI6j?=
 =?us-ascii?Q?2LqzSDhtlDc/AgnAPE+8hl0k1N/iVNd/nWU07ueMWCnP7z2fbQp/AZUYBMwP?=
 =?us-ascii?Q?5YjSnD7OtvVCGVlPr7+y9J2WuR8+Rzywq/fBXU9gwc6StY9q0P5eG5Yr6ogK?=
 =?us-ascii?Q?ND6QzDO3DxSN9LN7YND1Rd55CFQuktLcajAuQ83yQZiC5gucnsw6gi0bVoaQ?=
 =?us-ascii?Q?20a4UrxXqd7pj5xF1UAvN2pqIqel1KY21z1FX4WxIDaIGbu009Wp5e0H+inu?=
 =?us-ascii?Q?0RUcvRihCmra089ylvYZ2e3C/pRghwaVoxSKn8TSZBHE8IQac3ndgUcSjVB+?=
 =?us-ascii?Q?3spYCEUW1DvTnpF8/0+2/bzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e37fc0f4-5e07-4f31-182c-08d925e6761b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:00.6258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgMFYMjRJvPUbJimmyzhWXrNf1Cq7K4FoQ4VLmUEFYXEV47yfExGFlI6t7cJyO1598UeafmcvW7VjJtupGGruQ==
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

Add smu_post_init support for yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index bb2c42d8afed..6aab65c684ba 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -662,9 +662,6 @@ static int smu_late_init(void *handle)
 
 	smu_set_fine_grain_gfx_freq_parameters(smu);
 
-	if (adev->asic_type == CHIP_YELLOW_CARP)
-		return 0;
-
 	if (!smu->pm_enabled)
 		return 0;
 
@@ -674,6 +671,9 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	if (adev->asic_type == CHIP_YELLOW_CARP)
+		return 0;
+
 	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
 		ret = smu_set_default_od_settings(smu);
 		if (ret) {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
