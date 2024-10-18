Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6217AD3F2BE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 22:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0202610E389;
	Fri, 18 Oct 2024 22:15:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DvDEacw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A3610E389
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 22:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6VnzWUZGQ43NtPWNMHFlf8Xt07TGjKRnjL/UN+Y52ktFQZxL3r28ycDmiSPamTQK7gPHUg8AHv5IPhk/ua7TxmPTOKUYs29ltO85mMqxhO3fqsusWoGA181jScrstOB2j97CuNOxXmdGiqFdTjswkxvJ4lF2DI/GpTRRNWUreXjU9f49L6zeOzbgLDDtrNbTz6oRrIagDWhpOd/tKwyTe4Wr7bPFupx4j2rS97WG6fyvNC3nYBRqjj212ffHaNePU62vcjNG1AuqI6pVBRiBp8Uy/meF/WtGeBZpCaHNv0O7KUkUlTJ6T8N001yccgwuTAL8ePDIzZzdngO0Kq58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxNEh5/k2tCf17FiOb/0qn6RKM+hGy8VKWcfhqYxZhM=;
 b=cCfHtXa6fhPkv0/DX8ZAzXwnM9D/yFAgsCnHOLB5++B+c8auXKJ+eNZQwlzFthdGMgGG8apU/cO9TqKLxz5ZVR7jLepQxP6OQl2FhLdWuJBnxp5v1yk6V3V3U4U36XTKqLeLzrSQA9LJ/nvFOVWF70H+E3F9ck96lKb8gd2oEm1Yy3alnkd6hNBaLskYUAsf9ZJH6IWaXeiFL4SrpJRCq9rTmA+S0p1K54UUNk79rIw4V02QIbRZMEll0FMAn6bmBVKrbWvsJSHhzkBjoPTGNSPCDTxq4x6xGYlK+N1GaVuA24driJktCVyw9r0MfwSu1vDXebySOwn2YqOzdPGQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxNEh5/k2tCf17FiOb/0qn6RKM+hGy8VKWcfhqYxZhM=;
 b=5DvDEacwNUnyRCVbEXUk/XLV9pSOezaMTw/6zYDO/jTMrJ2oougrSRzzlGZbMkf7QWD6Grz/9VMawKBghU5SefqVW0QC7Q2VYXsAJc6ZcwRlXNWS6GdNDyeqVwrjQ2AewxfdK7iyZG8/HmK2ekcAsOagYvWXR0ZzkWefZtUtgjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 22:15:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 22:15:09 +0000
