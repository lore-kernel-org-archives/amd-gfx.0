Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C28EBFD1E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 09:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2EB510E386;
	Mon, 13 Apr 2026 09:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2T0Wvpg8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B78610E386
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 09:02:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtgwNm8btDVJ+7NgFF/nIq1wLSx1zB5yBGcDhYth/EC3S0VJvkk8bpEiCHs78CR+cnN0kATPJuHAVaGPjIc3dcpBBTN0UQi1Up/7HI27GfyIDtEikcOSem/Vpu9DMD8yTfURw4p3L8SvWbxu6sjdR4oxIZQo/nbkRQdw9o/xVsYaiMBovDpkmvhdDdhlJaa/2gGI93PVSsMrScBQqSi51HBStd7UfbOCV8aYxte8Rtw2QKmwtBCPZIjEvUEai0l2kBo5UfbXAB8GSGow7pPET5PrBkKc1aVWitxyQJ2nxzZGOEamGKB9HJZpoGbpcWrvRpVmd5GDKgcgH6ZX/Rb/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEiWt2UtgpbbvpY2qVlExHplgGlGQR9stX5MssPh+Os=;
 b=q1BGQ+SnyV6/J1+oAKbEu7R2UX0KnmEeXPy7ygmptvTwJ0HrOzkPnjAFXjxYdJT0VuGG+Eh/1U12oBtIBTBKgAyHPE72sulArVZDdjzbi3kHpGOppCgE47oxoxHlOfd8krIbrkYW7rmjdfZBfq3ozZBg3dw5o/UZgqxOP7KWwcRhtrAEoUqE62MKYG/kMcu6c36hSNdxcA7fqUTThqjsD2rdHuBkzHITIbhn0BFGdgUXqOeXetorB2BHvWmuE7UjUse832BSVwMw0S765DYk6beJI+0KHudBT1yNnQN54YbAoSW/Z+rxUyNWtwy0NPieGtXbxGSDMYI7FslMlI7SYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEiWt2UtgpbbvpY2qVlExHplgGlGQR9stX5MssPh+Os=;
 b=2T0Wvpg8O5MFndYQwuBVVVykwmx8de6OAk9kLVdl/815fhDs37MDubd6Z9HeM2Yu6qspwJOLYiOKWbV3ERvNkTLC4OL5UmVQao65udoUay35ZP/96zGMiHQyL30fiUxaID8dbIzg/MbnSj7e3nVJtm9s6/IHu3U4JXUMRj5OziE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 09:02:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 09:02:48 +0000
