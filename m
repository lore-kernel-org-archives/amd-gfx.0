Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F62EB28D6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 08:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF45810E3B9;
	Fri,  6 Feb 2026 08:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FAphEuwD";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2B210E06C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 08:17:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOg/WPq6uJTQiwaM3WRnrujSEqbgVfe0UHF31JhEvhEX4f44W5dYC6UbiNXG1bOP9GS9YpjGb/gUwIjnJTSNcYR4fVXl5haQdXble65mX0ULQ+Tei2Yw5mW6SRmhUfbmkgPcFtXunZ+YVWLjZ+CEOoMLZhJUR8o5cH96i71mF2kYzwBtmQPAZTdp70i96qGSXlbqaMhcfgiEGLJe549F+U/EbmKxEsb2GSqRsW7FVQTUtLFDG9KWIctSSNYcr/MZSwHMyRH40s9J992GuhhUICc/j5IKGUyJ7Y738V6LypmjHbt3x8OnCHMZuIvdYMyt5DE9jbFGd9FOCz9aCmA7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utH4+e75ZpTsbqj3G9z7Ys9IQzmaprNv+LPwiZzYI98=;
 b=YRlpbOor8CpRB2HkJaDp+VFZ4iWlaf6y0wcsOgkuXIY5ck7whJ1P1lXCc5m3Beoz4ySwpqrNfpglyyk8J7HmVFdAO5giDvJ0au2mcW81IEXQ6yNtxgMAiBI4ge6NKFFVA2VHig9yy5ItFlG1fin3lRJdbyD9MG4mZy8t+Rm/rvIQjskrtmsDEFeibkB5ebNrwDH2zyfjmJyZfNStIZCHRsre3LX1CYc1lRSzq2FnemzHr9ORdY2mIlAi3fMK8oySShNMyjUp9eQNP+ewDLGPUIsJ+uPKxxGoZfUgPtNk32Jy4is8+FWu3xgea/2e4lEbjAipNZUSozRxMTkcio6uvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utH4+e75ZpTsbqj3G9z7Ys9IQzmaprNv+LPwiZzYI98=;
 b=FAphEuwDOTHjxV8qDDsDH0UjnYgU9es+I74W85bmBg3mFnWrxOgIrWerzRcdC0QlbcKP5MYupurdjFfWm2HFU/TJBOHa1aKDDtnpHx8/kKWxXfQ1spvT/8ouDVR0ztos6I3sq32jx6FglHn+jHOfiljvHbCsfcV+j0ZIQo/wxOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 08:17:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 08:17:33 +0000
