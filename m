Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E19C1C87FC4
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 15:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4263010E382;
	Sun, 20 Jul 2025 15:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P/vBc69j";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8B910EA16
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:52:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8p9kE021593
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/jJS211K+91WfPtzNzKrjWRU80MmsvCM3rgFx21dfM=; b=P/vBc69jyQvb8sow
 lV/WOYxFLnnzhJsAqu/H721IYea+wKWldZ4xEYW92WXsZSktINoRbl0ftsHf3RFw
 x/1FLPFMwXwG9xAzrRr1gn/M+wzs6rR9jrpm7PFqfcpCe061m5PGDozIRfvr1fSV
 x5Ip0dkql6htf1/vbpv662dOR36r0VSNUp2XahM1HQuwQknuXgRAi3EeWFMXbo57
 ZmW4wtfDwMEKlSGkHEK+X61BYZv3NI767se+yb0V19LFavGHalln4qC7+6fHfQWf
 oi/SngOP17bMOcXoOE/IKlfcsFXN9g9wlPOWUOZyhdmB/pJowmXiJOiwODcz6jUd
 +PHV0Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufu8m5cn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 16:52:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3138e64b3f1so3212404a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 09:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752857519; x=1753462319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i/jJS211K+91WfPtzNzKrjWRU80MmsvCM3rgFx21dfM=;
 b=HfWTSniyspd1Lijg1Q6uaKnlEjnlwlNQix1mjyEBEa3x6jRQvtABC0s8DZP6nTW2zK
 3xHT0V2yeKf3SjJqAy8h91y5J6He/kyu781WPVm5T1yefo1z11NOL4YSrOTWZWxLb1ca
 KfpuREENkfQ0x6Bk6n7rMPb2503F0HuesUjg3iIauWXRCoQWqpY+ogdQnXJ/HPgQficI
 mxtYHttBwGtj6Y5G0lZiTqH9lVm+EGWkFlxBnNxsL7OlTo00iZRLaJLXbfo4fLBrAbmz
 arNvrMHTQVrfk2A/f/c89xLMTZJJyN6Q/ekNVhKOZjYDUotuiEmpUsu9VeghgkzErvRq
 Z05w==
X-Gm-Message-State: AOJu0Yyw5miB1KKy0WZz9v0SiqMEK47HAggY5LT4IWZK9W/oywtTIf0k
 K/4LwWD1JNbsecjU66vRYa8BoUsYIpg9XcZWaiMtCYTWXmBWyFzZMPLCwWCBx8suy+3gjfwdefV
 /TPuxoGjPBu4FkGcioHtdDqSv0upIsgGHNuXSqk4zlBMWn+cEwfnYeg29r33cRIZf19zY
X-Gm-Gg: ASbGncvwc83MKmu4jZs/EUk/BvYTqQaOCQSIhNVDFuhPwPPOUYJK+1OzoCx8rsGSuXu
 z/ZiBtwDvhEVsoKs63J+FkF5G49xSKN1H3BcI/vUfpCKShQ+OnaBdBvpAdJQWXq8fdp9vMsSZnf
 n1OYHf1Tys6alSP2Gxw/ujQDpSlE/j6UBZsdzkgnSkvX9v6ZZA/TkwYjgMyOmh0/CtpdvAxw/CE
 7Y4FMRB4+c2/1UCqh+uFty4UvFVB4wY+x4ZNvr7gU41/4gxKT6s0GkLx2skgxhaUTt3qkl9Rg9D
 SCuUqYADHmiQTtAkNIbxiryWRC5o1kWvaR0A0PIQH6O01ZfmeFtf3/xva91/h4Rw8DJqamz2LuZ
 2k4pn8y23JTtxfA==
X-Received: by 2002:a17:90a:ec8b:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-31c9f3993d8mr17038304a91.2.1752857518917; 
 Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9NIA98X5HRDDVuwcioD+0TFYXDcZBMvtr4Luz9HPLr/CXztRxjI3u8ZOFya8id3YrAIy6yQ==
X-Received: by 2002:a17:90a:ec8b:b0:312:1ac5:c7c7 with SMTP id
 98e67ed59e1d1-31c9f3993d8mr17038273a91.2.1752857518544; 
 Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31cb6ad7257sm3078809a91.42.2025.07.18.09.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Jul 2025 09:51:58 -0700 (PDT)
Message-ID: <2de96bf3-0c63-4db9-b581-f011bc1446c2@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 10:51:55 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/4] drm: move drm based debugfs funcs to drm_debugfs.c
To: Sunil Khatri <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, simona@ffwll.ch, tzimmermann@suse.de,
 tursulin@ursulin.net, phasta@kernel.org, dakr@kernel.org,
 linux-kernel@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>
References: <20250704075548.1549849-1-sunil.khatri@amd.com>
 <20250704075548.1549849-2-sunil.khatri@amd.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <20250704075548.1549849-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMyBTYWx0ZWRfX8sf+Y6ZkQZj/
 BMbiybDAHqgMmCP5xlaiMMwVojxN1D1OUR3ixUfLw1fy5VX+IOVmsx2YkmDnF0r44fI/ef/18tk
 llTh7LfMbrN8fkPjf281tMAUZaAUTKMdgYarSAZXgfBhBhiPR69gcLGdavVAnYu1G07N+avvbe5
 TSYX19llMyf2DHa/zawWDAuH8Sgo/fOa04GyeExmhUotjbSiuPOLnRL6nwpHPAaTUaSoRr0OuCJ
 ow2FIBlmpL20WurBGRzjTFw78rFZgtxKn1uGmCRhIyKk5cv0OJEnXzL7K1oZgMhvqp5l7fufg+9
 Fd+kSHVmk590JVN2O9sraz3hHVgndXK+HhtDt68LFxZ1bN6FV0d14MgwVYhEudG2ITxnmg4HnJM
 1n8G8gtLzdv8fdAgcabeyUQtiBKdYaFSrCMcQSxru0ZK6L9vzCFjiiTSSS1Um1vqz7eLQRoi
X-Proofpoint-ORIG-GUID: vVRxF9N1S_ZtSQeJrFOssHA_nkZgJPL3
X-Proofpoint-GUID: vVRxF9N1S_ZtSQeJrFOssHA_nkZgJPL3
X-Authority-Analysis: v=2.4 cv=f59IBPyM c=1 sm=1 tr=0 ts=687a7bb0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=qFjxPv6tQ-BECiE8w1cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=724 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180133
X-Mailman-Approved-At: Sun, 20 Jul 2025 15:32:54 +0000
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

On 7/4/2025 1:55 AM, Sunil Khatri wrote:
> Requirement is to create per client-id based directories to
> hold key debugging information and for that access to
> root debugfs dentry is need which is not in one place
> and that information cannot be stored in drm_device.
> 
> Move the debugfs functionality from drm_drv.c and drm_accel.c
> to drm_debugfs.c This enables debugfs root node reference
> directly drm_debugfs.c and hence enable to create per client-id
> directory.
> 
> v8: Create drm_accel dentry only if it's config is enabled (Jeff, Hugo)
> v8: Merge drm_drv and drm_accel debugfs patches (Koenig, Christian)
> 
> v10: Since we moved drm_debugfs_root, hence to handle drm bridge
> debugfs add a new function which call drm_bridge_debugfs_params where
> drm_debugfs_root is accessible.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

 From the Accel perspective, this seems ok.

Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
