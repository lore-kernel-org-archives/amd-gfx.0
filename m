Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AA7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 15:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D00310E4D1;
	Fri, 23 Sep 2022 15:30:45 +0000 (UTC)
X-Greylist: delayed 507 seconds by postgrey-1.36 at gabe;
 Fri, 23 Sep 2022 15:30:41 UTC
Received: from mx0-44.i-mecca.net (mx0-44.i-mecca.net [76.74.184.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064F710E4D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 15:30:40 +0000 (UTC)
Received: from ns14.i-mecca.net (unknown [192.168.1.14])
 by mx0.i-mecca.net (Postfix) with ESMTPS id 63EC216E6E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 08:22:10 -0700 (PDT)
Received: by ns14.i-mecca.net (Postfix) with ESMTPSA id 0718280277
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 08:22:08 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------u8B5mmtZbMplNEjoILBS5SVy"
Message-ID: <ee75db06-e000-c78b-0c30-fe7f8551df3b@fedoraproject.org>
Date: Fri, 23 Sep 2022 08:22:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-CA
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
From: Luya Tshimbalanga <luya@fedoraproject.org>
Subject: Update Device ID database for AMD Barcelo
Organization: Fedora Project
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

This is a multi-part message in MIME format.
--------------u8B5mmtZbMplNEjoILBS5SVy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello team,

I just got a Dell Inspiron 14 7425 2-in-1 laptop equipped with Ryzen 7 
5825u and graphics is a refreshed Vega 8 with 8 CU . Currently, the 
graphics card part reads RENOIR on GNOME Settings > About and it should 
be "AMD Radeon(TM) Graphics" or "AMD Radeon(TM) Vega 8 Graphics" 
following the name convention from Device Info 
(https://github.com/GPUOpen-Tools/device_info/blob/master/DeviceInfo.cpp#L546-L625).

A ticket is already opened on 
https://gitlab.freedesktop.org/mesa/drm/-/issues/81 and it will be nice 
to update the database.

Thanks in advance.

-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer

--------------u8B5mmtZbMplNEjoILBS5SVy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello team,</p>
    <p>I just got a Dell Inspiron 14 7425 2-in-1 laptop equipped with
      Ryzen 7 5825u and graphics is a refreshed Vega 8 with 8 CU .
      Currently, the graphics card part reads RENOIR on GNOME Settings
      &gt; About and it should be <span class="pl-s"><span
          class="pl-pds">"</span>AMD Radeon(TM) Graphics<span
          class="pl-pds">" or </span></span><span class="pl-s"><span
          class="pl-pds">"</span>AMD Radeon(TM) Vega 8 Graphics<span
          class="pl-pds">" following the name convention from Device
          Info
(<a class="moz-txt-link-freetext" href="https://github.com/GPUOpen-Tools/device_info/blob/master/DeviceInfo.cpp#L546-L625">https://github.com/GPUOpen-Tools/device_info/blob/master/DeviceInfo.cpp#L546-L625</a>).</span></span></p>
    <p><span class="pl-s"><span class="pl-pds">A ticket is already
          opened on <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/mesa/drm/-/issues/81">https://gitlab.freedesktop.org/mesa/drm/-/issues/81</a>
          and it will be nice to update the database.</span></span></p>
    <p><span class="pl-s"><span class="pl-pds">Thanks in advance.<br>
        </span></span> </p>
    <pre class="moz-signature" cols="72">-- 
Luya Tshimbalanga
Fedora Design Team
Fedora Design Suite maintainer</pre>
  </body>
</html>

--------------u8B5mmtZbMplNEjoILBS5SVy--
