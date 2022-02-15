Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B094C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Feb 2022 19:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2E410E535;
	Tue, 15 Feb 2022 19:41:40 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E62D10E535
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Feb 2022 19:41:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTL5/eiKWE27QMH6tvAsq96cfNYyBLvSMTaU+zTmIjU+shn+ENUtAaUybAQ6GPy4ei/xZtpy2XJ11zzgR04ZmN4VvxYj2FCU4PeJ0KRx5rIM4G3bo8QfFJ3Sgt8Dtd97ZEMIStt9lsyQ7ThSe4Wj1LT+4hszy4RNk8hGJro1en15io7zw6hyUypKZpLUGVdz1X2jvvtztZZBVLPUq5ULPGSsvrIT6a+eFXKUPmSAI4wvF9+xWHKbS+rP3N8CjibiSOHS7LYOfPUXoLIvujrn5j+8c9bX1EoEh1qlTGXFwu1seYXSdUIEd7wMOCulctr727uC2P3L6eQlzzTM7rBRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22x/uLzjd66QWrmEEYaalbdCCJMH9EA3F/76nCrH0NE=;
 b=fqMdKRMZA1o9wAzGHTiAYUe8ZuabzL/s5MW1YCVxTo7RNsYmci9r51Dnsz4FEWiW8er6m6awa5Jp1D2hhZVDBZK0SgdDRibHp+Pk9SPkmnimgSeLs9KqE0uliuSf6NToE79y74ThDrcCB7Ff+uAwea6Eno5e5mqewGh5icW7u7sHb9Qzgtsd5HkWVdtBdbMdjddZCt8Sul+5eFQgJ5JIAOFT88wKk/h/UZD4X7JKZCox3dd3sA1XCsn4/zrlR0N4tuNyBtChGj0+LzT/MX4ukaXa4smL9uuA15E0QRRIbEUvZ3QqgxUw+JGALLXNdw1EAbUSC/yOo+3TmXtjQFSeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22x/uLzjd66QWrmEEYaalbdCCJMH9EA3F/76nCrH0NE=;
 b=VeMzyX0AeEK6YD4m4K/9jmlZ1snyda4git+vA7w1RCM9KkX4ZKdrJtyx7PEz8ysORWZUaJxPBsNjmtV8dfG87RnU2csgDhoYfebPamMsqD4CAfpyjvL+FWFpwgctgHZGjOLiVOMXXeBgr4qG/T/NsDn0eiGSks2mXcYaPqDes+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 19:41:37 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::dd4b:b67b:1688:b52%9]) with mapi id 15.20.4975.019; Tue, 15 Feb 2022
 19:41:37 +0000
