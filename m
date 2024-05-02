Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74EAC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 14:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1725210FB59;
	Thu,  2 May 2024 14:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X6cG8vjO";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C222410FDC6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 14:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GP8UMZt9isE5Sapa2Oi0ij6SUCqMXxt67Q+/A/vs0W+AsITNkCqfyiRI1+wWAFeiq0ftH3zsoWn0M3iFVvNnCwToN8mF13/dlaLgcwhC7gR8dPnQeXhwi++V8JTAL3MzVESukYxbz0I06F+d1K7wcWfWBbZvytdBJfM+fvTFQPJ/sDQmL2t/oviipb3sywVFbCsg6gkjxgKK3NIGUBwc5cjpIsF/yimaR9I/E1CM2haDzTh6fFkfRJKtj1bB94fMJg1+fftaUGupYuFHSIj32CSGZoLiq7AsUpNEflWkUvuonGY2oPTp9Bl4/OhU2Lvc1L5rBqXmJJxQQQ09TucJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeFSBtOKcRsEqbdHhvkXeRbdgd75d4bMstybMiXh020=;
 b=GRdjjGvKQr4eFhbZB6vqeUXIWlpScA5wvgk7yBDnJb0sdJN7RyfOOQIU9nhqgcD0Ulc3huimikjDgmqHx0J+zCv/ng6WvdjIaK+yNMVbb5eCEw17LVIPM/abDXJ2auBIF3s3ppH2gjWpmYQ3MuQToAjEORV1KKuve6MyuP6VuqGzwLZnPVWevs1bOcV0755Tute+vCCC+k+41iJX32aJkuRhCS0/LVDNwdAyl59i0J7sRpptv3TNL7Dm2wQ2gC1JRgYtiwlf3jmOYzMXS6ezb9DG0DsSaxvjMGgqYbhEvcmac+zMr1hL2Ues5a7QRKwrNI1AYW2nA6PPvqAFTYMjcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeFSBtOKcRsEqbdHhvkXeRbdgd75d4bMstybMiXh020=;
 b=X6cG8vjOSZN++NRgjpDs/zVSPfrgQOls/2miYBrOH5Q6s8QwS1xvU0lnbjU/nA9JTWQRBFzKbdnuLIKJec26gy8uMqAdHqEJHPYfbudfdxLS+kfP7sQ7mvdHsYkgMdm/GqxsvWqYRrcy9Fo/vsW95ns4tmVFapuyl2M9CCdrkzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 14:18:05 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 14:18:05 +0000
