Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2813C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jun 2022 21:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC9610EC2C;
	Thu, 16 Jun 2022 21:59:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382BB10EAD9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jun 2022 21:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCEEQww6fFy3YwgwRMkvDyg66N2cb6NiyfDbgCBgnUe4b83QZM10ynurzqqMhsa3JgJe6n1sR2vlnAjHJDzkzgX3JYW1t12bW/y1WfLFuZwlMyyB47MGziyVp6UCNnLe0qshcQWS8DMzn3HO6ad/VlZ2gzk7l0rb+lQNKcJQgbgptElNY0wGZrTw7VhnqmGR8pOhipnh/ztHjTMTbX1oHuS/vZZvvZ/BaCbAp3zKWms3UpRI1i/n0r7T6wNvpwKp7twLbW4n3Mlt+JGqSE1UkGPW/1I0gVJCL6DP6eyr9Dbzd4ugW9sE40NHeBkzKczIJ6ZhkVE39/YIYZaDUXfUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRuKTaEwLlZwQCPUO21PsNaVjH4awi0Cf0WbOKaJQ/I=;
 b=mYXag55AtW/1m2XoyBU/t5+qbmKxqFVEgKbM65mzcvqcGVpi2Cl/5NeBs/zhvN44et+PZGZhedxxu1nhUNP50jw5d6JnXcJOMlnLwcwyVovQXN1gtaj4R9Qc+tQhhRd/daumKsTHi+f9KwDq4t9RvWRxU06V+EcC6XEksy7VM91l0Yar3FjfeagRvV6nqznE6atlCOOJh4LwtkG5h6Wt++pYDllAc5WTxPBwrbqKGiOOFhufQ1L599+3Gab+xXELGyjTSlJMcpxwTOoUFWZni8nUlOalY4f0b5kCUiOLpuSXnKpcqfwLM9IRzq5tKiYaVbPc+rRX8njtVPYI3dl+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRuKTaEwLlZwQCPUO21PsNaVjH4awi0Cf0WbOKaJQ/I=;
 b=Vgh9cTIJUD0mGrQUexPsIgO83/piyt3EAr5wrs5OUxhyeUtLtheesO0yqOVuiDiwM50kby/IYL8fu3hCoZbNU2XrO17xwqE0c7p23DIjjMdm73yiUx1V1RT25lbDijzrfVy00atLEAEpbybZXw3G4bydpPrW7t9FUIg5FP/R4mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by BN6PR1201MB0020.namprd12.prod.outlook.com (2603:10b6:405:56::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 21:59:22 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::85a:3075:1744:8317%7]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 21:59:22 +0000
Message-ID: <d48aa87e-b5fa-0437-d637-d7306b115311@amd.com>
Date: Thu, 16 Jun 2022 17:59:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] Documentation/gpu: Add an explanation about the DCN
 pipeline
