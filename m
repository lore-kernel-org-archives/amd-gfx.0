Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88984C83F07
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 08:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2768E10E080;
	Mon,  7 Jul 2025 08:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ef4Ve0gL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9696D10E080
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 08:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vuN2L9SgtTTXrznKM1C99yURiEMiZxenaECckxgBvhFjg4t3MqbSfupsTcvOjEBjnfI/jq9nnvwXPnGeLIWNWcT4OYIxDGZvOJ7qXfn5Jg1dd6gnBKU5YKj4U/r9xJQ6bybPwQ5woyh6P/LvZpIKpw5niH2zCy1teyZBC5sdpj0Tqv1dE85kvJQi8VBfS7u5ovWaAn65MsPA/MHDaa3oKqRpADHn7lHqi6WpB7S33f+Zbb6zQg7TT76FSxzAHUVlP1s/Ai2ORmILOiA0wkZGUK90WLFvvPfMCTroOTMWJ0eRLKVme5aqr0cr5mInrfyVcvBnl55K0Gjq7Wns9fkTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XF6j6pUUEivyX/3hVV71U9GY3t1qRwk8h2nms6ANBI=;
 b=oV3UAiQMd0EgahWmrvtVUcKiAQ3uWy/uQCaTyprpMjYnV9bcosX9BBG+t4dPO7pCmVU2rJnffi95gODHjH6YduCPM+XCJDilGG8Xs4dgPcbRkXcauWOhAN3v48ibNS8WmP04oE13CZC5OAYiAglK4iCJKxoHOhjwytu9pFsdGMw0BhRJxiRlNm/SLAXnPWptYnrFQYEkTr3/pCTWVFUH91nZq+5C49QYwtgErdnZwPuE4HqNJz59pMhT1+TL6Jr4Zvx5YsBaeWL7JVU6/QGlqboaYXi8US3u0q2S3OJdj+whYvAvDTLj6J0F8TwjlM3XHZBavwsijggDMKH8m6HBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XF6j6pUUEivyX/3hVV71U9GY3t1qRwk8h2nms6ANBI=;
 b=ef4Ve0gL69ZaolkL/qZJkLQR8WepcO4ND5zDPy5NxssMO3CxSm2nPBvz5f5pwvXYRf4/szhzvIlHAVFowU9OxxqlbcNCXEIebc6OoPgyHbiD7mQ0HcYNpvLDhfHbg6CdKLG58ZZVgNXGA6ZVzxw3cNnb1GZ3o54MUZOW9AZwvUo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.25; Mon, 7 Jul 2025 08:28:44 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8880.023; Mon, 7 Jul 2025
 08:28:44 +0000
