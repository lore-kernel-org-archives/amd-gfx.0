Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6298FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D770F10E2CC;
	Tue, 26 Apr 2022 18:34:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93D4010E2C6
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650998074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=eJubVxidxrH43nT1ZcESqGVo+TV4vGiI9S8510OYaUk=;
 b=d7aZ+8YfcSH/Rck7V2XQ/4epEAoRZ7zaVfVjfdZoQsg/PtLIWf0HI9oFJzD4H2XghVCDrR
 21++f1O+1PmkZThWmd1HXMgNNIgzSw6rnt14sDJ06q0hINVuNq1+Xb33nFUUew451O14WI
 Rf7kB5FLXUuNRJf7u3b8/I/U1SoIbm4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-o9G1Q32BMWKE8JmiC6oqYQ-1; Tue, 26 Apr 2022 14:34:33 -0400
X-MC-Unique: o9G1Q32BMWKE8JmiC6oqYQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 e66-20020a378245000000b0069f23a82b5bso7298262qkd.22
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 11:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=eJubVxidxrH43nT1ZcESqGVo+TV4vGiI9S8510OYaUk=;
 b=tNzhyd612di8fNGg5lZ7XSbzcOXG5xSSVXIc9izq6cEHzKCzN49fBP1F/0EtUOfL5s
 8K5LieqjDnGX+QCc/6bYApOQbdB0yXXj13tpycU/cvF299FCPeTPGqd0iNSfUwNMRCsr
 WRvVsfgRjHaZWM+H+/dXQqAWVT1zH+6oge0oFn2VnvyvU5XSkzkNDZyH93jXnOVyqzXS
 xv04MHfeCtIL+WqS44dJ62qK30s0947f0VzY1ynKPENfSU6Ku1QDecWLf+RmlRaOu5Qd
 lJsfDGKGsqqhPRKS8p02Aww44cVF9JDn76BhqiI1BC3DbvI/XV0VGGrNAB6GjTP3tzkF
 ardw==
X-Gm-Message-State: AOAM532D+uIEevj7cqgxbAvxuiY5O9sVKP1CRksPxVjCbbbLKE8kdd9W
 +f270IJRXZvRGv9gP88vIM2nQYBkAdkaoXO5hhSgYoiEkhDq+4QAjcmMTjAawt9gzTNWzQCMlDe
 rwBqGPnidqRtBLgWG/cMDUprBvQ==
X-Received: by 2002:a05:6214:4011:b0:446:63b6:8b51 with SMTP id
 kd17-20020a056214401100b0044663b68b51mr17416038qvb.43.1650998072511; 
 Tue, 26 Apr 2022 11:34:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSTyxghOMakuSzLg+vVd1jQRAhTlvSuZxjU1DMb91ySKyNOQTzvYi4NffiezRcnRfbz+CZSQ==
X-Received: by 2002:a05:6214:4011:b0:446:63b6:8b51 with SMTP id
 kd17-20020a056214401100b0044663b68b51mr17416023qvb.43.1650998072239; 
 Tue, 26 Apr 2022 11:34:32 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net.
 [71.184.137.158]) by smtp.gmail.com with ESMTPSA id
 22-20020ac85916000000b002f3402e34a3sm8785857qty.55.2022.04.26.11.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 11:34:31 -0700 (PDT)
Message-ID: <fa4b1543a0547d505d73a74002eedc12de03e910.camel@redhat.com>
Subject: XDC 2022: Registration & Call for Proposals now open!
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Tue, 26 Apr 2022 14:34:30 -0400
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
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
Cc: board@foundation.x.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello!

The 2022 X.Org Developers Conference is being held in conjunction with
the 2022 Wine Developers Conference.  This is a meeting to bring
together developers working on all things open graphics (Linux kernel,
Mesa, DRM, Wayland, X11, etc.) as well as developers for the Wine
Project, a key consumer of open graphics.

Registration & Call for Proposals are now open for both XDC 2022 and
WineConf 2022, which will take place on October 4-6, 2022 in
Minneapolis, Minnesota, USA. 

https://xdc2022.x.org
 
As usual, the conference is free of charge and open to the general
public. If you plan on attending, please make sure to register as early
as possible!
 
In order to register as attendee, you will therefore need to do it via
the XDC website:
 
https://indico.freedesktop.org/event/2/registrations/2/
 
In addition to registration, the CfP is now open for talks, workshops
and demos at XDC 2022. While any serious proposal will be gratefully
considered, topics of interest to X.Org and freedesktop.org developers
are encouraged. The program focus is on new development, ongoing
challenges and anything else that will spark discussions among
attendees in the hallway track.
 
We are open to talks across all layers of the graphics stack, from the
kernel to desktop environments / graphical applications and about how
to make things better for the developers who build them. Head to the
CfP page to learn more: 
 
https://indico.freedesktop.org/event/2/abstracts/
 
The deadline for submissions is Monday July 4th, 2022.
 
Check out our Reimbursement Policy to accept speaker
expenses for X.Org events like XDC 2022:
 
https://www.x.org/wiki/XorgFoundation/Policies/Reimbursement/

If you have any questions, please send me an email to
xdc@codeweavers.com, adding on CC the X.org board (board
at foundation.x.org).
 
And don't forget, you can follow us on Twitter for all the latest
updates and to stay connected:
 
https://twitter.com/XOrgDevConf

Best regards,
Lyude Paul, on behalf of X.org

