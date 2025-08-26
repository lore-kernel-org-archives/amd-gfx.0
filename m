Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BBFCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 21:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C80510E044;
	Tue, 26 Aug 2025 21:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O4Z6kaVT";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24AC10E044
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 21:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvCS0wx7ONj1KAGk0nvuMt8L/D73L2wjqK3+UW6vRGqDgBNXzd184MWn/UJ4327OtDtV0SAFckadtAzGgTowXei8qIg6P/82hFJ8NuIrbSY2SD/ZuS57pfsBB0hn9iPoYd1WloV3scI4s5Qo4dtJlrj2eUO9RCzFgUBgP6Z/Sm2z6CjsY6qTv51zKGxZ6uuLIxHz9IserqHmSu//6AWqjLRUXashFCYHqUvK6mOIc2zH9j1yug9m4h+xOwtDDwTIDUEcgUJjoYsZep5m6yutVl97dk4FoaHNmL1w3Jl+vmtRKkSJrHsD8cLC08wLQu98RlZ3lkOivDh/ci7AuAOHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3ApA/Hrm7H+j++fN9uEcEa+gdEd0BtE/U1dJSgMgNI=;
 b=IpslLGj7NG3MlCfhuU1u/3ESDWXq2JGmdBqEA10U1ysxHvrqlV4aP7V1UNmN3ctXWo2QKRu9PfRkNYYOsJXq840UpWV3VgECC+L+SjCV0EHO3f3Uv+i4M5br9Qr7tfWJ5hqQTP/qzuj2KQDS7JJ55B/liTKzkCom1BhayHdT6A336XH2tGR7UXSgtqfXIU8rHL7AeUsznBMGLd34F1Q9Tws2BLV0QG3gK2UMGdkt1ZT3b1xmanhZ756acoKUQ3Mkw6D4SliSskz+nrTj9oq+Pv6McMTgf+HC4r7T4uFXGxZWj2thOQAPQg0wJdkqBMSffTVZyDiSYwPe9/28mAqJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3ApA/Hrm7H+j++fN9uEcEa+gdEd0BtE/U1dJSgMgNI=;
 b=O4Z6kaVTqcXl+wKeLgpvjk5vCH2S7kPvk/at+vrV45ykMtMYMJhqdho/d0V6aXf4aPG/rI8Wvsk4OlwFtMt6GSqbgAwgvv3ANyI3LNuU6cQHCDozQsbB7ONP9Yqi8Y3xLTs1LFtlcQ7ePb+QE+nNd7tplPD4wptmLQz5GVaZ/1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17)
 by SN7PR12MB7909.namprd12.prod.outlook.com (2603:10b6:806:340::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 21:11:56 +0000
Received: from PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041]) by PH7PR12MB7210.namprd12.prod.outlook.com
 ([fe80::54c:74b2:5935:6041%3]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 21:11:56 +0000
Content-Type: multipart/alternative;
 boundary="------------63xEkY1YNAjVQewEDh0h5F5r"
Message-ID: <1b21a8e5-7aba-48b0-8201-2db619c1e3fd@amd.com>
Date: Tue, 26 Aug 2025 17:11:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: protect potential NULL pointer
 dereferencing
To: Alex Deucher <alexdeucher@gmail.com>,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20250826193821.869445-1-David.Wu3@amd.com>
 <20250826193821.869445-3-David.Wu3@amd.com>
 <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
Content-Language: en-US
From: David Wu <davidwu2@amd.com>
In-Reply-To: <CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com>
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To PH7PR12MB7210.namprd12.prod.outlook.com
 (2603:10b6:510:205::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7210:EE_|SN7PR12MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 481c6a3c-e621-4e10-b164-08dde4e52ff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElHa2hZMUY4NStWVlh1TDdoSEY1ZkN4WEpOZEU3K0FoNjF1YThiTjRobjBW?=
 =?utf-8?B?eUZnYVA5K3laMGJ0UkJGWmU0L3ppUDN0L1huSFd2SlA5NnRjQzE3VlFWc1FS?=
 =?utf-8?B?UkVkRGlDeG53Tld6S2JjNzJXbThKMnpZbjhoWXgyeTlyZWJFOFJzdUJoUUp5?=
 =?utf-8?B?R0RlZEVMWXNZUVBjTTl1eUVkR202Z1ArQ0FmQ0dHTjk0bGZvSXNmY1FrbE1D?=
 =?utf-8?B?SEdaYkNPQktZekFFdXJIMlBuSXNtRTJhNHdzRVl2N1h0ai90NTFLeVFtSFUy?=
 =?utf-8?B?MUtrQ0VUNTZWV2pnTkNnN0xrd0IwUDU0R0pxMnB0TlA4THUzMk5iUlhSRSsr?=
 =?utf-8?B?b3ZMSHQza3NONkdOMWFrWXhaMHQwNkg5RithcnVqaEhMU3Z4elBVNFMwVkpp?=
 =?utf-8?B?c2VZRmhHa0krU2tUNVRrQk9hdXZDOVhjSzZ5SXU4NGhIb3p1YUMxWTluMGxO?=
 =?utf-8?B?QjBxM0ZCK09TTGpEZ3ljemk2b2tvV0cxY3FGSUJrYytIbjJrQWtEZWVjMVVZ?=
 =?utf-8?B?NGlvdzFYVU03bXNIcjBONHI5cmdQL1hUNFIwQUtGTFowWWo0WVozV3c3WUNz?=
 =?utf-8?B?M2ViYlBMbWFYbHhHZEtjY0NpTmJXbXFCWk5aUHNiWVREblpLR2J3aWhxazFx?=
 =?utf-8?B?d1k3UkZGa2s4WFlSOVdoaWQzR1VublZYTTJuSmp0S1FtbEcycUkxQjlnVi9u?=
 =?utf-8?B?S0crUHhNbXh5bFRJU2dCMHVZZjFjeklkbjE3ZWZnUTlqZzd5M3Q0THQzZ01p?=
 =?utf-8?B?NTFmUW5oM1JEQUdkN3Q4RzJ5VDZyQVJUU0VDZDMvSTVHTGNLWDVJNnU0c25i?=
 =?utf-8?B?RHNJZ01Pc1JXSTduakxHSDVGYUtkencxZnRoUkdrWTB4c3NoZ1FDZGZtUktF?=
 =?utf-8?B?NGJEaERKRklrdmRjT0dWV1M5TWNrQXBHYkc4RWZBNmFYZ1ZxRnBQbTBjMTB0?=
 =?utf-8?B?NzRhVDUwSEQ0b29tdFFtMWdyQTRSbnphUUE4bGsybWtNRmJSVWFmdm9iazYr?=
 =?utf-8?B?TURKVXd4SXFpMHozZVhrR2pMTVpmbHdjOGNnQkU5MGlPK241b2JVbXlnR203?=
 =?utf-8?B?YXo3VVgyRm4wOUswQXk2MUhNamFuMUtYR3dsVEI5aWVwSkI4QUpLRlBISS9N?=
 =?utf-8?B?TjNyZS9sbWhsZnRYRFpjKzMyYTdNdGVRZ3U4a0IwVzAzS0NtcFArTE83Q0RD?=
 =?utf-8?B?RGNhU3hUU0ZCMU1DWnpNMFY2c0p3RFk1WmVjTVFKcXBydjA1QmJFb1FJbXhE?=
 =?utf-8?B?b3pSVWJuNm4wQmh3eUs2VVNHbjI3MmxndnlNS25kU0pvQTFkejdYUUFtdWpr?=
 =?utf-8?B?MjRIUnRXVm5yajNOV1JZN1RSdlAxd1RCK3lmYkpxeHJXWDZocVNBRUNZOXdU?=
 =?utf-8?B?UHRBcHFwdGdmODFxL3VTNzNwL2puV3VhNm9iL2w3cFBMQWNqOVBmaVdVbjh4?=
 =?utf-8?B?UFg2RkdLSVRsdzQxbVRhMm1SN0JlbkdCUHBBT05JUEdyemt5MVI2a0V0Mm5I?=
 =?utf-8?B?SEhSbzRlQXdBaFZvRU5SNUhVbFp2M0hVNW4vWDVsazJLVU9qOEdXZWdHcWdp?=
 =?utf-8?B?bzJoRm1XZmxudEFjTGlQRzNtRkx5WEdaOW40T1ByRW9IZjM1akxpK1J4ZGxR?=
 =?utf-8?B?M3pBSHVMTENjNFUxT1o5UnB0NTBaOFR6Y2hNSDZacldFS1hLMDJRTENFV1Mr?=
 =?utf-8?B?WklReG1HOGxUK2FrWGFjVjNQN1h0MzZMaDZydTk0T1AzaWttOWJqZzM1V2Vs?=
 =?utf-8?B?MGVKQW5YS3kwSTJTcWVKdHRUNnZQc0g0MnYvVk1jUUZ3dklBNUhrTmFHWmRw?=
 =?utf-8?B?N1h1NzFqOW5UemRROGR6VURqWS9YQ3UzTUkya3dMcHV4dm9QQkp5NmFHcDYv?=
 =?utf-8?B?eThvdVpWaUtPQjRONkRLK2ErMFN0Yk5EdXkwTDNJTGNQclE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7210.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1g1d2RwbnptbGFoR1RLRThyV0FkcWo5N08wcExXMUJjbW1jVGVtRDkvWEdM?=
 =?utf-8?B?QlF3aWlyZ0JaWldCbTBiYXVialBVQlc3ckg5TlAyTjBtN0FUMXpZaTkwdHBD?=
 =?utf-8?B?NklSRmZxOXpkbUxDaHNNdFlqcktUZ2YrQnBOZmxJbjNycDY2aWh1QzFMWkFp?=
 =?utf-8?B?L2ViMTJ4NE1uN3Q0VXplZTdML2x3VFpKNFAvbXcwMHdJN0hMRzRKOTJ2bnVm?=
 =?utf-8?B?Nmhmc3VpNkU5eGVwNUN4Umc1N0JveWF2MXIvdUJObmhYUUF5b3IxK3h1ekJS?=
 =?utf-8?B?YnpUckdQdUd2Ti9zVCs3Nzh1ZnZKODdnMGR5cmRtQzNZTVVnSU1waTJUemNY?=
 =?utf-8?B?TkhOMlNVUlZ5UzJTYThmcEhjeHZua0VmdERNK1M5OWxDMk9vd0pOSG81eERN?=
 =?utf-8?B?SkFLZk4xUGtYTmQxc05scDJTT0JrRU15aDJuUVFNdjlmNGhYL0tod2wrNHd3?=
 =?utf-8?B?Y0ZSRndVTUxhT0lzTnVIVXhpMXFubzdaZWVFWllTa0pwUXhMaWhVV05NTy9j?=
 =?utf-8?B?V3ZDdnNIS2FOMzlzRkdud3IxR2RkbGQ1QmRyK3ZHYXFRN2dWVnFUZ3M0NWNt?=
 =?utf-8?B?ZFg0djh1NVgrYlI5YTRPY2lhYmowRGpzMDZ0WGJkUUZWMEQrQ0FTQTlTazhB?=
 =?utf-8?B?dnhtOFdLWDV4VE5DYjJJaVBrcW5qSXNOaGw5Z3p6NmpOUWxiS000TWUyQ0xv?=
 =?utf-8?B?ZXlndWNSajd6dVJZL1NLT2xHdU93OW9FdXJNQjMwU0ZkYlM1U1pkZmdkbE1w?=
 =?utf-8?B?bkNUbHorK28yL1NSdXJwR0tYcFEyUngzSFhUOWlpa2Y5OVFEaWh4SW9jQ3VS?=
 =?utf-8?B?OExBUTF4N3VET1QwMWdRVGlUREEwVnhRQldQK2ZDVDUvYXoyS3B2RzI1bmt6?=
 =?utf-8?B?a2xCanNYM3JFdUpRQ0JkOUk5RmhYVlNSaFFoV1ZqT3UwcDVXSzR1aDdNb3JW?=
 =?utf-8?B?Y0d0VEJNMzZEMk9tUHZyeGJuWEJ0dDZHVVdxNldJWUVEVGI0UGIzMXJiT0NC?=
 =?utf-8?B?NXdpYkpkRG0vekF0dnVBV2o3ejhTUjJGd2NCQ2w4bFFlWUVoODhFaDlyNCtY?=
 =?utf-8?B?dU9kTVhnZmJGeXBrVndMUEFzanlka05lNFUza2haSXpDOGVWQ0FkNElDamxB?=
 =?utf-8?B?cXd4WjFLUjJTY21GM3lGQitoNGNMaHU2bTcrTkgvQnd1UjhUZDFYL2pCVUp3?=
 =?utf-8?B?WlllYnI2bm9KNFExM1lsdlBJQ2lmRDJndkF2YzBJbVN6cnYxMlVlYno0bWxS?=
 =?utf-8?B?Qm1pRklKRkZHa1RDRGcyeS83Rnc2UlIyNm52RUNweC92RWdWRGtPTGpZdDlN?=
 =?utf-8?B?b3U4VHVndjFpVGt2cmZMU3h4Ny9MSExZZzdSSU4xa2JKUlE5L2JCQjU0Q1o3?=
 =?utf-8?B?WHFwVG0xZzhWOU1adHhLeHlKR0ZjRUQ5WmlwSnpmU1krNTBQZE00aEkzQTRx?=
 =?utf-8?B?dEFsV21TSVFYbHBRbUpRcDVoa2NlckxjV1BEdnU4SGpSdzczRlJGSXBoWjFz?=
 =?utf-8?B?MVN6ZVpqT0NvR3YvdzhEODAwTjBuOThkRnhoZ0RINzQwKyt3TTNvcTFDbDJD?=
 =?utf-8?B?dUF5MjBleU9lS2dmaG9CZFBIUzJxaERHUVJYVVdiL3JSUUEyZFduT0hLOXlz?=
 =?utf-8?B?ZzBVd29NYis4WkxRQWFIU3htbk5Lb2V2MGh5T3ZVVTJGRmxMT01YRURBUDVn?=
 =?utf-8?B?Y2k4RTZOMkEvOGNPbnB6UERVZDhLanhpSEltUVZDL3NOYU1Dd0hyUFpsdUFx?=
 =?utf-8?B?Vk8xdjBlcSt1VFkzTTZwV2xJb3FHdTcyZ0V6M2dVN2dSUGhJajlUcVJZTHpr?=
 =?utf-8?B?ZGQ1NTJIMFNnR0NSUXRIR1VyVVFzMldXZUF6ZkdpK2pZYXpqN3MyY3Yvem5w?=
 =?utf-8?B?Rmg0ZFpMYnVGcUw2UkFBcUVvM2FCdVRjZDBrWVJibFhJKzI3NjQxTzZpNFda?=
 =?utf-8?B?R3d2U0c1VVVMWmZPOHJpMDZQRnh0ejFCVWpBdjdpU21ocVdnc2twaGxLdEo2?=
 =?utf-8?B?UXRkOVZZS3lzS0FSTGh5WU1LVTJBT2RRUVlyYkRNalhxUDIzaVJoNlZwejNy?=
 =?utf-8?B?KzEwcE1QSlZOSG5UZVFvczh6V0xIbkJXUHlYaURyZEVGQTRiOXpmUVpmTzYz?=
 =?utf-8?Q?jlD8ypeldCmKUrreO8dK3RJtY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481c6a3c-e621-4e10-b164-08dde4e52ff3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7210.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 21:11:56.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UgMod2b/McynUmjXOwgoaYQWMxRFS7bZeUhIos+ZnFeMxhheqQyY2QzR8MliqRJuVuynd2/YyC1iIj2MQT0uQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7909
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

--------------63xEkY1YNAjVQewEDh0h5F5r
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-08-26 16:58, Alex Deucher wrote:
> On Tue, Aug 26, 2025 at 3:48 PM David (Ming Qiang) Wu<David.Wu3@amd.com> wrote:
>> to_amdgpu_fence() could return NULL pointer which needs
>> to be protected for dereferencing.
> I don't think any of these cases could ever be NULL.  The amdgpu_fence
> is a container for the dma_fence so it will alway be present.  See
> struct amdgpu_fence.

hmmm... but - the function could return NULL based on base.ops - see 
below if it should never happen then we should remove the checking. I 
doubt we will ever return NULL, however someone knowledgeable PLEASE fix 
it properly. The patch is only to protect it just in case.

static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)

{
     struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);

     if (__f->base.ops == &amdgpu_fence_ops ||
         __f->base.ops == &amdgpu_job_fence_ops)
         return __f;

     return NULL;
}

