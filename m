Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7DFCCD19A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D08310E094;
	Tue, 18 Nov 2025 06:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="heUnQeLD";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010062.outbound.protection.outlook.com
 [52.101.193.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B7710E094
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 06:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBFxgaieuE92FQPqo78bvTwxq+zlSGxLp/YoyY3gLh9YrD55ZJOc8DSy0e6ma9JTqvQv/gzAxnnrE8gYiLlKpeSDolNShxPikJnihhQwpYVTh2frSyQAPM/jw22l7NV5dEsC3oX21+dOyqLps2lCXYNshszgjN2wzmeGCDHhCY3caD2YT77khIjT6ixONEvSCWUDFJtFOYWn6l4RrxUrYGCjlbNvNh3ANNKg37c5d7547lLsWbgr6Ez6JQjWI02pdFGSBb1qz7YpJPQsG5FDtHgVhAUSefHUNLDJ1SZqoye489CHGqJsomzv8tPHKcfPSqithBIt4gb2LtN6AmJ8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0c+399iM798KAQHUxNyiWFzPHT9kEETdiSLY5chNO3c=;
 b=ADRgHYonNr8vSAEJCb2SW+/9WRczOHTHAY71A7b33zeMVzzAfF59mYctKVZn2HZWEBhzMlH4N1U7m5AMTBQ9wLmzmwdhO1sWFTk5r080Z3/l4ip/1sY/L7C7ymjM0u83rsNQcUcEcXK92NsYbIZedU6vO7gRIR0r9BGqQrfVShxJVRYwbhNfAnyZ5CoNDvbLxiwDZ1VRoGNPt1woyUmiQvQP3tQVD50SX37UrdMokQHm3fhXLC78mveZQFbhqLBAJLbiC0PW6g5BZrzlTLWUUdPyDY+DZc5m4ziOF85y4ozDy3SiCmDyPSr3CDUFyxaHlB1j4VenZGOFDwHuU5LSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0c+399iM798KAQHUxNyiWFzPHT9kEETdiSLY5chNO3c=;
 b=heUnQeLDALHqXO3MnkAweyMR4rDMc7TOwfV2mgR8DP9sZGiKG2b3hKzm2R4fQcjg+AjOFQBLcQsQBER8/9vfu3L0VAvJz5RNKzX1TBgVaKe/21kM+dOKxwRAmJV/LqipZyaZcuj3bpMJCwTMDmFXwywObEJPjasajv06elIq8qk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 06:00:09 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::4179:4c7f:76be:47d8%4]) with mapi id 15.20.9320.013; Tue, 18 Nov 2025
 06:00:09 +0000
