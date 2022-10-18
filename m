Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33072C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Oct 2022 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D96C10E728;
	Tue, 18 Oct 2022 19:14:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B9210E728
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Oct 2022 19:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mt0KrdQDJN88CichlYDqhPxoQtg/o3IVYkRMIiZaGC6Sjh/DaVMPSsNBQr3Dy5Z3mTLRoVCd37isTG8mD0Ty6CzHNPKBu9GbluIUQ3jn2mOwxlWcLmuOj4rnLfWd46Sgc6PoAbClujoh6w1p0dod4U6FyGnnTPvfUyL/RkliHwPfGGZauM+h5+4hUUnDNpIiwLHF3spxXvvqsNf4drdDszUmIzTJfIPaiXLG70huJ2COaQnxSCiw49bLXj8/rWxQRPRsIllYRgSPgEVvp7WVdCd64GE/h1sB95S0zdURWfCcksG2XvustB5pQGXY0jgQHxUHC3bzP1FTo0AXQAFuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar+jlqMQ153K03dQAMDM9DLJNvLhtfNFctCNkyAlZSE=;
 b=FnD9KhGfDcjUCdesjvj6k4RNn7sGVYsnbedj6j57jAdiRbVMzxQ4XGuvibuk8W3of/JuPI5ai94MTIPEz/OfwF631wDayweDY0I118cLGPYXp3QLSlxs0Y5gj3KNOREoJr6bRzxrLEj9rFPATKOGuNpXW1vR322QCweAD4zdbGGwF4nIcChLIqy2fA/YL5N7WknZnZPIIZvLnJ7L2bCI45vV+S/YII+xnq3pidHBhP85Mpx4oo8v/1nUJfTy6nGDrdbH/8yGLeKETS+vvEGENratpRy1lg+1N+i/kBV+8YXoWXxkf2vo6J7iUpeGcjsZH/PPxPqrWw2Xd54zMBM+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar+jlqMQ153K03dQAMDM9DLJNvLhtfNFctCNkyAlZSE=;
 b=pSkEr1JRIta2Pb7/O1ePGaGXO65+Na1gzid8rFhiGCGwemfuFRYQsISFbaL5G4UnZHrxdA3ecsnkpqLAwSN16Cr51o0b80u1Rr8I0l6QbKRHPCzQLiaWcpdhiE8nLFNZTHsY/+uU9UBQ7FuITQexwVCvnYS8hYY8Zyva0XdKbY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SJ1PR12MB6289.namprd12.prod.outlook.com (2603:10b6:a03:458::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Tue, 18 Oct
 2022 19:14:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aef3:6aae:b904:e395%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 19:14:35 +0000
Message-ID: <2c37cd26-bb87-bad6-16bd-8933e0e3faf8@amd.com>
Date: Tue, 18 Oct 2022 15:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 00/12] Update DC commit sequence
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221018122826.1790114-1-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SJ1PR12MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4c0d50-ca93-4413-5f80-08dab13cfe55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XDlTDEom3I+RQpQltJmDbUL3JSe025cbB9pYeEzEG2t/eUgiCumHsAWbfmxNh1FGWJ3e+00a34GnTsURmaZUWgEpGlttCn+dz6ZxPx1JnJSYHLubu3q98bMb1ISQpw85uorB3mvO5S7bqZbU01gWiMpXWI/NecnoCqrhjiAuYo39qjZ8bep7oReCKtHVOKXxvSA7CZ6bW6xtYLqCx6qW/R4Oj6YLhCoalNJX4wf3VOCsFMxIcR8br15JciYB7scydLTO7zysUvYMa/KgNvuj/JKIf//HQCvugm2OjBrMp+m2mGcddI/zACSgwnKqgufrh4UV4ZiIUlNdWSf9SmYt56LZJR1qhhmzj8Yph5w8734OPzIFRbqakFjMHvLIZfORGtmSqzyBldz9iGjj9ka0WOxnD8tj2c0HhmYRRylYTMQAgCPGgsvEgEZcT32D5oZwwM6W8RnTbanLJdYE3oawiEmGvyFlj+1frkH4Ib0A+Uyu9aTNbL7SSaoYICgqL+1OKQMVxjosUmg0lXig0dolYNF599Ncg6c570KHY70ccLohLFvyDrgRoEtiRfc9xHZEpYsDw5Dxn5CPZ/Xp+TYOmses+LYlYd+heQBFZKKOahtMiRocMFLMKeJufC5zlBzmRMKxvbGuqvFc949uVn/QJ79GMx2kDvUBCNH/D9350HjZKGeIVBrt3A6NliJ1N1Nom5tQpBRDEV60DVEJaj5Nij0lmuTGC4mhFLCRviH4rvTFvkM8KGZAShZ4EwSGSnzDTCRl5t7ydGRRL7o83WKh+5VRrMsqTMmq8X3jBySvmzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(31686004)(316002)(26005)(15650500001)(186003)(54906003)(2616005)(6512007)(66946007)(66556008)(66476007)(36756003)(31696002)(86362001)(5660300002)(2906002)(4001150100001)(38100700002)(44832011)(83380400001)(8936002)(41300700001)(8676002)(4326008)(6506007)(53546011)(6666004)(478600001)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkVmcHhCbjM5UGZMSG45MEEvSld5U0ZIV1Azci9UUmoxY0daYVY3blc5U0hK?=
 =?utf-8?B?QkphZ0IyMHFIdWZ4QmNpUDgzVktjbVJ5UmZEcmJqeXVyZWhsWmJnSCsxbDh0?=
 =?utf-8?B?TWQ5WVVXWk1Yd1dlT29SaHh5a2pmenN6akZJVVpZTklnWHV2bmhkMGRYZWZV?=
 =?utf-8?B?QlVzeThaMEpncVhDdXUreVVQa3JlQUJTU2pLSHFTaEIvUkN3MkpqK0NVZ3lY?=
 =?utf-8?B?ME1Pek9obHVrSUM1OWZ4MFpIV0ZBMThKSitzR3NKVmpzZmFhL2FDQ1dyL1Vr?=
 =?utf-8?B?dzBEZVVLQ0haVUVoT2lhQjlTVVpzLy9kOXJDTXhHSVk0aVppMktTUGwyZWJq?=
 =?utf-8?B?T2prZzVac2ptZ1VLV1BoV2g1OXE0TXNjN3VHTnZkWTJzdVd1TXRkTzRhRXAy?=
 =?utf-8?B?aDJEMCtHSm1ZSGlLMWlSS2dXbVJSdVNvdWN2Z0JJZEJLdEQ0TS81eFZKeCsr?=
 =?utf-8?B?aXJTNGsyRXBJbUlYWDR5dUgxK3ZaZjk0eWRHbXE5Y0kwWkovQlZwaXgzL3Jp?=
 =?utf-8?B?WWpiZ2xXWDYyRy9EL2ZNWHNvdktrT1NSeTl6a3pkS3pCWGVrbWVGRlN2UXdI?=
 =?utf-8?B?SDRPS01DNFlVQzhPQkJDQmZpRCszeHZlbUlNdDE0ZWhsVG1HTVlqNEVqOVc0?=
 =?utf-8?B?MEFOZHRqdDlZcmpSY2lzUm42V1AyNlJDQUw3TCtadzFYQ0swTzVPWnpJTGpt?=
 =?utf-8?B?eVp4MjFRWitPa21qZjdocm9ZeFFmTmNyanJtSlhJZlpCNGJEMnkzQVJQVDVl?=
 =?utf-8?B?U01BWC9IaGxxZDdVMlJibTNEQm9kTHd1QWRhUFVUajgzSDUzRGpubGtNaEl5?=
 =?utf-8?B?aW5IL3p5OCszVTVpWFNrVGI2RjJhS1FTalU0VlQ0UGJtbWl6STAvLzNhOXFN?=
 =?utf-8?B?SXhlYXJHSW9aR2VMQkd1YUFrdU5xbmVtaFIvY21NN3Z5bnRveEhhYlNLMmM5?=
 =?utf-8?B?cDd4ZTRmTSt3MWRRTU1kTHNBTkZEZlhIUFV4RWF2US9pK0wwSDRxRDZwSGVM?=
 =?utf-8?B?WlBDcDdFUk1LdUJDRTBnMEdnTzAzWmY0QlJyQUJuOEU4NkpVWlNFdk4wanli?=
 =?utf-8?B?V2MrdE9VaFZBZmdDUTQ3OHE3Z2R3enhPd3U3SVBvRlRWc2h1UDZybHdOTERZ?=
 =?utf-8?B?dHZVTWVoQUg5emwvNDd4dWI4anRxUFUzMlVaRG9haWVldHFUdms5OGJ4MWJj?=
 =?utf-8?B?NVVKSWY4VzZhcm9VTkVDVUNaRktJeTVKUU1PODBTZkljMXNwUWhzSmlReEFI?=
 =?utf-8?B?dlJmeVVXVVNJaGJZdmVsZVgvMUpYZ09sdklNZGZxSk1ucXVuVnBhVFJwNDI1?=
 =?utf-8?B?N0pia2xqQjc1SmhLYVJSVHFpK3lVM0RkVkY4SnpXNnpCRTdNdGZRRktMYkZF?=
 =?utf-8?B?MU4xZkkrdy9KcDN6VTVIc2x5NVI4SURha2VTRjhiMjhrUDZEN1BiOHhWVlhF?=
 =?utf-8?B?dS8wa1FpQnlrdEFRa3V0ZHl1c0xqbDJOQ3I0MU9WdGdVTXNBQzZCdGRPN2pw?=
 =?utf-8?B?M0ZWZEtWMEk3ZjduUUhnODl1bjl1dzQyZWhNSkV3UzNSSWFITmw2NjY0YWh2?=
 =?utf-8?B?MTRiWG4wRkpPUVRLekh6ZnV6L0k0bkVndFFCdEhHMkdmc2c1ODBiZTNtOHdX?=
 =?utf-8?B?Wm15V2licUcwSkhnQ2pyUUpOV21kZzJQemYzTHF2RnAvRHg5N1QyTFU3K3NT?=
 =?utf-8?B?cU0yMGttRjYwaE5sR3ovMkMvMXUvRGxhSCtVVnVmMlBELzA0cEF2TFhXUXZH?=
 =?utf-8?B?ZUE5NHV3Uit2WHlMbzdNZ052aGRiZW1HZTBxNUNTbDNTbzhpek5vKzk4QlZO?=
 =?utf-8?B?dDFOTDBLdjRQUXBHazA0dHk2NWhJVThKaFh0bU1VNTY4bDlPZ3N0bW5wbE43?=
 =?utf-8?B?VkFZSFlNRmkzbytJR0d5RVlWdEV2VE54SVljdmR4eTA2RDAwOURPalRxeFpp?=
 =?utf-8?B?emlvTlNHSjF0QnFtNVhnSUxTUXVVdnp4UzJvL291enlRTlFEa2RpdWFUeUpR?=
 =?utf-8?B?clNiMTYydGtkK1JDRExLTmZMTXhzN0JycTMxeWQwbWJoOGt1K3U5OWsxM2xX?=
 =?utf-8?B?WEdhemJaSzNDdnFsZWJDbzdYSXF3UEE3Q0dZZWhmV3ZjbXVCZFVCaUZaYW5r?=
 =?utf-8?Q?R+PC18GAjpmYh8cdSkpIWtXIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4c0d50-ca93-4413-5f80-08dab13cfe55
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 19:14:35.1695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvtdSZfT+TThULTwiv4qyVQmnJjonvzDVrKCgqHgonuCigNTazfB7ctrkYZ3bLVBQs4t4X65hMiN+1SYgi1zZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6289
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
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-18 08:28, Rodrigo Siqueira wrote:
> Year after year, DC adds new features and expands its support to
> components already available for multiple users. As a result of this
> constant growth, we start to see some issues associated with the current
> commit state, which is a little bit simplistic for DC needs and lacks
> robustness. It is time to expand the current commit state to represent
> the DC organization better and make it more robust.
> 
> This patchset evolves the function dc_commit_state to a new function
> named dc_commit_streams by adding a step-by-step change. Current,
> amdgpu_dm tries to commit a validation state directly into update_planes
> and commit_streams. However, we want to avoid committing the state
> directly into DC; instead, we only want to pass streams/plane pointers
> into DC and let it manage the commit state entirely. This behavior is
> more future-proof because it keeps the state manipulation inside DC,
> which can benefit some specific features that might want to play with
> the context state.
> 
> This patchset is organized in the following manner:
> 
> 1. It starts with some adjustments in a generic function to address some
> edge cases and a function rework to enable the transition for the new
> commit sequence.
> 2. It adds one commit that duplicates dc_commit_state into a new
> function named dc_commit_streams and a code patch change in case of
> ASICs based on DCN32x or superior.
> 3. It added a series of commit that expand the dc_commit_streams to
> handing multiple scenarios.
> 4. Finally, the last part of this series adds patches required to make
> SubVP work as expected on DC32x and above
> 
> Thanks
> Siqueira
> 

