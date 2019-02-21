From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: disable bulk moves for now
Date: Wed, 20 Feb 2019 22:09:39 -0500
Message-ID: <20190221030938.GY10616@sasha-vm>
References: <20190220141606.8832-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220141606.8832-1-christian.koenig@amd.com>
Sender: stable-owner@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Feb 20, 2019 at 03:16:06PM +0100, Christian König wrote:
>The changes to fix those are two invasive for backporting.
>
>Just disable the feature in 4.20 and 5.0.
>
>Signed-off-by: Christian König <christian.koenig@amd.com>
>Cc: <stable@vger.kernel.org>    [4.20+]

For the sake of having it in the log, could you point to the upstream
commit(s) that fix it?
