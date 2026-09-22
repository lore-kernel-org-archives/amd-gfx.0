Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B245C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12D110E2BE;
	Tue, 22 Sep 2026 15:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y0T0WL+K";
	dkim-atps=neutral
Received: from mail-ej2-f20.google.com (mail-ej2-f20.google.com
 [74.125.228.148])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CC510E2BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:22:51 +0000 (UTC)
Received: by mail-ej2-f20.google.com with SMTP id
 a640c23a62f3a-c293c683202so634866866b.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790090569; x=1790695369; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6xM9071Uln19NQXaLoX1VpNQ6E+n9cdgDXzO/rDU2yo=;
 b=Y0T0WL+K3j11R27CgXGK8LxCx7utacvdi96qc9wEUyfnjcAIJ76L0eg2j2Q6JNBlmv
 s/6hUlQjPbJUrqGhpKdvs6I+NZuXCbuKhKv/JuzbbgYJT/f0QdfjRID4jmP/VW2I0Lyw
 86e6SZ5BFM9c83Fi619ZNsox5fIqOyZ112KfLZuHwk0PtYM7eqUakPjpeqOFMjkdaH/w
 tiwyIDk2mlzHFIVEFxTI0BuW6iW8zukZ1UAYrMqGhLUASCZB6dyF+oLuja6+NHqGuf6P
 j1VnQXZmguRMkOWzqVr0g+maI1xXiavGnVbIwtCNbaN8W+CfcyraMtVyBcJCPRznLFGi
 EB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790090569; x=1790695369;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6xM9071Uln19NQXaLoX1VpNQ6E+n9cdgDXzO/rDU2yo=;
 b=FqQs3QVsls3qsAr8b58Qhxd1Nk5sZ371MLoG9+lTHB8WwksbERYYt9Jy6CUSbHsNeN
 KL9KKJ0AbptrXkmeO6BsHL4i4KutIlkwoLc+Hbu0MV1tiS6uFUEOH7C8zdkqAtltjyFs
 OrUehlf+ewWCWt6bp/rCnJa+HvP3A00fTiIb9HLkr3cpIA6Yycnv2NZL+4LPwscvIF2+
 Q+lIuuW32LQO2N0cWQ/R6yBzHa6WVgorrZIKgsIjeW0Pgb4pznicyw8jPWUGVFms7KC4
 OjPqEVBx818J8GcevFf0mxoEZozm2dYzRAXK4++D/Xtl3kClqZkGA7AE2j7fNg6PEfQj
 g1rQ==
X-Gm-Message-State: AFuF++mUPvKa6vuOFxisx+FEKB8zzQtwWyVRP0xrPSTUHFFgecFv9cA+
 IdKCqNti9XImSucq4e3WzAhFM9wONZUfe1iUvbeYrBdy9IdmeNoVEn0bO+XQFrky
X-Gm-Gg: AYBFou3952hxc7Hisv2NEoz4Ih538FG/7ejAVv4wKKbiCJFx++Bl7QqqY/wuGVUtMXO
 FWFfJR8kevRqEupf9r+689wYZKSFbyK7hW2vECW6ldkOhCGwmIDpUowh/VXjHxNRYOnjZVzGTP/
 /9G9s1NJS3E9zyQBQy/1d0cSYDyO+g7b9Kd03rRzmn+1rpbejtDhU5mN2dXgcPQGvgFwbrnvhww
 WkOvrOxI2NHSb1CqwoP+8H32AjcpbVFwnR1UDzYaNbS/nm9wuxkQwibB2ljs6Uj27bVhC7jZVTC
 2p7Ick9lz0vmYhyMsUdKVezrqNdv5csRs9dTxdP/6Ns1YI+htWAe7geREC5kZCptE3syEDcqzEf
 kJqfy8aytOXm0t6ppM8eh3Pvu85rmDcx+adJvfpRuAVrlYKTaulHrAXUtjF5rPbV+hdBOAabbSc
 9TW+mBwzGMEahnhz80zS6b/bt+UqpyRGSUSQJNojszWxqcSWyMARYJ5tRO9jVnD8pYGRUFXckXH
 /7xnQISgax2dQqsB/xyrbTArYkDknnl+s12RBmpkz0LjA==
X-Received: by 2002:a17:907:9606:b0:c28:fb3f:fe20 with SMTP id
 a640c23a62f3a-c2a15cdc9d1mr1176899466b.30.1790090569244; 
 Tue, 22 Sep 2026 08:22:49 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a9c581412sm108339166b.25.2026.09.22.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:22:48 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com, 
 James Zhu <jamesz@amd.com>
Cc: James Zhu <James.Zhu@amd.com>, Natalie Vock <nat@pixelcluster.dev>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
Date: Tue, 22 Sep 2026 17:22:47 +0200
Message-ID: <E26TqGhRRCmT_3vybr_f2w@gmail.com>
In-Reply-To: <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
 <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
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

