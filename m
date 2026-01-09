Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FE5D1A631
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 14:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F0410E114;
	Fri,  9 Jan 2026 14:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ezu2Vy6S";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 622FC10E114
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 14:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIYhO6nI+f9yTu83fo2dRSE2bheWJR0HHSxXIa+oahJEcz/yGoZV19Fb51wO6UV5fSw5a4pmfkeyUJFWbM4shjknrljSjjtrdQxadaayXpGdG7YZYmcpSV1aFfaSOgwB9fmr/qQ7oVc2Kh8VAyYHN7G2XWEmLYIIL2fyO2wQliGkLHOI5KqkMOOsgHkuLNeLM9PhwLcTuXrHibn3+vRiIDuG+gmFAGl2FFaMmqbg1jDgMo6h/ZG216H9YR9KFNWRW/jkcigV+ABbu4w78FD2uLD/ROSgPlxPcPYW0dLNMuHSrBNTaZRXm/aWoKGQgcpuB5/jS7l+68AiQKU8q6tNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM0rrV6/oESIFH6rLI7yQfR7ZIGYVd8UJlU/2y8itCY=;
 b=WBj+aSUPEs7Nv1aTZ/qf2fN3gReGXigknudMapqq9jtTKcJ//TNVNfM1vPnufzaYwMmijybb9pWYmvGxf9cen75uF3lpKGAZJYM55tVUP8fXTW2V1NLPFbYvXZacsBBJia9sMgm6nvo4G31mjZwj7gvX8/lvFrksm90AaMURBKldCo6vXoOeBKZajuu5Zvh+v7KwA3hfzPPL3yNrb35H3zPpUKEefljzyIycLOqmmIpUdgdXfKWBz7PjSpaBIx1PLX8YrowjgaXA7aa7/Td8V4AzQdFpDqVx2Ve4LTDXe3TmR6R/Fu0QEcrDzSxREAClcXk01+VPARbduVCmAUrCrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM0rrV6/oESIFH6rLI7yQfR7ZIGYVd8UJlU/2y8itCY=;
 b=Ezu2Vy6SlGKDI3dOlkzVrywCoyZ1vNChhHKUCUfOeV6jFVl+VF8+KpqtygbZxH26ay7dAgqCzQDdYKKuCBZBx/gBpGBM0JPvbm7E++ryIVoJVXvoistz8P6a2AakRszmPTFo8oYSSMnosUvH8Snxm9fsuNtZdnJqQCJ8z6gz/qg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB7485.namprd12.prod.outlook.com (2603:10b6:510:1e9::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 14:03:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 14:03:29 +0000
Message-ID: <2c966fcd-3a07-4cb6-a88c-a5655d5ab33b@amd.com>
Date: Fri, 9 Jan 2026 15:03:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] drm/amdgpu: Consolidate ctx put
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
 <20260109133314.88548-9-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260109133314.88548-9-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:e1::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB7485:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8b142f-7b6b-46f4-8d7d-08de4f87ddee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0xCdWZyMXdQNTlzTG0yOXZUVWNxOGIxU1pYbWV4c0tIRzdhQjJPNHlteUdF?=
 =?utf-8?B?UjBydEFXaktKb0pHbFRYSGFmN3NRSkQ2b0V5U1pFc2VRdTYyc21kUXprU0Js?=
 =?utf-8?B?cDR4R085cDd3ZXdIY0NiM2haOFArN0tIOHV4YW5QMkoyYjVyTU9DMGtkcjRj?=
 =?utf-8?B?WjYwTzFFa0hyU1E4aVIwMTFhL3c1cnptdnhYMlowR3NGdk9kVmNjSjM2T0NE?=
 =?utf-8?B?SUFxZHN3b3pvcjNVOVVtdzFuUnQ4WmY5TU9wVGRPTzN2dEdhUjgxWTNNWnl3?=
 =?utf-8?B?dnNpL0JHY2x6bSs3bHNXSEE0SUYzVWJ2K3c5QlN3cXpmSUkvNGhxS1NuK0xO?=
 =?utf-8?B?bEJuZzUvS296QUJZT3hHamVibWFXSVRXMTZRSy9MZU9RVHpjTHRDcDhOVmth?=
 =?utf-8?B?RXlCTWtXeUxFU05kV1d5NmhTTEpSU1BBdlZiblJ3M0hRVmJHMWdsa0s3UkQ4?=
 =?utf-8?B?YnI0dTVLRFkzKzR0Z3kyUEdsN1hEYkhPLzdiclVSTTFVeGFodzJVbG94SXdx?=
 =?utf-8?B?R0tYVmUvZXA5SkM0ejJFZ1JZcTJBWmc0eXI0eUZHOTgvVVp2U09GRlo4dXF2?=
 =?utf-8?B?djZEKy9tK1FvS1BzMTN5UXcrNEFHV2tDQWloY050eDNXTDZYSGZqQ00yZzVt?=
 =?utf-8?B?RnRsaHVGUVVKd1ZiM2x0cDhGa0pBbkVVcWU3Sm05TEV4TUgrWnhIQk4xeG1t?=
 =?utf-8?B?OTlQTVUwcWs0TlRzY3pTajNvRXp0WVdZMkFmVitYcFV3bkdSR2ZjKzNxaVhE?=
 =?utf-8?B?UmRRSGg5LzB3QVBTdGZpdGZUVjcwNGg2U3pVOWVXQjRnQm5JQzJkbzNUVzJs?=
 =?utf-8?B?YWVJbTI2ajBqMFJEVVhFYmZOMG15bE1MWUdVbGZuNTZmNHdscU9abTVFcWNr?=
 =?utf-8?B?YVlyZFJwY3gvZVJreExJMWVucWVtN2s3Rkp2Mk9kU3djaldDVllRMXg2NmE5?=
 =?utf-8?B?dmY1cVU4cDA0L0hJNlFINy9qeXhiSUFXZjd2ZmtqOXFBVHJYcnJQSFphVktT?=
 =?utf-8?B?ejRSNld0bkRnRFlhRXN0dmg4K0RET1AxWUZ1dHVqV0JEaEo2YnFhaGd5VXBx?=
 =?utf-8?B?ZVdSWWRzOGlHZHV5a3E2ZDZ1SEdta0NUNk8wL3pMVUFHMUFNSVlXenpLYzcv?=
 =?utf-8?B?Z3NVM2ZCOGhxZTM2ZVpkdkdaMGRUbkFrNytKa1BlV0FIZkdiTHp1SnVnVWc2?=
 =?utf-8?B?NC9HYUZVbmtWVlN5akJrQUZwZms1QTdnclJLSFFpYU8wTHNRdW5hQW52aWFl?=
 =?utf-8?B?R2U4WDh2MUxuZlIwNW5JK0dRZmR0SUhwSHdwM29CUThMN2JkSVF0d1FuMXB4?=
 =?utf-8?B?Vi9oRmpMWkdtT2w1UGVTOGY1MmUycmJYNXY0UWluL2x1Z3o2R3dqRmtLUUdS?=
 =?utf-8?B?RW5GdTAvZzh4STgyV1FiTDRBU09tS09RaGsrTkMyUEtacW5palM4bFE3bjBr?=
 =?utf-8?B?eWV1NzZKUys0cG12ZFB1NXM4ZGVxUTFCSVRGMFNIQUp4RVc5cWR1ZVE0TVc4?=
 =?utf-8?B?VHBQOXViWis2TitPaUhVNjlGdG82OEdHU2ZIcytpOGxMOGRMQUkvWk5FZk5D?=
 =?utf-8?B?S0k3R2NtYUljZk9uU0JKMVZVMUt3WE1kT0Y5ekV1eUI3NWRIaVQxUFh4a3Na?=
 =?utf-8?B?OEtSTUFWVDhXcDRudm5UNXVoMTR3cE9GSVM4SHZvd01vREdmYzVLbnllMTJ3?=
 =?utf-8?B?Ym54dXVNYVk1c3REamR0U3pDNUQ1azNBR2FIbUhwM2NzNDVUUDlLazNra09U?=
 =?utf-8?B?eGV6LzNnSEJ2blpnQlVvRnlSdHlyYmJZQ0hjVHdsN1g5OVJlVEs2bVBhR1FS?=
 =?utf-8?B?cUdldTRkWWE5dEtsNS83Vkx2eDNPa0FhMzJGRmF3alEvbS9yYjFMZGRGWUlk?=
 =?utf-8?B?UnBRZW5TNm1hNEVWKzJ3bTFlR3h3blJ3bkpFMk1mczBza0JtQVNyQU5YUFJn?=
 =?utf-8?Q?jVeluW/6bR5pUy/SwNq8+/Cthxn32RBZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUNiQmkva2pDcmxha0xCZjcyaG50U1JNNEJNVmQrWFVXOUNzSFB5cy9iZWxm?=
 =?utf-8?B?TE9KZm5zYy92b0NJa2NlVEFpV0E1U05xQk5EU3BuSUM4UHRYT3Nhczl1V3NG?=
 =?utf-8?B?OTI0SHVNQ3krQ2hTTEFjem01dTNkcjJrTHY3OEpucTdWRUw5enY4ak9VeVM3?=
 =?utf-8?B?c2x2RThldkJFdm5hSm9tU0x2QnVGMzZJSHpFbEFEcHVERmZKNXBrR0VaaGJY?=
 =?utf-8?B?YXVncVNnbVpxYU5jM0lNRld5WTMvK2kyVHgyZ0tqK2ZMNzRraGdESEJVUTVE?=
 =?utf-8?B?QkpsZ1hvWGN2YlVpNTdPa1p0NUF6T01DazVFMi82N01XdjRnZ2Nkb0VRbmRL?=
 =?utf-8?B?VWI3YW9wOFpZNWk2dDZieWVuMUFmdjZOa2tqdVJ1cWNSRVlLMU96N2dUeXBL?=
 =?utf-8?B?NUs0Y1NwaWIrYmg4bGtMRTFlWnlvZ2NFdzVwUDN2Rmx0MTFScy9rdk5YVjF0?=
 =?utf-8?B?SVRWMTNSaXM1R3Nrd3NnSDVKeks1NEFSS3lzSkNPaXdoZkt6cEpIcExrd1VI?=
 =?utf-8?B?MXg4V053TURrSllBNHlJbTRSa1ArK3FabGUwWkYvdk1YOTBtR3pGZEdXc2dm?=
 =?utf-8?B?bkZHZVdKZVYxdWJOWTAwWnFJY2NWWTR6QjlhYmxJQjNSTFlkaHowOWFZclhr?=
 =?utf-8?B?VXJUV2YrZ2NOdmg3MGFrV1NaY3VSTWNRL2kyQUJzeUY1NGZ1a2RvR3dGdGN3?=
 =?utf-8?B?cGJ5UVdrZm9xQjlCeEM0YkZUUExEdnZMVWNHNlNkS2Q0VkxiV1Z1VFRuU09H?=
 =?utf-8?B?REJyVzJpRVE4V255VjFLVTFCVW96TUZQZ0p4aFA1ZmpPUHJJS1NDSE9jODFL?=
 =?utf-8?B?MFp4NzF0dm8zNWk4b2lwQ1V5V3dOeGJYSDJNZXAvS1lKalIvQ29VRzcwTFBt?=
 =?utf-8?B?YTNMMVRTaEZ6VGF1Qm84THlGVkRlL0NXdWZGVURTV1dOcG5GY25jbUhINEQr?=
 =?utf-8?B?a3FXTnBjcFQ1RitXb3hVRC9NY0p1RFR6Q3RWKytKSGI4OW1mQjNRd1hpU2xO?=
 =?utf-8?B?UnQ1ZG5KTVoxbWloMlE4UEJhc0R4aXFjK0p5dHFRNmdhQkFZNFQ3TVNGbFVa?=
 =?utf-8?B?c3FkUGlSckpFL2o1c1NXTmdQbVN5Lzh6ODNzSnU5bWFQV3pTSjdqaWJ6ZFIr?=
 =?utf-8?B?RjBSdy9rb1BqUDVpRXd2UkcwKzBLNnZ1WnY1c3FsWEl1alpNN1Jhajd1TnJn?=
 =?utf-8?B?RHVqcFZ3ZTNWeDBiaGE2T3FYOE1OTWxLV0dIUGxVUGFYb3dvNjkvdU91QlN2?=
 =?utf-8?B?RmhEbUNKYW1HN1lyTTBsMHJQb1JoaXpnOENQWlk5cjdWS3UzSlBNZ25leTdm?=
 =?utf-8?B?VXBSdlljT2xLbEFBeERqUVR1cmtZeUdPcUljYU5PTVlFSFF2WE9wci9jQjdG?=
 =?utf-8?B?RnZwdGpyaUFMUFRpZDdyeCtoQURyTU0raWZBWmtON1YyenZzN0pDOGJQS1hs?=
 =?utf-8?B?RWFDQUlKUGVGV3dtMGZvLzJ0a1MweFhHQjUycUx2VXB4dG1TL2s4SWp2Y2Zl?=
 =?utf-8?B?ZkIrbnRBZldheFNGZklKbTZTQTlYc2grUDdPSUhqeGYzNGxEY2ovNysxR0Ix?=
 =?utf-8?B?YU9od3dEdGZvaHE5Q0FLSG5QZi9NcDYraURPRXhmN1BGNFM0bWVGTVhsM1Bj?=
 =?utf-8?B?QS9QRGo2YlJ6VExPUHdMbnUxbDduRzlTNkFFeXo0Y0x1VUZZeUZNUW83VndI?=
 =?utf-8?B?V1FNdVdkZ292VmNBVkU2ZWpWNyt1ZFV6bVI2c2ZVMDJYZVVBcjN5L0N6dTJ4?=
 =?utf-8?B?MjltR3liTHRkU0pzaklSVkh2Z3p1WkRrTGJObDl3R3g2b29jUENHdCtuSkhS?=
 =?utf-8?B?NWpsUEI4TU53Ym9QRUxPM0tBVGJFNnF0RUtTeURMWi8wa3l3a1BPUWJCT1Z4?=
 =?utf-8?B?ZzNaeFAzSGNnYUZYU2xySnZ0clJCR0NrYzcyT2M1MVlGUVZVN3pkZStUc2xa?=
 =?utf-8?B?L3RvV3dFZHBTUENzbUhKSXdkQzBsakVvRnkyTWZCdlphbnJmRko0YWlONjFr?=
 =?utf-8?B?YkZsQlk0OHVKTVAzNWZudmV6RlhCeUdLeFo5ZStJcWVkRndSNUxKMFB2MW02?=
 =?utf-8?B?c0htN0liOG41WjBCc3ZHMGNiOGx3dndmUXIwekRBMjJJVEVkZlZFVDVUWTEw?=
 =?utf-8?B?RmtnSTlKS29VeU1tSXJmMXUzazc5azgxcGltQk9EcmNWeGIvMXZTY3RkMllM?=
 =?utf-8?B?cTZ4OCs1Q3pGRytrV2l1RlR0WDZtNGk1RnBNWGRaclQ2c09YM3poTGJ5YUJh?=
 =?utf-8?B?dTZNYnMzajhqb3F4ZnZnYUh0WjJYNmZVOHRqZUFyRzBEQURoSHRvS0hqUXRq?=
 =?utf-8?Q?8Q975pDIJNf9cuEB1r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8b142f-7b6b-46f4-8d7d-08de4f87ddee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 14:03:29.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjgdxe94P+27YJyL4QUqxlhes9VXh4L4o2UpNs4TyfhjL3JWMWJUspS6CyRkZ/kK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7485
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

