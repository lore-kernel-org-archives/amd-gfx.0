Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEFA1C36005
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 13:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D025310E331;
	Sat, 22 Mar 2025 13:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tvuhHaFb";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 476E110E0F2
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 13:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwP8EHxiL7BmK0dB+vptQ93zK82iL7tfP7zJwse1JVZ/SjNV8z/wDl6i71JVMEwB2YGGK8uUpmirjH+9aVNvCqM9gwJr2RQGOH0mbJNMDHtItpJTGuPlbR1fMXBATVY7yaSaIQ6aMo8DaXcIgk+pEoOy+AAEzyfFBzSddNRMixQionf0A9hrHfQiW2Ymqhpn67mqVxCjTQW6h52v94v68aU/Nat5muGJX8Tv7c4IicWo+u08meykkPFUGpozXF3lGlK9yYOc7RMrc1efWEWH4UKn+P9s8314ZZcA26+NCAEAu2HR2X/ggkd05U1BKXwF9rUi1YumsTeuziNA7df2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLZ1As48ywtUWb7Q+iaKowO/H0yU2c5A8K3c3/z2VLs=;
 b=yS/T0+hJg6VNKn0YKo2RCmr3JuP7IbisJLaVlvjKXiFtn/oTgzsJ7ialYY6JnFvMWmKLgrYT02lbWMvorrkOV4P4vkbDY32BC5JRwBnfqeJ8YN+k+KlxM6bsXslNv3gZ2ezorH5huIiAQjvH2kE7+ofmRT9n+BkQpm5PVi9wG01jX4nmFJsisGAiYnP1o2dGzekrYQTJ7rpbennrYAeHDpLp2EuBj3rGhcgY8Zk5hxvlNdMbtOUjPkUQjdugCMDxwa2UPGo9cUvWbrz7ONo1+PcEAomhRzlGONsuExjd9Ru9nDMfa/6Tuh3hrRgKc5iWFFHipe0zHtnxISrI6ofs4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLZ1As48ywtUWb7Q+iaKowO/H0yU2c5A8K3c3/z2VLs=;
 b=tvuhHaFbN147tWL/5u+KflixeiVDghuPgH7UQ7jI2F2ishK4lLk6AfJ0FVhxy8Vhl0yE4nN4820RLX0om4u8Dkec/LsvyVNoONjvYO9fmC+vGCAAVZy9GTRzuLzECoDKO9Uw4F0VdRUh5Ga6QZK2fJ77kA3ruPT0jf1NCCyxjBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) by
 SJ5PPF000ACABD1.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::984)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sat, 22 Mar
 2025 13:28:09 +0000
Received: from DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7]) by DS0PR12MB8413.namprd12.prod.outlook.com
 ([fe80::58af:a888:7e2e:bba7%7]) with mapi id 15.20.8534.036; Sat, 22 Mar 2025
 13:28:09 +0000
Message-ID: <bd6de94f-61c6-46c1-bb0c-1e5e20276f85@amd.com>
Date: Sat, 22 Mar 2025 08:28:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Increase KIQ invalidate_tlbs timeout
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20250321182658.22436-1-jay.cornwall@amd.com>
 <BL1PR12MB58984DC8346F9D80820501B985DB2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Language: en-US
