Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE79C02185
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 09:48:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02FC410E1D6;
	Tue, 21 Jan 2025 09:48:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7KpKFOf";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B147F10E1D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 09:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHu7bnNF/fJiJoVDAIiLsTjTczPKxGq++G2vPgglzjmSeOEVbsurW6b8MJouX2rVdfEY0jyxmuD7hdKfmFt2WO+teDwSN/Kupw7cYxVyrSaMkWvnlBzTKEdRUCTueVc6SZmWXG5l22U6U3xLE+lW5iPDgCDuIQ6g53IfgSVnltBXwnSbc4lECyjPwzPV+4Ik/qtTa7tIFXDxkSml5q81LlUa0x9GZ77hg6RgfpsTCIdJQsxMT4JhQenOsGRUBADf2aYut78KDfXbymGPHo+EhUta20GyHkEnFR6+ZeOa2pQHHWxWy65gEhUX6s5z603lxcWYzpr9fOdR1x6phIlWKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD1Zc5nVEMccyO9ISF4MVN2VTK5yKvG7bTMan2gAQGw=;
 b=wrGFzxzsjK/J4Kf3FeNfOlRQL5dh8TqUFLlvsc0zzZruJ1lvxpfZug4Ad+s8IPQ29LQq5PGlzCtZhw7QnPqY+ODrfDuUupALpkwPr3dW/AgqpsS2ksou/bQiWkZkhDGGQuw/HhuEvl5oU9ptHg/6jg5oPMBZMLBijytEYrl6KG55UUqpgW55tF1u5GYwMS0IW2xGUEtqg9/+wGVgiv9vnmzwxqmzF1EZDCaNIROl9K5ZUskdKOztaHiBOJQc3KiOAoAxJD9ngZEodDHrPfEMmMHN0d38V/dQIKLPVEmpFJqHKwSctx8W3tZySUg4mmtUxR66IO8n3c1O4Zf4/9iVbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD1Zc5nVEMccyO9ISF4MVN2VTK5yKvG7bTMan2gAQGw=;
 b=T7KpKFOfa6CiyS7KFn5p78R24fQ4tSBZnyLcciQEbKz8W6xDaiJbkUXK9chUmjPSB52OuUTJ7FzAqP7yMnWWgDS36odF3wQ1Eva1aIGdRYhbBFDl75/PURcUwpkJLItn9+jsVYG7TT+w0iD0NWr6a2LSVBvzHg1wYHW83kw0514=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 09:48:50 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%4]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 09:48:50 +0000
Message-ID: <7bcb053d-dc8a-4b3c-952d-d23197862c3f@amd.com>
Date: Tue, 21 Jan 2025 15:18:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Update smu_v13_0_0 SRIOV VF flag in msg
 mapping table
