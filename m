Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C9AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C6B61A62
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 22:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79C6B61A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1556B6E5A2;
	Thu, 18 Nov 2021 22:49:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE5B86E5A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 22:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvJqxNcePMIKu0tIkVJh3FZXHlzPqFXtqTWq68V6fDeb+UIiDs/1TySte57edNIiKj2OW7Nt7OFl9OZfQh60nN5c7cW4+xIFsdFzfHjIzZa07f2+taz5tFfJpqoTkYYFTVbEhW/j30Mx0pk3NuA63mfj16jRqwL1kyzgO7RQeVe1rxYDCKacF5rzPM/9yZGJES9YzYK8RQXb6k3dMiUvv/HQknacEBzJvkrK5AqYKVBisWr/p/gY8olGVTyRSZ5MlCXK1L4whiWt9TAbFr2LWFGz0HXko2sRM0ncDHU51kscnkhTv/JaGAso0bewVj1Ke+wEOoFCxSJ0aqI97rZAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4b0lGh1VtF4sNOpVhsfvUZUadpDdoKAx4LsykZsjs0=;
 b=YQr+K8EECIEFQOgEfMcqE6eDwrh+gGqxQtfA0H/PMSLZdJ7aeazwEY6mtJOmOtHmR7pR7Frb2AqYFHBIvnZsCimGRRVd/X9kjSqu9drOwU3A0GZ4mWENl0FoRsJKFN/XhiFYM6RyQpMaMy9k6EeXWGhrKQ/gis85TuI/AyFutZ1dmiKi57reMFJi8IO5iOF2sjsZ27aeU0qjYGWXXSLDUbjwqc9kvaTUSHYvgeThCdnoCc9sbtVOUsRBH0cRuXSqD5WL/mg4jb0Iacrx3P2TfYmE0Pw9cC2YIip8LINwkhqjqu4dlsJ/t9LSEXlKx/KBjupYzV5FntjDkuRWyAJTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4b0lGh1VtF4sNOpVhsfvUZUadpDdoKAx4LsykZsjs0=;
 b=pGe0Sh8LKW2LxA8ttGHUS9erWwWvzwVWsrx7zWii+MulzdRdrAGH/9Ho9+Jzh/re/dSBXzSVMa4NJ+f/ZTJkKtB3hnNtM+5WXGmjNCwGitpF/RrA6HGrlZILN1DhN4E+YmLf7mYZY8BfHtic92upRkhIDD1sNvhAjbshEQ3o+zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 22:49:52 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::7d09:bfe9:7aa9:6011%5]) with mapi id 15.20.4690.029; Thu, 18 Nov 2021
 22:49:52 +0000
Message-ID: <dbffa5b3-1ecb-1637-3cd5-2520905d8e0a@amd.com>
Date: Thu, 18 Nov 2021 17:49:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx10: add wraparound gpu counter check
 for APUs as well
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211118195453.485901-1-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211118195453.485901-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::29) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.47.56] (165.204.84.11) by
 YT3PR01CA0087.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 22:49:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f1f17b-b8b8-4e01-f2c8-08d9aae5bbd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4987:
