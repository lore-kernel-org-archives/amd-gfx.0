Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB95CF07D9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 09:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B24C110E220;
	Thu, 10 Oct 2024 09:11:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUFVn90q";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DB910E039
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 09:11:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNRWIZEqWnJd13O1UsquR/ji4nKvv2rmdiv46KvNHhR/gWRwjNS0u4Ftw144M1l6AgQB92C47BTWupSAsuHhnUZCwlP6sk36cuji25Q8D2rX4slFFVFh12Y6hNnV6H7LVIWOfVow69GFLZ3UK2U6CptlwjPboA9Ln0wChennO6otewI7gbuLpup8Ik6aA1POluUT0olip7Znfw4M8Fsgp8vtHjD9rYvbavQNvz91nMKfKOAxwFOK6vhxLVxIlHqSSlqRZfniJGstExXpy3xCQpMswR/npO5DNj2mFBYILjAF4t4gRz9Z4PEYguOa6m1GAEIWAeBkRS8+k7pW12TGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO0GpNPO55VslNdWzGIgl7eGMZujJXLlm4iI0mx8OaE=;
 b=xIWugek8FR9ALF/5suB37+HSU9dMtZW97n6BhBxQeZKQfzACdcqvQuzc4T7bS72ZDpBIwWHiPGbPOJeO/RqZZpVRqgibT2KqMMRMGfexqVbMT5SqgeDHdY7BT8j+HJL4pPC2AaPCuTyEhmbjc+O6xGORovdFEW9j87h7leSPgmTMCeOe9Oe3WgafpW1pXsxTpKycrh/DqyrTvYYqvQjSyu/EeC00jRv9I3v5+U/N9RG078kaOEiGgljGpl5jbXhMY6qxE7i8xvg9yA4CBOOjUS8XMroEGNC7C0RutVgaEKgksTJJN2rhwsvM+47ww7AITM0w34VIROevwfX5ksSH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO0GpNPO55VslNdWzGIgl7eGMZujJXLlm4iI0mx8OaE=;
 b=yUFVn90qU+eLEl7oRHJIAXbqm7p1THeZ528jsaPQw8O5y2VktPQ+ZN8OuAWW7MQ+3Lcz7WwgvH2YCUENcrY9qlg2my91sfZkyC5MthryuHM7CUNntQYRb4oWcuU3vgNkfDHE91+3s8M+dXqaJotEpOQXICsMF5CC1pBYDNIqmKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB9525.namprd12.prod.outlook.com (2603:10b6:8:251::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.18; Thu, 10 Oct 2024 09:11:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 09:11:36 +0000
Message-ID: <56761d75-9cf8-4809-aa57-11ba5217c823@amd.com>
Date: Thu, 10 Oct 2024 14:41:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/13] drm/amdgpu: validate suspend before function call
To: "Khatri, Sunil" <sunil.khatri@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241009142502.891864-1-sunil.khatri@amd.com>
 <20241009142502.891864-7-sunil.khatri@amd.com>
 <d7fa2890-7e0f-48c1-afe3-2d934ee3448e@amd.com>
 <832aea2f-8692-406e-874e-679bbf0c33a1@amd.com>
 <85fe3fd1-53e3-2c00-d27c-96ed595634b3@amd.com>
 <b774ebf7-f191-43dc-ae35-7cfbee126e1b@amd.com>
 <63e9aa2e-e584-5927-b1b5-19b47da8ebca@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <63e9aa2e-e584-5927-b1b5-19b47da8ebca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f6fd06-9338-4e47-8854-08dce90b8a9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlVmSHhiQy9KWnF1RFIwazdhVHYyQTB5TEJtNnNVTXNQbjdtSHNleVNqK0pt?=
 =?utf-8?B?dlhBcjF3ZVkyWXFEWHRaMGxvbVpxa2VsQ2tyM0pDa3d6TjFjQW1DVjg0am1B?=
 =?utf-8?B?V3pwL0NMUUNPVGo0YUpvc0ZBVzZ1Tk9oaGc2U004N0NOQWRFbzZtUFdSY2VO?=
 =?utf-8?B?Q0JEMytRclpLbzhKS1JHZHIrQmFNTzM2K0JjUm5vSnNZQVZDVHgyYlhGUHNj?=
 =?utf-8?B?dGtDdXdiRXlBZVVSUmowWlI3SzRLK2VoRXhBN3VqZWEzRml3eVozQzJkUTlu?=
 =?utf-8?B?dTZxZHh0OVlKUndiTjlOVnQ2U1VIUlJjVmhpQ205Q1ljU052dFZyYTF4dHox?=
 =?utf-8?B?RzNIbUFXVnZJdng5TzlHNmdTcFFObmY2KytObno3Y3FlYUc5MnNkcS9rSFJr?=
 =?utf-8?B?MXFIRWsxRHNuVXgveVBMWEdwREh5dFM3ZkRBb0ozNVBOUjFzN1I4S2VqRi9Z?=
 =?utf-8?B?K2pTNVNnR0JnalMydXVWcStmbjFGMmRqZjZNWldyRlpqNUZDLzV3dWNKWmFK?=
 =?utf-8?B?K0VwZWZPQ1RnQnkzOTVMeVBHU0FycGhKaC9IWk9NSVdMTTdrUTIzSkFtRGdh?=
 =?utf-8?B?V3lOM1pwaTdUUjlYMENpdjNpS0pjZTNqQllEWU9SRWYrL21RcUx4R1puQndF?=
 =?utf-8?B?WXFtNDZYZUswbDVCVGlGMUNwK24vUHl4R2c0emJCNWZjc3AwK0tNRVQvQmRJ?=
 =?utf-8?B?cURnb0dyQnJPOUpaVnplWFJNbEh6Y01kYjkyc1ptQkxQMzBwMXpNSXhxWFFq?=
 =?utf-8?B?eUVEU2NxUzdpbGpFaW45cy9BbERWTDZUSk1TZUNlTjdYdUQ2Ri9OWktiend2?=
 =?utf-8?B?M0hyYmttK2owWmFmT0x0V0tHU2pncWkvUWp6WE5DNGRBc1h1d1VNQ2ZNRjd5?=
 =?utf-8?B?TWdoZ3JXcDZvOUNrNkR2VFh5RjM5M0JDeUk2U1hOODVCbEJzYUxJMVc0Vmda?=
 =?utf-8?B?QVQ5NnozZ2dCdERzcGNQenFxUVhZQUg0NlF6MmNjZ25lTVFkVjBpZXFZQWZD?=
 =?utf-8?B?Q2ZpRFp1dllzcEpLaTZpa2tBL2JIb2NVYURlYUdYUW8xQjlYaUxDUjdiOEN0?=
 =?utf-8?B?c1pWVXVaaDg4R2kvK0dsOXA4TmdwMVY2bFJkWXZzWkk3YVB6Q2UvMGJHSnYy?=
 =?utf-8?B?ak1pbmpaQStmM0Q2V3RzWGxtMGYvazNMY2tlbUM0c3g0UWN5czJwK1dTYnBa?=
 =?utf-8?B?TWE3ZjRBUXd2Z05adzl0OFRMRDFHNEFEYmpIQmhiN3NRWDcyRWc0RDBFTjlq?=
 =?utf-8?B?UURJMjVrZElMcndFcm8xb1VHcFBGSUtKTWFib3RGbGxBVjhOT1ZxcWI5dE9s?=
 =?utf-8?B?Ly82VXNXZ2Z2b2VlWU9wTTFoZ3JlOXV6OFBmZk56Y2pGUUlJdGhJTFNNU0Nt?=
 =?utf-8?B?NnhqYmphNEd3Vk5TYVJveXY1akVYQlJTREdLZDhPUnY1U0tCRUthQ09tOHVa?=
 =?utf-8?B?MEtJOGlmdjlpY0JyandIa1ZMN0J2MEt4Yy9iTW8venJEbFlPUG5NcEl0bERh?=
 =?utf-8?B?SGVodThkN3pQZFZ0S09LbGNoSWZLL0lUSUJpQkUvc3hkakRvTDFDVy9xOXdx?=
 =?utf-8?B?WkpoYnE0VWZlK3BrMG5xeEhKRTVZV0tlVWMvOTNmS08vODFLalpsS2dyZXd6?=
 =?utf-8?B?aTZSZDlWcHlrbTV3ZEgvQXlsTzFBcHVuRTRYYldwOGsweEpHckltaDdOWGlz?=
 =?utf-8?B?dlJnSGtDNnlURytUSm1JRVo5RkVleld2S0lZL0VyNE82SlJBL2oxSmV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlA1a0xsdjJuMmc4UFRPKzhTSU1yV2pxLzNFdjJIZm9yNU0zdkp0Nm5SckhH?=
 =?utf-8?B?UjJrT3Byb0xvQW40Z3ErM2lXeHlNZlB6V1VzdGxqb3Z5aEQ0V2pJQXZuRXVs?=
 =?utf-8?B?QitkRGIvK1UwSis1bXBCMnA3d21QWnpWSVRPWFZPa3BLOUpPdTVOZllFdXVK?=
 =?utf-8?B?dUcyTWdoVkdyMWxHa2pnaEJNYXhtZmtVUSt1S3o3OTRmT1BUSTE2T3V4VWtQ?=
 =?utf-8?B?NGJaUlZ6N005WlhKODR6eUN5TERZSDEvTUNTcGlkakRYdWJlL2pFZE9uZmFM?=
 =?utf-8?B?dG85QS9iMDRqaGxpYVNoY1pYWUdhR25peFNOaEU2NmVPVHhTUHVtekJGRDhW?=
 =?utf-8?B?QXNIMENzUGxOdW5QRStwK1BwbWovZDczYVlwUkIybjFIbWx1N0ExOEwwMERI?=
 =?utf-8?B?enRRbDBtYTNGc3pBNkpQc3BqSGIrcjNYQVhsMG13L05jVktaTlhEV010cU5I?=
 =?utf-8?B?ckZyT0hSNTkrZDdhQVpNZzNUSkU0dkU3QWZMS005YWlYWjJOTmdReTVrL2Zm?=
 =?utf-8?B?cDd0cTdra2graGQzVjhOR0hXMnRjRW1NaFFNMUxobUJKNW52WmZkVnFhYjFl?=
 =?utf-8?B?RnhFaC90WGoxZ1JrcFhKMWplbkJtUW9EbWxoa0JBRUFXYWtlZm8zTE1wKzRi?=
 =?utf-8?B?QXg5SWYrQnlIOUtoaDUzYVZUSGNOSklIRXNLd09SS05mdWEyYU14cDlSSjd4?=
 =?utf-8?B?ZFcwbGM0OFY3Mjk4MmJtWW8wSEV5K3Z6K3lLNDU2N2JpNlJlcTdRUVJRMXoy?=
 =?utf-8?B?dmdidGFINW01alVMVU1KQ3o3N1UxdFJrd1RWYkxHcW11bG5mWWlYZlhZdkpw?=
 =?utf-8?B?UUZQUUxYTGJJM0ZObjQ0QXJKa1FKdDVqc3FERXE4dFBTYUYzbzZ5cFlzaTRu?=
 =?utf-8?B?dnlsbzhxS2piSWRaVE0wL3hIakZ5akwrT1NNRnlNVFF3eHQxem5RVEYrL1gy?=
 =?utf-8?B?eCtGZyt4T1M1VHR3NW1EVk1SVHVQN3BYOVdMTndQQjVYTFl4LzEwTHErZFZs?=
 =?utf-8?B?ZDNyemVqbjVQSW5EaHg4My8wMWd4bXZZYXFhUk1helUyRGttZVBoWTE4YlVl?=
 =?utf-8?B?U1VJTFJSOWIxdEVHZURWMm5UTm9OWTFGL2lWYUdIc0pxNHBWOGhPaG9jdGdH?=
 =?utf-8?B?d1JGV1JuRVdObzFmdWZGQ1dJZFNuY3Y5Vm5Vc3ArSUZaVmRjR2RHcE1PRzhh?=
 =?utf-8?B?UEdVYmhXa1dweWUwa242QWhkbjgvNWRiU29hdXJPNjgwY3lUSSt3eHJGK1pu?=
 =?utf-8?B?a2V5TjFGMjMybjNmU21yc1FDeXhWM2dIVlVDYUU5NkZmZnZKcThmV1JYd29I?=
 =?utf-8?B?bzlvMXZDZVoyYTBOMVM0bFhPeTN5WjYvejJScVNGM3F4VnhmV005ai92SGpF?=
 =?utf-8?B?bTJaR2xnakRBWCtJWDFuUU9rajM3WDRnZ3U0UjhmbmtDK0VSTGl3VVZDNGZU?=
 =?utf-8?B?ZVdmaE85KzJEVzFScFZaMmw1V2Z5RDJYdktCK29Qa24rQ2l5UGhqQlk2aXV5?=
 =?utf-8?B?aCtvV05uT2FKL1lwMTVuRzJRQ0sxT1FNcUt5d1pObkxGeFpQRE96aTZmdWpM?=
 =?utf-8?B?Ny9SV3F4d3JlaEdyb2U2YkM4blVuYm54WVdEeDF2cFhCRzRZSDNjUGM1dWFG?=
 =?utf-8?B?T3dSc1lUeEFpNnlCVllXN1hBckUwejA3bEw1Vk11c0ZyaFgwYlVTOTlNN1Z0?=
 =?utf-8?B?ZnpIcFdCTmN4c1VDYmNLekIrN0lBTzVvL3UxcFNBcWsyNUlpcGxSN2dveDA3?=
 =?utf-8?B?WmxLNjl2UkFMYUhhOFR1cm5sTUtyblZFaUJOYW5MZ2tlUzcwQWg3NFlpQXBC?=
 =?utf-8?B?QjVWekIwNEhvSzAyRXl5MURzS3Zia0F5RG5xZ2hNNW9NdlNMd0lIZVhDbjNC?=
 =?utf-8?B?dnZBbG1XbUloKzNLSFpkRENoSFlaYzN1dlVJQjlEQVVZL0VXZTFBRUNNcUM5?=
 =?utf-8?B?SkF5dTh5U1cwNGs1cmtNazh1aFhiSkVuMWMyeUFDWk9PcjhUUno0QlpabEM3?=
 =?utf-8?B?dXBoR2hLNDFjZm9vSmRLUk5naENCNHZGM3dPZlc1c0lyS2lXY3NhUEs3WXk5?=
 =?utf-8?B?ZFZqWlZxOG5yTkRJbXRsMTNQMG1XRnZyM1BrYnV2YStaVEc3aGFFb3JxY2d5?=
 =?utf-8?Q?ijyCqSejHeqnT1QsQkd2M1Hiu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f6fd06-9338-4e47-8854-08dce90b8a9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:11:36.2310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH3qvshHdzYU+8zU3Wr4Wmx9QaeAAI+1OUwMTRBwwxCTwJJuBJjhM2qASbgcdweU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9525
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



On 10/10/2024 2:34 PM, Khatri, Sunil wrote:
> 
> On 10/10/2024 2:15 PM, Lazar, Lijo wrote:
>>
>> On 10/10/2024 2:05 PM, Khatri, Sunil wrote:
>>> On 10/10/2024 1:42 PM, Lazar, Lijo wrote:
>>>> On 10/10/2024 1:13 PM, Christian König wrote:
>>>>> Am 09.10.24 um 16:24 schrieb Sunil Khatri:
>>>>>> Before making a function call to suspend, validate
>>>>>> the function pointer like we do in sw_init.
>>>>>>
>>>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/amd/amdgpu/aldebaran.c      | 15 ++++++------
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 26
>>>>>> ++++++++++++---------
>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 12 ++++++----
>>>>>>     drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c | 15 ++++++------
>>>>>>     drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   | 15 ++++++------
>>>>>>     5 files changed, 46 insertions(+), 37 deletions(-)
>>>>>>
>>>> Original patch series is somehow missing in my inbox, hence posting it
>>>> here.
>>>>
>>>> Below ones are SOC specific files where we know those blocks implement
>>>> the suspend sequence. If they are taken out, then that needs to
>>>> generate
>>>> attention. But this check will cause a silent skip.
>>> Hello Lijo,
>>>
>>> I have not idea why the series has not reached you in first time.
>>> Second i did not get your point clearly, I am just cleaning up code
>>> which just return 0 and doing nothing else. I guess those suspend/resume
>>> functions were expected to be implemented but right
>>> now its empty and just an additional call in stack doing nothing and
>>> hence needed cleanup.
>>>
>> In those files, the logic is to call suspend resume of SDMA/GFX blocks.
>> The implementation is expected for those blocks. For others, it's a
>> 'continue' statement.
> 
> True. That why i have added a check first to see if the IP provides a
> suspend/resume functionality and if not then no need to just call a
> function and get return 0. Earlier there was no check and it just calls
> an empty function and that is what is changed in these patches to add
> check for valid functions and then call it and for those where no
> implementation is needed are cleared and i think this is fine?
> 

