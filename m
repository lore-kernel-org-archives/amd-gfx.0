Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9DAC36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FA810EC18;
	Fri, 11 Apr 2025 16:17:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RozXFSO2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D397A10EC18
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:17:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ec2y2uUuStzfXx1Frrx6eAtClyc+Cq2o6SvDYMQlHyklNaNLlmKq3U7rmjy+IVS2QdCxuJ+Pcvr+UR2304uM4xnTn1uA7wJmzeIJUq7QxLXwzWAB4BoduHdn1VqRXieL1pmbR/GogoQlcVa/r/a8JjBIYbm2pz+PRnEIfk9b+NXf4BmTCKRE3tKKlpWEjd++ca7rs6Z+fvmxjMbC+aGSOzg7o1XCLW4P+PZxmubYwnE7Ov7B2NbG9YYCQVUY+fLY0eqjei5zhzEXOfPKokY+pqmlQ5nDlqBrSehRE8ENUDgtNhGFpHFyIg9vYo86Xatz0T1bO/wePLF3P3je57B9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSYj7dDEhOEVntotda22+0HzuoQ05CSozWZw1i5B5aA=;
 b=jBhSgs1EWOeSw0Lahs6IbMVYZGgXibb197w9dotN5hCEd/6TvJoddtSfLLboeYg/u9sg6TCevvwIeL9uOvm9uIVQf0yylqj93tPQGWkYlU/THFi+P+2wW3P5bOlw4/86AKEK4vdKitoqTgJ0PAEBggXfQ5NJEOg1arApmVnKffyPZZo5nV04DjqWwOGJ3lSNCp9II8oSDjv4XBrTGpMmGp64pwGNSmVn7cxyxCobFxDLVtuVt3O8JmpTl7Uma9A2zLOfzlBKT27WD7DUwlfkFmr6qqEOWsererb4ufNlLmns9hmQY6toNknuSbN4jiB9PUAV+UfJHB3yW3k0WZxEig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSYj7dDEhOEVntotda22+0HzuoQ05CSozWZw1i5B5aA=;
 b=RozXFSO2zhTI+0RLdtxOz2mnbquEEfmcuPo0ASfU1w2X5IfYFMTg+3yZJNPZ/BdIiZbsk/j+QbDiBeeAmghykD7XINP6I48KRymfMSujbY5AfSD6dL9YgQ7X0XC53m4YAR3NbpqZZiC4xuhVHPvz7hORwHyZJ7r9b+mC4rt0UE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:17:18 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.021; Fri, 11 Apr 2025
 16:17:18 +0000
