Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E532C3DA61
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 07:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB79410E4DD;
	Tue, 30 Jul 2024 07:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p4XtibAh";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E7E10E4E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 07:54:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2fRTmnNAXAzVQ2HfA3VvBfZUSifjJcxcLvxZ/O6MvYBznDinU/MzFrWcZJekONdIw5CbG2cd8Mo4zI8oqnA5BznMxzXIkk4h/scr4vIvYJj2SSyOjD3H+0W1WrtuOgI/SKdqOFyl0Flk2cEP+IOItaYAdocFln6HbgXrcfP7MYbkTiFFw/halNi2rxbkq+P4cwdXaYOwojCJTUnKRy3Cux2it4GZNA5rCKW1QVbldnJhrFDxAeX58K+3aKxD5XO37UAlRFRscn6EqNG7m2x83WBvYzP+bsdtMUMdL6w/Od7Ej7p0l8wDBNf8lVCTKTO0zhEr45Aaot4pypXeBftyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfu+hylOhPFoJgs8DC7V0dLKqeQG28kmxvDlfhYpsFo=;
 b=qNxRyQB/Q3kLK4XjHlzoTNR271+UnSOjVQLT8lgzGqrlLNcbTuypAcTyY6TdYMHtRTJhQOsYrRRFILSsqt/Hmvf0/phTS0zgDdm95tuHmlgQ7wTSpI80LdL+Nlv0XoDzmHdWlsrMLyL+gn139f+CcyzdT1Hhi/y0yA+H4/5GRFBWLiVGonBegAq+Asy0C2x8PTFFpn8a0ODyiyA8M0uMxJJp3scEceSrAHeNhLsjf+L/F6ezYCwBEgMendvaSQA0SExRobSv3MgWoeyHgI2uHd6d8c2ZaB9XBsFzA6lNfstI6mMFzmHkjowF4tpxck3CvWkK6v4iT/GPD9g0SGslmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfu+hylOhPFoJgs8DC7V0dLKqeQG28kmxvDlfhYpsFo=;
 b=p4XtibAhN+Se+W2FF53aienXJH7S/fT4HjUFwNBvYO9/fHC1wgSbyAJoQ2olSdCF3147G1OfcK/yvGqK0VGRED12OKc9ZtDSpaIP5m1zXvtkOaF0VghZQkqmJdYG0zAzaUZHhTwaGyZQKhC8/5pRs6LIgPInjNS9QDZ32yfzTyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 07:54:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 07:54:28 +0000
Message-ID: <217ab3fa-09af-42ca-b20e-37bd924b0aef@amd.com>
Date: Tue, 30 Jul 2024 09:54:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Remove debugfs
 amdgpu_reset_dump_register_list
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20240730064448.4187459-1-sunil.khatri@amd.com>
 <20240730064448.4187459-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240730064448.4187459-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e44c62b-bcd5-40f1-5a8c-08dcb06cd65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTVrdTEyNk52dG96dTlaTHNPV2dBRG4zV0h0cjdaZDhIVTc5ZVQrVm1YZXps?=
 =?utf-8?B?SnpKQ2s0bG1yQzFhTm0zeExPOVc1Z1BvdDlycWlRMUtUUExxTmJGa1dndE9M?=
 =?utf-8?B?MjUyRHlybUdic1ZCUWRnVEY2Y3pLTk04T21GWTUwUGcvVEhrY0FUOFpqZ2lV?=
 =?utf-8?B?cG9iaEs5QjdHTHUyOEpWTlVqUkV3N3l3ajVmbGJoZjZNQVdQOSswV09ZWUFT?=
 =?utf-8?B?dmljRkw2a0hMbGF5RWplQnpSbUtzd0RWbGdOUnFTVmxEcXQxazZMWGVxVFdW?=
 =?utf-8?B?aTJwbzVLRWkrbnZKSE1iVW5PTXJkcnhuMm5lbW5VaDBSbzIrTDBwdXpCckFj?=
 =?utf-8?B?MnJad1BOTEFXRUN3czdJdGdLOFhIbFIvZ2E4eFpJelptOWdrTmFsT1k0cXZh?=
 =?utf-8?B?WUlUaysrSFhTaDBmUGxmc3F4WlU3ZmdaWUFON0ZUaHo3c2NTVGR0S2syTUJJ?=
 =?utf-8?B?MXorYkNFQTB0c2dPd0VNZjNwcUlLU2Y3bWRrYmdSOGc4bmxsZG9uUDNBWXVx?=
 =?utf-8?B?WHhEODdRcGR6Y0JGdEFQTjQ3ZUFDTVQxWkorWVNvUERhMDNMdXJOSVJSaVh6?=
 =?utf-8?B?bDBRcithTVBHbDA3dzlJV2tVaHcxUVowUFcrRlpNL0ZOSmp6R2ZwMXhMT24v?=
 =?utf-8?B?Q0FyNjRBdmhDcTMzZlpNMlA5bFNkQkFrc1Z4eTZ6RUlZaHpQZjFuc2hnZk9v?=
 =?utf-8?B?UlU4YlVvbFBVM3A2YTZRdGs4K0NuU2ZCTjQ2ZTBHMENrMUMwWEk5UlFXVS9P?=
 =?utf-8?B?YkdJcnhIbEIrVkgrYTdYY0hwY2UrSWZ2a0pUR0pyVE5BMEJSY2loOVBLVVZM?=
 =?utf-8?B?ZEtqNHNoYTk5NEd1RERtQmdwZjJjNkxlTHNWNTZ6SkN2UDlUYWt4L3F6M2Zr?=
 =?utf-8?B?NFErQ3F2Wlp2eGFtT2I0eXBzRi8rNnMrdzBCZGFQMGRvQXJiMjQwTzdISmpv?=
 =?utf-8?B?aU1qZkZyL0d6UmJhdkNXRkNTQU1FSVN3ZGJaY3ZrbjdOcnhwdlN6am1iOEtj?=
 =?utf-8?B?NG9VL3lJamM5TEJHTGdMSXQxTnBvVm5wY2ZNTVFsWEpsUnNqMUt6RTJXSklp?=
 =?utf-8?B?eEtvRDF0REtZWS9kVjQ2ZTZpKy95aDJQSkVvRlM5dVoyd01tc3lhQTkzcEY3?=
 =?utf-8?B?d1JTVWR6OE9yNStEVGtud3h0N1owUXZVY0w0UTZudllTQllNYk1iMEhYZ0lJ?=
 =?utf-8?B?S0VwYWtPZFlTQ3ZsYVAyTXRlRC9YLzUwbVdxS0VjcEhVajErNVk3dlB0VkYz?=
 =?utf-8?B?Z2FrU0hUdTdqTi9oakVlQnh6Tm9PSUtPbGY0ajhMOHhzNlZHN08xWnFKNnNa?=
 =?utf-8?B?OTV3cS9CWmV0S0RUZ1BzMjdwL3JTSkNMeC90SEtOTHR1aEdCbjJrT3ZsQnpx?=
 =?utf-8?B?RXpsMGRLV0t5aEk2ZDdiM1hONko4aWloRjRmL0FJM09WZC8wZmltNDkxWUMw?=
 =?utf-8?B?V2NwUGY1d1BVLytoQ044QVYzYS8xL3RzcDR1UGtNeGlnWHRrUVpCTDR1NHd0?=
 =?utf-8?B?NWI2cUR4cXJpb0t5Y0ZEZ1lKb1ZKYzBicWxtUVFTRlZMZFF1L3V4bHhwMUlS?=
 =?utf-8?B?WEpiVGxoM1p6TE8wUm53MnRYSUM3dFRhM2tsdkV6MUt4MTI1blF2RjIyVW16?=
 =?utf-8?B?TGIybjlwOUozYlp2Ky9rRW43WHY2aFJhVHJyOWphalZKZzZsSytKVjlEeHBV?=
 =?utf-8?B?Q3IrVVlvTU9XQTNYZnpWQ0kzVWs1UWpVMXR0a2czSXVwbkh3ZDZjdXlmUjJD?=
 =?utf-8?B?dndsbWlocWp0SWs4TldPczMvenBzTnI4SGgrWW9QZzBqWkFXOXd5RlhOdmhY?=
 =?utf-8?B?dURXVzgyZG1mMS9lbFpmZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjM4dkluMnFCdUM4Mm43WE9YRFRVOTQ1T3VvRUZFdW1FTzdmK2xDbmxJbG5S?=
 =?utf-8?B?ajhnRjJnbHFITjFCWkh3V05NNnZEQitiRjRqcnZIb2loUHRrdW54ZjVpbHEx?=
 =?utf-8?B?UmZVdU5VTGxYSmg4N054RVN4KzNud2x6eG9tRVJxMjc2YjYwcmsyVHowTGxs?=
 =?utf-8?B?Z3lMWGVGb09kRTVpZkNwdEdUQmJLMkliQ0tDeklkenRIalpzS29jRUZaekZj?=
 =?utf-8?B?VGFsSzRIbGN2WEo4V1JuTWVlalltd1VJcFI1YWFMN3RoNEtiMytiV2V2eE1t?=
 =?utf-8?B?YzV2czZEcCtpajZYZFdsQUZzT0ZBSGN6RDZKeFh2N0c4SE84Y3gxWmF2UWJX?=
 =?utf-8?B?aERxbFlvQXczdTV6NWtLTTN4SitIUDFKS1lVWkJMQVN2STNGVlVTSmxSY1Nj?=
 =?utf-8?B?ZEpyWGYxUStnL0M0eUcyWDRhQzRaSDA3S1JvcGJHUDFwNkcrTTVwWUhObjlz?=
 =?utf-8?B?Rm1wQVV1QnA1MnZnZGg2UjFkcDVaZ3FQWTA1b29LTldJeVZ1NlNvYUx0cEtp?=
 =?utf-8?B?Z2ZOUUNaWDRBbE8vS0gzNG5la0JvZ0ZTUnlXOVp4M2w5QnEvV21FN0hJMkRx?=
 =?utf-8?B?ZFpERXQ4aFNaSlFsVnIza3B1aFRHM1VHY2hCNU9ZZG4wL2V1SEg2aWorSDdE?=
 =?utf-8?B?V2NPU0x1Z2FLenFVV2J3SFMwc2Z3K2N1RmtXalY2eDgwbjh3MS9zZ3FSS1l0?=
 =?utf-8?B?RUpVUjMrdW83WTE1aDIwNTcxQkxIWWl0eTB3cWJnSzhmZ3lyMW55YWh1MDN4?=
 =?utf-8?B?NUhhVjV0MkNXRjJvbWFNekNSd3NpMkdBMXdNbW5HQW9TZzFYZmdBTDB1VmxY?=
 =?utf-8?B?WUlaSW5MYSsrYnV0V1VROUZqbndGRFQzRzJ3TUJyejNaTGNjbG1ScUYyZVpv?=
 =?utf-8?B?NVRxMW9jTVhoODJkUXFuSmN1Mk4rSTRmUXlBTGpLU283ZGg5VXExVHZQa0VJ?=
 =?utf-8?B?RWoxc1FuVGpRSFpKVWhSeGRTemVpZTFMMk8xNFhMQzFJakM0anlML3JiaThk?=
 =?utf-8?B?YXR1RzdqeThLRDZtK2grekxtRlJDOXB6bXNOL2xid2N3cnd4YkJCckM4ZkU4?=
 =?utf-8?B?NVNkYXdYOXM5b1BKNHkxM28rT3VUQ0FwZXVnN2M4OEM4eUJ1aGdQaWlBM0I3?=
 =?utf-8?B?a1hkSStlMEdIekpnc1hyYTFPczBBZXZjNXpRaGF2MXkvOUhMRmhYWDNDN25V?=
 =?utf-8?B?MDNJYTNiejBMa0ZIREFaZ1EySjBFTVdRRE1NZ1JpMVJDWkFwQncyd2lhVkVJ?=
 =?utf-8?B?NzE5cWtKOGFoM0pRbG9SRDJlNHpPbXFzM1hsRC91NkN1R1pyNklacWdSY0Q0?=
 =?utf-8?B?NVM5c0QrZWJCUUtCUDBlMUhQWGtKaHBSbkpReE9TMzFmZHNvdE40SDNJbjhp?=
 =?utf-8?B?d0RmRkZkb0hTWnFvd0pHSDVuVUdwemhEZFJ1MjZncXdYd0Z1RGZaYktvdWlC?=
 =?utf-8?B?ODBYUnJiUEtYWndHbGY0WGNyMFhXdDZNeTlxUDMyY3dOSWZzSStESU1CR0FZ?=
 =?utf-8?B?czc2cUdOZmdWMVFseDEyZ1dFMFVFbTRMYXo3ZVJidDBsTCtKWUdNZkc5YWZi?=
 =?utf-8?B?amJyNnNuOUo2MXVrdjd1SUpja1Z0dmtPdER3ckYwblhDclMyaEpqSTlWTXhi?=
 =?utf-8?B?VVlQakVic1kzMUNJaXlSTDBjRURuOE9TSm1xS0FFMkxqM1FUaGpYdmhoeFFC?=
 =?utf-8?B?bG5HWjNxSjRJU1RRZExJYlh4OU9icG56cHA5VGk5UVRIT0Q1Z0ZlMmtJM3NJ?=
 =?utf-8?B?ZkptM2ZrKzdWV0ROcDhOZ2J0dzNSUjFEMGkwSjFYdVgwQUVvNmpVUVJ1Tnph?=
 =?utf-8?B?UVRtQTQ3MjZ6VnQyRmozQ0NzUk5VdTNjeHpUMkphL0xObm53L214T2ZQalVu?=
 =?utf-8?B?bjVDRWh6NjZRaldRblNMdjZ6d3JUYkJGbXlhdlhHRkNheXVYTDI4VTdnMGRw?=
 =?utf-8?B?WlAweHFZUE1NTWxENkJoalZIemhwbVJEVVlIcHU0Zm12eklBM2ZnMjlDNyt1?=
 =?utf-8?B?VFI2TlliRGtaaVJWYktoTkE2eGlrVUdsSlp5ZDB1K2d4bWtteCtPdXh4MTkz?=
 =?utf-8?B?aGVsQllZM3RkK2lnaWVHK3YvRGhhYi8vdWZNbktIbWpEWk12b1JVTkYyTnll?=
 =?utf-8?Q?xwtdcTJKMm8u8gEMKYlBnQibe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e44c62b-bcd5-40f1-5a8c-08dcb06cd65a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 07:54:28.1239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zr84KhSeIOaY+Pnr4V3wb6vo4KEzN+fTo4iG/zqHa+x6FQWe5tmSBTomJwCfoW6v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Am 30.07.24 um 08:44 schrieb Sunil Khatri:
> There are some problem with existing amdgpu_reset_dump_register_list
> debugfs node. It is supposed to read a list of registers but there
> could be cases when the IP is not in correct power state. Register
> read in such cases could lead to more problems.

You could be a bit more specific here, e.g. "could lead to ASIC hangs.".

>
> We are taking care of all such power states in devcoredump and
> dumping the registers of need for debugging. So cleaning this code
> and we dont need this functionality via debugfs anymore.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

This patch and #2 in the series could potentially be squashed together, 
but either way is fine with me.

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 ---------------------
>   1 file changed, 96 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 0e1a11b6b989..cbef720de779 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2026,100 +2026,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> -static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
> -				char __user *buf, size_t size, loff_t *pos)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> -	char reg_offset[12];
> -	int i, ret, len = 0;
> -
> -	if (*pos)
> -		return 0;
> -
> -	memset(reg_offset, 0, 12);
> -	ret = down_read_killable(&adev->reset_domain->sem);
> -	if (ret)
> -		return ret;
> -
> -	for (i = 0; i < adev->reset_info.num_regs; i++) {
> -		sprintf(reg_offset, "0x%x\n", adev->reset_info.reset_dump_reg_list[i]);
> -		up_read(&adev->reset_domain->sem);
> -		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
> -			return -EFAULT;
> -
> -		len += strlen(reg_offset);
> -		ret = down_read_killable(&adev->reset_domain->sem);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	up_read(&adev->reset_domain->sem);
> -	*pos += len;
> -
> -	return len;
> -}
> -
> -static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
> -			const char __user *buf, size_t size, loff_t *pos)
> -{
> -	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
> -	char reg_offset[11];
> -	uint32_t *new = NULL, *tmp = NULL;
> -	unsigned int len = 0;
> -	int ret, i = 0;
> -
> -	do {
> -		memset(reg_offset, 0, 11);
> -		if (copy_from_user(reg_offset, buf + len,
> -					min(10, (size-len)))) {
> -			ret = -EFAULT;
> -			goto error_free;
> -		}
> -
> -		new = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
> -		if (!new) {
> -			ret = -ENOMEM;
> -			goto error_free;
> -		}
> -		tmp = new;
> -		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
> -			ret = -EINVAL;
> -			goto error_free;
> -		}
> -
> -		len += ret;
> -		i++;
> -	} while (len < size);
> -
> -	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
> -	if (!new) {
> -		ret = -ENOMEM;
> -		goto error_free;
> -	}
> -	ret = down_write_killable(&adev->reset_domain->sem);
> -	if (ret)
> -		goto error_free;
> -
> -	swap(adev->reset_info.reset_dump_reg_list, tmp);
> -	swap(adev->reset_info.reset_dump_reg_value, new);
> -	adev->reset_info.num_regs = i;
> -	up_write(&adev->reset_domain->sem);
> -	ret = size;
> -
> -error_free:
> -	if (tmp != new)
> -		kfree(tmp);
> -	kfree(new);
> -	return ret;
> -}
> -
> -static const struct file_operations amdgpu_reset_dump_register_list = {
> -	.owner = THIS_MODULE,
> -	.read = amdgpu_reset_dump_register_list_read,
> -	.write = amdgpu_reset_dump_register_list_write,
> -	.llseek = default_llseek
> -};
> -
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -2204,8 +2110,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   			    &amdgpu_debugfs_vm_info_fops);
>   	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
>   			    &amdgpu_benchmark_fops);
> -	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
> -			    &amdgpu_reset_dump_register_list);
>   
>   	adev->debugfs_vbios_blob.data = adev->bios;
>   	adev->debugfs_vbios_blob.size = adev->bios_size;

