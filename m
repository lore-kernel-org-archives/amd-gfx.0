Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A58E77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:07:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705FC10E81D;
	Wed,  8 Jan 2025 09:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pd/zbeDj";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4AEC10E7E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 03:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736307294; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=tdZYreF4V8ZsFSnJakQ0zG9syBnAyk/6ul0hGbpqgNA=;
 b=pd/zbeDjCODz9nlWlk6CyVaR1hAQGsIuKlNnHOJ8mv/m/K0Jp31zsnczq6sX+sk7qyFcgQuiwiFFW5JF4gNhIcpJTQVsh6mSy+5MCexuSVwHjZnhoTTnw47eje4CQIkITLn/CDEx1Wd7A+GByL1vikKCn3IJ5w1Q7H0Ciu2SxeM=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNCP8JL_1736307290 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 11:34:52 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <A13BE326-3978-4434-AAEF-2B6613C05A79@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_B777BF54-AC9C-491B-ABD1-4DC379CBF2E5"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 4/6] amdgpu: fix use after free bug related to
 amdgpu_driver_release_kms()
Date: Wed, 8 Jan 2025 11:34:44 +0800
In-Reply-To: <9e73447e-520f-4caf-bedf-a8be36105bad@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@linux.alibaba.com>
 <9e73447e-520f-4caf-bedf-a8be36105bad@amd.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Mailman-Approved-At: Wed, 08 Jan 2025 09:07:10 +0000
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


--Apple-Mail=_B777BF54-AC9C-491B-ABD1-4DC379CBF2E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=888=E6=97=A5 06:55=EF=BC=8CChen, Xiaogang =
<xiaogang.chen@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/4/2025 8:45 PM, Jiang Liu wrote:
>> If some GPU device failed to probe, `rmmod amdgpu` will trigger a use
>> after free bug related to amdgpu_driver_release_kms() as:
>> 2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer =
dereference, address: 0000000000000000
>> 2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in =
kernel mode
>> 2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - =
not-present page
>> 2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
>> 2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP =
NOPTI
>> 2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod =
Kdump: loaded Tainted: G        W   E      6.10.0+ #2
>> 2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba =
Cloud ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
>> 2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 =
[gpu_sched]
>> 2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 =
ce e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 =
31 e4 48 8b
>> 43 28 4d 63 ec <4a> 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 48 =
8d 55 10 48 39
>> 2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: =
00010246
>> 2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: =
ffff96b0fdadc878 RCX: 0000000000000000
>> 2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: =
0000000000000000 RDI: ffff96b0fdadc8f8
>> 2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: =
ffff97abbd035040 R09: ffffffff9ac52540
>> 2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
>> 2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: =
ffff96b0fdadfc00 R15: 0000000000000000
>> 2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) =
GS:ffff97abbd100000(0000) knlGS:0000000000000000
>> 2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
>> 2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: =
000000011be3a005 CR4: 0000000000f70ef0
>> 2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
>> 2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
>> e024se+0x3c/0x90 [amdxcp]
>> 2024-12-26 16:17:46 [16002.337645]  =
__do_sys_delete_module.constprop.0+0x176/0x310
>> 2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
>> 2024-12-26 16:17:46 [16002.348858]  =
entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> 2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26
>>=20
>> Fix it by unplugging xcp drm devices when failed to probe GPU =
devices.
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com> =
<mailto:gerry@linux.alibaba.com>
>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com> =
<mailto:shuox.liu@linux.alibaba.com>
>> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com> =
<mailto:lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index d2a046736edd..9ebc0d47d1cb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -165,8 +165,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device =
*adev, unsigned long flags)
>>  		DRM_WARN("smart shift update failed\n");
>> =20
>>  out:
>> -	if (r)
>> +	if (r) {
>> +		amdgpu_xcp_dev_unplug(adev);
> You have made amdgpu_xcp_drm_dev_free, why still use =
amdgpu_xcp_dev_unplug here? I think you want undo =
amdgpu_xcp_drm_dev_alloc in error path. Why involve adev device unplug? =
It is a different scenario.
>=20
Hi xiaogang,
     I didn=E2=80=99t get your point yet. Current work flow is:
amdgpu_pci_probe()
	-> amdgpu_driver_load_kms()
		-> amdgpu_device_init()
			->amdgpu_discovery_set_ip_blocks()
				-> amdgpu_xcp_mgr_init()
					-> amdgpu_xcp_alloc_dev()
	-> amdgpu_xcp_dev_register()
And amdgpu_xcp_dev_unplug() undos work done by amdgpu_xcp_dev_register() =
and part of amdgpu_xcp_mgr_ini().
How about splitting amdgpu_xcp_dev_unplug() into =
amdgpuxcp_dev_deregister() and amdgpu_xcp_mgr_fini(), then things should =
get much clear.
And it seems the xcp_mgr object is leaked current, and there are =
resource leakage on error handling path of amdgpu_pci_probe.=20
Above proposal may also help to fix those resource leakages.
Thanks,
Gerry
> Regards
>=20
> Xiaogang
>=20
>>  		amdgpu_driver_unload_kms(dev);
>> +	}
>> =20
>>  	return r;
>>  }


