From: Jiri Pirko <jiri@mellanox.com>
Subject: Re: next build: 208 builds: 3 failed, 205 passed, 5 errors, 23
 warnings (next-20170215)
Date: Wed, 15 Feb 2017 10:50:02 +0100
Message-ID: <20170215095002.GF1992@nanopsycho>
References: <58a41194.828bdf0a.685a.3c15@mx.google.com>
 <CAK8P3a3XSBzVoM02sdehxDmrX3qM5NFqTgz2s2hyCqE203VzOw@mail.gmail.com>
 <20170215093807.GV24226@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20170215093807.GV24226@jhogan-linux.le.imgtec.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: James Hogan <james.hogan@imgtec.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "kernelci.org bot" <bot@kernelci.org>, kernel-build-reports@lists.linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org, Hauke Mehrtens <hauke@hauke-m.de>, Jamal Hadi Salim <jhs@mojatatu.com>, "David S. Miller" <davem@davemloft.net>
List-Id: amd-gfx.lists.freedesktop.org

Wed, Feb 15, 2017 at 10:38:07AM CET, james.hogan@imgtec.com wrote:
>On Wed, Feb 15, 2017 at 09:56:48AM +0100, Arnd Bergmann wrote:
>> On Wed, Feb 15, 2017 at 9:30 AM, kernelci.org bot <bot@kernelci.org> wrote:
>> > bcm47xx_defconfig (mips) — FAIL, 1 error, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > /home/buildslave/workspace/khilman-kbuilder/next/build-mips/../net/sched/sch_fq_codel.c:468:
>> > undefined reference to `tcf_destroy_chain'
>> 
>> I have not looked at this one yet, appears to be caused by commit
>> cf1facda2f61 ("sched: move tcf_proto_destroy and tcf_destroy_chain
>> helpers into cls_api")
>
>So effectively CONFIG_NET_SCH_FQ_CODEL (which bcm47xx_defconfig sets
>=y), and just over half of the other packet schedulers now implicitly
>depend on CONFIG_NET_CLS (which bcm47xx_defconfig doesn't set =y).
>
>Perhaps revert would be best since the change looks of questionable
>value to me, as all the users of it are in sch_*.c anyway.

Fixing this now.


>
>> > ip27_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: error: insn does not
>> > satisfy its constraints:
>> > drivers/net/ethernet/qlogic/qlge/qlge_main.c:4819:1: internal compiler
>> > error: in extract_constrain_insn, at recog.c:2190
>> 
>> broken gcc release, apparently fixed in gcc-7 (can't reproduce here at least).
>> I suggested a workaround, but got no reply so far:
>> 
>> http://www.spinics.net/lists/mips/msg66465.html
>
>I'll look into that.
>
>> 
>> > xway_defconfig (mips) — FAIL, 2 errors, 0 warnings, 0 section mismatches
>> >
>> > Errors:
>> > (.text+0x14e10): undefined reference to `physical_memsize'
>> > (.text+0x14e14): undefined reference to `physical_memsize'
>> 
>> Hauke already did a patch in December, but it has't made it into linux-mips
>> so far:
>> 
>> https://marc.info/?l=linux-mips&m=148612428414708&w=3
>
>Hauke: you mentioned sending a new version of this patch. I'll apply the
>original patch for now, as looking at the VPE loader, zero doesn't sound
>entirely unreasonable:
>
>/*
> * The sde-kit passes 'memsize' to __start in $a3, so set something
> * here...  Or set $a3 to zero and define DFLT_STACK_SIZE and
> * DFLT_HEAP_SIZE when you compile your program
> */
>mttgpr(6, v->ntcs);
>mttgpr(7, physical_memsize);
>
>Cheers
>James
