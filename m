Return-Path: <SRS0=tcRC=MO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14ACC6377D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818486101E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jul 2021 14:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818486101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9436EA67;
	Thu, 22 Jul 2021 14:22:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE186EA67
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jul 2021 14:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVNBCCn5fUFz3y9h+OH5HLEIXKFgCL5TiKHKlaIekGu1z9EokFcLdWirM4bqwt/x9FGb9fOUZq/jfGzTwyRmc+TWGDuzGMpJ7SqseX2n+PFEgh28xhZ/4uyYqAwpL52YhDUcFmCaCjvbWbKcWPSjttR+irwaPwAsu4ESorcVqOQX1OViRCZsjgmWPfjR8kl/Yo4EpRJ64PIER8bzAhaSRLuvGdn0KUwZCKSdq2KGPx4v4RWxR1+X0ckSds33zQLdBiMuwbkK4mB9PZiHaTPnYZJNcwctIkBgR2DB0EGkCLMfj6IK2B6sYQoHOzqEKyL5WZyS+CgKOgOM5KAXqHHKbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uyQr15ZJXx6t4LvfZdXCSQlYi1ljOlfqAfns8TaEM0=;
 b=XPbwBxmSkvz4wxm38r10KreEfY9lSphe8r6cfijHbziowOU8zRuBXW9pJm2DiplPV/6s2U2NYHOt9PrjjG7zrEULpbd0bNKCZo+U327Yt3W5G9E3L+7gPPxvh55w7VeZRsFxqOUBGJBxvy8U0mgvMBqdg5KYrL+1/KTIvxIeTtW1HkjgaIo/mG6xRv9DFRYWDu5FBZRmHPk/VMVlnaQeV+H/FT2l1S1Wb5+88kkL6cZDfDuNkV35/tzivIXjR1YmpZhtIRCiY5bHaT13r7P7rx+mUg3YMNTWjsjGSnboFOT9iixPltIIShtDS3VchfVy8zCIMRgsXd1pgBG76qvikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uyQr15ZJXx6t4LvfZdXCSQlYi1ljOlfqAfns8TaEM0=;
 b=cjLQhwSpVs8pBfjoAAEtXtpgnWpNRnzcciKqyEdK/OMGpi7uGi5y7rpAsev9uBVYvKJqqV6u+S8SVahaJNDlDc33mGJkMCS0fDlSrsvdGg9CL37u6WjgFHRsM5kyqqIU3T4hBhQW2D//otGTSUNtO8T24ILG9OmpBmQiFyXDXXE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Thu, 22 Jul 2021 14:22:28 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 14:22:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix build error
Thread-Topic: [PATCH] drm/amdgpu: fix build error
Thread-Index: AQHXftuVSELMXzOwekWe/nXadydwFatPCgIAgAABWKA=
Date: Thu, 22 Jul 2021 14:22:28 +0000
Message-ID: <DM5PR12MB2469A4D01053A7F5F5D04263F1E49@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210722092537.27624-1-guchun.chen@amd.com>
 <31ab5df1-3692-f9af-2467-4c8dca0b5c0e@amd.com>
