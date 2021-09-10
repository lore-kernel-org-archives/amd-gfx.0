Return-Path: <SRS0=y1ja=OA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2E5660C51
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Sep 2021 08:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2E5660C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C6C6E9A4;
	Fri, 10 Sep 2021 08:47:25 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81A7A6E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Sep 2021 08:47:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktCIJ/j8K6u7sNY9r7dgQpsRO69zDKTFWmgLk385GV0PyoPM2PXD4AEZdNetiEN+gQsgKMxc1Ex9G08+jy8fuoZMzJb9iqIaF9rEHEDjm35N7xF3SwWdWyaT/NJwAdQKr/mf521WEiTekT75ZvY3iGksctTlhTnvPnkWXL3xoBAtaw4ZMbaZtMFSFEdLCdChRywJaCxxZ9ScIu9sAyi3aFf+XPWC6TJmDRGt6rOPRI4Z3610o7hO1nMVZ/rW0dzXaEQiwX97dBhNykB76FBjQ7p5EGduhqwEKg5+oWhBLBfxgT+hvMBYBlOnc0mzF/8cGzQr7MhlrgRwG0K6Rt3HGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=O/hfeC8oSyp140JQ1Ob1Sx+rTu/Bqp3FUPR8k+Y5Exg=;
 b=hY8ABPuKishfAyWLM4gWLRg2UX/SVBsDykQK7zq5jvskg7kMqpB58NYZLd6mQvVm8+fwLCYgWvy/CbU5zPNCG0OvdtQwALPK19jKoHAgCZGJPRwq8ES/4lmnGOxDQw0FcVVq9kPSJQppt3CvyN6YfWI2ScU1rO1D5I6IS087oKtuwa0qS7ldhnfJxJXQJfVtDRD1QL49dCsukKZ/SrqY33Gbm8h0p7gkShjIPBwjn3eimiae4O9KCw0UZQH1+PsKqnx63Tztxj3kneSy2QdifO5r+AculzHpz1EzBLU1NqnwdSLpBVxo2ar41+9EtwTTMMaDPz9bWbYXnUIhPmZKQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/hfeC8oSyp140JQ1Ob1Sx+rTu/Bqp3FUPR8k+Y5Exg=;
 b=1X13bCHz0Bc76eoY2LJ7VSstFqOBpwbkUdH0CCbv1x2V9m3PTbqDQXMay8hw7nG1Q1fXzOBlpVQnFcnmQ0HF9bwHpal3UNLAZU20ofe7mpyha/N1Ub5CtjTw2a2aZEvHGBPI7khE2d/NEkY7hYCSTdc6VldZiph4i6DGKqPZdfc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) by
 DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Fri, 10 Sep 2021 08:47:21 +0000
Received: from DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6095:ba85:8fad:1c83]) by DM8PR12MB5431.namprd12.prod.outlook.com
 ([fe80::6095:ba85:8fad:1c83%8]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 08:47:21 +0000
Message-ID: <d1781e49-40aa-1eef-5321-1be322410f72@amd.com>
Date: Fri, 10 Sep 2021 10:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] drm/amd/pm: fix runpm hang when amdgpu loaded prior to
 sound driver
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20210910031758.724964-1-evan.quan@amd.com>
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20210910031758.724964-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::15) To DM8PR12MB5431.namprd12.prod.outlook.com
 (2603:10b6:8:34::8)
