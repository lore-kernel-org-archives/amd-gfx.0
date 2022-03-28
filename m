Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0860C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 21:18:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8298510E171;
	Mon, 28 Mar 2022 21:18:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE4BD10E11D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648502315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=o/20j76lcDPeDTIfcY54M2M3yeP1hzS1Frzdk4vK99I=;
 b=G8RGRjqC9+uChOZKtx5BttR8JSr3hhnwHBOCSNekpDloK0fUbkebC2U0Fb3fl0NJi8oZnp
 N8/ch/UD9wfK/pMI4zesJMgn9odRg0FhERVa7IKQ0YyDjcuoV8fFUmzs3VfgSwzehBb/FL
 31vKWA+bqkDg3/RExwZA4RRb88j76YU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-enHpNaSRPfmBMdWJJIy-Rw-1; Mon, 28 Mar 2022 17:18:29 -0400
X-MC-Unique: enHpNaSRPfmBMdWJJIy-Rw-1
Received: by mail-qv1-f72.google.com with SMTP id
 fw9-20020a056214238900b0043522aa5b81so12251276qvb.21
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 14:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=o/20j76lcDPeDTIfcY54M2M3yeP1hzS1Frzdk4vK99I=;
 b=HlHoA9sxUAh9fvdziP8UiYEd+HMS5otRF0yyowWxNXOE87DiVhahwYT3S9c1UB6lXB
 THtpnmCe+q8C2UWn3yEAQr7R2dwv93xp+cOdY7opm0e1tE6m1i6ag+hLAWAlHLC9Os7Z
 jrI6TOVxcU5dtZftzSTlsbFt6pB+U3Ko7xu5XfNsWQkQ8sAWFm7bRTcKcWg8b3c2zOCL
 mWlD7swBo9UkBqL5sR1Um0HwCAwO6TzIpgClN+JVOISNoKFabPw+N/sXx7RYMC5NDYhB
 CSENCK9pPPqlACyrAXaRieadAwob1iRyHoQLudctP9DrLUtw2r6cH2KbjyhuzWdeLjM2
 +wdg==
X-Gm-Message-State: AOAM531pvzE7jaV8rn4B1kQ7LYwbcw7UjwZURuuJkWFnNwzTAiSAxspi
 xGZ4U3/85aiG/tit9tb+/Opm3rJcn6LEagr9DWPvadk6tmLSMOI0xPVvD4FycFtVYJIMdmOoxEH
 y4A3pPsPrMVMfEMxZOJVvmPiQ6w==
X-Received: by 2002:a05:6214:29c8:b0:440:fac2:a6c with SMTP id
 gh8-20020a05621429c800b00440fac20a6cmr23153273qvb.96.1648502308563; 
 Mon, 28 Mar 2022 14:18:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx80FvxqgxoMsKHifZxJPlSaASMzEtm2PCjdcW91NHHki6CRsyrlYXzQuiJUFDSkSZnID/Qgg==
X-Received: by 2002:a05:6214:29c8:b0:440:fac2:a6c with SMTP id
 gh8-20020a05621429c800b00440fac20a6cmr23153243qvb.96.1648502308333; 
 Mon, 28 Mar 2022 14:18:28 -0700 (PDT)
Received: from [192.168.8.138] (pool-71-126-244-162.bstnma.fios.verizon.net.
 [71.126.244.162]) by smtp.gmail.com with ESMTPSA id
 br13-20020a05620a460d00b00680d020b4cbsm2856816qkb.10.2022.03.28.14.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 14:18:27 -0700 (PDT)
Message-ID: <dc0ead0da30d0ccf8c4c57a2548d293c57407080.camel@redhat.com>
Subject: 2022 X.org Foundation Election Candidates
From: Lyude Paul <lyude@redhat.com>
To: events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Mon, 28 Mar 2022 17:18:21 -0400
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.DarkModeFix.fc35)
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

To all X.Org Foundation Members:

The election for the X.Org Foundation Board of Directors will begin on 04 April
2022. We have 6 candidates who are running for 4 seats. They are:

    Emma Anholt
    Shashank Sharma
    Ricardo Garcia
    Mark Filion
    Lucas Stach
    Alyssa Rosenzweig

To be found in the link below below are the Personal Statements each candidate
submitted for your consideration along with their Statements of Contribution
that they submitted with the membership application. Please review each of the
candidates' statements to help you decide whom to vote for during the upcoming
election.

    https://www.x.org/wiki/BoardOfDirectors/Elections/2022/

If you have questions of the candidates, you should feel free to ask them here
on the mailing list.

The election committee will provide detailed instructions on how the voting
system will work when the voting period begins.

Lyude Paul, on behalf of the X.Org elections committee

