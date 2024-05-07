Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E27C25B10
	for <amd-gfx@archiver.kernel.org>; Tue,  7 May 2024 00:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B0C410F3E5;
	Tue,  7 May 2024 00:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pvab/ZeD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D04910F3E5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 May 2024 00:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzsF9/Etf34iypFaRywPvDI1HrtkSIltYKPsMrXzU1Vh/cxvmZH4hvOtx/5NB1fxRMqy8p2ABcemfy1+5KgVmJ7AV+CfnB/UlUf3qHseAEy3Wi3ef9xJO2XRba9J7yJ6EqzqSYbTuzKf5A3YSOQIR0SBCbnn61WEtMy/Id8vSU2W87JCtFlVCyMYxquFA9uOvB65+CrcgFftyg+vERGCoH1sw6fHpcASdJjGvlJzFUkS1MdvezZYaZxasfnkNyI0mQnAroHE0pB4WqexuOzVsSS4PVQj64j9ohM2yhdjk3XylLJ+kBG1dTSihVssQuyz65LYf5wh6wIe36b5+Eg5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PjlZ8sDn3AyTKfEX67pIGsB/yMLJg2Siv7vRbv1FtL4=;
 b=JOlftUVOzdUKEM0d7sTu1LvV5oH4p2KX6i/G/5CxmB0upB7FmNgwMgBNOlKA9lJ8mYEcprB3ZunTqxPKRg56YRw9wdfl2L1uGDc2oxGS/+KgIIYpBq+km3HssuvXltiZ0o3My/YTZQQ7rEAaFtlMZxGOr9NOaR7AEq58oztVduurot7AXNuaKjojOYX7a8TUJn65nyFZhJEnEJSV2CGLL++2o+xRj1WaWe21ZXgeKbq8LCi4sgphIG2N/3h5JdoESHJK5jwIwNZ8JmFea2pyMT8iG+JtImeMEoT+CUxT4vBsS3slT8vT73n3FyiuQhy9lwh7XBMIUqgOA6JXir1Aeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjlZ8sDn3AyTKfEX67pIGsB/yMLJg2Siv7vRbv1FtL4=;
 b=pvab/ZeDLc04GWaZuCSKUTkGUtdu5jvCf22DkUQXBx0BWV0QkbuLJRJXCKHyx7t1YTz0UGQJpW7e4KCHpXuL2rzEYLLufb7Gfa1q2UvhpTVSWbsSUUTkxcXYMDrAKNXVOKX8JElxmPtwmrOcMtMxR+oNFX1fEgxuFkdpqdNGOo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 00:30:58 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::1c2f:5c82:2d9c:6062%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:30:58 +0000
