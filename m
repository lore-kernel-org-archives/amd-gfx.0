Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74757C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC4B20775
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKD2H8mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC4B20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D606EB58;
	Fri, 20 Mar 2020 18:54:00 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70C896EB58
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 18:53:58 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id 26so3714526wmk.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=S74Ej443pekXYXLYSVBeN9MExo27Wyd06Um/vL7uga4=;
 b=pKD2H8moQ1laUrglhKoNQo+2ZW6GyPTFa/UwnREyp7gZyJ3qlVk1Wi6BzZAgYrZUW6
 w+c048xuDu/OYSvs7mFyTTDlCWVON5HExmY+X35gXKp4qrK6HgF61aeYHDhOaKNv8sTK
 ZrC9la2XuxAeOhl+dObzYLcJoXFUfPTBxhj2kuxA9wARQGI2Xk8YaUMj5JcYrHPEVV/r
 Wsk3rJdOvX/ZzGxI/FmZ6GlAqxzDtJcPWM8KY5d2F36X/d0jWBNA0+EJIyMMg1poykbE
 Wz9Y2iHfSP4FR5rh/GK9dcU8ZXOoyJwyk8dWsmAdA8od5ZCtPW/fMYEcaBT9uvQUWjxK
 d+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=S74Ej443pekXYXLYSVBeN9MExo27Wyd06Um/vL7uga4=;
 b=UP8kpiZPEbnboZVhGVsfftRHE03twyGxZNIfHzbUKjk91HDNZ7nGK+k92/NZrq8L6J
 ovs3sWikdjCHTnjoPPTou6DpZym0jL4q4eRmOsD33dJt+N+Mr1rZ4NNSjmuKobkHeQyh
 lVTZJF4lqUr4S8G/u6AgZjeDBQKFm0FUqZvmjupQ0qRJYwMH4h21fiSGp1DkmyY+mytI
 3ArciEQi8m7p+ZEpj7mkMhezHxt87hkcp2aSey7YRj7RU9/1DolwgJ+JRUYOeHlOyIjy
 b8zeFkFd1ur0FZUmAjjYJmRaeUBPSoBiIGotD24aH3zAtdDugly5Xd3iXcOlH11zkdpy
 9lyA==
X-Gm-Message-State: ANhLgQ2T2oOFluoCp3JP9l1DZBaFLve/x4sYhiv60huu+juakntAG7A7
 WILXtyh7F6jsEINahAj/DA+T/PQZ
X-Google-Smtp-Source: ADFU+vvXKydlvjuodUwKwo34PCGKBbZs+HcogEELx9YzZZuiSzLtIrlVBieGBA6qPnmoscsS0hpKQw==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr11053918wmc.150.1584730435341; 
 Fri, 20 Mar 2020 11:53:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id u5sm1648000wrp.81.2020.03.20.11.53.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Mar 2020 11:53:54 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring offsets
To: Felix Kuehling <felix.kuehling@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sierra Guiza, Alejandro (Alex)" <Alex.Sierra@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20200320002245.14932-1-alex.sierra@amd.com>
 <MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com>
 <50a79ebd-ab45-927b-a44d-dba313a72953@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <62ba8a76-3b5d-fce9-4853-3ebf7b27d09f@gmail.com>
Date: Fri, 20 Mar 2020 19:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <50a79ebd-ab45-927b-a44d-dba313a72953@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============1106349152=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1106349152==
Content-Type: multipart/alternative;
 boundary="------------1DB72E8DA77B4736406EE89E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1DB72E8DA77B4736406EE89E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.03.20 um 15:20 schrieb Felix Kuehling:
> On 2020-03-20 10:06, Deucher, Alexander wrote:
>>
>> [AMD Public Use]
>>
>>
>> This seems kind of complicated and error prone.  I didn't realize the 
>> extent to the changes required.  I think it would be better to either 
>> add arcturus specific versions of these functions or just go with 
>> your original approach and add a new arcturus_ih.c.  If you go with 
>> the second route however, no need to show all your intermediate 
>> steps, just add the new files in one commit.
>
> Hi Alex,
>
>
> I suggested the approach in this patch series since to minimize code 
> duplication and maintain readability of the code. I don't think it's 
> very error prone. I believe this is more maintainable than a separate 
> arcturus_ih.c. I'll have some more specific comments on Alejandro's 
> patches.
>

Question is rather if Arcturus has really the same OSS block than Vega10 
or if the registers are just the same and at a different offset?

