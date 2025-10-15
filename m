Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3E0CCD192
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 14:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911CE10E80D;
	Wed, 15 Oct 2025 14:31:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="enGBPXXA";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A19310E805
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 14:31:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGl8C9+0lKQSwUs6W2Unh78PQWChwIzkSRoLKOr53gJg+cjmh5KyMfI6zpOw3X9GsRgAC1faBWy4Ia6kBdmcoF0n6DNG3T43K5MdcZFgB3oVq7H61A7ml6ZJAcNStQmeiKEqmnyxQGir6SCYdJyu33uxbITLYNOfsmQmLvP5VlERM8lLHDkJ+UJI3ZZi/RFG7mGrVgWETDg2TAK9Uee4iCljacGXOuzPYxDNqBD+UQ/HOXxTFSV38tYS4xMeaWKTVO1DuiaXlqaSBfDeGgxpH2DKgUT1CroUOvG5jgiWAdjvoCfQU9TnypXd3xa+WEG2lL1L3x7Fv+PVz5jwujxV/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1s6qLQW3KsSM52z0EpefZWOQbBnAK+GHq/2/4oofBDM=;
 b=uObGMiYdJgr2aA32++vXL3vKELXncaVLtplrd+PJSCb4RqsMl7SEpBnms7EI3GJeAve0DYWjVJ/EkaUg9Q3ZutCPFjME4PYBxG7RzPMMnxeAuQNkM9XgC6XxOwwo17clMzZZajAltfWQ6ZmPkFKO0RneVl1NlqyRuLrkPXJ3NI4WnxuruJ/XlRCbxItcJq8+7/1n1E6K1lxdBFNVPRPYVvvs0Ba1AqYdADcbpWr/DxfSDZzZhzODpaDr3COnvcUhE4oQHaMJHiKqF4+ZCnCElnIOqO8OUz29Alqxn7Y9887V5StJ0dHoRbGAjBxAupOXaj4evvadFuMmAbhWaYMiOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1s6qLQW3KsSM52z0EpefZWOQbBnAK+GHq/2/4oofBDM=;
 b=enGBPXXAiqFrcsiCt7haEKpv51Q2fb1bgZvsNxERMsVZTOjnTiMbmdCsYNitRHPOeP19TLj8oiVWMmaXnAzNMAz2fnrxABRkW6N67MvErgWhmAvcp5TfnmG4LZhtfmdhcjpgu3TWMBg3jcwSUOmRqnEXhVdTDYrH6761PGxZ+vQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.13; Wed, 15 Oct 2025 14:31:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 14:31:02 +0000
