Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9C2C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BF210E4A5;
	Wed,  2 Sep 2026 13:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vFyTM1fZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EAC10E4A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2REwON2ndM2n7rMWRR3O1KextEOm+mh2MVSAVVZcpubvmz6Ae71ePXJCFDhqiM/0Y2xH5XgYRtB6OHGU3N23fuYFiM/UJpTvAj61Dc+E97Zj0lrUEfoxFPW3vtZqwj9Ove0C1DHd83msgzRE7x8VL6hsrf8eDkVbkMPuL0QkAbzytqBTzvnzj7IoOxFe9tfUbFlb/FJ5Sxg/xGSh86tgCRBkbW4W+pUo7I4DrDzeMUbJ3Eb0etpeBKBlx7R+TEfXonZteKdXlAkwi/7xiuy3NDuPaEd69DRS/12Wc/z0ImG/YtRJh6d5NGmzJ+1sGRedoTJrx6RO7up3wPrnkvEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0IvGs3tuCGj9hYXrX6rKzj1vnqu/1d/6kyf3/R91xo=;
 b=BoddUQ7OZJ+oLk2URWcM2sFsKruk50gFGG4LQvv4rQi10o9suPV39WacOsAk+go1QkkdvGXV7B/+qNZNiSpCw2PqmzZ5onGzDE7nROIjJawX4tEyZvsR8M9TgxUJ+3HKztGWUiiag90Kv/vzvrJA9vauQkRpzMCnYX2XEpN0PllhDm33SWoUdcKqVpaVOCy3SUeMcVLx2lUKQ303fyphFRq7xptse8N6ft/P5p4cUjnTl/9NhpC4v0WVqjG/kmYc1/Q8fvqTWIBhsXkMluNXRhic/7bKwusf2IjVUhAxXoC8EPvWzvIyFjf/GNDLORr3KuOimNGI6M1Li0WQci2UyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0IvGs3tuCGj9hYXrX6rKzj1vnqu/1d/6kyf3/R91xo=;
 b=vFyTM1fZfljbNPZjAtwYPT+5tesuq7Kq275m25B9vh/TosaDnWv004U2y7fNZaWIAn33UorhOdWcGFvi1RAVgweHMvBWItWG3FNpzxIk3tg6KTJn4mFyM9Vm4J4r/bE/B7HJ/b40SV9y6B5pTPlZhi/7/sQsS0/AtaCcFQijPKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:57:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 13:57:16 +0000
