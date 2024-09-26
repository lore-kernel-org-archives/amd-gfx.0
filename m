Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F8CCF9E9
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Sep 2024 09:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87ECE10EB7D;
	Thu, 26 Sep 2024 09:34:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bJ1pKFkX";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864BC10EB7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Sep 2024 09:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ndz+ufPQc/1rj2DLHFeArPfeifh2qSuwxfCPScAT4oXDqOnNhh8IhL2umxSsjE6F7MCc/JwUxaHsjJWyLE/BDT3SuzsVwjhKPU3tRP7t/D4l9dejpPHeWLJmiiYLaxCxCqUzIWjIPpbmcQIf2FJo13JT+E1++irA9fXo1VZXpIWzEpif0YfxG8CACCyx8MV/Hv4sI9dm/DbypJrfLH4jUOgqwNZZ5Sm+3nl2nfdTnL2/xQrWkDlWWG4Wm26ZgOHJcQPF3RyjK0sEb0YZylRN+FWsUu8wu2ILlFZE5bBFY26CmNqOmjIfPcdxqtheIPr7yTKf6s0iFPmPLKhPeb+BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxauRXVsj8az4vgx2sv0gS4Yjt1NpUr3nWGwOs1LGzQ=;
 b=LcaZwHGlora6rj4t1a1hn1ZfmsU8v1aROiUomAaStDld76rWw35otM8D5loogl7P4f8e7veERQRhU3Vl8E53cTRdnywrxHDrcUp7wTwyOq2wGq4ssUIHsXXoL0ijJqepDN1QIPYtq9aq4/D6GCdNETDXA2XZFZ1YuiVG2W8MXvfPXTl3z3dXWY85isad36A/O2G4D3IuGsXkZf+ZSPDuOhJsYa9FOZTwa8Kk9Ksj8a6Hhp6I7tHfXyUdtDPTaUlSMrPlAVJfsvYvz1VXwlGj378XD4AffDlKFwj5Gtgq4e0l3W/e+Ig81C12CTLQRWHkd2UvXFks7O/1S0LAsyyWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxauRXVsj8az4vgx2sv0gS4Yjt1NpUr3nWGwOs1LGzQ=;
 b=bJ1pKFkXKOf7TRSMfSHjMrRI5lEMzPjeykWbwXh6tbBinm2E8i1QRuaR0eV74TpppbDvP9F+o2daRfBgOsoz91f5CjzYLVkkYvnHhpgmCn+g8CUxXzNhRvqke0mmBjcP0ToqpebKlj/u9mFl2MdXZ2A6CNf/yRtnmEx6FzcKJxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 09:34:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Thu, 26 Sep 2024
 09:34:21 +0000
