Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD11D462AF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 14:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2569510E718;
	Wed, 13 Nov 2024 14:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R9P29xgq";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8929910E718
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 14:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgzVJwfG4S1rSSPTOYz9q0j4dFxFpQhRxMUyitTeFCmgUsnexMJgF/qp+CN02Z4bkozGy+81t46KPYOyb+NXf4CHcBFMig8es+irdFmcv9a0gLc4u+JIOMnYQVXEhn1mvnz4tGo+DGa8K1Y8sqtGBdHaZXVLebwnViu7Asabd0F09jriA1DFScH8yohUubrqTisqhaVlNcfO9KwMTxMTKtUaNAOX2z1kIPWNtbm/E2rl1F+uMUZ1vUTvqbMNd9Ge4ji6L1lLWCh9d4YgiYlxSXEUV94iCNWPUdINBibs78oS94SPTxFZncHmQ52Jd7LpHmQDEnE3cffCfz57w2ZFKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys2eKPVG7ImJB/1vuIx31LaStKQ1Ck1u+XBndJVLJlo=;
 b=XLCnT/steUWxCXJ9tG8FiOcfpmu3flVhnAi1HtWSiHRXG8sepkqvUTAbWokTP7hBKtJeeYKp+13lFqIojPBRtCXQbTdf8ulqxB64deCI60RfvaAm/1Ey4Ar2LffrS1FJYrmCp7+BsIcMojZKB+Roi2jIMLVOmt/mohbI7Qe9L5XYtiPM7nKHRDOtRZXXkRdLlBihuswgP2fL73n9Me6+Mu+DJJNReZEpxsDoUYakuOvtH0wx/1HGGqqv0m1ezFXRWA1Uh4XcYxgAoWOO+6zXt71M4rZ4l0ucgKlsq60CwjOo3/Dz+xstpAO7nN6dNdzEUJBLOlINjNTz7YNkV7SSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys2eKPVG7ImJB/1vuIx31LaStKQ1Ck1u+XBndJVLJlo=;
 b=R9P29xgqrwadnpb4u4Ww2Piui46hNlxTbm43jE+4gTMi2XG8WDWIJJeZHlH12i9ydZcoETQLk45AzI8xC5wY3J9XBzb+FBDuzgYGuo6StiFW4gpCtT8g5DclrhSzrTDUW2WbNqYt163GiBtfV/vwr7mdm72nBxgmuwYCFXC5uwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:27:03 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%4]) with mapi id 15.20.8137.022; Wed, 13 Nov 2024
 14:27:02 +0000
Content-Type: multipart/alternative;
 boundary="------------8Ol0lMGabPK6D9j43nN1m7zM"
Message-ID: <2b71c0c4-9820-4f03-8454-5d9ffd3ca025@amd.com>
Date: Wed, 13 Nov 2024 09:26:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdgpu: add the argument description for
 gpu_addr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
References: <20241113090705.741598-1-sunil.khatri@amd.com>
 <20241113090705.741598-2-sunil.khatri@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20241113090705.741598-2-sunil.khatri@amd.com>
