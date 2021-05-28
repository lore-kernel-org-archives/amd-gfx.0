Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48641C2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91B9610CE
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:23:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91B9610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2626E842;
	Fri, 28 May 2021 15:23:09 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E448B6E842
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 15:23:08 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id s22so5869499ejv.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 08:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=AGtOQ9lZMZbX8Ah5EZcKnlPz5vQxszW1EilHFo7oTBs=;
 b=TZkk07uo9A6jagV5zF7ggkG2v58CXiQL+vtjC3Hb9Lto/XgyalcAsuFOHxK/NV1tN+
 ipY2+fqmQ+8kqHZiEJ97tEOCF/v6LbEbGdugfbfMS+AEFGpTwKo4jfcQ27Hcqvo/qsRB
 4oCsvOl8yvgwP8xiSiiw7f5XC7L2xphmC+VR7blPPLnggYFmR7X84TkCcdz/TNL3iIl3
 fhzN2RqO50707pMTbwNk2Jm0psWU/TxjQ86uMxi3sdUeHPf2vyWf291QNEvt9+mHaGuZ
 Zs1Q/M3YvZCe0tmcUo/485e24jnHSLuRNx4WzU7nUcrfo03awdY0J0SQ95/Or8tkT+5d
 SA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=AGtOQ9lZMZbX8Ah5EZcKnlPz5vQxszW1EilHFo7oTBs=;
 b=T4HD3G29jRoRCwmg+dQ2tL1xyuHCgXtpT3NyNnxztJ4jCg8hADF3jrRBZmvawBwuZR
 bkS5HHxibRf7r6eJbSwKd6dF7X+pblYCeQYuS2ccUSeW2JKDsaE3bWfIETF8W6z05E1w
 EnaghoWchAOUGhOaoq2i587VQj3aw29VrImhrjCjRa4M4+UCIwBMuSenIzaWIGfAeqhh
 NP6jnJXYohbUBWWEg78Q4nuiOEVaGL96aR38TJhQ2jDm9roTy3cdOH4otGWPwJh2B7/t
 t7/YqFIuL5f+NDvjet2UjUEAV0uFQeVPii25C8sC9VfyngOf8oPDw6B/3h4TRN0cRW5R
 08Vg==
X-Gm-Message-State: AOAM531MoRLRGMX/5rdc9wX05tZMWV3kjhgCM4COJudyL6Y/DoQe6R4J
 LIG0sj1kXQpXJEUW0T/p1EyX5PKRxoA=
X-Google-Smtp-Source: ABdhPJwVc2+IsC62g0OSno1+jkiUv0GLh5LIja/FYeNwR9feJcuHKxHDMPU/u2GslXo1QHQ2Sh4ZUw==
X-Received: by 2002:a17:906:fc4:: with SMTP id
 c4mr10014026ejk.111.1622215387566; 
 Fri, 28 May 2021 08:23:07 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:a878:922a:f147:ebc?
 ([2a02:908:1252:fb60:a878:922a:f147:ebc])
 by smtp.gmail.com with ESMTPSA id s7sm2501025eja.75.2021.05.28.08.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 May 2021 08:23:06 -0700 (PDT)
Subject: Re: [PATCH] drm/amdkfd: move flushing TLBs from map to unmap
To: philip yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <fab1b78c-d6a9-2c23-368c-9cb1999e3aa8@amd.com>
 <b19402db-5b60-2cc2-991b-87c6190ac630@amd.com>
 <236a115f-7209-37ea-277a-ec86ec57f9ce@amd.com>
 <80a52ee7-0a94-0861-128e-ab23d209987e@amd.com>
 <9a71e303-f582-f658-f62c-dcda29c182d3@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <58d8ea74-9e74-540e-4845-55ac88746693@gmail.com>
