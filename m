Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517BCCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 07:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5702C10E172;
	Fri, 24 Oct 2025 07:28:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J0IX945e";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A4B10E172
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 07:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dg9vUxUkpHDnaBAO44SAB8eJyCLU1rWRWD96jGF2Rn+UKrPZAJSJ3zmHc3WWyQQTV43QNClrlyTFKidr9o/eNAfM+zKepXhA8KemNzHoF3WrGZS2PZwLtFUdkp16i4NJl3rFoCr3O8F/eDh3Kp19o8sb4vi5BpZB+26krxpjMLhlrEi+pYRtkx0j5XhTSYq8Ig9sp6AjCzI8HHOoG4q6t9fm5FoH9mvws111cYx0vs3nCEVzQZvgzHm9AYF5QNwugpeVIKK0x2aOqHGZaq16qz6SxrgHlsukaJDfzq/IVrkhERAVUHyM2+zqOWeZFBWG5a9FkdoswyhXadLkVdrY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDXh1EZ21dZe6uFYkJpZHYcq7917m1FOhaU1lBabfz0=;
 b=k4hJkW7ol6f4co2TiR0E7MAcfIfBc80L0HAnl/Q0BVMwOYqzJnxN9XPyzMttBTVDwxwBMwjjdmEt/zUkCWfF6hLz0m3P890YoEk7wzRWYTDkRMlroExNUauTherhui40o2UiCvKmk8uX2P6PJqJZeb5M9jlUSYQOlLP05Cy1/+hbUvtdXuSM/SbZ/yHd5UfAVHZt5QNGB+1eRfrUdgIA84swsbCbh4p8sqA0Zun7+tpG88JDD4VTForettBQ1ydH9TIbq175b9uv7LOZB7sP/3hca9Pg0Q88vSyGP7KsPa3TpYvTAfTEqKJDjPZWQ7BagQpESjrp0q2OS0ZceSQE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDXh1EZ21dZe6uFYkJpZHYcq7917m1FOhaU1lBabfz0=;
 b=J0IX945e02agNNve6Iu2pQR93MSDSo6wuKpkBNxlkOYPsAfznrDEfU6pTsdlPF1wtctR7dExhtCLzyeqkOcPl492GGgV3e4n3wjOZ9O9uzePOaf5KGPxT5SvhKYd9kG3nl2sSoQwmzdMRkf/ICjLynlQ5hoFyAX588dVBcszZkA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:27:59 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:27:59 +0000
Message-ID: <1628dce3-4678-44c9-9622-505fffa03fb6@amd.com>
Date: Fri, 24 Oct 2025 12:57:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
From: "Khatri, Sunil" <sukhatri@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
 <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
 <IA0PR12MB8208E2BBBA8D41F85A86BDA990F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <06bbce9c-f5c2-41bb-b949-4ee89c945cfd@amd.com>
