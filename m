Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EB7C54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 10:00:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9473910E4E5;
	Mon,  2 Jun 2025 10:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WewdCrIi";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832B210E4E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 10:00:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2d8TbGoLTxX/YQeWCrmuCaiG2DRoOLJHqp+7Wri83nS0fg8xJ9iUfCaDxuIuhRjCRPgWqRqBFqbaDdlQOE8/SF2Wq02DWxlJVzjJ8VA+W4/01w5d3CMFEBi1RvA8o9gutRGmo306HKVu2bW92Bn0mHjXtBPjMZaL8hy1dU80snI4fQn+yLzSgvxMPoq86vuMiFqVxN0+l/+BMDnffNNAJikEOz4M5+SbOZ2P9gscTuGzyTr2K+1C2vi9IxIxoiCjxKPI8/qiTHmXxl9/gJBr75DYmbCO+HURz/timtZSL6I+cEZ2LvZ4aR3r4VwE0u0GhuyznwYuhwe3K4PdwO0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1E9dDKqHf3tG05fPa+3/LAs5FAFYsXergCbm0gcv+M=;
 b=EOFLcPoOvFbod4oIKxOOk02fKI1McDpoSf6izkMsFs0rsXI+hCebguWqk2kjAl8rNHqkSoBn8k5puUDJbTS9DejMBB6CA2iVSGS8SmteqVbZzjeFO1JGi+ffyngZ5CSUCiwr92wYWMg/sGmu4qFb6vJX+FhRXOpv3asdLO4syg4C9IZ5BHlGzIC8gpY/KOwzqa7lWr9jtlZsBdndhyVVYA7zJHpa2ZfKBsYGKsvdGLyqp3dAHp1I9raBWfPhOKE3FAXH7JCcUbhlvWz7YFLpdcsK5aLDDgXiaLDcHIfveN9+YvU41u7XCCqac3+y1RQ6kjXsNMwfpQZ4JwOCbPBkwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1E9dDKqHf3tG05fPa+3/LAs5FAFYsXergCbm0gcv+M=;
 b=WewdCrIiHx3TCcw2y38TmusAhO7ZBYziZe0E1AktgwcOZUFzfMHUUduAX4TpisMpxXLsbLXP+9QKP/sW6+rVO1okwkW0nNA+YTKm1pDUZ80JK2Y7+o0C7CJUOd5CYdNlI55B7iYtO7e5RoNPmO9hGghOwUxQwTiGt/X5NQvZ5Vo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Mon, 2 Jun
 2025 10:00:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Mon, 2 Jun 2025
 10:00:17 +0000
