Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC46DC04FFE
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 07:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D6A010E3BD;
	Tue, 14 May 2024 07:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGh9sZkh";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEEF10E3B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 07:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf3mIBaip2aLTkw5lYeJCMNVPIoLtXg4q3svltHFnF1rdk+mp+WoJ9NQpqzLLZnLG322fEMMZs0GEJJXQhIcbygpeL1N6xJcmVPIy2lPmBC9Lq7ifotY7nlgy3cV4XhbluTgmgsuQFnmiEqO1VJnEYrsfL5sruDhxeUflwEL+KGmOsmzSAE9ma7ffbhv0V+Hm1Z5XryBps93sW4RJqZg9Oid0ooKaLVuTjuqqAQVoEcz2u4oAXlYYkOQA24gKkVwRbXrviwFlrSdh83zrsxeO9TparSQwUlx3zEPM9+WlBdtNl3JJL2ubuVOilLPqNve4KCfvPtD5J2hghWR5g044g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQHXLJXjxUVoHK+9ChRzt4KPQxqLD7HO7wdof9osPro=;
 b=mVpSUo0L5UAdTHxjFDfFScKriGa2JH+vHJqSMrQGHMG2Sw3x6DLpZ+a1DrdplEM7XAsHwta28jv+DZYUcx0tbcUvtFsVEls7jPb0pAIXGxQuff1uBTTBKYwx3SrdioKkZ1/KC5tMEo43EGrfkSFpryxQryX4cy/GXLp04minI44XprUIuFQhvh5Ua8+8IJ4nCyB5UrLatgxXZEq7psM7P3906dstUEGgKeCSICLc53c207xO2+G0QktVEljoqd7fDlZl8LJsmmz74u8UGAGjFwrqcYFp6D1f6qYkeQ+lE4+hZXk74O9LoomE6mHJLovZ2CvUd8wxI5z3m0+4iJVWtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQHXLJXjxUVoHK+9ChRzt4KPQxqLD7HO7wdof9osPro=;
 b=mGh9sZkhJU47cdB+kQDtpcp/+G4lLL8I/aA3J41uQblnlG5JbRwZzSEKC9dJ0ZeTH0OKA3bCCm/TZ29OA7eTJEJZbTSjaRdTHIAYi1Bqpev/G3MQZLtPcC/4QdW6Q7ym+lBBun+EGQc3q5d/2L6iQFKAHVy6tvYsQxryhz9hiIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55; Tue, 14 May 2024 07:14:58 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 07:14:58 +0000
