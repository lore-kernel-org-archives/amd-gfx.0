Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD501C54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F205010EA19;
	Fri, 13 Jan 2023 14:37:57 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1FA110EA16
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 14:37:55 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-15b9c93848dso14183021fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWrCLcUHfgZZix1VxmNI8xEOMY2Uq0aw/oqM4nM9BB0=;
 b=C74xiuZFggmskSi9xhGkFd4XCaIArDqqtcwXxAfpqYaZGfvGulmEWthDxnvdMmCUqt
 GUVfWObGyTD29K6iu03rlzYgRj2s4b4pKEm9Q73QEIh44OwBxbgoHiY2K5X6qOZXj0L2
 EJkt+DzUIW+6hcvnoCba+uI31MOCH647z4c9QU3nz0ggQbpKynthy/yF80MayGFRg+XT
 2S6R7BW8D1VOsxyW3t0k5CF8ATFaddIBplXi+jAaZQdoVfPf7gRJAA1EchvtMO6LuQGN
 uzuhmAs+5YNirAkzOdSeZ38EUqIx4v4TOzORyL4JTApEXeL2Akn2qiY38qqPGYOkoD5R
 hrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWrCLcUHfgZZix1VxmNI8xEOMY2Uq0aw/oqM4nM9BB0=;
 b=zSjkOuODs2wtiNPCXRZxBJBNxedqITnyfH1v91Tis/WFLf4K/Bon8pYWqZf8FMSJpu
 Bb4yVYzQbnIKAx+wj186duldcCAn431r5XnFgwS4mjjrATTesJMRwAa2o5I8hH4YZ7VH
 XA4EwW1n5VIopxhomcV/uZYsKIIuFfGg1G7T6phwXv9AjifT4gGy6599o6bJbHB44Vii
 QDSjQkDs06NH0Z336UcaYGItcTluPN/DAWp2ZBvstuJzm++90+UfGO2gHnNmlgbEUpvi
 jNLAHggcCn1Mht0ZHOD0NHWHGC/57fxNQA+JMF/Kj00sFSoahoAOWz/2WdrAgog0MsxA
 c16w==
X-Gm-Message-State: AFqh2kpcunPmrfgnC8VV1DF0yWetWDVK8knGn2egd2tSiGh/HOYotA3C
 LHUp6zieU/9I5qHAleBOp38drObukuRVKE5h2yKaXK7E
X-Google-Smtp-Source: AMrXdXvSZFDL9FeuFBq6uR9TcA25ZWXL/hT0Mu1rEfRnwGNdC/gaRWgI1ZbfsUJ7MnJMP0epoR8YQpNXHIKuLeEuLJI=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr6920470oaq.46.1673620675125; Fri, 13
 Jan 2023 06:37:55 -0800 (PST)
MIME-Version: 1.0
References: <CANiD2e9bdhxdJr_N9wb7O0Su+LRhzE1n=TepvbBiOoqmKRRgeg@mail.gmail.com>
 <DM5PR12MB24692E12F2C533BD8D88508AF1FC9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CANiD2e-JebLZGvc0tSis=062t+=vPBVr_50=wm76G0Vu8nwnbg@mail.gmail.com>
In-Reply-To: <CANiD2e-JebLZGvc0tSis=062t+=vPBVr_50=wm76G0Vu8nwnbg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 09:37:43 -0500
Message-ID: <CADnq5_PWc92J+0=-L+8ShjY+aRcn4L9sMTS42QUO5f-GrAG0kw@mail.gmail.com>
Subject: Re: Wrong revert commit in stable channel
To: Yury Zhuravlev <stalkerg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like Sasha picked it up again for some reason.  I'll revert that on 6=
.1.x.

Alex

On Fri, Jan 13, 2023 at 1:02 AM Yury Zhuravlev <stalkerg@gmail.com> wrote:
>
> Yes, this is right in 6.2-rc3
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35ce=
3369b1418ebae0e657cda6a
>
>
> But somebody reverted it again for the stable stream:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dv6.1.4&id=3D9ccd11718d76b95c69aa773f2abedef560776037
>
>
> On Wed, Jan 11, 2023 at 5:35 PM Chen, Guchun <Guchun.Chen@amd.com> wrote:
>>
>> Hi Yury,
>>
>>
>>
>> My understanding is though that=E2=80=99s a revert of your original patc=
h, we did a revert again on top of the reverted patch later on. Can you ple=
ase sync to below commit to check again? Or do I understand wrong?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/drivers/gpu/drm/amd/pm/powerplay/hwmgr?h=3Dv6.2-rc3&id=3Df936f535fa70f35c=
e3369b1418ebae0e657cda6a
>>
>>
>>
>> Regards,
>>
>> Guchun
>>
>>
>>
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yury =
Zhuravlev
>> Sent: Wednesday, January 11, 2023 4:26 PM
>> To: amd-gfx@lists.freedesktop.org
>> Subject: Wrong revert commit in stable channel
>>
>>
>>
>> Hello,
>>
>>
>>
>> Something went wrong, and we commited what we diced not commit.
>>
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?h=3Dv6.2-rc3&id=3De5b781c56d46c44c52caa915f1b65064f2f7c1ba
>>
>>
>>
>> and
>>
>>
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?h=3Dv6.2-rc3&id=3D4545ae2ed3f2f7c3f615a53399c9c8460ee5bca7
>>
>>
>>
>> It's wrong reverts because, initially was an issue with a test case, not=
 a patch itself.
>>
>> My GPU is not working correctly again after such "stable" patch.
