Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66C7D2F7E5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 05:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAC510E199;
	Thu, 17 Oct 2024 05:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZZaAo5l";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8D710E199
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 05:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3EKW+fR53ke85B3XBNlOgrkYzdw+ccWYKk5a9vtcHCXgjKGO52tnCB0kvUa6xWIxSPsc6kje/xnx0Gesm4aqosJ3qFBjKM37pdqYgneKUIMsxQX9pc1U4fdLxfKvtilSedQSThxA42QMRE0PtpTlNU1JDpvVl0qrBsnvNZLGyXkcV4MQ0gesrjFdHw5wbm5C6xE2pzKEtY4D+opoVW31tbcGWqyXiMBFysSPv7kv73uM45Lyqy1aDkTDhFrlfRAn6sfu/z/46tpJnoCz3FgTviY2OL/MJRaWiM/74ad48Bq8E2O406qgjYNsscSjFfNS+j9XamE14MRj8znVy4Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FP5Wl6WQ+ryeYudz7SbydgtF9FdEWJNj3ugaX5cBnM=;
 b=dlostTtemqL0iIQUH4kZiwUc4PopnXCK8mgr2tgLtpcQIFaYC93UZBLc1nWYBdrHmQkPDFUa+bWjvXDwCoaCibYF9D3arhoBeVlqwQDYTFcOc1Z0X2NpiMk73tbGq6SYFJci2zFwIVwe+uDvv7b88EYktl8Rx+ID3bE2NlqfY4B5CHXVDlr6KhDpkPuAibxrEZhtSWzpy0Um3FNf6N0LSgzDFH+4d2s4jNCiv/E75qkrnxD65+qv2j5Al8YzPnC8umfgMxS6+wgJWtUywHCMnqnSttUVyIHGtnSuzh/qRLwPnYAhMktJmTL9ZSjmYBem4XP03GtYySRIKO9r02WB/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FP5Wl6WQ+ryeYudz7SbydgtF9FdEWJNj3ugaX5cBnM=;
 b=SZZaAo5lyQitPyRvICdLIUwfUKKLVeXgER3uvRiVxwvhn5+V20eyHb0a/bwTOynJTIlO/HDk11sVPL9wE5qKWpcNI8or5C4SSyT59Hx2R5I8ePqyDEUkTcYrqmiCYRi3FF/cdyBbB3fhKdgh29gWMLIT5LCilp9fZhWVSV89ao4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 05:26:57 +0000
