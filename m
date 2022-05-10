Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB123C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 16:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C61510E618;
	Tue, 10 May 2022 16:34:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24AE810E618
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 16:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijfuYgEiaRlJ4fSc8+iAlDDLtdwGS4zN43RHY90Se97Be9+iDF8++GeavYJPLvfKGuUvm3nNtzVBSm07N2aJySX7gPFi7Ie0MKYXidimdP0w3Ju3KVtg9fACHoXyFhoix1KR/dgPJF7cc6oQ6GcWBkyT4Tpuse0f4MBBy/Gc5DlyOAid7kT+R2rcFuLE3yGE1DBS7CLZKfkR0+cD9y7NyDKDIPbM11QSgNaNwdRHifzTnVKF6fpSwImGdcbsn4dwQ65KHZ2EBTss8RPrZ7IMN1OBG81OP5fABI/LKvnRSODF5y5hp0bLCQ3WsjMt3OKRkEwBzpmPfdWfyyfliSA+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blq0Bfchajdq1+1A6+mf+9p9ifNaiDpK5Ow9UckHIIs=;
 b=fHUBpqhC6pqq1LqEMkKDZ3I8SZcd1SBIB3E+UofotfqMOkORVzt2r/DuBFGDenUJjZDUl8O6Je8NxeQmc9SuFBkJbtAkMIFh1IEGKjJ7lPeKKCH1eR0OpPuNbBBSWwlhh2ht3KX82j67tM52Uf1sGGpbNteSt0569Lit6Drmi4dFh2ZwaYc3w2mcEgOOWGe0PbgBoeEDjtAyHBTftJkKZ8DDMi+LfJ6hZyaRRIbC+DLgKYIPFGKeaw+pwL5Engz4/8m5YSq8jX9r5jj/SNfy2DaRzDG/ip2y0kwbOGVRaLo2f0JgZ0vHKt4NqmNozrj0xBlHBjaV3gjO4EoHryYyeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blq0Bfchajdq1+1A6+mf+9p9ifNaiDpK5Ow9UckHIIs=;
 b=034qB3IvxlmW+lWf1yu5g7+pTm3uSrqOyOweWp/AvcaItTnS6Q27wnrkqOotoM1yVt+YdHYFOnaa8QODysSYaaHq1A9SHxxyYgeUEFyFGQXcdTUhuQb8Zh+qTdkyMbFpiPW3Y64g0tdk2Lz2hO7mL0Y9yupWP/Q0rtUmXn7AFEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB1227.namprd12.prod.outlook.com (2603:10b6:3:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 16:34:09 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::1ce8:827f:a09:f6e%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 16:34:09 +0000
Content-Type: multipart/alternative;
 boundary="------------oXnjjJdqUicSDfw3qS4dNHZQ"
Message-ID: <41735d9a-2989-f795-c67d-c451217bddc5@amd.com>
Date: Tue, 10 May 2022 12:34:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [EXTERNAL] [PATCH 2/2] drm/amdkfd: Add PCIe Hotplug Support for
 AMDKFD
Content-Language: en-US
To: Shuotao Xu <shuotaoxu@microsoft.com>
References: <20220408084544.9313-1-shuotaoxu@microsoft.com>
 <08212428-471E-4C1C-9037-9AE16E9BA356@microsoft.com>
 <5c22aa65-f75d-bc05-e210-f28533d9f0f8@amd.com>
 <5A64FAEA-CCE8-4EB6-8E7B-852D4F384255@microsoft.com>
 <c771861c-f25c-1953-3cb7-f805ddb11aa3@amd.com>
 <B7970589-ACF6-41F3-8622-1C0F705F3EE0@microsoft.com>
 <42927224-900a-8548-80c4-13cda4d3f867@amd.com>
 <76C16B06-0539-48EE-AB11-80089490CE3A@microsoft.com>
 <c82b697a-b032-1b03-8a9c-49af57f4ae9e@amd.com>
 <7825EEC6-BAF8-4B71-B01C-FE246D360779@microsoft.com>
 <c5a41b51-5275-05dc-2a4e-2522ddb898b9@amd.com>
 <0FD33B90-BD27-4F32-9735-CA525735B5FA@microsoft.com>
 <77a8677a-0ac9-74be-598d-a2e8cf4d6883@amd.com>
 <549246A3-B326-47CC-92FD-608708E1876B@microsoft.com>
 <34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com>
 <0d99be40-f6b9-b191-feca-d74344f03bf2@amd.com>
 <FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com>
 <66bf32d5-1636-ecdd-8a49-24c6254079bf@amd.com>
 <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com>
X-ClientProxiedBy: YT3PR01CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::34) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cad9300-35c5-486b-691f-08da32a2e826
X-MS-TrafficTypeDiagnostic: DM5PR12MB1227:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12278ABA0990297774706A5AEAC99@DM5PR12MB1227.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jz0l1dAdsM/RqA4gB8MWAJNAazw/0W2DzZSEhIxjlBfpa8HHMFqLhVbGVa0gObjeExHiTVhamU2g2Mf4+NCc3CDrllcrEgdVNfdtv67IYwaxPrwvP1ohnK4tBRDPN+jqKcKcJe2olyrohcB6Bcw8hrlUxaL3jnEnJKM0g7FlAnRcvjVT4bBoBvApwGe6nkUJUw0eSbQrRKY0vxXbmdr1A5jQapGPvrk2jsSVuaiKcnP1y6mw+3VLh3ObJn3i7Af/bLezCNw8KHehBMc5nbSqu7ZzpCOrIfydLfpbgAOpODi1VcOe/7+MRgwCRAadfTKZDJ/DaPiam9QIJIuG7zmBQKzWtRgRW9m8gz6q/J0RW/YlUB4/zX9KXYs6nh0WioX1NOP28Kdx0K62IhijAq3ViPq0+m/vfRTbtDRZzgzQhu6xKjV0YEQa6YnbeBVODKoU5M+NIz00alaVoPvl3YvP8Izz+5wYUGyGXpsJp0baA+a3o5rjrsQmwkNDmJTKNcnDc2Kzi3exj4nV35gz3N9e0j1AFg3Y/Zf6YQHYdW3tHojuxIYkimNWJgM00rgj+hKJPMMRgMKAUrn4zdWPv6J3mcoYt1AQVhpBY0TUAhQwbzgGca0O/u1pUlq/q4iMcVhPRSX79njSfCMd13fQo0P8+bx0ISeYddmaqZav3jNm0Aq4hRdubYEepIanWIWFJTAR/oD0MIH9sRgFjds19Qz2uVvB3DRquvKe43XKodD9H3Oa6Qzx2LZ+jSglddSUx8mnK43Oq3KkOpbDblsaDLr/AiwHd5XA2LvMhH4MSzUXSseuX9N5dEzwESYYJh04mCwlCP88ZvFA+k5lqUgtOdme7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(53546011)(33964004)(2616005)(186003)(316002)(86362001)(6512007)(31696002)(4326008)(38100700002)(30864003)(44832011)(5660300002)(6486002)(966005)(8936002)(508600001)(36756003)(66556008)(2906002)(66946007)(66476007)(83380400001)(54906003)(6916009)(6666004)(45080400002)(8676002)(166002)(31686004)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MysrTDhldUE2dlpzcU92V21taVNydXNSRC9OSVdGam1UNVRkNjdrdEVldDRp?=
 =?utf-8?B?YnRJRnZjWUJZSlRZcWV0YlJtWm5WWjk4NjJBdHA4eHB6RFIzSUFWUWxRRElo?=
 =?utf-8?B?OUxlQS96TkgraVdOMk1LSVJ5OFQvdVpaemRGVTV1ZVJvWFBpdVZvUlV5eE13?=
 =?utf-8?B?emFNNHVoblVQYUdtbkF5ZWFjVmdkRjFuVUVWRDRnQnBlZUFkVzZ6T3diTUhC?=
 =?utf-8?B?b1lrdGFLckNiWGNwU1VpSnY2U3hlRXA5cHR5RUlKVjMvL1hibXhIeU1OTk5Z?=
 =?utf-8?B?MTAzTW0zRjhHWnU5STE3OUJ4Skk1RFduZkFSMkh1dDMzeDVreFd6MnRoYkVw?=
 =?utf-8?B?SUtqUW5UckRFWnl5TTQwNGFVeDVVV2loYlAweFdyOFQ2ejh6VGFBdkNPcEk1?=
 =?utf-8?B?eFJlM05vVHVMNVJBVGppcnRESVJoQXRzSE1YQklNOTZsK0IrRzEydUxDU05K?=
 =?utf-8?B?NHZualdtVzJxZ1hPSlRXOHRRd0NhMTJBS1pyN011ZlIyMU9UYWsvVTI5YnB3?=
 =?utf-8?B?aUJ0U3poRHlFNlhGanFKMGtGVUhXTTE1eFZ6eXV0Ynh3U1BWZGFpcUJWeWl4?=
 =?utf-8?B?K01VcHdNWHZoUm9mOXFqMnc3SlZZVFNJL0gxZWpCeVJuNHpUSUNJdGZyMjd1?=
 =?utf-8?B?b3ZsVUpVYkw1NCsyRHcwUWZRVTRERUcwZ3U0VjVrUG1ZNjhiWnFack11cjNY?=
 =?utf-8?B?RWJOaUNic3JIdlM1Mk5EblE4UlNLQjB6ZWRjQkE2d0hBWEtLKzVYbU9sODRB?=
 =?utf-8?B?dEFFZHFCbXU0V3ozUzQrUThWZzdid0dwbGJ6eUVXUzVUeTdLbkhKVHBBTXQw?=
 =?utf-8?B?QzBZRDRtUWpHUVd3OHJzb3lLOHBRV0VmZ0plTUtZbGZGSnVrM1NLQTl0Rktl?=
 =?utf-8?B?OHA2MWJzRUhSNGEwWXhmaFZ1cGQyM2llaVlVbGtaYzZUZU83ZHdiM0xNV1hW?=
 =?utf-8?B?S1BlZnRtR2FybXVEUzVZWUtqMkZxU3BIa24wcnY4L1VocEpUVnVnSkEzZng5?=
 =?utf-8?B?akt4M1IxcG5GRWtra1ZGZnRLdVZxdWlMdE5lTy82WmJFRHMwRDVOQ2JoU3BJ?=
 =?utf-8?B?TmlNaG1nR3pxMW9iR3laeTdPMFB0L3pFelpGTGVoZVVHM1dwKzIxN0NWOWlZ?=
 =?utf-8?B?MGIxYUovazdGRG9sTHhnQmUxeVZPTkg3OStkeTd0SjhtdnlzcXFLeU10Rkcz?=
 =?utf-8?B?TTIzUjlpTjNHeUNyelZMMW95OUg1WU1EZFFYc3YweWkwS2FCWTJtenpsVW9x?=
 =?utf-8?B?RHNDdjR5bDdBMFFvOEZsQnI5cHdxZGVjQ1YvVGFSK2xaaTZmWEM3YnlhdFlp?=
 =?utf-8?B?UHc1bHF5YXE3SHc3Uy9aYm9pSm56ZHA5Mm11M1lnSlM1RUg3enV2WnFjMXFk?=
 =?utf-8?B?bTdIZmFnRUZ6VndLakNTNkNPTDFVRkpNS1NzOUFIU2ZtUjFEY3ZIWnpSRjdY?=
 =?utf-8?B?WmlvNFJQMGp2RnBpRklpWE5VWFlDMEZTcE9HNnNQUkN0NzBEQVpNeDl2U2tX?=
 =?utf-8?B?OGd6YnRyMnhUYnJoeGRwb1dWQmtQa0ZIQ0Uvc0tPRCtkNCt0bXdwamo1YnhG?=
 =?utf-8?B?cnNZRm81eFZxUmppU2NLQmhBQWpOWDF6ZVBaWnliZzE4ZGZFMXc0emRGMmhs?=
 =?utf-8?B?WXdUd0JNaHB1dFhJeUhFMWwzbWFkbUQwZmZxOHd1YlN3ZGxjTlIwN2twZjNx?=
 =?utf-8?B?QlE5bDhCQWdpZUoyUGoxcDAvZWNwcWJzNHU5MWFCU1oxQ0RoSk1iekt4Ym9q?=
 =?utf-8?B?YTRWNTRSaVZadnluUjE5SGozbWpKeW9oTG00clFINXNuNUxaYjl1Z1A1TU1K?=
 =?utf-8?B?RkEvcE1IWVY0TzNsdEtzWlg5Vyt6ZE51Y3UrSS91emNlSFN5M0x2bEFmTklU?=
 =?utf-8?B?WXVBbXpOcGxmMkZyVGpGVC9IZFRNZDZPUVhnczJxTXIrVDdiUDNGTlk5a1F5?=
 =?utf-8?B?SktucWhzU0taY0Q0dE1EUTFqTmVuL2xwb2FGVzQxMG9rck43M3o5QitwM3F6?=
 =?utf-8?B?ZjhMeVZRcHIvOHM2Ym5uUjdtamJoUnYyc09NdjJ5Q1dpZU55NDM2VEJmQWVh?=
 =?utf-8?B?aGxyM2oxV01DWUY2emxPdnhoQnp3S3pCaTFFRWVkVmhzcEJ0VHZldTZwQlZp?=
 =?utf-8?B?eGp0bGoyMVNFMENPbmpNSFUyUitzYlBvVnpLUGt4UnBaZU43eWhSK0JDTDZ0?=
 =?utf-8?B?QUJLb3BLaFpTdkpUb0NuejdNTWhjRnVob2VkeWJPVitiN3NMY01zeW9pRGJz?=
 =?utf-8?B?WUN1NForNS95eFpjUi9Kc1NJdGJYdnZtRVFvQi8rendNUFR1aUlXclFVMERD?=
 =?utf-8?B?VWhxUDJFVWFJVWlZUi9DckZNUm9OdXBNMG11NGZSRVR2THcvQW5ZbVhDM3g4?=
 =?utf-8?Q?G0tn+PYjQ92GpQtb2i9Tx8u6iyl7n/1w5eapmNHbtuzvC?=
