Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE54CCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFBF10E184;
	Thu, 30 Oct 2025 15:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XEVuMXKp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F31E10E184
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXZRBokCgjCdyY1JsIoVm44pl/ZAFy67bjS1rJm/7rATUiOnJC7RaOIvWUBImiA2RBRaCcOQCcgOkxQvtXjbNL3feZgFEIMnpU2DA9TBymsKp/mHfGLr9pU5jUK06sjflfxqVafJSEdDDlDhurwbVV6MYHi+9wRtIA7UamfzP42Wy121y3wZPAv+B9hnSQDwncgQU5xppOfjXYqKnNdiMCAY8E41SYpEsyGe+6YYChd4chadUBAE3aOeTAkCIH/5Mxmtvzlh0dTrIwPBYK1FDXyIHHux7FTqGUEM4jTvIR3T4LInu0IcLPPKH+967e28MePb9mWavjaEgUwsi2HJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQCJ23+3l98WAf0fC55P94xcupuiDPO3fPikhLVtJe0=;
 b=aFDcEom12K/uO3tOoj3w3dPKB4362MVU5kp30b6OHdWs/yqqHFRpuYO5jBltA0tzo0FaPs4JmXh3kn1r1GXFemx9xhrbHQW6A6qc/9Ik1hSY7kNsFGXpwCHOE1Vnzqnvi+tusOGunzrAHgMJ4FCAE8k3l/khS/Ee/3o58MuuX6EsL8ZAKaaqbjq0fGCRvrigSpW8CI94ZUUOKRIKWH6BksUPjYlUrly318msDCl3J/5fo+VzPPoa54D7WyS0ZX3jM5KtRbDIEMTkPJJuNTNIg1+Mho5HP8yZGWZa+Uk2pFhvTTNilNaLvdxhtRlLmvDteSp5B2QNKbcaex8hk+F/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQCJ23+3l98WAf0fC55P94xcupuiDPO3fPikhLVtJe0=;
 b=XEVuMXKpJaYBpc13anNM5GgPBeLYFcUVgHW/rfsra94hm+5Qg+90fhGEKYRzGMS4UOymN5q8hZFafPBMKBQHsk5+wsYhqj582b8ocuzlVu+G6TwcKpcEctsOHW2/ntSa5+qCLBge86TgupE2F68a1OR3CBeWhUIO8eHLnzVQXDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 15:17:28 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 15:17:27 +0000
Message-ID: <1af7d99e-d31b-42b9-9883-f9340d17dbfd@amd.com>
Date: Thu, 30 Oct 2025 20:47:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/ras: Fix format truncation
To: Xiang Liu <xiang.liu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, Stanley.Yang@amd.com,
 YiPeng.Chai@amd.com
