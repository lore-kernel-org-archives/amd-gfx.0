Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D781C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C71061090
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 16:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C71061090
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA8E6E05C;
	Tue,  7 Sep 2021 16:48:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5264D6E05D
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 16:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGtlduBQBrFuDGW2ab3OOacJo92yIcaSf7A4A+BrfeD15zEOBfXh/C+q/PUFfkCwB63bFhgWyOJKsRWZNsdUXF1jYfQCxdj6q3Ti2Wy25ObkZ+vqdXtLbOez8bx/kTtybSlImACL2jmounJYTh9i5P+hfAd68VtHeSNgSIE5yf8nQliM9ZcLhicCNnJUEKbZDlOLIPykRVg7CyZjlCh5FoZMepfBmB7ITXl61uRTd6JKY5xWa2c0CJLdpmCOdL8e/UcHlPypXUp9zdMQKJPouhH1fJ7EIyFRj23Shzrmmn14O+YcftnDjslL6p2EfXx91zi7iWjFhlzV+o+ClPZKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=31EUQOuTGc7Bmw2KCgmQM7cn66EIb1sPEVOZII26mqo=;
 b=Pmg5QKpka+Iw6YwV3hklS0iNq6YlJqFOqQtRsnvqpn4EOzLplhE2Uq/cTgLeYNQEIpKfbEKumakmzwqFOVqcsDsUb9HJzx0UvIwRSx0PzhogppWxaVMFTpEuCqTKRgEg4XXqy8p0c4IPWCmCP4eyRBxCdL/AE9dYPujOTImX8jGlJ45qSN5F7nTN/6p3ELEWUidmgSkGXJPlmON5gDi1IkmjtJ6QgMSClsmOjJ6j/0ZUWKbSOLvJ5BTERcwoqbpd9GpHcS0vS4cNTw1sfqAI7mMHPXRY3WOIJn2fdXP5TEgxDLm5s1XIAGqgEuPUjYrtL+85H9cXh399VJqkBPznUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31EUQOuTGc7Bmw2KCgmQM7cn66EIb1sPEVOZII26mqo=;
 b=0ZVgVU/jL6EZ4rrfVqAR9BmD+EuO4pHYjnqkgPqe0uDorcgYqVsjY3Y3HCSobXYGMW5VAZklAxiKa0BIsu+KzKZZW8AMAKk7eCAZ88TOgM//AQrS/GdYTH1FD19W6En99+z0O2X0BHUi03UY2C0+JFWymuTiyi1MMzX/S3EN21A=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 16:48:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::94bc:6146:87a:9f3c%5]) with mapi id 15.20.4478.025; Tue, 7 Sep 2021
 16:48:53 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: move iommu_resume before ip init/resume
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: jamesz@amd.com, kolAflash@kolahilft.de, me@jeromec.com,
 alexdeucher@gmail.com, ted437@gmail.com
References: <1631030843-18270-1-git-send-email-James.Zhu@amd.com>
 <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <03c5e276-c478-c33c-9f75-e03a56ef16a6@amd.com>
Date: Tue, 7 Sep 2021 12:48:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <1631030843-18270-3-git-send-email-James.Zhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::23) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.186.47.3) by
 YTXPR0101CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Tue, 7 Sep 2021 16:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 629d699f-3a08-4983-cf1b-08d9721f6028
