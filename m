Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33636C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26A8113116;
	Tue, 23 Apr 2024 06:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2hh+vlg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EE0113116
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:05:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg5ZnhZWF4KZeuah2knM1lVI2pxVX4aIOcfKM/h750UuUbZK3o/iPOxIqoA5Hy8XpTACUEK9MIP7pHRDZhslG/YCLsc8kgou9TuX2BapuoEqqR5JqX1q5TW7iT2mSwxvS36mWnxbHJSrpUTDWS6BCl4a4w08O4Codhh4t+1IEq9bLNcGkDIbfJvkHbz1c2lnDubgyw+sd/PDBbX+WcoHTU/jauFLhWwvFX27MuB1O+lCy8YS4+ExXxTTqlYWxzg/hk6ZFRCZZ49ILHfoMGkVM6/A9R2a6mpebsM7E+S/KWh8j6nTrTtdMo/l6Aby0sXs1yaRAHYDPxZ7kfc0SdAbVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuP+G9ZCp2KXJJmQ3vptXtBdpEHv3feSfY1g4p2HTjI=;
 b=Xtrq3Mm6hx+fVrun/kce1b6GFhQjas+dXqgbFADuK34wIkI9DquU/1JvAUFHbqkOV4PALt6mJ6/JTzpNNImLblSxQW15GulAtVHFxGUWcX0ENwHgXIM/36+V7mP4E6LY+f1lD0YK6G9Raz10IqXFWZwrDVtQ3MyAZcTTjz/TGkTwomSm/VYkj6V1aVDbO025vXcr4UBKZJFlo+Y/B1ENUonhCqee4Xf1AtnKEuASadyUptM6FFi2d9JQVfNSxJwOGkfAOY5OrXibIibrRU359RjjR1y5hiCL3L8jtFk6aJCUtSOMJKvEUceDF1cNS1mOSHCxsdJlfiS/mcSeXzxFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuP+G9ZCp2KXJJmQ3vptXtBdpEHv3feSfY1g4p2HTjI=;
 b=k2hh+vlgPmkeR72fv5FDki+qA1ItOalGumdR7gtzrWYzpay6hlY5/3o1Wuqv9zU0YbATGcVr9A229UZsJsoriV5ZZ+PcjkgODhXprJnUIzk6mFO+rwdtFFat2FQ54bUt4tieIS/IechdPgrnA0ylTWYQyQzezpHk81OErsUgGAQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:05:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:05:05 +0000