Message-ID: <6cc92ce5-908a-4b90-93d9-c648a48af49a@amd.com>
Date: Wed, 15 Oct 2025 09:30:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Check if display HW is enabled in
 amdgpu_dm_atomic_check()
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20251014193036.595453-1-mario.limonciello@amd.com>
 <20251014193036.595453-2-mario.limonciello@amd.com>
 <CADnq5_P-9F0NsOK_5HG06YP98vqJH+1RXxfEnhnAhQ_U1Q=DNQ@mail.gmail.com>
 <d462f951-1b9d-4390-800f-9af09a7282d5@amd.com>
 <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <a1465fe4-f17b-4a72-935d-df0105a45e6a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:806:6f::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b11e15c-b816-40be-0c75-08de0bf77747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlNJUU9qVVBkRy85dmQ3ZHVEU0ZsaVo2K3lrcExzSGxRLzRLRnFQcHA3ejVB?=
 =?utf-8?B?SXFSVFJhR0hJc1owQ3RnQkxnK29iMndWeS9TdEpad2NaRkNnbXBDYUdmL3pO?=
 =?utf-8?B?WHoyQkRHbFlGRWdURXJEYjRtRWtENnZuTjZsYVFtZFVSWmJ3SUoyTWFERzEx?=
 =?utf-8?B?NHVXTGdPd1VPUU9SN0Y1dEw4eXMxajQ5T1lhMU96dk1CMVNPaExTTkx0UmYz?=
 =?utf-8?B?ZkQ4ZFlMWkhxNW10MTZESE5iN2Rsd1lJRkRNb3BPajB5MHNNcEZXRWxNWjha?=
 =?utf-8?B?WFplTEZHR2xabWpWV0gyek1QdkRLYmU5cGVQc05SdUNiWjErWUh0WDdrU1VG?=
 =?utf-8?B?d21IY1B4SmlBWVlOdE1pak5FZnI4bjVoay85WEkzeWk2aTNzL05vZUhNZ1lF?=
 =?utf-8?B?WU9BaTZ4Y28yV2lWelN1V01jSmIya0RRR1Ryc0RqZG10ZG04TlBVTFNLWC84?=
 =?utf-8?B?MFJWQ2hyR2NRQTBhRkVrUmRUZVd4aUg4Z3RGWTRhdVZ3eGhQWUZyMk1IMzhE?=
 =?utf-8?B?VWpKOWN6dURXcnZzNFpIRlc3Q2U5c00rUmphZmZNWGprM2h3T3BmU2NOTnN1?=
 =?utf-8?B?VnVIa0VOOWJhWEl6bFlGMmluTXRGS0JrZFVXcHFrTStOd2RmSUhGQzlYUjls?=
 =?utf-8?B?UGhENlFQS1R6R3ZzbVU3NFJvb3VQNktUNGhFWDlYQ2dMRDE5MURxM2g5WVY0?=
 =?utf-8?B?eXlYU0oweTcrWkdSSVhkcHNDMlZ6RFQ5MDBacllCQ1JpY3M3SGcxLzBnYXNE?=
 =?utf-8?B?UWhiL1NCQmZvZkJpS3l0MnJwcnlQNEhicWFkRnlqRFBQemoxM2EyUnU0d0p4?=
 =?utf-8?B?QWNXZGk0L0l5T0l6ZmZRSSsyYVVWZGNWQ2NiQXJqZlE1dDJzbmdFQ2NKSTJS?=
 =?utf-8?B?OFVUZWtxN0VYOHdNZ20wOGhSUTFOZC9lWmdxWUZCeW9USE9TK1JpOThGaUJL?=
 =?utf-8?B?c3ZSQWxmVWluS2ZBWklrSjRRYmhNaUc4dFJwODQ3OFg1ZDlRcnZ0YjlLL0Ry?=
 =?utf-8?B?MjBwOUxzRjFpOVoybUZpMHdrZC92dTE2WUcyY3IvcHJWSVVDbmw2b0pDMWIx?=
 =?utf-8?B?alFsUmo3SlNpSU8yZE5BZTlUSVF3UktYWWtPSTNxMWYvYnVHdzZiRmxhRDB0?=
 =?utf-8?B?dDAyNGFKem16TmJOV0tWcUtNRnM4T21UZGQ1cmdlZUNVRi9nUU43T2tlbEJp?=
 =?utf-8?B?czJaaEpnY0YvaGY2NTg3VDNoTHBRbUN5eC9nOWNYc0l3RXV2Z0FPZm01WkNC?=
 =?utf-8?B?N1Q5b0ZKY3V0bE5od01xaDdHZzlsYUwzQ1AzUTlHWGdqMUNYbDM1SlNXOXZC?=
 =?utf-8?B?djYvWi9CNnh4NklnanZUQXEzSXFBeTdRcHozRGM3cFkxODlheTdTU2NOTHZF?=
 =?utf-8?B?blRuenh6MjRnYlRJT2dmTytpMjhuWVQrclN4N1M0YTk4NFVJU3ZnbGVhSTJJ?=
 =?utf-8?B?bDdGME9mU09uL2tYZHBxamZSUFFUeEhDWWJBRFkxZnNkMDhUMUF5eUVla29V?=
 =?utf-8?B?NHVRNHN1dUI4OUhpblpSeXRZZW1zbER6TjVmcG51V2lyTTNIbkdqbmtCcUVH?=
 =?utf-8?B?NlFJcVRaOXpRZGFhWnZ5SkRjako2eUcrSmkyck1MTDRHdEttalFjdTVzVnBy?=
 =?utf-8?B?VG0vc0p4eThGRlhBeExvVFlyMUtMOWcrOGEyU0w5UTRNR3JwbU9kczZaZ2gv?=
 =?utf-8?B?RUUwbGJOaVEyNE9uU3M5NlFqeWp2bW9BZ2E1em4vTXhGZllBZUxRUmZZSldC?=
 =?utf-8?B?OGdLQ0R3YUlIK1JyQys4blg1amtiU05NNC8vbnNYdlp0N052VW9NeHZ5dDNr?=
 =?utf-8?B?bi9QZXVLTmJUa20wekJHRWllV2ROL0xEZzUrQllBeWlqRmFKNFBKa2U0SHZJ?=
 =?utf-8?B?MVhNRUl1em5KdllaRk1Zczg4TDRGaHhUSEhia3ZJeEtmWWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDZMMms0MDZzMjJWQndmbnJtNzluMG9YMzJKcmdDcmF0V0IyVGFNRDlEQ3dN?=
 =?utf-8?B?czFoWHI5c25rYlU3TUs0YmFnYkMwS3V0YXdPdnNOczVHTG5SNlFKYno5anpQ?=
 =?utf-8?B?VVEvUVBCdkhJWTg5K3dTUjIxWEQvdG1mQWRWaG9UeEFrbUVNTVdpenl6c3ZB?=
 =?utf-8?B?SWNlWHRHUEUzK3lUWHBOMWlCNllocEN4WmVTZFVxcDFDaytnZXkySVBwazlH?=
 =?utf-8?B?TFFMbmtwR1h4TEtsUkVmNFNhN0Q5cmxrWEZvSFVRUEM2NHhQZzkrYWFQUGNG?=
 =?utf-8?B?QTdNZ0d6UWlqYWxVWkd5L3NERmVlZ3ppRHBOa2xqcUx3cDNSUUdsYTAxVTlh?=
 =?utf-8?B?eHlWalZONVFxUThDcmpPWVp3dEtDYVNmSFJWYW1jUFJOcDhCYXFnKzZSNnlZ?=
 =?utf-8?B?Wm45WmxCb0xlUDBZWG0vU3dCQ3lQYk9UWU8rTEpsSlo5d2diZ1pHaUo1bmFN?=
 =?utf-8?B?c2s3KzRiSmZITk1xUEM5OWhnRU5SUDNFdHpCeFJCZ3ZFUHhlSmxDWStFaDlv?=
 =?utf-8?B?T2JqbFJaek84L3BUOXNLeGw3YlBuWjZVbVllUG9Wdm5wQkc0OEZya2tFNlAy?=
 =?utf-8?B?YytXUWR1OVdpQzVITWduZGJ0a1dHRkh5MjRnd1VLMFB1eXV1TGRMUXlVUjFF?=
 =?utf-8?B?cDFMWXhXSUMwOXNWS0pXQlZDWVppY01wcTFKUm1tS2tXWkQ5RExVVUdsQnNB?=
 =?utf-8?B?OUJQNk9ydWlPRzk0NDBCUm1ualo4UnlhWk9BamZrcVBheUhVMlJRaGFEd091?=
 =?utf-8?B?MDBhSUZxaGN6QitiMGhCQ3g2MWJaUGpTT0pqeXIyZVltekNhSG5TWFUwQUlO?=
 =?utf-8?B?RjFNYlg1RXYrOFBlQUJqM1hneElWdjR5czhSUWdYQURwa056WEtZbng0TnRK?=
 =?utf-8?B?K1d1SGI5UW9qa0V4bmkyTTk4d2VabGw4KzlnQWNJbnFiMFdHTzhmaCtmSlRn?=
 =?utf-8?B?VlNEU3dHTExta0hkNW9ZZzNrOXdmVXpQNks2eDVPU3JVQTVOSlY4b0RsRmEx?=
 =?utf-8?B?SXIxblcxenErS3dZZVFjNVQ3cnExRkdzdmtpNXllN01zQS9YQkNnL0JRbEN4?=
 =?utf-8?B?L29OSEtOSmZwZTNjb09jQVBIaEhLRmtHdHNzSmRBcGp2WVdGMkxjUjZIeHM2?=
 =?utf-8?B?MzNtNVlYODRQMWVtUGhGOXMwTTN4QytOQ0RhSHNrVmZEMTc4eHBWVFVQOFNL?=
 =?utf-8?B?a0NjaWVNWjUyR0pPMW8wY2h5ck94Yi80R1EyMG1IOG5rY1dKWW8ycENXK3hn?=
 =?utf-8?B?TjNIRFVuazAydUpQZ2FvdldCNGo5UVJQd25GVmloTGlyOW1zMkhCMzlJZGJE?=
 =?utf-8?B?aVNvQ2lWeDFLQU9KRkwyVWhCQ2dHaTN2OHZOUXJEMmVWa1pGbUs5dnF2MU4v?=
 =?utf-8?B?RDVyRVdkTGp0dXI0cTlOa3ZjZmpCNFdIVjRlVlZOcmhyL2VFZStEK1g1VVF3?=
 =?utf-8?B?TFVDWEVhR2dMYmZwWGlNMm9sRmRBUE45Z0RiSDFnMmwySkFqVFpUZ1E2bE9F?=
 =?utf-8?B?NnhvS1QxTW1MTTltaUl5UUZvVjVnd1lST1RRMi9TYUZyS2RmRnpLanZiWUJS?=
 =?utf-8?B?TUVNMHV5aTZiMVJpZ3JpSFNpMVA5T0QyZnVpV1RTS05sbGNpcmFCWFFnWGwv?=
 =?utf-8?B?eFdLUHNQZm43VjlFOXpCN0lFWjlPNzBQbEY5UjFUR2h1MFZoY2h5TVh6QVVZ?=
 =?utf-8?B?UUJZZHVWalhyUWEybzVXdHZZcVI3M0RsUXorVnNDZ1M4UjlKaHNRV2F1dGpD?=
 =?utf-8?B?M1RONVc4Qy9CNVM5VFE4Y2FpWEFIS3BkM2RFMXVQTnJiVnViOEZlaGdFMW9K?=
 =?utf-8?B?aW5DMUJHdmNzcTU4cllkc1gwUzhHL2o1cGdpODNIN1J3ZzFTbWQzdFVQK3dN?=
 =?utf-8?B?SERPdFRpTEV4ZFRwZHhHbFJNd3E3YS91emNvdUhKVlZLZ3Mzd0VzTVluZHgx?=
 =?utf-8?B?V3dkYnRzVWN4K1BFaitsUmlXMmlXZEQ3MkV1bkxkYm80cGw1WVdCVDQxWVZ1?=
 =?utf-8?B?SXJBZU5tNWR6NHRFbXNVbjFubFN2MVFzRG9zT01TTSs3TmhBdm80aGZOWmpt?=
 =?utf-8?B?aGtMQTdMZkc5T2NuRDhPNmlDVW5FSjNkNks1Y1AzWjVZeE5PbVlpMU5INU5Y?=
 =?utf-8?Q?YVBp5r+XVY7CMmq37ksooXw9A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b11e15c-b816-40be-0c75-08de0bf77747
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 14:31:02.0947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nIWAjdVGT/ywbGpnRxgbM5ivbgxkSL80y2UJGSahyogekTOuyhinKEANaNQ0ySZG4uw1QF7QjCzmf+TOAWysA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288
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

