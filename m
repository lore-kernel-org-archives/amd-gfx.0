Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0732CC43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F2A2075B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 18:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRZ2SPAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F2A2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9F26EAD6;
	Fri, 11 Sep 2020 18:25:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2048.outbound.protection.outlook.com [40.107.102.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52276EAD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 18:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k75fv5+Ylf8zK0eJqoKYBreTM+aTwH40p5a5C3REgsfvcY/fVwZl4V0eUjRjQKVfQLFXuj2oDP/7INsZqmhG/D6/Gbe2AFkj+6tH37RGLF1nMTDbnwSWwgD9q+OayGRowj5nAD0SD0BzqZVNebFhhV0epq56pLpgDXxOR3XosR/Gs1y1eRWiwcDD/qggQTsbEzfHwV/27WRLSpdaaAGizGWbR9C2NKNkAdJQArTrfrNxk6aNusAz5dO/ZqFqK5ry8109QEogBpX2pSIoLVM4uYVEyLGN+B/we+sHZrakiOtd0VKkPEndqRKW3/vV26fupXpdOj8UpFyPlnpK/7W1yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd122ZMp1/T93qcYuqnCdvh+9rSPs9tgLgby/vEJcRw=;
 b=KWRDeJERhRFfeZ9BJoGbT8TaIzPXDzArR5jp8Xh7WIruRLRnMSmZrehxhZj6/XnU8nOyzGBmxG+ZrKlUtlUgXXj2N7smwZPuoP8YpzzWNi5RkatbhUCI5VecnmZONRGWoZDDgTr8T1sXTD7dEyV0PDZ6XRAifmAQ/X4Sc++LHpYIjruEmrJXGcFD2A6gqyDiLkvyq0XL2ATjquFMO7ZSSmZPqohFok+a2LJK2NjAkG4GNFbxpFuAzkEoRbwl6dAyq4l9iU+8U9kqTrz18x5jQHOEKwl4ghOOkd4EW//yuLsFdYU5veg3FXKFsKeZpIacFy9JCI0athcApun0cqf5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pd122ZMp1/T93qcYuqnCdvh+9rSPs9tgLgby/vEJcRw=;
 b=gRZ2SPACgF9j7uxL+D7ZPp+6f3vo9qTEflYpax+dkZ3LP4eBFlLslU2stwBHMy9/kHhgjsV0XDfcju2WQbcyEctBk5SATx/Q3royhV30q9klgzMosE3BXqQiajFc3WZwv92PlINyBAhFb4hykK04DR1MvYDGp2IvgwuALUKrA9s=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Fri, 11 Sep 2020 18:25:45 +0000
Received: from DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341]) by DM5PR12MB1643.namprd12.prod.outlook.com
 ([fe80::8e5:a542:5281:d341%12]) with mapi id 15.20.3326.030; Fri, 11 Sep 2020
 18:25:45 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: More accurate description of a function param
Date: Fri, 11 Sep 2020 13:25:32 -0500
Message-Id: <1599848732-15764-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599848732-15764-1-git-send-email-Oak.Zeng@amd.com>
References: <1599848732-15764-1-git-send-email-Oak.Zeng@amd.com>
X-ClientProxiedBy: YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To DM5PR12MB1643.namprd12.prod.outlook.com
 (2603:10b6:4:11::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 18:25:45 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 10acdcfa-2b5d-47e0-e8ee-08d856801950
X-MS-TrafficTypeDiagnostic: DM6PR12MB4058:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4058691CE335B08A5365563880240@DM6PR12MB4058.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xu9n/LmpnJqJElgy5MRW7aYvqNhQG9BbNlH3/qx2KdBnXEC3PKFhgheHNLhJ2pt6kdB9gylL4k/cYQeX9g7cI9OxiWALULQcbfdtyfu92q4clbpNTxKcUXqbcyctcn/xk+hd+ya7xL8wILqCt7Nw8caT8xQknOP6uLFUNyAlQGolNtm+Wa4/Gt1pCfWQD2WIDIpeKQdDQi+xo8s1rmIQH+Jpr3escorMkmZjMrY4ofkpJzA+fjiUzLc0iwF1y8VTbtwXkE8GawO9Sx/6SutegD3D4Vf3gTIAqyIAxf2I+K8CepHdPJnsknrH4QxadcOGL3GJ/FvHT+vEynQ1dEltxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1643.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(5660300002)(16526019)(8676002)(8936002)(6666004)(2906002)(66556008)(83380400001)(66476007)(66946007)(956004)(478600001)(186003)(36756003)(2616005)(316002)(52116002)(26005)(7696005)(6486002)(4326008)(86362001)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AquqnMP411IHIt3igS3e4pbAYYbyk24n3xLZca1TdrL0EibOFGVU97kIno27PMi4hfKoJ2epty6eyzQglB3HF5YyIQVkN0NAg4XAZswqes3yo2DNNA7QO0hO4paN6UnohKJRVmWwOanx97+RHTX+sEzM08q4L5dLxSoz2ujHiC3J/yQWoRBBhaLMN63qKn3lyhUw4Yue0LrAIQcQFZwMjyyJy7YMDVSeBFVeQnwCZnkr7mH4CPPItMB4krA3ogv9k39+jsA+/1UO7Hkt75oeM5SMll51kBR5DJdtsY71BXj/EL+xJoE5P7r1Eh5OqkLbP9gd6UTgeLVVclRSyTHP7SLs50R3KTGKLkoK0t/TW9LxdU8kNNlQqMi3xf5vqM8Ojaf8CDDzB32f+L1ogPe8g01JNFkjqTyTDgfLnD55wsveVt3+G3S6I66iHET9SFu2+nRF8QdoosmOXvSzujbmJ6x4Z6hn9FRZcb2bkxNGHLuDQb8vi4dmpHNrjWLgt9yT8Kr0l+rIs1bThHf8Yfg3E8g5CCgwE7LWvP3smrt2jCHjtfYIpqNRDYEJrCV4QmHnjmA4wtjzcLGSAhW4YAftE66YTQ/ue3wsyvRhx+rr8DxNd2YpfZSPtWazQQYu4J5P+TzXpO0zrKVQu+0KD94GCw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10acdcfa-2b5d-47e0-e8ee-08d856801950
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1643.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 18:25:45.5839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PK1PxSBFzlDWhfatff4hwNrBqn0bKIXDZwcIS60JhNVk5NLOS1q59/rYTRUARpV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: Oak Zeng <Oak.Zeng@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add more accurate description of the pe parameter of function
amdgpu_vm_sdma_udpate and amdgpu_vm_cpu_update

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 39c704a..0786e755 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -59,7 +59,7 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @bo: PD/PT to update
- * @pe: kmap addr of the page entry
+ * @pe: byte offset of the PDE/PTE, relative to start of PDB/PTB
  * @addr: dst addr to write into pe
  * @count: number of page entries to update
  * @incr: increase next addr by incr bytes
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 189d46e..db79057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -155,7 +155,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @bo: PD/PT to update
- * @pe: addr of the page entry
+ * @pe: byte offset of the PDE/PTE, relative to start of PDB/PTB
  * @addr: dst addr to write into pe
  * @count: number of page entries to update
  * @incr: increase next addr by incr bytes
@@ -187,7 +187,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
  *
  * @p: see amdgpu_vm_update_params definition
  * @bo: PD/PT to update
- * @pe: addr of the page entry
+ * @pe: byte offset of the PDE/PTE, relative to start of PDB/PTB
  * @addr: dst addr to write into pe
  * @count: number of page entries to update
  * @incr: increase next addr by incr bytes
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