>
> Alex
>
>> Signed-off-by: David (Ming Qiang) Wu<David.Wu3@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 2d58aefbd68a7..1432b64d379ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>>                  }
>>          }
>>
>> -       to_amdgpu_fence(fence)->start_timestamp = ktime_get();
>> +       am_fence = to_amdgpu_fence(fence);
>> +       if (am_fence)
>> +               am_fence->start_timestamp = ktime_get();
>>
>>          /* This function can't be called concurrently anyway, otherwise
>>           * emitting the fence would mess up the hardware ring buffer.
>> @@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>          struct amdgpu_fence_driver *drv = &ring->fence_drv;
>>          struct dma_fence *fence;
>>          uint32_t last_seq, sync_seq;
>> +       struct amdgpu_fence *f;
>>
>>          last_seq = atomic_read(&ring->fence_drv.last_seq);
>>          sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
>> @@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
>>          if (!fence)
>>                  return 0;
>>
>> -       return ktime_us_delta(ktime_get(),
>> -               to_amdgpu_fence(fence)->start_timestamp);
>> +       f = to_amdgpu_fence(fence);
>> +       return f ? ktime_us_delta(ktime_get(), f->start_timestamp) : 0;
>>   }
>>
>>   /**
>> @@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
>>   {
>>          struct amdgpu_fence_driver *drv = &ring->fence_drv;
>>          struct dma_fence *fence;
>> +       struct amdgpu_fence *f;
>>
>>          seq &= drv->num_fences_mask;
>>          fence = drv->fences[seq];
>>          if (!fence)
>>                  return;
>>
>> -       to_amdgpu_fence(fence)->start_timestamp = timestamp;
>> +       f = to_amdgpu_fence(fence);
>> +       if (f)
>> +               f->start_timestamp = timestamp;
>>   }
>>
>>   /**
>> @@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
>>
>>   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>>   {
>> -       return (const char *)to_amdgpu_fence(f)->ring->name;
>> +       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
>> +       return (const char *) (am_f ? am_f->ring->name : "");
>>   }
>>
>>   static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>> @@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
>>    */
>>   static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>>   {
>> -       if (!timer_pending(&to_amdgpu_fence(f)->ring->fence_drv.fallback_timer))
>> -               amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)->ring);
>> +       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
>> +       if (am_f && !timer_pending(&am_f->ring->fence_drv.fallback_timer))
>> +               amdgpu_fence_schedule_fallback(am_f->ring);
>>
>>          return true;
>>   }
>> --
>> 2.43.0
>>
--------------63xEkY1YNAjVQewEDh0h5F5r
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2025-08-26 16:58, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Aug 26, 2025 at 3:48 PM David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
to_amdgpu_fence() could return NULL pointer which needs
to be protected for dereferencing.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I don't think any of these cases could ever be NULL.  The amdgpu_fence
is a container for the dma_fence so it will alway be present.  See
struct amdgpu_fence.</pre>
    </blockquote>
    <pre><font face="monospace">hmmm... but - the function could return NULL based on base.ops - see below
