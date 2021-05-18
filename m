Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C2C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFE16108C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE16108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE0DC6EB6C;
	Tue, 18 May 2021 13:17:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B0F6EB6C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGAWodv9tkdGGO5Eu+GFglhSAfrgYpDyPvQcliZ9Xz9kN9KlOht+pH3/muWKV4Sr871ajRNJ48CKJGu1u9muEvGGHa3Fm/RdjHddD9coljLNFtEjLk2U5gCFC3C0MSsqT+CpiqJNx8zlxCJUuGbAIyNRxV0vywsfDvjGgCiN3muO4PNnArU4vuFlEi0qCw362lIlLPXLncpnNOmJ4tDbOSuZyZ+d2Tz+9KvTcAovZ9581g8whkXfTw/b1Nt7ez5iNWRusXdO2DwpYXVYmDIdaPG9AYz8wT0tYePemtaYXJ30qkIMAOoMxqSlvrIvp8AMet5WSQSDYOzHmJMn7ZzV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+qNfPutORVCxgKlGRI4GI7m8FYSzCOQ1WWLlY7Xg6k=;
 b=DdPXAJf9eh4a5z9Efff6JJMDli0PTPWH5KoQbHChG1HEv5DX3vZEGjpAE7CFy46Bk/syC5rYWOKVVxPN8MSFgjToLLteuYyNYsDMxPuUHX7jEN0E96RiOGTorz2iIaUHy6aXzm3Ltd5WIV6UvNO/Z1sv4zXWSioc5u8u6fbbj15EyKIQGgSwHKwxpnCTgjXPlukT2/LGYtJ4CpetlbW2vdUPu0sb7d5OBpqqVC73Rz5QxUipYL9I00Hnori5jPboP35J4bx9PuAyheu+N9apSZ2SH/kwlGwjo2MxbpP+iIs/YLth53kefyfhv7gt8jxjaamwyExCN9ZVc9zH/K+fPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+qNfPutORVCxgKlGRI4GI7m8FYSzCOQ1WWLlY7Xg6k=;
 b=rc8FQ9OWaxkoJtxSuzpForuy5d7ebL36iUFsuBCm+iRS4aO4i6W63gEBjY21GleoSRbO3nLj2IuxWZsApdlyewM1R/qPvwnYYh+0K3jv66geQpIVx1f9p1uQTdS5yeQ54+BEVIuR8PCtdEGLOlDB+FK5HHhCbKcLqBSq7IXJ6lg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2545.namprd12.prod.outlook.com (2603:10b6:207:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 13:17:08 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 13:17:08 +0000
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Nieto, David M" <David.Nieto@amd.com>, "maraeo@gmail.com"
 <maraeo@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210518121628.9811-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1ec97d1f-aaa3-46c1-b702-378879e67cc5@amd.com>
Date: Tue, 18 May 2021 15:17:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:8470:36a5:2010:f0c4]
X-ClientProxiedBy: PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::30) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:8470:36a5:2010:f0c4]
 (2a02:908:1252:fb60:8470:36a5:2010:f0c4) by
 PR0P264CA0234.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 13:17:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1fd31f6-7231-4903-0899-08d919ff3cec
