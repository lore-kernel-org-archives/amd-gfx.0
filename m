Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E37C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB40A10E5B6;
	Tue, 22 Sep 2026 15:14:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nq7Zt3sz";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C03D10ED64
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:14:03 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6356f6bso24562f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790090042; x=1790694842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xFnPQGt5SNVczN7hgpCStgUgnp6CX2iURlnIA0jAvQU=;
 b=Nq7Zt3szL3SOHxNaM5Z4wsPuI27DlugoHDgn1fvjdFUwR+WhFUsMT2Uo1qWfpoEnIo
 ORWSPUxiRYmqe8F6JxLry1Mw4ul8qXwfKd7fopaj4RobWKTcUTpa8wP6/ECfBgvg0jV5
 unQtLOoz6+BaDtiuhh8aRIB1IBS8NhXd917/s3IPihjXBlESmgjYJgAVkhm3/hylg6un
 o/iY1T4iTYUPVCME4VQhTxYwgEDjGo9XvAaMC7FpG0/eRPHMx4ZvXRWDsAwki7ro9rp2
 q53bPSQ8CrZ9MflKp5OHkQRa1j15BCNuJqmbbDBce0gPQ9oPdhL5FBtspBuPrhAjHCxt
 Xkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790090042; x=1790694842;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFnPQGt5SNVczN7hgpCStgUgnp6CX2iURlnIA0jAvQU=;
 b=szApqwGqrWalh/pL8RP6yZTS0HESjDWDnMb/7FbjPOkx7AsQiAu8OS9KfQNvqWJ8Vr
 bxBOpqKz396nkKGw4itGG88pz7CDVTFWcAMBlnRZNIoPpHHC4/mWHDnq3Xnfz/aDCepP
 MNUu54om4qQPKibre2Mb0qEX8oWNJLf+pxP4SqYc6XDCHwOs1rTG2YgMrF+IDxX5/6Fb
 pUvgb/Qj33l3+8htTEnCqTw5WWDn7D+py/rbqwhXkygrJFdli6XTYm21eOVkzz2a3j0j
 Bv8VBtaYK3bNFOcIUUuKa4Ce/giLOpCbhaRJYYE2fuED14ez5V7HHgfyoe8t/F0bchkQ
 XD/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR6RDedojlrueJ6ms8P3oKHz+8o+4Y2bmzV6E1mqeJasokuYZgiiEximrOQWsRgMm2gyqObnqg@lists.freedesktop.org
X-Gm-Message-State: AFuF++kYBNIpsM3VlNGF6YkTvx+f8uCOmSeFbjwsi7YOTnl3N4K7LHuD
 RcBY4CanTIM1OxLCAuXy1ESjLAQL3SM8guTtcZmpbz6DfOUMFvR+Azpk
X-Gm-Gg: AYBFou2WbiqJN5hA5EoW3qRTu8fEzGvko7qofCuEW5v+xCID34A0rvHwy00xJYYTQzO
 Wsiyhu73t2JRbRk53ChAq5fYdxb+KkoDcOYyO5fmB5RhMHp6yoNd54W53/3sw7lAhQ9B5XtxZnc
 px3MCux0R8bg5wPOxF6WSffwG+wQyCtiEAvtxN2Ajesb/KWS9ZsRAd68NY0TCLWttM7CDhY6EJD
 YZy10h6w+idmv5ipAijyYA2qBImEqpZjFx3SdUQDUvw3pDzKCye4sjRGMpM4V/3kmAyQiVgDwWM
 Pf/b44GZWui6Y3idY5RZ8oNI5mgoGJT3bYyXFOLgTPHto1KPZM3dz2F8YcmmHkRwgVY4B8B3JPz
 75l9dM7KxmBKxg8Mk5cif5Pp7JteXL3H4JQbip49AEOPKL0zvl0Y/znr81as4EHj/02JM3nG5WI
 IdAko2w4qYtaUKLroO/EluJYC1cAH4RswseFqRUuxuAIFxnEIsS4qxUasBy1ducu4V8Dk3tO5Pv
 +BlGYobNfeV5aWLWj8Lz+MI98af
X-Received: by 2002:a5d:5e8f:0:b0:487:27f9:82f with SMTP id
 ffacd0b85a97d-48727f90afemr19895073f8f.36.1790090041422; 
 Tue, 22 Sep 2026 08:14:01 -0700 (PDT)
