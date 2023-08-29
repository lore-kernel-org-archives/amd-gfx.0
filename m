Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B69AC71153
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 14:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C66D10E034;
	Tue, 29 Aug 2023 14:46:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E937B10E034
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 14:46:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjiMeDTP+U2jblK0w7I/MOBa3UEYAXqVFFosUiP7hutITizqvPDMBdmbZOqUzPtHWHv9DM4ChMtMLE/cq1E7YJjWLGDcDmf93hJ3TE8XUYqY+3g2F1IxBmYd7QSM2agIvk+fTqL2ScS/Gw1Eqj+zSTrAKbBhh77QtV3GhPafwsT1LSBiaxZ+RpG7QHhaRR586Gj7DcyTWIHokIYpLUQx5MrdLZj4jopZufpZzP15a9EvDDOBmGPpmARFfMQlxSeP9/BBODxkJ9u8+o9+inFALzEAjMApNEjFWbRUsot1clf0xADHRPPkCH29SPpYJtpMYzaQY+2Qrgnb1Fq3Xi2SeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TalOIh0UQY8cgdYosJbGPW39M7QC/FEJEefCFw5N9w8=;
 b=X0ZPBpuzccReINvDvvAHivUN+3tZ+KM5i+rQs5sWL/dfBV+hwIsUUf58czu+T7IjD3MXV4y36fOBsqGfbD5GlXkdSbEOpgCU19EKodQzZW8YqKg3kvqdc+W0lVkxRo686pgwOSVzv8+lACIJpqBQQN+Tlp6jhKKPLP+2BVA2Hjxf08GooiFTnqtwTg4QmTtOo4RFnjFxg3eydRyW+8CQTcy8BX7qrS1lS+PAXCN2v50LYcI0CIJXROVEq+sojxiHx8dWPz6dAfOPIXkMlK9s+v/8/cwmxe2vFDYd7IlXjdQs5Bii9Wi1V6DnjxAywjUIjaFhcpqB3qe2JxmgA9P63Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TalOIh0UQY8cgdYosJbGPW39M7QC/FEJEefCFw5N9w8=;
 b=zfNKWBrOWZSyW5UVk3P+MTEfKUbWVYYw0LKJDOqFfZ9IsxFdIdff3K/Vw8K8s5XZjwlf82WloVwHWIECzttTR07nmAt0V3CmAwFY+awkQW4j6IR4r4MlmWunhULBZNPy0ksn1Y1R1NMZhi176HC/pt09dubcZ+2M3w/CkgjsKKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 14:46:23 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::33a6:f24c:da30:4f38]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::33a6:f24c:da30:4f38%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 14:46:23 +0000
