Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB62C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 08:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053D510E452;
	Tue, 18 Mar 2025 08:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qIR1IdPQ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8144D10E452
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 08:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+bSN7FDjkQypAnFtdvcFs9GsqKJMbmsrIQ8QBcdfna5DBrtmXCBoWPs78E/6Xg6ogwM5aVuWlTyAgxl6d/WlwBw2s2W5kqrhKFavuEHKMAE2hLWzCmcuscnefiViiMVRlegJywe5oZjq64zwgn48PEJIxn/GMHOHNKqDXyws2zcfZagdW5CY96MJ95VgqOmn1GtijeKtbj3NawR5xWudR2WUhNpIsK5XpP27CCd1bH7zgs/EWKQX/AM0QsY4+sXIp5VRKSqOqIJ7acE6qtwLtvEfXqQNgJaMrmQ4qNgWRMwxLkZsBOwp+JWDkkwT6Wna8q3tscSAAYkQ54Lu/Jxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqAURrV5FDRgi7lXdY5SCS7w84emh+GjZjHlT1lwdzw=;
 b=CqSIitBQl5ny6HgNsM0EQV9NVVWveFZK96RnumohT5+Mpe1D0JLAFaNArW4D8pfOzDw27bqAZa8qelqE6HAvHZVd6I+hy3c8BYIs4ld5E4LBm3X0vwdccR10gQrV0UBtEoj3NTZ7bIO18XHj/YeYoIheWHzLBs4IeXG/ntfLJ1maKQmSi8vtU3BwKnPxfnFZ5kY+wgMPAFmurB7NsNbLnf6yyusLtVlITpaMyVsVjdfY0EH5CpHA/U0tuKY3MCLTvAEMtyAYrk+lCH3HJDfLg1qxhIGyiBxjPf+G+58080dfGQEkJ5VnomMcmxjaL/PUwqjAmyMmTo2eq99nq0p8DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqAURrV5FDRgi7lXdY5SCS7w84emh+GjZjHlT1lwdzw=;
 b=qIR1IdPQ0BhT0fdX7S5S68rdEEA1HhxDFMev0pt9sHOJP/TDCwZg9ymhGWuQEPoFvhUYka0sG1VR7/byvXim0Z+YNfN5cPnP7bB42sTqSLmIFhH23KTUl9/EflNNeKTVmkLXED5I6J+uwPDvTjG2A/XXkUxaLNEAk13hfeQX784=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 08:37:48 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8511.026; Tue, 18 Mar 2025
 08:37:47 +0000
Message-ID: <fc78716a-c3ee-40e5-a87e-4068e362aa5c@amd.com>
Date: Tue, 18 Mar 2025 09:37:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Where do ttm->pages come from?
To: Matthew Wilcox <willy@infradead.org>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <Z9h54wu2Nqbf4OqF@casper.infradead.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <Z9h54wu2Nqbf4OqF@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd4dd50-f594-4290-c79f-08dd65f8291c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3UrY0ZhckZ0N2VtYlZOa2NDK2toSHZlZXpwRWxUSVF3Q3JjU2JkckRId1JK?=
 =?utf-8?B?NWtTczJycjhDUUd2a3BPdDVGY05XOHdWRUloNFpIL1lMWTJuSWhvNjF2Q3Jn?=
 =?utf-8?B?aUUvaFlUaDNBNWlVS0w0bVB5Y2xqMzBXQWtMUCtQa2tnUURDUVhMbkFycDht?=
 =?utf-8?B?SEhqU05NWFhvWnVvQTdTR2xDVXBqY1dnaS9DNyt0ZWpnUmJ4RGExSWtkYUNU?=
 =?utf-8?B?NDRyNmh4ZjEyc2V2bDd2d1VYZW1ldmVYU3hNZ3RyTW8yYlV6bzNlbHR5RE45?=
 =?utf-8?B?eDhwU1oxd3VEOHB4QTBSTzBNcjJoc0Q2bTNrSTRZZi9uTThGMXA1c2dmNEMy?=
 =?utf-8?B?R1cwSTE3clZEcHJkcWlYcWJKMCsyM2ZKaDNJUkJzNkNGa1BCNzJIOUROY2t6?=
 =?utf-8?B?aDJRS0lMeDRON0VwMEhlVmNjZ24xUy8rTTZiUjVsSUszcWwxQUUxM2hqaE1o?=
 =?utf-8?B?WmphODBoMHhWb0VhdDllb2d3WnZsWXdTRVRpOVR0cTIwUUVsekdibU1xOE0z?=
 =?utf-8?B?bGpzY21RcFFiZWJqRDYrWHRUdmQ2TTkvYVVPOHNHV3lVL1FueUtTSHZ1b29C?=
 =?utf-8?B?VDd1T3NtQVhieGdrOFAyd1lPams2anA4M3Y5R2oybjhBYmhLWDlTRjd0cEgx?=
 =?utf-8?B?emV0VGJYN3VXY0EwSFZCZlN3QlNmQVV4bnBGSFhHLzVDeUQ0Z3lCZk5aYUxZ?=
 =?utf-8?B?Z2wxUHI1K3QwU1ZqNzY0WjJSRnBmN0FSZUVTM2tNaW84TDBoRG5XRDRkeXNW?=
 =?utf-8?B?RTZiSTZXelNNNnIwaXpMMWlxUjdpZGNYNmFSUGp4cyt5RUo1d29yMUJXQUF5?=
 =?utf-8?B?UDVkeEozNEFPS1RGOW45bkpaajNqUGYzbVcrWUhZblJXWDRFRVE2ZFVQcUhp?=
 =?utf-8?B?Tk1CajVaWnlrbFFmQ3l0NERnbFZONkdYeHlydXlScFd2bHpoa3k4ZzdNNzhw?=
 =?utf-8?B?SUxCcGF5NUdkaHhERHUweksvVWRDN3dMVHk2Ty9xd1ZJUE1GdnFKaWI1S1M2?=
 =?utf-8?B?Z016UmlBTHp5UmNBS1dueE9zdk4vZHlXZFBDNWR6L3NiOTRLVGEwTGhJSTU4?=
 =?utf-8?B?elJoNm9RSnZzTVozVm44cTZLc2hJSU1ER25mcW54OUdrbTFUdXZyMlp0STI4?=
 =?utf-8?B?Yk5KNHZoUjQrSlRsMEs3TFRaazJXWEtWOTVvdVhkYk02TGo4RnF4eE9mR0Zx?=
 =?utf-8?B?N2Vub21Semcyb2pJU05jdmtaOExaTzAwOXFOUXA4ZCtLZkZ3RDQzeUU5eXZ5?=
 =?utf-8?B?dkpveU81dkQwWjRnQkJPV3lyalM4WC9STFpnODh5L0R5cDBDVnVvTmdPeko0?=
 =?utf-8?B?ajA2Z3BvSUlRRm5aTCsxc0RJZUFPTHZRZFhQQ0lvbGVNclJzelJXdDFtRFF4?=
 =?utf-8?B?RHFYWnlSU3Q0Ykl4QUxvNDEyVXJWWFA4M0dDOU5tQnc5NWFOM3RFTFIwaCs4?=
 =?utf-8?B?VlE5WTNwTVQzTHovQUwySUF4cWIzWEQvYWZVc3VpQXFvODVrWWlRb095Unl0?=
 =?utf-8?B?WC94cUVFOENEQ2dJL2xUU1IxZDJxMWltRGpYK3JoNUdobU0xcGRQV0JiRFd1?=
 =?utf-8?B?NWJ5K0F5U2lrS1BFajRWU1pnL3NuQVUyamFNeldySThBSE1FMXlVWWZ1MDVH?=
 =?utf-8?B?WFpoLzczei9IV1hGMXBpT3JHR055a3VvTkdIZGpranE0VldKMDZxQ3dTM3Fm?=
 =?utf-8?B?QU9uMlVMUXg0VUZlS3UvdHlUWEN6OVl3aG5TRVdRb0Z6M1VRbE5Sam1mNmFQ?=
 =?utf-8?B?WnZadmJPL1dFanpzTTJ4QTE1anhINStNUFo4UXhWbk1CajNMZUI1YlpGQmZZ?=
 =?utf-8?B?N2VmWTJlZHdXSStlZ3lOTjJONjlEemZtVXlQL1dNOEYzUmQySW1JM0JVOFJy?=
 =?utf-8?Q?SswqkgEtkn/JW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azlCRXMxWU9Tc2JWUlNrdmY4NVMzOGEzMHVwRS9OcVlrSHlkYkdzd3hhdnJ3?=
 =?utf-8?B?RmI1UjZCcjlja01mRU5MTDhLamo0eFdsMnI3ZG5JRFNndEVCL0VZb3JKRVUw?=
 =?utf-8?B?R1RyMlNHeGQzaXJJNzRnaUs4VGpGSHovcGdBZ2s5dS9VRlBYRmZSVWhiKzd3?=
 =?utf-8?B?eXdEdHVKQzRndWJ4Z0VRSjMxakY1bnB5WkVxdmYrNjJ3QW1yRUNQVXhpaDZu?=
 =?utf-8?B?endKb0tOQWNVTU9PbVMyODFTY29SUmR5ZzJpMlJVSUZyN1JyNmZmUmlrQVBm?=
 =?utf-8?B?RWxzVlJHbTBROGN3NTUzQWQ5ZnQ2K1RxYmFPZDZXQWNJSWJOS1E2VGtJY2lq?=
 =?utf-8?B?R1Y5REJFYUp5cVYzY2hMY0VranZzemdBelBERkVXd25EY290QWpmS3dqTEtM?=
 =?utf-8?B?R0p2MEhUWElrQzdxQ3lTRWdMQXN2YXNaeGc4UFJVbEVEbVdaWmpuMU93Z09B?=
 =?utf-8?B?eDBUcVBsQURXWWV6STZWektKUjljc2dhWlo0QjBqM21lRzFKVnBvY3kwUjlV?=
 =?utf-8?B?eThzUjZXcitZRkFsT1ZJREtvUGdwMTE1WXV0RkQ1anM3d2pDSGhmdkpxOEg0?=
 =?utf-8?B?VVlURE54ZXRXNGZQbXRUN2ptamdwV0xQRWZvUmloZFJVcWhQeEZaZzdkNytt?=
 =?utf-8?B?TTBNemJxL0N3VUg2bnJsRGtzVzBSa0ZJUVdJckd2UXJEOCt0OTVwWGpVaHNS?=
 =?utf-8?B?Z3R0MmFDUkViWlpUUzdGeVMwQUMwQXdCT2N2Z2JnQWFhdWZ1K0JXZzBna0hr?=
 =?utf-8?B?MFFQdTNDNldhaGVlazBsQ2tENFR6dWJhSXMvN1RWbE1xYnBESjZOZkthejBO?=
 =?utf-8?B?MGJGYk1hN0NlVUtZQTcxTndaemU4RXpYUnVuQ3h5TjZYRWQ0K0JLYmRZTVN4?=
 =?utf-8?B?U2hDWVduTWVSc1ZhWlBOMkFJaWtFNWI3ZDV6Z29NeExrOFVIL1NSTnIxQWtF?=
 =?utf-8?B?ak5YT0VJcW5NMCtYOGJucXcydUc4cVFQUWk4QjlIL2QrQ2VvMFZjSzhiY2dZ?=
 =?utf-8?B?cHE5VFVDdnp4Ui8rK3BhaEs0eEVPOXRyYTF6b0M1T2VzQkI0dkNnTGYwdVQy?=
 =?utf-8?B?K1lEOSsrQ2pDQjhuVVVOUlZDbUo0MlpCVHVzeWNVdXpTNHdaSFlKS0Q1bmdU?=
 =?utf-8?B?bC9pTGRrWjQxVFd1UjRJdldDMWRmRmE4aElUbVc1UHFPUUhhYkYrUk9ZajZ4?=
 =?utf-8?B?MEw0WlFWMDNvaGtySEVrdlVrVzFoTWFyeDBMN1RmWmt6N0VEaUcrdFBLdTdW?=
 =?utf-8?B?ZWlPckNaT2FLUlpRZm91S05PUzhBN0VUTkx1MjNYRGN5cVBCcUtGN2s5M3Zl?=
 =?utf-8?B?akhGSWFlaDgzcEhCRVUxa0YzN1hUK3VLSGp0V0t0cVBMZko0ZzVUaVFMYVFL?=
 =?utf-8?B?NnEvYTJTZFN3UUhRNjlMblo4anhva3VwQzRwOStsczFHTm11TnJxa3VFeEwv?=
 =?utf-8?B?bnJUR3k3SktSUisvOE82TG82R3JpNWlBNTBqenErZmp3dDN6K1dRc0t4bUZQ?=
 =?utf-8?B?TzRvL2h4WXh4ZE5ncDJ3UXVRRnRVaWRocGpURUZZV1VWWmhjNm55aE5jM3d2?=
 =?utf-8?B?ZjZQelNJYkJsVHdHZThpcTNEWXVkZnpQbGFKRGpVT2FxMXdwZGdkZ0lCNFFi?=
 =?utf-8?B?dkx3djRnOEtKVjVLZXFlTVdrWUJVSXgySzE0YUtPOGdnZWtycC9vRE9Va1Va?=
 =?utf-8?B?cTA5K2NVSnFFRlE2UWhRR0xaYmZzTWNWL1BPaWtNNUNkU3NRVmsrMytkNVdT?=
 =?utf-8?B?Yk1ISjMwMjRsVXdKTWVJM05OVXYrRzFnUkh6SGdTZE5VekRXRVg3Ni9pNEZH?=
 =?utf-8?B?VVoyOVYrU2tocktYNlpOaHY5dVZoNHRkYmt0dWNtWEpXRjZzNWtmRTFveVJi?=
 =?utf-8?B?N3JYWml3c3oyN0s2WldsOTJpMEtzeE1SdUZGTWx4K1hzUmplZ3pBblE5R09S?=
 =?utf-8?B?eW1GeEFVS3p6ZEhKMjJxaCsvbEpzWExYS3lPZ1IxY1B2V1duYXhOeWUxNVY2?=
 =?utf-8?B?dG1qSU9UcjBHeUgvTFpNZklJRjE0VjlSRzhxRnhjM2xSeHdZR29PZDQxSit3?=
 =?utf-8?B?cXhidm5LdU9Memhoa2RTemdFTVRRYkxKVnJmMm9QS2pMcHY3NUdHYmVHb1RD?=
 =?utf-8?Q?68ks=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd4dd50-f594-4290-c79f-08dd65f8291c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 08:37:47.6267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MsrLjO1/w6DpUAO3aT4QfYdqYfbz9kde6DWoFS7NU9PuXkLHbaffqjEJCt8Okh4w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
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

