Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF5C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CB661108
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 14:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0CB661108
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8176F6EA48;
	Wed, 13 Oct 2021 14:53:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4A86E9FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 14:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQfb7CZnLmr3wcDP8OBIwb6WD7Ang9iFl2sseODXjmEVNmJeFOqCR6XO1Y63Jxgy85gMa7J/ACmRgSbMXarjMktDZDmYn/nkmp2YfJSyoh5+xEgXSYTcOh1yhmNn2CjnF1xKhRr9vm1CPKu3MhMNRwWVIhAaR8EY/DlOBvqXGchwnVIf0y//lhDgotM+HBt5OKMpo16MYgtYXUiiFGS3gHBUPLiP3DDVKcewjJ5zxc2DgPzooQAsKQWdVzgcwWdutUaEVtbbl9x4VjGzW6ReNS14CFyFWL45qafP5Nwy7JfhT6iErb0CXjzyg7Yh8V0CQuZ7JZw00bbWNuQfcCP9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olsrjwOPR7dp7ROwsTKRn6/lyajSZJR3g5Y++oXHb0A=;
 b=K74XeJ/8Z27ZK6VBzGiyOTGF3PX1cULj0D4dkU01DAnwpfi5HrG0+RpMCfq/KxKziP2eNplLYiDxEXyTlyH1feoxD75X6sDHqe75zNLMeCW8iaqgLcrqBoVVbjqaFPBea0QmSBdpAhU4b7kHT2eWu1DbGREtjapxhakSuUUS5XK8BivOSxjPxNR9h9B4AZiiVonZ1t3VbUsS6nUce99++qsXSChDKU/aqQJceapc688Et4oh3H5FxrjkwOxtn13bLlJgQaLNmYsES+9zQYRD4A8fX8S/k1sX+pe6gjA2Yr+ezYM1lqXFzn/rftkK4d/tD2ior98iHv6BslAl9bdZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olsrjwOPR7dp7ROwsTKRn6/lyajSZJR3g5Y++oXHb0A=;
 b=5GnR7yDxD3lya5ugaOevTD2hryUz6Qii0i8TMTG77/W6Sd8e0dhZAZn6xDXvjKu851uHP8MRKuEtIN9kEsCZy9K169MEQWOlx2qm69brU6ktC1Y5ghfSs9+aQq0V+WXyzl4LqPI/iVEgYbJf5b10mF282w3rM7aZPAwG+dO3ZZE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2987.namprd12.prod.outlook.com (2603:10b6:5:3b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Wed, 13 Oct
 2021 14:53:15 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 14:53:15 +0000
Message-ID: <9d1f5166-e72b-2f24-7194-131af3ae851c@amd.com>
Date: Wed, 13 Oct 2021 10:53:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/5] drm/amd/pm: Slight function rename
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <20211013031042.53540-2-luben.tuikov@amd.com>
 <DM6PR12MB3324B58464F55888B4D1FF5285B79@DM6PR12MB3324.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB3324B58464F55888B4D1FF5285B79@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::9) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [192.168.1.14] (135.23.225.238) by
 YT1PR01CA0100.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 14:53:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26d4a01b-e12e-4345-038d-08d98e592f7c
