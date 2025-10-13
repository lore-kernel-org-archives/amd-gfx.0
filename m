Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DFECCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4B910E3DB;
	Mon, 13 Oct 2025 07:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CrEhuV+z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF7210E3D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:19:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocUhVoZ0ovc23b1uBigIhd0mww3WtlnjQ1B9gaVtMUBCyGHNO6+R1Zi9itZ26zxzaoBm10rRfh14iE1Sx+tfdejjVWJ1wpUED5VDrn2FZAqPX7NoYLQibd2zZFxWTZVJ+DAZ5eiQztTlGPHM4YJy0K5IKJA7T+2a2SKZtZWkMNfeuhJpPzGxmVcMxbUkpehTfDuJH0370kOix7m7JH0mCi8BSCZrZ1jsJOFMSB992NnGbsX/j87TXGzRbAV9GaG0xBfqhpCsQjM37utwZkf0y8VKZFGziOVnE+vy4V/KycoHO4YfDzAdrkYmb1XS/r5Ph+EyKQ5UHMMhb2ZvL38r6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+HpQEpdrX2LpTivND7th1EhNIeydEoa6xSVkFH2E7s=;
 b=S38OWsm1h4kn7fdZgpu4zS7eyQx41NxJ/b9Tgnl+Jcn4eBgO05MiLJRW1mLdQ8mr1lfkXB6GtYhYhXA24Fho/fJkqosh6jluLLHyThKMda1fPjWR/AQT1F31oEEJUVT4p9UGOfR5dQGIB+teTBjdNGFQW6tlpdyDQlmN6KpWSBqyYeyb1eufu4V6QJzfs+KEuFmOyFt/WjVC6TDsNiYadf/E8pXIhTobvGv+OMncPsWYeWfSh0RGEQuiNlbgu18F6eOXSyZF/2ojRUIWhux1rTqI/U/xYXK9hLRpaX03fTP7hZvLtcyuzZjsqGJFH+R8gtUp/S8CUQf3Ls04l883LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+HpQEpdrX2LpTivND7th1EhNIeydEoa6xSVkFH2E7s=;
 b=CrEhuV+zJWWSUsAykR4B5SI2Vc7DnmCDwoYOjTayuLuu8P3i/yejDCqqrfZaptbdp2Z5tstNtKpuEcNiJD+/NcCm0ddpItA+SyNAec9Zjr3/SifA1g4DUVF3KxoCEMvdhNPtkKR2qSyE8sI0sB5c6W+rzouJibTjdQqCv2sDCRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 07:19:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:19:04 +0000
