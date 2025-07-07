Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DA6C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 09:27:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 672DC10E316;
	Mon,  7 Jul 2025 09:27:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IimDax4o";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A1110E316
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 09:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLt86/CAhN3w3f7Aceklhhx1OQRxcq1YxuD0V0wMxjdXvZEMOvTfJBI/N5gL8NjL3JVfZhuy+2d9ysSsrduFACBzqrw1XR6rKLoWYSzusfL26RfLD+mNU7SHew6ElDG1KLqirPDcgymEt2acKyqD8UCJ8PRKrkqjgBHiKvu049mRbdWrD+wj30vBnPiPXd6tl4wYi1imdqF4VMDkCNEx2zJ1chYbdkrlQFZHGao6TIs/EFTRcE0NQyjCXqAessCZv6QrdGBDHKGMkMSw2ZRF0aswzU+PvpS1pVf0TIDy1G48uI0iu20Xd30n/U/P5UQlVbToszq3ug3JO1IurJfMig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0MIJrUbLrTiwnJfdag8ySuuXT9smj25dSNWKxBzGP0=;
 b=jN0td18X9pXg4dajknfdlwLV2ccbob1Aw82asxedq3OwZenROt/kqc70wo1R/87q/72yR85kumpr3J3582N0GLiPihA3C9t30R07LSSwM1aSdwwhUb7gsU5Q2yT7NCHF3uhGFCeftsV/RKOx75SMRyYiDy9/nJ4sx9UVBHBikxqq/8rSA8U/MqXPaoAPiFxddk+OkGWpVgZczYYJc10MxruoepzcO3pxbg/M7cgdiExzVIUYvIutWKs9QXVFFP9/QsZpGMlz/sDdA1B8TmOgyCqFCxA954El50yTGQyb/pZEtxNfurhzzF6uKAiuQq5fIClBj/UWjj+Fi/4oLrbZrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0MIJrUbLrTiwnJfdag8ySuuXT9smj25dSNWKxBzGP0=;
 b=IimDax4o3FkiMQWHKt1+v/CdphL+cXnkes6qjxGAPPNdHVxb+pj0SURD0e/AWEm3I/9Gv08V/czKWYRJkjqE3nAg3fSHHc6Sesi1NAEsk7thDwwX5sek0Hpjuz8pOulkEDoOjA7lsU6QgMWDnJHAH7z4HH40jeydpuM7nOfVxW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 09:27:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 09:27:46 +0000