if it should never happen then we should remove the checking. I doubt we
will ever return NULL, however someone knowledgeable PLEASE fix it properly.
The patch is only to protect it just in case. 
</font></pre>
    <pre><font face="monospace">static inline struct amdgpu_fence *to_amdgpu_fence(struct dma_fence *f)</font></pre>
    <pre><font face="monospace">{</font>
<font face="monospace">&nbsp;&nbsp;&nbsp; struct amdgpu_fence *__f = container_of(f, struct amdgpu_fence, base);</font>

<font face="monospace">&nbsp;&nbsp;&nbsp; if (__f-&gt;base.ops == &amp;amdgpu_fence_ops ||</font>
<font face="monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __f-&gt;base.ops == &amp;amdgpu_job_fence_ops)</font>
<font face="monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return __f;</font>

<font face="monospace">&nbsp;&nbsp;&nbsp; return NULL;</font>
<font face="monospace">}</font>
</pre>
    <blockquote type="cite" cite="mid:CADnq5_MCiwaLJEXG1y9-D0v8naz0ZnNVurs-cQXBDvAyL+oXDg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">

Alex

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: David (Ming Qiang) Wu <a class="moz-txt-link-rfc2396E" href="mailto:David.Wu3@amd.com">&lt;David.Wu3@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 2d58aefbd68a7..1432b64d379ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -160,7 +160,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
                }
        }

