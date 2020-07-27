Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB57C433E3
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6D220719
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 19:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ys41GKSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6D220719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F210189BFB;
	Mon, 27 Jul 2020 19:13:53 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770070.outbound.protection.outlook.com [40.107.77.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79E4589BFB
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 19:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKaPp4a9s4yHx177YmWymsNJ+iQ8O1VduAYhAoPIBjnW31+SdKmDcsSFqiE1Y4txtL7xkqWNmZNyazIOstsSVELP51n7eM/uT0Pz4MuMNgiZP7L/SYEDoEmrz4E6woK6I7mYlRlmDfWUyDAKVwBd1Z72IAR2qyogGRYoIjy3QA//g6N2APq5IEgUq6YYTAgBCV4EGfofImygBcBgAGzyExQYO7zstTFQCOEA5/kfa/+yjNtuM9KUzf9Z5wo+K14YXYOLUgubW338MX7Wd3sf7wREo9sMb1rObfiOyYsFqabX9Dol22dReucJ/LPpeqKhhqzg415OGOzzrVW3dRGKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I97i+aAXsVH+aGLBME7fmXsN2scE/1Kow1hDZiXPJkw=;
 b=P3rI8KqswkQZW22j2Yv9mrX+5rViytDQtsanRgG8Azq/KEY+79nHsXn0J++LSQXNDj5du+EKhCTrpY0wCxM/R4FQdbitGGpGqCDBfaTPX2LPRTg38dbreW6MaSx0Hx5kQCF/Vn9M7UoHHAhKZmxVcX0bkhczlud0plKJs751SVzL/hTLq0Gln7YbXhtFDt48VC13mGcJzGDfap3dFugL1fkEvdFh2IdALWCuHqawSTQuY7Jb0jut+XrVwm07PJ+QTJBY/INSlK2TQUjSmk3jRUZIIPKs0z3OKSVAmrOXiRGY2e4oCXc7oK8Jc+dgfz8GMlXN83bQ1Tz/WML02O6IQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I97i+aAXsVH+aGLBME7fmXsN2scE/1Kow1hDZiXPJkw=;
 b=Ys41GKShV/z+x+FnKS6OekvtufZJPdbDY+Ya077HXcS6MMR0nZh6Lry4Dgxm89oI8sAx4PGqMW7z1XrZSPdUrOP9Ooz55toPQuR0rAWBxAwK/sTJPuz3H7r6lIAEmzrDU8aHLiEJRix12o3XzjicEUXz64IEHGwWLbO/RqPlz7Q=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN8PR12MB2866.namprd12.prod.outlook.com (2603:10b6:408:68::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.33; Mon, 27 Jul
 2020 19:13:50 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.026; Mon, 27 Jul 2020
 19:13:50 +0000
Subject: Re: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200727105720.401290-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <723ba330-66b7-c156-d45f-0ea207fd0031@amd.com>
Date: Mon, 27 Jul 2020 15:13:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200727105720.401290-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::11) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0102.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 19:13:49 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b3d5a98-420d-4269-8d83-08d8326131a3
X-MS-TrafficTypeDiagnostic: BN8PR12MB2866:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB28669D13B59203B67DF239F099720@BN8PR12MB2866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hPjFFYt7QqgSejYdmMfOaHMj7LLUlUbv7QwxAgzIX5/XVWWljp6U4k2Kje0VfuhphIauZMWARiHrvR+7pKRD9CSF8AGE0Qb9ntLh7mYqPnkn9IDp2W0A0sxGwSndjGnhkF1WfN8bVWiqwh5JXoxS5acWtRoI0wddZBLf9jxUIf9KGCmwsmMRqwprDXaGOLfaSdZeQ6NQfJ/kZGZ6KsIBCa9E6ULcy5ZnbZ79ZPAE6ggjb6s5/c+lZPHfgdDFH4hRLtMqBYRVgSH9u1GSADjBsGvNeWDBOhAF5+sACbuQGQzjENFPN37yAq1wHDRUNHijPtA6bBJPz8Eo+kBu1WYtfc6iyY2GcfcINdd53xVmkSZU6sYAWAHNmmzekWrT0H+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(6512007)(2906002)(83380400001)(36756003)(31696002)(86362001)(44832011)(31686004)(956004)(2616005)(26005)(53546011)(4326008)(6486002)(66476007)(66946007)(66556008)(5660300002)(316002)(478600001)(52116002)(8676002)(8936002)(54906003)(16526019)(6506007)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CLcvi29X1g5RW5AdQ3FtoZ7hpDOLySlcG+8cr2O6rXsR4hIITl9LwbZa8bSnpmJw42VurzZTiH4whor4K1LVhzL5o5qzvSh8KvIPVlaTC3BeQJ3G2rK/lPD4qe2npWzZtL2/5rQP65fOsxF1K2FhtUStghQVvjewrpivY61ry6lZr6Cl36S96t7FrqpHa8q5TpsyFiDvm3Nv5O9Xcza7m9RA+POIebgBBzMRT3g7Mu3O9QqlOaKjTHIGiEekKtm8NHOtNvqwICYp0csnfzPjK9bLJtcPqwnG6JP5sv1DVPlR3EnsEOpUfCSLytOWNOmyBT3RD8Cqa7q4xIhhM6d+I/uGpi6Oo1bH1zRB7ZiQ6oVgWY9jOtR7TsBVJ8/EWRTIPog8u0VPNQGX7rOHylv6eQNXPNFdi1vKizoz3KFhbZaf7WhPV3Z+cE8ThpINf3wziQKURgTFbGpmBeYqHlDQC95YRDhsDg8sUr89ao0om7KeBs4+r+RKxLhpGL8/HUVM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3d5a98-420d-4269-8d83-08d8326131a3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 19:13:50.2631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6JhgOihpKdbpPgddAcCEscEQkT60UAARGOiwHdW2+LKBOyDnUJeK+HAaqQPuCtmW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2866
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

On 2020-07-27 6:57 a.m., Liu ChengZhe wrote:
> From: root <ChengZhe.Liu@amd.com>
> 
>     1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
>     2. Check pointer before release firmware.
> 
> Signed-off-by: root <ChengZhe.Liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 +++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a053b7af0680..a9481e112cb3 100644
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
> @@ -409,11 +415,33 @@ static int psp_clear_vf_fw(struct psp_context *psp)
>  	return ret;
>  }
>  
> +static bool psp_skip_tmr(struct psp_context *psp)
> +{
> +	bool ret = false;
> +
> +	switch (psp->adev->asic_type) {
> +	case CHIP_NAVI12:
> +	case CHIP_SIENNA_CICHLID:
> +		ret = true;
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return ret;
> +}

There's no need for the local "bool ret". Remove it.
See in the "default:" case you already do "return false;".
Do "return true;" in the NAVI12 and SIENNA CICHLID case.

Regards,
Luben


> +
>  static int psp_tmr_load(struct psp_context *psp)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd;
>  
> +	/* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not setup TMR
> +	 * (already setup by host driver)
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
