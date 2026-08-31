Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9252BC61DD3
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 10:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EB6C8826D;
	Mon, 31 Aug 2026 10:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmrVmjuX";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C9810E277
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 10:55:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTJmd/v282RT/eqeEY4ZFcfEvBp76PODSszqwAAOwdJZiGIn3SeKreQxVs/ZbHhH2L8BXaS2rVE2EKxSe9PlSJdUhbp8LjSSlv2dtlAbQSZe6G3ikBW/4YalVybNDdwfravSDm1FFzs3BmsisHJ4pqdr36JI3X1pgovOu8xNMZQSqyMuH5npasQ69RJKrqO9e1xWBAhKVL+KwFYWfDtQKTFdXni2iP3iJ251xayfQ5JSZDU4JZeoWgu7G8mYbmLJrFrJ6pb547cexwQoEVu36xatlyos0G7ebVZBw9BIlQlx12zLCno+7R+XShcqqz4CZHr5p8XHVWt3mNJlUkn5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuv0ejzsDq7fQ1wrq2kRryzNAYweBcVmKahHRvMKdOE=;
 b=FiSEIgAfyCAOp8GiOrEu72P/Pco1gRnYPtPoozMAko9hvplHSV9VX1Q0haUc3d9HzqXT9572fTeClBGZwIcGdGq1vc/kj/1PgMMpFDwbnjK6dSiS+5L3AKLyfvOFtgX6IGrLIVJVfutf5FRywtxtKbnyONAr3Y6EjMWim/StYDzWGqY90pdq6xa+eqwY7HQAVOtNfVIJILhcFNq3J/Y0w3yX4Pzzb9ZSBpOMws1Rc2t/zul4VRenu+lvoLyP656qSiAwNZZSZW67LdFI7d/WCfDvZ4pElkGtHFOo2+JiDiYB+XYRuzmmw2N16f+IszUZtLjdGCyj7H5r2+6oSFfhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuv0ejzsDq7fQ1wrq2kRryzNAYweBcVmKahHRvMKdOE=;
 b=GmrVmjuXTaW1h1vSOGEInFHFkciu56gNN2G1axnmwW+/Aie0MqcjAd+cRSCzTspYnNKhLmiMDHhVek2uCwcttF9CFcv6PCZAUMkhKef5mm7yLbJ9IbRKjA2RZHINVR3P0j72goRwrVeCbEJtYsja3BL2IHXUSVvjxnCE+MVY3CI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 10:55:46 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 10:55:46 +0000
