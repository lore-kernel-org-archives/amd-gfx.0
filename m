Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2166ACAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 21:41:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA62910E7F7;
	Wed, 24 Sep 2025 21:41:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIOgFs9b";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ED3F10E7F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 21:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyrFiuUBN9gJP6e4aky4L4vq5/yqH2atBEVPNRaUlvgKLteuApKhLyD06Fx/UTqQ+QXldgLkMhjmtSe3/asjfH6tMBCrquf6mq7AtItGW5NLEheSrQ/OZS+Fmk4ns8WC2XqgOqQKW8FH7NZZQvD9m2HEM0kVFejjFHk0CfTP2Dd/I62JMa6Wg9c2nmr4DK817mEXR30Pbi8Yv6Z4b+XelXrQlajasja4S+eGS36IIVTzZ6f/pYCQuPt49ZKMWSIv+F4voXoPKDf4TR1P6zRisX8h7IjoZJiE29bgKwJr3bvHstXhWRaWLSuQBLE+NcROled1ULQYIR1r8y31ZPanxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MVkhiuHLj7N9vh7s2aqUTCFG1HMkEtRx3nS+v1sOpM=;
 b=oDDygF4ephQZwB3u/oWO/lSzd7mu1KiiEt+/1kU7ZcoWjxwu70EvBeBXw52OpRmlYD53kPEn/zOZhf8lPJn0Z2/f+MqQPBEnEyqPk3dA14bhURjQbvzXOakO2QkGRrGqpwbeKAy+TpCEns8rSEXU842NWwwRYC3hinh4Qhp/LWmRPiVK/cWZdv9Z+wt4XtEShSxcwUrt3H4GkqwIDhAPJUqUwMnRxmVqmqV1LB1BOX80PXTa9vOjKFAq+n4BUnNFynZqczqGn1zOgl8fQ/0EeDoGFeGd+Em5fFZ2YSXSfOG/Jxw1PcjRTLp2R7eCECKidrjzVq/sFjO+UaZMzVKYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MVkhiuHLj7N9vh7s2aqUTCFG1HMkEtRx3nS+v1sOpM=;
 b=lIOgFs9bjQiYbo6Buqyp4OQ/h121M8S/DuTJhGa32z41ztpcZm+ncK06DECQDL6om5DhJQdzpTz9K+AeVXmwvJhSl/+a+gP88WEbXrFs7CXTvbhX2smZhMQQwSmKIyIac3bky1Xpt9YDasl17G/TDEqiNewlKGo65yzQFXyU18E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN7PPF862C85B20.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Wed, 24 Sep
 2025 21:41:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 21:41:12 +0000
Message-ID: <00280d51-4548-4e60-9005-34683d4068d8@amd.com>
Date: Wed, 24 Sep 2025 17:41:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 08/18] amdkfd: identify a secondary kfd process by its
 id
