Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61497C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F964EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F964EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B04AC6EB76;
	Wed, 24 Feb 2021 22:21:45 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCBA6EB71
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfBFtM7nnTgRpFs8F+XUrr6QwwXQ8uTQ47P4jnCeXsRcg/Iv+54HQIT07KLldlUEYPRqDJ/VCN4DxBb0VfPofn9GxX3nkrMnAsHi6jvIntPImQr/w17n+Z4NFpKzovpSPpta362OiUhvSls36UwJnIQmdaVGgtGG5VqTYOioeLX+OQWECFFRT4ztrpOnL/H6s7xxNo4rqNinj7RVM3rBFFxsUMXvSaloLp3J9R97xCDqLFvTWWXfviZ9lWNAJYHUM0VqcP8zjZ22E68CXof01/pEht0tfttXuMbsXzzMrFqiC8V39FD/QoL3kdbcfe+wae8nMT3pREYQApGonZNaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4gxLc1aaalqp5IiwyjafuiNHf1QpfMzOesj4LPZSRI=;
 b=h2FDatdvcVKFHi6lJKpiQCFxnt6zNyOwDF99gg+Nw8EFQEy9FZQ6AlHve8iaFbEMBxr6ypTO7kLLefK39BQIciuJHYe0gsdPgjQ4mCZaLkZ016DOSb1cLmEXrlcrgOyOgwceEVPOqCWzqOgh7pjkWr7a6YqU4yKh7AM+ZfyBn8X2TiIlWHG1BTddX5usK8nZQLAQQEaSbnUrq8CKNs5/C0kBjYEV4Cf/6nWS61Qdilxt6MloJzgRfWnMbOHNmY4LsAIkSqwQI2+QvPwQV5g5y0FRjmKBMXlFBjXVj5QsA+rZHjmoctEMIdAz9pjKgBHvUoyKsjN4VciNAV4EMEdZig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4gxLc1aaalqp5IiwyjafuiNHf1QpfMzOesj4LPZSRI=;
 b=cY4GKeI/h2wcTY8YzR2+i/CRr/iy9i2nDu9zlMoBXPunZ8kiQLTEpjzcaTcu1RoAaJoJeWmD1IM1A7oP7iT87demfVmCaTsKBD9LK+tvAtNfZr9OLLRgQjiJZozPvNncB5Ruwn/V161yHCJRUd6rrRUOQpqJQ9jmnZL9mILplJc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4798.namprd12.prod.outlook.com (2603:10b6:208:3d::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Wed, 24 Feb
 2021 22:21:43 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:21:43 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 101/159] drm/amd/pm: Set no fan control flag as needed.