Message-ID: <837e1e3c-cbce-4d55-aa47-b6a35fdc104f@amd.com>
Date: Fri, 11 Apr 2025 21:47:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] drm/amdgpu/userq: add helpers to start/stop scheduling
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250411141228.2722962-1-alexander.deucher@amd.com>
 <20250411141228.2722962-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250411141228.2722962-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::30) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 38550847-5923-477c-422c-08dd79145472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDdwUXIwZnRCZXpKTGRhTG1zNXlyQXBzOFVXaDlhWDdxZGpoYVREWDAveUJC?=
 =?utf-8?B?MGVJOHMxb3pGZ1dnUThERjNNTi9iSGJVUmoyaEFISWdWcW92ZWhaWmFpdHdx?=
 =?utf-8?B?dnExZXI5d1I0R0wxQ21nUkk0RVNyblpGVElnRWZJOTFwQ0dSMlhnYThoUGlW?=
 =?utf-8?B?K1RUS0h5YUJzL0dkd0FUc1ptU2pyRU9ST0ZOU2RmMXg4cnZzR0tMUEVqQUVV?=
 =?utf-8?B?RUh5d3d1eE1TbGduLzVSZm5sWUx1aVNBUWE3ZzFXaW9jTHgrdWRPS0VOOElL?=
 =?utf-8?B?akYrNXJqK1dMa0JlM3ZOcW1zdmtpTVlLQ3BhcDAyS2RrK1NrZkNJTXZVNDU4?=
 =?utf-8?B?Z3lDZnN2Wm01RzlFQ1JHc1dXRHJIUGQwWFpwRENNNi8zT3VlUFAzTnBhOFRz?=
 =?utf-8?B?WEVRWENuZ1ZySUY5Z0FFMHZNN0ZDbUtrdTRVUUFITXRNYjFlVzBQZkE0Nlh5?=
 =?utf-8?B?RG1yWnE4TjV2elBuZmNkZ0JMZ096T0hjenBTUGxkd1V5WUFuYyszeVNxK2RE?=
 =?utf-8?B?eVc0OHJDVWxUMnRrWVAxQUg3OHZ6MG96ZXpSeEJWTVovWXBWSDdRTTh3eGVL?=
 =?utf-8?B?UmQvaVlPK3pvcUhsM2ljUlBRbHFqOTZvOStGTTZGSndLbGdEWXhPdDlnckhB?=
 =?utf-8?B?Zi8wUWwycEc3V2xLM3FtM1VOSDA1VEJHMzhCUkFid2Q3OW84aW81VnlrNC9S?=
 =?utf-8?B?SGZJdm83d0ZQaGNvdU5PR2xrV1daVnNvVDZ1eW5hSVNjSUpPaVhlUUowV0RC?=
 =?utf-8?B?bnlBTURpbEwxWlYxQzZyM3VPaWh4MVh0ZnNBQzQyK2kzNStjT09lSHJmb3c0?=
 =?utf-8?B?VEIvNkoveVRDSFVEY2N5ZmJVbG9Da0x4bEhmQVM5Uy94QkFUb3JybXZYRndD?=
 =?utf-8?B?ekN5Qk5WaW9jZitKSVIrRlFFRmlBQzAwUEFnYi9lR1YvWjNqRVV1eDh1SDNL?=
 =?utf-8?B?b21rRDEvcEh5QitUckRxQzdSUFhablhMVVdDWDdaQ0VycDczS2k5OGZXUk5s?=
 =?utf-8?B?SHlKQkgvLzVaazFRR0FaM29tVk9xWHkxdUlKUEhieWN2ZVhLc29kS2RmWlNZ?=
 =?utf-8?B?SnpXUnRrUVF0WGhYdkJNOEM0SUdlQVBLdnRXdm8zOFBwdEpkb2t6NFVIcWlZ?=
 =?utf-8?B?SWRlRzFhSHNFS1JoWE9ORDNhN1dPVTBWN21BN2pxNEwrb3NxR2VHVEx6OEQz?=
 =?utf-8?B?K04rUVpzb3NPQm45RHBOeWlFcVFoSVQxcnRBSWFOR1FwbmN6YlZJcWgxZEI4?=
 =?utf-8?B?bkJ4NUppTGJQUzZ3dlE2d05JeGhwMkhGUFA4V1FPejBtajBtZTJWM0RPVi81?=
 =?utf-8?B?blluTHpEMzJVSEtzZ1R1RStsY1dha0lkN0RiNlNCZldsZEJjQ2ljZ0ZkR1FU?=
 =?utf-8?B?N3lhQ3dBb2Y2SWUvdkJ3VWxQQXR6V3ZYNUJRSFdnZDdEZGVBQXhqRS9na0Ri?=
 =?utf-8?B?Zmg2QVY4TFppMHZVR09TQnRZeENHTmpOQUxkQzhsOHg4dnFZU29OSThwL0di?=
 =?utf-8?B?dzRFa2NJRk9RZ2FjL2ZIWWo4d3B6bCtGeEdndzVBai9PbFBpSEdwN0tzVjVu?=
 =?utf-8?B?bmZQK2pjMm0rOStwdGU1SlkycWg1MEtJZHBRRFg0M28yMUJnUUNic254REds?=
 =?utf-8?B?dURkS3JRMnJ0bllRcVJPNkdFMzYybmFrUll0YVNiMFlOV2dSMzFqZVF3L2xH?=
 =?utf-8?B?NzQ5czJ1NWhKZzFKOEpYMGp1Z24wNTlpZjNpcHRnUXZQUms4MWxQc0hYTFhQ?=
 =?utf-8?B?Wll5MnRuNDBTaEsySVBCbGxnVU9HV1RvanBSN0ZTTnJQcndDOUlOb3o4cUZm?=
 =?utf-8?B?djh5cG5JT1FBdnR0Wk56RDNSUEs3Y3lYMVF3U3lXeTR0dDJnWGRIZ2xMdVpR?=
 =?utf-8?B?UFRFYklzVS84WE1WTkp1RUlwalltbXlROW56b2xHNTZBK3BhZG1rYTF4TzR3?=
 =?utf-8?Q?FAafdmCmXzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXltNjJJQXplODVKSWU0THBYZE85MEF1VkFFeEdxYjJNdUFmYVF0UnJBL0g3?=
 =?utf-8?B?b2xnWkkvOWpnaGM1aGFrNndrbW4zUnJtbWl2b0h3VjcrVWdHQ2V2N1dBdWNK?=
 =?utf-8?B?Q3VpMWdMTWF2VGFKTUsvbERqNHB4Ylh4ZzlBdHB1alBYZTRkV0tlaEZ6b0Zj?=
 =?utf-8?B?U2Rwd3d4WTc2NWpzMXhRV2FuUm53WE4rcVMzOVYzZVcxSlhQM09WUEtNMU0v?=
 =?utf-8?B?cEQrYVFQRTNGVzhqNTFpZm5WQ2dJdEQ3L3RQVFQ4enFia1Z1bG94Mm5XN1ow?=
 =?utf-8?B?SjlSTVlUR1Y5STVpVHNQL21KTUhRM1g2bDFYd1pqYzU4bndHYVVTQ0pJMUlx?=
 =?utf-8?B?UjRSVCtoZ3BucG5JSjFUaVhrMzAxQytNaW5yYk9XT2pBaitNZ1VvcTVZODRW?=
 =?utf-8?B?dXVzano5L1N0emhhaFN4bnY1L2R2TithQkpyaTRxL1pPaEdqTmtMSXNEN2FM?=
 =?utf-8?B?Wm8rZHRYZ1liWkZONnZ1LzArb2hnVVl4bzZFNDl3N3NSZ1lySUdtdW9EQ0RS?=
 =?utf-8?B?NzJuajlvWnhVYUJCVUhUQm9Dd2p5TVFNb1ZFeDk5L2JBTEU0VDAwWVlrYVBx?=
 =?utf-8?B?NkRXNElhd1BOcDBuaTBNcmlGcDdoYzNhOUtjUzRFUW1pVGcwVDlYRWQwK0RO?=
 =?utf-8?B?ejRZUFpPZW9IaVFnaG1sekJGUE84VWc4NVN5bE5lMnE5WnlnM3h0MTg2dFhH?=
 =?utf-8?B?d3NCcHM4Z1YzTkh6cVlMZlB3bXBtaVJpREErak42SnJDQVBaRnROeW81eXhE?=
 =?utf-8?B?UUNPMnRRdHRaT3luc21xT2ZQZVZlNllZeGY3S0hna3o4WjBobjEzbjl0U3BO?=
 =?utf-8?B?dmZwdVhUdkNXaVBDQkUxQlRRa3REMU9nV0syQjA2cS81L1l0dnc0ekhabXBo?=
 =?utf-8?B?TlFVQWNPRjhENXE5WHMycUFsT1RNV0tiYXBMbTIxM3pIQ2szS3k3OFR2SkI5?=
 =?utf-8?B?Z095a0xaenljYVA0WE92WVJnZWNzVTFzc3d4SXd2VzRSOVNhS3A0MlhxYnhk?=
 =?utf-8?B?ZEN0NlF3dlEyd0VHQTJKb2hmODQzWTRXOGRmWWdya1krdnNGMEtyOC9SaHQ2?=
 =?utf-8?B?RzYwQUJtZEsraWhmTE50UXF3Z3NnK1FvMEtDYWZoa3NxSmNSR3RSQzBhbVZV?=
 =?utf-8?B?Y1dDSVc0YmtxSlRBK1V2VUczU0Fpb2xXcDBOd0Y1UG1kb1RFSGk5ZTA0NW1q?=
 =?utf-8?B?L01ZSC80ZG9LaGs1V014UkZNSk13VHU2ZXFBcHZUUzgxdythOGREakg5Rk9u?=
 =?utf-8?B?SWFjTDZRZ255Z3owcC81ZGlERjFGS2JHeUVsWHhkc0VhRUhHMC9zeDExWDNu?=
 =?utf-8?B?aG5BU2dQWkZJejNCSXlmQnNRL3B1ZmkveUxTdlVaM0FhbEswZHN5cUQ3ZHdm?=
 =?utf-8?B?M3dyMm1vMUMxOUlZY0p2bm0rTjZsSHdTM054NTZ6bmJRRVFzSGZpQk9paThY?=
 =?utf-8?B?MWwxMjU3ZG5hUzVSNW9DdGpPUCtzZHdnbEJzazhGUWwxQks1V3ZpTWVmQXJz?=
 =?utf-8?B?ZEhCbEwwSC84Q1V0bjJ1VEdzK3J4cVI5OHc5TDhjQndsSjBlWjVpSE5lTlZY?=
 =?utf-8?B?U20zUE4xZFNqcENMTVJGZWF2Wjc2SEk5VFAzTnVVZ2l2VVhnVE5JRkM2Szdn?=
 =?utf-8?B?NGV0cExNVk5DdUFCbUM4U0IyTzEreVZMWmdrV1FTSWJ3VXdOdkVkR2pheC9v?=
 =?utf-8?B?TVpQeUR0U3RVNVArSlYvSVpyZjRkZEc4aGEvV1JOVldOTmFMSWhQQUxoTmFy?=
 =?utf-8?B?bm5kWmpRdlN2UFYxVEFRN3ZsaGJtdlBIcG1aRzdqNWI5aUZXVThaQ1JFaWFs?=
 =?utf-8?B?aCtUemRtMUJTZUY4Sy9vY21ZeEJjcklCa09BM3dGaWlTa0IyMzlqYWIyTGtW?=
 =?utf-8?B?ZUhScnFPTUhoZ3UxbkkweWRmR0NNeG5tdXowK0lLZGNtNndxRmdkYmJ5anJl?=
 =?utf-8?B?d2NDemprSUo1QlZiQURqSUF1OStJTDFhdVBnMUE0NEZUR1NKWTRYSEtwa0FK?=
 =?utf-8?B?SEpPb0szTnpIRUMzY1RYOVR6TWF4d1lkUm5JK2VCR05vbVdFRzhMeEcwamJy?=
 =?utf-8?B?MmloK3poZ1FWU3R0dHR0VFRRZFlscHZ2K2grVXZtaHpNZDFPSnlDc2Z1ajAz?=
 =?utf-8?Q?TS6xmIFMD+znmzn5E/phpExW9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38550847-5923-477c-422c-08dd79145472
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:17:18.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDYhU1+Xa5NWtoRO5DJuSN0SUGoWHNLss28PAa6KL2v3esnC/8WitFSjaFh8ZpWoghZlnLEC8RV5MbPdg8/V4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
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


