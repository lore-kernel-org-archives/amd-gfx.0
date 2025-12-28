Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04A5E9271F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Dec 2025 00:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5BC0113361;
	Sun, 28 Dec 2025 00:53:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIVlJJTe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BHHiiJJF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149E710FDBD
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 00:53:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BS0qdSp1522359
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 00:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tKcMbFWNjzITwh4/Q6d8qQItR8/b+qZfIJdqdqrqAIo=; b=ZIVlJJTez2/C/3Gp
 Ga2/gIIf13Achz47vReZB6U29hpq24HkzTtz7JTG1HZkoTf7aW85g8rDcAG2knhA
 EEg90YktD7icwRf2Zd3gLgFS2d/txWqn5gY5iLUFbgfed2h38rW3/g4e+t8ElfVs
 HTYBl2J2OwUATBC803XKE+2M/QWR0vgg1rTwxNeOdNYKfpGEupBV5Gg5qBBVs3At
 jE4Q+bL0tjaPiE8ZyEAcbCwfsg05ibD8xbOjAGytJxXsXofOVtWjY3r0pc0+cprE
 TGF6VfJNQeZCHqNOvYijWYxjnfwDtUmOg7puW1qd7cS11A2rQa08kGhfqZdmnVnM
 X91dSw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba7hs9bxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Dec 2025 00:53:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4ee09211413so214232801cf.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Dec 2025 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766883195; x=1767487995;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tKcMbFWNjzITwh4/Q6d8qQItR8/b+qZfIJdqdqrqAIo=;
 b=BHHiiJJFvXNnySBuZirJlIleASYiAt2RZv9i+EKiYbolVAOzfUllf5Ck/MkYwf0qyX
 HwhEeKu0t+1EmnK4SZbAKfrCadvugIUkuZkngDAnrIdM4bVDCavjIddjbvBNAwWvDayh
 MBU1N1TUDb9cmoGiaGsNE6AeoRwGADlPxIK1pJI3EHmd9VvzBEO5LQllmZh8d7ZsOA67
 noLpq0YYmadhZwF6c7Ri2uxvNv8xfAkNpworPohQnTF4iGPr3hESsY039vXLEoWRkxxX
 T1T+F1Svf1F1RwQeXZkf5BP06SwA5emrx/0irT3mYSxn5yCdXHhrX+o2qu3CvvtCsn9z
 ZsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766883195; x=1767487995;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tKcMbFWNjzITwh4/Q6d8qQItR8/b+qZfIJdqdqrqAIo=;
 b=j7rzxHY+jClezHIeWyE6ZlW+QChyHblzLdfMpZ0DLJWzonorM7OJtiZ/7kRwugGDb4
 ord7OS+BZQGKo4IwLqtJZh4cT2E+CnEDtqh2pi8FoWvabylZcKL3WqMjqb/BEW8xzgnX
 jHPLKFIvJUgq2XyPEygPzkSAOy0r4ao9OZGW/5indIm8jZDnOeBSf1/8C4Uie19hEEvX
 HxB7WwQEWpA4M4mxbH5mDyNrj0rPS1A3hppQev0aJWSeI1yk1rCNaQzEadElRk4M/uns
 cLUFA9+wG4ER1vN0ZTcwPSxgCt8papEWv+ZuIj3qEv5WlSOg/NaaOsAndvfY0YV9yvkF
 r1ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDa7WegpM8e/HYiMSbQdbYqG9ezjbAy+C1YNCFZE/m21G8CRyLnF/zHn8ebQmoHt1wZnlBpDqs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJHG+sUy3W5/o7C1GMG5ZRc5XTSqIMOQBtKM99UFWDXWvEgAAD
 K5CWi0qddRaxuhqNIaaufevZsBZMTH/jS5IJPTA5PfwLRQlaoPXLopLqZT1HyQ3JcJrmQYOe7FF
 aLmliOz466CcyKrMQ7IAferw7lhL/FshrcRAFaxdoyQu53nbXO7JqgF8eKlrHD3FpDLCm
X-Gm-Gg: AY/fxX7x7rsS/0t+b7+ElnrvuJ4SEWNWCIlcDGUThg8ef9pJFRHbKili5fcjRPvCyP9
 ujAKK8K/4mu0ytmEJxo8i2zNSa3vSEwpNrOdMROvQrjj89ShmPmNaDNijgAmB2eE9q0gcYrp2Ag
 XmrKD2vuoGkQnGnBrnkrbpSO7u7C69Xyb/+evt2syck2s2ZC9GvvLhBJEpLOPIhMB1xxu15CuNG
 SejK+05EjkdO9N0gi2kMlB2iH7DPEE9qvm6ZzIoKqE6keaDnselHt3VDlcc+vkip1knNV1XjfnW
 14YD97HOtrNUjf8FJ70q+T7739EuWxLc4awOs9Po5QAR4pU3ShwSpwPTodJSm9+Sxtb51Pn4B4f
 J9iN3s9eR7nf03aevchoCR1OIAboXE8xXF9xhSkGb0dM7iAaU2MPBNIJkKk9jyZLho6+aEH1i4g
 IbxU1pwYUSrhCtJZRFlHLCfKM=
X-Received: by 2002:a05:622a:17ce:b0:4f0:165e:c1fe with SMTP id
 d75a77b69052e-4f4abd93127mr424542161cf.54.1766883194755; 
 Sat, 27 Dec 2025 16:53:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjmHVj87RMWxad1vU+LeGO5zKfAvU7D8dJVfdrvgUQiGJzJGjaCj9tS+wJF0GBZO/Kg7fzIw==
