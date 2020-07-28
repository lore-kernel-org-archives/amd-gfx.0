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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DFC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:12:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7714E2070B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 18:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="abw727QW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7714E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 270C46E227;
	Tue, 28 Jul 2020 18:12:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E5E6E227
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 18:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f726XrJFTSRrSpasPeKkfafQylNAtOM3CIaQPE3bTFmJhomaZWUPSs2HB0TYg7Z35xL+FD/N1JY68dgBr/Q/yFhJL+xpIXU8G942eYEcZCnAEuZ1nVvbeWRI+4kouRZRk7/lgrXdRnB14KHhmGp0xtrL1BhF7BCqoR6TpIjCVQqLcocM1osrtzUFV1o7aRmYZc0+KjiAuWb0EzeWdw5JQ391lZeVEIehvXtoLeYOJ97SWMF6sSby+7zD+iE0W+m92Bk+cnltKcsJ/6teTLG6NbvaDoKLoqJt4zVknYnrGR57B1z90kmj4HMxIjFWrFmCGV6Bp6YEAUJdagHe8StFTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdv5bECbqb2oCkPvFVaOFyCT9d8bw0VkVDI9tSWhOvc=;
 b=ncFewRbAn2lT1Ijen224Ts2epIKUT7V9JLJT8Xp6KPTC3bHbwUiGKuSbEF8W1nTPfQk+H5J/4uCfdr8t7Pp6MQvoOfSKOAnhcQCc4xfGXgtb9NO0Rx0QHvPhN+/izJeYIMyRhyp7UKHrIftuYDaXX7mp94CF95qDKsx4M//xouHoQn/1gDlhRQSTaVWoYvJjW7gEwlqVdz/Zw6UDjhbV31d4F/zUDnnO3WmvXZMWcbaaFXpu8JPD9Z94XMgj1wugHhGsTtqWO8zs9rLy1QTKiAIqwEHVjqL9s8pNHo9kzBslZKGK87vNkj2gL+xU01Mtix6HuIkhRT+D+g0HwvOhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wdv5bECbqb2oCkPvFVaOFyCT9d8bw0VkVDI9tSWhOvc=;
 b=abw727QWIEqJD/4frvN540kA4I916gQRPsTLH4JuwmNeBqJ/pB93+i/9h3BFE5GjmOjwmMegYaBFf6vrk3fH2A7CD0C33jAMtrm/lhTMjCMZogjsG9mOkJbqLEzLquEvA92m3MY1p9L9y+TpePtV5qg2sY1DTzEDO05psLVHnSo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12)
 by BN6PR1201MB0051.namprd12.prod.outlook.com (2603:10b6:405:54::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 18:12:39 +0000
Received: from BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d]) by BN8PR12MB3124.namprd12.prod.outlook.com
 ([fe80::5117:9f4f:6cad:786d%4]) with mapi id 15.20.3216.034; Tue, 28 Jul 2020
 18:12:39 +0000
Subject: Re: [PATCH 1/2] drm amdgpu: Skip tmr load for SRIOV
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200728053647.415062-1-ChengZhe.Liu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <622cdce6-fa2e-d1d7-29be-9323953935f9@amd.com>
Date: Tue, 28 Jul 2020 14:12:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200728053647.415062-1-ChengZhe.Liu@amd.com>
Content-Language: en-CA
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To BN8PR12MB3124.namprd12.prod.outlook.com
 (2603:10b6:408:41::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.22 via Frontend Transport; Tue, 28 Jul 2020 18:12:38 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b8dcb63-c7a3-4b06-3406-08d83321d046
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0051D4040E151C2017D7817C99730@BN6PR1201MB0051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVPLn2i4rUuqNkyI0YRK4zBngiF9rQ7FCQYTctiRc2U2akZHHZItqtTEgSpJCSPhRBE+jX/WpeWLOrce5G+MEaGv3N8eJP/n0UJWc6VXUTkazIbgNywegSzDuCAhO7fuNHtbFtvYR3b8olD0zt/fpLLWk7D+OD6sjUItCP7+FyEyPFtElLOPMTVm1QvssSJ01dyXwTLxGkcMw1D19mgtHdkS/cNsI9y4emAv2cse4RKVTor0t1tGIGPMaRwP0oWq9wQVG12tzcSWJuMBlNgMstKYq8i9XG00E4Omq3VOksdtS3lAHcNehaU6a2699Gy+hZiDN7rkoY9OlK7R3YpLO7gbbfGr6OrzaJdI337h3ejTjK98aGU8jfyhGB7TrLRr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(6506007)(26005)(4326008)(66476007)(54906003)(31686004)(66556008)(53546011)(6512007)(8676002)(6486002)(66946007)(2906002)(2616005)(44832011)(186003)(36756003)(5660300002)(16526019)(86362001)(52116002)(8936002)(31696002)(83380400001)(478600001)(956004)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 82JU/qOib/DzfWCW/iCj6T6Ddogoxx4Se5uyEH28fOdK97qE8aOsxc/dyBYsVajofrZ4gifAqFYPMoPRs2CHnr0MzYSC4n5bkcAD/HGX7mCIU1vvKQBOhoBPDPjDFPatCEZ8yQIgiYQLE8Em3l763Ziy8ot5XxfYMIjlkkNUzw/wOnp/UzF4rFhwyFGtAKb8xQIuX9ZvSD7uhCeJ6GS9qXj9GPEUzVm++AyULuCLSx7VHoByKOdLXMgJdOWB2ldiP3UGBGjNj6gPJLYIXnEIWGvrJ6BpLVL9rmB6aUYRQH9hxHcTKF70M+vDHXFvz8h0/Y380dQApAtdFBv23VU+gAp9lLT0dGZTdtyFCmM3PS7KkDSSDhv8ZsJ24UhG7F48Tdpn9DkpUkTeBa6ua8LGUXEm3vRkZkNyWIcT6LKwcJtEvhnUVaBGqTRydjvs4wo4LqR/rG1+9wnW4A4Ghdzn678l0m/rbk30Ux/e53/k8PZO2KoVX2BEaTaNqzniGDZb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8dcb63-c7a3-4b06-3406-08d83321d046
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 18:12:39.6482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNiNCukMdaxtNsbpHGBpc+QqlLF66vTjM1PiNIB5Dyc2K4SbJOOJMKCSXsf6FRPV
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

On 2020-07-28 1:36 a.m., Liu ChengZhe wrote:
>     1. For Navi12, CHIP_SIENNA_CICHLID, skip tmr load operation;
>     2. Check pointer before release firmware.
> 
>     v2: use CHIP_SIENNA_CICHLID instead
>     v3: remove local "bool ret"; fix grammer issue
>     v4: use my name instead of "root"
> 

Don't indent any lines.

> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
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

Yeah, that's very nice now.

> +
>  static int psp_tmr_load(struct psp_context *psp)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd;
>  

Fix this:

> +	/* (F)for Navi12 and CHIP_SIENNA_CICHLID SRIOV, do not set up TMR(.)
> +	 * (A)already set( )up by host driver(.)

Thanks,
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
