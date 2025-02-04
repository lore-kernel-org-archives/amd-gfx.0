Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F71C02197
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 07:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E9F10E271;
	Tue,  4 Feb 2025 07:30:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YyW0i2pB";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 396B610E271
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 07:30:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yi2hXB9Th0ADgdAMfa+Ver46WjfwBGSB1KOc9y0RHYb7SzV7+KK7wnO0fReANTCJ9+R4eWqZR4mLRMRzceUctBq3UkE/gWPGsiUpMzhIcNbfSTC4hGIiQbu3YMwqOFBD/0Msp1QQMVvl7DPBOU5rW2+YyEtoyq/AZJ+U1d9jhWmsUAYgGYTVmwzbT9Joxdd/QEqjUfN6TP/mbQSYsWYhxEGWMaPNwvKb3yofrQ/FREiPscMpGSi9C+x4CIpGhdWPT1cOq/8n4EzI7IyX31/wEKWnYoR7TOkVN8PIwDJd5SiI38+701/tc+8KtLsc6aXNIv6L3C24tapX4w78EiKbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f9XOxh2reKzLdq6+8JgqzurIQ222XLaf8s8BcUveeY=;
 b=fGnmLSICTHkZAFZDRhW/K8QUQVgzwGA1A45uFSfz5JEreGisLnV+euADL29enU6e6tVHD9mU16EAJVnryrOGNlsdJ7RLy8JPyAjtz4OgLG8JvYXEyM2OGkcMnTifHbu0XwbqqFIUCn/COeACBajdssadk76mdV1L8d7dn5QJWWcnvDu/VnsiiNmZpYAzeHoIfGR6RyMWLz/IRpQ3okBgc6t3/rCgyW//vwIXc1lsPPE87fDOE2PKxvvlUOsnllawUeeZBHfxppBKRQfS635YHUW3uP09crrfVFhEqlg3Jgsj7vm4F64JD+O1zgSh5hiquhPs0ALNMZSQz70jMzv6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6f9XOxh2reKzLdq6+8JgqzurIQ222XLaf8s8BcUveeY=;
 b=YyW0i2pBn3z1MqbqdLWXWADHj/FoG5HSrv/+poX7lDdZ6Kqpj0uUPKV9LznQz33ZOeSxZpcPU3uZeOxg0xtrdV6jFieHoihbHTjuJ/I67RQoAIiMiPH08XoXVQOZqCxt3N9hti4ITlWxImZiY+yyXX7W/beP04s/wsmOkp/LLYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.26; Tue, 4 Feb 2025 07:30:22 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 07:30:22 +0000