Message-ID: <ac18b980-3696-f284-de4d-1af8cff92d87@amd.com>
Date: Thu, 2 May 2024 16:17:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 13/14] drm/amdgpu: enable compute/gfx usermode queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-14-shashank.sharma@amd.com>
 <CADnq5_OQHhmPZXsPdQfygAR3=EsWMB3r3n=Y0ajJFBhA+voY+A@mail.gmail.com>
 <1f34c3b7-0c3a-b83b-efe4-d3f5750cfa34@amd.com>
 <CADnq5_M2ErBmKHeg8hE-xsf_xZGWSZ-r35F8Py44yn+NNXSRwQ@mail.gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_M2ErBmKHeg8hE-xsf_xZGWSZ-r35F8Py44yn+NNXSRwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:803:64::33) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb4cebd-32a8-4d4c-3538-08dc6ab2af2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWRsNE0xeUFTMEdnQzNsTmJOenRWSHhFV3doNzN1YXY3MjlWNXRlNndVZk1C?=
 =?utf-8?B?RjhneW9sYXFDZ3k2Wmd1cTFmN0pxejFFM3lNWGlLMElocUFmMEJLdXdyQlJ2?=
 =?utf-8?B?ZHR3MkozNFZ2R1VtdTNneWloM1IrQ1VMejdZRHI2Sm5abG0wSzFVeDU2OWh0?=
 =?utf-8?B?eGcxSlczRUJVWFg1aWZwK2UrZE5lU1JCd09SRTRsNDRGK0lPUkRHZUFoNUNx?=
 =?utf-8?B?aS9YZ1BWeC9MZmxOY29Ra3BXOUp4S2Vhd0I3dHBVQkt2WmdTQ1ZWTWFJWjlo?=
 =?utf-8?B?cHlJTG9pWHNraHVjeGR4OUlVdFlDV3RJbGFSajZ1a3ZEcTc4czNQcWt3VVdn?=
 =?utf-8?B?YWtlVUg4R3NRMDlCeFVYRzU3c3lYV1pNcDRRcytFemV5WGdOUjdnZGJrNTlC?=
 =?utf-8?B?MHJsMm9TYWwxcTBSMVFwQXJxbWladFJJUFg0VjBjMVZCdy95bWwwUTUzbFRI?=
 =?utf-8?B?UnlodS9ZK1c3VFNuaGR1QlpHSWdkRUlyUHk1eWQwTGlvaVpHVFptRS91aTZp?=
 =?utf-8?B?WElsSUVNQ0dHRFBiR2hIY1AyNzN2bGUxY244NnBYRWJLSVhoRVQzN04rVDRO?=
 =?utf-8?B?ZnZhcVJOQlB4Smo0TXNrdlF3dmswZ3R6TG1kemp4ekZjVlBmbDlQZkEwSzdt?=
 =?utf-8?B?WUZVREdjUGM0NVNidzlPZmoxRXhEeWZFaGpVeUJuK0Q5ZGpQay9mVytKaW1N?=
 =?utf-8?B?N1RQTDlhdmRaNHNMcTNiMzk3ektsYXZCMVlmTTNTYVV3VTdHWko2dUlFTlVt?=
 =?utf-8?B?dlVEVDJEbmNIK3J1cEMwTjFucWRMbzEzajY5VmNtVisxbmVkeVJnTUxneWtu?=
 =?utf-8?B?VjNuSHFrSmQ2MTN3dHpDSlZZa1hucU01aGdwc1lFR1RvcTNYMEZlTkxoc2N5?=
 =?utf-8?B?VlhJNzdPUmRHQWFBQXZNZEZpaU56akJpT0prdWJYYjRiWm1BR3NqcjMrVmhm?=
 =?utf-8?B?MERwN3B5dk5zcDRpeDFOeitMdlNVWXppcER0SHl4c2hUUmh1N3M0bmtJaWNK?=
 =?utf-8?B?K2hGRlZOMWxhMFlwbGlubkVIME04cjA5VXB1RDVRME1SVW1Id3VqWTAzZ0Fi?=
 =?utf-8?B?NGJFOW00RkJpUDhuSkl5SWVMUmgwbVBuRjROOG9KaVluMFFHZGJIV3R1Q1pm?=
 =?utf-8?B?VStjNGtnOWg1YnVtcFRHdjZ1ekwwVjFzMWJUUlZ3MjU2dVpUQXI3OXdiRWpY?=
 =?utf-8?B?UW4vdmo4TmtwQ3NhTjlKWWdsSHE1QUtpeGxqK1ptK0hkM0h6Ulh5dTNlZ0tP?=
 =?utf-8?B?QU9Ob3A3bU1NZGc1QnQ5TEtiTWJaR0ZQOGw4MDZmMzNFbjRmQzBOMWE3Q3la?=
 =?utf-8?B?cGkrT3JITmxUZkg2bWw0b3RCYStHVTNCZElyRlNOKzBWOVdyc2FnbEFoTXBU?=
 =?utf-8?B?K1l6aUY5aXgzVHZhYzRFM1NHOVFCYy9lNk1lM0lKeklZM0VsdTZTQk10VWpy?=
 =?utf-8?B?ckRhaVExdzRiZ0E4N1N2OHZLNXJ0UGJlaEpOSnZ6T2N5dmZlMDdTd2wydkFE?=
 =?utf-8?B?T3BPSFdUeW43NWFabjBaWkFaZHBGZnhjQ25MSVo3Q3ZxMUhDVDl1Z0wyNHI2?=
 =?utf-8?B?dDU2RDhkNWJ6RHNOeWVJN1J5RXhZb2FvZkdKL0k3V2JyWFpuU2Q5elpxOVdz?=
 =?utf-8?B?dnN3aE5xakhSN05WcDZ5ZE1waEt1Nk5QVy9QU2FmOG44SkxmZE03RW9yaHhL?=
 =?utf-8?B?b2NZZXQ3RC9mZDNXelVsT3kyZzRYSkVDQ21leUlSWnFjenFwVU5FOTRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGdtWWcxZlN5OWU2Z0xJaEkrNFB4NldqK1FoYWdMdzZDVkJreDhSVlV3OG9G?=
 =?utf-8?B?M3d2UVd3MTZGLzZya04wQmFkaEFGaW11NEZJLzZaVWFvWm5KYlZ5NDNUaTVH?=
 =?utf-8?B?dmVNYUluT3pKSmxESGsyS1JIbXgxSlArWTNvWk5yM2tJVDA1Sll5di9aTlhh?=
 =?utf-8?B?Qlh3aXpJQzI5cVprUnZrZ2EzcUI0aHpsQWhFOFZmZTFMa2JHT1BKb2ZVYUxw?=
 =?utf-8?B?bkg4SWUrSW01Mm5OZjl6VDZDY2FBOTFHQ3MzZWVNalJNRmxYOVlTM1kwSHM3?=
 =?utf-8?B?bFhOMitLeUZKTy9zeHZrbVZzVis5b1hyd3Bxb09HSEZReWp5d0dOblY1OTdI?=
 =?utf-8?B?blBxK3ZtN0hmVEMrRm5tY3ZMenpVZWdmTEtlVHBxM3VPQjJDT21TUUFzR1Jo?=
 =?utf-8?B?YnVxakx3TWRsZDlTR3phM3h0cGROS0R2NkNZVGcvMlhScE5UR2ErcnlKc20y?=
 =?utf-8?B?VHIvdzdsS1NoYWJta3VjN3VVTVhhbThmWGVFaFFqRXBNdHg3VDUxOEhJbGhl?=
 =?utf-8?B?Ykh1QU9wK3ZUZDYyMDNCVkFOSjZ0cmlya28ycjFxa1hxV083UnZqOSs5Nm9X?=
 =?utf-8?B?SFZ6akZmKzR4YnVlaFJaNG1tTmdtQ0pVN2laRGJjM253SkEwWjVsdEJhRUVB?=
 =?utf-8?B?QjNZSVlzdFVURDk3NXNOaTJXeVFaamluMFdKOTVGcWNwL1JxMkZaWkllWWx6?=
 =?utf-8?B?ek1UZkx2U3QreVliVmJrSnZlZGZHZTZ1bmU1cHVHSk5XTmN2R0JoRjJhSTBi?=
 =?utf-8?B?Z3cyRkU0enlRckgrOVlUL0dxb2tEWWV2ZHlFMUJZakFxeWpIMzl4aTA2OVpS?=
 =?utf-8?B?dkdsSVRiZDdxK1lwVStEcTY0QlVQaWhEa2tqblJuaWoxbGhUdEc3cDQrWWVE?=
 =?utf-8?B?WFFVWTJJa1dtRGhRNkR1TDFKNURkNmI3Z3M3by9hNWt6LzNiS0dvV3VWWlJU?=
 =?utf-8?B?eGtJYUJlekRkd3VnQ2NwWnVMNUlCc1NSZ3VoNFBNTXBNWm1NMm9VVFMwZ0p0?=
 =?utf-8?B?NWdna1E4cGV5UFJReFNEWkZJNWY5SGVRaW1sRmlkT2twZlhVcjlJNE9jcS9G?=
 =?utf-8?B?S0txYzNoYVNHTkhOL2xjTDBYbXMweEdTeVhZNkZUQlJqQkhGaHRjTU1ZWlZU?=
 =?utf-8?B?QzE0NFd4N0pZTW1DVHNoSGRheGdIdkFsMlovUFF6QUl5RWRXa0o4MWIrdTQ4?=
 =?utf-8?B?QW9vS040eTd5OEd0NUorR00wc3cxNEQ5elAvS3k5Y3k5TXZUNjNDYUo1cm9D?=
 =?utf-8?B?VnBUTkc5QkFxT3pVVVFNQjJ1U3g4cEs3TmpPOTJRWkNRdGswQ2JoZTc1bTFv?=
 =?utf-8?B?VmE0SWN0YVEwRnh2d2ZoTWJVVnNhT1lxeEdFZTB6aU12YWVMVC9xTStISDZX?=
 =?utf-8?B?ZWtZc0libGhoVm8xWVMzSGhQSkRXNDBRSXZQbTVlUnFxZDducWhyWERRVWM4?=
 =?utf-8?B?Ymxna1grb1dWYzFiNWpneGk4Ujl3V1F6N2RNL2hyT1ErTFYxMmtmUEtwVWFF?=
 =?utf-8?B?M0ZCcU8ybUh4am5LZEw2WHdwR2hLOGJGbXF0WHNOb0R5cjFpUUV0U2k5dUxC?=
 =?utf-8?B?RmxYMDlMT0FQU0ZCd2RwckFEa3lxN0pndWxVQlRTRmEwT3k0TnBPbmtVdXJX?=
 =?utf-8?B?U0lvMDBubW9GZkVjZEgrZzlSRmhvckV3eGhlZWRaRlYwZ1pxTGxiMnBNMEhi?=
 =?utf-8?B?VmVlTlZISllPUGRveDVTcXcrai9kOXF4UWcyOUFHMGtvVnlhb0Rac3orMlNh?=
 =?utf-8?B?blZNZlduaFpPdW1HR0VZZXZVeU9sOE5yUm9KeVZsV2U4Zjg0TDZRZm42ckNm?=
 =?utf-8?B?eU1XQXBYTllUTUUvRklObnhTWmJmRnUwWS9QcXcxOURZakQ2ckNHaUowR3d6?=
 =?utf-8?B?bDR5S0JtZHBsTlpRNWRRK2N1cHZYM3h0Skkxb1pObTlrcDIralpmZUdydjRZ?=
 =?utf-8?B?ZHhGMkFQK2pnN2drNFRrem1rOG1HTWsrS0lNcEFrS0ZYZmpGemtnaGg1OEpP?=
 =?utf-8?B?bnkvNWZSN3dFR3hjRGVEb3pRYUM3QVpSQ1hod0IvWUVnU3Q2RlpybkgzV1Zx?=
 =?utf-8?B?cGg5ajA4alZkbWxvVi92UHFhMk83Y2REOVM1d1N4Q2tOeU0yUnZZd25iR0tO?=
 =?utf-8?Q?Yrwkg6ryzqV1EKGTm3+d5eBaU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb4cebd-32a8-4d4c-3538-08dc6ab2af2f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:18:05.8397 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hh8qLsUxoNrAJ6WFA0yVyl7vN5z5B7KMqgDhG/CZRxiRA+RkbbB6xNqKAIbhE7tnPpyEB6C+RwEopTlZjePKFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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