References: <20251030144113.2702507-1-xiang.liu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251030144113.2702507-1-xiang.liu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 4902e384-748f-4249-3e1b-08de17c76f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cVc3Ym4wQUZVaHZoSStReEFtNERSZW1qUmhnUDBiVmFMbTVPbTZxdWxRYy9n?=
 =?utf-8?B?K2NqUmVUUGxaTTN2YkFRYU10QTFZejF1K2lnTVpkNWwrTGJiS3RMVXNVUHdC?=
 =?utf-8?B?eitxNGFnTWZ6ZGtHUjVNVHBIelkxdFN6RkNGY2lsS1J2WVFhOU85N2NIZmcy?=
 =?utf-8?B?Y0hMNXBQYjNNcnBEdEdzTkNiNXRCWTNKV0pJbU45SVVma20vdXppaTQ5RktU?=
 =?utf-8?B?SytqdlpPUm9UQlk1VHo0cy92M0Z0TmxpbTVsbDliWnpncVlYb0hVZS9WM2Nk?=
 =?utf-8?B?Unl5OTh4WjdPbWQzdFpPc3NIM2tEYVF2VHdqNm5ycGt5TmUzRkhXcU5ZNmps?=
 =?utf-8?B?YjI5VFJCVjBCeGdLQ0o4bkFZUm9adURwOUdoK3pWRlhhbjM3ZFgvOWJVMTZY?=
 =?utf-8?B?UEhnd3ZNWlhRdkErSHRKd21LWU1tLys1TjRZcjZOWDVxcHZuZXUraGVRVmMv?=
 =?utf-8?B?VkZqZmYxRWxoN2poSFBjSzM5anlacitRVTFtN2N6TWg1dlA3M1dUcWJKVXFB?=
 =?utf-8?B?Z1BsZG9BSkd5K2F6Q3pkOW5YN25Xckh4UVd1QnVrb2NBVXZTd3dVMWFFbWs2?=
 =?utf-8?B?cE1neVY5VUdldjlZYVhyRnplNDgvYlR5ZUxadk96TWF3OUlxSFovbGpraEg3?=
 =?utf-8?B?VDhVTDRaWnp2c1Bab2U2UnlUZFF3N1pHWXkwc3VWK0duYW82RGhMZzNBRS8y?=
 =?utf-8?B?UnhIbVhuaUluV2Vwb29FZHNZR2JFUUZqWG1qY3U5bUkrcEYwSklTRG9SRUw3?=
 =?utf-8?B?U0o2dkNFM3E2WXFJY0Y3bmh0RWRYcVY3VGNGVm1ZcmNHaFJsMTVDMmNvNlg2?=
 =?utf-8?B?SkZMUy9ZQWJOZnFXSjNHN0lEbml3dUNvNmY5VGl6SVZpMGNVcGlkWUJoczhW?=
 =?utf-8?B?dFFqMUJFS1dwZXlxUmlRUGx1WTFnMkpJK2FRR1BXRlVsOXFVZzdhaWJPRmdl?=
 =?utf-8?B?bWg1OXdMRk9od2xiMnJHZ0FxUDdhRlpDcitDYmw0ZUlISVFFbWhaRWFtakRl?=
 =?utf-8?B?VGZkMEVnTC9QSEQ3bFpsc0tkdGdEa0oyeEhEa3NZaGpTQ3h4OE1MaHR0aitk?=
 =?utf-8?B?SldsTUtwaEVoMnIrNUQzNHRMSzk3dk94K1cvNGNlbTdsSXlDUHpTOUVWMVNT?=
 =?utf-8?B?cEhxNEhQTDJmSlkzb0JUVGpVNzFKd1NROTg2Uy9XTnBFNTR3bzlYRHVQZEcr?=
 =?utf-8?B?bVZVYW1SbnRUaW41Tmx6OFJIRDI5OVhJaWc2VjlkdHZPTG9uTmxhQlYweDVh?=
 =?utf-8?B?WU9ZU3JkaVNCc3JXOHdrNFhRNEJrdHhLeU5DelNBOWZsNEZVL3VNZllDMDZQ?=
 =?utf-8?B?MWRHOGZjV29vL1pUNWhta042ZGNIVjJINXVXVEFLNGYxak9CNkRxWVFjRnNo?=
 =?utf-8?B?dzZva1VVOEVGazB3YUcvR042alRtR0NYVVkvMFhnelZCYVFFSTJJRXdiOG01?=
 =?utf-8?B?NlBrSWxrMHJRWStkWDRzUGc5NXRqOTBiMnNCRWw5MWZmc0txemEwSTBoOE54?=
 =?utf-8?B?UGFFUy9oR0k5ZG9nbDJJTXVxc3ZpdlMxU0p5ZHJFcDc1Z2E5eVVQWElCMHdr?=
 =?utf-8?B?ZERkVHFxVWpBMXlLbzRveU1mLzVCb3cwdG9PeFk0RjR5aTRzUlhxWkhoTExo?=
 =?utf-8?B?Ui9mSFJsWDdZSDN3bDRSV01VWGVCSmx6SEdYTUFRUCtlZEhETXMrb0xUWkYv?=
 =?utf-8?B?S2lDajdCbG9YRDVCeGhmZGF0OGYwMlQ2MHpZdmh4KzZlM0VEOHlWYSt2NGxz?=
 =?utf-8?B?ODk0bkkveGcvU1J5WXpsL0pMc0xIbWZ3OEF4TTZ0UVE4MldEN1EyTTQ1c0pP?=
 =?utf-8?B?dmJ5OUFtTXNsRUR2MkJIM2ZWVURpellPRDlGWFBrbXVXRU5INTU4Z1VTeklI?=
 =?utf-8?B?TzdUcXBQM3dpazFuMEtiTUVSU1UwWHYzVk4vb2kxQVpUa09yRThxRGNsdXYr?=
 =?utf-8?Q?Sv1iKrUbH+oBh6CMiNLJuC9dIW8Z443Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1YycXhRNnAzU1VQMjhPWTZDUDUyOUhJQnlBUVdRZ0dkc2xTV08wRElXbGdH?=
 =?utf-8?B?UktyT2R6RmJYUnptTWFqN0R2TVYxTnhMS3pSejJic05GZFNsaG00TG9hMDcz?=
 =?utf-8?B?M3dEb3JTanlKdGhLWlRuZjVJTXAxcENXUTVxNE9iQkNma3lQWm1SelVKOFJy?=
 =?utf-8?B?SjhPbXZGdmx4Zk5BOXd3cDFUQnJ4ZFJUSEFjSjNKUFJvQWJBR1pUM29nWXkw?=
 =?utf-8?B?SXdxT243TDNyNG44NmlycUFIcVV0WEpVNEhnNXN6L0dEQTVMSU5ZUE1UTGJz?=
 =?utf-8?B?K3BvY0NQUktaaklXcEV1d29TM0dFa3dTcG44djhLNHR0S2JUVWRSeXJTMWhl?=
 =?utf-8?B?VUpqYkVwT2dRaUFWUlByS2RBR1pndmhFMnJJMTVub241MGE5enlXQlVZTGl1?=
 =?utf-8?B?ZmkzUVhOZEJESStVZmloeVFJZHBsU0QzcXdBbjJ5dXoybU1TbStwQVNRVFU3?=
 =?utf-8?B?NzFub1hTcFpCVE1xT3FFTkpkS1V1QXBrNER6Mmd0Vk5BdkRVeTVTMkk5bGVQ?=
 =?utf-8?B?QjhSWHhsLytWT05jaHBoSzd1UFJYaTVzamJKOHV3TDYxUlNILzdZSlZkemxG?=
 =?utf-8?B?aS9UakJnQ3hhbHpGanZDNFplcHF5NkJaUDRHUXFaNEQveitxYzk1a0ZnNzlN?=
 =?utf-8?B?Qm9QcDMzVWtyNlRES0VjNUNCYXFseitVWk1KbnVEcnIzWlFPWUo1TGxrWVBq?=
 =?utf-8?B?eGxvY1QyaTRWL1lMWHg3MnRHVjIvQjRUZkw3dEFzQmJwVlViOXlPWnRZL0hV?=
 =?utf-8?B?VkZINnZOWEZZK0lRcHFIaTJxQVlYTkZqZytGUHRoa2FseTh3cmJoQ1pWOG9z?=
 =?utf-8?B?WGRtTkhjQU1sMVJ5R0JrdFFwelBnRWs1QmdBdTVCL3JrT1FsR1poa2ZlYjAv?=
 =?utf-8?B?ZktlYktOa2xITVdxY3RpTEZ1SHNhYUNzWUVBVXYyN0dhUkxtYmV4TnlxNGJ3?=
 =?utf-8?B?WFkzaTZ0MTB1SGNxUFVDSFFwUWwwMFRFeEVsWDNXK1M0NHJFNGs2clJvRWxk?=
 =?utf-8?B?RmR2K0JPZzliZTV5S3AyOUNzblNqWDJGUTZrMzZsRm9yNURZbEpSWjl0QWU5?=
 =?utf-8?B?ZzI4UUdCN2YzOSs3UVdGeTNwV1hSbUlzaExKT05ycGdsOXBwVVhDM05tdjBl?=
 =?utf-8?B?QTZFUzI1YVVZSWdncUx0SExPWkhjQ1gzTWUrTVcyRjRPV3l5Nm5TV2JleG9W?=
 =?utf-8?B?bkk0cndtUWM3R1V3L1BVQmk2VWVKNWovRWVyQ25UVlpDMm1POHNxajVTTnkw?=
 =?utf-8?B?dTd2aGJpaXdSMGs2NmNQRjV6bDRKU3FaOXB5bjl4U2U1OTFuUm5wb3BQK3BU?=
 =?utf-8?B?ZW9wWDQ0bE9Xdm13VFpxeXZ3bjdNT1daWjVEdmF5dm10MDdBcW1Zd3dTMkJ0?=
 =?utf-8?B?bC8zQjNQdWQ4U2l4STY4bkQyNTVySnNUZkgvbmF4UnJqYXpyUWtwNXdmN3lE?=
 =?utf-8?B?OWRraElRSnlTQk8vTFlsd2VLdGYxZWpwNXdJLzFYaVRodC94RFZENk1qelp6?=
 =?utf-8?B?SGpDemFOcDRwVTJldUVmL3AreG1jeEE5TDFGZ0NOS2FxaUkzclBmQXRFMmxq?=
 =?utf-8?B?eWZuZi9TRGhvaGNocmF4R1F2NTNsdEV6c2pVc0ZTU0RFOTVBMkF2aWVJcy9k?=
 =?utf-8?B?UzJmYmdPakk1YjYxM011TU9RUnhTbDhvNzJuczJ2bWlkSW9MTnhhVDNSVHlE?=
 =?utf-8?B?dmxWNFJETmE0c0VDbDA0WGh6Tmd5dWNvQjZYVVM5UGUrSjFOSUljOWJla1ph?=
 =?utf-8?B?WEg5UitKK1NvV0VRRkliM3FtRVJmZzlTUFFRZzFiOVhFY01uTDVpbWxpbTFu?=
 =?utf-8?B?ZndkMDhLdlhWR0h2TW1xNVkweHg5SElyTlExc29RZ1ZDbm1DUGo0cDNnVnZV?=
 =?utf-8?B?ZzhqQjFOWEZiVkpIRGluSWhYbHdSc3MwN0VrQ0lFM3NsbWhiWnhIS2M3cThh?=
 =?utf-8?B?UUErcDRYNllUMVhRMGR4VXlZalhYaTUxaHY2eEExam5UTGdTK1o0TXVreHd2?=
 =?utf-8?B?U3p6aGo1SVlkNmYyd3FqZDhoZ1BGK2I0OW1iR3g1eUlYaFpvN0lDZ0N6RHpt?=
 =?utf-8?B?bDZwZTZwR3RRTmo1VWtZMldycmRiVjJLZDRBazVYTXBGeXBFNjBpRlhsVE4z?=
 =?utf-8?Q?E4PSdK6rqokuvZgb1XIgxw8I8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4902e384-748f-4249-3e1b-08de17c76f2f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 15:17:27.5006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Y88vekTivd9Rr49ZPX21wuQrnF6Vc1ZkfRfOcj9zcdnihxsea5a2yzm+Ev+AAEJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735
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



