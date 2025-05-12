Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4725AC3ABC3
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 06:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31D610E2CD;
	Mon, 12 May 2025 06:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b3N7XiWL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD6910E2CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 06:57:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KVg7on2WvCu1lHd43EUlY8kRkVLwqyt1IK5YXUCQqilq+tgN3R8V6Xt3mYmDnzRzziZ61P2Y5ZsANyh2Lt98TlcM+woFOrdyhcZ8LBoG3JM4H7HNMG8dnpgsVoDS/JfH/04xQMomElbGY8hbU+5E45ON49eHVZiYk6qYJrlt+m5lko+Fp+0QzZRSL0FgfTUoaFl67PkGiingFr9C1aG49hnrhhFvHmSe26gCxZuGlhnSk/usEbw6EbWH+vLOszACVtuzW4llMhqD9KfKYE0uH4ZYQN/rdjNiQlcqIkmTRyfDBC8YX98MpBI4YADekxcdVB2kbubQ7hB6p+OBqpkNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCqQ6i/RKiUfJWrNTPQvgfBpoV//4cU46ks8LfWm6zM=;
 b=P5dY0Om7xPeXlFzIYz5KD3GMMP3Fd4ORDQB7rQ72/j8uu5TaEyVWToNpp4PWdjPkqU2N8djeEJ0ZU6kUAIc7sf6q/RNq9VonCgxRI5hB0UlP9wFzyHL98jKpcEOakyuEjkgLtwqu0M79Ou3g/nggyqz/LaZfqN1yaR+hE/cZM4ltStYP9ZdI/BARsmrNrDdpN5BAl37V32RsN7uorKzCS0XiXzA4ZHFzIHj0T3nzZoJf2b/lJCwzFFcLH4BvDYgaBiGE+kq07px64do/PSAoGWZ5AB3QSYXD+u7Z7g4VG+UNOp3PRV+M0i2cLLIbB4kVbvgX6HS1a4VVJuQJatKAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zCqQ6i/RKiUfJWrNTPQvgfBpoV//4cU46ks8LfWm6zM=;
 b=b3N7XiWLp4W5zNyT5hznwtoMBKb4V2VCM8QIkjN+nj35SL0uEvzRnQcQ1MVa0dNhVaxjQbE+OfVHKIhuPSjfNKYML/nNPZ2B7Cz6rCj1YB531xXqP5Bh5v7qJunQW3AWOhMVK350NciiQW6kKlu0vkUpdzuTRR2w6ozrJCHBA1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 06:57:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:57:32 +0000