I left a couple comments that we should follow up on but in order to
unblock SubVP I'm okay to take this in its current form (i.e. for Navi 3x
only). Please follow up on my other questions as part of the work to
switch all ASICs to the new sequence.

Thanks, also for splitting this into smaller chunks. If we see any
fallout it lets us bisect the problem a lot better.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> Aurabindo Pillai (1):
>   drm/amd/display: Move dc_state copy in commit_tail after
>     dc_commit_state
> 
> Rodrigo Siqueira (11):
>   drm/amd/display: Check if link state is valid
>   drm/amd/display: Rework context change check
>   drm/amd/display: Enable new commit sequence only for DCN32x
>   drm/amd/display: Copy DC context in the commit streams
>   drm/amd/display: Include surface of unaffected streams
>   drm/amd/display: Handle virtual hardware detect
>   drm/amd/display: Add function for validate and update new stream
>   drm/amd/display: Handle seamless boot stream
>   drm/amd/display: Update OTG instance in the commit stream
>   drm/amd/display: Avoid ABM when ODM combine is enabled for eDP
>   drm/amd/display: Use update plane and stream routine for DCN32x
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 122 ++++++++-
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 234 +++++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/dc.h           |  36 ++-
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +
>  5 files changed, 384 insertions(+), 29 deletions(-)
> 

