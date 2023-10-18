Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF48CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 18:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680D010E453;
	Wed, 18 Oct 2023 18:02:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358CB10E45A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 18:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6bzFrtKaFMlnSVDxKiZRcYazZAWn5eLVvKXTuJfsm95IS6u1ynKj/yueBYcpoOUYf9RUoUIv2lpZOoQiiuPFizZRY9RCnuW+f25fF3mQUeHopEqVbBTHj+PzipNh7YV/LZTUdi9aApSgn+V/hxgCa7HqBlLYyVchqa2PPt7QyH+nmc+iZSNQGrDsa/nPMdbKr0FT92AiQyxMzRHmD6Z2bWP+qVqifXHC179V66P/2bcvuWg3rb0Jl0uexwk/p9JisEJGVh0RJYM4KDEj5gGf6Tfn3XvEZeQcJHlYV/ZtLsU/sESifNUq+PmZHlfcBaFtSZ1cOPyD1zHBZG1S6NW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEqnxU1oGXdgKgpJLufyGeDbpUUeexQOtSq3q3Uz5tc=;
 b=IDc/W6BQan/d8aFuezfAv8qH9VMm+xtXfC5WCd3QCHolGvwsJH0P5qDFf/WfCaayNSitgiP2psgLne/17O4oDFEbDLZTao/H60yFSsQJb7U6S5lYk3HSgQSm9H7/YtSz2PLPDJ5xFID/7BsJPDz9KZ/Xab8OnWVGesqF37vzXv1aTI5b4FLEcEzRQOSvGLvPZ2lNciSieasCjHV0w1/Y3rKnmkyHhE50nFZwpxGQ5NupZ4QPzvjvbD3EYMS0Q+x22tIG+A1CC5QKa/5ISViX6GPH8QulFCoYpU/sS9BStE2JF9EzVGVuruZoI7e3fXgdeyp/r4/a0DTgFRQ+Njufvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEqnxU1oGXdgKgpJLufyGeDbpUUeexQOtSq3q3Uz5tc=;
 b=wVil+U6SMtAnc5zhaZYZBrHXleiz0rPpRuOvKbjJG+MMI/S/uyKqKo4Xhu5wyxK+83ayRc6dUEaPc2LtgTlVTDM6QQ+jk/iU1/KmEKBs2fLp6l3ujo6rEURsMmNZuoof/XOzbVU46GtUQ4WMMT6DwcmTkEAb4k4vWT36UiMO/KU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 18:02:10 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 18:02:10 +0000
