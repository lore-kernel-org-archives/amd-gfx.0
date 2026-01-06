Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D699ECD0431
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 03:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A13710E073;
	Tue,  6 Jan 2026 03:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DFd4TSda";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CLWuLUnv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B0410E073
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 03:10:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6060nn0t1845052
 for <amd-gfx@lists.freedesktop.org>; Tue, 6 Jan 2026 03:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZTfa9wA8T0PaE0E1zoWe0d
 puxT/D7unhHfcCbxzfev0=; b=DFd4TSdaGjKEdGf+wA1frYDd66dXOS3fwpfd09
 L2pvdmVjlp3o5efikasJ1hqFGW27Ei6E2EEa7dM/3cN4PgjTeYuljnMYL6KtnQz7
 hNlZbJcKcUyNoQEiEhxlWzpDy6/g5NYuZ48wWW4aGhnK+zewczKTLPBEb2kYpG8a
 Wc+5/vrTL6QgqKZBOjOVpEVLaRmqaZ7Eq6zT/pEbsMdKg0kSeodbo561dTiTsbEv
 URNe3Fi3+zTiTXD9FNRwHamKWlmj+oGh8rGSAPWcvDe6jXL7HMxP6JgUIwWP9G9E
 qM3z0S/RKdss07e2Dv2h4pntA2Sgwl+35eDh4WKmTz0Tn1Qw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg6uubevy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jan 2026 03:09:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4edaf9e48ecso18500031cf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jan 2026 19:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767668999; x=1768273799;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTfa9wA8T0PaE0E1zoWe0dpuxT/D7unhHfcCbxzfev0=;
 b=CLWuLUnvZ2GRE7j5K5ec3z8xBH+ASKWQ4ituQe4pGS/uNR+fP6CSOoCksuVH+TKju6
 RtnBjAjZGkmvch4iXo1ovc/xY1rRB4Cf2LqWkJ+IoElNvWzkDPhBwOxtSU789ZQpTttl
 Gi8s3RzIiRmMsV+TIYVGmz2BX9+LOy2l9J+tn01NGr40rJl45I9f5qHCvwGhGEgd6rFW
 0TRL5/JQ6bQh6iUNTx5KTZgN0BuyfmMo/7LBe9NBpwxMNmXYvmkh7001Qwskogt1mgPS
 7pd4xH5liPP+OLlTwLi78RSJlVl/y7UUbpuTcLs0+oQ99wi0nKPfhi2Q+NseWWhbIFCR
 3lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767668999; x=1768273799;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZTfa9wA8T0PaE0E1zoWe0dpuxT/D7unhHfcCbxzfev0=;
 b=qOgYNVgHcUohETP4lVISSs7HOnR6jqKMjGBkTEO0qr0NxE0pcdZEnZWICZfF7aMXOe
 qIai89hpwOK/7un1J9o7HN6TPqE9xO79xgoLyWsLYFDnZpm/i2Qys7qAymOzUB3n3Br9
 mdc8Zyz99+vJDn7lBOfvd2YNAjCRHnfgJRP3TOdRdK5kxPU22izFPgOt9jXu7w/4nlmk
 lAOlt+2/lEPqsQHuwnVlmvANWztBsTSgn1mrAtE82YB4TKs5JJky2xNZzekEO7IBGBkP
 67zazvqsjCOhwyNf97saO1GMtyYDAEMfnUjxIh+SgvlB0i7pP+MBPvR9xecPOADXMdy3
 n/kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYWcwTm57czR0g5FWkrUllYfBvENSLkCo3XwvCILE/aA1dGG4UsmNVYlkRdj3ocurn8alnZDRn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB0AmbA+TyguvNEWP+antlBV2ba5i7lwj9YjZjQnWY9MF5zYAT
 KMfLZTH9UG0Yk2vJMPz3HTUjObTVQMNPe5Z8zJUHaBXVdYTFx8teSH3cG2OEqvF3YXBJFdmTqOm
 nkPCHy1TBmBbyQXYSwjawDQHvX0Fa5kwpDVhkyg1LWnxSOiTh3C0Hmvi+/oQp16evaWKE