X-MS-TrafficTypeDiagnostic: BL0PR12MB2545:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB25457487614C5DB68186B1A7832C9@BL0PR12MB2545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g43izZjBNUiGyA6oTQYw8jkM8tH4K242BbNP2WH19Ph8NBSmbwPaO9bf/14A5e0hoRv3t6rpsizTv5hJwqHzLoj7dWwneTOr0ZHyIAcdGAzLQ1ipudrehGxE7irwPnre3j1rI64nxiGKaLH/IJBWivqNwhZd7JmfXiDDTo32hU9E3P4hQrMb3asrmTKYxjH9FarmXiP9pQWIpytMTpa0hWimFh8Zz1JqwaEajZVA2F4tCt8JNb1dwtgsH/MiAcd3qpbiPvy6RrHtpvGN5zqOS9Y+NqSBpjr3ZYzFDHZQALdT4vs8gCYhRGiFlsOcmi0csmOD3Qvbv7xCFWpr3z7W2Yuhk2QZiToVC3KOIONkohZF9xAERkKf+rlACjz2kqK9zYr12O6EOP+jnjr8zmVcV4FExyJAycXUVW9KdU4J5GH+9yrpBBbTmCRsggZegyQJIX+00v5fHwfkFoEaolSayIEXOhGkWOCkjiISWMG0oFrOAW5wN4EPz6G1Kcx3bcLm16Taf+cDB7lEJXbWisSwVyjTkekqUWwqJxjboUemqna3l9nI+xgWmxX462hMOwoRzqBDQFvlFNmQnVYtQEFTKLHg5FWTwN4DzgqoiVM0F8ylPD4SNU3vM0NyZIyKPNZAZtkvPMFECsnmTMR9Hbkj4i8Pz0TqlG1pk2KNITEsjnYgJktjkml2djnKNfRlHWAd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(186003)(8676002)(2616005)(16526019)(52116002)(53546011)(5660300002)(110136005)(86362001)(83380400001)(66946007)(30864003)(316002)(8936002)(31696002)(66476007)(36756003)(31686004)(4326008)(6636002)(66556008)(6666004)(38100700002)(478600001)(2906002)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1hEcU5MMEpXdngzZ3RqTGZNNHpYZFFmK2Q2UHo0TmIxbG9LQ2hJcllXMFVH?=
 =?utf-8?B?WHNMVGt6SG5PN2NJZnR2TGl4dkpmQnRlbWJQV3Y4TXBPd3kxZEJtd2VCU1l6?=
 =?utf-8?B?TVhjaW9TMmZhNjV1VWI4SXZ3cFpzdWlGL3FuZ3B4c0phbW5BNUJXTlNJYk5T?=
 =?utf-8?B?SEFacWwyN0J0NXFtNUpTM3hiK3A4NzUxeURjSHh2dGhRdEYwZDNmcmRrMlR3?=
 =?utf-8?B?TkRTQTJjZ05nQXl4eGxIa0czRW1YUnhLaXpvY3JUYXpXWUtiK1l2V3RieXg2?=
 =?utf-8?B?bDhKUG5GNERxQlUvMXo4Qmczb29lRG5GRStocWphMjVIR0k4RmNMODNtOGYz?=
 =?utf-8?B?c2ZzMGdnTHkwbGlOZ1lVcFE1WDN2WWdaQ0U0S2RYMGplRnRrVWNuTjVVWDMx?=
 =?utf-8?B?aXUyeTZ3T0NRNVNCcE16NWlVZEVQWUhsQ1V5aWF3L3E0ME9HYzB6OTgzZ3p5?=
 =?utf-8?B?aG9XNHRwSWQrbHppNStrNWlWekpQcytidGVVTEY4a0kwbng3QzlvbXhKdUFi?=
 =?utf-8?B?SWdIcVZoQkR1OGk2VkxoRWt5STVtaU1jMUpxVENzc3UzQ3R0am05ZVZZYlM5?=
 =?utf-8?B?c0NNV0lpY3hjcVNUMFdxNEhoNEFZcUdJUnl5d2xDRklYS05DNG5DUk1meENv?=
 =?utf-8?B?VVVVQldZZ2EzZmlsMUhLWDV5VHZldzVIMEJZZDRVM3E1VzhleHpPdmZUaTY0?=
 =?utf-8?B?dEtWSXVHREF6T3laS09Yc1UvQ2xOWnBsWWkxNXUwVjdHbGlia1hrdHFsZTVj?=
 =?utf-8?B?eTJiTzRMNExJU2M0ZmZNdGJ4c0lYV0JVaUNObk45ekZkZkdla25WNUZjRUpP?=
 =?utf-8?B?a0ozTi9yZGlIcFFoZGd0TmpvaExBNGJWWFc3YS9TRmhxaUJ4VTlOMDkxc0FP?=
 =?utf-8?B?Ty9ja0dOY3RxcTZDcnpvWEFmdXpvendlbjdtb09jcjVnNWxpdCtLQm14endQ?=
 =?utf-8?B?WTRZM25CVkdLY2lhUHVncmRqNFhPR1VtUXR5Z3grMlFHMHBCWTZaeGVnanNt?=
 =?utf-8?B?MXBDZUNlbndFOVNoeFZ0eThVNkI0elE2RnlpWC9nQ1lBT1pLcEl0SUwycXhi?=
 =?utf-8?B?R3VLdmozTWlSQWZxdWlJV1FzUFJqOU1heWlVci93SXduQjhjSlNkMTBYcFpP?=
 =?utf-8?B?anQ1ckFSTUY0ZFNFdFQyaSt3T2VObDgzQU9zSnAra3N4c0p6MDlkRzhvQlRk?=
 =?utf-8?B?SURrSkxKWU9QMldjZ2J2d1NET1o1aW1DRGNWSWljWkw4elpYbnFTam5kcmhY?=
 =?utf-8?B?R2JxMTczcFZNaUNGdzcyVzRKNm00TDdIVkFuOGVQU2NWUW5PZG1NM3FBS2dL?=
 =?utf-8?B?L1QyN1RZZkNneTlsd2VVRU41RW15elVrQm1NZWRtTkovaG5zNEZaU0NWSjRk?=
 =?utf-8?B?ZzlCV0pDdFJ0cGhCRGhENFEvVlJVSUNGZ3Y5SGN2SzJ0TXZ2OXUzdHNYcW5m?=
 =?utf-8?B?MjJleVRXSnh4NXNYcjBhNFY2QVY0dGFVOWs0NUpmRXYvaFJvNHRJRXhOSWFn?=
 =?utf-8?B?MzIyQ3hIQVYxSHdYVk5DM2V4Zk5SbFFodVd5NnV4WmJGU3IraDJoNUpXcENJ?=
 =?utf-8?B?UDE3YkducTBaTUh1R2ZmU21EcVZUMnAwTTI2QnFGSkpOSmowamN5b3Exei9W?=
 =?utf-8?B?Q0ErRmY3dU5zVlk0eTVUKzhtNStlRXd3Z0NnNHNlb2xTN2V2Umw4WFdBc2x0?=
 =?utf-8?B?RGkwZlBoWDR3OU45T1lDc1ovdlU1LzNiRTFESGlYL0xmcXNWUTlMNGEwampW?=
 =?utf-8?B?Y1M1WTNZQWdtSjA3UnYxTEJHUmMrcXhkZGd1Qk4xZkV6MTMyQ2N1aHhKbTRo?=
 =?utf-8?B?d1c1ZE53TXBjamhwQkZqVWtIMTg2eUEyckxrdmNQMmNDTnh0MFhrelRBVUlu?=
 =?utf-8?Q?280eDhrS9mArP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fd31f6-7231-4903-0899-08d919ff3cec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 13:17:08.0711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDAG/BfVix3DyZhqi9eKF0GTTV4rIO7JNTrW1869HAplp7qMWyquIlW9kPQBP9jG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2545
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well not an expert on that stuff, but looks like that should work for me.