Content-Language: en-US
To: Pekka Paalanen <pekka.paalanen@collabora.com>
References: <20220613200112.3377638-1-Rodrigo.Siqueira@amd.com>
 <20220613200112.3377638-3-Rodrigo.Siqueira@amd.com>
 <20220615141204.62ba64e1.pekka.paalanen@collabora.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20220615141204.62ba64e1.pekka.paalanen@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:610:b3::7) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7be61f3-6847-407b-b00a-08da4fe378a6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0020:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0020A874C49E558E489379AC98AC9@BN6PR1201MB0020.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0cs7oG5Z445XmCj0TByfhF0OMLhp951Izx8VY2/dxUJLLWwzDmTrp6dt13hhFZLzC46Flx87fQU9DcINI8EUS4sNuhIevXMIKaO7ITF1WiHfVHZMjYrLdtqCyL0CtGvSimHuz0CLUFhlGHUuhgfNqtvv8DhaZoqBLf1qQNaLISbtNo/tja6vTQ6hHlaps8N4UG8xUbAsSpgo5fX48fYYsgijibjSp6YgUi8RmJ7F7ok78UwYkJVf07skS+7jL5D7zEJoMjR+4hGhhXHxGlR6idSFpinjJLR0GllcJz0Z5KqALtUJjn1pBfON4HnS6qnx96GmISbdPgagWPBn6KrDl1wOiCmaopul3OfmaDES3vaTjyTayVdZzX3mvmb9l8YI/F60FqsWf5EX6NbNezmbsr3/r/tPP5iBnacTVOZ9Kj2ji0zxm7hUaRyzUk2ReXhCBHca39zUv4pvuF8MQcOGJhXANnxd/PhlUOg80BCKsX8PmOs2Gr91Q9pq8zCvwWs0DlcK6mfkeZygaAkvRMobr/xZBo+Z2H59/8zolQaUlXeaz96AH8CM9KHAsrSflFPm3cwU9ox+wLJPuQ6NNYg9XR6P8JpBOQtfkGJTcBxDV5Ms0gp/hkMHo1qz2M+/D/Cthq4ASpPVyQcZFdIrmAFQRTFgkQLFf085mdR9ReBtVlmVcs3gUOzJ05JiXaV2MVMXl8trM1ndUwIiP4yfl3K2qrCQOMtI2Ekl9PveN9t6sKTriGg3ch7TRDHERWL1TPhh73ypEWjIgeDZodgl3mU0wHc/o3qYXrC0tfAT48gKw02XdjL5HNdDs6C/0okkWgC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(508600001)(6486002)(8676002)(966005)(54906003)(7416002)(6512007)(2906002)(4326008)(66476007)(8936002)(316002)(6916009)(66556008)(66946007)(36756003)(5660300002)(31686004)(31696002)(86362001)(2616005)(66574015)(186003)(6506007)(53546011)(26005)(83380400001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDVFbHNHd3FydTBubjFjdU5WY3hNU0xzU1JMaXVGZkpBL0NFZXArbGtCZUJh?=
 =?utf-8?B?WkpjODd5ZjhqWjU1T0d5cFY0ZVJXWDRMNUlwN0dBRmhxVWt6R0pUY2VvbGlU?=
 =?utf-8?B?SEZnaXVrWDJUVWdabjRsTW02OWpIelVJSHFBUGFsZjhGN2J0UWZvVnhKbE03?=
 =?utf-8?B?QklnNHV4Tnc5Q2RseE5uMkVmQ0IxZXFYMDNoM1c2T2ZsNlJkVFZaUG1ubDBY?=
 =?utf-8?B?Mm9VdmcvVUdFcWk4akZ4Y0pWQWlLa2Y1dnI1TXNPUEVGUWdnaHNFNVZzL1Vt?=
 =?utf-8?B?SnRMVEYyNXk5U1hNYjlqUDJXT0J5WEtKRFY0YXpzV3V2OUtWcjJPZE5tU2wx?=
 =?utf-8?B?UHlXUS9vczR3S1RGYktad3pkeVhzNkpWaDh6NllUaUJtbVpXVUozaXlKemg4?=
 =?utf-8?B?cDlPemh4OEdOMTJwN1J5U09ZdUZNbUlmQk80UFNNUjQ2VGV4VXNyMXFyRG5P?=
 =?utf-8?B?RzVzbnVyNDQyNng5T2I0NGVsYjlCNlk5blRRT0lzaEZLV2ZtR1RkeEJYRzc2?=
 =?utf-8?B?QnZQczJlUG9PWjNMYXp5WWlqblVlRWcvWVFhRThEWnZmRWE1U25RTVN6bXBo?=
 =?utf-8?B?MHhWYS81QldRK0NjQXI1WUd4OUxNUDk4UjlFVnRqaElSKzU5ZEUxN2Q4K0M5?=
 =?utf-8?B?SVJTdkhvNzI2Y1k3c3RuNm9BR3M5elY4Z05NZzR1ZSt0V2ZYR04vUk1pTTc0?=
 =?utf-8?B?WVZqKzI3RDhGeW84b0c2MmJBN3hvQ2RSNWRWc0R0aGJMTUVLWmpXQk9oODhv?=
 =?utf-8?B?R0JvTzBzbjdQWDZHdUZsMExLQWFGNUszczRnS0NnT3U1ZExFdUp4OExGc3NW?=
 =?utf-8?B?bi83OVBjRFZZZE9JODFKTlR3OTdPMDA4R1hJU1JHWTNnRWNFZGx1OFNrRW9G?=
 =?utf-8?B?M2pJcUdPT3FySEUxSnhPUlpJVjExN1RRVFV5WTI2Vk9GaWdDU2cwVUNYZE5k?=
 =?utf-8?B?emEweGxoZ2xtbEs5cUJjMUVmdHNMc0xVSnU0Zk5JbEJnWnRmdGtKb1Q0RlQw?=
 =?utf-8?B?TVJTTHV5M2JqaFVaNUprVGhSZnhkY3paUy9hZDMra3hNYmUvMmwwOGcxUXJ0?=
 =?utf-8?B?UE9zS085bjlNUzYzOUpwdUJjZ2I0b2p4N3JtNnd4aWp3UFlweTdWalZhNEgz?=
 =?utf-8?B?VDhFN3BXSllEMlY5SUhhbWQ5VzdxZlV3R1ljR1FDU2liaGZOaVVmYi96Ry9M?=
 =?utf-8?B?cGh0WFBPd3dmbFNmS1ZsUWd3akc1eGtuVXA5OUhYVFUyWk41OURMK3IzSUxn?=
 =?utf-8?B?enNFM2x3M2ZZQmppMTEyZHpubkJyWmpVU1dIdHhjQ3dPL1NTN1RPYXdLeDNS?=
 =?utf-8?B?UnU0WURnNWlSaGsxa1ZuK29COXhiZFlUL25MUW5mRjRyVUVGd0FKdlgzdE1i?=
 =?utf-8?B?OGlQSDlabU9DRnZLNlM5bmRsUGQvTVpZUkt6UklaWjN2SkRtZ2dUNDhac3d1?=
 =?utf-8?B?bU42cEZqazFmOWw4VUxQZzNMekF2QzJ1Z1JuV2xjK3B2Tkx4L2czTS9rd2hx?=
 =?utf-8?B?NGplRUdzYTBUWUttd3dOQVM3aTRveU5DRlEzS1pVZFBQV0VjamdRbDdVR05k?=
 =?utf-8?B?bHZsamtXTGgwZDhJUzV5OEYyTGNFV2ovN3p1aTlyTEc0Uks0clhFMzBnanRH?=
 =?utf-8?B?NGhNbUVHaDloeUFNSHVFOVhiTlJjajRkZEJnQUE2NnI1QnVGeGZuR3EwY2Nn?=
 =?utf-8?B?dmVVejJiTThCZTJTUnppTXVwYWVWR0RpSSt1QnRFNVMyVzl2emFjcWUzMEd2?=
 =?utf-8?B?WHVHODYyeTEwcFhnSmlnT0cyNERYbnlFMjY0bklHa2c1cXlGSGpRYVg4UWIw?=
 =?utf-8?B?TTFhUEQ1bGVnVDB1MmsrMFY5L2I2S2hIcThPWWYrU0xRVlVieHVCUUNOWnE4?=
 =?utf-8?B?OFQzYnQzeGNpcElxclVjVThNeGgvT2JnRnZGRzJ3ZXVRdUl4OGc1dUZ5Qlhi?=
 =?utf-8?B?aG1UVHhtdkg1SFl3NXg5cXBBOUxBY1FiYXhFVVZmbXRCdmxsYTNjV1lxeGNT?=
 =?utf-8?B?UFUzWXJQcUcwOE9XQTNDNkE2NlowbTZHeURxNUJVVjJDKzRXdGI5KzB0MTNS?=
 =?utf-8?B?bXlBTmZDbjZpQUtYWS9VRVcxYlhJZXBUVjQvY3dIZi8rVUxHS3gxOEN5eWtN?=
 =?utf-8?B?TWtab1ByNGd6UnJLanZaWDdIQW1qZ2R1L09jcmFNVTdORGlMaVNYNlhYVHlq?=
 =?utf-8?B?N2ZzZG9vdHRGU25ycHJycUpyT0dSMzFFTnNMM3dZMW5wMldVM0UyOEE0c0hB?=
 =?utf-8?B?cHM5OWEwY3J2SjloRFhBWkR2ZlJqbS92cDU4Ris2QTV6aXNlVE5jeWhDaDEy?=
 =?utf-8?B?YlpjbU53WDhCUTlpa3VUN3JpL21LYUQ2bG01aVk3WGxxUlJRaThRdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7be61f3-6847-407b-b00a-08da4fe378a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 21:59:22.8269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pti8H3Z3iiQZ5xH9OzxISHQjGHncaWSEoPN7+M1hqGvMbhu1pdxyDwzKXR8HFnvzpbzRsorO/Cr3/ajP85ishA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0020
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Mark Yacoub <markyacoub@chromium.org>, Simon Ser <contact@emersion.fr>,
 =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Hung <alex.hung@amd.com>, maira.canal@usp.br,
 amd-gfx@lists.freedesktop.org, mwen@igalia.com, Leo Li <sunpeng.li@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 tales.aparecida@gmail.com, Sean Paul <seanpaul@chromium.org>,
 isabbasso@riseup.net, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Pierre-Loup <pgriffais@valvesoftware.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-15 07:12, Pekka Paalanen wrote:
> On Mon, 13 Jun 2022 16:01:11 -0400
> Rodrigo Siqueira <Rodrigo.Siqueira@amd.com> wrote:
> 
>> In the DCN code, we constantly talk about hardware pipeline, pipeline,
>> or even just pipes, which is a concept that is not obvious to everyone.
>> For this reason, this commit expands the DCN overview explanation by
>> adding a new section that describes what a pipeline is from the DCN
>> perspective.
>>
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
>> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>> Cc: Leo Li <sunpeng.li@amd.com>
>> Cc: Simon Ser <contact@emersion.fr>
>> Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
>> Cc: Sean Paul <seanpaul@chromium.org>
>> Cc: Mark Yacoub <markyacoub@chromium.org>
>> Cc: Pierre-Loup <pgriffais@valvesoftware.com>
>> Cc: Michel Dänzer <michel.daenzer@mailbox.org>
>> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> ---
>>   .../gpu/amdgpu/display/dcn-overview.rst       |   58 +
>>   .../amdgpu/display/pipeline_4k_no_split.svg   |  958 +++++++++++++++
>>   .../gpu/amdgpu/display/pipeline_4k_split.svg  | 1062 +++++++++++++++++
>>   3 files changed, 2078 insertions(+)
>>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_no_split.svg
>>   create mode 100644 Documentation/gpu/amdgpu/display/pipeline_4k_split.svg
>>
>> diff --git a/Documentation/gpu/amdgpu/display/dcn-overview.rst b/Documentation/gpu/amdgpu/display/dcn-overview.rst
>> index f98624d7828e..430e363fccae 100644
>> --- a/Documentation/gpu/amdgpu/display/dcn-overview.rst
>> +++ b/Documentation/gpu/amdgpu/display/dcn-overview.rst
>> @@ -124,6 +124,64 @@ depth format), bit-depth reduction/dithering would kick in. In OPP, we would
>>   also apply a regamma function to introduce the gamma removed earlier back.
>>   Eventually, we output data in integer format at DIO.
>>   
> 
> Hi,
> 
> always nice to see more docs!

