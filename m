Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66511C4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 06:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8A32223E
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 06:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K9MDwKyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8A32223E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A7C56E0FF;
	Wed, 23 Sep 2020 06:54:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EA96E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 06:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCPERPQqEUFrJf9Fm2XZ1PY6MKZFUwyFp88UBkbuyniOdMTHYB0q+7bFUVt8vAU+qvYgYDfx1jS8/GHzpwixZl3kQpwvcvfZ/O2Fl7OzvmoNjuuOh7Cym/9v3EPsj5eZL3aQaV0K1YywmA5DYB2zs6uBuRGmYKFSS0ed9tv4z6kJXPTHg/hWgv8xbUJWAwke1EAM+8SDrVX5GnRFZ6PDVQ7S+OXRxQIEXGZ2Wgcn8b0DyFQhABgb/33Yf2LyESFQgaY2CKOh2/RtCFdHKsT1lggjGTtXs2lfEkw/f7rko68aai0xztRgTDvqk9qsHt0CnWAUhmDnKF70wM3+lfQ8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s58QKmL9+99OXsuBwN+Xbz2sNGXaOn51JbWSxEmSG8=;
 b=ihbB0dHYnvFrd6iFd5tC+XQ8jJnhR0H1e97l3IPdzi0UuRAc5A9z20iZhsUCGR7KuCAOcKMKAF0sos4mt9tMzLCFDoPktn3hHP/8JUAw4/UBWAIYSui1M1/FzfpuS46JBdjwpqFl5CziMlVVlsJ+4ylFHb975kvI4AqvnLzeiN9Uk85Dd5Gqoo/OjN9u4O8InmTUkEMWhoJANrYFEwrGgxSOHlC3Wfen7l0A0DqWJq4BO0ychlRwf3S5zIKtT7man/my2gfY3W3JIfSoZVU/gTDn0jRB8ccE7Jj5C5wg2a0HS0tKU9kEY5Hu8rj+0osLnuCO/nX6Irc0i+X3LavVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5s58QKmL9+99OXsuBwN+Xbz2sNGXaOn51JbWSxEmSG8=;
 b=K9MDwKyjEZgjXUCfGGjFadbH/KQdfWT3yvfbK/+lnMZYQbACjlXOy9GDafFpYZqm+0xnJ0W2IfrdU4onKebgJHXq7TOtdzso51+qa69eJlKnmidzfz+5Aq0vZy47dI7FInb87Ynq5JX/qmz0uG6dLPydDmst88Oj3f9v8/SKnNg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3762.namprd12.prod.outlook.com (2603:10b6:a03:196::24)
 by BY5PR12MB3844.namprd12.prod.outlook.com (2603:10b6:a03:1ad::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Wed, 23 Sep
 2020 06:54:20 +0000
Received: from BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28eb:805b:95b2:b75d]) by BY5PR12MB3762.namprd12.prod.outlook.com
 ([fe80::28eb:805b:95b2:b75d%7]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 06:54:20 +0000
From: Flora Cui <flora.cui@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix return value check for hdcp_work
Date: Wed, 23 Sep 2020 14:54:01 +0800
Message-Id: <20200923065401.38979-1-flora.cui@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR04CA0067.apcprd04.prod.outlook.com
 (2603:1096:202:15::11) To BY5PR12MB3762.namprd12.prod.outlook.com
 (2603:10b6:a03:196::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from flora.amd.com (58.247.170.242) by
 HK2PR04CA0067.apcprd04.prod.outlook.com (2603:1096:202:15::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 23 Sep 2020 06:54:18 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 626fd031-c16c-4c1e-a592-08d85f8d7eb8
X-MS-TrafficTypeDiagnostic: BY5PR12MB3844:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38448A267009A5FFEB339118FA380@BY5PR12MB3844.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6IiBNgVh/AkEF7vSm4v8xVvxpYQSfM2qQ4f+eJQ7Sqb/W8Dsu0HqfX4WU8BH9J3nN4nGyjxSHrDbM7J+p2eNJSEhaNH5k6pkjnPoAYQuDksjbzWVPR7NteB0g2/J7Hhv3gBvQ/pFfRbrxuAw07yZA9IVfwD0Y5e0s8iTQC1QdgWn3gs5dYJ+IFvnmrqxgABSkp+jK5aE69gr8bNPdGFOfKEGQqxlKQ9kGvUoeE6IQMtEa+53OJp6Gl22G3ReoQDrFaEcqkQWgoiJb/Z5M/Tpk1vC4NYiXoRKycli11S2mvi+rf83UdHit30EgxT/T378rSeMfwxBiIn1kokxCaZmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3762.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(66476007)(8676002)(2616005)(8936002)(83380400001)(6666004)(478600001)(44832011)(66946007)(2906002)(5660300002)(956004)(316002)(26005)(66556008)(52116002)(36756003)(86362001)(7696005)(4326008)(1076003)(186003)(4744005)(16526019)(6486002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AZ9QaVql2VcUueFP8U3//mqha1ttVBWyS+xFaBGbm1ulTix6PrGpXeVSWjnQ94irJI/X656Gikx3wmD6A/yK30kjqiwT/IxvHBW6dcH35/6frGxmJnlc7/5Bv14Lx7tHUAdr2Duo6kTeYLmhm0O+PnvYfHbqoua3CDzZA3qX9GsEv0ljgWNtRpzAJbzAm99+uhozXBR/+ohj5QZtJqIEqx9Mtvkk4CZKehXDeHwOOArF4t/IIg7amvWWA4o3JchHBqA8zFOI4vTzp+naURx1Dzg9OvIENUMok/vj1ampvPI4oHIlVFU2/IsX2uIzbpoYNGz9e/ITk1C1gHYFf2paJUFnCW9dhuvGrLtaqskf08aVjbQ6r/bwG1gIWEypmtiuo2b7tW8qywIF9/UvcuUR4Te9jTR3cbih5zAsVMGYIvWIM0tHD/YJvdXRwgYA1SzvqjXvUDocMJqSa3QSpjwPGiRcXI0OXo/w7IfmUUspn/rnHmuP9z6EK4OZeowrj1a0eKncYrVRg1tc+b382bC5/JuhuCtrAcD9XovRI1D7b6dcnRzsQjNDPSm8Q6cUUVb8L4fPhUALiuM2FVnaLuG1MFC3ZU0DzWkIFPfmgfcCDIOhs1ykmY+aC/3t60CtxH4ndzhOGHzaX1K7OV42Fw+nzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626fd031-c16c-4c1e-a592-08d85f8d7eb8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 06:54:19.8410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X31ndtpvJyC0IG0ysk87NQIP1oXKmE7JILZYCESXiZ2ZdXS0dFhTeUnJ1c5q7ljv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3844
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
Cc: Flora Cui <flora.cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

max_caps might be 0, thus hdcp_work might be ZERO_SIZE_PTR

Signed-off-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 694c5bc93665..c2cd184f0bbd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -604,7 +604,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 	int i = 0;
 
 	hdcp_work = kcalloc(max_caps, sizeof(*hdcp_work), GFP_KERNEL);
-	if (hdcp_work == NULL)
+	if (ZERO_OR_NULL_PTR(hdcp_work))
 		return NULL;
 
 	hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
