Return-Path: <SRS0=UM6f=Z4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB91C43603
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 21:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DD2A217BA
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2019 21:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD2A217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1DD6FA97;
	Fri,  6 Dec 2019 21:50:55 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760088.outbound.protection.outlook.com [40.107.76.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 399E86FA97
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2019 21:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohs84xTyP0JfiCf2VGiJHcb3QWoNZo6+ON+BmCfneslxeWizmBKiJ96OtHdI43aOzQnH667ai9Eshg4w64mWMkzKdBn4X/JV64Le87oPk3iXTDD0pPdFaMPGXo4qL90x5P2zJSpL4TmCNBoQ3XaKrLWgwbqERwrV2LrpTKmQ9RKJwUt3NjiaxbdLiXRIYP4oLxvAqXYF46eHZpuXOlujHCsEolbioRLxyEZBXXAPhXoPJAWHvUgPqAoZS7UCiuiKmJAhnwOfF1gwgYDLo58JGTxGeexoi7yBCepfJH6Oe4Fo/5H2xdb9pJ8E0zV+ELmq3ANHWjWf7TyfWK9w5B0AaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuZ3LFV7yFdF0x7jn1WNA5qH5GAZZAJUfjm8De3sNTs=;
 b=Sj6pOfxEIdTiAIzRBufWBxXjdemabGvZmxOAp0C6XmogPbOa7HNsFNC56AfCVDrBLNAELuOyAnSVK3/xkNp4Jw2JcAYr1htWwHRoqBWZG6uXrhOZVWF6PGOby3nseyWLJk1/zUJIzPWXnszU1uCWfO16zvoBRkASZyB1JQ11eH9TUf146WlcwFJ9zHHaNBhpI2Q4woFYZYo/2uxHQKq4G4YYqMKu3b76iH6VgzoPcImkKK7p8WgGnv6PIiQgVTtI2djf336qgBaT68NSFgpRxO+8RNht2eXCw44jIUxR1olfg+6+jSQIg4z3orifPRLIRstvV7rM5fvmRFphcjN1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MWHPR12MB1453.namprd12.prod.outlook.com (10.172.55.22) by
 MWHPR12MB1790.namprd12.prod.outlook.com (10.175.50.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Fri, 6 Dec 2019 21:50:50 +0000
Received: from MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80]) by MWHPR12MB1453.namprd12.prod.outlook.com
 ([fe80::514b:dbf8:d19f:a80%12]) with mapi id 15.20.2495.014; Fri, 6 Dec 2019
 21:50:50 +0000
Subject: Re: [PATCH 07/10] drm/amdgpu: add concurrent baco reset support for
 XGMI
To: "Ma, Le" <Le.Ma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-6-git-send-email-le.ma@amd.com>
 <c09d7928-f864-3a80-40e2-b6116abe044c@amd.com>
 <MN2PR12MB42859443EA78D08B295AFE0DF6470@MN2PR12MB4285.namprd12.prod.outlook.com>
 <157d7671-803c-4f6e-f77c-9738f32905e3@amd.com>
 <MN2PR12MB428532FA663C99770AA71263F6430@MN2PR12MB4285.namprd12.prod.outlook.com>
 <5b505116-17aa-383d-5cdf-246663a1f4f9@amd.com>
 <MN2PR12MB42855B198BB4064A0D311845F6420@MN2PR12MB4285.namprd12.prod.outlook.com>
 <2c4dd3f3-e2ce-9843-312b-1e5c05a51521@amd.com>
 <CH2PR12MB4278F9759EF24F29A85D7D23F65D0@CH2PR12MB4278.namprd12.prod.outlook.com>
 <0cf9f58a-3ce4-2a9c-cb1a-db3cb13760b9@amd.com>
 <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <a38e95ac-ca7e-20fd-0c2a-4d4310e8599a@amd.com>
Date: Fri, 6 Dec 2019 16:50:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
In-Reply-To: <MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com>
Content-Type: multipart/mixed; boundary="------------0D9D97FA420FF2B59011F0CB"
Content-Language: en-US
X-ClientProxiedBy: BN4PR12CA0024.namprd12.prod.outlook.com
 (2603:10b6:403:2::34) To MWHPR12MB1453.namprd12.prod.outlook.com
 (2603:10b6:301:e::22)
