Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7F2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 16:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F8010E6FF;
	Tue,  8 Mar 2022 16:46:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E5CC10E6FF
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 16:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7RYQnn9KPfBPNJ+4/jsu0D/PcL+ahFOp6Gqe20SNFrpwl3gOLvo2Cg5oYtUzKwiU9Bux4ENdvWAw5wNrgtLuV1FSsa2iq4FeBA8aDAtqdVha2yDoFREvld1kyDvVdIJrrLZ5EWHzwBbLGCCZze2sbSwZ3667UA43upj5MfEKxC5KcmJd043Ghbb69CB3QBQhqWMc7avmbkGJWd8+WaIl/+IQBw2IYeAhOW2KqgkSoDyeyp2wCCWyuebQJm+1+ZFAB/38HAy0fpbHPYBAz/Y8Xhwd0KoDmgtbp2qYSgdiKXfBEEfYMM0l1u2V+h6kLAwK4DCy1FSF/3hPZH6vGGIjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDSPzbwtlK3oBvXJIOM9xcJXcm7Gy8dEKYzvubxZ/wc=;
 b=PGu9RLS8f4ZYCh3MkLYjVZicr3HItPcz6SIi6t8jWgvrpabt1b0iipdmbBJZeruhAqy1NRZRXGQ5eLzN4v45VPAG9FtIhDN/Ff9OqMAnOHzeMHE0bSptZWdX/NqNT/hyxJAg4KWqf+gzWgUI+Fuo7Dzg3t81SQKEgwtK6NgGBLQYgT4GJDMQr68pVC4st+d0FRQTEv/MSFg8JixyAsKiI5eZiSgFrYqxdmtDKm4QkOlxQX4GelHtCea6Q4M8GZHa89SaU/KyIsPmU5MNv0wDjASFmRpP64aeKxevYqkVG1RQEHJM9kZtnCQNEHUdnzWorEKITsIBAyGLkSxHur5Kww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDSPzbwtlK3oBvXJIOM9xcJXcm7Gy8dEKYzvubxZ/wc=;
 b=uNB2PuqKY7EnHpTgBWpMitlDAD75FgFUeL1//Xp0WlKCQc6NavKaHOoirO+gFubkRsi4x0XHt12kQr1/AYXEBR4PChCM90+v6u2EjK/BygSy56fYKO6EXk7bEUuAbqhIzw28XPGMguzIk2eh3YVqAqP1sJ7qv/krUaK2Ahh5yZs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL0PR12MB2562.namprd12.prod.outlook.com (2603:10b6:207:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 16:46:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::f037:e2a1:f108:125a%8]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 16:46:28 +0000
Message-ID: <b16fa66b-2712-633b-ee00-27916dbd32b3@amd.com>
Date: Tue, 8 Mar 2022 17:46:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <1eff0822-f410-fd1b-b9c7-6a54862de74a@amd.com>
 <BYAPR12MB461498EFB1E9A3A76A38735497099@BYAPR12MB4614.namprd12.prod.outlook.com>
 <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <5c32f2d0-e278-529c-be53-ffd5603cd472@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0131.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::36) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ba5a0c4-54c7-4241-8abe-08da01233106
