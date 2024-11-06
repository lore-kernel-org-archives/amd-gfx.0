Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A2D59F40
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 15:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A348E10E1D2;
	Wed,  6 Nov 2024 15:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xa8TWVnk";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98DF10E1D2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 15:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=skP+pdcYaeDIfsZnIJVqruCMBAIj9+Ns/xB7gcsAStwN72hIXGxK36E4yVKJfAE7RWNQXOZ+QRquWQ/cveva598UZiZ+rHcuaTpumnPIjPScoy0JpHwJ2JU7jWJfanSPuQsGznt3S0gUblx1z5jyuBRPvt1n2iJOMijPpmbV2mk3qM9rJeIjXVrdvEmM6UIvYXuP7d4uhRmJ/0u8THrLKIdX2hRRxoOdNzdP1yt6AngdL6nAb/9WpPKZ1CS0Inm2ZEUrwZEkADTfzq3d3kpDcs8Fn5As2kPaPlmb4DIgMzWdeYlnh9Zn1H68YMGI1b/a96rZCdUHqNEmQJ5spsmUrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5JSiaUrpz4pE88JgP9XCD3d1HDFTvfc263fZUfv9ro=;
 b=i5ciwW/D8QI0OveYZBAKi9mvYdnA0kF2irbJWRy4dDF4gk2ECPiXH1GrUqvo5DJ8B6jcO3fGREiJnEhTkgtVRw7iuIepBwvGBqp7NESl/9rEZsfIb9qYhJbv5z8ssLo4QsonZJ9ijXI8Bh6xL+ZtXhXuOMkdd+17r/ZumALRi6nI8TGVXXGyvDFLHWPshSj6rPe+NBBblgQup9UDTo7/tVYFQ1v1gxf5gLLyq5/UxQIxMkWgDwA/sCBvYcH1xDHllt0mO0aFeYHDi6BV3cRESuB039zH01HFXg6HL0nfytV+MWRobnNpRwAF9Tv5qIvpQLt+8I1YABZfO1Lh/iihUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5JSiaUrpz4pE88JgP9XCD3d1HDFTvfc263fZUfv9ro=;
 b=Xa8TWVnkJpdJkiY6nZwXz9Hjx0N2+8oHLBMOM6HCR1m4aJxAeYvaIQh0XR6IgHBtrYctEZqjDlQqp8pDuLKxyHixYGSBtTbiGZLkLoubuImuX83rTOaWUbcitB7bOOT6xETdu7gzsLMlaEXnfTZWaf29L/SNZtPqUlavPtmMTpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 15:50:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 15:50:25 +0000
Content-Type: multipart/alternative;
 boundary="------------q00PUigDf9sPBdmbuh056ZUK"
