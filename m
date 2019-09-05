From: zhong jiang <zhongjiang@huawei.com>
Subject: Re: drm/amdgpu: remove the redundant null check
Date: Thu, 5 Sep 2019 16:46:50 +0800
Message-ID: <5D70CB7A.8040307@huawei.com>
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com> <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com> <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 2019/9/5 16:38, Markus Elfring wrote:
>>> Were any source code analysis tools involved for finding
>>> these update candidates?
>> With the help of Coccinelle. You can find out some example in scripts/coccinelle/.
> Thanks for such background information.
> Was the script “ifnullfree.cocci” applied here?
Yep
> Will it be helpful to add attribution for such tools
> to any more descriptions in your patches?
Sometimes, I will add the description in my patches. Not always.

Thanks,
zhong jiang
> Regards,
> Markus
>
> .
>