Message-ID: <b3655417-7b6e-472b-9a71-834361c4ac22@amd.com>
Date: Mon, 13 Oct 2025 09:18:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 2/2] drm/amdgpu/userqueue: validate userptrs for
 userqueues
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
 <20251010140712.3983709-2-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251010140712.3983709-2-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0870.namprd03.prod.outlook.com
 (2603:10b6:408:13d::35) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec718a7-bd14-4b71-0a4a-08de0a28ca21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFAvaTJVRmxKdUpjUDV1MENpdjF1cm01NzdMVllsQW9JRjF1V3FaWTVFR2hw?=
 =?utf-8?B?SWdiRk8wd3o4Tkd5cEZ2RkRPOFlzM0YzYit4eGVpTDJMaG1VODBMSDdtYlB0?=
 =?utf-8?B?ZjRKVnBSWWw1bGd6ZjB5V3A2aVE1ZU9NTVpHdlMrOEdOZzdtd2wvalJ3YXBq?=
 =?utf-8?B?bmZMdTRaQ3g3WjQ1a0ZreEFmVkc3OUxhem42VWt1TkVkUjE5NWxYbHJDeWpw?=
 =?utf-8?B?RDltdWlXYktDandSSVJJcldTeTVSOGFoMGI5dHAvTGpjVVhLcW4vU05NZjh0?=
 =?utf-8?B?REg4S0s1ZkM0OUZ3enJ0SEdrRzdGQms2YVpuUVlxYjFONlB2cFZaRzNkbEJ3?=
 =?utf-8?B?Slp4MUd3UWtJMEdjN0tuakxOYXJnNG9ZRmV1dXZZeHZQYXhXNWFCZGkrQTN3?=
 =?utf-8?B?dW5zMndRL2kzL3dwZ0pkd01Oeit6cXZMOWxFcmYxZjZWNnovYzE4ZFQwRTFn?=
 =?utf-8?B?citUUkdMNUdXSEo3a1FsZDhxWXNrUnNMd1o3eDNCajFhbHd3aUVkbVQyRGlz?=
 =?utf-8?B?SjdTUHozNW9GRDE2ZlM0dFFaSHVXV3VYYnJzUnRiS1RLeGE2SG80djArdjVp?=
 =?utf-8?B?VG1HUVNMdmJWUGtUTGdqRHprVnJmNmN1T0ozK3Jpb3k4QzRhbU1QRGdjcGRv?=
 =?utf-8?B?ZjNDZy9WSWJTcTlUaW83Zm01MGpydTRFakNISm9sNnFlUS9wRXhEVzlhWXVa?=
 =?utf-8?B?Nm5qcDhVQms2cHdBNHB5OVExQzBpcXlzUkRNMGxPYUhDekk4a05LMHQyampO?=
 =?utf-8?B?WTdRSWJYNHpETUNrR0s1WHEyejVwS0dMZVVoQ2NGYSswNGN1UUJvWWN5WjFB?=
 =?utf-8?B?ejhUbUwwaldGMVE4UUVQblNBTEtBdmF5MC9CTmNpRHZoSTYybmswNEV1UW93?=
 =?utf-8?B?WUloN0RaMHFwY0FwTWxXQmd6SkJRZGVCcjBSV0lhdXlzUTlYS0ZZTmp2SXBT?=
 =?utf-8?B?Qkg0SG1KTUp6bmhwOVJ1ZWovQjZicmtDY1l1bVE0UCt5aDF3dnFIWmdCaExF?=
 =?utf-8?B?RG5hUkNmTisyRzJoMmp3UCs1SFV5NXl2MHQrd1V0S3NlTVdqMVpWTGd6dEEx?=
 =?utf-8?B?YmlRaFBuYngwSWVBQ3I3YkJVZ3AwK3Z5WFhzMjNnd0tZV0M4a3pNWXFISm9N?=
 =?utf-8?B?NjFmMjZmRHdESXdyY3RwMkVPVWxBQmxyK3doWlE1N0VjVk5GQ2w4YmxJcjhu?=
 =?utf-8?B?MEptVWJ3c0xRL3l3OXl4Yktvb2pER0haMHU4OXZKcW9adTJ5SVpod1d0RXZt?=
 =?utf-8?B?d29aZWw5MzdRQlFpYmtFTjA1SjJJNnV0WnJaZExhTXltN0I3S1JqRFZOMG0z?=
 =?utf-8?B?c2dsNDc0cDFFV3pjUzZnNmE0cm92ZStrcUdDb3REWm01Q0VxbGVta1VuNmZQ?=
 =?utf-8?B?K3o4OUdPdS8wMk9IMUtTaVRlZHYrUzZjeG1iR1pXUFFFYXhBOHZ4YjdWTmt5?=
 =?utf-8?B?M1RGS2FNM1lubkh5SzBKdHZNQVRlcHRXNXNpb1l4NTl0dFlmaXVPUFpSbTd4?=
 =?utf-8?B?TXBiclZod0RUYmpWYk9Pd1FlK2ZxcnBmdzh2bUV1R1RVb1JINUZvWU9RR21z?=
 =?utf-8?B?d0ZBc1ovR3BkMHpKcWxhYktRWUZlMVVyd3lNTjVZTExncmJoMUM3eks2TStW?=
 =?utf-8?B?UTdhb3JUcUpJUDJBNkFLQmwrQ3JXdkU1UnRwazlSUFgxSWExN2FMOFl0L3ZV?=
 =?utf-8?B?YmIrRDlleTdGRHJYMUFjdmJacGJac3MyNyt5ZzJ4bkFlWmx4dW5pQVBYWDBU?=
 =?utf-8?B?M3d4cjhWT1BneVJaRVkrREt1QWpJV2hWK1AwSFcwVURJZWdtbXhUb0FGWExQ?=
 =?utf-8?B?K2pZdjNpdys0bHBpNXlwOFdheFBNc0o5MWRLQlpvQWtUUGRCVEhFSXptdHJP?=
 =?utf-8?B?WWFRd0ZOT1l4Y3dNcWthOENzMGQzUy9rd1ZOQnhYVm84WTN1ZkpjL0F3MUkv?=
 =?utf-8?Q?suN4grIThuL8wDJtjS1avZi311wTitu+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGd2eVhTc0tINjBBMlppazhpV3VrZ0VUbmVaTi96ejdvbWIxbitFOUpIRVpt?=
 =?utf-8?B?eExvVzczdkdYYzJ2SWpHL3UyTU1FZE5xZDVjMVZRaXhUaWNyRlRjd3pXTko1?=
 =?utf-8?B?VUVzdFVYWWZyV0YzR2VhUEZNbExudzVncDl0aU9qcTdvUEpLYWFFN2xqVVJH?=
 =?utf-8?B?ZGd5T1JxM3F0RGk5ZEI1MHdsNWd0M0YxY29ySlpTT0owRFVhMFBOdDFJSUwx?=
 =?utf-8?B?eno1UHJ2MWFnN01WMmtWRDhTSHhNYUdGSkQxbk8zZTRWNkYram43S2NCdkZ3?=
 =?utf-8?B?Y1ZGdUk1NkFWbW5FTXRZMkkxWHdoMDVKMjZaZnZQeUtmeC9ZaUNmK1lJaTN1?=
 =?utf-8?B?QkxtVlJLWVkxYjJKcW5PNFRVaFVEcUhSNWk2aGdicHRoRHRHclRJYmtjYTI3?=
 =?utf-8?B?cXVkcDJkcmowcnVrb2sxLzR2ODU2T0luYk9GMTdyaHZOaG9pSXRURDRCNDhl?=
 =?utf-8?B?TVgzdDNQanpmSXZMeEpzdDhqMUxyQmhETGpQUTRISlg2Um02ZUs2ZklFaU5w?=
 =?utf-8?B?YmxoN3pCdG81TmZVNHNLVi9BNXNDdTZlaC82VmE5VlJIU1kybmNBZDA5a2NX?=
 =?utf-8?B?Q2pReExkRml6dms1MmozKzVkV0NYdVRKbVVBdnZOSGE2VTMzUWdxa2dwYVNw?=
 =?utf-8?B?dHhXb0hVTVVSUUh3ODdMYm9hVWNIbkxXaE1PalhmMXB1a1NqWVNKNldhczRK?=
 =?utf-8?B?RzlOSXdsVXc4cjNhTFNVd2cyWk9jWVpRcnorUkQ1VFBINWhVem9aVXk0Z2VT?=
 =?utf-8?B?cUE0dnV2eFFrUFBWem9PQlRaUjlQYmpIUlorQW03dk9UWWJ2M1BHWFhSVWNV?=
 =?utf-8?B?MnVDVWw0aDBHU2VCYWxiNDFxZzdVMTdNYnJzSWhXOUJtL3hxR3A2Rno0VTJz?=
 =?utf-8?B?QUN6VXNjRlEyMGdCM3IxcFo5RGx2Z0J6UHVhcUw5b2lmYkZjNVRqZFBnZE9O?=
 =?utf-8?B?cndOUEUxWUFnWGdEZTA3eDhKTUZqc2RsWFNad1JYS044M0dLaE1zWDlTNzg4?=
 =?utf-8?B?ZEQzN1FVcVFIaEt2cEFXajVBTjYySjhUdFp0Nkcydng5RnBSdTMyQXlQYXo5?=
 =?utf-8?B?ZTk2WUVOWVRhTzBzdHd1RlJQWWl6QkRRbm5uM1MxQS9naGJma3VzeEI5R01a?=
 =?utf-8?B?LzRNK3lLNmJyMzYwdHFHRTRQbW55a2xuVDRJbzRhU1podS9ZM2xiU1ZiR2VI?=
 =?utf-8?B?VytoQ01PZllXU0Q2WFEyVnhpQjlnclZybFAveUY1RVBoWkhEUWx1bk1vbHlK?=
 =?utf-8?B?bmJDdDZVTVY2aGR5SHlhTnRCNXBSL282b2xiYnRQd2F5YXZNU0JyTllneDhv?=
 =?utf-8?B?THJqclg0SjB1SjY0SnBkNWg0QjZTV3VGUVVZZVk3ckRZRHl0ZEJONEhOOG5j?=
 =?utf-8?B?SzBZejhrL1JQWjNqeDJ1Qk9DS3Y4RUlianN1Y3RqUzRLTzhESTBGOWc3d081?=
 =?utf-8?B?KzVoekZ0dHNWRExpMGR6Y0V0TStVaGxHdko0TjkwZDgyU2hSK3hCdy9Ea2dP?=
 =?utf-8?B?c1ovZUl5STFDOXIwd2tWZEl1cGZCSkNiVE02RG5GWWwybnljUG95bHFSUFlZ?=
 =?utf-8?B?QzMzVFdsenlGRmNFVTRFM3BvVzloOGRMUGx6SE5KWXJxejZKUFM1Ykg0WUhS?=
 =?utf-8?B?bzJoV1F5MXBqS3ZFdGw0ZWtCQ2hGdlY2VS9rWUYybjY2RWwxNjBpSUkrRHJS?=
 =?utf-8?B?bmdJRStUUkpyRmNFQlBsWXltbHo2dEdnN0I0M1VTb1M0ZWFWVFBPWEhic3hC?=
 =?utf-8?B?S2FFN2FtbDFJbkNTVWtGZTBnRW11a2xnWkxVZFRWZUZ0WS83ckNhNXdybVg0?=
 =?utf-8?B?dVR5UW1QSkpXZEdVd2xhVktMc1UySWVoSGxZNmttYjE4MlRrcFNqUzBjMDdz?=
 =?utf-8?B?WDJPdEdlRlY3RkozSTFmTGxSWEgvY1hjUDFscU92djVtQkFaZ0J2bG5OVTRn?=
 =?utf-8?B?djN3SVdSTHUrM0x1TUJkOTdVMHlMNUhOeUlDSURGRzZ1Tjk2VlpwUVhuWTJJ?=
 =?utf-8?B?QzBOVnBJOC9TVEFjN2tOUXRHbTIyOHIvTXlrTzl3bkE5RzhYbnp3Q1ppcWZo?=
 =?utf-8?B?eEh0TUJqQ3I5bThQb0RSUllDbWdBWVBFNDM5Rlo3K2tpdFRBbzEzMktZZ3pW?=
 =?utf-8?Q?gIyZxR6no38ZFicSeTj3H8O9x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec718a7-bd14-4b71-0a4a-08de0a28ca21
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:19:04.1052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2t5eeMddKjhqJdnjTAhv8FOG24fiboGzeRas0xIUqo3jWeqZGAfy6+jyf9sPsfiy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

