Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5933EC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 10:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D934C10E2E8;
	Thu, 20 Jun 2024 10:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0uEAsOtS";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 040AC10E2E8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 10:27:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8+lOggf2Jnj6NtpGBhaEsvtIpSzXb8hupKRlPolzx3q4pxjFwXfW75Xzd0xYtFXhnqvRar/I/MKfZPL7D5IrYDnej1B964Y79Uxicd28h6VLG8yiTe005h322F6yHJ1XyZoG7kEod5iWhna0vqdKfgrdCXQH/Gp3ROFbvh2c/4jvui99E/zYqYsnDM2+2VvKlx6sjW/4dD7IbrECK4uM1r13TCm7mRQ3wvo2LyH2Cl8z5MvwGrsEC453d5fethk63NnTyS+ARwCLRDRIHP9T3PZ65HEl5BvhZGkAhlI86wnhEAI16wmd2pM0rlOzlJDZW85KgXbBLeLDcZ0Wn+3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvjtCemDzMjI0H4Dq6L3IVNtJfoVzxIJD2XGdPrajlw=;
 b=hbe4hjrS0cpn+zjp6jgcrVWVN700+Zmj8lh+ZIq04wsq9NSc11BzKvsijEujcWohpf3sXsVjjB/5qVCGaQJhzklbfuo2aYIY+IX2W4Ex1nj1xDHeckyxaDauzO3+yeLiGCXFS+9ArDrJdX9YerPc97EsAkHI5YueboHR+63N8OvuH7SKldV87TQEmrDDRrMtSglVMx4EQ/iC9aIza3V3PoQfwL+H+2ZrVbmvLZ+zkWcdAgkMK3Bxc/Ao9JpFvsXbz1TxROFKu6h43R2oQx9lKF4OO3crHRcEkAMzvJKYRGf6eplvDIXavP3JdBbWNjipvungSnCHbAmaSyrjjIvRuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvjtCemDzMjI0H4Dq6L3IVNtJfoVzxIJD2XGdPrajlw=;
 b=0uEAsOtSMDCCGMm401LaWyme5LrNHvoReYAOHCsaaM0VWyu+JvXqIYWQ28NbTSpAtP+x7kRCmhFJO0P2RE81qWxC1sPfvZefDkzOh+eDE88MRHf5DSRm9jQJuePCzmtcer3ECHGm23jrtXKaEPdixjTyJt/lYn5HtEBpSRQZTK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.19; Thu, 20 Jun 2024 10:27:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 10:27:34 +0000
Message-ID: <e1efc625-a39e-4690-8105-8c5d9f319dba@amd.com>
Date: Thu, 20 Jun 2024 15:57:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: part I - normalize registers as local xcc to
 read/write under sriov in TLB
