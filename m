Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB03C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 10:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E243320706
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 10:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n2imISS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E243320706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 967536EA46;
	Thu, 25 Jun 2020 10:43:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F5C6EA46
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 10:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7206tt91tWIetmOZYh1GmRByrgEUeL9J1F9bZ8XXDH3Fkn+nMxXtLycmQ+IghH1+Gh1VWLnVQI3Q9eEDeU1/pQbnrw+JBxKiDH0wJgciIbNru8rTiihIgQusOHvEjhicw2rYtALwvGcqyTb/vK0tN3vPjqIrjazdt2X2MTkiQUPEsvLjjO6Iw5KEC3Zuw5DEyrUHRfEdiv95YRGZsKxwC8NNuBWvdPTTsHHRUwba8AefnrxQVQ+at7BrOH8cIBtxt+rXrcokb9gFhfHFUIV55cqgxHo0R2wOm67SbsUN11hRLsaKnB4ddUXXXbsmImFGamGzLweyuxybkLRGyLoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yav+JYeMkCpSfr8HGrf3JvM1VqAmlzAwFjpEwPQnClg=;
 b=kma/Q+zAi9N82HaMNhwh6kcG5GIK1JaTXdYjv5TvEk/AdgvV1YgjGBpnDhWX0amUCJlW64/A0WlD5DlB4PnrfLIIaZwTu0HtDDiPOcC6z2g9v5tqC5VFYQcH5dO0Xyw9z/5jN48pVQIeFR/73w80774w9SApFzoacCwyX14rp1MJJjePIVneho0KarHe6Lg62UwgBy0eGDZeiuOkYBKi4Ih7qSsAbLTgzJKc2BHa8KUUe8yVGjNEd4vGNCe8odiPTblSxNH7pvibNtOT09VkEVRbnybzej0v2xmPmOwO16yarTU+5bpN/PMKmENkf2bLMYcJ0SeaNcPSxdZ68J0DCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yav+JYeMkCpSfr8HGrf3JvM1VqAmlzAwFjpEwPQnClg=;
 b=n2imISS1C+9RyF9j2OKmZofecFarK3bmEQKhADxBnZLF++oPZyb/WbvLTHKdA5EBQhk885kV4ZTiS3n29lAsbyoyh4s2j81BTgD5NKkud1CjjU4T7vkd8+CdidlHj+9K06Z4NBaNYl/VyT6L0c5EIf/mLijLEupyWGzmXPC9zGA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Thu, 25 Jun
 2020 10:43:37 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3131.020; Thu, 25 Jun 2020
 10:43:37 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: call release_firmware() without a NULL
 check
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200623162637.26011-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1cdda34e-8798-7ec6-f628-7829216e58e1@amd.com>
Date: Thu, 25 Jun 2020 12:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200623162637.26011-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:208:122::34) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.119.194) by
 AM0PR04CA0021.eurprd04.prod.outlook.com (2603:10a6:208:122::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 10:43:36 +0000
X-Originating-IP: [217.86.119.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 56c93d91-04f3-4282-95af-08d818f49dcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB440174FAF3E8D5FE11EB71628B920@DM6PR12MB4401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:160;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZQYK792tFWIsoN23qiqwLnCqKQES029/i8oNYD+Dvg+M4NxgWJ2m8N8dBRx3ea7hUxv8nRCAVliFMpqnYhbwITytittyROW0/HvLrtTGK3t2mK/taoYbmP3kYxKJmzXdcQ+9M1AmAIIn6xi25ZxFNp+Di54mme6VDx6h6/liGteKQ7NwGXV5JkmyDjXy6JWRpyXc2gTmfNwDyzVFo1TP8i9ePGAyaK2h/0xdM33l06NYD1xoBsgCyza0SL7Rh8fJ+WK7AH5cBkr6o2nku6OqrUVbrYndqr/WxWfmAyQGbhdwIDbWRQTGFvXAAOXH8pYw730P7JuXI5gJ96qRqXH5BFkrhh/C0NcGovZmkJs3Lx8+2QXoRfjmc0v7Cjo20B5V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(16526019)(186003)(83380400001)(66476007)(66946007)(31686004)(66556008)(4326008)(52116002)(2906002)(2616005)(956004)(478600001)(8676002)(316002)(53546011)(16576012)(31696002)(6486002)(8936002)(26005)(5660300002)(6666004)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: h4xsmpKHKXeVD1ljq00gCIWlxsKefIYZ9ZtIO5DB5GQss4mv0JaJXjXA+7CgherEVCK+cGV05GAm4Nb/qXGkPo/girx7ChEPEdq4XkSXdEwftk26sjgBbFy/uzMKSKsJ6QMVPmNLR+l0kjIwUdsjH+hjrnAXbkWVjBgfEi2zOM3bs63kkUKd2B+TKlj1CsNB5qUZMjbqgArNLew9zh2GJxPAbGdCprR0/7Y8eWMPgYgeIA49SODrGFXHjU1A2x2X0M1nTXwVmz4BKkWWNQqa385AOWtEmOKxe2KUdJo+n+GW7hy0R1T+6iX+xBdnkN/ohR8CkonwKgMl/8fTJMw27iaaFS8SIxVN27IZW9pZIY0ggbdymuxggIvPeqjcE+Riyhgu7f4VOFu/CTr//p0GZFQ6lfnrNIN5K26t1i9H7QtPJgGfmrunveLI0LXr0Cz1Hh7Hq6IugOPirRWD7aPNrles3wSyAfHHdIxtvBSTcAI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c93d91-04f3-4282-95af-08d818f49dcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 10:43:37.3078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGypC8x1/Y9wsoXbQANrMdsLCPO4pCcXvH0Dt+SiT/4VvGuMrl1yM1uC75HryZm48lvNObLDot/jbGf20+OaLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping!

On 6/23/20 6:26 PM, Nirmoy Das wrote:
> The release_firmware() function is NULL tolerant so we do not need
> to check for NULL param before calling it.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  6 ++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  6 ++----
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  4 ++--
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>   6 files changed, 14 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2858c09fd8c0..a649e40fd96f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3380,10 +3380,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>   		amdgpu_pm_sysfs_fini(adev);
>   	amdgpu_fbdev_fini(adev);
>   	r = amdgpu_device_ip_fini(adev);
> -	if (adev->firmware.gpu_info_fw) {
> -		release_firmware(adev->firmware.gpu_info_fw);
> -		adev->firmware.gpu_info_fw = NULL;
> -	}
> +	release_firmware(adev->firmware.gpu_info_fw);
> +	adev->firmware.gpu_info_fw = NULL;
>   	adev->accel_working = false;
>   	/* free i2c buses */
>   	if (!amdgpu_device_has_dc_support(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 0723dee2958b..9342a9e8cadf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -196,10 +196,8 @@ static int psp_sw_fini(void *handle)
>   	adev->psp.sos_fw = NULL;
>   	release_firmware(adev->psp.asd_fw);
>   	adev->psp.asd_fw = NULL;
> -	if (adev->psp.ta_fw) {
> -		release_firmware(adev->psp.ta_fw);
> -		adev->psp.ta_fw = NULL;
> -	}
> +	release_firmware(adev->psp.ta_fw);
> +	adev->psp.ta_fw = NULL;
>   
>   	if (adev->asic_type == CHIP_NAVI10)
>   		psp_sysfs_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 58382646d962..2985c61bc6a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -559,8 +559,8 @@ static void sdma_v4_0_destroy_inst_ctx(struct amdgpu_device *adev)
>   	int i;
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (adev->sdma.instance[i].fw != NULL)
> -			release_firmware(adev->sdma.instance[i].fw);
> +		release_firmware(adev->sdma.instance[i].fw);
> +		adev->sdma.instance[i].fw = NULL;
>   
>   		/* arcturus shares the same FW memory across
>   		   all SDMA isntances */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 6751ad69ed90..1baeddf2f1e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1300,8 +1300,8 @@ static int sdma_v5_0_sw_fini(void *handle)
>   	int i;
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (adev->sdma.instance[i].fw != NULL)
> -			release_firmware(adev->sdma.instance[i].fw);
> +		release_firmware(adev->sdma.instance[i].fw);
> +		adev->sdma.instance[i].fw = NULL;
>   
>   		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 95751e7bdfe8..318d32e2bbf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -115,8 +115,8 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
>   	int i;
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
> -		if (adev->sdma.instance[i].fw != NULL)
> -			release_firmware(adev->sdma.instance[i].fw);
> +		release_firmware(adev->sdma.instance[i].fw);
> +		adev->sdma.instance[i].fw = NULL;
>   
>   		if (adev->asic_type == CHIP_SIENNA_CICHLID)
>   			break;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3badf685338f..4767f9ea0352 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1318,15 +1318,11 @@ static int dm_sw_fini(void *handle)
>   		adev->dm.dmub_srv = NULL;
>   	}
>   
> -	if (adev->dm.dmub_fw) {
> -		release_firmware(adev->dm.dmub_fw);
> -		adev->dm.dmub_fw = NULL;
> -	}
> +	release_firmware(adev->dm.dmub_fw);
> +	adev->dm.dmub_fw = NULL;
>   
> -	if(adev->dm.fw_dmcu) {
> -		release_firmware(adev->dm.fw_dmcu);
> -		adev->dm.fw_dmcu = NULL;
> -	}
> +	release_firmware(adev->dm.fw_dmcu);
> +	adev->dm.fw_dmcu = NULL;
>   
>   	return 0;
>   }
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
