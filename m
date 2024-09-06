Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3378CE7B1C
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 14:21:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F3B610E15A;
	Fri,  6 Sep 2024 14:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0edtSj1H";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A39610E15A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Sep 2024 14:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxMOlzOOLi5v5/KxmNqW39LWylz5ujsIFo4VIm3z1NCUZGw6+e4yesyhXmFoaaIzqTjnffv8LCySmqIF5D2RRqvPps7OFIh+198qqpHxTUaaZQ5qEoqhilkwM61RHdm55ZCoDA5T6O3lYXVFsdidYlbmROolplUwkTruVpk35EMO6IxyHiF40akCuz0xjiVUGD0dL1F9RNaZ0KYbLoyYE6hzjSeqezD2+C+HhyvwGEhROI+W7NBmYYU2cqCiVsDBGmbNsmZ8cW+Bjj604bkBTDfNVMr3ponW4C/gl3VMZR6ngMubnWrjs6kAF+HmOObtQp4+RGrIys4LclwwHURwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgM8J6PIlOlGTBse0wzpxOkc9lnQA/C7awGwMOfhlDg=;
 b=C51hHyFztcInK+JUuuCZlBVEwQTF/70bLc5HET75S7NRQACM+sIEPK1zKFXVnjAP1lmUQeAWmhP7YpjblmP2fkm29U8DlMktPPJMVpNaTr/bmms6jwP4FF0w0H61fc7qFWcyNqnOAletcU3dX65TBIbPfjImQ+l68L2F7mCdfsPIlC61+kmmcqZ4uUW6m2p5pRWVRX1aWRCJiTFIcKOYNFGKfdO9XIgwVmbiSDuu6pzo9nDU5vJsnDfLbbl4YpYPF6k961jYKqu4rWkO7rLs+QyOB1eAs+WQnV8PUaKhUDj3IptRUxEXwq8cdArumECPT6tRpSr/MHbKLpLrPyu+QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgM8J6PIlOlGTBse0wzpxOkc9lnQA/C7awGwMOfhlDg=;
 b=0edtSj1HFmmjEnoeutNWzw3NSqsN7tachhYcljY8yr5gPxf+Ft9s775Ovbh+Z5ovoDgsfPEtoK/mJaNXGtmawiCNPPZqq6oC9vm9a9IISGJYW+KAFFzmFdhpX4XQiCm/RrtO/Ha3e9B5lF4hqapzYjnMOaSdu1XdzSrPcdJpGeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 14:21:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 14:21:50 +0000
Content-Type: multipart/alternative;
 boundary="------------F6tvXrt3tc0KdGQzs0jk3tBF"
Message-ID: <4d02ece7-93bc-40fc-8c53-5ac0d2734a36@amd.com>
Date: Fri, 6 Sep 2024 16:21:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Raise dma resv usage for created TLB fence
To: "Andjelkovic, Dejan" <Dejan.Andjelkovic@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Prica, Nikola" <Nikola.Prica@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deng, Emily"
 <Emily.Deng@amd.com>
