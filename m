Return-Path: <SRS0=syDT=EO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF68BC388F9
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2020 15:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E39206F4
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Nov 2020 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F8bu+vsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E39206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A31893C9;
	Sun,  8 Nov 2020 15:10:16 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86B54893C9
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Nov 2020 15:10:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/1oYlbkiAb14YiyiktQhdvPAOW8uX3K+CDVCbwSS4aIeeVa7WrWWUqlyy/FQyzpGZ1pVWOXDYRo30hMjberH19F+8JLYU836tHsj2YdZTFc3Kx4/iVFeNCIkPPLVyXYFR0+E7NfxQZIxBlUwpKpU+bQUieXrzkm5D1eqFbeksQUdgfhlqGSghp3zyvfZHd6LhPw5bMnk6Ih8Wdm+14T+8dIuX4iTzyy7rAzf2C35x9Filzmf2LcBpFSFM1buLvl6csbCWhAir0v1bxLJj0HNBPbOY1nnJ4aqpnB3ltCj9pGW47bS0DBSSbFOaGjn5iDoefYqFqZI1nUxkjeaL1Ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWDglxOJSi8zkZmDmzGqnTSy7kYIOgzlTWI8J6TkaMw=;
 b=WRZqzquy4o/NxhJQ3huI+7pIxqq/9qZzJVMF1BhcYCX3h30y0XtWVwA2VaKMXoENB3UUZjIPtqGLZaVZ+9sTNYkLLjFS+zU1gm3lZblWgiQJeKW47rkvehn8xUvdEACZICnFYftXAm6TX4iJRMeAD7K/PKRekEYWL3PX3IiltlP7aoJROuf28gj9EBS8eHkJbTjCdZ39CbW5udMd0z1QLQH3IxIFjwUtcC53E1K7oKipqeT3b4aoiAEefoSQWKvwt/0NAiQ8/YbbLC2wCj2ML3i7vRRojj6knwcGSQlxThPQUK+HVAAY/wDPBdUsa5wOyfvR3NdMYWcNzg9dqi4gsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWDglxOJSi8zkZmDmzGqnTSy7kYIOgzlTWI8J6TkaMw=;
 b=F8bu+vsgl0qrsvgxwMaK4UAITBSdgp4kCUIdNE3oHJxHy39z+43eWSxfDzv139v4nnMNxP6jJ72lpe2o+7jy11JkFaPWgyp0PmTnlYZ/VH43cAzgeg3T3CtrrKJ4YlziH6+nBLuWu/6RWZKbSISse1MH4TGemz8L8ItkuMuTnOI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Sun, 8 Nov 2020 15:10:13 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::6009:8864:b920:1dcc%7]) with mapi id 15.20.3541.022; Sun, 8 Nov 2020
 15:10:13 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix SI UVD firmware validate resume fail
Date: Sun,  8 Nov 2020 10:09:53 -0500
Message-Id: <20201108150953.12042-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [67.71.220.248]
X-ClientProxiedBy: YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::40) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (67.71.220.248) by
 YQBPR01CA0104.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 15:10:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1e1ca809-cb45-4818-9df3-08d883f8641f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4579442D4FCD034EE5682B07FDEB0@DM6PR12MB4579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6VW4r8PindpKS2EjzPIKtMjXqLQ5Bexh1fahAOmGSDq4NF0GKwJtw/ZRdlM9RqJZjsTlo2RkqErSxjkqs7if/LD9L2EJDPo0FrpAyNJ76XQxZ/5rtY1UHnLGuFimj07oDQ+IiineX+m+NRnfkZyP1XZq9WaVoeUIw6+tMGsLAn4OiufeQYij4gWCzIxvwtWJPu1QJTUoMKyyWfdDZXXeVcSZV0iN1MKGVhGPDQQPKVUmQ65EWxxs7gOF6nZJT6Ybq4GYeEwi1Td4B4k50Q21RU5D6gWs1btAM8v5pySkesgi7Wxl4//3INaWogk2c7ngo22OvkCnzMp8niJ0HTrhRlzgazMtEnj51ooU3i0XJOZDagp0hOD/WEHfjkYj7rfI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(6916009)(2906002)(6512007)(6486002)(1076003)(15650500001)(478600001)(66946007)(66556008)(5660300002)(66476007)(69590400008)(6666004)(956004)(83380400001)(44832011)(6506007)(52116002)(186003)(26005)(16526019)(8936002)(86362001)(36756003)(8676002)(316002)(2616005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MlYDYnunhKwg1ffYxaOftuDrFWmWvnWY+RazDOpm2YAyhA0Lq1+AD/DsH6k3Z6EJ1z1bYXmp4nl4Y1RLODS4sjffySYRF+uMhEfUvAItery7n3tWioG37Oi3pEYh3PHXuGc9rz3mHbadLMs0Lp+aIUQpIC1lWWwpBiZnGu7F3J8tPmiG9xzYx+o2JZx1DCydVtM0brbmeaqAUPCPcxMBO2qvEESm9T0EDZxQcpP6Rq11/1fEn66nIQa1FYn6+Ty6YtFplLK9TxybZjvKwXQkdxyr3Yewmkof79+Mu8KREOtpvxkwdI1RlgwECA3LgRA7eki1F15/TT3/hkHy/0VAIV4uhWOpi2TtEEhcDziwV880gFEFtIjrdyhOe1D40CvyXZEq17205mwbk+cHESQlnKLL26pl1qqTnAZinQ7dXp7X+iwtdjXWidotGhdOmC3G32DP9+5eL2PLhIMvudiOa1ZAaKAwqmApUM4DZJYxIW8AnQbmtbLMxFA370ur8QKEIQhpazcFnGBYtP0ThbjLj4qiDPk7c3NRp8WNaLnz4WKqI627f5y1oirUpbvh46GiXE5cQGa0z+e41Y6mnTidsaDmpJimX0HIjip6r6W4C1S0ry4XwpTK0pGMhyA2VmxRWHqOno0/hlaMCYhMqkj/GQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1ca809-cb45-4818-9df3-08d883f8641f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 15:10:13.0725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMSSPlSIkgf/lRTGyGbICXc6GUKMCpmquMrIFmwNdZfPdPpjN81uhb+0tQKwS6nvvr+hFx3Pyr6XUc5+TXo+eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The SI UVD firmware validate key is stored at the end of firmware,
which is changed during resume while playing video. So only to get
the key at device initialization and save it for later using.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 7cf4b11a65c5..aab7415c1a32 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -279,13 +279,16 @@ static int uvd_v3_1_fw_validate(struct amdgpu_device *adev)
 {
 	void *ptr;
 	uint32_t ucode_len, i;
-	uint32_t keysel;
-
-	ptr = adev->uvd.inst[0].cpu_addr;
-	ptr += 192 + 16;
-	memcpy(&ucode_len, ptr, 4);
-	ptr += ucode_len;
-	memcpy(&keysel, ptr, 4);
+	static uint32_t keysel = 0;
+
+	/* Only get the validate key at device initialization*/
+	if (!keysel) {
+		ptr = adev->uvd.inst[0].cpu_addr;
+		ptr += 192 + 16;
+		memcpy(&ucode_len, ptr, 4);
+		ptr += ucode_len;
+		memcpy(&keysel, ptr, 4);
+	}
 
 	WREG32(mmUVD_FW_START, keysel);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
