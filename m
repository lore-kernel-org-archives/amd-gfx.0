Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024DCC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 23:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FDAF10E1A9;
	Mon,  6 Feb 2023 23:15:12 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Mon, 06 Feb 2023 23:15:09 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BCC10E1A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 23:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1675725308; bh=Z8Jj1SBT3YwXW9UPxHTdzy4KhmJWr2P4RAjnidDbliQ=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=ZQkKm5StYQh8BHKUnFYQ808tBaV4L94mkJuf00LA6ZXS1V3ZalH2kA21qMGT4xgI3
 dHGermjGRurLuJ9241VfQuv+ZZIpSvY0MFlaPP4haMiAR/S3zDjJKjLazNJy+PrDj/
 QHkrElujdjvsVR94LujTsAVln1K2y7KIIpi+2w8/aAo3iUHy8YmQj99/r/iHvvpSmJ
 viPIaqkjDpdURGBG4caWKrTBM9tTe0VTZsDmHBS1+o9F8dAhME6QqRDUW9lXwa7pGp
 kouDA7UHfi5spkOL2Gizqyxxoemg/B9HJEjJal3t3oJinC8853RWy87OdVaJ6G/Li6
 O1PWtnTEOyucw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.2.10] ([217.9.99.227]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6DWi-1pVmKW1VRQ-006iHU; Tue, 07
 Feb 2023 00:10:00 +0100
Message-ID: <4211e472-042e-a384-25ca-0a109004fb41@gmx.de>
Date: Tue, 7 Feb 2023 00:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: Use the TGID for trace_amdgpu_vm_update_ptes
Content-Language: en-US
To: Alex Deucher <Alexander.Deucher@amd.com>
References: <20230202162103.5811-1-friedrich.vock@gmx.de>
 <44330b41-b7a9-d82e-2614-e9fd291e356f@amd.com>
 <CADnq5_M--J7ERZqLML3SL56zj14RkSe7YVnDwv22nHtjyZJ1RQ@mail.gmail.com>
From: Friedrich Vock <friedrich.vock@gmx.de>
In-Reply-To: <CADnq5_M--J7ERZqLML3SL56zj14RkSe7YVnDwv22nHtjyZJ1RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y4Zf1a3U1hsEVc6ZoHVjxnK6LBURJGsUq8Zpiv6iM52CYLhmx8X
 qf+2oUOTg9XM2MBxJzI0Wpjit5QEe8pn5/9MXXDl7lsxbNU8/jakr7jIX9ahyy0AfHXT5Xa
 xah1GxoQyBYEsJ/pSQ6WkqT4I/KS+Bq5A7IQ3Gz4Oo6Af2T7tv8FWH3C6c8EduwGthBiXyV
 bk3yAguXAFlwdJTK0Fs8g==
UI-OutboundReport: notjunk:1;M01:P0:4p7yh9ugLQ8=;XfCVLP15yunkxWHlvhxOegb3mGp
 wLcow6OKEWw8bNBxQwA+vBSM8fQlkUnBdUT0kumoE8bEjcp81mDcRxQbOtumMH/CNgWQJhcTe
 1ts/VwO25SyfvsfKitMEXa+0A9llxaEW99UXPCF6sesQOs/W1paYP0RcyK5lQsJ7OxHE3AZm6
 /XmXOpq2exsbDuJRGaoMvl2TGvVxD9023ZmVbpz27cvEZfgjcNmhlWiECvBGiobil4rmcTIZB
 YwKZ6cTaKL6fW+Hzi4TlV7UaavigeeWbohLGNDHAM6WWbOss5YALmG7pzTW+84Hvv8rQT6TVy
 mHnQQh4JxVeOaxYw+9hndcu2sGxAuOFXYmYaw9cpsCjGCN762G5lmInBPO+AymK4ZaslZbgJB
 SIAhJKe0ex4LOQnos7NWAEjUixff9BANdXqJB5Tb/E8VdAcCAU5tHEvlde1B3vsy1vfGEIhlA
 IkKVFGaPl9Lw+IGTxOI8NxUbyaPLvGF7xJ6jrc4WBdVbDVRjKbjPI6EwLaXCcqleaMe1fOYeP
 VTkBzNc571Lou0uKdzqjBIAf3GRGrOeKuAO7yJZWjD9yHiQ1ysleZNWv0vCPrOJv5pYZxsHwE
 VcMVjuHEyzKtPjuNx4irf1r4R7jXCGxi3sfE3i1b4JCwucpQRCK8F5Os6TBKnGHM1Gz2PORDP
 KSHHzUIbNio1gEKrJAc3IjOxskODagsvL0DDtAY6QousOpH7jGMyxDa1eZ7SswmKMXI+HNwjn
 6LS5nueO/j+GN0uSV5vM40POnvFfxJCL5mNbsBMMIyMhemgXHZRrM+3d9omwhYvceW5QLEYCO
 LuMogD82TlMeGZjuOP0ARZ85a/sRUaG8Dx7t2HmW/jHPoHmduQamRaZ55N9zmr8NV3N7LYApo
 2tyNsWlLHhbpILQ/X23CSjnvLaDKHXF3gwxSEkythgoJRoX8wEBvAWcCFMhe9BTX4dc6WcpuH
 eNPrcYkNjWndi7+uWQgdMyZkoZM=
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

thanks for applying the patch!

Do you think it'd also be possible to backport it to previous kernel
versions or do you already plan to do that?
Since it is a one-liner bugfix it shouldn't be too hard to backport.

Thank you,
Friedrich Vock

On 06.02.23 21:26, Alex Deucher wrote:
> Applied.  Thanks!
>
> Alex
>
> On Mon, Feb 6, 2023 at 3:35 AM Christian K=C3=B6nig <christian.koenig@am=
d.com> wrote:
>>
>>
>> Am 02.02.23 um 17:21 schrieb Friedrich Vock:
>>> The pid field corresponds to the result of gettid() in userspace.
>>> However, userspace cannot reliably attribute PTE events to processes
>>> with just the thread id. This patch allows userspace to easily
>>> attribute PTE update events to specific processes by comparing this
>>> field with the result of getpid().
>>>
>>> For attributing events to specific threads, the thread id is also
>>> contained in the common fields of each trace event.
>>>
>>> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
>> Ah, yes that makes more sense. Reviewed-by: Christian K=C3=B6nig
>> <christian.koenig@amd.com>
>>
>> Alex do you pick this up or should I take care of it?
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vm_pt.c
>>> index b5f3bba851db..01e42bdd8e4e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>> @@ -974,7 +974,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_=
params *params,
>>>                        trace_amdgpu_vm_update_ptes(params, frag_start,=
 upd_end,
>>>                                                    min(nptes, 32u), ds=
t, incr,
>>>                                                    upd_flags,
>>> -                                                 vm->task_info.pid,
>>> +                                                 vm->task_info.tgid,
>>>                                                    vm->immediate.fence=
_context);
>>>                        amdgpu_vm_pte_update_flags(params, to_amdgpu_bo=
_vm(pt),
>>>                                                   cursor.level, pe_sta=
rt, dst,
>>> --
>>> 2.39.1
>>>