Question is can you provide a patch to use that information in Mesa as 
well? Umr might be sufficient as well as justification for upstreaming, 
but I want to be better save than sorry.

Unless Marek has a better idea maybe add the vbios version to the string 
returned by GLX_MESA_query_renderer or something like that.

Thanks,
Christian.

Am 18.05.21 um 14:19 schrieb Gu, JiaWei (Will):
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi all,
>
> Please help confirm that we're all fine with this new struct in uapi in this V3 patch:
>
> +struct drm_amdgpu_info_vbios {
> +	__u8 name[64];
> +	__u8 vbios_pn[64];
> +	__u32 version;
> +	__u8 vbios_ver_str[32];
> +	__u8 date[32];
> +};
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Jiawei Gu <Jiawei.Gu@amd.com>
> Sent: Tuesday, May 18, 2021 8:16 PM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>
> Provides a way for the user application to get the VBIOS information without having to parse the binary.
> It is useful for the user to be able to display in a simple way the VBIOS version in their system if they happen to encounter an issue.
>
> V2:
> Use numeric serial.
> Parse and expose vbios version string.
>
> V3:
> Remove redundant data in drm_amdgpu_info_vbios struct.
>
> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
>   drivers/gpu/drm/amd/amdgpu/atom.c          | 172 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
>   drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
>   include/uapi/drm/amdgpu_drm.h              |  10 ++
>   5 files changed, 212 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8d12e474745a..524e4fe5efe8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>   					    min((size_t)size, (size_t)(bios_size - bios_offset)))
>   					? -EFAULT : 0;
>   		}
> +		case AMDGPU_INFO_VBIOS_INFO: {
> +			struct drm_amdgpu_info_vbios vbios_info = {};
> +			struct atom_context *atom_context;
> +
> +			atom_context = adev->mode_info.atom_context;
> +			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
> +			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
> +			vbios_info.version = atom_context->version;
> +			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
> +						sizeof(atom_context->vbios_ver_str));
> +			memcpy(vbios_info.date, atom_context->date,
> +sizeof(atom_context->date));
> +
> +			return copy_to_user(out, &vbios_info,
> +						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
> +		}
>   		default:
>   			DRM_DEBUG_KMS("Invalid request %d\n",
>   					info->vbios_info.type);
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 3dcb8b32f48b..6fa2229b7229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -31,6 +31,7 @@
>   
>   #define ATOM_DEBUG
>   
> +#include "atomfirmware.h"
>   #include "atom.h"
>   #include "atom-names.h"
>   #include "atom-bits.h"
> @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context *ctx, int base)
>   	}
>   }
>   
> +static void atom_get_vbios_name(struct atom_context *ctx) {
> +	unsigned char *p_rom;
> +	unsigned char str_num;
> +	unsigned short off_to_vbios_str;
> +	unsigned char *c_ptr;
> +	int name_size;
> +	int i;
> +
> +	const char *na = "--N/A--";
> +	char *back;
> +
> +	p_rom = ctx->bios;
> +
> +	str_num = *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> +	if (str_num != 0) {
> +		off_to_vbios_str =
> +			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +		c_ptr = (unsigned char *)(p_rom + off_to_vbios_str);
> +	} else {
> +		/* do not know where to find name */
> +		memcpy(ctx->name, na, 7);
> +		ctx->name[7] = 0;
> +		return;
> +	}
> +
> +	/*
> +	 * skip the atombios strings, usually 4
> +	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> +	 */
> +	for (i = 0; i < str_num; i++) {
> +		while (*c_ptr != 0)
> +			c_ptr++;
> +		c_ptr++;
> +	}
> +
> +	/* skip the following 2 chars: 0x0D 0x0A */
> +	c_ptr += 2;
> +
> +	name_size = strnlen(c_ptr, STRLEN_LONG - 1);
> +	memcpy(ctx->name, c_ptr, name_size);
> +	back = ctx->name + name_size;
> +	while ((*--back) == ' ')
> +		;
> +	*(back + 1) = '\0';
> +}
> +
> +static void atom_get_vbios_date(struct atom_context *ctx) {
> +	unsigned char *p_rom;
> +	unsigned char *date_in_rom;
> +
> +	p_rom = ctx->bios;
> +
> +	date_in_rom = p_rom + OFFSET_TO_VBIOS_DATE;
> +
> +	ctx->date[0] = '2';
> +	ctx->date[1] = '0';
> +	ctx->date[2] = date_in_rom[6];
> +	ctx->date[3] = date_in_rom[7];
> +	ctx->date[4] = '/';
> +	ctx->date[5] = date_in_rom[0];
> +	ctx->date[6] = date_in_rom[1];
> +	ctx->date[7] = '/';
> +	ctx->date[8] = date_in_rom[3];
> +	ctx->date[9] = date_in_rom[4];
> +	ctx->date[10] = ' ';
> +	ctx->date[11] = date_in_rom[9];
> +	ctx->date[12] = date_in_rom[10];
> +	ctx->date[13] = date_in_rom[11];
> +	ctx->date[14] = date_in_rom[12];
> +	ctx->date[15] = date_in_rom[13];
> +	ctx->date[16] = '\0';
> +}
> +
> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, char *str, int start,
> +					   int end, int maxlen)
> +{
> +	unsigned long str_off;
> +	unsigned char *p_rom;
> +	unsigned short str_len;
> +
> +	str_off = 0;
> +	str_len = strnlen(str, maxlen);
> +	p_rom = ctx->bios;
> +
> +	for (; start <= end; ++start) {
> +		for (str_off = 0; str_off < str_len; ++str_off) {
> +			if (str[str_off] != *(p_rom + start + str_off))
> +				break;
> +		}
> +
> +		if (str_off == str_len || str[str_off] == 0)
> +			return p_rom + start;
> +	}
> +	return NULL;
> +}
> +
> +static void atom_get_vbios_pn(struct atom_context *ctx) {
> +	unsigned char *p_rom;
> +	unsigned short off_to_vbios_str;
> +	unsigned char *vbios_str;
> +	int count;
> +
> +	off_to_vbios_str = 0;
> +	p_rom = ctx->bios;
> +
> +	if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) != 0) {
> +		off_to_vbios_str =
> +			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> +
> +		vbios_str = (unsigned char *)(p_rom + off_to_vbios_str);
> +	} else {
> +		vbios_str = p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> +	}
> +
> +	if (*vbios_str == 0) {
> +		vbios_str = atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);
> +		if (vbios_str == NULL)
> +			vbios_str += sizeof(BIOS_ATOM_PREFIX) - 1;
> +	}
> +	if (vbios_str != NULL && *vbios_str == 0)
> +		vbios_str++;
> +
> +	if (vbios_str != NULL) {
> +		count = 0;
> +		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >= ' ' &&
> +		       vbios_str[count] <= 'z') {
> +			ctx->vbios_pn[count] = vbios_str[count];
> +			count++;
> +		}
> +
> +		ctx->vbios_pn[count] = 0;
> +	}
> +}
> +
> +static void atom_get_vbios_version(struct atom_context *ctx) {
> +	unsigned char *vbios_ver;
> +
> +	/* find anchor ATOMBIOSBK-AMD */
> +	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
> +	if (vbios_ver != NULL) {
> +		/* skip ATOMBIOSBK-AMD VER */
> +		vbios_ver += 18;
> +		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> +	} else {
> +		ctx->vbios_ver_str[0] = '\0';
> +	}
> +}
> +
>   struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)  {
>   	int base;
>   	struct atom_context *ctx =
>   	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>   	char *str;
> +	struct _ATOM_ROM_HEADER *atom_rom_header;
> +	struct _ATOM_MASTER_DATA_TABLE *master_table;
> +	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>   	u16 idx;
>   
>   	if (!ctx)
> @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
>   		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
>   	}
>   
> +	atom_rom_header = (struct _ATOM_ROM_HEADER *)CSTR(base);
> +	if (atom_rom_header->usMasterDataTableOffset != 0) {
> +		master_table = (struct _ATOM_MASTER_DATA_TABLE *)
> +				CSTR(atom_rom_header->usMasterDataTableOffset);
> +		if (master_table->ListOfDataTables.FirmwareInfo != 0) {
> +			atom_fw_info = (struct _ATOM_FIRMWARE_INFO *)
> +					CSTR(master_table->ListOfDataTables.FirmwareInfo);
> +			ctx->version = atom_fw_info->ulFirmwareRevision;
> +		}
> +	}
> +
> +	atom_get_vbios_name(ctx);
> +	atom_get_vbios_pn(ctx);
> +	atom_get_vbios_date(ctx);
> +	atom_get_vbios_version(ctx);
>   
>   	return ctx;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
> index d279759cab47..0c1839824520 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -112,6 +112,10 @@ struct drm_device;
>   #define ATOM_IO_SYSIO		2
>   #define ATOM_IO_IIO		0x80
>   
> +#define STRLEN_NORMAL		32
> +#define STRLEN_LONG		64
> +#define STRLEN_VERYLONG		254
> +
>   struct card_info {
>   	struct drm_device *dev;
>   	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  filled by driver */
> @@ -140,6 +144,12 @@ struct atom_context {
>   	uint32_t *scratch;
>   	int scratch_size_bytes;
>   	char vbios_version[20];
> +
> +	uint8_t name[STRLEN_LONG];
> +	uint8_t vbios_pn[STRLEN_LONG];
> +	uint32_t version;
> +	uint8_t vbios_ver_str[STRLEN_NORMAL];
> +	uint8_t date[STRLEN_NORMAL];
>   };
>   
>   extern int amdgpu_atom_debug;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 275468e4be60..28deecc2f990 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
>     DP_VS_LEVEL0_PREEMPH_LEVEL3 = 0x18,
>   };
>   
> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> +#define BIOS_STRING_LENGTH 43
>   
>   /*
>   enum atom_string_def{
> @@ -215,6 +218,8 @@ enum atombios_image_offset{
>     MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      = 20,  /*including the terminator 0x0!*/
>     OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   = 0x2f,
>     OFFSET_TO_GET_ATOMBIOS_STRING_START        = 0x6e,
> +  OFFSET_TO_VBIOS_PART_NUMBER                = 0x80,
> +  OFFSET_TO_VBIOS_DATE                       = 0x50,
>   };
>   
>   /****************************************************************************
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..155fd9918b4d 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
>   	#define AMDGPU_INFO_VBIOS_SIZE		0x1
>   	/* Subquery id: Query vbios image */
>   	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
> +	/* Subquery id: Query vbios info */
> +	#define AMDGPU_INFO_VBIOS_INFO		0x3
>   /* Query UVD handles */
>   #define AMDGPU_INFO_NUM_HANDLES			0x1C
>   /* Query sensor related information */
> @@ -949,6 +951,14 @@ struct drm_amdgpu_info_firmware {
>   	__u32 feature;
>   };
>   
> +struct drm_amdgpu_info_vbios {
> +	__u8 name[64];
> +	__u8 vbios_pn[64];
> +	__u32 version;
> +	__u8 vbios_ver_str[32];
> +	__u8 date[32];
> +};
> +
>   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>   #define AMDGPU_VRAM_TYPE_GDDR1 1
>   #define AMDGPU_VRAM_TYPE_DDR2  2
> --
> 2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
