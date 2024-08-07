Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98BBC52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 08:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BB110E453;
	Wed,  7 Aug 2024 08:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fklzmEcf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FA5E10E453
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 08:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Edw9aduP2ax3X9XLToQbFy1JcWGolje2uZtOBy8bIk+rCL5EBmGthdn6Wbwkbkpmr9USENnFIhL8Iaw7ubBvxcu3JgGF2Z5A58DUIGWnxV0PkBXBvbbOxNrDQiEg6Tw/JnrZ2G8ujVKWQt7GXh7L4fEmAJsctVb8+LaPp0ZUsoNeb0KKrWEOQIObkoocSlSHuHJY4EOMFEO9jrOH2wmKZYI2HCJyXa1HtcOiVb4Zg1eiuM2PRi9ZZjnYyDsVLLv+PE2JoaN/aosOGeXhc4Pzjm2ZLOcxZk+TnRmyXSHxyYjDczimairos9i4IxD73dQPR91vVy9O9uHs9yOkl6KM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3Ouxf0LFGcSVmVOChkPMPn5koidh/Jv0W8QhLycTPY=;
 b=HOJ8Bt5rBJZugsC+KWMdw7xjaF0HSdpphzDUIrxZsnwRjCEYT6dovER86qmqz5BECAmYD66kNHcayfIuXerEWbHF2FeGd/Nof3rjpqqSMc1a3zWsNcSM/mMALiEeevvL6/1swCQSHOR29kt/J8iGhwooCWQPQZIKS5MvBV24Ti61MOpcZp+4jTPxSEfj4DjU6M/gLAg7wHjP3JB+MKNnsRDc+l2WsKfFWb3kwhnopzXNadgYXvN7hHs6G1vK9rU13yA3r2iKP+5/73yLcAxjxh5k58ETqbnn6CLSYwn7RMWEUP27is41d0s+PPulXbVYSxrTSXGDrIztjZ38SkGpTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3Ouxf0LFGcSVmVOChkPMPn5koidh/Jv0W8QhLycTPY=;
 b=fklzmEcfyzpnGrkVdaquUIKG4W0bYEEjDug0TiMI2pk4UsRjmAfUgoLKnWe0WqutaweHn5mDhB81YuyZRexVwnuHsc7e+nv9n+UywM9PQJRZ7gWvM2IF2YU+ColFTPsLJ7A5HsT6JKOG8izXA5GYyjCmU8pmabqa4yxC9MLO6hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6611.namprd12.prod.outlook.com (2603:10b6:510:211::11)
 by IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 08:03:53 +0000
Received: from PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381]) by PH7PR12MB6611.namprd12.prod.outlook.com
 ([fe80::76d1:e471:c215:4381%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 08:03:53 +0000
Message-ID: <84f1014e-27c8-4fd0-8a18-b4b5259028f5@amd.com>
Date: Wed, 7 Aug 2024 16:03:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor (v2)
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Roman Li <roman.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
References: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20240807012057.1192380-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To PH7PR12MB6611.namprd12.prod.outlook.com
 (2603:10b6:510:211::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6611:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef29236-9359-4393-c0f6-08dcb6b77a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nk9ZaVlGS3FxSDFaejdqZ0JSREk0UkY3bGdHNW1JMHQ0dnJhMXdobGhnUDBn?=
 =?utf-8?B?U0ZVcXgyNVJja0pHK0dQSDVIQ3c5dGlZQ1V4VXFZQVFWYXNzSUVWaGRiaVhv?=
 =?utf-8?B?aitUc0tUdXRqRXQ1dFkzbktmYklaOUUrSnJuajlISGVHdXlWbGZkU1FyU1VR?=
 =?utf-8?B?ZXBiMlRmWTd6a1dlQ1JYbG54ejJJS1FFVmFMU2dLbzNQcmxhOWZGazc2anRB?=
 =?utf-8?B?RHpTVUVlMmdOTmVjTTQwSUU3cHI1V0tpTEZHR0d5QzBvRTliaEJaTmVuQTVC?=
 =?utf-8?B?OWI2SyszQUhsTW9IS1FUVFEzaUZFMENyZG9ONnovNERoU1IvMk5WWmdRM1JQ?=
 =?utf-8?B?V2FGems1dEpPVXNJdUZsWU1wVGVRRlYxbDlXQUhnenBBTW9qaUpsQnB5N3lQ?=
 =?utf-8?B?WUZTVll4MDNsVEpEUzJJMGFyMGtUSldaV256WFhSVTBwL3Vtem1HbDFXU2lO?=
 =?utf-8?B?bTVhQnRQM2IxdmlyZlpQOEdrTU9UNkl2UFkxWE9WN1pnejlNK0xLNXBKTkJG?=
 =?utf-8?B?UmM4QTRkSFA3YWVUV2Y3UXdCRHNYbjlXSHdmWUxGM2d4UmZZVm42OW9KVkt3?=
 =?utf-8?B?bjR0NUlhWHJQZUFKS2pKS0JEbWJkQmc2V05lMHRGZGNueERVLzgzZ1llUjc5?=
 =?utf-8?B?RTFHdjlEQWwvMWMxS2tFWG1GbmNxQzFpZVFmQVFaditSVThlQjE0OS9MbUNy?=
 =?utf-8?B?SzhwL0h6M2EreGwybXJNVDRxTVFSVUNoU21VZUUxb2ZTUlU1WEQ0eFpDNGNh?=
 =?utf-8?B?eGVMQlNZZFNUQ09EVGJzaGJQLzNFRjUrVVZQVHZkUTZSM3BNTDE2enFlNmJB?=
 =?utf-8?B?dkNqRFpwdDFia2lhTG5VK0tQUFBySXQ1OWN6RTJUenJOUUtjZTdtSnhpdlRW?=
 =?utf-8?B?aDk3djRkZWJZTnpZNEZVTTQrVmdqMjN4VVNKeHFZNmovVUlOc1pPZytHdHQ2?=
 =?utf-8?B?QTZEL1JCcFRYdWR2UytUUHhpYWVXY3NZc2xMZzlkT1FVZC8yMkZMa0h5NnRk?=
 =?utf-8?B?SEFDbUgyODZZK2F0S3FFa1RHYW1YWE02K29YOUg2N2hYR3R5UUFaM0ZQZXls?=
 =?utf-8?B?QzhzL0sxRFhlUU9tRFA1YkM3MDJ5aGdZTzIvT25MR3JOdHl0cEE2YzFiZnMv?=
 =?utf-8?B?V1VPbHJuU20wYk1UZEFpUmxNbEFrVFpkbzJ1OTRYOHVTWnZvQmtMRWdIaGt2?=
 =?utf-8?B?Q1o1WUg1dDh1eGh5eHRZdElSdmczalFpSDVUMnFQbVZpOGlkdFE3WXdmM3c2?=
 =?utf-8?B?dFZMQXJXc1NSdG5UUVYvam9MOGl0U3Y3MEpLZlFvL0ZEUTZkR1JlbFg2Y1FY?=
 =?utf-8?B?ZXdXRTl2ZkJra0NjSy9aQUVjOTVNRHhuNlpnbmlGMExVb1RWUkVDQW95OXlx?=
 =?utf-8?B?QmRQMjArRDFXM3dwSkp0YnRqaVZrWFQvQUNkUFZPU3liT3Jka0lmZnJVNTZB?=
 =?utf-8?B?VytKSHNEQWNaN0ZRY3B0QXFLQThjREpaN3NnUkczY2lCaVNDenc2WmdyUUxs?=
 =?utf-8?B?U1o2bzJnMHZJSmRJMDVVZllIZEF0SWhoM2FHdGlLclprOWRzTmdZNnVGeS8y?=
 =?utf-8?B?eHVINTljT24rZHduOGEvQ0N1TWVDWUViS2kwcEFReEVocUNpMW0xSDlmNVIw?=
 =?utf-8?B?eXNCclV1SGtVZnFjOTNDRXM2ODduZFdEaStjclpNN2NjUXh5UHBOWXlrTUIr?=
 =?utf-8?B?RzR4T2ZqZlAzeG9BTU9ZbWxFVGhUWGRhODcvYTBreTczYld2VHlBU3d4cHJL?=
 =?utf-8?B?UFRyWGFtYWdvSGNGelRscnlwd3RaamFOR3F2S2JtM09WMnlyVkFseEU4K3lo?=
 =?utf-8?B?bHozNG9vR21yU3R1ejU2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6611.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVQvY1FaZ0xZNFlnRHh5Nis5ZzdpU3hMMTZ4Nm41em5QakFQbHNEWm9RbEdK?=
 =?utf-8?B?ZTFqWndyMzUwcTdXMGI4ZktycEdFMnVaUWxJS3Zoek1uSS9kc0g3SXRteXZs?=
 =?utf-8?B?Ykh1TkRoUUQzNlNhd0M4T2V2Q0lxb0pHMHR6RXplYStrdldVSmkxSDJoR1RK?=
 =?utf-8?B?ZWpiU0MzUWtnUnhFaDlLZUxvK3VBRThaWkRUQTMrQm9PZEJRbUhhOVUwbjBu?=
 =?utf-8?B?UmNLQ1h6T1BXbHdyNHNackpVMm5tZWZkTDF0STY2ZzZiaFR4MElqNTgrNWp2?=
 =?utf-8?B?UHFhOXBobGMrTGRqTFh3WEV3c3NrY3llWlZoT2ZaSmpwVVFZeXJtUk1Wejcw?=
 =?utf-8?B?SllUK2Z3cGFod0crbzNpWWxhUzlvZElJTlJ0YTJtQzZuRGI0OVIvVkJ1SmZk?=
 =?utf-8?B?MmlJMFRtQXZsVUREcVJLczB4VGVBQUsvKy9EQ2lFZjh2YThvUktmQjgyUVdK?=
 =?utf-8?B?U2xpcGd2M1VuWDhyZEprakt1U0hVbnVwbVJPYm5UdUxwMDh2djJIeU5jcHhU?=
 =?utf-8?B?WTJYMHdiWlNRS1JuMmZPT3YxY21ENzV2N2RheXdIQUlTUlJqYlk3YkxML1U1?=
 =?utf-8?B?bFhmSFBPMVlQR3FLQ0lLY21NZ0JweDBYL01TZm5RUE1tRGlZWGV1TkhTZkpB?=
 =?utf-8?B?bklmcFpFT0liU1BRTVN0Zm1yd3h3bEU0Zy9FUVZYelJkUnBVbzFqQjFTTmRn?=
 =?utf-8?B?R240R3ZjOVZnb29GQTZTcDhwNXp3NUFEQnNpcnVaNnk2dWh5ODQ2S2x0NlUw?=
 =?utf-8?B?SUtMWm9idk1ZdHpaSmZoVlhBeDFleXFDTjNhYys2NUtLWE1RUVowRnYyVEtS?=
 =?utf-8?B?dnV1SFNWclB3MkowYjN3dzlnK3NmdFVmWERTbG95S2pEd1NUb05KQTdCT1pp?=
 =?utf-8?B?amFYRGZXeDBERTdZL2ZzQzYxYXo3NjRLaENOUUJzM1J6WVRkNlh6Z01xTTl6?=
 =?utf-8?B?QmVZTkQvZHlRRlNEWTcxMi81TWpZU2N2bHA3bkNvSEFsOW1RVnZ2V1VIdk1k?=
 =?utf-8?B?NEN2Y3VTa2EzQlJPZ2g4NVdEbG83MkJ6Ym52Mi9IaUQ0eDhlNjhyRGZudnNn?=
 =?utf-8?B?bTZVNmUwa3V3aW02blhORU1GeHJQem9uZnEvckVBSHp4K1Y5TXZYTC9tVG16?=
 =?utf-8?B?dW5oTDYvWXIySk5manJvM29zTWR4K09CM1JMckVhNkx3YSt6RGhsSU5na3Mr?=
 =?utf-8?B?aUVYcXVYWWJOOEhmWTNOaXJrdkpadVVMUkdaVjM1RXFlaHpza3NrMUVHd2Nt?=
 =?utf-8?B?emt4SC9mYms5L0psa3p5aVBwUzd5Ky9Qbm4rN2hkc1BQTXlmOGJlSkE3Kytv?=
 =?utf-8?B?QWx3ekVtSG40cHM4TEtOSkxHNTh6bDRhT3JnNCsyVG04aE9DaGZDUGZOazAw?=
 =?utf-8?B?QS9kdlFScERlUlNUd0JFK1J2SmpEbkRGVzlVZFJVWEpuYnd2YlNBZ29vUEpk?=
 =?utf-8?B?V1M4djlLdGhaMUU4UzFTWFcyaVV2VkpNczdtdnp5QjExZjg2MC82ODQ3eVJ3?=
 =?utf-8?B?M0dwMkFaZzErKzlRK3NWWHF2SnU0N1NXZ0g5QStrWEpMZ0lOSmw4S3pXeGRl?=
 =?utf-8?B?ZjhpMGNSeTZEV2VDditPVXFhY1RMQk9EYW5DWjZrSk5MU0V4WGZZOUxPT25V?=
 =?utf-8?B?ekJEeWRXbjBOcXQwckE0YnYwZjNqWkt4akZYWTd5Y1Q1YzM4RzhFWHhPUnMw?=
 =?utf-8?B?Q0RRcUpPOGkvVERDTGFQbEVIRlh5K0l5WmVYY1ZnMUFUa2F5MHBocFRJYkZ2?=
 =?utf-8?B?eUFPdXd4dEZEUnhnNnVQaUdQTlI5blJURkJKQSsyY2lYSHhsZG9WR05sU1dT?=
 =?utf-8?B?S3dHZ3dZZnNYRHhaTG1PZFRTVUhuZFhkL0wwaVRiMXp4Q3hBa29QT3lNNWJk?=
 =?utf-8?B?K1h0TzR5QWl6VTYxZDF5WkFlTkRvMlFHS1U0anFEWHFzL1RZUXlxSkhBTEZn?=
 =?utf-8?B?cllUQVNJaDQ1WGFCM2ROVFF0akkrVjgyeUxTQWpUWk5rMERQYS9GT0RsVFVi?=
 =?utf-8?B?bDFXYWlJWlc4Z0JCVGo3b01xTVA4RTJNSzJoR1F5YmJQZTF1MHFES09WWGFL?=
 =?utf-8?B?elZBd2JUNms5YkljTEh5cFBJZytRVXV0VlVHWmNrV2hLd1dEMklXVHc4REU0?=
 =?utf-8?Q?0Sgw8MB+VCtiKoUYEHzbcA12S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef29236-9359-4393-c0f6-08dcb6b77a7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6611.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 08:03:53.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzSGXWjqMghmXLIWwupwqsQ4Csvk4W44B04LK/mRwCDi1hbpYIBIgJj1HrsgmGsPxRS1lBf7bCuajhdT91C1Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716
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

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 8/7/2024 9:20 AM, Srinivasan Shanmugam wrote:
> This commit adds a null check for the 'afb' variable in the
> amdgpu_dm_update_cursor function. Previously, 'afb' was assumed to be
> null at line 8388, but was used later in the code without a null check.
> This could potentially lead to a null pointer dereference.
>
> Changes since v1:
> - Moved the null check for 'afb' to the line where 'afb' is used. (Alex)
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
> 	error: we previously assumed 'afb' could be null (see line 8388)
>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Co-developed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 293f93d1976c..0fe043df643d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8697,7 +8697,8 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
>   	    adev->dm.dc->caps.color.dpp.gamma_corr)
>   		attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
>   
> -	attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
> +	if (afb)
> +		attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
>   
>   	if (crtc_state->stream) {
>   		if (!dc_stream_set_cursor_attributes(crtc_state->stream,
