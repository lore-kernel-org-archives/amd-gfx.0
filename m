Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381AC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 22:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6D7D10E26D;
	Wed, 19 Jan 2022 22:56:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC90C10E272
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 22:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642632973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6jpHE1+BpzE8oEcVzu2U7JQ8f9cnoxZjC0hx7dFA8fk=;
 b=O7d2c7TPto7/m2COa3Zw/pr2aY3Sm8Rh4PTskP4D86gVgtLGvc+YPIrKDO763dlWntm+FS
 BeqX28R41t/R5MSW6BhvVuSDE72CpxpaypLG1H4y5BdOohWWeMohHJ5idPreUc2s5xPl67
 RI2jMfHqj1tGW5rOrQQN/vOsNp7Pgss=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-0L_qfE6uPxKoKXfGRfANMg-1; Wed, 19 Jan 2022 17:56:12 -0500
X-MC-Unique: 0L_qfE6uPxKoKXfGRfANMg-1
Received: by mail-qv1-f71.google.com with SMTP id
 jq14-20020ad45fce000000b0041f389903aaso3677015qvb.18
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 14:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=6jpHE1+BpzE8oEcVzu2U7JQ8f9cnoxZjC0hx7dFA8fk=;
 b=LkacAZ9MvIa9AnNxRbicQe5BtnlZijuBSjh/+jaZ4+wnGkVbqw1Jf1xLjp4fiN5xMh
 p0MIjjzW1e81KaOgvj4jpRWzBztoCSVISOoxIOpAgsl2/DDkf/5jLbFDZKyQjdmaHYj9
 aVp+n8H7TgWVlpF4bce+jjf7wpE/g09I54+A08Us4ERv+LP9t8KjryTsbN3xMYmUOrjW
 i3IMiEkxjo6ZS/PmXasUPYBysDGrxi4gvmKueX8R8gML440Acf2Ld045PYi2UY+MJ8MB
 MpZNDiCgAatCJ+Ax9UpRmvbDlHC6DsZiLhoCAAf/VTxwviHHExHOKphBOj/sPNAChESn
 ux7A==
X-Gm-Message-State: AOAM531ueMlinHo7raHtve66/FHrRlwhFpULXU4iL4xQZ/PrIjkZ6Xhs
 PZm7iwkkCByx9brBHzjJ8EfYJqsApLcYHjYdRDlA4QOy+HLTRZk/Z3Ms94HIS7sHEooLvs9VJnZ
 n2ZkgsTrc/gQG2x8iMuhAl59rG8LTOhZE+E6olcNbgtlq4//7+0suvkqDSXRUgIqL8GqZW4zd+g
 ==
X-Received: by 2002:a05:622a:34a:: with SMTP id
 r10mr26279215qtw.366.1642632971416; 
 Wed, 19 Jan 2022 14:56:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDwfhs6HQW/ujJsVKfvb9EqWiZArF7OrbNbWpbD/kTCfgy+xtlQdS0Pj7WTZmb09QRIlcO+g==
X-Received: by 2002:a05:622a:34a:: with SMTP id
 r10mr26279203qtw.366.1642632971031; 
 Wed, 19 Jan 2022 14:56:11 -0800 (PST)
Received: from [192.168.8.138] (pool-98-118-105-43.bstnma.ftas.verizon.net.
 [98.118.105.43])
 by smtp.gmail.com with ESMTPSA id h17sm511894qtk.19.2022.01.19.14.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jan 2022 14:56:10 -0800 (PST)
Message-ID: <15588b86c92b18144be1574826f38f90e9b752ba.camel@redhat.com>
Subject: [RFC] amdgpu MST questions, and future plans
From: Lyude Paul <lyude@redhat.com>
To: amd-gfx@lists.freedesktop.org
Date: Wed, 19 Jan 2022 17:56:09 -0500
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
Cc: dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi! I'm writing this email because I'm currently finishing up removing pretty
much all of the non-atomic MST code in drm_dp_mst_topology_mgr.c as it's
really made it difficult to maintain MST over time. As well, once that's
complete it's likely I'm going to start on the (extremely overdue) task of
moving as much of amdgpu's MST code for DSC out of amdgpu and into the DRM
code where it's supposed to live.

This brings me to two questions. The first major one being: is anyone capable
of testing the MST support in radeon.ko to figure out whether it works or not?
I've already talked with hwentlan and ag5df about this and they haven't been
able to find anyone to help with testing this. The reason I ask is because
radeon isn't an atomic driver, and is basically the only user of any of the
non-atomic parts of the MST helpers. If anyone want to prevent this from
breaking in the future, I would definitely recommend they step up to try and
help with testing it - otherwise I'm probably going to be pushing for us just
to drop the code entirely.

The second question is: is anyone willing to help me figure out how much of
the code in amdgpu related to DSC is definitely not amdgpu specific and can be
moved out? I'm honestly having a lot of trouble wrapping my head around how
some of this works, and how much of this code is even needed. As well, with
the amount of issues I've already found in it (there's numerous spots where
we're storing MST state outside of atomic state for instance, lots of
duplicates of DP helper functions that should not be here, etc.) it's quite
likely I'm going to be rewriting rather large chunks of it. If anyone would
like to volunteer please let me know, it'd be super appreciated and likely
will make reviewing the patches that will come out of this easier.
-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

