Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89723C38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 09:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48ED10E5B4;
	Tue,  6 Sep 2022 09:02:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFA610E5B4
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Sep 2022 09:02:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9eKVYjdObCBAwG0dG2IZrepi7m+V7U3NwRDHMxmNhKiFJ7zYST3VJYgkcrNUU+VZTN0qe66zEitjFmrAG0cDV6Ouq2XdZQtT3MKAteyaeTrluyoQnM+k0pI37YC8pnEGbkdvYJQVGIaVVgTCUBW7ZcbLSQLe7lz49Lz3SvmiBGyetQCCKBU6A4QfnfbGCwkix7lvrh0JEcYo8zy4PToESQ+SqFSryRUPSnuAWMCC/t7WdXTcmpyogLfWtDRdF5plbJyrXghBc8CXpadmxBKLpyPtRyzje8eRkXY7D0JVuZIpHhNkG+eRn4/PIB7LW0/Pnfjz5ak1Uf3st+BMab8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTicHa4uQ3OphI5cHw3wxyMZLoWPbzSrf2Xo6F1o1T4=;
 b=Y00VjseUoUgrMwhQc5G8vKQe/pWzP9HhfZeKlXGUnuf0H/uNDV5agctJOxH68JqQqyn5/rqMyqoE5CoVEiVPiC1pobhaztADsdEpf+BUQd1U6J3jbBv6VnVEABNovdE7de//xVhFWD4INji50g1JA38mpg1RLcHFuLWRkVT8zaMbNrme8l51cDkqj0kuu3zJi2S4vHI5v1zds7ir2WINX4R4M3iOyikb9JmyCM5L269dGQ0mcS3gg1rxgy+TWWlqIPn7vsA/k4bRRSYregjb1fJInzdYc3RYGJyA7ewtXxfbEfeKrj8BnIF+1C01ig7uobi3ZsakpzQo13e44hvUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTicHa4uQ3OphI5cHw3wxyMZLoWPbzSrf2Xo6F1o1T4=;
 b=5P5JeVWdc/Y+r+6KPhGi1mtjFh7tHY7UVzOIH4uFqcxQgxTuR1GnUIgqp/lpd2ck74y45mYKhC8oCyPR3Tq6vXLS0CZg2dkKV+jv2XmC/NjEv8RhuqroEzMjH2IZxZGD7prOHGD++KJhHXccLrDd1BtQEDGAGFRd9uTjTdjTNIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Tue, 6 Sep
 2022 09:02:22 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::a997:c7f:aea0:764a%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 09:02:22 +0000