Message-ID: <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
Date: Tue, 23 Apr 2024 08:04:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
To: Bob Zhou <bob.zhou@amd.com>, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
References: <20240423053334.884670-1-bob.zhou@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423053334.884670-1-bob.zhou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b8b90c-17a4-4e30-e33f-08dc635b51ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXNrYTNzVExuY0dEYzFpZVZEV0xuNk9nNmxRMWZzOXlraUVYZEkveUU2OUYw?=
 =?utf-8?B?cFBUVFFDU1ZQUnZBdFJwUkduSTBzWkxiV0xES0IxRUJ2NEpnL3RZdit6Wkw1?=
 =?utf-8?B?WWFicEJYSlFTNEFoMjdIek4weU5tbm53OFUwOG9aaFhuamlPNlVlMjZrQXFU?=
 =?utf-8?B?NXBxYkNja09oWEZDV1RaWTJOZGlYd3JBSTNPUGF0YWxmUituYWY5UUYzblNV?=
 =?utf-8?B?UVRPdVlkODhxM3dNb1NBaVZZMWozc1kyZTJXcmZKT29SUllaK0RoWjRwcWJ1?=
 =?utf-8?B?eHY0SG9IUHJqTTVIYjBKUjJMZ2pkd3F2WnExTVpZVlJLSFhmTG1TQTVZWVIr?=
 =?utf-8?B?WitGL1FoUW1peEhkV2FLSVZBS3JWaGlnMUlFQTJVSU9sTXI5dkFVYUZrVzA2?=
 =?utf-8?B?clE5Q2VZNndkSUZLeDJBc2dZbnIvdDVXNlRIck9LRDUycFRSMFBpZXRwM1Nw?=
 =?utf-8?B?SGM4Ukg2RWUxNlhKNzhUSTlLQ3lUWGFaS0tyZmlyYTJEcER0dVhFUlFLZUNx?=
 =?utf-8?B?U3dycnhydElkTmE4QW0zaEFsaGlDQXBSQTlETEJzZk5Ra1lycUE0ZGY4U1Nr?=
 =?utf-8?B?TVJQVUlqYkZlaTVzZDVSZi9NenlIUk5vUGRKSWdiOE9JdWVoZ201TkxTKytB?=
 =?utf-8?B?R0VJdzRJWnJUdGRaSmZ5K1JMRFladVV4aEo0VkVXaUN4Y2NwdldpZFNjWU02?=
 =?utf-8?B?M0FjM25KZXV5Y0ZYV1hRNlp0Z2MvalRRNDgzUGppNG95cjBaeTNxMGFXeGxr?=
 =?utf-8?B?dGFXQXVLc1BkVUdLdUcva3VIeXJpTExrb0JxY2xWRW5yTFdkekl4U1dNb2h4?=
 =?utf-8?B?enlUT1AyVmtLNmt2ck1GQlFvMjdwVktYR1JLOUU2TEhHSjhuSWpSejJlVXkr?=
 =?utf-8?B?NzZTTitDL2N6MDZZWGhZVHl2V2xFdnRpaHU4M2tUeWdOUzkxd3d4QXlJYVhz?=
 =?utf-8?B?UlQwY0FmbUFpRDBqdmo4STJ3VXI1RUlNbmZ5d2krdU14QU9TOUgwNlI0YnBR?=
 =?utf-8?B?TS9vd25HS0J3bUVwNmpoN0luNXNaVHdjTHhDMUx0QU1ZTVV6dmFZaEliODZl?=
 =?utf-8?B?blZycjUzaEUyZXVJTTRrZEhuVkVDWUtoNHNCS1RJa1dBMXdHQ2NiZFJOTDk2?=
 =?utf-8?B?ajRjeE1EdnVmODVRbGphMmY5di81K0orWFVUOTV5NkllMjFQd3RWR1YreFp5?=
 =?utf-8?B?TnhoVHU3bUY2dlBVMlNkSC8xemhNODIyY2dHeGZFc3QzZi94bmJ3NkYrT1BE?=
 =?utf-8?B?eXFxN1pNQlpwWXFiWEswUDd1VTcvTjN1SEllcStnM0dxTmx5U1lQV09YZVpN?=
 =?utf-8?B?NFFyVUlwc3ZhazRrTi9BNzFNTFB6U3N6SWtDUUR2Um9wNzU2TFJ1M2svMTVC?=
 =?utf-8?B?TE1nbXFUcEJ6Y1BrRVByamdBYXFxNlJMa2xtOSs5N2lwSmJTMUE3eWhlZmFV?=
 =?utf-8?B?QUx2R3NXTE9nQUpTdXgrQytwMC9Xcy9tY0RITVF0MUtRanlSdG5BMml4d2U1?=
 =?utf-8?B?N3ZNMDNaRFlOempuZnFKYXgzKzI4WktjY3pBS1l1YlNiR1QxdUM4ZlhDSzRs?=
 =?utf-8?B?Mm40MVdleGpoVGZraE41WGNDeWd3UEd6Ung0dlB2WWRHbzVOZ0xreEQ0ZktH?=
 =?utf-8?B?ZFZqRUthejVnTFVyeWJia0xEZE1aT3B0N24vZFRCVTBlMTI3Y2JSeFBXcFpK?=
 =?utf-8?B?cDFpcHhLUlNKaUN5K0JVWjBGSlFOZUlnVEV3alRFWHd0ZnhqdTZzSCtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am05ZkJ0NitVZ0tVSWQyWFoxa0d4VmRodmYvR2dJYk5aV2hpOXFRRTh1QVJQ?=
 =?utf-8?B?U1p0VmpTRFR2amlOSEtrTVcxOWMrL25iMTd3WEZUR2ZnWVgxdTdrVzdnVGZo?=
 =?utf-8?B?ZFhvVkk5NHJpZnN5VTlaeTBzUTNaNEhrSWFCY2FzOVpOMHA4UW5QTzVOZFJG?=
 =?utf-8?B?dW9CdEc0b3VCY0habUsrRjRYQmZqZGFFNVhXenRXS2d3WUQzMmRxVVoyQk1P?=
 =?utf-8?B?Z2V2TDNxMnl4dUlRbzRiVjhtdmxBRUtUUE82M1lnRE1KTndBQVl3TkJLeXdG?=
 =?utf-8?B?M2V6akFQTWhhVms1eXozb2ViSTdXTmRhenloS0xIdVBaUnJGRkw4Zm11enNq?=
 =?utf-8?B?Slk5ZGNMVC94cGJ6NVByTyswc3dEbTROMWJ3RXBXdXVJOTlCcEZxMk9oVWNW?=
 =?utf-8?B?eXBPK0NIT29SdGEweVpQK2tac1lSb3RxZU1BRTdyUzFIU1dLLzdRU2xOOTNm?=
 =?utf-8?B?c2FzeUdpbzluSUphbnlyQUtVMDlYWXU2K0pnRS9MUmszM3BzYkVsZE5lZitU?=
 =?utf-8?B?TXBZOW1lV1hBYW1JOU9hYXNKQXZPMnVmYS9JZUlSR3hud29tYmVSdTVjRjBu?=
 =?utf-8?B?cXlXeStlSElhWWxmYlpWUDkreVhKSEEzeGNrLzBRbDFraTlhYnAwY1ZDRllh?=
 =?utf-8?B?d2xBa0Q0L2E2WHF0Y0ZiMGFMR0hvenY5K0hFR2V6SUNPTDFTaHVvMTRtMUZY?=
 =?utf-8?B?YlpEck9KWTc2UG1wTUtVVTMzTThDUWVuaWFFdno3dFJGUHVRNS9pWHJTTlVC?=
 =?utf-8?B?SVhwYzZBRUIrUm5EQ1ppaFppN3NRLzVLcHFKczdkam9mQ1YxRmxSVncwVmZ1?=
 =?utf-8?B?UHcvZWhzNzZnZ2lpdFljdUMxSC9YbUR6a2NNL2FMNCtFWGVtTTBOOVdKTnQz?=
 =?utf-8?B?Z0F6bm93OWhkMzVTWXVhQzNOaVlCTk92MFVGT2NUMTg3SzhuUjBmb0JsQzVG?=
 =?utf-8?B?WjFla0VXaEY1NGppN1ZvT2hjdUVFazFtZ1RKUlNzUEVoc0trVkREdUhtY3dy?=
 =?utf-8?B?QnVPQWFkRjd5OExETW1JaSswWWU4WXViU0kzVlR3MEpweEk4bVhFZDN0eENk?=
 =?utf-8?B?R2lKdGRyY0pvZzBoOWdjUHA4OHJyeTFVbUJMZC9uUlY2YzgzODQ3Yi9NTXQy?=
 =?utf-8?B?ZHlKQVhuUnRBeTRRNDlEZkhRZ1RyRTRlUGVxL29YWnQ2K0VSSTlOcStRTUFt?=
 =?utf-8?B?WTMzNkxsVjBtMjhZcWIxWUNyUzRoU1lMOXFJbmQ0UmVSQ2JYQTB5L3BQVHRi?=
 =?utf-8?B?MjMwbFh5RXV1bEg3eGI2TENBdmlYZFE4ZHRyOHRrckNRenlGdEUzNzZVUjl3?=
 =?utf-8?B?bzdOVVZBdUU1SG04THhVd3hXTk11ejJuNjRyNXMyd3FHM1A2M2NsNk8yTFRG?=
 =?utf-8?B?Qk9Zd1pRWW1pamtZRlRtN1BlWkdFcGxMWXFSSk53VE9QVWVDUmNaaDRKckxF?=
 =?utf-8?B?OHdnTDlpVmIvcTJnRkFGMFJMam13eFhUaU9JbWkydis2SjFsaHI1Rm9vblgz?=
 =?utf-8?B?cVlNOThrTDBxWnpQd0pnYzVBYndNMVhKdld0cGJSR1E4TXQyMkZLZ1BIWm04?=
 =?utf-8?B?RFJUakxiU3dka1NlN1JRQ0dNZXAwV0gzSW42QVlENUJDTGpHc3lRSTFmbUNl?=
 =?utf-8?B?U0pqRmN3Z2NETkh6OFV3bkR5NlNqUlFWUG9WQlErQWhIRHFzSkpTZWQ3aE5k?=
 =?utf-8?B?QmM0K3lQTnA4R2tRQm91ZHB2WkpTNVh2RlBYRDcrYkxhK2pxNnl3SGR6MitV?=
 =?utf-8?B?dHRZUmpKekpjcFZxckFPeFNtY0tQdk5wV0Fwdmo0NlA4Ui9SaEkzeWtKeEpv?=
 =?utf-8?B?OWw1bHpManBhMis0eU9SUFlYVENsWXB3VWFPdFhFZk9BUXJvalFnV0hzaURy?=
 =?utf-8?B?ejd2UWZYQUZmL0FCZHQ1Ti9UNnhFaGRnOUpZNzFtK2h3bEJ2c05CSUNEVURT?=
 =?utf-8?B?MGFjVWYvcC9HWnVnQlVKaW5SVEo4L08xdFB6Z0UrODUwSStxV05DUVhPdFBZ?=
 =?utf-8?B?YXBQWlErOFpZeWY2THgxQ1lCTno3b3Y4STJQNFNMOExNaVZMWUtYb0FlYVZt?=
 =?utf-8?B?NmVtekYvSUdWdFZCY2dxdnFiekpsVmlNa21EMVEydWwzK3YxMVRzdnJURytk?=
 =?utf-8?Q?1jYEiCkDf66uGcHbb/Twv8Gex?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b8b90c-17a4-4e30-e33f-08dc635b51ed
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 06:05:04.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvZvW5lDw1INzpxhEn7P/95Mor4YLTVkNNTL7CsDoOmYRED4f2ddsyFkIwFaYo/q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679
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

Am 23.04.24 um 07:33 schrieb Bob Zhou:
> Because the val isn't initialized, a random variable is set by amdgpu_i2c_put_byte.
> So fix the uninitialized issue.

Well that isn't correct. See the code here:

         amdgpu_i2c_get_byte(amdgpu_connector->router_bus,
                             amdgpu_connector->router.i2c_addr,
                             0x3, &val);
         val &= ~amdgpu_connector->router.cd_mux_control_pin;
         amdgpu_i2c_put_byte(amdgpu_connector->router_bus,
                             amdgpu_connector->router.i2c_addr,
                             0x3, val);

The value is first read by amdgpu_i2c_get_byte(), then modified and then 
written again by amdgpu_i2c_put_byte().

Was this an automated warning?

Either way the patch is clearly rejected.

Regards,
Christian.

>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> index 82608df43396..d4d2dc792b60 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -368,7 +368,7 @@ amdgpu_i2c_router_select_ddc_port(const struct amdgpu_connector *amdgpu_connecto
>   void
>   amdgpu_i2c_router_select_cd_port(const struct amdgpu_connector *amdgpu_connector)
>   {
> -	u8 val;
> +	u8 val = 0;
>   
>   	if (!amdgpu_connector->router.cd_valid)
>   		return;