Message-ID: <937d47e3-596b-4ab4-bb1f-4f85e5ad9cb8@amd.com>
Date: Wed, 2 Sep 2026 15:57:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 00/31] Rework GPU TLB invalidation
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <05e8a019-903c-4249-9c82-11dce0403aea@amd.com>
 <CADnq5_PELtGDm5MkC+hiGLviAEtUufjYVzCTaA2Es-NPJsmAxA@mail.gmail.com>
 <db022549-86b8-43a3-9b8e-b46bcdee2033@amd.com>
 <CADnq5_Na=0pvEjoCC=ONR2iOFc745inQBrFgxMuZ5prwXpV5KA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Na=0pvEjoCC=ONR2iOFc745inQBrFgxMuZ5prwXpV5KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fb1360-3f8e-43db-c750-08df08fa189f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nIijZM/Gq2WHUfUqFeLMr+YgBS/941jEQ4WhB7ux8J7vjC/p0foixFYSX6dAxYebVpTMOP+IjRWeXSuntZSoUtlzwXbkuuGkiL0yCk0voX4DaqUtn1nkwDHniHAS9k72ebYuY4p/0hwgWcVImDEZOpzV4F4Pi2s/2OndDjH6d42Md5j7NRY8p8eYgwOLV+T3/f3iOlGrhJDb3U5qck6ayfKQdew0HPsfz+1WPkNaJUp5De8b8/EJ7rZgA2mGmJmebE9f14GhHBbhQo7Pa5vio9tjhwCFKnC4X7Nehc9DlIzL0Bkibob8uw2FR61x6Dj1Iy+b00ltkpy1IHuqFrPJbQBKDpbvAUIMCXArt1hGEqvfQNL6NLOsu9EE+rfnc8UlisdMryi57KHszmhnNfJ0sAqR4zFbJdVe1f4FPEIflsGsPH2TUX0WcS/NUszG2Oz2Azhva4uN49QJ2axV9Hpnmd1gh81DdxYg+zxGBsZ8b/vTHhIJnKLYEBMpRb20nKAAsDKlPcYZOg9UqesAgv1bcn6CqTRleoJIVtEt1TF1onYw8z7jn4+mWKCARjp1xR20VtkW4sjQmuLSHhozM0uiMkXIWz7zWPYzDoFBY5xhXOLqzbDyoz2c+8JEgJK9p2j3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE80a3pHaDQ2bjZEMnN4NTVIMWZOaitiOGlzNHNUb1VCVU1iTnZQc2RjNFRq?=
 =?utf-8?B?Yjc0NG9uc09tWFBmQU0vOXd0bDBWbVdML2k4dHNRRmtGdnZ4aEdUOWxNcmtM?=
 =?utf-8?B?QjFtYm01anZpcjA5aXIyWEM2djZVOUlqVHdIU1BZM1d3Q0hrTEdSUWxja1Vr?=
 =?utf-8?B?bGpXOS9VQS9DM3RNSXYzZnhReHpoR0FjS1lUeEgyUGdaaVlMRFNQVFhxeVpO?=
 =?utf-8?B?enpWcVd6TXpyUVVoOUk5dVUvNkZMMTg4NVl1bDNSQndleDdQSnhZQVNOdXJx?=
 =?utf-8?B?Z21Jb1VrYlJtWFJQMDZDSm5BSlpML0hxMlUva3RaN2pYbnlJRmNibDRpMTdU?=
 =?utf-8?B?YlBoNnlKYU9yTmRCNkZxd0d0QWhtRGtHM1pYcnpFa0hGeVNQS0hKQ0o4ZGVh?=
 =?utf-8?B?U0MyQ1FFTFFvNEhLNzVFcWxqMndtWHVSMndYN2QxUW9vS3p6TXhaUjZjb0E1?=
 =?utf-8?B?ZEdKTy9JcmdaVEZKUXJqbjliTGhiUk5vREpBWWo1cTNEcjZuSEtLeXlQdTBz?=
 =?utf-8?B?RzVjMjJXOEJwK21ZVS83VnFiN29PTVE4b3dBbnk3TmFHZ3Zyd0Nxd05HeWdj?=
 =?utf-8?B?NFJtUVluOVRLRXJuRk9La0pDT2c4ZkxEL2c1UDhUbUI3QTVpeGxDYmZXWXJY?=
 =?utf-8?B?RXlsaVZzODU2NWpBWU54WG8zb0N5N1RaTjBocUpOT3JDby9SMSt0dnBRZkNW?=
 =?utf-8?B?T0Vad252V0h0WlduRVNYSnpGVkM2OXorRUxValJWeDRTUXF5YTZQS3lMV2lI?=
 =?utf-8?B?ZXlxeTEwK0JwUVBHeVNjQ3NNVk5oL2xNMzJ4eG8rTVJUWElkejV0bUlBTUFE?=
 =?utf-8?B?cEJXdy9YcjZ2OHBlaks5M3ZTcVpIRWN2ZTVwS2FocWZ0c1RYLzdZVERsUWpK?=
 =?utf-8?B?cDc2RktxR1RHMzBKaTZSdEdlQmQ4dmZIYmJaSmcxRkRFYkhuZUdDbVRvT05E?=
 =?utf-8?B?N3BiaHpBSjNsR0R5UHpXVWdFYW5qWGY5YTYwSTMzT3Ewak5oOEFkMFZIUkdJ?=
 =?utf-8?B?ZmJ6MzV4QjUxRG1FZmpjSjVHYTVjNHV4c0pWanZUNzlxZGFvMEx6R04rYVZx?=
 =?utf-8?B?aHh1dFg4MzJMaXB6M3F4M0dUd1VrQmY1L3JPRnlyVVh5c2ZtTWg3anpLM2lD?=
 =?utf-8?B?S045RHFRNUdHOWxTZkFtQWZrdkVmbElTR0FEcnpLOHQ1WnVvOFl3WWtyYXF2?=
 =?utf-8?B?ZmhhcDhTaENhL2YwUkUrSGVqbmhlMFBYQVc5dXU3NjNHbGRIV1M1M1RwaGNB?=
 =?utf-8?B?bEVhM3dRWmNaYXV0dVNoeDB2eG9jdFRmR3FpV2RKdnhQaEJRS0U4WG1IVS91?=
 =?utf-8?B?cnZOWnRKVHM1YkxiU1lMK2hIVnRSRjVnS0FDTnBuM09IdTJ4S250STk0b2hS?=
 =?utf-8?B?bVc3V080eURIOU9sRytKNWxReDRhdnU3NWJ1L2xWcC92SFNncmJpK1JQSk52?=
 =?utf-8?B?QjJkU1JCU3pwcW4va3prSzFwUjhKM1JvbTA1UkRONkVVZXNVcDM3L2JoSVNH?=
 =?utf-8?B?YktMQmRmTXdOYXNEQ2FSOFhhMkUzaUJhZnp3NytOc21UV2lqWFl4dWlmT2ZP?=
 =?utf-8?B?aE1QamNTemd2WktLdWhoeUcvWjEvQ1lPZFdFV0tIR1FZV2N6dFBOdHFoWG10?=
 =?utf-8?B?SS9idEszK3EzZ2p4UzhSenlncjI1dmNFcytqT3hGRFV5a3ZIdkI2RGt1NVNG?=
 =?utf-8?B?NDZZaGUrMC9DY1ZrdnhMSmpNRmNHTU1rU0lWMCsxTy91MHZ6TEpMN3pscTcr?=
 =?utf-8?B?ejhOZHJDT1BRMzFDUCtud25tZ2N0bGhjcHkwYnRtMXFaaS9UclQ1N0J1QTFI?=
 =?utf-8?B?eHo5enFYZEpNU3F4cjFzdFpYZFNyeGpET0d5QkZ5TElKMmxvN3dLZndNR1lN?=
 =?utf-8?B?Z2VLSFU0eVZkQnBYY1Q0dXZiVXV4RElPV1NveXJXMzAxT3dkTnZnRUJ3aU5P?=
 =?utf-8?B?Vmp2bytEbEJ1dDhnSS9VRERxYTRuREtkVnBxbjBCcXhjdnkyU0NaMDR3QjdD?=
 =?utf-8?B?M3FpV2J0c1ZrQVhQL2tQdCs0dlZpWFVuQlFYZzJLeTh2cWJkSmlOR21NcVY3?=
 =?utf-8?B?blBaUjU3VHNnLzdXRFJuUWlrNHBoQkx5QTJ1OFZOcU4yTmlnY2ZubEd1cW02?=
 =?utf-8?B?UkpsVU9wdUhHdmxhbHV6QlAvOW9XUS9aNlNvU1NuMFJwV085OW5mKzlWYjJO?=
 =?utf-8?B?T29TbGpheHpGMXlwODBBMFlGWEt1c1MvVHNLYjA2WEhNRUg4Nm1JTGdSVGFs?=
 =?utf-8?B?dS9WUG9sTjVZSGtCUlBFZm1uY3Q0RkdzS0NMMzVaNHo2TTVKNHA0TDN6Z3JI?=
 =?utf-8?Q?d6F/wFwXSpRcmKPCh0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb1360-3f8e-43db-c750-08df08fa189f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:57:16.0354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOzagI6xcTx+OFP56mmQVhynKG1uRtyPYNmXTj+YdypMAlIFGX3O06s3AlAoaB3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
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