Content-Language: en-US
In-Reply-To: <06bbce9c-f5c2-41bb-b949-4ee89c945cfd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4c) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b625e0-cdf8-406e-10bd-08de12cedb97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZwZ0g2SHlNRFIrUkpkcGJOZ3Q4SlZaNWYyTG1wb0xOQmVqS1RLeXlOTUR5?=
 =?utf-8?B?YkNnT1FvZHpKTHhpbndzMTM2VTdMdjdudkU5d29uTEt6TlhnYkFqNHQrS0Jp?=
 =?utf-8?B?SDllQVVibXQxbk1FR05SUDVMV0lpeHBqNmo0cnNLSVRuL2pGaGZldkN2bTBS?=
 =?utf-8?B?cEdKMXVKczlYWTRlOTBnYXdmMmNoMnVvTWE0Q2NLNDd5STQxZGFvTldHTFdi?=
 =?utf-8?B?bUE4bEpKWGQ5M0JldmxLSWVSTVpHaCt6SW1WL2pIWG0yMzU0cHpQK2NMcUl4?=
 =?utf-8?B?Ynl5d3R6V1E5TWN5cWkrMWFaaDN5enMxSHp6WlVHemdwQ29pUjdNZnhzNnd6?=
 =?utf-8?B?NFlndlpINXRYNmhYVXA3Tm02MUtxNGpzQVplcVdqc2o2Rk5QenJNN2RhT0No?=
 =?utf-8?B?SkNKRy90WUxMN1J1T2pwYzltNXVJdTlrRm8ya1pJcXMyMWczUFRDZ1dXVHlm?=
 =?utf-8?B?N1N3SG1rMEwrZGVXd3IyTm43V2Z2NDZLZUtlNlpKYnh4MzJKTXRZQk1hYkRH?=
 =?utf-8?B?NjlXYlpHSnc0VWVSUDYwaVFTcHo0S2xjS3NGVGU3SzA0M1daSi9TeTU1TGVl?=
 =?utf-8?B?azZ6VGtaS2lMcmU0TjVjYU9KcDZmYTcxdENVWU5EYzA5Z2pPZmJ3UmE1d2NU?=
 =?utf-8?B?ditmMFJiemJpaEJFS1hSblV0RHlXcUlRSVNCaGdPWTY4K01WWkVMZndrVWgw?=
 =?utf-8?B?c1NGMHhJbEpRdmFaV3JGcjE3Mm1qMDdrZlRVeEdza1JiVzFzdEdqUWVQclZV?=
 =?utf-8?B?NVZ6aW1KVHdqSitUU1pCK09JTmlYMm9aNGZJRHB5TTBZWmE5Zk5wUlVmNGVV?=
 =?utf-8?B?ck1uK0ZNNTc5bWM5dlloSlU1QzR0K3RtT2V6b1VaQ09ydS9xRVhGK2prNUFR?=
 =?utf-8?B?TEFlNklrSExnVFA1RmExaVpMWjRjbU5kSEdtMTVGOGVyZGY1aVp2d1pWMDNL?=
 =?utf-8?B?Z0N2ZXhzTmNOVkFTOTczdzVRRWZMVVhZV2U3L2pjblhNd1JVUXovTklTdk83?=
 =?utf-8?B?TFF6Wk84TlhEQXhHNXBWM1A4bWJydE5XcFB4anBXcU5YQUsvV3dBcnNmTThw?=
 =?utf-8?B?eVA0MkdmUnp1a0s4VHhhb3RzSWE4aEhzcXFNbkUvaGpaNDBQcHpnb1QvZ2py?=
 =?utf-8?B?SHp4a2tMYk5tN0Q5c1dPS1ZnYnJPbFloS0RVaDl3V01sZFpBVGFndXg4a0s1?=
 =?utf-8?B?dTZmcDE2cnF4MlltUzQzL3BqOHo0UWRTYzU3enJvR3lxRUY0Y3lRd3NKSVk0?=
 =?utf-8?B?ZXkrbzJQMWxYK0dOR2g0cnVETVVadHdlSWd3VHBVeFZvbGZvL2R2YmM2TU0y?=
 =?utf-8?B?Sm1JangzelJOVTE0YStYVklaN3J5YUx2UHlXTE9lK1FRZHJRZXRZNzBGNUM0?=
 =?utf-8?B?Z0QvWE55cUl1dDdjWDFmSEFIaWpGelNzSnp0NmtnaVh2ZTFaWm95YjhJSXhq?=
 =?utf-8?B?V1h3Y2JBMk1wWXRkQWVVNldEa3dxeFRTL28zcHh1eEZTR1NWNHJDSlg2WUJt?=
 =?utf-8?B?OGRqanVaOXF3ZHB5K1lFeFllb3V6c3pKZEtQR2gxc3RySnRXcEoyY3RJWHFV?=
 =?utf-8?B?RXFzTGJod3E5RUFpTzcrTHRNT0FGaHBJUUw0ZGxlRjJpSDJSQzNTSEF2eVVi?=
 =?utf-8?B?NlBDR0xacjdDUVRSMUlYcVh5M3FPKzFGai95c3dQWFBuM3c0cmNnMHFiTnhq?=
 =?utf-8?B?eGpIK1RNRDFvaUhFdG5IaFk2dE9HdWp4bWIxTjN3cEttVXIxZHBHbDZsZmwy?=
 =?utf-8?B?Nk45b3Eva0V3ZktHSFNacWhqL1hib1V6eFJKU0gxY08zTzIwZWNvcGUwVkpu?=
 =?utf-8?B?Skg3VWJiQTB0OW1Gb2pJZkxLVXJnbUlqdW5ZczZaWnliYUlyOStMYTN4NlJI?=
 =?utf-8?B?VVBoSEp6VkxiMlFHNW9GTnBYVnVHZlgzTFZPZkFmNURvYW1rSkJPUEE1K2Ew?=
 =?utf-8?B?QVVUek02MHJSampHZW8vR3hoZUxvbWxLclh2Q2pBZkdXS3JnSkRvczJEODd1?=
 =?utf-8?B?MnBJT3hVZ2xKUlM1d1lrNlVMYzd3b0dpWmJGbDBuUFZhUENTSWpmd0VmZDlE?=
 =?utf-8?Q?OVUBZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjNoUTczbXFmT3ZUUWFycVZtUnhKamRjTzVPN2t0YkZMeDhleUU0WE9sa2hP?=
 =?utf-8?B?SStsaEhzdTZRbnNYMndRZWMrY3NvRWV4NllrQ3pUeDUzMmZHUHFNUjF0aVdK?=
 =?utf-8?B?dE9sZGIyZXovVWdkdVV1THYvSit1OWJKL3VtU2hlYUthcnB3ZUEvSHBhV1dw?=
 =?utf-8?B?bHp0L1lKNHRDY2UrUjlQSi9MU2hoZVpvc3IybW43ZEV1TzlsODhxWXJ5b0lY?=
 =?utf-8?B?TXFjQ045YWREb2lNV3FsaHZld3pTNHY1NkU0OXEyNm1oQ0NaaWVvZGM3MEoy?=
 =?utf-8?B?N1hDMHZUY3NzdWhQbG1WbW15b2JiTm05bXd3bU1YcTN1QTUweDN2dHJrTHk5?=
 =?utf-8?B?M0xxOFVpT1JUSW1KS0xhanE3RWFsTkgzck90bDRLRC8zVVpZRFJhQkFNZG1y?=
 =?utf-8?B?L2dRQVdHdWNKSjFzNFhpNlhVUmZITHlNaHNoZWhaZEw1S1pZN3Y4NTBySGNZ?=
 =?utf-8?B?Q0JITHU5WEp0Nm5UeDZITkNiTHBKTzBTV3ZZWlZqUVl2WmhyM2JYcE1MNWVU?=
 =?utf-8?B?eW00S0wzVTdZZGE5ekFTNTJ2dnZ3ekRwdWVjS0NBTTBQSGRGRUJOWFFtblJ5?=
 =?utf-8?B?TURHNGw1WmZVbVp5S2g5TG1Eckp4Z3I3U1VwaHBkSVZ4Y0lNTXg3RXhSSmNT?=
 =?utf-8?B?RjlFbjdKZFhoV21tV05PWkUyMFM0ZkNmc1BicS9hTlRtczdaQlI0R21HR3pF?=
 =?utf-8?B?MXp5NG5UMS9SL21kcXVmMlY5VEVkZDZLcDVqT3NHSU5lM0FGRjNQRWcvRnFl?=
 =?utf-8?B?S21pdXZVK3N4OFY4SUJkR0lyaEh4bUhVbDZuUFdDbXRoZ2IrUE4zZFdGbjJC?=
 =?utf-8?B?dnZBVFhQVThFN0xZRE1xVnhISUcweCtpcldDNjRvTkJSVWU0WC9HMTNWSm9i?=
 =?utf-8?B?dUkwYmVtQVVqaTEyVk11c0hGUW1ndUZqTlpnR0JLd0RBVTJ2VWZXOTNTa2tL?=
 =?utf-8?B?Si9qbnB2RlZUYTZXZE41VnBKdVJVL2gyY3NRQ0dTSWRaeEkrZEp1TzRSY0tF?=
 =?utf-8?B?SHNpUjZsQVN0LzJ4YVpRQ2tkQ1VPekFKTlE1UlQyaUxIWkh3VzhvRWxYVXdo?=
 =?utf-8?B?ZlZKNkxqbTlyRFlSOE9KYmNoQ1dGblNvcDk4cGd6b2xvUDdVdHpxTS9iOU1w?=
 =?utf-8?B?UFdyNGs2bXMrZFBrQWg2cVdBOUtyY05aeCtUdU85eUlzNXU1WjNLSEJPM2Jv?=
 =?utf-8?B?d3lqYWVmR1V2TXd6TVpUdGlZTE5zd0ZSeU0raEVqTnZEYkRSTFd2cVpNYThZ?=
 =?utf-8?B?NnV2SDg3d2tmRzBiS0haMGhMUWtHaVFNZG41bVBKdmo5YnBoTXZQc2N0NXdF?=
 =?utf-8?B?NTNqYXBDYTBLZzgvdTBXNTFnNTFCcG9YNmNIRTRwQWpoQjBiT2NEZUkwUUNY?=
 =?utf-8?B?S0wwK25oZjlWa0ZsQyszWWo3OTVhTWRhZEl0TW9FZTdnZ091UFRSNk9ERHJ2?=
 =?utf-8?B?bUs5clhNK1dVTlBzTTZneVFRb3A0bjIzTURzcDN4MTVzYXg0Vlg5NldZVXJ3?=
 =?utf-8?B?RmU3clJyMnVtWm9WVldHU0xJRHdSZWJuQXBxSSsxY1BjTFNSZHZlWDNHdlhN?=
 =?utf-8?B?dm93TXJtSlI4cDNweFQzd3ExbzErRWZNZmtNR3F2bitRQisxeHVWV1kxakRF?=
 =?utf-8?B?ZkhkUDNNcFpZSXFiek02UWxqK01NS0tHYk1nZnBYclZwVFFrOElkY1loaSty?=
 =?utf-8?B?dFpIQkdXeUV3RUdsVThJYWN6U3BSaVdqenlUUGFWYTFBbnZpeFQyWG9MSitx?=
 =?utf-8?B?Mit6dHdhaUlRaHZyYVZZY0cvQUdVenNUckJibWhjMnlSMkxuR1BxaUFPNTBr?=
 =?utf-8?B?VXhrbDhsUFRTQjNMUXFOOU5oRTkzZktrSUNYWGFiSTNZSEdIbitrSjVzVHd3?=
 =?utf-8?B?Z25qa1dmRGRXT0xYSzM1dlNJU0VYbzJESVdFbEhwRWdZMnRxQjg0UUhwRmNE?=
 =?utf-8?B?U3FyeVU0UWlySnk0Q3RGdE9yY3VvbS95TzAydy9McEhyRFNpdXprUVNkR0Uv?=
 =?utf-8?B?UUh3ZE96a01wZUxLbURNR0FsRjRuZFBaRktBOWdiSi9WWlpVeVJTaTFvcDFH?=
 =?utf-8?B?UWc5OWZRNlpTWUFGeTBHVnBNUkxNK2tNeWYzd2M3R05aSjlPWmJTK0c3bkxi?=
 =?utf-8?Q?bIJ0/WNNcIqwROQWhVmbwh6tU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b625e0-cdf8-406e-10bd-08de12cedb97
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:27:59.3634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qPZ8OI1eESu4HhR4IgqaTNNGG8di+xtkCGWEtB6T193IWVqUqSN+mao0KgydcwsX867hSBJkPVuMBpZ8gIgAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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


