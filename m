Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C4CC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:58:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA84C6191B
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 08:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA84C6191B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 553826E87F;
	Tue, 30 Mar 2021 08:58:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B386E87F
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 08:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hycRriJdsIYmJAewqiDgtHtGytKJRXGFLlVOaVSAPZ/LFjw/cvMKHEhZ2I75K8YNy4os9rPht+4Rm82gAg4MoH3+1Dlg5htuqjM2us/n9Us2LoV7da037AnVwcQQrBjtN920MOcCQrKNoVFymrWucUHChIJ90yH/fi1vJ2wlVYRo3y3a7/L55DJlN4sO6K7GIHuBOgJ47+bdJFm5Hm3YT47dR7TOQqp3EcQYfjfOg+33lZ/h2MLGgU+WGtr1NINhNhknYbX4a+BkPDUq5HevaDxFqP7LsQx/YTWoCFT0f7KD+mKhRAXdaD8OVnMHbxOlzNSHoQM1vKnOfRxCGMDO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403PRATxMIbMoMSAgMgAY2LGb+0DGa1kHt24z59NSQA=;
 b=O0iyWy341a+mDwuiCC1MMQfn4dkhbd/YXtSOLlR3j0wBPKksAo9wbeG2cfXLV3A+t98pcdBaf3RV53JqwnFxeHPlOILJNeq/MMBS49WEAt4AH16rEfea6OkPuB6oKsZPAH0ZaO46ErUf3r0PdDL3ZOuiQiL4pOPQzdYV388/pWGa8Oe46+Pdtqse4ygRQqlr8xYJ94RLKh+Zxwh0q8Dcn4FuKXJ7Ojosueff5VCzyLqjzXIGsdVkZI66NVxr8ATU5Ruybiw+sWsEVGzWqblUSNSXqbFFTUPUD1GTOwzw/frL1dvCtULM8zgvYNK8vZoLfT3K9/wvne5cFWoUnOTmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=403PRATxMIbMoMSAgMgAY2LGb+0DGa1kHt24z59NSQA=;
 b=4WArts7LQIz355k484BhgjERZV1/RlrrdXdbzOnBRUp14xZRIBKmBWXz+WPyQQsxrMZMO7zDpfd1MudG8mJo0Tbr1t6xhUZRbGMKOV35w3JEyecY7kivjemrl8ih4ScuKsIEWzCaHopRaYIryy3ZYy+WDmqi24/vdGs+bjZyWpI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 08:58:42 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 08:58:42 +0000
