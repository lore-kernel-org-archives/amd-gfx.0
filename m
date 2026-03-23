Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4872DEC01B1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E029910E43E;
	Mon, 23 Mar 2026 09:54:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UcaHkUOT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC08F10E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:54:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dahZ45mLVCBrlW6jtt736xSEmtvPpmyQKeke0o1n2UMjFJFGgSrIMUe6LokxrfYAhEmYFtXKXbphjLMzVDpTNDd6s3TDtaBYhpBAhp8d8EDdSW8f4V1BXfCPihruefIs57D/pEcS+usSkNH4ZFm7VNg08r3cP0TCObR1KmJQXV+qpYYbzXmoW74I5Nfz7yzG8Ukd3YopN5xDJbtrD5w6vQl/vdhZ+oLM6vJe714v4J6TBwjEoFblv/qU2+9EtL002AgsTj5Q6yePjegX7FjkATOC36pXWbHowetPIZnHOnrF08HGj0hgNq8TwnIAj+KHpxGqR3bLgAsJBGtAK+UeVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkJ1QwGT1s4GOhYPHyZlVbLAEYhoIKkFFMd4YibE2M8=;
 b=jqpZbXyc3ZnizJjJaYSG6hhw2I1rf2obv6w0RtLBe2b+m6ZINuHu3rtRw33NqBCtTXl346b/W581gFQCmjOU1HbUKaymWZAS9D6urIBVYU8qLPZaRoXELUWHR5Ixsy2PArwZlNmbEPaM7EeZ3++g4DztUoib5mTXlaZ6YdJfqmTrvXgcDvdiMzb6cWMzn2hQF3QJOAh3OuHDnyq68y7UxTvsMILYhywVZCuFyMbCknnBTEIfKirPAHSSZ4pEPzkmNEgAb9Eh8KlaPx8Alza1TgAY3hewbN9lF++tz5NFSYSuG4NMnk3bUwV/DptDX+/3oTcb8141sX/b/7e0N6ul4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkJ1QwGT1s4GOhYPHyZlVbLAEYhoIKkFFMd4YibE2M8=;
 b=UcaHkUOTVqEPUOVTi+4fo4iCJYKVB2Xds9csq1Fb7qtgr1xhWWh2hIy0A0Yak/yIUPKgmokrdciNDXiuNIgeKoELanKRAIVG6xRnEb9j6YAuduxz4hJrONU/U4E8f6Oc5Gj7UHkgsFCyzygN6s9AhsAiz76QeSxEwc6BEps0qXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:54:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:54:21 +0000
