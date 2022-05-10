Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11BFC43219
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 14:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D2710E976;
	Tue, 10 May 2022 14:40:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA07010EFE9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 14:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtUTYydjV2hJTLzc/UPFhT0mfZR8KY6cBtDlUmbvT44/5bPhrI6Zbbx+ap9zgWgNzoktqV+pip5s6QzdcpXYf1+DyFvzAt7cTQE3Qv3LyzficuYuCmUaXhAkYk+pSWHaFK0BoVLsoOUJRc+124mekzScDaOIZ23XdKStKfRzKjGf0htf1AmvJOiQmRpICkFdXbKUSNPtsVaRwZFVv1ZS7MqwKQI1LMMNFUuosOcK3DnlatgaGkTsz/kAKiBFRzW3rnC9xo8GaSq53Bw2ZA/OWrkIvaIs2u0O+peaWLBxo0rfMT/sqrhuqWLUzdGkOQUggGAqk50/8EROjD4lTdCh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH5zOrG9IyMe+ZSAHYb+6gmdYTotEtzWMkLOe6iLqjM=;
 b=VBt5sZ9+KHZJ/YwDj7qiNEmHSzWHmtHzcl7YUL5PsjOPT2Ewpo6h0PZle3LTja/pZTCxfpJh2tLdS0IpAufaDcVL8nU0LxiLIBh2FZolfynjnUWzdNTpFisl9S4PzG2gYtChLze4X7pO+cgQwYSOipMChd2GffcXUPrBevJtilP6teY6BMr4NFRdhYU58g6TJxcAkmI8yo15KL+iSJP3hXu/H8/rtJOUzrULq9W2dXFNggAO+QoIkPShP7uMeXn4gst8qZ8Rljmg/Zkr8IGYaJ/T59qIfEWT+ft8Lp1PVASUWhG9w8coZxEMNetq3spmcxeFQUUO0vvpgRrl7346QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH5zOrG9IyMe+ZSAHYb+6gmdYTotEtzWMkLOe6iLqjM=;
 b=sA1lxicMlaWtGC6gXE1RXFI25qmvPCf5sjgUqhYhBi5GfM3FUcVuq6D/QjkhLSqWBFEXf9vRLAUESYhqZw9ol8oGJn2hJeRJwfyMygCCi2HfAtpbKl5RFA5uOwMNosRTdrBMjUD9rRASNOB5Qzx4OugTdEJLWe3JLtr9O4t6TQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:40:11 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::1134:e908:ed64:d608%7]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:40:11 +0000
