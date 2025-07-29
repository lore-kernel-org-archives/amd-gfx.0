Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD1BC83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 06:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17C210E1D0;
	Tue, 29 Jul 2025 06:21:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MeOeq31v";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D99D10E5D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItSdQIAW3mOc87jFVOqSBtGzIYeK8TcVhkAQXuUONkGT8JjDixfmMjDWKyjFD13ZciKGkle2HvttCLrtip/a5ifUK3ESv73U6QJb2NfdwMnO6DHBNgrI8QY4zvLNoW65ABl1FEyHtBOQIiDoTbrDl0aqymTTc32wHAuAWk7ygbF+qK0J8WYnpLf6SRRVwFDhbX/bO8wqEs1hjK0s/8glXhFNCrK1Lp1D/NQrNb66haC4nl0BIvPYEd15fffwRss+/XzokOkBKd4IXJpJ5s2I5PEqRjceuy47NjTY0VWp9mS/oLw1Wbk7XR6zfIntdZbuv55Mo3dKbLZhHDkEVb4N8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dzPpjmcRCRNqtNdScFhxT24aUmHp8Qb4Lk9ZRWbrb0=;
 b=lGRcGbeMfhlqYDU7zu1VHzh1XrmiVbdRdr30d1KO9ETAlWiNe+u/bzC9oMhKLTdtc5uS/8MlMW5uplD8+6VpTTW6V8SEIPJMWmK20W6Py2stcq/JMTZohp6OZsmeXlREr8HSZjcfKJgitdULdBmI5YgpTkelGIwz0Gr/3hRUDFhjvj1YAaQ9zLGyfZOdc5OuFv84OJQyGdNQRGJqN8bCIlX3iBT/Jlnk+CN5TX+TDTidZC1mCS2FzpZ/5xSZm5VuZqiz5x8RAP9faLH/eJiT4H+WG8hdF19d5Zs21PV/6eFaEFk6bkPuf41hsTriCoChQxg9AIL1+Xy5KRICvHBmHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dzPpjmcRCRNqtNdScFhxT24aUmHp8Qb4Lk9ZRWbrb0=;
 b=MeOeq31vXOQA4U7gTEmHMelGH+PCyTAQEwQlcqbSJDioIzZr14zyceHMJYK59scTanG93lX87i2JJBzc/H+mWkIVq66/LjOWGSJEV1zqgkxxsJsnogo3TPm3E0aiLQQqgkrs8VYOLAB4iij4htWPlKK7b4oCU+2h4F2fqXfhgCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 06:21:55 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 06:21:55 +0000
Content-Type: multipart/alternative;
 boundary="------------0Xj2Kd8DarS9nqphK6cP9sN7"
Message-ID: <92a7a926-b99e-4b2d-b976-caefff03844b@amd.com>
Date: Tue, 29 Jul 2025 14:21:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] amdkfd: identify a secondary kfd process by its id
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
 <20250725024316.9273-9-lingshan.zhu@amd.com>
 <51264616-aca9-4b82-822e-7c8856b47629@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <51264616-aca9-4b82-822e-7c8856b47629@amd.com>
