Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E482CC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 09:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B68110E863;
	Wed, 24 Apr 2024 09:39:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B2O4dg7X";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18B310E863
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 09:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN7UQhLLxxwXJxrHy4rYEG4nQNg0ngKrRoRZW96RbaCHsiC2RLeo64kUEDTpMicie1NOq2gbpS1exW0THoqYJmHGK7C0sQSmUaf7FtxfacNqwFoEOVjBFpmvhx+6oNIjlhb8zFeyzAcfj1se+PSIvm7Iqj6wyUTa7iWwXevjrT7e54ANj9eAehwp88ZU6YhI5tl7huIBKlBuWzoK4bVr8HF9jKkrMRygmACNW3Ng22WOe+mKs4GyVnQfQQ7zvUkyjdTWY/Wl4WaB5SjSQ9kEq5FcgdLmh2pSaWIlO7mt8A53IcPeBfrUVqCFm0b8TBzISP0o409HXm9SgJo1EGU41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrKBA36En4ucC1oa4eB6P11Y57L43NqVbOLq6W3USbE=;
 b=miqSQb7jkuDRvch9kMuYxh/GnBMKK+Jm808DuSb1alfxaZ/w53d9rAWXfb3EzdisBBVkHKGkG26A//upL7iXHHCdwXHvULPPyekZralq8KgZ5kBPj2I4K8A3UB4l+wXRcgO2PW0VOgasPMmtPRQAJa6r6VLVyjdTnTUnmWbrZL/p2TMXsZ1bR4ekarA/w4Gnxhlhgg1dhfPDxisehGRN7Qe82FTSavSQhKcyijdCYOx0veG+N5UsVdlMoIKR5ECIKJrI6KmTYUba4eauaWFdm/6t2kaPx7PAentCw3vQBTItVfgmjx0+j/5aa61FZL1gCREDZtaprj6KQpXGQAp2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrKBA36En4ucC1oa4eB6P11Y57L43NqVbOLq6W3USbE=;
 b=B2O4dg7X410sjCnwIfadsh9TGYqLaT0PNPKPj7uPvqnVfH4xMvvdaBSZSCk7Q29+vbCwI2KhG+mUxSxiU1tvVlp+AlTGxhqZhqMb3mjapeaeVMe/YiGumrVhQJ6k9z7PY2eTfcQebHvzAOO50g/YC+raof+MYBvjtzu31ZDFd3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 09:39:42 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 09:39:42 +0000
