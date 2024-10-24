Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BFDD0C609
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 12:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16FB010EAAD;
	Fri, 25 Oct 2024 12:48:12 +0000 (UTC)
X-Greylist: delayed 1108 seconds by postgrey-1.36 at gabe;
 Thu, 24 Oct 2024 13:41:26 UTC
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com
 [45.249.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5367B10E258;
 Thu, 24 Oct 2024 13:41:26 +0000 (UTC)
Received: from mail.maildlp.com (unknown [172.19.163.216])
 by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XZ66H48kJz4f3nZs;
 Thu, 24 Oct 2024 21:22:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
 by mail.maildlp.com (Postfix) with ESMTP id D58981A0196;
 Thu, 24 Oct 2024 21:23:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
 by APP4 (Coremail) with SMTP id gCh0CgCHusYpShpn7tb6Ew--.444S14;
 Thu, 24 Oct 2024 21:23:05 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, viro@zeniv.linux.org.uk, brauner@kernel.org,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org, hughd@google.com,
 willy@infradead.org, sashal@kernel.org, srinivasan.shanmugam@amd.com,
 chiahsuan.chung@amd.com, mingo@kernel.org, mgorman@techsingularity.net,
 yukuai3@huawei.com, chengming.zhou@linux.dev, zhangpeng.00@bytedance.com,
 chuck.lever@oracle.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-mm@kvack.org,
 yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH 6.6 10/28] maple_tree: use cached node end in mas_next()
Date: Thu, 24 Oct 2024 21:19:51 +0800
Message-Id: <20241024132009.2267260-11-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
References: <20241024132009.2267260-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCHusYpShpn7tb6Ew--.444S14
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWUuw4rXF43Cr4rCFy7GFg_yoW5WF4Upa
 4DWa45K39FyF18Krnavr45Zr9Fgr1ak3yUta47Gw15XFyDtr1fXF1DAa48uFs093s2vF13
 Aw45C3WUCws7GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
 xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
 F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
 IY04v7MxkF7I0En4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
 6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
 CEb7AF67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
 42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
 daVFxhVjvjDU0xZFpf9x0pR4E__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-Mailman-Approved-At: Fri, 25 Oct 2024 12:48:03 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

commit e9c52d8940cbfd94b36035bbebce7f55954e7728 upstream.

When looking for the next entry, don't recalculate the node end as it is
now tracked in the maple state.

Link: https://lkml.kernel.org/r/20231101171629.3612299-6-Liam.Howlett@oracle.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 lib/maple_tree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d19fb14a9635..e0dcc8412da0 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4539,6 +4539,7 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 	unsigned long min;
 	unsigned long *pivots;
 	struct maple_enode *enode;
+	struct maple_node *tmp;
 	int level = 0;
 	unsigned char node_end;
 	enum maple_type mt;
@@ -4591,6 +4592,10 @@ static inline int mas_next_node(struct ma_state *mas, struct maple_node *node,
 		pivots = ma_pivots(node, mt);
 
 	mas->max = mas_safe_pivot(mas, pivots, mas->offset, mt);
+	tmp = mte_to_node(enode);
+	mt = mte_node_type(enode);
+	pivots = ma_pivots(tmp, mt);
+	mas->end = ma_data_end(tmp, mt, pivots, mas->max);
 	if (unlikely(ma_dead_node(node)))
 		return 1;
 
@@ -4625,7 +4630,6 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	unsigned long pivot;
 	enum maple_type type;
 	struct maple_node *node;
-	unsigned char data_end;
 	unsigned long save_point = mas->last;
 	void *entry;
 
@@ -4633,12 +4637,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 	node = mas_mn(mas);
 	type = mte_node_type(mas->node);
 	pivots = ma_pivots(node, type);
-	data_end = ma_data_end(node, type, pivots, mas->max);
 	if (unlikely(mas_rewalk_if_dead(mas, node, save_point)))
 		goto retry;
 
 	if (mas->max >= max) {
-		if (likely(mas->offset < data_end))
+		if (likely(mas->offset < mas->end))
 			pivot = pivots[mas->offset];
 		else
 			goto overflow;
@@ -4650,11 +4653,11 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 			goto overflow;
 	}
 
-	if (likely(mas->offset < data_end)) {
+	if (likely(mas->offset < mas->end)) {
 		mas->index = pivots[mas->offset] + 1;
 again:
 		mas->offset++;
-		if (likely(mas->offset < data_end))
+		if (likely(mas->offset < mas->end))
 			mas->last = pivots[mas->offset];
 		else
 			mas->last = mas->max;
@@ -4691,7 +4694,6 @@ static void *mas_next_slot(struct ma_state *mas, unsigned long max, bool empty,
 			goto overflow;
 
 		mas->index = mas->last + 1;
-		/* Node cannot end on NULL, so it's safe to short-cut here */
 		goto again;
 	}
 
-- 
2.39.2

