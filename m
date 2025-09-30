Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25875CCA470
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 14:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C24CD10E5E1;
	Tue, 30 Sep 2025 14:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sKjED3ea";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010010.outbound.protection.outlook.com [52.101.85.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03EA710E5E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 14:38:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCqYHCRgTjpi9I42OeuxxjK5NKV23HRgz/pWjKV5z89PngxyB805/UFHZa0l88b6tKB2yOpt5B7KuSE91oMs5WzT//mZVrSWbZhidKd0XNTE3QNX7CJkD/iuIJtzIn/VsYAGl9FC+FFHFx645iac07oFccdsvDPwBnoh5t/RTeSxzjPPL5kBA8r9EYERwQYCOFvUbLfqiWStJyxH7puo7w3OL1pMt1+IowEW/lDNcnDP6xHDSXFvV/IwlfqB5wib93qf4aA2rGJj9Vr2+eoAnjzEdH6wmtqHG3ulzJ+2uLclIcq+fw24BBpiG9HqppgftzTp+NrZApAs+IXWor2j6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uM/f7x3WFzkSUSBL3SG8ovGn5TnEUhzTqWLQDbjnmao=;
 b=OLYqVPS2qslHReufQ12ev+XkSnyZpJPoHecDait69zRAKQrIcsOFw9I5h3Ag2R62cOCyIVCM68v4EISwaAM/DLVii0xM16kEcDeQmKy2vT8tr+IbCioFwpagelWxqVLG/x1QpBtfmdsGu8sq9WfWYNYqqnAuWaEvSevRbx7XnpMeJ8mtAp93tHxIDEBI4JjiGJoM+ioklrnXv9UfGls4p7TGfnY2vQwHlOtnTblUyXSheTdUQvyiTPL+hxa8lG1O477hBmKlWaEjEGjs9FaQr/XAK4craMAtYVB/yHUwAsTJjPMuIrCa/Hvzb6AOZIFdcL4ul6kfS3ZaRgm6G0v8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uM/f7x3WFzkSUSBL3SG8ovGn5TnEUhzTqWLQDbjnmao=;
 b=sKjED3eazbGFBRq6I3m7oUV6gp2OdoOOZLVzwhSZxBRSNgqFcDGz39Cq7hpMXwS5KDexGlfggjAV7wXf5BgO0zB0Hn07+ANK88bjn+BQacO2edu/NGiPhhaRu38++jw9c5/rsLryYCOkivZYyUxEeI1PbxpV/7UgXNaTaj2nmn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 14:38:36 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::25c8:f399:b2e8:1947%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:38:35 +0000
Content-Type: multipart/alternative;
 boundary="------------N0Xz7MZs4ytIWjIl5mvWouI4"
