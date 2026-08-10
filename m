Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11A7C5B56A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 13:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0580910E872;
	Mon, 10 Aug 2026 13:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="FB5rR/+5";
	dkim-atps=neutral
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB1B10E7CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 11:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1786361270; x=1786966070; i=spasswolf@web.de;
 bh=b46wsTJjy/Jjj97yBvBbzCH/gQQvVj+KrXCTFD/HQHU=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FB5rR/+5Hu37h6JNHRK+ctB84vUpCuUZSuLfxbewww5mZj8pq4FQDlAnvayzYuxv
 pAbDdi6iYOM73iYdGeo88kaeD/Iy0pBMGw4PjCgFZ78yZVqt7ovnNj+u2i/jzDvBh
 IOejRwBbdo8Py0RGTFN+5cNGAFbWr0smLI3Ggm9UiHJPWaUlu1XfW4OaAm3iE390d
 eO85TaRlY8iMJ3jo+pVWNAPXIUD94XuoX+GePn2fPOoU9jBGkuw5pcqEx+QvwU9ZW
 lMbW3nwDhj1qx/7YdQg+eXhH6gClaj9Tkon0T3AaG/usZsno5twIfB566dRaM4xYA
 InWhFd5B3vWTgWFJFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1wXALn2ulV-00LXk2; Mon, 10
 Aug 2026 13:27:50 +0200
Message-ID: <6e837ba2419216d9d142766a13f3947fbd456dfd.camel@web.de>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-next@vger.kernel.org, Jesse Zhang <jesse.zhang@amd.com>, Amber Lin
 <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 spasswolf@web.de
Date: Mon, 10 Aug 2026 13:27:49 +0200
In-Reply-To: <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
References: <20260705003504.31425-1-spasswolf@web.de>
 <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
 <b5f93060955a72a358bf82406eda866f2c5cde56.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JOXdFEdxQ20qpDtYFBmK1S5bLpZ70NPOw4lw6lsHh3jx6Hm7Wrq
 IQ8Pc5hcG+XtYgE3XPfJnTXf84BX1RvO+Zds9ww3pwu8RvkMBds3NfuKAKKduGFomanWTKW
 dMX2JaVU7aDGjDo2j4/f/Dtg1lVMqScTXeABH+UBi697+vjwRDrxjzI5za2Q8UahH/D8GJ1
 kPyXrpbCWsqAJ4AtE7Qlg==
