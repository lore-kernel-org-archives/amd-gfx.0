Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC27CE77198
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2025 10:13:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C2F10E865;
	Fri,  3 Jan 2025 10:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xlxKXdrj";
	dkim-atps=neutral
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5CE10E0FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2025 02:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735870951; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=Vgxvv4nEn+iS04LU4aPFOgDAPBsUeAb6lvT4y5e5tA8=;
 b=xlxKXdrjD/ylYGe4FcD0rgTuYcTvGTA282Rh29fdZTNlp0VScjnEGnjYulD2/MXPPXw97xa6/2q7pdvsUhZyVIBJg3M1WaTeOFdgStSB6GKKNuKN2QfVo5HmD3U13SAnrKSyNPbUTE9ByTamm4z1JjU7rQWFgNszJJVdwSk+plY=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMrb5Eb_1735870950 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 03 Jan 2025 10:22:30 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <3CAD4155-244E-44EC-9EC4-D441E17DBEA2@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_1C1DF36B-BA52-4BC0-9927-4B1AC02FE5DE"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/6] amdgpu: fix invalid memory access in
 kfd_cleanup_nodes()
Date: Fri, 3 Jan 2025 10:22:29 +0800
In-Reply-To: <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
 <7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@linux.alibaba.com>
 <b835ec1b-f40b-4abb-8267-934a0e497415@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Mailman-Approved-At: Fri, 03 Jan 2025 10:12:56 +0000
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