To: Zhu Lingshan <lingshan.zhu@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250923072608.252345-1-lingshan.zhu@amd.com>
 <20250923072608.252345-9-lingshan.zhu@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20250923072608.252345-9-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0087.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BN7PPF862C85B20:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fac5a4d-d32d-4d69-d251-08ddfbb31448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1JCSWllcVJwVm5qa1VSU0NFMjc5dFcxK25PbVJ2Uy8yS0R1TVRyMzNZQWF2?=
 =?utf-8?B?cjRMNmd2ZWVndlhVeGppNHh1Y1ZmWlBIQkhQQzRvamc4cHhFTEQraXRLcXc2?=
 =?utf-8?B?R0xIMEp0S0hVbFRQZVZLT29hV0orM3J6cEVhV29mTng1Wnl3N0pSKytNMm02?=
 =?utf-8?B?bzExRzNISDZIMEFjQWJoNEwybGdnZ0c5K3FFM3MyMzRjMmVqdk9KNHBCNUxW?=
 =?utf-8?B?amlrbWdFaysrTzAxdzUrWnlBdW1LKzRXdU94UG56ZjdDc2JFSERqbUNwbSsy?=
 =?utf-8?B?WitBSFljWHpoUlFxdjFFeXErU0hJb2tiZG9RWlp1SE1rOXRNSlBOblFpM0dp?=
 =?utf-8?B?WDBucTA3SWJDVUl3TzBDZ3JkOExSNFdUaDhCTWYxcWtHRTFCRlIxYnl2OW9V?=
 =?utf-8?B?ZVhUZUJpV0N2b01LUlhlK1VSZlFwMjgxUTkxRjVObi9ML2dLWnd1QkdwOCtK?=
 =?utf-8?B?Z0duSWpYTExiajZ3eUNMeVVzL3RHVnRPZ3IxTWNCckFEdkdkVTk2SG1NT2g0?=
 =?utf-8?B?aVpJWmJnbGNrZm1LSjZzUi9Yc3NiUThLZ3NoRGd0c3dkNmJJYTBVLzdNTWlZ?=
 =?utf-8?B?Vnp3WEVZZW4vdWRscFp2WGEySlNJTlhiTFg0cEtDVHNRTWc4Y3lORERhcHVp?=
 =?utf-8?B?QW52ZEk3ekxLVFVDY25JeS9QTmRtbjRtZFlIaVV4WjFJTEp1Si9xYktKZE16?=
 =?utf-8?B?TkR3ZkpIbWMxYnQveTFybWlFUTFLUThGamVMalFBaUpwY1JGMG02ZUVFdkpS?=
 =?utf-8?B?Z0xud0FHK0t5Zk9DZEdPRGo2QlpRaStrYzcyb1duVFlyV1prUjFkbmplYjlZ?=
 =?utf-8?B?M0FkNm9jTm94ams0ald4b3dYWXlmRUlDUyswOEtiRVJhVXlGOXVYK2xOTXZQ?=
 =?utf-8?B?MjZ6VEdweVUxWk9HUnNGZkVhQmJMeUQxQ2NhNkpVb3VNeGFuUG5UdWxGeklZ?=
 =?utf-8?B?Vmc3TjJzS1NvblZRMC9ZS2xzdm5iMUJ4M29FRzBjS2pkR0Y0Y0MxVDF2VkJX?=
 =?utf-8?B?QUVia2NsYnlYTkdSS1ZxcVlXdXpVTTJhM2ZjN0h5V0dLZlhTYzVaU0d0Q21M?=
 =?utf-8?B?K0QvNzV3WjFmUlRaRVdyS0pEZ1FWc0RzQzlCOFZvLzRNTng1eGJLeXVTK0xR?=
 =?utf-8?B?NFcrMzdwWkk2ZmtneDRZalNXbUNzMFdzMnRRaHI1OE9RRkZSdWp3UkUrcTll?=
 =?utf-8?B?MTdyYUd6NUJLczVLUyt6UHMvVGV2V2l6Mlc3TGJFN2dQTThjZi9SL1dielI0?=
 =?utf-8?B?UU9wZ2hyekxOdjNWcGJPWnA2bWlHMng1OHJlWDFYY2pUNkorSEgxMkhDbmN6?=
 =?utf-8?B?SXl5ZDU3a0dwdXVDTndyczh6SnVyZk9CQUN5eE9xMVhzQ1lsL0FIdDkzcEtD?=
 =?utf-8?B?VE4ya0NOTytvNEY2cmpRekI4MS94YzJLMGNUQXlzVmYyMnhOQ01oM2tFQW5D?=
 =?utf-8?B?cW02RGlBK1F6Z29zb2lwTnVuSGo1clc1d0RWVkNkMXlsSW1oc3ZYZE1Pc2xs?=
 =?utf-8?B?VVhCejEzeU5IS1JDa3YvMi9LY1ZtNEExdStRbWgrOGdaWDkyZ3p4a25KaldZ?=
 =?utf-8?B?VkJrYUgvVjlENjBsbWhIOWl5dElCdWdWN2VMK3pWajJXUWpucitjSTVEVDIr?=
 =?utf-8?B?ZGVveVBFRUY3K0hjNzFMTGtjbTlJM0J0STQ4eVM5MVVUUURTREd2MXVCb1l0?=
 =?utf-8?B?MVljRytuMjU4SzM2c2pVcm9sbkRSbjcvMFVQQ1hUNVJsTitpUTlBYklnMnl2?=
 =?utf-8?B?MXdXUVZ0RGRHS0U1bHRLTDNTekhlcHpxMCsyUTlrbENRTVphNUtyc0YrT25x?=
 =?utf-8?B?dFdTNnJSbldheGtuaXJoRFhEd3ZQNG90c3ZHYUM1QmxSYmJMVTF0cmk2Vmts?=
 =?utf-8?B?ZFNnZHVVTTYvZmphd3ZqZm5YUXo3cFRXcnNiRXdxMmZVbWVNR2VQRkdoajNr?=
 =?utf-8?Q?mDkL9KwnFVw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?My9EcksydXNSWEZxVXFVN1JtTzJjWGtMYnpyT2QyamdOc051b2lkUE52REUy?=
 =?utf-8?B?ZG1PNnd5MllhR1l5Y2JIMzNPVGsxV1ZjTHJBSlVSWkFFYkZENkh6NnBGMGZJ?=
 =?utf-8?B?TUxuSFhoaktLMVlwMkwzUUxjMWJ0ZXI0QUNOeW9laVF5VFhLbVRDMTdvbGpN?=
 =?utf-8?B?TGI2WGJZT09OZk0zRzVQVkR3cWhEZ0UwVXQ5bEY5bWViamRkS2kxK2xEM0Rz?=
 =?utf-8?B?a0ozMm5BS2JjT1JHUTVRMDlHdHJVSzJ3aU1UV1hRZFQ2RngwNE9GSkNqVTBM?=
 =?utf-8?B?aXRmUjJtYklCQU8zNjJKRFh3WEJQRWRneXExZ3Z1MkJkcTg4NGt4ZWJNblg5?=
 =?utf-8?B?cStHWmo3b0Uzc0JoK0FXZ1FYVVBCbFF3L0hoZWFxVHkrL2JvMnM3RGxsaEhr?=
 =?utf-8?B?eEZpa1l4NWVZTzRNcWhrYS9aeFdYNG5FTWFOWFFrbVMwQzZ5K3NSUURjVkxz?=
 =?utf-8?B?cC9JblBtSmI0OVdoK1BWd3g2QjlqNmhZeHFFa3E0czFxeVl4Y0V5c1lER2sr?=
 =?utf-8?B?eTFlbzZvR0x2UEJ3WWVYWlhCUkZsd3V1TzExUzJxZ3ZQbkNBdG91Qmc0U2dJ?=
 =?utf-8?B?MHFPTE91SFJQbFB2QWVKWEZzTWtnVUJFa2dveGRHR1o2RFQ0N2cyMUFkaDNE?=
 =?utf-8?B?eU1TSXVtK3JNbXJlUDg0M2xNTFVxd00yMm0wcVNlNXo5L3VWL2hxN2hVMGt4?=
 =?utf-8?B?dUpvY2pwNVgvN2pXeEV0RHhEVldsdDE3UHB0MUdMUW9wVG1qZ2xheXpDVkpO?=
 =?utf-8?B?MGJpRVNHRVZKRDE2dnl1cE9TMDJ6VWRCazc0aTNzcXR3dFovZy9uM09vSVVY?=
 =?utf-8?B?U0dROGNucGN1SEZYSHl5clowZW02T1NVdGlQNDZPWSsvTnB3K096ZGh6YlNm?=
 =?utf-8?B?blJjMUV1OXFkaUNiSnlBWHhTazBRRitIbldONWdYYytYTzAxNGV5SXZkWHVm?=
 =?utf-8?B?NkRNcU82MTI3Qk14NlVCMEZQYWNtN3h4dGtNRUovWkR4eHFpbDdERGNXSlpo?=
 =?utf-8?B?L3R6czBTSmc0QlFudlNMbTltdVFVWW03K25Wc2h4bTR1L1I1N0RTTm1samtD?=
 =?utf-8?B?eFBQckFRVHNwdzI3Y1U5WjdaaE42SXNTV1AzUVQ4cE5zelFMb0NnU1VTanAr?=
 =?utf-8?B?bFhWL3dUbmpTZm5Ud0VvTCtUOG1iSlhIdENTeWI1Szk2bk42WDd0cjF6UkVD?=
 =?utf-8?B?bVdYclZhRW00ZFFnRkNkZXdUYVIxcm5yTk9UaFBjUmN2enN1K2tTK2FWZXlV?=
 =?utf-8?B?dFY3LzVyLzEyZWgxT0hBNncrYjg0NGFVck42Tk12NGp3NXZzUk5OcnFQYXJY?=
 =?utf-8?B?eWlMZ2F6UHh3QVBPYTR4MC9MbUpkWis4czEwd2Ftd3QzY29qMmR6YTB4Um1u?=
 =?utf-8?B?SDJCMGpjbGY1emhrMWU2emhmQjZqZzdJZWxxR2hWYTFDZzd3Q1hJZThyRjVH?=
 =?utf-8?B?dktBajNjZy9qSkZKbjRsbGJraFZFUTd4MUEwL3VYT2tCbVNwWDV1MzI2TjZ2?=
 =?utf-8?B?UEc1QzdBYTl4eFprSUhWZTFTKy9GMVdSR3pKZDNvaWtxZ3BRcUNDQkJOUlFW?=
 =?utf-8?B?U0I2eWh4L3ByMXppRVh6NGFHWThQamNWVkpsSXFvYTVGVEFoS2R2UjJxNzlX?=
 =?utf-8?B?OFI0Tm12dUhESmRVMVY5V0tlTzdXa0JvYURmdHlYMHZxd3JuRktTYTlFNXVj?=
 =?utf-8?B?Q1p2TCtFWTZFYWdDalBCRVlUVVJZSDZ1WXhscjVvZWkxY3FjZXJMVERKclFT?=
 =?utf-8?B?NHAzTTVXVWkrNnlqWFpSVi91cTlBS0tVVUVLUlg2ZEQ3Y1lRUHlzSFptL3Zm?=
 =?utf-8?B?RWN5OHZoLzFCNythaDFnbWMwSkdmWnBtSSsvM1E5YTY0N3JBbTcyWUtlU214?=
 =?utf-8?B?Tzh1cHJ3SU45Y3lGRlVlT0NKYm5ucCt1bW9FWm9na29IbTk0SjBLR1IwcUpQ?=
 =?utf-8?B?SGJKN2FnelhvYitIZnRNNzdUSERTOFBwT3c5b2FqLzRoUGxNVUltV0VIOWE3?=
 =?utf-8?B?Sm8zVzRQV0wweFc1M1dsMGtpdjBHRkZEVkp2WUkzM1hxNndNdTJDcFJQb1Rq?=
 =?utf-8?B?T2Y3Vi9IT3krbEpsRi9sZlBNazhDSEwrZlBlSXhRT1VXaVE4TGhSdmdZdkY5?=
 =?utf-8?Q?9gKAFvskaPFXq84tEBWsADhoR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fac5a4d-d32d-4d69-d251-08ddfbb31448
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 21:41:11.8946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbbsyGjvFJ9KX6GjO/L2mvD9xiSCtpbAIQXqNCK9asji4nsSt9il4OT4uOPTtnD2U9bm5J5k9qqgi0H0stkoqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF862C85B20
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

