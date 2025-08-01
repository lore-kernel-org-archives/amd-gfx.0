Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B3C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 14:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E922410E890;
	Fri,  1 Aug 2025 14:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="COU+OT89";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED26210E890
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 14:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8IYqyY1xuVfnQbJTzljXAOCqg0+rfD94Ps1+NdDnaSV3WSvP1eQMs8iKnOp8c8sTZJTn/ny0kVwt+jSMb7I0OPeSI5AdwL+QnjhoJBH8VWmK7Arv80ifN7rZVd2yzI67nUE2uJyWmjlPaldI6uyn7BBBH30jt03/R9l2/NsW38KKtC9NiD+rfokvSy4ZcV4QwjAOqEt3vM6krF/90LInPKfV3jI8vyG06mlKrJIdsqD7OJAXOjdwhfAeQ/ReyYBJCwbuASfbTqwEnZQjBPV+qiynqL0mosZo+sNKxYe5gzmcd63SwAgiWn3vH+UfRX5Sy4aft6FcwYQM2rL+MCK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/pkHQ1LZBSn5h+i3Mz08lW2JgXKFHNM/9XMk9RWKiY=;
 b=FeYOPeHWN5dIOewtsGApbCKT3F8+tGOGVIUw+7F54LyKp7OGNGNIA2ydqsjcGW77/OmC0gUVjbE3zr82NXQn2gbHjLuCiRORhkxU/d6j5Epw6hq9SQF7PwXMwJOGRWHUkDdE15IbpdUtIRwxAJdo6jvlh4rnPTd9XVnmne2sl55SYp5gUQSiitheefVTgN3j6cX3vRfhXommiHJDrE5tmigVJgbFWClgZ7vcfGlRGXsdLL+sZF2BzkKqnY1jJ3wbR4ZB6R0Xuv6Al9pgCUA8y/A1LY0+2n6uLTtL1Mwlaz0grLhz9n5mUl9K63reQwglcxinBJgbkCjBjxlnvCuw7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/pkHQ1LZBSn5h+i3Mz08lW2JgXKFHNM/9XMk9RWKiY=;
 b=COU+OT89PlCATUwFMyFzLJRl9eDoaNMO7274C+BAorR5JR4LKs5WySuKf09l4sAr6JdAC9eYMoDpyQa+jFpJorhBkIdNTm29ZjmFDzlxrtQRdwSmGVE1IZc5vHwuGTMDFpMhn3CmBgW1xNIOjwzdLZ35w0zARXzb7bJmOXlDCKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY5PR12MB6273.namprd12.prod.outlook.com (2603:10b6:930:22::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 14:55:26 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 14:55:26 +0000
Message-ID: <a9bb6304-f6b3-4ae4-bbd8-fbd569ce237a@amd.com>
Date: Fri, 1 Aug 2025 10:55:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] drm/amd/display: Don't use stereo sync and audio on
 RGB signals
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 alexandre.f.demers@gmail.com, amd-gfx@lists.freedesktop.org
References: <7bae9003-933d-49bc-969d-abf45424b825@amd.com>
 <1ce09488-0384-4d88-a1eb-cdff89c0bed1@gmail.com>
 <0942ca2451ec8614835a9a56a3e0725ecb0aa6d7.camel@gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <0942ca2451ec8614835a9a56a3e0725ecb0aa6d7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0073.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::24) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|CY5PR12MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: 3958d6e8-93c1-4bf5-ef69-08ddd10b72f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UStWejdNQ3ZLZ0lsN1BKRmc2Zm91SVRBdi9oYzNMaGxHazg0WlErS3F2aTBj?=
 =?utf-8?B?S2RkMFhGSzQxNUQ1VStxbXlMc0RVT1d1NnRXZ3h3aVRwVXVtYjJ5MDZMWlZ1?=
 =?utf-8?B?UHBkMmRiTThwNVlhYnFqTzNLYWF5RnVMaU5JaVhHMDUwQVpCWWJSeGR0RUpG?=
 =?utf-8?B?MDkwOTBiK3Y4ZkJBTVQ1SmhlamZUdWNYNVZ3UWx3UnVyc2I1Q3pmTlhackV0?=
 =?utf-8?B?QkRuejRuQXhYY1Uvb3RhSi9HRUF5RmgzVXRkRGFLMkFnakovM3JZdEFJM2sr?=
 =?utf-8?B?T1lMSFZRNGg4bVJLK1VVMzROeGFEbE5vUytXeTg2dHpMRkpLekxlM09mME5Q?=
 =?utf-8?B?TnBTcm5waFZqMU4zZXgxU1U2TFVHZnp4ZHlwTmlZWW9NdVQ2S2lDU3NWL2V0?=
 =?utf-8?B?VDBNUTZ2Q1B3OXgwejdsekJ1OWcvc0hUcm01V3ZXVW05WEtZUGpuUkF3ZnB2?=
 =?utf-8?B?QXVEa2wycmMyVUVILzZJV0hXaER3MDdUNU96R2xjaldSZ1hpTjYzeGVEUUg1?=
 =?utf-8?B?WGp1elRMbEdFOTQ4NzBqQlhEcHNsT0tPWXpPbUlYS1h6YzdBSk10UUo3eUhq?=
 =?utf-8?B?NDF2dkNNb2YxWFh4T3dpMy9zeGVaaGMwejJWQ2UvTnpLTEFVdm9aalhwSmE4?=
 =?utf-8?B?TDIxMVMzcHZ1UG5IQ1BEUzdsd2FuYTU5RFpIbXhaVmEyZXBsQzBQMXR6eHUv?=
 =?utf-8?B?OEVSRDVnem9ZWlVLOFhKMXRDd3NQQk9pQnRkRDJQMHp0NHlwUVVxQWpSQWF1?=
 =?utf-8?B?NDdPRy9SdTd1dE5nWkQ3RkIvcDRYTHJSSU5CTUJCZitaRmh3azRrOHpzVU10?=
 =?utf-8?B?NmlKZWxKNWpvalE3Snl2QnNyZ2YrTnkrbFdhaml6SE95VElmVGc2OXF6MmJM?=
 =?utf-8?B?WDdobDNqTitmWXZTUUhmbWVCa1g0Z0hVQnhoZHMzakw1WFY1N1Z1ZEU2VjNP?=
 =?utf-8?B?RGs5anVWdFl1cXozVFo3STErWnRQNjNCU1BIbTE1SElOSERPS0xXcGV0OXJN?=
 =?utf-8?B?YXZEYTVBZW84YWZZc2VqNzA5ODhMdmtndXI4dW9nbXM3ZWgyb3hJdjVUaHcz?=
 =?utf-8?B?N0hDbkdFdjZaMHpaS2JFUHhrdGEvaVFheXF2V2JBaDhYWk9tOGZLRk83ZStE?=
 =?utf-8?B?dW1IaUdncysvTWlUQnVYZFRHdFgyNFJldjlhODZqUVhRczgyVW1kT3JlRnV0?=
 =?utf-8?B?RUFHSHZMQ1JVUWJLU1UwMG9kd3BaTldSNTRLNEdLN1d4QTFyRDRiUGQ4VVN2?=
 =?utf-8?B?YkRZcEMyVURISCtWOG03OGRSRDl4OC9MWTMvUkdBTWZtMWtKMlpqQTdMc0I5?=
 =?utf-8?B?WXVaaDRuRE5WQXB6Q2k0RTkrTUhpN1AwNUpUNGREMm1Wc3hIQThsZ29STzY4?=
 =?utf-8?B?UW1vREVLSmY3UHMzQ29sY0FuRDAycW5kQk9qZlhsM21QbW4zZDc2UHQ3V2VP?=
 =?utf-8?B?N21URnRVOW52Sms0NmlEV2JrMzlsRG1tT3VSYTdINWs1bzFJc2ZwNnFPZk9p?=
 =?utf-8?B?QVNEYWhaTDdoTVhBb3QwZitSTFNOc2RncmxlTEVSNUdVTVhwdU9sTkhNUmpK?=
 =?utf-8?B?cVJkcldvemRhdjBKT2xTWXc0cWZuMEVzVzltczNUc0crT3FIOElQZkoyT0dL?=
 =?utf-8?B?L1JKUUpvTU9WMGJKMnljRnQ3UU5tWXE1bmJvUDd3cDdpaEEvWklGcUl5azJS?=
 =?utf-8?B?M2k4d0s0Q1ZwTzRQZmZZbGloR21OaWNiNHpWQ1VYczAxQlIvQ1R1MnYxa2pR?=
 =?utf-8?B?UldyVUtmTjd3VS8zeFUvZFZ1UVFmc1VaUmo0U0pmYkZkbDQ3NU1UcWFBRnBT?=
 =?utf-8?B?VTl2TEMxM2RVdTQ4RzhVd1NaZjdZTlFmTmlHUjBRQS9EbGx6S0ZvRloySkFX?=
 =?utf-8?B?b2o0SGZpbldtRHdsYkw2RWJZK0NqRXR2cHZCSVNZSDl3djdRTUxmWlVUU2Zt?=
 =?utf-8?Q?QJ5+Sj0Br48=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEhqZm0rQXB0dUh5b1p1OXFSekRsWWMwMmc1aVg5SGdROFZ2ZEZPMytiOUVl?=
 =?utf-8?B?c0lUVGt5aVVJTUdMS3lGVHRxaVU1b2NLWHlvQU1yYkpWMElvTDlnTTZzZS9l?=
 =?utf-8?B?aFpDUFE1SXBSSisyUTBQbTgyUjEwVU1NUXFiR3A2RnRpaHJXSlg2WVdNNmlE?=
 =?utf-8?B?Qk42YjNJSC9mc3h1VFFVWEMvTlM1R3pOZHZ0dDVmQ09RWUUrdUdrMWppQzhV?=
 =?utf-8?B?Q1RpbklJMHExMjcrc20rN1FtMWxDWkpjc1RRNDRwaTBzaGZ0ekg0UkpRQ28v?=
 =?utf-8?B?R2xvOFM2bnlleVhUb0FZc2trQTNQaVlXbzVGcitEREhxZjNiZzNQaEJOSVpn?=
 =?utf-8?B?b3RDN3VSWUJ2OW5OL1BaYUoxWUdTTDFuR0RmZE9uekE1YXM1K2VQeW1IOUhx?=
 =?utf-8?B?eUhsWW5HdGZKYjlZMWFLSzB4dy8vdjA4UVpaYTlKZ0RZWHkybmhIM2oxK1FO?=
 =?utf-8?B?bFZsMU5RVVpZN2dQU3ZiM21MVFlRMnIzYm5Db0NVYkU2Sk9GNExMSWpwUCtr?=
 =?utf-8?B?Z3FjZXhWUkxUSGZqZVl0a056N2ljdzZpQzZQTUdtbHBxeVNCcElXNnZtTjVC?=
 =?utf-8?B?ZUUxUFJGSkN3R0dCUEhEV0VyY0VQdnRCSW5nWkdUU09BN3I5T1hxTjU2dW5a?=
 =?utf-8?B?RFlEV3ZneEQ3SklxRmZ0NmJqKzZQWVNHeisyVHpGWC9iV3RPeWNYa3VSOVpL?=
 =?utf-8?B?N3FWZXBxM2VOQitDenFIbUJlRE9kbDhPaXJsMU1FT3NyRDNzYzJZL3RLcUZG?=
 =?utf-8?B?cGRudUtDNFBBMVBKSzhXL1NWbHNySUVka1R5YWdVdnhiUndwZzZQcUN5OFZB?=
 =?utf-8?B?NU9qc3d2ZTIvb2J2TG5XU0locXNhOUs1ZEJzUkE1R2hsN08zZUVyczV1MVp4?=
 =?utf-8?B?alhFb2RLUmxUUFNPSjM5eDhhblY1MHdDNlFOMDFyUzZSWU80aDV0MjdibCsr?=
 =?utf-8?B?WXhCbzVPZG9ZU3htdVpQQmc0MFpyV2IxVmN2b3NpbEhPWVhTQ0FwVDdFclpx?=
 =?utf-8?B?ZC9IWWZPVWVNMmpsaUpNSG9ScFBndStxakxWY3pRVlluaUdjN2tLK2pYUW9k?=
 =?utf-8?B?MHF1aFhwMVpYeXpHS2MyNVR2aUl6OVFtTmJCR0M2UFJ2ZzlkQnltSkZSb2ZU?=
 =?utf-8?B?NkJKV2hGUVJlNzR6VnhVRVZyY2crMEloVERxUU5aMXRxNTBtbGNNWC9GRUoy?=
 =?utf-8?B?RFZSUUovQ2ZtdW1zemNMT2xWOFR5VjR3b1krUklJT1F3ZkUzbE1sZ25pR0tu?=
 =?utf-8?B?VlRsbVhoREZHS29nWTVYYVlEZCtuZDlyQzlLRExJd3FLSEVvUk5ybGtFNDU0?=
 =?utf-8?B?bXNUSitPQmVHVHlXcUZwaVlCYmd5eU5GWTJEeXZScEtXV2ZzNXBlMXE0WUF5?=
 =?utf-8?B?YWFNeVJjN1J4S09JYjh0eERzZUFZWXhPaDJ0UzRxWFY3ZFh1RlU3ays2b1VC?=
 =?utf-8?B?cGh4MERqcDNldGNMUWVPTWUwS2Z0L2ZvYTd4cUs5MTBpT1FlT1JYNEVqOGZE?=
 =?utf-8?B?RW1aNSt4b3IwSHVxamZBQnB5U2pGSXNwckFrd2JZS1FGcm1HeG5HRUROajkv?=
 =?utf-8?B?Sk0yNE4zWDg5ZVFwdjRtTkl0UENZQU5NZ1pqd2VVSGlyVUNraFBJZEM5SkFD?=
 =?utf-8?B?REFoRm0xR3M1Nm9qbWliZEg4RzBFaWFQTFUxLzlQQ2xOeHFwa3JsYTdEL1Jx?=
 =?utf-8?B?bjhlbXFqZldVU0d2eTFvMGc0Z0p5SnBPNDhyTko0N0NxelVGdks2SDhCRWRj?=
 =?utf-8?B?ODlyNFBFWkllbjh5ZWFVakNiQ3ByZ3d6NzVVQlZ0WlRJOG1IeHNjcTVwRTVF?=
 =?utf-8?B?MVpWRzJKa2hYR2pqOWZNMFhsTUpUVGRGdnpxN1VYMTh1cXRST0pSTTN2UGRa?=
 =?utf-8?B?bHphU2t2Tk4ySk56d3dZS1UyNUcrUlNyQXNmTml3VndoTHc3U3EzVUo3UVBT?=
 =?utf-8?B?RGNKTlBld1EvNWFvWE1aSG84SXVab05lVTRUN2ZjekZqUzZ1ZGRHa1hYUkQy?=
 =?utf-8?B?dnh0NXJaelFPY2hvb0dvUndQYjZBVzlZTThOc3djWEN5dVduNE9ONG42RGQw?=
 =?utf-8?B?dzBxYklPUzY3ZFpBdnRON2lZOTdUMEw5THduU1djSTdBZndKMFFpWXdYRGhJ?=
 =?utf-8?Q?C56busRRp5a9l4CluWwkvSfmT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3958d6e8-93c1-4bf5-ef69-08ddd10b72f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 14:55:26.2675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cegu57UYtWGuBmkfW1V+w4L6R4CHvDOH9MP7+wHC863Sas5LxhDThZArAYKTlTC59IH5g3fdJVc9BZWXrJ+GIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6273
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



