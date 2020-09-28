Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00963C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 22:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFA823A01
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 22:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2gYwhl/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFA823A01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D7D6E15C;
	Mon, 28 Sep 2020 22:26:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96EF6E15C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 22:26:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSDpI40LU3dFsjyZcH8j580VO4Kp2ENhm4oNM6qahVzEm1ZWUIIWWMAXo7TKkbR0gSHbmw6KjYd5z6AcGRFozxZZ7xWnN/su07fmdDjIMwGMmKvCuAJlTsh/qYM0JLqnfF+zgw0/+iAWWL//2e+AN/hXA7rK23+3c6gf6apt1M3K/64BNBkz0ScqrXJPcOPNG0ojcE1dgirDknfU04D/p1Au3XFZLSjS40zcbBx+LOazE67yHCF07IUGLmwkXHJUgak3JT+qmRTJ1j4Vqx2f3dda20xyisWcfSz1NRHjPj86l5HYnRutcZhroh1v/zfCdqYxYlieZ/NuTkDuDElzGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBpH4EUI1pAtAiPVjUKM91aTIADBql8KdqTDW0VGF1c=;
 b=Qr1ZwDTZthCIIMgC5nXCjo168XEOgMyznh9yAOlD4X1SSGEUhwenyTOjx/FjfBYCDudHxIZzCaMpk+BEdzmYOP0ObpMpyCjGw4NN0HwjTboqv8xalQVSz34jdAujxhbVIuJxuFcJRVVqeDDs6qMnOMfX5+ew2yFobgkQl8FCxVVdQ6RaE6kbDeic7wJeuKTkTQ08ejh4sUfga2/y2Vm28DPLej8qNb/GT7JfgNN3B2NAlqA4iqBMQ4bim1AZ2PFpZVQ33BYtHp3DVVD7muOoeAOLxiTQD86EgDzJTbJiMRb4Qi3tMd2RZYG0ND1qbwsaNTgE1fD0vVHUj/18aKsqRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBpH4EUI1pAtAiPVjUKM91aTIADBql8KdqTDW0VGF1c=;
 b=2gYwhl/7En9Wbu2XBlmHZSGfJZMHgeFVManGF7MwFnWPofCS/F4BcdvQghfXowGX+8yTWVnYRgFB4cMFkNN7LgnZQaHLf96Lzm79bJUHhf5DqG7AGn9cQy868iD3bn9GhkmgqOJFbsYIjFn9GJeBs6CI6Imen+wSXK0jLFcaoFY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 22:26:24 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::c8c1:1bc7:cad0:3933%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 22:26:24 +0000