Message-ID: <d74fffc9-2553-a3ac-0dd0-90a83e980832@amd.com>
Date: Tue, 10 May 2022 09:40:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: Revert "drm/amd/pm: keep the BACO feature enabled for suspend"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220510135144.551692-1-alexander.deucher@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220510135144.551692-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0208.namprd13.prod.outlook.com
 (2603:10b6:208:2be::33) To BL1PR12MB5157.namprd12.prod.outlook.com
 (2603:10b6:208:308::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669e333e-015d-4502-3faf-08da3292fcb2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4112:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41128C9A91E5D40A64CF1201E2C99@MN2PR12MB4112.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TM2QFvxm0AinsVl0p8wqbu2kLex2p/Z/GfvuMLed0JEnzgMZew+4F8fIfqUEWr1o8YXJAHJDJ26nc9su793Bftc+L4mezAitUL3AjdKBxhiX13aySvErfS5zTdDiYTblHgiXWYr3vQpwnysKF80cz7z3zfVeItZ6K1p03x5niUBMgMTZby6DBvCst17mqDHC56gVYkxMeNLqd3TTS4oEUhhO1urnMD4A21bLWzSNIFdjS5y5O02/y/+KjYSApTPWSWh6TeKPcJ1G+8wbw30AvJL9kiEvlK8FY9Z4D6b9FXaqZG0uc9rA+CQI4d6lnFfJhuGJUy726nVFpT0pHDgfT6TL7/RUoUsHMsFF6gzvoaQez3uWLCrhEu8y6/4aWBCYYG8Ofx+CBOpwv1LAOVK8YkDnjeXzpmIrLa/Vu2jR1BDsAhjIrz6SfXaRs3qsQuorISHkNo1fgayN5bSGNOhsHnBcxSHuy7yhu8iLvAt35ajJp509pRIpmtw3eESQY/iwpcY0FXse9z9gzzrAXBvMExMkiq3frQTyj0eViRdBFD/R5QAHa0WYeaNWrUXLNt29/r8Y+5pUpdIXxlm12m2SS4nlSiaMOUi3ZX2VA/fuLUdkiN1uZjYSz9JiAwDSQqpJ6DIEk5Ku5XKLLho6KlNJlOM3FdBbKehqYquHJ17/1EzA6adRiJljbFDuj5hwR7Y4slzKuqhROyfrQDLoRsnfPv7zWM3uoHvTIZPlUDEK7RNkSRHh/jRnFOaUfaemufzE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(8936002)(36756003)(2906002)(31696002)(5660300002)(38100700002)(15650500001)(83380400001)(186003)(66946007)(66476007)(8676002)(66556008)(2616005)(508600001)(316002)(53546011)(6506007)(86362001)(6512007)(6486002)(966005)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRoalUyVGZrUnFFeUh3eUp1YXlFcUdWOERDR3dzbldxVCtKRmpWak9TZUUz?=
 =?utf-8?B?akNxVTBuZGtTVzdpQkUwcG9RVUs2VXFOUnZETjVFM1pNMUpsWk1sWTVPdk54?=
 =?utf-8?B?Ulo0dXBSNExvczh5ZHFHdmEvVmZQem9FbGxEcklzMWpxVlduMHhKY0k5QTJI?=
 =?utf-8?B?RW04bkZQQkg4a1BLMDNUVUNneFRad2JybUNrSThmK0pWOEp1YmJjek5XSWhF?=
 =?utf-8?B?TWtlbHY2bHp4bGh1SXJqbGxuelVqZVRJUXpCbUN0dHNmcVRjdy9NTWR0QzJN?=
 =?utf-8?B?WDVoZHRhMDNYRUdCVzhvQXhWR2piMWc2T0ZPcVgrZzlKbHgvRngyTWtHL3Fm?=
 =?utf-8?B?MVpkanBWdFR2SXEzNFNHcE0raStIT1NtSENjVzlQVkRPNDdqbWRaeXdmVmtr?=
 =?utf-8?B?eXNBNnRaNkNWRjJoU2NRWXdHMjFycUhRclpLd0lZNlBoOW1nb3o0S2ZYSTRk?=
 =?utf-8?B?bGk2MmtVcExQUmNlQ3cwWklMQmVwcDF0RnZlWCtKVDhIKzgxOEMzZHJWaU1h?=
 =?utf-8?B?RS9NcVVQMU1LOGY2QkFtZW44NGxkc1gvWDV1OC9qVmdDWHkzQlB5VHhPRnlw?=
 =?utf-8?B?azl4ak0zL0JGOEJmTTJxanVEUFlQUWgvQXZrdDBhL05pL0xEckYvRlRRTWxi?=
 =?utf-8?B?REpScldJZ1hlSDUyMk51d2pvN0dhTHZPcUY4OWVFWlVLR1dhNVBzMXYwYmg2?=
 =?utf-8?B?VVVZSjA3UmNnQVhBanRVbjBpWExiZ0FNY2hXeFJUSUgzdjJReDN2ak9Hb21t?=
 =?utf-8?B?RForWk5YU2hQYWVSdjBNdmNYaVBiU3BRK0NiVkN5OGVES1ZQSENqZzM2Z1cr?=
 =?utf-8?B?a2p4SEsramhVMXhkZENMWmM3TW9HT3lkbFA1YzZDeUI0UW9LZzA2dVg1aU1i?=
 =?utf-8?B?S2ZEa0NuQkFjM2dWYjVvUTg3UW9HT3l1QTY2c3A4SjRhQThKV2ovNmRMenFT?=
 =?utf-8?B?WFh4YUk4a2JyQnVsaTFQR3BpSHV4ZWFlZG4yWlpITGUraUpqeFdYQVlSTHBh?=
 =?utf-8?B?NGpFR3NhOTBkMmtQRm1sSVcwKzkxeTMvemROaGhkRXlGT3AxMkZBc2hheGVZ?=
 =?utf-8?B?R3AxcVNTWHJIb29ldnhaRGtwL3Vydlo3Q211aU1pcnZYWTZNVmhDTGMvak9y?=
 =?utf-8?B?aElMemMyTzJzb0lKRVAyMG1VUVhlaDcwNTF6ODBESHgxMExjTDVieEZDaXBF?=
 =?utf-8?B?eHJxRGU5NFpjV01LaDRpQnlBSnFUd2VVbmw5NTRZR2N5K211WjllbHNaWk1z?=
 =?utf-8?B?WXB3eE1Temg4dC9ybllCdWpRTnVkNzRkS2g3bHdlL1NnK1VoQkpCRDg2cHZE?=
 =?utf-8?B?dEs4RC8wcjN1R2RSU0tBKzJSUlJISnIwZ0tzQ2FQZm95eXJPczNDNWZIZnhE?=
 =?utf-8?B?NW9tdW1qZTNwNmx6dk1hNm9SNWVqWW93dlN3RlYzM2ZxRUxOUlgwbXEvT0lW?=
 =?utf-8?B?R1BNOFJybTZ4TjA5anBwSWdndHllUkxvaDR4MjQxbTRrUWpxVDB3R0lkdkZL?=
 =?utf-8?B?M1laRVZHanEyeWNKTDRmNU94aXBtOHFUUS9qTnlQclZNZ3loZUJQVEpieEJ4?=
 =?utf-8?B?Mk1laEMrdFVVckVONTduS1NDQmlEYUxzSTlTRTYrbDNrc21HVXcrcHF6bDdH?=
 =?utf-8?B?OEFNUVZuL1ZLc3RMNkVnZ051WCtoYjcrbjhWQ0JBUFNpMU4zZHBhRGNsa3Bj?=
 =?utf-8?B?RSs3dlNsWTVmSW14VU9UQUtWb1Z0YVNIOHN3alQ5eUNORzJTTnFBVFVnRFFr?=
 =?utf-8?B?TG12d3FFc1lQZCt4WkVySkxSRk4wL1U2TGRKOTZFbHJEYkd3ZUFpTWFIdDFX?=
 =?utf-8?B?TXFFV09lNGdMMkpMY2pvSXZXYThkd2s3MnhKQlFYL0VVTC9PUm1QeStReE1l?=
 =?utf-8?B?Yk9OVDI3U2JaOGJqT1pxWWZYWnVlL2dPWHNUU1pyQ1R4UG91QWtab0R0ZXJk?=
 =?utf-8?B?V0hDQjBpYTZYbThKZS9RSnoyWC95K3dLOGpFZS9jTWdQNitvT1I4V3BYSVBi?=
 =?utf-8?B?ZUI3RzVXTkhTWUg0KzR0MldyVzBpZExLWWxERUJTRmVKaVNmMmc0a1FXQ2p5?=
 =?utf-8?B?WTY2UExpUjBvT2cybzZEOGJvSWxCOUk1eHNENjFIOG5WdjcrcjZqOVQxTHJJ?=
 =?utf-8?B?eElDbzYxTWpqZVNObS9ndXRuTWwwelAvbTZPbkxaWmFqOWsySExnTmpRWkM4?=
 =?utf-8?B?RXJOWklNeXNlcG0xaHJIdVZhUVFQTE5TMUw2c3lHTGZlbVU3dVhpaVlyZmdG?=
 =?utf-8?B?SXFzbnZLYWNyZ0h5Vm93M3JYS1RQa0NHZEY2SXhvTW9iWW9RckRvMXVSRlhm?=
 =?utf-8?B?QTkrUW5CTUFNUGJMN2daRFY3cFJId3pUTmRjMTdKNXVQMVFHUEN2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669e333e-015d-4502-3faf-08da3292fcb2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:40:11.6718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrC6Ym9/Ke751dhPSN2ZfOaMwGWm3IMOP+FgbzelP8NlyaH5hK2eqziSBOH05CtgJitY4sh6FUOOUyKkANN09w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

On 5/10/2022 08:51, Alex Deucher wrote:
> This reverts commit eaa090538e8d21801c6d5f94590c3799e6a528b5.
> 
> Commit ebc002e3ee78 ("drm/amdgpu: don't use BACO for reset in S3")
> stops using BACO for reset during suspend, so it's no longer
> necessary to leave BACO enabled during suspend.  This fixes
> resume from suspend on the navy flounder dGPU in the ASUS ROG
> Strix G513QY.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2008
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1982
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Make sure to CC stable as ebc002e3ee78 also was.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 395f266be690..956062496202 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1390,14 +1390,8 @@ static int smu_disable_dpms(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   	int ret = 0;
> -	/*
> -	 * TODO: (adev->in_suspend && !adev->in_s0ix) is added to pair
> -	 * the workaround which always reset the asic in suspend.
> -	 * It's likely that workaround will be dropped in the future.
> -	 * Then the change here should be dropped together.
> -	 */
>   	bool use_baco = !smu->is_apu &&
> -		(((amdgpu_in_reset(adev) || (adev->in_suspend && !adev->in_s0ix)) &&
> +		((amdgpu_in_reset(adev) &&
>   		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
>   		 ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports_baco(adev)));
>   

