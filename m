Return-Path: <SRS0=ZtFC=PY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB22C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 02:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBEC61056
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Nov 2021 02:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CBEC61056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1469D73B84;
	Fri,  5 Nov 2021 02:03:14 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F8573B84
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Nov 2021 02:03:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjRzDuJM8YBqXQii6jVCdCjDlJhbgRh2eXdKYMdYORACPTa8xlOIGsDsSwjXStbtvlxoZmC8vrQULkmSbOE+XHZXRQeaB830OjCcerSGdCtj5NzbLJZVzerJUCgkhdiH13gxwUPafRi0gNxC82igS9qxW3PJdjvZXKnjWxE9ediW8MMrBHkNDK+IDH95+lOzwSaYFZGWlmkgzC6x0UweDB4L50keJBLaDlyvUlk/QrtmPexqfBcCkSP8Y2so/gTaE6eib4MBexQO5/260UC+mV7OnZ4AqX5q688yy48C1uM2ez8B23Hc7qiy37xelB1CbV9fFy6LUtOePDIdqp2mdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9wpRdxNVf0vCucDh3Hpf4jW0CO4pfd/SfOgfFOsSHU=;
 b=YVrH/iV9JVUbzMlbwdocq7K9K0nVx/WDBKqAWSNXWoyDjTMwdRZf9tzzVvWSgl1KqMpGM83cHFXipRYP4w02y6Z9Py6PieSk4MOaYobSApjC5lgiSPtkqYl9PpzUbON0dNOzwGrKQt+CmnQaq0Ls1oTGuEFQ5vXlYJ5LQHcaVeLP9/SO//iQPVPFqONQbYNvmfMTvj0QHsvFmiUbQ2vwWXv9soff5PDmyijojmtODSdTz5RzlJSVI1CrPZkyzZHorRlga+k5vutyspALY+KI+wRYxr2od0EruUIrol7rRkPjL8+jlx/hb4xgGyO5C7eRS5UnloaUUmTFWb+Zz7ptRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9wpRdxNVf0vCucDh3Hpf4jW0CO4pfd/SfOgfFOsSHU=;
 b=eQQSDxr2Nl13umX7wzgLP1KyNUKgXbogsmft62r1cZ2d0zkZ4rgTDGjZ8ZwbauF0XZk5R805+BON3otHp30pxCUpcy7pRf73xE6JZky0kr4tmE6gVs5iHMPflT0Ky1oojiRHBFvhmksR6XbMMRISVvQs04AKes3q6XXgg+bA42k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (10.175.88.140) by
 DM6PR12MB3019.namprd12.prod.outlook.com (20.178.199.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.18; Fri, 5 Nov 2021 02:03:07 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 02:03:07 +0000
Message-ID: <89b93be6-75f4-eb32-1772-23c52e86956a@amd.com>
Date: Thu, 4 Nov 2021 22:03:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] drm/amdgpu: fix the Carrizo UVD hang on system reboot
Content-Language: en-CA
To: amd-gfx@lists.freedesktop.org
References: <20211104081931.467399-1-evan.quan@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20211104081931.467399-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::20) To DM5PR12MB1884.namprd12.prod.outlook.com
 (2603:10b6:3:10d::12)
MIME-Version: 1.0
Received: from [172.27.230.192] (165.204.55.251) by
 PR1P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 02:03:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89f35e6c-8a50-43c1-1576-08d9a00068c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:
