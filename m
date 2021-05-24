Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD644C04FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 06:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B6D76105A
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 06:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6D76105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113BE89D46;
	Mon, 24 May 2021 06:58:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2077.outbound.protection.outlook.com [40.107.95.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C0389D46
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 May 2021 06:58:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6hFdjh57OvUt59rNjd8blnC3eVEPjr0jZgPsA9o0MOn6Y9uGxSC/Qaf4WJWGEFu231oVh/EtV8eP27LKzgFQgQYBKz0Z42CNp7G6tobcBLKjVV9+o6dBJrB/dwIJj+/0i0RIGcq36LP/mo6/2Hl8NAx0Kfa6l6r88pTICyL+4U2qMORo29cN7SJisDlsERMcF7+xxvMxdmm3/C/sQGOT1CbFdytfI7PeWzgRca703vT40AAMc4G+46R3L1FYjyDZEFWZvm+2uPFx++Ilkz3Uk9b+G+kbjyum85NJF5kla+nKnMW5HtYVfh/Ach68YuEpTlsIoEXNYVwgP43uR1hMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SId/fCaai3n7/Z9k9vpvxQsAJxgxmCzPSX2b9QGorw=;
 b=cLts9c6nA2phgXqaNIWLVzJf3A6jqrR3mjSEQ0+WL4gzuO6ZFems6ohniVRfHmxUkVFldwZ9j0Zjo0aKCV8vIsgdThsEiWKHgzs8/Rb46v6oVJJftrmZbCIEAvDvW1XiDvC46hbKGSK57blVpJdxCpc1vd5vMbErVmCoTYiBuanPL+OFMd5tii1Oo0ASVZS+wA1Fb+lN3MPIdFEeYk3JVgZnl5nTtk458YIIR5pATU1PLFVIlHF9B7G/4AyoUmdw8xNbbg2UBNiSy4HGTf/HeDFnIcAaWaGQRFLW5xAPnTMrKlPyvXmta8ZYDvu/7MbFBqRuatTezWG+GrS6Nen4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SId/fCaai3n7/Z9k9vpvxQsAJxgxmCzPSX2b9QGorw=;
 b=duJvqYLsOgclddayRd3aKKMU7fTuKQgGmX68LWYJ15LkoP/2VosGMEEZBiliVSJeYr3ZlVxdo4ViwQn+tR+vYDO58jZj2P0kKaZW+OPtQrA7k9AUw95JN5u9A+wi5TciPqcMQ/EK3Y7A4bbyOrxfqhnpx1wEM11pEv3yJipeR3I=
Received: from MWHPR11CA0041.namprd11.prod.outlook.com (2603:10b6:300:115::27)
 by BN6PR12MB1219.namprd12.prod.outlook.com (2603:10b6:404:1c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 06:58:32 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:115:cafe::fc) by MWHPR11CA0041.outlook.office365.com
 (2603:10b6:300:115::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend
 Transport; Mon, 24 May 2021 06:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 06:58:32 +0000
Received: from [172.31.157.114] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 24 May
 2021 01:58:27 -0500
Subject: Re: [PATCH 1/6] drm/amd/pm: Add ASIC independent throttle bits
To: Graham Sider <Graham.Sider@amd.com>, <amd-gfx@lists.freedesktop.org>
References: <20210520142930.8369-1-Graham.Sider@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <05960347-a7ee-20a4-a657-4e523a14aaa6@amd.com>
Date: Mon, 24 May 2021 12:28:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520142930.8369-1-Graham.Sider@amd.com>
Content-Language: en-US
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57441b88-0877-43f1-46a6-08d91e8157f5
X-MS-TrafficTypeDiagnostic: BN6PR12MB1219:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1219F3F3E6F487CE1BCB467997269@BN6PR12MB1219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7u6jqqdU8D2SwGU6Ra6WgHg9Q1w4R8g3tSIAnxMX41cEHB5woLFjG9v6XyH2obzfZDKxa4IGmuSTw4460yH6/3No8jArzZl5UqXVI8riZiJhDSTmrP9kEamUJB+nM9oLtLg1JAmoffVBJ8gwZZlmJ7jDxv4qV+IhUDHQaCeWmrjTK/W4+TgM3nepIhep2Dmu75uV8LirLrWp0FWYhN5+AlnFz/8HyZGphWBZ7jmHd3hQksikCr26Iqe30FXT1An4M+8WBoCDKkE+lpoXMIMHzgtKxfptYkLQPU1yHPWMpcr9J3YvcJ96bVSUxn8gSWoioNB+9C+/Sr1bIAS/GyC0JRKZqvB8nUGBCXrNsUuaTn3k0pg8WoLGkqtpKlqbinLnhob6a9/ih3rWjg7Xj54cGIQB6m4898v05R1EK03jUUBtYEAc5+mGfW2w/20eFo/e9vvXAwsHBBuLqyejX5zhD6HsuAiJQ4LFS7u+ePQteMKjZql4//4Y4/P9yfTaNzx1bya5WlXkI4WIS3QwogH/QE9ujVcBgKS0k7eGR3+lr+sMS/8M516Nn6lhAF3Pz2Sc4xYufaW+Y7EOY/ODggPh8wKf2eu3daZBFiAdOXqPzPt62ezgThsEsfxwVqWoqcoW4X2FSHT4goc1nlDARCF62vICNGrQVsPVFdulotuUe0/hRFMtHTMkxdnHHZRP+z5uK4idN8G20lmIyBtq6rEF9N+VYEXktTuIEI6LyVjlTFY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(36860700001)(31696002)(82740400003)(81166007)(316002)(54906003)(478600001)(47076005)(26005)(110136005)(86362001)(6666004)(31686004)(70206006)(70586007)(16576012)(356005)(53546011)(36756003)(336012)(2616005)(44832011)(8936002)(82310400003)(83380400001)(4326008)(8676002)(426003)(5660300002)(186003)(16526019)(2906002)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 06:58:32.3323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57441b88-0877-43f1-46a6-08d91e8157f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1219
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
Cc: Harish.Kasiviswanathan@amd.com, Elena.Sakhnovitch@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are duplicates in this list. It's better to classify as 
Power/Temperature/Current/Others and map; maybe, allocate 16 bit each in 
a 64-bit mask. Also, keep the naming consistent and start with "SMU_", 
that's what we do for others like SMU messages.

Power throttlers
-----------------

#define SMU_THROTTLER_PPT1_BIT		
#define SMU_THROTTLER_PPT0_BIT		
#define SMU_THROTTLER_PPT2_BIT		
#define SMU_THROTTLER_PPT3_BIT		
#define SMU_THROTTLER_SPL_BIT		
#define SMU_THROTTLER_FPPT_BIT		
#define SMU_THROTTLER_SPPT_BIT		
#define SMU_THROTTLER_SPPT_APU_BIT	

Current Throttlers
-------------------

#define SMU_THROTTLER_TDC_GFX_BIT	
#define SMU_THROTTLER_TDC_VDD_BIT	
#define SMU_THROTTLER_TDC_SOC_BIT		
#define SMU_THROTTLER_TDC_MEM_BIT => Should be the one used for HBM as well
#define SMU_THROTTLER_TDC_CVIP_BIT
#define SMU_THROTTLER_APCC_BIT		

Temperature
------------
		
#define SMU_THROTTLER_TEMP_GPU_BIT
#define SMU_THROTTLER_TEMP_CORE_BIT	
#define SMU_THROTTLER_TEMP_MEM_BIT		
#define SMU_THROTTLER_TEMP_EDGE_BIT		
#define SMU_THROTTLER_TEMP_HOTSPOT_BIT

#define SMU_THROTTLER_TEMP_VR_GFX_BIT		
#define SMU_THROTTLER_TEMP_VR_SOC_BIT		
#define SMU_THROTTLER_TEMP_VR_MEM_BIT
#define SMU_THROTTLER_VRHOT0_BIT		
#define SMU_THROTTLER_VRHOT1_BIT

#define SMU_THROTTLER_TEMP_LIQUID_BIT

Others
-------
		
#define SMU_THROTTLER_PPM_BIT			
#define SMU_THROTTLER_FIT_BIT	

-- 
Thanks,
Lijo

On 5/20/2021 7:59 PM, Graham Sider wrote:
> Add new defines for thermal throttle status bits which are ASIC
> independent. This bit field will be visible to userspace via
> gpu_metrics, replacing the previous ASIC dependent bit fields.
> ---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h | 32 +++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 523f9d2982e9..fbbebb1da913 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -35,6 +35,38 @@
>   
>   #define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
>   
> +#define INDEP_THROTTLER_PPT0_BIT		0
> +#define INDEP_THROTTLER_PPT1_BIT		1
> +#define INDEP_THROTTLER_PPT2_BIT		2
> +#define INDEP_THROTTLER_PPT3_BIT		3
> +#define INDEP_THROTTLER_TDC_GFX_BIT		4
> +#define INDEP_THROTTLER_TDC_SOC_BIT		5
> +#define INDEP_THROTTLER_TDC_HBM_BIT		6
> +#define INDEP_THROTTLER_TEMP_GPU_BIT		7
> +#define INDEP_THROTTLER_TEMP_MEM_BIT		8
> +#define INDEP_THROTTLER_TEMP_EDGE_BIT		9
> +#define INDEP_THROTTLER_TEMP_HOTSPOT_BIT	10
> +#define INDEP_THROTTLER_TEMP_VR_GFX_BIT		11
> +#define INDEP_THROTTLER_TEMP_VR_SOC_BIT		12
> +#define INDEP_THROTTLER_TEMP_VR_MEM_BIT		13
> +#define INDEP_THROTTLER_TEMP_LIQUID_BIT		14
> +#define INDEP_THROTTLER_APCC_BIT		15
> +#define INDEP_THROTTLER_PPM_BIT			16
> +#define INDEP_THROTTLER_FIT_BIT			17
> +#define INDEP_THROTTLER_VRHOT0_BIT		18
> +#define INDEP_THROTTLER_VRHOT1_BIT		19
> +#define INDEP_THROTTLER_STATUS_BIT_SPL		20
> +#define INDEP_THROTTLER_STATUS_BIT_FPPT		21
> +#define INDEP_THROTTLER_STATUS_BIT_SPPT		22
> +#define INDEP_THROTTLER_STATUS_BIT_SPPT_APU	23
> +#define INDEP_THROTTLER_STATUS_BIT_THM_CORE	24
> +#define INDEP_THROTTLER_STATUS_BIT_THM_GFX	25
> +#define INDEP_THROTTLER_STATUS_BIT_THM_SOC	26
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_VDD	27
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_SOC	28
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_GFX	29
> +#define INDEP_THROTTLER_STATUS_BIT_TDC_CVIP	30
> +
>   struct smu_hw_power_state {
>   	unsigned int magic;
>   };
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
