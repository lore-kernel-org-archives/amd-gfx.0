Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A128FC2BA17
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 17:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FAD320672
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 17:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="L0Xb4Y7M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FAD320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C57E6E450;
	Mon,  6 Apr 2020 17:42:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B32D6E450
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 17:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7LQwkh/y+7xZrXksuasPNFmCd2V6erYpavbRjNudNOeUoh+TY9rXUP9six4d39WbmK0CqvVqEUVbnlawtXJdA3IltCy6iSqWY88nN7wkjFbVOhV7j28ohbeWpdEIuz3Z6SXNoh5usf+Ap67sXEkOo3yNDj5Fz6sofC999ma7a90k9n9PwixMGSd3WdnrOqwlF9qWiQbRNrK0PicVWc7PT7EJAmEi/KZmTW7JB3n6LtjchlCkQn33rFMF3ncfC12Bzt9lRuIW/dgeF9o+gX+LznDhpI5oj3YvObRYBV7Z/3HrrycXPPWvprkSGLIx2A5glch5TbXP89WtveFS+tUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1rBt7HA/QE9VTa96D9EYEjBgoL4cV5yoKQLrEEFSKc=;
 b=X4g//776/NgrqarE0mFUizxTzunLuvYycrfSv4kEB73SFRe/ii4evbIrIvZ2Ft5FVMR8Tt5+uN5wcS+inul8qTiacXPmkt0il4Chjj6zb308Sn/VuWBqLqOc6VaAqDFi7X6j/XV6VXzQ01HB+vz6fIJ6fmvoa0yEYtj74CEiBwsMFqVVGJfoUrcI3BQ15s5qGMHhRptZVu35FomkDiIpg3w/HlTUyaRfdije/MtWwEW7JnrR/AvAz41yGuLHfZ/67qfdpCX+2k2XzJes2TLoAxJaEz2tWpJaNuU0ti85h0y4mMvRmzQj/okL3ZiTTkh8KSsQpttXgrrnyI1kvg+thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1rBt7HA/QE9VTa96D9EYEjBgoL4cV5yoKQLrEEFSKc=;
 b=L0Xb4Y7Md3r9mLCaiqPwfOURgGoLnW0WeGgEO/CtNC/Y2CZYipy5uHUlmHAuUHU6JXLB68XNlZ0OMSvzXfe3a8mlOZeSeMHLU6vfRVQ2+IDlP86XQFQJ1WkRbDdVVZeLQPhpOAOZ/xdvB4d+j5SXRPlNzXPGBaQ/F6ic73kxrlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
Received: from DM6PR12MB3372.namprd12.prod.outlook.com (2603:10b6:5:11b::11)
 by DM6PR12MB3483.namprd12.prod.outlook.com (2603:10b6:5:11f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16; Mon, 6 Apr
 2020 17:42:35 +0000
Received: from DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::ed10:46c8:d2df:9f3b]) by DM6PR12MB3372.namprd12.prod.outlook.com
 ([fe80::ed10:46c8:d2df:9f3b%7]) with mapi id 15.20.2878.016; Mon, 6 Apr 2020
 17:42:35 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Print UTCL2 client ID on a gpuvm fault
Date: Mon,  6 Apr 2020 12:42:27 -0500
Message-Id: <1586194947-13405-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM6PR12MB3372.namprd12.prod.outlook.com
 (2603:10b6:5:11b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:42:34 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6ba5712e-aff5-4475-dabc-08d7da51e3e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB3483:|DM6PR12MB3483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB348383ED87D9B5ADA7B0CC6780C20@DM6PR12MB3483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(478600001)(316002)(81166006)(52116002)(6486002)(7696005)(186003)(16526019)(6916009)(81156014)(66946007)(2906002)(26005)(66476007)(956004)(66556008)(36756003)(2616005)(8676002)(4326008)(6666004)(86362001)(8936002)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xBlWHBtDgmiqAsMqfPlaM6LN0DkAavhqiUEBhiHmW4OUqDzZBmGjdSsYt9SJ8K+T7bG7pUmnmM06LG4rhqQPST0FzfVRaMh/AYDoEGkbhL0HF4tqEkIGAxnfXocO+Fx7YIBGg8MYzlvsoIelEAWU4FjXDkeDWPRZWMJXoIWzL2YC9h5cSzmJiC3rPzepzZrzphiWnJDiu288U+ppSfyWK/cmVGLm2wtMPJondkcQFbFSBsWQbEWHJRcGv9BLktRCgt21YbfHrTKHJRzAA9iUNwgteOHkgLLs/9nA/fKyGdx1ogtWJdLt4ABCKiJ8fVRbAqa0CvTdM7b7mxlS0dED3ZvWUg9Q8+/u2JoNrmp0tR1VVrjk+jk7BT8Yiet0+XP5240UFjoe+Ety/cVubTGBBBITnNI8w2av9msSCUYRCcjuNefMAel0RFjC/Djos3UE
X-MS-Exchange-AntiSpam-MessageData: 3lKrqvuOlmP5AuBq9EOPFNpLWMY8anwYN4xH1nvl4lr3hhJVhZOU0/DGDjYMSg0NwTNFYO7HzN5M9o6ACL7IHo5VbjF1xl8EIODgCwaRl/Y7Zb1JHCZveW6L+XUVlJy4kGum98+kYh/3bRy/kvW0HQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba5712e-aff5-4475-dabc-08d7da51e3e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:42:34.9884 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5JdtNVn75NdpvC7KsqXtgfyBTYPzXyzpXSlVh5l7VoqFeFjWo9CcUPAqZeedmCOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3483
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
Cc: Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UTCL2 client ID is useful information to get which
UTCL2 client caused the gpuvm fault. Print it out
for debug purpose

Change-Id: I733d0127b0ee53aa788f194cefa53cbb55b49c11
Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 78d769e..94a6096 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -170,6 +170,9 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			dev_err(adev->dev,
 				"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 				status);
+			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
+				REG_GET_FIELD(status,
+				GCVM_L2_PROTECTION_FAULT_STATUS, CID));
 			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 				REG_GET_FIELD(status,
 				GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8606f87..fecdbc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -362,6 +362,9 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 			dev_err(adev->dev,
 				"VM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
 				status);
+			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
+				REG_GET_FIELD(status,
+				VM_L2_PROTECTION_FAULT_STATUS, CID));
 			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
 				REG_GET_FIELD(status,
 				VM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
