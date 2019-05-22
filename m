From: syzbot <syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com>
Subject: Re: WARNING: locking bug in inet_autobind
Date: Tue, 21 May 2019 20:16:01 -0700
Message-ID: <0000000000008b645c058971629b@google.com>
References: <00000000000033a0120588fac894@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00000000000033a0120588fac894@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong.Zhao@amd.com, airlied@linux.ie, alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, ast@kernel.org, bpf@vger.kernel.org, christian.koenig@amd.com, daniel@ffwll.ch, daniel@iogearbox.net, davem@davemloft.net, david1.zhou@amd.com, dri-devel@lists.freedesktop.org, evan.quan@amd.com, felix.kuehling@amd.com, harry.wentland@amd.com, kafai@fb.com, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ozeng@amd.com, ray.huang@amd.com, rex.zhu@amd.com, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com, yong.zhao@amd.com, yoshfuji@linux-ipv6.org
List-Id: amd-gfx.lists.freedesktop.org

syzbot has bisected this bug to:

commit c0d9271ecbd891cdeb0fad1edcdd99ee717a655f
Author: Yong Zhao <Yong.Zhao@amd.com>
Date:   Fri Feb 1 23:36:21 2019 +0000

     drm/amdgpu: Delete user queue doorbell variables

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1433ece4a00000
start commit:   f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1633ece4a00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1233ece4a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163731f8a00000

Reported-by: syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com
Fixes: c0d9271ecbd8 ("drm/amdgpu: Delete user queue doorbell variables")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
