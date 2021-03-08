Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1D8C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64AD964FB7
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 14:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64AD964FB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898E66E3F4;
	Mon,  8 Mar 2021 14:39:01 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C7F6E858
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 12:15:00 +0000 (UTC)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DvHMw3qc5z9tysJ;
 Mon,  8 Mar 2021 13:14:52 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dEqMcPH0WQ-Z; Mon,  8 Mar 2021 13:14:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DvHMw2x4tz9tyrs;
 Mon,  8 Mar 2021 13:14:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B36388B7B3;
 Mon,  8 Mar 2021 13:14:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 2JHGHDJHPda4; Mon,  8 Mar 2021 13:14:57 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D2AE8B7B1;
 Mon,  8 Mar 2021 13:14:57 +0100 (CET)
Subject: Re: [PATCH v1 12/15] powerpc/uaccess: Refactor get/put_user() and
 __get/put_user()
To: kernel test robot <lkp@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Evgeniy Polyakov <zbr@ioremap.net>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>
References: <3c174edb80d2d37af6b08c637b09268f675e5371.1614275314.git.christophe.leroy@csgroup.eu>
 <202103071822.4cXbH0Xp-lkp@intel.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <bfb95917-2b84-59f2-7f22-22fd6d63d09a@csgroup.eu>
Date: Mon, 8 Mar 2021 13:14:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <202103071822.4cXbH0Xp-lkp@intel.com>
Content-Language: fr
X-Mailman-Approved-At: Mon, 08 Mar 2021 14:38:59 +0000
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

+Evgeniy for W1 Dallas
+Alex & Christian for RADEON

Le 07/03/2021 =E0 11:23, kernel test robot a =E9crit=A0:
> Hi Christophe,
> =

> I love your patch! Perhaps something to improve:
> =

> [auto build test WARNING on powerpc/next]
> [also build test WARNING on v5.12-rc2 next-20210305]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> =

> url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/powerpc=
-Cleanup-of-uaccess-h/20210226-015715
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git=
 next
> config: powerpc-randconfig-s031-20210307 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sb=
in/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-245-gacc5c298-dirty
>          # https://github.com/0day-ci/linux/commit/449bdbf978936e67e4919b=
e8be0eec3e490a65e2
>          git remote add linux-review https://github.com/0day-ci/linux
>          git fetch --no-tags linux-review Christophe-Leroy/powerpc-Cleanu=
p-of-uaccess-h/20210226-015715
>          git checkout 449bdbf978936e67e4919be8be0eec3e490a65e2
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cro=
ss C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=3Dpowerpc
> =

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>


The mentioned patch is not the source of the problem, it only allows to spo=
t it.

Christophe

> =

> =

> "sparse warnings: (new ones prefixed by >>)"
>>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type i=
n initializer (different address spaces) @@     expected char [noderef] __u=
ser *_pu_addr @@     got char *buf @@
>     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [nod=
eref] __user *_pu_addr
>     drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type i=
n initializer (different address spaces) @@     expected char const [nodere=
f] __user *_gu_addr @@     got char const *buf @@
>     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected char cons=
t [noderef] __user *_gu_addr
>     drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
> --
>     drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: cast remo=
ves address space '__user' of expression
>     drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: cast remo=
ves address space '__user' of expression
>>> drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: incorrect t=
ype in initializer (different address spaces) @@     expected unsigned int =
[noderef] __user *_pu_addr @@     got unsigned int [usertype] * @@
>     drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse:     expected unsi=
gned int [noderef] __user *_pu_addr
>     drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse:     got unsigned =
int [usertype] *
>     drivers/gpu/drm/radeon/radeon_ttm.c:933:21: sparse: sparse: cast remo=
ves address space '__user' of expression
> =

> vim +342 drivers/w1/slaves/w1_ds28e04.c
> =

> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  338
> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  339  static ssize_t crcchec=
k_show(struct device *dev, struct device_attribute *attr,
> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  340  			     char *buf)
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  341  {
> fbf7f7b4e2ae40 Markus Franke      2012-05-26 @342  	if (put_user(w1_enabl=
e_crccheck + 0x30, buf))
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  343  		return -EFAULT;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  344
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  345  	return sizeof(w1_enab=
le_crccheck);
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  346  }
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  347
> fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  348  static ssize_t crcchec=
k_store(struct device *dev, struct device_attribute *attr,
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  349  			      const char *b=
uf, size_t count)
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  350  {
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  351  	char val;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  352
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  353  	if (count !=3D 1 || !=
buf)
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  354  		return -EINVAL;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  355
> fbf7f7b4e2ae40 Markus Franke      2012-05-26 @356  	if (get_user(val, buf=
))
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  357  		return -EFAULT;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  358
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  359  	/* convert to decimal=
 */
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  360  	val =3D val - 0x30;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  361  	if (val !=3D 0 && val=
 !=3D 1)
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  362  		return -EINVAL;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  363
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  364  	/* set the new value =
*/
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  365  	w1_enable_crccheck =
=3D val;
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  366
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  367  	return sizeof(w1_enab=
le_crccheck);
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  368  }
> fbf7f7b4e2ae40 Markus Franke      2012-05-26  369
> =

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
