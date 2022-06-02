Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1D2C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 20:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CDE1137B8;
	Thu,  2 Jun 2022 20:51:21 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EC6F1137B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 20:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dylWys6q9+tB+KygNYyVF2pX4i2QteYM3SUqHABbFrLAHGPQIlNGlsifiTUv9a5xf/S5zfk1B8dmw1MLZtzyJ9UbX01ttxqEWg5Jik/37Dsp61J1k3Z+Yr6EGqgVduP+ouNFCguQChPeQP5eyU2iSwLz2qEE8eOPHStt8BfCq/vOQCvz0K5SIGK073KZjWmLEVJ2HXRya7uDbWs+sN5Le+DxGYcaQW5f9vQMs177ZXrQXO80HdUXWpGH1KfuD1BwvqreWO2ACXlAK+RhP4Uqa3EqeDe4Owf0+BtQDWtU0p1IBlZwlnOiCX1REYLYwi5hLrTZJSShPCdczTR/ZSCZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQR3UIdfUb0WvxLHNuRujpMaoUoDn7YqDg81gGJFzd0=;
 b=g0mjSliRig5utCDhp9dwSC/8J8iAoNz1lMCZ9kx8ItKdlBLhoT0h1aR3firi0eLF0mpZr1mCEETumUvRUpLU9vSnhdhbeTLSu08hK945BvZehq13D0cIaEAwjD12zTguRQ0B/x1yrFIpOtT44L7+EXxmKE7E27OJYHwjWGTAh2oFXNixfLyZ0t7zmKjMzbocvB9HFdWFITBNpcHH3TT4aqscbOXM7CRfRV74560Lb9X6gHBFt8FYxhuBeYhR1iLf1wAkXHDHqFl3oANIliEhdSolbT1N/HUwHsCxel/W6qsV+BqxAuCBs9YN3hcp+a6dvwisU17MGDy+rqer2zz/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQR3UIdfUb0WvxLHNuRujpMaoUoDn7YqDg81gGJFzd0=;
 b=t8vcN5jDX8rie4kl9mIXy4idCbzR2M7AOy63hcynW9uGLetEQZR0OdJHfQtEd4H5SQ9V/mtdYSWP2waaots6LtO22mi5SS6hj92dtlSjYNtLcVMyWkSDtlh5oMQY5b2UWsXkQ3xBPvWh9n+ePCsgUxSaW12xUpTmv7NIeopVII8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BL0PR12MB2484.namprd12.prod.outlook.com (2603:10b6:207:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 20:51:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 20:51:16 +0000
Message-ID: <8289bad4-d097-80cb-dde3-9de1c52fdb11@amd.com>
Date: Thu, 2 Jun 2022 16:50:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/4] PSR-SU-RC DC support and some PSR-SU fixes
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220602180347.754067-1-sunpeng.li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220602180347.754067-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b75cc4c-c578-4991-968d-08da44d9a2f1
X-MS-TrafficTypeDiagnostic: BL0PR12MB2484:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2484B354017A26E2087E7AE28CDE9@BL0PR12MB2484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MiM5eYmhmpoJTud0FWVE3j3/kgkQ/k5ZGRPkId6hYKxDsxdFkkgRbHCCkQSZ0BqF0irhgQX9oVD1S2EyyLRmz9LtAbcGV5YoOXgiV9AYnXF/cHYFJOyXWAGiIaonM4tZXMXukAl/7PBWTAr0ekkzVCWeypYVNFqFgx7wzN76Kx6PuxebwPW0x/f8/ZA6jiy3PienVdUEjsi4vMd87eJg/1mgFOZTWHw7fzk6JApKushEKSrnsLqF8HxYHVArkX7rnpnQpBkTtcF5AJn1q+wz6fApL3uEAbYFTk8PAT898AldSoOynYXEZkyjL+06EtgGAYMrFMLcxdyPZRA/A0663oYNRjxcyvf9BhyyLSfplJi3csd0LFTaHjqEVtikWlGdEGh78VUj9dqVLhm9cDUGQkjpiGfnmUV3up9IxmQZsuuJubuWctIFtpNiQBzwaRvD5aOg+qmOkZHgoqnqjIE7Qx0YeVp4ncJzsSzhgOnOLbEK8+AU96swU3DDd6BDR2YZs6R4kHpkL4sdDlcgdjs9E90m/2cf4blmLAtMe7ybEs1SS1Vq3hU49c6JikZf0GP73AEFt+qMxEnlA0Kwhpw4eWLpZmIIFx1s6b6HRr1yRQ3Q3iRfksHpSEi+91SaujYwxZFW+aRzFPmC30Vz4VOLlUJdaJZxo5EebSkDCiRFrnBvd+yHhSqGiR+kYKUz3Ytp+kTEHR30wknLbf6C8fLTB55DzQVGIhmAK4Q870ik5nWT/cCEHzOAOa8e4X3YzlYT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(66556008)(316002)(66476007)(8676002)(53546011)(5660300002)(44832011)(2616005)(31686004)(36756003)(6506007)(26005)(6666004)(8936002)(86362001)(6486002)(4326008)(186003)(2906002)(83380400001)(38100700002)(31696002)(6512007)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTQwcDJUNGhoSEZZVzFscW5Gd1hjWUYyYmd1SU5jc3MxZ0lmYWtxK0crYnkv?=
 =?utf-8?B?d09HbGVOVzhxNVo3TlZmMFFjc1lxMVRxMnp4YWJua0hqVlY3MDBtS2tsQVFy?=
 =?utf-8?B?R3U3N2E1bFhoV0hTU2l3QUZKSzBMaS9YNEpxQjg3WVU3MDlyc2ludVNxdTVN?=
 =?utf-8?B?bUswaFNqYXZHOThhNHNDNXFCN1ZLbU91ZkxZNXZra3lUUmhac1lFdnJlOXp3?=
 =?utf-8?B?RkxjbGhWZ1R0WThydFB0UzJVMGJ4Q2ltYVQyMXhHZ1VvSVFhMXIzZEdNZWU1?=
 =?utf-8?B?ampZQUE0dUpPaERvbXNGR2xPaFNwZ3E5NWoxWmNVbXBRY1FWMUhqSWdjUFFE?=
 =?utf-8?B?SFR2VXY0MGU2UzZ4QmQ2ZmlOTEZOclk0cm5MSXhSRFNtNFkyZk1lTXpZY3ZV?=
 =?utf-8?B?ZjdxMUhxWGdYclA4cFFYYWx4eTBLeWEwaUdzZjlwR2E4d1FZVXBpaG9QaVVz?=
 =?utf-8?B?MFdlUHpWaDlvRjhXUHNtYVIvMS8yZGVEMUFEQ21aZlAydEFwUmEvUTVvOXY1?=
 =?utf-8?B?eWtJNHVWQy9RRTZ1cU8yd0pxTko4cFo0K2JiWitHdUU5alVkZmZhY1dIajBZ?=
 =?utf-8?B?cW9XNFRISURVSmQ1d0R4cUZCTFkzR1F6ZEtJYjBGRHlQc1dpK1dReERncTJQ?=
 =?utf-8?B?MFZIZ21uMjdxemsxOVJ3NHZuV3M3QmZ5czUyaC9PYWI3YS82VDZSeENBYWNo?=
 =?utf-8?B?am9Kc3JCYjdteHBSdWRQRHBFeXBTWEZkcU5VN1hvczJBOFcxU2VXbkVScjlz?=
 =?utf-8?B?NXowTktocFZJQ1RDVGNCRk0vZitjdTBNSFhEbFZsdzBzWWhIYzVvY3o0c1pO?=
 =?utf-8?B?V2NYOE10RVRqWTJyalZCUlBPK2FIb2JwS0hVYXFNMlBkbldIdUJRL0h3QmRB?=
 =?utf-8?B?WDB5K2F3WldmdmU4K0tPbGNjR1hZYURkWUt6N2xYalNac1NhYUhoSTRSZU9Q?=
 =?utf-8?B?bERET2Fwc2VwWjEzamtlOVFWdFdCUEs2cENaRU1aMzBtWEV3VVdtckZrZUZ6?=
 =?utf-8?B?ZjJiV3U2aEplTzRPa3NQbXVxS2tWWkVmOGNoSFNaQzFCUlpJdUM4dkV6MWZL?=
 =?utf-8?B?WmN6c2l6bEg5dy8vMFVtdXdyU04vZE1BS0YrNThKVC9BWklESjVtSlo1M21k?=
 =?utf-8?B?bDFOWmFaNDUzY0tLRXhRWDVVTkh3V3EwdlQ1YkpaN3NJS3ltQTBLZzhMZXIw?=
 =?utf-8?B?eWxKRlhHN2pjdXMwMi9XNFBpSllQZzBmWFdMT1AvMXVJbUQ5OGZ4dXBWZ1lt?=
 =?utf-8?B?bWwzcTdwM3JpTE51ZXVkWkEyVS9rdCtSV0Z4Rnd0TTBGb0QvODgxZ0lGbnNr?=
 =?utf-8?B?TndwUWk1S2RZZ2h1R3pjOTJtMzM3TUkrcWxZSEhrVmphTGNXZEU4WTNzR1gv?=
 =?utf-8?B?T3FsZllXRXFYRVFTdGh6M3BXSldQOU5aYWhYVENqMGEwYjlXSnFBVjdrUXZi?=
 =?utf-8?B?eVBVbGkrOXRsbmxYMk1ieUxaalN5U1BQdlhWY3BuYlM3bG9jTHFPei9MNnF3?=
 =?utf-8?B?WDBtNnB5SHkwa1kvQW5PMTVJK3BiK0VsNExuV2tiZHhaSEFKblRLcGJySkxv?=
 =?utf-8?B?alUyWVI0Qk1YOW9sREhPSkNmTzJjZTlXRncwamgzQWYxRGZPTjdpRHJSNFl5?=
 =?utf-8?B?VmpZejM5MXhSd2lWN0RGYWRxeFNtZ0VHbldmVzFFUXB1dllWVys0YnhZNHJP?=
 =?utf-8?B?OVl4L0lHdlVXSHREVUVqRXIxdXJwdmtTMmxCUkpaL0grdXBHcDZ3YSs1WCtn?=
 =?utf-8?B?aTFyeFVXNmdPMnJVb1RIUlBaNmR6eG5kZzBBcE1CN2J2R29tdWk1TzJsdnlC?=
 =?utf-8?B?dCtTS2NrTVAvTXdzNW05NHI2VE9PVWJKelg5YjlHUmltdVZ2bjFSWE5TbWRo?=
 =?utf-8?B?OWpqdlVLdGhvbkg5eXZtTU56T29wMkNiZ0llamxLUUkxZHVwVlZENEhSU2c1?=
 =?utf-8?B?OUlsN2laVVQ2djRnUzZKb09WQ002d3RxOEw0Vkg0L1h5OVVIdzdtbjk0NkJD?=
 =?utf-8?B?anhXTE9ic2U0OGtxQ3htWURJVUxqajMvVmprMnZYcUxoOHpmTDQzQ1U2dFB4?=
 =?utf-8?B?OTl1azFOSFVoUm1kd1F6cUp5WklDcEJVWUNyQUpLYWI1V2I1a3BqT2lHTXZz?=
 =?utf-8?B?WnYvZHhObXFJdFc2RHQ0ejg4dS9CbWs4U2tpTUVsUE5wZkdpR2FFOXdhUHda?=
 =?utf-8?B?dnZnUmcrd3A1NDhrekFWYnRTREdVa1VDa3E1a2dNblhkelhSbWJRY2ZWeHlB?=
 =?utf-8?B?MTdzSnZ5SWJSdUgrZitvVkRBWlZIMkxNd3BoY0pCRWpSRDF2MHI0YnNRQWxH?=
 =?utf-8?B?R25wcFRUUWFDdllBem9ucC92bys4emRaMUJBcWZlVFc0R3JwUU8xdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b75cc4c-c578-4991-968d-08da44d9a2f1
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 20:51:16.0242 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkySqW1yRbVrIArsUpFF0Wrqm/Vct60D8mqOJ+6kkZ9yb2V4cXEc0TmxIHD+IkTipPNl9qOpFy1/Q522rzUtow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2484
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
Cc: alexander.deucher@amd.com, dingchen.zhang@amd.com, roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Patches 1, 2, and 4 are
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

On 2022-06-02 14:03, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> The first two patches here add PSR SU Rate Control support to DC. Support in
> amdgpu_dm is still pending to enable this fully.
> 
> The last two patches are some fixes for PSR SU.
> 
> David Zhang (3):
>   drm/amd/display: expose AMD specific DPCD for PSR-SU-RC support
>   drm/amd/display: Add PSR-SU-RC support in DC
>   drm/amd/display: pass panel instance in dirty rect message
> 
> Robin Chen (1):
>   drm/amd/display: refactor dirty rect dmub command decision
> 
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 19 ++++++++++++++-
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 22 +++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 +++
>  drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 ++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 23 ++++++++++++++++++
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  2 ++
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 24 ++++++++++++++-----
>  .../drm/amd/display/dc/inc/hw/link_encoder.h  |  8 +++++++
>  .../amd/display/include/ddc_service_types.h   |  4 ++++
>  9 files changed, 100 insertions(+), 7 deletions(-)
> 

