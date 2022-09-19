Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9B9C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 22:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF5F710E186;
	Mon, 19 Sep 2022 22:21:51 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C82A410E186
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Sep 2022 22:21:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN5j0b/QzGbeLNjl4xxfpJOjAq28xIVM+9PRMI4dWGmE9Iv06MTBZMTl98zxidktsMTKE6/qi+D/3V+hPG4d/sf+IyGUS0hTgYuTE+r/hxJB7tI4J+ZNdPxatd6382hCG7VxYl7wtYwSQmMFNw0BeJLH3vMhp/wzpjKarOYW9/D4iVGmcgxWlKaqpUS2ABttZibIEw5YO4p7XnzpHRNGi8MZq0ZoGJhzYTPHEOu9ZyIufoVlF0GzrF1uqqWelnA1lf+yb3Amo2fQdnyYDU6j2HSl2BDxkxdA47XLzw5q9rpM2ZyyoU8fcu+meoREavMSnbR0us/oT78kTxfUTG4m3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H32zKPqbYmHz/n1uEYrMdwF3562w2fpy3li5XGy3r3A=;
 b=SgG2elZ1R4DX5fxQvIllmhtdudlapv2D7Q6aLiLRdgQlE7Ak3RD2JLqjIN/Epx3qeSxPhPuhCyHYJeh03dJxBfQcHuYhoayEW4S5CV+0a7g4s/wJo35+XQRwtptdLaBpMegLNTbn/Lf0SKalzvLKLXFAZ/QxvErs5DHwXac3ZUMJ7ULwl607qv8TAR4ejmmsxxF/kD6QljvO7s/XUHdGYh7Uqg9GjjC0sxWa6C/8VtQSzBtPIQJDXwZGnCqsMhrggqwzEKIw7lh48tYXH5BqEQznH36VG59qY/LvVwlTh9C5F9luuuKHd4IgF7944gNGTXvTL087GwOOWMZe/eT5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H32zKPqbYmHz/n1uEYrMdwF3562w2fpy3li5XGy3r3A=;
 b=SFgdJ3bm3j0bwtCxIED3xAzL0XArr4quH7dr5KwYOh+TjYeoI92GjTie4cz2WRsAEF4Q+3SzxbOYUb0ZnzFZvrM8ITy5ZMMbaEFGI+Syn5yUZ2AOgrP5q5S62dGSNswMG8bCXNtS1pERNSdLZGbeqH83Z2vVSuCMIjDMdj+efEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 22:21:44 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a%3]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 22:21:44 +0000
