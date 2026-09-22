Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DB3C982FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 15:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B8D10ED78;
	Tue, 22 Sep 2026 15:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PB/L2kWm";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDEF410ED78
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 15:40:48 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 71dfb90a1353d-5c656135b77so40684e0c.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 08:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790091648; cv=none;
 d=google.com; s=arc-20260327;
 b=jtaLUUynXgp7TGA54i6wU4uAAuKb8S2C757BmgopOmuXYCDe+hf+folJ1TXjsW5REM
 xK/kvL7rCGY9G+DR+yP9eakvTH7dCJnQvYi0DmGSEhMIiDFwloxdtaIdqxikbVqDxYXB
 MY8XEkkuIaeRWx8s6j/mR0rr+1DYk/+4j7TDQ3u9K5DTDUOpBKaBRdg00HQn04VgPsno
 XkGZy9uXhcvFTvDJSAT/wkAuMT0Du1CNlSLDgYD3WmBhpo8hXuX59k1lkVyPsmm/A2dB
 LTDhyutUNv07IsaDzuGFSXobQPTJFLSOR8aij2m022jzjrK9vn34MH0HV+drXj+uP8GU
 x5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W2HRuLEivLSxhSrN2vQydJeg24IU4LTPnUvy7M+zYIw=;
 fh=/Sm63mF9gtlow87687mhvFIEvv4i+MbWo2gYhDEcd/U=;
 b=BUd4RuC1WfwvK7buKfLAYPhaR+bQAs0HEsbkQVYwj/jiINJmQ0a1ztMHp7VuHKUzTQ
 ZoAA+pAO1Uj277iggGSPpXFDjW6Ei259vHQPH/jOVhCvUYZZYTKJXbOt9Lbp9kqUHROI
 XMTxo70tHMvRcPonQec+t0uwhUALOZqsBUPFFVilhcACxeSP/75ryrMurU/gp3TZpoxJ
 EzLkbKsKTTANUQHrmZXOyAY1uiAKilw2U8YYZ2nE/i4b5XflEqvnB8zdZwD5FtM83Wxg
 zP9gE5O9yK9Ps45ZfwvOOqhq7Ekl1FJJLRH4c24MdHR403w2SgWK6L6A2RlnrFmmSvRa
 w1eg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790091648; x=1790696448; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W2HRuLEivLSxhSrN2vQydJeg24IU4LTPnUvy7M+zYIw=;
 b=PB/L2kWmFT/voJ1ywpYWOr4QtlmkqyKNxSM9yA/U7mXG6s7tnY4FTO2gKOix2kW2T4
 MZlkzLKgp8aXgo5yRU+sgXRY7DqmiESMfq1nJ42anA6iIVBSUl5K5G0Rnz0dFj/ezE76
 r5aMe3/fBNayFv01blOQNf5BZZNsvEYs8SEA+ZkkcpH0z7SYGM8r/YcAT2IT57oTiU6b
 zC5FXJhL6YaKRR+qYuHEKCU0hQDO3xlKMdj1VWgnN+i0ntIonmtrio8EVdmxb/8x7gp0
 L/HzflIafbxyNEb8svGeLZjbKsf1w/Mqz4mKeQ1VUU+wKhd56srFfhOhA7smbJFAhX6c
 d3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790091648; x=1790696448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W2HRuLEivLSxhSrN2vQydJeg24IU4LTPnUvy7M+zYIw=;
 b=Z2Vlb/IE957oXAXt9xm6RPUzoijsOYV5a3YAbqwWsZNLeJxTiEtweLp/1YLCx+Acrc
 rgi1udXowfdVPBU36UpkJoon1h+Q0RRhXAuI4MKEwgKHlG3R7Ekhn7UeRqdaPB3BYJix
 RVQc2yyiaPQfJpJOSeRSu4uhW10U1yHscbOHucaosIaalKWVuJJkIFdppm5nqqTwJvAU
 7aKxaORDZxQnC19dkLO18pQMbQbraxUkqCC1EbfTH6M2hNdL/pm1UPlfssIjX0ddBbEj
 0Of2uiSThDdcQmgQ3wIMxtuY9Y9byiy1DsRDyOHvwjCOpBIUeq/QDEKzgH+nwTCdMtvp
 q3MA==
X-Gm-Message-State: AFuF++lVE0kofZoVVQps+PtSdr5TsegUW6mE3IGcJdNuPu5joQrpNzZ6
 CK8GGtpsGWvMHCYO/NGM3nNr2ELQCpgl2HUyfYr489j9nI6xHERB6dhJOdM/0I/ht7iwEhWk+RZ
 xLLi7Hff4sHtufejqg2KYKhotVGfvVrs=
X-Gm-Gg: AYBFou06doUgw/h0HlRY6yPOuRSB4qg1X47/d6iQo+uf0/WXrIdBcPuTmYuFq/6AS7d
 A7KDRpwdVj1Uv6/H7nFDD2hrt5s+zSQFlbQPxS8vKO8Q9w41AvRnTOz95Yo3DtEfP50CPuCVazP
 JFaJYSzsrUM/S5grAfexeJdotXCfvBUYCQUw4mOBnjc3//DT/HfPDx0NugV0oYDJO92ilmbwWAB
 Yllpk4Mjbkm4BdLstyDmyjS+QPTIz4kiTF3F3go2dABhLWxjr6hgnt28lSBduvQuhonSZnh4vPw
 3+zWkLEIbpv5VFturDmT0cKfKfpQ74oYFdAdNelrYzlyEl5nOQ7YvBrpysRG4OxD9QCTUVeKDa3
 vTs5smnm1cW8ZyBTJiqe/mVB+Pb3a4JyGWrTtkWEo4w==
X-Received: by 2002:ac5:ca8b:0:b0:5c9:6766:5353 with SMTP id
 71dfb90a1353d-5c9b5a2f8aemr7576111e0c.3.1790091647631; Tue, 22 Sep 2026
 08:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260921200313.865829-1-James.Zhu@amd.com>
 <_Vw-t4UsQJK0Ic5kimqXtw@gmail.com>
 <d955f3a3-2f90-4e6a-bc9f-579df06e6402@amd.com>
 <E26TqGhRRCmT_3vybr_f2w@gmail.com>
In-Reply-To: <E26TqGhRRCmT_3vybr_f2w@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2026 11:40:33 -0400
X-Gm-Features: AclHuK8b4G4TFT9WF6wnf5YovRyU9LaNrdQ8Se18-24cRG1eMnth0TVfWtaQCzI
Message-ID: <CADnq5_MhUmRZeDKCVHPvq8z=UbJv3MEJZAOzBXjz5cFm46v_Zw@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: add profiler UAPI definitions
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, Bing.Ma@amd.com, 
 James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 Natalie Vock <nat@pixelcluster.dev>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Sep 22, 2026 at 11:22=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> On Tuesday, September 22, 2026 5:20:41=E2=80=AFPM Central European Summer=
 Time James
> Zhu wrote:
> > On 2026-09-22 11:09, Timur Krist=C3=B3f wrote:
> > > On Monday, September 21, 2026 10:03:02=E2=80=AFPM Central European Su=
mmer Time
> > > James>
> > > Zhu wrote:
> > >> Add the DRM_AMDGPU_PROFILER ioctl number and its argument structures=
, the
> > >> UAPI for GPU performance monitoring features such as SPM (Stream
> > >> Performance Monitor).
> > >>
> > >> struct drm_amdgpu_profiler_args carries an operation selector and a =
union
> > >> of per-operation parameters, currently AMDGPU_PROFILER_OP_GET_VER an=
d
> > >> AMDGPU_PROFILER_OP_SPM. The SPM operations and the layout of the
> > >> destination buffer are described by struct drm_amdgpu_spm_args and
> > >> struct drm_amdgpu_spm_buffer_header.
> > >>
> > >> The ioctl number and struct layout are frozen here. The implementati=
on
> > >> lands in the rest of this series and the ioctl is not registered in
> > >> amdgpu_ioctls_kms[] until then, so this header change alone does not=
 make
> > >> the interface reachable.
> > >>
> > >> Signed-off-by: James Zhu<James.Zhu@amd.com>
> > >> Reviewed-by: Bing Ma<bing.ma@amd.com>
> > >
> > > Hi,
> > >
> > > Can you guys please clarify why this is necessary and what the use ca=
se
> > > is?
> > >
> > > Are we sure we want a uAPI for this? RADV has been using SPM from
> > > userspace
> > > for many years now.
> >
> > [JZ] current RADV SPM is for graphic engine. These patches are for
> > compute engine SPM.
> >
> > Thanks!
>
> Is there any reason why it can't be done in userspace for compute too?

There's only one SPM so there needs to be arbitration to avoid
multiple applications trying to use it at the same time.  It also only
works on a single vmid at a time so the application using it has to
request a fixed vmid.

Alex

>
>
> > >
> > >> ---
> > >>
> > >>   include/uapi/drm/amdgpu_drm.h | 124 ++++++++++++++++++++++++++++++=
++++
> > >>   1 file changed, 124 insertions(+)
> > >>
> > >> diff --git a/include/uapi/drm/amdgpu_drm.h
> > >> b/include/uapi/drm/amdgpu_drm.h
> > >> index 9e5fa6f53e59..285949d63eb6 100644
> > >> --- a/include/uapi/drm/amdgpu_drm.h
> > >> +++ b/include/uapi/drm/amdgpu_drm.h
> > >> @@ -60,6 +60,7 @@ extern "C" {
> > >>
> > >>   #define DRM_AMDGPU_GEM_LIST_HANDLES      0x19
> > >>   #define DRM_AMDGPU_PROC_OPTIONS          0x1A
> > >>   #define DRM_AMDGPU_TRAP                  0x1B
> > >>
> > >> +#define DRM_AMDGPU_PROFILER               0x1C
> > >>
> > >>   #define DRM_IOCTL_AMDGPU_GEM_CREATE      DRM_IOWR(DRM_COMMAND_BASE=
 +
> > >>
> > >> DRM_AMDGPU_GEM_CREATE, union drm_amdgpu_gem_create) #define
> > >> DRM_IOCTL_AMDGPU_GEM_MMAP  DRM_IOWR(DRM_COMMAND_BASE +
> > >> DRM_AMDGPU_GEM_MMAP,
> > >> union drm_amdgpu_gem_mmap) @@ -83,6 +84,7 @@ extern "C" {
> > >>
> > >>   #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BAS=
E +
> > >>
> > >> DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles) #de=
fine
> > >> DRM_IOCTL_AMDGPU_PROC_OPTIONS      DRM_IOWR(DRM_COMMAND_BASE +
> > >> DRM_AMDGPU_PROC_OPTIONS, struct drm_amdgpu_proc_options) #define
> > >> DRM_IOCTL_AMDGPU_TRAP      DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_TR=
AP,
> > >
> > > union
> > >
> > >> drm_amdgpu_trap) +#define
> > >> DRM_IOCTL_AMDGPU_PROFILER  DRM_IOWR(DRM_COMMAND_BASE +
> > >
> > > DRM_AMDGPU_PROFILER,
> > >
> > >> struct drm_amdgpu_profiler_args)
> > >>
> > >>   /**
> > >>
> > >>    * DOC: memory domains
> > >>
> > >> @@ -1821,6 +1823,128 @@ struct drm_amdgpu_proc_options {
> > >>
> > >>    } kfd_sigbus_delay;
> > >>
> > >>   };
> > >>
> > >> +/*
> > >> + * Supported SPM (Stream Performance Monitor) Operations
> > >> + */
> > >> +/**
> > >> + * drm_amdgpu_spm_op - SPM ioctl operations
> > >> + */
> > >> +enum drm_amdgpu_spm_op {
> > >> +  AMDGPU_SPM_OP_ACQUIRE =3D 1,
> > >> +  AMDGPU_SPM_OP_RELEASE,
> > >> +  AMDGPU_SPM_OP_SET_DEST_BUF
> > >> +};
> > >> +
> > >> +/**
> > >> + * drm_amdgpu_spm_args - Arguments for SPM ioctl
> > >> + *
> > >> + * @dest_buf: [in] used for the address of the destination buffer
> > >> + *            in @AMDGPU_SPM_OP_SET_DEST_BUF
> > >> + * @buf_size: [in] size of the destination buffer
> > >> + * @op: [in] specifies the operation to perform
> > >> + * @timeout: [in/out] timeout in milliseconds (in), amount of time =
left
> > >> + *           in the timeout window (out)
> > >> + * @bytes_copied: [out] total amount of data that was copied to the
> > >> previous dest_buf + * @has_data_loss: [out] non-zero if data was los=
t
> > >> (e.g.
> > >> due to ring buffer overflow), + *                 zero otherwise
> > >> + * @reserved: must be zero for forward compatibility
> > >> + *
> > >> + * This ioctl performs different functions depending on the @op
> > >> parameter.
> > >> + *
> > >> + * AMDGPU_SPM_OP_ACQUIRE
> > >> + * ------------------------
> > >> + *
> > >> + * Acquires exclusive access of SPM on the specified XCP for the ca=
lling
> > >> process. + * This must be called before using AMDGPU_SPM_OP_SET_DEST=
_BUF.
> > >> + *
> > >> + * AMDGPU_SPM_OP_RELEASE
> > >> + * ------------------------
> > >> + *
> > >> + * Releases exclusive access of SPM on the specified XCP for the ca=
lling
> > >> process, + * which allows another process to acquire it in the futur=
e.
> > >> + *
> > >> + * AMDGPU_SPM_OP_SET_DEST_BUF
> > >> + * -----------------------------
> > >> + *
> > >> + * If @dest_buf is NULL, the destination buffer address is unset an=
d
> > >> copying of counters + * is stopped.
> > >> + *
> > >> + * If @dest_buf is not NULL, it specifies the pointer to a new
> > >> destination
> > >> buffer. + * @buf_size specifies the size of the buffer.
> > >> + *
> > >> + * If @timeout is non-0, the call will wait for up to @timeout ms f=
or
> > >> the
> > >> previous + * buffer to be filled. If the previous buffer is filled b=
efore
> > >> the timeout, @timeout + * is updated with the time remaining. If the
> > >> timeout is exceeded, the function + * copies any partial data availa=
ble
> > >> into the previous user buffer and returns success. + * The amount of
> > >> valid
> > >> data in the previous user buffer is indicated by @bytes_copied. + *
> > >> + * If @timeout is 0, the function immediately replaces the previous
> > >> destination buffer + * without waiting for the previous buffer to be
> > >> filled. That means the previous buffer + * may only be partially fil=
led,
> > >> and @bytes_copied will indicate how much data has been + * copied to=
 it.
> > >> + *
> > >> + * If data was lost, e.g. due to a ring buffer overflow, @has_data_=
loss
> > >> will be non-0. + *
> > >> + * Returns negative error code on failure, 0 on success.
> > >> + */
> > >> +struct drm_amdgpu_spm_args {
> > >> +  __u64 dest_buf;
> > >> +  __u32 buf_size;
> > >> +  __u32 op;
> > >> +  __u32 timeout;
> > >> +  __u32 bytes_copied;
> > >> +  __u32 has_data_loss;
> > >> +  __u32 reserved[9];      /* must be zero; pads this struct to 64
> > >
> > > bytes */
> > >
> > >> +};
> > >> +
> > >> +/**
> > >> + * drm_amdgpu_spm_buffer_header - SPM Buffer header for
> > >> drm_amdgpu_spm_args->dest_buf + *
> > >> + * @version:       [out] SPM version (0-23: minor, 24-31: major)
> > >> + * @bytes_copied:  [out] Amount of data copied for this sub-block
> > >> + * @has_data_loss: [out] Boolean indicating whether data was lost f=
or
> > >> this
> > >> sub-block + *                       (e.g. due to a ring-buffer overf=
low)
> > >> + * @reserved:      Reserved for future use, must be zero
> > >> + *
> > >> + * This header precedes the SPM data in the destination buffer. The
> > >> reserved + * field maintains 64-byte cache line alignment (32 bytes
> > >> total).
> > >> + */
> > >> +struct drm_amdgpu_spm_buffer_header {
> > >> +  __u32 version; /* 0-23: minor, 24-31: major */
> > >> +  __u32 bytes_copied;
> > >> +  __u32 has_data_loss;
> > >> +  __u32 reserved[5]; /* pad to 32 bytes (64-byte cache line / 2) */
> > >> +};
> > >> +
> > >> +/* Supported Profiler Operation */
> > >> +#define AMDGPU_PROFILER_OP_GET_VER                1 /* get profiler=
 UAPI