To: Jane Jian <Jane.Jian@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240619163147.1706778-1-Jane.Jian@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240619163147.1706778-1-Jane.Jian@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0112.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 421651d0-77d6-4811-d39c-08dc9113992c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTVvVUdHVnFuZ0VyTDI1NHJtM21kYklTTjlRVGF5Q1dwNzVDcWJTK1didk1D?=
 =?utf-8?B?aTZDQi9EZWlCOWJ4Wms2c29mUUZMZzVWMDA3K3kzSjEwWTY0cWoxdVB0bnpJ?=
 =?utf-8?B?SUdKZkZtemVDNnI1bzJtV2F0aXZmdHpJTGw4MUg0NGZhS29KS1E5WlFJb2p6?=
 =?utf-8?B?SWM0OCtNUTBHK1NvRDFIc0R6TW53Z0Y0MUZpSFFEUmY1WC9OZEQ4SCtqOXds?=
 =?utf-8?B?UUFwdXd0cUFPT3B5M2prQ2IxOVI4dmljSG1pdUVyZDh2eUlmM1lFV3FkM1NY?=
 =?utf-8?B?dXJQdk1SYnpmTFFCK0NNQUFvdG9ZSU02Ny80QW9NUThEbStCUGlIOUJUZTNN?=
 =?utf-8?B?UDd2MStIaVgxTFhtM3V0WXhmMjBHRjVRUC9QTmtIWnAvVW8zM1JxWEJzVXJM?=
 =?utf-8?B?eFVadzFlWmJKZldUejdZUWNEeWNjWkpKMHNZaEhnMjUzNVN3SXZxcDVGVWJw?=
 =?utf-8?B?b1h0Vitid3lDWkE2TllGUVEvR3EwaXRiK3RWSHR4cFEwMFl6QWdnUmZVTWZK?=
 =?utf-8?B?Z3J6cnlJcWU2clVqSmREcGFyQjBGZnorMlluUW12eWZjQlpRc29hS3UwK09Z?=
 =?utf-8?B?VnMvbURNRTBPRVhuRVVrMnRPbmtFVnEvNnN6T3dDZkUvMEZzZTNMZmV0ZEtZ?=
 =?utf-8?B?ak1GMTVUYnZRS0hNMEZqdlk3MFFua05ydXl0MGRuUWNhTDFkVzY2bnkySitE?=
 =?utf-8?B?YmRGUy9mUTZCdElianhwcXRwM3BNSlhRTnUrVFZjbWVMV0UzU0h2ZGdYYTA1?=
 =?utf-8?B?NGxrTVIxVS9vbGJSS1pVNjlRWUFxRVZhM3dEcVo4SFJCYXhEU2h5ODFQbVFI?=
 =?utf-8?B?S0VCT3lnQnRRNncySmhTTFV6eHBVZUtzamtITXVCZER2YnpxeDlYTDlYdGlp?=
 =?utf-8?B?NzNsRTFyblhSTHBHdkZ1TzdNZUN5RmlaT2RNVUhZRFcwd0ljZmNTRkhFZll6?=
 =?utf-8?B?NDF1TEFGYzNIRnRwY2hMNG96WHdNSkhBUGdiRHh2Y0pTSzZ1RWVaNzN1QlNR?=
 =?utf-8?B?MGlUYmY5eXJYWGVsbG4wRjA3RUJGNDRoYjZlS2k2blR1Ry9aMHdJaWR3NjBQ?=
 =?utf-8?B?YysyWWFxVzRDTGVwRGJqV3BJc0l0VUg2WkVoSURrblFlMkVPTEpOYzRmdlRQ?=
 =?utf-8?B?U1d2NmFBMCtoS1BSMkJaNUc5TkQ1UHlXR1lJMlI4em9LQm1YMlpFYlJLVjd4?=
 =?utf-8?B?MHdDTm9paURCS1Y1dXVnMWpSSmZRbjVoMStiV21EMjRud1NvbytWUGN0RWov?=
 =?utf-8?B?MWJUM3hJQks5bFRZZXBDOTB6bUdBdEo4UktXK2VQdWUxVyt5T0dwNmpuTUFG?=
 =?utf-8?B?S3RQbnMvRnBVc0laWC9kTWJVQkVqREY4VTd6RW5USWVINk4rdUVqU2NwYVVB?=
 =?utf-8?B?M2p0OEszSW4wYzBIYmR2Z0tRSWN2ZlRDNEkvRThtelZKTldxZk1KMW95aVpR?=
 =?utf-8?B?SkJwRnRiaVN2NSsxNlFwUWZSVkdkVGdTQnlFYWd0ZlZiOEZ5VjlFOFlmdFFT?=
 =?utf-8?B?cTBZYUtxaFRkMEluYmRSQWRqUXBpNE15eHpUR2JNZ01JaWMvWm5IMituNmFV?=
 =?utf-8?B?TC9SQXc5KzlRSHVhSDdBekFSRTg5UjZjWUtwbTF0NjJmQzh6MUdCRkJZVURH?=
 =?utf-8?B?V0p4UXFBUTBMOUU3OUlJamxDdURVWGR1MVFiL0xHV2Z6Q2RxT1dZUmdpTmNu?=
 =?utf-8?B?M1RuMlZUTjJQOEhrQzNVTUh6M1NVWUY5U1lDQ0t1N2JKNW1DTmd4Skg5Z1Bu?=
 =?utf-8?Q?XloAQrh1adLxSE59UyVzAPCGQXMs/5DmZ/ozvZc?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlMSHd2WUJ3SVJ6bGltc3dkVGx2amkyR2NZd3owMG8wdTd6Z0ZGalpXa1Nx?=
 =?utf-8?B?VWZMTE5CaWdRYTIzRGlLWTlJdnpQczVlTGw0VzAvMElIYzM2aUxNMXM2UkEy?=
 =?utf-8?B?amY1RjFIczNSU29LY2c1Uy9ERWRWL1pNc3h2TXd3aEhqSmVxVU9ncWZsWG5S?=
 =?utf-8?B?L3NVZWkyK2kzVUJtZUY2d1o1R3RLRnYrSURhaXlweEtsYnFWNkE4SVkxUW10?=
 =?utf-8?B?bjJZK0UvZ2ZQWXJQK0Zha3AyVkRmTi8xY1R2VWJIZ0NMelluUUROdEQ1NC9V?=
 =?utf-8?B?a3hyWXpIVzdVYWdydnFlTWJvRjUxVkNTY0ZxQ2dEZ2pxVDdJRUpSckRJcjVw?=
 =?utf-8?B?ZlZCRVh0bXhJelJaNmt5SVFPSC9SQ1IyRXJ5amxvVHB1T2I5UkN2RVpvT2dR?=
 =?utf-8?B?SXNjMnZsQUFkNDNCOW5WZlc2Zkl4RGMyN0x0T3ViNkEwOXROVkdTZkpLOW5E?=
 =?utf-8?B?VnhLbyt3b1hIc1d3TnNSaVFLRFB4azhhRlhqTkRiQ0hTdDFpQ3lOenIwbXZO?=
 =?utf-8?B?Ti9hcC91RjI0dE5rTUhpQzJVODdxV0ZVM3gza2h1NXBYREJFaDFqcHVMZDJp?=
 =?utf-8?B?S2RTTVJmTVRDWkd6WElqdUd5YlgwdDBpNlIxRFRrWEt3L0xwNEJ0bFFVQWJO?=
 =?utf-8?B?bW5PUWpOaVZxdDhiWXZ1VW9RZGV5MWpkNUJQYXpoSWk5WGFULzNNZGhmZ1JT?=
 =?utf-8?B?UVI0K2V0SGxtYXUxbHhVcnpVb1ZHelluTDhBSVRJYkUvOUFGQlVmb0tkQkdI?=
 =?utf-8?B?UzFGeU9YUlRRaFBwQytYNjd1QzRnbWsvS1RyUysrTE1lYkxOZHliMy9QbTJH?=
 =?utf-8?B?QTc1d1hYSnNqZVpqdmhBdmtFV29pQ0lHcGxqb2pHd2llVCt3ODIzUUFlSWI1?=
 =?utf-8?B?Tmd5bXBtRGtPN3dXOWNyVVlUaDMzb2hVVzM2UjJtamhBdEdwTWxXM2VWZnZx?=
 =?utf-8?B?dVNzL3hieW0yejU1dk1nM3E3cFJsZmRzYk9tV0x4cFhBY2lsTjlUbWpLU3lH?=
 =?utf-8?B?K0t2SEQ4ZVg1dUpKOHZ0ekJuaXBHVXo3OXJWZVFyODZ2bStBcmRPMXNVVVFw?=
 =?utf-8?B?aUNXZDFjczVZWkd1WVprVWdvUDlTUGZDRGdzSVp5MXlrMDlqckNzSVFCSGxj?=
 =?utf-8?B?SFFtc0RTUFdSQzFBTGZyYnNtNEh5VFlaZTZTbnE2S0FZVVJ3d0ppcjZhQ1Vs?=
 =?utf-8?B?TG1kbTVzdjVZS0ZKTitmYWtTOWtjRVZqSkNMRmVCQWpoSmlEMEcyMVM1d1BT?=
 =?utf-8?B?aTRFcHN3MjJQbnJaWXc2R2xlMWZYeEtRK1Bqb0xtNnFvN3IxMml0NkdLTUZx?=
 =?utf-8?B?Uitxa2x2VlRjeEY5ZXl3KzdOVFp2MmFrUDlRR09LSzNCRm5WNi9Bb2xZUFZK?=
 =?utf-8?B?d1UwTytFdUU5ZTM3WFh0NE9zNTV5T3ROUnpnRHk3Y2VhdEl1Z2xUMUV5bUpB?=
 =?utf-8?B?Y3R3ZytLODZ5ZFFLeno0cTVoNGZIQWtCY2ZnQVZpeUhMY1FMK1FhWVBkRGNz?=
 =?utf-8?B?MnhDc0lNa2R5cWJpMGpVbXpGeklsNGVuNnBUaXlOVUY5b0JuMWd0TnZ5cmF3?=
 =?utf-8?B?ck1RQkZBaGZMZnBGVS9yOG05aG55dTlTa0JQWWdCU2hnbk55cmF4VUhmcllv?=
 =?utf-8?B?Zy9EZlpoYjhraE9kRHY3MENLN0FCZVpUdzF0aElEYldhUFAzbmo3QlFXaUEx?=
 =?utf-8?B?cjVkTVJBME5XcW5LbXpOVEtNb1BXckxEOE0xTWtiOFpWNS9uTzZKeXFsOGN0?=
 =?utf-8?B?c1BzT1ErUlZENVBGTCs4b0hPS2oxOHViRzBHck5qdHZFVzA0aVBKUGVhckJB?=
 =?utf-8?B?QjFZM2VLMU93MDlqNEI4eWQ5VjJmSHhqQTNxdldkNzlEOW9GOVhiVUVLTDNL?=
 =?utf-8?B?MVB5Mm5WNnFkS3BkM3hhNklBY29XMUI1d2U1bW51TkFqZ20wbW1BaHQ0R3U0?=
 =?utf-8?B?clJDc0w1czNCWTJ0Um5wRWlNMkdINE4yd2RBdDBvTmI0MWR4dXJsNzUvekps?=
 =?utf-8?B?Y1YyZ2l2S1Y3WmlBWlRGelJtbnQyNWlpejJHYUU0NFFNNjBRMlU5eCtIL3Vx?=
 =?utf-8?B?YTgwRkRZRHF2enFNTm94cDFScnIvQ0FmbXYxbzZKeTFWblV6cFIwK05UWnE4?=
 =?utf-8?Q?OU6qddr5A+eNGD8Hq+PaoUwto?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421651d0-77d6-4811-d39c-08dc9113992c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 10:27:34.3633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/Epb/Hp2RwdWF7paeO6Xy6EQrhO4rWGV2bmmAUZ/NdREYtofjx0ghXkHKf2d46F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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



