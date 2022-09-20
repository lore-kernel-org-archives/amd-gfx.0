Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DCAECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 03:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E5B10E25B;
	Tue, 20 Sep 2022 03:42:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E46FD10E25B
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 03:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LikScIAp0g6UVskHSwWAQLY30dTpJDxu/IMUY1ZjATSPfQRmdwHo0bzQTzdLTDD+dor4bwzkxfXie/I6C/dcKJSzxMtp31BPu9058iGtxBEkY2eC/mGJIi16qpKYYTu9pbM8SjR9EuOF3EvidDDkvJo7+OQ8Co5J8KBzruqd9i6itgagtkRmKGTPNfCy5lq+ppLYdIEjC7uMoHWAvG3ivoXp7CiaKKKWXsceWO5p6bpiZj4nRDTTsxdxX3yuxTErasPqQr/cuH08S2FsYvyEv5Z17Jes4ENpGwf9mECcSzZBjLhym49sBQYqqEQ+m15bHa2zSldONgiRmiaBbYqz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gF0YlZustLAsQwHsgcAAcY/zv+00BjZOTsymd8RzUZs=;
 b=anmhlB1jVlletN94Lx6v9E/MXUVPaN8Kz29/kP2PkXZLXcq8bzTZDjgjw8BYRWAb5mf6LRAyrcwVjS9muBwT/5UNODbch4w1p5PpPChyI0Fl1T5FIZIlxwqQsO9TolGET3mhKb7r9Z6frS5JHRlifco2DD+D4N6/A5HPlBhvckyikwWqyj1YK5b+v90uqtqI54NBuH2+3ICCSi4QoaZaaZISL8WTQCTObmOPvkyF5R8aDcBRcB5fkVqwyYuqTwfVaxiB/vZVyKCKQfrNPQEfpaKj8EGg1kdvX5L05WokkbhlBR8I/m65TSe6QX9OzTd6D55ORzWdwT49q7HiCBCzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gF0YlZustLAsQwHsgcAAcY/zv+00BjZOTsymd8RzUZs=;
 b=aqwvvxuJSJ+9775+/f+MXpOPKZUTRi87OnUFmHkucpNL4+w71tMb15E7DucKpNx7ioBc3euf8zzcpA/Uu9/xy17IvzUiTmn9YM6ePY7x4+w2+bu8X/q9Mc7Kkk3y/zyK2KcPmCPm1TBVEYTGQwhRA9SY1aOhEeI4k0Hv0Lfk1Zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 03:42:53 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 03:42:52 +0000
