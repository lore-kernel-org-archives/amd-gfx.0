Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDF9C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 07:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85E4A10F275;
	Tue, 19 Mar 2024 07:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u3ko8KSs";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E08B10F275
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 07:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0hLNSoqRhr5WgrCqaKePXYshqzmxIskWSn3NBPI0SE8XwypUeZwb+My4hzFQzQ8UYYRYK9hjqujHVqxMoyIP8ql/1xnZrwdjGcB5rjGHbdWp4VroJS9PJmRJaLc3L1fhEM8uQsXb0U247uIr8F1LUew2GAFI/XMpC7FxZ074bCsOBXPyS021XKzcwIqErTQ2UO5Su7jG9z/AgyL6Z5J0swuxZV+GlDZhFl4+2SkGPfpV4MLjC8UXsQYcin66fVgEVsuTsXLSpxEuOTRBUxYQOl4PGwiGRwzuL5Bep65HAAPmWDaObzA43sUSAWgWtvakNFKajaxkAN6ad3Ixem9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdLvb/55W449etbo+K5S9JGZ1nsk7ai8Pm1EzxHZ6IE=;
 b=RcfXxp4X3NiDSOSFiY48X+zQ0VEsyXbyEb3BMXBpSUXmB4wqQ8OTUE2OhuxXL/+aG9wVbqADJ40KbWhPScM/k7cA4c4CjXaEAKZt0D3y/2PE8iZfcmXtFsij8i7/l5XvZk/ZNiO6lIVKV/NZIlYapSKDrV5e/7CwFHyC8BSMaopaC7102N2HAo5gGFgg8U20LtQZCXHxsnSFeLNTQao8BY+bv3jmJFeJPPzo9WM58H0Qo8Roqhz6kifBqSJE5ZLevDBlkoeXPfEX368hJSz8IjXB3qbiUhqB5cprt02d3bWnh2Uem/vQGcq0bfSmm/zMom/XE2HkKQ0SKF9jG9FtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdLvb/55W449etbo+K5S9JGZ1nsk7ai8Pm1EzxHZ6IE=;
 b=u3ko8KSshAonYuEQzO5QRzLKsC7bHGLmgG6dBYw0uqEjCan02iT8yhuqfUMelcu473+KlCmJCA5XcZvqpCK2t4TCMw8zEN9nXmxG0gGaCOJ2MqTatpYDWxSN8W71dHmOD4Zdq9SCM//nDgFF9O/MjoT6E4a3TMcZuo1CDTdH/jY=
Received: from MN2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:208:23b::10)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 07:10:18 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::a5) by MN2PR11CA0005.outlook.office365.com
 (2603:10b6:208:23b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 07:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 07:10:17 +0000
Received: from [10.65.150.118] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 02:10:16 -0500
Message-ID: <6a6793b8-792f-4831-8a8e-c63b299d570c@amd.com>
Date: Tue, 19 Mar 2024 15:09:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm set pp_dpm_*clk as read only for SRIOV one VF
 mode
To: <amd-gfx@lists.freedesktop.org>
References: <20240315063158.18105-1-lincao12@amd.com>
From: JingWen Chen <jingwech@amd.com>
In-Reply-To: <20240315063158.18105-1-lincao12@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 1571f534-b2fe-4bf6-5eca-08dc47e3a1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qF3Qda7D2Hs8zwS0vlm7/fwQV56oSyWzW8uYZ+JybcLYyACwp4XhZa2UINyZloPZogKkSUqnqRmH4sa75hYFFiRfjOfr3VURn7qepmoQaoIXny9mFCpiodPv1bU4NwAPcU6RGSkmc5dfOTBP5ASr3GzGIbmU4Ujj1Huqsy7qwiSULnnUCLqnyTkMKWIg/EwQynTez5F41dmxVhccREP2xrwzKgZtRvsNKH5iFvLaxSbFxvf81Ze+Kw6IwlCaAhdLVNoXXUUC8APCXcpRf9IzLfvZOjLXO/LcxzaIMxTDKjJ091U3DJknUC9D9pVX9K909FqkQ9dep2rO2n/QBYHHjcPeovav6KJTTj32+h5Am6zJNJ0bjeMRBx1VVfvuhLXzphy6xclL5vv5f/zegqcV+VgQaATQ6qbrQgVlS6RMH7hmqhaZ+/BAgEf0udjnn1VqArUSjRpnbWpOlLAdj4gWoycGPjCq6mGCXrwek6zlPCxNvDTW/io0Y8RCFuvIjsbZTLO8/XO4d3AUafFayC2R3q7tq/uiF5klyIXKWeUPM8pf6rRCcUkANWao7Tlg56Ba5yoPWx7hq6WNMQ2Flq3Dz47/9W9lXcE2GloV9ZC4Q2TLfcT7vMrklDbS7Xg4atUPSZvk377m+IiHbvyF46wG1dzBJbrujKb9zJ7wPwJx2skYFHzKo8fDibFsA2euPTzBEC7qEWZDU+zdD3uCwWUgT/dvkv98oX0XKzbEMCl+0/+z65h7/XtffcKO6IX9xFik
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 07:10:17.5898 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1571f534-b2fe-4bf6-5eca-08dc47e3a1be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
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

Acked-by: Jingwen Chen <Jingwen.Chen2@amd.com>

On 2024/3/15 14:31, Lin.Cao wrote:
> pp_dpm_*clk should be set as read only for SRIOV one VF mode, remove
> S_IWUGO flag and _store function of these debugfs in one VF mode.
>
> Signed-off-by: Lin.Cao <lincao12@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index efc631bddf4a..2883a1d873ab 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2367,7 +2367,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>  	}
>  
>  	/* setting should not be allowed from VF if not in one VF mode */
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
> +	if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
> +		DEVICE_ATTR_IS(pp_dpm_sclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_mclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_socclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_fclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_vclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_vclk1) ||
> +		DEVICE_ATTR_IS(pp_dpm_dclk) ||
> +		DEVICE_ATTR_IS(pp_dpm_dclk1))) {
>  		dev_attr->attr.mode &= ~S_IWUGO;
>  		dev_attr->store = NULL;
>  	}

-- 
Best Regards,
JingWen Chen

