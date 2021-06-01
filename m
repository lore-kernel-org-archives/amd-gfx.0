Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C604CC4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 10:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831806139A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 10:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831806139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473316E11C;
	Tue,  1 Jun 2021 10:13:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A541A6E11C
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 10:13:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmBmwTlKPkAxwGkOFkAZ7osYdiH5/mH9gZBH0jJ9Go/lt4mActop6d/dIpBiolmn8N54XbG62kxzOFh9Np6wQlPavbjBAhRzTTZVJBjbsDDlEbm1IVJfN9fYCcpndpg8F9QlVBHKLMISnLDX+t6ogemlYrSSmvsstGfvXXQAz6Y9OXnnSAUdhgj2MymjFi42nBgkUEKlDsZd4OL6LvUePZDMHEPNhHLKhVrAnlL/5L3ML+F5wwDLDBBY/QbFDzvWQaBMDvCEmiUwo5/yRkQltPhvgChkJ+yw5WADUdwrt+G+datESfdfg/dbzYACaqWSZADTzzyQR8f9tJxoANTIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDr9y07P4qDlnYcvYO/hxlq9ZIZkZBoL6d21gODAmM=;
 b=n8mmUmx+NKUuMb1iw+cd9XuwOmUPrhR+pdexMLeF4BYUsC55G/gx7sC9d7r29RaWhULpRfILe02q5+o/XKkG9I6MhHRE9w5nVPFmvZH+HfIa6JLe+PogQWEwl86TvGvFbTXr/FX/HHQqu3ViHcsxhuW1iRLo3PL7GrpkJxVdb4fnJdE0ePWUQZyOupz54DWbTL5c4p20v2uBuGjpH3abv9jAdOkFDNVyry1EdeOCIPqH214t6KKZJcDUZDjndn1YWWfQtjPR9+RG9YZS3/B0aaM/XuANhFWTaL4asTQj8aT7fKLIDy1KxZwKQDID1jXyD7vQsjGzmc3ZTCvxdJB4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miDr9y07P4qDlnYcvYO/hxlq9ZIZkZBoL6d21gODAmM=;
 b=mVkAikJkDxEv23pBE6cDz7b1101FxRCiBpWmIcI93EzhPsDeEGOEbMnOgViISGIuT/CRtI7Qedhabu2x0zTKlyct/Pdt2D4cMafc6AFoyHgL4LI31SLIVMS9qt5MNI1cBKkeSMykrjg84/NKrX4hArqwNEHefQ8TpuycIrOHwnQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5215.namprd12.prod.outlook.com (2603:10b6:5:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 10:13:46 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 10:13:46 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: alexander.deucher@amd.com
Subject: [PATCH 1/1] drm/amd/display: fix coding style
Date: Tue,  1 Jun 2021 12:13:31 +0200
Message-Id: <20210601101331.31846-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0916.namprd03.prod.outlook.com
 (2603:10b6:408:107::21) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN9PR03CA0916.namprd03.prod.outlook.com (2603:10b6:408:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Tue, 1 Jun 2021 10:13:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 793aba7b-4c95-4d81-7152-08d924e5f0ed
X-MS-TrafficTypeDiagnostic: DM4PR12MB5215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5215E2CE14B54FA1CBA54EA98B3E9@DM4PR12MB5215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGXPox0FwgAj7A7GYuq93vfbCQLOYm63tpYZsXDLZ6a//uQwBJeBcd3Ym07IJFax8US1UdrsUoI4h9DcpluBkjAOJt2vqMoYqJecA70Awfj9kX+GcbzfQcEWet6w65cGjAs2YvbCwIr62j/ctnF7MeoPEzKW9I1x2DFC2EfBfyzpQz9Nzg14dhASUo4ksVrJpWh71dUhfKnVGZeDKPW4F/92s/nmDwQhng8zo8CX78Huv0BQ9RQArEL/a81oyTYaVJGv91cjAPjFQLz+gM7ZXHo+JdR4221POhFRYjiLPXvUt4U9Lg9uwMFgvzlo3gimFKd2yYlKYGdfyUqb4hKD1/HYh7+teWgbEwrudCrvLf+9tJzj12upoAAn/kjUpegOWRQTpWw2VuP4YK4c4D3w0V7xCMHX2jcaJHp/kOG1LMpqKx8AzvOiAC9z5yX+VXJ29SpMJ+AwbJ4dsXLHN3nyyERoJHY/nTtFEVfKnwJXbRiobs0wjfHjUNQc2aUNVMfusBQx1cNKmSVkzGmKpVKMeZWqhfQJuRBSGkv5YZOChZVsNqwda0LAZQ5iJBhPYR1JfaSMKP1IE0pe9DJqxFZm/PwPoSa30WIujjJpXACVGjgNABKQ+84CEY519rnj2lCOM+W55lNzqTGNDlS4LwBJ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39840400004)(366004)(346002)(376002)(2616005)(956004)(7696005)(52116002)(6486002)(5660300002)(34206002)(36756003)(44832011)(16526019)(8676002)(37006003)(4326008)(6666004)(8936002)(316002)(2906002)(478600001)(6636002)(66476007)(66556008)(1076003)(26005)(66946007)(186003)(38100700002)(83380400001)(4744005)(86362001)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ssCZbU8RFQoHIqS3FxOz21V5mp6xLQ1YFf6FlRBQU7/B5NsPpmqfrb/+0tLb?=
 =?us-ascii?Q?nyCMPckHYH+8q7l+lhG6sF+DoIKFYWgHfZnuYzh/tiRZe9kFxoyLjK3rgl7P?=
 =?us-ascii?Q?86fm/zuUqISXR8c0J/b8m2M0mWyoDr7cQGvJTGodV+vPjGB3j/QyZ1ugNtIs?=
 =?us-ascii?Q?9qMJuSpH8aojjPIbCWBrv7VGuB0vhCC4SpZA6MEluP5ZT0wiPKM0dWf0aMPf?=
 =?us-ascii?Q?jIaHgjpPItoWbUkwc0UA/+i2o2qMW/SrCzd4yi/pR5z3A/mv541fmcL71Qrt?=
 =?us-ascii?Q?BeUPKR7t3rbNYY5GP+4dw2CdiSKqK8ti62u8eptioriq6ncpHNJzL4j7tSyU?=
 =?us-ascii?Q?mVdz2F8WGCe+h5axr6sQugzGH7FCHQDsOJ8H7PhL78/4DYIdbTdwu6TbJ8cj?=
 =?us-ascii?Q?x4c6SifyabD3qLJ7zXm1gxNnh5Tp7PrB3FunO8l4tjh070P/o4h660DtlsQw?=
 =?us-ascii?Q?mbfbj55R7vbjk6Kd2E7LqyEBLU1JtuE3ms9pRWtu93ZFagLX2KAFgSxPlWiQ?=
 =?us-ascii?Q?t+2bxjVxTXadsb/FJBSIBO4jhiDyfQUIZqssmVP9cCn06tMGblmBrftnAbPe?=
 =?us-ascii?Q?0Km64pSS4qDBEF+9ca/slK5U6CF6JDMMrbmKlCUEoBoEF/EpyoAUIP5KmjaW?=
 =?us-ascii?Q?lfI6IXSJKorKL6qe9dUArdFY0imq6ieryl9X2PUVWBhwE8NEUFVuC29xMiR1?=
 =?us-ascii?Q?lZhYGGFmI9btJ1dW31l3rU0ZmiUIBm2oIqFAKYQxXxEJDajvy9GE3XYZk3ei?=
 =?us-ascii?Q?UVzEAna5oaGqUjQzkvoHca0Mq9IIRJlPSxS/7pqnV4K4dz2Al6WxdmZUQKKH?=
 =?us-ascii?Q?RB1+lLRHpoIgB2oxvm618F8ga7F0nX288M9n5U0rRBLJliPVwj5yK3RsQk0c?=
 =?us-ascii?Q?U9ZQti6/ViwIAiKg7asOt5AlTWpmkxVvxX5Kg90ZxUShwjy+pwg1+MlV0rDg?=
 =?us-ascii?Q?9AhkskN4MLdihpZx4Ul4Cmwd7b1q0hHkCs0GQ01AABSa5f4V48gvRYd6gJLI?=
 =?us-ascii?Q?MNgt9vmdrTv+AZhhEetsMFrEbGU3evqr3vwPqSqLnAbj0Jw1cgU5xn2q6pCA?=
 =?us-ascii?Q?cboSLRmT1salFdsk2DekD0PNzdrWDEqGtpvVNn9RZspMVz+pAsIQ6LuL0cxk?=
 =?us-ascii?Q?YinVEBe/8iHhGNjZ8Ir8HWejmbDu2lG4ztOW+Er6pb9Vhx9vE1dVlaLFpmGz?=
 =?us-ascii?Q?q6TsvH5nEy7mtgYnQ26GoyFURDSoI6yQIFYN7qtDw+DQgx3s5bkSf/Pl0Nj3?=
 =?us-ascii?Q?WkA6M8lWnNfLgMJyzoHqEQrOmF+tAvfnLlS5K1foSFhl1us8JRZ2kl61CGME?=
 =?us-ascii?Q?ItZ6mVIY+URht6II2uKuwIkF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793aba7b-4c95-4d81-7152-08d924e5f0ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 10:13:46.1045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8FjTe7xpOtwrc+IwIuH0nmFCijJvAm6aAGLETOfP1UHZ/Scz4Km6tik9QTBmATDW2X6UOy7i4+SE5GznKmfTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5215
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes: 60d198ca66ecf778 ("drm/amd/display: WARN_ON cleanups")

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
Hi Alex,

Can you please squash this with the "Fixes" patch?

Thanks,
Nirmoy

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 09bbec4dab7c..56abc27b78f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -315,9 +315,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
 	struct drm_crtc *crtc;
 	struct amdgpu_crtc *amdgpu_crtc;

-	if (WARN_ON(otg_inst == -1)) {
+	if (WARN_ON(otg_inst == -1))
 		return adev->mode_info.crtcs[0];
-	}

 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		amdgpu_crtc = to_amdgpu_crtc(crtc);
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
