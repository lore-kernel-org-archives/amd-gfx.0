Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3406C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8171C61994
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8171C61994
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C916E8DC;
	Tue, 30 Mar 2021 13:10:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1A446E8DB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:10:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgobePS9shC1E68ZaKrNtFrYYlKliR3RNcLcV2C03W3ILxugnmdo7gT2/vvyjjU8AJr5UqYh+WTFMSdbX2z+I6HHw+gnrw0Z39J5ak24Qrnb3lp9eCi5xa1K25qZfz8ZfR+HO2M6X2YtAOFOuDSyByz1YIaEQwkkRc1X74zrUj6NkdPU0FfJ8IDC5BvoXce5i5h4sROgnHDuQ0XwpB0c1Uz19GN5lmHa7IDjj6PL7fNlsHZOumk4d2looHPv8ED2dLaCYaXzB2oRHVavaYCy8+vtskjGSys+I0/4F2NVcwiy17Ev2n5AEH9tTtumMUD6Hm/ygB9X3uD1mSHDFou3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdUwq6ovuzwnw/Od3SFYbWix15bnPvTwY/qLFePjNOE=;
 b=K4eWPjIEUspHv6HOtcC8SBc5bLIP3cCpiRjUqDBaMotCAjREpPbGLAWYsVTRPEGy7QyaU1BsJehycTQWtn1JUmHDjrcj696FnxCdbWCVWRpUlfFSf1/qv3ZEYT509DOEei1h4cCqlC5mtiaI3/mB7iNklR7FpQ1KIAmY+tL0SeEaCRqhVDkOvZovxFvjokkv1XdwMTJtmOpRdCxg6pKXWNpWDXiyPoYlMW58FpaWdz6G+XgLMe6jCtyk44sgYewbovQsgaAONjEPgvRou8OveSYMYrmaxZtii1/pmKQBe6oYZlZhNblXbOdM23b+fFXxEy9wg1Mp0igtDqn4PZuBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdUwq6ovuzwnw/Od3SFYbWix15bnPvTwY/qLFePjNOE=;
 b=FRG0cGtcqXulkLTE8RzQlTx7Se8cEMbaWEpTiNjOH4/cYgEmwfL2tF7EdyrW0bNqtD3ID6/JM4a6qPBAU+oQAXKHGDEC8loDWyY6v83+KweJmS22705Z4L0PY/jmR5Q6NYgLltKLTl0OeAkqSsFQCyRwihCPqI+K8GUXpifk0t8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1159.namprd12.prod.outlook.com (2603:10b6:903:36::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Tue, 30 Mar
 2021 13:10:30 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::8908:d7:5544:6007%8]) with mapi id 15.20.3977.032; Tue, 30 Mar 2021
 13:10:30 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix compiler warning
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix compiler warning
Thread-Index: AQHXJUvfMHvK/K3VA0aWK/B4FtbTmKqcV5yAgAAomzA=
Date: Tue, 30 Mar 2021 13:10:29 +0000
Message-ID: <CY4PR12MB1287918442BA6CF42D844932F17D9@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210330100229.26435-1-guchun.chen@amd.com>
 <20210330100229.26435-2-guchun.chen@amd.com>
 <a8fc10aa-b410-efd5-ae29-7c4bbb76d05d@amd.com>