On 2025-09-23 03:25, Zhu Lingshan wrote:
> This commit introduces a new id field for
> struct kfd process, which helps identify
> a kfd process among multiple contexts that
> all belong to a single user space program.
>
> The sysfs entry of a secondary kfd process
> is placed under the sysfs entry folder of
> its primary kfd process.
>
> The naming format of the sysfs entry of a secondary
> kfd process is "context_%u" where %u is the process id.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  6 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 83 +++++++++++++++++++++++-
>   2 files changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index d1436f1f527d..d140463e221b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -998,6 +998,9 @@ struct kfd_process {
>   	/* Tracks debug per-vmid request for debug flags */
>   	u32 dbg_flags;
>   
> +	/* kfd process id */
> +	u16 id;

Can this subsume the "primary" flag? E.g. process->id == 0 could mean 
"primary context", and all the secondary contexts could have non-0 IDs.

Regards,
   Felix


> +
>   	atomic_t poison;
>   	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
>   	bool queues_paused;
> @@ -1012,6 +1015,9 @@ struct kfd_process {
>   
>   	/* indicating whether this is a primary kfd_process */
>   	bool primary;
> +
> +	/* The primary kfd_process allocating IDs for its secondary kfd_process, 0 for primary kfd_process */
> +	struct ida id_table;
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 8 /* bits: 256 entries */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 5d59a4d994d5..8e498fd35b8c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -54,6 +54,9 @@ DEFINE_MUTEX(kfd_processes_mutex);
>   
>   DEFINE_SRCU(kfd_processes_srcu);
>   
> +#define KFD_PROCESS_ID_MIN 1
> +#define KFD_PROCESS_ID_WIDTH 16
> +
>   /* For process termination handling */
>   static struct workqueue_struct *kfd_process_wq;
>   
> @@ -827,6 +830,7 @@ static void kfd_process_device_destroy_ib_mem(struct kfd_process_device *pdd)
>   
>   int kfd_create_process_sysfs(struct kfd_process *process)
>   {
> +	struct kfd_process *primary_process;
>   	int ret;
>   
>   	if (process->kobj) {
> @@ -839,9 +843,22 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   		pr_warn("Creating procfs kobject failed");
>   		return -ENOMEM;
>   	}
> -	ret = kobject_init_and_add(process->kobj, &procfs_type,
> -				   procfs.kobj, "%d",
> -				   (int)process->lead_thread->pid);
> +
> +	if (process->primary)
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   procfs.kobj, "%d",
> +					   (int)process->lead_thread->pid);
> +	else {
> +		primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +		if (!primary_process)
> +			return -ESRCH;
> +
> +		ret = kobject_init_and_add(process->kobj, &procfs_type,
> +					   primary_process->kobj, "context_%u",
> +					   process->id);
> +		kfd_unref_process(primary_process);
> +	}
> +
>   	if (ret) {
>   		pr_warn("Creating procfs pid directory failed");
>   		kobject_put(process->kobj);
> @@ -863,6 +880,51 @@ int kfd_create_process_sysfs(struct kfd_process *process)
>   	return 0;
>   }
>   
> +static int kfd_process_alloc_id(struct kfd_process *process)
> +{
> +	int ret;
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary) {
> +		process->id = 0;
> +
> +		return 0;
> +	}
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return -ESRCH;
> +
> +	ret = ida_alloc_range(&primary_process->id_table, KFD_PROCESS_ID_MIN,
> +	     (1 << KFD_PROCESS_ID_WIDTH) - 1, GFP_KERNEL);
> +	if (ret < 0)
> +		goto out;
> +
> +	process->id = ret;
> +	ret = 0;
> +
> +out:
> +	kfd_unref_process(primary_process);
> +
> +	return ret;
> +}
> +
> +static void kfd_process_free_id(struct kfd_process *process)
> +{
> +	struct kfd_process *primary_process;
> +
> +	if (process->primary)
> +		return;
> +
> +	primary_process = kfd_lookup_process_by_mm(process->lead_thread->mm);
> +	if (!primary_process)
> +		return;
> +
> +	ida_free(&primary_process->id_table, process->id);
> +
> +	kfd_unref_process(primary_process);
> +}
> +
>   struct kfd_process *kfd_create_process(struct task_struct *thread)
>   {
>   	struct kfd_process *process;
> @@ -1193,6 +1255,11 @@ static void kfd_process_wq_release(struct work_struct *work)
>   	if (ef)
>   		dma_fence_signal(ef);
>   
> +	if (!p->primary)
> +		kfd_process_free_id(p);
> +	else
> +		ida_destroy(&p->id_table);
> +
>   	kfd_process_remove_sysfs(p);
>   	kfd_debugfs_remove_process(p);
>   
> @@ -1549,6 +1616,12 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   	process->queues_paused = false;
>   	process->primary = primary;
>   
> +	err = kfd_process_alloc_id(process);
> +	if (err) {
> +		pr_err("Creating kfd process: failed to alloc an id\n");
> +		goto err_alloc_id;
> +	}
> +
>   	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
>   	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
>   	process->last_restore_timestamp = get_jiffies_64();
> @@ -1599,6 +1672,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   			goto err_register_notifier;
>   		}
>   		BUG_ON(mn != &process->mmu_notifier);
> +
> +		ida_init(&process->id_table);
>   	}
>   
>   	kfd_unref_process(process);
> @@ -1619,6 +1694,8 @@ static struct kfd_process *create_process(const struct task_struct *thread, bool
>   err_process_pqm_init:
>   	kfd_event_free_process(process);
>   err_event_init:
> +	kfd_process_free_id(process);
> +err_alloc_id:
>   	mutex_destroy(&process->mutex);
>   	kfree(process);
>   err_alloc_process:
