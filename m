Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1611D29FE5
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 10:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3406510E5F1;
	Wed, 14 Jan 2026 10:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lQcpBWlU";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FA510E5F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:35:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmP30IFuyGGbrQZdLuo92je6zVrVx5RapO45hMLPatEH/YfcUI+vZ/C+A7CN14/64VeDHDDjMMtgYYRdjshgFAP6XVMUoWP+0Lc8yC+UCe8sloznabPGk44QDPl73rdQuXSODODZ6rEkBU+uWnLyI22CbtMlJqG8j4NRqm70KLGSPBHTiQBujhqnJTphfNl/I8AfD77jyLfxJqD/5tPs5EwwY2TMlce7Nr7wFkMrjz2so6zcupNo4KjxzLik2udP+gC9IBCOqisvR7wEaMq7dZ0IfQCKj2EmjxHCtnfT9M+79W6iaLqPGhnt4zeyWMlNfRJBVLEOFlw3sy8I7KQVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0SaIH7LIoj4+DzFnavQZ2dOYvAHWzUkHKfNRMex73A=;
 b=Cpz3VpvCtHq7Bch5hzeu4PIuGATTmO7xRJtIornYsyYLristhR0rUUrTadGPOR/VzNQ6NO7p5aGrmTLkjn6FrT2DIkfZ2RFUc5fgsGaOQO/F+7ew/UFn6BSYgwoTjcnH0QDKtBzLmhFHSeIyHc5JRDmrHT2hXTGtmGGZuokxElUloKqHbTD1Tv1zAWqEbEpgIBStL5pdPnhiKlPvsYaV6X/pnt4gXNQIuv2yEkT/fPz/ZH+tA3Tonot1DXkIJe9JZm/Kkd+zPFMEBzHOW6ENfDe1vGofsPVsTsON9BNbMwvu+J+HLYD9jbuo3HqXiaz/U5K/217pUQUltuhA7J6MFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0SaIH7LIoj4+DzFnavQZ2dOYvAHWzUkHKfNRMex73A=;
 b=lQcpBWlUDjSKw42HckhMbvXtSOLZmj4TRGgr8CPAZs2c2l8nKipd1wfCM0nEIoMvVEtouguOgPBFoHUrFxR08AflSQtzECWqJA3P/9Juh9if1yC4EAp+dPubPdtkAU6gH7/KBhK+jfQb9nXsBRYPIwBkGx7JCBcgoOtqnFojC7s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8228.namprd12.prod.outlook.com (2603:10b6:208:402::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 10:35:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:35:38 +0000
Message-ID: <8df01f0f-405f-4f42-92c5-9b39cd4f6c86@amd.com>
Date: Wed, 14 Jan 2026 11:35:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/42] Improvements for IB handling
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <ca9d73f3-60c6-4a51-a62d-d1358940ac3c@amd.com>
 <CADnq5_M8DE5N=c3zZbFHtL6GPq_zJCk9P1VN+gMTCPR5dy7KSw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_M8DE5N=c3zZbFHtL6GPq_zJCk9P1VN+gMTCPR5dy7KSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 31466f30-a95b-4517-ca0d-08de5358a85f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWYzamRYK3FLRkxXYUN3T1M0OHpwMENzak9PeUJkOVFpNmp2bjBlY3A3aWdi?=
 =?utf-8?B?SFFxN1dlVjVkTnc2TFdmSFExRXdObkh6QWJNZzltM2V4d004VFZveGtKTVhr?=
 =?utf-8?B?SDQyR3pTZU5QVHpDcUF5UFlOUml2cVBzK2hBTitLRWVhaE1sUFRBZVRhTDNz?=
 =?utf-8?B?TGd3TzdpVVU2UWIzNDNYOS9KM09zekY2Mzlsa21xS0VnWnR5MnJzVEdRN2dB?=
 =?utf-8?B?TEtYc3FIL05uam1PU3loZzhVSDQvOHNzakhQOVdsdFRqVWRFcjl4NEhXbVZ3?=
 =?utf-8?B?OG1TRG5rU0pkY0lJZjlqNVAvV2g1elpEaXZ3K1l4MHZjTkFaSDdRYUI0M1hx?=
 =?utf-8?B?L2JJcFZvNkJsNzMzeUUzV3BJVGo5WlFscGo1ZGtpY2xpdDd1S0JhV1h3bzE0?=
 =?utf-8?B?bm5tWlV1YURkNFhVZHpyQ3cycFQyWG5ZVXNOZUFjS0t1cU84QVJyQXJFajNs?=
 =?utf-8?B?TklZWVhKOFNqVWJsUjFPcjNaWkkzMXVxV1JkNEQvcGJhL0FkMDlWNW5rQXRr?=
 =?utf-8?B?Yy9VeEI2UWtZSStKcXg1VlQzU3UrNld1eUlxbmRySXQ4Ty84K2c5SzU0QkY3?=
 =?utf-8?B?dmthZDNSS3lTVEJFV0NiMFVZWjc3M2dRNTlRbWtHcERKMTVjR0tZNVJrY3dE?=
 =?utf-8?B?aUV4RDV4UVlZWXdjbm5tS0JaNkZ2SWN2YVdsN3RkU2dlalV3MDRENW1memlI?=
 =?utf-8?B?Q1BBVWNCK1JlVjdReStJVEJPbk9WUkJGMk5qQWxmQ01MTXBiME8vT0Roc1pG?=
 =?utf-8?B?TFJJeTQyYU8rOGsxYW95cklaU2lQRHgvUUMvQ09Dc3lEZk5GS2xRRWhFKzFh?=
 =?utf-8?B?TTVZVVoxckM2ZDNPYytnNXhIenVQZk5UVC9CVHlVVjBVblpsRllXTVhrelJJ?=
 =?utf-8?B?VGpxaFc0aTdmUk8xVjlBMVlrSXByTFRPSXNoeG00LzUvdmZOZVMzcGxjcUFX?=
 =?utf-8?B?UmVJclduN2RIbkJsRjN3ZHFPRStWR1FZdmRXUzFibjU1bEZka2lxMFRRcVdG?=
 =?utf-8?B?Y3RCVkc2b2xVTUFkWll5VGxZUHZ2OUlIYktQT1NVNkFHVURScS9mUjN2S0Z1?=
 =?utf-8?B?MzgzL0hMKzc0THhCWExnMVA2RU5jTFJWYUk3TURoRVNCaG1kdG5PSHNMQ0pG?=
 =?utf-8?B?cTlQZW9kRVNtWkZnK0s1K2lWNW02R1M0em5NaWZHMXZWdS9zRnNRRk5DdmJR?=
 =?utf-8?B?MmZabGhDMzlDUm9ITlZSdGVhUndHZ0FTSWRiREc2RHRHUk1BZFo2VFpldkpM?=
 =?utf-8?B?R0NzS0FvdHJCRzNXeDF1UndGMHdtR2JPd1dUKzVramZITkVCL0lTRWFqUUJ3?=
 =?utf-8?B?eUxsVlRMZmpHZWMyV3loMnp4K2FLMk1OQmZINVAvaGgwclFUWGRMWklHUEFo?=
 =?utf-8?B?bXFwekF2TUxmNktpQTRIUWdaWWg3TlROUmRtMERud1lncFpWYTA1WTd3Ylp0?=
 =?utf-8?B?VUxJM3VjTXNlcnhlK2dRd1VJdHFmbW5rNGpoZGNEMzd4TUd2VzJyQ2FqdGFR?=
 =?utf-8?B?MzdtcTFOY3IxTkRiUzlWUDI5cVhRcC9EbmI3aXhXSmZQallKdmxHTm9qUTM3?=
 =?utf-8?B?T2w0dUNZL0U1ZkpXYlgrM1Jlekd5bEJQNHVRVEc3QVlWZlZpSzU3b1Fxa0kw?=
 =?utf-8?B?SXY1cVFKQ1hlRWc2Uk0zVU9EMHUxOFA1UkZmWTNaekRoVzd1eUJkSms0dm5h?=
 =?utf-8?B?aEhubnphUGZscXcyN2JVMnNqR1RhVmZHbFowMDRKZDFaNmFPdGxCSUdUV2lE?=
 =?utf-8?B?d3VPVDM3VHF0ZWNNYVlXdEV2WFJhcmx0aE9VQVh3Umt3MCthR0JsTVY4djFv?=
 =?utf-8?B?ZVhzRllRYnBaZDAxbm5TWFhPdTByK2hwVmtlekIxTDgvTVZ0ZTBjTXJWWVFV?=
 =?utf-8?B?MnhmM29sM1RkVkJuUVlxd0ZzK0p2QURrSzk1RVBOS2hnSWdOdVd0Unc2dVdv?=
 =?utf-8?B?TllDVHk5SlpRZVBJR0NSaU1pc1VnUEtQSlNRemkzQkxPVkJyczU4U3c2Wlgz?=
 =?utf-8?B?L0ZZZ0RFMXBwTEhkWEFSYVJCNXhrQWRnaDF4aXZyNmNaRG1pU2FyU2dQN2Ur?=
 =?utf-8?B?T1VOOVNETkRQUEpvKzJpWTdqY3A0SlVWcVJvQTZabTVOM2R1Y1MvdHNxVnZq?=
 =?utf-8?Q?fYFU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWJpTmlFbC92MVNtOVZqcUQyTnlNNlNyMWdDRW1GV0pONzdLWjFIaDhiNytw?=
 =?utf-8?B?bS9aYTFqY01JdExicVY0NC9VUnJVQTRseGNQNlZhYjF5bUkwTDQ5UkxCTTBT?=
 =?utf-8?B?a1p3T0NNVHFHdGo2VGtnTzk1Sno3Qis4MnVpUDhXUnB2R2VVUk9WeG40MlVp?=
 =?utf-8?B?S3E5dUwrazYwcWtCNmNpejA0dTFmV05SNEp3dU1mYUxYRmlxbmlXN29HV1lW?=
 =?utf-8?B?N1EvdkF5aGV5TmlnZXdoWnh6NHV6QWo3REt6ZlFueFBvajluRmxBNUI3RUZV?=
 =?utf-8?B?Z3UzdFVoYmtzNHRJS2tkNUorZjA2VTN4b3pTbjRGTk5SY0lYMGxkRUk5UDJO?=
 =?utf-8?B?blRrOTJoZmdnSldsY3Ayb2FNd1l0bG03YjdvL2h4Kysyc0lEVHFhWVJxRDVx?=
 =?utf-8?B?YXR3cldCUElVMDFrYVJkTVpmTVpqeVMrekpDalZvdHBlQWpoOTRBYVJGMlFH?=
 =?utf-8?B?SlA5OGZmcTY0bEFXSHZOTE9GUi9DMWFQRmlLTml0TEFMa0NSeXNaS2VtKzd4?=
 =?utf-8?B?WWxyVWtEMTJ4QldKZDkzWGcwYTFzQkc1ZzRRQW4vaTZJN1Y0Y3RBbkxJTFVy?=
 =?utf-8?B?Q1RWSlVPaGNIVUczcU1Qc2g1TzlSU1IzSzBEWkRxdmlTUml5USt5WUpuaVpY?=
 =?utf-8?B?bXEyRUxnN2RiVzNhMzZUbU9GSm9jcUlxYm1Db1JIdzRDWE5XVHBxUDBsTW1t?=
 =?utf-8?B?VmJzdFFhb3c1bVRZZnBJdnpMUzV1WjBaVmVkdDdpYmJLa3hudjJOR1BtaDBR?=
 =?utf-8?B?MTh6MW1ZQmVMLy9VT0RKUmVCL0QrTFVqbTk3b3U0ZlBpMjU5Vks4WTVXS3or?=
 =?utf-8?B?cjR6V1dlYm1IWjJYeTQzSG9BNndSUkI5QkdYS1I0R3ZNdVJxSUJ3cW4wWUgz?=
 =?utf-8?B?Ry9yUDUzTmcyQnA1TFYwanUzWGFIeDE0a0ZJNlV0UTVNSGRNT1Q1Vkt2Y1Jr?=
 =?utf-8?B?eHBya2l2ODl2dFhuY2UvVlpZVVRGUHViQkRmeXh0aHc5T010bjhYRExZKzhx?=
 =?utf-8?B?OGxZYjlXZERZRTVYOHdaMU9PaDc1Z0NRYUIrSWk2TkRPR1RuSTFtcWM3YmxB?=
 =?utf-8?B?SFpHMU5mVkFndnZ2SjI4SkUzZVBDWlhlOGpxM3dDcytKVXhOTHdrYkxKZ1dD?=
 =?utf-8?B?NjhlTkh5TVhtb2lrL0xwMnlFMDZORzViL0FxS1AwbGNOY2t1bmVXeTN4VnV6?=
 =?utf-8?B?VlozWGJCZ3BiVmNuc2xnU214Q1VFekVCbko4VmhFU1lwNTBrSFVJcHRNQ0Y0?=
 =?utf-8?B?Z0pIMHd5R1hNNmdrNTVVWnJUT0NlSUxqaUtBQUE2UTVMWjlaYnVOSm1KeGNv?=
 =?utf-8?B?TUN0dXc3YUU2VUFSc3pabThlR0NCQXU2eEwxWjQ1S2x5WFZpcW1YaWVNY3pV?=
 =?utf-8?B?bU5xeSs2OFBzaHdlWnNna21Kajk0R3NVSTdaTHhmY1Z5MFFlTVI4QXN6Y1hv?=
 =?utf-8?B?c1VNWStXTGZ6YVBSNHJBN29UdktkTWNka29xYjBhMCswV1dyeS9TaTJ1Zm8x?=
 =?utf-8?B?cHA3Q3c2SnNaSlRhUCtZOSt2cGVlaDZQZ3FPSGhndURCNGdYWTlid1FRaXZz?=
 =?utf-8?B?T2UyOTQ2Yll5bjIxRjVUY201Sno3UHFYT29VaitXU0tuUzcxWlBFQmdwbjRU?=
 =?utf-8?B?V2QxMlNuNGpRNEVoMWIzZjdLNUpqVWZxc1VtUFFBWTd6cW1vejJOTnl4VEhN?=
 =?utf-8?B?RUJmY1lZSTJGTFZ4MXpEZWRTVFVVSVpxbGM4QVVLYlFnaHI3ZElEZWpmQmpM?=
 =?utf-8?B?UVJudTVSMG9ySlM0VFBYQ2M5dFQ1MFU3b215OTVtM2xnbFZneUIvaUVTbG9n?=
 =?utf-8?B?enplSEVhbGY2eEI2UTNnKzRDNjBvRThVRmMwK283SlJ1YURPN3RsM01PSXBH?=
 =?utf-8?B?WWYwdE1SNmVSRzBvTEdEUndwRkJMNzdyVzlYZ3Y2eEh4T1BiaWFVK0NHSDNu?=
 =?utf-8?B?Z1FsR2pmY1ZaWlRST3d1SUlISldBMS83UjlXRXdsUFZOV2tYbE90bENvY3dP?=
 =?utf-8?B?QUtiNjMySWFYZU1FbmZURlJwa2IybVZocjl4OVF6SGpQSzdBL0tya2JpTnhi?=
 =?utf-8?B?MEJEL0J4SDFwOW1aVTV1M0QzZ0VrNXU2aGZ3VjlIcjJYalp4VEhGeDd1ZE5t?=
 =?utf-8?B?UVRSeitWZnBKUGFNc21DdHpOSFdsa2JLL2N6ZEJKaEtDODkwcnpYcmdTTi8w?=
 =?utf-8?B?WEFGaUZQTmNCcHBtRWlXOHA3TzZwZTJuTjVKT25HbkllRkJTb0R0dy84S2R2?=
 =?utf-8?B?dm5IYnZOakdFVUJMcFpEbGxNdlI5dWFSTGpFNDZEMHpkYWM3aEdlSmEvUjVl?=
 =?utf-8?B?VjNtR1hYb3hNRmZ4bXM0NUgzMWwvbW1TSDhUdjJLTjRNWUhKSjZnZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31466f30-a95b-4517-ca0d-08de5358a85f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 10:35:38.1908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAcXBVw5KdLUYc031tRX0kpXM9z4peC70qoWN3wmx5AF8R9hARHvT/0zsCQ8cAxc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8228
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