X-MS-TrafficTypeDiagnostic: BN9PR12MB5114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB51146C0415077EB94A3E116E92D39@BN9PR12MB5114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PD2LwbbiraAErEcjnYYikVbBnt3Mlitxu30ZZFQRJG5Y/UsGK+fHRj5MVuYOObun4Gx4MG6NSqrOHcHVnETnLXLfDk74I+S/k9zj7LY3CkTa8I3ncSYk0EFK9EhHKcBx26NUmEB5HNyxbrdw1JYkYd5vJaitowBr6nYGnCmEAlE4bGSo0VihO5MAC1HlX4e190EMMqGYJ5onQh7z6bq5j9PiKLZS20iYZwNz0nc7vUzmLp+r8FhY1r0FeYGCMzVsRLFsV+8VHfpudjWSgjfVILFYXyeEmsie2qKlQNvFrzEnRpVykGz4A7nc+xzIwr7VAcc7k6PYwM3ePvcuiFV4SuBt30O0Fmt0BCRtg34TYltTR3JJe9cnIWmcIn9wbcqmRKyom2GgKcDjlIgngt4VfgoWAj+zUTHig7UuThYUwZ+XOlQ/sYG4/5R2PoIzIWJjp+JBbGz7cT05DeWGwXPiydByGqx0/KxmtCtR3zCl820Ao+y/MNz9p7TyUfMqgLOrTtfdw3Ro9SEDp9v50jFuo106PNfKkS8ziHLesPtq2SRxZkXnF54p2bcMsezKR4g6CORn5Cl/52Mb4BrGUcVw4asiAiMG1iJHnvTwrkNPOjOf4tMY19Ins8XcAUbRWMUnMeC0DJvoypbgbmMRivh2vr5gZTT+dbY+AbLjRpafp9dJ+LcPxzT0VhW8xDjyEStyVIACU2IFfy5KcXDqNU9CES44cFIuPeXgGzxW5+B+/J2U4MkU1W4STAcEhCn/MYyUwKDrY4Qi9H/UZ8/R5m91yFVEErIrcQpgtNQiqlB1FHbFlkGq8BToiU/7HU/07mrO
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(8936002)(36756003)(8676002)(5660300002)(16576012)(31696002)(186003)(66946007)(38100700002)(66556008)(66476007)(6486002)(86362001)(44832011)(316002)(956004)(966005)(31686004)(4326008)(2906002)(2616005)(478600001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3pBTDlxWU5SVmFtQTZrYnJ0MjZDRnlRbmlXbGVERzVMTFFxVFUyRHE1aXNw?=
 =?utf-8?B?WmNXYXlzY2w5K3djWFdGUG0rcC8rQlUwS1ZDWHordnFSZG9aRkdQRGI4Yzcx?=
 =?utf-8?B?MTFTMkFJamNQZncvT01zaXEyeTJjU1JlMUpsa240SXMxdXQvOVcxalBWTkJO?=
 =?utf-8?B?YzB5NTBxZ1VBM1BxazJqT2tLVVQ0U0FPMG1SS1NaSmE0N1lMMUx5YTN5RXJH?=
 =?utf-8?B?enZRR0NQZ1pWK3ArVi8xdUdBcDRKZGJ0czZNamg3MTdNMnNyblJGWm9SYmpH?=
 =?utf-8?B?d3VjbUJqalR1VGswWTZsVzdWay9XSkloVWd0ODZncGk4QkZNN3c2YzhyQUM1?=
 =?utf-8?B?N3R5MmhoUzRRbVUvOWJVQWhoWTVDRGZsQkg3TXJ3WWdWWHBlR2tBcU51dXlX?=
 =?utf-8?B?L1pjcHY5TEZRcXZZSDhIQU9zU3lyS3FObWU4dUNnM01SZ2U5WUM4VWNjRkdw?=
 =?utf-8?B?MEFFU0lxTXFMQ3czS21lNkdkZWd2MHk0ZGVzb2NLdEt0OHhObjg3R0tpY3VK?=
 =?utf-8?B?akNZRkk4SnBZYUNXTDRvNTBvN0RFdkk2NkpPQmJtMUFjOFgzdVZuemhVVnFI?=
 =?utf-8?B?TWJJT0txVE15UDNEWG4zWjF6dytKMTZzRXh0TGordE0xZkJlaE84TTJadnZC?=
 =?utf-8?B?NWpGdmx0L2xuNnAyZXVrOXE4bWFqczh4SHordHNGSGZ4di9xb2kvWWd1bHpB?=
 =?utf-8?B?QlI3RlUzU3NrZXQwMk5jWUZmRDFyL2JyMzdoM21mWEFHUUJSQWExK2hIamFW?=
 =?utf-8?B?ZUN2ZmNXRFBTY1M4b2NLVnRVMDN1emNWV0hVYVkxNGUvTmJIbmdZcDkrNGM4?=
 =?utf-8?B?L0E3K3Y4Q1o1RGlhMnBRaHlaTlBaNm1ZQ0RuMzlzaVJOdjFmUVRSWXBhTkpG?=
 =?utf-8?B?N3N6RFB0UUZ4T3M3cHBrOVF2a3ZyUlFESWZBNnB2eWRJZ1RCbEllZ0dZSlFZ?=
 =?utf-8?B?YUpzZGtKYlE3b1Q4dTdJd1V1VmttVWhmUWg4MlVRczZnZU82bFhIaEdWNloy?=
 =?utf-8?B?TnNiYzNHYTZITTVnZ29ZL0tHRC9CMEh0MzcxK0JGUkkyZ2t6anprdGdmSTNC?=
 =?utf-8?B?c3hVd0I5YXNzZUQrTnMrNElhMmx2c1RibHJieG1zejltTzJrNzYrWE9xWTN1?=
 =?utf-8?B?RnZKWFRRUFByYkJGM2VEc0p4NEJocWJvcXlrVGtLbElLVTMxN1JPZEVLdVc4?=
 =?utf-8?B?QytqQXk4RFE5a2ViOHloZUlYS0dZNnlBRW5SSHdzZ1lNWEI1Q0lXbE5KZXZU?=
 =?utf-8?B?K2cybUlMNkw1UC9PTWZTbWl2bGVKbWtUckRBMlQ0V3daekdVVWdtN1NNUW5E?=
 =?utf-8?B?VFlRSUFMM21FQU9JRS9QblNJSi9tVWdaRWlaeXNpUnNiUVl2WS81T2hCRXM1?=
 =?utf-8?B?enZ6WW9Md2VIQjJzM3g5VTlDT1NhbkE3ZHhXdGVINDZZdWk4LzVxUlZBVzRB?=
 =?utf-8?B?Z2JEenE3S1AzbURVVnRvTWdjR1E4cWlHMjNlL252SkNNMTkzb2E3QXpLcVFC?=
 =?utf-8?B?L3FjdkZ6amdqeHk5VHBMVGYraXhUbzhWdngyekpiR0FRcHZkK2llT2dZVkVU?=
 =?utf-8?B?VHQxRnZxVlZYSmFPdzkzdmNpMnlZdVF0UHdHcGxrRFdDeHFjNWJ5T2VJOVNx?=
 =?utf-8?B?Ukk1SjIwNlM1TEFhVTIrTy83VnovMmhXNUtwV0grQ0NiVnlhMHZtU3BuOENy?=
 =?utf-8?B?T2ZONkpTTHNaUnZCRjRBYmpDcGo4cC9NSmdUcytXR3FBdlRMTWliQU1hQUpt?=
 =?utf-8?Q?QsIJvGHD+Njg9EwQYx2Rrs79X9oAcKzlk/Qap32?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d699f-3a08-4983-cf1b-08d9721f6028
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 16:48:53.4237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OugP9jLfK4IcxVaxv0faZ7yzCldyQ4bBff9C2TIJBrQIAL4qHFZKOjpJKxzNJZ7Fip+dDLGPRrhsJYyg4DAPrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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

Am 2021-09-07 um 12:07 p.m. schrieb James Zhu:
> Separate iommu_resume from kfd_resume, and move it before
> other amdgpu ip init/resume.
>
> Fixed Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211277
I think the change is OK. But I don't understand how the IOMMUv2
initialization sequence could affect a crash in DM. The display should
not depend on IOMMUv2 at all. What am I missing?

Regards,
  Felix


>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 653bd8f..e3f0308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2393,6 +2393,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> +	r = amdgpu_amdkfd_resume_iommu(adev);
> +	if (r)
> +		goto init_failed;
> +
>  	r = amdgpu_device_ip_hw_init_phase1(adev);
>  	if (r)
>  		goto init_failed;
> @@ -3147,6 +3151,10 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> +	r = amdgpu_amdkfd_resume_iommu(adev);
> +	if (r)
> +		return r;
> +
>  	r = amdgpu_device_ip_resume_phase1(adev);
>  	if (r)
>  		return r;
> @@ -4602,6 +4610,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>  				dev_warn(tmp_adev->dev, "asic atom init failed!");
>  			} else {
>  				dev_info(tmp_adev->dev, "GPU reset succeeded, trying to resume\n");
> +				r = amdgpu_amdkfd_resume_iommu(tmp_adev);
> +				if (r)
> +					goto out;
> +
>  				r = amdgpu_device_ip_resume_phase1(tmp_adev);
>  				if (r)
>  					goto out;
