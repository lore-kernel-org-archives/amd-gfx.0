Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54D2C64EC4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 19:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505CD10E44C;
	Mon,  6 Mar 2023 19:49:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C72510E44F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 19:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnGffH6WLv1oN5e2dzSLrb4TUZ1H7Xvu1nuhl23SmAF8H7pxVmwtULUjmHf4lYP3oGAte0QC/ZplNNvt91C28AP+R2Gg32zuIF+hMXYQNM1hAu588wrBrxCSnIP3l/POoeb2XFQ1l2m8WQwgVIYOZaK/5IFRBbhOUwwhRBk8UGVHUqRyhfYDqEVDZQI7KUcyGmZTmx2r4m8yuj5foqbVpotYhi2Bl55eFqq0S108FsiQAqScmeEVVjVWRs2AGOY6RXcH3o7svzoJ4RjtN63SZjuCzSPDrTliBRRuZ7k2ThxIRzAD1lQ9GP0Agooa4KgGqe9swcSM1ULTU2xJHeDG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BIGGfCsAQy/cbjngNDKvt1nGAODWKCUQH0J4IcLmsA=;
 b=mI6M0KATHIzeDD6Nrz06gcTRH8wRPfC2VjqOCAsDOMgz/oiV4jdn7fsWZGkMyO+aDakSwj3dtR2czgzpYz+KwdIeELoqX7EKNLFYS4nfQ463THq5wS8Nc3AtweHuxWZBAS7hlvx64ZU0KhZ/HGjSajbV7v1xKy4XJ8Ivyqqjy9iIBJ4D/+QXPt83CAx4cM7YO9gyRNxSBmPZgZE1F4dg8kMB6WrQAEZZ51dDon2+QmwNrmP2giFNMuovDqoAIOk/MIcJT99tCa6kqDoQJ0u0OwBwmwOGjukh1rgofAnsdm6KBMbJxeub+dAHdBdTNt8RGEwn3nWplj/klt1rcWXrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BIGGfCsAQy/cbjngNDKvt1nGAODWKCUQH0J4IcLmsA=;
 b=e4xKmFR7/9YMLJcNlnMWEMGN2aCusYQr/c5MMxGsO2Obf9yfXi2Vg7sbbmAj90WdxRo2x+Dwr1nmWvAF6/rrAOMoWv329qqqnkxq6EqDch0H+SInI6xr6bg5a4dAMSnt23U/Uvv4QI3/gjCIt0+tWbiHFNdlOdLvVCk1j1SH018=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Mon, 6 Mar
 2023 19:49:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 19:49:37 +0000
Message-ID: <88948047-4f96-67fe-4135-1b385c4a1234@amd.com>
Date: Mon, 6 Mar 2023 13:49:35 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [v2] drm/amd/pm: Fix sienna cichlid incorrect OD volage after
 resume
