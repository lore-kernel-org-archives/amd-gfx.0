Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15606C25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 16:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482C310E380;
	Thu, 23 May 2024 16:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hJvn8G4a";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F027D10E380
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 16:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKJo5gLbZY6H5NnhD/hLHFquv2b4oZ1NunPht6Etyu/kwXC/JwTeeVcXJULpeEMo0AIMXv0T2D1/56vUkvwNbPha2WxeqaZdjtDNK7YI3Er+Ft+db86aErJ4Zw6uAlgq+HFcAVp1OILpNMehWrVNdwqHMPtq/yIBPkmtjIdMS3crHu3lRMdos/HmTCzARwkx9PMgKlV4xAqkzZxNnHbpvGywJJ/6p8d9trCnkF9stI9tbKyvuIIWq3+x/lKoKKEq+MuVigUDF6+KvtIdpJfLkwNEBElZcXJqeIIeojCph0tlTgT0LvUXaS6+wZm+dm55DsPrB8KYVQ43eZOvFXpabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtZD0TyRMimD9GRVIw7Y8DF40k5w43ZrZhKBwtcmwV4=;
 b=iXbW6oldNtDpylZkCgme9UbY7CcYxft73TQE4kKqKBvdVNTyUftP9flnvGlQ9y+EabDk0zTOUIhv/cOD5HqhCNgy8IYsuD5Gt+QlLgIZ8bUAZs+1XN255S/S8D1HRJ9ycWfcPU6Aw/q6NfW8KKVYFP2FCky7qoa3CQm8zeWwU69yU1HsWTS+dKiAapu0z7OA9iRuIG7GoBmHWYeu/xradjxhKgpPcALKC+bYGBokufBOC6D7bQIFNbov38dEmJD4XgQiUvp3J7VP0y2DmzDZANsY8G6BcJOG/CSNK6jtXk0O712bpB8IK/Jcw0S1uJ/ADrngai44JvsqibNmYrH2xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtZD0TyRMimD9GRVIw7Y8DF40k5w43ZrZhKBwtcmwV4=;
 b=hJvn8G4aSIa79rndlfvI2KPI6WobLQwWi+oX/wHzZiKc7zZ7/xvRTO+R4CMPfG3oM9maffSKJOLaFMDq3N4MmulOjXx5phY/EhGrLMQFziESCmZ3Jg+H6B3ormKm3mHQZw0Erq4SbroGFzF/qv6mQ91s/pkYzEUz5myq+t/U4Hk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 16:54:47 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 16:54:46 +0000
Message-ID: <47f0ac94-d6cb-4632-9960-0f94832857be@amd.com>
Date: Thu, 23 May 2024 12:54:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
To: "Dong, Ruijing" <Ruijing.Dong@amd.com>, "Wu, David" <David.Wu3@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny" <Sonny.Jiang@amd.com>
References: <20240523150439.3274992-1-David.Wu3@amd.com>
 <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <SJ1PR12MB6194DBE65CF492DA12ED5BE795F42@SJ1PR12MB6194.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c6af47-7c9d-4d23-d1a9-08dc7b490d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFFJNFAxKzUyb3NTRzhYcFozZys1dWIzYUN4ZnplQVBKSDdWd0VBVm11bXFP?=
 =?utf-8?B?Yi9maXBBMUQ2eTJhR2FROUJVcnFKSnBCbWlvVlNJa05BNzJnTkxsNC9GRFBr?=
 =?utf-8?B?enE0NlJtZzFRd2V4WnFkR0gxZjJYMFZhTzVyNjRUY2lUOEhZME02VE56YnVK?=
 =?utf-8?B?TWQ3Q00wUzdWNGplVVZOaGprSWFJa2NjQkN3ZGdmek0rOWgxcTRWOHdVUzhO?=
 =?utf-8?B?Qllac2pWdnRQbFJnWjlIT1hKVlZKWmU3Y3g4V2QrenNXcXIwcktQWEozK0hr?=
 =?utf-8?B?bmhrVkJRT0oycEQzTHArRW9Cc05LTFFoNERTZW03eHpMdmNRclh1WEhaTmdn?=
 =?utf-8?B?U255bjBLdUZ3YmtoSUlOeGhXa3c0OXJuQUhFYnJXM0hRaUpoUmgyM0pRYXkx?=
 =?utf-8?B?eEpEc3VZdEg3NHpkck5QZm9ibUgzd3pmZ09Wb1lBRE1yc0dpbFAyY2IwRlB2?=
 =?utf-8?B?NG9yQko5RlpwWmtLU2M0K3ZRSVgrMk1HcjZUSTBWdmZxci9aWTNkM3Q3VTBZ?=
 =?utf-8?B?amgrKzNLNGtnNWF1RExHMHZlYUp6eG85K1VqTWt0bHdsd3VTOVhCWXM3TXJU?=
 =?utf-8?B?b1ZQTSt1THRzbjA4ZDJaTE9VSUJQQ1JCMDlHYUVHQjZkOHVaMjVKNnVjdXFM?=
 =?utf-8?B?RGNZQXFTZDdiWVVzSVhRcUp2YjB6Mmt3cVQ0SWltUGtMSXg0NkNyRHJFQWhv?=
 =?utf-8?B?SEpDWDBjRDBsWG9pOE12VEUxQ05odk51QVdtOHZqYWZVM01GS25BL21UWENP?=
 =?utf-8?B?c3BUSVdNc2lWczB0bUhBZGtXdFpkbG5hTnFPajNVRnVNKzVSaUErdGNmTnU0?=
 =?utf-8?B?ZjYxMWJxNWhEcEp6aWRvWTJLd25wNVNoZlZTQTkyU0hmcGxNWm0zblZpZ3RE?=
 =?utf-8?B?d2xFVjBlcGhRRDRPNHZFNTZ5ZUdsS0wrVW5xb2JsWk1vOGQra1IzUkpENlJt?=
 =?utf-8?B?eWoyaFlhYW5jTEY3NmJWcVlUYUR6STkzam1nbEpXM3BPZWZuTFZrOENibFNq?=
 =?utf-8?B?STZnZC9CeWF3YVJ2SjE0NHVHTFluNThYQWhmNE10M1pQZWdra1hOelhXT2xP?=
 =?utf-8?B?MjlZKzU0RFUrSklGVVd3TGlBRzRSQXBrN09JaE5VV0tOb0ZMK3ZDQ2k2bitC?=
 =?utf-8?B?ZzJPcXlVTTh3T1lkejN1dkw2aHBISy9EaVVZUjlwbm1EQXZxRHhpYUpvS3Fs?=
 =?utf-8?B?dWtCMkk0SmViSWlQbGxMWWFHdUFxTHdhN0NuQTJUaUdoZnJEemYxZjNnME0w?=
 =?utf-8?B?c1psNS9zRkg2TUNxb1ArQkNWT2k3amtHWFJtS0NpL0s2eSt3NytBcGZJcXlN?=
 =?utf-8?B?a2E2aGtyUmVRUGU1aXJMOTd4Q0RjckY4NlROSExtREpCY2lJRVJXdjFwejFp?=
 =?utf-8?B?NEthb3k2MXdDalNxUTBEVlA1Zi9IOW9kdi8vck41Qi9wQm0wWTdXMlpqbkY4?=
 =?utf-8?B?R2pnR0drVGhkNjY4WTQwMVFCdlVMN29JeHJKUVJwYS82Sm9Iblk2aDNPSnV2?=
 =?utf-8?B?Ykp2N0FySVdoUzBEdEZkZm5vSXdxaW80MW4vRU9XRHUzZ2pGL3ExU1poUVFr?=
 =?utf-8?B?akZ3TXVENCtBUWZmai9NTCs2UFNaeWFEQ2VqZHljMGdMNm5XTmltRjNsQzJD?=
 =?utf-8?B?NkFhTUk4STdNMXBHMElVajAzS28wYjJlQkVzVFFoWUFuQ3NNSnZFZ0V6OWM5?=
 =?utf-8?B?SFJSY1h0dVUwa2NMbVA0NFRobGhGVzBlUy9uaXlLNDh0SHZSVGxUMGlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHdwRHg3OVI2R2grOSs3N0llRGRTOEZJZWxUV0loL29Xa1NxWUpxUzlzNFFH?=
 =?utf-8?B?cTRjdm5rQ1ZGTGlTMm13SXVrMTloVnRWQkxMWlNNSTJ6UGNkUlYvclN6bHc2?=
 =?utf-8?B?Mk1YZDF2S2JEYVEyUm41SlV6ZDNlbFNRRzhZeWx5MWFHNDZhQnRmaVdWVysz?=
 =?utf-8?B?c3RRTlcwNWw1c1NqUjdNU2RMbkg0c3owa1JvcWV4c2tYWjhxck1ETkh0UE9T?=
 =?utf-8?B?S3k2akRyb0NKK1Z5SkNUcGZEaG80MFZaN2ZIVno1b3JYUWpHTnZ6cTR1Tk96?=
 =?utf-8?B?bjFVLzZNOWE0MWFoelYwN0VyaE5zZE5TKzNpNFU2eEV1VE9ENUtYYzNld1ho?=
 =?utf-8?B?dmE4aytTbW02L3JVZHBzc0dmaWwzK05PT2RjNllKRnViT0NMSWNCcHoydWNR?=
 =?utf-8?B?c3MzWTQwK2d2dXVMdm9zc0x5dUJjMnFhUXNMazB6NjBPbnVTSy81WFNidXFz?=
 =?utf-8?B?UjUza0lmUXVtZFJTN2NMdVNCSzhWZVZoRFFjWlNEWkljSWcrVlFVNzkwcXRH?=
 =?utf-8?B?OGdhRnEwZXh0REZyeDZSaXZtTFVxSWY0Y1QyYnMwekFjTnBzc28xVk9jcEFu?=
 =?utf-8?B?SGx3dUd5ZE5jcVlySlhESGRmZDNLL21hTm4vbGZBNTR0b055OERnNGE2c2xC?=
 =?utf-8?B?amMwcDdDdW00bGRkbExQUXdadlNpYVMxNjBSdjBpaFBrMGl0MUlNVVZRdDg4?=
 =?utf-8?B?aERlUmk2cEUxQWEzMjU0L3VOYjRIdHovaHZCOXppYkk1NE5XMGJwWlllS1oy?=
 =?utf-8?B?SS9VYmhmVytyOVZrYldlMWs0M0ZGd1JtYnE0d3FMR0h3VUE2ODVyZW8vK3hV?=
 =?utf-8?B?VFZhcDZSWkI3Q05wak42TExPUTByYmR0dFora2hlWlc4TVA0TDRiSGYzSTRm?=
 =?utf-8?B?MjVjR1JFUWZOTEZkYm9ObkZoRlFZRXFxUGxEVHpBdkhVcWI4c1M2U0pOTEd2?=
 =?utf-8?B?UnVhaXlveGZWZ3NQU1llUUZpaDlGZGRuL2JZdXI0UVZyLy9yTTVnK1pLdjFZ?=
 =?utf-8?B?SFZIOGFkNUk3cTRvWE93TzBpaU5kZlI1RlJvTE5vbk9lQlFFK3QycExJOFdx?=
 =?utf-8?B?SGJQYTE4ZENNUWxiZWRhUTgrQjNJcFNHK1VzMHpING1YZE5qc1lCKy9FZTFX?=
 =?utf-8?B?dmFva0VPTU9wTDMycGk2aktMdEE3cmN1NnBpLy80citXVWhGTFBpT1Y1bmhT?=
 =?utf-8?B?a0x2cTN3RC9UUFpDUGV4TW50Z1IwY2FydlIyZUNFaU1vU0RLVWt5U2JNNEtE?=
 =?utf-8?B?ZXBuTTZUQWw0VXh4SHo0NnFZU0tzc0VhRXhXN1NPVVJSdTFQMFAwelRGcFM2?=
 =?utf-8?B?cEFoQW53NGd4c25zNUVzSE5MRW1nYkpiaFRjMGp6clBFMUI1U0kzZjFmWlBo?=
 =?utf-8?B?UzczdXArNmNTWHJ4VXRKYkVxTlM3M09kVCsrVVppdE45eE83RGVIMjVqY0JB?=
 =?utf-8?B?dWJIRTRRbk1KY3hldHB6ZHFHYS9NQW5ZWVBRTDhob2FZUVAwdXVqKzJEU0VM?=
 =?utf-8?B?OEwrMDFnSVp3VWNnOGp4QXA1dXhqQkRkNHhZQWpweW8vTE1RU29jTG1CeWZj?=
 =?utf-8?B?UnorQnZhYVF1WXNWWkJRdTA1dEsyR2l6aTR2bEFSY2xtSU5Sb2NFZDBXSkE5?=
 =?utf-8?B?M01kZzAzWWkxTWIvNmtROStweU16QURsRWZCWU5SWHpYQlVWVW8vaFJhUHNL?=
 =?utf-8?B?QWVIWWZyalJmWllERGZWMEdDVU1BeEoydlJ6YTN5dUUrb2lwVWMrOEZLcnFv?=
 =?utf-8?B?RjFiSHp0ZXByd2NzcUtQUHRWYXJRMmFuVUF2dkQ0YlNuQnBSa3ZvTW9rTTFr?=
 =?utf-8?B?UkRXRGlPUWZTeWRpajJPRE9sWlpzSGZqemtkeEVSMnJicTNWMy8xMXUwRmp1?=
 =?utf-8?B?NCttcHh0VktnMUpKUmR5ZUV0ZWhPSDhRUVVvTWg1MXdRRTA4K09xcjF5QW95?=
 =?utf-8?B?bXVaN0VJUnp5bXFSYXFFNGdHdEpsRWJWOExpTm92WkFyTURxa3ZRRjVGT1lO?=
 =?utf-8?B?dXp5c2ZLT2xnczYzcXpiUzloRFJOZlJ3Q2pWY1VCM05uQWhjMXNsdkVISlFv?=
 =?utf-8?B?V25qWjlVVk1GN0VDNnpianN4NER6a2pPc29wVDBZWHlTVWxxOVVjL2pNcEov?=
 =?utf-8?Q?WnFhV4pIarhCC0SXKCoYQ/sfP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c6af47-7c9d-4d23-d1a9-08dc7b490d1e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 16:54:46.4017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 29XPIhILzoc59Zk7/6h6L2eJvHcBpCUHIgfQwmgO738Ysuk9hj7HJQk4OpaMiKmVA+yih36LrEYN2vA0lV/LyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827
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

please see in line.

On 2024-05-23 12:02, Dong, Ruijing wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Please see my question inline below.
>
> Thanks,
> Ruijing
>
> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Thursday, May 23, 2024 11:05 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny <Sonny.Jiang@amd.com>; Dong, Ruijing <Ruijing.Dong@amd.com>
> Subject: [PATCH] drm/amdgpu: drop some kernel messages in VCN code
>
> We have messages when the VCN fails to initialize and there is no need to report on success.
> Also PSP loading FWs is the default for production.
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  |  1 -  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  3 ---  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  | 10 +---------
>   3 files changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index b89605b400c0..5e2b7c340724 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -1078,7 +1078,6 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
>                              IP_VERSION(4, 0, 3))
>                                  break;
>                  }
> -               dev_info(adev->dev, "Will use PSP to load VCN firmware\n");
>          }
>   }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index 64c856bfe0cb..68ef29bc70e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -145,8 +145,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>          if (r)
>                  return r;
>
> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n");
> -
>          return 0;
>   }
>
> @@ -549,7 +547,6 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)  {
>          adev->jpeg.inst->ring_dec->funcs = &jpeg_v5_0_0_dec_ring_vm_funcs;
> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
>   }
>
>   static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs = { diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 36d4ca645c56..070b56610c7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -200,16 +200,10 @@ static int vcn_v5_0_0_hw_init(void *handle)
>
>                  r = amdgpu_ring_test_helper(ring);
>                  if (r)
> -                       goto done;
> +                       return r;
>          }
>   [Ruijing] Are we assuming the hw init process always be successful?

No - it could fail with errors and in this case the top level will 
report error. Otherwise it will succeed(and no need to report successful 
message).

David

>          return 0;
> -done:
> -       if (!r)
> -               DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
> -                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> -
> -       return r;
>   }
>
>   /**
> @@ -1122,8 +1116,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev)
>
>                  adev->vcn.inst[i].ring_enc[0].funcs = &vcn_v5_0_0_unified_ring_vm_funcs;
>                  adev->vcn.inst[i].ring_enc[0].me = i;
> -
> -               DRM_INFO("VCN(%d) encode/decode are enabled in VM mode\n", i);
>          }
>   }
>
> --
> 2.34.1
>
