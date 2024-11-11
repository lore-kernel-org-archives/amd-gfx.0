Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B94BD12D79
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 06:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D08A10E429;
	Mon, 11 Nov 2024 06:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AkMzh0c4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062.outbound.protection.outlook.com [40.107.96.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF12210E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 06:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3l1GNNWjve0KGPT8ZnnJ7vpjxreeM0Bxgmvndfy1TZQY1jBHo0rlPQWFigCUZ1hTmFErlT2MDjBvGZGfdAisod2O8MelJow4/ZwPUTN3qXdfsjkuFHB8L+E427CjaaydCW/ZM3/nAALskVGw9wxJu1XWdLNj9mRp8yWhteSeGjtq0108HDpVthH0nsb7/I6XXw79B6WANd3Rt/GhTLzWHy4k+3YjX2kYWC0UDLI2FOFcjlx58jzY0zrMsHByvvFP0JL6htQswSddAaO4LunQ/mYrLNbMTvLmFSu4pLlECS1eVbkRZ3yKclvnArhBP3ii4bbKPulZ6ntmRBqufm2ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DruyLipAeYFoEqVAeLmkuDMbiu5FTwIMK1Q4XFtyn78=;
 b=IdUbbw16WOm+pBpVw7LxXvsrq/EjiDnEjA34DNA917m166W8Cp3aXXC7dej6hhRvfWQBJV5k/+b/TFskvbSc0f6T+0Xl2kQcapUlGW6TZbLjW61U06WDnHiecPhjB0NxSHiuwOpeZS8owI+s+U+45q4mvAZJC9oV34Zyihu+UuflvwBGETJLqQAvuf/Xtl2FyU7E8bSERPHpGW4o81XkPLIizjG6sB96ji9pS2HhoEjbxI3m29g+Taa/SP5g4Otld0sJ9qzd+m+xxdZquZJiAOFP2IryiNEk5P2mEHjvzkU3jAA7/4qqzejC1mWQfhIyS4+kyuFT+m8Ul0MUWRicWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DruyLipAeYFoEqVAeLmkuDMbiu5FTwIMK1Q4XFtyn78=;
 b=AkMzh0c4m+Oe8C4iW+stIHKc0dOSimcfstzZKhhihnkkvz9oBSvRA72H0lw7oEA9JA0PUxAmForHyfG617+HifvEQ16WngSbOX2w1J6vxRAVFmUWxfz4rk6fesY1PHKvmRL6Eg10dGfgmEaigNOclFK6gi4SlME79xOuQwNceyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 06:46:51 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%4]) with mapi id 15.20.8137.021; Mon, 11 Nov 2024
 06:46:51 +0000
