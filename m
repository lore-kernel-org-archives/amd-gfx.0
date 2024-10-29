Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591B3D5B176
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 14:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020D010E671;
	Tue, 29 Oct 2024 14:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJKOcHX1";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD8FE10E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 14:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btKsji4unfPHLCPiDjnfTfDdPaFdZW8pSF5TojtOzOmqI6ja3tPJ1QEuOqRFL5j93k0XsANfp76Cnfp3tDUnGTlnwIGE8tMK1nX+CdUKRZDPzuG1tfdVkUEBVm5dIS8X9eK/1n+mdihweafYtRMlP5Vb58V1h0uX3Rc4udEhfXrzvmPLujwNVH3kSf3kw3QbaQB7nwbxJSIVexevx9rB42rAL5EikqaPh9tgr0jFLwhJLeDBvgJXXJ0y2OldjJhuPIj2yREg05wwNBnhsjPZbTN66fdYLZlDvLkLbBiOHdSXDodQUgvK/9w7OjKaauqBTWQK8j2/SqJywUQuIBnYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFY+bcYOWaIlOzUIeDGCzzrhfjCu3GefmW7Qdoej3hI=;
 b=Zke+TjAAvshxgr5uoOLZs3xZwNmIURi77uQL8aGk42kzEDF87BSKOiuQUtoh9z5QOgs+jt2vl90h16Px7FBtj02PvXNUvbboDZjcUMcyWyeVEukMxgYy74Zr9N2rZwstJzcEzmLY+SvGUtElCf63OAGnJ2frd8KlsEtrIoWPjUiFAQyjfq+f0XlWXrI6eldOwHltPbd0FUBenhYPALI+IIEtMcMAhvtfUeyITjxhrfQGlVFc2Sqz/LLCVjQY2anyBYmEg4e2WN7qd/MaWARCfxJby6sInJWJ9mmKOAd6VadKmA7eENh1qsC+yBUpr2Spbdu/vEE3OdcWEqQS+rWq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFY+bcYOWaIlOzUIeDGCzzrhfjCu3GefmW7Qdoej3hI=;
 b=PJKOcHX1P/0b+uYNh2CToCwT62egt51eVROwyxSrN9WBv+eYqwoLuDq8Ek65E6fWeOX+tANCsPDfRJy6o8Uzp3iast0MFOjZYdlKU+8jB9xDSGzh8crRGfv799i0FKeOVAx8ZYAwhO2UVHOGZyKRCKdIAckw9i2BCOcUfhTERuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 14:06:57 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%7]) with mapi id 15.20.8093.024; Tue, 29 Oct 2024
 14:06:57 +0000
