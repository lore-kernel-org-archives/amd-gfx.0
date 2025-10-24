Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86EDCCF9E3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 17:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BA810EB29;
	Fri, 24 Oct 2025 17:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4ZG0VA1X";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CD310EB29
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmYP9Fucda+0fOA8YnI5XI/vf371tZH+ppRcsJ0CtQmGPsOuWUPPigmGI8M/2bFz7MlbBWPVyY4pQYDJqyAbpKAXncUYF7R9XxRP+9VaFKPiwmGujUXf9y5Z21siOMoYw7yltGwqrj2WLyRgIqg/AYbHC/eoUo7eM9Oqjon/YK2SOKS5GWmBsb/QPTau+WP739ppl9DJ5Kzg/yPM9pD0pP1peehNLv4wRHmuWoBZl7iRw4g7weE0RLQpB2lgrtb3DoQm1oIqpCjdLk22KY6A1Bv6wYAkN6n7nwUu2RGiacT+jFTHB/VryLcqh896RlxpY6AUYQhkTrYNkKdkEQJALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzpF9kzOfFoXIIqPeoMsL9/hh8wSETWC/xmuRPQvgOE=;
 b=P7pKEixyNF653QzAJM2jx78VRy8KddefOrJcxpdgNFzSgfimWfoLWEAOlQSNt/0JaS9ptZ+Pl4ZmhhJ7iARh7USrjOeQRTezF65dlPIwUX7zI+iO/SNiIkSXH5yETa52xOLxsoWn6EeZWzrdwsrSbdGHKHTy72s4LpAoCnazdBTQq/iSXyUORNBDfSm+rDxKd992fIXZ+gPmbr/uKVyjHIvBXprwWBOQVOhBvV4CxuJP/GEsH5RxNYIigtk1b12gauJZ1M84e5MrqJMgchzs+Wcz9nuzj9OM4YXjLfQHznv7LrAlcOgAF34NKW6ws5XeLolHRpnuQB+XU59EY1so6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzpF9kzOfFoXIIqPeoMsL9/hh8wSETWC/xmuRPQvgOE=;
 b=4ZG0VA1Xndo/GOl16w2P/OFbgO7eH0u5xLXv++SkQhsKEpNV1td0hw8ZWlC7kInEk3iNiBReCdf5to9kg9q5eTgQUFK+n4erb1dNh7Q/FFcQ4y11zWXECDp6+8Un4+EA2Y/6zLxZ/iBrWzr0rD+iiJCNAS5Uu68MNS9Vd2c7HVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Fri, 24 Oct
 2025 17:08:36 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:08:36 +0000
Message-ID: <afead39a-9b14-406e-a410-ac61aa272ca7@amd.com>
Date: Fri, 24 Oct 2025 12:08:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amd: Move Van Gogh specific suspend code into
 common `set_mp1_state`
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Robert Beckett
 <bob.beckett@collabora.com>, Antheas Kapenekakis <lkml@antheas.dev>
