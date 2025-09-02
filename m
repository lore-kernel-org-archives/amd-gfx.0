Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CF0CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 11:20:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A8410E323;
	Tue,  2 Sep 2025 11:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ngrwV/0u";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDAF10E323
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 11:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CITCxe9unSb3u9RCC0vvwvvB9qUsc3oeBYAry6GZiVk2sQfZGx5SI82CNnGndk9BZ6Il/4IiKxjsVQc0YtVj4s3TIHJdqj0gzOc374Nm2Ep1cax+MVjQPtS+GF+sSVwgyPUmz/mJ5df+2waRWFJUOc0FjfW8LyoEjDfXNe+lQXReaC/6xOhHP/1RYaWcRw5NGViwXJUe+G31IPc6mET2Es+TJ2H0XBJirFNn5EK6XSa/WDgS2WQdg+JH+4AfryWFjQp+cKUsOXwOlfdbiNMRITUNJsFDwrlIik+yI2UQwwLNnc5Sjwthkv/R/Fc+iNQ/TdjC6dWe6tf6s0k8oxbk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrllBzbJ3FGaF+t+EVBoWPMASTtHCjIKnxNzvu8RhmU=;
 b=a6kHs/J8eWbU23gWiFc89iIr9wRtvlAXhKeJWNfPaLHLt+DZHEbQxs7GQM/kUtvMCCoeH6YHitbZztUeKZ2iR5bW4pS5kotSUedECrBOLe7WgGjxm04MeZHaKRMd5s65jEerx3BRw5+u9CCP0w58xdSNI1Cy0DI55tS4q7CB+a08yqrhZywLkhNAWsD5bUaWcbpSVZyhUiPBdut1Jyp4ivbYN/pra6mF2Bzp7K7p2PfbdLOe5qLxna7f4A1VSTQk3JBEap9mURlDFHSgRv+++iMZGp2gZ3fkphwKhHsQ6ezuiYkRMtCStnwvVfUfFKtoIOkI+dSc854Lwwhb39DQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrllBzbJ3FGaF+t+EVBoWPMASTtHCjIKnxNzvu8RhmU=;
 b=ngrwV/0u+5aoeBXY4t1CX2NeOdfoIb8GtlVhUyH1nZ3pNXrr56FDyy7jrr1I+o/OQVop+EwXg1FrcRfLdqWoibcY1lA823xxIc7tWrAYA6ebIJnIwomh6o+ewC+o9IsCfGHwoYFPW1GKf1BovtT7K8VROjYN/GfPFtjphOWFNCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV8PR12MB9618.namprd12.prod.outlook.com (2603:10b6:408:2a0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 11:20:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.9073.021; Tue, 2 Sep 2025
 11:20:32 +0000
Message-ID: <555c595b-4585-4a69-bf87-79d5a30301df@amd.com>
Date: Tue, 2 Sep 2025 13:20:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu: Fix allocating extra dwords for rings
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20250901100012.439155-1-timur.kristof@gmail.com>
 <cb030737-e602-4bdd-aef2-cb5fc79ee2ca@amd.com>
 <f1279a6181ff9dba8f18f3eec352502cfea953e2.camel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f1279a6181ff9dba8f18f3eec352502cfea953e2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV8PR12MB9618:EE_
X-MS-Office365-Filtering-Correlation-Id: dda2e583-b135-4659-0623-08ddea12bab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1BRdUZxc2dleXNFellXN3NTOENEOHVycHIrTlVxQ0h5MStIUDVaR2c5cGt1?=
 =?utf-8?B?dWdnbE1PWXAzTUZ6QWxPTDg4MEFyRjZoYXdFblBnblBVZzd0ZGdxUzF6N3lh?=
 =?utf-8?B?SHhWR2wwSW0zQjgxTGdpcFJ0OWxxVjhZYXI1Z2hJaDVmYnRsTUd6YkNVR0U3?=
 =?utf-8?B?UmVsazZtMG5GSmp6R0dGaVh1dWxTRFF2bXhnYmo4QStVZzdsMHZOK0Evajdx?=
 =?utf-8?B?U3pocEZtVTlpVVBNV0JOUVdVb2ZSQkl1ZEVOYWR1THlReXNlS1VhZEpzN0o0?=
 =?utf-8?B?UUZML015cWtYaUREZWRqalRZVGdOQ2xjMXR1TmxHVUVtTnVWQmY2cEd6OUho?=
 =?utf-8?B?YWlSblVXODdCM1hra0NxR3pJTDM4ZzZnT3o2U01pRzlzWjNZaDBCQ2VXRmxE?=
 =?utf-8?B?b2tBdUtpcTEyZmRBeVVaS2lDRGwvU2RDYlMrSE9TNzdrV1NPRjNEWGwwQ253?=
 =?utf-8?B?WFNMdXc4SnBXTi9pbG5iSzYxeHp0T0E4T1hDSUNtNFowU0QzOU13SFhncEM1?=
 =?utf-8?B?OWFkNlhxWXZsOFlTZ3Y0dkZ3eG1iUGFzYzZXSkNGdFh5TC80ZDdJN3lwcEt6?=
 =?utf-8?B?dndKVm5LNDErNWhvdVRCSTJTOUR2MGJQNGkxL2xzeklMWEMxZ2p5cHNhRFRB?=
 =?utf-8?B?ZWRWeTlVRUZBbkx6TWpKTUdCb3pxSGk2SWNJYWxDY3RMODdFMFVrUjJOV3hO?=
 =?utf-8?B?SExHNjR3SGMzMTJDcXlqM3YrMDhxeTU0KzJYWVdmc3lSbWk5emdWQjJGclFy?=
 =?utf-8?B?dWhEZU45U3VHd3BQQ0E1aEpKUmRPVGZORUcwaHp6bzg2YjMyU2tWd1AxaUh2?=
 =?utf-8?B?SmJKNFVDcnBGQi9KZ1BNckJCNXYxaFhLbmRSSTRBWS9mb3c3YnlSb0tTQjVt?=
 =?utf-8?B?Z1FUYWpEcGJsbitHWEFjdFArelgxVTQ1NG9UWDBFN1oxNXRFVHJxUVdMRkFs?=
 =?utf-8?B?a0YyY1NXQmhMNVZZTWFBZThlNlpjUDBUWDcwaS9oakdQKzNpdSt0Mkh0bzc0?=
 =?utf-8?B?RnpuUlBhVmdKQTk3cGVSajZXdkpWUlIreU9nMFVHKzkwYjlsZ2daa1VpYVZH?=
 =?utf-8?B?aEJSRWtHcjF6MHdkd1VWV1YzN3pjZDc2aFQ3VWhXd0E3akdTWVd2ZW5VNkds?=
 =?utf-8?B?RWFWdmh3TzNLem1jSHNHbC9QYThyakFPbXZ1d09jcmJ2QWJaTG8wOFFIcWha?=
 =?utf-8?B?N1FtOVZ4anNYT2hTamFMSzQ0N1JUK1JReGJBU1NMQ1ZlWGZuOXhpS1YzMkVO?=
 =?utf-8?B?ZEorUHRLUWRZOG85d3JRSWJad1gwY0x5NjdScXB0YUp2aWI2VmJXQkgrOVBX?=
 =?utf-8?B?RHIzdlY2d0ZKSlpldVBTWUdPVUFJSFAzZkR0VzdIMkNYbmg5OFpqLy9TYzBi?=
 =?utf-8?B?Ym94M2tEY0VsMnBvVWVObDg5RHV0QndYaDJncmhjQ29kUHpFbEo0QTd3U2RH?=
 =?utf-8?B?YnczUCtVTzlsY3AvYmd0bUhucUN2TVZXUjhvZUQrWWtuam9maWp6eDlISHRR?=
 =?utf-8?B?Ukx5OW9UbUxJMnE4MjcvYTNFOTBGZlhXQnJHOXRseXVtcVNSNzZqaXRjRXdw?=
 =?utf-8?B?QlVvVVNtQXdzNXBIRDFCak5jZ2J4dmpVbnVYaCtLOWhJd1h5Znc5UHM3UHFL?=
 =?utf-8?B?c1g4ZS9ZejhSWE5uWGJhdHJYc0lqNnRGenJUbVcxKzZwOXFxQy82RWczR3lm?=
 =?utf-8?B?M0JpYVhzMTIyNGkwc3NtTytic2tYT3hxZGl3M2FKWng3ZGpiWXl6R2F2N0ww?=
 =?utf-8?B?YXc2WExLbk5FemFzaHdSWDZmTnBsTkFVZjJUbmdxYndYSzcyR2hIdmNLbWRN?=
 =?utf-8?B?c01xbitXcWpoTnhZZ0Z2RktUa1VjYzFRN1VyQkt3MWpnTnpqMEJBLzl5UUJJ?=
 =?utf-8?B?YVFaRXpLMVhITWZMUTNxOHh4ZThuNUU5Sm1CRy9KSHRkSEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3c3ajFqNjM0Vm83YWx1UHJkM3BqZURyNmk2Y1p3R1dCU3o0QmhieEVNcyt3?=
 =?utf-8?B?MXdZU0ttbGlMYzZ3N2JtTmxQTXlnS1ZwYkZxaGJheXRQSUpKM2hNdnlkT2dw?=
 =?utf-8?B?NXlEcWRxV0FuVVM1OVFjanVQUHg0MDNlQ2h1c2lsYmM3SnkvQkFtUE54eWdU?=
 =?utf-8?B?aWRPSzMxcWxtbnJ1SzJZNnFiVU5RcjlMMkthdUpCdjZ0UjNyS0luVDVBRFhL?=
 =?utf-8?B?SUQzS2Vad3FPWlRKQ0NjWWgvekRkbEZ0SkFxRi9iSVVTTXBsQ2MxRVRwakN0?=
 =?utf-8?B?dHJ0c0dUS0lIeDJsU3duaGlwM3lDQ2hzbHR2NXpBUm9CNUVoR0ZWQXRTYSs3?=
 =?utf-8?B?N213UGp4N3BROW9aZzA2ZnFRYWFFbXhBQU1CdkYySW9RNGNxM1piMFNQM2dv?=
 =?utf-8?B?RnkzbmJkQzFFL3U1a1lraVZqbEVPVTRyUFZwZlg0TmpVUW9FM25wZlMwVmZD?=
 =?utf-8?B?bDJPbGZkQUxoTGVBcjNwd2piTm54N1hNWENURko4UThKUFhNR0ZWbCtZQTdw?=
 =?utf-8?B?MjhWbEo1a0xoS004M2s5ZERSQWF4RWxpUENKMTdHYU1sTW5EZm9RSEZSU3Fy?=
 =?utf-8?B?T3RJRUo4Qi9MMSs5UUNRQUNkWWVmZlZaUyszZkU3aDlQNUpRZi9lcXEwY3JL?=
 =?utf-8?B?YklaM3I0eEVlRWg4VjlhaWRKaDlkSGl2ekdLcCtEbkdJK2tSRVAvYnoxNHRB?=
 =?utf-8?B?QUVyMFBnNmhXOENsdUpkajR2TUtwK3A1T1J1RnlFVEkzNXpFcEdXOG0xQ1RQ?=
 =?utf-8?B?alo4VnVYVVRvUTFiZGNvUEgzYkhWSEZYWVY1NnlBSFQ1ckxldGZ6SkV3Z1hE?=
 =?utf-8?B?U0NGL1Z5ZmxOb2M3T1lOUFNsWlJrLzhYbTNsNkkwZ1FCYVpkK2tHL0FSN1ln?=
 =?utf-8?B?aStNcVNOblJYRzNzT09seUg0Uld6cG1PL2ZWRjVralh4cHZyOXNab1RLdlFl?=
 =?utf-8?B?M25jaGM1VTBnL1hmQ2JhMzBjeEhEbEEwbGNrZ1ZNYVNyQ2pUN0I1ck12cUFQ?=
 =?utf-8?B?L1d5Z2hZU1UyNk1BMXZZWFJ1c3k4c3k1SWMwbkoveWI4dkdWY2tNd2ZmQ3I3?=
 =?utf-8?B?bUd6RkxKVVJnbDRQUmtRc09VYnBNVjFHQmJ1ZitXbjJncS9nWVd4di9rWFBj?=
 =?utf-8?B?VTQwM2V3WFdRNnhtWFRzRFp1M1VxYXV6dUlFeVRkMmJ4K1dVdTVDWnJKVm1I?=
 =?utf-8?B?c2txallFbmM4eXlEWGl3ajRubExmclVMaGtveVk3ZUJnNWpMbHlFM3V3N1lJ?=
 =?utf-8?B?NXowNHVteGpScGtkRXpwU3g0bTMxb1pzVXd3bEFsamFRbC9wdW1HYWtSeFBV?=
 =?utf-8?B?TDd4OCsrNVlXZ0kxRTZxMWI2NmsrWmVzOEhvTFdwbXBmZ0lNOFZKK3I1MEU1?=
 =?utf-8?B?d1k5QVhBSnZtYmhaaVIzc1luSjFCZHBpNmp4SzFOMWlvUGtWN1QxeEl5eXBM?=
 =?utf-8?B?RTB2S0o4TXVHei9rcTJHN283VmMyY1VQNzU0M1NXRVZjRDRIT0M2c1RGVWE3?=
 =?utf-8?B?MjFlMXFaa2NEMEs0dENUZUVGNnpENkpkQlJBRUk2anJDc0ZxSU1WRk1kdTVT?=
 =?utf-8?B?d205YUpXbjZuWGxPMFNEaGxVSGsrZ0gzY0tDVktVSWdpU09Ia0liczYwbHMx?=
 =?utf-8?B?Nnp4M1NjdTE0djM0eExkN3N1blUzNUEwNjZCR2F0aG9pRVBodkpSczk0REF2?=
 =?utf-8?B?OWpVUEdCcEdockhkL0RGWXpONjBGVXh4cUJjOTFROXJ3U0lGM0NFY1hvWTdW?=
 =?utf-8?B?TlVLb25qOEE1SXU0ZTIyZktsRy9JVG93aDhyMmF5UUlRdi93bTdzS1M3dFlO?=
 =?utf-8?B?b2FXQk9JUkRYMEtnZUFyT2QydXY1UVdOcnVZS2h4bWpkekxLTHFnVzFpeFBm?=
 =?utf-8?B?RmU3OC9Xb1llZ0U4bXUwYjgvRVNjR0p0alE3VEp5YndDbEZNeWxRUzV0U3k0?=
 =?utf-8?B?VXQ0eUFmU1V2UmhaRGx3UVY4VW95THE1cjgzdldBTFFFL09vWUxmL3QwYW5m?=
 =?utf-8?B?WGNCWHhEUTVaVW1KSDFBR0pxWkwzKys5ZERBNHFuWkI4LzFhbXBENmJMUDhX?=
 =?utf-8?B?SkkxZncrR3hZL29WdE5tQktCWWFjUmp3YUhYaFJCMUVWMVo5MEhzZElVc2k0?=
 =?utf-8?Q?9aZdHWOGeQfCLWzsRa1vIWXSQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2e583-b135-4659-0623-08ddea12bab6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:20:32.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu1WVGhGGZCVe6yWd0gsTXxylYET4HBi7dr7DePN4VIVWVSIXIFYGLIdYXmfFf0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9618
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

On 02.09.25 10:26, Timur Kristóf wrote:
> On Tue, 2025-09-02 at 08:41 +0200, Christian König wrote:
>> On 01.09.25 12:00, Timur Kristóf wrote:
>>> The amdgpu_bo_create_kernel function takes a byte count,
>>> so we need to multiply the extra dword count by four.
>>> (The ring_size is already in bytes so that one is correct here.)
>>
>> Good catch, it just doesn't make a difference in practice since
>> everything is rounded up to 4k anyway.
> 
> Yes. It looks like extra_dw is only used by jpeg_v1_0 and vcn_v4_0 and
> fortunately both of these are small enough that it doesn't cause a
> difference in practice.
> 
> I'd still like to fix it though to avoid potential issues in the
> future.

Yeah, clearly agree. 

> 
>>
>> But I'm really wondering if we shouldn't replace the extra_dw with
>> extra_bytes instead.
> 
> It's up to you. I'm happy to change it to extra_bytes if you think
> that's better.

The VCN code already specifies the extra_dw in bytes.

So I think it is better to rename the field and add an "* 4" to the calculation in the jpeg code.

> I would prefer to keep extra_dw for two reasons:
> 
> - Avoid unnecessary churn
> - Most of the code related to rings are in dwords, so IMO it's better
> to have the extra space in dwords too for consistency.

That more or less just a leftover from the early radeon days.

The GFX/SDMA/UVD engines worked with DW packets, but starting with VCE and then later VCN, PSP and MES the FW teams moved over to using C structs which are obviously counted in bytes.

> 
>>
>> It should only be used by some multimedia engines anyway.
> 
> Right. vcn_v4_0 has this:
> .extra_dw = sizeof(struct amdgpu_vcn_rb_metadata)
> Which would also need to be fixed because it's not really in dwords.

Yeah, exactly that.

Regards,
Christian.

> 
> 
> 
>>>
>>> Fixes: c8c1a1d2ef04 ("drm/amdgpu: define and add extra dword for
>>> jpeg ring")
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 ++++++-----
>>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index 6379bb25bf5c..13f0f0209cbe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -364,11 +364,12 @@ int amdgpu_ring_init(struct amdgpu_device
>>> *adev, struct amdgpu_ring *ring,
>>>  
>>>  	/* Allocate ring buffer */
>>>  	if (ring->ring_obj == NULL) {
>>> -		r = amdgpu_bo_create_kernel(adev, ring->ring_size
>>> + ring->funcs->extra_dw, PAGE_SIZE,
>>> -					    AMDGPU_GEM_DOMAIN_GTT,
>>> -					    &ring->ring_obj,
>>> -					    &ring->gpu_addr,
>>> -					    (void **)&ring->ring);
>>> +		r = amdgpu_bo_create_kernel(adev, ring->ring_size
>>> + ring->funcs->extra_dw * 4,
>>> +						PAGE_SIZE,
>>> +						AMDGPU_GEM_DOMAIN_
>>> GTT,
>>> +						&ring->ring_obj,
>>> +						&ring->gpu_addr,
>>> +						(void **)&ring-
>>>> ring);
>>>  		if (r) {
>>>  			dev_err(adev->dev, "(%d) ring create
>>> failed\n", r);
>>>  			kvfree(ring->ring_backup);

