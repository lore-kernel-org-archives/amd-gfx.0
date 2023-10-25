Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EED0C07545
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Oct 2023 01:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F83310E0C0;
	Wed, 25 Oct 2023 01:10:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A59610E0C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Oct 2023 01:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRp5UkvujCc+VM+gzNzf7BqqywpjjXvTqfxBqKJTGnoTM8eQLfJuljKIJkXCrsWb9aoDH1r5QpAR8rUpcM6L88GnQT9pg2E/1QNVYmmDEVsWupYsrSY+lzrOSfIGpGpIP4jd67hd4xVU5XaSwMSQLNNbPhqVR6Dpglx9h3YdI8uWilne+WeEJPS5iDwj3mfIUQ62b5dQv3wKryp/ysKVJabpWsh6K8jWabtYdNNO/OhVswvgauV+lEcDCik125AWsZQOMSNS8nkA8I+jJTF7UWUxYv4riXtE9qRkpiecXDN/6G+6zAynQUzJ+eqcfpt/rpN0iHsb3DVWcVVtKW17RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nRAUEqbV82j3vS5XM4yVo+Cz4lI5oJ25l6LC1CtBk0=;
 b=BukAE/2+rWrXDW/obzqTkacjgSAd7EbHaLY1TzBl7G0V3x4J8DxLDIApfeYGu+wt5KZZYadDJtamAYWx3Lo9nDP+KxRylSIOib3iUnDTjBbDb9GhOLmlZHg0nUgX3KQZ56NdPVmAmeqX9JktotUPA6jdoV61nENosdN8EaQWOKCqVT5Y+wE+LafnXA12gIpXw91klt1JmCKxlQr7B1xyo3BQaOubRzf2Z34/MI4YZOryx3LVY8kDJjf+K2fiVsSkKgrveLdJuHgOaMbUaFW/hMDFC0K1vfBzFWH19fYZ2fesgkkvyC9VZ5Pbx7A1VfvWu8WdCiEiI26NjlxIyDZ3oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nRAUEqbV82j3vS5XM4yVo+Cz4lI5oJ25l6LC1CtBk0=;
 b=Ek/YeZPlx5Ntj8KOwrLDz+rQQGgOCphtF2718BULJFFEenOe3m5FBWYqvndax9mt4Ygq7vbVocErmB7pcvwsKdEKtCxA4uIHlUPyTLuTpxgkjKa0zcBdfz1Zm0EfoyAkrhECV+T/5vtzc7PIx/dTwGLp8SXE9CYYioq9hiElDxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 01:10:44 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::b80b:7138:6ceb:9aef%6]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 01:10:43 +0000
Message-ID: <dd6969ae-8ba9-43c2-bc50-11277613b27a@amd.com>
Date: Tue, 24 Oct 2023 21:10:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:115.0) Gecko/20100101
 Thunderbird/115.3.3
Subject: Re: [PATCH] drm/amdgpu: Initialize schedulers before using them
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
References: <20231023032344.164925-1-luben.tuikov@amd.com>
 <402f475c-bb67-4061-9521-2f811eca7657@gmail.com>
 <53e14f59-6743-4a11-bf27-151507071bb0@amd.com>
 <bf4e2094-3304-412b-a196-27c289e080a5@gmail.com>
 <6dcf471e-6daf-4aaf-a534-322b6483bc87@gmail.com>
 <CADnq5_NuPw2KdW2FZd6u4LF2ArkHxi9J+peDAzg7WADXj49OPQ@mail.gmail.com>