Message-ID: <fe886d93-36c9-4895-a9e6-c9f38f8ceebc@amd.com>
Date: Tue, 18 Nov 2025 01:00:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: FORWARD NULL
To: "Martin, Andrew" <Andrew.Martin@amd.com>,
 "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20251114144033.1432008-1-andrew.martin@amd.com>
 <PH7PR12MB590242762FBB162CCE923A0385CAA@PH7PR12MB5902.namprd12.prod.outlook.com>
 <8f5fead3-2f4e-4352-a4d1-2d316bdf23f7@amd.com>
 <SJ0PR12MB81387F24365922E3E1EFE646F5C9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <SJ0PR12MB81387F24365922E3E1EFE646F5C9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::20) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b80561-7de9-4e8f-b58b-08de2667baa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnVpNGFrMmVTVlRMdXJKMXc0cHZDNUNkUXhFNStBY3R3K09pV1ZqSkdsaU9i?=
 =?utf-8?B?ak4zT3dIT1FZckMxaUFHcGZRd2lSNGZIK2xLWFY1a3pvTUJCdDYrWUJVdDEr?=
 =?utf-8?B?VTM2eGRqVzV6WTI3Sm9WY1hITUpJR0R6TDlWaEp2emJqWXprZ2VyZjZkQnlB?=
 =?utf-8?B?YmFkWDd2MnhyVXdxR2xWcW5ab0R1MUtVbzlXZFNkS01saXpCZVJsdE9xOTdj?=
 =?utf-8?B?NGVoeGExakVMb3ZrRWRRTXhOT2lrdGNkSHEyYW9PMXlVUmgrUmtYdERJVmJE?=
 =?utf-8?B?OGRTSVlaYnZuTm9yL3lHSytZYUN2SCt5L0JmU2NuTU4vYTBlcTJLdlNCNlQw?=
 =?utf-8?B?cnFFMHN4anE4b0VYQkxwTFc4aTNrclhHaVJ3VEV5dmQ5cENTK0pYazIyZzIw?=
 =?utf-8?B?VXMzbExFUlNVYXBCVHhjTXBZeUJ0ZlZOeEFUeG9MaUlHUkxZQkNtdy85WENl?=
 =?utf-8?B?V2VoaWRNU1dQaFVhOWs5NW1QRE5HZ1A3RzduWmFvdldqQ3p6SGdFMURrRnJr?=
 =?utf-8?B?d0p0YmFsSWFZcGRBb2YxUlFSSUxMT3Z2emNKbUM1Y3o0RldRVnNneFNjcG50?=
 =?utf-8?B?U3RuRXQwdy9TQVNaUno2NWN5dUQ5UGN0SjlnU1lqRkErVU82b2JhcFcwcldh?=
 =?utf-8?B?UkpCYzNuY2pVOXlzK2dra1ZOYXdKRG1DVnNRWnR5bjR0S0pEWnBLR2pGUmFl?=
 =?utf-8?B?OUF1ZkxaSkRqWEQ4b090QXo0clFEeVRzR2dWc0lYa1FsbHV2S2tTd3B2OUZE?=
 =?utf-8?B?VTNScWI1SFZ1K2cwVG9IWGFxTmQ5czhwT1dzZFNmeFNxaHdJL0MwbDlUWVZ4?=
 =?utf-8?B?OWhOUEpKaEp2THlCc05OUjdpYUNyV3RGR04wRm5Ma0htSkJVNEgwUk5ueC92?=
 =?utf-8?B?MkpJSmZCRi9EUGtGRDJmTzVHeGI5NW9qbEJxMkk0L2dpakY5VlZLeUt2ZVlB?=
 =?utf-8?B?NXFDR3BiNTY4NlhWMFZ5ZHFmdlFhUWtyNGFHKzFJOXJoTERITnNvc2pldVNU?=
 =?utf-8?B?V1ZiN0pGRGJ5d0FWT2ltK0k0N2J2ZWZoUmxuK0hINE9paFByeTFTUTdpNElF?=
 =?utf-8?B?UkswZUtETDRPRzlSMzhjdW55RjRTM0U5UksrczJCNTNpd0hINHl0WjdXOEYv?=
 =?utf-8?B?SFI0eVhKQTZjQkZjaEdDa2xjRm5mY1BITXhqODlNQUJJNjkyK2p0N25xRHNK?=
 =?utf-8?B?Z0hmZFNMZ0RvYzA5ajVwREVpTFdMQXJMVkVCenFZTGZYbjNhL3lqd0tUOHVJ?=
 =?utf-8?B?ZUhQV2Mya1hZWkhBQ0hYWFh5bkl0VW5iYTdQaUhqOGVPallITy9OQjA3TkNU?=
 =?utf-8?B?eFJFc1hZc0ZLa2ZJTExaaW9TYjloMU16OVlTL3JGU3ZCY01rSzB0VndFZGVm?=
 =?utf-8?B?OHRqZ3pMZ0hQelowU2cxL0hGNkpCei9XcTYzVHo0eUpiWWwzaldlaXFVUGxT?=
 =?utf-8?B?UktRdjJUU1RqODlOcENsd0Jqc0UwMk9WRzNRMm9zc0I0TnRrYVgvWmp4QVJq?=
 =?utf-8?B?b2Jpd1hxcXo3L0lWQ0VYNXg1a3ZnZ2dBWnhYRVFiaS9iVURnZE52UzJLSWg1?=
 =?utf-8?B?NWFYa0VqZFRCaHhBeUpleWxrYmdRU0VMYXBwSEZpckRKWmwza0c0WVFUbVJl?=
 =?utf-8?B?aSsySURGZll3aWJEZTEyNWp5M050VUJ4WjZMUXZJWXBremhZa3NhYzM3YVBJ?=
 =?utf-8?B?UzYwUk9Wbmljem0yaWJvcXpremVTNUI3WTZoLzNocFdnWXI2aHZDWUVOcUJN?=
 =?utf-8?B?TzVZbnZQUlA5allQZ0IwYURsOFRmSGE1b0kzUnJ3eEswQXdCQkkrR3pqdVhV?=
 =?utf-8?B?SkdBWm5HRUpPRnhzMVpoWHZsTFRLc2NWUkNLTFdsR29CdUE0eTJGV0dCd2dn?=
 =?utf-8?B?Z05seGlmbDBJamlLY1llTEhCQlVVVTV0a21SbmJsZkZBbmJuSmFEMmhOaFVW?=
 =?utf-8?Q?qsyuX+ukpMWpEIsMTuMLAUbk38E+W5hJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjl6REw5NTRXNExMQTBqdG1JSFA1bHpSSjQrY1hyVzRldTVxbEJhN0JtVERo?=
 =?utf-8?B?T3ZwcWlmT2ZPODNmcHZKUGFEYTJpcGFWVHhSNFNyRzdOSDlVM2tZMmt6ZlVH?=
 =?utf-8?B?TXE4cmlyL0VHQWdYSlUvRUhmeGNjSjhtRmh6dzlWVkpNam0rcGVpQUV5NE14?=
 =?utf-8?B?U1RKN3lQV2tVNkFwRWQzVmx4cXFSVnIzM2p1djRlT1lNNWhFamRNQXpkYk5N?=
 =?utf-8?B?RHlTeWhMK0VlVU5sWlIyNXh2K0haL0lKdWhEbFB5UElHQkZOL3ZxckxCRDlP?=
 =?utf-8?B?QUl0T09QcVZiYkRpQXR3L3gyb0ljbVBqY2ZleVU3VzYrZ0dVL1UrblQxYTVi?=
 =?utf-8?B?QktqQ0pIdmNML2NFSWQzSlN5ckpjVEkyNzVDdHI5cGNhVGthSy9KR0pINGJY?=
 =?utf-8?B?c0hGWnYyNS9pSGhWdlo3ZzZTRVhtczB1d29aa25zdUs4aWgyRkJtNTAvWHZp?=
 =?utf-8?B?bXA4MTIwdWVWNGF6TDFXbjh6SEhBZCs2U05nUGEydnM3aVpoaUwweVlPV0k1?=
 =?utf-8?B?eWVZeHNBUTBzQWMvcWh0QjkvYmxidTNzOXo0OEdoOFV0NGZ2ckF5aVlLWXZH?=
 =?utf-8?B?SHZhQTZMbVRicGlIVitYdGFRV1Q4ZzNyWWo1SVEyekd2N2g1aDdOZXBoMkEr?=
 =?utf-8?B?Wm1uZ0RxaFFkR1lrVjNQdUptSkJOMC9RdUEvd2Y0b0xnOTFtU1FTbXJmdzNt?=
 =?utf-8?B?NWY3Y3J2VVRNTXBsWXBIVUVaVm1EU3h0eUpSMmxZakIwNVRBNEtlenl4aXNO?=
 =?utf-8?B?UnBCVTRIYXhUUTBLd01kMEthc2ordmRhWEFqMUJyQSsvcDJ3Rm5ndlBTK0xp?=
 =?utf-8?B?RkxhbjNaalNoYjJleldURDB3VG5lNDlmNWVYNXI0eVhMOCtOTW43cUhsWlZu?=
 =?utf-8?B?YlluNFZnYVMzajNEREd0SUU0cnp1bE1oQUloeDA2ald0azVFNTA5azBZbTFN?=
 =?utf-8?B?dm40RHRjK0cvby8rS244OGZtWlowNStqbzFrQmV2bkVGWEdIMFQvYUp4cnhm?=
 =?utf-8?B?MjhjOFdZMHc4STB4QVhodktCVDJLSVJId0JrWWFHYmEyUTFCZE1qdzVKd2NU?=
 =?utf-8?B?bUFyMHJtQksvd3BFcklhVEQrZ1hvQWtEMDY1d2p2Z2JoOEQ4WEwxN2RjSi9S?=
 =?utf-8?B?ME9wWmxBWi9SdFI3RUh1Vlk3UGRQdGhBNS9aZTkrYW9BaG1KblhkSXp5Wnd4?=
 =?utf-8?B?VTE4TVJtYnhxL1hMNW9DdEY0NU5sSTcvZzFhM1BLaWRlTk9SOGZRdXIrUFNk?=
 =?utf-8?B?blBtdFJoYkVjcGhLeGlVUkhCOTQ5MmZHOGJZSk5HRGFScDhmNU9xVXpsckRG?=
 =?utf-8?B?WXlnVERITHZPbWphUDdkMklGaDZ2TmpFYzBHcmFBaG5EVVJGUnZIMW14VUJ6?=
 =?utf-8?B?SVdtUTdKd3RkbS9VYnp2NTFKUW8zbG9KQkQ3eW54VFo1RHRuSUpNb3ZuM2ZX?=
 =?utf-8?B?bkpneXhJbWRpSEVnM05jUlpDditpakFYSFBNN050Ui9jY09KR3QzSlIwbzNJ?=
 =?utf-8?B?UTdncndkcWZmWlY5azZiQVN6NXYySnBIRHp5b3Yra2NuTmlLdGFCbmhFTThF?=
 =?utf-8?B?a09LNjBqRU5wclp4NUJtZC9ZaExuejFvZERiMXlHckxmM1VIblI3dG5ORmFm?=
 =?utf-8?B?TFVWK2xiR0RTOGlkY2NuekVwMVdTQUhNVmhrWU1NMStNdXhwVjBob0ROWnpp?=
 =?utf-8?B?WkpXRloybzFHMVNxUG5zSXpma1lnMFlKSlIxTlN0SU50VVRjbDQzVmhkaWNO?=
 =?utf-8?B?Y0o0Nmk0bG0rNW10bGFXek5jZTBKQXpkaVhiL2swMmUzaDFjd1ZrL3NwZ0gz?=
 =?utf-8?B?dmVZbFA3Zno3TWlrR056RTlqQU11ZXNJRzdoRXByYlNnWmxWekViV0tpSXFa?=
 =?utf-8?B?dElvb3ZObGtTUDgvY3RKRStveFJLeE5lSHVRZVBZNVRJdlk5eThuK243czFX?=
 =?utf-8?B?YUpsNGVpeHpESm95VGpwbllKbm8zbXpycmY1Q25DNnRkM2Q2TThGaDBvOHNQ?=
 =?utf-8?B?TmJiQWJwMnN0VEJVdWpHemVUOGp4RmNGSFY0eTZJNGJSS2tBOHVxbzdWNTNV?=
 =?utf-8?B?bmkrbE8rOGxDVmtROGNWbFFiK1pmeko5ZWMxdmUveklNMVJqVTVsZjFjNFJn?=
 =?utf-8?Q?Tfg/3gtLqdm7PTnvjk6sEJpFg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b80561-7de9-4e8f-b58b-08de2667baa6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 06:00:09.0442 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCyah0EzOx0Q6A1lWai3LgrFIT934YfI1tWd3ndUc7Sth6kLZw5Bsu2/EljlsvA733Kj6V6FzPNRe3fKuy52Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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


