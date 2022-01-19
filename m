Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8975FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED91010E14A;
	Wed, 19 Jan 2022 07:34:04 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB23B10E14A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 07:34:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4vW7K0utjMz/skdDQ/7oLQjWFMfawEEOxTjWzF3BbE62nHRMxF3lhwxQ/Xy8oHX49zhG2BlBAu6EC+y0Mu2g9etxa1e4CEYnMI/NKrf6UoPD9Xnzh3PzXVg/ZAvKwfHlYrVRHU/+rOQaWRayouUX+s0lGsCg270DbspHx5UYCUKDSj0ZOXVpZYqhhFCTCyDfV6nI1brtYchDWjV9CQ+IunHyC8zyP7KwY8wurLYv3xr/3FWNrbEtBnfRYEDsHYjQjaogWlOCj5a4lM8jhQ7c0lhos2b2AJwPHFTNbd3ABYfHBFdJaC9BUEj9PzvVu+VRVHZrR2bWd+GxY7TzYzq0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwsWCgoc9v6ka6h3UEc2pfV/rkK7Uk+knCARBkXILWk=;
 b=arGkPmoMoYcqIKxFjrXzq52wp7qTml+nYoa5E2mvr0EjAgEt9HAmJ6X0i0HpI2Fd/8Ul3i/rVYUogqezhVt+RcFuoqvOF7WPYg/i8XYn0fr6MJN2OsiqeDuCiYlv59jE8SU1WxXMCMbXfl4gMRKu5U8VGcGeFDQ+w3ZeDSULT8mliHDwEvj9ieXQ6oFTGZU91H8oe2nrIbcL4ZhKZeMomUp8w9SvZvu97a3bOdQ22exoAEc2kWP9OMLH8xkomqa72RvC2rWloufaKfz6s7gSbqSsMd6DU/FdhPnf2ojltgxIB9RVytrcyygGSSYhKyeuUi/pfrNUzVkBg+clD7KxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwsWCgoc9v6ka6h3UEc2pfV/rkK7Uk+knCARBkXILWk=;
 b=rIwAn/qyuRnjnfPjWAUUyBIr9yQSMd4sTNN9LKWv6lUZktHPXKgwngyUPOe4JWnYadZhwMQ/8szbm0RsMUWA/HoXHE14i6vrjyiKpOioTQRRfWKCo+X44jFTMbgAVptELy1lwS4So1tFoAT+gvIbTxxz0GGAn9dMDVdxjSJAy58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB3387.namprd12.prod.outlook.com (2603:10b6:5:3a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Wed, 19 Jan
 2022 07:34:01 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::b03b:7df9:d733:13b2%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 07:34:01 +0000
Subject: Re: [PATCH] drm/amdgpu: remove unused variable
To: mziya <Mohammadzafar.ziya@amd.com>, Hawking.Zhang@amd.com,
 lijo.lazar@amd.com, john.clements@amd.com
References: <20220119064230.2903518-1-Mohammadzafar.ziya@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <29ed41cf-021e-a776-27cb-fcfa78380575@amd.com>
Date: Wed, 19 Jan 2022 08:33:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220119064230.2903518-1-Mohammadzafar.ziya@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0105.eurprd05.prod.outlook.com
 (2603:10a6:207:1::31) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f5e088c-0ef0-4790-8b51-08d9db1e0fdc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3387:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3387004ADA168205ED5EE9C183599@DM6PR12MB3387.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDMzV1VaiEIpFlsMUPc2kvObj5WpkmkHH9gbf+zRLINj7VDUPriPZjsEX5LTUOReJKIp2WVtWDIS26JuFlBAJYOaT5LC+7E6dGWmLGVzRE0GtujQ0oFgu8hgbleGWWautm5q73e1mY3ZLMUf9LpK016wEH1wrKPQnIqJ1Wts5E2RbXxqOCVIx+ty/yAvVxBXe8sisAJqV3WNBFFswlSAqpwXkJfNsn1H8Bq9f8uMfsRheLPt/ndDz65YXGqr+qG75Z9fpZtGksnD7o9rHur90N5R4D8GHMpikeFjN6Upt2ScM+7tPBoTmKKA9TplpcohISne1jVkD1olgwo+2YA8OrDOaIRWmcyqn6wakmhc5QYt8n+3MLwIv2kCSSimQ3zrV+rNgm5PCSFkLwH3TUBLDd7otdqfn6CvgrmJqqR1GDMW5jG4yju0xScDWYeDW926cj8frc2ryjECdCzQSA1ewX/Wuukog9ZIl7gOfr+GNGUJ1hv+k/OV0JitDmrtHBPCO2UhEbhvr4GW1Evlvnfs0wF5MX0N7LSM/IIwR0hEj9TdIRli+JsIRxzGC6N5tgEL4cpWwhRnNJ7PfsJrqcKiGNJ5WxMUvV9+f5q19ebseh/sF+0mxsJJDVDwlxGqAJrT54diiBJ+oTr8inqm2SOy27yifWdpCtYYq66AqCLuZf4C2h3Ps3FTtMVR9zl/bWny3YhbmQ1QDWZOgz8PVpNuyh7wtfBH+eHcd5JVhBk3GVGOrgtTHWvQrNcm6PyTfq5A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(508600001)(26005)(6636002)(6512007)(31696002)(31686004)(186003)(36756003)(86362001)(2616005)(66946007)(4326008)(83380400001)(2906002)(5660300002)(316002)(6506007)(6666004)(8676002)(6486002)(66476007)(66556008)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0NoMTBlN0lNY3pWUkx6cGlpM2xDQ2JDUDlXYmhKOWZNUlcwSlg3N1BjSWRh?=
 =?utf-8?B?M2ptcC9ldVdqZ2d6UjBOdHRzeTRaTVdmbkdRY2NKRzBtQjF6ODI3WWVPYXRJ?=
 =?utf-8?B?cFFCQmFyNkZxRVYxUDBuZ1Q4Mm1Oa2hWODdhQ2pSclBRbU56RjV0UEFrSTdj?=
 =?utf-8?B?MTI1VGl0bHA5NzhZOFhtTG9ISUMvTU4wTDlMT3A2ZzlSRGY2YTVzRVBNRytO?=
 =?utf-8?B?VlgvUnlPbDdmSDRjbi9kMDRUV0xRcVN6YU9uL05oMFZZZGNlTGNldDRrWlVw?=
 =?utf-8?B?eVRSWHNQVlcxZHJ4dVFPNVpOQlhJV2tYOEVyZFVvSWZxclBqellTUVBZMW96?=
 =?utf-8?B?YlhXZzdsRjdCS09pQXVnMWpUSktuVjIrcGlGSlVPTXpsbzc4NVpCNDNGMGgw?=
 =?utf-8?B?MmV6Q05hUE5JcC9rU04xVlNpTjJ6TkRVRDhIaDlPUEt6L1VnK2IxNHRVUlNE?=
 =?utf-8?B?Yk5MZVdKVVdVOVhyRDFmMHJLMlFCdDNsbklzTzJJRldtRXdLZS90dVVTUFYv?=
 =?utf-8?B?Q0NmWkc1SmNHNE8zeEVwMnN3MDFkRjNLNmRBLzgzRXZOdVBENWxpYTBUMzVO?=
 =?utf-8?B?a0xRUGFIcTF6Sm5OalNNdmNSTkJQa2U0RVU1Y1lnbG9BYzMra2xTWnhaNW4w?=
 =?utf-8?B?MDNXQmR4aldYdzJIR3VYY045MW1NSkdGVUNoN3hZVTRqMzVndndHZ1cwME40?=
 =?utf-8?B?aE8wNFFqVVNVVjZ3bjdKRmpxNVlGajJ2ankxZ2Z5bDVVK210RThpU3pZSkha?=
 =?utf-8?B?eFRpZUJUbWpGYzFVbFZWREQ2ZEJIb0lrcFAyTXk2NUdrK3d0dnQvVkgvVGdi?=
 =?utf-8?B?T0hacElXWmtwR0E1a0c4WVBuK2cvQ1dzUzh1ZE1PZ1BCaVJNSm51R1ErblJx?=
 =?utf-8?B?NlNFTHFBbXM4OW1HTHJteUxNek9IZ2dLZ0ZlNXEwQWtrdWNPT2RKL3Q2bFc4?=
 =?utf-8?B?TFFKWlhJanlCMkVvd1U2RXFUL2cwRjU0TEFwWkdqOWFDMVFlSXZFcTVja3h0?=
 =?utf-8?B?OWNpb2NRVkRCM1o3anRMS3BwNFlNbEg0bG1Tc05ZazRXOVhYaWc4MFFJdXFz?=
 =?utf-8?B?eGozV29uSWRGOUVvemJNNjNTcWVCZ3QvTDZlMFlOUXZod2NmeEw5MVhGYXVk?=
 =?utf-8?B?SXB5cGxBZG41azF0cWJhTGFNUnEyLzVTWVZTR3BBOVZJUW8ybEpkTkp1ZzRx?=
 =?utf-8?B?Vms3N2VRTHYwa3ZaTWE1NjNpbS9GTk10RjV5SVNGV0h4WUVxRWh5R3dQbkdF?=
 =?utf-8?B?b2tmWm9OQm9jdkFsaHJmMnlWYkcvWHZKUGMwN3JVdmQvNkxFcjlGRUhiU3cw?=
 =?utf-8?B?MVBwaWZKMmRiaGNiN0RUTkJpQ3YxM2VBNmVnSVRDYUE0SjdqYTJuUUxRREsw?=
 =?utf-8?B?VURrNmJnTTFuaXJVUnBEc0pmNWZVTVJwWno1dEo0VXZVRTJlbVAyVjBXYVhI?=
 =?utf-8?B?a2c0TkhDYm1wZ1c1MTZOTFZVTGFrZWFGYkt1YkVVaVB1Ny82L1NualRCWU51?=
 =?utf-8?B?a3FDSzErNkpoMUQrdVVqT2FTR0VvcWxGSEIrRHZqb3NzNThlbzJjWWNVcGxC?=
 =?utf-8?B?U3lGcCttV1RRTTQ2UHN2dVJFS0llM0IyRWFiQmVjNHlBQkJNZEhjYWlMcU9B?=
 =?utf-8?B?Qy9lcldPVmdsMWdjTGlQTmhnZm42UWFJcmxidUN1ZWoraSs5a21iTkQxK3J1?=
 =?utf-8?B?T0hDb0RJdmFUM3hjSHcvY1YrTnQzUlpoZ3Qzelpka3JyeFk1UkUrdUhiQjlx?=
 =?utf-8?B?WExNVTBiM1AxZjF4ZjJGQy9rMWgzdUhVSzZGR0Z5SUxGMEJMQ1E4Zm1MalMr?=
 =?utf-8?B?ZnRtUDEvYkovelhod0xYNnN5Z0VxbXpvTENEQmRWRHRKeG1CMlNvT3RZRk9Y?=
 =?utf-8?B?OFN5THdZQTJ5dUdxc2crYnJnOVM1MmIybmlmbERwL1lnRng4MXg1dVhYczZU?=
 =?utf-8?B?clVvKzV1VzJLQzFubEtJU1FTaUxROEl5U1FDWVUzeTVyNzFNR3RFUURyZGRV?=
 =?utf-8?B?VlFxa1p1K0lXV05nejlMbHR1Q3diTndsUWhrZnlwVjRnUElzMlNmUHVUMWRt?=
 =?utf-8?B?L0JWVE81a3RBT2d3ZEJQS1lPYmdNTWxkNXorNEtqdDg5cWc5djNHbTZKNkk0?=
 =?utf-8?Q?Ej+0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f5e088c-0ef0-4790-8b51-08d9db1e0fdc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:34:01.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+Q2xKW9JY+ekIWLSlmIDO6jWeElSILsR6YSSLbPmw+7TdpVrAKZIGNv722HfmQE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3387
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
Cc: kernel test robot <lkp@intel.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.01.22 um 07:42 schrieb mziya:
> Remove set but unused variable.
> warning: variable 'umc_reg_offset' set but not used
>
> Signed-off-by: mziya <Mohammadzafar.ziya@amd.com>

You should use your full written name here.

Apart from that nit the patch looks good to me.

Christian.

> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> index 291b37f6db4e..05f79eea307c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -94,16 +94,12 @@ static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>   
>   	uint32_t umc_inst        = 0;
>   	uint32_t ch_inst         = 0;
> -	uint32_t umc_reg_offset  = 0;
>   	uint32_t channel_index   = 0;
>   
>   	/* TODO: driver needs to toggle DF Cstate to ensure
>   	 * safe access of UMC registers. Will add the protection
>   	 */
>   	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
> -		umc_reg_offset = get_umc_v8_7_reg_offset(adev,
> -							umc_inst,
> -							ch_inst);
>   		channel_index = get_umc_v8_7_channel_index(adev,
>   							umc_inst,
>   							ch_inst);

