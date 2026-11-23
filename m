Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD9606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=n5f3LAQy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF81810E148;
	Mon, 23 Nov 2026 13:54:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A39F110EBDE
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=mc5BLRJT/rIUvt3WEEI4WwycTbKPyLioriXYWWrGRXA=; t=1795429400; 
 x=2110789400; b=n5f3LAQyNaxZSny6c3C0ksiGdmqYcTBhDIp4uN2cDtnSOzo7zXzpwyOu8YYcJ
 OZPVH3kj8gipK6OM/kLrVazE7XEwBst6q8/AsVI2RevdPCV+KAbTaDLfXbJgD43YT0ygb8iOjb+cr
 B0uWCES+w138e/gM1EtLDEQvO34UNMD7F3c4XMfBIYUvOQnt7FMnlClJjaHJzEg0I+73RlvdOYOoC
 84s/ROYzWLJoBSDiN7Y5CuW+/TO+/RyguTCNrSr1XX9XtN0a2lQe0kXJDHmN4O1cV4I6cU4qAWgAO
 6MreBWSQp+anv8PpUGRnQY7HXAHKUCHj8oGt0IQpQBMALT3boQ==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVRCg-00000002sj3-2f9D; Mon, 23 Nov 2026 11:23:19 +0100
Date: Mon, 23 Nov 2026 07:23:14 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: "Mu, Zihao" <Zihao.Mu@amd.com>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [RFC PATCH v3 0/5] drm/amdgpu: prepare updates across page-table
 allocation
Message-ID: <awQUEmwUoWSSDDOV@quatroqueijos.cascardo.eti.br>
References: <MW3PR12MB4572FABB93F6676FDBA1D2479E722@MW3PR12MB4572.namprd12.prod.outlook.com>
 <4edd67f7-381a-4446-9509-552739c8f016@amd.com>
 <MW3PR12MB4572A08ADA8CB7BA9F83AF519E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <938026a1-3b02-40b4-98e3-a0a22f045f82@amd.com>
 <MW3PR12MB4572BEFF9134ABF824D374C79E712@MW3PR12MB4572.namprd12.prod.outlook.com>
 <bf90d631-c63e-4df0-92ad-213bd65ef0ba@amd.com>
 <MW3PR12MB4572DA4F9D571938FB7C4A999E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR12MB4572DA4F9D571938FB7C4A999E7B2@MW3PR12MB4572.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:54:41 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:39:43AM +0000, Mu, Zihao wrote:
> Hello Christian, Alex and Cascardo,
> 

I had a hard time trying to apply these changes as they have pre-requisites
that are still not in tree, and b4 has trouble applying it as the series
were submitted as a response to a different thread.

May I ask that when you submit a new version you do it as a new thread,
please?

I wonder if we should just submit the cleanup fixes (the ones changing
return type and parameters in the hooks) as a separate series and get them
applied in the tree already.

Christian, any thoughts?

Cascardo.
