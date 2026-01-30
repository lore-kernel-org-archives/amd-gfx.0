Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AE0D73EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 05:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8551110E8F9;
	Fri, 30 Jan 2026 05:50:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzDABuKP";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730D910E8F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 05:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PX5pFwUMOswmaeBh9XxXVe5nBq8UWq47i0tjz/9ncUkVqLSeENVqcm9EtCeFcYZmis5xMJARZRqne/uTZzWtfKi0Uy0ZASGORISeGsYxU/dAarw/dExbxoHHotULZOoSrl84UykBf/UzfoM6LordRkUcAuN69SH38laGSBmfW7cP6eDCv6nqCCABt+nHIthWlu61awe2jMp5t/FX98t0RxojocqZVUQVdgozoqYUdJ5fuDJOouKa4fIkCMloiXm1tTMELh43KJi2jhkbZzcHT3ED08f2xicHpHn9uEsNmEZQMmAJhqzR78Wxyy/4Irtub1wHoX5Q0CSuLHEBKznfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zo+f/Ld6ML/dF2mhkkln3Em2kM6QVYysuiCrhA0cJvU=;
 b=HmCXYBVBXW6/4bqv/q0nwgxZ8BEg8F8bQtvMxArKFEsBlPcs5g9bqT1n6yTuZBMKUUDWKSFmJIFhH5jKTmtUCpmigQRC45rYMZp8Kb6ofL0DppOsJD5ggKuGG9q+IO8RBaS4/9SrNIZJehUtjampyjAJAGA7dDDmOFuM9gUrV73Bt/yp9Ja00b5oft+YJYYzUTyZKPL74Gz7DSCms8nNmN+VoHWXe/d88L3ROSXebniHGPJ7tG2XYjooqC88EI6f2tnSiRTa9ZE3AsWu3HRyDAYv7eOk4BBys7jjG88gMb0RjZQJ7fBF6scfZwmo+oMguRdZxmTqS5Ql/GIjW1a1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo+f/Ld6ML/dF2mhkkln3Em2kM6QVYysuiCrhA0cJvU=;
 b=hzDABuKP1tOQlBYFO2tSl1fR+XcSA9P5VMKdBchn+EyhAMGUKssntBGCbpSQrabDzwBM8c35Y3+wNqmU5JejQNKelvYpS5oIAK6TDfTtA6EoMSy1y0d3eQgKTvG8T5yKBrJP+2jtRj7Y49zYe7Y+k8+fWiNYXYr1utifE0TsZ0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 05:50:33 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:50:33 +0000
Message-ID: <02c5ca3d-fb75-4410-ab38-da74caf8d367@amd.com>
Date: Fri, 30 Jan 2026 11:20:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] drm/amd/ras: add check safety watermark func for
 pmfw eeprom
To: Gangliang Xie <ganglxie@amd.com>, amd-gfx@lists.freedesktop.org
Cc: tao.zhou1@amd.com, YiPeng.Chai@amd.com, KevinYang.Wang@amd.com
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-7-ganglxie@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260130022950.1160058-7-ganglxie@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::12) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a92a56c-2623-4d88-85f3-08de5fc37bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2VlVWgwTlFMQ3pxR2RxWEVCeWhUM0hKbVk4WVdQM2hRU0xJVW5vYUFNbHdZ?=
 =?utf-8?B?bGpNT0YzQnpjNTN6MytHK1BvdjE1UnFUSi8zc2Z4VnZkTi9YVWlBV0Y5TkZp?=
 =?utf-8?B?aDFXWDI4V1pRKzVqOW5RYm01bVZpTXQ4ZVNnamgrSmduK3Q3ZXhnVXA0bExk?=
 =?utf-8?B?cFg1a3Fuc3pjUTI4bXE4Q3BON28xVUREUkhSUVdwUHZlOXplQXlKUDE5WDVX?=
 =?utf-8?B?V0h2NlpxNnlVK3V1OFFBWTV2bGxNMHV1ZjU5Z1hRM3ArL3hPN0IwNkNSaU43?=
 =?utf-8?B?ZGY3NGE3dFdwY2doRXgrTStoTnlmc1R1MXBUcTlXNTBqNERqOGdDM0cvdlFt?=
 =?utf-8?B?SDJ2UzRDSmI1UXVibFdVM3RkUHE1WHhNQ1RPQ0dJK2s1R0QwNmI1aE9abCt5?=
 =?utf-8?B?K09qMHQ2ODhiUnl2TzFJMzlUc0hrMTJRY2VoZFdybVNsZUZmaVNwVkh4YjNZ?=
 =?utf-8?B?VUp2YXovYm16Z3hJaDJDblNWMkpTMG03MCtkTUtPV1kxa3pJOExmazNpVVlP?=
 =?utf-8?B?WTRVc1VyU095emF4TE94V1o2TVozVG1wYU9lQ2FNUGpqWU1ncXJqZzRLZEFm?=
 =?utf-8?B?d2cxcWY2a3lGam1wQXBLbVUwRFVxMW5mUlhqSFppdEw0algrYXFpSEZDY1lJ?=
 =?utf-8?B?QmRwS2VqYnJSU1dUV1Bvci8zd3FZY3U0ZmlwMk42ejFMNy9FL3NKQ0FHdGZy?=
 =?utf-8?B?ZHMwZ1ZIbnpLb3Fkc0tUd2MrUlVIZC9iU3BoZlhLVlNJczJvS2RtWUlNZG8x?=
 =?utf-8?B?TWQ1WTYrc2tjVDlFdjFwS0xnODdhSjUwYk1aSVdVbG9wZG95WmgxaXlyRVgv?=
 =?utf-8?B?R2tibXllMzVsbkFqTTZTSVJkYm02TUJyTkorTnJrY1B6S2hWdjhYTUQzbk1Z?=
 =?utf-8?B?VzhTQ2gwV24vMFVkYVdmenVHRTFQT2VZelVmT2xFSWhEQ2JnRlhNVng5eTIy?=
 =?utf-8?B?SVFTQTJlcUFaek9hdzBrZjZGeU1TK0x6VG12WGpkNWE0RUc4Wi9KNnBBRitQ?=
 =?utf-8?B?R2VYNTdta2ppSUd6YjNwSlUzWW5CQzVSM0ZFWnlla2hBNml6Z2ZjcjloVC81?=
 =?utf-8?B?WlBOUUlVN3VPVGdpcXAyQmVPTFFWd2h1NnF0NFBYd0YzWVhYcWRDeHVqaWRX?=
 =?utf-8?B?RHNqMGh4V3Z6K21odGxJbnp4TnRkQm1QNElzcm5rSnRJL2ZQRDdGTHA0dXVS?=
 =?utf-8?B?S2NiSG9tOFUxTUpZei9Xd3dTNDhxTU4yNWNmNHlCRXVQNm9lZmgweDU2cnZk?=
 =?utf-8?B?YXdpUjAwdjVRM2lheHc2bmN0Z3paTmhIdktpa2wrTTBJWjBzcjZMeDVvdEdG?=
 =?utf-8?B?TGNCcGxNa2dRaWZoSFMyL3dpZUZ4RXpYV3R2K3prVk42TnJrYk4wVlNYSERD?=
 =?utf-8?B?N2xNS3YwWTlObzJYb2RwOEhmVHcyekZod3VZYWdGWkR6NGdJaG5hSnJvcklx?=
 =?utf-8?B?Vi91NmNUd3NUWkcwbkd5bTVseVlGaHp4ZVBGdnRjdndsM1FhMENZL3VWUW1p?=
 =?utf-8?B?NDRGWUg0bnMrQWFLZFVKYjhFd2ZKRzJKL2s1eFQ5VXBtME43SmUyZUswTHUw?=
 =?utf-8?B?ckxoMEE3OHpTSU9WNkR2SUJRdWVma2tWdUtYWmFDbWgrc0JnVWRkQmkxSUFy?=
 =?utf-8?B?WFV2aVUrUVVWbzNFODdCcm44eVBqcUdsZHZSOEdydkhEME1JRC9GR3g5dSta?=
 =?utf-8?B?c0JkOS94S1EwZTA3SE82S05UbVFvU3VhUVpQYUFoUkVQYndYanVBcUhKczdE?=
 =?utf-8?B?S2h5WElwbEFjMnVtM2YyYllWRkZZcUF3WEV3a2ZoRWFPbWpMOHpPUmZQb2Ur?=
 =?utf-8?B?ZE82TkNwTzVnQ2IyK2E2Z2YxUEVaK0tROUhOYm1sOXpkR3hnbDVUSnEvRXBI?=
 =?utf-8?B?WUFSdDR2YVdqUmxCczliM1pTRlJZem1UU3o4eTM4Qk1WMEZabXZPQWpvRkww?=
 =?utf-8?B?VjF3TmhPbXdJaTZmcjVTMEc0K0Z0MjAwTTVSRVc3K2FXbm9XK3lHTjM4N3o1?=
 =?utf-8?B?TEltcXJMVjZCeU9hWlg1bnZ5NWU0YW1SQWNMVWRjVDBmdDVPa2c2aDFaQUxX?=
 =?utf-8?B?ZTQ0cVhhcmFtNlRvU2N6cmNMZnE3QkpzTWMrbEQyWEdHaHZOVVVVdGQrOXRM?=
 =?utf-8?Q?iS4w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXkwSFlMNEp2OVRvcERzanByNWk1cmhUQkJYYUNCTHZJSDJIMGE2bCtiQ0U0?=
 =?utf-8?B?enRWcVZaRUd4OXZOTWpqazlFbnd0YjRYdVNnTkZsQ0Y0M0ptODdlY2drRzNi?=
 =?utf-8?B?dlJ5K2FYUE5NSXRpYnh0OC9idE5DdThSSVpDQUNrZzNnZk1WRnRsK2J2RGlQ?=
 =?utf-8?B?QzdEQjBqdGM4YkVFdkVTYkoxTlVkQ0dtOGNaU2dYY2R5VE9KZDl5aFRIYUJI?=
 =?utf-8?B?UE92eFpBRGwwRXpoWFRid3Z5ZjNYRm00SlhIWCtQRXpYUHZSaWovKy9KN0kw?=
 =?utf-8?B?dVBZb00vVDI3Mm9WMGZJbksxVkVyT0gwSGpDcVRHZ1B2aEEydEtZcXU3TlJq?=
 =?utf-8?B?NitaK2duZ29DVkMrM2NneGFFam9heGdNV0N5QzBBUnJ6NHNuV0lBVWJiRnN4?=
 =?utf-8?B?Q3dxY0dFYVhyWkV3anVvaTZyOXRhQk9FYmp3NExBUGpHVzdrWDdiYXFVeHM4?=
 =?utf-8?B?NVUrYjE0MzlCT1B4eXRjQVlINDB0SXNra3YwczNodmo4bjZrRkZ1QVZHbUZq?=
 =?utf-8?B?TkZ1MWVIQUZZK2ZWc1hPazdOS0tMR0tXV08yUG5FOVFhQXJWVGJrclBFMjgv?=
 =?utf-8?B?ajE5N2Z6bHJCc0Jta2F3anpiZ2c5b1hXL0FybEMzTVdBSzFuVWJkQVJKMDlN?=
 =?utf-8?B?R1FkRVVjKzlHM3RlZzI1TDA5R3ZOdVl4Vy9JdlRLY3BuUnhwSEJ5T0JDSkVM?=
 =?utf-8?B?QVJPUGJ2N0JBWHdBbjF0ZnZEMHNnVUV6S2lVRGNGbnZzUDlYb2FJajM4YVlx?=
 =?utf-8?B?T3E0azJsaWJ6MS9MYUNiV3dzM1l6Q1dXclZDRzBDc3ZSUkdBZEFBbWEvVytP?=
 =?utf-8?B?eThiTDlJeXNrZGdYazN2b0ZJTjhxY1B3VkRiZzQzeHRZYTc5WUovRnFabVcr?=
 =?utf-8?B?bUFVZmpTR2xoL3FFdzVtS0Z6aUVBazFaTzhTNHFaRlI4WEtQNWt6M3hFeHhl?=
 =?utf-8?B?eFZtMmhXN0dVTnVNMnNRRWZwRU5xYzUyaEhpbFpxVEFnSW9KSVU3SXhvUG1j?=
 =?utf-8?B?NTlHblM2UFhvZ3VLYmYyTldCMGdDVXZPVG1kOGFkVkxZT2gzaFYvdDUzVHho?=
 =?utf-8?B?N01lK0VlV1pNbXRTZnJZUEp5MFRLUkQxQUpuNlh6cnA2eXEzdTlVcU1aTjN4?=
 =?utf-8?B?UlE3dDAxOUxQbGd1bGluSVdieGtnemlvaklKOEtvUURlMFQzUlhRekQ1L2kx?=
 =?utf-8?B?dDlTMWMwa2ZlQ1pWS1hIckhWaUZIVWNHUTdzY2xHVU54c3RLaGFpbWIwMVBt?=
 =?utf-8?B?cFJYRDVSQlpGMGM5aDdWU0FUMUgzRXhzS3lYcFFOd2g1NEZZb0dENEc1Nng4?=
 =?utf-8?B?N09HS2ZrdFVVUmd3OHdBV2JXbGdkTlVmdkpWT2p0b0RVWU9UcXREOXRHUXFG?=
 =?utf-8?B?N0NRamZXdlJNeVNNNEZxSSt3ZVNUbHpvNXBJdkdCbWRzbnBvMmFGQTlWS0Fh?=
 =?utf-8?B?bXJKbGVqVEY5Wmh3OEtnZXJRRURLSnRsb2hZMGR6NXFvZWFxUFpPTUZ4VjVW?=
 =?utf-8?B?Z1ZLVU5VZGNkMEZuTVN0bGNRRVEyN08wcjVxQVcrS1VIV2FKZ0ZMUkkwKzJ2?=
 =?utf-8?B?RHdOTGZucW4wZ2F6VU9sODF4ajcvVVBMWWxkVHFFclJmK1dhRFpVZVB2NDFt?=
 =?utf-8?B?bTJlaExmRmQyOEk0d3pJaG1tMW9HQ1gzOFFLNHp2VllYWUtRZ3hkTW1NUyt6?=
 =?utf-8?B?SHd0SW05U0p4WHVhVUx2VlVpUWF0UHN1cHFOSHVpWFgwcjVFNVBFS0EyalVV?=
 =?utf-8?B?MVRDUnQwejlrUFZnMjk1Q0FaTkx2Um13VnJnTGpWMjJUb2FoVm1UZnI0Yyta?=
 =?utf-8?B?MmI0aEdsTmFna29mYjYyb0FITUJiN2pvWW5UN3I3Q21LN0JPM1N2TlVrQi9l?=
 =?utf-8?B?VkIwL3Q0elFNSVRuc2RDTldTSGZxSld3ODhDMEJLSXhGRmxXemFrN1dOazYv?=
 =?utf-8?B?YzVQMnFTdWNiWTZiL3BjNGdBajMzUEtiNFlJbkdIakxIRGl0SlloOGk2N1FS?=
 =?utf-8?B?UFZNSDRRQ1R5MHA5TDcwZmRGeG9wcWIvaEJycERPVTYxZXYybG9qVldxb0c0?=
 =?utf-8?B?d0dORWxkbnpoTEtPS0R4RDhhU3FOdmhuTnV0Y3VtMHkyMDlwTXdnKzRuaWw2?=
 =?utf-8?B?dFlkWHVpMDdBM3NNYjQyZDFJaXdOOHNXWmkzMnNaMVRHR3B2eDBtQ3ZWdk54?=
 =?utf-8?B?LzVoNzlvRlljaW9BcWxQMS9ZM0NMa0ovaUE4ZE1qbEk3TkVnZHFCL1NCY1Ri?=
 =?utf-8?B?WUFyWnFPeVI5ZTE3OEJUUW5QLzlDVk9zanByc3drOHNlTHBWV1k5ZTMyMXlZ?=
 =?utf-8?B?d3Y0WllPVS82bzZ5VnF4dHFBakNVUlhudFJkM0JUQ2V4bC9sZTFNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92a56c-2623-4d88-85f3-08de5fc37bf7
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:50:33.7553 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmzFK6butLfYNZb23847xZLbhWBLojbxwbhEynUvqsDuLw+qwHn7pnoEqCykIMvl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255
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