To: Yifan Zha <Yifan.Zha@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Cc: Horace.Chen@amd.com, haijun.chang@amd.com
References: <20250120034918.1835607-1-Yifan.Zha@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250120034918.1835607-1-Yifan.Zha@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a235e21-bd6e-4c1d-33fa-08dd3a00cef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cFV2cld6cmJSODJsVWRWM0RvMjQzTkh1dmwvRnRzT1N1MkdkaHlaNlkzVmZa?=
 =?utf-8?B?ZVNhYjZqcWlpMHVUSnRNcU9WR2VEVzlrKzFHR3hBYlpZOG40TUpGU3VLa25Z?=
 =?utf-8?B?eFNhM0hUUVpuOWJ4TjBnb1U1a0I0ZmlvUS8xK3l2MERPZXlWekJVM1RreGpZ?=
 =?utf-8?B?T0RnclByWXM5NDY5VnBzWW0ybXJLaFMvZFQ4TG1PM0cxL1J1ZkljeVFlSDlm?=
 =?utf-8?B?SjdsZ2NLOEZ3Z29pcnZDa3JQZzNTRjdQRnc0SnRPcmV5VDdWUnZtSHlMZHJM?=
 =?utf-8?B?RWE2cWc0UkkyVitmTmMxN0RoQkJKc3lVeTVKd044NG80NkszWXFOTG9kRkV1?=
 =?utf-8?B?M2kvS1N5bFpucTU4Z3ZSYUg2SXljUmxZdlZFQmN0M1ZyNEFsSTF2elZaMVZI?=
 =?utf-8?B?MUQzQ1RDdW5hQ2o2Y1VhR3owdmRPTC9uVmlNcklnWHVtazhXd3dLVWhMTTFx?=
 =?utf-8?B?aE1kL2VzTjg5VWxQMkVvZ21lT3J5QlNnZDd0UkxuejNsMXRoUEQxYVprdlhF?=
 =?utf-8?B?ZjM0QTBlWUhKSy8rMFNoTm1QY1BIY2hNTWc5N1c2YW9WdjAyZllTdHJjUzl5?=
 =?utf-8?B?RGlIT1d6TmhSUUdqWnZpNnVnZ0NOai9zYk1JZXlrZVVId3Zwai9Uc0YrcG05?=
 =?utf-8?B?R0pyMEw1YVJEQnBSQnBxMmwxZmg0dFBtbEtsY1oxbkpHWHQzSjBrajk0Qzdv?=
 =?utf-8?B?U2tGaDFBaDBGSVFOMG1qT1hrR2F5MUo2MkJlNWZ3MUZPL3M4ZjlrVEliczdI?=
 =?utf-8?B?U1JCU0kvdUpMNDg2Z2FET0Q3eG5UU2thWXVTM09nSUtNQ0hjeFh4eW1sWXZ1?=
 =?utf-8?B?M0x2NmhXTWo2NGFRN2FBQnlObDd4RlF2MzQ2TmZGMEtERWRLL0xPL05ORkV3?=
 =?utf-8?B?b2J4V1c4Uko3MERVV2cyOGxGR3FFdWwyTGdqdWtUbUdmbHMvZERCWTJUTzZ3?=
 =?utf-8?B?bSsyK1RWcmtBM0YzeXhWL0s3Y083RjRrT1F0bWgvVnpSejNTbnluSTR0UUxu?=
 =?utf-8?B?Y3ZLZXFydVZocG93MjFELythcWhxZ3pSbUZVVGRQaFpqVDZweEk1OU9tcUk2?=
 =?utf-8?B?ZytENFF4L3BmL2hnS3pLZWwzVjE0YVk3UFdqRDV2akpPQTRWYytpOGxnbURs?=
 =?utf-8?B?RU8raWFjNTdSOUkycVY5aGltSlVqNENtYW8zY0VYRWZHM2dQM2xSWnZlM01R?=
 =?utf-8?B?YWZSMm1tY2ZrWVhoYzZ1VGtQZ3RQUzI5WHBXSXZLQTNDYm84ZmFCa1RhYWRq?=
 =?utf-8?B?SEZYejlHb1MvdXJoRXMzc3NYOHRMRk1ycTB1TCtrUVhNWDVFQldabzBCSDdQ?=
 =?utf-8?B?NlR0YVhXZXhKazFFZWlLbTUvUFU5Yy91WXdPZ295Q0ZTMFJLcVErNC93UFpW?=
 =?utf-8?B?Rzd4eStJOFJZbU9XWXF5ekRTTXl3SXp2akxzd082THNybkZ3YzlqUWN2bjhB?=
 =?utf-8?B?SmY0UFRpeEhqd29KMVl3Q0pIbzRqYTgwZHhjMGU3MjdvZDdldW1zQ2o1OEJ1?=
 =?utf-8?B?THBYS3E3bzhPVENuVlhUbnpQbmdFc0RZVUtKcEhUMnFmY0VpdURtbzUvaEZl?=
 =?utf-8?B?akExbFJKWWNqMWJmYUJPYkdjMXYwclFJTiszZy9VSWJ1ZklnRS96Nk5nWVM0?=
 =?utf-8?B?bGx5ZFZSdU5LUUU4MzAvb1QycWthVVplblpuV0I0OEh5V2dTNExZcVlScnJs?=
 =?utf-8?B?SlhMMUgvai9zTGVxOTRwUWZlVnZtb1NTNDhpT1F4dTNZRG5mb05ZSTFHT2V5?=
 =?utf-8?B?RHI4dTNGbUdEcG00WnljZGt0bFNQQ1haS20zQWlCWFZxa1Q5U2tyM2lEbUFU?=
 =?utf-8?B?bW5LeTg0RzRGbStQUmkzWHd3cW8xbEs4ZFBiMER6emJ6K2ZQdDFEcHMxV1Ey?=
 =?utf-8?Q?v/62wE3cLPIp8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2poSmxMeDBBajBUSHI1T0x2bitGNXQwdi8yczlqbDdrU1JxS0lRTG5SVXVJ?=
 =?utf-8?B?UWpkUGRhRm9wcmNUVUhlK1Q5UlVpbm5Pa01xZ2Jha3dEaGdaV1Bpc3pnYlZm?=
 =?utf-8?B?cVVvOEdpbWVBaGh1M29rdmQ4bkcxMHhXZllQM2ZzbmxrVDJpZFNwaDNWUVFC?=
 =?utf-8?B?WUMrWDIrb1oxVW9OeDcwOVFJaFVOVGdUcG1Dd3NNYWZrcFJlWFowZ2w3dkF5?=
 =?utf-8?B?b1lOcnJRdkVqT3FDcGthWk9ZcG0yY2dVazVwMGxEUnJBKyszRjJmTlp5RXh2?=
 =?utf-8?B?V0g5WlVGdkg0SStTazBnemovc1I0b1NrZE54Nm5qVTVxTzIvcWs2M2R5eTQ1?=
 =?utf-8?B?QlF6STVVQkRhUFJKc1Bxc1plY1B3ZTBBR2pmTEI5cHdEZ0hyclZVUm42c0lG?=
 =?utf-8?B?Uzd1MWdzUGN3NE1jb21LeEZtbnVwcGlNVjNkaWphekZJYmdGY0IvUDF2QjNq?=
 =?utf-8?B?bzFZQWlXcmw4bngvZmYxckZJcUpYb1dlcUFJdDhsQzBvTHpGN0s2Z3lYNDY0?=
 =?utf-8?B?ZjQ2N0VkS2txN2FLTHJpN3NXWmtQMEMvQko0cW1RaENGMkphc3N3U3NhK2VX?=
 =?utf-8?B?NjQ4L3pPdXZGZVZtdVdYQ2FqL29FM1ZaRWJ6bllSWWN2bk94SmlQVDNTc09p?=
 =?utf-8?B?U3FaUXRIWmgzZCtaTjA1WUcvaHRMT0o3b0NqMi9DVklia3JaOTNCMUFldzFE?=
 =?utf-8?B?YTU0azhiTCtuZGxpZEJvTHVZMER2TDlJV3g0dVR0VXp2aHEyUHdHM08wTWFq?=
 =?utf-8?B?cm13L2pnR1IvbVMra0k1cWFIRUlERVoxZDdwUTN4K05ESnFnaW5zMGg4anl6?=
 =?utf-8?B?TWlUN1lTNWZPQ2NPc3pPL1ljRmM0ODBKekRhVExYNE02QmRKMmF0RzlhTTUz?=
 =?utf-8?B?Z0U0WXU4cFpBcld6MU5DRURKSlFQVFVZM3ZObXQ1S1k5UTR6UGwwcjExZGRk?=
 =?utf-8?B?WFJobXdhdTlmcEgrY3JCWFppL2RWT3FlOWJ2ZW13RWFwOEZLUzRYVU03ZHla?=
 =?utf-8?B?dk1TV1pTcHdzckpEMWJBK0tmNnp3REtoL3lWRjhyVGRON1lNVHMveERiSVBo?=
 =?utf-8?B?VDRBbDVvSmRabzRGV2FNczE3NlE4R3MwWXRGajViYjgvQzkzWFFnVzIyWGU0?=
 =?utf-8?B?eEdTZ0JuUnlFMmtpTXowaW5xYVl5MUE2bVVzaTg4d01aUENkejNXSmM0NkJC?=
 =?utf-8?B?UnZ3TXlRazRhWnprMWdCZTZ1cEFrd1FRYzduNHIydk91ajE1MVVWc2xieGow?=
 =?utf-8?B?MXN5SFlPMjlFdFRGVTA4Y0NwZy9YamhLL0FldzRnYVZaOFI3NkNtcU5Za3d5?=
 =?utf-8?B?QUhUQjFQWE9UQWRrUTY3amhIQXFYODZZZkwwbkM3cmllczlpdXJxVmtNZ0tJ?=
 =?utf-8?B?QitaVS94K2FiS3BhWlBRRnlIY1Axd3Q1OFJkSzZHQTdwcUVwK2tjYUV5R2dW?=
 =?utf-8?B?QlJxWHh3QzllNFR3NVU3ZDRFVE4xUDVNbGNPRzlPQzB4VXFabEdNZGRHMHBC?=
 =?utf-8?B?ZlJVWU1wb2RWWU9tbFYzREZiYlFTQUVlWnNpTDdidWN1QWN5UGxiMEVPQzR6?=
 =?utf-8?B?OEdVWG95bmxLY3g4YTdWQWFCRitMWUh5TTY1TXNScVdWZnNnWVpwRmQ3NWhR?=
 =?utf-8?B?KzBpT1U0SWczVU5XYlY0UFV0eHRVMHVCOWVWaUEwek9YcVRHRE5LM29mS1h4?=
 =?utf-8?B?UnlLUXI4VWQwYUVnMU9MZkdtcFRWb3BJbGVlTVk4ZmNmc0c5eEd6VkdFV0hO?=
 =?utf-8?B?a21QeDBRSnVVdTdNM1MrY0c3M0sxS1ltbDFLU0JyL0tPTmJyUnJtN29nK05v?=
 =?utf-8?B?bFVLSm9QVGNWRnNBYXpUV3VwYnhMKzNEQXRYNDFibFFTVnFEaTF3MW5FTEw1?=
 =?utf-8?B?MzlZQ0UvS3UwRHhURzF5NEFBUmd2ZXlBZkFlWVZjWFVCZmRMd2lTbVRGT3do?=
 =?utf-8?B?ZllyYmFJQUhCWlNtQkR1cFVzL2pKMGhXeVNDMG5oSzlBcm1FRmQxWVpEUnNU?=
 =?utf-8?B?SFF6bGk0YmhsWmt0VlhVdktIUFR3azNDRXFJRlBkWk82ZGQyQXdiTytDU3hz?=
 =?utf-8?B?R3hHWW81bmh6Z0RVMVgvSWJ4T3M2NmtRWng4emVodjRMUiszTUhjK3ArWU0v?=
 =?utf-8?Q?BTlS/zN0hCnLJPxyf2EFF4ti1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a235e21-bd6e-4c1d-33fa-08dd3a00cef8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 09:48:50.6809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdOb6vLppagqeFprlB+zxDDAui1O5sK3WEnH8qwo4/pfN4xdfjbF2Gjh4sixuczo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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



