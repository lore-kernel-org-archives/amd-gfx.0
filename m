Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977D7F364C8
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 22:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28A8E10E033;
	Thu,  9 Apr 2026 22:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NI2OvWo5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0i4BHOd";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802C110E158
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Apr 2026 22:20:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639INJQV3352581
 for <amd-gfx@lists.freedesktop.org>; Thu, 9 Apr 2026 22:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NhC1xnjVzqLBQGw7MdZwg0L/BccYrR8OrGOTQqV/NrY=; b=NI2OvWo5Uz4HWnLg
 XmdY0oNoCP/JZDMqXJEUmu6dk7B6X0CTWehE6JGK/bsYNGl9Qm6mU3odG4PhuID7
 /DLPF24xx3/pOxRjpnNGLsqaE2VDwC9CKYrXmBPy2Io0f25bAuN+x55MVIGRckW6
 SM85MYoHlsTJgqhTO3QWGSSKjIy60livErsEQE5iYrkkPSOoVQ3OyFBuk7sAUMga
 IkyFHUHZwaGRPaEZIZZicz3q8B2ifD6QzFn0GoE7dlfgYJauLz1AX9E4CxRuZxTr
 Krw01r1nzcYB6O3AVbUn5/viHPYyPMF/CYHEhWcVWlc9wMSEkZvF/cdRVFxpyJki
 q3YtDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec1qt2x7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 22:20:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b6f869676so30647721cf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2026 15:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775773254; x=1776378054;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NhC1xnjVzqLBQGw7MdZwg0L/BccYrR8OrGOTQqV/NrY=;
 b=j0i4BHOdpxULafP7qGk+qighFCz7MPMjMscYKaU42TtVUAgEGoyERTlSKkC6nKSVAP
 S+0fTzP8e4RMqkipNTEkCm+xhY9mzfPBE09ell1gwI9Djd1npxyXHWUUkCNx46jDuAiy
 qynZCNvM6wI+E1v8culhI3SpNXLPSzzwtKtgvpJC7UwG86e8U5ech1APaMSqYGvDfDzs
 LlKhhkwIoD1gmK95OsI9oFmBNrOtbqZZncONJ8aS+qZ+M4THWUDcOX8KB5RwStmdO2y6
 6sk46A5uSkO7hYRtYE9e/6/8GY2fYeqV7YuZxvaTJL1zfPcjODVYmCZOVHESs1wB4TWJ
 lz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775773254; x=1776378054;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhC1xnjVzqLBQGw7MdZwg0L/BccYrR8OrGOTQqV/NrY=;
 b=H2e0btd8HjLQq0I1xmcwPEoDyLcyO/1eZSVxMhAAWkG98ij8AduZZo5fOVdVWGiEtN
 4a/JNxsx07waSQ6VVfUrfm/EfWuYPbCaxsRg2vPs8WYYmpsuNcJw4iAY8gH0heOomKrf
 FuHhwXbq87EArFuqgkgWzYTrBmphztDAru5P7RtpYZ6FLUYH/Vj6LbNIB984TCy21JHT
 cquFu4vYOCqJ+G7QtJox+Hd2TtFy1XVEZQFzXK6nVDlIg7CLLiFA/aWtFPJUUjeb//LZ
 OLN8SjCPKZLAK6MEcZLEjNkzjUUb0ivFIE+TqHLDazTuRTp+iw90qYog8GlAd032uh5l
 A18g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVabV1UQpBBEM8F0TspVeNxYlTP0EVFKR8Ty51aNc5bn6X99D601lkUukD68alkRwGYUGEIontQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNZt4KbXeqTzAL3V/H3AtF/U9Cnw/fqa4tWFxOAj/544iKmuH0
 l6lR9KBmCyqcHv15KOANIrhSatcaZ6yewsdz8CpI9t1DiDSMhfJsC1MOMSPwG0g+mOaGLWcb4Uq
 gY6K76GRkQtP9V96WHYhGtQSVcbmS79yEJ4pgOGalKhPXU/eALQX8JLKMqu8UhG0AMnIg
X-Gm-Gg: AeBDiet8P6yOFWzeMQG1L0M1PeHWj6IpO9O98I1kmfzNO+02ziHVjC29YAPGwqfeVKD
 7/yrTzmcliosHPJdRH7HL9hqA3cUBUJhbDGbO2SQ7t+D3rHAfE4D6MzSCzfd/ptGcteEQfxqDJj
 SnlNH4J7mKkFMdsRC8MHbun+pZ9s1IStsbcaRal06F9yxULaBjkpMWJbmhrPU0Z7F1ubkknAQCN
 3RBYiIx3zmGWLBt+JtqtWwzUqy0wF7fvP9ZLuOMQcZV1KNrej+Z85jy49uw1fqgCbCxpt/uYbbm
 5k/ibtRMFHh8GvTJTgBlgoGs4U/3+598nHJP5jO+racfUSu/Md8N2fv0JdhGVH0FC2gKydS+5Kb
 6KQnuq1wW5C+vcDR4su9P1d3n3ZqD175jIJMVSFBIYVBId0bnrl3zHCwXa/xhNy++BjllgN08Lv
 ckTGPnN+NmvsN/4XM8qLiIEmlLDi6utBzyriM=
X-Received: by 2002:a05:622a:a707:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50dd5b77e0cmr13383911cf.33.1775773253527; 
 Thu, 09 Apr 2026 15:20:53 -0700 (PDT)