Message-ID: <a23eda9f-f1a9-4884-360e-d8d22d3b81f6@amd.com>
Date: Tue, 15 Feb 2022 14:41:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] drm/amd/display: For vblank_disable_immediate, check PSR
 is really used
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
References: <20220215185337.1873778-1-michel@daenzer.net>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220215185337.1873778-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::14) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8787f03-d20a-4db6-0875-08d9f0bb2e33
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB41264E7F2FE1099BC11771798C349@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mF+lolQvlVQh8ZTpreKzboz+2KFJt55jGbPvffYErEr6CVPZ5MlKSJGhuKNOwIoVF668u3qIaFrOAu98jeCmmN1W+KLpOA7+aSEXb+dUoUvGdF6WvbxEP6f/ULBxSdBRWcfU5cUk7L0tEOLsFQkVeteJoPcTxCES7bID8kIcKhAFcQJePL9JuAiXF4pCJeMnyMksaOHpLd5Uc04dWf4Zk7c5pxatjJWKliiPFSczTOCTmTiWfDjgv1quSeCrP70kYIrhJKU2mHBFfXJRHM7i+IqAnVpy3HYjbjTfe+lpV//NOLwRH8GvIHIGrYbqyKj85T5m4S9G0SFiNJY1ivUMDtv/Te1HTkcAAdH5xH7cg5XvhrPQSgD6lF6pw/2ufOAcUkCsASO7i3gsxfWIAWaIZJZ52fRbNjIOeaEAIYwgwdu730puUgoM45vwhRRcYNiKlWbwfjN8FTQZ9IB4EdFsJu82aUpW1qu3CzAbfD+ZEOhr1oyb2JZTq4nky0nBMBY6Rc1FRv7HT/4LQJ8UPLQGMzwKZbr0Qxp3mXzFaby9Q3dwCL2KNUycb2Q2UOKxggKLCq0Ok4npa5NfkKaJLpE5ZaZfaoeU3rhrlbU9eIJSa3d5gB+1yktChMPkyd2IeG5SSBC5u9PkTGaT+14DEgBPA/h+R8Q2ye8S7LUphdjq+anZPwE2WAnfOq3DBQyy54Uhnl51zVXL0JOlyezA1OAuwlvpwq7X0kPQkkdZo0dplisafRjI3r3AyjCWHq9yVmyrGXFBqWBaZF8CB6QoUIP4rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(316002)(31686004)(66946007)(6636002)(26005)(36756003)(66556008)(4326008)(66476007)(6486002)(186003)(2616005)(86362001)(31696002)(8936002)(6666004)(66574015)(2906002)(6512007)(110136005)(54906003)(508600001)(44832011)(53546011)(8676002)(6506007)(5660300002)(83380400001)(14773001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXkzc0R5cG1JdWFWK2ZrT0R4UHlzV01jZlVmY05tZkZ6UUQ1MGFRYitnTE11?=
 =?utf-8?B?RXlMcEZVOGhVM0FvMFRUa09IdEVJR0JvWVN2SDNqVXFVUnl5Z0xoZUhUeEUr?=
 =?utf-8?B?K0M0aW9TTWdjeXRXT0hVYmpvZU1tYzNOTTFrRnUrTXF2Mjhnc3pxTGVGZ29N?=
 =?utf-8?B?Sjd1R2pqS1JIMmQ2NlJ6LzlGT2lveUEzaEp4K2N6YVQyY2JGbStyWTRJclNZ?=
 =?utf-8?B?SG9zeW1YdUpFazVjMU9nWUV3ckJ2MnMyM2xxSzh5WkNYdWE3bTJYK0s5clNn?=
 =?utf-8?B?d3pqc1hZeFNBb3pzTEFyTGpjVDRUTjdiRUpNQ3hWR1pzTG9jc3FwTUNPYXJ5?=
 =?utf-8?B?UGJubGF2Q2pYNU9FSXdad0Jkb0lTdnVvc3o5c0dTQk1USFNVNWdtV1NyR0xt?=
 =?utf-8?B?ZHpCRkJuRUtpZTBSUko5dDVScUswMHlRWUNPS2RCclJvTGFzcE9IZWUyK2R0?=
 =?utf-8?B?bnNXbFgveG95dUxrOW9hSEkrQi9tWE55VmplZm1iZjh6TWE2TkljT3Nidldn?=
 =?utf-8?B?MUlVSHF2b24xSGN5OFg5TU5FcTIwZTZNczNZNzFBQmtRNzlzK0VNUDJQYjJ3?=
 =?utf-8?B?dXVEcDBBelM3cWJib21NdGtaQnpyL0pneWdveU1BSndOSWlCdmJ4ejUrK1ov?=
 =?utf-8?B?cDN0eGJjN2JXWnFLeXd3eEZGYSswR1piMXliVm1tM0VmV1F6c29UZXNGbDUw?=
 =?utf-8?B?b1ZYTTBBdU1GRGxURXdKYXlleU1rc3Y5MTIwcVJobGgrMlcvV0VtV1RacWIw?=
 =?utf-8?B?MDg0UTlyQVZRWVlDdnpKMGs0ODErMEZic25UZnVsVlgxSjZGQVNRNkRTL3Jx?=
 =?utf-8?B?YldUcmlMeXd6bUhYZUlCM1lBeTI0TzZtRW9DdnRhTnpsbzZ4UEhUL3lLWGZq?=
 =?utf-8?B?RFh0cjk4QWE5K3VnbVJnS1RuN0FCNzVuM0hDWFBkNHFaYVlVVExmMWQ2bWVV?=
 =?utf-8?B?STI1bUQyeldGVWQxK0xKUnZQMlFjNytNOFJPMCtpUlRzenhZV0ZpWUQrcU9F?=
 =?utf-8?B?bUk2Rm1XZXU0L1ErZ1RHQytkdDBQcUd2Z0NFalRTdThqWUdHeCtscm5GUlZF?=
 =?utf-8?B?ZW5UNElIdXpSMjVJQlVVbDViR29Lc3BiK2ljdTh2SHpnWTRiK0Nzdm94UGEz?=
 =?utf-8?B?ZFU4ei9LaWNrdjZaMHNta2tPSEJBQ1dRbmE0Z05seU1EMDg0a0hlWU9mUG5k?=
 =?utf-8?B?azV3WHFmMkc4VGhGbmxraDFqVHdsZkdEaDZVSG91dFVCZE9PSWhUeDkxemg0?=
 =?utf-8?B?RllaZUVDbDd1b0l4ZXZha2UxTjY1S2x1T2tqU3dRM05xck9BNFh3TGZjZHFW?=
 =?utf-8?B?NmVTekpNOGhCQVVIcHFqWVQ3Z1U5UXhRb0N3NXlVUzU4MkQ0eWluVVlDaGVy?=
 =?utf-8?B?bzFrL1B0cG14N3FZSzJ2REZzc2Q2djNTZmVyb2VjY0FNaWdDbHJ0d2cvQ2tP?=
 =?utf-8?B?T3FSQWlhVWlNRk5HU1FkV3I1YU43U2trRkE5S2dLSW12bmV1OTNzQ2hCdTN5?=
 =?utf-8?B?czFYbTBrZWVaUHJvakdLRFIrdm52QjdZSlVCMk1ZTnJzOVV1VnBsUG9YMmx1?=
 =?utf-8?B?V3UzdXQ5VXViekZyZ1hkalozUEVLcmZRbkgxTEJGcVllcUo3YzhlN2xiZjhQ?=
 =?utf-8?B?eENtbHB0cW96aytETVdkNmdxanFKTGlHMlNPQnkyVk4wS1FTU0RFM0VGSGs2?=
 =?utf-8?B?MVp3SkZReE9WZXZCQWFqL3JKZzl4SGIvcDVtL01mOGVFYXNkSmJJVlFocWdG?=
 =?utf-8?B?bGlua0NpNThYZEY0eVpXOVB1UVJncGs3ZmZ1YWVZQUJnWThjNmdSYUFJUFZO?=
 =?utf-8?B?eENra2Q2ZExXcDFsZEdFQ3dJNG9EaEJCZTNZd2MyMGczc0srOUJROElRM1FM?=
 =?utf-8?B?bUN0am9BYThNR0RPM1M0YThQS0V2c05lMDFDQ0VoWCtSRlRXdzdiUkFjaVRE?=
 =?utf-8?B?MjcrZlpxQTlTa09BdEZkN1lnRkJHcXB4Tkx2UlpoZHZodWZGM3FIS0xJK1hJ?=
 =?utf-8?B?MDd2YWdqV2dHNGNyaHpCNnBVY2d1dlZvcDRpRTRWeDVyTnV4RENiK0tuSkI3?=
 =?utf-8?B?d0tuOVJET2V6ZDlTdTd5ZjRwTERXSGZJVXkwQkxjeVVmaUUwNFdqU0ovNmly?=
 =?utf-8?B?RGcrN1pmVUdLN012SUVkcEtTMGtLZHJGMzBXQ0FONi9yMmFZM01PeTZqWSsr?=
 =?utf-8?Q?kky1Bl56CLv3IfU+T7mWFTA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8787f03-d20a-4db6-0875-08d9f0bb2e33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 19:41:37.6157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7WSE5/p6Drp3BxsYhWVzxPXn6fJjtiwQgxKgEmH25spvG2d8uWmVgA7haLQ69wgyzCC9fO2kPafrbZ/sVihTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-02-15 13:53, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> Even if PSR is allowed for a present GPU, there might be no eDP link
