Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1449C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 16:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6939772F3B;
	Wed,  8 Dec 2021 16:09:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B57372F3B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 16:09:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epH4hnBQXqtwebITYNLNqNwKRhHp8Rw/SA2Mwco/u5IzBhRuZIav1gmc2VMnykPLaXIT/CG3xJV6Hr1rX0MjaGP9ztAR+BXkeUMzgWCTVLsiUfcHVIdTegk91FRXZIlYOfMVAbNQQ5nUegZm4DEWNdzwWbRnRRAzXAfSaxGX3osvALDg+0bqP/yW4CvQ7ve999tcW8GJT+EJP7Q7nUtUUw7KdVW/duyvuaIhnp9ZgiRi60qp29CZrba0EJbcwyKWDwE/8XCYyNX7yjSt52KLtR+zkBqri9wX/fsViPXjANUt9m/FNHQRCzJCvRcIu5ntQ8xd2I8UNStAzj6tfw0X0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSIt7VYFl6Ek+OwVlN8dMORdocfJTWhIIUZlHqIHiaE=;
 b=nIGm5Oh/NyLRiEIz0XxfWoCiwAD0/0UHmEdLjR0+BRTGCvitb2Fv/lwSofUEC0WXWa4/kuUslzs2ATgYTrZlG3gIor2qAj2BUHdHxtDuA7XzCDMYJdruhCSFVm+X0GA6BEpQHaJ6oOOD/gOF4YVAMGoVE4QATNBI7Di8P17OdrqmRkr7Uw/DR0Uq5u1Hao8kLLlp+KTvYCVUZVlJF2+8360eKRap6oUMYz8r6fp+HMHa92uhC4dXz0Dxh66B/TPoBU0ph6bRwYHXZsWYJSRKQ+ToijsFeP7fQFo6+VLKFjpMG96fQ56NUmg1gZ9S12kMeGGXWFqo4ewHVgozshp+sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSIt7VYFl6Ek+OwVlN8dMORdocfJTWhIIUZlHqIHiaE=;
 b=F7ura9CdDx4NwUUF8n99KLLHYBPvY+N3N11gAMD6rJ74efBFSSa/6GhbV9FpHU//XKZN4jcYTwcovZZaSZvYahtOtG0za1k9GemFhvQVOJQH5Edgtzy5TZ07Xa2iwzzn7zP4noj8hAVesYdqsnRAhJC/P7PbpUwFaExHQoMpSPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3305.namprd12.prod.outlook.com (2603:10b6:5:189::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 15:35:56 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 15:35:56 +0000
Message-ID: <6879fff2-fd58-677d-7473-682f1413c5d3@amd.com>
Date: Wed, 8 Dec 2021 21:05:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Shi, Leslie" <Yuliang.Shi@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211208084615.437375-1-Yuliang.Shi@amd.com>
 <DM5PR12MB246969CECC6AC8D12C2856A3F16F9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB246969CECC6AC8D12C2856A3F16F9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58cb5620-28ad-4512-54c1-08d9ba606cff