--Apple-Mail=_B777BF54-AC9C-491B-ABD1-4DC379CBF2E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=888=E6=97=A5 06:55=EF=BC=8CChen, =
Xiaogang &lt;<a href=3D"mailto:xiaogang.chen@amd.com" =
class=3D"">xiaogang.chen@amd.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A</div>=
<br class=3D"Apple-interchange-newline"><div class=3D"">
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8" =
class=3D"">
 =20
  <div class=3D""><p class=3D""><br class=3D"">
    </p>
    <div class=3D"moz-cite-prefix">On 1/4/2025 8:45 PM, Jiang Liu =
wrote:<br class=3D"">
    </div>
    <blockquote type=3D"cite" =
cite=3D"mid:d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre">If some GPU device failed =
to probe, `rmmod amdgpu` will trigger a use
after free bug related to amdgpu_driver_release_kms() as:
2024-12-26 16:17:45 [16002.085540] BUG: kernel NULL pointer dereference, =
address: 0000000000000000
2024-12-26 16:17:45 [16002.093792] #PF: supervisor read access in kernel =
mode
2024-12-26 16:17:45 [16002.099993] #PF: error_code(0x0000) - not-present =
page
2024-12-26 16:17:45 [16002.106188] PGD 0 P4D 0
2024-12-26 16:17:45 [16002.109464] Oops: Oops: 0000 [#1] PREEMPT SMP =
NOPTI
2024-12-26 16:17:45 [16002.115372] CPU: 2 PID: 14375 Comm: rmmod Kdump: =
loaded Tainted: G        W   E      6.10.0+ #2
2024-12-26 16:17:45 [16002.125577] Hardware name: Alibaba Alibaba Cloud =
ECS/Alibaba Cloud ECS, BIOS 3.0.ES.AL.P.087.05 04/07/2024
2024-12-26 16:17:45 [16002.136858] RIP: 0010:drm_sched_fini+0x3f/0xe0 =
[gpu_sched]
2024-12-26 16:17:45 [16002.143463] Code: 60 c6 87 be 00 00 00 01 e8 ce =
e0 90 d8 48 8d bb 80 00 00 00 e8 c2 e0 90 d8 8b 43 20 85 c0 74 51 45 31 =
e4 48 8b
43 28 4d 63 ec &lt;4a&gt; 8b 2c e8 48 89 ef e8 f5 0e 59 d9 48 8b 45 10 =
48 8d 55 10 48 39
2024-12-26 16:17:45 [16002.164992] RSP: 0018:ffffb570dbbb7da8 EFLAGS: =
00010246
2024-12-26 16:17:45 [16002.171316] RAX: 0000000000000000 RBX: =
ffff96b0fdadc878 RCX: 0000000000000000
2024-12-26 16:17:46 [16002.179784] RDX: 000fffffffe00000 RSI: =
0000000000000000 RDI: ffff96b0fdadc8f8
2024-12-26 16:17:46 [16002.188252] RBP: ffff96b0fdadc800 R08: =
ffff97abbd035040 R09: ffffffff9ac52540
2024-12-26 16:17:46 [16002.196722] R10: 0000000000000000 R11: =
0000000000000000 R12: 0000000000000000
2024-12-26 16:17:46 [16002.205179] R13: 0000000000000000 R14: =
ffff96b0fdadfc00 R15: 0000000000000000
2024-12-26 16:17:46 [16002.213648] FS:  00007f2737000740(0000) =
GS:ffff97abbd100000(0000) knlGS:0000000000000000
2024-12-26 16:17:46 [16002.223189] CS:  0010 DS: 0000 ES: 0000 CR0: =
0000000080050033
2024-12-26 16:17:46 [16002.230103] CR2: 0000000000000000 CR3: =
000000011be3a005 CR4: 0000000000f70ef0
2024-12-26 16:17:46 [16002.238581] DR0: 0000000000000000 DR1: =
0000000000000000 DR2: 0000000000000000
2024-12-26 16:17:46 [16002.247053] DR3: 0000000000000000 DR6: =
00000000fffe07f0 DR7: 0000000000000400
e024se+0x3c/0x90 [amdxcp]
2024-12-26 16:17:46 [16002.337645]  =
__do_sys_delete_module.constprop.0+0x176/0x310
2024-12-26 16:17:46 [16002.344324]  do_syscall_64+0x5d/0x170
2024-12-26 16:17:46 [16002.348858]  =
entry_SYSCALL_64_after_hwframe+0x76/0x7e
2024-12-26 16:17:46 [16002.354956] RIP: 0033:0x7f2736a620cb-12-26

Fix it by unplugging xcp drm devices when failed to probe GPU devices.

Signed-off-by: Jiang Liu <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a=
>
Tested-by: Shuo Liu <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:shuox.liu@linux.alibaba.com">&lt;shuox.liu@linux.alibaba.co=
m&gt;</a>
Reviewed-by: Lijo Lazar <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:lijo.lazar@amd.com">&lt;lijo.lazar@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c =
b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2a046736edd..9ebc0d47d1cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -165,8 +165,10 @@ int amdgpu_driver_load_kms(struct amdgpu_device =
*adev, unsigned long flags)
 		DRM_WARN("smart shift update failed\n");
=20
 out:
-	if (r)
+	if (r) {
+		amdgpu_xcp_dev_unplug(adev);</pre>
    </blockquote><p class=3D"">You have made <span style=3D"white-space: =
pre-wrap" class=3D"">amdgpu_xcp_drm_dev_free, why still use </span><span =
style=3D"white-space: pre-wrap" class=3D"">amdgpu_xcp_dev_unplug</span> =
here? I
      think you want undo <span style=3D"white-space: pre-wrap" =
class=3D"">amdgpu_xcp_drm_dev_alloc in error path. Why involve adev =
device unplug? It is a different =
scenario.</span></p></div></div></blockquote>Hi =
xiaogang,</div><div>&nbsp; &nbsp; &nbsp;I didn=E2=80=99t get your point =
yet. Current work flow is:</div><div>amdgpu_pci_probe()</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-&gt; =
amdgpu_driver_load_kms()</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">		</span>-&gt; =
amdgpu_device_init()</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">			=
</span>-&gt;amdgpu_discovery_set_ip_blocks()</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
</span>-&gt; amdgpu_xcp_mgr_init()</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">				=
	</span>-&gt; amdgpu_xcp_alloc_dev()</div><div><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>-&gt; =
amdgpu_xcp_dev_register()</div><div>And amdgpu_xcp_dev_unplug() undos =
work done by amdgpu_xcp_dev_register() and part of =
amdgpu_xcp_mgr_ini().</div><div>How about splitting =
amdgpu_xcp_dev_unplug() into amdgpuxcp_dev_deregister() and =
amdgpu_xcp_mgr_fini(), then things should get much clear.</div><div>And =
it seems the xcp_mgr object is leaked current, and there are resource =
leakage on error handling path of =
amdgpu_pci_probe.&nbsp;</div><div>Above proposal may also help to fix =
those resource =
leakages.</div><div>Thanks,</div><div>Gerry</div><div><blockquote =
type=3D"cite" class=3D""><div class=3D""><div class=3D""><p =
class=3D""><span style=3D"white-space: pre-wrap" =
class=3D"">Regards</span></p><p class=3D""><span style=3D"white-space: =
pre-wrap" class=3D"">Xiaogang
</span></p>
    <blockquote type=3D"cite" =
cite=3D"mid:d097f02c25ff44fced59b10ac72587f304a6637f.1736044362.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre"> 		=
amdgpu_driver_unload_kms(dev);
+	}
=20
 	return r;
 }
</pre>
    </blockquote>
  </div>

</div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_B777BF54-AC9C-491B-ABD1-4DC379CBF2E5--