X-Microsoft-Antispam-PRVS: <DM6PR12MB30191869AEAE0C82F01C81A1E48E9@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1y7n77aQn8JyKxktoNK4r1q02Ryn37saag9wX3mN5KTL7XOG8ICYnGMHbdf4dRsZQvjK+uxC8eZyMnd24O5OZGvdLwOlZ5FpAULXSuZuTaLQjTekPtwL2vYNkmKO8C2YRT2dZ299kEAAVPRgoTCadNhJbca+OZdLEcdgV3CPRUJ5DR4r5xvYtuA//GqVU2Of5EReHfxqfNsheoYIaO8QBHLSgInKMI4/ta7q/eZCNVpDWOS9c664PrRE0HQDZOA2dl0I3W7PnsbRRopQQ99oRdg3uXO5Dl1sA9Ovv9/1fGljUrQnF3PsndVhGLWqBofTxW62HARlt392TtwlSQRijd/hkVjWLD2avcLa4/IRpSW0TwPlBo7stB3n9ovT7j2RGhzoh7SBWOr/j2XvpWi4Bym8ZZvC/2qU6faX520v4PX/DRA6aPCQvtc6PR6HitFOr+LIBFUyO3pys/PZJMS1KSYxNJJfrMAHRMI4Tvgqrtz5XZtRsIx2x+/xgftHrOgJ4ibNNKi2CyQ0hEWL6UFMrsxxQNIuoW4qNDXm0/v9UrxUFbCthXkSCQIWi3HkgDesmx/QPcYVfP2A2nBYjjXftSVfpF60HsxZLHXRQYtg7TL4NWdJeNFvM4uTafKerlaSe1Hn4nSTnp2BERjnFGKPxLcmAmTgCXVo4BlJ6aVN3oAXEYsRWNJBKdCJWrkfY66dcxnRVsoRSqtpzL6tcy5TsKOEpD7Nrffo9RNggoxq7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(38100700002)(83380400001)(53546011)(31696002)(66946007)(36756003)(5660300002)(66476007)(66556008)(26005)(316002)(956004)(8676002)(31686004)(6666004)(508600001)(6916009)(16576012)(2616005)(8936002)(6486002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZuRTNKaFFWZ2ZKM1V4SG5hODF5aUI1VlRzeXR1b0U4bkV5d2lJNEwwRFB0?=
 =?utf-8?B?RXZRcHNHVVFzVndibm5TYkhidFZnNnp2dWkyZTRpeHRBZFdycU12c2c0cUZr?=
 =?utf-8?B?UEFSYk5Rb2RKZ2tFMGVpZGVPT0dBRXFBRFhyLzhJdFZuM2hSZEhacEtxVzA0?=
 =?utf-8?B?RWlRM0FRR0twNEpTRnkyMjJtTlRnZjJhUy9KU3gwTUxIaHByU1lQTTZPSVJK?=
 =?utf-8?B?Q0ZOa0pUOE9KcmhKSGlhMkpjanJobGp2Uk1pYUJLNVEyL29TZUQxZ050Z3Zm?=
 =?utf-8?B?UTFCdXcyR1BLcUxuT0J1cVhRSkRUby9qVmlxNlRYTEpWU3g1ZWxEUkMxOCtr?=
 =?utf-8?B?S0U4NVgvQWpNaE9qSEd3UnVDUFhaVW5ZMUlhOVlGNXIxd1ZNcXlKblpYOHYw?=
 =?utf-8?B?OVFnSjFkMWliMmhxblhSUStJWEQzM1VPYm1NUy9Ld2hqUlpnK1BucERmSTND?=
 =?utf-8?B?aC9QUXd0VmxmTGZZcVlVR3ZtNHhHMXd3WDg5M3R1MGQwZWVxMllLVzlBUVFN?=
 =?utf-8?B?WXQ4U3pRbDRnZGVoZExWS0xVMVJDM0FLak5HL3E2OHEvSFZUd20yRGNPWHBV?=
 =?utf-8?B?WHYreGtrUGV5K25YVWdESnhUQ3VYS2NOUk40M2QvSElFNHdvMzhJUzEzeDFa?=
 =?utf-8?B?eDV6YWhNK3VrTjNSUy84T0JHdVNJZ3lOWS9ZejhIQnVzOThFbXFDeit5dXpK?=
 =?utf-8?B?Sks5ZG9GNktJM3g1YjN3Y0hUQzI4aUpsMTlVT3ZrNUZDWGEzLzBnVzFPYTkv?=
 =?utf-8?B?YzZ3U2tiUXB3ZitmcDdGYXBpblhUYjJ3aXFDL1VJRzZtMGMxd1VoeWVYT0Fm?=
 =?utf-8?B?dGo4SHdhMy9hVERIUm9SdzFLM2ZyRnRwc1o1MWJqQU0xVCsrSDkybldWcU85?=
 =?utf-8?B?VlJRcTN0cWZzc2ZhNzR6eWEvSm5rVHo2OHVDSmNRSDNadzhONkppK2hFSXUz?=
 =?utf-8?B?MEFLNklwN1d5eWN1ZHNSSHRoWkpwR2N4TlpvSitqcnRQTC9uSTRaZm1uOUNQ?=
 =?utf-8?B?NXcyVGxwV1FWS1BNY3drTHI3aWtTYVlwMmhLYjNwZG91MU5MRTRPa3U1c3pp?=
 =?utf-8?B?ZVJBSmN4dzk5RllIcTFxaGt5RmwwVWJwem9ONG1ESFZLV3FRN0V5YmVDdWh3?=
 =?utf-8?B?NDlYYU1iMjF0bm5MeE9nSy85UEc3azVhdjhsWU1VbHFvaHhVVUdHamduYk9G?=
 =?utf-8?B?SnlsZnR1NU5BbVJNUkVEWXJLZWh3Q3BkRWhQYVNFZ1gvZkRyN3hSZVFMYVZl?=
 =?utf-8?B?SkNDZldqSnR2T2V3c0hHb0s3Z2xiOXhtNlEyRE92cHZCNzZWektIVVpEUWY5?=
 =?utf-8?B?WVJYTmoxREJ6OGNzRzBMNFdTNndKT0U4ZWxZZHJLTWE3a2xkMEl3V0J5SXI1?=
 =?utf-8?B?NFlOTzhMVmhwU3dTaFVmSzdrTzRFbWlOQmUvZWFac3dURU56eFFnVUlrODRZ?=
 =?utf-8?B?RXFnZjJvR1R2aTdqNFh4V3E5a1hGbmd6QmlkQUlQOFU4aWxYeHd1N2svNGw3?=
 =?utf-8?B?MHNBby84Y2J4ZDNzU201VitIOXVOU1VDcE1wZ0tiMlJ1bG5YTHQyOHVJbnlX?=
 =?utf-8?B?aGgxYVJXMWxNMytibE9tQkt0VFltK3U5cWR5a3dIbG50TFFVMlR6b0gwUTlY?=
 =?utf-8?B?S0l2SVd4eENDNThwM1IvTDFQL1ZxSHRTRWFVQ0NRKzgyTzRMTXJHdkI3cXdj?=
 =?utf-8?B?Ukh4UERqY0o5NjhGQlJaMlN1YkoydUo1ejdWTFc3czI0bmRQdkdrS2psZVpI?=
 =?utf-8?B?K0lMRDhBdEkyR2YrS3I0Vlo0K1diUHQ1ekIycWZUSENlVmx0QXJ0bXJoRnly?=
 =?utf-8?B?WG1seVA2OG1YNjRlb3dkVkdzcTJPVnBxVk95QlpTdjNOclM2SHpvM0g0M28z?=
 =?utf-8?B?TXpDVzQrNXh3bGNkcFRpNWNRYnZOTXhodHhKOW9QZFRZUU5BSE0zN2JpcURa?=
 =?utf-8?B?bE5LaU9zZEp4dUZuVmZCamVha21IOHR6eE5JNVhTQmgrRmwyN1ZCTVJXSVU2?=
 =?utf-8?B?dmhLeWZ4NW5LOVYxWkZ3TXFJR25LbDdkOWZDS3JGWHpoNDg2RzhOM3BOczR1?=
 =?utf-8?B?VVM5RVo4YWJjNVNpdHZSU0NuaC9MendLaU1vdjVUc1kyMjVnZzIzMzhYNVV6?=
 =?utf-8?Q?zNiY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f35e6c-8a50-43c1-1576-08d9a00068c7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 02:03:07.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpxiTLC1JHxfHRATxB8YGIZ4Y8s2UNqkk0fwg3Z8SMAO7W9EQvekd0hRLZEtlrqx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
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