On 10/30/2025 8:11 PM, Xiang Liu wrote:
> ../ras/rascore/ras_cper.c: In function ‘cper_generate_fatal_record.isra’:
> ../ras/rascore/ras_cper.c:75:36: error: ‘%llX’ directive output may be truncated writing between 1 and 14 bytes into a region of size between 0 and 7 [-Werror=format-truncation=]
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |                                    ^~~~
> ../ras/rascore/ras_cper.c:75:32: note: directive argument in the range [0, 72057594037927935]
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |                                ^~~~~~~~~
> ../ras/rascore/ras_cper.c:75:9: note: ‘snprintf’ output between 4 and 27 bytes into a destination of size 9
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     76 |                     RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
>        |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../ras/rascore/ras_cper.c: In function ‘cper_generate_runtime_record.isra’:
> ../ras/rascore/ras_cper.c:75:36: error: ‘%llX’ directive output may be truncated writing between 1 and 14 bytes into a region of size between 0 and 7 [-Werror=format-truncation=]
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |                                    ^~~~
> ../ras/rascore/ras_cper.c:75:32: note: directive argument in the range [0, 72057594037927935]
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |                                ^~~~~~~~~
> ../ras/rascore/ras_cper.c:75:9: note: ‘snprintf’ output between 4 and 27 bytes into a destination of size 9
>     75 |         snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     76 |                     RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
>        |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/ras/rascore/ras_cper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> index 2343991adccf..54503d0d4d36 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_cper.c
> @@ -54,7 +54,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
>   				enum ras_cper_severity sev, struct ras_log_info *trace)
>   {
>   	struct device_system_info dev_info = {0};
> -	char record_id[16];
> +	char record_id[32];
>   
>   	hdr->signature[0]		= 'C';
>   	hdr->signature[1]		= 'P';
> @@ -72,7 +72,7 @@ static void fill_section_hdr(struct ras_core_context *ras_core,
>   
>   	cper_get_timestamp(ras_core, &hdr->timestamp, trace->timestamp);
>   
> -	snprintf(record_id, 9, "%d:%llX", dev_info.socket_id,
> +	snprintf(record_id, sizeof(record_id), "%d:%llX", dev_info.socket_id,
>   		    RAS_LOG_SEQNO_TO_BATCH_IDX(trace->seqno));
>   	memcpy(hdr->record_id, record_id, 8);
>   