Hi Pekka,

First of all, thanks for your review.

> 
>> +AMD Hardware Pipeline
>> +---------------------
>> +
>> +When discussing graphics on Linux, the **pipeline** term is often overloaded
>> +with multiple meanings, and DCN adds another context to this word. In the DCN
>> +driver, we use the term **hardware pipeline** or  **pipeline** or just **pipe**
>> +to indicate how many DCN blocks we are instantiating to address some specific
> 
> This seems to say that a "pipeline" is a number, a count (how many).
> 
>> +configuration. DCN composes those pipelines together when the data reach the
> 
> This seems to imply that each "DCN block" is "a pipeline".
> 
> Is either true? Is a pipeline not a sequence of selected DCN blocks
> instead?

In the DCN we can have different pipeline configurations. For example, 
see the below picture:

 
https://www.kernel.org/doc/html/latest/gpu/amdgpu/display/dcn-overview.html

Let's say that our pipeline policy does not allow pipe split, in that 
case we will have just one instance of each component. However, if we 
decided to split our pipe, we will have more instance of the other 
components (e.g., 2 DPP). I added some examples about it a little bit 
below in this patch.

Try to apply my series in your local kernel [1]. That way you will be 
able to open the svg files at Documentation/gpu/amdgpu/display/.

Maybe I can rephrase it, do you have some suggestions?