X-Microsoft-Antispam-PRVS: <DM6PR12MB49875DD2F1859338D8E3E9C1999B9@DM6PR12MB4987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHincgQdGAELpsbqZFsZRtzObfiVkITHlkJok2CtrE98xucErfCfuiH3phVsjZWW7mFNt8ZvFqeflLxILJ6mcedq1QoZVNeG1Je9aWdGbtsUOjOF1w4a9xQru0WEQ/+20asd+maypKMs2DCzpY0rqPnvAcbRbjtlYOAq+lsqJCf1vO3hdoAOIhKVEWP3Bg/H/OpqfBwjTRl9/5aBMbPUCeMx/hebwJYYZMqTOXOYuia2bgETceqXDp5VuvENJ5BDKgkx8RIZufYJWiUoziHg5vYNJ6f8AxQiQ3Bu/2mZbrZ8S5cI61MYuNFijCdo3SiiZcNgKlkukptPRAEmpf02kgFGUx1sUiHjasGCJLu/knFDIWS9VQ1xYrov3r+O6kbr7+Aj94QxcoEm/uat0Hxui9D29ldkdjHdlWTB8HK5iKrQMEpNtEu/2bXmqwcH3LKz9zMbWaQ7V+IGOrEo9FQ7AROghwV9Qys5eLppKjcZy5ksDKcT+3M4tISMXpeNA/WokWRWtEgYQ/pxf73H1Vzb7rpJ/NHL22uXq84+KMeI7n5ESEjK8zXMVaOA+ll7jC+tQusr3DQcE3IOn2q6z48aX6aEz8EL8jrRuylHpwJyTWb1NRcwEolsh5oIlrYGcMhY6J8qrOmOfD++K8dk5GyDZPQWsYNr7s2WgqfYrNvs6t+BZFfwajRpagNyMJz/EcihIzLnDsXW5Wu2dlOz/XuRJiubFbeMPx0OhmatOWdSxhY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(26005)(31686004)(66476007)(186003)(8936002)(6666004)(66556008)(6486002)(83380400001)(4001150100001)(8676002)(31696002)(5660300002)(16576012)(38100700002)(956004)(2616005)(316002)(53546011)(44832011)(508600001)(2906002)(36756003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlpkVkxnZklzUDVUWWROM3JjaFFpMm5VOG9qbGZhUDEyVkU0RVY4b3NsM3Ny?=
 =?utf-8?B?QUV3M2xYYXczU2kzVU1aZWdLcUduNElrOUo4WTJ6Rk5YeVl5WmFvMjFZMHJF?=
 =?utf-8?B?SnJ0RTNEK0g5WHlyWUFSYlZnRTkzSUoxa1NkVzdpRDU1djZUM0V0RWZkVHVO?=
 =?utf-8?B?RllQeUxHdVNvN1hDVDFzQnpzcUl4TGdBemtMV2lBWC9WRTNkbitZbDhNcy83?=
 =?utf-8?B?ZGVQd0xHbzhwbnhjTDNGMjl3MVlwdHcvTk5NQjI1RklIRXpjTFBYUk5rY25V?=
 =?utf-8?B?SVF1U1haYUpWN2k4T2NtSVVBZzdLbDY3bDJLZHRSWVp3WlV6K2FCVjhWVzhh?=
 =?utf-8?B?eG5veEpXclMvY25ZZzlCaWNhUDFlcVNQMUpUbTZXb1hGOGRsdG9ESnlWNG9u?=
 =?utf-8?B?c0REMm45SFlialVwUGVaQnhleU9LYzhoVVAwblhhVUxpTEU4QlRFNG1OeGdS?=
 =?utf-8?B?VzI2WG00eHhCdFp4SWtkMWFGTllGSGtNd0hMV0FldVVUZCtKZGpidGR2RVBl?=
 =?utf-8?B?V2hJTFYvRHhtbzl6dHlIeUNyeTg4K1FrNzhzejREYzJWRzF2N3dPa0VVella?=
 =?utf-8?B?cXZROEdlUnJEaEl1VVM1eHJxZmhGWE13ak9PdUVqUTJlSG03OVRPMDBQNDRU?=
 =?utf-8?B?bFdPZnBvdVBPejl1eG10NUp1Vk1BYTBuTnVFTFNEQ3BZSyt5YU5lczdlSTdp?=
 =?utf-8?B?U2pjM2tmTnFSOXFmdUtjdURyQUtib2hhNmVHdFZzWDZZbWNlVVNwbjJJVWNn?=
 =?utf-8?B?SGk4NUY5MXpIV1VLOGR4VlJRMGE0SWFvMlAwdFdaTm5RSzY5bmZ1MWJtY0tE?=
 =?utf-8?B?Y25VdTRlYXMySWpHKysvYmY1VHVOSlJlTFQ5YTJiODNuNFVUaFhWUERNS2Fi?=
 =?utf-8?B?NGEwOXlaVzlqSmh0cjFOc0RiellOaUNBREZsUWhXd3ZxZ2ZnMC90bUNRSjhp?=
 =?utf-8?B?cTA2OHZhdWlrUGdYU0IrczVTVUVScG9YcHAzNDlyUE4zZTdXQTZpZGNZQjNL?=
 =?utf-8?B?RkJ1eGtRQ01HVkE5TVNBR1gxVnQwVEJrR090ZnFCcUlsQ2NrTWp3SDRVeVJJ?=
 =?utf-8?B?aVJNdTIwbmhrcHlIQVgxUlZQOTMvOVJHK2VzVFM5c29IOC9DVDhPQ1ZKQ2t6?=
 =?utf-8?B?ak1mS1BRUThISS9LdXJydnV0VHFJV3V5cWdUeHY1SUxTTG52amp5cm9hMHN6?=
 =?utf-8?B?cXd3a3p0NzJsaGo4TElSQ1Z6b1h0TXhmSXBBNks4c0Z5OGhDYXVpa0lQQU9G?=
 =?utf-8?B?TG1DOEQwSlJJRFlxQWZENzVvbUpDTDA5ZVcxOUZGWVgrT2xJS3Z6RjM2NXlj?=
 =?utf-8?B?OFFVMFI4ZVg4eTZCSkRCOHF6cnNhS3lPYlV5WVZiTnNzU0R6SEFIaXlqUWhN?=
 =?utf-8?B?WVh0UEJvUnExMitIWk1qM0R3QXdaTG5rYTJMMVFkYkU5QXd2eFgrSkdVNUdj?=
 =?utf-8?B?c2dvY2NEeThYVFAzMmtzdlR3M3VQamRnUjhONFEzU3dpQ29raEhpbmsvQmZ1?=
 =?utf-8?B?T1A1aGdvS1BJUkNTalIyZlZ2cHZYZHc5WUFDWjhtRWRqbUlsaVhwVHNmS3JZ?=
 =?utf-8?B?dytKcytwZG96Z2haU2ZyNHFTR3JjZnhoSFhtdWQrUzFYQ2JRYm1kWUJoWDMr?=
 =?utf-8?B?S2czQ2dQYjF5Ync3dWpLTVc3NEVlZERYbUh3SisrbEptanEwbkd5cFQ4a2xU?=
 =?utf-8?B?R3BsTzA2RXVFSlllZFNsaU0vcVJVZWNCQ2VkZUVkWnlYQW9aaFNFeWJHQWdm?=
 =?utf-8?B?dzI5TExGZGNxRWlRYy9ZUk9iY2RtTnVManBkV1BHSFczOFhrZUJmNHB4U1R1?=
 =?utf-8?B?VVpGc0dDYy9MZUgrUXlkb3FXclhsZ1RCQkk2cWdyUi95UHBDSTFnSlhlbU12?=
 =?utf-8?B?MkhoVUpTVTBLeGtsMEs1OFIwTnk0a3NQaHBNQS9SL1dtQysvcGdrV2hSa0ti?=
 =?utf-8?B?T3FjYmw2QjVNMjRCNHlXaTlKOVdjYzk3TXk1RjNaVTNSNUZ0T1AvS2oydnVt?=
 =?utf-8?B?UWorNFltK0JVaGFTb1ZBcC9vVkRjMUtWN3NoWTRmckZ6a1JOd0hrVlY1TmFL?=
 =?utf-8?B?cWVNUFdOM1BRS3NDdmxpVzEzR2JBdGl6bkEvZ1dKS1hNTmNuaEljZStQdUFa?=
 =?utf-8?Q?POpk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f1f17b-b8b8-4e01-f2c8-08d9aae5bbd0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 22:49:52.6820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpE9OiF3kF5//acAPxdwnYxMsADXqbHE/wmuuZxfaQugMn9T21EQJ/nf6gi//V+u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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

Seems reasonable.

Series is Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

On 2021-11-18 14:54, Alex Deucher wrote:
> Apply the same check we do for dGPUs for APUs as well.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e7dfeb466a0e..dbe7442fb25c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -7707,8 +7707,19 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
>  	switch (adev->ip_versions[GC_HWIP][0]) {
>  	case IP_VERSION(10, 3, 1):
>  	case IP_VERSION(10, 3, 3):
> -		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh) |
> -			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
> +		preempt_disable();
> +		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
> +		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
> +		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh);
> +		/* The SMUIO TSC clock frequency is 100MHz, which sets 32-bit carry over
> +		 * roughly every 42 seconds.
> +		 */
> +		if (hi_check != clock_hi) {
> +			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER_Vangogh);
> +			clock_hi = hi_check;
> +		}
> +		preempt_enable();
> +		clock = clock_lo | (clock_hi << 32ULL);
>  		break;
>  	default:
>  		preempt_disable();

