Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C186FC54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 06:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5737B10E1D8;
	Fri, 13 Jan 2023 06:02:12 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B91F010E1D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:02:09 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 bi26-20020a05600c3d9a00b003d3404a89faso230666wmb.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 22:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x8R866yQt51YUiei5A6DEugeaJxwDMBUbSrneNSHkX4=;
 b=IZ8DRRQeW01aUUHGROueMCsJTNP7I9o+ShpHpU3ou26oZGnBnZwSZRn7zwHL6/qxsG
 H/9SBMCh+WATiUn+HrSMl0FOFPnEH71DDabfTBp9sqUoGEsKd6QjBZQhM54ImwTSzXvQ
 3WcWz/W/s/tWbhFJJ2vI4AzS6Q4kZa8Vc+zsfOeMpP9iGEE95tQYVYJQ9vNSJx+8CPZY
 S+XqJUglT9hNNcFl0lIjQZkEedvc4+shEr1EBGrXjtyZmoomFXVg6m7HoWogSmnfBQ+t
 9VStnEqYEApdTcHka7YiaqKFpHi7Q77VhiehTi90H/+VKggl65WUWaPtYYBsKyByAcbG
 vYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x8R866yQt51YUiei5A6DEugeaJxwDMBUbSrneNSHkX4=;
 b=veAL7whIM3DRVlGEw2Zr6W+AM6e4ybuQw0ewQhDKeG/NUS353CdjTlPhyWe8w4GuYz
 IHqb2qchsJE8dX/CuV8yxmi5WUI7YsAMFLmgqtG8UOxxtqbE23uIE5SqvsivZUnoVekd
 wyiEmKvUwKirjMLAEEszz2O0fpjWtbzdvF2lA6LAeKlUTH3ZAZqEFS8iPxWj7D7ZN2JX
 7/1uYlmFD8LVg/5lo8vPwDyp3vS8vPbtYVpZRhPIpQXgygdYa5F+CyrKsbqLqqtAO4vT
 oa7zdEOkC+Ccv+Sva+4NGA8eRxt9GDsOAT2iCfJtH2n30apl3yhg9jQFI5DEVXK9gC2j
 +DJg==
X-Gm-Message-State: AFqh2kpIXj8uBX7aOX75Y/uUtx+kXxzUuw7pwo8QR0w/3boSoKN7sD3I
 /zMYJwCl4MGzE0G1/5t+IrixLoYFPuGiqLsRiPQ=
X-Google-Smtp-Source: AMrXdXudVE8CsDDRmGdGSeN1kQo3RQwjOpf+IqFbYs2Y7JgK9Qx/cnJO1J55WAO8pSkx2sCi7/EpkT1ogPES8nQ1Csk=
X-Received: by 2002:a05:600c:4688:b0:3da:1c49:d630 with SMTP id
 p8-20020a05600c468800b003da1c49d630mr279844wmo.190.1673589727926; Thu, 12 Jan
 2023 22:02:07 -0800 (PST)
MIME-Version: 1.0
References: <CANiD2e9bdhxdJr_N9wb7O0Su+LRhzE1n=TepvbBiOoqmKRRgeg@mail.gmail.com>
 <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Yury Zhuravlev <stalkerg@gmail.com>
Date: Fri, 13 Jan 2023 15:01:50 +0900
Message-ID: <CANiD2e-JebLZGvc0tSis=062t+=vPBVr_50=wm76G0Vu8nwnbg@mail.gmail.com>
Subject: Re: Wrong revert commit in stable channel
To: "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: multipart/alternative; boundary="0000000000003b9f0305f21ef97f"
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000003b9f0305f21ef97f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this is right in 6.2-rc3

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit
/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35ce=
3369b1418ebae0e657cda6a


But somebody reverted it again for the stable stream:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=
=3Dv6.1.4&id=3D9ccd11718d76b95c69aa773f2abedef560776037

On Wed, Jan 11, 2023 at 5:35 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:

> Hi Yury,
>
>
>
> My understanding is though that=E2=80=99s a revert of your original patch=
, we did
> a revert again on top of the reverted patch later on. Can you please sync
> to below commit to check again? Or do I understand wrong?
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35ce=
3369b1418ebae0e657cda6a
>
>
>
> Regards,
>
> Guchun
>
>
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of *Yu=
ry
> Zhuravlev
> *Sent:* Wednesday, January 11, 2023 4:26 PM
> *To:* amd-gfx@lists.freedesktop.org
> *Subject:* Wrong revert commit in stable channel
>
>
>
> Hello,
>
>
>
> Something went wrong, and we commited what we diced not commit.
>
>
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv6.2-rc3&id=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcomm=
it%2F%3Fh%3Dv6.2-rc3%26id%3De5b781c56d46c44c52caa915f1b65064f2f7c1ba&data=
=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399d97a2624b5bc46e08daf3ad88a1%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090223898249455%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000%7C%7C%7C&sdata=3D%2FkLymTjCMQ3uC669%2BWNXePiZ9ysaAGdvm7gFw5kIGeQ%3D&=
reserved=3D0>
>
>
>
> and
>
>
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?h=3Dv6.2-rc3&id=3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7
> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.=
kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcomm=
it%2F%3Fh%3Dv6.2-rc3%26id%3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7&data=
=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399d97a2624b5bc46e08daf3ad88a1%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C638090223898249455%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C3000%7C%7C%7C&sdata=3DI57dx%2FORRXDeu0TTENlejr0IcuSncVHfy7LCPOJNekw%3D&re=
served=3D0>
>
>
>
> It's wrong reverts because, initially was an issue with a test case, not =
a
> patch itself.
>
> My GPU is not working correctly again after such "stable" patch.
>