On 2021-11-04 4:19 a.m., Evan Quan wrote:
> It's confirmed that on some APUs the interaction with SMU about DPM disablement
> will power off the UVD completely. Thus the succeeding interactions with UVD
> during the reboot will trigger hard hang. To workaround this issue, we will skip
> the dpm disablement on APUs.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I4340cc2fb0fd94f439cbac5d4963fe920866bc13
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 20 ++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 30 +++++++++++++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 18 +++++++++-------
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++++++++-------
>   4 files changed, 52 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index c108b8381795..67ec13622e51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -238,15 +238,17 @@ static int uvd_v4_2_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);

[JZ] Hi Evan, VCN code put amdgpu_dpm_enable_uvd(false) at the end of 
stop.  Can we do the same for uvd/vce?

Here, it is possible that some dec/enc jobs are still running when dpm 
is called. I am not sure if this situation caused hard hang during reboot.

> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v4_2_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index 2d558c2f417d..60d05ec8c953 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -560,15 +560,27 @@ static int uvd_v6_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->uvd.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_uvd(adev, false);
> -	} else {
> -		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> -		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_CG_STATE_GATE);
> +	/*
> +	 * It's confirmed that on some APUs the interaction with SMU(about DPM disablement)
> +	 * will power off the UVD. That will make the succeeding interactions with UVD on the
> +	 * suspend path impossible. And the system will hang due to that. To workaround the
> +	 * issue, we will skip the dpm disablement on APUs.
> +	 *
> +	 * TODO: a better solution is to reorg the action chains performed on suspend and make
> +	 * the dpm disablement the last one. But that will involve a lot and needs MM team's
> +	 * help.
> +	 */
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_uvd(adev, false);
> +		} else {
> +			amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> +			/* shutdown the UVD block */
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = uvd_v6_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 67eb01fef789..8aa9d8c07053 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -505,14 +505,16 @@ static int vce_v2_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v2_0_hw_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 142e291983b4..b177cd442838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -520,14 +520,16 @@ static int vce_v3_0_suspend(void *handle)
>   	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> +	if (!(adev->flags & AMD_IS_APU)) {
> +		if (adev->pm.dpm_enabled) {
> +			amdgpu_dpm_enable_vce(adev, false);
> +		} else {
> +			amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_PG_STATE_GATE);
> +			amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +							       AMD_CG_STATE_GATE);
> +		}
>   	}
>   
>   	r = vce_v3_0_hw_fini(adev);
