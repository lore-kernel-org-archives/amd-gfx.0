Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDF6C54F2E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 13:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE0A10E7ED;
	Fri, 23 May 2025 13:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKm4qcqd";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FAF10E7ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 13:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKC2SjtG2lNnodFnZ9WGmXSchsGu9d3V25iIAU1dwm+kl/SQjzXwTxEfL84Sl9t8AODPIMnaOIzMdWcnS8snCCtR1/5oNHBTwlf6jNvrDVxzynRBaFK9W/pci0/B8IlXjJtKZrsyu3j7xkQLp1hX0nv0DGAdPMnaR+qBI9UPQnTsTZedujj3zOay9uzN4V7kSpObvkOHKhpd/WFKzV9Lfkcx45yYnkwlS9Yj4KcEk8aGvHr5187B5UDgZWxFhj58BTzfy/I/eQ39RI0T5cmP+LBvzGrbcEviOq0/AsdB6+BSuEI8B5cKVDflO0Yz2dAlf3583Eey8FkdAnfNfcKu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeaoYC0JtX5RzRUObBrqUfRFVD+BU5VnAHk3N39zgXs=;
 b=MqsD06v4HrcAKGQF/H+hb4NsLiZpOqirri+ZrfzYh60t4ik21yrYECM9nSayF63OH5uhCSn0/fnhm1bJ+qJPVnZheQS/NvB5eonWYTkbk0GOFg3e1rPF3qa7rH8rD/Gp+KigAgwVJpHFk0CE5eqhANwTYT44cULOo0qh/OIzDMZhmD4HgSR0koGSwsTuhYuBtDbR3zljGSUkL/Tpzlm4/E40Ajr+oOWQf4eg0owaEKRVGnPimD6WvgaoL23EogerPhS08blmq2polapuvZ4qeblgHD0uZRfx7U5WANwZ9WKF2RL1QaCVsKIdQokoS4BBGLwRwapOMj0Gi6ZR912gGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeaoYC0JtX5RzRUObBrqUfRFVD+BU5VnAHk3N39zgXs=;
 b=LKm4qcqd+DLbOckDqmLQ7ljrmadcUty5D3PPFF8qiFl18abFPwLa3O61ucD3mOfsye9/wBH/Mr0qq3+Yv3c4PkSM8jzgjlDLUinM76x+xkWLjCdFHQlNWmhnfk7a9xRlfxs6utP+AiIAvCwwcI2BWUEPi/HNFSELIgkBQm+6bHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6810.namprd12.prod.outlook.com (2603:10b6:510:1b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 23 May
 2025 13:27:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.031; Fri, 23 May 2025
 13:27:19 +0000
Message-ID: <c859107d-c09c-404c-8021-75ad3df7d54f@amd.com>
Date: Fri, 23 May 2025 15:27:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/10] Reset improvements for GC10+
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MYYR4c8_QW0jo=Gd7w3dnkCFXpgDZAxnSEuhmRpwqZyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6810:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b17175-899e-4afc-d393-08dd99fd8b26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWNmTlcvZFZWSWQvSU1KYmdsRkR2eVc1WTB1S0pJOER6UUpPalRmVm5ZUVZD?=
 =?utf-8?B?bmRPUWQwZzRtRnBORExYeG95OTk1Q3VBQ0oxSXJabTNYVStwU29wK0w2ZXNQ?=
 =?utf-8?B?TDRQMTl3NTdZdDdtSkFpV3hVQTY4WDFYUzFkeVRLNVRwNWt3WGZtYytVcDhK?=
 =?utf-8?B?QzZEbGFNckZFQ0E0eXNRVXRTS0MyeWFOT0RTdWRDWlNtWkx1Z1lRR2VIK2VF?=
 =?utf-8?B?ckg5ZmdxWWFmK3cwR1FGZnRLUnNlbmFCa1ZIbEh2aHU0blhVNFFkcS9qak1M?=
 =?utf-8?B?c2xlVTg2WThzbzg3VmJZRXBYdUplcWExVWtOK3Y1WEFTOGE2VzVteE4wZTE3?=
 =?utf-8?B?SXFjLy8vNEk4ZlRvN2hrVFdMUXloejV3UHdrNVA4RnVBdU9xanFaeTJ1NklR?=
 =?utf-8?B?dlg4b01NYzlZQ0xBRkpkeGFFK29qREo5S1I4eENnMk9PazBxbTZBamhRYUpC?=
 =?utf-8?B?VFEvRjlFeWZMb0JCUk9XalRLdk05d1NpZlhneUhma25Ha0hlV1g3UHdoandV?=
 =?utf-8?B?REhnNHVlNEdjNDE5VHRySGgycXQ5NEVPZG9qcVpXNlBXOCtRRlRyeW44RDdY?=
 =?utf-8?B?TlF1NEV4Y2gvajlnZnZmY0s3Z0RtOWpPUXgxT0poT1VKTDlNWkdBUTVPMEZL?=
 =?utf-8?B?Tk5ZSGdhOGQrc3ZIQ1ZiaU4rTlVMbEJaMW0vdWxKcDhVcHZNaWhkaDFLRG0v?=
 =?utf-8?B?cDR4ak01SDJrNnoyNExxckNad0hVZFNTVHV2dktLUklrYW5OeG4xZ3Bpekti?=
 =?utf-8?B?TytxUmxyc1AwdmdCU21Ld3lYSFNYM0xIeUg3ZDYzeVVlWkZiVEhuay9ueHJm?=
 =?utf-8?B?Z3VVckNrMkZoeW1pTnhMZVpTQVBiYkJkZDBJOVV1b1VtRVpyNG11cHFZQmhV?=
 =?utf-8?B?YXFtMjJLeVFCQUoyOGZEWGVkdENJY3pDOUlKd2dQY0ozS1UzRkt1dm1jUjNs?=
 =?utf-8?B?MXY4bEtkb0p1czF5M1pwSzBjdWUvWC9naU5FcnMvUEdNNnBHaGZURWptVndT?=
 =?utf-8?B?WGhta01mUzNmcGtzZzloa1FzOEZuTE11WTBtZ2VDTCtDdVU0NWxadHpsdHlk?=
 =?utf-8?B?VnJxWHdYUDZjYmVPWU5lNVZwTGk3dG9XN1lqQXV5VDZ3eTdNRVFaL0Ftbnpr?=
 =?utf-8?B?WCszTUk4dEVDTEtRWG0xeHVsQXdIc3FGOVMwanpXK3BLVVZadDNRTG0vZzA0?=
 =?utf-8?B?eUhzNnpaYVBBdnAzZUhKWE5WUFVNOHJiR2w1dVZmSU9XV25uWHRsakthb3dO?=
 =?utf-8?B?ZXlaWkR2Q3VubnpPUHRMemw2clB6cWhhRXJzaXFqZVBETC9aUjlGVGgzVjlm?=
 =?utf-8?B?V2xPTkdGRzByY3N4Ylp6WkhESWkxVk0rVE1jNUQ0djY5SndMS1dZZS9HSHk2?=
 =?utf-8?B?VE54NnFqb0s1Q3F0cGxyWms3SGJYVTByWHdUV1phK2lGLzJhQ1BkNjJNZTVp?=
 =?utf-8?B?Ry9WVnVweFVuYlA3NStnazU4bnpmZlArL1Nhd1ArTlJEWmp4UU1JL0FSN0JY?=
 =?utf-8?B?R0IybXo1R09XTnJ3WVVzYTFROWhBY0hTQ0RzbzhZQUM3T1V4SXZraGg0Y2lM?=
 =?utf-8?B?OXU4ZEY3S2x3bnhvRU5qcU5CRjM1a1JvSW1TRlBxTzNFVlpSbW14Uko3UkJI?=
 =?utf-8?B?a2RtMUE0ampCcHpkK2VQOHphVjM2ZVBWZHpMK0UvbFNjSlVjSFpmSjVCdUZC?=
 =?utf-8?B?RjFTcEtZTHpDamhaT0pVSFZJcitLaldweURwNnZUM2QyZ2NkZmpTSUhZVWwy?=
 =?utf-8?B?dXo3LzdXKy96SWJhWjRmSnIzckxNVnlUekZFbGU3VlQxVndnQ0MvdjdJSzNx?=
 =?utf-8?B?RzhNZjlQU2Fzdm5hek9qSksrQkM3VnhkSUpJZGNBN0tjYUpoZ0tiVEVNVHdW?=
 =?utf-8?B?NzQzbjdsRXg1QjloZjBsRFN0Q2NpNVRrbWxDZ1ptL1oxOXBlMjk3QWVubWg0?=
 =?utf-8?Q?AclREciy7Rc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRxUkpzV3U2YnhVY3YzTkQ1ZFlQY05Mb2s5ZmpTS1ZOY3F5SHZ0dVJKaVh5?=
 =?utf-8?B?ZytGQmtFWWorTWtEZ2psejR5dGcxT2pPaWkrUnlXNHc2U2dPVGJNWGQ4eU5x?=
 =?utf-8?B?Q1lXeHVUNjhWYmFqa2FFdUtnbDZTd0FEcUtSYXRNNEV3Mm5tRkpVaUpqVUR6?=
 =?utf-8?B?SFVaYWIrbm9nSEtZUER2WHlmb2lTTDZ3VXV3eGlvS2I1ZzF1bEtac0NBekpG?=
 =?utf-8?B?WGZjWGRWNS9sczdTSm1OdVIyUnlnOU5aek1HOERqRHFYb1N3REdFTHdiV3dR?=
 =?utf-8?B?ZndQZ24zQjl4ZDJGVGc5UlJ6eU5pNk9ydkRDbmFCdXpXbjVRM1ZJWVRxMHZQ?=
 =?utf-8?B?b29GanNkbWFZeGNsbDU4WnhDYm9qUWljNUtjQUJONnFBQjZSZHdCYlJOdmVo?=
 =?utf-8?B?N01OeXZvNTRHSVNwdkNBVE5IaVBrekVWcHVKaWE4TDNvTktjQ3A2dGJpMzBB?=
 =?utf-8?B?Q0pMZk14QVZ1eGR1dVJBTEZaemgyZlVzcFVNTnZ4Qy8rVEVhdFBod09GZE52?=
 =?utf-8?B?a1BJdllLL3Fzc2k5WXF1YVF3MWNRYUlyRER6aXJZaGFnQldpRkpRTkZHTHF6?=
 =?utf-8?B?SU1EQ0tOT01jbHdkUGdONmNEdmNMU2p0c1ZocGRSc1FMZzQzM3NYbC8zZUha?=
 =?utf-8?B?b3BqR3hKTytOTE9CaXJJUHFiekRnSTc5Z2lDQk12Tzk2bWZ4Rk8zcmFieXpB?=
 =?utf-8?B?S0hEbEo1bUFpMjlMZ0NBTTk4c0FEK1R4OUh6Ukh4Z0F6SnVrNW1TUi9ON0hW?=
 =?utf-8?B?TXVRRmFYVDNia0QrSXlGYkQ2WkZ5RHVhZXdlRlFPUnNUZDd0NTMwRmZxVm9u?=
 =?utf-8?B?NitaNE0yQUJIc0ZtbkFETEsrOStlenNHYzIzSUhZZlRGK21DcUxGNVcrdHZ5?=
 =?utf-8?B?ZW9vdnJqVmtvYW1RNjFWRTc5TmQ2OVdySm5pcTBlbkdiVmdwYjNLbUtEd0xh?=
 =?utf-8?B?NSt6MGxRcFowbHN1VWFmSG8rd3BpM3FTYnZqMEk1SlVHSUFzUm1NMm9GWVl2?=
 =?utf-8?B?OHgxQzRCMzViQ1lRazlHbndoTlV5TnVkTTkrb1RtZzZKaGpDRXZqZGlwVVFW?=
 =?utf-8?B?MnJIZlI0QitUSHU2aWRnRnFhTGdkLzJnZDg4dDBaSURGNU9hS1NzdVE0N2RB?=
 =?utf-8?B?M1BPRWJPU3AzMjYwT2N3bk9GbHRQSjV2VEw5UCt2d3JZQ3RHNmNaN0FXMmVR?=
 =?utf-8?B?cTNJYzJCWDJJaTFYWktFaXZLdEU2QTExSWNQTkZMRmx5czBiZythWlRiWUJX?=
 =?utf-8?B?T2ZBRGUweTRnUWJTYmJuZkl5UTZ5bjRmVHdLL0JFdGNBckJCd0RaNkFBTm16?=
 =?utf-8?B?S0plNkxlbzk4bGtaZVJUdnVRNXFZU3QwaEppK0ZDNXJSZ2hoc1FVM2RqaVJK?=
 =?utf-8?B?L1Z2djMyOGNpQitTZnJBV3pBcDErT3ZtVk9UTmh2T2JEcC9zbW5ta1hwc0x4?=
 =?utf-8?B?ZjZkVjJIemw5Z1JKUkhOTUFRT0hmcGxEZFdWVFRSdnIxNVcvMkZEMkF2eFVC?=
 =?utf-8?B?MGVDOThnZEs0MGR2WW80bGR5cVc4a2h6MGEvQkozaCtFNEZ0bmZLN0VHaXdS?=
 =?utf-8?B?cWpFd3BZZ25INnNJUnQwTTBmSkZLQjVIazFVK0hlRndxczZuRFJ5UkdKbzBk?=
 =?utf-8?B?QnJTUlJaOUw1KzYyZkwweGZXV2UwNUVYeUZQdGwrZUpiMEVqTEpIeUs1dnN2?=
 =?utf-8?B?OEh3ZW5VbTNRZVdacktOeWFVOVdZVE84K1pZNHJaWEc1VW1JRzk2SXpvM05v?=
 =?utf-8?B?anZTY2RaVUNGS2RuMXF0NkVucVR3MHh2S1R0V2FySW15VzdONlM2TU8wK3BK?=
 =?utf-8?B?dnFuekdTdlJEUW4weUpGNjhaSElMNTRkMlZwaVZnVmJweWRPS2dtb1hiNzJB?=
 =?utf-8?B?K1hFaFZ5d3ZidHJ3RWgvd1VJS0RzeHVZRUpIUHhFaTRINGdySzIwazBGWjBo?=
 =?utf-8?B?dyt6L2RFWDFqUm9FNmF3TlZPTldOTzJybTQ3cmtiM2RYQmVxNmtidTJXcTAw?=
 =?utf-8?B?cGF4cFNBRFhUekwzYjBvR3paNG0vUE1yb2ZpSG1acHJOaEgvbGdGMG10Znhj?=
 =?utf-8?B?NkNrZXFwNmJqaGFOKzZmYU9xdGs0MXlkMWZ6c3VBRHRsWDNPK0dmTU1CUGwv?=
 =?utf-8?Q?fBTE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b17175-899e-4afc-d393-08dd99fd8b26
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 13:27:19.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd6Sq54G92/4QTqK1SjWibmybTY+Z6IPzj7kkb8/4ScDWrHCfH/0qtxHLwyZM0Vz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6810
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

