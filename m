Return-Path: <SRS0=vd7l=OL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB0C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 14:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D785661159
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Sep 2021 14:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D785661159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8166E989;
	Tue, 21 Sep 2021 14:12:49 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC156E989
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Sep 2021 14:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHd/De30expKH1spWkbNkevfcpFxZlihrdz1nfwGnx+4n82uMaAeDVqGrRaKWSpxW5ezqwjyYEoFxuo/o7qv3zDb3jqV5AWGOFcvfmz/LTfI7KfqCPiLQcNioWeKaHfgvjpUtkZUJieci/1XkvjvjZREnUJA80pL2+TfHfl6cT1wzexuoUMb8BSvd8JadoZ59vM6OV0fR/d1ibJt/6S278q0XmamNGn2MYoKBLNyoHZtM0iK8vScl4rKm/SvI/7qZ7LAL3tKAVG3g89IBgytME9dO1Y6UdE4E2pTi8hGYx4VwLqqgXnLd79Vd2cm5tFP+lV031eNKgPjhnwixLjcTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=hf9uLt1I/UXxc3ucsxGqa3iFj+DO3kvLRT1MNIKobig=;
 b=eViHih0PkhwfOlkVHRG02IvxCWNPHGp8CnGXF875cN081qEtzmzwdvgK8lpCiNdnYrSqt9p3NzddU1xDlLcAKTu9877724U4r4OKcTVCGVCrMR3eB6q+uyUdX1USwGoP4llwuM/XfefuX1JkZM+jlG27YHl1OJ1417cFQL/g2ZbTwNV4tiB1IVYkMFTqYakiSkXHysgJ96EGKHB+cIfjBjyNFgnEBLtq6Oo/1cK70YOOOTOVUvGAE8cv+XNWwtYAvJlZCas2HzLnsr0rH903i6ymUeT8+A8UkDpLXi9vdrWPMNzIbsMTYViT1VkqxYxos2+faHUb87fp5cIV+OZbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf9uLt1I/UXxc3ucsxGqa3iFj+DO3kvLRT1MNIKobig=;
 b=jQU3qfYKyBePSPQ1BdwaEtCGJuSw2BcyD0YXxhF5xh88ofM2s2okWqNaVkKClHrp/idPOkh0uvJUTPFEhSpPvnWoMOylXiqV9I0ZRGor1EPD6tbtTtOKQtnRNpnvGhNwfu5WduYoOMMld/PhPZMmlO+cfmnHEPeI42CYo/2mRPs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM6PR12MB2763.namprd12.prod.outlook.com (2603:10b6:5:48::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 14:12:44 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::3153:3d7b:e216:74c0%11]) with mapi id 15.20.4523.018; Tue, 21 Sep
 2021 14:12:44 +0000
Subject: Re: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to
 fini_early stage
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>
Cc: "Shi, Leslie" <Yuliang.Shi@amd.com>
References: <20210918060909.8068-1-guchun.chen@amd.com>
 <DM5PR12MB246933AF573AC62992B7BACCF1A19@DM5PR12MB2469.namprd12.prod.outlook.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <d5bb0cba-8952-7c39-0073-8c3771bc5c29@amd.com>
Date: Tue, 21 Sep 2021 10:12:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM5PR12MB246933AF573AC62992B7BACCF1A19@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::13) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:591f:ecc8:119a:23e7]
 (2607:fea8:3edf:49b0:591f:ecc8:119a:23e7) by
 YT1PR01CA0074.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Tue, 21 Sep 2021 14:12:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 184da69d-f8c0-49ae-d6ca-08d97d09e167