Message-ID: <b407264f-58e2-4f7d-b5e7-e758b1edc58b@amd.com>
Date: Mon, 12 May 2025 08:57:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: improve performance with XNACK enable
To: James Zhu <jamesz@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, philip.yang@amd.com
Cc: Felix.kuehling@amd.com
References: <20250508144651.16745-1-James.Zhu@amd.com>
 <e741c57a-651e-4acf-9ae6-4268c6540e0e@amd.com>
 <6466df95-a64d-4894-b148-c153d299599b@amd.com>
 <7563a7d3-a871-490b-b756-11255d0532d9@amd.com>
 <bb06537d-b04e-4657-9893-923a54b8e5a8@amd.com>
 <06caf86d-c29b-4cd9-8105-5624334a79ca@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <06caf86d-c29b-4cd9-8105-5624334a79ca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1632f4-4158-418d-f241-08dd9122442f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2dRVW1UcjhqNE9ReU16eWw5dUkyWWliODRqcTlrZDJWWmRZUFNudXZDSnQz?=
 =?utf-8?B?MXdXQnpvazdqQ3QwaEFBVG95WUF2NU05dHppL1ZRd0NybTBCTWFRMGlFcHJH?=
 =?utf-8?B?aWdVQ2FjYjRwdDc2aGZaWWFvUDJicDFWaWEzMytzSytBNzB0dWphR3NmY2xR?=
 =?utf-8?B?d3F0STJ1eFFvUHkzaTAxRU5qeGU5M0RqUWN3dExrTitkUG0wdnNwa25tRGZ5?=
 =?utf-8?B?RUpqaEdGUHZiWmQwYXBIZWxDUFgyN0ZmWkZlejhabHMvaW5UNWo5amZHZkVU?=
 =?utf-8?B?WXloRjRjQm5tcHNrQWlaaE8wTkRVQXlxY08wSGE0M1NwUkRDZHNGcUdqaEZB?=
 =?utf-8?B?N2FXNlR0ZFhrZ1ZTY2g3WUVVVEJxYTZ4dHFHWVVxYnZnMlhTZUZMVWtXQVRC?=
 =?utf-8?B?M3JHTzc5aDdVemRPckUwV0trSEh0QjlqUXVXSExPTVFxMm96ajU4cml1VUg0?=
 =?utf-8?B?azdLcCttaXVPWmp4SDQ5NHBNa1VPUDdwd0JpSVA2U2MxaXpPTy81VGIzM2VZ?=
 =?utf-8?B?aFdSOU9OUFVocUxrd2MzRGloUVlCcytoc01OZGVXeXZVTnJOZ2xsYmZIWGVm?=
 =?utf-8?B?VEkzMU9qWWRlNGJ1aWZJYnNoYjYrWGpMYWtkVzRvdk4rY0RqV0pwNjNxek9n?=
 =?utf-8?B?aW5iUkhXNFgybms5ZjRZS0h1NmNTamg5N3BldHd4WjU1ek1oY1NoSHJCb2d0?=
 =?utf-8?B?TXdZTHloVUZmSTBYdUo4UUdScFhYRWw1TWR4OGU4c1VwNklHYUFKUUpsY21C?=
 =?utf-8?B?Q01IZkdIVEhzT3VVZVBwRFFXdktzdWsxQ1psWXJiTGhRd1plMXZxclJoLzF2?=
 =?utf-8?B?djBsZXBFN3RJaFQ3Z3pMRmd1RXorbUpzdEVVaDRYMEowRFR0Ujg1MVk4WUpX?=
 =?utf-8?B?UlhxY0kwQ09Ra0s5S1BCNnJqN0Vra0ZtR1pCU0lDT2FZcktIdm5aQVV5cWZj?=
 =?utf-8?B?T1JrVW1reURJSGtvSW5oc2hkMDhIWWtKelo1eGhjQ1JSRkg5TlJ6emZDcGR2?=
 =?utf-8?B?MHJoT0o2ZGRMTUZlUlk4RjEwL1gvbWg1LzZKL2Q3dUJ4VElJZCtrM3ZxYUZK?=
 =?utf-8?B?ZnRwcHhDV2MwN2dCQ2djZU5EUUFrRkJTVXQ3VnUrUFNOVDh3Wi9KNVk4dE91?=
 =?utf-8?B?N1pKSytFdmZLZUNGVHlqUUN3L2ZYZDk4ZFNzTXRNSFZ4N1plaVNYSnNEUnBx?=
 =?utf-8?B?MDN1THpEaW1xaFk4ZHN2eXVFdVZPbS84TnpRNE12MCs4MXQzSzk0bzFrNzFj?=
 =?utf-8?B?OHEzZStVV2F4cFpjN3JSQkRSNlV1aHVzaTg5VTduL1RqZXYxUXZRdzk1Szdy?=
 =?utf-8?B?VS9Yb29lKzZhWW4wMFlhYWlINE5PcXBrbnloWE9EYjluM1FnM3h6ZEtCUVp2?=
 =?utf-8?B?SUx6Uit3MjNaTjV1VzlvNFdHcWcwc3Buek1BWEpvdW83ckdPQnYrbTZ3VHF3?=
 =?utf-8?B?K1ZWQXcyUjRhZGpjcGtkNHQyblRWeFZQd2NCbEJFdEdRVWdZUStKMUxGTE9i?=
 =?utf-8?B?Sm1XRHg1dDkyNmVHZkxaUTdqalZGRmVFdnIxOHduZTZDR0ZYUE1MMmdIVGRC?=
 =?utf-8?B?TlNvbWcybzh2aURhS3pvdE0yRVlBUm5SWHlTN3QzTFQvS1dDUGxjSVJUdCsw?=
 =?utf-8?B?Z2tlRUtvYUhFa0RxSEQrYlBaaWg1cUJuWjNnN09STWx0TGttTHNwTFJabUhh?=
 =?utf-8?B?bUVKV2dOWUdpYUg5WmhMbnUveVkrT09hL1hGVDdRVzN5djlnMXU2dkgwdTRV?=
 =?utf-8?B?S0FxZFdLb0syZlpGMHQyeGU5eUNiSHdNQVlvbW9hbmJ0K3kxQXlBZTRlbWJI?=
 =?utf-8?B?UWtCRDhpYm43dnJhTk1RYUFNcHQybGRlWUxDT29hME1pSlFjc01mdExYY2wr?=
 =?utf-8?B?NW12TW5MNU5rNnNTeWVIVnIwdTd6V0UyMTluSHpLN0thWjJqVDZtSlpWK2Vm?=
 =?utf-8?Q?gl61lf6nLRY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZEL1o4RWV0UzlQNGl0SHhpNTFtdHhZVlU1VTUxUmVkdHM2dFpaaUxPUTJl?=
 =?utf-8?B?eEdMRGFkc3hJQkJsd3l3Z1Z1WWFsNkpnNUxWVHpFMEpHOHc0TU0xZnhObHpE?=
 =?utf-8?B?OWxuQi8vRGc3Q2k2Um9sY0R6Y2M0c3EybUhGakNHUXQzQlhWVGtEOUg5aitO?=
 =?utf-8?B?UGpyOXRVdUw2WnkvZytKMnl2dlZCcVdBc0lWZWR1RGdMRVZsczZ2YWlYZE9i?=
 =?utf-8?B?WXdCaU9OUE96YktjVkFiQ2d3cjBjWXVlT1lDU2o0SjhYMmZTK3lnWlJCL0xj?=
 =?utf-8?B?cTE0WkE1QWRRMHcwbEgvdEFwNWx6VTc4a0FVaG5GTWJ1UTdOck9wTGFXVDk1?=
 =?utf-8?B?SmxLNDQ3TlZHTldLR2xCOXJwM1VGSTZ0ZmljNWh2UlRRT2xWWXBpZDIvWUtx?=
 =?utf-8?B?dTZHOG8weVd2NEFDZ1dadUNaZ0swZU81WlUyNkdQTjhyV0VwcHlhSXdPWjNp?=
 =?utf-8?B?YnZXbDhQK1dJRTZuQnZuTXovakZPSnhLUUZaaWJzU0xvNDRVR25PMmNFTi8z?=
 =?utf-8?B?ZHF4QmRpYUVmcFhIVm9ReXgxMTd2VHJGd21YQzduenpJdTIxQUwvU09VVzFS?=
 =?utf-8?B?WFlWSW5rTSthV29hL1ZvcXVONWhiQldESmhCcTZMenhWWGVwZkpsaW5lUzBF?=
 =?utf-8?B?UlVkWTlCZjIxZ0M3a21iTjNaaGRjNmpWZ3lJa29uZUxZTHBuUFpmMWFJOWQ4?=
 =?utf-8?B?SmthOFpWR3N4ZS9ISWhmRURoSHRheGM5Z2s5dEh5Smhvck5rc0ppYXBsSVFD?=
 =?utf-8?B?cTV0K3BtbyszRjBTbEhNUnlTYTUwTyszc1hhbzhadzdMdmw0NGhPRUZlNkUz?=
 =?utf-8?B?NmRiRjRxMzlTRVVuVTN5Zi9UQUxiNUlwR1ZFemkwZnVERW9XRDRKdUt1SXli?=
 =?utf-8?B?TFBoMjhXTHppR0p2R3lQWFlhRDEvNU9hdHNHMWo0aTlpU3BOYjVnUVc4dE1R?=
 =?utf-8?B?VzBDSm8yL04yYmNzTk9JcnErSEpSc3ZQTm1wSy9PNTlkalpWS0QxRjNrZ0lN?=
 =?utf-8?B?eVNyQ2M3UW5IOEczdWVPUEFLdTJ4WXJkSXFyMXVsbWJuQ2I5aUJXZ0Q5Q21v?=
 =?utf-8?B?dkdoZGFlb2lVS0w1Z2VYMDZhNUJoOGZrMjh5YjJHN3o4N2NLOFIwM1FRNHdy?=
 =?utf-8?B?TEJHUGR3cUNLbTQxZk5ORXQ0OFh4RDErK0pCaDVINmg5QzNsaE1NWURKMDNu?=
 =?utf-8?B?NXZRdWRaUDJUL0NsOC81R2ZRT3hFZHh3Vk5Qb2ZvQTlHcjhrVUNLYkRoQmJ5?=
 =?utf-8?B?YzZkMDJnVnY2SGIwc0U2VDJIbXU5SEUwV1QzMkM2Y2ZuaGQwNnhwTXFGTXln?=
 =?utf-8?B?Nk1Jbyt2QWcwUjVFa3YrSVNxa2dEQmFsZmNUV2k4VXQ5aDhtZzZIWEt2RUln?=
 =?utf-8?B?eXFmck5aYUtzMW5YTU1Id2VpQVN3UDc5eVVMRkVVUFRPdUVGa2pwU3h6MmJ5?=
 =?utf-8?B?Z0FCbFo2Z3VwTFE3TjhLTFllUVpDZ2gzNjJ2bjlCazhMckFqeEJUeE11MDE0?=
 =?utf-8?B?YmNWdG16bFd1N1RyakttK2YxRTNtNnRGSzBrdnFRSm96bTJUTTlTbHFhVWJm?=
 =?utf-8?B?M1FTY2tlYzFjUnlUcGhjayswZEJnbmxWNFRMUTJKSUFDTUZyTktCSXpid1hM?=
 =?utf-8?B?eTJOWlVEZHRXOFFDSWFnWEZPNUxITngwVnRYWjVrbGRxZDhXdFo1ZXZBaHNF?=
 =?utf-8?B?cmJsVEpWZkVvd1ZzZ0xPVUgyOFdkVTdVL3Y1QkNETk9ZaWxmUkpVT1lEWlR6?=
 =?utf-8?B?aHozOXhpQm5PMkxpY2k3OHVMVy83WWV5ckhsT3lMTjc2RGo3SEFQVVdPUmdO?=
 =?utf-8?B?bFdkY2RjWEMwd0FwR004ZU5tenFlbEoxbFJBa3FrWlV4THp3V1AwMzlxNlZO?=
 =?utf-8?B?dm9OdHpXNnBZaUU3dmFjV3o4akI5YzdPeDZZT2ltSGR0dy90MU9BeUNSMnhF?=
 =?utf-8?B?cHpHNks3a1FBOCtKRThLY1RQUVFlanhQTmkvYm9wVGVlUlVnam8zVFNuM3Rh?=
 =?utf-8?B?UFhDZ1piajNXSWtDZ1pQK1BJK1V3M2hJMlJ6WmlJM3NwWE52UFhvSm5XYkdC?=
 =?utf-8?B?S3dORENIM3I4cmUvM01LajhCQXNud2tRM0d4MlZyU1lCc25OMzgxb2FRdTYv?=
 =?utf-8?Q?5RGs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1632f4-4158-418d-f241-08dd9122442f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:57:31.9288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hjqs/+l4Z9GF07lg7DkOkclOa5PQ8/JH/ufsDhnSN2hG3Z/v3n9GBp6jxI/BcrNO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

