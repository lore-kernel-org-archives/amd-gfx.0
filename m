Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CC5C624D2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 07:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E3110EBC8;
	Tue,  1 Sep 2026 07:59:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wvr4TpYc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QMjHVEmz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F4510E33B
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:34 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VIXvja336792
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=; b=Wvr4TpYcqqNSNW/c
 7MbI/noBMgaCUGPiX4RNjBSbAAlI6cOG626h8HzDCimzMCq5DR6dyRBuef3EKvWJ
 pmyeItpWbagjmktj0sQR6TmfTyhz4Dz29ufjJuG9MXRO+8V2/zrD4bGQCfC3APBw
 hwOiP1+IW8UwARVGAPJMqbMy2QKLnpPNKMrcQVuTLITjDisdbqmvph7Fm3vAyImW
 e9Vxp5snkUtEuHev9TE+JQA+XS6pKAnAsKEegcI+Hzf/cHJElkii+UrFnGPWRrOh
 gCXzQJj3Zg5Cx7jUdlKC11q5LIuyIRQ7DYidKoga5yvTGmSj/rYaFXi0krGH/xVc
 IKwn2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6h938fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 20:59:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9375d92d8cdso711288685a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788209973; x=1788814773;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=;
 b=QMjHVEmzllHG9ePlZJkwEtyUGkuj2tv8ltNjxwD5V0oQP9BUUckI9Ewj58fiq2iTwW
 ujcZPRk/tsl31thKuBW1QQE9rsQIdPbeEadQtt5288EaZCFrRBD9qS06NYRHPdad6XIR
 y571glQUWGmwEucdnT3F13vHGz90eY249kMBOxff7/ojFmRYauYgDoixT5ZGeDNzsYRs
 8otHrUwfslkTFbMXNSNf9PDtRMILUHZwvqw235E0sVHS4AWYMQYeCu2KOFHFyQDOnca1
 yiV4rwvSi4wXCasleG7JFnSDE27LZ+JDwaKK9yKUBvPPE0ObsLHhz/Eyz7GFhkqjGAD6
 k2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788209973; x=1788814773;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5eH2tkoqrxEkiPHG70y7OV/Rv6ro3jsgF0WXE4qtlyo=;
 b=n1OEn8ShnTe2RZafCVDUPIET8frB2EYt1sp4/A2qL4iawFy3kZsVOuuJyK2ifJjF4w
 e1p0g8datg8/8feNgbAJvJ6EF6RCCJHsvYjg9FH8XYwIaUnmpSb6gq327/r0Q9qtCNco
 CrE4tRTiekVxlNFW0uc5D0zdmUDs0kB0wfSfIISm2mXAwm9wbgtkEPrt4kQkxKg6Bm7D
 8MjITHv5PDkmoNi0G75F4HNTZNfi/yTO7vE7IypiIXva5Nc3f0uIDKni1K5VVVxfXHMM
 6xBHgQfnbuh+j5D09SInIAQfDYDXH1JA0egde74fzwA0Uzye6HDa5s8iVU2AcgoLMX/L
 09BA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6IG0ouhJNLhD+uwKMfIxJvku/ajjth4CbbCBGabWRx7YrhrWSEalNAB/uTmpxKTiLRGGWVUPm@lists.freedesktop.org
X-Gm-Message-State: AFuF++lntG1WuqGpBVnoTy3QpuiMko6UgEfv0/zn7gGul4O895pkIiRm
 6AeMDukUZoQMnJO+LyArLJYUDcIQzrzSsOH5GiZatH+WsS/cZG8Z770eMxgxdGdUhWtvLxRbG+S
 C+CpUeyzTJuLQo0So5pcAOM8AkDFGSSdKuCt6UeuEcOQ7iwK+7cfcH4TGHKO5fm34JOgp
X-Gm-Gg: AR+sD12qBOGacKV5MVypnMR7szuUshk9/r+bEZuPTh3xwS+2ImyTgTTm+6rfCn32sd7
 04iV8ZKtwKaicX+q2IaYOO0TUTmfMTLxGBZ8N7YC9jAbC6Rjr84Y5qWrbUfTiOVPRgUTozKoFAW
 9vwesLpmpi4M76N2HExS9+3PphBaWiDC+CuS5ekbCObSIU0AKh2GaxbflfK3zvBnYG37SoMM052
 iBiweT0pzSPRZ5B5qe/Z8oWtplxFvoXfWaQi+DJZPzufj3YkGuZr9QK6NneM75/zHwkS7ZJyOZh
 ryBAQmpZM+9zL8AmbZB5c6xnZBGF3djqobFXffpADBLX77bWZbrmDMCyQv4iZ8kyR1KqloAXeIy
 I1u/GMXS1FriiCYaFesHsMHFvok2uaWuDnYedUg==
