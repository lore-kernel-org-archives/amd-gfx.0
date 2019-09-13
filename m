From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: drm/amdgpu: remove the redundant null check
Date: Fri, 13 Sep 2019 17:04:59 -0400
Message-ID: <CADnq5_MH5HnfihRTBRHnSWRzDj5nu_8w0TWf82-999nKCa4wDQ@mail.gmail.com>
References: <1567491305-18320-1-git-send-email-zhongjiang@huawei.com>
 <62b33279-9ca9-5970-5336-a8511ce54197@web.de> <5D70A196.3020106@huawei.com>
 <dd351754-cb3a-b19a-64e1-f2f583c2a23a@web.de> <5D70CB7A.8040307@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5D70CB7A.8040307@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhong jiang <zhongjiang@huawei.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Sep 6, 2019 at 3:01 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> On 2019/9/5 16:38, Markus Elfring wrote:
> >>> Were any source code analysis tools involved for finding
> >>> these update candidates?
> >> With the help of Coccinelle. You can find out some example in scripts/=
coccinelle/.
> > Thanks for such background information.
> > Was the script =E2=80=9Cifnullfree.cocci=E2=80=9D applied here?
> Yep
> > Will it be helpful to add attribution for such tools
> > to any more descriptions in your patches?
> Sometimes, I will add the description in my patches. Not always.

Applied with some minor tweaks to the commit message.

Thanks!

Alex

>
> Thanks,
> zhong jiang
> > Regards,
> > Markus
> >
> > .
> >
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
