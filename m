Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2663DC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Dec 2021 22:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 612C110E18A;
	Tue, 21 Dec 2021 22:09:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA8210E18A
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Dec 2021 22:09:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHxz0eFH5og96LwGOZnWKsikLJ8T4skEkIjBTDppQn2DKe0ZE/cs7oBO5e3/2QYFy2DpAulkj1k/EeSSbgVznhDbubvt/nKaSdRa31ER4k3GzTLf5YrtXIjv2tNfD46d3ux7aVNpLOLo/36bC6ZFId4cY4tXAL79yVde0WBEVsNE2ef7FaF/HxHci6aHKktx5JU1JGdZw57istiQ/BDwmJ+okGzRh5qGnkN3CSOKCHE4KFPLtXHpCeT2NKA29alWg82raH8l0B/Oy0hgDrajL0jY23VgXFi8Ytg7Mdu5wwTIiSydduGf4wFTH0Rpi1+Vb9uPaQ/z+KEaJKJ3VBzk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHuBWWmTJBhMKfWVohEs1+WKlZ+Vb2F60oZ299fSPRU=;
 b=n5vXU/Ff8S1GlMRxHaADC1e3WxOvLZVSfLxctMYH5Nbn/VRDSEtMRyK0KucJmeBJenFv8T5+VKQXzAwnNW/46BA60019ef6dEDnWdZwSb0nT+nYMAFj2Wp8sZpTkDU+jcOYOY0ApAcGz6EkDz8gDL1sv3WqE2s+44vzccHmjIJA0CXw2ahOXjvnSdYpV3AbmGfLSYV8rU/DAcnqWlVSicgwYJ1SD550X/P9WwEZxzWdovwYHNH6cDjJfdhHpLwovYRTPn5elk+ST/BQlM+M0m1PjdqTTmfN1fybcI6sQ2fLYoczmggaL4aAFjkWAMh9w3UjgaKwImNLyEdQnqkGm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHuBWWmTJBhMKfWVohEs1+WKlZ+Vb2F60oZ299fSPRU=;
 b=zJeb5wiHPbyXTPnn9osqby7vVUZ6u2DEsXwQjnscZ0hCtpQ2nCzPE7V0CCgKKMAUbrZI+iIdVVh7WoNME7Kl8F2PnRGo0/7Sr09sthG4fEv5FdAXVwR8d85ewB3HHGbOQuf+FwK7OZnps9hmyed4P8TLavcyfLmZS2Tlp75lStw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com (2603:10b6:a03:3ba::23)
 by SJ0PR12MB5439.namprd12.prod.outlook.com (2603:10b6:a03:3ae::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 22:09:34 +0000
Received: from SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::13:495f:dd24:166e]) by SJ0PR12MB5438.namprd12.prod.outlook.com
 ([fe80::13:495f:dd24:166e%3]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 22:09:34 +0000
Message-ID: <32ca7ff8-b5d3-23e5-7821-e429baa4c5aa@amd.com>
Date: Tue, 21 Dec 2021 17:09:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release PCI
 device ..."
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CAHk-=wjs4AjAKJ26W69xcMB7snFc+0u+rbgA+Tj0S1GvwY2T3Q@mail.gmail.com>
 <20211220213254.GA7250@ideak-desk.fi.intel.com>
 <CAHk-=winh9=DS2ZJZbgwTFS3r3oWfrZcM9MedQ4dKzsGW8QaTA@mail.gmail.com>
 <BL1PR12MB514437F7B1726A2173650FBFF77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB5144E1E5C51C5B5226197978F77C9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CADnq5_Pio64msSwvDXL6Ocm6Ty5B2VVf+v+7f+Dz2EJ_-J7VzQ@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_Pio64msSwvDXL6Ocm6Ty5B2VVf+v+7f+Dz2EJ_-J7VzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::21) To SJ0PR12MB5438.namprd12.prod.outlook.com
 (2603:10b6:a03:3ba::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0696a5df-a9c3-4a46-149f-08d9c4ce917f
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5439:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5439C36F32855B24C85DF26A8C7C9@SJ0PR12MB5439.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbTJO0+iTnTRhTuCX25uqawUbkaqkTw4U8teFlh/i8w0nQAoxkcHthiy8MTvrkBdN9NtKpi+6pDG4D1FDEEZsFsJ+w3erzAFDXnPK4OFjNNNFjKpf48sn4xgmWoeKstfWKo1PFxjEui8fsHZzUlPH87rGWKzxVtq366WrTBNJUMAyr5W8lEk45NbpU3sKjdLU7LKZBLfPGPjixO/WCECwnqDMl1J10bTVkH8FW9C+Y+R/MUXpBbaG+jHiyQF36IvZ848LnjLBssSG9WbBH8qzzJNqHSbtHb3fRw/w/6K9On1KLC3Uv+bw/v1Ek77F0wzzwUlMa0W7bMAHhGu5/0SDie4UKYnzEKAPDZKBmS5Wf05lIABm8SiQRuv+ugUcG7orwQBGLXopfnJQ5Enz5EYpg0CW+mTPWTFBzpEY+CdlOUGstsMPUqvFiOKz784k0brT/Un1IjcG8RTVxpkFO3w5o+O+ozxDo59AFuPIPo+zZDpBuF1udlFlsifQO3odN2pZfDBhJWvVGrzw/soQqCqJ12OMb48K0H8k3Ii93Ux9igcfcWvtm3eFez1PGZsTPirVNj1iRrp8vvK0Z9YywBwU1yenNtoDAUpB1B0Foofs+Rj2wOZUq4cMPp1XVP0ofZL0vF5eYkZEr7LIATt9gjlEY2wyBeooaXye9YlL2scjf6NqdnKcslt07HGMqR29Zq0dViYz89Y1USQJt7wiaQJHvu2uvg8oY6G/yUDoUjj+duY10tZngQe9mzM0ouqmmlOVq1ZNY+OstjB7DZJRKEVYgK49cN98R8LHPPAg/f1v/kEUGmOLoxcP02MSKkRx0AIujlygyH6o6sPxu45S328Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5438.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(66556008)(6512007)(53546011)(31686004)(6506007)(86362001)(26005)(66476007)(8936002)(8676002)(4326008)(36756003)(38100700002)(186003)(44832011)(6486002)(2906002)(54906003)(110136005)(4001150100001)(508600001)(31696002)(2616005)(45080400002)(83380400001)(966005)(6636002)(6666004)(5660300002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1Iwcm8yN0wrWWh3RGRzbVZRNVVHRjY5V1JjOEZReFVTOGhzWkNFRUJvSFVK?=
 =?utf-8?B?RFBzNkVlZWNDOXFqSEV6dG41aHM5MlVkK1dSSnp4aHNCSTlsZGtpanh4Zkp4?=
 =?utf-8?B?bmdQVGZmODRNVlRNdDFNOC9wR3FubVIrVmpiRys2MC8vZ2RZNjBwWllPNzRl?=
 =?utf-8?B?QlQ4cWx0aDkyRlc2anY0RWNWVWVlVUxLQ04wUTFGaU5UVFJGUVNxYkg5MVBV?=
 =?utf-8?B?MEJxQS9Jc1BYaTRsZ2VlNjl4NC85NFNDQUd5RXUyb054ZWd6VE54KytWUWNu?=
 =?utf-8?B?a3Yyc3dnSW1MU2Q5dVhUU01UNCs0RUN3aGRFVG56a3VRS2U5V3dubTRMU1Fv?=
 =?utf-8?B?ZFR3VTBxQkhWVDBLMkloNEwxNCtsS0M1Y0oxTldRSXhUT1JyYlZqYnl3N1Rt?=
 =?utf-8?B?S3VRbDRHVnR5TURBZVZ3MTg4OXdOU3h4OXB3ZWlxY1JuTUxDdW03UlBvL0JR?=
 =?utf-8?B?VVhCSHlnTVZGdEoxL0JJMnBVOVFkWWUyV0hQM01SRUk4VldORWlrSzFLQmR3?=
 =?utf-8?B?QmwycWZHNEZRNTc2RmtnY1piRTAwSlppanA3SzFmbTdlc2h4aEkwRW1hK2NF?=
 =?utf-8?B?cUQ3c0ZZY1Z2S1YweDFpUkNRV1phd0JjSXlmSVFlVGwydy9EcWMxdmhneEE2?=
 =?utf-8?B?K0o0V2RsTkM0REpJUStJRkZNZE1NWUlXSUk1R3dwbnpIQUJNbmlQRVZnOU9i?=
 =?utf-8?B?Qy9iQXVDaE9SL0dyLytiU2pja2dZbVFYdEFLTTdjU3pXMWErMnRYbjZQTTR0?=
 =?utf-8?B?U1ZvYkFabEhlcXBBQS9GN3VYQmdQZ0hWcmFROGNYdHFNUStvbG5IZWsvaFpJ?=
 =?utf-8?B?TjVlS0ZSeW93RnlIOHZJbUxZbjQzN2ZZYkxGZkxvV0ZQdkVyd3FMYXZWTG5h?=
 =?utf-8?B?Y1BFcC9pQjhneHpPcEt1Y0pLNnk5NHlWenVianhXZTNocGp3ZjROSTJYWStm?=
 =?utf-8?B?MEVaODk3RG9wQXFnc1pqMHlrTUZ4WGZNOGJwQlRpZUUwNkcrZlcxb3BkTThL?=
 =?utf-8?B?T3BuWXVYKzJ2Tkw2S0tsVTdVSWtCLzkyLzIzcUxLSkxYVGdEb05kKzdMTFE1?=
 =?utf-8?B?d3M0RC9qYlZHdXFNSFFRU0dVbm9XOFc1OTNZbU45YWdHeXFWNTF5R3VldCt6?=
 =?utf-8?B?aXlmTDVJMXdrK2htRU9iR21MQzIxQVRsMEJZVlE5NXhSYTBZNzRqZHBTaEV6?=
 =?utf-8?B?aDBoNVN5bzVzaDBIQnpDOHFvelNnU0RIMmpUTEltRlgwT2txdnlNbHptL2sx?=
 =?utf-8?B?TUx5V3VheGJTTWNwcWFTYmp2clpwNlBZOXJpMlR3Z1Rvb0g2T1dtZjZMTUE0?=
 =?utf-8?B?VlE2WUoyOXhBeGh4aU1RSlg0RnVKak9BcndaZml2MHM0emJ1MUVHeWtSa2tE?=
 =?utf-8?B?TG1VMWlJd0FLWnJqem5jK0FOQWI2aTZDb0cyaUdsWkIxcmtraXhiMStMcENm?=
 =?utf-8?B?SE5DeFVwL20xL2laTVJUeUhGdm9NSVRVd2JwdDBCdHFYajJPZ3hTZXBzcG53?=
 =?utf-8?B?N1huUDVKTE5Lb1VqZ0d5V3Rvd295cXNFckZIL2NIVXZOZG1uTFpDVE9vRGgx?=
 =?utf-8?B?VVUvNkEzUzRyRzZZNTRGVW9WT1FOQTIrQzJweldlOFg5eVVvS20zNG8za0ZQ?=
 =?utf-8?B?YW9MR1l4dm95eFY0UmZkSkdUZE5hSExQZUdFQWtBa2lvVDl6Nm81cWJLdlZm?=
 =?utf-8?B?bkF3d29JbDZiemJGZy9qVHVsVmtsYVd2TVpYMjNvN2ZxTU13TmErazFoOVYz?=
 =?utf-8?B?THF2N2laMmNoL1FhNzFHUHZSV3hqL3FXV1p0VXR3dmpqZUMwbnE3M0QwbEt1?=
 =?utf-8?B?T3BLQUROc0I5VURrWGJtcU9XcXhDM2dTVWdyTFJGVGxCLy93NFFYeE56ME4y?=
 =?utf-8?B?Wi9HWGFwZWFNdHhjMVBBRXlHanFxcGErcjZqeXVhbVJ5NWEzZEJJYTlMMXNG?=
 =?utf-8?B?MkxKVkJnM3AwUE9xRmtMeTNsUWpRYmVZenFGaXdGTWRuSmxheGg2ZmRmbmhz?=
 =?utf-8?B?VDI1ZkxaejZkUHNxVWs2VGtwZW5id1BOaE5ZbXQxZHk4cVpaTW56OU9lRXRs?=
 =?utf-8?B?amdYUVNCNTlkUG41U0JqK1QrUldYOEhFRnR6RTJOeHNldTFvcjRNNUE0aXBH?=
 =?utf-8?B?VnZJdFBGNm1FeXR0RXdNSjBPSGNnNmk5RkR3UzNtL1NmK3NVU1ZKOGpMTTQ4?=
 =?utf-8?Q?TBOpfCmLMpvlua0Vmee15G4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0696a5df-a9c3-4a46-149f-08d9c4ce917f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 22:09:33.9369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NvakiJq6Xjyg6dd6byXAkaXOmpfLF7PNc3UACi7Um+wfrBsVvjuxjcekfFtZGmNgc2I2u0xUyN82i6EUXFgBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5439
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Imre Deak <imre.deak@intel.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-12-21 16:18, Alex Deucher wrote:
> On Tue, Dec 21, 2021 at 1:47 PM Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
>>
>> [Public]
>>
>>> -----Original Message-----
>>> From: Deucher, Alexander
>>> Sent: Tuesday, December 21, 2021 12:01 PM
>>> To: Linus Torvalds <torvalds@linux-foundation.org>; Imre Deak
>>> <imre.deak@intel.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Kai-Heng Feng
>>> <kai.heng.feng@canonical.com>
>>> Subject: RE: Expecting to revert commit 55285e21f045 "fbdev/efifb: Release
>>> PCI device ..."
>>>
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Linus Torvalds <torvalds@linux-foundation.org>
>>>> Sent: Monday, December 20, 2021 5:05 PM
>>>> To: Imre Deak <imre.deak@intel.com>
>>>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>; Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com>
>>>> Subject: Re: Expecting to revert commit 55285e21f045 "fbdev/efifb:
>>>> Release PCI device ..."
>>>>
>>>> On Mon, Dec 20, 2021 at 1:33 PM Imre Deak <imre.deak@intel.com>
>>> wrote:
>>>>>
>>>>> amdgpu.runpm=0
>>>>
>>>> Hmmm.
>>>>
>>>> This does seem to "work", but not very well.
>>>>
>>>> With this, what seems to happen is odd: I lock the screen, wait, it
>>>> goes "No signal, shutting down", but then doesn't actually shut down
>>>> but stays black (with the backlight on). After _another_ five seconds
>>>> or so, the monitor goes "No signal, shutting down" _again_, and at that
>>> point it actually does it.
>>>>
>>>> So it solves my immediate problem - in that yes, the backlight finally
>>>> does turn off in the end - but it does seem to be still broken.
>>>>
>>>> I'm very surprised if no AMD drm developers can see this exact same thing.
>>>> This is a very simple setup. The only possibly slightly less common
>>>> thing is that I have two monitors, but while that is not necessarily
>>>> the _most_ common setup in an absolute sense, I'd expect it to be very
>>>> common among DRM developers..
>>>>
>>>> I guess I can just change the revert to just a
>>>>
>>>>     -int amdgpu_runtime_pm = -1;
>>>>     +int amdgpu_runtime_pm = 0;
>>>>
>>>> instead. The auto-detect is apparently broken. Maybe it should only
>>>> kick in for LVDS screens on actual laptops?
>>>>
>>>> Note: on my machine, I get that
>>>>
>>>>    amdgpu 0000:49:00.0: amdgpu: Using BACO for runtime pm
>>>>
>>>> so maybe the other possible runtime pm models (ARPX and BOCO) are ok,
>>>> and it's only that BACO case that is broken.
>>>>
>>>> I have no idea what any of those three things are - I'm just looking
>>>> at the uses of that amdgpu_runtime_pm variable.
>>>>
>>>> amdgpu people: if you don't want that amdgpu_runtime_pm turned off by
>>>> default, tell me something else to try.
>>>
>>> For a little background, runtime PM support was added about 10 year ago
>>> originally to support laptops with multiple GPUs (integrated and discrete).
>>> It's not specific to the display hardware.  When the GPU is idle, it can be
>>> powered down completely.  In the case of these laptops, it's D3 cold
>>> (managed by ACPI, we call this BOCO in AMD parlance - Bus Off, Chip Off)
>>> which powers off the dGPU completely (i.e., it disappears from the bus).  A
>>> few years ago we extended this to support desktop dGPUs as well which
>>> support their own version of runtime D3 (called BACO in AMD parlance - Bus
>>> Active, Chip Off).  The driver can put the chip into a low power state where
>>> everything except the bus interface is powered down (to avoid the device
>>> disappearing from the bus).  So this has worked for almost 2 years now on
>>> BACO capable parts and for a decade or more on BOCO systems.
>>> Unfortunately, changing the default runpm parameter setting would cause a
>>> flood of bug reports about runtime power management breaking and
>>> suddenly systems are using more power.
>>>
>>> Imre's commit (55285e21f045) fixes another commit (a6c0fd3d5a8b).
>>> Runtime pm was working on amdgpu prior to that commit.  Is it possible
>>> there is still some race between when amdgpu takes over from efifb?  Does
>>> it work properly when all pm_runtime calls in efifb are removed or if efifb is
>>> not enabled?  Runtime pm for Polaris boards has been enabled by default
>>> since 4fdda2e66de0b which predates both of those patches.
>>
>> Thinking about this more, I wonder if there was some change in some userspace component which was hidden by the changes in 55285e21f045 and a6c0fd3d5a8b.  E.g., some desktop component started polling for display changes or GPU temperature or something like that and when a6c0fd3d5a8b was in place the GPU never entered runtime suspend.  Then when 55285e21f045 was applied, it unmasked the new behavior in the userpace component.
>>
>> What should happen is that when all of the displays blank, assuming the GPU is otherwise idle, the GPU will runtime suspend after  seconds.  When you move the mouse or hit the keyboard, that should trigger the GPU should runtime resume and then the displays will be re-enabled.
>>
>> In the behavior you are seeing, when the displays come back on after they blank are you seeing the device resume from runtime suspend?  On resume from suspend (runtime or system) we issue a hotplug notification to userspace in case any displays changed during suspend when the GPU was powered down (and hence could not detect a hotplug event).  Perhaps that event is triggering userspace to reprobe and re-enable the displays shortly after resume from runtime suspend due to some other event that caused the device to runtime resume.  Does something like this help by any chance?
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2Fattachment.cgi%3Fid%3D300103%26action%3Ddiff%26collapsed%3D%26headers%3D1%26format%3Draw&amp;data=04%7C01%7CHarry.Wentland%40amd.com%7Cd1d2f9528d8e42199af508d9c4c7793d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637757183279389936%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=KdIAXxYP0oQpNCFCe1slYwqgDhRdse2CrkGuCc2KrAE%3D&amp;reserved=0
> 
> I'm not seeing this on my system, and another user tried the patch and
> it fixed his system, so it indeed seems to be something along the
> lines of what I described above.  Something in userspace seems to be
> accessing the GPU causing it to runtime resume.  On resume the driver
> then sends a hotplug event to userspace (in case anything display
> related changed while the GPU was suspended).  The desktop manager
> then sees the hotplug event and reprobes and lights up the displays
> again.  @Wentland, Harry, I guess the display code may already handle
> this (seeing if anything has changed on resume since suspend), so we
> can probably drop the call from the generic amdgpu resume code?  Or if
> not, it should be pretty straightforward to fix that in
> dm_suspend()/dm_resume().
> 

We handle re-detection in dm_resume but only seem to call the
drm_kms_helper_hotplug_event for MST. We might want to call it
in dm_resume but that would just move it from amdgpu_device_resume
and will probably cause the same issue.

What I think we'd really want here is to make sure
drm_kms_helper_hotplug_event is only called when any display
config actually changes. Unfortunately, we're not being very
smart in our detection and just recreate everything (even
though dc_link_detect_helper seems to have code that wants to
be smart enough to detect if the sink is changed or not).
This means this change is non-trivial. At least I can't see
an easy fix that doesn't run the risk of breaking a bunch of
stuff.

Or maybe someone can try to see if (non-MST) detection during
RPM still works with your patch. If it does (for some reason)
then we should be good.

I can't seem to repro the problem on my Navi 1x card with KDE Plasma.
I wonder if it's a Polaris issue.

I also don't see my Navi 1x card going into RPM after
'xset dpms force off' with the Manjaro 5.15 kernel. Might need
to try the latest mainline or amd-stg.

Harry


> Alex
