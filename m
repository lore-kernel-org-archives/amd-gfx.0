Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E81C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Oct 2022 13:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89F3A10E963;
	Fri,  7 Oct 2022 13:51:23 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EDC10E2E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Oct 2022 13:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShnIFDSq4vpCnv40TlCl6QgSKe5fheiPTQDxmYnNIBdzA5G7UwGobAH39y5FS4I5t8c+VnMz/NfEXQxmoUJ87uhTOYKnk08UMYsXTgAbO0iRDlLbmR7cufz6Iyzy0q+OIl3zpwC/mA185LhIOeE4EDcCLey1JZ/lmlMLCs1hjMmatZlK2XufAUwMWWbWEWs2pcsavl6fFwJY9yGUj0V/MQ2/HC8NDaEWb1awenv6StrTSKkfi0eup0rvSC6s3vi5C79K5x+yvS+ZMU3h7ndJtBKCDGyfCfyUX2s0T2UjASFv33DbiVTKxxJDrqiFL3Lwww67BsoUVmwjcRI6ZCAgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKbVSU8RcWTft7MMiFBXKTGfGoA1/ShFZm4akzbcB4s=;
 b=bQdqUt+HuRz8F2YmK8hvgsExExmfzKBmiiAHOeQHFD8LJV3ShesyiF3DxXS6rj7akh3gGUFUPHPFhzteFZMSnDEFgd3QrZ/8QKfW6spKYIBj693T99Qd2i2L0d1x8s5/MYRZpdh93o5KQGd8IuN58bH77ZBsmUZt/p8gNiWjLuYe1BCAFSGNiW7MId2qVQsF5OHGXB7jjW56vFollZMTGfdo5oMXf/YMU4ohO70OpoA8KVfClBeZEjMdkIKNCag1O5s/dtGLr4wKMgtoaSgYCtKpk90UiHHFfWmw09aSRYmlhNt4OD25KrrWV2X/Ks64ii7aCDidVAo+rqW7OFaCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKbVSU8RcWTft7MMiFBXKTGfGoA1/ShFZm4akzbcB4s=;
 b=aURB4EBfOohBMhDubJjY54v3hTrRRrL2D9xuLSWr2IwWA52/Cvs4mJAQfsL+ISeDm1PMp2bORyBEQVo2N1RVxj74zak8evfioolwYtJeLvONttbn5osjP57Jkcbd6cdq0OLQeh+rzeLdORhsysDw+Wz5NsEPOVtBrgZ4Yc/7+i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) by
 SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.20; Fri, 7 Oct 2022 13:51:17 +0000
Received: from DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243]) by DM4PR12MB5311.namprd12.prod.outlook.com
 ([fe80::fc54:e514:e096:b243%3]) with mapi id 15.20.5709.015; Fri, 7 Oct 2022
 13:51:17 +0000
Message-ID: <3fae3460-f737-c266-7564-d66ca0c89448@amd.com>
Date: Fri, 7 Oct 2022 09:51:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] drm/amd/display: explicitly disable psr_feature_enable
 appropriately
