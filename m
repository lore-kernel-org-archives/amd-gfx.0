Return-Path: <SRS0=wnxc=QD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C30C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:44:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1B8619E8
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Nov 2021 07:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AC1B8619E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3662E6EE82;
	Tue, 16 Nov 2021 07:44:30 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 006766EE80
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Nov 2021 07:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OO7vuVF9zccbcVboR7x9vB+naKRgHaVn8ZRHatAC47bOLa764HoZXM05a/cb11qX2msUVOKf70tH8r6uBxw9vuEN8wJ0CrNC98LyqOeLQ0MSvuhTf/V9H8e0+fNkqHYilVR2HakMm/NSTI/yrmTlWrUAiBOVeKQcg/ju44zaVmGEow3zL9leANYcri+ahp61jrMaIoWTbelZhFmyAQg691kRq8YV5MSmxYWXUNlfRG5IcD+B2OePFY+XxezhjZGaHLSEaCGqVNIr+S5Okq8G4udfwaATl4gBXBF4n+ENINJdvkbunKkRUT8HSUIJYXxBiFUm9SKpfoZnGE837DfBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhsOAN555jRrkUYUNfg4k6coxgRT5iyB7gm1uI2uDWE=;
 b=n7oqU8tB8Q8viB6ZddnMemraBh3YPATgxMSYJs0Q4cRrVR7PR35Nc/z2Hc+wkRfkmDwaGMLlVdfwFBm4ro/lDgATWyJLOt7ROFJrcmUaV97Jx9PNmW83SYfQrywY4WK1aAb2BqOp6fjU89vynUXOl6Qri+QRGhfnyvppoM7kOoPTuSWKG223AIuNSwLlxXGmXcaToNlzG4+k0EfDgkYqcjKbqf5wQdFDgmUYi94jvs8d228KYxRTycHCPjBM5xSMbZHRdnfvKhk/5Y6rhDYmxLQghA1rGB+yIRx4BF7Lbgq8q8ebrod/7sIgfoN3H+WkUPXMOCWWxUAKyBgKJIDb+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhsOAN555jRrkUYUNfg4k6coxgRT5iyB7gm1uI2uDWE=;
 b=St3BqQOXclKW6hVD5K/YMHimOcz63K7qNmuubou84Z3pFlodBopDZYkYRLqduvSTMLx72TWWDoYzJeRAIjjFsHU2gwBFr4f+nWRdkGI72as7bAewZlUkOEuQEXLlo/+GgHgDkWNGZRkeTggCp4Nhz52UYuEC9kdgW9as8H/jTTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 07:44:26 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 07:44:26 +0000
Message-ID: <d7384968-1a5c-bb76-2b5b-010f42fe65c2@amd.com>
Date: Tue, 16 Nov 2021 13:14:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdgpu: support new mode-1 reset interface
Content-Language: en-US
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, john.clements@amd.com, stanley.yang@amd.com,
 equan@amd.com
