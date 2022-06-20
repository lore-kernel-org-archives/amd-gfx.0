Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDA3CCA47C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 13:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC69810EC9D;
	Mon, 20 Jun 2022 13:26:51 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF41910EC9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 13:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKceBzlu0S+S6wMuNPkBVKvN2WeHOiEe8c0NvbR07JCF6EBL/Gmm3BjoD6zoGRvuPmshrO9U8nlLEJBOv5D76dh3Fy7mNTCoSBYJwXGCzV4bC7+K7ficxPKt8djYnZEnmDjIsjUxqg6zKxYF3ZBA5Ym8MWJeF7VlLz4OEH412mi56pBsoGl4GdxPNyjG5IeeT/zEUZ6jBe2vdfYM6PqVAS+33QIe91wCz/lEX/9IiMr0wDxg9d0sZpSYktPsY7tmyYZw/Wfmy0Y7xhtQiVFmbIilgoTsxsN37Qu4XKYXDEXegR0cp1jvqhFYKU+6DQZnsge5Cryib4H1Y9yVaeqNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCsX1GT0ILs3jdtvpvMJ8qZBBFoQO2LcIo4bHvrETpM=;
 b=h2cfDdMiHAoJyk8UM1cShm68HS68derLse6ZE3JJYhAI8ODwUxUoHSsI+nIzslvxRJq2lz2zWQSJkZvBfbveYi05L0q7YmnKQbobrbpZF5/Oj1gaK5tP+cAPoSRkFkVdVslRJ5NtXt3Tg/FMleu3Fmtsz4N4WF+MQdWDlhOm20F3nApB7XDQZwjAPqXQbOjm+2IvMWjM2BoXbbMFSz8zk4gZe/POs4dhVgxCJdhfObd+/tlFCVY/etfLqBhR7Zg2Y0kLB2FSm1YNyMhQ8muhQhOVESAW+yEOzNND97LjlJfku5XAp7g/FFDL0hF6yR8i2eb9spnADIFAzCphpeg8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCsX1GT0ILs3jdtvpvMJ8qZBBFoQO2LcIo4bHvrETpM=;
 b=VGQIGrgEon9WgzwXSLBaLaLBuVPaIHbpxXeAfE6dyTlYoVzgSvmEdgdCd05FMKrs7UgoPWGuj6u1Q2p6HNZypO/fCwU595OebGYtqN5THUTT57HJ2t/3iog34GXOjTGH6MpLFRjX8LKHAR7ZHTM7+3kA42Q5+6UTZ3kPKAkrYG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 13:26:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e0fd:45cf:c701:2731%6]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 13:26:48 +0000
Message-ID: <6cd161d2-5caa-65c8-6b86-5992cc15d1af@amd.com>
Date: Mon, 20 Jun 2022 15:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Performance drop using deinterlace_vaapi on 5.19-rcX
Content-Language: en-US
To: Thomas Voegtle <tv@lio96.de>
References: <0249066a-2e95-c21d-d16a-fba08c633c0b@lio96.de>
 <f1a52ddc-5aad-cc76-282e-93206ae43477@amd.com>
 <70395b22-1857-2a25-1472-17ce3df22607@lio96.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <70395b22-1857-2a25-1472-17ce3df22607@lio96.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0207.eurprd06.prod.outlook.com
 (2603:10a6:20b:45d::34) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35de90ee-d59f-48e3-65de-08da52c08738
