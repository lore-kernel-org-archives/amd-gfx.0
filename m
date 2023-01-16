Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0509FC46467
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 11:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA65110E3CF;
	Mon, 16 Jan 2023 11:31:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B760F10E3CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 11:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1TTZOajzgL7MSnLwlWPFw8tOW79zAQEn53uqrfx7S1ZuTHXQAYz8uDs0fJEn9gt6SFq5IjWoFq4UsvaYnRA18kcof616+ImRoDW0s2XLMXoe7sZt65wLlBRt+1WIm5boOM8A1lSaMZ8Aof8QT3kMSnccT9MIz/ZCkTZj6LEbO62PX2AzPbW1f7LbtOevSkQBmf3tMMT+ytXL4UusvDBad+Q8FSSQ2aUS3ivTwn3tPsdp8+1iU6c0EkDKD/wYm9jrsf0ZBe/GockQMzVNsYhGrArnRD0hPyeMHUqWyBTjYRlBv9+tdTzsALaT4ojyNiFvIboe6n0WBDmnyL+Ya+BuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amq0Cy6MZxQXMx3fiK7UpRRwm1IJM9uQJfRIcUaahXs=;
 b=bBNwLkB4uD6s8dZWoIAFk5dpC74zbeUdVYEc6Tv1JkEvn3dYRGVd3VLRjRYw3P9k3lC+vhgQxg7ktHJpwSAunKFFPSCgZfuCXtt7fwMcHUoX/juHzyWsfmxjmiRVtE9TeA9rNlnFbUwX5xWUCf4scF/yFIMqc7yMnlcdZO+5L0L+ctNoUoU/sHXRXZtv72zVOIVri1aGvx+EqeT8hpA2AXBjeTasT3JUQr3vXLmvD+mF0z0y4ZVdArEiImhPe9GRrQKd8RFrL8d6kuQI+ybfv+TzUyDFA1xxMPlbM1Liyt4yyfMYdz8u2YNvuPePNbCluYd5supXekBe30iaYuIZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amq0Cy6MZxQXMx3fiK7UpRRwm1IJM9uQJfRIcUaahXs=;
 b=gKRS9byeFV5VQ3oIS1K/Cd91bR1eqLVX0zRhm6JMB0VBJeNdmJAen2U5a38jEq+Y6L+8IFoq8OqzTN/lPYkEzdRDQPUrL/QkaMPzZY2GutiHt3IqKJuU62cT+TsUWFsK4fMQTPuirzRnOmrqfhGv90g4u+4WcG0orfyaodcjcbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SA0PR12MB7480.namprd12.prod.outlook.com (2603:10b6:806:24b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 11:31:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::80d8:934f:caa7:67b0%3]) with mapi id 15.20.5986.022; Mon, 16 Jan 2023
 11:31:06 +0000
Content-Type: multipart/alternative;
 boundary="------------Rp610wY1QsB3zbTu1DItPGZ2"
