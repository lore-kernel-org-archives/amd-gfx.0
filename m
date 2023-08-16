Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A761AC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 13:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F0710E0DC;
	Wed, 16 Aug 2023 13:50:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA7AF10E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 13:50:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbDuTzqLcsWUJyzw9vv5gw5Nf0IoyIFofqgWgQ3t8AtvEFPpa8zpzpcosK5Th3zWH+DDEHQLRoei+NPW/vt2BO8hu5902+yF886DP7YQBrO+UD8cCDMBK4Y5so+NY/+aA6wZrXrBVt74ibswPY5/11RNZ3SiI6026YE/fymOuWhwIcdAsc93FJPVol9nFEgOjIM8Hu4jwFUy8ipqZqueMf4QTJ90rVK57h3RPMVAH5x0ZJbzwcaCFPjMGmGdczU1MUJtFJJ5+WsFTa1q+ypbmoKbqR3rkGBDlPXCcnYbIfmD58S0bbM2T8+H/fR32tVfSahS8fq5raKD1LkMTkKAvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6flfQn5ATDAv+2bwsXEOSCJhy/hnzNcZdqMGLN9wdU=;
 b=Ea6noZe9uc1o0OkzjjaR563gBYt4OOwtcS9zsDBO8hCNvDJlRbCNTs+oezKWz4chQIbZbtJZvRU5mEgY9vaUipFmX5WU1GEUt2equOVQUeYM/vZc54iWiXV21ARTYoRkkn1ka6gReUSLsQjmJ8wC3juETTS3LPsr10/hQGY5CTY3EFTVAJ804+6UxQrzS8Cg1Dju7FExpZZqIF7/mpjDk1s5srss1jtsRxQr2IdLLUfky6KbvikyvDRBRq/bzvMgI5gSvxrXsW3dbLrgyVM6V3iatz6eT3X6nGNSv8TcFuFzocpxS7qYXy1F1UqYolWq/u+K8EQO7ncWcEXpgRi7gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6flfQn5ATDAv+2bwsXEOSCJhy/hnzNcZdqMGLN9wdU=;
 b=rlVsxJ8kgwYR0+yVQeaBTP67noSravOzZJq05SURZ94/BIN0HY/kWpxUAjEmL+h6yYVqeNeyPiaT/kYzAdmE7an4rV60EIivE03KP7WtYe0LiYKQL4yLmqXIosuHJvzWxzI0VZ96ff19gs+6l0QvMrZd6yR5UyVEHhIm/heKYeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 13:50:37 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::236b:d4e2:6fbf:6c2b%5]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 13:50:37 +0000
