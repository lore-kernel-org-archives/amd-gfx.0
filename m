Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA6EC36008
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 09:20:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA4A10E71E;
	Fri, 21 Mar 2025 09:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="fOUWlnkD";
	dkim-atps=neutral
X-Greylist: delayed 346 seconds by postgrey-1.36 at gabe;
 Thu, 20 Mar 2025 23:49:01 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8D910E04C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1742514536; x=1743119336; i=spasswolf@web.de;
 bh=H2sN7m/Wdif8cWuHLe6L4aA+ynY3kIFzVcj6ozTBAZ0=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fOUWlnkDS/eRfVp80ZDo1eGakpiSTdtFoZ7RYC1BYula7w5cMorzSBA3IyttSgZ8
 RGnpE6TKc945YRgNsGLDxkIc+l//d03VGvuMsTKS8IVcDxdS/DEf9upXzkA6zOte6
 Ao7QfI2W9aV+8+RCDK8dRMBwQsCylEVvtyY5ay9Uvexm5mZjuPlRzFskgJfsJYyyc
 oLN6BCoQ2woKv6om7FeW1Q3ru16SUZatH3OJpuhPr+HlD9dnNPX98RCQdTL2mEtrB
 XuPAkmXi0X6VoSE2zIBgCbicN/UBt+DG3iWUSdkFM6OVVld10tL+unQJ2NOoOGB4y
 ipT9R5XIm4zoZw8YKg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTOhc-1tjLHG48h2-00QZiL; Fri, 21
 Mar 2025 00:43:03 +0100
Message-ID: <841287f296579671dcd91329a49feed97186bcd3.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Fri, 21 Mar 2025 00:43:01 +0100
In-Reply-To: <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
 <b5d80ef2-fd5a-41cc-9184-6c82226c330a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kKM3j/JQ/1It3V3Cl0uqnEO9ygQB20vF4/KiBoh/vSg0It10LrD
 vkYfiGMWu8FJT7UML8UKa4Dl6+ovsUW/tcdsuZv6v7Vp2OqhtuiK/govSUF1NoXBOBTYloE
 Tj9K23DjJEhwr31sSDEl4bLIO1ytso4ah2HwugXO2lvFWW3XOkWV7XJWm1TZIHvR70WGA3V
 FXQ7cQWzMJZsGNRV8Z6eg==
UI-OutboundReport: notjunk:1;M01:P0:mLaQGDaIoy8=;crrNYyPIXdT98JE/mPgehpaKONX
 Txir5u0Gsi8eyFx25OiMi4R8oUKjS7VHwE8+dMnP6tvcgLko9gu94yp7lAjyImLxnLkjnLNcI
 0t7UNYoPds1yvZUcX1bXQKORd2GRHEzU0FezKSNrNiJ10Eyo0LraqikZfZJHTXJ3NB2zIyTmL
 pdWM2Sot2Z6FrgBuSSNHmQTGcE1ktCmMjkuoQdeSOJuZic4DyU6NY/qzWM2f2FgpM2X1JDduv
 Qsg5hwVgn4Y0UNiZcoGDRDtMb/JaZQ9KQjjnD3cNAHJeFfYDvqlfd1oboexfIuEL5P+pabX79
 UjHW7FnSkXXhTPZnOMDjLMo1oNr3LassdDNJlP9Pl85/DiK5EEu7S6wgBDl1H+zoxCP9Dx9kb
 MWn2dT5c8SCOyLjAraztfs3k6w4BCwWEHgL/2oeIFMt0YjthcQxH4mMU0HhuTo8M2Wwgg2xQy
 bqpBuMTtjdpJa6alR9JC3n0NDeKpI7wIkCdUOzzzAtc/OhoHfmEg70Mi+cGVNzcIq/WE7l/rx
 bjrFf8ZKWWbDBWEictL78bLJeK6XG5EqE5lU+0ij5eeIGDIIgzWBh9Ca+3DR0st4QfGrI+Z4X
 /vYCTNYzD7YZf2VdqSFdg3lGKdtpWxuUz+7/GVlCqK1QGCbFj0WgxOyln7c+ZHxKAjqW6mZUM
 VOBAesXzdRd4I6Hd+lDieXPkp4uIwvTysMZtyg5Uz8shPJIb6x+J/YO7LBTNJbsXeMPUNpKwu
 wxu6d/tLuJq5J0LLKSWBjdvmNwosKIUAOBXc09P64XrVD6Bzuj7ETvv9eRG9UjAxOCw8boqwz
 B7qrC1c9140VRHACvzULzc9C1wqw9MJcyGywljzwrTFJpfYoCoL7XYMzZWG9ngZIYQsvvlRYu
 1bmSOnWmxeMak1VWJIqg8Td70Rveqv5ZSnHbymSUsOf6l0lQTrPl0w+a7c0xM5ltV4z0zghXy
 aPHuuVe6D98GH/jC6LYZSGE59od0+83N9hc2dNIk6XEUN8ReVtXiWh/WZfpmx6trl6d+Tyj5s
 cjgqFvx9drzx9hU+Dj+T0l4ZKaHx6nYD6rUr8jwP72oc8h5rEPsAiTuUUbhzucxKkqLtNMffO
 IEQGE6F8kVVYpLOqdMQ/oldVDhopCuAic++7s3gpK+WLeL053YIzzSFKQMyKWaanV2PThc5Qk
 oSh2K4rXPx5FOi2dSjkua57r+1q23BDyQr3weU+1Xa60MTeoWbPvugIrRNvvaJvPyiYy133Zs
 yolp6CJfV1Speqi+a5PswvpZFH6HVoW3zYv+M9xArZ35lSo4RLnJ1QBZOSKMQsx+cMnaj+ojz
 wG48WXe/EVHCgnEtp7+SkK9XCpQi7KM7uWuKI14sklTuWlqj1BGk2viddJz0k9lMYV7QIqqcc
 gYl0xqkcReKI4X3GnVhnvZuSPGXR4JyyGACUc5eDK3vvp3aRH8Mzx80udXBCFuMHwrrAUgblP
 jup3nu++pnkMDYIIKGmHdcjlXwlA=
