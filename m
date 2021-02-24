Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8588464EDD
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8588464EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0336EB9C;
	Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249186EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQU9zX73rwCPy0jp9PPleNQpVNB2+3QDwv8XiVue2F4vjJVrG1iyCmIRDnmkRonjyTl2cKs8fPzT3kP3BZZQUQIxB5rfRMgE9ltoP7FhHd9wdkzJF7+z1ml+5taKSGIFGTQ07GMlWG3fGHUtiNZl8E6gQv+/dmH770HOvR+2tKQTEJpQ0hxPkzV2MpcQVy14/hBjkofHOxtlcsKqBMcMaeS3MVB8oqe9MwwGMm14SAM5dYr6oDLxvJdt/rauGz6Iv9fY8YpYNib6rj4NU4z2dJgZKcqSxOj6n1naje/pEGdqDIKhtLQPlXERHReWzCv2mRiR1nUMM6Yw1nGHCiEsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHg98KR9GF0lZY2vvTrxfl05QaSEPNxhLzmZv8PCxSY=;
 b=SqJT6BTiydSjDo4V2xINMYm/3vS2Y/DSybRMPGTgigtFKw/+SdKUIgLQ+R/g9GboWaeN+BeA/sbsBKAWpV2+x0wO6Z7ttpx7Jm7tcBVvp9kEMmSDcTDLU1h93HF09qpm6oB3j6iFvLQ0O0uCmdAWNX46OGWPOMmi2vlCSG6a+MsvEu6IxsJlLS+qC04OVy6qasRbzw1XM4xOxGDPesuR7XX7/ABWVjGwUoGdX0Ym74UcpjSD9//DjGN8nCJUqWwLAobRApYUu4Dyrn9c21CzU7QcsuWFuvLc0SLTDsr0J6fzmMKViFSeT1hqmco6YtzYo7pm7tcpdmoOjdjObh0hFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHg98KR9GF0lZY2vvTrxfl05QaSEPNxhLzmZv8PCxSY=;
 b=17tr2o7J7KQkzvr065b/CSyuXkyF+w8EzP+fZWxPDIAWJGvzkl9qGG7ZRwMg3frIqeltqaw3Z5aGcsqINvhI5BlDxCHFJytm1sX1/Nqumg3s6ZguZDEDLc3oE9ZB2eN6Yx9GOFOOYw8n3maxrzlmaRIDt1jZVUgoG76xVCQiRXQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:31 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:31 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 136/159] drm/amdgpu: enable sram initialization for aldebaran