X-MS-Exchange-AntiSpam-MessageData-1: Q4tgYssfHVzqVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cad9300-35c5-486b-691f-08da32a2e826
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 16:34:08.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2F4yGvQmbCCG7BkZYSiZB9z9VnqjN4AY8OY++5JMjFgfq7YinjK15LcMl7goF+dNduJq1g35JRriQEhPA026A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1227
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
Cc: "Mukul.Joshi@amd.com" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Peng Cheng <pengc@microsoft.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Lei Qu <Lei.Qu@microsoft.com>, Ran Shu <Ran.Shu@microsoft.com>,
 Ziyue Yang <Ziyue.Yang@microsoft.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------oXnjjJdqUicSDfw3qS4dNHZQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2022-05-10 07:03, Shuotao Xu wrote:
>
>
>> On Apr 28, 2022, at 12:04 AM, Andrey Grodzovsky 
>> <andrey.grodzovsky@amd.com> wrote:
>>
>> On 2022-04-27 05:20, Shuotao Xu wrote:
>>
>>> Hi Andrey,
>>>
>>> Sorry that I did not have time to work on this for a few days.
>>>
>>> I just tried the sysfs crash fix on Radeon VII and it seems that it 
>>> worked. It did not pass last the hotplug test, but my version has 4 
>>> tests instead of 3 in your case.
>>
>>
>> That because the 4th one is only enabled when here are 2 cards in the 
>> system - to test DRI_PRIME export. I tested this time with only one card.
>>
> Yes, I only had one Radeon VII in my system, so this 4th test should 
> have been skipped. I am ignoring this issue.
>
>>>
>>>
>>> Suite: Hotunplug Tests
>>>   Test: Unplug card and rescan the bus to plug it back 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Same as first test but with command submission 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Unplug with exported bo 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> passed
>>>   Test: Unplug with exported fence 
>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>> amdgpu_device_initialize: amdgpu_get_auth (1) failed (-1)
>>
>>
>> on the kernel side - the IOCTlL returning this is drm_getclient - 
>> maybe take a look while it can't find client it ? I didn't have such 
>> issue as far as I remember when testing.
>>
>>
>>> FAILED
>>>     1. ../tests/amdgpu/hotunplug_tests.c:368  - CU_ASSERT_EQUAL(r,0)
>>>     2. ../tests/amdgpu/hotunplug_tests.c:411  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2, shared_fd, 
>>> &sync_obj_handle2),0)
>>>     3. ../tests/amdgpu/hotunplug_tests.c:423  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2, &sync_obj_handle2, 
>>> 1, 100000000, 0, NULL),0)
>>>     4. ../tests/amdgpu/hotunplug_tests.c:425  - 
>>> CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2, sync_obj_handle2),0)
>>>
>>> Run Summary:    Type  Total    Ran Passed Failed Inactive
>>>               suites     14      1    n/a      0        0
>>>                tests     71      4      3      1        0
>>>              asserts     39     39     35      4      n/a
>>>
>>> Elapsed time =   17.321 seconds
>>>
>>> For kfd compute, there is some problem which I did not see in MI100 
>>> after I killed the hung application after hot plugout. I was using 
>>> rocm5.0.2 driver for MI100 card, and not sure if it is a regression 
>>> from the newer driver.
>>> After pkill, one of child of user process would be stuck in Zombie 
>>> mode (Z) understandably because of the bug, and future rocm 
>>> application after plug-back would in uninterrupted sleep mode (D) 
>>> because it would not return from syscall to kfd.
>>>
>>> Although drm test for amdgpu would run just fine without issues 
>>> after plug-back with dangling kfd state.
>>
>>
>> I am not clear when the crash bellow happens ? Is it related to what 
>> you describe above ?
>>
>>
>>>
>>> I don’t know if there is a quick fix to it. I was thinking add 
>>> drm_enter/drm_exit to amdgpu_device_rreg.
>>
>>
>> Try adding drm_dev_enter/exit pair at the highest level of attmetong 
>> to access HW - in this case it's amdgpu_amdkfd_set_compute_idle. We 
>> always try to avoid accessing any HW functions after backing device 
>> is gone.
>>
>>
>>> Also this has been a long time in my attempt to fix hotplug issue 
>>> for kfd application.
>>> I don’t know 1) if I would be able to get to MI100 (fixing Radeon 
>>> VII would mean something but MI100 is more important for us); 2) 
>>> what the direct of the patch to this issue will move forward.
>>
>>
>> I will go to office tomorrow to pick up MI-100, With time and 
>> priorities permitting I will then then try to test it and fix any 
>> bugs such that it will be passing all hot plug libdrm tests at the 
>> tip of public amd-staging-drm-next 
>> -https://gitlab.freedesktop.org/agd5f/linux, after that you can try 
>> to continue working with ROCm enabling on top of that.
>>
>> For now i suggest you move on with Radeon 7 which as your development 
>> ASIC and use the fix i mentioned above.
>>
> I finally got some time to continue on kfd hotplug patch attempt.
> The following patch seems to work for kfd hotplug on Radeon VII. After 
> hot plugout, the tf process exists because of vm fault.
> A new tf process run without issues after plugback.
>
> It has the following fixes.
>
>  1. ras sysfs regression;
>  2. skip setting compute idle after dev is plugged, otherwise it will
>     try to write the pci bar thus driver fault
>

