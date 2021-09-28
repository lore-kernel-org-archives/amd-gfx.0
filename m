Return-Path: <SRS0=UpsA=OS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F430C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 18:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC786127C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Sep 2021 18:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DBC786127C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 748456E91B;
	Tue, 28 Sep 2021 18:01:14 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E486E064
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 17:13:32 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id j13so20551730qtq.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Sep 2021 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3Xx8rNIZkvMliD68DmgFcYOoQ1tpCBrX2+RD4NaKqi4=;
 b=LanYIHwLUugO1SYhA4R1tjx/4/Za+1W69P8OiSvyrQXmlYAdpbyB85E23JmtXfGDHt
 wDUzXSyVeUosO2AwtC5ep6h56UygytauvIz8Qdi86oR2WYIgror7+r5XdKdNZJMXADW2
 teFMQtLGF7zsP8hzV4AhfTM5awwdCuByO0G9yhkwWenLgruL7//YkdwrSbP1PqEhcnI1
 xUu62EKpnImnUhUZbYkhDetuXiAugos4PsWbBV0yxXz9ylLSun90NzDflFzhWGUHiSz7
 yZUUnYjocHsdZep+d5DWuEVLKnZME54O4Wvij6NNlm4cWTy92Y5NiAt/MEFNlvAFiMmx
 Tqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3Xx8rNIZkvMliD68DmgFcYOoQ1tpCBrX2+RD4NaKqi4=;
 b=0k3XeukG+bn/MvUQIWpEBhogo2f0pdlk5B+mi9DMVkJB1gvHQUTeMD8tXxSS2/CkUW
 WzV7Hf1FBe0lrZAbKGzbeCijWrCZfUu+uedDGe7PMLedejqI+14Z9r/aJm2GKX9kzL0z
 ThY+yhAiDs/nll2bgnMVzAqvAE1NuxcV66CUABjS40Qda1EPcrNyR466eoAp1wCHAtUs
 hfQZ2L8VZ+Y0dQq+AQSbseRVFNptmowRVvLnNCtFN4fr0tbIZGw1XYqm5EiPbx8sRhlZ
 zwQREQnGirMgAkrgR1vh/ZPvq2XB9Y0h2dUYSdzm53qTRIfJFbPf7FW0WbPJxo8ZkpSe
 /V+Q==
X-Gm-Message-State: AOAM531Y+CNjDpOWkjzV03831OcXXysR5CMqAX8RzVyjkJrAMIsML+gW
 630DdD8HAe+I1C9qopkDxWC0bQ==
X-Google-Smtp-Source: ABdhPJwySofKZpBkD7jy6Vdb6WsNA3yiKbulrnJQTRUb8BGGkmyWflBOTfaYOzfqm6nDJlcs8e0wag==
X-Received: by 2002:a05:622a:178b:: with SMTP id
 s11mr7167370qtk.13.1632849210891; 
 Tue, 28 Sep 2021 10:13:30 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129])
 by smtp.gmail.com with ESMTPSA id p12sm14912297qkj.54.2021.09.28.10.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 10:13:30 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVGfZ-007Dzq-MQ; Tue, 28 Sep 2021 14:13:29 -0300
Date: Tue, 28 Sep 2021 14:13:29 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Oded Gabbay <ogabbay@kernel.org>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
 christian.koenig@amd.com, daniel.vetter@ffwll.ch,
 galpress@amazon.com, sleybo@amazon.com,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, dledford@redhat.com, airlied@gmail.com,
 alexander.deucher@amd.com, leonro@nvidia.com, hch@lst.de,
 amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v6 1/2] habanalabs: define uAPI to export FD for DMA-BUF
Message-ID: <20210928171329.GF3544071@ziepe.ca>
References: <20210912165309.98695-1-ogabbay@kernel.org>
 <20210912165309.98695-2-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912165309.98695-2-ogabbay@kernel.org>
X-Mailman-Approved-At: Tue, 28 Sep 2021 18:01:09 +0000
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

On Sun, Sep 12, 2021 at 07:53:08PM +0300, Oded Gabbay wrote:
>  	/* HL_MEM_OP_* */
>  	__u32 op;
> -	/* HL_MEM_* flags */
> +	/* HL_MEM_* flags.
> +	 * For the HL_MEM_OP_EXPORT_DMABUF_FD opcode, this field holds the
> +	 * DMA-BUF file/FD flags.
> +	 */
>  	__u32 flags;
>  	/* Context ID - Currently not in use */
>  	__u32 ctx_id;
> @@ -1072,6 +1091,13 @@ struct hl_mem_out {
>  
>  			__u32 pad;
>  		};
> +
> +		/* Returned in HL_MEM_OP_EXPORT_DMABUF_FD. Represents the
> +		 * DMA-BUF object that was created to describe a memory
> +		 * allocation on the device's memory space. The FD should be
> +		 * passed to the importer driver
> +		 */
> +		__u64 fd;

fd's should be a s32 type in a fixed width uapi.

I usually expect to see the uapi changes inside the commit that
consumes them, splitting the patch like this seems strange but
harmless.

Jason