Message-ID: <4ada5092-0f8e-99aa-5dce-a6a824aa1fde@amd.com>
Date: Mon, 19 Sep 2022 18:21:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v4)
Content-Language: en-CA
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220913090558.685714-1-jiadong.zhu@amd.com>
 <3645ac67-57d9-eb51-9ddc-0577237ecdb4@amd.com>
 <DS7PR12MB6333F351ED3BBE6AAE3597DCF4499@DS7PR12MB6333.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DS7PR12MB6333F351ED3BBE6AAE3597DCF4499@DS7PR12MB6333.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 521047f6-fad2-4779-e5a4-08da9a8d554f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMdIhZThk3GZ6YEzI/PscOQb+KXCkcjxQfqBh+q7V9wei/+AjoLh73+pdlyBg1yx7NulFHHEDeb+Qd+Gd/PIOKeUNJ9jWXdkMiR2Q04NdvuMLopLh1Isd7WmpTUL6jeFqxPAuBYVrraVzcgFm6P2K3HqpOWQHIcBK5DeMkR2xN+oQ7QS9o6auJyDqS9tLEYaidWeTQZVSK6uVO14wL0utGIZEZpvd99rLpgjAQog431IWSw9Z7D9DsqZpZEGl6kEbi0uq8eqY8eTU8vYGcbPUmU0PCciKKUg7teMrqjfo7NFeVQuc16kybaPitmhR8VD/51lt6j3JRotI1NvOGWyzKP+M8pQPdXX5219Wa/TbQ52aqT2RQ+TvfKtJ0lkM0zf2ngslWcMC3LTKW3x+DeV01lih8uc0YJYSvS/HdnDDWG7nou6Ikw256J7BsOvWH58TPNHVdXWCWJHvls6N9qEt6h7hhbNKIjpqbbTualaQkm6IaGhRwJ27kvY8h4v21Aivr7bUde2n0NDoc16yIg4iPQFXRJIlECZwainI3HKTrbFvk/CBulSa1z6RAChkn+MWZBST4SstkA1AQ2w2kbdI1ndURkaZfeTXOu+Zo0+GtsRB3tmxawtr5CWHXky0e+P8H6S9BCEWL6QoZWccG0Tj38uxiAn9NdJ7BBICs0kO/q9HF6ZHDryZMdJt1Vz54c5SiV5sH32vtMV8ssIxN6pxIm5/0VPhwD0FrherSDsa2KRxQg1X/qXdoufU/+l4YPjChHrxRRZMOvVKkjDuEDcmlbRo3e0v9O2/eXvG9IeCy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199015)(6506007)(4326008)(31696002)(2906002)(36756003)(53546011)(8936002)(66556008)(6512007)(6486002)(86362001)(26005)(66476007)(66946007)(8676002)(41300700001)(478600001)(83380400001)(38100700002)(110136005)(186003)(2616005)(66899012)(5660300002)(316002)(54906003)(31686004)(30864003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnlNVGJEVEg3RGpxZGFGK2Fha2hGcGRlSWtMV2dQRFFEbXFiMC8xNXZXUFdE?=
 =?utf-8?B?Q2o2dXpKNERXK0NOSlJUMkJodUwyeitvZlE2NGd5UXNla2VOVUdOa0gyQkty?=
 =?utf-8?B?SEVqNDRlWHYrcUFWVmpsUUtqcnNENHIrUFphdjZraXBIN21VcjgwMy9tb3lN?=
 =?utf-8?B?QUJlQ0lUZ3JEYWtqN2NTZ0Z1RDBHaURjNFJ4OW5yWjBRRlNkSk5DZWM0QkJj?=
 =?utf-8?B?THp6YVlxbTNOWGEzeVRkdEVXckcvS29oeElBVDVRemZWTXpSOXZONy90dXpZ?=
 =?utf-8?B?aVFNRmRPc1ZHRWlPUXFVN2VEcXZTcndMK0RSU2pzZmlURThGUnRydHFmKy8r?=
 =?utf-8?B?UVFXWGFaUnVvTXNFUW9CMXdGSXV4THl3MjJKSCtORmtHTHgyOEhZcVhtY2NR?=
 =?utf-8?B?WXYvTkRNWThOcWNOL3BnTWxiSXNsQy9lK3YwUTkveWlZQzhwcWxIY2ViUzVM?=
 =?utf-8?B?dnZrcjlZSTJheU9kWDJZSjVPL1dNNHVZakR0Wm43STVBL0dmZVR5TWVhdmNB?=
 =?utf-8?B?SmlxcStMdEpaeDVDa1VwK0NvczdMQ2R0MnljY1dOT0dHS0hweEdua2dmMjJT?=
 =?utf-8?B?TGVMVm1Hd2E5d3NhMGprTDhha2pUY3NYa2ZBYXYwK3pzVm9yOGtSbzBDd2xM?=
 =?utf-8?B?bWl5anF2cmJYa2ZkYmcrSDFCZlBXdXpSYmg4b2RuRk5tQ25sSXRsbzlqMCtN?=
 =?utf-8?B?MHZIOWV3NmJyYWxDYUtMVEVZV3hYcXBtY09yUFpTdkNqVFdqeVVTZGNBNmtL?=
 =?utf-8?B?WXA3TUJKWHNOZHIwSlZMNW54SWQ2TnNrSEJhblF0eHc2ckZmMVVwNklkU2Zs?=
 =?utf-8?B?cEd1OE11YjZrSjlSblA1bU9hU3R4VVJWeWZQYUhBL2ZvOFJieFQ2Y0kyUk9z?=
 =?utf-8?B?eG96SG5SOWdaMEZMdktIWDBOVFR4bnQwd3l0Q3RZb2hqTHRKaER6cE42Tkx6?=
 =?utf-8?B?WHpyL3RFN0pLZXR6QzlvSm9ONDNQRFg4K2U2S3AvcE1PdnpicTlGd2hES0pZ?=
 =?utf-8?B?V2JLaWliZGdoQ29YT1cwNmQ0UDROVmVsZERuNzkrb1k0QkpRWHFiY0Y3L0cy?=
 =?utf-8?B?VU1EZlgzNlA0TklocjNmemFEVXVBRlArcytXRFpNRHdiVG16SWtES3NISWRO?=
 =?utf-8?B?QXRxRlg1ZlRqYkYrTi9GNU5JUTRIYUgydlVTNUl1cHRpeVoveFZIZmlpd3Fq?=
 =?utf-8?B?TW03YzFERWJMUzJvSjBLMVpTZVk4SkhaVnptaWszUVphNU5PUXprNXk5SmFY?=
 =?utf-8?B?TjRKVDJJZzVENjNpYzE5QndBRWNPaFo5aDd3R2tKV0lrQnhacGlhRlVYekJo?=
 =?utf-8?B?eHZTcEpmZ0thY25URTVhOXkydkVNd01CK0EzQkExKy9Jc0xuUHhJMzVtRjhY?=
 =?utf-8?B?QzZ3VWw2RTEvTEJ5eUVwblJIU0lXbDJSdHh6eGppb0VkUnNQeGJjZHViVE5i?=
 =?utf-8?B?UldjREYvMDdxVmZ0aStCVHlUWkJKTUlVQUg2dWRxQTMzbndsMzRrQUZ2Rmkz?=
 =?utf-8?B?VE5iUmhnRzBYWUYxaThjVVE0TnB5K3dCYWJmOFlGUnpKM2cvbGVYeEpyNDJN?=
 =?utf-8?B?SHliSXJKMkpEaE5GWFBLYmJLUU5ScExIVEdDbWVkN1RsS01ySVIvSFRhVGVP?=
 =?utf-8?B?RktrQnRjSzV4UVJWbnBMSDkxVUlRdm1yV3dOVUhSQ1ZrUGU5b2lVZWc0cHpS?=
 =?utf-8?B?NkFmeVJ1N3c0NVF4MDBGZzFlOURtQ1J3RE9hMFZKNzV4aDhleUF0ZnJzckx0?=
 =?utf-8?B?dC8rYUVqdWs5WFdjQTQxMlppSjFXMDc5eDdpeUNZVDJySjFrTFI5K2NIRG9n?=
 =?utf-8?B?WXhZWnY1VWNWSDBWMEFHNks4aTJ0STN0WFZnb1dCekgrS1JVeFdCUk5NME9x?=
 =?utf-8?B?cGFsTk51WjhraURaZFRMbGN1YzFpYlZZdjdQTmJnTlErMHhEM204SWZGWU5V?=
 =?utf-8?B?ekhURlB1c09lQ2FvU0pkaGthOGdxd1hiN2V2elBGakk2eE9rNy9XNWExdy9U?=
 =?utf-8?B?eGVWMFBSbHZrZ3VGd0dvWHdhWFIycXova25LbTVDL3VJT3dVZkJidURLSjZt?=
 =?utf-8?B?ZzB6bTA2VkU2bGxzcnIxbDVCTUIwc1JXOU0wYVptS1VUYnlWOTRFdHBxS2lK?=
 =?utf-8?Q?dyF0ZiiHb4z4dfQp3BPXRy3dy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521047f6-fad2-4779-e5a4-08da9a8d554f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 22:21:44.0743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEuIIZjdTt60pb4XBhR6kF4MREKVMXAyjSCIhQSk292ifFxlofZP+j3E1KObnwr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

You can still use "writep" and "readp" in the function name. Make code sustainable for the next programmer in the future.

Regards,
Luben

On 2022-09-15 01:30, Zhu, Jiadong wrote:
> [AMD Official Use Only - General]
> 
>> So, between the function names of "amdgpu_ring_get_rptr_from_mux()" and "amdgpu_ring_get_wptr_from_mux()",
>> they are 96.6(6)% _the_same_ name to a human. How about "amdgpu_ring_get_readp_from_mux()" and "amdgpu_ring_get_writep_from_mux()"?
> 
> I agree with the similarity between rptr and wptr. But the function named amdgpu_ring_get_rptr_from_mux  is aligned with amdgpu_ring_get_rptr for the same style, easier to understand.
> I would rather use it currently until we replace rptr with writep in all the other places, shall we?
> 
> Thanks,
> Jiadong
> 
> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Thursday, September 15, 2022 12:49 AM
> To: Zhu, Jiadong <Jiadong.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Huang, Ray <Ray.Huang@amd.com>; Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v4)
> 
> It's customary to add a Cc: tag in the commit message on subsequent revisions of a patch, once a person has reviewed and commented on it--Christian, Andrey, me, so that subsequent patches' emails go out to those people automatically via a CC.
> 
> Inlined:
> 
> On 2022-09-13 05:05, jiadong.zhu@amd.com wrote:
>> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>>
>> The software ring is created to support priority context while there
>> is only one hardware queue for gfx.
>>
>> Every software rings has its fence driver and could
> 
> "ring", singular.
> 
>> be used as an ordinary ring for the gpu_scheduler.
> 
> "GPU scheduler".
> 
>> Multiple software rings are binded to a real ring
> 
> The past tense of "bind" is "bound", not "binded".
> 
>> with the ring muxer. The packages committed on the software ring are
>> copied to the real ring.
> 
> Use 79 column wrap setting in your editor, not 50 or 60.
> Wrap at 79.
> 
>>
>> v2: use array to store software ring entry.
>> v3: remove unnecessary prints.
>> v4: remove amdgpu_ring_sw_init/fini functions, using gtt for sw ring
>> buffer for later dma copy optimization.
>>
>> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> 
> Add Cc: tags before the Signed-off-by line.
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182
>> +++++++++++++++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |
>> 67 +++++++  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 ++++++
>> drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
>>  7 files changed, 360 insertions(+), 1 deletion(-)  create mode 100644
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 3e0e2eb7e235..85224bc81ce5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>>       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>>       amdgpu_fw_attestation.o amdgpu_securedisplay.o \
>> -     amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
>> +     amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
>> +     amdgpu_sw_ring.o amdgpu_ring_mux.o
>>
>>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index 53526ffb2ce1..0de8e3cd0f1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -33,6 +33,7 @@
>>  #include "amdgpu_imu.h"
>>  #include "soc15.h"
>>  #include "amdgpu_ras.h"
>> +#include "amdgpu_ring_mux.h"
>>
>>  /* GFX current status */
>>  #define AMDGPU_GFX_NORMAL_MODE                       0x00000000L
>> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>>       struct amdgpu_gfx_ras           *ras;
>>
>>       bool                            is_poweron;
>> +
>> +     struct amdgpu_ring_mux                  muxer;
> 
> It doesn't align, possibly because TAB chars were used between "bool" and "is_poweron", and because TAB chars were used between "struct amdgpu_ring_mux" and "muxer".
> 
>>  };
>>
>>  #define amdgpu_gfx_get_gpu_clock_counter(adev)
>> (adev)->gfx.funcs->get_gpu_clock_counter((adev))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 7d89a52091c0..fe33a683bfba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>>       bool                    is_mes_queue;
>>       uint32_t                hw_queue_id;
>>       struct amdgpu_mes_ctx_data *mes_ctx;
>> +
>> +     bool                    is_sw_ring;
> 
> Use spaces to align "is_sw_ring", not TAB chars, as I mentioned in my review of v3 of this patch.
> 
>> +
>>  };
>>
>>  #define amdgpu_ring_parse_cs(r, p, job, ib)
>> ((r)->funcs->parse_cs((p), (job), (ib))) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> new file mode 100644
>> index 000000000000..652a6d3e0ec3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>> @@ -0,0 +1,182 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <drm/drm_print.h>
>> +
>> +#include "amdgpu_ring_mux.h"
>> +#include "amdgpu_ring.h"
>> +
>> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
>> +
>> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>> +     u64 s_begin, u64 s_end);
>> +
>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring) {
>> +     mux->real_ring = ring;
>> +     memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>> +     mux->num_ring_entries = 0;
>> +     spin_lock_init(&mux->lock);
>> +     return 0;
> 
> Get rid of the "return 0;" here and make this function "void".
> 
>> +}
>> +
>> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux) {
>> +     memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
>> +     mux->num_ring_entries = 0;
>> +}
>> +
>> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring) {
>> +     struct amdgpu_mux_entry *e;
>> +
>> +     if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
>> +             DRM_ERROR("adding sw ring exceeds max gfx num\n");
>> +             return -ENOMEM;
> 
> Copied from my v3 review:
> 
> You can't return here -ENOMEM, as it is not a real out of memory condition.
> Maybe EINVAL or something like that, but not ENOMEM.
> 
> Also, under what circumstances would we get to this condition here?
> Are such circumstances valid?
> 
> And if so, then when this is returned, what happens?
> Does the driver die?
> 
> I feel we shouldn't ever have this here--it should've been calculated correctly to never have fallen in this/such a circumstance like that here.
> 
> v4: Perhaps make it dynamic? So that it works for any ASIC in the future without the need to modify AMDGPU_MAX_GFX_RINGS, or modify the driver.
> 
>> +     }
>> +
>> +     e = &mux->ring_entries[mux->num_ring_entries++];
> 
> This seems hackish here because you're not saving the increment of mux->num_ring_entries. Also rename the array to "ring_entry", so that "ring_entry[i]" means "ring entry at index i".
> 
> Perhaps keep a "ring_entry_size" member variable in "mux" to hold the size of "ring_entry[]", and use "num_ring_entries" to hold the dynamic (populated) size of "ring_entry[]", so that the _next_ available index is:
> 
> if (mux->num_ring_entries >= mux->ring_entry_size) {
>     Complain;
>     return -ENOENT;
> }
> 
> e = &mux->ring_entry[mux->num_ring_entries];
> mux->num_ring_entries += 1;
> 
> e->ring = ...
> 
>> +
>> +     e->ring = ring;
>> +     e->start_ptr_in_hw_ring = 0;
>> +     e->end_ptr_in_hw_ring = 0;
>> +     e->sw_cptr = 0;
>> +     e->sw_rptr = 0;
>> +     e->sw_wptr = 0;
> 
> If struct amdgpu_gfx is kzalloc-ed, then this is all zeroed here anyway. Something to think about.
> 
>> +
>> +     return 0;
>> +}
>> +
>> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
>> +                             struct amdgpu_ring *ring)
>> +{
>> +     struct amdgpu_mux_entry *e;
>> +     int i;
>> +
>> +     e = NULL;
>> +     for (i = 0; i < mux->num_ring_entries; i++) {
>> +             if (mux->ring_entries[i].ring == ring) {
>> +                     e = &mux->ring_entries[i];
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return e;
>> +}
> 
> This is a bit naive, as every time we want to do an operation on a mapped ring, we do an O(n) search, as shown in the three functions below.
> 
> Perhaps add an index variable to struct amdgpu_ring to tell you this mapping, in O(1) time complexity, and eliminate this function.
> 
>> +
>> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring, u64 wptr) {
>> +     struct amdgpu_mux_entry *e;
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("cannot find entry for sw ring\n");
>> +             return;
>> +     }
>> +
>> +     spin_lock(&mux->lock);
>> +     e->sw_cptr = e->sw_wptr;
>> +     e->sw_wptr = wptr;
>> +     e->start_ptr_in_hw_ring = mux->real_ring->wptr;
>> +
>> +     if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
>> +             e->end_ptr_in_hw_ring = mux->real_ring->wptr;
>> +             amdgpu_ring_commit(mux->real_ring);
>> +     }
>> +
>> +     spin_unlock(&mux->lock);
>> +}
>> +
>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring) {
>> +     struct amdgpu_mux_entry *e;
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("cannot find entry for sw ring\n");
>> +             return 0;
>> +     }
>> +
>> +     return e->sw_wptr;
>> +}
>> +
>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring)
> 
> So, between the function names of "amdgpu_ring_get_rptr_from_mux()" and "amdgpu_ring_get_wptr_from_mux()",
> they are 96.6(6)% _the_same_ name to a human. How about "amdgpu_ring_get_readp_from_mux()" and "amdgpu_ring_get_writep_from_mux()"?
> 
>> +{
>> +     struct amdgpu_mux_entry *e;
>> +     u64 r_rptr, offset, start, end;
> 
> "r_rptr" is not a very descriptive name. How about "readp"? It is more descriptive to a human.
> They are all "ptrs", but what is more descriptive is whether it is a "read" or "write", etc., so "readp" is more descriptive.
> 
>> +
>> +     e = amdgpu_get_sw_entry(mux, ring);
>> +     if (!e) {
>> +             DRM_ERROR("no sw entry found!\n");
>> +             return 0;
>> +     }
>> +
>> +     r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
>> +
>> +     start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
>> +     end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
>> +     if (start > end) {
>> +             if (r_rptr <= end)
>> +                     r_rptr += mux->real_ring->ring_size >> 2;
>> +             end += mux->real_ring->ring_size >> 2;
>> +     }
>> +
>> +     if (r_rptr <= end && r_rptr >= start) {
>> +             offset = r_rptr - start;
>> +             e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
>> +     } else if (r_rptr < start) {
>> +             e->sw_rptr = e->sw_cptr;
>> +     } else {
>> +             e->sw_rptr = e->sw_wptr;
>> +     }
>> +
>> +     return e->sw_rptr;
>> +}
>> +
>> +/*copy packages on sw ring range[begin, end) */ static int
>> +copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
>> +     u64 s_begin, u64 s_end)
>> +{
>> +     u64 begin, end, r_begin, r_end;
>> +     struct amdgpu_ring *real_ring = mux->real_ring;
>> +
>> +     begin = s_begin & ring->buf_mask;
>> +     end = s_end & ring->buf_mask;
>> +
>> +     r_begin = real_ring->wptr & real_ring->buf_mask;
>> +     if (begin == end)
>> +             return -ERANGE;
>> +     if (begin > end) {
>> +             amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
>> +                     (ring->ring_size >> 2) - begin);
>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
>> +     } else {
>> +             amdgpu_ring_alloc(real_ring, end - begin);
>> +             amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
>> +     }
>> +
>> +     r_end = real_ring->wptr & real_ring->buf_mask;
>> +
>> +     return 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> new file mode 100644
>> index 000000000000..d058c43bb063
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>> @@ -0,0 +1,67 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#ifndef __AMDGPU_RING_MUX__
>> +#define __AMDGPU_RING_MUX__
>> +
>> +#include <linux/timer.h>
>> +#include <linux/spinlock.h>
>> +#include "amdgpu_ring.h"
>> +
>> +struct amdgpu_ring;
>> +/*
>> + * start_ptr_in_hw_ring - last copied start loc on hw ring
>> + * end_ptr_in_hw_ring - last copied end loc on hw ring  *sw_cptr -the
>> +begin of copy ptr in sw ring  *sw_rptr; the read ptr in sw ring
>> +*sw_wptr; the write ptr in sw ring  */ struct amdgpu_mux_entry {
>> +     struct amdgpu_ring      *ring;
> 
> Don't use TAB chars to align--use space characters.
> 
>> +     u64 start_ptr_in_hw_ring;
>> +     u64 end_ptr_in_hw_ring;
>> +
>> +     u64 sw_cptr;
>> +     u64 sw_rptr;
>> +     u64 sw_wptr;
> 
> Align all members to "*ring".
> 
>> +};
>> +
>> +struct amdgpu_ring_mux {
>> +     struct amdgpu_ring *real_ring;
>> +
>> +     struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
>> +
>> +     unsigned num_ring_entries;
>> +
>> +     spinlock_t                      lock;
> 
> Don't use TAB char to align. Also note that TAB char in the kernel is 8 chars long, not 2, 3 or 4.
> 
> Regards,
> Luben
> 
>> +
>> +};
>> +
>> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring); void amdgpu_ring_mux_fini(struct amdgpu_ring_mux
>> +*mux); int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux,
>> +struct amdgpu_ring *ring); void amdgpu_ring_set_wptr_to_mux(struct
>> +amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
>> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring);
>> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct
>> +amdgpu_ring *ring);
>> +
>> +#endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> new file mode 100644
>> index 000000000000..7a59e3fbb970
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>> @@ -0,0 +1,60 @@
>> +/*
>> + * Copyright 2022 Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> + * "Software"), to deal in the Software without restriction,
>> +including
>> + * without limitation the rights to use, copy, modify, merge,
>> +publish,
>> + * distribute, sub license, and/or sell copies of the Software, and
>> +to
>> + * permit persons to whom the Software is furnished to do so, subject
>> +to
>> + * the following conditions:
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR
>> +ANY CLAIM,
>> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
>> +OR
>> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
>> +OR THE
>> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + * The above copyright notice and this permission notice (including
>> +the
>> + * next paragraph) shall be included in all copies or substantial
>> +portions
>> + * of the Software.
>> + *
>> + */
>> +
>> +#include "amdgpu_sw_ring.h"
>> +#include "amdgpu_ring_mux.h"
>> +
>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +     BUG_ON(!ring->is_sw_ring);
>> +     return amdgpu_ring_get_rptr_from_mux(mux, ring); }
>> +
>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +     BUG_ON(!ring->is_sw_ring);
>> +     return amdgpu_ring_get_wptr_from_mux(mux, ring); }
>> +
>> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring) {
>> +     BUG_ON(!ring->is_sw_ring);
>> +}
>> +
>> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
>> +
>> +     BUG_ON(!ring->is_sw_ring);
>> +     amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr); }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>> new file mode 100644
>> index 000000000000..0a2e66318f3f
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>> @@ -0,0 +1,43 @@
>> +/*
>> + * Copyright 2012 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person
>> +obtaining a
>> + * copy of this software and associated documentation files (the
>> +"Software"),
>> + * to deal in the Software without restriction, including without
>> +limitation
>> + * the rights to use, copy, modify, merge, publish, distribute,
>> +sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom
>> +the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> +included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> +EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
>> +MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT
>> +SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
>> +DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>> +OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
>> +OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +#include <drm/amdgpu_drm.h>
>> +#include <drm/gpu_scheduler.h>
>> +#include <drm/drm_print.h>
>> +
>> +#include "amdgpu_irq.h"
>> +#include "amdgpu_ring.h"
>> +#include "amdgpu.h"
>> +
>> +#ifndef __AMDGPU_SWRING_H__
>> +#define __AMDGPU_SWRING_H__
>> +
>> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
>> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring); void
>> +amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring); void
>> +amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
>> +
>> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring); void
>> +amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
>> +
>> +#endif

Regards,
-- 
Luben
