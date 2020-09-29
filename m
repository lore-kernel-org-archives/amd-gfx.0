Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86090C4727C
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:25:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78072075E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 17:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b/9sYUcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78072075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1312D6E7D7;
	Tue, 29 Sep 2020 17:25:44 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5487E6E7D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 17:25:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJ2koYbQbxrCG+BwIJ41E3sHfvVLWbZBp6Gh32DOXHiofNXMxGrKfj7nFLFmJHApaiMqqBfGy2t0Zx2LzaoQs89OU2hkSyfxeVGxRA1ahq8NFtK3bo8UVVMzKlKxEZs+tMJj2rnwXRfju2V+jp8eutTKZti2qEv4v/gN0RcRXgYtzCtrUBSreQpvy3uOWC3a87yrGuCbBSb4udel2MDQ3VLYgm2Jhwt1jOiduQPYjK2gLFFiA4KbeANNXa7+j65MO0BSTXdtgWNb1/xX+MtfeEe8Xlzjx3Ui/eoHiI6PqwpMr2KzXEYYYgTz1kxXt2noUeJSnYAeqRwhBciWwgtlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4yDis528hpr6meLWgbvuamZ+SqeJYGipQ459Vt34fw=;
 b=nHCvbk194w3/l4npo1S0OXYbTGuunCRDc4Txl2DKJDwQ205/ecOUWw3LvS/pXNzEXrB29eDxNohYR9KtqmDiKvo/ZkGebsWpC9D72a2HltGNGXJuH8HVepD6YzfFGIoqgn0Ow2jsclGCBxh6XH4JdDZ5nAg3Xn8+jPTqKxY4bIMhVX26jPi21I+Rw/oiAahIkFWDa0Z+2Fx4V6zSJDMtTUs9+0eiPeHJNIKfHj3wVOgzGs2J9ozRUbuxqqaH9Q46ZYglX8+6h0WnJHR0MmnpcDhTGHGOaMNHgPcWTqaFTi3CoQu45ejmT8WJZaEFomEgxxWSkFpF5oXYhFO2T2NgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4yDis528hpr6meLWgbvuamZ+SqeJYGipQ459Vt34fw=;
 b=b/9sYUcjXoIAKF5kd4SeiyOVDzz1NRnNY5W+DQfDIJw4lPFzPxNpVo4EgUvQ+AkvtQYq6D8cw2RjapMo7s63+4gHurCH/eFB7zk4CVgtkpZAnSBwTR6pUnjSlnlrx54um8PE5b2wPqlPGBpU4z2WRmqnbBiR+/UtUHnN4KzJ/mg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 17:25:41 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::3d17:21ac:a0ed:9a82%5]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:25:41 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/amdgpu: Clean up header file of symbols that are
 defined to be static
Date: Tue, 29 Sep 2020 12:25:24 -0500
Message-Id: <20200929172524.24857-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:803:2b::29) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsacqe51.amd.com (165.204.77.1) by
 SN4PR0201CA0019.namprd02.prod.outlook.com (2603:10b6:803:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 17:25:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81f0136c-e7f3-4f3f-d1c0-08d8649cb09a
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23825B9CCBBC0EFE0A5B5A09E3320@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nhgme4vggj930ZBINsQFzDZoDPQnGSotcm8vAIpGv/r3ARPdC5PzEfZSivR6vlw6CyMHy9sBB1tS2E26Hl3VKrylw0ThHvw5grtL5q0Vkm+4e2rqxShHm0JyaHNsLwaCVT7sky6ZKlo34mQMLRysAxXRdyaowZNWq9OYVv9z2Zu0LCyvoWcBuRReGDFWYu1Ezm0GDwuUMNm7uj4pTyZ7Uot4KnTMH8sRBCd/mkOtvsfRjx5xaFxNUG77tSTg81G2RPtFoN5vgddJOCFhhoW192vXyRMNIQXnLmFWsM8weqj0BtptAiUmyNISXr7P8AcfWvtW9D+1xwDl+GV7yUzGUr3aL/PXXOTz01ZDZIrVN7jgD7cHOlCmW0NY/Dd+aibl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(36756003)(6916009)(6666004)(8936002)(1076003)(8676002)(83380400001)(66946007)(4744005)(86362001)(16526019)(186003)(26005)(2906002)(66556008)(66476007)(4326008)(478600001)(956004)(52116002)(7696005)(316002)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: QYXrcajF4K3ckMa9qvVF9tzMXYl73fuBNE5+iKWGroh9m7ot+7gCBcOyNQO9HrdpI5O5B35o33BXEsGxR7JHkTvi7SewZ744lQ2Cqww/lghRsawB2BS2BPV/NItDcGAHOzQGLHg0DqEoAQdaELo5a8Uy1PPQDLstVZrAduV0fI765W53CCNfAEiB751YpEmj8g5chVULCIA1WAU9bmjwzSQNQgXTgYVF4mo10WMdWVdvxYmImoYRfijarOmy13CCcZPuE7skGX9i3HC6sz3xzbaAbNQdplZ+1F4kKX1Op/llkm9BcV5dlpltw4Ke81bANsl2vpSK5B+vA0K6MxwTp1gRAygH0QKgtHMmALeuddTCoTyllawkMe0BhPY/Z4P5phPUUnZb86/RnfA2UyY03ig94Kh0qVTlq99lEuy8Jw1/Ep4JWXccPAgC2xDjMOlB1i8VN5bFK9VpR1eNvP5KsFizzeCybPjzimbRdK8BiBRBYOM6AjLiGazm/4B0KMeHxou2VIMyJSuzKDa+DZL1MDiEyz9bVHma26qzcysV45xeaV56zU1GasK+7/07HuWC4/o46lArHzLH4//BfecVRhCo1aWr4ZQio9H3MjrreM5xSau00vX6PNmOFeKYTIzoJi4RO/4WsEAvv9aI1koE7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81f0136c-e7f3-4f3f-d1c0-08d8649cb09a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 17:25:41.6095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WgcKWo8I3xVPwLKbXitohUmUaOL72blPgAsXOfsTo74n115dIog/hMWcIv7YNN9d54NSExJqmcuTgdM/JGAqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Header file exports functions get_gpu_clock_counter(), get_cu_info() and
select_se_sh() that are defined to be static

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
index fa5a3fbaf6ab..407472031daa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.h
@@ -26,9 +26,4 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_0_ip_block;
 
-void gfx_v9_0_select_se_sh(struct amdgpu_device *adev, u32 se_num, u32 sh_num);
-
-uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
-int gfx_v9_0_get_cu_info(struct amdgpu_device *adev, struct amdgpu_cu_info *cu_info);
-
 #endif
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
