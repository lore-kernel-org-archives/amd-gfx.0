Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD7C433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 08:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072C764E4A
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 08:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072C764E4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52B196E0A5;
	Sun, 28 Feb 2021 08:51:46 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 181586E0A5
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 08:51:45 +0000 (UTC)
Date: Sun, 28 Feb 2021 08:51:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1614502302;
 bh=rqrU85mKAf1m/dpW4StJ7wZvMN9yMgwq6gamXG2nkMM=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=lemkLZgAtnUswuhY2+G4htjmz8bEN/IAm9ORfe/2FxMM0ov5gQjL2rV45V4/yQMfw
 +ECZbE05e5BRW2PwD/9Qdc9RBQet7eq3D0YY4Ng6jcTL2a6vHA5Ab7UWuDzJ1i/De1
 XZ8mU1wvCRwK7HwV1MhtPtWZpQ2NpcU2EEzhjaKfi7HPE6DK+JRWxpcX6XBXywD6uw
 GuugOn19EMWn2jCUUXtzoour4rUNY8h1Z7LxVQEFW2tLPpkxwugooNEwYEn1hG7uUZ
 60rA36AGXo9axcaKvWgT8nQgPjbxJvT0/ytUa6eehemIDJxUC4Nycce2urt8X71osW
 B/9GyFCBJQuhw==
To: "Cornij, Nikola" <Nikola.Cornij@amd.com>
From: Simon Ser <contact@emersion.fr>
Subject: RE: Overlay issues
Message-ID: <j-UGiIngTVGXVwcM2Ynd32pfOemhZI8rApiiaqt6O5ZZY5Vgot8eGskObaOe2A6GznJW42pr7xt8DB55dvIU4-x9DoE8yhA-NWZu2YB1kTo=@emersion.fr>
In-Reply-To: <DM5PR12MB4679498E09A74977446CF66FEE9C9@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM5PR12MB4679C807DB8DB502AC4793DCEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <05FNtjCma79AawCUxH3mqJ8sWHmoIXFXhQWW0N_b-mpl7QvuW3JN3AbtPUiR0y1LOf3tLhWFWv8YjuIEvJ3dci9y1EHk_D9a9L1BAyWyxRs=@emersion.fr>
 <DM5PR12MB4679F2B26887B76BC025161AEEC60@DM5PR12MB4679.namprd12.prod.outlook.com>
 <DM5PR12MB46792E5F8DF0F128FF01D79EEEDE0@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Zq5awE32--JJaePI-8O0Rd-2AYVUPYgIn1PspErRR_qpQeTlX_L0M_8iQMyN6rGZPJRuBmkf6OGmeQFLYkzB9cswAhdyWbAzEXqT-0ZjFC4=@emersion.fr>
 <DM5PR12MB4679C406F33E9B04BA343295EE819@DM5PR12MB4679.namprd12.prod.outlook.com>
 <Kdv-dXZJZAwHurjWGxke0BycsKRikMsY_omFpPVknQqoLWCweXWWMs9ET6_Ax0hIMvFKornwDJ2i5MXyspmEykuloW5IppjT-w6NT6vfIBU=@emersion.fr>
 <DM5PR12MB4679498E09A74977446CF66FEE9C9@DM5PR12MB4679.namprd12.prod.outlook.com>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Improved the patch, now in the process of getting it reviewed
> internally. It'll be posted for upstream thereafter.

Thanks, perfect!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
