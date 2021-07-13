Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340F0C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F003B611CB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 07:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F003B611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84426E049;
	Tue, 13 Jul 2021 07:15:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9F16E049
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 07:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctk8zJq4SeQ5NX3zkx0iU2cX9membOOBB01lxr99LBnqJVynO6L4qQI/TEv77qweOltgS4ee2xYsRfnxRELqNXnGc8GZZxB8B3u9BeCOHQUqyI3jFYO998YAfEu7vwtzcuYJ9jLqCU2eomCZmRe+kqVQ66Cmp65n/NXGFp9SBNF65fwTtG2u0UR/cLwl9TRYCIhklNySI6QMtvzGOxMn4/Y7aNrfBPmot6O7Qd7gF5aiT0ymJGkB8gHSimZ4MFr+Wrrc+3v3AmBZr6Cjl8NxkIxSIymk7X+Ab3SMxuW+Ao0LBCMjDns5T9u2JCL8xCn3YadknYXGDoQxCS+ahdubwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVTvDelpeaDsYVIcO7osvAAGdD/qTKvim7SctztJvpE=;
 b=iYSiLTGoUjKf7rfP3KaKe+s4aybb4kacNj+O5rJrUd5T+75loGw6k/c3OwOTnPjM3jZ4RcmLjX5yEfTBSsT7+JJvbkay221Xbbg70kE7OqV8U30+Dd6NX0LW2d1wfiZwhPzmTkgXre9zz8uBrpHECYqImNPbfQkyHYgJ5clpPjA+75kjXdfMQOLYv6N5vrBHbcPI3pO0cFsz8Zt8ivpTlar7xCgPxCkiakraSaNvfsIxjA4zPwDqIMNDGbtSWl7CRARInBfnD5aTnGKjDNff7lSMAPBMZoYbsRciuXHtRgEmbjoh9yYjfVi/DzmCnqz+c/oiPhSbUY0+8aBIRW3y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVTvDelpeaDsYVIcO7osvAAGdD/qTKvim7SctztJvpE=;
 b=YVQQIQtN/LMGAJakTLKJIHKwg8+J1P0YnqTexSAD5SqXlERYtaL2Uq7yTDitxneNqMB2VrYH2sBzbVUpgmIwbRuPPHzQVeTSrTqmjyGfWmcKshbt9/zatw15J6QdIfMnywxF7oNYOyjz0s4wbMNIks5bWOcBlDvGs+fNImaKVtQ=
Received: from DM5PR08CA0046.namprd08.prod.outlook.com (2603:10b6:4:60::35) by
 CH2PR12MB3733.namprd12.prod.outlook.com (2603:10b6:610:15::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.23; Tue, 13 Jul 2021 07:15:09 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f3) by DM5PR08CA0046.outlook.office365.com
 (2603:10b6:4:60::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 07:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 07:15:09 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 13 Jul
 2021 02:15:07 -0500
Date: Tue, 13 Jul 2021 15:14:47 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Subject: Re: [PATCH] drm/amd/pm: Add waiting for response of mode-reset
 message for yellow carp
Message-ID: <20210713071447.GC1959772@hr-amd>
References: <20210713070057.554024-1-aaron.liu@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210713070057.554024-1-aaron.liu@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54939940-1100-4a4d-1440-08d945cdf309
X-MS-TrafficTypeDiagnostic: CH2PR12MB3733:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3733AA7748F6D17871819678EC149@CH2PR12MB3733.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RTJ2KSe5V464y8ylBP23MRSlwdbNZCOyb1jkqbi91d4BVb+9folsG2iS7qSlVEK2AedmgKdEW9+mwRUZKuXPkG9Jcg7Q37oYrZ6L6Qeh1sXRMCTolchjDfJHLT4Yx/0cBkwIHv0tKkjSfivZOf79i+iOqiOirur/KtlpBVtjOqGWNpPHszv0XCMbQojKOx5GoJc+vGne6RyyPbcHfsUjMHyvhqeUl7UWrft4QKDQ0sGT9irmk5Q8F6vlkyKFDFXnIM+fEKRdDDxwFKV57cs0QXIXFb3MVrWVIIz3gtb8YsCgK+bLIv7LQ/yAbbHJsrtxkIWqzx0u+cWJvIAzo9ik7uYo3EFRAn39uJ+DwdBzAbGcRpuD0ceFWReLbLAhkRtUBXvLG5NAUh3QJvsdz2is/E0A4yjuKkV9K5pHaAncVsk5KJUpAn5ansL9dDi1eLR0dlrh64dZj+geLeW907GtQDLirvPaWG9PEi+qIW8ClLyu/endcMBts/L7qEZ6liTUkh1Sz7BN49e5WKQykkNdsaAXqt2EUWe5SXGKHro88ha8vNjHl5fwp+UcZ1wT4JVM8DcAtrLst7onh3OcpdfRiVYWwHJgZJw4UmvNlmFFOFlGDV297aNHW/yLe7YTy4mC4Vi8X+VVvxSsUmWuRuVTYcrQpylgMU8J31NpwF7rmQ2bhOqVbRpLuSyitjlTru23SmfVnrMXz3qJc2fEq/8a1+nh6p1B/XxMn4vVSK6eqIqSywXj3qJqfUNbgxlhQ1yRDvFqnSwy+NmuvhOKv3VBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(46966006)(36840700001)(5660300002)(47076005)(33716001)(36860700001)(8936002)(86362001)(1076003)(2906002)(70206006)(478600001)(82310400003)(8676002)(70586007)(16526019)(82740400003)(26005)(186003)(81166007)(356005)(83380400001)(15650500001)(33656002)(6666004)(4326008)(55016002)(6862004)(316002)(54906003)(9686003)(6636002)(426003)(336012)(69900200002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 07:15:09.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54939940-1100-4a4d-1440-08d945cdf309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3733
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

On Tue, Jul 13, 2021 at 03:00:57PM +0800, Liu, Aaron wrote:
> Remove mdelay process and use smu_cmn_send_smc_msg_with_param to send
> mode-reset message to SMC.
> 
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> index de92f713a911..0cfeb9fc7c03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
> @@ -298,13 +298,9 @@ static int yellow_carp_mode_reset(struct smu_context *smu, int type)
>  	if (index < 0)
>  		return index == -EACCES ? 0 : index;
>  
> -	mutex_lock(&smu->message_lock);
> -
> -	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
> -
> -	mutex_unlock(&smu->message_lock);
> -
> -	mdelay(10);
> +	ret = smu_cmn_send_smc_msg_with_param(smu, (uint16_t)index, type, NULL);
> +	if (ret)
> +		dev_err(smu->adev->dev, "Failed to mode reset!\n");
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
