Return-Path: <SRS0=tiv0=75=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C76FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB434208B3
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2020 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2zYcdJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB434208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B85576E8EC;
	Tue, 16 Jun 2020 15:24:51 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D976E857
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 08:28:32 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id w16so20015345ejj.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2020 01:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
 b=n2zYcdJI10LwDXrUDK71pELIpej3d4vK23sWHQIG+DTNiP7rBB2Ydlo3ni2NhqKlw0
 qmgjqRyWrTNKRJqtcN54fNNbVchNxv0UCZ8UD6A5n0N9veGqYXg67ZE1JHCqEN7GwO5N
 bEzMy2pQBU1i7k0Z/9BJp4fSpA1uwPrI9uPISnm1l2c83I4urBxMP6qXHOXcm7LqT474
 DkWGGV7iqbwvNUH1ffz861zJTpj+CcmYfrKxZNalIwc2nhiDZQK3HmY8x01t6j0g8Rzp
 21hq2PicDxmT3+wENPx4ZJnox12QbkNo3+5pkq+RlLl6x1a38Mh53C7YsX6mxJYhTMLu
 rlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8IjNpcb5GlLP8oh8x0KUTPeP/cupRlI8efPDAe078Wg=;
 b=F31XsVbMVpRjg1x8KUNlSD/scVRJ/sicdOXQSkBZRTnfn98jjSUl5uFMn6A1jqRMmr
 3SxnqiCPHu6lMLOQbkONSFS/Pz3RSxPmGuseQY7h9dN+vNDyha6AJOpEHb9VpDtNPEsi
 v35XLGNyTUaTWsHXKvAH0nV3sbsRQwIfmaQsZ2pgymxXihA5xsOs+M9Hbm9Z12PtaVC0
 CumCvqeIvenPV4vPr70+Pz5G7UJzKV2HcGCCfQxyY0G5FS5A4AhUdYyqN1rtVCc8ZcEr
 0szUCQXVlF0Pd8UQJ9IhSyGVKSS4Ot1jzIPfcV3kCMGKYhozVSFiFSg+jdUGX/lrnCdw
 tDRA==
X-Gm-Message-State: AOAM530/VYTVoasyhShbNbfViOnEPgrUuXziXj1VDJyQCkhcvuoFiBmF
 SsVsQPmE8xXC93TdokrDjcCANg==
X-Google-Smtp-Source: ABdhPJwdmGZqCbPQVfP2PbF9SY5ULvsP9RvSngnjuu0AyNddv0ojHPfA/jhOP8zjYvYdGToRfiyJAw==
X-Received: by 2002:a17:906:6b92:: with SMTP id
 l18mr1733654ejr.145.1592296110725; 
 Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Received: from myrica ([2001:171b:226e:c200:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id c4sm10680797ejz.104.2020.06.16.01.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 01:28:30 -0700 (PDT)
Date: Tue, 16 Jun 2020 10:28:19 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 08/12] mm: Define pasid in mm
Message-ID: <20200616082819.GA590740@myrica>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
 <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1592008893-9388-9-git-send-email-fenghua.yu@intel.com>
X-Mailman-Approved-At: Tue, 16 Jun 2020 15:24:44 +0000
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
Cc: Dave Hansen <dave.hansen@intel.com>, H Peter Anvin <hpa@zytor.com>,
 Dave Jiang <dave.jiang@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86 <x86@kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Ingo Molnar <mingo@redhat.com>,
 Ravi V Shankar <ravi.v.shankar@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Tony Luck <tony.luck@intel.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jacob Jun Pan <jacob.jun.pan@intel.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 12, 2020 at 05:41:29PM -0700, Fenghua Yu wrote:
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 64ede5f150dc..5778db3aa42d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -538,6 +538,10 @@ struct mm_struct {
>  		atomic_long_t hugetlb_usage;
>  #endif
>  		struct work_struct async_put_work;
> +
> +#ifdef CONFIG_PCI_PASID

Non-PCI devices can also use a PASID (e.g. Arm's SubstreamID). How about
CONFIG_IOMMU_SUPPORT?

Thanks,
Jean

> +		unsigned int pasid;
> +#endif
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