In-Reply-To: <31ab5df1-3692-f9af-2467-4c8dca0b5c0e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-07-22T14:22:24Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=3d0c1f51-518b-4db0-82d4-fea9137acf35;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91bb4c16-4503-4cb0-7ba8-08d94d1c22c5
x-ms-traffictypediagnostic: DM6PR12MB4372:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4372E4535F59136D808F308AF1E49@DM6PR12MB4372.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHHIhZShlBMJAq2aiyGYT7LVoAVunMqzAFujPb13GdY62M0R4wHjopqLBFKzeZoQlfyfr7yrdzEoA2EGC2quq9kL+ww0cpt/x/BqFxUkebQW81qDBNIUTdU8vsnVockLKtf+U6oPsw2+A0+2YhVjBaOpgpGDIeUG4TnZmV3rB5KqrTphEor4tm2jg/0YHcqrh3cJ3yE9onw0QQpNbsSw33v2yUgCYYNpfeyG99TlvfwpHeSYigwLinZE0uPgukBPacHBgr9f9Yq9awYkbL3scdQtB+Ty8xVMaVq/hGqJJqfWonsmW21MpL47GOxbZuHCiDuR2Nfj7CYfMx2LWsYIDdri2ZV5xjVPYCgRWlmOhN/Rz2cDYPl2i44agl6vrggx0bDlBIUW57ZCgFEJZs0Ruo//WxGnn77OaVSKGJbWRUX7yWupMNR3IOCvlLee8Rw+AvZvt9LDOkz3YEEMePAzDrdL2DUTtxNS4aCir2e8F+eWqGaNPVU8HdzIGlTfLGMMhuD4k4UMPru79EE/40s1ePl64wkVRyASToWYc5FRhKPh4Cp5eStk6M255DQ8cIzT2iboVXie/ipusJ1pCKMfr/biHab8q16ZZzgTKJCSJsS5Yp8ae9qUiX6CVxJcnj28ttVWeL/6ao159y3f1YwrEBn2INK5/T5ZFt1UITnpXcknLhVE3161xuE7QhjfRWkV3y4VLTUg8rkE/3uWS2VUug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(8936002)(2906002)(8676002)(66446008)(478600001)(66946007)(66556008)(64756008)(66476007)(6636002)(55016002)(316002)(76116006)(52536014)(5660300002)(9686003)(110136005)(83380400001)(186003)(38100700002)(71200400001)(6506007)(7696005)(86362001)(53546011)(26005)(122000001)(33656002)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXpLSzBIdXJRTS9MbHZqamlDSWlseDNLRGRvOFcvRTZFZDRpbk9FQ3JhUFdC?=
 =?utf-8?B?aG4zZm05MzR3c2k2RHdHSmJSK2V0L21nbHByRENlb293eFVaY0VwUHB2K2tJ?=
 =?utf-8?B?L2I0TS93TTA1MW5CL1ZTTjZzWXZjanZKTjlxdDZ6OStUV0xkSWh1TnQxUm1Y?=
 =?utf-8?B?bnNlTkVETjRQUXMzUVZsa0R4a0hpVldaMnlDWWNKdXVjQk9DNDcxNk55MXp4?=
 =?utf-8?B?NEVXblM0ZVdLU25XNVJKVzV3UklqcFJmWlRvdUF5c0hRZmtDVjhHSUVFcmRt?=
 =?utf-8?B?ZG5ZalFVOGRJK3N4MXo4djlQUFJFTTU1d3hhL1N5LzE4Vm5WVW12L2hXSmlz?=
 =?utf-8?B?VkNXREFieVVncjFtRUxPS0l4cGs0azh0TlpHMW1oZjhNZEFSWUg4TjM4R3ox?=
 =?utf-8?B?L1ZiWEVEWUliWHBMTGRVeTlVb0tEYWdhYTNHMGNCMkZnRUpwTkVWODFOVGJX?=
 =?utf-8?B?TUhLMVgwTkQ4TjltUi9ZNER6cHcwSVRiRHgrSHVZRjJ5UC9iMHRqS0dRYXB5?=
 =?utf-8?B?cjVPaDBFUStTdXJTRkVtRExaakJxSEVCdWF3YjVoaDc5SnJneVRLZTUwTkYw?=
 =?utf-8?B?ZlY2cTdkQkJMWEZYNjZBUmkyUVk3enhLc2x3VjE2YXY1aGlMbURkS0dSemlx?=
 =?utf-8?B?MDlvcllXRU42R2t6WVoySnRMOFE0QnMySUtJR28wVlZmNExRUHVKNUwxdTlV?=
 =?utf-8?B?ejA1dW84eG9OSTFMcFFLRS9JbFN1ZGNHc2Fzc0FhSGFWM0dyNFFJTzRnSWwr?=
 =?utf-8?B?Qi9JZCswSHU4Sm1uVVZ1dkhXMXd2ZTBpSWhLUVZOL0JVNlVTTXIzaWlTQWtT?=
 =?utf-8?B?RG1jMHg2bFpOUXg4SlZndWdmTXhsWnlwbmFoRGlaa1p5TkZYcjBQUUhSK1FX?=
 =?utf-8?B?UklrK3NUeVVNWWtGREl4ZFFjZ3ZHbHo2bExRZWdjZHRVS0MwcGUxMlVzNTE3?=
 =?utf-8?B?T0p3VFlSN1VOMXUydnMyUWVoVzkyZGI5UlV3cmFkaUh1VXNSTUwwTWFIRDRj?=
 =?utf-8?B?cElJdmcvUVp5Wmh2Y09uTnhyaXJISzlzTnc4UXEzY25FVUI0d2ZUSzlLcDNB?=
 =?utf-8?B?WlB1U2pJdkUxTVFYTzVlN0dkSUtGci96TGd5aXRTd2p5dE1OWm1FdHVXTlBS?=
 =?utf-8?B?UXQ0Tm12MEphTWV0djUvK3NZaFRFSERxbXpoenNqQ0ZWRHpGZHNQVTFtSjJ2?=
 =?utf-8?B?a28xdmN0ZFlwaVladmtyZ2dQREpiMXUrOXlQbnFRM1ZtSjRsNmNFVFdZdjFT?=
 =?utf-8?B?TFdZOVI3Y2M0cGxJUHo1cGNhWnkyeE5MelB0N2dUenhqVnc5OGF2SmRKYmww?=
 =?utf-8?B?anFacC9qYjNGc0dpdTNuM1cydlNqbEpyUzQ2emVodVVDeTluZTBCTk1WaUlv?=
 =?utf-8?B?WXRHaVlsRzVLeTJGd3VQNjZ2QXVrdExseXoya21aZ1ZpVXUyejV4M1duWnNG?=
 =?utf-8?B?U3B3SnlzT09qRkhRektkOHhsZDA2ckdEb1VzWmo1YmVIWUpEVEJZT2dnUmdS?=
 =?utf-8?B?MVFZUkcvWFMzL3hpNkZ4UllPYWprQVJmZERrNjcxdXFkaVc4S1c4UnNXUXJO?=
 =?utf-8?B?bWx6UWg5RFYwMFNNMXNaV3RubzFwWjVVbGNNamc2UW50dEdSQ1VDMVEzUWJv?=
 =?utf-8?B?Z1Q4UzcrM0FVWkI2Q0RDOWk2amtKNDBwQWh6MzdMVEZESEdEVitRM1NTSGJI?=
 =?utf-8?B?YW9zcFJkWXc1anBteXVTTjdRdzcxdHhpNWhxOXpJaEZScW9wczl3RDJBWHNk?=
 =?utf-8?Q?ONaQHa5MdzDptNEEwRqDinYRd0chZDK5WwhAUDI?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bb4c16-4503-4cb0-7ba8-08d94d1c22c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 14:22:28.3398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFuEk8LyYl3JFZxBjt7yEb9aZOzRwR45li5m4G1BSroBj8DD3n1tWxNvnEzeYeqvrNdjqMisrUF2jiDvrZaukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

