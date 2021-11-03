Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D97C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 14:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC58861058
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 14:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC58861058
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572AB735E6;
	Wed,  3 Nov 2021 14:49:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98FD735F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 14:49:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPweFmyfJcOxiY5pGZ6GMWlGN55xr8okWk8IYbrL+jk7ykvSC5MhdGxQ1tjk8/m0qpDfowbHd/QJVZpOPpTEWyT4FLyGjvGmng+k0FGwpdfCcRAh9KsXuvDEuv29U44ur4Wmd9I6jc+DOuqjqXW2lMWV/fey/5w/OcssWW4f6Fk0gTU5nhcnsGUgGdLhut4XhCj1xfw2ajSAfK10dhEBQDXhCjxCKI3Ykwb8cmUNEPep37cgqZNXxF16aHqf3dzqhIhAHgZ/rxHzOJcH++QHfNM5FKIU1j9buMmoognjQb1EEa3ncR8IfOe+EL2ZiT4iF1uk9xbLlxVLBdpSygldgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IVRq2JBW3v5KKwQVl9wjmKQacsYcbAvdCyukfuqksY=;
 b=ahVaK6ZkupqWg0Oh5TgWoMb/R2pT1vKLLCfNEVbcGNFkXyf/oPW8NJLbCwpJxRzoWSKFZ8q0aW2ArgTUNzuBx7TsuccTbiwIRqNc4x6Nrkd2Ztq5FJIxSNWqTpWXdSHlA5b0oWEhPkcLqVXIBM2JSgZa7ZKQoG1zUpi6YTN+YaaHBc4uOx5iBy1jxh6JvBXGSV6ECTlYWlLY8pCxMECAAlK+6r2dTO999Hse8Dw9DQcYnybpIElCZYh52z+3TgtGmI/GfhC50xmOT/3g8wx01J1cuQBWPY+dBo35Uc6y469OyevWMru4erIUUslzg3zsPYLfi2a3i8bOowShX/cUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IVRq2JBW3v5KKwQVl9wjmKQacsYcbAvdCyukfuqksY=;
 b=OgAnCDEpRUDRGL2zIdpdbKwO57/oCQYi7/k/9shikpbyiieTFmHIzX9lFaI6Tzbzve6E1lrQ/bBSOic9a2tclw5IHBgXiI+2iOOecHIlsQ+SUIixDravo11Fjig7DUXJimdViRORRHzvTfKSLJkqkKg7ur3riOkkSrREy0tB1jQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB5564.namprd12.prod.outlook.com (2603:10b6:610:65::24)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 14:49:10 +0000
Received: from CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::6147:a3dc:dba5:60ea]) by CH2PR12MB5564.namprd12.prod.outlook.com
 ([fe80::6147:a3dc:dba5:60ea%7]) with mapi id 15.20.4669.011; Wed, 3 Nov 2021
 14:49:10 +0000
Subject: Re: [PATCH 1/3] drm/amd/display: Don't allow partial copy_from_user
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 rodrigo.siqueira@amd.com, patrik.r.jakobsson@gmail.com
References: <20211027142635.9459-1-harry.wentland@amd.com>
 <20211027142635.9459-2-harry.wentland@amd.com>
From: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Message-ID: <2f8bc988-888d-aeb8-1f0e-819cc2739bf6@amd.com>
Date: Wed, 3 Nov 2021 10:49:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211027142635.9459-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:408:e3::7) To CH2PR12MB5564.namprd12.prod.outlook.com
 (2603:10b6:610:65::24)