Message-ID: <eae05187-67a4-d159-79fb-c82cec0a5d2b@amd.com>
Date: Tue, 6 Sep 2022 11:02:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Gang submit
Content-Language: en-US
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Olsak, Marek" <Marek.Olsak@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
 <BL1PR12MB52691BCF633B4F87318AE9CC847E9@BL1PR12MB5269.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <BL1PR12MB52691BCF633B4F87318AE9CC847E9@BL1PR12MB5269.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0055.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::32) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8b66269-b15c-4dc5-2244-08da8fe68275
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qH/wPadagu8Jt2yIbCMWVc4CJYPt5EEt7HOuC1odz8tlpH+kO621I0j4WuC7gjyiuy38Cf/rqSlkWeLvHSrCZnEdmYa89DPN4kq9mddQ4z6QRQfucPuRtwPsWZDe3E7/XHQeJ7aODnSkcgdBJ2qvDmzjHxz4ak7m/3IYsBgp272Xnx4bxBSO6Y3gomYMLICyw8GCJ5vPQkjPdlxmiokP/QO1PkAkTII67IaeY3ERmsK0mmWkX4XyTFzW5f5Ip0xT5BiBllTrSQPS+IgiMSWf/Zlc7Y7THYqXyd64aETA23BzOLLczCG8Rd0txevMCCGYZNiQ89ngBi/1nLIsC0l+RX1QdikNhG5/M/mFTfJApbBd5gBrAjk283gYjgkxy2g3fUc3CglmcntTGCx9o8Y7kvm/x4UwnOwYYwind3jtQTA4Hx6nlx+oNeuqz7G/vcVLOfhU8Rwn1G0SqkgVlHNCdb1TOK+r+9+YjpaaF3PsZ5yjKVtBEOCJvExYk7+qF8qlIlDZcJ33Uj4qCApW7PvWjx/lkWllV6n9Sw49Mwaem5aG05TNZkNKY97AG/070PKtVzsk1j8+kwhHQPlKm6Y065RBD1UtJRPqEvathEmVdLCJ/UxzAvURrSqQbt14H3nS0LVEVcqah13+seYgM5LD3jt1aoBvSmwLsXBwqVVK8Jhof4sAVjmX9Qz3WcAXngpvPj1VDhYqQYGVn38xAbP9BUkz1kRGPB9yK083cWN0Km2C8wnUT00wY0KAUyOsAQbWCjcv3CNzDnoKU2kEJVyf9wloKZ017qBE01CmF1gQAIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(86362001)(3480700007)(31696002)(6636002)(38100700002)(316002)(2906002)(8936002)(5660300002)(110136005)(186003)(8676002)(66476007)(7116003)(66946007)(66556008)(83380400001)(2616005)(478600001)(66574015)(6486002)(53546011)(6512007)(41300700001)(6666004)(31686004)(6506007)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNIT2FPWTA5OTNwVTN3eU1rWVloUkszOTJLcWxTMjhLUFdIZi9pdUhwNXFK?=
 =?utf-8?B?VDd4Q2JJamhCMHpVcmNNL1p6b1VHcE5CcWxEbmRwM0dnbTZobXR1aXRSSURz?=
 =?utf-8?B?MGxyZk9KOUU5NzVrTTVpOXZtWnUvMUU2MzlkOEJvL0EzdjB2ZC9wZ01vR3RN?=
 =?utf-8?B?NWY5eXR1aWF4emtsNjNoYys1NzVmcjFmZnA4eGpJZkZTY2RyeTN4WHgvd1Yv?=
 =?utf-8?B?MkU2a1B1Ui9ja1ljWlExMkxmUjlXT2xiYUtjZzEyZlJXd3VPT1lqSElacElO?=
 =?utf-8?B?a21HcWZnMWUxZjg0UXB0dXZ0aUw5ZzVha3VyY0VLaU5VQUJVcHYwd2xQNVcv?=
 =?utf-8?B?bzUrSkVlT1REQVd4OVJUcHVaa0Z5ZmFFdUthNWYzaThFYWcxYUFKUUZ5V24y?=
 =?utf-8?B?NlM1WTRNaHZneDQvUFB3S1hrWDdYNHRHUFB1dGdoQ1ZpYVROS3h3T0d0UHdl?=
 =?utf-8?B?OUhvSUxMc1Rrck10M0NvWE5oOS9pT2k5b1hTUGpCRHE4MVpnSElHeUlsbndE?=
 =?utf-8?B?QWFrdC8yOURHazlMNFIrZW9DcVZqczJvcndvMVExa1ZCTzBlb3ZwZU1iNWRp?=
 =?utf-8?B?alZQK2d0Q1cxSmNHUE0rT0o5M0htYWdjaGZFVVFteWhCbTVXdkVPTnBLeHpL?=
 =?utf-8?B?TWtqVEJnSXZ6VDhKd1hCNWdUbWhzVE9qUU4rVzlDZC81VFZualdQSEVXSnVE?=
 =?utf-8?B?NExTcWFEKytTazMvTkpLeGM2alhGYVJhT0QyYnVTcU5FMm1nbkR0WEV3OEhy?=
 =?utf-8?B?a0ZZMm00R1RpV1dybjMyczJwODRHbm12NjZJb2FYR2JTZkxBL2h4R3pMdGtS?=
 =?utf-8?B?Q1lvRTJrYmQ4V3c3WjVpVk1OSkdyZzFYeUJkcU1qbzRBNzVia3dPSFZ2emo1?=
 =?utf-8?B?NnN6alZJQ2lZbkFNTzJzV1ZRTjkzSHZNWlFvRXMzRmVRelJocUFqWjJLVTFa?=
 =?utf-8?B?OGNSWEhJM216UUVwQVgybkZpRU40TlRtMGtDMFFUTHRtUjZ6TVZrRG43ekFt?=
 =?utf-8?B?K1hiWTAydkxXajlhc3o4UXV2a3J2TUwvalI5NmhVSzE4ckl4anVaZmM4ZTR0?=
 =?utf-8?B?VTZjQjM1eGNUNmlGc0hEaG1rY3VjNWlUNFNDZjYzSU9ib1lZOE41eWtXZENQ?=
 =?utf-8?B?Ni9nSEVFdmc2eG9DUkplK3JDZXZSL2hiMFJUY2lGMmxQVEpIdUFPT2t3K0p6?=
 =?utf-8?B?OTFSbjAxeEQyMENGSm94NUwzODJxK2gyY0ZMR0RNd3d3VXZTcEhoREdaNzR4?=
 =?utf-8?B?dVFLREd3NlJqb0d4OGoxVnhoRFNNZW1EQW03eEZrRDIzQjhFcmJLVGhEZ0Zw?=
 =?utf-8?B?anExUi9UZ0JlajZUbDJMbHFHL2o5YWpYcFUrM0tsVVpjUHlZMWdaT2o3QXE0?=
 =?utf-8?B?RDZIWS8rMTFsNENnUkdiN01LbmVlVFpVMTVmYTBOeFNoNURkajg5c2Q2NEdx?=
 =?utf-8?B?a2JDZXFESFRqQ2MvOEdVZkxtb2hYbE1GanJXMHNmZ2dNNGo4Mm9HaXg5Wkdn?=
 =?utf-8?B?VmI1WU9lb2xNbjRyRVVMTytSV0c3VS90bjJMamVDak9waFExYjI1WjF0bDFr?=
 =?utf-8?B?QklGSmd0RVBUVkF3QVFjN21rM0ZLQW9KVlhxekVzMWk1NjN2MVN6Z0s0YXlY?=
 =?utf-8?B?bE52UmFGalUyanU0Z1AvV1pEWm1KUlhTN0U0aUd2RG9SSWZ0WVQxdWk3aG1u?=
 =?utf-8?B?QS9DRGlVc1B1Qkw0QVRzUWJ0WlhBRHlGaVJ5cms4dHZxNzNYcWhwdG1ubTVt?=
 =?utf-8?B?VDZmbUh6akZpNW50dVR2cnRneGRsMkRhYjZlK2tVbUpFRHhUQkpCNllqTVFE?=
 =?utf-8?B?c1EvbS9DcnhWUEtIdCs2WFlSSWN3QzlKVldLODZ5QnBxVVJKZ0RRVWhNUXZM?=
 =?utf-8?B?VWlKS0J3enhuYlJMcDd3a0hjcnVRSlFHYnpGZHM3THYyUGRNcFUwdkVxQWds?=
 =?utf-8?B?TEcvb1o1dDYzRE9zeEVLdDlsZldBMUR3ZUREM3lTQTZ6bjMvWEJ6UVhVU0J1?=
 =?utf-8?B?OUNuS3NmUXoySGJXN2RxY3JidVVIcHBRRFk0NHpHTjRxRStRT0FnTmt2aE9O?=
 =?utf-8?B?UTdwNGdERE5ZZlF3RFNVZ3NOaTlqKzhSNnQxNnN5THR2c0NkcDQxRFlMeHk4?=
 =?utf-8?B?V0hmUHNhM2h3M0w0b0hqMUM0K0FZbTlvb3NkZUJwUmREZlZ1dXNOSklIaHo5?=
 =?utf-8?Q?PgswIa8P6PalSQX3KLh8c40G/Pa/F5mwOVjmDuvX8tiM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b66269-b15c-4dc5-2244-08da8fe68275
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:02:22.2342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/StTIwUaSt/k8PYubzT1VtWbK5VkOUBB+j4FKO63s6Bk1OdR2EflHA6b2O5yzfl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

