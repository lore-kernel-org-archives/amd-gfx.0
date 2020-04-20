Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B25C3815B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2594C206F6
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 15:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="18Fe11BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2594C206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFC146E5D1;
	Mon, 20 Apr 2020 15:37:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9563C6E5D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2020 15:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEJfA73vcyejbCk1oKnd1Cr4Enmt7WkyTZN04Klj1A1MsJmraw4S8zVcdAJZG032GIftXicUvF3+l3zbrLUL2IJ/aRSn9tz7u7pQQeuYqQGvjphCEBrQ7cU9NOMarjPjMMqjAdkCNBiuZ1JwvK+rC4m6y93+COhAAk9p02yU1KSNsW20yqEs4TjmCWwCmGWZGgewxKo4z0hQYUxoYqIoUS46bDlMra3QQLIIdn3O6vUCIKB6+WEz3P/D+Xb2DLmBkjOHCYyn7O1TDKiIf0yPUQZjvYsdzL+b5zCY7PhqMUwYHyJo//PYx+KxV/XDSSdEbSbKUJuy7O/pk6mBjrkUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lRA5dqa1syVjIkpfriBjO4N18seD8jozQeqcXEdCqE=;
 b=oK+irzqvIRnTNKbp6BXURl++in9k+1Ls9jINlqaW9FiagpjJb3+8JcGMo0yH31MkOoHrkRAZdjilramIXYVsFZfcczCQgLg3rBM46sWTdSgv4Sn4c3vAWaCR2TfvZvdKIBPjWfQOVeU8zxhQawnUyKLiPip2KyxDeep5Bkoqnaa7oUq9aa9945+ZYxDaiaCqqlu0YK7EA0pM7dPwsmRr/REV8tWXqkTPx41UqSW7gchuJKM5CsYxhDkn+xVO8JdE1FDKIWE1itXYDdlb7GSwbZl8CME6zmuIgUeV0hmSJ02wlo+Rq3sq6OKvc8tGBRbf6pTivMQCpeTKlFB64VbuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lRA5dqa1syVjIkpfriBjO4N18seD8jozQeqcXEdCqE=;
 b=18Fe11BT6mObOTePvxuBF4QWwdIQbKCG7+0oGpVc5TZz1dKgruG9CBa1YKvd8S3ofiqq3Xcm5q0m8At/ppll+d4z1WabINhjK7jm5wH0hZHSpq9XpjrITSd3lBKrV6Dziwac1ZlOWkEqrrdzHR7QSpQg/FO9cqXuw5ssrvQqINc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (2603:10b6:5:115::26)
 by DM6PR12MB3148.namprd12.prod.outlook.com (2603:10b6:5:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:37:52 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::cd6e:7536:4dbb:aa85%5]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:37:52 +0000
Subject: Re: [PATCH 6/8] drm/amdgpu: add helper function to init sos ucode
To: Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 John Clements <john.clements@amd.com>, Guchun Chen <Guchun.Chen@amd.com>
References: <1587377804-3836-1-git-send-email-Hawking.Zhang@amd.com>
 <1587377804-3836-7-git-send-email-Hawking.Zhang@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <afd24947-2665-776f-601b-856957c0cd40@amd.com>
