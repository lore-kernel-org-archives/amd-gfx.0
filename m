From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] Per file OOM badness
Date: Mon, 22 Jan 2018 15:23:15 -0800
Message-ID: <20180122152315.749d88f3c91ffce4d70ac450@linux-foundation.org>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 18 Jan 2018 11:47:48 -0500 Andrey Grodzovsky <andrey.grodzovsky@amd.com> wrote:

> Hi, this series is a revised version of an RFC sent by Christian König
> a few years ago. The original RFC can be found at 
> https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html
> 
> This is the same idea and I've just adressed his concern from the original RFC 
> and switched to a callback into file_ops instead of a new member in struct file.

Should be in address_space_operations, I suspect.  If an application
opens a file twice, we only want to count it once?

But we're putting the cart ahead of the horse here.  Please provide us
with a detailed description of the problem which you are addressing so
that the MM developers can better consider how to address your
requirements.
