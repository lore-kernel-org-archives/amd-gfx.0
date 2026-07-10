Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A26CBC43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 06:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2470B10F78B;
	Fri, 10 Jul 2026 06:46:07 +0000 (UTC)
X-Greylist: delayed 369 seconds by postgrey-1.36 at gabe;
 Fri, 10 Jul 2026 06:46:05 UTC
Received: from us-smtp-delivery-44.mimecast.com
 (us-smtp-delivery-44.mimecast.com [205.139.111.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B76910F78B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:46:05 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-avuHxtz3OUaIoJUStDF6PQ-1; Fri,
 10 Jul 2026 02:39:53 -0400
X-MC-Unique: avuHxtz3OUaIoJUStDF6PQ-1
X-Mimecast-MFC-AGG-ID: avuHxtz3OUaIoJUStDF6PQ_1783665592
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA73E18052CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:52 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4A2BF30001A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 06:39:50 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu: sspl small piece of dieting to start
Date: Fri, 10 Jul 2026 16:37:41 +1000
Message-ID: <20260710063946.2262582-1-airlied@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jHY9ziQLp3PIKm_gZWfj-N2mBfrGAp3WwZYt_iTh7Ek_1783665592
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
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

I was just idling wandering around in dc and fell across this spl library
imported from userspace, in the worst possible way, now I'm willing to
forgive some bits, but this is horrible, and I'm not happy this passed
review.

I've started by ripping out a bunch of duplication that at least drops
by kernel driver build by 6k. 6k out of 12M but we all have to start somewh=
ere.

Dave.

