Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD4FC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB0710EC36;
	Fri, 11 Apr 2025 16:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eBbYJTzH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76A4610EC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/Ti7RbQMLI+hJn2fPPqrsxGgcZAxteNJHNgS0uOvy5SEpl3qI0iE4itkG1E+ZeC+ttO9v7WszzSW20sCRVEUHThXZkeUqoEY6QGRhU52sA1ho0LzRzBskivq7imJ6o01T/Ctn9yylq2ajeW7hKvypHDsLw9VsjoVucfK33Y/RMmxOI/pBJ4/s2JSlGYSMa4dHoueMqhbQgrvyfIXw9+xRKKyKsLc68dRuNZLgZC3RH98p+8jcqtEVCH6YooQEGfGEefJW7dxIRoDbdSh2RirVDXcvBqHY52f4RN/XEmwHblX7TUIpriOo+SjCcm0Ckh3rj+jQT3BMh4SsHzacUT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJkUA4zH0yyLDFNq7HMSlSNB5ded5V6fUdWVESwcNy4=;
 b=Vk/yJRedkgGX+GFcHjvu6q1MHQupCntshBcWXJOOMB9/8os0ZtWxtyD3J6kU6fy34MCQ7uUd6P1JOrxe0d7Xw4XHErCknN8qF5azW8ZL8DphiagVzLKtbUTHjaDr2fPTfX+C1geJe3R5MnLYJQuOvKrvLVhO0j+8nSEuanvQgIIziavpdIoez/ExFgGy+L5UCUPdaGFs5WlApRHDxEAzBfXqUtjhgZ1ttQzvjAwZZtcJlMm2+djFZ6LxVydTXrd6iMLdE5XpdM0SgtGm5mkXb1VeKQo+hrqZAs2d5EKv3g6gZipozfvQgHne6Zq2pNe1OiAXAbpkJSDCR+qgDv29qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJkUA4zH0yyLDFNq7HMSlSNB5ded5V6fUdWVESwcNy4=;
 b=eBbYJTzH2y2MkZhNFznQx9pARgEpwT1H6eTd0u8qXnWBwIy0pGRItX2N5+em9RgCg2Z+PCaCMuzKZGHL1zvqbxMomDHuaumn9uF1JBUWOmDdKCr8e5KQ39yoFeexRKp7nWDziEG8WRPNENqby5KL6v8v8PQSi8rm7yBhCEr7wO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:53:58 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:53:58 +0000