On 2025-11-17 13:13, Martin, Andrew wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Greetings @Kuehling, Felix,
>
> Thanks for the review comments, please see some discovery comments in lined!  Patch 2 with the suggested fixes is on its way.
>
> Note: I have added 1 change in the new patch (re-running the scan, found it)
>
> file: kfd_crat.c:2360
> ...
> peer_dev = kfd_topology_device_by_proximity_domain_no_lock(nid);
>          if (!peer_dev)
>                  return -ENODEV;

Hmm, not sure I agree with this one. This is in a loop that looks for 
XGMI-connected peer devices. Currently we create devices with increasing 
proximity domains and no gaps. So 
kfd_topology_device_by_proximity_domain_no_lock should never fail. Maybe 
in some future scenario where a device was hot-unplugged this assumption 
may be broken.

To be more robust here, I'd just continue if peer_dev is NULL. That way 
a topology with gaps doesn't cause the creation of new devices to fail.


> ...
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, November 14, 2025 4:48 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; Martin, Andrew
>> <Andrew.Martin@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH] drm/amdkfd: FORWARD NULL
>>
>> On 2025-11-14 12:02, Russell, Kent wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>>> -----Original Message-----
>>>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>>>> Andrew Martin
>>>> Sent: Friday, November 14, 2025 9:41 AM
>>>> To: amd-gfx@lists.freedesktop.org
>>>> Cc: Martin, Andrew <Andrew.Martin@amd.com>
>>>> Subject: [PATCH] drm/amdkfd: FORWARD NULL
>>>>
>>>> This patch fixes issues when the code moves forward with a potential
>>>> NULL pointer, without checking.
>>>>
>>>> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 ++
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_debug.c           | 6 +++++-
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 3 +++
>>>>    3 files changed, 10 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>> index 1ef758ac5076..71b7db5de69f 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>> @@ -104,6 +104,8 @@ static const char
>>>> *amdkfd_fence_get_driver_name(struct
>>>> dma_fence *f)
>>>>    static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>>>>    {
>>>>         struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>>>> +     if (!fence)
>>>> +             return NULL;
>>> Felix can hopefully confirm, but we may need to have something here,
>>> since the references here expect something. Like in #define
>> AMDGPU_JOB_GET_TIMELINE_NAME(job) \
>>> job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence-
>>>> finished)
>> For amdgpu Job fences the above makes sense. But KFD fences are our evictions
>> fences. There is no job associated with them.
>>
>> I don't think the NULL check is needed here. to_amdgpu_amdkfd_fence returns
>> NULL if the f is NULL or the fence is not an amdgpu_amdkfd_fence, based on
>> the fence_ops. But we're in a fence_ops callback here that should only be called
>> for amdgpu_amdkfd_fences.
>>
>> That said, if you need a check to satisfy a static checker, I suggest this:
>>
>>       return fence ? fence->timeline_name : NULL;
> This worked perfectly.
>>
>>>>         return fence->timeline_name;
>>>>    }
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>> index ba99e0f258ae..42fa137bdb2f 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
>>>> @@ -517,7 +517,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process
>>>> *target, uint32_t *flags)
>>>>
>>>>         for (i = 0; i < target->n_pdds; i++) {
>>>>                 struct kfd_topology_device *topo_dev =
>>>> -                             kfd_topology_device_by_id(target->pdds[i]->dev->id);
>>>> +                     kfd_topology_device_by_id(target->pdds[i]->dev->id);
>>>> +             if (!topo_dev)
>>>> +                     continue;
>> This loop checks the capabilities of all the devices. If a device is not found, we
>> should assume the worst and return an error, instead of just assuming that it'll
>> be fine.
>>
> Done
>
>>>>                 uint32_t caps = topo_dev->node_props.capability;
>>>>
>>>>                 if (!(caps &
>>>> HSA_CAP_TRAP_DEBUG_PRECISE_MEMORY_OPERATIONS_SUPPORTED)
>>>> &&
>>>> @@ -1071,6 +1073,8 @@ int kfd_dbg_trap_device_snapshot(struct
>>>> kfd_process *target,
>>>>         for (i = 0; i < tmp_num_devices; i++) {
>>>>                 struct kfd_process_device *pdd = target->pdds[i];
>>>>                 struct kfd_topology_device *topo_dev =
>>>> kfd_topology_device_by_id(pdd->dev->id);
>>>> +             if (!topo_dev)
>>>> +                     continue;
>> I'd return an error here as well, because we obviously don't have accurate
>> device info.
>>
> Done
>
>>>>                 device_info.gpu_id = pdd->dev->id;
>>>>                 device_info.exception_status = pdd->exception_status;
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index f5d173f1ca3b..f40d93f82ede 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -1685,6 +1685,9 @@ int kfd_process_device_init_vm(struct
>>>> kfd_process_device *pdd,
>>>>         struct kfd_node *dev;
>>>>         int ret;
>>>>
>>>> +     if (!pdd)
>>>> +             return -EINVAL;
>>>> +
>> We generally assume that functions are called with valid parameters.
>> With that argument, we should probably remove the check for !drm_file
>> below as well.
> Done.  This is a good thing to note, but I want to have another lesson here.  Is this true in general or only for internal/private APIs? I asked b/c this comment forced me to really look carefully the kfd_process_device_init_vm(), which is prototyped in kfd_priv.h.  This mean this and any other function from here should be called with valid params.  But public APIs should check that the params are valid, b/c this how we prevent crashes in our library?

Right, I should have been more precise. Public APIs where you don't know 
and don't trust the callers need to check their parameters. Internal 
APIs where you know and trust the callers don't need to do redundant checks.

Regards,
   Felix


>> Regards,
>>     Felix
>>
>>
>>>>         if (!drm_file)
>>>>                 return -EINVAL;
>>> Probably easier to just combine the !pdd and !drm_file into the same check.
>>>
>>>    Kent
>>>> --
>>>> 2.43.0
