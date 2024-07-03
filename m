Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3D1C2BD09
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jul 2024 14:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0314410E8B6;
	Wed,  3 Jul 2024 14:10:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1PGoLuWE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5237F10E8B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jul 2024 14:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT3NBM4pCdJOLqqAXMWOlpPCngUUQ4brcfO/xIU+yP7bzfx1zwcPr928avqGpQBboJFuf8Dl1lxXCPShnNMAFJXKr5SwncWD19BK4SDaQrV6GLGy3d1PVFPoywORZwTqXR9d4NhsJ+5xtJsHztTZW8bcsMBkgOTbuZoIOHyuxXGGShIrB0GcqNi8jQI1Qjy8rubYWZ8PpxBHyc1kDu1zsLSgSSwm/xsQ3+hq+KXkjssZOM8JjeMVvT/FPeUzkJbO9G6KeOo+iFxvf6G+/fj3Qse0UJ+wxYS1H3veIakU1U+CVLag88XFzKW5jEy1bfD2PkWBNsZiHXDawST/9Hq/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzNH8QeAeYzaIrXPsXk4vOfDG6Gg1Lvhzzqp4+ffDQA=;
 b=OT2aMAWkVpu+Q09DItbaH/rVoQnuwa9/8vfqfPOBZMKBdejfVEtJprfEb0log12TjYFZ/PVLJYpHZvPu2khx5SwzLN+j7lsaq1uX9LH77WfzkpTzxzXSaIAvep4TjBcNVJshqEqZiGpoupBvlChqonhDWxPbFvWLWRxMyDRdm6gppaWnCZhAk+xKqpWyt2R0MaIvNKk+hD/R4Sp4VdM9uZHD+RxhMx6aN0VBSJPnfrEr7vbtRYogr0NKFn1ANOl5MYFQMsE3P9eavusYYS1DkuA2yEmiy3GMP7pzR1hA/F/CNsGaWCDwezR27Ret7MwiLcUvi2FiKJU+//5IDl7qBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzNH8QeAeYzaIrXPsXk4vOfDG6Gg1Lvhzzqp4+ffDQA=;
 b=1PGoLuWE86vL3Wrf26AYtdedpHZSOl2mY0VK0VExKTL//d31r6FVEd/NoDZwAdV1GPOLSsF+37tCOIo6Fn+sbt0ZGAM8rMdXu51ivoAG8kz2tcYgxjpO5ZrVMq5u23KcaLy6JhLYf8mcZBGkkELrM+7RKjFEdroTAEK3sKYPFg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6184.namprd12.prod.outlook.com (2603:10b6:8:a6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 14:10:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%6]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 14:10:34 +0000