Message-ID: <4974d335-2b5a-46c8-a832-6ad1ce642e7e@amd.com>
Date: Mon, 7 Jul 2025 11:27:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] drm/amdgpu: rework the userq doorbell object
 destroy
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250704103308.1325059-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: c32b5cc9-b079-4144-4b12-08ddbd388879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N28vdzFKcTBkU28yT0VhSlNORjNnYlB4aTdNVUEvN2U1TlhZQUQ3bXE5NExa?=
 =?utf-8?B?N2NZYmZ3UGFycGJoVUxMWlZwRHYyaExhNXNRQTZMOC8zMDRiVUM3ZU9tMkNJ?=
 =?utf-8?B?VGN4Rk0veTdHSkJtL1RFS3d3ZVcrNDAwUVFYY0lvWmdxUHRud1VBd1FvZlBi?=
 =?utf-8?B?TllTdk5uaTJXaEdUTGl4OVNDNG55TWlNc2U4KzdmZzMycXVObkxvWjZTQ2pE?=
 =?utf-8?B?ME9hRFY0cWhzSHlRK200ZUYyait2a2U2M0dOMFh4Z0ZUR0dCa2xiVE83dGlv?=
 =?utf-8?B?SmNBQ3JVUERpeFFGZWlyQktqL3ZBbXVOOXZEazlXUnBzWEQvWlRnck1qRVRV?=
 =?utf-8?B?bDd2N0JweHFnTlAyRGFxdmpaV01XUGwwL2JsUitjaENQQUFxTm9NbENueURp?=
 =?utf-8?B?TjErczV4WjY4ejNkMDZwWjZaMjNEbWpaMlhLdEc4L0FVYmhZL2t2RXdVakVW?=
 =?utf-8?B?SldEM2dicndmTnNlcmlBQUtCQWdndTVGS1NycGs5Qll4WUVxa2tuK3hGMWUx?=
 =?utf-8?B?SjFIR21uTTZib2QxbEY0Sm05QlBvVXoxRThON2RXMmJVL3F2VzU4RUJmYTZa?=
 =?utf-8?B?UnRqTFJiU3EvRGo4Y3hQVzljU1dQN3JJdFZDNTViemlVeTAyZ1ZScTk2eTFH?=
 =?utf-8?B?SGhSMHBSRlNmaW93TmFYdEQ3TTBQQVh5QUtic2ptaFpSREhaK1FQRTR3WXJl?=
 =?utf-8?B?MDE1NTRkT24zcHBtMXowWHVuZ05ZZjZTMC91a29aVEVQZVJsUEorT3owbldy?=
 =?utf-8?B?YkhyalRRNGVyd291bjI5c0ZCTmZDMkFGTVhGb0lLb09COXJyRFgyWEpkSm15?=
 =?utf-8?B?TE1lQnhSNEVIekJ3bXlYbW1IZTFWZ3dPOUNWMStyQzl0bFVvc1FkYzQraXd0?=
 =?utf-8?B?T0JiN3BERDM1ZGlEVHBuSDZCNTBLTGRCOUZlL2dLSTNwZ3JKMFFpUmRoNGpU?=
 =?utf-8?B?WVVESkVnTGFFUWZ5NVJwclpyVGdxaU5CWU50Q2dZUEUyYVp5SGVhdVlzRHVy?=
 =?utf-8?B?cWIrWVFqWW4xQ1lxWmhsNXJicXhsZC9SVGVBU2dwSjM2QUk0K2Q4ckY3ZTVM?=
 =?utf-8?B?L2ttWGxGUXd6STFjMDUwLzRXd3JaQ2gvYjhXMHRzQVcyWW9lQXZBazlKVGtN?=
 =?utf-8?B?UStnR3RqcnU3TVQ5YWxvQWNOSzZiTkFOcjBnVVp6MUlaSDgwWDdiT01ncy96?=
 =?utf-8?B?U1dnazErWTZLWFFYRFRjSjZwQnNqcStBQkJKUFNJK1pndnRpbUloSU9TOWl1?=
 =?utf-8?B?QmRYYTdaQ2hiZWJRZGhGd0ZxcVBabUpVK0srb3ZXYWJwbEpPejJzK0srV3J5?=
 =?utf-8?B?ZWlsOTkrN3BEOUNWRnlVVEMzZWpRS1ZIVkJGTjhLNXl5SG00WStTVTVVeVBt?=
 =?utf-8?B?SDAzTzBaUDVpRnhMbWp4LzdTTkpHNXdOTzU0N0NDWkJsb2Q0cHM5eGZUdWZv?=
 =?utf-8?B?dXlaVFo2S1hNdFFOYmFKN1IwYi9XSldBeTk3U1d5V3BmN1NPUFUwcTUvSzVl?=
 =?utf-8?B?NWRNS1BjKzVOQ1ZDaDRZUzJ3bjV0MW44SndTMXQxd1dRVC8rWmFIQmYrT1Rt?=
 =?utf-8?B?RW1TYUY4NUJtbTc4Skl1dzltUTBZdzVaRGJCaWJuWDFTWmJJY2pUSk9NNVFB?=
 =?utf-8?B?NWp2MlBqT1lTZzRzbkVYMHlsZ3FnV2Vkci9ZMll2WmUwQnlYbmxubWQ5b1ow?=
 =?utf-8?B?NGJrdmxVeDlUTnp6eE9WdjlEaW53YktEUGZ0Z1BETDZuRFVZZ0tUR05JS256?=
 =?utf-8?B?NU85anZRR1lEVjBiU0tLUThOWUpzNDBpdG1wUkFRSm8wK2o0dDdjYWlpTXpj?=
 =?utf-8?B?V3NOWmM3RFVTenNtR1lhT1UyQmgvVE5sS0JtM2FkZ1FyNU01MlVzMjRwOUF3?=
 =?utf-8?B?dE9yOTMraWRNU0R0UFd3cnRIOWtPclpIZlhNOTFEQlVNck02OWtrZUFkUWxQ?=
 =?utf-8?Q?g3jvGsTd7F4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0hvb0dNU0dPOXBvSVJiVWxFZE9JYlRwTGx4bjhjRUtTZ2VTeC9BcXpkVDV0?=
 =?utf-8?B?TTFybndDanFPeEdHWUEyTE5xSG9KbUI5NDR3cmhpcGZkUFBJSHpMMjBIa3ps?=
 =?utf-8?B?S1RtOGt6VCtVWUp0WFFyaGNQd28yTHJUa0l4d0hYT1QrcWdaMHUwMEFVdXdL?=
 =?utf-8?B?WVBCaFpJb1VZQ3BtUEdxSFp2ZUc1eHJiUzM3emF6cGw3TWtRekY1WHdDZ3Qr?=
 =?utf-8?B?NkVXQWgxVTFHcjNKRHVseG41blExZCtFaXZPaTBHclVwMUdIQjNNQUpPemE5?=
 =?utf-8?B?a2crOWFrNjRGRkdrUEhFMlIzczU4UDNaTG9ibEV3OGNsUmNxZ0xLL1JXbG9F?=
 =?utf-8?B?QTVpVGVvOEpCQmxFOXEzOG5TMjhneUY1VEdzTjFnMXZIYzdVb3pURTd2ODdw?=
 =?utf-8?B?WnBTbFdNclEyVnBPVkpnTFJ1OUZtb1NCa0s0TXpwL0t3d0VkL0NlVVZ6UTZp?=
 =?utf-8?B?U2xQS0hhZitEdFFYVG1ZMC85NlRObzZDZVRIdVZONzdmakd0RGVWemt5VzVR?=
 =?utf-8?B?d3NTSlVNTkl1SDkxbVJIa0t3WXovZWE3RUlPbEJHVERBWlZXamFxNmFMU2Fu?=
 =?utf-8?B?YUs2ZXpSMVpNNXEvOHM4VWZaSElhVVVYVGZEZWFZRWk5OGF2TmJ1OXZDc3BK?=
 =?utf-8?B?QWc0eVloYXFWamNUcGMzcktFUVNKS3JaakFlakV1T3FtSGhOOG9FN09xbkh3?=
 =?utf-8?B?cFVCclQvZE5DNFA2NHlpS01NVE9PdXhEWVQ2MTU3RmtkNE9RbnpnV2xOWmxa?=
 =?utf-8?B?ek9aTzRrUDMvTzdzWm1wblZ6eEdYMkh4c2NBSVUva1JDSnNYdW9wY0pEemxK?=
 =?utf-8?B?TlNXYVlwMGlBRjlNeGZsZUYrWWFRMndSaTVNeTFubVhmMXFJS2o3a0ZXN2tr?=
 =?utf-8?B?UXYzOHdwWWpyTGkrbzg5R1k0dXM5UWhZbVNlZENKOHNTQm9oY3NiQldwTWdq?=
 =?utf-8?B?bDJJaWZEWlBHL01wUXZOR1R0VFgvVTVvQ3pOUzNNeEhxQjNuTmxYSzlXOGtW?=
 =?utf-8?B?Zkkza2tJQWFvbGdTZUc4WnVYSmc1RmYyaGNOemppWWJrZTN3MXZqY21hSWtK?=
 =?utf-8?B?NEdTU2wvZmdrZGk2aUJ6Q2xCVUdxamU2dm1oNUdsNkFkR3IrWjBvQ2VLNTNY?=
 =?utf-8?B?RTg2bTdKemhnNS8yNjNYWDBnTTR5RnRjdVBrbE0rakM4VzZ1dkFWTFJYcGpq?=
 =?utf-8?B?ZjVSRHMvSFlHdlVGaHk5RDAyb3h2S1hOMUp3RTdWWGo4V3BhKzZrelVtNE12?=
 =?utf-8?B?bG5iZm5qWXBEU0JHbkdoUDNob2lMQzNCbG9Zb0M4WWxZWG13TkNGM0hvdXVa?=
 =?utf-8?B?YzUvSXdOVi95dGtUSEN6UDYzZVNoMFVOdlBNNTYvMk5OSlNDeTBpVC9vQjAv?=
 =?utf-8?B?T29ZWmFKYUsvNFZJQ0d3VDdiRFJMVjhvMmF1dURBSFZRcTZ0TmtRV2UzWWhY?=
 =?utf-8?B?dk83RnM4UzNOTThMUE9UdGh0SFhoQzRYTXJGVncyVllUMXlaYmdaTnkwNk9C?=
 =?utf-8?B?UUNBbEtnQjdxWXIwVEE0T2VmQWp4N1dPTm9sRzZRdEJveGtuazV1NmwwbG14?=
 =?utf-8?B?OG5vZ251WXZBR3BhN0tCVFBtSFZVdWxzeG1YYmxESEthTk9zK3VCdk5UZTJK?=
 =?utf-8?B?NG5NeS8yUW9KZVJZS0ZWNmhrZmE4ZEVISFlHdnRZSmVYQk1TenhPTTJXdDFR?=
 =?utf-8?B?RGlHYjUrTVFhS1dHM05jdjhWak1jaUxHK0ttUThmQVVEeCtNTFAyTi9JTXJQ?=
 =?utf-8?B?ekd3dkVqN2Z5Z0tLekN0aEFKSzlYdnJhdm1hQkRNNklEdnJFbmk1VG53b1Ew?=
 =?utf-8?B?MnQ4L0pkU3ZYNlUvejA2T05YVE5kaE1YMUZwK2tiSXlVWnRQRUlURTI1Wk5u?=
 =?utf-8?B?ZEVHOGR3MEtEbS9BV2xEUVNadHlXY3dSaEhPbTNTeVVuZFltaDdxb1VSaTEy?=
 =?utf-8?B?SFdyL041ak5EU1RxZFdJRms1T1B1MlpCQ2RjSkh6dDRMZXAwRVhoU0xYbk5L?=
 =?utf-8?B?WktnUG00WVBMRmQrbmo1YjZjN2ZkYWFWVEZpeHl1OXpteGVaTGZqYzF1Ny9p?=
 =?utf-8?B?eThtRkcrTnlsL1N2ejJ4dFFBakVnR0owZDJQVDlhOTRHNHg5bytVQ2tsZXgx?=
 =?utf-8?Q?yDjwwfLnOIagGl2oAhC1SHARt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32b5cc9-b079-4144-4b12-08ddbd388879
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:27:46.4477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +P4JtdsQvxYREDOtF+/YVcLFS28OzBbc+2yr5BtJr+cOAxnoHebnRmYHUc/IeD9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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



