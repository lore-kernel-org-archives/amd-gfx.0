Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B560EC27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 14:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4347210EC74;
	Fri,  7 Jun 2024 14:15:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i5e35vd7";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9455610EC74
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 14:15:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjrUtthTzl34dOR2ocGU/+rTyFBd3m2uEukOKc6J3NEvdg9pQW/WOqHj4Qrr00ExeN/hYgvqIVbm1oGdXzDRVY7PFyejJY00q2vfFxMuI9IyjmaXh1lAu3912u3d5brSVhnqkBbMZKaLUpNTo7BSoA3QO7ztA6CvueB/SDPGBVkW/u+sBxSiG79KQNXDCnwKmarPriNwJk0oUIaQaOqL8deixgidoPpcClyiuU244o0zATIw1N7hkOId9T35dsgq5z+KTra6AEIlfDnc3EW4BGmgYRC0W2ZIijLZwHISCFFMgY93iVi1PayV99KSH2aEyysNvpdXK632Bk+RrBK10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubW8jxHmjcfoXGBHZ5sd8l3eigfS+ev1ufk761Wtsao=;
 b=RWzpSGpgvhvYCaqZGGnRhHvV84K9tlbjKYp0C89NxyWAntwTbo9s6B7rC1KCyK9yhpYLVRUZ7CPL3RLlQXjKMXVqA9SyftTXdPl4WUB7vm75ILUkpAsXTuOZFiz4pWc54dK2HFGj7fxHOx6dEjLgIOQWEjjOTFOOqYO2z2rlCU7WY5+bwPtM5PADl9qd5qdpNBPgiUZPVSvVJqC8OlCdhDMCquRH5gJVQw1Lr5IrI3Qnb5W9iCw1Obd96HCuQS5a5EPMT77gyCOYBn12F1ncyusBSSo00xExVHvu1G6tMZVVUYyNo7JdkGkPW4z7niT7l0Xd6dGEcmUoSuXoO1a3Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubW8jxHmjcfoXGBHZ5sd8l3eigfS+ev1ufk761Wtsao=;
 b=i5e35vd7HK7tOSWEcT5DUSOFeHcxDjafRLZRPFyvvXxGKvyCiS15o/amUbq+rJJbGEYXssmG5V0BftXN0rbEhEBEeWOITHiqy710NkqFSqjGQTxTdZFucl3KD6iImMUEPwPED//LhV4TlhegDfGYPIwbX31x4dxO7e7mW/UJ3iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 14:15:29 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::a846:49eb:e660:1b5b%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:15:29 +0000
Message-ID: <c16b4d72-f1c3-4491-910f-1191066ff69f@amd.com>
Date: Fri, 7 Jun 2024 10:15:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Set default brightness according to ACPI
To: Alex Deucher <alexdeucher@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <Harry.Wentland@amd.com>
References: <20240607060228.509050-1-mario.limonciello@amd.com>
 <CADnq5_Oijf8vWntypaSYy4WFvVJbuWShinHKCYmV270fcb1K8Q@mail.gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <CADnq5_Oijf8vWntypaSYy4WFvVJbuWShinHKCYmV270fcb1K8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::43) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c7082ae-30d1-4db7-c522-08dc86fc48e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2ZYYVNtbTkrcTlTaFZHWHJXdTR4a25rUFhSb0ovaDRjck1BaUF0cUhTNmht?=
 =?utf-8?B?MUM0Y3h3TGROdU54blNPU1B1TXVNK2tjclNuR2ZUbUZ4SGZoaUg0amZ3UlhH?=
 =?utf-8?B?OG1mZExFV2Z2TDZJNlRNUmF4Sk81cGhya3YrdGZreCt3WkVPcXgwcFNGVVBl?=
 =?utf-8?B?elNha3llbWUydzJJQnJraHZLTDhyRlhJRFFjc1JudTdibGQ4L0pSS09YVlAz?=
 =?utf-8?B?MUJ6c1QzaWpLZGhnTTVLck9rSkdNZktrZnUxN3NlS2dHc0dpT1lXZFBoYU95?=
 =?utf-8?B?dFJkM2V2NWNYOUxnejQvNFNWZ0tNS0ZkaXI0dHFlNlJiSXVpU1krVkVOTkJV?=
 =?utf-8?B?RXFoMXp2UHo0bFRnY2N5SHcrUllVTHhBSCtyeFhVamJUUXk3a2IwV2o2d09Y?=
 =?utf-8?B?Tnd5dUEzMTI3L2t5UHVJcndDMVgvdnJGTW8wbFdrK3A4Y3QzS2xIeXc1VC9y?=
 =?utf-8?B?TFA5Lyt0TjF4ZnY5TEw1SDBmNlA2QnA3Qy94czR3UEtBRmJIQ1NLbmJ2QWRl?=
 =?utf-8?B?Mm9vWnhjMU1mNk1QbjRmZjlMTjhmK0NHbHIramRkMitKb01YWjlyeFlUYXJ1?=
 =?utf-8?B?TjROdlMyUFg4WGRGenZIbEdXSlViejBsTURGcGtITlNyOTJMVVVqUFVCS2g4?=
 =?utf-8?B?NGl1ZUx0Zjh0NHNjcHZYSVcxZmVLWnFJQzhrQlQvM0xET0F0ZTE2K2pZNlBx?=
 =?utf-8?B?ODhiSDArWEcyb0JhZzdla2VEcjV4eEw5V0RkWEU0Yk5QWU8rQUhuNTh2QlU1?=
 =?utf-8?B?Z2pRVEZrNG1KTGxyQUtDVUFMZjByZDZHamczSFhPSERRR2oxbnZpQlZ4cGtW?=
 =?utf-8?B?aWZUQTVxbkFGZ2E2OTRXZGprcUlPR3BOSHBiV3dlMFl0Tnk5VHBYUnBYTGxm?=
 =?utf-8?B?TWYwY2VUS2Mvckd1VmJxYlhkb2x5UWRkU2tTdERIeEhTYmJUQjNHSDJKNkVr?=
 =?utf-8?B?eFJFaXNOZVlESURDNE53ODNjRzBGWUtWVCs2anBEL2Z3Nmw0TnBUbDBad0Iz?=
 =?utf-8?B?NzJHemJublA4amVSODI4RXRrem9TUTJPQXVkOTE5RmpXbjlTTmJnZjZua1kr?=
 =?utf-8?B?UUNxRDlDMU5va1RhbmtoR0ZaSkJ1a2U1Rmo4RXBCanlrN09xSFkwUDdvS1h3?=
 =?utf-8?B?U0IrOWFObUVhK21BR09LQ1FUVkUyM1ZvUmZJTzgyUXpuM0JySkNmVVV6aUd4?=
 =?utf-8?B?MnVRd1JFR2diK0xCV2Y5TG45UUM0M3N5OG1UVm4wc2VuT1BCT3RJUmpDQ200?=
 =?utf-8?B?Q0dTRnJLZTc2dWt3NGUwVlM1Vkd6MnpwWWNXZUVRNmlzOEU3ME1IM2Q0djY5?=
 =?utf-8?B?ckVBbUVPOXJaNzByY2dpQWdKTkNaNWFJVldESWZMSTVuMjhrWkVYOUhmbU1U?=
 =?utf-8?B?dFpXKzluYlN0OXMxZGNPdDA3QnBzeEFIY2FpVnFtclhrS0NwaythVUdIRVE5?=
 =?utf-8?B?ZEFpRnJEV3ZoRXZFOGxmK005OTRYY21BYjFSZm12SStYT1l2cExJRUEzd0xs?=
 =?utf-8?B?TUZVdE83OFlaMTVYUGhuRmZ3ZzBjdW4raUJYR2pqUzFMUUxFdlVETXZnK01V?=
 =?utf-8?B?QnZLbEMvQmdacTg0UHVJbFBPclpIMHJ6bU85V2s0R3BiMW5GZGtHZzBzVHBt?=
 =?utf-8?B?YzNMaURkdEs1aW9wN2xuR1FWa3B6bTdDNmtGcjltNnNUVi9Ta3pOZEJYNzhE?=
 =?utf-8?B?ZGpRVHpPanljTGlsTUlhdW96Q252SUVmSElaSzc4YkJCZzlENEx5THdEQmJy?=
 =?utf-8?Q?KCSrRkiLpYIIF3eZJLqSc3NmW7roETPZ4C+F3La?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0V1VnZLLzJOQU1tWWNFYisrdU5lbmltdlJSaE5iSzFzMlpTNWpKeDI2bXJ0?=
 =?utf-8?B?WUJWTXVkSUp6WGZabGZvSGFIS292cVdVL0FCYWZIN28vUEpyaFRBQ0o0dUlB?=
 =?utf-8?B?ZmtxYXllNGlPWFlxRHBQTms1dE9ha1VMOUJSOXU2MGUxTnVaakF2R1llT1NI?=
 =?utf-8?B?L1UraWpNYlZRaEFkSTZFSmlOU0JLRVJUZjBwSXJURnAxSHJaTmUyVDJmSnVB?=
 =?utf-8?B?U2xObjBlVlN0OEhjRkp6anNGeGRBKzc1dk9CeHhrRFlFMi9WY1FZREJxYjNZ?=
 =?utf-8?B?VEk4WXVPYnRqVWV4S0JrQTMvRStNbXY0eG9uenh5QlpvQ0NUSXZCb3dEMFJK?=
 =?utf-8?B?SXU4NFR0aytuM21ESU1Gd09teVJTUE1iMEJ6ZFVLMGJUY1VTeXpaVWQyWENy?=
 =?utf-8?B?QVg1N3ZOMVMwem1ib3dHSUhqY1FPVlJaa0VkV09UWnVTbUpoa3l0L3FwTW1k?=
 =?utf-8?B?OEh3M2dUMFRkcFhTMDRYVFpwNmRWd2QrYkNJdFZYbEpxL0lUWHFRMi9VM3dn?=
 =?utf-8?B?bzVWbTBJeGVReVVKWVJaS1FhU2NJbzRhQ09wTEZVaFlodXhKZ2F6OGR2YTlm?=
 =?utf-8?B?K3JndjFPRnk4aE1iNTk2NVQ1emtOWWV0czRoYkNQMW0zaE4waStYSUFSQ1pW?=
 =?utf-8?B?NmZYVmswSUV1TUpDT1pvR1hYM2ZVcnJhdXNjLzlYTHFCN0lqL2NXbm12cGE2?=
 =?utf-8?B?ZksyYVM2TlVQNklPdHI2QnFwVzlrYWdDWUNkYWR0QkhrYnI1anBBTjBKaDg4?=
 =?utf-8?B?UW5kNkVRVWEyOWpQOGt2cGhXV1oySkk1UVlpc2tBT2o5QklVVGlTVnFJK2Jm?=
 =?utf-8?B?TW5KZWt2bFNSZGFXdnliRUE5OTdkamNITWdvV2h2NEEzaVRaRTRjZHJ3cWV1?=
 =?utf-8?B?MGI1ZU5KWmR5a1BNQnNzcENZNUlUamRyWEZsMjN0RGVnZnRjRVdrZFU3Ly81?=
 =?utf-8?B?N0YvV1d3MjZjcVpEUHd1ajltK3BLNnNLa1hZTnk5MkRSbUlKcU9WVWNpVkp5?=
 =?utf-8?B?VDJSNXpoNzliOGZsbTJzQUo3Y1ExMTFuL2hRUDJlcUo1TVRCM1hCdlRmUWg2?=
 =?utf-8?B?Y3Ewc0FnZ3ppRk1xbHkyTXJINjI0NFBGZ3RycEF3L1F6b2NLWTdpUUFQWVNB?=
 =?utf-8?B?NFRwV1dVckFzWEhVT2dJK1BkUEVRd0F6OTRzL3hHRVVMVUJqR0NyMnVTMjg3?=
 =?utf-8?B?UmwxQUxNdFpWTGpQWk1JaExacnUxakt4N3diYmJETzQ2b1FGTHNKYnh4bXY0?=
 =?utf-8?B?SUdzN2ZRRFpCQldoZjBWL21OSldEMDhhbmpoRHJOWkNJaVlWY294d3JEbWV0?=
 =?utf-8?B?enFsWUFzd3N4UzBRcWx0ZzNpWFl2LzdVNlJkL2ZzN2lyd2tiUGJBUVJua2Ju?=
 =?utf-8?B?NDlrS2lwc3IvL2lzZVBLdkZHT1dTQURRWlpJcGhJYVNmNjNzWk9jUkVqNTI1?=
 =?utf-8?B?Y0oxU3J3ZUpNT0RzRm5OTzAwdHN5SHJFeGVkNTJuM2hEanN1cnpsK2JjTWZo?=
 =?utf-8?B?QzRZWmdHbmRtUE40MVdyU1JVV0VjbjI5WWVCcmlvKzhVb0lnNEc4ZGpOQkc2?=
 =?utf-8?B?aHRtdllicUNCaElDc3AwZ1NRRnJteHJPT0RUU1VXTG5RMjFGUWFyZy9CM3h4?=
 =?utf-8?B?Nm1ZaGZ5UklMZXZkM2pReElaWkFNZ2tQN1FQWHE4RTNkb081OCtHOUdHQjh2?=
 =?utf-8?B?UDZZTnV3RUhmV2JvbittYlFDMWtCSTZ0TWp4ak9UN1NhR2NGQkcwN3JxaVU3?=
 =?utf-8?B?VFFIbm42a0ZhQ0ZwOVZ1Wm10NzliZS8vZlk1YmQ4bmlWVVZDelI0R2prTU9t?=
 =?utf-8?B?ci93K3BsNDZXMWxjTXpiaHNYTm1adHllTGREbi9tdU82MTdTNFhQRWowbjBy?=
 =?utf-8?B?TVpsNWowVkxFc2p1dmE4bzhOUXNvc0xJckhocTBPVDhyU2RhSTBRTlprc3Jz?=
 =?utf-8?B?Q2RDdFVLZzh6QzgwRGZyNzY1SU5QNVhYWjJFY205SW1vK1I4eG5QUHNvNWVQ?=
 =?utf-8?B?WVpLTUxnZjQ1NjZaMFZ0Z3poNy9uVFFlR2tva3l6NldTNTBjNVExWUZ0WEV4?=
 =?utf-8?B?dEtpcXMybC9nQjZTcnBuZ2w2dUtaZVBEVUtXZ1ZvMVNDb3ExSVh3eWhkd0du?=
 =?utf-8?Q?0Vh5vSUqZVp6VwGVUomrxrkFU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c7082ae-30d1-4db7-c522-08dc86fc48e5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:15:29.7477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cIehpNxDknjdInO1145B/LTuizX4regM7svvQz6Hx/6/4M4nD274CY96WvxeXlH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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