X-Received: by 2002:a05:620a:44d3:b0:937:75cd:4627 with SMTP id
 af79cd13be357-9391395431fmr3175556085a.32.1788209973212; 
 Mon, 31 Aug 2026 13:59:33 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:937:75cd:4627 with SMTP id
 af79cd13be357-9391395431fmr3175550185a.32.1788209972753; 
 Mon, 31 Aug 2026 13:59:32 -0700 (PDT)
Received: from [192.168.0.183] ([80.233.33.41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d6eafesm277031f8f.24.2026.08.31.13.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 13:59:32 -0700 (PDT)
Message-ID: <da6868f1-1f9c-47a2-ac48-88dd160ae3e3@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 21:59:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 04/10] drm/gem: Convert drm_gem_private_object_init to
 return error code
To: christian.koenig@amd.com
Cc: matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, dakr@kernel.org,
 ecourtney@nvidia.com, nat@pixelcluster.dev,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-5-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20260827124910.2245-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=W6UIkxWk c=1 sm=1 tr=0 ts=6a95eb35 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=le/gl0x2G5+ma5yo0zCuxQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KEyuISjlM5fmf-MbB58A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: nLgbnp2SL1wLFwrmS9ygrzoz_pQfQZHM
X-Proofpoint-GUID: nLgbnp2SL1wLFwrmS9ygrzoz_pQfQZHM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE4MSBTYWx0ZWRfX82XCaOCk1qZa
 3kuecE0LYi/d4i56mbVsNBLukvYxcYYig99dmc4ctxcfDbjKEUBFjIRmKdWDKWQiz7Q0lKlTGwD
 SuJPgAlnIwOuI6I9uXKLqpkbhAfebeM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE4MSBTYWx0ZWRfX8SMx4vPYVMcN
 4XlO4J6po5iaF0AOe6gdHA13xpH9pEop45KPEORDKWkCnqfvExTyfnRglfpLJID9jsXGnhCWlG2
 B9gYBC++C5+vl8dYYwn/8Il4D0JiNUgOmzUu55Ueo+6eZB2WVbYlEyKvWDWHtX/oAzItr6XVKSS
 l0J0ohYLgxTq+uQa1r+7EyTqKeUYrb91rIs518cs2xgV4FywAt7gHuFzIaHv/08TRcmPd+KGec3
 sKDWbydyIbdbWqLFDQGIBR13AVsfwcvpT0JOrtGxs9jNw1Bg/OTBc1tB+3FDIgc7nlgxEWKLTrK
 gliM9FdM2eyCOZjT6ENAh/RQ9EAQRcOVPOPGmfPDhggjMJ2p+wWJD8U7ThHLEBuBPRwMl5ILFFC
 QLqRGTH9XdetmFUAGbX15gk1m/+9VHVbvoLbQfjYfQrc+89AILOpIRIRRt4WBKxwC5WVHWRPAOU
 QuNoPcKoU2j87ox997A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_06,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310181
X-Mailman-Approved-At: Tue, 01 Sep 2026 07:59:19 +0000
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

> diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
> index 8a1d6c5636c2..5b198162c588 100644
> --- a/drivers/gpu/drm/i915/gvt/dmabuf.c
> +++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
> @@ -202,13 +202,19 @@ static struct drm_i915_gem_object *vgpu_create_gem(struct drm_device *dev,
>  	static struct lock_class_key lock_class;
>  	struct drm_i915_private *dev_priv = to_i915(dev);
>  	struct drm_i915_gem_object *obj;
> +	int ret;
>  
>  	obj = i915_gem_object_alloc();
>  	if (obj == NULL)
>  		return NULL;
>  
> -	drm_gem_private_object_init(dev, &obj->base,
> +	ret = drm_gem_private_object_init(dev, &obj->base,
>  		roundup(info->size, PAGE_SIZE));
> +	if (ret) {
> +		i915_gem_object_free(obj);
Building on v7.2 with DRM_I915_GVT enabled will result in modpost undefined symbol error.
Exporting i915_gem_object_free() in I915_GVT namespace (drivers/gpu/drm/i915/intel_gvt.c)
should fix it.
> +		return NULL;
> +	}
> +
>  	i915_gem_object_init(obj, &intel_vgpu_gem_ops, &lock_class, 0);
>  	i915_gem_object_set_readonly(obj);
Thanks,
Youssef