Message-ID: <dec1882e-75ca-4349-93ca-a538969e2bc5@amd.com>
Date: Fri, 18 Oct 2024 18:15:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241018202128.97719-1-kent.russell@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241018202128.97719-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 799b90e2-7dc2-4c6d-87e7-08dcefc25405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0laeStEY0N5cE84RUlLaXdNSUsyc2JsMjQzT1JjQ3RtMmowUStMN1loL2VM?=
 =?utf-8?B?MnNkRGxFUnhnejhRcUhkRXFTVWNERzgybGNBWVowcHBTeEgrNGF1cDFHV01t?=
 =?utf-8?B?RzJDNFpKK0J6a2VHenFJemxJQi9LZG5vWEpyWVdRejZMaTFxcWpRL3N5YmVK?=
 =?utf-8?B?TGwrN09ZeEsweWxpV3FvdXdKWjRVOUxOaG8wS29SaFIzNlk2U0tpQ1lqZEVa?=
 =?utf-8?B?ZE9KZGlEN0xyanN3RHVGZmZ6WDN0SHBWU01hQWhpTWI1WmlZZGdKczRLTGJ4?=
 =?utf-8?B?SHBKa002aFd1MmhCbytYOEpiVzFldUtybDIvQTE3cHpWQk1RUXp0Q05nKzFp?=
 =?utf-8?B?ZXlRUC9GZ3ZYTWs4OXJ0VzZSWnV0VkhSUzVPRzlFa25JNkxFd004d0FSQkQ0?=
 =?utf-8?B?R2tKcnh6Y1k5UlQ4bnJWVE54b0MxblZJbEh4cUZ6M2NLOHI5aXQ5WmFzd2xD?=
 =?utf-8?B?bThSL043NUJKZXNFV01Kd2pZNVBOOHZpVVF2RkJScXdYMnhqbFY1NHJTWXFv?=
 =?utf-8?B?dTg3S1JORHRoQm13S1FmNkhNeW9xeEdrRjQ1Sk9ScE02ZWcyTVBXQ2RGbEk1?=
 =?utf-8?B?RXpzNEQ0QjB3dUZzQlo2b0xvUTJvVGpUWEJoRXpNWm9TQU1jYVQ0N0RjNzIz?=
 =?utf-8?B?RzI1STE3bXZEMzJDK1Y2MnByRHNySGI2b09KbjRBcTFkcFR1dURjU2cxbWMr?=
 =?utf-8?B?aElWaUMyNGg5RTQ1bkZ5NTFIUjhWVXZacEFHQllHcTI2RlFRODhDRmlZTmo0?=
 =?utf-8?B?eGVWK1Npc3VzTFdtOVUrZTIzckpoWFlvNzJpZVVOdlFCM21YUDlETXFtRWpy?=
 =?utf-8?B?WnlTK011bVliSTJScHpjS0tySGFSNmF4Tit3TVpibzNKR0dXVjd6VDZtREdx?=
 =?utf-8?B?VjNiSHBTNzdHRFk2SnBxYzhjSjFmMVJEZUJtK1hHZ0RGRHB6KytDZDk1bEdy?=
 =?utf-8?B?WTdQcUt5UTVDWU80aUFyK212RWwvNXJZeWdYK3N1OFd6SHA5ajdiYU5GVW5r?=
 =?utf-8?B?VDI5MWlZZkFySmI0SXFWM2lBSmU5Q2JpaHVndGNOY3EzYnZMN05rMVpkczQx?=
 =?utf-8?B?RmwyeVBkdVY1dnNXbGZlTmhTR1oxZXlsZGJoOFF2TmNEaWQvcGF2WWdldUQx?=
 =?utf-8?B?VkRKbUltR3hGWHBtbG4zem5TQUZFVS8wOFpyM0hLelFvdXVoUjZGQStFTmxq?=
 =?utf-8?B?MmR0M2t1UXY2OU5za2tQNCtIbm8wY2JPclBreEYvTmJRYm9xRFZUcmpOS0w1?=
 =?utf-8?B?VGkrQzRVQ05wUVFwTHZGeTNtWjVyT0x1cUlnQVRTUTNpTjArYUdxa20xN0V1?=
 =?utf-8?B?MU9iODJzVHhGdlorZHRkK285aDhHa0c1VmorTnduU1N2amhZTDlCVUdxTHd0?=
 =?utf-8?B?RDhtWDdpa3M1TlJEM3BpcWtGbktNVlRHUlJPQ0h4anQwVUVLUHFMVk1rdTU0?=
 =?utf-8?B?R3lOYit4L0pxeTRyUjBFUktyMzh4RjlzWWt4enk0dHRqTTd1c3hFaE1MdWd6?=
 =?utf-8?B?endlbElBMGFsZVVoMDVZVHNyZ3RLR1hmVzFHeHFjQTBUK25IUWM0RFlSZXZn?=
 =?utf-8?B?NzVua3NQZUNOSHo0SEVsUjJFbVRVMXlscVdLelFOaTBaMEhBb3FvY3BYNnc4?=
 =?utf-8?B?NEJsWXhxNW9BRGxsSWo0c2ZoM0tkR3FKQ0VCZmQ2Y3p5NHV3YTZCelJBa1pU?=
 =?utf-8?B?UlYzM21iQkFGZEpIeFd6Skc0L2xBb0pBTWphaGtQQzQxay9SeWJrVWhRZWs0?=
 =?utf-8?Q?jhaU9ggePCgCUuFB0Sl00wGwRokKIhz5y+3Mxqj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFErYnl2dGRZTVJId0RzUm9Hb240THVtd21MeVg4czdVYW9vYXZwVWVKelBi?=
 =?utf-8?B?TjJzWWlOdkcxZDdZejcvNDdqY1NYMGdHdEVtWG0rVTFKMUJQdjNOSXlqZ1dl?=
 =?utf-8?B?WlFoNXpOMkp2ckZraEFzeCtHQno3WlZrOTlpMnJxSFJvdXVDRFY4Wlh1YUNR?=
 =?utf-8?B?dm91SEtycU04b1RRUERNNTN6NkpMcDJVZWRoU2FpM1BQbWZvNnNVVllZcHZn?=
 =?utf-8?B?TnFnQnFKZzFqOHJGL2FTYStXUHRmMDZQdDdMdGFPdUZWOEh0c01Bd0FReCs3?=
 =?utf-8?B?YXRiYVp6VlphS2JURXI1dC9BdVVyR0FlKzhpTjBMSmhSb3dtTWllaDN2R1o5?=
 =?utf-8?B?VTlWSTFwY0dobThBRmtORGI1Z25neUhKUWYzRXdLYytmUmhTSkdxanRTaWcz?=
 =?utf-8?B?aGVlbGxHRTFqRzF6bVZwNDRZU0VKbVIyMlVxRDl2dE4yVkoxNSs0RW9GTlVH?=
 =?utf-8?B?aVRRdHRHSk5KaDBQK3pNdngwbyt0V0pIK3ZsNmhYUG1kSHJIQzBJNHFDNEw4?=
 =?utf-8?B?UWI4b1crTzlyUkV2OWovZzFlSnp3SzdQN29zeElxSHBXSkcxSzZieVpzclE1?=
 =?utf-8?B?V3piWThEcFRldGV1bnpONTJQNkRIcWgzd0wraTV3SjIrRjhsK1VXZ3Q0RHI1?=
 =?utf-8?B?cTFvQkRCaW40UGNVSDJGTlhCM0tKZ2Nlc2ZGSm1HWTZHSkh3ZmtLeHpMdGRs?=
 =?utf-8?B?Q2dhZDRIVXYxeHhrQmRxdHNMQXJMNzZuVEZWLzB3NVZDZWNUVDV2OVRKMEQr?=
 =?utf-8?B?RUZOWWsxSytPK2NWSVp1U0tMNUw3QUtBNCtrWXdWTlM4WTcwUW0xRG1HVUxD?=
 =?utf-8?B?MGU1TWhwQkE4TG0vdzA4VE5mUWZ0MFRKZlBDMHBUZzJWYzRDSWY1VzZQRUNG?=
 =?utf-8?B?ZEEvR3FtRDZMNUV4ajJBVGx0aUZZMUkyTVhFbUZWckdVUXlJb3F4Qnp1OU01?=
 =?utf-8?B?UHNZU0NBclovTnVCdDhwbFM2RFJ4a1ArYW0zVHRWV283dE1WL3NWaFZYK05y?=
 =?utf-8?B?NllGV2tlQlBCNlJNTHJKTFZwZFllck9kNVdZYkZibS9tcmx0cmhnVW9jYjZz?=
 =?utf-8?B?SnN6ckdWMnFRbHpXaGFaNEU2bXg2TjhtVFRuR05qQjFRclZTRm1KOTBxcXJV?=
 =?utf-8?B?SkEvOStkQ201bGYxdlArN3Z6SmVzZk1TT3gwRC9GZis1ZDlRdmZUSmpEWDh5?=
 =?utf-8?B?S212NFE5bWVTT3BjUm1PWFFnQjgwYXFldGR4VVYxU0c3clh4YjQzUXlmdEZD?=
 =?utf-8?B?eGR1ZkhWdzRndjhpMjZGZVpXVW1uWkR0bExyNmJRSTNFd3FoSURiVXNjdUJn?=
 =?utf-8?B?a1cxRW1zS09wemZhcFpRT0owS1dId0RWREFNREVvc21QNzQvVmhrTkV1cURR?=
 =?utf-8?B?OUVpWWdFTG5jT0gzeWVvdnRJekdINnV0c3pnOFdCM3VVVSttQXFlbHJoNk9Q?=
 =?utf-8?B?c3pXTTFCWGt5TEFwRHZ5SU51eUZvL2JVVWJUcFhWRzF1TUcySlpsbmVYYVEr?=
 =?utf-8?B?SS9DNjJ2MkhvYUVyRjVHTG9rRXB4d3lEOSt1V0lNb0UzSDltSWlyNkJqS1h2?=
 =?utf-8?B?OStpN0VNZ1h2NUl3MGIxTUIySEl0TVpWZXl5S2N4d1pmWFVuZGMvVnB4SlRR?=
 =?utf-8?B?YXRlamJ5THJZSHFJdFlFdmlNQThKTlIyTndGeXJCRnpabHFOdm1DamZkb0Vh?=
 =?utf-8?B?MEl4RnZzMEJCbFo1THFpVVZWSE5pZU1TMGdGZDRjMG5udlIwZEM1ZUQyZjJW?=
 =?utf-8?B?VnFWRUtKS2t6WHBUdSs3TXVnZ08zci9udW9PWnhPMnB5cW1jODQ4dVlqUVZF?=
 =?utf-8?B?RXBjKy9rYU9hTTdxaXpyTzZUNjhxVU81L0tTNndBRzlCNFNVVWgzdEZtRXlH?=
 =?utf-8?B?ckJ1eVBua3QyRXIxNDEyWWFvZWNtTWhKWU9pOU9iZzdzT1IxVWhPLzkxUlRz?=
 =?utf-8?B?cXRDbWFKVVh0eFVlYzcyMDB2bTZrV2oyTENHSlMvaUZhd0NaWkxMN1NtdVhv?=
 =?utf-8?B?K29ZSFpJTEl5QnBhRnhEMk1IWHdTakNvNkNSMzZPN2FqdW9XeUpYcjk3eGNo?=
 =?utf-8?B?U25xcGp5aWxvWDdVb2lBQTlQallIZVBuN0MzMWNWR2l2ekVCY2p0MlZSSjdS?=
 =?utf-8?Q?rj5hI4zXRdbDXuM/GORa+icC4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799b90e2-7dc2-4c6d-87e7-08dcefc25405
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:15:09.3440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBQiFJuDe1wWRvfaRZ8tjTkDpfiEYL7sXL43FT2cATrp3EFU2OUZ+amik/Imwpldr3CCs+pOKtYoTGvfkzYLaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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