On 1/13/26 22:17, Alex Deucher wrote:
> On Tue, Jan 13, 2026 at 8:57 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Patches #1-#3: Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Comment on patch #4 which also affects patches #5-#26.
> 
> What was your comment on patch 4?  I don't see that reply on the mailing list.

That we didn't used the job because we couldn't allocate memory while in the GPU reset.

We could use GFP_ATOMIC when allocating from the GPU reset IB pool to solve this.

Christian.

> 
> Alex
> 
>>
>> Comment on patch #27 and #28. When #28 comes before #27 then that would potentially solve the issue with #27.
>>
>> Patches #31: Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Patches #32-#40 that looks extremely questionable to me. I've intentionally removed that state from the job because it isn't job dependent and sometimes has inter-job meaning.
>>
>> Patch #41: Absolutely clear NAK! We have exercised that nonsense to the max and I'm clearly against doing that over and over again. Saving the ring content clearly seems to be the saver approach.
>>
>> Regards,
>> Christian.
>>
>> On 1/8/26 15:48, Alex Deucher wrote:
>>> This set contains a number of bug fixes and cleanups for
>>> IB handling that I worked on over the holidays.
>>>
>>> Patches 1-2:
>>> Simple bug fixes.
>>>
>>> Patches 3-26:
>>> Removes the direct submit path for IBs and requires
>>> that all IB submissions use a job structure.  This
>>> greatly simplifies the IB submission code.
>>>
>>> Patches 27-42:
>>> Split IB state setup and ring emission.  This keeps all
>>> of the IB state in the job.  This greatly simplifies
>>> re-emission of non-timed-out jobs after a ring reset and
>>> allows for re-emission multiple times if multiple resets
>>> happen in a row.  It also properly handles the dma fence
>>> error handling for timedout jobs with adapter resets.
>>>
>>> Alex Deucher (42):
>>>   drm/amdgpu/jpeg4.0.3: remove redundant sr-iov check
>>>   drm/amdgpu: fix error handling in ib_schedule()
>>>   drm/amdgpu: add new job ids
>>>   drm/amdgpu/vpe: switch to using job for IBs
>>>   drm/amdgpu/gfx6: switch to using job for IBs
>>>   drm/amdgpu/gfx7: switch to using job for IBs
>>>   drm/amdgpu/gfx8: switch to using job for IBs
>>>   drm/amdgpu/gfx9: switch to using job for IBs
>>>   drm/amdgpu/gfx9.4.2: switch to using job for IBs
>>>   drm/amdgpu/gfx9.4.3: switch to using job for IBs
>>>   drm/amdgpu/gfx10: switch to using job for IBs
>>>   drm/amdgpu/gfx11: switch to using job for IBs
>>>   drm/amdgpu/gfx12: switch to using job for IBs
>>>   drm/amdgpu/gfx12.1: switch to using job for IBs
>>>   drm/amdgpu/si_dma: switch to using job for IBs
>>>   drm/amdgpu/cik_sdma: switch to using job for IBs
>>>   drm/amdgpu/sdma2.4: switch to using job for IBs
>>>   drm/amdgpu/sdma3: switch to using job for IBs
>>>   drm/amdgpu/sdma4: switch to using job for IBs
>>>   drm/amdgpu/sdma4.4.2: switch to using job for IBs
>>>   drm/amdgpu/sdma5: switch to using job for IBs
>>>   drm/amdgpu/sdma5.2: switch to using job for IBs
>>>   drm/amdgpu/sdma6: switch to using job for IBs
>>>   drm/amdgpu/sdma7: switch to using job for IBs
>>>   drm/amdgpu/sdma7.1: switch to using job for IBs
>>>   drm/amdgpu: require a job to schedule an IB
>>>   drm/amdgpu: mark fences with errors before ring reset
>>>   drm/amdgpu: rename amdgpu_fence_driver_guilty_force_completion()
>>>   drm/amdgpu: don't call drm_sched_stop/start() in asic reset
>>>   drm/amdgpu: drop drm_sched_increase_karma()
>>>   drm/amdgpu: plumb timedout fence through to force completion
>>>   drm/amdgpu: change function signature for emit_pipeline_sync()
>>>   drm/amdgpu: drop extra parameter for vm_flush
>>>   drm/amdgpu: move need_ctx_switch into amdgpu_job
>>>   drm/amdgpu: store vm flush state in amdgpu_job
>>>   drm/amdgpu: split fence init and emit logic
>>>   drm/amdgpu: split vm flush and vm flush emit logic
>>>   drm/amdgpu: split ib schedule and ib emit logic
>>>   drm/amdgpu: move drm sched stop/start into amdgpu_job_timedout()
>>>   drm/amdgpu: add an all_instance_rings_reset ring flag
>>>   drm/amdgpu: rework reset reemit handling
>>>   drm/amdgpu: simplify per queue reset code
>>>
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  13 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 136 +++------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      | 289 ++++++++++----------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  40 ++-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  13 +
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  67 -----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  37 +--
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |   2 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  21 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 141 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c     |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c       |  36 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c      |  41 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c      |  33 ++-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  28 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       |  30 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       | 143 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       | 149 +++++-----
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c     |  26 +-
>>>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c     |  38 +--
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c      |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c    |   6 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c    |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  43 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c      |  46 ++--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c      |  45 +--
>>>  drivers/gpu/drm/amd/amdgpu/si_dma.c         |  34 ++-
>>>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       |   8 +-
>>>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c       |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c       |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c       |   2 +
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c     |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c     |   3 +-
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>>>  54 files changed, 952 insertions(+), 966 deletions(-)
>>>
>>

