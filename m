Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66140D2F000
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 12:37:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F417C10E081;
	Tue, 27 Jan 2026 12:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j3Xq/N3E";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE7A10E081
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 12:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6g5eOMuFVo8LhhAYTU7iAW4SduKYlF0/HyTTHOfgra3iF/sEVM0smhFt7A2ibGTQroOoNd2oG+I2EqAscvWC7u10y9ovA5sXI04KR2zWcKJvcBvUNvJXN4XnahmgdzyLLIs3BIz3ZL2hIB27jsfghP17JUgzTKsLaFkb3ji+fGm6ywIapQhk0DxFfU1T1BRjG0ofp5qrco6YNKlzivevT8iRtU/jk8e/jEVq1IgZWKfzMR5jJB4UUN6iPhU8ccDXhGo4BFWEiVboaQhejjTIBIxJKi2HY6MbB8VN1nh5wiEZNPz+xHEzzlFgdYezhPWEcFiUPhTB8r1pnSZLJMv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnXkHQxlmTpXAQDlUHI80CRf1CQCYEgPgeCocs+OIoQ=;
 b=PHwhwon+gsyqFZVB7bQ+rFxhFRZe7JMcyTOCgZ2E6pd1Cbij5H/kWfBpnybraBKO3XrEaRDiPODC4TVa/1MT8VJprmwURKnQiGtqcsithSe7udguIaleOcq1HoBi+sqrr/D8/XVysaGqu9kYNFvMQaeB+vpJymkwiQ+Bisgl8MWzZ1dMhd4XDRcS72U4B+lTs1p9eq/50Mm+LKbL2uh/FS0MKS56LhsUtAwoAEfqkV6POewoVzNhlEHrKNoRux2iuZrv0FFu/Nxc+GAFDgPePnIm0FDjkQQ+jWoZu99o62mbtb4CeA4Js/8/1nlepCYkfm779Ws+7MQpUSZPD+KI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnXkHQxlmTpXAQDlUHI80CRf1CQCYEgPgeCocs+OIoQ=;
 b=j3Xq/N3Ega9/zEbKYF82HVSOUFjXpO9/kjy6ei6jEQ71mQUwHPpSkbRHuEEQ1TNU8ByT3KIzCqnoYShdJhI64/k/6UkN4H0NyHrGDCB24U7pHTUvMMtwin23qYgWjcUAybPeKFWPOJLa35wcvN9iEgpEo9kohdC1WAl6eWSlebQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by MN6PR12MB8568.namprd12.prod.outlook.com (2603:10b6:208:471::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 12:36:57 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 12:36:57 +0000
Message-ID: <399a47eb-0b85-4c8c-a747-fff92fc3e7e9@amd.com>
Date: Tue, 27 Jan 2026 18:06:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] drm/amdgpu: Add interface to set debug trap flag
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-12-lijo.lazar@amd.com>
 <CADnq5_MQUq4sQXDc3Kv5RJDzP+ya82-+xEPnAsys9KAP0=Mb=A@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_MQUq4sQXDc3Kv5RJDzP+ya82-+xEPnAsys9KAP0=Mb=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|MN6PR12MB8568:EE_
