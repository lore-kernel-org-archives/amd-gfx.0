Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A75C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CEA60EFF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 20:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87CEA60EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 094E36E491;
	Tue, 26 Oct 2021 20:46:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 499E36E491
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 20:46:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZrZHQKVMFQoE0o+FspcY5f8OnF+MJx+M8+ANVaTaZzkAAcelzA21VOO+CHqRJo8AHz8R9nQTvU6xCrPw3HFp6ldp9MWVCh6tNa0QY1atDK6uyBcLVSS8dBRtIASPhE0ow/UFec5oIwxuig7Z8poHxti+wkbwsEB6ihyd8NdsEN33MuSRty0koUHm6PMWL8z4IozviCyfzN7ACHfPClQOguYj0T0Ly38Z5ryz3b3IBVBvx+0Wdjv5tQ1meu1ACPFpPOMvn/lMuHJszUp5sWG/WG8lDurKGG6MgMk7gbvOeWOk55BGJLHbWv3sC9h2LlW0rki3g0vLSEBD9XS31W5dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Dojey03HW4fJfQXkRczxXA4qtkN9P8wuBIOdYEBcGY=;
 b=AGhg3ZY24gnyaUfG2v+BwCj4RC0mAeBYWGk7MwcmR4mEegc4RKAP0YkPsq0O2p1QhwU7Zu30jCS93NZxYewfvLAS5cdM4NpccavAhTadG/KX1aSF+D+SOVmZolLD5vOBvq9Yj9+fMdjc3KlbcsCPu4SY6yKvpEho5MkNN61A7WvosqeIorbCOIhbNrPJRnRJrYgH/j9nKSa3CqKz2lzMAXupoEazKdvBfe+N+p3xHIE65is4Gnx1Oc0g73mVJuwdm6MOTJA+rJCRWBF1FoFO/Dq72cNdV7lSd4DkvbjpzD2pGVMCaHSuL2+Su9vqlNi9PZYJc+MIE9M2nYWN0GAc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Dojey03HW4fJfQXkRczxXA4qtkN9P8wuBIOdYEBcGY=;
 b=oe8gCTcNXsWfzTp/8p2VJAD7JEI4h8MwmrfYlXWO9zZw55lfbIpy/1YqAplXKtCMlqdnWhKNZBGtbJtflLT8NMtP21E36DJRMBNFpDeMoXGof+WWsN6tDtqHgPSpvgmWqA4Hl7/9I3CP1RkNoH97zSLkYg8/NqCzrjeKBI+t/hA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2825.namprd12.prod.outlook.com (2603:10b6:5:75::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Tue, 26 Oct
 2021 20:46:46 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::4447:dad4:f8e9:c5f3%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 20:46:46 +0000
Message-ID: <fd4113e6-5eb1-e55e-fc56-336581ff0681@amd.com>
Date: Tue, 26 Oct 2021 16:46:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 2/2] drm/amdgpu/discovery: add SDMA IP instance info for
 soc15 parts
Content-Language: en-CA
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211026144535.191727-1-alexander.deucher@amd.com>
 <20211026144535.191727-2-alexander.deucher@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20211026144535.191727-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
Received: from [10.254.36.169] (165.204.84.11) by
 YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:86::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Tue, 26 Oct 2021 20:46:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fe37aee-d0dc-47ba-418f-08d998c1b9a8
