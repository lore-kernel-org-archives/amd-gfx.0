Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A76C44500
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 07:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E1710E699;
	Mon,  6 Jul 2026 07:20:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="vLLAHaWw";
	dkim-atps=neutral
X-Greylist: delayed 311 seconds by postgrey-1.36 at gabe;
 Sun, 05 Jul 2026 22:50:48 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9965610E276
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Jul 2026 22:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1783291847; x=1783896647; i=spasswolf@web.de;
 bh=IU3tSUq2jRftD+6O90sMRzR5hGEK1EC6I4FopZftc9s=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vLLAHaWwaoZLedP5UEYq4s7YbYCHyvhSfFaNHlec78OWOm5IqhH25nM6v6GkZb95
 Hijw2Rwlw3ZkrGIb8XnKfk5Kt5151hiTvEVLvf4ws3Vl75x8WahCa/GTzAGTDlYQj
 G6i6NwJEyiVaQptJZAAuUSEWopeX+N3vBna24LzmfK/GlYRLxkCnaX9DIgQ00T6qp
 5uvSuvp2p0Bry34mhu+RaFINtfQ/JVa99QXcZZEO3keb5y1yD9d+Ibi8ntBUoDVat
 gq2Uk91TcWumbmY2rGKtOJKu7loeuEDr/aDLjof0/QbOf3UyymjG8GW1okQmzm+jE
 SRzSQfPavFWIrTji3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcll-1wbmWd1qdv-00WSKq; Mon, 06
 Jul 2026 00:45:32 +0200
Message-ID: <e3b04980fd0bc7a6c3edfcd089e8fb4c559bbf38.camel@web.de>
Subject: Re: [Re] GPU reset when running the ROCm hsa runtime tests on gfx12
 and next-20260701
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 linux-next@vger.kernel.org, Jesse Zhang <jesse.zhang@amd.com>, Amber Lin
 <Amber.Lin@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 spasswolf@web.de
Date: Mon, 06 Jul 2026 00:45:31 +0200
In-Reply-To: <20260705003504.31425-1-spasswolf@web.de>
References: <20260705003504.31425-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/0Sl+SQ2DLJBteyJ9828v6YpdrH+Hb9TebkksLq2iYnrlDMzgPp
 8W3yWIEcTCLsXtCvdsXafwJg9ZLXR8Z9vT4jufGHp3iorEwAFMggq9fEqHVEBuJlZQSkmH6
 wldX6DMBd79LVmb3zzd7f976NDhUJ+Fen/eX44CVGFl+41Xo725ZCY3bhQRqCOqzxItZZL5
 oUjKHF8JT37qIyOY3jqJw==
UI-OutboundReport: notjunk:1;M01:P0:sYRd1mRmpLY=;tv1YItKItMsKnyP3ZiW9klauRu6
 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
 kuWMzA==
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:20:18 +0000
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