References: <20240905085841.18189-1-Dejan.Andjelkovic@amd.com>
 <c93d6652-08fd-40fb-a629-d52bec489ede@amd.com>
 <CO6PR12MB54412BC4A08D1335062D28C4E79D2@CO6PR12MB5441.namprd12.prod.outlook.com>
 <b693de66-ecbb-4270-b52b-341a9c69cbe5@amd.com>
 <CO6PR12MB5441B3A86656FFD6D7EE9300E79E2@CO6PR12MB5441.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CO6PR12MB5441B3A86656FFD6D7EE9300E79E2@CO6PR12MB5441.namprd12.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: fb357af4-6941-430d-4287-08dcce7f3f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXVrUlNPOTU5Q2M5NlpnSElYYVpHZWVjdCtETG05SWF3cnZZajl2aDh5RWY1?=
 =?utf-8?B?akFuZ1FJVzJIMFdyN1M1UzZONjJ0RnFYMjFmaTc3Mi8yaU1EdTRzWEowQnNy?=
 =?utf-8?B?M0FVdjBPT0RkTWw0MTFSUUxzK2l3enhoQUtabTdXVnUzUldrVUo2bFRZTTFs?=
 =?utf-8?B?eURLQTVxayt6NFpwOGRPekN1SnJMdEZzWlZ6SDZCbEg5R1FLbFc1QTc3aW9W?=
 =?utf-8?B?S21BdkpjS0RTcnVuTWQ1WW5GQUZIc3dod0lPdzE4ZUx2YUY5bHBDYTh4VEhZ?=
 =?utf-8?B?SWlTZW1Scm10RTR6T2ZBM1FGK1RtTjI3MmpKMTFsaE16Z1RLLzd2VTlnT0R4?=
 =?utf-8?B?bUdKZldROURLejBGb2VGOERBWTdlRmhuK2JEb1VzZ0Z0MEZFWHp5bTkvZzRK?=
 =?utf-8?B?b2JtbHUzckRKTEkya1NNdEpSM3F0VStDb2d4Nm1PUEl4cEJ6NHQ5dXR2Nnhn?=
 =?utf-8?B?Vm8yb3BkMHNVbHNjYjBpeTBWTXRZMUsyd0RidUhDTHk1dVc5UVNMaU5HVEkx?=
 =?utf-8?B?MVBqZnBEUFpJM0pBMDc0elF5d1pDV3lQOFVsWTdMTnN0cVV4RnhSMGg5cjU2?=
 =?utf-8?B?ZjNxakU2NUVsTmdhUXRpK0c4OWxLcGpQK3gvQTJ5UGtUcjViSjlEUkY3WEhC?=
 =?utf-8?B?c3NUcDNFM2FRWitzTjFIcVpETEJoMGdUTVAxWTRLT1creXFCZG8yeVhLUzJl?=
 =?utf-8?B?QXduRGFrUmdMZlluSlplYVpVaTNJT3BNaUkwd1FyVjFiMnB1Q3p2cnQyVnkx?=
 =?utf-8?B?S3RzK1dxb2p0RHBma2xZZlUzcmNTNUxKZWgwanlqbzJjN3BOT0FWVmF4bjlu?=
 =?utf-8?B?bXYxbkc4bkh4UmRKbFg0KzNsd0x1QXZOQ2gycFdDNGxYTXd1WlN1amFzUm9R?=
 =?utf-8?B?ZldhYjZLQnJseitaWkJEZUFPSHg1M20wcmlBNlliTU5Pd2Z6Y0lBNmRUb0pt?=
 =?utf-8?B?NVRIUTVtQ0RlQ1lYeC9pT1pjT1BleFpKK25nai9lYm80blI1cFNEY3R3Vits?=
 =?utf-8?B?UDBIc24vRWRiMkxXYlVXRkxIaDZuMkRndmwzUU1NSTFuMUo3aHE4K2g5dHBR?=
 =?utf-8?B?c3hWd0Y4UXJkZW1YZkxKVFVwS1RMY2JOZzBXdEJpZlJuVDF4TUV3TUV1Vm5F?=
 =?utf-8?B?VEY0ZlJqQTFIM1l6ZWZ0Y2xhOUQzanpjTlJ0MXJOOUhJY1BMelVNbGZ0aHZE?=
 =?utf-8?B?blRCRGxEV0dUZHVTY0FkYXJoS1k1RWtZRktRV251ZTc3cS9oSkFpeUtVMFdO?=
 =?utf-8?B?QUNvc1NuMzl4d1o0YXFzS0x3RmZNcXBSemwyTEQ5dVFJL3BPV2lra3Bjb0Rs?=
 =?utf-8?B?UHVha1hZT3BUQ0d3anFDTEFzWm91VU9KVzZ1UGlKY2NPYURPR2JRbE4rZGI2?=
 =?utf-8?B?TWFWM1l3Yko4L1FnZzBYM0tSK1gxSHVBSmpBd0F2NXFXdFdBemNuS1FnaC8r?=
 =?utf-8?B?Y2hvbjBCNDZXYzlydU4ya2ptZXExaXFFdkJFcENGYnNIYkN4TDJJY05URVhv?=
 =?utf-8?B?UURwRVltRXZXc3MxZ1lIb1RkK09rTkUwWUFObkVtckJqL25aYWFkdFhNRGF6?=
 =?utf-8?B?amJSbTMzZTVHSC9TSmhoblhQQjhiS2xoNlFoVXZHb1cvcHh4N2lFMVFWYmx6?=
 =?utf-8?B?NmsrcmlUbkZtZ1doUFoxR20rQkJsQm53aFJBZzBuSUN2WjBOWWlzWmhVck9r?=
 =?utf-8?B?b0diYmQ4YjJCOUJ4TWJTRTZraFBXcDlwNXFOTWFYS0poVDJmYzkxY0IyYS9a?=
 =?utf-8?B?MTk0VDlabVo5WDZVRzNCdGo5WE1mQlFVODdCRXQ0WERKWjBKSjRkNStxcUp6?=
 =?utf-8?B?VmxXY2hoYmFEb0hTVkxqQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXhOT00vNVQ3NXZLODhzQ1hLNUI3N2dIQmpMeDc3YUtab1FrdkxIaGxocDZF?=
 =?utf-8?B?YXNnOElaZFBSWDJwc2RLZUZtMVNhQm4zMGtoT0ROV0gvVlk2L2c0cERudGxM?=
 =?utf-8?B?Y0tTbUorb0JTMzJEMWR3dzhUWVJPTkplZXhOQUQ5NkduOHNrOEw3WEhMU0Ux?=
 =?utf-8?B?RWpVNTQ4ZCtFZ2xaMDhHa0VCTDdKeVpxYm81Uy9yUDBHRzQ0c2tKdEcrMnh6?=
 =?utf-8?B?OUJUOEFtU05jdWczenh6MUdaalBVR2RONmo1cUZBOEdoai9wa0NpUkV3RzM4?=
 =?utf-8?B?NjFXOWp1d2JDV3M5ZFZTc1dBSzViRFpNN041QkRESm5OMGlpcC83YStaWnZJ?=
 =?utf-8?B?eHRVbmRuWW9qc2pTamN6aFBBbU5xeVlELzVQYjE5ZDNDMFdrZnZIOTU2Q3Nr?=
 =?utf-8?B?SVFtMEtMNUh1NXN0dlBpQTZoTFFvdkhzMjgxUE1hMzlRMWpuMjdhL2FsVTc4?=
 =?utf-8?B?K2hxNFlNd05kRmo4ZmlpdFIrQzFodHlySWJlbEY0MmUxQ2w1MnVtN3FHdE5S?=
 =?utf-8?B?T2hDZEVWTXhubXVVOEZXZmgxcDhFUXNXYTdjM2VvTnhVdjVXcDQwUFBNd3BC?=
 =?utf-8?B?bVU4bmxlcW1iUE5HQWxVc1pxRHpFOFNaQVozN2hMejQ4S09jM2plbFMvTHpp?=
 =?utf-8?B?cmRpZVNMcGd4eU5nU1JJZ1ZTN04vTzJhb1pOTDliVjBROTRmbUVvOExoQk5o?=
 =?utf-8?B?ZGtwY0ZXVGplZmdTL2RhSUJUcVBTMEdHOVp6WC9URVVSdkdQcVpvKy9FYWI0?=
 =?utf-8?B?TWVwd3BPRldsNHo5NGlYUlpLWXlCQ01WVkh1b0tZYnlRMG8rQjdQZTI4MkhO?=
 =?utf-8?B?NUE1dHVLM0dMT3FvU2tSTDJpVjBKZmpyZFg0NUdCa0t3VDNBbmZYUG9VdTdh?=
 =?utf-8?B?UFllMmpscktJYWpPRG9vWXlNL2FjZTVIZ3JwV1FQWk5uK29wRklNclY0dDUx?=
 =?utf-8?B?NkhSaFZjR2tzNXBhVDQxa1pScFFWcVZGbi96dEswT1g0RENzTFBxUWE1a0Zm?=
 =?utf-8?B?RE5tVGlwamFLdXRlNGhnTllWa1R1ZXFob0hRNGNLdFZZNTJ0SG5USVpFWW5u?=
 =?utf-8?B?NGxsUXE5OFRxMTc2SE03Ukp6Y1FKVk5ESS9sOTZvTlN4TFUzL2hnQzh2YXZK?=
 =?utf-8?B?VDEwRjFzeFE2VG84ZHg0Vi90SnR1RjdmQ0ZXUHJoeExOdkswOHZtWmw2NHVq?=
 =?utf-8?B?aThmYjdBa2RBZ0JvbmJQL1JHYjBZVDBWdVRBMWRxOU9zQ3NLd2xkSHpjR3Rp?=
 =?utf-8?B?NEpzdFVlckhlT2JHd2ZjMDZyK1JXOXg4bldmSTJKUXcrNEpLbXdqcDNJL05x?=
 =?utf-8?B?UzJ5R3g0cjgzWlBMbEFtMHNKVlBlMVBPUXB6MkdvbmdhNG9XZHVUTlk1Ylcz?=
 =?utf-8?B?bU9QVWtGY1JHaE9IYUx5a0w2SnR1WjJJNkpwK1ovL1dVaThVR0d0a1pIcnJy?=
 =?utf-8?B?MnhNN1lqSXRFbGVSbWRDT2hmMEJ6NFJFVVRqZzAvRmhLWFRWbnozcFhPT0Vm?=
 =?utf-8?B?c3VoMjhrVXhJTnVPV0lNV1pydHliWFpKaUVJQlJ4S0JlOGtuQUdPaWxhbkF5?=
 =?utf-8?B?NGd4ditkbVRJQU5jS0FHTUFJLys2SkRyUldYYUZMNnJnV293Q2thTjlqYldI?=
 =?utf-8?B?WnZvdDUyc2dDSWR4SmQvL2ppM0ZPa3hDaFQyblIvS2tmbm95UlVlUFZkckh0?=
 =?utf-8?B?OGVkY2tHeVVUZ1VsWkxVbEJjdldqZmxjdUdaditEbWJ0WDFjOER5MUx4YnF2?=
 =?utf-8?B?dnIzODFMZkZ6RkE3ZzI0b1JEbTFlY1pZWTUrTDNIWjFlTStTYmg0VUU4SnFk?=
 =?utf-8?B?VFJqbkNJTGhqenVva2Y0bGh1MDVaNytGM2lybzBJUnAyV2lublAxU1pRZW9l?=
 =?utf-8?B?L3ZVZGFNSWs2RXg3QUFCYkRlMkhOTE5uZHVSWWRZbmFWK2lvc2d1Sy9HKzhk?=
 =?utf-8?B?Sm1nZWxGTC9ZVDlsZ2R4KzV0RWY0UW9SYXdXTDN4NHBPRUEzZWdSSXZOUjBO?=
 =?utf-8?B?TDFCVXh6S01DaGNCR1orL1ZYNnE2MUhMN3dkTy9nUThoSVRHZG5QUGYxVHdx?=
 =?utf-8?B?WkFseXlDbTc4WFNrN1hIaHZIVGJ6MVdUaU0vdytIRmFuZ3lhSncxMzJtdVBx?=
 =?utf-8?Q?wxYw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb357af4-6941-430d-4287-08dcce7f3f95
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 14:21:50.4263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/fl0/SjtE4NaYHw1zFTw4R/8tgb40Cp4BJzJBnROe7ISVUpt0gvSLisg8sEHWHx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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