On 24-10-2025 12:54 pm, Khatri, Sunil wrote:
>
> On 24-10-2025 11:44 am, SHANMUGAM, SRINIVASAN wrote:
>> [Public]
>>
>>> -----Original Message-----
>>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>>> Sent: Friday, October 24, 2025 10:10 AM
>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Chen, Xiaogang <Xiaogang.Chen@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>; Deucher, Alexander
>>> <Alexander.Deucher@amd.com>
>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip 
>>> <Philip.Yang@amd.com>; Khatri,
>>> Sunil <Sunil.Khatri@amd.com>
>>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
>>> svm_range_validate_and_map()
>>>
>>>
>>> On 24-10-2025 09:20 am, SHANMUGAM, SRINIVASAN wrote:
>>>> [Public]
>>>>
>>>>> -----Original Message-----
>>>>> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>>> Sent: Friday, October 24, 2025 3:15 AM
>>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>>> Koenig,
>>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>>> <Alexander.Deucher@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>>> <Philip.Yang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>>>>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range
>>>>> in
>>>>> svm_range_validate_and_map()
>>>>>
>>>>>
>>>>> On 10/23/2025 9:34 AM, Srinivasan Shanmugam wrote:
>>>>>> The function svm_range_validate_and_map() was freeing `range` when
>>>>>> amdgpu_hmm_range_get_pages() failed. But later, the code still used
>>>>>> the same `range` pointer and freed it again. This could cause a
>>>>>> use-after-free and double-free issue.
>>>>>>
>>>>>> The fix sets `range = NULL` right after it is freed and checks for
>>>>>> `range` before using or freeing it again.
>>>>>>
>>>>>> v2: Removed duplicate !r check in the condition for clarity.
>>>>>>
>>>>>> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails,
>>>>>> we
>>>>>> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still
>>>>>> pointing to freed memory. The caller (or
>>>>>> amdgpu_hmm_range_free(range)) may try to free
>>>>>> range->hmm_range.hmm_pfns again, causing a double free, Setting
>>>>>> hmm_range->hmm_pfns = NULL immediately after
>>>>>> kvfree(pfns) prevents both double free. (Philip)
>>>>> what you fix is not "use-after-free", it is preventing double 
>>>>> free, right?
>>>>>> In svm_range_validate_and_map(), When r == 0, it means success →
>>>>>> range is not NULL.  When r != 0, it means failure → already made 
>>>>>> range =
>>> NULL.
>>>>>> So checking both (!r && range) is unnecessary because the moment r
>>>>>> == 0, we automatically know range exists and is safe to use.
>>>>>> (Philip)
>>>>>>
>>>>>> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu
>>>>>> version of hmm") Reported by: Dan Carpenter
>>>>>> <dan.carpenter@linaro.org>
>>>>>> Cc: Philip Yang <Philip.Yang@amd.com>
>>>>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>>>>>>     2 files changed, 5 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> index d6f903a2d573..90d26d820bac 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>>> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct
>>>>>> mmu_interval_notifier *notifier,
>>>>>>
>>>>>>     out_free_pfns:
>>>>>>       kvfree(pfns);
>>>>>> +   hmm_range->hmm_pfns = NULL;
>>> hmm_range->hmm_pfns isnt set till a goto out_free_pfns is called, 
>>> hence not
>>> needed.
>> Why?
>>
>> pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>> hmm_range->hmm_pfns = pfns;
>
> Sorry i missed it being set in beginning as i see it being set in the 
> end . Not sure if we need to set it two times, check that once if its 
> needed again, i guess the second time setting it isnt needed.
>
> Regards
> Sunil Khatri
>
>>
>> for example, hmm_range_fault() fails), the code goes to the error path:
>>
>> out_free_pfns:
>>      kvfree(pfns);   // free the buffer
>>
>> But after freeing, the pointer hmm_range->hmm_pfns is still pointing 
>> to the same (now freed) memory.
>> It’s a “dangling pointer” — it points to memory that no longer 
>> belongs to us.
>>
>> Best,
>> Srini
>>
>>>>>>     out_free_range:
>>>>>>       if (r == -EBUSY)
>>>>>>               r = -EAGAIN;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> index f041643308ca..103acb925c2b 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>>> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct
>>>>> mm_struct *mm,
>>>>>> WRITE_ONCE(p->svms.faulting_task, NULL);
>>>>>>                       if (r) {
>>>>>> amdgpu_hmm_range_free(range);
>>>>>> +                           range = NULL;
>>> Range is a local pointer and if it has been freed it should not be 
>>> used again in same
>>> function. The error condition should handle that.
>>>>>> pr_debug("failed %d to get svm range pages\n", r);
>>>>>>                       }
>>>>>>               } else {
>>>>>> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct
>>>>> mm_struct *mm,
>>>>>> svm_range_lock(prange);
>>>>>>
>>>>>>               /* Free backing memory of hmm_range if it was 
>>>>>> initialized
>>>>>> -            * Overrride return value to TRY AGAIN only if prior 
>>>>>> returns
>>>>>> +            * Override return value to TRY AGAIN only if prior
>>>>>> + returns
>>>>>>                * were successful
>>>>>>                */
>>>>>>               if (range && !amdgpu_hmm_range_valid(range) && !r) 
>>>>>> { @@
>>>>>> -1769,7
>>>>>> +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct
>>>>>> +*mm,
>>>>>>                       r = -EAGAIN;
>>>>>>               }
>>>>>>               /* Free the hmm range */
>>>>>> -           amdgpu_hmm_range_free(range);

We still need to have amdgpu_hmm_range_free function for clean up in 
case there is no failure reported before. Check for r and call 
amdgpu_hmm_range_free accordingly.

Regards
Sunil Khatri

>>> I guess we are setting up the error and that should be the criterion 
>>> to call this
>>> function. If there is already an error condition before we should 
>>> not be calling this
>>> again.
>>>
>>> regards
>>> Sunil khatri
>>>
>>>>>> +           if (range)
>>>>> Can just check if(!r) here and remove "range=NULL" above? if r is not
>>>>> 0 range has been freed, if r is 0 free range here.
>>>> But there are later spots where r becomes non-zero after 
>>>> get_pages() succeeded
>>> and range is valid:
>>>> svm_range_dma_map(...) can fail → sets r != 0.
>>>> !amdgpu_hmm_range_valid(range) → you set r = -EAGAIN.
>>>> !list_empty(&prange->child_list) → you set r = -EAGAIN.
>>>> In all three cases, your new tail logic if (!r) 
>>>> amdgpu_hmm_range_free(range);
>>> skips freeing because r != 0 now. Since you also removed range = 
>>> NULL; after the
>>> early free, nothing else frees it → memory leak.
>>>> Regards,
>>>> Srini
>>>>
>>>>> Regards
>>>>>
>>>>> Xiaogang
>>>>>
>>>>>> + amdgpu_hmm_range_free(range);
>>>>>>
>>>>>>
>>>>>>               if (!r && !list_empty(&prange->child_list)) {
