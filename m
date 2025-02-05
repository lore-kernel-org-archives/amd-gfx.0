Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEDCC02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EC710E7E2;
	Wed,  5 Feb 2025 15:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eJ+/UIHU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440CA10E204
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+dL2mi1ci+zpX/KfOQdY6PjgMoHtGIFEgHSy7AWyywYUjG/pP6o9qNpT0LjHzgiXd0N3FF+IL3OOmG90+jTC8oLYYDr6tbZ5eRQbTRQg/SbiKvUJ0o9BoT3j0euPfgiyJt4DOmoSvrhOeZBchphUp7DHY3NDzMNXBNL5webUKCiFUL15sziZKaeCrMTpGEpqQKvYbmKZ/qAcykVeK5392l1defdhHt72/UpRWMEntYtp5f0XT6n+8KH7Fck/i8DY0ZqXKGJ1UqBkjuhHIW6ykoUI2u69kqFvVB8458mS84jsUoiS3LMjwiZltkYOk232K58WxhfR3m7UDtjMZLlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd7/RJ7EaOW6mA8lsv4XNz+6NOMY1GIKL98Rz5c1Rp8=;
 b=nSKdtIPgEmobZ1yW1Hw1GWF0+ZndIeLZVyVF3kuAC2e54Hl5KAfnAFwvFWHph8pbpXq+gFFeaPCCTLomb/B4vRhoxSXc2ABabsv6YXZhXWdu0y/wpli3YdQAifWk09Y7XUTYLNA5EjYNbxz35QWakuWcb3wKnRF3aDh3bZyd+rXgRUgoFM9SiePoUptNV601JSU3qyO1WBKKIfsn/5izJBM9cxIM0vcwEHaVu8MLAt6iLKy2q+jp2qZ7oTZZFvqHB/LOLCeUxUmSZSmwwGpqy1cb2ZsMzYYhTT58HIXDIPcOGO71yI6pxPlKQzgmeglbDGnTu0p0W78A4EovnpADTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd7/RJ7EaOW6mA8lsv4XNz+6NOMY1GIKL98Rz5c1Rp8=;
 b=eJ+/UIHUXHnbZ1zo72wOdWh+i9RJk4YKoZeuueA2WnxvlAhRCLXqTAZdkp2t8xaBN9Du7RU2ngfGDn00io39t72awqUZqfwcLI0glS53GJkYUlXgnGhHpx4sp/4hmT78NbmMTuKFIutcbum/jT3p03Jbm6ZixjBW7dULE0n3A9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 15:03:34 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:03:34 +0000
Content-Type: multipart/alternative;
 boundary="------------EFs3PTKlT5SugH1FHsJKzOus"