X-MS-TrafficTypeDiagnostic: BL0PR12MB2562:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB256251104443628BD235701AF2099@BL0PR12MB2562.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dl48VkHmEJDcClIMhdKN3lAW7mqZx2xiybIBPJ7WjPCEV5g5ZZhqsOIdmEa4eEHtwFMG8EBhSNEBm2QU6SDYAnG6nx6moig5buiV0atk/2TIqGGikoeX4gU/LvMAM0mzBPmz7iq+XJZB9x8LC8s0hsW5RWi+mE+9Cd3QzzYBbOQpAztkh+lzpk9j4U4rr1m4TWIYOZwBxbk9hrJIE3RiXfG2uo6O2nEDB8sF7FcCzaEH4IrgbLP3XOVnqxeBQsyXkePQiHgbfyM2x6AMpZNC3Uv+wWXEjr8HUddlwArggRqPiV8nk6KRX3QkRChzipSyTpmkrZVUoTVVjS3lUKQTc8TBiwhuTlLFPzIddhLzP3liGbY5UejhncohzoS32EC2+b66CL+8O2mnQlHT39gMv8vec0OhBTbqbnH/EyHVW+Z1iTVvm49j7IOGPBWvDc4f7F8Di57SmVzdSpBKTn5LnxKzyYJ4eO8riFei9dsfn5I5FHf6wHikzeTzXt9cCYxgALiUkILWyuQwnuQwHMd8iXvai+zGeOann94K5oUH4F64GtPlT98wwRKAUv9Ut8jpMg/IwUHwTsrCxNmcxXDI79PTrrysRp1AEyp/naKlJa47ab3tCfPVzNcAitCVBBZ1udo5keXYCa2H/MdPZbWhV3fI0LqPDGVFdIbD2L38R8uVp4/ZBXS5e0lgMU5wqcUxG23g2uIvN+iURJd5a6ZBuXwFFVh6VoAjpAVaFQuiyPVL5nibCqKIEDjFnSslp4eRCdhmuutG1RawNyXvqT91UzeUwa1MAuf7tfvHCDpBd4D/ziGuYjlGY/qKyKK0yNfTtS3GKRRbec98+3F27FCxig==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(86362001)(31686004)(5660300002)(186003)(26005)(45080400002)(66476007)(66946007)(66556008)(2616005)(508600001)(53546011)(36756003)(54906003)(31696002)(966005)(6486002)(83380400001)(316002)(4326008)(38100700002)(110136005)(8936002)(2906002)(6512007)(6666004)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzRCcjlaTS95UUJwemwyOTNqdDhZVHNucTE1K01YZ2psdEd4SDA2Mi9FQWFp?=
 =?utf-8?B?TklBYzJRTlJOeTcvdmFxWlRwUkpBYVdKeDFrUktTWTZtZmFHWG56dXU2UmlE?=
 =?utf-8?B?TGlTamlmZCtUWWd1NkVvSDlQU2R1OTJmUHV1YkM3S3RJN2FRVFQyVXZadE9a?=
 =?utf-8?B?VzV2MXpoT2NCSGxPbUpybGpvUTdWbkUxKzJBOGZjMW1oQlV5NzlPa1FJK2Zr?=
 =?utf-8?B?MS9BL1Z2VkJzV1ltTkFsbStwMWd2M292bHZMOG5sSG1OdjJFQ3VVamIvaG8x?=
 =?utf-8?B?Y3dlbXY1MXVFWUMycW5EbFd5cGdDM0lZUE8xQ1pySmRlTzREbVR4UCtadDly?=
 =?utf-8?B?R3p5YkloNFV0SHByWUtoWU80QXViRHBvZCtyejNuSmJUbU15anF1WEhWQlox?=
 =?utf-8?B?dEFuTkJjOWRjdE0waWJwY2cyT0RUMEtPazNoeG8xRFRyUUdGckZPb1hvbkRT?=
 =?utf-8?B?bnNNL1RDdUc1d3Y2NDlxVFhlZWRXV1IrK01NZG56K3ExdWtXMTJUN3JDR0VL?=
 =?utf-8?B?MDRFZHNDeUhWbXJybnZubjV0NUN6SkRieHpMbVNVWDdaMVNKalZ1VGN2OWVz?=
 =?utf-8?B?aVY3KzJScFVLTGZ4UWhyNmRNaFlVNkZOT2U2TFJrTFFnWFdMMWNnVUV5Wi9E?=
 =?utf-8?B?THFpMzgzOTlTQXA4UHM3cTgxNjU1SWl0akY3aU1RL3lzSXB4WkhPUWlFN3p6?=
 =?utf-8?B?Y0VZMTdsUUUwM3J2SXhyRC9IanFTSEM5bHFTdy8vRmcxTHNpNmxZSHcyMStm?=
 =?utf-8?B?NVcwNXdxeDdMNWY5RHdZaU94WmZrdWljY2NoeU41R1l0NU1QUXN1YzNEdzdP?=
 =?utf-8?B?M3V0WGg0cFZGMFFuRHNoVXBTWXdEcURyVFh3aTc5YWpuUmZjdGhPTTRZY2U4?=
 =?utf-8?B?MXZpcG4xaTlibXFyeEZ5UzNNUHBMclo3bHRQbS8ybUpGOVlZblZHSnJyYzZ0?=
 =?utf-8?B?OVpYNHN6UDNMRWd0aFBkYlY4ZC92bXJPVzcwUlBDTHhzTFRYakNvWDRCeUJD?=
 =?utf-8?B?UzA1RDBNQzJSTU94TzdyTTc3cmYwN0R3dGE1cDBUT1pid1krc2pJdFgxRjBz?=
 =?utf-8?B?V3Eybk5XK1lrOHAyM2xHTVFGWTJhZ09rSnQ5Q29zKzZISTFmTUx1OXkxcWMr?=
 =?utf-8?B?UU9Sdk9iaWtVREF4YUxpR1BwejBvc0VOcjlOMHNkeTEzd25sOWxlWmpEVkpm?=
 =?utf-8?B?NGl6R0RHNXpoeFN0cmR0SjZQUkdpZmRSYTRmRlVrS3FHNDVRODYrZEt1YmYv?=
 =?utf-8?B?V1ZUKzlNa2R4ck0wZ1JZSVBBaDZrMFBNUE1FVUJobHNia2Z1Zm9NTzd5bHRq?=
 =?utf-8?B?ZUtvQUgxR1RWaUU0d1dIblV2RkJITktjMWYraEs4UDNNVFlxcjVKK05ycTlt?=
 =?utf-8?B?d1Z6SWlCaDgvcGlXV1Vod2hROGN6a2xzTFByWTJ6WVh6bHZ0NUMxOTdTVUdP?=
 =?utf-8?B?cGlqbDllNHZZaGhIaFJpSGlsREUzZXlCY2FXbk1hTzBoZzZTRW51VE1xQ2Jh?=
 =?utf-8?B?dzBKVXV4VkFJV2dMc3VtZVA5Ky9qbHdGRGhRVVVQSnVnVll0M2NOL0o3S3gr?=
 =?utf-8?B?S3l3N2JSR1RhdFFWWmlBUDNacXgxUGg5amovdGRvMG8veWNtUmJWN21yVGw5?=
 =?utf-8?B?Q1dvaEFBa1VJVEl5a00rb3Vza0NRS1VqWlV0Wi9Nb1RqNmRXaTVXcE4yOWtr?=
 =?utf-8?B?WHpuNHlSdmpzclg1dm1ZanZUakdLS0taMkZVNGxGVVp0V2xPSitNOHljbWRT?=
 =?utf-8?B?SlZjaGtVcWdjRlpUUmVVMCtLeTdVeis4b2U4U1BmU0w5SVRXL1RQT0tQVFJC?=
 =?utf-8?B?RmdEb2Q5ZXVxK2kwL2V1Q1k0YnBibWRzY29kNGJzV1RVcXUxWkVpMUgxVHBl?=
 =?utf-8?B?Y1hudjN2SllLVGppR2ZuQlhYSDhlT1JDWVVGa1ZwcEFuUHViNEQvNzdjTDdF?=
 =?utf-8?B?aVJJVU1IdnYxVUpQUGcrOTVqNlNLcHBIbzMrMzg1aERYVkVhT2xpQmZvWklW?=
 =?utf-8?B?VlF5SjNGd0UrM3JzT0JUQng2K1hXRlc2dDJNUlN4T09laXVNSnpvaUl1S0VB?=
 =?utf-8?B?SGNyaVVPcHJlTGZWSEdkNDBMWFkrT0ZReGZJS0VjMmRaNXB4cW5nZ20wcGZs?=
 =?utf-8?B?Si9QZGNURmlOYUh6UHNxeWRKWXRJV3ZaWGFFZHpoamowQ1Y0aThxUm85Mzl0?=
 =?utf-8?Q?EEaw1OSe9rsDSxlv86blhL0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba5a0c4-54c7-4241-8abe-08da01233106
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 16:46:28.7480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAxfOVizMLfXgYsTRc+XvtP7cE4AE0OlRfVcA8n9SkDfphJ24lxk72wLyj6JPS+aUvnPPyYV7WEKtDvKP7iy2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2562
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I have a very limited understanding of PMC driver and its interfaces, so 
I would just go ahead and rely on Andrey's judgement/recommendation on 
this :)

