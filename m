Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676C9D1A45F
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 15:07:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF1AE10E476;
	Mon, 14 Oct 2024 15:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H3wjA5dt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63A4810E476
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 15:07:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dm1F7WxCeZGonK+va07QyMjHdU7xtGRAUDZgnRBJ4oTyO4Nn9MoCw0LQ0K+iMYcv95Q+XR+FB+ZYm7xNXD7FCEUWVq0+6vBxx05VgWYve3vBirz/kImN6Y+6vW8NB1virvIS6TXocCR4B1HmKKDaJLIn7gdxKNQQFjrCEIU6iPhZ4EeEMbn0YxHa9gz5stqMhprHGJBZrqpTh/kxYT7NOX89SHQmAAUQGkbFP4b6N2vA7f3WGFZNJ1aZe2TBBQvjS/gNpGlcLz03HHw/uExZ2gRqDNLoUUe/UDBwGg6T7Gk4QFGXhJFKRHVAesa5lWVof7jrCgKd0n/Njuv2N1AL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQDKpmv9F+0ZEc+nrcu7QT0+5o/AK2i+1Ijn2Ml7AOA=;
 b=cR3KYjoChogv55/9PElV0ERn7txeyDBYKi1oRHXDjXLJCiVg1Ui3bRVauKQJSOP/v8axmv+xGHvR57TQRKPoV5prvVNMWlAC3Cor2TmCuIoAt3RkJBIMsxCPrOLPTicrE3ksTtDOPB5frfQ4pdzsocYhyu2j3D+CC3zCBgHvYKjOGS6WUeCsqFWbRHIXsez38aL58+O5yvZP32H8/WZTc4Q/RX1at4IZeeCWtHYhKyG66efhvO2g8sUiUL1hfaOtcS5r0sMFO1TtH5FF/EmkoKq5o7QkI5e54xu4wkRUpR3DfHm82TLtuFF333RT7f7JfO8VOIyjz87jyL3loevF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQDKpmv9F+0ZEc+nrcu7QT0+5o/AK2i+1Ijn2Ml7AOA=;
 b=H3wjA5dt+ZyAihPFO7+pidpn1E7TehUZHosTBzbnTQLclRFtemAGF5fI0s62FPs6osIBnAEgnSC6FI/C/jYvHYGvnQYXITsKOa+z4QnZJltnqnZjvWg48Ga8PRnOdnVeFn9IrZGyxuu+Ke2edCmGY5fhMuEAi2VRDsOmQ5ydRsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 14 Oct
 2024 15:07:44 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:07:44 +0000