X-MS-TrafficTypeDiagnostic: DM6PR12MB2825:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2825DA6FFDAA8F2C3D28BA7799849@DM6PR12MB2825.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qmrHaOzzKdVSgci0kfDcbEgt87XtYqeDefMCyQi3fvbn78GCEHYOnLhbBDyGLSx447SLGQyrrtNGTH/hgMdX9KT+XhfZeJkNW80VQaDlYkUXNGwdyNu2qW7XOO+tTBsC/Zs1NTUnBHuSCVA7XSYqHkKQf3JWTHybXw8PZd9TY+1gb77v82SH716iz1H6Kjzr2rjgsBm+zFBKT9jekT3mmTVoVdZGS4aaKUaRfz8CV8cYAXZpAYTVHS6Rkzh0PVLNeRx9k6RNjZ6nKksFwG3VrY3BSPAAuadtUpFAKLe8jtW7R5l8FJjN3VtIOYmrNF1s7JCaJLcfEBi/NWTx0w7aoURSgiK3hexNxyw1KvHnuMVDlf2aGVK+7J+8XPU7lneaTPXGBUawCEjGjMLzDqRC62c0MOqAaPSAPPyOWnjTQ+J9rTsXWU8VPVpGDepvbMESdlgjaIFqdlPhBk7aEooRDZwhfzIH3cv4AEqFmJ2O2b+TIT+wZC/xvZ3htYhCwc3wPExiMFqRU3Iy17BlzkCb1KAh89RAwbzJDOijf73CBpykjAwuyknLzk0TFp4w8hhzYEhG7dyQBze6K10e193XLIFD4gm4v9Spsf6sfuwficw2ZR7Zo9MGOm4+lnJXxLdfk1LKDK9g/T4oeQbGo/aU3acBwHTTFBPd17ddR1Rv5qg0ySF6UCK+se46xq8PGxtrs55AnQi8o4JyKvOtFvQci7ZndL9Qw7EwcOUyvJBFm4kbkgEf+D5jltlMnpC+PXG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(16576012)(66556008)(316002)(186003)(8676002)(26005)(66946007)(5660300002)(508600001)(6486002)(36756003)(44832011)(66476007)(38100700002)(86362001)(956004)(4001150100001)(2906002)(53546011)(31696002)(83380400001)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9EeG9ocTZZajZhbEVrdHN2ZnJ3ZjNOS1RhS1hBblJidVF3U05iWk9uMFRP?=
 =?utf-8?B?MjZ1Q0tHQk1yeVNVSzdTbjZUV1dYOXUwRXFQUmVqSVNHa3B2L2tJSUlJVUw5?=
 =?utf-8?B?SDlaSXA1RTZPVXJTNyttUTN3ZVlhUjcxcm8zVFE2N2Npa0JSSUt6eW02NzFa?=
 =?utf-8?B?QVlaZS9zTVJMTzlSVERQL3d1QWZHNFFoQ2krVU5DOHhZS1ZDbW95TlZ4aUlJ?=
 =?utf-8?B?V2JIUFhpK2FDNjdCTTNqTnJNQWNwb0hQaFpEOTNSdnVZUkx2WlFaVTNBNGNw?=
 =?utf-8?B?c2xEVVhyWHN2aHFDZ21KRVZ2bWlyR2lNWTBJUkdFbUkyM1pEKzVUbmhmUzND?=
 =?utf-8?B?bEljdGF2a0FUbk1zL0hROWxBNVNyWUhJQkxIM2JFcmcwL0dtcGVIRjVFZU9Z?=
 =?utf-8?B?Nm9NQ1ZqL2VmRGpMTXNUL3hwNmp3RDJ2ajh6RVJBSklBSnRLNFpkZDJwWCtQ?=
 =?utf-8?B?T0s0bkgwaVZ6dnNLMGsyUmM1bVFXN2o5bVVvZkVFK1VITmhCbGZHMi9reGdt?=
 =?utf-8?B?NDRjeklVOG91QTd1andHNzRpYkx5ZWpJMktHOHo4UnV3ZXRFWlFQa2YvZ0Qw?=
 =?utf-8?B?K1JiVGRZa0pRUGxsU2NkbUFBUFA5UEMrV0o5QWY5N0JKWTFQaGN1N1UwYUx3?=
 =?utf-8?B?Ykk0eFVIdmlGY3p4QmtsakFTWDZLTk9EcFoyOGdyTUcvZDF0aENLZXVXSUJX?=
 =?utf-8?B?VFpMTTFENjJseE1sUDlwbU5JdkZlUmNGeWRqNmh1bXZUSmVDeVRBaHdkeUxw?=
 =?utf-8?B?TVFWbUJYZ2VZTnQydzY1UzM5L3ZYcU0yZDY4eVhaWU5rSm9YUTd0dHRWVHFk?=
 =?utf-8?B?elN2S000QVBjaDlMSndSRm5FekliMW5GdHdOTjY3OHlBMmQwTEt4ZnZLWXVE?=
 =?utf-8?B?anNob1drK0FPRjB6bGxlRlJlS00zU1gyZ3RmSzB5eGFSV2tQbzV1VXE0VzVr?=
 =?utf-8?B?YTkydlJwbVhJOHo0ZXJGdE9ITU9jcDhTL2ZuNVJVUkRkbjhsVzFxV09GUWpW?=
 =?utf-8?B?SFN4UXl1eCtibGlMOFRFQW13anVnUnpKbTloUzF1Z1l4THQ4UUMrZkt6cklj?=
 =?utf-8?B?aStzOGR1dmhlc2phcG5KYVc2bmZjY3J4SXZvc25KQWtnUERGY09xQzRydnFS?=
 =?utf-8?B?dFdIdlNxTjdib2ZTZ1dTTzk3aUhuUlFkcHkrMWVna0hHU1I2bTlsR0Nnclhu?=
 =?utf-8?B?bVo1OTA3VTI5Uk4zSkxPRUg1amMzaTNkR3RMakNxcWZpbUlVeENjOUxTTHo3?=
 =?utf-8?B?SVFrTVI1U2gvai9kOGY3elJiWWF5dDBFelZEbXVHTjVuNFlzY2ZCL1ZnTW5U?=
 =?utf-8?B?WHNnbkZRRHFWVVo4NGJ4MEsvNlU0aHJmMml0WmdFODhHQ3RBODcrQUtZWG1G?=
 =?utf-8?B?ck8vTGduV2k3RXhJbU5aTS9aT2xIK0Q4aWdERUF6cjFCUTREdlVtS0pYQWIy?=
 =?utf-8?B?ZTJDK3BHem5WbWNHcCtlSUpvSGRyLzltdnhSZW4yN013RHFGWUJGS3FSekdq?=
 =?utf-8?B?R29NNmswWmk0OVpqaW9vdldaaTljcmU0VW41VzBTbHV4b25ReDhVa2hhUkNt?=
 =?utf-8?B?L1luVUdQM0ZXTGtBcWFvbzN4VG9NL2UyaFNabS9nbnR6TzZtK0FIRlZWUUtk?=
 =?utf-8?B?Vll0K2lvb3QyRTFJeGsyeUpyekpUMzc1NCtpRFFBZTlUZEcxOVB3cC9mZHFW?=
 =?utf-8?B?M1doQUtmRExsckZXYkpFL1hHWS9oZjBNN05lcW80aEk4QnBHeXpKRVduL2dU?=
 =?utf-8?B?cVdwdDFaZ2pjVHo3UmxSUWl4NitEcC9vWTRnaFl1ZnVhdU44ZHF1RUQ4Umlz?=
 =?utf-8?B?VXk4NEdmTERqdnlISnVHVlJRUlZlY3k2UGJTUDlxVExhVTc5S3R0UXpYTFhl?=
 =?utf-8?B?dmpvUkpjSVozWnVjL0psUUZFTUd0QlNSdFlQZXZIbHRYSFdkeFFHWFVHaCt2?=
 =?utf-8?B?VUxlVUNFdEZuK3d3VGpuQlFvT29qRXk5TUpzdmZHWWhvazBKYjhyK0tZMVJq?=
 =?utf-8?B?VDdTMUpZWFZLaEtXUWgzNWE2MmVCTis3QmhQMUpSaUVuaW9kRnREYzg1bjJT?=
 =?utf-8?B?UE1PZmRqSUxsbEJHUjNhOWtHZnZhRS84REcrNnFPUDE4TVpSWlVlcjRpcUtK?=
 =?utf-8?Q?TCxE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe37aee-d0dc-47ba-418f-08d998c1b9a8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 20:46:46.2366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDqSXshgnr0ixUf7Bxv1b0/bLwAYF2IubU54hFEwLRiHiv2AHDI4+HmP8L5Rhef+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2825
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