On 02/05/2024 16:10, Alex Deucher wrote:
> On Thu, May 2, 2024 at 1:51 AM Sharma, Shashank <shashank.sharma@amd.com> wrote:
>>
>> On 01/05/2024 22:44, Alex Deucher wrote:
>>> On Fri, Apr 26, 2024 at 10:27 AM Shashank Sharma
>>> <shashank.sharma@amd.com> wrote:
>>>> From: Arvind Yadav <arvind.yadav@amd.com>
>>>>
>>>> This patch does the necessary changes required to
>>>> enable compute workload support using the existing
>>>> usermode queues infrastructure.
>>>>
>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
>>>>    drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 10 +++++++++-
>>>>    include/uapi/drm/amdgpu_drm.h                    |  1 +
>>>>    4 files changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> index e516487e8db9..78d34fa7a0b9 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>>>> @@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>>>           int qid, r = 0;
>>>>
>>>>           /* Usermode queues are only supported for GFX/SDMA engines as of now */
>>>> -       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA) {
>>>> +       if (args->in.ip_type != AMDGPU_HW_IP_GFX && args->in.ip_type != AMDGPU_HW_IP_DMA
>>>> +                       && args->in.ip_type != AMDGPU_HW_IP_COMPUTE) {
>>>>                   DRM_ERROR("Usermode queue doesn't support IP type %u\n", args->in.ip_type);
>>>>                   return -EINVAL;
>>>>           }
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> index 525bd0f4d3f7..27b86f7fe949 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>>> @@ -1350,6 +1350,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>>>                   adev->gfx.mec.num_pipe_per_mec = 4;
>>>>                   adev->gfx.mec.num_queue_per_pipe = 4;
>>>>                   adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>>> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>>>>                   break;
>>>>           case IP_VERSION(11, 0, 1):
>>>>           case IP_VERSION(11, 0, 4):
>>>> @@ -1362,6 +1363,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>>>                   adev->gfx.mec.num_pipe_per_mec = 4;
>>>>                   adev->gfx.mec.num_queue_per_pipe = 4;
>>>>                   adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>>> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
>>>>                   break;
>>>>           default:
>>>>                   adev->gfx.me.num_me = 1;
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> index a5e270eda37b..d61d80f86003 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>>> @@ -183,7 +183,8 @@ static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
>>>>           }
>>>>
>>>>           /* We don't need to set other FW objects for SDMA queues */
>>>> -       if (queue->queue_type == AMDGPU_HW_IP_DMA)
>>>> +       if ((queue->queue_type == AMDGPU_HW_IP_DMA) ||
>>>> +           (queue->queue_type == AMDGPU_HW_IP_COMPUTE))
>>>>                   return 0;
>>>>
>>>>           /* Shadow and GDS objects come directly from userspace */
>>>> @@ -246,6 +247,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>>>           userq_props->use_doorbell = true;
>>>>           userq_props->doorbell_index = queue->doorbell_index;
>>>>
>>>> +       if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
>>>> +               userq_props->eop_gpu_addr = mqd_user->eop_va;
>>>> +               userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
>>>> +               userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
>>>> +               userq_props->hqd_active = false;
>>>> +       }
>>>> +
>>>>           queue->userq_prop = userq_props;
>>>>
>>>>           r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, userq_props);
>>>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>>>> index 22f56a30f7cb..676792ad3618 100644
>>>> --- a/include/uapi/drm/amdgpu_drm.h
>>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>>> @@ -375,6 +375,7 @@ struct drm_amdgpu_userq_mqd {
>>>>            * sized.
>>>>            */
>>>>           __u64   csa_va;
>>>> +       __u64   eop_va;
>>>>    };
>>> Let's add a new mqd descriptor for compute since it's different from
>>> gfx and sdma.
>> the only different thing is this object (vs csa and gds objects), apart
>> from that, the mqd is the same as they all are MES based. Am I missing
>> something here ?
> The scheduling entity is irrelevant.  The mqd is defined by the engine
> itself.  E.g., v11_structs.h.  Gfx has one set of requirements,
> compute has different ones, and SDMA has different ones.  VPE and VCN
> also have mqds.  When we add support for them in the future, they may
> have additional requirements.  I want to make it clear in the
> interface what additional data are required for each ring type.

Yes, this comment was also with the first understanding, so please 
ignore it.

We are aligned on the IP specific MQD structures now.

>
>>> Also, can we handle the eop buffer as part of the
>>> kernel metadata for compute user queues rather than having the user
>>> specify it?
>> Sure, we can do it.
> Thinking about it more, I think the eop has to be in the user's GPU
> virtual address space so it probably makes more sense for the user to
> allocate this, but ideally we'd take an extra ref count on it while
> the queue is active to avoid the user freeing it while the queue is
> active, but that can probably be a future improvement.

I was also thinking if the BO is expected to be created by (VMID != 0), 
so keeping it in userspace makes it aligned with other IP specific MQD 
objects.

Lets keep it for userspace, but will create a separate Compute MQD object .

- Shashank

> Alex
>
>> - Shashank
>>
>>> Alex
>>>
>>>>    struct drm_amdgpu_userq_in {
>>>> --
>>>> 2.43.2
>>>>