Am Sonntag, dem 05.07.2026 um 02:35 +0200 schrieb Bert Karwatzki:
> I identified the problem in =20
> f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute rese=
t")
> it's reset_queues_mes() being called unconditionally. f94bbd648bb4 can b=
e fixed
> like this:
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6054c8e216b8..ed1ffa8b1743 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -484,15 +484,18 @@ static int suspend_all_queues_mes(struct device_qu=
eue_manager *dqm)
>  	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
> =20
> +	r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
> =20
> -	if (!reset_queues_mes(dqm)) {
> -		r =3D 0;
> -		goto out;
> -	}
> +	if (r) {
> +		if (!reset_queues_mes(dqm)) {
> +			r =3D 0;
> +			goto out;
> +		}
> =20
> -	dev_err(adev->dev, "failed to suspend gangs from MES\n");
> -	dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU r=
eset\n");
> -	kfd_hws_hang(dqm);
> +		dev_err(adev->dev, "failed to suspend gangs from MES\n");
> +		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU =
reset\n");
> +		kfd_hws_hang(dqm);
> +	}
>  out:
> =20
>  	up_read(&adev->reset_domain->sem);
>=20
>=20
> But when I try to fix next-20260701 like this
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5c9dfb0c424f..5a78b1504f8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -493,7 +493,10 @@ static int recover_bad_queue_mes(struct device_queu=
e_manager *dqm, struct queue
>  	if (!down_read_trylock(&adev->reset_domain->sem))
>  		return -EIO;
> =20
> -	r =3D reset_queues_mes(dqm, q);
> +	r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
> +
> +	if (r)
> +		r =3D reset_queues_mes(dqm, q);
> =20
>  	up_read(&adev->reset_domain->sem);
>  	return r;
>=20
> I still get GPUVM errors (but no GPU reset) and when running
>=20
> $ /usr/libexec/rocm/libhsa-runtime64-tests/run-tests
>=20
> [  146.577245] [    T418] amdgpu 0000:03:00.0: [gfxhub] page fault (src_=
id:0 ring:157 vmid:0 pasid:0)
> [  146.577247] [    T418] amdgpu 0000:03:00.0:   in page starting at add=
ress 0x00000000002ba000 from client 10
> [  146.577248] [    T418] amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_=
STATUS:0x00000B3A
> [  146.577249] [    T418] amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID:=
 CPC (0x5)
> [  146.577249] [    T418] amdgpu 0000:03:00.0: 	 MORE_FAULTS: 0x0
> [  146.577250] [    T418] amdgpu 0000:03:00.0: 	 WALKER_ERROR: 0x5
> [  146.577250] [    T418] amdgpu 0000:03:00.0: 	 PERMISSION_FAULTS: 0x3
> [  146.577250] [    T418] amdgpu 0000:03:00.0: 	 MAPPING_ERROR: 0x1
> [  146.577251] [    T418] amdgpu 0000:03:00.0: 	 RW: 0x0
> [  146.577606] [    T418] amdgpu 0000:03:00.0: [gfxhub] page fault (src_=
id:0 ring:157 vmid:0 pasid:0)
> [  146.577608] [    T418] amdgpu 0000:03:00.0:   in page starting at add=
ress 0x00000000002ba000 from client 10
> [  146.577609] [    T418] amdgpu 0000:03:00.0: GCVM_L2_PROTECTION_FAULT_=
STATUS:0x00000B3A
> [  146.577609] [    T418] amdgpu 0000:03:00.0: 	 Faulty UTCL2 client ID:=
 CPC (0x5)
> [  146.577610] [    T418] amdgpu 0000:03:00.0: 	 MORE_FAULTS: 0x0
> [  146.577611] [    T418] amdgpu 0000:03:00.0: 	 WALKER_ERROR: 0x5
> [  146.577611] [    T418] amdgpu 0000:03:00.0: 	 PERMISSION_FAULTS: 0x3
> [  146.577611] [    T418] amdgpu 0000:03:00.0: 	 MAPPING_ERROR: 0x1
> [  146.577612] [    T418] amdgpu 0000:03:00.0: 	 RW: 0x0
>=20
> This means there's at least another error in these commits (reverting al=
l these in
> next-20260701 fixes the issue)
>=20
> b789664e3e30 ("drm/amdkfd: Clean up suspend_all and resume_all mes")
> a665d09b10af ("drm/amdkfd: Pass known bad queue info to reset")
> a4e4d945cba8 ("drm/amdgpu/gfx: defer per-queue helper_end until after ME=
S resume")
> f401a2633e02 ("drm/amdgpu: Remove faulty queue before resume")
> f94bbd648bb4 ("drm/amdgpu: use a single entry point for mes compute rese=
t")
>=20
> Bert Karwatzki

These GPUVM error are introduce by=20
a665d09b10af ("drm/amdkfd: Pass known bad queue info to reset")
and can be fixed by a partial revert. a665d09b10af can be fixed by

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drive=
rs/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0d95dd941129..0c49fe95a75d 100644
=2D-- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -491,15 +491,18 @@ static int suspend_all_queues_mes(struct device_queu=
e_manager *dqm, struct queue
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
=20
+	r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
=20
-	if (!reset_queues_mes(dqm, q)) {
-		r =3D 0;
-		goto out;
-	}
+	if (r) {
+		if (!reset_queues_mes(dqm, q)) {
+			r =3D 0;
+			goto out;
+		}
=20
-	dev_err(adev->dev, "failed to suspend gangs from MES\n");
-	dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU res=
et\n");
-	kfd_hws_hang(dqm);
+		dev_err(adev->dev, "failed to suspend gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU re=
set\n");
+		kfd_hws_hang(dqm);
+	}
 out:
=20
 	up_read(&adev->reset_domain->sem);
@@ -3239,6 +3242,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *k=
node, u32 pasid, u32 doorbel
 	struct kfd_process_device *pdd =3D NULL;
 	struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, &pdd);
 	struct device_queue_manager *dqm =3D knode->dqm;
+	struct device *dev =3D dqm->dev->adev->dev;
 	struct qcm_process_device *qpd;
 	struct queue *q =3D NULL;
 	int ret =3D 0;
@@ -3260,6 +3264,12 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *=
knode, u32 pasid, u32 doorbel
 				q->properties.is_active =3D false;
 				decrement_queue_count(dqm, qpd, q);
=20
+				/* this will remove the bad queue and sched a GPU reset if needed */
+				ret =3D remove_queue_mes(dqm, q, qpd);
+				if (ret)
+					dev_err(dev, "Removing bad queue failed");
+				/* resume the good queues */
+				resume_all_queues_mes(dqm);
 				break;
 			}
 		}

This does not work in next-20260701 as commit
b789664e3e30 ("drm/amdkfd: Clean up suspend_all and resume_all mes")
removes resume_all_queues_mes().

Bert Karwatzki
