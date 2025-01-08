Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8176E7719B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 09:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFEFE10E815;
	Wed,  8 Jan 2025 09:07:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="of8Dwzuj";
	dkim-atps=neutral
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A414B10E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 02:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736303390; h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To;
 bh=jCMykoSeOuGnmTHCOf+yIfJQFvKbYAqoGT67O1lYGws=;
 b=of8DwzujoJHR7OaQzWE7/58wxLujZ3A35VR25eFvbxNbWCox6CkDxbfaJutEtosQKBWVNdukX8KHixRAnt1MInYcZ5C1Nvtf2xWoeWQ/If768OMDfqVGjFGyPZG4a7B74oqOS2gdp0BXSFheYKFLYfCDwoFRDsC+oxd5IUlAK/g=
Received: from smtpclient.apple(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNCAHYt_1736303389 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 10:29:50 +0800
From: Gerry Liu <gerry@linux.alibaba.com>
Message-Id: <444D37B3-4AB5-4700-BE89-CE9AE942865D@linux.alibaba.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_2D98976B-2A47-46E7-B598-3A60C4F1B21B"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v2 1/6] amdgpu: fix possible resource leakage in
 kfd_cleanup_nodes()
Date: Wed, 8 Jan 2025 10:29:48 +0800
In-Reply-To: <995bdc6c-2051-400f-b717-38cbb645aa8b@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lijo.lazar@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>
References: <cover.1736044362.git.gerry@linux.alibaba.com>
 <70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@linux.alibaba.com>
 <995bdc6c-2051-400f-b717-38cbb645aa8b@amd.com>
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


--Apple-Mail=_2D98976B-2A47-46E7-B598-3A60C4F1B21B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> 2025=E5=B9=B41=E6=9C=888=E6=97=A5 06:53=EF=BC=8CChen, Xiaogang =
<xiaogang.chen@amd.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>=20
> On 1/4/2025 8:45 PM, Jiang Liu wrote:
>> Fix possible resource leakage on error recovery path in function
>> kgd2kfd_device_init().
>>=20
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com> =
<mailto:gerry@linux.alibaba.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index a29374c86405..fa5054940486 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -898,15 +898,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>  		if (kfd->adev->xcp_mgr)
>>  			kfd_setup_interrupt_bitmap(node, i);
>> =20
>> +		spin_lock_init(&node->watch_points_lock);
>> +
>> +		kfd->nodes[i] =3D node;
>> +
>>  		/* Initialize the KFD node */
>>  		if (kfd_init_node(node)) {
>>  			dev_err(kfd_device, "Error initializing KFD =
node\n");
>>  			goto node_init_error;
>>  		}
>> -
>> -		spin_lock_init(&node->watch_points_lock);
>> -
>> -		kfd->nodes[i] =3D node;
>>  	}
>> =20
>>  	svm_range_set_max_pages(kfd->adev);
>> @@ -921,6 +921,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>  	goto out;
>> =20
>>  node_init_error:
>> +	i++;
>>  node_alloc_error:
>>  	kfd_cleanup_nodes(kfd, i);
>>  	kfd_doorbell_fini(kfd);
> I think this change is not right: if kfd_init_node fail it does clean =
up for the kfd_node that it is initializing internally. =
kfd_cleanup_nodes does not need to clean up the kfd node i which failed =
to init, just clean up the kfd_nodes that were initialized previously.
>=20
Yes, I made a mistake here and will drop this patch in next version.

Thanks,
Gerry
> Regard
>=20
> Xiaogang
>=20


--Apple-Mail=_2D98976B-2A47-46E7-B598-3A60C4F1B21B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">2025=E5=B9=B41=E6=9C=888=E6=97=A5 06:53=EF=BC=8CChen, =
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
cite=3D"mid:70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre">Fix possible resource =
leakage on error recovery path in function
kgd2kfd_device_init().

Signed-off-by: Jiang Liu <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:gerry@linux.alibaba.com">&lt;gerry@linux.alibaba.com&gt;</a=
>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a29374c86405..fa5054940486 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -898,15 +898,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		if (kfd-&gt;adev-&gt;xcp_mgr)
 			kfd_setup_interrupt_bitmap(node, i);
=20
+		spin_lock_init(&amp;node-&gt;watch_points_lock);
+
+		kfd-&gt;nodes[i] =3D node;
+
 		/* Initialize the KFD node */
 		if (kfd_init_node(node)) {
 			dev_err(kfd_device, "Error initializing KFD =
node\n");
 			goto node_init_error;
 		}
-
-		spin_lock_init(&amp;node-&gt;watch_points_lock);
-
-		kfd-&gt;nodes[i] =3D node;
 	}
=20
 	svm_range_set_max_pages(kfd-&gt;adev);
@@ -921,6 +921,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	goto out;
=20
 node_init_error:
+	i++;
 node_alloc_error:
 	kfd_cleanup_nodes(kfd, i);
 	kfd_doorbell_fini(kfd);</pre>
    </blockquote><p class=3D"">I think this change is not right: if =
<span style=3D"white-space: pre-wrap" class=3D"">kfd_init_node</span> =
fail it does
      clean up for the kfd_node that it is initializing internally. =
<span style=3D"white-space: pre-wrap" class=3D"">kfd_cleanup_nodes</span> =
does not
      need to clean up the kfd node i which failed to init, just clean
      up the kfd_nodes that were initialized =
previously.</p></div></div></blockquote>Yes, I made a mistake here and =
will drop this patch in next version.</div><div><br =
class=3D""></div><div>Thanks,</div><div>Gerry<br class=3D""><blockquote =
type=3D"cite" class=3D""><div class=3D""><div class=3D""><p =
class=3D"">Regard</p><p class=3D"">Xiaogang<br class=3D"">
    </p>
    <blockquote type=3D"cite" =
cite=3D"mid:70f5963233c8a34354ec8a9efebc3a7b4c7940d4.1736044362.git.gerry@=
linux.alibaba.com" class=3D"">
      <pre wrap=3D"" class=3D"moz-quote-pre"></pre>
    </blockquote>
  </div>

</div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_2D98976B-2A47-46E7-B598-3A60C4F1B21B--