-       to_amdgpu_fence(fence)-&gt;start_timestamp = ktime_get();
+       am_fence = to_amdgpu_fence(fence);
+       if (am_fence)
+               am_fence-&gt;start_timestamp = ktime_get();

        /* This function can't be called concurrently anyway, otherwise
         * emitting the fence would mess up the hardware ring buffer.
@@ -387,6 +389,7 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
        struct amdgpu_fence_driver *drv = &amp;ring-&gt;fence_drv;
        struct dma_fence *fence;
        uint32_t last_seq, sync_seq;
+       struct amdgpu_fence *f;

        last_seq = atomic_read(&amp;ring-&gt;fence_drv.last_seq);
        sync_seq = READ_ONCE(ring-&gt;fence_drv.sync_seq);
@@ -399,8 +402,8 @@ u64 amdgpu_fence_last_unsignaled_time_us(struct amdgpu_ring *ring)
        if (!fence)
                return 0;

-       return ktime_us_delta(ktime_get(),
-               to_amdgpu_fence(fence)-&gt;start_timestamp);
+       f = to_amdgpu_fence(fence);
+       return f ? ktime_us_delta(ktime_get(), f-&gt;start_timestamp) : 0;
 }

 /**
@@ -417,13 +420,16 @@ void amdgpu_fence_update_start_timestamp(struct amdgpu_ring *ring, uint32_t seq,
 {
        struct amdgpu_fence_driver *drv = &amp;ring-&gt;fence_drv;
        struct dma_fence *fence;
+       struct amdgpu_fence *f;

        seq &amp;= drv-&gt;num_fences_mask;
        fence = drv-&gt;fences[seq];
        if (!fence)
                return;

-       to_amdgpu_fence(fence)-&gt;start_timestamp = timestamp;
+       f = to_amdgpu_fence(fence);
+       if (f)
+               f-&gt;start_timestamp = timestamp;
 }

 /**
@@ -827,7 +833,8 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)

 static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
 {
-       return (const char *)to_amdgpu_fence(f)-&gt;ring-&gt;name;
+       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
+       return (const char *) (am_f ? am_f-&gt;ring-&gt;name : &quot;&quot;);
 }

 static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
@@ -847,8 +854,9 @@ static const char *amdgpu_job_fence_get_timeline_name(struct dma_fence *f)
  */
 static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 {
-       if (!timer_pending(&amp;to_amdgpu_fence(f)-&gt;ring-&gt;fence_drv.fallback_timer))
-               amdgpu_fence_schedule_fallback(to_amdgpu_fence(f)-&gt;ring);
+       struct amdgpu_fence *am_f = to_amdgpu_fence(f);
+       if (am_f &amp;&amp; !timer_pending(&amp;am_f-&gt;ring-&gt;fence_drv.fallback_timer))
+               amdgpu_fence_schedule_fallback(am_f-&gt;ring);

        return true;
 }
--
2.43.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------63xEkY1YNAjVQewEDh0h5F5r--