Message-ID: <ad931726-cfa8-4c60-83ef-ae164a8c3f66@amd.com>
Date: Thu, 26 Sep 2024 11:34:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/08] drm/amdgpu: Implement userqueue signal/wait IOCTL
To: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
 <3fe2c80e-565f-448c-9b7c-9e69fe175ab8@gmail.com>
 <04440164-8566-4ec0-98ce-c40f718a7575@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <04440164-8566-4ec0-98ce-c40f718a7575@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0245.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d68244f-d21b-432e-42e6-08dcde0e66af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVdIeWxwbjE5WlNHeUNJTldvdmMyUXd2eEZhUlhWa0Y5cjM4U0NrM3EyTU1K?=
 =?utf-8?B?WUxqM1VaOVAxbHdHbysvQ3hSVitueDl1Z2RDelNYeTQ1QkpuWlFvL0p6S2dp?=
 =?utf-8?B?bFA0UEZZOVpSQ2k1TDBpaWlLdk5nelRCMStpaW02VEVxYm9VRVMrTHg2aHE5?=
 =?utf-8?B?ODlrZkdRcklieVk4MkI2VHJKc1pTM2hwQ25IeGVxK2Zscnd1VjJDb2RyMXFo?=
 =?utf-8?B?YXlnRjZzbTdua3NKVStrTytOVTUxRFIyRXM4bVlxakNXRmtWZUxzdDRwOVhr?=
 =?utf-8?B?UitHa2p5blh4RVNwTlhpUlJEMHpFZC9TT014WTlUazduY3FNV0oxWURDQ1kr?=
 =?utf-8?B?ZjRZM3c3VTkrdW9JVG5rNnJzWitGS0RlWTFQeWdaQlg0VFhuSnNmWFVBNzIy?=
 =?utf-8?B?aHB2TmNYQ0gxYWgwVXUrMWVmdXF5SmZnL2orZmFLeEdFNE5jUWZXVDRNRkNv?=
 =?utf-8?B?U0dqL2wxbi8vTnpIUFhRa09HTG5sbVRDQkhZeC9ucjlBM3h3bnFjdHoydFZP?=
 =?utf-8?B?azByVFowdnM5SldiL1h0dXdWSUkvQkg4OEZCbCs1azlLeXpyRzQxdGprU29Z?=
 =?utf-8?B?R25rWHdCbXY4SXNEWjFtM0ZGRTBVMDZ1MVRXV0wraTh3VW5KQTY3ZnZOQlBL?=
 =?utf-8?B?dTI0WjFNYkpoaGVKODRPaiswcWJwVGxoZlNtd2FsaW1TdnQ3S0pLMDhQVmJH?=
 =?utf-8?B?ZGViZzhUNWZqekV4bjNUOEFMOEhnVWhFa29sQ21VVVVjdFVBQU4rVHlKWmI0?=
 =?utf-8?B?UXh4T1JlVXlTQ0VCNENaS1lYcGF5dCtXZ1R2Lzl1M291WDRxTTlEeFZpSUU4?=
 =?utf-8?B?NXlSZGdiWlFoUDNwNVhjN3VWckVscnBYTTVNTUIrSXR6MFVzcHg2TFRFeTNH?=
 =?utf-8?B?WW5jVDY2T1htcUVoNi9KTklaRmVoSHBpWnQ3eVQ1TVhkeEN6N3V1NHVkSTM3?=
 =?utf-8?B?REZGUVduWUVrYy9PUVh4WnpHNG42MlVuMFU0a3VjakdZTkJidGN2TnJGUlVM?=
 =?utf-8?B?SzJlSkJodHR5dDQwdGVwdnZxMURSNHRYUkEyS2RkcUF0ODVQajlVcFUwRFht?=
 =?utf-8?B?M2NhaytCWEpUdTFJWXRoWUtpa3hJUU9YMHVaZHhNMVlIa3g1TWJ6b01wTUZO?=
 =?utf-8?B?RVQ5VXlweFpDVi9CaDZJY1UzOWVmWHZKSjMzby9XcVluWEdLRnFtUm1lYk9z?=
 =?utf-8?B?V05TcDc0emtmbFBzOUNLNjkyOC9zbW1KdENUYUJPaVBUOVpsUXpJQVAvS3Rs?=
 =?utf-8?B?TFVKQ25ZdC9Rdi9XZHZsSjVwQVpwNFpWV1l5UHRpSlVQYTFaOGdmNXNnNG1v?=
 =?utf-8?B?bFZMTVdpYUgyMlV6eVFOTXgvNGFsajB1KzVTT3JXUUcrM0ZRNHZGcE5HVEdm?=
 =?utf-8?B?Um1jRmRjSWRBVytUREgrK0tCQWNrdElyMlV5cnNzbHo0eWUweGtuQmVSS3RT?=
 =?utf-8?B?bEFPWmxnUGR3UWtndmtVQ0Rua3ArSk1EQzZqVTRPbjNSYXNzdWhkOGdlSHdj?=
 =?utf-8?B?eEUzdDgzdDU0dnFOWmJ3YnNxZVZYRjc3eDBYTHRFaWZHL3NmUHVRdVFCWVNQ?=
 =?utf-8?B?K0luWEU2cEZleDRRYzdobUxEWmI3ME9tdjR6dHlOL1hQa3FpeDZDYk82REMw?=
 =?utf-8?B?alZCdGJ6Y0lsYlJmNEFReldOTXJaSDhoQTU0K3JZSkVSWk9PSUJSZzF0UlZn?=
 =?utf-8?B?QlJFU2JTR3hZbFlDOVdqVDVaeGVNWG0rSVJ3d3kwMkQrODdJVzhrOG5UYll2?=
 =?utf-8?B?RHNRNUhwamlGczNoTnY4R0NuYStrYkJFemFmOXVNUitvbXc2UVRJWDExUUli?=
 =?utf-8?B?Zk9ZcUY5b1RBNEJzaHFqUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emY2L05VcmtQZ2o3WkhleUFKdU1WME5TUHRSWUFHQy8vaEM0Qmwvc2c3cnBZ?=
 =?utf-8?B?bWFNSytyK1MvQUhTTWxQMU5CTDNGbWRGbWxuN1h3RmxjUmhZNHlKWm5DbW5q?=
 =?utf-8?B?MG9MNnBPTnNTN3o3M3NBbVhvMW41emVkb3JMTm1hMVJnVlI1L2JzWUo2eXZN?=
 =?utf-8?B?MnhQV25yWVl1Rkx4TmdPblN0dXJOajVuRGlFUlZCakMzOHRndVE4NjJvN054?=
 =?utf-8?B?bVdMaStZTGZWYmxoQWxkSWFaSFIrWXZQZitUdk1hWTh2WDRpUEdQb0VlaTdQ?=
 =?utf-8?B?K2ZlME1oQXlod2VUa0VEUkxubDBJb0R5NFZwNDVrSkZEdkxaU1RYMG1sZ2Qv?=
 =?utf-8?B?SnlESXhvRmpWMzJDT1h1ZFFmZk1INlc1YWVoWHFXVnVtNzNNMStrY1ZGdFA2?=
 =?utf-8?B?Q1VWVm9jUmxQSjUwWWVjQll5RG5IaFVpKytPR1ZkZFgvQUk3QnI1Ukk3TDlt?=
 =?utf-8?B?dndOdWNPMWFSQTU3TDc3OWNWeGlNb2tmbDVnMmNobDVGMGxFTWhnYi9yV1hM?=
 =?utf-8?B?YnpUaXBCL0J3bEYyZzJqU0kxaWNKcUxxSEUvVk1Nc0dBUUZxa0FYYU1YMWh1?=
 =?utf-8?B?ZHRmZVNYVFFkL0lTanMxajRzUzBtL1pNSXg4Q2NLNG94MktoaWZQTlJDaHlD?=
 =?utf-8?B?eWgwcm9qTnVCUXQzcFN5YWNXWFBxMHJocUZxd2REa2JsSkVOM1dQaW11dGFi?=
 =?utf-8?B?MG1RVndRL3I0d2FJUm5EQWJtanVzcy9tbUlWUWNoZjArTEQrMHZERUljTTdG?=
 =?utf-8?B?M1NvNzNTalM5TnltU0ducitsd01TZ0x5UmdZUXc0Y3lpZ29jcWphZXBPMVNK?=
 =?utf-8?B?TzltekFaWGdyeDMxdzFvWTV1OHhHcFlxajJLRURmak1xbFQ0TkR3UUMvdDcx?=
 =?utf-8?B?Y29xZUIrMlpCTUxsS1Z1KzNndXByaUtLRzJVUWx2LzRwZ1pROTNOMng5Vm94?=
 =?utf-8?B?QTh4VEs1czI5UHZNNW1oWVpFUUNid2llWjlZYXJDRHFzZWRJaFdaeEpDc1No?=
 =?utf-8?B?NXJLMFVRakxQUmxySGVtRWlBTW5uZGxhT0F5NzB4TWNRTWw4cEZuYzFGWXJa?=
 =?utf-8?B?b0l4RFFIb0oxMmRNWW9qQVBnbW4zbit6ajJYdmY2UFkydnY0WllUcTl3RXpO?=
 =?utf-8?B?aUxFelowbVlia25sY2NaL005ajBqbExWZ1EvdEJDbW9zVS8rc0c4MTZKOE0z?=
 =?utf-8?B?V3FCQThQMTY5SjFrNnhtMy9MSzFoald4SFZuMlNSeUtlSnFyUGxuL1FrS0ph?=
 =?utf-8?B?dWF2cnN0QTNSbThsVk9QSGRKcGpKNHpmSHdTK3lrWUFIbjVSc0hvNmsxbENZ?=
 =?utf-8?B?ZlZFQ0lCT1pEZFZxdlVGZFVWdVE2a1VzenVxS240aDlJQ2dxaXYyUU5DVnNr?=
 =?utf-8?B?ejc2clNPNDJjM0ZjQ0pRS0xXVzd6UWUyY1hmdmFvaG0ySzR3Wm52YU1aWEpi?=
 =?utf-8?B?K2ZnRWUwVnk2RXBWck9LU05MRDBrM3BROFVleTZhQnB3NkZKb3JxenFhZG5l?=
 =?utf-8?B?bkpBZWtWamVVYnZ0NzlObDl2VEc0KzErdkJ4VmlUK2JFT2ducytubi9WSG9u?=
 =?utf-8?B?c1QyMnpWUEFNWE1XV1JRbDhCU2V5OGs1a3dxUm9yN3pmNWluVk92UWFTMVRM?=
 =?utf-8?B?NW5MWXRwWlV0V0JERWorc3dYUURIenZiTWQzaWhLWlQ1TGtTeEI2S1Y5aHdI?=
 =?utf-8?B?Nkdka0dMVmJId1U1QUJIYzY1bVYxZ25Rd3RBRkYxOWk4cVhvQWFFamxMM0hI?=
 =?utf-8?B?TkxLNTNUSzNHNHVYUzJRWHBRVTFtWlJMdXdFbncrZXNtSkQybDdQOVg5RFNw?=
 =?utf-8?B?LzVLamxkZExUVDlHbVg3ZEh2Ym9zNE9ZcG9iYlh5dVdWUGxUT1VpWkxmUExs?=
 =?utf-8?B?RE1mNnRja2JyS1hRN0VWVmtMT3VBbWF6YnY0NmkzNEF4VnphcC9VOHNjK2Vl?=
 =?utf-8?B?Q2NWYkFIa1FMci9uaU1XNG9GNGJjN2FEbUJtQ0NFdno1SFQ3a1ZWTU85TXdz?=
 =?utf-8?B?Rkc2dnlBeTljOVQxTHNIUUV5M1R0c0gzZnBvNVhSUENjVWNtNVBOK2xVWXlY?=
 =?utf-8?B?cHQyRnpXTmVBTHBCWmlJdnBEbndpQ2xXS0lWbWFSU0JPeDFhMEF6Zlg1bC9J?=
 =?utf-8?Q?D2zQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d68244f-d21b-432e-42e6-08dcde0e66af
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:34:21.4405 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MlBTw55/BjoxIKQluOmkURSA1kq/urwJOTGyDHeuQ4ZuJqFMI0+hGWA2lZp58/cO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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