Subject: Re: [PATCH 36/45] drm/amdgpu: add TOC firmware support for apu (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-36-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <535ea0cc-67e5-a81f-47d5-87b51ee47a82@amd.com>
Date: Mon, 28 Sep 2020 18:26:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <20200925201029.1738724-36-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42)
 To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.22 via Frontend Transport; Mon, 28 Sep 2020 22:26:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6dc31d37-1449-42ac-86a0-08d863fd88bf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41533486DA36802DA76ABC6B99350@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KzlBv7nyHaliOSmeyAynRdga2UtEbZHIzfT08ifj7IIrpqTJazAb9WC3aeCKO8/VNTGzduZGv6oLSqX//lVS5rkFVrwgurL0UdmT0dkV2UptAE1nraEH/aGJIp1zfJUYk2mADx/Kl+y62WUHp9ImytbC/eaW9aVP4nRmcrUCeTkhdGo06Zk7gVtEO0j/38G7rzDSClTNms6UOh5l31YTtP/fr9wTD9qLimLumiewu+uGwTh/cD/bphRVGU5nUEeNgQm2Rm5zlQ+Z4n/fdZbuLEEWBfjF0YSkV0tOX1wo1WGOyvLJk/OlQQ5mkn5fIYPfn0Tkx9Hrr2Zoug74AyK7PSrhJV0hJRLqNdEwZ8t7xmLROOoKwEAFO+D1d1jE5ZdjdMTXjV9bn+V7nVv9KWfmnIKQbsSQ4LLJ8+IvMlwIaBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(186003)(26005)(86362001)(16526019)(31686004)(31696002)(956004)(2616005)(66946007)(36756003)(2906002)(6512007)(8936002)(44832011)(478600001)(8676002)(6486002)(53546011)(52116002)(6506007)(316002)(54906003)(4326008)(66476007)(66556008)(83380400001)(5660300002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8ST0CSb2e0TwO7TBDVul+bnfugBSPvjH26Vz9aT1JtTVmz4uOj083hh0/PXuFFNIFsIrHxoKXwzot1S5BSEll+uUNyxjjEv8kfF5PUE9jVLSwfAodq2An64SJJRtdnSGCjLjBY6Db7SArvTXyk28TkMwwlfG8tvVyYEmcvoMn+WTnLbTgvYjq074D7JJtVqSkYlwixpSSF98UOc3jqgvvcOlTqjFMVUT+giVz4JgG+pAx/Lwzj6NrGqqCHnLcWabcfFrOGyMTFXlQisiBA0tXEVUpeONWiRzvjnIO/HHNXDD4OsVoRnhmxvswNim+rx10zW00BAm6/TtzP1gVxRooEUT5/ZSKTswOJ1gK1X3H7FAAbCpEzZOA+00O8YzJOEmtK/t+q+0D17txV0CSWWKDYCMhrdU78xj4CjJcGuIX5GlsaR/RUJtVfeOkbWKiepyE7rpcOHmd6gaa12dPj0danDBhwBtJ0MGcjg3YU0Bkk/O6rKTmiU2Zf4QURnjPngyStBLlTyNmoq3JV26b9M4WvZhoeRrybs7g5f+ccUF16METSyWEM9MGYGQK6FnbcCCsXW1xDzbF4wCBDQAAE7/K6pyWoYPjHwiGoEQNMTEKeM+nLICqH0BJs9d6lw31hSMtYSi8tJm9ocoJlF1dzwYYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc31d37-1449-42ac-86a0-08d863fd88bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 22:26:24.7332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgXUW9fCL/6kQFh7cYE98ApMxn97L2cSnx/Izo8lSylRHXJN57tLpLGXbU9JqnzX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-25 4:10 p.m., Alex Deucher wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> APU needs load toc firmware for gfx10 series on psp front door loading.