In-Reply-To: <a8fc10aa-b410-efd5-ae29-7c4bbb76d05d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-30T13:10:21Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=96cb234d-c193-446b-89f6-8b6bdd2394da;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [101.93.253.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 86745632-3ba8-4368-2a9f-08d8f37d31a7
x-ms-traffictypediagnostic: CY4PR12MB1159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB115906098E691B64ECE1F10BF17D9@CY4PR12MB1159.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: st0TkinA8DLpv6XWaR/WgkTGsAJ5FB4O/dUX2G2XvvkrHPxDWG5JyVLUksM0Qvfe2sFHMQJBukbjyVA9KY30m1jbNUk3vW/SpDlH1cNceRLsAR1fmGWW4vXqR6HlDEbuIM+LIzdTDmI7GpFJSkpH1IjYF2VczuONkTU4y5oL3jzPy6gF7ejxjgjGNqI0CTPkIAELvzAd0kOYiHGGozaM1XEVfrpRnRO370lpnJN46Zurzz4meSv+ZORXsbEoherKihPjSvSeWO3+YjSlH8Xsf4OAeJFyKNIQFaBtV0ooaNdZ5WpqQSS3T7ltMcRutIb1kFxEDPvpUlYOaFFs9r07uo7Ooeupw2hmBxWRJeZO6cHtPypv1fLBvCK3RpFeFKp6fQSkxTKMKf/A1ad6zcvdu1w+gweEgqXdRaywZEh4YDQFffLKlworwPaVjMFSv8YgnJj3WbisglmM0lTOMXTzCxdhQ9zfmEwJMBpRij5285UXzEEXaJ6rg16ddqv0xMlzTXT16azxPwIpawM38ywGZgfFGAZcmGevBbmkNxTrW2cYHAj3mYUmk+r6Uo+Vutrj+185oUWEdkrtNWeK3pAbA74fjz9T+Yjx09FOTKpEoMiS0eYwySICHcTdCWQC9FS46sGC5rxEYc7KSNy0Fim8BA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(66946007)(110136005)(66476007)(86362001)(76116006)(64756008)(66556008)(8936002)(66446008)(316002)(6636002)(38100700001)(52536014)(33656002)(5660300002)(55016002)(8676002)(2906002)(83380400001)(71200400001)(186003)(478600001)(53546011)(6506007)(26005)(7696005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?U3VjM1FoREloeEpPWXB1SUhabkN5dmdMNHZpdm9ZZlptQnpHcitncW5XZjQr?=
 =?utf-8?B?ZHdIY1I3Mk9rZTBkMlFNNE1pWng3MjIyOWI0TkQzL2JEVmE5bnRsR2JoMUVu?=
 =?utf-8?B?d0tiUGpYYjJLQStkV2wrYU1MQTNhY09oNjA0WlV6elk2cG5lOFN0ZDlYbVd4?=
 =?utf-8?B?a0xpTlNTVFVGL3FvdGVjekRFdWkydUNOa3k0Q3BXVUFYNmViaVN3QmgyZndB?=
 =?utf-8?B?b2o3L2pZeDNuc1ZjclNBZHFhUVlmN01qenV2Nm9RbUNqWlduTzkvODhwZjRu?=
 =?utf-8?B?azJIVDRRL2VnZisyRHVUM0ZsbHBFeklNR2MrSWVGK1ZnYWExM0VLUUMyNU9I?=
 =?utf-8?B?VkZKbVhmSkgzbWpBd05EOFNmcUxPSEtJQldKMDg2M09nalZmaldFaXZVeFpU?=
 =?utf-8?B?WXY3d1E3NmJQQ29TaDIrWUlPejYxYjdnQ2NvcXp2UVFEVzY2VWczY2hwd2FP?=
 =?utf-8?B?Y2VldndSdDNNY3RWQjB6MTFJNGd1ME9nVE5tdGJKTTZiUFd2cDg1SnR4K3J2?=
 =?utf-8?B?YWpuSU9XaWdaVEZoY0dES1lXZjk2Qzh3bGo3eElYMFhIZ2RNSWR3T2owM0lC?=
 =?utf-8?B?L28vbXJ0YUF6Z1pybnlkUXVaMjAyeVpvaFkvQlBFWlpvWHluOFpjL2lueWVC?=
 =?utf-8?B?WXJkeTB0Ukk0RGhhdjZQdUdzakFoWHNYc3o0Zjkyckg2UEc4TTQxYUorUnd6?=
 =?utf-8?B?OU8rQWFrUERMOVh0SUlPdld6Y2xZejByekFMbERjRndkRjh2MDEwczZBaEgy?=
 =?utf-8?B?dWcrVlU2OXJmR0xkbTVnK2dUYU1SRW0zUnlsamNSSWk2QmhaZXRidjlJdVlh?=
 =?utf-8?B?UnFqYmU3YUhQcXY0VTBKRUZWdXRMYjdSalZUU2hCRUU1dUJiazdKajNUaGF3?=
 =?utf-8?B?aTRPS2FodUFxaGY0Tmlkd3k5QWdQUG5EZTBobkpMeVJ5MXQ2dW0zcEFRa3lI?=
 =?utf-8?B?ekpBekdFS2pJSDJOK1dsQ0Y3UHd0eWMxVVNlUjVFUHNDU1JEUmxabERRWXR4?=
 =?utf-8?B?Z0FUUTBjWTZGV1RzUU9iaDd3V0hvdjZSdzRaOUZqKzMvYTlpeS9na1FlTmkv?=
 =?utf-8?B?Mjc1MFNQMHk2RUYyVy95VTdpakJYdTN0WHJPbFBURFc1dmg4TUNRdFVlVFk5?=
 =?utf-8?B?aW1hVmdWNkNvNGNPR0NWSjVhSGNIR1dNT09PRjJGZHhwbjhKSC9XRE5mSXow?=
 =?utf-8?B?R3lZeEd6L1Y5bU9WY2tIak9NUE9Vd3d4N2NJdWdOa2pOSE8xSWt3QzhwTC8z?=
 =?utf-8?B?YlpmN3dSV1hZSVlIT0dtbEEzcVVhODBEQXViekc0SkJLU1BZOWVWekptU0lZ?=
 =?utf-8?B?SWdHSEFHYjlJNjZMQzBrUi9uRGFsVHdMRmRqcnhtaitJZlFoQUN6UUtIK2RX?=
 =?utf-8?B?MzhUOWdIQUhXYUsrY3oxT2NCbEU0Mk1jTHlpSTFLR1VGOC82VHVQVXhiVFkx?=
 =?utf-8?B?Tm5kZ3BNdnVpWGVNSm9aVEdGRmFuVytyR2ZhaXpqd1AzNkEvQ3NYR0FORTEw?=
 =?utf-8?B?VEJaekVuWld4VGY1dElrS0dmVE9uOHBncDhRdkN6ZU84RVBPa2IvWXlKSXlv?=
 =?utf-8?B?STRZWGRGcmVHd1QwdktTVDd1dmZlblhXK0tJdnRYamVkVkFYemNzc3VXT0tG?=
 =?utf-8?B?MWhIOGZNdHhRZHpVK3dyendYelZKL2NhYmVNak03TXpKR3laRXpEbnlaV0NQ?=
 =?utf-8?B?UUI2VmZsa3plQ3AybUdYdXMwb0RmSytLb1lnR09lN1hQN1RoZDNtOVpwUjBn?=
 =?utf-8?Q?NKfgAZHrP2wb9SRaO2jUUPq2DJ8IgfjvPVgNKla?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86745632-3ba8-4368-2a9f-08d8f37d31a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 13:10:30.0886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V9E3xIYgJXCNCkciQVBPHrU5n+RfyNUpSZ684mKQ2vdEwkMCVYAydecjlhQk0g5OSO/GHWU0v22GTF+dXNkB4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1159
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Inline comments after yours'.

Regards,
Guchun

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com> 
Sent: Tuesday, March 30, 2021 6:40 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix compiler warning

Am 30.03.21 um 12:02 schrieb Guchun Chen:
> warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
>    int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);

Well there seems to be some kind of bug in the compiler if it complains about the code below.
[Guchun]From linux coding style's perspective, we shall put the declarations together, separated from code by one blank line, right?

>
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 722efd86718e..2a6fc0556386 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -824,7 +824,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_device *bdev,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
>   	int r;
> -

Better have variable like "r" and "i" declared last.
[Guchun]Will send v2 to address this if you don't have objection to this patch.

Christian.

>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE; @@ -861,7 +860,6 @@ static void 
> amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
>   	enum dma_data_direction direction = write ?
>   		DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
