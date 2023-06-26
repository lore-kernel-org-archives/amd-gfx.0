Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047A9EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D60D10E222;
	Mon, 26 Jun 2023 15:13:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3015810E222
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=est3Fo1xqbsPvomO0ghnIE4STkvyxS9usZJCDskQA3cRkFM5i9abWaxP4WsoXETEE+yW/XnYdgok02To3OZWmNQPNAuk6J9BR48/PdJ0ny68Gc2xIvJa4kO8XeTovzzCnvWmn6PtAJZ7x5IoWDL9jZD3y913Vl3Mims9YD74aQa/vqT8Zqp2nU9s5wHzjoXlITVYrAQq9xyMsDOw4BlGfwSYZR4esYQUh4NbppOhWBf9uLyHRSYd5/HqNEkh5ORvA7ueYAXo7xY94PLyTR/PfT8tcukRLAg1jANlJdWU6mAbAbKu0g/ko3BFNqojTcMYhnKFe6ApRNm2GF7n9ipYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc33tnu09lh7YuLRyD1gdjZfiETnInvbv2FaWma0IiI=;
 b=VXlqgxFix6y0KRtY8IiTyD0FNv3xomITxNSpD/v9JmerCEIZ6YY08yN5PL0Wj6SJ+n7x8ebpOc+oBl3nWtXksznAP8KbcBNeabYIO/R4azarayr1/J2IXQE3kFSGxVw01umLyU2RRL2+BuX2Ueo+vhkHiE3RjaGQY4rvgyxwoNHfeciMwcR1GBDYeXTKODC89kPxPhdeDKAjTSwQmgHdpLbLTMCSwASvVdW7C5/0JzVEHnC5ETc88i6pehqihD9bFJmRGgw+qUiaSnPnX2GY1gN8aGbpyNxhCcU7slxW80ELxlWs3+d7pt2B/3+PdQ6GKFHbTBVXLLPBsSTWyZcofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc33tnu09lh7YuLRyD1gdjZfiETnInvbv2FaWma0IiI=;
 b=GtftGITYL4SYqVZCYtr+piEgrAeqAo6fJsMQui1Gqg9f/1xNhG43wxDIk2ztluDN6TAqXZjGr9+D4g9Q4A/kYAlJnno+eu6SAq/cwUQ60tzryJk1dfl+PZx9u9PlERwzV/eF0sk+JVqb1aYAv2zt145AT7Cz6hq/0Xht9kgiAVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:13:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 15:13:46 +0000
Message-ID: <2817521d-89fb-70d2-b2a4-711ef36427d5@amd.com>
Date: Mon, 26 Jun 2023 10:13:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] drm/amd: Fix a documentation warning about excess
 parameters
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230626145938.1393-1-mario.limonciello@amd.com>
 <CADnq5_PTDFHnmaPeG=WyaaOEA10Gf8KhNif9VGGvQC8YffxROQ@mail.gmail.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_PTDFHnmaPeG=WyaaOEA10Gf8KhNif9VGGvQC8YffxROQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::20) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d7fc5f-563c-4400-fd4c-08db7657efe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMGhBwuBru+51qX7FFjpQwb7XHFUJIONYSOzabt8xzKa8qDpCPWc7eU0wHYm3imBjeYcErDNACPCyecVvsWBVyaXDd1+UfmSVIw0YPA7FCe6oLWDfMe+aj+QqLuajXLTJH13lCuoY8LCO/0RalWLmqSJgA7RW0AbANIgWLqLWe3Xm2cGMgP9vZLv9xxtd+bfb0NZ3B+84K9Bf8Vacer8UxdmYgqYHKIBp7uKDhAqhgxBrH2L6SHdq24BFlVGWpgpMqOuABWYmTjin8lKRRwUG5CB7YIEnNMCybfMBOljb1yG7LgMY3a3qTrQG3EBWu68HHF+ed7gYqllmNCLirAkbev8OeKv29ygjVunaa0l5bxc8h3gC8jENxtwG5SM44PKEHVPAoF1x043pD73spb+KJpfhykNeytuvggYvn6AndGAHtlFY+YVrqfuVfp6QWDmMY5SDJnLloU13GV6Wf6mGIs5hRs4KOlbrZ0T8BJ81Rtr4y8nWEM5OhnRrNTkMO4mjcDV6sZJNUF6KKCYx+UkuWK8OkJcMpwPkoe6ihTBInzM4jg9ZPYfr7K5Mz7j8MmdoNLa5+uZN/AP/0IlYkbAurkuO1y7g+Uqd2VqIxe3Srt5v+cJlhjRAP0+NOtVkuNsTw/gnmtuASzDf95H7oWYZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(6486002)(478600001)(53546011)(2906002)(6512007)(186003)(6506007)(26005)(66476007)(66556008)(66946007)(316002)(8676002)(41300700001)(5660300002)(8936002)(38100700002)(36756003)(6916009)(4326008)(86362001)(31696002)(83380400001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEt4bW9GbnNHWVRQWlc0SXJldmdCaVFSTGFXcWk3VWtqdnlnWENoWTd2TXdB?=
 =?utf-8?B?Sm0rL29BSWY1TytNams3Z2QvYnpnRHBJSkd1bkE5N3N1MERucFJFalQ5eldJ?=
 =?utf-8?B?Qlk0R1JNa1ZyaUxZcVdsbDV6QUQ1WFVWdFZqdDdHVk4yNGx1WXR4K0Z0Q2tZ?=
 =?utf-8?B?TzFFTHJDNWRWcSs4ejNVU3FZOGx4MkFqQ3ZJVzVzTHhFb2plNDFWcSsrQUFJ?=
 =?utf-8?B?UVNUaUp1ejlSRkNIOTFLTXkwbG9mU0R3Wk5hZ3BTNlVjQjNYVE9FdUQvV0VG?=
 =?utf-8?B?eGNySUJUNW5zUTZqNnVDZVA0V2kxb3ZzMWtuQkp2VUdzV2traVl5S25lMG5Q?=
 =?utf-8?B?VmJmZE1udkw4TVl5T0pnQmllRytKSHE4RGZPNFdFaGwxcTNXeWxWRXhCbG5t?=
 =?utf-8?B?Z0RZZk1nWVpvcmtUck1QdjJiRlI1TnVvY0EyNjV6VC9ETHExcm5tUCtmazZ5?=
 =?utf-8?B?ZVlHa2h5VEZuVDRhV0tPbE52RkRQbFl4Z3ZpMUM1dEJvQzdZblFycjVRYTdn?=
 =?utf-8?B?d1p5SW54UnlkY2E5VlovZFhMOG0rc3M1U3I0NUtQUk5FNnlQS0UrbkV0MTlz?=
 =?utf-8?B?RmxzdUhxdlZFRWEvWnNIejd2cnpKVVRxK3JTQUJDY1VNdHV5L25COThWMjlS?=
 =?utf-8?B?SEN6cWNTMDJ5VnJxZ3VlVm5qVVF6a0RmMGZ3UzdLRGVybkkzeElyYmxJRy80?=
 =?utf-8?B?MkYrUzZRUkkvdUJPRk9TOTA5d1E1cnlvWFMwWklHRm1EeVZxRW5FL0ZITEdN?=
 =?utf-8?B?d3dtd25NSytBckUwbnp6bWNFaldRRWtjbDF4TWNnOC92SldWSGc0cFZmYytV?=
 =?utf-8?B?cUJKVlRoVkFpQjJuUGwvS0F4SnJVbWxHeDJVOFFqZVlzNjBqTEJ3d3g5SnpL?=
 =?utf-8?B?eXAyTXNIRjZlYXpaR0ZBTE00VHJQaHlLOFlLR3hQMUFob3gwamx2d1IzeUha?=
 =?utf-8?B?dmVIb25MZjhsZ3RhWGZrMm01aVE1Qy9zV2RqWVRQd2wyVU9lc1BmRHdERHk0?=
 =?utf-8?B?V21scjBTV2ZJOEFNRnhmVEtORVR3aFhPU3IzK0Z6SHpXNzNrRHBoanBIV1R1?=
 =?utf-8?B?cmVpVzN5RFk1Mnl2eGJTWmY0QnlaeEkvQVdlOUNvbU02UDV5eEVxV1RPZC9t?=
 =?utf-8?B?TUZTVS9PZVBOVytaZm11ZGNSOThnSW9NdVE0SmdoejJ1ekdmc1R1em1xODVv?=
 =?utf-8?B?WFFqbVp2NjhJSHBUZFhhbXo4Qmh0YTJRTHJiT2twTW03T0pTRWV3R0xNeTdF?=
 =?utf-8?B?T3NmQ01XRlVqQjYyY25zR2dLN254RnlPWjRSQjZzL3JPb3ltNXFkS1BkaDh5?=
 =?utf-8?B?Sm9GeGJzMFNIdTh3aFNiOXVIdm5PQjhSMlBFRlF4TEM1MW02a2ZyUGs1QjZX?=
 =?utf-8?B?NjZ5TDhwZFNUeGlBM0pqbUh5eEdqWUpyWkg0M05sajllUXhWYXM3ckxwTWx6?=
 =?utf-8?B?VTJBUW1EYmRVZFRFWFY0TCtnc01DV3pmN0QrUlNKbU5hM1RlMzkwN0pVYjRa?=
 =?utf-8?B?YXM3V2l3ZEpnaEs1ZENQV3h5ZW8zZjZrcDR4Tnp3dGFBMHNPNXpIbEFSUmNC?=
 =?utf-8?B?cFhkTjRIdzQ4ME9vWkErdzlRQjF4aUlVajl2NHpxNlh2NWh1UXkvMHBUNkZM?=
 =?utf-8?B?Y2NqbTlDQnJnUk1heWtxcVNlL1VzbTRKV2xVM2ptOGEwVG0rZmUzSk15QVBi?=
 =?utf-8?B?dHhZamN0bWZ6aVpTK1ZGY2hrU1U2Y00vZzZWakNxcTJ3RWlqVTV2anl1S0w0?=
 =?utf-8?B?UkYvQnpEbHRWWDFtd3Z4ZitQY001eCtCMHVGbUNVeGFIdFJtTkpTZ1M4MEow?=
 =?utf-8?B?VHQ3N1FJNjV4S2pscWMxbzVscWlVRU54cFBKaTJEaWY1U0VsZkxsT3pRTEds?=
 =?utf-8?B?N1paS0dlMEIwVDhGWTl6dkdkeithSWcxS0dUTThUL0Z1eFVlTFJkcSs2VzRM?=
 =?utf-8?B?cHdGMUJlRmNpT3h1VUUwN2NLTGlIMkpQSEpQRWNsenFEbE00NS9neDU1L3ZX?=
 =?utf-8?B?VjhjVDMzTTFJakhPQnZSNDNHRktiWWNEcG9ya3lHeU45VFRsaUlkV051Tk1P?=
 =?utf-8?B?Nlh0VUNZZWVpaWFpdWhLTWFuUFJXdnRQZTR2SHZ3WFlmUHZoOHdiNllhM0o3?=
 =?utf-8?Q?Obm83hnEV1/7F9xtQUi2CLscG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d7fc5f-563c-4400-fd4c-08db7657efe2
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:13:46.3376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BR9WA9Xn6vuylh6sm0YUrJcn429In7UzRgsAoxH/1M+iDyKQ+oFv5e39Gk/UkW8+dvHyL0d48AlvhpJ88YHVew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 6/26/2023 10:05 AM, Alex Deucher wrote:
> On Mon, Jun 26, 2023 at 11:00 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> `pcie_index` and `pcie_data` aren't used by
>> amdgpu_device_indirect_wreg() since commit 65ba96e91b68
>> ("drm/amdgpu: Move to common indirect reg access helper") but
>> the documentation wasn't updated. This causes a warning while
>> building documentation.
>>
>> Fixes: 65ba96e91b68 ("drm/amdgpu: Move to common indirect reg access helper")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
It turns out that the exact same patch already landed in ASDN as:

fbdfbe84aaf4 ("drm/amdgpu: Fix up kdoc in amdgpu_device.c")

and I missed this.  Sorry for that.

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 65fe0f3488679..a3dae8ffbdb10 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -747,8 +747,6 @@ u64 amdgpu_device_indirect_rreg64(struct amdgpu_device *adev,
>>    * amdgpu_device_indirect_wreg - write an indirect register address
>>    *
>>    * @adev: amdgpu_device pointer
>> - * @pcie_index: mmio register offset
>> - * @pcie_data: mmio register offset
>>    * @reg_addr: indirect register offset
>>    * @reg_data: indirect register data
>>    *
>> @@ -778,8 +776,6 @@ void amdgpu_device_indirect_wreg(struct amdgpu_device *adev,
>>    * amdgpu_device_indirect_wreg64 - write a 64bits indirect register address
>>    *
>>    * @adev: amdgpu_device pointer
>> - * @pcie_index: mmio register offset
>> - * @pcie_data: mmio register offset
>>    * @reg_addr: indirect register offset
>>    * @reg_data: indirect register data
>>    *
>> --
>> 2.34.1
>>
