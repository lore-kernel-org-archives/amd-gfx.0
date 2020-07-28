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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76362C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C28E2070B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3EpycJEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C28E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B50696E22A;
	Tue, 28 Jul 2020 18:10:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374336E227
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZzU8bpDROo1/fg9x8qXbV9KEMeE5l5RSH125iTrNKZC8cMHcVcCNCZkvSSY7GfO1JmHpa4uqv0La8Kjp8isy24/YWggeAhV/dwKSR8TQKjyTY/sJJ/JWmyVgMZbrVaY4beGWjoQ+B0IzDLQQCN/XRUv3lTdnwBbFN2QkpwS006vQ0FiOHye/UKVrJVVw9iBzB3RjLehuRXT4/rbkX44utrLGGogKmKLHvm6G6WXfSXcX39fSPdU5GXd1YA4Zm5m/VPBm/z4gWeaFZb3RgjBOIXizmHrVHGu+Q4x5fsBiJAEuPAHf4JkLaS3pQ5YxfFDez19QQ/0WMUZqDzUJjkElvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yek/7vIXM6AzIjoaIggKAMjHdUqsyNs7m2E2uAnlcN4=;
 b=nL+4cdY3TWNylqtRcc8Su/Vj7n9xiF83PHY1zXppD2tEvpgoAwG0Vu4U07EOjsnnGL2GcPhFUE/yoCoXF9ixs4kwZfltxRwiBbCV9lNDaQj00WGdJzPe7eakuUiMMGX2nvn/ghtGFLTkIFNlqAFV5tQOdCdA2wXxqdBrVu1fcNP8H/KLckPNja+f1Yc1IMlG+GHij8mnWkzTgi+vCSnEPiSIwR5n7D1tGrTNPtQsR5YiwIqhyN0zSaJHfxPRPZqH/JnVPCrWeNRds5rjRbjr6llAkMWsHIWdwX0M6xXS0gnzmSQOD/goxSRf3QlGut4/7DfWepFLoTsmSVHKiXWzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yek/7vIXM6AzIjoaIggKAMjHdUqsyNs7m2E2uAnlcN4=;
 b=3EpycJEEqNGKH6czZs90C9VORtRzJnQaizYcHZTUxnz88SvYlCT528yHNINynRzpeKfXI+8KeymrXZGWrjmA+9XiQ3iHJ9IR9HeQyfJCjAkH5ScV1MXFeCQbYmmP9jjjazge1XplWf5gd5u5pLb9GSdE+lI+hkXOhpOjo/cS9L4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 18:10:11 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:10:11 +0000
Subject: Re: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728051236.414161-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <2c31bf6f-8cb3-a34a-a4ae-6c492acb8caf@amd.com>
Date: Tue, 28 Jul 2020 14:10:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728051236.414161-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 18:10:10 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 273f63d1-2eb7-4d22-e14d-08d83321782c
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0051A6CCD114F569555B814A99730@BN6PR1201MB0051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ui9zjc3JQi9hp8bhxyT/exB/xpOkMUtWyO7lf7KDVfCTV2dIR6QA48T/naJrOgVk0ZOcS7X2OG/Kj+jKHXW8wIRthvUqxvS5l5Y6jrhr9ItugjtXyxthXPJckj/xps0zbPqPkW2SF63pKNgO+c0pdKEspRhVeokhDNPY+44o0+ccBa3F9ZygTKz1qRQbJP/pvuWSgrlSyS8jcwworTTrEunN3K2+4au7+XyIsOaUqpKDNsw06a3kVCGwiKFUzsbEnRyFtFPHQe5fqIFwCnnhgQ18+fH82JbDpV/dQiHsf6RRqCQ7iAf//1GgX22NkOkVi1X1n+6gNvycgSu2OX89P8VvMlk/rYLRY1sCPTyV5h8VbI+zt4Uj/ZzZEJNQG1tBQMRwdlR5miO+wKbNfWizOiovWOR6Y8MT41zCwQTQGOMX+9vgvvRXRtgRkPJyFu0E1lTBulajZtd3m0qzsXswQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(6506007)(26005)(4326008)(66476007)(54906003)(31686004)(66556008)(53546011)(6512007)(8676002)(6486002)(66946007)(2906002)(2616005)(44832011)(186003)(36756003)(5660300002)(16526019)(86362001)(52116002)(8936002)(31696002)(83380400001)(966005)(478600001)(956004)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RazWg1J9dQs+cI021gamI+KeS3LKDYQr54IL8M97qPqd/mE1qf1H35DjzbIm1qR98QSVBZFiuF2peQ0VFfmau5aYOiv5Dyxiy14Puw9zmefDF4tb1TeM7pnZu1YLufCnVs5WFjsLfLdtOwAHmCWn4ZojDaP++YXwiBP9nRa8e4hwjaIbu9gSNXmuih0hfIGRpu60dwqkY30huH/4enxSAqdeyybCy2AuW8/mVdqgWhjpPZUErziJDGTz5XqsT3JolB5J8T3g7yf6UVJAER6qRWu5bqRPtw8DvHKJ9jGR5LcGOKz9wG7vGULr7M+2XdNKeBy/DxOvofLYV7WngRoVpjMQfpumGZk7ff8XOjiHpI8hQk4RxjgjrNnhM4z9RvBKGOU/BUbr3G8G35l0YFqUDghB4MR+KlgOr++pEnzZ4AinsvTI7iQ11n/qNhdnyArCV7YvMqGPRc3bG+7T2mIgaa1wSI1ZixdLKAV75DbN2/OhMBnVh2FDZWvpm+65Oq+c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f63d1-2eb7-4d22-e14d-08d83321782c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:10:11.8208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc72v+eU+uII4Ub4IXrsvhk1/HSpZKbNce02MVVkgMMDFC9vTQdJlkwKplG6kVo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0051
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

Thanks for this patch.

On 2020-07-28 1:12 a.m., Liu ChengZhe wrote:
> From: root <ChengZhe.Liu@amd.com>

You should fix your Git setup to show proper user name,
not "root". I've prepared a Confluence page which shows
a way to do it, and a few other things along the way:

http://confluence.amd.com/display/~ltuikov/Git+Setup

> 
>     1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
>     2. Check pointer before release firmware.
> 
>     v2: use CHIP_SIENNA_CICHLID instead
>     v3: remove local "bool ret"; fix grammer issue
> Signed-off-by: root <ChengZhe.Liu@amd.com>

You're missing an empty line between your commit message
and the Signed-off-by: line.

Also please do not indent your commit message. "git log" already
indents it and it would look too indented to the right.

Below for more:

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 35 ++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a053b7af0680..7f18286a0cc2 100644
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
> +	/* for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR
> +	 * (already setup by host driver)

Thanks for fixing noun "setup" to verb "set up". But there
is another "already setup by" should be "already set up by the host driver".

Thanks and regards,
Luben


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
