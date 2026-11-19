Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65331606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P8RkMAj7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDEB31122E2;
	Thu, 19 Nov 2026 11:35:22 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00D6B1122E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:35:15 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so30284055e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088114; x=1795692914; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OyRTnHYjDnVSWxiHULkqZOhih9WUGVcNgHDbxVDrNPg=;
 b=P8RkMAj7ir3Jn02k3/UCf8jjKsYOyRFgK6Kb7x1dAHoYBgYGc0ybBCjNfHRQ5TbG2t
 S/CnpSzQxy3dCEE1JoKMDyHfrC17f1TBpD3onm+zmhofVFkKv4OPU7Ay4U/BDcHKE+7x
 DdWaFILPjFUrYwUAepDvf0m2I9tZjrlYZmb/zJUlcbytqjO+Q30IH9VkzCIksdssvoH3
 Zic2R1HVhEr+LrrDGLXbx3UFqr9Dz5UNIonq80bVzW+efog7d2rrTaTbLu0eqnaqSxKZ
 7IDwRwJ5e/x+RzP6QA3GeDS8kTp1jwe84SM1fvHzFtf3HSnEn0UoEgm8jrm7OzsChlB3
 EMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088114; x=1795692914;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OyRTnHYjDnVSWxiHULkqZOhih9WUGVcNgHDbxVDrNPg=;
 b=i1BSYCoejhter5Jw4o2+fSUMFgmkYSWFbdrOkCWwyXaAnKDnrt0wXP4zbKj1lHADOE
 rVKnjY7eVbdGgW6Gu0moj3H82LPVNJTQ2dglBGoVfFrzYI6xDWw5pLcClh4ckBFaQ+wg
 +QFa7DIVWaJSwCGekPVWRkcKFWOpVeYY6EbdBn/N5ObYjTEsVvabAgk/ZTe9QNg0ZOoq
 rP8xySI/Ph4gHITPX7Gxew5Gh8m6aHtFtU3nylBo2e041Af0350RcWwxLjFsIeJNqBm9
 hYd32Gtf9mln1AGx1Kbx1c9SCWIEZUoNWnKCOlGv8z1WN0keqAess7hZt3LmlQn6J4sr
 fFYg==
X-Forwarded-Encrypted: i=1;
 AL+hErHrXVg8jlGUiDHv0QbfwWpwlPJIxCBiByZQIueptsYJIUTaLIZ8+bNNSZh6iruSfUigC2SdRZDC@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+wzG4E0EcS8XSn5p4m8XiWKPekWztgFiEY+uKSNuq2uj/hhkcL
 Av3/ysxmTu8+tbVJ37k6AVBxrSVQ9QGObsUt0e6ZkiC5yz97ZfQNowGl
X-Gm-Gg: AYBFou1SQOhdnoAA42+5xD7vK6uT5TVfYNddvaQ9M+fFzVT1LopL6NA6pwh/gXt6eje
 mWzTa6SBFBzO53qReZUXQUbEAVTJUYQcJdulvqwDm8EF085QUtvUhRuljHhxg6aogSp4kNjY1ts
 4XSpvcGexZztyl9uY3l+edC9utMGV4JNHHEqkfL0CnbEt4ReM5rQ9y5P7tAV9l99+EoUxpBE131
 uUSesyWfM+FY8WCTAcZb+iuahO7z/bcdDb1jI0URGMqKIbNaDyCdbX94MAng6BiI+Q9ecgtNR19
 vlKpBBxklxfoIsL4EEvM0KecsWznXZNs4jPqg1NM8LOdq8zlBDV8gcpVmaMdPvDNnuiWYxJx8Cd
 enKa4W8VyKRTiyB9ms1KnkiY4Eteu3bQtcBdxnKCtqu6z60X/Be96Q3ZFPzfrQe/NzxRI3MKSwS
 iuandaK5rYl+nUtjxot8SIzzMA9uxhcaeSgVaCCrQFJu1LhkvjVsRIbrKvlRqexi5kLO17oG6A8
 EJdae7AIR7MxycU8C1RS/GVses+Lb13c11wZ8r+wE0hZFYR+8QfHa6W4Pn9Lm1jl5S9DeinKidy
 g4Hfs6QYnooLt/t76Wpe6Wtg7xQm6dHx2DrV+gIi8NlKmZfo5gU+aXfaj4F/IU97I5zPyMX3g5+
 +nEHF
