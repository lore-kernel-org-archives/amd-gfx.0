Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEEDEFB818
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 09:04:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8CB10E51F;
	Tue, 24 Feb 2026 09:04:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tTURnZqd";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012001.outbound.protection.outlook.com
 [40.93.195.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AD810E51F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 09:04:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ublY8oYAiZ7Z1f4my/IUj2IA9QtIUS98I11gU3Qf2a4wsVYpWxQwpLTeLrCnJcMnhWtZqbGfzGVog+xEg1KHkRZNWSQE9MiRHhBIg0s5JbsnfbFerjplzTyKxrS6RVhIZotgaL3tAH5YC5k/WBacEpSzxAGsCKzdnoqbpq9qYfvqwuOtLz5xtnS8h+kJsKTXAN+yTPBA5s7GktmFAu9uCGrMKnr4EePMZSbWfFwo3UCeQyC0sDWGPrLrd97H+MjXMxU7GTbvPSTko5SDlh/HgDUKpklJFzB4SAZa+qC8uTLpft8yHLGTwVAtGLOnwY5DkpEdlYC18aWqFMvJtsd3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHC74aULbYRZVuGulGELELOqZtmWg8hlqEIl605EbtI=;
 b=UTpQd3nL2pQy5njGVYUQsRJ67K+BQT+oULX+Z4RvwHCGH0N0szzlHm2vlnmpEu0STfbsnlaWzeFpkMYguMU7M6n89qYQ8ZtEwRUE3C+9jmoNbFL30Xx51e37kLYjJilafO7cGoNHtP/o+G7EJtooanNtV2qDx+njXJDLGFUA306B0fClSGuFdyq8EVf4IbfyXi1CJbkTxZUhJkvjyOovq5mvaDEfezgGkJBFl6/rmCt32k86gv9LdNQ2vMlejlmAJd3LzWTQIovEdigEu+KMlvBq7tqhIXYkXBaBnkeBbtXP6I7LGplkFQoKyFhgIoQ8HAuYlMLy4VlYcBZGp0uH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHC74aULbYRZVuGulGELELOqZtmWg8hlqEIl605EbtI=;
 b=tTURnZqd3qfAXZmqw2pLBXuL47bLkgNJjmY1Maud+7PYVsUWwJYdspHO5uXUuBHNCRiWLu66NDmF90ry2C+nTcdttAAPf7mp6/9y4e9CvnamcW+W5I8hIjQq8PUsXkS7ZT0wWNeDS+2R8ETS2CK/u2oz8gCL1gVXRkmm2u8BqFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 09:04:39 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 09:04:39 +0000
Message-ID: <7218e761-6148-462e-a1c4-72b356ae05c0@amd.com>
Date: Tue, 24 Feb 2026 14:34:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amdgpu: add upper bound check on user inputs
 in wait ioctl
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260224082443.4002292-1-sunil.khatri@amd.com>
 <20260224082443.4002292-4-sunil.khatri@amd.com>
 <2ae55bf1-0d01-4f1a-b8ad-42be7cf1b5ac@amd.com>
 <ed4ad63e-0e09-4cf7-b3e0-5154053dc7a1@amd.com>
 <98983ad6-fb66-483c-9640-f490ab2527ab@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <98983ad6-fb66-483c-9640-f490ab2527ab@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 42269dd0-7a0d-4239-aaaa-08de7383bd66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXhBS1IzOTVBemV5THNyRkFhbzMxZ3lZZlFnZ3ZEQVRqVGJVRFhRdGpzNW5K?=
 =?utf-8?B?UWdzaDNUZU1WQ0wvd3BJbVJmWTNBanFVaEpJa1NsQVJMZWhXNHZtRTdieFlD?=
 =?utf-8?B?Q3JsclIyR2RXd2tPS2ZicFh1ckdib0FReVIzVG5jcldYSWZEVGFGRlZDSjA3?=
 =?utf-8?B?VHl6L3B3UnJKVDRTT1dkd2kwOWpBR1J6ZjJuZGQ4cTk2ZzQ3U3d0dkkvdTZB?=
 =?utf-8?B?cmdHNmFoYndlZkh2dmVTMUtMVEhCbGVrdzgzcDhiTVluN0VDVXZVTmh5Z3hn?=
 =?utf-8?B?cXkvNGdPbTNzbkJRUHU0bDhFOWowNzh2MGtzc0xhM1M4REJ0VWJmRkVEbGpp?=
 =?utf-8?B?QWlsdUFsbmZ1RlZFamdjME9XYWZITWlFZFpwOVdQcE84bnpJTDFaQkxJczg2?=
 =?utf-8?B?dTkwbStnbzJZb3RZL2ZkR1NDR2ozaWhxRHB3ZVJlVGtQbGFia1hNOHM4a040?=
 =?utf-8?B?N2xRbFlvNG40TnpsdDRqQjdmY0F0RU01RkltZXNoOXJUZUo4UldaWnZUYkJy?=
 =?utf-8?B?K0puWkpnakNNUnRFcVFrY0o1d2x6eXRGUkZXRGhKS1paNVhUQ3JvdTVjc09o?=
 =?utf-8?B?eEZ5TTNNQUpCNVhuVDVFdkU4ckhBRWdIVkJDUFEwdDYvdGEyek9sbE5ncG90?=
 =?utf-8?B?TGpUTUlrK05vRXhyVmlSWG9EOHhKNW1pSG52KzVkMVQ5cVNqbXB5ZXBDNHIr?=
 =?utf-8?B?V0hoZ1FrN094VlNIMFZ0TnpObTBaWXNQOWxtQk5UWVJlRzlhek5DRjYyV296?=
 =?utf-8?B?R2VEeTk4UW9YNlJXcEw0M2V1Ujh0Z09vRnRWM3NWeFU0MjI0VTIwZVFNNGl3?=
 =?utf-8?B?NXVCbXBnaFZJS1N0Y3cwRjE3RHdGdktoU2EwR2hmSDA1RHVPcDNJSDdJcmxi?=
 =?utf-8?B?RC8wcDA4dTdlUGpxejh5Z0xXZlVaT0N5bDFDR3BmQmk0b3RUSWVSelVua2I3?=
 =?utf-8?B?bFdsZ0VVZzdlRnBpT0tsbUJ4V2FLZ1hPaDZRbGJ3SEMwQ3JHZkoyd2l3M0V5?=
 =?utf-8?B?MVU5N1czc3NyZUF5Zm1NNENzTVNJd0N5ZkwxR2d6aVVxSzdYdzA5VEJZRG5j?=
 =?utf-8?B?amphZXVEbmF6OE4wcXJnM2VsRlJpbis1aGtOUGg5ZTVlT1Jrb0dKZ2NnOU9x?=
 =?utf-8?B?aGJXelpmZDBVbnNkMms0WmZQUU9IMmRMYVA5WFRJR09jdmNDMDdMem1aYTFY?=
 =?utf-8?B?ajNldlNwSXBKRS9nSGhxM05PSThkdlJPRHkyREhGVVFEaVhhRFdGQVBmN2RS?=
 =?utf-8?B?R1NsUjB4TmtuUG1SUGthMDIxenBVYjVhL2VBZXhDTXR3c0cvNkJOV0hEQXlH?=
 =?utf-8?B?eDYxTEcrZG5UdzhQNWRFNEh2dnJqOG4rZDNwcHY3VmU3OVZzKzU3UVQ1b0dK?=
 =?utf-8?B?WDVmRFhKRFVrMjJjdm9qZG0vbU5zL1NOMURnMXFBemlMbmI2eWlPUzBiRG9k?=
 =?utf-8?B?LzVHcnNpVUVQN1JVSWlHa0Y2V0szbEtabVhIemJzVzB4K2Nlejdtek5vMWJi?=
 =?utf-8?B?dGxmTkh1NGVQSGZVY1RGTFlXb1phYzl6NkptWFpTWWRsUVdRS2RnUU5QOVZn?=
 =?utf-8?B?ZUNDd0JJVDZmVElJZmlsYm1PUndibEVEbkNtN2M2ZmxCTWFkU1hEWS92MnBZ?=
 =?utf-8?B?dkQ2OEtHSEFBd0M1NVdmSTZvaEVUa09EZkNUZGdRaVQwbDdQRHZhdFA1R2hW?=
 =?utf-8?B?K3ZzZU1KWnFnb3d5TGVSN1l3K05GRVV2RkdIWmhreWt6WkNWS0JyL0duc3VO?=
 =?utf-8?B?WHg0SGJYdXF1T2ZlR0NHL3BKeDZtR2NseExFK2dWakhEUnNRTWFLaVdhdzNl?=
 =?utf-8?B?WWhaRjdkME0vRktsMDFQS3Y1TlUvSUpRekhhWWdzVStyQ2VyUTJzUEcyMG1z?=
 =?utf-8?B?cU9ndWhhbk5yQjZpRnhpTmp6RVVNWHlzcmxUNkM2R1c0NStSY0RVYVBQV0l6?=
 =?utf-8?B?VEE2THJYb3A0NkdtZVVEU21WNmIzZjBRYTVYWHF4c1lETU1aRGNqN2xQclZs?=
 =?utf-8?B?VjVSb1Q1WmxadS9OdU5Kc202bXhXODB0MUdvSHZQU0krVG8xWUpxZGlUUlRG?=
 =?utf-8?B?NzNoZzMyL2RScnhPK0E2aHQ3MHhOUkg1eTZMTG9UeVRDOGwzU2FNbXdhQTZa?=
 =?utf-8?Q?73CM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d29yTDdlS1pGSGNoNUVYUGdtTEVpSkdtUkx0WWZGenBPQ1lKV0FvT2t1VE9x?=
 =?utf-8?B?RENuYW5XUmV5ZG0xajIyMlEyQ3dsY0NQRnBqcFJxYThkV0hjU0Y1aFZSS2Vu?=
 =?utf-8?B?Ui80Nmt6R2Q1Z3JnN1lESmdoUzFXNkVSREVranFtOVVYU1VVZGNlM1JZUXQ4?=
 =?utf-8?B?dnBHdmVodDQwV3FLbkdEWnQ0MzNGZmJIdzh2YzREZ0lQT3F3ZTFhK21DbU40?=
 =?utf-8?B?UTRtZE1mSFFnVVdZV3VycVkxakdLYjZSbGFUTU1PdWF4V2NxOUxZMi8wRnJ2?=
 =?utf-8?B?cjlwNCtBelh2d2ZWdy9DeXMxZ3FrYkpxZGhSbEhzZTZJdlpKa2ZoWXpDNUpG?=
 =?utf-8?B?ckdNaEovQXZnUkltQ0V1eUxOUnZuY2lSK3pVMmZNb0FPMmM3TFpheU4rcnVZ?=
 =?utf-8?B?elVGVU9ielBpa1I0QmdCNXJJMEwxRDJMSEQzNmVxU2NHVzdIMUp0NjZ4MGQz?=
 =?utf-8?B?OEI0WlNlcG5JdW5wZUpFeDlKOHg2bTg3QzkwRDJ0b3hXQ3hBcHBqR1FXdGtz?=
 =?utf-8?B?ZUt0Rk1tK0VFRzdhZEVjQW03Nmszb1hxcW1TUDZQNHVBNXcvbFJLWjlydm53?=
 =?utf-8?B?bDZFWWw3cGpPS09NZ0NKOG8waXB0Zm52U3NIWEZIQ3pVQVpUMzdIaVZsREx4?=
 =?utf-8?B?dldyaldFUFU2NzFMeTQwTENyMjNYYzZCbHBmS2g1OHlDbTVxM3NGYUEvd3Ra?=
 =?utf-8?B?ZVRDODRVbUVQS1h1ZzdlZy9tRGJhZEpPclR5ZkRyeXhuS0N5WEhLR0V1RXNj?=
 =?utf-8?B?MGFBWVNwZWliK0drTFhrSEFJbDhrdUlGL3p1NDhPbWhSaWtEdm5UbXB3Nmh3?=
 =?utf-8?B?M3JVZm9zbUNVM3JSck05U0tSUVRwalNidnU2ZVgrRzA3UmcwT0lHVkNZbmZj?=
 =?utf-8?B?NllKc24xY1NwUk81SytBd3lPUngxbUM4ZEFmV1NZQ3Q4SUFtc1c2dFI0aSts?=
 =?utf-8?B?K2lycHpEVHlFUUR0U0p6bmxlR2NtdXhrTGNGUEhzN1h0aGR0K3YwQ2M3NUdt?=
 =?utf-8?B?Ni9zZVo1dWFvZ2FSNmJCMTRwMHNhbEt5ZjhUYXhid3JBcGk0MndPQmMwR3JM?=
 =?utf-8?B?Ly9EYTV6MGtDNmpwL2p4QnlUQ1YzZUhCV2RKWjI3bXNWUHN4Z0I0UlVtUE0z?=
 =?utf-8?B?UUI0SVBuT211TUNnR2h0ODkrYkxSYkk4OFBYZkVNcENIMjliMFdLbURUcXIy?=
 =?utf-8?B?QTZ6cE96RXo2VllFTkJYVUhsYkJOSTdaQy9ZUFozdjZ5SnlaNXZNaFJZTUQr?=
 =?utf-8?B?RWk1WFFPdCt6MXp0Z0kxdlRNNXlMT2UzNEk3aTdRdGg4T3Z1MlUzY1NzbTFw?=
 =?utf-8?B?azVvRldPaWxjdS90azBvSWlsdWZuU1puZW5lbnlFblRFOEJiSzZIcFNiUDA3?=
 =?utf-8?B?anNnT1pQcmdLVkhoWVprendUTG5kUzRhRHo0RDh2cG1MMnY5SkhDWTRZQUlV?=
 =?utf-8?B?SUtlblFiSDBOb2d0N2tnc0VMNmFsckdVQW1ReTYvNGpMSVJtbkhjckpIYlpV?=
 =?utf-8?B?TEpRYkxCL3dhSmxlWWtSbXVjbWhNMllNREVlZjVGdW9YcXhJdnJRZE9ONDJC?=
 =?utf-8?B?Z1ZBbWRPcUdrcDFIT0xrNGFadW5kV29VK3JCcVo3cTExMklyMExmd2JRcW82?=
 =?utf-8?B?NHU2aXlhS0hzWG5odFJVMmM4WjBtY3J2TmZXVGhiZS9xdkpkTU1LUXZ1T2gv?=
 =?utf-8?B?V3J1NEgreEhJWlh5Q1pzOUJid0RjYjRLSDZsZVZYRnZuck9CZzlsKzJna2VM?=
 =?utf-8?B?MWExdEpIbndGckpBd3U5NW55QlpNazcwTW1oY21VdGQ5K0szcGtVZzh2TG4z?=
 =?utf-8?B?SWZCWkVhZE0vcjZoSkhJV2RHVW5QakVLUUVUODQ3SDh3OU4yZUluK1J0aUE3?=
 =?utf-8?B?alJMZllaWFFqYmFyS29FRDgrYzFGNjRVQVhjSmlsRVpFY3VaODZucGdRTGZT?=
 =?utf-8?B?cFRSUDBicEJ2UXl6YzBCcHY2dDdIQjQzMlpxM0hQNjZEZmZ1WEI2bTRQVVZS?=
 =?utf-8?B?RVdKL2Y2NitmNWlCcGpmNUZWYndRcXk5Y01mNXcyajJkU01RSU43QVVsWjJF?=
 =?utf-8?B?UFNNRitoV1NYWUFNTUUxUGdSUll5VDlweCtMQUtFTVVSclhPNVlwcmdQQWdV?=
 =?utf-8?B?c0g3RzhZQ1ZqNzhPYVp3RFRMcEtuU2JaNWwwZSt5elh3MjJNaVNEeU9SaTJV?=
 =?utf-8?B?SmxYcGFUdXpKVHBJd0lHQitNOThmeE43cjBsQStySU91amdJbjJDOGgxcEpv?=
 =?utf-8?B?YTNYNkxBekdPRXFvYmF2VGxobUtaeW9zTjVhYnRlZ0hFSzNGdUxWQlJ4b2FM?=
 =?utf-8?B?Y2wvc09RbFlDaHg1L3VEQUJEUlIwOVJUSWloclp3aTRMdlNXQ21GZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42269dd0-7a0d-4239-aaaa-08de7383bd66
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 09:04:39.1935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0+SBvKpl6EvRZ6QH4MTVZV19ccDLWZCGzGjxqtHOouUMNfUk+Y2o9qQbfSLOPvl9+rCmpmJkjGKKniHCqVang==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304
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


On 24-02-2026 02:26 pm, Christian König wrote:
> On 2/24/26 09:54, Khatri, Sunil wrote:
>> On 24-02-2026 02:15 pm, Christian König wrote:
>>> On 2/24/26 09:24, Sunil Khatri wrote:
>>>> Huge input values in amdgpu_userq_wait_ioctl can lead to a OOM and
>>>> could be exploited.
>>>>
>>>> So check these input value against AMDGPU_USERQ_MAX_HANDLES
>>>> which is big enough value for genuine use cases and could
>>>> potentially avoid OOM.
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 4f9386677c47..c2435ddfbd49 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -636,6 +636,13 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>   	if (!amdgpu_userq_enabled(dev))
>>>>   		return -ENOTSUPP;
>>>>   
>>>> +	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>>> +	    wait_info->num_syncobj_timeline_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>>> +	    wait_info->syncobj_timeline_points > AMDGPU_USERQ_MAX_HANDLES ||
>>> That here is wrong, syncobj_timeline_points is a 64bit VA pointer.
>> Right, but do we want to set the value to be much bigger value for this ?
> No, this is not a number but only a VA.
Ah, yes i see now thats not the count. Sorry will remove that in next 
version.
>
>>> The number of timeline points is always the same as the number of timeline syncobj handles.
>> So should i check only for num_syncobj_timeline_handles, or its ok to check for both ?
> Checking only num_syncobj_timeline_handles is sufficient, syncobj_timeline_points should not be checked.

Got it, will get that removed.

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> Regards Sunil khatri
>>
>>> Regards,
>>> Christian.
>>>
>>>> +	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
>>>> +	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
>>>> +		return -EINVAL;
>>>> +
>>>>   	num_syncobj = wait_info->num_syncobj_handles;
>>>>   	syncobj_handles = memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
>>>>   					    num_syncobj, sizeof(u32));
