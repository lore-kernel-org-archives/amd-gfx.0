Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4409C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 15:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0AC61051
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 15:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E0AC61051
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097976E3D0;
	Fri, 19 Nov 2021 15:39:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45AC36E3D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 15:39:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqamNWE6yYho/rdxqzhjTzKs2Zp78KFQ+OycL2LnRKyJ+svZXGvUVfx2wLBr2rglTAm9lXA6rUDXsziB83VS+gpR3H3OrGYTMqfmc/lGcwVtTzSXkI0lF5L9peN1xQmt+Y2EjafbUJrMeXI36LEmCutQIYpSb+y20px+0XpSytxo6z8awt3Xr1H1x9FnU84CxMpIHlEfCFPNERXDrEB3FooykB3U0djcXqRY/K6MAq1m2L0WvnIdq6ubZ7PJFw2jdSeChZGtiD8HYZ5cCFhrOgwkLRjWIGwo66KGBi9JB9Qqhx25DEjRzrLYi2LYq/ImeT7QCqtdv1vKVM1JaWmilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMS6wxqnV56o+rmmkxQ05rBk2JSyCcGw5epM/3U0M9o=;
 b=aWelktGl2g9iVjUfgJ2uuHhLL8fY1BlovXxdlV2Dc1wYHRg8Vy8TywLsZyz5hm08VcqtuyQIc5NUTJj7yR0OC6lcF5mQ1GG+ZDRcDFkeb488Dr+hrhm6eTxd62834Adbt/Wvyz6uKoSEuN5EMRq7vQpRjmO4JpnjAvuUgRxlVFHnU7y8SXyFxDCLuSkmeiNsmYQ1qWvZRG5AChio1EuzRIUdUdmhhnvb+C03sYWyThPPFYWCsHI1jM1DRipjl0VtmyTERhM14lB2c5oegmWp5IaveRNF0GT/EXx7XkSZJnfoHUNV/1f9bp7OgKpjItZ1o+KTUte8RyKPzuaWvK5h+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMS6wxqnV56o+rmmkxQ05rBk2JSyCcGw5epM/3U0M9o=;
 b=WzM6KXdeYHOFqLKsE4QiMbxCkjZSyM5Kou/pz/0je8exBLTHWzshD/oMHLeNoIe4x2Uoe8heuFJr40ABC6edh+L0NA0uzzSYZ2rBLrJ35RZhAvIN/FZjzZmgnRggtQS+P/H8W5hCQiS0gccdQGuaZxtZu4GbzLkPWNWRwNUjTV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by DM5PR12MB2389.namprd12.prod.outlook.com (2603:10b6:4:b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 15:39:26 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::2548:bc51:2643:fb7b%7]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 15:39:23 +0000
Subject: Re: [RFC 0/3] Add Smart Trace Buffers support
To: amd-gfx@lists.freedesktop.org
References: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <4ccd33e5-5b98-2798-0f74-7bdc8432fa16@amd.com>
Date: Fri, 19 Nov 2021 10:39:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211118181827.237115-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:3edf:49b0:71cc:6c87:da40:41f6]
 (2607:fea8:3edf:49b0:71cc:6c87:da40:41f6) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 15:39:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55da92f1-97f0-4c3c-dc4b-08d9ab72c2f2