1. https://patchwork.freedesktop.org/series/105071/

Thanks
Siqueira

>> +end of the OPTC block before sending it to the display. We have this pipeline
>> +concept for trying to save energy and optimize bandwidth utilization while
>> +providing the maximum performance per watt. It is easier to discuss it if we
>> +dive into this topic by taking the example of a 4k display in the below
>> +example:
>> +
>> +.. kernel-figure:: pipeline_4k_no_split.svg
> 
> A bit too hard for me to look at SVGs from email patches, sorry.
> 
> You wouldn't happen to have a git branch available in Gitlab or Github
> or even cgit somewhere I could visit with my browser?
> 
> 
> Thanks,
> pq
> 
>> +
>> +Additionally, let's take a look at parts of the DTN log (see
>> +'Documentation/gpu/amdgpu/display/dc-debug.rst' for more information) since
>> +this log can help us to see part of this pipeline behavior in real-time::
>> +
>> + HUBP:  format  addr_hi  width  height ...
>> + [ 0]:      8h      81h   3840    2160
>> + [ 1]:      0h       0h      0       0
>> + [ 2]:      0h       0h      0       0
>> + [ 3]:      0h       0h      0       0
>> + [ 4]:      0h       0h      0       0
>> + ...
>> + MPCC:  OPP  DPP ...
>> + [ 0]:   0h   0h ...
>> +
>> +The first thing to notice from the diagram and DTN log it is the fact that we
>> +have different clock domains for each part of the DCN blocks. In this example,
>> +we have just a single **pipeline** where the data flows from DCHUB to DIO, as
>> +we intuitively expect. Nonetheless, DCN is flexible, as mentioned before, and
>> +we can split this single pipe differently, as described in the below diagram:
>> +
>> +.. kernel-figure:: pipeline_4k_split.svg
>> +
>> +Now, if we inspect the DTN log again we can see some interesting changes::
>> +
>> + HUBP:  format  addr_hi  width  height ...
>> + [ 0]:      8h      81h   1920    2160 ...
>> + ...
>> + [ 4]:      0h       0h      0       0 ...
>> + [ 5]:      8h      81h   1920    2160 ...
>> + ...
>> + MPCC:  OPP  DPP ...
>> + [ 0]:   0h   0h ...
>> + [ 5]:   0h   5h ...
>> +
>> +From the above example, we now split the display pipeline into two vertical
>> +parts of 1920x2160 (i.e., 3440x2160), and as a result, we could reduce the
>> +clock frequency in the DPP part. This is not only useful for saving power but
>> +also to better handle the required throughput. The idea to keep in mind here is
>> +that the pipe configuration can vary a lot according to the display
>> +configuration, and it is the DML's responsibility to set up all required
>> +configuration parameters for multiple scenarios supported by our hardware.
>> +
>>   Global Sync
>>   -----------
>>   