X-Gm-Gg: AY/fxX7LU9gEejCPP9gQK/jSRmJezxsPOmkEiGOpYX4numG6NUy8bE6+qSvIy3zepwb
 XPVUmWmXyTYarAdd10FR+StvCHHdQmPfmEjpqHc35oxANGq38sb89Onr3rZ3/dFGCU0y58sTYdQ
 RNFIVfvdSrNV7aWfxnpVmLxLstHwCc2kSKj5s0w52rk5LZjbHeayblcPhNAGfw98EYwkjhJmo+X
 A+sGIVrTVzt5GtZkxAml8j3oFtBt/G7EyicdokEYxMofQB7xOmUeDM7T4DTODo12HXLGpcPpGR2
 t93uzYh90RXZrGklaMaFlsb02Mrcf/wN838Ma9wNH26tpvC3gux2XbOyMA8I90eu7uG0diMuVkb
 1obdHtaDxC/EzFoFX5swWddKjmtra99xSDuvRwmVD1YU7dSQMWMi3M7oQE3wPnskrVAd/cgX1QL
 HCAcIXssqQyw6j8oNza64NBiQ=
X-Received: by 2002:a05:622a:4ac3:b0:4ee:4a3a:bcf5 with SMTP id
 d75a77b69052e-4ffa78583dcmr20493581cf.67.1767668998878; 
 Mon, 05 Jan 2026 19:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtMMytdXKOdfWr9jpNpiYTarVWG9byyZNEtfvBoH7+SDJ2bhYWIKAl7W2ZCBk6vxjgpVBdHQ==
X-Received: by 2002:a05:622a:4ac3:b0:4ee:4a3a:bcf5 with SMTP id
 d75a77b69052e-4ffa78583dcmr20493351cf.67.1767668998373; 
 Mon, 05 Jan 2026 19:09:58 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b65d0d22csm242869e87.37.2026.01.05.19.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 19:09:57 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/3] drm/atomic: restrict the size of of gamma / degamma
 LUTs
Date: Tue, 06 Jan 2026 05:09:54 +0200
Message-Id: <20260106-drm-fix-lut-checks-v3-0-f7f979eb73c8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJ9XGkC/23PwW6DMAwG4FdBOc9dYnCHetp7TDuEYEa0AmscU
 Kuq717TqtqFS5Q/sj87VyOcIos5FFeTeIkSp1FD+VaY0PvxhyG2mg1aJOdcBW0aoItnOM4ZQs/
 hV6BqmhKJsXLOGm38S6wVD/TrW3MfJU/p8pixuPX1xdEWtziwUFK976gmasLH5ySyO83+GKZh2
 OlhVnXBfwmx3pRQJbIdtc7j3vot6fZcOPFp1s/n59am8cKwFsV8KFZ5iBLeXxcY+Zy19XYHqIo
 xbT8BAAA=
