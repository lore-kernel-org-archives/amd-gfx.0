Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACABEC4361B
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:07:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F77323EF1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 09:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F77323EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5E96ECE7;
	Fri, 11 Dec 2020 09:07:53 +0000 (UTC)
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9236ECE7
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 09:07:52 +0000 (UTC)
Received: by mail-ed1-x544.google.com with SMTP id u19so8565721edx.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Dec 2020 01:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2uC5uI5r9WoacbKJDeePEZlG1BDYJm247+OaScIR7DA=;
 b=e6E2OZtFQtR1FSJYBlRe/upCVVEO5cybi+FW1gNUdw8ylMQ2Q5YlRXHmVVdxeO19+B
 VT3K0/v7ZW8FIEyiBQGlipE2C/pVWDy2t/+S8JuivfOLI0L9eQFvUiIHaEMRBQ5jZgia
 mIErJzmFsjcMfR1BDnhHl5O+j2AIB8T6FmZPmMAJ+3LPRjJc2YRPUACVLpf2rg5tQJ94
 Wu0KJKmuLm6HJ3tSb7b0oPE7wzp5mQadkId+py+XIVjXGX4ZDW3z+JQWqkQhM0tmZCoi
 TzgMp6oGQmobN39wN8CZcFLmeDUz9Qo0T9hVr+GlfOCKiqRzYRptY8yI5RjVcvQ12tfA
 5oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2uC5uI5r9WoacbKJDeePEZlG1BDYJm247+OaScIR7DA=;
 b=sM9u8d7u7+eFePzbCe7pNMxi8zWW0Y6AuObI96zrXmZBq+XP1uTVHuJbelKiqr1tbo
 yUUcD29eXmtnHVnQbzn1l0apOwwLptN+Rz/yM4rzSUG3SkIInAa6ddOd90G0uUP6W42b
 HHT1iQVRclRpiaMhJ40iPJy5O8D1r2IRCPTkKwk/mnOZBaaCWfWdDyUSzR9PFxQ/eh3d
 YPo+4SI6nCc0Z6/19Qo0iPfk+5SaqQJbs6GA3gzQHL1baMjvZf63pXF3Zd+PN7zWkdfP
 pNzvOpOZ9lQAARXlzrNd7gq5sRWewW1vm/TUPC1Jk8nNm+meZk4A3jCozD9+r1ZtmfjF
 e92Q==
X-Gm-Message-State: AOAM532aG/fAPFdQK+KS82eeLf5FW/QXw6wx8Z4tuhBe4Fv/i7F4IQVW
 lk0jTgo2GQHMfmOcA6tr3jqLQqnlBio=
X-Google-Smtp-Source: ABdhPJxY/Qm7gpYzzwguVhAX0QBjZzHgOxMcp151379KwCDBN1rdJczDKzUsx0gfVhhRXGrSOWsVqg==
X-Received: by 2002:aa7:c0d6:: with SMTP id j22mr10766403edp.31.1607677670524; 
 Fri, 11 Dec 2020 01:07:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f18sm7106562edt.60.2020.12.11.01.07.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Dec 2020 01:07:50 -0800 (PST)
Subject: Re: [PATCH 1/7] pci: export PCI BAR size-reading functions
To: Darren Salt <devspam@moreofthesa.me.uk>, amd-gfx@lists.freedesktop.org
References: <20201211005506.4554-1-devspam@moreofthesa.me.uk>
 <20201211005506.4554-2-devspam@moreofthesa.me.uk>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a4bae8bb-dc56-7e43-b0f8-4545ec909e87@gmail.com>
Date: Fri, 11 Dec 2020 10:07:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201211005506.4554-2-devspam@moreofthesa.me.uk>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.12.20 um 01:55 schrieb Darren Salt:
> This is to assist driver modules which do BAR resizing.
>
> Signed-off-by: Darren Salt <devspam@moreofthesa.me.uk>
> ---
>   drivers/pci/pci.c   | 2 ++
>   drivers/pci/pci.h   | 2 --
>   include/linux/pci.h | 4 ++++
>   3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e578d34095e9..3f6042d9ad83 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3579,6 +3579,7 @@ u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar)
>   	pci_read_config_dword(pdev, pos + PCI_REBAR_CAP, &cap);
>   	return (cap & PCI_REBAR_CAP_SIZES) >> 4;
>   }
> +EXPORT_SYMBOL(pci_rebar_get_possible_sizes);
>   
>   /**
>    * pci_rebar_get_current_size - get the current size of a BAR
> @@ -3600,6 +3601,7 @@ int pci_rebar_get_current_size(struct pci_dev *pdev, int bar)
>   	pci_read_config_dword(pdev, pos + PCI_REBAR_CTRL, &ctrl);
>   	return (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
>   }
> +EXPORT_SYMBOL(pci_rebar_get_current_size);

This is unnecessary. You can just look at the resource size instead 
which is also more defensive regarding problems/errors.

Christian.

>   
>   /**
>    * pci_rebar_set_size - set a new size for a BAR
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index f86cae9aa1f4..8373d94414e9 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -608,8 +608,6 @@ int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
>   			  struct resource *res);
>   #endif
>   
> -u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
> -int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
>   int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
>   static inline u64 pci_rebar_size_to_bytes(int size)
>   {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..5aa035622741 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1226,7 +1226,11 @@ void pci_update_resource(struct pci_dev *dev, int resno);
>   int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>   int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
>   void pci_release_resource(struct pci_dev *dev, int resno);
> +
> +u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
> +int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
>   int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
> +
>   int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>   bool pci_device_is_present(struct pci_dev *pdev);
>   void pci_ignore_hotplug(struct pci_dev *dev);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
