Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723D4C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EF710E614;
	Fri, 10 May 2024 07:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnSzqH5o";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DB1310E614
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:48:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMfYjuYr0Z+k/gn4McV7RRkbIvvT9V/Gr8Zg7SyUEVR8OMDzbVr1TtbSh1G+gXY5Q7wbhjDizZoU18xAKzi22eVPSWoxWprC0Fr/+UmTWCPCOdmmhkUoaToNvxkGSbOwPPyEZBxkM2DIk9YFDgJs1CDSYG1wz+Fbt1fyKAIGoQ63seUiSrrdgQcGo10ublz2BUzHYBABv+iBwHULGp4a1q9EndD1cYxTLzTVQcmuavimacB0gz8kkZ81KnhV6/cW4Bx/C78KdjC/roZGVEt2K7cGEQi5VOJyeuOH/yc6fT3Aj/8/3ieWSLVj6Rx+oOX7EXhfCnU9wJ5tMbrGXL408A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q39st+m8Ezys1FTW8z4FqlYtitijWwRAe0yLymJevns=;
 b=MBQnGfeQMGuBKkBRVhbhtKcUS2FtlJPKhMnVZ9qS1x3pFQg3rL2SEMV0B+NBKaq9UnMjfHEa5pzRjBw9SWYIAvUqeLVPMt3Fp98EcIamg4/SGonQRpwCOg8/q+CRazE2yw3Dv6xHATNXAKWm3KhNdy+cNKURHpdeNpf0zMUhj1SrF/KqjYMjBgGDMq3Eh7uYAWTveqRoWfqjOsvrVWTxh7typGWTx+EoFG6aR9QaOVIzYpHyXy4EZGy5fM0DQHq8UtWuXn/L9WAWf75VuRIzEMAoVh8+6S41BPltYzw0HWrSwqadJDzdCfG/pQDueJAiLABaKHAMDPGAQs8QMXYiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q39st+m8Ezys1FTW8z4FqlYtitijWwRAe0yLymJevns=;
 b=SnSzqH5oRxt8Iul2FBbn7F/aEENm3h9fXUr2F0taegoTCkoyhsq2dBfymIFN1L3BdR2ClzsQulfM00oJamFT4EdLffJCJEz6ny41fvR278+FyiQb38cZTT9cYaLfVzyhyv+zmJ77oGvOih694j5Q2dv7SA1TjVN6VoP0TeN4InM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Fri, 10 May 2024 07:48:05 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:48:04 +0000