X-MS-TrafficTypeDiagnostic: DM6PR12MB3305:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB330584ED368195D0181C39E9976F9@DM6PR12MB3305.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kb/TAxBd4kgOH3ihNxoqgaWIZW8n6DeCrclFFydC2pvompUqstXC2iPx0vcnQP8YdB86gm67HRAeplgqSB8cm6NtirJgAv6al3CFvV6wrKK6W4/xEHl8JHKbhJZYRb/w9Npw5V1ZZonw5ITwQP41w+gARP8NEuDJ+BDnmuBxiHt0VzwrWVr/XMYS95SFqU497tA5xX0d+DE+LKK8ZLf4s99hHy79yq4+xmrfNIrLChVbXxGhEnXdf1W32dm1j7QBhdlfFqtbBrLU40kCddRJWcrtOtWxipUkCaorKj9gDnj8eb0rU81pX1iCPtX44XaH9i8N7fCsW2ASc4LfY1TcHdtSvs+e/eGu6h8A6qglmcqESEUg9k8KQZdyOKg9ag5PLbsEQtW5JoR7cWdh2FWLY1xsuCgkyBNJGUxYLu2SRmBhByBDi5AAZDYkcHxOr8Cym+mSg+yjhDEocevqYvpWZ6kW7P6U1Ow8sfWUbgqG38P9WzDOTiMvQf45Eop60Uj/ymdC0fgxNJRugOwe9J+/TpMgq9xh9kGAvgW/tl8bVRhcEnmn0SU+llzcJbsdsJAT+gjxmTxYQ48OzRmWomocGQTjAhgIPnunJvLzppkOIIfssI0hwXhX5BePepwxKttMbgO/WHuqnoTI+weGLwlbF2wb6uwsAT2hMx9+Bbp1yPHcXoIrIZrsDUJj5+792oCj22GM8tS4423Sr5uctCFV8EUZcK9TVmGNQ83QXwOhZSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(53546011)(6506007)(31686004)(5660300002)(2906002)(26005)(83380400001)(508600001)(86362001)(110136005)(6512007)(6486002)(38100700002)(316002)(36756003)(2616005)(66556008)(66946007)(31696002)(8936002)(8676002)(66476007)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm43NzF2c2xaSlorQkRaazV0S0FJZGY1OHJvSGN0ZTdqcVh1ZUVJOVQ1N2hv?=
 =?utf-8?B?TUhBWDkzZDRWdUV3S0FsV2k3dloyK09RYk1IMFFJZSt2ME1uemc4UmMwd1NI?=
 =?utf-8?B?MGxsVENWckFwRFFpc1J6bFg4cjRGZXZnN2g2cjd5dCtUVmVPMnRlYk01WVJr?=
 =?utf-8?B?RVJ4eG5HRmRZS1dVb1Jsb1dBNFRhSDNLdmJYTjF0M3dIdXpWMkZsQkNJaUVO?=
 =?utf-8?B?dndKNmppZjRNYVdYUmRSZk00TkVJcllMcFhsNXl0V3JZaHZOTDJZWGJoRmg3?=
 =?utf-8?B?bEtyd3pIck5qbHQwcEJjLzV3aG93OWZSMDkvVHNra09qaENTUVJLaGV3MmNP?=
 =?utf-8?B?QXNaNWhsY3NhWnlUR2tVNEVLYjh3eWorbGppUDFQa0g0OGFaNjhmVjBRSnhE?=
 =?utf-8?B?OGZ4UzhMRGlFRXhvbEJlV2p2elhRZVZrejN1enhPU2t4VHJ2aFJLU1IxQnNL?=
 =?utf-8?B?TjZ1NSsvZmJUb2sxQ3VNVEt2cXZCbktlOTFKNFZucm5sMFBDOU9IalQ0a2Fw?=
 =?utf-8?B?Vlh0bUxKY3JVTmM0WHdkRCtaQXBNUWRodll1S0svWmxNRHplQWtDUnJBNzNq?=
 =?utf-8?B?cmxBWGdnT3dHQXgvM3JOeHpOMVAxanYzUFhTcS81QzBlczNBcTJKZFQwak9m?=
 =?utf-8?B?ZUcxSlpKT3Iwc0RHTUErNk1xQ0k5N3RVNXptUVBxWjBFcEpacUwwQkxRaVR4?=
 =?utf-8?B?NGFGcjJINkdxZVNpMUQ2ekN0U3orbFlNb04xekJudWNqUmN5ejl0Vk8rTEN5?=
 =?utf-8?B?K3RFRjhnQ1BhMnJuYzZnbnN6K2c3MXVlZ1FrS0J5ZmlENUhlbzRpMnhmQ2NZ?=
 =?utf-8?B?L0dQNVN3a2t4MUhlcGV0OElSYVBqMUZpQnpxN2FjVWJsWjlnYkdnaE9BMFg3?=
 =?utf-8?B?Tnh4SnhTYi82UkYvWWpralg3RXVoWVdzR0tYZ0UxUTUzWi9VT080SUxmRHJx?=
 =?utf-8?B?K09DclRmSVVCcnpLUlZqY2FWKzBpR1BrK0xRTmg2TFJ1TjAwQ3k0OFVXOGFF?=
 =?utf-8?B?a0ZhZkp0bWxudUtpejNhSkF0WjFTYmhRMzJZSGZWRlJBOWRXdlEvZ1psb3Ra?=
 =?utf-8?B?WUVta09qTDd0dDZuY0JkUmh3QUFPbjd1Qm0zbmRtbWZ3WFFWaE5OK216QUlY?=
 =?utf-8?B?MzhjSkI4aXp3dDJDM0VzUThYcVlyVTJJMjkrSUN1WURweHVKc1pPWHdDaFlO?=
 =?utf-8?B?NkdETmtrdVU3VERXcmNVK0lUUTFkbU4vZitRVjN6bEhVNW9SMXliR3VoQ3o0?=
 =?utf-8?B?RHhRaU9aTEVkMTQwNFBvTmpsVUpOV2xJRW4zSHBlb1NzQkpLNkR1aXpHSURh?=
 =?utf-8?B?M3lWa290TjNSamg1eHZuWjJJMXdMSDN6RDVGWHMzcStiZ09JTnJrVjhUb2l1?=
 =?utf-8?B?UjdnU001ays3K3JYSlpFZlFUQ2tOVjFZbkZZQ0F4djUvRDNDZXBNQTBPUjFY?=
 =?utf-8?B?Z2dKUEh4UGR0bXlSS3VYaHdFczFsL1oxYTNzdnJlSWF3ZFRBV2RpeEJma0hq?=
 =?utf-8?B?RFJGdVhDbGpnQTRlM3d6dndkM1FUdHpyU1NUS0k1c1FuNmhXSm5CTzM0T0c5?=
 =?utf-8?B?MVlqSC9IK3ZiNG5mNC9Eb0lOT1RqWHViSU1paXRJWnZCQ21nejRNOHR0MXRN?=
 =?utf-8?B?OHEwRTh1QlpkOU1JOUtQQkNKOWJ1alhCaDZiY3pIRUVzZm1SdzVUbS9TdGJG?=
 =?utf-8?B?ZG9WYXYrUG15ckdUcFpDcGQ2cUFCUTdxNGE3WGNEL29hR0pmZ0JaYXVNams3?=
 =?utf-8?B?UjQ5eVJLZEpOZWxOTGo3ZmFaZ2pNdHlhN3JUdlEwQTZBa0FmNFR1OUhiSnNn?=
 =?utf-8?B?VVBhSS94R1dSd2R1UUJ3TWJpMzlUTVZRWXZmS0t0UVpnaGZMN0V2eXFaS1J0?=
 =?utf-8?B?NUMrdlE0WVpra3JxWXZJWmtxQ3dPakVyQi9BTnRxOC9IaDFHc2dzQnZ5bGEz?=
 =?utf-8?B?cFdkOG5raFVHeUJSWG96U0Voa21Nd2NzekZQQ2liY1QrazFCYndJZDJoTnc3?=
 =?utf-8?B?SEtDNnJHalQvTlF4VlNBbFQ3bm5tV0tOVG9xeDBObzFYWDE0b1ZNQjhXZXpa?=
 =?utf-8?B?QmlDa2lhbjBsTFhTdFoyeXJlRWVzeGJyUkFxYVROYnM4UW1HTGRVU2tpVUh5?=
 =?utf-8?Q?DyTk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58cb5620-28ad-4512-54c1-08d9ba606cff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 15:35:56.2172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCJQ3K4iFRxCLMhMeGfg9CIe2sSDCYIREtG+njW1T64lkUDDhwf9Ng3LDMrzGzE6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
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