Message-ID: <5b8737bf-7615-4354-8547-0a13c24a5b9a@amd.com>
Date: Tue, 29 Aug 2023 08:46:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amd/display: Adjust kdoc for
 'optc35_set_odm_combine'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230829045048.1369376-1-srinivasan.shanmugam@amd.com>
 <20230829143822.1383741-1-srinivasan.shanmugam@amd.com>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230829143822.1383741-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:408:70::19) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa3602e-b94a-4b2e-8c75-08dba89eb735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mhCvuNc4gZX3cC8DapcIoir5ElmuXL1FRXGs0WnaO9GdPiLkzLT1baR+jeRWEbEwhfzyR1eZ12FUcoVCsfz/SunUMuw4DDoZP9R2O/bvXSW0I7HvsL0Lc7T5ZwODcoJa8+tdf99CUTmQ9H98++b5edV4MRWpZpeP2YjaMEKsD+1YnTiREEdgtFijcRQTneR8csVz5sqwfUAPbJRLqFDSPjWEKBXD+HTm29g4131OlaF+MYbX2cMVZLNXIJQd2KbberOkVAkcmlN0kX2YPLmM2Vr59zP4xdHlxeMQap7mWB+8GwdwAOajTnUftcBm1ZN9/Byy1tXzW3HKKTx83Ww45EFSuvtZOBI9y0XNkf0HNtNCWIj6AICjzagaGy7PfNj44+/UcRopO89BhqcVAyT7qhBXxf2cL5+casoxpZpYWTAq0OQLls/H3M9s66wiREEpq9+G85twYH6OBpG8GdfnpWrnEK9kHkOP2W98aawgH5Kgn9fNeBWd7fRzWPzHSgOsCjpo1Gre26VsQQbNtW+XkQLO1rxcTyRHUqv89X33ob5o7+xCYUksZdKCP1CViqFfNL3+CqY2yvZbkN4dIuM0gRSYa4RgIOrrNdgKv0CJE+VF+97A1Dww0y+2BJJei6Y196k5xkUDtlAhXhsZkJICQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(1800799009)(186009)(451199024)(8936002)(6666004)(110136005)(31686004)(478600001)(53546011)(6506007)(66476007)(66556008)(66946007)(6486002)(6636002)(316002)(38100700002)(41300700001)(6512007)(36756003)(26005)(8676002)(5660300002)(83380400001)(31696002)(2616005)(86362001)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3Y5RlU1VVpRdFl1bEFKamo5b0Nuam1uUE04LzcyRFJUaXlIdFhLZmJrR2ho?=
 =?utf-8?B?RFhTTUNnWXNxWUtYZXZuNHBFaktaVDNMUUtNOGhVNlhIYmdRZzc3TXovY3Ry?=
 =?utf-8?B?QjBoV2ZuMitmcW5WYkRqN0NEZ2o4d0IwQUVzcWtQeDMwUERPblZUUWF0cE9T?=
 =?utf-8?B?MUpha2MzTkNBdVNhaGpkcGk5VWcvSjV1Mk9hMTduVWhmMFhKT1E3Mlp3Ymcv?=
 =?utf-8?B?K3hmRlNMMVhYdFIwQnpWUTJDeTJWek1PazBmdnZJTDdWb05YaEYvVVBiVnoz?=
 =?utf-8?B?alo3K2txOEtHZDA0OExkWmZNK0YwR0dvNUttTGd1dGMvQ25RM2hkUDM4dWNH?=
 =?utf-8?B?ZTlnVEQ2OUhyaGUwMkw5ZzVhaENMU1U1WUNhZExOVEhrQTJIS3Ruc0RNajRo?=
 =?utf-8?B?L0M5STY4bVVZb25FcDFyUDBrc1JLZ0tIcjlaYStlMW84YXFpYzFNeGZ1K2Jo?=
 =?utf-8?B?ZTJEWlJWTnQvNVpqMUJvMjI4MGRYRnNScUFKNThXVDE3cWo2Ump5ZmZqWlpM?=
 =?utf-8?B?Q1hUM3NNRU9VampBaWlCVDFnNFhES2NrRTBYMXUwNllzSjZDb1grTnBhdTF3?=
 =?utf-8?B?ZWdoOThYbkVPbnZOdlBPelc5a2Fwd2J5dm5MNytFNzgrUWszdHdNTEd3NE5T?=
 =?utf-8?B?b29YaTdSbTRSUUM2eEpteVBpVGJYREN6S1psd2ZKWUFBSlU2bHh4OEFHWTRy?=
 =?utf-8?B?bStqSitRb3RBVWpmRzlTWHRnUitnZjBMQnBqemdpem9lajlRZWh5QnJJaGdr?=
 =?utf-8?B?bFROdWxVb0pHTFcyQUdjYWxnbVJYbStQcG1kSWR3MVc0N2NLcDNQZzhrZUg5?=
 =?utf-8?B?bHFVZG8rNUhlcUQyc1EzTUliU2s3ZEZ4NEpsa0I2Y2hzR1NCSk9ZRVA1cXBH?=
 =?utf-8?B?Um4weWxsOFE4SlUxdzV5WEg3YUhNWUhrZml6cW4wYm0xR29LTlRqWDVINVZJ?=
 =?utf-8?B?K0p6S2srSnVaa3VwT1RPM1RXc3RndXA5U3libmJmT3lsSE1uTlJ0THBtVXVV?=
 =?utf-8?B?WUJaYWtrU2Z5VlQ5dkdMOXBFV2RmdE01VzkweVg3TnBJOTJKUDhST0k2V2xr?=
 =?utf-8?B?RGpJM1FRaHlpU0J6bi92eWtVdVhVbFd6Z1dmSStRdHVRWnRCMXNJNmo1MThi?=
 =?utf-8?B?U3BFL2lVQ3NYOEdDK2JyUUtqN2R1Y0VoTWQzUXJrUmtjMUpvY2hVcEdpZ2FZ?=
 =?utf-8?B?a1RTbG1wQ2drTE1udk1EUzRMd1JlVVU5NmN2TmYzWlNyeTArTUdObGxTdktx?=
 =?utf-8?B?U1Z4UEVjWkN5a1dZNVBBUzM2SFBxQTdPNWdBSFE2NHYzWjM5ODVsaXhhZkth?=
 =?utf-8?B?dHRFdnNxRzlNRHFYQ1RMdHNRUEpTcW1JWjc3cW01ZUEvN3cwdXo3N3ZMRTlV?=
 =?utf-8?B?YU8rdDFxeGF3aFJuR0RFMlRNaXZvZlo0OG93UDExU2g2blgvOVdUVUl3d0pN?=
 =?utf-8?B?WjU3R0lhbTRjVjE4NklsdUZNOXIxaHFkaERUNXhkNjU2RTRXejB3YWxOSC9z?=
 =?utf-8?B?S25xYVRLL1duanZrMWVxSm9wekRwcVBtOHlyVk1yOUd1UlhWTlozeHhxcEhL?=
 =?utf-8?B?Q24yeEkvK1k1cG4yaU9GUEhwREZLa1VyOWFHUUtjK0dyaFVjaXdjUmtIckpR?=
 =?utf-8?B?SGlxMHBka1JWVW8zWmUxem4xM0hka2k3WTdUcFJVL3B1Ri9UVXp3MElBQklG?=
 =?utf-8?B?S2xMSEorVUFoc1RmRDU2ZW5oeWYzcXhFZWl1Mi92MkZ2a2p1UVNSRGw2a09n?=
 =?utf-8?B?WlB5dGdNaVBEd3dWYW9xbmtwaE4vRXJiUi92OGF4d0JQRzUvRGgrd2lHTmVP?=
 =?utf-8?B?NVNTWm1WMWo2Wmo2OGtWNnU1SStmMkw4Yzcrb3Vad2tzQkVmbGxwa0x2VmpT?=
 =?utf-8?B?TTl1b3FIRHd3VnJ2ekJkbnRFOU4yVjk4S0U1WWxhV3dSYnRidGY5V3pWZlU1?=
 =?utf-8?B?bFM0S1c2V2RRV3hkQXZPVFNKVStkeGFKYUpmNEwwZXFhazIyTGpzK0R3cUJ1?=
 =?utf-8?B?MlNRbmEvLzJERW1ra2N6UFNiNVNLYkIvQy9EYTRMS3kxQS9TVnovR3lrNGo2?=
 =?utf-8?B?NWNhTDRvRUxwYXlJZzlhd0ZjSUhnNW9kZk1LRGI4WW5CNXBOOGpoVVJZSlE5?=
 =?utf-8?Q?c5Xo6JHQIJd7DrLR45wVDdhA1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa3602e-b94a-4b2e-8c75-08dba89eb735
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 14:46:23.6315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dcVJ2JnMOIcY4WRteYGdkf83et2iet6K2P0kUMDH0EPYneftrS3VtRBPdc3X6h4mYzFaCtMNIB8lx2yKaKCYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/29/23 08:38, Srinivasan Shanmugam wrote:
> Fixes the following W=1 kernel build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn35/dcn35_optc.c:46: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> * Enable CRTC
> 
> Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> 
> v2:
> 
> - Addressed the following comments (Rodrigo)
>    - Updated Commit title to 'drm/amd/display: Adjust kdoc for 'optc35_set_odm_combine'
>    - Updated the description for paramaters @optc, opp_id, opp_cnt.
> 
>   drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> index 5f7adc83258b..d64be1a5071c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_optc.c
> @@ -43,10 +43,15 @@
>   	optc1->tg_shift->field_name, optc1->tg_mask->field_name
>   
>   /**
> - * Enable CRTC
> - * Enable CRTC - call ASIC Control Object to enable Timing generator.
> + * optc35_set_odm_combine() - Enable CRTC - call ASIC Control Object to enable Timing generator.
> + *
> + * @optc: Output Pipe Timing Combine instance reference.
> + * @opp_id: Output Plane Processor instance ID.
> + * @opp_cnt: Output Plane Processor count.
> + * @timing: Timing parameters used to configure DCN blocks.
> + *
> + * Return: void.
>    */
> -
>   static void optc35_set_odm_combine(struct timing_generator *optc, int *opp_id, int opp_cnt,
>   		struct dc_crtc_timing *timing)
>   {

When sending a new patch version, send it as a new patch instead of 
replying the previous one.

Anyway,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

