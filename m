Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F13C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 07:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A08060FED
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 07:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A08060FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE8F897F5;
	Tue, 31 Aug 2021 07:11:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFD6897F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 07:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3N/Wcmvw+DD0PNNfZqMQTdmwY6xcujYbam93Ja89gW1TfEzx7FUH4WNu5cZlNfMJlMdFt3DQ49b6QeHCTqlnZQ+MxdIii4VbzkIdTuGuCUmG1lkiNnkDFs041sjnYSShAIFTQUWvPmiEnfvEn3vvVfhlYzsBPxYR1u55QP5DNe0ejKdABSOoX/ClerUVZwXvbPYA+t4iiB+T/QXKV3TY2a+DSU68SnZG/FyORZrRy59ET2k6XPt0/PIDjYrRvyat8kOW19MJtEHmdZpd/VBeIBkWs6mXUAlkNTwqmtT/LEcMNrlnx88eAWGHtXZN232alvf1t1NwEoN+3yEI/Q/tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aX+4T10ZhSbS2Z0DyiVYueLUx+4u/Nhb4p8Prp//yY=;
 b=VZsK8PhcOYVCpFdxeouU0sXOmDUPUzHMWyhYSiFNgoa+rSN+VlM6If+RhIOeYPmYLByJguTcyw8DPkI92jMYCXriBXc2rBJ2FpBHnpslQmIRrv027FnyobnqIVyElSlrVAyBoqJ5xRbINe3KPtpIZNcpzRG9mCmK2nvuhoTyovouU7Iqr5BFZVFkVcKWSqSRDaYL3Q+QoPzFBCbC+tHZzuY3cOx/cxl9gFtUNSvdP/OWVIHfUmIyzqMN4921STHGOlY1G+klg2RVrYnupgbF6bdna1SfHDAZciMEdw5XGDvnuCEVRYgxOIeGowJMsIr2djTA+4ORlm8OZLVMyUf1DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aX+4T10ZhSbS2Z0DyiVYueLUx+4u/Nhb4p8Prp//yY=;
 b=CqyrD65+NWYGMvLGHGisoupbc2alSS4YL0hFOcqXG0e5xy4XEAu53FnUGu9+NzlWu2u6noTvVV1RKD9nbCQ72wKHYFDwmdGWYbJrj0/0DzC/aLPUxJHWjHwshgW5JRbfKRu6zThjpSJsxD5StxRc0PQhI3dHjofV3fS0So8wsGk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4930.namprd12.prod.outlook.com (2603:10b6:208:1c8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 07:11:26 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 07:11:26 +0000
Subject: Re: [PATCH v3] drm/amdgpu: Fix a deadlock if previous GEM object
 allocation fails
To: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
References: <8DA06109-D89E-406E-954A-27482501B3AC@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b601ed47-c625-36dd-f1fe-cd0f4593c03c@amd.com>
Date: Tue, 31 Aug 2021 09:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <8DA06109-D89E-406E-954A-27482501B3AC@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM9P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::8) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM9P250CA0003.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:21c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.21 via Frontend Transport; Tue, 31 Aug 2021 07:11:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682e81c5-9a5f-442b-d7d7-08d96c4e8c18
X-MS-TrafficTypeDiagnostic: BL0PR12MB4930:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB493042592EB65FD51A6E96C783CC9@BL0PR12MB4930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M51EacvvrxlyqQCBDD7+g6LXkx6R5QZXsLn3CdcF0ARexPk5T1/+LUmUynnu36NZxxeSrbglJeMG5uB57+jrniaunWoITuN4iUUWisd5W5Xm5M2VciBQLKZRaGhzzYn2kxcaQHo4ZfZAnVWFg0H+EPRFPlqND+PdCVDkDqYADiE2OkW7AgSQIlEwH+qemwqSSQoTcSrf/p4K0nmGJyJftbYp1ZRWRKFqRHSUVt5eJ7Erl44IlskPHn6y6Nc/btBZUYYU27gRBSEdffCFsokPRnlHthicQ/L0oG3/4BXoRH1/iawn5Rbp7aUh9oKOsuX/xJ3ySrH6/Lz95W6HkBRncIfiWCBbBvle0v3VNxnIDBpvtZHH2GTSailr63424z2cYPasjs3LsE3VYkcVWeVBiQs3buyhWlMw1K6DjJr4spJsQVvvo6Kf8hKiMpnsFdEjSaM7H4D4U6/WLT8Mc4m9ylA9W+F5EJY47CKV8xj8UrFS7je7kQRX4FBOGXnolJUM9lF+Osky7HvvMyIuhYNx+tiRSDtKW8Bzs+b/Oay/2X3l7bNKSGdc8JXpzl2G3u9tHMnDPqMF7EF+VfMmjktkbqJwhOKt2yeK7SBoywutGfh4LOU7o6BpIEr8qJ/mRnlv3ZDHJ3LbNY5ykFB37bi+Se8jhhQRNZg0rJThtksSEMZ2G3Lw1/ZmeV6vCp4d9UtaDRKs4gcgQXuH0Dm7EoV1VKvEc/VT5oUcFh0r6rMGk60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(38100700002)(6666004)(4326008)(186003)(5660300002)(66556008)(83380400001)(2616005)(110136005)(66476007)(31686004)(8676002)(66946007)(8936002)(54906003)(36756003)(66574015)(6486002)(86362001)(16576012)(316002)(31696002)(478600001)(956004)(26005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGVvVktCSlVFWWE2eUs0NWk5eCszM3k5NHdVbE1BVEREYS9UYW4rQTlLQjgw?=
 =?utf-8?B?T0psc25DdkRhdmoveFpnK1hjT040bGdhVGhKa0lnU0hQak00QzhOVTNFY2V5?=
 =?utf-8?B?dUQ0VExJOHNsa3p4YzR2bng0MHdLT2p6U2FUSFlUbHBqdlhPYUxDK3lHUXN0?=
 =?utf-8?B?WFdhYlB6YmxxcmxNRGlQQUtKM0U0U0gzRm1MSVAvL1VnaU5Jd293aEZiZ2hT?=
 =?utf-8?B?Z0lDWnAzSnZETGZrVkxDdWQ4VlJ6ZlMxa1ZLVXBBaGlSeGt4U0w0OUpYWUpy?=
 =?utf-8?B?TWNqZjJiNGwrTFVDbUpWS3ZVMmNLVFdJNlY2N3lOTU9RclBmNWl2dzdHekoz?=
 =?utf-8?B?N2xtY3JwRkJRb2VKKytDazNINzFFVWhLUm95STB4QStianRkcXN1OXRUV1h5?=
 =?utf-8?B?NlNwdW5CRlRaK04rMi9NK0JjbTFoUFU3cFBXYmh2OXVNMUxZQ3R4RGdHS29T?=
 =?utf-8?B?R2M2Ukl2bTFlQXV1L3luRU56N3BEOXRDem5HY3V5M0grbC9TZkdNL1ZNL2pz?=
 =?utf-8?B?S1pwOTB4L0lhVHFRTTRtL1VQWmxhMUVRM3NSeFFuK0g5dmNKVk04eTZPUlpD?=
 =?utf-8?B?NkNqTTN5WStEbFRNWlRtV25hSENVaTdVcklYRkpwWVl2eW9Nb0FpYmVDeVVr?=
 =?utf-8?B?SnlQK2c2cUd5WGVleUhDSzZqU0NkRFBaWmtSV1lJRHlSdTgvdjBONlNCbWRW?=
 =?utf-8?B?SGNZVWNFaXBYTUZCMWtXMHZTWWFtdVBwWkZCTk9ENFFLazNkQkFnWmtVbThR?=
 =?utf-8?B?MFBGUG85b1Z6WVQzNXE0RXhlak1mN1Y2OVpnTGQ3OWNOSjZPZ0pTQ21EYmND?=
 =?utf-8?B?TkZ1Wm0zVVJXdXRURWs4TkFZVDF5TXZSSWpvSmxpWHlkSzQ2Mi92WXhuTDJB?=
 =?utf-8?B?ZXVyNmJZak04blhUQmFjYmt0RVR4VTYxcU1Id3Z1dTVnWWVpdHpyWHA5UDNw?=
 =?utf-8?B?RTNSdHpFaFY4UGJLckVOeVpaRFlRNjJib3pFSS93MVRVWXpIM0pLclJSbHhJ?=
 =?utf-8?B?R2QvdFphWlR2UWM1VHV5a1ZlK1I4dlcrZzVxaWVRamVJK2FkTXNEZlN1My9k?=
 =?utf-8?B?OHZYWU9IZ0ZtTUxPNVN5US96U2xScDlXMjcvVkQ4cDAwZk9oVTNZWDE0NHhh?=
 =?utf-8?B?M3JUWjNVbnUxM3JkR25oQWlSSFY4bTRPZHNmTFpNK3VTNVlrQzVzdlViMk54?=
 =?utf-8?B?Uk1JMFErZzJ3NTJ4WUNYRGM0dVQxaWFjU0RrYnM4bzdHbHBsenFWTzc1SWtO?=
 =?utf-8?B?ZFdqTUQ2emtEMTBKSWYrMEhMaStGWk9ZRHowc1lyRHFZN3Q5UHd6ZW9rVEFC?=
 =?utf-8?B?VTF1ZXpwaHUzN2RISWlOc1oxaUlJV3g5OHB0S3ZOdGl3dmxMM2R2clkyUTl6?=
 =?utf-8?B?bGg5b1hLT2s2d2tVcmN5d2drbjR5c0h0UStyOUtwS1RzSTdQQzlYSW1rZnNS?=
 =?utf-8?B?bExkL09ISFMza3QwS1JTeGdXOXZucW13cnZFZjZVZjQ4QnF0RHJLbVF3K281?=
 =?utf-8?B?OTYvejhieW11NTBYL0VSS1h1R2hHSmdveDFJOHllWDFidTFXMHY4R2k4TTEz?=
 =?utf-8?B?dEc4UERneEo0Mkd2SjhjTXk4VkNLYXF1SkpsUEZxTHp5L3Q1dmtlM3grQ3h1?=
 =?utf-8?B?OUZIMXNZVGNDNzdsZXI5WHNRSktVZW5JOS9mT2RhVUdTV3FoT0lqbm9QMU1Q?=
 =?utf-8?B?QThEOGcyL09NbGZRYSsyaENTdURwODBHTkdvYjg3bjdjNXgwd0hFeUtsNXBy?=
 =?utf-8?Q?Rx/pUTnqvIbaE0Xb3jUchcMjtnqbDdtJvTF9hP7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682e81c5-9a5f-442b-d7d7-08d96c4e8c18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 07:11:26.5461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyI8JzT/XGln1sadIyJMJ4w4oJZaqibvQ2Nbgy6iF+SCwTCGFIA+Yz61JLuRdqhi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4930
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

Am 31.08.21 um 09:08 schrieb Pan, Xinhui:
> Fall through to handle the error instead of return.
>
> Fixes: f8aab60422c37 ("drm/amdgpu: Initialise drm_gem_object_funcs for
> imported BOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 85b292ed5c43..9e2525b96d04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -341,21 +341,18 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>   				     initial_domain,
>   				     flags, ttm_bo_type_device, resv, &gobj);
> -	if (r) {
> -		if (r != -ERESTARTSYS) {
> -			if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> -				flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -				goto retry;
> -			}
> +	if (r && r != -ERESTARTSYS) {
> +		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> +			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +			goto retry;
> +		}
>   
> -			if (initial_domain == AMDGPU_GEM_DOMAIN_VRAM) {
> -				initial_domain |= AMDGPU_GEM_DOMAIN_GTT;
> -				goto retry;
> -			}
> -			DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
> -				  size, initial_domain, args->in.alignment, r);
> +		if (initial_domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +			initial_domain |= AMDGPU_GEM_DOMAIN_GTT;
> +			goto retry;
>   		}
> -		return r;
> +		DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
> +				size, initial_domain, args->in.alignment, r);
>   	}
>   
>   	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {

