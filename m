Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793A1D78788
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 16:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E0D10E9CC;
	Thu, 21 Nov 2024 16:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n7Nvp9U6";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 927BB10E9CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 16:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbKN+4xNlxuCmrSwx83Be9FRuOWKWPXgfySHpBbEAj/m0dnFcKFUTItaGL/F9667Lg18Ehd8Oz5l8AdwMM2bKanq/qhvHZT1vmY2t31XKpCkjUlEbBzEIrC90c8YfPFVFsHnB5xCHRmiIdj535pkVPVGP+PHfzHD/uzAVEi+/2SZWXyviia1+t6tDHBHsW0xC2BwTYu/Di59pUmA04t0qq6Oy4UZqLccApGCELQmsbFau4iQ9am+4nnvRtqBftU9CgHYDogFyxEDA4bsyb2nCWdYAqMpmzCKXH28JsfBtpElPfXoE1bIJ7FBVHwBj77xkuNKiz81HU7mneo/jKBnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7H8Lqouj2/nK7BNrSRsRH5xtByFBCRWgXnv9s9ijR8=;
 b=enVzRIGM3PV3zy+xQ+Dpxbxh8jBc+o48BshBBc4FvKWz+Tgxxgfk2FrlKI9XlQeDOk5q58nV95tuLzihLVC1+K4yoHg0yqsVkPLZsPQkFcGs9g6MlrDFowkVy40vSY3U01eB+GTkFSOw6gP0AfAdTzhBZPMrpvKrN+zCvN4GsOYGKCUvtgKppbJu9lbW/9t1wDNE/PpTWCUcCNXC9sWoxHeBizuEZPAhRMHXotsHgQm/ofz4slUK8/OBY2iD6Q+JBn5ztWWJbc04hev1jsHxMh/y34YpbH8ew6anYR5JydJ3n0JzQvK90vSXwWaDFQHFKbK8JDZYjhVAxdzH0wS+tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7H8Lqouj2/nK7BNrSRsRH5xtByFBCRWgXnv9s9ijR8=;
 b=n7Nvp9U6UA3oMtMSbJ/sncnj4J6YTQv1FrsppuI5tqhJ6MroqeSfbOPl6Abx7Y4cn5RA4U4y7W8XFHUl6SOfhv1YZgI+RGSC55AYJSXzUohRFJ6bQISYn+wxFHwBSvckfLdg38XwMj3I/A37iNA9wgIjZ5YeD4w48pOqDWvH+eU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 16:19:48 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::6216:e70a:9c8b:7abb%3]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 16:19:48 +0000
Message-ID: <383350f2-a50c-4a0a-8cbf-e16ee4c613bc@amd.com>
Date: Thu, 21 Nov 2024 17:19:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] drm/amdgpu/sdma7: update mqd init for UQ
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20241121131055.535-1-shashank.sharma@amd.com>
 <20241121131055.535-6-shashank.sharma@amd.com>
 <1489df29-fe03-49d1-8191-b64f4e686c32@amd.com>
Content-Language: en-US
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <1489df29-fe03-49d1-8191-b64f4e686c32@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH2PR12MB4053:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bd8dc3-b21e-440d-0116-08dd0a4851b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NS9nN0VhbzN1U29KRytiSlpXMkxpa1ZmRzc0aVcza01tMSsrTDNnMUpqMjNq?=
 =?utf-8?B?YWg0dExoQXA4TWdxQjkrWnBkQytpOXJXVVVRYnA5L3ZMOFk1aDk0RGUra2tn?=
 =?utf-8?B?VHlOVVJrUjNvdjFleUIvTDZrS0xCS1ZiWk8yVGdFMGlMOTR5eW9LbU02cjVO?=
 =?utf-8?B?QXpGMFlEaWV2V3FpRTUycG11dklxdXVnSk55K3VZOXVBVVlGcjkzZ0lIYS8w?=
 =?utf-8?B?MTJYcmpMNWhYWGdrUnhwVUZnY2tBYnRIbW8vUWdUSlo0RnpVNjFoN2FFakpB?=
 =?utf-8?B?czg4emp2NHQrc1ZnVnkycWdHTk13QjYyS2duTjljY0JodS9FVXY2UzJPOXFS?=
 =?utf-8?B?NUFDZUpZcWVRNkw5SjZvZTgvL1VHbk84RFI0Mkw5TE1EVnJNMVNGSGFNU29R?=
 =?utf-8?B?WUFhYklaTDY1bUMzcVE2a2JJRktNVDQrOUUxYnpJNUhMczlHRE5SN3JrNHl0?=
 =?utf-8?B?cjBYSGV0N3V6NFJadnE5cUJmYVQ5M3pPSHBCdFJWY25JY0Y1ZGtSZnJGdFV1?=
 =?utf-8?B?V3VrMEIyOG5EN0szRndTODQwbkpRS3ZyaldZcHM4Tjc1QjNKYzM4SWFBQTZE?=
 =?utf-8?B?Y0hRdkJaQ0dwUnE2QVZtd1ZCTzZ6Q0pEbVN4VytzVHRJY29kdUF5NWo2RWpH?=
 =?utf-8?B?OTV0cFRDYUJaNlNId0g1a2xLUmdWdkNubEEreHdaUEhzanF4d3N6b1VnbVo1?=
 =?utf-8?B?MktKNDVQWk52b28wTzNrbzVES0UycTl3MEZKZXg1cjNyVnFZMC9FZk4wU3dP?=
 =?utf-8?B?RHNqNmRaSHpHOERSWDZqdmtydDdSMzBBRXhZVEtielVQU0R6emVlck5MTFhX?=
 =?utf-8?B?SkFiTFZUZDRVRUd3Rld2T25qUEthTlBzckdyQnl2R0lZdlFQVlR6dDhYaGFV?=
 =?utf-8?B?OUxoenhpd0VqSTRSZ3FZekw1L0NLanJZb1RXbUhlN2RtU3krZmNXOWFJOVFq?=
 =?utf-8?B?VjNSR29jMHpEdUNIdjgyWXhDWjJ4Y0tOcjFDaFdsSllRbzJmdXNJT1dIVUxa?=
 =?utf-8?B?eUdiUEx5NHJ5RkNHOFdaMUxKZFJSeGpkb3Q1cG1La3loOW92VkNjc2RTL29a?=
 =?utf-8?B?VnFaQ053Q3NkdFBMQVEyZy9JcklXbGZRazBTamJhbmJSUjdrR0QvODJQZUVD?=
 =?utf-8?B?OEZsS2tET2IzOC9sSEdlZEJtcFArODVxaHh2a2puZitNVk50MjFwT0lFdFk2?=
 =?utf-8?B?dWR6RzNYNWdjdk9iWXNOcXdDT0dCVkhMbUcyRjhOQUxnVkFMNVFuV3h6TVVp?=
 =?utf-8?B?VFZ3d0tXOVJJY1RYckR2dmpLdDVIVkhJQ1F1T2pMSHVHdHdGRndHbkliYVU5?=
 =?utf-8?B?NXlYWDlyenVQU0wvNTB1OGxMTWdma0JIQm9Da3lGclJMb0RSM3MzOUp1UTNQ?=
 =?utf-8?B?d2dia3MrTUFsSmoyVVpRL0JCcFhBTEZBbitFOFhlc0xMckFsbXdPeEEwbndX?=
 =?utf-8?B?T2lnWmJrby9ZTitVUThNc0JOU1g5d2tLU0tIaTNqSWVwRU1RamRRb3orczVK?=
 =?utf-8?B?VFBjVGw1Z0Zod0pMZHh2Uk9JSnhQUThWREE5S2cyWlhoclhQKzZXOGNGcHB2?=
 =?utf-8?B?YmdIaGRZUjUrR3pDRStDcWxUb0JjUmZLeFZDaExyZ1NkMEtmTXFwR0pqQ0VD?=
 =?utf-8?B?cTB1Q2JrTUhLSkM1dUhJdjJ1TjdtdkpPN2d0YXFyMlZDcU10K1BBYm52M3Rj?=
 =?utf-8?B?a1NmUmU0ZGNQb0FkUmtiaXlxYUtwbzJpaHNTRk40QmtKKzJaYXJOZ202OEVN?=
 =?utf-8?Q?mJr6MwzQe7UK0weokztHGlWhEB/t0HjzEQZ8bGy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNxWWpoVDZuOWlwdkZyVi8rR0RpUUFYRzkzVDkxeFd4S0RVQWpyMG5jMUpT?=
 =?utf-8?B?N0JvREdZbE0wSHNtalBnbTNFTkRjM1FUMjB2MVY4NEwvNi92VUJBdktnc3FS?=
 =?utf-8?B?SzFnTUVleDFocDJPWUxrc1RCTTROdExWMVJKT2pDdzdwSE9vb1ZMYUJtUW9v?=
 =?utf-8?B?WWxYOXZqZlZESlBDa1lPOHE2NUYvZjMyNE5sOTg3M1JWYVlXODV4bE5UVkJV?=
 =?utf-8?B?ZDZwZk9mUm5Oa2hSaXM4UFV3YVhabEdtSFBzVHBXTElHM2FGem1NczFaeGpE?=
 =?utf-8?B?bzRUamFONFVhWlZmbCtmeFRsYStHZW9OdHVjVzNKUVROaGVVZ3VhcHNxTTNU?=
 =?utf-8?B?SENvbDQwS0hEWEZ3eXVTUW1yaDNEZU5yczlEMmYxbmNUNVpZM0luMDN3Ykgr?=
 =?utf-8?B?b2t3SW9MR3lHZ2dEb0d4QmR1YUllcGQyalpqbHlGemd2WXNwZGlzQ0E1MkRZ?=
 =?utf-8?B?bW5hQVNacVloc0xyT1dIL1VnQTI3d3U0aFpmaW1MVEpOL3E3U05zT25ucjhJ?=
 =?utf-8?B?eWVSYk5YZXpCaVVNMDcyQ05nVUxJOHowS1Zkd2xPV25NdmNmZkM3N2VGRlVS?=
 =?utf-8?B?ZGwrTkhvWVJ0RDE2SlNLN3YyTnJaZDZxZVg3SUV3N0dTMDNkcERndkFmek1s?=
 =?utf-8?B?Q0NkQW9taCtmSStpWnltYmlXWmMxeVptQ3A3RXRRT256T250NE1DOEFRMDhJ?=
 =?utf-8?B?V2paMFNOVFU2eks5YU5WWE5WWDNWcU5XQWZyNXg3UlRPNlNxNnJCdGpvcjh4?=
 =?utf-8?B?MDZISmUxK1AwK1I4Ym42SUZMcUo5RjNDVWVXTjFFNS9NLzRwamRkZ3pqNk1a?=
 =?utf-8?B?SWhKWEc2bEwvakRRYTFBSFpIOTY4c3FtR3hldUc1TW9vbHdvL05Ma2I1L1Uy?=
 =?utf-8?B?aFp1Y0lLNEEyZ0FieWhEWTVtRGJNTzhja3dFU2dPdWVvN2wyNCtUc0lJMzR0?=
 =?utf-8?B?ZlZxQlE4Z3pPOHJaUjcvVmQ1bUE3NENmRi9uSXhCRGdrM2RCTGlZRkd0L1Ax?=
 =?utf-8?B?T2c4aks1RGtpd1NrMjZVbFNzQko1V05Ic2c2bitndk91d1pveFVFTXYvRzYw?=
 =?utf-8?B?b2lNQnZQYmxlVDdVUDlSZTdmNTgwRDF6RWpWZU9LUmdGNk1sSUFFVXRKUkda?=
 =?utf-8?B?UjR1ZUpGaTJabmhLSWo5L3BNMTk2UjlmTUpqSGxWbU5HOGIzWnJkbzFVN1h5?=
 =?utf-8?B?VVhKU0JFbjZDZXhWSjVzZDlhaHlnOEFBQ3o3MVhzZUZVY3NyNXg3R25NVG52?=
 =?utf-8?B?bFg5bHY3ZjZSRE9iNlpqQnZ4Y1RraklDeXFtV1psQk51Y0dXZWttY0ZaUS9Q?=
 =?utf-8?B?aTlmY3piT2JXU2puTWhQUVJIVU9RNHVXWUtYMEFWM3dKZWxST0VVcHVveDdu?=
 =?utf-8?B?SE5ENWhFbHVhQ1MvdXNxemdGeFNSUTNKbDRnMWVaZCs4V1NleE9FbVhGMVQ1?=
 =?utf-8?B?M0V1N0xqTHVpYzBCbkVWS2lraWh2ejN2Vld6MU9iNEFWbDN2WDZkVkxaN21W?=
 =?utf-8?B?aG1ZTUNiSld1Q2dSRDM0SUtUNjQrZDBIRU1vZ2VvY04vV3RHT21yVjB5bkVa?=
 =?utf-8?B?czdOZjZ6VkdGNWZJOUlMK2RKcnRRNWZkbjBhSG9sVEJyMUFUYU5YUzhheGdm?=
 =?utf-8?B?cTVscXFaTndiNmlOWjJiYVlIQ0VNTU5DZlArRlZ5QzhBWTdJNGd1VHlwYncv?=
 =?utf-8?B?ZHFHWC9hdEwrb2p2a0I1NVY0R2J3ZEkxVGRvYUJSaW40RXV1OEx0eTNXWmZ2?=
 =?utf-8?B?ZG83emYxY0FIcWpZWU9nQ24rbEdiczcvUFVnNFJhUzlEb1lOZkxERGVtL0I0?=
 =?utf-8?B?b2Y4MGJsc0tYV2VqNlFyYVNpMktzejAyTkllYmFWajc5K2tkK1VMTE5DMWsv?=
 =?utf-8?B?VWtnc3hXZ3VYTEJ2d1QrVWdTbUc5SFlUMHVnSEpKcTNteXI3Rk5aeGpQWmVZ?=
 =?utf-8?B?WjFTVmVSY2lCNE81YkgvdW1MYW5EbUQ5NEp3OHc0aW1PZ0tYOEE1RWdqc2x1?=
 =?utf-8?B?RVpnQ0YxcS9GQnJUVSswR2h0S0xueTh4cnNoZlhiVU9VRWxNWVhRWGZWUkRE?=
 =?utf-8?B?dzYrN2N3QXJPR2J6QTVVZHlhdFQ1UVVoZ1h6Ylg2Vlhwb2FrUnEzVUhndEFP?=
 =?utf-8?Q?Jv5Xpehw3ERDk02vIU1XLw8JH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bd8dc3-b21e-440d-0116-08dd0a4851b7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 16:19:48.4734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJDv2BBcpZxXUnSd2N5/GRhCZedomAh55fcLafsMTp+9UFq31AG6nz0XV/itiCjJFj1tBiFWreaf1FtDOVvr6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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


On 21/11/2024 16:19, Christian König wrote:
> Am 21.11.24 um 14:10 schrieb Shashank Sharma:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> Set the addresses for the UQ metadata.
>>
>> V2: Fix lower offset mask (Shashank)
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> index eb35ec9f3da2..fc9cb989aa6b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
>> @@ -887,6 +887,9 @@ static int sdma_v7_0_mqd_init(struct 
>> amdgpu_device *adev, void *mqd,
>>       m->sdmax_rlcx_rb_aql_cntl = 0x4000; 
>> //regSDMA0_QUEUE0_RB_AQL_CNTL_DEFAULT;
>>       m->sdmax_rlcx_dummy_reg = 0xf; 
>> //regSDMA0_QUEUE0_DUMMY_REG_DEFAULT;
>>   +    m->sdmax_rlcx_csa_addr_lo = prop->csa_addr & 0xFFFFFFFC;
>
> Please use lower_32_bits() macro here.
>
> If the lower bits can't be set on the CSA address we should have 
> rejected that in the IOCTL and not silently mask that here.
>
Noted and agreed,

Shashank


> Regards,
> Christian.
>
>> +    m->sdmax_rlcx_csa_addr_hi = upper_32_bits(prop->csa_addr);
>> +
>>       return 0;
>>   }
>