MIME-Version: 1.0
X-Originating-IP: [2607:fea8:3edf:e127:c5a0:8df5:d3f5:f311]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c7386ca-dc35-4838-7d50-08d77a965b6d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1790:|MWHPR12MB1790:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1790420FAEBA6CB91CED3C69EA5F0@MWHPR12MB1790.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0243E5FD68
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(199004)(189003)(52314003)(66946007)(37036004)(58126008)(31696002)(316002)(53546011)(86362001)(4326008)(66576008)(66476007)(110136005)(66556008)(6506007)(65956001)(6512007)(5660300002)(6636002)(568964002)(186003)(6666004)(235185007)(2616005)(2906002)(36756003)(99286004)(81156014)(229853002)(81166006)(71190400001)(33964004)(8676002)(31686004)(54896002)(76176011)(52116002)(478600001)(8936002)(6486002)(921003)(1121003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1790;
 H:MWHPR12MB1453.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4uS0iq6Ku9/REaM3Fd60gPGbLCvcc0s21pJU/VqZQztQgcC9kA8y+Rjz/T8yCXDcRzSM+DVk5YBN4dcGsdybhLcTE1hucJQGtGBv9qijIbKwMT1LZeWUG52bUkgq9kydwJr9k3fNBut9/4+vK8l7ypH4a/v05PWusGS5/zVes7g6w9HL1lJYyAOsfn4F4bz9IfG5dNIz2yZ0bAUiYNya6KHeKUisHMKQO9b/v2zL6eGlLgJEm/G4UfAq345P23W3j3INry1HHvlAr1gVVOAmTG3oiMj9M1S4106XwSOcr7IctjRQdJhhsLsoojbrz5jfcsWZft2hplH5U3/v67t3Ge+HqK+ln2LB3NOvIiVHNwk9P0e7bjgiJIHHUvE4gwx5usPzcoHJbtzC3zFQ9KCJofH9TCum+oy90kwcpZ9kxg4ElF31GYJFTxtz0jrWY24z65QfrDplfbdNBHJmmXNFeXfvxcfZwSmAsj2kYOX5O2nmumTeOMa8vlHPhrMS5Kx9/XEVm8qx2cJ4c3aqVJueBw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7386ca-dc35-4838-7d50-08d77a965b6d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2019 21:50:50.0806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJYiLgSLMUwOA/81c8i9y/1g+oV1KVLzFsjyzXI7RQ8DR7n5okAsVGS4mHHnQvuRHidyhVb2SH2EWGiPN3KE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1790
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuZ3LFV7yFdF0x7jn1WNA5qH5GAZZAJUfjm8De3sNTs=;
 b=Cy5lWXsgW3OSUiMJtY7zT+UtL4zg/MkH/SB3F24Hkh38yeDD2VCD22jxAKSCv9q9H9NkijhI6P1NmH3IkU4Y+g0S2ftnsgU2bz6jj+i7pO9TzPXmrl6LuKQmIrnxTXAnwG05jjoh+7a7eFzILy+9IMYiaSBGPmyBTeVoBWsVjDs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Chen, Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------0D9D97FA420FF2B59011F0CB
Content-Type: multipart/alternative;
 boundary="------------EB020B6A16E3E68E57A121C7"

--------------EB020B6A16E3E68E57A121C7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Ma, attached a solution - it's just compiled as I still can't make 
my XGMI setup work (with bridge connected only one device is visible to 
the system while the other is not). Please try it on your system if you 
have a chance.

Andrey

On 12/4/19 10:14 PM, Ma, Le wrote:
>
> AFAIK it's enough for even single one node in the hive to to fail the 
> enter the BACO state on time to fail the entire hive reset procedure, no ?
>
> [Le]: Yeah, agree that. I’ve been thinking that make all nodes 
> entering baco simultaneously can reduce the possibility of node 
> failure to enter/exit BACO risk. For example, in an XGMI hive with 8 
> nodes, the total time interval of 8 nodes enter/exit BACO on 8 CPUs is 
> less than the interval that 8 nodes enter BACO serially and exit BACO 
> serially depending on one CPU with yield capability. This interval is 
> usually strict for BACO feature itself. Anyway, we need more looping 
> test later on any method we will choose.
>
> Any way - I see our discussion blocks your entire patch set - I think 
> you can go ahead and commit yours way (I think you got an RB from 
> Hawking) and I will look then and see if I can implement my method and 
> if it works will just revert your patch.
>
> [Le]: OK, fine.
>
> Andrey
>

--------------EB020B6A16E3E68E57A121C7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hey Ma, attached a solution - it's just compiled as I still can't
      make my XGMI setup work (with bridge connected only one device is
      visible to the system while the other is not). Please try it on
      your system if you have a chance. <br>
    </p>
    <p>Andrey<br>
    </p>
    <div class="moz-cite-prefix">On 12/4/19 10:14 PM, Ma, Le wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MN2PR12MB42855296AE5C7EDA968AA442F65C0@MN2PR12MB4285.namprd12.prod.outlook.com">
      <p>AFAIK it's enough for even single one node in the hive to to
        fail the enter the BACO state on time to fail the entire hive
        reset procedure, no ?<o:p></o:p></p>
      <p class="MsoNormal"><span style="font-size:12.0pt;color:#203864">[Le]:
          Yeah, agree that. I’ve been thinking that make all nodes
          entering baco simultaneously can reduce the possibility of
          node failure to enter/exit BACO risk. For example, in an XGMI
          hive with 8 nodes, the total time interval of 8 nodes
          enter/exit BACO on 8 CPUs is less than the interval that 8
          nodes enter BACO serially and exit BACO serially depending on
          one CPU with yield capability. This interval is usually strict
          for BACO feature itself. Anyway, we need more looping test
          later on any method we will choose.<o:p></o:p></span></p>
      <p>Any way - I see our discussion blocks your entire patch set - I
        think you can go ahead and commit yours way (I think you got an
        RB from Hawking) and I will look then and see if I can implement
        my method and if it works will just revert your patch.<o:p></o:p></p>
      <p><span style="font-size:12.0pt;color:#203864">[Le]: OK, fine.<o:p></o:p></span></p>
      <p>Andrey</p>
    </blockquote>
  </body>
</html>

--------------EB020B6A16E3E68E57A121C7--

--------------0D9D97FA420FF2B59011F0CB
Content-Type: text/x-patch;
 name="0001-drm-Add-Reusable-task-barrier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-drm-Add-Reusable-task-barrier.patch"

From 1c89d4d835b9dbb6e02bdbdce903adbd12b1c115 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 12:26:33 -0500
Subject: drm: Add Reusable task barrier.

It is used to synchronize N threads at a rendevouz point before execution
of critical code that has to be started by all the threads at approximatly
the same time.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 include/drm/task_barrier.h | 97 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 include/drm/task_barrier.h

diff --git a/include/drm/task_barrier.h b/include/drm/task_barrier.h
new file mode 100644
index 0000000..858cd7f
--- /dev/null
+++ b/include/drm/task_barrier.h
@@ -0,0 +1,97 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include <linux/semaphore.h>
+#include <linux/atomic.h>
+
+/*
+ * Reusable 2 PHASE task barrier (randevouz point) implementation for N tasks.
+ * Based on the Little book of sempahores - https://greenteapress.com/wp/semaphores/
+ */
+
+
+
+#ifndef DRM_TASK_BARRIER_H_
+#define DRM_TASK_BARRIER_H_
+
+/*
+ * Represents an instance of a task barrier.
+ */
+struct task_barrier {
+	unsigned int n;
+	atomic_t count;
+	struct semaphore enter_turnstile;
+	struct semaphore exit_turnstile;
+};
+
+static inline void task_barrier_signal_turnstile(struct semaphore *turnstile,
+					  unsigned int n) {
+	int i;
+	for (i = 0 ; i < n; i++)
+		up(turnstile);
+}
+
+static inline void task_barrier_init(struct task_barrier *tb) {
+
+	tb->n = 0;
+	atomic_set(&tb->count, 0);
+	sema_init(&tb->enter_turnstile, 0);
+	sema_init(&tb->exit_turnstile, 0);
+}
+
+static inline void task_barrier_add_task(struct task_barrier *tb) {
+	tb->n++;
+}
+
+static inline void task_barrier_rem_task(struct task_barrier *tb) {
+	tb->n--;
+}
+
+/*
+ * Lines up all the threads BEFORE the critical point.
+ *
+ * When all thread passed this code the entry barrier is back to locked state.
+ */
+static inline void task_barrier_enter(struct task_barrier *tb) {
+
+	if (atomic_inc_return(&tb->count) == tb->n)
+			task_barrier_signal_turnstile(&tb->enter_turnstile,
+						      tb->n);
+
+	down(&tb->enter_turnstile);
+}
+
+/*
+ * Lines up all the threads AFTER the critical point.
+ *
+ * This function is used to avoid any one thread running ahead of the reset if
+ * the barrier is used in a loop (repeatedly) .
+ */
+static inline void task_barrier_exit(struct task_barrier *tb) {
+	if (atomic_dec_return(&tb->count) == 0)
+			task_barrier_signal_turnstile(&tb->exit_turnstile,
+						      tb->n);
+
+	down(&tb->exit_turnstile);
+}
+
+#endif
-- 
2.7.4


--------------0D9D97FA420FF2B59011F0CB
Content-Type: text/x-patch;
 name="0002-drm-amdgpu-Add-task-barrier-to-XGMI-hive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0002-drm-amdgpu-Add-task-barrier-to-XGMI-hive.patch"

From 77d54ef864cb0c667b9396f0cdf5c66cb672f6c2 Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 12:43:30 -0500
Subject: drm/amdgpu: Add task barrier to XGMI hive.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 61d13d8..5cf920d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -261,6 +261,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lo
 	INIT_LIST_HEAD(&tmp->device_list);
 	mutex_init(&tmp->hive_lock);
 	mutex_init(&tmp->reset_lock);
+	task_barrier_init(&tmp->tb);
 
 	if (lock)
 		mutex_lock(&tmp->hive_lock);
@@ -408,6 +409,8 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 	top_info->num_nodes = count;
 	hive->number_devices = count;
 
+	task_barrier_add_task(&hive->tb);
+
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			/* update node list for other device in the hive */
@@ -470,6 +473,7 @@ void amdgpu_xgmi_remove_device(struct amdgpu_device *adev)
 		mutex_destroy(&hive->hive_lock);
 		mutex_destroy(&hive->reset_lock);
 	} else {
+		task_barrier_rem_task(&hive->tb);
 		amdgpu_xgmi_sysfs_rem_dev_info(adev, hive);
 		mutex_unlock(&hive->hive_lock);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index bbf504f..74011fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -22,6 +22,7 @@
 #ifndef __AMDGPU_XGMI_H__
 #define __AMDGPU_XGMI_H__
 
+#include <drm/task_barrier.h>
 #include "amdgpu_psp.h"
 
 struct amdgpu_hive_info {
@@ -33,6 +34,7 @@ struct amdgpu_hive_info {
 	struct device_attribute dev_attr;
 	struct amdgpu_device *adev;
 	int pstate; /*0 -- low , 1 -- high , -1 unknown*/
+	struct task_barrier tb;
 };
 
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev, int lock);
-- 
2.7.4


--------------0D9D97FA420FF2B59011F0CB
Content-Type: text/x-patch;
 name="0003-drm-amdgpu-Redo-concurrent-support-of-BACO-reset-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-drm-amdgpu-Redo-concurrent-support-of-BACO-reset-for.pa";
 filename*1="tch"

From 016717e5caeaf1355935eb4302e43396c8a494ce Mon Sep 17 00:00:00 2001
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Date: Fri, 6 Dec 2019 13:19:15 -0500
Subject: drm/amdgpu: Redo concurrent support of BACO reset for XGMI.

Use task barrier in XGMI hive to synchronize BACO enter/exit
across devices in XGMI hive.
This also reverts commit b01245ff54db66073b104ac9d9fbefb7b264b36d.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 113 +++++++++++------------------
 2 files changed, 44 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a78a363..50bab33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1001,8 +1001,6 @@ struct amdgpu_device {
 
 	bool                            pm_sysfs_en;
 	bool                            ucode_sysfs_en;
-
-	bool				in_baco;
 };
 
 static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7324a5f..bf04e81 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -67,6 +67,7 @@
 #include "amdgpu_tmz.h"
 
 #include <linux/suspend.h>
+#include <drm/task_barrier.h>
 
 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
 MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
@@ -2664,13 +2665,39 @@ static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
 	struct amdgpu_device *adev =
 		container_of(__work, struct amdgpu_device, xgmi_reset_work);
 
-	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)
-		adev->asic_reset_res = (adev->in_baco == false) ?
-				amdgpu_device_baco_enter(adev->ddev) :
-				amdgpu_device_baco_exit(adev->ddev);
-	else
-		adev->asic_reset_res = amdgpu_asic_reset(adev);
+	/*
+	 * Use task barrier to synchronize all xgmi reset works across the
+	 * hive.
+	 * task_barrier_enter and task_barrier_exit will block untill all the
+	 * threads running the xgmi reset works reach those points. I assume
+	 * guarantee of progress here for all the threads as the workqueue code
+	 * creates new worker threads as needed by amount of work items in queue
+	 * (see worker_thread) and also each thread sleeps in the barrir and by
+	 * this yielding the CPU for other work threads to make progress.
+	 */
+	if (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) {
+		struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(adev, 0);
+
+		if (hive)
+			task_barrier_enter(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_enter(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
 
+		if (hive)
+			task_barrier_exit(&hive->tb);
+
+		adev->asic_reset_res = amdgpu_device_baco_exit(adev->ddev);
+
+		if (adev->asic_reset_res)
+			goto fail;
+	} else {
+		adev->asic_reset_res =  amdgpu_asic_reset(adev);
+	}
+
+fail:
 	if (adev->asic_reset_res)
 		DRM_WARN("ASIC reset failed with error, %d for drm dev, %s",
 			 adev->asic_reset_res, adev->ddev->unique);
@@ -3796,18 +3823,13 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
-			       struct amdgpu_hive_info *hive,
+static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
 			       struct list_head *device_list_handle,
 			       bool *need_full_reset_arg)
 {
 	struct amdgpu_device *tmp_adev = NULL;
 	bool need_full_reset = *need_full_reset_arg, vram_lost = false;
 	int r = 0;
-	int cpu = smp_processor_id();
-	bool use_baco =
-		(amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO) ?
-		true : false;
 
 	/*
 	 * ASIC reset has to be done on all HGMI hive nodes ASAP
@@ -3815,62 +3837,22 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 	 */
 	if (need_full_reset) {
 		list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
-			/*
-			 * For XGMI run all resets in parallel to speed up the
-			 * process by scheduling the highpri wq on different
-			 * cpus. For XGMI with baco reset, all nodes must enter
-			 * baco within close proximity before anyone exit.
-			 */
+			/* For XGMI run all resets in parallel to speed up the process */
 			if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-				if (!queue_work_on(cpu, system_highpri_wq,
-						   &tmp_adev->xgmi_reset_work))
+				if (!queue_work(system_highpri_wq, &tmp_adev->xgmi_reset_work))
 					r = -EALREADY;
-				cpu = cpumask_next(cpu, cpu_online_mask);
 			} else
 				r = amdgpu_asic_reset(tmp_adev);
-			if (r)
-				break;
-		}
 
-		/* For XGMI wait for all work to complete before proceed */
-		if (!r) {
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					flush_work(&tmp_adev->xgmi_reset_work);
-					r = tmp_adev->asic_reset_res;
-					if (r)
-						break;
-					if (use_baco)
-						tmp_adev->in_baco = true;
-				}
-			}
-		}
-
-		/*
-		 * For XGMI with baco reset, need exit baco phase by scheduling
-		 * xgmi_reset_work one more time. PSP reset and sGPU skips this
-		 * phase. Not assume the situation that PSP reset and baco reset
-		 * coexist within an XGMI hive.
-		 */
-
-		if (!r && use_baco) {
-			cpu = smp_processor_id();
-			list_for_each_entry(tmp_adev, device_list_handle,
-					    gmc.xgmi.head) {
-				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
-					if (!queue_work_on(cpu,
-						system_highpri_wq,
-						&tmp_adev->xgmi_reset_work))
-						r = -EALREADY;
-					if (r)
-						break;
-					cpu = cpumask_next(cpu, cpu_online_mask);
-				}
+			if (r) {
+				DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
+					 r, tmp_adev->ddev->unique);
+				break;
 			}
 		}
 