X-MS-TrafficTypeDiagnostic: DM6PR12MB2987:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB298727B93908498B3CEAE88899B79@DM6PR12MB2987.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wrsseti5kAanLW1yN5qPdheSW1Ese5AklqbHz99NY/yfOKwnNMGy33n2rnG5F3vsYtYO0H2VDUWKmSPnp9MU3Ti1my+CXRW1miWGDeiGBnSYARcuivny6npTBK4Lhm5MIRIhX05gSMsofcTZozgAiNiHvphTxLqn8GVcR8YAiBjQbBVUEIN2W1N/jNDEQbp1L7mOEEC9XNzsDDQaz/D580ao539m/7y95JBHvTJ1CoB63n3M3XqN2qIC8upSBpuqW7MlCGKOYX1A+Ex4k3EVLyBXKyMygygHY2gGFaqQltMWiicrgV0JcobYXm0yv5qw03QJyC21tvB7A2N5rgIT2iZJ/ZmI1BB0/Id7NY9+A8hD35qEPvcNEFV4Pb2IBzy8YCuy9kRIG/rIMTBMaYynyhlFerx9OJZ1bhbzpJfQ4fhx0uQelEnfbRKDfgoUI4hsEo8ndKOPVsvmRo4GPTP4yjsmMG/lL09xHEWsOxcRRpkqQk3S2HIk9QiWPv+IuaijfpFuTIruEhJodltsq/1qgO6n/SxM+P6uZDJznD6CC41Wz9lroLPItF8MiQUVqy1P31J3byqgsxuC774Eh/R/UK58pnX9vTj60imIVFJYtMr0toLt6QgfTYPGvgrTxOsE32TOc2a+sN8CeBOVQxi2HPbweZ4teZjRyvJsmuMeQdvWEOeLEqZ0vGfsDBphgS2EsJ4qfT2eBoysIfOjl+5gHDREqyktNlK7LarZ34x2RAg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66556008)(110136005)(36756003)(66476007)(66946007)(2616005)(508600001)(16576012)(316002)(26005)(8936002)(53546011)(83380400001)(5660300002)(31686004)(8676002)(31696002)(4001150100001)(6486002)(44832011)(186003)(38100700002)(956004)(4326008)(86362001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmdHR0Y2Yll6elVDK2czTUU1VEQzNy8xQllSWGxWQjBzWDA0cXozVkVjb3pk?=
 =?utf-8?B?ZklJVmFJbnlWQ0Q4aGlGNTNRak5lMGlJeVBJMFFBU2VGZUYvWktIcmRRM3Vj?=
 =?utf-8?B?WDBiZ3BUVDlZVzRiQVlFa2JvYlRMWGlCNVd1TjVaUjRXQ2dIL0xIOE1DZ05j?=
 =?utf-8?B?UUNvU21zeGtKdVhOQm5YQVBKVkhLblE4OGhPT3BPWlU5S0hmOG1ZdXhYbEdz?=
 =?utf-8?B?WGhFUFBYRjhJM2hYSURma1FWSFZKeitsa1NBSFRLN0MzUUJVN0RCNE03QVpH?=
 =?utf-8?B?UTdLaUoycUljekp6WDVrc0hDZmZBaEZ2eUs4d3dpUWxGWXlac1V4MDZtVFo3?=
 =?utf-8?B?R1hCVTJNQXBwQmxnb3pucXJ6akdEMHJIazdHcWFNM2VENWZYN1lseTdyR21R?=
 =?utf-8?B?ZkQ4UDl0YVR3aEFCaXJqdFFmYlU0OVZHZlBCNGxDYWZUTnMrZmdwd2p6Zkk2?=
 =?utf-8?B?c2JvVWV5WnIvSmRPWTk5RUpBWTYya2RzQUFMM0hnRGUwTEl1QWlOR2hKVUpM?=
 =?utf-8?B?KzFPZ2J0WWI3cXZWbjB6SEtLYy9VK2VPUFRvQmN6U3FZMWNuakZYUXhyYUJI?=
 =?utf-8?B?VER4ZEZXWjFuVXg3NHh3aUlCelVLcER3c3pmM0lJQTlkYkxFRUVqVTJ5dXZE?=
 =?utf-8?B?TVhSOXY3V0phbVZZbjcrejFOMXA1NlZvYjNxRnpVME42a0NIWEdwbERRemJs?=
 =?utf-8?B?bHlZQ0NOM1dENmRKQllmNCsyVUJpYlhBRUpseEtjemx1REw5SjVwZGhCZmdR?=
 =?utf-8?B?UFFPRDBxMDM1S0dTUG9PZ3FxcTdYWm5PWU44VXJRL1pSYy90YytmWFVzeCsy?=
 =?utf-8?B?c2JEcnl4Y1h2QkppOUNaT2hicFRvNGZFeWhRcGhiRUZwODYwaVBiVjl2V1VD?=
 =?utf-8?B?OFU4V3JKZ0lCZ3RvVHFlTUgrQ0xIcndzWEFjeTRvbHBoeXpsU0FrUmxIVVN2?=
 =?utf-8?B?a3Ava3RlalU4NjR3Tncrdzl6clE2dTZNcm40eXpHdytOOVN3K0pBb0NVK29u?=
 =?utf-8?B?YmVTNUZTSTBEMkpFMVYyMGsrc3ZpNVdIY1BZUmh6dElENEZUN05hekl3R09N?=
 =?utf-8?B?VnVzSzhXeUtGa3F2dEpuTGRzNDBrWmtCZEJ2Sm8veVFtdzJvdXZGTjBEQVky?=
 =?utf-8?B?ejdzRm95czEyOUY2WEFseXhWZFpIWWVSWGgyZFJ6aFZOTDl3RzZMMnVlcE9V?=
 =?utf-8?B?cVdJMWFMQTVTbTVOdWJJMkVhS0pybU1MVHpIRmpUWXpIVnFFUmhWUmZRYXRO?=
 =?utf-8?B?bDJacjlZYzFoWWt3UHJ0TjlWSWVqaldWYWQ1TGdPaEV2bEZDNkNrVkE4VzBR?=
 =?utf-8?B?enlIcEZHNDVIejdzV1cwSmU3UUIyT3VnMzZIQW5wWlMrbEM4QWZ4LzhnRk5D?=
 =?utf-8?B?TWF3R1Q3VVhDdWRKRkIyVW5US3VHck15dytKeERBRjVVY3M5dkxsTWtwUytr?=
 =?utf-8?B?RThqNldvazFiZXRDTWs4Q3ZleGZUc1BBME9XLzZUZ052ajVnUmkva0huMDNS?=
 =?utf-8?B?ZWxERDY1RTF1Tk1BaExWazNuTlA4Tk9BNHZhaElKVm9RaUpzMGorQk9mMnlv?=
 =?utf-8?B?UHRUZ1FUWHpUbzk0MW1DdDRaTXhHUENmTFFHUzI5dFZlUVdtRkJTNGVOM1RE?=
 =?utf-8?B?M1E1bXVFUjNsTzJtM2lxS2hsV0grU3cyQ0RaSXdUKzY2ZHpGTEt1MVZXUnVT?=
 =?utf-8?B?VWptVDFPeXI1bUhvMXZWOEFEODhBcVpGMlZQZGNxaHVjQkt3VmVPK3BTV0t5?=
 =?utf-8?Q?ASplXxj7T3MYzg44WRZhEkaTi3xMcq9guBWPv0C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d4a01b-e12e-4345-038d-08d98e592f7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 14:53:15.1984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z79DAK2aIcxdXcwH+Qvhh6SFpcGrErjGB98u39pvMwJEyLVUdRHqq4BNJhb+TQcm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2987
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

On 2021-10-13 10:50, Russell, Kent wrote:
> [AMD Official Use Only]
>
> Pedantic tiny thing:
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Luben Tuikov
>> Sent: Tuesday, October 12, 2021 11:11 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Tuikov, Luben
>> <Luben.Tuikov@amd.com>
>> Subject: [PATCH 1/5] drm/amd/pm: Slight function rename
>>
>> Rename
>> sienna_cichlid_is_support_fine_grained_dpm() to
>> sienna_cichlid_support_fine_grained_dpm().
> ^You would want cichlid_supports_fine_grained_dpm . The function is correct below, but anyone grepping git logs would miss it.

Ah, yes, thank you Kent--I'll fix the description to add the missing 's'.

Regards,
Luben

>
>  Kent
>
>> Rename
>> navi10_is_support_fine_grained_dpm() to
>> navi10_supports_fine_grained_dpm().
>>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 7 ++++---
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 7 ++++---
>>  2 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 71161f6b78fea9..0fe9790f67f5af 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -1231,7 +1231,8 @@ static int navi10_get_current_clk_freq_by_table(struct
>> smu_context *smu,
>>  					   value);
>>  }
>>
>> -static bool navi10_is_support_fine_grained_dpm(struct smu_context *smu, enum
>> smu_clk_type clk_type)
>> +static bool navi10_supports_fine_grained_dpm(struct smu_context *smu,
>> +					     enum smu_clk_type clk_type)
>>  {
>>  	PPTable_t *pptable = smu->smu_table.driver_pptable;
>>  	DpmDescriptor_t *dpm_desc = NULL;
>> @@ -1299,7 +1300,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
>>  		if (ret)
>>  			return size;
>>
>> -		if (!navi10_is_support_fine_grained_dpm(smu, clk_type)) {
>> +		if (!navi10_supports_fine_grained_dpm(smu, clk_type)) {
>>  			for (i = 0; i < count; i++) {
>>  				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i,
>> &value);
>>  				if (ret)
>> @@ -1465,7 +1466,7 @@ static int navi10_force_clk_levels(struct smu_context *smu,
>>  	case SMU_UCLK:
>>  	case SMU_FCLK:
>>  		/* There is only 2 levels for fine grained DPM */
>> -		if (navi10_is_support_fine_grained_dpm(smu, clk_type)) {
>> +		if (navi10_supports_fine_grained_dpm(smu, clk_type)) {
>>  			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
>>  			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
>>  		}
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index 15e66e1912de33..3f5721baa5ff50 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -1006,7 +1006,8 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct
>> smu_context *smu,
>>
>>  }
>>
>> -static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum
>> smu_clk_type clk_type)
>> +static bool sienna_cichlid_supports_fine_grained_dpm(struct smu_context *smu,
>> +						     enum smu_clk_type clk_type)
>>  {
>>  	DpmDescriptor_t *dpm_desc = NULL;
>>  	DpmDescriptor_t *table_member;
>> @@ -1084,7 +1085,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context
>> *smu,
>>  		if (ret)
>>  			goto print_clk_out;
>>
>> -		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
>> +		if (!sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>>  			for (i = 0; i < count; i++) {
>>  				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i,
>> &value);
>>  				if (ret)
>> @@ -1235,7 +1236,7 @@ static int sienna_cichlid_force_clk_levels(struct smu_context
>> *smu,
>>  	case SMU_UCLK:
>>  	case SMU_FCLK:
>>  		/* There is only 2 levels for fine grained DPM */
>> -		if (sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
>> +		if (sienna_cichlid_supports_fine_grained_dpm(smu, clk_type)) {
>>  			soft_max_level = (soft_max_level >= 1 ? 1 : 0);
>>  			soft_min_level = (soft_min_level >= 1 ? 1 : 0);
>>  		}
>> --
>> 2.33.1.558.g2bd2f258f4