Date: Mon, 20 Apr 2020 11:37:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <1587377804-3836-7-git-send-email-Hawking.Zhang@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: BN6PR04CA0066.namprd04.prod.outlook.com
 (2603:10b6:404:8d::16) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR04CA0066.namprd04.prod.outlook.com (2603:10b6:404:8d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.26 via Frontend Transport; Mon, 20 Apr 2020 15:37:51 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f55d244-f3bf-48fd-fabd-08d7e540c9cf
X-MS-TrafficTypeDiagnostic: DM6PR12MB3148:|DM6PR12MB3148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3148E5344D6EF1AB2C393BA299D40@DM6PR12MB3148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3355.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(5660300002)(316002)(2616005)(31686004)(186003)(44832011)(16526019)(956004)(110136005)(2906002)(8676002)(6486002)(26005)(81156014)(478600001)(6636002)(36756003)(6512007)(52116002)(53546011)(6506007)(86362001)(66556008)(66476007)(66946007)(8936002)(31696002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Za1rm5M6IOmfAdYuqIjhBlyCoCk9luyJr68oAX4UZTyEdzNvBr8JxZk3teNWvIbD8Wz4D4HWGNs9s4AKvoVVnkoyJsfhhZHoDcF/G5/EmyukdLRcQRFbcK40apBEOrUP+guLezsyKf+3qTlww8LIZ3/kZkOPmGwjbUxogLKvIvuLatz4luhh/FO9EQVY95DCG/rREWOMnTkIROq29jL9I/AdyJckEdfaD/DelF+yu6G4hJK7cibsj392n2cNXF7E4cp10u0As0ZNZXdMtUfFG7tJDDDdLlgKSvF96uYqPMge5KTElazUGepC3ShDQSDDG2coJbpCMde0MmE5R4JXTpUWa8Vvpu8u6brocF6RYzMgra1BK4TwKaAIx8boUuO2xxpm5Je7aSZcyMUiPFIU/nvhPia5B2d+KotKwy6HxmvmdwSNMsbiLiiClx1HG7Uw
X-MS-Exchange-AntiSpam-MessageData: AiTL+9G2m6MyHsg8gw0JTDrr7qz3iFBpzYdgIjKvFlajgrUfV3hyrRj1in1Y/UOpCKAgFQBrHFRShrEZa0MGY/ktLlqHeE7MMjVgq97Z3vVArjI7xg1U3GaGN6l1sSaCRMT1WtROeXrZgnf0vARx8lG/aW6WwoanY73Ef+Bn85Bik2LRp6bOyEavrLBkkbFWoEInd++aCyc6xQ/nrfrgokJna86u1oBhAMWP8ee03c2HU0qr6qcQPxr5hf/cbAvQtBbmjpNBs4YzpH3TbgqyzFZDVJP135BeFUItX76henq8V7L7hRVIsQHI0lygNuO/xN5/LXHe+lxZ4Eti1akxEox4v5ZFV+3M97dpAnS2YSYNeC9NyA8wZYUVgdHUun2nsXX62HT1VKtm7DwtRbJHdaXk0Bj84Dnj9IE/Ep/JLBUeDP7Bjmhe8PdYZACbqEsfkhLkncuK3WvNh9T73/2X12zlAG3fb3406+HOukSw1GOEjG5Z1UqdBfoZLcvEZz6slYRdy9ndCauEFIVAEgYyonwKz/KOcSLhrd3wY+pCNpxkXaDiLf4ChzA2FhidallPpthFLhWUWxO1yQHLM9YuWYg2D1c+3k75FejoBQtvq93kR8ZaoLG+/NbeYmkIf/B+p+x5aIa3MSxoKY28cWkcXRdJipF5xYBSMz4qBOjl3H9siV7XdalTPcQ2yJ5GquEOvUegl0RUWnxz5vD3aAcWcWyDEbNG9nzjBa5584fI6KUSL3RLmozB0QFh8hAVKjIj0ovz7rK3mN5rhkDOOqszLr4mmsb8bEOXsvckyP7XZDA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f55d244-f3bf-48fd-fabd-08d7e540c9cf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:37:52.4111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjtb73CgYH95RPLGh4Vo0HJ0EDUp6Wqmaw8U8402hWT3/FlaPUsehD2Vvqd0uWS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3148
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-04-20 6:16 a.m., Hawking Zhang wrote:
> driver already had psp_firmware_header struture to
> deal with different layout of sos ucode. the sos
> micorcode initialization could be common one.
> 
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 70 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 +
>  2 files changed, 72 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3656068..730f98a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1876,6 +1876,76 @@ int psp_init_asd_microcode(struct psp_context *psp,
>  	return err;
>  }
>  
> +int psp_init_sos_microcode(struct psp_context *psp,
> +			   const char *chip_name)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	char fw_name[30];
> +	const struct psp_firmware_header_v1_0 *sos_hdr;
> +	const struct psp_firmware_header_v1_1 *sos_hdr_v1_1;
> +	const struct psp_firmware_header_v1_2 *sos_hdr_v1_2;
> +	int err = 0;
> +
> +	if (!chip_name) {
> +		dev_err(adev->dev, "invalid chip name for sos microcode\n");
> +		return -EINVAL;
> +	}
> +
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", chip_name);
> +	err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
> +	if (err)
> +		goto out;
> +
> +	err = amdgpu_ucode_validate(adev->psp.sos_fw);
> +	if (err)
> +		goto out;
> +
> +	sos_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.sos_fw->data;
> +	amdgpu_ucode_print_psp_hdr(&sos_hdr->header);
> +
> +	switch (sos_hdr->header.header_version_major) {
> +	case 1:
> +		adev->psp.sos_fw_version = le32_to_cpu(sos_hdr->header.ucode_version);
> +		adev->psp.sos_feature_version = le32_to_cpu(sos_hdr->ucode_feature_version);
> +		adev->psp.sos_bin_size = le32_to_cpu(sos_hdr->sos_size_bytes);
> +		adev->psp.sys_bin_size = le32_to_cpu(sos_hdr->sos_offset_bytes);
> +		adev->psp.sys_start_addr = (uint8_t *)sos_hdr +
> +				le32_to_cpu(sos_hdr->header.ucode_array_offset_bytes);
> +		adev->psp.sos_start_addr = (uint8_t *)adev->psp.sys_start_addr +
> +				le32_to_cpu(sos_hdr->sos_offset_bytes);
> +		if (sos_hdr->header.header_version_minor == 1) {
> +			sos_hdr_v1_1 = (const struct psp_firmware_header_v1_1 *)adev->psp.sos_fw->data;
> +			adev->psp.toc_bin_size = le32_to_cpu(sos_hdr_v1_1->toc_size_bytes);
> +			adev->psp.toc_start_addr = (uint8_t *)adev->psp.sys_start_addr +
> +					le32_to_cpu(sos_hdr_v1_1->toc_offset_bytes);
> +			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_1->kdb_size_bytes);
> +			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
> +					le32_to_cpu(sos_hdr_v1_1->kdb_offset_bytes);
> +		}
> +		if (sos_hdr->header.header_version_minor == 2) {
> +			sos_hdr_v1_2 = (const struct psp_firmware_header_v1_2 *)adev->psp.sos_fw->data;
> +			adev->psp.kdb_bin_size = le32_to_cpu(sos_hdr_v1_2->kdb_size_bytes);
> +			adev->psp.kdb_start_addr = (uint8_t *)adev->psp.sys_start_addr +
> +						    le32_to_cpu(sos_hdr_v1_2->kdb_offset_bytes);
> +		}
> +		break;
> +	default:
> +		dev_err(adev->dev,
> +			"unsupported psp sos firmware\n");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	return 0;
> +out:
> +	dev_err(adev->dev,
> +		"failed to init sos firmware\n");

The message is vague. Print the name of the firmware which
the driver wasn't able to load, don't use "failed to init"
as it doesn't give specific information, use this instead:

	dev_err(adev->dev, "Failed to load firmware \"%s\"\n", fw_name);

Like the rest of the driver does.

Regards,
Luben

> +	release_firmware(adev->psp.sos_fw);
> +	adev->psp.sos_fw = NULL;
> +
> +	return err;
> +}
> +
>  static int psp_set_clockgating_state(void *handle,
>  				     enum amd_clockgating_state state)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index a763148..7fcd63d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -387,4 +387,6 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  			int index);
>  int psp_init_asd_microcode(struct psp_context *psp,
>  			   const char *chip_name);
> +int psp_init_sos_microcode(struct psp_context *psp,
> +			   const char *chip_name);
>  #endif
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