-		if (!r && use_baco) {
+		/* For XGMI wait for all PSP resets to complete before proceed */
+		if (!r) {
 			list_for_each_entry(tmp_adev, device_list_handle,
 					    gmc.xgmi.head) {
 				if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
@@ -3878,21 +3860,15 @@ static int amdgpu_do_asic_reset(struct amdgpu_device *adev,
 					r = tmp_adev->asic_reset_res;
 					if (r)
 						break;
-					tmp_adev->in_baco = false;
 				}
 			}
 		}
-
-		if (r) {
-			DRM_ERROR("ASIC reset failed with error, %d for drm dev, %s",
-				 r, tmp_adev->ddev->unique);
-			goto end;
-		}
 	}
 
 	if (!r && amdgpu_ras_intr_triggered())
 		amdgpu_ras_intr_cleared();
 
+
 	list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
 		if (need_full_reset) {
 			/* post card */
@@ -4181,8 +4157,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (r)
 			adev->asic_reset_res = r;
 	} else {
-		r  = amdgpu_do_asic_reset(adev, hive, device_list_handle,
-					  &need_full_reset);
+		r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
 		if (r && r == -EAGAIN)
 			goto retry;
 	}
-- 
2.7.4


--------------0D9D97FA420FF2B59011F0CB
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--------------0D9D97FA420FF2B59011F0CB--