To: Shirish S <shirish.s@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20221007042819.119692-1-shirish.s@amd.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20221007042819.119692-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0021.namprd15.prod.outlook.com
 (2603:10b6:610:51::31) To DM4PR12MB5311.namprd12.prod.outlook.com
 (2603:10b6:5:39f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5311:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 3561d0f4-7994-4f08-4444-08daa86b01be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF/CbDFFdeI6NRt/UTX/hRHMA237XM3/q1KJUrUfiuK6haE44ax/0JkSYXKitktfF/ZLydKjNOEM8zeo+XioWY8T6wZY71v3WIdR9g41FrukbyfMqqJFkYBVCaCAjaILMuRvXeXcAOpojSNg8hVaE8yxLfChV9AzcH6hVW5eXX8ydbIcFVom8ZHYYg5ua2Dh6sOIsgNZRt/eFZtEHmLXzL0yGrjgelGG8RhEMRCWodAB9zfrviTVUfoHjds9eQH+mBtDHgF35ks7Eio3nvYx7uyAChEOqYPTi0AGTSe0txh/68v8B03TGx8Sfc9CrxZfbNHZYxA2sdx7D2OT2uz6tIqBqVqetjeH4/nhLn1r+X0etG6c8Z7oAqwcW73/bMoy0N+7gvSjQL2apbPfVRTS1/FT/C6Jm6EX7m1qaVf7OA2tWDAZMlBgJp4LfmLcVfwM8+VqhSlrcZD9dg8eciPBUbBejreqYacbCOhN23Ak089JGaBTHNhBLRzIxbqe4phoJoEIvscrPnCW9/bayjPgML6sfYCWgxtdiCf/zNeKvZ/1hqH6yjovdjh8TMpWPvml7lECP2CY7R9YdAuw1BUISUH6O63na7w8CmO8tQpluktB4M2JdNMJ3hpZIIthwDh79319FU+CUqmeDZTPUn1CSNKnGTz8S8jAvM7NSANIIJdxgrIXodSrhnYR78da6KURJZY+3uT4nqsaVIXYfv86oIWRW9CMA4xlxaNH64pz/FXy3CpJVjCfoZHWiY0bO72X0yLu2B3zL3aMDE0YC9NkRTAfRJFRy7mbseOeHcbEjH8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5311.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199015)(2906002)(38100700002)(6486002)(4326008)(86362001)(66476007)(6636002)(110136005)(8936002)(31696002)(66946007)(66556008)(186003)(41300700001)(53546011)(6506007)(26005)(316002)(478600001)(6512007)(8676002)(5660300002)(2616005)(83380400001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlsNGw2TldkTS9KWUtsb0xzbjRxdnA2UnFkMFZFN0VjSVlxQmdDbkdTMUpy?=
 =?utf-8?B?VWFPU3FiblF6cUJ6YVpGMzUzM2xCZnFiVU5vb25YZzVXZWFlUmlTMWV2UTha?=
 =?utf-8?B?ajFZKy9IQ3dzVkxSSGVFd2hTeUpMSUcwSDdqVzVwemJkc0k0ZDhCOTFENXdF?=
 =?utf-8?B?d0NuRjFuWkEzY3BHUm5OSEhsTzNyaUR3YUV5N3FHTTlSTk1lZ2VUN3FNZXM3?=
 =?utf-8?B?b1R1cGhyWWhpMFlKbzFDNGtML0tDT3RmTWhuR0ZlZ1IrWU1FbERFdGJlL3Vw?=
 =?utf-8?B?SlVvcWlVVTZqSUY2MnQ0enFoVFVYeWdIMHRESHZBQWc3aFo0bUpaM0xZVE5x?=
 =?utf-8?B?QmZ2YURFVi9CZytZN2dUb0Q4dHpRT2ZuMVRuWGdjaEtVNStIcHRMbUdjQm1I?=
 =?utf-8?B?VDUrMFErdTlTK3JPV0t0ODJWSnlyRkx0ZnZQRVc5VVk4N3JtL3lmVnI3MXJq?=
 =?utf-8?B?aWttR1VlU3NPUjY4UEVGVHE4RVgxL0Q2bFJMeWlXaTdZUUgzdVdyd2ZZVGxP?=
 =?utf-8?B?ekdObUpLSkp5R3Zya3dkYS9IeHAwYnAxY3c4Z3VWWjlNb3J2RUt6enM4Z1By?=
 =?utf-8?B?UE83K0lhR0grRjlDMndjRjU0aGpUeTVwZWdWRjFDR1BhTXhmK2xtcFBYd3FH?=
 =?utf-8?B?NUt6cFU3U2dSdUwvTGg1cStBdDgvQzdodEJzWnU3eDlCWHI3NWovcUE4Q2o4?=
 =?utf-8?B?NGxnRDlZZjFHOGt2WkEwY0FwTUU0b3gwS25tdU9ybk1nMWc4VmdWa3ppUzdM?=
 =?utf-8?B?c3dFOGZmbWVaWDU2R0VKcTEvd3VqSC85L2M1Qzl4K2RSQmk0MmVQalAzK0ZJ?=
 =?utf-8?B?cHFKVGl0aDJoNU84L3d4RG43TzAxRjRtU3FaQ1JEK0tuNVNFdDVwRk55NmRt?=
 =?utf-8?B?c0l6NXVTQ0JpcmdMcXZqeVlEcFdjOExNdGpsR1NNODluQmlRUUxjRHgxaHJX?=
 =?utf-8?B?T2h2RTFEdEc4T2xkTDU3RWdMelI3cWNZZjA1clZJWWVVODhoZ3FJOTIxdnFs?=
 =?utf-8?B?WGdKRDZEVGRUY2p3cGtLcnJLVStKUysxbk1WM3UwQ21qVU1BK3crODduaUNH?=
 =?utf-8?B?TUphbmI5K2Y0VVUyOFJXM0JGLy9HZkVYUk5XK1J6WFo5bXJBRkV3ZDltRHhM?=
 =?utf-8?B?WllWcUlzNjByRkk5TWdLcnpaT3VaMkRTdkdHT3huZnMzVlhjSDNQaGhkcWpt?=
 =?utf-8?B?ZkhISVJhVGdyMXZWU1VRSVNQN1VrcWZETGZNaUdTVjhYYlZ1aERub3VmUDdS?=
 =?utf-8?B?alNZTkRSNHU5U1VsdDY4WFhIL2lUalJlbDl2VzhmRDhrdFFDSEZORzhxZks2?=
 =?utf-8?B?eHoxRkh6MkltUTlBSDRqb2JLTlBEVW1mY0lJMHAwY3g5dklCejRjbnlneWRY?=
 =?utf-8?B?RWg0MmovWTlLdG10dWl0d2VQYzVkK3I3QlA2T3dIcU5RUGx6U0c4WXpJNnVD?=
 =?utf-8?B?YVVJUEtJZWduZjh1U0IvSnpaU1QrR1lDMjRQK1pSSVN3WkEvckMrcXZleGlI?=
 =?utf-8?B?dHByL1gxV3MrODMvNHRIV2JrTHowY1ZKTDhtQTRsa1ZHQ0o2OTdWSWVqaVZS?=
 =?utf-8?B?bG5BYldUQWVwSFZMVEZMNm9HRTdtbnZhSzY1YTM2YnJUMmM4eGNxSk90ZXFj?=
 =?utf-8?B?QU4wSWxnMEpoL1h3QXROWHViRCtxaVF6R1MyZ3E1TzQyV1lBTGNQekg3UVZJ?=
 =?utf-8?B?czlIQWV0eUZSNGFwWWIveWRaaWZBd3dGdzFpanRxYTRWYUZrUVMrSXhWN0N0?=
 =?utf-8?B?SWNlczViYzhGTWlKUTBVd1lsN1FYQmJsL2VNVW5zUGZQUURZZGpDNGg4SDVE?=
 =?utf-8?B?ZmJnVjc3K2oyZzYxd2xiTHlMTVBqOWxKTkd0aTM0RTlaQ2dhRXQ4MGdFSUdP?=
 =?utf-8?B?U3VhL0NqcC9zSGlLWmdKTk9ZKzhGK1JqdjdXZGQxRkx6aktabzhQVUVJMDha?=
 =?utf-8?B?dEFteExjTnRIa3NMdmUxa0ZDWlNmWUxEMWNjOTFSendoeHJIbWwwTkEyRHNH?=
 =?utf-8?B?bkhtKzNqekVCWk1NRWtQUnp4Ui82QkxKTnprdm9Zc2E1cHBkekpvU2lSU0Rs?=
 =?utf-8?B?K0xNNDZaMHpmTzJmQmkyOHlJVlNPaE16L09OalBUTnNxNG9xQy9lVFQ5MDRK?=
 =?utf-8?Q?DQBM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3561d0f4-7994-4f08-4444-08daa86b01be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5311.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 13:51:17.2121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXcK0iEwiG4Eow0/RG8DO1sFjg6b9FcuwNzWjuh14nM8tAQBE2/65oXzTHdHP2m1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
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



On 2022-10-07 00:28, Shirish S wrote:
> [Why]
> If psr_feature_enable is set to true by default, it continues to be enabled
> for non capable links.
> 
> [How]
> explicitly disable the feature on links that are not capable of the same.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> index 8ca10ab3dfc1..26291db0a3cf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
> @@ -60,11 +60,15 @@ static bool link_supports_psrsu(struct dc_link *link)
>    */
>   void amdgpu_dm_set_psr_caps(struct dc_link *link)
>   {
> -	if (!(link->connector_signal & SIGNAL_TYPE_EDP))
> +	if (!(link->connector_signal & SIGNAL_TYPE_EDP)) {
> +		link->psr_settings.psr_feature_enabled = false;
>   		return;
> +	}
>   
> -	if (link->type == dc_connection_none)
> +	if (link->type == dc_connection_none) {
> +		link->psr_settings.psr_feature_enabled = false;
>   		return;
> +	}
>   
>   	if (link->dpcd_caps.psr_info.psr_version == 0) {
>   		link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