[Public]

I guess your branch does not have below patch:

7afefb81b72c drm/amdgpu: Rename flag which prevents HW access

Regards,
Guchun

-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com> 
Sent: Thursday, July 22, 2021 10:14 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix build error

On 2021-07-22 5:25 a.m., Guchun Chen wrote:
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c: In function 'smu_cmn_send_msg_without_waiting':
> drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.c:259:15: error: 'struct amdgpu_device' has no member named 'in_pci_err_recovery'
>    if (smu->adev->in_pci_err_recovery)
>                ^~
>   CC [M]  drivers/staging/rtl8192u/ieee80211/ieee80211_tx.o
> scripts/Makefile.build:272: recipe for target 'drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o' failed
> make[7]: *** [drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu_cmn.o] Error 1
> scripts/Makefile.build:515: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
> make[6]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[6]: *** Waiting for unfinished jobs....
>
> Fixes: e070ba49f3a7 drm/amd/pm: Fix a bug communicating with the SMU (v5)
>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Generally, there is no empty lines between tags.

Not sure what happened here? Rename? This compiled and worked fine on my machine.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index a48f18932357..a0e2111eb783 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -256,7 +256,7 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>  	u32 reg;
>  	int res;
>  
> -	if (smu->adev->in_pci_err_recovery)
> +	if (smu->adev->no_hw_access)
>  		return 0;
>  
>  	mutex_lock(&smu->message_lock);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
