Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C69BC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F42C206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 08:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ekvvS/s7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F42C206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D2E89CDD;
	Tue, 18 Aug 2020 08:26:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF3AE89CDD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 08:26:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgM4mfhtvlCPFMj85o3270d7wSByAT0LeS4jl+4FSrJKR02WdNLvPq5n0FsEJdZl7HdufzJRcrTNR5HUjqkWg8uv4yV910vxOko7f8JoVnzUEvVoOhci+TGnvJjn4xyx5WjxL6OQp1xn10vyzSyP173B3NjbeW6c4GxVb3zg8bntROdbHJf3Iwz+8iQgELVvXN+F4yt5KONDCYtXN4jTkzHnlX6bzXzYM1O6SBCHsMxXvrx2mB8XZJXeWO62j5mUZ+p60LHalvnQfXQZb0MPrVnttOs/ooeUZcJmp+2LzPhuoiU9uvzCS4oYalfXSGyAnkWMdzMYdML0JYKkFw31wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pM6GRfzpcJaB6ElpVgCTibbHfdhB+yT+Ocn6wpXQ8c=;
 b=FWIbFo15kWjOzHQhbmtxYONT7f0FNB7gMoHzlIQT4uL2C7bT470JR9/xfdFTTcaCFLoTQwdX5FBXLn0lkjc8EH5uvd8B3zhqKdz0SFykBvCzUfvQC+kbUdGUqFVuubCRXIrBw1l2ybob5ksXk8CsEaRPK9Fn+1wfPD/cUANgxAeO7inuNS5Jt47q5pKuG4oDJzcFWSS/DiuHZ3nTKN20aU6XviWQcMPLeeU8i313bpKtjBWG9L6VnTSWG4wDZviME1EM0l/P00SOYkg9l+z91Pa/ckGOyKQXP9XM12HvwYYBaY7ci8go4iiCdk8dT2iToyW2F66cUsZqqxEoOCeuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pM6GRfzpcJaB6ElpVgCTibbHfdhB+yT+Ocn6wpXQ8c=;
 b=ekvvS/s76IzSWemfSi1zzmPLXSgVVOdirMq7QEOj8UM/uTLimqy8SoriIjMQQxV3yoJPG5nawrrt3dwWif8guqpP41wEa7ybhlBVMdvlUH46r/FhzynSF4XDB8hncuoNEwzabB+MSVhAZJQl9ILNyuoH7VJZTcteITvtxVrANIg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 18 Aug
 2020 08:26:47 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 08:26:47 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/pm: only hide average power on SI and
 pre-RENOIR APUs
To: amd-gfx@lists.freedesktop.org
References: <20200817195329.1971490-1-alexander.deucher@amd.com>
 <20200817195329.1971490-4-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <4d83c901-cec1-a004-bc64-7e77d674d377@amd.com>
Date: Tue, 18 Aug 2020 10:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200817195329.1971490-4-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::42) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
 (2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69) by
 AM0PR10CA0089.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Tue, 18 Aug 2020 08:26:46 +0000
X-Originating-IP: [2003:c5:8f2b:8b00:ad4a:160b:54c5:6c69]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 161ebd0b-2e1f-49db-a68e-08d843507288
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4418F7594CC097958FA933078B5C0@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eqlPa+oRXBQq3wK7cJs6Cj3IQgftjhZ5tHrEWr4+CqwFzYlN1hf1LzWhU+kx7xv86w3XOBwl9Xw7Y730aT0ZXiH3I7jM1ZuknundPx8FxP7BHHcT8EZYY+Ri/Pwa2XPx9Xw/tPpcbcxfacGLxdBefjj6eRq4xPSmzxHJ3YubsrY+v951ikE006hv+O8e6JbM5ThxnHyZyeDKLUvfYnoEh6cU+CxNaRcYkJiI/uTJcjeTliVvxeNU8f+mKzRaDeAVBcsrFilNm/5rP7HnnJ267roHstzx5C+pHTbOhFcf55UqwWGJNen4jvn2xSk9Ww/5TW8EjqzScPn6eUrMfuZtW769XVxDu467ec/gMVr5so0c0GUxWfiiZ0nrBPYnT46
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(66946007)(31696002)(6666004)(83380400001)(478600001)(2906002)(6486002)(31686004)(8936002)(6916009)(2616005)(8676002)(186003)(16526019)(66476007)(66556008)(36756003)(52116002)(53546011)(5660300002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MYCcplQKe7eFIJyZcx8g4Z8pmkQTV/X2WebkiNrBAzl0TrvcrJLfUr145Qq6g8VzPSQ3nLkvAgmZh/ymNfGhhyETdy0UH+6ddWReSledB6R09kOC3YmjO3xuV1QnWkKggp4/SbiNQQGsbuGDVdKmPS1N7OAmeNJo6Fhh95czjOEfs9WiT9dbCbAFi39mz2bNB9qNUxNP41Y6CBV4mEXx90pJw4TcnIMn/YvtSceqU41VRRPW5mfmLyjJoSU701iM1iXvrTrxthrTwo0SO6gL2rtdquVFiNFt89k9wreNObXH/DvqSfd1s+nOYaY0YVSn+QiMVUjWdVrphg1t4MYCKJM1zVAlJy3trg3WCc2N9hIYZ5+yRoDtFyQXZY19G1pgxaqe7agnKEY+RaB+VwnG63MCNQuUBfsZCox/UO+ycmdDreZzGheDkudRRpPwTDM9ZSBoxsrzhVJCvEGvh5C1b2sNMOYIgvafLucrrbJCcUy83GEoG+vbLlA8EmXs2ta/kW15FUWQhc3BBAftvWmQnr32UYRMtv/1bjgLQGejXAq6Gdd0KO+uMB94FKiUTcRfAMjmzWCSE3tuiuGDqDc4e8LwoIQevPWkiv36nc34gHmGOmH0RvSzGXhwbIP63MKbKinf7Ol2jnefG6y0vxNdbZFQvJn310StrzkLz8rCGlx5z0bHr0ZyqZJB4ParWAFUS1IOPY+rfupHUIcvC3I0WQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161ebd0b-2e1f-49db-a68e-08d843507288
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 08:26:47.1687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJDZuN/FwfEHeCetmqbjAUGMbB9tacM8hWKS6ri3Z0e9UELIpzcgkUYULnyTNJLM09xjvIK4ZsBjFbh6csIACw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 8/17/20 9:53 PM, Alex Deucher wrote:
> We can get this on RENOIR and newer via the SMU metrics
> table.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index f2e70655e8d9..a77f7347fdfc 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3312,12 +3312,17 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>   
>   	if (((adev->flags & AMD_IS_APU) ||
>   	     adev->family == AMDGPU_FAMILY_SI) &&	/* not implemented yet */
> -	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr ||
> -	     attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> +	    (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
>   	     attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
>   	     attr == &sensor_dev_attr_power1_cap.dev_attr.attr))
>   		return 0;
>   
> +	if (((adev->family == AMDGPU_FAMILY_SI) ||
> +	     ((adev->flags & AMD_IS_APU) &&
> +	      (adev->asic_type < CHIP_RENOIR))) &&	/* not implemented yet */
> +	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
> +		return 0;
> +
>   	if (!is_support_sw_smu(adev)) {
>   		/* hide max/min values if we can't both query and manage the fan */
>   		if ((!adev->powerplay.pp_funcs->set_fan_speed_percent &&
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