On 10/15/25 9:19 AM, Harry Wentland wrote:
> 
> 
> On 2025-10-14 17:38, Mario Limonciello wrote:
>>
>>
>> On 10/14/2025 4:27 PM, Alex Deucher wrote:
>>> On Tue, Oct 14, 2025 at 3:46 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> [Why]
>>>> If userspace hasn't frozen user processes (like systemd does with
>>>> user.slice) then an aborted hibernate could give control back to
>>>> userspace before display hardware is resumed.  IoW an atomic commit could
>>>> be done while the hardware is in D3, which could hang a system.
>>>
>>> Is there any way to prevent this altogether?
>>
>> The obvious way is that userspace should be freezing user processes. That's what systemd does.
>>
>>> This seems like a recipe
>>> for trouble for any driver.
>>
>> If we want to uplevel this kind of check I think we would need some helper to report hardware status into drm and drm would have to call that.
>>
>> Most distros use systemd, and this only happened in an aborted hibernate.  I guess I'd like to see how much this warning actually comes up before deciding if all that plumbing is worth it.
> 
> I was briefly thinking about a generic solution as well and don't
> think it's worth it at this point. This is mostly about internal
> driver/HW state.
> 
> Harry

FWIW IGT testing seems to have thrown up some problems with this which 
didn't show up in my unit testing.