X-Received: by 2002:a05:600c:1c1f:b0:4bb:6847:7943 with SMTP id
 5b1f17b1804b1-4bb7da28927mr126326215e9.26.1795088114152; 
 Thu, 19 Nov 2026 03:35:14 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654997681sm7943426f8f.15.2026.11.19.03.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:35:13 -0800 (PST)
Message-ID: <d1e6815abbda0bc380daddffa7bf1846b0a44b1f.camel@gmail.com>
Subject: Re: [PATCH v4 04/13] drm/amdgpu/gfx: add callbacks to save and
 restore a gfx HQD
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:35:12 +0100
In-Reply-To: <20261105030612.726542-4-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-4-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> A gfx engine reset clears the HQD registers of the gfx queues,
> including
> the only copy of the ring position of the queues MES didn't preempt.
> MES doesn't save them in the MQD either when the engine hangs.
>=20
> Add struct amdgpu_gfx_saved_hqd for that state, and gfx callbacks for
> the gfx IP, which knows its registers and the layout of its MQD:
> - save_hqd() saves the state of the gfx HQD of a doorbell;
> - restore_hqd() writes it into the MQD after the reset, for MES to
> load
> =C2=A0 it into the HQD when it maps the queue again.
>=20
> v4: Rename to save_hqd()/restore_hqd() and struct
> amdgpu_gfx_saved_hqd
> =C2=A0=C2=A0=C2=A0 (Timur).
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 22 ++++++++++++++++++++++
> =C2=A01 file changed, 22 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 5939e1fb3b24..1c23e97fd04d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -345,6 +345,17 @@ struct amdgpu_gfx_shadow_info {
> =C2=A0	u32 eop_alignment;
> =C2=A0};
> =C2=A0
> +/* State of a gfx HQD that a gfx engine reset clears. */
> +struct amdgpu_gfx_saved_hqd {
> +	u32	doorbell_index;
> +	u64	mqd_addr;	/* the MQD loaded in the HQD */
> +	bool	on_hqd;
> +	u64	wptr;
> +	u32	offset;
> +	u32	csmd_rptr;
> +	bool	connected;	/* the queue the pipe executes */
> +};
> +
> =C2=A0struct amdgpu_gfx_funcs {
> =C2=A0	/* get the gpu clock counter */
> =C2=A0	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device
> *adev);
> @@ -376,6 +387,17 @@ struct amdgpu_gfx_funcs {
> =C2=A0	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
> =C2=A0	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32
> doorbell_index,
> =C2=A0				=C2=A0 u32 *me, u32 *pipe, u32 *queue);
> +	/* save the state of the gfx HQD of a doorbell, if it has
> one */
> +	bool (*save_hqd)(struct amdgpu_device *adev, u32
> doorbell_index,
> +			 struct amdgpu_gfx_saved_hqd *hqd);
> +	/*
> +	 * write the HQD state saved by save_hqd() into a gfx MQD,
> for MES to
> +	 * load it into the HQD when it maps the queue again;
> +	 * true if the work up to hqd->wptr was dropped
> +	 */
> +	bool (*restore_hqd)(struct amdgpu_device *adev, void *mqd,
> +			=C2=A0=C2=A0=C2=A0 u32 ring_size,
> +			=C2=A0=C2=A0=C2=A0 const struct amdgpu_gfx_saved_hqd *hqd);
> =C2=A0};
> =C2=A0
> =C2=A0struct sq_work {