On 04.07.25 12:33, Prike Liang wrote:
> This patch aims to unify and destroy the userq doorbell objects at
> mes_userq_mqd_destroy(), and this change will also help with unpinning
> and destroying the userq doorbell objects for amdgpu_userq_mgr_fini()
> during releasing the drm files.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 1 -
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3d2a7f8946cf..f1c41b1114d0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -317,7 +317,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
>  		amdgpu_bo_unpin(queue->db_obj.obj);
>  		amdgpu_bo_unreserve(queue->db_obj.obj);
>  	}
> -	amdgpu_bo_unref(&queue->db_obj.obj);
>  	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
>  	/*TODO: It requires a reset for userq hw unmap error*/
>  	if (unlikely(r != AMDGPU_USERQ_STATE_UNMAPPED)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 1457fb49a794..dbacdfcb6f7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -336,6 +336,10 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>  		      struct amdgpu_usermode_queue *queue)
>  {
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +	/*Validate the doorbell obj whether has unpinned by amdgpu_userq_destroy()*/
> +	if (queue->db_obj.obj->tbo.pin_count)

Clear NAK to touching the pin_count here. That is clearly broken!

Regards,
Christian.

> +		amdgpu_bo_unpin(queue->db_obj.obj);
> +	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
>  	kfree(queue->userq_prop);
>  	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }

