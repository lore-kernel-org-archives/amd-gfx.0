Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AACEC982FA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:09:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69BE10ED75;
	Tue, 22 Sep 2026 15:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T7DtI/Xi";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A902810ED73
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:09:10 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c254f55efe7so630376466b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790089749; x=1790694549; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PpSbZYptFP4jla/S9iDj11kgDYs0mqpDq3fzi2lyre4=;
 b=T7DtI/Xi5merR8h3mYESz4rC1MzUkTVg9XaZupWKMvugHt9TPio7ACPchj9Qfnf5kC
 s0WhKyD/69ZNvPxMCPzYVVQbGZqd0X2GQr1LtqWF30bza+7/CEr0PZ9ffF27ccy6kYqL
 d/mSmXmvYY7miFLcjYoEyFo+mNeXuz67w+PjkfOJBOoqZhpvk+FvOMF+crIpslynaED6
 Ioe54iZM9liwfgaQZVqOIsuAnP1D2R8H2AfzYGFO9/L7QB6T8lnbzJbngLeav+l7Asi1
 pJh7TWfuHXtjQ3fQspWeIAHd/H3mnZ0o37pa7cL/sj0J6zEww/uhvUCIJr8oWHw+8sWi
 R2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790089749; x=1790694549;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PpSbZYptFP4jla/S9iDj11kgDYs0mqpDq3fzi2lyre4=;
 b=fjynjDpz6HIi1e7XsfDDWR1qBubQ3LGqKi5iIlIlDfJYBI1ivUOE9klfLNFutgC+oW
 0wkVw4oBCi1xb8hhNoNp9q20BaJF5UVy/cFRPJOu05GnX25hKeN1K9lq5vpwMjCwSi1O
 cBmz/6CnChXkFVNHt+SP9phZ/ZILR0F5Pibl43bfoJnPIbdtdVD93q2WF3TUhy1gDm6O
 Mu87yogjmiWqjS3DnA176aIVhRw2gN5TgkOGUqGK6p0k9Blh/EjNdZcGhEk3M+C7sSet
 7sVaFmrtAJYtfFpfCp/zZ497rikkxmpDMeqtpirDwZdtnvxnjcqcTJtS8dCHBppzS2ZK
 8L3Q==
X-Gm-Message-State: AFuF++mk7JkQ4VOBcsFSkZrpComdCGHa04XnzONKXjDqpEZvVgbBczMf
 yghEn+dgMHnc+lxIQ2+0XmXpftGdrsFpRC4YD03BcLIU806yysZW0tw/iQ5stg==
X-Gm-Gg: AYBFou0+2WmEiAUAguB9T6X/fZLmX/394cozuLi7Sa6oFKzc+EVwhrYJUFRzBweKTIC
 XnRaIeOMeiDwTnxGtA4/C9niV+9gRdUAgZ/yu4j66XsTRM2RoJsW2nRe6tahoWHEaMaD8DNRBOM
 zVCBFlxJROLfoL7pC+YCc5/ml2POeuwEbFpVQP2SVdSYomn251xRREDfRE6sUMqNg6NJZNOQp84
 HzCMzwspHwLwdgMnTRJpoLv16dBZ/GpsZ2nkQCQ1+AkQjAbjjwUQqJ1aYMrtSVmAor8uYquoPTu
 JNcTYTrF5x29Qk3fjDfOKyUYEBIoZ7dU0cwiFyvl6ZuqYRWDoSq9W2k3To8EwpY96NlT9HcOHxq
 de4lmGGGDwbPLBhhP/5XmUdHTNdL+j9D9Xb/hrFwC2szJadviOE9C0YjkArHC2+ix0Hsbv1xDbg
 C/dxcJslWn2hAmJN2eCRWIspnLHf8Jo9KJTDVKK1cl9PiJW0oi3dvWE8/fEYXvHqAlv+M6LqYUy
 Ff0Yf1GJKglB2ZNcwgVAieDytvhxlc1xCPx6KcUQxwdwA==
X-Received: by 2002:a17:907:9810:b0:c26:3566:5b47 with SMTP id
 a640c23a62f3a-c2a1569d5femr1336347166b.12.1790089748785; 
 Tue, 22 Sep 2026 08:09:08 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c647c3dsm110958166b.63.2026.09.22.08.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:09:08 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com
Cc: jamesz@amd.com, Bing Ma <bing.ma@amd.com>, James Zhu <James.Zhu@amd.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
Date: Tue, 22 Sep 2026 17:09:06 +0200
Message-ID: <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, September 21, 2026 10:03:02=E2=80=AFPM Central European Summer T=
ime James=20
Zhu wrote:
> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
> UAPI for GPU performance monitoring features such as SPM (Stream
> Performance Monitor).
>=20
> struct drm_amdgpu_profiler_args carries an operation selector and a union
> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
> destination buffer are described by struct drm_amdgpu_spm_args and
> struct drm_amdgpu_spm_buffer_header.
>=20
> The ioctl number and struct layout are frozen here. The implementation
> lands in the rest of this series and the ioctl is not registered in
> amdgpu_ioctls_kms[] until then, so this header change alone does not make
> the interface reachable.
>=20
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Bing Ma <bing.ma@amd.com>

Hi,

Can you guys please clarify why this is necessary and what the use case is?