On 5/23/25 05:04, Alex Deucher wrote:
> On Thu, May 22, 2025 at 5:57 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>>
>> This set improves per queue reset support for GC10+.
>> This uses vmid resets for GFX.  GFX resets all state
>> associated with a vmid and then continues where it
>> left off.  Since once the IB uses the vmid, only
>> the IB is reset and execution continues after the IB.
>> Tested on GC 10 and 11 chips with a game running and
>> then running hang tests.  The game pauses when the
>> hang happens, then continues after the queue reset.
> 
> After further investigation, this appears to work as expected, but
> only by chance.  The ring is reset, but any pipelined content in the
> ring after the job is lost.  We either need to limit the ring to one
> job or patch in the subsequent packets after resetting.

Yeah, I feared that this wouldn't work.

Any idea why the VMID based reset isn't working?

On the other hand we could just restart from the ring RPTR again.

Regards,
Christian.

> 
> Alex
> 
>>
>> I tried this same approach and GC8 and 9, but it
>> was not as reliable as soft recovery.  I also compared
>> this to Christian's reset patches, but I was not
>> able to make them work as reliably as this series.
>>
>> Alex Deucher (9):
>>   Revert "drm/amd/amdgpu: add pipe1 hardware support"
>>   drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
>>   drm/amdgpu: set the exec flag on the IB fence
>>   drm/amdgpu/gfx11: adjust ring reset sequences
>>   drm/amdgpu/gfx11: drop soft recovery
>>   drm/amdgpu/gfx12: adjust ring reset sequences
>>   drm/amdgpu/gfx12: drop soft recovery
>>   drm/amdgpu/gfx10: adjust ring reset sequences
>>   drm/amdgpu/gfx10: drop soft recovery
>>
>> Christian König (1):
>>   drm/amdgpu: rework queue reset scheduler interaction
>>
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  3 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++--------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 41 ++++++++-----------------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 35 ++++++---------------
>>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 35 ++++++---------------
>>  drivers/gpu/drm/amd/amdgpu/nvd.h        |  1 +
>>  7 files changed, 50 insertions(+), 92 deletions(-)
>>
>> --
>> 2.49.0
>>

