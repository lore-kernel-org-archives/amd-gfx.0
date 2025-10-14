Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5ACCD18F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Oct 2025 07:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE6710E564;
	Tue, 14 Oct 2025 07:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="OilukKMS";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21A3010E561
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 07:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760427235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2f+TEVmNHcIZWSH2C31Ng9eliwbtMBD5xTQThZ/PZk=;
 b=OilukKMSu42pV46NBFqbnT70tAnBSPt39yYIoREjDrDjti0kgBDOh0yIV/nOnfvaMkI0Uh
 ajmf39v7pWsGLFvz51N1b/n0KAF1fHu23RMdqf6Y4/uN25JS5dU9AieDfJV9B7EwGtce8L
 Bhuwi0MSeep25QnW19JUqRvEGOeF3IQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-2EQoYt2cM5y1P9YL0dE7pA-1; Tue, 14 Oct 2025 03:33:54 -0400
X-MC-Unique: 2EQoYt2cM5y1P9YL0dE7pA-1
X-Mimecast-MFC-AGG-ID: 2EQoYt2cM5y1P9YL0dE7pA_1760427233
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e3ef2dd66so33271345e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Oct 2025 00:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760427233; x=1761032033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G2f+TEVmNHcIZWSH2C31Ng9eliwbtMBD5xTQThZ/PZk=;
 b=szRXmjtQp6g8Om9DRInYrtKxeWC0NVGzYt5pfKCvTzjaUT6GLS6fV9Z0CZ+5zxPJiC
 28N+wyhMePOG555bjM8Ug220rtKreM957tqFSbPDDVrDqeAYGB72jAk0H7VbpW2rlWkQ
 bzGbSTe7MnIh0t2lErnU4AVNSchX5e0hLztzi8iHOUrBQ4rQlKDPnEEoICGYB33jZC1g
 qOtC5KqucZ6oKFAWIucGO52XchZu/cNh5oCH4iG7TsEhOAnEHQ6vb7bN9vT2kbNK2RBA
 sMCoe8d4Y7EC2fnlT+DSWIPfrmk8MW3u3A/mIgX+t1G2ShImqKhItiuuOYC12jzguQYQ
 a6EA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlXDSbnItmYwJWzf0c29NLc+H6RFDho0wvbURSUc5u/7VMivNxhqtue+sMlHrc0H7Ypune8fZd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNOvjuc6Q9Cryi6jv1l0tmPgHbqDIWJxKH0W2irJQqTck52bsg
 9BN90Xx5yyNUuJyHdrv38PTG1GdKWhBeA7SANrDLH+hSpFiqZFr8SYppTxPjxnF6A2rQms1bs+e
 lqAT4sPJmPqgf9PyyftoVTKuLCYSBiWCQOGmEGDzI0nJa2MO6dduLBXMeneD6WMOJpwA=
X-Gm-Gg: ASbGncvMTN+gXNUu1vyTEei7IRLw0soo7DGnF206tDvjflbpRGMLI5UDH1fSu2QTS9X
 nDO08mLd2dq8oX0ERbVhpzQMVHBsiqxX0l4pmG5YF6IqEFW1jYYh6V+D4KvDx1I9zaf439GAYNH
 ZDPHLmQSUUFYYxt5gp9hQ+gQJDFvQ83opD6JV6zy+hEZXr5No4RVlQbLDWadYqc+o3LzqCvImL5
 wLmkEZzm0PjP4Iv0+mi/NRdcc9HZJtwp9qeaOoEoOAFejuShEcer6bbqTJ7gtdgkKFL1WYk9LcY
 cuGIOtzw1rmoK3T4jI0Ks3UToC5KzPRl+4vwcAeThXYJyZM0OPpVtSi8i3GL1wfWY+iD7tVJE5d
 +MkRT
X-Received: by 2002:a05:600c:1277:b0:46c:adf8:cd82 with SMTP id
 5b1f17b1804b1-46fa2952c02mr135681155e9.3.1760427232816; 
 Tue, 14 Oct 2025 00:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBeNo7ZlnJvZO+4tdhdDmG+vIUKT7nCznXOA5q9opUrokbPvd9TwG1AFWjfUcvv1KmWXVDOA==
X-Received: by 2002:a05:600c:1277:b0:46c:adf8:cd82 with SMTP id
 5b1f17b1804b1-46fa2952c02mr135680875e9.3.1760427232370; 
 Tue, 14 Oct 2025 00:33:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb489ac60sm230694605e9.16.2025.10.14.00.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 00:33:51 -0700 (PDT)
Message-ID: <335fdb74-6d43-41e0-9774-eb57f425313d@redhat.com>
Date: Tue, 14 Oct 2025 09:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/client: Remove holds_console_lock parameter from
 suspend/resume
To: Thomas Zimmermann <tzimmermann@suse.de>, alexander.deucher@amd.com,
 christian.koenig@amd.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, lyude@redhat.com, dakr@kernel.org,
 lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com,
 javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20251001143709.419736-1-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251001143709.419736-1-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pbeAacc1Qn7lExGpb92v7lkU4EBl9ma8sD_OwJDu1ew_1760427233
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 01/10/2025 16:37, Thomas Zimmermann wrote:
> No caller of the client resume/suspend helpers holds the console
> lock. The last such cases were removed from radeon in the patch
> series at [1]. Now remove the related parameter and the TODO items.
> 
> v2:
> - update placeholders for CONFIG_DRM_CLIENT=n
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Link: https://patchwork.freedesktop.org/series/151624/ # [1]

For drm_log:
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