On 2024-10-18 16:21, Kent Russell wrote:
> If a 2nd fault comes in before the 1st is handled, the 1st fault will
> clear out the FAULT STATUS registers before the 2nd fault is handled.
> Thus we get a lot of zeroes. If status=0, just skip the L2 fault status
> information, to avoid confusion of why some VM fault status prints in
> dmesg are all zeroes.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 ++++++
>   4 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 5cf2002fcba8..5fe7a1c74ff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -175,7 +175,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>   			addr, entry->client_id,
>   			soc15_ih_clientid_name[entry->client_id]);
>   
> -	if (!amdgpu_sriov_vf(adev))
> +	/* Only print L2 fault status if the status register could be read and
> +	 * contains useful information
> +	 */
> +	if (status != 0)
>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>   								   status);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 4df4d73038f8..25a3dee27d81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -144,7 +144,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   				addr, entry->client_id);
>   
> -		if (!amdgpu_sriov_vf(adev))
> +		/* Only print L2 fault status if the status register could be read and
> +		 * contains useful information
> +		 */
> +		if (status != 0)
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index e33f9e9058cc..3dee7474c06d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -137,7 +137,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>   				addr, entry->client_id);
>   
> -		if (!amdgpu_sriov_vf(adev))
> +		/* Only print L2 fault status if the status register could be read and
> +		 * contains useful information
> +		 */
> +		if (status != 0)
>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 010db0e58650..f43ded8a0aab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -672,6 +672,12 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>   	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
>   		return 0;
>   
> +	/* Only print L2 fault status if the status register could be read and
> +	 * contains useful information
> +	 */
> +	if (!status)
> +		return 0;
> +
>   	if (!amdgpu_sriov_vf(adev))
>   		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
>   
