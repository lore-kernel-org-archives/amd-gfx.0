Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FE4FF885E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8517610E632;
	Mon, 27 Apr 2026 08:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="phh3wcIp";
	dkim-atps=neutral
X-Greylist: delayed 319 seconds by postgrey-1.36 at gabe;
 Sun, 26 Apr 2026 08:34:38 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF61B10E527
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2026 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1777192477; x=1777797277; i=spasswolf@web.de;
 bh=HKdkkZxhzWhSZNCuALP3j01kwxKX3ukZguHj7H7aQXg=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=phh3wcIpaP2t1cYsaj/FFmltzU633HQ9wW9qy3AwSkx8W9vDa3427NysBMC+XNfr
 yqtwv/Ukj6JwVE0rESzuIPaih8ykmneGIcz0e/1gcSFL9xfj0iJ+HOfYukoSAi4Av
 qaG3OwIX05BuYglzFePwNUVRwlmtQyEa0yPAK7zwUXFyG65X8W1b8cNZyr/AU2Kjo
 19sy7vpyy1uSryFiFfa5h4ie8ym777hwC/jSg2IhaOUgm0OvIgrwqSdtCk5ybFu1c
 Wj+F8V2Bluh6yBjP6JTriEGg9JfgOV3D/Gk15q+DcwPNlbr0U1n71oOGgYwNxJ/rv
 72TeFE5CDmclsWBOag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MVrg7-1vp6a70IL7-00OI9q; Sun, 26
 Apr 2026 10:28:58 +0200
Message-ID: <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: "Varone, Dillon" <Dillon.Varone@amd.com>, spasswolf@web.de, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
 <linux-rt-devel@lists.linux.dev>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Sun, 26 Apr 2026 10:28:57 +0200
In-Reply-To: <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQcTY/3PUzonPXpbQyWw2UThw3wqIb8voXSQJLLomU3am6FJDtR
 jZEP7YjWtr84o9Yl8q0+X5GrTyAG3qmGq3XCH8ntrf/Qermk+r/+kQwmlbZGZFG0LpAlsqq
 DzTZ25+xm1GEcinLjcrK0xqw5JmKojq2GYVPKBIIGO0j0rYGcTJfg7GeJ4+i9FqQ+btJE8m
 NFSIttFCnUI4EoF1sh+9g==
