Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D442C5B552
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jun 2025 08:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 465C510E22A;
	Tue, 10 Jun 2025 08:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sE7U6Knx";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECA3910E22A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jun 2025 08:47:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTUt0TrQR05UkqK1/kP600lzBDoqWykuSpiox2vQ0Zv7WWWH3jqeZ4GCUGGX36p6Q/YArzk6e9tRUvYekOY0Jg1wuOhNY8D0shN+pG8uDT0wW8ygpZl5ynxIPh6YSvUDHmwtJ5/Zd7G5M8fbLMMvCL/O+UdPYae6j88POEFXn+tIFpvhVzBVCrIEfEXAzuQz4scbrYKGZZNf24XQfLYhVtmel0N+6i2nBb0M1pY8+Wfc2gfJvZ9eDZ2HBoM8pxmg3/88lVqfz1+hr7qIIJw9JhZx1WwrxoTXsXhMOZNFfolM55a/EgJBO79+NvOkIT6GBRy2JolyddVyz2E37Bushg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXSxI/UlWJpCESsL8+dkQFHb7kwfch27Sw2kOAcxWAg=;
 b=PsGH0H5WQstL3ElsK+3B2xJiXqun6hfDrJSai4x+Bmsq6J5TS0HEbNVGSdmhKCDdgaHBsRKpp3PONOe0apZcKv4F11Jgt/cwsizv8B0mWZlyGdZU5VNZgqot2dxGWpEQPdSc0ZaqDak7m5Vv4/N9PZwtJTS1yonyLk/Kvs0fBUh7XedwDTTBuT1ZoPW/JIxNnlzU6ih2WCCOO5Uf2D+hlYFpbsJe7e+wgaz7D6DlZbekDEY1hDQnjzep7jf45R88pXvWPqn4fBzGdEYjb5VxFoYrFvpmYHJY4GH/eSXj8A0fXTCNagS7gSP1akYI1XDJrdv7wLm0A0YiBux9YIIBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXSxI/UlWJpCESsL8+dkQFHb7kwfch27Sw2kOAcxWAg=;
 b=sE7U6KnxDdiN78d05K0DOuJgmOWu6T+F39LxiAH97/gHgHs8zXFDSIBZxOa8pe6ylGIACRmtrEX7+MCsKn00ZG/+XBevym6A67rGLJLYOecj1BfkTdZ6L6ERdCuPXwC+RSXX30uqyS/xx7aroObgb9iXUun/HahQtVY/rLPcpwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Tue, 10 Jun
 2025 08:47:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Tue, 10 Jun 2025
 08:47:06 +0000
Message-ID: <849cdbd0-1c45-4510-9da8-76be0f735db3@amd.com>
Date: Tue, 10 Jun 2025 10:47:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/ttm: Should to return the evict error
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250603091154.3472646-1-Emily.Deng@amd.com>
 <becc0fd4-cb6f-49b5-8197-a755d3c5a359@amd.com>
 <CADnq5_O5-1GT=xoOQCdnkg4k9v27g3sOOonf5ghqR5hiLEtnyA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_O5-1GT=xoOQCdnkg4k9v27g3sOOonf5ghqR5hiLEtnyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 45269dbb-eddf-4fa1-20a4-08dda7fb610a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0lIS3FkZ1FpRm9wVVB0VzFiVFl6bk9RNVloemNTcnFkaDJoZUdpSnAzc0Ir?=
 =?utf-8?B?b0xlWDVvVjdKcE9oSCtFY3pDMHlWYklOaS91dGErN0Z2S0FqR083Z1VZc2pv?=
 =?utf-8?B?QzBqZStZaStKQjl4Ym9iVXlFVmVBdzRyeXBXdjRvWU1LN2lscjVkNUxXQWgy?=
 =?utf-8?B?MEFIUHBxRFBpanhKc2xabVY1MDVLL1FnT0t4dkFNb0pwbFV4YnVnb1BuYm5H?=
 =?utf-8?B?OTNHV01uNUF1TXQxOVdUMzNlKzFoY1ZrYXU2Rjd3T2duTit4dWZzdGp0Q3Zo?=
 =?utf-8?B?WVh6aE5OT055ZVZqQmhwa3dsdWw0a21NSnVMSlZyM2s3cDQ5bnA4a3BuZGxx?=
 =?utf-8?B?eEl6TEJCSjViVTU2VjBnV0puYzZudmpkdVZaOXdGYUJPQ3JJY29LT2wzdE4r?=
 =?utf-8?B?aHRhcjBQMTI3dmhJeVhEUWFib095WDZzeUJqalpxV1h4MzdBSE1VRzFFSkxU?=
 =?utf-8?B?MHpkSGhoUERWRFV3Q2VBdFo2UXJZVHFhVGZOT3hIdy9RaExtdGVJMmVLeHhN?=
 =?utf-8?B?SjJFNzB2Z0p4Nm5FUHlMVnUvckh3QUpMSlllYm9GK05NWVlGdW42ODByWlhx?=
 =?utf-8?B?aTl3bzljejFyZG1NalBiM1lTeUZvNjcydWxraWxZUE15eERzelk0cGxkVFoz?=
 =?utf-8?B?QkdzWXY3OVhYcHlUMnlGNzREZHZCbW1uT0N0MkphSnRMeGIvZE5kdHJPVFRr?=
 =?utf-8?B?R1JYa0ptUGk4N3Y3NkZaYm5CWmRPeGJFYk41YkltRjIrWEh4c1BGM1o0NlRW?=
 =?utf-8?B?SHlmMFA0SnUyT2lWTTRBWmpUN2lQakxSQ2lIYzFteUVaOFQzWEpHOVQrUzQr?=
 =?utf-8?B?MCtESlRWSCs5OTBDWThMK2V5VkVESHE0NWJPZkZraWtGSHJrL29JVGNhVFcw?=
 =?utf-8?B?T2d5a3FuSDEzV2ZHZExlQmM3S09IaVhHV2FERWhNQVg2ZmV2NHJvMHoxa1lU?=
 =?utf-8?B?M0dkR0JyMlhjK0h0WXBucTBIM1VnYlMxZmlGMHpRM2EyNWVYTnMxOTQrclly?=
 =?utf-8?B?ZmkrekkvSlZJZ1VMdTBRc1RBKzJMYjZqUXBUNFRlZ29TL3Y4VFhOeTdKZm1O?=
 =?utf-8?B?dHpWOFlIbzVVM0xaaFdGWVZTZ2d2TTI2Z2o5bDZXWVVXMVFKY0FiamZNdUYx?=
 =?utf-8?B?V25sVVRDeVZ1MlorZmVrNWlzckRVVWNNNjUrckpjbXd3ZG01Z0RDeU8vQndP?=
 =?utf-8?B?RDhhcXR5VFB3VTBiQVVqa0RZK2wzaGJ4em1Ya3M3Rys1blZYclloK0h6OEVI?=
 =?utf-8?B?VGV4clhLVGtyT3h6Mm55Mjdxdi9qT1N0K01rM2NsWFhPeEs1d3FWVU5qR05G?=
 =?utf-8?B?QVpnYnNPOXJFTExybXVXdDN0MU9HMk5ON2dNZ2hmM0JLNVZwOVVnMHRERnc1?=
 =?utf-8?B?Y2J4ZSsrMGJmUzZBZ0dhTjdINTFkMnhnN0JJNTdkZlk2K1kwK3BzMnkzdUdL?=
 =?utf-8?B?SFBxM2Z3SytSUkFpYjdNdFFjb3NMVkZiV00rN1F1Q2VtNmxyRklIdEVURGEr?=
 =?utf-8?B?L2dtNXdoTTRhaVhyZFlWZFM5MHpTRW12N0Q5dUwvenZob1l1czNPUlIwa3hl?=
 =?utf-8?B?Wm9GaXhhOGRYdVhZTHFUNDdrNjZGOTBwRnFDN2I4blg4V2RlTWZLWEl3ZWNj?=
 =?utf-8?B?M2RqUlgyYnNYbU93NE1Sd3hwWS8xclVZVFdJbldDSUZmTUJINWxoM24yVHVy?=
 =?utf-8?B?QXJNbjdydlBUOWtqZzkrTU5lN2dJTXh4eHdDZ3lvSENUNUtNNlhKUGhBclVS?=
 =?utf-8?B?SENlcUZMTXE1OUp2QzJUdHBydGhTZjUxSytibGJtNWw3ZENGRE1JaVNZTm1K?=
 =?utf-8?B?RHFzdG1wUnViaDkyakh3bWJFMUpNV2dlN01QK0p4L2tQSmRza1BkRGx2Znow?=
 =?utf-8?B?S1I1Qk1yWUxwcWpDQWZhbTZiS2pmVjF3V0x3NnN0b2ZYZ0FBSmo1UVg1YjVP?=
 =?utf-8?Q?CgzG1fY0Jg8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVNSVZtT0RmSDE5RzNqc3VHSFhnZzlDaFFXaGxZYks1WFhyVVc4VWcxRU9l?=
 =?utf-8?B?c3dNdkJFRFZkUFNSOFp1a3VNVHNNekd3cnRpK1V4Y2JpcGFaQlhEUlh2VzJa?=
 =?utf-8?B?aFFjZ0tSUGwyZ2FKNHh3VGpkSTlqMDRRYTF4aFF3UkVlVEdCakNWZHNIdjZO?=
 =?utf-8?B?bjRMU2grSHhKL2gzMVpWSTk3RjhpNXlwdVdKK0ZKL2U0M0hlOW8xQ2V2a0ty?=
 =?utf-8?B?SnMzeERmUGcvM01BTldOQzY5Q2ZvRGxVZXlZeURGMTlLMzJybnNIalJXNHUv?=
 =?utf-8?B?dGNsU2d4UEpXUUtCOWJEeG5CeWtmRlVvVHA2V1FzQW5aYWVyaXdjaEJFdzZp?=
 =?utf-8?B?bTJjV04ydzFQNi9GSU9OT3RiTGVLTHJNUnBkMEVkTER5S0kwU1pNUmZQN082?=
 =?utf-8?B?TUhQY3kreFlXVDhNTFRWa2NuanFLMVpBbVQ3bFFpUGR0NjRuTW5UVGN6Z2RF?=
 =?utf-8?B?akVFVWJnZ0prNTdrS2Evbm5qaUZRMTVzemRkQS81VjZQUitKY3ZnSDJ4amtt?=
 =?utf-8?B?U1A3N3FSbXdrOGdHUnRVekllTWpLUUNVazV2bGwwTkNLRWVLUVFtcnlENCtl?=
 =?utf-8?B?dE9ERGlReDlpSkdOZFB6bjQ3MitRTmlBZmphY3Ezb1pHY2l4eEM2UUJMTHV4?=
 =?utf-8?B?N0x1cVB3UUpNeWc5NHF4NVlBNXhDK0NzbTBpbGVQeW5jTlhnNjhnZ0RNM0Vw?=
 =?utf-8?B?emdyZ1J1ZnNBME9kOW9EYnkrMUJCd0gvbUlWYmJNWGpJbkxJQkhjM2dGclpF?=
 =?utf-8?B?b2dRWFc0USt3Z2hEeHdXQmpERVc1MjNuUGlmbHN2Zm5LNlluakRrcHV4UDhP?=
 =?utf-8?B?RmhKWmNtSzdEUG13RmxzbGw5djZpcEdUZWR2L2Q4TDFDWU9rVjJDL0lTTkZj?=
 =?utf-8?B?dG5FUmhqdkNaVU1lTmdVVUFYWEQvM2Z5eWxPRXZ5RzJiNU5EeHBxVjNVNHlv?=
 =?utf-8?B?dlNBRkRvU1h4V3RsN084dXBvTlc0R2VRVVpOVGkrL3lhaGhUa21kQnBYMUV5?=
 =?utf-8?B?K3YzZHJBTHpSajFlcTU5dC9nYWNvRy9xTCs0bzF4dWd5UHdHSmFaQUlHM0Ew?=
 =?utf-8?B?d0JTYU9PVFNWcEVocytkeUttNEJLcXdoZzFtQWJNbmNxY2UrL29sZ3dhSVBv?=
 =?utf-8?B?TGYrQWVxMkhiQzZkMm1GdmxwTy9jQUhGeENiS1hsVW5yZExYVlk5R1NadzUy?=
 =?utf-8?B?aVhMMDl3M3IzY2FxcEhVQ2ZmWTJ5U3RnN2wycU5SVlZBTVpSZU5XVjRFWGFp?=
 =?utf-8?B?ekxnYTVGQnY2a3p1c0phWGNQeUJSdUVnNTdPK01uQitNV0U3Y3UyNXNleXNi?=
 =?utf-8?B?aGtCbE9Xbm9nbktuYlMxRjNvTThLK1lBdXpiNjRNZmhOaHlkMk9GMkJxaHAz?=
 =?utf-8?B?TDJYd0pXbXl1V0dYUGZJTDhXN0twV2tLYmduTUhNRUlOKzhXS0UrQTdLRnRy?=
 =?utf-8?B?dzlHRy9aOEN6eVhRK3N3UjFRSkhaR3pISVJnL3duUGpaU2ZGbFFNTi9pWEpT?=
 =?utf-8?B?bVBhN3QxbXQ5a1NZRHB2bHpjQTIwWWRMeTlXMUNZT2pkNkU0WHpEWFJHVGxi?=
 =?utf-8?B?bE5CQXRFcUhLY3JNLzBSQkZzRXdpL1Z1VFNncytTR3VZVzZRY1g4aExjM3Bv?=
 =?utf-8?B?dGxTWHdXVWtYK1hVVGdLU3dGdmlGWnhFeWt2WFpvNGNrK1Q0SFkrZ0pxdzFi?=
 =?utf-8?B?cHB5TE9kZ1VSeE9vZDBpUVdCWG5HUjlOdlZDSDJmbm44Z3RhV0psSmhBM2Qr?=
 =?utf-8?B?RkpuUlNNRDZGQkRGTVQwVnBZWTBGc0tWbFVkNEZRd1B6dk5QZGtrMmZNTUdm?=
 =?utf-8?B?eFlCMVlKNy9GQmJiZlNQUCswc0R2S1NRdDBsRjRJcDhpYkg4dGsvMXVZblV5?=
 =?utf-8?B?OWRjUERQV2FBdEpzMytlbnJIVkhSc09KUWlhNm1XbFg3MjMzQkJsMktuNENB?=
 =?utf-8?B?b3lwUVVEeEtNWldkNHA1Z1pmRTAyVHpsSzJDYytKTkUwQWhNd2NKcUhZdnd2?=
 =?utf-8?B?Uk96bkNyYW9xbmdQOFNTa2N5ZkxaRGx1YUg4cjZwZkNHV1JCbkRHdUlSdnZj?=
 =?utf-8?B?cXk4Skl1M2RuaTVrRm45KzYvbUFiTHRBZ3pUMHVkM09seVJ6RDd0YmlrK012?=
 =?utf-8?Q?n6vo1YYoljAEdk0uoMpqOPbxM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45269dbb-eddf-4fa1-20a4-08dda7fb610a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 08:47:06.6735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9eVQ4NcKkC/U3A4lD6fCedgkIfCWgZVwv2PyyKaRWZ+27bJ6n97oDheAzZgI0Hl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

On 6/6/25 18:55, Alex Deucher wrote:
> On Wed, Jun 4, 2025 at 5:06 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 6/3/25 11:11, Emily Deng wrote:
>>> For the evict fail case, the evict error should be returned.
>>>
>>> v2: Consider ENOENT case.
>>>
>>> v3: Abort directly when the eviction failed for some reason (except for -ENOENT)
>>>  and not wait for the move to finish
>>>
>>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Did you push this to drm-misc?


Not yet, I wanted to take care of it this morning.

Christian.

> 
> Alex
> 
>>
>>> ---
>>>  drivers/gpu/drm/ttm/ttm_resource.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
>>> index 7e5a60c55813..bb84528276cd 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>>> @@ -558,6 +558,9 @@ int ttm_resource_manager_evict_all(struct ttm_device *bdev,
>>>               cond_resched();
>>>       } while (!ret);
>>>
>>> +     if (ret && ret != -ENOENT)
>>> +             return ret;
>>> +
>>>       spin_lock(&man->move_lock);
>>>       fence = dma_fence_get(man->move);
>>>       spin_unlock(&man->move_lock);
>>