--0000000000003b9f0305f21ef97f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yes, this is right in 6.2-rc3<br>
<p class=3D"MsoNormal"><a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/commit/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=
=3Dv6.2-rc3&amp;id=3Df936f535fa70f35ce3369b1418ebae0e657cda6a" target=3D"_b=
lank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/<s=
pan class=3D"gmail-il">commit</span>/drivers/gpu/drm/amd/pm/powerplay/hwmgr=
?h=3Dv6.2-rc3&amp;id=3Df936f535fa70f35ce3369b1418ebae0e657cda6a</a></p><p c=
lass=3D"MsoNormal"><br></p><p class=3D"MsoNormal">But somebody reverted it =
again for the stable stream:</p><p class=3D"MsoNormal"><a href=3D"https://g=
it.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=3Dv6.1.4&=
amp;id=3D9ccd11718d76b95c69aa773f2abedef560776037">https://git.kernel.org/p=
ub/scm/linux/kernel/git/stable/linux.git/commit/?h=3Dv6.1.4&amp;id=3D9ccd11=
718d76b95c69aa773f2abedef560776037</a></p></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 11, 2023 at 5:35 PM C=
hen, Guchun &lt;<a href=3D"mailto:Guchun.Chen@amd.com">Guchun.Chen@amd.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div class=3D"msg-6172821185785906225">





<div style=3D"overflow-wrap: break-word;" lang=3D"EN-US">
<div class=3D"m_-6172821185785906225WordSection1">
<p class=3D"MsoNormal">Hi Yury,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">My understanding is though that=E2=80=99s a revert o=
f your original patch, we did a revert again on top of the reverted patch l=
ater on. Can you please sync to below commit to check again? Or do I unders=
tand wrong?<u></u><u></u></p>
<p class=3D"MsoNormal"><a href=3D"https://git.kernel.org/pub/scm/linux/kern=
el/git/torvalds/linux.git/commit/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=
=3Dv6.2-rc3&amp;id=3Df936f535fa70f35ce3369b1418ebae0e657cda6a" target=3D"_b=
lank">https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&amp;id=3Df936f535f=
a70f35ce3369b1418ebae0e657cda6a</a><u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
<p class=3D"MsoNormal">Guchun<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-color:rgb(225,225,225) currentcolor currentcolor;borde=
r-style:solid none none;border-width:1pt medium medium;padding:3pt 0in 0in"=
>
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;<a href=3D"mailto:amd-gfx-b=
ounces@lists.freedesktop.org" target=3D"_blank">amd-gfx-bounces@lists.freed=
esktop.org</a>&gt;
<b>On Behalf Of </b>Yury Zhuravlev<br>
<b>Sent:</b> Wednesday, January 11, 2023 4:26 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blan=
k">amd-gfx@lists.freedesktop.org</a><br>
<b>Subject:</b> Wrong revert commit in stable channel<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Hello,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Something went wrong, and we commited what we diced =
not commit.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgi=
t%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc3%26id%3De5b781c56d46c44c=
52caa915f1b65064f2f7c1ba&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399=
d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
8090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2FkLymTjCMQ3u=
C669%2BWNXePiZ9ysaAGdvm7gFw5kIGeQ%3D&amp;reserved=3D0" target=3D"_blank">ht=
tps://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=
=3Dv6.2-rc3&amp;id=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba</a><u></u><u>=
</u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">and<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><a href=3D"https://nam11.safelinks.protection.outloo=
k.com/?url=3Dhttps%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgi=
t%2Ftorvalds%2Flinux.git%2Fcommit%2F%3Fh%3Dv6.2-rc3%26id%3D4545ae2ed3f2f7c3=
f615a53399c9c8460ee5bca7&amp;data=3D05%7C01%7Cguchun.chen%40amd.com%7C9b399=
d97a2624b5bc46e08daf3ad88a1%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63=
8090223898249455%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz=
IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DI57dx%2FORRXDe=
u0TTENlejr0IcuSncVHfy7LCPOJNekw%3D&amp;reserved=3D0" target=3D"_blank">http=
s://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=3D=
v6.2-rc3&amp;id=3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7</a><u></u><u></u=
></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">It&#39;s wrong reverts because, initially was an iss=
ue with a test case, not a patch itself.
<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">My GPU is not working correctly again after such &qu=
ot;stable&quot; patch.<u></u><u></u></p>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--0000000000003b9f0305f21ef97f--
