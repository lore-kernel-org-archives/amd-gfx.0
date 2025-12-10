Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA80D2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 04:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A521910E654;
	Wed, 10 Dec 2025 04:13:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uz0dZsIM";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010038.outbound.protection.outlook.com
 [52.101.193.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD31110E654
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 04:13:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNpZFYGx1Bqoj3ANKinBWIm3sODnIHD4a+sVyVK6ZU/XJDp05M5/CHc81xq7ceG1/g31OV3z76qaHrTw8v9UG5GEmvcQBvycuNh7PbO0fQImQQC4KNCZfDnlvwGI1P7qBjUvx4Mkj9dcs2k41dpXjBiUuZmnhWGjdYOsgpyNFz3JrgnWsqBcKBCcoUCApiFeLSgFjCoY253ptQTBTBDx5R1ol1GStRvaQuvQ4/G+N2IZrJq2f2btjChm2Q+NqHwmvvsbBd7JLANeO6/T8q52h1hVmjh7NWUaZBSLU55d3cHbiTDn/nMejNGyznLfTSLltYeI69aUElYBr2tzH4sYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iE43sY6C3DZrLHDDrXRnkPtjUSklGMR98Fy9a0dw5b4=;
 b=XVmGrzQPcKJe19QfgrnV78sPstDbNH/ddhIATLl1anZvn/hJPY0tiXvQOGF0M7UCkjEPdNr4E9DE5b7WnnzmmU2qrUp+8zmxfCb5QZKsqnAWQtwdROJn3yZxDYRj2N5GvPJoMhOvy6SCiGqDHv+yP4FtLeCbUw+edg3V39BYN9ddzqUTQhXFuNI4iCkuS4GxIwNv2gJVym1ai63kxJLfNcgwbYs0i/dPA0gJtVyKzrO2NkOHDHuXMs0gZ0HqGRR3s/8UTcMU9XLtCs7IhFbCcshnJUdavdGoUgFDDxlbeacBa/qlGb3p3L27Zm6IzRWEwDnEuabXpcm5mqBSuUKEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iE43sY6C3DZrLHDDrXRnkPtjUSklGMR98Fy9a0dw5b4=;
 b=Uz0dZsIMvzRLd6xIb8jISf2AnlTiX8xu4BL9vFKuQf5Q5ZJE5yLbr9aTjmOoar2/HttTQ8KKFSktc39iMNo6lA6URvu9dfIjt/nY+CTDu8H224S1iTNc/Da2zjwlmp4scsn1yOZba6caiIY+b7W4hTsGDYK3ysgPAjjhvX2mqGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 04:13:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::d759:a62b:f8ba:461d%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 04:13:34 +0000
Message-ID: <815a5f79-1eb4-4001-9274-605376744d8a@amd.com>
Date: Wed, 10 Dec 2025 09:43:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deng, Emily" <Emily.Deng@amd.com>
References: <20251209073831.1426657-1-chongli2@amd.com>
 <4e4a99a9-5fff-42c1-ae5a-b2f925df2633@amd.com>
 <MN0PR12MB5761696F1F3009C6F4EB2F969BA0A@MN0PR12MB5761.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <MN0PR12MB5761696F1F3009C6F4EB2F969BA0A@MN0PR12MB5761.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::17) To SJ0PR12MB7082.namprd12.prod.outlook.com
 (2603:10b6:a03:4ae::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c1e88f-9e65-4b1c-23af-08de37a27b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3Q3K2ZDc2xzRk9RN1M5RXhmK0JyamhwL1VxVHpnMGlYb2N6WTB5M08wdkc3?=
 =?utf-8?B?cmRONUxnYmdxTEwzVit5dTF6c2hMOHhTdG50OFdjNnVwSVkyTTg1OVRwb29S?=
 =?utf-8?B?ZHFLMGN3ejQ2aENaUW4yNFRJYkNwNGpUUW9VMHBBL1ZLc2NNYjlXVjhOc0pQ?=
 =?utf-8?B?Sk1IdG94VWtERDh2UHFwM0tKcUlHdmVVRVhhcHZHQmQwOFdMR2h1YUJuWWZj?=
 =?utf-8?B?Y0NjQlhoMWNKUGI0UE16cUI1NU1NbkF4Vk1MSk1Yamo1R1dnNWJpUjRhUWNK?=
 =?utf-8?B?SHBHU281ZGJLVk1MakViOWRldUMySE03VWd4RnM3QmIvZjY5ZXNxWTFtUHlP?=
 =?utf-8?B?eTFWb2VsMlMxeTF2RUNydFZQdkJYWFZ0ZU1Nd25GL1FyU3BnWXNKeklhd0Zs?=
 =?utf-8?B?ZTdBUy9aZTNnZllLQlU4MjVBQW5RcHkxTjUyM2RYRG5vQUIvaEIrcnF6NkVG?=
 =?utf-8?B?Uld2SkxacSt2U3VJUmR2VnRoeFlIODNTcmNtWkZUNFBES3ZxSmF2bkZvVnZF?=
 =?utf-8?B?TjVUWFZJK1RGb01kcDMzaElxekVrSVZLRTBhQWduOU1QWDdjMTdIQnNkMloy?=
 =?utf-8?B?RmN4bkF0L01nQXpPRmIzalh3elEyZWo0RWh4eUIwditvMFcxeUtHaFdaREw0?=
 =?utf-8?B?djE4SEdPVFJDRkwzSUU2SHU2bjNOb1RlQnFybVhlNDlZRSs0eXZvdUJnQWEv?=
 =?utf-8?B?WnBETTBBc2l5WHVWdmhHUEJHUVdweTVtMkd6eitkNEhnU2hLbStRMmI0ZTBV?=
 =?utf-8?B?OWs3NWRucFZ5eCthaExDS25TSlM2c1NaUnVaa1VJR2xwNm5GUUxIaGtJcXBr?=
 =?utf-8?B?R29rNlZMdFlEOTc5NmtTei9WUzlnQUFCbUUyaXR4RXJEbVdPZDltZDF2QXdy?=
 =?utf-8?B?Q215UnZiU0Q3cVFLazB5RXVtd04ybmM3Njk2TWhMSzBudjJrckMyUDJUcXlm?=
 =?utf-8?B?K0JNVzJ1L0RRWVQ2SzdHa1RvS2xmR0JpVG9oRFdNeTdnbVI3bmMyS2pTcEdJ?=
 =?utf-8?B?cFlXb0pQN0JmWmYyNXdvR2p2MGVvMkpLWW5KaHpyVFBTMnFLTlZnejgwVVdU?=
 =?utf-8?B?UWZpenF0NHdwblJkZkhoLytuVE5WeUttODdhTjltMjcveEtoWjZYeWMxTDc1?=
 =?utf-8?B?TkQ5MUNqNWRWcmNWUUYvZGhGaDZDTG5LKy9qbHowK1B1UG9PQjMvWEdSTmZz?=
 =?utf-8?B?STdiYjVMbHZHQllHSExySk8zUEpTWU5BalQzK25zcWkzYXhIejJvWVI2RkNn?=
 =?utf-8?B?SXRITGxoelRDeWlxT2tpdTkybDRma2QvblNvTTdrY3ZWRzFRY2x5QjJGUlo5?=
 =?utf-8?B?RmdIVng0dG1PRkJ3STVESENmZE8yTXhEVkFFdVEwL01hYlFOZlViNTFwMFpy?=
 =?utf-8?B?Mm5rcU9FeFhULzRubDV2UmE4Rmd0aDR6blp1TldiQ0RSR3cxRVExNjhSUWdJ?=
 =?utf-8?B?V0o4TnNFZnljbzlMbWdjL1NLbHhNYjNVSWtkSmhOL1VpYUR1SEJZd1EzN2dh?=
 =?utf-8?B?R2RjcjduN2VJbS9zUzVQdUVOMCtKTU1ibGlNNW5ZS212ZWt5Mk14RnpycGZP?=
 =?utf-8?B?SHJQYkRsWVY3YmZyZksrSWVEWmtaUnVVdExFd2tBRDdibzRwTzduMDBDdkxm?=
 =?utf-8?B?dERIaXg1a214WCtaUnpZMzJDUG1hR0lkRXhoblNrVFBad2dQeDVkWVBIWlFq?=
 =?utf-8?B?aDZXaUFPTWdaZmcyVEdvMkhSMmtrK2xqWkd2ek1uOFR1L2xINHV4REFIeW9m?=
 =?utf-8?B?c2FBSWNUYXpTeGswUXZHbG1Qa3NLMmEzN2NZelRYemZnSTNrdURiU2VhaFFa?=
 =?utf-8?B?VkxrWjVkWXM0alVDMWlwZHdvKzIyZ1RaaFJDQjZQWGRIK3Vvb2h5MzZUdnY5?=
 =?utf-8?B?L2hRd0NOSEl6b2NPcWNUMGx0TDVnSzdxMkxpa2RmRHVONjhMTDJWc3JJQXNp?=
 =?utf-8?Q?//Dh5FwL278FKc9mmBf0upfgC8HtS3l+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmp0Y0FUUk5EN0owNlJ5bSttb2FnZ0lxL1lXVTFMdG9iMTlhU1poUG1nWTlk?=
 =?utf-8?B?OWZMTkt1eWYzWENWclhaSnNOYmE3REdhNWgvSHhvREh5NVRVNjY2Y053c3hJ?=
 =?utf-8?B?aUl2VlMraUk5bzBZZlNHQzQ5SGZEdjdidlhjNTVxZWp3cE03YUxYT0hxQzVI?=
 =?utf-8?B?MDZlOFB6RWpxZ3dQNHUzdnFQRjJjSERXcGRGbm9kcHQ3M0V6WGxQSDFZdHds?=
 =?utf-8?B?ak84NXlMT0lzL0lmWGIwVHhOd1M3WmtnMFB1dTJuUCsrU0w3ZGFaYWtBODJ2?=
 =?utf-8?B?aENKSFpyUWY4b3dMZlBNeG82bThYQ1hTTHdlRDhIQW5FcUdJaFc0YVE3b3JX?=
 =?utf-8?B?U1U4R2I0RlZBQzdnTGtHZ0w2WmoyN2RrSldDOTg1TE5LaE13dkpWOEZzeFha?=
 =?utf-8?B?WWFSbUk4QkZ2b1VkZ2NzWXF0M2NoUUg2UHhyd2dUUUNsWWlqdExzN29SZ3ZZ?=
 =?utf-8?B?QVVBRWRreFJ1V1NDQ0dmbnFVUU93TGZvSUZ1T3BCdW44cmdIcjE2UTUzdlFM?=
 =?utf-8?B?TDQyMWVPNkd2UGlEOEE1VHB0Nldqc3U3QjJudzlYTGR4T2tWK2hGMlZpU0pz?=
 =?utf-8?B?RjFId2hneDlPYW9wRlc1MnkvRS9yTjFBd3BaUmJqVnI2cEVwRDEwSWFEN3Vx?=
 =?utf-8?B?QnIxZU8yczJxbURnWGgrdGd3MmhKY3o0USsrZmt3OE1idnZHc2NWVksxNG5z?=
 =?utf-8?B?NmlxZ0VUcm1NYStjamF5aFdpcTBDc1dvcllpc2J0NG5JTnZjUHYyaXlNTGYr?=
 =?utf-8?B?d1Z2ditTVEVqRzl1TEZsVlYyR1JJREdDbEd6THVzb3l0SnhLSFZML1pmVnU0?=
 =?utf-8?B?NjVCeXl0SWVPa0pZRmJVYzdnNWliNi9GRzlzK2JFVmFiY2RPaEFVZGpIdWdj?=
 =?utf-8?B?elYwUy9WR0dZZmd1dnovUnRmVFc1UmQzbVVHaGxjTlcwc3BVWG16d0xFUHE2?=
 =?utf-8?B?UnVoemh2aXlqczVvVTZRYy9yZnVaS1I2eW9mRzAvNkJaZXA5cHlBVDQ2QTY5?=
 =?utf-8?B?dnYxOThQSjRaQkVBSUo5TlpNdWMwL2JvbFZqbGNHeE81QTY4dDJvTnIzbkZ1?=
 =?utf-8?B?ZnZJKzgyZy9GR29JWldKNWNtWWd4Uzc4YnRzMDRMcjVPTzhHQkRNdVVoTXlD?=
 =?utf-8?B?cGhPYW5wS0pxZDNnbzJXUS9nMTZ1TUo5d2NuWmRjWmRkcHlWaXN6TiszVEQv?=
 =?utf-8?B?UUhrbk1Xc0NlOElRVG13bzlWT2FjS0Jpb3k1bzIwQTBJQ2lTcXFtclB2Nk9K?=
 =?utf-8?B?d0xKRjdwd3hWdXI5UEptODFMOTk1QStKRWxoakJ5OFo2clFMUjZtTU15T1pk?=
 =?utf-8?B?clRqaWZ5ZC9LcjRwa25HeGJwWnVnSWJDYTVPRkpGNDZ1MHp5TzRrdWdJazNV?=
 =?utf-8?B?ZzNXc21ySkVoZ2E3QTlINWZSVXg3MHdGbzNaT3ErbkZ3VkRINituT1hVZy9T?=
 =?utf-8?B?NC9SR1VEQ1lsdzIzdmN4cUVmZm5FMzhxZ3BrdUZ3T29nWlNMcFVKZzFaT3Jy?=
 =?utf-8?B?a0RJSGlNWHZweVJjWmRxMTltdHEvVEFieCtzTmV5K1pPWmZubWJqSE13YWgw?=
 =?utf-8?B?ZzU0dXQ1N3ZWNlVycE9uYXhYOElqMzRDK1VsMndoSTVXdDYvdEtJNXJndU1i?=
 =?utf-8?B?SGNWM1VldmE5ZEtKL2w3TDh3UkVIMWdaZ0hmMjlscUJZcElaZUlteXJSMDUv?=
 =?utf-8?B?eUdIeERQQ1NSZU53WmVQelBPOVk2UEZmUzEvdWxYbC91S09tMU5XMFFNcGRM?=
 =?utf-8?B?V3dISE9tZmtERVJKcENnV3RSRmJHM3hYQ29MR0VYU2RGMlljajRRYnNoQUJK?=
 =?utf-8?B?OTl2ZHNVUnF2Wko1V3dlazQ5d1QzSmpBRVdlTk1BcENxSGhSTTYrM0wyYTJM?=
 =?utf-8?B?NjI1b2ZEZEZUU2JwTlVRN0xKSW4yWjVCZS85Rjc0UTRRYnlTMFFqcFk1b3pU?=
 =?utf-8?B?NENIRkZWVGRadHZucFc2ZXZZRDh3SVpVV0R1K2lOb1dHZmp0YUN5K2V1bWY5?=
 =?utf-8?B?QjZXdHI1dFlQRksyWmIxZmd1VnRaSEQyRTlFSDVEMjRCVnFHZHVQU1pyc0hP?=
 =?utf-8?B?amc1WTViQ3RsSWVlTEJNT2RsSTRKSDlPR0tZSnJnVjBBVzFqdjNHWlo2Tm1j?=
 =?utf-8?Q?M6ALLuA4b+mH2/JWcgYtMpbTp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c1e88f-9e65-4b1c-23af-08de37a27b4b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7082.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 04:13:34.2690 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJRCHuGksla3ils+E0PhhlTxQCKzVELyAadUxYgc3Bz0URhBcOtIxz9KTyMPV2ih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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



On 12/10/2025 8:32 AM, Li, Chong(Alan) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi, Lijo.
> -----------------------------------------------------------------------------------------------
> It appears like gfx v9/9.4.3/10/11/12 all can be kept in some amdgpu_gfx_get_ref_mask generic helper, then it's not required to repeat the logic.
> 
> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>          ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>          switch (ring->me) {
>          case 1:
>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>                  break;
>          case 2:
>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>                  break;
>          default:
>                  return;
>          }
>          *reg_mem_engine = 0;
>          return;
> }
> 
> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>          *reg_mem_engine = 0;
> } else {
>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>          *reg_mem_engine = 1; /* pfp */
> }
> ------------------------------------------------------------------------------
> 
> In gfx10, the ring->me of kiq is 2, this code can pass.
> But in gfx11 and gfx12, the ring->me of kiq is 3, so this code logic does not work.