--------------F6tvXrt3tc0KdGQzs0jk3tBF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well that's the whole reason I'm asking :)

Why do you think it should be added as dependency in 
amdgpu_vm_sdma_update? As far as I can see that is complete nonsense.

Page table updates never depend on TLB flushes, it's the TLB flush which 
depends on the page table update.

Regards,
Christian.

Am 06.09.24 um 16:10 schrieb Andjelkovic, Dejan:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> I might have worded that poorly, I meant that it seems like TLB flush 
> is out of sync with the SDMA update, which leads to a page fault 
> reliably. I don't feel it has anything to do with the implicit sync in 
> itself. When TLB fence is created it's added to the dma_resv of the 
> vm's root buffer object with BOOKKEEP usage specified, in order to 
> make sure no PD/PT is freed before the flush. But I don't think it's 
> being added as a job dependency within the amdgpu_vm_sdma_update, 
> we're adding all the fences found within the dma_resv object with 
> KERNEL usage specified. I may be missing something so I'd love to hear 
> what you think.
>
> Best regards,
> Dejan
> ------------------------------------------------------------------------
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, September 5, 2024 2:40 PM
> *To:* Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Prica, Nikola <Nikola.Prica@amd.com>; Kuehling, Felix 
> <Felix.Kuehling@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: Raise dma resv usage for created 
> TLB fence
> Well that explanation doesn't seem to make much sense either.
>
> What do you mean with TLB flush is occurring prematurely?
>
> Regards,
> Christian.
>
> Am 05.09.24 um 14:38 schrieb Andjelkovic, Dejan:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> Hi there. We're running into a page fault issue that's very easily 
>> reproducible on a SRIOV environment when using SDMA for page table 
>> updates. Going through mapping logs and trace files, it seems TLB 
>> flush is occurring prematurely. Changing the usage to KERNEL 
>> completely stops the page fault from occurring with no performance 
>> impact, which was confirmed with extensive testing. Looking through 
>> amdgpu_vm_sdma.c, namely within amdgpu_vm_sdma_update when waiting 
>> for PD/PT moves to be completed, fences are iterated with KERNEL 
>> usage specified which are then added as a job dependency.
>>
>> Best regards,
>> Dejan
>> ------------------------------------------------------------------------
>> *From:* Koenig, Christian <Christian.Koenig@amd.com> 
>> <mailto:Christian.Koenig@amd.com>
>> *Sent:* Thursday, September 5, 2024 1:17 PM
>> *To:* Andjelkovic, Dejan <Dejan.Andjelkovic@amd.com> 
>> <mailto:Dejan.Andjelkovic@amd.com>; amd-gfx@lists.freedesktop.org 
>> <mailto:amd-gfx@lists.freedesktop.org> 
>> <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>> *Cc:* Prica, Nikola <Nikola.Prica@amd.com> 
>> <mailto:Nikola.Prica@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com> <mailto:Felix.Kuehling@amd.com>; Deng, Emily 
>> <Emily.Deng@amd.com> <mailto:Emily.Deng@amd.com>
>> *Subject:* Re: [PATCH] drm/amdgpu: Raise dma resv usage for created 
>> TLB fence
>> Am 05.09.24 um 10:58 schrieb Dejan Andjelkovic:
>> > When using SDMA for PT updates, a TLB fence hooked to a buffer
>> > objects dma resv object with usage declared as BOOKKEEP leaves a
>> > chance for TLB flush to occur prematurely. This will lead to a page
>> > fault. Raising the usage from BOOKKEEP to KERNEL removes this
>> > possibility.
>>
>> Well that's complete nonsense. The usage model is for implicit syncing
>> and not even remotely related to TLB flushing.
>>
>> What exactly is the problem you run into?
>>
>> Regards,
>> Christian.
>>
>> >
>> > Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com> 
>> <mailto:Dejan.Andjelkovic@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> > index f93804902fd3..8efc2cf9bbb0 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> > @@ -928,7 +928,7 @@ amdgpu_vm_tlb_flush(struct 
>> amdgpu_vm_update_params *params,
>> >
>> >                /* Makes sure no PD/PT is freed before the flush */
>> > dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>> > - DMA_RESV_USAGE_BOOKKEEP);
>> > + DMA_RESV_USAGE_KERNEL);
>> >        }
>> >   }
>> >
>>
>

