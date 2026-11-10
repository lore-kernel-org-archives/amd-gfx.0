Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837BF606A33D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bkMDhsL0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF9D10F63B;
	Tue, 10 Nov 2026 12:25:04 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7CE10F63B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 12:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWDdPIiqE0Zemv4WI8zajfx3sVJsvPo4pUpAZPq0uFFFzvyCm/HQ+T62zREZEkerEVgxo0E5BCm0Wj6WzzPgi/VEYKm6W51vOo6lj9Li0VR57f2luRXsZ8cl5Ph3ImMW1iE6iet1lxDxBMDWPrP6H/mVNLxPfIieWmR8xVeDSFmrPxs9R7JVMw65H8G3dnmsGAguoPBHxMPvP/+ZxQnhjMXe1955lWOSmg7tQZbDuVydPIXKfQly386vh83iTJXJztkPzsxJANfLzXpyxNWl/lP4R0s7kg7+bIPbBCR6TvX8UcNS4+VwxK543flTO1neknhIpGzuXorjThDwJ47NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eNSNitRSNrLel70CZFjYqQvpLSv4wT1uhmljdavkw8=;
 b=Yx7FZqD7VkRyjuN1fu47JTQbzoT5T9pQXIgAu+0GuIRwY62t66BO1HWeuKF5wOVD0O7SZTS2BrQvmsVP8FLxKLwVunEpXmlMgYNkbqL+TWjlFx1odvCLEBNV2ip42q4gmLuBfdTam0pOx6apIk9ke6Qo2JD8t52a0EffNobJJ52vAhA/meDDiuJLIgejg+CGVqMN9+2QQljN997bk+ja1VoWNlZvhVudvEHykued8wh/FKI16jXLxcW4hqgz5ft6dpq1laq85l/ZQDlss8oz6B0ub9aHVsg9dqx8LbpEgSpONp/fSKgtnBVxSB+s3S8SSDgvuOwooQbsCwwDzjn/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eNSNitRSNrLel70CZFjYqQvpLSv4wT1uhmljdavkw8=;
 b=bkMDhsL0cdrRk2PRrQSs86quk/juFU0jqEzVO1YP84JtCe9bXr/JZDSMv1BvlzE637oqBDnuXR+0I4zlUBm/LoLgPdtYQUiKWFSULS4TMLWcLqm3VahoNlekR3b8twKZpSJNLPRiqZweecj0IFyrQQ8LdkmF5pQcXw2oCiOQox8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 12:24:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 12:24:48 +0000