Message-ID: <5a63063e-a3c3-4ce5-ac7b-95aafd7dffce@amd.com>
Date: Wed, 3 Jul 2024 16:10:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disallow multiple BO_HANDLES chunks in one
 submit
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20240702132357.327220-1-pierre-eric.pelloux-prayer@amd.com>
 <636b7a69-f6e4-41b3-886b-1dbe92d15479@amd.com>
 <f014af20-9d7b-4276-8e06-eb48329d2f16@damsy.net>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <f014af20-9d7b-4276-8e06-eb48329d2f16@damsy.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0071.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 2323407d-bef0-4312-77ae-08dc9b69e7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEJiWjlhQ1lTY29jSGRraFZwNzE3WVVCbjJpUWNVNjhlMHBjUXJaM2FPTU9O?=
 =?utf-8?B?YlZpSUZFcnJtK3ZQbEM0TmhYc3dVSnJ1WXpiVUxZcWJtQ1F1ckdEUnp3cW5y?=
 =?utf-8?B?L2tRbnJYQVI3NGVOaXNyeFNUWGtmU0l0SExnemhXenY2eUpNWUlGbEJyaGhI?=
 =?utf-8?B?WmswZDhFY3VvMUVNdTVidzZyek5uQjlvSzlmc2VkMVVQTnFpUHNlZVl4Z1hJ?=
 =?utf-8?B?Rko5WFI0ZzRXT2JyTThiVXd2RzZ5S1VHdm51dVFFZlJsT3FaeHJVQXpERTJj?=
 =?utf-8?B?eGFZOVhpNm9PTmh3N3psWUt1dmRZdmRhdHJJUC9DYmk4bGJpUFBaZXlFTGxM?=
 =?utf-8?B?VytrUkNWU1g2dmxxVERVY2FJYktnMStmSUxCaVVUcTFnZkVweXlwWGxXaUty?=
 =?utf-8?B?aGN5RXQwRzU0eWtKUDdOT3hNbS84VlNzdDF4emVWZytFU2tSV3hDRXlxenNS?=
 =?utf-8?B?OHZWdTJtQngvV2wwSWFvTGowUGZNTE9FbGs1OE1vVDVrLy9QdVZZMnpPb0pM?=
 =?utf-8?B?Y2I0YzYrUURkcGlxR0tEOTFkakxUM3NnZEMxTEY5NlhGKzk5Q240SzYrcUE5?=
 =?utf-8?B?SzVIOGc0SHFlVklqMkJrTkpsVGIzazYwaWs5NDRJYTlDYjRsekZ1WUxvVTJz?=
 =?utf-8?B?N2hMYTdPZCtOektxSTJ6NHpHYmwvSG1QL1BJanZzaXdmMitvTjByaUNTMnN2?=
 =?utf-8?B?Q3lBcXdmTFE4SGUybEt5eGVYRlJzbHZ3YUF1YnBVSnF4KzQvK0VVZ0RhYk1H?=
 =?utf-8?B?aS9RSXV1RU9FNDJIN3FYNk96Y2pSaG5CUklPQVB6a1g1eldId0FaaUF1YVMw?=
 =?utf-8?B?bDhzU21EWk9WbkVDZmZ4VGFoL05aRU9ubk53bkJqYlJCRkhBSUUwVlJENXNu?=
 =?utf-8?B?YXh5S2xEZEpESkl3YlVuK1o2cHdxQ20rRHZHSDZSQXBUbDJ2UWZWbXIvYi9N?=
 =?utf-8?B?T01RT1VQUkxDRVNqR1ZjYmJ4TnNQYUJ3UFZPdTdYYXU0YlpTOXYzTlpaWVlV?=
 =?utf-8?B?K3I3RytOWEhUMUpCSnZZUUcxTk1RSVNxQXN6aHlHLzN3U0trYWUxQTd1bnJV?=
 =?utf-8?B?RzNzbENqREZ3L1hHTkhPYm8rSVFwTGM1Tk1PZXE4ZWxpcTJLMXQzeTdRNUgw?=
 =?utf-8?B?d2ZCYVg3TlNseGk4c2hHbVAxQ3dQcWFNaUtRcWFVRUx5TXVFUDdqRm5wdWI0?=
 =?utf-8?B?NSttL3NXUThpUE5pVnhLZXFrbEFPbFpQSGlyWFBkU0ZLTjQ3TnJOcUhYM1pQ?=
 =?utf-8?B?a29lUkZHQWwwR0ZRcmJPM3hsWldHTjRMTy9TYWoxenZ0akxLd2lvcURoTWx0?=
 =?utf-8?B?Wlg3MUNSNEFIQkIvUzNaYnYwN3QyVk1oRENzTjRsK2R0eERTeE9KLzB1bmY0?=
 =?utf-8?B?cEpIdUNPaUlHL3FRYk5zL3U4NjNGak85K05IWnJ5akpMbmk3L0orYVMvTSsr?=
 =?utf-8?B?dGswVXJqaHBFT0hQT2FRUWZvWDVlM0hxRE1ZVS93Y0NkMWJmWkJmdzdKMGt5?=
 =?utf-8?B?Ni9WTWlzb3E5dEdpcUx6RytJSmNSbm5RQzRteUJ6aUN1N0JXZnhDRUlYMENG?=
 =?utf-8?B?cHczVlA1b1lDeUR4MGw5ZXBTaU45SzgyMWsvaVEzVmFaNjZuQUg4TXA2OElN?=
 =?utf-8?B?MCtzTUg0NkNCakwydXE0cDRGdFg5QUJZSWRLNGNYdFhLeUVTRU0yR1ZRWUhy?=
 =?utf-8?B?d0ljeWxWN1NPSVYrMWRQSVYyQ0p3N1NvVzB2cWNpWklVN3l3cU5hdlVHclc0?=
 =?utf-8?B?aGJFUkxxaW5GK0g0SGEyNTNOMWNhUDMrdUh6VW5PRTlCU21zcDBqeG5YcFRY?=
 =?utf-8?B?SlBwdVVlSEJhdlIvbCt6UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0F3Skl6bTYvYUV0QklVOURKdTZBRXM1RG81UThWNVBXbmFMYldDL3lHQWJ6?=
 =?utf-8?B?azZwUEtHTG9NUFIrcW5jUGU4UkZoWFhQLzdUODdVZklZdFN5Y3BTVGJqb3VJ?=
 =?utf-8?B?ekVwRVlJd2FsT0U5WFhKNHYzL20yc0p4Y25TTGRvRysweGZta29WcFZlTzhv?=
 =?utf-8?B?Yk0zYk1nRS9henFTU1hRR1RSeVJtVDl3aUpMMkZ5ckNlUUJISGNDdnVMVXJi?=
 =?utf-8?B?OUZzNzBEd29zWVphaFljMGg3RjQyMW40aGMrTWJWTTh5WGtPZTRzMXVub1Zl?=
 =?utf-8?B?ai9hT2hicENaTDZPTTRhdGdVZVRwSUNJdHJBemJKMEw0dEpveUtXMDZSZ0R5?=
 =?utf-8?B?ZVdwSTZMR29iRjFlUmZXTk1sMkJuMVVMbUlvd3JidUx4L1dBM3o3KzFxQWU3?=
 =?utf-8?B?cC9oTDkyNlZ4S1p5MjN3aTRLM0pCRDliZXMraVZiUHFlWUxTSGhaSEJkT2gr?=
 =?utf-8?B?N2IvZGx4SjhMTmFvYkpXNXlCa1ZaMEoxUVZWMW1tTDI0L1BBQ3ZsNnhSZUNJ?=
 =?utf-8?B?ejRzMkRDb004VENSZElXcWphdVp0cjhqc1ZiZUZxR1NydWV1NlJaTXZ4L1dV?=
 =?utf-8?B?UHNNQ2o5ZGxHRm1HZXhuUHMrdHpPSktJbUhzR3prNkFpVER5UC92bTkxVnVT?=
 =?utf-8?B?MHhyTmpteXFuYndqcldDRVViNE9qOEJFVTNXdDNhUEduL1Q4ZEF5QXk3SXVS?=
 =?utf-8?B?SHNYc2NLTGRtVzJhc0NEWk9zMDI2ajlhU3I4NWUyaHFaUkhBb2Q3ZE91TWFq?=
 =?utf-8?B?ZHBMV1A1S0UwSVdxSXY4YlhBOGJmUHdhNnB5MFcyeDY2NWdJTWtzekdLNlg3?=
 =?utf-8?B?NmNuaUl2dEJXbk94dG52L2NLeUE4Tk1JTFh6ZDg1c2xTNlJ0Rmlic1FKSmtF?=
 =?utf-8?B?Y2p1VnhSUWNYYXI5dndwSDhHR2NzalJnRmxucW9DMmhlbElQUTlPT3FIR0sw?=
 =?utf-8?B?MW1URnRmZGdUNWNxUGFJaG1hYmtOYzkxVGVWRUd4Y3A2T0E5dHhvM21vbUdP?=
 =?utf-8?B?b1ptTnpQVHBFSngza1c0Wm9pM041M3BiK2VIRFFvMkZtQlJ4aDJvMXc4dG8r?=
 =?utf-8?B?cllENVJxeUhLVDlZYW1hbGp0NnM5Rjdzb2lQUFluOGIzWjA5QmFjY1Q2TDdU?=
 =?utf-8?B?K1NBb1hjbXdtTHZBZ2VtaDIxS2ZqNjNZL0ZtUzRDay9vT2xFTitxWGJyTDNZ?=
 =?utf-8?B?NEhQOUpQVmNZekxJb2pDUmgxU2FKdVQ5emh1bDlVWHo1QXVTSStzclBhMURs?=
 =?utf-8?B?bmprS2VFdjFFSHhPVi9LL21QWklUZ0M0RTlxdmxMU1FGSzVWU1pqMFpUZElp?=
 =?utf-8?B?ajNPQWtXcGFDZ28xQ0o1UmVnMzVxVmUzZDdpRG5JWldnWlc5SDI2L241NlIw?=
 =?utf-8?B?Qko2cG5sOGRCYlBySHRpUWNiNTloTnlLaFNIOXo5WWlrOEtvR2xWc25NcElO?=
 =?utf-8?B?Qk4yeUFqL05NZzZNVnlNc25Eb1pxRFlucEdQWjBXNit4a0U1WlMxbDN0SnZJ?=
 =?utf-8?B?bXdQNWtRd2ZIb3lCVDRRN2VIUlNKWUlESlMzV1djUjRBYzlkNTNadVpNUExw?=
 =?utf-8?B?NnF1eTR4cWxzS202OUxhSUpyUG5weUE4MWhMN2xjbGNJTXdQRU8waW1CWkJT?=
 =?utf-8?B?ZWF5L2xXdDk0WVRIV2F1Z1dwMkJKTnhhUkZZUHNucXFMYW9sWUdXUnFvSzFK?=
 =?utf-8?B?K2oyY3d1VkFJTWxpQ3FaNjJaemxhRDVDakMxZDZQaHBaaDVQTFFUK0VuR0JW?=
 =?utf-8?B?WGMxWHBhekF6MURYWktuL2VNYmVXMXNkYkJXLzlDaTIxclNVSVhQRTFjaWF6?=
 =?utf-8?B?WmVoUi9DMGUxMVZVbGpWQ3VFRUk2QUxEc0o4Sm5IMG1BMG1BT1JSbWFETnNU?=
 =?utf-8?B?OFBVMkRRMitVVTVWYUlwemJ2NWpoQUdJYjUyTDJTZzlkRzFxeTJpclJiSDdL?=
 =?utf-8?B?SlRGT3NDbU5uRmpQaXJSeWxKOXJlcll2NjRXM2FTZm5UTitxN21ib3grYmRW?=
 =?utf-8?B?L2ZPQ2JkekcvL1dPcThGaXBJS3BqcFVaYUNobHVXeFJHaGhLWFl4VXg3TEQ4?=
 =?utf-8?B?Zm1RS3VPekFUSkdnVGlua1NnTXllb2FyMi95STFqRzdmOXNqRHJtaHhzQ1l2?=
 =?utf-8?Q?4hfpBqyFJd0jX3gDoADDv+tE9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2323407d-bef0-4312-77ae-08dc9b69e7de
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 14:10:34.6815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCUunMOABysuhwfw6feSi1EmMwVutrF8A+KVVCKAApS5nQ2r9cRxD30GuhSaPh6E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6184
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

