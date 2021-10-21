Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7B0C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 09:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3B39603E9
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 09:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D3B39603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B976E3E3;
	Thu, 21 Oct 2021 09:44:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B46BC6E3E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 09:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6l/Gv9XSdwssOugl5ET9qAMeyOkci9Q1JPzT8gQsUfMDNqQE9U8NHtCBdHzlHgu9ASHblJGzlpTvkUwy6yUq3npYH7BJYYqVgY9L5LhlL3AIdZjEU02P2IKCVriv9ZAdhZ246S/5kAnzjX9x4qx7oB6/bRl2PAXspvp/UCm8tRQGXaoHOFWxerev17XJYD4W8oFSoIcb7C1T4tv+24glAnzCJWor9pT8CD5H/ZC/JdkyTM3kb2icHi5zaVrENnVIO/Fkcv+n9bJNyhrTQ5EpKOdcaEO4k6hrjTj0cLPX3htUffmBmd2U9UiYwTnU8IJRUepL7jI2vgcieNp4Aq32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUjcAQmb0PwwbYL3nJ8g0sgdow8QAD23BfWtpVgO9gg=;
 b=exhEl5ynPXuHjJ0+lozO0J4QpNjsqpisz0C0FVwTm7fzttSALeZXnGjhE9jXJPXwQ9yN8H4i2Hpdyn/B7N0DEambpy7E43dIscKAK7eB5XvWfxDG0IidXutXS1FRA65WXO0VpZGk/JCHZOcj1XXxY/lWDVWQ/FwaFgPB78MXF8sq5qBLo8m1w4KSPPGzWXy8MqQpT7dbWr4fmt8qMGOYWzRGuGWz/qtSWJC9eexT7xwPzwYJdfyD/jCeOIMrondiFz6k4C5lRU+y/S+TVvVBFX58019MNTqdZFKvySK0/2vfVLnl39XVFD3KvT/yjldvawzxrXV3lTINiNMBWrdEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUjcAQmb0PwwbYL3nJ8g0sgdow8QAD23BfWtpVgO9gg=;
 b=SsikXUwRuuD7Nn8J+nTBg21CtejLkWsTfHhOr0Y6bZE1PGh/SuCI8wq053+GDjby75QDcNYWlhh09SjPWHKNaJ9dXlPHzF/NuLGHyzuu6s1B/VzoaJ+nb9HkIdZoyiEqJ3nh8fAv/BJpwnbuOj5WSRIqZYd/rgYsgQovzn5hDU0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4617.namprd12.prod.outlook.com (2603:10b6:5:35::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Thu, 21 Oct
 2021 09:44:52 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 09:44:52 +0000
Message-ID: <e6651a1c-50d2-af66-c985-4b500dcd12f8@amd.com>
Date: Thu, 21 Oct 2021 15:14:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] drm/amdgpu: limit VCN instance number to 1 for
 NAVY_FLOUNDER
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com,
 leo.liu@amd.com