X-MS-Office365-Filtering-Correlation-Id: a7186640-3541-48ee-7202-08de5da0c26d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUJGOHo0bG1uMy8xQVg2SmVCTmhKWXhScUd5L1gxeU1rRDJxK25QbHFPd1R2?=
 =?utf-8?B?VkxuZjVkZ2d5aHJ0Z1g4RDMrc1B4U1hjeHc3djM2Q05yclNmd2lacnFIWmQ1?=
 =?utf-8?B?cUlsS3ZsMHNkRDRBUXhtWlYxejRaS2RTZ3VFR3F4aHBITW12cWQwYlZTWjdK?=
 =?utf-8?B?dld0UjlaNDFTbGFEQk1Id0l6dnY4MkdCY25oSkVLUVlMRVJZTXRReDVSSzdq?=
 =?utf-8?B?MXJIblFyRktKMlRYN3VzS3BGdmFKcjFEMk9sYXRrR09tSFpFQUcweWJ0Wmgr?=
 =?utf-8?B?SUJibExpdGJIR1hwc2k2OTNJSE5xc3VDamd0WG5jNVlzWEErU3JNRm9tWW43?=
 =?utf-8?B?WTU3S0JDU2dqOGZORWVuRW42eU9weUhFa1c5T0xBWlFWbXlvekh4MHhTRmcx?=
 =?utf-8?B?VHdlU1FDcEtmNGc0ckpVamkvdllQVndHQkRIRzJ2U1pOYm55eWZrRFhWQ1Nx?=
 =?utf-8?B?eTQ2MjVRZHQ1TUl2ejcwdFY5djc5V3Y3SThNa0VTWm54U1dMSTczSERibXdU?=
 =?utf-8?B?bmJWRmdPdUVhWnZjRVNOb3FDdW16cndOV3lLR1pBOWU3dWY2WmZGYmYzb0lG?=
 =?utf-8?B?S2hQd0ZTUHVmZnRxSFF4YUtqa0FxeDVmbDdDUVl5UldlakpiYjYzbEYwUWhn?=
 =?utf-8?B?U3puZUwwNDlwSzh0T3F5UjFoVUtCUXN6Q09rblUxTjBKemdFTkdHS0g5bWdB?=
 =?utf-8?B?b2FhU1FZOHRUQU44Z0JUZ0FBTDlvamdrRHRQbUptd0lIRHdOblZCSXVXMC9E?=
 =?utf-8?B?SlR0L2s3aXBnTDBKb002S2Z4cW44TkdjOFk4V2kra2hMQVY1bitybXBmOVRD?=
 =?utf-8?B?dXp0TGx3ZVhHdnJxMHoxTWoyN2I1YWdIYWRZeElBSi9NMllXWWVUbk5lTlpJ?=
 =?utf-8?B?WTY5NDBtc1VOVkU0M3pJYURXZDRQSS9aYlUzZG1FRjdPR1NsLzMzUmU0bUhK?=
 =?utf-8?B?Z0N1OUhVeUpKTUZDN1E1MkdpbHNBL1A2dnlINWJBdU80dG5sclB5NnR2V296?=
 =?utf-8?B?YkZJaFVSaTd5OGh0ZFRBd3drMlF5Um01ZDduVkxWQy94U3hyOE53TFJJRkRV?=
 =?utf-8?B?d01vWmJwU21USWdMeUhGeHcyU0xiWUt2TlBWaXdiU1N1VXlGR1BvOGpKbnBO?=
 =?utf-8?B?c0xHY0gyNU5wV05TRk1xSTJ0RUdNTjRQeGRkWGIzOXdxZGJDVFAvTVhhV3lD?=
 =?utf-8?B?UkE4d0IwU1NxSGx3NnZ5Si9mN2ZGNTRrYUFpYW5yQVFWSnFYSUhGTjM1blBx?=
 =?utf-8?B?amFUZFdVSG9TTWxlSW5DREF0WGUrMmhPUUJ4c3dvV0hoV1lXQnBhVjBwUDIx?=
 =?utf-8?B?YnV4VjJ6MjdjNklyTG0xS3puUXZpOXlLcXUvTmFlUUhBRWRZRHA0VGtBZ25n?=
 =?utf-8?B?MDhUUHJsMnpxc1RoUWFZelRXMVNaSU1jbXRLWUp1MVExYitOT3c3NTR5VjVz?=
 =?utf-8?B?SDhha2NGNUs0TWVEaThDQXJEYmJCeWVvdkFkZzZiRjY3TzNmWEo1R1hBUnYr?=
 =?utf-8?B?RlhlOVBGbzdGKytzNjliT0FtL0J6cmthSDJqNVNUME1sSjB1OWZabFRDVjM0?=
 =?utf-8?B?djZaMVVDL1Ezd2tTUEJLVE81aTBGNHROOERvNnRzcU1QaExCaExQRHNrSVk4?=
 =?utf-8?B?dk5DaVc1SDMwNGdTcWhCK1AwdkcvZ090QXVEazIxZy9veVdaTE5YVUxRTmZ6?=
 =?utf-8?B?OEZvTFNLM1VNN3EvczVaTURCYUl6MUJwckpFMjBQLzZFZkd1c0dYZWpPaThw?=
 =?utf-8?B?NWIxNzBaVTQ0VGpBblgyMUh4dHZ6V250TzlzK3ZFTkQ1U1pJM2pTMTI5N3h6?=
 =?utf-8?B?TW5lS1YvdlVBMjlHVU5Od3NXbVo0UERRNTE1YXpSK1JoLzlzNHFjVmlGSEgw?=
 =?utf-8?B?K1Z2dXBUVk9YNmtCbFdoTjBKTHJ1U1YwTko5ZDRTR0dnd0R2Zm4rbnczbGdU?=
 =?utf-8?B?T2pqbERDRjBpeDlWNHh3M3AvWnIzVStaOWREU0lyQXJjWWxQcWpxRDl2WktO?=
 =?utf-8?B?ZDU1RjlrL3lEOWtMdU01Q1d6T2xzVStXbi9iSmF1Sm1sUGJvUjdmemZTUXIz?=
 =?utf-8?B?eUl3RUhPdk1EUmprOWVnUTh2cng0aEFQWU9ONEFFcFZEYWdTWFYwNWVtVWRk?=
 =?utf-8?Q?/Uw5an/pZHWj9ZZzkWz9IjOxL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akp2dE9NTDlKVkk1WmkwR0hJTHZTUHQvZlR3TCtLUHNyMUUrSzhRQ1dCa0ZJ?=
 =?utf-8?B?MFl1MFp2YmJEK2FKUStwajRDSmhsRVRvekpxZlUyaWtIcWFBMFl4WjRaTE5S?=
 =?utf-8?B?UjY3TktSMVBwcGdZV295aGpMOGZ6YmVsZEdQYTRESVpwSzlTU0s0c2Q4L3Jh?=
 =?utf-8?B?VUx3UDgzKzFoSVU5bFVKUUt4aXRxZzJjZWNjZ1NnV2NFS3VrSFZ1bFVGWVRJ?=
 =?utf-8?B?QS94bnFlM2R6Ynozb1pDOTBzN3d5eENOek1nSlJZKzh2eHM0dk1SMUpoQ1dw?=
 =?utf-8?B?cnVpYlJrQnhTc1k5RkJPQUlVdURjUGdJRkFwZW5NdjRGWkEzNzJRcjBQbmZo?=
 =?utf-8?B?Vlp4bWd3cCtBMlg0dW5ycW1UTnNtbkhqVHpPZjF4c2NiZ0d2Vml2Sy9oVDBU?=
 =?utf-8?B?RkFENVdYM0d6cGNzOXRBcXNBY3RPQTdCc2pRWGw4enAwSFpYSHBYa0pyODVi?=
 =?utf-8?B?NEQzbkUrcmM4YlhSWUZOQ3hiN2RMUTQxbjg4WU1jSnR2UStRelVhcndTNnc1?=
 =?utf-8?B?OGJMTmVYeFlTQjRXZnRHcE4vYVQ3ekNUQjZNc20vaDhKM01EZXA0YU43aGpB?=
 =?utf-8?B?SExNOXFGRGZPN0xscC94S2o2ckdGMmVDUjVvV3RrVXgzQ0JwWXV4ZEw1Y2FJ?=
 =?utf-8?B?ZDF5VUFjMDhJL0FVSjVJejc1N1h1bHBJVXF1b2FzV2xrRHU4dWlOM3F4Z2Vj?=
 =?utf-8?B?UkExc1QyWUtiTGVqQ2dDaFM0cVlzbXVJdFJDWEhiZWFyUURkRGQvNWVUdTA1?=
 =?utf-8?B?dDBTZWJIR2ZiNS9oeGk3LzJyOUxPSno5S3ZxVHgwNjlhS3RuMFJRbDJhV3ds?=
 =?utf-8?B?OG1NSDZ3Q1MzdVBSTFhaTVozd2VXaUh5VjNuWlpxWjIzU2dYODZ3NzNNdWJW?=
 =?utf-8?B?cmVTQUR0VlZHTGZqQW0yL281bFE2TE84T3NMTGhvdVRBazh0cTBEelVtMmla?=
 =?utf-8?B?K2d4Z29KcTdmZmVFK0dFaTBVaDVuUU1OKzhIN3ZxaVlEb2JyK3BQclg4dWV4?=
 =?utf-8?B?N1YzZWhDeE5wVDNxb0lveDMxT3M0NkxQbUdNRDBibFpBQ0RudExSckNjRG9z?=
 =?utf-8?B?Z2ZFUEI0eGdsczhzdmxJQXdEYXY4c0ZLSzlBZWd5dFNSSmp2cWNqbmhVeDBX?=
 =?utf-8?B?dWU5QjFPVFJNaEljN1BSbVZrS1RNaXFMN2dvdkFmTFpubzQ4UklsUk1qWnIv?=
 =?utf-8?B?TGRKZ2E4TUpDRTU5N2ZVeUxTZHAxWHRKOEk1R1Rxc3F2VGtwYWdaZzlpVDB0?=
 =?utf-8?B?ZkdRNnI4c2s2UXRGTGtROFJBYkdjS0ZxWWIrMW1seFdCUzNnYSs3VHZVc3NQ?=
 =?utf-8?B?MlhwSmdWUDE2YitMWkY0emJJdStxUXZJM1dyMWgxbUFHdGt3WjNsSjRCYjZv?=
 =?utf-8?B?bGdGU3dTelIzMEdKVmZlSUtPakNIdE9XR2VsK1NQaGxqbDEyTHZvQWhPeGhw?=
 =?utf-8?B?UkFYN2VqUDJFcWNvNW5xVDIyNlV6dE43QnZ0V0pxb1dQVGhNbytUL0xZWnJm?=
 =?utf-8?B?d3Y0emVkYkl3S3lhTVdGd0tEWXJtbGIyaFdZN2Q2M2Q0VFhNVWFhQ1I5UFNV?=
 =?utf-8?B?UFAxcHpBcUhvTFBzWGVhOG1RdkM3eEEyaFFZeFNia3J3akd1L0E4c2t4RzZ5?=
 =?utf-8?B?eVY5TWROUjh0KzVnYTFPbDFsWWxHLzNmcDZPOVNqYzIzdjFsQndnd3Q1bnlN?=
 =?utf-8?B?ZG51UXV2NlR2WWFXVm10M1Nqd2dta2hubmM3OUFVT3BraGRqSWVqa1oxOU41?=
 =?utf-8?B?SkxSYVROejFJRmIrZzBWZndySGhSVEdjdXA3cDZMMHNtUk9IZURnalp4T1hC?=
 =?utf-8?B?M1k1RWhSbkpFSzNmWkFWMElXL0hWeFBJWllMVWFiWENQYXV3MnAxTTdmRmt6?=
 =?utf-8?B?V1B4RVBzT1h4aHRrdHZ2dlAwQ3ozKzQycmVaZ1BhRThsSnU1ZFdtRWtwZHYz?=
 =?utf-8?B?ZUJ4OUZpTGMwbFpoQllSSHRzSUNUQ0V5SWVpMzNwZCtNemNNZ2lrNWhkY1k0?=
 =?utf-8?B?QlM1WDluc3doM1Z2QnZKVlNSM0tVcHlQWmhzOXZ1ZWNYemZDRzVuVXFTWjB2?=
 =?utf-8?B?ai9ZU0Y5WkVzMjIvNFVSdDdiL2VXYzdpUDdOMnlUY083SWdxaDNMQjlRdjE3?=
 =?utf-8?B?ZXVJWitPOS9XRFBvRllpNEx6bXJuTTVsaGVGNitSdlppekcvOGRzOWtkSGFV?=
 =?utf-8?B?SHMyazZGVHlEOXNqRll3cHVISCtZby90akRtdzUxRUw0Z0lhQVp3N2FSK011?=
 =?utf-8?B?UmNHZDgrNThFbHA5K204MGZtOS8xU2lNdS9PUDlKeXpVeGE3aDVWYUh3Nnpj?=
 =?utf-8?B?TXozTWhTa1h6SEIwdDcvTSs5NVo1ZW1FWEwyM09YWU9wVEUxMDRUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7186640-3541-48ee-7202-08de5da0c26d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:36:57.3079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LmBfh0sStfcsMdO0OFGxEmAT1j2C0oTGNN0RwbOerZa+/Y4Pb9LVDIbkjruwjWqT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8568
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