Message-ID: <228fa4cd-1e2d-40f6-8c63-15a9d6f90a04@amd.com>
Date: Wed, 6 Nov 2024 16:50:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Bypass resizing bars for PVH dom0
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20241105060531.3503788-1-Jiqian.Chen@amd.com>
 <20241105060531.3503788-3-Jiqian.Chen@amd.com>
 <e6dd8f17-2322-4fd7-bdcd-861e77fcfc8a@gmail.com>
 <BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: cb71beb1-8541-478e-17df-08dcfe7aba9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d1dMYVgyVVJ2dHREQXBRYjJzd0JKSS9yVUtjOWk0UGJWSXJWbTEram90dzM4?=
 =?utf-8?B?dXVJR002aWM4WjNWcGJtSmROSlF6SHIzNkl1bnlPSGY2ejRNWU41VlMyODQw?=
 =?utf-8?B?ZEU1dFg1N2FsQVlnV0NMOEoxSU0zY1lVRmFQQW1reFJ6V1FBV2s1ZUIvaG4r?=
 =?utf-8?B?K1hmbUdSUEZwZUdBcmtyZ011dXJnZ2ZSb0lLMktkdk1oUU1JWmtNUTl4cTQw?=
 =?utf-8?B?cHpwVjFreCtrQ3ZwOUhPWVlsd3VEZHNoSzZleC9XOTlFZWhxZk1BaDFlakNz?=
 =?utf-8?B?eGpkckhrYWFRZ3JDZllsWDJpK2MveERFM0NSbnZpZnp5TjFpZ09iQ3kxS01U?=
 =?utf-8?B?Zzl5anBoVmhnbFBoTlBTS1BvUXpVa0hoOFp1SW5jWWxwMkxKS25Sd0VUYmhO?=
 =?utf-8?B?SzlaWVpCNGtKbHdFUkRicFBzNWM0NzBDVmN0NzFYZzBTKzJtOXdGSUlMaFM4?=
 =?utf-8?B?OUZLaDBWa2xYZm1uWVYwaFRheUV3VVIwL0pwZTRRNlVYV1MwM0twbnE4TUgx?=
 =?utf-8?B?WGFsRVJ4Z1FHR1BVUWluaVhPUHBEVkhOL2FPUTI5NjFRK3BMeFpET3dkdHAx?=
 =?utf-8?B?UEdKdlNzNnJ5c0ZqMG9WdzlUckQrVDhLekNuK0RHZy9IWHJBRUtqUGx4VHhY?=
 =?utf-8?B?Z29qRStMZGd5dWRvWHdVWGNuUE5xZkptbHNlMDFaalhNcG9vQmxqZTk5a0I3?=
 =?utf-8?B?bncxdENNc3ZxK05LN2hKcTMvL2ZXWGo0bjVzYzJwY2doa0l1bjZhNDVoVDNT?=
 =?utf-8?B?enM0eGpFc1o0TkRHeVVLMys5dWRXZ2owOVhpbmMyOEUzMGhzOXJqdkxRWU1I?=
 =?utf-8?B?Q0lOdm1mbmdtVU1oQnJkQ2hGY2JaT2haSVRDUW1CSnlUeEdad3lQZE5BZitj?=
 =?utf-8?B?MTU0OTNuWnlFY00vRGpxT250NEc1MGg1Vm56cXUvWTVweHQzR3IrSEZjZUtj?=
 =?utf-8?B?NTdSZk4yRDYxUTNjRXdic1JYSU9KRU1hcTdTQ01LYlVOaTgxdDRXR0RvSHBJ?=
 =?utf-8?B?TGVONzBxSmJQMjlUQ1AyRGswQVNoZm93enV4bHQxZnQzeXk0M2hFb3UrZEI2?=
 =?utf-8?B?WkwyQmt6VllCVDJaVmc4U2EwOFZYMkRFYVJNZ0VBUlB6d0ZUaytPQWpnM2d2?=
 =?utf-8?B?aFgyaW5Za2UzV2Z4MlFwKzRnSFcwQVZXanJ5TGhySHBaYU1KbUFrdTdEaHZp?=
 =?utf-8?B?a1dURnN5cGRpYjk3YXZ0TStUVTF1VGRHVzRvOFZVTHpjdFR1U2xhOVhXeGla?=
 =?utf-8?B?blg2M1JuV1Z5blVzNFhVUEZLNlRLTGtjRzFLejhOcm03YksyR0xFOEpuWi85?=
 =?utf-8?B?WTN1TVZYL0dGZlMrYnAvS2lIUEVJMndlWlQxYUZQMDYwUmNid2JkQUlsWXZB?=
 =?utf-8?B?WjhjSmxWc0VweEZFak5rUk16WWtHQjdtTFFUWncwaEVFRlAwZXdDMWltWG1G?=
 =?utf-8?B?MmVya255SzFSMkUxOG16ckEyZngxbHBjSkk4RGlwNkhRSzJHbDl5N1BSS3FO?=
 =?utf-8?B?N3dTTXZDY1p2a1U1S0IxaUkvdndsaHEweDJUeFIrbzNsblNYeFRpK2M0NXFu?=
 =?utf-8?B?SWFVTnM3eExZN0dKZjUrdVlwdjBnUXNnT040VDdlaVh5MEZYSVMwVzlKNjRw?=
 =?utf-8?B?RjZiOEhMUUJTSzNLdE1nMFFkb3BIRXh4MXo2NlNOYm1CWFFGcUpJYUZqcUM2?=
 =?utf-8?B?Qitqbml1K2RuUTFRa0l4WWtQQ1lLU2ZIYWtRanhnalkxU1RmQlpSZEJvUURF?=
 =?utf-8?Q?PO9lgB73H4k1bXReWlgApZ4BIw2C4kadl5Rfici?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJHR2U4cUxuRjY5aGNEMkt2cHQ2VzI2b3FPcENGYmo4cmtMZVdvN0xKT1dS?=
 =?utf-8?B?Uzd0T2Fza3R5ZXFCQnliK2FuUHQ5dzEvY0FQbXRnREpKVVFmRFRET1oyajlR?=
 =?utf-8?B?TVlybEFabk5WT2tOMGlCS2kyUllPUlpwVCtLcTI1Y0l6UU5iZHFvMjd3Qzlt?=
 =?utf-8?B?d2NCY01MbXlGalRGVzJkUzIvR0w1WlBFTVE3OEdOTUNORmtJcmFhZVpUYkVm?=
 =?utf-8?B?aHM5MEloejN4RHFRamNnWEhuaUVWaFNvOStZRk8yK3VSQ3RwRDJOeHpZemFF?=
 =?utf-8?B?S1d1L0hNSTBXWWltQUNjUyswSG5hSGZVMXV0b2Z6WUNXTTdnQTRwWFd4VXly?=
 =?utf-8?B?NnFSWk9qUmg2U3hLaTBCWG9oUE82aXJzV2RQd3hkU1RZSm40TUErVG4zeldr?=
 =?utf-8?B?S2F4N2ltVEU0UVozSmFOWmN6L0luL0Y2cU1GVkp2aUtYaHZ4S1cvSU1LY0di?=
 =?utf-8?B?S2NhOFZIU2l3WUF2QmF2dG1Qdk5sWDU1SE93TjlVUkF6UUFNaUJpR3RkeEhk?=
 =?utf-8?B?c3RnWEJSekZXTnpuMHlJQk5ZQytWUC9MN2VFaGRic01IYkxVMzBIRjc2cmNS?=
 =?utf-8?B?c1dXdHlYc1gvL0lHcmJmWXhERmNPUDRZUUlQNHpHN2F1VUo3NlF1QlJGSnh1?=
 =?utf-8?B?U2RTSGdaOFRqT3VQZzFkUEZTazJTU2plaGgwUWhjbGhCeFlSdHluRk9MdWo3?=
 =?utf-8?B?UEFYSFNzTU5mYnU5cDc4RGJrYVoxZlJQdXNTSnJ1bENyaHdQQVNFWjgzb25s?=
 =?utf-8?B?YlJBTnNtRDhSM3QyaytDVGNFbzRnZ21ZQWZndWVxLy9ScXVoZ0VweEIzRU5m?=
 =?utf-8?B?bkdpZWhFTHczLzZ2QUdPRHJ2azFrbTJmZUIxNzZxZ1REMDFHMVFocm8yem1C?=
 =?utf-8?B?VjlGQjJqRkFwQXR6Vmh2SFFTV2F2RnVBVWxpMnYwdEtlMkhDTXpLd3lDYUUw?=
 =?utf-8?B?M2U5eVF3NWhrV1NUK1p3RUZjV2ZkbUFKS1ZnQTJ6MkpCUFBKNVNEakM4dDlX?=
 =?utf-8?B?RVIwSHNBVUNoZkJ1VXJ2cmVHN2d4d3B6Mm9scTJxcW5oNTFHR2pRMTd4SUcy?=
 =?utf-8?B?dXBnVFpYSE5BbmdiMXhQaG5MRDRsQVhTeDdtMTBXT2hpZjhMQVAxUmtSZUJO?=
 =?utf-8?B?cCtiN3NMQUxXNVVUSU1KVzIxM291WklOeWxlQmhWaHpvNFo5WXFwaEc2c1oy?=
 =?utf-8?B?ZnlaUWlGNnhhUHByaW5USkp2UmNpdDA4ZG51SjB4cWR4U2ZpaUZ3amtVa0pX?=
 =?utf-8?B?enQ2N0VzZTdqQ3RxTEVINDAzOXM0RnUwZEF0KzRrZjJqNGRHbHJ1aERJTkRN?=
 =?utf-8?B?MWV3bzBuQS84ejkxNVpla1JxaEx5UUtSWkt3MnZvRERxQ0piRGQyUHE1Tmp5?=
 =?utf-8?B?eWcvQmVONFI0YUwzYTBjYXYwS3lCVmlDWGhGMEg3YzhhdFJoWUlza3BqZ0dF?=
 =?utf-8?B?cEVTRURHOUZFVW9sY2NzUGNsODUxTU5OSmo0U1FBZlZPS210RmJYek1HeDYr?=
 =?utf-8?B?cm1OWDJXREpNMG53ZUR1Yk01dXJ0eGlHWnpYaEoxWHBXV05pU0hhc0hVVXRj?=
 =?utf-8?B?bExSMzRpeGwrN0RzRUxnd0g5azd0RTVyRHRRcGFqaUE5U2w3emtrL1JQNW9Z?=
 =?utf-8?B?K2dXT2xnalV4VEZWYWZQTjdPYjhIK1RmT2p4U0dFekRBNmZuS0tJVWRnNGkw?=
 =?utf-8?B?NXVxSzZLMGpwaUd1T3JVUERmYVBsQmp3cnZzSTk2elVzQVhHMERYRDFKMm1C?=
 =?utf-8?B?TFcwNFNvZ3JoazlFZWtscUNWUHpuczRkMW8yNGdaS1NkSFJ1UVF5ZENhMmZ6?=
 =?utf-8?B?RHpVd1h0K2VJc0p1eGtVQzR5WWZYY3Y1aFJRSit0UjFWenViZ3dxVkt4NXpZ?=
 =?utf-8?B?QjFYNThGb1VwS0NadEdRUXZQaXI0djZHcjIvTU9VVS9FTHQ2b1BLY1dpVkZx?=
 =?utf-8?B?czE4WE9qeVFhQzBoeVYxa053YW0vWXdYUHJ2RXFqNSs0b2VaUmdiR1lxNjc4?=
 =?utf-8?B?VCt6L2E5SmEyd09YYUM1QnFIbGZEZjZoVm51SXdBWllIQUV1TGJJWGVnbmdE?=
 =?utf-8?B?RU44NFhiZUt3MGlISTRNcXJEL3VDTGpVcmhVdGFxQTJuWmdGeHpYakd2czhw?=
 =?utf-8?Q?8gK8+JFrDSug/F6020GNa4do7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb71beb1-8541-478e-17df-08dcfe7aba9b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 15:50:25.2893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIK6vUmstNGWKR5I3uOabjjoqKAD6DYB1Irzyf6enTf08C93NA+LOvjjpZ/gnAFy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
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

