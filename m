Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D71C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 16:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BF9233F6
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 16:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BF9233F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 251146EB33;
	Wed, 13 Jan 2021 16:47:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D886EB33
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610556474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMP7Uu1omhLwuQabuN/ve5GPqmI9hcJSvp6O8aAN+hk=;
 b=Cdncl/Ib2uGksThsZn0L4NIsAMGIXWkk4S8iHIiH6IkXJrTrKfBmUbt5tQwavV4cPMggqe
 3Wx+Fvc03ShotvbX2V6u+oOgR/CUdjQYvP23Uz2f6NdbBOrgsMhf+9pPV2HXM7JB8eT5ml
 bu0OgGdiCe5squUrEulU6kFmiO0Hlsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-OEGxfA5QMVy3HCehMr_M6A-1; Wed, 13 Jan 2021 11:47:51 -0500
X-MC-Unique: OEGxfA5QMVy3HCehMr_M6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6BA7806660;
 Wed, 13 Jan 2021 16:47:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 431A81001901;
 Wed, 13 Jan 2021 16:47:49 +0000 (UTC)
Date: Wed, 13 Jan 2021 11:47:47 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 00/35] Add HMM-based SVM memory manager to KFD
Message-ID: <20210113164747.GA521755@redhat.com>
References: <20210107030127.20393-1-Felix.Kuehling@amd.com>
MIME-Version: 1.0
In-Reply-To: <20210107030127.20393-1-Felix.Kuehling@amd.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jglisse@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 06, 2021 at 10:00:52PM -0500, Felix Kuehling wrote:
> This is the first version of our HMM based shared virtual memory manager
> for KFD. There are still a number of known issues that we're working thro=
ugh
> (see below). This will likely lead to some pretty significant changes in
> MMU notifier handling and locking on the migration code paths. So don't
> get hung up on those details yet.

[...]

> Known issues:
> * won't work with IOMMU enabled, we need to dma_map all pages properly
> * still working on some race conditions and random bugs
> * performance is not great yet

What would those changes looks like ? Seeing the issue below i do not
see how they inter-play with mmu notifier. Can you elaborate.

Cheers,
J=C3=A9r=C3=B4me

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
