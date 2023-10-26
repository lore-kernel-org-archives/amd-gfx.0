Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD37C0032E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 02:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE8210E733;
	Thu, 26 Oct 2023 02:49:45 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF45D10E733
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 02:49:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hx37Nx2l8qb8XxlByyDcOrjT+ExZb5JIDTo4/lWJTQbSQWa99wQtZt84rxbAXBzvIruNlXplfF4EpNKyvAKlVQ75W14fofU9+vOyv9qzhCwD1aaqVXvPlBeALDVlXo/VVHz2/2IEVVmf5wEKqdXITO460DWfQatSXKpqA9b7blIn6Jq5CvSURU+1x6EZfzOCPqs4Qdtli7x20X4yFZyXlyY4Ik4b8rjQ2STnJ1tybUWuXXK0ZNuVY79HGqPrMFD4TC9AWCApjMB6XZMVo4cNUSWVd9BLU6ie7Qk6ha5zZjco0EBgmbWAeiZ0IRv7D1ATJoyuQt64xk4vTSzMhSMaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzfeWN0iGe15T1btUxBR8oGC8hZLkWkXaAEmzMRTQ2A=;
 b=f3imNazVlaRSsmi2iL+hgoopon4ixjh9DiInlP5AScnsbaO4gmP+sTUFlFnsUQD971yopArALn9S5Igd8GmPEp86oCdBndS08Q+PYKqj7Mf6jsyW+y0InAYDOaV0OwyZeViScQiA2QqB07lxDcjTwOsVVrr/zM5tIVTsyUzfjARN0SUYMFSgYXwDbRjAQ+YhCkvmZO/0gsUKojebm60Kde+fY7z64w5V4igjXQZrYewLn1CxbtHTXnMfCXB6CRY2IRD6xJF5VsdZ/MRH2GTFbhJHxymCakB5mfHU2LJZ378hXE9A+H7JjcXiY/maJd8EhmGZ+TpkD6q/6T0+Obwdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzfeWN0iGe15T1btUxBR8oGC8hZLkWkXaAEmzMRTQ2A=;
 b=BBxbyZeDmVhJgu5OPeunvS2VNl8UYkMdgUNKQLyudyJx5Pj3ULBJEUqGWxgo7PrYKA/L+3JZYb1tWKSKIu0NmHKfhlFKE3EMT5YaiR1FPkTOc+B3oHe+smWie2LJK645cevGS4uTaAnoCfV69NuZEnl+ruijBAJZBIDxNIEKMdU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:49:40 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:49:40 +0000