X-MS-TrafficTypeDiagnostic: BY5PR12MB3763:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3763C48FF3121F9F6652808283B09@BY5PR12MB3763.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aassxh+SQJYkNvdVWskZFv0B/nJ7MylSjNoEof7jo5X//XfrJZ5+4bVdncENWStjzOMpsM/c8Dc/qliwhBxAR4qnQU00d51peIH3XAXI4GnAS/L9Vpv2l3R4++hj1yGXlTk6ABr1TB7IgQyjEh2fLkTrW8XNo/T+nMUN71/ISME0FwlzsjdoEqeR3k/9j1GMNXAvHz6mUE6tmCu6eYWUWDDJLBpk9u4+JA0kfvns9RtLRApuvfyI9g7a3SP2tzGQQBTBsqua06w2ftoPDXN0zqzHWisnpHaFcrQlPD38tAp8PSwSIvdQU4ZGpTNKbj46iZ9efZ3T+NkCGYx6rpxSC/7gs4TXMMZulqZ1Tbz1odfMq2nZWAKrP6i6RBI8BLBuiGHiUaagXKNq7MAioWtmOxvZwF9ouo0PINkbbVQ5CPWhzttwVhjfDR0k+xyut3xC/eno3ZOU72Z2cqvw/m7P8gfAmNQ5OLd3IczPFWTUCzInvocU3JLLvio197Ss3HX1TCkEQ9jA+WfQUlCPxjWgKm07eiOAw2MLFVf4nlRnqt89u1dTMgPjDtI33Y9q8wV+y/c8zdZAtDtiJycara7CRN2HBsTcLTJK3ZIxgHoruljTvAv5EHOcfbIZ77pAT1oNZCyyYArHFHW+xZ13xxhmeMCHj2JCV4aMVenSdrCGtv70HeAb5j+DyBrE1svbIlKYJ/eq8KFdo1C+yrgH+Bw2wpLqF530zdDQFvH30jmhNl+h5T2ZnTtcRRhvtIjGpQ9b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(6512007)(478600001)(8936002)(6916009)(41300700001)(6506007)(316002)(6486002)(36756003)(8676002)(6666004)(31686004)(2616005)(66946007)(186003)(66476007)(86362001)(5660300002)(2906002)(4326008)(66556008)(38100700002)(4744005)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWF0azkyUHhuaGwwbDVKTCt3ajRKNG9RRzFZL0grcXFhU1NuOXhRY2sxWk4y?=
 =?utf-8?B?M3VTVlhVN3g3MGFjTU91amFXUXY4cVdBQUhYblFPbHBEazAxZjZHUTd1OEp3?=
 =?utf-8?B?VzRGdDJxS3JqSjNLWkZGRTJhdzBTV3pSbkFZd2txOGJ3K2VXV01XWWlTNm9Y?=
 =?utf-8?B?MkJOMUp0b2V4UVJlWmF4RUU1THBMd1NRVGxqSTNFeUF1UXg2aVE1YjgyOFN6?=
 =?utf-8?B?OVA4anp3L0tXQzgxd2dVOGZmNDRPanQyZHlBK1ZUL25BVlUwcURXZ2htVDVS?=
 =?utf-8?B?dndZQzRlT0Q0VFMxT014RnZQRnpYeUw0bVpaS2JpTnhYQllQeU01c1Z3QmRB?=
 =?utf-8?B?NC9VOXZYWU44UkgvbUxLSDBPTVIwTVBIdmpsdmlzRENYWUd0Z09mVHJQaTE0?=
 =?utf-8?B?ejBXd29UZW1tNkZaeDY3bFNqZFRxdi9MMFltYWFSYURQQ0pPYTBJV1ZnNHV0?=
 =?utf-8?B?S09yNG1BWXRHZVNCVUwrZmovc1ZXVHFWdGoyb3hyeTk1YkR1L2ZKSXQ5cy9D?=
 =?utf-8?B?bW1MTzZvaHlZdno1RzZNWVFNTDY4dnpqQVhoaGtGTmJOa1BUcjdQZGtRcll1?=
 =?utf-8?B?c3B1WCsrQ0tUZzJjZmtNVkxtZlVUK3hDZStISGZ6T2pycGowYWdWbEZwL0hh?=
 =?utf-8?B?YWd0STFrTmVIOWU4eFZNcWtZYlYxWGU5Wk1FRGZYeVRlSmtJaDFENWRQT3lH?=
 =?utf-8?B?U0hVRUNreGJQL1pQWEFuWnpNRU0wa25uSmhzQkJBc25CVDRqeE93QVJ2aVA5?=
 =?utf-8?B?N1k1MnQrdklSVW1NRTVBMFJleXEwNVZHc1QwUGNYTHdmM1pOY2RaVi9wMEI3?=
 =?utf-8?B?RW4vK2ZmRDJIVHk3L0lRVnJ0c0QzVGFMVyswTVl1VDdYdkxoNTlwM09rVmFM?=
 =?utf-8?B?RE0yeDNwWWRhRWgyaWlvUmNwRGdTYWVpUXk1QVgwWW4yVHZmSWlpTnlSQmZG?=
 =?utf-8?B?MmpiaXVPaHdOdlhvak00VWtwSmZES2w4dk5ZeTZLVXRpM1hrc1ZnVHlBa0lq?=
 =?utf-8?B?VkJ5S2FheWRDamhOSjFxclVveEI3eThkN0NaRkVBa01OMTdOc1QxQTBXZ3FG?=
 =?utf-8?B?MkxNUnZOR2h0Z0NNK25lZkYvU01PVzV1NTBNemdUT0lLTEMvRU5UVVE5QmM1?=
 =?utf-8?B?d3YvTFVWQkhzUmVRRSsyUEZZeGtyaUU0a3lQNXRRT25hRit4d0hsQStuc3cw?=
 =?utf-8?B?cUhZR3lxdGhITEs2T1NYb1hnZ3V6V2xaQ2I4alVodjNuZU1VQldEbHFpS3Vq?=
 =?utf-8?B?Y1BoWHN6UmcvRU5GTDVTbkVCaURUTzVTekptQXpHYU9jcjRNUmpYV2haeCsx?=
 =?utf-8?B?MXBkMkl0VmdtNmUxb0MxNlU4MFZacVBoNStJcXUxZ3IzZ3dQbWRuUUhkT3Jv?=
 =?utf-8?B?OGJ6TGVHTUJDUG9pd3RnYTJhVWdoTHlGRm9YRzJzK0VkeEY0dUV3Z1lEMndO?=
 =?utf-8?B?K2IvbzVwS3VydW5wWlJnbU9iRXlraFk0QW5UQmhERzY2QlAwRkFhVnlRNktt?=
 =?utf-8?B?VUJidk5DcDJBalZsZzErdG4vWDRpdmJCQkxpMmhLaTliM01KV3JGQjhmaWM0?=
 =?utf-8?B?VlNVNkJhYllrZjNWd2hFeGdRV1Q2SVFTWm1Kcmd2WUFhNnBHV1dGRHVkbUhx?=
 =?utf-8?B?cW11SCtOdHhDWkIvOWU4cUxFR1BaajhBSFQ1RlA3d0tweTNjMzVkN2RmWGcw?=
 =?utf-8?B?U1dnZG11UWs4V1JEWGxpNlF5L0VpdEpWUjg1NERxRlkwOTVYOG00RlZjaG41?=
 =?utf-8?B?RkY2QlJ0WFA3aVhlQTUzeFZmbFV3bHF4ekxjc0pCeDQ1bmE5YnMzYzV2MEE4?=
 =?utf-8?B?NldUeEcrZGpDZXVoRjBQLzZyL0VUUnNDYk1OdDY1WnNXS2NsaXZ6eXVCUjR0?=
 =?utf-8?B?YjZYWU9ETkJBcm82UFh3aytLZUVUWFIreFEwRnZUWnlKd1liV2I3Z0tsSmRI?=
 =?utf-8?B?UTVpcDdIYmdTaytPeFNMUmZBdnJHNkVlM1VjVXNra3FDMjZFdldWM05NSVo1?=
 =?utf-8?B?MDNreXlZTVRpUmZ2TXhxOHJPUlFRNGNnNHFPYmhiRGpqSExoTXpqR1krSGJH?=
 =?utf-8?B?L0ppVXFQWnAyZ1BGK0Q1UDFzQzdlOFFXSUhGQ3RjNUExYmJsL0lrSThLUCs2?=
 =?utf-8?B?K1BOaC9TQk00Sko2em5ockNNdlRpdDdobUdBaEttelkyVC9jSGNrVHNzYk1s?=
 =?utf-8?B?YmN5QWUwa2hYNnB1RDhnWDcyQThlMTEyVWkvU1RqSW9TRThJdlYxdG44M21y?=
 =?utf-8?B?bEkrNWVUcENsc3JCMFJ2ZUMyRngvQ0lZZUMzYjEyOVNYSnBpS1lvNDZyaU8r?=
 =?utf-8?B?VU1yaktjTmc0d0d4eVVNb1p0ajhnMmlMQ0paaUVwMm81NkQxMG85ZmR0RDJ4?=
 =?utf-8?Q?4uSbKbYJW35+DLMYbwHbhsWUHVUw9KgCXSsBWHAmj1WL0?=
