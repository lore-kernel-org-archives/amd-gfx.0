Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ADFC11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098472468F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 20:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dgrVqgs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098472468F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C94E16E0D1;
	Thu, 27 Feb 2020 20:30:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567216E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 20:30:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXldv85OfXoPdu7nrkh+4LDm19A2xzCgUthAmk7DylbVTsm6ndOkOLLmvKM0eQd49u41G1amqh9BRsPvSgDYV+jACxZh8kQOTeRBaC+yAb1oMQxK2VYGJ/MEhTk07tplHARnDam0MeYhIJr9OpnudP+d9a1OaU8Afv1ndC6b+cEvhX95yNxcEUhtLcSRUgQscHTp3ekGgPtMTdTBQQSkI7U4sjSTD2gPp8+fZajnmXxNJjf/kzALPyAW3siDipSNUS1ny3lXlvT6KSkTzbk+Wo5DFRggQPNn6p6oyYMsWg5jC7U357jBT2Ad2MInnLUfV583Csd6/hd/0eig+rwhtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBuUvfj3DcXoo2mnvwBG4hhboDBfTl6vfOtnXjYxe+4=;
 b=Byl2QQiQ5c6luCm+Pxb6a0PX3YDKR0c7ha910Wg/bpZ2MD94p6cBpdmGW2yNyXtqmB3VT6lvYEYU2y7HRUWr/hXMCek+Eufy2meiqUZnywjou+bJEW1wKjWLhrWPM3C5WVNMOMHxvFZU8FsM+y318NvRSXxyEAQ/ODZpB1B8KX6Qz75MTFg8h4solJGcSDfCXNGXP5mhoek4vWT5YRr4y4V/XKpxsHO6fwhcDu3sR+xcm4SQHWzTa3Slfvdd4XLlQYEL0pcYxqRMsglKsF88rM+aFy6SmXifWq7NJWnQXzR92njYIGVeSPeQxehOjSHFE1NyampKSypg9CRXAK15fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBuUvfj3DcXoo2mnvwBG4hhboDBfTl6vfOtnXjYxe+4=;
 b=dgrVqgs0qt4Rb+DwoYrhhcGSvqEsYz3Py7P0frVrfhs3q/kF6aYdCXox4uFtbEplJyo+GSdG9aZzS9LNSZ8uFXgCdNgbUjyPzTJbXOim7lO3kcj+BXUghEHhbz9D2rpkdwG5E7IqjHNXCOpkOwzyJpYpcnC30ESf3wlbsxe1Fws=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5SPR01MB0358.namprd12.prod.outlook.com (2603:10b6:4:e9::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Thu, 27 Feb 2020 20:30:10 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 20:30:10 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx: fix indentation in new rlc spm code
To: amd-gfx@lists.freedesktop.org
References: <20200227201450.185953-1-alexander.deucher@amd.com>
 <20200227201450.185953-2-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f6bbeab4-23a4-487f-339d-d7af49bec232@amd.com>
Date: Thu, 27 Feb 2020 21:33:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200227201450.185953-2-alexander.deucher@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0029.eurprd07.prod.outlook.com
 (2603:10a6:200:42::39) To DM5PR12MB2376.namprd12.prod.outlook.com
 (2603:10b6:4:b9::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
 (2003:c5:8f2a:b800:8c:b0f3:cb6e:896b) by
 AM4PR0701CA0029.eurprd07.prod.outlook.com (2603:10a6:200:42::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend
 Transport; Thu, 27 Feb 2020 20:30:09 +0000
X-Originating-IP: [2003:c5:8f2a:b800:8c:b0f3:cb6e:896b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4010c69c-5f3e-4056-c465-08d7bbc3d76d
X-MS-TrafficTypeDiagnostic: DM5SPR01MB0358:
X-Microsoft-Antispam-PRVS: <DM5SPR01MB03581C8F09EF5DE32B8A28638BEB0@DM5SPR01MB0358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(39850400004)(376002)(366004)(346002)(189003)(199004)(66946007)(6486002)(36756003)(52116002)(2906002)(6666004)(66556008)(8936002)(8676002)(478600001)(81156014)(16526019)(66476007)(186003)(2616005)(31696002)(53546011)(31686004)(5660300002)(6916009)(316002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5SPR01MB0358;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBUbrWOyXWTA57GJc17lnLedGHJ0flu520S3Tr7lL03q21mShr8W7/wB9G+2QfaGVFMluUG+BWKhjLqMCjE3ST+H/XRLk8WDdb5ZfJJmXF0Xf3NtMiH/q1KYHZRSHsjgqPW4FL0ZwqH5e1tlNco2i0bwak7g52QVtMjMoawhR9L/3iylPVBDcayBzuNLYT5f95WSOK7RxMZBiB6p3BkpNOGhTxJ9rLbcugPGglS8EeRfG90kG3f/KU/X5DGRdA6zrlaqz9vn6isz6FHGQDMHYCy8QGUpX2P7ovg1j4cQvYGtt2Bdjj5t16F5mEKnQRa7Gp5bDNHX+fOU4BXaQ/nIUxOqohOzQnpPOG0ls8coFpqMC6WpwCPCy1BdQx/wKvw23jz6q5f4nOGtKg+pk+Erz4SzwROZ2UWi4Wa9sy4qbKwdzGTViv1f8JG0Xv67Z4+J
X-MS-Exchange-AntiSpam-MessageData: MMwnJWtDn71jDAPF0NEp3N8f5gDKeNhPV0D7HuGXd4eFQ/E2MNrdkXW6GSnDIqjSN4c0j2yoeThe2YbuQT0GLmWzTZTw/kCgJMD+LleuuCLEvVxUJArNarUXhDP5excxGH25TVJ2W8ZqfvKoLUnb8HeMl5ffO6B0w2Mcd/5waVx8gCs9KL0kh0uaw6pyRLxq2LsZANAGiXLjRpSEvttHVw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4010c69c-5f3e-4056-c465-08d7bbc3d76d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 20:30:10.5195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYED4OjAtYPWQRoLGJIqi8/WPUyZqeuwu4BT64gF7crYN8CrGOAlrUiLjNyldULTTTf71bb7xlz7K8LauKuyLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR01MB0358
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

series Reviewed-by:Nirmoy Das <nirmoy.das@amd.com>

On 2/27/20 9:14 PM, Alex Deucher wrote:
> fixes warnings with -Wmisleading-indentation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 6 +++---
>   4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index cb3421e25adc..0dc3ed694fe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -1016,9 +1016,9 @@ static int gfx_v10_0_rlc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -    /* init spm vmid with 0xf */
> -    if (adev->gfx.rlc.funcs->update_spm_vmid)
> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> +	/* init spm vmid with 0xf */
> +	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 397c62c58436..733d398c61cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -3346,9 +3346,9 @@ static int gfx_v7_0_rlc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -    /* init spm vmid with 0xf */
> -    if (adev->gfx.rlc.funcs->update_spm_vmid)
> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> +	/* init spm vmid with 0xf */
> +	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index 294abff9efb7..393a1324daa9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1318,9 +1318,9 @@ static int gfx_v8_0_rlc_init(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -    /* init spm vmid with 0xf */
> -    if (adev->gfx.rlc.funcs->update_spm_vmid)
> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> +	/* init spm vmid with 0xf */
> +	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 1d5fd5f17a30..9962ef80da92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1847,9 +1847,9 @@ static int gfx_v9_0_rlc_init(struct amdgpu_device *adev)
>   		break;
>   	}
>   
> -    /* init spm vmid with 0xf */
> -    if (adev->gfx.rlc.funcs->update_spm_vmid)
> -        adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
> +	/* init spm vmid with 0xf */
> +	if (adev->gfx.rlc.funcs->update_spm_vmid)
> +		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
>   
>   	return 0;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