On 30-Jan-26 7:59 AM, Gangliang Xie wrote:
> add check safety watermark func for pmfw eeprom
> 
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>   .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  |  3 ++
>   drivers/gpu/drm/amd/ras/rascore/ras_core.c    |  3 ++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 30 +++++++++++++++++++
>   .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  1 +
>   4 files changed, 37 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index 923bddd0af3a..36c264ab889c 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -570,6 +570,9 @@ bool amdgpu_ras_mgr_check_eeprom_safety_watermark(struct amdgpu_device *adev)
>   	if (!amdgpu_ras_mgr_is_ready(adev))
>   		return false;
>   
> +	if (ras_fw_eeprom_supported(ras_mgr->ras_core))
> +		return ras_fw_eeprom_check_safety_watermark(ras_mgr->ras_core);
> +
>   	return ras_eeprom_check_safety_watermark(ras_mgr->ras_core);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_core.c b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> index 91c883f16ae5..1f2ce3749d43 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_core.c
> @@ -561,6 +561,9 @@ bool ras_core_is_ready(struct ras_core_context *ras_core)
>   
>   bool ras_core_check_safety_watermark(struct ras_core_context *ras_core)
>   {
> +	if (ras_fw_eeprom_supported(ras_core))
> +		return ras_fw_eeprom_check_safety_watermark(ras_core);
> +
>   	return ras_eeprom_check_safety_watermark(ras_core);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> index ae63e7394829..34a4161251b3 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
> @@ -190,3 +190,33 @@ int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core)
>   
>   	return res;
>   }
> +
> +bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core)
> +{

Again looks like duplicate logic. ras_eeprom can carry the threshold 
config regardless of the access type. There is nothing in here specific 
to the way eeprom is accessed.

Thanks,
Lijo

> +	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
> +	bool ret = false;
> +	int bad_page_count;
> +
> +	if (!control->record_threshold_config)
> +		return false;
> +
> +	bad_page_count = ras_umc_get_badpage_count(ras_core);
> +
> +	if (bad_page_count > control->record_threshold_count)
> +		RAS_DEV_WARN(ras_core->dev, "RAS records:%d exceed threshold:%d",
> +			bad_page_count, control->record_threshold_count);
> +
> +	if ((control->record_threshold_config == WARN_NONSTOP_OVER_THRESHOLD) ||
> +		(control->record_threshold_config == NONSTOP_OVER_THRESHOLD)) {
> +		RAS_DEV_WARN(ras_core->dev,
> +			"Please consult AMD Service Action Guide (SAG) for appropriate service procedures.\n");
> +		ret = false;
> +	} else {
> +		ras_core->is_rma = true;
> +		RAS_DEV_WARN(ras_core->dev,
> +			"Please consider adjusting the customized threshold.\n");
> +		ret = true;
> +	}
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> index a1003db3c33b..b0d3eade4377 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
> @@ -67,5 +67,6 @@ int ras_fw_get_badpage_ipid(struct ras_core_context *ras_core,
>   int ras_fw_erase_ras_table(struct ras_core_context *ras_core,
>   				   uint32_t *result);
>   int ras_fw_eeprom_reset_table(struct ras_core_context *ras_core);
> +bool ras_fw_eeprom_check_safety_watermark(struct ras_core_context *ras_core);
>   
>   #endif