Message-ID: <82fa6702-73f7-8851-4d4b-2e2466c67764@amd.com>
Date: Tue, 20 Sep 2022 09:12:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V2 1/7] drm/amd/pm: add support for 3794 pptable for
 SMU13.0.0
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220919020251.7048-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220919020251.7048-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DM6PR12MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a05a4d-42f2-4e99-9660-08da9aba322f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSJtKnu3/V3qjZP1bK0XhY9PE+/aHi+cYzAopU2FF/16iV/VoD/hjStQdCwdVC1/AEw0FvNDy78SI+5O9i6NBH2WZjL4WvQNCaByizLND8Eo7fjlB6x9wU+TLHCfP7CQ7kIgT1u3HyCS9v44DxZaX+3oGPwawill4nSRMNHIZC75q390PAQhRwxDJaTs0EXoI4rgBWFb/XwAOhXYQFMsFbGvrrkVM410i1GO2/GQa3mcHXtDLkOwBdwKV/DApriWkOnRu5uC54jYq0pGN9eSCP3mEAphLKSw+gC+Dtu3+vCFn1N22WFcYol4A+8BLbk+D6msWgsE0jm/E8jQw5+zjYuMxlTuyLRyCieoq0ml9wQt1AgxaiU9USsQufCOSaneMNyhmM/DS+2O/FMktgMlw3I6p1V5oTGQIgmqyz+8toYSsIBnJCw3dNQv8su9POX6Imrnzu6OqjlKi14Nw1Y5xI07Grm5durRqguA9HYBYpNrKz+045oTSf9bw6rQtihMKALu153Ll3FUzduZcxKKP1FjeWsyeRyNO3LQ+2DJ9EK+rMJIL3DklszAolsLT/Ns3IQAKt1AKIVeTdLVjI3qcH4l6rEeZ/mJX2x/lDVAir2xn1wruwj2nIT9iFQmMT73MbGiR4KFT4XpbtdgTbf2v9Afb/bItCW259A3P22NeX/a2BeWpt6B1hYpN7ZVIePluGiHMQ3rFwgYTM4cmikod4R34v2K8tAEzygpgWovVxeXf+7rqYtZsnbO47DgySICv9yDwHSiCz4Nxr6GHOehNmKDw9bemDlS398qSHVWZRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199015)(31686004)(36756003)(4744005)(2906002)(316002)(38100700002)(4326008)(8676002)(66556008)(5660300002)(66946007)(66476007)(31696002)(86362001)(186003)(478600001)(2616005)(6512007)(26005)(53546011)(6666004)(8936002)(6506007)(6486002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDBRS0RDWFdPTTFWOTVhaEdtKzFzZXdPOU1qcEpSYTFSUCtMRVAzajUzZklh?=
 =?utf-8?B?YndVdDdpa2lMZStPeWpJenBIMVMzR2ZJL0RMMWZrQjNoM0oySjRsWi9ybG0r?=
 =?utf-8?B?N2J6d2tPaE1DNUY0V0FhSVNpM3hHNUkrVGcwdTRkKzlQR3V6VDUyZlpWN2tt?=
 =?utf-8?B?VDNhblFESEhHeTl1dHFYTzJwc1RwZWNOV3U5TmtmUUlOSUw2NnIvWVJkTXI4?=
 =?utf-8?B?RTZCSzdVWUFGdk1paE5xTy9CYmlRR2FkcytsNWtBaFVKOEg0WEY3alRhZUtw?=
 =?utf-8?B?RENseEJhdGUvQ21wdHE2Qnl4TjBMV2NjS0ZSNUh2azE4NWREc0ZZeDNQalMr?=
 =?utf-8?B?NGRXRUU4ckZLTHNQMzhZWlRoS0JlY3NJci9xa1V3K1FBTFhwKy81VFBiR2NU?=
 =?utf-8?B?ejlKSHFFMWxJZFRDVjFEZWhGc2dRaE5UWVpERDJGT2M5a3R3Mithd3RIRFFi?=
 =?utf-8?B?NGt6R2VNKzY0ZUg2dG52WFhKSUJjaWJCZndVWnFHUXhET0JoYXBXdXNMN0NQ?=
 =?utf-8?B?dHBrV3I0MGloNTMvVWZvdDk3REg2aFFvbENhM000bEpaM25nakxvTVg2QUFP?=
 =?utf-8?B?dVU4aEMyYnp5d1BBOXRwWE5ESDRJdEtvTDdvOUFGSG9NZE5mZzBkRzFybm1G?=
 =?utf-8?B?MFNLMjRsRUxhcWU1VW1WNDRBUmVSbzUySkVXc1RHTnh4SmErOUpuc1BraEdN?=
 =?utf-8?B?Wk5WNXpjNlM0UmYwMTdkWVRUZXpHVVE2ZW43bFhFRHJLSGRrVkJvVFNpdHpj?=
 =?utf-8?B?UGtpbjNLdXQ0QnFUSGoxcXFYOWxEQnM3OUt2VnlRUU5IcXczTjg0TzRaZDF5?=
 =?utf-8?B?OURCSG9pMTZaYTBJZTEzWkRFNTV5NHhqVy96WTVMakg0VWFIcUE1U0xkZ04r?=
 =?utf-8?B?R203dVdPVk5EeGo3MW9YWjQrNzRXekhYTUJVT2x1ZzRxTTNJU0ovdW1CcnhM?=
 =?utf-8?B?aXM1QTBXWVNmekYrclFuUENRVFdiaXhLeENNZnYrWFBoWGZXK21MOXRvV0c1?=
 =?utf-8?B?bngzMW1kZnhKTkV5K3E0V3Rrb1ZWTFBCYzZaRVZ3bWMyN1pCWU9rOG9vY2Rx?=
 =?utf-8?B?ZDNvbWEzQjZaWWh6MWlnTkhVcmVqUzhHYWpKU2IzQTk2OW9ZdzdscUx1TnJ0?=
 =?utf-8?B?dnk1eERvVjBxZW9ickF2Y2FwT0ZDWTdSNUMwRFhSeTVsS3lCNkwxMFJ5RW1L?=
 =?utf-8?B?VlJkYlFuWFlNYkJQQmM3TTdEc3FKYi85ZkIyWDJHMFVCOUMreTJuYjhpOVc5?=
 =?utf-8?B?QjBRZGFSWmpRcEVwYk5rb05rNnJlMm43ZVBTOUZaN1dYNU1DRU9PdnRLMTNu?=
 =?utf-8?B?bTlpZEhDdnYraFl2S1hiZ0pvQjlSclhjMFNCK1FYTFRObkVzcHZTem9Cd3Nv?=
 =?utf-8?B?aE1ndnV3ZFkvY3g1RklOMnd1aWJJRUtGNERMcmN2dmR5NmRDTzBIZ21idERJ?=
 =?utf-8?B?UGFiZmRWNGl4Y2h1d0FuRTl5cE43Ymo3SG8zQ0RVQitjMFVqQlJpSmJHdTh6?=
 =?utf-8?B?cHFXWERGUGZYQWRrNEdNaUdjU3dlTlBqOVQraEk1ZFdVZC9najIxT0tNcGhq?=
 =?utf-8?B?L3lKb0pPZjFhdEltZ2VlRDJJZEFkNS9YOG5kYVhlVzI4ZjZwVGhXNi8rUG5S?=
 =?utf-8?B?WFVEZm5wNFpIQkJXYlNoWEtmeEtMak9uRmRkdit1UnZrOTNwVURRcS9qZHBh?=
 =?utf-8?B?bjBMbWN5Y3RqQzZpR1ZhL0p2Rm5tMVVXellNdlNlc2xuS1BWQ2lwNUY5NXpZ?=
 =?utf-8?B?amhuWEd1WGwyYTRLNW5oTXE1VlEvb2d1WFZOaENYM0YrZkVkRHVrUjBSSU9B?=
 =?utf-8?B?ZStiWXVKUjg3OHZYZGdEY1lubGYrZlpIbkhzRW9NRkdqU2IvSFhLTG84TC95?=
 =?utf-8?B?SHhmUElaY0VydmlhSTQ1aUZyUlVoSm9QRzdTZVVOMlc3NGFuL0dva1R1SHZZ?=
 =?utf-8?B?cWNXQVBpRHQ2S284V1cycDRjRDFPVTJpTloydUtMMkROd04vUm0wem4xS1g0?=
 =?utf-8?B?TFNoTWJ5cUZlYTVOY3U2UkNOUkdvZ3Q0OXFWQXpQVzlEL0dhZFY3TW1GZFhQ?=
 =?utf-8?B?ckZKOTIxeTZtNU5LUVlORFNLTlVWR1o1N1g1aHJqZUxRQVJTaGZldVNBTEwx?=
 =?utf-8?Q?mjF3EDc9FHCj4bECasY9z9VJ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a05a4d-42f2-4e99-9660-08da9aba322f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 03:42:52.7139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dc0MzLfRCmpJoWlc2gO6fHLq2zFBCjW8KhSCRDRLHDHWaoZdkPpcDOhKZX+igdWu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: Alexander.Deucher@amd.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/19/2022 7:32 AM, Evan Quan wrote:
> Enable 3794 pptable support for SMU13.0.0.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: Ia208531c9eb96611b6136975bcbd8d27007b9e14
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index de779f8089d3..a6b7319fbfe6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -406,6 +406,7 @@ static int smu_v13_0_0_setup_pptable(struct smu_context *smu)
>   			case 3664:
>   			case 3715:
>   			case 3795:
> +			case 3794:
>   				pptable_id = 0;
>   				break;
>   			case 3683:
> 
