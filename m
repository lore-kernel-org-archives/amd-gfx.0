Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29185C02193
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 01:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB97510E023;
	Wed,  5 Feb 2025 01:54:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I99mUgRP";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D680A10E023
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 01:50:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/Okhq1fJHxcOa2RbdW/Gak4XYv3A4F0QRSC5kw4q+ZxJXAybZ8KJbadG+XXoa/dnjN07xz23kQhwzDTC8hl7eljKEZi2xiP6OSNTL91QpBBq8gkb0/6oiHfWLRn5qDis+2xAYZmedNhRavZSkenhAOJEbX+GIuvo72zBGOxVr7ih3j9bzUfdOATR1kqTlzNkA1CHC2hGjL+gxAyu27xzjdfSWufHuS/AKj+n7N2volBJEV263s/LPIGVYBjFCWxOgGEl9AkkGS6r/aNrNzJn4XEJTT7+S0WkVtGrEPHZykV7FgvyQrCt6FCaflVI1QvzMowfaSXAJbXZ7SwtFEDWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqoqI1ZbgOiyRxPodOn99Jw+vwNjdegRfinyCNBRu1w=;
 b=SklcpQvwfW4hxtf/yNSahH7+9tON0TQ4JJqxD4/qXmSRSobRjYnYQSSGDcYNmTw7qsUdpAGYCekCeKM6xCPEULEE8DnffcGa3gNVmH4RDX6qmUcKApq4fXOUYln+tvjdo/xqlHgs1Ak15vfYhr4ApY9fdbKot+YnGgkIKfePtcQI4ZqoQ0fQQLiuiVFPKVZdIhJg7z6Fo3DftaBYlogOFDO5NTHoAUOYTa17NchEKlp1uRbA2iwzfRrkSdvBf0r5juOZPcmv/QqmGjcBfWsVWj4eW788LnwnI8ScGchPKZh+i3lF9plENUdA4O3W2tGimazAQ5IUkuYN8nsPAb3Ocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqoqI1ZbgOiyRxPodOn99Jw+vwNjdegRfinyCNBRu1w=;
 b=I99mUgRPxoxOUqd+tcxItB4KoHkhjxiqsKHWJ59EA5rka+Y8bOBDb3K5BBt69yVeaDT45nRiDYWy/I5b9dwA87w6pzUQ/DkZA0w041agCG7nfhj8FFqvEFhd9q6sALJLTZqFgEAJbRboec3IZuVEd1FyM9xBcFeDA7DwTT1oGOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 01:50:12 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 01:50:12 +0000
Content-Type: multipart/alternative;
 boundary="------------JPZ0zQa7KvPuuD4GBZ6pa8jO"