Message-ID: <79a9a6d6-1158-53a7-40ec-b66f2c281c0f@amd.com>
Date: Thu, 26 Oct 2023 10:49:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amd/pm: only check sriov vf flag once when creating
 pm sysfs
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Kenneth.Feng@amd.com, Alexander.Deucher@amd.com
References: <20231026024546.1468900-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231026024546.1468900-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ef61c8-848b-48d6-0719-08dbd5ce331d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qj1s59S6fCfIbeIgeI29yo4CUSC2nwVxTa1H4VyczEl1ILpnr4w3rhIWMH3YVMNbQck48ClEW1Jbi0VpVXSW6n8NXdQKI34rTeKdS2z31SyQ4bWMKjmT+6f2sC105S9bfc2gp9hRMPJ56zFm3mtbegDQRC5hVXmPf+FVkUV1jtQzsjADTBwpvrZry6kNuPiWQ9Ao4xbenr0KUHa9F+Lt9d11L4QjIaxHUA/Uhbh3vcz+czZf9vXR9iUTfTWlnH3r1VN5MOlRQ0mMz5CulCxhW9BHGLwLjp8GxvyvzM1iM3kTPg6Ucl2U6besrJKWg5tWHbOIFcWbWzIpaq9lGmvXHHrzF/8wPHnKiW7ED5wBgKtcTz72Ww6bfAhLvX6q47c89KCsBGe0CB3cKctVRebitKVYokn8rGoNV3kMg6BpJbCB2bMm11/T+A4HFkdOfS/YMMa9S+CfU6W9YQrB4J1e1KHKATMiUPr+isd2lr/8Y1qfdxRkMErGz2xkeH1OCumlkdcAaOtyMPjn4cVj15Ya5wbdrcDH68CiZqqms6fdMrDl8TnrxQNLvb/vW/0xjuphnhP35OHItZSBRu7opKbGwIFuGjUTcxbM7AO0SUimaOpWgSr4TphD7hpJzaDeW1uvEIMhYBeoktecwR648WnvqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(478600001)(6636002)(6512007)(6666004)(316002)(6506007)(66946007)(66476007)(66556008)(36756003)(38100700002)(2616005)(6486002)(2906002)(83380400001)(8676002)(4326008)(8936002)(31686004)(5660300002)(41300700001)(53546011)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUVqQWxhWUttcFVYRFBFaW1CODNKbzFhdzY0elpXUGhKTUtxNEwwaUlBQTRW?=
 =?utf-8?B?L1VQQzBIUDJtdWNOZ216b0MrTWF3V3lyNG1UZjFpMmZZSEdOcitHV1FXVUli?=
 =?utf-8?B?NDNjN3VDNVdIMSsyNkUrUEpHZ1lTaVVoOWpQVWRTRzBPNGZIT0xjWCtONS9m?=
 =?utf-8?B?aDhrYTI3MVdMbzlDNWlzSEtUQWJvR0w1YXY1Q2grdzkvL3Evb282VDdvQjc5?=
 =?utf-8?B?STNNekVIQkl1L2JPUC9jSG1tUDQ4M0kxQVI3NlhWUDdMWlNnYTNuUWtGTWE1?=
 =?utf-8?B?WXBzUVFJUzg3S3k1aUxqcEtGU296RWdKUWhSbkxzT3ZMQkNBUEhqcWtLeG4v?=
 =?utf-8?B?WXBFbTVtSG1ENDFGZzJ0TnEvRGJWVXQ2NFFmVVltdmhCeERRb2twSFpPNlZI?=
 =?utf-8?B?MnhqbzF3THlXUmozc0xKT1RNS0tJZHdobTRhZ1dsbFNmTVlSYit0NzliWFlD?=
 =?utf-8?B?UlVYWlBDZUJrY3BuNnlGYnlVWkhrZEdRYXRQdWxobkdsQjluc2xMTnFQdkVv?=
 =?utf-8?B?MEJOTHVBYmhEWVlXOW5WVTJnRm10TUQ0Q3BaQlRBZ3FSN3ZoVFp3UkpTdDJD?=
 =?utf-8?B?R0dwTlp4Q0x6ME1NODdtc21XNWFtdko3ZGs3Z0tQdkdQQ05QUGVCOXpEbkFk?=
 =?utf-8?B?eFdBVStsaVRENnVVVkhrdG9NOGFHQ0pkMUNJQk5RZVIzeXhMTjFLNVQrSEFZ?=
 =?utf-8?B?NzJLczRBMXJWZGtQUmlHdUloR0REUURZOEZFZ1FKeDRDcURVMy9RVVNaYXRF?=
 =?utf-8?B?Q21uaTdVZUJicURkaXRwZlNNWUFUMXloK2ZEOTNOOUhadmx3VUdta3Q3TTFJ?=
 =?utf-8?B?K01sRFFWV0lTV0h2ZVNrNGdFWkQyMG9Qd3VCOUhpdkRNNWVER3ZobHp1aFN2?=
 =?utf-8?B?NVBXYk5KeGF5VUwvWXNZNTIrQlNSL2pMeG9WMkY2emUyL1lrTDhmek1Od1pD?=
 =?utf-8?B?Z3ZaUDdCcEtsNmlZVVJmSmFXZk8yZkFrMldhUHhSUVpzV3puWjlyaW1yckpy?=
 =?utf-8?B?Y2hFTm5Wc3YzR0hOa21sOHkyUkVyTm1DK1JDajcyZzBobFIySGZheDJtWFFQ?=
 =?utf-8?B?Y1AwVElkMEt4QUJpTXRKaDh1bU54QmYxRC9WMWUzY3VWOHBqS2thaHFXNlJh?=
 =?utf-8?B?SHZTYVl2d0k0aHBJNDZoaFZSSUtMdFVkcmVQNTZpMXVYcE5zRE1zSHNKZE00?=
 =?utf-8?B?am05TEI3RjlhQjZyY0pUQ2lOK2NQNGdVdU9RbmtEd0E0NmFHSUxHSVl2OUlE?=
 =?utf-8?B?dFUva1ZLSG5adDlTYlZFc0t5Q014TnJSTHphRGFybHR2RTlpMmV5dHk3ZDhq?=
 =?utf-8?B?WHdYbmYzZk5hSzV2MFRUalI0S3hWSUlhUDdpaG5GajR0YUY0UUwwYWZpSjNN?=
 =?utf-8?B?Q0p1Z25CQlUxUHNDeVFka2tCZ1FXR0tCc1pta2VUVDBWeGg4QkEvbGovOFZZ?=
 =?utf-8?B?SUpmOTBxTnM2d1Z3ek5lR2FOR2R0VXFRUVhOSmRSSWdwd0NucTdGV1I2c1ll?=
 =?utf-8?B?YXBLWFpJWDlIQmtsM2d3WWFPMFlPVkVST2RENjRTU0RyeURoOFhPcEdUMDBh?=
 =?utf-8?B?YStVNmZKb2lYWmk0YlM5S21RODFRWVFnVk9SWWNmVmdJbG1aTmp1UVdGeHdH?=
 =?utf-8?B?cmwrV1daZGpxMGJlRy82U2poMGdoeFJqMEp6WVJCbk1CWkFsWThsZkNwemox?=
 =?utf-8?B?WG5zUVh5YWRJL0hveDFQaTFBa2tTOEZkY2txN3gyMDU4U1JxMHB6ZTR1YmE4?=
 =?utf-8?B?RWRWK0I3ZWtaS0xMNGJubHpQbjlYbE9tUnM1TGxtWXZnN1llTVAyTmRadzZp?=
 =?utf-8?B?TCtVT0U1TzhBMlZMU2J5NWVtb3hVRGNPWmhITWliaWRFZEJMQm1paW1xQkhn?=
 =?utf-8?B?Y0hHR3pzN0RrRm9yMFd2bXdOTitpQm9rdmVtL0ZWajEwUHBxT3Q3WVh0WUg4?=
 =?utf-8?B?YzVXYTNrVW9iWVU0TWxEL3I2OXZTSGVVYzBkZUZQTFMwRUlTRGxvbE15VlZs?=
 =?utf-8?B?MjhjblhtUzA3ZU56aGpCQXJtdjUzTTh0RTU0L0FlcE14eVpQb0QvRzIyWDhD?=
 =?utf-8?B?NjVDSVYyME1YRG91bXp6amQ3WHVnbjRkUTFtbndEdGcxem9PTm00Y1lQN3hM?=
 =?utf-8?Q?JLFghc8yxPmzcEzy32K5zDdKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ef61c8-848b-48d6-0719-08dbd5ce331d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:49:40.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP/RV9xlNQM13eye4HMwufwRJbENndTDtM2FMd4++cPe6TLN7UtMbClOfccQsDF1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301
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