To: =?UTF-8?B?QsWCYcW8ZWogU3pjenlnaWXFgg==?= <mumei6102@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20230304234431.29507-1-mumei6102@gmail.com>
Content-Language: en-US
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230304234431.29507-1-mumei6102@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0003.namprd15.prod.outlook.com
 (2603:10b6:207:17::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ab37db-6236-48aa-c123-08db1e7beb00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8ybxGp49sP8PqrealRkaMcLE7XnQKS/Dpb/HAmUG29Qtf2wknGLhszJTPvAXt8lf1uuVzQHTirQ3ZhV/akg2ovv9kULIoL/XnE+oyqIKcI5Pibi+7xh7WUOQ5fOMzK0WP4IDKXk5+thwPLjQTcrurhuaiLTis+aXPiHcUQ3682xW4E8J4TZoEosnFGVdbEugE/oebo9t1oXLaSi+LOD72JVCAEvww6UVkHmCWxj3o3X7v2fSMNL2yAb0i6kTWnI0ddObytcUWwAGGXD9g+QR4p05UDsOseddvYAcuV1Rl0neb5jxqbaX+2YpI3B17duQ6krGxExoAkvp7TP8WRWvJ/Le5tUoQj0+7ZCwMWgxWSxVSTClpkiRimPBlugxIIjEIYE8wXfi/OPQ6LadFdEGzqJ0+F2gacumuoGNxF/3ZngN+X4y6SNm8WGdcu3ydrkBp/+oDgQtiWqZkODMFg6yca01xEyrDSjKvvNhTY5rLBiM6n0kD5L6+S253uLKmhtTpmDjLQQohOlZ9ormZCgNvQ2ICRMGKvn/P5MMB5N+mCIqvVOymoCViJr1j/piMwKJpGXgqTR1czurn8r1DZc9IxuCxThyYyhJssMCWqTNabB2WC8XQQgKX+cvEceH0eOo8SSxmDfVKFdzxwh1qqjfVm6uYFTJF1AAfQW8bEDLGfUdXJC/Xt+YH8CfUXrYcypies68LnhBsmjPQHEtdSczcsRfLDGFq5mAgtjSjeaAXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199018)(31686004)(36756003)(316002)(6486002)(83380400001)(31696002)(86362001)(186003)(5660300002)(2906002)(66476007)(8936002)(66556008)(66946007)(8676002)(41300700001)(478600001)(6506007)(6512007)(2616005)(53546011)(26005)(66574015)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0hhVHphQjYxczZScmV3U3hyU1FrQVpzL3NvNDRSREpQVVdHSDhUS0k0Z0VY?=
 =?utf-8?B?R3NESWo0ekszY0IvRzBmN2FUdVJIb05IZWFMclArRHUreUNqeHBCK29mRFQ1?=
 =?utf-8?B?RlRJZUhPdnBSdkdGYTR1WjAxQXNDOEpiMFZSeGZGZUtybFV6Q0lyWnBiWml4?=
 =?utf-8?B?ZzI3RWRsbUsybVI3V0duNi9oVGRHME5FQVBhUFQvbWZNL0xEaDBraks2ZnM5?=
 =?utf-8?B?Q0ZTZ3h3aVlGN3p1SEtaTHVPdlBLTnJwWjg1VmFXYVU3YnVYdEZHMnRCWjZz?=
 =?utf-8?B?b1pXSEZ5R3hpRUZ1VUpQb1o4OTk4bXc0Z1VzQ2lERWFIVjBnaVFkMXhEVHBB?=
 =?utf-8?B?Q1R1eFFUcTN0MFZlRHhzem5FN1ZveS94bVAvbVhVeGFPNnJmdEh2bGtZODZC?=
 =?utf-8?B?REQ1emVOemhsY2VhSTVzd1dDQkxXV2JqWWJyUEQ3d0F6OW9KWjhJZXdRMy8x?=
 =?utf-8?B?SzNLNGhKT044TGNTcUh4TjhFMTBlUmxVaEtBVG52TWRWQkVmVEsrb0xNWlZw?=
 =?utf-8?B?dm82T0ZndXFrSzZXVEZBQmVUZnY1Q2l1UVhWWmlpUkIwcVc5clZidytEVW54?=
 =?utf-8?B?aklhdW42WUVQazEzKzJENHphaXBFVkVUQUQ3azlLc1pvWVhoYk9pOHdLd3FO?=
 =?utf-8?B?akV0K20yOWJ5S3NTQ01QQ05udnJ1bTRlNDJuRldOVVZBdmxCeXBXNk1KUC9p?=
 =?utf-8?B?eEkwK05zNXg1RzY0RDNzSU5NVFdZUWg2dFllcGdXMDlRM1B4Uyt5UlB1Q2VP?=
 =?utf-8?B?djdBZ2tnTndneEtyQkpwaVhkYkl0VFdWV1ZZSkloaWVJUW0rVTJuUEhlU1Ra?=
 =?utf-8?B?clRPRG9xYU1LVmdFdWFqREI5MlVwZ3laQ3Y3Y0o5NHMyVWI5Z2lONkdSOTVr?=
 =?utf-8?B?ZmxHTUhwT0RHbHp5c1RUMFJkN0NjbEdnMlFOYlhSa2FEM3ROckdNdllmbXky?=
 =?utf-8?B?b20yaTZpWmZKVzY2YTREcnpseERjMFpGRnJKS3MxS3p4OFcxTFRNMlpML3RO?=
 =?utf-8?B?akUwMFIvK045bFlKMHVMTmpwdCswcVZmLzNlR2VCNFZnYXBoS1o5ZkpoUk9m?=
 =?utf-8?B?UFFSbUd5YzZQdFNPdjRRMlh0dTZYenJoRHFDeXN1akZPNWlacFBrcUZmR0Z1?=
 =?utf-8?B?U1lFRG1wR05QVW9ZVHZhSklYWTZ3cGU3clNwTTBmMFlPUEZOTk52cnh2WU5B?=
 =?utf-8?B?VGNlS2NNUUtzWUh6RlpjSlc2WEFPNEpUN3ZCR0g5NTBjbjYzT0k5Ly9VUk1y?=
 =?utf-8?B?YU84T0hlV2dRVGxGVmFseUNSbFltcnRqUEh0WWU0THM0K0QvOTNsK2k4clFq?=
 =?utf-8?B?d1ppbm0zdDZjUEd6TXlCMGlMdU41YWlQdHhvMnU5ckpFMERFYkNBNE45YXhS?=
 =?utf-8?B?ZUMrQW12WnM1WUJxWGtlVHRES1VXTFRySVR2U2xLYkR0cEZ3OTAzZThJQzFX?=
 =?utf-8?B?NEJpTG14WHRJVGx0aHhnTzlnbC9wVTdWZ0Vaa1ZSeTdJVFpvNWdBN2FqTkFJ?=
 =?utf-8?B?emhlT29iZ3ltSzJ4bzV6YU5kdXdhREJJSFRGQWF0ekl6YzN6TDE5Ri82WXNO?=
 =?utf-8?B?VldEMzdncm1BRWpXbUpPTXc5bk5TUkFHbTl1aXVwdzNrbDlMU2tISk54QkdE?=
 =?utf-8?B?U1Z3R0lVMWlYWlR3YU1LVmlrdzVhN1FiK0M2Y2V2NUVKWjQ5VUo3bDZqL0FC?=
 =?utf-8?B?eHlrbG54NkhjbzE0RUpmZ0t6cnRmaW9TYUw5azdXaUtXMHIycld4cFFKODZj?=
 =?utf-8?B?Qmovb0hPK2NnbUt3Uml0STd6Q29ISnBRRUZLTGJDVm9IODhQSE4vbkltYVR3?=
 =?utf-8?B?Q2xCSi9MaVFtZXl6MEhmSWRnRi93bjNJMjJINmtLUDV5RVFZNDB4NzNGNTZo?=
 =?utf-8?B?TWlXd2ZtUHQ4aFdrakorRHN1aGZacGhkc2V4Y0JtNTloK0UxM2Q5VlhyWXRh?=
 =?utf-8?B?NkZHbGlZTCt1MmliYXdEOHV0aVVGWlVJY3B1TEkwbkNvUU4yME82Z3ByT1pn?=
 =?utf-8?B?RVoyK3lWZDd1UkY0VFhZS25BSTlIRnFnMlVyRjZtVVZoUy9OOWp2UHpvOFIy?=
 =?utf-8?B?YkxCbkU1VmgzTGp3RFh1WGl2bkRmSzVxT0dKSTZzc0xPc2Y3OHF6Wng1cGNk?=
 =?utf-8?Q?1dhd3PWX/4AmQRRqd6nRk1gcH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ab37db-6236-48aa-c123-08db1e7beb00
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 19:49:37.6812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtnnXzN1nBlKuZtm3rDCHo1jOY0Nq0ybiZ2hk4TE87BMrljvyDBSn7raMDnJCOuS6k3T/RjI0kicngYDqHuBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