X-ClientProxiedBy: YQZPR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::28) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b1d19c3-71e3-4667-47c0-08dd03ef3d4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWNQVE1yOGpTN1k5NFpHQ1NNZllENUthdDQ3Zk1pS0Q3cUdqZzJuM1RBYU5Z?=
 =?utf-8?B?QldaVHEraU40aHVEM2JTeDUyVG1yUnNwWlpMTnBtUThIa1VHV0pBckQvTHhm?=
 =?utf-8?B?emxVS2xOWlJ0Y201U1Jxb29Xazc4QVVYWXdiYWpSL1h2QmVCbXRLL2NmVExP?=
 =?utf-8?B?LzE4cTNTNDlmSUtVeXBJYkovUDhmbTVYeklrVHcyYnFJTlgrNFhhMThDVHp5?=
 =?utf-8?B?K3BlSWczRkFOZ01VRDlXUE9lTzhoUmhSTFcyRmlzVzBXMGVwdVpycHU5UWN2?=
 =?utf-8?B?UHUwQ242TVpYMXBsUzIvYzZWQVBjSE9mQlJ2SDExY056UUt2R1F6cVNYdnc2?=
 =?utf-8?B?SlRGNlNTOGVWeEpoVW8wWEQvaGt4VGRWNjFvT3BOakxLbEpheHY5eTB1Z2RS?=
 =?utf-8?B?bUU2NXF6YXRsZmRhRWFDYkRSZ2FvQUpPd2hrTmFOWC9jY20xUEVxelBPRGJC?=
 =?utf-8?B?U09UazFyaDFOWEVSdUlocUlQRVFaZDJqSVJrOWdRckIzLzJGM2pjRkNFV3Ax?=
 =?utf-8?B?NnNORkJ5cDR5ZC9XcHZqWWpVQTkyT0hqVzdTR0hVWmdCLzhFTUM4b2NHQ05G?=
 =?utf-8?B?Zy9ObzJ3UmVDMjU3N29tLzYzRmNXdXRQaGJYNEpKV1YyUjQwWCttOEg4Wm92?=
 =?utf-8?B?eHVPWGYwQVQvNmNBbE9iUHhadkZuV1NPM01UbUdtdWt1cTNZZFJ4eXBSeU03?=
 =?utf-8?B?RmZXdlFDWlp0SHlpOThrRERDNXdlRUJ3LzlUenlzRnFNUENiYlcyU3NXbndP?=
 =?utf-8?B?SHlPcFJkNWhCZG93bTRlUjZ2QUkvVU1ZWXpTQzJBUjZraUdKcG9tR2VoRndm?=
 =?utf-8?B?TytaT0xJK04wUXloOGJrRVdtZG0yKzNpSFRZRXcxQTUzUXJLT284MDVlYzEv?=
 =?utf-8?B?ekFFK0oxRFhyaWhFd2c5VmZuMXNad2VKUjZtMmUyUENtUHYyVVU5T0c0Njl4?=
 =?utf-8?B?NjFKaURPOE9hMHdDMGdlZzU4TzQwcVYvcTRZd2lZdDFzMnpnSHpDRjdocFlh?=
 =?utf-8?B?UkRNQWxINllxbzluTDd0bkt4QUJ4ZXlKMGhxMUc0VUp0dE9CcmsveUFVWDUx?=
 =?utf-8?B?MXBtQWU1VHN5L29aNStwN3lSam9xK25HUFBPaEs5aURKVUdWNGcxdTBWZXJN?=
 =?utf-8?B?ZHlhMzdRTXA4V1h6MHJmOGxVd0x4bnM1QTJvTVBGTVllZVBjYzFhMlplcCtH?=
 =?utf-8?B?S3YxTFFraEY4V2tmZ3lSeDRlTFRISlVFMVU2UkZyZGxpcm5GKzFwVEFHMTJW?=
 =?utf-8?B?bFo0TmpvZkpXZkUxZE85bERVRG5KY3V0ODFFbGJzVmVtQWw0ZkRIdjlVUHA3?=
 =?utf-8?B?L2lEU2M2bVp6S2w2R2dtWGZ3Nnp5cStCWUEwUUhjVmJxZGNhMEpUNUpDNk45?=
 =?utf-8?B?Yzg2MS9wazFRUVVKK042dGtBZVJFOEZQbjJaT01FbERSSis0TFd1ZjZWaFZ1?=
 =?utf-8?B?aHEyMDdHUGZpcnB5MW9POFJNb2g0cTBtblJna28yUVZHcEpZaDV0Q2I1YmRZ?=
 =?utf-8?B?dUY2aUUrTWx4ZWtFT3NHWVFtS0Z3a2JuUGRkeGFvY09memFuU044YzVVcWhW?=
 =?utf-8?B?Kzg1TXFMMmwzcUpoek9ZVDhNNmFpOHltbThwQXZ5UWoxaCtyUXUyaUhSNDJo?=
 =?utf-8?B?d1hkbVMzQWI3ck9tLy91Rzk5TXV1Rm10blgxbnU1Z3lMUmVyaUgvNS9wakFX?=
 =?utf-8?B?bHkvRUdPM3NzaXQ3dVR0MHdFcFhFY0dGcXVKZmpSS3o0a1d1OVpDbzMyNGxp?=
 =?utf-8?Q?e44RdUPCZsEk3EAjHPskvhQXuZf5eXtMDLf0mzp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9EV1hUK2hlVXJySlJhOTh1Y2dhNjBaRGFsZ081MGlKTTFYSmVzZEVBUjdx?=
 =?utf-8?B?d3FEaWF1NFVaaFBYa2pGMW1tRFg2RnUreC9nTysrQXQwbDhuNDFuSFk2S3ZI?=
 =?utf-8?B?SW5PZUV6OSsrQ1JpM1Q1SjBLQUx4Y0FOMnFtaE45TjlRMW12OC8rV0RXU1d2?=
 =?utf-8?B?STUyOEplL2NleWVvMmRMeUNIVm5najNvd1hDMHAzdnlRdmZCNjZ6ZGlxSk9z?=
 =?utf-8?B?WHlTRi9TWnlJV2JhZCtIL2hGMU1VQmppZ2FRSkdmcDJTK0FsM1crY0xlc2F5?=
 =?utf-8?B?aC9ENGp4RU1LOFNnZm5PU1JZNkJtdFRpNTViZElvd3ZoTFN5MXFGVmpUUjVZ?=
 =?utf-8?B?ZGFEcnFtdUs3M0d0S0tsK0htL0lJN3BNYVNMMWE3UXI1eWhvbFpVL1BFTHVX?=
 =?utf-8?B?b09IdFlNN0hrbU9XVVRHSEpjTUROYWtMY1RGNHdvd2ZpaWdSR1V1UnJXZGpa?=
 =?utf-8?B?RDNyQnFrc0NzZHo0MXdHcnBHNmZFbE91eTlaclV2ZzFtMitFZzIwR2cwakdE?=
 =?utf-8?B?UTFBQUk5TDJhTEVzYXVFTUlVMWg1NHYxQVhHZGYzKy83TEVRekpNN1lhZlM0?=
 =?utf-8?B?cXpCNjk1Vzlzb2hNbGVBRmZ3VXBSY1lOS09TL3BEMmNJbXFlNkduZkE2ZDll?=
 =?utf-8?B?bFVOSGhHZUQ3ZFRkNC90MXNaQnhDQ3FBeW9hVjhzYko1K0NlYVRuZTd6RXFt?=
 =?utf-8?B?MjNoZkFrQklyVGh3Y0VPYUpjVTZFTFJsbUJYTDdlcUVoaW85ckxqTFhqZFg3?=
 =?utf-8?B?NC9UR3MvTzVOMWdrdTRHK2t2TlBxVHlZT2wzMzN4UnVUWUlCMlYyb2JWZ1VL?=
 =?utf-8?B?V2EvWnNMYW8rSjlIdUdlbW9qYVFCSDg3bzREaUNnMkJIN1p4U0N5VUNralYx?=
 =?utf-8?B?NDlFWFhTR0JxY0JmSGJIM3NsTUdSN0ZwM3Jmc3hWQThYNW53N3h1V0JQeGZu?=
 =?utf-8?B?eXhMY2ovOHVPMFJSK2dDMU0vNExYeWR6dVhLQm9FajJlZkNNdWY2MFhKQ1Zk?=
 =?utf-8?B?cEwyODZ3dk02bDZpV2oyYmRqdWhEK01PVGtSZWFqRU9HSVY3RzNyKytwRTJD?=
 =?utf-8?B?M0FqMk52TFBQSTZic1FVdzFBNlFIQkQyaG5aN2VvaXN4MlpnN2NnMlNMWlhO?=
 =?utf-8?B?RlZJWmJYcTRqTDZaeHMyT3JiTFZObk40NXAxeG92UWNUNkFhZWxzOU56MHFo?=
 =?utf-8?B?a3pINXJoYTF2U0NEaGpXSkRlaTZOVkVZcksxaVRyYXRGaWxLM3dDNHlSU0sw?=
 =?utf-8?B?bUR4N2pLTCtIVjVJVEQ5aHNZNUdMbjIzajJRZ3VhLy9Ka1h5V0taUnR2UEla?=
 =?utf-8?B?bWl0QUJpYS9nQXh4RHZGWGJTWW5HTE1uckNYOVdhWmNKRUlrT1owcXp6aTJm?=
 =?utf-8?B?UlF2TzRqR2RsNEpKU05uQStSNlprQ0Q3Z3F1U3ZsbmxNRUpKVURUZUhxZWwv?=
 =?utf-8?B?cDVueXNwV2o3M1ZJemwvMFBJYVYyemluMGFCZVdUK1NWYTlQRFZ4Mkp0MDBL?=
 =?utf-8?B?bCtYbEMyUXpFMzl6bk9rTnN5ckp1NFlYdzhTckxvNHlRYWZSdlJLWnlkZURp?=
 =?utf-8?B?Mms3Nkt2MlJWY2N4cm5mSkt3UW9Va0M5d1Z0YWpCSkY0NkNHL0JGUUJGU1FP?=
 =?utf-8?B?RUdodVQwR0FMWDFGcllpaU1JN0RRN2pmazAxOGVmbDFnRmVsNmdKLzE0dTJr?=
 =?utf-8?B?cC9UMkJteVNCS2prVldWUkQxaHhyVjJoM2ZTWnF4QnlwWW1haHRyM1N0MzV3?=
 =?utf-8?B?QXFxUWhmUFlBMVRJWkFXZWFlT3hOODdpTDRIWWh4bjhZYjZBKzZjMWNFOGEv?=
 =?utf-8?B?U3NwWkdnK1k5RWs4Q3lEOGdybUkzWlBsUzA2YWd5SjhnU0FmMnNNdlIvVGwx?=
 =?utf-8?B?MkR6TUQvenVyeWQ3enNDckcvZ0VLaVZKUlFMUVg5M25IbVViWDFIVG40alB0?=
 =?utf-8?B?TjdWWWNqTElKZ1JwUEhObkNheE5NTGJuRVRpUkZsR1MrMENWR3YwcEY1amNw?=
 =?utf-8?B?cFhVazdJR3d6VGtNU28wRml6M0FhNWlTcFd1OThnSXFPRTROMUZGTHpQeGVR?=
 =?utf-8?B?TUYyMDFhNmZyNUVrcFZSZDB4a0tQK1d1eDBNaTMzVDNVRWhYTjY1bFVPcXVv?=
 =?utf-8?Q?8xfaRJ/YG5X4/VYgmJWo1IS83?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b1d19c3-71e3-4667-47c0-08dd03ef3d4e
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:27:01.9403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBiXiyp5LmJDRsBXs/nk84rN1NF+lH7mt+9xR4eFGsjBCgJw6MygTHph351VUoDZ0HMf82/U/RDNhkLZe2N+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781
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

