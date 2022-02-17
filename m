Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC625C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 20:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 275E010E77C;
	Thu, 17 Feb 2022 20:08:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0754E10E784
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 20:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645128503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sK34GucLf1EjDJhzzUqx7/Oepkk2e4FDf8Dxqp0a2xc=;
 b=eWSeWg3hBS5tUBHEfMZ/Z9E56OBSVr3BKkcYkKB13hIxAer9KPbsFdHGh9zoVzsyu0kBtU
 18e8tZybrQNYnghBVDRm7pptt1Qd5PN7MvCl1GTQqYG7ZsOH5dZXBbhwihrBgUpArz+7fA
 +pLCNyxHi5K4kjwT9+wzYr4kMOeHatQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-l3nED4NPPcaENTG4hWJH4A-1; Thu, 17 Feb 2022 15:08:20 -0500
X-MC-Unique: l3nED4NPPcaENTG4hWJH4A-1
Received: by mail-qk1-f199.google.com with SMTP id
 m22-20020a05620a221600b005f180383baeso5186965qkh.15
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 12:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
 :user-agent:mime-version:content-transfer-encoding;
 bh=sK34GucLf1EjDJhzzUqx7/Oepkk2e4FDf8Dxqp0a2xc=;
 b=HAmVnl8nGQ3ls7cyGPW5Faig4N/Mgg8scMpSpOGl3r4oXjCD+4ziaZQo76TXgtSa6C
 yaolOP1OrhnRW3ox8JhIb9aVke69UfwAITssOMYKqvSmaY2L5FKbwVMFdEMwGEaM7OCv
 oaNd27OIXJuHPExrI081tJ2jk9FZYORunkh9OGAfzya03G5Stp2M1sZGzynZFXZR55Z8
 ivn9z/Jsuy6pvKGligpspCGCfRXb0pHjfRS4Rvm9emqYaDBNzQfUWV/hCK2RbF3xhAIb
 ucRfksVIvd6xteOMMKOfc/KLHJ6jUUtEkcXo3Q1HwL9hvysgKI2dPscjVCs0DMqmqrsP
 bnGQ==
X-Gm-Message-State: AOAM531YvKLkHUkIn2LuJ5Xfaekp39ir7Ed2fD/BmSxAzv5n0Timio6T
 svVCe4cAI2V5skxVQ2qjabbki1KOPUoZZEqirnwMIylZZZdoZGuDlbcL5LQR9nkyo/OfsseW0J6
 +4oaGs+J436utjemTLExkkgFfxg==
X-Received: by 2002:a05:6214:2528:b0:42c:1599:12 with SMTP id
 gg8-20020a056214252800b0042c15990012mr3420826qvb.76.1645128500382; 
 Thu, 17 Feb 2022 12:08:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJycbxYMpaPo61PhTMr/DZq7LFboQhm1n/b16fcARkC40ffOKYC2XX1xA9CYu8QhyI7O53ib0A==
X-Received: by 2002:a05:6214:2528:b0:42c:1599:12 with SMTP id
 gg8-20020a056214252800b0042c15990012mr3420803qvb.76.1645128500128; 
 Thu, 17 Feb 2022 12:08:20 -0800 (PST)
Received: from [192.168.8.138] (pool-96-230-100-15.bstnma.fios.verizon.net.
 [96.230.100.15])
 by smtp.gmail.com with ESMTPSA id i4sm22182394qkn.13.2022.02.17.12.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Feb 2022 12:08:19 -0800 (PST)
Message-ID: <db5decb525e7ab36cd4875ef5c6bba942b46d7c7.camel@redhat.com>
Subject: [Important!] 2022 X.Org Foundation Membership deadline for voting
 in the election
From: Lyude Paul <lyude@redhat.com>
To: xorg@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 events@lists.x.org, xorg-devel@lists.freedesktop.org, 
 wayland-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 mesa-dev@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 etnaviv@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 libre-soc-dev@lists.libre-soc.org
Date: Thu, 17 Feb 2022 15:08:18 -0500
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35)
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lyude@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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
Cc: board@x.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 2022 X.Org Foundation elections are rapidly approaching. We will be
forwarding instructions on the nomination process to membership in the
near future.

Please note that only current members can vote in the upcoming election,
and that the deadline for new memberships or renewals to vote in the
upcoming election is March 17th 2022 at 23:59 UTC.

If you are interested in joining the X.Org Foundation or in renewing
your membership, please visit the membership system site at:

https://members.x.org/

You can find the current election schedule here:

https://www.x.org/wiki/BoardOfDirectors/Elections/2022/

        Lyude Paul,
        On behalf of the X.Org elections committee