On 1/20/2025 9:19 AM, Yifan Zha wrote:
> [Why]
> Under SRIOV VF, driver send a VF unsupportted smu message causing
> a failure.
> 
> [How]
> Update smu_v13_0_0 message mapping table based on PMFW.
> 

Does this hold good for 1VF case also?

Thanks,
Lijo

> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 0551a3311217..985355bf78b2 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -126,7 +126,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(DisableSmuFeaturesHigh,		PPSMC_MSG_DisableSmuFeaturesHigh,      1),
>  	MSG_MAP(GetEnabledSmuFeaturesLow,       PPSMC_MSG_GetRunningSmuFeaturesLow,    1),
>  	MSG_MAP(GetEnabledSmuFeaturesHigh,	PPSMC_MSG_GetRunningSmuFeaturesHigh,   1),
> -	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             1),
> +	MSG_MAP(SetWorkloadMask,		PPSMC_MSG_SetWorkloadMask,             0),
>  	MSG_MAP(SetPptLimit,			PPSMC_MSG_SetPptLimit,                 0),
>  	MSG_MAP(SetDriverDramAddrHigh,		PPSMC_MSG_SetDriverDramAddrHigh,       1),
>  	MSG_MAP(SetDriverDramAddrLow,		PPSMC_MSG_SetDriverDramAddrLow,        1),
> @@ -140,7 +140,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(ExitBaco,			PPSMC_MSG_ExitBaco,                    0),
>  	MSG_MAP(SetSoftMinByFreq,		PPSMC_MSG_SetSoftMinByFreq,            1),
>  	MSG_MAP(SetSoftMaxByFreq,		PPSMC_MSG_SetSoftMaxByFreq,            1),
> -	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            1),
> +	MSG_MAP(SetHardMinByFreq,		PPSMC_MSG_SetHardMinByFreq,            0),
>  	MSG_MAP(SetHardMaxByFreq,		PPSMC_MSG_SetHardMaxByFreq,            0),
>  	MSG_MAP(GetMinDpmFreq,			PPSMC_MSG_GetMinDpmFreq,               1),
>  	MSG_MAP(GetMaxDpmFreq,			PPSMC_MSG_GetMaxDpmFreq,               1),
> @@ -149,7 +149,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>  	MSG_MAP(PowerDownVcn,			PPSMC_MSG_PowerDownVcn,                0),
>  	MSG_MAP(PowerUpJpeg,			PPSMC_MSG_PowerUpJpeg,                 0),
>  	MSG_MAP(PowerDownJpeg,			PPSMC_MSG_PowerDownJpeg,               0),
> -	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         1),
> +	MSG_MAP(GetDcModeMaxDpmFreq,		PPSMC_MSG_GetDcModeMaxDpmFreq,         0),
>  	MSG_MAP(OverridePcieParameters,		PPSMC_MSG_OverridePcieParameters,      0),
>  	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,      0),
>  	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,       0),

