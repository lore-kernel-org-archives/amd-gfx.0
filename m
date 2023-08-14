Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69E7EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 11:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1AF110E1A2;
	Mon, 14 Aug 2023 11:10:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A4C910E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 11:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCujrRUQEGvWF8e4FDQSnvWRCN2WumhTISQDJfiyVLaHTjvqA0ZCd26G3sfPPwZutjWT7y2ZdwFLNmvGVPYk6kYEJBdYk5FRojBJH4JJjElV0nJAWkT4UKpibZviEJ8yhtdhGVDeSBwHJs/pt7EG0WNvDOt6L4OfDs/3jJDzvFSGq4hSpABvYt8pspwHIcYE7PBqCOoR8bKIxeOyrHqeG9kwZNUFjn3vErdlYbBt6rfqlwZt0i5urmGphH7VMMrq9taHBCOlkJVKGUAq5N1sAV4gCwn0D7tP/j6S2aC94MFoEYKehSLGhJmGTloNwrRl+TSaA600gCEH9PyEWZOx4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH+YouNhJHL1gQAdGBs2KbWda5DH/1+b1wCBmhM3PPY=;
 b=JreQ0qBdW3ZyQxfyzIKT/7lsD4kSw+VQoLsxY3NMIkhrYzi3tq0Qg48EXlxmL2H7QtSRqRC8GV8rslVPvo/ax7egAXcDY/Aaf2uQj4yhvYXIT886ccvxSunJwHego0JHsnVv/wbrcpujioqfW11nFnB+pgbVj/ZehPNzdqRE43D57DYCx5KjgNfOZSHqxhfjBkf+ehXepYHtY1ooz3jit00PpO/j5Kz0F0cx14y/Uyc/ZDgTvugz263ziFcTM8bcvX2vki4m5bQJcTykgRTri8avyFGwda8UE8m3+Emo+l5mAkOra8TDva3Z+XuaUXODAQ7+maDPwhTomcP8Ui6RKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qH+YouNhJHL1gQAdGBs2KbWda5DH/1+b1wCBmhM3PPY=;
 b=2+LrKDrokR46ExGGZJg07o3UwY/WKtfUcj0IBd1lwt8MCEHbh1PySwbFqhYwZ2/5bqfW8lLowHC+rn7KFZfH0dv7Gafes6QNbrJFaxZ5BlqbfZ3NTuJB7Rw84L5A1CtIiu/rBVvFmRX8hPfXHpGb678pNvhi6EGVeU+29exUJlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 11:10:00 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::af11:a0ea:b4e4:d1e0%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 11:09:59 +0000
