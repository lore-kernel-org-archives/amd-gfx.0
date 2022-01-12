Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD4FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jan 2022 13:26:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9F9112868;
	Wed, 12 Jan 2022 13:26:25 +0000 (UTC)
Received: from sonic312-47.consmr.mail.bf2.yahoo.com
 (sonic312-47.consmr.mail.bf2.yahoo.com [74.6.128.109])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2437E113755
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jan 2022 10:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1641981737; bh=x74AItx7Ee5VjJ4f5OqmLv3BDuRb3BTQjkAYk8QhY2k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=BXKbOcuZ9NruH7oBNDiX6ARkTrwpagVtHBL33bBhsfgmoJ1Gy/M64XAhQ5E7uPCfwWq32p0nu2nL1i1do3rVOStwEPW5yA5IK6RFWyNMBLrc6ZC3H3P+I2eas47Ox9WIo+JtjeGeWzzSo+YsgX6hWvOERQrwAW4X9rjjSdhjYMM51Y893fcgr4XqnGt0sBaU8db5VLIqgqXU4MOg1g19JTZoZEjZABDKSJZXv+ckMjy15qMuM1IBBrfiyHAcwYLBTzvDrl6LERCeOo+Zx2S5/jdwz++mRzANYJv+vKxbVIWu57bkqZvDsP4wHqs3UumNI6oBa4B4GKFr4ioxL04H1A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1641981737; bh=nqGQ4gDlDgnM1Jjkxm+NWeaX0X1nZFj/CxGfwgm/nGw=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=W5FYYqgJEeId03xfFEUn9AS8eW19717g14BglMgJ1RzubJRHn5QGIYw4w6Gv1+/0osXWox70mqNk6Dq6dTT4uobfb2qug39XkOBwIZ43yrsMWktzp276GPOqe98Y0+ityqzbAFM3uUY/1MSuEq6GphstK2fnSkvdwr7NRx5ijDcSzTrHA8HuNPO8epVAXeauAJ/VjMMWNeYJszOJR1BK8nhbst8Puh6rwZGGpjPGaavZvD7R3Uf1N+IuaZzm9+xnaqiCWIO4S3KvhkCjY/VCsvnT3kot8lnFWsPiHkz0JR+AboMeQQzMekopqpPhdLIP6QLW3YwbJXseksaPl6Tklw==
X-YMail-OSG: rrbW4voVM1lPPPbDZfOu1D3vmZV1COT5ESm9hlL2lOQar6jwQTwCPH7CI0zhgbp
 Ey2sgCdF4DTPDraG3d4WbUp_DY96ua3exFRZCSJbqzqLtHaU.p6qNnyzcFbw6WTL2XBIAcr4TIDD
 Nv5MXhAqR_AMcsM0n7xQzvsURFMN8VOrQNfXuzr4gJjpIHwNUx6sSQDrdOPzCZ9ZngL1vjPUWwIR
 vr9.fR0CLmMt9fafHNEpYNDpI2XXCLGK.sMPErxdBzLUX0.58QZ6EtEtirPf698cYliiQizU5KX1
 .zpx50rSpuXOhSb61iNRfGbudpP2UeMBhb2G6ENRuEmIeuAZbLo6Gpfmsb_c2rCrXaGlgH22pXFk
 ewuvg61ATT.rkMosaiybDjM7j4wbXPEAN4uZngHb3V5BLDlIxX20VMJOPHfbA5qAqtw__2qsFqhq
 xzYjoG15zAhIgyoAc8E0zECpy9dIwcOYiA6ymRMMM9.H9_dkc8n4wyuaqtwKaDcZcdCiN6ZkY.a6
 SI2j9n7.Xh2YGg4NxfLDxTL8iuKLTkZtOSXN9eHP6bqCV7mVEqQ0qDfkllkKmAW3cfDRjS6x2jQV
 .fNpllVY.8_edjvlS4XlahrnbC5RsGBWaYIExDeAwpDMx6EQD1LqG7aNQ3NyiMFVYAyC5zag1OJw
 hOJWz0Ak8Zqaeljd3_tCkKE6PWklLbmy.oamootPqeMVAyVOjeZxXJgLWl_lvsTX4WYC6KMk8BtZ
 6m4kuMR1SvzBeSiuijKeYmQ5uHxrmb3CEoIt6RkaqP2DmTj9ODrzJlXwScVJsaFQlc8fzQc7Jx5r
 czC.CKq.yTN9B3FvlTnhVr5RtPZixI6dcrhJRH7OMOuJ.zWrgguMD1V3X59z09s.mFRfkoZl4ty4
 woB7DSkTmxqgMzy2poLysPnDlGADIK.ZT8IHAB5Cq_ciylQw6DMBtaRkDRpiodzZ8jfXe6fWcLZJ
 qGh4yj62y.Z3mFnyqdKK_bp.f2zzUetUhgqYKWrrNab9RdBo8J_WiK44MeGUnKrPgqXevXuqYNHd
 p0whdd14jb7vloKRh8uPtKQBzZcpZsj8_yFuB2gCPqPegKNZc0f.zRhFvDE12VEJ9sNfQdNsPUZC
 wl7wiyy6PtaCxtqwVjopMfGNkedkveUxF5OpCz58UUjPHw0.nC6E.Q3gr7ZfpG5FocjrtvHLW3jg
 CLtYP5zknp1jSdcbnB4kGPrfdf2b7ad0qgTLUlmFGUSLzi94xuk_tvz7pJ.yxgxkSajOzqEsVQtk
 UH6cRZwdrK2opOLKGtinCtve7Fs.XZANQLdvKeGZynPM8Jkbn4dgVIULMRcK2n0AvA.cQ3.jd_ji
 dpFdUg9JEbEgQRvtvMbJmbcu2AdKId6Oc5CfloCyuVG17HQreIiL18hfdXRiQ5BOL9eMrwGFHQmZ
 FxJXjbzbWsmLSYjjX5tComEkDn7HK4Xm9krdNLhdnBYaSXa9.IzK4ANDHaFXoTv1J2i1WHpyTvs.
 RT8JQJREC.FPlt5qTdMevMNnX5cMQvwmTyIJe45lhMH0Zh_EIH9bYLCPIBR1nj6FJWdA.LW4FupI
 6R0ALEBJ.nnD1xyVFxVLxwC_ZGYP_LrWrDN0S3kp_3LLCtE5GTbgWX1SVi7iGD4BsB5hAhlusgVm
 FZJZKz7u0lQvakXyce7IUUgcioHVz0hkZvo93qxtYg8HOloN3Wi.0eVCkVdqJURn6KLeGIGeqj8O
 iwatxz7CFxF5tV.Sl3DFksgA61jCMscJ6FncgFbGzfi4LrvrpnTRj2JO_OUauN5Bx937syfikuc9
 tt4p0Qf5vpelxNqQR1ZyKSZ.thpoqP53wXsDBr3xyBV0dNkD2YJhP6U5XDiZ_MVDHy1dXwPwWFdx
 FqMhNxnw_QOzNormjENIKPiS.KYdw.v0ERlJL1Ci6enDq7R_MiTJDf8KIdQXhm_g.ZpQf8Ng.g1J
 PQBXUE.oJ0a8ZMcBofU_jA_Y4Fnc5.3XWQaoLkQ2J.tOKPBK2dk_urpo9njAyAVfrWI37n3B1Dqi
 h3ONq8jiRYu5YR4TTdPAoIjs9kxYQs1Pk2EiefB8mE2zVO_Cc6JUbnjRPw12EIjEyPbn7bTM2RT8
 5lIstf1_tf0ShebRmHKarI81DZcyQeVBH_R43rec8GVB0QR4imLRdNlKAwSY4Zu_o3kEXxZpYA1z
 FjESR7sOPpjqKks3S.nh6GfWV8lhcc7Bh_uzXZwX9Q1_2zU9eqMujhFkDsEoRTK44a7H9S62K9lp
 55t2XXeyHj4E9K.ZufrwuTmf_T1JahvNG.eQF9DbGSJzVlGiGKTfbLO9PLDJw3Rj9IBQESI0_Yjb
 2Fdr0geTvpVexMLDnCsyMRl3ESW0KvJD17fNOkxBWRCXG63uPYacWeYg-
X-Sonic-MF: <tarequemd.hanif@yahoo.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 12 Jan 2022 10:02:17 +0000
Received: by kubenode517.mail-prod1.omega.sg3.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 705d92632efb658ce59ff3af9b8c9d06; 
 Wed, 12 Jan 2022 10:00:13 +0000 (UTC)
Message-ID: <4dfbee97-14c2-718b-9cbd-fdeeace96f59@yahoo.com>
Date: Wed, 12 Jan 2022 15:58:25 +0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Revert "i2c: core: support bus regulator controlling in
 adapter"
Content-Language: en-US
To: Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org
References: <20220106122452.18719-1-wsa@kernel.org> <Yd6gRR0jtqhRLwtB@ninjato>
 <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
From: Tareque Md Hanif <tarequemd.hanif@yahoo.com>
In-Reply-To: <98ed8d6d16a3d472d9432eb169aa2da44b66b5cc.camel@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19551
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Mailman-Approved-At: Wed, 12 Jan 2022 13:26:25 +0000
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
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 1/12/22 15:51, Wolfram Sang wrote:
> would the reporters of the
> regression be available for further testing?
Sure. I am available.
