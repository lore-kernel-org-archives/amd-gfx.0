From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: drm/amdgpu: remove the redundant null check
Date: Thu, 5 Sep 2019 10:38:48 +0200
Message-ID: <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
 <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5D70A196.3020106@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

>> Were any source code analysis tools involved for finding
>> these update candidates?
> With the help of Coccinelle. You can find out some example in scripts/co=
ccinelle/.

Thanks for such background information.
Was the script =E2=80=9Cifnullfree.cocci=E2=80=9D applied here?

Will it be helpful to add attribution for such tools
to any more descriptions in your patches?

Regards,
Markus
