Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFEEC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 12:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F8310E5A5;
	Tue, 15 Mar 2022 12:01:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C4110E5A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 12:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKSsFLzorNHgIqCTn9iYXg2CY2r0U9mAGLLrQn9b/ZQoF0R08mniLZdy/mqBN6A/gPv5Gr7t/CB908UNxvF8dPH/R2dzjBYMeWfpbuoqcccMpdNTBXKqTylrMfETNszUsYQAIpZX7zBAsRmmkhRnWR2j7mB8iajtE0+lObD/1oCL+A7ePEjgqInUSJ9PjwKp0/tipsBr3n1EBSLn3HoENN9jR/1NYXpSg3eJhtyrUte5zdkhqajwKwHU9AOUUpYi3phEU5JjFKyKIMJc/rbiuxVtxCBiddv6MI4z9mM+Xz+hRqZ8MQbetJc1v9IsT/g5rs1cwNIVVm1HcMI4Fqtd4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0/fwufnqdCJXqXK77vGHX2OtnBd1fSEMbucAOcjx1E=;
 b=NrblGzanh1SeZvnxxnXNu5gOty95gk9MmvA85cP+sPZWrJQfwd0+6nFL7b5AxkUadgEfhqcHcz+iM8j0uA4kgZ2iA+FVfe0RMOru68kgOO9wbYXTZ3z0hDKBmor94C6oZZjeDozDAvISGJIZ8BT/+VaGaHiiS3O/UvpbOhZwoTmmZRjdLRTyNcFCaN4Y7l+FbHyZmMK69KlexeFlVd0xvrGHLA0odVjfIxSii2OptHp2GMYCb4IlHpTWQA+YP50jtn3+uqjRfbbggpGogL3saeYb1mDiZ+SyVDx/7k0E7swAeaLmgIJOLTISDepKyqv39BdLrYjd+BSsrhuGSGBP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0/fwufnqdCJXqXK77vGHX2OtnBd1fSEMbucAOcjx1E=;
 b=FiNvTc+6KpKeRRqCNGhtvzJSUqH+Xa8A28iu9Xinc4kxwlMIfCUc8++Z4p9gbdHh/FBp68RP7DxaUNqlaViRuk+K2dkFr/mF+NEOSBwNGgDcyHXn70tMJjf4gMh6PLeFAsXJyayu3dss2Oyl724n3N24XOww8VapTGn1KJvVpjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 12:01:34 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::8d3d:32f4:7ae0:799b%11]) with mapi id 15.20.5061.029; Tue, 15 Mar
 2022 12:01:34 +0000
Message-ID: <bbbbd2d0-24ae-0cf6-e5b7-8951a79fecb0@amd.com>
Date: Tue, 15 Mar 2022 08:01:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amdgpu/vcn: fix vcn ring test failure in igt reload
 test