- Shashank

On 3/8/2022 5:39 PM, Andrey Grodzovsky wrote:
> As long as PMC driver provides clear interface to retrieve the info 
> there should be no issue to call either amdgpu interface or PMC 
> interface using IS_APU (or something alike in the code)
> We probably should add a wrapper function around this logic in amdgpu.
> 
> Andrey
> 
> On 2022-03-08 11:36, Lazar, Lijo wrote:
>>
>> [AMD Official Use Only]
>>
>>
>> +Mario
>>
>> I guess that means the functionality needs to be present in amdgpu for 
>> APUs also. Presently, this is taken care by PMC driver for APUs.
>>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> *Sent:* Tuesday, March 8, 2022 9:55:03 PM
>> *To:* Shashank Sharma <contactshashanksharma@gmail.com>; 
>> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, 
>> Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
>> <Christian.Koenig@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
>> *Subject:* Re: [PATCH 1/2] drm: Add GPU reset sysfs event
>>
>> On 2022-03-07 11:26, Shashank Sharma wrote:
>> > From: Shashank Sharma <shashank.sharma@amd.com>
>> >
>> > This patch adds a new sysfs event, which will indicate
>> > the userland about a GPU reset, and can also provide
>> > some information like:
>> > - which PID was involved in the GPU reset
>> > - what was the GPU status (using flags)
>> >
>> > This patch also introduces the first flag of the flags
>> > bitmap, which can be appended as and when required.
>>
>>
>> I am reminding again about another important piece of info which you 
>> can add
>> here and that is Smart Trace Buffer dump [1]. The buffer size is HW
>> specific but
>> from what I see there is no problem to just amend it as part of envp[]
>> initialization.
>> bellow.
>>
>> The interface to get the buffer is smu_stb_collect_info and usage can be
>> seen from
>> frebugfs interface in smu_stb_debugfs_open
>>
>> [1] - 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0 
>> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg70751.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C80bc3f07e2d0441d44a108da012036dc%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637823535167679490%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=53l7KlTf%2BICKkZkLVwFh6nRTjkAh%2FDpOat5DRoyKIx0%3D&amp;reserved=0>
>>
>> Andrey
>>
>>
>> >
>> > Cc: Alexandar Deucher <alexander.deucher@amd.com>
>> > Cc: Christian Koenig <christian.koenig@amd.com>
>> > Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> > ---
>> >   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>> >   include/drm/drm_sysfs.h     |  3 +++
>> >   2 files changed, 27 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
>> > index 430e00b16eec..52a015161431 100644
>> > --- a/drivers/gpu/drm/drm_sysfs.c
>> > +++ b/drivers/gpu/drm/drm_sysfs.c
>> > @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device 
>> *dev)
>> >   }
>> >   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>> >
>> > +/**
>> > + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
>> > + * @dev: DRM device
>> > + * @pid: The process ID involve with the reset
>> > + * @flags: Any other information about the GPU status
>> > + *
>> > + * Send a uevent for the DRM device specified by @dev. This indicates
>> > + * user that a GPU reset has occurred, so that the interested client
>> > + * can take any recovery or profiling measure, when required.
>> > + */
>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>> uint32_t flags)
>> > +{
>> > +     unsigned char pid_str[21], flags_str[15];
>> > +     unsigned char reset_str[] = "RESET=1";
>> > +     char *envp[] = { reset_str, pid_str, flags_str, NULL };
>> > +
>> > +     DRM_DEBUG("generating reset event\n");
>> > +
>> > +     snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>> > +     snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>> > + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>> > +}
>> > +EXPORT_SYMBOL(drm_sysfs_reset_event);
>> > +
>> >   /**
>> >    * drm_sysfs_connector_hotplug_event - generate a DRM uevent for 
>> any connector
>> >    * change
>> > diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>> > index 6273cac44e47..63f00fe8054c 100644
>> > --- a/include/drm/drm_sysfs.h
>> > +++ b/include/drm/drm_sysfs.h
>> > @@ -2,6 +2,8 @@
>> >   #ifndef _DRM_SYSFS_H_
>> >   #define _DRM_SYSFS_H_
>> >
>> > +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>> > +
>> >   struct drm_device;
>> >   struct device;
>> >   struct drm_connector;
>> > @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>> >   void drm_class_device_unregister(struct device *dev);
>> >
>> >   void drm_sysfs_hotplug_event(struct drm_device *dev);
>> > +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>> uint32_t reset_flags);
>> >   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>> *connector);
>> >   void drm_sysfs_connector_status_event(struct drm_connector *connector,
>> >                                      struct drm_property *property);