X-MS-TrafficTypeDiagnostic: DM5PR12MB2389:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2389B337270C145FCED0A57BEA9C9@DM5PR12MB2389.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lSYlTbgroEM6pReLX9PM6P3xHliThDpb/pNiVHqYDTJo0rYczCGfscvDVlQUrBMWKPSDJY7K1+zwgi3kAHBNMOiB8jzhjp+QH6ab7XTcPKwlrRWMHNBHzy9ABvdP5APwKm2sT+zij4aO5eK1seKYfAAU4aFsgam/ZvKpwGsUAVzAjeGmpBS+FkxTfvmQs1nB/SZ22KxUwdAlHkGNioscLdzOGVq/oPuk/HSVOLHA7ZvPtk+SlT+EqfN4E/okpb7FQZkgi8hrlSwjZ9xKvrjC4ZEduPtjtUr1cMCSTIgsj9TqTaZ5UDg1Qu64qumyYS2oynU3vZwF5Rgy58Rltt96yqrUUlyNrNA7IZ3uslkNUriKnlluuTyWt2XyxoPTAu4TapU39ldar9vQ8mDndozf0Lw5InKW8TZnwmtTvT3kZWnvfFz3KTJ3DKarjF54a6sxS4/PXi2kx9ghRf4NLri2Qd/3dUQi5Zw/St5RFVM4LFXP8wo/5fHD78GAA05spKl1hN8DjerPM6Fhg4kmFNXKlg7fuqzo2fbASlHOWwvOjotVe7Sbn1pYx4piHd1lCZaW+bO5t1H7a7XQkplye5KmKT3whNMiKHv0k7zXkcB3Cqb+7nXT3JWk0xw8mfkRrzdTndFZNMWuyPpt3qn8aqSN8YhDbggyc/4X867HCk/1xi6QKztCzIdwke6VnlueklJZEt/G+TFMQUWHd7fXgz4/oimqnfmhALxbdzWIOmRNQRpRtMdoDV70IjnQA2eKP9O
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6916009)(6486002)(4744005)(2616005)(38100700002)(53546011)(8936002)(44832011)(508600001)(8676002)(83380400001)(66946007)(4326008)(4001150100001)(66476007)(86362001)(66556008)(36756003)(31696002)(316002)(31686004)(5660300002)(2906002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bi9xTDBiQzluVEpIRTFCb1pNeWRIMTNvNXB3Y21DY1pKMkpHUUhBZHF3MzNC?=
 =?utf-8?B?aVFXb2FNQkh2VUhYV1U0NHNFZzZiRzJCZzdpOGFlVXBHQU85ZlFUcU1oMEFC?=
 =?utf-8?B?M1hDMXhXZitEV0IrQTRKVHBScnNmVDZVcktiajgydnFmNnI0cUQ3Mmh1ZHhl?=
 =?utf-8?B?WGF2djE5ZkVQRVdHb2YxZTE0Uk40Ymxnay9PK0tNYjU5bjFETzlYc2RMeTcw?=
 =?utf-8?B?UE51Wjd0UWdNeGlnNVFZQ2swamJST3lQT0JjV1pPdTEyTU9kWW9hY1Q4SkJq?=
 =?utf-8?B?Zm9JUkhOZjdSVlFZSXhUSkorNW1tSE92SExxYnRSMnlCM09qb0E4bEdkQlZp?=
 =?utf-8?B?azI1N0tsZ1dTZ2dlVUpiMXJRUXpaSkhpSStCNmNob2luampMaXkvdXdseVlT?=
 =?utf-8?B?K1BHNmI5Y0ZaUmNqQ0RuNEhwM3RFYVNyTzdsc1ZYWkZMU1VmQU14dnViOUcx?=
 =?utf-8?B?b2dQTmIyMmxaSVJOUGlpcFN2UmR4bTFCUUkvWWoydTZYL3M4YWZnTmNDR1lG?=
 =?utf-8?B?UDVBWHN1aENoSzZLVVZybFlST3hLL0pWVU10cVNjMzAwd3hCeUozenowZTkx?=
 =?utf-8?B?ZkFkTDZDUjE1L1NlTXpBeFVSWG1EMFVIV1ZpeDJ4VmF6dmFlUGJ1aTVicW9p?=
 =?utf-8?B?Nk91TzhLZnJoSnduVUNBWHFYYWs0Q04yMytVNG9YaVFHV1J6T3JYZExsTWtm?=
 =?utf-8?B?MnJmS2YvOG5VcUt3R1c0aVEyYUZRdm5nMEtOMXA3Qi9DZU9PbWk0TnVoekhr?=
 =?utf-8?B?WDF5T2cwSmZqdlZxLzVyamRlYlZUOGpKTTkrR3YwRVJUeXR2N1NmdXE1TzRs?=
 =?utf-8?B?eUMwaWY4WDNyUkdUb3RiMjlDZEpXeW5Iem1tNC9VeUkvejlTUnlwd01EMENQ?=
 =?utf-8?B?R3VQb3VrUFN2b3c4amNVVXpZdHJNN2ZCQW1ObUl5U2Z6Z1AxU0pzWTl6bXpl?=
 =?utf-8?B?dmVSdkorV2tSV29xU1hrT2FaYW95U2t1TmZGWE5DMXd6T25XOWt2eWp2MCt1?=
 =?utf-8?B?Mjd6dzdLRHRZbHRSRktPUTB3dGdLcTlVRTNKWFpoNnZLVUxKNVlBNzFVV3Bu?=
 =?utf-8?B?RjNkcHBhMnpjSFlONk5ldnBUaHI5dDlPc1JiQWcwVjY5SXgrdzA1TkZ0RHc3?=
 =?utf-8?B?SFFWWDRwcFRkWS9xRjlpUCtXTWI5VFZVeU1HM0Z1cGxXNTRrSlJuMDFqRU1s?=
 =?utf-8?B?amhFd2tHOFhrb1M1a1pEQkJnSFNWVDJpSTJhcVZrd0ZJVHJsZjN3ay90ZlhW?=
 =?utf-8?B?aDA0VmZVdUZVS3NYdHN4UkJ2aU5jSHByQ1ZIanJyN0V1NHV5OTA4UDZFaDR1?=
 =?utf-8?B?OG85a3hVTm9oRlhQK2txVm1sQmxnVWVUVWtWQ25tcjFFL1o5aG1CTW51L1FO?=
 =?utf-8?B?S1pWTzVsOU1kdnVKbjBkSWcxWjRmZWhtRzJQejhUQ3pKZEZpTkVxUDBVMmNV?=
 =?utf-8?B?a2hHalRwZGFwNldiTzRqdU5MR0FTQnN5Vmd3MlhLdVd6cDMzNndRYUNnQTJo?=
 =?utf-8?B?MlhFYU55M2FvK3RteTZxWVZjY2tXRDE3Zk16aGZEb2dmb0xEOWNXbUFucEI4?=
 =?utf-8?B?SUc1YU1SMVVaRnI4amVRckxaRHNSN1ZRUGlicUt5RDczUDZCZ0h0ZHBMdnhq?=
 =?utf-8?B?MEJaNU13SXI2cno5RzZHVGJ2Z0JDSHZSb0p5aDJhMzFxWmUrSzFNUkl5VldQ?=
 =?utf-8?B?SW5YeWRsSTV6Nzhtbzc1UUZSVXJzQW5CYXdWclZKMmZpRFBPdGNtbE9sVE1F?=
 =?utf-8?B?MWJQemcvckdGVXovQjZ4RCt1Z0l6RFU1ZFZGbFpXVmZSdEtyekx2TjRZOWlk?=
 =?utf-8?B?dXhjRmdnY0VVOW12ZmMzNk1aV0ZINW5LejR6Mmd3eUhkNGFsVFZxRjNDcURU?=
 =?utf-8?B?NzlIczQ4TFdDYk9WMTluVDFVblNwT1UrbjQrdHphQkY1QUJMbUU5dGc3Nnc3?=
 =?utf-8?B?MURkaGRGRmROSHhQTlgzcjY0U1UwVE8rTkZxM3dnMFp6SDk3cndQNlN5QWZ6?=
 =?utf-8?B?ZUYyMWV2N2E4dDljTTdMbFQ4THZnejNWaGNzYkNySGE4K2p2cStweXllMy8z?=
 =?utf-8?B?N3Q4N1Z5SkNNM0FhWCs3Wk5jNnZqVElwZncybkN2cWxMRGFhUElVd1BWYjRp?=
 =?utf-8?B?U0hQL1UwUjFFdHVwYjdoV0tlenFqajVqbmtxY1oxR2h5OHdUek1hVDQ0YXdz?=
 =?utf-8?B?UDJodTFTZW0zSWo3RDF5OXZaMjdvODRIOTRXN05RcHRKU0hvZ2lRbEhhMUZQ?=
 =?utf-8?Q?ueLZE05jsk9PjcFOPBzMlwnTHFK+9z6/vi0IP4WBNw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55da92f1-97f0-4c3c-dc4b-08d9ab72c2f2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 15:39:23.8321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rcrtDizMCbOCb8eKizi12u0086tSmU/Q4rvDQG35ut50oAQ6gaiZSjMkkkLYMcGBDgnjgq8EEKC0ifNR/qHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2389
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
Cc: alexander.deucher@amd.com, Lijo.Lazar@amd.com, luben.tuikov@amd.com,
 Shyam-sundar.S-k@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping - mostly just to get final ack to push it into amd-stagin-drm-next

Andrey

On 2021-11-18 1:18 p.m., Andrey Grodzovsky wrote:
> The Smart Trace Buffer (STB), is a cyclic data buffer used to
> log information about system execution for characterization and debug
> purposes. If at any point should a system encounter a functional
> failure the trace can be collected without need for reproducing
> the failure while running additional instrumentation.
>
> Andrey Grodzovsky (3):
>    drm/amd/pm: Add STB accessors interface
>    drm/amd/pm: Add STB support in sienna_cichlid
>    drm/amd/pm: Add debugfs info for STB
>
>   .../amd/include/asic_reg/mp/mp_11_0_offset.h  |   7 ++
>   .../amd/include/asic_reg/mp/mp_11_0_sh_mask.h |  12 ++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  16 +++
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 104 ++++++++++++++++++
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  55 +++++++++
>   6 files changed, 196 insertions(+)
>