[  471.261018]  ? drm_atomic_helper_resume+0x2b/0x150 [drm_kms_helper]
[  471.261031]  ? dm_resume+0x459/0x8f0 [amdgpu]
[  471.261396]  ? amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
[  471.261635]  ? dpm_run_callback+0x9c/0x200
[  471.261640]  ? device_resume+0x1b4/0x2b0
[  471.261645]  drm_atomic_check_only+0x5d9/0x9e0 [drm]
[  471.261672]  drm_atomic_commit+0x6d/0xe0 [drm]
[  471.261697]  ? __pfx___drm_printfn_info+0x10/0x10 [drm]
[  471.261729]  drm_atomic_helper_commit_duplicated_state+0xcd/0xe0 
[drm_kms_helper]
[  471.261739]  drm_atomic_helper_resume+0x93/0x150 [drm_kms_helper]
[  471.261751]  dm_resume+0x459/0x8f0 [amdgpu]
[  471.262119]  ? preempt_count_add+0x7b/0xc0
[  471.262125]  amdgpu_ip_block_resume+0x27/0x70 [amdgpu]
[  471.262363]  amdgpu_device_ip_resume_phase3+0x54/0x80 [amdgpu]
[  471.262598]  amdgpu_device_resume+0x188/0x3b0 [amdgpu]
[  471.262842]  amdgpu_pmops_resume+0x4c/0x90 [amdgpu]
[  471.263078]  pci_pm_resume+0x6b/0x100