Date: Wed, 24 Feb 2021 17:18:36 -0500
Message-Id: <20210224221859.3068810-129-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae6ba439-a889-4edc-5772-08d8d91273d7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503C78745758F67F9D00484F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJosN06/W9radSi/+7hTXnaLdAwHPvsSddlvygNH+LZgYadYg36SiDKUpabbCz9JUIFV19YmEjQ1DdPVaXdBhayn1iOK6xLben7iuBnHaFOaAH2/TJduzzqWHgw3/dFkiJlZ61GREivXlZyB8MBE9zJuJ3LRLyQ7zuN8bGeHxIFF8UiWmqF13yAnwHboGATIuAq3FrfWoOgo4Tj8ZFcyCmg3aeftfOc3lBWo1qZhd/xDPCn+SslqN+rrgddgvFKsilwkzqkeXE/vKLStE02Uy8L2PNY7IfcxXAhImePjx3jAoE37+FrIBVzxvVvdb/Db/0qRU/3umX78wzjE3qXdKjlX66m/xQZI2Oq0J3aWqLN965Omlbz1JKl6LxXgcN5HfPzy2f6/1Qw2VtLWf769rf+XuJf0BioYlfZUPgI3Br3RSl/W2G734j1UGUImvli0azW0t6zti8u/qCpEzMAe4sAumsYIdjit2Pqj0Qu9FYwAqcxDNubMZaK3Xub0lmqR40G8fjMJuEklW1feKW2LarcVF7AK8wHIyPIiCOnvN6p5orEW2S/Pn0yzwotyZl2R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jrmrO4Pj9Izjgi0pe6NOEZO/Q2gut90xbK2PAkobWavfc2YXVizLGwMgWtJu?=
 =?us-ascii?Q?k4uCm9UfeL03MBZsrQecv/3lpe0Whj7elK+m2QkgqPHKWr1CVbHbZCnYkMer?=
 =?us-ascii?Q?wGeJ80trXzcltpZbEeC2TSQJXjYEjvS3glDA9PqbtdAnvrlMel6pjtf7xKh/?=
 =?us-ascii?Q?nIKQuMfZCjbGE3k2Ftlo5C+DYIygSPzwG7y3W11TLtGooDwgLzFP4+WfHudi?=
 =?us-ascii?Q?rmBhdrfH4w7G0fIDD0/BBD16ZBp0DmIizkFvZgSui3uqYeLUMQXnCRT8/3hD?=
 =?us-ascii?Q?UWnO0ya63hDRR7on0pdRlQH1BBPkgjN45lZEUZiUjeyA4JO3yM5iiPgOZCmA?=
 =?us-ascii?Q?mYsXBkuZtCYPA8KDf3td6QTm8n+e0ZxQuCMJIzipAqcj+smOYDzey16OcVJ8?=
 =?us-ascii?Q?ByCQ8dr/TxL41H7ezu2Xv69cebkejax4M2tLCq6D1rwJn3cwH4v2/ubc13uw?=
 =?us-ascii?Q?D7LXob3Dx3nHCXCzUE4smymrBKRKhmmDq77Or+CXCUVgWZI2RzatgWKDRU0n?=
 =?us-ascii?Q?osWKcW9IXZOktzRBf0QwmA0A+HfDeUq+NvLR4roplqkDKM+8Ox2CcYUECz2B?=
 =?us-ascii?Q?w5j9jvdfwNR5TG0mTzy0zndtW8+EW5UNo/2bMsG4p9OVQTIrcVuWE7VOfNcf?=
 =?us-ascii?Q?n/eSw2JaXTTYmByYMzhduW6UcerXttMSMTG7Uv8KC6+FEP4TsBKkWtJyi4Zu?=
 =?us-ascii?Q?vJBO5/U9E0Eaw/5cORAIZ0bYqUWqsKiAOtmGqP1RIDPJ2uQVhl+LfwtvfohQ?=
 =?us-ascii?Q?iMyvylCyRmlsJYECBTnNgpl4CS/oKDQhDOp/pO9S1q5t7BAASTdvdPGlh+FN?=
 =?us-ascii?Q?wOx6Y0QNEMMVZzRcsJ0YIYVWIBi0cu/uZnlzMLMGkQQR6gen89gTUtn/4xQQ?=
 =?us-ascii?Q?WaNZSW3HSeZfV/wbmPDPcYD/OkBUV7k8elCICOLu0Zu5rjv/k+Y1A2jeBMjS?=
 =?us-ascii?Q?shqjTfMfIjOtaRV7id5a8moPo5tYjFUCxWtl4zw6m0zbYRgutgKxWHJpjwFx?=
 =?us-ascii?Q?9uaZBfejWlLLmMBidN8BluU9/wf7LfHVkuh0+HVik6oAq2qF7qfPlBGXBAmU?=
 =?us-ascii?Q?R9l+OKwFLqeWEJecTcCBdiSH/pVeCxgXvFDD19LOQy6YdhK+TeuA0P+y7gIJ?=
 =?us-ascii?Q?ApsxUy426864Fop3aZrz9UMfKhZBg/k/eqS0aahaS+83PjB6kGFHRmT5F/q5?=
 =?us-ascii?Q?gm7NwA/x06a9dN1xMrkFWPRsh7rv6tV3Zl8j/6PqFLD5NpQAETrhAhM2h4Jt?=
 =?us-ascii?Q?YUHGdF9iCtY/HHkH9t57w9e3cNGI1e5LH1rVNVjwjr8sVuV4kJg3vMz6RanV?=
 =?us-ascii?Q?vWteRd9tnUtvIV7YlNtuphbI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6ba439-a889-4edc-5772-08d8d91273d7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:55.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PgeXITaqR5peUpaVv/LagKjLkTHQNi1Thl/ECcDB7T/ekAQY5j3DLaKaa7fAP9UtZF0s+YEs3wl9VOw2DuIBtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Dennis Li <Dennis.Li@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dennis Li <Dennis.Li@amd.com>

Aldebaran can share the same initializing shader code witn
arcturus.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 95e97f564f2a..5bac5659e707 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4516,7 +4516,8 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!ring->sched.ready)
 		return 0;
 
-	if (adev->asic_type == CHIP_ARCTURUS) {
+	if (adev->asic_type == CHIP_ARCTURUS ||
+	    adev->asic_type == CHIP_ALDEBARAN) {
 		vgpr_init_shader_ptr = vgpr_init_compute_shader_arcturus;
 		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader_arcturus);
 		vgpr_init_regs_ptr = vgpr_init_regs_arcturus;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