On 2024-06-07 09:49, Alex Deucher wrote:
> On Fri, Jun 7, 2024 at 3:22 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> Currently, amdgpu will always set up the brightness at 100% when it
>> loads.  However this is jarring when the BIOS has it previously
>> programmed to a much lower value.
>>
>> The ACPI ATIF method includes two members for "ac_level" and "dc_level".
>> These represent the default values that should be used if the system is
>> brought up in AC and DC respectively.
>>
>> Use these values to set up the default brightness when the backlight
>> device is registered.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c          |  4 ++++
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++++++-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  8 ++++++++
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index 7099ff9cf8c5..f85ace0384d2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -383,6 +383,8 @@ static int amdgpu_atif_query_backlight_caps(struct amdgpu_atif *atif)
>>                          characteristics.min_input_signal;
>>          atif->backlight_caps.max_input_signal =
>>                          characteristics.max_input_signal;
>> +       atif->backlight_caps.ac_level = characteristics.ac_level;
>> +       atif->backlight_caps.dc_level = characteristics.dc_level;
>>   out:
>>          kfree(info);
>>          return err;
>> @@ -1268,6 +1270,8 @@ void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps)
>>          caps->caps_valid = atif->backlight_caps.caps_valid;
>>          caps->min_input_signal = atif->backlight_caps.min_input_signal;
>>          caps->max_input_signal = atif->backlight_caps.max_input_signal;
>> +       caps->ac_level = atif->backlight_caps.ac_level;
>> +       caps->dc_level = atif->backlight_caps.dc_level;
>>   }
>>
>>   /**
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 5fd7210b2479..71aa0c518951 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -77,6 +77,7 @@
>>   #include <linux/types.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pci.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/firmware.h>
>>   #include <linux/component.h>
>>   #include <linux/dmi.h>
>> @@ -4321,6 +4322,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>>          struct drm_device *drm = aconnector->base.dev;
>>          struct amdgpu_display_manager *dm = &drm_to_adev(drm)->dm;
>>          struct backlight_properties props = { 0 };
>> +       struct amdgpu_dm_backlight_caps caps = { 0 };
>>          char bl_name[16];
>>
>>          if (aconnector->bl_idx == -1)
>> @@ -4333,8 +4335,16 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>>                  return;
>>          }
>>
>> +       amdgpu_acpi_get_backlight_caps(&caps);
>> +       if (caps.caps_valid) {
>> +               if (power_supply_is_system_supplied() > 0)
>> +                       props.brightness = caps.ac_level;
>> +               else
>> +                       props.brightness = caps.dc_level;
>> +       } else
>> +               props.brightness = AMDGPU_MAX_BL_LEVEL;
>> +
>>          props.max_brightness = AMDGPU_MAX_BL_LEVEL;
>> -       props.brightness = AMDGPU_MAX_BL_LEVEL;
>>          props.type = BACKLIGHT_RAW;
>>
>>          snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> index b246e82f5b0d..df72cb71e95a 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>> @@ -173,6 +173,14 @@ struct amdgpu_dm_backlight_caps {
>>           * @aux_support: Describes if the display supports AUX backlight.
>>           */
>>          bool aux_support;
>> +       /**
>> +        * @ac_level: the default brightness if booted on AC
>> +        */
>> +       u8 ac_level;
>> +       /**
>> +        * @dc_level: the default brightness if booted on DC
>> +        */
>> +       u8 dc_level;
>>   };
>>
>>   /**
>> --
>> 2.43.0
>>