--Apple-Mail=_1C1DF36B-BA52-4BC0-9927-4B1AC02FE5DE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=883=E6=97=A5 07:08=EF=BC=8CChen, Xiaogang =
<xiaogang.chen@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/1/2025 11:36 PM, Jiang Liu wrote:
>> On error recover path during device probe, it may trigger invalid
>> memory access as below:
>> 024-12-25 12:00:53 [ 2703.773040] general protection fault, probably =
for non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
>> 2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod =
Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
>> 2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba =
Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>> 2024-12-25 12:00:53 [ 2703.809188] RIP: =
0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
>> 2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 =
45 e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 =
00 00 00 0f
>> 1f 44 00 00 55 <80> bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d e9 =
65 df 9d f4 8b
>> 2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: =
00010202
>> 2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: =
ffff97ad689a3ff0 RCX: 0000000080400014
>> 2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: =
ffff97ad627e93d8 RDI: 52445f4749464e4f
>> 2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: =
0000000000000000 R09: ffffffffb5814c00
>> 2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: =
0000000000000001 R12: ffffb5313df07e98
>> 2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: =
0000000000000001 R15: 0000000000000000
>> 2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) =
GS:ffff98a93ec80000(0000) knlGS:0000000000000000
>> 2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> 2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: =
000001008fc50001 CR4: 0000000002770ee0
>> 2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
>> 2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
>> 2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
>> 2024-12-25 12:00:54 [ 2703.935444] Call Trace:
>> 2024-12-25 12:00:54 [ 2703.938962]  =
amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
>> 2024-12-25 12:00:54 [ 2703.946080]  =
amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
>> 2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 =
[amdgpu]
>> 2024-12-25 12:00:54 [ 2703.959789]  =
amdgpu_driver_release_kms+0x12/0x30 [amdgpu]
>> 2024-12-25 12:00:54 [ 2703.966501]  =
devm_drm_dev_init_release+0x42/0x70 [drm]
>> 2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
>> 2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 =
[amdxcp]
>> 2024-12-25 12:00:54 [ 2703.983906]  =
__do_sys_delete_module.constprop.0+0x138/0x2a0
>> 2024-12-25 12:00:54 [ 2703.990775]  ? =
exit_to_user_mode_loop+0xd6/0x120
>> 2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
>> 2024-12-25 12:00:54 [ 2704.001166]  =
entry_SYSCALL_64_after_hwframe+0x62/0xc7
>> 2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
>> 2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 =
00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f =
1e fa b8 b0
>> 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 f7 =
d8 64 89 01 48
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com> =
<mailto:gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index b6c5ffd4630b..58c1b5fcf785 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev =
*kfd, unsigned int num_nodes)
>> =20
>>  	for (i =3D 0; i < num_nodes; i++) {
>>  		knode =3D kfd->nodes[i];
>> +		if (!knode)
>> +			continue;
> I wonder how knode can be null here? kfd_cleanup_nodes is called by =
kgd2kfd_device_exit under condition if (kfd->init_complete). =
kfd->init_complete is true only after all kfd node got initialized at =
kgd2kfd_device_init. If kfd driver init fail  kfd->init_complete would =
be false, then kfd_cleanup_node would not get called.
>=20
Hi Xiaogang,
	It may get triggered on error handling path of =
=E2=80=98kid2kfd_device_init()`, when it jump to label =
`node_alloc_error` and=20
then call `kfd_cleanup_nodes()`.

Thanks,
Gerry

>=20
> Regards
>=20
> Xiaogang
>=20
>>  		device_queue_manager_uninit(knode->dqm);
>>  		kfd_interrupt_exit(knode);
>>  		kfd_topology_remove_device(knode);
>> @@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>  		kfd_doorbell_fini(kfd);
>>  		ida_destroy(&kfd->doorbell_ida);
>>  		kfd_gtt_sa_fini(kfd);
>> -		amdgpu_amdkfd_free_gtt_mem(kfd->adev, &kfd->gtt_mem);
>> +		if (kfd->gtt_mem) {
>> +			amdgpu_amdkfd_free_gtt_mem(kfd->adev, =
&kfd->gtt_mem);
>> +			kfd->gtt_mem =3D NULL;
>> +		}
>>  	}
>> =20
>>  	kfree(kfd);


--Apple-Mail=_1C1DF36B-BA52-4BC0-9927-4B1AC02FE5DE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=883=E6=97=A5 07:08=EF=BC=8CChen, =
Xiaogang &lt;<a href=3D"mailto:xiaogang.chen@amd.com" =
class=3D"">xiaogang.chen@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</div>=
<br class=3D"Apple-interchange-newline"><div class=3D"">
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8" =
class=3D"">
 =20
  <div class=3D""><p class=3D""><br class=3D"">
    </p>
    <div class=3D"moz-cite-prefix">On 1/1/2025 11:36 PM, Jiang Liu =
wrote:<br class=3D"">
    </div>
    <blockquote type=3D"cite" =
cite=3D"mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre">On error recover path =
during device probe, it may trigger invalid
memory access as below:
024-12-25 12:00:53 [ 2703.773040] general protection fault, probably for =
non-canonical address 0x52445f4749464e4f: 0000 [#1] SMP NOPTI
2024-12-25 12:00:53 [ 2703.785199] CPU: 157 PID: 151951 Comm: rmmod =
Kdump: loaded Tainted: G        W  OE     5.10.134-17.2.al8.x86_64 #1
2024-12-25 12:00:53 [ 2703.797515] Hardware name: Alibaba Alibaba Cloud =
ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-25 12:00:53 [ 2703.809188] RIP: =
0010:kgd2kfd_device_exit+0x6/0x60 [amdgpu]
2024-12-25 12:00:53 [ 2703.816136] Code: ff 48 c7 83 38 01 00 00 80 45 =
e4 c0 c7 83 40 01 00 00 08 0f 00 00 e9 cd fa ff ff 66 0f 1f 84 00 00 00 =
00 00 0f
1f 44 00 00 55 &lt;80&gt; bf 28 01 00 00 00 48 89 fd 75 09 48 89 ef 5d =
e9 65 df 9d f4 8b
2024-12-25 12:00:54 [ 2703.838622] RSP: 0018:ffffb5313df07e10 EFLAGS: =
00010202
2024-12-25 12:00:54 [ 2703.845216] RAX: 0000000000000000 RBX: =
ffff97ad689a3ff0 RCX: 0000000080400014
2024-12-25 12:00:54 [ 2703.853935] RDX: 0000000080400015 RSI: =
ffff97ad627e93d8 RDI: 52445f4749464e4f
2024-12-25 12:00:54 [ 2703.862652] RBP: ffff97ad689a3ff0 R08: =
0000000000000000 R09: ffffffffb5814c00
2024-12-25 12:00:54 [ 2703.871368] R10: ffff97ad627e9280 R11: =
0000000000000001 R12: ffffb5313df07e98
2024-12-25 12:00:54 [ 2703.880068] R13: ffff97ad689a1810 R14: =
0000000000000001 R15: 0000000000000000
2024-12-25 12:00:54 [ 2703.888768] FS:  00007fa4db81e740(0000) =
GS:ffff98a93ec80000(0000) knlGS:0000000000000000
2024-12-25 12:00:54 [ 2703.898547] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
2024-12-25 12:00:54 [ 2703.905684] CR2: 00007f4502deca00 CR3: =
000001008fc50001 CR4: 0000000002770ee0
2024-12-25 12:00:54 [ 2703.914382] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
2024-12-25 12:00:54 [ 2703.923066] DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
2024-12-25 12:00:54 [ 2703.931746] PKRU: 55555554
2024-12-25 12:00:54 [ 2703.935444] Call Trace:
2024-12-25 12:00:54 [ 2703.938962]  =
amdgpu_amdkfd_device_fini_sw+0x1a/0x40 [amdgpu]
2024-12-25 12:00:54 [ 2703.946080]  =
amdgpu_device_ip_fini.isra.0+0x3d/0x1b0 [amdgpu]
2024-12-25 12:00:54 [ 2703.953278]  amdgpu_device_fini_sw+0x2a/0x240 =
[amdgpu]
2024-12-25 12:00:54 [ 2703.959789]  amdgpu_driver_release_kms+0x12/0x30 =
[amdgpu]
2024-12-25 12:00:54 [ 2703.966501]  devm_drm_dev_init_release+0x42/0x70 =
[drm]
2024-12-25 12:00:54 [ 2703.972891]  release_nodes+0x6e/0xb0
2024-12-25 12:00:54 [ 2703.977522]  amdgpu_xcp_drv_release+0x38/0x80 =
[amdxcp]
2024-12-25 12:00:54 [ 2703.983906]  =
__do_sys_delete_module.constprop.0+0x138/0x2a0
2024-12-25 12:00:54 [ 2703.990775]  ? exit_to_user_mode_loop+0xd6/0x120
2024-12-25 12:00:54 [ 2703.996563]  do_syscall_64+0x2e/0x50
2024-12-25 12:00:54 [ 2704.001166]  =
entry_SYSCALL_64_after_hwframe+0x62/0xc7
2024-12-25 12:00:54 [ 2704.007432] RIP: 0033:0x7fa4db2620cb
2024-12-25 12:00:54 [ 2704.012025] Code: 73 01 c3 48 8b 0d a5 6d 19 00 =
f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e =
fa b8 b0
00 00 00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 6d 19 00 =
f7 d8 64 89 01 48

Signed-off-by: Jiang Liu <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a=
>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b6c5ffd4630b..58c1b5fcf785 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,8 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, =
unsigned int num_nodes)
=20
 	for (i =3D 0; i &lt; num_nodes; i++) {
 		knode =3D kfd-&gt;nodes[i];
+		if (!knode)
+			continue;</pre>
    </blockquote><p class=3D"">I wonder how knode can be null here? =
<span style=3D"white-space: pre-wrap" class=3D"">kfd_cleanup_nodes</span> =
is called
      by kgd2kfd_device_exit under condition if (kfd-&gt;init_complete).
      kfd-&gt;init_complete is true only after all kfd node got
      initialized at kgd2kfd_device_init. If kfd driver init fail&nbsp;
      kfd-&gt;init_complete would be false, then <span =
style=3D"white-space: pre-wrap" class=3D"">kfd_cleanup_node would not =
get called.</span></p></div></div></blockquote><div>Hi =
Xiaogang,</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>It may get triggered on error =
handling path of =E2=80=98kid2kfd_device_init()`, when it jump to label =
`node_alloc_error` and&nbsp;</div><div>then call =
`kfd_cleanup_nodes()`.</div><div><br =
class=3D""></div><div>Thanks,</div><div>Gerry</div><br =
class=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><div =
class=3D""><div class=3D""><br class=3D"webkit-block-placeholder"></div><p=
 class=3D""><span style=3D"white-space: pre-wrap" =
class=3D"">Regards</span></p><p class=3D""><span style=3D"white-space: =
pre-wrap" class=3D"">Xiaogang
</span></p>
    <blockquote type=3D"cite" =
cite=3D"mid:7aace7d239b729340e311ad6e08a14f60b87a361.1735795671.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre"> 		=
device_queue_manager_uninit(knode-&gt;dqm);
 		kfd_interrupt_exit(knode);
 		kfd_topology_remove_device(knode);
@@ -954,7 +956,10 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
 		kfd_doorbell_fini(kfd);
 		ida_destroy(&amp;kfd-&gt;doorbell_ida);
 		kfd_gtt_sa_fini(kfd);
-		amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, =
&amp;kfd-&gt;gtt_mem);
+		if (kfd-&gt;gtt_mem) {
+			amdgpu_amdkfd_free_gtt_mem(kfd-&gt;adev, =
&amp;kfd-&gt;gtt_mem);
+			kfd-&gt;gtt_mem =3D NULL;
+		}
 	}
=20
 	kfree(kfd);
</pre>
    </blockquote>
  </div>

</div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_1C1DF36B-BA52-4BC0-9927-4B1AC02FE5DE--