References: <20251024161216.345691-1-mario.limonciello@amd.com>
 <20251024161216.345691-2-mario.limonciello@amd.com>
 <CADnq5_PCK1ttQki=9aGCpYSKinfy36C_s1f10p7wT-9rwc63ug@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_PCK1ttQki=9aGCpYSKinfy36C_s1f10p7wT-9rwc63ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:5:40::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: f985993e-09d9-48f6-7bca-08de131ff814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVQ5ZGljKzVDbk03am1Sc052TEIvUUdNRTJSdVRlMjBCVGF1S2kwZ3p1WDY5?=
 =?utf-8?B?aXo3VjMwdXoxRG5aVVltU2hsRXlvSkEyZUFqSHNtaHpVWVdqTFhOR0tjU1Fh?=
 =?utf-8?B?MklHSXVwcUQ2Kzg5eUJ0NDNJNVorQ2xnbDgvTDZRWnJWWGEvTVIyZW9aWGNI?=
 =?utf-8?B?cG9XbHZBc0ZxYVJ0bERJKzZSTy9vUWh6V3BXTnJ3VnhMMU8zRitDZWdwOXB5?=
 =?utf-8?B?NDNZY2MzUFE5MmZ2UTB4cDBBMHIxN3NHdEQ4cmxLMVFLYnJkR0VKS0FwOG4v?=
 =?utf-8?B?K053QWtCanBsZ3oyRmlUV0E5R0NKQWw2WEtudGF0Qy9INGVOOVc3RGpOaDlL?=
 =?utf-8?B?OG1FL3FIMytpc0JoWmlPUTZ3eGZncWRudXZkc2VPZm5JWk94cENCVFBXdThP?=
 =?utf-8?B?NHZsbVBuOUZvRVRBaEt0R2dJeWxxcnBKRUFvTXZEUWlDMGc5Zlo2L0RIY05i?=
 =?utf-8?B?RXlxdmhwUEFXU3cvTWkwY2hjYldydzkwUVNGbStoYVgzRGJ5RnQxRGczSG91?=
 =?utf-8?B?VDBabG05L1crSXZVMnlCRE41UWpOakhsOG82RzNyQlZwWGtRcjRsN0VhWTZ4?=
 =?utf-8?B?NE55c01aeWJLRHVEbkVWU3pCa0RITjJvZjRUdTR2dzZOVVl4eGtKd1JEL1Zo?=
 =?utf-8?B?NVB5emlhelh2dWRpQ2tybndjT29iRTk5cmE2dDVNN2VFUmEzSzFFaWZ4c2cw?=
 =?utf-8?B?WkVlcWlMdWFhNTBkSzAvajZPTURqckpvS21Sbnl4ZGFrNVI4aG1oSjUyY2hW?=
 =?utf-8?B?azVUZTRGcisvWkVFWDVtY3hLMlkvMkJqVWJRb0ZnTWRRRFpTMCt4OFdMNms5?=
 =?utf-8?B?SEVFSXVxaWwyZ04zekJnemY4TGpCdU9aNW1CZ3p3OVZqM0IvaE9qTmdSZVdu?=
 =?utf-8?B?cEdQcERQa3dBak1mMWxPUGJ5cG4vNHlZbENyTXpZV0oweEtvZkY5M3NIRG1Q?=
 =?utf-8?B?ck5JOXAvOGE4dElpNmd1c0Uwbk5FN1dOa1VPdHNtRHdSOHFMVXZrbnQ5c2Fa?=
 =?utf-8?B?clBiaTVkTFpMT1M0aVgxUnE0eHJuS25RTUsyZ2tLY0pvVUJ4aHZtMlNwZEZY?=
 =?utf-8?B?b1lTVFlCR1BQQmNJWGZFZ2JhU3BuMDluRkg3aTFuSDY0L1JRdnFhRS9DSENm?=
 =?utf-8?B?UTk5cDZPd2dWREZLbW9WcDlLWmMvdThOd1hQTW1qcVZYMWVoeHFHNi9jVXhs?=
 =?utf-8?B?R0lucXQvQSs1cUN2Y2EwUEhxV01zT3pMTTcrckUwRzg0OHp3cjNLZklFZy9y?=
 =?utf-8?B?L0t4ZkNPR3p0V0VaQUp0VGQ5T25PK3NOQysyZUxOVzVoL3VuN25vMHl1ckVx?=
 =?utf-8?B?ekxoY2FzRERzZGZlNjZnM3RZRWcyV1BmMVpQeU5TS3U1TWJEbWovai9oQlNM?=
 =?utf-8?B?N09KTE41dWNLQzFIdVJ3ZzlJd3ZRcmdsY2FrNWpUT1M0anp1UVo5WlQzU1Zk?=
 =?utf-8?B?eFcxVG1vWUVKRmhncDNaR3ExMEtUYmpwc0pSQUZ3amNoZzkvVlE5QVJuNG85?=
 =?utf-8?B?anpkQW5ORnlEQ3BkRGJZMXNROVpUdFFSZkxQcW8zSS9lNnk0Vi9CeUZpM0tX?=
 =?utf-8?B?OERkYzkwT21PNGFrU0d1NXoxemdXRFFpUGxSZTV4UUY4ZHVTVlFFZjl1d09I?=
 =?utf-8?B?cXdISDhOS0liMGthK3hZeUlWRVVNM3M4WFhmbW1ac3hiK3dZeUxQRml3by9G?=
 =?utf-8?B?ajJLWVQweVg0bnk2NXVwNWhUSFFEc0M0WmkwbFNkbHZObjdPZVZDTzBsTUd1?=
 =?utf-8?B?MGdkTGNUZWVPUkxhUzhYdEdIOFRDbnFNU2tKYjNmYVFDUzA2ckxlSmlwNUh2?=
 =?utf-8?B?NXlSWHBjN3V0LzV6MFZzbTJQTDk0N1JHMzlJMmNVMm1yNmVMY24xS0sxR1NU?=
 =?utf-8?B?VmdqYUFXSXFyOGFicWcwc1ZrQTc2cVFzcFQyOHVxU0s1djVTSkg0WWZIQWNW?=
 =?utf-8?Q?/zyJy3zxc3sgh132K+XApAdggmDBe85Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdYTkpwSjlpSmhzb0hkSXhxcFoyQ1lIRS95ak15NVFSNzF3VGIrWkthaGlB?=
 =?utf-8?B?SXcvUW9UbjY0MVNVdG91L3VGWFp6Y1QyQXQ5OThSSUhEbDZFa2lydWVtR3hN?=
 =?utf-8?B?dU1YT0RqMC91UWs4WklMTEtxSHhYSUp3UTNyaFdUMU03TEhLTGdsejRDRWhj?=
 =?utf-8?B?dkJ0SVFEUXFpeC9TWjNPZ0twaFlrU3VCYzRCcytoL2VoQUJNVWx6aS9EMTJT?=
 =?utf-8?B?TTRDWktOcko5U0tFSXNkTkgrdU4yK1hhYmxCR3BiRHdHNHc2NDJ5K3BxQ3pT?=
 =?utf-8?B?MHlsRFQ1RExIRlUyY3RocG15MjMyZUYzR0lTRWVOWVl4dVB0dTNlMURkOTdK?=
 =?utf-8?B?UDJwZGpLM0lwM1JnNklJK0o0bnlwdHlUL1k0bTNqS2laOERkNzQ3NWxIUEFt?=
 =?utf-8?B?Y3ZERzluNnArQzJkSkxERUtBUWl2clBHN1BNOTJ6SzdyT2hTQ0s3VURSUGda?=
 =?utf-8?B?MkUxcHdTZ0JsQ214QVk5R0QvMzdNbHRtZkh1cDhCTzRocUlxTk9FWElNVDVR?=
 =?utf-8?B?NldiTDh6R3k4T0prYTcxdHpZQUF2V0FPRHRIV3VpU1ZRUERMd0xmNkNHdVds?=
 =?utf-8?B?ZVZHR1A0QkFrdDZQYWpCemIrYXB6OFdoVVRkT0NwZkU1dTd1RWNuVU9mMkRx?=
 =?utf-8?B?Vll2TDhvT0lZQVdyRmxTS2FBS3ptY3JRcFN2TVoreGJUOHlVYkhMTDhzSnh2?=
 =?utf-8?B?d1Jtbm4xd1p1eUFBMGhEZmdrYmdkZ3NobXFTK1gxUHNSYU9NSzhwSDZwMTB1?=
 =?utf-8?B?MHBtenp4QlhQRExWSnhYMTJCcnJtNG40bWl4Ni9pb2hDUm1ZSVltd3ZXVmFv?=
 =?utf-8?B?eVRnOWJuSmRXSjhCRnFCbkk1QUxzbklzemIwUTRUOVppNzREY1RHUjlvOVFu?=
 =?utf-8?B?Wk1UcmgxYVFxeXVrZUFCSHdXb3I0SDVlWUdsd3BZRmVrdEpETk1iV3RwT3hT?=
 =?utf-8?B?UE9hdGlaOG1hUlVPWUpEUzRicEVOZTREOHFHZE9mT2lQclB5SWxIUHFPK3JT?=
 =?utf-8?B?WG00Zyt5ZnA1bXJtVXd3MGxQUFJCSkZ3RHdhd1ZjMlV0RHVZMk9xeTE2QnNy?=
 =?utf-8?B?U1hyL2N5SWQrMlZycnY0UGFSc2MvRmpJN2tpeElxZnpCTWlTMExJcng5MlA1?=
 =?utf-8?B?aVFrYTRmd3h4Y1RGWTlKZm95cFl5bEhXdnZCQWIvNzkwbnY4a2NzdHZIWDVi?=
 =?utf-8?B?T3RiNllaa2wzWDJPeEd5WnhodjlVbURHY1FwY2FjaE9oYkFnNWVQU3M4SGJW?=
 =?utf-8?B?Z2t4ZU0xVkorRTRBMXRZNHd2M2U1WHYzc3doT21Fa1YweExTdmlSc2dVdktv?=
 =?utf-8?B?azlac29DbE9JK1pyUm41MDhXamIxR0h0YnlLK2NnWUlxeWlkallhUXNYdXBY?=
 =?utf-8?B?WVp4NGhoSzhjL1ZGT3M0QzZGQXA3Yk4wRG9EY2huVlNwTjNQQ08vNHQ0Y04r?=
 =?utf-8?B?NkJISldhbTFtZm5FelFRNDUxRlZCRXJ4V3k2R2xuNW9vdWFkZ2FEaW1NcVdX?=
 =?utf-8?B?Wnc0L2Rya1hjb1lTNjdqNkdSejJBNGx5OHFEN0xhMFd0NkkxK3EvbHdWMkhM?=
 =?utf-8?B?RDhiL09uVm1XU2t1NDZmTmpReHAwS3JXa1ZoMzA0aGRGUjZmbC91Q3M4NGdn?=
 =?utf-8?B?alhjaHI3bE9Lc2U0d2h4aW5zVkFxTWJCN1dzejhtdXdoQ3NzWVNnNlE0QkVU?=
 =?utf-8?B?WjliWFR5VElERVdIV2ZzMjVDcGhZSjJsbXpwU1pwTzdQbHJUYXZYaWtsMFVI?=
 =?utf-8?B?c0g1RjgyRWhCV3Eyak1hUFpJNXRFbU9JVFg4TDZJQUJQaVEzYStSaGJhWVlV?=
 =?utf-8?B?OERQQTI5c0N0Ulg2N0M2TXJwYmhxdXJLNllMbkhoTGhpTGppUHhZUTVMRHJN?=
 =?utf-8?B?TmZray9TZlJ4L2doc3hQcWlFazRFQVJtZ0M0aWhrcDVUNlpiTEJUbXk0OHlI?=
 =?utf-8?B?TDFTY2tvRGdFaWRPNjI0NW5tWGMvVkJ4RmV6eHRsblJ6czJZc0NFaU42T1V6?=
 =?utf-8?B?Z0ZBeWNvNytUK3A0NVl0SlZ6OUxYTG9PcUwrNERhYndRQU1LeWpSNVRQV1RN?=
 =?utf-8?B?M0lOZmU4eHJPZ1lPQ1J3SFdDTE5iT2VPYTZ0T0ttQTlzcTVLazFCdE9CS28v?=
 =?utf-8?Q?DFkgkuzHz0mFQLIOSaA0IyXRy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f985993e-09d9-48f6-7bca-08de131ff814
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:08:36.2211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwSYATi1KMmAF1RxXHVC4cVK4KGfMXtBkQ9qJ5c6rWaOOutXSNn5fsEW6l85Ct0ZQtlNlrJ+jZscnY1bnqMOLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/24/2025 11:59 AM, Alex Deucher wrote:
> On Fri, Oct 24, 2025 at 12:21 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> [Why]
>> An `.notify_rlc_state` callback and wrappers for it were introduced
>> to support notifying the PMFW that the system is about to suspend.
>>
>> There are already callbacks for `set_mp1_state` which get called at
>> suspend though from `amdgpu_device_ip_suspend_phase2`.
> 
> This won't work.  PMFW needs to be notified that RLC is being turned
> off before the driver turns it off.  

