Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985C8C3DA4A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 12:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4517310E7A5;
	Tue, 20 Aug 2024 12:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qp4pIjh+";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1867B10E793
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 12:55:20 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-3718706cf8aso3405678f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724158518; x=1724763318; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ngRoBeDBVxwsr8KowtAh85ovhHVduGWqpMKlvWBi1CQ=;
 b=qp4pIjh+KmKXmCIiMqpWWPTNKcGg66dQ3ptCmEuAJvNy7W/bay/Dt77htXs3LYB1iJ
 ssaCzq8jaqlHHqODTIqYBR0Mdw32AkSYUtkzfgFN3SoDsoSjJARlPutAdK68llnLy4Tj
 cTXVhnI6yqwEv87yRB+RtTq8brQjpwMlye+COvlCbj3+fAEdpnHNOOUPd4Su28afDgdf
 skuQt1fIB6XItSn7Wqk0oHCB1bHYUzCzXyoXAE+jCFkWkZNQWCmbq1PQPjvZeTY92Me3
 3CNAamvZxZ43yWE5J2X40MYfZe7oWsxmvoUPIUKl1YOMDOJwUuPTNi4SAOAhdrlIGdnA
 aUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724158518; x=1724763318;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ngRoBeDBVxwsr8KowtAh85ovhHVduGWqpMKlvWBi1CQ=;
 b=XU5zs5EYhpb/GM0NaEa9oRBOwk2juHRLS0+WJmdEXz9GzKa+mvBvm5U7VLeRnlCR5u
 2Vx8LOOucwb0YmpNBZnxHM8HPaIq0aOI3fXR4e3eoV5zbfrNFVxENJVxOWGrZTUqv+4t
 YVj36V19IWWbr/Kg/M0k+BOt/EcX0jLbQj9+0WOXil4rM7jIwboUJlG83r/+wqNKv6T2
 EmRMvizXT1XgTeA917GUHvmQamLxeWeHKFHzymmQz+IuxSG+VGb3TsQRNhdmfqnHraFv
 fgGNCf81zgQX+bFDDJL2L8RpQc1iycuad9aWnCKOAMEPbHwZBoH8FA1vjl6Wkmh9m6E1
 IvVA==
X-Gm-Message-State: AOJu0YznG/dHHTgAQ/zdZnGsuEqZHkuwXRQHfSgpRwsx8O53bDTHsaFX
 66UpuBS5/V/tTyKQq07Udl3el//BD+QbyRoZicOoAdWYqgRDkuuALlWumqvfCjs=
X-Google-Smtp-Source: AGHT+IFAHL+RJ5gD/FYZRBFwpA6DtkNcBmPdTEulwk7pezIgOYHEz65TukuTZbdLoNIxNzFy6AHmig==
X-Received: by 2002:adf:9790:0:b0:371:913a:3533 with SMTP id
 ffacd0b85a97d-3719454bd5emr9453217f8f.22.1724158517905; 
 Tue, 20 Aug 2024 05:55:17 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648e76sm143087615e9.2.2024.08.20.05.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 05:55:17 -0700 (PDT)
Date: Tue, 20 Aug 2024 15:55:13 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu/gfx11: add a mutex for the gfx semaphore
Message-ID: <17436eb7-00c8-4ef3-b58e-de47cedb685f@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 20 Aug 2024 12:55:45 +0000
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

Hello Alex Deucher,

Commit 76acba7b7f12 ("drm/amdgpu/gfx11: add a mutex for the gfx
semaphore") from Jul 12, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c:4778 gfx_v11_0_request_gfx_index_mutex()
	warn: inconsistent returns '&adev->gfx.reset_sem_mutex'.

drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
    4745 int gfx_v11_0_request_gfx_index_mutex(struct amdgpu_device *adev,
    4746                                       bool req)
    4747 {
    4748         u32 i, tmp, val;
    4749 
    4750         if (req)
    4751                 mutex_lock(&adev->gfx.reset_sem_mutex);

Could we move this lock into the caller?

    4752         for (i = 0; i < adev->usec_timeout; i++) {
    4753                 /* Request with MeId=2, PipeId=0 */
    4754                 tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
    4755                 tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
    4756                 WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
    4757 
    4758                 val = RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
    4759                 if (req) {
    4760                         if (val == tmp)
    4761                                 break;
    4762                 } else {
    4763                         tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
    4764                                             REQUEST, 1);
    4765 
    4766                         /* unlocked or locked by firmware */
    4767                         if (val != tmp)
    4768                                 break;
    4769                 }
    4770                 udelay(1);
    4771         }
    4772         if (!req)
    4773                 mutex_unlock(&adev->gfx.reset_sem_mutex);
    4774 
    4775         if (i >= adev->usec_timeout)
    4776                 return -EINVAL;

Either way this error path needs an unlock.

	if (i >= adev->usec_timeout) {
		if (req)
			mutex_unlock(&adev->gfx.reset_sem_mutex);
		return -EINVAL;
	}

But I really think it would be nicer in the caller.

    4777 
--> 4778         return 0;
    4779 }

regards,
dan carpenter