--------------F6tvXrt3tc0KdGQzs0jk3tBF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Well that's the whole reason I'm asking :)<br>
    <br>
    Why do you think it should be added as dependency in
    amdgpu_vm_sdma_update? As far as I can see that is complete
    nonsense.<br>
    <br>
    Page table updates never depend on TLB flushes, it's the TLB flush
    which depends on the page table update.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 06.09.24 um 16:10 schrieb
      Andjelkovic, Dejan:<br>
    </div>
    <blockquote type="cite" cite="mid:CO6PR12MB5441B3A86656FFD6D7EE9300E79E2@CO6PR12MB5441.namprd12.prod.outlook.com">
      
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p style="font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;" align="Left">
        [AMD Official Use Only - AMD Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          I might have worded that poorly, I meant that it seems like
          TLB flush is out of sync with the SDMA update, which leads to
          a page fault reliably. I don't feel it has anything to do with
          the implicit sync in itself. When TLB fence is created it's
          added to the dma_resv of the vm's root buffer object with
          BOOKKEEP usage specified, in order to make sure no PD/PT is
          freed before the flush. But I don't think it's being added as
          a job dependency within the amdgpu_vm_sdma_update, we're
          adding all the fences found within the dma_resv object with
          KERNEL usage specified. I may be missing something so I'd love
          to hear what you think.<br>
          <br>
          Best regards,</div>
        <div class="elementToProof" style="font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
          Dejan</div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Koenig, Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Sent:</b> Thursday, September 5, 2024 2:40 PM<br>
            <b>To:</b> Andjelkovic, Dejan
            <a class="moz-txt-link-rfc2396E" href="mailto:Dejan.Andjelkovic@amd.com">&lt;Dejan.Andjelkovic@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Prica, Nikola <a class="moz-txt-link-rfc2396E" href="mailto:Nikola.Prica@amd.com">&lt;Nikola.Prica@amd.com&gt;</a>;
            Kuehling, Felix <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Deng, Emily
            <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv usage
            for created TLB fence</font>
          <div>&nbsp;</div>
        </div>
        <div>Well that explanation doesn't seem to make much sense
          either.<br>
          <br>
          What do you mean with TLB flush is occurring prematurely?<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <div class="x_moz-cite-prefix">Am 05.09.24 um 14:38 schrieb
            Andjelkovic, Dejan:<br>
          </div>
          <blockquote type="cite">
            <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
            <p style="font-family:Calibri; font-size:10pt; color:#0000FF; margin:5pt; font-style:normal; font-weight:normal; text-decoration:none" align="Left">
              [AMD Official Use Only - AMD Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Hi there. We're running into a page fault issue that's
                very easily reproducible on a SRIOV environment when
                using SDMA for page table updates. Going through mapping
                logs and trace files, it seems TLB flush is occurring
                prematurely. Changing the usage to KERNEL completely
                stops the page fault from occurring with no performance
                impact, which was confirmed with extensive testing.
                Looking through amdgpu_vm_sdma.c, namely within
                amdgpu_vm_sdma_update when waiting for PD/PT moves to be
                completed, fences are iterated with KERNEL usage
                specified which are then added as a job dependency.</div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Best regards,</div>
              <div class="x_elementToProof" style="font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Calibri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
                Dejan</div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b> Koenig, Christian
                  <a class="x_moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com" moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a><br>
                  <b>Sent:</b> Thursday, September 5, 2024 1:17 PM<br>
                  <b>To:</b> Andjelkovic, Dejan <a class="x_moz-txt-link-rfc2396E" href="mailto:Dejan.Andjelkovic@amd.com" moz-do-not-send="true">
                    &lt;Dejan.Andjelkovic@amd.com&gt;</a>; <a class="x_moz-txt-link-abbreviated moz-txt-link-freetext" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    amd-gfx@lists.freedesktop.org</a> <a class="x_moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">
                    &lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Cc:</b> Prica, Nikola <a class="x_moz-txt-link-rfc2396E" href="mailto:Nikola.Prica@amd.com" moz-do-not-send="true">
                    &lt;Nikola.Prica@amd.com&gt;</a>; Kuehling, Felix <a class="x_moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">
                    &lt;Felix.Kuehling@amd.com&gt;</a>; Deng, Emily <a class="x_moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com" moz-do-not-send="true">
                    &lt;Emily.Deng@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amdgpu: Raise dma resv
                  usage for created TLB fence</font>
                <div>&nbsp;</div>
              </div>
              <div class="x_BodyFragment"><font size="2"><span style="font-size:11pt">
                    <div class="x_PlainText">Am 05.09.24 um 10:58
                      schrieb Dejan Andjelkovic:<br>
                      &gt; When using SDMA for PT updates, a TLB fence
                      hooked to a buffer<br>
                      &gt; objects dma resv object with usage declared
                      as BOOKKEEP leaves a<br>
                      &gt; chance for TLB flush to occur prematurely.
                      This will lead to a page<br>
                      &gt; fault. Raising the usage from BOOKKEEP to
                      KERNEL removes this<br>
                      &gt; possibility.<br>
                      <br>
                      Well that's complete nonsense. The usage model is
                      for implicit syncing <br>
                      and not even remotely related to TLB flushing.<br>
                      <br>
                      What exactly is the problem you run into?<br>
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      &gt;<br>
                      &gt; Signed-off-by: Dejan Andjelkovic <a class="x_moz-txt-link-rfc2396E" href="mailto:Dejan.Andjelkovic@amd.com" moz-do-not-send="true">
                        &lt;Dejan.Andjelkovic@amd.com&gt;</a><br>
                      &gt; ---<br>
                      &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2
                      +-<br>
                      &gt;&nbsp;&nbsp; 1 file changed, 1 insertion(+), 1
                      deletion(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                      b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; index f93804902fd3..8efc2cf9bbb0 100644<br>
                      &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                      &gt; @@ -928,7 +928,7 @@
                      amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params
                      *params,<br>
                      &gt;&nbsp;&nbsp; <br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Makes sure no PD/PT is
                      freed before the flush */<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv,
                      *fence,<br>
                      &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      DMA_RESV_USAGE_BOOKKEEP);<br>
                      &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      DMA_RESV_USAGE_KERNEL);<br>
                      &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; }<br>
                      &gt;&nbsp;&nbsp; <br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </blockquote>
          <br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------F6tvXrt3tc0KdGQzs0jk3tBF--