Message-ID: <32880a04-c459-43bc-bad3-424d3b7306fc@amd.com>
Date: Mon, 2 Jun 2025 12:00:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
 <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
 <2d3fba88-ed8e-4c3b-8fb4-56633ab0aa08@gmail.com>
 <ced428cb-798e-463e-bdc6-4c01f9562c58@gmail.com>
 <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <5eab610e-26d0-4dd3-b46d-e61fa44364c2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: f602ae90-0566-45f0-0a3c-08dda1bc4716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aThBaVhMZW5Iamt5Z0t1ZklSYytqcmJ3VitwTGJyMk5rOStVcWQ5QVJIT0VO?=
 =?utf-8?B?SCtsQllQY0NxSENJOHM5dFJ3K29hOUozYWpQL1ZKdUFXR0hHK1NWRVJOckt2?=
 =?utf-8?B?U1B3OUlNSXVjNFdOVDdoVE5LM1l3YWhtdUk0bHNaWHNHWVJPajhhNXBHeXJ2?=
 =?utf-8?B?Z1pOYStDd0sza3BseTZrdGRtRUVsUnNXdGlJZm55aHhPSEc0TGR4R2pWekds?=
 =?utf-8?B?STZTRTJJVXlVTy92S0tIRG9KR2tBR0huN0RxTzlsNktUWTFhSk1FRTFQdm5a?=
 =?utf-8?B?ZXVPdFlWSWh6WWJobC8rQ1paKzVjNTZTSTBFbnNMeWdWdFBtdlpxTHMvNFQ2?=
 =?utf-8?B?OFlNY1VOMU9PbzUrUzV4LzF3TlRQOHNTRGlxYS90ekE3ekgyWHplUnB1bVdF?=
 =?utf-8?B?RHczTkd6NEV5NitReDBsb0Z0ek9CUWFBMSt1ZTF0ZWxTWXhsTk8vVzY1dEEz?=
 =?utf-8?B?NW1DL2J5TWtZcUU1dGp4NjRzd2dTZXdCeldzMlhTVVhLQVV2ZGRGQmVFaEJB?=
 =?utf-8?B?WGp4bUlmY2czVUkzTk5NaXNJSkd5M01UNlV1SkpCMkR0c1NQaGRaMTN2OGRV?=
 =?utf-8?B?aHJyMnZhdlVyK3NNQVJTejA0aDEwWFBNY3RROWlNKzQ5ZVVRUzNydlV5Ym1J?=
 =?utf-8?B?TXJLVk9CTFluR25DRCtYd2VVeEtPMS9mL3ZBSDN4TGRNRVkrTzhZQ0hvakN4?=
 =?utf-8?B?YXRxZmZLZkR3Q292YmwwWWtwTVFpVUNzWjNJSUwwZmIxUGFRTUFpR0NWc2lu?=
 =?utf-8?B?SS9zRm5SZHVOaDlNeVZSU29FYVNzamxpQWt6aWY5Z3BuYy9rM2J2bWJFeG9K?=
 =?utf-8?B?SXArdnByUmdLS3dKemhpWlMrRkNNbnVYVVdFWE9aRHlXazFIUGpmTCtzdnhu?=
 =?utf-8?B?ak8wN1MyZGljOUZxek5rRGc5aW9nTk1vazJ0VzdFL2h1NC81TGxSWEJQaHVl?=
 =?utf-8?B?SUZKTThvV20wWTVYTk5LaWJGZXpqZTVzeFZxdHJESVE3SzFsV05KQVQxczNS?=
 =?utf-8?B?dXpZWitOUUtSbCtha2VQTXJxZ0JMS1lYRTZXTWFLQVlKMWYyV0c0Z09UWUxX?=
 =?utf-8?B?aE5CemYreWt4bWRENlhBYWN1TXFZbG9od1ZDdms1OTliand0ZTlZeHNnclNH?=
 =?utf-8?B?NldCV3ZVYmhFZmpxOEZlY21OTnhxRkZueHZIVWVwZUpQMnlPODZIQWZSMkZG?=
 =?utf-8?B?bjRlN0FnRTJxZG9CYmpsYzRJUG9uM05lVEJTNUF1MGFaUlhSaURsTG45ODZk?=
 =?utf-8?B?QmF1T1F1TWt1T0cvOS9jelJBQmlLTUJiR0puRjJyWno2RWdndGhheWRzK2lY?=
 =?utf-8?B?UGZGQW1EN1V5dHJhUG1sUTIvdXFjQ2REN0lEZkU2Wi9PbzhzcjR2Q093OC9R?=
 =?utf-8?B?QThQRDFBMEgwSnF2N0QwMm1tYWo1S2t6NGZrN1RESUowYlB0bkdNRmZ2Qmta?=
 =?utf-8?B?TFNoUUN3bThEKzIvSis4MzBsOG5IYU9IblJObmtPYS9Ddm0ySThlbUI3d01h?=
 =?utf-8?B?QVE1Zm9kNWN2bi8wQUhFNGZleVBKbysxUUVYY0E0dkxEc1pYclh0cXVaT1BV?=
 =?utf-8?B?RjBsNzlmcDYzOURCaThBV094c2xYdkJMaWpGQ0dnejFYREpIcG9EK1grQndL?=
 =?utf-8?B?Z0R1UURITEFrbWtxSTdoMzJYek9US3ozd1pGbkk2Yy9PVkNDeCtoSmtrSmM1?=
 =?utf-8?B?K1JTMVFxYjJGVHdpcURnZ0Ura2RMZGpxLy9ZQjB4SHVEcXgxV1dXQUpENGNw?=
 =?utf-8?B?QnFjREJSTFdUUnd5aG9WeWdsakxxd1V1T3RYZmFHQVVFYm9BcUh0Uzc4OENV?=
 =?utf-8?B?OVNZTzVaT2FFNU1kRmU0SUE4RFdNYUlxYTNhSDFZRkhhbUtkS0VNVlJ4R3Va?=
 =?utf-8?B?bmVFV042NlB1clVzYXBPQjlJaUE0SUxMdGNVUDhtQzdtYXdodVlleVNZSkgr?=
 =?utf-8?Q?/01pEBwnUZA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHBmTE92U0YrTHpIYjdNKzJ0eGNlMzlmdkdTOEdhTjh5OXM3NUdSV1ZSZ0t6?=
 =?utf-8?B?UU40ajRsRWZSeWwzS3BXVi9YVjkxQm0vMG9mcW5mU2FVZFFaTjFrQUQ1OXUx?=
 =?utf-8?B?cDR5bDV1cWdieVBqaUtZYy8xMzUzR3UwYzZvS2k2bXEyaGtEeDl5d3F2ZzlY?=
 =?utf-8?B?d1FMY3BsdEU2TlcxcTBId3VhcStQQmlGcnJIZmpYdU5zS09tNHE0b0pYVlRR?=
 =?utf-8?B?R2kvNjNFbXZaT1h2alZQeEMvM0F3YWI2N2pRSUJZOWZmL2lVQjM1RlZBbHFu?=
 =?utf-8?B?b3NXUkVXMVdNOXNraGdOL29tOGRJRExFVDIwUS9rVDYrZnh3TkRJdjgrWFJE?=
 =?utf-8?B?ZVhBTHFaL2VkNGczclZ3Q2lZdFBrejlsTTRkREpUM0c0UVRmQTBMMFdrVW41?=
 =?utf-8?B?bmIrSmgvMEM3ZHArcG1zdDR1TzFVMEUyMThueUY4aW8rTkJNTFZmZTE4R0Qv?=
 =?utf-8?B?QjJoT0ZwUkhlRU1oTERMMHJIYzFqTkdMMlUrZ21aT0V6eVQ0WU9BdC91SEtj?=
 =?utf-8?B?SU5Od2Jid093TmtxaEZKVmh6QnE4MnJxZElpNXNyS1V6OWx1TGJObFpnZ2Ew?=
 =?utf-8?B?QnNKaFJJZWFpcVBab2JrbXNXam10MFpxZEc4dUh4bGZIU2ViV0hpSG9yZjNh?=
 =?utf-8?B?QVoyeXBrZFNqNGRuNkl0ZERVWUsxVmtDRTdod3FzUW9lWUpHTElOSVNMU25R?=
 =?utf-8?B?MVZsbWFZS2I4Sk1VSWZ1eUd4QTVraXlDSnpQcHl6OHNDNlU1dW8xVDZ4ZzBx?=
 =?utf-8?B?aWlwY0tueVBTQkc3NlZFL2pKajJXMmk2TEpBZHhndks2emlKSkVkTjRPenMw?=
 =?utf-8?B?MmdWTytqWjVTRXpYb2RQSkRyYnRzRVU3Tzc5S3pBY3hnNkFaaGNJdFdjQTlE?=
 =?utf-8?B?VVBRZndpVmlKcWZoNmNiU2ZjWXBlWVBDRDFJbXZIeHFselZDTjZYQVdWSGlO?=
 =?utf-8?B?R3dZQUJpNUNDeW40Ris3Mld4OE5GWU9QbDlNcU84dzI2eWZ3bkVUVUZmRTdp?=
 =?utf-8?B?UVdRUTkvOEFwTjNOaWZMT21aQUtndmdjZHdrS0ZJZk5WMmJUcjhFZytrU21i?=
 =?utf-8?B?WnRTdmxuYTB6cFhHU2hvVzlQZU5VMnhpcGdJbnUvNE5LOTRnblNFNWdIN0Jq?=
 =?utf-8?B?cE50dDF3bjVsTGtOVURtVGY2MWFYNHZJNDdCM1AvMVcyQU9PbzhnaXM5ZmFD?=
 =?utf-8?B?eHB6WlhWOU1Mc3UyQTdQM20yNU81TmNnVFhjSGtQcGhDNDA3RVlPaWJiYWNX?=
 =?utf-8?B?QlpQWDNBdEMyVXMyVklwNE5Fby9BazRSQm5kTWIxdUNlOXFCejVCenROWVNl?=
 =?utf-8?B?VDhTc1JJYzBzdlVXM05idkVyb2d3RHFqR053c0VGSHRzOUdVQ0JZdVVEODM4?=
 =?utf-8?B?dXRBaXNZTjJxQk5DUGpMM3pHQ2FwOWRoN3AvTXYyaWMxS0ZCVFI5NmpaUlBV?=
 =?utf-8?B?ZmpHeDhRWFBWTmZoM1VzcTlEK2VjcXIwZ05PTzM3ZW9GYU5JWWdQZndTTmh5?=
 =?utf-8?B?QkxROTJxQllGa3NOSCtRZm1XNklQWC9Kbnd2Vm5WaDFQUlVPdU1hc0N6dDc2?=
 =?utf-8?B?anFiUGJiM0JKUHlVWXRCN0R5Rk51RHpnMWRlSldRSHV0NklxTldxd0NWaEVu?=
 =?utf-8?B?bzZTT3lXYXArUHRqcWF2Uk9xaEZDc3JaNTRuZVh0c1BRWEEwUEQ5cE5sa2NG?=
 =?utf-8?B?QmtCMGZJUEJIeFc0TXZucHlpZFB4Z1AwWjJsa0tBL25ZSno1YUVObWdYcTMy?=
 =?utf-8?B?bzcxbjlZeWpjVlpENWFPb0tYNmJlMm9yZ1A3NXV2c3VSbTFJd05PQnIrSHZN?=
 =?utf-8?B?NmpSR21LMUU2WmNRVUZLbW5iK1pWS3FYNGlHbGhiR3htdWtRQ0F2b1p4Nmpt?=
 =?utf-8?B?emtiV1lIK1NiN1hFVE8raDEwcFFBbWIraFl5QWdYMklFSDBkK05WYmMxQjBO?=
 =?utf-8?B?bElkRW9mUFpmeFRnejM1RTlHdGkyWjVTSDdSWjF3TjU5cExUak1VTEhOWWxI?=
 =?utf-8?B?eXFXa1FQbzJsK2xwSU1VUmp1NWRiZjJRK0lybzJsQ2V0R0k2OXpUakZublI3?=
 =?utf-8?B?MjUxaTdvSHp6Zk5TYUpMUWxRRU83bzlrVlBtaFVIVHc3VG5kbFVFMlJhTUEw?=
 =?utf-8?Q?gL80=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f602ae90-0566-45f0-0a3c-08dda1bc4716
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:00:17.6873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nnKXpv+e0p0pXC1dOfqvBpE/IHIimZ2lP99IqMYXLrZrhY4tlRAoa9z4OzISpDcj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

Hi John,

first of all thanks a lot for taking a look into this.

>> Okay, I did a read and compare after each write.
>>
>> Both writes seem to go through on both the Kaveri and s9150:
>>
>> Kaveri (512MB UMA Buffer):
>> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF41FA00000, addr=0x00000001, wrote 0x00001001, read 0x00001001 [same]
>> amdgpu 0000:00:01.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF41FA00000, addr=0x000000F4, wrote 0x800900F4, read 0x800900F4 [same]
>>
>> s9150:
>> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_ADDR_EXT: gpu_addr=0xF7FFA00000, addr=0x0000000F, wrote 0x0000F00F, read 0x0000F00F [same]
>> amdgpu 0000:41:00.0: amdgpu: [drm] uvd_v4_2_mc_resume: mmUVD_LMI_EXT40_ADDR: gpu_addr=0xF7FFA00000, addr=0x000000F7, wrote 0x800900F7, read 0x800900F7 [same]
>>
> 
> I've also confirmed the patch works fine when segments other than
> [0, 256M) are used.
>  
> E.g.: Both init and VA-API playback work fine with a UVD segment of
> [1792M, 2048M) on Kaveri with a 2G UMA buffer.

Oh, that's a very interesting find. Could you try to turn around the way the patch works?

E.g. instead of forcing the UVD FW into the first segment, change amdgpu_uvd_force_into_uvd_segment() so that the BOs are forced into the same segment as the UVD firmware.

That would resolve my concern that this could overload the first segment. The feedback and message BO are usually rather small (4 or 128k IIRC), but the firmware is a couple of megabytes in size.

When we have other FW and VGA emulation buffers in the first segment as well then that could result into clashing that segment to much.

Thanks,
Christian.

>>>> I will try to find a Kaveri system which is still working to reproduce the issue.

I unfortunately couldn't find a working box of hand. Would need to search in our HW stash for a box which still works and get that shipped to me.

And that is overhead for this issue I would rather like to avoid.

So if you can come up with a simpler patch which works for you I'm happy to take that.

Regards,
Christian.
