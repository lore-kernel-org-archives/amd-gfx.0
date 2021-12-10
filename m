Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57465C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 14:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66AB10E3C0;
	Fri, 10 Dec 2021 14:17:03 +0000 (UTC)
Received: from sonic305-1.consmr.mail.bf2.yahoo.com
 (sonic305-1.consmr.mail.bf2.yahoo.com [74.6.133.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3832910E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1639136358; bh=3DzBMbvnxzxQsacAJ7ILBnAy1sv4m4cITI9TC67MqVk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=IT1mfDndvJ3ZD5pDSZHwUP8mbvM1mUFC0TBdpvhJVBZz3WnLaSuC+eUOlohScIfZnfP0SHkAZs1OZk2uJXcpEfiIvCGQ8MYQJBXLMSipYQlyldrz2hSRvzOlVv5WMQZiiBZMeIU3JwJShOk0EtRzH8Z1alA9aeqR0Ey5WKxyxoy+EeXP40OTlRz/tq1AzHx8ScCcDUp0aV4L3taQPOq3J9zQtaLK3EaljT/+hfgQxkQan3rvbbmr7lIVqJB+vyXAai3ZlnY7Zo275EUkVl3y9+gVz/sTox8SzO1wJzrmZL9Ofh91KBRaCjDWxgvKFBp7X8T4hcdwENtuDxmM2Br81g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1639136358; bh=7m/0sa5KWxucEQvmIzIai9JMjzk/zQBkoAqnHByJJGn=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=GdRFZ/zib4U7mnIFloCp3x5FlpftnHWgr3ExI0Na3mrmtLblXp3GurOfVeLVH1oUrV9a+563bq11G/Y93N+WSDy3HiHZ6V4RCQg0cfScKvqQ7tYrd2OSV9LDePnqqEmf3AGg4xcCZXXihPxcGVG1noUpJra+wKFUT4djGF5151VFBQgN6duU0a2quwGTjqwJTip3cPfpep8sGlFRGe2XUkzkrgVG3PYNIlH0CDVtFzsVsvdE7d8wfNrSk4+CfzGPgBG3qRMspIMzxQ67Udd5HY7KZgZhnXyyInvjLq+I0rQqxGi85wyzxq565GDHzSHpGYjhD0vxY9cLWK7/nGeJzg==
X-YMail-OSG: lyn1kzEVM1kwl4oXXd.7WdxtRr_8m8Mod0ovZzQAAWVNBDT0JD9FTRlzfuhuaOi
 c0bx.7mdJxWtWXiS_cLbGQkLOZaQlSmwQdg2GkqmpfDtzXnrd6SbGbTWolS9g3adR1.srH96GGRn
 LJSZx4VIzOHqNT60OXF_unrzpKixNzYuhYt7gAqazx3tiHDeXVavFxZP42XdfvA4JVdf0oCXCC3H
 6FmV0z.srHiEr70tJ5c9FaUtyxYM6uqH_CsCykbFnlY07n2WwQGWCyigy1uLOOFEDmUmd7R94yPr
 pV7S_vrHzMukCyfLdg_Wfe2sEhNqRqWL36q_ZXJZ6qGFx1l_HO7JvDKLHSg6tjeVuUwqYoeH9FqY
 bZsZ01YjEimyyMNIObgFw7w5D60nIdqMoQ8_PSjFAPnh9yPRvqP9j8eSjDQ.c7iL7IrG8sEMedTk
 IoVeTlJ9hidGXyTVA.vHRaReV227L0W..8NgxEAFx0JnAgYyLk7U5yhdmshupQ8smNlH97MsV5P7
 5CADsTRx2IUt8x3Snc6dSFyuGf49zk4pDIyzq1nyA3VP5u5dDlwhAUKZsU9ouHNbXDhGGsrpyHeo
 wK5rhtHTvL1CQ4ZSEj0tf9o_iVtPXAYtCKg_iq4uGYl4d0tJ8OTzHeYrsgaOISpXUXcqPj9q_lzx
 rUmPKz9vEmDoswNat9OqckJUgxmFfSGyFZ4Y1xCbWhwtIeI6EObl4OCge7frERsdwWzlG.LTUKeB
 ynH1xEs13QKG37btEmfJmT5IWdZkT5ixAcIE034ziCjxMs5u72HQJPwYy3qi4.ZEzKu86a0IWtlW
 g6cj_CkrPoE4DIUNYct2y8MT8O1yuykmhZ7zBP7hT_kWpN.BaOAKYmAmpbUD_qxO1OwEX8c0aWSU
 zgyoWtWd7LV08HghieS6jQgD4JnTQFNyU19bkuuiAl.kNF_bnzwmTF6YfM9FJ42mgio5z7L.ZAjL
 BUABssi9ihMaUVBkfGxUtRvYMZkf9dg3J08HFEcBwNbYSkAmvwQsEOqFe_sSZHLVpQa_diZs3NxK
 r6nL285DN6I35nl4u8WZ5rTj7zIBcHHKAVIsl_M4GsDYmQYDXJGZc_ImAPmHj5QE4kMjTsZ3Kj4i
 fx63T3QuT4uyivsGMjUj2TIRKz7BZ3NsR2wt8OjlZHfIl4sAhHMZsPB1Y4sLUacciAtpxvDSxapn
 H2CZKbaJQ6kf3sgtdcUvrICNgmKUit1.jqL01asSNHKSim4eO.fcIEYqlis46LDobgIsatvdNdtb
 gs0hfv2Yj8eonyXLpGka47WRXZe3JNUYsNuwIV5NeQ7E4tvmLk0epWtCeqar94nZSBxvSl2WpCpN
 6GhXoVe7lx4mM86tpYE3DrVwUldp5CFwCjx2W24GOwh_ezptZd.t4JhhoK6tGKDp.tUr3RWWo7sm
 9Kd0LJeip72LTL55chL8Co0nIEtTgS6Zf6kHCjmvo1vGrKMVCclhdjuBF6MhY03l3dSFKisJ48yE
 EzZ5fKUhyi.b_6QX7fPSHXHv.UTmp4A9PD_8VuCZAmnB5V85z8KniEuyBVICiFHcPU0COUpxHl9H
 Mh8phfwbNNgZyrQvnvsnMyxl_4.SvzBB0i4iodc2BCny7KC1nJJTcmGa9YzxHOSVSr57PBGh5SjB
 GHkhG7yYN1klGMy7pNjrYZHYbsrn..IODowsy3R0JcWc4G.D5vOQOcZ90d0bf1Dxod3acoT6Bqkd
 sGrPS8KQHGjGHCYFrVbDZ4sXWZxP_eDDTb6bAG4oLQ0bMYdNMZQTnUCtG6NpR7hIzCphePSsBZ6x
 bXsjSIMlSjaol43onZiCOiMmbs3R7Ek5HpTyLrns0EY3XdxBo_z9ZRIRsJWl5G.2XhcuQ4xWoMmV
 Pr3Rv_Ozj4fuJ3Iu9RsUVPfANdStxsWBhNYJuOxqgmGc9vBJGQuKIyptywBrtBTzhxJqXeTeiBTf
 YiQp4svq8J80PueNTZuHHDP7C71FnO8HOfOdG05XGm5ONFVkWdFkOo0mZA26tDvFyQUF_Sa4I.KW
 LRxrRVKnSaeUMlt3nJY8EEbxZDHYIK0T_vaUZ6tE84WGFQJ4qOsWz.Gf.EZjjHV01JP9S4gNUk4X
 _ECbk9DzOMrXqnUVPoEJunIKZ4n_1JDyADZT8FsBHZaVIhf7uyDzDRke.x0y07Ma.vpaBxpSwI_h
 SBzWGxU2.iYNRvnhxtwhrVU5vWSAh_hUoTfFfV8Ci9AcTyxE8W7F2j2Ws3EuJK08jIxXPhQyKpmJ
 h0m_hknPQKy_GNXmg293.xKgE29odbtWcnnuD1w--
X-Sonic-MF: <tarequemd.hanif@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 10 Dec 2021 11:39:18 +0000
Date: Fri, 10 Dec 2021 11:39:16 +0000 (UTC)
From: "Tareque Md.Hanif" <tarequemd.hanif@yahoo.com>
To: "wsa@kernel.org" <wsa@kernel.org>
Message-ID: <1394751822.39123.1639136356516@mail.yahoo.com>
In-Reply-To: <YbJj7xyiPs8HBxC8@kunai>
References: <1295184560.182511.1639075777725.ref@mail.yahoo.com>
 <1295184560.182511.1639075777725@mail.yahoo.com> <YbJj7xyiPs8HBxC8@kunai>
Subject: Re: [bisected][regression] Applications that need amdgpu doesn't
 run after waking up from suspend
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_39122_1379925081.1639136356514"
X-Mailer: WebService/1.1.19415 YMailNorrin
X-Mailman-Approved-At: Fri, 10 Dec 2021 14:17:02 +0000
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
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

------=_Part_39122_1379925081.1639136356514
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

 Hi,
I just reverted the commit in tags/v5.15, and there are no issues after rev=
erting the bad commit. But in 5.16-rc4, "startx" hangs with or without reve=
rting the commit, it could be another bug.Regards,Tareque
    On Friday, December 10, 2021, 02:15:49 AM GMT+6, wsa@kernel.org <wsa@ke=
rnel.org> wrote: =20
=20
 Hi,

thank you for the report!

> No issues in Kernel 5.13.13 and the issues exist in 5.14 to 5.15.7 .So
> I bisected the bug with
> git(https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/lin=
ux).first
> bad commit: [5a7b95fb993ec399c8a685552aa6a8fc995c40bd] i2c: core:
> support bus regulator controlling in adapter

Have you tried reverting the commit and see if things work again?

Kind regards,

=C2=A0 Wolfram

 =20
------=_Part_39122_1379925081.1639136356514
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head></head><body><div class="ydp801404f4yahoo-style-wrap" style="font-family:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:13px;"><div></div>
        <div dir="ltr" data-setdir="false">Hi,<br></div><div dir="ltr" data-setdir="false">I just reverted the commit in tags/v5.15, and there are no issues after reverting the bad commit. But in 5.16-rc4, "startx" hangs with or without reverting the commit, it could be another bug.</div><div dir="ltr" data-setdir="false">Regards,</div><div dir="ltr" data-setdir="false">Tareque<br></div>
        
        </div><div id="yahoo_quoted_9589008530" class="yahoo_quoted">
            <div style="font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:13px;color:#26282a;">
                
                <div>
                    On Friday, December 10, 2021, 02:15:49 AM GMT+6, wsa@kernel.org &lt;wsa@kernel.org&gt; wrote:
                </div>
                <div><br></div>
                <div><br></div>
                <div>Hi,<br clear="none"><br clear="none">thank you for the report!<div class="yqt7613182026" id="yqtfd87508"><br clear="none"><br clear="none">&gt; No issues in Kernel 5.13.13 and the issues exist in 5.14 to 5.15.7 .So<br clear="none">&gt; I bisected the bug with<br clear="none">&gt; git(<a shape="rect" href="https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux" target="_blank">https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux</a>).first<br clear="none">&gt; bad commit: [5a7b95fb993ec399c8a685552aa6a8fc995c40bd] i2c: core:<br clear="none">&gt; support bus regulator controlling in adapter</div><br clear="none"><br clear="none">Have you tried reverting the commit and see if things work again?<br clear="none"><br clear="none">Kind regards,<br clear="none"><br clear="none">&nbsp;  Wolfram<div class="yqt7613182026" id="yqtfd39717"><br clear="none"><br clear="none"></div></div>
            </div>
        </div></body></html>
------=_Part_39122_1379925081.1639136356514--
