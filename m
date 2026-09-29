Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE42CCA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 02:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512FC10EC68;
	Tue, 29 Sep 2026 02:57:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdNL9Wgc";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85CC110EC68
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 02:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk/MJJXQBxomWoNWDwVePOspYdw2H3VULkDgqUV9n6osap4FT986hB+mZc5hgKYJPmtfv3+LHJIoIXDq7ROejhngcq50UEHVRSn8ZuKOvwRfElhMHyh6PJPzhk6lhMOM/GgA1yN3WhGiSymC2dEYEc41qEtS65zedzvPBmP8vRTe1fDH9zlOJlbapRKE6R8KiZi2YxjCjsKlsU5jienhuBAlj99spT8P+mbJWztPp9ljEbOB/xTb+YqFmUsMHKNcJYQYQOniwVf2EOphxfxHuLUPyzV4uxqaJ6FUS+ugct076aW71JTWqMFlNL5aqLm7/D830TH0llJMa9p/Ms2NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNzV0wSXhv6JRAYgbXC5V4p7TlYHPPNNZ6npwlCCoQM=;
 b=K/zous8TyJRv/Pa3Y0L6QuSnsO5DTy2VhBwbvAifx22r956pNGYLcILylCtGPSXLaJhAXQ5Vj3zzlNiVe6LusHE+bmlvzRNfQqCTUnq6L3zMcp+RG9uZIsYYX+4Mqk0VaTpCAaD+hY/flbqd+UZfEtBevGkbKQidWklrvYh/zyof8AJui1T2UHjFAiQKutpCkTwRUnhBxwSzP63UIEjqLH65ADts/knyDUhzY7Pyh1JdwaQ69QjmiM/usweeCf3ryNQqSxyLQOjt4Bpj3myYz5sgphuhFYxF6j96hhXyLp4yp9F8ExSYb1KCeX1iLertd9btIo7kK8NgRSm5qPLKrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNzV0wSXhv6JRAYgbXC5V4p7TlYHPPNNZ6npwlCCoQM=;
 b=WdNL9WgcbCibpl9TF4ipeqQKzp3fxXzq+dd7LLtAEupbnmmCrrL0fncUMoQNjzbwwLyV9Jk1lIIxgAWCrMk4iHIn67bEc4ofdQ/k57bt925VscBCfqFDe9Ywo81nUDrXqAeDqFGVYWGryfLUQ/P7sjn3CKG1gEWB8CLzig8aalQ=
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.24; Tue, 29 Sep 2026 02:56:54 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:2e:cafe::90) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 02:56:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 02:56:53 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:56:52 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 21:56:52 -0500
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Mon, 28 Sep 2026 21:56:51 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix the unit of the SR-IOV IP discovery size
 check