Message-ID: <27359134-1037-4ae0-8645-ca14624f84ad@amd.com>
Date: Wed, 5 Feb 2025 10:03:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/44] drm/amdgpu/vcn4.0.3: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-18-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-18-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR0101CA0108.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::11) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f46e1c-53db-4f7d-6789-08dd45f642a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGloakhldnMzZFdKbk1sWTAzaDk4VXVnVU1TWXY5cUNESFVBb3NlMUw5bGFq?=
 =?utf-8?B?YWVzN2JLT0ZtWlMwbFRRSUROeHRpaDNFYUpldmtpS0pXcmdnWTBha1IxRnYx?=
 =?utf-8?B?MHNtVklKSjQ0NXl1d2o4dXNDVGhIUFU4WjBicG1JaTRjaGphc2Q4VTVDeSt5?=
 =?utf-8?B?N2hBNGxYTWpEQ1VhUDYwNDlQNE1FMHRxTDMxSHp6T2p6OEdaTlorc1FRWXhL?=
 =?utf-8?B?eCtUYk9GcGxkdHhVQkQ0VU5tWDNYM0FkL2dLaFZ1bWJ0cGt2RS84bDV1SnNO?=
 =?utf-8?B?OEwyYjlzMUVSSzllQ3RnMUhxNk1KVHZKQmRmdGxVb3ovYzVia0Jpd2lhOTRu?=
 =?utf-8?B?M24vdC90TGdUYlFGQS9kTi9HSGMwRjc0QStIbXFQNzh4eWZqNko4Y2lleDVR?=
 =?utf-8?B?MzFhNzNtVlVmWHp6eVdycldoREwzcGw4TTNwUHo1a09aVGNyWW9tM2NBTFp5?=
 =?utf-8?B?ZE1yenZxdDNaTWwyRWExYm9vb2xJVWUrYjJ5cVZFT1BITFZNcGVkalpadllV?=
 =?utf-8?B?VzQ3NWU5RWJXRFBDd0VhUk5ETWcvdGxmV3p0aW9GMTVoNGZwK3hOOGpBTHNh?=
 =?utf-8?B?VWxlbU40SG5ZV2RWRWVsWnlOMm0wdnFxUmlxL0sxeC9LR2swUkE1TDZYOEZo?=
 =?utf-8?B?K1gyNXp2WW0xZ1orYlpMQkFLd2Y4bHRRNEs5TTZQeFBDTDdjMEo3Qm1oYTFR?=
 =?utf-8?B?cFpUOUNFYjFGQlhReFdxdTJUNGM5eHN1cFRXSGJhRmRjMGZNcVpZTHpUWm9l?=
 =?utf-8?B?bnRzTnZESXhvU3UxcWRkVlZkSzVwNFVtWHVDSk1nVmhoclY0K2JyV0hKVkJw?=
 =?utf-8?B?OTFkV284Y3JxeC9xTGg3ZXlNcE1XWk9JSTlDWWtUdFlzNzJQdE5DaFU2NXlr?=
 =?utf-8?B?cUtqc1NBRjcrUEw5Y1VRWWpKaDlpSzJBdk9GdFZiZk4vdTJSR0ZQaXMxTVBp?=
 =?utf-8?B?d2pKZ0N4aU9URTViMGlWdUVKRmZPbkg5QVFYdzVURUNXTDJlaDIvSVd3eUE5?=
 =?utf-8?B?RTdZOWVneEdlS2JPdjNXUlE1S0syL3pZdVJpb2xsOFlCT3VlS1hGTU5vUDZu?=
 =?utf-8?B?bWNSYktaVDhkQWg2TmdLd3RnQVBzZStCOUsrSE01UWJ6RlpIRnljRUc4OWNS?=
 =?utf-8?B?V2JzUFBmUDZFNFgvS3ZUc3NvZEhNQlc0UmNHVlFiVWlweThIY0Y1UjBvYmxL?=
 =?utf-8?B?bU93WGttT1JGVXFlb1ZCRG5IMGhTMlpxeFU5elBlRFAvMCtNVUtHYittdTZE?=
 =?utf-8?B?amw1YURzbGl3aDd6NERabUYxdjkxWFlpL1p3VGVNQmVIdC9OODA5cTlZekRM?=
 =?utf-8?B?eDh2RUwvZC9HYm1LbjQ2SGdvdGtMS0xUdTA1TGF4S3hlUGVaekI4WEc5Nnlz?=
 =?utf-8?B?UTFGejdNbUJpZkFBQzl3bG11M1NOUDZiblhMdmJoQUNLSUUyWEhLNENhNFc3?=
 =?utf-8?B?K2Joa29TZFZBL3A3M0lFZkI5K2ZMRGJ1cUJYVlU5V2RaWnFsZi80Z1RTd3FQ?=
 =?utf-8?B?bnp5V3MxdWVTVVVuRTYxTlVWRlpXOVRGdEg2QmhlZUt3TFZENXBJcUsxckVQ?=
 =?utf-8?B?Z3E0RElHZGhOZ29qOS92V2ZMdVhmK3cvdVdqUGM0QWVCTmV1OHNMbFJIVEVE?=
 =?utf-8?B?dTQ4M0d3eUREa2NGaFVKZ0ZKZU4zMk9rZjNyd25SdGpvUlVtQWhwU0xFQ3My?=
 =?utf-8?B?RC9hVHlITkZCNjVWVS9xNXMyU1VrdEluMWRFMnE0TVNQd24vNE1ZTzJNcnc4?=
 =?utf-8?B?ODZxeitXOFNJT3pGck4zWWpjZ1VCdXpXRE9yODAxbWs3aHQ0dHRoNjgxSGhj?=
 =?utf-8?B?MXgvSTI2ZG11Q1dLaThCUGVabEtWMGZoc1ZGdG5OaERaWDhCd21LN1J0QmZW?=
 =?utf-8?Q?2lMkktwxLD461?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRFaW0vY1Z5a3NwOWlRejh3Rm1OR2hBOUs3ZjF1QlIrZkFOanFVTWZyVXdY?=
 =?utf-8?B?T0RSMVVLcWlpSWpSRmtjaU9ZcTlMcjliOGk5VXdGWm1tSXBOejB0cGsyelY3?=
 =?utf-8?B?S3ZTQ3p5UUpzOERyN2VvRlZSM01RRFQ4WTVYeXhnZ1VjZGZlSGZvTk1CTVV0?=
 =?utf-8?B?elVkaTVSZFZCaVZaMnVCZ2oxcVBPZ0xDc0dhU1B0d1BhTGIzL1VtU0NialNE?=
 =?utf-8?B?c2pVMlZ5ejFQcWFpNC8xYUhDL0srVlBKZzUzOXBUZVhEcktsTVpoSjQvMzdM?=
 =?utf-8?B?Y2JxSzRNRjBHTUlLOG1IbXlVSk5RenNRbTlXckNyK2dhTXd6M1RuQkNPNW1a?=
 =?utf-8?B?YWZ1WEkrWWZXOGFZcUwvbzNaUjkvZ25rUGhVYVRIc3ZnS3RlQWg4T0JUV3JP?=
 =?utf-8?B?VUtIQVFSUm4xbFduVlVTQTJ5YmRWZXVtK3l2aXVtc0t3U3dBcFlJbGp3VnZM?=
 =?utf-8?B?L2lkenZtcFoxUzVSUkRWTWRqUXV0dzJiejZmQzJudVZTYkFDUGxvbzd5Q1BY?=
 =?utf-8?B?Nk9STmNLSUM1aWdZcnUyRjlxQjlKWlRuTEZMY3RQSWFTTlpHNkp2UEV3UkxR?=
 =?utf-8?B?UnJrVmQ4d2hHM3FieTNjMXczYS9VbWx3RTF0ai9NZnhHUDRuOWJYRUVpS2J4?=
 =?utf-8?B?WTJtOEJCd2QzVnJ2Q2hJQi85TlI0eDVBZnRTT0V5c2k4YnBBa1hFMTNsM2xq?=
 =?utf-8?B?Z296ZkY0S0t1dWFnRzFvM3J3cDdHeFJ0MEJzTzYveTlYN0pzcmlKbFkzaWow?=
 =?utf-8?B?d3crbzRidnZOcGtnVlZGMlhnOER6RjlzcnFBZzBLTVZTd3ExcEltdDM0b01O?=
 =?utf-8?B?ZzJBWDE4dU5SKytSQXNudGNTNU9kTEo2NXB1OFova3g0NkRWclR2MkloNldI?=
 =?utf-8?B?U1lWQ2JFSFcyNDZDbjVBWnM4dkxyTDhZQjM2bzU4V00yUEE5enl4NFRCanZQ?=
 =?utf-8?B?S3dpN0hlRzVpSWY3dzg5T0JWcTgrVEU1U05yVllYQ0Y2OFJKTXIrQWlIb3l1?=
 =?utf-8?B?WGh2Wk5BL0VuRVh4TkJWNG9ZV3lCK3lkZ2ZyWGxpaVVIcDdsRnVjcFdWQUJ1?=
 =?utf-8?B?R1YvWDVuUVlYbGltZFpubzlTaGo1T0x0OWZWeElGZkw5OUNKUWdhRFpBdnk2?=
 =?utf-8?B?SGp5d1ZLUXpGZ3JWem1qV0xHU3NBek1YSVhFTU84NnhIRGFOai9tZUI2R2k0?=
 =?utf-8?B?RFJ5ZVNxeWdzaXEzTGFyK3MyUnZLVjlyYmFQNXpqcGRiLzlXb21KMElrSDN1?=
 =?utf-8?B?Y2RQTGduRVZ0TVNrVHl4S3BiYm1WVEYrMlYvbUZBMzhKV1I5ODM4emw3V2t0?=
 =?utf-8?B?dW5CUWFxcHo3N3FZZzJoQ21NdUM5QkdnR0p3QTE3emFtWHFmOTArbjhZT3Zm?=
 =?utf-8?B?S3VvckxHZ0IyYy8wMW5LaGt3R0VMMzI2ZmFSMEtsZ0syaHM2Q3FBRU9hZUdG?=
 =?utf-8?B?OHlWYWwrMkowVW4zWDZsSFR3SmJCMFpnWWc1VndsZUF5Ty9paE9YVUJTdVUr?=
 =?utf-8?B?ZVFGRmtrOFkwTEJTY0JGYlYxbGM1ekJhSmltYlY5aTBzS2tYamw4VmdHaDdQ?=
 =?utf-8?B?VEE2N0p0ejRiR205NFY4U0dib0cyeThEa1ZoSlV3ZExDb0U5N1FUS2J2b2tK?=
 =?utf-8?B?bTA0SU52MUlpNXJTYStYVmJYWTh3MTlkNFpSL2txUW1ITUhUbWIwSktaYVhJ?=
 =?utf-8?B?akNndEptVytJVEtZOVZzS2gvZlU3YlNHU1hBVC83UERGSDQvL01CQ1ZxMlVp?=
 =?utf-8?B?TU1oczIxUmVNT3I2am9CSFZDQ09Zb0orUXMxeVgyRFBoTXB6SDVhalVwTnJy?=
 =?utf-8?B?Y2pwR1B1cmxkVkpmcnZDc2ZQUUQwWEpUQXYzVUlFbFhZUUFWbnFrMkwydEpk?=
 =?utf-8?B?SU91Q2t6SzNTVDE1dGxCdFBSalh1enlpWW9Nd0R0NjFid0VOdkcvcHRUR2Zl?=
 =?utf-8?B?ZzhLQWNmaVBVL1E1TDNJRld1OVVQamNZdC90aDBNQ09ORWNvU1NEeXZ3YjdH?=
 =?utf-8?B?SUIrWEFlcERMYzQvOGp2RHI4Y3NpTGVFcnZVbndZWjBIYTFGSjQ1cDg1M0FX?=
 =?utf-8?B?cEM4a24yRDBBYlRlT3V5SENGYkV4MHlqLzNIN05vRzRIMk4xa2h5YnBBZVFU?=
 =?utf-8?Q?eG9NH2DgKxvKBDk3ohqfpjPW9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f46e1c-53db-4f7d-6789-08dd45f642a4
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:03:34.0594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQ8pi28XGN+Ou9J3qkSeLNmUrxkclDM3xQaYMAZmVWCEUwCxq7zqZUFFCc6qYeRwI7BBGo1KyZv5OmgIVzq2bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222
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

