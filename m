Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61C5C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 14:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9128E2070B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 14:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dvE0zsSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9128E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E046E52D;
	Wed, 29 Jul 2020 14:15:13 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750070.outbound.protection.outlook.com [40.107.75.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC666E52D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 14:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIeUvafmJKhkpwPqUzU+HjtUJuFQxlPTBVg0RxKgYHdQOILoTduWw6bgNkr2E95YIZhqIqmQr6LkTsxVtlXgBWFsiFIRX1qBiYPeLu4KM/MNkk4b4iMgUrzq41M/9ws0J3ik8xRJR5/OPI1kRgoZo+7+fAu7Z/dsFU594Ffl8enVO6zRS7a2WZOLwYulrwHVh3tUgZ8YXYjjoJRx+Rz9wnlAj/KfF6wqDeceCrMYzJ++P9Wsthy/TxchCB/vO6fiXi0ttA7AA7JrJNHezpEKeZ5whu7dNGqbYnBx9B6+3cAwTw4JmI2cQuJaFQEfWknLYSAq98djykxvqwBKvt8xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPfUfYxF6Eqv7s0Xi4TIW6IQIdBDQwb5c/xxCumaUBo=;
 b=NpD5sRnv9tnY+dYtA6ob/VNcBUaPv4U44pFIICL/mwm623iu3pwkEDd48eGAAIOQX0d4v5cQJNlaezb9RaA6ZfzCu+Xic5zj9BTrMY7ECWf3AZWBFXoupl8nptwiscjEaKQrMKZ8qgKAiLojsNBjp5K728mnjI/H8FTgCN29W0NblsFrKJ7oKAbNqvp+wTSEUjZLHBpujDT9ZYXMcOyQw3N6+LYf/I6AiGlNUAaIqa9Kn+cgKC0DLchrfPRPcVAiGq9mG/rwVFMcumvtALK6stZkFRs/vs0c0qoZkaK+vIcV9I4VagCtBjo6+o0DGZvRwykZ7VbGJFboI0xCtVRAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPfUfYxF6Eqv7s0Xi4TIW6IQIdBDQwb5c/xxCumaUBo=;
 b=dvE0zsSdv6EIqd8AX55IDFAYRXFvX+04joJ6tUlP0h08xPESltwprsTeQKCaATTj/BypWkxHGPbWdRhGLBBiRdIUJMY9q/6qlR+l+2/+rTyNegNUv4S41UPemrF3QWb8tPGv8D0gqweYF/+bTdeN6toMhe20nopyE0t+MynqprM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB3059.namprd12.prod.outlook.com (2603:10b6:408:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Wed, 29 Jul
 2020 14:15:10 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 14:15:10 +0000
Subject: Re: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200729082359.1133512-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <d559c2bd-cb2c-e75c-aa90-57104fc81caa@amd.com>
Date: Wed, 29 Jul 2020 10:14:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200729082359.1133512-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::24) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.35.64] (165.204.54.211) by
 YTXPR0101CA0047.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend
 Transport; Wed, 29 Jul 2020 14:15:09 +0000