On 9/2/26 15:25, Alex Deucher wrote:
> On Wed, Sep 2, 2026 at 9:20 AM Christian König <christian.koenig@amd.com> wrote:
>>
>> On 9/2/26 15:06, Alex Deucher wrote:
>>> On Wed, Sep 2, 2026 at 3:25 AM Christian König <christian.koenig@amd.com> wrote:
>>>>
>>>> On 9/1/26 22:10, Alex Deucher wrote:
>>>>> GMC 9-12 use KIQ or MES for TLB invalidations to avoid using MMIO which would
>>>>> require disallowing GFXOFF.  KIQ and MES are management queues however and if
>>>>> they hang, they cannot be recovered by a queue reset since they are the
>>>>> mechanisms which handle queue resets.  Since using KIQ or MES will exit GFXOFF
>>>>> anyway, explicitly disallow it on the MMIO path and use that. Next, switch to
>>>>> using SDMA for TLB invalidations.  SDMA 4.4.x and newer have special packets
>>>>> specifically for this purpose.
>>>>
>>>> That packet was just introduced to work around SRIOV issues and proved to cause stability issues as well.
>>>>
>>>
>>> It was introduced because of gfxoff and having to toggle it to use
>>> MMIO.
>>
>> No, that was completely unrelated to GFXOFF. This also applies to HW where the SDMA is not even in the GFX domain.
>>
>> The problem was the SRIOV could interrupt the SDMA while it waited for the ACK and when the VF was scheduled in again the ACK bit was resetted.
>>
>> So a single packet was introduced which couldn't be interrupted by the hypervisor.
>>
>>> WIndows uses SDMA pretty much exclusively for TLB
>>> invalidations.  It's also what the memory hubs team recommends.
>>
>> That is rather interesting.
>>>> Since Arun now found that on basically all Navi generations the SDMA can hang while doing a TLB invalidation I have to clearly NAK this approach.
>>>>
>>>> In the long run we should do the TLB invalidations on newer HW completely with the MES, the SDMA was always just a workaround we should not push forward.
>>>>
>>>
>>> Well KIQ and MES also seem to be problematic as well.  See the thread
>>> from Denis about KIQ and his renoir system. There are also various
>>> reports of MES timeouts doing TLB invalidations.
>>
>> The MES is the only instance which knows the process to VMID mapping for user queues.
>>
>> The hack to read out the PASID->VMID mapping register directly from the IH is not really something we can use in the future.
>>
>> So the plan was to move all of that into MES in the near term. IIRC the MES even added a new packet for that.
> 
> Sure, this patch set retains the use of MES for pasid invalidation
> where it's supported (navi4x and newer with new enough firmware). We
> could try and get the new packet added to gfx11 MES as well, but then
> there is still gfx9 and 10 which still use KIQ.