--------------EFs3PTKlT5SugH1FHsJKzOus
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 93 ++++++++++++++-----------
>   1 file changed, 54 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 1407cb4b553b7..a3fbfaac76603 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -431,13 +431,14 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
>   /**
>    * vcn_v4_0_3_mc_resume - memory controller programming
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number
> + * @vinst: VCN instance
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v4_0_3_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size, vcn_inst;
>   	const struct common_firmware_header *hdr;
>   
> @@ -505,14 +506,16 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Let the VCN memory controller know it's offsets with dpg mode
>    */
> -static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					  bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t offset, size;
>   	const struct common_firmware_header *hdr;
>   
> @@ -619,13 +622,14 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
>   /**
>    * vcn_v4_0_3_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t data;
>   	int vcn_inst;
>   
> @@ -712,16 +716,18 @@ static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst
>   /**
>    * vcn_v4_0_3_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    * @sram_sel: sram select
> - * @inst_idx: instance number index
>    * @indirect: indirectly write sram
>    *
>    * Disable clock gating for VCN block with dpg mode
>    */
> -static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
> -				int inst_idx, uint8_t indirect)
> +static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +						     uint8_t sram_sel,
> +						     uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t reg_data = 0;
>   
>   	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
> @@ -763,13 +769,14 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   /**
>    * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_idx)
> +static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t data;
>   	int vcn_inst;
>   
> @@ -814,14 +821,16 @@ static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_
>   /**
>    * vcn_v4_0_3_start_dpg_mode - VCN start with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    * @indirect: indirectly write sram
>    *
>    * Start VCN block with dpg mode
>    */
> -static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
> +static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +				     bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
>   						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring;
> @@ -849,7 +858,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   	}
>   
>   	/* enable clock gating */
> -	vcn_v4_0_3_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
> +	vcn_v4_0_3_disable_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -899,7 +908,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v4_0_3_mc_resume_dpg_mode(adev, inst_idx, indirect);
> +	vcn_v4_0_3_mc_resume_dpg_mode(vinst, indirect);
>   
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
>   	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
> @@ -1146,13 +1155,14 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
>   /**
>    * vcn_v4_0_3_start - VCN start
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to start
> + * @vinst: VCN instance
>    *
>    * Start VCN block
>    */
> -static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_3_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	int j, k, r, vcn_inst;
> @@ -1162,7 +1172,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   		amdgpu_dpm_enable_vcn(adev, true, i);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[i].indirect_sram);
> +		return vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[i].indirect_sram);
>   
>   	vcn_inst = GET_INST(VCN, i);
>   	/* set VCN status busy */
> @@ -1171,7 +1181,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
>   
>   	/* SW clock gating */
> -	vcn_v4_0_3_disable_clock_gating(adev, i);
> +	vcn_v4_0_3_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
> @@ -1225,7 +1235,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   		      (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		      (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v4_0_3_mc_resume(adev, i);
> +	vcn_v4_0_3_mc_resume(vinst);
>   
>   	/* VCN global tiling registers */
>   	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
> @@ -1319,13 +1329,14 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
>   /**
>    * vcn_v4_0_3_stop_dpg_mode - VCN stop with dpg mode
>    *
> - * @adev: amdgpu_device pointer
> - * @inst_idx: instance number index
> + * @vinst: VCN instance
>    *
>    * Stop VCN block with dpg mode
>    */
> -static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
> +static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int inst_idx = vinst->inst;
>   	uint32_t tmp;
>   	int vcn_inst;
>   
> @@ -1351,13 +1362,14 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>   /**
>    * vcn_v4_0_3_stop - VCN stop
>    *
> - * @adev: amdgpu_device pointer
> - * @i: instance to stop
> + * @vinst: VCN instance
>    *
>    * Stop VCN block
>    */
> -static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
> +static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
> +	int i = vinst->inst;
>   	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
>   	int r = 0, vcn_inst;
>   	uint32_t tmp;
> @@ -1368,7 +1380,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
>   	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		vcn_v4_0_3_stop_dpg_mode(adev, i);
> +		vcn_v4_0_3_stop_dpg_mode(vinst);
>   		return 0;
>   	}
>   
> @@ -1425,7 +1437,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
>   	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>   
>   	/* apply HW clock gating */
> -	vcn_v4_0_3_enable_clock_gating(adev, i);
> +	vcn_v4_0_3_enable_clock_gating(vinst);
>   
>   Done:
>   	if (adev->pm.dpm_enabled)
> @@ -1662,13 +1674,15 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   	int i;
>   
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
> +
>   		if (enable) {
>   			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
>   					 regUVD_STATUS) != UVD_STATUS__IDLE)
>   				return -EBUSY;
> -			vcn_v4_0_3_enable_clock_gating(adev, i);
> +			vcn_v4_0_3_enable_clock_gating(vinst);
>   		} else {
> -			vcn_v4_0_3_disable_clock_gating(adev, i);
> +			vcn_v4_0_3_disable_clock_gating(vinst);
>   		}
>   	}
>   	return 0;
> @@ -1679,6 +1693,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   						 int i)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> +	struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>   	int ret = 0;
>   
>   	/* for SRIOV, guest should not control VCN Power-gating
> @@ -1694,9 +1709,9 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v4_0_3_stop(adev, i);
> +		ret = vcn_v4_0_3_stop(vinst);
>   	else
> -		ret = vcn_v4_0_3_start(adev, i);
> +		ret = vcn_v4_0_3_start(vinst);
>   
>   	if (!ret)
>   		adev->vcn.inst[i].cur_state = state;
--------------EFs3PTKlT5SugH1FHsJKzOus
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
    <blockquote type="cite" cite="mid:20250131165741.1798488-18-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-18-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 93 ++++++++++++++-----------
 1 file changed, 54 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 1407cb4b553b7..a3fbfaac76603 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -431,13 +431,14 @@ static int vcn_v4_0_3_resume(struct amdgpu_ip_block *ip_block)
 /**
  * vcn_v4_0_3_mc_resume - memory controller programming
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
@@ -505,14 +506,16 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_3_mc_resume_dpg_mode - memory controller programming for dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Let the VCN memory controller know it's offsets with dpg mode
  */