MIME-Version: 1.0
Received: from [192.168.50.98] (91.174.76.219) by
 PR0P264CA0099.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 08:47:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72ee120d-3fa8-4eee-b133-08d974379a69
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5230F7BE0083DDF78455CD6D8DD69@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x/5iwmH0rSXHzlqO07QmF8qvhl9JrNC2hOiS/rICdr5Jq7zwgkoVjKN0ebLoKhoNI//cY8L5GuDUvwQMctdxOFLVRGKrSmZy54mUCActDuzQB1iFqz00VGOIFN8IuGsBkHo3/iQjqR3X1paSQEb3JQCMv3XFLz/Nr6p+IVExnNh0ksVOg+BVm+4fBKwyvXukGcEo8P2YfzWI5wtsrvCCv3GMJwgGAfgnbB68qgbnA0Zg26GX0HWfT0qw/A1WOH5KnXKEUad0vn13m059GUuc8vylKgk1mnSJorN8LNnOl9TCBFWr7cS3t9RaMAAEpmyqTLXnUKEFiaIKzvTLPaAyFLsqCSkTRVydRKcoXd+XE6Q80DGV81ERdXn7XuOdBbF+0VXbNt8ESnWZXWobL7Ov00x6ZI8kiaSSE9jZNHaqIHS8TflIYTpj+Nc7KF2nxSxb9E6fLuluebhQ/6A50RJXJyA74mzXwLO2HI6zvd5LQVD/MKek5Z0auviKKIsrUkR4Ao0VzneVbSaj5JjdWoMb0clCByIxvBaZ+lWNaid6UpPRp4O+JQHAv7TNLJxndEDFYUFK02b/6U2q9uImIW5bay+d2UIiuFSaEtZjd4EOP+6Ignd8a7wUWbpmm2nWNE+yD3Ag/ntRqBLJkEkjROUtsKGlEdyvvcbkVc9vlHsVHtqxVXIjouoOxx+naAj8sQLgnlcsJa6SiSY4Yb6o8wGifWIskSLV42umjC5NSP5+E6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5431.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(66476007)(66556008)(316002)(31696002)(83380400001)(36756003)(16576012)(6666004)(956004)(6486002)(86362001)(2616005)(31686004)(53546011)(8676002)(8936002)(66946007)(4326008)(26005)(478600001)(5660300002)(38100700002)(2906002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hMTXlreVMyNVJ0UTRvK0JaOC9NUWpEdWdGZTVjcEgzdjh5aCtBWWYzQVNV?=
 =?utf-8?B?OGJVZS94aXNQRUV4aGtCdjdCNmFMTmtXcXlLU2pWZy9Cdy9CTlNRUzlSNEwy?=
 =?utf-8?B?QkxYVWFKQmYwRHR6ZFduRC9hc0VpRU96bVVxNU5aSEtUZkxNeUo2Tk9vbmlM?=
 =?utf-8?B?VlEvOHkwdFVCQm95QnFTVnZPUW9WMitEZE9aNDRwUmJqV3lIaDM4WkgrSVIv?=
 =?utf-8?B?SUk4VnZGd0liZFZqRi93REJsVjZQbjYzQ1hPNVdVRitnTkk1NUgrUWdlaG5r?=
 =?utf-8?B?WG90WVg0b3ZxWnFpTW4yRmpZRWZMRDFqREIzWkk1TEdoSFVCNEpQS3VsSlNC?=
 =?utf-8?B?NCthTkdvYTR2ZlRTY0FKNmtqV2V0TkxxeVdqT0dtdU91U3dTaGdpRmhhK095?=
 =?utf-8?B?V1hibUgxYVFuZEpITmxuRDJpc01XUHdHKzFzc2sxSFRpTmp3Zjk2SkxHeU8v?=
 =?utf-8?B?bnRoSmJkcjBvR3gzbU5iUjNFWlpTa1U2UTZjZHpKWXl0NGp0ZFhNTlRrdTdC?=
 =?utf-8?B?V004U0lZak00aGc4U0dRVytJd0lGVjBzNDFXSEZZSENscUdtcmN3cjhLTEdv?=
 =?utf-8?B?ZDhLNkJaeXhVaHhrNkR1eWE3QmpiWDBtbkJqUVlieDNQektxWVlRbS82MnlQ?=
 =?utf-8?B?SDEvWnNHaUZqUWVJYzA3UkFucVdPR2ZrYkVRRlVTTHNvTnNzRnltNkNucXU3?=
 =?utf-8?B?dXZ0eTV4cktpNW9hZ3ZLUElvQlgya3hTUWxMMFk5b0VjVjlIbzYyemV5M2U5?=
 =?utf-8?B?WFpNSDRHdnhoTjNyZjBqSzhuSXpJN2NCWHBmNWtBY0d0RjBDeC83SWhBbEZ1?=
 =?utf-8?B?Qk5FWDVUV2hyaHRuYXNyS3BYWDNyVTR6RG4xVlRGQk5LUVJINUhwNHA4R3VF?=
 =?utf-8?B?d3ZlbHcxdVVhWHNwd0VWTW5YeGRVcFpBR1hDS0Z1NXJzOWc5d2c1WUkxTjdN?=
 =?utf-8?B?RkY4WllsRXhVUE1tNHRLcFJueWFlWXBYS28wNVhBcFdHN0N6T3pwMXZMODVS?=
 =?utf-8?B?NnU4aE1WdlJKQ1dlb29LRUt1WkwwbDZFakZ6NTEzN1haQTR0TXF0WFEyNzVZ?=
 =?utf-8?B?ak1ucmVBSGsvdW45TzhaZ29vbkM2Q0ZnVTN3aVRHWWowVUprWlc5am5jOFJy?=
 =?utf-8?B?Z0pyWUpjTjh3OER0RHB2bVJWOTZiOWhBWFlUOW1INGtPV2ZQU2RyVytLQ1N2?=
 =?utf-8?B?MktMZDBsMW9rV2hvSzZrUTRuU1RPSUJHNHh1V0llNGhCWk80SzB1VXlEeFhQ?=
 =?utf-8?B?emMza3kvd25TbUNHK3hvVnBBVGRkQ3p3bHQ1Y2dQMzhUSW8rNndsR0VFUXEx?=
 =?utf-8?B?Q3QrRDVaY09RaEhxa251K2JBNzlJcGl4S1dIQzVwajJRaStuL3NNME8xNFVP?=
 =?utf-8?B?RHNqUUxmV2hKQTk1bWFFNnZGcWY3bGJBRzYrUGpteEpKc0RFbWhxMUU1dnM3?=
 =?utf-8?B?b3k2Q2MrZFVCS3FoazNMVlFzTVNLc1lqZTJJWXVBOU1uU0lDYmYzSCtBMnpv?=
 =?utf-8?B?YXoyMG1yK3VkQkxQclN1ZnZuamVONkdWcm4vdjVCdDF1OXJrM1pmNnkva3c3?=
 =?utf-8?B?Zk9kOC8xRy9Gem1CVGo4QWRHVmlzNXJHUnc3MXJFdDRMTS9pRHZIbnNUclJY?=
 =?utf-8?B?aVN0Uml1MFNISG83WmwwSmRmNk8wd0s3eFRIaVVNRHZ0YkVyNmRCdkdKRit2?=
 =?utf-8?B?aGlDOW5oS2c4UjhoZEthanIxOFFLdjlvZEQyVEhzSFdaRkkwOHp2UEl1UjJU?=
 =?utf-8?Q?Sw8c5mH0jokViy0jd/HT/vxOcu2quBFE5XlNLn1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ee120d-3fa8-4eee-b133-08d974379a69
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 08:47:21.3601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tarJuooLXCMzDgiEXSeyu5mA9+yyo9s9y9qQT974jSk6lMtBtb4Ef4Q85E2Estw04RzAo1mmtTKbbo+hu3IIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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

Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Thanks!

