Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE1BC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBB110E074;
	Thu,  8 May 2025 09:22:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ajImcZUA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F05110E074
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6oZQjTnZu6LzTOKNos44ixANK13yqldv/O+hKaHb63VHIBmSaWY/WMRgEHriMiBDa0yr1Q+gAfmtoiHlIq8U4OqjS5Hft9qJNsHHCn1TlxI19bpVUNNxFQH3T1OeiwSe13iZOgeCqOJTX7tiLqY+T59lhU2RJ6NpTXiEgNHaGT8pxgLmO7uJnjfPKwuClDdHuffrjp4toc8s3P62rFCQqKr5ZpHrkkgT28I1Q+MeBneH9JAt0c4uQpcsXaHqacFkWK61WpqdvZ++vV5hTbTUmGOpPCcLTX/WaIdWVubbZivl00xS7GBmPHVJ5ep5g4xKGCmVYFWSgbCX5DK2tv/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6DQhg77JSjXwf9DeLzF2pxfkiDQzeLShMbxC8GfXQU=;
 b=eMy1IgjVFCmtYg0MCmC6AVkTFoqJYtaVzu4kw6PoZdPAelZTie3ayGBfJaQFA9VgJxjEu6EPwW1mqYlWwB/LsMIeyq5EgSs/wbgGmjW3JOfc4v4AKW0RJHJOJI24v29OYSwIDpPuFn46EdYySaumzf/BHiJ+cCQOaVZA0jad6W94nSdqaQ6pBv38WLzM3z71lvToesBCgWoFGr8K4nx7fZZlFxN+Rs/HclHLkTlEvqDfE0NDfGyAId7XJNMGAhudhfC4dyAAbXeCcUscyeigonM18gK76patywzjuJq7Ppkaf4wbAK7CRBpBnj6aI6MdPS+IFZ34c+xWuWUBlhZb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6DQhg77JSjXwf9DeLzF2pxfkiDQzeLShMbxC8GfXQU=;
 b=ajImcZUAT2Y10aZIEbdcDMwGwzKNd0tm1+dkSh/gjjKmQehtzQBh2b560Fs84czVypqwUqM4s0BH5K8lKGFLBGeIxhnaDI/pOAJRgm0eLdSG4tJq7XNMo9xZcCUXyFFtMPK8uLWYoeaWKEbrGD1rD6gqPF+v+1HjniI8wYsa668=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 09:22:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Thu, 8 May 2025
 09:22:17 +0000
Message-ID: <560b466b-bfc0-40cc-9af9-6b8830b712ce@amd.com>
Date: Thu, 8 May 2025 11:22:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
To: "Yadav, Arvind" <arvyadav@amd.com>, Alex Deucher <alexdeucher@gmail.com>, 
 Arvind Yadav <Arvind.Yadav@amd.com>