X-MS-Exchange-AntiSpam-MessageData-1: dBd1xXm4HMs0kg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de90ee-d59f-48e3-65de-08da52c08738
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:26:48.7946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tFqfo3+fn3R/3xD40uABG/mZ/LEWJsJbBzIHnwMV3DWNpZn8CBDXCa1RwJKdmov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3763
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 20.06.22 um 13:40 schrieb Thomas Voegtle:
> On Mon, 20 Jun 2022, Christian König wrote:
>
>> Hi Thomas,
>>
>> [moving vger to bcc]
>>
>> mhm, sounds like something isn't running in parallel any more.
>>
>> We usually don't test the multimedia engines for this but we do test 
>> gfx+compute, so I'm really wondering what goes wrong here.
>>
>> Could you run some tests for me? Additional to that I'm going to 
>> raise that issue with our multimedia guys later today.
>
> Yes, I can run some tests for you. Which tests?

Try this as root:

echo 1 > /sys/kernel/debug/tracing/events/dma_fence/dma_fence_init/enable
echo 1 > 
/sys/kernel/debug/tracing/events/dma_fence/dma_fence_signaled/enable
cat /sys/kernel/debug/tracing/trace_pipe > trace.log

Then start the encoding in another shell, after it completed cancel the 
cat with cntr+c and save the log file.

Do this one with the old kernel and once with the new one.

Regards,
Christian.

>
>
>       Thomas

