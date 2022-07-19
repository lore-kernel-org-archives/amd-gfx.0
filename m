Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F56DC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 19:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A219310FA38;
	Tue, 19 Jul 2022 19:02:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE55914A0F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 19:02:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmzgn9EmAkSfy7aK/wR8i0oQEj3UALP7F0x715QPeSI/bhGymGUvRNE9royQ9L4OCpteAEPwSDZmqWslzlL+1rAO34MDN/6EmGUcBBioCzUwvkpbih42cIZD+P3YfxFxC3Kv0E3M5r6yhRwPSAhieXj8b/B+zl8S2PNyOXovGq79CJ3hvCK+wGI5XKfSq56Ux7Boa4lFmR7dSki4bA25xqsl5LlHx75HYladFpumJm/VWMJb4RgOlq0Im8i0FMqb1pFHyrYsTLVgVi/U90RL69qHYTGAa/Gl6S6jpPfU4l4abazGMqDONC5k5iuO6z1eBwNKl/WN8nOXDL5wMs9sqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ry8+dbEsPauAulM+PPKQE6rvy9rLrGi/iDGnaJDUEfQ=;
 b=ARjL+Ql/lKIF/b3LPz6g5IiJ6knunnTuvouZLHuCwDGrKP9NUFZE5xHvygABsBXaPVKlNfW4FvhN0/wL0p7ZgdGoZ1yJJQd1dN3WJxN9d4BklSAIgy6n3JpRMrtkxNgV+RoDpapzepcBFwAm3eB9/s9y9QwgWGobe0k3oacujiMZLHJL8E0wxRnKXEjBtZcXroLOL7HkjDvOw6Gf12uWo/ysGJ/7GmIxjso70AwMYL0cmMenjOv2Dp//AvzKeijJyZPMlEvQmw82Fsq2rfK4QyWVCXCRkA64pePAesYja1t2kjQRIvWNOFT9BwN2UfBbxHHXXQDTuVeM2LHrXnKwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ry8+dbEsPauAulM+PPKQE6rvy9rLrGi/iDGnaJDUEfQ=;
 b=IwlnY0+KH8MZ0wcL98U6loFX8rimAvdTySpZEwS35/m1a+2jgcuVVl6N+6wYzlMIHpYB9dyUgda7YHpIFvSGek92HuL7H/WEmAr3hv6VKgA+pJmsicjTw7Ktq/8b2yqXblvlgAN2maBbnhfvPC9Qqk2ELCq1fNg24RhtYA9tSmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB2695.namprd12.prod.outlook.com (2603:10b6:a03:71::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Tue, 19 Jul
 2022 19:02:54 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::6999:13c9:d124:418a%8]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 19:02:54 +0000