X-MS-TrafficTypeDiagnostic: DM6PR12MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB27633AC92855D82D8300F806EAA19@DM6PR12MB2763.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRVmEtgjxAKRVH7kF5oAVp1tV/1QFFYjzbPGCA2De01Vkq4VYpzAT5615eQtsUsYkOGyRuKkZcdL3NhIPMmHe7p7w4Q+pYOAfRNAmyo3X4YQiNk7ZzEi9/hohre1iFdWV2B8w3Oayer1A82B3E1acYYgNT78fLiOr3tFC0GDzYbD07/Wx7WqLE42STo6yTIP0sTWjkUxokLeVkGr3khcC9SkXqhwAT5DQybqWeRXENdXJIMKdGZWuEDVZfk36ICwfJHneFEmKjwbhb9aR2avlycd0FgsUb6qabTtWiry/7c9WkcHx9fmtniIFR2ncQzqaHNtznGelKYO6NuQ8rt3fLcs0Wv9Bi1PijVokwEQ3FBvfIRihThHS+D/5NVzOoKxXtFLjzwlkrn57IE4KjS+OBQRM38JzVEwXeXn5dQVOPo47gZhyiN27FwUzQy90L+OoNI1MeDOZSTBE68BRENRcenCERZ1G4Wcq3qLnQJHaJ85qAZEFh3zsW3McgupqhWAt3Lidd+1lWxLJfO0SoLVwpSGPs82mteTDfes1Yu85td1OBpyH/vVIfI15jxtkfSp5TiOPvoBVvSbw04NsO3RAQn/G+mqi3lbvu/UZzUjMVGDnuhjJcw+Bgslq9pyA39oKMfDrCe3wFC1z3vfZzRVTn+hXO0+GAjNLtFWRWXMSjvXFzC++78ZR0HcsC62dFe+wsrR4B7CN13ywja/cGqvGlBHS6ecbPD5c1D/QutAVjsErHwXfe/tR3Q7xfox6W++kyNMou8InIa03UqUGI21tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(110136005)(4326008)(6636002)(44832011)(2616005)(66476007)(66556008)(5660300002)(8676002)(38100700002)(508600001)(86362001)(31696002)(8936002)(31686004)(83380400001)(921005)(6486002)(36756003)(53546011)(66946007)(186003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXZwc2k4TDNhMnpNUDIxdk1QeHBFeGJaeFVVRFNMUGZhSDNETEtSSFRwbk5J?=
 =?utf-8?B?Tk1idG5aV0VvdFUwdmNRL0srSGtyRUN2WEdyQnN4cHpkOGJlTW1iSThZb2VP?=
 =?utf-8?B?dE53WXJRK2h6RUVMVDlDcnpwdksxZ2NvdnA3QzZjYUpXVDRWSWFNaWE2NmMr?=
 =?utf-8?B?S3IrK1djWWlvempJY05wTy9pbmZyTmZoRkJicEpDN0ZpWW0zZDIxT3UwWWo3?=
 =?utf-8?B?MVpCWVk5WVg5UmxrMDNsYXNZRW54cGF0Vnp3WWM4NkFXbDNHNm5ZK3d3aVJm?=
 =?utf-8?B?aW1Hc0lEODhBa3dNbDAvakRtam5sT2dKaUV2eXh5NFp1NmMwL2tmU0RlTDlj?=
 =?utf-8?B?TmM0UlR3S0dQZTZMK0lGRUJEbm9QZmhwS2RKS0x0RFZPNWhYc0N6OTNWUXdN?=
 =?utf-8?B?dTJZVEt1Y3NHbTVVeWtDRVRScHZzL0VTU0phM21qalJJWDZLbnlvTjVzS1lF?=
 =?utf-8?B?QWVwWFVJazhPbUpUQXVidkNyQlhPeHJKMWtQRk9lbDlKWVc3RXFtYkFxMXU1?=
 =?utf-8?B?Yll3OUJqRzNrSnA1clV0YThsaHVXRE9lQ2RERUdvREpmcmJFdmI5Ylg0d3d2?=
 =?utf-8?B?YTdDbEljeU42MC8rUzBMbUppSVB6NWFDcTBnU1p5NEd1aEk3TUxNdUYwYkZY?=
 =?utf-8?B?aVVoazBtOTVTNm55ZHFTOHNGTmo0RWRhYkl5dzRDTGJLUzJLYmtPNmtHMGs3?=
 =?utf-8?B?WTd3QWR1amkyUU90YjFPNlR6bi9Mcm1aSTRPL2RzSXh0ZTJTa0JkdklyN3Jv?=
 =?utf-8?B?UjdWdzF5Q0p3RkNoU0p1MnJIWTlITG1sRTExcFBSQWNhdzU4NE96Sm5xdU44?=
 =?utf-8?B?anIwaXg5WStWTE92Nzl4WmVMaXRCMERjUFd1MktaSy96U29oN012UUdZc1JG?=
 =?utf-8?B?U3A4WGZLV3loNXZaNGxydWdkcTFvMHhYMGJiRzJKbTY3ck41VldkT3Zqb3N3?=
 =?utf-8?B?Y2srbnRqeTN4Y3Bpa0VtYmw0MkJpWGlnWWYvWFRqOUFHQTV4Zjd5QlhTV1JC?=
 =?utf-8?B?Tjh2VWwyY2JVZUlGd0Evb2w5TU15cTQ1Mk00M1lrTFNCa09XbHBYSCtyV2l0?=
 =?utf-8?B?TjFBWjFON2NldW0zWElpWDRyOW9MUUNTbFZHNEhZQjRudUhzYS9WL01WdUF5?=
 =?utf-8?B?TTM3ZytRbENrcVkvOHJiZyswZm9TWUp1akxQdnN6YXlKajNUV09pdzZUNzFL?=
 =?utf-8?B?Q1dCc1BUMHNCQlBRWDN4eUlTOXRRS3lpcFV3NVhrbE1vQS9GT09XZWF6dUVp?=
 =?utf-8?B?QW5IZ0ppYkNZaFlYY1IvRWNkcmt4dmJPOW5wZ2djS3JpallBelRZNU1zbEo0?=
 =?utf-8?B?WEs3Z0kvUTFTUHZCRTVPM2JyNmxhMmhVZk1HWC9tcEluRWN4NzhIN3Y0cU9X?=
 =?utf-8?B?c0FzcjhnbjNaWWNDb3FxWk1ueGgwQ1p5cXo5NTNUeGx1TER0NGdwM3pqajhD?=
 =?utf-8?B?TjVKbVpqRVNsaWRta3dYWHNweER2a3ljTldBVG5DaGw1blVxVFQ2ckJpeTdO?=
 =?utf-8?B?aWFyWjNaQkpUbnI3Sm5Rc3JITzJaUXpnUE5ZeVp4UU5IUitvMmlHU0hMdDYr?=
 =?utf-8?B?NEkwVUgyRzNBZjVkRlVGUXVwNVBSNHBxQWk3L20xV1NJZWVqOG5HN09taWZ0?=
 =?utf-8?B?WkJpd3dQZG9WQmk5TjRyYXVraVZnMDdJanVwMzRPcjFxQm9IRTlReVZLb3E2?=
 =?utf-8?B?UXUxMUpUSUNqbEVUd1hLTmZZK2h4YVN3VThiZzVFdEw1K0pQMUNsRGhXL2ZK?=
 =?utf-8?B?UTc0cThiUEdlSmRjOFlrSGlCenY2RktBRGQ4VmhEandDUlpZTzF2U0hQTk9z?=
 =?utf-8?B?ZjNGVkVJRHYxS1o2Q3lpZHdIS3ZLaS9lRjk0bGp1aEhDT0ZOLzN3SExIN3hi?=
 =?utf-8?Q?zy8Rlapvu8NvZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184da69d-f8c0-49ae-d6ca-08d97d09e167
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 14:12:44.2161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2j6K78B5zV/Nhee8aMBO0KA1SowJCH3yu9FEgv0X9ylgVz9MIBe65GMixPi7bGIV1/qLm35YmUKGwpi0aYq7Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2763
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-09-21 9:11 a.m., Chen, Guchun wrote:
> [Public]
>
> Ping...
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Saturday, September 18, 2021 2:09 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Liu, Monk <Monk.Liu@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>; Shi, Leslie <Yuliang.Shi@amd.com>
> Subject: [PATCH] drm/amdgpu: move amdgpu_virt_release_full_gpu to fini_early stage
>
> adev->rmmio is set to be NULL in amdgpu_device_unmap_mmio to prevent
> access after pci_remove, however, in SRIOV case, amdgpu_virt_release_full_gpu will still use adev->rmmio for access after amdgpu_device_unmap_mmio.
> The patch is to move such SRIOV calling earlier to fini_early stage.
>
> Fixes: 07775fc13878("drm/amdgpu: Unmap all MMIO mappings")
> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f3da97086f7d..2a75c09c4884 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2810,6 +2810,11 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   		adev->ip_blocks[i].status.hw = false;
>   	}
>   
> +	if (amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_virt_release_full_gpu(adev, false))
> +			DRM_ERROR("failed to release exclusive mode on fini\n");
> +	}
> +
>   	return 0;
>   }
>   
> @@ -2870,10 +2875,6 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
>   
>   	amdgpu_ras_fini(adev);
>   
> -	if (amdgpu_sriov_vf(adev))
> -		if (amdgpu_virt_release_full_gpu(adev, false))
> -			DRM_ERROR("failed to release exclusive mode on fini\n");
> -
>   	return 0;
>   }
>   
> --
> 2.17.1