Message-ID: <7f777747-7654-4ea8-a50a-1a8159967620@amd.com>
Date: Wed, 24 Apr 2024 11:39:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: add return result for
 amdgpu_i2c_{get/put}_byte
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20240424093646.59783-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240424093646.59783-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: 805a50e9-e510-4fc2-cf14-08dc644277bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UURYdDZvTUEzRXBpc2xNMlJodXIxK3dnTWtPZGVuOVdlNWV6VjZvRE5ubUx6?=
 =?utf-8?B?cVRyZVBGWGVuWk9PL0xVRGNvbkV1VEpPbWlJN3ZPeXNNRndBb0Y0elFqUm1p?=
 =?utf-8?B?S0ZrbGxjWCtRemlsY2l6QWxrSHhRamVpUUcrNzBzWXFmaEh0NklxVjVmeFkx?=
 =?utf-8?B?YWdqRnoxL2xwdWZQbkpKQi93Z1lJdXBEZlNPdnl2MWgweUJSZlRIOXNyVzVN?=
 =?utf-8?B?dE5Bc1BmT1BlM1U1M3hjVW8zRi9tNFZDejJKcDIxbFBNME1jNTBzNXUzREhC?=
 =?utf-8?B?WHVwdGpYSU8zK25HU011dzRVWUVDdzFmOTJjdFNPY1dsK3UwOHhxU2dXWGhF?=
 =?utf-8?B?RjQxWjB5K1UvKzV0Vno4R2tyUHN5anFqYWdsOTRhR2p1QzFua3JCbjY3bitr?=
 =?utf-8?B?L0cvSFIvMVVzaDRCd04yb3locHlrRkZRZExLbkFsajRRMVJvbHVDVHRXcVpv?=
 =?utf-8?B?aExIeER6N1hSR3RLbmxlRjE5UWxCVU1hSGM5aXhuaXd6VWtjOVN5Z3A3NFhv?=
 =?utf-8?B?K0g2TVowTXhLblRrTitlM1NJR01ETk1YaEJzS0RpZGFIWGtWUllTWlVYd29O?=
 =?utf-8?B?QTJQQTZZSmN1T1N0RDJkanpWemYvRGVXcFJFTS9nb1BBbTFxdWFaemUxVXVD?=
 =?utf-8?B?MWpLUFQ2ZVNyYmJUQW5nWVYvTzI2WENoTTlDOVF4dTdpOXY0NmV2ejlBNVJs?=
 =?utf-8?B?dzZsMkhPeEFpdG9BRnhUeStXL0xkTEp5TnFMYWluQkNHbE4vaExTQ1l1MUV3?=
 =?utf-8?B?Y0RvNjg2RTBPaFZibVJKT0ZDWVRrU29KaFpRek0wR0d3SEYrREl5eDk3aFlw?=
 =?utf-8?B?TXB0bTNQTEZEYnVlL0pqSlA1ZkxvVmhidTdsakJZOFZCbHZtd3c2QWhFN3hC?=
 =?utf-8?B?SU5Hcm04YlB1b1NiekNsSFhjZGJ4Uy9ZYXBIL3VDQ1N2dzVyK01TOGhPbWR3?=
 =?utf-8?B?d3NkdXdTQ0xSMjJvc2hPMzV0NjJoVDgxLzFIUVF1Uzg3aXIybXRBbUx6RkI2?=
 =?utf-8?B?Ly9PV2VKTDFyQUoxTjFLT1BjRmt3dy9kMkhSeWhEUE5kRndNbXJwN096SGpX?=
 =?utf-8?B?NWJDZFA0ZDh6SDdKb2h1NTd0dGlhK3V0YnlmT1VhYmxMellkNFhYcmZUT2JW?=
 =?utf-8?B?dXZvdVVUa0V3U2hrL2M3MEFVcjlTNTlFWDB2YXBSQ096TWp6c2hlWUhDVmF2?=
 =?utf-8?B?MmZBclRvWWZyUFRrOTNVbW5DazM5Y2RHTnNCV09DMHltT3lmU25NckFmclVa?=
 =?utf-8?B?d2g2aHhPUnhWQm9hT09Eam5wbm1JUE1KRjFuZGkzUFh3K21OeTRsWkF5a2ds?=
 =?utf-8?B?ODBkempTTmZHSjhjUlZDYWlWRG5QSFVkcS9uUUFWaFpKM0libC91TXBYRGhR?=
 =?utf-8?B?b1RSZlc2QjFsb2tNS05WaEpYVmFSeHp0ZWEwR2hRY1J3ZzlYaUxLMktIUHlh?=
 =?utf-8?B?YVdsRFRxMC94bWZaTm1GTytXckNJSUQ1V05IRktXRkZzUTRhZVN4MHo3ZUlE?=
 =?utf-8?B?b0dhd2IyczBoSXExMlg4b0h2cGcrMGZ5QmxKSlliQzdKMGZIQ2ZMbm9kQ1RT?=
 =?utf-8?B?RUVldEk2VEdoRnBhMjhIS1FHZ3M3ZUQwZlRNYXRvLzZHdEsrU3JEN3Y5NXhB?=
 =?utf-8?B?VUJvN1Q1OTRBM3NNMHhWNVpQc2lCYTV3aWtjZFd6OVdONXllWXRzdDVlMENv?=
 =?utf-8?B?RTVkQy9ZUjl6TWM3UDdGdEZidUR3blgvUU5hSUkvQzBFbDVyRVdJNDBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVVYS3dPMEJTY0tYM2xZVjMzQlBzYStvRWlyak9WYTJpaW1XMGVJUWJJck40?=
 =?utf-8?B?QU4rZW5pRUFHdDBZOHY0K251ejBIa3BvNEFMUkNLeXhXUTlZZk5PRm8wMFV1?=
 =?utf-8?B?VDhWZXgvd2cxZ0tSRUZibW90bEFQWElKMkQyRXFBUWxBQjdoVDByQmh5YXVC?=
 =?utf-8?B?Zy9XV3R6MWtoMUxZaFJPUlZtWEkrZmNJalRkNk8weDJCaTZ4N0VZTHFJSnRK?=
 =?utf-8?B?WTVCckZjcEhRa2NORlRYMXVULzBhOFhOOW9SYnZYdi9ocmp6VmhsNitkUHln?=
 =?utf-8?B?VGZLTER2WlVMSUFQNU5hUkYrSGxKaVBOcWdpK3h1TS9JQXByUWNhRFhYOWtw?=
 =?utf-8?B?MWwxZitPM281YUgvc1R6NWhFMlhRRW1oM0swdlRUWTIrcWgxelROOW5WRWNv?=
 =?utf-8?B?OFlZN1JCTktaSXhSVXFsSXVJN1JaQkMzVFZSK3VmNjFybFJZUEdSWmxmSjVs?=
 =?utf-8?B?azZHNythcVl5NlEzajBjZ3JiYlQ1N3VKLzFTNkpYWnJDREM0VHJjZkV2UFJJ?=
 =?utf-8?B?aC82Qlkrd3JXL0xCZ05oS1NWaUJ6MmFxRUJ0czB2S3FweDRKcHhRYkJpbUM4?=
 =?utf-8?B?eWJrSWczOTM0OUxyOUdJRDVTckY0QWd1M1FVQ3lNUzlQWHhtY0gxWVVZVUE0?=
 =?utf-8?B?L1dpbVFVVVJOaWFQU0VxLzFFVkdjZmgvU3hnTkZYWnpaYnE3VC9MWEVqcUtU?=
 =?utf-8?B?WVFwWElydUd6dStCVnMrUFVLLzBDU0RDOGlsOEpkNVZYdUZqMTFjYW1TWEJo?=
 =?utf-8?B?QzZGK0M3cWVWTFNFb29YbXZVK1h3K1NMaDhYUWgycks4SDgzR3ZBa05BYUN2?=
 =?utf-8?B?Tk16SG5HZkYxMThma3cwOUp5cVpBZG9nQWQ4eWFLbTZ4MDZBYnE1TkRHU29M?=
 =?utf-8?B?Sy8vL1dsZTVTbnp0UFlxdFpleWNMTVp1QWdCS2UrU05VZUZ2d3U1T05yWU5h?=
 =?utf-8?B?dW9nM0V3KzJZVmxtQzlybDdJdVlOUTNMYTBtZTc4TEZIU3ZHOFZFMEFWemN3?=
 =?utf-8?B?bmM3cHJqcm5ScW1HN0w2MElXc2h5ZC9xRGNpdVdYU1RCSldvbThOV3duZ2tp?=
 =?utf-8?B?ZjVtc3RPVDlGazMvOFd6dk9Oei9ybEFFM2JzbGZmalR0VU5IQTBjVCtRbE1j?=
 =?utf-8?B?c0FIY2czQ0F1eHVtdkNVTXVxdk9hYTlORHBPOEFVTGpoK0xBTzhJUnRUV08y?=
 =?utf-8?B?ZHpFajFKM3NqMFZNdjVpc25rc1RScm9BbDF5aTB6a25idHJUWm1qNExGV2tQ?=
 =?utf-8?B?ZE9xQmlOR25yUk85OThQYkF0UnpUaFo5VUNDbXltNC9pcWxnbGNwSVJRYnoy?=
 =?utf-8?B?WFVPTzNzN1lBUWlxVW1YN2dwcSttcUV1ZFRpQ0xFRHFZWlFzb05NZDZFbThp?=
 =?utf-8?B?Tlg5anVJYW9sR0pxRVk4Y0FkMzFlMm1kdlBNamhKZVdLdnhUNXpDa2VTWXE2?=
 =?utf-8?B?UFNpbnJObi9FanpTWDJaODZ2bE5SbWNENFlzOGlUV3dlS2lGM2tONXRFK0g0?=
 =?utf-8?B?eC9FMTlmamQzaUxVRnVlR2pLR3lZSDBPTXVaUFptM0hPRFNvOVBMa2tIN3Zr?=
 =?utf-8?B?S2UzUzM2cmt4Y1dYcmpydWtvOURQdnNaelhjZE5yRyt2STBQZXk1V1dLYzM1?=
 =?utf-8?B?bm9ZZ25DK0FWWmtUMnNCRVh1Y2I0aWRabFBuZ0dRUHRueHFWV2RPRUo1a1Mv?=
 =?utf-8?B?cWRGd3BsWGd5aGxmQjZRYXowS3lDaEtvcmFJRm55a01mV2pFcmcwVFh2aVJt?=
 =?utf-8?B?bWZoaXBvL0hkM0R4bnhzODdyeWN4KzVZbi8rQ3lISWRkczFqNkdYWjY2UkhU?=
 =?utf-8?B?Z0VqMzlxYlpTYjliQVlSNmFZZkVudzZJVGZKTXVDUDYwR0VhVVlzYlNtT0hn?=
 =?utf-8?B?VUpEYXdYSWlhUzlPL1RFM3E1WCttYURLWTRSbUVoZ3JuSUxzTnZBS3Vpelha?=
 =?utf-8?B?SnR1MDhnTXExYTROeGRpSmo4NGQ1N2ZoTkhzV0xNMnhmMnFsTjVOVjhxSzlE?=
 =?utf-8?B?eHVjREIyNlQydElFL3FNTjlkNkZURkZ0eFB4WkZveDBhZ0txYmdONHltWWZz?=
 =?utf-8?B?WWdONHZpRXlyWTRiZGNvdDA2aVdlblBsRzdMY1czUFl4UU1OK0JJSkVqT3A3?=
 =?utf-8?Q?s9aui8YhZak7AfB3GcPzGBBXx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805a50e9-e510-4fc2-cf14-08dc644277bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:39:42.0372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGhToNta2TL00u9rm7jZFY1ZnemXO5FA4aNpr1Hvwo0I2P6+hiv9QmRfG2diOiR4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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