In a generic file (SOC agnostic) amdgpu_device/amdgpu_reset, the
expectation is different IP blocks with different IP versions may/may
not implement suspend/resume (as they are optional).

In SOC specific implementations, it's not the same expectation. Those
deal only with specific IP versions. Then certain things are expected to
be there. In this case, it's expected that SDMA/GFX blocks should have a
proper suspend/resume sequence.

Thanks,
Lijo

> Regards
> Sunil Khatri
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards
>>> Sunil Khatri
>>>
>>>> aldebaran.c
>>>> sienna_cichlid.c
>>>> smu_v13_0_10.c
>>>>
>>>> Thanks,
>>>> Lijo
>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>>> index c1ff24335a0c..e55d680d95ce 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
>>>>>> @@ -85,13 +85,14 @@ static int aldebaran_mode2_suspend_ip(struct
>>>>>> amdgpu_device *adev)
>>>>>>                       AMD_IP_BLOCK_TYPE_SDMA))
>>>>>>                 continue;
>>>>>>     -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -
>>>>>> -        if (r) {
>>>>>> -            dev_err(adev->dev,
>>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>>> -            return r;
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            if (r) {
>>>>>> +                dev_err(adev->dev,
>>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +                return r;
>>>>>> +            }
>>>>> I think we should probably create a function for that code and error
>>>>> message repeated a number of times. Same for the resume function.
>>>>>
>>>>> Apart from that the whole set looks good to me.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>             }
>>>>>>               adev->ip_blocks[i].status.hw = false;
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> index 340141a74c12..51607ac8adb9 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>> @@ -3471,12 +3471,14 @@ static int
>>>>>> amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
>>>>>>                 continue;
>>>>>>               /* XXX handle errors */
>>>>>> -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -        /* XXX handle errors */
>>>>>> -        if (r) {
>>>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>>>> -            return r;
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            /* XXX handle errors */
>>>>>> +            if (r) {
>>>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +                return r;
>>>>>> +            }
>>>>>>             }
>>>>>>               adev->ip_blocks[i].status.hw = false;
>>>>>> @@ -3553,11 +3555,13 @@ static int
>>>>>> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>>>>>>                 continue;
>>>>>>               /* XXX handle errors */
>>>>>> -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -        /* XXX handle errors */
>>>>>> -        if (r) {
>>>>>> -            DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>>> -                  adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            /* XXX handle errors */
>>>>>> +            if (r) {
>>>>>> +                DRM_ERROR("suspend of IP block <%s> failed %d\n",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +            }
>>>>>>             }
>>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>>             /* handle putting the SMC in the appropriate state */
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> index 3e2724590dbf..6bc75aa1c3b1 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>>>>> @@ -40,11 +40,13 @@ static int
>>>>>> amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
>>>>>>                 continue;
>>>>>>               /* XXX handle errors */
>>>>>> -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -        /* XXX handle errors */
>>>>>> -        if (r) {
>>>>>> -            dev_err(adev->dev, "suspend of IP block <%s> failed %d",
>>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            /* XXX handle errors */
>>>>>> +            if (r) {
>>>>>> +                dev_err(adev->dev, "suspend of IP block <%s> failed
>>>>>> %d",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +            }
>>>>>>             }
>>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>>         }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>>> index 475b7df3a908..10dece12509f 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
>>>>>> @@ -81,13 +81,14 @@ static int sienna_cichlid_mode2_suspend_ip(struct
>>>>>> amdgpu_device *adev)
>>>>>>                       AMD_IP_BLOCK_TYPE_SDMA))
>>>>>>                 continue;
>>>>>>     -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -
>>>>>> -        if (r) {
>>>>>> -            dev_err(adev->dev,
>>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>>> -            return r;
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            if (r) {
>>>>>> +                dev_err(adev->dev,
>>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +                return r;
>>>>>> +            }
>>>>>>             }
>>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>>         }
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>>> index 5ea9090b5040..ab049f0b4d39 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
>>>>>> @@ -80,13 +80,14 @@ static int smu_v13_0_10_mode2_suspend_ip(struct
>>>>>> amdgpu_device *adev)
>>>>>>                       AMD_IP_BLOCK_TYPE_MES))
>>>>>>                 continue;
>>>>>>     -        r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> -
>>>>>> -        if (r) {
>>>>>> -            dev_err(adev->dev,
>>>>>> -                "suspend of IP block <%s> failed %d\n",
>>>>>> -                adev->ip_blocks[i].version->funcs->name, r);
>>>>>> -            return r;
>>>>>> +        if (adev->ip_blocks[i].version->funcs->suspend) {
>>>>>> +            r =
>>>>>> adev->ip_blocks[i].version->funcs->suspend(&adev->ip_blocks[i]);
>>>>>> +            if (r) {
>>>>>> +                dev_err(adev->dev,
>>>>>> +                    "suspend of IP block <%s> failed %d\n",
>>>>>> +                    adev->ip_blocks[i].version->funcs->name, r);
>>>>>> +                return r;
>>>>>> +            }
>>>>>>             }
>>>>>>             adev->ip_blocks[i].status.hw = false;
>>>>>>         }
