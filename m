Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91944C433E9
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 21:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D096146D
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 21:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D096146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F006E1D3;
	Tue, 23 Feb 2021 21:11:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3876E1D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 21:11:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUsO6FAjWw0SUZaPh4zSP7eNEkakTBXwb8d9atx1Kox9rOVKX6UvucAzDIJhohSzb1T8fz78nM3FLHf4a2F9XLH1H8j5655vfbBr+htfqlY9Q8YrkK30g+GgGz5BCdNJR97VjoiJjSWXMfePSa32LvfbhqMb+N9N9lx+etqB3jdse7ctOwzfAcbi0IPEEOiPCOCharcKLneV9FDaXjm5fw+5CHOR+BIGzFLO43848ksckcLZxQ5oOHL5FRTx4N/BhhgRHGIy5/f+xeCTUvWWCcmPj3Ag/6aWVEcBo0gYNoyWGEpq4u6wC8ML9suRVlHOMDUV/PjvvRFbQWlEoEmV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz4ZsY6hH3dlh9xmZLb0eMY5p5sQ9dOrQJTw/HEJyHA=;
 b=Rx3E3Mp0ybMkQf92qdo02Jj/o5MKCMN6WpbUuX3eAMBEtpWZQvOQDD+gz3MTCMmsBf61mkKOwNLcQ+A9ZIbthwAfT1eQAFhzVLQUAf1LsCwG3VUsU9Bn+VCda997iGkUL38mk8PF0dbiw+tsNROQTialIyDZG84x9Ryu83a49yi+XjxBZQeiCKV3rpYvtjB3YH3+mZSrPM2joI7j9Eo9I94iySLvUYfA1MgFYjvi8FxUnrMlGvDK1QMSmBbhtk4353sbyBqUiUCShBb6vtLmuaSWrJx7IGuZ9PnPzx3spgpfQctnoS0akgeQTum4GeWTBNhrPY/cR4neryVrLoS/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz4ZsY6hH3dlh9xmZLb0eMY5p5sQ9dOrQJTw/HEJyHA=;
 b=hm03cx6SR7acy3/r6ScnGKK7x/VNjchDLU2aDQGJH6vuuCgeA8L8851uEuKuRPjM8UIGqww+lYVOQH0s4aNPuvbbDEK6Rvq9ITC4D3B+GQD6DeZArq5LD3N8c9BhEr69iLQsHXR2ywBr5u8UdPwiKHUN5SZ/JWQuPeiYuC8HRBc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB4682.namprd12.prod.outlook.com (2603:10b6:302:e::32)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Tue, 23 Feb
 2021 21:10:57 +0000