Message-ID: <3aed8145-8d98-40b1-ad63-e4896a189b7c@amd.com>
Date: Tue, 4 Feb 2025 20:50:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/44] drm/amdgpu/vcn: make powergating status per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-10-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-10-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::21) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: d24b4db2-7b9e-431a-90bb-08dd45876dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1k3R1dDUHppdUd2N2lacDRLd25ybU5rVnNub3ZMSzc5TUwvUkNmQ3FhbS9o?=
 =?utf-8?B?MUtoSzNYUlE5RkNwbW9Ka1E5VnlFUmFzTXErOVY5MTkvVzc4elZzZHlselB3?=
 =?utf-8?B?T3JKRENHNTJ2dG5TMWFkUENtZ0xJRHJ0bFhWL3I1SkZQY1FhZ00yZ3lFTHJK?=
 =?utf-8?B?T25OeXNYOW1jN2FhTmRaSndQWW12T3MrbW9JYmhzMVFtWDVRUFZ1UlU3V1Ju?=
 =?utf-8?B?Z3FRS0daZ0paemplYWI0ZmxzbUFUbjMvakEvdGJtRXg2bk1yQ01ma1lUVnI5?=
 =?utf-8?B?Uzk2azR3aHRlNFlHRlJPdWdHcitsQks1NEhSL082cjN3TzJ3ZTVHWExEUUFL?=
 =?utf-8?B?eUhkeHVmZVg3Y00wTThCcTY3ck9EK2kwcVhOaVhjRVFaTU5rTm9oT0hvMFpn?=
 =?utf-8?B?dHVwNzlSVTRiUzdHVy9MVHptWXFhYmpTNE1JT0hoNSs2U1FYL2ZUeVcwbi9V?=
 =?utf-8?B?YlkvWXcrYkNReWRORFV5TnJFbmlqS2FaRTJyeTJGU1RTUXY5Rk9LQ0c4M3BI?=
 =?utf-8?B?U1RvdUpxRXNaS0tXUFlyQk5jVGpNZU9VVkg4VGJCbi8wNjBSaGdNUm5qL3Qz?=
 =?utf-8?B?SkF2emVvL3BsNXpMNmEvY2V4ZE1hdCtXK1c2VmcrdUg0bWgvRXdDV2o3SjlN?=
 =?utf-8?B?anRMdDE3eVkxLzE1UENCemNWdHZUOENpdHRCcFpRbmlKeFBuODE2QUdORmVO?=
 =?utf-8?B?ck9GS1ZQNHFKQkZzMzlqcVZUTEVoZElSUGpuRUxVdjFTd2lZQXBiT1FaUVNU?=
 =?utf-8?B?ZjliVFNhU0RFdkdvSW5oYmVhTU9DV093YkJ2bUwzbVZUOE1qL1U2bGZIYXN6?=
 =?utf-8?B?SHdmY1dpWVBiaTJtb3IvQ2JZNm8xaWZReTRFR2dDT0JIdWNSNGJhYmVPNEVR?=
 =?utf-8?B?emN4NC8ybThRdUpwUndDVlpIS29mRlZRallkS2tTRXZpVmpNRGN6SHpBTGhF?=
 =?utf-8?B?dWI4Qk9pdW15ODhsZnB1ZFMvR0ptVE1sZ3YzMVRUZXhxcjFWc0xOUkVOQzVI?=
 =?utf-8?B?NHpuNGlaMGwwc3NQWTFCcUdaWGhqcnJPd0oyM09OVFMxRm9DZzlmazkrOUJz?=
 =?utf-8?B?Q01HV2FmYTBJcU9UUUloM05jSzkyb1B0Sy91ajM0WjNLL2Uxa3Btek1iSUpw?=
 =?utf-8?B?R0RPUnE3a3YxWjhlMHBGdTdMT1l6VVpKOVNvN3lBbHRQK2JUeGZtRElBZWp0?=
 =?utf-8?B?ckRjM3dHRWNqTU5KQTAxcGV5cjVzNWhXWDV1QWV4WVlEOTU5MTFTRnA4bmNR?=
 =?utf-8?B?M0xxYkw1aXhxV0ZUN3grQktOUTY4Zy9nQi9iZ0oreW5CSmU2L0RSNktGV0FK?=
 =?utf-8?B?TEVjSjJuQmZxWXlwdmFKbnNVejN4Nk1ZdG5WYkU1TDNhaVgrYzJYUlAzV3pU?=
 =?utf-8?B?S1FkMDZ0emxqODdZVHBEUThBc2ZWeWV5R0VNdU11bGJZZElTT0dmbFUxeHFP?=
 =?utf-8?B?VFFmazFNdnAwQ2RucnNRWm9ZY2RqeEwzWEN2ZjBkYlIwdC80YlhoSVhqRlNz?=
 =?utf-8?B?Z2VJZTdFZkJ5YTh2M2VHWG5KZ3g3ZTVhNkR1aGFYNWZiL0lDVllaZHFsNjFJ?=
 =?utf-8?B?SFIyZ2M0T1RBMTNvbXduOHlVVmNUWndDbUFpdXhISzYwR0VacnpLT2xJazg2?=
 =?utf-8?B?WWlHTStXeWFud21weS9iaVBjUnNlZUsvYy9VSTNMcDk4d1pBT2NwZ3NOTUpx?=
 =?utf-8?B?V01jclZxWE9EWndEZzlYYzZJNGtidEI2RHRLSjZIQ3NORThKRHB5bk5ieHY2?=
 =?utf-8?B?VmYyRDgzYS9SeUV2TjlzVlYyakFDQlN6VlhIYStaQ0o0ZVdqTnN0dUpCSjdx?=
 =?utf-8?B?K2ZYK3ExT2RZY3FsS05aNHNKc2g5UGVWYTdlYUU0b2Y0Qnl5MmxHVnYxYURI?=
 =?utf-8?Q?t1pDxEbjRUlAf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hTWEg1ZHBnWGZyYWU3ejlNWTMwMTZ3UmJIZElYc3diRDAvbHV3SDk3bTRz?=
 =?utf-8?B?Ni9sbzA3Y0xTYkpHdkY0eTNLOU4zYnVidDNMTm5hVFh1Nk1ZR2xxNnAxak1W?=
 =?utf-8?B?SE9rMTJQZmRGdm02cmtmbWZSMXNISXNQQ0w3UTNWeHNhQkcwdTU0Z0UvRkli?=
 =?utf-8?B?T0k0SWJuRmtHZkVsZU5oK0hCeTN1dXZ6bUVoT0NWZjk1Z2IvcDNWNW9pRW1L?=
 =?utf-8?B?R2oySlpJT3FFYU15T3kyUHdreVcrbzE2S3VPTk84QXVvVExvanFCaXpScUNU?=
 =?utf-8?B?UmtRNEdWM2Evbm1CRUFuRWZFQ296OFIvaVNveERnSThjczEwQkNHTDNUK2ln?=
 =?utf-8?B?YVcxd1VKbk93T1F0ZXdnNUk0LzZyMUFNaTRoSE1ySWd3L253aEx5VVRiWStW?=
 =?utf-8?B?Wk5IbGpmRWZHc2c0TlJYcEdiTENpK2VMWlg0WmIxYmpkdWFkRW9oK3FZUS9V?=
 =?utf-8?B?emVueVpuU1RVbkFLOGQ4bHAzby9Ra3k3SytUTDU2SC82NnZ3MjBCSXlRWDF5?=
 =?utf-8?B?RnhwcXZqUHRZZEUwMkFXSEJ3YmMvUExONENJUFBZNjdGTGpiMU9JUklya3NB?=
 =?utf-8?B?Z21BYVJTWDhhaGp6bHpUQXZUMEN1cTU4NC9mTDFKL1RMSlQ2Yk1mWHBnL3Ni?=
 =?utf-8?B?OWhtc044RFBNZ3FzUnNrdllrWmk4NWFXY2p2M0JGb1U1cFVZSmdMbkhOZzlS?=
 =?utf-8?B?aFpkekJpY2RJeGduQ1lCdHVYZ2VNTlpWSDhTdm9IeVpyOXpQR2V1SW1YRDkv?=
 =?utf-8?B?TEo4ZkswaWUxL0tFd2dqaWZGSGtpOUtuSmIvYnlScDRNVXNYVVROdjl1RmNk?=
 =?utf-8?B?YmMwQ0VZc3dod2ZwRUxhTFB5Q3pIb21jT3Y5TEsrM1JHSWZ4RVJQekpwcVJO?=
 =?utf-8?B?TFFJUGMveElSYUtNZThvencwY3FzSTdWVDYveDIwTFh3TWU0Nzl1U3lCS1Zv?=
 =?utf-8?B?Smh4N0FmQmVPV2JkL3R5cEdvSytSVXlSblVwMnppWVRyNHIzSFJiTWkxbnJN?=
 =?utf-8?B?dDRPVGZDUkF5MThCdlROSy9xMVF0aWhDTjRLTTBIa2g2S1FKM2U0b0cvWEVB?=
 =?utf-8?B?dzd4NU9ZZVhtc2ZEaVZ4cXpTSW95cDl1TUM0NE16SDRzZ2F3ZVJibUdOcWhH?=
 =?utf-8?B?OG1UdnhWSVFIcWFKRDd3VE1HOXhtWHhjanBNWkl1b3IvSkhXZER1dFlSZEhC?=
 =?utf-8?B?ZXFDYTZXQkVrejM4SWd4NGlZVG1FTkh2WHc3dGtHYjZyQ2NSdjJwTXZ5U2wz?=
 =?utf-8?B?d1AyZnBVaTh2aGN1WWpXcC9HRzM1N1pONWY4ZHo0MEFVWklCNHFmVm1kUUJa?=
 =?utf-8?B?azhOejNXKzQ3TmZPU3ZKbXY4cGxTTVlEc1BDMUsyUys5MmJNbmZGbTcvc0VQ?=
 =?utf-8?B?RHVNM1pXRGY0WFhROEN6VWFrRDNvQWRGUW9DYzQvbE41UUMxU01kd0FhUS82?=
 =?utf-8?B?dGI0SGZKSjhxUTlnQm12WUdBQkx2U0lnWE1obnlPNnFYVURZVkJpOG9QMjFi?=
 =?utf-8?B?R0ZRa2h4WHNjNytIMW9XK09lYStPVlBEMUREMTlPOWxjRytQV3JTUWg3dTdS?=
 =?utf-8?B?b1A0cGdIVVJ2b3M1dVdhaHllbnhNL1NCWktwTnNMMXFzeFErckhTME81TGlD?=
 =?utf-8?B?Y3RlQ0lFU09jR3VNL2hZbnV2YVhYcEVzMTNKS0p6aUp3OURWVitJd0JZZ05r?=
 =?utf-8?B?N1BCY08yZUppMXlTSWh5a216TlRDNG1kNFMrdjIzUitDU1RCMFhPM1M0WTdF?=
 =?utf-8?B?NWc1eEcvdGtONDRDaVUyWjBGWHRaS2FpVjF1R3lYenRqQlJRWHIxczhtREhm?=
 =?utf-8?B?Q3JuYXZpS0dJOHdBc0dIQlN3WFJmWlVSSzRhMUJwOWlOb2phc1BUUGRNOTFs?=
 =?utf-8?B?RGl0eFBCZTkySVM5c2hNdUdRSGFWY2pGT0Y3TkN6SHFlU1JSNVFXcjBubWMx?=
 =?utf-8?B?a1d4Z21EQ25ubXY5VS9Ka3FqOTczcWlkVkdrRVRGRGN5VXYveWdPR2ZhMVJr?=
 =?utf-8?B?blhpRktYRmtaQ1puZmc1U2FXRTE0QlpZM0xjMGtHb3ZBMm0wRUZyTVUxdHp4?=
 =?utf-8?B?OU0wUkgyZTM3QXhLTjA4T3Y1TmpiS1lGRXMyRVk5QzFQSFlBc2JMOGlSVWQ0?=
 =?utf-8?Q?NHtY4Y2+5pLFiMj4PhWkQgXYY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24b4db2-7b9e-431a-90bb-08dd45876dcf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 01:50:12.5760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5wr+YSOW/U5IruT2RLY0tvh+ETGZcFa4ljXXuPE403oIh0f/92bcltixKOud83vrkhfavSt01+45kLONY4ozg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877
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