The issue appears to me to be that ip_block->status.hw isn't set again 
until the end of amdgpu_ip_block_resume().

I am tempted to move it before the call to 
ip_block->version->funcs->resume().

Thoughts?

> 
>>>
>>> Alex
>>>
>>>>
>>>> [How]
>>>> Add a check whether the IP block hardware is ready to the atomic check
>>>> handler and return a failure. Userspace shouldn't do an atomic commit if
>>>> the atomic check fails.
>>>>
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> Cc: Harry Wentland <harry.wentland@amd.com>
>>>> v2:
>>>>    * Return -EBUSY instead (Harry)
>>>> ---
>>>>    drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
>>>>    1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 6446ec6c21d4..f5cd9982af99 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -12010,6 +12010,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>>>>
>>>>           trace_amdgpu_dm_atomic_check_begin(state);
>>>>
>>>> +       if (WARN_ON(unlikely(!amdgpu_device_ip_is_hw(adev, AMD_IP_BLOCK_TYPE_DCE)))) {
>>>> +               ret = -EBUSY;
>>>> +               goto fail;
>>>> +       }
>>>> +
>>>>           ret = drm_atomic_helper_check_modeset(dev, state);
>>>>           if (ret) {
>>>>                   drm_dbg_atomic(dev, "drm_atomic_helper_check_modeset() failed\n");
>>>> -- 
>>>> 2.49.0
>>>>
>>
> 

