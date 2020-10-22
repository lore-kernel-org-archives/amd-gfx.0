Return-Path: <SRS0=NxiI=D5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D0C388F7
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 19:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96B5241A6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2020 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ecqflQmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96B5241A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC36B6E0DB;
	Thu, 22 Oct 2020 19:41:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B756E0D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2020 19:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZLoVvhWsjoikEMud9/MOR152KIq1X/hWO+hYQvN03haTWGWOrh+OXkKfdQdz0sIFceEkjjVJW1G3NcY2I7te7ZSqMrfDG3McQuvDFnsMHmsjYqVkYyVMiGtF1JiegaYfk6CEuYV0WePInoJAEbjwnR/6346uLcIi0DHttv4VF5mSMoYLjUadjtAwFEbaGEy5ahsAoHtJ2RYqdZFiRAz8qVoQA8/Bq/sUXEHfrnIrjBKwXQqH1C/+eMLL/KxH8lFR04BMxU+WnWjYu8khPS1TRPtlOj23V9UTJjcI8LXHTWxc5ZYd+k3gKL5cSUHeKygt/3Txqv5Fc+2H0Oo3CrKIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9xux1dLizh3R515ZhZfmfHb3N0QnFq273xxdduuXYI=;
 b=NIAQ7/929qS+Hla1dpcmxnTVtP9UmZEuS5DZijSbGne5nfkgd0k1pdNJA0ddIGz3nZ4PfgCwRZdrmxKryI6CvunXMufBCStzEOyB2R0D5iHk3Zb4vA7+Rp1uRIfuc7Z+lKkBvtW9VCmYXCaPcR0OCeYv05CcLcSgbZuYOFa2Cr4y8nx29I6p5ESnNB5xD/oGGbl+MZjI6hAxPo2UNISWVk8COjPwT39UqAZjvayHc59XJUzVtRLOrwdeXwi2MeEoysH+usGh8df4cHfQk9CUfGECgO4r5oNS+ux4541OqU/1AKmO2Tof6mh3OBR78EN+iDY9Y+pWZ6zCpxOPrzJQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9xux1dLizh3R515ZhZfmfHb3N0QnFq273xxdduuXYI=;
 b=ecqflQmPCzCCcsEkV684JkuP+XJMnlhr3RzW2DdL/2zvq+tLlGDFIfaYMxKN5OaxfBiAh4RdEPoPxjUsoLgK504hs6lyh0LQQ3ngnQrj7AOPq2ORX5aoNpIfq6Pog7uVIjC2yWFSt5vx58imHOMF7Z5DMyxqiogewivEXl0otI0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB4863.namprd12.prod.outlook.com (2603:10b6:5:1b9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Thu, 22 Oct 2020 19:41:29 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::9c4d:ce40:451e:6e80]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::9c4d:ce40:451e:6e80%7]) with mapi id 15.20.3455.037; Thu, 22 Oct 2020
 19:41:28 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: During compute disable GFXOFF for Sienna_Cichlid
Date: Thu, 22 Oct 2020 15:41:12 -0400
Message-Id: <20201022194112.295794-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Thu, 22 Oct 2020 19:41:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0ab2218-7849-41f8-ed4a-08d876c277ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB486368197DF46F3109D1A38F8C1D0@DM6PR12MB4863.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xm4tY0rf7ndWgG/cpTCnGYO5u7dsrWlO4rNQ5VdTcKrTohDpX7opdkmxWIeacUKlV6eS4hoMXsQV04Ovaj/mQdjK3lygjxWMZKcruiYJ1UmWynBepJigDKSkPQzE2pd8/3i4RgzOngUlmwtN5Ps68RqhqTDlcZiRRCeeTUTLBBO2nEcazWqi48yude7opDOIhxA6c7dQRhctcu0vVE6koCIrKXrRLAG8CE3HgzZKKgVSHDFOizyiZs6sZpZY2VUPsEZE3uWr0iZ5b9cd3bILGzCstl8SMGczZugWOH/3W4wkGr98usrWcHrlcqFtsG+Kyyr+KMocj1qt7OdiO+TCdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(6666004)(478600001)(2616005)(8676002)(2906002)(956004)(83380400001)(52116002)(7696005)(26005)(186003)(66476007)(66946007)(86362001)(5660300002)(4326008)(4744005)(1076003)(66556008)(6486002)(6916009)(316002)(36756003)(16526019)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0asmKFfUnkRe93o1gQCZ7EpuySnsRO+7F1MsVljMxPcVqnprsWyP8YQuGRloN/ZaZNCkJ9+cP3GZ1PJST/bC79yrTi67LkJmOgjiwFJvsW2/eitmj4MaxBY8tbjAMFWncq+fvqmY19vWWMykYA0bwV9iOXP+LB8AOestCmKVJHWHI2cMvq2534x1sYapD08m7pX5TOivJ8RBODKNZ2DiZYDjsJT9TciGZHPYUtuTF8vr6Meozalznpr5kKyRgVpb3MbnkglnbWrzhD8iS4wIeGOuP6u2KmqF0HY6/V+FmQpKZnpbQ6tfZrSpInFibnznPt92jdeEKWzK+x5cSAMRuEpRSFG6NbdqTeR9XIowAifnsM5mZlnHWY6ovrntPU0ekh3eiypja89n90z+MM1D3bTabyoBwiMMmREafEnr1l/XtzN6UxKkbEGJcpwfrG6oGe/Ve+p8vXvmYNqvJFyHM+0KIctLmBPeimpYmieoHR3fs5LiJ30HxvxcDyyI7epbq9RfEPt+TFZDaPvBUM945e7skY8O8eX/J+pbbRr+aPfRO6YolSQrhpRc1osYTZC2gpLG2rPCLMI/dmvVo//HTsMvNWmzjTC4WYJlaiTt+19Nh/vvvUlRNUESxn4kNKs91fW/9CGYe7egPYTmFCpeFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ab2218-7849-41f8-ed4a-08d876c277ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 19:41:27.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HtfTeKahimuhZkIIsWTQLuY78kUOAxL7Q0KaPnqSpt6N9VemI0xlmRcfjQLbBQmqi4/KgXG3/+nwZ7ALo1eFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4863
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Change-Id: Ia9f8872b7654b99864bbef1afb9998d0cf39b7e5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 90fb864ac7aa..450389218516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -647,6 +647,13 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 
+	/* Temp workaround to fix the soft hang observed in certain compute
+	 * applications if GFXOFF is enabled.
+	 */
+	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabled");
+		amdgpu_gfx_off_ctrl(adev, idle);
+	}
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
 					!idle);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