X-Originating-IP: [165.204.54.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ee9ee54-374e-48da-bad7-08d833c9cd68
X-MS-TrafficTypeDiagnostic: BN8PR12MB3059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB30592FA0F9CF0A550DE60B7199700@BN8PR12MB3059.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HnabrzIKAbklAaBJ5c0Ij+h7QmuyBVmpzlKhAnJ3YrVt0RkhUIDNnIKhaTa8gssjNMdN5GNUrHQTKDam3be5cWK+WaMKmF33KzH70U3TaMzV/JApkGqwF0HkCKN6dZF/Pv3Z2I4A8JcD4uZzmhN5fqMeaGMtlYjzvGBMRG0fVshQ9efjl5KzrBhsfGcS0WMICOqo/lHnaIyULEuLeuiCYH5T922bnNgUo7iev0MceJPssmDx+T8apUQLec2itfR4VEvImD5DJeWxawGHMWc02NIGJz+r2lMQuPKWnhlI32Oem/rAJIsRjoJQ1jci9SJCyL+r89WfNc0hHIjhVe4knUtPU4Tf5OT7joulxnjLtTrq/W4VymPWC7qLO3bjwib
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(6486002)(5660300002)(186003)(316002)(956004)(31696002)(2616005)(86362001)(2906002)(83380400001)(53546011)(52116002)(66556008)(44832011)(54906003)(6666004)(478600001)(66946007)(66476007)(26005)(36756003)(16526019)(8936002)(31686004)(16576012)(4326008)(8676002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3odxW3QGK0WNjlAWaq/HXhV9rVLp1WDxkJA4n7zk80xCFJF7Tcv1LsOmD9B0NRGfxUD+xbrpSFUjlF8F74rKq7bSOZbxnXdp2bnGpjhidMCXIE+fNhJ8HDGP16Roqn0alsYbAbB6kjN9iqU3puFmK4E8xp249Su1/BfsxrN5DO6C+aQ0jBMc5Fvm+r7cDwBcttPu0Sd4ipwna0qwGOHdYSoI/r+0L7PEV2ULAdW+sR3zkJAAqmRlwz2id2OqmAy6HwkIJ47s+Fxy0pVIF+RdJdlNBA42EuYaJad9X3TAsj0wtl85RIdOpPyZtUwNKl4YCQVJ3FiDhzdn8ucIKr6fsBbcd/WdNsBVfrRFadkUKIQwIZ+FufLN8yWo4C7/cL98tKa/hczX4HROXN5mGj8MRJiKMtAp7D/00M9vqJn+CgUmJirzt1CY9gkljOFymfM3oM6aPHTnhxXNZ2I4BLrAxXZM1wqNqxvnb3XTsZUyu1WukrzO3tVejb6mNqJ8CQBL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee9ee54-374e-48da-bad7-08d833c9cd68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 14:15:10.4139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvYtOtQoS3phEb0YZ3ktHjLjVGv6+TbLXM9x0awrTSnmjp8MxS5LqAQvQ8LBEIfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3059
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

On 2020-07-29 04:23, Liu ChengZhe wrote:
> 1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
> 2. Check pointer before release firmware.
> 
> v2: use CHIP_SIENNA_CICHLID instead
> v3: remove local "bool ret"; fix grammer issue
> v4: use my name instead of "root"
> v5: fix grammer issue and indent issue
> 
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 ++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a053b7af0680..c68369731b20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -193,12 +193,18 @@ static int psp_sw_fini(void *handle)
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
>  	psp_memory_training_fini(&adev->psp);
> -	release_firmware(adev->psp.sos_fw);
> -	adev->psp.sos_fw = NULL;
> -	release_firmware(adev->psp.asd_fw);
> -	adev->psp.asd_fw = NULL;
> -	release_firmware(adev->psp.ta_fw);
> -	adev->psp.ta_fw = NULL;
> +	if (adev->psp.sos_fw) {
> +		release_firmware(adev->psp.sos_fw);
> +		adev->psp.sos_fw = NULL;
> +	}
> +	if (adev->psp.asd_fw) {
> +		release_firmware(adev->psp.asd_fw);
> +		adev->psp.asd_fw = NULL;
> +	}
> +	if (adev->psp.ta_fw) {
> +		release_firmware(adev->psp.ta_fw);
> +		adev->psp.ta_fw = NULL;
> +	}
>  
>  	if (adev->asic_type == CHIP_NAVI10)
>  		psp_sysfs_fini(adev);
> @@ -409,11 +415,28 @@ static int psp_clear_vf_fw(struct psp_context *psp)
>  	return ret;
>  }
>  
> +static bool psp_skip_tmr(struct psp_context *psp)
> +{
> +	switch (psp->adev->asic_type) {
> +	case CHIP_NAVI12:
> +	case CHIP_SIENNA_CICHLID:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static int psp_tmr_load(struct psp_context *psp)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd;
>  
> +	/* For Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR.
> +	 * Already set up by host driver.
> +	 */
> +	if (amdgpu_sriov_vf(psp->adev) && psp_skip_tmr(psp))
> +		return 0;
> +
>  	cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
>  	if (!cmd)
>  		return -ENOMEM;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