Message-ID: <6041b95a-ac8c-4410-97cb-8eca51d20d50@amd.com>
Date: Mon, 31 Aug 2026 16:25:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
To: Kevin Wang <kevin.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
References: <20260831043507.523599-1-kevin.wang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 78a52db3-76bc-40a8-3065-08df074e68f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HoGDxo//isK0QbHofUfrsNX8ldJqCBbCLk1CuKlXraMQpIDaR1WhAZUtFtV3r4qZESdqyqmv2VlGwZ4RyLWlJoiGlVowY5C9NTs/qH5aAHUJI0jT79BqvdGOn1R2UCXCfCONnQSe5B6glxU6m69k9ErZxSRpzp+eH8MsPDvdSSlXgdIBYx/IkAlp+k8lyW2bjs06idX894VFWf6BG4izJmhLnlQLZ4MEIjJW6dfu0m6GNj7Osy+5h9sYqjfaIiZqW4LaEAFVOYlb/l+WAsxQ+0MgFNWMj1X4aLOJgp3KVNN03O/B/vs4E8n3Drg5RR9g1L96idCYburRhwjysrCLnCFbKNTFEtiPAHBfawOeF2UOMlKYmaDx7rY/w1vjY5vi3vxWjctVUigwyRnM64FTJCoCN4XDmHRdaPofu3zj5TBt4AMKioHYgH6b5MnVga/f35xWkBFUFO1kkXj+G2qgdFhac1jYGmBOBBvNyrcJQjJDSTHY2w+oWhzEjxL782i9vC4ZRiGJGeL5tiu6dMb8vAGNsYt0cAD2dSeDSSiFhKFs+AjOd5fPnWEKvwP1cpoCKyo9Unn2ZLWAo9nGkZ4CJ4BrM/gwT7o101gvUZQdUow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFB3TUNGcUpZeFFSRG1FNlVFdjlseWdEMVJFS0ZGbjdFeXVvUXhLQS9seVhy?=
 =?utf-8?B?SkNLejVldkZPL2g1NUVlRG9xazlUZ2xURHpiZm5kU3YzSDRJbnMxTVVwSS9P?=
 =?utf-8?B?L1pNQVFUS1ZhM2NwWlBUalFkT085NVA3anBZSUN1RFlMT21FdFRoclRLaGMz?=
 =?utf-8?B?ZVZJNWdnVmRHbHFDc3hPRXlQU1JMbzBFU1B0cU5PcHlteVJ2dDVuekw4N0Ny?=
 =?utf-8?B?YVBwajYvVTN5Q1llOHltZ2w1c0J4YTEzMVhJd0lqZ1NrZzdDNityNmJ0WUty?=
 =?utf-8?B?S0gvbWo1dHk2QlM5UEh3ZU5nMWo3c3duNTRtcjRqR0c0bEVrcDBtSVZmb1Rx?=
 =?utf-8?B?R09qVGk1MDEvclppQkpHMG15cFhrZEFDbDNWMjQzRVdMRmlaRWRBQ1Vpa3pY?=
 =?utf-8?B?bksvZy9WYmRKbWpkR0g2VGlCSy9zZ1hPQWhvcW9VVThxMVVycTU0TDdBU0Yr?=
 =?utf-8?B?RU9peG9SRGUxUXB3cmh0WCtjTjVTMGc2ZFV4OUIvUzZuYndzMHN2akloQzRL?=
 =?utf-8?B?dTVhK1Rmd29rQWlqOWJGMzBtQlprT0lybUkrL2Y1TEJ0SUFnZGxXK1FSOW9I?=
 =?utf-8?B?UGVHZUo3Y1lKaEErQW8vcDFQMEYvZzNQMmUyMVZHcW5mQmxKSkZTRkNjb2lt?=
 =?utf-8?B?a3F0QnBnaFlPcHIzM1V5dGxRT1RzWlJWb0JUUWRlU0Q3Vnh4NXZYWVVRZnRB?=
 =?utf-8?B?UWtLZ3BaOHRUdmJmTTQyQmJQK0gvelh6ZlVvZUdLdm9taWk5ZjkxbC9sQUpz?=
 =?utf-8?B?KzgvQ2pzNmYyL09yRWFRZnB5YzJYZnV2OXpmWW9seVc3SDVlamVMNkVPeWl4?=
 =?utf-8?B?blptQXY3Z3ZYbDNUOXgyWUdGVzFHZzNLbDRYSmpBUUhLbDVsdlN0MGovSkRK?=
 =?utf-8?B?QVBCNTBIRHREQjZZU3AyS2lieEF5QURoa2FobndvVjVuV1JXdWlNMEhHQ2J3?=
 =?utf-8?B?MWQ3WWdrNE1CTHRPRW1qTVJNUlRXL0daZlNiM3FqK3o3Rno3YzdKNTRBSTZV?=
 =?utf-8?B?eUxMRVNsUUp3R1gvSkU3TzJBNjhIZHYyUkRXQ1FQaThtOXJIbnV5dkpRYXBa?=
 =?utf-8?B?TUVOVmxZb1BNRE9BMkJtZ0N1dkdGTXJ4MVpSSXNFa1FiWE8yQVA4NzRvOWNl?=
 =?utf-8?B?aC9FczgyUldQalBldHZYWTFxUUtFVmk2bGhTMUl1TXFEVzc0OXFGTzA1YmJl?=
 =?utf-8?B?K21NS3p1eEE1cmlyUm40cy9od2duV2hJUHB4QjRxd1dPUytDSVZWVExHL01j?=
 =?utf-8?B?L2tLNk5EVzNSRlRqaWZSSUxROXhHaTBaZ2tPR3lQb3lwVy82TVYwYmVSOVJR?=
 =?utf-8?B?enVBdzI2TmsvTXJWVDVlWWxyaUZ5SmZJV0g0MU1ERmw0Rkt0VzM2UG9JUjA1?=
 =?utf-8?B?L0JRbnZHbFlyaFJXMmRhb3ZhTEVyekpEWkd0ckxxbXpmRXVtQ3J5SDFDMHhz?=
 =?utf-8?B?NWRLRVBZRTBzbXVtNWkvaDI5Myt3YmI0SksvVW10bXRScmpMMlF2cXR3cjFL?=
 =?utf-8?B?bDlHLzZ1S0ZrZGNBNGtGSHNnekJvTytydEpNKzAxeDczVDRteTZhblAwallE?=
 =?utf-8?B?amdCU2xralpiSFR1WEhBd2tOR3FLSkRxc2M2M2lVSG83bVVIdXQwWmJHMS9p?=
 =?utf-8?B?Uzl6ald0SFBnQnRoc1ZWTzBuUGFSZlJ6NDBlWlNDekFubHoyenI3SWRmbitE?=
 =?utf-8?B?Mlh2TXBXeis3dDBvbmhGQkdUTk9ORFNpamkzb3BDMm9Nek9BbUdyYUxGdnk5?=
 =?utf-8?B?dUt4RHk0bldObHNPZExHc1FIZjNsMmlHLzF0Z3FSNWdQeG5US1pObm83cGMw?=
 =?utf-8?B?TFhITFhvM0lCTkZvZm9mQThmcEQyVWNSK2VxYWtuUlFmMkZqVGFzRGpMWVRE?=
 =?utf-8?B?T3Vvam83YXl6aHIrTEovWThxYXBTR0MzR21aUnVEWGRjUnR1SWxrWUY5UGM2?=
 =?utf-8?B?VXVNaHFUckNFZmh3WW9tc05wcG1hNjF1VGpnall1dUh2RG9nMEFaY25TdXdm?=
 =?utf-8?B?cUlPVFlrYzRGbmVEUGNNMlcxdkdMa3JEOGcvSEhSRmFzcEpFYlRUb00rR3lW?=
 =?utf-8?B?ZFpMaVdwRjE0aHBBbUNVdHhaU2RvQTJMbHdUbGc4R2gyZnoybUp6MWYydzRB?=
 =?utf-8?B?c29FN3pBTVdoS0g1OThNN3F2dDFYemxKZFJiZm54ZnVhVTNhQmRIUU5GOVc0?=
 =?utf-8?B?ckpNaXNDaE1lSlhRY3pkNjZzMy9VUXNKek9BZC82Uml4SUNzL3hXT1RMZ2Z2?=
 =?utf-8?B?OG1JSzQ0bnVSSCtCL3hNMk1QeEIydTJvSXpIK21YZVZyME00anZONko5TUh0?=
 =?utf-8?Q?j+5UZNkUDNCppZp6NU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a52db3-76bc-40a8-3065-08df074e68f9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:55:46.1104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2JglmEv/LIr5K/dYALehhL4D+sdWM4WKuzLHp1EctAogLeVZafwgCeFtUajqlBJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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