UI-OutboundReport: notjunk:1;M01:P0:BQjYTB6cc+s=;Jk4SPeur+K1R2pZmrzCYIHw0jgO
 VXPbs4RMk3E76y7ahw300DaJhKmwjE6Kze8l74ZOeT8QTISPeQJLxYC5wdeZuHhlgYY9RmVPz
 Wlyhst781kukb6Fao5dGNmQEpG7ukACffPIjLU2XEeHits/esMuyUZTX3D72So6iK2bYt2OQ5
 diuzGOIp32sHMd84pgZ6ctTTwfGfvwjFkGqGNOaGFVT64yqS2cFR+fQZPnyRl76nLEd1kIwjG
 s/M7LG00YVJ03IgRVkJmOyJTf08omRQIQrCYgBI4tPqyiy5BCXisxTBbLi80dja8Kfo689uez
 KApfMcxeP3Rw3o1u47rPQ1r7CfNTKFMoP5qGkL0e+WdJtrKmHJHWh/YntIw5AWQg5/c8+4wUM
 3gVG8ZBUoJH0t6mSyOZwsSNTbqxjXnc2HCv2B8RIwPTbNh2Z11iByoaYjzyNbn7W+XYy8BsAZ
 IvJbKide6Jy7TPTh6BuDYwCIvtXwm2XnVC3UMWDZqfBBLWguVDD2C7gCYc3YaKGdcuxR6QosW
 LWwAPoCwG565e/rZ7Ew+bHNqteyNLyVAtuR5R98UikfOPUNAW/KPU6La0sT3mgqOEvTiGboai
 68/ZCjMooLADJ5RWwaiY2CWuJQhr7HrdUj33xMr7HJjm80e2OeN8WzwUvfcTJEJy756wnIju+
 maHx7Nj3g6+iQT7tsHb/ofaN7PD7+7vWYAzV/mNImaW44xy7qGo3wAImk0UigC0iEiDzREGfJ
 svkrKuj9IrmxBY6uvOR0jozf3d5daEd4R1cb4TAjPvv4GqAFdXzpLU9EoDiZ5nPO+k5qFbEmh
 K56ldUenBmV28zMwU0bS6OAAumHzxxZ2G3FuO3+IRvwXrIrTIHskgnZDMHmFPQ3eNP/lO/8RK
 l2lSm22xVgLYCH1hjZIgJMOdBhKAgH3Ki88O5TMUJXDXdK6DqHT6VJSrck4cojsbLNd1jMFEl
 qLCh25FFtbFR0hvZzmTA2n0Q4Tw9YRU90PVF8drnk2kzQjMoyuQVOkhT+4zi/Aa0IK0wE2sOs
 xW7y2W8Pe+IWGszgGEHOzF0o6XwDLgF5G9fcd412t10IzOwXx/NfjzDWRbysD8wL4JSI+Ue5F
 riRvXyyuAPVylzAi5ir5QNICJyTUSmZtg7vECK099JhE0HY/Kbjf5Q0X9wxUAsrRaWlgxd7h/
 DXgkQE+7hEmspK36FOx6b1OkZPc8Mr76VjVzP4mhXGzOCugyza/Zi/lAxG409GlbncVEaiTni
 to6WjotHDIfO6mRdfKTntG8k0dudKy1Ud73PqdJHJnI21IWtOKFjVcsIReW9XCIs92bETMuao
 WOYvhP8Zy4noEKR7xZdEMVpJd1T8tARpyxCGfsCWsCKClIQDoPlmD3ksOiH9BrGnlSjPZhgEV
 4VoGGeYw/pOgg32dy2JvVxloa4rvvqBTFxz85KQPnDZfb/Jeq7Fvk5pGqPoueqfTGuOt/E2lz
 tsQyWAzjoBAucT+gvZfGzMVhI7x9yPczF6uUlCBoPX03acARfJD8Uv9qbi4zglZ0E/IcYlvIJ
 dHBqYHk541nuAAMsIun5LduoTwCfyjNdwmress0sxfchU6EOeevZQJ1rIFiz+DYORA94+OM4Y
 CjTLxkpVcphkDVY1LLpgNp5U1gT0tCvFRWWWniKdz4rmJBRE852tl8RsAZ3yRSYlPg/7heTOX
 A4Qp596KG3NRya7izFACUoZ2UhiZo/l30jteYF2hbKm4W1NMLKduLoU4w0kQAVL6lOOpoLMFA
 7JeytlL0OFW2fZ3j4duybJCw55Q8TW01QdafwzmpYO4nqYeDN6EPR3qyYibRXEq8+ohWk72zr
 6oYchgEd3Ewp9sDIQFxVCy2q7a4wV7pnf14DG4KV4ipaeT+lDE0nG3Sy3wFiYzes5bN7Nl85l
 LNyEwiRDMAmywCAoUt/ZGGIoNSQbD2nAbmhCfDD2GeBFNjeZ9xMAwOr7Q0iosNn7Qfl1/SEmn
 cs2df9fWTLK0epwfYGKWJEc9KexAABnFnF6VTZ4mu4KKD25zYnZ7qNBQBCqRsBII2zH+sS5ZX
 xAgfV4pICh6klYVElMU/xPEoVfu4+gSMomWINzPgRODeRZFlSQSkexyogZjg6Xxsk+xWvloLi
 fB7ItgskXz1FJOo43YUzZqq3kAI9oFcUxoNs6RH4KPDKknQYKEw2HU073/9u5nrFvXDizRt2p
 V+bH/vOq4PZNM57XUWEI/K7Na7OU2AZXs1bex1t+pJyVQFTxEUO7OSj+Ss8FIRiFsrfjygDq3
 3PGSE12t9zKidp1lURi/8H+aTfYplSI04vcqL4w5EWS42peSUOUsPXMIQRjZwZOiMw+N8ZJZN
 W2GYh6+GVnVKbMUerf4oY8u6UumOc5MdwjRd+39rLGTUAL8TL/zfCSkjjawdVqa5A//7ZHRr6
 nL7faUNCFYFJJfCvHmHNND0RmmoA99nbnChCEzqN51g9bvd0qqlSN//hU4b9OWuwVUyr0BYHz
 DNYWdnn5cmxdn7i4tKdf0fnR2+RE4hY9alkYaiNNFt3h6wdyxKpLgW6wB943vfHUSmgJiFTY/
 GSDGBHTyGOEiXIhIShNxP7sIEv2pCCZe6tj8Vv6zKt3GoQYHvrvWXecNjJ0QRvTn2wGi+72NA
 7rBIvbGEsBJAKsA3ciJ8DhUknc6oBsooCbBtbj8SaQvqb+9W3KTTgJAnBGTSWnfL59Px2N/bg
 NbVJDy1XAIiQOqsHXw/bXfnhr5+Zkx3zv+1HKTy1XrnRazMipcv+qjya9iDeI1OmRe1UTWAGk
 e6n2yGh8QiwN6taWYaPjlJmMjp8sKFEJq8R8kq1MpT4nzWuDORZrW6KIAVPVXKKA1A6w8yJYE
 l9DPAHpx253gQSJ1szpJVa620SVJz0Su/K8uTKlZfxc2JO9qovsLiwDd1p1PCb0k7Yt44Pcyk
 1H9t8fVMnaqWoS+9noELwb6cbjYPSbw5h/kbKPAKGRgGtPOemFuvi4tSyfjaeHpS805rQ8Yx3
 NGuFodvyJIGUNSh9VCYZ7sDuNuGOnPELh0wi4RzNFb0YlExVdyye9hPCMi0arOIuqRx17bx/e
 E09BNjKG/WmXlMZFn2jQDcs7PtYacUMwpZ9ZGzDKZMuSHzZgEZrBuMFWhLA9FDdf1x4klrkLh
 s/7aih2yosgRaYp58QuzClFxtXjhgvKRivgvSChmuf6Z7HClSjdhSe5ICrRj3fL/2l9Ky01L9
 /WtSIDBlejQKjwPWqvHxI+XirphJStsf/6eKDFKIrZPr2ebfQur8m9uvV5PwwhG0vGzBXLUCe
 nfQsTF2alI+4WYzpQOcl69FO/CmN3YLHFwIgLE+lm80hAMDMzypbDP5kJ1i123o8seyggAGCj
 bsXKOWx/zAB8XipV+xG523S0Hh2mh2Hao3b9Gk41FwKeVkhFXjJLrdBRY+SVKYgN3QL8tTYfd
 bU1vcKjH/2uWRVotm5gHxhX/gERsKUONM+//fdili2REgynYBhgXo15by91jTOJjBORtGmQGE
 NlvOMMVUJHQh0ucgL3BUCEhbBoXEErJ9TaH7XPS2d2qYe4PzqDlvCyJLM2OLw+6SrtQqSZkzh
 T5cii043BUhCu43VGBh9WZH7kCvsgvE8a3vY6c8FADwzbrgAnA2jVShYU3cOAo2Z+Y4rOJfOX
 G+/eds26uhXP+/0JgTITSMKGoJxzHPZ2jCL2yS3Gp6CnLyAGq7gfwYI/Ds3hLx2eQdaPw7TJM
 vy37Vlbxt0aTETwdrF3SbcXPRK1tQXCn0DGMUDGO1HYBM9nXVp7kdNz9xbStdX1NgLBaMQiOO
 0fuNcM3++vsZndVTrhy5mmoNk3yhzxenbzlJgEwq4KvgAJoshLtdTfytlTcK4udCsOR1R0F4o
 jasB3xx21FNPTPvRJxoBZ98IMRqG8ol+YDfaDpEyzQxgDH53wYg1f74XfE2Govig/HZGVzvCM
 s9LZlvYZ92rhzx4Bn0VRASGYuu7woK7M/BWv43pJE+7tZ5Pw1LSLgHvvWUyF/fBVQlfppXpHG
 vB+Ikjd0PyIdj8XXoq5H6mzlefuvt5ZNBrQO2mOmOlB5hnTUA4CP8YDKWRsuInxz1t220CAtj
 vOmnvSj/fjhRuqg0izVWuevPfP03hCL32fY7Xumvjgk6afalUmcy/y0h7XnYeBAtUd5WHKNv0
 XnqcaFf3cQ+2P+vnbDry+QvsRHa9Bba9wL/dOQVCtlV0/BVGCK4WHtk9pNcP8OyxqgatbkHne
 3+nTMA8og67RCNJ7UvyOER76cC4+uqzWRRgg3B4inpQHHMM0VjqDf+9+eynTMcHrogENcqyZY
 wa812lddmlo75DAKyE+hIPRg9AMd5fidBQdN/bnxeHroNnlfPQjL+nn2DLWhbS452aVA9/FFl
 ILXiVsjkd0Q+ATDhFOlZzN9IL/n8zwpXF0D9DVTkucwK5VQXNI9QR48WfA49ULLYP4zDhteI7
 Dc6XZMOQEaKbR+RxcdbzyARAU99LZ7DCYxCS1NTKQ1RGCfy0QEMUwr2ONz6ohwikSGwsxuWlh
 GruQHs4AxLNczGgkZGfx/UWTJQezXguzTPjNAJMnIDeuFr83yKpUPrRtHb8SmEy0XR1hj2Lby
 //3HpayAHSQ7+0Pu+rrqVTI5l6sQnJaHI/3ME8BoHxfkxb6kujPviDZgXB1ZwZJwV3RT9sEH4
 5FZiYnhxbmEBzPNsEp7FmUbvh9c+e/IZoo1BSXwbXw94nFexrsVXfm6y9QS7Gs1ZUxTH1YBWQ
 gQ/kxoD8L7mxoHonFPcGncE/wL570nT+V97AW65d6o9HLkhDv4/WfjNr91MXhFiqI6Y3zynXb
 GXKKbV6AG58+jrAC8JDuqsL+Y/o6I8P+dKTNnneXCh44VmN5GNWz+XXTPENcq4MqVBqvSYm+8
 nKjPF2GzlJ1KVtgvCHmce/W1BVNu2/7DVDog5SE3zONUgRPlvxYG2iw7uh+5vd8Hs43XjJ9Qv
 Ch3L49FDd4gdkZLsirmcCga3OoECtxkAwn+E+6C88yLG2yySDyDAAR2vMM+vGhPUxeF8gngYr
 F0cltpjl+b6+o6Ag9GmfmDdffNhD+2sPc30yQ7Fw2j7L/xVrYo4XZmk3IFmVMqD+vtPfcbhX6
 Rl/rN9Y3TBQnVJJTMHGQ3yL7Wz9NqYlmfUKyRJWKOTmtWbcCsoXo4X0/wTVCxvfxmKEsCjldz
 e/0YJbXhXQpNB/PexydHLLxFKdLKDnuO0IhIxPHcySypZO0+u1wmXxTrlQ5hdo2lpiTLm6dx+
 x3yOm5Y4BINwh7zr90GwsLgBkupb4KgY0PpO0/XSoPpSPa4tHRZXPhc/H+yaJMYCCS1UQkny8
 7ju2x30PMBkhLuaVDOqwq+YmGiW76YXnd7olW+d6pvAOw8bb5dbnAVR5IOoLGKQboGGta8uY0
 aPHtMixGNDu0eGfFC1k89qoVYZLnomcKRQ1sKKdj7GpQKCmzyMBdSmcjX6EdMx4qi4oSXBzmx
 mbmSBMk0/K30MAdCmtzjLPZQ==
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:20 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am Freitag, dem 10.04.2026 um 13:20 +0000 schrieb Ostrowski, Rafal:
> Hi Bert,
>=20
> I identified root cause of problem. I had to do modifications to mention=
ed patches to work well with PREEMPT_RT enabled. I tested it on my local m=
achine and it seems to fix the problem. Now it has to go through internal =
processes. I will let you know if I know when fix will be available to you=
.
>=20
> Kind Regards,
> Rafal Ostrowski

So it seems that commit
8bf0cb97edb6 ("drm/amd/display: Move dml2_destroy to non-FPU compilation u=
nit")
is the commit that fixes the issue, but is missing the appropriate tags:

Reported-By: Bert Karwatzki <spasswolf@web.de>
Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Pa=
rt 3")

Please fix this.

Bert Karwatzki