Received: from [10.254.153.234] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886279298asm4880632f8f.34.2026.09.22.08.13.59
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Sep 2026 08:14:00 -0700 (PDT)
Message-ID: <15f96feb-9db9-4a8f-a81b-ecfa2fb605b0@gmail.com>
Date: Tue, 22 Sep 2026 17:13:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, Bing.Ma@amd.com
Cc: jamesz@amd.com
References: <20260921200313.865829-1-James.Zhu@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20260921200313.865829-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/21/26 22:03, James Zhu wrote:
> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, the
> UAPI for GPU performance monitoring features such as SPM (Stream
> Performance Monitor).
> 
> struct drm_amdgpu_profiler_args carries an operation selector and a union
> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
> destination buffer are described by struct drm_amdgpu_spm_args and
> struct drm_amdgpu_spm_buffer_header.
> 
> The ioctl number and struct layout are frozen here. The implementation
> lands in the rest of this series and the ioctl is not registered in
> amdgpu_ioctls_kms[] until then, so this header change alone does not make
> the interface reachable.
> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Bing Ma <bing.ma@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++++
>  1 file changed, 124 insertions(+)
> 
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9e5fa6f53e59..285949d63eb6 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -60,6 +60,7 @@ extern "C" {
>  #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
>  #define DRM_AMDGPU_PROC_OPTIONS		0x1A
>  #define DRM_AMDGPU_TRAP			0x1B
> +#define DRM_AMDGPU_PROFILER		0x1C
>  
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union drm_amdgpu_gem_mmap)
> @@ -83,6 +84,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
>  #define DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options)
>  #define DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP, union drm_amdgpu_trap)
> +#define DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_PROFILER, struct drm_amdgpu_profiler_args)
>  
>  /**
>   * DOC: memory domains
> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
>  	} kfd_sigbus_delay;
>  };
>  
> +/*
> + * Supported SPM (Stream Performance Monitor) Operations
> + */
> +/**
> + * drm_amdgpu_spm_op - SPM ioctl operations
> + */
> +enum drm_amdgpu_spm_op {
> +	AMDGPU_SPM_OP_ACQUIRE = 1,
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
> + * @bytes_copied: [out] total amount of data that was copied to the previous dest_buf
> + * @has_data_loss: [out] non-zero if data was lost (e.g. due to ring buffer overflow),
> + *                 zero otherwise
> + * @reserved: must be zero for forward compatibility
> + *
> + * This ioctl performs different functions depending on the @op parameter.
> + *
> + * AMDGPU_SPM_OP_ACQUIRE
> + * ------------------------
> + *
> + * Acquires exclusive access of SPM on the specified XCP for the calling process.
> + * This must be called before using AMDGPU_SPM_OP_SET_DEST_BUF.
> + *
> + * AMDGPU_SPM_OP_RELEASE
> + * ------------------------
> + *
> + * Releases exclusive access of SPM on the specified XCP for the calling process,
> + * which allows another process to acquire it in the future.

Clear NAK on that. We already have an interface for SPM VMID acquire/release.

And please CC me on such patches in the future.

Regards,
Christian.

> + *
> + * AMDGPU_SPM_OP_SET_DEST_BUF
> + * -----------------------------
> + *
> + * If @dest_buf is NULL, the destination buffer address is unset and copying of counters
> + * is stopped.
> + *
> + * If @dest_buf is not NULL, it specifies the pointer to a new destination buffer.
> + * @buf_size specifies the size of the buffer.
> + *
> + * If @timeout is non-0, the call will wait for up to @timeout ms for the previous
> + * buffer to be filled. If the previous buffer is filled before the timeout, @timeout
> + * is updated with the time remaining. If the timeout is exceeded, the function
> + * copies any partial data available into the previous user buffer and returns success.
> + * The amount of valid data in the previous user buffer is indicated by @bytes_copied.
> + *
> + * If @timeout is 0, the function immediately replaces the previous destination buffer
> + * without waiting for the previous buffer to be filled. That means the previous buffer
> + * may only be partially filled, and @bytes_copied will indicate how much data has been
> + * copied to it.
> + *
> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_loss will be non-0.
> + *
> + * Returns negative error code on failure, 0 on success.
> + */
> +struct drm_amdgpu_spm_args {
> +	__u64 dest_buf;
> +	__u32 buf_size;
> +	__u32 op;
> +	__u32 timeout;
> +	__u32 bytes_copied;
> +	__u32 has_data_loss;
> +	__u32 reserved[9];	/* must be zero; pads this struct to 64 bytes */
> +};
> +
> +/**
> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for drm_amdgpu_spm_args->dest_buf
> + *
> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
> + * @bytes_copied:  [out] Amount of data copied for this sub-block
> + * @has_data_loss: [out] Boolean indicating whether data was lost for this sub-block
> + *                       (e.g. due to a ring-buffer overflow)
> + * @reserved:      Reserved for future use, must be zero
> + *
> + * This header precedes the SPM data in the destination buffer. The reserved
> + * field maintains 64-byte cache line alignment (32 bytes total).
> + */
> +struct drm_amdgpu_spm_buffer_header {
> +	__u32 version; /* 0-23: minor, 24-31: major */
> +	__u32 bytes_copied;
> +	__u32 has_data_loss;
> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
> +};
> +
> +/* Supported Profiler Operation */
> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI version */
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
> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) | MINOR.
> + * Input: @data must be zero (reserved for forward compatibility).
> + *
> + * Design note: GET_VER is intentionally a parameter-free query returning
> + * the global profiler UAPI version.
> + */
> +struct drm_amdgpu_profiler_args {
> +	__u32 op;				/* AMDGPU_PROFILER_OP_* */
> +	__u32 pad;				/* must be zero */
> +	union {
> +		__u32 version;		/* GET_VER: out (MAJOR<<24) | MINOR */
> +		struct drm_amdgpu_spm_args spm;
> +	} data;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif

