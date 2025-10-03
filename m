Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4448CCCA471
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 21:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE16810E0C3;
	Fri,  3 Oct 2025 21:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QzKIW972";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD0B110E0C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 21:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtwpGJ0U0DjsJ9l8l1oozqeKjy7O//MYRlpvvAp1Ektcoxs/bsaNwRJdRw9XSyXD1hVRQq4VViLjS3ukMWv3225WXBRM5E9wKCHYpuSp5jUF21McLO6SHCTXETsaxD2ZQ2/6V6G3tnb9r8dq4fziOl6C9V7QghE5I7pwV8t/TE86i79SIBPp73zTkLVOVJJflKaArxlx2CIKK47jwLIh1rq5MWmHd2Ao93k52xQyTbwgyBkHVO6sFfRa5UWwF8WBs1uc1yxQmbjjB0+0xj2z35bcYdW1uTFVFGM0QFmfOJ7Rv2+FMwkzNsl0Lmhoum+zr/4YukdR607r+orsmYlwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMNHhTZ+4vXy0r6KSmFKY3E145wc+VZYchDUh06gJxk=;
 b=fPc3zrZVKeVD9iUY85J+fTbBjqigJVGyB7VSMGdq5TVFNU39aEk1LH4UAHs4P/BhlZccmJS8t2Lhs12IXRo0+FsuqIAdBzOF9hYcEekPmnVEFEZmwl+hKyZS1Jf8UkV4AkANbo9TBqEKuh1EceWr0TZjkfYzm15E4pzybOg7hEMC28ZQEx8KpMjEGg8CoduadeLN8Hq0oLSCWAWmlhWxaVdm9O4LsdZ+3uGRj2Gm6ztkVEpSLAthdhEdDpS1K3AiT2Eo2GGFq6GU4EgJ2v1/9ldDe99wEBM2qGy1r+JUTM3A7jnjowrenEfuxpCc3CWPFHH80eHiGNfvVW0TTXRgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMNHhTZ+4vXy0r6KSmFKY3E145wc+VZYchDUh06gJxk=;
 b=QzKIW972fCXiSHHSMREY/7kUMMwXdXJZRf5umrpxx2QSrZbqs61oL5Lf6jv1BFYcPToQr3iQabyghZSMXlGVWwnSPTrbh3u4XOczi8zJNb6lzfNBE60LnJbvMzp8WyK1WhJonIa6KqFcH1ghCTN3SiulkH5NfHmU1apqBlrfK5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Fri, 3 Oct
 2025 21:05:54 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9182.015; Fri, 3 Oct 2025
 21:05:54 +0000
