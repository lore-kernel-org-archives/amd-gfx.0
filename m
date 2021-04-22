Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD44C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF63613C3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 02:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF63613C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1B26E02D;
	Thu, 22 Apr 2021 02:11:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD646E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 02:11:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZqYUQgQFjx0pttjjpkTgHzPhmGBGtvSAtUV85cskeCZL2W8Ua0ZpFykAdmtXD3WSou6sfDHuyPlCQLrcXP6j4pRKLJP5ANJZ0M+QE9Zxc1J+KgiSijAEpqquMfKs/8cU1tQf3S7WWmrdN4EYDSUCktD0vVYb7nZh2KonPQLYgBXU75bh5gUFJgY1iJV+q+wb4FKvuGYrbeVeYIO5ZOAtosECpUx3xrmkNRuatcgPejOVa33V7tsDJsfS1EgcssNETmlZP5ho0lErnTVJftYGs86360gMbBB8YkzuLDs1wipyzFo2FX+o0JI2itfGubyQgEiLyVXz03Qx/YfEBqpZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g78A/OdCYTYzf36cgaXJ2UQMMPRVl1zU+bWDFjwDeQ=;
 b=eKTAeOEtFn5K+TldvBZzthCS4T70VuPv3PbokNV29ECsfOxOihHIw243i8godFjeT2LgtVw+xsrVpcAty/NgaL7lmYn3XNHvfgOB/AdwpX6YnuNpzOzh4pXOn7CqVKi2Bd/q+fPCU1QeUxELNLXqifuWBgZeh/IGLdMFSN8fRaLOfPeSRe3bd7TQa8rQPTHV0XODwi0KOAKnX60VYftzhhhXRA44lOju1vEYoeBZyqEd6wIoRqIU9kwBE+m3CaWS6P+D3G2BacHG/4dA9P8Q3M4rnqZ/XbDjCKVJC2senC68ErZQ5bfRzaNGLpz+Im0/230CRpK6U9pk6us5QexToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g78A/OdCYTYzf36cgaXJ2UQMMPRVl1zU+bWDFjwDeQ=;
 b=XDZH59sDSYV2P0bSt8JxIqEgP3tU2BRH3GD3BgTlG99y8oPVjijqU16FUIQHIxpHP5PELCnDhlxoWKCtPhJaYgBSXHzW1GItiROwpAZo3QgWg/+/+R9vL67G6OBsx0aZ2yNn5L+8QWsGIkaCTPRqVR1bwZ+NYUgIJnzNZ5k80hA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 02:11:02 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Thu, 22 Apr 2021
 02:11:02 +0000
Subject: Re: [PATCH] drm/amdkfd: Add Aldebaran gws support
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
 amd-gfx@lists.freedesktop.org, Joseph.Greathouse@amd.com