Message-ID: <b3c274db-4648-4265-8e6b-498f758099b5@amd.com>
Date: Tue, 29 Oct 2024 19:36:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add userq specific kernel config for
 fence ioctls
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20241024121027.3397-1-Arunpravin.PaneerSelvam@amd.com>
 <9ba915e5-2266-468f-a978-f89a33bb9fc8@amd.com>
 <CADnq5_OduwSsD+ZCRwSF1+2HwDRGjgZ_V0R8QYuK6LxrQ7Zz4Q@mail.gmail.com>
 <8bcdc50f-2135-4faf-9f24-d901c3809a20@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <8bcdc50f-2135-4faf-9f24-d901c3809a20@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0009.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::17) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 13d9fbb1-3903-4099-7da7-08dcf822f2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDlsTVlEcWdxbEZUZmE0Q3FhT29DUjVoa2NJZlkzeG44dE9HOVZ5eFRCM2ZL?=
 =?utf-8?B?Umk2R3Fzb1BGTjBjenJrSHVrVkZmTHFPVldmZGVjejJSOWtNTG5NdXkvMzd0?=
 =?utf-8?B?QnpVUjVXcDZuMmtmS2NaUm1STmx6c2M4cXY3SEFjUlltYW1FK2RHUUZiSW1h?=
 =?utf-8?B?R3lsREpQdVY0QnRIZHN4c2pnbEFtWldtSXJDVUdCZXgxUE9oNmJOTXRJRk5H?=
 =?utf-8?B?LzVtV2xTTERTa091ZDh6RFBuNjNVSGNheUp4Uy9rb0IyY2xMYVRqcVl3M3Q3?=
 =?utf-8?B?NkdFTThYVVVtSEhsdlBnZnVBeVJHMGdCTm41eEJSTXo3aVFUOXFqVURPVHpa?=
 =?utf-8?B?bWpHNXdxWWxkYm5GaHIyM2JkWXZwZHdYSWZ3QVptVVpKb0U4L1dKSUQ1QUJx?=
 =?utf-8?B?eDU2MWdBRW5rVzZYeGU3eTRhdEg0TTU3VVZlQW1WeDQzM0gxZWxpTTZnc3FD?=
 =?utf-8?B?eG1ZeFMzR2RROGo4dHBXNkVjTWJPTDMzUDNUUHd5eDAxZ3pRV1N3eElNQlE2?=
 =?utf-8?B?NE5xQTU1N2RTYmFNMUZ0SXZGM25zOTlzdEJpT2tjejFsaE1SeWxNc0N0RkVX?=
 =?utf-8?B?dFNCTFMzSEU0MXlYNGJDSGhnOTFncHB5UXFrK0FPNjl5a0dyRDlVcHYzZE9B?=
 =?utf-8?B?TUdYM1B0VXFwN0szTTFBZFBTdVJkMVlNYWkzTTRUZ2xnS3c4K1lkZkVFZUhh?=
 =?utf-8?B?Y0VCdmppcTVpYmVadEhCQllhQk9Ua2c5bkhGZ3ZIUWdzSjRuNElQNkdpNXZq?=
 =?utf-8?B?dWRmNm5YaXB4VFlkV3dVRHpHTEErTWI5L3JQYVM1ODNwR2dlKzIzMGY1NFlw?=
 =?utf-8?B?Vjg5TjNLOElYbWdRbEhXRTYvK2ZBL2xTSVBFdU4rUTdHMUk4eVM0SWVDakVy?=
 =?utf-8?B?bXkxbWtyNFZiSWVjVkRLdjE2ak1TVjRTTDJuaWxRTlNVYVIrUC83dnBqS1J5?=
 =?utf-8?B?RWtMMFZ4WHNHODJncjYxdFJ0U3lFT0lOMWhYOXFSdlRlaW0zc2NZVFJxZE1j?=
 =?utf-8?B?RitaYWw3czFyOHVwL0NDZkh1U2VKemFLR0lraWxMTWlhY1Z5T2tIQWloRk02?=
 =?utf-8?B?aENNVGZjc3NSVEF0akZCc09IYkdiNlY5OTY2b0xkMTZJMmVHRkJyUUk0N3ZO?=
 =?utf-8?B?VWZ5c0Q1anhJV0hiaW5xQWFGT3p1NVlVbHo1dWtZSkZjaDM5R3hQMHdEbkxy?=
 =?utf-8?B?cmF4RDdta05EODBLQVRkZlE4cU5tQUdSaXBEVGNqN1BobU1saDcweUpmakty?=
 =?utf-8?B?c2NjTUtKT3BxeDV4Y2orV2FvZlBvRkdwOWlVdVEzN3pLR2ZMSnpBSWhQdXUv?=
 =?utf-8?B?ekxmaXIvWDFKNGFiSWl0UWRkYSs2WlpLeTZzU1AvdE1VenpGQ0tFWGpDMWUr?=
 =?utf-8?B?NDVWczZBTUcxQlFXQnU1Sk9tRGRzSVY1ZlUwT3Q2NGVYR0JjNk9lVXliek4r?=
 =?utf-8?B?RDdSKzJQU1VEa2U3ejZEdVVFeE0xTzg4aTdSOTEvZmorQkE1VlJsSDB4OEtj?=
 =?utf-8?B?ZThKb3FXbk80MWtYbDl0bmpGNTlUd2ZoWFNtYW10TlhFZHIwTzU0MXUzbWJ3?=
 =?utf-8?B?N0V5a1RPdG9xcWtlTkp4RjE0eTNwb1lsQW5XNGtCTnpHUUF6Zi94dXZqTkli?=
 =?utf-8?B?V1RVWkRiTEJTbGNpdTEraUpyb3ZiczMwazJ1VkNXdXVSUGdhQVM2cm9pbUVX?=
 =?utf-8?B?ZlU4cEt5YTNuTG1wbWR0NVVNMWUwY2dxUzJLK1RwQ0ZmOEI2aUxwWDlISWUy?=
 =?utf-8?Q?pVuo52/vF9cM/DZ05YjSbJ4JneXmdiT+OlG0M7+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djdVeVM3VVBmUFZnSXR6Ymh2eVBFOUdJWUJEaWl2ZWtQTEx6c2dGdjBVTkN5?=
 =?utf-8?B?VmFDK0ZSd3ZjRzR5NW85czRIbUIxQWVkQnRtZTdvR2pWQ2RZbkRualVWZE5h?=
 =?utf-8?B?elpmNTVCOHhpU3RLUysrV1l3bVI0cmFhTU9QcmdLbktTUjNoZEx1b3FoOFJG?=
 =?utf-8?B?TzZYK1FsY1RkM2xUamEvY3JnbEpLT2hkMHVNeXUxRmVDcXBiNmloZEtPWWMz?=
 =?utf-8?B?ZDhQN3VpR0RrVy81OVJLZmcyUWkrZW5pTjg0M2l2Zm5DUUw5V2k1azZkYVRG?=
 =?utf-8?B?cDEvemVmOGFKaGxJblVUVjBSVkZoaUFhcUpGUUZpY0FDSnVKakNHeVNLK3No?=
 =?utf-8?B?c0dOVEpIYjM0SlNIZmsyQnEvNGRoTGJBMm9IbkIySTRHWFFkSXdCdXVjUnNP?=
 =?utf-8?B?Z09YSENNbDRCVUM5ajNJYVpzSHFjMEFFTG1pQis4akJzem1FMjJkbHhBSGdQ?=
 =?utf-8?B?V3Z2NHBWcVh4ODZjWktkc0Q3VzluN1VSeW1pNk5DKzJ4Q2YwL29Qbnc4VWpz?=
 =?utf-8?B?ZEJLYWpxa05HaXhNYThyaUJqN1FVY2VQLzV6bHF1ekMzU3Qxc2s5YU5YcE5H?=
 =?utf-8?B?cEdrVm1SVURnTE0vUVdHbDhaQnBFUkVTUWlHVndFOWcrOGc5bGQrbW9mYVhH?=
 =?utf-8?B?Vk9lZ2pYcjU4RkZUQ2VLc3NydDFaalhhVkFPUWdOaThoT1NkcEVWTTBlZW9Q?=
 =?utf-8?B?cC85RjBVZzJOZlJIRTdZYk5vYXZZL2lsbElpVGx4c0N2dzFaYW1GSG41Nlli?=
 =?utf-8?B?aThkdkFZTDdvR3lVNmllUTNmWGxncUxYVmpxbEk2d3RRelhFTU9zSEt5STVW?=
 =?utf-8?B?NC9Lb3BqZjl4eXZHWVcxRVFVWitueFpwdExMS0hqd1pzVmRMSXd6TCs0K3Ry?=
 =?utf-8?B?eE9SSnJrL1htVkFNQ2RTWXo0bGRSR0JQTFI1UlpRUmhya2U5dDJYODdack0r?=
 =?utf-8?B?TGF0cjFVd0diaE1sS1g1eHFUMFZ1WkJUK0hPSmJZWVB6WnoveDFtT0NYcTQ2?=
 =?utf-8?B?TVQ2ekxENlM3VUhnd1Z4NEpsclMzRkpZRlNUNC9Hbi9kWWJPc0k0Nk1Ienha?=
 =?utf-8?B?dHBpdkRVa0RmL3VSRXg1RjBuNDRxdHBIeDdDY2J0VWNVbTNMNTB5Ukp1eFk2?=
 =?utf-8?B?KzgyTXcrS1orWkxmOHBhb3Jnd2tjVGUxQjZaRSs4Vm1NVkpEZzFGRGFSUGpu?=
 =?utf-8?B?eWdEUEdBbGZCMy9BWUlzSEZiOFdkN0xCQUQzYWg5ZEgrOG5jdmZsTm0xOXJn?=
 =?utf-8?B?MzZlTFBLcHhieWhMUThwVVo4ZU5uTnJXdy9ETnVxYjZlcmtHQ1o3OWFNVXJ2?=
 =?utf-8?B?S3lPU2g1ZmlFV3J6OWJ0L1prd0tYdlh4dGlpUktqR3k1VVNmdUdXaDluREcv?=
 =?utf-8?B?UGZlaDlNdTIreE1oRTl6aTJSb0dPL2FqZVdlM1JTYUhzZnVzSjZUNWc5Mnc3?=
 =?utf-8?B?OXRkTGlnbkswM0VqRjZsQTZHZHZVanJyV1VlUVI4NDNCZE5LTVhLV3lqeERU?=
 =?utf-8?B?cWE4QU12aGVOVkZqUk4xcWNjem5BS0U2czBnS1R0b2ZIZVg4UUt0LzgwUEFI?=
 =?utf-8?B?WlhoZ2ViREVlNEJQL1A4d2wzUUJzNUsrUlBWNnJyaGp5VVphM0tUNkRPc1RS?=
 =?utf-8?B?cDhDejhIZklBdlNSWTRqVW82UmRSbXZSUDE0QW04VDd1WFUvZ3FVUm56VkdE?=
 =?utf-8?B?US9SWlpnQ2F6eW41aVJFbmcxQ2RtTE9HOUdsdXpGTkI3RHU5R0tabUlFcFRj?=
 =?utf-8?B?UVQvRW4rZGMvY25KYkNSV2dmTmJZWGUyMXVPaVhGMlZtTzIzYU9BL0k4WWhC?=
 =?utf-8?B?UCs1Y1lpaUUwUDFTQXFxajRUQVZhZlhnMlA2QjBNYzVCK28yVlAraHd0RGE5?=
 =?utf-8?B?OThJWXNhcVo2MWx0VDhObzRYSVdHWFZoRzl6dExXZUlVUERrUDJuY2Q1QTlH?=
 =?utf-8?B?T0lIVFpVN2VpdEY4NDY5bUg2K1dQLzBVVnRiU0hPaEFQcWp4WHpGWDZKV3Zh?=
 =?utf-8?B?ZFd3Zi9IYUpZbGltNG5tTDhQeHZxN01JNEpBMUhtMTNwRWtqYXA0TnpaQTNN?=
 =?utf-8?B?dlByQlFPdUJVVUUrTXlZbmZTZmJ1SDJmc0Vab2l1Z2JsUVVSbzgrVFhVZTBN?=
 =?utf-8?Q?1frMc6ZjAxkQkoF/hqNuJXNgC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d9fbb1-3903-4099-7da7-08dcf822f2ed
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 14:06:57.1708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agXOr9+4qJsGD0sJ22/i4b5blG9lhVDasbU85pqTX2X/e27OLHjpZhxh6C3dqlMXaQAfohRuvcI6AHq4Nv2Abg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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



