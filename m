Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B7C61DA3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Feb 2023 13:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4C010E175;
	Tue, 21 Feb 2023 13:25:18 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B35C110E166
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Feb 2023 13:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT26qC/2JYE1WfLDL56OLGzXQOLOxTt6pAYXbh6AbRY+VeW8BmbW08yXZMqRBnOt0dD4VHHEblD0Bgoqu+lW4Q1Bs7MSOHY7HFEJfv2Itb/oBfcFGkQko73C+FE0eQSNGfVMRP/wCJPOJYwk0fBywHWE6VqgdJ4WGNGrm8b3iX8aR3Klz+iKGwnGtCczfkhGT/gpZySFUBAOhsbTICMP6dBx0nbiUeDpO+sFcTnDFHVPaj7sDcrFHlFJPZFXDnHEnWunHJvKHhErdCWJiVt9vhp0VDD6MqlnsKnsKG0LHJ7VyGxSBxK5ZNKl47hc8pj5LCi55XxCnrc9Oi9UKpkVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXrzovJfGF3MUc8WxchCnx5/9GCiCIGacukrGrkwfeU=;
 b=XEnBvmHulqxsPDQd4q62DP/z1PQ8eEVbaxALTMq7+AvelkBhoicDgXPrh1GDv5xGI5gsbcrQCr7D/nP8cTIv2R+rQNuEc3UF385C2lRacXfev3pnJ9esK8Hs0ApbNPnuRV1BPvfBsAWI1BfmWamzUeRMsMyew2/TINYRL/WLTY8qbGkEQpxcRcbPc/SPZBHkWmQ6ZeBeA1cI6ow2fAs61bFPBf1EfezhV78kPM8q6Q0jp6/UEMHS2kXcKUU1opbmvi1+Hq0klDcyN6NVRuwizi38G5FqoWx+MakgdkDgtpz8BtvIeTOUjdD5mvEOf9fXW7JdhYCrzd/piUzVhf1MvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXrzovJfGF3MUc8WxchCnx5/9GCiCIGacukrGrkwfeU=;
 b=sVSRtSKQ/nyoBvL8afzCc8gbEiJMG2rSTKcsJLBPDb7cQeALIIzJ7t2GnH6lL8jTUldhaiLGh9M7vXp+Q+Gj+BEIXFvRePwgnetxMIXtr7eyT6ReenDG7ALJR4vw+/uZfqxPtXengqVdeG0JFrsfNjn95KzKxpSJBWWFdzZGcO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7875.namprd12.prod.outlook.com (2603:10b6:8:14d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Tue, 21 Feb
 2023 13:25:13 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 13:25:13 +0000
Message-ID: <ebeab4bf-4394-0638-1ab5-697e1bc24a27@amd.com>
Date: Tue, 21 Feb 2023 18:55:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] drm/amd: Don't always set s3 for dGPUs in all sleep
 modes
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230220201618.25962-1-mario.limonciello@amd.com>
 <20230220201618.25962-4-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230220201618.25962-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: b15229f5-0181-40a1-2c68-08db140f1000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmcOzEBX89UE+DQ1M6fsJ7L0D2Z6H5NStTOEWnfUXSW0q59BG4Kbu3PG6yKx6fLHI3nPfJjsmAsbKS5AXA8Plq2fPrAn282LIp/1Tpv/QQSHMws1ihFhr74UckkRhVQgV4uPGQjvXqTk3JduM8N88bzMISnxGTONyQNWsNh0a8NS4I0QfxaMh8BJLt7xPPGoLx+eCM4+P5fvaC4KrzztnEfRu96sQBKn5mnxNREPZ+WHrh9TQbdzJOrVCSvUF2RbW9LXO3DynJiQpiwBGQ8VgCEvv9kyuCUykOIYOA4hujeXBlQIodYBn5EtrjQhSSeWjIhHhr+HG2VK+WYMv0JXJXzsnRQ19oaLE1H4AIdin98Q3YLTrINBNdOP820NrdaxJ+u/cFTzlmOAVwuZnYKs9/m81GyYBZ6s5W7V9KfHf71KFqAn0rHCdxxPPvkwEL709bUWt6tlynCXKyMfZExAQlh2unTPVE800DAjBEjdON37kfQmqwCnqlYyAkI/JGcgDlo2L4KGvLI+GFXPDkIpq5Qoynk55qvArhAj4WPUxI4yQZ2pgNqnVntUG2+wE082XXhvGfo5D9hGDMOS8lrRlyyMNNE9/AU/Revuo04taGMar8wzD75GOt5wf8yqqU++DpR0GM7GMcUodBV5aDD7QK/IoCI897V+rMMdj+md5kHCR6i0qqmfGPyok6YtlyjoY5UC9GZZhsQVMpR3WlYU78s6Pybz6bcuVSEQRTp2ERQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(31696002)(6512007)(26005)(53546011)(6506007)(6666004)(6486002)(66476007)(66946007)(66556008)(186003)(478600001)(316002)(38100700002)(2906002)(86362001)(31686004)(36756003)(83380400001)(4326008)(5660300002)(8676002)(41300700001)(2616005)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUQxMzNXeXNXRXBsR1VUamZuQjdCMVJxTTl2eGkrUkxRSFpPVjlzQWtaSUp1?=
 =?utf-8?B?U0dGeWVjd0taZkxEcnlQNDBHVTlzY0NYa25rc3NzU0JHU0gvVEs2TkpodThS?=
 =?utf-8?B?NUxzd0lLVkY5T0Q3OURpZVdCOHFtWHoweVR4YjJSdkE3b1VKRjY3bUQ4N2hK?=
 =?utf-8?B?UW9uaCtlRVgxNmJleHlVazB1SEdFM21LVHRqTzhZYXFwbWxsVmpSNncrVDRa?=
 =?utf-8?B?Qlp0dHpFeVFOUFRuZlJIWUhlSU1PUmk5RTluRmgzWkZBd1VpOWpTTEtHcWYz?=
 =?utf-8?B?bTVIbXBvd3FaSGpiR3o0aXJPN080cE50aVh0WFhYZVlSeHpKV0p6bmtoQ3ps?=
 =?utf-8?B?L2EvUzR4STJMUDAyWU8zTk9Gc05qajBPM3ZHTkxGeU5NOHhCcExlaVR0S3N1?=
 =?utf-8?B?QTZmcXp4RHN0bWFsT2g2clF2K05WK25yZ0IzbEg3RTFidG51NjQvenRlcFJ5?=
 =?utf-8?B?bDFZOWdEZnM1UWFnUFhManl3U0lSOWhrcUxSc1FoOG1zM01reDVTcU5WNWFK?=
 =?utf-8?B?VVhFdktESG1zQk84a2diQVZhOHBNMXlQNi8vTmw2QS80bHAzTWhxWElha1M2?=
 =?utf-8?B?RzF5TFpJYVRsQlJ2eEU3am9NVHRKRHF3ZUNnQkNEVUc0YTJLS3JENWtaUy9M?=
 =?utf-8?B?NVZhRytJcmUwRGVmTjM1ZFVJN1cvaDBQRUFQNWtwNEI4MHNIdjU0eXIrMHhM?=
 =?utf-8?B?NUI1TzhQNFo0aG1TSVhjb0I0R2R1cTcrZFNOcTlhTWFZYWFod2RaTXN0MGJK?=
 =?utf-8?B?S3c5d1hWWnUwRFpWMmExMEw1cHpteVczRmFvUXN6UjdLV3lwRTlFWFZmK25M?=
 =?utf-8?B?WU9STmV5cWRnbUUyL0NpQ0JvbEJIZnJ4YVdYZGR4V3k1c1pqcFkvaU9XbDdH?=
 =?utf-8?B?bVFTTUs4bmxrMGMzeFoydk5mdnpycjczNjlGaTJCZVJtTlFDb2JPUysyZ1Zi?=
 =?utf-8?B?WXl1endEaFVRTDIzK3BVdm9LWmlZUFRmR1RRNzRHeVVQd2NiVy9ZWXltdytY?=
 =?utf-8?B?aHVpUVo5aERWbVV6UE9LTmVMblhhRlpxV0trWVkxYlRvZjFaZDhjYU9TZll2?=
 =?utf-8?B?TVhWbkNYVnp1bStVVU5jV0RMN0Vpa09HcTA1am5QdGszenVmUklOcGkzSFc2?=
 =?utf-8?B?b1JGVFZ3NmtwUnRWOENVdUxqUjVqTHFyTzMxbWhjdmtXeVprYUVLd3FWVG5t?=
 =?utf-8?B?RDRJY01DSWRBQjNNNnJFREF5WFM2U2Zndlh0R21XUzJhZ04rWG9oVmFHVGli?=
 =?utf-8?B?V0hzSkNqNjVkb05nMjMvNHh4bU5jRjhRZ3RVMnhnb0FXbVJrUHdUelJuT1Iv?=
 =?utf-8?B?RTA2NllhSFljdUVrM0I3ZzJIUEt5Y0VFWUdXRG1wRXRRdk9JbWorOWpDaUVJ?=
 =?utf-8?B?OG1YQVhZRUYrV1pCMlh4S1JpbzBtRkd0MENKTzRRM2VpZlQ2U0NtZloyTGc0?=
 =?utf-8?B?NDIzNGtBWHVGMStpa3lPanQ3ZHdyMjdZOGQzSXFXUmVZdkRXK2wrU0dRQVB5?=
 =?utf-8?B?STBBU3cyMEVCeDJwblNuRE9BMjlKMVlwK0puTFNqNEVTeHhPdVgxWXM1QjB2?=
 =?utf-8?B?YmxiaE53WVg4OHRzVTI1TWdFTXh1cUlSR0JLazAyZ01kZVpBN1FXeEhPRC9E?=
 =?utf-8?B?MEtDbmpablZQYWdJT1crR0RYRFVDUm9SVXdlOUJFdEJLSWlCakRCRVJLbGhI?=
 =?utf-8?B?RlBqQjV5ZzQzazhYbnNnVDcwZjcveHdhWnI4OUdsblN4R2gvMjBuS1R4QmhC?=
 =?utf-8?B?WlV3Sld1SXp1RGNONjN5MTJ5NFhldFZzejhYcEdNYkVTWk01UVRIS09pdWM5?=
 =?utf-8?B?cU5wbXJjWTlXRVAwOFl4c3VtUnM5a0gydDZmWVpCSnpUKzhyVVovMm9lcGc4?=
 =?utf-8?B?SnRac3N3cUNiUUlXclFrYzBvZzBSUnlEbVdZbmgzSnd3c3lGeUMrM2kzSnRB?=
 =?utf-8?B?SERVdkp2Z1VIZE9qVkJGbm9IbHpFTisxcE9oNXZJMGkxZ2FORExoTzFBdUJM?=
 =?utf-8?B?Nml1cEMxOFhndDNOdm1iTFpsWThFaDBTYzRJMHpTb2pEL0VoWDM4VUZIT0dH?=
 =?utf-8?B?UFJ6T2pYcktCbTg1ZUVDSVk1d2RWZlR1Vjdvbjh2WGJSSVd2aTJLOUw0T2Vq?=
 =?utf-8?Q?kUCf8whahktWjhgocoLB9URA9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15229f5-0181-40a1-2c68-08db140f1000
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 13:25:13.2005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orANcO8lBzp1uGRoKiq1y4zZ5GIhp7Q5MrhTV0fa+e06Ptpzj0Ht6vY68dOOd7UA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875
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
Cc: Peter Kopec <pekopec@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2/21/2023 1:46 AM, Mario Limonciello wrote:
> dGPUs that will be using BACO or BOCO shouldn't be put into S3
> when the system is being put into s2idle.
> 
> Cc: Peter Kopec <pekopec@redhat.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 25e902077caf..5c69116bc883 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1038,8 +1038,13 @@ void amdgpu_acpi_detect(void)
>    */
>   bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>   {
> -	return !(adev->flags & AMD_IS_APU) ||
> -		(pm_suspend_target_state == PM_SUSPEND_MEM);
> +	if (pm_suspend_target_state == PM_SUSPEND_MEM)
> +		return true;
> +	if (adev->flags & AMD_IS_APU)
> +		return false;

What is the expected path of APUs which don't support S2idle?

Thanks,
Lijo

> +	return !amdgpu_device_supports_baco(&adev->ddev) &&
> +		!amdgpu_device_supports_boco(&adev->ddev);
> +
>   }
>   
>   /**