Received: from MW2PR12MB4682.namprd12.prod.outlook.com
 ([fe80::195b:7e51:6992:7480]) by MW2PR12MB4682.namprd12.prod.outlook.com
 ([fe80::195b:7e51:6992:7480%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 21:10:57 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add ih call to process until checkpoint
Date: Tue, 23 Feb 2021 16:10:26 -0500
Message-Id: <20210223211026.116403-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::25) To MW2PR12MB4682.namprd12.prod.outlook.com
 (2603:10b6:302:e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT1PR01CA0116.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.29 via Frontend Transport; Tue, 23 Feb 2021 21:10:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 67d9b6e7-1949-480f-35c7-08d8d83f82db
X-MS-TrafficTypeDiagnostic: MW3PR12MB4554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4554876A233DE3FC6D15CD8785809@MW3PR12MB4554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EOJ4qhJ747n+rPCX9jWQyblHH9BZvXJihaC/1S7V3JTsR9XsN8BHddhuqP+2FOU0gyQuF+VunjhlF8lc8GwhochC8KkE+lOREGPP1E//1oHCigW3J1Smi6ByBGf3VTbqVLDU58Gc3zh6UZffy2Y0XOdVGJAK0bSHKHpBwpSIDkpblaTVQnWCXFY7fn/o9coBl321CvmgJsiNAt6pQNu1fM9UdIx4XmV7rq2c6AfBmh5hwePlTsjCZIppnQubbv8ZF2F4pWQ0VbZ0zBlB4BYWeoX0nMkVUupd4Cao2v/hwZHujiZM+ifu/fxNojPjYsb8F2Mj5YZn8ySnh8c8EUeTannoIqRYC++eSQmD6y8xDYynIhvGP9NctFGq31RqRCVa4VL4VtghNAbTNZcSUfx8+dHkljACLJEfpKn+g9nN9dNWpi9boCJdptCSpRiISi3CDkA80mxwHTotwplCmYhtR0sKD+HNir7h4r0eL3l9gvWvzjf+batPsboOw5zjXCWKSXJJRsbh9A0mzbSOgahxkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4682.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(2906002)(26005)(956004)(5660300002)(6916009)(6486002)(8936002)(2616005)(8676002)(186003)(16526019)(52116002)(86362001)(36756003)(66556008)(6666004)(478600001)(7696005)(4326008)(44832011)(66476007)(1076003)(316002)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l7jIfu3a5+DvQg3nJ+uyZa6+TGiL8mvdQVkDthKYXDNP5o5sCeYTwjzpCT8j?=
 =?us-ascii?Q?3eZ/igQHevSJmUmkfJMK6fhrKhhtei8B0NGDluKYNyjuNnFr2rvj3bvj98az?=
 =?us-ascii?Q?CeTSnDNndIIjd7s/Dwr/Backf/t/O+yTw+MxfQGRh1n3Chx9gkJ5tBvRyzCI?=
 =?us-ascii?Q?kQz1NPHUnEHfhIDovADTvJ6YueQAucK9T4G8ki2MwvWOBBk+xUohgwYCVykW?=
 =?us-ascii?Q?UXQyj1XS0xTDDXatttGNWkhfwRFuEmrpXS7QI2mq3EsG9nM6gEmpTwlDuQN+?=
 =?us-ascii?Q?tQaOJpISc4zML9DqGSYMxechwifnM6GL4alUdInfl8z30ByAqvtqiK2duU6M?=
 =?us-ascii?Q?3vUXlsrCgj9z7uk87ibPuUdh8kpkjUb/69hCyL2PxhuRFaQ5FkOXF19gimYS?=
 =?us-ascii?Q?NfkvgxfiQ6WNJiAbjTJSegzlSwvHMNptdMRa7SzzL7N0wsTDCnZRzaDk2UqB?=
 =?us-ascii?Q?pbDCiInb7c6FT0N+UFfnomg51AimzG+KyswYjNlbt7vlLmKovTqDUgjJADS0?=
 =?us-ascii?Q?FteTaCN+wFfy34JoHylbCnGMUHvq6/vfXqH7lB6cyS+5NRHcpEa8UKrRryCK?=
 =?us-ascii?Q?8fMvKUDLM832YVEQhysLREDvqSDUZxkllYo7v0Z9EDydK1m+NHXUf4cLWQTt?=
 =?us-ascii?Q?CpJfZzkPaU6TWQdOlYtQbiRB31b1xdnadhqhlmO5DZm87BhQeXQwkDwqkF4R?=
 =?us-ascii?Q?8hkW44Buwh1noBP0yAu3wDQkA2DNFls/vcP5Gx1wyDoaKMgf0VeXhFXGWbch?=
 =?us-ascii?Q?7PgviSs5iq5VmZp4+Ka9jnPkIF8a9GK+yCW6H+mHtkwDyF2ymMoic3b9Fq1R?=
 =?us-ascii?Q?cIJPkp0qBPj7AbKhnFRmLzzPsgn9AY2z8J9oDsQEg/c+O05gFTf1xl3N2Czt?=
 =?us-ascii?Q?K0jQ5RkcHTCR3zCNhhYDlFjb6d+Cb4KmVIkhSobX68SnZFs50wnHOGnbRDmj?=
 =?us-ascii?Q?dhokRlnE8AWwJT1Dn7QuzeouaK1QQHuamwEAj++zATLZuQyVh7FNLJAS28zz?=
 =?us-ascii?Q?YjXJk/y5Ftb9l+MISgUnW3vyJzJxnZtth2IBboseHYAW0HYOyETgJvbijio1?=
 =?us-ascii?Q?c0sLBOAiMrEKPrPrCCe0yCz9kADLZEeDjqzTAdz27+qQ+qx5xHoZ1jolJMRX?=
 =?us-ascii?Q?t/Hj+XP8sMYKJtqS5Otaq21eL4xqKIzNdD9xHCjAD1rjW+dFRgKfgAqJykht?=
 =?us-ascii?Q?Pqpts4RBf+7m7nAdp4anx/ILIS1zUeoH6oXxImgpFrBet88myCTf7dOC3P5P?=
 =?us-ascii?Q?fNcuVoLheC3ou6Q7H37bT/R9TRL54E+RnQX+lYZdoDMQ1a76CDC1m31JRZ+z?=
 =?us-ascii?Q?25mGh4yWnFsMQoBudCJRVarC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9b6e7-1949-480f-35c7-08d8d83f82db
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4682.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 21:10:57.2243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XfRkUxfPc+5iUNIVTaiJGHKMFxBq4RWHLO7SQJFGlzwLqxJwb/cfFpoIZeVF2F+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add IH function to allow caller to process ring entries until the
checkpoint write pointer.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 46 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 ++
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index dc852af4f3b7..cae50af9559d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/dma-mapping.h>
-
+#include <linux/processor.h>
 #include "amdgpu.h"
 #include "amdgpu_ih.h"
 
@@ -160,6 +160,50 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
+/**
+ * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: ih ring to process
+ *
+ * Used to ensure ring has processed IVs up to the checkpoint write pointer.
+ */
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih)
+{
+	u32 prev_rptr, cur_rptr, checkpoint_wptr;
+
+	if (!ih->enabled || adev->shutdown)
+		return -ENODEV;
+
+	cur_rptr = READ_ONCE(ih->rptr);
+	/* Order read of current rptr with checktpoint wptr. */
+	mb();
+	checkpoint_wptr = amdgpu_ih_get_wptr(adev, ih);
+
+	/* allow rptr to wrap around  */
+	if (cur_rptr > checkpoint_wptr) {
+		spin_begin();
+		do {
+			spin_cpu_relax();
+			prev_rptr = cur_rptr;
+			cur_rptr = READ_ONCE(ih->rptr);
+		} while (cur_rptr >= prev_rptr);
+		spin_end();
+	}
+
+	/* wait for rptr to catch up to or pass checkpoint. */
+	spin_begin();
+	do {
+		spin_cpu_relax();
+		prev_rptr = cur_rptr;
+		cur_rptr = READ_ONCE(ih->rptr);
+	} while (cur_rptr >= prev_rptr && cur_rptr < checkpoint_wptr);
+	spin_end();
+
+	return 0;
+}
+
 /**
  * amdgpu_ih_process - interrupt handler
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 6ed4a85fc7c3..6817f0a812d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