On 5/9/25 14:45, James Zhu wrote:
> 
> On 2025-05-09 02:00, Christian König wrote:
>> On 5/8/25 19:25, James Zhu wrote:
>>> On 2025-05-08 11:20, James Zhu wrote:
>>>> On 2025-05-08 10:50, Christian König wrote:
>>>>> On 5/8/25 16:46, James Zhu wrote:
>>>>>> When XNACK on, hang or low performance is observed with some test cases.
>>>>>> The restoring page process has unexpected stuck during evicting/restoring
>>>>>> if some bo's flag has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting:
>>>>>> 1. when xnack on, retry pagefault will invoke restoring pages process
>>>>>> 2. A. if there is enough VRAM space, simply migrating pages from ram to vram
>>>>>>     B. if there is no enough VRAM space left, searching resource LRU list, and
>>>>>>        scheduling a new eviction work queue to evict LRU bo from vram to ram
>>>>>>        first, then resume restoring pages process, or waiting for eviction
>>>>>>        timeout and try to schedule evicting next LRU bo
>>>>>> 3. for case 2B, if bo has KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED setting,
>>>>>>     queue eviction will be triggered.So restoring work queue will be scheduled.
>>>>>> 4. step 1, restoring pages process will hold one mm->mmap_lock's read until
>>>>>>     restoring pages is completed
>>>>>>     step 2B, evictiion work queue process will hold one mm->mmap_lock's read
>>>>>>     until evicting bo is completed
>>>>>>     step 3, restoring work queue process is trying to acquire one mm->mmap_lock's
>>>>>>     write after the above two mm->mmap_lock's read are released, and in the
>>>>>>     meantime which will block all following mm->mmap_lock's read request.
>>>>>> 5. in step 2, if the first eviction bo's size is big enough for step 1
>>>>>>     restoring pages request, everything is fine. if not, which means that the
>>>>>>     mm->mmap_lock's read step 1 won't be release right the way. In step 3, first
>>>>>>     eviction bo's restoring work queue will compete for mm->mmap_lock's write,
>>>>>>     the second and following LRU bo's evictiion work queue will be blocked by
>>>>>>     tring to acquire mm->mmap_lock's read until timeout. All restoring pages
>>>>>>     process will be stuck here.
>>>>>> Using down_write_trylock to replace mmap_write_lock will help not block the
>>>>>> second and following evictiion work queue process.
>>>>>>
>>>>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 +++++-
>>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> index 72be6e152e88..5f6ed70559b7 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> @@ -1794,7 +1794,11 @@ svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
>>>>>>   {
>>>>>>   retry_flush_work:
>>>>>>       flush_work(&svms->deferred_list_work);
>>>>>> -    mmap_write_lock(mm);
>>>>>> +        while (true) {
>>>>>> +                if (down_write_trylock(&(mm->mmap_lock)))
>>>>>> +                        break;
>>>>>> +                schedule();
>>>>>> +        }
>>>>> Oh, stuff like that is usually an absolutely clear NAK from upstream.
>>>>>
>>>>> As far as I know that is not something we can do so easily.
>>>>>
>>>>> Would it be possible to wait for progress instead of calling schedule() here?
>>>> [JZ]  At 1st beginning, I am thinking adding sync with restoring pages done.
>>>>
>>>> but the original restoring work design philosophy is blindly scheduled after certain delay.
>>>>
>>>> the changes with sync may take more time and risk. I would like Felix and Philip give comments
>>>>
>>>> if there is efficient and safe way to fix it. Thanks!
>>> [JZ] BTW, in worse case, mmap_write_lock will fall into rwsem_down_write_slowpath(), schedule_preempt_disabled() and schedule();
>> Yeah, but drivers are not allowed to re-implement or even bypass that logic.
> 
> [JZ] here  can take as a new version mmap_write_lock without blocking the following read request and competing for write
> 
> lock which means read has higher priority under this case. Logically sync is better way to replace it. In practice, under
> 
> current scenery, sync will increase other burdens an risk.

Yeah and exactly that is messing with mutex internals and is an absolutely clear no-go.

Stuff like that is not allowed, not even remotely.

Regards,
Christian.

> 
>> Regards,
>> Christian.
>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>         if (list_empty(&svms->deferred_range_list))
>>>>>>           return;

