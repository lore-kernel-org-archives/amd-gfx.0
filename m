Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94958C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B46611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 11:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B46611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD64A6ED22;
	Wed, 19 May 2021 11:27:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D86D66ED22
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 11:27:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VnWcjW7qmwHvyW+yoYPPpPedeUwwrrM4yODBBE+9fv/n6I0eoeIiSwxU3PFexbTgLdXANKRl3MghTQGezQ1y0dmLvNK6mZ3O5fAO1+kSE+ZdFkLxlLOKFOGRgEa1O/x16m4eTcFfMrg+QHuxpSfpGVXsaKY5Q39JKiTwkn1k3rkI4Ug3vHOoW9YfA68sdqL7dPUxGsERadkMEZ2PQZi3b8Ys/kXS26AjlclLtADD7QAhgh9AUuwDP54Qg9uTcBObPCeBwWWIXEmZHKcbJ8VVPUZ9VR6kQK1bbsw9xgQ8jRMmkBj5fNwmPykUR6rgdjzHA0lYFYd6+/+x4y5mHpz0Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+Fr2NND4GPZYCWgXpqnLrml3YnhEU32StphuAlBd1g=;
 b=BlE7kotLelAiW7rwoKStZqUEQ5cH9VrhkjpjJsoXcVcV42LF7qXuqEPvPKPAL/Ij+wzzbQMNweRFFtfjBEyC3fUHuX9DJASvqujxP2v9ssvvygjhbIYjcKykcFvOpgdCIt7dWWCsStm9GbUAcVt21sYpP03lPejVRp5ot3gyhhRKRUxdLuMHMQw8IBHDCvgWHZSKTEBKc+FJim344ke9/lrt0bG24UqlJd7c7L7GmQE62JxnhIqqKXR+sTqubpSSXZ7o9+m96RSYi5wi6WbO7rcrrvqdeKM8YDeS1oYXX5JofR2dM5nCcwv7VavnuJ3Ro51ixYD59c8ABDxS5mbxBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+Fr2NND4GPZYCWgXpqnLrml3YnhEU32StphuAlBd1g=;
 b=FgbAo5r+CGF1aa/AaHiW2hn0T6Vl4hVSI1dFHQh1RlcMBy0j6scAabwcWpJNje2xt9GsNZG9LlkeR6xPVzC7LrIkijbvx9yixnfzwmXY1F2JsROJ/R8r6WZThlT30v1mTNfoQwAEFegnvS0xZaRgeWsdyS7DNJmVzlb50mW/3c0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 11:27:34 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 11:27:34 +0000
Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to avoid
 compute hang
To: "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>, "Zhu, Changfeng"
 <Changfeng.Zhu@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "Das, Nirmoy" <Nirmoy.Das@amd.com>
References: <20210514081944.16849-1-changfeng.zhu@amd.com>
 <CADnq5_P4tvpTkmzpn=7V8qvfvy3aiR3WO967UObKKacJzQro9w@mail.gmail.com>
 <20210517062724.GA1853590@hr-amd>
 <MW2PR12MB46847BE39163543C680AF9BCFD2D9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CADnq5_OmpYjzaeGPUC4rUNkSo_CP+8zFfZQsF6d+2fLegtxUkQ@mail.gmail.com>
 <MW2PR12MB46840D259987CA9265317F75FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <MN2PR12MB448807A739B82ED7721E4A5EF72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW2PR12MB4684ECE117B6D8CB2FEA84F2FD2B9@MW2PR12MB4684.namprd12.prod.outlook.com>
 <CY4PR12MB12873E4A35B066FB196E4C87F12B9@CY4PR12MB1287.namprd12.prod.outlook.com>
 <MN2PR12MB448886D0F0CD237D056B3445F72B9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MWHPR12MB12481CD68B579778D851B88FEC2B9@MWHPR12MB1248.namprd12.prod.outlook.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <0d795485-585d-5784-608c-d6f8c7f2b118@amd.com>
