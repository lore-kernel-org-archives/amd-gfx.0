Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD885606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=p6mC0/Tj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7671D10EDF9;
	Mon, 26 Oct 2026 10:51:15 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010056.outbound.protection.outlook.com
 [52.101.193.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7230310EDF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sf3C88PsMLKS3p2M2Ugs6VbuLXGl1tfWXu2iL16hsCzIJz5Mw2+ywemD6URI2Pt7RSA5tS1aT1nZJ+aYAWtg+Y+c0TUEbs6f2RSAFxM24Rn2HbpLu7ihautvBUxI2/ad0Kl2OMswEJwvWPwNTSTj2u5YPTUA0yE1e5LxqvkeLvUnkQCycbFHbIBMW0BcRxt9d39jfmuEdQ7A+qeqWSK6090/CmcBcrcYtjoECJExGXdjPjkWGnz9EPOsZchOwyd8E4sfrwkDMkZLnyApeDTFbxkL/8kqsA3NkXI8cH5YGpD2ggHeeVrJfhOT0T09a6EYXnjzcadOy737jatMU6yCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVHlX89NToERyreW94itw2d9W3PDyPvIHlQbixUQOUw=;
 b=NV46rYuV9eEXApUsrzt12eKEh6gvbVQI2cMx57fF6HtdEQLJwA/EYMMPEdUcg+SAPiqV7wbNgnLQUNN1iftAkJPkZGT641omJJwfyzQSIBoAq5+GgDueZmAF/90Y1GjwxYrNcBBp5s5HFGafLvEcX0WLL2Cit97rOmSYWrJyWXqwM4gdivzL8fSyOyTzJcNYXGh+PuQMmNBu/c+R9sA2GNwRBXmD/jP9Tpaj20pCAlPJQ4zvgHfK/e5vJx3GZ3AsM5mbBN0vySR0FFpk+P5ktMa03z3xHKUQhwMKSEFtDRowx0fBDV/sXwl6hfncUGK+mbIRneOiBFLJng7/TTt83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVHlX89NToERyreW94itw2d9W3PDyPvIHlQbixUQOUw=;
 b=p6mC0/TjNkelhWi8SfhMzvbAY6UC4649PIquMkWMpCpFdCMdF2ELKDmSrMvl/9rRT+/5ivBCNIAkl9l0UIVEjPeCWGExcZBS4c3ATecHuDxiIzPKdl5b/YGPsYGjppisQYMrRcaIR6UlRCS03zr6JL4tg/2I95SzeD6r3jg20bo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 10:49:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 10:49:03 +0000
Message-ID: <4121d6f0-c22e-4527-b2ed-acba18f70fe1@amd.com>
Date: Mon, 26 Oct 2026 11:49:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: parse CS IBs at the BO offset their VA
 mapping starts at
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, David.Francis@amd.com
References: <20261023101246.937830-1-Jesse.Zhang@amd.com>
 <20261023101246.937830-2-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261023101246.937830-2-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d43c99-8a2c-474c-fa81-08df334ec057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021135927099003|261021133027099003|261021123027099003|261021121427099003|261021130227099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 4JTbxkXPPDsTB96TNhEe2gJqBng/f189anisHpfeLifHSj2Nzb+6/AMEKLUfl/42Xv+GmRCnJf7aPaUcrr2CkoptSBCi2LPGjNZWWGwuQC2Shy4ClCO0dwyv/hXaxyKgio9tB9R/yabhkhtj/aipIxGL2X5peHdaLVyOt3sMn+hFq53PuYVMEl3+AfICZIg+4clHSWzbq6pP8OzhdMxUnEpmvVoUPeJnqPGQ0gXL6cy01L8DZCe/rghmxxz/+2nOZvouzuYeGsWK/BKDI6leEU5G3rK7yrJxq79ZtOulSUdNIdOQeqdJC2/6q0IoiTtEgKr0eVHBMbGNukhby2RUNgYjSHHscuu1VzUpGMMKp+2Sr3mn+NM5J0CtJwZsHclyisf/4ZU2VYk4NJGPwnHwqAYbK62DT12RBnMNCqtZkZutoSFOigC5kYhEvglZqF6qMkXevyiMRcZ/B3o75LIU1wE4hJksOmlGAAiyAkW7sWGd76cFGhEmGnjwtC5/zwsSWaDhoSnrIyv1lhPD7PPfCKKkyhayc0fSdC7AGHiYSPsc/rXIxwIZHkNiUnkDHZdzEBl+nVYQnuX7LOhivksMYFB1RzAvcSv9xNhPq1SXSwbkd4EPBNvCaOetH9PJd07HB8WFRuSknBp2LDE+TKiZnHc2sRgInYRJ1SoP/Bi7jyw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021135927099003)(261021133027099003)(261021123027099003)(261021121427099003)(261021130227099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnNGNnJ5eHpCM3ZiSWZIWDh2aTU3MVd1QUwraDdFcHdpVFVXM3dqTzhMdG5m?=
 =?utf-8?B?b1dGTHlEclhVV1dWMVlHQmgrUGpqaWVWSGt5WW92elpSME1yZXA0eHBmZTUy?=
 =?utf-8?B?bW5FMTRnZWV5YjBCUCt5Zy9YemhXUDc4NlJ1WWh0VXpGZittcXU4UmRqQzR2?=
 =?utf-8?B?Ny9HOE9ORkxUaCtPcTJ5MHhrMXVNK1hQN0FlSlJ2bU5qbTQ0R3lEYk1kb2w5?=
 =?utf-8?B?UGRYR3ArV0ZXZ3FXZ3Z6TytLVXVwc1VjdEwzRmhXbGpHR3NobnMvRDhmM1JW?=
 =?utf-8?B?VXZwc1pnYk93TEh2Rlp2SGNjQzE5WnJiTUxNbHlkbTZ1dHBvZjNFdnNOQWJW?=
 =?utf-8?B?bUkrYVBDWXJES2QycFM0OE9FTlVEZVY0K2xkczAySW8wM3c0V05oTzBxSVpz?=
 =?utf-8?B?WlNOdmtNWEl1NlRGVHdCUUYxN2c3M2cvQ01QWHVSTXRLanVJOGs3OGZyWisz?=
 =?utf-8?B?WEVSVG14UEpNRUdmbmg4ZDE2RVFjbnhOSHhWR0N1d0hTM081a0xlM2puZEpo?=
 =?utf-8?B?OHpnS3JsU0YxMjVQM2I5eUN6Y2oxZ09BSHpjU1VWMjJVamxxNTczN0lnOHpj?=
 =?utf-8?B?Y1k0MDFiMitGSUNuMDlSam4xRUhHaDRCL0h5UnpBZ25hN2hXcU9RL2M4MW15?=
 =?utf-8?B?alFwYkpiMVBvU0VyWHcyQXhYdkhGWDk1QW5nSXIwVys5ZDM0MitDR3dPaTJN?=
 =?utf-8?B?RFBVaGN6SlRGSEtSTnV2aGJUVlp6cWxlM1lIdmZQSVZwSmRqbTQ0emtvaEg4?=
 =?utf-8?B?d2hNRXBYM3NUTXpGZ20reUhiSkxETml2WGxBNk5WQWJKOS8zeXJLcnN5TkJa?=
 =?utf-8?B?a3h0empqak9VNkZObVl1MkdaZUdoYWNmaWk4VGI0YkRBVnRuSU5yZkVqN0lx?=
 =?utf-8?B?bHdpODZEWENaZ2c5WkxoenJRMjhBYS9oRGZWNno4Tmx0b2NteUxheHpLc1lY?=
 =?utf-8?B?aVZGbWQ0Tk51S1JJMlhHYjFkUy96cGVyRUJYcVBPdllUR1MrYlpsTzlLVDFz?=
 =?utf-8?B?a0VGQkF0ajE0N0FqcHlwUnlKWTJQVFBoUlRPNit6NVBmY2haSGQ3aVdldDFS?=
 =?utf-8?B?anA3eDk0WVlDazlnM1JTQkRxN0x0RmpVcElXRG5DUWdsWWkxeHRiQ25xT2VT?=
 =?utf-8?B?MUF1VHphOTVQOFZORng3NEVCQTRJR1FyMHBLWGNKRXZtdUd1RW82aHF6aGFl?=
 =?utf-8?B?U3A0eVM5ZTF2SnQ2ODQyUlVyTWpPelFhK0dseXZkQkQyQ1ozbFVNOFVpU2N0?=
 =?utf-8?B?K2IyNUwzMm5yZWlVb1F1Y3QvaXVKRGsvbndTeDlvdm1kRkpKN25Ba3h5WGlD?=
 =?utf-8?B?RkN5Z0poYXFGYy9aYzF5NEtKMCtlb1AxeGU4Z3FjdkJHbENKMHdLcjBLaGZa?=
 =?utf-8?B?aDEybGp0b0dTajZHd0w3NzB6eEFpbjA1QU5vTTg2Q2R1bWZlRzBZRWxYZTg0?=
 =?utf-8?B?d3diUEk2MWdDRU4rOVlZMG1JNDI3Yk5RSFQ2VDhmdFp5ZWQyNWV2Z0I4Mjls?=
 =?utf-8?B?azdidDEyL0N0Q3FiUGY1bGNyV3Mxa1MxUmtJTlNNUVMxTGpIOVRrS3BiaE9s?=
 =?utf-8?B?QlZFZktEbmt5SGU0UTRrYVpEVCtXaVVuajVtQ002OVlvUCtBODI2VG9ETHBy?=
 =?utf-8?B?RGFpNElWV3JGSTIyMlpHMEU2UzliWVVERFhrYzRlNEEyMlNUZEVzK29BNXlV?=
 =?utf-8?B?UFBNeE9SN1AvUGk5VnB2TFFFTUhyR2RWTFdZS2Z6NXNtREw2UGpHeHZiNWRR?=
 =?utf-8?B?YnVaaUh6QnkyaVpWTHVrRTByTzcwUW43ZjdLTENyUi9MZkRGTTlEK2pqS05F?=
 =?utf-8?B?dGt1QUYxSTJYVll5UXh4WU4yc1htTVgrVExwbDFFd0x0clozb0wrZFBEa1dC?=
 =?utf-8?B?clNIc3ZxMk10RWp1RlJwYWRIeXRVclJGMGszL1BiMkJVV1pzbzA0Zkg0OEtG?=
 =?utf-8?B?Mzh2WTM3L3phMGRrbEx6YmNRaXU4Q1V2dm0rekpZaFpVQnp5SUJ3aEp4ekov?=
 =?utf-8?B?VkYwSWVOek5NNThzYmM3cGxlNFJ4aHNDYWRFTHNlMDR0Q1EwenRhK0VEakFW?=
 =?utf-8?B?LzA2NWcvY0NBWGxpRDBqaGRqNStvY0pnYUtOd3ZOQjQwMUwzaEZ4bEdqbmJY?=
 =?utf-8?B?c0pwOElTc2ZMK1Yzc1VBWU1ySy91Zzl5amdRa05xOVNia3I5ZEJkL3hEdTNI?=
 =?utf-8?B?dkhVSHE0WFMyb1FzM3VkTlU2bmdLaUJOcWZDOGxZb0N3TEVvd1RVYjc0T0RI?=
 =?utf-8?B?U3Jrc0RZdkcwK211YXh1elA1czNDUlhLODMwVHUyTU1VcjBlaFZ5Rk9SaDB0?=
 =?utf-8?Q?IOkj99EmRbwNEqbTHu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d43c99-8a2c-474c-fa81-08df334ec057
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 10:49:03.8656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpvlnODbmgZk5DHRsSC/I9HNkadVob2sEve4GV4McpEn/ojNSJAXLc+SwmEAFGCL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 12:12, Jesse Zhang wrote:
> For rings which parse or patch the IBs on the CPU, like JPEG and VCN,
> the CS looks the IB up through its VA mapping and maps the BO, but
> ignores the offset in the BO the mapping starts at. It then parses
> other data than the GPU executes. On navi31, an IB of JPEG NOPs in the
> second page of a BO, mapped with offset_in_bo 4096, is parsed from the
> zeros in the first page and rejected:
> 
>   amdgpu 0000:03:00.0: Invalid packet [0x00000000]!
> 
> while the same IB submitted through a mapping of the whole BO works.
> 
> Add the mapping offset when locating the IB in the BO.
> 
> Fixes: 4802ce117786 ("drm/amdgpu: fix UVD/VCE VM emulation")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

IIRC that was brought up before, I wonder why that patch wasn't merged.

@Alex do you remember?

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index fa301c71b782..4a277f04cde5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1073,7 +1073,7 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
>  		if (r)
>  			return r;
>  
> -		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
> +		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE) + m->offset;
>  
>  		if (ring->funcs->parse_cs) {
>  			memcpy(ib->ptr, kptr, ib->length_dw * 4);