X-Received: by 2002:a05:622a:a707:b0:50d:a466:6d11 with SMTP id
 d75a77b69052e-50dd5b77e0cmr13383621cf.33.1775773253058; 
 Thu, 09 Apr 2026 15:20:53 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eeee1219sm202574e87.50.2026.04.09.15.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 15:20:51 -0700 (PDT)
Date: Fri, 10 Apr 2026 01:20:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniels@collabora.com>,
 Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, kernel@collabora.com,
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
Message-ID: <flq7gnt4l3yd736dcg32ra4tzrwslv4uj7kgvbbqv5uj2m7rop@37p2kjfcaty6>
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
 <5797606.kQq0lBPeGt@workhorse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5797606.kQq0lBPeGt@workhorse>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwNiBTYWx0ZWRfX3yKgkIXdYezB
 MEoDZq5/R0gvVrJGII/aZ99qpoJnMzcFmzwVnQ3e+KFkHz+2xBgZqM57hqW9kwAq0dgKgphdNPf
 1dmFjDAo3i6VhQgdPuc5UC7/RvC2v2ZiqmXtWzf5jr+Wm2SVuaICUo0hW1zbpqDp06TCKwJdHBG
 2PPxFYwk18OE6vaxTV05J18U0MjJEQGzJ2R5TPAeLRRM9qDjZm6nqKpk5gVrh+Z03rl6MbIxUkb
 bBTr3iAl2+E176MPbnGSH6Ap6QP7F0sgRxx6GbQLWtO8dedkppXEoHXH43Fu6ZO8+QhDd6mH828
 JRDz2TTp1tKzAcMxfEkFomItbRld06Jf+WET0p2Irrh/OwGhLByHVzKszVRO+13zqewiDBwx2LP
 cwoJ9r5vx9AhP1OGaG4NHlPTFS3N/BiQIBTKchpi2Hfb6fZZ14TixvDWaOfqXIP6adBNcA+Xt/2
 oPAMXw1QJ8oL4SUTUCg==
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d82646 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=9QKrCliAx9hTWDlqWTcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: kAn23WP_2Caj8jQeEjhP1KSeAHzylG03
X-Proofpoint-ORIG-GUID: kAn23WP_2Caj8jQeEjhP1KSeAHzylG03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090206
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

On Fri, Mar 20, 2026 at 07:02:38PM +0100, Nicolas Frattaroli wrote:
> On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel Dänzer wrote:
> > On 3/19/26 13:28, Nicolas Frattaroli wrote:
> > > This series adds a new "link bpc" DRM property. It reflects the display
> > > link's actual achieved output bits per component, considering any
> > > degradation of the bit depth done by drivers for bandwidth or other
> > > reasons. The property's value is updated during an atomic commit, which
> > > is also when it fires an uevent if it changed to let userspace know.
> > > 
> > > There's a weston implementation at [1] which makes use of this new
> > > property to warn when a user's requested bpc could not be reached.
> > > 
> > > [1]: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
> > 
> > I see no description of a real-world use case, either in this series
> > or in the weston MR, beyond logging a message when the "link bpc" &
> > "max bpc" property values don't match. They are not expected to match
> > in general, so I have a hard time seeing the usefulness of that.
> 
> Hello,
> 
> these are valid concerns. The problem being addressed is related to
> userspace being able to detect whether the link has degraded due to,
> say, a sketchy cable.
> 
> This patch started out as a method of forcing the output link's BPC
> value to a certain value, but this is not desirable. The max bpc
> property is already used to restrict the link's bpc due to sketchy
> hardware that advertises a higher max bpc than it can actually
> achieve.
> 
> This adds the other side of the equation, where userspace isn't
> necessarily keen on blindly accepting the combination of output
> link parameters the kernel degraded to. This allows userspace to
> detect that an explicitly chosen value it tried did not work, and
> try again with a different color format/VRR/bpc/etc.
> 
> A particular real-world use case is for playback of video content.
> When playing back YUV 4:2:0 10-bit video content in a full-screen
> setting, having RGB 10-bit degrade to YUV 4:2:0 10-bit rather than
> RGB 8-bit is more desirable. However, this is a tradeoff only
> userspace knows to make; the kernel doesn't necessarily know that
> the framebuffer it has been handed as RGB 10-bit is secretly just
> a video player's playback of YUV 4:2:0 10-bit content. As for
> the property that let's userspace actually set the output color
> format, that's a separate series of mine.
> 
> I agree that the weston implementation isn't a great showcase,
> but it's actually supposed to compare link bpc with an explicitly
> set max bpc config value, not the property value. The config value
> exists to request a certain bpc.
> 
> > Moreover, there's no description of what exactly the "link bpc" property
> > value means, e.g. vs things like DSC or dithering, or how a compositor / 
> > user would determine which value they need / want under given circumstances.
> 
> I agree that I should've expanded on this after splitting it out of the
> HDMI patch. It's the output BPC as HDMI understands it. That means DSC is not
> a factor. I don't know if any display protocols do dithering at the
> protocol level, I only know some monitors dither internally, which isn't
> something that can be detected.

First of all, HDMI 2.1 has DSC support. Second, the world is not limited
to HDMI. There is DisplayPort (with DSC support). There are DSI panels
(also, DSC). There are cases when you have the DSI-to-DPI bridge doing
dithering from 24bpp input to 18bpp DPI glass. There might be a display
controller doing dithering from the 24bpp to 18bpp or 16bpp. Overall,
you need to clearly define, what is the "link bpc" in all these cases.

> 
> > In summary, I'm skeptical that this will be useful in practice in the
> > current form. I do see potential for spurious bug reports based on the
> > "link bpc" property having the "wrong" value though.

-- 
With best wishes
Dmitry
