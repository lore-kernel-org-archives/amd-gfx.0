Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377B5CA0EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 22:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7650410E9BC;
	Fri, 15 Aug 2025 22:21:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KaywDozi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66D3910E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 22:20:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIqs7017540
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 22:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=xfIBhnpUDRVNIWjXRgxsYT8X
 VCA1w9Y6OWwHkBmVkwQ=; b=KaywDoziy0fxrA3uFl6uoMxKbTDM2EUGBAX26H/6
 XrWOSY4LPTflZg2g/TnAlXFBHwO6kx68lg6JJNk7KCiR1CaGE9cmaVkklrUmm11a
 13DahpnZ+g2MPucq6ZyzW6iKpoME46KHivAIAQbCAWkq2hz9KHh7aBr3LBUEGG8a
 bEFwlFCKguKFzmoOJ7xMOhAh66SjDU0EDVgxCkLtTLDAX37TTFDEnrfSyvFykFnX
 4NYol075SgWSBzrykyzqVX0kPELrmb6ZulQOLe2hvLlXbRzZCXumBkhxVkd/Vitx
 brnB3CNu4iWlsHLnn8xIwR+RtdGNgM5PK9KWRamu/xXEkQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxjgn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 22:20:58 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4b109be525eso64291921cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 15:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755296458; x=1755901258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xfIBhnpUDRVNIWjXRgxsYT8XVCA1w9Y6OWwHkBmVkwQ=;
 b=bYGkO9y3vuHYKzBUNAza2fzDFdUsAyGd73tevw6AkPugvKBlrAdUwN0aTnwGbijKKF
 kLejv8gkaZleMbVhVum3K3U7iIN+57j1W1jW7IPft0E8ajcm79PYwBEhwqMexLgDxfW4
 WbTVYlcWos9Sh6w4kg7ykq6s+xkZUSlMBj3rr2XHLU2kgVfGzHRi3QztyyRIhWeuv3mF
 KJaJc7SltehXv2koFBzK11Ps9l4OsxVYWkjtWBlwCsVXjcxDfoaRo+9vetsCcYTGmuQB
 0d09McOEZok60n8xCWtT+B2+NZoHr03UHWA3y7EkqNnqxmStiDqz2x9GSgIwgMS72Cma
 OmQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUo1c5TKkz7Q0ZwEuG8mLlXcqzPqLOwSdsryfT/FC3NN/0VXUCAb27WVCgsC8jOJqhiyli4gob@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEuhYvI4KOV6Efm2oU8t/kMmEOo6XbZD1yQkI3JwLTprhgkg/q
 5tk0jf8Ar2HPuSP1Eoq1JhlL4w6pKkHAZz5YYiUcocOO+kjLZH9c+go50pqj4mUcv/Cm4v1EwWj
 srXiFTvCF94V+BRbPsG7bb1ZlQ6Mn3WYsrErpign8+a6uNojj/f6G8agoFGk6GSlbbtpW
X-Gm-Gg: ASbGnctUEnm8N4o4cL3EYqDa9+8XzrqnEicosKxPHvTZLhALPe0zJCyQ+AHWDpQIjmr
 vKt38N3nphhEztvlf2mtpMZvT3iK22MzSY4CWnpxIjG29khOL0+6hDObfy/3O/XXet2mGPb6UxK
 b2xmDprIfPvC8BsQRZp1MSIByvvalnTnkhCt26so8xgHnOwqzJIlIrJmGq2kD7E8XFjFBWoZ7VW
 BI3w24NYu0mrA3ZRr21Ni8NkIB/imuMEqH/BvYx3Gjylj/H1/2vKYNdypAkHkrlRfRpJsO42QEQ
 iOMPmkZY7EqBie44Ww69UvyhCbYf0k0t3XPatQKNdaxRB3XDGPE952NoEZjnvl5VgD04WnskssK
 KCc8YnHq0jWEo4lIB13k+esAw71pLLdbgGk0vjJmwye7qbz5PYq91
X-Received: by 2002:a05:6214:27c2:b0:709:82dc:b1b2 with SMTP id
 6a1803df08f44-70bb064aab5mr7415136d6.48.1755296457510; 
 Fri, 15 Aug 2025 15:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1+iZ0Ln0WZk9wKMEFeC3GuUiWeKAJqXs2A1a7u9zGnMDfpKmmxWgkIpmWbduQTZnYFsEO3A==
X-Received: by 2002:a05:6214:27c2:b0:709:82dc:b1b2 with SMTP id
 6a1803df08f44-70bb064aab5mr7414886d6.48.1755296457044; 
 Fri, 15 Aug 2025 15:20:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55cef3cc9a6sm518362e87.78.2025.08.15.15.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 15:20:56 -0700 (PDT)
Date: Sat, 16 Aug 2025 01:20:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Cc: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
 "Murthy, Arun R" <arun.r.murthy@intel.com>,
 "Shankar, Uma" <uma.shankar@intel.com>,
 "Nikula, Jani" <jani.nikula@intel.com>,
 "harry.wentland@amd.com" <harry.wentland@amd.com>,
 "siqueira@igalia.com" <siqueira@igalia.com>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
 "abhinav.kumar@linux.dev" <abhinav.kumar@linux.dev>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "jessica.zhang@oss.qualcomm.com" <jessica.zhang@oss.qualcomm.com>,
 "sean@poorly.run" <sean@poorly.run>,
 "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
 "mcanal@igalia.com" <mcanal@igalia.com>,
 "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
 "tomi.valkeinen+renesas@ideasonboard.com"
 <tomi.valkeinen+renesas@ideasonboard.com>, 
 "kieran.bingham+renesas@ideasonboard.com"
 <kieran.bingham+renesas@ideasonboard.com>, 
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>
Subject: Re: [RFC PATCH 1/8] drm: writeback: Refactor drm_writeback_connector
 structure