Message-ID: <fca2838f-a08a-499c-849b-9d17d312b342@amd.com>
Date: Tue, 30 Sep 2025 10:38:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix svm_bo and vram page refcount
To: amd-gfx@lists.freedesktop.org
References: <20250926210331.17401-1-Philip.Yang@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20250926210331.17401-1-Philip.Yang@amd.com>
X-ClientProxiedBy: YT4PR01CA0424.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::24) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 66ee7454-919b-4c15-09c1-08de002f0932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cHJWT3dtWlFKQTdVQmlNak1GUDBPeE5CRmZXbkIyL1V0Wnh5am5oUjFONElB?=
 =?utf-8?B?RW8yYjdjN1ZqS1gvSXY1SnRKNmV5U0F1bmI5TTlualpxV3FPN3NKN0J2MUdP?=
 =?utf-8?B?VEt4ZmlpQzBLWnRTNGM4eGczd3JOQm83dVN3TGJ1MHlLaFFvcmVvb2J3aU9B?=
 =?utf-8?B?M0VwbnpDazRpRlBQNVBHSTZXNHdIaTBjR3FnS1pCV3NPR1Z0UVVEclNkY2V1?=
 =?utf-8?B?VFU1Ynl3VGlmc2d0T2tSUEcwcmRiZVgwbUZrMWQ0L01oNnM2R1k4cE5VZmZq?=
 =?utf-8?B?NEI1R3RTMktLVzRVWVVIQWJFUkQrWlVzWlIxbDVOeEpZdVNJZGY3cTd6N2o5?=
 =?utf-8?B?cVNyYWYwUFMxaGp5ZnpwaFNwRDFKZTJ2aEFZdjNkdzZWQTN5ZzFGSUVzeVJi?=
 =?utf-8?B?RlduUDVTYkdGVGlsWHZHODZ0VktFWFE2VzFoNEE0T2JLalZtQnhTNnpUWkQv?=
 =?utf-8?B?Z3ZFME4ybldRUHZMNGxqVGNxL0lFVVEzdDUrQjZ5Z29SOTVENitwS1REakls?=
 =?utf-8?B?U082RDRIaTkzb21lMjJqak1LZitRclRTRW1vMnBxME53Z3dtV0tsMFM2NWpR?=
 =?utf-8?B?Zkh1V2FtSmFOalNKanZkU0pOSjdianBTay8xNjhkbTg1UTZIYUZmbnUxMncz?=
 =?utf-8?B?eXYxWTVGcVR0K2hjczh1bVpLd3lyUDYrakI1dlpFZHlxNDN4UnBrdjAzeDlo?=
 =?utf-8?B?TUJtd1YrTDhGU1VFQ0UwK0VyS3dwYzlGL1NwUEFlc1FtUDB2MXRVeEptalV0?=
 =?utf-8?B?ZWFGdml6ZDhQZ3VlM1BWZG9xSEZteng2V3p6TGxhUGo0M2ZXNW80bXpHUDFz?=
 =?utf-8?B?OXMyaEhXeDVCREpBZXg4alZrS0o5OHJ4TTNCbnNpcHY4NTZISGtDbGV4ZW84?=
 =?utf-8?B?QWFndEZvTk9TMm1RUmo3UkRyZmVFK3pFQmZ1MkwvY1hnQy91WG5ya3lrOUtF?=
 =?utf-8?B?RW14aHFDM0E3YjdaTVEvSjNEMmxZSnRyVVJrbDlyZEJrR2p4L283K3VrV1Zy?=
 =?utf-8?B?Tk8rYU83aDNzTzlGNWNZV3VEMktEblBzMXFvU1Z2RGdjUUY2SHJYaW1Ub3R5?=
 =?utf-8?B?OWhaU0xUaUFPVkcvTTVvSkNONUFPZVdDSG8wbEFOcVI4aFlLZXBjamlKL2R5?=
 =?utf-8?B?amVpSWIxRk14NHRpVWg4WEtmK0Fxem82TTBJdTRnUXhhQ1hRSExOQTBzbzMw?=
 =?utf-8?B?RnFIbS92bHpxblZBNi9vRW9zMmNlSTg5Nmt2WG43OXdKR052SnlySllTc3dF?=
 =?utf-8?B?U1IwVG9Mb3o2THdSbW85bnhJL3BDUkFWYzdwWktKOWFJdTBCZlFmcGdBZngz?=
 =?utf-8?B?djdKYWFoM0EwSkk3SkFWVVROU2dRYStCcURmQ0trc0JJQ0VJcTNzV2ltQ29V?=
 =?utf-8?B?dGowcXRJeXIzRE1sTWNRMHFCVWJITDhWdkVSblJteUg4bHhEWitaV0piaTF6?=
 =?utf-8?B?aFZiNDQ0VWNhUHhqZkRCdzdIK0t0U01NMmliUkpZdUR4Uk1uZUIwak0yZTRs?=
 =?utf-8?B?c3VpcGxETnU2VjJLOTVRamwzdzBURGhKbUtMZWpYZ0hzYW9VWTVydW1LcVBx?=
 =?utf-8?B?ZHN5dFdNSnYxbFFZeWd0ZnRDWmkrSDBJcmtEWEhWaHVqZmtTYU1Ua3A2YVhY?=
 =?utf-8?B?MlRyRmFTZklobUQxVlBKOXM4NXpSbEQ2RFpseHZuNklSWFVCWjUyTXFIVXly?=
 =?utf-8?B?SklFWXVVU0syWDJjL2h1Ly9XR1F3QUYwR0VXclhNRjIzWHpVcC9hN1pwNm5h?=
 =?utf-8?B?QTlPNnBZUU9HdXhldGZ0aVJVRVp1RExlcWl4SE9BQ2IzdVFDUCtLQksvK0JN?=
 =?utf-8?B?aGMrZjhXQzJkRy8xRFJmZk5nZTFaY2Uwdm5vM3B1YnM1NHVjQ1pzaU5MZVlh?=
 =?utf-8?B?UGN2emVyQlNXVmk1cXM4eXdEZ016b2t2SGIrVVdHOCtqSXV5NEx4RXlNOS9Z?=
 =?utf-8?Q?HnjTHXbGt+OcOJ89CCoN2XA6uifSMi5B?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGZ0SlkrL0VuUjNWaktwS05oQThLeCtsWExOQ0VkaUdxcG15bE1KTk5LVnRv?=
 =?utf-8?B?dVo2c0RnK292RG5qcjhaenBheTlWaFc2ZHVCdGRaN1R6TzVHQkV4VGFlaDJC?=
 =?utf-8?B?NnJUVTlPYlNpUnNISm5KdGQ5THRMU1lYWjRhcXByaFdxRmtMYndNbDNwdVZh?=
 =?utf-8?B?ejhsbHhyY1RKZDBTQWtIdkVYMnhFUm9QNXczTzVuZEJUM2FKUTMzaW9zZEx4?=
 =?utf-8?B?WHlsYUEzS09TTWJDWkZPUTJpb1ZxUFN5TEkySUtaQzlzSHVxSU4yQmxyMG9n?=
 =?utf-8?B?NGFBdnJyWDJHRG1pb2hVQWpoS1BwZ3FuMnNWdFZrcWFXOEc2RzRmTGV4akVl?=
 =?utf-8?B?dWFqUmtOcGM1Y0RGSVZRU2F2cnpleFVJWUtadUpmR0hPWWZLMWUrRzNpQ0Jk?=
 =?utf-8?B?ZzZrb0VWUDE3UWh4K3NWVDZvd3RScWx6QjZBVEIwWE13SS9Icm1QVjk4Y1Fm?=
 =?utf-8?B?RGc4OEF4Q2hSZTB0SVFvdkQrcmRTVVBxMTFrdGx2MlJEVmtlUm41cHBDS01z?=
 =?utf-8?B?UitLbU5VOGhweTRhUVBGVG9iQ0tCUXUzTGwzeEQ4QmhWRGVBVXBhelkxdURp?=
 =?utf-8?B?NysyMEVsWk0zanNwNFl1Z1YrWG1adGNXMjhGa2FBSXl0RDEvdDByMjRrZk5P?=
 =?utf-8?B?eHR2QlpVb3krcEwrS1k5eUsrczR3ZFZtZ0tZVDZ4TU4ranRBN3dIc3ZOY3Z1?=
 =?utf-8?B?MUh1ZSs4OVNFeHo1dVR3cSthT1hEeFVXZnhMeDV2RDllZXNUYjl4WkxuZXRv?=
 =?utf-8?B?OVhQdlBQTHI0ODBvTDBxWFkrWVdHMGwxdXdUK3ZiZGdMMkNyeTNpbDJYeHhU?=
 =?utf-8?B?cEw2bHozdDV2MTBTWXIvZ1k2cWZoVDRXeHJvcmZpbkdoNCtUWG9oNVFCRXB2?=
 =?utf-8?B?ZEhlMlk0cGE3d0lWNmhwNW9pRU1ZYWc4U3YySkEyWUdnZC94djdoYlpPY0RK?=
 =?utf-8?B?cGRRaU5FR2IyZEE5dVN2N2RFbVoyd2h3WjJxQ3BmR0JYcVlsOTlVSExlNENB?=
 =?utf-8?B?TmhrUnB0QVJVbDVsWVhMV1lhNW5zT1RUaG1PRjhmYUxnOEkwWDJCa3NYRE9C?=
 =?utf-8?B?MTUvYmUwOG5KZ2tOSW1WdHBaN3NEWStPckFFbDBsY3psM1BzcDN6V05IbjAv?=
 =?utf-8?B?aHFMcHBZVXJZV0lvUk13MVVhK0RmU0pQai9xWmVMaFk2M24wWjZmaTMrK0Nj?=
 =?utf-8?B?TWRSUCs0M1RIODQ5Y0lXYzZzOE10azZ2cisvckdIclBiM243a1l1c29LV3Jt?=
 =?utf-8?B?dUJrQUFzbUR6N2UrNmdGdy9SZFFUU1JBUFptYnc4ZTM0NmN2allDaDFJVUFy?=
 =?utf-8?B?WmlONC82bWRUeldJazU0RGhyNjF5SWlYYzgwdDRSS3IvYnYzclNOd1QwdmF1?=
 =?utf-8?B?VktTU3hMYlVjTWQ5azNiUFBxVExodjBmT1cweE9sY1VKbkxyUHZqUk1SbEpI?=
 =?utf-8?B?cFFtbDdKdUxJa3VpbFA3Z1ZwdW8yOXdmSkVWaVJSZTFhRDNlb3VkQmJnVzBw?=
 =?utf-8?B?Z2gwZzhnOVZHZ3NleW4rVzBxVTQ1UkN6ekRxdnRKNDVJTTNJbHY2SUp1SFZO?=
 =?utf-8?B?NW00dks4bUxxOW15WjNxVG5DNDg0aHNIQlJCbE00alNxS2NtZTV0K1A1b1dz?=
 =?utf-8?B?Z2NmblU1cWNDMzhMWXhYRWdzeVJyalh3ckMzQ3dCS24yaVVuZ1dmQW0yL2VH?=
 =?utf-8?B?b3VPVnBiUWNYUTh6N2NqOFB3ZlFUV1JXRGdHaDZjSGhKTzNYblJnODIrWlJV?=
 =?utf-8?B?bFpWdUo4cnFoeTIvdW94RjBSanB2R0tpc3FQKzhsQit1RmZLOWQ4MWF2NGgv?=
 =?utf-8?B?MjA2L3NhY3hMT3RIM21sWHZCcHh6ei9yUkZaU3NwQXNNdHlIT2xQakN0a1VW?=
 =?utf-8?B?bERCakJBZ3J4MWpQaTlueTlJZTFSbmZ3T3dYcGZIc2NGMk54VmdCSDQwTHFs?=
 =?utf-8?B?V0N2Z3A5TUdwdDAyOU01N21UcDhqSVFYWlJmL3Z2bzMzVnNhU3gwWmkvZVRV?=
 =?utf-8?B?MUFxSFo0Zkh6K2xpamZKSjN6dERtTWhDdDA5VHJSd1ZVM2Q5cmlPaTljMGVK?=
 =?utf-8?B?YWM1UGJVWnMvUW9pRXZyd0daRjVrTmRzTVljTWJGUWovWjFsUXBQTVdPZjBs?=
 =?utf-8?Q?0uvLiNsZ+T9zDzkeeIy7IUJns?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ee7454-919b-4c15-09c1-08de002f0932
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:38:35.4482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwTZSxUKdPdGvviBjH4mgk5gBolNhtbSlo0JNI8bXOKdTVUM/0X6H5c4tIw0Ya5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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