On 2025-08-01 04:39, Timur Kristóf wrote:
> On Fri, 2025-08-01 at 03:19 -0400, Alexandre Demers wrote:
>>> On 2025-07-30 13:08, Timur Kristóf wrote:
>>>> On Wed, 2025-07-30 at 10:34 -0400, Harry Wentland wrote:
>>>>>
>>>>>
>>>>> On 2025-07-30 04:19, Timur Kristóf wrote:
>>>>>> On Tue, 2025-07-29 at 14:21 -0400, Harry Wentland wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2025-07-23 11:58, Timur Kristóf wrote:
>>>>>>>> Features like stereo sync and audio are not supported by
>>>>>>>> RGB
>>>>>>>> signals, so don't try to use them.
>>>>>>>>
>>>>>>>
>>>>>>> Where does it say that?
>>>>>>>
>>>>>>> Harry
>>>>>>
>>>>>> 1. Audio
>>>>>>
>>>>>> VGA ports (and the analog part of DVI-I ports) simply cannot
>>>>>> carry
>>>>>> audio. So there is no hardware to control any audio,
>>>>>> therefore
>>>>>> there is
>>>>>> nothing for this code to enable, which is why I added those
>>>>>> ifs to
>>>>>> not
>>>>>> even try to enable audio on analog video signals.
>>>>>>
>>>>>
>>>>> My bad, I was thinking RGB as opposed to YCbCr. Forgot that we
>>>>> use
>>>>> RGB signal to refer to VGA.
>>>>
>>>> Sorry for the confusion.
>>>>
>>>>>
>>>>>> As a side note, DVI-D ports (and the digital part of DVI-I
>>>>>> ports)
>>>>>> may
>>>>>> have a non-standard extension to carry digital audio signals,
>>>>>> but
>>>>>> that
>>>>>> is not revelant to supporting analog displays.
>>>>>>
>>>>>> 2. Stereo sync
>>>>>>
>>>>>> With regards to stereo sync, I didn't find any reference to
>>>>>> this in
>>>>>> the
>>>>>> legacy display code, so I assumed either it is unsupported or
>>>>>> the
>>>>>> VBIOS
>>>>>> already sets it up correctly. At least, considering that the
>>>>>> legacy
>>>>>> code didn't bother setting it up, we don't lose any
>>>>>> functionality
>>>>>> if we
>>>>>> leave it out of DC as well.
>>>>>>
>>>>>> That being said, upon some further digging in the DCE
>>>>>> register
>>>>>> files, I
>>>>>> found a register called DAC_STEREOSYNC_SELECT so maybe I
>>>>>> could
>>>>>> investigate using that. Maybe it would be better to work with
>>>>>> the
>>>>>> registers directly instead of the VBIOS? Would it be okay to
>>>>>> investigate that further in a future patch series once this
>>>>>> one is
>>>>>> merged?
>>>>>>
>>>>>
>>>>> I don't think DC supports stereo sync currently. I'm not sure
>>>>> there
>>>>> is
>>>>> much value in pursuing that.
>>>>
>>>> If stereo sync is not supported, what does setup_stereo_sync()
>>>> do?
>>>>
>>>
>>> My bad. Not sure then. But no objection if you want to explore it.
>>>
>>> Harry
>>>>>>
>>>>>>>> diff --git
>>>>>>>> a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>>>> b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>>>> index a10d6b988aab..825a08fcb125 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/display/include/signal_types.h
>>>>>>>> @@ -118,6 +118,11 @@ static inline bool
>>>>>>>> dc_is_dvi_signal(enum
>>>>>>>> signal_type signal)
>>>>>>>>  	}
>>>>>>>>  }
>>>>>>>>  
>>>>>>>> +static inline bool dc_is_rgb_signal(enum signal_type
>>>>>>>> signal)
>>>>>
>>>>> To avoid confusion with people that haven't worked on analog
>>>>> signals in years (or ever) it might be better to name this
>>>>> dc_is_analog_signal.
>>>>>
>>>>> Harry
>>>>
>>>> Sounds good, I'll rename it in the next version of the series.
>>>> To further ease the confusion, what do you think about renaming
>>>> SIGNAL_TYPE_RGB to SIGNAL_TYPE_ANALOG?
>> I think Harry hasn't answered your proposition. I must say that the 
>> first time I looked for VGA in the legacy code, I stumbled upon the
>> RGB 
>> usage. But then, it began to make sense (I'm not completely sure if 
>> signals and connector types are used properly everywhere), because we
>> are mostly translating DRM signal types to supported connector 
>> types.That being said, while both dc_is_rgb_signal() and 
>> dc_is_analog_signal() could be used here, we are specifically
>> querying 
>> the signal type and this signal type is RGB. Because of this, I would
>> be 
>> in favor of keeping dc_is_rgb_signal() unless there is another analog
>> type that could be queried and not rename SIGNAL_TYPE_RGB to 
>> SIGNAL_TYPE_ANALOG in any case. Cheers, Alexandre
> 
> Hi Alexandre,
> 
> I think the confusion comes from "RGB" being a very overloaded term in
> this space, so I am in favour of clarifying the name. I am open to
> suggestion as to what is the best clarification. If you want to keep
> the "RGB" part then I propose:
> 
> SIGNAL_TYPE_RGB -> SIGNAL_TYPE_ANALOG_RGB
> 
> Which should make it very clear what it is.
> 
> Otherwise, I would like to apply Harry's suggestion to name the new
> helper function dc_is_analog_singal. Considering we don't support other
> types of analog signals, I don't think there is any confusion with
> that.
> 
> Let me know what you think.

After going through the entire series I'm not so sure
it only makes sense to rename this function to _analog_.

Either rename all of SIGNAL_TYPE_RGB (like you suggest)
or leave it all as RGB. The former creates a whole bunch
of churn and it might make sense to just leave things as
RGB. My confusion came from the fact that I've spent a
lot of time in the world of color spaces and over the
years have forgotten our terms for analog connectors.

So, no strong opinion from me. Maybe slightly in favor
of avoiding churn.

Harry

> 
> Timur
> 
> 
> 
>>>> Thanks,
>>>> Timur
>>>>
>>>>
>>>>>
>>>>>>>> +{
>>>>>>>> +	return (signal == SIGNAL_TYPE_RGB);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static inline bool dc_is_tmds_signal(enum signal_type
>>>>>>>> signal)
>>>>>>>>  {
>>>>>>>>  	switch (signal) {
>>