Hi Monk,

> If one gfx ib and one compute ib are in a gang, can they run literally  in parallel on GPU ?

Yes, that is essentially the functionality of gang submit.

The driver stack must guarantee that those IBs run at the same time 
because they use a ring buffer to communicate with each other.

> if one gfx ib and one compute ib are belong to two gang, they will be put to the gfx and compute ring one by one (e.g:  gang1-gfx-ib scheduled and signaled, and then gang2-compute-ib scheduled )

Yes, gang submission should never overlap or otherwise you can run into 
lockups.

Regards,
Christian.

Am 06.09.22 um 03:43 schrieb Liu, Monk:
> [AMD Official Use Only - General]
>
> Hi Christian
>
>
>> A gang submission guarantees that multiple IBs can run on different engines at the same time.
>> The effect is that as long as members of a gang are waiting to be submitted no other gang can start pushing jobs to the hardware and so deadlocks are effectively prevented.
> Could you please help to explain or confirm:
>
> 1) If one gfx ib and one compute ib are in a gang, can they run literally  in parallel on GPU ?
> 2) if one gfx ib and one compute ib are belong to two gang, they will be put to the gfx and compute ring one by one (e.g:  gang1-gfx-ib scheduled and signaled, and then gang2-compute-ib scheduled )
>
> Thanks
> -------------------------------------------------------------------
> Monk Liu | Cloud GPU & Virtualization Solution | AMD
> -------------------------------------------------------------------
> we are hiring software manager for CVS core team
> -------------------------------------------------------------------
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
> Sent: 2022年3月3日 16:23
> To: amd-gfx@lists.freedesktop.org; Olsak, Marek <Marek.Olsak@amd.com>
> Subject: Gang submit
>
> Hi guys,
>
> this patch set implements the the requirement for so called gang submissions in the CS interface.
>
> A gang submission guarantees that multiple IBs can run on different engines at the same time.
>
> This is implemented by keeping a global per-device gang around represented by a dma_fence which signals as soon as all jobs in a gang are pushed to the hardware.
>
> The effect is that as long as members of a gang are waiting to be submitted no other gang can start pushing jobs to the hardware and so deadlocks are effectively prevented.
>
> The whole set is based on top of my dma_resv_usage work and a few patches merged over from amd-staging-drm-next, so it won't easily apply anywhere.
>
> Please review and comment,
> Christian.
>