UI-OutboundReport: notjunk:1;M01:P0:7wqwqqM7WR4=;Lgg2Z7I7b5xK2W6HUnIKlMP4JiB
 cu6EhKqr8PquZyzV04MTgUI35m/rV/wc0fgszZs2bHkwIN/ky4VCAW5ibJ/famuLYsxD5v/S2
 bJT8fOsDPP9LYA4+I8+3OZxpSlqtw58dYrZD0hPT8GGETnr9i9jUL06FlsUSEjcgBR1K6KAne
 X4OGrDQmmjHYCMeRA2ajyXS6Youq1C3d9zuI3eICMeD2ofFV4eehpXSWB/Av5FDUrYi0u5+o4
 KYrVapnzlLRTiRc3B9RWwc7js5Jzc3Z2id30lBQ7d80d7DVnmm3k//gGf/QiDc56wZ3o4diRa
 YbZv5Me2Z99qXbm/kgoXCTy7E8oPa+5dWyKKkxTcPizvi3j9a9/9ab3e7fJfq1u9PfMlagzwC
 xUHZPqEm1pyg1IHdj4bojvJSSGx6r1zhRPhf+vSDtSRHd8uLKE2/cGbOcO7dLSW86tKq2yt5R
 ovKbalYF5jg3fTDnw8mCDNsdI5MchsFv3UJ9HTzJkKPBIRjL/vvXtdtcu9A9B1YiwpS3t0Vp/
 hSEf90i74gRR0J0E/5Qf1vcBRAhOApiQBRZq3SzhYmCI9VgZvzoU0S2b1rHLky6LtBvVKrJjj
 DR7YLcSM/PocL8pbBEVUEMZi5cUZ/+B0N8vi7GudlR6L3ElYBOxq1CoCg+jumA67B9ymG1Ryz
 3B+9YHl2Ct5gqEh2vuzcSNtAkr4qxdFAwZcZmUjzvvOPsTeO4MIvWoQ5GIHXqMx1G3FWVelgP
 5ktMigaJfWaMqNVB1yaIMRFrJcwEv4Z1AmWCXCELRG/XyoGbA+ElZ1bYZKUe0h6p2SMBliVxZ
 vtecOvn6tcKMrjsmgpTC/FBpV4qZrQWdvPKs1MUfEKprkdA+kyjOM9vvUUw/e2/0PSPHY3Kd0
 pGJgDaLcQbaXAVzURprcf0i5zqiPX6nUQtIaKJ6DI6fkCYY8SJLsPeQ+8N4UPVrWFDl7veWjV
 mz+L418ss+5ohm5jxY+bZgXxsKslZeISOO5F3RCL/pP02fJndtaHIHvN8+sWYOwhK7BVIiG0X
 PtAOSQZWbioJKopwjRsYPIyq+32omlHMnaSvV1CTiXHpMxeXqYGfjdTYY0E0ta21mzc2rzrpa
 auyx9X3/CoUnMloOYFAvlJ3h8W2k9r1Ah0bv/dznV0pOeEh2tA7wH2ll1tk4M1RBguWybBMvp
 3h8wcW3h0a5oF2jUwZHVlQzePf6eImVBw0IirVy3EF2UXJAg/DJKsr/3DxIT068djy0AZAaij
 E37XCkWfPjWpQlNjIP0esOSXcBKOy4zpQzrui4hMesJC6cDBQSQ69NDWgfi2Ye7GPMjXGTl7b
 K68hm8N+2JGrkQ4FsZHVjfNOHhNaT1SdUB6ocElT2wwrPqz3f2Z+DkPlR0zfESle7LwoDBLrQ
 Ex+QtFsTolf5G5wKBdmHpjdmKh4iVTGjFNQUy0BehvHjlEP9dy37GlTsfNBUNo2UTdbI7mroF
 zR27DzDzxXWQNKdxzSVw22cfh1Pi45k2TrRnGkXUcxrzIpVxVqN7oosHhW4zoK9TXX4+TRd3t
 YNDWUC3orkEJ9Ny/K+t9iWlGpPd4aD/0bkNRmz9l8ecwnMS2wj4uz9/VigL3N6hUJYxXD7xgi
 vV+3SQvksdJTruyDNnjd/C7ywHB6w045OO+ecLgEVI2UWTKC4lG53x/PLusSnsDhD9clzdt3x
 W2xLRvpGq+b0zagKa8dpEKXgyeuNwIokiXAkoCWVuthigckrQ1FxFsZAckGE1uu0uF6684WM4
 NUXpc66SHkzD9Xv8N93u9Ozaj888wjTr5x3aOfJqtaulz7AQBN3UWJiCVhRzviJN6ha0rMo6p
 WRWhwDnccww80wMzrhnP6HUceKF8NdEocLKHI3BblcpP6uBQ3eOFrX3LbkCOXy/6F3ki+l8aF
 2Yc2Gg4DVUnNqmNxav4NjRtmHZJia1LRcuv0hyrnnNDwJFF4sSmufKhTcHpSsjkGjarYue6OZ
 P85TtgYH9vyCXYeI5Szl0uqYlEfVgAFAnUU7R3NyMvEK8vTYnFlPqV9booKQK49ka05F38hjZ
 GNVr8fOOLa/Xlz6iNI5ZvPza801tLyxEFb7vp8hzcd7XQvLN7obkQnnHC4ZB0TlDsqx70a5Dt
 oLdQA3esToUfDrmxNqmQo9LrfFQIxUXeV3ZNvcpR/DerlZCCsokTfVdBKC9HtC7s2xJYfTaLg
 2VK9KQ9kGU6g8z0Fk8QrrH0NtI8uMcpEFoeCk0vDmyX7Qo3w6exmWT6y9Hus+z2ZW+F8lu62t
 icNXBr5jCJ3CMEqebisd9bE2vxXg09qsEsYQCf0JNJtf+5iz+X276Kjy+BxZ6MSVO4AZ3MbFp
 uclRdDPojG+xLHk9BfgILQ3UFieFtHxswrmrdiNNZBykbeYWB52TSXOVPd5Gze/1PgUBZvAUc
 lWV+GO8A6vKS80/e8kv3BXQe42aDG+tiyA9lVnQ9elyntnOWOY5qVyLg8ja/MaiYjAQ1tF8xN
 wfhVwBrcLmkbt0BFUZmnFC1ixEfVhuG0FwNgWEyY5fvIdsJMyvmG00UGa2rkI1WWl9BKCMm45
 5Gx+pDVv9w27lWApks2LzKVVAhSUQU0pxuv/so4rRdEVaScNDvh4xftseq4vrwtM0MflHQD+p
 WCfLDPUTrdDeEy8G3DLHgtx/rBDZFXYO05c3uBo4uYCfcDL74TnmU0ybFjYwWQPAZEZt7mdtp
 AZx9UdoZtGrJIEB+sZoEAX0iBf5NkKlOoti0BjWX4XjvHW2PRaa1lUrgzsM/HI8uyqzmeIBBR
 hHQ2vbpCURfooMrQwV06qN06TVRLya7/WE216ZpQfJ08fzaTZOMAjztMv3Ej2Ck85M+sob69n
 +SvIRJPK7I3hQQRn8oENU/3X8cKnONLiq8YjNhZ9NAzb9Ik55Ztq48AGeu3OsZ1KCN3Nwmt/o
 zaXh/OFbZNKPd8/rs+qFH9x2Nin3vYq++jMXCYNROmb8FV+OgaHwdWXy1SUBdIXWVcGK7tXks
 PwmBCs/pDno2ZKVsWdKfjd92Flwj4bTlrn4FCaJTwHHQg6P3+vjiYoLPxOhQszsovxEqLB8n3
 RJENUodXPN5HTFR03vcBpMLiJrSwDo0mVAhikKD8qiEnzVr2eMXr8uAYoVLeKRgjwaUghenPo
 fVvsRidQMzIWwu/893fUHiLGRhJx+M5rZr7fhwxwcJ816z64It5accN+OMPeLUiVSGf21xUBa
 rucFJQfqLszJ68IzZiE9R1I1GMlDyKpnsBsGiq5Q3WNLzIvKRRvP6mLE5Qhni2OHyqYxb3nOS
 5giP1oG16hmMrd6g/Oquxzx6VIofzHOhWnPZ4DfKYMV/W66rW05OhD/uVLazcNUPogjD7EXw7
 3PNStGhWUNONG6/Pc1lYgMt4Npa2OjcZzlhd7alQpngLNGzBMWJ2kNq2dNRriraw9ZMU9DbLo
 Yf55q46YuETTCqa75cUwIL7qhhi2X8KoEd4dbG8GcraELg9cYujQnt/51wAlgsEikEIxoXZD3
 NEEUQVGqL8W8TmV6wKGrX9BO5ivdp2VcsPREydSOXFtg+r/V5hNNcxUlxTw5ad24Fg9YUL+V1
 JjXL+g1rxJnytHh1kMjpcP3nUk0h+EcAEnW9LZSYnaLC9xSOKkcQJQPAAZBbAhrBIEpHJrJXT
 qeT1atreP1FegSrqsBOKNyyeI8pWssPqEkURyeU6SSx12eaW9p0tATcBD24ca6pAr0GFQtefv
 /OM9zb5WMbmN83NQqnMOxdJeYD07T8GiACxiYolVF71NsGsLl/i8VRYQpThOjupnLomCv0epb
 p1he3SnpavpQwUwH9U/h8M7IWojST/QCZMsBRKIc4aGlIM8L5zOx4DR0PJF23MZDBi5J0tgpx
 HZ6R8WW12FdIwSCEs+Anb90PxUBB9yJm0Tx6ve3Og51vtCTFQ2ZjbOvYXCxrbD1Q3uNVPgLSW
 +cjcwNYsup04Fgy5/ykT9NtzETF2lDk/Vi3sYJMpFlKg5ENos5JMwfJesoFCDtaFrqqefrGXI
 y+MNAnyBIG1pORfiQBaEuLlUK7LiYvR80EuneR1toH4TdQIEA+81K31iZYQPzLapQrgyGWDsU
 P7FW50zaQhhmA3TKpiFGbweBsh/gmWE86x6XuY/o4NSq4TaweoSFF6yjzK07sJtC9/gn8zE/P
 catdDfH7/pHFDcseYpLZ8/CqQOxelAXN92DYdrCYJA6YqFx3YfwYwwuqLGVsIxm82C/vLQK1p
 c0VF8mqwnTlrvEzdtTM/3pRfm3wTpj36tdH8gyGPQk6Ys2FYfjBpVyCRayRy17yGep0WhQ/Gu
 eDSclXhX4bkC64GjJ51XqJ4ami7V3KQ3YzQHqcLD+vFEAXEaLeHqSjoW+iRVa4LEEdn5xzFVA
 j4Kjel0f1mCszGplnftfDCd7Af1wKf/iresFK/IR1MonbEsJPJrtg9ykzrJufZIFmhvC/4G5I
 /Vki0/1PDsO/DNCa5NAY7m1D+xNQgPduCEqEbiFLvhCGhnkwRHaGLzSNrL+zhN558+1KeXmyn
 FdUKpVYI452ui2U9pkKk13DJZtw7ZQ394eHlLZwXiUvtzV/HvT+cRpRoWYU4nscd4asJTIuZ+
 tEIixOJtu5pW2w5mVdrU4/+g8oc1dMcW9BPtAJCJTgguvX1xzOCJzTTKzuf5tJkszW62Jv35G
 j6D4EB3hXP9GC7aMECGAPJTDrd6VQ733+pyK7cH/1/MHP0ktj82qj/4ihWU66t+UlyDmRnI2W
 Ee/lN3vlpIZEkbFgnISb76u3vlL6uK6uroTmU6rfuJXGjWGLXFnMIcxtvE4Xsf4gvZYcLCUTY
 o3jIHs3ObX9PoYCDZGkkb0d4tg9+UGuiFZsxUq/fizY3gSCxVBsLRJ8Jc7v4IvTcxsD8JQrCT
 XdBcnpNzYoZzcNGxMXJi0HnH8KrOad1KuyF3UuNu/ZKE+FIH9k5hy2XLTAPJAALsdRLiME12g
 pl3HBO5cjHVrhZYRZIupC/vDCeF4dhMtj8gJfR59uTLwJxZ2u8qvLRZifMIg/AmI09K9P66ep
 738UseSvtGB+UN+GCwEKrg5q4t7f9ffNnPNTim61Lc80iSUM57KjZucO2wScmoBIpM6XYvnU5
 9VbiSzplhneyMGqSmTT7sGB8IpYewo3FraUPM83V1lNlPizK+ZstSyakiNeoZDLUgAZ752Q1g
 Vclj2gsCh1DizR55Q2SUjIRoYuR+KuB4bMFBElmKo3eHnP4PkK89g9K7XEpU+2sJJBRe/4PDQ
 XTg+C3VRnsNQL0hPfRGmbt0LxDonBzjBjWM2VG3zaBR7y3z02qlyucC8z9NzjnQYtdSEcdI+r
 1eKc+efvZh9y2bpcJTwrpNgzgrzS/R3aZCLm0hUGrL0HXhNyuW8qEszIIKLK65umcy17tMnG5
 XeCjkWSGVUCSACiXy7qG9LsUAzx/tGGWBjD83iortScrvrxUw4TnJomkTzVHzvW+M9weynxhH
 B9ZlO8ihpZlxeEWsLKyxjHHwxmtgZEL5tb78EeRPsGsDKB7oF7ic8ZwByDNrXXVnY4L2WT+1M
 +jva75yTWLx6IG1wRdabwyf8i0rF+NokG3oRzlx8GcXZ6tu1aox0X9C/vGMJJo4cPsDWPR9FJ
 kknKA9dogQvlmL/yWWhU7eOwf5CBaleUR5cRdbuyJM1m7cP79xBa/9YznHNabxp35LvBLX8Xs
 cX3lIzLKxCTUXeSqePzmJFxk2MQRS3483P7laBvHXW8j+aAjOur9GbqpQI7f1TcJ8oGsS0W7p
 DvRSWL1BCCu2M9uRjXC09fW+n2BwCti8kg7YPoaZvYlcrhv5TZ2BwOWXkC+FFSdSBl9HoHILl
 eKIpO47VGTAmOdhE436g3df56k3BdqoFFDLnD5SVJU9/OyvtWMZYMUQwbeoscvcIfXJHhRmmW
 H0VhvyYRZKbe2cvU8phpMMrbn6kB2Bg9NaH/uwdYAaaI7jR5ERixNgJrID//WUJUXpKFivsLQ
 AUBfH9+eQnRSMXRa4q5GGx8fUbcc3xuUyHVjnolTGrLA6MbnOxkE2PZG5M/epdS6iEI/lDiDB
 soEfbpLV5VlDW8MyjZTCVG4+w1JNrA3jtMB1+H70bAXAGeStGvKXWwzwO2PC/ZrfR88AmJwYD
 1MUtEh/IIPepOzWeS3KTsfdVvuJAHNsBmzOo3cFBhLpsb85qOnyq4tAJLuCanbXekQ78etmGe
 5xmAzD9OwlAnO+6Wrn7SYkY9kJPyoFXlg/vaayxhi3UmhM2y8F6DSU+y6UL85Q==