Hi Matthew,

you actually got your understanding exactly inverted :)

Amdgpu takes a look at page->mapping to make sure they are *not* coming from the call sequence starting with amdgpu_ttm_tt_set_user_pages() or be imported from another driver through DMA-buf etc...

The only pages which are allowed to pass this check are the private driver allocated ones, see this code function amdgpu_ttm_tt_populate():

        for (i = 0; i < ttm->num_pages; ++i)
                ttm->pages[i]->mapping = bdev->dev_mapping;

So far that has been save since nobody else should be using the address space object from our drivers inode under /dev.

But when you plan to remove page->mapping we probably have a problem here.

Regards,
Christian.

Am 17.03.25 um 20:37 schrieb Matthew Wilcox:
> We're close to removing page->mapping from the kernel, and I've run into
> amdgpu's use of page->mapping (setting it to ->dev_mapping and comparing
> it against ->dev_mapping).
>
> What I need to understand to know how to fix this properly is who
> allocates these pages for what purpose?  I've got this far:
>
> amdgpu_ttm_tt_set_user_pages() populates ttm->pages.
> That's called from amdgpu_cs_parser_bos() which got e->userpages from
> amdgpu_ttm_tt_get_user_pages().
> amdgpu_ttm_tt_get_user_pages() got them from
> amdgpu_hmm_range_get_pages()
> amdgpu_hmm_range_get_pages() gets them from calling hmm_pfn_to_page()
> which ... could get pages from anywhere?
>
> But cleaarly they can't be _any_ pages because if they were anon or
> file pages, overwriting page->mapping would blow up horribly today.
> So they must be driver pages, but I can't see where they're allocated.
> Is it ttm_pool_alloc_page()?