Message-ID: <d6cf999f-c44a-4f70-90fe-7cce1eea4a5e@amd.com>
Date: Mon, 6 May 2024 20:30:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Assign correct bits for SDMA HDP flush
To: Alex Deucher <alexdeucher@gmail.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Le.Ma@amd.com
References: <20240417115743.167530-1-lijo.lazar@amd.com>
 <CADnq5_Nu85f-UkAwnVzizxwKMhmW6UN11JuBpx68Se-SpLhm1g@mail.gmail.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <CADnq5_Nu85f-UkAwnVzizxwKMhmW6UN11JuBpx68Se-SpLhm1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 414d457e-2f76-4d4a-6203-08dc6e2cf729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0pEeGpCMjM1Z2hLTEZDMm90YkRYcmtIL3poWGFnaE55ZURFamJZVisxT3Na?=
 =?utf-8?B?RkNDREFVNFQxZ2UrcHpLOC9jcGh2NVBicUxHOWpDMmlhRVZQakRMZkRRRU1I?=
 =?utf-8?B?MFBRUlJ4dmZ3bGdRSU1zaFFoczJudUliT3N6a1BYY3NacGNvQVU2RC82UEp4?=
 =?utf-8?B?M2pWaTBLT0dMR2FHUzFRaDg3RjlhWlJ4U1BFVTFNRjBkd1NpR1ppQndXZ2dZ?=
 =?utf-8?B?ZCtjRVE3MEdXNTlOajFTN0d4aGxTNWFlLzNnMzFvWGxIRlUyNDhYM1VQU1Z6?=
 =?utf-8?B?aDUrQ0c3dDhicWU0cUxHSkZ4VWtuV2dRSU8zUjlMUnhqbUU5bjFLWmRyUmtH?=
 =?utf-8?B?MDk3THoyN3pnSXVJcHZGR2dVOTNwVUZmSWxlSWhPSzFmS3pyMGFuc2dneXpB?=
 =?utf-8?B?N1Fpbi9FTnY0RE1QL2F5YnNKMWNMc3lMaU1hVGxOdXBNS0hQdG1vYW8veU5E?=
 =?utf-8?B?aGx0NE9lMUVMRjlXckFzSzUybWVpY3pSUnlnbElpV1VyK2VHZitON3RuL29P?=
 =?utf-8?B?MlM5YWl1dkRiVFZ3RmN2QU8yNWkxT0NwQ0NZL2l2aFZFYjRRY284NC9WbTNX?=
 =?utf-8?B?K2haQ0oxb1RQVVpzOXJnZkI4cEp1RnNMaFEveHlWVzlTZGkyZGhEMFNWd2xB?=
 =?utf-8?B?OVBvbEVDdmZsOC9VTW5sWVZwQ3pNRmhyY2lTZkxtajdiU3RTdVVhTS9oN1M2?=
 =?utf-8?B?VElJdXZUUXlhNzZBMXJRUWJYRTFCNk5oY0d3YTZBdHFnelk2c0ZONi9MS0dv?=
 =?utf-8?B?TTVsU0tWeGwwaHlVMXJYL25JdnlkenhDc3FYMS93VThkQnlkV0k4VWhyQmVa?=
 =?utf-8?B?SWlIdHZoVjU5dm0zSFgrNUttdlc2Z2Z4OW90NElyV3d0QzZoT3M4RVg1WmEy?=
 =?utf-8?B?SEpmMFRma3BDMG15cmFoOXd0Q3JWOXZBd1grYUxBZXZSQVoza0sxblhGdTdO?=
 =?utf-8?B?SWNGZTZYUERtNGlsNFJRNElIdTRnaENScVMyUFd1MEI0ZDRweWJTb3o5RUJz?=
 =?utf-8?B?YzhCa2EyUk0rcGRTY1BCcWdZL2FUN3RzbG5jRDU5c3dVOVZDRExNNGpTbCsr?=
 =?utf-8?B?YVIzY1ZTV0d3dzlDT1p1N01ZZXhMdkpmcG43eTBZWDNRZDBMd0Y2dVU1eXM4?=
 =?utf-8?B?Z1BvOUlEQ3ZmWEEyUGR4K0hBeDhackQyemoyRHBHZmJvd0F1aS9VeWVYcEVU?=
 =?utf-8?B?eGxnNjB2YlhxN09FOWx5ZkxoQ0ZEOTQrZkpwK0dpODVFaDh1a29SdlcwZ3NU?=
 =?utf-8?B?YmFldjlRbUdXcjFnTTAxb3lOM05mSVNZb2UybUVMMksyQXVHU0NXRmlGNGN5?=
 =?utf-8?B?a3RmdFJiL3NjcFBqR21oMVQ0VDZWQWlXL3RyVndza2cxRTlUS0VUdWV1a2M0?=
 =?utf-8?B?SXdqdVJnaFNEVytuRmxLdDNtN1lYTGx6VnRCdE9PVWRuMkZrZmVGTGdBNWw5?=
 =?utf-8?B?dzdNYkRlbG9tSVV5OG1uQi82blM0Y2ZjcXJ0MmNoaWhOL2V0YWg1ZmlsWEl5?=
 =?utf-8?B?S1pZZkpQVlQ1SWZhL3haV0tEWHNaRGNIZnRiUGtnZ3puMmlUWHp3U3lnM2dI?=
 =?utf-8?B?QnNjTkZyaThpYVQ3b0xsY1NEK2RDb1c1cnA5Yy9yejBpUjdJUG5RQmRoaVU0?=
 =?utf-8?B?TEZKZkRML3BBQnVDRU8rcEs2eXlROS9oR05saXowQnJZQXVicFBFckRrV3Ay?=
 =?utf-8?B?aW00dy9zaU5OejJmMUU5S09mMDY3bWh4eGRkWFo4Unp5QlZFQlB6clV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0Frak9MTEdPek9rOXdFMFg1TDJBWm5vNmV6cXJIcGRwbGF6c1BYNVJqVHhv?=
 =?utf-8?B?cEpYSlNsclAxbVhXaTV6UmV2TXB1ZCtpQ0hmYkNNTlVaZ3VVek54SlNscmRE?=
 =?utf-8?B?RmZDdkt3OFN0N1k5a3VUeGJ4NzhDSGtvbC9wcnZ2VXd4V01KSkVPWWJwY1Q5?=
 =?utf-8?B?d2Ywb0w4ei9GQlk3WXN3UitLNEljc2JKTEJBUEhrVkIrdFRteHIyNTFWOXRP?=
 =?utf-8?B?Y1hwUmI3YzNmZlJBWlJqeWRhYmlKNWo5Z1R3cTBuMks4RUx0ZG5QeWJHenVU?=
 =?utf-8?B?WUthaWZLMW9PYzMza3VsbndXbi8ycGs4UGszQUN0SHBJUTBzUWxrZFp5a2sr?=
 =?utf-8?B?WXRXUmVyWW4zeFRHWncrSEFLcm5QZ05zRmhFUlJPbzVEc200RlFER0gwamRQ?=
 =?utf-8?B?dDJySSsvLzdxakw0SjJMSm04eWpiY2pKNU9BaCtQbjRrN2N4WCsxcE15enVX?=
 =?utf-8?B?K3NZRVhxTXVEelpSdTF3VXYvcDFXSGRYL2h3aUhXZi9kTnJNNFljRUdNVU1n?=
 =?utf-8?B?c1RGNTQ3Q0lMVUQvNEVWRkI0ekVzRklVdmZTamczSE5PK21mUm9VemlwdDFp?=
 =?utf-8?B?VnVoUHN1WjhIVklRbTVPaE9qR0NsU2gvZmloRVJMa3gwYTNIQk5GTXRXYTNQ?=
 =?utf-8?B?eE9SYlJMOUhLUEEvbkRlNkJMVkhWZUpRYzIwaFJSL3I4eVMvamlqZnlJNkV4?=
 =?utf-8?B?T1cwVUdLdC9rcTEzOGxvdmUxY2FVTFhNMVZCRkZaQVVxb2kvWi9ucTBKM2N1?=
 =?utf-8?B?M1BWQ2wwNEdCU1FyTjlBOGxYaTRSYzFKZnRhN2VqaFAyLzI5MUlCWXE1NWVI?=
 =?utf-8?B?VXVONnZWT1J4L0NBQVh3QjdFS1F2NnlYZ2dHZG8rS3Z2SlVPc3dLWCtUUGZS?=
 =?utf-8?B?VGlERDcweTZxOVI0YmRLVUs0dk9SZjUrQ01zN2VhVGkxQ0xhUGVDcFNxeUZp?=
 =?utf-8?B?ckFBWkx6Ni90WUg2dVZYaTkySkdKbkU0QXhwRlg4LzFFN2c0U3hQYnRVLzRp?=
 =?utf-8?B?WmUrd0wwOGRUU3F3SThnbnE4dTZ5SUMyTnIwang0aTlaZEtoeStMRm5MaDFu?=
 =?utf-8?B?M05FdXBtc1Q0bDNBSG1ITjM0cFpweVBlSUUySzRObGwrcDhINC9VWXg4eUFq?=
 =?utf-8?B?eDNiSXl1RTFHLzZTazdVd2VpNm1ZQ1YrejgvS2E1allGS21KMXE2S0JsMlRC?=
 =?utf-8?B?bC9GNENpai92ZFRUU1lmTVk1K2NmcU0rNWJsdTJlaEtLVE1oT3lVTnN1UTV2?=
 =?utf-8?B?RW5MYVNJMXFudVBTWTBlTDk5d3FQdnFOUDBOWmdlSnR0djd6OXgybmpIY1Q4?=
 =?utf-8?B?bzlmNjZHOHBobjZpYXJpcFQ1T1VZckg4ZGdWS1V2U21yVnFHOWRqUW1IYXNo?=
 =?utf-8?B?cUpDeVM3REJVRGRnYUtZbHRacTNya09CZ0NUZjMrNmRzUGk4S21XRGFoL3FO?=
 =?utf-8?B?UTI5cUFQbmkzVEhZWTdSdzNXdEUydWVmbWgxb0t5RW9TTWUwck9IK1ZIeHk1?=
 =?utf-8?B?c3NMdFFCYnhSVGo2VnZ6c1B6cUpQcXlvaG5UbDIvNUNoR2Z6TTZKaDdJZmpS?=
 =?utf-8?B?bng1VVZnaTc5TEdINWd5bmpwcmFYdUhLTnZXV3VqM1o4NHNWcHJPV1NoYkgx?=
 =?utf-8?B?YzhjSzl1bEZRVy9OdVl3QjU1dWJJQ1ZScE9VT3R2VUVqUlVjNXFvb2lTMVUz?=
 =?utf-8?B?eW0yWUlBSndtYllMQzhNZmNFWGlKWWVubFVGYUNLbzZaQ0sxOUVjdGlUMjRL?=
 =?utf-8?B?UXpUcUNsM1U1dHkvWmtGbExYY2tpekpOUG96c3V0eU41REFEbHRZZCtLSEdR?=
 =?utf-8?B?YzM4eGN0dENLSWRCMThtL2hVQVk1MXpaS01NRDJ0OXhBVmk2VVNzR1IxUjBa?=
 =?utf-8?B?SlRwQzg4YUJaWHhnWXFmYkFRU1B4WlU1RllESFVLcVY0azZSanViYXhNNC9z?=
 =?utf-8?B?Uk80aSt2YlAzcTIyODBhYm9vUXlzMGNXWHFhMWpqSjg3S3g2MUJYMTJPQXRG?=
 =?utf-8?B?Um05ZGlQNWpjbU43TUxNOXk1SFNxQ1pUVmZRQlo5aE01TXE5cW9lQkUxdjZK?=
 =?utf-8?B?RGZ6dER0T05uWU82TFVEdnA5SVI3M2MybGovdWpWODlkMVhTYlp2ZHduYVJR?=
 =?utf-8?Q?Cg0tiMJ7zY3eZZz+PrGhOAFSG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414d457e-2f76-4d4a-6203-08dc6e2cf729
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:30:58.6335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kgv37XC/cCa87FMCcbDlSfWqEaXcXKy5RGBGd8hu2FP9bM2BY9U3UsESad6ML3H2xzY+5SM4vYpXrYd2vOulyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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