On 4/11/2025 7:42 PM, Alex Deucher wrote:
> This will be used to stop/start user queue scheduling for
> example when switching between kernel and user queues when
> enforce isolation is enabled.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 68 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |  3 +
>   3 files changed, 64 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b156e31ac86ac..30c485f529d17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1249,6 +1249,7 @@ struct amdgpu_device {
>   
>   	struct list_head		userq_mgr_list;
>   	struct mutex                    userq_mutex;
> +	bool                            userq_halt;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index aa7222137c31d..e93e390f4e301 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -335,6 +335,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   
> +
>   	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>   	if (qid < 0) {
>   		DRM_ERROR("Failed to allocate a queue id\n");
> @@ -345,15 +346,21 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>   		goto unlock;
>   	}
>   
> -	r = uq_funcs->map(uq_mgr, queue);
> -	if (r) {
> -		DRM_ERROR("Failed to map Queue\n");
> -		idr_remove(&uq_mgr->userq_idr, qid);
> -		amdgpu_userq_fence_driver_free(queue);
> -		uq_funcs->mqd_destroy(uq_mgr, queue);
> -		kfree(queue);
> -		goto unlock;
> +	/* don't map the queue if scheduling is halted */
> +	mutex_lock(&adev->userq_mutex);
> +	if (!adev->userq_halt) {
> +		r = uq_funcs->map(uq_mgr, queue);
> +		if (r) {
> +			DRM_ERROR("Failed to map Queue\n");
> +			mutex_unlock(&adev->userq_mutex);
> +			idr_remove(&uq_mgr->userq_idr, qid);
> +			amdgpu_userq_fence_driver_free(queue);
> +			uq_funcs->mqd_destroy(uq_mgr, queue);
> +			kfree(queue);
> +			goto unlock;
> +		}
>   	}
> +	mutex_unlock(&adev->userq_mutex);
>   
>   	args->out.queue_id = qid;
>   
> @@ -720,3 +727,48 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;
>   }
> +
> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx)
Did i miss something of the param "idx" isnt being used in this function 
? Same is applicable for start shed .
Regards
Sunil
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	if (adev->userq_halt)
> +		dev_warn(adev->dev, "userq scheduling already stopped!\n");
> +	adev->userq_halt = true;
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		cancel_delayed_work_sync(&uqm->resume_work);
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			userq_funcs = adev->userq_funcs[queue->queue_type];
> +			ret |= userq_funcs->unmap(uqm, queue);
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> +
> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx)
> +{
> +	const struct amdgpu_userq_funcs *userq_funcs;
> +	struct amdgpu_usermode_queue *queue;
> +	struct amdgpu_userq_mgr *uqm, *tmp;
> +	int queue_id;
> +	int ret = 0;
> +
> +	mutex_lock(&adev->userq_mutex);
> +	if (!adev->userq_halt)
> +		dev_warn(adev->dev, "userq scheduling already started!\n");
> +	adev->userq_halt = false;
> +	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +			userq_funcs = adev->userq_funcs[queue->queue_type];
> +			ret |= userq_funcs->map(uqm, queue);
> +		}
> +	}
> +	mutex_unlock(&adev->userq_mutex);
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index 381b9c6f0573d..fd0542f60433b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -114,4 +114,7 @@ uint64_t amdgpu_userqueue_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>   int amdgpu_userq_suspend(struct amdgpu_device *adev);
>   int amdgpu_userq_resume(struct amdgpu_device *adev);
>   
> +int amdgpu_userq_stop_sched(struct amdgpu_device *adev, u32 idx);
> +int amdgpu_userq_start_sched(struct amdgpu_device *adev, u32 idx);
> +
>   #endif