Date: Tue, 29 Sep 2026 10:56:46 +0800
Message-ID: <20260929025646.3899495-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924070131.2150481-1-YuBiao.Wang@amd.com>
References: <20260924070131.2150481-1-YuBiao.Wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: bf74f12c-6a79-4402-1c43-08df1dd5513f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|6133799003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hI29kstsVslAH7apcRrACqYZl93V+1vR28YsCntX9k7FPnK4MV6ik+xrbmhliULGD1X3HdYMZ4Kbcnu3/VEyPXFpJpcFMwGNXIzKVmZBdIoWDygp49Fr38l1XKFG+zIKDgYU1u4GsYC7azlh+SoynFcfiPbgfNTeWwQgPnlI5TyiblXoyvGURfabhd5aLAH7tJ3+/p1xfk0aufhUzZAezf75c08tj10VZxoSQambk4QNVsRbg6m1bcOg2kAutwHSGr5591qdMB5SO9U2Qx/+hfM/wkmeXeo7v3YCEBadZ3VVuO/TEEcYpI7RchlqfzwKXEtsG6v4x/Zrtad2zPwD1lgJ9we8eRtVrC9elPDXEyX+90kYoyfm/g14gYhcrgcee/ICtSME29lJteFhb6simRQVa+qSNemSmu50xhI25pI0AsOI9CCMArf9EsRMraqSXpVcWI0K/gIVQv1c0c+Lkev90nXV3SEAiCyUo+JNS3sQKRqMI+A5BSCYURNkERgfHReW6r2A14a8cGjFQ+fqmzfic6tD15g4kLGx5kgjP3wztLC3c7Q8r1SbpCJ40bPQlPRyv0GgUzhcyFdSfIsEXCMyR0dJZofsYF5DeblvZY8byVmOKiPJQA5LBzyrWc1pFnre6Fl/W9HSfZpHj5B2ArTmLw+UiEi97TXhB/Lg/tkqgvr/Mrof7wKM8iYE9FDq27u3sEWgU4Xk9fJHDFfHNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hxhLrefIsumC1DO2YYd51R/lImX4KOiEgK4noJ/7NN03vNGJ9i2IUgsRMoNwjHM35rUd1C9gDb7xOQ3To337h11D+vaBErtq2lmdU8xItxfg0eyD+zd34R8wAAHIFTP9cg6ck0nD2JWiKwB5M1MSNkC/eoX9G2fnMQIvMqle+OR433kbqDYDF+zBX/fAcQqaPQaUABw4cDxIdUpuRZRShFRwjvYzqRvgjAP3SJGzlOuV9ACt9TvzMD3+jpvkhCPkhqZzlNtGPzs2TUHwaBDSaDCOr4mFYShANFSdSco3QcEEJebjRtCksMsDoJXUSmNQg3Z08usZKZUYyrIFQ40BUh2ppboPHPz+xAeRrhRwjRcpjmynGVFZmC9r6YET3hpZ+YDnW2uYpIyIb9M9SXnbzbH1mdcZkkoSjM2Csks1hat2fIpBM8VB6aCtggWsmGmg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 02:56:53.7407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf74f12c-6a79-4402-1c43-08df1dd5513f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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

Ping.

On Thu, Sep 24, 2026 at 07:01:31 UTC, YuBiao Wang wrote:
> ip_discovery_size_in_kb is in KB but was compared against
> DISCOVERY_TMR_SIZE, a byte count, so the check never fired.
>
> Compare both sides in KB against a new 16KB SR-IOV bound, since 10KB does
> not cover new ASICs which need 0x2840, and drop the duplicate check below.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 11 ++---------
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> index 6e1d55e78790..94964efa7dac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
> @@ -28,6 +28,7 @@
>  #include "discovery.h"
>  
>  #define DISCOVERY_TMR_SIZE      (10 << 10)
> +#define DISCOVERY_TMR_SIZE_SRIOV (16 << 10)
>  #define DISCOVERY_TMR_OFFSET    (64 << 10)
>  
>  struct ip_discovery_top;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a454c6f12d38..73d9072f0c6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1115,7 +1115,8 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>  	/* Validation and initialization for each table entry */
>  	if (IS_SRIOV_CRIT_REGN_ENTRY_VALID(init_data_hdr, AMD_SRIOV_MSG_IPD_TABLE_ID)) {
>  		if (!init_data_hdr->ip_discovery_size_in_kb ||
> -				init_data_hdr->ip_discovery_size_in_kb > DISCOVERY_TMR_SIZE) {
> +				init_data_hdr->ip_discovery_size_in_kb >
> +					(DISCOVERY_TMR_SIZE_SRIOV >> 10)) {
>  			dev_err(adev->dev, "Invalid %s size: 0x%x\n",
>  				amdgpu_virt_dynamic_crit_table_name[AMD_SRIOV_MSG_IPD_TABLE_ID],
>  				init_data_hdr->ip_discovery_size_in_kb);
> @@ -1189,14 +1190,6 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
>  			init_data_hdr->bad_page_size_in_kb;
>  	}
>  
> -	/* Validation for critical region info */
> -	if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb > DISCOVERY_TMR_SIZE) {
> -		dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n",
> -				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb);
> -		r = -EINVAL;
> -		goto out;
> -	}
> -
>  	/* reserved memory starts from crit region base offset with the size of 5MB */
>  	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
>  				  adev->virt.crit_regn.offset,
