Return-Path: <SRS0=QFXE=LS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3AC49EA6
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 08:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE73613B7
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jun 2021 08:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE73613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C516EA89;
	Thu, 24 Jun 2021 08:29:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F2886EA89
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jun 2021 08:29:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKqDVmP8Tj9CjodJX9yiH6+3l4F1T7VSmdMjeqGu36ZQ5CGABttBUaRxvkLXQXh/MeHZLCJXHW/GdGba02+gGZjZRWwBUrTykmzXnGk8+rQi6Pfq0WPUrIAFHzwN5pcHDQK+XYJQIUQv9lfcJRI66Bjd0fXQvZGPuWigRebl2qk+eImdsDUSh4YLY/Tue8LtClQeWiIMKizgiXyatexl72eobxoIZMvzs/vs9pWh158j3kbs4NR/wyKDe1b74Zh0NustIUlAW3bmVL/Er1NA882o0Ed1EHTSc3H3q6lG8HLdqxMHTQpLGW+GRZvRu573F9vTmkpOVfCzfzZMAT3l4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1zXyPmeku7iPjSjnT9mxA2qlHToAZnnAtStcXn+4a8=;
 b=YQwztgJKCzscCbkDdfegHI/ZymyyYTqRYMX+tq0zVmfCL5erxndSySWMOo1but6pY4cecraZBG4g+0wmxPpiISpZgVFteYCf7HYUigT4ZS1zgCzj2bI8XMonCEP8B9zcAfkS9U12hPRqzLoQ+beIQJNgAsrdDWjXyG4M4yc9pURo6LNg0mWjNXQuGC9Tccm4zHag7gg7Uw9E4VCrKLPBk9895D+++XG7/xSNZMdJXaGb9EC405CF3eIhGlRFzN2eyUf7M9ejAch8SpumOikBGgLiyZUCvpOSKzZ7tZ4+z4RYRAdtUbfEN0nNjrmL7OawZq+FaWxuOiWzMxtoqOOL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1zXyPmeku7iPjSjnT9mxA2qlHToAZnnAtStcXn+4a8=;
 b=CJ5U1tmlXFpaJfbl4vh9BVCG9BD5A8wRzVvYPsYKaWNjdiByc2iJyHyZm0KPgHGPDVEYOWlRzKBgBSuhWbmv+BzonkSJBOMsZBLQB3n8SuMY03y66nyQl6iCFa03WOsW0eQKgHifVcXJchmkZYt7Zbvf6l3SX0qQsEz87hhM2rU=
Received: from MWHPR20CA0017.namprd20.prod.outlook.com (2603:10b6:300:13d::27)
 by BN9PR12MB5065.namprd12.prod.outlook.com (2603:10b6:408:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 24 Jun
 2021 08:29:21 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:13d:cafe::a0) by MWHPR20CA0017.outlook.office365.com
 (2603:10b6:300:13d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Thu, 24 Jun 2021 08:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 08:29:20 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 24 Jun
 2021 03:29:18 -0500
Date: Thu, 24 Jun 2021 16:29:15 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add function to show ucode name via id
Message-ID: <20210624082915.GB505943@hr-amd>
References: <20210624064724.77436-1-lang.yu@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210624064724.77436-1-lang.yu@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4319e14f-833b-4014-6c8d-08d936ea2a42
X-MS-TrafficTypeDiagnostic: BN9PR12MB5065:
X-Microsoft-Antispam-PRVS: <BN9PR12MB506564F2ADB336664DF57F6DEC079@BN9PR12MB5065.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ieJtHMU8IFF0zaihqFXhgL8fuuH4sp2fceiIqMQ06Joon8n/LUaJqngcXKF0v5yZab6UIk8cplhoEgz8596lTpc6VnU/TR6UBZm68jf2wBHVWYCjTFh8Bwu3/g/kQt2sKLYALK2yORQObGPBShrHfFL3uyLQfqRXu21d3P7JMjxDNsLtCAr0/3NjT2HUIlrekAOkDBUK+FRznfIT1BQ2ZavA4bEbC+Vl6bQ7hLdDvelWyqspuFWRNcz3rajpdL2cyJ7jKsJROMy9tcJrTVqd8W84FZwQVd6S3m1sX4T1DO21COdgPlcciE7TkD5etmiD6mgs1OUssAsrjSQ56vCYS3lvtxNixf0qW/e37ZY5gGxkOGlT0ppvtfjZgY6SyRZpBHA4B6j33vWYuYYr2hMWspQimBB7ea0tMA3k8OLOl77PzZqVki6AKAUCy3Zl+1SSs0KFqJT8mpknqtwSOjneUl3kUoDRXS/XRrRSnT28a3uue6CVpS3UVHhi/Uv6v+/NsTI4Disl0xnrwZIE0vQLuP6kaTAFvy+lWJjGYK+hJzWbuyctyQiMy6IHdwHxc3LCochhyQ5q6q9C8eWywxq+VVmfMqhCHvF0kdmEg6JWOZDQ95tzUNipz99olEmw7quu61pjbjwfmgx3C6ORS3sk5GGuK3XkEp9+Ej1emhaszCWHFQZeFJC7J+UUBan2bZr9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(81166007)(478600001)(36860700001)(8676002)(9686003)(55016002)(54906003)(316002)(356005)(336012)(1076003)(86362001)(6636002)(8936002)(186003)(5660300002)(47076005)(2906002)(82310400003)(26005)(426003)(6666004)(70586007)(4326008)(83380400001)(70206006)(16526019)(33716001)(6862004)(33656002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 08:29:20.7180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4319e14f-833b-4014-6c8d-08d936ea2a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5065
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 24, 2021 at 02:47:22PM +0800, Yu, Lang wrote:
> From: Lang Yu <Lang.Yu@amd.com>
> 
> Implement function amdgpu_ucode_show to show ucode name
> via ucode id.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Series are Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 78 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  2 +
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 2834981f8c08..6a03abb009ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -416,6 +416,84 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
>  	return AMDGPU_FW_LOAD_DIRECT;
>  }
>  
> +const char *amdgpu_ucode_show(enum AMDGPU_UCODE_ID ucode_id)
> +{
> +	switch (ucode_id) {
> +	case AMDGPU_UCODE_ID_SDMA0:
> +		return "SDMA0";
> +	case AMDGPU_UCODE_ID_SDMA1:
> +		return "SDMA1";
> +	case AMDGPU_UCODE_ID_SDMA2:
> +		return "SDMA2";
> +	case AMDGPU_UCODE_ID_SDMA3:
> +		return "SDMA3";
> +	case AMDGPU_UCODE_ID_SDMA4:
> +		return "SDMA4";
> +	case AMDGPU_UCODE_ID_SDMA5:
> +		return "SDMA5";
> +	case AMDGPU_UCODE_ID_SDMA6:
> +		return "SDMA6";
> +	case AMDGPU_UCODE_ID_SDMA7:
> +		return "SDMA7";
> +	case AMDGPU_UCODE_ID_CP_CE:
> +		return "CP_CE";
> +	case AMDGPU_UCODE_ID_CP_PFP:
> +		return "CP_PFP";
> +	case AMDGPU_UCODE_ID_CP_ME:
> +		return "CP_ME";
> +	case AMDGPU_UCODE_ID_CP_MEC1:
> +		return "CP_MEC1";
> +	case AMDGPU_UCODE_ID_CP_MEC1_JT:
> +		return "CP_MEC1_JT";
> +	case AMDGPU_UCODE_ID_CP_MEC2:
> +		return "CP_MEC2";
> +	case AMDGPU_UCODE_ID_CP_MEC2_JT:
> +		return "CP_MEC2_JT";
> +	case AMDGPU_UCODE_ID_CP_MES:
> +		return "CP_MES";
> +	case AMDGPU_UCODE_ID_CP_MES_DATA:
> +		return "CP_MES_DATA";
> +	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL:
> +		return "RLC_RESTORE_LIST_CNTL";
> +	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM:
> +		return "RLC_RESTORE_LIST_GPM_MEM";
> +	case AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM:
> +		return "RLC_RESTORE_LIST_SRM_MEM";
> +	case AMDGPU_UCODE_ID_RLC_IRAM:
> +		return "RLC_IRAM";
> +	case AMDGPU_UCODE_ID_RLC_DRAM:
> +		return "RLC_DRAM";
> +	case AMDGPU_UCODE_ID_RLC_G:
> +		return "RLC_G";
> +	case AMDGPU_UCODE_ID_STORAGE:
> +		return "STORAGE";
> +	case AMDGPU_UCODE_ID_SMC:
> +		return "SMC";
> +	case AMDGPU_UCODE_ID_UVD:
> +		return "UVD";
> +	case AMDGPU_UCODE_ID_UVD1:
> +		return "UVD1";
> +	case AMDGPU_UCODE_ID_VCE:
> +		return "VCE";
> +	case AMDGPU_UCODE_ID_VCN:
> +		return "VCN";
> +	case AMDGPU_UCODE_ID_VCN1:
> +		return "VCN1";
> +	case AMDGPU_UCODE_ID_DMCU_ERAM:
> +		return "DMCU_ERAM";
> +	case AMDGPU_UCODE_ID_DMCU_INTV:
> +		return "DMCU_INTV";
> +	case AMDGPU_UCODE_ID_VCN0_RAM:
> +		return "VCN0_RAM";
> +	case AMDGPU_UCODE_ID_VCN1_RAM:
> +		return "VCN1_RAM";
> +	case AMDGPU_UCODE_ID_DMCUB:
> +		return "DMCUB";
> +	default:
> +		return "UNKNOWN UCODE";
> +	}
> +}
> +
>  #define FW_VERSION_ATTR(name, mode, field)				\
>  static ssize_t show_##name(struct device *dev,				\
>  			  struct device_attribute *attr,		\
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> index 270309e7f5f5..4b0d34f1d450 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -449,4 +449,6 @@ void amdgpu_ucode_sysfs_fini(struct amdgpu_device *adev);
>  enum amdgpu_firmware_load_type
>  amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type);
>  
> +const char *amdgpu_ucode_show(enum AMDGPU_UCODE_ID ucode_id);
> +
>  #endif
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