Message-ID: <405d0005-fcc0-4cc0-a17d-90c5fbc4de4d@amd.com>
Date: Tue, 10 Nov 2026 13:24:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/vm: free pte update job on error
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Benjamin Cheng <benjamin.cheng@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261105210020.3852328-1-benjamin.cheng@amd.com>
 <20261105210020.3852328-2-benjamin.cheng@amd.com>
 <de2d1b55-bfad-47bd-843d-2ce98006103d@amd.com>
 <avLyHUZ4NMWMQ5U7@quatroqueijos.cascardo.eti.br>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <avLyHUZ4NMWMQ5U7@quatroqueijos.cascardo.eti.br>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 85313b16-1ad4-4506-f84d-08df3f259c6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003|10067099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261021121427099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: PHvOl9VBOY0fjIwPb5SqwtG9UXwrVYQO76svgC0zUup8tDNwm9RNuBIwGFrrFvaF8L65qtSryh8yhNZ3S+S1lhmpFow4Gfg6K9gRZPgM7gIz8vI5u2og73mo3EG6f/bfVyiQaRynIxcOTwxDbYgxptuND9MnU2VqsyudzyVmf0rIELNQUQMRux2egv3fqYCxgF/cYC2oYFceUD2uMvD3/RBS8k2eadixrJn8dntodcG3CjESotYLH4qiGn7I6oliyMuuEXhNftTQ6ug+DtlyrEBbOMSOCt+kSr16W8H7h+f7jD5wQhw202PWJtCl8Ka2Zejbat5w87lm1Mr+JRrG8pySol/E/qgE8B+C4u85r84sgnLksgiqcMQczULVgXtazXwSDPBpiXNCbIMI6/rDi/mygeW3szqIch+vZqZ5nKsY5TeBR2tF8yVyObwtbRk9Iz2+HFuUqiDPpD7FloeXRWTsFcnOnfSeebTiyjhI5oSogroUfWPwADs/DrPkHUDrlS8FvV4YdB90IBEywO1XGWGsW1zP3RoEmUzxgHVxU3/j8LR7WnCFJ4ruNimRp9/UqUxHB9rVYGcgaufxKvgZzi9FyCyiYMuNuo83BDGt9SmoDqfgWSej7JgzCKcuIvwh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022105027099003)(261022075727099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXp2Z3pIc3V3bm9qaEpoYng2ZUJxS0RuYUtmVUpKOHBCZVRqamFvRUtUdkZr?=
 =?utf-8?B?ZVBWR0tPRG9sRGRpSFJWQ2h1R1BEa2VNbE5mYXMwa05pS0JPNEg5QU43M210?=
 =?utf-8?B?OFhTazMxQ29sMHJlZFE2Nk1oVVg5Yzl6RmlweGo5Yjk0TkdyZC82R2wyN3hH?=
 =?utf-8?B?L0NLR0JkRGV6cWhTSGFGMlBYN2FKVTZGR0VONkJoYkUzVUVkNkNGYUt4VjBl?=
 =?utf-8?B?VUlGMStvNDZiYVl4WTZnMnJTbFJvYjkyUm5ZZUdnTXNVd0U3WUF6SWsvTVM4?=
 =?utf-8?B?TU1US2FXVUNnSlFLWHZIMTdJblI0b3VmUmZ4eUU3R2pQSzJQWFJTZ0EyeVBH?=
 =?utf-8?B?UmNGM2tBeDlHSEJFREsxY0x4bTBSMlhyejRrUlZaWUEyMzF3UG1Vd00yL1RQ?=
 =?utf-8?B?cmJhcXlkMlpzS3VYSTVrVlQ0YUNaT2s1Mnk2ZDNoQUIzQy9GSGNTZzE1T1dP?=
 =?utf-8?B?bGttOTQ3a2gyaGZHcXNFdHkrM0kvSHk0UWhiV1N2YlZIRUxBMlBnSzBpLy9w?=
 =?utf-8?B?WkJTRytoc3VFaWFWcWlQYUZxcG5lZW1Zc2FBdGQrMld0Y1puN1hYTm5IYk9m?=
 =?utf-8?B?QUkzeTd1L1BuYlJZQ0tKdXB6TzZYL2QxZzhHY2FkQThSK1pIL0VST2VNZ0ky?=
 =?utf-8?B?MUN6dXdZQ0JjRmlOYzhKNEVGL1h4WFBSYlprUGlhc1kwT0I0MTE3Z29xRGVz?=
 =?utf-8?B?UFltL09HRSszMlRkNUhBdE9mcWFQRXhnbXp3ZHNVSTFyN3hzK0VLN2p3SDQr?=
 =?utf-8?B?dFJFOHA2S0kyVkVhdlhyTjFSWDB1b2pyWmJzQStmMXN5MnFJeVNFb2xRdm1K?=
 =?utf-8?B?MWl2Zk15S256VHVxU1o0NUM4YXNOQjBkRGVzdm1kY0poZ1JhUGR6YnFBV3Qz?=
 =?utf-8?B?SVNEai9QV2Y2ak1Wc2lDcXViQnJEOGdMSXhPeG9lRVJrbUkyWVdLYWZUSDVo?=
 =?utf-8?B?MU9EN2hCODFOOFdnbFI3cFBsRWZYdzM3YW1xYnV2Y0huQ2xHVFpLcFBDY0Ji?=
 =?utf-8?B?aXllY0l0KzRPN0E4SDRjd1VNb0JWNStsdldTTGpZS2hLQWlXc3l6ZU81OGtr?=
 =?utf-8?B?VHF4QTMzODBud2tWWmNKSGtrVXR2am1oVW1GRWxLQVlJWXlJVDVac05rMWdR?=
 =?utf-8?B?KzZCMlBYY0Q5eFNYU2pQM0xmU3dEaE1WbEpBcE4rQUFyTU5Hbmg1NmFBRGFm?=
 =?utf-8?B?aVdIRTlIK2VXeDJldEtiRXhHTEVsWUtpdEdhYUE2T0QxWFRtYzB1aFA3N2Vy?=
 =?utf-8?B?ejFsVXpDRDJxZThKZktZNzJPTm5kMTAwSWtGcHNHTjZHRVc3amxVVTdzVFJt?=
 =?utf-8?B?VTNwM1VrRVhwa1h5c0VZdTNvV282U2NDVlljbWl5R2I1TlROUDJvRnQ2QW9I?=
 =?utf-8?B?b25PM1Z2KzZTa2l0dG9aVkUvdUk0ck42UUYxTXZhK3I3REIvL3Z4OHRrYXNi?=
 =?utf-8?B?MmI3dHRXTUVteDQ3cnVxS0xvQ01yMi8yUzY3TnQxRDRSakprcHN6alJBVU5N?=
 =?utf-8?B?eVRQd0pBZ2VUODNUNEx6ZWZuVkF0NFFHdE85RFJjTUxOT1p0dGx6cXdRb0pH?=
 =?utf-8?B?ZklHeHZMNll2Qlk5QXRDRHR4WFdwcXFyMFgzRDl3blo1aU8raFNBSkdSRFhF?=
 =?utf-8?B?R1ZwNWh0b0dSeGNqc2hYRHplTW0wM3dtMkpnMWZKZGNNTldOS3h6Wm13eUYy?=
 =?utf-8?B?OHp3bVArWVpBR0ora0NLVk45Vm0rVExWdnJudUFxRlB0WWhtMHNhY2VKeTRZ?=
 =?utf-8?B?Q2hjVHVNKzVGNk5VcEVxQkI5NHlNYmp6RzdtQXc0TmVkZGU4NklOTkVrZ2Rv?=
 =?utf-8?B?ditiS0FWL3lwL3Nua2tiWXp1OEJ6NHhkb29idXk0eG40NXFMWXp3YVpzOFBx?=
 =?utf-8?B?VGJjQVgyUU1IMFRQb2JhYW0xWjRmSkZlbzJDUmR4NUkyOE9scUs5djNLQWU5?=
 =?utf-8?B?Y3JmanpVK0dQUTZVNGpDRkt2NHlKWFhsaDk3MFQzMnVmeU52UnM1R1MyYWFL?=
 =?utf-8?B?TEZuM1lhVThocEFDMm1VRlZaTzNha3cyRXRneTNpNFN5TSthN2RIcDJtdTNU?=
 =?utf-8?B?WVdjQjNNVWgvWTFKOGJwM3lGRDVWdS9VQThwSi9sNnlUTzdNdENuMXQxZmY3?=
 =?utf-8?B?S1drSmkwVUZtWTdmdVdZWldTZ3JUYURtMjczdTVCOTdwRFdIWHU5V0NBd0Fk?=
 =?utf-8?B?R3R2bjFORnJZakVKa3o3TmdmY056UnpncCtEb04va3VKRHo4bDhldER1RmNz?=
 =?utf-8?B?RUF6TnFkeHlNbWpOWk12aGtvbjFjL2dzV3Jpbm1sYTFyclhoejFqWWJoaGlV?=
 =?utf-8?Q?Zv4sBuLONDpBbZtVmW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85313b16-1ad4-4506-f84d-08df3f259c6b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 12:24:48.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9gbxdnKX8rhWKipVCxFUrMbimRVDbGjU4M6Ej2El67uj8dFp3OhzBbB/SelDeF3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 11:29, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Nov 06, 2026 at 09:55:36AM +0100, Christian König wrote:
>> On 11/5/26 22:00, Benjamin Cheng wrote:
...
> 
> Hey, Christian.
> 
> I have been looking at this and trying to find out the best shape of the vm
> hooks and other helpers we might want to introduce here.
> 
> But first I tried to work on a reproducer and I realized that we have two
> situations:
> 
> 1) In the case of DRM, the BO should be locked, so there should not be any
> eviction of move, so the entries in the IB should still be valid.

Correct, but that is actually the easy case. Updates to the VA space through the DRM render node should always look the VM root PD and so should be synchronized.

> 2) In the case of SVM, there is the prange lock. Does it still protect the
> range, and, then, would the entries be still valid?

Nope, that is an often made mistake.

MMU notifier update which invalidate a certain VA address range can happen with quite a bunch of different locks held.

But in general PTE updates are opportunistic and we can only use the sequence number while holding the VM critical section lock to determine if the PTE entries are still valid or not.

> Is this related to what you propose at [1], where you mention:
> 
> "
> This allows to remove the buggy SVM range lock, but that's not part of
> this patch set.
> "

Yes exactly that.

The whole idea of the SVM range lock was to prevent that race condition, but that approach doesn't work because you can only allocate minimal amount of memory while holding that lock. So allocating page tables is an absolutely no-go.

That's also the reason why unmap operations can't fail and MMU notifier can't return an error code.

Regards,
Christian.

> 
> Please, let me know if I am missing something or am working with the wrong
> assumptions.
> 
> Thanks.
> Cascardo.
> 
> [1] https://lore.kernel.org/amd-gfx/20260930133315.12270-7-christian.koenig@amd.com/
