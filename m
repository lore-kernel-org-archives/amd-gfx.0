Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1D7C0015E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 01:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20BF310E183;
	Fri, 28 Jul 2023 01:14:31 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8656210E183
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 01:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmu+QKg6zQ7/A3cwvjUZ4KfaLm2Eyj9clJdSKtG/HSGnQksSaYMrf5Tgkxtc6dBjczDmBBPiX5rF+iCOLOG1GiuQwQ08WSPDKUZtWnoXtMR+mb8FmfOX61FaKg3GS415YaNNmFNgIf8kz4MW0JgN8zexG+dYb+IvQZqCpVMZN25AV5QVg4KfbaIlvAJ1Y+GoPQeMran8C45uB3xwVMfBcKXrtl78f5kLWU0lX+KAy6hzHG74HWpqwHAClrkMIIbsllN8lgRhN/ZIapxtcACLgv7BkZHWbzFoCdO+DT4sCmC+V1NXlwOMry0PdR78ewlKLkelW0B99lKzUDc2rsK2vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrnHv+cEZaK1j6IQCXVaIontAPwdpqFZhEZp7mt0UDQ=;
 b=i6Dyr1MOvGTdWOsmnSXdTivJlOeo9UiWTOx71tgt9htVnK9v0boi5JsqPwNnR4dxdS/ZtXg8cd5YaG8AJJvNp1iedawg8888va+c+yNdsfH2NIvmrDr9epnxuuUniyfnR/1sEb6LIy292kIniOS67BiKlgXdofKoTGwwkdSYbXa/8j87yeyBWrZGnYISXBbZQNPK4I46+1MWeP/0BF040xrF3lvO0LHSNgl4NRMsIJMrKdXoueBEeALe68ehPfEpdcL1WfCzeuUSqPhy9QKVKVgWGaRqA3Q/lR3nOwPSBO26EREyzykKGzc9u2l1vEwhHIJHJAufuFVg1u9rYNVJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrnHv+cEZaK1j6IQCXVaIontAPwdpqFZhEZp7mt0UDQ=;
 b=nyLIMq/TkzSciUOngmhIuVNhRbjSeyPG7YsCJaNwu5OZJi+9aAoOTb+pOsFMMAe9v3XcNPgCRYEM96LniFDVQZdyfx3E6MXhFwNKSwX69zdu7nPs3n6XMee0R/6Eni8O5fLC4+Qou1A010OUaAkz/Z/QXAOjikcYwDBQqXRs2Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:14:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:14:27 +0000
Message-ID: <e751765e-9ec2-83e0-90f6-c7d96943dac2@amd.com>
Date: Thu, 27 Jul 2023 20:14:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/pm: skip the RLC stop when S0i3 suspend for SMU
 v13.0.4/11