From: Jay Cornwall <jay.cornwall@amd.com>
In-Reply-To: <BL1PR12MB58984DC8346F9D80820501B985DB2@BL1PR12MB5898.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:806:a7::14) To DS0PR12MB8413.namprd12.prod.outlook.com
 (2603:10b6:8:f9::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8413:EE_|SJ5PPF000ACABD1:EE_
X-MS-Office365-Filtering-Correlation-Id: 236ac102-8cfa-47f6-41a9-08dd694562d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDBCS2lLSkphcXZWcmZ4UnpLV01lQTBTeXpabkwxQ2FkTFhHM0RIdWxXMndz?=
 =?utf-8?B?NTdFV3RRdzNsbmFzZ0ZsVUp0QlBlNDRMOXRuUEJBb1NabC9menFoM3dUdWp4?=
 =?utf-8?B?TG01Vy9VR3loZk1NM2VyQlFGcGNEQmcxSnRRR3h3cTlKVVhJWDBUclZpRDdm?=
 =?utf-8?B?cm5YeThFcnl2MW1WbTlNMWJGcjcxQWwvZHk3V1dHN0pqWGhmeC8wc25hcDVK?=
 =?utf-8?B?OTh1RGQ5RmFxcC93bVZJK244WW5RbmcrV3pPSmVhbE5GSFppVGoxOXJWL2dP?=
 =?utf-8?B?bStlbmpJb0RuQ29nVTJKK3BkM3ZQVXAxNHNxNkIyNmxpemdKcVVnN1RXWGNI?=
 =?utf-8?B?ZEM4TFNQRGNtVVBaQmNJUndFOWVwejVkSmFKK0VoK1BHZ0NBRUN6ZG5FWm9z?=
 =?utf-8?B?OGIxZUV2OUZtSUhwMWpzaVZaZ2hySittMjhPUUNMcG5YV1dnVjFyR215UkQw?=
 =?utf-8?B?Vkl2ellrajNKVjhjNDhqZXp4VzZONGY5S2R2TXpJT25FbU05MEpPZkhXN0Rh?=
 =?utf-8?B?aDdOUWtuR1BaY21LVzdiNlV6S21QWlh1VUY1azFYM0JNVXRJWXNuVlRtUElS?=
 =?utf-8?B?anE2YUxYSFI4SDNtbWYvbGk4dEpHaG55MzJQWjgxSk5yZituOTZ3ZjgvRUZR?=
 =?utf-8?B?cFU0RFVIaU52eElob1FxcjRtZVRMV2JZc1kwMkdPRWZtOWtNWVFvWTBSWENm?=
 =?utf-8?B?NDJ1MkZnZGRUOW9GV2JhRkFORkNYZ253VjRsNDBpTEZWQ04vVjRhcUgxc0I5?=
 =?utf-8?B?TDB0NUpNaDFmKzREQlM1MXZpOEJ5eFdqaUJsdHlrc3pNeW03dTZWS0xFTUxT?=
 =?utf-8?B?dFM2R2hEb2tHRWpaQllVK0Q0L1ljbDNUdE90L2dNOThGTVR0K2RBMGZxU2ts?=
 =?utf-8?B?OGpRUUhoeTdMRVdVNWtyUW05M1N6dTlhNlZQTjF1c1N1eWE2T3o5WXB2SE95?=
 =?utf-8?B?SE11aFBZdTBpUnVDRW5HWVJtdUtQci85R3diR0djQk1rVjd0YU5mOXYveitw?=
 =?utf-8?B?cC94blVudXBPRlFaRXFoSVp2ZW1vUjRWNENMNlVoVVdnR0lzbFhScTJnMVB0?=
 =?utf-8?B?K2YyQkp5MmVJNUFlaDdOQ3BlS0VVY0RVNnM1bVczZUtIMW1OQVZQampGVU9p?=
 =?utf-8?B?Z0g3VUZSV3ZEQ3RsamFNN2JKZVRvMW44ZUN1ZEQzdS8waTRDVWlzQ2IwajZU?=
 =?utf-8?B?V0lldTVTditjc3AyR1FQUytGdldoa25zbnByNmxCdlFSTmlKbzNpcXRHYmxi?=
 =?utf-8?B?QkdHN1RidUVxREFqWmxZZmNmbCtVdGlxVmRGZUIxbHZsS3l2U0hqb0Vydys0?=
 =?utf-8?B?YUNSSnNoRGo5djJaT1FBaDd4b0xwait0bFhmUVNUbmdVU1RvMTI5dUVUWGY2?=
 =?utf-8?B?R0ZaNUUxdGNqR3g0bjRZc2EzbThCL0lzcjR0V2cyOTFhVUdKTTFET0VRazhD?=
 =?utf-8?B?c1dPTm1aQ2NFdDR4ODRBZTdXOEc0RUJVWGNid2lEUTM5NjM5L3huZUQzSWpX?=
 =?utf-8?B?RzNBNUtCa3BLTkJ4TjZMWEovRWlETzg0ejdLODNyN3BKNmlGWXQyaVVDd2l2?=
 =?utf-8?B?ZHBDZXNJWTVkZlY1MzFEeEd5YXlvUm9SN1VpVGR4NG04VjlUMFBDUnJSM1cr?=
 =?utf-8?B?ZjZvTms0ZWhVQVZDYWFPN2QxMVlxd1VEek5Yekt6UFpGbytmYm5saTNhbWdm?=
 =?utf-8?B?NWkycElTVE5CdlFwdnB0U0ZsQWMvcithN2hxOGtWM3dsUWZtTFFYWXhBOVV0?=
 =?utf-8?B?SHVMMy9xSEEvbXlYS0VnU3VNK1I2QlpYTHIzVkNlc3dYMGVTeGdQL2VHOXgz?=
 =?utf-8?B?WTd5czBRMFBGN09JMW9BL3VPY0dnREE2VXVPRnNQZnJTbklVdFlVOS9LSmtp?=
 =?utf-8?Q?JGWe4ucHvVTrp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHM0Q0FZU0dsNEordytzcktsaU91Y0xpYi9BOXBMNkxDSnBFRUhLczlPcEtU?=
 =?utf-8?B?cDl6UExReXA1MnFDQnJ2RENPaEJOM1M0dGRKTHFJNU9vczZPbnpwZFlGVzJP?=
 =?utf-8?B?anN5NGZiNGNVS2IwUXZQZ1VvbXVNaERBWkRmZzFxL1lUeVFTWEhwV2lVb3dk?=
 =?utf-8?B?RXFWK1J6aWlaOTVNbllOK1IwY2F4cnlaRmJHaXBETjBKZGFvYktlTnl2WXdl?=
 =?utf-8?B?emF5MjJFRDI0V2RCc1FickpCaUFFbGxwbkYzS0psdWtDRE5sNzBEQnkxS2oy?=
 =?utf-8?B?Sys2SDJudmlFNUNZZHFmSUlrVFV5WnlMME9PczZZSGxWYlk2ODBKKzg1cG5p?=
 =?utf-8?B?VjBaUlNnM1E5SnA4a1YvN3c2RTdwZ3hrNE1kUGRMenNGa0hIa1BDWCtyWWdE?=
 =?utf-8?B?UU9OSUxjMmp2bnRFejN3WUVCdU5Fb00xRUdmdHJJdUVUQWpxOCtPdkl3TmtT?=
 =?utf-8?B?UnJadCtscDBwMTdyM3VwRklaWEtNay9sZUlnRU9GbG50dzZ2Y3NWanZNWHdj?=
 =?utf-8?B?OGM3ZXZ5ZXBCKzdwRTFJN2Y5bUtqY3BxQkxIL2ptckdNY1MrSnNVVFVSN2R0?=
 =?utf-8?B?QmNybkJ0UTRCZVpXOE5wVkxWVVNIa0lpWFhWNlZxMjFUUStOb2NlRTdJZmJC?=
 =?utf-8?B?UHZyMWk3OXphakxIaDBYVjBHRkR0cS9OMGRERnNmMlo1TGRtK0E4aHJBWldh?=
 =?utf-8?B?dzk1SGlCMm9JOXZCdmVMUHFJZkxpOWRrR1UzbEZMMHRYeHdCZnN6am9PTHRU?=
 =?utf-8?B?NSsvYzEvSTRkdjZzelhCcXRhQ2VBY2I4Myt4ZDYwbm9TYkVUSG01OEpKUzJN?=
 =?utf-8?B?ZXJ4aFI3VTI1RG1CSHNBNmRFc3J2a3lyU0RXK3lGcFBTV1FIRHdFVUpoQ3ZI?=
 =?utf-8?B?TElkOXJHSCtjUWQrQlNqelF4ZFhpUjRuZDV3VmlQYWJIR3lYemp0VE52QXF5?=
 =?utf-8?B?RU5oakxucldaTkdubnY2NDZuSWt0c3hRdEtTeGxlbXRrZGt4YXhMRS9WN0x4?=
 =?utf-8?B?ejFVVWRlTDJaUDRYWkl3SDkrN1drdnBvZFZTK0NMK1JYcE9ZVnYzbmlWVlE0?=
 =?utf-8?B?ZnEvcTBNQXo2N3g3T3NjQzJ3OHZJVCtIeCtPRWpzbWtiQ1oxZkJobjYveTZL?=
 =?utf-8?B?N3dQRk15cVVJc1gzWGdaem5CaUZFVWJNY1RWWUhUTkw4QTlIRXRYVkp1OE9q?=
 =?utf-8?B?VnRpQk5wZTNCYmFYQ1VSUXpvU09jRWM0QjNkMGZQSjI0R09WZHd0YkpoTDVt?=
 =?utf-8?B?TW5GWG0wcGhOaWZycjJaYWxXMy9Nb1hmVzIwVk9hckhuNWpTaWtocXIrd1Uz?=
 =?utf-8?B?cUlvS1VKTVpUbVNQQlhjUlpmR25zTlhmQ2d1ME1DaHJ1RmlIZThGOTZhM29Z?=
 =?utf-8?B?RUo1VStNYUZIQ0hDem5iV3dTd3hwM3FaMGdrekVRMXVVMW1TRmRjMDdULzlS?=
 =?utf-8?B?a1gwd0FNbUhLU2JvaXVXeEluaXZUV3pEa1MrMTQ3RnZDeVhVNjV4UExVSzFL?=
 =?utf-8?B?SmQ3T0M1MXJVeitBZXU3aTg1akpORUptVTltUWRWSnRTY29tc0pGcHlUeFo4?=
 =?utf-8?B?VFVwQ1RZRzAvS2RWYWh5L0tiZjZVRE1hdUpKWlpHaG95ZVcrNmQ4YzNjUkRa?=
 =?utf-8?B?VGZ0VFZ3Ti9rS1QzekhGS1Y2dmc4clZGTXhZVE1NNDkycHJYMEt2bVZzRWc3?=
 =?utf-8?B?QktQenVhaWpybHBYQSswS3BxZUllTmlhYzVMeFFPYmlJREdoc3BiV05RS09Z?=
 =?utf-8?B?NjJOQm9QWDFQamswdXdNM01scUV3V2VqN2pHSE11bHFPS2FvdDhiQ0tHUEpm?=
 =?utf-8?B?SlZhVUpYWTBuTVJDRWtiZWhJVXZjcjRpV0FIRVhJay83bVlFdkhONmh6dFkx?=
 =?utf-8?B?cWMxRFprK2Q3SjVkcG5uLzZ2Ylpkd2xOUmYzbVpscC9NVHRLU3NnMjhGUlFW?=
 =?utf-8?B?ZkFQS0VvaERkWG56aHIrbzEvUVFleXA3SStYUVV5UXBsdGdFMHJmcktnSU9t?=
 =?utf-8?B?ZGdhOXYrYWc5RDByYXpDOVpFZ3ZWQ1ZvcU5WQ05CbVBTNEFldUlqUGpqeXNh?=
 =?utf-8?B?MEQzTnBxSlBJd3RaRHBnRWtaSG5BdDdjV1htVG9zTHJYc0hpSXY5STdGaVVI?=
 =?utf-8?Q?0uaKtpVzbA0f+/qrtoDoi/3pl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236ac102-8cfa-47f6-41a9-08dd694562d6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 13:28:09.1640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ur9tvhaBgDABTx+vfHtsB5ItdSDImEagnIZ1seflrO77bbKrRbOpseUagPU3lEN07yx+jtzkz730ZNyy6p11A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF000ACABD1
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

On 3/21/2025 14:36, Russell, Kent wrote:

> Do we want to actually do a fence_wait_polling before the loop begins like in all of the other functions? I know 5ms isn't a big deal, but the other ones we have are all after a single fence_wait_polling first.

Oh I see what you're saying now. This introduces an unconditional 5ms 
delay before the first poll. D'oh, I'll send a v2. Thanks for the catch.