Am 03.07.24 um 14:48 schrieb Pierre-Eric Pelloux-Prayer:
> Le 02/07/2024 à 15:35, Christian König a écrit :
>> Am 02.07.24 um 15:23 schrieb Pierre-Eric Pelloux-Prayer:
>>> Before this commit, only submits with both a BO_HANDLES chunk and a
>>> 'bo_list_handle' would be rejected (by amdgpu_cs_parser_bos).
>>>
>>> But if UMD sent a multiple BO_HANDLES, what would happen is:
>>> * only the last one would be really used
>>> * all the others would leak memory as amdgpu_cs_p1_bo_handles would
>>>    overwrite the previous p->bo_list value
>>>
>>> This commit rejects submissions with multiple BO_HANDLES chunks to
>>> match the implementation of the parser.
>>>
>>> Signed-off-by: Pierre-Eric Pelloux-Prayer 
>>> <pierre-eric.pelloux-prayer@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> index c08dfffae262..69d168d6f35a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -154,6 +154,10 @@ static int amdgpu_cs_p1_bo_handles(struct 
>>> amdgpu_cs_parser *p,
>>>       struct drm_amdgpu_bo_list_entry *info;
>>>       int r;
>>> +    /* Disallow multiple BO_HANDLES chunks. */
>>
>> Describe why you do something, instead of what you do since that 
>> should be obvious from the code.
>>
>> E.g. something like /* Only allow a single BO list to avoid memory 
>> leak. */
>
> It's not really to avoid a memleak because the code below could be fixed
> to not leak the list.
> This change is really about only disallowing multiple BO_HANDLES since 
> this is the de-facto API, except it was not validated until now.
>
> I can rephrase the comment as /* Only a single BO list is allowed. */
>
> Would that work?

Mhm, we still need to give a reason why only a single BO list is allowed.

Maybe "Only a single BO list is allowed to simplify handling".

I don't really see a use case for having more than one BO list, but who 
knows.

Regards,
Christian.

>
> Thanks,
> Pierre-Eric
>
>>
>> With that fixed Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Regards,
>> Christian.
>>
>>
>>> +    if (p->bo_list)
>>> +        return -EINVAL;
>>> +
>>>       r = amdgpu_bo_create_list_entry_array(data, &info);
>>>       if (r)
>>>           return r;

