Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF93C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AC361168
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4AC361168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B686EABF;
	Wed, 22 Sep 2021 07:32:14 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FBC6EABF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 07:32:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL+DDqgxxiGOHtSqXlnjV29kxZmnDX4QF9A9jl8fB9W7xawGtspUgy/zCj2XoeqgqtpIlfA32/m5xY85N3rndb0Qn4iiK2BkM+/HenL+TeNZjAehgBfMdzpQjG6xiI6wVaf1zyLvRJmytjoTEi52fpxW7lASK22ICgbqXaUMD2dMc1smK0C+I3glYIxIUpVlN1ci2oiwqv7GuSdLoBonMj1yhOljP2T8ghODCk4eVLeZVIn5HC+OmV+e98pGPb0YmcNFUC6wyak5PkBav8xoGs7stH+tPuWPkVx7Zo122LYfN20n2w0c19ScgH0PGna3bM1DWHLvzniOhflXAUsSAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=oe7ogZkOxNLikvrdFD6TFlfV2wPZgNqBzwJAFZvh0tI=;
 b=Bix6JaEY4p7Nz2eIgHc/aetLX+sHiTLvThg9FsEyjWrYcd7UUo/ZtXMsAfNK71ZOSDq/0DD2h2kDW7WEhuJ+LYaYuKDflREA3+7RmZqcYENx12PlD6SdAnukk9O3ymqnT9jpnOvHt6Ny0fPW0qHezueF1E73dX3hLnZV10sL6pKlZmVFHeSmkQEC0zaywzN7msmbHipefNCOGGmuQ0N/7kDOeWTKJgHVpN5o6D3AeT/8o0BkXYD+0QwISNKRXL1G3AcXW7wW2APVgcJrKO4vhDnCoIgJAIguykidWNqMMIL+WbKWZF/EOPalGjuhcqDx31gU8p0P4IndnqeKOaMuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe7ogZkOxNLikvrdFD6TFlfV2wPZgNqBzwJAFZvh0tI=;
 b=2SYf6B1U4KVDNMYZnBIFEltG4OAMCNahUchoxUV6a7SB8+kgzg8kURY21APQjiV1qqqTgnE68xoUkTQ2V67QU4xUn8psk9PLMtbwQWgvYxiCkXuwFBGU8G+FS+VGkNEkJnA38DmssLmqxMTZLQz3ZVI484NWqsjG84TpRZnbF1Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3115.namprd12.prod.outlook.com (2603:10b6:5:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 07:32:11 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:32:10 +0000
Subject: Re: [PATCH 28/66] drm/amdgpu/nv: convert to IP version checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-29-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <deee930b-0214-e165-e23f-93a6ffd150a0@amd.com>
Date: Wed, 22 Sep 2021 13:01:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-29-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::18) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0008.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:32:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3766d629-5baf-4108-1c6c-08d97d9b166e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3115:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3115ACFF55CE76AE9E5B2F1497A29@DM6PR12MB3115.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fTXzxu5OV7gsZX/t4i34DGEfGP92ozAsXWrGVnjhQmpghkexBFD56MY/06uIjsaTrWCY3FuthpW/7IgjmvPhgRnBvBO/cOBHrH53cd0YOspUF4OxfbTsbXsy8NOkLIgR7yL0TPjxfeU/nPZoe5W+Z72FdN934MVhJLd/GJe4n8hsLKeqyOS0W2E32hza5p9pmTOpBh+x5rZc1oyB6576RQsTKLAUbO393yLQiH2EDcauEUS91mbIaCyV6I1AyfMugkmVi+tirdRKIQGbxFzmFnfIFsGt39/KLVRRdKx6aY29dnpr5uC7paZ/MmQmgn/B1NgMioNX4BDj5HhzfonhsBa/tYx0yt3rWIVUVjrGoy/CNEj2T9UO6QFx4T7qNF6x5RvpsQJuAO2M+Td8KZO12nN7D8DWcwB53OvDo3MFinz4tS7GEg6gBdMLZdq1VcpD4mFHC9QadI1m8Nuiur0lbvvAps1fDw6PsRYFCBnsAN/Pj3Ns6z5Mzh6fAIVDs8Mls/H9cWMjIdgHI61QI9+j+2eRiHQSfiU4OZOHkHS8gKX1lxdlhZ9a7RKmWx4iYrKOwe7sreOtcoZpeLy2aBYOz7kU1DnD1pQUOPjTaHtntDhUqtqlf9j+znIEv88rXPS/YONUG/uFMH2dq0AIgyIdw6YIsjaQ90OwiH1zOSbAGW7gVJC8stSGHpYUs1A4eA32dQ3jS6oQO+ae6iDW/oKV0PgwXpXdctvig+EqmvwG4UY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(38100700002)(8936002)(31696002)(36756003)(86362001)(66476007)(66946007)(31686004)(53546011)(8676002)(508600001)(186003)(956004)(6486002)(316002)(5660300002)(2616005)(26005)(83380400001)(66556008)(16576012)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWZGMUVmdnVZaUVqalpNM3NPWGFyMmRpcU5TbTNLQ2M1eVljaVhkazFFZ09S?=
 =?utf-8?B?R2hXN2l2ZW9vV1ZSM1dlUTFWTlg3TjhWeEpmVTNOVlhXYTFSa0NtSVlYSm15?=
 =?utf-8?B?aEhMVnJuWjlGRXhVYi9QeEpPV2gyZjJoSnBtdjM1ZHFlZktiV1FkREV5a0Jh?=
 =?utf-8?B?Sm1Sdk1OOUpvRjZYQ1RMS2MwRSs3d1NBMURheVZjNjNGQk44U3o4RW5FYnV2?=
 =?utf-8?B?UmNKL3FSY0tkL0hLNURzVzVocHlPcjdYSEdkTW4yNlpMMXVFMTVMc1JPQjFV?=
 =?utf-8?B?TCt1OWNYbTE1Ky9tWlZwb1R6SjlyZzg5NVVxOWo1eGJ4dXJqTi9KcDRnQ1pR?=
 =?utf-8?B?a0ZLb0tzWmJSMm5oNTZNMVJ5TFRzdlRoNWpiU3pGNUJZbGNaV205UThObUl5?=
 =?utf-8?B?RWVLSFBGZ2xtV1hmWUlNUCsrRkppL1VETHNTMXZhaUgwK0VlSEplbUxIcjVm?=
 =?utf-8?B?ZWZjZFduQk52eSt5OGk2WGxnK0FZRFJjbkpNOXZKM1lhaE4vRk9rV1VOSmcv?=
 =?utf-8?B?QmR3NngwaThKN1JKbllZa0MrWDIvbCtKclo4YkVsbXZRRTNINUx4azZMR1ZV?=
 =?utf-8?B?YVdKUlhxU3pySktQSTZTTnBWVlZ3MjQvRDVaeGRTZzJOOHJmOU9CSEhZTHdT?=
 =?utf-8?B?N1VLNng3N2o1KzBnd1E0a3FvUkt0ZjNUSkoxMUkxRzFJZEhENkhRZU94ZTZ4?=
 =?utf-8?B?U1drS3dqcjJwY09XZWJVbW8wQmlOaVY4VHRxQmRnOWg0N2l3MFVVQlQrU2Va?=
 =?utf-8?B?TVY5Mjd2eU56d1hSK3JrQitQbjQ4UUFmUTNvWHNPd2FCeU1ndUgzc1l1OXJU?=
 =?utf-8?B?WTEvbHVleC84ODRqZlhiNFBGWStDVU1xTERJTFFVdVhCbldCYjVrTnU1aWZ0?=
 =?utf-8?B?Y29VMi8vNkN4OTBocmRMVVoxOWdSbXdSSlZJZllESWVNZXpBTnkrK2sxdWVo?=
 =?utf-8?B?TlVST3hrZjBWMlp1K3JZNDRsQ2habVZjTjVqZEl2bVUrVGdWWXNqYXM3aGZC?=
 =?utf-8?B?U0VxdVZoa0l3R0VjMWFBUmU0b1VQejAwOVFzaGJVUUxJT0FnQXhZQmJSd0JQ?=
 =?utf-8?B?b1RkRVhuTnIyN0plbmVZNzErVkMrbEpLSjV3N0cycGtrdnNwQlRHZ0dCdVM1?=
 =?utf-8?B?Y0lpUEo0dk5IZjFpWXZvR3EzMnRVWkJSekpqZFR0VWlUWTg0enF6WHZmN1hP?=
 =?utf-8?B?bTFNNUlNMVJ5a0xROEFhVHlSdXZoMFNiVGJvQVFVV05IUkdtY0pkZnNNajVr?=
 =?utf-8?B?bVFuUTdLTmpwd1ZJSHc4ckNMWWZRbklqQWFoT2RaS1pTMHZXL1FERzhmeFph?=
 =?utf-8?B?MjVxSUJ0d3RCYzNPSXNiYWtLNDNpYzdPSkJpZmp5TUExQ2lNZmpZK2xFem13?=
 =?utf-8?B?dDdpVXUrbzNqZTN2UFJNN3FxNC9keFlYMExQUjkvMGIyd21hTSt0WDY1Tll1?=
 =?utf-8?B?NGtuNlBadzNLcVNBUmphbUdSbkVqYy9JWTZ6TXYwUnpIVFdQTWtyUmYvMWND?=
 =?utf-8?B?S1dUaWRDbmtVR1hMMzhVNWkxUGZLVzFYYW9xTnRLWFh0VDFGdVBWaHJQWUpa?=
 =?utf-8?B?SUdQb0dWdERTamhlVFM1UGhqbmN6T0pzeC9EM1Y4bDNPNXh1Z2J1U3Ezd2Qy?=
 =?utf-8?B?MklTeXo0ck1mNjhrM1RIRFArdTBRUzFQYzU3WVV3TWd6Y0tqMy90dHhFWW4r?=
 =?utf-8?B?aUxKVi9HeVRrbFVqRGxsaTdvbVhqSExTZXdZZnZmS1c1WnYxOFVqSitOd1lq?=
 =?utf-8?Q?vsrXQzltK0Ha5kevGplth66xCGTkwVgg22whtQ1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3766d629-5baf-4108-1c6c-08d97d9b166e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:32:10.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud5AqUOpzg99A79xZKyfNsxcAxvGwLCg+TslbBh7M8NP6hdqneI020mqqc1BLBV5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3115
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



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 75 +++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 0dc390a7509f..57be517d70bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -180,8 +180,8 @@ static const struct amdgpu_video_codecs yc_video_codecs_decode = {
>   static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   				 const struct amdgpu_video_codecs **codecs)
>   {
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> +	switch (adev->ip_versions[UVD_HWIP]) {
> +	case IP_VERSION(3, 0, 0):
>   		if (amdgpu_sriov_vf(adev)) {
>   			if (encode)
>   				*codecs = &sriov_sc_video_codecs_encode;
> @@ -194,29 +194,27 @@ static int nv_query_video_codecs(struct amdgpu_device *adev, bool encode,
>   				*codecs = &sc_video_codecs_decode;
>   		}
>   		return 0;
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(3, 0, 16):
> +	case IP_VERSION(3, 0, 2):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
>   			*codecs = &sc_video_codecs_decode;
>   		return 0;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(3, 1, 1):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
>   			*codecs = &yc_video_codecs_decode;
>   		return 0;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(3, 0, 33):
>   		if (encode)
>   			*codecs = &bg_video_codecs_encode;
>   		else
>   			*codecs = &bg_video_codecs_decode;
>   		return 0;
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> +	case IP_VERSION(2, 0, 0):
> +	case IP_VERSION(2, 0, 2):
>   		if (encode)
>   			*codecs = &nv_video_codecs_encode;
>   		else
> @@ -511,14 +509,15 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   		dev_warn(adev->dev, "Specified reset method:%d isn't supported, using AUTO instead.\n",
>   				  amdgpu_reset_method);
>   
> -	switch (adev->asic_type) {
> -	case CHIP_VANGOGH:
> -	case CHIP_YELLOW_CARP:
> +	switch (adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(11, 5, 0):
> +	case IP_VERSION(13, 0, 1):
> +	case IP_VERSION(13, 0, 3):

Odd. Two cases replaced by 3 - are there two versions for YC?

Thanks,
Lijo

>   		return AMD_RESET_METHOD_MODE2;
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(11, 0, 7):
> +	case IP_VERSION(11, 0, 11):
> +	case IP_VERSION(11, 0, 12):
> +	case IP_VERSION(11, 0, 13):
>   		return AMD_RESET_METHOD_MODE1;
>   	default:
>   		if (amdgpu_dpm_is_baco_supported(adev))
> @@ -1042,8 +1041,11 @@ static int nv_common_early_init(void *handle)
>   
>   	adev->rev_id = nv_get_rev_id(adev);
>   	adev->external_rev_id = 0xff;
> -	switch (adev->asic_type) {
> -	case CHIP_NAVI10:
> +	/* TODO: split the GC and PG flags based on the relevant IP version for which
> +	 * they are relevant.
> +	 */
> +	switch (adev->ip_versions[GC_HWIP]) {
> +	case IP_VERSION(10, 1, 10):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_IH_CG |
> @@ -1065,7 +1067,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_ATHUB;
>   		adev->external_rev_id = adev->rev_id + 0x1;
>   		break;
> -	case CHIP_NAVI14:
> +	case IP_VERSION(10, 1, 1):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_IH_CG |
> @@ -1086,7 +1088,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_VCN_DPG;
>   		adev->external_rev_id = adev->rev_id + 20;
>   		break;
> -	case CHIP_NAVI12:
> +	case IP_VERSION(10, 1, 2):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CGCG |
> @@ -1115,7 +1117,7 @@ static int nv_common_early_init(void *handle)
>   			adev->rev_id = 0;
>   		adev->external_rev_id = adev->rev_id + 0xa;
>   		break;
> -	case CHIP_SIENNA_CICHLID:
> +	case IP_VERSION(10, 3, 0):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1139,7 +1141,7 @@ static int nv_common_early_init(void *handle)
>   		}
>   		adev->external_rev_id = adev->rev_id + 0x28;
>   		break;
> -	case CHIP_NAVY_FLOUNDER:
> +	case IP_VERSION(10, 3, 2):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1158,8 +1160,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x32;
>   		break;
> -
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(10, 3, 1):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CP_LS |
> @@ -1182,7 +1183,7 @@ static int nv_common_early_init(void *handle)
>   		if (adev->apu_flags & AMD_APU_IS_VANGOGH)
>   			adev->external_rev_id = adev->rev_id + 0x01;
>   		break;
> -	case CHIP_DIMGREY_CAVEFISH:
> +	case IP_VERSION(10, 3, 4):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1201,7 +1202,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x3c;
>   		break;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(10, 3, 5):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_CGCG |
>   			AMD_CG_SUPPORT_GFX_CGLS |
> @@ -1218,7 +1219,7 @@ static int nv_common_early_init(void *handle)
>   			AMD_PG_SUPPORT_MMHUB;
>   		adev->external_rev_id = adev->rev_id + 0x46;
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(10, 3, 3):
>   		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
>   			AMD_CG_SUPPORT_GFX_MGLS |
>   			AMD_CG_SUPPORT_GFX_CGCG |
> @@ -1247,7 +1248,7 @@ static int nv_common_early_init(void *handle)
>   		else
>   			adev->external_rev_id = adev->rev_id + 0x01;
>   		break;
> -	case CHIP_CYAN_SKILLFISH:
> +	case IP_VERSION(10, 1, 3):
>   		adev->cg_flags = 0;
>   		adev->pg_flags = 0;
>   		adev->external_rev_id = adev->rev_id + 0x82;
> @@ -1374,14 +1375,14 @@ static int nv_common_set_clockgating_state(void *handle,
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> +	switch (adev->ip_versions[NBIO_HWIP]) {
> +	case IP_VERSION(2, 3, 0):
> +	case IP_VERSION(2, 3, 1):
> +	case IP_VERSION(2, 3, 2):
> +	case IP_VERSION(3, 3, 0):
> +	case IP_VERSION(3, 3, 1):
> +	case IP_VERSION(3, 3, 2):
> +	case IP_VERSION(3, 3, 3):
>   		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
>   				state == AMD_CG_STATE_GATE);
>   		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
> 
