Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73BFCCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 19:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAEE10E652;
	Tue, 28 Oct 2025 19:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PtrDBg+z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHrc+n4k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C6110E653
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 19:54:33 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59SJlRbE2552965
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 19:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2afrDbATXikU2P98B6c0J0m4ZgHNuW/14p+YdDAqu64=; b=PtrDBg+z1RJoSGZw
 ngQn86Waw+T2U8zDWNrDutSLoe8j2rGOU4ErW+W7tYqptFgesimHadUVZrlht1ng
 CmUKNwb7ereJCI5Q4e/KyV2GRswAopZAku1w5o5l4np9fDq5tIY4CfPbmpZRWH63
 uA1o7cSLf7Fq7TbmIiSeq0pR7CGoHjqgD5H4SttoWiB5yd5o7x4ElY5GVsDiN8+T
 BOZtA5o+WBjmIKIvr1/jXlM5oAajD8efbYjRmeinshLqFUGNz2KNfzhu2IrHFyxI
 dvrhDN3guCj5uHHPZytfGhC2ApcnimbGGdEFEXC+2Haci447ir0uEEI7XhUhjehI
 M2Lj6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2g0fh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 19:54:32 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4e8b33c1d8eso159874271cf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1761681272; x=1762286072;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2afrDbATXikU2P98B6c0J0m4ZgHNuW/14p+YdDAqu64=;
 b=YHrc+n4k2Zs2POjUDpEwGd1MbKTZBmKxl0LQ8XcnLr5evfFM3xhJIY9TZGpNzyCVCZ
 S7my0a2Qc8W8SEEIsJNmb/yu3UWnK8hNWRvDMFqIFKwULpQs9QhqUzTK6QpSC2VQ5o3l
 JSP6r2Jqj6W49yJQmiLW+aQ49PElMkkQhohU9Rt1gJ2AQmYz+ac+2UEhy3RFHUhy7Fhl
 kXNKva2zaHa/G9zs8I8CyLAYr+lbFeVxfYL2EWAsYPLyOFjnMtpXQXHmOxK/24IpD9DE
 O8TpsFo8JagyC8Fjul5EZLDdo96ZEPeGOU7M1fnzf8rpUclHP/VeVr7jeNX4O7WDotft
 cqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761681272; x=1762286072;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2afrDbATXikU2P98B6c0J0m4ZgHNuW/14p+YdDAqu64=;
 b=KhI4MZrpfWTmL98ixpYuyMcTQOV7BBILt5cb3GD/02dADLizNMkEKXeQGiI/GkDmib
 rE1IlpV/6C70mP2IBeChOdubUskaLFrkGpEeoI7k6Bci4TWqjB6iiOEClIv827MM8gUx
 wM/Wj+r9gTwMideFC6k0pPDsB4ANHBnt2TN00Qab7sApObAToeZ6fwuMv5XJBfTf+hnT
 oPprbVarHw4ve/IGlXaBAfDPIyrKwu3tO7uHPWER2k0rV2DF5hnXeZjqPbfCFviiEMU5
 gC5jkLHqhEx9Z4lg1dZGEbIRz1rTjukIXtWlVLKG5S5+/6ssta4LMPxwu3+PHiGIZ7e4
 SHFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvg4lQGlcu61PKRk3+UjmOYwA7khkjQMJp/LkpMrtoUlYZ75C7fGoF+hXTkU/ddQuUDFrp6/hA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJuj6q8HgDB4N9pGyy9THPzEIdyKyuqhB3j5lL6jYyK9FFfk23
 +1D9vdkfbnNdyHAk5t8NZctTfOmAV3hzw+HFjI9xDV76RPl0ultrgBZoG308b3cIusqG9EVuCgc
 R5dZ6smfF2Qm3NN9n6iYuJy5TpX7ILUSRDButgfBKuOjaTouyb46BDOjadhdN9C91nlRM
X-Gm-Gg: ASbGncvUgtOdjAJurEZLaaBAIMksG5+QLz+iIl6hvULi9QwW2YK9QRgeZD+X0Ly981h
 oZdt8N9/67xSbCUYdWzJbfusUPMol6ha+s6wIWMH/bAMZrPhOE/WnMf50x4oo5PPtYwG8xzkMXx
 Bi6p0MD8ng/C3D+U3aU5TJVKlGUkOwOoMGPu+uVa7x+jUihchj7xZLryFckwAyNTLleAR530sVr
 kXUIq9ydN2e3PO5hMhYU016rpoCqiKZbyUFa0E3O65HsxPU7vqsCTJpiYkNAYA4dmbxMHthx8s/
 EfStUklMTo+8UFW+YWxYlEFPR8447D+UaAbDx+llwEe9gSYehJVhlNBAXnMbOSIoXqDR8VqjBe/
 XJjUtr3U91YpzDllV9J/Usewv9Cz3geZoBFnTXwlNErLAfjPn9fjWmcqgcd1COU6fd63mkGBj+2
 IdN15AJoF7scxg