--------------8Ol0lMGabPK6D9j43nN1m7zM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024-11-13 04:07, Sunil Khatri wrote:
> Add argument description for the input argument
> gpu_addr for amdgpu_seq64_alloc.
>
> Fixes the warning raised by the compiler:
> drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168:
> warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc
>
> Cc: Arunpravin Paneer Selvam<Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> index 0defad71044c..898d215a8d99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
> @@ -156,6 +156,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
>    *
>    * @adev: amdgpu_device pointer
>    * @va: VA to access the seq in process address space
> + * @gpu_addr: GPU address to access the seq
>    * @cpu_addr: CPU address to access the seq
>    *
>    * Alloc a 64 bit memory from seq64 pool.
--------------8Ol0lMGabPK6D9j43nN1m7zM
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-11-13 04:07, Sunil Khatri
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20241113090705.741598-2-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">Add argument description for the input argument
gpu_addr for amdgpu_seq64_alloc.

Fixes the warning raised by the compiler:
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168:
warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc

Cc: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" class="markz4gub081a" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span>:
          Boyuan Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Boyuan.Zhang@amd.com">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20241113090705.741598-2-sunil.khatri@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 0defad71044c..898d215a8d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -156,6 +156,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  *
  * @adev: amdgpu_device pointer
  * @va: VA to access the seq in process address space
+ * @gpu_addr: GPU address to access the seq
  * @cpu_addr: CPU address to access the seq
  *
  * Alloc a 64 bit memory from seq64 pool.
</pre>
    </blockquote>
  </body>
</html>

--------------8Ol0lMGabPK6D9j43nN1m7zM--
