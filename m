Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4A8C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 15:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B155810E3D8;
	Mon, 23 Jun 2025 15:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5bn/dEWG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE91410E3EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 15:30:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmB7LlMoiuz6eArou3acF+YB57zvreHGdZx/oHvwlNxJaPNL7lXgnGoRk7KRez7CoDXt29QUBXMn1nM5/8z3LfHLrWwn/u1yC7/pR7/nXeGfua/f4Gzl/0qay0ZMgpJEYwPhUw/gQn3FX/XCN9ErogUhK6MwTe0YUzKW1graj9U0L5UVacGHvfyudJZQNW/LbIS+VBOsC/Ziws24Wa23zXgy6aS3JX7bm+oZwmfXLG9WnUZP7gCLoWQMJiNr69HMNaG4Lg3Jn8O8nmGOQk68q45QKbcLF62UHCMW6k4OqWDKzuFcZueGUYnIoilY5WMigRv/VADTxd3tlNx+/HBMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCsjOeUPDzOdhtNVIkhuNKmnLKVUH+mEjl7nJ6k3214=;
 b=uEjJfTzgaxdGp5fM1E9jDcmWcBLrS4ivdCUiOxVDeQQhAVA3mEFfmHxEI6+1TK3n/bRMEKH4HKLta55COhY0AMSouySd5HXpDKWmDqaQIKPpP8JDauVKUujg+aE/O5zxUmnB7oS61U7Uc64IF5BzG86XZlYmEDKgInU2UidUtaw3hvgKFPhuLWMZw91Bc3WkRYoSO4SruzugWgENZ2TQ2WKDORwsmxTvrUEQSWoUVUgEs9B0Ty07IH6BeGdZWQfij4eWpshpmLL7pihnPRt0Qf55tPv21DeDwJNtg7hx2pohyF/oI7G7E2KzGhI1gQPbE5+5o+u55sO+tmPiBopREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCsjOeUPDzOdhtNVIkhuNKmnLKVUH+mEjl7nJ6k3214=;
 b=5bn/dEWGubsopQHdX6o8hhYzWCLeUJ29A7TxNt3wAPRUsgcbYd5yYYZ9vkfLYc8zcSV6shhlPBbkkG01ipseUBe6u2yaT8RYaNuQG9l4yCX274QqjxqrMtnDNR1BJ+nZFdhqgyX4Pzffceefa6mD1c9P9QdA2F9Dyw7njVGEwfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 23 Jun
 2025 15:30:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 15:30:31 +0000
