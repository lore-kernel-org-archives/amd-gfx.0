Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F7D3E2DE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 07:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A72E10E5C3;
	Tue, 29 Oct 2024 07:57:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VZJkhsju";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529A010E5C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 07:57:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdKkWK8EMoqXzvs1f7INvIVWYDqr1WMf4G6KzUnZqgio6slES2uB6LCvANWefvDhTqphmBfM6KERI+JP5A4/wUliNYFRDLWoSJS6kgwg51ZIp3ZJ4e1xqgtjql8Qdi+ta5ISWwuJVST62r7wKmeCIrNVFXxJR1qnTV9VH1N1nTnmC/V5Prl4l2Eeh5Zta0IhlEqqQA2nsaqLcj0FCyytRgT/6c5BdS3s36Pz8IlUH4BptLkDTYa3FEd96VATX/BxBpaJkoQHSRV0AhsEaPY0/DcntSR0oy+zV4+/4ATwf7FIjpT2PmwUzLdH9gHNjM3hu54kPX+ZBCwXPuMmLyKCKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QCWmYZWIVAqrIrqU2QJo960AjhFGjbdqsYjMj0Hwa0=;
 b=w6wvFsuF9Z0OlUw0UiqanoRctT/LeE1oAKR+5/LSWmm/gw6PHSfTUQYOeMPdIzg2fFY7Mdb7Xwb15XL+U923L9NU1slWFi1flIXoKR3qh0/vMQr1WqPNUMw+u8yxnfZNqjAKFugIVxUPjQe6snEIIAoB7nDb0tQtH8+BR2jeGdM0tesDh3mFGvQgVfSSao7YlMnblEHzVu1umZy8desNqlopUZu4t6AvI0HnkKEMU0SdkWndNUGTl32z5x5ZYdirG1RsYvOzhMvSfGli9szopAjcu32HA/G/j5oDMrbqbjUIYeiXNQ1DfoOA0LllfP7VvJGOCN6e1HBHmPzOMs+c9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QCWmYZWIVAqrIrqU2QJo960AjhFGjbdqsYjMj0Hwa0=;
 b=VZJkhsju4CFusBioOOQ77rqUI/od41qm/wKeMJbZyEr7EKtTx1w9aEDZyYEAbiCIrQu3QgUAI482NNL1Zoq7FHLZR1iJ+IWZWhECCv1fTCHTE44rtbL/mrdcTs+EY44Nmxb30diG7rK3y276KCTmbCPQMM3tE+dAU/ziZA5x/Pw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 LV3PR12MB9167.namprd12.prod.outlook.com (2603:10b6:408:196::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Tue, 29 Oct
 2024 07:57:50 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8093.023; Tue, 29 Oct 2024
 07:57:50 +0000
Message-ID: <fc99c891-b2e8-45b8-aeaa-a0d0bd023b05@amd.com>
Date: Tue, 29 Oct 2024 13:27:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5 V4 1/5] drm/amdgpu: Add sysfs interface for gc reset
 mask
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 Tim.Huang@amd.com
References: <20241029071447.3077959-1-jesse.zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241029071447.3077959-1-jesse.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AB.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::11) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|LV3PR12MB9167:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c6d69e-3371-4bff-997d-08dcf7ef623d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW1VUzB0bWJ1Nlc0NXMzRU1SWE5VbHNvRGE3b0E2U3B6ZkhIbDlEYnlwRDYx?=
 =?utf-8?B?cWJlNk5oVUdpTExramZ6L2F6M0RGUkY2L3gwK2tycGVyT3BwU2xDV2Z1Q2VT?=
 =?utf-8?B?ZUFaZG85aCs3aHByV0lvM2x6QVk5Vy9xUkJMYTlUK0RvZzlTQ0R5bVBhaGJy?=
 =?utf-8?B?VzYrVU5RWGtBUGRWeVhldmR0TzFUT3ZZRFZjMENBVzFkSGZ4MHNZbEYvV3Zi?=
 =?utf-8?B?ZEs0SjJRWEI3MkNFQXl2SllOWWdMQ24xNjVTTVZXUFJ2Mlg2c0M4ckpmajUr?=
 =?utf-8?B?ODMxdkxlUCs2WXA5S0NQNzJYRHhvTFo3b0twUEVIUDQ5a3BPNzZSNURvYUpM?=
 =?utf-8?B?cElvelNGVUZPT2cwVFE1Sm1XSUdRVjdNeHAzVFlScWpXeFpGU3VMdDRUYWlt?=
 =?utf-8?B?Yy93OVdRN1dwUzA0RW9wY1ZlTmlTbVRKQVhqM0VrKyt4dkROQmw1QlZ1SEpn?=
 =?utf-8?B?aTEzbm9hdUF5UWNJZGRIMDBLTndpSlk5RDN6VlJ3Y0NQVERRSU84TDdKWm90?=
 =?utf-8?B?bmNYdllaaXBlVDZNK2x2Z2J2aWVJcHgzWk9QbmFaSDVvV3JFQkdZc1FuY1F4?=
 =?utf-8?B?MTc1OHJ1M0tGL1VSZE1GK0h6RVhvNXlobnNLOFN2bitXRDROSUQwdEdHenRh?=
 =?utf-8?B?c0hCOFk5R1g5T1o0Qlk0VGg1cEJmS3FYZkFiZ1Mydi9TS0RQTWJEak83ZDBm?=
 =?utf-8?B?TUQydmxJb0xVa2g5VWtMM3ZPTW9zSWVvYjJkTU1TWDkwT0doOUJPbUtVREt0?=
 =?utf-8?B?YXBpMWRqTFFxekFqT0o0b2VoSmdkb0JEcE01NFE4ZHlHTDRjNXFxNW1hbUFl?=
 =?utf-8?B?QXp3dEUwb3F1WTRPZ2g5dlMvSjVydVZGeVNTUTZrRWVDbDYycGNMcXBFOTlS?=
 =?utf-8?B?N3RRNmVlY3NLMzgxMUYvMWtMQkFMM1o3YTJWeFNyY0xVZ2NUS3pza1U2TGE1?=
 =?utf-8?B?TUpFdE95VXlGbUk3eHZWRmZlcFpMWjAxVlJISE1WTm1oL1BGY0Y3T0NyejZV?=
 =?utf-8?B?b2VhcmVGRE1TbUFnSCtFendsMjl0eUF4R2k3VlpGaERzajk3TkZJcnhobExq?=
 =?utf-8?B?QTlvS0xEcHhTY0ZFOHZwL3VzMFNNTjNrM2MySFZFb2w1WUpNdFkrN1JuMGp6?=
 =?utf-8?B?UW01TlNsWlNlL0ZaYnp3RkF5NnJzcFBpQk9jMXFtVjdRRy9rV3ZOSHgra1Rq?=
 =?utf-8?B?N1JVYWZUMUJYVWRWY3pjMXQ0aTdHR1lWSHVzdTFTRnhYWGpxN1RvdlUvL2U2?=
 =?utf-8?B?Z2JtTk1KSGR6QlNITXJ5bXRwallkT05mSlVkME5kU1FReDlsWVFJamN4RnA0?=
 =?utf-8?B?M3BJbHA2Y2pyUFQ4UDN2VGd4bWVxS0JRQVZQU1lvcUtwOURwOHJaR2RVd0ta?=
 =?utf-8?B?dE1VSlh1bnhFQUVqRHFCNTlkdnFzV2pVWmhBMHpwcG5JMm1VOVQza1pwanpk?=
 =?utf-8?B?TnFjRndWbXlINXo3aEFycUNiMk1uUXBmRW5wLzR4VE4xNHU0UVlvbjdxSk1B?=
 =?utf-8?B?dEY2bnJ3YXNYSXAyL0dGbEcyRHU0eExURmh6dnRtOEtuMzRQVjFxYzlFclRx?=
 =?utf-8?B?VlNENVRGNGNkQUtLcksyZVJaWHV1b3JOVmQ3ci9vSzk0MUpRcFEwd2dxaG12?=
 =?utf-8?B?cVc4azlpK2ZWcGN1bS9uZzdRcS84RUVtRE9na3k1MXRVbTNnVkZlMVNiZVZz?=
 =?utf-8?B?d3JETzRYcDFoaXFxUGh0bVpKd3Z5cTJiN3U4TEVKSHZXVjAyYkt5dDBzTU1o?=
 =?utf-8?Q?BcQ2k+6uR9veqxQyf3u19hea17m8iJ81wze3Jek?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUJLaEIwRWZJMlJ4ZmhtcjU4LzduTjAxNGxxRldzcWl4QmtoUGdNa2VReWpU?=
 =?utf-8?B?N055L29McGQwVlp0WWlEV1Q5empYZlp6bTNQWG9WaGNRNTk4T0hIYy92Y0NF?=
 =?utf-8?B?MXplc20xL21lbEN5eXRIZ1VZVDIyNjF6Vk0zRmRRa1V3cnJ4QnlGeEF5cDg5?=
 =?utf-8?B?QkxlZWQxQ21PbCt6b2Rhby8rZWVlZDF4cTdyaDhvMk54Z3dkdmVTYzlpN1lW?=
 =?utf-8?B?MHlaTWN4OVhUYWlDMnFXaEhyNWdXMjUvbWNjaXBjS1JQaG94YXkvTTA5cU9E?=
 =?utf-8?B?MUNDcmg4QTlNSC9tVWZsajJNZWdxTWpUVTBGaGVVenJLWWIyWlBiR1RlWHdN?=
 =?utf-8?B?TWNYUjZLK2NROUd6cjZQSmxpNnhPMEhncXJrZ00xcUdMQ3RPUU9PSXhNM1ZK?=
 =?utf-8?B?SGNKUlZnbVNleGM5ZE56ZS9JNFJVblhGOWlPK0lDVklkYWVRdWpVTmtzeHo0?=
 =?utf-8?B?ZjNuRU1kUHVtSkhOdDhwZHB4SERXbTRHMG5CdGs3cTNERFc4MXcrbGl1bS9h?=
 =?utf-8?B?ZEl3MWVaV3RNZ1graTBvQlR0SmUzejlZQnM3eFZJZDRxMXk0RUFndGNWeUZD?=
 =?utf-8?B?QzVBRDd0WFRQb0NnMVhsYzgvYzNrNWozc3BGMDFualR1bHExaFQ1L0cyZzE2?=
 =?utf-8?B?N1JIS295cTBxRlYrZTVLQ2YxZ0E4dTFjazcrb3RrRW9pa0sreFdXSHhnakVm?=
 =?utf-8?B?dEJjSi9lRGNxUisxQWF2Q0NLQ294a3pDS3dRNzA0L0JCWU5rM0E0QXBvb25z?=
 =?utf-8?B?d0pWY3NlNkFVNXR3dEVaYUtGdWc2cFNkYU92bDBtZHlnb00yV3ZLb2x3T28y?=
 =?utf-8?B?dmdUbmJMNEV6UUp5S1VhNW9TRkUrTmg2YkxCY3NjQ3FvUUkxdWJRZC9DRlRm?=
 =?utf-8?B?Z3dscGNscm45RlNzVHovTUNSWU5jeERGUXFOZzhHYmxaM2Z2MDYxN1RSZzJq?=
 =?utf-8?B?a3pPVFZjR29pblZSMlhCY2R1YUh6aktPREUzUi9PWGdGZkU1WGF5OFdMdXVm?=
 =?utf-8?B?VEJmdjRLUTBDR2U5dG1jN3VpNnNNZTY4MmJYYk16YlRkM2pEL1ZUUlFKY1NG?=
 =?utf-8?B?YS9ZRG9NS0hldi8xblkrUlhOc3dRZlh5MUFmaWtBSWlnNFZkbXF5V0d5SlRP?=
 =?utf-8?B?ckFyRkhSTmd4UVVnQ2NkU2JIN3BMQVYxVWtoQmJpbHBGSENpS25OSldSc1Na?=
 =?utf-8?B?TkZPWTlXc1pmTUdqLzQ4eURic0VEM29nMHMrbDkya0xsTStWb055c3ZhRis2?=
 =?utf-8?B?U3l2UCszN3ZYRGl0M2ZRMmVuamlwek9aWTFETklid2cxb3BMNmFXdE94bWgy?=
 =?utf-8?B?SkJQcWtUY2I1R2N3M2psaVF0aGtmSU9pUURGa1BRYjlEZ1Uwc1lqQ3huQjZh?=
 =?utf-8?B?ZnZFL2IxNlFEQ1JBU3NUMW5HdXJZSG5OYzlWYjErbXNyZkFEdDRLZWR0eGMy?=
 =?utf-8?B?VzVoaUxESEFSWlp5RGlUMVdKQit1MElIN25rNG5EcGZURmRKVm5RaWJYZkhT?=
 =?utf-8?B?Y0FwK2FVajA0VmdZZCtHSFlGd0Jkd2p5TE9CTEUvK0FiSWFZVG9Qc0laMktW?=
 =?utf-8?B?b3c4OEpDWktWYUdxcHFkM0NMWTdEVUliTTRnbVdsUCtZSW8waHhxT1ZHUFBS?=
 =?utf-8?B?WUE4ZzhZU0Q5R1NUb3pIVnNqQXdpY1pjNm1vR200aFVUK1VYbStWOEJYWjg2?=
 =?utf-8?B?Y1VFNDROUXRLMjBkSE83UEZuNGhSZDVCK0VCUk42dTBNRUpwdVlDNjh6Tzlk?=
 =?utf-8?B?Qll1L21VZnFEZEdTUGl0UXpudmtIa1ZEcVZqM1dUZnpmZW1qaEl2NUFaUmJ0?=
 =?utf-8?B?Y0pOb2N5aHdBbHU3a0pUZ3VBbkl4RjJKM3QxVUQwYWpOZERLcUZ3NFFtVTVQ?=
 =?utf-8?B?S0xrT0dHVWdPZVNZaFgzZ29BOEVhWXhnUDc0VE5xYVhMek9UdWNrSnBIY3Z0?=
 =?utf-8?B?QzVqOGJBa3I4aitockdNT0FseU0rOGM4RDdweXpOVmFGcU1HOUVrMGpBUDc2?=
 =?utf-8?B?MHZ0ZGdldzdhSGx1bGlXRGZFaUpaTFFUUnhEcFRpdzlxQW5XK3hYc3IxdE91?=
 =?utf-8?B?TkpqaTQ5Z3dtcXJvN09JUkhHSWhrRGtaNUR3cTNHNkZ1WUtzNjFVWmtBeVRR?=
 =?utf-8?Q?De8K6uQ/x9foSxJnZYqOAYEtq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c6d69e-3371-4bff-997d-08dcf7ef623d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 07:57:50.0691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9hMX4JLwRN04m/9YlccEfxAUhaH84CI98bgGlFMIJiEzy5Uo2niRQs3RczCRNbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9167
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