X-ClientProxiedBy: TYCP286CA0326.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::10) To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: ff21bd35-f05c-4488-0a63-08ddce6836b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0hUMmo4M2FCL1ZjeTZlQUZ4S2VMYzF3QWw1a0gwMGU2c2tYSWhJajJxYmd5?=
 =?utf-8?B?TGJWek9HSDMzVy9TR0l6MVdEN2gyeW1tenNtTkxFMGhVSDVkVGMvL3VYd2NI?=
 =?utf-8?B?b3ZkVThaUUZ2RUFYTjRGYi9rdDM4dkJMT2c3Njl0S0pRMUIzdEJwZWVHaHRD?=
 =?utf-8?B?a3VROEcrc2Fyd3MzY1ppakNETWk2MHRPcGR6Q3ZmdXN6Ymp1Q2t6OVVPL3N3?=
 =?utf-8?B?dC9XWDU2SnlwUXhkWENNMXdFTWNTVXcrQ3d1Tk1EUGliTG0wbFIyUlVKMXhx?=
 =?utf-8?B?b05jQXloeFVzaXhsZUpjQzZwSjZVSWhLRnA1V3pzdmlLM3FRN0Q3NkZNeVEw?=
 =?utf-8?B?RkFuenJKNDUvT0g0RzBGemtwL0RCMGFZN1NneENrNnVrZUF3emg2RTlFUlMx?=
 =?utf-8?B?Y0RqRFNieTdnMFlzRHYxaTFTV1VqUlJLdE5LUmtsd0F0ODNXaUJtS2RKTE84?=
 =?utf-8?B?YmZNOU1oTFVwTFBUbXFNZ1NwTlNncU80SEZCZWRlM1B3KzlGbDNadWdmU0Ni?=
 =?utf-8?B?Nm83THI2Y3Z6M0QxYjUyQ0MyN0lSZm92Unl5UFlydGNGOGFHYnZqWmY4aE92?=
 =?utf-8?B?YU1iQVZFYUZoM0tIRnpkZGZIN0I5U1NKeTJqYjhWQTVKeDN6eVlxZE9vQ2NJ?=
 =?utf-8?B?ZVlXT25LZVdpRU56N2dlQWN5SEUrb3o1eFlYODVYcWNWVHdlejBuTnArWlk3?=
 =?utf-8?B?MVkySjRKTjJNQk5vM3N2bVdxbTlPMlRLbFZLYXJaeDgyRXgxazNFZkZla1da?=
 =?utf-8?B?SFoyMWVtTTBETmF1ejNieVZXZTN0U3BwSE51d01Ld1FvMkNQd0o4dmxFQVBP?=
 =?utf-8?B?L1p0OFdsTEJESE1EUXZwd3k3cXF5V1BiUDd4YXZTdzF3a2xXS1Y1cWVqVXpx?=
 =?utf-8?B?VVd4YzQ3RHdpVzBTN2k4TVRRMWE3NXRjYUJFUFVwN0JiNS9mWGJoU1d6ckFZ?=
 =?utf-8?B?bU9RY1I5RmZ3VFRRRVBFeGFZRVJhK3NReFYyaVpHSStyZnNOSndCN1Y4cHZO?=
 =?utf-8?B?VjU0bC9TQzYwUTI4M3dRSUhVaDVLSS9oRUwrSFJIdVVnajJKcHpCQys1N3RP?=
 =?utf-8?B?NDMyLzlBeWVDd2R4ak5tMXgySDhvbGp2TFhvbWFwNkRRcE9GRmt5bCtTSFBV?=
 =?utf-8?B?Qnc0eFF4clR4VlJZUXFhdGVFOHlWcXk3QW5UTUV2K0d1ZlhtSUNTL20rZ0xr?=
 =?utf-8?B?bzBJNWRIVmR3YmhMSGFpMkIxelhTcDFHemcrVmsydnJPZUhpT0lORmI5dGRr?=
 =?utf-8?B?MHhaMTU3Q1R1dXR5SU81ZFpPTzk2ZG5NYnZKR1pCcVJVTmJxSlBwcVdyak52?=
 =?utf-8?B?WXNXUFNWQkRsYlhQMUdGSVowN1RKVWQ3OXl3WTlETVZoM0p2WE50b0RIeFhF?=
 =?utf-8?B?WC9xYXdaWklhUkx1TjhyZlZxZHJQUDhnVFdHc1VqNER0cUZPYzRlZUJaUk55?=
 =?utf-8?B?V2MrV3NlOUJLbGRYUnB4ZUdQK3VNbGlvWllrUGtsNTJSL3RHdkhIenFpVCtQ?=
 =?utf-8?B?WDV2Qzk3dGlaQzdGZ0Z2S09ENjZhMjEzeW02bmI5Lyt0b1ZWanJJZUZyRXkr?=
 =?utf-8?B?eVBsdmNQQUZrZU5RWUlPYk91UzFkYVlzRWxVZVhGeGZ5ZlRZWkExeHBRVEVv?=
 =?utf-8?B?WWk1Zy84YjB0b3FacmxlQW1IRzlLdVlUcEp3RDdQdzRBdUs0U281Tm1GZHd0?=
 =?utf-8?B?NnBXTmk2NW13S2Rzcng2djdQSEppZmVzc1hZb2I0dG1sNEJPV3FIcnlmTGRa?=
 =?utf-8?B?YWh6a1ZXc0Z4UG93ZHp6YzdidmpLZGxOU0ltREdZZ24wUUd4TGZhSWdKNWEy?=
 =?utf-8?B?MHRrK0tCM3BXc3lhV3lJSHFaL1VaYkZJY2tBM1p4d1kzV0RacFlaaUVqMGJM?=
 =?utf-8?B?OUgxaEVRZ3FTY3N0V3R5MjB0MmNIUXhRSVJEWGJDbXpMeDFvSUJDaVBQUEVY?=
 =?utf-8?Q?haMCTUSZYwI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDh6eDIrL3dRZHkzaXRYK1FWRzFmWUtYR0FCSTY5bXIrOThxSncxbmhXbjlW?=
 =?utf-8?B?Z20rVUNxMi9CY3FmZGs2VERsUklvT2JZMUpUbmtHWkhUY1gvLy9XeENuZ09x?=
 =?utf-8?B?Q0lKMXFGSWlha1NKeVJYSlUrdDdBcDBqVENrNC93RnZYZDNYemlpc3RSL21i?=
 =?utf-8?B?b1JUUGMyYUUwOWR1UTdDdERLOXdsUTM0dVJhZ09aY2locVFQSktLOE9uR2Zv?=
 =?utf-8?B?L2NBT3pWWmlwa2c4Smx6ZlVtNnNXKyt3L0xobEJvbk1Sd2RxYmw1TU1XRHM4?=
 =?utf-8?B?SXlaODQ1RnlhVHo5R0oyZVozWTNzSTZZSVhEMDVVTnBzaFAxZEpSVStIL2po?=
 =?utf-8?B?bnluL3VaWWYyUm02ZEpNakF2dkFBU3ZhVXF3NGlvSGdEMndtV2h1VDRhRUMx?=
 =?utf-8?B?YjgrSG9VZHBibVVQTlNHK0pHQUhtNGFsN0NIN284TjZmcmdkUnNPSnQzK1ow?=
 =?utf-8?B?Z1lwM3FLelB1TnY1Nk5ET0FGaDR1Ym9KcUhYYlFtc3FyZDhxVHpja0Nob3Rz?=
 =?utf-8?B?Wk5kam90MUNFNks4T0xtQWJaNmtCNkloRUlyQTlPT1lkWGNFUlU0TkhDaXV6?=
 =?utf-8?B?dW51NGoydnFoTm5qVFpVb3R3dGxtR3VwRTBGNGpxaFphS0FwWndlWHZUM01Y?=
 =?utf-8?B?aVBPa21sM3J4WjJNS0l6N3RBTHZMbVRKSEMyWjNBT0JkTHdYSmpBMHBKQm5t?=
 =?utf-8?B?RjB0dHdySElxRFFGMmRSTGE4U3c4bEROYmwxS3V3Yk1mSE5sQ2FaUVExRnpW?=
 =?utf-8?B?M1RJQ0pha0pocENTTFZvTFh4a1Z3NTRqM1lMdlc3RHlQczRNZTUxMmt0TGxv?=
 =?utf-8?B?eW5oditrcldPcXZPL1FwZzRHRm9iMlR2VHJQZHZXdzRHL3pDRVBjNmYzVHcx?=
 =?utf-8?B?bCs1cEZZWXRSODAxcWJ0Qm1NNlM5cjFPTGh3RnBZTVk1S0MrMFZCd3AzcURL?=
 =?utf-8?B?UjJkd3laOUpTa0JQcFZPanIyQTF2SmFjMWVTYTZTU09LeHI5ZnhkSFdpNHhC?=
 =?utf-8?B?d3RWSTZvQ0hzT2dxcWtxQWdwNkt4VzMzMGUrbXRhK00rall4Q0txK3hibGY2?=
 =?utf-8?B?STZmd0hWVmx6Q205VmhPWkRXUlVyOG1NcERHM2JYTkVlQUltRk04VDEzQ2pK?=
 =?utf-8?B?TUZVUXgxeE43UHVnNE92cmJ0NmRJR2czNUhGSHptMmpYdXM5d1FnQnNxS3Nl?=
 =?utf-8?B?THVwcStzS0pSTFZwUWxYQWhZV1Rzd2hHcnNUNzNLZGk4Wkh2T0twRVRHM1BN?=
 =?utf-8?B?YWdYYjVlemJ2bk9lajB4TUJ0K0Rqc0xlSWt5dDNmZW9hd0UyOVJYbkUzbXZE?=
 =?utf-8?B?ME1nWGNkd0FRSk12Y1lrVUFqQ3J5bnpzajlFeGYyNzVxeFhlbUllWE0zdlRk?=
 =?utf-8?B?ODBkNFZFc2oyamJWTXlLblBhSWxlQVYxcWxzLy9jd2psNFVQTjI0aUpFWXhN?=
 =?utf-8?B?bytCMStWVWwyOW5NTnA0bHR0UEJ0TFdYV3RKaSs3Slp2MUNDd05RYlNxTkNL?=
 =?utf-8?B?Tm5pWmNRTzVXQitHdUVWakRZMExER3I4ZHY5R0p0T3lpUGFqM2RrUVVFci9t?=
 =?utf-8?B?MmdaM05mZjROUDV4d1VxNDlYSkhnL3BSWk40R2R2VE1MSXB2b2hPWjZPUG5N?=
 =?utf-8?B?MURLYmFpQ2l0b1phb1hEZ1RMVUphMzR3TkQxQ1VJcjQvQ1BWVHRLcWZtU2Z2?=
 =?utf-8?B?cStLVzJOODhoMGRxY0pnSjhiZXpqL3pxbUZhVU0wTzVaamhoTTZRdCtqWm5T?=
 =?utf-8?B?aXdNemY3a25WaXJSR3dmeXVPaDFtRUF0Q0lHZWdqcENqcCs2dzJZekdaOTZv?=
 =?utf-8?B?TUJSYy8xVW1Qck82TEJhWktZZWk2NnBRWXNndjVjdkV2eldvYTZqYmliUHZn?=
 =?utf-8?B?amUrSVlvTmlyNGx3cXRGb3RKSmExUXJ2dEdvV2UyR3VtZEdwVkh1a044a0pC?=
 =?utf-8?B?RHJqcUlXdzc4Rk5JOFV6clhJdHpOV2ZvVC9jRUFmZjhvN0dqYzI5bHhJayti?=
 =?utf-8?B?dWxUdXAyS1NoaWxkV0lMODNNKzk0THlMYTk0WlBOWXBiMkc5aDhIaDZDOVo1?=
 =?utf-8?B?WHYxUDRkQ1pXT3g2UGwrOUVyT0c0ZzFlL0J2N1ZKUDNMb1ZwRm9GZTNJUUZW?=
 =?utf-8?Q?VV79ieHEo5Z4WhhfiRJR4k0Dz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff21bd35-f05c-4488-0a63-08ddce6836b1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 06:21:54.9327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LExDZ6R53skQzQ1UK+jDdgLsD77j+DbEj16VriZFz0fTbLBrL/VdaX45eH7IjP8D59+UY1hUqEIeqITIRhintw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
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

