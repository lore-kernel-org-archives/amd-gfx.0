Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4E3C7113C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 11:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80EB610E040;
	Fri, 18 Aug 2023 11:53:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FF910E040
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 11:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5Na8QyX0C9O+AZ7wJLgV2ffVL+myZTmjeo+VZhBdY3u6QWnV/R5a2vM2V4hgQlo4XUIXJTLjTARFUmb00bkhPM/EDZmU2e88t1MlQRh+Vnnqo3tCnw2miRVxeU/bgkkEo/LVN8ma7bLUQWZWeFW4IX3PVBQXE5OIzJtIm/gXOhMrsMn2hTEgg7n2QLz4Bm3Skf4+jOx9ANP0arNtgBVICWJmPbqHHshjFzaVhoybWpddxKTWZNbN2xHruSncpsHC3Yl/IBdZKP54GBzQlBbZ68Pb2dqXLEz5tIPlzdQUbhdTxLoyHyB4M6hNkAcOQwWol8C9g5GErtiRjn201cYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eR5OZAJBtMRf9GMnbdIp37QFhcgye1QMiRSKYZcU97M=;
 b=f4bLz48U+/D4EqyVLs+aIBH2mnljiMLx8t9qpmSTBpmsGbt/PdZ6bokh0V1FHFHbPFPJUHYUyZtrNQX8Tn3daEVWH89nqAA9Vs1jz+jO/00ojyglm9+135HCDOX9AKYTve2b6A148jihGxWtJXyaZ80ygutXllhaVE+LH6mHAlRJ5tHKtrH67sQnz1DX/ea9zIkg96mcAKq+B18Bp0QNpQN9SP6h4WRb5Tb/bfH3uXz3ql1HZ49TmbUmbdtRlI+socj+77Vxo8l1koyMx5CXlX4ySqPPLnUj5gN35Ulgs7gGh1Bh86Qj87y03jUgogoWEVLn+MHtiwIGvHVPGDK4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eR5OZAJBtMRf9GMnbdIp37QFhcgye1QMiRSKYZcU97M=;
 b=PsnVtVEBmAcJamw2I0GF7SxxjuGv3iezl8xY9hKpbl3ZQ+UfpNaTC4bJwajo/tyzcd/WDk4A6acTFVkL6kjTNf71gG+yS+k7Jhr2K2RJuAbjpXQDZQoYtjatfKT4TyGOdH1Zg5yYg0ToRbJQtNQoZaKPxn0awCLPSUhd5Lf6MyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA1PR12MB7343.namprd12.prod.outlook.com (2603:10b6:806:2b5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 11:53:42 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%5]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 11:53:41 +0000
