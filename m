Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89A5C8303F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 07:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A19510E2FC;
	Wed,  2 Jul 2025 07:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UIlakh6W";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2656A10E2B3
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 15:21:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561BrYBt029749
 for <amd-gfx@lists.freedesktop.org>; Tue, 1 Jul 2025 15:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nWs/xb1vRSVrZ23orH469KqPX5Uv0VM7XaZIbkm6Jh4=; b=UIlakh6W1MCgTS0w
 dQ8YPd0+SU/cW248W90o4Yn+WukQbWtsRGcboMH8I+RWg6rWgEse+YqacUs29E0v
 oRiJ+a0dDL5ayDgStgmik0I26Nhnx+x/LkFotu4/Ns1kxcPWo4TluIq1qiRj3GY+
 GMxyh6bkcsDfxD9uSWeGtu0qnhuVNtdoUE5NFXmkh2r4OHzpoTXe4KvkuOYgXrn/
 Kul5rvlt4XmBwOigbvoWEZnZOebN8vwkou5DuEAXjhzEij8FbdTYZ/C8Py8qiH+2
 WjLotb9uB8PRQa+EdoKYLd/cAk9vVbNEyj7y1FCM/qVnHKBaQoM5qyqjbxIs9a/u
 bHVwtA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47m02v3em8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 15:21:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2354ba59eb6so56305615ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jul 2025 08:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751383259; x=1751988059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nWs/xb1vRSVrZ23orH469KqPX5Uv0VM7XaZIbkm6Jh4=;
 b=AVZUx+H+VgXlnUufmYFJT4oGUlr3e+vJRX+veugV/qCBYoCz743+sYoaL1D3G8tIo2
 VUVqxsy79zbDN1cDQ08z1ct9JOWA9Qf1c6iUX6Fzy5alkx1JmY/2rfyKKWAEWBr3fru6
 vMW7Z91Kyp55nZj8SwYjNLRn3cFTOw09yfNoyg5hThoydIK7vUKj/mb7HV6D7oz1gv49
 yK/XkkQpniaedaIcUFwALTc/096AE4t5HnJ5rz1HXXOAYTNw7/35BW2OV+cujhb2dtAT
 QN7yxqae0Sofp3CZTF0spmzajVXy+gjvMUyypR+p/YMDI65Ko5LQToJfakHIzjjzyUbV
 0nqA==
X-Gm-Message-State: AOJu0Yxb9dw1N6TUcLjPgWDfnGRqdK6r3U3C5RyPkkffun64tm8LhTqR
 fm/xsOr3y9hcxrkM8Qdbk31OdCOgoy8T5zdTNTfHwXy3RFIH33m5UuSRmEDSn2BC3c7C0H6+QvU
 l8clwQO/CQUKm57E4+Tio89AsTDeWDXl5AnVcKkrGyeaJ7RoO6lKzCEuam+ByAzDZG4h8
X-Gm-Gg: ASbGncvsDH0QtZXGyuhZmswpjcw8tkPQtrJp7rNqcayMVwnRKxFhDTJZ+oIAXNTQCnu
 wAAPF83+xQU2g6jmsttwo97SHUSH0pU/FLM+maEfLkV3VTvtFH0NwO7EAQki+TUJESt4KoA9zMg
 waCLMv5uCPK06Qjdje50AVztHYSXyiW8E0EuNt6ptlQ7Ja65xFrGPzL3/DmA2LL4Oh0ZUjT8TD2
 G7JWPGGeIlrN+PSYHC/74LvLsM8a/ufm5otT4Hf8Svw1doEZb24k+P2mBBwhq0UMQV+Ox9KVDub
 gd5Xqe0DDIKP7Z9t121jcyoMUZ4Jd8LCcqkZZ9Cw4u8Scsx+JCMZXm993byyj5a+9O7zH2c4
X-Received: by 2002:a17:903:2acc:b0:234:a139:11fa with SMTP id
 d9443c01a7336-23ac381b1efmr236944175ad.3.1751383259300; 
 Tue, 01 Jul 2025 08:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFStwjk67YEUI9Oq8heAN5eBmkoywGIh/1YJEVqnxjaukSDuHrgyVq2fd/MD04Ev/pgKWVXWg==
X-Received: by 2002:a17:903:2acc:b0:234:a139:11fa with SMTP id
 d9443c01a7336-23ac381b1efmr236943785ad.3.1751383258925; 
 Tue, 01 Jul 2025 08:20:58 -0700 (PDT)
Received: from [10.226.59.182] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2e1b49sm110555205ad.22.2025.07.01.08.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 08:20:58 -0700 (PDT)
Message-ID: <04216cc3-c8ec-4782-a021-705f53c0fefc@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 09:20:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] drm: move drm based debugfs funcs to drm_debugfs.c
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>,
 "phasta@kernel.org" <phasta@kernel.org>, "dakr@kernel.org"
 <dakr@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>
References: <20250701063303.3210665-1-sunil.khatri@amd.com>
 <BL1PR12MB575314D550E85AAB35321DA79341A@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
In-Reply-To: <BL1PR12MB575314D550E85AAB35321DA79341A@BL1PR12MB5753.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDEwMiBTYWx0ZWRfX7OITKUFwpfcj
 /jpD7BPTfiRssEusaau2DKtw5OQHYxHOATtPSp0g5jVobyb1ARrknwdM4nxyrwVSoimgP+2pyRq
 IzYjqczJKkoD777z9q07DQtKTsKec0X8y9REOXOTFgHiiPA4QZ8m9/q4n8F5uYJJ00pzdiVEcYd
 e2nMH5slgw9ghPFjzD8Fv7c5bd0Gmi7s91xI+s7VCMZyghgl7yGNoH9eVkh4/5sZw0hbdfpZKn1
 L+MsIH7BUDMq8ViLsjtmq9eV+pxRTThCNW5UZNa6vXKKB4cToacPtG6zwg/N4z5UsV3ZhqmdBk3
 1E+vmmPdhRN1VvT8Muakr7eU98EffwUSoU6JCI/e9nNOiac8UgpEkuKF9zUb0OS6FGBEhF+4SUM
 2tIkQ00C6JX6SUAs2vH+tp1IKzoeuEmnE6Ig3I/FCfcyOmViumk8YRprBP2nR6bDrPlXhkQT
X-Authority-Analysis: v=2.4 cv=Y8L4sgeN c=1 sm=1 tr=0 ts=6863fcdc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=RAJSH83syF66xFRst6sA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Hqfz55hMQjYDrWe1TZXHWMu8H88JThJG
X-Proofpoint-ORIG-GUID: Hqfz55hMQjYDrWe1TZXHWMu8H88JThJG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=888
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010102
X-Mailman-Approved-At: Wed, 02 Jul 2025 07:21:22 +0000
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

On 7/1/2025 7:02 AM, Khatri, Sunil wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

I cannot review this message with this restriction.  In my opinion, your 
email client is not properly configured for interfacing with the community.

-Jeff