This patch is causing crashes of Manor Lords on my Navi 21 on the 6.8.9 
stable kernel. It leads to an assertion failure in wine:

File: ../src-wine/dlls/winevulkan/loader_thunks.c
Line: 3621

Expression "!status && vkEndCommandBuffer""

This happens both with radv and amdvlk. It starts happening on v6.8.8 
with this patch. The previous patch (drm/amdgpu/sdma5.2: use legacy HDP 
flush for SDMA2/3) is fine.

Harry

On 2024-04-17 09:19, Alex Deucher wrote:
> On Wed, Apr 17, 2024 at 8:07 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> HDP Flush request bit can be kept unique per AID, and doesn't need to be
>> unique SOC-wide. Assign only bits 10-13 for SDMA v4.4.2.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index f8e2cd514493..09e45ef16c0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -368,7 +368,8 @@ static void sdma_v4_4_2_ring_emit_hdp_flush(struct amdgpu_ring *ring)
>>          u32 ref_and_mask = 0;
>>          const struct nbio_hdp_flush_reg *nbio_hf_reg = adev->nbio.hdp_flush_reg;
>>
>> -       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0 << ring->me;
>> +       ref_and_mask = nbio_hf_reg->ref_and_mask_sdma0
>> +                      << (ring->me % adev->sdma.num_inst_per_aid);
>>
>>          sdma_v4_4_2_wait_reg_mem(ring, 0, 1,
>>                                 adev->nbio.funcs->get_hdp_flush_done_offset(adev),
>> --
>> 2.25.1
>>