On 31-Aug-26 10:05 AM, Kevin Wang wrote:
> [Some people who received this message don't often get email from kevin.wang@amd.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
> users edit clock, voltage, and power settings, then write "c" to
> commit them to the SMU.
> 
> However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow on
> every SMU version. Some backends restore their cached settings and wait
> for "c", while others upload the reset table or send frequency-limit
> commands directly from "r". As a result, the same userspace sequence
> has different hardware effects across ASICs.
> 
> For example:
> 
> - SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
> - SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
> - Navi10 stages the boot OD table, while Vega20 reads the current SMU
>    table instead of restoring the saved defaults.
> 
> This series makes "r" restore default values only in driver-side
> staging state. "c" remains the sole operation that uploads an OD table
> or sends frequency-limit commands to PMFW.
> 
> This gives pp_od_clk_voltage one consistent transaction model:
> 
>    edit/reset -> staged driver state -> commit

Reset should be reset to defaults and shouldn't require extra commit. 
This breaks existing userspace for SMU 13.0.6.

Thanks,
Lijo

>                                                                                                                                                                                                                                                  It also permits userspace to reset a staged configuration, adjust one
> or more settings, and submit the final configuration with one commit,
> without temporarily applying an intermediate default configuration.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690
> 
> Kevin Wang (7):
>    drm/amd/pm: stage od reset for smu 11.0.7
>    drm/amd/pm: stage od reset for smu 13.0.2
>    drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
>    drm/amd/pm: stage od reset for smu 13.0.6
>    drm/amd/pm: stage od reset for smu 14.0.2
>    drm/amd/pm: stage od reset for smu 15.0.8
>    drm/amd/pm: stage od reset for smu vega20
> 
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++---------
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
>   8 files changed, 145 insertions(+), 88 deletions(-)
> 
> --
> 2.55.0
> 