--------------q00PUigDf9sPBdmbuh056ZUK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.11.24 um 04:20 schrieb Chen, Jiqian:
> On 2024/11/5 21:42, Christian König wrote:
>> Am 05.11.24 um 07:05 schrieb Jiqian Chen:
>>> VPCI of Xen doesn't support resizable bar. When discrete GPU is used on
>>> PVH dom0 which using the VPCI, amdgpu fails to probe, so we need to
>>> disable this capability for PVH dom0.
>> What do you mean VPCI doesn't support resizeable BAR?
> VPCI is a virtual pci of Xen hypervisor used for PVH dom0, it is worked to emulate and process pci devices configuration space access, all that access will trap into Xen and handled by VPCI.
> But the Resizable Bars capability is not emulated now.

That must be changed or otherwise you will run into more problems on 
hotplug for example.

>> This is mandatory to be supported or otherwise general PCI resource assignment won't work either.
>>
>> In other words you can't hotplug something if that here doesn't work either.
> Yes, once I added dGPU to Xen PVH dom0, it didn't work unless I added this patch to return success for Rebar.

That's only the tip of the iceberg. You are trying to mitigate symptoms 
instead of fixing the underlying problem.

So clear NAK from my side for this approach.

Regards,
Christian.

>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Jiqian Chen<Jiqian.Chen@amd.com>
>>> Reviewed-by: Huang Rui<Ray.Huang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
>>>    1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index b3fb92bbd9e2..012feb3790dd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1619,6 +1619,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>        if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
>>>            return 0;
>>>    +    /* Bypass for PVH dom0 which doesn't support resizable bar */
>>> +    if (xen_initial_domain() && xen_pvh_domain())
>>> +        return 0;
>>> +
>>>        /* Bypass for VF */
>>>        if (amdgpu_sriov_vf(adev))
>>>            return 0;