Navi 1x already uses the SDMA for TLB invalidations to work around a HW bug. We could trivially enable that for Navi 2x as well.

My take is that when the MES doesn't work reliable for VMID specific invalidation (or rather VMID 0 TLB invalidations since we don't use that for anything else on Navi with kernel queues) then it won't work reliable for PASID based invalidations either.

For GFX9 or rather Vega and MI* products I never heard that they had a problem with KIQ based invalidation and we have a *lot* of those systems in production.

For MI* products switching to the SDMA pretty much sounds like a no-go to me without very extensive testing, especially the KFD/SVM implementation will most likely go boom with that because some HW generations still use the VMID->PASID mapping read out hack.

Switching to the SDMA sounds to my like hiding problems without actually fixing them.

BTW Denis Pisarev reported this morning that his symptoms are gone after updating FW versions.

Regards,
Christian.

> 
> Alex
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Alex
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> If SDMA hangs while doing the invalidation for
>>>>> some reason, it's easier to reset the SDMA queue than KIQ or MES.  Finally,
>>>>> most of the TLB invalidation code between GMC 9 through 12 was identical, so
>>>>> move it to common GMC helpers and remove the IP specific code.  If the SMDA
>>>>> and MMIO pathes prove to be stable, the KIQ pathes can be removed in the future
>>>>> to further simplify things. SDMA 4.x could also be updated to support PASID
>>>>> invalidation via SDMA using either the new packet (SDMA 4.4.x) or via
>>>>> REG_WRITE/REG_WAIT packets (SDMA 4.0.x).
>>>>>
>>>>> Code is available on this branch as well:
>>>>> https://gitlab.freedesktop.org/agd5f/linux/-/commits/tlb_inv_rework?ref_type=heads
>>>>>
>>>>> V2:
>>>>> - Add missing hub callbacks in gmc9 hubs
>>>>>
>>>>> Alex Deucher (31):
>>>>>   drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
>>>>>   drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
>>>>>   drm/amdgpu/gmc11: disallow gfxoff around TLB flushes
>>>>>   drm/amdgpu/gmc12: disallow gfxoff around TLB flushes
>>>>>   drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
>>>>>   drm/amdgpu: add a gmc flag for using MMIO for TLB flush
>>>>>   drm/amdgpu/gmc9: use MMIO for TLB flushes
>>>>>   drm/amdgpu/gmc10: use MMIO for TLB flushes
>>>>>   drm/amdgpu/gmc11: use MMIO for TLB flushes
>>>>>   drm/amdgpu/gmc12: use MMIO for TLB flushes
>>>>>   drm/amdgpu: add a buffer funcs callback for TLB invalidation
>>>>>   drm/amdgpu/sdma5.0: add tlb invalidation buffer func callback
>>>>>   drm/amdgpu/sdma5.2: add tlb invalidation buffer func callback
>>>>>   drm/amdgpu/sdma6: add tlb invalidation buffer func callback
>>>>>   drm/amdgpu/sdma7: add tlb invalidation buffer func callback
>>>>>   drm/amdgpu: simplify amdgpu_gmc_flush_gpu_tlb()
>>>>>   drm/amdgpu: add tlb invalidation method enum
>>>>>   drm/amdgpu: plumb tlb inv method in amdgpu_gmc_flush_gpu_tlb_gart()
>>>>>   drm/amdgpu: uplevel reset check in amdgpu_gmc_flush_gpu_tlb_gart()
>>>>>   drm/amdgpu/gmc: add new callback to lookup vmid to pasid mapping
>>>>>   drm/amdgpu: add a gmc callback for the inv semaphore
>>>>>   drm/amdgpu/gmc: rework pasid flushing
>>>>>   drm/amdgpu/gmc9: use SDMA for gart TLB invalidation
>>>>>   drm/amdgpu/gmc10: use SDMA for gart TLB invalidation
>>>>>   drm/amdgpu/gmc11: use SDMA for gart TLB invalidation
>>>>>   drm/amdgpu/gmc12: use SDMA for gart TLB invalidation
>>>>>   drm/amdgpu/gmc10: use SDMA for pasid TLB invalidation
>>>>>   drm/amdgpu/gmc11: use SDMA for pasid TLB invalidation
>>>>>   drm/amdgpu/gmc12: use MES or SDMA for pasid TLB invalidation
>>>>>   drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
>>>>>   drm/amdgpu/gmc: add helpers for various tlb inv functions
>>>>>
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c |   2 +-
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 486 +++++++++++++++++++----
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  33 +-
>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  18 +
>>>>>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |   2 +
>>>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c |  33 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  33 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 202 +---------
>>>>>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   | 207 +---------
>>>>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   | 250 ++----------
>>>>>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c   | 225 +----------
>>>>>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 135 ++-----
>>>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |   4 +
>>>>>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c   |   4 +
>>>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  |  33 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  |  32 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  |  32 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  |  32 ++
>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  49 +++
>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  49 +++
>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  49 +++
>>>>>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  48 +++
>>>>>  22 files changed, 943 insertions(+), 1015 deletions(-)
>>>>>
>>>>
>>

