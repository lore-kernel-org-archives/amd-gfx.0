From: John Fastabend <john.fastabend@gmail.com>
Subject: Re: kernel panic: stack is corrupted in pointer
Date: Wed, 24 Jul 2019 09:22:26 -0700
Message-ID: <5d3885c2e2e20_73c32aebc43b65c08@john-XPS-13-9370.notmuch>
References: <0000000000001a51c4058ddcb1b6@google.com>
 <CACT4Y+ZGwKP+f4esJdx60AywO9b3Y5Bxb4zLtH6EEkaHpP6Zag@mail.gmail.com>
 <5d37433a832d_3aba2ae4f6ec05bc3a@john-XPS-13-9370.notmuch>
 <CACT4Y+ZbPmRB9T9ZzhE79VnKKD3+ieHeLpaDGRkcQ72nADKH_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+ZbPmRB9T9ZzhE79VnKKD3+ieHeLpaDGRkcQ72nADKH_g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>, bpf <bpf@vger.kernel.org>, David Airlie <airlied@linux.ie>, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, Alexei Starovoitov <ast@kernel.org>, christian.koenig@amd.com, Daniel Borkmann <daniel@iogearbox.net>, david1.zhou@amd.com, DRI <dri-devel@lists.freedesktop.org>, leo.liu@amd.com, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Marco Elver <elver@google.com>
List-Id: amd-gfx.lists.freedesktop.org

Dmitry Vyukov wrote:
> On Tue, Jul 23, 2019 at 7:26 PM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Dmitry Vyukov wrote:
> > > On Wed, Jul 17, 2019 at 10:58 AM syzbot
> > > <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    1438cde7 Add linux-next specific files for 20190716
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13988058600000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=79f5f028005a77ecb6bb
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111fc8afa00000
> > >
> > > From the repro it looks like the same bpf stack overflow bug. +John
> > > We need to dup them onto some canonical report for this bug, or this
> > > becomes unmanageable.
> >
> > Fixes in bpf tree should fix this. Hopefully, we will squash this once fixes
> > percolate up.
> >
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> 
> Cool! What is the fix?

It took a series of patches here,

https://www.spinics.net/lists/netdev/msg586986.html

The fix commits from bpf tree are,

(git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git) 

318892ac068397f40ff81d9155898da01493b1d2
ac78fc148d8249dbf382c2127456dd08ec5b161c
f87e62d45e51b12d48d2cb46b5cde8f83b866bc4
313ab004805cf52a42673b15852b3842474ccd87
32857cf57f920cdc03b5095f08febec94cf9c36b
45a4521dcbd92e71c9e53031b40e34211d3b4feb
2bb90e5cc90e1d09f631aeab041a9cf913a5bbe5
0e858739c2d2eedeeac1d35bfa0ec3cc2a7190d8
95fa145479fbc0a0c1fd3274ceb42ec03c042a4a

The last commit fixes this paticular syzbot issue,

commit 95fa145479fbc0a0c1fd3274ceb42ec03c042a4a
Author: John Fastabend <john.fastabend@gmail.com>
Date:   Fri Jul 19 10:29:22 2019 -0700

    bpf: sockmap/tls, close can race with map free

The other commits address some other issues found while testing.

> We don't need to wait for the fix to percolate up (and then down
> too!). syzbot gracefully handles when a patch is not yet present
> everywhere (it happens all the time).

Great. By the way the above should fix many of the outstanding
reports against bpf sockmap and tls side. I'll have to walk through
each one individually to double check though. I guess we can mark
them as dup reports and syzbot should sort it out?

> 
> Btw, this was due to a stack overflow, right? Or something else?

Right, stack overflow due to race in updating sock ops where build a
circular call chain.

> We are trying to make KASAN configuration detect stack overflows too,
> so that it does not cause havoc next time. But it turns out to be
> non-trivial and our current attempt seems to fail:
> https://groups.google.com/forum/#!topic/kasan-dev/IhYv7QYhLfY
> 
> 
