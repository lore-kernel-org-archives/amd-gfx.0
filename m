Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D25F3ED4B
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Apr 2026 11:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91FB510E1C7;
	Sat, 11 Apr 2026 11:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="SMxnHZm3";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8833710E1C7
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Apr 2026 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=In-Reply-To: References: To: From: Subject: Cc: Message-Id: Date:
 Content-Type: Content-Transfer-Encoding: Mime-Version; q=dns/txt;
 s=fe-953a8a3ca9; t=1775907926;
 bh=fKc7rNjB607WrvadSSpq8ggFYcIZbT8rYkFD7UDg5zE=;
 b=SMxnHZm3h6g/JqjRMNcsZll/REPRoc31ayf/TMHbZ9qh0/cXTRrmWl925d81k1322bHfJH9g9
 jRKlOnRoGW6ZhBQIVtbh0+TuIdzEABL5Pa9ZySI5Z2j9BWq9+EhYf4MN1z37kD82CHPWXNSFY41
 E5Bytw6wRmxpiEpJmJ6H+YavlhO9Etd7A0H0cH+gTEwl04Khq8xQ6vqtYArrX2zhGUXRyn0FmaI
 G3N/CVq/Mzdx2HPo9OGr5WeFhcckohiTA9dQUCO1lJPsNCxRDmwi1ET/TWD5d93JtZPaoF2k7gt
 MGu60glrh8IESz/booGTiylodyozl+kYkK6wvw2ZF41Q==
X-Forward-Email-ID: 69da345156946c16b3de7e88
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.69
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Sat, 11 Apr 2026 07:45:19 -0400
Message-Id: <DHQATFD3MPLS.XULA16D1IROS@ubuntu.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: Re: [bug report] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
From: "Joshua Peisach" <jpeisach@ubuntu.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Dan Carpenter"
 <error27@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
X-Mailer: aerc 0.20.0
References: <adinpZORBkhVcw31@stanley.mountain>
 <DHPGIF5U4U8O.1R90J7IR4M80L@ubuntu.com>
 <IA0PR12MB8208DAB29B0617E8F6D082C490262@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8208DAB29B0617E8F6D082C490262@IA0PR12MB8208.namprd12.prod.outlook.com>
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

On Sat Apr 11, 2026 at 1:30 AM EDT, SRINIVASAN SHANMUGAM wrote:

> I went through the code path, and the warning looks valid:
>
> In amdgpu_connector_dvi_detect(), we do:
> drm_edid_free(amdgpu_connector->edid);
> After that, we call:
> amdgpu_connector_get_edid(connector);
> But inside amdgpu_connector_get_edid():
> It immediately returns if amdgpu_connector->edid is non-NULL
> Since we did not set amdgpu_connector->edid =3D NULL after freeing:
> The pointer is still non-NULL (but already freed)
> So amdgpu_connector_get_edid() becomes a no-op
> No new EDID is read
> Then later we do:
> drm_edid_is_digital(amdgpu_connector->edid);
> At this point:
> amdgpu_connector->edid still points to freed memory
> So this becomes a real use-after-free
>
> So the issue is not just the removal of amdgpu_connector_free_edid(),
> but that we lost the behavior of clearing the cached EDID pointer after f=
ree.
>
> Because of this, the EDID cache logic breaks.
>
> About reverting:
>
> Reverting the commit would fix it indirectly
> But I think a minimal fix is better:
> Set amdgpu_connector->edid =3D NULL after drm_edid_free()
>
> This keeps the current design intact and fixes the bug cleanly.
>

I like it - less is more :) and it also makes it clear that the
pointer is set to NULL, instead of being hidden behind a function.

-Josh