Are we sure we want a uAPI for this? RADV has been using SPM from userspace=
=20
for many years now.

Thanks & best regards,
Timur


> ---
>  include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
>=20
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9e5fa6f53e59..285949d63eb6 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>  #define DRM_AMDGPU_TRAP			0x1B
> +#define DRM_AMDGPU_PROFILER		0x1C
>=20
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
> DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP,
> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #define
> DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE +
> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
> DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,=20
union
> drm_amdgpu_trap) +#define
> DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE +=20
DRM_AMDGPU_PROFILER,
> struct drm_amdgpu_profiler_args)
>=20
>  /**
>   * DOC: memory domains
> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>  	} kfd_sigbus_delay;
>  };
>=20
> +/*
> + * Supported SPM (Stream Performance Monitor) Operations
> + */
> +/**
> + * drm_amdgpu_spm_op - SPM ioctl operations
> + */
> +enum drm_amdgpu_spm_op {
> +	AMDGPU_SPM_OP_ACQUIRE =3D 1,
> +	AMDGPU_SPM_OP_RELEASE,
> +	AMDGPU_SPM_OP_SET_DEST_BUF
> +};
> +
> +/**
> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
> + *
> + * @dest_buf: [in] used for the address of the destination buffer
> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
> + * @buf_size: [in] size of the destination buffer
> + * @op: [in] specifies the operation to perform
> + * @timeout: [in/out] timeout in milliseconds (in), amount of time left
> + *           in the timeout window (out)
> + * @bytes_copied: [out] total amount of data that was copied to the
> previous dest_buf + * @has_data_loss: [out] non-zero if data was lost (e.=
g.
> due to ring buffer overflow), + *                 zero otherwise
> + * @reserved: must be zero for forward compatibility
> + *
> + * This ioctl performs different functions depending on the @op paramete=
r.
> + *
> + * AMDGPU_SPM_OP_ACQUIRE
> + * ------------------------
> + *
> + * Acquires exclusive access of SPM on the specified XCP for the calling
> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
> + *
> + * AMDGPU_SPM_OP_RELEASE
> + * ------------------------
> + *
> + * Releases exclusive access of SPM on the specified XCP for the calling
> process, + * which allows another process to acquire it in the future.
> + *
> + * AMDGPU_SPM_OP_SET_DEST_BUF
> + * -----------------------------
> + *
> + * If @dest_buf is NULL, the destination buffer address is unset and
> copying of counters + * is stopped.
> + *
> + * If @dest_buf is not NULL, it specifies the pointer to a new destinati=
on
> buffer. + * @buf_size specifies the size of the buffer.
> + *
> + * If @timeout is non-0, the call will wait for up to @timeout ms for the
> previous + * buffer to be filled. If the previous buffer is filled before
> the timeout, @timeout + * is updated with the time remaining. If the
> timeout is exceeded, the function + * copies any partial data available
> into the previous user buffer and returns success. + * The amount of valid
> data in the previous user buffer is indicated by @bytes_copied. + *
> + * If @timeout is 0, the function immediately replaces the previous
> destination buffer + * without waiting for the previous buffer to be
> filled. That means the previous buffer + * may only be partially filled,
> and @bytes_copied will indicate how much data has been + * copied to it.
> + *
> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss
> will be non-0. + *
> + * Returns negative error code on failure, 0 on success.
> + */
> +struct drm_amdgpu_spm_args {
> +	__u64 dest_buf;
> +	__u32 buf_size;
> +	__u32 op;
> +	__u32 timeout;
> +	__u32 bytes_copied;
> +	__u32 has_data_loss;
> +	__u32 reserved[9];	/* must be zero; pads this struct to 64=20
bytes */
> +};
> +
> +/**
> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
> drm_amdgpu_spm_args->dest_buf + *
> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
> + * @bytes_copied:  [out] Amount of data copied for this sub-block
> + * @has_data_loss: [out] Boolean indicating whether data was lost for th=
is
> sub-block + *                       (e.g. due to a ring-buffer overflow)
> + * @reserved:      Reserved for future use, must be zero
> + *
> + * This header precedes the SPM data in the destination buffer. The
> reserved + * field maintains 64-byte cache line alignment (32 bytes total=
).
> + */
> +struct drm_amdgpu_spm_buffer_header {
> +	__u32 version; /* 0-23: minor, 24-31: major */
> +	__u32 bytes_copied;
> +	__u32 has_data_loss;
> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
> +};
> +
> +/* Supported Profiler Operation */
> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI=20
version */
> +#define AMDGPU_PROFILER_OP_SPM			2
> +
> +/*
> + * Profiler IOCTL
> + */
> +/**
> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
> + * @pad: Must be zero for input validation
> + * @data: Operation-specific parameters (union)
> + *
> + * GET_VER operation:
> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) |
> MINOR. + * Input: @data must be zero (reserved for forward compatibility).
> + *
> + * Design note: GET_VER is intentionally a parameter-free query returning
> + * the global profiler UAPI version.
> + */
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;				/*=20
AMDGPU_PROFILER_OP_* */
> +	__u32 pad;				/* must be zero */
> +	union {
> +		__u32 version;		/* GET_VER: out=20
(MAJOR<<24) | MINOR */
> +		struct drm_amdgpu_spm_args spm;
> +	} data;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif




