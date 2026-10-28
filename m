Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24342606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E9Iqdm5s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE49510FCA4;
	Wed, 28 Oct 2026 13:57:57 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BC2710FCA4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqUK29seNG2Cq0DDl8wPI0ataOr8tCS6dxV5k0GGLUnjjErBaL9w5ozuqb/I53rmh2XUkuUxSdWBDZOMAyNKT8zvUaXc3uEU10t6y7Cq1RVysKQQ8q4FSmuQdY5T0YXAn73ct9u4XArHZAET9FU88mJdqGomsTRsqW9G9SPJSIeg5+tMNPBotmP2Z9ZnuNfaGFVJW9i2d6BKz7BTDMJI4u2R+V00KUhqReclQVlbzRC/oCl6YzOJc+1FK6wokiBKeSNEdKxqq7Jm8BLagJgLZkDXcCdBHOtfFLBpDAaqwLJ+brIoJNSfugeirGOXUD8DD5eRwx6JUrZEk35EB0nurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxNlixuzSL2V0WwvXd3GUj5gql0NUoLoWkTSVQUFVaQ=;
 b=Y8kzOUPGCsg7b4mDj7ZFTxZXT7n2mI0r9xt/eI50ZRX39gQfnUW4s5N/lmdNZ4YVTi+2aRUYqEoi5OH6CUqfmNCFSyQUjaa04yDqXnBAHw/GlOE4HrB+R780wVE5h/HXWavzWOOZ0qflo/I5mPdnNDh/tSKtOScqVNZKlKquL3NIpWQQa7U8ngHO3wgp3rKxy+lyXZjxstaQ7/bMLVc08HLbphWyHISFRGg8zO/rqmJwEEBAskuBZIGYV5FRbgemNhBzPifiBHy6Nsiagu6fRhuHrdTBTu+P/S5t4q/NiwjEZQhK7eadermD7V6EWCy5pZH1b64ZNum3gpy51sy9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxNlixuzSL2V0WwvXd3GUj5gql0NUoLoWkTSVQUFVaQ=;
 b=E9Iqdm5s9Lg2znB+KZlLeM+hShBujvjM9bfzAjNlW5HwfBSGhSqUz0r4cjHHczfzjSRpPUZK6bdHbiHY6xmMBiyscf/mT+ny6xM5KEpxXWAtZZtnbiPlvRHNiwgrbg046bm7RZqf4QOox5PjLiu8ZkT1jLEo0qEf9c6ca1plWHc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6)
 by SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:57:47 +0000
