Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4E5C43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F075D21D91
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 14:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="axYzBKWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F075D21D91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800BE6E2E0;
	Mon, 21 Sep 2020 14:27:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0796E2E0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 14:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN2ng9a6+IfYn2ycLVnVWto0t/2y26Z/K8OF4Qwm0+VhE4VCbjTJRTKZkBULj3LbCKFW4mBer9abcZ8Ayl3APTbuMZlg6Z3qnt5otUGoffxQSYmNjwf0HtiNNHREbWVOCfD4DzrLPYfDAPuVk3F9jbtrUfGpupCZYHLGiuFtdpd0CyAX+2GMCHwtEJtqpk4y0nZk3nB0+agYbMvwNtUQ7BLK2ddDz9kUBAHayIDGq2TeZTZG+Ji3P1Yyl3e7sOuE9wggKTd8IF7QEZB+se1WJDlfxDzJOe7z6U1ynLE5UAsWGQAEEQFBnOnEKkXoHwob5dZoyoxTcsjfXzYJWFrh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi1UpGR3TsapwsGhdEbhMYATF0Pp+g1uWUm2RbDmzhU=;
 b=drZX/YyaUcRZCeHuiKReoPNwgx6K+1lVQM/6LSMk3ohuk19oqHl4O+3keS73tN/GIpRKYkvN0+F0bKqUVLc7+eKmBmZKdTD9kEXbGTr5IWIFbu9bwLEb2GzdyqBUF8jEwuktOJ8W3/NOfdPzJtxr04KQaun7UZdFPuQ+wHAFOBSaVqknlLx1SbHKIelPc0+ZNimG/Qlos3AsXuuyEgLL2TZdS61oREZD2WqeS7oNZVl/pVO4KvJ3ewlsWjEpCptXeZN7D1wcEf5v7CSMiyvJJhpAz2vQK9IFE5RUTHj8oK5lxBvbjLano0CAnqZleZR8s//qFvcmLRgIqw6YGEWqrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi1UpGR3TsapwsGhdEbhMYATF0Pp+g1uWUm2RbDmzhU=;
 b=axYzBKWrxbaE52/x36jjKjI418SxdfDLWITigjBEuFC0UfBf357p+hTmTj3qyuTn+HDouK/Tm41UO1DgAGUbVzoXKMqkKMQIBriZ6bm/9MZz6WzdrWN45+ODwqCwH3FT1nHqSYpUF5bfj7C3Tf9T8DPegpzTGGyVYgOHkzOEYO4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM5PR1201MB0250.namprd12.prod.outlook.com (2603:10b6:4:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Mon, 21 Sep
 2020 14:27:27 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 14:27:27 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Use kvmalloc instead of kmalloc for VCRAT
Date: Mon, 21 Sep 2020 10:27:13 -0400
Message-Id: <20200921142713.27791-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Mon, 21 Sep 2020 14:27:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 183b46df-165c-4121-8bb9-08d85e3a76fb
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0250:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0250C8AC5B760F56DF5377AE853A0@DM5PR1201MB0250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Xf4ppe0YJQnofkcVAdFAe8KMhCji1tyLb9dAf4JQmSF4YvABQV5MXdyBdcly2JfOWVuCbbRbBAJ5Wax/KWtIBOm+Bs/vM8PrJdBGGhnQPx7ZoUuPQ714kCYWlhJyZgufFnLn+oArVjCsANym6spYxJ5vo802Z16wL3aJ0nQj9vRVS98x6cKvWLYuGhX9bmSpieW3p962dX7KH6cVvjseTttO/7APAQjJWseohADMk8dOgiPhGZ7EyTmy5lkikoyl+iBY8lh+N4GZBcmIQtoSiOVbgujarAKD5G6lQ8SpDCjLb6FHykuOrkhmqaa9v16t+OtU1GvWkR/ONNwQ8kRmsXYk3njYl1+G0zKqzzgSMGLTIKSLF0foB0MeakZ273i
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(316002)(1076003)(66556008)(66476007)(8936002)(66946007)(4326008)(186003)(6916009)(8676002)(5660300002)(16526019)(36756003)(83380400001)(6666004)(2616005)(956004)(26005)(52116002)(7696005)(44832011)(86362001)(2906002)(6486002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: naRsv52czZmrNKFaXz2B4ArFkKDGCg8s/JIakfkGvkBP8hckgMoS99OImjgfCE6/pDe9v+0gbgwjB7B44wiRSg7X6HQGnlIZLpYEb6H04O7WvtXDL69mK266NpM7JQquFg1GCkfXceGXBMf8g+kmV16mVWabovSEdpf3uJ51EMKrN2rC+38MOB1q/8+U0gvVMQ9w8FmxzsTy5yi2GCGhf+6LE9cbSr3RVhLa+/y3yaE5LrJ7Lzx4N2zhwjWptG3NplzDTk96kIwrA2wAtQWTRcxZR5jqbt15xUAmDjCDHK1uX+llg4q7RinoSCmkX+JpwvoDYRQSA3AVf+LwhtmE0lIoThicara+dVfOU78PB0XOy1FNk504oWggFh4F/lNUpdrJ/OxkE/lwXb0RiOqF8acM6OKL+SqWLzhKrHHnsPRQ31ZH/bpVyWwAAYcf6sXnEyRM35w5UDNi/oSTjeD/3J69VOjxqQWYNTctY9dX0daxqrmDA4hN1Q+4H1EtWgqvukWsv2n7v/S3FOAeKOz+TEAUBoCXH6BZELBSHZyjRFH5abySMV5Hw3XQFsDw+q2T448kBMjUn3Nyg9o2KVp/Wos7qlIRhesoG6omf7Ht7IGeSD6ZsH0J5Osql6rLs2wqSqLXep2YwuP+lpCv8iFjIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183b46df-165c-4121-8bb9-08d85e3a76fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 14:27:27.2104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EATUHKg4vZS29VJqcp16loK036LHlwQZfGbxftzMvG9u+dj+8gtyw7CY+8am2kaDErvYjnXhmL0H5TJN5cHwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0250
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since we're dynamically allocating the CPU VCRAT, use kvmalloc in case
the allocation size is huge.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 99182b8e9152..c50e9f634d6c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -797,7 +797,8 @@ int kfd_create_crat_image_acpi(void **crat_image, size_t *size)
 		return -ENODATA;
 	}
 
-	pcrat_image = kmemdup(crat_table, crat_table->length, GFP_KERNEL);
+	pcrat_image = kvmalloc(crat_table->length, GFP_KERNEL);
+	memcpy(pcrat_image, crat_table, crat_table->length);
 	if (!pcrat_image)
 		return -ENOMEM;
 
@@ -1383,7 +1384,7 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 			num_nodes * (sizeof(struct crat_subtype_computeunit) +
 			sizeof(struct crat_subtype_memory) +
 			(num_nodes - 1) * sizeof(struct crat_subtype_iolink));
-		pcrat_image = kmalloc(dyn_size, GFP_KERNEL);
+		pcrat_image = kvmalloc(dyn_size, GFP_KERNEL);
 		if (!pcrat_image)
 			return -ENOMEM;
 		*size = dyn_size;
@@ -1393,7 +1394,7 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 	case COMPUTE_UNIT_GPU:
 		if (!kdev)
 			return -EINVAL;
-		pcrat_image = kmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
+		pcrat_image = kvmalloc(VCRAT_SIZE_FOR_GPU, GFP_KERNEL);
 		if (!pcrat_image)
 			return -ENOMEM;
 		*size = VCRAT_SIZE_FOR_GPU;
@@ -1412,7 +1413,7 @@ int kfd_create_crat_image_virtual(void **crat_image, size_t *size,
 	if (!ret)
 		*crat_image = pcrat_image;
 	else
-		kfree(pcrat_image);
+		kvfree(pcrat_image);
 
 	return ret;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
