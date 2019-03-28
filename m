From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL 5.0 070/262] drm/amd/display: Pass app_tf by
 value rather than by reference
Date: Thu, 28 Mar 2019 11:04:21 +0100
Message-ID: <20190328100421.GA19456@atrey.karlin.mff.cuni.cz>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-70-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-70-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

> From: Nathan Chancellor <natechancellor@gmail.com>
> 
> [ Upstream commit 672e78cab819ebe31e3b9b8abac367be8a110472 ]
> 
> Clang warns when an expression that equals zero is used as a null
> pointer constant (in lieu of NULL):

Fixes warning, with unsupported compiler; not a serious bug. Plus, not
a minimal fix.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