Message-ID: <1b28c112-c9c5-417d-b9e7-088100cbd22d@amd.com>
Date: Mon, 23 Mar 2026 10:54:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix the idr allocation flags
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, jinhuieric.huang@amd.com
References: <20260323083923.3348059-1-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323083923.3348059-1-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b6e73e-c2cc-422d-85aa-08de88c22856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: TwsUhLcBS3BdvMTgnrRVutu1GammQE77AAsPeDHJJN/d+QedEaf1UIAHm+8WK0FtgJt4H+bTiG8zhVAIf6iHHlhmn+q54SuJql04j6tZ6lSwaCQNTxObzwyvydy59RUm+5vPP0GNNCawS93YcVRRI/m27Hm+Mlz3qJbrnrg23jmN7u/2DPdilJWywBKOknYjkiYG873Wbdg10Zzd1RkLcUK2d5LDsRHebywHu0TH/AzQpA3VwlC/UeMt09wb6H9qsHrE+CZP8PV58ZQOBBKsq68yRIPXGzpEiOZW8sb1/8MFVbL2GCAXQHwshExJen8G5VTbrQViiB8AUQhHGuKkr5Nj7QDj/lsZkJ+2yNSy+RNlaJeTUjpCRqcRw/MThXvIifcrIqh7f/AGopqMWSgl25KD9tK+5I+v64p7VxFmyO3GDHpuOgnvqSC64aX7YQDjGnsRzEIQYB8Z1pyI1yjhcB0Z8Joh5R+3TnG4Inwp8Eb8DQc78hF7gJKAWh2H/NAyt/yz8q64uSUPduwPHP+GCCGD3kKXP7eccUY/UTQH5FDhrRwvqQ60VmiShai4eMGDjwv+i9twRTSs4pSNt9PztAhH63BeDdV0E8Qa3tLtLggcHkj929xXU6hz2whqHrEHTrL8tyQP7LI2DCgvDR2faIS1KaQsrvY8XsbnDWJJ+TGaVWVkIPJTS8PPbRt7hSPL/S25uUzV7iwTtRVUDlkLCq9dGJmbp1CyYJFBZibpi2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0FTT0pXSDY2aUo1a3NQOHE2MmFOVk5ZVGtnL0lpL0ZpbW1SaGJEbDZ0aWxM?=
 =?utf-8?B?Ykt5WTUrSndqSUxLVDNsRVlHMTQzSlhTcDRxaDhWUXN3VjZMMlhIMEE2d2ZV?=
 =?utf-8?B?cWdhWldGUzN6VG9EcVhLUDhOZEhwWjNRc0tDcWNGSVRYRVU0UXBldmNNTm9O?=
 =?utf-8?B?cDExM0RmRW9GVVdZTzRRS1lVcFEzREVvMU41a2JsQmx6eCtqblB5bU5QQy9J?=
 =?utf-8?B?ODN0RTdoVXBwcC9MMzIyYW5VNFJhUmNGY0pGSTRVQ0dpdTg1TXVrR3ZjaG1m?=
 =?utf-8?B?bkZmK0d3Z0lVZnFWN2RqMDRZZllsQWZwWUFHZXFsVVZuUkc3cmpscW90NGph?=
 =?utf-8?B?TDJYTnVXQnRJbTd0UXZ0RkVSbG5Hd3ZucXBiNkkvK1E3MVJpc084QVBqNnZX?=
 =?utf-8?B?NTBYY0VMNlk3SjZUL1FyMU0vOUFVS01UTXBTcGhETzFFY0IrNDg2Z1RzUmRy?=
 =?utf-8?B?aXRoeVZXSlorZzBqZ1VQN2Y2ZG1mRDduWnFRSk5kSUF6QnFsT1VLQ3NzZ0hi?=
 =?utf-8?B?SjRlQTFLWThhVUVmR0tEcS92SDk3d1ljNTB3M3V4VnJQcVdtdll5bHJqeWx3?=
 =?utf-8?B?MGVsaVg2cjZFcmZnN2RDNEQzRkxOWXZEald3RCtnVWtacFJzZWVkSHpxTDVR?=
 =?utf-8?B?aXk0TGxSOEVaaVFDNm81ZWlxR3FKdHY0b1VOcUlDbCs3dGlTMlVqMkJjNitS?=
 =?utf-8?B?TEtscFB5MlpNVU5mWmtRQmhrZjIxblJCZUtVY21La2xJZktDK2VjOEQ0UGtB?=
 =?utf-8?B?WjdsejJBeDFvdWdJVW9iWHo4aTVhdGVoaTJFVDlkN1VwajlXZy82MWhXenZw?=
 =?utf-8?B?bkZleUVDV0NNU2U5RVB6VGUxUGczSW1tcmN1dnJUUWdyREg5YXpaejVYZkJX?=
 =?utf-8?B?dVh3UW9VUzFTYi96Y2JwbW92MWtWMElDaDFkaGxjTlcxbWRoVWxHYTV6c2hp?=
 =?utf-8?B?cWgxZ3hnam9LMm9HSWdxcFlhU2xEd2lTZ3lHUTJqV0JGdHNkQTVNTWlrcjdT?=
 =?utf-8?B?empwclU2Q1dVQll2SG1kcUpISjIweVdKUUZqUHljK3VMQTdhR3NFRktRWExU?=
 =?utf-8?B?TWh2ODQ3TnFtckpMU0lDbWRGNndKSUtiWGo2Nm9YSW5OZkFZVDhHNjVsRnhN?=
 =?utf-8?B?Ync5TkNoRTNZc0EvQk5SbUJ1T3FNNVNjQ285eE00eHJHVGJvTEozTS9LL3lC?=
 =?utf-8?B?bVltd2tBNjk0dEtFZHdBOTZUS05YdFhXS1liYmZ4NEt3WXJlUWwrRWJtZGhu?=
 =?utf-8?B?OXFJSGo1OHk1aGFNaFp0VkhtdjUxNlluMDNNME9oVzRwR2laYkVuYjNUcStX?=
 =?utf-8?B?enZnQ0JEWUc5SmJpb2xKb2FUdGFaU0NISmpJL1ZLeWVhOExvaTBRRzdaenZp?=
 =?utf-8?B?SC9WN1FGd1RTQ0x3Wk55Y3g0dy9GSFE1SGpDTmFzSkt4Rmdqbm92L0R5TVAw?=
 =?utf-8?B?czdQZXRMSjBOVjlTV1AzeTZudXdRMWo3QXZkekVnT1NaRVVZdVNkOThNQ24z?=
 =?utf-8?B?VkNsdmhZYkgzdjZWM0tueTV4Z3pLSCswNThwbzh6eG5wbVJ4ZWk1d0hPZ0sw?=
 =?utf-8?B?ajNUYnZyVDZ1d2Nudm50eUhib1l5eE02WG8yUFhLeFBTeFV6ZjJmRUI0Y1RU?=
 =?utf-8?B?YkVJOTliN2tEejB0NnlkZmVDdjhuc0FuSkZOZVdmUFRyN3JqdXAvbGh1RkYw?=
 =?utf-8?B?RE1mSjZOR2tXUGRKSkY0L3dYZDZ1czR2elJwWmlLdWNnVytRZFBSUm1WVFFj?=
 =?utf-8?B?VklKK0h2WCtYNXY2ZEUvblA1WDdEZWpWSDErZ1o1QVpvU1VBYy9FK2N3UjBQ?=
 =?utf-8?B?UjQ2Sk9DcExJK3J1bDR5ajl2VjFPY0VsMm9sOGxuWFlNV1BBSHYzUnluOTE5?=
 =?utf-8?B?SS9Xdlhsd1YvQ01LcDBZNkFRVXZldFI3bnF6SU02elhnTmhnRFJDVjhRRnlY?=
 =?utf-8?B?bksrMlE2K3BjVW5KWUhiT2JxZjZzcnpJejRGYUpJRmRoYVJYNXY0dzZoWGtt?=
 =?utf-8?B?WS9WS3dYWlNha0RTQ3VyV1VuRTRnZW9vWWNNQjBYU0tlQlNqRDZqZnR5TS9u?=
 =?utf-8?B?SjBqTHZHMHozV01RSis1NDk0cGlvWGhla0piSDlpZ0oxQmM3NURnVmdBZi9W?=
 =?utf-8?B?VTIzR1N5VEpQVHorWkRGZG9URHNsTk1uL2JIZUQ2ZzVkbFlTV1BtOXJiRUph?=
 =?utf-8?B?V0RKbWhGbVNSQ2NEWmc2aS9RaDZhZHQ2czV3UnQwcFhURHlqb1psajUwZ2R6?=
 =?utf-8?B?eG0wODRFUVU1SVVwblFiRlc5Vk1FUThsbmt3OUxFREgrVzlvbTY4L3I4bGZv?=
 =?utf-8?Q?48tuMakt788Elb2DVo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b6e73e-c2cc-422d-85aa-08de88c22856
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:54:21.6143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWu6rCXjJIROhg9WoYMz/BZktlM2AljltY7Bp/SWGpXOUevpC667OuL5X1jsR/Cz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
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