Subject: Re: [PATCH] drm/amdgpu: fix double free vcn ip_dump
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 vitaly.prosyak@amd.com, Tim.Huang@amd.com
References: <20241111063011.1380340-1-jesse.zhang@amd.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <788c8bb2-75c1-3ad4-4898-6a01d6019587@amd.com>
Date: Mon, 11 Nov 2024 12:16:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20241111063011.1380340-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebc7c54-8ab2-48a6-8811-08dd021c9f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N21VSkY1dEZCaW81K3ZodUx3Z2crZHpTdWtaNU44Zy9qUUtTUE40MGV3bXRS?=
 =?utf-8?B?eGRvdmRsS0RJeVJoQWRMTzYvTHpycnNaZ2RYY3lyL01aZlZqQUs0QjBDdVhN?=
 =?utf-8?B?NHhsZ0ZkVldCd3hKVS92alRndElZQ2VnN01zTHQyTDR5WDgzME5ROXRhSGtV?=
 =?utf-8?B?N1c4NWZMa3FtRzRHdURoSWtsaEtQaXZ4OHVwU1FWNVhmU0ZwUnRESVRDSmEz?=
 =?utf-8?B?SHJRK1V1aTlDamJvS1ZCY3VXVEh1UWlyeGl1ODhMMWh5bGtrd3dPMVdVeG5v?=
 =?utf-8?B?T1QyQ1llbWd1R1hneGUxSHdGbmZpNGxvSDBOVG53cmlZb1l5WXpHcVRLQUhj?=
 =?utf-8?B?WllnWWVEOUhBUlh3Rzg5U25FZ0M5cEFKSEdWRWllaU5QYllMQ2FkNjgzaHlI?=
 =?utf-8?B?YzRET3M0eTIzbGY0aEFPNmJtWHRzODdBSzhYSnNYaGVNa1QxQ0hKd25Ed1Br?=
 =?utf-8?B?N3hCM0tBMHArYjljNjQ1N0gwZnFYMklpM2F6T1NWbEtjYzdsZmZocTRWcTJG?=
 =?utf-8?B?WkEyWkpzNVJ2cU9JSVNlVGdQcDlPNVlDdDk2c01IWXliNnN0WXIvaFBHR1Rn?=
 =?utf-8?B?em5TQXRSRC95MlF0Wkt4UzYvbzYvNDAyQXZBaHlPaWRIZC8wdXZpSkg2MGp1?=
 =?utf-8?B?dXlldEU2ZWxaczUycDBaNU9GYm5KeFVvTFBnSzlZSDlkanEvQjM2dGovckd5?=
 =?utf-8?B?Q0VkLzM4dFBYTTUxQVJOZVVUL0dUTXRNeEF1T1RiVkdqcFo3aUNlS2g2ZmJs?=
 =?utf-8?B?aUEvclI0YllETlNaTVY2Z1FlTWNWWXh0bGlhVksrTkhDaitzcm1OWTVVQlpF?=
 =?utf-8?B?dGpkZzhtSHRMdW5OSkYyVUxyd203THNpRmxHTXBUM0FFWnVpVzFxWmREdkIx?=
 =?utf-8?B?VFBrV2xaYis5STlGQkZ0dDlkSVpPRjJLYmI2TlRROUVkSXkxQnovTTJwS3U4?=
 =?utf-8?B?RHBEWWcvaGZRcklBaDBSTDF2UFNET3hDaTFuWjMvM1Y0U2lEWDVKbUx6SXBq?=
 =?utf-8?B?NENaaFBkZktQNFZXRDRCRERxelFRNS9CMGtqZ1ZZYVVLRVNHcFBkT084ZGM1?=
 =?utf-8?B?QU1nU29iK0U0djJjNTRmemlhS1R0eDZXVEg3Y1BSY2dYRmMxTGZPOCtFQmRp?=
 =?utf-8?B?VnZSRUtLT3NkZEhzUnRZMXBUYjJYdFAwK2Z5ZmNQblZYaGhBOEtQd05jYXpp?=
 =?utf-8?B?dHhYV1cyMW9mWU16STloSGFPdzJtdEM4N1JMZXFKVGhZYXJqN28xaE5WcU9Z?=
 =?utf-8?B?REdVbk9xNlB5Tlc1enorRlovb3V4MEVFdldCWWI0MGxsVU9wOGNabldrWlZX?=
 =?utf-8?B?VkpVa04wbk43MWtmZjVzQXBSRmduWWtISU5jNmFQbFIrcHY0T0x1T0hnblVt?=
 =?utf-8?B?KzRqQ3BQUlNXMW54WVdPY2ZlUEV1ZTZEditoQ2J2RllwM0M1cDZhU0c5Z2R1?=
 =?utf-8?B?MFJOdWhNTCtENWpLbmFyM25WYTFucWxzVXNUZDdTSEowVXMyVk5ldnZOUFA0?=
 =?utf-8?B?c1FFSGd1SjJqT0Y1SWJMT0ZOOSttYUg5TE1PeFpqWjBQdHYwemF0d2pwRi9T?=
 =?utf-8?B?bmZ6ekkzNVlYZTB0Q3pWSVNhcXJSZkdOTW9MTWEzR0craUlXQU92YzBCMzJK?=
 =?utf-8?B?dTlOWVl2emlCWXEyLzFGRXAvQWhQNFBmNTl2N2k1ZHRDa21EQ1Fwdi91Y1U5?=
 =?utf-8?B?L3N2TzVDOFlsNFM3R0hmK3dwbTg1SCtCdDk0TG92bFd2Qzl5d0M3OVJybXdC?=
 =?utf-8?Q?m22ul2LLrUW+rJFbmM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUsrNDZWRFZVZDBxR01CRVB0VDR1NHFjNHE0cHo5OW1NVVVLUUJvWTl5TXJN?=
 =?utf-8?B?WmZzaFVEMnNUTHRPNTV4VjQ5NTBRYWtpMFNKSittckc2aDU3bHJtTFpqeDBD?=
 =?utf-8?B?L0Z6cmxYZ3BZMjU0Z21sYzQ3aUxsamhsVjRLTnZONVU5VDJrdjcra1B3dE9u?=
 =?utf-8?B?ZDZDeURVM2x3Nmk2RjIyajNlYmJ3SzM3NG1kR0NNc2g1OFNsc1FWaUpuSEFF?=
 =?utf-8?B?Uy9GcVlMdWZGeGk5RXBzMUZ0YUhKdXFmTTFsTjJqRkE5TG5iUW10cDkwQmFn?=
 =?utf-8?B?cjZlYXFvM2VhRURxWXR1MG5ETnpRd2sxVHF6bjBYQU1mQnBiRktIY0Fpb0lh?=
 =?utf-8?B?b1lHSTZEaEkzYTdya1c4ZUZ0RXlwbEwyUXUzeVhhWlJBZkh4Qi9RTUY0Szdt?=
 =?utf-8?B?NzI0azRxWDFOczJRTDRuckozdDlPUzdPRHBYcW42bExOcHcvV250SFNiZTc5?=
 =?utf-8?B?V3ovSzg4dk1Ka3dkWnB1NFZoRHRzNThMSUhOcFMvczZ2dVFMSjRBRzFabHJ4?=
 =?utf-8?B?LzdWOGw0SHNNR3pGOEJEZWx0UjhVRlQ5NCtndzhGZXYvb1h1QTJtaCtIWldP?=
 =?utf-8?B?U2RXdTh0bjVPWTYyaW5tb1NZRjkyTlVHK0hGNVhHQWFkakdZOVoyR0UyV0l5?=
 =?utf-8?B?dGhHRWRCM0RlejFaMlhKblVTeXFENGNFMUR3cCsxODlSSnkvdjZ3T3BYalIv?=
 =?utf-8?B?ZzAvemxxaC9YcFJZOWFFeEVqTnFxZTNMS0tQcEFRcUxDWWJiOWRiRDFyYmdC?=
 =?utf-8?B?UmpIckN1b3ZLZWNDcGc4bys1NE5Xb2ZkbUpBdk1YWXJ4VkhxbVlDZ3FCcWxv?=
 =?utf-8?B?VnlObEZYRlUydktvZ0N5SDhLd2p4UCtGY2VCS0luM1Ywd0FIU3lYRVFoRkh6?=
 =?utf-8?B?ckVjZ0RJdHo3VEsrdFkxYjAwaWNPY3Z2czI4dGVIR3VxVHYzM1kvQjdoN0Zj?=
 =?utf-8?B?czFwTVNDTC9rNGlPSUdLR2Vyb0xIN1lPYmdUbmI5Z2ZWTTZodWtjNUhRL0hk?=
 =?utf-8?B?d3JQWjdYUm9kdzFaaE9uSDY2ckxXVERUdmcraWIwcmVpZ1dMYnY1bDRIN3FR?=
 =?utf-8?B?RW5BY3hTeWZBZ05JeDI1TDJXd2RlMXRKbVFEYTJDSGYzL1dqV2grYm5KM1dn?=
 =?utf-8?B?NW5NbFcwc2orQ1Y1MnNhbFR6Tzd6RkQ4YUJ0aUY4cXV6ZDA0dUs2MTlEVlAz?=
 =?utf-8?B?dEp1UWxHeU9ER1VzY214L0Fjb0pQWjBjZUNrZlhxL2g2ZlBZTEJRUE1iS2dv?=
 =?utf-8?B?NEtudC9uM2IreDNJRitic0E3cFRVUy9aN24wQjVrRUttVHU1bWZaU2ViOUxP?=
 =?utf-8?B?ejFiT2VnWng4OENsakJhMWtsSE9iZStSZjBxaUh2ZE1abEVkZFdZMVI0anB0?=
 =?utf-8?B?RVVRUDNRSVFpeFJWbGdZUWJ4Z1lVR3VIRExSWUptRTB2TjFFVzJZOEorNVZQ?=
 =?utf-8?B?WTYvZHpGVjB5UG5rczd5dmNxN2dISDI5a25obXhTelI4SkFDRUV3SmFEZitx?=
 =?utf-8?B?K2ZuaUZwMndGMUY5UmIxS3MyTk15MWl0Yi9jNXNmUzVYOVo1dXRaM3hURmtv?=
 =?utf-8?B?bGRnazBoWnE0bWpFM3lhWm1wbCt0a2tPa2NwU1E4VHQyUHRkSm9jRHZhNEQz?=
 =?utf-8?B?UGV6dytGUTk3Q2N5NEVQZTZxais3TVRGQ1VCV2FwaGtNVmxJUWs5U0VXVjZQ?=
 =?utf-8?B?dXJXaXZlY2NYYnJielprMDNYdk9HUE9TWEVMUy9lVXNJUDEwKy9KbEtqSzlQ?=
 =?utf-8?B?cmhxTzNrUGc1VnJvcTA4U3dPMUdIbks2UjR0S051SWtCMENVTVpPNmgvN0M2?=
 =?utf-8?B?TW5FQTBKbUFwOWo4QkVvdWlSZ0M3emppRS92OHdWRG5aR1UrallQeUF4RGRF?=
 =?utf-8?B?QlJvTU9sZmtlRWJzUHI5aVVlTWd5UTgraGJXV3dPZEduYXpQb3VWd1FyekEr?=
 =?utf-8?B?K1NacU1UdVJ6S09mdE9YVG5KTVE4Q3BDQWxOVEtEU0creXBiZFo0bXkwbzJ5?=
 =?utf-8?B?VndhbHVDd0xSOWpNVUFjSHYrNjdKdklXMGZTQ1hmQ0t4T0RjNzlKOFJIOEV2?=
 =?utf-8?B?QmpVMnNXVVhWRDdtSW9pWis0OWJmNGlqUE1QcXFERzBhNmZQSUdWREF4Z2Nz?=
 =?utf-8?Q?rBuuCtTP54MwHJgVTJUeJaB0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebc7c54-8ab2-48a6-8811-08dd021c9f22
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 06:46:51.1689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWKWOnLNIjRn7TOxCpk8X+o57nV//BmWLX+658V1Dv1elhsoxIDpb7ShcjgQzSRDQWKqefqd3CudDyyqbEEBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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

This isnt needed any more as the issue is introduced with per ip changes 
in VCN.
Changes to accomodate per ip changes for ip dump is already reviewed and 
in progress to be merged. With that each IP of VCN have it own memory 
which is freed only once.

We dont need this change anymore as we need per vcn ip/instance memory 
which is a design change and is taken care with changes in merge pipeline.

Regards
Sunil Khatri

On 11/11/2024 12:00 PM, Jesse.zhang@amd.com wrote:
> [   90.441868] ------------[ cut here ]------------
> [   90.441873] kernel BUG at mm/slub.c:553!
> [   90.441885] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   90.441892] CPU: 0 PID: 1523 Comm: amd_pci_unplug Tainted: G            E      6.10.0+ #47
> [   90.441900] Hardware name: AMD Splinter/Splinter-PHX2, BIOS TS41102C_925 01/05/2024
> [   90.441907] RIP: 0010:__slab_free+0x1ce/0x320
> [   90.441916] Code: f7 c3 00 02 00 00 0f 84 6c ff ff ff fb 0f 1f 44 00 00 e9 61 ff ff ff 41 f7 46 08 87 04 00 00 0f 85 d6 fe ff ff e9 ca fe ff ff <0f> 0b 49 3b 5c 24 28 75 bd 48 8b 44 24 28 49 89 4c 24 28 ba 01 00
> [   90.441927] RSP: 0018:ffffb9c801cefcb0 EFLAGS: 00010246
> [   90.441934] RAX: ffff8cdb481dcf00 RBX: 0000000000200012 RCX: ffff8cdb481dce00
> [   90.441940] RDX: ffff8cdb481dce00 RSI: ffffe3f904207700 RDI: ffff8cdb40042a00
> [   90.441945] RBP: ffffb9c801cefd50 R08: 0000000000000001 R09: ffffffffc149f632
> [   90.441950] R10: ffff8cdb481dce00 R11: ffff8ce26e621e18 R12: ffffe3f904207700
> [   90.441956] R13: ffff8cdb481dce00 R14: ffff8cdb40042a00 R15: ffff8cdb481dce00
> [   90.441962] FS:  00007f0a4f3fec40(0000) GS:ffff8ce26e600000(0000) knlGS:0000000000000000
> [   90.441968] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   90.441974] CR2: 000055bf74ba8930 CR3: 0000000108f48000 CR4: 0000000000750ef0
> [   90.441979] PKRU: 55555554
> [   90.441983] Call Trace:
> [   90.441987]  <TASK>
> [   90.441991]  ? show_regs+0x6b/0x80
> [   90.441999]  ? __die_body+0x24/0x70
> [   90.442005]  ? die+0x42/0x70
> [   90.442011]  ? do_trap+0xda/0xf0
> [   90.442018]  ? do_error_trap+0x76/0xa0
> [   90.442023]  ? __slab_free+0x1ce/0x320
> [   90.442030]  ? exc_invalid_op+0x57/0x80
> [   90.442036]  ? __slab_free+0x1ce/0x320
> [   90.442042]  ? asm_exc_invalid_op+0x1f/0x30
> [   90.442053]  ? vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
> [   90.442308]  ? __slab_free+0x1ce/0x320
> [   90.442316]  ? release_firmware.part.0+0x2e/0x50
> [   90.442323]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   90.442332]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   90.442338]  ? vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
> [   90.442496]  kfree+0x23e/0x2f0
> [   90.442502]  vcn_v4_0_sw_fini+0xc2/0x110 [amdgpu]
> [   90.442653]  amdgpu_device_fini_sw+0x133/0x700 [amdgpu]
> [   90.442835]  amdgpu_driver_release_kms+0x1a/0x30 [amdgpu]
> [   90.442981]  drm_dev_release+0x2d/0x50 [drm]
> [   90.443003]  drm_minor_release+0x3d/0x60 [drm]
> [   90.443026]  drm_release+0x90/0xd0 [drm]
> [   90.443052]  __fput+0xfa/0x2f0
> [   90.443059]  __fput_sync+0x1e/0x30
> [   90.443064]  __x64_sys_close+0x42/0x90
> [   90.443071]  x64_sys_call+0x18f6/0x20d0
> [   90.443076]  do_syscall_64+0x6f/0x110
> [   90.443083]  ? do_syscall_64+0x7b/0x110
> [   90.443089]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   90.443096] RIP: 0033:0x7f0a51514f67
> [   90.443102] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
> [   90.443113] RSP: 002b:00007ffec29b16e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> [   90.443121] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0a51514f67
> [   90.443127] RDX: 0000000000000001 RSI: 00007f0a51776485 RDI: 0000000000000003
> [   90.443132] RBP: 00007ffec29b1770 R08: 000055f942381170 R09: 0000000000000000
> [   90.443138] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> [   90.443143] R13: 000055f90a2a41c0 R14: 0000000000000000 R15: 0000000000000001
> [   90.443152]  </TASK>
>
> Set ip_dump to null after releasing vcn ip_dump.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 5 ++++-
>   6 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index a327c3bf84f2..b23b55539b43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -263,7 +263,10 @@ static int vcn_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index b78c6da0a3cd..df3855e7b5c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -331,7 +331,10 @@ static int vcn_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 5c3b718ebdfa..d8b46f440ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -295,7 +295,10 @@ static int vcn_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index aa06b2fdeb7a..c71793431433 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -257,7 +257,10 @@ static int vcn_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index 4e7da56a9f34..4c4b8a711b99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -252,7 +252,10 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index a72de204f130..71f2cb75e91f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -226,7 +226,10 @@ static int vcn_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   	amdgpu_vcn_sysfs_reset_mask_fini(adev);
>   	r = amdgpu_vcn_sw_fini(adev, inst);
>   
> -	kfree(adev->vcn.ip_dump);
> +	if (adev->vcn.ip_dump) {
> +		kfree(adev->vcn.ip_dump);
> +		adev->vcn.ip_dump = NULL;
> +	}
>   
>   	return r;
>   }