Content-Language: en-CA
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220315023315.436797-1-tianci.yin@amd.com>
From: James Zhu <jamesz@amd.com>
In-Reply-To: <20220315023315.436797-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0021.namprd19.prod.outlook.com
 (2603:10b6:610:4d::31) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 628eb887-27ac-4dd4-8a6b-08da067b8ccb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1218:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1218EB65EAF40060AF0F9C75E4109@BN6PR12MB1218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihRMATzormlatteRnOQWIR+C62U6ltMqH+J5ilgARxr5tEe117FFyn/OSig0mjw8YOeBmmA2YkFRaNV9xtOAyN7ftvA94L4+vmdffDuk7qxACpLx4Fj5aK5di0gYp6axaKer94M+Ilz9wGFBDUSv98XM1MwM7GIUxJ+Go7lQTXis4Do4reSjs+22mdAKz9JFPPWfnHjXtf4Xw6YpLdzTyM/LYqvXHtFWFXLXgk/ylDZ5RJNwQKuI9FcDdqX0GzV00CFTttRCYuN3EZdH+6BAStcb0blDVpx+vwQRc6GeX5W16CVhq16lcNxBMtVZcEWY1d5Y0S343nh2kvp5jS6CNUUpNduqC0guhqOsZXCsQSn3e6Um8+9w3EpuYz/4OtEYHCeBBtmevctFTEixftl2smHrBEN88g5AmzqBnsSfLvl9qPip3OAgFMz27JgbbTVVjP6pLgFaj6iYr5LeaIaJNmtRVNe4SeF61eKYg4uIWN6rlEiPrkxUjPnN4grtrYLGeG3Xrf3w9uz9W9yBNsoEBBlX7jIhUN0uBwzOfhCpDWCn/c56gieHBNLbQUZpRi4USRqdP8VxDjB7sFtvQUguRXsq/KVYKEsMueB09zg+JyE6Kjez1Q2Pt3iikBxDNfLr+mW8kmAkIjbCLO5/dxzWICVrXEZQqBV42vPJ/A7Ww708RuJhCN/I71/SGeKV5ihBLWdh6ngZGUvJUAbJop9thpuFy6f3qnpCwreSdyGYkx/YFPqq+gWCLsDCUsR4dQr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(508600001)(6486002)(54906003)(36756003)(38100700002)(31686004)(31696002)(2906002)(53546011)(26005)(186003)(2616005)(6512007)(6506007)(5660300002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkRyMGFDVTBmT1kxaFJPem51UVlubFYzcU1VdWpMYjNFVURlOW9oRHZyeVNK?=
 =?utf-8?B?a1J4dWNwS25qTVRjdGV4MUMra0JiTEwvR1dNc2JjK3J6Zkswb1QxUEgzWkk4?=
 =?utf-8?B?NEVUMDRuYWFwN3pDRlJjMnk0WTE0VndJa1BXSDFBVm5kaWFOTG1TSnlUOWVq?=
 =?utf-8?B?SklFR2hURjQ5QVJrcDVBTlhzRGNOZkRlZStReEdVSmFscGFOZ2xpTWxqcmI0?=
 =?utf-8?B?S2pTWis5MTdIMG1jV05vR085bGR3QnM3R2kyeHVJWG5HMy9Tc3V3YWI0NHow?=
 =?utf-8?B?d2srSTJtRFBUZzJtOU9tWEVpNW5UMnZXUTU3d0JYdE1JendPVm9vK3A0TlZq?=
 =?utf-8?B?T3lIeVJ5NjNYVnBLWUhWWjh2U3d0eVQ3SU92QnNPMkQvbU5HMzZxKzdCZVFl?=
 =?utf-8?B?TW04TjNVSGlwZTk1ZGRnbG8zcG4xbllXRFpkaFNkdCtPSjlrZFY5WG1lV3Fp?=
 =?utf-8?B?eGlYRXBPQmhYYXlTVDNjbmQzTUV5cGRWdkJPSTRidk85RXcwTFA4ZzZhRVdX?=
 =?utf-8?B?Qm56QmJKQzNZVEdieGxndXpVY3JzWTdoNC9lQ1QzZzZHVitCdURSQ2VSWHpk?=
 =?utf-8?B?dERlMXBVUEpONTBoYyt6U25SMThDQXVFdDdBeGdMOGgxdnlrM0ZTZmI2Z0Y1?=
 =?utf-8?B?YWdIVUFmRjdpbCtMUUJQTkJOS0FEdWpLZHlUaGFXck8wc293aU5vQjN5WXJE?=
 =?utf-8?B?akNiZXg1QnNtOUgzMDNrdzRpS2VJQ2l1Yi9WVGJwUW9lM3pWZmlOTjAydmxp?=
 =?utf-8?B?QlNhYVBzOWdTaC9xZ3I0ZSt6enZRaElhY2N3aGRkMDlxV0FTMitsL3RnanFl?=
 =?utf-8?B?SmxiQUFaK3NKRjd2RlBOb1g2Y1JSSWg5N0N0Z29zUHgvbGRVUmRhT0xjNkda?=
 =?utf-8?B?SGlSWFVma0RJRmJxUzMxSGhIeVZ5Z3N6cW9TRDJhUzNJb3ZNV2FqazdsRllE?=
 =?utf-8?B?Y0JUd0NQRVpYNVZNMjJiZGxMejVIM01FL2pueHlkSzlDOWdkQXVOQWdwTUln?=
 =?utf-8?B?bHpCT3hsZmpWazZEMTkvVkpqaGVFMHBlN3lmbXZyVXFwT2p6ZnArb0NjMzBS?=
 =?utf-8?B?WTVzTjVDZCtIL2RVWHVvdHBsOFBxNzl5TlR6QzVIMXQzbHVPTG8vVmg1TWJI?=
 =?utf-8?B?MzFsU2c1TkJZbmhuRFhsZ3hhNlVQMmlSUHVxNy9IUXNHQjRnMW1GbVpMTmJC?=
 =?utf-8?B?bjBhWlhTWFZ0TGVtbTV6eit6ci95UzQ0TldrQjg2MUFOaUtPOThuejlETXBZ?=
 =?utf-8?B?eVFRWTQ2Z1ZMcFQyUGxnNHVpcklKMndJaUhoUE1KNGMzLzJqL0FCdmpXbDh3?=
 =?utf-8?B?aEZ3V29jQzI1TGpzK2xyVi9udWZLMlduakZxWnAycHdYemZybUEzcDkyMndX?=
 =?utf-8?B?VlZISjdnVElFQ1FvZFZ4OXloVEEyam9NMWM2NDdKcEhzUlVlMzNkdVRjK1VP?=
 =?utf-8?B?RnF5S3NyVHRWeGxPdGVqdm5Hb01Ib3VGbWxQbDdEWXZIMm0yZTJsQVNOM1V3?=
 =?utf-8?B?d2V1aXFGYnVXdzdHVGVzL0JvaE5ROXBiK210Z2RaQkcwSVk5cW5VYis1OHZB?=
 =?utf-8?B?Y2lnalJhUWFobDBzMGw0eE9iNzVhOEpWTUVtZXFBYktqOFlkVy9kdzczTEVu?=
 =?utf-8?B?RHFERC9LczhueldiZUprbXVWcE9VUkVneGVEQjBLRjY5Vzl3QkZrM3hWb1R3?=
 =?utf-8?B?d0xrTG5yOXE5enh5clFwUDI0ZlpnVCtuTmFGM1pibjgvdlNIaXZoY2h3L3ll?=
 =?utf-8?B?aklVUlJZN0poRU9TVHIvQmt2MngzZFFXMkhqRi9vdm1CVzhKU1dsSWh0cng5?=
 =?utf-8?B?dU5xbUM4bWVFdExrY2tJVGt2L0lWVDRXSTB6Y2R3QzlXWjB2YjNnZTE0QVpi?=
 =?utf-8?B?UmlhRVhsdkZNUE1jQnE4RWxtTDhBMGF4Wi9ibVdKT1JkZnIvb3VXbjVRdTlB?=
 =?utf-8?Q?E+pe4scdeWxpr6G0eoXjFnuBO87iG9cK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628eb887-27ac-4dd4-8a6b-08da067b8ccb
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 12:01:34.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfz3rLzfr4XbQO+aPYNhQqx4kE6/gMLXmgGuOZQbXU9KJub3j4J7Zut/+DYXDae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1218
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhu James <james.zhu@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>

On 2022-03-14 10:33 p.m., Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> On Renoir, vcn ring test failed on the second time insmod in the reload
> test. After invetigation, it proves that vcn only can disable dpg under
> dpg unpause mode (dpg unpause mode is default for dec only, dpg pause
> mode is for dec/enc).
>
> [how]
> unpause dpg in dpg stopping procedure.
>
> Change-Id: If6ec3af694e1d6b63ebce386a563f03ca6d291c1
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 319ac8ea434b..6e0972cd1f2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1098,8 +1098,10 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   
>   static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
>   {
> +	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> +	vcn_v2_0_pause_dpg_mode(adev, 0, &state);
>   	/* Wait for power status to be 1 */
>   	SOC15_WAIT_ON_RREG(UVD, 0, mmUVD_POWER_STATUS, 1,
>   		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