Message-ID: <50fd40a9-3369-4016-a93b-b90b5b25e444@amd.com>
Date: Mon, 14 Oct 2024 10:07:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: change kfd process kref count at creation
Content-Language: en-CA
To: Zhu Lingshan <lingshan.zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: felix.kuehling@amd.com, philip.yang@amd.com
References: <20241011144155.120290-1-xiaogang.chen@amd.com>
 <c7d42fc6-6164-4080-a90a-b53bd7cd796f@amd.com>
 <15671ab9-264c-4a4e-bb28-8c4da30271b9@amd.com>
 <2da699ed-634d-4710-9539-a28ede17c41b@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <2da699ed-634d-4710-9539-a28ede17c41b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::26) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 671b43d4-0857-4653-290d-08dcec61f4e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmczanJRWFRiait0bGVhZVgyTGtSd0JqSGF6MlZ4a2hhWWxDRW1FZlJWWXN0?=
 =?utf-8?B?eFp2Rys3dEdlTXZ0V0cyZEl1TnZSNkdpNGxidFZJYkpOOEhoSDJWM1FocFpu?=
 =?utf-8?B?TEUwTERKNUpSUEtDUjFuT0E2cUsveGt3cW5KOXNJUnhpM0NxV0JiQjZIZnFS?=
 =?utf-8?B?OEpCV2pqWXJGVXZkc0ZQalc3NXpPTzJPa3pjaE8wYStweTU5Rlh1bll2bWF0?=
 =?utf-8?B?U1lsS0U0d1R4OW15bGpzZUV4USs4ZzJsRldVK3FsL01ORW1pbHlhS3BQWktI?=
 =?utf-8?B?WlllckFQRXc2Q2ZZYlYzZVBlMzRuUlFUcHNQRkgwbEo5OENac2g2SXlUMlA4?=
 =?utf-8?B?bHBvSWZtbGtva2Q4NlNya3lJUUtac0FNc0J0OWl5UTVMMVQ3TjJPaFNsQUhh?=
 =?utf-8?B?dDFkTExsblU5dElMR0RTTVpFWUVUN2h6VUhjZSt4L3d2cHQ4VTdTZ0FkNGZ4?=
 =?utf-8?B?eXdZU0dpNlFJeU5SUUlqdmZLZS8wSWtQSHZ6MjI0SFBYOGt2RVdjYUFraHNn?=
 =?utf-8?B?aFZBNHFHdlc2WmFMT1hPSG9HWnBSZ29CRXE3N25ibCs5bnErcWMyUlAvcHRD?=
 =?utf-8?B?cGlWL1NLcG1kbUVEZHI5YVlKQ1A2clFZdElBdU9LUDdwTmlJbTVPOXFBWTdp?=
 =?utf-8?B?TnowTEYzc25rQU1XVXhOZ2UxcFZiUy9xd0RobDFUcUJqRTJSalRIQ3gycVVE?=
 =?utf-8?B?UEFQc2FTOTFIWFV2NEljcnhOaEFqc3hZSVppQnBqK3pKVXViNk02TnZZUThR?=
 =?utf-8?B?YzBVNlR3d041cUJGMmY3NFc4cHpZdTVwSnZic3c2QVdXZmdVWUtOR3ROQURu?=
 =?utf-8?B?eGxmSnRwVEkrZ1Fia2xNVm43YXhSblo4MXNmSWJZUm1XaFRTU3F1azA5eWhM?=
 =?utf-8?B?V1ZQS2s2bm1IZDRvUkNJTGU0Wjd3dnNNWGUyMVA0bEY2WnlsRVRTRFlWRlZR?=
 =?utf-8?B?Mm9Ldm5kdGV1Zy83SDBGOGlqU1Jmb0Urd2NnaUc5MllGQzAvTllWcTY0VnJ0?=
 =?utf-8?B?eW1wSE03NEN1bmdLV1QraXUyd2pkY1V6WktaVGhodXBTUDQ1dTdyeVFnbEVR?=
 =?utf-8?B?USt3cFZ1Z2pxWkR4QWFHZDhMNUlPZXRETFhyUVpiMW0yc1J0MFQxTUhJSW5M?=
 =?utf-8?B?L1o2d2JQZVo1QndzdldvYm5kZjU4Qll5WnJUMmtmSlhVRTFtM3RxTDdxTWxs?=
 =?utf-8?B?T3hlM1VreExLWG5pWUc0R1BrRVNBZldHRkVPL2RTcDdtQzd4enJTK21DSFpj?=
 =?utf-8?B?TTIwbVpWdGl2dm1lcEh4bzhyUXRJak0rNFBPQ09BbU0yTVYzMTIvQUFOWWZl?=
 =?utf-8?B?NHBZU3dKemVNVENQWGQ4OXh3S1BoK0NKVWRkd21vcDlJOVJsdzV3NlRhYTJN?=
 =?utf-8?B?Tm9NWnl2ZGZwcWYwWFdLU1V6ZHNmM1JwaUdCRGNmanI5dVBEalB4cTVmcm5U?=
 =?utf-8?B?UHFlenBMcDN1WlJpQVhkcjBmVEN0NlNJU0x2bEZTYmU2eGxiQjhOd0YyRnpz?=
 =?utf-8?B?OE1kdEVQNlU5TW52U1lrbmx4NXJ3eTVYTVd6LzNZcEFVTGlUQ1pYRTRSK1Uw?=
 =?utf-8?B?cTdtZlAzWkR5RTc2cjVnTUhjV083TSswbzVDYjU1ZnlPTjZhd3p6NnEvSUtK?=
 =?utf-8?B?MndnQVdVOUhpbmZxWDRCNzBuOHNIY2Y2T1psdEpaR0ZRVk8vUDFQSkI5YUNh?=
 =?utf-8?B?RE9LY25ZMjFSQm1QdXZIR2t6aTdoRmNaKzBPdkk5MVoxalYxcHk2dFJnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEQvS3BvVW9oaHAxeTJQL0ZDYkZOcnh5RXBPaFlMdTBXamo0R3pHMXczcHdW?=
 =?utf-8?B?NTB6Q2JqbG02cmZJN3NLb1ZjQ29rUzdDUmpnbWc5a1ptY3hNRVRZVEtzbUZt?=
 =?utf-8?B?alo2aGk0STJxYWxaNTJBb1dIREpYdHp4MCsyQlk5NGd3VFV4Zi91VkVjRXJ1?=
 =?utf-8?B?bUtZeDNVZ0VHdlVPUC9NRDJKc1NZUUNTNmJKSm9ucVMxNEpTMzMwdERxL3J4?=
 =?utf-8?B?YkdBRk1LeE5NTVcvZ3Z0cWJOYkVnN2VHQzhpRmFjT0pTbndlQnpJL09raDk3?=
 =?utf-8?B?blZCd1NFb0hxMks3YlNnemV1aU1jQldwMDJ0TWl0a0sxcXl0SlQzVEQzWE1G?=
 =?utf-8?B?ZDZjNmZDY3BZSXVId0NWNzU0TFVNSFUrdmZuOEx2bjF2Ly9lR05sdUVZbFE0?=
 =?utf-8?B?T3R3cEhqeFZ2bnFJNExibzJKNm1mYVVocVZwTU1mWHd5SXBjMXhob0hlM1B4?=
 =?utf-8?B?Uk9LWHcxUVFQNUNIbm93SkRIR0pwbm9pK3I5TEtuQTNpL0hiK1pSY1d4M0lU?=
 =?utf-8?B?V3pJa1ZmY0g2ODBIWEFBREtzMTVWVzJwK2lySmIyNlBMN0JaZUlqQ3BJQ3FK?=
 =?utf-8?B?YnA1ell5dUZjVXkwblpEOTNBQjRKRzFYOEJZMEdSb2tvTzEzUmlqdU9RSlBu?=
 =?utf-8?B?SkZEKzBpeGNyenM1T08vYzJ1WXh4SmdEZEtRS1VrblB3UkgzSXN0eSs4Tzc3?=
 =?utf-8?B?T1RqME5pTWp3SDNGS3dzMitFSVdrMEc0QjdqL3hmSjhmOHlIblFPM2x1M0ty?=
 =?utf-8?B?M0JkSWxtdlJQbTZacDAyY1VRVmU4RlBFNGNlMU85NXhoQUY3L2R0c28xcU1s?=
 =?utf-8?B?bzl4WFljY1FLMVI4dVBDYzJhZXV5MXBTOTRoaE1TYXpnTHB1eHoyQjF4RXFG?=
 =?utf-8?B?aVhkVmNubnlIVlBwMUpqdVdMRkhxOVBndzRjbWV4VjIvcVRzeG9LUUNZSTNG?=
 =?utf-8?B?Y2dSYWNSWUVlQ3NpYSt2TDN3S1dGQ2lRdndpREdUazI5cDlrK292TUlPZkgy?=
 =?utf-8?B?YmMrMWZRSWZ6NWxOYUdPOEVhT05QTjdvMi9kVW5Ublg1WVVsb3YwcER6ampK?=
 =?utf-8?B?ZWdVMS9SeDJLNE1yem9VY2lBVTNIcFJzUmpJWnJ3VWx3QlhTZGFwdnU3TXVL?=
 =?utf-8?B?L1hMTUZabWE1TTlrZk02OTMyc0N0d2IwTEhsN2NwM3NSUmlGbEdJMmNzcHhn?=
 =?utf-8?B?ZHA5RlJuZUZwNXlJVmQvOWR6OVRGVzE4K3NKQmV5NkpSNUpUenRkalM3ZEhm?=
 =?utf-8?B?M0tPY3Nwb21FREcxdjh6T29ETGhtYXhzL1FvYi9mbkE1YWEvcGR5OTc3dWJi?=
 =?utf-8?B?dFp1c3BYK0NBVjFzTEhSQkkwdnpRZXNxUi9LTVlkV1FZaGF2QjZDTVJ0QTFW?=
 =?utf-8?B?OVRSSDZaZFMzSjJkbmhxMnV4c2kzRFNXejljeTdvSGR1NWRGemxiM0QrQmlL?=
 =?utf-8?B?Z1hGM3h3a2tGMmFhUGgrQU11QWFtRTNCTGRlTjRPWVkwMUtxdWZSQnFZNm9L?=
 =?utf-8?B?WXl3T1dmVWtGaWl2ejVzQ25uMmExaUFldkhTVlc1RVZQZUxoQ0NRc0I0a3FC?=
 =?utf-8?B?ZkwwdHk5MlVTZGNKTEszMGZZZGg3bGVFTFl6d21aRW4waW5LSHZ5bGFFTzZ4?=
 =?utf-8?B?MUp6WWw3YjVmMExFNUptaGI3TGJUb1VlMktycXVmbmUwdkV5QjZoTVRvTXRu?=
 =?utf-8?B?YXRQVzdTZFBQZjc5TkczcHpCOXg2eXg0SytadmN2dmRkVm9CN1pQZ2dDdGx6?=
 =?utf-8?B?Mk9xNW02cTluTWdVOEoxWjREVHJKcnR4cU9QenpRSGU5K1BUcHRXc0NaUnF4?=
 =?utf-8?B?a2wzSDFZeGpabGMzODRIcGNGcWdCUnpRenJiV1hPY0U4ZXB6REZvZlhPbDhV?=
 =?utf-8?B?RjFDQm00UEY4UHBRNHk1Q1lxVlpBVWJYZ3l5WTNUd1hpUXJwcHJwcGtYT0NE?=
 =?utf-8?B?SURCaXE5dXNMWjgrVkc3RzFMalNLNFlLdE1MTVMxU1J5NWc1ZC80cXhYUko2?=
 =?utf-8?B?Y0JDUlVxT2ZrOU5lNEtkVnZJR2tNSkVYek9QM0pkY3B6STVZZ0c5L1MrMThK?=
 =?utf-8?B?cVFhR0kwTHVpYWJ3SkRLc0M1R0hsVSs2YkRrVVI0a1dLTFdrRGhreUlhL2ZI?=
 =?utf-8?Q?E6dU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671b43d4-0857-4653-290d-08dcec61f4e9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:07:44.6041 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKorI3vKi48utGNGtXCNzq4/3x7nPjXQXdl9GLTDVoWS3r2BHE5X/pJu27P8dn8R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
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