Am 26.09.24 um 11:31 schrieb Paneer Selvam, Arunpravin:
> Hi Christian,
>
> On 9/26/2024 2:57 PM, Christian König wrote:
>> Am 25.09.24 um 21:59 schrieb Arunpravin Paneer Selvam:
>>> [SNIP]
>>> +int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>> +                struct drm_file *filp)
>>> +{
>>> +    struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>> +    struct drm_amdgpu_userq_wait *wait_info = data;
>>> +    u32 *syncobj_handles, *bo_handles;
>>> +    struct dma_fence **fences = NULL;
>>> +    u32 num_syncobj, num_bo_handles;
>>> +    struct drm_gem_object **gobj;
>>> +    struct drm_exec exec;
>>> +    int r, i, entry, cnt;
>>> +    u64 num_fences = 0;
>>> +
>>> +    num_bo_handles = wait_info->num_bo_handles;
>>> +    bo_handles = 
>>> memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>>> +                 sizeof(u32) * num_bo_handles);
>>> +    if (IS_ERR(bo_handles))
>>> +        return PTR_ERR(bo_handles);
>>> +
>>> +    num_syncobj = wait_info->num_syncobj_handles;
>>> +    syncobj_handles = 
>>> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>>> +                      sizeof(u32) * num_syncobj);
>>> +    if (IS_ERR(syncobj_handles)) {
>>> +        r = PTR_ERR(syncobj_handles);
>>> +        goto free_bo_handles;
>>> +    }
>>> +
>>> +    /* Array of GEM object handles */
>>> +    gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>>> +    if (!gobj) {
>>> +        r = -ENOMEM;
>>> +        goto free_syncobj_handles;
>>> +    }
>>> +
>>> +    for (entry = 0; entry < num_bo_handles; entry++) {
>>> +        gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>>> +        if (!gobj[entry]) {
>>> +            r = -ENOENT;
>>> +            goto put_gobj;
>>> +        }
>>> +    }
>>> +
>>> +    drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
>>> +    drm_exec_until_all_locked(&exec) {
>>> +        r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>>> +        drm_exec_retry_on_contention(&exec);
>>> +        if (r) {
>>> +            drm_exec_fini(&exec);
>>> +            goto put_gobj;
>>> +        }
>>> +    }
>>> +
>>> +    if (!wait_info->num_fences) {
>>> +        /* Count syncobj's fence */
>>> +        for (i = 0; i < num_syncobj; i++) {
>>> +            struct dma_fence *fence;
>>> +
>>> +            r = drm_syncobj_find_fence(filp, syncobj_handles[i],
>>> +                           0, 0, &fence);
>>> +            dma_fence_put(fence);
>>> +
>>> +            if (r || !fence)
>>> +                continue;
>>> +
>>> +            num_fences++;
>>> +        }
>>> +
>>> +        /* Count GEM objects fence */
>>> +        for (i = 0; i < num_bo_handles; i++) {
>>> +            struct dma_resv_iter resv_cursor;
>>> +            struct dma_fence *fence;
>>> +
>>> +            dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>>> + dma_resv_usage_rw(wait_info->bo_wait_flags &
>>> +                        AMDGPU_USERQ_BO_WRITE), fence)
>>> +                num_fences++;
>>
>> We should probably adjust the UAPI here once more.
>>
>> The problem is that we only provide the AMDGPU_USERQ_BO_WRITE for the 
>> whole IOCTL instead of per BO.
>>
>> So the best approach would probably be to drop the 
>> AMDGPU_USERQ_BO_WRITE flag and split up the array of BOs into readers 
>> and writers.
>>
>> Can you work on that Arun? Shouldn't be more than a bit typing exercise.
> Sure, I will modify and send the next version of this file.

Thanks.

In the meantime I'm going to review the rest of the series, so there 
could be more comments. But please update the UAPI first.

Regards,
Christian.

>
> Thanks,
> Arun.
>>
>> Thanks,
>> Christian.
>>
>