On 1/9/26 14:33, Tvrtko Ursulin wrote:
> Currently there are two flavours of the context reference count
> destructor:
> 
>  - amdgpu_ctx_do_release(), used from kref_put from places where the code
>    thinks context may have been used, or is in active use, and;
>  - amdgpu_ctx_fini(), used when code is sure context entities have already
>    been idled.
> 
> Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
> and destroyed the scheduler entities, we can consolidate the two into a
> single function.
> 
> Functional difference is that now drm_sched_entity_destroy() is called on
> context manager shutdown (file close), where previously it was
> drm_sched_entity_fini(). But the former is a superset of the latter, and
> during file close the flush method is also called, which calls
> drm_sched_entity_flush(), which is also called by
> drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
> used entity, or flush it twice, there is actually no functional change.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
> v2:
>  * Use separate variable for drm_dev_enter for readability.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 99 +++++++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  9 ++-
>  2 files changed, 36 insertions(+), 72 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index fb3f1f22a3f5..0e02fc624cd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -274,26 +274,6 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
>  	return r;
>  }
>  
> -static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
> -				  struct amdgpu_ctx_entity *entity)
> -{
> -	ktime_t res = ns_to_ktime(0);
> -	int i;
> -
> -	if (!entity)
> -		return res;
> -
> -	for (i = 0; i < amdgpu_sched_jobs; ++i) {
> -		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
> -		dma_fence_put(entity->fences[i]);
> -	}
> -
> -	amdgpu_xcp_release_sched(adev, entity);
> -
> -	kfree(entity);
> -	return res;
> -}
> -

