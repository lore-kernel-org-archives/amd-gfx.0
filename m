Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2AB61574
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2AB61574
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE6B689F49;
	Mon,  8 Mar 2021 14:43:28 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C1D89F49
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 14:43:28 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id mm21so20800923ejb.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Az8rhA9caHuo5zJCEYV8g7y4jULWEe6VaW1tk9jHX3I=;
 b=VNEcNxDgmlldA/u8di4huVxTlpa63PWMrv1nVVNhGIhelZ8P8KTUV7fB2hzpu2JE3L
 JR2nNA8A2rPTgt7Y7SHLNz36wk7715OF6V3QdYK1ynr1bpibEr2d2s0obXyasg2pViE4
 Y90OLyHBTliRuLh6i20zM+WckQYC6ADJexiAtBJF7QFrMZNV4vniXv0kP3lIinLsrmf7
 dkfZBqm9FUtnoK3l4G4wpC4ZrT06TML31imjHUZe53UU0aWfQVJ/VJskJXmrYYHDWDQU
 UL2I7iIpchwsyzl9tknM4XrRJH8B5zXEuJe0woH/m8++6yUQZWjaJBrHWwtvnEOgMVig
 tJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Az8rhA9caHuo5zJCEYV8g7y4jULWEe6VaW1tk9jHX3I=;
 b=Sq9BO4pG3gCsG/9hwxHORBIZX5W+KNdZGj/gsJcIAYlm4C4eYuNis6re7QY9IGmT9e
 Rqzy6TAuvilgRvt4XsJ87eW76dB1JUZZw0Cy6nkwHqseW9DzZbIDz1L54Sqs1U3ozoxf
 xW40nYt55xAh/lyGWPsp7DlHhNbItEyHbHegTjqJeLMG6UNPlB9koEQ9DCQYgVy0r2+u
 wg/C6YGZXVCXLZ+Wii8Xqbcq1XsLmB2VqEaCLnfKK3jE7z7DHgNr6uXml8XFfd6y+hpF
 +7GORKvNKwWvutdambk1KS2wZbcHLhIPm1s/lOXyc0IKi3DAXvvpeAkNpaw24Z3TmKvR
 VxrQ==
X-Gm-Message-State: AOAM533W/ZkSxnNzZiYwyx3auQxBIWkVzFMpXMIMOqGIHy2K/pxBbwnk
 MBjejonEydYoy6UI8nQkQzFPnwZvWtFwVQ==
X-Google-Smtp-Source: ABdhPJzLVFusCJGHsLRE2whpfSe3NJ3sQRGVskencktMChCB5X29IBCZfnhGe0pbrM61syySA7Jj2g==
X-Received: by 2002:a17:906:d787:: with SMTP id
 pj7mr14938160ejb.257.1615214606892; 
 Mon, 08 Mar 2021 06:43:26 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:4794:2f8d:7bcd:36a5?
 ([2a02:908:1252:fb60:4794:2f8d:7bcd:36a5])
 by smtp.gmail.com with ESMTPSA id d19sm7259446edr.45.2021.03.08.06.43.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Mar 2021 06:43:26 -0800 (PST)
Subject: Re: [PATCH v1 12/15] powerpc/uaccess: Refactor get/put_user() and
 __get/put_user()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel test robot <lkp@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Evgeniy Polyakov <zbr@ioremap.net>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <3c174edb80d2d37af6b08c637b09268f675e5371.1614275314.git.christophe.leroy@csgroup.eu>
 <202103071822.4cXbH0Xp-lkp@intel.com>
 <bfb95917-2b84-59f2-7f22-22fd6d63d09a@csgroup.eu>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b282b744-ea10-aedf-da10-832af7565f24@gmail.com>
Date: Mon, 8 Mar 2021 15:43:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <bfb95917-2b84-59f2-7f22-22fd6d63d09a@csgroup.eu>
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
Cc: linuxppc-dev@lists.ozlabs.org, kbuild-all@01.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The radeon warning is trivial to fix, going to send out a patch in a few =

moments.

Regards,
Christian.

Am 08.03.21 um 13:14 schrieb Christophe Leroy:
> +Evgeniy for W1 Dallas
> +Alex & Christian for RADEON
>
> Le 07/03/2021 =E0 11:23, kernel test robot a =E9crit=A0:
>> Hi Christophe,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on powerpc/next]
>> [also build test WARNING on v5.12-rc2 next-20210305]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url: =

>> https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc-Cleanu=
p-of-uaccess-h/20210226-015715
>> base: =

>> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
>> config: powerpc-randconfig-s031-20210307 (attached as .config)
>> compiler: powerpc-linux-gcc (GCC) 9.3.0
>> reproduce:
>> =A0=A0=A0=A0=A0=A0=A0=A0 wget =

>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross =

>> -O ~/bin/make.cross
>> =A0=A0=A0=A0=A0=A0=A0=A0 chmod +x ~/bin/make.cross
>> =A0=A0=A0=A0=A0=A0=A0=A0 # apt-get install sparse
>> =A0=A0=A0=A0=A0=A0=A0=A0 # sparse version: v0.6.3-245-gacc5c298-dirty
>> =A0=A0=A0=A0=A0=A0=A0=A0 # =

>> https://github.com/0day-ci/linux/commit/449bdbf978936e67e4919be8be0eec3e=
490a65e2
>> =A0=A0=A0=A0=A0=A0=A0=A0 git remote add linux-review https://github.com/=
0day-ci/linux
>> =A0=A0=A0=A0=A0=A0=A0=A0 git fetch --no-tags linux-review =

>> Christophe-Leroy/powerpc-Cleanup-of-uaccess-h/20210226-015715
>> =A0=A0=A0=A0=A0=A0=A0=A0 git checkout 449bdbf978936e67e4919be8be0eec3e49=
0a65e2
>> =A0=A0=A0=A0=A0=A0=A0=A0 # save the attached .config to linux build tree
>> =A0=A0=A0=A0=A0=A0=A0=A0 COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dg=
cc-9.3.0 =

>> make.cross C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dpo=
werpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>
>
> The mentioned patch is not the source of the problem, it only allows =

> to spot it.
>
> Christophe
>
>>
>>
>> "sparse warnings: (new ones prefixed by >>)"
>>>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect =

>>>> type in initializer (different address spaces) @@=A0=A0=A0=A0 expected=
 char =

>>>> [noderef] __user *_pu_addr @@=A0=A0=A0=A0 got char *buf @@
>> =A0=A0=A0 drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:=A0=A0=A0=A0 exp=
ected char =

>> [noderef] __user *_pu_addr
>> =A0=A0=A0 drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:=A0=A0=A0=A0 got=
 char *buf
>>>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect =

>>>> type in initializer (different address spaces) @@=A0=A0=A0=A0 expected=
 char =

>>>> const [noderef] __user *_gu_addr @@=A0=A0=A0=A0 got char const *buf @@
>> =A0=A0=A0 drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:=A0=A0=A0=A0 exp=
ected char =

>> const [noderef] __user *_gu_addr
>> =A0=A0=A0 drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:=A0=A0=A0=A0 got=
 char const =

>> *buf
>> -- =

>> =A0=A0=A0 drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: ca=
st =

>> removes address space '__user' of expression
>> =A0=A0=A0 drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: ca=
st =

>> removes address space '__user' of expression
>>>> drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: =

>>>> incorrect type in initializer (different address spaces) @@=A0=A0=A0=
=A0 =

>>>> expected unsigned int [noderef] __user *_pu_addr @@=A0=A0=A0=A0 got =

>>>> unsigned int [usertype] * @@
>> =A0=A0=A0 drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: expected =

>> unsigned int [noderef] __user *_pu_addr
>> =A0=A0=A0 drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse:=A0=A0=A0=
=A0 got =

>> unsigned int [usertype] *
>> =A0=A0=A0 drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: ca=
st =

>> removes address space '__user' of expression
>>
>> vim +342 drivers/w1/slaves/w1_ds28e04.c
>>
>> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21=A0 338
>> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21=A0 339=A0 static ssize_t =

>> crccheck_show(struct device *dev, struct device_attribute *attr,
>> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21 340=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =

>> char *buf)
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 341=A0 {
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26 @342=A0=A0=A0=A0=
=A0 if =

>> (put_user(w1_enable_crccheck + 0x30, buf))
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 343 return -EF=
AULT;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 344
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 345=A0=A0=A0=
=A0=A0 return =

>> sizeof(w1_enable_crccheck);
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 346=A0 }
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 347
>> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21=A0 348=A0 static ssize_t =

>> crccheck_store(struct device *dev, struct device_attribute *attr,
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26 349=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =

>> const char *buf, size_t count)
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 350=A0 {
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 351=A0=A0=A0=
=A0=A0 char val;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 352
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 353=A0=A0=A0=
=A0=A0 if (count !=3D 1 =

>> || !buf)
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 354 return -EI=
NVAL;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 355
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26 @356=A0=A0=A0=A0=
=A0 if =

>> (get_user(val, buf))
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 357 return -EF=
AULT;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 358
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 359=A0=A0=A0=
=A0=A0 /* convert to =

>> decimal */
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 360=A0=A0=A0=
=A0=A0 val =3D val - 0x30;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 361=A0=A0=A0=
=A0=A0 if (val !=3D 0 =

>> && val !=3D 1)
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 362 return -EI=
NVAL;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 363
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 364=A0=A0=A0=
=A0=A0 /* set the new =

>> value */
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 365 w1_enable_=
crccheck =

>> =3D val;
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 366
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 367=A0=A0=A0=
=A0=A0 return =

>> sizeof(w1_enable_crccheck);
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 368=A0 }
>> fbf7f7b4e2ae40 Markus Franke=A0=A0=A0=A0=A0 2012-05-26=A0 369
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