MIME-Version: 1.0
Received: from [IPv6:2607:fea8:56e0:6d60:9ac3:1434:ff1c:4bce]
 (2607:fea8:56e0:6d60:9ac3:1434:ff1c:4bce) by
 BN1PR14CA0002.namprd14.prod.outlook.com (2603:10b6:408:e3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.18 via Frontend Transport; Wed, 3 Nov 2021 14:49:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d17cd70b-2ac2-4127-8d04-08d99ed91857
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:
X-Microsoft-Antispam-PRVS: <CH0PR12MB51214634D1CD6E718E754DE8988C9@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgDdrv9e3Hdu5mREhVmi+ug+utfeAgbmy5oRaO7A0cczctcF1Gomj0YsJuhJuL4EvozV78OODPUKMfZWJ6Sbbt4UdAFzBz4qhm6jVZhvzgeuvX9an7+GjGMadHz0FPSaUjqwM/hmgJ1/z0KDLrg2Jd31kooJWnrO5Qy2blI9EHFyPa+YJddMdQHdmhAq71BDOMa9vRZw2pmUwbLE2LxAz2qW/W4L4xs72C7JUVtOMlDQyugsLGNu0wkpXGg+D9nHEyzWSK4lL+QhDHXVU6WDFk41sa3VQI+CZRPBIxlpZdGbiiKL26RoAyQQNWsy2YXZs2JEqC+q+LoDhbtGcY79hVrOC1eMOGbF2wrxZi9bHco6zPbSO2bv/TsaH0r3yfl5xFmEe1cikmRuK0fDAylpgL/3jk9qrFIACean0Ls2RdGJY+aCdMXFaiZGMSCwaS7NkjN407kVSaDbyGaIG9idqk+7FDEGlbsKIxSaq7QKpQU42K465RkjMVJsRjaYSGHEwM0fQmT7W4rj8l1M3vHwSDxHAnpIfXyfG5vWHFi1ZndMds/Z3+sXJzuUC92PKtWKLz5CAXLZt/gfRMkKBJXMncLlA+iVtd4BPEtf0fOL/ieoWhEgJaC2PtohhkVjaTTu1ePrnguyuLfpRCSVEhDiXJCdmGRhWyY6cjYx0MQPON1L4GyjTU07IALN/mtcR9BNtmR5ORD8NHAYoQEyxMzPKFM2Kbtp5NfBXQNDKccUYha+bE2qkyZB0sXRVi8LUM56OMqb+k23C3rqgbYeWjc57DM+jPZiTpdc2l8AtwvCEfyqakeIouIsZkeeD9DTLXJ/zc/hueGenL1FOG5q20AXVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB5564.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4001150100001)(31696002)(8936002)(38100700002)(53546011)(2906002)(83380400001)(6486002)(66556008)(66476007)(66946007)(2616005)(31686004)(8676002)(5660300002)(186003)(36756003)(508600001)(316002)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1lkNHN6UE1vTk9CZkVVRWY4VThUU0xMbVovbkVaaTloQzVuUythbzllNlFi?=
 =?utf-8?B?NHBIRjVyK2dwa3dlemsyc2I2VmNtZ3Rpa0dBU1ZHSlJxVGgrVGxaQnVINXd4?=
 =?utf-8?B?VVgzdjk2VWEySWl5Z0xacUxza0RLUlRJOEJ2Mm1QNTdzL1IxZkhoNXVBVTVu?=
 =?utf-8?B?dWxNMlZUc2RTL3J2ZHJodE4ycUwxb3JnOSttaXhYdEcvN2l2MEpNOUVIZWFw?=
 =?utf-8?B?dUF4RW5ldVQ4TjEza2pia1pETWNuTHhtOFVaT3N3bm1IekJ0Z2ZqV2NaNWRI?=
 =?utf-8?B?c1V1T3F1OE52Tm81aGg1TXM3OTZNd2VBRUUyYlliS3YxTWFVNUo3aDNyZlhj?=
 =?utf-8?B?bGl0QlhUR25oUURtd2g4Wngrd0tYTHljMDkzMXl5SHNUU3NCODVWZmdReGZU?=
 =?utf-8?B?ZVlZMUsxanpoTnJwelZsSzg1S0NRem5ZdE1xWUtVOERxVkFucVhhaWdkYURZ?=
 =?utf-8?B?b1lPVSs0MlJ0SkgxMXprSGZVaERMQjRxSjhzaTFYdnd1TWpwbXNNT1pEU2JB?=
 =?utf-8?B?bzMvUEk3Q2lqdUczUHVnVzJrQmpNenpMa2RCTjRGaEJBZzhMQW1GSUpXQmVT?=
 =?utf-8?B?S3U4ZmZ6cDhwWHpTWDF1QUlJa3FMNTZtWG40bGdqeUdCV1FBeHlmdkd4Rlgx?=
 =?utf-8?B?OG9VMjVoLzFrSWlJWU9CaXVMZmtPR1NLWXZHUDBKUHJ5SjFOVW1LZnpLVVpV?=
 =?utf-8?B?TmdwSHpWbDY1eWVYWnBvODRBdmFGcmx4M2FsK1ZPTll0aCtNcHY3NTZWaE5B?=
 =?utf-8?B?UVhEcVM5YnlHUVY2WjN1L3JBT1hVSDRMd2RWa2FsY2kzS2xQbnFkZXMyMUMv?=
 =?utf-8?B?ZGpIUU83YTdJQytMc2FwTDRiYkFEUXBGZnM4d3E0SGdpdFEwTDJiWFpWcFRj?=
 =?utf-8?B?RFVMYWQ5ZzU3U0E1Y1daa2xUOERSM3hWcUtiSWlGdUJhZ3NRYU1QVS83andE?=
 =?utf-8?B?aG9kaG9BQmJFNkRoYWpBaXZCeUlNeVZsYmpTYWtoRDdlZC9oeFBDRFVhU2Fo?=
 =?utf-8?B?VTlnM0VRRnVaYmRUOWxpY2h0U05rQWh1bjVRalBQUUZVeU50NFdESHJlcjA0?=
 =?utf-8?B?aFdvbmtQbTFRQ3IvQis2MlBoUEt4eGpCOGt4R05hQnVmRmVwM3Z3Tmdobm9O?=
 =?utf-8?B?SHA1TGxEckplNmsyS2JQd1NCS3RZS256QzdSVXhnRVo4UjAvUXNxbnk4b3Iy?=
 =?utf-8?B?bGIrSTQrenZLMjFoRVA5Z3NjbGRTV0h2ZkZ4YmNQb3NZdWYvaXpHTk96Ylpl?=
 =?utf-8?B?a3MybkczcUNMbVZSQzBiU2xPYmxMSVJGSHg3aDJUSnVzNHMzaldGVUk3NlFE?=
 =?utf-8?B?K0NsQ3laSkZFYlRMNXAzM3dheVRlY1cvRFY5WmlMbklxQVhkMWxpR0FKUkg4?=
 =?utf-8?B?VFdoRkNLVFJkQXJVZnNKaTJqTzg1Sldaa2pOczVpejZqdXJJWTBWUWVSdVRX?=
 =?utf-8?B?U0g1QzNUTjFQbjU4QlYrS1Q4blBna2xaY0xNNGxObXdSK2NmVlpPck1ScmJt?=
 =?utf-8?B?K1hpNHh3NXN5Sy85V0pWZUYya1FudkhaV3k4VWp4MExURHpwNk96N0xOck5X?=
 =?utf-8?B?bGNSaUVoa1hQSjV3UGdnOWdtcHBwK0FCREtteFliNVF3VE1YbmJVczlGdlVi?=
 =?utf-8?B?R21jNG1DcURBR1pRamVxb0JrOWU3eGN6cjlDNGVjNDdPdjZLb2pvNFZFV2Vv?=
 =?utf-8?B?SmhBc084V0gwNEtWai9adms2ekVGdCtCbEc3VE0rL3RWODNiYUVlQ0xuRFc0?=
 =?utf-8?B?RkpOU0sxNVNvQnpFWkYxNG5JbjFUZUZZR09Eb2J3bDR0VXlEV0N6dG5GVnUw?=
 =?utf-8?B?bXJ4TlJUZnNjTSthVFEydDdkREIwUDV3aXdmUCs2di82UGJTNFVVeGZ3UnVX?=
 =?utf-8?B?ZXhkUkEwcWdiVEtJS3NoQzhDWVgxWUppYTY0S2ZVYWtYY2hJbTJQcERFV3I1?=
 =?utf-8?B?VzA5eVYrcnpGeTBVQXFoYmtQN2J0cGRraDZLUzlaeWorK3MzdnY0RDBLampW?=
 =?utf-8?B?TzFlTmloVDlER0pYT1lvektNeTZ1d0NPWHpwVmxKR0c5bFdndFNJQll0WHM1?=
 =?utf-8?B?clRGSFlUbjZzdXdMY0g5YzBsaDdzOWdZYWVRU0UraEV0UXFDd241ajc0TTRV?=
 =?utf-8?B?azZDM1pFSFEvanY1OUk5T0dVZEpjeW04RUx2WHZ6SkV6bFhuaVFzR1dpRTIv?=
 =?utf-8?B?c2pqZ0pRMEcyVlA4YXZOZk5OOTZsNTU5WXZvdHVaN0tvSEMwNHcyU3BkWHdR?=
 =?utf-8?Q?6TA29ugXj4PAreacWdl0zAE7cNosFNizdgL3ZE74cc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17cd70b-2ac2-4127-8d04-08d99ed91857
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5564.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 14:49:10.4811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/F6/pJVxMDeegLMNlEqyxXtYaLc6wogSQ1N3LPZVvMITAfekOcP/NBK1VrlQm+/y1Nv+ZZEQO2D1ctGMALhlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
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

Hi Harry,

lgtm.
Btw, it looks like that the other patches from this series are already 
applied to amd-staging-drm-next.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>


On 2021-10-27 10:26 a.m., Harry Wentland wrote:
> There is no reason to allow for partial buffers from
> userspace in our debugfs. In this particular case
> callers will zero out the wr_buf but if callers in
> the future don't do that we might be looking at
> corrupt data.
> 
> Linus puts it better than I can in
> https://lkml.org/lkml/2021/10/26/993
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1a68a674913c..b30307ccff12 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -78,12 +78,10 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
>   
>   	wr_buf_ptr = wr_buf;
>   
> -	r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);
> -
> -		/* r is bytes not be copied */
> -	if (r >= wr_buf_size) {
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> +	/* r is bytes not be copied */
> +	if (copy_from_user(wr_buf_ptr, buf, wr_buf_size)) {
> +		DRM_DEBUG_DRIVER("user data could not be read successfully\n");
> +		return -EFAULT;
>   	}
>   
>   	/* check number of parameters. isspace could not differ space and \n */
> 