On 3/4/2023 17:44, Błażej Szczygieł wrote:
> Always setup overdrive tables after resume. Preserve only some
> user-defined settings in user_overdrive_table if they're set.
> 
> Copy restored user_overdrive_table into od_table to get correct
> values.
> 
> Signed-off-by: Błażej Szczygieł <mumei6102@gmail.com>
> ---
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 43 ++++++++++++++-----
>   1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 697e98a0a20a..75f18681e984 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2143,16 +2143,9 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
>   		(OverDriveTable_t *)smu->smu_table.boot_overdrive_table;
>   	OverDriveTable_t *user_od_table =
>   		(OverDriveTable_t *)smu->smu_table.user_overdrive_table;
> +	OverDriveTable_t user_od_table_bak;
>   	int ret = 0;
>   
> -	/*
> -	 * For S3/S4/Runpm resume, no need to setup those overdrive tables again as
> -	 *   - either they already have the default OD settings got during cold bootup
> -	 *   - or they have some user customized OD settings which cannot be overwritten
> -	 */
> -	if (smu->adev->in_suspend)
> -		return 0;
> -
>   	ret = smu_cmn_update_table(smu, SMU_TABLE_OVERDRIVE,
>   				   0, (void *)boot_od_table, false);
>   	if (ret) {
> @@ -2163,7 +2156,23 @@ static int sienna_cichlid_set_default_od_settings(struct smu_context *smu)
>   	sienna_cichlid_dump_od_table(smu, boot_od_table);
>   
>   	memcpy(od_table, boot_od_table, sizeof(OverDriveTable_t));
> -	memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> +
> +	/*
> +	 * For S3/S4/Runpm resume, we need to setup those overdrive tables again,
> +	 * but we have to preserve user defined values in "user_od_table".
> +	 */
> +	if (!smu->adev->in_suspend) {
> +		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> +		smu->user_dpm_profile.user_od = false;
> +	} else if (smu->user_dpm_profile.user_od) {
> +		memcpy(&user_od_table_bak, user_od_table, sizeof(OverDriveTable_t));
> +		memcpy(user_od_table, boot_od_table, sizeof(OverDriveTable_t));
> +		user_od_table->GfxclkFmin = user_od_table_bak.GfxclkFmin;
> +		user_od_table->GfxclkFmax = user_od_table_bak.GfxclkFmax;
> +		user_od_table->UclkFmin = user_od_table_bak.UclkFmin;
> +		user_od_table->UclkFmax = user_od_table_bak.UclkFmax;
> +		user_od_table->VddGfxOffset = user_od_table_bak.VddGfxOffset;
> +	}
>   
>   	return 0;
>   }
> @@ -2373,6 +2382,20 @@ static int sienna_cichlid_od_edit_dpm_table(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int sienna_cichlid_restore_user_od_settings(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	OverDriveTable_t *od_table = table_context->overdrive_table;
> +	OverDriveTable_t *user_od_table = table_context->user_overdrive_table;
> +	int res;
> +
> +	res = smu_v11_0_restore_user_od_settings(smu);
> +	if (res == 0)
> +		memcpy(od_table, user_od_table, sizeof(OverDriveTable_t));
> +
> +	return res;
> +}
> +
>   static int sienna_cichlid_run_btc(struct smu_context *smu)
>   {
>   	int res;
> @@ -4400,7 +4423,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
>   	.set_soft_freq_limited_range = smu_v11_0_set_soft_freq_limited_range,
>   	.set_default_od_settings = sienna_cichlid_set_default_od_settings,
>   	.od_edit_dpm_table = sienna_cichlid_od_edit_dpm_table,
> -	.restore_user_od_settings = smu_v11_0_restore_user_od_settings,
> +	.restore_user_od_settings = sienna_cichlid_restore_user_od_settings,

Rather than introduce a new static function perhaps it would be better 
to just change 'smu_v11_0_restore_user_od_settings'.

That could help this issue if it also occurs on Navi10 as well.

>   	.run_btc = sienna_cichlid_run_btc,
>   	.set_power_source = smu_v11_0_set_power_source,
>   	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,

