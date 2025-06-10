Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABD0C5B543
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 08:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 250FD10E492;
	Tue, 10 Jun 2025 08:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hwuXLY2Y";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1825E10E496
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 08:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a54trxRuKqU72ZR/uGAabxMe4WTVZ9t+hcgkzogQGE7XrCfM6q8/zon3AIP860Tdo/xL6C0Q6j58VFpw80X8nUgmErIkLZDOlWarvH9R0/wXU3zck9CTV6H4hMQ1n0AhgfH2gtVRd+Y9JH3EgftWkG+1LUSecneQFaeJkc7CJnv6iZd/lnVEpl/kjc5vhvc42r9CHxLfQY+G/hodc9qh7WGXo3rVtJ5O5Lev1D0yQt+DDH66cgnkA80xYOCYLdeeo7HSc7HUoqpx/3x/SUXSiAmGytP+0d6Ynps2jEG47QYD5zCxQHbdgp9WjGYPm1v/phm+0smD/phC/qYD/mFepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2e5w/U6t0Fr9RW+/C5vRQyfBfr3h1t2mEJ67OXwTuU=;
 b=GmY+TYhs4lqgnOr84cHrBk5hHO5hFgZVM5TObwgbN/CGsc+MVuNzpFVs6yZirQmM4XWAKc6dQUZgIRln/IcRL6z3e6TB9YmYTqL5WZLpiwZAFY47IdC4o4YCxiJoDZ/49Ko8zO2N2soGL8AEHhIcRKZkNmCAxXnE3um5ChOiege77pKfP9nMMb/qxWVISzEdNfVIBV1QKngxT0gvOK6qUjWModjd9BWBFTIUl3I76ew0AryLmxViGinkHrkYkr+OqKjvq8Q7qvJGaM97MqFrHiw40S/yBSo0ggM2ZUg5VdBjQQHegkt+QyNdDwhApcSyGCDubJwwSx5DAnOXyXJO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2e5w/U6t0Fr9RW+/C5vRQyfBfr3h1t2mEJ67OXwTuU=;
 b=hwuXLY2Y/fUgFRbLb7gy/iTb1epqOGSFJG2WI3LCIhQkU3vFMi09uJjl3+nIpS/cwlamRO9R1Z4rsYCd3TgoWsXg5z+ukcvUmgWazLo8o/D1ceI8MRInjJTpC6FWOC8gEilNCo7/OypaaVAdGQm/sN67L2JhTXmqRYntwL9xKfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 08:23:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 10 Jun 2025
 08:23:52 +0000
