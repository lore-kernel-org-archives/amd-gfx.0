From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC] Per file OOM badness
Date: Thu, 18 Jan 2018 18:00:06 +0100
Message-ID: <20180118170006.GG6584@dhcp22.suse.cz>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Sender: owner-linux-mm@kvack.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Thu 18-01-18 11:47:48, Andrey Grodzovsky wrote:
> Hi, this series is a revised version of an RFC sent by Christian König
> a few years ago. The original RFC can be found at 
> https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html
> 
> This is the same idea and I've just adressed his concern from the original RFC 
> and switched to a callback into file_ops instead of a new member in struct file.

Please add the full description to the cover letter and do not make
people hunt links.

Here is the origin cover letter text
: I'm currently working on the issue that when device drivers allocate memory on
: behalf of an application the OOM killer usually doesn't knew about that unless
: the application also get this memory mapped into their address space.
: 
: This is especially annoying for graphics drivers where a lot of the VRAM
: usually isn't CPU accessible and so doesn't make sense to map into the
: address space of the process using it.
: 
: The problem now is that when an application starts to use a lot of VRAM those
: buffers objects sooner or later get swapped out to system memory, but when we
: now run into an out of memory situation the OOM killer obviously doesn't knew
: anything about that memory and so usually kills the wrong process.
: 
: The following set of patches tries to address this problem by introducing a per
: file OOM badness score, which device drivers can use to give the OOM killer a
: hint how many resources are bound to a file descriptor so that it can make
: better decisions which process to kill.
: 
: So question at every one: What do you think about this approach?
: 
: My biggest concern right now is the patches are messing with a core kernel
: structure (adding a field to struct file). Any better idea? I'm considering
: to put a callback into file_ops instead.

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