Subject: Re: [PATCH] drm/amdgpu: Toggle msix after FLR for sriov
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210330081441.61418-1-Emily.Deng@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <53edd04b-97a6-3f79-16e3-9a58704f8e28@amd.com>
Date: Tue, 30 Mar 2021 10:58:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210330081441.61418-1-Emily.Deng@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN9PR03CA0768.namprd03.prod.outlook.com
 (2603:10b6:408:13a::23) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.5.65] (165.204.84.11) by
 BN9PR03CA0768.namprd03.prod.outlook.com (2603:10b6:408:13a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Tue, 30 Mar 2021 08:58:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e62a5b14-0e71-45b5-c943-08d8f35a0499
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1829E12BB19D7C86492E0E498B7D9@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8IlPrK8alI4nBGdLt1v0tBUrnVTb3YhxbprG0+t+OfvCg58khHpiiWyNwe7rBCjwHL3eyEVCvirbIoPyloBc2V0DKJm3QLfCpHDoCUfuHcUD0RCO9S30au5gag/ACTAVTQwMHMmP1+wua2FLqf1P4RzSZ+botlQGfa1mcBpuUPpzrNEMK1Zhz4eP6YGlSrm37Y9/rIG+aqLQUem8a6R0a70i7toIYJlEO1TNQIKMrEi71xzZDTBEclGOLQkRaeOBQL+XdlpB+m32oqBPQzyrTrwRc1HuyEJxQXoa/rxOJljgHSxqfeX0Zp3wP8GceFM05vz9yU5mJ9xcNrTHrRAUOdrJrlynXDReSluFH5TKEVN5s3EG+jOY1yKsu0aNtyyPTw9AQIScwL7dNIRRimlOK66oPJI+o+EG3ztKtA8oK3m+ORRxUYV/m91sTgxe/wSONlDvjr9fruOWOKiMemw3ESJTYiMfSzpHwejGcaelrF6UqlhezG07tBEv0QdXWrVLrFOeG1wrGtu2NdsDgMZgb/g50ojS1nQXVCrhDga3qtUriaT2xep2Z0zLFKWxq54YSDBemePhOfKhNJLSBYF3N+23/mW4Iw3H+GcsFvQXUNJuStXNp7V+gb3ipeGygto2RqWkopjHS0w2vKTBT1qfVbbBKgPVBaHM1tQq9CJeDmkpagaFTW8A3cRpbKp7V5M6dZCLwxB0S8i/rEskFesAlVS41rhfgy6qLxQL+43Vcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(38100700001)(53546011)(36756003)(2906002)(6666004)(31696002)(83380400001)(52116002)(2616005)(956004)(6486002)(8676002)(478600001)(31686004)(16526019)(16576012)(316002)(66556008)(8936002)(186003)(5660300002)(66946007)(66476007)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cDRIeXhmNzMxSHNpdFhSZ0VodVNzdTY1T3Z3MVBmVFpyeWdwVFVuNEFyVXBk?=
 =?utf-8?B?WWVKOWtCbkFXRW43ejJQSWJiZXZ5aXArWSs2RjBYcGZQOS8xQlRRMkhKM0FG?=
 =?utf-8?B?ZUcvdVRYUnlBclArWTlHZitsNDR2ZWlQWE5nNFdnZ2lyd3VYWHE5YlE5eDJa?=
 =?utf-8?B?Rzh0VVVkSm5LNHZIRTNLTjAzN0JHMWhNSStWanJHSnZIbi9QcVVCM0pLUC9x?=
 =?utf-8?B?ZXVjZ2xoc0tNQWJKWHRYOGtxM2Q5SXVSR3d0NnVMVWdvYlJlZUZFVVpvSzZL?=
 =?utf-8?B?Qm9DWmpoaHdCK0FEUldnZzdYV28vb3FlL2FNeFdHb0RaMUc4dkZlYTgwZU9D?=
 =?utf-8?B?U0U1RVVQanBVMVE5RHlJWXNkbVN4MU51SG9jVnZRYll5MGtEVFNOOFI2R0NU?=
 =?utf-8?B?ZEREaElDelVZd3pwZjgrYllTSW8rcUVqVy9ZWnRyYWlqa1p2aDA4V0EycUtM?=
 =?utf-8?B?ZGtjaG9vNm5RU0FzcEVPaWh4UDdEaWJ0UEdYM29obVM5M1R5Zk9waWtOUzlE?=
 =?utf-8?B?WVVOd1V0T0NOU1lmZlh4ZTRwZGhjZjN2U2tPTktxWHF2aEcvNGVpYmFqN1Zn?=
 =?utf-8?B?Z3UvM3dzNWpybE9uYnA1Qyt3d0dNMVRvc0dlM3JnNnEwTzBtM1ZyM0lZK0xk?=
 =?utf-8?B?U2xnVGdXOVhLcUFaL0RyZERrYkkyNzd3YVpIYnFIOTUxLzIyZEtLazJWS3Z6?=
 =?utf-8?B?bXRvcTJ0NFFPK3l3VitSaFRtMFVCUjhUREJNMzBSSFBDMVFJc1F5N05kb0FP?=
 =?utf-8?B?S3AyK0FuMU9FaHF2YTlmSVVxcUpWU0k3YStqVlB4ZXlXc0FENVRVNkNYMWJp?=
 =?utf-8?B?QkpyN3JiN28rckNaeE13NnVQMFNXZ1JUMDF1TThRMHFmMVlWL3dwTm9RVUVP?=
 =?utf-8?B?eDY1SjBZVDEzR0FQRElxdm4rREt6VUtOSWREQkJ3Smp4WWZSZ2hZcGd1TnM4?=
 =?utf-8?B?NEY2bXY2SzNNZUthZXJBWFJiTXNyM2pzMlAxYkhxRUN3WExZN2F6Z1J6V004?=
 =?utf-8?B?K3ZmNDZiRWdLUWxzaEpYSUJ2NWg3STZwNzc3NVRUMEgrRHBWMFRuWDhYUUth?=
 =?utf-8?B?SHU1d1Nvb1RDTDY1RVdwbWc5Y0VFVEZiSXEzaktNcEdlWVBncVdLQ2NjYzY4?=
 =?utf-8?B?WmlYVGlxOW9yUTJsVUY3cGt1bGhCMm52VzlrbEtoajBlVEVmUGFFK0N1azVE?=
 =?utf-8?B?bnVETlp6RmVOYWQyQUZMNnQ5dUd0bEt0TUE4aTMva21GTDlzbW1YL0tVMHdo?=
 =?utf-8?B?Z1k5OUJSRDBoVGsreVZvZkRjVGpVWE9YSExGNURmNUo1SHJHKzMxUUt1QWxF?=
 =?utf-8?B?UXVxZ05WcmZsbXlVQ1NSRExFTTd3cjdYZnl1d3BMbmhQZUdGL1RiVXhXK1dH?=
 =?utf-8?B?ODYyaDFBSXNLZ1BUb1dIb0pSWHhmMWxGMlVGMVFoc1FJTG9OUXdOdVJ5N0pK?=
 =?utf-8?B?dUx3M0huQ28ya0NPTmU2cmpSZzBsZGNhb1E4Qk9RNEpuVm9yQ0I0Z3lINUJo?=
 =?utf-8?B?dlZTL21JcXo3azF1TlExRFdEdFMxNlJ4Z0hlQ0xIdnhOc0FyalNqSG5TTHRl?=
 =?utf-8?B?VElDM3doeDlrRWNLb0hFQm1sVXE2ajVOV3VabVFBRFNKQWIyM2pRaUg3aUNz?=
 =?utf-8?B?WkE5Y3dmbGsvemhwSXR0cUlOQlZoMEFCcEROVmhEdnRCZmpYL3BvQmp5aTRi?=
 =?utf-8?B?OU9QQUI5VndOajZPWjBnRkZDdHpIWUdtT25qRUFZU3dIRGxBVnlzcmhnZml4?=
 =?utf-8?Q?lTkyU40gM/JrJQ31HsIghQPVV+6LWxrin+jqBNL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62a5b14-0e71-45b5-c943-08d8f35a0499
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 08:58:42.5377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFZ0le8vMj0hx06seOvyDE6MTXz1u3GFAqqDbLYnM+WP5KLU/RwIS6k1DmfxyH04G2j2m8woPio2J7hBe/0dEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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


On 3/30/21 10:14 AM, Emily Deng wrote:
> From: "Emily.Deng" <Emily.Deng@amd.com>
>
> After FLR, the msix will be cleared, so need to toggle it for sriov.
>
> v2:
> Change name with amdgpu_irq prefix, remove #ifdef.
>
> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index 03412543427a..3045f52e613d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -277,6 +277,17 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
>   	return true;
>   }
>   
> +static void amdgpu_irq_restore_msix(struct amdgpu_device *adev)
> +{
> +	u16 ctrl;
> +
> +	pci_read_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
> +	ctrl &= ~PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);
> +	ctrl |= PCI_MSIX_FLAGS_ENABLE;
> +	pci_write_config_word(adev->pdev, adev->pdev->msix_cap + PCI_MSIX_FLAGS, ctrl);


Why write 1st clear and then set the msix flag if we know that msix is 
already cleared.



> +}
> +
>   /**
>    * amdgpu_irq_init - initialize interrupt handling
>    *
> @@ -558,6 +569,9 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev)
>   {
>   	int i, j, k;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		amdgpu_irq_restore_msix(adev);


Is it possible to load amdgpu on guest without msix ? If so then we need 
to probe if msix is enabled.


Nirmoy


> +
>   	for (i = 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>   		if (!adev->irq.client[i].sources)
>   			continue;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
