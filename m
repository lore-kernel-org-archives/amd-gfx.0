Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 18:51:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92E111A586;
	Thu, 19 May 2022 18:50:59 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD8EF10E093;
 Thu, 19 May 2022 18:44:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 5CFBACE270A;
 Thu, 19 May 2022 18:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20673C34100;
 Thu, 19 May 2022 18:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1652985851;
 bh=LV7LTnAH/p1rCGESk6oys94gfkqXoBT21ZKPBvHkVag=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=PJntBITtl+Ix70J0sB1XcPAphJMOsg4aFBWMHvc0SY2z73uU+bdYPDEbFBi+d1k76
 ysN5otvLvJDv0wXhWJUhkShJ6y0IswWrsq/4D0zNAN/gjfwPvXK6nuH5Fo5/HvjFsM
 DcteBtGl6sEhkNPBAN1XO2L3TUlpiYC03t69XjLY=
Date: Thu, 19 May 2022 11:44:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
Message-Id: <20220519114410.638baa38ab2067884600cb72@linux-foundation.org>
In-Reply-To: <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
 <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 19 May 2022 18:50:59 +0000
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
Cc: linux-hwmon@vger.kernel.org, linux-fbdev@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 kvm@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-nvme@lists.infradead.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, dri-devel@lists.freedesktop.org,
 linux-omap@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, 18 May 2022 20:41:27 -0700 Guenter Roeck <linux@roeck-us.net> wrote:

> On 5/18/22 17:55, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > branch HEAD: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3  Add linux-next specific files for 20220518
> > 
> > Error/Warning reports:
> > 
> > https://lore.kernel.org/linux-mm/202204291924.vTGZmerI-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205041248.WgCwPcEV-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205122113.uLKzd3SZ-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205172344.3GFeaum1-lkp@intel.com
> > https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com
> > 
> > Error/Warning: (recently discovered and may have been fixed)
> > 
> [ .. ]
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    unsigned char
> > drivers/hwmon/nct6775-platform.c:199:9: sparse:    void
> 
> This is getting tiresome. Every driver using outb() on m68k will
> experience that "problem". As far as I can see, it is caused by
> 
> #define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))
> 
> in arch/m68k/include/asm/raw_io.h. I have no idea what the
> "(void)" is for, but removing it "fixes" the problem.
> Either case, this is not a problem with the nct6775 driver,
> nor is it a new problem.

(cc Geert)
