Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E27C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1D1823436
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 07:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D1823436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B3ED89789;
	Thu, 14 Jan 2021 07:55:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF6389789
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 07:55:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz2r3J0l4m57SHyEuogUEJWCW2A8A/ITAK0wBrHrQtL07w1hbMOL1bgWOh9IDt6R5gRKQYIB1RUcSnrUBanTUbHVOKSevfOBUeipJ4oREf9pIundQ0W/ZkWoHsl566fYzGO51sXHI9nVRzJLsk8siHh+nvWXQMPG83aBnbIQAKib/03oBbDlVg0ndhHUG2a2vgVF8JCi/uosl7trRrlS23Qj0QKWm5XSE9zVbPxj0Y0Q4kAxifqQ7oQmp79HTFeL7XJeSUnJIio9Sv+8i5WaKn1ZXgyaQJpW9tdG+k1FnvAwYLA6ryUNtjhBo7eLKS85hJqmI9dPn4s5Y1Dv7BQ/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7KLskJd0oN48ptQM7zW8j6XqUwA9UbGr7FrGdDHu7k=;
 b=PQHtQ69x1rP4kD9Z1PZ4NcNA4g3oC/DekYE30QLyGjbqXk8Al5rDn7dkHsX1TXIPDoGq8ma79xRPIMPmivU4EsbtffYNBwO+wYLZ5QB+LceVY289bhtj3aVKNZE7vcjODBU763hVk2gFkvqwQnBUXoljz+562/9kS3S5q6FYMmZPPum9VhZUarAGNlMvUR0ul6Y1ywn9aSMffFDDjueCL8yXBoYR6FNlgf/MiRvFaWKXJf59xbg6sqtBfY20hNLKXPF8GTQYWDm97TFYZebcysAQAcYR4DIFxS6rZ4xpBJpP2M/enaRUnjGZyJ7oze4vFGM+Mw6dIW6H40R+5P1gbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7KLskJd0oN48ptQM7zW8j6XqUwA9UbGr7FrGdDHu7k=;
 b=PJZoUnH3whVsoeCn3NvaMkh06hiy33qy4F2xK/ZXEnxWVzMB9M5GkQ9DyMPN7shsLoTZh9CmHQ60GeiFTKuSGJzC90T839/kndkcx1A4vaB6rYZzD0n1p4xdDZd14hXm2UDiLBMZBSNF2ppQAtpYeuMDKtetBYwmw1ByjmDn6Qo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1654.namprd12.prod.outlook.com (2603:10b6:910:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 07:55:01 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 07:55:01 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: toggle on DF Cstate after finishing xgmi injection
Date: Thu, 14 Jan 2021 15:54:41 +0800
Message-Id: <20210114075441.12726-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR03CA0060.apcprd03.prod.outlook.com
 (2603:1096:202:17::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR03CA0060.apcprd03.prod.outlook.com (2603:1096:202:17::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Thu, 14 Jan 2021 07:54:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f82e8e76-4984-42f2-f325-08d8b861b20b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB165426E73857FE35AB4F795AF1A80@CY4PR12MB1654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6gW4rkGYRAGFneocd6dn192WDvl0eNomT1aG10GQcAOx4ysNylS57cxrcEoqLslShba0vgvo3bW0goUw55OXdRt0eCjAZLJknovTkhZRCFKPJUxAYsnc1e4lGzpVfo2YZcOwZ7yYLflxXxmpb4OBOLlmmfIkpMmVIxoqOxuG7jXNbvF3mRqUcfCMvQiH5F1allfphBnr1EaNlneFPXLDmmVyyapshpmbWuJif9CY1/KL/LdAI6Ox5Q1Hgc38AsWFUW+TLMVvFbiNMTsVPvG3X87+BZ5B4I9yW5OSIk4j97k+QMMGTZEHfAbrJKu6VGfbWzl6dxt8ckFr0W3H0ad75bc+yVBolxqqWvpoT4VHBP+1VLza8E4unmSLeARy7MJEEVrwb1alnJ9UdfGrxVdDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(8676002)(8936002)(6636002)(26005)(316002)(52116002)(7696005)(16526019)(36756003)(956004)(1076003)(4326008)(2906002)(5660300002)(186003)(6666004)(4744005)(66556008)(44832011)(83380400001)(66946007)(2616005)(66476007)(6486002)(86362001)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?np41K7keFJhOpmba0TB0uBqzgtjvwHUknL9UrUAi7cz7+EpNKVPJPdW7kGdl?=
 =?us-ascii?Q?fZi6w7ddf29ZOanStfgZhg0OMpnSh5wpZADkv1hhEzD/9YInbuS9YN9Pv66z?=
 =?us-ascii?Q?ev9x826gMCVlRvIa1ZXarE87hQJgYUgIhaEBvTmJT7mjpfjUuWrmmW14sTp0?=
 =?us-ascii?Q?O64drInwJTuW2K2TOXkuvSPrM91lOyUXuufubp96koozT63yspvQHgDXEwb7?=
 =?us-ascii?Q?MUMYhzMbRbRBdSVDVSm1SXPGHFobSlGb2kdGyTgc2xnwQx8/Js/ZOsN6ohf1?=
 =?us-ascii?Q?9PiT+7//55de7M8lW5uWn0WV3lqiailELMHSzGK2Saw78b2jZO8k0PRlNpC4?=
 =?us-ascii?Q?GE6h18CxFNzrCBA0FzwC/gZBDEUnWVzet+xJVZ8Z+H2urvCX1dA2/PEzNjep?=
 =?us-ascii?Q?pLXXicS1QSCGHySq35n5PoGyyzoLn9dZ/ujnNgrFVAWEU2Qe31OZL4XUQb1A?=
 =?us-ascii?Q?fQbSUWyxavhTaeTaPiSu7yp28xYkvyWAT3O6k8VCMCyFO/AiZouzL2VNmBrD?=
 =?us-ascii?Q?j1TwknhRT1zDeKBFoyfGk9r6WJ80V6JuOQBcgxVK7ayyT7ULGjk4W6r179uT?=
 =?us-ascii?Q?IW6cGqdcBze/RKjSv9kmuXr+JrPoJRGPweVTE2ORnYg4K0VqYLCVG46jti6Q?=
 =?us-ascii?Q?UZqC9xPtWYxiPYsnzAgku8X3DQYn0tTpu8gcereHgL5ttRmV21m/2YNu157P?=
 =?us-ascii?Q?PcK34TQFbl/Lz6CxgKXbR+MciE0od+yliHGMqcVR3LfV6oW46iE+TZreIMST?=
 =?us-ascii?Q?1rss4Xc/jAnO6Gquxl6NBFC1Hl+ex5gU3+HVXZtdMyr66mc3NVvPw7ZIsqa/?=
 =?us-ascii?Q?aS/eiOBo6CH0dDTycmIW0TFD9+PoYKPCTQcPvhgx+pQ/Mm9LKxqFrjhkYgLg?=
 =?us-ascii?Q?JieuqdasocDSUHY0L0VsQ9ZYuTN1i0WOFKmLsVK6kFWxV4t/bsCpg//kwRjm?=
 =?us-ascii?Q?B5Q8w4FSYKw47p3uF1j5wA/ZFenY+uWSkWp1gSYtaTrsBRyR/uSXbaDz7pYn?=
 =?us-ascii?Q?AVR3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2021 07:55:01.0101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: f82e8e76-4984-42f2-f325-08d8b861b20b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Obrm5EYeBcF9S9vwVEY6nq+p0s3w4wvmHBR96rwV81AsptZZOsR3gPv/Bs6OI3n8QGheoNRoeQsTTWzt7AlNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1654
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 5c23e9e05e42 ("drm/amdgpu: Update RAS XGMI error inject sequence")

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..a6ec28fead07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -846,7 +846,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
 		dev_warn(adev->dev, "Failed to allow df cstate");
 
 	return ret;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