On Tuesday, September 22, 2026 5:20:41=E2=80=AFPM Central European Summer T=
ime James=20
Zhu wrote:
> On 2026-09-22 11:09, Timur Krist=C3=B3f wrote:
> > On Monday, September 21, 2026 10:03:02=E2=80=AFPM Central European Summ=
er Time
> > James>=20
> > Zhu wrote:
> >> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures, =
the
> >> UAPI for GPU performance monitoring features such as SPM (Stream
> >> Performance Monitor).
> >>=20
> >> struct drm_amdgpu_profiler_args carries an operation selector and a un=
ion
> >> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER and
> >> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
> >> destination buffer are described by struct drm_amdgpu_spm_args and
> >> struct drm_amdgpu_spm_buffer_header.
> >>=20
> >> The ioctl number and struct layout are frozen here. The implementation
> >> lands in the rest of this series and the ioctl is not registered in
> >> amdgpu_ioctls_kms[] until then, so this header change alone does not m=
ake
> >> the interface reachable.
> >>=20
> >> Signed-off-by: James Zhu<James.Zhu@amd.com>
> >> Reviewed-by: Bing Ma<bing.ma@amd.com>
> >=20
> > Hi,
> >=20
> > Can you guys please clarify why this is necessary and what the use case
> > is?
> >=20
> > Are we sure we want a uAPI for this? RADV has been using SPM from
> > userspace
> > for many years now.
>=20
> [JZ] current RADV SPM is for graphic engine. These patches are for
> compute engine SPM.
>=20
> Thanks!

Is there any reason why it can't be done in userspace for compute too?