On 3/23/26 09:39, Prike Liang wrote:
> Fix the IDR allocation flags by using atomic GFP
> flags in non‑sleepable contexts to avoid the __might_sleep()
> complaint.
> 
>   268.290239] [drm] Initialized amdgpu 3.64.0 for 0000:03:00.0 on minor 0
> [  268.294900] BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
> [  268.295355] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1744, name: modprobe
> [  268.295705] preempt_count: 1, expected: 0
> [  268.295886] RCU nest depth: 0, expected: 0
> [  268.296072] 2 locks held by modprobe/1744:
> [  268.296077]  #0: ffff8c3a44abd1b8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xe4/0x210
> [  268.296100]  #1: ffffffffc1a6ea78 (amdgpu_pasid_idr_lock){+.+.}-{3:3}, at: amdgpu_pasid_alloc+0x26/0xe0 [amdgpu]
> [  268.296494] CPU: 12 UID: 0 PID: 1744 Comm: modprobe Tainted: G     U     OE       6.19.0-custom #16 PREEMPT(voluntary)
> [  268.296498] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  268.296499] Hardware name: AMD Majolica-RN/Majolica-RN, BIOS RMJ1009A 06/13/2021
> [  268.296501] Call Trace:
> 
> Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 644e413a4e69..2f552352e046 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -69,7 +69,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  
>  	spin_lock(&amdgpu_pasid_idr_lock);
>  	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> +				 1U << bits, GFP_ATOMIC);

We should avoid using GFP_ATOMIC here and rather replace the spinlock with a mutex.

Regards,
Christian.

>  	spin_unlock(&amdgpu_pasid_idr_lock);
>  
>  	if (pasid >= 0)