Message-ID: <4ad1a088-53bd-4966-a922-b4de490256e8@amd.com>
Date: Fri, 10 May 2024 13:17:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by
 zero for the variable num_xcc_per_xcp
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240510025038.3488381-1-jesse.zhang@amd.com>
 <20240510025038.3488381-19-jesse.zhang@amd.com>
 <f82ed0c2-d90b-41a0-aa90-62ec8eceeffc@amd.com>
 <DM4PR12MB51521E176AA69BDBBED80996E3E72@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM4PR12MB51521E176AA69BDBBED80996E3E72@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: c54c7acf-08be-4a14-ae07-08dc70c5861a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N3pQVXl0cUhlWXI3OG81Y3IvMVdqT01pazNwVXFkM1c0S2Fzb2c0bUF0aXhS?=
 =?utf-8?B?TjNveUlMeWp6ZHdtRFJsOFBoQlIvMlI0YndxdVB0dXl3Ym13RmFBWWY0RXZL?=
 =?utf-8?B?S3ZCWkQ3WFR1KzBjTmxHaHZoYko5ajJSSW1PN2hMSXcyOFVLa0ZIa2pyYnpI?=
 =?utf-8?B?OE5GRmtYTk5odnJMQ1EwMTArYlBSWTRTQUJUa3pyRzJaZkFwdDZObjQrZWpX?=
 =?utf-8?B?ei82NHlsT2xYajNlb0dkSDQyN1krNEN4ekNBc2YzK1ViMkZKWDBsZi9OcXlK?=
 =?utf-8?B?bmRoaDVpUVZ3WG5HRllOR1IxeFNQQnNVU3lNZ0tzUVAvOHUzUWJwZUxFMUNM?=
 =?utf-8?B?VmIyS2tYUU0vYjBKb0sxNzJQQjg4WnZxNmJjQ0d2QWo4dmxuS2JjKzhldGdn?=
 =?utf-8?B?bVliN2JCeE04Y1Vsb3BBSGl6T09ZKzdLZkN2YXZ3dzZxZjFCUEJSNjduYVUx?=
 =?utf-8?B?aE11VUh5bmFRN0xKSWJyU0padHY4d1Qya2x6dDdiTkVsalBrTTZSNDliK1F6?=
 =?utf-8?B?ZTNUSTFwOXgvdzVlUVo4SVE1ZHR3aUNiQUJVRzh0MWdzOWNUSTZYWnRjTThq?=
 =?utf-8?B?dHhKSmZ3aVhqcmpBdG91Qm5QMDFPQVpuZDc4YXN5NXVUdllSR1pQdDlBVzNz?=
 =?utf-8?B?WktTb3RrRjhnZnZoakVQekt0bWFndEdjYXdPdHM2S2JTOXdvbE9USDEveWFJ?=
 =?utf-8?B?WGwxb2tGNVhKNE1oY3JyWllxekRKZmkxckZLMFQ2Rk8rdkZkZG9OSXZYOTB2?=
 =?utf-8?B?clFIcWJVQTU4NHRYMTl4UHNsdlViSlhFZE01dWk5dEk2clptOXkrcmNGMGQx?=
 =?utf-8?B?WFdvZWZrWVNseFIyeHRuTTVSZVcxMCt0K20wVDB5MnZXTkJxRDF6NHdDamNk?=
 =?utf-8?B?VmdxSUFLMkYvRGdxanY4QTlDanNqNUtGaGZHMTBCRnNVYTFXaG5EZU1zWGEz?=
 =?utf-8?B?Mi9VK2l5eWVhbVo0RFplVS95U3VpTEt3dXI2SlFGQVRPLzV0SEdWMmJxdzJP?=
 =?utf-8?B?UU1lMm81WGlHMHE2a1R5NkZlY0FEeFFreWN5dDQrM3dndHlyS20xNVFZSTM4?=
 =?utf-8?B?Y2lJcjhWY0xwVTU4R1BNbFpYUnVDR0lJMmYyMmlIRnViSlJ3bnRWQXYzOHFv?=
 =?utf-8?B?Zm01cmRXUHRENU5aMjVjRE1tQzV6MWlqOXBGQkEvbFFmRGNlWE5jd0hWQjZT?=
 =?utf-8?B?K0FxblJ0ZW9DK0tXV3FyVVBrSVVMakJ4Yjl6MStHcEh5VDhWcTNkNWFSYjYz?=
 =?utf-8?B?TG92bWxpbGd0S1hyLzQ4T05rZ0d6RUVSL2t3S0ljOWlBMitzL0p4RitLQjdV?=
 =?utf-8?B?a3p3ZXJNanVXQ2NSRy90YnFSVEJjNGZ4SUlYTHhzUkdTdE51UlFmWGs0eSt2?=
 =?utf-8?B?NlNDZGtROTNDRGVkSjQzaDh5STVzWTlLb1NzNTZrbC9wZ1NubHhKTnptVkVz?=
 =?utf-8?B?OTIxVHRiMnVBck1DTXpIa0d6Q1ljVE1SSENBRHptRGloMlpsandqQUJsTUJ6?=
 =?utf-8?B?N1h3OVJEekRvTGd2dnNrS0ZUazM0UEtVdXo0NThCeHllOUJVRzBHR2x3Ylpk?=
 =?utf-8?B?T2R4U0hxai81dWxreC9vM2M2NVRFb3d2WnhjUnhMV0cvUlJCdThTNnA5UjAy?=
 =?utf-8?B?WVA0dGI0Uy9adElUa0RDdkswVk03cFZrZGlzVGZLSC9HNU05S3RGcDZNVFNu?=
 =?utf-8?B?VUp0ZGJUNHZCc0s0N05ESGk1VGZzSHAwLzhaZTc2aURXeHFNTitlU2NBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBEZVhML29hWlhlYkx4a292Zy9jVEF4NGhZTWt4SGJUNld5cjQzb2NNWjh1?=
 =?utf-8?B?NWh3emJhUGd6NzZ0clhtbEJRZTlLaWNKM1dTdWphbWFzVmRUK1ZmRDJnUEEr?=
 =?utf-8?B?Q3VZVkFyeG1VbVNsWk1OdHcrdjk0YUhwdXY0aUtJM3NTYUNpQTBzV2ozTDJD?=
 =?utf-8?B?Tldlc3ljV2N5LzBEWkw1Y2pzOSs1RzdlUHdrV3NSU2FZVHFONWdLaXZvVjhM?=
 =?utf-8?B?amRacGFlZDRxQ0Rjd1pyajV1emVpdDB3VDFHSzFPZUNzL1dXNFJITVBmYnB0?=
 =?utf-8?B?S20zS2I4clFwVkpLMkpFUWdaS21GN0UvYlBoNVY3MkxMWmtIMVFTRG1jUHhs?=
 =?utf-8?B?RnZ4TmRmS0YyVWxXV0J2UDFiSmRYNHJQR1JScjZHUHZEMkJxVFkzb3JxUTRo?=
 =?utf-8?B?cEVUVmVLRlN4bHJqcFV2LzFSN0xrVWh0SEMvVk84NGR6WjJQY2IveERPR2F4?=
 =?utf-8?B?RkZrWlNEYjN6YU81MndnOWlBbU5QR3V3alZhNDZzaXk5cHlDSU8wRTc0T1Rp?=
 =?utf-8?B?akMxMXNVaTVCdWdldUpPQnAvbm4xeEpRUzJpVDRpcWExWjNWVXlKUmVpR2RR?=
 =?utf-8?B?dWlpc3NkV1AyZ1ZoQWIwQ0xBNFpFR0Z3MGd3L3VNcHZhVlNTc2NrRCt6dHpy?=
 =?utf-8?B?RnR3SUdxRFFsNDF2d1hZSkkxRHdxdGtDSUlrdXFsR3o4WjlWNWYrdFh0Y2tL?=
 =?utf-8?B?UmJHTTZ4R1RqamVFUUFtbTFNd0FqQnRyZkMwWVNxNkFVaVlvVnZuQnRYR0Jt?=
 =?utf-8?B?SEIyL25uSWI2cVVWRjNCbENYU0xuTEJEaFVWN0E0NXBXQWpoR2liZHVZQTJx?=
 =?utf-8?B?ckl1MW43Vkx1cFY4Ykd5NC9EOVhKN3BCRW9sdDJXN3FsQkcwU3RrNHpOZW5n?=
 =?utf-8?B?OVc1bGxKVDQzTk15S2Fpbzd5MnNSWGVtK1htd3pUaHo2a2ZPVmkvOXdwcVds?=
 =?utf-8?B?b3A5bFpjcFlGZlVZbDRTbHdmUzV1Ri8wVmMrb3ZySWdOTmRUVVpwa0t0Lyta?=
 =?utf-8?B?eWg3eVRUWkxmcXdTVEw1ZkNBazd1UjVVSS95K1h0ckFjVVpIOFRnUnNHNUp0?=
 =?utf-8?B?SnhNT2lrZEMxajZNVU9uZE9VRjc5N0VmaysvWTQ5d1QzeENPcEdPN1FyRnZM?=
 =?utf-8?B?Q0tiUDdTRzcySzZJZmk4dkkxNHdUWnBPNS82bmxkcllwVk5NSlVOWkJiUWJy?=
 =?utf-8?B?ZEFwTzJpdEVYV2c4eG1FQlp4YUxCTlVNTHp0UEhvaFFNTFBjSXc5UnRpRmxU?=
 =?utf-8?B?eW1JQllmakV6bjBEVTNyMXB6RHg5aWo3M2g2eEZaTnVscFBVUkVvR25QWTlX?=
 =?utf-8?B?dUFaSExVWFRKUjhscmtERjlhYVFYcmFnOWprQklRNGYxNjB2bzl6L2xEQnpC?=
 =?utf-8?B?ZjRqRFJORk5QR3o0M0VzWjVMdVdmWXMyNWlJTUxST3JzQitSZWJ3aURsbFVv?=
 =?utf-8?B?N1d4UDd6cWxNS3liWUtwUUhnZFpGVkRMYzFnT2tHZTQ2bkt3bzNwS0x5c3BX?=
 =?utf-8?B?ekNtS3Yzb3JyeHF3RGJsMlI4VUZTRS9JZXRINHVCZXlldDlYZVhlSTZSRE15?=
 =?utf-8?B?UENWYkw1VFFpVHZEaUN1NzFpZVhRcFNROGNLMmNCQjFTK3YwblU0b3ZFNG0v?=
 =?utf-8?B?Y3BjeUpVc2NpY1dPbzJsbXZwRFcrdzBZc08xODQwcHVTb3RYM0xRVk1vTTlp?=
 =?utf-8?B?cnVGTWhMSUxEZnh6d1hkRi9qNllLbTV4Yy8zbDJGTmJuVGFlUUthZFdLMWI5?=
 =?utf-8?B?Uk82ZWRxK29hU2lHeVg2ZTNoWElndGU5dUx6WE9QdmYvazZTZXFaSVROVzYx?=
 =?utf-8?B?VWR3VE91ZWMyd1A3RUNpSVliaDNGMHEzVy9jS3BnZ1RlN3BCWG1kRTNRSTdF?=
 =?utf-8?B?KzBhUFpmcEVLRWlDckJ1VU9qZ0V2S09tMFdacTZhVFVIZHJQLzlKVDcxYWVX?=
 =?utf-8?B?MmRsL3RLanlPaE1xZ3pKdFR0MDVBNk5GUVJwK29KcWFBTVFzRW9IdXhsQnp3?=
 =?utf-8?B?cXFHSnBDemtTcnlVOEdnN0pNRFY4ZVNHNEhlcHNUV3JjSFhDSW5uK2prem9F?=
 =?utf-8?B?bkpUcnM0Y09xT2R6M0xncGZtOCsyWDJlMm9TYVFQeGMwYkxhS25UTnVCOEVs?=
 =?utf-8?Q?t6GeXggHNevvBQZWfsotV/hOp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54c7acf-08be-4a14-ae07-08dc70c5861a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:48:04.4167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5Jt5qn62qozdUjpZWIq+zTuVWC6MhT9lPsxl+NLCL9+AZihLoDHhdSauA/YRRO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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



