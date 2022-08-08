Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5879C00140
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Aug 2022 23:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12C1A68D7;
	Mon,  8 Aug 2022 23:08:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED2DA6665
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Aug 2022 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660000041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTykkjMreZGlPtiHtJZVriJJcrzikHVxhAuXCB1qSxU=;
 b=GJPrdjID4RrT99pF1/+MGkpwb9teDdOVr2vJK9n2EqESVvWK65Kv/xATL3Xkn6cmCUusPq
 P/frmVPGzdHSb7B8qhQqnX2vkQesmLrfpZl9+cwLpGgYowq+C77LdGWYcE3zjcigeRZwck
 amwYQ8MWvwheQxb7sHNzEJeKuWe4F78=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-yMZfkUsoO8yHA1Rq4OKqXA-1; Mon, 08 Aug 2022 19:07:20 -0400
X-MC-Unique: yMZfkUsoO8yHA1Rq4OKqXA-1
Received: by mail-qt1-f199.google.com with SMTP id
 bb40-20020a05622a1b2800b00342eb08cc48so5087647qtb.17
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Aug 2022 16:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc;
 bh=VTykkjMreZGlPtiHtJZVriJJcrzikHVxhAuXCB1qSxU=;
 b=WGhSvWGEls7u7ZjbhwnOa3oTiHUkJzMNT1ROVoQTDevm+Weet2Bbvt2hs405th7s18
 UHDh1VQqDo0ecAlrV/CXEdcDILyOQZVgqViUmILttL4Q8KDmv+oHOeinESOUcD+2sEbj
 7FFJa3t0QsJjWyq2Pi4CYSNWGJe1D4U04VfY8Y9YyLMgvtChh4fTj7kxMnhN+2J7huzV
 UuMtKuIDMXamjNBamXoLd5FwUuLlVfRcQf2+ADDTO/BXM+Kz1eAnjY8O1/dE2EYjPCXP
 reDM8FrIBUXHZO6q86XPewx9UQ6k4OOG2p69meKGmoDSbMve3ifTG3X1m4oY6VTEKy2+
 jHYg==
X-Gm-Message-State: ACgBeo3lesvICC97XLCrdkllzI/h8p9NZKw28dOLqBRoeaQ6par8atWf
 0KJkRjAmqhmscLsLEPt3+OQwD8yrKptrbVixRaS5CWOaIg5/y0l1Z5PuV4ed9MZrbLKAgPvbZbd
 /XMzqSbg01e5Tmz1+oRmh9vaedw==
X-Received: by 2002:ac8:5bd3:0:b0:343:3d7:b35e with SMTP id
 b19-20020ac85bd3000000b0034303d7b35emr2847921qtb.684.1660000039784; 
 Mon, 08 Aug 2022 16:07:19 -0700 (PDT)
X-Google-Smtp-Source: AA6agR46tDYlnYw3pgmddX2HjPE1Rbd1ysZz8fH6jnfgN+WWv+32bU9uk9MafWASDaWLB6SisWPYGw==
X-Received: by 2002:ac8:5bd3:0:b0:343:3d7:b35e with SMTP id
 b19-20020ac85bd3000000b0034303d7b35emr2847909qtb.684.1660000039598; 
 Mon, 08 Aug 2022 16:07:19 -0700 (PDT)
Received: from [192.168.8.138] (pool-100-0-245-4.bstnma.fios.verizon.net.
 [100.0.245.4]) by smtp.gmail.com with ESMTPSA id
 bm32-20020a05620a19a000b006b8e63dfffbsm10296141qkb.58.2022.08.08.16.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Aug 2022 16:07:18 -0700 (PDT)
Message-ID: <cab2385388606f3292e55d962a8ddedac0540f2c.camel@redhat.com>
Subject: Re: [RESEND RFC 06/18] drm/display/dp_mst: Add some missing kdocs
 for atomic MST structs
From: Lyude Paul <lyude@redhat.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "nouveau@lists.freedesktop.org"
 <nouveau@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Date: Mon, 08 Aug 2022 19:07:17 -0400
In-Reply-To: <CO6PR12MB548907FE2E64F8D8CC5D5227FCAD9@CO6PR12MB5489.namprd12.prod.outlook.com>
References: <20220607192933.1333228-1-lyude@redhat.com>
 <20220607192933.1333228-7-lyude@redhat.com>
 <CO6PR12MB548907FE2E64F8D8CC5D5227FCAD9@CO6PR12MB5489.namprd12.prod.outlook.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Jani Nikula <jani.nikula@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Imre Deak <imre.deak@intel.com>, open list <linux-kernel@vger.kernel.org>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 David Airlie <airlied@linux.ie>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>,
 Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also JFYI - I did see this comment but didn't address it in my respin, but
only because I figured this might be better for a followup patch considering
how much work is already in here

On Wed, 2022-06-15 at 04:43 +0000, Lin, Wayne wrote:
> I would prefer not using the term "available" which is a bit conflicting with
> the idea in the reply of ENUM_PATH_RESOURCES - full PBN & available PBN.
> Maybe better to change to use "full_slots"?
> 
> Not yet finish all the patches. Will try to go through all the patches recently : )

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