Message-ID: <4ed443e7-6c7c-4dfe-8fe5-b193b169e046@amd.com>
Date: Tue, 10 Jun 2025 10:23:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/29] drm/amdgpu: switch job hw_fence to amdgpu_fence
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-6-alexander.deucher@amd.com>
 <ac6a8a10-fbee-445b-8031-8b5c42f02695@amd.com>
 <CADnq5_PpRemT+dkzBegFWDE7TQTCr-x0NEEys99MDGv_X2KOsA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_PpRemT+dkzBegFWDE7TQTCr-x0NEEys99MDGv_X2KOsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 005b0cf1-77e8-446f-7a0a-08dda7f82218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckxkaTc1SG15NU5MZW83S2RIT0VrTUtSMTdsLzFEL0w2M3I0UXV5cHN3eVdE?=
 =?utf-8?B?WXR1RC9VWDZLYWpVUFhvQ3FTMC9tcjluREsyckk2ekxpQ3NnQWFrYWQwcGl2?=
 =?utf-8?B?QnRiM05wVis5RVN3UURlWlpTK3VEOG9EL0t5MmEydUpKbFVWbDAwUll1dE83?=
 =?utf-8?B?cVl2RG92MkNDbGJobXgrbXlkZVlGbDdoUFIwR3BaRndFK2Q5TE9FOUg1S21n?=
 =?utf-8?B?aHNhcnAvbFhjQ2MxNnJFNGlrMmc1YlUybUt0WFgrZ0RzZGd5ckVNMnRLK3NQ?=
 =?utf-8?B?bHY0aHBaUURhbUFHS1I0MTFkQjY0Zm91bFVSc0RwQlRRbGVYcUdzTjFBM3BJ?=
 =?utf-8?B?bVJ3VkVKRytkV0xQQ3J5N3AvcU4xeXVmRnhTMVJtTWtRQlR4STFNR1FkZzBI?=
 =?utf-8?B?cjVTRSs1S09yZWdsY05BelhYbDFVdWVqdzgrTzJzeFJDWmM4ZWlIbjg2M2dY?=
 =?utf-8?B?S0g0V2cvM2pXTmpPYko4aFR0ODc0S0VCWDVoUE9teCszbG4zSlJ5VEREWXdl?=
 =?utf-8?B?a3g4dkNGVXRvTTg0RzBpRmExUzNwZU5MWi8wWVVmQ0J2UHc4dHFnaXRwZWI5?=
 =?utf-8?B?M2gxalBiOWJNeG56Qmx3aXBnZVdabDV0Yjd2SDF2WHhyM0RqL0ViNTQ3dUJQ?=
 =?utf-8?B?RHY1RkJja3VlWHBRNFROY3IyMmlaYzE5WEhwTjkwOHdiSGhCWnFRQ04weUxk?=
 =?utf-8?B?U1gwbjVsL0dKL2VNb1p3YU5teEV6d1E1ZVhjL2xVL0lvSE96UUtYNGRMVmtL?=
 =?utf-8?B?Qmc5aFYxNjYwUEpwQTQrUUx1cy8yNHpZQWtuZC90d3Q0NU5TODN3N2h2S1FN?=
 =?utf-8?B?RUxSbkV2TEpaQVdicDNHdGtKY2RKU1doM3FLWXU2Q0N4QWN4d25QNndsY3Fa?=
 =?utf-8?B?elNzMC9VcmRzaHhGL1R2WE11ZVpldzFiK2tWZDZIUTNCSHpPb0tqd3Y2alM5?=
 =?utf-8?B?ZmFsNy9MakNNT0IyNlBPdlZJS1dhWnlvNEdTMVZKRkNlbHYzNlk4RWkzMGxK?=
 =?utf-8?B?bSthWkZZR3NZY0RnMHh4QVpIODBiaDZMSlUrRUpYUURNTG5zSkNqSlM3YVJX?=
 =?utf-8?B?bm5TZHV4UnIyNExqekF4OXJXRzJ1ZHFQT3poWmp5RzRjNHRkRXp2b2paYlYr?=
 =?utf-8?B?aGRsQjFIZUtVZVlPVStrZmM5Ui9ob2s3MndUZHQrYXM5SkFsOHp1dFZWWlk4?=
 =?utf-8?B?eGdLd1lweGVjblpnQThpMnpCOGhLVkZkT1RoM1F1b3N1TkM2eVlkMHJBOE9z?=
 =?utf-8?B?TklwSW1jSmtZcXI1SXA2aGZUaVRzTlV1bkNKT1R2VDN4VUZEYm9ubm9oMnJE?=
 =?utf-8?B?VTdTTVVMZi8zY1BWVzVSMFdvM1J4WlIxRkEwaE1BRlc4b1NZekRFM3JNSUhM?=
 =?utf-8?B?OWpaOEg1YWorMmhoci9TRy9BMk5CMnNvQXlZUmZ3SERXcG1KSGJRdEsydkdn?=
 =?utf-8?B?Y0s1dUd0Nzkzc3ZKbkl1WVdtTmNuZEh1dG12d0FrWnpaQ3czVGtLZTJOTEpn?=
 =?utf-8?B?LzdOZERvRTRNTmo3UGliUk93L2FTWHo1ZVJqbWtlTWw5TnFaN0VKVDFCMHJX?=
 =?utf-8?B?TFB4MHljdituQnBybHlOTmF1NnBMZHdrZmVyOU9qQmhlNzZyTDdNaUpuVzZ0?=
 =?utf-8?B?WEZIU3NwT1hPa1QxVmMrdVQ0Z0orUGtRcDZESm91d3k2aVU3eHhycEkzYzNW?=
 =?utf-8?B?WVBqNXdTUUo4emNSdUFsK3FkZEUxWEhWTC9mYWtSbjVaYksvdUhQS3k3N2Jo?=
 =?utf-8?B?dTNTRTR2YTFwRTN4cE85TlEzaldoZ2RIT1VNWlYxQk1yekdNamNoZjRIQmtw?=
 =?utf-8?B?eGlXRTNXYm5XOUlGa1JTWmVWZUtLSk5tbnRIeEZOR1gwN2hZczR6U05lV3hK?=
 =?utf-8?B?cXBZbzNIcTRiQkg1VkNFVVlLNlF6c0hid0RXdmIvc3kyTXpyU0p4SmdCWTNv?=
 =?utf-8?Q?zBjWatrPeAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRBOXhoN0ZoRnBMVGcxZG56QzF4UjAvUndIVzVBeDdHSXVkRk5rM1JJWW5V?=
 =?utf-8?B?Y0hxR0syUFJ3RWtRVGpuY2tDSFNDSUM3OCtMalpGY2w1U3VseDVnSDl6ZGhI?=
 =?utf-8?B?V29RRjBwME5WUk5oNnJMOHFoblUvcXBtZ1NzaTNaUGJJaFZjTy80VFRHd3JP?=
 =?utf-8?B?aGN5d1RnNDRBTS9JK083eklQaUduMWZwVmIyaGxaWkpLeHc1QW1MVFE4UktX?=
 =?utf-8?B?UHlMOXg4TFA0K3N6UUV2dmVKYUVPNEpSMHFUTk1zM0xMVHg0Sk1UNnNtYjNu?=
 =?utf-8?B?c3VxYjh4RWVxRFVhMm5hRDdCUktCd2lKRkJsUmhLYktpbEdGVlNYZGtQMlUy?=
 =?utf-8?B?VTNxT1pMZ09lLzFmUm56d0tTQWg2alZDRlF4NmVmNlpzcG5HTUN3Y2N1MUl6?=
 =?utf-8?B?cUtQWW1ScGR4eCttMEU3TEtKOStEMDFxTkl6czVhSnk1cGkzZ3BrbUFGMjRN?=
 =?utf-8?B?Slh2QVE0S0hBS1dOSTdnSmdrN1F5UG0yaXlUTGZhUktHZnk1SUhrZDk1bitT?=
 =?utf-8?B?U0F5dStsNGlWZXc3bVRWQWx0U1NVNVNqVUhwcUMrZFNMRENpSmJRcWlvb09l?=
 =?utf-8?B?OUU0ZE8xaXduK2U3RkVzN1Zib1d0NXc0YklKalAwUkUxZldsUmtmaW1Pampo?=
 =?utf-8?B?RjFoYUUzc1Y0ZDZDWm5zc0w3cEZkdUhvMDB5VFRLNEpyWlZqZnYzNzFiQ0Ni?=
 =?utf-8?B?QW1aUUlnbU05S2liNlgzRklYL1gwVDVkL0l5UzFUVGJXc0lXUGQvUFArZFpn?=
 =?utf-8?B?bUpTU2tjalVhOWpWUXZxVXhrVWh2OWgzR0RDNHhJdFFQRzBTb3MxMmZTdDEz?=
 =?utf-8?B?azk1c2ZLTUlOVyszbWUwY2MzWnIydTVIRlZPUEdydDJ2ZDU2V2tmRHBhR0Y2?=
 =?utf-8?B?TUxVYTV4Ni8xWmdYd0FFVU9lQ2E1bm5GdElsQjRWanErQ0J0ejNTL1JFSGpW?=
 =?utf-8?B?cjBHZEcxdG14UnM0eG53OXNtQk12Q05FTlhya3Y3R3hyZmViYVZjaTVKbTFP?=
 =?utf-8?B?d2VqVjFDR1NMSFRYVTA5cjhzOXRyYkpxRXlJNWViTlBpYUoxZ1BxeHhpWSt2?=
 =?utf-8?B?V1ZML21Ya3pKN0ZqRlhLaXhEdkZsR1hLODErWS9ua2RyMGdzeUlzb2htN1No?=
 =?utf-8?B?SSttRStUT1VNcDdLMGJhczFEZmZURC8zUmVrWjNBWXY4cHZyWDR6OW1CYTJa?=
 =?utf-8?B?TndxaHBUbjNpNnE0MVFOb0RmdnhjZC9hU0VQNWFtdUMycE1NenVQWDZjSEVo?=
 =?utf-8?B?TS9pUXg1RUErSzFsNGtpZEJuREk2OG5MbmVGZG43c3ZPMGVmTk9sKzNndnY4?=
 =?utf-8?B?dUI2Z05SckU2WTZPSVVYMkZ5NVNiSHF3U2R2NlVpNHJYUFgvejhBU1ZiTVV0?=
 =?utf-8?B?T0tqYjVGYkhlMFlhZFUzZ1dOOXB1b1IwdEthQWdzZzRvRVdneC9rZGJoSERM?=
 =?utf-8?B?UUdhbHQvTzAxdzRGYVA3N1R6KzhKc1hWSVp4bVdXRWcrbXdwcFBuNER3SmRO?=
 =?utf-8?B?RWRkWERxUmhqR0pEWEU0aW1PYmVmQlRqM1RTUk43ajFydTZsc3AwS3YwUUZT?=
 =?utf-8?B?WjAzNC9pRVhNTkxFeUZUMVRGRElnZ2JLV2VWSXlHSWNlOWQ5c2dCcnJGemJI?=
 =?utf-8?B?M3d3NFh2Mm1sSkpBeUtTL3hZaGFPZ05CVlNhNzVUUWMyU2JIMWhQUzNTbGxJ?=
 =?utf-8?B?T0h2R2pETTN4eFgwOGtWN1NMU2FDTnRmU1RyM1dYYzBoOEVLZk45OENCV2oz?=
 =?utf-8?B?YWxuaVVyUkVqV0ZmOGJMSEVWR3JYdis4Q01aZTRUdFVKanA3MFJRd2JScVEw?=
 =?utf-8?B?WTBzdDFzTjVmY2ZxZWd3VGxOUWM4Z0pzYnl0RUN0S1UrWWQ2L2Q0V29pMzdQ?=
 =?utf-8?B?MUowNUo3MXZmMmhGZDJkZmQ1LzJFNWV5cmpaRGJJRU0rRXVJTkFVN0ZoMXNx?=
 =?utf-8?B?dGgvNUJGbkJLRmd0SEp1dFJuSXBwTll4OWtneDA0dThBckx6OHo5TkxiVzZO?=
 =?utf-8?B?YmZWTm13eGhBNUYyc3c5ZC80L2lVNDB6cUNpKzdwc2lRb0dZaGxCVDZ5S3Nl?=
 =?utf-8?B?anQ0VE03MFJzNCt3aktWT0c0djRJeksrZy8va3M0VDk4cXd4cTlWYk9FQ3dr?=
 =?utf-8?Q?FnL8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005b0cf1-77e8-446f-7a0a-08dda7f82218
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:23:52.4545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2msnyOfHjn/NJKXpC8Oh7u/YHXZrMVPAUX1CIE3w/8V9qVPQmkhrXEyvzLjfu0aN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884
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