Message-ID: <44715395-947a-4cc5-8971-a455dcc8c9fd@amd.com>
Date: Wed, 16 Aug 2023 09:50:31 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Fixup some coccicheck warnings
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
References: <20230816113213.716108-1-srinivasan.shanmugam@amd.com>
 <a959ad03-e5bb-404b-1aba-2d7c88b6a1d6@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <a959ad03-e5bb-404b-1aba-2d7c88b6a1d6@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::13) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 315929ce-721f-47e8-033c-08db9e5fc564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eh+cOWp9leOoQ2Etx/ECP/dsNLPselKtzz8R9eFHBeD3G9aT2aCDbxsNw4IcuV2OQ4XKV8USEmVWxZvMobwq7+RRHVDDQ+gEOYlxMDQMV2rhxLPxBj+T7+A/VY3RJjY77t+fzSSZ1EPsuNPkwqihWaBhXvGGNEv1n+t0NA6Ogw85HqqOD86/q2GCh7oiYloZjOp7DH7wCU/YETmHO60pgy96WMXH1tIqGshI/vawrihn4iWGv/FmIfg6+VlAxBaZcVsxX1kIhVojiG12n7uSMLZsx/ITNWQX466mrXtqB2fCbmLK0DMzcxPEY2paMTOdyd3g8p/+E5F1QxJ0+UjBrtEhZIu6soK5VrGc08FY3hfr7IH9fouZ7zgxRdSfG3vswWEMwpUE83qjanVzOOaVvBhTkSSJmLhbKiPvq+h+KgRTCwDmME9wvuWmJvKCQzQ6/0EeKH/BdJ5cN32kn9Q+Z/86ZCxfUH3u3pERZCcldNauUah+50KsbMZ4IdeNCkHZ5nNEH3U4QLA93M0n3AHV8OBzS8T/sUQ/yBAGmr7BeutRjrZMyCFcTNE9FnyqbzoRQfkUDLYkNDOAaSo68Ww3edhNOxAd6Mlwhh8uAbwWjghEJ8kefxajgbFzPcxG63uSHIWhdzQWI22LYG4+iRSy+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6636002)(66946007)(110136005)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(31686004)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRCKys3RlBLMXdrV1FTaGR3VXVzeTV4RVZlVWFXVlRzUEtIcjZJV2RkN3dn?=
 =?utf-8?B?RzhHLzUvdC9nY0toNUQrY3Y4YkxYNy85dHFFOXNDRi8zTkFUNXVCVTE5b3dN?=
 =?utf-8?B?VjI5VnZYNHZ4L2pEdFMwRlVyZTBvVVc2NWRGQTFRMFZNUGxHM2MrNlV5OFFU?=
 =?utf-8?B?N3FQOTltK2VueVFZNCsxV29uQmpVSi9xQzNac1NndDIwNU1rb1F0dnlsdkxH?=
 =?utf-8?B?Ly9jOHhheUNIRGhueHFCQWNCa0RoOXE2MDAzbjJ4bk1ad0EzVTdUTzR2Y25X?=
 =?utf-8?B?b3BQQ0JrTVV6M0NHVjZWK2Y4aVdMRlJwVndrODJxa3NxdmxUYjdkNGp5Ukxr?=
 =?utf-8?B?ZVNBMmFUa0ZXU3pQSUgvQk1mSkV6bmVDRGF3M2pwbk91MlZMeFlYRzY4S2Zw?=
 =?utf-8?B?OXRIT25VV29tdGp5Y1ZaYWRyNExKSHlRbFoxT0Q5K2YxUDNsMG1uNEVCR0pu?=
 =?utf-8?B?OGJUSHJ4QjNsQU5ER0VyeTFwUUgyN3cyV1BKNW1NVUFkK01BUnpyb09peVds?=
 =?utf-8?B?M0NDZ1pVNUhLMndBTFIyVVJhRTV6VTJRcUdsZWl0RGw4Rm92ZFZqZmtlR1Qw?=
 =?utf-8?B?TzhVNkVrTkhhNDR2M0sxR3F0TDV0a1p0b2ZBbnVva2YxSHFQNExxR1JWTG1Q?=
 =?utf-8?B?bXhlMVhCeFpFZTE3TDRMN2N2VmNaYWxRdm03WDV0OElqMERpSGVCeVJJcmFw?=
 =?utf-8?B?eklaS21DeDhNYldhZiszZnpoOG5FTW9ob0JtK2lsd3ZlTk1DSERTdHEybk1N?=
 =?utf-8?B?Q1cwRDlYdEhtNWdscXVNNnRNN01BK3dtMGQxang1U1NPMmJ0cnlGOER4Z2V0?=
 =?utf-8?B?Y3oxNzhFUzRrVkNEVlQvOUFCb1g3Vm9rWTRSWXhSNE5RZERGZEFNUXk1b0Nq?=
 =?utf-8?B?MlgyNTFBYXhvU2psRENlQ3hDa1ViQ0RzZWhHc3hReEVUTXYySDZFaG9WVFlP?=
 =?utf-8?B?Vk9BZ2lDTWUvTkQ1ZlYwSUQzRXRtRVRQY2VkN2ZDeVVRZXhETGVyODcrenV6?=
 =?utf-8?B?UUVBTzlSTzNYNHh6djRoY1VlTi81dlMwV0d2VEx1QUlqaE9UYWtnVjBqbFE5?=
 =?utf-8?B?YWkxdk1LT2p4T2puOEtZWUNLYU4zdmFqWnZwYXpGanZVYWFuWU5rb3c1L3Nr?=
 =?utf-8?B?TTBvZnc0cXpHMWNBWVhjTHRjRVZmTHdBNXlMeThzSDBmTExGSGFFaGF4REQ5?=
 =?utf-8?B?YTI0VktFNFJlZ0R2ajJmeW5OSjh5ME9hRVRiNXNqdGlydzNEbDJkOUFrWDEw?=
 =?utf-8?B?TXk2c2EwMmx6UHloS0g3d2FZekwxL2tyZSs3ZmEvVVdmOE1waGxwemN1RDh2?=
 =?utf-8?B?UWM1eC9wTFRwQkdiZGwzcGR5TEx5S01DMjhGYzNJUDBnZ051bGJqdjhXY21O?=
 =?utf-8?B?dHJNcm5DcjdLdVpMYldJYlk4Rlh3ajZJTUZ2SEFMdjQ4eDkxM2NoaDhTVDJ3?=
 =?utf-8?B?aVUwUXpva0JYdXFpTnNTL2syaWVwbXVlayt0NnA3ckxLS0NiQmFsbTBHU3Vu?=
 =?utf-8?B?UzhNbGxkM3BVUFNWM2V5cy9iVktNM3ZicG1sSUxEYlk1TE41MkliN2Zzb05t?=
 =?utf-8?B?ejF1MVBuRXZ0QitSZ2xkTnQzdEdEbVdndDMremFMdVNaZWpFMFUvTldTWHU4?=
 =?utf-8?B?ZldiMlNZbnNkaUZ6emJSb3NPdXZTakc0cHM3djRSMmg0L3hGY3gzdTQzdmNF?=
 =?utf-8?B?Myt4ZDAySGNrSjh4QlVUbzdDdjFBTitKS0pUQUVaZyt1SjF4MEZmcmRQR3ZW?=
 =?utf-8?B?R1JXSUJ4dHk3TndYd2R3amdWN2dlWjU0RC9YZ2liKzhRZm9qTWR2L3BNVGtx?=
 =?utf-8?B?NUE3S24xWXRSQ0ovZngzUTBiRFBiSUtzSWtrdzRBeVFnMTdGNWtFK0JvbFVz?=
 =?utf-8?B?TUJYUHVPMEpEdUpHcUJnWEc1NUhOeGloTXNrVTByalBLYmtJaGhrYzdOOC9X?=
 =?utf-8?B?NHkzSW5CbUFiMGVjcTJzZ0x5Sko5V2h2Z0dDQ01zd2V5amJtdkRpR0xFTXc3?=
 =?utf-8?B?ODM0ek1XWmtIQ0xnNVJTby91SGpQS0Fac280d0IrcG16czhRdEtzOXVXRk9u?=
 =?utf-8?B?RDNxK3labUJFQlhtREp6ejFzM0RKb2s1cFpVT3lnWCtTZzU0SFJ1bVhZVWgz?=
 =?utf-8?Q?v4RI5FHww7T27fh1RDCUqUfiz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315929ce-721f-47e8-033c-08db9e5fc564
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 13:50:37.5788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gI2V1srSTDGBdgSPzXdEE0HCPpgW/e0EuOa1hQqmMDzUw08P3P8Ky95OUbW8G2u2p1tOoKPbPzScnld+oGUAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-16 09:15, Lazar, Lijo wrote:
> This series decreases the readability of the code. Is it really a rule to fix such warnings or is it only a generic pointer to double check (not to be followed every time)?
> 

I'm a little tired seeing these changes come in and agree. I see
no value in this change. The old lines in the change actually
have fewer characters and more whitespace, making them more
readable.

Harry

> Thanks,
> Lijo
> 
> On 8/16/2023 5:02 PM, Srinivasan Shanmugam wrote:
>> v2:
>>
>> Updated to max_t/min_t along with commit title message
>>
>> Srinivasan Shanmugam (3):
>>    drm/amd/display: Update ternary operator with min_t() in
>>      'do_aquire_global_lock'
>>    drm/amdgpu: Update ternary operator with max_t() in
>>      'amdgpu_fence_wait_polling'
>>    drm/amdgpu: Update ternary operator with min_t() in
>>      'amdgpu_ras_eeprom_init'
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c         | 2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 2 +-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>