Ah I see.

> I think the call in
> amdgpu_device_suspend() is superfluous (but someone should check S3),

Yeah; Antheas checked this and confirmed it is.

> but the important one is in smu_disable_dpms() since that is called
> right before we stop rlc.  I think something like the attached patches
> should do the trick.

Yeah those look good.  I'm respinning my unwind series for test 
feedback, I'll rebase on them.

> 
> Alex
> 
>>
>> [How]
>> Tear out all the notify_rlc_state callbacks and instead move the
>> Van Gogh specific code to a `set_mp1_state` callback.
>>
>> Cc: Robert Beckett <bob.beckett@collabora.com>
>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ----
>>   .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 -
>>   drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 18 ------------------
>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
>>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ----------
>>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 -----
>>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 ++++++++++++++++++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
>>   8 files changed, 18 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 3ffb9bb1ec0b..4dbdcb7b11e9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5281,10 +5281,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>>          if (amdgpu_sriov_vf(adev))
>>                  amdgpu_virt_release_full_gpu(adev, false);
>>
>> -       r = amdgpu_dpm_notify_rlc_state(adev, false);
>> -       if (r)
>> -               return r;
>> -
>>          return 0;
>>   }
>>
>> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> index 87814c2b526e..48846a3e4b7b 100644
>> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
>> @@ -523,7 +523,6 @@ struct amd_pm_funcs {
>>                                     struct dpm_clocks *clock_table);
>>          int (*get_smu_prv_buf_details)(void *handle, void **addr, size_t *size);
>>          void (*pm_compute_clocks)(void *handle);
>> -       int (*notify_rlc_state)(void *handle, bool en);
>>   };
>>
>>   struct metrics_table_header {
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> index 5d08dc3b7110..5c4d0eb198c4 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
>> @@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>>          return ret;
>>   }
>>
>> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
>> -{
>> -       int ret = 0;
>> -       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>> -
>> -       if (pp_funcs && pp_funcs->notify_rlc_state) {
>> -               mutex_lock(&adev->pm.mutex);
>> -
>> -               ret = pp_funcs->notify_rlc_state(
>> -                               adev->powerplay.pp_handle,
>> -                               en);
>> -
>> -               mutex_unlock(&adev->pm.mutex);
>> -       }
>> -
>> -       return ret;
>> -}
>> -
>>   int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>>   {
>>          const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> index 3bce74f8bb0a..c7ea29385682 100644
>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>> @@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
>>   int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>>                               enum pp_mp1_state mp1_state);
>>
>> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
>> -
>>   int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
>>
>>   int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> index 4317da6f7c38..10d42267085b 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>> @@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *smu)
>>                  }
>>          }
>>
>> -       /* Notify SMU RLC is going to be off, stop RLC and SMU interaction.
>> -        * otherwise SMU will hang while interacting with RLC if RLC is halted
>> -        * this is a WA for Vangogh asic which fix the SMU hang issue.
>> -        */
>> -       ret = smu_notify_rlc_state(smu, false);
>> -       if (ret) {
>> -               dev_err(adev->dev, "Fail to notify rlc status!\n");
>> -               return ret;
>> -       }
>> -
>>          if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2) &&
>>              !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
>>              !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> index c48028abc8c4..361e09f20ead 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
>> @@ -1496,11 +1496,6 @@ struct pptable_funcs {
>>           */
>>          int (*set_mall_enable)(struct smu_context *smu);
>>
>> -       /**
>> -        * @notify_rlc_state: Notify RLC power state to SMU.
>> -        */
>> -       int (*notify_rlc_state)(struct smu_context *smu, bool en);
>> -
>>          /**
>>           * @is_asic_wbrf_supported: check whether PMFW supports the wbrf feature
>>           */
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> index 53579208cffb..3dc1919b8c64 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
>> @@ -2208,6 +2208,23 @@ static int vangogh_notify_rlc_state(struct smu_context *smu, bool en)
>>          return ret;
>>   }
>>
>> +static int vangogh_set_mp1_state(struct smu_context *smu,
>> +                                enum pp_mp1_state mp1_state)
>> +{
>> +       int ret;
>> +
>> +       switch (mp1_state) {
>> +       case PP_MP1_STATE_UNLOAD:
>> +               ret = vangogh_notify_rlc_state(smu, false);
>> +               break;
>> +       default:
>> +               /* Ignore others */
>> +               ret = 0;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>   static int vangogh_post_smu_init(struct smu_context *smu)
>>   {
>>          struct amdgpu_device *adev = smu->adev;
>> @@ -2524,7 +2541,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>>          .print_clk_levels = vangogh_common_print_clk_levels,
>>          .set_default_dpm_table = vangogh_set_default_dpm_tables,
>>          .set_fine_grain_gfx_freq_parameters = vangogh_set_fine_grain_gfx_freq_parameters,
>> -       .notify_rlc_state = vangogh_notify_rlc_state,
>> +       .set_mp1_state = vangogh_set_mp1_state,
>>          .feature_is_enabled = smu_cmn_feature_is_enabled,
>>          .set_power_profile_mode = vangogh_set_power_profile_mode,
>>          .get_power_profile_mode = vangogh_get_power_profile_mode,
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
>> index c09ecf1a68a0..b9976313e741 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
>> @@ -96,7 +96,6 @@
>>   #define smu_get_default_config_table_settings(smu, config_table)       smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_table)
>>   #define smu_set_config_table(smu, config_table)                                smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
>>   #define smu_init_pptable_microcode(smu)                                        smu_ppt_funcs(init_pptable_microcode, 0, smu)
>> -#define smu_notify_rlc_state(smu, en)                                  smu_ppt_funcs(notify_rlc_state, 0, smu, en)
>>   #define smu_is_asic_wbrf_supported(smu)                        smu_ppt_funcs(is_asic_wbrf_supported, false, smu)
>>   #define smu_enable_uclk_shadow(smu, enable)            smu_ppt_funcs(enable_uclk_shadow, 0, smu, enable)
>>   #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)            smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range)
>> --
>> 2.49.0
>>