On 10/29/2024 7:33 PM, Christian König wrote:
> Am 29.10.24 um 14:32 schrieb Alex Deucher:
>> On Tue, Oct 29, 2024 at 5:38 AM Christian König
>> <christian.koenig@amd.com> wrote:
>>> Am 24.10.24 um 14:10 schrieb Arunpravin Paneer Selvam:
>>>> Keep the user queue fence signal and wait IOCTLs in the
>>>> kernel config CONFIG_DRM_AMDGPU_NAVI3X_USERQ.
>>>>
>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         |  4 ++++
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 16 
>>>> ++++++++++++++++
>>>>    2 files changed, 20 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> index 70cb3b794a8a..04eb6611d19b 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>>> @@ -2971,9 +2971,11 @@ static int __init amdgpu_init(void)
>>>>        if (r)
>>>>                goto error_sync;
>>>>
>>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>>        r = amdgpu_fence_slab_init();
>>>>        if (r)
>>>>                goto error_fence;
>>>> +#endif
>>> That here makes no sense. This is for the kernel queues and not for the
>>> user queues.
>>>
>>>>        r = amdgpu_userq_fence_slab_init();
>>>>        if (r)
>>>> @@ -3003,7 +3005,9 @@ static void __exit amdgpu_exit(void)
>>>>        amdgpu_unregister_atpx_handler();
>>>>        amdgpu_acpi_release();
>>>>        amdgpu_sync_fini();
>>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>>        amdgpu_fence_slab_fini();
>>>> +#endif
>>>>        amdgpu_userq_fence_slab_fini();
>>>>        mmu_notifier_synchronize();
>>>>        amdgpu_xcp_drv_release();
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 279dece6f6d7..bec53776fe5f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -318,6 +318,7 @@ static const struct dma_fence_ops 
>>>> amdgpu_userq_fence_ops = {
>>>>        .release = amdgpu_userq_fence_release,
>>>>    };
>>>>
>>>
>>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>>    /**
>>>>     * amdgpu_userq_fence_read_wptr - Read the userq wptr value
>>>>     *
>>>> @@ -502,7 +503,15 @@ int amdgpu_userq_signal_ioctl(struct 
>>>> drm_device *dev, void *data,
>>>>
>>>>        return r;
>>>>    }
>>>> +#else
>>>> +int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>>> +                           struct drm_file *filp)
>>>> +{
>>>> +     return 0;
>>>> +}
>>>> +#endif
>>>>
>>>> +#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
>>>>    int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>>                            struct drm_file *filp)
>>>>    {
>>>> @@ -797,3 +806,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>
>>>>        return r;
>>>>    }
>>>> +#else
>>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>>> +                         struct drm_file *filp)
>>>> +{
>>>> +     return 0;
>>>> +}
>>>> +#endif
>>> Not nice, but since CONFIG_DRM_AMDGPU_NAVI3X_USERQ depends on
>>> CONFIG_BROKEN at the moment probably ok as intermediate step.
>> Wouldn't it be better to return an error in these cases?
>
> Good point, the functions should never be called in the first place 
> but better save than sorry.
Can I return -EINVAL instead of 0.

Thanks,
Arun.
>
> Christian.
>
>>
>> Alex
>>
>>> Regards,
>>> Christian.
>>>
>