Message-ID: <a3323f38-1cea-4880-b048-a9a3f926fe5f@amd.com>
Date: Mon, 7 Jul 2025 13:58:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: refine eeprom data check
To: ganglxie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com
References: <20250707070939.6852-1-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250707070939.6852-1-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::15) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5835:EE_
X-MS-Office365-Filtering-Correlation-Id: 10198917-aa64-4505-03c5-08ddbd30490e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjdLdkswR3JXblhIK3l5Um5YYTN1M0NIOU9Fcm5pMlcwTE5YWFc1b0ZQc3pS?=
 =?utf-8?B?aHNnUytGblNSa3BEeTlETEdQaUVVNXJncTJqTUYzL0FudExvZmJnMThlRW5R?=
 =?utf-8?B?WEk1Q1llWGNSbDdaWmNRZlhJUm16VWcwQTZuaE83aDRlVGtDQjBkYmJvSDgv?=
 =?utf-8?B?aG83SkY3eXY2Z2MxU2E0RC9OdEEzYmhaeXF5SGY4bnZWYjBFUDN3b0hlRXVR?=
 =?utf-8?B?MHR4RFRXQWloUzBlZFdGRkJkdXhzeDZkL2lMVGVIdkxMd0NuZktzSitmeXh5?=
 =?utf-8?B?NndjV3JFN3dtMExSamRzOTYva2I1R01za1NBOWJGOGtLaXRBblBSaGFqY1ZW?=
 =?utf-8?B?TUV0VmVRM0p1MkNJa1ZodjVSc2Q2Yk1YaGh6UFhVZUh0SXB3WGk4L282WFBS?=
 =?utf-8?B?UFJtZ3B6TWdOamlMMDVSdmhFZXhzZnJRZnlma2NWUlp3NUowMDlkVnNPeU4y?=
 =?utf-8?B?L3VZSi9QbjAyUUJBS3liWFJ4aC9nNFVaTGJFb21VVmR1dzJWUkNoMFQzc3pn?=
 =?utf-8?B?UG1IRTZpSENiaXhGY21xS2RBdi9JRG5wUXlLcmxhUElhemlKdlJLdHloUHJo?=
 =?utf-8?B?Rm1ZOHBkT2crUVNqcU1mdzk5amlkSnJOdGxkenExQ01pbXY4QldiM1NCTGNB?=
 =?utf-8?B?UkZNSHRVS3IzbmF0THhYQUhDa3kxNWM0Nyt0NXZvUWJyU1l2bmduWlJtMnIz?=
 =?utf-8?B?VEt2bUx0WG1rOVNvVFZRNnZ1Wk5IK3pYNTREMEpYZlJQVmgxbHNMVGRoSTNa?=
 =?utf-8?B?OWJBcTFwaXFGUENGaDhWSFFHTkZvZHRzdnAyV055UHBDY013d1RsRFFMMG9r?=
 =?utf-8?B?Nll4WURoZE9nR25odC9ZeEhvNXkzYXo4RjNnWXJkNnFGQ01PczFIU3c3UVUy?=
 =?utf-8?B?WlV2L0NucnIwamlPczVIaVVBcDhLbEpzd05hVHEwU1lUak5QSWxSY0N1L2Jq?=
 =?utf-8?B?czYwZmRQREhTdVFSKyt1QjlNL0lZQ09yaTZMRnhWQzRSVVNaQk1PeFlhWno1?=
 =?utf-8?B?bWZWUVpsMFBlWWNPcU9KU1VJWWo2eHlFQ3dOditwdEc3QWgxWmRQb3BhelIy?=
 =?utf-8?B?MEJxN3RnWU50eTdBVVV6OVZRM052R01jbU5iTFMrd3htdmlLMDQwZzBzUjNp?=
 =?utf-8?B?bnI3RGdjSnZkREZJcmxYYkU0V1Q5UG8ycUdoZHUzNkdSSkxNWkVyYUMzMWpk?=
 =?utf-8?B?cyt1cUhtZmJnTkRYYXdjVEhuM1lFT0R4Tng5VnFSUGdTSHNTeWdhaWtzaUJO?=
 =?utf-8?B?L0lPVkd4SUVEK2tYWXJvY21vYzI4Ylh5TVB1Yi9lSjBEbWxQcm1DWnFxNzFT?=
 =?utf-8?B?eFlXeFI5bFVYeXVWV2pzZ0MzdFJWTWFpUUNzeUdycWFNb3UvRVBxSHNKVEc3?=
 =?utf-8?B?YkFkV0NQTnVJQTU2cWxrYjJOOFNsWHVFaG42QzBvSkZrc1UweDdtTGdkUlJI?=
 =?utf-8?B?bTlHRjlXa1JoOW0vOVMrcTZwbGVlWHRENURsVXBGTk14WlZUSmpkVk0wTnBy?=
 =?utf-8?B?R1M4U1Vtbm1HVFpqK2NmM3IzQlg3amo0end2VmR5cnE3Q3cvWjNtZHpUb2t2?=
 =?utf-8?B?Z3RJcUpTNFRZVmlRWnhTcHZZbDIrSkFrYjNUb2NwSVZrRVU4NEN5ampybU9v?=
 =?utf-8?B?dTNLZmNlc1pHeFVHV3cxSm5TZjB3K0dWTG1kK0FNSmF3WEl2bWVJVTlKcVVE?=
 =?utf-8?B?L3Q0YjZueXRxaE5YbUgweUVYOHBiS0IxaHNOakZuMDIraDd6UFcvNVZHcmRv?=
 =?utf-8?B?VjhLZUt6dWJiSnNhWmtITFZ2b1pkazFmTDJneG1vT1lTb2I2Rnk5aGt6eXV2?=
 =?utf-8?B?RGdFQ2FQdEpEZlBHdDVjcnc4eUxKaFVBcUZ6WSt5TGIwbHBJRXUyQ3FMWGZ0?=
 =?utf-8?B?VmkvTDc0UVEyazc0bHRYaTNITWxHR1JQM3NobUxaUGorSWpDQmhyS0pobzRj?=
 =?utf-8?Q?7Qgsu+ACVO0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG4rMkxzTmRjTUtKQ3gwL1ArYkpuRE53enZmOFFmRUFRMytIYlpWcUtqa0NQ?=
 =?utf-8?B?ZlhWMVNjY051eUtEZGlCbEx0SmIxekpncmhiV0J3eGswTnJ5ODUwblppQ2Rq?=
 =?utf-8?B?amcyWVJxZG9scEdOUmdNcjZrc2Eyamd0Qlo2S002RzJ6S0UzeENVcGVXNXFl?=
 =?utf-8?B?VXlJWE51Y2RmWHhMaHgxVDRWNllYZ0d4aHpOSnBEZnlEdkc3dmFsRWZielRZ?=
 =?utf-8?B?b1BtK2hrRXJlSWNLL3NNWGNPY25VcWtVUjNONUhkL3ovMlQvU3ZCVU5Mbzcr?=
 =?utf-8?B?VjUxL0o0cXZ3OWFwa3h5TlpUd1NIWnB0d2JYeGRWb0xBL2M2Tk4xdDZiMmxG?=
 =?utf-8?B?cS9iN1REeUE5djVHS2FKTUxMWmVJR1JCbGN2TnozOXpLNXp1OG4vVU14OExz?=
 =?utf-8?B?K0pwcGtUM2FiTUNteEJEc1kwcjZBMzZ1K2ZVZnBES1R2Zzg3a0lKRmJEYy9U?=
 =?utf-8?B?MW9zZk8ya1BYbHU1K0w2R2FYNUtTSGRtSXJlUlNDZW9jMFFXV21mVGxiZU1o?=
 =?utf-8?B?NzIwT25zTTdTTlVyZmZxeVNDdEswbW05RGEvMXBvKzhZQlBUSEUvUGZuRVkw?=
 =?utf-8?B?WklFdTVLWklPZmxPZGF3OW1iKy84ZHFIQkZSWDk2b0UxY1JkcWd5dHl1bHpS?=
 =?utf-8?B?dXNtdUp1NS9VSzJGVCthaWw4dGtYaEZBMXRyR2dQMkdORkRRSGZhOFFydlJa?=
 =?utf-8?B?c2djTGFmUTFBTElQd0Z6Sjd0RnlMbHJmRzY3ZWJyUWF2Q2U3UFBKeXlJVmpE?=
 =?utf-8?B?WFJiQjFkSmluOXZmNDVYQUI3VmVMMGdncHZSOTBieVFvNThDbVkvNXIwNnMw?=
 =?utf-8?B?eUo0KzVQZmIyakV4MXZEcmRvdEVRajVBM1FodU9QWjh6TlgxNlNxdWpzZFhk?=
 =?utf-8?B?NFhsc1RtSndEclZMR3VOWHBCbFlhMXl4NlAvR2Q2TUljWGZjTVRQMGk0ZFdq?=
 =?utf-8?B?NHJFZ3lLTzV3b1Q0Q292MTloQ3pnd1I4aW9pVU9OMGRramdGeE93ZXkrZ0tF?=
 =?utf-8?B?SnpZQmwySWw4NkRVUXJZT24xa21jTktCNVU3QmQ4RkVMMUdRY0NkK0orODhw?=
 =?utf-8?B?N2dGb2RiUjhpM09aZWRvd1NEMjF2S1VtbGZFVzFoRUNnVitFQ0dIQzBZZHpr?=
 =?utf-8?B?QStSNmhiVlRhVWMzSFIrejNKZGphM1ZNSnFiandlRGZZTjlWVG01dmdWcDQy?=
 =?utf-8?B?NVpsU3pFOTlRbzRRVGVHMXg5TC9sWEc5dXU2RFpjeVl0SGtnL0JYYWpjY3dY?=
 =?utf-8?B?d2kwZHlBdHd0U1cvaVlMOXNSU3BCa2VQeXdVOGcxeDV1Z0RYV1Bxa2FRa3E0?=
 =?utf-8?B?QUgzK2Q5SU9sbTFnUjRHYVNCZWdkbE4zSmhoemg5MkgxV3dSaWxMQnFnZHJk?=
 =?utf-8?B?OE14S0Q4YjlLSVIzSDRWV1RLY21tbnZCS0Fiam5uSnZkTjhZdkhHYlA1N3Fu?=
 =?utf-8?B?QU0rcmJDNS9sWGlSMjlIRGdlL2RhU0VKSmpGM1BVdlA4V1RvbnFYT2JUZU9W?=
 =?utf-8?B?MUJ5c1A5eGsxVGVTZmczSUtYMXpHcmtXTnFRTUhnVGtYRkxOSXlqdnhSUVdl?=
 =?utf-8?B?MC9yU2U2VzNscFp2ZTk1dlNkY3ZDRUI3d0RBUUU2ZVZiaFVsR0dza3NCR0dz?=
 =?utf-8?B?YlIyWGVianJ5WTdCcFNTWERYWHhaWUZRQjRsM3o4b3c5UjlBclhmTFlzNnJT?=
 =?utf-8?B?bytjTXNNeTg1YnJGN3gxZlhNNFZtaTlyNmhiK2FySC9pSDMrTitGRkRxM0tU?=
 =?utf-8?B?cmptS2hiam9wck1xWVVyRDVhNlZCclBSSEkvMHU2YW1MYmVmVXVSL0tXcHRK?=
 =?utf-8?B?MUJkdlNYZnVkc2dINkRzbDFUa1FkSlJxUy9MVFh2VUxadTBCc1dBQ1UrS21H?=
 =?utf-8?B?czlJQVlPUzQwNzJPVUdsTHdKaHNlOUM5VmJheklhL2ppZUpnYVJZUVB2Vm1G?=
 =?utf-8?B?NU9JR1ZsaER1Q0RQWkpiVnkxbHZ0T0FlYjRsVFhPL3A3ZGZpNEc4ZlFsdEFQ?=
 =?utf-8?B?SDBRbXkvOTlGZG5id0pFWUtRdDJvTzRIcDN2UDNoSXZXc1FMWmNicXpPMHp4?=
 =?utf-8?B?N2RFUm1PZDdLQUpIZlZFeVlPSnhwb25GbEk4MzkzMnF0WU1wbm11MFVyYzM2?=
 =?utf-8?Q?pMhTxhTVticMdSUB/Ek04cvDR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10198917-aa64-4505-03c5-08ddbd30490e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 08:28:44.0660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npOXaqiYW3E3nq5UtEZ5INwc+OIrjtfJMqEI7C3RC/0GSFOoQueSFLXPJUXn4oG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
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