X-Mailman-Approved-At: Mon, 10 Aug 2026 13:34:45 +0000
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

Am Montag, dem 06.07.2026 um 14:46 +0200 schrieb Bert Karwatzki:
> I found the real cause of my problems:
>=20
>=20
> bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
> {
>  u32 ip_maj =3D IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0));
>  u32 ip_min =3D IP_VERSION_MIN(amdgpu_ip_version(adev, GC_HWIP, 0));
>  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
>  printk(KERN_INFO "%s: ip_maj =3D %u ip_min =3D %u mes_sched =3D 0x%x", =
__func__, ip_maj, ip_min, mes_sched);
>=20
>  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
> }
>=20
> returns false on my machine (because mes_sched is not large enough)
>=20
> [ T8549] amdgpu_mes_queue_reset_by_mes_supported: ip_maj =3D 12 ip_min =
=3D 0 mes_sched =3D 0x76
>=20
> So I skipped the call to amdgpu_mes_queue_reset_by_mes_supported()
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5c9dfb0c424f..462f20aeb681 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -448,17 +448,22 @@ static int reset_queues_mes(struct device_queue_ma=
nager *dqm, struct queue *q)
>         unsigned int num_hung =3D 0;
>         int r =3D 0;
>         struct mes_remove_queue_input queue_input;
> +       printk(KERN_INFO "entering %s", __func__);
> =20
> +       /*
>         if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
>                 r =3D -ENOTRECOVERABLE;
> +               printk(KERN_INFO "%s: reset by mes not supported", __fun=
c__);
>                 goto fail;
> -       }
> +       }*/
> +       printk(KERN_INFO "%s: skip calling amdgpu_mes_queue_reset_by_mes=
_supported()", __func__);
> =20
>         /* reset should be used only in dqm locked queue reset */
>         if (WARN_ON(dqm->detect_hang_count > 0))
>                 return 0;
> =20
>         if (!amdgpu_gpu_recovery) {
> +               printk(KERN_INFO "%s: gpu recovery not enabled", __func_=
_);
>                 r =3D -ENOTRECOVERABLE;
>                 goto fail;
>         }
> @@ -470,6 +475,7 @@ static int reset_queues_mes(struct device_queue_mana=
ger *dqm, struct queue *q)
>         queue_input.xcc_id =3D ffs(dqm->dev->xcc_mask) - 1;
>         /* pass the known bad queue info to the reset function */
>         r =3D amdgpu_gfx_reset_mes_compute(adev, NULL, NULL, NULL, &num_=
hung, &queue_input);
> +       printk(KERN_INFO "%s: amdgpu_gfx_reset_mes_compute() returned %d=
", __func__, r);
>         if (r)
>                 goto fail;
> =20
> @@ -3231,6 +3237,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node =
*knode, u32 pasid, u32 doorbel
>         struct qcm_process_device *qpd;
>         struct queue *q =3D NULL;
>         int ret =3D 0;
> +       printk(KERN_INFO "entering %s", __func__);
> =20
>         if (!pdd)
>                 return -EINVAL;
> @@ -3242,6 +3249,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node =
*knode, u32 pasid, u32 doorbel
> =20
>                 list_for_each_entry(q, &qpd->queues_list, list) {
>                         if (q->doorbell_id =3D=3D doorbell_id && q->prop=
erties.is_active) {
> +                               printk(KERN_INFO "%s: calling recover_ba=
d_queue_mes() for queue %px", __func__, q);
>=20
> and got this output when running the hsaruntime (which inject illegal op=
codes into the
> command stream) test:
>=20
> [  113.811612] [    T645] [drm:gfx_v12_0_bad_op_irq [amdgpu]] *ERROR* Il=
legal opcode in command stream
> [  113.811675] [   T2558] entering kfd_dqm_suspend_bad_queue_mes
> [  113.811676] [   T2558] kfd_dqm_suspend_bad_queue_mes: calling recover=
_bad_queue_mes() for queue ffffa03160950400
> [  113.811676] [   T2558] entering reset_queues_mes
> [  113.811677] [   T2558] reset_queues_mes: skip calling amdgpu_mes_queu=
e_reset_by_mes_supported()
> [  113.811887] [   T2558] reset_queues_mes: amdgpu_gfx_reset_mes_compute=
() returned 0
>=20
> So even though  amdgpu_mes_queue_reset_by_mes_supported() reported false=
,
> amdgpu_gfx_reset_mes_compute() returns 0, suggesting that resetting actu=
ally works here!
>=20
> Perhaps the minimum required mes_sched version for 12.0 can be relaxed t=
o 0x76 to solve this:
>=20
> From 6d7af652177063963012eb4df228e99caeb03b31 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Mon, 6 Jul 2026 14:36:22 +0200
> Subject: [PATCH] amdgpu: relax required mes_sched version
>=20
> This mes_sched version is actually enough on this hardware:
> 03:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [=
AMD/ATI] Navi 44 [Radeon RX 9060 XT] [1002:7590] (rev c0)
>=20
> [    3.200538] [    T537] amdgpu 0000:03:00.0: initializing kernel modes=
etting (IP DISCOVERY 0x1002:0x7590 0x148C:0x2437 0xC0).
> [    3.200546] [    T537] amdgpu 0000:03:00.0: register mmio base: 0xDFC=
00000
> [    3.200547] [    T537] amdgpu 0000:03:00.0: register mmio size: 52428=
8
> [    3.203739] [    T537] amdgpu 0000:03:00.0: detected ip block number =
0 <common_v1_0_0> (soc24_common)
> [    3.203740] [    T537] amdgpu 0000:03:00.0: detected ip block number =
1 <gmc_v12_0_0> (gmc_v12_0)
> [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number =
2 <ih_v7_0_0> (ih_v7_0)
> [    3.203741] [    T537] amdgpu 0000:03:00.0: detected ip block number =
3 <psp_v14_0_0> (psp)
> [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number =
4 <smu_v14_0_0> (smu)
> [    3.203742] [    T537] amdgpu 0000:03:00.0: detected ip block number =
5 <dce_v1_0_0> (dm)
> [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number =
6 <gfx_v12_0_0> (gfx_v12_0)
> [    3.203743] [    T537] amdgpu 0000:03:00.0: detected ip block number =
7 <sdma_v7_0_0> (sdma_v7_0)
> [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number =
8 <vcn_v5_0_0> (vcn_v5_0_0)
> [    3.203744] [    T537] amdgpu 0000:03:00.0: detected ip block number =
9 <jpeg_v5_0_0> (jpeg_v5_0_0)
> [    3.203745] [    T537] amdgpu 0000:03:00.0: detected ip block number =
10 <mes_v12_0_0> (mes_v12_0)
>=20
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mes.c
> index 6c0dde3786e3..c88fdc8a187d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -869,7 +869,7 @@ bool amdgpu_mes_queue_reset_by_mes_supported(struct =
amdgpu_device *adev)
>  u32 mes_sched =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
> =20
>  return (ip_maj =3D=3D 11 && mes_sched >=3D 0x8c) ||
> - ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x8d) ||
> + ((ip_maj =3D=3D 12 && ip_min =3D=3D 0) && mes_sched >=3D 0x76) ||
>  ((ip_maj =3D=3D 12 && ip_min =3D=3D 1) && mes_sched >=3D 0x73);
>  }
> =20

The specific hsaruntime tests which cause gpu resets on a RX9600 (gfx1201)=
 on next-2020701+ are

$ /usr/libexec/rocm/libhsa-runtime64-tests/run-tests --gtest_list_tests | =
grep Invalid
  Queue_Validation_InvalidDimension
  Queue_Validation_InvalidGroupMemory
  Queue_Validation_InvalidKernelObject
  Queue_Validation_InvalidPacket

Bert Karwatzki