Message-ID: <8adbe624-14eb-4825-bf27-33af64b68191@amd.com>
Date: Wed, 18 Oct 2023 14:02:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/26] drm/amd/display: Remove power sequencing check
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
References: <20231018174133.1613439-1-Roman.Li@amd.com>
 <20231018174133.1613439-4-Roman.Li@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20231018174133.1613439-4-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: e8fc1d30-0cfd-444e-b754-08dbd0045958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DuPEoRtwE+tmExelaZCkf8Ff1Ce/ez6/KRFej32BIhi7G6fbRoUU/kubHWav7yqxdta6UMbjp43f+997OK9cMXeFZmk3H+9USRlhT4pIT2WbCjlUZJW5NfpBd0i5FPTCZgyy0qr5OW7YXrfzKE4pgZQ3dtkEgY/v5nvX0CYfBWtgJ7qZjkfAIbM7tRhBB0SSzpNwChU8uI+pmQQHvbY0aL3097ecuCEGvfupsbRRXtPvC5WoCzI1ynwj7Xig6mfjypAaY/MC4qt2+NAXYyUfWopxzPHfckkYJneVIG6pvxCZTLfwVJnKw9sbtvIxx83sHrOckPgwIrGvysTQ9DLssj9cKh+Ahuq7ydiZ5GtwbFRcFQIRzVyUai8tMFvlGSehHCczsG655fgptrwB13XnZWK3mW9ztrmfr4pqYmtG0b2BGNWkhwYhrEuoeXEBAw9Qq+0pEV+fjUIto9DFU8qv/24NQvgGv5BKSOvsgfa8p4BffeRqCem79+df+l0KCS/6WYBJQ1QuYC1snYZ3OgpVkV7Rg80Gu9wtSol0ISJFsZAaK9LkUA/SnbuxPYGqVfWKMscLd+dTYCANPT+kbkFDBporGamCW06NSt9g4487CXVqxMjc+8JvcoCKyd5URNs6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(44832011)(26005)(2616005)(8936002)(8676002)(4326008)(5660300002)(38100700002)(83380400001)(31686004)(6486002)(2906002)(478600001)(966005)(86362001)(41300700001)(31696002)(6512007)(316002)(6506007)(6666004)(66946007)(53546011)(66476007)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnl5TlcrVDNueGs3SDBJdkVmdE8raWEySVBWN09FUDRIVnNhb3hhUmxpeDB2?=
 =?utf-8?B?SUYwMDY5dnl1MDN5VmpxRzVuT1BFU2NYQlh4WkxiUFJyNG1EeWV6MzlhWGZm?=
 =?utf-8?B?MFF6SHN3cVQxa3ZGa3FxcnFHYjMwODVxdkZ0Z25ONUg5anlIbFBtRHJvSFlk?=
 =?utf-8?B?SHpFU1pFVHhDbzVKdTdJYkIxZCsvcFhhOFlLZTFURlV3akFrdFV5ckNJTDhr?=
 =?utf-8?B?c3pHbDRDRW9kSG94R0YrWnMzdE12RTlnUUorakw5aUEyMkoxWTBoTTVoZGRx?=
 =?utf-8?B?ODNLRWthblYvU2EvUU01bEdhL1V5SWo0M1U0OWZ4QzE1eVZHdjVZRmlORndY?=
 =?utf-8?B?TS9IU2dVMEkybkp3QUJJQmdXUDdlcTA0TzRSQXBvMEtUYVRmOG1vLzEzejVa?=
 =?utf-8?B?NmlPcU01QXkzQUt2SVFZY2p5YVNWU2VEU2NyRmcwZEdTRzUyRS9sNlEzWVow?=
 =?utf-8?B?OExkeWJXemdXWmxnNUFpdHRZNnpBUEgxbXlDWjZGMlZiUnJZZVZ6VTRuQlVE?=
 =?utf-8?B?Z2FGa1JoTDgrSU1hN1llTWZxVHdoVUtBL1lBSTNtc1lzeUd2eHY1SHR6NStp?=
 =?utf-8?B?eGhmeGhrdGZTRUVSWUdVNUxHekFVWmFHY0dpM2lZS1o5aHMvampqZ3drY0tQ?=
 =?utf-8?B?aEJLOElUSjZ3SjVVcjFqbUltaDVLQ0t4Nml1RUI5alpyK0hlUEZvcGxxeGFt?=
 =?utf-8?B?L3J4OVIrUDJhSFljWkpPWXpDaXVFNzQ5VHNwdTdITitjOGpkUzRjTnRaRklj?=
 =?utf-8?B?M1FXVkFTVDBoQko1Y3FleEg2NkM4U0RnMU1IQnRuUFNzdlRtVmNLMGNmakRJ?=
 =?utf-8?B?dUdsNk0zOGhwc2dSRUtaUm9wSmxnVzF0SFVNTG9OdU16K3FqM3JZY2xaL0Fa?=
 =?utf-8?B?M004aGYvRTlPNlVsUkZmdkVHdU9XMDVTZnZhSmcyNHV3MWhDbXIraVJLdXNS?=
 =?utf-8?B?Q1hWc0lZci9kcnNVSW9wckdBODB6T3BTUXhDbzVsNXU2VGVZZklkSHpVTklP?=
 =?utf-8?B?cUJZSUtQekJxNVFuTjVaaEJ2WFc5SzFyd1dVTnRGYU4ya3hFNDlsQlFkMWNB?=
 =?utf-8?B?RnJ2QU04dWNpYjBlRHAzZnViU0NYV0hnb3NIMGgyb0xiL1YvbTNsSUNNWUNm?=
 =?utf-8?B?WGhkUHVDSlgrUHZxZDZabjR3d0pwNXRkSEtNTHRLNFduWTFkZGxYZ3ZLRzZD?=
 =?utf-8?B?V0NQdE1iMEVaZzQ0bFdubCs2YngxaTk0Ymd2WnRHSm9OOHRzTURXQnNPcW5C?=
 =?utf-8?B?MnhaQW9uaEF2a1pwSnloK2svMUxDTE5iK09VRk5ZN2xib1JFQjJqQ2ZqbXZM?=
 =?utf-8?B?Qk1FSC9vb0pKRHA3Nk9FMXAza3ZUd01IZXRiRCs1UDFkN3VNR0NFQnJVTzRH?=
 =?utf-8?B?R1I0S3F3a0ZHK1pXejVjalNjdnVqcmlNRDN2VG5YNjhFSWdqRkQyM2swbjBG?=
 =?utf-8?B?TkxsTmhlblBEa1NTMnZZRXY2NjY2bEkzbUpTTTh6MXRMNnpNK3FwZVRhWHkz?=
 =?utf-8?B?ZE5XU1FXNjM5aWF1RnFmSTBjSTVxbXNvY1R3V3NDZGZjclRSTXZMTEMvMDdY?=
 =?utf-8?B?LzEyT3IwNVRRMXB6azZ5SzVOR0p2VndoTjNhTEZoVjhReHhkQXlueUlKZzd0?=
 =?utf-8?B?N3VUbmQvUkp4N3g3L1htdG5aaWFHclVBbWx5RlBidVJRcWh5b0crYllpK09Z?=
 =?utf-8?B?QldBMFhBNVRCNWFlM1RVN3ptdFNSMHlGQ2JmUmk4WGNFUUVrOFh1cnQ1eWFv?=
 =?utf-8?B?U0FxbjhaYnZlK0RSZms3aFk4MTcydFlVaGUxQ2t1TmM0TjRvS2pZa1RSTk1O?=
 =?utf-8?B?R09Qa28vNjVuWEpUYnFFWkM2SGVxUlBBTFRTbEIvYXR0QlBhaVY4WUNmMVNr?=
 =?utf-8?B?d3NINGhaSnBGQlpKbEVTMFZFVldLZVk4Q0piSzZkN1BQcWIyeEJJSGdBQWdw?=
 =?utf-8?B?UFlMVXJpRkVwejBiUlcwa2l4b3ZmTFZUQkN4dVY1dHJuOXZ2QzNNTnk1U3lB?=
 =?utf-8?B?MlR6MkNoQkwxQXZRRUJvU1ZGMy9mZGRQUFkzQUMyU0VlMjJJaHYyVVUyZWNR?=
 =?utf-8?B?OEwrODNwdWRVazJoa2c5bHE4dnlQeDZlcGhmVkRId1ZoOW1XWkUreWFIcERH?=
 =?utf-8?Q?Uc6H+fDEHh+oqjLvz20ZzXUIL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8fc1d30-0cfd-444e-b754-08dbd0045958
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 18:02:10.1928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /57YlI90CaT11TIEmIyJTmmlIznQr+UmSaRYlG/Lez9Z/TlPxCGXRDB9nYmGtlsHrRUW5wX4E9bZugyMutWGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/18/23 13:41, Roman.Li@amd.com wrote:
> From: Agustin Gutierrez <agustin.gutierrez@amd.com>
> 
> [Why]
> 	Some ASICs keep backlight powered on after dpms off
> 	command has been issued.
> 
> [How]
> 	The check for no edp power sequencing was never going to pass.
> 	The value is never changed from what it is set by design.
> 

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2765

> Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
> Acked-by: Roman Li <roman.li@amd.com>
> Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> index 4538451945b4..34a4a8c0e18c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -1932,8 +1932,7 @@ static void disable_link_dp(struct dc_link *link,
>   	dp_disable_link_phy(link, link_res, signal);
>   
>   	if (link->connector_signal == SIGNAL_TYPE_EDP) {
> -		if (!link->dc->config.edp_no_power_sequencing &&
> -			!link->skip_implict_edp_power_control)
> +		if (!link->skip_implict_edp_power_control)
>   			link->dc->hwss.edp_power_control(link, false);
>   	}
>   
-- 
Hamza