> > >
> > > version */
> > >
> > >> +#define AMDGPU_PROFILER_OP_SPM                    2
> > >> +
> > >> +/*
> > >> + * Profiler IOCTL
> > >> + */
> > >> +/**
> > >> + * struct drm_amdgpu_profiler_args - Profiler IOCTL arguments
> > >> + * @op: Operation to perform (AMDGPU_PROFILER_OP_*)
> > >> + * @pad: Must be zero for input validation
> > >> + * @data: Operation-specific parameters (union)
> > >> + *
> > >> + * GET_VER operation:
> > >> + * Returns the profiler UAPI version in @data.version as (MAJOR<<24=
) |
> > >> MINOR. + * Input: @data must be zero (reserved for forward
> > >> compatibility).
> > >> + *
> > >> + * Design note: GET_VER is intentionally a parameter-free query
> > >> returning
> > >> + * the global profiler UAPI version.
> > >> + */
> > >> +struct drm_amdgpu_profiler_args {
> > >> +  __u32 op;                               /*
> > >
> > > AMDGPU_PROFILER_OP_* */
> > >
> > >> +  __u32 pad;                              /* must be zero */
> > >> +  union {
> > >> +          __u32 version;          /* GET_VER: out
> > >
> > > (MAJOR<<24) | MINOR */
> > >
> > >> +          struct drm_amdgpu_spm_args spm;
> > >> +  } data;
> > >> +};
> > >> +
> > >>
> > >>   #if defined(__cplusplus)
> > >>   }
> > >>   #endif
>
>
>
>