On 10/13/2024 8:55 PM, Zhu Lingshan wrote:
> On 10/13/2024 1:30 AM, Chen, Xiaogang wrote:
>> On 10/11/2024 9:56 PM, Zhu Lingshan wrote:
>>> On 10/11/2024 10:41 PM, Xiaogang.Chen wrote:
>>>> From: Xiaogang Chen <xiaogang.chen@amd.com>
>>>>
>>>> kfd process kref count(process->ref) is initialized to 1 by kref_init. After
>>>> it is created not need to increaes its kref. Instad add kfd process kref at kfd
>>>> process mmu notifier allocation since we decrease the ref at free_notifier of
>>>> mmu_notifier_ops, so pair them.
>>>>
>>>> When user process opens kfd node multiple times the kfd process kref is
>>>> increased each time to balance kfd node close operation.
>>>>
>>>> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_process.c | 15 ++++++++++-----
>>>>    1 file changed, 10 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> index d07acf1b2f93..78bf918abf92 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>> @@ -850,8 +850,10 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>            goto out;
>>>>        }
>>>>    -    /* A prior open of /dev/kfd could have already created the process. */
>>>> -    process = find_process(thread, false);
>>>> +    /* A prior open of /dev/kfd could have already created the process.
>>>> +     * find_process will increase process kref in this case
>>>> +     */
>>>> +    process = find_process(thread, true);
>>>>        if (process) {
>>>>            pr_debug("Process already found\n");
>>>>        } else {
>>>> @@ -899,8 +901,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>>>            init_waitqueue_head(&process->wait_irq_drain);
>>>>        }
>>>>    out:
>>>> -    if (!IS_ERR(process))
>>>> -        kref_get(&process->ref);
>>>>        mutex_unlock(&kfd_processes_mutex);
>>>>        mmput(thread->mm);
>>>>    @@ -1191,7 +1191,12 @@ static struct mmu_notifier *kfd_process_alloc_notifier(struct mm_struct *mm)
>>>>          srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>    -    return p ? &p->mmu_notifier : ERR_PTR(-ESRCH);
>>>> +    if (p) {
>>>> +        kref_get(&p->ref);
>>>> +        return &p->mmu_notifier;
>>>> +    }
>>>> +
>>>> +    return ERR_PTR(-ESRCH);
>>> this cb should only allocate the notifier (here it returns an existing notifier ),
>>> so I am not sure this is a better place to increase the kref, it seems coupling
>>> two low correlated routines.
>>>
>>> kref is decreased in the free notifier, but not mean it has to be increased in alloc notifier.
>> Who referring kfd process should also un-referrer it after finish. Any client should not do un-refer if it did not refer. That keeps balance in clean way.
> I think we already do so, see any functions call kfd_lookup_process_by_xxx would unref the kref of the kfd_process.
>> The current way is using  mmu's free notifier to unref kfref that was added by kfd process creation. Ex: if not use mmu notifier there would be extra kref that prevent release kfd process.
> I am not sure this is about paring, current design is to free the last kref when the whole program exits by the mmu free notifier, so it would destroy the kfd_process.
> MMU free notifier would be certainly invoked since it has been registered.

This patch is about having "get/put" at correct places, or keeping kref 
balance in a clean way. We have 'put' kferf at mmu free notifier why not 
have 'get' kfref at mmu registry(alloc) notifier?

Regards

Xiaogang

>
> Thanks
> Lingshan
>> The final kref is same. The patch just makes the balance in a logical way.
>>
>> Regards
>>
>> Xiaogang
>>
>>> Thanks
>>> Lingshan
>>>
>>>>      static void kfd_process_free_notifier(struct mmu_notifier *mn)