> >=20
> >> ---
> >>=20
> >>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 124 insertions(+)
> >>=20
> >> diff --git a/include/uapi/drm/amdgpu_drm.h
> >> b/include/uapi/drm/amdgpu_drm.h
> >> index 9e5fa6f53e59..285949d63eb6 100644
> >> --- a/include/uapi/drm/amdgpu_drm.h
> >> +++ b/include/uapi/drm/amdgpu_drm.h
> >> @@ -60,6 +60,7 @@ extern "C" {
> >>=20
> >>   #define DRM_AMDGPU_GEM_LIST_HANDLES	0x19
> >>   #define DRM_AMDGPU_PROC_OPTIONS		0x1A
> >>   #define DRM_AMDGPU_TRAP			0x1B
> >>=20
> >> +#define DRM_AMDGPU_PROFILER		0x1C
> >>=20
> >>   #define DRM_IOCTL_AMDGPU_GEM_CREATE	DRM_IOWR(DRM_COMMAND_BASE +
> >>=20
> >> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
> >> DRM_IOCTL_AMDGPU_GEM_MMAP	DRM_IOWR(DRM_COMMAND_BASE +
> >> DRM_AMDGPU_GEM_MMAP,
> >> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
> >>=20
> >>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE +
> >>=20
> >> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #defi=
ne
> >> DRM_IOCTL_AMDGPU_PROC_OPTIONS	DRM_IOWR(DRM_COMMAND_BASE +
> >> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
> >> DRM_IOCTL_AMDGPU_TRAP	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TRAP,
> >=20
> > union
> >=20
> >> drm_amdgpu_trap) +#define
> >> DRM_IOCTL_AMDGPU_PROFILER	DRM_IOWR(DRM_COMMAND_BASE +
> >=20
> > DRM_AMDGPU_PROFILER,
> >=20
> >> struct drm_amdgpu_profiler_args)
> >>=20
> >>   /**
> >>  =20
> >>    * DOC: memory domains
> >>=20
> >> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
> >>=20
> >>   	} kfd_sigbus_delay;
> >>  =20
> >>   };
> >>=20
> >> +/*
> >> + * Supported SPM (Stream Performance Monitor) Operations
> >> + */
> >> +/**
> >> + * drm_amdgpu_spm_op - SPM ioctl operations
> >> + */
> >> +enum drm_amdgpu_spm_op {
> >> +	AMDGPU_SPM_OP_ACQUIRE =3D 1,
> >> +	AMDGPU_SPM_OP_RELEASE,
> >> +	AMDGPU_SPM_OP_SET_DEST_BUF
> >> +};
> >> +
> >> +/**
> >> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
> >> + *
> >> + * @dest_buf: [in] used for the address of the destination buffer
> >> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
> >> + * @buf_size: [in] size of the destination buffer
> >> + * @op: [in] specifies the operation to perform
> >> + * @timeout: [in/out] timeout in milliseconds (in), amount of time le=
ft
> >> + *           in the timeout window (out)
> >> + * @bytes_copied: [out] total amount of data that was copied to the
> >> previous dest_buf + * @has_data_loss: [out] non-zero if data was lost
> >> (e.g.
> >> due to ring buffer overflow), + *                 zero otherwise
> >> + * @reserved: must be zero for forward compatibility
> >> + *
> >> + * This ioctl performs different functions depending on the @op
> >> parameter.
> >> + *
> >> + * AMDGPU_SPM_OP_ACQUIRE
> >> + * ------------------------
> >> + *
> >> + * Acquires exclusive access of SPM on the specified XCP for the call=
ing
> >> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST_B=
UF.
> >> + *
> >> + * AMDGPU_SPM_OP_RELEASE
> >> + * ------------------------
> >> + *
> >> + * Releases exclusive access of SPM on the specified XCP for the call=
ing
> >> process, + * which allows another process to acquire it in the future.
> >> + *
> >> + * AMDGPU_SPM_OP_SET_DEST_BUF
> >> + * -----------------------------
> >> + *
> >> + * If @dest_buf is NULL, the destination buffer address is unset and
> >> copying of counters + * is stopped.
> >> + *
> >> + * If @dest_buf is not NULL, it specifies the pointer to a new
> >> destination
> >> buffer. + * @buf_size specifies the size of the buffer.
> >> + *
> >> + * If @timeout is non-0, the call will wait for up to @timeout ms for
> >> the
> >> previous + * buffer to be filled. If the previous buffer is filled bef=
ore
> >> the timeout, @timeout + * is updated with the time remaining. If the
> >> timeout is exceeded, the function + * copies any partial data available
> >> into the previous user buffer and returns success. + * The amount of
> >> valid
> >> data in the previous user buffer is indicated by @bytes_copied. + *
> >> + * If @timeout is 0, the function immediately replaces the previous
> >> destination buffer + * without waiting for the previous buffer to be
> >> filled. That means the previous buffer + * may only be partially fille=
d,
> >> and @bytes_copied will indicate how much data has been + * copied to i=
t.
> >> + *
> >> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_lo=
ss
> >> will be non-0. + *
> >> + * Returns negative error code on failure, 0 on success.
> >> + */
> >> +struct drm_amdgpu_spm_args {
> >> +	__u64 dest_buf;
> >> +	__u32 buf_size;
> >> +	__u32 op;
> >> +	__u32 timeout;
> >> +	__u32 bytes_copied;
> >> +	__u32 has_data_loss;
> >> +	__u32 reserved[9];	/* must be zero; pads this struct to 64
> >=20
> > bytes */
> >=20
> >> +};
> >> +
> >> +/**
> >> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
> >> drm_amdgpu_spm_args->dest_buf + *
> >> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
> >> + * @bytes_copied:  [out] Amount of data copied for this sub-block
> >> + * @has_data_loss: [out] Boolean indicating whether data was lost for
> >> this
> >> sub-block + *                       (e.g. due to a ring-buffer overflo=
w)
> >> + * @reserved:      Reserved for future use, must be zero
> >> + *
> >> + * This header precedes the SPM data in the destination buffer. The
> >> reserved + * field maintains 64-byte cache line alignment (32 bytes
> >> total).
> >> + */
> >> +struct drm_amdgpu_spm_buffer_header {
> >> +	__u32 version; /* 0-23: minor, 24-31: major */
> >> +	__u32 bytes_copied;
> >> +	__u32 has_data_loss;
> >> +	__u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
> >> +};
> >> +
> >> +/* Supported Profiler Operation */
> >> +#define AMDGPU_PROFILER_OP_GET_VER		1 /* get profiler UAPI
> >=20
> > version */
> >=20
> >> +#define AMDGPU_PROFILER_OP_SPM			2
> >> +
> >> +/*
> >> + * Profiler IOCTL
> >> + */
> >> +/**
> >> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
> >> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
> >> + * @pad: Must be zero for input validation
> >> + * @data: Operation-specific parameters (union)
> >> + *
> >> + * GET_VER operation:
> >> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24) |
> >> MINOR. + * Input: @data must be zero (reserved for forward
> >> compatibility).
> >> + *
> >> + * Design note: GET_VER is intentionally a parameter-free query
> >> returning
> >> + * the global profiler UAPI version.
> >> + */
> >> +struct drm_amdgpu_profiler_args {
> >> +	__u32 op;				/*
> >=20
> > AMDGPU_PROFILER_OP_* */
> >=20
> >> +	__u32 pad;				/* must be zero */
> >> +	union {
> >> +		__u32 version;		/* GET_VER: out
> >=20
> > (MAJOR<<24) | MINOR */
> >=20
> >> +		struct drm_amdgpu_spm_args spm;
> >> +	} data;
> >> +};
> >> +
> >>=20
> >>   #if defined(__cplusplus)
> >>   }
> >>   #endif