drop this one for some format issue.
I will send a new version.

Regards,
Ma Jun

On 10/26/2023 10:45 AM, Ma Jun wrote:
> The current code checks sriov vf flag multiple times when creating
> pm sysfs. So fix it and optimize related code here.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 358bb5e485f2..ee46d04549e6 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -3288,10 +3288,6 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
>  	uint32_t gc_ver = amdgpu_ip_version(adev, GC_HWIP, 0);
>  	uint32_t tmp;
>  
> -	/* under multi-vf mode, the hwmon attributes are all not supported */
> -	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> -		return 0;
> -
>  	/* under pp one vf mode manage of hwmon attributes is not supported */
>  	if (amdgpu_sriov_is_pp_one_vf(adev))
>  		effective_mode &= ~S_IWUSR;
> @@ -4162,6 +4158,7 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
>  
>  int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  {
> +	enum amdgpu_sriov_vf_mode mode;
>  	uint32_t mask = 0;
>  	int ret;
>  
> @@ -4173,17 +4170,21 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
>  	if (adev->pm.dpm_enabled == 0)
>  		return 0;
>  
> -	adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
> -								   DRIVER_NAME, adev,
> -								   hwmon_groups);
> -	if (IS_ERR(adev->pm.int_hwmon_dev)) {
> -		ret = PTR_ERR(adev->pm.int_hwmon_dev);
> -		dev_err(adev->dev,
> -			"Unable to register hwmon device: %d\n", ret);
> -		return ret;
> +	mode = amdgpu_virt_get_sriov_vf_mode(adev);
> +
> +	/* under multi-vf mode, the hwmon attributes are all not supported */
> +	if (mode != SRIOV_VF_MODE_MULTI_VF) {
> +		adev->pm.int_hwmon_dev = hwmon_device_register_with_groups(adev->dev,
> +														DRIVER_NAME, adev,
> +														hwmon_groups);
> +		if (IS_ERR(adev->pm.int_hwmon_dev)) {
> +			ret = PTR_ERR(adev->pm.int_hwmon_dev);
> +			dev_err(adev->dev, "Unable to register hwmon device: %d\n", ret);
> +			return ret;
> +		}
>  	}
>  
> -	switch (amdgpu_virt_get_sriov_vf_mode(adev)) {
> +	switch (mode) {
>  	case SRIOV_VF_MODE_ONE_VF:
>  		mask = ATTR_FLAG_ONEVF;
>  		break;