X-Received: by 2002:a05:622a:17ce:b0:4f0:165e:c1fe with SMTP id
 d75a77b69052e-4f4abd93127mr424541881cf.54.1766883194270; 
 Sat, 27 Dec 2025 16:53:14 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b30f7c322sm3152128e87.59.2025.12.27.16.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 16:53:13 -0800 (PST)
Date: Sun, 28 Dec 2025 02:53:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH RESEND 2/3] drm/atomic: add max_size check to
 drm_property_replace_blob_from_id()
Message-ID: <kxlk3cb6tsge6wf45xs74i6u6cmmkvw4sbujir54vuwqkwvriu@halwo27swzll>
References: <20251210-drm-fix-lut-checks-v1-0-10ae38519f43@oss.qualcomm.com>
 <20251210-drm-fix-lut-checks-v1-2-10ae38519f43@oss.qualcomm.com>
 <f211044d-c797-4e10-a06e-10dce071f704@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f211044d-c797-4e10-a06e-10dce071f704@suse.de>
X-Proofpoint-GUID: hPaQ0j940cY_BQzPlMqwuxkC4iuLvBwZ
X-Authority-Analysis: v=2.4 cv=O4o0fR9W c=1 sm=1 tr=0 ts=69507f7b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=iox4zFpeAAAA:8 a=CKk-xbJTmnNh4yQCEWIA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: hPaQ0j940cY_BQzPlMqwuxkC4iuLvBwZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDAwNSBTYWx0ZWRfXynFqc9Fanlnv
 g+MpcTjOqSK3gBrUh4NhozDgyGHYyWsOO9KTeDzMksGta0Ty+JUWeUhHI4RsRu0zR/EkIsLT1eP
 p4Ztn7blHQtQm+iwL7DMxDGpygw/uT5zsTvk/gxMiR8BZgmx2jPcTTjAhkHQjByJF4svDc2FKL9
 Ei1ggemfrYdAhUvJ+/iXulljm1TlsJBFlEeYQsiSjaHAtexOrvtPZRU+CidJ/lcgmDR0dLoC6Fg
 sjPdWTInYqd5wA3dEllKbfVvvOl6PL8Xje/7lB/2sXEZMMGegnpBNiopJ+E8vF1fTkQdizGVl72
 7cJSMhInkxKiVwaYZxf1mnk38t7zJhS5CU8iZ5X52FEmFTOT0mO0o3hfevXUQX1qmT7iQ4mE7M8
 iXAed+mjC5V9GNUR+iPSJHOG/FX3ojCL5iuAMYqFIEWmrW0Ci1J7v7GnZ9n4D3+sUatEOIgTJne
 eHXeDcPvzPHy+g1yXtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-27_06,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512280005
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

On Thu, Dec 11, 2025 at 08:46:26AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 10.12.25 um 20:42 schrieb Dmitry Baryshkov:
> > The function drm_property_replace_blob_from_id() allows checking whether
> > the blob size is equal to a predefined value. In case of variable-size
> > properties (like the gamma / degamma LUTs) we might want to check for
> > the blob size against the maximum, allowing properties of the size
> > lesser than the max supported by the hardware. Extend the function in
> > order to support such checks.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c |  5 +++++
> >   drivers/gpu/drm/drm_atomic_uapi.c                       |  7 +++++--
> >   drivers/gpu/drm/drm_property.c                          | 11 +++++++++++
> >   include/drm/drm_property.h                              |  1 +
> >   4 files changed, 22 insertions(+), 2 deletions(-)
> > 
> > @@ -801,6 +803,15 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
> >   			drm_property_blob_put(new_blob);
> >   			return -EINVAL;
> >   		}
> > +
> > +		if (max_size > 0 &&
> > +		    new_blob->length > max_size) {
> > +			drm_dbg_atomic(dev,
> > +				       "[BLOB:%d] length %zu greater than max %zu\n",
> > +				       new_blob->base.id, new_blob->length, max_size);
> > +			drm_property_blob_put(new_blob);
> > +			return -EINVAL;
> > +		}
> 
> I'd first test for max_size before testing for expected size.
> 
> And shouldn't you also test for (max_size % expected_elem_size == 0)?

No, why? We are testing the values passed from the userspace, not the
kernel itself. E.g. we also don't have a test that (expected_size %
expected_elem_size == 0).

> 
> Best regards
> Thomas
> 
> >   	}
> >   	*replaced |= drm_property_replace_blob(blob, new_blob);
> > diff --git a/include/drm/drm_property.h b/include/drm/drm_property.h
> > index 082f29156b3e..aa49b5a42bb5 100644
> > --- a/include/drm/drm_property.h
> > +++ b/include/drm/drm_property.h
> > @@ -284,6 +284,7 @@ int drm_property_replace_blob_from_id(struct drm_device *dev,
> >   				      uint64_t blob_id,
> >   				      ssize_t expected_size,
> >   				      ssize_t expected_elem_size,
> > +				      ssize_t max_size,
> >   				      bool *replaced);
> >   int drm_property_replace_global_blob(struct drm_device *dev,
> >   				     struct drm_property_blob **replace,
> > 
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
> 
> 

-- 
With best wishes
Dmitry