> which supports PSR.
> 
> Fixes: 9b510908e420 ("drm/amdgpu/display: Only set vblank_disable_immediate when PSR is not enabled")
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

Looks reasonable to me.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index cd8b0d9eb19c..df86517dd532 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4256,6 +4256,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  	}
>  #endif
>  
> +	/* Disable vblank IRQs aggressively for power-saving. */
> +	adev_to_drm(adev)->vblank_disable_immediate = true;
> +
>  	/* loops over all connectors on the board */
>  	for (i = 0; i < link_cnt; i++) {
>  		struct dc_link *link = NULL;
> @@ -4301,19 +4304,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  				update_connector_ext_caps(aconnector);
>  			if (psr_feature_enabled)
>  				amdgpu_dm_set_psr_caps(link);
> +
> +			/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
> +			 * PSR is also supported.
> +			 */
> +			if (link->psr_settings.psr_feature_enabled)
> +				adev_to_drm(adev)->vblank_disable_immediate = false;
>  		}
>  
>  
>  	}
>  
> -	/*
> -	 * Disable vblank IRQs aggressively for power-saving.
> -	 *
> -	 * TODO: Fix vblank control helpers to delay PSR entry to allow this when PSR
> -	 * is also supported.
> -	 */
> -	adev_to_drm(adev)->vblank_disable_immediate = !psr_feature_enabled;
> -
>  	/* Software is initialized. Now we can register interrupt handlers. */
>  	switch (adev->asic_type) {
>  #if defined(CONFIG_DRM_AMD_DC_SI)

