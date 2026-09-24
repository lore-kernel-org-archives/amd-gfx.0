Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3EDC9830E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2026 07:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A632010F928;
	Fri, 25 Sep 2026 07:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CHHZwAON";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2771A10F6A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 17:13:31 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so528285e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 10:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790270009; x=1790874809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ij7MAN7W+YzHEW+px1HCxBjC06Pm0gT3zC5V96sK/OI=;
 b=CHHZwAONNcixl+8TBPkW0hCWDLCWV8y/xHztCSo0BC1+qYQOhrImELInPbGqupZijp
 9Q1JB4fXydJGqTaNz101ryl89FNCRld3Mt/+pbDbSG/WG0CRaP6nzwxkLk2vlsq1CsJn
 BYtmDpEXf1rzDCt1qMhEZ3DIxCcsanVxFL+MrBGY+N+X+aGfEL63MuuAmv9m6Aso4T2I
 tmTAHD1Vfe7g/SbyW3+6L1quo33NnqpxUsaiXGKKeLUkApwEz6Oz8/cvDFgKUlUWnW90
 CKR4CF8lnnh/CkwSSgMGyVQdoBz7R045Lm8NTjdbi0xppLWh3MW0eL2kX+GcpVb9idQi
 jTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790270009; x=1790874809;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ij7MAN7W+YzHEW+px1HCxBjC06Pm0gT3zC5V96sK/OI=;
 b=DXPl1y+s00UeZ7rIcIz/BuM35gpHNKRQrEXZiQgYiIc9UEKuquKLRrCyn+BT3j6RlD
 yN1CSYah2pBEwa6OaE2FfkcZ/DPD2b/S5uRloDZDk/UFKD09fLH7Ov89Ua+N2u9Pehmi
 JotZAgOBRUkP+VEYqB/k1C6+uTRjtok57J+bBxGW7Z1/46ZnvhzM3zNusHSPhflpc6Hj
 YAoQJMuM02WJPXo5XUfgAlq99JqFt9AL4OKktQip/nxXsw+8O86W72HPkAmMRBcOYip7
 ZZq3f+rNJkGiacvncAzQI6LsLVhCGHmVZl84CMNnUuDOnlPod2XSOgS4Z20oGV1uMAx1
 6suw==
X-Gm-Message-State: AFuF++kzpg9R1msIfw0L85mKftyeAQy6eiF9pjVs6ry1lkp17OUoQDfK
 dArfZrECbJcxaLJIUytznDslDwUEzXevxXZUNK4dEb2SKHhQcbuDo8aIdmo9EJrXGmM=
X-Gm-Gg: AYBFou29fMU+pEYS+LSTtGhTL8+krFPVamX+sK67gG05DBmbF6Tj3dxgJKYLQmUOEhW
 EMssuoCHLbqa7NTEyETZJ9Ay4enx+vawS2yrdGT5hkmjRHG+v/0nxGCMxyQlcs0R4yOeDCBzSQy
 ZAPt4tY9GKCI2eVv6UCAvMj/FXoqT3QfN0L11kw5OhmJGbadGAxh3pXi30LDp5Dgfn5IIM1+0Dz
 QXxhjPHNrgC5zI7KDass1qGOUTo1liLEVHLAE4wlipAPAPUmEYEDUMX3BAGArGC1xA1LyOxa6TS
 gEDqAirz1q7BY5OoUCAsglgxUkHU9pLpZMs+f6RTm6vAx7Ivk1xoVTP3DXcxRD+NdlEhflMkYQn
 j0z756lop/+v7i5x4h4OoSbbK0+iOaDlQBeICet3k2UAfRqTZ0p0LIs7FrduCzz4Glw9Zn9/2Lg
 5/X4IwAgHLhznB+tjd46kubCSQWC+mA0b4hkuo1kje11HH/qem2tbvslPGP2UQMF9nbhyUlXjBB
 qM=
X-Received: by 2002:a05:600c:1d0d:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49fe66f144fmr56773715e9.16.1790270009307; 
 Thu, 24 Sep 2026 10:13:29 -0700 (PDT)
Received: from NBLK-WAX9X ([2a00:1d36:5f19:6e00:eb69:2262:593:ab12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd42f2sm86170695e9.15.2026.09.24.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 10:13:28 -0700 (PDT)
From: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
Subject: Re: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x
 despite AMD VSDB
Date: Thu, 24 Sep 2026 20:12:43 +0300
Message-ID: <20260924171246.17280-1-atailhan2006@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CHXPR12MB999220241D7681B15420FBA721E5822@CHXPR12MB999220.namprd12.prod.outlook.com>
References: <20260923002718.5915-1-atailhan2006@gmail.com>
 <696580d8-cf2e-47aa-8616-7d930c2f5b82@gmail.com>
 <CHXPR12MB999220241D7681B15420FBA721E5822@CHXPR12MB999220.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============BOUNDARY=="
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:39:28 +0000
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

--===============BOUNDARY==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Alex, teapot,

Thanks for the update and clarification.

I've attached the raw EDID blob from the
Samsung S22C31x monitor for reference. 

Good to hear that the transition to public DRM parsing for the
AMD VSDB is in progress. Please feel free to reach out or send
any RFC/test patches my way when you need validation on this
hardware; I'm happy to test them and provide logs.

Best regards, and thank you.
Ata İlhan Köktürk

--===============BOUNDARY==
Content-Type: application/octet-stream; name="samsung_s22c31x.bin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="samsung_s22c31x.bin"

AP///////wBMLRBzRjdONQEiAQOAMBp4KqHVq1RQpCUMUFS7jACzAIHAgQCBgJUAqcABAQEBAjqA
GHE4LUBYLEUA3AsRAAAeAAAA/QAwSx5UEgAKICAgICAgAAAA/ABTMjJDMzF4CiAgICAgAAAA/wBI
OURYMTAwMjEwCiAgAeQCAxyxRpAEHxMSA2cDDAAQAAAjaBoAAAEBMEsAAR0AvFLQHiC4KFVA3AsR
AAAejArQkCBAMSAMQFUA3AsRAAAYjArQiiDgLRAQPpYA3AsRAAAYKkSAoHA4J0AwIDUA3AsRAAAa
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA8w==

--===============BOUNDARY==--