Message-ID: <35c28517-cafc-168f-eee9-2c4cbc572814@amd.com>
Date: Mon, 16 Jan 2023 12:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen and lanes from the
 INFO
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <CAAxE2A720cJguG5b+0zbP=G4TxTjpqKBvOqDXXAP0LWHZEuj0A@mail.gmail.com>
 <35304b1e-98a7-d342-9f1b-50f07b45cf98@gmail.com>
 <CAAxE2A6KJWPJ3eqKoaiJZUJCNqRpx+WYwoGEZKxX2Kf_auLUWg@mail.gmail.com>
 <a90b0e8e-dd02-031f-0432-1c5f6f02e949@amd.com>
 <CAAxE2A7PJdiPORP-X+7kFmix9pCo63PqeamP20BZJx4GDfJdEQ@mail.gmail.com>
 <8ec2b238-fa8b-a693-b9d9-3a590cc05664@amd.com>
 <CAAxE2A7G_gjvuGNNtZ6J-4R25Ykx8ziz1B2f0Dc3KuC4KeYdzA@mail.gmail.com>
 <BYAPR12MB461473D2083BC8B9FB012AC297F59@BYAPR12MB4614.namprd12.prod.outlook.com>
 <CAAxE2A4F59qttYfrT66v4Fe0D1h4Km=DLY779uC=HHSGswg4Lg@mail.gmail.com>
 <CADnq5_MLO4FLXrmUXPUzo2UBzqxa_hjfL0qBzibWAqO79uhxvw@mail.gmail.com>
 <e931b723-d4bf-be9c-0f08-6f3bf00eb938@amd.com>
 <CADnq5_NOmdq9_kUzm9cnavyn6czx18-kKmLm0-R6msRdqOwXsA@mail.gmail.com>
 <CAAxE2A7QvaE3triTt6vAYuWmkaG6DRZsdkQrLJcpDXj96-GO9w@mail.gmail.com>
 <CADnq5_Pr+8vdtEtn4K5kd-ssbvsGAf2_wnsqAkMpLJUPW+55_g@mail.gmail.com>
 <CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SA0PR12MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 53b1f50a-14b7-48de-1eca-08daf7b52856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: reTMLJxRmnaORjrKNtA7PwOMAftHyErBoKB0Y9h+wocVGtLWKsuS+jLHVzkSQpJk+5tOIwuPygeL9h/eXcnRzKijgBBG0Kd1RjyfyC/5I6kuQDGlKezy7mwO9oJJvQVLAB/RcLgFbPgaN/B206n5uX8AzQFdIp5p/U8nRNaltj/yVCVjhug3mmr07KTeBAgEPaAkvJkNs/4Cfqs7BDzTCl5ju3r5WZt9/XowS+85AkIvvmTHRkYjPZIbqa8Mj0TUlvGYH5dTl02HDOPihiOpTw5i2t/QYrmYXT/BIaID5HnR9L8QPwvfnvwqFvsgB7FQ4ENuokon7jtkEk7Ii7W/Hk6trjbQKMPw/6op6fQWNjW4cfmGCENEwwTfQdoKTgVorbmHqvx7RzbuHuU07WkwSCnpQPjQHbzs7XNifGuG5Rn4Q1IcVcoJ7ciArSOoQzi5x5MRuQ8+ePPxRVZLr3038u8hbeaxqGRJIbaVJIItRdkhX3Niqru/JjASDrCwVAdE3NbBijw9+9sZomfaQPIBRFdX9N2j/QnZQT1GAA6O7xsLqZgvBZL87H9iigjlhCbLuHIo2+3/HrH0hL/6M21LQYnQxBjC4UBlL5m5ErRNZfQYbIEkVIhvnHdeBneknI4Y8gmDCMsIesBMlJv74eVXQqyftRGqJ8eXxPcyHQg98fb7vmk7hheGVCGCdxb5JOWoErFH9O+2r856HWT2vTqfZFq82wRBuKXZ+pYbw7/xlUU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199015)(83380400001)(66574015)(36756003)(38100700002)(316002)(2906002)(478600001)(6506007)(31696002)(33964004)(6512007)(53546011)(186003)(26005)(66476007)(6486002)(66556008)(54906003)(6666004)(86362001)(110136005)(8936002)(5660300002)(30864003)(66946007)(4326008)(8676002)(41300700001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlUzdEVxN2tpbWNBbUxuK2dHSGdySWlZb0gvWWdsVXhDVHNiRjJzNlZOSWdY?=
 =?utf-8?B?QTZTbXN5M0dDRlo5OFZlMldSZU9PdUdJM1ZGM2tpaGJOaTJVeXZ5ZWp1dDFQ?=
 =?utf-8?B?SThmaFYzQzZVcGZ6VDlML01KU1FaNE9RRkNlLzExZ1VWZ1R1c3A0RTdtQnYw?=
 =?utf-8?B?dGNBYWV5Z29zQ1Q3bG1oSEZuWFFZRUk1dExpdGxkdDROUU9MSFVpQlkweTFn?=
 =?utf-8?B?S2kySFI2ZWhzU09rZWtFMFdTV0RVdlNQR3orY09TYmREejlMMkwvK2Z2YzQ5?=
 =?utf-8?B?NlA0dUhzZ2QwOHQ3cGZKQS9BcUhjcGdpTytDYkVCUDRicFhFY3BFeEZWamE5?=
 =?utf-8?B?Kzkzem9TbTk2d09JMmhucEQvNWR6Smp1ZmpHaC8yeWQyUngyRzFVVDhKLysw?=
 =?utf-8?B?STU2YW1LSE5NZTh0V09TZXlOVVJtbUkyTWhELzdLdytWNCs1S3hZeGxib0ph?=
 =?utf-8?B?dHg4Mm91MFlianREMTFrZmtRcmVSbzZFNlVZKzRmdjFIRFhKT2xVcUdkU0pl?=
 =?utf-8?B?K3dyRVRzRUZaYUFIUlltai94KzlZeWc1eXJjOVhHWTV2TzZZc05vOGNQeitX?=
 =?utf-8?B?ejBxNEY0dXN0MGt0dTFkbDJLNFFWOHhWNzBrLzEwNjd2Sjd1a3FuQkgzZmVs?=
 =?utf-8?B?MlkvYXlYd1JRTzNsVTNLTFNQb096UCtLamtFUHZRTk1xTmFaWVVpQXZFRGJj?=
 =?utf-8?B?ak1pUSt5dmtSVW5ORmpyT3dWRXVEV2hLeHRIaXh1d05wR0RudW1ybExEZnlt?=
 =?utf-8?B?dE9WTHVQT2hSZW9uWGRpNkRjN09TR1JCZ3pJUkV5dGxibGQ0YlEwUU4wenA2?=
 =?utf-8?B?bGIwTUoweVUvTEc5QkpnN21uUS9rMnpsNnNWemduTWs3c2dudU5vUVJMc3JW?=
 =?utf-8?B?dUlWTEwwQWdPN0l4ZlZvRS95MVpnTEpEbjhJaEk4YVFXb3pIa1hYOEN6Yy9H?=
 =?utf-8?B?SFI5SmVoVTdTc01rakVUL2NFZEtwTC9qQS9rR1dmRmw0QVpZUVVNS2Z1MHFZ?=
 =?utf-8?B?d0YyY2lkeGVETjdtb1FaRFVIR3Zpbkk2ckJHT2U1cUZ5RngxdllVbUtSdW9v?=
 =?utf-8?B?NWdTZG90RFEwSUpVWUtmRTl0WWc5blFkL0RoSHQreXpqS29BUUlpSzBXT1JF?=
 =?utf-8?B?V0NNaXZkVVM2MGxvYjRFRVRldkh3UERPNTZ2amFmOUhqTkU0ak1rYW1pL1p5?=
 =?utf-8?B?Z1hDMHR5aDRJVmMxV2hUcExEOFo4cU1ybjFqMmRxaUw1ZW96V1FrQjNwd0c5?=
 =?utf-8?B?a0NKUVgyeGZrUmZ0aHpGOCtCODJhdmpNTVg5WEZjaGRKcnNWNVF1SkkvMnVa?=
 =?utf-8?B?UFFRNFZvaUdOWi9VZEhEOVFYOGtrK0Y1b3RScXFxRjMwakswSTBtanNCU0Yv?=
 =?utf-8?B?NlJDbVdMcHY2REtxSURyZ0ZhN21zZGpJTVFGSVQwd3E0eVpTUzR5K3IrTytw?=
 =?utf-8?B?YlBWcUhJRFN0Tmc3RE13b01MWEsrT2hneWliRHN2V0tFaGwzMVJEemhXL2Js?=
 =?utf-8?B?MHQvcFBXd1pZQm9rVjgvUG0zaEFnYzc5TEJWRGJWN1FnaklYbnY3YWJPWStn?=
 =?utf-8?B?dGlhWVViczZZa0o3Rnl3c3ZIWGc3L1FUTWhEZ2NYcDBzMG9ka3ZpajBpRDdW?=
 =?utf-8?B?SGlkVXpXTWF3MEVNUXZJRkNWcEpNV0RIS0t2WGhTSEVTbkR4ejJTVDZUb3dn?=
 =?utf-8?B?ak5td1ZyakNyTTVobThTWlJvRXBONVJialcxeGp3M1gwVVhqcDZadldXQ2U4?=
 =?utf-8?B?Yldwb29tS3hFRVpSMDVTQy9jbjZjZ2ZXclRNQlFzcG5rMGdKS2ZHZ2daTy91?=
 =?utf-8?B?U3JJMGVKaEJlNkZ6K1Q4ZUgrdkR2SXRBV0hYMEViQjM1S3o0ZXp0dG96VzNw?=
 =?utf-8?B?SWY5b09GZXZmZGRkSHJ2SUpld2t0djNxeXg5MVJnckFwdHNYYzBvU1JHVExM?=
 =?utf-8?B?WTJFZGxIWUNpT29DSEtYbUVpaWhIY3dLMXRGWHMyeUdOSTRiYTVxZWcrMGlL?=
 =?utf-8?B?Vi9BcE1nWlhaK1g0T3pTRHlIQjRBa3dRT1pYUHF0OXJua2RVSEg3eTFpN1JQ?=
 =?utf-8?B?VlNJOHRJb3Q5NStlM2NYNE9LQkU5ODMveUYxRmJvV0pQN0V4WjFyQjIvZGRz?=
 =?utf-8?Q?1pAH42fMkbvEUz+YBrqpwVuvA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b1f50a-14b7-48de-1eca-08daf7b52856
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 11:31:06.6876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRKFekyrp6kjHjs6dIQYm1j2/w8FuzehNghF2hY7fu92dqWjB4pn3rPKAFTpMKIa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7480
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------Rp610wY1QsB3zbTu1DItPGZ2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Mhm, that sucks. Could we have the automated builds check for paddings 
in the UAPi data structure?

Christian.

Am 14.01.23 um 00:33 schrieb Marek Olšák:
> There is no hole on 32-bit unfortunately. It looks like the hole on 
> 64-bit is now ABI.
>
> I moved the field to replace _pad1. The patch is attached (with your Rb).
>
> Marek
>
> On Fri, Jan 13, 2023 at 4:20 PM Alex Deucher <alexdeucher@gmail.com> 
> wrote:
>
>     On Fri, Jan 13, 2023 at 4:02 PM Marek Olšák <maraeo@gmail.com> wrote:
>     >
>     > i've added the comments and indeed pahole shows the hole as
>     expected.
>
>     What about on 32-bit?
>
>     Alex
>
>     >
>     > Marek
>     >
>     > On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher
>     <alexdeucher@gmail.com> wrote:
>     >>
>     >> On Thu, Jan 12, 2023 at 6:50 AM Christian König
>     >> <christian.koenig@amd.com> wrote:
>     >> >
>     >> > Am 11.01.23 um 21:48 schrieb Alex Deucher:
>     >> > > On Wed, Jan 4, 2023 at 3:17 PM Marek Olšák
>     <maraeo@gmail.com> wrote:
>     >> > >> Yes, it's meant to be like a spec sheet. We are not
>     interested in the current bandwidth utilization.
>     >> > > After chatting with Marek on IRC and thinking about this
>     more, I think
>     >> > > this patch is fine.  It's not really meant for bandwidth
>     per se, but
>     >> > > rather as a limit to determine what the driver should do in
>     certain
>     >> > > cases (i.e., when does it make sense to copy to vram vs
>     not).  It's
>     >> > > not straightforward for userspace to parse the full topology to
>     >> > > determine what links may be slow.  I guess one potential
>     pitfall would
>     >> > > be that if you pass the device into a VM, the driver may
>     report the
>     >> > > wrong values.  Generally in a VM the VM doesn't get the
>     full view up
>     >> > > to the root port.  I don't know if the hypervisors report
>     properly for
>     >> > > pcie_bandwidth_available() in a VM or if it just shows the
>     info about
>     >> > > the endpoint in the VM.
>     >> >
>     >> > So this basically doesn't return the gen and lanes of the
>     device, but
>     >> > rather what was negotiated between the device and the
>     upstream root port?
>     >>
>     >> Correct. It exposes the max gen and lanes of the slowest link
>     between
>     >> the device and the root port.
>     >>
>     >> >
>     >> > If I got that correctly then we should probably document that
>     cause
>     >> > otherwise somebody will try to "fix" it at some time.
>     >>
>     >> Good point.
>     >>
>     >> Alex
>     >>
>     >> >
>     >> > Christian.
>     >> >
>     >> > >
>     >> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>     >> > >
>     >> > > Alex
>     >> > >
>     >> > >> Marek
>     >> > >>
>     >> > >> On Wed, Jan 4, 2023 at 10:33 AM Lazar, Lijo
>     <Lijo.Lazar@amd.com> wrote:
>     >> > >>> [AMD Official Use Only - General]
>     >> > >>>
>     >> > >>>
>     >> > >>> To clarify, with DPM in place, the current bandwidth will
>     be changing based on the load.
>     >> > >>>
>     >> > >>> If apps/umd already has a way to know the current
>     bandwidth utilisation, then possible maximum also could be part of
>     the same API. Otherwise, this only looks like duplicate
>     information. We have the same information in sysfs DPM nodes.
>     >> > >>>
>     >> > >>> BTW, I don't know to what extent app/umd really makes use
>     of this. Take that memory frequency as an example (I'm reading it
>     as 16GHz). It only looks like a spec sheet.
>     >> > >>>
>     >> > >>> Thanks,
>     >> > >>> Lijo
>     >> > >>> ________________________________
>     >> > >>> From: Marek Olšák <maraeo@gmail.com>
>     >> > >>> Sent: Wednesday, January 4, 2023 8:40:00 PM
>     >> > >>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>     >> > >>> Cc: amd-gfx@lists.freedesktop.org
>     <amd-gfx@lists.freedesktop.org>
>     >> > >>> Subject: Re: [PATCH 1/2] drm/amdgpu: return the PCIe gen
>     and lanes from the INFO
>     >> > >>>
>     >> > >>> On Wed, Jan 4, 2023 at 9:19 AM Lazar, Lijo
>     <lijo.lazar@amd.com> wrote:
>     >> > >>>
>     >> > >>>
>     >> > >>>
>     >> > >>> On 1/4/2023 7:43 PM, Marek Olšák wrote:
>     >> > >>>> On Wed, Jan 4, 2023 at 6:50 AM Lazar, Lijo
>     <lijo.lazar@amd.com
>     >> > >>>> <mailto:lijo.lazar@amd.com>> wrote:
>     >> > >>>>
>     >> > >>>>
>     >> > >>>>
>     >> > >>>>      On 1/4/2023 4:11 AM, Marek Olšák wrote:
>     >> > >>>>       > I see. Well, those sysfs files are not usable,
>     and I don't think it
>     >> > >>>>       > would be important even if they were usable, but
>     for completeness:
>     >> > >>>>       >
>     >> > >>>>       > The ioctl returns:
>     >> > >>>>       >      pcie_gen = 1
>     >> > >>>>       > pcie_num_lanes = 16
>     >> > >>>>       >
>     >> > >>>>       > Theoretical bandwidth from those values: 4.0 GB/s
>     >> > >>>>       > My DMA test shows this write bandwidth: 3.5 GB/s
>     >> > >>>>       > It matches the expectation.
>     >> > >>>>       >
>     >> > >>>>       > Let's see the devices (there is only 1 GPU
>     Navi21 in the system):
>     >> > >>>>       > $ lspci |egrep '(PCI|VGA).*Navi'
>     >> > >>>>       > 0a:00.0 PCI bridge: Advanced Micro Devices, Inc.
>     [AMD/ATI] Navi
>     >> > >>>>      10 XL
>     >> > >>>>       > Upstream Port of PCI Express Switch (rev c3)
>     >> > >>>>       > 0b:00.0 PCI bridge: Advanced Micro Devices, Inc.
>     [AMD/ATI] Navi
>     >> > >>>>      10 XL
>     >> > >>>>       > Downstream Port of PCI Express Switch
>     >> > >>>>       > 0c:00.0 VGA compatible controller: Advanced
>     Micro Devices, Inc.
>     >> > >>>>       > [AMD/ATI] Navi 21 [Radeon RX 6800/6800 XT / 6900
>     XT] (rev c3)
>     >> > >>>>       >
>     >> > >>>>       > Let's read sysfs:
>     >> > >>>>       >
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0a:00.0/current_link_width
>     >> > >>>>       > 16
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0b:00.0/current_link_width
>     >> > >>>>       > 16
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0c:00.0/current_link_width
>     >> > >>>>       > 16
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0a:00.0/current_link_speed
>     >> > >>>>       > 2.5 GT/s PCIe
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0b:00.0/current_link_speed
>     >> > >>>>       > 16.0 GT/s PCIe
>     >> > >>>>       > $ cat
>     /sys/bus/pci/devices/0000:0c:00.0/current_link_speed
>     >> > >>>>       > 16.0 GT/s PCIe
>     >> > >>>>       >
>     >> > >>>>       > Problem 1: None of the speed numbers match 4 GB/s.
>     >> > >>>>
>     >> > >>>>      US bridge = 2.5GT/s means operating at PCIe Gen 1
>     speed. Total
>     >> > >>>>      theoretical bandwidth is then derived based on
>     encoding and total
>     >> > >>>>      number
>     >> > >>>>      of lanes.
>     >> > >>>>
>     >> > >>>>       > Problem 2: Userspace doesn't know the bus index
>     of the bridges,
>     >> > >>>>      and it's
>     >> > >>>>       > not clear which bridge should be used.
>     >> > >>>>
>     >> > >>>>      In general, modern ones have this arch= US->DS->EP.
>     US is the one
>     >> > >>>>      connected to physical link.
>     >> > >>>>
>     >> > >>>>       > Problem 3: The PCIe gen number is missing.
>     >> > >>>>
>     >> > >>>>      Current link speed is based on whether it's
>     Gen1/2/3/4/5.
>     >> > >>>>
>     >> > >>>>      BTW, your patch makes use of capabilities flags
>     which gives the maximum
>     >> > >>>>      supported speed/width by the device. It may not
>     necessarily reflect the
>     >> > >>>>      current speed/width negotiated. I guess in NV, this
>     info is already
>     >> > >>>>      obtained from PMFW and made available through
>     metrics table.
>     >> > >>>>
>     >> > >>>>
>     >> > >>>> It computes the minimum of the device PCIe gen and the
>     motherboard/slot
>     >> > >>>> PCIe gen to get the final value. These 2 lines do that.
>     The low 16 bits
>     >> > >>>> of the mask contain the device PCIe gen mask. The high
>     16 bits of the
>     >> > >>>> mask contain the slot PCIe gen mask.
>     >> > >>>> + pcie_gen_mask = adev->pm.pcie_gen_mask &
>     (adev->pm.pcie_gen_mask >> 16);
>     >> > >>>> + dev_info->pcie_gen = fls(pcie_gen_mask);
>     >> > >>>>
>     >> > >>> With DPM in place on some ASICs, how much does this
>     static info help for
>     >> > >>> upper level apps?
>     >> > >>>
>     >> > >>>
>     >> > >>> It helps UMDs make better decisions if they know the
>     maximum achievable bandwidth. UMDs also compute the maximum memory
>     bandwidth and compute performance (FLOPS). Right now it's printed
>     by Mesa to give users detailed information about their GPU. For
>     example:
>     >> > >>>
>     >> > >>> $ AMD_DEBUG=info glxgears
>     >> > >>> Device info:
>     >> > >>>      name = NAVI21
>     >> > >>>      marketing_name = AMD Radeon RX 6800
>     >> > >>>      num_se = 3
>     >> > >>>      num_rb = 12
>     >> > >>>      num_cu = 60
>     >> > >>>      max_gpu_freq = 2475 MHz
>     >> > >>>      max_gflops = 19008 GFLOPS
>     >> > >>>      l0_cache_size = 16 KB
>     >> > >>>      l1_cache_size = 128 KB
>     >> > >>>      l2_cache_size = 4096 KB
>     >> > >>>      l3_cache_size = 128 MB
>     >> > >>>      memory_channels = 16 (TCC blocks)
>     >> > >>>      memory_size = 16 GB (16384 MB)
>     >> > >>>      memory_freq = 16 GHz
>     >> > >>>      memory_bus_width = 256 bits
>     >> > >>>      memory_bandwidth = 512 GB/s
>     >> > >>>      pcie_gen = 1
>     >> > >>>      pcie_num_lanes = 16
>     >> > >>>      pcie_bandwidth = 4.0 GB/s
>     >> > >>>
>     >> > >>> Marek
>     >> >
>