Message-ID: <0ad240be-6e70-70bb-5047-0df2364e9b2f@amd.com>
Date: Mon, 14 Aug 2023 16:39:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/2] drm/amd/pm: Update pci link speed for smu v13.0.6
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230814101734.1149593-1-asad.kamal@amd.com>
 <20230814101734.1149593-2-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230814101734.1149593-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e600f1b-5d40-4859-6dda-08db9cb6ff65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZiggZ5TZEu3mDYpZ1oA0xUzjYbxPiKid+XjwtVAkJZxuQYS8+/ohDaO/fF9Sd1cytBK+5HEuY06kfqHTsL2DLxU0wQlJuSBud8LBq7mjfB8Hg8ETEUZkZBZjlT6OQmvz/eFL/HZwJ0fuP2ifk3N0txFxcV8E6jleGDQPpumh8T55mt6mVPn4bJpxbPSFjZ57Vo0iTMxFoJo2CP93KAkX64hav3BG1EACig5AGqd6389uLU9sZYUJRkXIKl+ilCEFkkQQFeU43j5nRSxrY0OTZnx4iROqNofVd33N7jbCcUtT5EqZUW2RS25OotPXvgwQrqi7HBG9XBwe52EFMC2C+hG5GfxnP7DVLy2pcfbLLCdOQ4HTRf+S/RNmgWFgcD22+BiWLwC/A+3EhhWa+5v+zWPbMgXOuWGhA72utsLbTcGBE+CauyEYWbTypKf7uWJ5RrUYB0yMsUsWH3v+Yyd05MqpLrGXCIjTELtO7S2WMLlRKRFgBAtoyuIkr1xUCCh2I8wCZYeEvHjnb8OBRDUAJIU/sf9Q9oUrZjJzdrTWMABIg0oC3LWSXCsP9N5Nphh0KTEHhC+ufhrhHAklnco9a2UdzwZGbPGTPEyaumqDd61PZNqokeCPlGy9t7zJEBhpVO+aMZ4OYS2nJM/ysd/Ykg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(186006)(1800799006)(451199021)(478600001)(6666004)(8936002)(8676002)(4326008)(66556008)(66476007)(316002)(41300700001)(38100700002)(66946007)(83380400001)(6512007)(6486002)(6506007)(53546011)(26005)(2616005)(86362001)(2906002)(31696002)(15650500001)(5660300002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUdRL3ovYkI2NUtzZS9wWGxYaUFqTzhSdERsQmltR0hab2hnejQ3TDREeno5?=
 =?utf-8?B?WnRCUlJrQlplQktRZnNmMVlJOUZzK1RRRWF0eEc2akxXMmtlaWhpL2l2U3d5?=
 =?utf-8?B?dkRmMWMzbmpmMC91MkNiZEhveU9FcDhaT2JhWEdEaWJBZTFQcVVleVY0aFd4?=
 =?utf-8?B?SFpaMkl4azJoVFAzY2pnSnJMNWs2R2lXbVVkTTlsa3czS2JRQUViZ3JySXpP?=
 =?utf-8?B?R3l4aFBGbUlieTcrUmNDOS81QldHOWdQY3oxUnNjaUQxSUs4bHJydWN2cjZj?=
 =?utf-8?B?elhmSENoQmE5Z0drNVJCOHVWbFpkMUZUYjEwa0srQ1ByS3ZJMlJ2VDd4Ym50?=
 =?utf-8?B?ejR6eHJGQmlsQUFMYktWTXdSSDVBVTdUbWIveVNoWGl3R25FR0R5bE84eTZn?=
 =?utf-8?B?NkJkWkVOR2hOc0R0TXlUZktXNk5JbTMrYnFuaDQ1Tm0wSlg4Q2ZzQWZwYXJB?=
 =?utf-8?B?TkVXTXNtaHp1UTdKYk84K1YwY3ZEMDhzejhRWmVBdDJWcitlN0RjcVVUQlkz?=
 =?utf-8?B?ampoKzU4bE9aNU5ib0dlYUxCczdUalJNMFZxbzF1L1g0VjBRemVROXBrU0l1?=
 =?utf-8?B?ZGVxaFFqWGo1aEtFR05QUFF0YTRPT0d5bis4QkFFNzJNRGExajVlR3VZa1Rk?=
 =?utf-8?B?bk8vY3BWajkzMlFQZjFGWGlEZVZkV3dNZTl2eVhLQWxsbFFqZ2FZWXZ0MzdI?=
 =?utf-8?B?QVNuaG8rY09KNEtPTm9LMGZKbmFValY4YmdRLzI2Z2RtUDJNeGt5VDN0UTBz?=
 =?utf-8?B?dktXTW1oQ2xSL2hxM1g1Um1EMEwwbnlFWUdtM2pkczV0d3dBQlF0a3REUDh3?=
 =?utf-8?B?ZmdPZ05lK2pWOXZDaDJyNTlzVmRyQ1hRcUNrMjhiUjl2TU5JTFhzanZyUUd6?=
 =?utf-8?B?aEw3UmZ6czcrazdkZ2VvdWZLN05RZHJZNUM4d1lPTUpDTFB1RVlvcWx4Vkc1?=
 =?utf-8?B?SGl1OXh5TVhWYXdBZ3lmYnFNa1VkKzd3U2VabWhSbmRSWm5rbXFnd2dFS1Ji?=
 =?utf-8?B?Nml1TDlSb2tLN3gvSCtFa2U0NDg0b1BScjFMVEFMeXNsaEorYUNseFZndXdz?=
 =?utf-8?B?alVZZXJraERSb0wzb21jbGE2US82VGJ5L05VY2IxVjFFRHVtclZoRWMySWtu?=
 =?utf-8?B?cnovVUNjTW85YmY0QTJoOTc1enc3NlZRK1FTeHpCRk5XQnE5a2pTSlZCd3pI?=
 =?utf-8?B?QmllR3VoRHhPOGovVVRXZVBrZ0NtNng5NitaRFhBZUtsZk9nS25manRtNFZ1?=
 =?utf-8?B?dndtQWhiSld4ODJqKzkxczB2aHVuUXE3OUxvS3BQZjdGOExLNFYrNEZCL284?=
 =?utf-8?B?VkZiZ1Y5anp1Z1pHSkc3UDA3aFdJa1I0VEtBSFdvUXdRZy9saFRpUzVoQlVG?=
 =?utf-8?B?bU1zNGQvaXNjTitSN3VrTmhzbStTRU85QzY4dGhmeW1LVkRWZ25uZGQ4SXBx?=
 =?utf-8?B?Qk5BL3VkaUJjbldUL2s5MUxTSXZ1OEMvNzdJeW5SZytZTHIwQnQ0OXE3OXBN?=
 =?utf-8?B?ODVDMjZNcTZHaGVpOFh2cmoxUjluSlArVCtmd1k1dWxFdTJPL2c4dVlPODVO?=
 =?utf-8?B?L0pMRk50ODdoWTYwcGxwaTRFQVc0L01JUG1LejBNakNGdjVGS09rZUdYNnBx?=
 =?utf-8?B?azRUaXhIRzN2TUNVMnplTWtiT2dnMGpRcEJGbWJqOStKcnJnM0JIU0dmeDBC?=
 =?utf-8?B?NjNvZUFsZkJJVUwvcUlHY2t6YktFeWUyUXNxSW40V01UK3BIeGU5T1paT0Ro?=
 =?utf-8?B?dytYS3dRZzFmSHV1REpXOW9Zank2RnEvQ3F2d0w2NTJUcnRTeElwK2RjT3lX?=
 =?utf-8?B?d2lyYmFIVUxkSHlZUzVoL2hHM0JvR2JEbjRmeGtvT3hEaEx1MDNESENsNkl6?=
 =?utf-8?B?cVU4dVJNeUZJTzZVYTdsY0tNWmVHdXZqL3B3bEtvYkYwSWVjVytzdE1iQ0tO?=
 =?utf-8?B?djNlT1dVYUZwQXl1aGFvZWxyQmk1TU5NVkdFUDkwTkxaR0ttSlJDNVVVbTM2?=
 =?utf-8?B?OE1Ba3RuclNsWTBHTi9IMmRRTWd6enJpakZFdFRyR1pwdW80ZllMNHlQaUhs?=
 =?utf-8?B?MGQ5ejI1MStvY1liSkM4K2NtdzBHWEtGQ2JvZitrclN2RmNRdWtyNWR5V0h0?=
 =?utf-8?Q?2yy7OBVVRJiA+N8NPTk6zC2WU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e600f1b-5d40-4859-6dda-08db9cb6ff65
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:09:59.3618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMB2EXMjY26PEmnrzEUuhxPFsTgdKE2RWkj+NuwGYNAGARnDJdeV8hsqBiXwGNm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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
Cc: le.ma@amd.com, maisam.arif@amd.com, shiwu.zhang@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 8/14/2023 3:47 PM, Asad Kamal wrote:
> Update pcie link speed registers for smu v13.0.6 &
> populate gpu metric table with pcie link speed rather than
> gen for smu v13_0_0, smu v13_0_6 & smu v13_0_7
> 
> v2:
> Update ESM register address
> Used macro to convert pcie gen to speed
> 
> v3:
> Chaged macro to inline function for pcie gen to speed
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h     |  1 -
>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c   |  1 -
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  7 ++++++-
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++--
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |  7 ++++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c           |  2 ++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h           |  8 ++++++++
>   7 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index 1b4e0e4716ea..a0e5ad0381d6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -64,7 +64,6 @@
>   #define LINK_SPEED_MAX			3
>   
>   static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static const __maybe_unused uint16_t link_speed[] = {25, 50, 80, 160};
>   
>   static const
>   struct smu_temperature_range __maybe_unused smu11_thermal_policy[] = {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 895cda8e6934..6863186937f7 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -83,7 +83,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
>   #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
>   
>   static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
> -static const int link_speed[] = {25, 50, 80, 160};
>   
>   const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
>   const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 48b03524a52d..f4e2ac4a8713 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -102,6 +102,8 @@
>   #define PP_OD_FEATURE_UCLK_FMAX				3
>   #define PP_OD_FEATURE_GFX_VF_CURVE			4
>   
> +#define LINK_SPEED_MAX					3
> +
>   static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
> @@ -1759,7 +1761,10 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
>   
>   	gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -	gpu_metrics->pcie_link_speed = metrics->PcieRate;
> +	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
> +		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(1);
> +	else
> +		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(metrics->PcieRate);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 21275e496852..d1a9be37bece 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -80,12 +80,17 @@
>   /* possible frequency drift (1Mhz) */
>   #define EPSILON 1
>   
> -#define smnPCIE_ESM_CTRL 0x193D0
> +#define smnPCIE_ESM_CTRL 0x93D0
>   #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
>   #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
>   #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
>   #define MAX_LINK_WIDTH 6
>   
> +#define smnPCIE_LC_SPEED_CNTL                   0x1a340290
> +#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
> +#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
> +#define LINK_SPEED_MAX				4
> +
>   static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
>   	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
> @@ -1936,6 +1941,7 @@ smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
>   static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
> +	uint32_t speed_level;
>   	uint32_t esm_ctrl;
>   
>   	/* TODO: confirm this on real target */
> @@ -1943,7 +1949,13 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
>   	if ((esm_ctrl >> 15) & 0x1FFFF)
>   		return (((esm_ctrl >> 8) & 0x3F) + 128);
>   
> -	return smu_v13_0_get_current_pcie_link_speed(smu);
> +	speed_level = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
> +		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
> +		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
> +	if (speed_level > LINK_SPEED_MAX)
> +		speed_level = 0;
> +
> +	return pcie_gen_to_speed(speed_level + 1);
>   }
>   
>   static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 690f89fcbbe3..df88206aaf13 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -78,6 +78,8 @@
>   #define PP_OD_FEATURE_UCLK_FMAX				3
>   #define PP_OD_FEATURE_GFX_VF_CURVE			4
>   
> +#define LINK_SPEED_MAX					3
> +
>   static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
>   	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
> @@ -1735,7 +1737,10 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
>   
>   	gpu_metrics->pcie_link_width = metrics->PcieWidth;
> -	gpu_metrics->pcie_link_speed = metrics->PcieRate;
> +	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
> +		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(1);
> +	else
> +		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(metrics->PcieRate);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 442d267088bc..12618a583e97 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -39,6 +39,8 @@
>   
>   #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
>   
> +const int link_speed[] = {25, 50, 80, 160, 320, 640};
> +
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	#type
>   static const char * const __smu_message_names[] = {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index d7cd358a53bd..7d0251422228 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -30,6 +30,14 @@
>   #define FDO_PWM_MODE_STATIC  1
>   #define FDO_PWM_MODE_STATIC_RPM 5
>   
> +extern const int link_speed[];
> +
> +/* Helper to Convert from PCIE Gen 1/2/3/4/5/6 to 0.1 GT/s speed units */
> +static inline int pcie_gen_to_speed(uint32_t gen)
> +{
> +	return ((gen <= 0) ? link_speed[0] : link_speed[gen - 1]);

Since parameter is unsigned, < 0 check doesn't make sense. With that 
fixed, series is -

	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> +}
> +
>   int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   				     uint16_t msg_index,
>   				     uint32_t param);