Date: Fri, 28 May 2021 17:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9a71e303-f582-f658-f62c-dcda29c182d3@amd.com>
Content-Language: en-US
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
Content-Type: multipart/mixed; boundary="===============1608602917=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1608602917==
Content-Type: multipart/alternative;
 boundary="------------95F88C2EAD0298093E7BAD88"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------95F88C2EAD0298093E7BAD88
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 27.05.21 um 16:05 schrieb philip yang:
>
>
> On 2021-05-26 5:25 p.m., Felix Kuehling wrote:
>> Am 2021-05-26 um 3:21 p.m. schrieb Eric Huang:
>>> On 2021-05-25 3:16 p.m., Felix Kuehling wrote:
>>>> Similar to a recent fix by Philip Yang 76e08b37d0aa ("drm/amdgpu: flush
>>>> TLB if valid PDE turns into PTE"), there needs to be a conditional TLB
>>>> flush after map, if any PDEs were unmapped and turned into PTEs in the
>>>> process. This is currently returned by amdgpu_vm_bo_update_mapping in
>>>> the "table_freed" parameter. This needs to be also returned by
>>>> amdgpu_vm_bo_update and reported back to KFD, so KFD can do the TLB
>>>> flush after map, if needed.
>>> I follow up your suggestion to create another patch (attached) and
>>> test it. It seems it doesn't improve the latency when memory size is
>>> bigger than huge page (2M), because table_freed parameter will always
>>> be true when mapping page is huge page size. I think Philip's patch is
>>> to fix the case of remapping memory from small page to huge page in
>>> HMM, but it doesn't consider if the memory is remapped and arbitrarily
>>> flushes TLBs when mapping huge page.
>> That's unexpected. Turning an invalid PDE into a valid (huge) PTE should
>> not trigger a TLB flush.
>
> table_freed will be true if PDE has been used by previous mapping, 
> unmap the previous mapping will clear the PTEs, leave PDE unchanged as 
> P=0, V=1 (in memory and TLB), then huge page mapping turns PDE to PTE 
> (P=1, V=1) in memory, and free PTE page.
>

I think there might be a little bug in your patch. See we set 
params.table_freed to true when we call amdgpu_vm_free_pts(), but 
amdgpu_vm_free_pts() doesn't necessary frees anything.

It can be that all subsequent page tables where never allocated before.

Christian.

> For example, test map 0x7ffe37401000, unmap it, and then map 
> 0x7ffe3740000 2MB huge page, table_freed will be true, means that 
> flush TLB is needed after mapping huge page.
>
> You can change the test, don't unmap previous mapping, then 2MB huge 
> page will get new GPU virtual address, or closeKFD, openKFD again to 
> create new GPU vm.
>
> Regards,
>
> Philip
>
>> Regards,
>>    Felix
>>
>>
>>>> kfd_flush_tlb probably needs a new parameter to determine the flush
>>>> type. The flush after map can be a "legacy" flush (type 0). The flush
>>>> after unmap must be a "heavy-weight" flush (type 2) to make sure we
>>>> don't evict cache lines into pages that we no longer own.
>>>>
>>>> Finally, in the ticket I thought about possible optimizations using a
>>>> worker to minimize the impact of TLB flushes on unmap latency. That
>>>> could be a follow up commit.
>>> It is a good idea to use worker, but how do we grantee it done before
>>> memory is remapped? if remapping depends on it, then more latency will
>>> be introduced in map.
>>>
>>> Regards,
>>> Eric
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>> Am 2021-05-25 um 1:53 p.m. schrieb Eric Huang:
>>>>> It it to optimize memory allocation latency.
>>>>>
>>>>> Signed-off-by: Eric Huang<jinhuieric.huang@amd.com>
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> index 960913a35ee4..ab73741edb97 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>> @@ -1657,20 +1657,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct
>>>>> file *filep,
>>>>>                   goto sync_memory_failed;
>>>>>           }
>>>>>
>>>>> -       /* Flush TLBs after waiting for the page table updates to
>>>>> complete */
>>>>> -       for (i = 0; i < args->n_devices; i++) {
>>>>> -               peer = kfd_device_by_id(devices_arr[i]);
>>>>> -               if (WARN_ON_ONCE(!peer))
>>>>> -                       continue;
>>>>> -               peer_pdd = kfd_get_process_device_data(peer, p);
>>>>> -               if (WARN_ON_ONCE(!peer_pdd))
>>>>> -                       continue;
>>>>> -               if (!amdgpu_read_lock(peer->ddev, true)) {
>>>>> -                       kfd_flush_tlb(peer_pdd);
>>>>> -                       amdgpu_read_unlock(peer->ddev);
>>>>> -               }
>>>>> -       }
>>>>> -
>>>>>           kfree(devices_arr);
>>>>>
>>>>>           trace_kfd_map_memory_to_gpu_end(p,
>>>>> @@ -1766,6 +1752,7 @@ static int
>>>>> kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>>>>>                           amdgpu_read_unlock(peer->ddev);
>>>>>                           goto unmap_memory_from_gpu_failed;
>>>>>                   }
>>>>> +               kfd_flush_tlb(peer_pdd);
>>>>>                   amdgpu_read_unlock(peer->ddev);
>>>>>                   args->n_success = i+1;
>>>>>           }
>>>>> _______________________________________________
>>>>> amd-gfx mailing list
>>>>> amd-gfx@lists.freedesktop.org
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;reserved=0
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------95F88C2EAD0298093E7BAD88
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 27.05.21 um 16:05 schrieb philip
      yang:<br>
    </div>
    <blockquote type="cite"
      cite="mid:9a71e303-f582-f658-f62c-dcda29c182d3@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2021-05-26 5:25 p.m., Felix
        Kuehling wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:80a52ee7-0a94-0861-128e-ab23d209987e@amd.com">
        <pre class="moz-quote-pre" wrap="">Am 2021-05-26 um 3:21 p.m. schrieb Eric Huang:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 2021-05-25 3:16 p.m., Felix Kuehling wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Similar to a recent fix by Philip Yang 76e08b37d0aa ("drm/amdgpu: flush
TLB if valid PDE turns into PTE"), there needs to be a conditional TLB
flush after map, if any PDEs were unmapped and turned into PTEs in the
process. This is currently returned by amdgpu_vm_bo_update_mapping in
the "table_freed" parameter. This needs to be also returned by
amdgpu_vm_bo_update and reported back to KFD, so KFD can do the TLB
flush after map, if needed.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I follow up your suggestion to create another patch (attached) and
test it. It seems it doesn't improve the latency when memory size is
bigger than huge page (2M), because table_freed parameter will always
be true when mapping page is huge page size. I think Philip's patch is
to fix the case of remapping memory from small page to huge page in
HMM, but it doesn't consider if the memory is remapped and arbitrarily
flushes TLBs when mapping huge page.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">That's unexpected. Turning an invalid PDE into a valid (huge) PTE should
not trigger a TLB flush.</pre>
      </blockquote>
      <p>table_freed will be true if PDE has been used by previous
        mapping, unmap the previous mapping will clear the PTEs, leave
        PDE unchanged as P=0, V=1 (in memory and TLB), then huge page
        mapping turns PDE to PTE (P=1, V=1) in memory, and free PTE
        page.</p>
    </blockquote>
    <br>
    I think there might be a little bug in your patch. See we set
    params.table_freed to true when we call amdgpu_vm_free_pts(), but
    amdgpu_vm_free_pts() doesn't necessary frees anything.<br>
    <br>
    It can be that all subsequent page tables where never allocated
    before.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:9a71e303-f582-f658-f62c-dcda29c182d3@amd.com">
      <p>For example, test map 0x7ffe37401000, unmap it, and then map
        0x7ffe3740000 2MB huge page, table_freed will be true, means
        that flush TLB is needed after mapping huge page.</p>
      <p>You can change the test, don't unmap previous mapping, then 2MB
        huge page will get new GPU virtual address, or closeKFD, openKFD
        again to create new GPU vm.</p>
      <p>Regards,</p>
      <p>Philip<br>
      </p>
      <blockquote type="cite"
        cite="mid:80a52ee7-0a94-0861-128e-ab23d209987e@amd.com">
        <pre class="moz-quote-pre" wrap="">Regards,
  Felix


</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">kfd_flush_tlb probably needs a new parameter to determine the flush
type. The flush after map can be a "legacy" flush (type 0). The flush
after unmap must be a "heavy-weight" flush (type 2) to make sure we
don't evict cache lines into pages that we no longer own.

Finally, in the ticket I thought about possible optimizations using a
worker to minimize the impact of TLB flushes on unmap latency. That
could be a follow up commit.
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">It is a good idea to use worker, but how do we grantee it done before
memory is remapped? if remapping depends on it, then more latency will
be introduced in map.

Regards,
Eric
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">Regards,
   Felix


Am 2021-05-25 um 1:53 p.m. schrieb Eric Huang:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">It it to optimize memory allocation latency.

Signed-off-by: Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang@amd.com" moz-do-not-send="true">&lt;jinhuieric.huang@amd.com&gt;</a>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..ab73741edb97 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1657,20 +1657,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct
file *filep,
                 goto sync_memory_failed;
         }