Date: Wed, 24 Feb 2021 17:18:01 -0500
Message-Id: <20210224221859.3068810-94-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:20:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 680e5ee7-01b6-411a-e0bf-08d8d91266b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4798:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB47986517834C732C10334097F79F9@MN2PR12MB4798.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FsR6nCUHyAIcmJYAJGA8dkZzPywpvs2Sw76AZMGNPpgnrwkhgV46RAlG3UVVq4K3C7lhEhVy2agCGzTujhE4etxuubwsmS6GekwLlp0W/U4+PN8AlziChQolosLZi7+T7kHbccnJ56sLs2B0ZZpZhv7hpmMAUFxbCvaJTM/18WjpNbIiAC/7N3KFS13JIDgGMxUidUi27w5pvorAZ9bUFQIfwwf91eXjWkinq3MLkuBE0VLtuP+8Xvs+Usz9D6KApcQwad0RTb6jTDwq82HVUVcjMlPRO6TvWFRFazq2R+EwnJ40DOsCqyv2AusIdw5MYG8bwYa09ugzJh6EbPNVlwuoWLSRemFHR+rZJdUt8kkqKoGe6egEELysQ0wBGtdrgYXZj4QNatzH0zrjgeeg+PMpd/uFnV3G4xFWJU/yVmZfBOXSdiynztNF0yjFyzLRGEMaIufJs2AE0rXN7GyOMWEBn1egRIRIGOpbfoWo1lpjzv9HFDuP6ym1Q4I0Q1cyz9pfd8qdXPIU5ZPTrX3pNwTAuGRM60Zm5dhKTr4bfwzjaYi1+HYrh2D8SoaF6PZLEx4iC0CaOQz3qXFODbujQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(1076003)(8676002)(8936002)(186003)(16526019)(6486002)(69590400012)(66476007)(66946007)(6506007)(2906002)(54906003)(86362001)(316002)(6916009)(66556008)(6512007)(26005)(2616005)(6666004)(4744005)(956004)(4326008)(36756003)(52116002)(5660300002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2W79gKpJeCo7qUZwsGWf5T7dopyL7oGLOBsHjw3BbYDRPnQ442QZFMmOTlUN?=
 =?us-ascii?Q?nRUGcrn9erMRreNzo1nlqI9zmwI2pJiCYOsUxPP7fHHsCyJ1v4rPlDuxZbBV?=
 =?us-ascii?Q?0+mRv49ftyb0h6D+PeQPw8I4vIVBdeM2UqxRz6v3FrG0RnsyCKm+znF3VXMN?=
 =?us-ascii?Q?uhKsxyW2jpXRMFKsFwBnW3p58As7S3eXMsyyKGlcBWTcfLLYx97n+R4wFfYb?=
 =?us-ascii?Q?eyyOCt7g39+gtH6UEYqeKJnounrSc+ITvY/vSfKO9LBzhX2QLvBdg7JFW68x?=
 =?us-ascii?Q?UG8sM4PVUBJ37+2vweFCbEo7FDWJXy18I+TRNKa8d1W+/ibwqdDO5s3z0EcH?=
 =?us-ascii?Q?91qS32yRBD4IsWHZRh9GUGjY6OG9+EO4yczffSsatL1izpf3iJnagEJiSdUz?=
 =?us-ascii?Q?erC/WCsKYOuOkY8IMD7aDSbv2KFFXDDgebWpHhE1CVVzd1dvwA/PlaaBgKaX?=
 =?us-ascii?Q?9niah/ZK4/Rq+LrZSzr6240Xd4+PXID8F0/wFYbd9lrMly2/U7fmaW0pw00X?=
 =?us-ascii?Q?P+1xe7PJ3hCkyO1J8GPV0tqb5gPrWwEql1s4PABFG3HVJXVJpdmTh593TYVx?=
 =?us-ascii?Q?XOhaw8blMFYi9kDfEBjuVHgOoOfb/JKTt++ek46RgVWPDS8hN260HuLaqFfJ?=
 =?us-ascii?Q?eh5eXmuXYvGVLWCfFPQKMjnHFhWKkp4cw1PR0SwvZwCm1oliPonoAWWEcWAT?=
 =?us-ascii?Q?ljqOGFHcqOHfP55G5D5qYAhQsNViVRScXtSPUfKnVu/USUU/yV+NPq6XQBzX?=
 =?us-ascii?Q?IVFwy+F6MglkmAym/Og4TRwuS/f55ZTdPwVrpNSUIAU2BXccah5u4r8pT78n?=
 =?us-ascii?Q?WSPQAX+89n3GZi+Bvt16nkGwpUa42DN2SXhAAf5s1Wp1pFN++1fi+xHP6P3X?=
 =?us-ascii?Q?xoUYQ2PyDX+oss2ZuIWyzbtpx8efdP1KegUKlLjiaVA1Kpea77cEbo7aLr1v?=
 =?us-ascii?Q?AAmABvbLXDNAzdHrYi+oatqLYCoZO6M0NRvgjJwJLfKqL0xkdmRY760v1e+t?=
 =?us-ascii?Q?Rp4ON0Ygghzu5aDPbfYY+cLg8iH5ujsgVCExyOX3Nrq6OgVZtBIXmqscFz5z?=
 =?us-ascii?Q?dlN695jWOnG6zkxN+CAQkTOCuSRKecMYRTHo4SiKUXKxa87f/DgoND/961EH?=
 =?us-ascii?Q?3JuqX0Ufc9W7w5EzOmKRhu9nEgnhMRXe+lEN+DkQj12tEbCmoRSl1ShjNM/+?=
 =?us-ascii?Q?1tIlil9E4sXsdM5qVCQvpVTrPd3Oj2Go5Gj+nxe1ny/fLjVgn/nRc76qH1WB?=
 =?us-ascii?Q?BcmZqEvjpdZp9CBzhZL2DTbF/fiEN7VyHkcwkRcD1SOsZmCXu+6Bwmf73MI2?=
 =?us-ascii?Q?958OnXS1Z/RqTtnJq7C3fRE/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680e5ee7-01b6-411a-e0bf-08d8d91266b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:33.1421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jydaLOvbKS212tcsJc8WZciBNGAaxSuxFSrGLnnwuhBg1DI8ImnVJ8JhfrqJhBBmzlYemqs/dGZYC8JxScF3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4798
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

For GPUs that don't support fan control, set the no fan control flag so
that they don't appear in hwmon sensors.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index cf81b2ac2232..90a00bb986b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -995,6 +995,10 @@ static int smu_sw_init(void *handle)
 		return ret;
 	}
 
+	/* If there is no way to query fan control mode, fan control is not supported */
+	if (!smu->ppt_funcs->get_fan_control_mode)
+		smu->adev->pm.no_fan = true;
+
 	return 0;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