1+ 2 look good to me.


>  1. stops the actual work of invalidate memory map triggered by
>     useptrs; (return false will trigger warning, so I returned true.
>     Not sure if it is correct)
>

For this you need an ack from Compute team (e.g. Felix) - For me it 
looks ok as you have to stop generating new restore user PTR works at 
some point - but maybe we can let them all to run their course and just 
restrict HW access
more at the lower level.


>  1. It sends exceptions to all the events/signal that a “zombie”
>     process that are waiting for. (Not sure if the hw_exception is
>     worthwhile, it did not do anything in my case since there is such
>     event type associated with that process)
>

About this one i am in doubt as i told you our policy for Graphics was 
to not force kill any user side clients who monitor those processes and 
just let them live until their natural death. Is it different for KFD ? 
Does it create a specific issue if you don't generate the signals ?

Andrey


> Please take a look and let me know if it acceptable.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 1f8161cd507f..2f7858692067 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -33,6 +33,7 @@
>  #include <uapi/linux/kfd_ioctl.h>
>  #include "amdgpu_ras.h"
>  #include "amdgpu_umc.h"
> +#include <drm/drm_drv.h>
>
>  /* Total memory size in system memory and all GPU VRAM. Used to
>   * estimate worst case amount of memory to reserve for page tables
> @@ -681,9 +682,10 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device 
> *adev,
>
>  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool 
> idle)
>  {
> -       amdgpu_dpm_switch_power_profile(adev,
> - PP_SMC_POWER_PROFILE_COMPUTE,
> -                                       !idle);
> +       if (!drm_dev_is_unplugged(adev_to_drm(adev)))
> +               amdgpu_dpm_switch_power_profile(adev,
> + PP_SMC_POWER_PROFILE_COMPUTE,
> +                                               !idle);
>  }
>
>  bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index 4b153daf283d..fb4c9e55eace 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -46,6 +46,7 @@
>  #include <linux/firmware.h>
>  #include <linux/module.h>
>  #include <drm/drm.h>
> +#include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> @@ -104,6 +105,9 @@ static bool amdgpu_mn_invalidate_hsa(struct 
> mmu_interval_notifier *mni,
>         struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, 
> notifier);
>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>
> +       if (drm_dev_is_unplugged(adev_to_drm(adev)))
> +               return true;
> +
>         if (!mmu_notifier_range_blockable(range))
>                 return false;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index cac56f830aed..fbbaaabf3a67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1509,7 +1509,6 @@ static int amdgpu_ras_fs_fini(struct 
> amdgpu_device *adev)
>                 }
>         }
>
> -       amdgpu_ras_sysfs_remove_all(adev);
>         return 0;
>  }
>  /* ras fs end */
> @@ -2557,8 +2556,6 @@ void amdgpu_ras_block_late_fini(struct 
> amdgpu_device *adev,
>         if (!ras_block)
>                 return;
>
> -       amdgpu_ras_sysfs_remove(adev, ras_block);
> -
>         ras_obj = container_of(ras_block, struct 
> amdgpu_ras_block_object, ras_comm);
>         if (ras_obj->ras_cb)
>                 amdgpu_ras_interrupt_remove_handler(adev, ras_block);
> @@ -2659,6 +2656,7 @@ int amdgpu_ras_pre_fini(struct amdgpu_device *adev)
>         /* Need disable ras on all IPs here before ip [hw/sw]fini */
>         amdgpu_ras_disable_all_features(adev, 0);
>         amdgpu_ras_recovery_fini(adev);
> +       amdgpu_ras_sysfs_remove_all(adev);
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index f1a225a20719..4b789bec9670 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -714,16 +714,37 @@ bool kfd_is_locked(void)
>
>  void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
>  {
> +       struct kfd_process *p;
> +       struct amdkfd_process_info *p_info;
> +       unsigned int temp;
> +
>         if (!kfd->init_complete)
>                 return;
>
>         /* for runtime suspend, skip locking kfd */
> -       if (!run_pm) {
> +       if (!run_pm && !drm_dev_is_unplugged(kfd->ddev)) {
>                 /* For first KFD device suspend all the KFD processes */
>                 if (atomic_inc_return(&kfd_locked) == 1)
>                         kfd_suspend_all_processes();
>         }
>
> +       if (drm_dev_is_unplugged(kfd->ddev)){
> +               int idx = srcu_read_lock(&kfd_processes_srcu);
> +               pr_debug("cancel restore_userptr_work\n");
> +               hash_for_each_rcu(kfd_processes_table, temp, p, 
> kfd_processes) {
> +                       if (kfd_process_gpuidx_from_gpuid(p, kfd->id) 
> >= 0) {
> +                               p_info = p->kgd_process_info;
> +                               pr_debug("cancel processes, pid = %d 
> for gpu_id = %d", pid_nr(p_info->pid), kfd->id);
> + cancel_delayed_work_sync(&p_info->restore_userptr_work);
> +
> +                               /* send exception signals to the kfd 
> events waiting in user space */
> + kfd_signal_hw_exception_event(p->pasid);
> + kfd_signal_vm_fault_event(kfd, p->pasid, NULL);
> +                       }
> +               }
> +               srcu_read_unlock(&kfd_processes_srcu, idx);
> +       }
> +
>         kfd->dqm->ops.stop(kfd->dqm);
>         kfd_iommu_suspend(kfd);
>  }
>
> Regards,
> Shuotao
>>
>> Andrey
>>
>>
>>>
>>> Regards,
>>> Shuotao
>>>
>>> [  +0.001645] BUG: unable to handle page fault for address: 
>>> 0000000000058a68
>>> [  +0.001298] #PF: supervisor read access in kernel mode
>>> [  +0.001252] #PF: error_code(0x0000) - not-present page
>>> [  +0.001248] PGD 8000000115806067 P4D 8000000115806067 PUD 
>>> 109b2d067 PMD 0
>>> [  +0.001270] Oops: 0000 [#1] PREEMPT SMP PTI
>>> [  +0.001256] CPU: 5 PID: 13818 Comm: tf_cnn_benchmar Tainted: G     
>>>    W   E     5.16.0+ #3
>>> [  +0.001290] Hardware name: Dell Inc. PowerEdge R730/0H21J3, BIOS 
>>> 1.5.4 [FPGA Test BIOS] 10/002/2015
>>> [  +0.001309] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>> [  +0.001562] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 
>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 
>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 
>>> 2e ca 85
>>> [  +0.002751] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>> [  +0.001388] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
>>> 00000000ffffffff
>>> [  +0.001402] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
>>> ffff8b0c9c840000
>>> [  +0.001418] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
>>> 0000000000000001
>>> [  +0.001421] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
>>> 0000000000058a68
>>> [  +0.001400] R13: 000000000001629a R14: 0000000000000000 R15: 
>>> 000000000001629a
>>> [  +0.001397] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.001411] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.001405] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
>>> 00000000001706e0
>>> [  +0.001422] Call Trace:
>>> [  +0.001407]  <TASK>
>>> [  +0.001391]  amdgpu_device_rreg+0x17/0x20 [amdgpu]
>>> [  +0.001614]  amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
>>> [  +0.001735]  phm_wait_for_register_unequal.part.1+0x58/0x90 [amdgpu]
>>> [  +0.001790]  phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]
>>> [  +0.001800]  vega20_wait_for_response+0x28/0x80 [amdgpu]
>>> [  +0.001757]  vega20_send_msg_to_smc_with_parameter+0x21/0x110 [amdgpu]
>>> [  +0.001838]  smum_send_msg_to_smc_with_parameter+0xcd/0x100 [amdgpu]
>>> [  +0.001829]  ? kvfree+0x1e/0x30
>>> [  +0.001462]  vega20_set_power_profile_mode+0x58/0x330 [amdgpu]
>>> [  +0.001868]  ? kvfree+0x1e/0x30
>>> [  +0.001462]  ? ttm_bo_release+0x261/0x370 [ttm]
>>> [  +0.001467]  pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]
>>> [  +0.001863]  amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]
>>> [  +0.001866]  amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]
>>> [  +0.001784]  kfd_dec_compute_active+0x2c/0x50 [amdgpu]
>>> [  +0.001744]  process_termination_cpsch+0x2f9/0x3a0 [amdgpu]
>>> [  +0.001728]  kfd_process_dequeue_from_all_devices+0x49/0x70 [amdgpu]
>>> [  +0.001730]  kfd_process_notifier_release+0x91/0xe0 [amdgpu]
>>> [  +0.001718]  __mmu_notifier_release+0x77/0x1f0
>>> [  +0.001411]  exit_mmap+0x1b5/0x200
>>> [  +0.001396]  ? __switch_to+0x12d/0x3e0
>>> [  +0.001388]  ? __switch_to_asm+0x36/0x70
>>> [  +0.001372]  ? preempt_count_add+0x74/0xc0
>>> [  +0.001364]  mmput+0x57/0x110
>>> [  +0.001349]  do_exit+0x33d/0xc20
>>> [  +0.001337]  ? _raw_spin_unlock+0x1a/0x30
>>> [  +0.001346]  do_group_exit+0x43/0xa0
>>> [  +0.001341]  get_signal+0x131/0x920
>>> [  +0.001295]  arch_do_signal_or_restart+0xb1/0x870
>>> [  +0.001303]  ? do_futex+0x125/0x190
>>> [  +0.001285]  exit_to_user_mode_prepare+0xb1/0x1c0
>>> [  +0.001282]  syscall_exit_to_user_mode+0x2a/0x40
>>> [  +0.001264]  do_syscall_64+0x46/0xb0
>>> [  +0.001236]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>> [  +0.001219] RIP: 0033:0x7f6aff1d2ad3
>>> [  +0.001177] Code: Unable to access opcode bytes at RIP 0x7f6aff1d2aa9.
>>> [  +0.001166] RSP: 002b:00007f6ab2029d20 EFLAGS: 00000246 ORIG_RAX: 
>>> 00000000000000ca
>>> [  +0.001170] RAX: fffffffffffffe00 RBX: 0000000004f542b0 RCX: 
>>> 00007f6aff1d2ad3
>>> [  +0.001168] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 
>>> 0000000004f542d8
>>> [  +0.001162] RBP: 0000000004f542d4 R08: 0000000000000000 R09: 
>>> 0000000000000000
>>> [  +0.001152] R10: 0000000000000000 R11: 0000000000000246 R12: 
>>> 0000000004f542d8
>>> [  +0.001176] R13: 0000000000000000 R14: 0000000004f54288 R15: 
>>> 0000000000000000
>>> [  +0.001152]  </TASK>
>>> [  +0.001113] Modules linked in: veth amdgpu(E) nf_conntrack_netlink 
>>> nfnetlink xfrm_user xt_addrtype br_netfilter xt_CHECKSUM 
>>> iptable_mangle xt_MASQUERADE iptable_nat nf_nat xt_conntrack 
>>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT nf_reject_ipv4 
>>> xt_tcpudp bridge stp llc ebtable_filter ebtables ip6table_filter 
>>> ip6_tables iptable_filter overlay esp6_offload esp6 esp4_offload 
>>> esp4 xfrm_algo intel_rapl_msr intel_rapl_common sb_edac 
>>> x86_pkg_temp_thermal intel_powerclamp snd_hda_codec_hdmi 
>>> snd_hda_intel ipmi_ssif snd_intel_dspcfg coretemp snd_hda_codec 
>>> kvm_intel snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm soundcore 
>>> irqbypass ftdi_sio usbserial input_leds iTCO_wdt iTCO_vendor_support 
>>> joydev mei_me rapl lpc_ich intel_cstate mei ipmi_si ipmi_devintf 
>>> ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel ib_iser 
>>> rdma_cm iw_cm ib_cm ib_core iscsi_tcp libiscsi_tcp libiscsi 
>>> scsi_transport_iscsi ip_tables x_tables autofs4 btrfs 
>>> blake2b_generic zstd_compress raid10 raid456
>>> [  +0.000102]  async_raid6_recov async_memcpy async_pq async_xor 
>>> async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear 
>>> iommu_v2 gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper 
>>> drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops 
>>> crct10dif_pclmul hid_generic crc32_pclmul ghash_clmulni_intel usbhid 
>>> uas aesni_intel crypto_simd igb ahci hid drm usb_storage cryptd 
>>> libahci dca megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]
>>> [  +0.016626] CR2: 0000000000058a68
>>> [  +0.001550] ---[ end trace ff90849fe0a8b3b4 ]---
>>> [  +0.024953] RIP: 0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]
>>> [  +0.001814] Code: e8 8c 7d 02 00 65 ff 0d 65 e0 7f 3f 75 ae 0f 1f 
>>> 44 00 00 eb a7 83 e2 02 75 09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 
>>> 09 00 00 <45> 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89 f7 e8 a2 4c 
>>> 2e ca 85
>>> [  +0.003255] RSP: 0018:ffffb58fac313928 EFLAGS: 00010202
>>> [  +0.001641] RAX: ffffffffc09a4270 RBX: ffff8b0c9c840000 RCX: 
>>> 00000000ffffffff
>>> [  +0.001656] RDX: 0000000000000000 RSI: 000000000001629a RDI: 
>>> ffff8b0c9c840000
>>> [  +0.001681] RBP: ffffb58fac313948 R08: 0000000000000021 R09: 
>>> 0000000000000001
>>> [  +0.001662] R10: ffffb58fac313b30 R11: ffffffff8c065b00 R12: 
>>> 0000000000058a68
>>> [  +0.001650] R13: 000000000001629a R14: 0000000000000000 R15: 
>>> 000000000001629a
>>> [  +0.001648] FS:  0000000000000000(0000) GS:ffff8b4b7fa80000(0000) 
>>> knlGS:0000000000000000
>>> [  +0.001668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.001673] CR2: 0000000000058a68 CR3: 000000010a2c8001 CR4: 
>>> 00000000001706e0
>>> [  +0.001740] Fixing recursive fault but reboot is needed!
>>>
>>>
>>>> On Apr 21, 2022, at 2:41 AM, Andrey Grodzovsky 
>>>> <andrey.grodzovsky@amd.com> wrote:
>>>>
>>>> I retested hot plug tests at the commit I mentioned bellow - looks 
>>>> ok, my ASIC is Navi 10, I also tested using Vega 10 and older 
>>>> Polaris ASICs (whatever i had at home at the time). It's possible 
>>>> there are extra issues in ASICs like ur which I didn't cover during 
>>>> tests.
>>>>
>>>> andrey@andrey-test:~/drm$ sudo ./build/tests/amdgpu/amdgpu_test -s 13
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support UVD, suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support VCE, suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> The ASIC NOT support UVD ENC, suite disabled.
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>>
>>>>
>>>> Don't support TMZ (trust memory zone), security suite disabled
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> /usr/local/share/libdrm/amdgpu.ids: No such file or directory
>>>> Peer device is not opened or has ASIC not supported by the suite, 
>>>> skip all Peer to Peer tests.
>>>>
>>>>
>>>>      CUnit - A unit testing framework for C - Version 2.1-3
>>>> http://cunit.sourceforge.net/
>>>>
>>>>
>>>> *Suite: Hotunplug Tests**
>>>> **  Test: Unplug card and rescan the bus to plug it back 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed**
>>>> **  Test: Same as first test but with command submission 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed**
>>>> **  Test: Unplug with exported bo 
>>>> .../usr/local/share/libdrm/amdgpu.ids: No such file or directory**
>>>> **passed*
>>>>
>>>> Run Summary:    Type  Total    Ran Passed Failed Inactive
>>>>               suites     14      1    n/a 0        0
>>>>                tests     71      3      3 0        1
>>>>              asserts     21     21     21 0      n/a
>>>>
>>>> Elapsed time =    9.195 seconds
>>>>
>>>>
>>>> Andrey
>>>>
>>>> On 2022-04-20 11:44, Andrey Grodzovsky wrote:
>>>>>
>>>>> The only one in Radeon 7 I see is the same sysfs crash we already 
>>>>> fixed so you can use the same fix. The MI 200 issue i haven't seen 
>>>>> yet but I also haven't tested MI200 so never saw it before. Need 
>>>>> to test when i get the time.
>>>>>
>>>>> So try that fix with Radeon 7 again to see if you pass the tests 
>>>>> (the warnings should all be minor issues).
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>> On 2022-04-20 05:24, Shuotao Xu wrote:
>>>>>>>
>>>>>>> That a problem, latest working baseline I tested and confirmed 
>>>>>>> passing hotplug tests is this branch and 
>>>>>>> commithttps://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6which 
>>>>>>> is amd-staging-drm-next. 5.14 was the branch we ups-reamed the 
>>>>>>> hotplug code but it had a lot of regressions over time due to 
>>>>>>> new changes (that why I added the hotplug test to try and catch 
>>>>>>> them early). It would be best to run this branch on mi-100 so we 
>>>>>>> have a clean baseline and only after confirming  this particular 
>>>>>>> branch from this commits passes libdrm tests only then start 
>>>>>>> adding the KFD specific addons. Another option if you can't work 
>>>>>>> with MI-100 and this branch is to try a different ASIC that does 
>>>>>>> work with this branch (if possible).
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>> OK I tried both this commit and the HEAD of and-staging-drm-next 
>>>>>> on two GPUs( MI100 and Radeon VII) both did not pass hotplugout 
>>>>>> libdrm test. I might be able to gain access to MI200, but I 
>>>>>> suspect it would work.
>>>>>>
>>>>>> I copied the complete dmesgs as follows. I highlighted the OOPSES 
>>>>>> for you.
>>>>>>
>>>>>> Radeon VII:
>
--------------oXnjjJdqUicSDfw3qS4dNHZQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2022-05-10 07:03, Shuotao Xu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com">
      
      <br class="">
      <div><br class="">
        <blockquote type="cite" class="">
          <div class="">On Apr 28, 2022, at 12:04 AM, Andrey Grodzovsky
            &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
            wrote:</div>
          <br class="Apple-interchange-newline">
          <div class="">
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              On 2022-04-27 05:20, Shuotao Xu wrote:<br class="">
            </p>
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              Hi Andrey,
              <div class=""><br class="">
              </div>
              <div class="">Sorry that I did not have time to work on
                this for a few days.</div>
              <div class=""><br class="">
              </div>
              <div class="">I just tried the sysfs crash fix on Radeon
                VII and it seems that it worked. It did not pass last
                the hotplug test, but my version has 4 tests instead of
                3 in your case.</div>
            </blockquote>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              That because the 4th one is only enabled when here are 2
              cards in the system - to test DRI_PRIME export. I tested
              this time with only one card.<br class="">
            </p>
          </div>
        </blockquote>
        <div>Yes, I only had one Radeon VII in my system, so this 4th
          test should have been skipped. I am ignoring this issue.</div>
        <br class="">
        <blockquote type="cite" class="">
          <div class="">
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              <div class="">
                <div class=""><br class="">
                </div>
                <div class=""><br class="">
                </div>
                <div class="">Suite: Hotunplug Tests</div>
                <div class="">&nbsp; Test: Unplug card and rescan the bus to
                  plug it back .../usr/local/share/libdrm/amdgpu.ids: No
                  such file or directory</div>
                <div class="">passed</div>
                <div class="">&nbsp; Test: Same as first test but with
                  command submission
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory</div>
                <div class="">passed</div>
                <div class="">&nbsp; Test: Unplug with exported bo
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory</div>
                <div class="">passed</div>
                <div class="">&nbsp; Test: Unplug with exported fence
                  .../usr/local/share/libdrm/amdgpu.ids: No such file or
                  directory</div>
                <div class="">amdgpu_device_initialize: amdgpu_get_auth
                  (1) failed (-1)</div>
              </div>
            </blockquote>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
              on the kernel side - the IOCTlL returning this is
              drm_getclient - maybe take a look while it can't find
              client it ? I didn't have such issue as far as I remember
              when testing.<span class="Apple-converted-space">&nbsp;</span></p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              <div class="">
                <div class="">FAILED</div>
                <div class="">&nbsp; &nbsp; 1.
                  ../tests/amdgpu/hotunplug_tests.c:368 &nbsp;-
                  CU_ASSERT_EQUAL(r,0)</div>
                <div class="">&nbsp; &nbsp; 2.
                  ../tests/amdgpu/hotunplug_tests.c:411 &nbsp;-
                  CU_ASSERT_EQUAL(amdgpu_cs_import_syncobj(device2,
                  shared_fd, &amp;sync_obj_handle2),0)</div>
                <div class="">&nbsp; &nbsp; 3.
                  ../tests/amdgpu/hotunplug_tests.c:423 &nbsp;-
                  CU_ASSERT_EQUAL(amdgpu_cs_syncobj_wait(device2,
                  &amp;sync_obj_handle2, 1, 100000000, 0, NULL),0)</div>
                <div class="">&nbsp; &nbsp; 4.
                  ../tests/amdgpu/hotunplug_tests.c:425 &nbsp;-
                  CU_ASSERT_EQUAL(amdgpu_cs_destroy_syncobj(device2,
                  sync_obj_handle2),0)</div>
                <div class=""><br class="">
                </div>
                <div class="">Run Summary: &nbsp; &nbsp;Type &nbsp;Total &nbsp; &nbsp;Ran Passed
                  Failed Inactive</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; suites &nbsp; &nbsp; 14 &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp;n/a
                  &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;0</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tests &nbsp; &nbsp; 71 &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp;3
                  &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;0</div>
                <div class="">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;asserts &nbsp; &nbsp; 39 &nbsp; &nbsp; 39 &nbsp; &nbsp; 35
                  &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp;n/a</div>
                <div class=""><br class="">
                </div>
                <div class="">Elapsed time = &nbsp; 17.321 seconds</div>
              </div>
              <div class=""><br class="">
              </div>
              <div class="">For kfd compute, there is some problem which
                I did not see in MI100 after I killed the hung
                application after hot plugout. I was using rocm5.0.2
                driver for MI100 card, and not sure if it is a
                regression from the newer driver.</div>
              <div class="">After pkill, one of child of user process
                would be stuck in Zombie mode (Z) understandably because
                of the bug, and future rocm application after plug-back
                would in uninterrupted sleep mode (D) because it would
                not return from syscall to kfd.</div>
              <div class=""><br class="">
              </div>
              <div class="">Although drm test for amdgpu would run just
                fine without issues after plug-back with dangling kfd
                state.<span class="Apple-converted-space">&nbsp;</span><br class="">
              </div>
            </blockquote>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              I am not clear when the crash bellow happens ? Is it
              related to what you describe above ?</p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              <div class=""><br class="">
              </div>
              <div class="">I don’t know if there is a quick fix to it.
                I was thinking add drm_enter/drm_exit to
                amdgpu_device_rreg.</div>
            </blockquote>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              Try adding drm_dev_enter/exit pair at the highest level of
              attmetong to access HW - in this case it's
              amdgpu_amdkfd_set_compute_idle. We always try to avoid
              accessing any HW functions after backing device is gone.</p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              <div class="">Also this has been a long time in my attempt
                to fix hotplug issue for kfd application.&nbsp;</div>
              <div class="">I don’t know 1) if I would be able to get to
                MI100 (fixing Radeon VII would mean something but MI100
                is more important for us); 2) what the direct of the
                patch to this issue will move forward.</div>
            </blockquote>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              I will go to office tomorrow to pick up MI-100, With time
              and priorities permitting I will then then try to test it
              and fix any bugs such that it will be passing all hot plug
              libdrm tests at the tip of public amd-staging-drm-next -<span class="Apple-converted-space">&nbsp;</span><a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C9ab31a8629f34094adab08da3274c20b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877774330844118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=l%2BVlO2pGT%2B17sfSCft%2FImv1spQUusjvM%2F%2FxkcmNHmXA%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux" shash="p0UtLXjJdQWbTZv+V5wp3PThfAAfXGXiJUfo2wokIX2I5MP1WTEu6SGfRAhQ/wtIKxNt41HfoN5XbKAI15FYxj0OgBR2mcttYL9hSoFyhQSSBq2fgmOwM0xEHvWCysRwSy/PR0qlVLbZ43gmerIIt6dDS+rxRCAiqE4IYTCi55Y=" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux</a>,
              after that you can try to continue working with ROCm
              enabling on top of that.<span class="Apple-converted-space">&nbsp;</span><br class="">
            </p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              For now i suggest you move on with Radeon 7 which as your
              development ASIC and use the fix i mentioned above.<br class="">
            </p>
          </div>
        </blockquote>
        <div>I finally got some time to continue on kfd hotplug patch
          attempt.</div>
        The following patch seems to work for kfd hotplug on Radeon VII.
        After hot plugout, the tf process exists because of vm fault.</div>
      <div>A new tf process run without issues after plugback.</div>
      <div><br class="">
      </div>
      <div>It has the following fixes.</div>
      <div>
        <ol class="">
          <li class="">ras sysfs regression;</li>
          <li class="">skip setting compute idle after dev is plugged,
            otherwise it will try to write the pci bar thus driver fault</li>
        </ol>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>1+ 2 look good to me. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com">
      <div>
        <ol class="">
          <li class="">stops the actual work of invalidate memory map
            triggered by useptrs; (return false will trigger warning, so
            I returned true. Not sure if it is correct)</li>
        </ol>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>For this you need an ack from Compute team (e.g. Felix) - For me
      it looks ok as you have to stop generating new restore user PTR
      works at some point - but maybe we can let them all to run their
      course and just restrict HW access<br>
      more at the lower level. <br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com">
      <div>
        <ol class="">
          <li class="">It sends exceptions to all the events/signal that
            a “zombie” process that are waiting for. (Not sure if the
            hw_exception is worthwhile, it did not do anything in my
            case since there is such event type associated with that
            process)</li>
        </ol>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>About this one i am in doubt as i told you our policy for
      Graphics was to not force kill any user side clients who monitor
      those processes and just let them live until their natural death.
      Is it different for KFD ? Does it create a specific issue if you
      don't generate the signals ?</p>
    <p>Andrey</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:E4C3FDDE-9948-489E-816B-D2777C07BD2E@microsoft.com">
      <div>
      </div>
      <div>Please take a look and let me know if it acceptable.</div>
      <div><br class="">
      </div>
      <div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
        <div>index 1f8161cd507f..2f7858692067 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c</div>
        <div>@@ -33,6 +33,7 @@</div>
        <div>&nbsp;#include &lt;uapi/linux/kfd_ioctl.h&gt;</div>
        <div>&nbsp;#include &quot;amdgpu_ras.h&quot;</div>
        <div>&nbsp;#include &quot;amdgpu_umc.h&quot;</div>
        <div>+#include &lt;drm/drm_drv.h&gt;</div>
        <div><br class="">
        </div>
        <div>&nbsp;/* Total memory size in system memory and all GPU VRAM.
          Used to</div>
        <div>&nbsp; * estimate worst case amount of memory to reserve for
          page tables</div>
        <div>@@ -681,9 +682,10 @@ int amdgpu_amdkfd_submit_ib(struct
          amdgpu_device *adev,</div>
        <div><br class="">
        </div>
        <div>&nbsp;void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device
          *adev, bool idle)</div>
        <div>&nbsp;{</div>
        <div>- &nbsp; &nbsp; &nbsp; amdgpu_dpm_switch_power_profile(adev,</div>
        <div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          PP_SMC_POWER_PROFILE_COMPUTE,</div>
        <div>- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; !idle);</div>
        <div>+ &nbsp; &nbsp; &nbsp; if (!drm_dev_is_unplugged(adev_to_drm(adev)))</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_dpm_switch_power_profile(adev,</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          PP_SMC_POWER_PROFILE_COMPUTE,</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; !idle);</div>
        <div>&nbsp;}</div>
        <div><br class="">
        </div>
        <div>&nbsp;bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev,
          u32 vmid)</div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c</div>
        <div>index 4b153daf283d..fb4c9e55eace 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c</div>
        <div>@@ -46,6 +46,7 @@</div>
        <div>&nbsp;#include &lt;linux/firmware.h&gt;</div>
        <div>&nbsp;#include &lt;linux/module.h&gt;</div>
        <div>&nbsp;#include &lt;drm/drm.h&gt;</div>
        <div>+#include &lt;drm/drm_drv.h&gt;</div>
        <div><br class="">
        </div>
        <div>&nbsp;#include &quot;amdgpu.h&quot;</div>
        <div>&nbsp;#include &quot;amdgpu_amdkfd.h&quot;</div>
        <div>@@ -104,6 +105,9 @@ static bool
          amdgpu_mn_invalidate_hsa(struct mmu_interval_notifier *mni,</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_bo *bo = container_of(mni, struct
          amdgpu_bo, notifier);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_device *adev =
          amdgpu_ttm_adev(bo-&gt;tbo.bdev);</div>
        <div><br class="">
        </div>
        <div>+ &nbsp; &nbsp; &nbsp; if (drm_dev_is_unplugged(adev_to_drm(adev)))</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return true;</div>
        <div>+</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; if (!mmu_notifier_range_blockable(range))</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return false;</div>
        <div><br class="">
        </div>
        <div>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>index cac56f830aed..fbbaaabf3a67 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</div>
        <div>@@ -1509,7 +1509,6 @@ static int amdgpu_ras_fs_fini(struct
          amdgpu_device *adev)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
        <div><br class="">
        </div>
        <div>- &nbsp; &nbsp; &nbsp; amdgpu_ras_sysfs_remove_all(adev);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
        <div>&nbsp;}</div>
        <div>&nbsp;/* ras fs end */</div>
        <div>@@ -2557,8 +2556,6 @@ void
          amdgpu_ras_block_late_fini(struct amdgpu_device *adev,</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; if (!ras_block)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
        <div><br class="">
        </div>
        <div>- &nbsp; &nbsp; &nbsp; amdgpu_ras_sysfs_remove(adev, ras_block);</div>
        <div>-</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; ras_obj = container_of(ras_block, struct
          amdgpu_ras_block_object, ras_comm);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; if (ras_obj-&gt;ras_cb)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ras_interrupt_remove_handler(adev,
          ras_block);</div>
        <div>@@ -2659,6 +2656,7 @@ int amdgpu_ras_pre_fini(struct
          amdgpu_device *adev)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; /* Need disable ras on all IPs here before ip
          [hw/sw]fini */</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ras_disable_all_features(adev, 0);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; amdgpu_ras_recovery_fini(adev);</div>
        <div>+ &nbsp; &nbsp; &nbsp; amdgpu_ras_sysfs_remove_all(adev);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
        <div>&nbsp;}</div>
        <div><br class="">
        </div>
        <div>diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
          b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>index f1a225a20719..4b789bec9670 100644</div>
        <div>--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
        <div>@@ -714,16 +714,37 @@ bool kfd_is_locked(void)</div>
        <div><br class="">
        </div>
        <div>&nbsp;void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)</div>
        <div>&nbsp;{</div>
        <div>+ &nbsp; &nbsp; &nbsp; struct kfd_process *p;</div>
        <div>+ &nbsp; &nbsp; &nbsp; struct amdkfd_process_info *p_info;</div>
        <div>+ &nbsp; &nbsp; &nbsp; unsigned int temp;</div>
        <div>+</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; if (!kfd-&gt;init_complete)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
        <div><br class="">
        </div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; /* for runtime suspend, skip locking kfd */</div>
        <div>- &nbsp; &nbsp; &nbsp; if (!run_pm) {</div>
        <div>+ &nbsp; &nbsp; &nbsp; if (!run_pm &amp;&amp;
          !drm_dev_is_unplugged(kfd-&gt;ddev)) {</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* For first KFD device suspend all the KFD
          processes */</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (atomic_inc_return(&amp;kfd_locked) ==
          1)</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_suspend_all_processes();</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; }</div>
        <div><br class="">
        </div>
        <div>+ &nbsp; &nbsp; &nbsp; if (drm_dev_is_unplugged(kfd-&gt;ddev)){</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int idx =
          srcu_read_lock(&amp;kfd_processes_srcu);</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr_debug(&quot;cancel restore_userptr_work\n&quot;);</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; hash_for_each_rcu(kfd_processes_table,
          temp, p, kfd_processes) {</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if
          (kfd_process_gpuidx_from_gpuid(p, kfd-&gt;id) &gt;= 0) {</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; p_info =
          p-&gt;kgd_process_info;</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; pr_debug(&quot;cancel processes,
          pid = %d for gpu_id = %d&quot;, pid_nr(p_info-&gt;pid),
          kfd-&gt;id);</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          cancel_delayed_work_sync(&amp;p_info-&gt;restore_userptr_work);</div>
        <div>+</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /* send exception signals
          to the kfd events waiting in user space */</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          kfd_signal_hw_exception_event(p-&gt;pasid);</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
          kfd_signal_vm_fault_event(kfd, p-&gt;pasid, NULL);</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }</div>
        <div>+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; srcu_read_unlock(&amp;kfd_processes_srcu,
          idx);</div>
        <div>+ &nbsp; &nbsp; &nbsp; }</div>
        <div>+</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; kfd-&gt;dqm-&gt;ops.stop(kfd-&gt;dqm);</div>
        <div>&nbsp; &nbsp; &nbsp; &nbsp; kfd_iommu_suspend(kfd);</div>
        <div>&nbsp;}</div>
        <div><br class="">
        </div>
        <div>Regards,</div>
        <div>Shuotao</div>
      </div>
      <div>
        <blockquote type="cite" class="">
          <div class="">
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              Andrey</p>
            <p style="caret-color: rgb(0, 0, 0); font-family: Helvetica;
              font-size: 12px; font-style: normal; font-variant-caps:
              normal; font-weight: 400; letter-spacing: normal;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; word-spacing: 0px;
              -webkit-text-stroke-width: 0px; text-decoration: none;" class="">
              <br class="">
            </p>
            <blockquote type="cite" cite="mid:FF40C1DB-326C-45F5-9B59-14C39E17359D@microsoft.com" style="font-family: Helvetica; font-size: 12px;
              font-style: normal; font-variant-caps: normal;
              font-weight: 400; letter-spacing: normal; orphans: auto;
              text-align: start; text-indent: 0px; text-transform: none;
              white-space: normal; widows: auto; word-spacing: 0px;
              -webkit-text-size-adjust: auto; -webkit-text-stroke-width:
              0px; text-decoration: none;" class="">
              <div class=""><br class="">
              </div>
              <div class="">Regards,</div>
              <div class="">Shuotao</div>
              <div class=""><br class="">
              </div>
              <div class="">
                <div class="">[ &nbsp;+0.001645] BUG: unable to handle page
                  fault for address: 0000000000058a68</div>
                <div class="">[ &nbsp;+0.001298] #PF: supervisor read access
                  in kernel mode</div>
                <div class="">[ &nbsp;+0.001252] #PF: error_code(0x0000) -
                  not-present page</div>
                <div class="">[ &nbsp;+0.001248] PGD 8000000115806067 P4D
                  8000000115806067 PUD 109b2d067 PMD 0</div>
                <div class="">[ &nbsp;+0.001270] Oops: 0000 [#1] PREEMPT SMP
                  PTI</div>
                <div class="">[ &nbsp;+0.001256] CPU: 5 PID: 13818 Comm:
                  tf_cnn_benchmar Tainted: G &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp; E &nbsp; &nbsp; 5.16.0+ #3</div>
                <div class="">[ &nbsp;+0.001290] Hardware name: Dell Inc.
                  PowerEdge R730/0H21J3, BIOS 1.5.4 [FPGA Test BIOS]
                  10/002/2015</div>
                <div class="">[ &nbsp;+0.001309] RIP:
                  0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001562] Code: e8 8c 7d 02 00 65 ff
                  0d 65 e0 7f 3f 75 ae 0f 1f 44 00 00 eb a7 83 e2 02 75
                  09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 09 00 00
                  &lt;45&gt; 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89
                  f7 e8 a2 4c 2e ca 85</div>
                <div class="">[ &nbsp;+0.002751] RSP: 0018:ffffb58fac313928
                  EFLAGS: 00010202</div>
                <div class="">[ &nbsp;+0.001388] RAX: ffffffffc09a4270 RBX:
                  ffff8b0c9c840000 RCX: 00000000ffffffff</div>
                <div class="">[ &nbsp;+0.001402] RDX: 0000000000000000 RSI:
                  000000000001629a RDI: ffff8b0c9c840000</div>
                <div class="">[ &nbsp;+0.001418] RBP: ffffb58fac313948 R08:
                  0000000000000021 R09: 0000000000000001</div>
                <div class="">[ &nbsp;+0.001421] R10: ffffb58fac313b30 R11:
                  ffffffff8c065b00 R12: 0000000000058a68</div>
                <div class="">[ &nbsp;+0.001400] R13: 000000000001629a R14:
                  0000000000000000 R15: 000000000001629a</div>
                <div class="">[ &nbsp;+0.001397] FS: &nbsp;0000000000000000(0000)
                  GS:ffff8b4b7fa80000(0000) knlGS:0000000000000000</div>
                <div class="">[ &nbsp;+0.001411] CS: &nbsp;0010 DS: 0000 ES: 0000
                  CR0: 0000000080050033</div>
                <div class="">[ &nbsp;+0.001405] CR2: 0000000000058a68 CR3:
                  000000010a2c8001 CR4: 00000000001706e0</div>
                <div class="">[ &nbsp;+0.001422] Call Trace:</div>
                <div class="">[ &nbsp;+0.001407] &nbsp;&lt;TASK&gt;</div>
                <div class="">[ &nbsp;+0.001391]
                  &nbsp;amdgpu_device_rreg+0x17/0x20 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001614]
                  &nbsp;amdgpu_cgs_read_register+0x14/0x20 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001735]
                  &nbsp;phm_wait_for_register_unequal.part.1+0x58/0x90
                  [amdgpu]</div>
                <div class="">[ &nbsp;+0.001790]
                  &nbsp;phm_wait_for_register_unequal+0x1a/0x30 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001800]
                  &nbsp;vega20_wait_for_response+0x28/0x80 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001757]
                  &nbsp;vega20_send_msg_to_smc_with_parameter+0x21/0x110
                  [amdgpu]</div>
                <div class="">[ &nbsp;+0.001838]
                  &nbsp;smum_send_msg_to_smc_with_parameter+0xcd/0x100
                  [amdgpu]</div>
                <div class="">[ &nbsp;+0.001829] &nbsp;? kvfree+0x1e/0x30</div>
                <div class="">[ &nbsp;+0.001462]
                  &nbsp;vega20_set_power_profile_mode+0x58/0x330 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001868] &nbsp;? kvfree+0x1e/0x30</div>
                <div class="">[ &nbsp;+0.001462] &nbsp;?
                  ttm_bo_release+0x261/0x370 [ttm]</div>
                <div class="">[ &nbsp;+0.001467]
                  &nbsp;pp_dpm_switch_power_profile+0xc2/0x170 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001863]
                  &nbsp;amdgpu_dpm_switch_power_profile+0x6b/0x90 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001866]
                  &nbsp;amdgpu_amdkfd_set_compute_idle+0x1a/0x20 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001784]
                  &nbsp;kfd_dec_compute_active+0x2c/0x50 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001744]
                  &nbsp;process_termination_cpsch+0x2f9/0x3a0 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001728]
                  &nbsp;kfd_process_dequeue_from_all_devices+0x49/0x70
                  [amdgpu]</div>
                <div class="">[ &nbsp;+0.001730]
                  &nbsp;kfd_process_notifier_release+0x91/0xe0 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001718]
                  &nbsp;__mmu_notifier_release+0x77/0x1f0</div>
                <div class="">[ &nbsp;+0.001411] &nbsp;exit_mmap+0x1b5/0x200</div>
                <div class="">[ &nbsp;+0.001396] &nbsp;? __switch_to+0x12d/0x3e0</div>
                <div class="">[ &nbsp;+0.001388] &nbsp;? __switch_to_asm+0x36/0x70</div>
                <div class="">[ &nbsp;+0.001372] &nbsp;?
                  preempt_count_add+0x74/0xc0</div>
                <div class="">[ &nbsp;+0.001364] &nbsp;mmput+0x57/0x110</div>
                <div class="">[ &nbsp;+0.001349] &nbsp;do_exit+0x33d/0xc20</div>
                <div class="">[ &nbsp;+0.001337] &nbsp;?
                  _raw_spin_unlock+0x1a/0x30</div>
                <div class="">[ &nbsp;+0.001346] &nbsp;do_group_exit+0x43/0xa0</div>
                <div class="">[ &nbsp;+0.001341] &nbsp;get_signal+0x131/0x920</div>
                <div class="">[ &nbsp;+0.001295]
                  &nbsp;arch_do_signal_or_restart+0xb1/0x870</div>
                <div class="">[ &nbsp;+0.001303] &nbsp;? do_futex+0x125/0x190</div>
                <div class="">[ &nbsp;+0.001285]
                  &nbsp;exit_to_user_mode_prepare+0xb1/0x1c0</div>
                <div class="">[ &nbsp;+0.001282]
                  &nbsp;syscall_exit_to_user_mode+0x2a/0x40</div>
                <div class="">[ &nbsp;+0.001264] &nbsp;do_syscall_64+0x46/0xb0</div>
                <div class="">[ &nbsp;+0.001236]
                  &nbsp;entry_SYSCALL_64_after_hwframe+0x44/0xae</div>
                <div class="">[ &nbsp;+0.001219] RIP: 0033:0x7f6aff1d2ad3</div>
                <div class="">[ &nbsp;+0.001177] Code: Unable to access
                  opcode bytes at RIP 0x7f6aff1d2aa9.</div>
                <div class="">[ &nbsp;+0.001166] RSP: 002b:00007f6ab2029d20
                  EFLAGS: 00000246 ORIG_RAX: 00000000000000ca</div>
                <div class="">[ &nbsp;+0.001170] RAX: fffffffffffffe00 RBX:
                  0000000004f542b0 RCX: 00007f6aff1d2ad3</div>
                <div class="">[ &nbsp;+0.001168] RDX: 0000000000000000 RSI:
                  0000000000000080 RDI: 0000000004f542d8</div>
                <div class="">[ &nbsp;+0.001162] RBP: 0000000004f542d4 R08:
                  0000000000000000 R09: 0000000000000000</div>
                <div class="">[ &nbsp;+0.001152] R10: 0000000000000000 R11:
                  0000000000000246 R12: 0000000004f542d8</div>
                <div class="">[ &nbsp;+0.001176] R13: 0000000000000000 R14:
                  0000000004f54288 R15: 0000000000000000</div>
                <div class="">[ &nbsp;+0.001152] &nbsp;&lt;/TASK&gt;</div>
                <div class="">[ &nbsp;+0.001113] Modules linked in: veth
                  amdgpu(E) nf_conntrack_netlink nfnetlink xfrm_user
                  xt_addrtype br_netfilter xt_CHECKSUM iptable_mangle
                  xt_MASQUERADE iptable_nat nf_nat xt_conntrack
                  nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ipt_REJECT
                  nf_reject_ipv4 xt_tcpudp bridge stp llc ebtable_filter
                  ebtables ip6table_filter ip6_tables iptable_filter
                  overlay esp6_offload esp6 esp4_offload esp4 xfrm_algo
                  intel_rapl_msr intel_rapl_common sb_edac
                  x86_pkg_temp_thermal intel_powerclamp
                  snd_hda_codec_hdmi snd_hda_intel ipmi_ssif
                  snd_intel_dspcfg coretemp snd_hda_codec kvm_intel
                  snd_hda_core snd_hwdep snd_pcm snd_timer snd kvm
                  soundcore irqbypass ftdi_sio usbserial input_leds
                  iTCO_wdt iTCO_vendor_support joydev mei_me rapl
                  lpc_ich intel_cstate mei ipmi_si ipmi_devintf
                  ipmi_msghandler mac_hid acpi_power_meter sch_fq_codel
                  ib_iser rdma_cm iw_cm ib_cm ib_core iscsi_tcp
                  libiscsi_tcp libiscsi scsi_transport_iscsi ip_tables
                  x_tables autofs4 btrfs blake2b_generic zstd_compress
                  raid10 raid456</div>
                <div class="">[ &nbsp;+0.000102] &nbsp;async_raid6_recov
                  async_memcpy async_pq async_xor async_tx xor raid6_pq
                  libcrc32c raid1 raid0 multipath linear iommu_v2
                  gpu_sched drm_ttm_helper mgag200 ttm drm_shmem_helper
                  drm_kms_helper syscopyarea sysfillrect sysimgblt
                  fb_sys_fops crct10dif_pclmul hid_generic crc32_pclmul
                  ghash_clmulni_intel usbhid uas aesni_intel crypto_simd
                  igb ahci hid drm usb_storage cryptd libahci dca
                  megaraid_sas i2c_algo_bit wmi [last unloaded: amdgpu]</div>
                <div class="">[ &nbsp;+0.016626] CR2: 0000000000058a68</div>
                <div class="">[ &nbsp;+0.001550] ---[ end trace
                  ff90849fe0a8b3b4 ]---</div>
                <div class="">[ &nbsp;+0.024953] RIP:
                  0010:amdgpu_device_rreg.part.24+0xa9/0xe0 [amdgpu]</div>
                <div class="">[ &nbsp;+0.001814] Code: e8 8c 7d 02 00 65 ff
                  0d 65 e0 7f 3f 75 ae 0f 1f 44 00 00 eb a7 83 e2 02 75
                  09 f6 87 10 69 01 00 10 75 0d 4c 03 a3 a0 09 00 00
                  &lt;45&gt; 8b 24 24 eb 8a 4c 8d b7 b0 6b 01 00 4c 89
                  f7 e8 a2 4c 2e ca 85</div>
                <div class="">[ &nbsp;+0.003255] RSP: 0018:ffffb58fac313928
                  EFLAGS: 00010202</div>
                <div class="">[ &nbsp;+0.001641] RAX: ffffffffc09a4270 RBX:
                  ffff8b0c9c840000 RCX: 00000000ffffffff</div>
                <div class="">[ &nbsp;+0.001656] RDX: 0000000000000000 RSI:
                  000000000001629a RDI: ffff8b0c9c840000</div>
                <div class="">[ &nbsp;+0.001681] RBP: ffffb58fac313948 R08:
                  0000000000000021 R09: 0000000000000001</div>
                <div class="">[ &nbsp;+0.001662] R10: ffffb58fac313b30 R11:
                  ffffffff8c065b00 R12: 0000000000058a68</div>
                <div class="">[ &nbsp;+0.001650] R13: 000000000001629a R14:
                  0000000000000000 R15: 000000000001629a</div>
                <div class="">[ &nbsp;+0.001648] FS: &nbsp;0000000000000000(0000)
                  GS:ffff8b4b7fa80000(0000) knlGS:0000000000000000</div>
                <div class="">[ &nbsp;+0.001668] CS: &nbsp;0010 DS: 0000 ES: 0000
                  CR0: 0000000080050033</div>
                <div class="">[ &nbsp;+0.001673] CR2: 0000000000058a68 CR3:
                  000000010a2c8001 CR4: 00000000001706e0</div>
                <div class="">[ &nbsp;+0.001740] Fixing recursive fault but
                  reboot is needed!</div>
                <div class=""><br class="">
                </div>
                <div class=""><br class="">
                </div>
                <div class="">
                  <blockquote type="cite" class="">
                    <div class="">On Apr 21, 2022, at 2:41 AM, Andrey
                      Grodzovsky &lt;<a href="mailto:andrey.grodzovsky@amd.com" class="moz-txt-link-freetext" moz-do-not-send="true">andrey.grodzovsky@amd.com</a>&gt;
                      wrote:</div>
                    <br class="Apple-interchange-newline">
                    <div class="">
                      <div class="">
                        <p class="">I retested hot plug tests at the
                          commit I mentioned bellow - looks ok, my ASIC
                          is Navi 10, I also tested using Vega 10 and
                          older Polaris ASICs (whatever i had at home at
                          the time). It's possible there are extra
                          issues in ASICs like ur which I didn't cover
                          during tests.<span class="Apple-converted-space">&nbsp;</span><br class="">
                        </p>
                        <p class="">andrey@andrey-test:~/drm$ sudo
                          ./build/tests/amdgpu/amdgpu_test -s 13<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          <br class="">
                          <br class="">
                          The ASIC NOT support UVD, suite disabled<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          <br class="">
                          <br class="">
                          The ASIC NOT support VCE, suite disabled<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          <br class="">
                          <br class="">
                          The ASIC NOT support UVD ENC, suite disabled.<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          <br class="">
                          <br class="">
                          Don't support TMZ (trust memory zone),
                          security suite disabled<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          /usr/local/share/libdrm/amdgpu.ids: No such
                          file or directory<br class="">
                          Peer device is not opened or has ASIC not
                          supported by the suite, skip all Peer to Peer
                          tests.<br class="">
                          <br class="">
                          <br class="">
                          &nbsp;&nbsp;&nbsp;&nbsp; CUnit - A unit testing framework for C -
                          Version 2.1-3<br class="">
                          &nbsp;&nbsp;&nbsp;&nbsp;<span class="Apple-converted-space">&nbsp;</span><a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fcunit.sourceforge.net%2F&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C9ab31a8629f34094adab08da3274c20b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877774331000343%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=eWKOCwbUhnOk7jXz3jIjnBvLrxJN%2F9FgudN1u0oK9Dg%3D&amp;reserved=0" originalsrc="http://cunit.sourceforge.net/" shash="WxvGw8DaCn6ywbQrcLA0/wjyPNa9gIVhimdeC29MN4jVatEfyfmeWeNnwpfSaH/dBQiFah93t8cItzmX8YqikOgnPmSAtaozGTLU6Gw7+woCmBxaR3VqoLAtgtzKaO0gDk81K9LEssKDxhY12rHvPXAHIOlZu5KRBAm6ievVuLE=" moz-do-not-send="true">http://cunit.sourceforge.net/</a><br class="">
                          <br class="">
                          <br class="">
                          <b class="">Suite: Hotunplug Tests</b><b class=""><br class="">
                          </b><b class="">&nbsp; Test: Unplug card and rescan
                            the bus to plug it back
                            .../usr/local/share/libdrm/amdgpu.ids: No
                            such file or directory</b><b class=""><br class="">
                          </b><b class="">passed</b><b class=""><br class="">
                          </b><b class="">&nbsp; Test: Same as first test but
                            with command submission
                            .../usr/local/share/libdrm/amdgpu.ids: No
                            such file or directory</b><b class=""><br class="">
                          </b><b class="">passed</b><b class=""><br class="">
                          </b><b class="">&nbsp; Test: Unplug with exported
                            bo .../usr/local/share/libdrm/amdgpu.ids: No
                            such file or directory</b><b class=""><br class="">
                          </b><b class="">passed</b><br class="">
                          <br class="">
                          Run Summary:&nbsp;&nbsp;&nbsp; Type&nbsp; Total&nbsp;&nbsp;&nbsp; Ran Passed
                          Failed Inactive<br class="">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; suites&nbsp;&nbsp;&nbsp;&nbsp; 14&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; n/a&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br class="">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tests&nbsp;&nbsp;&nbsp;&nbsp; 71&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br class="">
                          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asserts&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp; 21&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; n/a<br class="">
                          <br class="">
                          Elapsed time =&nbsp;&nbsp;&nbsp; 9.195 seconds<br class="">
                        </p>
                        <p class=""><br class="">
                        </p>
                        <p class="">Andrey<br class="">
                        </p>
                        <div class="moz-cite-prefix">On 2022-04-20
                          11:44, Andrey Grodzovsky wrote:<br class="">
                        </div>
                        <blockquote type="cite" cite="mid:34789d77-b8ee-1e4f-c5c2-f32f42f923dc@amd.com" class="">
                          <p class="">The only one in Radeon 7 I see is
                            the same sysfs crash we already fixed so you
                            can use the same fix. The MI 200 issue i
                            haven't seen yet but I also haven't tested
                            MI200 so never saw it before. Need to test
                            when i get the time.<span class="Apple-converted-space">&nbsp;</span><br class="">
                          </p>
                          <p class="">So try that fix with Radeon 7
                            again to see if you pass the tests (the
                            warnings should all be minor issues).</p>
                          <p class="">Andrey</p>
                          <p class=""><br class="">
                          </p>
                          <div class="moz-cite-prefix">On 2022-04-20
                            05:24, Shuotao Xu wrote:<br class="">
                          </div>
                          <blockquote type="cite" cite="mid:549246A3-B326-47CC-92FD-608708E1876B@microsoft.com" class="">
                            <div class="">
                              <blockquote type="cite" class="">
                                <div class="">
                                  <div class="">
                                    <p class="">That a problem, latest
                                      working baseline I tested and
                                      confirmed passing hotplug tests is
                                      this branch and commit<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux%2F-%2Fcommit%2F86e12a53b73135806e101142e72f3f1c0e6fa8e6&amp;data=05%7C01%7Candrey.grodzovsky%40amd.com%7C9ab31a8629f34094adab08da3274c20b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637877774331000343%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=oVKmwxAycqT7ov3zMpcdQ83Bzb%2B6L33oW5KSOgpCeuk%3D&amp;reserved=0" originalsrc="https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6" shash="nHWZ21tw7M8uMobEGk3ZAvjWAmfuo8mqCWqr1h3q1o6S57XnK36HvnMckrB1sVqZPmt7vLKYMzTvMNBxKi7ctxtcX5cV1h33adyPnhy/zxzPyYFLahcjl3WOmdacNk7/NEincT8PEdJZtrrFLSZ1rh7VA/kbTmfrMu4sQjC3pdo=" moz-do-not-send="true">https://gitlab.freedesktop.org/agd5f/linux/-/commit/86e12a53b73135806e101142e72f3f1c0e6fa8e6</a><sp
 an class="Apple-converted-space">&nbsp;</span>which
                                      is amd-staging-drm-next. 5.14 was
                                      the branch we ups-reamed the
                                      hotplug code but it had a lot of
                                      regressions over time due to new
                                      changes (that why I added the
                                      hotplug test to try and catch them
                                      early). It would be best to run
                                      this branch on mi-100 so we have a
                                      clean baseline and only after
                                      confirming&nbsp; this particular branch
                                      from this commits passes libdrm
                                      tests only then start adding the
                                      KFD specific addons. Another
                                      option if you can't work with
                                      MI-100 and this branch is to try a
                                      different ASIC that does work with
                                      this branch (if possible).</p>
                                    <p class="">Andrey<br class="">
                                    </p>
                                  </div>
                                </div>
                              </blockquote>
                              OK I tried both this commit and the HEAD
                              of and-staging-drm-next on two GPUs( MI100
                              and Radeon VII) both did not pass
                              hotplugout libdrm test. I might be able to
                              gain access to MI200, but I suspect it
                              would work.&nbsp;</div>
                            <div class=""><br class="">
                            </div>
                            <div class="">I copied the complete dmesgs
                              as follows. I highlighted the OOPSES for
                              you.</div>
                            <div class=""><br class="">
                            </div>
                            <div class=""><span class="" style="background-color: rgb(255, 38,
                                0);">Radeon VII:</span></div>
                          </blockquote>
                        </blockquote>
                      </div>
                    </div>
                  </blockquote>
                </div>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
      <br class="">
    </blockquote>
  </body>
</html>

--------------oXnjjJdqUicSDfw3qS4dNHZQ--