On 24-Jan-26 2:23 AM, Alex Deucher wrote:
> On Thu, Jan 22, 2026 at 5:42 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> Add interface to set debugger trap flag in TMA region.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c | 19 ++++++++++++++++++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h |  3 +++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> index 70f444afece0..663b91c8e6f3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.c
>> @@ -19,7 +19,6 @@
>>    * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>> -
> 
> Spurious change.
> 
>>   #include <drm/drm_exec.h>
>>
>>   #include "amdgpu.h"
>> @@ -614,4 +613,22 @@ int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>          }
>>
>>          return r;
>> +}
>> +
>> +int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
>> +                                   struct amdgpu_cwsr_trap_obj *cwsr_obj,
>> +                                   bool enabled)
>> +{
>> +       uint64_t *l1tma;
>> +
>> +       if (!amdgpu_cwsr_is_enabled(adev))
>> +               return -EOPNOTSUPP;
>> +
>> +       if (!cwsr_obj)
>> +               return -EINVAL;
>> +
>> +       l1tma = (uint64_t *)(cwsr_obj->tma_cpu_addr);
>> +       l1tma[2] = enabled;
>> +
>> +       return 0;
>>   }
>> \ No newline at end of file
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> index c9f61e393fde..a32044b07b45 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>> @@ -93,5 +93,8 @@ static inline bool amdgpu_cwsr_has_dbg_wa(struct amdgpu_device *adev)
>>
>>   int amdgpu_cwsr_ioctl(struct drm_device *dev, void *data,
>>                        struct drm_file *filp);
>> +int amdgpu_cwsr_set_trap_debug_flag(struct amdgpu_device *adev,
>> +                                   struct amdgpu_cwsr_trap_obj *cwsr_obj,
>> +                                   bool enabled);
>>
> 
> Nothing uses this yet?
> 

This is added to account for this - kfd_process_set_trap_debug_flag ()

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdkfd/kfd_process.c#L1505

Usage with the new design needs to be finalized.

Thanks,
Lijo


> Alex
> 
>>   #endif
>> --
>> 2.49.0
>>

