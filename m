Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F77C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8465760F5B
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 08:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8465760F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B8EA6E53E;
	Thu, 26 Aug 2021 08:19:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F78E6E53E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 08:19:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEVQ9Mtsx7lTdg1zwTxCrWOtkp+ieGmqXpo9JZnpScXXlhOscRImMe6hhABnZmip4vHqM9joHzxj+MAKkwgeIEf7NWvZGKHCFdAtQGru6YhIeJu97GU117cb/y01qEZLHT+P7Aymi3QDFxr17H8hWGBaD8fH3EG+vhri9KzFGfOiAbZ7MW9YsvybltcetmLvqzcxmJhR6DlQ6Q2ez6uIDg0ucXCYQ7KbiVbDZ3S6D1SM0y/ujRguqRIO1Xjzbo9tp8f7R17ngKx3SE0OFGqobGaZCWGRw1MXFphF1Kuotv+/yfz2aqyznalG56X95O8IGLpz1QgDzow2Wr9/YN0Aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMKASoVH7i+8H4aFrZh4NiLbBcTns2NNaoPgIa3kpP0=;
 b=ShyPhRNGeV9751duRh74H0JsNK0p8HuPZ5gbVY+zxOXuB5BYVn4bP7aNZubgW/TMVUi7ICFvF72r9GnPP/MkYGMdnnOiNWz9yA/wkRNNpFBsiwZgwpP2rcN5UiogXNGgC/q3Db/6pR82YkqLqqiptC9TKqWWHgsanWHwdtI/wHeuT6HUJVsugSj/h6vmadoyrPY0jD3d88gQQCs7q5lr6YZEiA1EdRvya51fGbxcbIUPJxKmce91TknanJ6cUg7PpqE1ZyPrhBwgOxe+Vp3kGWOjt8ps284uG0y9Cg67AGTNqvZMt+t4tsxs+MlluZ9DdeCtmCyDFk5FD7sr4SLUsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMKASoVH7i+8H4aFrZh4NiLbBcTns2NNaoPgIa3kpP0=;
 b=Dpct1BD4T20Dx5rT1ZNsWFQo6U99ZxRts+q2U9N60YVHeRs9djEj35Ehh6j/fcbwEeIySzrguix8gbf88LfGL46M2+izSuHisldeeHSMigCKypKckWNGFbhODjveJVWeSl8Ud82qDdFqS4hHO8OVFd0pSOp6tUR2O7f1KOUFjq4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4868.namprd12.prod.outlook.com (2603:10b6:208:1c4::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 08:19:28 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4436.024; Thu, 26 Aug 2021
 08:19:28 +0000
Subject: Re: [PATCH 1/5] drm/amdgpu/vce:set vce ring priority level
To: Satyajit Sahu <satyajit.sahu@amd.com>, amd-gfx@lists.freedesktop.org
Cc: leo.liu@amd.com, Alexander.Deucher@amd.com, shashank.sharma@amd.com,
 nirmoy.das@amd.com
References: <20210826071307.136010-1-satyajit.sahu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a69fc58f-8c30-346b-f303-6bfef8aca724@amd.com>
Date: Thu, 26 Aug 2021 10:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210826071307.136010-1-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0020.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::33) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff]
 (2a02:908:1252:fb60:1fe2:dd0d:124d:d9ff) by
 AM0PR02CA0020.eurprd02.prod.outlook.com (2603:10a6:208:3e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 08:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f360b3a-73f3-4359-fa9d-08d9686a38b1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB48680DBE1289C3580022EC6083C79@BL0PR12MB4868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: swKVjyL4zGc7Y2LIxCxsKVaaE0iYjkEn4dvkplJFZAJJNoxofzythicOPiSA4/jCIP5KZ5VledvOPSXZN3EKWUXSiVvY209ACyQyeoqldULoDqTJUebY+knQJ6PdN3uEgR8bcg8nKMYB0eqK7G4Ei5N/2UzzqUzE0DtI7yqvZZbaso2YkqiC4VAyWmcvEa3f58w9jVWEPQps6ayuS3UWB8U+2aFXsp0RgjSUyh45px7WDc9aCG8pirMHRRwGu1yfRFtk5nXkSvytLLsOWMqsnpPtfl6XaeFiPSc8tT6Bcd6MJ2cDhOi8tG/p5h25gNvTQZjigph7RbMw268AI/cpbwfJMRMWkXuF4fxmEm3zE+crIpWZlpIVoN7oLVZwfaQ4vgbNQ31iv9jFKTGe0CPuS7kNPscj4DK5NLYjGzPTrG6whzg/CAqdh37iRQo9kLs4LdRDUJ80uf9KNiHYnCCA6T9ewLZkBj6zo7wlGA3g31qqliqtbTDC8Gn6y5ecvnXuNiZD5Fnxc9xph4CCJzL76nc8Y4wQqPh9JtfQZ3z5SIGWPbOtEQkjZ8Ak7c6hmE7Iu8Ef1QRv3Y2NDLA2QWJdPuEi/fRSEkI5F/SH8huDWo1+MoMjuGhIHBJpLD2gwrCKQGLFYZ8mAWX+eQSPgsaO8ECkbrkp8jEnYTb72Wvf8XIsHbd84gWCfZlg7T5TnbDUI7qKXnrGKiZ8CRWnBSML+PVKVzgQnsc4bT0/aZBNfE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(31696002)(5660300002)(186003)(4326008)(478600001)(2616005)(86362001)(6666004)(6486002)(66476007)(66556008)(316002)(8676002)(8936002)(66946007)(2906002)(36756003)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUk1b1FjaU5NWkRZU3RONm00RXUvZG11QS9TT3NQQ1lhZmpoM25HeHQ3RnNn?=
 =?utf-8?B?SkdmZHZ0ZVN2TFBBRlVyaFJMdVBGQU1wNWVLL3FJai9SbjV6K3h0R1VSY0dF?=
 =?utf-8?B?SGpCYWtkZHlzcEsrRDhwZ1pmTXlpVkplZHBiVnp5NW4vTUxtL0ZsN0lRR1h0?=
 =?utf-8?B?dC8vU1pwWlhMckNNbUhQODI0RnBMR3dWLy82Y09tOURURlZuT2g2akF6UjBO?=
 =?utf-8?B?amZQT0lqNWxqMHpyMVptVEFIbmUrdkpGSFphVGd0bnUrODBwWHAwTGZWUzhj?=
 =?utf-8?B?cEdSSW5KRDZPc3NGQUtudVZHQWdOQWRIUCt6WkRhREEwV2c1ME5kZWQ5Mkln?=
 =?utf-8?B?bHJFRVg5Nm5NMi9jMnN2aGRMYytGby91VjhBNk5XYlhjRTFnSkZHT2llL3Q4?=
 =?utf-8?B?NVBkSitud3g2KzdsSW9GMTF1dTVOL3dCNG52eS80WUZ0cmQ2WjlteU9iRVpr?=
 =?utf-8?B?QVRZY2xPekpVL1IvTXZLaGh3SFB1R1hZT1NHTDVJaVlNcG0wa040K0d6aWh5?=
 =?utf-8?B?UUdHNWtNb1piQ2F5Vmdjd1lOclowdjNzbEV3dnQvV2NqNlZBK1AwOEJYaHJx?=
 =?utf-8?B?NW5aZlpsMjY1bG9SM3MwOFBScnlweEt4eFluMjJXWnhlcTBlSWowcmxZY08w?=
 =?utf-8?B?dGdDeWpPMGlNZ2NKcENXTjBrVWFUbWM2SUhVRGZNOHRjRVNXMTVVVTFMTkxl?=
 =?utf-8?B?Nk1HRWE1WU9WUldsdmdkeVBFL1N2eVBvS2FyWjhZT1REVXdRNzQrYS9haTN1?=
 =?utf-8?B?TkR4UHdzUnhqd0U2RWt1U1QzQmMyME5hMDVKeVZwZVQ1SGliYWpKN2o3Y0RQ?=
 =?utf-8?B?bWcvZEhOM3N5MU5nKzR1cm1DVWZHaWNQZUh1WXJXLzhYeWpabVAwVEpFYUtK?=
 =?utf-8?B?MnNKa0w3OG5zWVNRN2h2bVdvcjVqTTFCQmhkVWlsdDN3aUltdmd6NkNjWGl1?=
 =?utf-8?B?dm5BWlVkTHRrK3VjK2dTbnoyOTJXaVA0WDJDVXc3cEdvdmxUdkdoZCt5VHJX?=
 =?utf-8?B?bUNHWmd5ZVdaMGdnRm9IellkWG90VXgyREFJRHFheFYzRUhlVXA0eHJwcms5?=
 =?utf-8?B?S0gxUVk5SXprZ2NUWWRJMVlFeEczTSt6OCtqdmdPektKZi9JWEhhNTN2Q2Yz?=
 =?utf-8?B?L3dxZVh5NDF2Wlp5YURtbHBIZ3RJbEYzbFE5QmhuMGhJSjNwcEZHd0Rpcktq?=
 =?utf-8?B?anhLSnBwTEZTNDNUdXhCSDhOWGlwVW5DeFJNbDhOcTROd29Oc21Qa2JhZmFB?=
 =?utf-8?B?T1ZTanBNOUlnUUxVb0Zpa29rbXNtUkVRMlhOTGJPbjVjQXZ1d1NxcG5HdHVy?=
 =?utf-8?B?K0ZPemk0eEx4YzJ1QlRHcDQvOHdmNkQ1R3kybG9rOG1aNmY3STM1MTJqUHNp?=
 =?utf-8?B?cXk5RGRxYUxTVG5zTEt0OW4vajBVYUxYRzM3N2x6Nk4yVUtvUVBJLzk4MTFW?=
 =?utf-8?B?SkZ5ODg0TDJTVzhnQS8wUjVMSHpiSzRLakJYMm1hQnNlUWpvYzJQdU1EeDQ2?=
 =?utf-8?B?Wndrc1dJb2JxRitjSjdIZkd2cXZwN1BOcHBXOUVOOWFkejFMZEU2NHFYdDBp?=
 =?utf-8?B?QklvZDB0Um43UDdvVDBKSkw1MlNNR1E3Vi8ranF4K0dWbG96bHJUbWNtT0x4?=
 =?utf-8?B?djhqc3owdGtxR2Y1bUtaUHpWYjBReC9pME5KOUx2dVhza2J4bEt2SFlneWNm?=
 =?utf-8?B?c2o1b2QrWHNLNW00RktkbXBTR0NPTWUzbEg1a1RDSnBVRVlqcTBTTCt3UkFO?=
 =?utf-8?B?NERXNjE4SzU5SWNjUWtOMVRTRHNLN2JNSHN6Y09vb21Bd09VbFpXdnNZUk02?=
 =?utf-8?B?YUxkY2s1L1hOeUg0VEI0YWs1S0VUd3YybDR5MFpwTWlSRWYzRXo3TlpObzlM?=
 =?utf-8?Q?E8WUQncUzwtJ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f360b3a-73f3-4359-fa9d-08d9686a38b1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 08:19:27.9684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btoNaCM3J2fCv0LNlw5+l+Ply1/0b08ZMHwqUZvWA30puWWNEG4zT22quu0fxlN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4868
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



Am 26.08.21 um 09:13 schrieb Satyajit Sahu:
> There are multiple rings available in VCE. Map each ring
> to different priority.
>
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h | 14 ++++++++++++++
>   2 files changed, 28 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..b68411caeac2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> +
> +enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index)
> +{
> +	switch(index) {
> +	case AMDGPU_VCE_GENERAL_PURPOSE:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	case AMDGPU_VCE_LOW_LATENCY:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case AMDGPU_VCE_REALTIME:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index d6d83a3ec803..60525887e9e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -32,6 +32,19 @@
>   
>   #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
>   
> +enum vce_enc_ring_priority {

Please name that enamu amdgpu_vce_...

> +	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCE_ENC_PRIO_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,

Please use the defines Nirmoy added for that here.

> +	AMDGPU_VCE_ENC_PRIO_MAX

I don't think we need this any more.

> +};
> +
> +enum vce_enc_ring_type {
> +	AMDGPU_VCE_GENERAL_PURPOSE,
> +	AMDGPU_VCE_LOW_LATENCY,
> +	AMDGPU_VCE_REALTIME
> +};

Same here, I don't think we need this any more.

Regards,
Christian.

> +
>   struct amdgpu_vce {
>   	struct amdgpu_bo	*vcpu_bo;
>   	uint64_t		gpu_addr;
> @@ -71,5 +84,6 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ring);
>   void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
> +enum vce_enc_ring_priority amdgpu_vce_get_ring_prio(int index);
>   
>   #endif