-static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					  bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
@@ -619,13 +622,14 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 /**
  * vcn_v4_0_3_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t data;
 	int vcn_inst;
 
@@ -712,16 +716,18 @@ static void vcn_v4_0_3_disable_clock_gating(struct amdgpu_device *adev, int inst
 /**
  * vcn_v4_0_3_disable_clock_gating_dpg_mode - disable VCN clock gating dpg mode
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  * @sram_sel: sram select
- * @inst_idx: instance number index
  * @indirect: indirectly write sram
  *
  * Disable clock gating for VCN block with dpg mode
  */
-static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t sram_sel,
-				int inst_idx, uint8_t indirect)
+static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
+						     uint8_t sram_sel,
+						     uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t reg_data = 0;
 
 	if (adev-&gt;cg_flags &amp; AMD_CG_SUPPORT_VCN_MGCG)
@@ -763,13 +769,14 @@ static void vcn_v4_0_3_disable_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v4_0_3_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_idx)
+static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t data;
 	int vcn_inst;
 
@@ -814,14 +821,16 @@ static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst_
 /**
  * vcn_v4_0_3_start_dpg_mode - VCN start with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  * @indirect: indirectly write sram
  *
  * Start VCN block with dpg mode
  */
-static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
+				     bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev-&gt;vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
@@ -849,7 +858,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 	}
 
 	/* enable clock gating */