On 6/6/25 18:08, Alex Deucher wrote:
> On Fri, Jun 6, 2025 at 7:39 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 6/6/25 08:43, Alex Deucher wrote:
>>> Use the amdgpu fence container so we can store additional
>>> data in the fence.
>>>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 30 +++++----------------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 12 ++++-----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    | 16 +++++++++++
>>>  6 files changed, 32 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 8e626f50b362e..f81608330a3d0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1902,7 +1902,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>>>                       continue;
>>>               }
>>>               job = to_amdgpu_job(s_job);
>>> -             if (preempted && (&job->hw_fence) == fence)
>>> +             if (preempted && (&job->hw_fence.base) == fence)
>>>                       /* mark the job as preempted */
>>>                       job->preemption_status |= AMDGPU_IB_PREEMPTED;
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index ea565651f7459..8298e95e4543e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -6375,7 +6375,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>>        *
>>>        * job->base holds a reference to parent fence
>>>        */
>>> -     if (job && dma_fence_is_signaled(&job->hw_fence)) {
>>> +     if (job && dma_fence_is_signaled(&job->hw_fence.base)) {
>>>               job_signaled = true;
>>>               dev_info(adev->dev, "Guilty job already signaled, skipping HW reset");
>>>               goto skip_hw_reset;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 2f24a6aa13bf6..569e0e5373927 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -41,22 +41,6 @@
>>>  #include "amdgpu_trace.h"
>>>  #include "amdgpu_reset.h"
>>>
>>> -/*
>>> - * Fences mark an event in the GPUs pipeline and are used
>>> - * for GPU/CPU synchronization.  When the fence is written,
>>> - * it is expected that all buffers associated with that fence
>>> - * are no longer in use by the associated ring on the GPU and
>>> - * that the relevant GPU caches have been flushed.
>>> - */
>>> -
>>> -struct amdgpu_fence {
>>> -     struct dma_fence base;
>>> -
>>> -     /* RB, DMA, etc. */
>>> -     struct amdgpu_ring              *ring;
>>> -     ktime_t                         start_timestamp;
>>> -};
>>> -
>>
>> Oh, that handling here is completely broken.
>>
>> The MCBP muxer overwrites fields in the job because of this ^^.
>>
>> I think that patch needs to be a bug fix we even backport.
> 
> What is broken in the muxer code?

See amdgpu_fence_emit(), the code casts the fence to an amdgpu_fence and assigns start_time.

But the fence pointer isn't an amdgpu_fence at all, that is just a dma_fence embedded into an job object!

We overwrite the gang submit pointer and the flags with that. The only thing preventing us from crashing is that those values are never used again after emitting the fence.

Regards,
Christian.


> 
> Alex
> 
>>
>> Regards,
>> CFhristian.
>>
>>>  static struct kmem_cache *amdgpu_fence_slab;
>>>
>>>  int amdgpu_fence_slab_init(void)
>>> @@ -151,12 +135,12 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amd
>>>               am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
>>>               if (am_fence == NULL)
>>>                       return -ENOMEM;
>>> -             fence = &am_fence->base;
>>> -             am_fence->ring = ring;
>>>       } else {
>>>               /* take use of job-embedded fence */
>>> -             fence = &job->hw_fence;
>>> +             am_fence = &job->hw_fence;
>>>       }
>>> +     fence = &am_fence->base;
>>> +     am_fence->ring = ring;
>>>
>>>       seq = ++ring->fence_drv.sync_seq;
>>>       if (job && job->job_run_counter) {
>>> @@ -718,7 +702,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>>>                        * it right here or we won't be able to track them in fence_drv
>>>                        * and they will remain unsignaled during sa_bo free.
>>>                        */
>>> -                     job = container_of(old, struct amdgpu_job, hw_fence);
>>> +                     job = container_of(old, struct amdgpu_job, hw_fence.base);
>>>                       if (!job->base.s_fence && !dma_fence_is_signaled(old))
>>>                               dma_fence_signal(old);
>>>                       RCU_INIT_POINTER(*ptr, NULL);
>>> @@ -780,7 +764,7 @@ static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>>
>>>  static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>>>  {
>>> -     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
>>> +     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>>
>>>       return (const char *)to_amdgpu_ring(job->base.sched)->name;
>>>  }
>>> @@ -810,7 +794,7 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>>   */
>>>  static bool amdgpu_job_fence_enable_signaling(struct dma_fence *f)
>>>  {
>>> -     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
>>> +     struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence.base);
>>>
>>>       if (!timer_pending(&to_amdgpu_ring(job->base.sched)->fence_drv.fallback_timer))
>>>               amdgpu_fence_schedule_fallback(to_amdgpu_ring(job->base.sched));
>>> @@ -845,7 +829,7 @@ static void amdgpu_job_fence_free(struct rcu_head *rcu)
>>>       struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
>>>
>>>       /* free job if fence has a parent job */
>>> -     kfree(container_of(f, struct amdgpu_job, hw_fence));
>>> +     kfree(container_of(f, struct amdgpu_job, hw_fence.base));
>>>  }
>>>
>>>  /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index acb21fc8b3ce5..ddb9d3269357c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -272,8 +272,8 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>>>       /* Check if any fences where initialized */
>>>       if (job->base.s_fence && job->base.s_fence->finished.ops)
>>>               f = &job->base.s_fence->finished;
>>> -     else if (job->hw_fence.ops)
>>> -             f = &job->hw_fence;
>>> +     else if (job->hw_fence.base.ops)
>>> +             f = &job->hw_fence.base;
>>>       else
>>>               f = NULL;
>>>
>>> @@ -290,10 +290,10 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>>>       amdgpu_sync_free(&job->explicit_sync);
>>>
>>>       /* only put the hw fence if has embedded fence */
>>> -     if (!job->hw_fence.ops)
>>> +     if (!job->hw_fence.base.ops)
>>>               kfree(job);
>>>       else
>>> -             dma_fence_put(&job->hw_fence);
>>> +             dma_fence_put(&job->hw_fence.base);
>>>  }
>>>
>>>  void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
>>> @@ -322,10 +322,10 @@ void amdgpu_job_free(struct amdgpu_job *job)
>>>       if (job->gang_submit != &job->base.s_fence->scheduled)
>>>               dma_fence_put(job->gang_submit);
>>>
>>> -     if (!job->hw_fence.ops)
>>> +     if (!job->hw_fence.base.ops)
>>>               kfree(job);
>>>       else
>>> -             dma_fence_put(&job->hw_fence);
>>> +             dma_fence_put(&job->hw_fence.base);
>>>  }
>>>
>>>  struct dma_fence *amdgpu_job_submit(struct amdgpu_job *job)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> index f2c049129661f..931fed8892cc1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
>>> @@ -48,7 +48,7 @@ struct amdgpu_job {
>>>       struct drm_sched_job    base;
>>>       struct amdgpu_vm        *vm;
>>>       struct amdgpu_sync      explicit_sync;
>>> -     struct dma_fence        hw_fence;
>>> +     struct amdgpu_fence     hw_fence;
>>>       struct dma_fence        *gang_submit;
>>>       uint32_t                preamble_status;
>>>       uint32_t                preemption_status;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index b95b471107692..e1f25218943a4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -127,6 +127,22 @@ struct amdgpu_fence_driver {
>>>       struct dma_fence                **fences;
>>>  };
>>>
>>> +/*
>>> + * Fences mark an event in the GPUs pipeline and are used
>>> + * for GPU/CPU synchronization.  When the fence is written,
>>> + * it is expected that all buffers associated with that fence
>>> + * are no longer in use by the associated ring on the GPU and
>>> + * that the relevant GPU caches have been flushed.
>>> + */
>>> +
>>> +struct amdgpu_fence {
>>> +     struct dma_fence base;
>>> +
>>> +     /* RB, DMA, etc. */
>>> +     struct amdgpu_ring              *ring;
>>> +     ktime_t                         start_timestamp;
>>> +};
>>> +
>>>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;
>>>
>>>  void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
>>