Content-Language: en-US
To: Tim Huang <tim.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230728010504.532158-1-tim.huang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230728010504.532158-1-tim.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL0PR12MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 06879889-54fe-46f1-4479-08db8f07fd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDw2tQK/kTjFfvuftd2mj+9spxrdea8mwE6PpkuEyJSgXc11r++bwCKMjFS7d31jiDFkJ8vsusnbv/Tj/qcuaz8E59jg75CXzi3lFtu7IE3++nl04BJ8T2EflhNBk/L/Qcd8MuVnL/jx9e/SQipucUuPq4ihnQObGnKi4+jkz1YRifS1V3ncxTJZhylfHakhEJSA7MEf0GWcaKItmPunI2zqgDAF+ExLRsYjvB0FN8BMH8RdND7yWydTRNHN4uGrgq4sG9sd94itx3MWyWQvu9WiyWrkhpjhx2MlhoSf6JQtyXYGKFQEfT/HupRRTDtbdJzyPgBAMoSLE5FW2shd2Cuop2v/1J/Uf7L0p+XCyfXMqLBqSDscqJZTWgUMH/ROT9ftP5RnW+V40MblPT6mHeadrh0nxgt65Y64ZcMiPXN5pw+hM7/ysGX8yZv5BkF3sR4oubxjKQXbWYUAxODNya0C6DyyuwPstCWCJ6017qv7kc6KFNbqmJff3CuvPwJqlq+gGV/w5o+u3ym4NGbIUIEKFMuqfNW7KeMx4vib/jvCU3G8KndHEnaNFBe2DwDEKlWU6sdOMyR318Eitb8FISeSkyy8KAyChRcdCIClP+QLQgV5RnbZGXuhRLoOYW8B57mkJ9b6tty5MdBMIuWdSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(478600001)(6512007)(6486002)(6506007)(66476007)(53546011)(2616005)(2906002)(66556008)(316002)(8936002)(8676002)(5660300002)(41300700001)(44832011)(66946007)(38100700002)(4326008)(36756003)(31696002)(86362001)(83380400001)(31686004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzBwM0pWQXV6SXN0bmR3dFRNZy8vVHNaWitMOG5rNTk2WUNlZUcxenpRR3Ny?=
 =?utf-8?B?TVdITXduYW01OUJITkZMSTcvcjJPMld1VzVveUVjNFZLTkhXdWhhQ0FaUmdU?=
 =?utf-8?B?QmJsa255dFVMWXNjVXNPNFhIazNac3o3aWZRTFBKd0VOUDJEZFZYZVB1bFJY?=
 =?utf-8?B?Y0crTEhjR0FKM1RXUkV6MitGaU15czVISnRLMVB0eHNBWWs1NzJOa2psL2Y0?=
 =?utf-8?B?ekF1M2dHTE5OWGFzYm8zOXJhdVJwYVhoVzdaVXNYeFRSQXlJaVpnMWhmYzJo?=
 =?utf-8?B?YTEzby9mdFlHbmRPbHRsQ0ZrbytpWlRseVEwWEtCYWZSL1pkZTNmVUZ6QWhZ?=
 =?utf-8?B?VkY1dzlseitLWVlvUGltUEU1RTZPYTZIWjlybTYycFdnTis4UG9POUhVYks4?=
 =?utf-8?B?clFYOTY2aDg4RHp5a3FuS002UmMydzhGeXFicmo2bG0rWDFueHZLejJFUWtU?=
 =?utf-8?B?Zk9jbWxVQy9pN0w0OUFNRVViMWJJYlo1elBwa1ovMDFGWlEydmJSNysyY2pP?=
 =?utf-8?B?MmY5R0ZVdXpIUVQ4OXF6eUx5Q3R3c2Jacno0TDBKU3IxaXVTV29Ea2JEWTg1?=
 =?utf-8?B?Q2xlUkRhU3ZIUlB1ZjQ2NC9pMGd3QnhiUTdqVG5UdDZvYWxsY3Q1OWlvcUg3?=
 =?utf-8?B?WnEzOWdEQVhPVWl4L0tjQi9pQXVYS25BNFg4L21aaGhya3FRNENUS1RFK245?=
 =?utf-8?B?SmZwUkpycmNkSTluWksrNU1jN1ZobUQ4Skt3dzRYQWdHdEZmMmN6TDdoSVNo?=
 =?utf-8?B?Y0NGNm5SamxaN3NMUVhhMmxFeDcrVE9ZajZaTEZja0JmclQzYXk5VUZGWDA0?=
 =?utf-8?B?dDk0ZXlCOFZER2k5Y3lTbG9YcHhYc0R0Zmh1YTAvSW1jR0kxSjBJWk9tYVBG?=
 =?utf-8?B?OHZudHhvenlNWFB2c1k1eTZ2Z1BHODhnSDZlZHRPM3cvVDZsYVIxZHdyWHhl?=
 =?utf-8?B?V3hQbE56VmJLY2N2RGwvSy80dkJGTFl3dGVlb1RZVVNZdFI5ME8vbkVUTW9h?=
 =?utf-8?B?cG1aUzhuc0hSak1UbzZIYTlYbWNubUliSkpuaWxqNEI2NXRWU0IwQVZUYzhn?=
 =?utf-8?B?aElxUnZwZFhBQUhPWE5tSDFoWkJ4RU1lSmxIWlJUSGphWFkrUXdRYXc0UG9Z?=
 =?utf-8?B?Rk9wcjRuNmd3VE52bERuTkJZRG5iZlpMZXphbEZ4WDRya0RuMFZSMDlCdHZ1?=
 =?utf-8?B?bjBDUlN1SEhlQ3ZhWnNWM0NUMkw5THJ0YWErT21aeEFDeFo4bURGQTZZdW1z?=
 =?utf-8?B?ZEYxZFZJWDkvZDVtRmZHTnQxOTVTMkhheFpuQll6VytkK0c5VThWdHQ1alVM?=
 =?utf-8?B?eC9WT0FCOTdyK3I4WWJkMEZ3VVpSUVJyRzZtQm1DR0F0T1hGYUhVU3lCWmFp?=
 =?utf-8?B?OVlXNW1zTHdKYVllTklla0dqQVIzYTJEajl3b0dNNm5GcnZ1SDBqK0RiSzFI?=
 =?utf-8?B?NnI0ekdmMXcrSmNKTVhhdzg3VUVkYmNzOTlRTGp2QTFkQ0ZNWUcyaGM5eEpP?=
 =?utf-8?B?emZPQm42UjJOSllHd2w3RER1N2hOTnlFRng2ejhTQVdsRDB0RzRsU3RmYkV6?=
 =?utf-8?B?czIvMkt5c1A5K0tOb3JodStKOHU0czRHVTBWRlVhMm9hN1FUZ3Z2TVZaODZ6?=
 =?utf-8?B?TzlRaVQrNDBpZkR1TThIQlcxSW1xYm1aYlRJQk1VUkluVkp2amhMeXlteFV5?=
 =?utf-8?B?WUVuRkljNjJDeTh5T0tzRHpab1NBUDBsNndrc0R5UWZKWmNveGxad0RBVmZp?=
 =?utf-8?B?VkRscmRFNzB5Vm5xNForeHR0TWx1a2VRNlZobXRNU3MyRHYxVjBxOVI3V0xB?=
 =?utf-8?B?NFJIeG1ybzlzcXBvYTRtTno1d3hjdXdwYWZQbllHK3d1bFd4NTdDRFJ0b09R?=
 =?utf-8?B?SFB6cEl1S0VCTEpUTkk3a3JNMUZIQWQvMEQ1d0FyMzhBSlRVaTRhQkpQMVhj?=
 =?utf-8?B?WHhWRmtweFYxajB4dWxaRzQrS1BObU0yaGMyODFLaStPOHRrakVxK2JJZnRD?=
 =?utf-8?B?U2QzZDQrSkN5ZTdwUVhFcEZQeWREektBNFozT3cvNUdZaERQM3FvaUhFTzJi?=
 =?utf-8?B?aXR4MFQ1c2RteGRBaitlVmc1MmUyYmpDalM4Z3grZE1TVldYVVZuM2NGMGs5?=
 =?utf-8?B?ZmJNZ0x5NnE5K1lnRHk5TWtrUTVhaXlWaUZLTEU2SFVCZWhxRjBrRDZ4U2tI?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06879889-54fe-46f1-4479-08db8f07fd11
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:14:27.7699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tV5aJmgM1gRaKrSzmGcQnJU+2N2DYZZfoB5KU5JGEyzSaS0jzLtAzAb/6iioW5wN2+t8pbrKqbeynJJ3gcA3gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/27/23 20:05, Tim Huang wrote:
> From: Tim Huang <Tim.Huang@amd.com>
>
> For SMU v13.0.4/11, driver does not need to stop RLC for S0i3,
> the firmwares will handle that properly.
Conceptually I'm aligned to this.
But, just to confirm, have you already run some testing with this
with current GPU F/W, BIOS and either 6.1.y, 6.4.y or ASDN?

I checked with this on my side and saw success but I'm fearful
that it introduces some of the fence expiration problems we
had in the past and I'm just not seeing them for some reason.
>
> Signed-off-by: Tim Huang <Tim.Huang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index ce41a8309582..222af2fae745 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1581,9 +1581,9 @@ static int smu_disable_dpms(struct smu_context *smu)
>   
>   	/*
>   	 * For SMU 13.0.4/11, PMFW will handle the features disablement properly
> -	 * for gpu reset case. Driver involvement is unnecessary.
> +	 * for gpu reset and S0i3 cases. Driver involvement is unnecessary.
>   	 */
> -	if (amdgpu_in_reset(adev)) {
> +	if (amdgpu_in_reset(adev) || adev->in_s0ix) {
>   		switch (adev->ip_versions[MP1_HWIP][0]) {
>   		case IP_VERSION(13, 0, 4):
>   		case IP_VERSION(13, 0, 11):