If the later (which I suspect) than that should really be the same file.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Alex
>>
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>> Alex Sierra <alex.sierra@amd.com>
>> *Sent:* Thursday, March 19, 2020 8:22 PM
>> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Sierra Guiza, Alejandro (Alex) <Alex.Sierra@amd.com>
>> *Subject:* [PATCH 1/4] drm/amdgpu: add stride to calculate oss ring 
>> offsets
>> Arcturus and vega10 share the same vega10_ih, however both
>> have different register offsets at the ih ring section.
>> This variable is used to help calculate ih ring register addresses
>> from the osssys, that corresponds to the current asic type.
>>
>> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index 5ed4227f304b..fa384ae9a9bc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -279,6 +279,10 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>> amdgpu_hotplug_work_func);
>>          }
>>
>> +       if (adev->asic_type == CHIP_ARCTURUS)
>> +               adev->irq.ring_stride = 1;
>> +       else
>> +               adev->irq.ring_stride = 0;
>>          INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
>>          INIT_WORK(&adev->irq.ih2_work, amdgpu_irq_handle_ih2);
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> index c718e94a55c9..1ec5b735cd9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
>> @@ -97,6 +97,7 @@ struct amdgpu_irq {
>>          struct irq_domain               *domain; /* GPU irq 
>> controller domain */
>>          unsigned virq[AMDGPU_MAX_IRQ_SRC_ID];
>>          uint32_t srbm_soft_reset;
>> +       unsigned                        ring_stride;
>>  };
>>
>>  void amdgpu_irq_disable_all(struct amdgpu_device *adev);
>> -- 
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp;sdata=B%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;reserved=0< 
>> /a>
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0>
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0>
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0>
>>
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0> 
>>
>> _______________________________________________ amd-gfx mailing list   <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&reserved=0>amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1DB72E8DA77B4736406EE89E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 20.03.20 um 15:20 schrieb Felix
      Kuehling:<br>
    </div>
    <blockquote type="cite"
      cite="mid:50a79ebd-ab45-927b-a44d-dba313a72953@amd.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <div class="moz-cite-prefix">On 2020-03-20 10:06, Deucher,
        Alexander wrote:<br>
      </div>
      <blockquote type="cite"
cite="mid:MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com">
        <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
        <p
          style="font-family:Arial;font-size:10pt;color:#317100;margin:15pt;"
          align="Left"> [AMD Public Use]<br>
        </p>
        <br>
        <div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> This
            seems kind of complicated and error prone.  I didn't realize
            the extent to the changes required.  I think it would be
            better to either add arcturus specific versions of these
            functions or just go with your original approach and add a
            new arcturus_ih.c.  If you go with the second route however,
            no need to show all your intermediate steps, just add the
            new files in one commit.</div>
        </div>
      </blockquote>
      <p>Hi Alex,</p>
      <p><br>
      </p>
      <p>I suggested the approach in this patch series since to minimize
        code duplication and maintain readability of the code. I don't
        think it's very error prone. I believe this is more maintainable
        than a separate arcturus_ih.c. I'll have some more specific
        comments on Alejandro's patches.</p>
    </blockquote>
    <br>
    Question is rather if Arcturus has really the same OSS block than
    Vega10 or if the registers are just the same and at a different
    offset?<br>
    <br>
    If the later (which I suspect) than that should really be the same
    file.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:50a79ebd-ab45-927b-a44d-dba313a72953@amd.com">
      <p><br>
      </p>
      <p>Regards,<br>
          Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite"
