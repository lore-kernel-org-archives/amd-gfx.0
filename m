Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC7C433E4
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BE420786
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hVaim7Xm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BE420786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FF16E241;
	Tue, 28 Jul 2020 18:44:28 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680066.outbound.protection.outlook.com [40.107.68.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C763A6E241
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:44:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZdfFO6KsG3T76nkxC49fo539CO/nu71AiYQXv+D5NNon0JCY8JtVZbZfrsvngfghHb9LGUOXgE81Zkuhkaf/pP8rLApynPS1uMzNDTxF7f6nIB24yNejIxVPKOCADoy1+XBYgMCp4pDOLQlarOrZJlUnJr/mPweFWI4uXilne6ZptoBtsun3UCA5Ne+MWwuFgyg587e7ToxWmRdi4YJopFBW7xuJPEz7gok5mFtlzEWqcGpoJw2fBFA13xB51dfa4kTt88pkqhHw6zcdRxMz7HBR58H8Is9M75NlatoIXDIDWXNoVm5tEG8j9x/laW94C62c8ESaBeQltkUyWE/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XszP3n9VRo6ghCPyLadF0nPovbjVeSRptBeQGN+pCMo=;
 b=PuQ3rX37HfluAeTMxxmfbd5qGsidXu2+clQTxhlDYuKeBEv189nIRnflYWkoGNyQHxjZxJX1Kk2K0i9bjyA7ShFwRJO8iybpOCF2GFeS43w7dwIJewjfZ5/T+UgDTZuzJtJgHMTRDlKVTgVVWZlRYFoUa7qQhy0/dqYC5oj2nK5hH4xLaXeOxtpQ9rupZBvqu0TjU52TMs0unVpgMyxsLblM57bu1x0MVGP0vx53kZ/CCzgBesvwRRx6otMwF9jde9WlVik4YCgOIhCIRn5Pu6suHJMlhREwA2g+BT5ZGecwj2EXk7vg38CdDWck5Bh3E+4m9hj4ChJFh8200zUQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XszP3n9VRo6ghCPyLadF0nPovbjVeSRptBeQGN+pCMo=;
 b=hVaim7Xm8e7dj7uy5xOEbDNCt3uQLpAmdyFWw2/83SJsBPK9syQlPhG6le9Jw9i646IxvS5iPnZoZs+Vf9ZCN1U2UyylAwtwenO6tCUP1huu/QXDgVXEMiIhzQoRmy5/Z4YzINliUKBcP9eJfMl+dUMC6vBLMtDuhfK9gSERVGQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN7PR12MB2706.namprd12.prod.outlook.com (2603:10b6:408:2a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 28 Jul
 2020 18:44:24 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:44:24 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: reconfigure spm golden settings on Navi1x
 after GFXOFF exit
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728052717.21071-1-tianci.yin@amd.com>
 <20200728052717.21071-2-tianci.yin@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <6bf4db16-25ca-4588-345e-c4919f1bdf30@amd.com>
Date: Tue, 28 Jul 2020 14:44:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728052717.21071-2-tianci.yin@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 18:44:22 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e000096-51c8-46ef-37d9-08d833263f5c
X-MS-TrafficTypeDiagnostic: BN7PR12MB2706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR12MB2706314DCDEDB4935F1D268099730@BN7PR12MB2706.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnysTjJpj6jK3H/ECKABhXxYMX8thqGAma5NM/oMgMo1mrlN2eZmsVW3VYOSVjSU8WmdycSY8i83L56JZKGoaTnb+6ztgO3ibhvrDi+eIQ7DCbLMEr07OvT3AtK2K644EUguylqpm0cLedJYZ2G2uMJidtucZRqF6hGxKRaJTsB9r6xb5JOPNbcnRUvq+Ux2kS92XB6YWfPChYnv/C76lulfhD+ktdS6MCw37pfBeYyXb8I23vI5fVPM1VmKUS9zupzktwgBno1MMugO7y+HtJkbDeMpRdVC5q538Cl1gHJC3Cz5i8OW5LxqiRBFbnhPX+fkWV+TwPTRI8miPeN2NLby/zMep51zHr4NX/QidR2Kyocx0/Uw8apcE1bntdUGCZMgdqYZrNZzTawbIrDHTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(66946007)(66556008)(2616005)(478600001)(5660300002)(66476007)(2906002)(956004)(44832011)(86362001)(186003)(31696002)(54906003)(36756003)(53546011)(6512007)(4326008)(8676002)(31686004)(8936002)(6506007)(26005)(83380400001)(52116002)(16526019)(6486002)(316002)(32563001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: z1dqQnYFge8C31l9fMC199TetVR73SYHz7fD2Apyz2TWzX/Pt1xei5L+akQvYHNf78f07Udoti86vfVm9hmDcQumaokNydFYAlDAe+mPdH0AR9Vl2OVqa9/yBuyBAhaELx9Chhejp1/gI+whUBlMs8+Qg08vPWF2fSRLwSjDUJUpYI34rrG4o6DGKSFQsmfuO8QtnweMHLfGcXwFlIbU2/+EY8z+GPgm+Bm/rsw8QR2n4PoMDhMYQEFCT3Nh2mjRC5QxaZOaXQZGPiWfZq4e3xWHHoSReQSGG1M6cKckevuTUBaXd0FJTGLNQZ6d98/3eV5DFb8JebJfLhJy4n/EIkrv+xIBtqccZT61ijuhbcJJHnbeCtm+6pjDhKU5MCsdGwLKa1FmHa/e9tACPpo2NAIxpsrKPMdg+SPvsnItYFj6roKK7tPChdy2nc9OMDum1UQyURO7pqHFa3z/1cKn2A1G8tYB7VTB6xMUgpZeJ0MBfDNjk8+oQvxePi9zNqe7x5Rp6eO695Mk/HyfXBFy/C+Hpn2P+6fZ/xPM2qnkVYLVvyf5ev40XV/pakDPn4djIMmbjZi19W2eMvJ2Lg0WKi00Q+8c7oL9xbMH7j7BOm8GAFqiTEGWgihVZLIDsz1ojBfmny0apgquWiMQOKUyTQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e000096-51c8-46ef-37d9-08d833263f5c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:44:24.0035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IykKrM2QIQQe/YnHipMXrgSAse2jI4X75A6bZcPeslKicDdmm2DcOwxzjyIbfPZY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2706
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
Cc: Feifei Xu <Feifei.Xu@amd.com>,
 Hesik Christopher <Christopher.Hesik@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Swamy Manjunatha <Manjunatha.Swamy@amd.com>, Evan Quan <evan.quan@amd.com>,
 Feng Kenneth <Kenneth.Feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-07-28 1:27 a.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> On Navi1x, the SPM golden settings will be lost after GFXOFF enter/exit,

" are lost "

> reconfigure the golden settings after GFXOFF exit.

" so reconfigure ..."

> 
> Change-Id: I9358ba9c65f241c36f8a35916170b19535148ee9
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 55463e7a11e2..5da0436d41e0 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -1309,6 +1309,7 @@ static int smu_enable_umd_pstate(void *handle,
>  
>  	struct smu_context *smu = (struct smu_context*)(handle);
>  	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
> +	struct amdgpu_device *adev = smu->adev;
>  
>  	if (!smu->is_apu && !smu_dpm_ctx->dpm_context)
>  		return -EINVAL;
> @@ -1324,6 +1325,16 @@ static int smu_enable_umd_pstate(void *handle,
>  			amdgpu_device_ip_set_clockgating_state(smu->adev,
>  							       AMD_IP_BLOCK_TYPE_GFX,
>  							       AMD_CG_STATE_UNGATE);
> +
> +			if (adev->asic_type >= CHIP_NAVI10 &&
> +			    adev->asic_type <= CHIP_NAVI12 &&
> +			    (adev->pm.pp_feature & PP_GFXOFF_MASK)) {
> +				if (adev->gfx.funcs->init_spm_golden) {
> +					dev_dbg(adev->dev,"GFXOFF exited, re-init SPM golden settings\n");

Space after comma is required.

> +					amdgpu_gfx_init_spm_golden(adev);
> +				} else
> +					dev_warn(adev->dev,"Callback init_spm_golden is NULL\n");

Space after comma is required.

Please add braces to the single statement of the "else". The reason for this
is that it complements the braces of the "if ( ) {" of the multi-line statement
and closes the block. "checkpatch" calls it "unbalanced braces".

With these three fixed, this patch is
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> +			}
>  		}
>  	} else {
>  		/* exit umd pstate, restore level, enable gfx cg*/
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