X-Change-ID: 20251114-drm-fix-lut-checks-4bb325e24110
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1983;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zd7KvTkjp3RluqiZkKPwKlyuKSXMCiArD2cEpi+mKn4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpXH0DYJMUCmQ8UL075S1QSsUvbl0tseCtCXkN+
 8XptjZVvRmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVx9AwAKCRCLPIo+Aiko
 1Q/vB/0RdUlaSsb9MVSbrumP+g0aTu5modvg/i19dR7jZIzr6ErKRD/nCxGksViadJ4fLxhB5Xd
 RhzOFbFaDOpYTqm5fuGs7b8kK5E1zOJbYPl9op9KNjaiy6FtkDHhDgF/2YKl74n0/gQXIPjCaja
 8t/kmsRhwzAzwGYZjDPM1+hE1wkapJUKtI9pLAalDcSZBDjBe9yz40u+xvSt8E6JEl5q3weIcot
 5Y9vKH2LcKOXKUGhRwamyiSINyfzUgb3tN+ZrW7T6ijgWPeypBVNDS6/YYTg7yn4bRzYRpJJBJM
 DUh3mmqK9d78nvTIbDdjRKL8exswJ6qPpyDyIf/xWlMDdpqv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDAyNSBTYWx0ZWRfX2w6BpjN9PqW6
 JGtte5sLrxs1U0dq3p4y/09pPZqV8uuJMmX3wiCTRtI7jtbNUy5c7t3qQBtAsQDrraQ6xfRhUk1
 XCCZiuA+ad1In6+QZ6ZiwmCCqdgIOjz/XICa9v111WytWDjRZ018zQwUCYocQt7IgEZ5ZFRQ4dx
 wR+p+DefmbSTvHlytZVQ8bOQ6c8r02gYvolIaY4E5WkTcBWqpMks7ESn8hqw6x0349OnkVGlwwE
 YZXnh7TAxTBrCNNYO2bcNeVHpL15UNXit6G5PyPH6dnWJCGeY5G5GCT8GLjqlRpYNeH9zoX0Ro2
 /to9Cy16kP0qfIr3ZsvRToOtF9IYpNRfYuKznr2NyxAxBfTjgouV8amwoMTHWfkLTJAES4ffPLM
 oukbmbT3ryy7J+JDYRrvMwPsR3IpB/MIl5by3AuXuJBiHz091gADwcWLscI7tE6w88pfEUyW+8f
 NaN2EJAsTLw6DPY1kHw==
X-Authority-Analysis: v=2.4 cv=eZ8wvrEH c=1 sm=1 tr=0 ts=695c7d07 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KipMzqLmMTXpIc6q-14A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 37oJviMick8aMSIyq_vcPeu7lqhTo9vf
X-Proofpoint-ORIG-GUID: 37oJviMick8aMSIyq_vcPeu7lqhTo9vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060025
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

While picking up the Gamma correction patch for the msm driver I noticed
that kms_color@invalid-gamma-lut-sizes and
kms_color@invalid-degamma-lut-sizes tests fail. These tests attempt
submitting LUT tables greater than the size specified by the
corresponding property. The issue doesn't seem to be specific to msm
driver only. Add generic check that LUT size is not greater than the
size passed to drm_crtc_enable_color_mgmt().

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v3:
- Fixed elem_size type (LKP)
- Link to v2: https://lore.kernel.org/r/20251228-drm-fix-lut-checks-v2-0-50f5d1a260a7@oss.qualcomm.com

Changes in v2:
- Fixed comments for drm_object_immutable_property_get_value(), changed
  it to use drm_WARN_ON (Thomas)
- Reordered arguments of drm_property_replace_blob_from_id(), moving
  max_size before expected_size (Thomas)
- Link to v1: https://lore.kernel.org/r/20251115-drm-fix-lut-checks-v1-0-3586f5855bc7@oss.qualcomm.com,
  resent at https://lore.kernel.org/all/20251210-drm-fix-lut-checks-v1-0-10ae38519f43@oss.qualcomm.com/

---
Dmitry Baryshkov (3):
      drm/mode_object: add drm_object_immutable_property_get_value()
      drm/atomic: add max_size check to drm_property_replace_blob_from_id()
      drm/atomic: verify that gamma/degamma LUTs are not too big

 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 ++++++------
 drivers/gpu/drm/drm_atomic_uapi.c                  | 32 ++++++++++++++++------
 drivers/gpu/drm/drm_mode_object.c                  | 25 +++++++++++++++++
 drivers/gpu/drm/drm_property.c                     | 11 ++++++++
 include/drm/drm_mode_object.h                      |  3 ++
 include/drm/drm_property.h                         |  1 +
 6 files changed, 73 insertions(+), 17 deletions(-)
---
base-commit: 349d4efadc1f831ebc0b872ba1e3a2b7dd58b72b
change-id: 20251114-drm-fix-lut-checks-4bb325e24110

Best regards,
-- 
With best wishes
Dmitry