Cc: alexander.deucher@amd.com, sunil.khatri@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250507183722.76789-1-Arvind.Yadav@amd.com>
 <CADnq5_N0m738JXJDzRkdZum=KteV_jTYixXQ4SCYGs-43NdhLg@mail.gmail.com>
 <b5486ff8-171a-b02a-357f-04da917299b2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <b5486ff8-171a-b02a-357f-04da917299b2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0005.namprd02.prod.outlook.com
 (2603:10b6:208:fc::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: b7600e7f-facb-4be3-eb90-08dd8e11d3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmtISEcyM2ZCVXhRanZ2bVhpT05KYkNsZ0Z2dHZkYjRnanZ5b0RFbXJqeFEv?=
 =?utf-8?B?SmRXZnQvTDdpaGVDNFVFYTJSSHJrYWdqaDA4S0o3S1RUbHdyY3VsdktpYkFz?=
 =?utf-8?B?Y2wyMUwvaDVZTXN3Rzk5L2FqOUl4K0owT0o5L0J1bGNUbFR6KzM2ZVhzekF4?=
 =?utf-8?B?ZEtRN3g2ZXBoSWFESG1xcllDb2FSVVJJVVQ0UFYySUxUTGErM1d4a1IvNHJO?=
 =?utf-8?B?UkpuY3BQMktxalZ0NzVDZ0N3REVMV3l5Z2pnNUtyK1ZHbHNlRjFLOEVDUzl0?=
 =?utf-8?B?bWN5RUpaVFFUcE1oV0pBNWlXR2cranRjdVJSbkd6RmpiVkVZMHhIVU5UOHFl?=
 =?utf-8?B?bUhrTnFraGJPZ21naWtxd1NUTGlwdjZZN20wL1F3NjExUTYydTdDZkYvNFpE?=
 =?utf-8?B?aFRueUR6ZHhvS01vOXJXZjlaTlZFZzRmMFMxUXUzc1F4WDNsQ00xaFRzc2Fu?=
 =?utf-8?B?TWFQd1JLMVRpcFhsaXdJalBDeDVYdG1UQ3dyVFNFM3A4bnY5b2NnQkJ3cm5a?=
 =?utf-8?B?R3ZhT3NMN3hPNEtvZE8ySlBLZEp4WVBGYTN2dDU4Q0xVMnVYeFJpd3ZqU0Iv?=
 =?utf-8?B?Q3hkRnJMaE4yMTV0cEdnU3NMdmdXT2pGT3dZSWNXSXNwU1dQNGZFcHcrYVV3?=
 =?utf-8?B?emtBVDkxNm11V0pLb1ZoUUhPWlVqWDF3TlB6VU0xQnhhRjZjWWhPdE4veFBV?=
 =?utf-8?B?UHVTMjgwRUE4VWtSK0hJZDNSaUQ5QWNha0JqdXY5MjU3OU9zSEVqRGtDN2RY?=
 =?utf-8?B?YUtxU2JqSTZWY3ZZMS9EUzBiZit0Q09FdFoxaWROS0MrcEVMK3ZyU2VnbHl4?=
 =?utf-8?B?SUdVVlhjRVJZTzc3WjlZY0VBQXdjSko0MThmSktTcnIxMkRubnAxaVJXdmRo?=
 =?utf-8?B?NHZ5SzN0anlNOVNpWmJlbHloUHMzd3pwa1Y5YmVRc0Q1REZ2c3JKYTNNc2ZY?=
 =?utf-8?B?cFA3UTlYd084NzRnUmJJeXRtSU13OTN6dnljanFaNlVLUDVSUHpjelErd3o3?=
 =?utf-8?B?T2lJcDRQMktEMW9obzRKOGZuZytwaXk3NjBJTXlPT2taMzhvcy82Smdtb1RO?=
 =?utf-8?B?dnRLSm9hUlpCZU10MmJ0NW1sSnU3TTFLa1FlUWsvUlZIL011b0RPNUcyMUhB?=
 =?utf-8?B?M29zdWdhUXpJOWUwdXBJZThyQVV5WjdYdEVsdklRa0NjK1kxZ3VZcTUwVktB?=
 =?utf-8?B?d2VWMWtSN2x6MEZFZ1dDZVVpblRURmRDTDNyQ1dkRmR6RDhxTzV3czZya2Er?=
 =?utf-8?B?aE9kZlFNMHk0NDBJcm5uOHFxaGtPWGVWSTFIL293eFdNMXljNUFVQ1dTazY3?=
 =?utf-8?B?TnpvWXFmc3kzWFVNQ0xNOUorWEZuWllIZHlZdEh1Qk85L3lZd3VoQzExekN1?=
 =?utf-8?B?OEh2V0dTdWtUZkJUREJUckpPeWdkR1dsc2t2L2VmdEhCWmZwRjgwdzUrMlV3?=
 =?utf-8?B?UTNDakxpVnhwQjd6YUJKNVBZRzM2L2o2dEdBbjNlbVB6Z3IvTkFOVHVZMlNq?=
 =?utf-8?B?Y29USFdaaUF3SHlndEF5Z09GamQvMVI5ODVxa2VPM29wUW5vRm5UNnIxYklB?=
 =?utf-8?B?S0xGM1FxM2hkTTA5T3htTkZUaXZGQkExNGZlcFRQVHFTMytFL2w0VmcwY2tr?=
 =?utf-8?B?Z3lQbjdjcW5EUStyRWxvNjVSVmVmSFFnR2NUOVZPKzVWZFFpZ0VjandJdEdC?=
 =?utf-8?B?djd5WVdKR3cwRnhSTUg1RGppZDBKUzRlOTd3YnZPVjRiQVNXSk5CcVhkZkZj?=
 =?utf-8?B?YUxtY3Zuc1dNa2lqc1VIcndDcDF6dENrdXdBWDY4Yjd6Sm1SSWtxbUlXTXhW?=
 =?utf-8?B?NXdzU3liYk9wYUdpRlp4WEZrRVNwcWw3aTdaMzhmbnBQYVZkbjZQYzJ2T2ds?=
 =?utf-8?B?TVYrTFMvZEx2Tm00bXYwK2tIL2ZYaXh5SUNvM0JpWUMwSmIxMTVPUTRpTjk2?=
 =?utf-8?Q?Gz6QRMU4Oys=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndOZG9xa21vTVBNOGpnN2R4YUY3YWMxcHZHNU13YkNicXZqSEpnZlNFTTBO?=
 =?utf-8?B?WWx2MUpoZGtwVzBxR0oxWjF2VmxFdTVFOFhHazJDcW9FOHFoWnVPUk95blVU?=
 =?utf-8?B?SkhOYzZkVTNkVkN3ZFNYSWJrVm10OFJjQ05tS1hrRXp3d21jK2h2R003SjFa?=
 =?utf-8?B?NVpyMEV6Y0tNemhETFN4OFNld2VncjhXY2lvdXlTaGFCV3pDcTYwMFg1STdi?=
 =?utf-8?B?WFpTQ0NkdzVyaWNKaGdjaEhnQlZXa0QvTEZJYWwwRDNDaWFyVVNqQTVwNVZB?=
 =?utf-8?B?d3FScnZPUFd4M3dvREUrS1lEQzV1RnB5T041NndlRGZZWjRldTg1VlVsM2lP?=
 =?utf-8?B?VHZNSHVlcE1LTHpuMFZhZTliOXg5aFhWVFhLUCt0UEtVSUdrdnBkeS91c3Er?=
 =?utf-8?B?dDE2ODFKZGRWT2YwZlltRnI2VFVRcUptVjFDT1YyM3hqOFp6TEhiVVp6clh4?=
 =?utf-8?B?U0RSOVpKNWw5NUxLcUJVejI3cXBrcjNtR2tqeEpua05kRzl2ekZlSVp4U1oy?=
 =?utf-8?B?OE4rM2VCV2h4TEwveTdIaFd2aG4zL3NoTEt2SHFuL1hlSUdGTWZvQ09yYmVX?=
 =?utf-8?B?S3BXSUpuUjh4Y0RkUEZZRWhIQkdlTkNMVHZWd21LbGpsWTlNOXRGZmpESG9h?=
 =?utf-8?B?allIdWJSdlhnNWd0MlFUUXZSZmYxbmtISkpOVW1NaHUvd0h4VU1FVHBpelRy?=
 =?utf-8?B?MUlwWlZuK3B2Z3RlTzhWN0JBZXp5Y21SRXo5OHE2blg0R3ZVbzVzOURRQzhZ?=
 =?utf-8?B?RHIrTmd5K1lzYnJtUmhMNVBlalF0RHRVVkRUdEwxSE5UUGFHejlQclowcFlQ?=
 =?utf-8?B?aTZoQUF5ZTBwbUM0OGxVck9JMjZRNmVVc2pQWjNqeEdUeEJCS2RST1FiOTd6?=
 =?utf-8?B?L1pBZUNEYWVmaGdIL1M2eXlKdWdpM2Z6QkNQTGJrLzhWdVZKV0x0MGdLYTNW?=
 =?utf-8?B?eFZzcmxaek4rZmR3SkJJc01OTi8xb2lnNElDcmkwUEJ5SVQwcDRKb0d5MURi?=
 =?utf-8?B?VVVEM2lHd2thamRaM2VRUkE0V1RzU2lrNDk4RUtkeHAvOWJmTjF5ejBzNnRI?=
 =?utf-8?B?NE52STAydUZ6azhpNTNFeFpnMXZKS01WR2F4WTdEWlJOM0tmVm5QM2k0MkhG?=
 =?utf-8?B?d2tKenZrRWduN1dSSkxtR05VcnhEYlVtKzcwV2p2S3duZ3RUeHlnRVAxVGNJ?=
 =?utf-8?B?RWZlQWJhcVVIRXhpVGx3QWlOamEyZHVsWWIrQWNFc1plalo2MlQxOGJPcUs2?=
 =?utf-8?B?K3NKSndQcHJzWkhqNUJ1QkxLSyt2RTY2VC9IeXprUExYaVdJb1RVZDVTSlRj?=
 =?utf-8?B?ZFFJSlN3N2Iya1ZTMEZrQlVCOVFPYnlXM0wwYW5HRzg4OFFYbEw5Sklva1Js?=
 =?utf-8?B?alBCblVOMkRhbzhhM0tJNXdNcEhUWVpYN2psOHZNWC95NENZQUdXT1Q0ODBy?=
 =?utf-8?B?TmZHMUxrUnJBOHh2UFV2bTZ0Um1yVUNzV3lvbEdvU2IwMCt6U0pISVZMOEpz?=
 =?utf-8?B?am40S21tVDVnREtBVVVUbFJ1RGVPS3VjM05WdzVQSnl5aFFUTUJVTE5PYi9i?=
 =?utf-8?B?ZW9LMUwyZ3ByZ2E0cHdGSFRzVlZRSWNLR1M1NW0vaUxnQklJbVA0bUQwWENQ?=
 =?utf-8?B?M2g4ZUJTcmFQeVJuQjAyOHovVStRdTNFdzVNL1A4Z0ZlMzR6T2NHNWVnTllS?=
 =?utf-8?B?bEJkWWUxaUlNcEpTTVBGWjAwZ2w4QVNKc0NuUExSYTRyR3k5aHhqalh0UFBN?=
 =?utf-8?B?NXJUNnV1WWNLV3lEbFNiNHdqd0s2ZUQ4NkV0K2kwcmpOZHoreVFrRXBxY0cw?=
 =?utf-8?B?bWNrMHJpYmprMzVuUE1Pam05UlEvbExtVUJwMlBldlZ5U2Y0Rm9VWFZZRmND?=
 =?utf-8?B?M0VjNU1pUlVqdVI4ZFYxbTV2QU12Z1NZY0hqR1Y2S1pMS0VINW5HRDFvWVZo?=
 =?utf-8?B?c2xKWk1XU1QvWHh6WlQ2K296aVdrVlc2VkJCMlFNUGowZnRKc3J5WW41MHpE?=
 =?utf-8?B?VTY3TFZKZitvRXZLQlI5WlZ6QnVhSnVNMlRVZ2lSTWFVdDl0OGhtLzU2VmlI?=
 =?utf-8?B?REUwTlgxTXh0bDFDMmhQNVBOKy9odFB0NkRRdEhpY3VrampNOEJuZWVpbzds?=
 =?utf-8?Q?Q7WMs9usnqJ62teBGe5p+tKit?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7600e7f-facb-4be3-eb90-08dd8e11d3c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 09:22:17.7176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLxwM4ldpt4UHSYTUroCF+NfOXARWkZQ+urBrfzqL9UVT8WHAheLcQxZWdRsSweQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7555
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

On 5/8/25 07:04, Yadav, Arvind wrote:
> 
> On 5/8/2025 12:36 AM, Alex Deucher wrote:
>> On Wed, May 7, 2025 at 2:38 PM Arvind Yadav <Arvind.Yadav@amd.com> wrote:
>>> Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure
>>> the delayed work has finished executing before proceeding with
>>> resource cleanup. This prevents a potential use-after-free or
>>> NULL dereference if the resume_work is still running during finalization.
>> There are several other places with similar patterns that look
>> suspect.  E.g., amdgpu_userq_destroy() and amdgpu_userq_evict().
> Noted, I will do the changes.

Also keep an eye open for lockdep error, e.g. compile the kernel with lockdep enabled and make sure that the code flow is executed at least once.

Apart from that good catch,
Christian.

> ~arvind
>> Alex
>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000140
>>> [  +0.000050] #PF: supervisor read access in kernel mode
>>> [  +0.000019] #PF: error_code(0x0000) - not-present page
>>> [  +0.000021] PGD 0 P4D 0
>>> [  +0.000015] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>>> [  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G     U             6.14.0-org-staging #1
>>> [  +0.000032] Tainted: [U]=USER
>>> [  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F39 03/22/2024
>>> [  +0.000029] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
>>> [  +0.000426] RIP: 0010:drm_exec_lock_obj+0x32/0x210 [drm_exec]
>>> [  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 48 83 ec 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 08 48 39 77 38 74 54 <49> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8 08 50 bc e0
>>> [  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297
>>> [  +0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000000000
>>> [  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04da3d88
>>> [  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 0000000000000000
>>> [  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: ffffab1b04da3d88
>>> [  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R15: ffffab1b04da3d90
>>> [  +0.000023] FS:  0000000000000000(0000) GS:ffff9313dea80000(0000) knlGS:0000000000000000
>>> [  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.000021] CR2: 0000000000000140 CR3: 000000018351a000 CR4: 0000000000350ef0
>>> [  +0.000025] Call Trace:
>>> [  +0.000018]  <TASK>
>>> [  +0.000015]  ? show_regs+0x69/0x80
>>> [  +0.000022]  ? __die+0x25/0x70
>>> [  +0.000019]  ? page_fault_oops+0x15d/0x510
>>> [  +0.000024]  ? do_user_addr_fault+0x312/0x690
>>> [  +0.000024]  ? sched_clock_cpu+0x10/0x1a0
>>> [  +0.000028]  ? exc_page_fault+0x78/0x1b0
>>> [  +0.000025]  ? asm_exc_page_fault+0x27/0x30
>>> [  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec]
>>> [  +0.000024]  drm_exec_prepare_obj+0x21/0x60 [drm_exec]
>>> [  +0.000021]  amdgpu_vm_lock_pd+0x22/0x30 [amdgpu]
>>> [  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amdgpu]
>>> [  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu]
>>> [  +0.000316]  process_one_work+0x189/0x3c0
>>> [  +0.000021]  worker_thread+0x2a4/0x3b0
>>> [  +0.000022]  kthread+0x109/0x220
>>> [  +0.000018]  ? __pfx_worker_thread+0x10/0x10
>>> [  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40
>>> [  +0.000560]  ? __pfx_kthread+0x10/0x10
>>> [  +0.000543]  ret_from_fork+0x3c/0x60
>>> [  +0.000507]  ? __pfx_kthread+0x10/0x10
>>> [  +0.000515]  ret_from_fork_asm+0x1a/0x30
>>> [  +0.000515]  </TASK>
>>>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> index afbe01149ed3..711e190a6a82 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>>> @@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>>>          struct amdgpu_userq_mgr *uqm, *tmp;
>>>          uint32_t queue_id;
>>>
>>> -       cancel_delayed_work(&userq_mgr->resume_work);
>>> +       cancel_delayed_work_sync(&userq_mgr->resume_work);
>>>
>>>          mutex_lock(&userq_mgr->userq_mutex);
>>>          idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>>> -- 
>>> 2.34.1
>>>

