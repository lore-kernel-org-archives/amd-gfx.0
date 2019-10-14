From: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] Revert "drm/radeon: Fix EEH during kexec"
Date: Mon, 14 Oct 2019 03:54:22 +0000
Message-ID: <20191014035423.30DCD2083B@mail.kernel.org>
References: <20191009181503.20381-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20191009181503.20381-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>, Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org, kmahlkuc@linux.vnet.ibm.com
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.orgstable@vger.kernel.orgstable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.3.5, v5.2.20, v4.19.78, v4.14.148, v4.9.196, v4.4.196.

v5.3.5: Build OK!
v5.2.20: Build OK!
v4.19.78: Build OK!
v4.14.148: Build OK!
v4.9.196: Build OK!
v4.4.196: Failed to apply! Possible dependencies:
    6f7fe9a93e6c0 ("drm/radeon: Fix EEH during kexec")
    a481daa88fd4d ("drm/radeon: always apply pci shutdown callbacks")
    a801abe4773da ("drm/radeon: wire up a pci shutdown callback")
    b9b487e494712 ("Revert "drm/radeon: always apply pci shutdown callbacks"")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks,
Sasha