-	vcn_v4_0_3_disable_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+	vcn_v4_0_3_disable_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -899,7 +908,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v4_0_3_mc_resume_dpg_mode(adev, inst_idx, indirect);
+	vcn_v4_0_3_mc_resume_dpg_mode(vinst, indirect);
 
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
@@ -1146,13 +1155,14 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 /**
  * vcn_v4_0_3_start - VCN start
  *
- * @adev: amdgpu_device pointer
- * @i: instance to start
+ * @vinst: VCN instance
  *
  * Start VCN block
  */
-static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_3_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	int j, k, r, vcn_inst;
@@ -1162,7 +1172,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		amdgpu_dpm_enable_vcn(adev, true, i);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v4_0_3_start_dpg_mode(adev, i, adev-&gt;vcn.inst[i].indirect_sram);
+		return vcn_v4_0_3_start_dpg_mode(vinst, adev-&gt;vcn.inst[i].indirect_sram);
 
 	vcn_inst = GET_INST(VCN, i);
 	/* set VCN status busy */
@@ -1171,7 +1181,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, tmp);
 
 	/* SW clock gating */
-	vcn_v4_0_3_disable_clock_gating(adev, i);
+	vcn_v4_0_3_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_VCPU_CNTL),
@@ -1225,7 +1235,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 		      (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		      (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v4_0_3_mc_resume(adev, i);
+	vcn_v4_0_3_mc_resume(vinst);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15(VCN, vcn_inst, regUVD_GFX8_ADDR_CONFIG,
@@ -1319,13 +1329,14 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev, int i)
 /**
  * vcn_v4_0_3_stop_dpg_mode - VCN stop with dpg mode
  *
- * @adev: amdgpu_device pointer
- * @inst_idx: instance number index
+ * @vinst: VCN instance
  *
  * Stop VCN block with dpg mode
  */
-static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int inst_idx = vinst-&gt;inst;
 	uint32_t tmp;
 	int vcn_inst;
 
@@ -1351,13 +1362,14 @@ static int vcn_v4_0_3_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 /**
  * vcn_v4_0_3_stop - VCN stop
  *
- * @adev: amdgpu_device pointer
- * @i: instance to stop
+ * @vinst: VCN instance
  *
  * Stop VCN block
  */
-static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
+static int vcn_v4_0_3_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
+	int i = vinst-&gt;inst;
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	int r = 0, vcn_inst;
 	uint32_t tmp;
@@ -1368,7 +1380,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		vcn_v4_0_3_stop_dpg_mode(adev, i);
+		vcn_v4_0_3_stop_dpg_mode(vinst);
 		return 0;
 	}
 
@@ -1425,7 +1437,7 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev, int i)
 	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
 
 	/* apply HW clock gating */