cite="mid:MN2PR12MB4488EFB20868482AC55D3C14F7F50@MN2PR12MB4488.namprd12.prod.outlook.com">
        <div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> <br>
          </div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);"> Alex</div>
          <div style="font-family: Calibri, Arial, Helvetica,
            sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">   <br>
          </div>
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E"
                href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
              on behalf of Alex Sierra <a class="moz-txt-link-rfc2396E"
                href="mailto:alex.sierra@amd.com" moz-do-not-send="true">&lt;alex.sierra@amd.com&gt;</a><br>
              <b>Sent:</b> Thursday, March 19, 2020 8:22 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated"
                href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
              <a class="moz-txt-link-rfc2396E"
                href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Cc:</b> Sierra Guiza, Alejandro (Alex) <a
                class="moz-txt-link-rfc2396E"
                href="mailto:Alex.Sierra@amd.com" moz-do-not-send="true">&lt;Alex.Sierra@amd.com&gt;</a><br>
              <b>Subject:</b> [PATCH 1/4] drm/amdgpu: add stride to
              calculate oss ring offsets</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">Arcturus and vega10 share the
                  same vega10_ih, however both<br>
                  have different register offsets at the ih ring
                  section.<br>
                  This variable is used to help calculate ih ring
                  register addresses<br>
                  from the osssys, that corresponds to the current asic
                  type.<br>
                  <br>
                  Signed-off-by: Alex Sierra <a
                    class="moz-txt-link-rfc2396E"
                    href="mailto:alex.sierra@amd.com"
                    moz-do-not-send="true">&lt;alex.sierra@amd.com&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 4 ++++<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h | 1 +<br>
                   2 files changed, 5 insertions(+)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                  index 5ed4227f304b..fa384ae9a9bc 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<br>
                  @@ -279,6 +279,10 @@ int amdgpu_irq_init(struct
                  amdgpu_device *adev)<br>
                                                  
                  amdgpu_hotplug_work_func);<br>
                           }<br>
                   <br>
                  +       if (adev-&gt;asic_type == CHIP_ARCTURUS)<br>
                  +               adev-&gt;irq.ring_stride = 1;<br>
                  +       else<br>
                  +               adev-&gt;irq.ring_stride = 0;<br>
                           INIT_WORK(&amp;adev-&gt;irq.ih1_work,
                  amdgpu_irq_handle_ih1);<br>
                           INIT_WORK(&amp;adev-&gt;irq.ih2_work,
                  amdgpu_irq_handle_ih2);<br>
                   <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                  index c718e94a55c9..1ec5b735cd9e 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h<br>
                  @@ -97,6 +97,7 @@ struct amdgpu_irq {<br>
                           struct irq_domain               *domain; /*
                  GPU irq controller domain */<br>
                           unsigned                       
                  virq[AMDGPU_MAX_IRQ_SRC_ID];<br>
                           uint32_t                       
                  srbm_soft_reset;<br>
                  +       unsigned                        ring_stride;<br>
                   };<br>
                   <br>
                   void amdgpu_irq_disable_all(struct amdgpu_device
                  *adev);<br>
                  -- <br>
                  2.17.1<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated"
                    href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                  <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0"
originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb+ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr+uSoF6bz83ifpZaF1KhW4RGW4V+rHlh2VDoaZ45h4="
                    moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Calexander.deucher%40amd.com%7C17d5391c86ff4ceee12b08d7cc64f056%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637202606831789803&amp;amp;sdata=B%2BbtLEKN5A65OEp8se5m1M4aQGX7kxsqYYGTTukF5m8%3D&amp;amp;reserved=0&lt;
                    /a&gt;<br>
                  </a></div>
                <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0"
originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb+ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr+uSoF6bz83ifpZaF1KhW4RGW4V+rHlh2VDoaZ45h4="
                  moz-do-not-send="true"> </a></span></font></div>
          <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0"
originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb+ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr+uSoF6bz83ifpZaF1KhW4RGW4V+rHlh2VDoaZ45h4="
            moz-do-not-send="true"> </a></div>
        <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0"
originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb+ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr+uSoF6bz83ifpZaF1KhW4RGW4V+rHlh2VDoaZ45h4="
          moz-do-not-send="true"> <br>
          <fieldset class="mimeAttachmentHeader"></fieldset>
        </a>
        <pre class="moz-quote-pre" wrap=""><a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032276037&amp;sdata=bs%2F33P5feC0SRxcy6JyiVLkLG6uA7fSWQ4EeCmGItU0%3D&amp;reserved=0" originalsrc="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" shash="RpptISRMfKBBZP2h2HOxGfxgMoH70rCb+ynpCaxpjoQfUURByH8bfh2o5xfNNLXX/0W1br0JWtFqcIbbajPUmDwP09Xlet5BBf2vF6seIhDiQAhlTwrUgbF6br2BVN3Rfr+uSoF6bz83ifpZaF1KhW4RGW4V+rHlh2VDoaZ45h4=" moz-do-not-send="true">_______________________________________________
amd-gfx mailing list
</a><a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=02%7C01%7Cfelix.kuehling%40amd.com%7C7e44179e2a0d49c972ba08d7ccd7e626%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637203100032296023&amp;amp;sdata=bil9pUebulcGpl5YhTi9k6yqK8wYDzw6XN%2FSZ9YbR44%3D&amp;amp;reserved=0</a>
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

--------------1DB72E8DA77B4736406EE89E--

--===============1106349152==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1106349152==--
