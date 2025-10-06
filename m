Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F92CAC5B8
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 13:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B27010E2ED;
	Mon,  6 Oct 2025 13:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e4wj1zsn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013053.outbound.protection.outlook.com
 [40.107.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3F8D10E06D
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 13:14:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jed8X/ahsoEeh0esFwWV3iX61Gm23XvorFB5lg+gvmoIipfgbnFR+PjVye3ozLv1IrWWOEuncUf+SPbCtOItLOBsGvG0KcDX+OEWs4XNuim3Fob1Jd4mejReQaYYwg4+G5rWwvyn0nKgSMRG/PgG6XFTsfqQHBfrClnbt/ZCK3zkOvDT6XamQA/h6vdpmLTrAjFsIxy7L5QdCHF2j1/G4wPV1AGViXhZaFD7VMQOAKmcq7oW8LcDlde/NxfH8tMswpgPdcpyVgVBU0e+geWJCX0MT9JPcRy4pf5GKfOUQimcBVAZmtUUtxAjfUwPxHvkk3FDuCXcKJSTlFnWs0ADcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmDOMijZs7GY5D7tihnxj7UV+abBi5V/ki6qY3MaOn8=;
 b=pgu4dJh9DXYEUquj3Tap2qK4Iojsw/2huWKPzyrgCDk62Q6g8OWzpRozHtaZ9Ii70dKmVD2vlLhxb1OhjGCgTHPunOaERSQPA2miUyoNguhyWjYnsvKX1r5h75JOUQ3j3VrBvTX5ubiaY06rTFKrKR4jRzpfjB/Bbth39B1yqlNNNuMkR7xAGmnLyYO2xAyfJ4T2egalB7jHOVdT1Ekpgw7gAFN50oVz+oIP9rW4eG0S3QPd/RSkFzpi7Fa4hyVdkNmQY8Pi/ubzW2c69UHr1S65+txOMz+p3xakAxhRq0JPFeF5sbILaMYr5Q9ltfbsF41h727TJSD5sNQgDfI+eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmDOMijZs7GY5D7tihnxj7UV+abBi5V/ki6qY3MaOn8=;
 b=e4wj1zsn8sTd4uED/621w+yorejGue3woprJoNAuhqcbEXTzMDFxPyw9A/l0BbKI1xL0D1brvu0382EPP/wjCxgi+xjBoHAbZPN3iDRzOdB8CgOVoo9oT7v5CS6EfPZ1lRL2Xt4YHmd7IE7ZiniT1SSa3IKbhIjhNne7FCQnQ1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 13:14:39 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 13:14:39 +0000
Message-ID: <8e2cd7c2-87f7-44ef-a91c-1d116284d2af@amd.com>
Date: Mon, 6 Oct 2025 15:14:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Introduce dynamic pf-vf critical region
 handling in SRIOV
To: Ellen Pan <yunru.pan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Shravankumar.Gande@amd.com, Zhigang.Luo@amd.com,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250807000156.196220-1-yunru.pan@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250807000156.196220-1-yunru.pan@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe22f72-1c12-4e40-9a34-08de04da4e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajgvcTRycDZFbTA3a2s5VHFKeTM1Nkp1NGtlMU1pNC96am1mUkJ6ZVExbnYx?=
 =?utf-8?B?Z0tHUEkzb0pNRnVZNXlzdnpiS3dwTlZTUnBHR2xwTjhJS0Rpb2NkdE9ka1U4?=
 =?utf-8?B?SDgrT2JTUnJqcmVTWDZpU3NCRmduSE9pdlJLaEloMnlZOUZPdWJ3ZGdmYndL?=
 =?utf-8?B?NWppOWIyeE9xc2lFRzA0UGQ0enBhdnd1MWlhREE4RlEzeDdnaDIyd1JSK3pr?=
 =?utf-8?B?NFVGUHR6bGl4YklXUVBuMjl0Wnk4eDM2bGpTT0R1M2VSRGNTakNud0l0L2hN?=
 =?utf-8?B?aU1tT3pJeG4vR0RkQWZ3R1lvaGhjeTNoMXpEYlIxOGxqd0JqQVZ4cGVZdEYw?=
 =?utf-8?B?K3hya0xVaWpzc0M2YXRkYThwMUlsVmpDR2R2OS9OeFIyNDlra0ZIT1VnY3ZJ?=
 =?utf-8?B?NTl3cWthdkVRczhrZmxjam0xSDdxR0Y1K3dUeCtaVGl6cUVSN0VrNllOYWNk?=
 =?utf-8?B?NWxyTGZTQzM5cU5XczBuU2tEY2wvSVF6a1UvcHFNdkZuWk9namtCOFFmY2la?=
 =?utf-8?B?RWl0YWpDVC9ZR2RmR2pRckxaOEtNU1d4U1lpb0dQUG5VeUg5bVdJVjZjajZy?=
 =?utf-8?B?R0NLcWdWOVNrbk4vT3k4aE9jcW02Ym5sMDZtSE1VbmFOVU9jWFd6TjQ2L2JV?=
 =?utf-8?B?TFZlSTI4K0t1VDlLLzFiTGw0Q0xKTFVWSHNwS08vWjJSUk1ORldSTjY5Wjcz?=
 =?utf-8?B?N1YyWHpHdlZWajRHZ1MxUGJLaXhlQzRhdVJ6UUh1NHZvR0JLcDZiTzZFM0tE?=
 =?utf-8?B?djBBcyt2T1RzaTM5ZzV6OTJidzhuQWVnRDZJbW5KSnhJbFVIWk1vbnNDUGJu?=
 =?utf-8?B?dXJ5aHVzTWxURVNOVE5hdHlpNDhqRGxhM3RjdE5rZEtRWGxseENCU1ljSjl5?=
 =?utf-8?B?LzN4UDVqSTdwOWVzS2pHYjlkV3NmV0h1MEZSL20xbGs0VGprejhxdXllQmpo?=
 =?utf-8?B?cXBOZ2RGVGNZUmdBSm1mdDF6MmhGOXFaS3ZjcTAydkdjb0xOdkRIaWZsS0JG?=
 =?utf-8?B?SDJzZzlMbTE2QStVOGpqOFg4bGl3NDRxMWVja0tFWThHM0JkOHFvbnRPOStI?=
 =?utf-8?B?RzdzVGdobklpQ2x6WGkwaVBvNzY0MkY3blNnRkdheGVsdTBRZitTbXNxY09Y?=
 =?utf-8?B?WUlDZDg0dWNKWDRLZkx0RVJnUHJOa3J4ZnZEZU0yQmdvYjBSTlo2WVhFSnJw?=
 =?utf-8?B?czBkUEUzalZDM1B3QW5MbTdrTDkxOWEyWXkxV0t0dzhBNy9RUU9ZcUpLQXBt?=
 =?utf-8?B?Y2lXTFNjNFJ3UnFCV2VCQXZPYTY4cDNFVUNzQlZEaUJCYzI5d1d0UXo1YUxh?=
 =?utf-8?B?ZXUzSFdWM05weGplZzBGZ3ZEOWpSRDRuNVJnOG5BSDhqNi83c3BPbHNuM3Zs?=
 =?utf-8?B?RlZGTFp6TUVDaW1UeUMrcTVXbWxkQ0NZQy9vZ0NJemtmQy9meGszNU1sTkVJ?=
 =?utf-8?B?enkyNFVXdlpvR2pEbnlEbXJMSjZkd0plY0NhTXRBREVPL1UrQUZ2OGdyVDVR?=
 =?utf-8?B?L0drV3lEUGVRUi9QOTNzeWdMNGQ1dHdMR2psL1R2ZmpIdGdYczMzZVVkTEJ1?=
 =?utf-8?B?TE9vNm1xWDlXUm50Z2NzVE1SNFNVWXJNZmhlVEZ2OW1YZVEyWGcyUFJKcWJG?=
 =?utf-8?B?M3hwTUJEV0JvUExiNnBtc25CQlJPZlNsaEoydWxxZzlORFhXRm9reFVFTDdG?=
 =?utf-8?B?cFVJNE5wTzhhbk80MzlhRjFtTDVNa1k2aXhyaHA5V056Z09GRjZpenlVdHJ4?=
 =?utf-8?B?N25STEIzWVUzRmNuNnNDaldtNUJVQ3MzZUtFQ29MWkowbFc2bXQ0VEpmY3c5?=
 =?utf-8?B?WDB5Tit2RUJNRURZRVV2WGdocmN1bWZheEJQWGllK0NyV2F3NHdaOGhGb3RN?=
 =?utf-8?B?K09RdFk2MGpRZVMwY3Y0R1FLd0FWeUp6RzhzSDlJRTNrUjJPK0VOTUtEbUZw?=
 =?utf-8?Q?/BGkR3wIxaKSK7VURQOkPiUeNHW2Iors?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zld1ckl6OGxYUVZJenFJZCtqa2xiNzdDQzV6aWhTblFuVHkyUkNiWWkzaHNW?=
 =?utf-8?B?cXhCQzNVU2hxZFVqWmpwZWNXNWVNOWRjZm1TOVZSaG1vUGtkTFRRZVI4TjFF?=
 =?utf-8?B?TDMraUF3VkM4U2IyRzZMTnRuWUU4VG1VRWE1RUpDTU9jUFErYjhTSkFURGc4?=
 =?utf-8?B?MW5oWTlCd1RBaER2TXRoOHJXc0xjMHBicnZQZFpRTHBkeFhJQmZUeXdlbWNF?=
 =?utf-8?B?S29PYVFpbFpZRjdabTFEUEdwU0RlcEdyRU9aR2Y2RVgzYmdOTGhqWVJOaUo5?=
 =?utf-8?B?Nis4M3hzTG1aRHA0M0tqcU1kVElJYi9OYk9obmpqUjltYVFLWVl6Y295V2JU?=
 =?utf-8?B?blRJR0poSTN0ZER1bDI2VlZyRmhDWjdvRDNtN0Jsckc5OGZpWnRZVUxBamhF?=
 =?utf-8?B?R3hGc0Vpb3BpKzhXN0MzcjVEUWpRdUJuUm9RUE9Ld0oxS2piZmtUSXM3WG5S?=
 =?utf-8?B?VkE2eVlRcWhselJ4R0hjYldDbXhZamZuVmlWYWRBT09wODYwZThJU2tzMWZt?=
 =?utf-8?B?YzdKaVRwUmppcXgwZ1dHeFM5RkVHSlV5UnFVdGlEMEJnUUZQWWVVcTJvMnk5?=
 =?utf-8?B?c0RqcHJlbS9BK0ltYnArQm5GdVVibTJBVE9iMkIxVjBsUGpTNUFkck5keWlB?=
 =?utf-8?B?YWVvV3NMS0lKSEs0YjlLelBzdmZ6MHU4OGcxbkp6MGYrL2Y2VnZuM1RSMjBS?=
 =?utf-8?B?L0p3QzFmTVhJSHFPLy9uVlZxakhUTlk2Y3pLSnR1VVYxNlVrS1JVNkJ6ZnpM?=
 =?utf-8?B?cjRIajlKSXd5Yk1Ka1JlZG9ORVVIUWh3bXV1dGhTQXJ5ZWtWeWZsdHZreXBG?=
 =?utf-8?B?U3JtWnlUTUU3RmZMUG1uV2tIV0pPREtVQ3AvYTA0NFVsUGlSY2lDc2VGOHM4?=
 =?utf-8?B?YlFyOWtNZURkYnlYSDNQam5qdXZ4aWx0Q0Z5bzNSQXNrNVd5akpWNjFwM0hW?=
 =?utf-8?B?Y3B6ajFUSmpYMmZ0MDZuRHBYZnQrT2o0dUp3TGhrSW9jYVpFNEJqWk1teXho?=
 =?utf-8?B?OWdORCthSlNFdWpIeDRuOHA0U1B4RUdJVUIvVUJYak01MDhwMXl5dnpxekI0?=
 =?utf-8?B?c0lNd2VZd0syUVRNRFJ3akNXdkxFNWZGMlhFcUpITHQwUlV2NVJSd3Rkcldr?=
 =?utf-8?B?K3RmcDdHZ05QMnEyNGZHVHdJN2xNbzhNaENUVUQzYzMxR1kxdVhqakxXQ2dV?=
 =?utf-8?B?YnpHSFdhVjZkYXBRVFMvVU93emJ0RVU3V2lyVVVDd3g5bUcwT25yRUF1aXh5?=
 =?utf-8?B?TnluSmxIVThwOWUvelAyZjN5d2svcE45eHlFZ1VaWVRzbkRGVDV2RzNwZzlt?=
 =?utf-8?B?R2JJRDh5Y3U3d1B4aDhOR3JWMUxIR3RKS3BxbC9XSktUREQ2d3MyTXU3cUtp?=
 =?utf-8?B?dDJaODNDd01LczU1MDZqc0t5dlhRb3ZRUWN5K00xZG5SQ1d5SXBsWFEwT0VN?=
 =?utf-8?B?VThYRHdPd2tvY3gvTVdzVVB5Smxhcm5PQ1RVcTlZNHRkUTFveG5zVW5obmVl?=
 =?utf-8?B?STAzTkFuTGU5VEQxempBUUpORnYrbXlxa01ER2tjNmRiZmtCTzM4NDlXV0lm?=
 =?utf-8?B?K1JlL3hBK3lRY3QvWWl4cjVrNE1oRTdZUXBaK0M0aXlsSDAxOTR0OVQ1dkRq?=
 =?utf-8?B?SkdraVRuRStQdlByRmd3TmQyUUpZZHZDQ1NDVkgxUE5WdGQrVzRVMlc4OEt2?=
 =?utf-8?B?NEYyUFZCWk1CS0Y2aDFYd3FEVlpFUVhrVTNVcDQ0UzFLTVp5ZmUydlJGaTRk?=
 =?utf-8?B?d2RMS1JoQ2wrU2hhYlJwM2RUUjUxMENWQ2tLZWJuZ1gzMi9rYVcxQkVJK1c0?=
 =?utf-8?B?THJYU2YweGRSYWZKTGxJQlZnREZiYlFZcWhkL3lWeGNNcmZCakp0MDlvdmkv?=
 =?utf-8?B?eWgvVjBHRUtWWHViYUVkbWRvMHJOZ0kwU3FHTmlrS21hendFZXRhYlJRRUsr?=
 =?utf-8?B?WndKYStHcC9qY1cwZFdqNitiV01zU3czdmZJS2FpeEhrOFBubTJVS3NnRTVO?=
 =?utf-8?B?dHVwWmJDdDZsU0d1ek9YUWV2UTBWZEkxU1J1MnMvQXpDeVZ6NHltQ25vbk5Z?=
 =?utf-8?B?VW1yTysyMVIycmZZNzc4Tm9Pd2JyNVl2dTJvdFdMUVEvTE9ZdktLVklrVFNO?=
 =?utf-8?Q?D7dtrIkFaQyw9xDdtv2WDMVpL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe22f72-1c12-4e40-9a34-08de04da4e0e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 13:14:39.4875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dpfX2rZUXNR6S3GOEdNNhkA/sDuYSgw9/mWmrcRDCDlSFVfnqYcbEYMp+0QLm8xD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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

On 07.08.25 02:01, Ellen Pan wrote:
> 1. Updated previous layout offsets and sizes to _V1.
> 2. Added v2 layout offset enums for dynamic pf-vf critical region handling.
> 3. Added crit_region version in VF's msg[2] during REQ_INIT_DATA.
> 4. Added support to init critical region v2 during device init.
>  - After VF sends out supported crit_region version during
> REQ_INIT_DATA, PF would confirm back with provided crit_region_header
> offset and size.
>  - VF uses the offset and size to fetch critical regions' offsets in VRAM and
> save to local struct.
> 5. Added support for critical region handling:
>  - Init IP discovery table from dynamic offset from init_data_table.
>  - Init VF BIOS.
>  - Init DATA exchange region for VFs.
>  - Introduced ttm to manage critical region data in a 5MB chunk.

First of all when you make changes like this here please CC Deucher, Alexander <Alexander.Deucher@amd.com> for general questions about the driver stack as well as me (Christian König <christian.koenig@amd.com>) especially when you touch things like TTM code.

I had to dig this up from the mailing lists archive and that there wasn't any discussion on this patch at all is a clear indicator that people didn't noticed it.

Then in new feature development must be synced up before any coding is done. That neither Alex nor I could figure out what this is all about means that this didn't happened.

Additional to that when you make change it is mandatory that the driver keeps working on older hypervisor as well as newer hypervisors working with older drivers. How is that handled here?

In general it is usually better to split changes like this into multiple patches, one for the PF->VF interface change and one for the actualy functionality.

Adding calls to amdgpu_sriov_vf() all over the place is also a no-go since we want to keep the code generic and working for both SRIOV as well as bare metal.

Regards,
Christian.

> 
> Signed-off-by: Ellen Pan <yunru.pan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      |  12 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  90 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 354 +++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  15 +
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h   |  93 ++++-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  23 +-
>  9 files changed, 506 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index 00e96419fcda..2cbb24ede86e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -114,7 +114,17 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
>  
>  	adev->bios = NULL;
>  	vram_base = pci_resource_start(adev->pdev, 0);
> -	bios = ioremap_wc(vram_base, size);
> +
> +	if (amdgpu_sriov_vf(adev) && adev->virt.init_data_done) {
> +		resource_size_t bios_offset;
> +
> +		if (amdgpu_virt_get_bios_info(adev, &bios_offset, &size))
> +			return false;
> +
> +		bios = ioremap_wc(vram_base + bios_offset, size);
> +	} else
> +		bios = ioremap_wc(vram_base, size);
> +
>  	if (!bios)
>  		return false;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index f7d7e4748197..51157143135a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2716,6 +2716,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  		if (r)
>  			return r;
> +
> +		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
> +			r = amdgpu_virt_init_critical_region(adev);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	switch (adev->asic_type) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index efe0058b48ca..76d5e13aa837 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -292,6 +292,11 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	if ((adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) && adev->virt.init_data_done) {
> +		ret = amdgpu_virt_init_ip_discovery(adev, binary);
> +		return ret;
> +	}
> +
>  	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
>  	if (!vram_size || vram_size == U32_MAX)
>  		sz_valid = false;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 27ab4e754b2a..6a77d63d224b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1644,6 +1644,20 @@ static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>  						  &adev->mman.drv_vram_usage_va);
>  }
>  
> +/**
> + * amdgpu_ttm_crit_regions_reserve_vram_fini - free crit regions reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free crit regions reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_crit_regions_reserve_vram_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->mman.crit_regions_vram_usage_reserved_bo,
> +						  NULL,
> +						  &adev->mman.crit_regions_vram_usage_va);
> +}
> +
>  /**
>   * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>   *
> @@ -1694,6 +1708,31 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>  					  &adev->mman.drv_vram_usage_va);
>  }
>  
> +/**
> + * amdgpu_ttm_crit_regions_reserve_vram_init - create bo vram reservation for critical regions
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation for critical regions.
> + */
> +static int amdgpu_ttm_crit_regions_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	u64 vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.crit_regions_vram_usage_va = NULL;
> +	adev->mman.crit_regions_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.crit_regions_vram_usage_size == 0 ||
> +	    adev->mman.crit_regions_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.crit_regions_vram_usage_start_offset,
> +					  adev->mman.crit_regions_vram_usage_size,
> +					  &adev->mman.crit_regions_vram_usage_reserved_bo,
> +					  &adev->mman.crit_regions_vram_usage_va);
> +}
> +
>  /*
>   * Memoy training reservation functions
>   */
> @@ -1901,31 +1940,37 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  				adev->gmc.visible_vram_size);
>  #endif
>  
> -	/*
> -	 *The reserved vram for firmware must be pinned to the specified
> -	 *place on the VRAM, so reserve it early.
> -	 */
> -	r = amdgpu_ttm_fw_reserve_vram_init(adev);
> -	if (r)
> -		return r;
> -
> -	/*
> -	 *The reserved vram for driver must be pinned to the specified
> -	 *place on the VRAM, so reserve it early.
> -	 */
> -	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> -	if (r)
> -		return r;
> +	if (amdgpu_sriov_vf(adev) && (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2)) {
> +		r = amdgpu_ttm_crit_regions_reserve_vram_init(adev);
> +		if (r)
> +			return r;
> +	} else {
> +		/*
> +		 *The reserved vram for firmware must be pinned to the specified
> +		 *place on the VRAM, so reserve it early.
> +		 */
> +		r = amdgpu_ttm_fw_reserve_vram_init(adev);
> +		if (r)
> +			return r;
>  
> -	/*
> -	 * only NAVI10 and onwards ASIC support for IP discovery.
> -	 * If IP discovery enabled, a block of memory should be
> -	 * reserved for IP discovey.
> -	 */
> -	if (adev->mman.discovery_bin) {
> -		r = amdgpu_ttm_reserve_tmr(adev);
> +		/*
> +		 *The reserved vram for driver must be pinned to the specified
> +		 *place on the VRAM, so reserve it early.
> +		 */
> +		r = amdgpu_ttm_drv_reserve_vram_init(adev);
>  		if (r)
>  			return r;
> +
> +		/*
> +		 * only NAVI10 and onwards ASIC support for IP discovery.
> +		 * If IP discovery enabled, a block of memory should be
> +		 * reserved for IP discovey.
> +		 */
> +		if (adev->mman.discovery_bin) {
> +			r = amdgpu_ttm_reserve_tmr(adev);
> +			if (r)
> +				return r;
> +		}
>  	}
>  
>  	/* allocate memory as required for VGA
> @@ -2072,6 +2117,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  					&adev->mman.sdma_access_ptr);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>  	amdgpu_ttm_drv_reserve_vram_fini(adev);
> +	amdgpu_ttm_crit_regions_reserve_vram_fini(adev);
>  
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2309df3f68a9..aa8ed6524386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -100,6 +100,12 @@ struct amdgpu_mman {
>  	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
>  	void		*drv_vram_usage_va;
>  
> +	/* critical region VRAM reservation */
> +	u64		crit_regions_vram_usage_start_offset;
> +	u64		crit_regions_vram_usage_size;
> +	struct amdgpu_bo	*crit_regions_vram_usage_reserved_bo;
> +	void		*crit_regions_vram_usage_va;
> +
>  	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>  	struct amdgpu_bo	*sdma_access_bo;
>  	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 13f0cdeb59c4..24d25e4ed1b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -150,7 +150,8 @@ void amdgpu_virt_request_init_data(struct amdgpu_device *adev)
>  		virt->ops->req_init_data(adev);
>  
>  	if (adev->virt.req_init_data_ver > 0)
> -		DRM_INFO("host supports REQ_INIT_DATA handshake\n");
> +		DRM_INFO("host supports REQ_INIT_DATA handshake of critical_region_version %d\n",
> +				adev->virt.req_init_data_ver);
>  	else
>  		DRM_WARN("host doesn't support REQ_INIT_DATA handshake\n");
>  }
> @@ -423,10 +424,14 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>  	uint32_t bp_idx, bp_cnt;
>  	void *vram_usage_va = NULL;
>  
> -	if (adev->mman.fw_vram_usage_va)
> -		vram_usage_va = adev->mman.fw_vram_usage_va;
> -	else
> -		vram_usage_va = adev->mman.drv_vram_usage_va;
> +	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
> +		vram_usage_va = adev->mman.crit_regions_vram_usage_va;
> +	} else {
> +		if (adev->mman.fw_vram_usage_va)
> +			vram_usage_va = adev->mman.fw_vram_usage_va;
> +		else
> +			vram_usage_va = adev->mman.drv_vram_usage_va;
> +	}
>  
>  	memset(&bp, 0, sizeof(bp));
>  
> @@ -669,74 +674,137 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
>  
>  void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  {
> +	uint32_t *pfvf_data = NULL;
> +
>  	adev->virt.fw_reserve.p_pf2vf = NULL;
>  	adev->virt.fw_reserve.p_vf2pf = NULL;
>  	adev->virt.vf2pf_update_interval_ms = 0;
>  	adev->virt.vf2pf_update_retry_cnt = 0;
>  
> -	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
> -		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
> -	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
> -		/* go through this logic in ip_init and reset to init workqueue*/
> -		amdgpu_virt_exchange_data(adev);
> -
> -		INIT_DELAYED_WORK(&adev->virt.vf2pf_work, amdgpu_virt_update_vf2pf_work_item);
> -		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
> -	} else if (adev->bios != NULL) {
> -		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
> -		adev->virt.fw_reserve.p_pf2vf =
> -			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> -
> -		amdgpu_virt_read_pf2vf_data(adev);
> +	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
> +		if (adev->mman.crit_regions_vram_usage_va) {
> +			/* go through this logic in ip_init and reset to init workqueue*/
> +			amdgpu_virt_exchange_data(adev);
> +
> +			INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +					amdgpu_virt_update_vf2pf_work_item);
> +			schedule_delayed_work(&(adev->virt.vf2pf_work),
> +					msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
> +		} else if (adev->bios != NULL) {
> +			/* got through this logic in early init stage to get necessary flags,
> +			 * e.g. rlcg_acc related */
> +			pfvf_data =
> +				kzalloc(adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10,
> +					GFP_KERNEL);
> +			if (!pfvf_data) {
> +				DRM_ERROR("Failed to allocate memory for pfvf_data\n");
> +				return;
> +			}
> +
> +			if (amdgpu_virt_read_exchange_data_from_mem(adev, pfvf_data))
> +				goto free_pfvf_data;
> +
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)pfvf_data;
> +
> +			amdgpu_virt_read_pf2vf_data(adev);
> +
> +free_pfvf_data:
> +			kfree(pfvf_data);
> +			pfvf_data = NULL;
> +			adev->virt.fw_reserve.p_pf2vf = NULL;
> +		}
> +	} else {
> +		if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
> +			DRM_WARN("Currently fw_vram and drv_vram should not have values "
> +					"at the same time!");
> +		} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
> +			/* go through this logic in ip_init and reset to init workqueue*/
> +			amdgpu_virt_exchange_data(adev);
> +
> +			INIT_DELAYED_WORK(&adev->virt.vf2pf_work,
> +				amdgpu_virt_update_vf2pf_work_item);
> +			schedule_delayed_work(&(adev->virt.vf2pf_work),
> +					msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
> +		} else if (adev->bios != NULL) {
> +			/* got through this logic in early init stage to get necessary flags,
> +			 * e.g. rlcg_acc related*/
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->bios + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
> +
> +			amdgpu_virt_read_pf2vf_data(adev);
> +		}
>  	}
>  }
>  
> -
>  void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  {
>  	uint64_t bp_block_offset = 0;
>  	uint32_t bp_block_size = 0;
>  	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
>  
> -	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
> -		if (adev->mman.fw_vram_usage_va) {
> +	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
> +		if (adev->mman.crit_regions_vram_usage_va) {
>  			adev->virt.fw_reserve.p_pf2vf =
>  				(struct amd_sriov_msg_pf2vf_info_header *)
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +				(adev->mman.crit_regions_vram_usage_va +
> +				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID]);
>  			adev->virt.fw_reserve.p_vf2pf =
>  				(struct amd_sriov_msg_vf2pf_info_header *)
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +				(adev->mman.crit_regions_vram_usage_va +
> +				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] +
> +				(AMD_SRIOV_MSG_SIZE_KB_V1 << 10));
>  			adev->virt.fw_reserve.ras_telemetry =
> -				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> -		} else if (adev->mman.drv_vram_usage_va) {
> -			adev->virt.fw_reserve.p_pf2vf =
> -				(struct amd_sriov_msg_pf2vf_info_header *)
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> -			adev->virt.fw_reserve.p_vf2pf =
> -				(struct amd_sriov_msg_vf2pf_info_header *)
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> -			adev->virt.fw_reserve.ras_telemetry =
> -				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB << 10));
> +				(adev->mman.crit_regions_vram_usage_va +
> +				adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID]);
> +		}
> +	} else {
> +		if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
> +			if (adev->mman.fw_vram_usage_va) {
> +				adev->virt.fw_reserve.p_pf2vf =
> +					(struct amd_sriov_msg_pf2vf_info_header *)
> +					(adev->mman.fw_vram_usage_va +
> +					(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
> +				adev->virt.fw_reserve.p_vf2pf =
> +					(struct amd_sriov_msg_vf2pf_info_header *)
> +					(adev->mman.fw_vram_usage_va +
> +					(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
> +				adev->virt.fw_reserve.ras_telemetry =
> +					(adev->mman.fw_vram_usage_va +
> +					 (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
> +			} else if (adev->mman.drv_vram_usage_va) {
> +				adev->virt.fw_reserve.p_pf2vf =
> +					(struct amd_sriov_msg_pf2vf_info_header *)
> +					(adev->mman.drv_vram_usage_va +
> +					(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 << 10));
> +				adev->virt.fw_reserve.p_vf2pf =
> +					(struct amd_sriov_msg_vf2pf_info_header *)
> +					(adev->mman.drv_vram_usage_va +
> +					(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 << 10));
> +				adev->virt.fw_reserve.ras_telemetry =
> +					(adev->mman.drv_vram_usage_va +
> +					 (AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10));
> +			}
>  		}
> +	}
>  
> -		amdgpu_virt_read_pf2vf_data(adev);
> -		amdgpu_virt_write_vf2pf_data(adev);
> +	amdgpu_virt_read_pf2vf_data(adev);
> +	amdgpu_virt_write_vf2pf_data(adev);
>  
> -		/* bad page handling for version 2 */
> -		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> -			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
> +	/* bad page handling for version 2 */
> +	if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> +		pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>  
> -			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> -				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> -			bp_block_size = pf2vf_v2->bp_block_size;
> +		bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> +			((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> +		bp_block_size = pf2vf_v2->bp_block_size;
>  
> -			if (bp_block_size && !adev->virt.ras_init_done)
> -				amdgpu_virt_init_ras_err_handler_data(adev);
> +		if (bp_block_size && !adev->virt.ras_init_done)
> +			amdgpu_virt_init_ras_err_handler_data(adev);
>  
> -			if (adev->virt.ras_init_done)
> -				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> -		}
> +		if (adev->virt.ras_init_done)
> +			amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
>  	}
>  }
>  
> @@ -839,6 +907,192 @@ static void amdgpu_virt_init_ras(struct amdgpu_device *adev)
>  	adev->virt.ras.cper_rptr = 0;
>  }
>  
> +static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t *buf_end)
> +{
> +	uint32_t sum = 0;
> +
> +	if (buf_start >= buf_end)
> +		return 0;
> +
> +	for (; buf_start < buf_end; buf_start++)
> +		sum += buf_start[0];
> +
> +	return 0xffffffff - sum;
> +}
> +
> +#define mmRCC_CONFIG_MEMSIZE	0xde3
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
> +{
> +	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
> +	uint32_t init_hdr_offset = adev->virt.init_data_header_offset;
> +	uint32_t init_hdr_size = adev->virt.init_data_header_size_kb << 10;
> +	uint64_t pos = 0;
> +	uint64_t vram_size;
> +	int r = 0;
> +	uint8_t checksum = 0;
> +
> +	if (init_hdr_offset < 0) {
> +		DRM_ERROR("Invalid init header offset\n");
> +		return -EINVAL;
> +	}
> +
> +	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> +	if ((init_hdr_offset + init_hdr_size) > vram_size) {
> +		DRM_ERROR("init_data_header exceeds VRAM size, exiting\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Allocate for init_data_hdr */
> +	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
> +	if (!init_data_hdr)
> +		return -ENOMEM;
> +
> +	pos = (uint64_t)init_hdr_offset;
> +	amdgpu_device_vram_access(adev, pos, (uint32_t *)init_data_hdr,
> +					sizeof(struct amd_sriov_msg_init_data_header), false);
> +
> +	switch (init_data_hdr->version) {
> +	case GPU_CRIT_REGION_V2:
> +		if (strncmp(init_data_hdr->signature, "INDA", 4) != 0) {
> +			DRM_ERROR("Invalid init data signature: %.4s\n", init_data_hdr->signature);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		checksum =
> +			amdgpu_virt_crit_region_calc_checksum((uint8_t *)&init_data_hdr->initdata_offset,
> +				(uint8_t *)init_data_hdr + sizeof(struct amd_sriov_msg_init_data_header));
> +		if (checksum != init_data_hdr->checksum) {
> +			DRM_ERROR("Found unmatching checksum from calculation 0x%x and init_data 0x%x\n",
> +						checksum, init_data_hdr->checksum);
> +			r = -EINVAL;
> +			goto out;
> +		}
> +
> +		/* Initialize critical region offsets */
> +		adev->virt.crit_region_base_offset = init_data_hdr->initdata_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID] =
> +			init_data_hdr->ip_discovery_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
> +			init_data_hdr->vbios_img_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
> +			init_data_hdr->ras_tele_info_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
> +			init_data_hdr->dataexchange_offset;
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
> +			init_data_hdr->bad_page_info_offset;
> +
> +		/* Initialize critical region sizes */
> +		adev->virt.crit_region_size_in_kb = init_data_hdr->initdata_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] =
> +			init_data_hdr->ip_discovery_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] =
> +			init_data_hdr->vbios_img_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID] =
> +			init_data_hdr->ras_tele_info_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] =
> +			init_data_hdr->dataexchange_size_in_kb;
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID] =
> +			init_data_hdr->bad_page_size_in_kb;
> +
> +		/* reserved memory starts from crit region base offset  with the size of 5MB */
> +		adev->mman.crit_regions_vram_usage_start_offset = adev->virt.crit_region_base_offset;
> +		adev->mman.crit_regions_vram_usage_size = adev->virt.crit_region_size_in_kb << 10;
> +		DRM_INFO("critical region v%d requested to reserve memory start at %08x with %d KB.\n",
> +			  init_data_hdr->version,
> +			  adev->mman.crit_regions_vram_usage_start_offset,
> +			  adev->mman.crit_regions_vram_usage_size >> 10);
> +
> +		adev->virt.init_data_done = true;
> +		break;
> +	default:
> +		DRM_ERROR("Invalid init header version: 0x%x\n", init_data_hdr->version);
> +		r = -EINVAL;
> +		goto out;
> +	}
> +
> +out:
> +	kfree(init_data_hdr);
> +	init_data_hdr = NULL;
> +
> +	return r;
> +}
> +
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary)
> +{
> +	uint32_t ip_discovery_offset =
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_IPD_TABLE_ID];
> +	uint32_t ip_discovery_size =
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_IPD_TABLE_ID] << 10;
> +	uint64_t pos = 0;
> +
> +	dev_info(adev->dev, "use ip discovery information copied from dynamic "
> +		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
> +			ip_discovery_offset, ip_discovery_size);
> +
> +	if (!IS_ALIGNED(ip_discovery_offset, 4) || !IS_ALIGNED(ip_discovery_size, 4)) {
> +		DRM_ERROR("IP discovery data not aligned to 4 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ip_discovery_size > DISCOVERY_TMR_SIZE) {
> +		DRM_ERROR("Invalid IP discovery size: 0x%x\n", ip_discovery_size);
> +		return -EINVAL;
> +	}
> +
> +	pos = (uint64_t)ip_discovery_offset;
> +	amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
> +					  ip_discovery_size, false);
> +
> +	return 0;
> +}
> +
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +		resource_size_t *bios_offset, resource_size_t *bios_size)
> +{
> +	uint32_t vbios_offset = adev->virt.crit_region_offsets[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID];
> +	uint32_t vbios_size =
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID] << 10;
> +
> +	dev_info(adev->dev, "use bios information copied from dynamic "
> +		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
> +			vbios_offset, vbios_size);
> +
> +	if (vbios_size > *bios_size) {
> +		DRM_ERROR("Invalid vbios size: 0x%x\n", vbios_size);
> +		return -EINVAL;
> +	}
> +
> +	*bios_offset = vbios_offset;
> +	*bios_size = vbios_size;
> +
> +	return 0;
> +}
> +
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data)
> +{
> +	uint32_t dataexchange_offset =
> +		adev->virt.crit_region_offsets[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID];
> +	uint32_t dataexchange_size =
> +		adev->virt.crit_region_sizes_kb[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID] << 10;
> +	uint64_t pos = 0;
> +
> +	dev_info(adev->dev, "use data exchange information copied from dynamic "
> +		"crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
> +			dataexchange_offset, dataexchange_size);
> +
> +	if (!IS_ALIGNED(dataexchange_offset, 4) || !IS_ALIGNED(dataexchange_size, 4)) {
> +		DRM_ERROR("Data exchange data not aligned to 4 bytes\n");
> +		return -EINVAL;
> +	}
> +
> +	pos = (uint64_t)dataexchange_offset;
> +	amdgpu_device_vram_access(adev, pos, pfvf_data,
> +					dataexchange_size, false);
> +
> +	return 0;
> +}
> +
>  void amdgpu_virt_init(struct amdgpu_device *adev)
>  {
>  	bool is_sriov = false;
> @@ -1301,7 +1555,7 @@ static int amdgpu_virt_cache_host_error_counts(struct amdgpu_device *adev,
>  	checksum = host_telemetry->header.checksum;
>  	used_size = host_telemetry->header.used_size;
>  
> -	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>  		return 0;
>  
>  	tmp = kmemdup(&host_telemetry->body.error_count, used_size, GFP_KERNEL);
> @@ -1380,7 +1634,7 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
>  	checksum = host_telemetry->header.checksum;
>  	used_size = host_telemetry->header.used_size;
>  
> -	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB << 10))
> +	if (used_size > (AMD_SRIOV_RAS_TELEMETRY_SIZE_KB_V1 << 10))
>  		return -EINVAL;
>  
>  	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 3da3ebb1d9a1..f1498671e8a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -281,6 +281,15 @@ struct amdgpu_virt {
>  	bool ras_init_done;
>  	uint32_t reg_access;
>  
> +	/* critical regions v2 */
> +	uint32_t init_data_header_offset;
> +	uint32_t init_data_header_size_kb;
> +	uint32_t crit_region_base_offset;
> +	uint32_t crit_region_size_in_kb;
> +	uint64_t crit_region_offsets[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	uint64_t crit_region_sizes_kb[AMD_SRIOV_MSG_MAX_TABLE_ID];
> +	bool init_data_done;
> +
>  	/* vf2pf message */
>  	struct delayed_work vf2pf_work;
>  	uint32_t vf2pf_update_interval_ms;
> @@ -416,6 +425,12 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev);
>  void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
>  void amdgpu_virt_init(struct amdgpu_device *adev);
>  
> +int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
> +int amdgpu_virt_init_ip_discovery(struct amdgpu_device *adev, uint8_t *binary);
> +int amdgpu_virt_get_bios_info(struct amdgpu_device *adev,
> +					  resource_size_t *bios_offset, resource_size_t *bios_size);
> +int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, uint32_t *pfvf_data);
> +
>  bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
>  int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>  void amdgpu_virt_disable_access_debugfs(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 33edad1f9dcd..130f188ebb84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -23,26 +23,83 @@
>  #ifndef AMDGV_SRIOV_MSG__H_
>  #define AMDGV_SRIOV_MSG__H_
>  
> -/* unit in kilobytes */
> -#define AMD_SRIOV_MSG_VBIOS_OFFSET	     0
> -#define AMD_SRIOV_MSG_VBIOS_SIZE_KB	     64
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB AMD_SRIOV_MSG_VBIOS_SIZE_KB
> -#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB   4
> -#define AMD_SRIOV_MSG_TMR_OFFSET_KB	     2048
> -#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB	     2
> -#define AMD_SRIOV_RAS_TELEMETRY_SIZE_KB	     64
>  /*
> - * layout
> + * layout v1
>   * 0           64KB        65KB        66KB           68KB                   132KB
>   * |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
>   * |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
>   */
>  
> -#define AMD_SRIOV_MSG_SIZE_KB                   1
> -#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB           AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB
> -#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB           (AMD_SRIOV_MSG_PF2VF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB        (AMD_SRIOV_MSG_VF2PF_OFFSET_KB + AMD_SRIOV_MSG_SIZE_KB)
> -#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB   (AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB)
> +/*
> + * layout v2 (offsets are dynamically allocated and the offsets below are examples)
> + * 0           1KB         64KB        65KB        66KB           68KB                   132KB
> + * |  INITD_H  |   VBIOS   |   PF2VF   |   VF2PF   |   Bad Page   | RAS Telemetry Region | ...
> + * |   1KB     |   64KB    |   1KB     |   1KB     |   2KB        | 64KB                 | ...
> + *
> + * Note: PF2VF + VF2PF + Bad Page = DataExchange region (allocated contiguously)
> + */
> +
> +/* v1 layout sizes */
> +#define AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1			64
> +#define AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1		2
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1		64
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1		\
> +	(AMD_SRIOV_MSG_PF2VF_SIZE_KB_V1 + AMD_SRIOV_MSG_VF2PF_SIZE_KB_V1 + \
> +	 AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +
> +/* v1 offsets */
> +#define AMD_SRIOV_MSG_VBIOS_OFFSET_V1			0
> +#define AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1
> +#define AMD_SRIOV_MSG_TMR_OFFSET_KB			2048
> +#define AMD_SRIOV_MSG_SIZE_KB_V1			1
> +#define AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1
> +#define AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1		\
> +	(AMD_SRIOV_MSG_PF2VF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1		\
> +	(AMD_SRIOV_MSG_VF2PF_OFFSET_KB_V1 + AMD_SRIOV_MSG_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1	\
> +	(AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 + AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1)
> +#define AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1		\
> +	(AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1 + AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1 + \
> +	 AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1)
> +
> +/* v2 layout offset enum (in order of allocation) */
> +enum amd_sriov_msg_table_id_enum {
> +	AMD_SRIOV_MSG_IPD_TABLE_ID = 0,
> +	AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
> +	AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID,
> +	AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID,
> +	AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID,
> +	AMD_SRIOV_MSG_INITD_H_TABLE_ID,
> +	AMD_SRIOV_MSG_MAX_TABLE_ID,
> +};
> +
> +enum amd_sriov_crit_region_version {
> +	GPU_CRIT_REGION_V1 = 1,
> +	GPU_CRIT_REGION_V2 = 2,
> +};
> +
> +struct amd_sriov_msg_init_data_header {
> +	char     signature[4];  /* "INDA"  */
> +	uint32_t version;
> +	uint32_t checksum;
> +	uint32_t initdata_offset; /* 0 */
> +	uint32_t initdata_size_in_kb; /* 5MB */
> +	uint32_t valid_tables;
> +	uint32_t vbios_img_offset;
> +	uint32_t vbios_img_size_in_kb;
> +	uint32_t dataexchange_offset;
> +	uint32_t dataexchange_size_in_kb;
> +	uint32_t ras_tele_info_offset;
> +	uint32_t ras_tele_info_size_in_kb;
> +	uint32_t ip_discovery_offset;
> +	uint32_t ip_discovery_size_in_kb;
> +	uint32_t bad_page_info_offset;
> +	uint32_t bad_page_size_in_kb;
> +	uint32_t reserved[8];
> +};
>  
>  /*
>   * PF2VF history log:
> @@ -431,12 +488,12 @@ unsigned int amd_sriov_msg_checksum(void *obj, unsigned long obj_size, unsigned
>  #define _stringification(s) #s
>  
>  _Static_assert(
> -	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
> -	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
> +	sizeof(struct amd_sriov_msg_vf2pf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
> +	"amd_sriov_msg_vf2pf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
>  
>  _Static_assert(
> -	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB << 10,
> -	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB) " KB");
> +	sizeof(struct amd_sriov_msg_pf2vf_info) == AMD_SRIOV_MSG_SIZE_KB_V1 << 10,
> +	"amd_sriov_msg_pf2vf_info must be " stringification(AMD_SRIOV_MSG_SIZE_KB_V1) " KB");
>  
>  _Static_assert(AMD_SRIOV_MSG_RESERVE_UCODE % 4 == 0,
>  	       "AMD_SRIOV_MSG_RESERVE_UCODE must be multiple of 4");
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index f6d8597452ed..e1244cbee1c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -222,12 +222,20 @@ static int xgpu_nv_send_access_requests_with_param(struct amdgpu_device *adev,
>  				adev->virt.req_init_data_ver = 0;
>  		} else {
>  			if (req == IDH_REQ_GPU_INIT_DATA) {
> -				adev->virt.req_init_data_ver =
> -					RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1);
> -
> -				/* assume V1 in case host doesn't set version number */
> -				if (adev->virt.req_init_data_ver < 1)
> -					adev->virt.req_init_data_ver = 1;
> +				switch (RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW1)) {
> +				case GPU_CRIT_REGION_V2:
> +					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V2;
> +					adev->virt.init_data_header_offset =
> +						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW2);
> +					adev->virt.init_data_header_size_kb =
> +						RREG32_NO_KIQ(mmMAILBOX_MSGBUF_RCV_DW3);
> +					break;
> +				default:
> +					adev->virt.req_init_data_ver = GPU_CRIT_REGION_V1;
> +					adev->virt.init_data_header_offset = -1;
> +					adev->virt.init_data_header_size_kb = 0;
> +					break;
> +				}
>  			}
>  		}
>  
> @@ -285,7 +293,8 @@ static int xgpu_nv_release_full_gpu_access(struct amdgpu_device *adev,
>  
>  static int xgpu_nv_request_init_data(struct amdgpu_device *adev)
>  {
> -	return xgpu_nv_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
> +	return xgpu_nv_send_access_requests_with_param(adev, IDH_REQ_GPU_INIT_DATA,
> +			0, GPU_CRIT_REGION_V2, 0);
>  }
>  
>  static int xgpu_nv_mailbox_ack_irq(struct amdgpu_device *adev,