Message-ID: <a0bf4396-b13a-4cf5-bfd8-6edd963ef317@amd.com>
Date: Fri, 6 Feb 2026 13:47:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Add acc counter & fw timestamp to xcp metrics
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 alexander.deucher@amd.com, kevinyang.wang@amd.com
References: <20260206081227.4133648-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260206081227.4133648-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a811d4-b54d-40fc-2ebb-08de65582d69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzJCRlQvNS94S1cwNWxOdFJ5YTVVeERWRkhaTjBMNjFtRGszYkxWc1VzZHZC?=
 =?utf-8?B?aEtkK1J1bU5RL0N3SEtUUVFzTkFaTTBMSmdsTlFjdldVa0tpbDdCVHBrYncw?=
 =?utf-8?B?bStkNk51QlFIcDkydHhUOFhtZitma3JSclNKaDhvaGIwQ3F6REptb1FKdjBQ?=
 =?utf-8?B?bjZrVUFNY0hmMlZaTHdXRWtHR2JHeEhqVGthMndIbHJtOTdWY05pd0xWVUFM?=
 =?utf-8?B?cnMxOFgzZUxiUzhGa3liYmE3Y25obVNVOUhWZkE2ZVFMR1Z6TWZvNXJ6UWF0?=
 =?utf-8?B?TXVtTnJvTlREQ3VZek5KOHp0NUZyU3JDUnJvSXFJRys2T2swUi9yNVN4OWcz?=
 =?utf-8?B?QldhYjFzVEN3dGlvZEw4QTIvMnd4eWFKRWVLMHZxbG8vVHpoZU1SaWJKMzdn?=
 =?utf-8?B?Nmp6eGRhZmEvajlnajFVMkw3Y1hLZWRyQUIyRmtaVzJzYU5FbGNLeTluRkRu?=
 =?utf-8?B?UGloTzNJQVRYWjVjOWhUbDZXalFzT2lqYXhEYW1tNWZ0MXA0ZFpqSXJXWk9v?=
 =?utf-8?B?bFJBWjBwdTBjNk41ZzNzWER4S0dZSHlxbHFKd21JNE5DdU9kaUJ1a2NXS000?=
 =?utf-8?B?RS95L28yWlNHN2tRbVV2UnBHK2xwdVRhUnUralo0TW4rY3g1Wi9ONXlsOHNZ?=
 =?utf-8?B?NXJLckNVVHo4WExPWVVlSGk2SE5yOFIwNkNldkI1azcvZlRDL0hkN0VraEJt?=
 =?utf-8?B?cFN0WWFDd3RjZ0NBUFVqWmRseDB3dXZ2NWF0ZmE4b2Mydy9CYUtRUFMxTTlY?=
 =?utf-8?B?YVpvdEowY0xpLzIvQUtRaXJ2empkNEV2cnZPZ3FqZGJUdGdSMXYrbnhvbVlR?=
 =?utf-8?B?a1pSUFdlT09aNkZjNVhvODZiUk1jYktvNmRNR2VvbTM3cXpsRDVpQjhkc0gw?=
 =?utf-8?B?WjRSb3ZGbytXWFZZYVZTNjZOSHdaY0k3QUdNek5QMmJRc2VxVll3blUySWth?=
 =?utf-8?B?U1N4UHErQkVEcmN3emdjMzVXdnpSbFEzNzh4dFIrQ3FkcitXNFprRkl3d2Zp?=
 =?utf-8?B?NkNKVFhmU0ZJcDBNZ3F1QWx2SW5TNUVnSnpTSm9Xa1YxSnBVbHlXZnNBRDJY?=
 =?utf-8?B?U0U4RW5HU21IYWxTSmc4b3ltMGJWZnNCV3dXaTVPMFhjakgrRVlXRjhCWEZZ?=
 =?utf-8?B?aEtnUXJmVmszK0NxYUUzdzhkK3U4d2RBZGpwRlVWZnVZMzc3NnJQRXFXeHN1?=
 =?utf-8?B?S09qREhxMmZrc1dDMUtnQ1Q3OTZYcXA5ZTZ3Q2UwS3E3bDdZZWhpOU9kNDcv?=
 =?utf-8?B?ZVhSK2pEa3E5RVZKaGlnMExHYWxlQlU4L3ZCMHNLdnZpcDJPMFFYTWtCSXU5?=
 =?utf-8?B?a0VhZU0vYnNDUS9qc2FkQnNObjlIYTZQalkxYzI4eVBUNmVYQ3BaL2MxQ0dn?=
 =?utf-8?B?U3BvTEZkbTl4b1pvbU9UN1JPZU1xL1J0eERucUNZcldRajBwN205Rm5qYXVW?=
 =?utf-8?B?L2hIRkwrMUpvT3lyd0w4QWJoU1F0OEVRUk5DMEx3VUM5Q3dCTGF6L0RtaHFV?=
 =?utf-8?B?dlFUTTNRYmpRLytqeHVtdW5JS1IxL2ZhVThyQ3IzQzkvckJTTTJlMUpjSjR4?=
 =?utf-8?B?VmNQaVBnZmVpOENKS1FaTFhTQjhla0poZE1ETmRLMjBhTUlyZktyN1RtRWJo?=
 =?utf-8?B?djVPMzl3ck5QMXNZVjJmTHhXa1ZBd2FIVytlQnUwYUJPQXRkbVd4a0prWUZW?=
 =?utf-8?B?OEFCMDVRSGtROExlZ05QNTlxWElJTWRyNG4zRWkrWEpVTjYyeW9zK2syeUwy?=
 =?utf-8?B?SFFOSDUwWHdWNUtnSjh6RGNCUXNTT1NCMGo2eVp3NXdFQVFsZThiRzZkRDJH?=
 =?utf-8?B?YXFDdmJPeTFVbjNVOUN5NUlCRHdBRGlBZENBR0YyNlJ6MEVQMFRqMEppUWFT?=
 =?utf-8?B?OHBBZVE2SVVLdTlxbFNCekd1d2pZcE5Ha01NMTN4ZEo0Y0tuemFqbmRDNDQ5?=
 =?utf-8?B?NVZ1S1k1SlhETFRGcEVTWXNMNzRDcjAyWW9zSkY2Y3Ztdlk0aFY4N3lubExr?=
 =?utf-8?B?dVgvbXI2TEpMVFNqTytFSndudHRsSld2ZXRZUy9SWVZwZm8xTmh6Y1hCTXV4?=
 =?utf-8?B?dXhaSmJiRlJSbEVmNW1xTjdzTjAvM3N3K0VyUTVweUgyM0gwMWJZZVVXT2pw?=
 =?utf-8?Q?e2X0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNoNERFVzcxc3ZFbHFyMGlYclNHWmV2YUw5bm9Tb2ZjenNiQkNWd1FrOGFt?=
 =?utf-8?B?Y2xEb2hEVzVVNEoveDg2Yzc2WnBUYVc2RExNNXZ6K01OMmFhdlp6WXpyRVNj?=
 =?utf-8?B?Mk5NVmgvTDVJOFVRUCtqNXpIT1FjN0FTSzBoQTUrVzUreUVHcGpUckJveXRp?=
 =?utf-8?B?QWVUQ3d2bS9XdHExcTB4V1hxcFl0YXhzb3c5QWtERzlKWGM0WTJPZlB2c0lF?=
 =?utf-8?B?ZmExdzk2OVNudFdOblVKeFVmenZ1SnI4TGpZVmNLVnVmaEtmQ0x1VlR5d000?=
 =?utf-8?B?ckF6TWV3Q2ppZ2VtVURXQ0RtR2YzdWhjSlc1QmRWUU5rWFVCVVoyT25XUGFE?=
 =?utf-8?B?WHRRcHRGdkRQcldqRmxJTVJTSGwrMUR5TnQwM2ZmL1o1R1lmVXNQd1NRYkZh?=
 =?utf-8?B?SVhuTVc3RjVBL2QvOUIzYUw2eXNVdm1zczFkK01tblZNWVJZcTdYUU92Mk1I?=
 =?utf-8?B?MkdVS0pTb25rb2JzY1dBYitBcnA2SlZkdkE4UzhFQzdrbmZwNytMbDdJY1I0?=
 =?utf-8?B?ZWh6L3piSktXb2Y0UXlsMVpYSUJVZS8vS1ViOEpFbmJWNTY4WTR1WUcxZyt4?=
 =?utf-8?B?YUlKMk14WGttVytXcG1zeW9YYzYwMFlJVXovOGNoMDBzZkhFc3ZKcld3dWVv?=
 =?utf-8?B?bGhXOEovTWJQZE9IdlRQSjVkYTNRMnI2MzdpS0owNWdwa25XUGlnMXluV00w?=
 =?utf-8?B?U3NtZ01ua0tuek1NL1ZTZmRNSldjV05mNWNVZ1BxTjhVeDdMYjRGQXUxOFBq?=
 =?utf-8?B?cWxTOGhaNFN3NTRrVVFSelVtMUljMThOSGpxVllwNXRDMDJWdzZCN0JjV3Ns?=
 =?utf-8?B?aklHTndZTnZWRW5qdjIxTnA3b3RhMHQrdlRkMjFHbS9ROXVyYVFuMFNvKzZz?=
 =?utf-8?B?VStOL2dzRmFSVkxhc0JXVDduTE1yV0c3cjA0Q3QwdlZkSHM2SkV0RjNUZE9k?=
 =?utf-8?B?clpyYmNZSkhJMVlwc3RDRW03Qm5saFhSNFJySDFyRUxzbFFnckJJalFFK0Nn?=
 =?utf-8?B?ek9xenRVSzZ6N3lEdDZaL1FEbk1lTDkvU1BMdm9palVGYmhySnlIS0dlVDZT?=
 =?utf-8?B?d3A4OUlwMGNjYWZJVEgxenN1TXI4Q29Wa0tHNm9TWis4UzNGY25xNE9wbEp5?=
 =?utf-8?B?VUtadExzZFZ1L3VpaEdPT2hHWlRJald4VklWYmpycnNPdUtzM2RtdFNCWktU?=
 =?utf-8?B?QzdpYWQ5a2VaYjFBWUxGZ0RyVnR0cWZ5Z3k4amYwRHhIN3Z6UVZmU3hjTjRk?=
 =?utf-8?B?Y0xGa1lzUHpFNGE3Z0MrSmg5THpCWVpqZDFLWi8zMGo3NFRTckN6ZnJFWlZV?=
 =?utf-8?B?UFUrcU0rM3BoalV5c0trdEU0ZytGaTAxYkhrQ2hOYlQ5SmMwTVkzaEZ6VS9L?=
 =?utf-8?B?SlFHNzI2WGo2TlgyQjJMclpIMkhHMlpVRlA4Snd6S1lEQ3BOT251d1NFVThm?=
 =?utf-8?B?MnZtMTNaakJXa25CdTdFTXg3UjZOQUF4NnpvS0ZrWUtJMkYxTGtBbURzMkRk?=
 =?utf-8?B?Tmk3NkpQMnlDSmR6S0NMT0hEQytMVkw4UlI5RG04dDAybS9ocnZKVnYxVnZI?=
 =?utf-8?B?cXJNOERvczlDanFZblM2U1VnZjMzdE5MOUFXSUdJdkVXbjhuZGR5NXRYTUUr?=
 =?utf-8?B?NWkxQk02Rzc2cUVRQjlmV0lWV2hhNnRLWjlRUlBLN0RaWXM2akw0bGRMOVd5?=
 =?utf-8?B?ZnZwMHArczdtZzJzMllqVTVsTllUSUtIUytlSUkvQkp1N1V1NjlLREtyNmhF?=
 =?utf-8?B?eUIyWGtyWHRTQ0ZHWG1ndUN6R1Nwak1EWVd4dDlNMi9uNkZFQWJiNkdsSllr?=
 =?utf-8?B?enNBWDR1UWN5V2xvRzVmZXh4L081K2N1U0xMWnplMC9KNmJvU0JwSU1qKzla?=
 =?utf-8?B?MVRrcWthNFRRRWJpd0VaVlY1M3F1OHdWeGttQUFWODByeVZkOGN5R21pQlZY?=
 =?utf-8?B?VmJZMEVGWFlncWNTdGNHc2RkT0dFU2ZCbzRxUVlNS1M5TmxrSnl2ajkrYm1U?=
 =?utf-8?B?cVpOeEJSUDJtQThSSUZHdWhxQzFrcU83a1ljeVlJQkJxUjFZS2RhR2hXc2pp?=
 =?utf-8?B?NWE5RVNyb2FzMDZjL0cvYTBLeVpBZERCODdOWWIwTmR1NC9oL09lT3Mvd0o5?=
 =?utf-8?B?VllmWStnTk5DTzZlZ3FqTmx4dVBvMVRXTGc0RXA0c2oxQnJubkRkYk5ERkxm?=
 =?utf-8?B?a2FYckNZb0Qzd09aV2s2c0twTFB2Z3psTkMwcm0rYzZyTkFuS3QwYWxFUjk2?=
 =?utf-8?B?alRFemhaYmVYZ0pzRzQ3UCtnbW56WEpZdUNqSkFxR0pLOGtZUlovam9vdGdo?=
 =?utf-8?B?d1EzSDlDbzVucTFXQnpGckEvVGNib0tzazJPMDRYbnZnSi9hNngxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a811d4-b54d-40fc-2ebb-08de65582d69
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 08:17:33.0432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYgJk3WXiFqCjXd1wyXpqDPb/rfeMI2EJR2S43BjVE13dVTu0QaVKgGw1yRxttIG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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



