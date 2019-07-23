From: John Fastabend <john.fastabend@gmail.com>
Subject: Re: Re: kernel panic: stack is corrupted in pointer
Date: Tue, 23 Jul 2019 10:33:51 -0700
Message-ID: <5d3744ff777cc_436d2adb6bf105c41c@john-XPS-13-9370.notmuch>
References: <5d37433a832d_3aba2ae4f6ec05bc3a@john-XPS-13-9370.notmuch>
 <0000000000002cec2e058e5c7e63@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000002cec2e058e5c7e63@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>
Cc: airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org, christian.koenig@amd.com, daniel@iogearbox.net, david1.zhou@amd.com, dri-devel@lists.freedesktop.org, dvyukov@google.com, john.fastabend@gmail.com, leo.liu@amd.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

syzbot wrote:
> > Dmitry Vyukov wrote:
> >> On Wed, Jul 17, 2019 at 10:58 AM syzbot
> >> <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com> wrote:
> >> >
> >> > Hello,
> >> >
> >> > syzbot found the following crash on:
> >> >
> >> > HEAD commit:    1438cde7 Add linux-next specific files for 20190716
> >> > git tree:       linux-next
> >> > console output:  
> >> https://syzkaller.appspot.com/x/log.txt?x=13988058600000
> >> > kernel config:   
> >> https://syzkaller.appspot.com/x/.config?x=3430a151e1452331
> >> > dashboard link:  
> >> https://syzkaller.appspot.com/bug?extid=79f5f028005a77ecb6bb
> >> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >> > syz repro:       
> >> https://syzkaller.appspot.com/x/repro.syz?x=111fc8afa00000
> 
> >>  From the repro it looks like the same bpf stack overflow bug. +John
> >> We need to dup them onto some canonical report for this bug, or this
> >> becomes unmanageable.
> 
> > Fixes in bpf tree should fix this. Hopefully, we will squash this once  
> > fixes
> > percolate up.
> 
> > #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git
> 
> ">" does not look like a valid git branch or commit.
> 

try again,

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git master