Content-Language: en-CA, en-US
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <CADnq5_NuPw2KdW2FZd6u4LF2ArkHxi9J+peDAzg7WADXj49OPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::19) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BN9PR12MB5114:EE_
X-MS-Office365-Filtering-Correlation-Id: 0602aef3-bd85-47f8-205b-08dbd4f73658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m9q/4XkIY+xUflFE6EPxyM9pfiherMhqizLuEcNTsJdZQfTc7gR+wPZTDCk3d7qTPaB1Dp92Prznd6HxtcT9kh4G/ZLS6Xpx0qIh//c2Gzepm608pONH0nNAZl60P9PiR17j7iBPbBa5lL8yE+5X6NoWfsyEDpwFxPvMTU0i1ryVWfdkdEEiNcXRUcULHSW/vMH8zdE108VkaJx4A26oOgZlKSFKJAmNRVklS/0ZK3yCiT6+MyoULVHwq5E6t00gAua0wSogNTOpmoaTUgEGZ5lsusiqbsw+UmajdthkneXhqXVDjqC5y7HFGvezaJQYD/l3ZtF9aRm0EHnxJ51/+nLL0buVAoN9TEwTwtm+6RPVqr+LujAyWsugiSg2ICkycc58q+MZst3vvXHEUaNZweJnbP0I1WdB+lSLeaNK7k853YIRYRLbUqEsO+/ur0ph2HCojU9Nmaad8yAQBoEbq8jXZsi6CX0zQPnM6vfn9QVnIqErzCVbBbPGcJxnD4P91/vqRcaPYqveIAG6ckQ0Mc9g2lyzoKqQjZkr5plOMx9208e9ut/wCJoOk1MUe/sobRSjVqpT7FubQDmqbnQSHtzMYciyQMJZ/VpVO+vPWKnY6PMShY9tNIFUgSM6J2OAYynxCZtQGhHVt59JUA0zcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(53546011)(66574015)(2616005)(83380400001)(6512007)(6506007)(38100700002)(86362001)(4001150100001)(2906002)(110136005)(966005)(6486002)(44832011)(478600001)(41300700001)(8936002)(8676002)(4326008)(316002)(66946007)(66476007)(36756003)(54906003)(31696002)(66556008)(5660300002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym0yM1V3SDVQR3BYTy92b2xSU21YVGZVRUZrOVlzS3MvdGFlNzhMS05mZnVI?=
 =?utf-8?B?V1oxLzczWDc2d2RneGZPSkg0VUhXQ0prMWNRQi8zVThaRzVETFlRdFExWGJh?=
 =?utf-8?B?Q0taLyttMWt4SEhGNDVPS0VlRlJHcjMwZ0RuTTBZcGZPVnVENjliVzlVclR0?=
 =?utf-8?B?TENXM3N6cXRUQ21naHJ6Q1RxZ25TSjRqK1kyRWdiUHJ0Qkk2ZW1jZ1JSdlAz?=
 =?utf-8?B?ZlFESW9VdnpMV2k5dHBRSHV3V3N0YmpyRXNLd2VTSVp2S0pCU205V2ZTcGo2?=
 =?utf-8?B?c0N0M3Jja1JKZ2pxeGU1MTBqdjhpTExpbjNHQVk3cnB2WXFZcFlpc0pWTHQ1?=
 =?utf-8?B?ZUtTbHB1WFVyTHRvdEtGVHlBcWFsTTA5S2JxLzY2VjlFWmpQNkg3MkVaOFR4?=
 =?utf-8?B?c0h2SGZnS2h0S1NnNUVUbEV5bkMwSjVMYWpHb3MrS2dZOFF0SVhBOGwwRVRO?=
 =?utf-8?B?K1JhMnNXZmdtSlRqQ2VQT1l3K0lwTFpDcVdReER6RmVrUW1SYW9QUTNZaVNS?=
 =?utf-8?B?d2tZMkhhMkh1U1NhZWdtU3g4MnJYVEVtVlBDRVJQNTNvM1dKeXlBRDB3cE4y?=
 =?utf-8?B?eGxSdEYwTFdJa2xqUDBUTkUwU2MrS2xILzJ2L0RBUGQ1WnNZVmxjK3dtMmtv?=
 =?utf-8?B?ZUxzdUJBUmpVYWorVS9QaVZRQnpNQm4xcXlYRkRaMENyMlk5R3BlR013RFN4?=
 =?utf-8?B?c0MvUmRXVUNveHZ2VG9nQnpSQVRMNmJyV01GaE5RZUlLeDhDVldKK1JlMkpu?=
 =?utf-8?B?dzRBR0RUcHQ4SjdDc3J5bkJaelRwV1Y5N29sMC92UWVXaUNtWUxOTDNNSW5l?=
 =?utf-8?B?YXlWMVBlQjJGMWlNR3ZyRXVmNUxkYzRVUEsraUFQWUNaaGZjRkcrZXgzZ0RT?=
 =?utf-8?B?TWNQOElZaHNBcS9WMllEZnZCVUF3aHVMVkx4WFpaS0FXMEJ0RmFybTJUc3I4?=
 =?utf-8?B?YzdEZ1JvdThKK0JiNjdJcUYyTHVvRzRoNU9hcGNPZGE0MkdGMEg1Q0hmT292?=
 =?utf-8?B?SitnWWY4dHdhVFpOR2lLZ2tTQnpWd0NzVEtoSDcxbE1BWHRLbFpSd0NFOWZj?=
 =?utf-8?B?WERIVjJyZDJ3dlNZOE5uYW5iZnBQc2lpRkVNSk5qLzBKbUhHWGV3QU5WeXBI?=
 =?utf-8?B?S1VXa1psSU1MeWlwRVVRWGt5bVlWVlVCaVh1QlhCUS9vTXVBMitKbkRUeWEy?=
 =?utf-8?B?MmlEZUFzRkVvOGF3Zy9jNWw0TnlnYVlTekJWTy9od21SeGRrUXE3WHUvcGRh?=
 =?utf-8?B?VWo5VzkxRjFBUExXVUREQkZ1emg3VFEzNVVJSWpLMDBYR2NjUkNyb1RjNUtB?=
 =?utf-8?B?azlUeU1jN1pIT2VIVm4rUzJ1YnpsV2FtUE1FbEJGZHpzMDdPcGdpL2V0RGxv?=
 =?utf-8?B?dmQxY2FzZEM5UEJiZ0EvMk0zcUhaTWMvdXQxTWNVdEhZYnMyQlpzcFo3ZGF1?=
 =?utf-8?B?aVNPNmMxTE5jSEI2aVovRWtZUEQ3UlhCQnAzangwRWw1UW5ZOFdZUVBHTUZa?=
 =?utf-8?B?bklCSnRTVEZwTUM1UHF3UzA3UGNpVXpQMmprM0ZEMStQSCtZdzZtZEZiTTJh?=
 =?utf-8?B?L3NxeXc5dDVKd2RWYThVbEpwWStCTnV3LzdlYVZicEEyZitzcmJ1T2FFSTNp?=
 =?utf-8?B?amd1ZktqWTNacW5BK1luVDRicnpnMHRBRHNOM1ZkZklpd1RNOSt5blNMZnFG?=
 =?utf-8?B?MUxwN3pLeER2YkhTMU52ZWtEZnlDVGN3YzdCZUZQdFN0U3lieUlqMDIyUnFv?=
 =?utf-8?B?ZEV4NFFsazVLeWYzQVh5SE5BMUpvTFRBNFhaekprMXZFclU3VnZaMWRYMEQv?=
 =?utf-8?B?SkNuU3Q4TmtBMVJVem9UNy9NR0Jxd3M3Q29EejR0TGtSREhNcHM2QU9KVW1G?=
 =?utf-8?B?Q094RWVnNWlrcW1oZG5IelJ5SUYycUUvMTBWS2t0RmhPS1kzd2F1UGtwejBy?=
 =?utf-8?B?UUs5YmVCWTI0OU1ac202MlcvVlhvVnkvWll0Q1hyODR1WGdlQ0J4VDRHZ3kr?=
 =?utf-8?B?Wno2NncvbldNN0V5YlF5QVl0elhTc0kzS0FjenlVM0NicXB5OUpRNHhqN3pI?=
 =?utf-8?B?am55TzZUMGo1YWxmYmpDSVRwZURhWnhkaXI3ZUtkR2RUL3htSUJqbk5WTlJF?=
 =?utf-8?Q?eWjdugjawp5yLyNlula/PRqtX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0602aef3-bd85-47f8-205b-08dbd4f73658
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:10:43.8234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFlx/xgW12XLvz67X2IlluNYDJjVztPj8LCRhVWEPDK9Z0EDU9FY4vPltpcgiSGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-10-24 10:46, Alex Deucher wrote:
> On Tue, Oct 24, 2023 at 6:14 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> [SNIP]
>>> Let me take a closer look first
>>
>> I think I've figured out why this isn't working as expected. It started
>> with this patch here:
>>
>> commit 5fd8518d187ed03403a4d4f7f56f52c00b11c148
>> Author: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> Date:   Mon Dec 6 14:59:35 2021 -0500
>>
>>      drm/amdgpu: Move scheduler init to after XGMI is ready
>>
>>      Before we initialize schedulers we must know which reset
>>      domain are we in - for single device there iis a single
>>      domain per device and so single wq per device. For XGMI
>>      the reset domain spans the entire XGMI hive and so the
>>      reset wq is per hive.
>>
>>      Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>      Reviewed-by: Christian König <christian.koenig@amd.com>
>>      Link: https://www.spinics.net/lists/amd-gfx/msg74112.html
>>
>> Andrey separated the scheduler initialization from the ring init because
>> we need some of the rings for XGMI initialization which in turn in
>> necessary to figure out the XGMI hive and so the reset domain for the
>> scheduler.
>>
>> The code inside amdgpu_ttm_set_buffer_funcs_status() is actually
>> correct, the problem is that this is called as part of the hw init which
>> comes earlier than the scheduler init.
>>
>> @Alex, Ideas how to fix this? My best guess is that we should move the
>> call to amdgpu_ttm_set_buffer_funcs_status() from the DMA specific code
>> into the higher level handling in amdgpu_device.c
> 
> Yes, I think so, but there could be some tricky ordering issues with
> respect to suspend and resume.  I think something like the attached
> patch should do the trick.

This patch works. I've tested suspend and resume too.

Tested-by: Luben Tuikov <luben.tuikov@amd.com>

scripts/checkpatch.pl complains about extra parenthesis.

-- 
Regards,
Luben

