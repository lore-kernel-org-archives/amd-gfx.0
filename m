Return-Path: <SRS0=y+Th=FL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B1C4361B
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD662311A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Dec 2020 20:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD662311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D39336E8B5;
	Mon,  7 Dec 2020 20:21:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918686E8B4
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Dec 2020 20:21:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xwq5chvkLxbBu0lDP7ZI85nZsJkUYkhjZt11M4ZHLcyybrcRSg4EvTuHZ6M6fBNSFWk+kwNMRnys+/hffNN3jK4WNPjA2QIiV8nyEj+gdCb89UkdOXxRVYdtCqoC8KGfdcd6f72iqUxVzeuy2IqgwF3uqT+VRa20ImpWyfgSPb3EdF/3BJgSThotJ3UpPBQRdTar33VNn3guMlPGC2s4bQOFhkQP8CuJsgaDX5VHfZA/pJkJD1tde9IPPU31fV2pIjOMAHSVzgt1QZs5r9TgPZpZozC5JpTRynr6MT7H4rWbOS8DcDaYx8URBPHNabEQoQ7FPpOLWjSsrOWeKEenSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhPw57G1lT3P/uy2g/hEO2RZC+ujvfl4pAPjdpDNixM=;
 b=n5hhtLr5lxaG3/HXQJ9o8lQi3LJXmJtKp1YIV4BSbbzDtCucs9otO8MFeKmwbzGmXct9KwkD3sx56PnFQGziu7q3h7kxAoyLsN8W9sh43OX1dVoeyDTPCNkCVpDI27u/yQ5y9gak+PsyIyBh+B18G+UcxOIALLvFHMj39QmwGsaTExTnQc4PTXdDxcjn5COrM4/OHzIzHj9luvZTp/JSio4ks+ivvglEJtcPU1NOTiusUJTscrYAYwH5bk8WMoNJc+BLZj1AIC2bqy8VcF9W9sNPnbyC3Ah0YBnut+3w7CH25Lf0uWW4Uf8OT1DIf6vN4PPdrVyOn4AzlaoQInu5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhPw57G1lT3P/uy2g/hEO2RZC+ujvfl4pAPjdpDNixM=;
 b=cF1q/lY3KdwiXlU0EEHgRBpFhx65edW22aaz7xPBshulaK0fGLAMNgqodVyaQkaJVXff38KF9TwksPJ9VYXqOy7tRA/meXiCrCArGmoSGaP/kveNtpnttO635Ym0F0FfIQM/Bjyfb31bq4IIfTBOHuH8VKft9W8o4a4FoiknCIY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3333.namprd12.prod.outlook.com (2603:10b6:a03:a9::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:21:41 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.038; Mon, 7 Dec 2020
 20:21:40 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: add S/G support for Vangogh
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Charlene.Liu@amd.com, Yifan1.Zhang@amd.com
References: <20201207200302.11479-1-Roman.Li@amd.com>
 <20201207200302.11479-2-Roman.Li@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <650f7856-87b3-ffe1-9ccc-929431c0c096@amd.com>
Date: Mon, 7 Dec 2020 15:21:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <20201207200302.11479-2-Roman.Li@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR19CA0002.namprd19.prod.outlook.com
 (2603:10b6:610:4d::12) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR19CA0002.namprd19.prod.outlook.com (2603:10b6:610:4d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:21:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7d6f5841-6968-4c4f-2ba3-08d89aedb520
X-MS-TrafficTypeDiagnostic: BYAPR12MB3333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33335E18E0423270D4375C92ECCE0@BYAPR12MB3333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQTHNLiGVNHyx5XpzezpFSzqRbO7QbAPsKMEggxqHsd/9VQJRfehJLkyPBM78mtCIYWkuKyjnUrYrBix0lzoe4b326ooVFqlmTo5oozrdK4qdyMfxLTNjVSP77eebO687Tek4vkftO1iM2PWUPyNvfAW1QECOZZmfUj/eooszAwY5NfpoQZCCrSNkRgmzsHEnCsS0MFdh6/B78qOfcYxEUjzkh7JWqnOGVM+Tb6HloZaTowVO0YhmQZzhsjxZ+EdHe/VSrh4/JxVTDFu31vJbnGx//zrt/YdoSBNoWvFy+MlwnwJGXjYy6TEdMHqGWc8U7K9ULDZfq7Eyb0sR0XQWoTzE0TZO48538u2+lQ7SggCrgtF8UroPijSTlaApj2SEF/KzL6WB/QSXj4kYbgbpIj9X5zPjQVZ5qoDbBQOPJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(186003)(8676002)(8936002)(86362001)(478600001)(316002)(6666004)(16576012)(36756003)(6636002)(4744005)(66476007)(52116002)(5660300002)(31686004)(2906002)(2616005)(53546011)(956004)(26005)(31696002)(16526019)(66556008)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZGdOYVBpbXB5WU1IdWdSYzZ0Q1RtdndrZmd0V1lYQ2ozZHptZ3ZWSDUwQklr?=
 =?utf-8?B?OVhEK2lVWm44a2NtVXVHY2ZWY1hXU3Z2THJrQUY3ejFjeGJSKzVHeVQyYVNP?=
 =?utf-8?B?MjRuaUJOUXdoMTI4SEFSMGtNTVpRU3BOYk1lM0Z6aFVrT3BVdVdpVGlhcDZO?=
 =?utf-8?B?MmlZaEFtWG5ienYyQnpFVWFmQ2phTitHQ3V2cXhyN3V0NjE0SUtyb3pEZjRq?=
 =?utf-8?B?Z3VzOGlqd0lHVi9wM0ZQbW9LamRxNHU3Z05pWEZFcVhMeVMwVUwrZ0tlR1pD?=
 =?utf-8?B?R0N3akJZUS8zSjNEZm1jMStsdTNBOVBFWHp4K3JWYjJ5TFFiQ2tmTHN3SitW?=
 =?utf-8?B?dGFyNk1neTZGOEhkMkFGVlRQRFJMUHBkOE5rQVJWQ21zVW0raEtVUnRIUysz?=
 =?utf-8?B?QnlQeVJERm4vc2JYSTJuWEhtZDZxMW9GRWsrQlROeEk1YWVHcU1Nb1NpUy90?=
 =?utf-8?B?SFVpZ2pMYm5BMzBwQjNoalpZVmU0OUZLY0VyNlJGQlhsb1ZNWlpzUXduSWcw?=
 =?utf-8?B?MVlueENuVGFSbHZLS1ZFMWZxbTBNRmJsaDU3eGcxZnVQR1h6Mm95SGIrWHRB?=
 =?utf-8?B?TWh5U2JxK0JWQzZldmZBdFNETVY4MVNRQUpNaExFZ2hUdEJ1ZjJrZ1gzMC9B?=
 =?utf-8?B?VFZ5djFVcThIbmlTSkIxT0ZCOHQ3d2txL2JxTk9JNWd0RXVpUEF1UkVrZlRw?=
 =?utf-8?B?ck1xSE44YWo2dWtlOHBBa1Z3eUVleVNCeGFobTFmVWh3SitPZzhZWGI0bzdy?=
 =?utf-8?B?WEY4dHRUWndLc1JzMG5uYlV5ekFLLzBtVVExTW0wOVBGQjlqUms3UTJCT2lN?=
 =?utf-8?B?aHFmQitOM3E1TGhWS0MvWHdVdkREbnZQSHJabmJBSEhSNERyWUJzdERETklB?=
 =?utf-8?B?bEJTVVlBdTJPOVgrdmlqUzhvc0duYzVvRE9Fa0UzRVMzMDRYSDFDNGI0YXo2?=
 =?utf-8?B?bG9udXNhTVkxNWJXU083NWZLRzNabnk2dUNpcFI2RnQvQ1RyY0h2Rkw0THRM?=
 =?utf-8?B?VW5xMlJZMWQyZFEvN0pGLzNtMks4aVV3RTJiY2RaNWE0TzU4dGtaMTR0WlZ5?=
 =?utf-8?B?RmlnWXg3ZGExWkR2MVF2OXFlOFY1dmtpYlZtSnpCM2NJVGpNUUMxdjQrNVRU?=
 =?utf-8?B?dmRYdzYvZmlJZ1hzNVZxalJCcm4vZndZTU5zRGhNUHZJc3A3L05jb2gwc3hy?=
 =?utf-8?B?NjFDSFhCZTlsTmZ4Vm82Nm5tRFlUWWZWdllIbEhFR2FrWWlRV245bitySkxr?=
 =?utf-8?B?WHZ0dDVvVnptS01UZE01SUVyUXB0UlJ6VUpIUFlSdHAydVRLWkY5NmM2QnFZ?=
 =?utf-8?Q?QAaFtnvAS350YKTg+oWOQiMxd+ob2Fno+P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 20:21:40.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6f5841-6968-4c4f-2ba3-08d89aedb520
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQFpd/U9zoJL272sZm92CXmce1zqm3B/J8+mks43U1jB9o+pcM89up31wHO5VTM3+JygEecflFdjiM0SpJvlpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3333
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

On 2020-12-07 3:03 p.m., Roman.Li@amd.com wrote:
> From: Roman Li <roman.li@amd.com>
> 
> [Why]
> Scatter/gather feature is supported on Vangogh.
> 
> [How]
> Add GTT domain support for Vangogh to enable
> display buffers in system memory.
> 
> Signed-off-by: Roman Li <roman.li@amd.com>

Series is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 63401bc8f37b..a638709e9c92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -526,6 +526,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>   				domain |= AMDGPU_GEM_DOMAIN_GTT;
>   			break;
>   		case CHIP_RENOIR:
> +		case CHIP_VANGOGH:
>   			domain |= AMDGPU_GEM_DOMAIN_GTT;
>   			break;
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