Message-ID: <93897c67-75a6-1a40-c6c3-16104fe8997b@amd.com>
Date: Tue, 19 Jul 2022 15:02:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] drm/amd/display: Disable dmcu fw loading for dcn314
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, nicholas.kazlauskas@amd.com
References: <20220719182646.23049-1-Roman.Li@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220719182646.23049-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4038992-ae66-41af-df8f-08da69b948f7
X-MS-TrafficTypeDiagnostic: BYAPR12MB2695:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m89+bkdB6KuJpN9e/wvKnI+iEC4+iyORwWucOVtfFwCXh3ZLNlfph07ZH0oC9DZLnDk5UBIO36BuX22O36O5V6tyXUihKDj7fJ4r279hjlpuPxD+vcEzy3vXtdpIrZ0Pr7cIpMjKZaVd6cBZ5luT+c3fDU4ODuuRAlEPQIW38z2SrGFU5eajm5HdU1s1L7ZaQOZTjtFfe2KRKGjFehlH8IaIXTLGHCHEoo9S56iLNeoTSvZK2nXk6PanCMuEbnUJxlMUR+zCAONGwgGD25bSnkjrVPhUk3f6PaQGHsGRb4hXsG21yzliH+4dhk3lTkTlG9R/y4MNkkkG2y+WiQq9QHZJon2rkZ7gy4pALYqX/5QK4MbzQtck/zcMHd7iKOVUUTlPvf17QCj3fNmCDpDY0GmPPlWEuSBu9LToH/c3dPYtGlHTbYuFftSfRz+yjs/Lbxn+7M+MbDlzW0cvAMoZ5J3mggShMuTyQ2hYaEf9tn5D/Mc/rMMBctS2vdQHTlDYeXDmB6Yo3nDuFf66w/S8OUjzX08YEqRGsha/48jvpPeh7nOjyRsufidGxgoVfvpATCTXKGiwXhfOxD8IouoaEMs4UYEIJbmgZF+OrtrryHen+5vtPemTxhp1szzCQMvDO2y9FSG7F9fgPGZSEbcYU4AXSzEt/b0wgCppojULsSOnSfTnZG6u4bTQdPpQCk8XoQjAVLY/AkviXU/eATPT4bJkfNHe8YGCGlDnU/KQVxoJhAhETXZwhqj6/PDxguv6ZHd270El2whg9pRaqXOr0j2zqiI7SziWxYlCkxWKhHGVNcjLHenCpG+DYpMAAQnXczoYLxXp+Fm/0Q2bsiRQyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(8676002)(26005)(5660300002)(6512007)(6506007)(41300700001)(6636002)(53546011)(6486002)(31696002)(86362001)(316002)(478600001)(6666004)(44832011)(66556008)(38100700002)(2616005)(186003)(66476007)(36756003)(66946007)(8936002)(31686004)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1padFJpU1J5Z0Y2aDNMZ21WUnF4aGhyMlE1LzV1ZXhKUThaaFFFL2hIcitW?=
 =?utf-8?B?b2Jua0F6UnZFQkpFUVZsYUNlVWQxYkxTQk5FTXkvUmI0MGozWlVWb0R6cE1o?=
 =?utf-8?B?di9OVk9iYitVRnZ6RUZoWVFuRitsaWJlMC83Q0pKOVlGd2FlUFV0WlNPcnhy?=
 =?utf-8?B?aUEzUjgxZ25XVjVreWx0dmNZa05UdDROQ2hncVZlV05YSXpJczNqNGwxTVVO?=
 =?utf-8?B?TmdFZFkzT1ExOEJWcUxSWFArZWd6cGFTcCtUb0Z5YnNubTV3TkdJZVpaeFJs?=
 =?utf-8?B?Y3M2MnlycUlzayt3QmlJWDRuQXlCdWxhZW9xQkM3UVdKWTk0YXA5MXU3Umg5?=
 =?utf-8?B?VFNnK2NsY0JVdUZ5VUpoQXpremh6Q0FXZk95NjN1bEtFOEZpc2VWR200RTZ4?=
 =?utf-8?B?dGNSTjZuK1NzdXVPMFNNanNicmJaYXZlV1UvV0t4UHB3N3ZZV0dITm1kbEZ6?=
 =?utf-8?B?eEdiT2oyODJWdEVBQytIaVVkTm9FZ1lWOUs0b0VNU2dEUXlJVVZaSjNMc3Bw?=
 =?utf-8?B?STFiUy8zU0pNZSttdW9oUm1KZktHd2hnM3J0bHJIa29aRXQxZEozM0dVbWlq?=
 =?utf-8?B?Yy9lcC9sSjM5bjVUZC9WMTdUd1BvTmxUa3NCc2pwbXc3Q2lYQU5yRWFNK2lw?=
 =?utf-8?B?YytQUmhheTY0akRCZVRFR0Z6MTRKSEtqUW5zbDNoRWZIZS8wUnpTSXd6UEY5?=
 =?utf-8?B?RG1EU0J1dDBkeHZEcHJpRllnMXgyRHpMUWhhNHprQk9tNDRIRFNMVFRHaytl?=
 =?utf-8?B?OWZNeGpjanpTZ1pZeU41U21LVXFEMElnZVpoTTB3RkZMV0RtcUdDL3VVeVhO?=
 =?utf-8?B?YktQSkVmMFFIdVRMVUxrOG9RK3RTS0VoQkdzdTZpU3hCMVlQVDZUWjVEL2ho?=
 =?utf-8?B?emt6N2JGUEtrWHFoMU5yR3M1enR3aVpYOEZhOFRYOFFING9WT0hlbGRPeGl6?=
 =?utf-8?B?L2lGc0lGakxUMGJLQ1QyQUdwV0NnQlNMUG5wYUxFeXdOWklUTHFrNFBPTmxs?=
 =?utf-8?B?V3pIZktzOHpScEgxUEw1eGhFNk5UL2s3M0h5OC9KdHdMQ2FjM1haR01Dck5Q?=
 =?utf-8?B?QW9pczU3cnhCT3BjS3NzUmlEK1QvNlFxSTZwN2h4NkxhclI4a2VISFRMcWpM?=
 =?utf-8?B?SjJoOWtpbXZrZm82Mm84Z2t5dE1MS3VGeDJsQVZDQzROeWhIR3J3OFVpSnZT?=
 =?utf-8?B?L2pBRCtUeC85M2oramQ0aVJtUFo5Tmowdk84L1liN3BjKzBaTmlTQ09xc0RW?=
 =?utf-8?B?czNqSVZOMEJKZ0JZWDVEZlNGdGNGVjhQeHlrbGowRFBGdllHVVprR25CQytX?=
 =?utf-8?B?UktxZ3FwVHZHN2FTRytzODMxYk9nN21KYWJOTWIxRjdnMVdXdThaY09ORmRn?=
 =?utf-8?B?bTZubzNXc2RmQUw4aXdsWGRUemdHN00yQnhack54SUhLcXdDT3djWXpFbEtq?=
 =?utf-8?B?NWF6VjQwcGRWalNPVXdYOFgyeHNZdHNRNit4RXpUSUllN21xMVhRaloxUzl1?=
 =?utf-8?B?UlNFMkNadFNFYlBTN05admdTTENLbGdoVjFQRXF6ZjUzUWJ3VExWTXVhSUxX?=
 =?utf-8?B?VlZXUVVkajVnTENBRnZhSlcybzQ3Vmpyc28xcHJibjFBcFdTRWRnd0tENXl1?=
 =?utf-8?B?VkZWS1YxRUk3TDdjOU5IOE1TNFhtTDl1dUZpcVJ6NDNSQUpJY3FMV2ExaUd2?=
 =?utf-8?B?WnI2UUpBaW4xdXNkb2FEQmJNVUYraEJabzl5bTdMcE5hRGdNZWJyOG5pZmh1?=
 =?utf-8?B?bnBmeHMySnNMYUVDUHpBYWl4WERoV3d5Um9mbDVDSS9LeUxhb1pwcVdGU2Fm?=
 =?utf-8?B?UE9kRFYrVitidnk1OENSZFg0YWdhVDFZZWxtcklzanpweXg5SDZ6QmdkWEFB?=
 =?utf-8?B?R3A4aWpWZnJSNE5GRXN1eHZZOEJwWm9iclhQNmQxS0NCNVR2RDJjNjRLdGps?=
 =?utf-8?B?UjVURmFrMzJCUXJMZkJpRzdrSDFlc3lWcUVkeUlmZW9BalBldko4SWtWMXlC?=
 =?utf-8?B?ekpEV3BzRklUeUx3cHF4bGZmMTEwYmtpNWxNMG85WDJCcW8vTjk2UG4zWnBF?=
 =?utf-8?B?YUM5TU9HTWNtSm5BdW5OK2t6ZlZ5TUpzTk9tMDREWW9QZmZUd29SdWx0d0JE?=
 =?utf-8?Q?2hSGS/A/BWNka9IrCT40EO8/B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4038992-ae66-41af-df8f-08da69b948f7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 19:02:54.2447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYB5dIATTV58cuLCktu17QKWe1C6tE38M/leGtfta77Iep8KKivivopxnJwhQmuEGPG9nydJg3fIjLrbr3QO+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2695
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

On 2022-07-19 14:26, Roman.Li@amd.com wrote:
> From: Roman Li <roman.li@amd.com>
> 
> [Why]
> DCN 3.1.4 uses dmub not dmcu. Attempt to identify
> dmcu firmware for dcn314 results in dm init error:
> "Unsupported ASIC type"
> 
> [How]
> Add dcn314 to the list of asics that don't require dmcu
> 
> Signed-off-by: Roman Li <roman.li@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Might be easier going forward if we simply return 0 in the
outside case statement instead of explicitly calling out
IPs that don't support DMCU. The default (any new ASIC) won't
support DMCU.

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index dae998e014b0..9fff5aa86567 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1893,6 +1893,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
>  		case IP_VERSION(3, 0, 1):
>  		case IP_VERSION(3, 1, 2):
>  		case IP_VERSION(3, 1, 3):
> +		case IP_VERSION(3, 1, 4):
>  		case IP_VERSION(3, 1, 5):
>  		case IP_VERSION(3, 1, 6):
>  		case IP_VERSION(3, 2, 0):