Date: Wed, 19 May 2021 13:27:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <MWHPR12MB12481CD68B579778D851B88FEC2B9@MWHPR12MB1248.namprd12.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:404:10a::17) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.40.28] (165.204.84.11) by
 BN6PR13CA0007.namprd13.prod.outlook.com (2603:10b6:404:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.11 via Frontend
 Transport; Wed, 19 May 2021 11:27:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96be3649-3186-4ebf-e469-08d91ab91875
X-MS-TrafficTypeDiagnostic: CY4PR12MB1830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB183005367D3215D1A25815078B2B9@CY4PR12MB1830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tbskwwp7iODtNOZPpQ+fsJqj8xGSJ6JIqHI80pyYDIcSYQRu71AJMJvLPz4tmZ1gnsQJssaDLiR+yOebyLiJJh94sJD3PAc0VbOFe6qMAqTI4qVk7MGK9TfuRw9AI5I8fjGOy/dweac10NxOrXNYJQJ+4RbQYHh9NSN1ymfdvVvsEa9CjCDE7G7vM0/nM4qO0Z7n6+Q6inNvwG63PfOpqqv1Ijja2YXIO6pZjw3m0eQVM9PjY2BBSA9LZVEFis9HA5oS7yUUGjccl+Yy9Yx5JPemFYsMFO/HdfrDn1hPcPmOhELlPrx9TAK0oeOHbdqRUprb3afW8JLIc/CiVw2OtVd5kiN80gCeVqBSMxE9vQbodGIW+Q85YvpY3dKoc+KmmpVBzMUQumbYmqNyq05ruzizeLTq0tUWmOumKh8E8jn/tWBmQI6gJdCEDFWXoH7xfAwdNL2m16nyOmD3wByssCvFgYD79fs1ROIsReYsq9XJED7ArTdny14PD1WZzC1gVGi+7Erp7oNcJV0mtHqd3tu8FeICqW4NTuVGrhlXOSBOw7JA60dD0nxJGEaqybJ6OF94H4RSZ4wwuFtAftLvfMvaW4Obq4FjcfJg5KljcP6ATpKhnVYuNx4dxevsXdLll+sOCjgYiYkOuSbRVlThTHKsNM2kkO/Dtdmrbeq8zsSrnoK7QdrZFQExfHtJGfNrpTkmiKMydlaLoG7BtQfOBfCi5n/cJU/ENVQA64mLbJixIQljnQd0+8RIvKtp2mpM5cbewle5a6zp7dzs84CaXPHzWLCjECAxMZeMixh1MYBByYQyWHluIDevgyh6rzyk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(38350700002)(38100700002)(83380400001)(16526019)(66556008)(66946007)(26005)(30864003)(66476007)(4326008)(5660300002)(52116002)(53546011)(966005)(2906002)(6666004)(33964004)(186003)(6636002)(478600001)(45080400002)(8936002)(54906003)(110136005)(6486002)(31696002)(316002)(16576012)(2616005)(31686004)(36756003)(8676002)(166002)(956004)(921005)(45980500001)(43740500002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlUveGNBOXNidnJLT2trTWJMaks3ZkF3ZWxmbE8wZXpiTzV6RVQ4ZlB0UTA3?=
 =?utf-8?B?ZjlxK1Zua3VQK1dsMzhOZXB0NlVyL0pQak5FekhqSU4ycFlReFBTYjY4KzFN?=
 =?utf-8?B?cFA4emJwTzR2MWRETE0vOStLemd5Y1UrdkFtYWw2d3NDbmpad2EzQStwcDZu?=
 =?utf-8?B?M2ZDdi90MEdUUmRuUDZJWGd5RmVsUUMrbnFMMkZDTWZYOG54K3FlUnRYcjNS?=
 =?utf-8?B?TW9CbXQ3T0JIYVkxeitnN3FwWSsvSmJaekZUL2VXaTlxZ3BlVTZPK2VXTzJW?=
 =?utf-8?B?UlVlS2hPTmVuWEJBdEl2K3VtK3lLanhRRXhEMjhyNXZ3ejMyWTdDUFBFbkJY?=
 =?utf-8?B?KzNqV1pFVndLd05oL3dsdXhsaUxLMjlkakNLUm9uMTErNFJHVC81ZUg0NU05?=
 =?utf-8?B?VUhrR1lLRlpCL1JKV2E5NGlIeXJFbEduR2ROMk9mNmpnQ0ZHV3AyYkl2VXk5?=
 =?utf-8?B?dTJXSXdkcXpxNnJ2dTR2YVBFWjFrYnV0ajJMajhveGI5R0VDY29pYmlqQjNk?=
 =?utf-8?B?VEgzREFVd0U2ZkZFR1hjVE5CYWJWSXNCdUl4d25uRXJ5K0dCcWo5eVQyZ08v?=
 =?utf-8?B?SCt5RWRDcThMeFhudklVNVBmNFZhVUN2dEtMd0llblhuVzZ3cGhKM28ySTZP?=
 =?utf-8?B?a1BkZW0yb1ZHYnFYeVA5YjFTWVhHTEJMdTd5clczMlFlNXJmVjRrZUlEVmNP?=
 =?utf-8?B?R1RoaVhZeS91YXhTWXk5czNMVFJaVnN3em1qVzFSRDRPbGpFVTRFMFRzVk01?=
 =?utf-8?B?NmNIMXkzc0xoQ3drN1E1cjhtaWNLNThnMW9yeEtwM25TS3FnQm1abnRKQ3p3?=
 =?utf-8?B?eUtHYzl0ZCtvdHEyWmZSSWxVdEJ2V2hrQ1UvM1Y4OXlSdHowMktIdk5neUsw?=
 =?utf-8?B?TEQvbGUxQ0ZCaE1MYmFyUHJ6YzZSdVpMdEwrTFVXQzFYQnFjcnVaRFZwTklh?=
 =?utf-8?B?cGpxRHhJT1FmN0NPRjJWaytoWVBMc3JxTU02SVp3TkFPSWEvelByZ2RjSkxl?=
 =?utf-8?B?TTdnTk1IOHFMTDY3QVRTSEtvZVB0VGdiamtZb3d0K1doVktlUW4wMWNEemJh?=
 =?utf-8?B?Rk1zNllDWTRJSkxRRlZPNzZBdW50NVp5N01qNkhCWWRMd0podkNpQ0VjSTIy?=
 =?utf-8?B?R2hzRU9MdlJuWWI2cmh4NkRnWDI1VXFVb09ZRllNSFVIVFZNQVdsUVppWkVa?=
 =?utf-8?B?clBLN2dlZFdsS2VnYW4rWTlCbG4zMVZ3bm0rRWw1MTJ5bXZUdW9WZzg5MWxN?=
 =?utf-8?B?NzFVV0ZXOEZ4NHhyeWQ5Q1lPelA0dmdVTGM5UHFmWWZHSGUzZWRyMU0yWTFj?=
 =?utf-8?B?MGJwMkVhUkhMY0x1ZUZQbDBmVXdWTlluK290djZJR2lFNWJqV0Z3djBxNERS?=
 =?utf-8?B?NndLY2hhZkR0M0F2bmEvaHo4RWN5VkN5dlo5cWpBYU1jNk9laktYOEdaZnFq?=
 =?utf-8?B?Qm5QK243Ti9GVk0xVWVQVkdVVy9jR2F4UEE0bVNKS2dYS1hqRHRlbk1SSzVx?=
 =?utf-8?B?ZU4xR1k0OWxHVCtJNVVSNXN5WDEzZ3YyRlVMVlhBNHlWQjhMdUpsbFpwemJO?=
 =?utf-8?B?b2FWTFRDcEU4aURJaC8ySm9WU1plU3ZzVEJxUmhXdms5ejFBdFNCdjY5MHFZ?=
 =?utf-8?B?eG9NT1ZLbEJYcm9lelNCZ2d4YmxmMFc5SDRyY29KaW5za3JrOUliU2I3OGZW?=
 =?utf-8?B?Q2JnSVhhSEN6Rk16bUp0c09uekd5MzE3OG52Vk16ODJjeXBpRHV6cVZ3YlhN?=
 =?utf-8?Q?64oxRZ0K2EFRYewHWb4pgo/pLIdZo3SxchbtB8x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96be3649-3186-4ebf-e469-08d91ab91875
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 11:27:33.8444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mdnqiF7PHACfAywCn9ponR3ZOO/a+lp+mFLE9SoVdBt5pxiMJ3Irh8FM7dXwMt4m1yQu+gIH1HQ1MtqYY2rSgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
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
Cc: "Huang, Shimmer" <Xinmei.Huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0503868002=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0503868002==
Content-Type: multipart/alternative;
 boundary="------------8F672C0B21C007DE9559ADC1"
Content-Language: en-US

--------------8F672C0B21C007DE9559ADC1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/19/21 5:14 AM, Huang, Ray wrote:
>
> [Public]
>
> I check the patch (below) to disable compute queues for raven is not 
> landed into drm-next. So actually all queues are enabled at this 
> moment. Nirmoy, can we get your confirmation?
>

I indeed didn't push the commit that disable all but one cu for raven. I 
was suppose to check with kfd as Felix wanted to

know if that bug affects KFD. I think I got distracted with something else.


Regards,

Nirmoy

> *diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c*
>
> *index 97a8f786cf85..9352fcb77fe9 100644*
>
> *--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c*
>
> *+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c*
>
> *@@ -812,6 +812,13 @@* void amdgpu_kiq_wreg(struct amdgpu_device 
> *adev, uint32_t reg, uint32_t v)
>
> int amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)
>
> {
>
> if (amdgpu_num_kcq == -1) {
>
> + /* raven firmware currently can not load balance jobs
>
> + * among multiple compute queues. Enable only one
>
> + * compute queue till we have a firmware fix.
>
> + */
>
> + if (adev->asic_type == CHIP_RAVEN)
>
> + return 1;
>
> +
>
> return 8;
>
> } else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
>
> dev_warn(adev->dev, "set kernel compute queue number to 8 due to 
> invalid parameter provided by user\n");
>
> And I am glad to see that we have a solution to fix this issue at 
> current. Nice work, Changfeng!
>
> Best Regards,
>
> Ray
>
> *From:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Wednesday, May 19, 2021 11:04 AM
> *To:* Chen, Guchun <Guchun.Chen@amd.com>; Zhu, Changfeng 
> <Changfeng.Zhu@amd.com>; Alex Deucher <alexdeucher@gmail.com>; Das, 
> Nirmoy <Nirmoy.Das@amd.com>
> *Cc:* Huang, Ray <Ray.Huang@amd.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> [Public]
>
> I thought we had disabled all but one of the compute queues on raven 
> due to this issue or at least disabled the schedulers for the 
> additional queues, but maybe I'm misremembering.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Chen, Guchun <Guchun.Chen@amd.com <mailto:Guchun.Chen@amd.com>>
> *Sent:* Tuesday, May 18, 2021 11:00 PM
> *To:* Zhu, Changfeng <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>>; Deucher, Alexander 
> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>; Alex 
> Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>; Das, 
> Nirmoy <Nirmoy.Das@amd.com <mailto:Nirmoy.Das@amd.com>>
> *Cc:* Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; 
> amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> [Public]
>
> Nirmoy’s patch landed already if I understand correctly.
>
> d41a39dda140 drm/scheduler: improve job distribution with multiple queues
>
> Regards,
>
> Guchun
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> *On Behalf Of *Zhu, 
> Changfeng
> *Sent:* Wednesday, May 19, 2021 10:56 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>; Alex Deucher 
> <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>; Das, Nirmoy 
> <Nirmoy.Das@amd.com <mailto:Nirmoy.Das@amd.com>>
> *Cc:* Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; 
> amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> [Public]
>
> [Public]
>
> Hi Alex,
>
> This is the issue exposed by Nirmoy's patch that provided better load 
> balancing across queues.
>
> BR,
>
> Changfeng.
>
> *From:* Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>
> *Sent:* Wednesday, May 19, 2021 10:53 AM
> *To:* Zhu, Changfeng <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>>; Alex Deucher <alexdeucher@gmail.com 
> <mailto:alexdeucher@gmail.com>>; Das, Nirmoy <Nirmoy.Das@amd.com 
> <mailto:Nirmoy.Das@amd.com>>
> *Cc:* Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; 
> amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> [Public]
>
> + Nirmoy
>
> I thought we disabled all but one of the compute queues on raven due 
> to this issue. Maybe that patch never landed?  Wasn't this the same 
> issue that was exposed by Nirmoy's patch that provided better load 
> balancing across queues?
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org 
> <mailto:amd-gfx-bounces@lists.freedesktop.org>> on behalf of Zhu, 
> Changfeng <Changfeng.Zhu@amd.com <mailto:Changfeng.Zhu@amd.com>>
> *Sent:* Tuesday, May 18, 2021 10:28 PM
> *To:* Alex Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>
> *Cc:* Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; 
> amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> *Subject:* RE: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex.
>
> I have submitted the patch: drm/amdgpu: disable 3DCGCG on 
> picasso/raven1 to avoid compute hang
>
> Do you mean we have something else to do for re-enabling the extra 
> compute queues?
>
> BR,
> Changfeng.
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com <mailto:alexdeucher@gmail.com>>
> Sent: Wednesday, May 19, 2021 10:20 AM
> To: Zhu, Changfeng <Changfeng.Zhu@amd.com <mailto:Changfeng.Zhu@amd.com>>
> Cc: Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>; amd-gfx 
> list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to 
> avoid compute hang
>
> Care to submit a patch to re-enable the extra compute queues?
>
> Alex
>
> On Mon, May 17, 2021 at 4:09 AM Zhu, Changfeng <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi Ray and Alex,
> >
> > I have confirmed it can enable the additional compute queues with 
> this patch:
> >
> > [   41.823013] This is ring mec 1, pipe 0, queue 0, value 1
> > [   41.823028] This is ring mec 1, pipe 1, queue 0, value 1
> > [   41.823042] This is ring mec 1, pipe 2, queue 0, value 1
> > [   41.823057] This is ring mec 1, pipe 3, queue 0, value 1
> > [   41.823071] This is ring mec 1, pipe 0, queue 1, value 1
> > [   41.823086] This is ring mec 1, pipe 1, queue 1, value 1
> > [   41.823101] This is ring mec 1, pipe 2, queue 1, value 1
> > [   41.823115] This is ring mec 1, pipe 3, queue 1, value 1
> >
> > BR,
> > Changfeng.
> >
> >
> > -----Original Message-----
> > From: Huang, Ray <Ray.Huang@amd.com <mailto:Ray.Huang@amd.com>>
> > Sent: Monday, May 17, 2021 2:27 PM
> > To: Alex Deucher <alexdeucher@gmail.com 
> <mailto:alexdeucher@gmail.com>>; Zhu, Changfeng
> > <Changfeng.Zhu@amd.com <mailto:Changfeng.Zhu@amd.com>>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>
> > Subject: Re: [PATCH] drm/amdgpu: disable 3DCGCG on picasso/raven1 to
> > avoid compute hang
> >
> > On Fri, May 14, 2021 at 10:13:55PM +0800, Alex Deucher wrote:
> > > On Fri, May 14, 2021 at 4:20 AM <changfeng.zhu@amd.com 
> <mailto:changfeng.zhu@amd.com>> wrote:
> > > >
> > > > From: changzhu <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>>
> > > >
> > > > From: Changfeng <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>>
> > > >
> > > > There is problem with 3DCGCG firmware and it will cause compute
> > > > test hang on picasso/raven1. It needs to disable 3DCGCG in driver
> > > > to avoid compute hang.
> > > >
> > > > Change-Id: Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87
> > > > Signed-off-by: Changfeng <Changfeng.Zhu@amd.com 
> <mailto:Changfeng.Zhu@amd.com>>
> > >
> > > Reviewed-by: Alex Deucher <alexander.deucher@amd.com 
> <mailto:alexander.deucher@amd.com>>
> > >
> > > WIth this applied, can we re-enable the additional compute queues?
> > >
> >
> > I think so.
> >
> > Changfeng, could you please confirm this on all raven series?
> >
> > Patch is Reviewed-by: Huang Rui <ray.huang@amd.com 
> <mailto:ray.huang@amd.com>>
> >
> > > Alex
> > >
> > > > ---
> > > > drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 +++++++---
> > > > drivers/gpu/drm/amd/amdgpu/soc15.c    |  2 --
> > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > index 22608c45f07c..feaa5e4a5538 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > @@ -4947,7 +4947,7 @@ static void 
> gfx_v9_0_update_3d_clock_gating(struct amdgpu_device *adev,
> > > > amdgpu_gfx_rlc_enter_safe_mode(adev);
> > > >
> > > >         /* Enable 3D CGCG/CGLS */
> > > > -       if (enable && (adev->cg_flags & 
> AMD_CG_SUPPORT_GFX_3D_CGCG)) {
> > > > +       if (enable) {
> > > >                 /* write cmd to clear cgcg/cgls ov */
> > > >                 def = data = RREG32_SOC15(GC, 0, 
> mmRLC_CGTT_MGCG_OVERRIDE);
> > > >                 /* unset CGCG override */ @@ -4959,8 +4959,12 @@
> > > > static void gfx_v9_0_update_3d_clock_gating(struct amdgpu_device 
> *adev,
> > > >                 /* enable 3Dcgcg FSM(0x0000363f) */
> > > >                 def = RREG32_SOC15(GC, 0,
> > > > mmRLC_CGCG_CGLS_CTRL_3D);
> > > >
> > > > -               data = (0x36 << 
> RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > > - RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > > +               if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
> > > > +                       data = (0x36 << 
> RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
> > > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
> > > > +               else
> > > > +                       data = 0x0 <<
> > > > + RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;
> > > > +
> > > >                 if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
> > > >                         data |= (0x000F << 
> RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
> > > >
> > > > RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > index 4b660b2d1c22..080e715799d4 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > > > @@ -1393,7 +1393,6 @@ static int soc15_common_early_init(void 
> *handle)
> > > > adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
> > > > AMD_CG_SUPPORT_GFX_MGLS |
> > > > AMD_CG_SUPPORT_GFX_CP_LS |
> > > > - AMD_CG_SUPPORT_GFX_3D_CGCG |
> > > > AMD_CG_SUPPORT_GFX_3D_CGLS |
> > > > AMD_CG_SUPPORT_GFX_CGCG |
> > > > AMD_CG_SUPPORT_GFX_CGLS | @@
> > > > -1413,7
> > > > +1412,6 @@ static int soc15_common_early_init(void *handle)
> > > > AMD_CG_SUPPORT_GFX_MGLS |
> > > > AMD_CG_SUPPORT_GFX_RLC_LS |
> > > > AMD_CG_SUPPORT_GFX_CP_LS |
> > > > - AMD_CG_SUPPORT_GFX_3D_CGCG |
> > > > AMD_CG_SUPPORT_GFX_3D_CGLS |
> > > > AMD_CG_SUPPORT_GFX_CGCG |
> > > > AMD_CG_SUPPORT_GFX_CGLS |
> > > > --
> > > > 2.17.1
> > > >
> > > > _______________________________________________
> > > > amd-gfx mailing list
> > > > amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> > > > 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F>
> > > > li
> > > > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C0
> > > > 1%
> > > > 7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961
> > > > fe
> > > > 4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CT
> > > > WF
> > > > pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > > > CI
> > > > 6Mn0%3D%7C1000&amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2
> > > > BV
> > > > 7pSY%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&data=04%7C01%7Cguchun.chen%40amd.com%7C3fc7a549816d4c8061c008d91a719cb8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569897555065647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=YTC%2FvVR%2BbPKw9JKayhmHapRkkEFaczoGzJJ3jFJqBAM%3D&reserved=0>
>

--------------8F672C0B21C007DE9559ADC1
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 5/19/21 5:14 AM, Huang, Ray wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:MWHPR12MB12481CD68B579778D851B88FEC2B9@MWHPR12MB1248.namprd12.prod.outlook.com">
      
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheaderc10f11a2" style="margin:0in"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">I check the patch (below) to disable
          compute queues for raven is not landed into drm-next. So
          actually all queues are enabled at this moment. Nirmoy, can we
          get your confirmation?</p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I indeed didn't push the commit that disable all but one cu for
      raven. I was suppose to check with kfd as Felix wanted to</p>
    <p>know if that bug affects KFD. I think I got distracted with
      something else. <br>
    </p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Nirmoy<br>
    </p>
    <blockquote type="cite" cite="mid:MWHPR12MB12481CD68B579778D851B88FEC2B9@MWHPR12MB1248.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><b><span style="font-size:10.0pt;font-family:Consolas;color:seagreen">diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c</span></b><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><b><span style="font-size:10.0pt;font-family:Consolas;color:seagreen">index
              97a8f786cf85..9352fcb77fe9 100644</span></b><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><b><span style="font-size:10.0pt;font-family:Consolas;color:seagreen">---
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c</span></b><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><b><span style="font-size:10.0pt;font-family:Consolas;color:seagreen">+++
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c</span></b><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><b><span style="font-size:10.0pt;font-family:Consolas;color:brown">@@
              -812,6 +812,13 @@</span></b><span style="font-size:10.0pt;font-family:Consolas;color:#333333">
          </span><span style="font-size:10.0pt;font-family:Consolas;color:#A020F0">&nbsp;void
            amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg,
            uint32_t v)</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">int
            amdgpu_gfx_get_num_kcq(struct amdgpu_device *adev)<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">{<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (amdgpu_num_kcq == -1) {<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            /* raven firmware currently can not load balance jobs</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            * among multiple compute queues. Enable only one</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            * compute queue till we have a firmware fix.</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            */</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            if (adev-&gt;asic_type == CHIP_RAVEN)</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            return 1;</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:darkcyan">+</span><span style="font-size:10.0pt;font-family:Consolas;color:#333333"><o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            return 8;<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            } else if (amdgpu_num_kcq &gt; 8 || amdgpu_num_kcq &lt; 0) {<o:p></o:p></span></p>
        <p class="MsoNormal" style="margin-bottom:7.5pt;line-height:10.75pt;background:white;word-break:break-all"><span style="font-size:10.0pt;font-family:Consolas;color:#333333">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            dev_warn(adev-&gt;dev, &quot;set kernel compute queue number to 8
            due to invalid parameter provided by user\n&quot;);<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">And I am glad to see that we have a
          solution to fix this issue at current. Nice work, Changfeng!<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal">Best Regards,<o:p></o:p></p>
        <p class="MsoNormal">Ray<o:p></o:p></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a> <br>
              <b>Sent:</b> Wednesday, May 19, 2021 11:04 AM<br>
              <b>To:</b> Chen, Guchun <a class="moz-txt-link-rfc2396E" href="mailto:Guchun.Chen@amd.com">&lt;Guchun.Chen@amd.com&gt;</a>; Zhu,
              Changfeng <a class="moz-txt-link-rfc2396E" href="mailto:Changfeng.Zhu@amd.com">&lt;Changfeng.Zhu@amd.com&gt;</a>; Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher@gmail.com">&lt;alexdeucher@gmail.com&gt;</a>; Das, Nirmoy
              <a class="moz-txt-link-rfc2396E" href="mailto:Nirmoy.Das@amd.com">&lt;Nirmoy.Das@amd.com&gt;</a><br>
              <b>Cc:</b> Huang, Ray <a class="moz-txt-link-rfc2396E" href="mailto:Ray.Huang@amd.com">&lt;Ray.Huang@amd.com&gt;</a>; amd-gfx
              list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: disable 3DCGCG on
              picasso/raven1 to avoid compute hang<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">I thought we had
                disabled all but one of the compute queues on raven due
                to this issue or at least disabled the schedulers for
                the additional queues, but maybe I'm misremembering.<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
          </div>
          <div>
            <p class="MsoNormal"><span style="font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
          </div>
          <div class="MsoNormal" style="text-align:center" align="center">
            <hr width="98%" size="2" align="center">
          </div>
          <div id="divRplyFwdMsg">
            <p class="MsoNormal"><b><span style="color:black">From:</span></b><span style="color:black"> Chen, Guchun &lt;<a href="mailto:Guchun.Chen@amd.com" moz-do-not-send="true">Guchun.Chen@amd.com</a>&gt;<br>
                <b>Sent:</b> Tuesday, May 18, 2021 11:00 PM<br>
                <b>To:</b> Zhu, Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;;
                Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                Das, Nirmoy &lt;<a href="mailto:Nirmoy.Das@amd.com" moz-do-not-send="true">Nirmoy.Das@amd.com</a>&gt;<br>
                <b>Cc:</b> Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;;
                amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                <b>Subject:</b> RE: [PATCH] drm/amdgpu: disable 3DCGCG
                on picasso/raven1 to avoid compute hang</span>
              <o:p></o:p></p>
            <div>
              <p class="MsoNormal">&nbsp;<o:p></o:p></p>
            </div>
          </div>
          <div>
            <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
            <div>
              <div>
                <p class="xmsonormal">Nirmoy’s patch landed already if I
                  understand correctly.<o:p></o:p></p>
                <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                <p class="xmsonormal">d41a39dda140 drm/scheduler:
                  improve job distribution with multiple queues<o:p></o:p></p>
                <div>
                  <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                  <p class="xmsonormal">Regards,<o:p></o:p></p>
                  <p class="xmsonormal">Guchun<o:p></o:p></p>
                </div>
                <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                <div>
                  <div style="border:none;border-top:solid #E1E1E1
                    1.0pt;padding:3.0pt 0in 0in 0in">
                    <p class="xmsonormal"><b>From:</b> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                      <b>On Behalf Of </b>Zhu, Changfeng<br>
                      <b>Sent:</b> Wednesday, May 19, 2021 10:56 AM<br>
                      <b>To:</b> Deucher, Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;;
                      Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                      Das, Nirmoy &lt;<a href="mailto:Nirmoy.Das@amd.com" moz-do-not-send="true">Nirmoy.Das@amd.com</a>&gt;<br>
                      <b>Cc:</b> Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;;
                      amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                      <b>Subject:</b> RE: [PATCH] drm/amdgpu: disable
                      3DCGCG on picasso/raven1 to avoid compute hang<o:p></o:p></p>
                  </div>
                </div>
                <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
                <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                <div>
                  <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
                  <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                  <div>
                    <p class="xmsonormal">Hi Alex,<o:p></o:p></p>
                    <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                    <p class="xmsonormal">This is the issue exposed by <span style="font-size:12.0pt;color:black">
                        Nirmoy's patch that provided better load
                        balancing across queues.</span><o:p></o:p></p>
                    <p class="xmsonormal"><span style="font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p>
                    <p class="xmsonormal"><span style="font-size:12.0pt;color:black">BR,</span><o:p></o:p></p>
                    <p class="xmsonormal"><span style="font-size:12.0pt;color:black">Changfeng.</span><o:p></o:p></p>
                    <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                    <div>
                      <div style="border:none;border-top:solid #E1E1E1
                        1.0pt;padding:3.0pt 0in 0in 0in">
                        <p class="xmsonormal"><b>From:</b> Deucher,
                          Alexander &lt;<a href="mailto:Alexander.Deucher@amd.com" moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;
                          <br>
                          <b>Sent:</b> Wednesday, May 19, 2021 10:53 AM<br>
                          <b>To:</b> Zhu, Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;;
                          Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                          Das, Nirmoy &lt;<a href="mailto:Nirmoy.Das@amd.com" moz-do-not-send="true">Nirmoy.Das@amd.com</a>&gt;<br>
                          <b>Cc:</b> Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;;
                          amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                          <b>Subject:</b> Re: [PATCH] drm/amdgpu:
                          disable 3DCGCG on picasso/raven1 to avoid
                          compute hang<o:p></o:p></p>
                      </div>
                    </div>
                    <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                    <p style="margin:15.0pt"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
                    <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                    <div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">+
                            Nirmoy</span><o:p></o:p></p>
                      </div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p>
                      </div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">I
                            thought we disabled all but one of the
                            compute queues on raven due to this issue.&nbsp;
                            Maybe that patch never landed?&nbsp; Wasn't this
                            the same issue that was exposed by Nirmoy's
                            patch that provided better load balancing
                            across queues?</span><o:p></o:p></p>
                      </div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p>
                      </div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">Alex</span><o:p></o:p></p>
                      </div>
                      <div>
                        <p class="xmsonormal"><span style="font-size:12.0pt;color:black">&nbsp;</span><o:p></o:p></p>
                      </div>
                      <div class="MsoNormal" style="text-align:center" align="center">
                        <hr width="98%" size="1" align="center">
                      </div>
                      <div id="x_divRplyFwdMsg">
                        <p class="xmsonormal"><b><span style="color:black">From:</span></b><span style="color:black"> amd-gfx &lt;<a href="mailto:amd-gfx-bounces@lists.freedesktop.org" moz-do-not-send="true">amd-gfx-bounces@lists.freedesktop.org</a>&gt;
                            on behalf of Zhu, Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            <b>Sent:</b> Tuesday, May 18, 2021 10:28 PM<br>
                            <b>To:</b> Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;<br>
                            <b>Cc:</b> Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;;
                            amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                            <b>Subject:</b> RE: [PATCH] drm/amdgpu:
                            disable 3DCGCG on picasso/raven1 to avoid
                            compute hang</span>
                          <o:p></o:p></p>
                        <div>
                          <p class="xmsonormal">&nbsp;<o:p></o:p></p>
                        </div>
                      </div>
                      <div>
                        <div>
                          <p class="xmsonormal">[AMD Official Use Only -
                            Internal Distribution Only]<br>
                            <br>
                            Hi Alex.<br>
                            <br>
                            I have submitted the patch: drm/amdgpu:
                            disable 3DCGCG on picasso/raven1 to avoid
                            compute hang<br>
                            <br>
                            Do you mean we have something else to do for
                            re-enabling the extra compute queues?<br>
                            <br>
                            BR,<br>
                            Changfeng.<br>
                            <br>
                            -----Original Message-----<br>
                            From: Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;
                            <br>
                            Sent: Wednesday, May 19, 2021 10:20 AM<br>
                            To: Zhu, Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            Cc: Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;;
                            amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                            Subject: Re: [PATCH] drm/amdgpu: disable
                            3DCGCG on picasso/raven1 to avoid compute
                            hang<br>
                            <br>
                            Care to submit a patch to re-enable the
                            extra compute queues?<br>
                            <br>
                            Alex<br>
                            <br>
                            On Mon, May 17, 2021 at 4:09 AM Zhu,
                            Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;
                            wrote:<br>
                            &gt;<br>
                            &gt; [AMD Official Use Only - Internal
                            Distribution Only]<br>
                            &gt;<br>
                            &gt; Hi Ray and Alex,<br>
                            &gt;<br>
                            &gt; I have confirmed it can enable the
                            additional compute queues with this patch:<br>
                            &gt;<br>
                            &gt; [&nbsp;&nbsp; 41.823013] This is ring mec 1, pipe
                            0, queue 0, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823028] This is ring mec 1, pipe
                            1, queue 0, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823042] This is ring mec 1, pipe
                            2, queue 0, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823057] This is ring mec 1, pipe
                            3, queue 0, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823071] This is ring mec 1, pipe
                            0, queue 1, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823086] This is ring mec 1, pipe
                            1, queue 1, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823101] This is ring mec 1, pipe
                            2, queue 1, value 1<br>
                            &gt; [&nbsp;&nbsp; 41.823115] This is ring mec 1, pipe
                            3, queue 1, value 1<br>
                            &gt;<br>
                            &gt; BR,<br>
                            &gt; Changfeng.<br>
                            &gt;<br>
                            &gt;<br>
                            &gt; -----Original Message-----<br>
                            &gt; From: Huang, Ray &lt;<a href="mailto:Ray.Huang@amd.com" moz-do-not-send="true">Ray.Huang@amd.com</a>&gt;<br>
                            &gt; Sent: Monday, May 17, 2021 2:27 PM<br>
                            &gt; To: Alex Deucher &lt;<a href="mailto:alexdeucher@gmail.com" moz-do-not-send="true">alexdeucher@gmail.com</a>&gt;;
                            Zhu, Changfeng
                            <br>
                            &gt; &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            &gt; Cc: amd-gfx list &lt;<a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;<br>
                            &gt; Subject: Re: [PATCH] drm/amdgpu:
                            disable 3DCGCG on picasso/raven1 to <br>
                            &gt; avoid compute hang<br>
                            &gt;<br>
                            &gt; On Fri, May 14, 2021 at 10:13:55PM
                            +0800, Alex Deucher wrote:<br>
                            &gt; &gt; On Fri, May 14, 2021 at 4:20 AM
                            &lt;<a href="mailto:changfeng.zhu@amd.com" moz-do-not-send="true">changfeng.zhu@amd.com</a>&gt;
                            wrote:<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; From: changzhu &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; From: Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; There is problem with 3DCGCG
                            firmware and it will cause compute <br>
                            &gt; &gt; &gt; test hang on picasso/raven1.
                            It needs to disable 3DCGCG in driver <br>
                            &gt; &gt; &gt; to avoid compute hang.<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; Change-Id:
                            Ic7d3c7922b2b32f7ac5193d6a4869cbc5b3baa87<br>
                            &gt; &gt; &gt; Signed-off-by: Changfeng &lt;<a href="mailto:Changfeng.Zhu@amd.com" moz-do-not-send="true">Changfeng.Zhu@amd.com</a>&gt;<br>
                            &gt; &gt;<br>
                            &gt; &gt; Reviewed-by: Alex Deucher &lt;<a href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">alexander.deucher@amd.com</a>&gt;<br>
                            &gt; &gt;<br>
                            &gt; &gt; WIth this applied, can we
                            re-enable the additional compute queues?<br>
                            &gt; &gt;<br>
                            &gt;<br>
                            &gt; I think so.<br>
                            &gt;<br>
                            &gt; Changfeng, could you please confirm
                            this on all raven series?<br>
                            &gt;<br>
                            &gt; Patch is Reviewed-by: Huang Rui &lt;<a href="mailto:ray.huang@amd.com" moz-do-not-send="true">ray.huang@amd.com</a>&gt;<br>
                            &gt;<br>
                            &gt; &gt; Alex<br>
                            &gt; &gt;<br>
                            &gt; &gt; &gt; ---<br>
                            &gt; &gt; &gt;&nbsp;
                            drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10
                            +++++++---<br>
                            &gt; &gt; &gt;&nbsp;
                            drivers/gpu/drm/amd/amdgpu/soc15.c&nbsp;&nbsp;&nbsp; |&nbsp; 2
                            --<br>
                            &gt; &gt; &gt;&nbsp; 2 files changed, 7
                            insertions(+), 5 deletions(-)<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                            &gt; &gt; &gt;
                            b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                            &gt; &gt; &gt; index
                            22608c45f07c..feaa5e4a5538 100644<br>
                            &gt; &gt; &gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                            &gt; &gt; &gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
                            &gt; &gt; &gt; @@ -4947,7 +4947,7 @@ static
                            void gfx_v9_0_update_3d_clock_gating(struct
                            amdgpu_device *adev,<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            amdgpu_gfx_rlc_enter_safe_mode(adev);<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable 3D
                            CGCG/CGLS */<br>
                            &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp;
                            (adev-&gt;cg_flags &amp;
                            AMD_CG_SUPPORT_GFX_3D_CGCG)) {<br>
                            &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* write cmd
                            to clear cgcg/cgls ov */<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def = data =
                            RREG32_SOC15(GC, 0,
                            mmRLC_CGTT_MGCG_OVERRIDE);<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unset CGCG
                            override */ @@ -4959,8 +4959,12 @@ <br>
                            &gt; &gt; &gt; static void
                            gfx_v9_0_update_3d_clock_gating(struct
                            amdgpu_device *adev,<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enable
                            3Dcgcg FSM(0x0000363f) */<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def =
                            RREG32_SOC15(GC, 0, <br>
                            &gt; &gt; &gt; mmRLC_CGCG_CGLS_CTRL_3D);<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data = (0x36
                            &lt;&lt;
                            RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT)
                            |<br>
                            &gt; &gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;<br>
                            &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                            (adev-&gt;cg_flags &amp;
                            AMD_CG_SUPPORT_GFX_3D_CGCG)<br>
                            &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data
                            = (0x36 &lt;&lt;
                            RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT)
                            |<br>
                            &gt; &gt; &gt;
                            +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;<br>
                            &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
                            &gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data
                            = 0x0 &lt;&lt; <br>
                            &gt; &gt; &gt; +
                            RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT;<br>
                            &gt; &gt; &gt; +<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
                            (adev-&gt;cg_flags &amp;
                            AMD_CG_SUPPORT_GFX_3D_CGLS)<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data
                            |= (0x000F &lt;&lt;
                            RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT)
                            |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
                            &gt; &gt; &gt;
                            RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;<br>
                            &gt; &gt; &gt; diff --git
                            a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                            &gt; &gt; &gt;
                            b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                            &gt; &gt; &gt; index
                            4b660b2d1c22..080e715799d4 100644<br>
                            &gt; &gt; &gt; ---
                            a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                            &gt; &gt; &gt; +++
                            b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                            &gt; &gt; &gt; @@ -1393,7 +1393,6 @@ static
                            int soc15_common_early_init(void *handle)<br>
                            &gt; &gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            adev-&gt;cg_flags = AMD_CG_SUPPORT_GFX_MGCG
                            |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_MGLS |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CP_LS |<br>
                            &gt; &gt; &gt;
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_3D_CGCG |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_3D_CGLS |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CGCG |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CGLS | @@ <br>
                            &gt; &gt; &gt; -1413,7<br>
                            &gt; &gt; &gt; +1412,6 @@ static int
                            soc15_common_early_init(void *handle)<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_MGLS |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_RLC_LS |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CP_LS |<br>
                            &gt; &gt; &gt;
                            -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_3D_CGCG |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_3D_CGLS |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CGCG |<br>
                            &gt; &gt;
                            &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            AMD_CG_SUPPORT_GFX_CGLS |<br>
                            &gt; &gt; &gt; --<br>
                            &gt; &gt; &gt; 2.17.1<br>
                            &gt; &gt; &gt;<br>
                            &gt; &gt; &gt;
                            _______________________________________________<br>
                            &gt; &gt; &gt; amd-gfx mailing list<br>
                            &gt; &gt; &gt; <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                            &gt; &gt; &gt; <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F" moz-do-not-send="true">
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2F</a><br>
                            &gt; &gt; &gt; li <br>
                            &gt; &gt; &gt;
                            sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C0<br>
                            &gt; &gt; &gt; 1% <br>
                            &gt; &gt; &gt;
                            7CRay.Huang%40amd.com%7C0e273856253d4b3efd0b08d916e2892a%7C3dd8961<br>
                            &gt; &gt; &gt; fe <br>
                            &gt; &gt; &gt;
                            4884e608e11a82d994e183d%7C0%7C0%7C637565984495414849%7CUnknown%7CT<br>
                            &gt; &gt; &gt; WF <br>
                            &gt; &gt; &gt;
                            pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV<br>
                            &gt; &gt; &gt; CI <br>
                            &gt; &gt; &gt;
                            6Mn0%3D%7C1000&amp;amp;sdata=lBzswAPBguL0mWFglEk%2Bg2eDCEuhir7JfFjov%2<br>
                            &gt; &gt; &gt; BV<br>
                            &gt; &gt; &gt; 7pSY%3D&amp;amp;reserved=0<br>
_______________________________________________<br>
                            amd-gfx mailing list<br>
                            <a href="mailto:amd-gfx@lists.freedesktop.org" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                            <a href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C3fc7a549816d4c8061c008d91a719cb8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569897555065647%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=YTC%2FvVR%2BbPKw9JKayhmHapRkkEFaczoGzJJ3jFJqBAM%3D&amp;reserved=0" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Calexander.deucher%40amd.com%7C6d2cfe6e59f54875f6fa08d91a6dd27f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637569881259273626%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=33Is2P3sqdabI7PPuHFOmzuvXyFId%2BOTAMyJ8G5PhzI%3D&amp;amp;reserved=0</a><o:p></o:p></p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------8F672C0B21C007DE9559ADC1--

--===============0503868002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0503868002==--