Message-ID: <c83be3f7-a4e0-45d0-9803-db2b07aec0ca@amd.com>
Date: Tue, 14 May 2024 12:44:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>
References: <20240514060451.3649916-1-jesse.zhang@amd.com>
 <649af63e-99e1-4653-b5d0-72938171a94c@amd.com>
 <PH7PR12MB599748FF0209C8A3BD61F93582E32@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB599748FF0209C8A3BD61F93582E32@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0240.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::17) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 530847bb-bab2-4b20-b5c4-08dc73e5905e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXEyekFBV3VlSVRnaXdIZ1pXUUwrcnl4ck1rOWRXeFZMT2hIaTkwajFlQ3c0?=
 =?utf-8?B?VlVraHE2S1FUUkVtNUxwamthcitOaXFOTm9Ba2ZUS3M0Z2l0c1JmZGRNVGRv?=
 =?utf-8?B?N0MveDNjSU1XVWJaaUdWRndhL0FOYU9KQkprLzdtNjdrcXNhd1lVNDlPRUFV?=
 =?utf-8?B?K0RFbTg0U3hCa0t2Q3lWYlRWOTIrcjZibEtleE15Nm9xTG96V08wcXpwYXRQ?=
 =?utf-8?B?YUZiS2orbnNKM1ZJUWV3R2NDQnFJRDhxMjlaR3Z0ZmpiUDUvWGZ2NlR2MjR3?=
 =?utf-8?B?SmpOcEo3VU5sbGZRZFlpbmFML1pXVDNlN2pLaFFmWm9iUjZhY0xoc1I4ZHdS?=
 =?utf-8?B?c3F6RVQrdXJuMmo5Y2RBazVUbXpYUWpWMXVpWWRGL25iZ1FNYytqR3Ryb29D?=
 =?utf-8?B?OVBqbnVPNFN1L3VKcjdzajBham1ZS1gxcXV1QkpraDBZK0NqOGJMT1ZDc1ox?=
 =?utf-8?B?cXg2M3JWQUdnUFdWQkkzbzBJUHNEa1RNUmlST1hYdHZjUmJNUjQ3b2o2bXFY?=
 =?utf-8?B?NWpKN2dWdGYvRWJjZG5vV09BNDM3emtpVk5BdDlGR0dJbDlCZWNQWW9pQkx6?=
 =?utf-8?B?MllEdlY1eFRkNTVsMDRSVTh3N0xGY3MzeG5hakJWV1pwY3hhejQvZkd4MWMx?=
 =?utf-8?B?RlpnZHdZbzZzbUpVOVYyME1TVFFQNjF0RVJoSnV1S0pEYTA4UDVQWVJCWjhK?=
 =?utf-8?B?UnpkZG5DRXk2cWJKdllaRkF6NkgwRzBoRHgwOVlPMnVRTTFwR05QV1ZiWDc5?=
 =?utf-8?B?a2dqWVhVUzBPcUowQnVrT3c0ZWM0MW5XWGRxckE1NFErc0wyMlZ2MUZOQTRC?=
 =?utf-8?B?QU1BYWV1N0YreUhsUjArMDBnNE1qTksrYnNMaWtTVGFaZGhKTjdUOEpvdndQ?=
 =?utf-8?B?K1RwbTcwTUZ6dVlza3lacCtRZ0wxcW1QM3UvRmVPMi9xaXJFM1VQcnJ3cVNF?=
 =?utf-8?B?d1Fjcis2cDlCc3JOVEhsRFVGSFRHLzF1WWZWZFZDYUZVclVOYXBiSlF4ZnJu?=
 =?utf-8?B?SDRRTHhtVVpDMnZCSjFtR1NXK2JDYWw2aUlRUDJQUFAweU8rWlpjL0I4WDJz?=
 =?utf-8?B?RFd4WE9ITGhWYlV2QTdCN29OWlR4SkNXZzlwZEE2STVmVGhscEl5U0JKMnJa?=
 =?utf-8?B?SFVSdUNza0VScFR3Ulo2THNkbWpNWFdDbXNEaThwanRYY1NsZkxZNjF3bVU0?=
 =?utf-8?B?WWdrVWlNeEJPQVluYjFaTHh1eFBEMUdlSlVyeXlyQWVpbDQwQjdQd0RvZFZh?=
 =?utf-8?B?MDNOY0dGNEdLdCt5UnZRUVBRQzlQQS9uRnVIVjJackRFN050QVljY0pmM05H?=
 =?utf-8?B?MU1Gd2tDa2RYREJBYjJBSG5QSnNwaTM1Y3NQOFd5V2szUWZjMUQ4US90WlB4?=
 =?utf-8?B?V2N5SkFqTWJyeUp5QTd4eFN6Q05XcTRucTV1dDZEeE15WURQVUtDeHRKbXp0?=
 =?utf-8?B?NVoxcGlpejBVdE5MUzM5ZGNwSGZXWS9VaW1VQXZMVEFUdUVZSFN3aWlQRWhz?=
 =?utf-8?B?azh5SHc1eEJNdHZwdHBEYnRJdFZCU3lDKzhJQmtrMVBtN3FzTTB1U3lnTFBk?=
 =?utf-8?B?VTBOL2JrQ3JsZUtPZkJUdmFtWTUzaFhPVzRVMFQyR2tzb29tSEY5c2ZOM2M0?=
 =?utf-8?B?SDBtZEYzQUxFcXNJVVNZTjh6M2x5SUpBR3FObWt0RFdVYXlpSVRpL0hXdTRx?=
 =?utf-8?B?UlEySkN4alBQV0E5bEE5c1g3YnFrVzhUTDV3MTg5MFlTMlhUM2VrOExRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdKdi8rRzMySC9acHYzdUZMeGRyQXhydDlSZlhhclZKVjlTa1hseXFIUlBV?=
 =?utf-8?B?U29BMlFpVEo0bTBXT2o0YUhka1dva3h2aWl5OGM2OW4vMzY0VlR0UkFiK25C?=
 =?utf-8?B?Q1d2SDJDdXRYVjhGMFJXK2tjWGtKYlBkaitxdXZYTWl3cTFKSW1uQUhkVGJu?=
 =?utf-8?B?Q1NSWEZyOG00TnhaVHkyNXA1RDJ2T1A0dUx3R1BKOThEL1dtK1JZVHdxN05W?=
 =?utf-8?B?N2R4Zzl1bzF2VStYa1RscUg1cERGTkRyQi9ZeDNiMW10dHZ0Q0xCL3FwR2dk?=
 =?utf-8?B?b29ETGVReVFVd3hyYy9wMlFrV1h5YmxXUDk5UWNxOFJPWFZYTk1OS0VYM2Rz?=
 =?utf-8?B?VWtMUzZpWnBzY3hVbi9wRFpZcTV0MHoxRGlCSW9zMXp1aXFxR2xDYS9GdCtF?=
 =?utf-8?B?V2hqQVNWaFk2cktpQksweU5JRmdIRFRVM0wrR1V6QlhXT0NSU3A3aW93eDlR?=
 =?utf-8?B?bCtya0VtVzFKTXl4cHZhN2JyOTcxZS9EcFpVbFRGeGQ2NjBqRDZmMURqYjI3?=
 =?utf-8?B?cEFHSTJSSnVUSWk0TFNJY1JIL2ZaTjJ4Sk5kMXlUTmlNN3FMUk80ckZrV2Yr?=
 =?utf-8?B?ZXZiM3E4ZUFNMHlVZ1Q5Y3FFTWsxamFGdmJtU09FbjNxSUw4dDVPTnFPQ2Fw?=
 =?utf-8?B?QjUwanl1NmN6VmdaOFJEd0tUM1kxalh4WElyWEZnTkdaZjZWbVNjUDZRcGpX?=
 =?utf-8?B?QnFkMzB5eklPNCtWQnNhYjgzZnY4UUREVEtMd3I4all6TTRuVzAxU1FBajZa?=
 =?utf-8?B?VkMyWXRtc3ZsQWN3VWxZSEo3QWd4VTcwUTlLa0xhdEk2NFlaOG9uRG9tZkQr?=
 =?utf-8?B?VmdveEsyUzVIU2dvMko1T3JIZkdtRkhVNnZSbEMwellTblR0cDRWbHMyRWlQ?=
 =?utf-8?B?QllEMlpxQnh6bmhiWm1GV0IzM1M5Nk9uaW90M0h5MDQrdm9Sam9Wdk8zYmE3?=
 =?utf-8?B?aUJLZzh4UHo4T3pEaDh5SFZDcS9ocnh3V2l2RjdxeVI2cVVsUWpBcmp5czAw?=
 =?utf-8?B?T1hJYytpNmFQMlRHTDFXRDBCdCt3OWpmVC82UDJMckJVdUZIWlZGZnVwNEti?=
 =?utf-8?B?Q1F1U1lrSTdTYmdpKzVSM3RVZHJ2MGw3VkUrM3AvbGdlK2tNTVFTbXJrbkNo?=
 =?utf-8?B?Y081UDl1SUpRa2k0QUloWlBGMnZtZmhtVkFiTGhEWXNiT0tCTTV2VVBpRnpq?=
 =?utf-8?B?WjlnNWFWaTFsSXNtMGdYRnZzQm9BM1B5YU9GK09YWjdsYnhqT0RMWU5BUlZh?=
 =?utf-8?B?V0M1UmxaOFJRN2Y2VUZyNE1lLzVQMXZ6YjluT2xUZ0pNYm0rQStaTU9rcDNz?=
 =?utf-8?B?VllOVnRFYzNhUTc2ejlKcDZFVTBZSnNkOWlDaUp3QmlCNThrUFkxZGc4NGdO?=
 =?utf-8?B?bm1Sd3UyR2NqMnFzRngyUFRqQ2IyTGwvMHg1NThUR3ZxYkdOeTE1K3ljTzBZ?=
 =?utf-8?B?TzZFOFFXUzBZQWVUREVnVW82YjUrSDgvZE9yTExwdlo3OHpSK1ZBWWlNUDFh?=
 =?utf-8?B?NUx5NlB2bFFuNUZ2UG1BOXpYdXlHM3JWdGd1a2w5RXQ0dnFMbzVyazhUMTdV?=
 =?utf-8?B?elJEaUwwVXo3Zks3bk9oVFg0cExwbjR4aUNQYlJGc1JEWXo3aWtXYnNZdnV3?=
 =?utf-8?B?ZUFJTzhXdC9tUENPK1c0VGRsNU1sR2x3UFlITkk2RXpIclE5NlhvZ04yWFlD?=
 =?utf-8?B?QjJJQzl4K09PQ0VKQTRWVHI5cnZUZDJMTEx3ZUZ0WC9tNjhZQjR6MStZRFlY?=
 =?utf-8?B?MUdtQ3pkNzJvSlBnZk42am03bUU4ZC9aUWFmejJUc1RTV3BhRjVVZjFicmFQ?=
 =?utf-8?B?bVIxbHF4YlhlanFQV2k3QWNhM1hmTmNKYVltcnpRUS9laThxZ3dxY1BGWDRy?=
 =?utf-8?B?OGRGNjh2REVBOGxnVVdLMjFPN2UwS24vNFEyZFNqUUIraEsrcyt2UXRheUhT?=
 =?utf-8?B?c0Z3akdGMUdXdW5KR3I2UU9ZNW9QVEhoVWlEbWVDRWppYkNrcmdyRzNCVDF4?=
 =?utf-8?B?ZmtxSzRkeGpCWWU4a2xFcmRsSHFrQmFoRG9waTNjK0FFQnRvQmZuQ1lYZWNV?=
 =?utf-8?B?NFMrMUxlbklrNHJWVWg0Q0FXY2ZBWEk1U3NxeUxwNEk5TzZwTWdDUnBlK2ly?=
 =?utf-8?Q?uNu3MMCIG+dmpiPikN9Wt4fo9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530847bb-bab2-4b20-b5c4-08dc73e5905e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 07:14:58.7760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5E9xL9L7B7ozmrxMAJHc4+OyXkve0jQMMDtny6kvyeEEJsTR9plD2XeO2FIyc5E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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



On 5/14/2024 12:37 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Tuesday, May 14, 2024 2:07 PM
> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: Re: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
> 
> 
> 
> On 5/14/2024 11:34 AM, Jesse Zhang wrote:
>> To avoid warning problems, drop index and use PPSMC_MSG_GfxDriverReset
>> instead of index for aldebaran.
>>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> index a22eb6bbb05e..d671314c46c8 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
>> @@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct
>> smu_context *smu)
>>
>>  static int aldebaran_mode2_reset(struct smu_context *smu)  {
>> -     int ret = 0, index;
>> +     int ret = 0;
>>       struct amdgpu_device *adev = smu->adev;
>>       int timeout = 10;
>>
>> -     index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
>> -                                             SMU_MSG_GfxDeviceDriverReset);
>> -     if (index < 0 )
>> -             return -EINVAL;
>>       mutex_lock(&smu->message_lock);
>>       if (smu->smc_fw_version >= 0x00441400) {
>> -             ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
>> +             ret = smu_cmn_send_smc_msg_with_param(smu,
>> +SMU_MSG_GfxDeviceDriverReset,
> 
> PPSMC_MSG_GfxDriverReset is different from SMU_MSG_GfxDeviceDriverReset.
> Use PPSMC_MSG_GfxDriverReset here (for both patches).
> 
> Thanks,
> Lijo
> 
> [Kevin]:
> 
> There is no interface here to directly use PPSMC_MSG_XXX to send messages to smu/pmfw in the swSMU driver,
> and it is not recommended to do so to maintain code consistency.
> 

Thanks, didn't notice earlier that smu_cmn_send_msg_without_waiting got
changed as well with this patch. This API is a direct interface.

Please note not to change anything else other than what is specifically
requested in review comment. The original comment was only to replace
index with PPSMC_MSG_GfxDriverReset. Please stick to that, otherwise it
will break the entire sequence.

Thanks,
Lijo

> Best Regards,
> Kevin
> 
>> +                                                             SMU_RESET_MODE_2, NULL);
>> +             if (ret) {
>> +                     dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
>> +                     goto out;
>> +             }
>>               /* This is similar to FLR, wait till max FLR timeout */
>>               msleep(100);
>>               dev_dbg(smu->adev->dev, "restore config space...\n");