On 7/7/2025 12:39 PM, ganglxie wrote:
> add eeprom data checksum check after data writing, before gpu reset, and before driver unload
> reset eeprom and save correct data to eeprom when check failed
> 
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 ++
>  6 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84fcaf84fead..ecdebca7f3f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6506,6 +6506,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	if (!r)
>  		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>  
> +	amdgpu_ras_eeprom_check_and_recover(adev);
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	struct drm_device *dev = pci_get_drvdata(pdev);
>  	struct amdgpu_device *adev = drm_to_adev(dev);
>  
> +	amdgpu_ras_eeprom_check_and_recover(adev);
>  	amdgpu_xcp_dev_unplug(adev);
>  	amdgpu_gmc_prepare_nps_mode_change(adev);
>  	drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f8a8c8502013..e03550be45b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  					 err_data.err_addr_cnt, false);
>  		amdgpu_ras_save_bad_pages(adev, NULL);
> +		amdgpu_ras_eeprom_check_and_recover(adev);
>  	}
>  
>  	amdgpu_ras_error_data_fini(&err_data);
> @@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>  		/* The format action is only applied to new ASICs */
>  		if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >= 12 &&
>  		    control->tbl_hdr.version < RAS_TABLE_VER_V3)
> -			if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_eeprom_reset_table(control)) {
>  				if (amdgpu_ras_save_bad_pages(adev, NULL))
>  					dev_warn(adev->dev, "Failed to format RAS EEPROM data in V3 version!\n");
> +				else
> +					amdgpu_ras_eeprom_check_and_recover(adev);
> +			}
> +
>  	}
>  
>  	return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..2458c67526c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control)
>  
>  	return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_eeprom_control *control = &ras->eeprom_control;
> +	int res = 0;
> +
> +	if (!control->is_eeprom_valid)
> +		return;
> +	res = __verify_ras_table_checksum(control);
> +	if (res) {
> +		dev_warn(adev->dev,
> +			"RAS table incorrect checksum or error:%d, try to recover\n",
> +			res);
> +		if (!amdgpu_ras_eeprom_reset_table(control))
> +			if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +				if (!__verify_ras_table_checksum(control)) {
> +					dev_info(adev->dev, "RAS table recovery succeed\n");
> +					return;
> +				}
> +		dev_err(adev->dev, "RAS table recovery failed\n");
> +		control->is_eeprom_valid = false;
> +	}
> +	return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct amdgpu_ras_eeprom_control *control);
>  
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>  
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bfc86f1e84e5..f36fe46541ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,
>  		amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>  						err_data.err_addr_cnt, false);
>  		amdgpu_ras_save_bad_pages(adev, NULL);
> +		amdgpu_ras_eeprom_check_and_recover(adev);
>  	}
>  
>  out_free_err_addr:
> @@ -168,6 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
>  			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>  						err_data->err_addr_cnt, false);
>  			amdgpu_ras_save_bad_pages(adev, &err_count);
> +			amdgpu_ras_eeprom_check_and_recover(adev);

This doesn't look optimal. Reading the entire EEPROM each time before
going for RAS recovery is not ideal. At minimum it should have a check
whether the save failed, and then consider saving them later after the
reset.

Thanks,
Lijo
>  
>  			amdgpu_dpm_send_hbm_bad_pages_num(adev,
>  					con->eeprom_control.ras_num_bad_pages);

