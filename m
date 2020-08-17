Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942F2207DF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 09:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wlNrmJcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942F2207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45B666E07D;
	Mon, 17 Aug 2020 09:05:05 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B736E07D
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 09:05:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0t9MPAa9AOlVqpjHxUzXU9CnHJ+rw64GcgbnAH+CBmVcj/X90dvRxcydhxF89RaOZLwNq+x0rpjvWxKrIj8jSR/h2Sx8yDcpRCJhUVq5CIFQ4/iKV2SnQnZAancY9T+JYvRkuRyRobc0eCvjJf6J9EAucMwIABKG19Obh7lVUIwkCo8QY3zI+zieaDgxgA+VRON1woYdsRP5NBQEt3rPoo2u6y9esOpBqG2HsxlZy47QM6DUlAsztUJ50DW4wUQDP8rpXB7yb2XtFzCKn6H+w7EiX8y3dTIke1/uG6Pi5w/BsnkMreZSarsIFBoHn08hESKwkg8kaIJxg+/L/K6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXlD92VABc/GFnJ+HKjiOUdhLsRQ/rOHZKBQmOUsoE8=;
 b=ghKm3vRm/v9IZiY7H75WcD9R5jHqgeUU4hgQEDoZ9+jHDabU0iMqELhybbJvhGvszW6qLWx58eEphnuDjJQoLqxvDPg6dAk33hOd7T625h0vChz0HakX4eu1z76K8rd5htBFC9PYqXG0buUL+6yBogb9mJxZe8fEyHE1coCLTXnwbaKOmkhYefElLCnSLRiKjVJbuh7i/QQ4Z6Qbwz7sSZKGeyzTDLyl1SNii7vRJmRoQXalrUECsyo54jjI63yZuCbuUvP0vSW5CmAMkfGYuyIMr+0kMbYIUDwNDYUwPCu6BmATakufenRCe+yJZURTg3OQM2OL+nSwe71oE8L+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXlD92VABc/GFnJ+HKjiOUdhLsRQ/rOHZKBQmOUsoE8=;
 b=wlNrmJcQc7U4Zi7JkUnnDH3Vkvx1IlbNoXrdFxd+CiUC4dQsDngzlqmzrF9/A6TUCzHxqIqySZuuQ726mCtApHi+5Nr7ohr9Bn8961YLincu/nRPEOw8UaaIdug7GMA3EsPSksLEH+JHOkCZ41BwdeQdEMv0Oqawtv+2p7Ti0EM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3085.namprd12.prod.outlook.com (2603:10b6:208:c5::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Mon, 17 Aug
 2020 09:05:00 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::44b3:9382:383e:ab93%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 09:05:00 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add condition check for trace_amdgpu_cs()
Date: Mon, 17 Aug 2020 17:04:45 +0800
Message-Id: <20200817090445.26479-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR06CA0010.apcprd06.prod.outlook.com
 (2603:1096:202:2e::22) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:202:2e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 09:04:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0d53ef6-6f06-40b0-6500-08d8428c9ed2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3085B6E17B7595524059A0A0A25F0@MN2PR12MB3085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be/5BV0FPIY7w8yBXV2kd0+A0ffXxVIuxLTsJmBxChKl86E1PpeMY3K2dsw16bZr9pq7oUhWtjUT9ksc5Lr8+98SYCAlaY3jpsRUUM+uSHovoT0AUUMtc+4nSWeLixBd4ukYiKX0XZjcr7PURaNHOsZzy1cdfC0okt6YPcsPN8Qmwiis/zVST0P7s1mVzbMPuiVH5RgV62ZX5scCsH1Yqp0XZYr1U9c63xH9NS7EpdWt5H1q1Szk8im1h9gvnUD+jYd+0Lbsw4I+6IgYAx/lFdfvs9cuda2uDEaOTvk8A6VouoK4X1vIscmnojwFv/TZ4CKUZmHwANQoTTJ1mQXVAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(4744005)(8676002)(66556008)(66476007)(5660300002)(66946007)(1076003)(316002)(2616005)(6666004)(956004)(83380400001)(86362001)(2906002)(4326008)(26005)(6916009)(478600001)(52116002)(7696005)(8936002)(36756003)(186003)(16526019)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: HEIJEAG5XurQvODEmFOoOKHdkKr3KWIIu65p4EqCN/kU9MkfZuZfnnFk9JYPxAhDkzvqWkduLgXW5CPcR4TA2n9vpurP3hKwwMjqFKTojOdyehhqpQpLIguitE8rDt8nf4+4C8looW0U4lWgpyy49oLZhla8/SgIcd9etk7AzQuFneIZf8isXMiTCR4dy9qYRmMSHJvgOI5JPhmVowr+EO+SYXOR0HV+tr50qe16Ijea/MiWS4C6nulPiZgrAMvQQTUZO1nIph2oveIXhaalreS8VAjICi0vnYekw1TWsjNYz7cZWtLKkehe5/Wksotz/iqsi3YlkF4JckYvl2vrqnpzmf1N+H6tqIEj/nrYFbcJvMNnF//MMJCB0Bsft4lBBjj92oWRqthheDvfYllrAbyUevAxtU1w5P7DrkRpYnUPGaD+h2y/1u9UCn2QIGfx/B6FKuzqb9fJaqS5rizgzIZMFr5hSNfAb/PwJjRnyQUVKBGJdFIgtq2yxRGuqaYRcnpNOI9fZRgYOehVuM3c6WJTj8Dj1KTvIM7YTWBbBkL8gtxcB/YeNgot1ciJFzzxlHj6fvIwMOAYp7qbFBSDo01YT9B2zSQ6WZvQOMwdI+l7CkFR3FM4rCXMCoJwP3A9cJqKUxEIavB+qzJfsmbVDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d53ef6-6f06-40b0-6500-08d8428c9ed2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 09:05:00.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvvQmdg6oHKAYrXZo9s70FkMK8k0i8xuL1YKGf4trv5s9WX3kwO5C1trRNSmJWkG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3085
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
Cc: Kevin Wang <kevin1.wang@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add trace event enabled check to avoid nop loop when submit multi ibs
in amdgpu_cs_ioctl() function.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ffbcaf4bfb8b..409694f074ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1319,8 +1319,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	reserved_buffers = true;
 
-	for (i = 0; i < parser.job->num_ibs; i++)
-		trace_amdgpu_cs(&parser, i);
+	if (trace_amdgpu_cs_enabled())
+		for (i = 0; i < parser.job->num_ibs; i++)
+			trace_amdgpu_cs(&parser, i);
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