-	vcn_v4_0_3_enable_clock_gating(adev, i);
+	vcn_v4_0_3_enable_clock_gating(vinst);
 
 Done:
 	if (adev-&gt;pm.dpm_enabled)
@@ -1662,13 +1674,15 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	int i;
 
 	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
+
 		if (enable) {
 			if (RREG32_SOC15(VCN, GET_INST(VCN, i),
 					 regUVD_STATUS) != UVD_STATUS__IDLE)
 				return -EBUSY;
-			vcn_v4_0_3_enable_clock_gating(adev, i);
+			vcn_v4_0_3_enable_clock_gating(vinst);
 		} else {
-			vcn_v4_0_3_disable_clock_gating(adev, i);
+			vcn_v4_0_3_disable_clock_gating(vinst);
 		}
 	}
 	return 0;
@@ -1679,6 +1693,7 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 						 int i)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
+	struct amdgpu_vcn_inst *vinst = &amp;adev-&gt;vcn.inst[i];
 	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
@@ -1694,9 +1709,9 @@ static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_bloc
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v4_0_3_stop(adev, i);
+		ret = vcn_v4_0_3_stop(vinst);
 	else
-		ret = vcn_v4_0_3_start(adev, i);
+		ret = vcn_v4_0_3_start(vinst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[i].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------EFs3PTKlT5SugH1FHsJKzOus--