On 12/8/2021 2:43 PM, Chen, Guchun wrote:
> [Public]
> 
> Hi Leslie,
> 
> Can we move revision handling in this patch into amdgpu_discovery_get_vcn_version? Then we will maintain all revision handlings only in amdgpu_discovery.c.
> 

This seems to be more about VCN config than revision. A better thing to 
do will be to rename sriov_config as vcn_config and use that here 
(regardless of SRIOV or not).

Change discovery code to -
	adev->vcn.vcn_config[adev->vcn.num_vcn_inst] = (ip->revision & 0xc0);

And check here as:
	vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK

Looks like baremetal enables all and VF enables only encode or decode on 
particular VCN instance.

Thanks,
Lijo

> Regards,
> Guchun
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Leslie Shi
> Sent: Wednesday, December 8, 2021 4:46 PM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: fix incorrect VCN revision in SRIOV
> 
> Guest OS will setup VCN instance 1 which is disabled as an enabled instance.
> This will cause VCN ib ring test failure during modprobe.
> 
> Fixes: 36b7d5646476 ("drm/amdgpu: handle SRIOV VCN revision parsing")
> Signed-off-by: Leslie Shi <Yuliang.Shi@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 2658414c503d..2323815ac32d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -293,6 +293,9 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
>   	if (amdgpu_discovery_get_vcn_version(adev, vcn_instance, &major, &minor, &revision) != 0)
>   		return true;
>   
> +	if (amdgpu_sriov_vf(adev))
> +		revision |= adev->vcn.sriov_config[vcn_instance] << 6;
> +
>   	if ((type == VCN_ENCODE_RING) && (revision & VCN_BLOCK_ENCODE_DISABLE_MASK)) {
>   		ret = true;
>   	} else if ((type == VCN_DECODE_RING) && (revision & VCN_BLOCK_DECODE_DISABLE_MASK)) {
> 