Message-ID: <5976d500-d768-4a63-8fbe-4e68e20fc0e6@amd.com>
Date: Mon, 13 Apr 2026 11:02:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: gnome shell uses max priority
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413084943.819126-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413084943.819126-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 77b2c179-b6c2-40a2-75f5-08de993b6f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: CMHpW9leSBn/QU1HTYx89QUQcWLvXlt1TVKKZ3c/dAgn9oEXAwAw0LyLDRpSs+psXr5BuUo7SF8XYkbYS/D0Uhi9Ubsgqie8Y4MUd8IaMs+iRcBCCC7JNuKcl1gyLH2cCH7cilYuPokviYjJtm6W92fxngLLbufEEtYVRiyGeKyu0KKM4pgcXciETAxgrw7SKXxfhnNCZLBaM87qimA0ElGY+MfOPXvMbgBltD00XKzZ8JaEP+0LSnuGEX969lO796xSdnmP7Z348AyeQ1IX3J/N3c1IqWqH2dADXbYaD1ol+rLzBsyElVxThIgAAq9bv+FjUPclMMmUSajotR3rnz3eegdsrwev/PmWj2ZldHAD7I4jWebXeUtZ71eLipm6aQ3dTZG+szvxlhItchy9/Remcp8J9Ew1lkyglx1wfq3LXnXNNCMcMWrkWU+cpxKa3GfZp/8d7vFLoX1EM1yIDzLXmPDDFDPA7lQ4Dl/IPFlYWfSogK3SScQxETFN/WYVptk/usZju7VSamPJh6SUNhY7U6UM9S+74/lcp0Dd8F3CXnmtkM6uLsdhaE7j3aZnKEk4FeUZfCM5ISznNN0XUkWW+nqh0qFoW0CGYczgPZFSCeXg+WKjEhOnCNiNtnhIxPfpT4E/3pAgqZo/2JgFelz1w/K6JFqBwdFySmiR/E0Rk/gTzCS5ocLfyYytaysurz7Ch8uaaXulx1tnKwX6oyOBO32gxhob+dnD4D/a6+A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWY3RjI1NFd6UWFtd2RsaWx6bWtJVThhenpwZ09UK0NPaGEzWWU1UStveGI0?=
 =?utf-8?B?NVdLRXFTWi9SU2cxVnVyR2x2WnZOSVMzbG0vU3RhaGgydkt6bXJZTkZmTnZW?=
 =?utf-8?B?bVg3N1JWOVVRQVFQa1RiaGNLRWtWdjdtSUsxakwxR0JZMGVZM3ZtMndVZjN3?=
 =?utf-8?B?dFB6OThPeUhid0hjMTdoM01UZ1JWOVZGUUE5MDhCZ0VFQTBiZHhXenNnZWRB?=
 =?utf-8?B?WVU0djc2YnZqTlBTRis3SjdLT2N0RlJ0WHN2MWJmU29SWkxQZkNrVGhMdWZq?=
 =?utf-8?B?NWhoK09ISk5NclB5QWhjYUw3eUZKRWhZYWNRblFSMmdnUk5KekxlN2lTU1dG?=
 =?utf-8?B?bngrSGlhbTVNcFdQWW5vbXQ3cjlNcDN6RksrYW1qNGZkMDBuVWFnUXUzSEhu?=
 =?utf-8?B?UHpFSC9WZ3RUY3NnZ0k0V081YXlmNVMwYllMaE5COU56dzJBQk9JYnVSYnRw?=
 =?utf-8?B?VDlOYkdIVFlMOGhmN2ZKSWJtR0RuQ1FvU3NMLzJVOVlTY1pJMnFPVjJUN1NI?=
 =?utf-8?B?T0hSNlMxbnNEMThyb1lCK3BiYlA0QzF1N3RIZnZidGNFYk9PaExKeXVTQ29t?=
 =?utf-8?B?VlFzT2ZwbXFlNnFYUC9pSkxCWThDbmQzc3hCTFhaRVFvSjBLSjhCekpQbTlO?=
 =?utf-8?B?OGZwY2dqM0VtcFlOaU16S3N5RjlTaXpBNnZqVVZjUDhjK1J3TllkcTcwTUMw?=
 =?utf-8?B?ZWY0dittTmdUSW1rUUZHQWovUldYVlVicUxkN0tObW0xL1JMNkphQ0RlbmtL?=
 =?utf-8?B?dndnOGhTZk44U3dqenVtcS92NE13aVR1eUVyYmN3Z2c0dEpBTjl2Qm9sU1NP?=
 =?utf-8?B?bE93VFhjTk1zb0Fxbmo1YUZaRmdVTEd1RWpZelg1dHRxQkpBUG1RT1lLZVd3?=
 =?utf-8?B?QnVuK2NHdHNNbThyYko0Qm9tUmtlMXBHVkxyVjkzMlh6NnB4NkEwTWlpVGJD?=
 =?utf-8?B?c1lJSFRRVCtuaTdDdk9NVTk5ZjhOTXZvNDQzdU1wL2crd2ZDNThZbDNkQm4y?=
 =?utf-8?B?RTArZU9PYVJGcEU4dFBuaXhXbk9KN2FTbVp0anJKR1NwQll5eGpvZWU4RW5j?=
 =?utf-8?B?WVpkOVRCdlJXMmdBTTljb05kY0xLRDdzcnZIRDk1SlZMNWFiUHdaTW9yeWFB?=
 =?utf-8?B?ZHRsd0ZRck54YTNjbmJ4L1Y2ZHYwL3RFUzNrUXJDc2o1RHlUWTlXTHhtckQy?=
 =?utf-8?B?MDl4VFMxUjQ0ZHpxWFc1dFdBYXcxT25pQktRUmt5VkVZd0o4NVNhRjkvdHI4?=
 =?utf-8?B?blBubElzR3NkUUx5Z2gyMDdBRE9mekx5TjVLL2IwOTB5NWYyMDdtZXVSUWdk?=
 =?utf-8?B?aG5tNklaOEs4UVNUVXF5QzNxNmNrZ1F6LzFZVkVHc3pON0hNM0lQSFZ1NE5p?=
 =?utf-8?B?WHRiOGFFdlpQLzA4VkMrMnBYSm9pQ2xNUWZwdzZlaTlNeFlaajZiUXFCcW5l?=
 =?utf-8?B?RzFTSlFzbVJpRXBmSU1qTGsyZUJUWVNFMmVIZ094QlRRQk15TWRad0c1Qzhu?=
 =?utf-8?B?Z3BkTnB1VDJNM1BIaGRWdWpNOFBTeG5wVUljc2x0QkxIYWU0MWJucjdXdmlv?=
 =?utf-8?B?cUlLV0J0Vm83cVpKbGljTDdGR05wN2Iyc2Yvb0pqU1BBMHV1SlJLSnlQOGJn?=
 =?utf-8?B?WUZIaFkvTVlUVFlFbDlGNlpSbUxMcDFOdjlTRmFGQk84V2VsYnZYOW1lTUlJ?=
 =?utf-8?B?cVJzYlovbVN1bklnTDBCN1N6elV2eXZ4TGZWREJVTXVLaWJLR2szR1lleThp?=
 =?utf-8?B?VUtxdlFGc0Z6aXpkWFlYZXlhTDBsYm1lSzNiTHpPUlpEMERpcjJTTTJORith?=
 =?utf-8?B?Z1IzR0VZRkRiOVVWMlVtNXp5TUlCbE9pWnRpTWIwKzdYZnNwZWZ5UUxMZmg5?=
 =?utf-8?B?TDh3cVJENEt4SVN6NW1JRTMyWUc2UUlCSVpzRFYzc3hQbEhLOGNsMlRpNkdJ?=
 =?utf-8?B?WDBzWHVwNzVjdnEwZjcwRE5VRnluRGkraW1tYTVXUlFOZzkvcWcrNEVGM0Nx?=
 =?utf-8?B?cVVoa3cwZmYxYllvMEVReXpmS1E1UzlWbEhSSlp5UkNJOStOY0luR21JUm43?=
 =?utf-8?B?RlBrR3lQdWZNQklPVUhxSGYwUjJXLy9EL1VVQ21MWnFBRVBJZ1BIMVhYaTZt?=
 =?utf-8?B?RURRVENEVXVuQldXWUIrUzZ0eVl2cEYzZU0reXBMa051R0hvZjlrT2cvRVU4?=
 =?utf-8?B?a3hXVHlBb1BaSTdicWRQcHFRemEyelI4YkZhRGdvUm5KZHkzdE9haTl5RmVt?=
 =?utf-8?B?VTc4YzJGcndxT3duVGRCbjRqbjMxWmhQODRxeVlPSkg5L0EvMnFQMmIwZjU4?=
 =?utf-8?Q?ZlhfF87JO8gg4kEzGq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b2c179-b6c2-40a2-75f5-08de993b6f1b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 09:02:48.2484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L0YRLs35SLZ4/npyss1h07zZA05MzOajhtXrf6Emtxw2CvSyFASosdjkUyOOCtFs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

On 4/13/26 10:49, Sunil Khatri wrote:
> In function amdgpu_userq_priority_permit allow till
> maximum priority i.e 3 which is seen for gnome shell.
> 
> This is needed to fix the issue of unable to create queue
> for gnome shell.
> 
> logs:
> [drm] *ERROR* comm: gnome-shell pid: 2802 client-id:10 client: Unset ... SK: Priority 3

Clear NAK, as far as I can see the existing code is correct.

AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH is only allowed when you have CAP_SYS_NICE, e.g. you are root.

That is also documented in the UAPI. Question is why is gnome shell trying to use that?

Regards,
Christian.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6a635bb8bb30..b4f7229c21c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -701,7 +701,7 @@ void amdgpu_userq_put(struct amdgpu_usermode_queue *queue)
>  static int amdgpu_userq_priority_permit(struct drm_file *filp,
>  					int priority)
>  {
> -	if (priority < AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
> +	if (priority <= AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH)
>  		return 0;
>  
>  	if (capable(CAP_SYS_NICE))