Message-ID: <1b00904d-a1cb-cbbc-52fd-d62663950237@amd.com>
Date: Fri, 18 Aug 2023 17:23:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Remove SRAM clock gater override by driver
Content-Language: en-US
To: Mangesh Gadre <Mangesh.Gadre@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
References: <20230818114014.3307151-1-Mangesh.Gadre@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230818114014.3307151-1-Mangesh.Gadre@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::7) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA1PR12MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e37898-de69-40a0-044c-08db9fe1c45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmEERXHSntsBlcWNUcTwZq4usM0o9guhP56sYvhL3F2qFwITEw1kcuKAP+xmQJ/CMAFz5+otxA4a6wtvMNU5w9gKpd2Jp46fBDLAWkiJlU9N9kHdtx9q+HmUr3FLWHeHMGi86WIGY9ZmN80BRlnZp7oFRkSMlncII4NDIa631BxIwUzmhZFC6QKtxUxL0lgqtXXpGDJ+cGRSBb+K7yml9dFpkQs8TZXvXPrBph5LkclDlhODWlGEI4zr//ihM0QyEqO4GeZQ72DUasWpz3qZbQbOMsU6+11F8YqxqJtuhujjUz6EgV83R+P49mZGirp8RVCmM0NWtYIAduVRYWVCAFDmgncFZVV2rvpanfhouFy9Vt/r8XrmukeqRV5tfTbMpVw0bJXzy23PVqF3lsYXGz0Z6jPU54pOf8Yh4pIjp9trG/g3NUriqoy5vIFNPpZnC6jRyxe5+YZ5qoYHkkbzGoPqMl+CEbkz+iu4ITq9QSG1nErN++hYQ16+9D/VtZL20tf1UUJZ0tAn8ddCGyu1JTuuu3tNZQKK1MUuYjUIQAro4OqQaGDMkFWLF+NZjwf7SMGCWxeY17PE5uDE5JWG6E2+IlzBZm5Jqj00EOKJ4ktKsPLWmG6XgOnfOJvxBrhPTrwgZJVz5y53ZVK0NcnnCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199024)(1800799009)(186009)(31686004)(36756003)(86362001)(31696002)(38100700002)(2616005)(5660300002)(66556008)(66476007)(6666004)(6636002)(53546011)(6486002)(316002)(6506007)(66946007)(26005)(6512007)(41300700001)(8936002)(8676002)(478600001)(83380400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0IrMHllU3pYZWFLeEdDb3REVitiRURxWWlWTlRxdEREdUxkbzB3NG9BaHFk?=
 =?utf-8?B?Q0QzV29uZzhtU1VvNk1yYVFDZ2JjZWVWR21VOTNpbWswUDlubDU4QlZiRGNY?=
 =?utf-8?B?UUZRTytuSzlCTEFSWjd1WUwvRDZyb0c3U3pKY3AzOUxpTEhTQmh2cU9COTJk?=
 =?utf-8?B?NWt3aUxRMW50Y1lIZ01zS2ZNUkRJMXoyQVdPUSsyeW5DQjlCQXlKTzdKa0pM?=
 =?utf-8?B?MFZLa09FY2tiNXdJbDhzUFRQTDF0OSt1WUlnbVl1ZUM3ZXE4bE1ON0hXMUZR?=
 =?utf-8?B?d3lnSE5lVG5uYTFaTmlqZTN3N2VZUkR1SjI5TkpoYURrRWVwOU5SZHJSbGxo?=
 =?utf-8?B?VSs4R1JySXhkTi9XNDRHSTZxNTVhQmh0d1VFMERCRzErZlhZeTlqbzlSUkNE?=
 =?utf-8?B?enNUeGFCNVpLV09TR2dJdUJKOE40d1hDeU9DaEt4WGoyY3dHd09mYitjdmpK?=
 =?utf-8?B?cmZWOXlrajVHSFVMdUhZVFczSm9HNkJhd0lXN2x2NytwMC9vUHJHdXNqYnQ1?=
 =?utf-8?B?NnBnUmdsTStxM0V3WnpoUzM1VkIyd0VCdzlvOG9yUWZVVVMxUUo3akk2UVlr?=
 =?utf-8?B?WWFPYzRKVkhPR05rNzJvenNhQTczYVcwWmZRMy92V3dIaHBleDhPdllVYlho?=
 =?utf-8?B?bDlOZU5BL3RtY1NhSXNRMTF5NlpJMG0yYU1DeEtHaEVXSTM2blh1UUJWMUxJ?=
 =?utf-8?B?Qk96a3NaZkVFTSt3WDlRck1kanl1dEhRZDRvWHV6aCszb0gwVThwNGcwYXpQ?=
 =?utf-8?B?dVJhSEg0eEVsM1orWFdiTzV2SmFwd3R2elFUUG1hV3VDUlM5TmZwMXh3Zk0y?=
 =?utf-8?B?U241Wk96VHBhZ3g1aEVGT0VwdVFNTjh3RFNrYS9XOUVWbUd1Zi82ZGJHbjc1?=
 =?utf-8?B?MTRYSWhoQ2lmaEVRcXFZa3hwWGdMSGFrNVYxdmtZbDNPZ2JOaUJ2Nm84dmxn?=
 =?utf-8?B?REtXSExTSlM2Wk1PQ3lYRWU2S25GRWpYbVoyVm0rR3ZUN0xwZHZWTmxQdjFS?=
 =?utf-8?B?NXRWSjNIVmxuemp3TUZaaUtFOGluUC9sMUxSOXMzYUhlb1habXFDTWtDYlBv?=
 =?utf-8?B?Y1YrZThEUFBzdEFUcXZKbVN5dVNqeDlsWmYxWmczV2F4VmlyR3BRVTArWTYr?=
 =?utf-8?B?TFZaK3hjWTF2NzVMMjhNUWU5aG1seExqaVZPaVZDZENzd2c4SGNXVVJKaWJk?=
 =?utf-8?B?RThNVkE4bEhWd1lwL21mQkxLRHZNU3gzYUlkcmYwWXVJRHM5OFdLVHRkMnpN?=
 =?utf-8?B?UXA1NW9PTlFncDFrMWRST0J6dWlLQXFCTTF4WmIxVUlMNW5qRDRyMWVKa2JR?=
 =?utf-8?B?bTk0cXQvTFFPS09EWXlQeGlIek5lS1lRZFdDNnRVTmVtRG9UQ1B4enpPQ1g0?=
 =?utf-8?B?K0J2ck0zSXVLMUUvSDE2WjIwYlljSDczK0tMNUlPNDJqNzFtenRkUWFvU1py?=
 =?utf-8?B?VVpnUVQ5NGlzWmJ6ZkdRb2VxemxaYjNseFowbUFMTVkvL3BZV0VieUFGZGVJ?=
 =?utf-8?B?VkMvUXdGTVdZSzFtSXN1aGptSXc1NCtOTUQ0VVRTeVdpcHlSNVlDVWxwQmRX?=
 =?utf-8?B?WC9FREpwWEszUmM4NVI1QlFUMWp3dmVKaW5Ccml4SFh3TTBQbFl0cEZZMFJ0?=
 =?utf-8?B?YkRsc0hFdE9HVFoyS0kzVUhtU1d5anJSai91bDhucHNWcXUwcThiVEJhVEx6?=
 =?utf-8?B?S09mZEl3S2M3SlVmUWJpcDBldTBJTWxGRDBiQWdqR3E1SjJNNFEyaWgzaExE?=
 =?utf-8?B?cWltN2tIc3Z2U2xsaUp0YlU3RTZwNDV6Y0RQR2RLRk0zT2VLbUFaV3ovcTFP?=
 =?utf-8?B?NDlmT0V5ZnBSUytmbHp1amwwb2g3QWZqTzRFMVRULytLS1JKczgyZmU3VkIw?=
 =?utf-8?B?QWpuT2d6cy9DQVhwV0tIcDc2aXZ3UkdldXA2VW9jNTJPanB2Vlhhb1ROYlVJ?=
 =?utf-8?B?REVKaXVkcitBV1pINjJWYU5EaVNEVW5PWGlPdENxUEVzYlRmeDhZRy8xL0RV?=
 =?utf-8?B?UEpVREUrcFhTR1gzZnZEby82OU5WOFE2U1RaZG0vKzRob2c4d1Blamg5T3pp?=
 =?utf-8?B?dXpBN09NbmxnV0orNTh5VVZtT2d6NHZsL1g0Q0xjVDNOV2FTUnZ6ZFc0MGNl?=
 =?utf-8?Q?AsnGGxEoREoy78T5Ap7pGJUfY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e37898-de69-40a0-044c-08db9fe1c45e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:53:41.7469 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14hoFAWueo4n4qdb4XMwxbQJihJE4L3aeOTbB39zhn7n/h65K4CJU55+vJS9Ln/i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7343
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



On 8/18/2023 5:10 PM, Mangesh Gadre wrote:
> rlc firmware does required setting ,driver need not do it.
> 
> Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index d8d6807e7b96..93590adf2b04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -2221,15 +2221,6 @@ static void gfx_v9_4_3_xcc_update_sram_fgcg(struct amdgpu_device *adev,
>   		WREG32_SOC15(GC, GET_INST(GC, xcc_id),
>   			     regRLC_CGTT_MGCG_OVERRIDE, data);
>   
> -	def = data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL);
> -
> -	if (enable)
> -		data &= ~RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
> -	else
> -		data |= RLC_CLK_CNTL__RLC_SRAM_CLK_GATER_OVERRIDE_MASK;
> -
> -	if (def != data)
> -		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regRLC_CLK_CNTL, data);
>   }
>   
>   static void gfx_v9_4_3_xcc_update_repeater_fgcg(struct amdgpu_device *adev,