X-Received: by 2002:ac8:5754:0:b0:4d7:bf73:7641 with SMTP id
 d75a77b69052e-4ed15bb30c4mr5992931cf.17.1761681271920; 
 Tue, 28 Oct 2025 12:54:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp30l/mxiO0/x28DsAYuBVAOl6GnYN2VrIZ7Onq+dUKIoHEjlqng8hPS5TJz3djMSRii/+MQ==
X-Received: by 2002:ac8:5754:0:b0:4d7:bf73:7641 with SMTP id
 d75a77b69052e-4ed15bb30c4mr5992331cf.17.1761681271214; 
 Tue, 28 Oct 2025 12:54:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59301f87f14sm3312685e87.112.2025.10.28.12.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 12:54:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 21:54:28 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, javierm@redhat.com,
 airlied@gmail.com, simona@ffwll.ch, linux@armlinux.org.uk,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, patrik.r.jakobsson@gmail.com,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, sean@poorly.run,
 marijn.suijten@somainline.org, tomi.valkeinen@ideasonboard.com,
 alexander.deucher@amd.com, thierry.reding@gmail.com,
 mperttunen@nvidia.com, jonathanh@nvidia.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2] drm/fb-helper: Allocate and release fb_info in single
 place
Message-ID: <dlvkkogiueskk4emkwdkpst4pvqk54ordyuqobh3hzqckuzz3f@gguhnqagpvwj>
References: <20251027081245.80262-1-tzimmermann@suse.de>
 <3d1bc193-fbee-464a-b62e-ceca06d8829f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d1bc193-fbee-464a-b62e-ceca06d8829f@amd.com>
X-Proofpoint-GUID: FDp8gTI_6UP-6f1Rv8P7hROqEuZllij1
X-Proofpoint-ORIG-GUID: FDp8gTI_6UP-6f1Rv8P7hROqEuZllij1
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=69011f78 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8 a=G-TusFqAXxKo-7y7638A:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NyBTYWx0ZWRfX4C+lSZOv2WSe
 opG1F+J6m71CFVQ0vam+D7RfQn2epOHGB8PWvSqec/g7ETsKWum3IAab/p5gCt75Smb0dr5cuZx
 DOuEqL05yFL9cZ8NzcMFQ8Q4JPrO/px7gvMQreCNWe6LMKRn3621fvFj2XqUBRqm8TEKFxSAip9
 8vb6hX3wDH2JfM7HIYAKAvu34B8y1CwbXX2wXTBvOxBeW1zgDzbpvdmy+XF/G42vq+PPo4RX3lJ
 2WLqyyV6mhGrSSZ+K9wwaoIywY+k/2KaQnhr5zq5m76OdGBugydGVvcJUeytPt6txDm7YlMPiDt
 D8ltXRVQhALFgdGg+hbxFy8TPsbii6R27n7B13jk/48nWVdyk6y5ziHcxQN00B6VY9iv850aHAg
 BAqi2zqd2KvBipD6ld1PXeUpPjCpBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510280167
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

On Tue, Oct 28, 2025 at 08:58:10AM +0100, Christian König wrote:
> On 10/27/25 09:12, Thomas Zimmermann wrote:
> > Move the calls to drm_fb_helper_alloc_info() from drivers into a
> > single place in fbdev helpers. Allocates struct fb_info for a new
> > framebuffer device. Then call drm_fb_helper_single_fb_probe() to
> > create an fbdev screen buffer. Also release the instance on errors
> > by calling drm_fb_helper_release_info().
> > 
> > Simplifies the code and fixes the error cleanup for some of the
> > drivers.
> > 
> > Regular release of the struct fb_info instance still happens in
> > drm_fb_helper_fini() as before.
> > 
> > v2:
> > - remove error rollback in driver implementations (kernel test robot)
> > - initialize info in TTM implementation (kernel test robot)
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Acked-by: Christian König <christian.koenig@amd.com> for the radeon changes.
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> # msm


-- 
With best wishes
Dmitry