> 
> v2: rebase against latest code
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  7 +++++
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 33 ++++++++++++++++-------
>  4 files changed, 77 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index bd0d14419841..26caa8d43483 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -325,6 +325,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
>  		fw_info->ver = adev->dm.dmcub_fw_version;
>  		fw_info->feature = 0;
>  		break;
> +	case AMDGPU_INFO_FW_TOC:
> +		fw_info->ver = adev->psp.toc_fw_version;
> +		fw_info->feature = adev->psp.toc_feature_version;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1464,6 +1468,13 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
>  	seq_printf(m, "DMCUB feature version: %u, firmware version: 0x%08x\n",
>  		   fw_info.feature, fw_info.ver);
>  
> +	/* TOC */
> +	query_fw.fw_type = AMDGPU_INFO_FW_TOC;
> +	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
> +	if (ret)
> +		return ret;
> +	seq_printf(m, "TOC feature version: %u, firmware version: 0x%08x\n",
> +		   fw_info.feature, fw_info.ver);
>  
>  	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 18be544d8c1e..c8cec7ab499d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2415,6 +2415,42 @@ int psp_init_asd_microcode(struct psp_context *psp,
>  	return err;
>  }
>  
> +int psp_init_toc_microcode(struct psp_context *psp,
> +			   const char *chip_name)
> +{
> +	struct amdgpu_device *adev = psp->adev;
> +	char fw_name[30];
> +	const struct psp_firmware_header_v1_0 *toc_hdr;
> +	int err = 0;
> +
> +	if (!chip_name) {
> +		dev_err(adev->dev, "invalid chip name for toc microcode\n");
> +		return -EINVAL;
> +	}
> +
> +	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", chip_name);
> +	err = request_firmware(&adev->psp.toc_fw, fw_name, adev->dev);
> +	if (err)
> +		goto out;
> +
> +	err = amdgpu_ucode_validate(adev->psp.toc_fw);
> +	if (err)
> +		goto out;
> +
> +	toc_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.toc_fw->data;
> +	adev->psp.toc_fw_version = le32_to_cpu(toc_hdr->header.ucode_version);
> +	adev->psp.toc_feature_version = le32_to_cpu(toc_hdr->ucode_feature_version);
> +	adev->psp.toc_bin_size = le32_to_cpu(toc_hdr->header.ucode_size_bytes);
> +	adev->psp.toc_start_addr = (uint8_t *)toc_hdr +
> +				le32_to_cpu(toc_hdr->header.ucode_array_offset_bytes);
> +	return 0;
> +out:

I'd rather this label be "Err:".

Regardless of whether there already is a variable "err",
(there is!), capitalizing goto labels is good practice, since
it distinguishes them from variables (which are all lowercase),
and macros (which are all caps). Plus, you also avoid conflict
with the eponymous variable.

> +	dev_err(adev->dev, "fail to initialize toc microcode\n");

That's a very misleading message. Please print this instead:

	dev_err(adev->dev,
		"Failed to load/validate firmware for %s\n",
		fw_name);

To make it clear what was being loaded and validated and failed.
		
Regards,
Luben

> +	release_firmware(adev->psp.toc_fw);
> +	adev->psp.toc_fw = NULL;
> +	return err;
> +}
> +
>  int psp_init_sos_microcode(struct psp_context *psp,
>  			   const char *chip_name)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 919d2fb7427b..13f56618660a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -253,6 +253,11 @@ struct psp_context
>  	uint32_t			asd_ucode_size;
>  	uint8_t				*asd_start_addr;
>  
> +	/* toc firmware */
> +	const struct firmware		*toc_fw;
> +	uint32_t			toc_fw_version;
> +	uint32_t			toc_feature_version;
> +
>  	/* fence buffer */
>  	struct amdgpu_bo		*fence_buf_bo;
>  	uint64_t			fence_buf_mc_addr;
> @@ -386,6 +391,8 @@ int psp_ring_cmd_submit(struct psp_context *psp,
>  			int index);
>  int psp_init_asd_microcode(struct psp_context *psp,
>  			   const char *chip_name);
> +int psp_init_toc_microcode(struct psp_context *psp,
> +			   const char *chip_name);
>  int psp_init_sos_microcode(struct psp_context *psp,
>  			   const char *chip_name);
>  int psp_init_ta_microcode(struct psp_context *psp,
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 6c5d9612abcb..f2d6b2518eee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -109,20 +109,16 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>  		BUG();
>  	}
>  
> -	err = psp_init_sos_microcode(psp, chip_name);
> -	if (err)
> -		return err;
> -
> -	if (adev->asic_type != CHIP_SIENNA_CICHLID &&
> -	    adev->asic_type != CHIP_NAVY_FLOUNDER) {
> -		err = psp_init_asd_microcode(psp, chip_name);
> -		if (err)
> -			return err;
> -	}
>  
>  	switch (adev->asic_type) {
>  	case CHIP_VEGA20:
>  	case CHIP_ARCTURUS:
> +		err = psp_init_sos_microcode(psp, chip_name);
> +		if (err)
> +			return err;
> +		err = psp_init_asd_microcode(psp, chip_name);
> +		if (err)
> +			return err;
>  		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
>  		err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
>  		if (err) {
> @@ -150,6 +146,12 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>  	case CHIP_NAVI10:
>  	case CHIP_NAVI14:
>  	case CHIP_NAVI12:
> +		err = psp_init_sos_microcode(psp, chip_name);
> +		if (err)
> +			return err;
> +		err = psp_init_asd_microcode(psp, chip_name);
> +		if (err)
> +			return err;
>  		if (amdgpu_sriov_vf(adev))
>  			break;
>  		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
> @@ -180,10 +182,21 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>  		break;
>  	case CHIP_SIENNA_CICHLID:
>  	case CHIP_NAVY_FLOUNDER:
> +		err = psp_init_sos_microcode(psp, chip_name);
> +		if (err)
> +			return err;
>  		err = psp_init_ta_microcode(&adev->psp, chip_name);
>  		if (err)
>  			return err;
>  		break;
> +	case CHIP_VANGOGH:
> +		err = psp_init_asd_microcode(psp, chip_name);
> +		if (err)
> +			return err;
> +		err = psp_init_toc_microcode(psp, chip_name);
> +		if (err)
> +			return err;
> +		break;
>  	default:
>  		BUG();
>  	}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
