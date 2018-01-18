From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [RFC] Per file OOM badness
Date: Thu, 18 Jan 2018 11:47:48 -0500
Message-ID: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
List-Id: amd-gfx.lists.freedesktop.org

Hi, this series is a revised version of an RFC sent by Christian König
a few years ago. The original RFC can be found at 
https://lists.freedesktop.org/archives/dri-devel/2015-September/089778.html

This is the same idea and I've just adressed his concern from the original RFC 
and switched to a callback into file_ops instead of a new member in struct file.

Thanks,
Andrey