X-Mailman-Approved-At: Fri, 21 Mar 2025 09:20:13 +0000
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

I did some monitoring using this patch (on top of 6.12.18):

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..ccd0c9058cee 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -121,6 +121,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_mana=
ger
*man,
 	int r;

 	node =3D kzalloc(struct_size(node, mm_nodes, 1), GFP_KERNEL);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO "%s: node =3D %px\n", __func__, node);
 	if (!node)
 		return -ENOMEM;

@@ -142,10 +144,16 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_ma=
nager
*man,
 			goto err_free;

 		node->base.start =3D node->mm_nodes[0].start;
+		if (!strcmp(get_current()->comm, "stellaris"))
+			printk(KERN_INFO "%s %d: node->base.start =3D 0x%lx node-
>base.size =3D 0x%lx\n",
+				__func__, __LINE__, node->base.start, node-
>base.size);
 	} else {
 		node->mm_nodes[0].start =3D 0;
 		node->mm_nodes[0].size =3D PFN_UP(node->base.size);
 		node->base.start =3D AMDGPU_BO_INVALID_OFFSET;
+		if (!strcmp(get_current()->comm, "stellaris"))
+			printk(KERN_INFO "%s %d: node->base.start =3D 0x%lx node-
>base.size =3D 0x%lx\n",
+				__func__, __LINE__, node->base.start, node-
>base.size);
 	}

 	*res =3D &node->base;
@@ -170,6 +178,8 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_man=
ager
*man,
 {
 	struct ttm_range_mgr_node *node =3D to_ttm_range_mgr_node(res);
 	struct amdgpu_gtt_mgr *mgr =3D to_gtt_mgr(man);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO "%s: node =3D %px\n", __func__, node);

 	spin_lock(&mgr->lock);
 	if (drm_mm_node_allocated(&node->mm_nodes[0]))
@@ -217,7 +227,11 @@ static bool amdgpu_gtt_mgr_intersects(struct
ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	bool ret;
+	ret =3D !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO, "%s: returning ret =3D %d", __func__, ret);
+	return ret;
 }

 /**
@@ -235,7 +249,11 @@ static bool amdgpu_gtt_mgr_compatible(struct
ttm_resource_manager *man,
 				      const struct ttm_place *place,
 				      size_t size)
 {
-	return !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	bool ret;
+	ret =3D !place->lpfn || amdgpu_gtt_mgr_has_gart_addr(res);
+	if (!strcmp(get_current()->comm, "stellaris"))
+		printk(KERN_INFO, "%s: returning ret =3D %d", __func__, ret);
+	return ret;
 }

 /**
@@ -288,6 +306,8 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, ui=
nt64_t
gtt_size)
 	drm_mm_init(&mgr->mm, start, size);
 	spin_lock_init(&mgr->lock);

+	dev_info(adev->dev, "%s: start =3D 0x%llx size =3D 0x%llx\n", __func__,
start, size);
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
index 1ed68d3cd80b..e525a1276304 100644
=2D-- a/drivers/gpu/drm/drm_mm.c
+++ b/drivers/gpu/drm/drm_mm.c
@@ -223,6 +223,13 @@ static void insert_hole_size(struct rb_root_cached *r=
oot,
 	struct rb_node **link =3D &root->rb_root.rb_node, *rb =3D NULL;
 	u64 x =3D node->hole_size;
 	bool first =3D true;
+	int count =3D 0;
+
+	if (!strcmp(get_current()->comm, "stellaris")) {
+		for(struct rb_node *first =3D rb_first_cached(root); first; first
=3D rb_next(first))
+			count++;
+		printk(KERN_INFO "%s: RB count =3D %d\n", __func__, count);
+	}

 	while (*link) {
 		rb =3D *link;
@@ -247,6 +254,13 @@ static void insert_hole_addr(struct rb_root *root, st=
ruct
drm_mm_node *node)
 	struct rb_node **link =3D &root->rb_node, *rb_parent =3D NULL;
 	u64 start =3D HOLE_ADDR(node), subtree_max_hole =3D node->subtree_max_ho=
le;
 	struct drm_mm_node *parent;
+	int count =3D 0;
+
+	if (!strcmp(get_current()->comm, "stellaris")) {
+		for(struct rb_node *first =3D rb_first(root); first; first =3D
rb_next(first))
+			count++;
+		printk(KERN_INFO "%s: RB count =3D %d\n", __func__, count);
+	}

 	while (*link) {
 		rb_parent =3D *link;


With this I ran stellaris (just opening the game the closing it again from=
 the
game menu)

The findings are:
(a) The size of the RB tree is the same in the working and non-working cas=
e (50-
60)
(b) The number of calls to amdgpu_gtt_mgr_new() is ~2000 in both cases
(c) In the non-working case amdgpu_gtt_mgr_del() is called far more often =
then
in the working case:
Non-working case (cmdline: nokaslr) 834 calls to amdgpu_gtt_mgt_del()
Working case (cmdline: nokaslr amdgpu.vramlimit=3D512) 51 calls to
amdgpu_gtt_mgr_del()
Working case (cmdline: no additional arguments) 44 calls to amdgpu_gtt_mgr=
_del()


Bert Karwatzki