Thinking more about it it probably better to keep this function separated even when it is only used once, e.g. just to have amdgpu_ctx_init_entity() and amdgpu_ctx_fini_entity() properly paired.

Apart from that looks good to me.

Regards,
Christian.

>  static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
>  					u32 *stable_pstate)
>  {
> @@ -408,22 +388,41 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_fini(struct kref *ref)
> +void amdgpu_ctx_fini(struct kref *ref)
>  {
>  	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
>  	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
>  	struct amdgpu_device *adev = mgr->adev;
> -	unsigned i, j, idx;
> +	int i, j, k, idx;
>  
>  	if (!adev)
>  		return;
>  
>  	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
>  		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
> -			ktime_t spend;
> +			struct amdgpu_ctx_entity *entity = ctx->entities[i][j];
> +			ktime_t t = ns_to_ktime(0);
>  
> -			spend = amdgpu_ctx_fini_entity(adev, ctx->entities[i][j]);
> -			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
> +			if (!entity)
> +				continue;
> +
> +			drm_sched_entity_destroy(&entity->entity);
> +
> +			for (k = 0; k < amdgpu_sched_jobs; k++) {
> +				struct dma_fence *fence = entity->fences[k];
> +
> +				if (!fence)
> +					continue;
> +
> +				t = ktime_add(t, amdgpu_ctx_fence_time(fence));
> +				dma_fence_put(fence);
> +			}
> +
> +			amdgpu_xcp_release_sched(adev, entity);
> +
> +			kfree(entity);
> +
> +			atomic64_add(ktime_to_ns(t), &mgr->time_spend[i]);
>  		}
>  	}
>  
> @@ -507,24 +506,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> -static void amdgpu_ctx_do_release(struct kref *ref)
> -{
> -	struct amdgpu_ctx *ctx;
> -	u32 i, j;
> -
> -	ctx = container_of(ref, struct amdgpu_ctx, refcount);
> -	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -			if (!ctx->entities[i][j])
> -				continue;
> -
> -			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
> -		}
> -	}
> -
> -	amdgpu_ctx_fini(ref);
> -}
> -
>  static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  {
>  	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
> @@ -532,8 +513,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
>  
>  	mutex_lock(&mgr->lock);
>  	ctx = idr_remove(&mgr->ctx_handles, id);
> -	if (ctx)
> -		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> +	amdgpu_ctx_put(ctx);
>  	mutex_unlock(&mgr->lock);
>  	return ctx ? 0 : -EINVAL;
>  }
> @@ -749,15 +729,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
>  	return ctx;
>  }
>  
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> -{
> -	if (ctx == NULL)
> -		return -EINVAL;
> -
> -	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
> -	return 0;
> -}
> -
>  uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
>  			      struct drm_sched_entity *entity,
>  			      struct dma_fence *fence)
> @@ -926,29 +897,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
>  static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
>  {
>  	struct amdgpu_ctx *ctx;
> -	struct idr *idp;
> -	uint32_t id, i, j;
> +	uint32_t id;
>  
> -	idp = &mgr->ctx_handles;
> -
> -	idr_for_each_entry(idp, ctx, id) {
> +	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
>  		if (kref_read(&ctx->refcount) != 1) {
>  			DRM_ERROR("ctx %p is still alive\n", ctx);
>  			continue;
>  		}
>  
> -		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
> -			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
> -				struct drm_sched_entity *entity;
> -
> -				if (!ctx->entities[i][j])
> -					continue;
> -
> -				entity = &ctx->entities[i][j]->entity;
> -				drm_sched_entity_fini(entity);
> -			}
> -		}
> -		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +		amdgpu_ctx_put(ctx);
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index cf8d700a22fe..b1fa7fe74569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
>  extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
>  
>  struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
> -int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
> +
> +void amdgpu_ctx_fini(struct kref *kref);
> +
> +static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
> +{
> +	if (ctx)
> +		kref_put(&ctx->refcount, amdgpu_ctx_fini);
> +}
>  
>  int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
>  			  u32 ring, struct drm_sched_entity **entity);