Message-ID: <hc6f6wgsnauh72cowocpm55tikejhiha5z4mgufeq7v6gb2qml@kmgfd26bigos>
References: <20250811092707.3986802-1-suraj.kandpal@intel.com>
 <20250811092707.3986802-2-suraj.kandpal@intel.com>
 <20250811094429.GE21313@pendragon.ideasonboard.com>
 <awtqznhquyn7etojonmjn7karznefsb7fdudawcjsj5g2bok3u@2iqcdviuiz2s>
 <20250811111546.GA30760@pendragon.ideasonboard.com>
 <2ah3pau7p7brgw7huoxznvej3djct76vgfwtc72n6uub7sjojd@zzaebjdcpdwf>
 <DM3PPF208195D8D0E55A761A3C16B87BAEEE32AA@DM3PPF208195D8D.namprd11.prod.outlook.com>
 <aJ4LQvqli36TlETu@e110455-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ4LQvqli36TlETu@e110455-lin.cambridge.arm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXxQUnZov9O/LJ
 TNQQIC8hZftzvfsASMZD5qJoBvFOUKGaM1feD2o5uZjUMoCUJon4Qtwku/3aeMJSHR5gomJrbqR
 EnmcqoqMBOGXXxsKBrAeJycEDegVqubTF/SCPl6Tqhryxl5Zxh9gIYT81WR1atx73O5Z9pJPPst
 Tj4H4nRMde6r6wQEda9lSFEiBSQNszurWsjmPy62ipRESgL050/YGeHIBuDYYZXukDfrAZw2wYN
 voLl2ytTif1Z4yeoqMEdSVSiIswnt8pqxI6wUOYuXHHGW62T9Dd4vpa2CWDOndAfGNnt/1HnbZ5
 NOCegSWHDyPjdaEVnadUjViWgmlaZK5jmgMQvLI4EEYcv2q3k+BQGy56iLuv6yPdL5SYYNCem+/
 7Ws2wl4z
X-Proofpoint-GUID: bcO0l09bkIqr2O7cvuCrYVnMIbnEUaXd
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689fb2ca cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=7CQSdrXTAAAA:8 a=WdlRDaJtcICMsET58csA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: bcO0l09bkIqr2O7cvuCrYVnMIbnEUaXd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_08,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057
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

On Thu, Aug 14, 2025 at 05:13:54PM +0100, liviu.dudau@arm.com wrote:
> Hi,
> 
> On Wed, Aug 13, 2025 at 10:04:22AM +0000, Kandpal, Suraj wrote:
> > > > > };
> > > >
> > > > I still don't like that. This really doesn't belong here. If anything,
> > > > the drm_connector for writeback belongs to drm_crtc.
> > > 
> > > Why? We already have generic HDMI field inside drm_connector. I am really
> > > hoping to be able to land DP parts next to it. In theory we can have a DVI-
> > > specific entry there (e.g. with the subconnector type).
> > > The idea is not to limit how the drivers subclass those structures.
> > > 
> > > I don't see a good case why WB should deviate from that design.
> > > 
> > > > If the issue is that some drivers need a custom drm_connector
> > > > subclass, then I'd rather turn the connector field of
> > > > drm_writeback_connector into a pointer.
> > > 
> > > Having a pointer requires additional ops in order to get drm_connector from
> > > WB code and vice versa. Having drm_connector_wb inside drm_connector
> > > saves us from those ops (which don't manifest for any other kind of structure).
> > > Nor will it take any more space since union will reuse space already taken up by
> > > HDMI part.
> > > 
> > > >
> > 
> > Seems like this thread has died. We need to get a conclusion on the design.
> > Laurent do you have any issue with the design given Dmitry's explanation as to why this
> > Design is good for drm_writeback_connector.
> 
> I'm with Laurent here. The idea for drm_connector (and a lot of drm structures) are to
> be used as base "classes" for extended structures. I don't know why HDMI connector ended
> up inside drm_connector as not all connectors have HDMI functionality, but that's a cleanup
> for another day.

Maybe Maxime can better comment on it, but I think it was made exactly
for the purpose of not limiting the driver's design. For example, a lot
of drivers subclass drm_connector via drm_bridge_connector. If
struct drm_connector_hdmi was a wrapper around struct drm_connector,
then it would have been impossible to use HDMI helpers for bridge
drivers, while current design freely allows any driver to utilize
corresponding library code.

> 
> drm_writeback_connector uses the 'base' drm_connector only for a few things, mostly in
> __drm_writeback_connector_init() and prepare_job()/cleanup_job(). In _init() we just setup
> the properties and the encoder after we disable interlacing. prepare_job()/cleanup_job()
> is another workaround to be to some custom ops some drivers might want for signalling. So
> we should be able to convert the 'base' drm_connector to a pointer relatively easy. We shouldn't
> need to get to the drm_connector from a drm_writeback_connector() outside drm_writeback.c.
> 
> Then it looks like what we need is a __drm_writeback_connector_init_with_connector() where we
> can pass a base pointer and remember it. Maybe an extra parameter to existing init functions,
> or a new one that skips the encoder initialisation entirely.

I've refactored out drm_encoder, that's not a big problem. The bigger
problem is the embedded 'drm_connector base' field. It's really use to
overlook that it's not initialized / not used.


-- 
With best wishes
Dmitry