Series is:

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>


On 2021-10-26 10:45, Alex Deucher wrote:
> Add secondary instance version info for soc15 parts.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 44b0821b6ca3..d7c8d9e3c203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -931,6 +931,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 0);
>  		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 0);
>  		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 0);
> +		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 0, 0);
>  		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 1, 0);
>  		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 1, 0);
>  		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 0, 0);
> @@ -951,6 +952,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 0, 1);
>  		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 0, 1);
>  		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 0, 1);
> +		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 0, 1);
>  		adev->ip_versions[DF_HWIP][0] = IP_VERSION(2, 5, 0);
>  		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(6, 2, 0);
>  		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 0);
> @@ -1009,6 +1011,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 0);
>  		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 0);
>  		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 0);
> +		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 2, 0);
>  		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 0);
>  		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 0);
>  		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 1);
> @@ -1031,6 +1034,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 2, 1);
>  		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 2, 1);
>  		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][0] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][1] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][2] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][3] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][4] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][5] = IP_VERSION(4, 2, 2);
> +		adev->ip_versions[SDMA1_HWIP][6] = IP_VERSION(4, 2, 2);
>  		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 1);
>  		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 1);
>  		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 1, 2);
> @@ -1051,6 +1061,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
>  		adev->ip_versions[OSSSYS_HWIP][0] = IP_VERSION(4, 4, 0);
>  		adev->ip_versions[HDP_HWIP][0] = IP_VERSION(4, 4, 0);
>  		adev->ip_versions[SDMA0_HWIP][0] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP][1] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP][2] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP][3] = IP_VERSION(4, 4, 0);
> +		adev->ip_versions[SDMA0_HWIP][4] = IP_VERSION(4, 4, 0);
>  		adev->ip_versions[DF_HWIP][0] = IP_VERSION(3, 6, 2);
>  		adev->ip_versions[NBIO_HWIP][0] = IP_VERSION(7, 4, 4);
>  		adev->ip_versions[UMC_HWIP][0] = IP_VERSION(6, 7, 0);