--------------Rp610wY1QsB3zbTu1DItPGZ2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Mhm, that sucks. Could we have the automated builds check for
    paddings in the UAPi data structure?<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 14.01.23 um 00:33 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite" cite="mid:CAAxE2A5xivt_4PK2uEkVS_v08viJVJP9E39DfTb4VsVCvDMkTw@mail.gmail.com">
      
      <div dir="ltr">
        <div>There is no hole on 32-bit unfortunately. It looks like the
          hole on 64-bit is now ABI.</div>
        <div><br>
        </div>
        <div>I moved the field to replace _pad1. The patch is attached
          (with your Rb).</div>
        <div><br>
        </div>
        <div>Marek</div>
        <div dir="ltr"><br>
        </div>
        <div dir="ltr">On Fri, Jan 13, 2023 at 4:20 PM Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true" class="moz-txt-link-freetext">alexdeucher@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <div class="gmail_quote">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">On Fri, Jan 13, 2023 at
            4:02 PM Marek Olšák &lt;<a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
            wrote:<br>
            &gt;<br>
            &gt; i've added the comments and indeed pahole shows the
            hole as expected.<br>
            <br>
            What about on 32-bit?<br>
            <br>
            Alex<br>
            <br>
            &gt;<br>
            &gt; Marek<br>
            &gt;<br>
            &gt; On Thu, Jan 12, 2023 at 11:44 AM Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexdeucher@gmail.com</a>&gt;
            wrote:<br>
            &gt;&gt;<br>
            &gt;&gt; On Thu, Jan 12, 2023 at 6:50 AM Christian König<br>
            &gt;&gt; &lt;<a href="mailto:christian.koenig@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">christian.koenig@amd.com</a>&gt;
            wrote:<br>
            &gt;&gt; &gt;<br>
            &gt;&gt; &gt; Am 11.01.23 um 21:48 schrieb Alex Deucher:<br>
            &gt;&gt; &gt; &gt; On Wed, Jan 4, 2023 at 3:17 PM Marek
            Olšák &lt;<a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;
            wrote:<br>
            &gt;&gt; &gt; &gt;&gt; Yes, it's meant to be like a spec
            sheet. We are not interested in the current bandwidth
            utilization.<br>
            &gt;&gt; &gt; &gt; After chatting with Marek on IRC and
            thinking about this more, I think<br>
            &gt;&gt; &gt; &gt; this patch is fine.&nbsp; It's not really
            meant for bandwidth per se, but<br>
            &gt;&gt; &gt; &gt; rather as a limit to determine what the
            driver should do in certain<br>
            &gt;&gt; &gt; &gt; cases (i.e., when does it make sense to
            copy to vram vs not).&nbsp; It's<br>
            &gt;&gt; &gt; &gt; not straightforward for userspace to
            parse the full topology to<br>
            &gt;&gt; &gt; &gt; determine what links may be slow.&nbsp; I
            guess one potential pitfall would<br>
            &gt;&gt; &gt; &gt; be that if you pass the device into a VM,
            the driver may report the<br>
            &gt;&gt; &gt; &gt; wrong values.&nbsp; Generally in a VM the VM
            doesn't get the full view up<br>
            &gt;&gt; &gt; &gt; to the root port.&nbsp; I don't know if the
            hypervisors report properly for<br>
            &gt;&gt; &gt; &gt; pcie_bandwidth_available() in a VM or if
            it just shows the info about<br>
            &gt;&gt; &gt; &gt; the endpoint in the VM.<br>
            &gt;&gt; &gt;<br>
            &gt;&gt; &gt; So this basically doesn't return the gen and
            lanes of the device, but<br>
            &gt;&gt; &gt; rather what was negotiated between the device
            and the upstream root port?<br>
            &gt;&gt;<br>
            &gt;&gt; Correct. It exposes the max gen and lanes of the
            slowest link between<br>
            &gt;&gt; the device and the root port.<br>
            &gt;&gt;<br>
            &gt;&gt; &gt;<br>
            &gt;&gt; &gt; If I got that correctly then we should
            probably document that cause<br>
            &gt;&gt; &gt; otherwise somebody will try to &quot;fix&quot; it at
            some time.<br>
            &gt;&gt;<br>
            &gt;&gt; Good point.<br>
            &gt;&gt;<br>
            &gt;&gt; Alex<br>
            &gt;&gt;<br>
            &gt;&gt; &gt;<br>
            &gt;&gt; &gt; Christian.<br>
            &gt;&gt; &gt;<br>
            &gt;&gt; &gt; &gt;<br>
            &gt;&gt; &gt; &gt; Reviewed-by: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
            &gt;&gt; &gt; &gt;<br>
            &gt;&gt; &gt; &gt; Alex<br>
            &gt;&gt; &gt; &gt;<br>
            &gt;&gt; &gt; &gt;&gt; Marek<br>
            &gt;&gt; &gt; &gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt; On Wed, Jan 4, 2023 at 10:33 AM
            Lazar, Lijo &lt;<a href="mailto:Lijo.Lazar@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Lijo.Lazar@amd.com</a>&gt;
            wrote:<br>
            &gt;&gt; &gt; &gt;&gt;&gt; [AMD Official Use Only - General]<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; To clarify, with DPM in place,
            the current bandwidth will be changing based on the load.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; If apps/umd already has a way to
            know the current bandwidth utilisation, then possible
            maximum also could be part of the same API. Otherwise, this
            only looks like duplicate information. We have the same
            information in sysfs DPM nodes.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; BTW, I don't know to what extent
            app/umd really makes use of this. Take that memory frequency
            as an example (I'm reading it as 16GHz). It only looks like
            a spec sheet.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Thanks,<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Lijo<br>
            &gt;&gt; &gt; &gt;&gt;&gt; ________________________________<br>
            &gt;&gt; &gt; &gt;&gt;&gt; From: Marek Olšák &lt;<a href="mailto:maraeo@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Sent: Wednesday, January 4, 2023
            8:40:00 PM<br>
            &gt;&gt; &gt; &gt;&gt;&gt; To: Lazar, Lijo &lt;<a href="mailto:Lijo.Lazar@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Lijo.Lazar@amd.com</a>&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Cc: <a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
            &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Subject: Re: [PATCH 1/2]
            drm/amdgpu: return the PCIe gen and lanes from the INFO<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; On Wed, Jan 4, 2023 at 9:19 AM
            Lazar, Lijo &lt;<a href="mailto:lijo.lazar@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lijo.lazar@amd.com</a>&gt;
            wrote:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; On 1/4/2023 7:43 PM, Marek Olšák
            wrote:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; On Wed, Jan 4, 2023 at 6:50
            AM Lazar, Lijo &lt;<a href="mailto:lijo.lazar@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lijo.lazar@amd.com</a><br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; &lt;mailto:<a href="mailto:lijo.lazar@amd.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">lijo.lazar@amd.com</a>&gt;&gt;
            wrote:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; On 1/4/2023 4:11 AM,
            Marek Olšák wrote:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; I see. Well, those
            sysfs files are not usable, and I don't think it<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; would be important
            even if they were usable, but for completeness:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; The ioctl returns:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;&nbsp; &nbsp; &nbsp; pcie_gen = 1<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;&nbsp; &nbsp; &nbsp;
            pcie_num_lanes = 16<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Theoretical
            bandwidth from those values: 4.0 GB/s<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; My DMA test shows
            this write bandwidth: 3.5 GB/s<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; It matches the
            expectation.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Let's see the
            devices (there is only 1 GPU Navi21 in the system):<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ lspci |egrep
            '(PCI|VGA).*Navi'<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 0a:00.0 PCI
            bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; 10 XL<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Upstream Port of
            PCI Express Switch (rev c3)<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 0b:00.0 PCI
            bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; 10 XL<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Downstream Port of
            PCI Express Switch<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 0c:00.0 VGA
            compatible controller: Advanced Micro Devices, Inc.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; [AMD/ATI] Navi 21
            [Radeon RX 6800/6800 XT / 6900 XT] (rev c3)<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Let's read sysfs:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0a:00.0/current_link_width<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 16<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0b:00.0/current_link_width<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 16<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0c:00.0/current_link_width<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 16<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0a:00.0/current_link_speed<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 2.5 GT/s PCIe<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0b:00.0/current_link_speed<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 16.0 GT/s PCIe<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; $ cat
            /sys/bus/pci/devices/0000:0c:00.0/current_link_speed<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; 16.0 GT/s PCIe<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Problem 1: None of
            the speed numbers match 4 GB/s.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; US bridge = 2.5GT/s
            means operating at PCIe Gen 1 speed. Total<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; theoretical bandwidth is
            then derived based on encoding and total<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; number<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; of lanes.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Problem 2:
            Userspace doesn't know the bus index of the bridges,<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; and it's<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; not clear which
            bridge should be used.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; In general, modern ones
            have this arch= US-&gt;DS-&gt;EP. US is the one<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; connected to physical
            link.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; &nbsp;&gt; Problem 3: The
            PCIe gen number is missing.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; Current link speed is
            based on whether it's Gen1/2/3/4/5.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; BTW, your patch makes
            use of capabilities flags which gives the maximum<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; supported speed/width by
            the device. It may not necessarily reflect the<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; current speed/width
            negotiated. I guess in NV, this info is already<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;&nbsp; &nbsp; &nbsp; obtained from PMFW and
            made available through metrics table.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; It computes the minimum of
            the device PCIe gen and the motherboard/slot<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; PCIe gen to get the final
            value. These 2 lines do that. The low 16 bits<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; of the mask contain the
            device PCIe gen mask. The high 16 bits of the<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; mask contain the slot PCIe
            gen mask.<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; + pcie_gen_mask =
            adev-&gt;pm.pcie_gen_mask &amp; (adev-&gt;pm.pcie_gen_mask
            &gt;&gt; 16);<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt; + dev_info-&gt;pcie_gen =
            fls(pcie_gen_mask);<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; With DPM in place on some ASICs,
            how much does this static info help for<br>
            &gt;&gt; &gt; &gt;&gt;&gt; upper level apps?<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; It helps UMDs make better
            decisions if they know the maximum achievable bandwidth.
            UMDs also compute the maximum memory bandwidth and compute
            performance (FLOPS). Right now it's printed by Mesa to give
            users detailed information about their GPU. For example:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; $ AMD_DEBUG=info glxgears<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Device info:<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; name = NAVI21<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; marketing_name = AMD Radeon
            RX 6800<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; num_se = 3<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; num_rb = 12<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; num_cu = 60<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; max_gpu_freq = 2475 MHz<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; max_gflops = 19008 GFLOPS<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; l0_cache_size = 16 KB<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; l1_cache_size = 128 KB<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; l2_cache_size = 4096 KB<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; l3_cache_size = 128 MB<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; memory_channels = 16 (TCC
            blocks)<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; memory_size = 16 GB (16384
            MB)<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; memory_freq = 16 GHz<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; memory_bus_width = 256 bits<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; memory_bandwidth = 512 GB/s<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; pcie_gen = 1<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; pcie_num_lanes = 16<br>
            &gt;&gt; &gt; &gt;&gt;&gt;&nbsp; &nbsp; &nbsp; pcie_bandwidth = 4.0 GB/s<br>
            &gt;&gt; &gt; &gt;&gt;&gt;<br>
            &gt;&gt; &gt; &gt;&gt;&gt; Marek<br>
            &gt;&gt; &gt;<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------Rp610wY1QsB3zbTu1DItPGZ2--