Message-ID: <38f20446-11e1-453e-8a2f-3167595d2f80@amd.com>
Date: Fri, 11 Apr 2025 22:23:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] drm/amdgpu/mes12: add conversion for priority levels
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-4-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 568a170e-1da4-4cc1-f9f1-08dd791973bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sy9JUUdieVo5WHBXU2xqQTV1TXNESmVRS0FObmJPUXJSRjQrQzhBTFlGNFBJ?=
 =?utf-8?B?QUkwUkJvVnR3MU5nUlg2cTVXUzdKRkZwbTAzVkQ2NFA5dERTQ296am1TekVK?=
 =?utf-8?B?T2NWTkdYVnVOalQ0dTVxQjRlL2JEOXFkVHpHZGJBbUdYV1pCREZMdE1GSXFh?=
 =?utf-8?B?UUd2c0p3UW5pUEZtU3l1NUNkaVdiTmJjUnRpMTk4MnlSQllOdnJidmZVZmF6?=
 =?utf-8?B?Qzh5SUtUdHZBaWZsaW9LRm5jRVBsSU1zK1NqTUVIT2NSdVRSNUdtZFV0TFBR?=
 =?utf-8?B?VUVheVhscXBMTThKOWtJZlR0TDZrbFpZcjJpUzdLWHYvQlJWWGFzRk9WRmVr?=
 =?utf-8?B?K1hLWmQ3VjN2eHg1ZUtpUEh3OU9ZT1g1V2RGbWkrNHRiRVlBT0xPd1VHZVJp?=
 =?utf-8?B?UXowYWp4MXdjWkZ1MFRXYXJlWGNxMkN3Zm5Ub1hqR3JmVUloM2FiQU51QllP?=
 =?utf-8?B?VEZaZ3lhMmFwVVFXcXdPL0xxTkFxV24wTXRlVytUTjVlczJMK1FJR3Vkd0R1?=
 =?utf-8?B?WnJVOWg1NFVlT2JlbGZ5Wi9xTGpUelEyVUNvQWl6eFlHT04zQW5DQ3hncm1P?=
 =?utf-8?B?NnZuMnBIdGVZbGdkQTRaZjdpN3hXN2hMSURZT3ZuaE9IcmlTT3N5cWdFMUli?=
 =?utf-8?B?RjE3NWswcjFPc3VxWHRscURBWjBhK2t6Y0FwclNHbmQrL3VFT09hdDZNSFNw?=
 =?utf-8?B?R3M2Ym10aDdDUWc3NnBXYW5zYlMyTFFESHZoM3FVZEIvTVZzQldXa1YvMjhp?=
 =?utf-8?B?eHo0aGNMR1hpWHNmTGpPQ0NWNndoTEUxYlBKS2NCaWFOMnNmK1J3STVlME51?=
 =?utf-8?B?ZmJIQk5NaHprWERsUTFGd29XY1U1L05na1NqV0NtajZIRFpqZ3hVUksrbmp3?=
 =?utf-8?B?R2xPTXFqWUVlTjJIOW5Qakh2SXlOUElORHUzS3JpRldCMkhEYWxPMHBLZHkv?=
 =?utf-8?B?b2ZCZVo3N2JCVXZVOHU2NGdCdVR4eFQwUHJFN0F3cW8rSU1GanU4eE5rMy81?=
 =?utf-8?B?U0FzMXNyellrVGp2VnhzYXVhNitMTmFQSStBNUdkYjlPa1cvSWlWOWZrZWk2?=
 =?utf-8?B?SzhydTVzampyTHA4MWhJRUd3NEp3cmU1eUdteUJkUDJoak84ZTAwaWR6VVpp?=
 =?utf-8?B?RTNuR05vM1dGaWtyN1F6VlRQZU9oVmRrV3JBSFJoU1ljQVJoRTlrTGxtNHpI?=
 =?utf-8?B?ZTJpRG14dHRNRVlhdDFoL2pRZ3l1ejN3RWMrK0FMUXhBSWxidUNUY3ZKZm1Z?=
 =?utf-8?B?bCtacVhHbWVZR3hNZ0NjOVhEcVk4LzRJRFV1MDZUdlY0U1F4enUrL2taSGxu?=
 =?utf-8?B?bjdPNnlxVWFyZ05WbXVhdk5hL0lubENiak9kcWNVM0N1WHVwUlpkb3p1T3hK?=
 =?utf-8?B?RXNlenljQmZrVXFRa3Z0OGxlRkU5MHNJdE5LOHlYem1iamtqZjBpczdMVENj?=
 =?utf-8?B?dkFiblA3Yk10ckkwZ3Nac3M3R1pJeFdHVHpsRXdKaVVXYVNxaEc0VUFRTmFT?=
 =?utf-8?B?UUZCT3Y5YTZ6WGxxYVRqeG1aejlyUjdxKzY5NklxY0hmMVkvRXc0bm9EZHBZ?=
 =?utf-8?B?WVhJNXo5UTNkcWNab0NBTFBXZWxrTS9ZbE5VbjRFQ0ZTQzhxQnEvUzJMMHNX?=
 =?utf-8?B?MFZhTEhTdVJRRks2d0x1TjFlVWZqeSs0Y2hNdmJUR2JFV3NUOUN1SzNmVk1s?=
 =?utf-8?B?Y3lxZVNMVWRFbk1LcGpsWW1zNlQwc3pqMWRZNzNTRnpYSEFpZ3dlQVQyaVRO?=
 =?utf-8?B?djVWLzB2aElTdkJUTHAxYjJaWFpPNHR2eEdKMzlIVHY5TFA3K2hEVTIreG5G?=
 =?utf-8?B?K1ZQK0Zjc201MDBMUlRTbGtQampUVlFrU1I3b0N2ZXFFcDhuUEhNQ3Jja2tx?=
 =?utf-8?B?Njl1WncrRVE5S2pzcVJZZ2lyM0Zpbm93QjdVdTRWS1F5K1B4ODA2NnhwTTNz?=
 =?utf-8?Q?zHNOI1ZdxKw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czAxQnA4TVBDTEFySHYycldFOGxjZEkwWmdwOVFPaHpRTHFhNmEreHhubW1R?=
 =?utf-8?B?Wit0TXBUY0ErRTFDVGJxZ2lGR3dBMzM5aUxlcEZySFJ2SUMrbUlIaFYrTjBl?=
 =?utf-8?B?Vmw3ZGJrd0QvTGhjc3RGalhFTzhvVnVvVml5WTJ4dXpJZWdQMCtSQmU4M3VL?=
 =?utf-8?B?cXlFUGNiYTVQZXpTOEtnMWJmbVA5ckl4NXFnS1J3aGQxR3Z4MWZ0U1Vtc3Fi?=
 =?utf-8?B?QnVaK2I5bit3M1dPLzRacnlIOGlhRGloYmNrQ1kydERNM1ZiNnVZR3RyZUZE?=
 =?utf-8?B?eCtaQythYjZhS1cxeCtCYU0yNFdYSVVQMlN1MUdsalA4K0RsejZWUHVGVm5I?=
 =?utf-8?B?dTFuaGhzVlQvOHpKQ2Zya0NzZnN5ai91YW9odUdod0lXVzlTVEZiZzMvM1Zn?=
 =?utf-8?B?bVlBaWFRRngzVHE5dm9ac3RSZy90SDFqc2VJTzJIa0lhenE2bFpOMCtIMHdz?=
 =?utf-8?B?M2JHUk9jN0JwcmFGSitZZUFDcDZsaHV0Q0ErMDJwUzFnUGs4dnIrUEx5QW1D?=
 =?utf-8?B?NkZtdmVWazZUNURxUVFnWVY4MXhKMXRGYnhmMXhrb1dYeXdzbXZ0UVQvRjh5?=
 =?utf-8?B?Y3RPSExNSGczOVZ5SU9vSnNtbXR3VzZCZ1hiS1I2WCtpMlNYU09velMxU0lO?=
 =?utf-8?B?eXVoMVJHa2xLbmNHZzJXdktNR3I4amR5MXdreDZFaEsvUjJzNHdQUmViY2pU?=
 =?utf-8?B?WjJMeGt2TDR4T254MXR2c0tWUUNvbm5qVWVnb0dSWmV6cTVITEpxQUJSb2tQ?=
 =?utf-8?B?R1RRM2tRMmNpbXlpQSt1S1dvNlNsOXNKSVFIQ1FBcEg3bnk4NFNiczRiNExs?=
 =?utf-8?B?Rjh2MUFld29zMWxQZlBhZUs1VTlXSGkydG5JK2tNVXBFRnFmZ2JCc0dxZm9L?=
 =?utf-8?B?SGg4b3hkRnFpaFl4bnIxY1Z2MldDY0Nnd1QwdDcrQlg0RVlnbmxQV0FvTlZG?=
 =?utf-8?B?RTZYQzk5eEZkZStUU2lSbHcwNkdMTllaWUhleVhLdWxrVUViZTErT3pKWTVU?=
 =?utf-8?B?OXBiTXhQZGJmRmVCVnBGRE1Wd05zZ0FLaVBRRllNdkhMblZBYU01eCtmVUtm?=
 =?utf-8?B?Z0VmQ1dUZDBvQ3FscVRpRjNZNzlGa3piUUFLaFBzcEw4QnJjT09Xa1NFVXlu?=
 =?utf-8?B?QStGeXl2UEEyUnBCMklWblh2VllKK29ldW5zUGtwZDdraitDbjdwMTQ4elZP?=
 =?utf-8?B?ZTE5OEo5VDdzSTAzU2xQRVkrRkdUcTdvT2plSUhaNGdqWHhGTEhrTDhIY2pr?=
 =?utf-8?B?OUh6U21NOXM3VkJmekJpR1g3RGd4NEs4T05rb2hKL1BzWnVKWVhhaFlZN25E?=
 =?utf-8?B?ZHJ0dHFlRElWL3ZEdVFpQlVRSkRzVTJGeWFHcGJDKzAxaVArREhNU3BIMVBh?=
 =?utf-8?B?SThWL3FxcU1LMy9JZ21KMzVJc2NMME1CSW93Z3lndDJYY2Vtb1hBaEJCR0NR?=
 =?utf-8?B?TEJHUCszM0FsOHNtSVVsVmRYN0s5V0o1WVVtVkIvQkxWT0RXaDAxUHpvcFFK?=
 =?utf-8?B?T3pzVkNJSXNyUlBJdmFPWHlkRFZiWWI3VHJaS1dOdlRrN2c1M3kxRDVId3c2?=
 =?utf-8?B?d2VDRXV0T1BhbEFrR29lZi93Mmc1bTNGRlBETjFhVkU3eTB1U001RHNKK1cx?=
 =?utf-8?B?elErc0NaTDdvNTgzbHNUV3BQdDJpcmZLdWtwWnIvL1IvZkw3NkVNb2NIR1A2?=
 =?utf-8?B?YlVaT2tEVmd6MUlwRFN6WFhpeGRGekZSYnd5QjNxRXJDcVlYc0dPL01FWHZy?=
 =?utf-8?B?T2xBL2hVS0JLVFNiajdRSTVUNnRoRkNNSERUVW1iNGxHT1ZqYVlvTWJhZjI5?=
 =?utf-8?B?c0c0dmp3aThMelNBR0laSVEreDVzWGdhaXdOYW9BR3diOXBqSk1tRlFKK0pB?=
 =?utf-8?B?R3BTdFJGeGdOMkFzWTgzS3hOb3FpUGJqcGYxczJiN0t2S0FMalVMUXVqVUNM?=
 =?utf-8?B?M3pONS8zdmJZK1lHYlo0aG94czN1UnYwRWJwenVaRG9IckRVOUlaV3B4bDk0?=
 =?utf-8?B?bXo2dlNUSThDeEpxU2FUNXovYkdLb1dEb3dFY1lRTXp5bk5mTk1valdOa1Ro?=
 =?utf-8?B?QUNub2tmMTIvaW85V05GT3FZeEZsT1Jlcnhnc1ovZ0tpUysyODBRK2JONDdw?=
 =?utf-8?Q?WMD/uWV4ILQV9K7426icJmft8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568a170e-1da4-4cc1-f9f1-08dd791973bd
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:53:58.3035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QefxS4TBhCOlu9Jw8xDIFMUZ39vINTatMrgD3wISQ8vZ1wRewtgzq1XIKQQtOhjuPBsEksZHAp8XSXuR+Ll3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

