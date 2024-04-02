Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F248CD1284
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Apr 2024 03:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CDF010F8A4;
	Tue,  2 Apr 2024 03:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vyMuCB3n";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2125.outbound.protection.outlook.com [40.107.93.125])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7901A10F8A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Apr 2024 03:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4dLjSHmWb30xGhspTn4NeYmq3Xd3p2EyBc6FdDkrQtqdbYgVF1SagZbdMM1ulMW8eZSPr7Jm+fVTlRR6go4WQ1f2FgtxDUDrASfUwSdjWLzK5tp09i/XDutSSrTag40Qb56eZiny1wOJ7BmYNHlldMmkJZIhW9XkbofNPxlIfEvnbLVUI9DmWo5+4zCgBTazK4dujQoAPVKVCxqv6wS4tYlQ/ySeCuclMVhWzBO4iYTFg/btxZHq8pEST9nBbbr+5TO2gcsPHOYTgiqflCo5KUt1U4DLCllcBnD3FpQbh1swQ6JYE+YysjAal3IWMbxPZCqtH2EcQhZOGWC4Wtf5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amEJ4mg4WbuLmjIhldZv0S0dwm0U6maKjOTmSmsOUaM=;
 b=Af6ZjsQvdK22XX5N1bZUXfaQj6igNUE5+78jfrccCOe0OakLh+1jwZwWIKWgMkRnjGmK0gNmDek3PT4+abZGeO4m6jVJ588i989VCKZFOO3lGOvt+lHTQoOjdo4FKrGFv8BTKEPRwTPjhIEI3fnNGtiGrSF7toL53enwjvEz/vum8IZO5oAJAv6VeKDA2qhjKCMU4A0BxTx9StLAFswAWTvPgLaDLvl0RLie1old5MbiXxDnTGKLUw0I6g7pYQh1z143eEpg3CN562nOu+38bdq2UA/mTD8dI3ehw/Qa268FoJhjntQbMCMcUY/+Rq0+eznHLE1gNyGuub5b99hsVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amEJ4mg4WbuLmjIhldZv0S0dwm0U6maKjOTmSmsOUaM=;
 b=vyMuCB3nsHC2MbB3jJAKvR1B06Omfs1WXwcMS55ghzs1ePVUb8KLcgJ5n4wfxPhAdtit4Sg+KfYHw1ujYMNGMDtRI7XJRHr3+bVvWTTmlzJ4F0yZ8vr+R3qv/gH8SeXXsqWe6mo3soWL7/2P40+hcJKzA4SD0ueF4U6Gny/zw18=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH0PR12MB5632.namprd12.prod.outlook.com (2603:10b6:510:14c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 03:43:49 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 03:43:49 +0000
Message-ID: <e90dc62c-7015-4e72-80b2-61c451f1a03a@amd.com>
Date: Tue, 2 Apr 2024 11:43:41 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com, lijo.lazar@amd.com
Subject: Re: [PATCH] drm/amdgpu: refactoring the runtime pm mode detection code
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240329082857.3082844-1-Jun.Ma2@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <20240329082857.3082844-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH0PR12MB5632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCj+JbLhg3VWAxjGJiIN7UsjlO9AToY/+ufp+j6EV1eqsY/JAoygSGiSdtPLj63RjZqVa0wBi7ldifmk1eIVV41wsq0pFpwb5v/pzxzCaOUOmZSotpBYfS72ACHzicc8Xyq2NfXREbyPq8yXk5+kufvBEDNpPQrlMfxkSrpHyDbyMqdWnaT4nFZMK3nR0VrBurZjpZw0yqz9dvGUxDwRnWcOIv47E7mD1ASxR1yr+QsBhfLnWE2Qs8usRLDJ1rrAJT4Zd/NTmWvsXBjy/3xuk+tYX6dLqAMVhrLWi6BdHikYAcffGHL5mS9BB7ZQTRwqBzTUwJfr+CpMwPoq3A7eMrW/FI9fV1QjrqzjGgkw2iJMsAT5sd12MTtCh6GBb+wlV09X0E/8DGV9cK2o43G7m2yLAA/Lylg7Q/8KanaQdfZsWlNigENzEWeByfQCTHdbw282aCRPdVr7yGEeLvXE3srC2Ag32W2pKln9OLQ7JfPXiY6hcDFH26eF3KE55qILNe+tEtd0i6pSpFNYD2IMU4SLM1ceJ/LofoXJsPxQzt8fNImhig12NSZ6SgX7GToHjZBs5gvJAMYXkBBD1+kaJJw9faxZ4ldwIPPbQz2nQxRC0KDgOOVB0flWr58y8p6trj0CIjNmt5+kJ5N7WhedQ/+4HTunnHItvHlxDsU8WoU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2N3WW5TcDA0NlNtQnROVWl4azYxSEgvVFVGWFZPbHMyMjUxUys3d0ltekVj?=
 =?utf-8?B?UkY0K0xjZzd5azhjWjFRWEZUOVgweUJMNzBRL2E3OFZFaXJsZmQ2eGlCdkRm?=
 =?utf-8?B?K1lweXBjSVNoNElQcmE0c2YxNHg5TG9VbWNaSEJRUTFRMC9BNnV6S3NacFpa?=
 =?utf-8?B?T3RZNE5EL0lyWC9WUHBvTENmeXp6SVNxT1BIU1FoVUMxaFM2aXl4UzJCcFFv?=
 =?utf-8?B?TEdQL0Y3dVMyeW9ZVWJmMDdBU3RsTWEzZUlUcHQyK2p5SDRpMDNaSE9FZU5W?=
 =?utf-8?B?ZEh2b08wdTdYMmlkcGZLTXRzNFBTOVUraXVvdDA2dGduaWhKd0wrcDFCOHB2?=
 =?utf-8?B?T1VLbGo5a2tvVEQ3QmtUNUdodGhHKzY4QmNOR3paekQxbm5xVmRxS3kzTTJ2?=
 =?utf-8?B?L09zd3lsa2F3V3k1MFJ2djJDSXV5Yyt0V2I4Rzl2L2FJZk9DeTE2TmsrbFNT?=
 =?utf-8?B?bWNMY2FhMkVwQ29kQUk2U28xRnFRS1BPSlF5ZEs5MFpPVXlVY0lPRmJCZ2NE?=
 =?utf-8?B?THZ1eTZ6bWR2S1FISEtMN2NMTDhoSDNyb2wva0dLMEpCZHdFblI0amV3Rytu?=
 =?utf-8?B?dTdkNGh1Y3lTdUVuYVpEbVlSSDROTVQvTVkwdGNIaTlYU0lDWFZkOFcvdVgr?=
 =?utf-8?B?djFZK2JzR05XWWEyM2U5VGtIbDhmQVNZeFZoQzlscFdMZmlJbXBobi9KSFZQ?=
 =?utf-8?B?cGxmODVRQ21ZZHF0cnlhZWxiR1JJWWVQTGlRcnRzQWNtMWdYRDVKamJaYnpD?=
 =?utf-8?B?dG1LSzZpZkR3OGtUTTN3YURmckJpcGhkUlFCY2lTb1dydDVobk5yOEhhUnVZ?=
 =?utf-8?B?SVA4RWNCYzNUVDIvMEdqL3kwZmh5c0FUMlVWMHh5NGRHcVVjK25yMzB4SWhK?=
 =?utf-8?B?OXZZeTNyNE5YZ0lDU3A5NGIyMEZFSEQ2UUFHZ1dMZHZhZTkySDlpTkxoRGF3?=
 =?utf-8?B?VS9VRVF6M1lTWi9jRWNiWFBmeTdSTjRvdnE2TTR5Ny9sY3piTWw2U24wZytD?=
 =?utf-8?B?anpmeTJzR0dGSUovRVJTbk13ZjVpem9oYWRic2cxMXZZeDJ4VlQ1M1FnUjV2?=
 =?utf-8?B?ZlNPNmhxcGhwbVR2UW1tQU56WVRORll0S003cnl4b2VEQTYvbForeGl6U3pL?=
 =?utf-8?B?MGo2TVd0VnhsT08xQ0lhOENqaE4yZUxOMnU0ZHRpNktsYi9YUzRHWS8xNlow?=
 =?utf-8?B?Yi9CcTlPbzM0SWRzSkZGQzBmUHVSTkhTV0wveFVBNkdNUGdaWUwwTVdXV052?=
 =?utf-8?B?TWp0R1pQczI2emdGUFZvMEdWcTNCcVhoYVNyVlpBeURPN2pSZ0lib1pMdVg3?=
 =?utf-8?B?S3phTFZPWC9DK0w5NnJQZkZ1ZWNQaEdvbjhQMk1vc3pLOThEK1V3QVgzYlU5?=
 =?utf-8?B?TjUwckM1YVFsL3BTaXcza2JYRThJcW1xQlQyMTl5Q0Q4UmR4MTVtNkNlMGtM?=
 =?utf-8?B?dTJ0TmVzL2FJdXd2ajdDRG5mMXRsV0tELy91bExJRVErRTRSMWdidC9KakJJ?=
 =?utf-8?B?U0FlRTJhSTNTa0NZUmpEeWRoRDE1c3NDbDlsZ3ZEd0xrNjhKU01MSnhQNWdX?=
 =?utf-8?B?Z0cvN3VTMGhNRWY1Y052dHV6MERGVjJLZ1BaWWRPUHRTdWZOOEFkaE1jcURO?=
 =?utf-8?B?T1BoWExOZG5SRXJDMWpTVXMzbEF3dTN0TlBCSVdFei9VTjB1TytmOE5tZUpv?=
 =?utf-8?B?aWJQb2ozdFQ5emdzWmZEMmw0cGlMZzNreHVSdmpRWEtJODdwSHlSMUpQMk1l?=
 =?utf-8?B?KzlSMGtTdVVlSHZZR21reWJ6OFhQbmdUUzhUbGVndFBQd2Z3dXhOWVFWdnBN?=
 =?utf-8?B?bTVwcmk3cWo0NWJBNXlUemwwbW1YTWpLZkRtWHJZOHJKWTRnUXl4M0VSaVhF?=
 =?utf-8?B?Z29PNVlGS2VlYnBsMXRkZTBXQlJTTU5xdmhRanZORFE4YmIwWnNNM25PUUdz?=
 =?utf-8?B?WDJwb0RXSHRIWDFOQ2NWNFhUNDNaY3htcVE5bHNMZEloT3lEWHZJOUZHano1?=
 =?utf-8?B?UjBxRGxWMkhqclpJa042V1FYSm9SRFlxbmxySXJ3ZkZYN3NabG5hci92UGpQ?=
 =?utf-8?B?dzdOdDNWekhuRDNhOThDb1FWeUJSdVAvcEtUZU5DS2dScDZ1WUR5aHBhZWhs?=
 =?utf-8?Q?8w5k36MQjAe45r8eWIPhikxii?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6303ddda-f3e4-4ab7-7286-08dc52c71b1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 03:43:48.9594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOwsGTzDKgQpKJNGeJ8kzryEbmyRfOoOk5Nr1bpRvjCuVh6BbHyYOBbh+J5Oo3E/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5632
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

ping...

Regards,
Ma Jun

On 3/29/2024 4:28 PM, Ma Jun wrote:
> refactor the code of runtime pm mode detection to support
> amdgpu_runtime_pm =2 and 1 two cases
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 68 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 48 +--------------
>  3 files changed, 70 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3723235f5818..4358d8c630b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1408,6 +1408,7 @@ bool amdgpu_device_supports_px(struct drm_device *dev);
>  bool amdgpu_device_supports_boco(struct drm_device *dev);
>  bool amdgpu_device_supports_smart_shift(struct drm_device *dev);
>  int amdgpu_device_supports_baco(struct drm_device *dev);
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev);
>  bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  				      struct amdgpu_device *peer_adev);
>  int amdgpu_device_baco_enter(struct drm_device *dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 410f878462bc..ca117f2666bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -350,6 +350,74 @@ int amdgpu_device_supports_baco(struct drm_device *dev)
>  	return amdgpu_asic_supports_baco(adev);
>  }
>  
> +void amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
> +{
> +	struct drm_device *dev;
> +	int bamaco_support = 0;
> +
> +	dev = adev_to_drm(adev);
> +
> +	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> +	bamaco_support = amdgpu_device_supports_baco(dev);
> +
> +	if (amdgpu_runtime_pm == 2) {
> +		if (bamaco_support == (BACO_SUPPORT | MACO_SUPPORT)) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +			dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
> +		} else if (bamaco_support == BACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> +		}
> +	} else if (amdgpu_runtime_pm == 1) {
> +		if (bamaco_support == BACO_SUPPORT) {
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +			dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> +		}
> +	} else if (amdgpu_runtime_pm == -1 || amdgpu_runtime_pm == -2) {
> +		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> +			dev_info(adev->dev, "Using ATPX for runtime pm\n");
> +		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> +			dev_info(adev->dev, "Using BOCO for runtime pm\n");
> +		} else {
> +			if (!bamaco_support)
> +				goto no_runtime_pm;
> +
> +			switch (adev->asic_type) {
> +			case CHIP_VEGA20:
> +			case CHIP_ARCTURUS:
> +				/* BACO are not supported on vega20 and arctrus */
> +				break;
> +			case CHIP_VEGA10:
> +				/* enable BACO as runpm mode if noretry=0 */
> +				if (!adev->gmc.noretry)
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +				break;
> +			default:
> +				/* enable BACO as runpm mode on CI+ */
> +				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> +				break;
> +			}
> +
> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> +				if (bamaco_support & MACO_SUPPORT) {
> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> +					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
> +				} else {
> +					dev_info(adev->dev, "Using BACO for runtime pm\n");
> +				}
> +			}
> +		}
> +
> +	} else {
> +		dev_info(adev->dev, "runtime pm is manually disabled\n");
> +	}
> +
> +no_runtime_pm:
> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> +		dev_info(adev->dev, "NO pm mode for runtime pm\n");
> +}
>  /**
>   * amdgpu_device_supports_smart_shift - Is the device dGPU with
>   * smart shift support
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 5d1b084eb631..924baf58e322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -133,7 +133,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>  int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  {
>  	struct drm_device *dev;
> -	int bamaco_support = 0;
>  	int r, acpi_status;
>  
>  	dev = adev_to_drm(adev);
> @@ -150,52 +149,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>  		goto out;
>  	}
>  
> -	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
> -	if (amdgpu_device_supports_px(dev) &&
> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
> -	} else if (amdgpu_device_supports_boco(dev) &&
> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
> -	} else if (amdgpu_runtime_pm != 0) {
> -		bamaco_support = amdgpu_device_supports_baco(dev);
> -
> -		if (!bamaco_support)
> -			goto no_runtime_pm;
> -
> -		switch (adev->asic_type) {
> -		case CHIP_VEGA20:
> -		case CHIP_ARCTURUS:
> -			/* enable BACO as runpm mode if runpm=1 */
> -			if (amdgpu_runtime_pm > 0)
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		case CHIP_VEGA10:
> -			/* enable BACO as runpm mode if noretry=0 */
> -			if (!adev->gmc.noretry)
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		default:
> -			/* enable BACO as runpm mode on CI+ */
> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
> -			break;
> -		}
> -
> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
> -			if (bamaco_support & MACO_SUPPORT) {
> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
> -				dev_info(adev->dev, "Using BAMACO for runtime pm\n");
> -			} else {
> -				dev_info(adev->dev, "Using BACO for runtime pm\n");
> -			}
> -		}
> -	}
> -
> -no_runtime_pm:
> -	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
> -		dev_info(adev->dev, "NO pm mode for runtime pm\n");
> +	amdgpu_device_detect_runtime_pm_mode(adev);
>  
>  	/* Call ACPI methods: require modeset init
>  	 * but failure is not fatal