Received: from PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350]) by PH8PR12MB7301.namprd12.prod.outlook.com
 ([fe80::a929:e8eb:ef22:6350%6]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 05:26:57 +0000
Message-ID: <15fc37dd-c775-4fb7-9e37-b41167c31829@amd.com>
Date: Thu, 17 Oct 2024 10:56:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/09] drm/amdgpu: Add separate array of read and write
 for BO handles
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com,
 alexander.deucher@amd.com, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?=
 <marek.olsak@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
 <20241015074309.2484264-9-Arunpravin.PaneerSelvam@amd.com>
 <CAAxE2A7UawQE4UtCzj-SGpmT4iLsxQ_cZuBsrPTe+uq6B8=p+g@mail.gmail.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <CAAxE2A7UawQE4UtCzj-SGpmT4iLsxQ_cZuBsrPTe+uq6B8=p+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::31) To PH8PR12MB7301.namprd12.prod.outlook.com
 (2603:10b6:510:222::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7301:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c0d311-36d3-4dea-93ca-08dcee6c515b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2dybmVxRDUzeHQvR0hJV3o2bmVlWnZsQThyLzczWHN6U3RLMjh3elhUb1hn?=
 =?utf-8?B?YWNXZWlwc1lWakFKVThkaXpUTFY1bEY2cTRuNWxDS01VTFpvSFR0WVVkOHVD?=
 =?utf-8?B?UmdFSHJNNlBXLzAyNnVXTGRLK0FKZlRNRG0yNXlOWVhLMHgvWS81VXluVWdv?=
 =?utf-8?B?YUNXVnBJb04zYjNoOS9LQ2huNGJCTHZ5Zmx2K0llV0RUeno5TWo1VjZlQVdr?=
 =?utf-8?B?eW1lMm5lU0x0TE9SY1J5R3BwTjhOa3U4dEgzMW1CaXNKaEVkRVdjcGxINk55?=
 =?utf-8?B?elBjV0hWajZUUmRoa3BweVZIZUd3YnJLSkhUNUxlMldsRlZLZVV4UVZrNnJQ?=
 =?utf-8?B?YzlwWklWYS91WnR6SWxTcFl3YTBhZGFNemljc3EvcFo2cmhPb2c2YTlCVWlu?=
 =?utf-8?B?OCt4WTczTUhid0c3d2sxbjdsM0lZV0U3bDN3N2VMZGJ3NExKaDg4bjB6Y0kr?=
 =?utf-8?B?cDFDQTdCU0FxMDJYeHdCdjBKSWd2dkRna1dBbXNTS2EwWFNmdXpJcFFEWm9F?=
 =?utf-8?B?TFV0VVA4a3RqRytsTTc3MW5xMFFXQW5rYWJ6QU9nZGVSVDVqeUtxbDh1cEx4?=
 =?utf-8?B?MTh1U2N5WWhaZThIR09nZEhwSXVLOTJ4ZmljbkQvTlpiVXk0ZkV6c2tpTGFF?=
 =?utf-8?B?QThKd1RxSG9MRVpjYmxwN0FJeGlZeEd3TkRobVRuaitVQVNaOUMwNU1RZmEy?=
 =?utf-8?B?SnlMS1ZPYWhOV0xKbjBjZ3FUQmtZSVMwTkpWaUhtc2RZQU9wN3NjRVZkZUhW?=
 =?utf-8?B?RnIzSXE3OExzUWQxNFVWVTRUYUNGdmg4NmxRczZpSGZOdlZad25oQnZ1c3RU?=
 =?utf-8?B?MTNUOXBMNmsyVDkrS0NVOE04c29uWVo1emUvdUJ3NGVPOWRkOHhHYUFmZEto?=
 =?utf-8?B?d001QW5WVWpnUHFTb2loMXVqWDdxMmFnTjQvUlkzYkZyMkVLRXNQaEptZEdP?=
 =?utf-8?B?WDlkZG1pSTExMU9ybGppUElYdS9EMlpIcGJqUVhZT2FMTENQK2RUWmJPK2Zl?=
 =?utf-8?B?VG11OXo0djVyeWhPR3kwdkF0OVBIZVRyMS9ncHBlaHkxb2I4MlFxM3BsU2w1?=
 =?utf-8?B?RTJFcnFyejRKZGdMM05aS0o4RkZMSGJQNUJsMElaQmZhNGhPbXNSV0JhMElh?=
 =?utf-8?B?NXdlY3JwOUgxL2ttZ2Y5RC92b2tuREJHdjZEbE5WYiszS1Jzb3B6Q0UrUnV5?=
 =?utf-8?B?UmpuVXhXdHVYSWloTXlucHBRNE5vVXFQYUt0V0ZxbkhHeDYrNE9YWFdPeWZy?=
 =?utf-8?B?cWhCUHd2NFFhSWc0Q2t1MVBaeUNDVjFKSll5dG4xL0djT3Bidkl6QkxiT1Bv?=
 =?utf-8?B?b1pzT1VEUHdyYVZTZE5jWXFxQXV4R0dqQytZZ1oyMlJLQ3dLWHpUMWhyWi9w?=
 =?utf-8?B?ei9DczhkUnRlbjdleWdEdnkyZWd5UVUvSkF3MWorc3JrQjN6NmlGWktVMkhQ?=
 =?utf-8?B?SDRSV25sTjNudS9KQUt4c1hCNjZPSVE1d3hLVWxBWmlaalY0OElDdGtIOFZB?=
 =?utf-8?B?ZUk4dWQ2blFHUkt3bmNoQmQ2a0hubzljcS9MRHhmNWdpSDZPb1ZJYlBrb2pL?=
 =?utf-8?B?blY4eHREcUNicnhIU1RRamRLYU01ZmlsdGdtOGNBVThlYmdQa1R2b3FMdGQ2?=
 =?utf-8?B?aVEwMDNIMlNlSzlJUlcrNFBzUVVxRUIzb1krMnJiWWZncjJyQ1VuOGVLQXN0?=
 =?utf-8?B?NGRsM25oY0l3eXZ3bTBnMmxtaFlqNTA3WlRUNFU4RGJJd3daN1NNT1JXbllC?=
 =?utf-8?Q?smyRcV3QoIOcSeTkfJqStXtwF+uwFHsLbEtxKtH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB7301.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2lzUHAyYWltVmpKMmt3UzN0eDF0Y3F5UXB6ajhQa0grUWNSdjkvY3dZMkkv?=
 =?utf-8?B?UDVOSXpTZE1mVmpRemxkWHB0Nmp0RE9lclM4SVgzSjJtWEhlbUJKbzFrcWVy?=
 =?utf-8?B?ZWVMalFIOWVqc09mZXJ3Vm41S0ZxVGcvV2tkTFEwVFZRWDZoZXFqVEhjais5?=
 =?utf-8?B?SW1POUZLc0o4Y2xBRjlka2xpb2dJei9tVk5QbVBOZ2owVmhkVzQyQ0pBSHRz?=
 =?utf-8?B?ckc3Y0FpQThmSEVUZzloc1UvUE82WUJxaWlKWElMYjN6aTMwZUYxcU1xU0Rt?=
 =?utf-8?B?Y1owblA5bjhTOEVyQ1B3cG91ZmtmZmF2c0FsaWxkMUFKajN0dTlYbkY3UGhY?=
 =?utf-8?B?UWRyS1FFMisrMlJweFY1VWQ5RG1CdEtHNXUwUXlaMzhOOUJEdEszY21CYzBr?=
 =?utf-8?B?cW96NVR6Mm42QUNuUDlCb0tLQWtqODVOSWhaQnh1bXNIS1lZekFuSDl3cVNk?=
 =?utf-8?B?b2FlWldrR3Y3NUllSXB1ZkNUWTQyRFlKNk1ocXl1blN3eU1IZHBGYXRVUDBt?=
 =?utf-8?B?WDlQN3NibkprOW1RUTF2ME55RVZmbm4rTEovZE45MWdndm9lbWJWQnZPR1hM?=
 =?utf-8?B?M1pvNWEzOFRMaWFMM3FvQ0VlOXRwRE41U1NBL1hLMDE1a2N6Ulk5SVordmZl?=
 =?utf-8?B?V3c2c2QrT3ZXSVNvY3VUK3F4MXl0WWdQa0pxU0hUbXp1SVppMkYvZVBqY0Ez?=
 =?utf-8?B?MmtKTU41cGR6emdRazhnTW9vQldMRENrSWo5K2tBSW1jZVo2TE5UcmZlVUhP?=
 =?utf-8?B?aEdHUnNMdlJadCt6OHEwUTRNNE9JamFjMFB1SjRRNXZ3ZFNFRFlGRUEza2Mr?=
 =?utf-8?B?K0hDekZWU0RoendYQlBWdlVQMlBwUmpGTnFOcW5kUkVNd1VpaXNtNlJwT0Nq?=
 =?utf-8?B?SG16bHlYOEZ3bWRMVHV0cSt1V2FON3NONEkxWk5idFA0MEw0aEVMSFJRdnlp?=
 =?utf-8?B?cFJRbVdIdFlGWWhic21Yc3RBQnNTYXlDM0pKTkxpNFk4R0JWNGhReVNpbitq?=
 =?utf-8?B?SXc0WTd1eUdaMnNGSjVjVUlvQlJ1eTNxZnlhWUN3anFhL2JRTkUzZWpWVG1V?=
 =?utf-8?B?d1dkNHp3RDJZRFc2VHNRRFlGV0kxQmQ2TmZlb1gvcXBjVCs1c2FWTVFLNTBZ?=
 =?utf-8?B?Rzl4c1FiZUJBbzlQeE9LZWd1Y2N2ekJWK2ZuWHZ3Y0lDVnNSb1hrSUdmcXFw?=
 =?utf-8?B?aHlrTG9xWlZGTkk0YzJHWnROR0U0M3k5UmVhaWYyczRQOW0wL0RkRTdaWFI5?=
 =?utf-8?B?MVl4UzYxRzN3L3YwYzJHbUgvM1pqRUEyMlUzcVhLd2dLWkFUd3ZyRGZXcWxR?=
 =?utf-8?B?ampSVHgyb0dESXBta0hzdmEwU09oeWNoeHZtUzNGckhCQ2FqT0FiRWlqbHB5?=
 =?utf-8?B?NFV1L1g0UUxxYmt4U3g0RWVQL2FTdkV5TzdsTHp3dmdpcXgrVWFNK1l0aEpH?=
 =?utf-8?B?eCtXRnRRZGN6Uk41WG1lYURKWDUwUnhYczdvRDRsTi9QZnZ6OUgyTlNUNmd6?=
 =?utf-8?B?YVVzVVIvb1JXeCtiaDRPbnhuRFI5a3Vqdjk3SEJMVnFhZTJWZUY0QUM4UmRM?=
 =?utf-8?B?TlQ0OVhneFd4K2hYVnpnZ3Bjcy9vaEZWWllXS3VWR1ZEM2dkZDdYemlTTlNR?=
 =?utf-8?B?eVF4NzNLamExaWltMEdlbEs5VzkwZ05RNzQ3Q2VlN0R6K0lSTkpha2I1TjlH?=
 =?utf-8?B?S0YrcjBvMzZPZlZUbzg0QWlwczJWZzNNRE9QbVFCbElkU3pmUkw3MUVQdXdx?=
 =?utf-8?B?YVlkMlNlQnpDVDBTcXBWRDFSOUZEMElWVFRLVkdYUWltR0tkb092eXQ3VnNM?=
 =?utf-8?B?RlYwSFhIQUV5aEhER0k4Z3paM0xuT0FIMXRhdXA1L0M5S0pLeVJwS3hnQnRt?=
 =?utf-8?B?dVpiSzdvVlg4blVmR2VpK0Rna3RrZ0pWRHJNK0tWb3h0b1VTR2NtUG9QMVcz?=
 =?utf-8?B?QmY0c0h1MzBSemFTcHRSOENLeWtEaHJTT3FYVzIvcXRNaGtVUW94b1J5ejc1?=
 =?utf-8?B?N1d4SjVpN0ZFZkJLRDAzSFFyaVNsMm1jdHUwR1VmcHZSYjIraDgzZGIyM3pw?=
 =?utf-8?B?RDA2YWFQZWlKQ0JOOHMxNHdqZ3Q5WHRtS01rZFYyTmhqRnREbmMwblZtQklF?=
 =?utf-8?Q?mwsl8aGoRS7lunuB7USq2rDHR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c0d311-36d3-4dea-93ca-08dcee6c515b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7301.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 05:26:57.2293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Vp3p8/vyZDUIANPyWaRC/LSJDqCh++9hXiR2I+75srtqs6hqynJ6LgmQmSoiCUhdE70CymROlzrdTIycZ0TpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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



On 10/16/2024 3:26 AM, Marek Olšák wrote:
> On Tue, Oct 15, 2024 at 3:58 AM Arunpravin Paneer Selvam
> <Arunpravin.PaneerSelvam@amd.com> wrote:
>> Drop AMDGPU_USERQ_BO_WRITE as this should not be a global option
>> of the IOCTL, It should be option per buffer. Hence adding separate
>> array for read and write BO handles.
>>
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Suggested-by: Marek Olšák <marek.olsak@amd.com>
>> Suggested-by: Christian König <christian.koenig@amd.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 238 +++++++++++++-----
>>   include/uapi/drm/amdgpu_drm.h                 |  48 ++--
>>   2 files changed, 206 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 279dece6f6d7..96091a3e9372 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -386,12 +386,14 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>          struct amdgpu_fpriv *fpriv = filp->driver_priv;
>>          struct amdgpu_userq_mgr *userq_mgr = &fpriv->userq_mgr;
>>          struct drm_amdgpu_userq_signal *args = data;
>> +       struct drm_gem_object **gobj_write = NULL;
>> +       struct drm_gem_object **gobj_read = NULL;
>>          struct amdgpu_usermode_queue *queue;
>> -       struct drm_gem_object **gobj = NULL;
>>          struct drm_syncobj **syncobj = NULL;
>> +       u32 *bo_handles_write, num_write_bo_handles;
>>          u32 *syncobj_handles, num_syncobj_handles;
>> -       u32 *bo_handles, num_bo_handles;
>> -       int r, i, entry, boentry;
>> +       u32 *bo_handles_read, num_read_bo_handles;
>> +       int r, i, entry, rentry, wentry;
>>          struct dma_fence *fence;
>>          struct drm_exec exec;
>>          u64 wptr;
>> @@ -417,32 +419,59 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>                  }
>>          }
>>
>> -       num_bo_handles = args->num_bo_handles;
>> -       bo_handles = memdup_user(u64_to_user_ptr(args->bo_handles_array),
>> -                                sizeof(u32) * num_bo_handles);
>> -       if (IS_ERR(bo_handles))
>> +       num_read_bo_handles = args->num_read_bo_handles;
>> +       bo_handles_read = memdup_user(u64_to_user_ptr(args->bo_handles_read_array),
>> +                                     sizeof(u32) * num_read_bo_handles);
>> +       if (IS_ERR(bo_handles_read))
>>                  goto free_syncobj;
>>
>> -       /* Array of pointers to the GEM objects */
>> -       gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> -       if (!gobj) {
>> +       /* Array of pointers to the GEM read objects */
>> +       gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
>> +       if (!gobj_read) {
>>                  r = -ENOMEM;
>> -               goto free_bo_handles;
>> +               goto free_bo_handles_read;
>>          }
>>
>> -       for (boentry = 0; boentry < num_bo_handles; boentry++) {
>> -               gobj[boentry] = drm_gem_object_lookup(filp, bo_handles[boentry]);
>> -               if (!gobj[boentry]) {
>> +       for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
>> +               gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
>> +               if (!gobj_read[rentry]) {
>>                          r = -ENOENT;
>> -                       goto put_gobj;
>> +                       goto put_gobj_read;
>>                  }
>>          }
>>
>> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
>> +       num_write_bo_handles = args->num_write_bo_handles;
>> +       bo_handles_write = memdup_user(u64_to_user_ptr(args->bo_handles_write_array),
>> +                                      sizeof(u32) * num_write_bo_handles);
>> +       if (IS_ERR(bo_handles_write))
>> +               goto put_gobj_read;
>> +
>> +       /* Array of pointers to the GEM write objects */
>> +       gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
>> +       if (!gobj_write) {
>> +               r = -ENOMEM;
>> +               goto free_bo_handles_write;
>> +       }
>> +
>> +       for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
>> +               gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
>> +               if (!gobj_write[wentry]) {
>> +                       r = -ENOENT;
>> +                       goto put_gobj_write;
>> +               }
>> +       }
>> +
>> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>> +                     (num_read_bo_handles + num_write_bo_handles));
>>
>>          /* Lock all BOs with retry handling */
>>          drm_exec_until_all_locked(&exec) {
>> -               r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 1);
>> +               r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 1);
>> +               drm_exec_retry_on_contention(&exec);
>> +               if (r)
>> +                       goto exec_fini;
>> +
>> +               r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 1);
>>                  drm_exec_retry_on_contention(&exec);
>>                  if (r)
>>                          goto exec_fini;
>> @@ -468,13 +497,20 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>          dma_fence_put(queue->last_fence);
>>          queue->last_fence = dma_fence_get(fence);
>>
>> -       for (i = 0; i < num_bo_handles; i++) {
>> -               if (!gobj || !gobj[i]->resv)
>> +       for (i = 0; i < num_read_bo_handles; i++) {
>> +               if (!gobj_read || !gobj_read[i]->resv)
>>                          continue;
>>
>> -               dma_resv_add_fence(gobj[i]->resv, fence,
>> -                                  dma_resv_usage_rw(args->bo_flags &
>> -                                  AMDGPU_USERQ_BO_WRITE));
>> +               dma_resv_add_fence(gobj_read[i]->resv, fence,
>> +                                  DMA_RESV_USAGE_READ);
>> +       }
>> +
>> +       for (i = 0; i < num_write_bo_handles; i++) {
>> +               if (!gobj_write || !gobj_write[i]->resv)
>> +                       continue;
>> +
>> +               dma_resv_add_fence(gobj_read[i]->resv, fence,
>> +                                  DMA_RESV_USAGE_WRITE);
>>          }
>>
>>          /* Add the created fence to syncobj/BO's */
>> @@ -486,12 +522,18 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>
>>   exec_fini:
>>          drm_exec_fini(&exec);
>> -put_gobj:
>> -       while (boentry-- > 0)
>> -               drm_gem_object_put(gobj[boentry]);
>> -       kfree(gobj);
>> -free_bo_handles:
>> -       kfree(bo_handles);
>> +put_gobj_write:
>> +       while (wentry-- > 0)
>> +               drm_gem_object_put(gobj_write[wentry]);
>> +       kfree(gobj_write);
>> +free_bo_handles_write:
>> +       kfree(bo_handles_write);
>> +put_gobj_read:
>> +       while (rentry-- > 0)
>> +               drm_gem_object_put(gobj_read[rentry]);
>> +       kfree(gobj_read);
>> +free_bo_handles_read:
>> +       kfree(bo_handles_read);
>>   free_syncobj:
>>          while (entry-- > 0)
>>                  if (syncobj[entry])
>> @@ -506,28 +548,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                              struct drm_file *filp)
>>   {
>> -       u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles;
>> -       u32 num_syncobj, num_bo_handles, num_points;
>> +       u32 *syncobj_handles, *timeline_points, *timeline_handles, *bo_handles_read, *bo_handles_write;
>> +       u32 num_syncobj, num_read_bo_handles, num_write_bo_handles, num_points;
>>          struct drm_amdgpu_userq_fence_info *fence_info = NULL;
>>          struct drm_amdgpu_userq_wait *wait_info = data;
>> +       struct drm_gem_object **gobj_write;
>> +       struct drm_gem_object **gobj_read;
>>          struct dma_fence **fences = NULL;
>> -       struct drm_gem_object **gobj;
>> +       int r, i, rentry, wentry, cnt;
>>          struct drm_exec exec;
>> -       int r, i, entry, cnt;
>>          u64 num_fences = 0;
>>
>> -       num_bo_handles = wait_info->num_bo_handles;
>> -       bo_handles = memdup_user(u64_to_user_ptr(wait_info->bo_handles_array),
>> -                                sizeof(u32) * num_bo_handles);
>> -       if (IS_ERR(bo_handles))
>> -               return PTR_ERR(bo_handles);
>> +       num_read_bo_handles = wait_info->num_read_bo_handles;
>> +       bo_handles_read = memdup_user(u64_to_user_ptr(wait_info->bo_handles_read_array),
>> +                                     sizeof(u32) * num_read_bo_handles);
>> +       if (IS_ERR(bo_handles_read))
>> +               return PTR_ERR(bo_handles_read);
>> +
>> +       num_write_bo_handles = wait_info->num_write_bo_handles;
>> +       bo_handles_write = memdup_user(u64_to_user_ptr(wait_info->bo_handles_write_array),
>> +                                      sizeof(u32) * num_write_bo_handles);
>> +       if (IS_ERR(bo_handles_write))
>> +               goto free_bo_handles_read;
>>
>>          num_syncobj = wait_info->num_syncobj_handles;
>>          syncobj_handles = memdup_user(u64_to_user_ptr(wait_info->syncobj_handles_array),
>>                                        sizeof(u32) * num_syncobj);
>>          if (IS_ERR(syncobj_handles)) {
>>                  r = PTR_ERR(syncobj_handles);
>> -               goto free_bo_handles;
>> +               goto free_bo_handles_write;
>>          }
>>
>>          num_points = wait_info->num_points;
>> @@ -545,29 +594,51 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                  goto free_timeline_handles;
>>          }
>>
>> -       gobj = kmalloc_array(num_bo_handles, sizeof(*gobj), GFP_KERNEL);
>> -       if (!gobj) {
>> +       gobj_read = kmalloc_array(num_read_bo_handles, sizeof(*gobj_read), GFP_KERNEL);
>> +       if (!gobj_read) {
>>                  r = -ENOMEM;
>>                  goto free_timeline_points;
>>          }
>>
>> -       for (entry = 0; entry < num_bo_handles; entry++) {
>> -               gobj[entry] = drm_gem_object_lookup(filp, bo_handles[entry]);
>> -               if (!gobj[entry]) {
>> +       for (rentry = 0; rentry < num_read_bo_handles; rentry++) {
>> +               gobj_read[rentry] = drm_gem_object_lookup(filp, bo_handles_read[rentry]);
>> +               if (!gobj_read[rentry]) {
>> +                       r = -ENOENT;
>> +                       goto put_gobj_read;
>> +               }
>> +       }
>> +
>> +       gobj_write = kmalloc_array(num_write_bo_handles, sizeof(*gobj_write), GFP_KERNEL);
>> +       if (!gobj_write) {
>> +               r = -ENOMEM;
>> +               goto put_gobj_read;
>> +       }
>> +
>> +       for (wentry = 0; wentry < num_write_bo_handles; wentry++) {
>> +               gobj_write[wentry] = drm_gem_object_lookup(filp, bo_handles_write[wentry]);
>> +               if (!gobj_write[wentry]) {
>>                          r = -ENOENT;
>> -                       goto put_gobj;
>> +                       goto put_gobj_write;
>>                  }
>>          }
>>
>> -       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, num_bo_handles);
>> +       drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
>> +                     (num_read_bo_handles + num_write_bo_handles));
>>
>>          /* Lock all BOs with retry handling */
>>          drm_exec_until_all_locked(&exec) {
>> -               r = drm_exec_prepare_array(&exec, gobj, num_bo_handles, 0);
>> +               r = drm_exec_prepare_array(&exec, gobj_read, num_read_bo_handles, 0);
>> +               drm_exec_retry_on_contention(&exec);
>> +               if (r) {
>> +                       drm_exec_fini(&exec);
>> +                       goto put_gobj_write;
>> +               }
>> +
>> +               r = drm_exec_prepare_array(&exec, gobj_write, num_write_bo_handles, 0);
>>                  drm_exec_retry_on_contention(&exec);
>>                  if (r) {
>>                          drm_exec_fini(&exec);
>> -                       goto put_gobj;
>> +                       goto put_gobj_write;
>>                  }
>>          }
>>
>> @@ -608,13 +679,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                  }
>>
>>                  /* Count GEM objects fence */
>> -               for (i = 0; i < num_bo_handles; i++) {
>> +               for (i = 0; i < num_read_bo_handles; i++) {
>>                          struct dma_resv_iter resv_cursor;
>>                          struct dma_fence *fence;
>>
>> -                       dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>> -                                               dma_resv_usage_rw(wait_info->bo_wait_flags &
>> -                                               AMDGPU_USERQ_BO_WRITE), fence)
>> +                       dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>> +                                               DMA_RESV_USAGE_READ, fence)
>> +                               num_fences++;
>> +               }
>> +
>> +               for (i = 0; i < num_write_bo_handles; i++) {
>> +                       struct dma_resv_iter resv_cursor;
>> +                       struct dma_fence *fence;
>> +
>> +                       dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>> +                                               DMA_RESV_USAGE_WRITE, fence)
>>                                  num_fences++;
>>                  }
>>
>> @@ -640,14 +719,30 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>                          goto free_fence_info;
>>                  }
>>
>> -               /* Retrieve GEM objects fence */
>> -               for (i = 0; i < num_bo_handles; i++) {
>> +               /* Retrieve GEM read objects fence */
>> +               for (i = 0; i < num_read_bo_handles; i++) {
>>                          struct dma_resv_iter resv_cursor;
>>                          struct dma_fence *fence;
>>
>> -                       dma_resv_for_each_fence(&resv_cursor, gobj[i]->resv,
>> -                                               dma_resv_usage_rw(wait_info->bo_wait_flags &
>> -                                               AMDGPU_USERQ_BO_WRITE), fence) {
>> +                       dma_resv_for_each_fence(&resv_cursor, gobj_read[i]->resv,
>> +                                               DMA_RESV_USAGE_READ, fence) {
>> +                               if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>> +                                       r = -EINVAL;
>> +                                       goto free_fences;
>> +                               }
>> +
>> +                               fences[num_fences++] = fence;
>> +                               dma_fence_get(fence);
>> +                       }
>> +               }
>> +
>> +               /* Retrieve GEM write objects fence */
>> +               for (i = 0; i < num_write_bo_handles; i++) {
>> +                       struct dma_resv_iter resv_cursor;
>> +                       struct dma_fence *fence;
>> +
>> +                       dma_resv_for_each_fence(&resv_cursor, gobj_write[i]->resv,
>> +                                               DMA_RESV_USAGE_WRITE, fence) {
>>                                  if (WARN_ON_ONCE(num_fences >= wait_info->num_fences)) {
>>                                          r = -EINVAL;
>>                                          goto free_fences;
>> @@ -763,14 +858,19 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>          }
>>
>>          drm_exec_fini(&exec);
>> -       for (i = 0; i < num_bo_handles; i++)
>> -               drm_gem_object_put(gobj[i]);
>> -       kfree(gobj);
>> +       for (i = 0; i < num_read_bo_handles; i++)
>> +               drm_gem_object_put(gobj_read[i]);
>> +       kfree(gobj_read);
>> +
>> +       for (i = 0; i < num_write_bo_handles; i++)
>> +               drm_gem_object_put(gobj_write[i]);
>> +       kfree(gobj_write);
>>
>>          kfree(timeline_points);
>>          kfree(timeline_handles);
>>          kfree(syncobj_handles);
>> -       kfree(bo_handles);
>> +       kfree(bo_handles_write);
>> +       kfree(bo_handles_read);
>>
>>          return 0;
>>
>> @@ -782,18 +882,24 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>>          kfree(fence_info);
>>   exec_fini:
>>          drm_exec_fini(&exec);
>> -put_gobj:
>> -       while (entry-- > 0)
>> -               drm_gem_object_put(gobj[entry]);
>> -       kfree(gobj);
>> +put_gobj_write:
>> +       while (wentry-- > 0)
>> +               drm_gem_object_put(gobj_write[wentry]);
>> +       kfree(gobj_write);
>> +put_gobj_read:
>> +       while (rentry-- > 0)
>> +               drm_gem_object_put(gobj_read[rentry]);
>> +       kfree(gobj_read);
>>   free_timeline_points:
>>          kfree(timeline_points);
>>   free_timeline_handles:
>>          kfree(timeline_handles);
>>   free_syncobj_handles:
>>          kfree(syncobj_handles);
>> -free_bo_handles:
>> -       kfree(bo_handles);
>> +free_bo_handles_write:
>> +       kfree(bo_handles_write);
>> +free_bo_handles_read:
>> +       kfree(bo_handles_read);
>>
>>          return r;
>>   }
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index eeb345ddbf57..8d21e765094b 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -443,9 +443,6 @@ struct drm_amdgpu_userq_mqd_compute_gfx_v11 {
>>          __u64   eop_va;
>>   };
>>
>> -/* dma_resv usage flag */
>> -#define AMDGPU_USERQ_BO_WRITE  1
>> -
>>   /* userq signal/wait ioctl */
>>   struct drm_amdgpu_userq_signal {
>>          /**
>> @@ -475,20 +472,32 @@ struct drm_amdgpu_userq_signal {
>>           */
>>          __u64   syncobj_point;
>>          /**
>> -        * @bo_handles_array: An array of GEM BO handles used by the userq fence creation
>> -        * IOCTL to install the created dma_fence object which can be utilized by
>> +        * @bo_handles_read_array: An array of GEM read BO handles used by the userq fence
>> +        * creation IOCTL to install the created dma_fence object which can be utilized by
>> +        * userspace to synchronize the BO usage between user processes.
> This should just say: The list of BO handles that the submitted user
> queue job is using for read only. This will update BO fences in the
> kernel.
>
> Internal kernel details shouldn't be here. This file should only
> document the observed behavior, not the implementation. This applies
> to all comments in this file.
>
> Similar for the BO handles write array.
sure, will modify it in the next version.

Thanks,
Arun.
>
> Marek
>
>> +        */
>> +       __u64   bo_handles_read_array;
>> +       /**
>> +        * @bo_handles_write_array: An array of GEM write BO handles used by the userq fence
>> +        * creation IOCTL to install the created dma_fence object which can be utilized by
>>           * userspace to synchronize the BO usage between user processes.
>>           */
>> -       __u64   bo_handles_array;
>> +       __u64   bo_handles_write_array;
>> +       /**
>> +        * @num_read_bo_handles: A count that represents the number of GEM read BO handles in
>> +        * @bo_handles_read_array.
>> +        */
>> +       __u32   num_read_bo_handles;
>>          /**
>> -        * @num_bo_handles: A count that represents the number of GEM BO handles in
>> -        * @bo_handles_array.
>> +        * @num_write_bo_handles: A count that represents the number of GEM write BO handles in
>> +        * @bo_handles_write_array.
>>           */
>> -       __u32   num_bo_handles;
>> +       __u32   num_write_bo_handles;
>>          /**
>>           * @bo_flags: flags to indicate BOs synchronize for READ or WRITE
>>           */
>>          __u32   bo_flags;
>> +       __u32   pad;
>>   };
>>
>>   struct drm_amdgpu_userq_fence_info {
>> @@ -542,20 +551,31 @@ struct drm_amdgpu_userq_wait {
>>           */
>>          __u64   syncobj_timeline_points;
>>          /**
>> -        * @bo_handles_array: An array of GEM BO handles defined to fetch the fence
>> +        * @bo_handles_read_array: An array of GEM read BO handles defined to fetch the fence
>>           * wait information of every BO handles in the array.
>>           */
>> -       __u64   bo_handles_array;
>> +       __u64   bo_handles_read_array;
>> +       /**
>> +        * @bo_handles_write_array: An array of GEM write BO handles defined to fetch the fence
>> +        * wait information of every BO handles in the array.
>> +        */
>> +       __u64   bo_handles_write_array;
>>          /**
>>           * @num_syncobj_handles: A count that represents the number of syncobj handles in
>>           * @syncobj_handles_array.
>>           */
>>          __u32   num_syncobj_handles;
>>          /**
>> -        * @num_bo_handles: A count that represents the number of GEM BO handles in
>> -        * @bo_handles_array.
>> +        * @num_read_bo_handles: A count that represents the number of GEM BO handles in
>> +        * @bo_handles_read_array.
>> +        */
>> +       __u32   num_read_bo_handles;
>> +       /**
>> +        * @num_write_bo_handles: A count that represents the number of GEM BO handles in
>> +        * @bo_handles_write_array.
>>           */
>> -       __u32   num_bo_handles;
>> +       __u32   num_write_bo_handles;
>> +       __u32   pad;
>>          /**
>>           * @userq_fence_info: An array of fence information (va and value) pair of each
>>           * objects stored in @syncobj_handles_array and @bo_handles_array.
>> --
>> 2.34.1
>>