Message-ID: <0c86ca08-e651-4e40-94aa-c6958a99e220@amd.com>
Date: Tue, 4 Feb 2025 13:00:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] drm/amdgpu/gfx10: manually control gfxoff for CS
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250203214349.1400867-1-alexander.deucher@amd.com>
 <20250203214349.1400867-6-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250203214349.1400867-6-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: f48c6faf-c56d-4d4e-7586-08dd44edc8b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGxnNzB2a1MvUUsvNWlkKzBnM21DSjFpM0RpeUlINTNmOEZlbmpuZ2ZiTHpP?=
 =?utf-8?B?K2psWTA1clA0cllzcE0zVm1RVmlwSFJGZGZJeWdMUGd4ck1IWEtYejNiaW44?=
 =?utf-8?B?ZTYweDVIbEh4MkVYR3NZaXZWVGt5cVJTRzNuWDhzU1FNdDJ0d3hsYU5KbHRi?=
 =?utf-8?B?QnhYdW4xU1c0dVFPQlFiVEpVNm93TGRQWXBMM1g4a094RUEwdS83RGNidERs?=
 =?utf-8?B?YytFNGp4eE1scEFaRTUxajRWRkxxY3BkTkdzalJub0ptcXkyUHBtb1FYRVFF?=
 =?utf-8?B?Z05aNm5nZlgxRTdoY3VrdVFNbUNWenk4bVhicUlud1VyQ1htMlZPMUxEQXZv?=
 =?utf-8?B?dDAxQWlaTktnWlFDekhvSWhQczFrRHFvQjVvOUZZaVkwdHpYZE9nbWlWeDN3?=
 =?utf-8?B?NUdhT2ZJeno0cnFhWDBvelo4RFp3NytTUndDQWFLcHYzcXo0UTZZVmV3djk3?=
 =?utf-8?B?cUxCNDBJaS9ybWgyZGZmNzVQTHpkK3BmYzMxdmF3UDl2eTI4dE50VW9MdnpN?=
 =?utf-8?B?UWt5RXErakVqU0Y0SnBsZlB3VXFkNWlZUnpJWXBlNUxXYXlkNHB5d1IyZGgy?=
 =?utf-8?B?TVNEVDZmU1lEZklUTzIvdTVXUHRpQy9QUVFOTU1LaVZyVDZ4SnJ5SXhsR0Fk?=
 =?utf-8?B?WnRtemtOYTZtRVpJMXlMWW5OcmtycFBYNHZwNGVBc0NkTTd1bFZNNVRNNGhz?=
 =?utf-8?B?VXNXM3FsM28wNi9HK3Q0MjZiRktOTlVaYWJuWm9NSWcxV0htZ1Y4UFRGcjJh?=
 =?utf-8?B?WDIxb01NaUVxT09hODdaRFBYTjNSN29tZDRDRWdrbjZxL0JTS2kyU1drcnY4?=
 =?utf-8?B?WWFiWkE5Vm1rcks3bXR6U0ZwbS9NcE5RTGhZRW9nU1dUbXRJYzZIU2ViVWVF?=
 =?utf-8?B?Y2grTzM1Z2hSS1Y2SUQwZFNaOXZqRzNPcXNEM1ZvRm5lREpWdGJSWTNCTG9F?=
 =?utf-8?B?UjN2WDNqYkhuMEs1TlZwV2VwU2g1cndiZ1JlQXhXN2g0YXVxTXJjZ0lBa1A3?=
 =?utf-8?B?ZWl4VXBGTFVUS2N2aGwxd09MY0dqQnZpeUtRTDdPcy9hME92aHp0WTZobFha?=
 =?utf-8?B?YWJBN3crSGpSakU5T2xkVG5iNHJtak5QYmxXMk5sRm1TM1FST21qRFA2alcz?=
 =?utf-8?B?RnFwRFdmcTl3MExkQUxMQm92eEtZcjVGK2YxeFdzTk9jQTVMSW8yMlFFaW1v?=
 =?utf-8?B?MnVwZ0YyOWczM3RjK3ErVm5MdjV4cXptVWpaakI1SlBaWFVoQXRMRHg3MTgy?=
 =?utf-8?B?bDlET29MVXlHaG9jRExibm1NejVuYVRRUDY5YWpaMElwdVltUzgrR21kT2pp?=
 =?utf-8?B?N0xPQ2lWM1pNbUxmR290aVZubk9idXFxZFFJRnZDdVh1dXFSQ01ZOUJiVlEy?=
 =?utf-8?B?THp4WXNKdDhCWWoyamg4QzNRTmlrNVFJaHVvTHZKOFZEWG5WODU1cnZVU09N?=
 =?utf-8?B?cy82MkR2elk0TE1XZWc0cERRbjJyL3pPRUYwMERYVkVEQXhGOTBBT2k0UG5J?=
 =?utf-8?B?bC9DRTRmeVFoMzc0bGluaTExUVJXcHlzVm1LUG1FRDMzM295ZndoKzJXU3pV?=
 =?utf-8?B?UC8xcFpQbFRyMkNHeDhTSmRLYkx5bGQzZGdCVU9PenJBemk2Z05uN0JaMm92?=
 =?utf-8?B?bTZiMXhNMFNWYWlmWng2UU1tKzRXY1hNTnFJNGdwUHFzanpsSFlBK1ZaTllH?=
 =?utf-8?B?NWlJZVRjczBjNUpoa29PQ3NWeC9CaFBWWE9JOXg2TC9CVDU2dWs1ajRKRnZu?=
 =?utf-8?B?YUdBWTJOV3dYdXZyY0p0S1E4RndzSllraXM0RjVzRTRldEVZTnlEdVJzTUlm?=
 =?utf-8?B?YWduUE56ZHQxMW1UMXB3bi8yaVJESEgzOGFZNWFvUUovRXZDdlVKZU5FYmVN?=
 =?utf-8?Q?H34j6DX8RgVHU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmoxWGRpMExyV0Q4RFJvb0dVa0VvSXdCZjNQVkRqREFuUXFBQUdPa3RocVli?=
 =?utf-8?B?bzR3MFhFQjUzZ0FRbEpHNGFxSWo5dUlZbFlBcmJsVEhzdHF5UHVEVk9uMGwx?=
 =?utf-8?B?VlgvRDBPVC94RERwTmcxSlpGMDU3dHZXV2pNUmJkM203YmJWRkpMTW5XMUd6?=
 =?utf-8?B?RERJZDJiRkNDZWhPd3lpbmZ1UkZqSmx1NlFPaHM0c2VYa3h1c2pXMjdUTGR3?=
 =?utf-8?B?YVU2d0psamxaZUpXVWlrQWcxbTJqWkNFRmMwN2t0QjZLM25LbWtSL3JtRXIr?=
 =?utf-8?B?QWhDaTB6c0pHakNEYXBZVUlTdmJxTFE0N2xyUXVTUDgrWVd1dFJhbTdsUUVQ?=
 =?utf-8?B?Mis2cjEra1JNZ0xyN2ZoRHBhKzNwOFl4ODlDWmtHdHJOUERCcnNGNGRsQjBE?=
 =?utf-8?B?SnVVWitYYnpFaDNjWmJsblJFSDJRWmZEQXhTcEpJcG4wQ0Y1blVTMlFsY29H?=
 =?utf-8?B?d0xsSkVKWUxSQUdaejA4MFVBQU9Wd0VFeHdVK05GbDAzUklYYXAzSlNiV0xy?=
 =?utf-8?B?dVVjbCtZa282WEpoZWlwWW1hTXJNS21rU1pwTEo3N1FBMXExUE9iMjd1eXF6?=
 =?utf-8?B?RThzTHdELzkwNUNIWlcxaDcyNkh0Sk9BcU5CTEVsT0dPTVVnOUxBTkxEVzI3?=
 =?utf-8?B?WHJLN2hzNG0vOHo1eHFmM1FBak1RbnFHNUVzVitUWEdQaVpBL2h5ZGxlV0RM?=
 =?utf-8?B?aHluR3ZGbzU5em5YeFF3bUVieGVob0NNM3ZDR3Jac0NGdGhCaDBRTjk1S3Fr?=
 =?utf-8?B?TUd6Z2RXVTFuSFU2b1lKNXVZZlhHblVoTG5UbHBsNnFKZzRTa3kxb1pBK01G?=
 =?utf-8?B?dVl3RzA1dE5iQ2RZTjROMXVQVlFYeVBpdlNIUUtLZmI4RGF6OVFwMkJVaEl3?=
 =?utf-8?B?ZkJFRVFBOUppSGpoamhLYktTZnI0cW5kc0xkZXY4YnA4ek1sSjhLekhrM01j?=
 =?utf-8?B?eG5ySlZxTlN0TklFdGhCZ2Z3SVB2NHJiMDNTVEtpRnk4UTFZMkFxNFRERnZo?=
 =?utf-8?B?UXBtUExIUHhPYVVJa0xZZlNQUHE2N2ZkZUlIWFl0OWQrU1JTUTk2N0FTbU0x?=
 =?utf-8?B?SWZ4Wm5BME1GSjV1eVFJZXZJRnBkMlc3RFRORjBPT2tIZ1BDbnFvd0xGSUg0?=
 =?utf-8?B?YlRLTVRrYWxNVDF1dW1YeEcrdE5yR0dCVEx6U0daelZ2VEFoNy9kRG9qc3A2?=
 =?utf-8?B?VHZKSy8rV2h0VDRnaVg4NDZzeTE3ZkhyVXl3aHMxQnNnMDVqR2hXS2YxRzkw?=
 =?utf-8?B?WU1QS2dPcEVoV0ozaSs5Y2FVcUhhV0hWTGRTYm9ZbjlncE5sb3hOVDdhcUJM?=
 =?utf-8?B?WHFFNjZnTG1UV21CR01nZmVFSjhxR3B4bUZ3SnEvcTZId1FDRlFjSHo5WVRz?=
 =?utf-8?B?Rzk3UmxTTnJlYmMwUnVYNElQNTR5NHJhbGNtWC9zNTEvbFY0OXNyM0FPUUZa?=
 =?utf-8?B?cjFnUVNuNzFjemlzZ245NFdaalZIMmNBWVM0MFpDQktsN3NCQXBCVWQ4SWhS?=
 =?utf-8?B?Wk91dDdXR2lhdThhQURIR1BCZUJkYTZNM0hJUTBJSkVhemw4bHFMOC9GZGR2?=
 =?utf-8?B?MXgwbFQ1cXc3MzJxTk5HWWdoUkRLYU5wdWVEYVE3bmJROVRGSzRHT25lSm5S?=
 =?utf-8?B?SzJjSFZSbHNNUTZrL3J3cGJXSVFoYThQRDZSQnFkbDl0dEdHT0dvYXJYOGNx?=
 =?utf-8?B?NWZDdXFET3JaeEdkbWlBcldyaktvTjVnVXpHZ3VhQXNORTVmN1pmRTI5c2Jy?=
 =?utf-8?B?VG95Q2RsR0l3MmlNQ3RvMGJSVlhnUHFVYUtyZStvbkYwWUh0MTFYbDFiTlg1?=
 =?utf-8?B?M3JzaFBZVDFuTU1oWWE1citaQkxGYnJoeVJPek0rZTE2WmVvSG1tRi9BR0pw?=
 =?utf-8?B?ckFjL0p1THpJTUxGNStBcFRpRzhqNTB3bGdrbkV5cHp3ejNxbG8zajQwWTFx?=
 =?utf-8?B?VXlwZ0FidE5IRlZrNUxGN1JjZWlneWpTRllhd3dOV1JMSURqeWJsZlVUSGkr?=
 =?utf-8?B?U3BQNVNleG5FdmNXYk0rTGl2elh6Yk9Zb0N4bDNZWFdRazJ2bENOUFRFUjRR?=
 =?utf-8?B?Y2FCMi9FNlJ1UUFVVW56M2VUSzJod3JzS29abndKekRhZGlhMUVoYWpFR2Jm?=
 =?utf-8?Q?PeLsm98UKgdFmsL+2XSbw1ita?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48c6faf-c56d-4d4e-7586-08dd44edc8b4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 07:30:22.5824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gS15Jm0jDCE+VIj9j0HWYfVlaZkZVxbPwN4EQZ+Ot4sMGm0a7c/Eiofa/z7WOGKB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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



On 2/4/2025 3:13 AM, Alex Deucher wrote:
> Manually disallow and then allow gfxoff in begin_use
> and end_use to avoid any potential FW races when
> ringing the doorbell.  There are no known issues
> with gfxoff that this solves, but it shouldn't hurt anything
> and shouldn't affect power usage since we are only
> toggling it around the doorbell update.

I think, this path shouldn't be pursued unless there is a bug identified
in specific SOCs. This really needs to be taken care by
hardware/firmware and driver shouldn't be involved. This may only be
employed as a workaround only if a real solution is not available.

Thanks,
Lijo

> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 7b01828eea8dc..96346a19950b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9826,14 +9826,14 @@ static void gfx_v10_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
>  static void gfx_v10_0_ring_begin_use(struct amdgpu_ring *ring)
>  {
>  	amdgpu_gfx_profile_ring_begin_use(ring);
> -
>  	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
> +	amdgpu_gfx_off_ctrl_immediate(ring->adev, false);
>  }
>  
>  static void gfx_v10_0_ring_end_use(struct amdgpu_ring *ring)
>  {
> +	amdgpu_gfx_off_ctrl_immediate(ring->adev, true);
>  	amdgpu_gfx_profile_ring_end_use(ring);
> -
>  	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
>  }
>  