Is this about mes kiq? There is a flag to check that as well - 
adev->enable_mes_kiq.

Thanks,
Lijo

> 
> As the value of ring->me has changed with gfx version,
> the code logic is not repeat, I suggest keep the origin way to assign ref_and_mask.
> 
> 
> I accept your suggestion of add params check, alignment mismatch and delete the unused variable "usepfp".
> 
> 
> Thanks,
> Lijo
> 
> 
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, December 9, 2025 6:03 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH v3] drm/amdgpu: fix mes packet params issue when flush hdp.
> 
> 
> 
> On 12/9/2025 1:08 PM, chong li wrote:
>> v3:
>> Unify the get_ref_and_mask function in amdgpu_gfx_funcs, to support
>> both GFX11 and earlier generations
>>
>> v2:
>> place "get_ref_and_mask" in amdgpu_gfx_funcs instead of amdgpu_ring,
>> since this function only assigns the cp entry.
>>
>> v1:
>> both gfx ring and mes ring use cp0 to flush hdp, cause conflict.
>>
>> use function get_ref_and_mask to assign the cp entry.
>> reassign mes to use cp8 instead.
>>
>> Signed-off-by: chong li <chongli2@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 +++++-
>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 54 +++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 58 +++++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 58 +++++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   | 55 +++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 55 +++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 54 +++++++++++++++--------
>>    drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 54 +++++++++++++++--------
>>    9 files changed, 275 insertions(+), 128 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index efd61a1ccc66..090714127cba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -356,6 +356,8 @@ struct amdgpu_gfx_funcs {
>>                                     int num_xccs_per_xcp);
>>        int (*ih_node_to_logical_xcc)(struct amdgpu_device *adev, int ih_node);
>>        int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
>> +     void (*get_ref_and_mask)(struct amdgpu_ring *ring,
>> +                             uint32_t *ref_and_mask, uint32_t *reg_mem_engine);
>>    };
>>
>>    struct sq_work {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index 895b841b9626..5c7724f203d0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -556,11 +556,20 @@ int amdgpu_mes_reg_write_reg_wait(struct
>> amdgpu_device *adev,
>>
>>    int amdgpu_mes_hdp_flush(struct amdgpu_device *adev)
>>    {
>> -     uint32_t hdp_flush_req_offset, hdp_flush_done_offset, ref_and_mask;
>> +     uint32_t hdp_flush_req_offset, hdp_flush_done_offset;
>> +     struct amdgpu_ring *mes_ring;
>> +     uint32_t ref_and_mask = 0, reg_mem_engine = 0;
>>
>> +     if (!adev->gfx.funcs->get_ref_and_mask) {
>> +             dev_err(adev->dev, "amdgpu_mes_hdp_flush not support\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     mes_ring = &adev->mes.ring[0];
>>        hdp_flush_req_offset = adev->nbio.funcs->get_hdp_flush_req_offset(adev);
>>        hdp_flush_done_offset = adev->nbio.funcs->get_hdp_flush_done_offset(adev);
>> -     ref_and_mask = adev->nbio.hdp_flush_reg->ref_and_mask_cp0;
>> +
>> +     adev->gfx.funcs->get_ref_and_mask(mes_ring, &ref_and_mask,
>> +&reg_mem_engine);
>>
>>        return amdgpu_mes_reg_write_reg_wait(adev, hdp_flush_req_offset, hdp_flush_done_offset,
>>                                             ref_and_mask, ref_and_mask, 0); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index aaed24f7e716..ed79ceafc57b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -4566,6 +4566,40 @@ static void gfx_v10_0_update_perfmon_mgcg(struct amdgpu_device *adev,
>>                WREG32_SOC15(GC, 0, mmRLC_PERFMON_CLK_CNTL, data);
>>    }
>>
>> +/**
>> + * gfx_v10_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v10_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> +adev->nbio.hdp_flush_reg;
>> +
> 
> Need to do NULL check of params (this and others).
> 
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> +             *reg_mem_engine = 1; /* pfp */
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v10_0_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v10_0_select_se_sh, @@ -4575,6 +4609,7 @@
>> static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
>>        .select_me_pipe_q = &gfx_v10_0_select_me_pipe_q,
>>        .init_spm_golden = &gfx_v10_0_init_spm_golden_registers,
>>        .update_perfmon_mgcg = &gfx_v10_0_update_perfmon_mgcg,
>> +     .get_ref_and_mask = &gfx_v10_0_get_ref_and_mask,
>>    };
>>
>>    static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev) @@
>> -8614,25 +8649,8 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        u32 ref_and_mask, reg_mem_engine;
>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> -             reg_mem_engine = 1; /* pfp */
>> -     }
>>
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        gfx_v10_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                               adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                               adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f4d4dd5dd07b..c3d8e7588740 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1072,6 +1072,44 @@ static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>>        }
>>    }
>>
>> +/**
>> + * gfx_v11_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v11_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> +adev->nbio.hdp_flush_reg;
>> +
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             case 3:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> +             *reg_mem_engine = 1; /* pfp */
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v11_0_select_se_sh, @@ -1081,6 +1119,7 @@
>> static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
>>        .select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
>>        .update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
>>        .get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
>> +     .get_ref_and_mask = &gfx_v11_0_get_ref_and_mask,
>>    };
>>
>>    static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev) @@
>> -5833,25 +5872,8 @@ static void gfx_v11_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        u32 ref_and_mask, reg_mem_engine;
>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> -             reg_mem_engine = 1; /* pfp */
>> -     }
>>
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        gfx_v11_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                               adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                               adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> index f9cae6666697..b805ed4f88aa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
>> @@ -929,6 +929,44 @@ static int gfx_v12_0_get_gfx_shadow_info(struct amdgpu_device *adev,
>>        return -EINVAL;
>>    }
>>
>> +/**
>> + * gfx_v12_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v12_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> +adev->nbio.hdp_flush_reg;
>> +
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +         ring->funcs->type == AMDGPU_RING_TYPE_MES ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             case 3:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> +             *reg_mem_engine = 1; /* pfp */
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v12_0_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v12_0_select_se_sh, @@ -938,6 +976,7 @@ static
>> const struct amdgpu_gfx_funcs gfx_v12_0_gfx_funcs = {
>>        .select_me_pipe_q = &gfx_v12_0_select_me_pipe_q,
>>        .update_perfmon_mgcg = &gfx_v12_0_update_perf_clk,
>>        .get_gfx_shadow_info = &gfx_v12_0_get_gfx_shadow_info,
>> +     .get_ref_and_mask = &gfx_v12_0_get_ref_and_mask,
>>    };
>>
>>    static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev) @@
>> -4389,25 +4428,8 @@ static void gfx_v12_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        u32 ref_and_mask, reg_mem_engine;
>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> -             reg_mem_engine = 1; /* pfp */
>> -     }
>>
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        gfx_v12_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                               adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                               adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index 66a4e4998106..b3ea45e3c60f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2068,23 +2068,10 @@ static int gfx_v7_0_ring_test_ring(struct amdgpu_ring *ring)
>>    static void gfx_v7_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        u32 ref_and_mask;
>> -     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -     } else {
>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>> -     }
>> +     int usepfp;
>> +     struct amdgpu_device *adev = ring->adev;
>>
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask, &usepfp);
>>        amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>        amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>>                                 WAIT_REG_MEM_FUNCTION(3) |  /* == */ @@ -4075,12 +4062,46 @@
>> static void gfx_v7_0_select_me_pipe_q(struct amdgpu_device *adev,
>>        cik_srbm_select(adev, me, pipe, q, vm);
>>    }
>>
>> +/**
>> + * gfx_v7_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v7_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     int usepfp = ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ? 0 : 1;
> 
> This doesn't look used inside this function.
> 
>> +
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>> +             *reg_mem_engine = 1;
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v7_0_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v7_0_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v7_0_select_se_sh,
>>        .read_wave_data = &gfx_v7_0_read_wave_data,
>>        .read_wave_sgprs = &gfx_v7_0_read_wave_sgprs,
>> -     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q
>> +     .select_me_pipe_q = &gfx_v7_0_select_me_pipe_q,
>> +     .get_ref_and_mask = &gfx_v7_0_get_ref_and_mask,
>>    };
>>
>>    static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_funcs = { diff
>> --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> index 5d6e8e0601cb..cc5acfcdf360 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> @@ -5211,13 +5211,46 @@ static void gfx_v8_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
>>                start + SQIND_WAVE_SGPRS_OFFSET, size, dst);
>>    }
>>
>> +/**
>> + * gfx_v8_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v8_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +
>> +     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>> +         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>> +             *reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>> +     }
>> +}
>>
>>    static const struct amdgpu_gfx_funcs gfx_v8_0_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v8_0_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v8_0_select_se_sh,
>>        .read_wave_data = &gfx_v8_0_read_wave_data,
>>        .read_wave_sgprs = &gfx_v8_0_read_wave_sgprs,
>> -     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q
>> +     .select_me_pipe_q = &gfx_v8_0_select_me_pipe_q,
>> +     .get_ref_and_mask = &gfx_v8_0_get_ref_and_mask,
>>    };
>>
>>    static int gfx_v8_0_early_init(struct amdgpu_ip_block *ip_block) @@
>> -6000,25 +6033,9 @@ static void gfx_v8_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
>>    static void gfx_v8_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        u32 ref_and_mask, reg_mem_engine;
>> +     struct amdgpu_device *adev = ring->adev;
>>
>> -     if ((ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) ||
>> -         (ring->funcs->type == AMDGPU_RING_TYPE_KIQ)) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP2_MASK << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = GPU_HDP_FLUSH_DONE__CP6_MASK << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = GPU_HDP_FLUSH_DONE__CP0_MASK;
>> -             reg_mem_engine = WAIT_REG_MEM_ENGINE(1); /* pfp */
>> -     }
>> -
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
>>        amdgpu_ring_write(ring, (WAIT_REG_MEM_OPERATION(1) | /* write, wait, write */
>>                                 WAIT_REG_MEM_FUNCTION(3) |  /* == */ diff --git
>> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> index e6187be27385..f2ebacc73eb2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> @@ -1997,6 +1997,40 @@ static void gfx_v9_0_select_me_pipe_q(struct amdgpu_device *adev,
>>        soc15_grbm_select(adev, me, pipe, q, vm, 0);
>>    }
>>
>> +/**
>> + * gfx_v9_0_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v9_0_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> +adev->nbio.hdp_flush_reg;
>> +
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> +             *reg_mem_engine = 1; /* pfp */
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>            .get_gpu_clock_counter = &gfx_v9_0_get_gpu_clock_counter,
>>            .select_se_sh = &gfx_v9_0_select_se_sh, @@ -2004,6 +2038,7
>> @@ static const struct amdgpu_gfx_funcs gfx_v9_0_gfx_funcs = {
>>            .read_wave_sgprs = &gfx_v9_0_read_wave_sgprs,
>>            .read_wave_vgprs = &gfx_v9_0_read_wave_vgprs,
>>            .select_me_pipe_q = &gfx_v9_0_select_me_pipe_q,
>> +             .get_ref_and_mask = &gfx_v9_0_get_ref_and_mask,
> 
> Alignment mismatch?
> 
>>    };
>>
>>    const struct amdgpu_ras_block_hw_ops  gfx_v9_0_ras_ops = { @@
>> -5380,25 +5415,8 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        u32 ref_and_mask, reg_mem_engine;
>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> -             reg_mem_engine = 1; /* pfp */
>> -     }
>>
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        gfx_v9_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                              adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                              adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> index 89253df5ffc8..b4ba76110c34 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
>> @@ -838,6 +838,40 @@ static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
>>        return xcc - 1;
>>    }
>>
>> +/**
>> + * gfx_v9_4_3_get_ref_and_mask - get the reference and mask for HDP
>> +flush
>> + *
>> + * @ring: amdgpu_ring structure holding ring information
>> + * @ref_and_mask: pointer to store the reference and mask
>> + * @reg_mem_engine: pointer to store the register memory engine
>> + *
>> + * Calculates the reference and mask for HDP flush based on the ring type and me.
>> + */
>> +static void gfx_v9_4_3_get_ref_and_mask(struct amdgpu_ring *ring,
>> +                                     uint32_t *ref_and_mask, uint32_t *reg_mem_engine) {
>> +     struct amdgpu_device *adev = ring->adev;
>> +     const struct nbio_hdp_flush_reg *nbio_hf_reg =
>> +adev->nbio.hdp_flush_reg;
>> +
>> +     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>> +             ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>> +             switch (ring->me) {
>> +             case 1:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> +                     break;
>> +             case 2:
>> +                     *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> +                     break;
>> +             default:
>> +                     return;
>> +             }
>> +             *reg_mem_engine = 0;
>> +     } else {
>> +             *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>> +             *reg_mem_engine = 1; /* pfp */
>> +     }
>> +}
>> +
>>    static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>        .get_gpu_clock_counter = &gfx_v9_4_3_get_gpu_clock_counter,
>>        .select_se_sh = &gfx_v9_4_3_xcc_select_se_sh, @@ -848,6 +882,7 @@
>> static const struct amdgpu_gfx_funcs gfx_v9_4_3_gfx_funcs = {
>>        .switch_partition_mode = &gfx_v9_4_3_switch_compute_partition,
>>        .ih_node_to_logical_xcc = &gfx_v9_4_3_ih_to_xcc_inst,
>>        .get_xccs_per_xcp = &gfx_v9_4_3_get_xccs_per_xcp,
>> +     .get_ref_and_mask = &gfx_v9_4_3_get_ref_and_mask,
>>    };
>>
>>    static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle, @@
>> -2818,25 +2853,8 @@ static void gfx_v9_4_3_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>    {
>>        struct amdgpu_device *adev = ring->adev;
>>        u32 ref_and_mask, reg_mem_engine;
>> -     const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>> -
>> -     if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE) {
>> -             switch (ring->me) {
>> -             case 1:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>> -                     break;
>> -             case 2:
>> -                     ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>> -                     break;
>> -             default:
>> -                     return;
>> -             }
>> -             reg_mem_engine = 0;
>> -     } else {
>> -             ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
>> -             reg_mem_engine = 1; /* pfp */
>> -     }
>>
> 
> It appears like gfx v9/9.4.3/10/11/12 all can be kept in some amdgpu_gfx_get_ref_mask generic helper, then it's not required to repeat the logic.
> 
> if (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE ||
>          ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
>          switch (ring->me) {
>          case 1:
>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp2 << ring->pipe;
>                  break;
>          case 2:
>                  *ref_and_mask = nbio_hf_reg->ref_and_mask_cp6 << ring->pipe;
>                  break;
>          default:
>                  return;
>          }
>          *reg_mem_engine = 0;
>          return;
> }
> 
> if (ring->funcs->type == AMDGPU_RING_TYPE_MES) {
>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp8 << ring->pipe;
>          *reg_mem_engine = 0;
> } else {
>          *ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
>          *reg_mem_engine = 1; /* pfp */
> }
> 
> 
> Thanks,
> Lijo
> 
>> +     adev->gfx.funcs->get_ref_and_mask(ring, &ref_and_mask,
>> +&reg_mem_engine);
>>        gfx_v9_4_3_wait_reg_mem(ring, reg_mem_engine, 0, 1,
>>                              adev->nbio.funcs->get_hdp_flush_req_offset(adev),
>>                              adev->nbio.funcs->get_hdp_flush_done_offset(adev),
> 