Message-ID: <760982ca-3394-49ca-9fec-82d284c08a4e@amd.com>
Date: Mon, 23 Jun 2025 17:30:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
To: vitaly prosyak <vprosyak@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 vitaly.prosyak@amd.com
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
References: <20250619013206.123183-1-vitaly.prosyak@amd.com>
 <CADnq5_NKTTXcEuZANmsS=E6gcLeX11P5CMT5bQnF0p-5XaLqYw@mail.gmail.com>
 <4739df47-fb92-4e71-83e3-389ffc22edeb@amd.com>
 <cb116d0d-71d1-4500-b73d-b94aea536157@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <cb116d0d-71d1-4500-b73d-b94aea536157@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR17CA0025.namprd17.prod.outlook.com
 (2603:10b6:208:15e::38) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b09bc06-428a-4dea-3aaa-08ddb26ae36b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWp5U2VqTkwyUTZhbGJVYlJ6bmZ5bW96cTJPOFJoMFBldHdLdGRUbGlZMnZJ?=
 =?utf-8?B?bUNtUk1tbm9xdGRJVXlKUURXcFh4Rk1BTXZTN0VVQVZtamJPZW16M0h1TnNR?=
 =?utf-8?B?aVNzSmltdWxDdE9Tb3BaZnlyc3dZSE1kQlkxRVh6a1VGcURZUnJwVWwwVGVN?=
 =?utf-8?B?OTJzWHBYYnRYblNEaktXYXpLeGZFR0FUL040WEh3NmlYSTQrRmpmM1RuL3li?=
 =?utf-8?B?ZVZuYnRWZ3htcENHeWNoNk5KbHZjRk1Lc0tzaXVBSGFFRTY3MXE5NitueUgx?=
 =?utf-8?B?N1RYMTdCamNBdDBCM0xYYm1FaWl4dzAwM2d4SHFDelp5Z2Q2TmNEMWpBTGRy?=
 =?utf-8?B?TWs3bHZXdVhtTEViNmtRZWZTNUxXQ1AwSjYrek1NVVE5L2hpZ1VoNUtCbFdp?=
 =?utf-8?B?QndnYnMwd2thZE5qcWcyVWdaK21FZE9iM3Q4MXAyY3o1L1lZZUx2cnhwQ3VM?=
 =?utf-8?B?Z3UvRmNWSm9Jb0I4MU1NRnArbnp1MzBkVHk1NXFyMXhMak5QWmd0eGJXZjFL?=
 =?utf-8?B?OGNkSEx4MVRzOXhjZjA3OUd5b1BuaG1YSHlWeHBLNG1mcW5uRVFBd0FXZmVV?=
 =?utf-8?B?RzhCNStSaEVJN2dNSlhYWUU4N1JSUVF0Nm5GYU5vYTFyd09Ob04zV05NajEx?=
 =?utf-8?B?aVhyeXVpaHVveXR4emJEWVAxSTJXZUVPc2l3L1cyRHZFNWhlRUlybmtUYlpQ?=
 =?utf-8?B?MVp5Z1VxNmFhTGFLWitRSmxVVnlKNGtjSXorVlFOZWhIYnVjZnBsdVVIdHc5?=
 =?utf-8?B?S2Y1VWJaRmh0c294akppeTBPMVkzL0pKRVlXc1Z4OUpqd0dxVVdtTERPVmRF?=
 =?utf-8?B?M2ZsTVlZQWI3Z1RFbFpyK0RWeC8vd2p0M2N6SDhuZ1ljdUFKRlR0OVd1bExi?=
 =?utf-8?B?eDFYd04xQmhhck85anYxMmpvMmIwSWNkdjRTYmV4enMvdGR1NWZhWkxmQ2lJ?=
 =?utf-8?B?RFk2TjJKak12V1lyNldtZFBSQUtIbXlLb1pTRnp1ZnIxUU5EbTRxWktURlI3?=
 =?utf-8?B?QkdBZU9kOEtiTDhEWWE1L3E0MlFCODQyTTJnaWIzeDdCUEsyamJHUWkvYnRa?=
 =?utf-8?B?eDUyUVZpa0RiMFBiRXdyYUh4dDR3TDU4cU4xWW05cjlRRnNFdmpOeGFIRS9a?=
 =?utf-8?B?ci9kQUNXRFJ0blg2UXg3dmJhT0xPb0IvaDdtcWM4WFFkUFZTVVkwWERMZ09s?=
 =?utf-8?B?WFEzRDRsSTRhZFJSeWtSRnE0Y1o2ektzb0ttMHFiOG03dS8weGtab1VHb1Rl?=
 =?utf-8?B?Wm84RVhsTEEyQUhhcm5VdzVJSGljNmJiSG5BUGtJaktoYSsyVy9Ec0xBYnBX?=
 =?utf-8?B?anFaZnhBNkgrUG8xMG5haEdYdlRaRFkrK2RrYTEvbzBtTFd6U0VNWFRyYTNM?=
 =?utf-8?B?Sy92TnIvWmdxV2lZMFpDZUxMa2RZTElEN2xpbGc4YnIrdXpPNFVydXU4VmRi?=
 =?utf-8?B?TlFSd04xU1p3bG9EUWVGYU9lWTVZUVd0ZWtSaUQ0NjZLbVVLT3hrdjZVN29i?=
 =?utf-8?B?TG9pbElydm9SL1d6WUMwVGYxdVRHZWxTYVpyMXF2dmgyeXFLYWtvTkJ2cS8x?=
 =?utf-8?B?dEhVRDVpV2RuWHlwZGErWk9Tbll6dlpwaG1YaTlNR1cxUWxwQmZncnZHbndY?=
 =?utf-8?B?R25wVk5GVE9uc1gxYkVjN1pyTFF2bmVhN09DaUZINFYvL3doV3RWbkxoaEVz?=
 =?utf-8?B?eDdYQmtWR0NDNUFUZzNYUWZHNDIwWkYwM01ZeUttbXE3N1ZlbSsvZEIwdmcz?=
 =?utf-8?B?RzFpdjdEOWxKUEdTLzFOUFNwbVBvVjY4NDBLQXIyb25SZzFhdldsNUtSWUx1?=
 =?utf-8?B?d1NGOHBwcjNzakJ3d3Mxd2RqNDBHWlZjSGFGektDMyt4dHZBT3VjTHBmZjF5?=
 =?utf-8?B?anZGU2hCZ012NmE2QXN0T3dPbnlUUDQzU1ZvdFUwUCt2U2VmdmFDR2xyUnJy?=
 =?utf-8?Q?jVQ2sziD0Ig=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdFSWtSTzhyMUNWRzVtT3htSGtyZjRBRUNrbkZ0eUs3QS9QcFJoeUF0OE1t?=
 =?utf-8?B?UGh0b1Nsd3haUnhOcjBQcTY5T3pVMFpKdGRUSWFuMHEzbU5CcVQ4R0ZjaDQ1?=
 =?utf-8?B?NTVqK0JDUFVKSkFiZElGNW1mei93UEpkai9RQUlWcUkvYjdNVGlRWU80Mzc0?=
 =?utf-8?B?RC93MWVVQ05FQWJDRmYvYVNmNHcrZU0zdUhQMTBiY3hqY2RWVjVSMEUwbHQw?=
 =?utf-8?B?bG9EMS9SME5UM0Z6Sy9mZmxpZE1ZVGI2dzJNZW5JcjU0MytFK21hM3prTkM3?=
 =?utf-8?B?aEV2UDZ1b0ZLQlpOY2ozc1JaeXduQ2NpOFNpakdnRnNIY3Qzc1kxdTZSaTYz?=
 =?utf-8?B?SzY1VndpcUF0T1plUXJaSGpIN3pPY0dsSWYzcmlJQXMrV01oUlA2UGVZdmRo?=
 =?utf-8?B?bURmL3NLT0ZqY1FqQmt3VFBGVHltQXFYRXp6NmRmdTl1K2FzR01Qay9JYW9T?=
 =?utf-8?B?VzUvalM5UDJLOGVUNktUR0Z3MHpxelRxc3BWV3lqdDN0eDNVVW1qN2dENnVi?=
 =?utf-8?B?ZnppaHc4ekxNWnIzL1JVVUN2MklVcWZVSmlKNVdXYWRGU1M3N2lhVWphQWU1?=
 =?utf-8?B?QmJxbDJjTXdqazhaNExzQVNrWXo0NnZJdnJiR3dSOTkrS2F2QStqUnNPM0dD?=
 =?utf-8?B?OW12RjZTenFJZy9VVkxlY1RNd1AwemVDZ2ZrVmd0UVB2K0k4YXFDM1d6Y2lX?=
 =?utf-8?B?Nm43bE42RDhXbG10aVp1UjVZR3hpdjBBYm5TYlpuUmE4MkhpMzhsUlk5d0kv?=
 =?utf-8?B?RUxBclFuWEl3ZngzdlBrTW11dFN2bkF3eVhhUlkwWitnQVVsVXpwSXlzKzhj?=
 =?utf-8?B?ekU3SDZvTENHTDNiOTVhRHZpdkUzMlJ2eEJQU0ZFVFdqS21yeE5RNUtoV0NY?=
 =?utf-8?B?d0Q5R2JYK1p5OGVnYVBhNHZKTDJjZUJpRzlqQ3RRV21JOUNFY2pMYTJtWmVG?=
 =?utf-8?B?emJkbFlGWEpjYWY0d1pzYXcrWmxRTzFSSG94ZEJSaFJETkpnNUJoYUsyWThu?=
 =?utf-8?B?bjJNcDgxdm9GeCt1cW1BWWpOa2tYL01kQnRsdnNYNThrLzUvcDYwR2ZrUk83?=
 =?utf-8?B?SnVDcU50NCtjMkprRmVxMDdoQjRUZ0xnMmFQazFJNlZNcGtDYmlxekxQazFB?=
 =?utf-8?B?RHA1OXl1QXRteWNaRzRXeHFOUG5RRVQ3QUFDWEI2OC8vLzZDRmFPZ205NjJi?=
 =?utf-8?B?bW9LZEdqSDAzbUpjSThxYTVsbWZmTnU3NTJKUXJ2V1JUU2hEUVVpVTVJZVZ1?=
 =?utf-8?B?Y2oyN1pKYXVoaXoyMW9WUWswWThGelhnNlplUS9RVTIrMCthaVNEQVJDaUpS?=
 =?utf-8?B?SDdLSmFRaG9Mb2ZuSW5HM2RZNXFKMVcwWUFyckFEVHg3TW8zRWVhMGhFZDVU?=
 =?utf-8?B?QTFxV293ellzK2srWFBjaHpLKzFGMm5DN0RXS3dWTDVQUGlkdS9mcG5FSEhW?=
 =?utf-8?B?S3F5Tm9XVEhZbXNBSy9FdThob2VwU1BuNnd0U0trUThqSzdNZWdTZlgrL0p0?=
 =?utf-8?B?OXhjRXF3TDBOb3IyOVFIZXROem1kWHNjMncyQjkzRFdoKzlGejlZUnhod0pR?=
 =?utf-8?B?QlB0MWc5Y1ZBMFd2RDdQZ296T1BJSGFWbVF0ZzZ1eHE4TFllazNkSkRwYWNY?=
 =?utf-8?B?VndxQm4zY29XRzB5RkFRSmFKZnVWbkIzbGhabUc0MlZqdUNmNUovaVNzQ1Jw?=
 =?utf-8?B?enpESWlqR0tvTHRYN2NZdUxFRWhYYkZ2eWlCQkM1UnU4aTZiNHFkRXVpTldZ?=
 =?utf-8?B?eXdoT2Q4dmhlSXpGYlBiMGZEK2ZBSjkwUGlCSXU5L1Z4VEtLN2VWdk4vYk05?=
 =?utf-8?B?bVlidEVZRzl6TWIyU0lDRkhPVXhNQVhOT0dldGlWWTJyTFVTSEJlSGdGN2h4?=
 =?utf-8?B?UXdTbmtoS0xMRDZUQXZ3ZnlIUzRteVlDaHFkUzN2TEEwRlFQVkNYUkNvNHpp?=
 =?utf-8?B?aHI5U1JUcHkvUmxyNFhuR2NPVURQRURteTE4Y3BnM2dzOXVzSUl6bUkvUFRZ?=
 =?utf-8?B?d3RiTEhBMUhLbVFuNUZZV2ZEV1M2RytzTys5bWQ3YkNqNWp5cnB6TlRCUWJC?=
 =?utf-8?B?OHFBSFhUSk5mSmVGMmhZWXkzNkd6elg1VFlmZWVuRHVkaDVGZS95WlNRMXVq?=
 =?utf-8?Q?8lfmVd9gEKB1LboC+OQmgiw6a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b09bc06-428a-4dea-3aaa-08ddb26ae36b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:30:30.9885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBQ5I/U2iYMNY17SB3jPIRASqpqEk+/ozTrkyNAzVoVeYTozlnrUbXAliSRZygVv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453
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

