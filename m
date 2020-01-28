Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224FC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 21:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5081C2087F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 21:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B5PrRevb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5081C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B576F426;
	Tue, 28 Jan 2020 21:48:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F377C6F426
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 21:48:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByqZDhormLGRqpEJWaGJ5LuKYQDK9hDgjYPNak4PLLPZXKBhfk90qoi2d4U2Ll5fLnVZMBtTUsJ+FLKqpckVHtS3p7aeVUZ2Yhi9QKjfno0mf0nGy5xlo1iwbvkmk3G+pPX9nbX0mtQdzvwCEZ1WwoGRUiOFgOVucnSIxUN7tsO9WfMgj3NsDcrEdhb0/a27z7A6PBEagH4zHkiidgQPbt05Fhyz3OA7pCK832JLPV7WhTLg1GEOz5Bg7zpZ0Wjvk0TM3rK0RmrZ7/F6ozbUBlih1/dpcS+eI8ugpEm6pEVm6fcgisAg/2gZ0wzj5QH2P9r/nUyujgnLaRXiSEchbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCywni62vLPpFTgvCMVO6Yk7Mf5sWKDFugK/3JZ0+zs=;
 b=gycU9UcW18kA2jmxhry+rSYSQfwGS4VJHNh6Wi1Hw+Zg/3F1D1XPkw7v1zhLsOUGbbQ9p2sF0N+nvzFRyS3809Ktya5TTRDTFRGml/Ly7iAvqEZxS1pXKQ+BVpshs+dihcL0Ra78DxU4bJEDCILv1yi27VYMiS4KSYRT94PxXuI6bJfFlHXgjO0F+lkahkUS1nxfxPipF1HpSNuZP87LDmfch1kUE6R2OBvDJPR6ohRjOxtjbO6prCxFGI5nXP8F6KUAvsyz1nmLrUsWA4BnuJupnyjrytA7mDoCk3U3zsgnErSRLyTkM6AWnhuSO3AoqHTyxGxaRKwVgRyDQ2EZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCywni62vLPpFTgvCMVO6Yk7Mf5sWKDFugK/3JZ0+zs=;
 b=B5PrRevbGXBF6Ny86qNLEw3BOTqFBcd1Qj8ea9RoAn+SVJNfR4HwC4482AfIGsmS15CbdbDdcvAXgGENaEe+fmUzw6oafZwR/4ws5yKvvzspmd9Y1Bkuz61fiix/RX2q9ZikGvy9P5gybogQxAaTQdhADamnZPQMo4NOdLgQLvU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (20.179.71.212) by
 DM6PR12MB3802.namprd12.prod.outlook.com (10.255.173.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 21:47:59 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::c4f1:5ec7:7314:75bf]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::c4f1:5ec7:7314:75bf%7]) with mapi id 15.20.2665.026; Tue, 28 Jan 2020
 21:47:59 +0000
Subject: Re: [PATCH] drm/amd/display: Move drm_dp_mst_atomic_check() to the
 front of dc_validate_global_state()
To: Zhan Liu <zhan.liu@amd.com>, amd-gfx@lists.freedesktop.org,
 Mikita.Lipski@amd.com
References: <20200128214424.43253-1-zhan.liu@amd.com>
From: Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <4ec0cbdd-efce-f2f6-5c6e-cce1b67909ac@amd.com>
Date: Tue, 28 Jan 2020 16:47:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200128214424.43253-1-zhan.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
Received: from [172.29.224.72] (165.204.55.250) by
 YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend
 Transport; Tue, 28 Jan 2020 21:47:58 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5af5ba1f-845c-4faf-2c06-08d7a43bbda7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3802:|DM6PR12MB3802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3802F8653DD3804C586128F8E40A0@DM6PR12MB3802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(2906002)(478600001)(2616005)(6486002)(36756003)(36916002)(31686004)(6636002)(316002)(52116002)(956004)(53546011)(66476007)(66556008)(66946007)(16526019)(186003)(26005)(81166006)(31696002)(16576012)(8936002)(81156014)(8676002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3802;
 H:DM6PR12MB2906.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGq90Ictk0svfq1jrv6moHa9apqydNaAiq0WpeUyszfE2NujJ9eDMQIncXpePfTvZs1Kso48JR0Cyam0Bh1Vti5sO1+V/3YP1GazkHB58sH96sTPo6w1KmEV2ygz+q0Mmuh2kRt6MswvRQBPEhGKdtBd+47LEWNP77FKZg68rMYDP1kWtNXJolg0xn2AlTx9D5lgUG9iYC0Oh9jpFUVSIYeL+YnnMHAYWhFNrS/+0oQxMKFXz5kSoA80nZGQ/4RrBuwCrMV5s14Bhs8u1wetW4EfOhVA728taPJ7TUUn8k4gkamEB9A7W3OLwW3DJsykEmkDjLJ9IDutvf52MJaNNISV11aWnymupKJiOxBxua1Hp7uAr7OFKSFMJw7elvEgmbRbOaottJsc4aopcVXCJ1rG6cw0By+cdXy0a+iSFipzEbatHk3TBA1SXPfKRW79
X-MS-Exchange-AntiSpam-MessageData: okBXR2jLRZZ2h/i/r6co5W0Qm2K9AtTnwdMCJQwhhm16GYDx+ivoUT9RNXQE++MVH2CDYvbV+wGa3ScM50VicxoMC64YTHYtp4JvZFOlfZLCfpk2iqtZIMWAZNmQUuRlDTIEFPQnrKOP5nE/W5SLWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af5ba1f-845c-4faf-2c06-08d7a43bbda7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 21:47:58.9459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UiXI/6pKddnhTjvTUOl1HLKYqMUvb1Z7VeWA8ZjMME88hTJBsHNoN1+pn69fnbnu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
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

Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>

Thanks!
Mikita

On 1/28/20 4:44 PM, Zhan Liu wrote:
> [Why]
> Need to do atomic check first, then validate global state.
> If not, when connecting both MST and HDMI displays and
> set a bad mode via xrandr, system will hang.
> 
> [How]
> Move drm_dp_mst_atomic_check() to the front of
> dc_validate_global_state().
> 
> Signed-off-by: Zhan Liu <zhan.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index eed3ed7180fd..805d8d84ebb8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8256,6 +8256,16 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   #endif
>   
> +		/*
> +		 * Perform validation of MST topology in the state:
> +		 * We need to perform MST atomic check before calling
> +		 * dc_validate_global_state(), or there is a chance
> +		 * to get stuck in an infinite loop and hang eventually.
> +		 */
> +		ret = drm_dp_mst_atomic_check(state);
> +		if (ret)
> +			goto fail;
> +
>   		if (dc_validate_global_state(dc, dm_state->context, false) != DC_OK) {
>   			ret = -EINVAL;
>   			goto fail;
> @@ -8284,10 +8294,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   				dc_retain_state(old_dm_state->context);
>   		}
>   	}
> -	/* Perform validation of MST topology in the state*/
> -	ret = drm_dp_mst_atomic_check(state);
> -	if (ret)
> -		goto fail;
>   
>   	/* Store the overall update type for use later in atomic check. */
>   	for_each_new_crtc_in_state (state, crtc, new_crtc_state, i) {
> 

-- 
Thanks,
Mikita Lipski
Software Engineer 2, AMD
mikita.lipski@amd.com
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