References: <20211021071512.20034-1-guchun.chen@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211021071512.20034-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::14) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN3PR01CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:95::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Thu, 21 Oct 2021 09:44:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45e49abb-f2ed-42bb-a39c-08d994776e0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4617:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46177FEC06E81BCA7F7BB5EE97BF9@DM6PR12MB4617.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CG3STrPrWT7Y7kRDwyFqs74md7yLmWarOvWPtfQ4w9GCQUnZatk1wgRJGshhwJO8kUIIhEJ/27uP+OeLEH5J4R+jUAG+9eQLRoiY2/afED+Xzx7UuVIBJhztHX4TzsN0XRdzMUuhTBBG+d++1JEnQArJJdO0bux9BltXEOsDSM8BuVviOgeSKbe5X/u1GHhmsMW9bRYDdLoV3gIbq5luDzmNnb/Nsoh0FZEr/fPkyhkA+kvp5gh3X1NoJAgZFte8Y6nZ7yYfnOs8mZuwGC75Zsgz/2oV61TbBWWocRSbSGGReQjF1jIpe4v3E/1D1xnIlbrt7BSr7Dp4NKFqlpBKMRui3gCyatWVYQ4znf6cSrpKoPq2d+403MCdhzh2Sqcl+RMiDWgm1wk66AzYcKc/yCj91djNals04KnTmbK8GrbsozOuFSMYsi0zS6Zbo/2T0DIzj4BJBe2PfdH0gg5zAEqDywelSd9kUiO1uAbsZl+1IVYBPE+fU6wOOzObYy52vvQYFqrAxECadY7prkHN73kN3pLTMCHr9PMrYzFjs/BM6omusiAtE8sWFaNNvhb45yI3zTO9N3t7Kz+mpC5YFrYRD1me48Ym8TROYXQvcF8wmht9QQbrqyoxC1+fROPrPU9O4/rrgIWwvOADhecPIgywo7mfG54zirtINNm1kQ8dHZd3X4sifFoc5dQmQiQSAGLjK3hLyAlqU4tmOFMqKiOR969YY9fhXB2CIDDZNlI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(31696002)(2616005)(38100700002)(66476007)(83380400001)(66556008)(8676002)(5660300002)(186003)(53546011)(36756003)(8936002)(26005)(6636002)(66946007)(2906002)(6486002)(16576012)(31686004)(956004)(508600001)(966005)(316002)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkJ0N1krWUc0dWxyTGtKdHhFa3Y0QU9CcmtMV2hoMnlDTUZ1OWRvTUlTSk05?=
 =?utf-8?B?bTNIZ0RiZzBHZ3JJdUVDN296WFp5Nm9iL0R3M2NVZXdPOE12UUNlRGlHMlBq?=
 =?utf-8?B?NE5DUExtV0tPSlozVVhQT3J0ZlZZYWxjejlyc3J3eTBBS1RhYXZKV2s3eDUw?=
 =?utf-8?B?WEplYm4xb0U0eUptbkJ0aldRcmZYQ2taM2Z6R3h2eWozZVZFN2lmT3hjSzR6?=
 =?utf-8?B?NzFOSmtrVm1VMzZBcTZzL3BwQ280NlB1UXpSbGJTVFJpWC9sajNwTWNnMUVE?=
 =?utf-8?B?cVlYTHFTOHlaNHJlSDBDdHFlK2ZycVpSclZ2dGhZaWs3ZWwrN2h3OVZwUEw2?=
 =?utf-8?B?cHNvQkprU2REMDYrUWZldFArQmNLb3lMbVJvaDNLRHJOcVJ6b0RhSzlZc3Jv?=
 =?utf-8?B?dnY5Z0gydGc0MDlPc09NMXd6dkY5YldYcHl6OEJoQ1FuZHYzTWpGb1YwRVll?=
 =?utf-8?B?dVByKytKN0pxVVpIR0xmU3l2Z3dkZDRVRDlVS1h3REhkeFRUU3ZhdGwyOGxU?=
 =?utf-8?B?aUd6cnI2dFBtcVdRZ2oxTWtWWkRvMTJ6YU9ya1kxMzRQNDNFd09IaFhhdm16?=
 =?utf-8?B?cjhKY281MTRSL05QUW1wdStFSnpRSkkyS3VsYWgrRndHWTVqM2tmejQ2cm1n?=
 =?utf-8?B?YWxZbGJRSFE4alNheHA5cXd2ckZ6RnRXUE9xSjNIT1kyYXJlN0tQdjlpVmFa?=
 =?utf-8?B?U2NRK0pVeFBYeFAvL1Q1Z1FMUG92dUNEYkJ2WDdYRFkxdmpucjI0aEpoajNG?=
 =?utf-8?B?VWJ4Z3BvS2ZaZk85Rm5SQW05RzREaVNYcnFOdGE1b2RpNDl3dXZtTDNneDJy?=
 =?utf-8?B?R01iNCszdWtvdm1KN0pUaFl0bzd5ZTh0SW9MTytoU2d5cGY4S2ZBZ05kTlFY?=
 =?utf-8?B?S0VXNzQ5Y0Nhc2xBZjRDSG10bi9FYVRCOU1rY2xsbDkrMXMxNlR4YmYxY3Fk?=
 =?utf-8?B?aUV6a0pzWFc2ZjZPdzMwZ25CaEc5dEpSVFVycWxDUElyZ21YcElRNjY0KzdL?=
 =?utf-8?B?WTVlU3pDaDJpYmV1cFFhcjdOYVdGNjY2S0lqZmpEK25ibU5JbzArY3NoLzNR?=
 =?utf-8?B?SVViblR4NlMxM2xsTHZCNDczeWpIbXhQTmUvK05BSDBFVnFJZS84Ym5xbUJw?=
 =?utf-8?B?YWtwZmxKVi9KaC9KYStCbE1ETEFGb1JDU1lvc21pbC85RWJZU0cvTVBXOXNH?=
 =?utf-8?B?cUE2L05PcGsyaU9MNjJ3SUJGR2p6VzVFblNkM0RtbkhLNUN4WHZObStkTzdH?=
 =?utf-8?B?RFgvMWFoWFl1VjhzUGhrZFZFQUFOUSs0UnU5Z0FWUXV4LzI3c3krNUQyUHVk?=
 =?utf-8?B?OFgySzM2QmhYMlprU2VpbzRHanhhd2s5TU9DdUVZeDNlcm1GalRROHEvcTJN?=
 =?utf-8?B?NTIzMGVZMlVDaUh0RityMSsrQ0dLNHBnbkYwT0VwTlM3UklTMExVekVuOHg3?=
 =?utf-8?B?M1dtWVd3SDUzTy9yMDJCNTFyS0MyT3FSWG12Z2RscE1wWENBNm1ldi9qZWhq?=
 =?utf-8?B?ZWg0eUFXWk54d3pYaTA1VElmT2cwZ2xodnNmUzFGZ1ZOamFvVHAveXRsdEhu?=
 =?utf-8?B?L1ZRZndTYVRNRDVuM2lKcUxzdXdrZU9HVTdPbUJTQ0piNnBsZlA0Z3pESzNH?=
 =?utf-8?B?dVN6endITlV3L2RpWGxXQmd4V3J2QW1JdlpMUXNjbll3Ukh0V1c1bm9jRTBK?=
 =?utf-8?B?TmJ4MXNTY1FXRjBvc3pZU3hzUGVxR2hicURiRENDWTN4SlBFWDV4VzJsYThy?=
 =?utf-8?Q?jHt1rJZaQ9gfiBDFDQkZwSU4SJhVzg4AB9cdnp5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e49abb-f2ed-42bb-a39c-08d994776e0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 09:44:52.2154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4617
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



On 10/21/2021 12:45 PM, Guchun Chen wrote:
> VCN instance 1 is power gated permanently by SMU.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1743
> 
> Fixes: f6b6d7d6bc2d("drm/amdgpu/vcn: remove manual instance setting")

Nice find. Looking at the fix, the logic is already broken by
5e26e52adb46("drm/amdgpu/vcn3.0: convert to IP version checking")

Any ASIC other than Sienna which has same VCN IP version (3.0.0) may be 
broken. Any more extra checks?

Thanks,
Lijo

> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index dbfd92984655..4848922667f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -103,6 +103,15 @@ static int vcn_v3_0_early_init(void *handle)
>   			adev->vcn.num_enc_rings = 0;
>   		else
>   			adev->vcn.num_enc_rings = 2;
> +
> +		/*
> +		 * Fix ME.
> +		 * VCN instance number is limited to 1 for below ASIC due to
> +		 * VCN instnace 1 is permanently power gated.
> +		 */
> +		if ((adev->ip_versions[UVD_HWIP][0] == IP_VERSION(3, 0, 0)) &&
> +			(adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 2)))
> +			adev->vcn.num_vcn_inst = 1;
>   	}
>   
>   	vcn_v3_0_set_dec_ring_funcs(adev);
> 