On 10/09/2021 05:17, Evan Quan wrote:
> Current RUNPM mechanism relies on PMFW to master the timing for BACO
> in/exit. And that needs cooperation from sound driver for dstate
> change notification for function 1(audio). Otherwise(on sound driver
> missing), BACO cannot be kicked in correctly and hang will be observed
> on RUNPM exit.
> 
> By switching back to legacy message way on sound driver missing,
> we are able to fix the runpm hang observed for the scenario below:
> amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
> 
> Change-Id: I0e44fef11349b5e45e6102913eb46c8c7d279c65
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 24 +++++++++++++++++--
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  4 ++--
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        | 21 ++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h        |  2 ++
>   4 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 7bc90f841a11..bcafccf7f07a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2272,7 +2272,27 @@ static int navi10_baco_enter(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm)
> +	/*
> +	 * This aims the case below:
> +	 *   amdgpu driver loaded -> runpm suspend kicked -> sound driver loaded
> +	 *
> +	 * For NAVI10 and later ASICs, we rely on PMFW to handle the runpm. To
> +	 * make that possible, PMFW needs to acknowledge the dstate transition
> +	 * process for both gfx(function 0) and audio(function 1) function of
> +	 * the ASIC.
> +	 *
> +	 * The PCI device's initial runpm status is RUNPM_SUSPENDED. So as the
> +	 * device representing the audio function of the ASIC. And that means
> +	 * even if the sound driver(snd_hda_intel) was not loaded yet, it's still
> +	 * possible runpm suspend kicked on the ASIC. However without the dstate
> +	 * transition notification from audio function, pmfw cannot handle the
> +	 * BACO in/exit correctly. And that will cause driver hang on runpm
> +	 * resuming.
> +	 *
> +	 * To address this, we revert to legacy message way(driver masters the
> +	 * timing for BACO in/exit) on sound driver missing.
> +	 */
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
>   	else
>   		return smu_v11_0_baco_enter(smu);
> @@ -2282,7 +2302,7 @@ static int navi10_baco_exit(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm) {
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
>   		/* Wait for PMFW handling for the Dstate change */
>   		msleep(10);
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index 43c7580a4ea6..f9b730c5ba9e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2361,7 +2361,7 @@ static int sienna_cichlid_baco_enter(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm)
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev))
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_BACO);
>   	else
>   		return smu_v11_0_baco_enter(smu);
> @@ -2371,7 +2371,7 @@ static int sienna_cichlid_baco_exit(struct smu_context *smu)
>   {
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	if (adev->in_runpm) {
> +	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
>   		/* Wait for PMFW handling for the Dstate change */
>   		msleep(10);
>   		return smu_v11_0_baco_set_armd3_sequence(smu, BACO_SEQ_ULPS);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 69da9a7b665f..d61403e917df 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -1055,3 +1055,24 @@ int smu_cmn_set_mp1_state(struct smu_context *smu,
>   
>   	return ret;
>   }
> +
> +bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev)
> +{
> +	struct pci_dev *p = NULL;
> +	bool snd_driver_loaded;
> +
> +	/*
> +	 * If the ASIC comes with no audio function, we always assume
> +	 * it is "enabled".
> +	 */
> +	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
> +			adev->pdev->bus->number, 1);
> +	if (!p)
> +		return true;
> +
> +	snd_driver_loaded = pci_is_enabled(p) ? true : false;
> +
> +	pci_dev_put(p);
> +
> +	return snd_driver_loaded;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> index 16993daa2ae0..b1d41360a389 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
> @@ -110,5 +110,7 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev);
>   int smu_cmn_set_mp1_state(struct smu_context *smu,
>   			  enum pp_mp1_state mp1_state);
>   
> +bool smu_cmn_is_audio_func_enabled(struct amdgpu_device *adev);
> +
>   #endif
>   #endif
> 