On 10/29/2024 12:44 PM, Jesse.zhang@amd.com wrote:
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
> 
> Add two sysfs interfaces for gfx and compute:
> gfx_reset_mask
> compute_reset_mask
> 
> These interfaces are read-only and show the resets supported by the IP.
> For example, full adapter reset (mode1/mode2/BACO/etc),
> soft reset, queue reset, and pipe reset.
> 
> V2: the sysfs node returns a text string instead of some flags (Christian)
> v3: add a generic helper which takes the ring as parameter
>     and print the strings in the order they are applied (Christian)
> 
>     check amdgpu_gpu_recovery  before creating sysfs file itself,
>     and initialize supported_reset_types in IP version files (Lijo)
> v4: Fixing uninitialized variables (Tim)
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by:Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66 ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  9 +++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 23 ++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 10 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 17 ++++++
>  9 files changed, 184 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 48c9b9b06905..aea1031d7b84 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
>  #define AMDGPU_RESET_VCE			(1 << 13)
>  #define AMDGPU_RESET_VCE1			(1 << 14)
>  
> +/* reset mask */
> +#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
> +#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
> +#define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
> +#define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
> +
>  /* max cursor sizes (in pixels) */
>  #define CIK_CURSOR_WIDTH 128
>  #define CIK_CURSOR_HEIGHT 128
> @@ -1466,6 +1472,8 @@ struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
>  struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
>  					    struct dma_fence *gang);
>  bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
>  
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ef715b2bbcdb..cd1e3f018893 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
>  	}
>  	return ret;
>  }
> +
> +ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
> +{
> +	ssize_t size = 0;
> +
> +	if (!ring)
> +		return size;
> +
> +	if (amdgpu_device_should_recover_gpu(ring->adev))
> +		size |= AMDGPU_RESET_TYPE_FULL;
> +
> +	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
> +	    !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
> +		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
> +
> +	return size;
> +}
> +
> +ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
> +{
> +	ssize_t size = 0;
> +
> +	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
> +		size += sysfs_emit_at(buf, size, "soft ");
> +
> +	if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
> +		size += sysfs_emit_at(buf, size, "queue ");
> +
> +	if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
> +		size += sysfs_emit_at(buf, size, "pipe ");
> +
> +	if (supported_reset & AMDGPU_RESET_TYPE_FULL)
> +		size += sysfs_emit_at(buf, size, "full ");
> +
> +	size += sysfs_emit_at(buf, size, "\n");

Is there an expectation of having "Unsupported" when no reset is
supported (supported_reset == 0)?

Thanks,
Lijo

> +	return size;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e96984c53e72..6de1f3bf6863 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1588,6 +1588,32 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>  	return count;
>  }
>  
> +static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset);
> +}
> +
> +static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct drm_device *ddev = dev_get_drvdata(dev);
> +	struct amdgpu_device *adev = drm_to_adev(ddev);
> +
> +	if (!adev)
> +		return -ENODEV;
> +
> +	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
> +}
> +
>  static DEVICE_ATTR(run_cleaner_shader, 0200,
>  		   NULL, amdgpu_gfx_set_run_cleaner_shader);
>  
> @@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
>  static DEVICE_ATTR(available_compute_partition, 0444,
>  		   amdgpu_gfx_get_available_compute_partition, NULL);
>  
> +static DEVICE_ATTR(gfx_reset_mask, 0444,
> +		   amdgpu_gfx_get_gfx_reset_mask, NULL);
> +
> +static DEVICE_ATTR(compute_reset_mask, 0444,
> +		   amdgpu_gfx_get_compute_reset_mask, NULL);
> +
>  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
> @@ -1702,6 +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
>  			    cleaner_shader_size);
>  }
>  
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
> +{
> +	int r = 0;
> +
> +	if (!amdgpu_gpu_recovery)
> +		return r;
> +
> +	if (adev->gfx.num_gfx_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	if (adev->gfx.num_compute_rings) {
> +		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
> +		if (r)
> +			return r;
> +	}
> +
> +	return r;
> +}
> +
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
> +{
> +	if (!amdgpu_gpu_recovery)
> +		return;
> +
> +	if (adev->gfx.num_gfx_rings)
> +		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
> +
> +	if (adev->gfx.num_compute_rings)
> +		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
> +}
> +
>  /**
>   * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f710178a21bc..fb0e1adf6766 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -424,6 +424,8 @@ struct amdgpu_gfx {
>  	/* reset mask */
>  	uint32_t                        grbm_soft_reset;
>  	uint32_t                        srbm_soft_reset;
> +	uint32_t 			gfx_supported_reset;
> +	uint32_t 			compute_supported_reset;
>  
>  	/* gfx off */
>  	bool                            gfx_off_state;      /* true: enabled, false: disabled */
> @@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
> +int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
> +void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
>  
>  static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 9da95b25e158..e2b2cdab423b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4825,6 +4825,11 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  			}
>  		}
>  	}
> +	/* TODO: Add queue reset mask when FW fully supports it */
> +	adev->gfx.gfx_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +	adev->gfx.compute_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
>  
>  	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
>  	if (r) {
> @@ -4854,6 +4859,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	gfx_v10_0_alloc_ip_dump(adev);
>  
>  	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	if (r)
> +		return r;
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
>  	return 0;
> @@ -4896,6 +4904,7 @@ static int gfx_v10_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	amdgpu_gfx_kiq_fini(adev, 0);
>  
>  	amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	gfx_v10_0_pfp_fini(adev);
>  	gfx_v10_0_ce_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 5aff8f72de9c..ec24e8d019b3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1683,6 +1683,24 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> +	adev->gfx.gfx_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +	adev->gfx.compute_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 2):
> +	case IP_VERSION(11, 0, 3):
> +		if ((adev->gfx.me_fw_version >= 2280) &&
> +			    (adev->gfx.mec_fw_version >= 2410)) {
> +				adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +				adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
>  	if (!adev->enable_mes_kiq) {
>  		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
>  		if (r) {
> @@ -1721,6 +1739,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init (adev);
> +	if (r)
> +		return r;
> +
>  	return 0;
>  }
>  
> @@ -1783,6 +1805,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v11_0_free_microcode(adev);
>  
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 9fec28d8a5fc..f5ffa2d8b22a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1437,6 +1437,12 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> +	/* TODO: Add queue reset mask when FW fully supports it */
> +	adev->gfx.gfx_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +	adev->gfx.compute_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> +
>  	if (!adev->enable_mes_kiq) {
>  		r = amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE, 0);
>  		if (r) {
> @@ -1467,6 +1473,9 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	gfx_v12_0_alloc_ip_dump(adev);
>  
>  	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	if (r)
> +		return r;
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
>  
> @@ -1530,6 +1539,7 @@ static int gfx_v12_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v12_0_free_microcode(adev);
>  
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index b4c4b9916289..94007a9ed54b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2362,6 +2362,12 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  		}
>  	}
>  
> +	/* TODO: Add queue reset mask when FW fully supports it */
> +	adev->gfx.gfx_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
> +	adev->gfx.compute_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> +
>  	r = amdgpu_gfx_kiq_init(adev, GFX9_MEC_HPD_SIZE, 0);
>  	if (r) {
>  		DRM_ERROR("Failed to init KIQ BOs!\n");
> @@ -2391,6 +2397,9 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	gfx_v9_0_alloc_ip_dump(adev);
>  
>  	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
> +	if (r)
> +		return r;
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
>  	if (r)
>  		return r;
>  
> @@ -2419,6 +2428,7 @@ static int gfx_v9_0_sw_fini(struct amdgpu_ip_block *ip_block)
>  	amdgpu_gfx_kiq_fini(adev, 0);
>  
>  	amdgpu_gfx_cleaner_shader_sw_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	gfx_v9_0_mec_fini(adev);
>  	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 016290f00592..028fda13ac50 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1157,6 +1157,19 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>  			return r;
>  	}
>  
> +	adev->gfx.compute_supported_reset =
> +		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
> +	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +	case IP_VERSION(9, 4, 3):
> +	case IP_VERSION(9, 4, 4):
> +		if (adev->gfx.mec_fw_version >= 155) {
> +			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
> +			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
>  	r = gfx_v9_4_3_gpu_early_init(adev);
>  	if (r)
>  		return r;
> @@ -1175,6 +1188,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> +	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
> +	if (r)
> +		return r;
>  	return 0;
>  }
>  
> @@ -1200,6 +1216,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
>  	gfx_v9_4_3_free_microcode(adev);
>  	amdgpu_gfx_sysfs_fini(adev);
>  	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> +	amdgpu_gfx_sysfs_reset_mask_fini(adev);
>  
>  	kfree(adev->gfx.ip_dump_core);
>  	kfree(adev->gfx.ip_dump_compute_queues);