--------------N0Xz7MZs4ytIWjIl5mvWouI4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

ThispatchisReviewed-by:JamesZhu<James.Zhu@amd.com>

James Zhu

On 2025-09-26 17:03, Philip Yang wrote:
> zone_device_page_init uses set_page_count to set vram page refcount to
> 1, there is race if step 2 happens between step 1 and 3.
>
> 1. CPU page fault handler get vram page, migrate the vram page to
> system page
> 2. GPU page fault migrate to the vram page, set page refcount to 1
> 3. CPU page fault handler put vram page, the vram page refcount is
> 0 and reduce the vram_bo refcount
> 4. vram_bo refcount is 1 off because the vram page is still used.
>
> Afterwards, this causes use-after-free bug and page refcount warning.
>
> zone_device_page_init should not use in page migration, change to
> get_page fix the race bug.
>
> Add WARN_ONCE to report this issue early because the refcount bug is
> hard to investigate.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d10c6673f4de..15ab2db4af1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
>   	page = pfn_to_page(pfn);
>   	svm_range_bo_ref(prange->svm_bo);
>   	page->zone_device_data = prange->svm_bo;
> -	zone_device_page_init(page);
> +	get_page(page);
> +	lock_page(page);
>   }
>   
>   static void
> @@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (mpages) {
>   		prange->actual_loc = best_loc;
>   		prange->vram_pages += mpages;
> +		/*
> +		 * To guarent we hold correct page refcount for all prange vram
> +		 * pages and svm_bo refcount.
> +		 * After prange migrated to VRAM, each vram page refcount hold
> +		 * one svm_bo refcount, and vram node hold one refcount.
> +		 * After page migrated to system memory, vram page refcount
> +		 * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
> +		 * svm_range_vram_node_free will free the svm_bo.
> +		 */
> +		WARN_ONCE(prange->vram_pages == kref_read(&prange->svm_bo->kref),
> +			  "svm_bo refcount leaking\n");
>   	} else if (!prange->actual_loc) {
>   		/* if no page migrated and all pages from prange are at
>   		 * sys ram drop svm_bo got from svm_range_vram_node_new
--------------N0Xz7MZs4ytIWjIl5mvWouI4
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>
</p>
    <pre style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">This<span style=" color:#c0c0c0;"> </span>patch<span style=" color:#c0c0c0;"> </span>is<span style=" color:#c0c0c0;"> </span>Reviewed-by:<span style=" color:#c0c0c0;"> </span>James<span style=" color:#c0c0c0;"> </span>Zhu<span style=" color:#c0c0c0;"> </span><a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu@amd.com">&lt;James.Zhu@amd.com&gt;</a>

James Zhu
</pre>
    <p><style type="text/css">p, li { white-space: pre-wrap; }</style></p>
    <div class="moz-cite-prefix">On 2025-09-26 17:03, Philip Yang wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250926210331.17401-1-Philip.Yang@amd.com">
      <pre wrap="" class="moz-quote-pre">zone_device_page_init uses set_page_count to set vram page refcount to
1, there is race if step 2 happens between step 1 and 3.

1. CPU page fault handler get vram page, migrate the vram page to
system page
2. GPU page fault migrate to the vram page, set page refcount to 1
3. CPU page fault handler put vram page, the vram page refcount is
0 and reduce the vram_bo refcount
4. vram_bo refcount is 1 off because the vram page is still used.

Afterwards, this causes use-after-free bug and page refcount warning.

zone_device_page_init should not use in page migration, change to
get_page fix the race bug.

Add WARN_ONCE to report this issue early because the refcount bug is
hard to investigate.

Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index d10c6673f4de..15ab2db4af1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -217,7 +217,8 @@ svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
 	page = pfn_to_page(pfn);
 	svm_range_bo_ref(prange-&gt;svm_bo);
 	page-&gt;zone_device_data = prange-&gt;svm_bo;
-	zone_device_page_init(page);
+	get_page(page);
+	lock_page(page);
 }
 
 static void
@@ -552,6 +553,17 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
 	if (mpages) {
 		prange-&gt;actual_loc = best_loc;
 		prange-&gt;vram_pages += mpages;
+		/*
+		 * To guarent we hold correct page refcount for all prange vram
+		 * pages and svm_bo refcount.
+		 * After prange migrated to VRAM, each vram page refcount hold
+		 * one svm_bo refcount, and vram node hold one refcount.
+		 * After page migrated to system memory, vram page refcount
+		 * reduced to 0, svm_migrate_page_free reduce svm_bo refcount.
+		 * svm_range_vram_node_free will free the svm_bo.
+		 */
+		WARN_ONCE(prange-&gt;vram_pages == kref_read(&amp;prange-&gt;svm_bo-&gt;kref),
+			  &quot;svm_bo refcount leaking\n&quot;);
 	} else if (!prange-&gt;actual_loc) {
 		/* if no page migrated and all pages from prange are at
 		 * sys ram drop svm_bo got from svm_range_vram_node_new
</pre>
    </blockquote>
  </body>
</html>

--------------N0Xz7MZs4ytIWjIl5mvWouI4--
