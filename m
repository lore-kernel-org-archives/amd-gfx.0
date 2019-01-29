From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: add -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines"
Date: Tue, 29 Jan 2019 13:07:45 -0500
Message-ID: <CADnq5_O08E0T6g9n4N52=B14Yvh9XkcVR_7R+9M9ioKD7xTxzA@mail.gmail.com>
References: <20190129165725.31062-1-alexander.deucher@amd.com> <20190129173827.GA16918@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190129173827.GA16918@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, "for 3.8" <stable@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jan 29, 2019 at 12:38 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 29, 2019 at 11:57:25AM -0500, Alex Deucher wrote:
> > This reverts commit 10117450735c7a7c0858095fb46a860e7037cb9a.
>
> $ git show  10117450735c7a7c0858095fb46a860e7037cb9a
> fatal: bad object 10117450735c7a7c0858095fb46a860e7037cb9a
>
> odd...
>

Sorry, it's queued up for drm-next, but hasn't made it to mainline yet.

Alex