--------------q00PUigDf9sPBdmbuh056ZUK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 06.11.24 um 04:20 schrieb Chen, Jiqian:<br>
    <blockquote type="cite" cite="mid:BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">On 2024/11/5 21:42, Christian König wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Am 05.11.24 um 07:05 schrieb Jiqian Chen:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">VPCI of Xen doesn't support resizable bar. When discrete GPU is used on
PVH dom0 which using the VPCI, amdgpu fails to probe, so we need to
disable this capability for PVH dom0.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
What do you mean VPCI doesn't support resizeable BAR?
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">VPCI is a virtual pci of Xen hypervisor used for PVH dom0, it is worked to emulate and process pci devices configuration space access, all that access will trap into Xen and handled by VPCI.
But the Resizable Bars capability is not emulated now.</pre>
    </blockquote>
    <br>
    That must be changed or otherwise you will run into more problems on
    hotplug for example.<br>
    <br>
    <span style="white-space: pre-wrap">
</span><span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
This is mandatory to be supported or otherwise general PCI resource assignment won't work either.

In other words you can't hotplug something if that here doesn't work either.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Yes, once I added dGPU to Xen PVH dom0, it didn't work unless I added this patch to return success for Rebar.</pre>
    </blockquote>
    <br>
    That's only the tip of the iceberg. You are trying to mitigate
    symptoms instead of fixing the underlying problem.<br>
    <br>
    So clear NAK from my side for this approach.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:BL1PR12MB584921467E47ABAA580D95F7E7532@BL1PR12MB5849.namprd12.prod.outlook.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
Regards,
Christian.

</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
Signed-off-by: Jiqian Chen <a class="moz-txt-link-rfc2396E" href="mailto:Jiqian.Chen@amd.com">&lt;Jiqian.Chen@amd.com&gt;</a>
Reviewed-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>
---
&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
&nbsp; 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3fb92bbd9e2..012feb3790dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1619,6 +1619,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
&nbsp; +&nbsp;&nbsp;&nbsp; /* Bypass for PVH dom0 which doesn't support resizable bar */
+&nbsp;&nbsp;&nbsp; if (xen_initial_domain() &amp;&amp; xen_pvh_domain())
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
+
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bypass for VF */
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------q00PUigDf9sPBdmbuh056ZUK--