On 6/19/2024 10:01 PM, Jane Jian wrote:
> [WHY]
> sriov has the higher bit violation when flushing tlb
> 
> [HOW]
> normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
> RLCG will mask xcd out and always assume it's accessing its own xcd
> 
> [TODO]
> later will add the normalization in sriovw/rreg after fixing bugs
> 
> v2
> rename the normalized macro, add ip block type for further use
> 

In subject, part I etc. doesn't look good. Only put the intent - like
normalize xcc register offsets for TLB flush. Rest of the story may be
put in description.


> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 16 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/soc15.c         |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.h         |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15_common.h  |  5 ++++-
>  6 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 083f353cff6e..eb2e7312bf1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -636,6 +636,8 @@ struct amdgpu_asic_funcs {
>  	ssize_t (*get_reg_state)(struct amdgpu_device *adev,
>  				 enum amdgpu_reg_state reg_state, void *buf,
>  				 size_t max_size);
> +	/* normalize offset to keep in lower 16-bit */
> +	u32 (*normalize_reg_offset)(u32 hwip, u32 offset);

Please change the hwip argument type to enum amd_hw_ip_block_type.

>  };
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index 2c9a0aa41e2d..9b4bea2ca7df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -1085,3 +1085,19 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  
>  	return size;
>  }
> +
> +u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset)
> +{
> +	u32 normalized_offset;
> +
> +	switch (hwip) {
> +	case GC_HWIP:
> +		normalized_offset = offset & 0xffff;
> +		break;
> +	default:
> +		normalized_offset = offset;
> +		break;
> +	}
> +
> +	return normalized_offset;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 88b4644f8e96..1d24e19f304d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -853,8 +853,14 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>  	 */
>  	if (adev->gfx.kiq[inst].ring.sched.ready &&
>  	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> -		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
> -		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +		/* Select lower 16 bits to write in local xcc
> +		 * for MMHUB it uses xcc0, NO cross AID reg offset
> +		 */

The comment about MMHUB is confusing. MMHUB offset in the current form
will be SOC wide, though it is passed to xcc0. Better remove it.

> +		if (AMDGPU_IS_GFXHUB(vmhub)) {
> +			req = NORMALIZE_XCC_REG_OFFSET(GC, req);

Since IP is parameter, naming the macro as XCC_REG_OFFSET doesn't suit.

Thanks,
Lijo

> +			ack = NORMALIZE_XCC_REG_OFFSET(GC, ack);
> +		}
>  
>  		amdgpu_gmc_fw_reg_write_reg_wait(adev, req, ack, inv_req,
>  						 1 << vmid, inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8d16dacdc172..e6e61fc77080 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -927,6 +927,7 @@ static const struct amdgpu_asic_funcs aqua_vanjaram_asic_funcs =
>  	.query_video_codecs = &soc15_query_video_codecs,
>  	.encode_ext_smn_addressing = &aqua_vanjaram_encode_ext_smn_addressing,
>  	.get_reg_state = &aqua_vanjaram_get_reg_state,
> +	.normalize_reg_offset = &aqua_vanjaram_normalize_reg_offset,
>  };
>  
>  static int soc15_common_early_init(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h b/drivers/gpu/drm/amd/amdgpu/soc15.h
> index 282584a48be0..f1e974604e3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> @@ -124,4 +124,5 @@ ssize_t aqua_vanjaram_get_reg_state(struct amdgpu_device *adev,
>  void vega10_doorbell_index_init(struct amdgpu_device *adev);
>  void vega20_doorbell_index_init(struct amdgpu_device *adev);
>  void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev);
> +u32 aqua_vanjaram_normalize_reg_offset(u32 hwip, u32 offset);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> index 242b24f73c17..ddf0aad51821 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
> @@ -210,4 +210,7 @@
>  #define WREG64_MCA(ext, mca_base, idx, val) \
>  	WREG64_PCIE_EXT(adev->asic_funcs->encode_ext_smn_addressing(ext) + mca_base + (idx * 8), val)
>  
> -#endif
> +#define NORMALIZE_XCC_REG_OFFSET(ip, offset) \
> +	((amdgpu_sriov_vf(adev) && adev->asic_funcs->normalize_reg_offset) ? \
> +	adev->asic_funcs->normalize_reg_offset(ip##_HWIP, offset) : offset)
> +#endif
> \ No newline at end of file