On 10.10.25 16:07, Sunil Khatri wrote:
> userptrs could be changed by the user at any time and
> hence while locking all the bos before GPU start processing
> validate all the userptr bos.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 74 +++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 8dc12064da49..e9f423cf11b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -29,6 +29,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
> +#include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>  
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
> @@ -758,12 +759,21 @@ static int
>  amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  {
>  	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
> +	bool invalidated = false, new_addition = false;

That could potentially be only a single variable, but that is up to you.

> +	struct ttm_operation_ctx ctx = { true, false };
>  	struct amdgpu_device *adev = uq_mgr->adev;
> +	struct amdgpu_hmm_range *range;
>  	struct amdgpu_vm *vm = &fpriv->vm;
> +	unsigned long key = 0, tmp_key;
>  	struct amdgpu_bo_va *bo_va;

Initialising key here is superflous as far as I can see and some automated tools started to complain about that IIRC.

> +	struct amdgpu_bo *bo;
>  	struct drm_exec exec;
> +	struct xarray xa;
>  	int ret;
>  
> +	xa_init(&xa);
> +
> +retry_lock:
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
>  		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> @@ -794,6 +804,63 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  	if (ret)
>  		goto unlock_all;
>  

> +	if (invalidated) {
> +		xa_for_each(&xa, tmp_key, range) {
> +			bo = range->bo;
> +			amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +			ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> +			if (ret)
> +				goto unlock_all;
> +
> +			amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
> +		}
> +		invalidated = false;
> +	}

Please make sure that this step comes before we validated all the BOs, otherwise we won't go from CPU->GTT placement again and the GPU would crash on access.

Apart from that the logic looks good to me.

You might want to think about moving the loops into new functions in amdgpu_vm.c.

Regards,
Christian.

> +
> +	key = 0;
> +	/* Validate User Ptr BOs */
> +	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +		bo = bo_va->base.bo;
> +
> +		if (!amdgpu_ttm_tt_is_userptr(bo->tbo.ttm))
> +			continue;
> +
> +		range = xa_load(&xa, key);
> +		if (range && range->bo != bo) {
> +			xa_erase(&xa, key);
> +			amdgpu_hmm_range_free(range);
> +			range = NULL;
> +		}
> +
> +		if (!range) {
> +			range = amdgpu_hmm_range_alloc(bo);
> +			if (!range) {
> +				ret = -ENOMEM;
> +				goto unlock_all;
> +			}
> +
> +			xa_store(&xa, key, range, GFP_KERNEL);
> +			new_addition = true;
> +		}
> +		key++;
> +	}
> +
> +	if (new_addition) {
> +		drm_exec_fini(&exec);
> +		xa_for_each(&xa, tmp_key, range) {
> +			if (!range)
> +				continue;
> +			bo = range->bo;
> +			ret = amdgpu_ttm_tt_get_user_pages(bo, range);
> +			if (ret)
> +				goto unlock_all;
> +		}
> +
> +		invalidated = true;
> +		new_addition = false;
> +		goto retry_lock;
> +	}
> +
>  	ret = amdgpu_vm_update_pdes(adev, vm, false);
>  	if (ret)
>  		goto unlock_all;
> @@ -813,6 +880,13 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  
>  unlock_all:
>  	drm_exec_fini(&exec);
> +	xa_for_each(&xa, tmp_key, range) {
> +		if (!range)
> +			continue;
> +		bo = range->bo;
> +		amdgpu_hmm_range_free(range);
> +	}
> +	xa_destroy(&xa);
>  	return ret;
>  }
>  