-       /* Flush TLBs after waiting for the page table updates to
complete */
-       for (i = 0; i &lt; args-&gt;n_devices; i++) {
-               peer = kfd_device_by_id(devices_arr[i]);
-               if (WARN_ON_ONCE(!peer))
-                       continue;
-               peer_pdd = kfd_get_process_device_data(peer, p);
-               if (WARN_ON_ONCE(!peer_pdd))
-                       continue;
-               if (!amdgpu_read_lock(peer-&gt;ddev, true)) {
-                       kfd_flush_tlb(peer_pdd);
-                       amdgpu_read_unlock(peer-&gt;ddev);
-               }
-       }
-
         kfree(devices_arr);

         trace_kfd_map_memory_to_gpu_end(p,
@@ -1766,6 +1752,7 @@ static int
kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
                         amdgpu_read_unlock(peer-&gt;ddev);
                         goto unmap_memory_from_gpu_failed;
                 }
+               kfd_flush_tlb(peer_pdd);
                 amdgpu_read_unlock(peer-&gt;ddev);
                 args-&gt;n_success = i+1;
         }
_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0</a>
</pre>
            </blockquote>
          </blockquote>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cphilip.yang%40amd.com%7C92ac3fbce9264fbcf40508d9208cc477%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637576611241705305%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=S8NSZRdXq%2B74tSSLkm2TYEVDr%2Fr%2BW%2FET7CJln7tbEQo%3D&amp;amp;reserved=0</a>
</pre>
      </blockquote>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------95F88C2EAD0298093E7BAD88--

--===============1608602917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1608602917==--