--------------0Xj2Kd8DarS9nqphK6cP9sN7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks, Felix. All issues have been fixed, and I will send out V2 soon.

Thanks
Lingshan

On 7/29/2025 3:48 AM, Felix Kuehling wrote:
> On 2025-07-24 22:43, Zhu Lingshan wrote:
>> This commit introduces a new id field for
>> struct kfd process, which helps identify
>> a kfd process among multiple contexts that
>> all belong to a single user space program.
>>
>> The sysfs entry of a secondary kfd process
>> is placed under the sysfs entry folder of
>> its primary kfd process.
>>
>> The naming format of the sysfs entry of a secondary
>> kfd process is "context_%u" where %u is the process id.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 82 +++++++++++++++++++++++-
>>   2 files changed, 85 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index de701d72aa5c..a6e12c705734 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -995,6 +995,9 @@ struct kfd_process {
>>       /* Tracks debug per-vmid request for debug flags */
>>       u32 dbg_flags;
>>   +    /* kfd process id */
>> +    u16 id;
>> +
>>       atomic_t poison;
>>       /* Queues are in paused stated because we are in the process of
>> doing a CRIU checkpoint */
>>       bool queues_paused;
>> @@ -1009,6 +1012,9 @@ struct kfd_process {
>>         /* indicating whether this is a primary kfd_process */
>>       bool primary;
>> +
>> +    /* The primary kfd_process allocating IDs for its secondary
>> kfd_process, 0 for primary kfd_process */
>> +    struct ida id_table;
>>   };
>>     #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 440fde75d1e4..e1ba9015bb83 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>>     DEFINE_SRCU(kfd_processes_srcu);
>>   +#define KFD_PROCESS_ID_MIN 1
>> +#define KFD_PROCESS_ID_WIDTH 16
>> +
>>   /* For process termination handling */
>>   static struct workqueue_struct *kfd_process_wq;
>>   @@ -827,6 +830,7 @@ static void
>> kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>>     int kfd_create_process_sysfs(struct kfd_process *process)
>>   {
>> +    struct kfd_process *primary_process;
>>       int ret;
>>         if (process->kobj) {
>> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>           pr_warn("Creating procfs kobject failed");
>>           return -ENOMEM;
>>       }
>> -    ret = kobject_init_and_add(process->kobj, &procfs_type,
>> -                   procfs.kobj, "%d",
>> -                   (int)process->lead_thread->pid);
>> +
>> +    if (process->primary)
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       procfs.kobj, "%d",
>> +                       (int)process->lead_thread->pid);
>> +    else {
>> +        primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +        if (!primary_process)
>> +            return -EFAULT;
>
> EFAULT means "Bad address". A better error code would be ESRCH "No
> such process".
>
>
>> +
>> +        ret = kobject_init_and_add(process->kobj, &procfs_type,
>> +                       primary_process->kobj, "context_%u",
>> +                       process->id);
>> +        kfd_unref_process(primary_process);
>> +    }
>> +
>>       if (ret) {
>>           pr_warn("Creating procfs pid directory failed");
>>           kobject_put(process->kobj);
>> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process
>> *process)
>>       return 0;
>>   }
>>   +static int kfd_process_alloc_id(struct kfd_process *process)
>> +{
>> +    u16 ret;
>> +    struct kfd_process *primary_process;
>> +
>> +    if (process->primary) {
>> +        process->id = 0;
>> +
>> +        return 0;
>> +    }
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return -EFAULT;
>
> ESRCH
>
>
>> +
>> +    ret = ida_alloc_range(&primary_process->id_table,
>> KFD_PROCESS_ID_MIN,
>> +         1 << (KFD_PROCESS_ID_WIDTH - 1), GFP_KERNEL);
>
> Did you mean (1 << KFD_PROCESS_ID_WIDTH) - 1? That would give you the
> range from 1 to 0xffff, which is what I'd expect with 16-bit wide ID.
>
>
>> +    if (ret < 0)
>> +        return ret;
>
> You're leaking a process reference here.
>
>
>> +
>> +    process->id = ret;
>> +
>> +    kfd_unref_process(primary_process);
>> +
>> +    return 0;
>> +}
>> +
>> +static void kfd_process_free_id(struct kfd_process *process)
>> +{
>> +    struct kfd_process *primary_process;
>> +
>> +    if (process->primary)
>> +        return;
>> +
>> +    primary_process =
>> kfd_lookup_process_by_mm(process->lead_thread->mm);
>> +    if (!primary_process)
>> +        return;
>> +
>> +    ida_free(&primary_process->id_table, process->id);
>> +
>> +    kfd_unref_process(primary_process);
>> +
>> +    return;
>
> This return statement is unnecessary.
>
>
>> +}
>> +
>>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>>   {
>>       struct kfd_process *process;
>> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct
>> work_struct *work)
>>       if (ef)
>>           dma_fence_signal(ef);
>>   +    if (!p->primary)
>> +        kfd_process_free_id(p);
>> +    else
>> +        ida_destroy(&p->id_table);
>> +
>>       kfd_process_remove_sysfs(p);
>>       kfd_debugfs_remove_process(p);
>>   @@ -1549,6 +1616,12 @@ static struct kfd_process
>> *create_process(const struct task_struct *thread, bool
>>       process->queues_paused = false;
>>       process->primary = primary;
>>   +    err = kfd_process_alloc_id(process);
>> +    if (err) {
>> +        pr_err("Creating kfd process: failed to alloc an id\n");
>> +        goto err_alloc_process;
>
> That's the wrong label for cleanup. You'd end up leaking the process
> structure. You need to create a new label. See below.
>
>
>> +    }
>> +
>>       INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>>       INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>>       process->last_restore_timestamp = get_jiffies_64();
>> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const
>> struct task_struct *thread, bool
>>               goto err_register_notifier;
>>           }
>>           BUG_ON(mn != &process->mmu_notifier);
>> +
>> +        ida_init(&process->id_table);
>>       }
>>         kfd_unref_process(process);
>> @@ -1619,6 +1694,7 @@ static struct kfd_process *create_process(const
>> struct task_struct *thread, bool
>>   err_process_pqm_init:
>>       kfd_event_free_process(process);
>>   err_event_init:
>> +    kfd_process_free_id(process);
>
> You should add a new label here
>
> err_alloc_id:
>
> Regards,
>   Felix
>
>
>>       mutex_destroy(&process->mutex);
>>       kfree(process);
>>   err_alloc_process:
--------------0Xj2Kd8DarS9nqphK6cP9sN7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>Thanks, Felix. All issues have been fixed, and I will send out V2 soon.

Thanks
Lingshan</pre>
    <div class="moz-cite-prefix">On 7/29/2025 3:48 AM, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:51264616-aca9-4b82-822e-7c8856b47629@amd.com">On
      2025-07-24 22:43, Zhu Lingshan wrote:
      <br>
      <blockquote type="cite">This commit introduces a new id field for
        <br>
        struct kfd process, which helps identify
        <br>
        a kfd process among multiple contexts that
        <br>
        all belong to a single user space program.
        <br>
        <br>
        The sysfs entry of a secondary kfd process
        <br>
        is placed under the sysfs entry folder of
        <br>
        its primary kfd process.
        <br>
        <br>
        The naming format of the sysfs entry of a secondary
        <br>
        kfd process is &quot;context_%u&quot; where %u is the process id.
        <br>
        <br>
        Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
        <br>
        ---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp; |&nbsp; 6 ++
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c | 82
        +++++++++++++++++++++++-
        <br>
        &nbsp; 2 files changed, 85 insertions(+), 3 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        index de701d72aa5c..a6e12c705734 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
        <br>
        @@ -995,6 +995,9 @@ struct kfd_process {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Tracks debug per-vmid request for debug flags */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 dbg_flags;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; /* kfd process id */
        <br>
        +&nbsp;&nbsp;&nbsp; u16 id;
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t poison;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Queues are in paused stated because we are in the
        process of doing a CRIU checkpoint */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool queues_paused;
        <br>
        @@ -1009,6 +1012,9 @@ struct kfd_process {
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* indicating whether this is a primary kfd_process */
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool primary;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* The primary kfd_process allocating IDs for its secondary
        kfd_process, 0 for primary kfd_process */
        <br>
        +&nbsp;&nbsp;&nbsp; struct ida id_table;
        <br>
        &nbsp; };
        <br>
        &nbsp; &nbsp; #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        index 440fde75d1e4..e1ba9015bb83 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
        <br>
        @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
        <br>
        &nbsp; &nbsp; DEFINE_SRCU(kfd_processes_srcu);
        <br>
        &nbsp; +#define KFD_PROCESS_ID_MIN 1
        <br>
        +#define KFD_PROCESS_ID_WIDTH 16
        <br>
        +
        <br>
        &nbsp; /* For process termination handling */
        <br>
        &nbsp; static struct workqueue_struct *kfd_process_wq;
        <br>
        &nbsp; @@ -827,6 +830,7 @@ static void
        kfd_process_device_destroy_ib_mem(struct kfd_process_device
        *pdd)
        <br>
        &nbsp; &nbsp; int kfd_create_process_sysfs(struct kfd_process *process)
        <br>
        &nbsp; {
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (process-&gt;kobj) {
        <br>
        @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs kobject failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; procfs.kobj, &quot;%d&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (int)process-&gt;lead_thread-&gt;pid);
        <br>
        +&nbsp;&nbsp;&nbsp; else {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
      </blockquote>
      <br>
      EFAULT means &quot;Bad address&quot;. A better error code would be ESRCH &quot;No
      such process&quot;.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = kobject_init_and_add(process-&gt;kobj,
        &amp;procfs_type,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; primary_process-&gt;kobj, &quot;context_%u&quot;,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;id);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_warn(&quot;Creating procfs pid directory failed&quot;);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kobject_put(process-&gt;kobj);
        <br>
        @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct
        kfd_process *process)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        &nbsp; }
        <br>
        &nbsp; +static int kfd_process_alloc_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; u16 ret;
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;id = 0;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EFAULT;
        <br>
      </blockquote>
      <br>
      ESRCH
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; ret = ida_alloc_range(&amp;primary_process-&gt;id_table,
        KFD_PROCESS_ID_MIN,
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 &lt;&lt; (KFD_PROCESS_ID_WIDTH - 1), GFP_KERNEL);
        <br>
      </blockquote>
      <br>
      Did you mean (1 &lt;&lt; KFD_PROCESS_ID_WIDTH) - 1? That would
      give you the range from 1 to 0xffff, which is what I'd expect with
      16-bit wide ID.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; if (ret &lt; 0)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;
        <br>
      </blockquote>
      <br>
      You're leaking a process reference here.
      <br>
      <br>
      <br>
      <blockquote type="cite">+
        <br>
        +&nbsp;&nbsp;&nbsp; process-&gt;id = ret;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return 0;
        <br>
        +}
        <br>
        +
        <br>
        +static void kfd_process_free_id(struct kfd_process *process)
        <br>
        +{
        <br>
        +&nbsp;&nbsp;&nbsp; struct kfd_process *primary_process;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; if (process-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; primary_process =
        kfd_lookup_process_by_mm(process-&gt;lead_thread-&gt;mm);
        <br>
        +&nbsp;&nbsp;&nbsp; if (!primary_process)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; ida_free(&amp;primary_process-&gt;id_table,
        process-&gt;id);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_unref_process(primary_process);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; return;
        <br>
      </blockquote>
      <br>
      This return statement is unnecessary.
      <br>
      <br>
      <br>
      <blockquote type="cite">+}
        <br>
        +
        <br>
        &nbsp; struct kfd_process *kfd_create_process(struct task_struct
        *thread)
        <br>
        &nbsp; {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *process;
        <br>
        @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct
        work_struct *work)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ef)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_signal(ef);
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; if (!p-&gt;primary)
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_free_id(p);
        <br>
        +&nbsp;&nbsp;&nbsp; else
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_destroy(&amp;p-&gt;id_table);
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_remove_sysfs(p);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_debugfs_remove_process(p);
        <br>
        &nbsp; @@ -1549,6 +1616,12 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;queues_paused = false;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;primary = primary;
        <br>
        &nbsp; +&nbsp;&nbsp;&nbsp; err = kfd_process_alloc_id(process);
        <br>
        +&nbsp;&nbsp;&nbsp; if (err) {
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_err(&quot;Creating kfd process: failed to alloc an
        id\n&quot;);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_alloc_process;
        <br>
      </blockquote>
      <br>
      That's the wrong label for cleanup. You'd end up leaking the
      process structure. You need to create a new label. See below.
      <br>
      <br>
      <br>
      <blockquote type="cite">+&nbsp;&nbsp;&nbsp; }
        <br>
        +
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;process-&gt;eviction_work,
        evict_process_worker);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INIT_DELAYED_WORK(&amp;process-&gt;restore_work,
        restore_process_worker);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; process-&gt;last_restore_timestamp = get_jiffies_64();
        <br>
        @@ -1599,6 +1672,8 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto err_register_notifier;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(mn != &amp;process-&gt;mmu_notifier);
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ida_init(&amp;process-&gt;id_table);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_unref_process(process);
        <br>
        @@ -1619,6 +1694,7 @@ static struct kfd_process
        *create_process(const struct task_struct *thread, bool
        <br>
        &nbsp; err_process_pqm_init:
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_event_free_process(process);
        <br>
        &nbsp; err_event_init:
        <br>
        +&nbsp;&nbsp;&nbsp; kfd_process_free_id(process);
        <br>
      </blockquote>
      <br>
      You should add a new label here
      <br>
      <br>
      err_alloc_id:
      <br>
      <br>
      Regards,
      <br>
      &nbsp; Felix
      <br>
      <br>
      <br>
      <blockquote type="cite">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mutex_destroy(&amp;process-&gt;mutex);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(process);
        <br>
        &nbsp; err_alloc_process:
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------0Xj2Kd8DarS9nqphK6cP9sN7--
