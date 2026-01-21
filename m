Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A7CD625F8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 08:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83A0910E920;
	Thu, 22 Jan 2026 08:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="j4MZKsgU";
	dkim-atps=neutral
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 996F310E821
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 15:41:39 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-888bd3bd639so12378956d6.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1769010099; x=1769614899; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
 b=j4MZKsgUzjKQEpQMncc+/HcrEhb5f8k9TQICdU9VNuXmlenrDEpZRNk6OUPg2FQBZg
 5oUzaIrEAGpXUfT8bt68kqaimPLQ9lnU37FzB/va3EHpDGg/ZvBD01LFMHd+lii3pXr7
 Xzec+FExy4n7Q6eihGRIq1E4sUChCKXe1KgLhSbiw84bKGwO5sfXBd5no5iSYm40FCm3
 /IcgQU+LmiMmxV60xEunnfTpCTx+AYLGV11mi9LAop2ydcz24suGmc8r0zVEnCjNKuKj
 oJUIQ8H0J0X4bjpMwB7oo0dY3/mbBXX5m0X8i0Xv9X5MRukEttpTMeeeybrzypo++0JP
 ZpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769010099; x=1769614899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ou8wYJVgke38aZatOGIOXXNbnvyF2AuO4MiXOCQfuAM=;
 b=GrME1fQMdYZYFwlFFbf2g7fyvun/yWYU3Nlp50RLAshOj1VUmv8AzP6LYy/aHSywa4
 k+P0N51hR+BYDBkoj9pXQsjtUZubOZfcNYRu7FmpvJ/o9V64D00HTJl2XFUlS7tP+p4b
 08M1FZfGsPKxW0AwP0TA0WNwkSXKz9pRZLfMR43N1Q901mvJIlLkHzZuoaqnkaEfNy9L
 LUO5YtCQchU4LhdvHKYbcLbTAOezHLHJlkhqq1dwVcXgjgC0muGblVCtMyCG1y5A9KAb
 ZW5ti4CqVBcjwXLIll7t9/X4vVPnaGYGQBY+ujpFuCIC6sVrzFoRY+w85aTQqh9F8VVr
 JbHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzr+/zeOmmHoblzOf5yQW7dZJTPDvBNAzGsM74pKuDUc+qKtb7UZqv4PMrd+Ze/LlowJsEV1gD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyqpNydsiSISxQ2bckcy6GS8Xh8OfhRjDS2JdJGktjlzeczkDpU
 COpA/KwxwK9tp3UGa9rm54AaNlWXNHimhm1LivJpkpS6ji8Yi38D11DZFh4rkgzXiVU=
X-Gm-Gg: AZuq6aLQ63IsJVYIaEMzmehOnSrL4GUUK4IkkdDd+j9koLaCdoLKAZy+e1kw0nE3ygQ
 Ffquf9hu3v7GtIEo1sMDpSFLS999MUlXlyqrv5zaKPFaUOTqMdSf+EGgMpi0kiiUQdQVaRjWypv
 yMg1F+r7ng4Y3atD8yc/WQAcEXxig+/SxN1pmMSyC/mragums9zHJ4tlojK1iVSpbikOdjjUsaH
 uoxywOjf/caWFM6bwimTiMfxn12C/ztPLcodQaDYNEgcJLkqwWbIm0vFjUVRG6FSpTt/YC8i4Kr
 uJMNEiafdHrJvUAW7kkOdwWxRofLHBADra9Tc43JC9UfKSsD2VSffvSRnxzOCJ9YIuG0U18ltHg
 nIsjFeKPPUpiiJQ4uayk44CoYHuFyEBOtyX+8L9K0iLmRM9h//ax5WInEEUI06O5EAGaRq4Jl/E
 dvHTiuQWr6R+FFPu5tD6Ec3C0OPJhe6su2zSzB+lpG9JAdmUFf4aeIFKJWpbrKZle4Y61Sn1X6K
 cHHZQ==
X-Received: by 2002:a05:6214:212b:b0:888:6fde:7b72 with SMTP id
 6a1803df08f44-8942d7e0460mr262093776d6.32.1769010098574; 
 Wed, 21 Jan 2026 07:41:38 -0800 (PST)
Received: from ziepe.ca
 (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.112.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8946a1e3d28sm30951806d6.7.2026.01.21.07.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 07:41:37 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1viaKv-00000006EjK-1pDz;
 Wed, 21 Jan 2026 11:41:37 -0400
Date: Wed, 21 Jan 2026 11:41:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Williamson <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux.dev,
 intel-xe@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v4 8/8] vfio: Validate dma-buf revocation semantics
Message-ID: <20260121154137.GD961572@ziepe.ca>
References: <20260121-dmabuf-revoke-v4-0-d311cbc8633d@nvidia.com>
 <20260121-dmabuf-revoke-v4-8-d311cbc8633d@nvidia.com>
 <20260121134712.GZ961572@ziepe.ca> <20260121144701.GF13201@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121144701.GF13201@unreal>
X-Mailman-Approved-At: Thu, 22 Jan 2026 08:36:26 +0000
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

On Wed, Jan 21, 2026 at 04:47:01PM +0200, Leon Romanovsky wrote:
> > We need to push an urgent -rc fix to implement a pin function here
> > that always fails. That was missed and it means things like rdma can
> > import vfio when the intention was to block that. It would be bad for
> > that uAPI mistake to reach a released kernel.
> 
> I don't see any urgency here. In the current kernel, the RDMA importer
> prints a warning to indicate it was attached to the wrong exporter.
> VFIO also invokes dma_buf_move_notify().

The design of vfio was always that it must not work with RDMA because
we cannot tolerate the errors that happen due to ignoring the
move_notify.

The entire purpose of this series could be stated as continuing to
block RDMA while opening up other pining users.

So it must be addressed urgently before someone builds an application
relying on this connection.

Jason
