Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE04C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 05:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DDC619B2
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 05:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DDC619B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F125E6E40C;
	Tue, 23 Mar 2021 05:50:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D656E40C
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 05:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7ZcgSGkLglQaV+IvTfjq7GMy/3aNdMgnzgFlJq02+ce1QDZ+rEZU9Id6fpcUIqBU07a8tWj+JYp1p+Dec5KIXgoaYrOel9lxF1paqcplaIjDHto43/uKDlBti72FakT/P7VjL+hlAeRkm5mtxt1OARx0O+JU3jbPm+H+EfPPGPGdWrrV97dDjl2BShpSaX5j3QM7fFRTfW4qWR6nqs5s3XpbIAAShgmziQRWgbqNvfBeeMOP6lRnnUCMEbJPZ1Js5CgrbPdBNbxhXc/wYFr1RGMcOFwz4NvnMDhJogzzyI/zlKfym88LppT/QJacQw2wrM0VBvZWEItMuPGH5QD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAXvtrK1Ik1tKfgRNmOeyHMNEBKKtWGVfdMvbsEByE0=;
 b=kCsGF4uy3ARWIfGtJa/JWdj6zUQVQPZmK9XYi886G+auOrEcpijjK0djOeofg2Eid/VN0Btkx/w8PeGlucjXRXagkI1D2L9M5fI159Wb5OCdjOyM8tMhmwjP5ANw/Jf9vDYvQz8f3aEzdf/5IYV9TbKkd5QKGCGcKpCnWqqqyl0LVqjBiO57rhwAc6MV2DiTdfmmME+s+lPid4zD6dGlkoO0m/vcBuYj8CDEWvKufXipdwYAWkjQk1dgTEoiswmWEkkyjJGvXGtrgCnzo+QzxKEo9WmuBgSNuSkQ44YeQKhekn2Z1UswS1Wr8LOYfQdBUpdH0KHFGqdlTffdkKVUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAXvtrK1Ik1tKfgRNmOeyHMNEBKKtWGVfdMvbsEByE0=;
 b=CCYJJeSZyrbzcAMNrrqU2tyMrhQJDJ8kscl3KEX/WINY0QpF/VZVdi1ngVN65GqpMGrFaow3EHoHNqzyp3nn++v2EU8u91Cr7IyT0VYYXD1atEeA5JgYB3GvjQFd3iQDYlsA/AR4fdwqiYYBGeaeKo20Fokmj/UjjkDcmpisYnY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1878.namprd12.prod.outlook.com (2603:10b6:903:123::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 05:50:07 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 05:50:07 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, jiansong.chen@amd.com,
 evan.quan@amd.com
Subject: [PATCH] drm/amd/pm: fix gpu reset failure by MP1 state setting
Date: Tue, 23 Mar 2021 13:49:39 +0800
Message-Id: <20210323054939.26101-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR04CA0062.apcprd04.prod.outlook.com
 (2603:1096:202:14::30) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK2PR04CA0062.apcprd04.prod.outlook.com (2603:1096:202:14::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18 via Frontend Transport; Tue, 23 Mar 2021 05:50:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e662cd79-d5c6-4724-1ab7-08d8edbf8333
X-MS-TrafficTypeDiagnostic: CY4PR12MB1878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18781E96F7903518A5035F24F1649@CY4PR12MB1878.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /p4ghFEn0IX0vTj+7GFu6o1cVa7gfW4rZepa6bOEaP3wmMOsaDc+ugqehr0upSDgyo/crZ9z83dpZ+I+SHUHEZ4acqffLeRdzi5hxJy4SBN2TTvLQvXAIlcHtWJ7W8/kc3uZi2+x3NQrPzHF28hezEBREXKdxIcXeqmRlssdzMvAPnHrVJsH8YA0ok6+/NHcqjEHAVLN/mXiIX1RTvegHKmEb4A971HKrJ+F8/nLRns/VXLVBJFeEi9UJJNDVd9Kn9iM2IBrkmh00y6sxDVHp9VNDATQLvt3ID/EduFM3CJ/mYs8HJ5to4nAtmh6M5NcijMqX6kY6fOykw3PtGk/Kkt9/WQfbdDoOQmJZLQaKWhJMQZbFi5+NDFsW3sJlT9GKfd8FZ2yG+KHpAMW21j1DTc3tpPDlnTnWRQGwJXaarQj64RlEWdMP3Z9NkCXGJVjHvOahCI8IOUoRPsUQwA59pCnUhbNGhqT/3LOtpmRB0bUd4Lfyz3sI8zAjI0q9KTYpbPQVKGld7Ztp2QxoiQYxjpOZszipPN0pQJ+YII8C6ixvc9NTjNtEmRu2Vry5/Yt6WmsdrYW2Y+V0EAw5BfoLRXYEN/pUF4/GMOUoEaWYAmDRZwS5r0i+kUPSVuJsnGiC+HcJY8KcDjEy6RDIQrphvVHAe0tiut4YkcBCIP5rzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(66946007)(6486002)(86362001)(478600001)(83380400001)(5660300002)(44832011)(66556008)(38100700001)(66476007)(316002)(6666004)(8936002)(2906002)(16526019)(6636002)(2616005)(26005)(956004)(8676002)(52116002)(186003)(4326008)(1076003)(7696005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?57ER/KaaDxXKUfYXE4ufdSe3iE+MaaCGUforD6t7+JoklYJftx2k0mo6DIl9?=
 =?us-ascii?Q?mXbuFlKMlksOX6pWfxlugE2M3v07CL4RCluD+1p4A9m7sxlhpyngh+lMr2ER?=
 =?us-ascii?Q?YeK/ngRlUUAYTe04DvdzZt/ELF1d+WzfQNGHz2w+Otj1cmIVOtZKLE1os2zk?=
 =?us-ascii?Q?6IwcmzSGrELaGsuJktdooLMKvisMrsA0yluy9a4VD8cOo6QE2rjQWi7WJnGI?=
 =?us-ascii?Q?Bz7/RklFC6Q7iTlTJn7XfTOpd8ZQI02vQcL1CksFxg7Qo4/FsCmp1ejVICl5?=
 =?us-ascii?Q?e0W8VJn+QP6JsVALfJXSQejmxF+X8bmoXMx7i9aclFNlOkaVEMyL47I1ePhg?=
 =?us-ascii?Q?GW2lkyaqlKtjNCfafKMtH6nhY04O8xMpPRf3tDYukWilc4R8NrtoTrq1rYZQ?=
 =?us-ascii?Q?5VRe9qROHllNDEaFm8UfvCOK29GPo2w3YeWsrqaQJKAMwwuKHd8WAF/zRTo/?=
 =?us-ascii?Q?7cC9OGnJIQIvLqqMGJSXVnWySpOpe2zl2qBDx23CAYlir5sfTi8H54WM54k2?=
 =?us-ascii?Q?qNUFj1maloZBzAfdGeExslET25bwt0xOfDqGiyA/nLCSSUYgksAtnhFBopxg?=
 =?us-ascii?Q?KmABy5qeD1jOtmT428O2T3//6amoTU5QH6mkX9c2KwEYpYWui+SPwuk5+Mzz?=
 =?us-ascii?Q?9CXCSQ40egzRjfn6qoo16LyTA+t8MWME3KCjpw2NjeMRamMeCbfRVhYKSAcY?=
 =?us-ascii?Q?uzDJGViCCjcf8BDzIXq+UEWFAE5AZlcaclMwicMPWZAxBTBPK/9pWeGp49rS?=
 =?us-ascii?Q?Dd8bC3q/gHqpyRGGcDsnQuEKElU8HIULQmDFO0/JFw+jZQwoVTPpT5aqNBdG?=
 =?us-ascii?Q?T2nPikn6Fd2jx81ntGxr4ui2rRJuTDnCI67qtR6erko4vZRVsUcFiNQUxt8b?=
 =?us-ascii?Q?zBlAfQAgXKpamZYtysps45xI7a17Iho5nukxOQZI7JQ93k9e7DugHmFGmImf?=
 =?us-ascii?Q?URXI2Aqoh9G2/DEwKS+eJqHOtNFLIYLcgpex6j4tohz2piG9x1aM1BjkOPJk?=
 =?us-ascii?Q?6Cda61Vwj7F4qWtXyNlPtDZDaw96zxh/nKYVCGKcec3aIUJFou6ClWGftoXl?=
 =?us-ascii?Q?N1O0tX6gIlPpY52W/3Fh1/iY8w7gVWg8dDwRLSsLvGfTkbZtUKPbTxoRRDhY?=
 =?us-ascii?Q?cyRwBWxRAY/omAV2F+0aGeB5lM0ml5K0svWCkbHDCIC/d201mKhr7sgo59cy?=
 =?us-ascii?Q?iIH8VExB9QZNezYUsX7Wh95F3DquKBKv7WKo18Z25k1GBr/c7V6HvJYKuY6L?=
 =?us-ascii?Q?S457M3H2AzNc8gPyPzEk1xIyE0q1NQEUIQPo6iC02C0XKb0ZQsHJBZN+IFov?=
 =?us-ascii?Q?LbVRXbiJF1oKVH8H8R1bpo/sNU4WgwSkVZDWLigtjTm54A=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e662cd79-d5c6-4724-1ab7-08d8edbf8333
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 05:50:07.0825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Svcsl4zFEl+LFSImAKLMvRwnTwZwwcsS/O4z1hX3MkmtVFu2lvkRubg0NbvKWz8eTUMbw//Jz29bObfnV8OxXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1878
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

Instead of blocking varied unsupported MP1 state in upper level,
defer and skip such MP1 state handling in specific ASIC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                    |  3 ---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 15e239582a97..0a6bb3311f0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1027,9 +1027,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (mp1_state == PP_MP1_STATE_NONE)
-		return 0;
-
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 722fe067ac2c..72d9c1be1835 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3113,14 +3113,18 @@ static int sienna_cichlid_system_features_control(struct smu_context *smu,
 static int sienna_cichlid_set_mp1_state(struct smu_context *smu,
 					enum pp_mp1_state mp1_state)
 {
+	int ret;
+
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		return smu_cmn_set_mp1_state(smu, mp1_state);
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		break;
 	default:
-		return -EINVAL;
+		/* Ignore others */
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
