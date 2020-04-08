Return-Path: <SRS0=b+Zp=5Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0E2C2D0EA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6995F20747
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2020 13:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0Mku+AUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6995F20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3236EA63;
	Wed,  8 Apr 2020 13:34:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4696EA62
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2020 13:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUjw/L81489y5ePF3jHWvZ9sd/Lcp1RM3dDqoZclDE68YG3AoU46xiIGibbBjKJlx4jqR2iz4EvnN+y0V8Tfo8CRm33Sfo9V435Z019Z5LIZvu8NJVQ37sVELoAOWNVUOAwJx3LP1m1mm75fJOLMPaQR8kKky5GrxxsNUeSiGi4HfsR2cysGh62JQi7nNRNEqIVHrqGx32rzoZBp7rWtqLXqJ7XLiKerwR45fCxbOCoeAmr+vV41tH9EH759y+/afU+QwNHHZYzadlh0dWR2pI7zWYOQXQZz2rdSPIo45URZFqZLWuszPRXVa01z1eLd2Zkprk1Gpm0wG0OzbFH7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfNV/4wsYixJVyTnHX0eG+wIS3rzUovshOuguCVCHXQ=;
 b=jrktSpb3jrjzXuDgvxITRTZu53WJ+7QYaM4Ivv5aSsrV7h0qCjbCDkK0zghU5qeo8bRvjGvgdk2ywCvVtTsu/qF+92u+BtspHX82vN0a3huUOKtCYOOMqOk1A++7Ne23DlZqN0aIXzmckyJB7M8d5mTClmkl7KOvx3lUDIgYzOgOxLl7swBeu10lM7uks2zADxlBOVVXYQ+W7nE8lb7DoAyiX4SWvjxC7mvyY0ygMEgTE8BxYG01DCyoql3DHoWAs6SIAUiDJ5xDk0x+rl6KL1ga7JeyREMtyR4FtMaDRHrKRWyQVx3jyumQ4AMGddo0yIghpfjaoz1WQh9lBU69PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfNV/4wsYixJVyTnHX0eG+wIS3rzUovshOuguCVCHXQ=;
 b=0Mku+AUNhJti1w5Vc0NXAmEORTakOMd0cqj9BkmCjFbfGF14qQ94oM3fD1FmzM6Ev07Py2yqPWuoa0fVbYGGeHOj/hgEkEjJ6DUcVsa0oXyOawCoqUZKXUCfqaYp/cB3vjdPyynjQwVvYvJ/l2HlM6NuDpTJvVXVWe1mTLUOjdc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by DM6PR12MB4217.namprd12.prod.outlook.com (2603:10b6:5:219::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 13:34:17 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::50e5:52b2:abe2:2404]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::50e5:52b2:abe2:2404%5]) with mapi id 15.20.2900.015; Wed, 8 Apr 2020
 13:34:17 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix warning when compiling without
 debugfs
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200408133105.1743707-1-alexander.deucher@amd.com>
From: Mikita Lipski <mlipski@amd.com>
Message-ID: <f5c8b5c9-5ab6-6f2e-a4d2-d73793685a08@amd.com>
Date: Wed, 8 Apr 2020 09:34:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200408133105.1743707-1-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:56a0:7ef:cddd:8407:6e7b:9ddf]
 (2607:fea8:56a0:7ef:cddd:8407:6e7b:9ddf) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 13:34:16 +0000
X-Originating-IP: [2607:fea8:56a0:7ef:cddd:8407:6e7b:9ddf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 794dd9b2-b84a-408f-5842-08d7dbc188db
X-MS-TrafficTypeDiagnostic: DM6PR12MB4217:|DM6PR12MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4217BE3BEAEFD5ED14F62B73E4C00@DM6PR12MB4217.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2906.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(31696002)(478600001)(316002)(36756003)(2906002)(4744005)(2616005)(81156014)(186003)(16526019)(52116002)(6486002)(53546011)(8936002)(8676002)(66556008)(66476007)(66946007)(81166007)(31686004)(5660300002)(4326008);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LNpUPkPSzdSXOryUOQxElpY8DPXQzDsYQvJr0Q1b5yYC/wQXVPk23hoDGyrQC8v3YWCAknGyDA+Jm6/l3fkKbG6iVB34Wqz7n4wyHU8MGv0UrRhhY+sssd+d/0TaxT4rJ+B4ZuyWbMbBEVIkok3pm2bGkAOC3csRmBoAAEpBc6snV8CSgNIjEEb9YYFLwKVLK6z1PtYW7Hvd1RzgloqNtdu4TtYrUFLE/L2EhSEkXhuxOZG9xwJA6j3GWFw/Hhv4MCuhGjmNvOQgnmNDRvJyIov1mg5bkQ5sCqxXXaNpyF78YucXqcEHGd2HnongNrnCSkfC08LvdvREhuFelFFUdEd7YocqXxeiKW2LU9Zppc7cVrWyWPeXJKzlfP8KAwxHHfTWLYgWnU3Vn+pEaDSJaZ2RaWG0CKoDVkS7rpvmrXvQhPW2suzrmVvZW5bttp4
X-MS-Exchange-AntiSpam-MessageData: gTvIRtgySuhEdFvZAVGwipW9g6fH5/Fw1H+d98uGl/i/CMWFqcbKGCZ6Syvg9jlP2JkHS90vpOguf3SnAru6W0eNVjvpl91JG0qpttypAB36ICRbv8zfxw5Eca9fPoY97d6fVh5+Yx4SyKSQecUDZmwQh3F6iDXS0bVMVUg5N2sdhwWqa5TIIh2nIdOHg0M+obskh2+S3Z6uXF834OMRUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794dd9b2-b84a-408f-5842-08d7dbc188db
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 13:34:17.0820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Npui6tgKCdpNf/g5tTwMruvK7T/aav5E5Io5Vh2MqnHFDDNVYtnCG/fvfFPSkoTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4217
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>

Thanks,
Mikita

On 2020-04-08 9:31 a.m., Alex Deucher wrote:
> fixes unused variable warning.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1155fb686e36..417925a0d739 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4738,10 +4738,10 @@ amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
>   static int
>   amdgpu_dm_connector_late_register(struct drm_connector *connector)
>   {
> +#if defined(CONFIG_DEBUG_FS)
>   	struct amdgpu_dm_connector *amdgpu_dm_connector =
>   		to_amdgpu_dm_connector(connector);
>   
> -#if defined(CONFIG_DEBUG_FS)
>   	connector_debugfs_init(amdgpu_dm_connector);
>   #endif
>   
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