On 5/10/2024 1:09 PM, Zhang, Jesse(Jie) wrote:
> [AMD Official Use Only - General]
> 
> Hi Lijo,
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Friday, May 10, 2024 3:16 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 19/22] drm/amdgpu: Fix the warning division or modulo by zero for the variable num_xcc_per_xcp
> 
> 
> 
> On 5/10/2024 8:20 AM, Jesse Zhang wrote:
>> Dividing expression num_xcc_per_xcp which may be zero has undefined behavior.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> index 414ea3f560a7..5752c6760992 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
>> @@ -522,6 +522,9 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
>>               goto unlock;
>>
>>       num_xcc_per_xcp = __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr, mode);
>> +     if (!num_xcc_per_xcp)
>> +             goto unlock;
>> +
> 
> This won't happen as the mode is validated before and for each valid mode a non-zero num_xcc_per_xcp is expected. To satisfy the warning-checker, before going to unlock use a proper 'ret' value also (otherwise it will look odd).
> 
> [Zhang, Jesse(Jie)]  Is that possible?
> When the initialization mode is AMDGPU_AUTO_COMPUTE_PARTITION_MODE,
> and get AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE through __aqua_vanjaram_get_auto_mode.
> 
> If so, it will skip the valid mode function (__aqua_vanjaram_is_valid_mode).
> 
Yes, that is possible. If auto detection cannot figure out a valid mode,
then it needs to return an error from there without proceeding further.
That is a better fix.

Thanks,
Lijo

> Thanks
> Jesse
> 
> 
> Thanks,
> Lijo
> 
>>       if (adev->gfx.funcs->switch_partition_mode)
>>               adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
>>                                                      num_xcc_per_xcp);