--------------JPZ0zQa7KvPuuD4GBZ6pa8jO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Store it per instance so we can track it per instance.
>
> v2: index instances directly on vcn1.0 and 2.0 to make
> it clear that they only support a single instance (Lijo)
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   | 40 +++++++++-----
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
>   11 files changed, 241 insertions(+), 137 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index f1685283c2f13..0bcf4d1c7175d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -320,6 +320,7 @@ struct amdgpu_vcn_inst {
>   	uint32_t		vcn_codec_disable_mask;
>   	atomic_t		total_submission_cnt;
>   	struct mutex		vcn_pg_lock;
> +	enum amd_powergating_state cur_state;
>   	struct delayed_work	idle_work;
>   };
>   
> @@ -330,7 +331,6 @@ struct amdgpu_vcn_ras {
>   struct amdgpu_vcn {
>   	unsigned		fw_version;
>   	unsigned		num_enc_rings;
> -	enum amd_powergating_state cur_state;
>   	bool			indirect_sram;
>   
>   	uint8_t	num_vcn_inst;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index b90d41cd001c8..757cacf11a817 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
>   		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
>   		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   	}
> @@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	int ret;
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[0].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		ret = vcn_v1_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[0].cur_state = state;
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index a51691c6d6110..e55c1f8f260e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
>   
>   	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
> +	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
> +	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
>   		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
>   
>   	return 0;
> @@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	struct amdgpu_device *adev = ip_block->adev;
>   
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[0].cur_state)
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> @@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		ret = vcn_v2_0_start(adev);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[0].cur_state = state;
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 6fb08ed093101..1d3780a2d8513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
>   static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>   static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -				enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>   static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
>   				int inst_idx, struct dpg_pause_state *new_state);
>   static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
> @@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
>   		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>   		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
> -			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>   
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
>   			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
> @@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret;
>   
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v2_5_stop(adev, i);
> -		else
> -			ret |= vcn_v2_5_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v2_5_stop(adev, i);
> +	else
> +		ret = vcn_v2_5_start(adev, i);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
> +							   state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 70a1b85a4efae..13b9ed96cccda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>   static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -			enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>   static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
>   			int inst_idx, struct dpg_pause_state *new_state);
>   
> @@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> -				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
> +				vcn_v3_0_set_powergating_state_inst(ip_block,
> +								    AMD_PG_STATE_GATE,
> +								    i);
>   			}
>   		}
>   	}
> @@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v3_0_stop(adev, i);
> -		else
> -			ret |= vcn_v3_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v3_0_stop(adev, i);
> +	else
> +		ret = vcn_v3_0_start(adev, i);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
> +							   state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4a846c9a2b039..dbbeeffc90726 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>   static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i);
>   static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -        enum amd_powergating_state state);
> +					  enum amd_powergating_state state);
>   static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
>           int inst_idx, struct dpg_pause_state *new_state);
>   static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> +				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
>   				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>   			}
>   		}
>   		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
> @@ -2032,41 +2035,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -/**
> - * vcn_v4_0_set_powergating_state - set VCN block powergating state
> - *
> - * @ip_block: amdgpu_ip_block pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +					       enum amd_powergating_state state,
> +					       int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_start(adev, i);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_set_powergating_state - set VCN block powergating state
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					  enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 8343cee899c71..8396ef6831b69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
>   static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>   static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>   static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
>   static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -351,11 +354,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int i;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
>   
> -	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
> -		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
> +			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
> +	}
>   
>   	return 0;
>   }
> @@ -1646,41 +1650,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> -/**
> - * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> - *
> - * @ip_block: amdgpu_ip_block pointer
> - * @state: power gating state
> - *
> - * Set VCN block powergating state
> - */
> -static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -					  enum amd_powergating_state state)
> +static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret = 0, i;
> +	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
>   	 * MMSCH FW should control Power-gating and clock-gating
>   	 * guest should avoid touching CGC and PG
>   	 */
>   	if (amdgpu_sriov_vf(adev)) {
> -		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
>   		return 0;
>   	}
>   
> -	if (state == adev->vcn.cur_state)
> +	if (state == adev->vcn.inst[i].cur_state)
>   		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_3_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_3_start(adev, i);
> -	}
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_3_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_3_start(adev, i);
>   
>   	if (!ret)
> -		adev->vcn.cur_state = state;
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
> +/**
> + * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
> + *
> + * @ip_block: amdgpu_ip_block pointer
> + * @state: power gating state
> + *
> + * Set VCN block powergating state
> + */
> +static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
> +					    enum amd_powergating_state state)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0, i;
> +
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index e784f1457ee0a..f6b347fcdb7ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>   
>   static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>   static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>   static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
>   static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>   			}
>   		}
>   	}
> @@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v4_0_5_stop(adev, i);
> +	else
> +		ret = vcn_v4_0_5_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>   /**
>    * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
>    *
> @@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>    * Set VCN block powergating state
>    */
>   static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0, i;
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v4_0_5_stop(adev, i);
> -		else
> -			ret |= vcn_v4_0_5_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 03c7252e28ba9..c5d59edf3a482 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
>   
>   static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>   static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>   static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
>   		int inst_idx, struct dpg_pause_state *new_state);
>   static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
> @@ -288,9 +291,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>   
>   		if (!amdgpu_sriov_vf(adev)) {
>   			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> -				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
> -				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> -				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
> +			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
> +			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
> +				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
>   			}
>   		}
>   	}
> @@ -1260,6 +1263,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v5_0_0_stop(adev, i);
> +	else
> +		ret = vcn_v5_0_0_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>   /**
>    * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
>    *
> @@ -1269,23 +1293,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>    * Set VCN block powergating state
>    */
>   static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state)
> +					    enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0, i;
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret |= vcn_v5_0_0_stop(adev, i);
> -		else
> -			ret |= vcn_v5_0_0_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 5950ec4c7f6db..51a2d70a65c9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -40,8 +40,11 @@
>   
>   static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
> +static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i);
>   static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
> -		enum amd_powergating_state state);
> +					    enum amd_powergating_state state);
>   static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
>   
>   /**
> @@ -994,6 +997,27 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	return 0;
>   }
>   
> +static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
> +						 enum amd_powergating_state state,
> +						 int i)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	int ret = 0;
> +
> +	if (state == adev->vcn.inst[i].cur_state)
> +		return 0;
> +
> +	if (state == AMD_PG_STATE_GATE)
> +		ret = vcn_v5_0_1_stop(adev, i);
> +	else
> +		ret = vcn_v5_0_1_start(adev, i);
> +
> +	if (!ret)
> +		adev->vcn.inst[i].cur_state = state;
> +
> +	return ret;
> +}
> +
>   /**
>    * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
>    *
> @@ -1008,18 +1032,8 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   	struct amdgpu_device *adev = ip_block->adev;
>   	int ret = 0, i;
>   
> -	if (state == adev->vcn.cur_state)
> -		return 0;
> -
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (state == AMD_PG_STATE_GATE)
> -			ret = vcn_v5_0_1_stop(adev, i);
> -		else
> -			ret = vcn_v5_0_1_start(adev, i);
> -	}
> -
> -	if (!ret)
> -		adev->vcn.cur_state = state;
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
> +		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
>   
>   	return ret;
>   }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 51c2a7f4aba28..e8cf4aa6c43dd 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2037,15 +2037,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
>   	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
>   		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
> +	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
>   		smu_dpm_set_vcn_enable(smu, false, i);
> +		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
> +	}
>   	smu_dpm_set_jpeg_enable(smu, false);
> +	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
>   	smu_dpm_set_vpe_enable(smu, false);
>   	smu_dpm_set_umsch_mm_enable(smu, false);
>   
> -	adev->vcn.cur_state = AMD_PG_STATE_GATE;
> -	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
> -
>   	if (!smu->pm_enabled)
>   		return 0;
>   
--------------JPZ0zQa7KvPuuD4GBZ6pa8jO
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-10-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Store it per instance so we can track it per instance.

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-10-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   | 40 +++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
 11 files changed, 241 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f1685283c2f13..0bcf4d1c7175d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -320,6 +320,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
 	struct mutex		vcn_pg_lock;
+	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 };
 
@@ -330,7 +331,6 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index b90d41cd001c8..757cacf11a817 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
+		(adev-&gt;vcn.inst[0].cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[0].cur_state = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a51691c6d6110..e55c1f8f260e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[0].idle_work);
 
 	if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
+	    (adev-&gt;vcn.inst[0].cur_state != AMD_PG_STATE_GATE &amp;&amp;
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev-&gt;vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev-&gt;vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 6fb08ed093101..1d3780a2d8513 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
 		if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
+		    (adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE &amp;&amp;
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &amp;adev-&gt;vcn.inst[i].ras_poison_irq, 0);
@@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret = 0, i;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v2_5_stop(adev, i);
-		else
-			ret |= vcn_v2_5_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v2_5_stop(adev, i);
+	else
+		ret = vcn_v2_5_start(adev, i);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 70a1b85a4efae..13b9ed96cccda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-			enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
 
@@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE &amp;&amp;
+			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state_inst(ip_block,
+								    AMD_PG_STATE_GATE,
+								    i);
 			}
 		}
 	}
@@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev-&gt;vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev-&gt;vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v3_0_stop(adev, i);
-		else
-			ret |= vcn_v3_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v3_0_stop(adev, i);
+	else
+		ret = vcn_v3_0_start(adev, i);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4a846c9a2b039..dbbeeffc90726 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-        enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
+				(adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE &amp;&amp;
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2032,41 +2035,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev-&gt;vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev-&gt;vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_stop(adev, i);
-		else
-			ret |= vcn_v4_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_stop(adev, i);
+	else
+		ret = vcn_v4_0_start(adev, i);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8343cee899c71..8396ef6831b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -351,11 +354,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int i;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
 		cancel_delayed_work_sync(&amp;adev-&gt;vcn.inst[i].idle_work);
 
-	if (adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		if (adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
+			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+	}
 
 	return 0;
 }
@@ -1646,41 +1650,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev-&gt;vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev-&gt;vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev-&gt;vcn.cur_state)
+	if (state == adev-&gt;vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_3_stop(adev, i);
-		else
-			ret |= vcn_v4_0_3_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_3_stop(adev, i);
+	else
+		ret = vcn_v4_0_3_start(adev, i);
 
 	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0, i;
+
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e784f1457ee0a..f6b347fcdb7ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE &amp;&amp;
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0;
+
+	if (state == adev-&gt;vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_5_stop(adev, i);
+	else
+		ret = vcn_v4_0_5_start(adev, i);
+
+	if (!ret)
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
@@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0, i;
 
-	if (state == adev-&gt;vcn.cur_state)
-		return 0;
-
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_5_stop(adev, i);
-		else
-			ret |= vcn_v4_0_5_start(adev, i);
-	}
-
-	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 03c7252e28ba9..c5d59edf3a482 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -288,9 +291,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev-&gt;vcn.cur_state != AMD_PG_STATE_GATE &amp;&amp;
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev-&gt;vcn.inst[i].cur_state != AMD_PG_STATE_GATE &amp;&amp;
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1260,6 +1263,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0;
+
+	if (state == adev-&gt;vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_0_stop(adev, i);
+	else
+		ret = vcn_v5_0_0_start(adev, i);
+
+	if (!ret)
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
@@ -1269,23 +1293,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0, i;
 
-	if (state == adev-&gt;vcn.cur_state)
-		return 0;
-
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v5_0_0_stop(adev, i);
-		else
-			ret |= vcn_v5_0_0_start(adev, i);
-	}
-
-	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 5950ec4c7f6db..51a2d70a65c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,8 +40,11 @@
 
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -994,6 +997,27 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	int ret = 0;
+
+	if (state == adev-&gt;vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_1_stop(adev, i);
+	else
+		ret = vcn_v5_0_1_start(adev, i);
+
+	if (!ret)
+		adev-&gt;vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
  *
@@ -1008,18 +1032,8 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block-&gt;adev;
 	int ret = 0, i;
 
-	if (state == adev-&gt;vcn.cur_state)
-		return 0;
-
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v5_0_1_stop(adev, i);
-		else
-			ret = vcn_v5_0_1_start(adev, i);
-	}
-
-	if (!ret)
-		adev-&gt;vcn.cur_state = state;
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i)
+		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 51c2a7f4aba28..e8cf4aa6c43dd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2037,15 +2037,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) &amp;&amp; !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++)
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; i++) {
 		smu_dpm_set_vcn_enable(smu, false, i);
+		adev-&gt;vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
+	}
 	smu_dpm_set_jpeg_enable(smu, false);
+	adev-&gt;jpeg.cur_state = AMD_PG_STATE_GATE;
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev-&gt;vcn.cur_state = AMD_PG_STATE_GATE;
-	adev-&gt;jpeg.cur_state = AMD_PG_STATE_GATE;
-
 	if (!smu-&gt;pm_enabled)
 		return 0;
 
</pre>
    </blockquote>
  </body>
</html>

--------------JPZ0zQa7KvPuuD4GBZ6pa8jO--