On 06-Feb-26 1:42 PM, Asad Kamal wrote:
> Add accumulation counter and firmware timestamp to partition metrics for
> smu_v13_0_6 & smu_v13_0_12
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  | 6 +++++-
>   3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 3d60d3c1e585..f2a6ecb64c03 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -823,6 +823,9 @@ ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp
>   		idx++;
>   	}
>   
> +	xcp_metrics->accumulation_counter = metrics->AccumulationCounter;
> +	xcp_metrics->firmware_timestamp = metrics->Timestamp;
> +
>   	return sizeof(*xcp_metrics);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 3a9210083ce3..07592e285cf5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2668,6 +2668,8 @@ static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
>   			idx++;
>   		}
>   	}
> +	xcp_metrics->accumulation_counter = GET_METRIC_FIELD(AccumulationCounter, version);
> +	xcp_metrics->firmware_timestamp = GET_METRIC_FIELD(Timestamp, version);
>   
>   	return sizeof(*xcp_metrics);
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> index 0588a5aa952d..cbe41b2191a1 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
> @@ -259,7 +259,11 @@ void smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table,
>   		  SMU_13_0_6_MAX_XCC);                                         \
>   	SMU_ARRAY(SMU_MATTR(GFX_BELOW_HOST_LIMIT_TOTAL_ACC), SMU_MUNIT(NONE),  \
>   		  SMU_MTYPE(U64), gfx_below_host_limit_total_acc,              \
> -		  SMU_13_0_6_MAX_XCC);
> +		  SMU_13_0_6_MAX_XCC);					       \
> +	SMU_SCALAR(SMU_MATTR(ACCUMULATION_COUNTER), SMU_MUNIT(NONE),           \
> +		   SMU_MTYPE(U32), accumulation_counter);                      \

I think this should be U64. Apart from that, that the patch looks good.

Thanks,
Lijo


> +	SMU_SCALAR(SMU_MATTR(FIRMWARE_TIMESTAMP), SMU_MUNIT(TIME_2),           \
> +		   SMU_MTYPE(U64), firmware_timestamp);
>   
>   DECLARE_SMU_METRICS_CLASS(smu_v13_0_6_partition_metrics,
>   			  SMU_13_0_6_PARTITION_METRICS_FIELDS);