Am 24.04.24 um 11:36 schrieb Bob Zhou:
> After amdgpu_i2c_get_byte fail, amdgpu_i2c_put_byte shouldn't be
> conducted to put wrong value.
> So return and check the i2c transfer result.
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 47 +++++++++++++++----------
>   1 file changed, 28 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> index 82608df43396..e0f3bff335c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -280,7 +280,7 @@ amdgpu_i2c_lookup(struct amdgpu_device *adev,
>   	return NULL;
>   }
>   
> -static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
> +static int amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
>   				 u8 slave_addr,
>   				 u8 addr,
>   				 u8 *val)
> @@ -305,16 +305,18 @@ static void amdgpu_i2c_get_byte(struct amdgpu_i2c_chan *i2c_bus,
>   	out_buf[0] = addr;
>   	out_buf[1] = 0;
>   
> -	if (i2c_transfer(&i2c_bus->adapter, msgs, 2) == 2) {
> -		*val = in_buf[0];
> -		DRM_DEBUG("val = 0x%02x\n", *val);
> -	} else {
> -		DRM_DEBUG("i2c 0x%02x 0x%02x read failed\n",
> -			  addr, *val);
> +	if (i2c_transfer(&i2c_bus->adapter, msgs, 2) != 2) {
> +		DRM_DEBUG("i2c 0x%02x read failed\n", addr);
> +		return -EIO;
>   	}
> +
> +	*val = in_buf[0];
> +	DRM_DEBUG("val = 0x%02x\n", *val);
> +
> +	return 0;
>   }
>   
> -static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
> +static int amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
>   				 u8 slave_addr,
>   				 u8 addr,
>   				 u8 val)
> @@ -330,9 +332,12 @@ static void amdgpu_i2c_put_byte(struct amdgpu_i2c_chan *i2c_bus,
>   	out_buf[0] = addr;
>   	out_buf[1] = val;
>   
> -	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1)
> -		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n",
> -			  addr, val);
> +	if (i2c_transfer(&i2c_bus->adapter, &msg, 1) != 1) {
> +		DRM_DEBUG("i2c 0x%02x 0x%02x write failed\n", addr, val);
> +		return -EIO;
> +	}
> +
> +	return 0;
>   }
>   
>   /* ddc router switching */
> @@ -347,16 +352,18 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
>   	if (!amdgpu_connector->router_bus)
>   		return;
>   
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x3, &val);
> +			    0x3, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
>   			    0x3, val);
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x1, &val);
> +			    0x1, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.ddc_mux_control_pin;
>   	val |= amdgpu_connector->router.ddc_mux_state;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
> @@ -376,16 +383,18 @@ amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector
>   	if (!amdgpu_connector->router_bus)
>   		return;
>   
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x3, &val);
> +			    0x3, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.cd_mux_control_pin;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
>   			    0x3, val);
> -	amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
> +	if (amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
>   			    amdgpu_connector->router.i2c_addr,
> -			    0x1, &val);
> +			    0x1, &val))
> +		return;
>   	val &= ~amdgpu_connector->router.cd_mux_control_pin;
>   	val |= amdgpu_connector->router.cd_mux_state;
>   	amdgpu_i2c_put_byte(amdgpu_connector->router_bus,

