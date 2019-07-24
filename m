From: syzbot <syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com>
Subject: Re: kernel panic: stack is corrupted in pointer
Date: Tue, 23 Jul 2019 18:40:01 -0700
Message-ID: <000000000000384ae4058e636360@google.com>
References: <5d3744ff777cc_436d2adb6bf105c41c@john-XPS-13-9370.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5d3744ff777cc_436d2adb6bf105c41c@john-XPS-13-9370.notmuch>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org, christian.koenig@amd.com, daniel@iogearbox.net, david1.zhou@amd.com, dri-devel@lists.freedesktop.org, dvyukov@google.com, john.fastabend@gmail.com, leo.liu@amd.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+79f5f028005a77ecb6bb@syzkaller.appspotmail.com

Tested on:

commit:         decb705e libbpf: fix using uninitialized ioctl results
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=87305c3ca9c25c70
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