Message-ID: <87ae1017-5990-4d6e-b42c-7a15f5663281@amd.com>
Date: Fri, 3 Oct 2025 17:05:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250926210331.17401-1-Philip.Yang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20250926210331.17401-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::15) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c93c850-1a66-44a3-29fe-08de02c0a3f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REJvVzFYTWFqTWZ1bVk0NjAxcGI4V0RqU2h1VmxPSnJ1c2FwV25hNGFJc2JZ?=
 =?utf-8?B?WDZ0K1Y5cGtLMkJsY1g1alM5WEdWdE1KUDZBMjFnNEJIc2ZpTU9uVlR4TFdi?=
 =?utf-8?B?K0hBQ05iN0lWelI4T3VmY1Y5d3hBR3RLSldNUVd2V0h5VHNwUDJmZFdseFcv?=
 =?utf-8?B?SmxXVC94QkhtMitHWjdjdGFBVkxQeStkU21vRitvMkZOVTdQUGtVM1ZXbk1Y?=
 =?utf-8?B?L1BJcWlLZHhlVlJNc2I0Y3RFMDVwMVNLZTJWMktGWjdqQ3k4NXJYVHFzZ202?=
 =?utf-8?B?R1htRjNwWXpmU1BpWWM5YzNRdDJrcmN1Qm10L05PQTVqNEllZi9DM1NwVHNy?=
 =?utf-8?B?cUc5V0d3SmJaVCt5Sy9QUTB1UUJXeG1tK2NlUy84UFVMUlhsTU4rTTF1UGox?=
 =?utf-8?B?UU5hQ0pzU1Rac2k0aVJlcHdVSU1NQ2Q1VkVhZnhFU3U0dEcra1pEc2JpZ0Y5?=
 =?utf-8?B?ZitQYzZDMHNMTW9DVmxoR3B6QWNzbXZoMUIxZXh2SkxKdGJyUFlBTHV0a0xZ?=
 =?utf-8?B?UURNaWFMV0cvVDV2NlpjRUhNSnJKN0I3MlhVc3g5N2lSSGwwK3hJS0t1QXlu?=
 =?utf-8?B?MU0wK2JvZGVBUDRoMk5UNGoyRVJ3NjBaQ1YvdHFVUW1zZGtsVkxqeUJnblZk?=
 =?utf-8?B?K3RYYU9OZ3o3N3NPRG9VREZ3V3BySWJiMWlRNzJIYVk1WndTQ1U5aVdad0J5?=
 =?utf-8?B?aGIrZmplQW5JN0xIRmFmVzR4cXZQMlYvTEtYUnVweW16VVBOODdrUDdZU2Z5?=
 =?utf-8?B?VklhaGNSVjZ6QXZUSVRnMDRjcWxxY1RpYVV4SnU1WTk5VlNXajI3aFFZZVpn?=
 =?utf-8?B?TEpsMDByMHZraFF1UXhJMW5iTk1GYjN2ZzAxaDg2QXlTZ2RwK05aL3o4WUFB?=
 =?utf-8?B?UXdROHo0NFR1M2graUN5a3pDK2tFNW1aZmpPRllXeVk1bzZmeVJwbGxLT0dL?=
 =?utf-8?B?S0RXNDN6OWxoSzBUYWlabW80ckVwQm5sOGRwdnBlQ3lyYTFuSXZqVGkxNkNM?=
 =?utf-8?B?RGxlblI0TVZXVzBvcWNzaVlJdENnQ3RpMTJJb0wxU0hQWUNXbGdyZ2xtQi9E?=
 =?utf-8?B?MHN4QitrQU1QcFNvRkN2N3o3MitLS0NCZEp5SURpdFk3YXdHMExwUUc4eFR3?=
 =?utf-8?B?cFJKWG9ENXhvRG9ja2tCVWVReWN4T0g4KytsNmNidlBvaFdlRDd3WkVIcEZX?=
 =?utf-8?B?c2M2UEhuY3VOeFFncU16ODM2MTFmT01uZ2JxM3ZTZGEwb0ZxOTdNRCs1RDFL?=
 =?utf-8?B?STNOV2J4YWF5ZjhaWHIvS0ZBMldyNG5rK3p2RmtCTk5tQ3JSNTRWZTlqTTZD?=
 =?utf-8?B?TERwMXZJbmpFVTNPZVlBNlU4T2EwMEhHUjZwdWNZellqSXljYkkxdEl4STh6?=
 =?utf-8?B?alQzRHhZZ1FRODlEd1NGdFRKemM4ZDZteTdFT3FxbDJqL3B2NG9kbzQySnN5?=
 =?utf-8?B?b3dPSUxncGJmaHlSMjJ1SFVrMkZYQSs4SEM2MUFHbWRRUXZXUXp2RVlTZW5v?=
 =?utf-8?B?OThIWVJ3Tk5USWpPQitnS3p3VWtKa1M1Ky9MTkRzSVAzNlBTRUVSMWFWaGxR?=
 =?utf-8?B?b1JmZlQwWEhlMzBIQWo5Wlp4b1g5SmFYWlJkOGY0MCtld3B0WGcxaTFkZ3lL?=
 =?utf-8?B?VnliVHZnZzRmSFZhZ0E5bys0c1I0K3Y1bjRENklwRWd0SDJDY3IxNXhGalE4?=
 =?utf-8?B?dHduU0R4WkhJZEdkT1JibDZnd3Z1b2t5dUU2YkJxa1dCRzNic09SNEVVVDAx?=
 =?utf-8?B?VklKeUFsTVVaMDM1L1VTODJESUZUbUQvMmhjUldYN1gwRUM5dVNLUDl0TjZ1?=
 =?utf-8?B?UlZHb0VJaThWRUVXQ2sxY3c1R2VEbXlDMVVBQ0FWaHpZMUI1YlpnN1pkRUdS?=
 =?utf-8?B?WVJpdkU3M3VKWWJ5U0p4MTkvSVFDSklwV0VrOFBWQWhQVkxNZEN1L1NlQXUz?=
 =?utf-8?Q?bLpso/j3cPwNXlI9D8sal2+CgyPyAPYs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFRwajhJSEtaM2hJUExmOVZqeGl0OHAyTmF5bWdoNURWd1NyS2FqWGFLSUlw?=
 =?utf-8?B?RFF2RXhrOGNmTHhXUXJ4UUUwZ1N4cTlLeng4M3c5TEZ1RGk4MENiR3lraDdr?=
 =?utf-8?B?SXlDNnVBUXd4Y0U1R0Q4WDQ1M0htUG1KZ0lhc3dpYStRK0UrSjJKMDNJWDJ3?=
 =?utf-8?B?NXhFcDJuclFROGtKWWRFWnZGUkV3czR4OWlzd1h1ODhMWjBITGRIRFVDRDhm?=
 =?utf-8?B?RXRMVTdDTFlkbEhNVjZFejJiN1liU3hpUS8weEdNQzVGWDMyTCtSd3FxQ3Jt?=
 =?utf-8?B?WUdSdFlwVEdDZWo0QUNMM2M5VnA2UzhBNWdySkZuMG5YUTBTRUhXa3JVWU8r?=
 =?utf-8?B?bEZvVDRKdlZhT3VxQVZETWlTelJxcTdCZGdRclc2d01mUFdRQTJhTnF1SzAv?=
 =?utf-8?B?OE9VUmM0aTQxb1Vlck0wdHRlb1RyOW9USU5kdXlSY3FROHIyYVFMc0ZDNXJS?=
 =?utf-8?B?WVZTTXAwMGlGeEJsZEtCMHNNQ09OUkQ5YnYrZDlyY2dMS2toMXczOTBlNzQ1?=
 =?utf-8?B?ZHFLZHdrYkxGdzArb3dTS1BiYU1ScW9ZR0ZLaTlWSVh0bU5lZXN6MHRYRy93?=
 =?utf-8?B?TmJyQW4xMVNYZWFDWEhVYlpOVzhMU3hzZ2wvdVJDdk43VkVkdno5TVdDUjZl?=
 =?utf-8?B?VTg2ZnVFR0JRb0ZtUFpKTGNKWjI1bHJMd1JBbHdsMmRYem1CQzJVZFNXY2lx?=
 =?utf-8?B?TFNXZ0MzT2NCRlJzSDJLTHhEbVZOQU8zS1FrL2dvdDZNWEpLUUtzcjBsVmhS?=
 =?utf-8?B?MGxFTHd6c3Vza0ZuMkhmRFlXbnZwNUN4UWlRUXpadDNuYUlQajBObWlTZUo0?=
 =?utf-8?B?cHRpdTFxY0hjR09maWs0ZVdVS1pyNmdYWUViZ0ZwUnVPN3hQdzdPVUhUWFp3?=
 =?utf-8?B?RGxuMTViMDJNcUY0TFZOM3BldnlDR3Y5Ym0yVklJMmpOMXVxSy85K2ZOT1RV?=
 =?utf-8?B?cGZxUTRDOWUrYzRQdjJsV1ZwZ1NoaE16SFZRM0FTUVMzM2dVcGpjYUF0WnY3?=
 =?utf-8?B?R3dGOXQ4dFZnSlZFeDBIR3FrM09aL0pQTEdxTi8wTVNNODNVWE1NUE1Gbmlt?=
 =?utf-8?B?OU5sRkJySkFENGR4R1dmaDZpQWpxV2dZbDhFQzhvVDArWmlBemc1bDFESEcz?=
 =?utf-8?B?NlFkb0xrM0lvVWRybERzdlllL0hpMHRGakNVMXJsYm4yM2xKNGhaNlFLSVNW?=
 =?utf-8?B?MmVKMzhvOTVjSmJsTVBTUzJiQllVRWx2eTRod2VOanBCdVk1dHlBOEtackNu?=
 =?utf-8?B?aU04cXJycEt1K2c2UVNydW53YnJOQUVvRExHZjRqczA4YUFONmN6TWxwTTEx?=
 =?utf-8?B?R2NkMFNPM1lzSEhhWVdsMno1aEhjdHB4eFkzb2hDQTY5NUN0OWtrRXRheHlD?=
 =?utf-8?B?Rnk2UzF2YXdDc0tEZ3RFUFBXbFNEVVF5RWlWSy9QZlgyQk9HZlVhRTgvZFJa?=
 =?utf-8?B?cWkzWCtLc1R4bTljcVAxTS9TeVppb3VnRHpQMzlRSXhPTkwzaFZIQStxd0cx?=
 =?utf-8?B?YUlKMTlESnE4MDA4ei9HQjFVcm1pYVgrRWNJelNiaFdaRzRsTUw5L2k3Q0pk?=
 =?utf-8?B?TXFwTjlxc0ZKcUFwU2M4UjdWU2RLREtVRFZNOG0vWlhhbGpoRFBRWkgwKzRC?=
 =?utf-8?B?SUJVNHArVSs5ODZ2bnE1S2NUZmdCamQ5WlZPbWs3eFBCM3R0UzdKdkh4R3ZC?=
 =?utf-8?B?VENxRmxIUHE0aUwwdllxa05YN2pVaGU2YnR0WmZ5WWUzL2lLdU55TEpIN0Ft?=
 =?utf-8?B?TnFZekxxNWozekNwOFdpbTViUGp5alRETmFwZERqY01ISFpqVXF4MXErSlJK?=
 =?utf-8?B?V1dnNTlhZDNlVkdPZStRVWc0amJtbGpnVC9wQ0VZZmdGL3VQMlZSeVNUdFNY?=
 =?utf-8?B?amxhdnFic0UvSTNUSmJrbUNjWnNOTklBU0VTVmloSEErZ0wzZ1Z4M3hONjM0?=
 =?utf-8?B?WHlPQ0gxMUs5Tk1SMXV2Qkc1aDFFOUlPckZCLzZCdjNxSEhKWlFwSUxZM1cv?=
 =?utf-8?B?bk95enJBSTFWZm8ydVJZMEdWRklXRUIreDlQNHgyNkIzVVFjemx6VEQ1KzhT?=
 =?utf-8?B?MmxjNmc3MXMrNjh5UGdQMlZUOHRWbHc3bW5WZHk3STF0TVJXWXVlOGtldWY1?=
 =?utf-8?Q?ydmH4BeCan0kLDPibqQpCCUKa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c93c850-1a66-44a3-29fe-08de02c0a3f6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 21:05:54.2179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRgY1H2Kua1LmCztaEuwD9WRgAE3kKFrT5fLGXeWNFJPxm6EohrlWpd0K7xMJPhUVFZniX41V3t6xz7MlyJv3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On 2025-09-26 17:03, Philip Yang wrote:
> zone_device_page_init uses set_page_count to set vram page refcount to
> 1, there is race if step 2 happens between step 1 and 3.
>
> 1. CPU page fault handler get vram page, migrate the vram page to
> system page
> 2. GPU page fault migrate to the vram page, set page refcount to 1
> 3. CPU page fault handler put vram page, the vram page refcount is
> 0 and reduce the vram_bo refcount
> 4. vram_bo refcount is 1 off because the vram page is still used.
>
> Afterwards, this causes use-after-free bug and page refcount warning.

This implies that migration to RAM and to VRAM of the same range are 
happening at the same time. Isn't that a bigger problem? It means 
someone doing a migration is not holding the prange->migrate_mutex.

Regards,
   Felix


>
> zone_device_page_init should not use in page migration, change to
> get_page fix the race bug.
>
> Add WARN_ONCE to report this issue early because the refcount bug is
> hard to investigate.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d10c6673f4de..15ab2db4af1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>   	page = pfn_to_page(pfn);
>   	svm_range_bo_ref(prange->svm_bo);
>   	page->zone_device_data = prange->svm_bo;
> -	zone_device_page_init(page);
> +	get_page(page);
> +	lock_page(page);
>   }
>   
>   static void
> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (mpages) {
>   		prange->actual_loc = best_loc;
>   		prange->vram_pages += mpages;
> +		/*
> +		 * To guarent we hold correct page refcount for all prange vram
> +		 * pages and svm_bo refcount.
> +		 * After prange migrated to VRAM, each vram page refcount hold
> +		 * one svm_bo refcount, and vram node hold one refcount.
> +		 * After page migrated to system memory, vram page refcount
> +		 * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
> +		 * svm_range_vram_node_free will free the svm_bo.
> +		 */
> +		WARN_ONCE(prange->vram_pages == kref_read(&prange->svm_bo->kref),
> +			  "svm_bo refcount leaking\n");
>   	} else if (!prange->actual_loc) {
>   		/* if no page migrated and all pages from prange are at
>   		 * sys ram drop svm_bo got from svm_range_vram_node_new