References: <20211116072337.29600-1-tao.zhou1@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211116072337.29600-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15)
 To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR01CA0099.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.16 via Frontend Transport; Tue, 16 Nov 2021 07:44:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23d47f9e-dc00-4e71-3b9d-08d9a8d4e9c3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2940FE4F263F9B537A210E3897999@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 92PxYRymWcLWKAtYJyjaS8UXZSG6yROgU292/8Kk8mtf5xC8DEnPwzvCtttQsiyU73gy0YyzhdNFeFZAikRNHCxpjodsRdsO39LEWTSMnDCdMu7MxQaDGTgpapWtxvXPDkdAFWfwK7JEQ9VGs3qsnzf0oavE/FKZUY4dRl2g8hs7vOuTRAaeil8ddyHRhkxGru7ZLHkZQiBgnRnwmMpR6RGvPnJ2TQrvuWxTj6dFBt6IJtK330Vte3SooHhEgvX9MCjUiZChh98SWMUBMu+2779YG4oyvvzAVwTXFPCesQ9rZSPVqx7aEGqCg30anZ/GYEnZ6QrHj/gYK9EnpLUQwjuaqZpjLtOe3ULwJH78XUiCaUzkBL6y/5eqOU6d4Y8XAwh2qb1qU802ztVBHiW15F/jmOTvR/rTfvBoSr9UOvnQClLwUJ1hLyMuGiDdtdrUazoWCglorCgePRM9xTyD/VZtqoFchSYkBXh3Y88Z2A2YbZA+aaRaOXjzFPTH8kRyTlJ38JyoIzj+kw6tpB+CLkw+FSk4f8JOePYz85cDWXIAPIZOYhrhCK6f9iZUCCHHFZjpgiaNLg8LjGHxXt2BblQjjZ4IRdCvOQNgOYV/m2aWqB0XetrXnNA0XYc5uGqPO4avgtvTOX1L4aYTTGA+QoGjOnCsiVupi7aGkKXedcVqV5ewTwWLmwmO72gK4u3w5eGgnGBCgIAgE6+eN7WDmA5GMYyc1fB0UORmfGSfKVI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(2616005)(956004)(6636002)(6666004)(8676002)(2906002)(53546011)(38100700002)(16576012)(316002)(83380400001)(26005)(31686004)(36756003)(186003)(31696002)(66476007)(66946007)(8936002)(86362001)(66556008)(508600001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWVnUzJmRTgxRVNuR2NuSXdsTG9SQTVqVGtwY2FrL2hLQmJkTkx5bm84WUhn?=
 =?utf-8?B?MlFKaUxWZm53c3A2RnN1RnB1TitybGxhTUlIeHc5a1lEczlRcDdzdnQzTXUv?=
 =?utf-8?B?UWRHKzE0MEI5WjlEcC9tRnY4bitlUUNvV2lzQVNady9nTE9oV25GdS8yckZP?=
 =?utf-8?B?eldwSjRWNnJsdCtlWUVzSm11c3dyOXZTNnlXUmd2SFh5emUvME1FbVg4bFhz?=
 =?utf-8?B?MklaU1U4YjZRZEY2elhyT2pGd0JDTXlMM09vbEJkYXR5Wng4U3d3aTBVR3gr?=
 =?utf-8?B?RnNrN3RObTVUNnRTeVVaRC91MGNBSXJweVQrazdBUDZudlFnRlVua3N4dUJx?=
 =?utf-8?B?bjlFVTdmUzBuOG9jMEQzckxDTFlLcU1SSW1UeDUxNlRNYkpvUlRybWxvaFRl?=
 =?utf-8?B?cHFQL2lpellRckxCblpJVkFobjBRNFVjNHlieWNMeXZUdk1ZYWdWRmpNdllz?=
 =?utf-8?B?Mk1pNWJsRjhNMys2QjRiRkUyd0VOOTB2WmV4eUcxSjQrb2Q0elVCL3N6SXdk?=
 =?utf-8?B?OFBtK2E5YWJJenRPaUE0ZjFwZ2s1dTNEeXYyRjdDbC85aFNuK1Bxb1BzNFQ2?=
 =?utf-8?B?Ukd6aEJjZHhaY3JpUndGZnQ0YnU2RVVzbTZSQytkNGZXeFNCaVNTS3NoS0NU?=
 =?utf-8?B?WEZld1BobVppRVN2VUpwY0ZqQjZXUXVCUmtsMjJNdTU2NGVkZXJOU2ZFZmxM?=
 =?utf-8?B?SnZHbU5WQm5vMzZab0IyZmhHNStPUEdzRElJNTZRZFY4Y3U3Rk9jdlM3eEZt?=
 =?utf-8?B?MStvWWplUnBpWFFES1l6NjBhTEZjUFdzL2t0OXJWY3llTGo2aGZzQTNlSnNu?=
 =?utf-8?B?L0dJOXlZZmRCM2NWV3dsMGVWVjJBdTBmcGMwalNyUUNSdmFVbnhkS1FseS82?=
 =?utf-8?B?K3pPZEVJNDZnNllscmk5NG1RdnBUSmZPZC9Pby80UC9PQ29CanJPaWxyRjdE?=
 =?utf-8?B?OXFOaDNycVZGV1BEWGZJb1VmZkhMVFdOUnZGUWdlS2ltZVowMTluWEhhN3R2?=
 =?utf-8?B?K1ZTWTFKZkVwS3drelNDUHlqcFBLNWdLVURYVGpNUE85Y2ZZNjBsK1c0NHVG?=
 =?utf-8?B?RU9HVWN4UlJrd0VTc0xrVWNzL01wRHFlMFpnUklEMi83SHM0WFgxUWRMWW14?=
 =?utf-8?B?SXgwVTFqbHdjWHN2OHJNWVZwa0RTZ1Y4TzBWTHlpb2tZdjRhdktqV3hsYklW?=
 =?utf-8?B?ZnhBaXA3NmQ5NUg1OVluVU0wRzhDU1hyZnhMRWFRbDZCS2FGQ2t3bUdEY1d5?=
 =?utf-8?B?SkV3ZUFIdncxZ0hOV0tsT1Fvb0ZmUmdlWU5QSHl5azBkN0cyRWdWbGxveGpK?=
 =?utf-8?B?YVRid0VvaFdvYnBKOUVIOG56SmxyZUtJL0RRelJkVExPalFCdldMaXJJUkM3?=
 =?utf-8?B?cXptdXA3aU1sRGhNWTlkVkdDUm9jcTU3SjdDbFdXZHJzYW5odkhHRGoydnBa?=
 =?utf-8?B?NGVPaGVPNzllKzFtRmp1UDVDS2lGNFdQcGZubmJ5OXJMMEoxdDlPYkhXOGhU?=
 =?utf-8?B?L09ZSlpvTnF3WnliaUEyYVZUZkVPTXhVWGJNRUNkNXBCWTcvdDIvYWtSemZS?=
 =?utf-8?B?YnZtZ1pVN3VBeWo0Y1doaG5JMUZnRlBKL2hDMVFtOThyZXp0QWtacElwRm1i?=
 =?utf-8?B?bVR3NG5LaitEZ2d3TERUdFQ0WldkQzNueTY3RUdQMVdWTHA4Z1YxTm4rQkx1?=
 =?utf-8?B?V3pNUm1zSmIxSlFCTlQ5WjhsNm80dzdNKzI5QlBFSjlYMVcxMDVQM0xpaE9Q?=
 =?utf-8?B?Nkg5N1dmZ1ZRNTZlekh6UjBkUHJ5UDcrUC8zWEdnYnhtQ01BNG93Z0trTXZt?=
 =?utf-8?B?a0RtRjZ2eE82V3E0eWZGOHNPQW1WQVRXRjlId1J3QlllMVNtNFh4cjlyQUYy?=
 =?utf-8?B?L1c0a1VZck1jdWp6eWpRNVhKTFRpOXIyd0UxMXQ2bW8veENaM1grcEN2TEla?=
 =?utf-8?B?bXlHL25xd004VGFnMzhUdURKcXg5OEIrK3hJV0pIOGJzTG40MmVCdUZJeVVF?=
 =?utf-8?B?aXNUN2JhN0Roc1JDTW9kZ0xLVkhjbmNXdkNYcXZzZzhHMGU1MXgwNUQwZmdU?=
 =?utf-8?B?K0Z6a2xqeWY5OHRhcllwSmhQNXFMd3cwS2pYci8vM3g1akxyTkxRbGFETFBY?=
 =?utf-8?Q?qw8E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d47f9e-dc00-4e71-3b9d-08d9a8d4e9c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 07:44:26.1822 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pi3qNe63eJj7qTUcdaL0eftEPHzku7LGRk1GGuJdiEBBMXGz7HYbhaz9uR4DnBEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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



On 11/16/2021 12:53 PM, Tao Zhou wrote:
> If gpu reset is triggered by ras fatal error, tell it to smu in mode-1
> reset message.
> 
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 35145db6eedf..6f3d064a8232 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1426,16 +1426,31 @@ int smu_v13_0_set_azalia_d3_pme(struct smu_context *smu)
>   
>   int smu_v13_0_mode1_reset(struct smu_context *smu)
>   {
> -	u32 smu_version;
> +	u32 smu_version, fatal_err, param;
>   	int ret = 0;
> +	struct amdgpu_device *adev = smu->adev;
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +
> +	fatal_err = 0;
> +	param = SMU_RESET_MODE_1;
> +
>   	/*
>   	* PM FW support SMU_MSG_GfxDeviceDriverReset from 68.07
>   	*/
>   	smu_cmn_get_smc_version(smu, NULL, &smu_version);
>   	if (smu_version < 0x00440700)
>   		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset, NULL);
> -	else
> -		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_1, NULL);
> +	else {
> +		/* fatal error triggered by ras, PMFW supports the flag
> +		   from 68.44.0 */
> +		if ((smu_version >= 0x00442c00) && ras &&
> +		    atomic_read(&ras->in_recovery))
> +			fatal_err = 1;
> +

 From PMFW version, this looks specific to aldebaran. Since there is 
version check as well, the implementation needs to be moved to 
aldebaran_ppt.c

Thanks,
Lijo

> +		param |= (fatal_err << 16);
> +		ret = smu_cmn_send_smc_msg_with_param(smu,
> +					SMU_MSG_GfxDeviceDriverReset, param, NULL);
> +	}
>   
>   	if (!ret)
>   		msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
> 