Same comment here as MES11 that once we have confirmation we might plan 
to use same function for all.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> Convert driver priority levels to MES11 priority levels.
> At the moment they are the same, but they may not always
> be.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 8892858cfd9ae..852b8f2a4e387 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -274,6 +274,23 @@ static int convert_to_mes_queue_type(int queue_type)
>   	return -1;
>   }
>   
> +static int convert_to_mes_priority_level(int priority_level)
> +{
> +	switch (priority_level) {
> +	case AMDGPU_MES_PRIORITY_LEVEL_LOW:
> +		return AMD_PRIORITY_LEVEL_LOW;
> +	case AMDGPU_MES_PRIORITY_LEVEL_NORMAL:
> +	default:
> +		return AMD_PRIORITY_LEVEL_NORMAL;
> +	case AMDGPU_MES_PRIORITY_LEVEL_MEDIUM:
> +		return AMD_PRIORITY_LEVEL_MEDIUM;
> +	case AMDGPU_MES_PRIORITY_LEVEL_HIGH:
> +		return AMD_PRIORITY_LEVEL_HIGH;
> +	case AMDGPU_MES_PRIORITY_LEVEL_REALTIME:
> +		return AMD_PRIORITY_LEVEL_REALTIME;
> +	}
> +}
> +
>   static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
>   				  struct mes_add_queue_input *input)
>   {
> @@ -297,9 +314,9 @@ static int mes_v12_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
>   	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
>   	mes_add_queue_pkt.inprocess_gang_priority =
> -		input->inprocess_gang_priority;
> +		convert_to_mes_priority_level(input->inprocess_gang_priority);
>   	mes_add_queue_pkt.gang_global_priority_level =
> -		input->gang_global_priority_level;
> +		convert_to_mes_priority_level(input->gang_global_priority_level);
>   	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
>   	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
>   