On 23.06.25 17:04, vitaly prosyak wrote:
> 
> On 2025-06-23 10:34, Christian König wrote:
>> On 19.06.25 04:26, Alex Deucher wrote:
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++---------
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
>>>>  2 files changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 7fd233f160bf..204178d949e1 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2914,16 +2914,10 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
>>>>
>>>>  static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>>>>  {
>>>> -       struct drm_file *file_priv = filp->private_data;
>>>> -       struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
>>>> -
>>>> -       if (fpriv) {
>>>> -               fpriv->evf_mgr.fd_closing = true;
>>>> -               amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>>> -               amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>> -       }
>>>> +       int r;
>>>>
>>>> -       return drm_release(inode, filp);
>>>> +       r = drm_release(inode, filp);
>>>> +       return r;
>>>>  }
>>> You can just drop amdgpu_drm_release() altogether and just assign
>>> drm_release() as the callback directly.
>> Stop, that change here is just broken.
>>
>> We need to call amdgpu_userq_mgr_fini() before drm_release() since the later will release all BOs and so eventually also the ring buffer of the user queues.
> Yes, we observe that amdgpu_driver_postclose_kms is invoked before drm_release. Within amdgpu_driver_postclose_kms, we perform all the necessary cleanup steps, including:
> 
>     amdgpu_eviction_fence_destroy()
> 
>     amdgpu_userq_mgr_fini()
> 
>     amdgpu_ctx_mgr_fini()
> 
>     amdgpu_vm_fini()
> 
> These functions handle eviction fences, user queue management, context management, and VM cleanup respectively

That won't work. See drm_file_free():
...
        if (drm_core_check_feature(dev, DRIVER_GEM))
                drm_gem_release(dev, file);

        if (drm_is_primary_client(file))
                drm_master_release(file);

        if (dev->driver->postclose)
                dev->driver->postclose(dev, file);
...

The GEM handles are released first and then postclose is called.

So postclose is to late to stop the queues from processing.

Regards,
Christian.

> 
> Thanks, Vitaly
> 
>>
>> Regards,
>> Christian.
>>
>>> Alex
>>>
>>>>  long amdgpu_drm_ioctl(struct file *filp,
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> index d2ce7d86dbc8..195ed81d39ff 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>>> @@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>>>>                 amdgpu_vm_bo_del(adev, fpriv->prt_va);
>>>>                 amdgpu_bo_unreserve(pd);
>>>>         }
>>>> +       fpriv->evf_mgr.fd_closing = true;
>>>> +       amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
>>>> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>>>>
>>>>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>>>>         amdgpu_vm_fini(adev, &fpriv->vm);
>>>> --
>>>> 2.34.1
>>>>