References: <20210422020117.2095711-1-Harish.Kasiviswanathan@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <525384da-d047-a71f-400a-9118077d0810@amd.com>
Date: Wed, 21 Apr 2021 22:11:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210422020117.2095711-1-Harish.Kasiviswanathan@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::9) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0130.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19 via Frontend Transport; Thu, 22 Apr 2021 02:11:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3e4d73-6da4-4817-3f17-08d90533e0e2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42070901C7A52487B86720D392469@MN2PR12MB4207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVSf7Fe6K8ss61N2OmOtDeRattu9IhFGW/KmLgJTlk6vJ0lmWEHo3JQZZlc4rhXy0cqpEsdnCh3L141NYqp8CFbvGA3RqLyS458SWLzf3HAd43l8TVFTafVUMYvjQBORlpxlkq7Yd17lwaNwb/JLQohtqtW5b5cWbPJ6mXk2C3FvioEs6QG57GSJpGKZrn/JId6rHaDeYytau9oYbiBWC6q5ytKfeZdy9ldJBQtR3Wc3nfUmkprJsK6oVQZo4JBcPBJCJRBhVY6gzVn5iddEPo7+4FDGeV0cKEy5SNiXxr5QWH4mm437s+FaZ12wY6AplsNiEkM23jDbtx2Je1fhd8g8wgfsBCGsbGDkn5kTqGbI8j6p/19kib4tymNUkIFsBGQkpJTwM6DfPNvsSYNkiE+h5zYK0YprNXDwS0EH+bRSt+yvEFjTjNFRVc2xCx/JAZ4PGa0C6RJ0H/czW3K/1eWVcsva/MOMZTXQzhf0bzOc/CZ0ASFtGxzc6lwzeu8wluSQCo8bWhtCTtanU1Pffg4juzoZYWGQxCby5CET98OcmiZLAn7lCuYMxWWp4QB+QkclRAYSJGSVvBg8Nkhah7xDCqYENZ8ucyvItzYsiqk/KU0E4P4H7PL3dqo+782POAxo1tB6r9KOSsoDxA4ZpcOUHI97kAsCwyGPBuPdAlKj//CxHRM9OTOKJmur4ExCK5bDFESEnDTAceXNGZgyIBqm56TncHt6iMA3Ef2+4sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(6486002)(6636002)(38100700002)(38350700002)(5660300002)(66946007)(36916002)(53546011)(2616005)(26005)(66476007)(478600001)(66556008)(44832011)(2906002)(8936002)(16526019)(186003)(16576012)(31686004)(31696002)(83380400001)(316002)(4744005)(8676002)(956004)(86362001)(52116002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1FTT0NKVGVvS1BNYWh3VHdzblAwZG9NQWFoZzhOajdjN2lhTVc0RFVPZzJK?=
 =?utf-8?B?dncyWjc3azlINDdwM0xiNVVqaTlPc0VEeThJMGRiV3FwSmZtd3RPeW1FL2dn?=
 =?utf-8?B?dlFXMmdha0F2VlZlclg4QzQvWTZabG1ZZlJPRFVJQ3p4WlNCR2MyZDgyYlYx?=
 =?utf-8?B?T3RsRnBCUzlCbUswZng3NDBQWDVWZWNBU0JJSldvQXNZMXJVazFsbzhydlRN?=
 =?utf-8?B?R3hlMldOQjRsbjQxTERoL0QybklrWXZKL01sbGNKZU1GK3lmNndGdzJteWlK?=
 =?utf-8?B?bGcvZnhyZG1hUXp1QmxGU012cWJLaTdHSzdKelMxSWlkOElUak95UFZZSktS?=
 =?utf-8?B?K0paNGJQSW94aWZ1Q3BaVXBJMGhrd3NiUlJHOGtWd1Q3REdoL1pFZUk0bURN?=
 =?utf-8?B?SGc2MFFTdzQ3bndpaCtzL3NnQzhOK3lSOVJuTEVUbUxlWUFxbXcvK0JPTGxI?=
 =?utf-8?B?MnRHOWVlRFZnWWF3SVc4bVRVY28xQm12dVBYc2hmZ01nSG9yK01seDVwQk1q?=
 =?utf-8?B?K1B3ek1lRVcxS3ZzcUxSbUFFeHpkc0wyb2dTMmpHL2Y2dXV3RWR0WTFkTjE5?=
 =?utf-8?B?NmJkZUN2NGxkNGVyTnhDQ0N5TFJoamR1aUtRaTFGUnlUSit0UU5Sd0ZEbDlR?=
 =?utf-8?B?c1hwNTJ3dnhNNGlxY0tGQWZieHpkMTZaY1UvVzk0VHQvNXlzNmR0ckxINmVk?=
 =?utf-8?B?VlZUWVpWNXZBMGxpRkE2TE1rY2QwZEdwQ0pKZVQvZk1uSkhrS2VZSzUrTnF1?=
 =?utf-8?B?T1pWQ2tMb2Jpeno4WjUyUGZXaHIxRTNBdDJERnYrTlV0YkoyTldHTnh1dHNP?=
 =?utf-8?B?bHVqMWxBUHhqUGV1b3lNeGIvRnZTWnVRMDJiUXdEdkZCeVVRNUwxakhUelFU?=
 =?utf-8?B?REpGS1d5VnBtVm5CUHlBcjZ6K0lQMElPYjA3YkJ6clZCak1vYllOU09POGRj?=
 =?utf-8?B?dUJ5REVxOU5hcUlaRU9XM2RoWml1MFVNNXZQeHVHbnY5UGJRWmUzQUtTTit5?=
 =?utf-8?B?RDM4NzB6ZnFlL2w0SHhucWhncUhDSmpBSnhpV2ZnbWtyRzIrRHpJZGVDbTZt?=
 =?utf-8?B?N0xZb1AxRU5XU250c1VVMElKWjU1Q1liSXRTdWRFSFYvaHE4TEV6UklEMnMy?=
 =?utf-8?B?Ly9TQk5NaWxadjBTU0FRUTVlRXlHZWMweG5oSWpmVzM1REpDWXlXNng4U1Zn?=
 =?utf-8?B?dUV1alBmRkdkd2d2djc1aUhlV0c2dDFSUWN4OThYK3JtWEVDamd4UWJtMUR0?=
 =?utf-8?B?SFJzb21wKzEwSVhkaTJEdWpVS1RTVUpkWkhqNGhVNy93UElWWm40OGxtMmJ3?=
 =?utf-8?B?dkNpcHZUTXFyNUhCRzM0ak9MOHNpWWFoUFMwK0wzY0M2SkZ6Z2JYK2dPU3BP?=
 =?utf-8?B?VmN2b0tJZ0lDMmgySTVERkNHWnF0NXBCSDVrbTljNTlIMEx3UCszakpzeFFn?=
 =?utf-8?B?K1hhaXpocWVyVmpNcDJXUUwwMFFtanRveS9LWVFDMGlQYTNocm1FSld2K0ZU?=
 =?utf-8?B?R2N4TFVmdGxKenoyVDlLMU5hVjhYdUtEbUV0SVdRQjNhWi9OY251WXBJR0xs?=
 =?utf-8?B?VmFUT3ZmbzdSSjF2YVhpV2xiTFFLWHppdGF6M3h3ZW51eEU1dkFxSlF1M0xF?=
 =?utf-8?B?OTUzUDBTS1AvNjBxbmNXc2Q3TjVCWEpiU1FTMHprRllMVytTN1krTzlwcXEv?=
 =?utf-8?B?VkpVY0tzamFZcHdQWkdtQkhmRzlpZVVMVmxkR0p0NU5LUFB4THNXMVM0ekZ6?=
 =?utf-8?Q?JbbTuVBSU3aHgMiFeoo4WUnXDKWi0YhCxYy6G1d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3e4d73-6da4-4817-3f17-08d90533e0e2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 02:11:02.6579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9380y7hFxoClKZgwUeA7gL+QLQ/BQWpNId3SVcsZtTNjzO2S+NHpenucEA9KmyrzatldHeNGGYx8ThHSd48lKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-04-21 10:01 p.m., Harish Kasiviswanathan wrote:
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index b31bae91fbd0..bc57b07523e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -698,7 +698,9 @@ static int kfd_gws_init(struct kfd_dev *kfd)
>   			&& kfd->device_info->asic_family <= CHIP_RAVEN
>   			&& kfd->mec2_fw_version >= 0x1b3)
>   		|| (kfd->device_info->asic_family == CHIP_ARCTURUS
> -			&& kfd->mec2_fw_version >= 0x30))
> +			&& kfd->mec2_fw_version >= 0x30)
> +		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
> +			&& kfd->mec2_fw_version >= 0x27))
>   		ret = amdgpu_amdkfd_alloc_gws(kfd->kgd,
>   				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
>   
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