Received: from CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18]) by CYYPR12MB8701.namprd12.prod.outlook.com
 ([fe80::2d1d:d718:e022:2e18%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:57:47 +0000
Message-ID: <f7b7fd3c-f327-4228-8eae-7a879d994155@amd.com>
Date: Wed, 28 Oct 2026 21:57:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: add missing CRC engine 1 registers
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
References: <20261028091501.191108-1-Wayne.Lin@amd.com>
Content-Language: en-US
From: "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
In-Reply-To: <20261028091501.191108-1-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To CYYPR12MB8701.namprd12.prod.outlook.com
 (2603:10b6:930:bf::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8701:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 721e0ed6-bb73-44b4-04c1-08df34fb721f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|10067099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TAOFzOIcq4VNudGXhiGdd4FOWIaomSLvIvZ65ZtBEHljGdwryz8lNeYzlJzFEmxScTs9QFZsEQuigZQ3REM7iEpkKhnbhUZa/wU3/GEvNHqheqekLmgcH2B1eCrZ/vQ5cTx0DXF2BO9wZfDO4ounv7tJt0wyB2rHLX0g9xe3uNB3tGG7BXeTORA9c74lwKM0jbp/M64zgdkfHG010zMwnf7FgipgQXMMDL505gY3GuqB7DKbT2w0xremHmDP0WyzJPlkp8gQ1qqDVIyebA0qUSlA1y1VGB6sTXzFB/mKOmbpbjDhN3mUrKYtid9GgKkYGrD8I2NSMWSr8MT1gnfkDqpkWBvtnyD0P9k9+RkNJkHnbPdf0hnXNwcEARD6iTmgDJAyAcs9EWP/PuGs7cnOfz+AXUpsuosGlWOh76/r7Xs7oHZbOlK+zHI+56QtvRvmgzMWcgCSm0W/eVaS9Z/aVYB4ddjJalOmYgsHay7q5JRW2l0oLqdVMvIfo9WLY6W0i/c44q3lXXn/XArK5N6WtGNVvMp8pPrgdTQBBbOU0FTvNo7lQHU9dKD9hOW+ev3rOxkhcidWFD9BopPJKBzlrjmmWf+GVfJBO+Mrcszp+DMlOWuQKY7hEXD16/idIvwvRKMTlB+1btxivkVU5HuBC5vVKqPkEVmQn6zEnBHbEKQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8701.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(10067099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hoSmRuV21nZGR3VFZvNjVWZ0hsVmlXeGNMM21yd3AybFJwNWN4QXpMNHM3?=
 =?utf-8?B?OFAyRm8vRTNvajdWaEE3TWhwcTJqZ2RpaHUvd2RubnY2djFPd084VVU0aGIx?=
 =?utf-8?B?RDQrRVVPVURQcWJGTGVXcG9WeVVzTzF4ZDNQb1NLTnFBRFkvcFFsUDFaN2Ur?=
 =?utf-8?B?ZlA0T1VOR3BGVFNDRUNMY010N1cvaEwzUW1vVndPMWdSUWVxMDF3SGU0WjBG?=
 =?utf-8?B?dGFqOXBNaXI1K3R5dTdmTmloekUvcWlVMTMxUGw5L1ZrbG16VDZ4M0t4dlNw?=
 =?utf-8?B?a3hZUkY5UURGVHdoSStYeWowMFBRL2UzYm9DRnBPb0Q3ZkE3WXB6b09teU1z?=
 =?utf-8?B?dy9PRm53VnNFMTAydDNoNWZ0NituMlRNRHA1a0R3a29wcUpLblNzbk1iMlhO?=
 =?utf-8?B?RlRxTGtHU1lMS2xxOUJxaUhFdEpGM2dVQUtuYkE3T1pNWTZuWE9TSHRkcEll?=
 =?utf-8?B?dllFSXBidEtGSEFsZ29nL2g1SlUybW5vZmxFRVk5M3lHMzBwd1RManZIeVlR?=
 =?utf-8?B?ZERKd2o2TE5TWHlaVnp2VVI3azZvVnVtNUpEZ3hXa0FKZU5uSHpaNWUzVWZS?=
 =?utf-8?B?MmpUSXREc1diYUpLcmlabW1uVW1FVXNqZ2FwZ2RMa2VaeWIxeWl6bzhIdmxM?=
 =?utf-8?B?bG9SMHFtdkVPNkl4cG5NMVpOQ1N3YW4xdlFCRWpXNlpjWXl4bnZlSFNPWWU5?=
 =?utf-8?B?d25NMXZDUExnWUJmcy9BbE9OSzVqSENHbUhaODdhTnFETWZjaFJKSlFGVVM2?=
 =?utf-8?B?Q1EwZmMzNWMxYnhqMjlQbTY1L0V5djlQRWM1YmNuQ0RaR3dsalU2V3l4anBJ?=
 =?utf-8?B?aWdvdUFuRnlnZEcwS25NVFgrcm4ycml1VFZXcXJ5ZHVmbUx3L2hZa3RkQWlk?=
 =?utf-8?B?UU5TUjl0T0c4SlVJdkxWOVI2U3ZtQWVQU2VORmRqVW9kR0xwdEk4UVR1eDNm?=
 =?utf-8?B?TkJvcHhERk9GQlQ0c21xQ1grbndtajZNSzRUVEoxaW14NWY5Q3UrTkpHUEpv?=
 =?utf-8?B?aG1taklqbzNuVnE1Z2I1RzJwcU8rVldCRG9oY0pVb1ZwcU1keE15RUd6YldZ?=
 =?utf-8?B?MC9xeWRTWDJCNTBKYkN1UWJPcFN6N3hmMlFSTGJtZldIdlZ1K2dCUXlrY0xO?=
 =?utf-8?B?S3haanBoZlEzUUdNcVBVSU5wV1lPQ2NPUXZWZWhaUktmNTVlSUpaQ3hZRWhG?=
 =?utf-8?B?ZHRVWExpQ2t3STlkeXpBMUVObEJwL3ViUlpaZnY3RjZoQTF2dXhTUEZhVnV0?=
 =?utf-8?B?YVVFa2RyWUFHRjkzQlVvVFVkbUd5RWwvSjlCbnVhWHZWMHRUTEVGZ2k3VWxU?=
 =?utf-8?B?RW9ick5aRzVZMnNZQVU0UzlZb29BcDlNcmREczUrVGlzbFc2QnRPeTZBWTls?=
 =?utf-8?B?SmhvdlpSeFdkbVo1L0s0MmJqLzRrVkR2ZnBsS1NQQXRDVkZkZFdCbExqY29i?=
 =?utf-8?B?eDdseE5WUVFoblpCWXQ4aXZPRTgwQi9kZUswTUMyeHE5SlV6cFhlTDNwVVpQ?=
 =?utf-8?B?bVpsazM0bmpVTHAwK3BPaFBmTkRyanpVSFl5SmZDUU5WdUs3aUJIbFlGMU5Y?=
 =?utf-8?B?Q1hTbjRnWHp2MkZnRm9nVGxSL2JoNk1MaHJiWGp5aDFXOFhCRGd2b0lHM2Qx?=
 =?utf-8?B?Zm9ZNCtVVWJFY05WN252TVpna25TeTBsVFI1STZoejFzOUFrUmFkVjZtY0VP?=
 =?utf-8?B?aHVSOUQvdzZKWVZXYnVValRoRE5iVGloQzlaakRnVE82R0tsTlZ5MkVxMEUz?=
 =?utf-8?B?RGpEYjNwS0Q4SklIRkFkZ1J2QUwySUU3cmY1UHRGK3RnRDJsRzJnVmFjREk5?=
 =?utf-8?B?WG9lUzlsQnVreThJRXIzNWU1SVhSRGJXanhUVTd4UmRiblVIaFdDSEUvM0ti?=
 =?utf-8?B?ZGZoTVhqK1pBUm8wVVI5NHRvbks1N1pFOUNBSHJ0c1JnQ2hYWkpYd2s1eFBh?=
 =?utf-8?B?NUl3TzhpcVZ0a0E4THRyREZGYTFvdVJCYjZURzM1K1p0SnN6ZndtWFFzaUNX?=
 =?utf-8?B?Q2FVUjR1c05UU0YyUUQwM1dyOFgvYlp5WkJzT00veDZpUDVCR25CbnpjODVs?=
 =?utf-8?B?OWZyL2JPS3ArL1c2ZTkvaVVpSGxtZG1KRmhEbDdIcnpBQjJRejRPS0RRUk45?=
 =?utf-8?B?a3hQVmRqVjZjbHJqUG43ZkdjZmcwN2lZemhJRjVYZW5ZL0Z0MURkMUg1YkFB?=
 =?utf-8?B?ZkxEUWErY2pQNFhlWGcwOUpCQ1g1MjVsRW9HTGZlYWo3NzJmZDdkYkk0SjFP?=
 =?utf-8?B?V0gwb2ZuQ0pLWjZhU1ZtT3crazlOdjJqNkxtcTI5OXRYUWRoOW1lSXgxdk54?=
 =?utf-8?Q?+vWF4aliQtMYLNbyWk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721e0ed6-bb73-44b4-04c1-08df34fb721f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8701.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:57:46.9794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FePWq8qSXsxC2S0RPNBis5KV1oXVdHTcYQ9BeuVfYUF+oAlTF+noy1d8UL498Zlh5mTMxzxmEP1GDJE/jpgqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>

On 10/28/2026 5:14 PM, Wayne Lin wrote:
> [why]
> Opening the CRTC CRC debugfs file programs every CRC engine. On
> several generations the engine 1 window and data entries were missing,
> so configure hits a zero field mask and WARNs. DCN4.2, DCN4.2B, and
> DCN6.0 already had those entries, but configure still writes
> OTG_CRC1_SELECT with no mask check. DCN6.0 also lacks OTG_CRC1_EN, so
> optc1_configure_crc() writes OTG_CRC_EN instead. The ASIC headers
> already define the addresses and fields. The driver tables did not
> list them.
>
> [how]
> How the missing entries are filled in:
>
> 1. DCN3.0 through DCN3.0.3 use OPTC_COMMON_*_DCN3_BASE. Add the six
>     engine 1 addresses and the window, data, and OTG_CRC1_SELECT masks.
>     These headers have no OTG_CRC1_EN bit, so that field is not added.
>
> 2. DCN3.1 uses OPTC_COMMON_*_DCN3_1. Add the same addresses and masks,
>     including OTG_CRC1_EN. dcn_3_1_2 defines that bit. DCN3.1.5
>     and DCN3.1.6 expand DCN3_1 through DCN31X. DCN3.1.4 has its own
>     list. OTG_CRC1_EN was already on it, so only addresses, SELECT,
>     window, and data are added.
>
> 3. DCN3.2 and DCN3.2.1 already had OTG_CRC1_EN and OTG_CRC1_SELECT.
>     Add the window and data masks in the OPTC header and the addresses
>     in the resource header. DCN3.2 fills addresses at init from
>     ctx->dcn_reg_offsets[].
>
> 4. DCN4.0.1 also uses optc1_configure_crc() and was missing SELECT,
>     window, and data. Add those masks and the six addresses.
>     OTG_CRC1_EN was already present.
>
> 5. DCN3.5, DCN3.5.1, and DCN3.6 already have the addresses and program
>     engine 1 through optc35_configure_crc(). Their mask list included
>     DCN3.2 and then repeated the CRC1 window and data fields. Drop the
>     duplicates.
>
> 6. DCN2.0, DCN2.0.1, and DCN2.1 are left unchanged. They inherit the
>     DCN1.0 lists, which already name engine 1 window, data, and
>     OTG_CRC1_SELECT. Their headers have no OTG_CRC1_EN bit.
>
> 7. DCN4.2 and DCN4.2B use optc35_configure_crc(). Window, data, and
>     OTG_CRC1_EN were already present. Add OTG_CRC1_SELECT. DCN6.0 uses
>     optc1_configure_crc(). Window and data were already present. Add
>     OTG_CRC1_SELECT and OTG_CRC1_EN.
>
> Fixes: ef45aaf73717 ("drm/amd/display: Configure all CRC engines in pipe CRC source path")
> Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> Assisted-by: Cursor:Grok 4.7
> ---
>   .../amd/display/dc/optc/dcn30/dcn30_optc.h    | 18 +++++++++++++++
>   .../amd/display/dc/optc/dcn31/dcn31_optc.h    | 22 +++++++++++++++++--
>   .../amd/display/dc/optc/dcn314/dcn314_optc.h  | 18 +++++++++++++++
>   .../amd/display/dc/optc/dcn32/dcn32_optc.h    | 11 ++++++++++
>   .../amd/display/dc/optc/dcn35/dcn35_optc.h    | 11 ----------
>   .../amd/display/dc/optc/dcn401/dcn401_optc.h  | 12 ++++++++++
>   .../amd/display/dc/optc/dcn42/dcn42_optc.h    |  2 ++
>   .../amd/display/dc/optc/dcn60/dcn60_optc.h    |  2 ++
>   .../dc/resource/dcn32/dcn32_resource.h        |  6 +++++
>   .../dc/resource/dcn401/dcn401_resource.h      |  6 +++++
>   10 files changed, 95 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> index 16c5610b49ac..b801989f10cf 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn30/dcn30_optc.h
> @@ -91,6 +91,12 @@
>   	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_B, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
>   	SR(GSL_SOURCE_SELECT),\
>   	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
>   	SRI(OTG_DRR_CONTROL, OTG, inst)
> @@ -229,6 +235,7 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DSC_MODE, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL2, OTG_CRC_DATA_STREAM_COMBINE_MODE, mask_sh),\
> @@ -245,6 +252,17 @@
>   	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> index 19d90c65a22b..c56512455338 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.h
> @@ -83,6 +83,12 @@
>   	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_B, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
>   	SR(GSL_SOURCE_SELECT),\
>   	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
>   	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
> @@ -205,7 +211,9 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_G_Y, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
> @@ -217,6 +225,17 @@
>   	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> @@ -264,8 +283,7 @@
>   	SF(OTG0_INTERRUPT_DEST, OTG0_IHC_OTG_VERTICAL_INTERRUPT2_DEST, mask_sh)
>   
>   #define OPTC_COMMON_MASK_SH_LIST_DCN31X(mask_sh)\
> -	OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh),\
> -	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh)
> +	OPTC_COMMON_MASK_SH_LIST_DCN3_1(mask_sh)
>   
>   void dcn31_timing_generator_init(struct optc *optc1);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
> index 7b43c3ecd46b..956eecf0a43a 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn314/dcn314_optc.h
> @@ -84,6 +84,12 @@
>   	SRI(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),\
>   	SRI(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_RG, OTG, inst),\
> +	SRI(OTG_CRC1_DATA_B, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),\
> +	SRI(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),\
>   	SR(GSL_SOURCE_SELECT),\
>   	SRI(OTG_TRIGA_MANUAL_TRIG, OTG, inst),\
>   	SRI(OTG_GLOBAL_CONTROL1, OTG, inst),\
> @@ -204,6 +210,7 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
> @@ -217,6 +224,17 @@
>   	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> index 60c01ec28b65..492760779226 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn32/dcn32_optc.h
> @@ -146,6 +146,17 @@
>   	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
> index 82e0818c8f9f..196596cc9fb6 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
> @@ -32,23 +32,12 @@
>   #define OPTC_COMMON_MASK_SH_LIST_DCN3_5(mask_sh)\
>   	OPTC_COMMON_MASK_SH_LIST_DCN3_2(mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_WINDOW_DB_EN, mask_sh),\
> -	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> -	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> -	SF(OTG0_OTG_CRC1_DATA_B,  CRC1_B_CB, mask_sh),\
>   	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_R_CR, mask_sh),\
>   	SF(OTG0_OTG_CRC2_DATA_RG, CRC2_G_Y, mask_sh),\
>   	SF(OTG0_OTG_CRC2_DATA_B,  CRC2_B_CB, mask_sh),\
>   	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_R_CR, mask_sh),\
>   	SF(OTG0_OTG_CRC3_DATA_RG, CRC3_G_Y, mask_sh),\
>   	SF(OTG0_OTG_CRC3_DATA_B,  CRC3_B_CB, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> -	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_START_READBACK, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWA_X_CONTROL_READBACK, OTG_CRC0_WINDOWA_X_END_READBACK, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWA_Y_CONTROL_READBACK, OTG_CRC0_WINDOWA_Y_START_READBACK, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> index 3add972ca2ff..9e4e9d75400a 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.h
> @@ -110,6 +110,7 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_RG, CRC0_R_CR, mask_sh),\
> @@ -123,6 +124,17 @@
>   	SF(OTG0_OTG_CRC0_WINDOWB_X_CONTROL, OTG_CRC0_WINDOWB_X_END, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_START, mask_sh),\
>   	SF(OTG0_OTG_CRC0_WINDOWB_Y_CONTROL, OTG_CRC0_WINDOWB_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_R_CR, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_RG, CRC1_G_Y, mask_sh),\
> +	SF(OTG0_OTG_CRC1_DATA_B, CRC1_B_CB, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_X_CONTROL, OTG_CRC1_WINDOWA_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWA_Y_CONTROL, OTG_CRC1_WINDOWA_Y_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL, OTG_CRC1_WINDOWB_X_END, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_START, mask_sh),\
> +	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL, OTG_CRC1_WINDOWB_Y_END, mask_sh),\
>   	SF(OTG0_OTG_TRIGA_MANUAL_TRIG, OTG_TRIGA_MANUAL_TRIG, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL0_READY_SOURCE_SEL, mask_sh),\
>   	SF(GSL_SOURCE_SELECT, GSL1_READY_SOURCE_SEL, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
> index bc641f6ecd7e..bdda94489a23 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn42/dcn42_optc.h
> @@ -137,6 +137,7 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
> @@ -316,6 +317,7 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_CHECK_ALL_FIELDS, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
> index ba207c0e498e..ec40c9180030 100644
> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
> @@ -109,7 +109,9 @@
>   	SF(OTG0_OTG_GSL_CONTROL, OTG_GSL_FORCE_DELAY, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_CONT_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC0_SELECT, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_SELECT, mask_sh),\
>   	SF(OTG0_OTG_CRC_CNTL, OTG_CRC_EN, mask_sh),\
> +	SF(OTG0_OTG_CRC_CNTL, OTG_CRC1_EN, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_R, CRC0_R_CR, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_G, CRC0_G_Y, mask_sh),\
>   	SF(OTG0_OTG_CRC0_DATA_B, CRC0_B_CB, mask_sh),\
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> index 68e7140f1505..fa8cc89cb3f7 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
> @@ -1054,6 +1054,12 @@ unsigned int dcn32_get_max_hw_cursor_size(const struct dc *dc,
>         SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
>         SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
>         SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
> +      SRI_ARR(OTG_CRC1_DATA_RG, OTG, inst),                                    \
> +      SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
> +      SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
> +      SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
> +      SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
> +      SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
>         SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
>         SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
>         SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
> index 8e3473f86490..3cfc1a39a103 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
> @@ -535,6 +535,12 @@ int dcn401_get_power_profile(const struct dc_state *context);
>   	SRI_ARR(OTG_CRC0_WINDOWA_Y_CONTROL, OTG, inst),                          \
>   	SRI_ARR(OTG_CRC0_WINDOWB_X_CONTROL, OTG, inst),                          \
>   	SRI_ARR(OTG_CRC0_WINDOWB_Y_CONTROL, OTG, inst),                          \
> +	SRI_ARR(OTG_CRC1_DATA_RG, OTG, inst),                                    \
> +	SRI_ARR(OTG_CRC1_DATA_B, OTG, inst),                                     \
> +	SRI_ARR(OTG_CRC1_WINDOWA_X_CONTROL, OTG, inst),                          \
> +	SRI_ARR(OTG_CRC1_WINDOWA_Y_CONTROL, OTG, inst),                          \
> +	SRI_ARR(OTG_CRC1_WINDOWB_X_CONTROL, OTG, inst),                          \
> +	SRI_ARR(OTG_CRC1_WINDOWB_Y_CONTROL, OTG, inst),                          \
>   	SR_ARR(GSL_SOURCE_SELECT, inst),                                         \
>   	SRI_ARR(OTG_TRIGA_MANUAL_TRIG, OTG, inst),                               \
>   	SRI_ARR(OTG_GLOBAL_CONTROL1, OTG, inst),                                 \
