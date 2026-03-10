Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF476FD0650
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 08:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA2210E82A;
	Wed, 11 Mar 2026 08:09:31 +0000 (UTC)
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0DA10E261;
 Tue, 10 Mar 2026 13:57:39 +0000 (UTC)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 by mslow3.mail.gandi.net (Postfix) with ESMTP id 06633580A87;
 Tue, 10 Mar 2026 13:56:04 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 539B3433BD;
 Tue, 10 Mar 2026 13:55:53 +0000 (UTC)
Message-ID: <375c7c30c184d331c199876e45920976030f3cbc.camel@hadess.net>
Subject: Re: [PATCH 25/61] net/bluetooth: Prefer IS_ERR_OR_NULL over manual
 NULL check
From: Bastien Nocera <hadess@hadess.net>
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, 	linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, 	linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, 	linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, 	linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, 	linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, 	samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, 	target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, 	v9fs@lists.linux.dev
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
 <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 14:55:52 +0100
In-Reply-To: <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-25-bd63b656022d@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemsggrgeefmegrieejieemtgdvugefmeejrgehfegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpqhhiugepheefleeufeegfeefueffpdhmohguvgepshhmthhpohhuthdpnhgspghrtghpthhtohepheejpdhrtghpthhtohepphhhrghhnhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvu
 ggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishhtshdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrh
X-GND-State: clean
X-GND-Score: -100
X-Mailman-Approved-At: Wed, 11 Mar 2026 08:09:27 +0000
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

On Tue, 2026-03-10 at 12:48 +0100, Philipp Hahn wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>=20
> Change generated with coccinelle.
>=20
> To: Marcel Holtmann <marcel@holtmann.org>
> To: Johan Hedberg <johan.hedberg@gmail.com>
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0net/bluetooth/mgmt.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index
> a7238fd3b03bb54f39af1afee74dc1acd931c324..06d2da67bbe14e17ee478aa939d
> e26526c333d91 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -4169,7 +4169,7 @@ static void set_default_phy_complete(struct
> hci_dev *hdev, void *data, int err)
> =C2=A0		mgmt_phy_configuration_changed(hdev, cmd->sk);
> =C2=A0	}
> =C2=A0
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -5730,7 +5730,7 @@ static void read_local_oob_data_complete(struct
> hci_dev *hdev, void *data,
> =C2=A0			=C2=A0 MGMT_STATUS_SUCCESS, &mgmt_rp, rp_size);
> =C2=A0
> =C2=A0remove:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	mgmt_pending_free(cmd);
> @@ -8277,7 +8277,7 @@ static void
> read_local_oob_ext_data_complete(struct hci_dev *hdev, void *data,
> =C2=A0				 mgmt_rp, sizeof(*mgmt_rp) +
> eir_len,
> =C2=A0				 HCI_MGMT_OOB_DATA_EVENTS, cmd->sk);
> =C2=A0done:
> -	if (skb && !IS_ERR(skb))
> +	if (!IS_ERR_OR_NULL(skb))
> =C2=A0		kfree_skb(skb);
> =C2=A0
> =C2=A0	kfree(mgmt_rp);
