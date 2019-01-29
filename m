From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Revert "drm/amd/display: add -msse2 to prevent Clang
 from emitting libcalls to undefined SW FP routines"
Date: Tue, 29 Jan 2019 18:38:27 +0100
Message-ID: <20190129173827.GA16918@kroah.com>
References: <20190129165725.31062-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190129165725.31062-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jan 29, 2019 at 11:57:25AM -0500, Alex Deucher wrote:
> This reverts commit 10117450735c7a7c0858095fb46a860e7037cb9a.

$ git show  10117450735c7a7c0858095fb46a860e7037cb9a
fatal: bad object 10117450735c7a7c0858095fb46a860e7037cb9a

odd...
