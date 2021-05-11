Return-Path: <SRS0=e+DK=KG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTTPS_HTTP_MISMATCH,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC0BC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63539601FD
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 03:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63539601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7126E9A5;
	Tue, 11 May 2021 03:01:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6226E9A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 03:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3Li4tlmoT4s2AMQUlPi3nBfP3ER9SMSyzv6ZOzA5BF3zVjbxJbA37aPcPBNHyIdVnhiaWQJ7SduI4A+lRk8Alc+91oNifdW1EEeY/SxsfogoVKm5kAzTcPbl7yXXfBDuIUwp8d5PM5hFVwKgd8Nzi7Y1y/EhivgHNKJGhX2Ypl7Twjygh9HiRACPHcKsANpBPJaWomOFowj6qj/3yIZAd3CTFoz0QOxEimWtWOVjiqid7r0MAjVKNZ6L+QjXm+G9tqyaZHKy6ox8mCjjsnBIa73u/3f2Zi4GvR/y8wMF4pw/SSVAMXHGmmD8SI3bekWyZ3MNsV9kb1jlJtl/+Ssiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4EfjjngByy+Of6buPwNU8QKgfvmWkFnXN6UZSBhgug=;
 b=BElTcP0yfceiWmDgii2xBLISP73kWdGRoDOoi9WSOK++8jq+9NekRUFfMHrMzSApqqT4vThDvz0+IgqcuDAFp5CS5v7SMhSqS4D9VIS9f7L3YWuWeS/fPP4ZthiWC18vLNXmFrIjj1vBE7kGPFFJzTkwUMLY879TiClfFSwrXSVjHwDhvmCCBRNcdqxBssL50wz/CVMYglaNmw28nimUF2i5UHLMgam7Ks4eaYGpNPakFF2qet1eTpI+cXvUeli7JryTMFcapTqEslxt6h0424kuryPa5DkkfEjP+OD07TS8pVL0C8Kahxv2tgphhUrdU9k6X5KMtDp13GTIK1uXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4EfjjngByy+Of6buPwNU8QKgfvmWkFnXN6UZSBhgug=;
 b=hEnstltpmoppHuMmZmK4ATRhZMR90npavCG3L7uyakBMUDJVtO1tbBfDJUCBfXpl2uiOUSHaBKpgsCqebvRv0R5FozSqZVj6PJPJMOHKBr1UC/ZrDwa8us/FmUBdB9c9acU9ZbnxT2jwMRfUMuhLIF3z5lYnEJnfedmDfNruRN4=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5041.namprd12.prod.outlook.com (2603:10b6:610:e0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Tue, 11 May
 2021 03:01:28 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 03:01:28 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Nieto, David M" <David.Nieto@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7YAAA0iggABtf0iAAANEgP//9+aAgADU3gCAAA1l14AAAmBA
Date: Tue, 11 May 2021 03:01:27 +0000
Message-ID: <CH0PR12MB515623C3A3BF12FB78ABD6D0F8539@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>,
 <CH0PR12MB5156416E8409EB41D0858D64F8539@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB284050850E3DD885927F97F1F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB284050850E3DD885927F97F1F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T03:01:20Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93d2c191-8080-4b5e-2875-08d914291225
x-ms-traffictypediagnostic: CH0PR12MB5041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5041CAEAE9C5E562ABDA891CF8539@CH0PR12MB5041.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7G5tEFiDitwtU6Z7RlL0IThfqjDoEhrCZ9CBzDQvVFzezsBYvDlJ+rDgkFwSUGYIspSs9IICIRCKme7ICQ3P30cxCubdtba5ov5uD2NGO5qs59REUVyEYtrCl5cKamQ8+298aoyQNqXuV0e2erJESfYKzvI/qYpuUJ11WeGR9ICtuw8tcb4oLQ7ybLI0Q1Op+G5zlJ6D7a5Ab/Wt91Vtxihxtzd7DfUf2a81Usw5Udp3K9P31QUY/3BFAJNN4nxtfD/hRWl2TmoAPeqZ10wshNlb6XEWh+xOVGzL3L/mO1IUjywYSKMHwRP6XGN+nLkCbPu2i0GBNvB4OU0tz9zUO7rt6MEykVHfKY7t0qKmKgnAw4b3KT3KFazGRx8A7wFtbr5EDS4MCC3unw2viZgRlt8K/8/CqR+EAU+cL/S9UleQaWVgRS4QkJoeNQ7Yv+1nM2TQ0lxycwpq6aNPWfoW04gWu0vIJPH0yy8QdkxhEli71XoHpsi7Mopwz0VN6a4bzYRRA3vpnJDlhyDSU6WCQ7YJR7ahDLbpeVKt3itX1HXr/mYy+CNvpHuOJ0EN2wKLFU3qJw27W/aKkJGhpkncYqbm0DQYxYgGlUX7E82tvv+lNpbRi5jbsJSaGyarh2yFiCSOIaNtOoLPQnYrdBweO2oTjPbCyS4yQO1Xo31KFOB9wIy45zKtgdE75JD2k7FR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(166002)(71200400001)(122000001)(38100700002)(5660300002)(8936002)(55016002)(478600001)(66446008)(76116006)(9686003)(33656002)(8676002)(83380400001)(186003)(966005)(54906003)(316002)(66556008)(64756008)(2906002)(7696005)(4326008)(110136005)(66946007)(66476007)(66574015)(6506007)(53546011)(26005)(45080400002)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?7bm8q6nVzykeIz8oQc7paFWcIOR5Ta/Cly9HYbBwOV24/C49qgcqSegaXv?=
 =?iso-8859-1?Q?SzUnK40H9zCHLZlS3qHdFPxrgGjnI6mMG/h0yLiecgVvOV2N+nNZvega+4?=
 =?iso-8859-1?Q?i9/I611AYX59VRYUtvyHr/f5B1uQiE7dViBFmA2rBybhJiaDoFnBoemCVL?=
 =?iso-8859-1?Q?qDlSsokkOwTMQQqN0FzbT9Qm78tUU1oUo3KVPUKonu3og0iBi6lK0uvP5q?=
 =?iso-8859-1?Q?mObslQgJAhP51xiSwdIKVjcyugek/60E7ukCQQPjzPWbVcUgRtdVhw0RJx?=
 =?iso-8859-1?Q?diF0aV6XRpOdCDx5Z/jq2+s55bLRvtDZlmuCHNZMZTxeMMjOE77JOFLuGd?=
 =?iso-8859-1?Q?6h8PHTptj7DLd0gIII5uoSc32APWCQLO2LVuIDe6rvnfjyXs1Fn7GiZ0np?=
 =?iso-8859-1?Q?OXHWhVx343gmaa0q38Dx9C57dXab6/HuwjJ6TI02C1YwVUekeFd9fVSpDd?=
 =?iso-8859-1?Q?VbPlD3J8CsXHyj79401ylAYB13ybuO5m9/IfnIsCYGSBOfNB4mm66okjtY?=
 =?iso-8859-1?Q?L73Qux93ZFxXPUIS9HXII+dbXYNTQAwZRLp5RxBNO2TcxK0mXcbjQthLZt?=
 =?iso-8859-1?Q?4+QcL5mV2EyyGCUZllTkps/Y2Vxc2o/JK+ViwWZ5RwbfxgvGv3OELD0+BT?=
 =?iso-8859-1?Q?V15TXrRRXzhjsdyAN7vyey/J4WlQwaG4g6sGia1n+J08XgSDUMt7JyBmhn?=
 =?iso-8859-1?Q?1IGRvcASwsvu0ZrKhZ6/Y0+eX8Q2fjy1Kq2vG5fh96Vy9qxQPTP3KVL50y?=
 =?iso-8859-1?Q?uFb53D3xu8uCCwa6ywlcPwgcG5Izhrf2uGvWLut16qJDuPoJlia/Jsv02u?=
 =?iso-8859-1?Q?LM0NqcXD5mCzZVZxO/kgs5q++R2Q6CBH2QCcNYpsYyllDNqlDpmzr9UqIV?=
 =?iso-8859-1?Q?hLsQTMM2cNgx9LSgXO+fCOgxyOIvxlI3bjg3spkyEmZneKHPS+ZofPwv+Z?=
 =?iso-8859-1?Q?ELVqUf4pjLJutyHCt8b1W/FSNyDlc98NzEHAQuTNuKxJxPpuQDigJnQpWt?=
 =?iso-8859-1?Q?fsywrb7ycsvrvm1qLoU/r2ULNoQwCdV9qTUM79JD2thzEYalnvGWRsIAhc?=
 =?iso-8859-1?Q?3B5RfpqkJfn7Hmfsl2Xls/q4g57NnNY4JAw3Of1brXQ+xcFyFnNTDk+szf?=
 =?iso-8859-1?Q?mcC/bgwHFMeHqndF17VzsmCSL2PNEMSgxXMHWl2Ap2gnmTNosRA4F4Tz5V?=
 =?iso-8859-1?Q?r1ighIRW8SABU3p678gdzX7EofBVP87b08EnZSYSHluhyEB9fmiMOF+evJ?=
 =?iso-8859-1?Q?IEx3hncEZ4zHskPa+nzy7osmQH78C60p2oOS/+abmiqS662kz1QHEYmJ4e?=
 =?iso-8859-1?Q?55CXfZ4q7vyTYiC6LAjUOwpxHfAVbf+NF2ELHp2zS1XBC+IX7BqGDC/1Fm?=
 =?iso-8859-1?Q?MJ4etCWKcb?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d2c191-8080-4b5e-2875-08d914291225
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 03:01:27.8941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tj508n9Ve522Lo+wHWj5YYsJGSI6eAH7aQSdYN7eUdgfoWyn3vDECubxIoRhJLFQ/tBrxg1AxK6mfyxjuecYxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5041
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
Cc: Alex Deucher <alexdeucher@gmail.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 Kees Cook <keescook@chromium.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1417218715=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1417218715==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB515623C3A3BF12FB78ABD6D0F8539CH0PR12MB5156namp_"

--_000_CH0PR12MB515623C3A3BF12FB78ABD6D0F8539CH0PR12MB5156namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi David,

The snippet of code we posted here is truncated.
Here's the complete current struct:

struct drm_amdgpu_info_vbios {
               __u8 name[64];
               __u32 dbdf;
               __u8 vbios_pn[64];
               __u32 version;
               __u8 date[32];
               __u8 serial[16];
               __u32 dev_id;
               __u32 rev_id;
               __u32 sub_dev_id;
               __u32 sub_ved_id;
};

We included vbios name already.

Best regards,
Jiawei

From: Nieto, David M <David.Nieto@amd.com>
Sent: Tuesday, May 11, 2021 10:52 AM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>; Christian K=F6nig <ckoenig.leich=
tzumerken@gmail.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Kees Cook <keescook@chromium.org>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios


[AMD Official Use Only - Internal Distribution Only]

I agree that the serial number should be on number form, but I think we are=
 still missing one field, which is the vbios name, which is located after t=
he P/N, ASIC, PCI and memory type strings (skiping 0xD 0xA

David
________________________________
From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com<mailto:JiaWei.Gu@amd.com>>
Sent: Monday, May 10, 2021 7:23 PM
To: Nieto, David M <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>; Chris=
tian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leichtzumerke=
n@gmail.com>>
Cc: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Den=
g, Emily <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>; Kees Cook <keesco=
ok@chromium.org<mailto:keescook@chromium.org>>; amd-gfx list <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios


[AMD Official Use Only - Internal Distribution Only]



Got it. Let's keep them both.



Another idea about drm_amdgpu_info_vbios is

Does it make more sense to fill the "serial info" with uint64_t adev->uniqu=
e_id, instead of the current char[] in adev->serial?



Sorry about that I was not aware of adev->unique_id exists when I defined d=
rm_amdgpu_info_vbios.

I think it's clearer to use original numeric variable than a string to expo=
se serial.



How about that?



>> struct drm_amdgpu_info_vbios {
>>        __u8 vbios_pn[64];
>>        __u32 version;
>>        __u8 date[32];
>> -       __u8 serial[16];
>> +       __u64 serial;
>>        __u32 dev_id;
>>        __u32 rev_id;
>>        __u32 sub_dev_id;
>> --



Best regards,

Jiawei





From: Nieto, David M <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>
Sent: Tuesday, May 11, 2021 4:20 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.leic=
htzumerken@gmail.com>>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com<mailto:JiaWei.=
Gu@amd.com>>
Cc: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>; Den=
g, Emily <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>; Kees Cook <keesco=
ok@chromium.org<mailto:keescook@chromium.org>>; amd-gfx list <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



One of the primary usecases is to add this information to the renderer stri=
ng, I am not sure if there are other cases of UMD drivers accessing sysfs n=
odes, but I think if we think permissions, if a client is authenticated and=
 opens the render device then it can use the IOCTL, it is unclear to me we =
can make a such an assumption for sysfs nodes...



I think there is value in having both tbh.



Regards,

David



From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.le=
ichtzumerken@gmail.com>>
Date: Monday, May 10, 2021 at 6:48 AM
To: "Nieto, David M" <David.Nieto@amd.com<mailto:David.Nieto@amd.com>>, "Gu=
, JiaWei (Will)" <JiaWei.Gu@amd.com<mailto:JiaWei.Gu@amd.com>>
Cc: Alex Deucher <alexdeucher@gmail.com<mailto:alexdeucher@gmail.com>>, "De=
ng, Emily" <Emily.Deng@amd.com<mailto:Emily.Deng@amd.com>>, Kees Cook <kees=
cook@chromium.org<mailto:keescook@chromium.org>>, amd-gfx list <amd-gfx@lis=
ts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



Well we could add both as sysfs file(s).

Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?

Regards,
Christian.

Am 10.05.21 um 15:42 schrieb Nieto, David M:

Then the application would need to issue the ioctl and then open a sysfs fi=
le to get all the information it needs. It makes little sense from a progra=
mming perspective to add an incomplete interface in my opinion



________________________________

From: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Sent: Monday, May 10, 2021 12:13:07 AM
To: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios



[AMD Official Use Only - Internal Distribution Only]

Hi David,

What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.

struct drm_amdgpu_info_vbios {
        __u8 name[64];
        __u32 dbdf;
        __u8 vbios_pn[64];
        __u32 version;
        __u8 date[32];
        __u8 serial[16]; // jiawei: shall we delete this
        __u32 dev_id;
        __u32 rev_id;
        __u32 sub_dev_id;
        __u32 sub_ved_id;
};

serial[16] in drm_amdgpu_info_vbios  copied from adev->serial, but there's =
already a sysfs named serial_number, which exposes it already.

static ssize_t amdgpu_device_get_serial_number(struct device *dev,
                struct device_attribute *attr, char *buf)
{
        struct drm_device *ddev =3D dev_get_drvdata(dev);
        struct amdgpu_device *adev =3D ddev->dev_private;

        return snprintf(buf, PAGE_SIZE, "%s\n", adev->serial);
}

Thanks,
Jiawei


-----Original Message-----
From: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Sent: Monday, May 10, 2021 2:53 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>; amd=
-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freedesktop.=
org>; Kees Cook <keescook@chromium.org><mailto:keescook@chromium.org>; Deng=
, Emily <Emily.Deng@amd.com><mailto:Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios

No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.

The sysfs node only contains the vbios name string

> On May 9, 2021, at 23:33, Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:Ji=
aWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> With a second thought,
> __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs serial=
_number already exposes it.
>
> Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex
> Deucher @Nieto, David M
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com><mailto:alexdeucher@gmail.com>
> Sent: Sunday, May 9, 2021 11:59 PM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com><mailto:JiaWei.Gu@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.fre=
edesktop.org>; Kees Cook
> <keescook@chromium.org><mailto:keescook@chromium.org>
> Subject: Re: [PATCH] drm/amdgpu: Align serial size in
> drm_amdgpu_info_vbios
>
>> On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiaw=
ei.Gu@amd.com> wrote:
>>
>> 20 should be serial char size now instead of 16.
>>
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com><mailto:Jiawei.Gu@amd.com>
>
> Please make sure this keeps proper 64 bit alignment in the structure.
>
> Alex
>
>
>> ---
>> include/uapi/drm/amdgpu_drm.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/drm/amdgpu_drm.h
>> b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da
>> 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {
>>        __u8 vbios_pn[64];
>>        __u32 version;
>>        __u8 date[32];
>> -       __u8 serial[16];
>> +       __u8 serial[20];
>>        __u32 dev_id;
>>        __u32 rev_id;
>>        __u32 sub_dev_id;
>> --
>> 2.17.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis
>> t
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CJ
>> i
>> awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe4884e
>> 6
>> 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZsb3
>> d
>> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
>> C
>> 1000&amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3D&amp;res
>> e
>> rved=3D0



_______________________________________________

amd-gfx mailing list

amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>

https://lists.freedesktop.org/mailman/listinfo/amd-gfx<https://nam11.safeli=
nks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmai=
lman%2Flistinfo%2Famd-gfx&data=3D04%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8=
a2a74127027408d913ba53e4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63756=
2513264718308%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL=
CJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B2Z0=
PZBWdqp%2FzhsPiqQ8Q%3D&reserved=3D0>



--_000_CH0PR12MB515623C3A3BF12FB78ABD6D0F8539CH0PR12MB5156namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheader4d111418, li.xmsipheader4d111418, div.xmsipheader4d111418
	{mso-style-name:x_msipheader4d111418;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheader4d111418, li.msipheader4d111418, div.msipheader4d111418
	{mso-style-name:msipheader4d111418;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader4d111418" style=3D"margin:0in"><span style=3D"font-fa=
mily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - I=
nternal Distribution Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi David,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The snippet of code we posted here is truncated.<o:p=
></o:p></p>
<p class=3D"MsoNormal">Here&#8217;s the complete current struct:<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">struct drm_amdgpu_info_vbios {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<o:p></o:p></p>
<p class=3D"MsoNormal">};<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We included vbios name already.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nieto, David M &lt;David.Nieto@amd.com&=
gt; <br>
<b>Sent:</b> Tuesday, May 11, 2021 10:52 AM<br>
<b>To:</b> Gu, JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;; Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deng, Emily &lt;Emil=
y.Deng@amd.com&gt;; Kees Cook &lt;keescook@chromium.org&gt;; amd-gfx list &=
lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">I agree that the serial&nbsp;number should be on number=
 form, but I think we are still missing one field, which is the vbios name,=
 which is located after the P/N, ASIC, PCI
 and memory type strings (skiping 0xD 0xA<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-size:=
12.0pt;color:black">David<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Gu, JiaWei (Will) &lt;<a href=3D"mailto:JiaWei.Gu@a=
md.com">JiaWei.Gu@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, May 10, 2021 7:23 PM<br>
<b>To:</b> Nieto, David M &lt;<a href=3D"mailto:David.Nieto@amd.com">David.=
Nieto@amd.com</a>&gt;; Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leic=
htzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;; Deng, Emily &lt;<a href=3D"mailto:Emily.Deng@amd.c=
om">Emily.Deng@amd.com</a>&gt;; Kees Cook &lt;<a href=3D"mailto:keescook@ch=
romium.org">keescook@chromium.org</a>&gt;; amd-gfx list
 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheader4d111418" style=3D"margin:0in"><span style=3D"font-f=
amily:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD Official Use Only - =
Internal Distribution Only]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Got it. Let&#8217;s keep them both.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Another idea about drm_amdgpu_info_vbios is<o:p></o=
:p></p>
<p class=3D"xmsonormal">Does it make more sense to fill the &#8220;serial i=
nfo&#8221; with uint64_t adev-&gt;unique_id, instead of the current char[] =
in adev-&gt;serial?<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Sorry about that I was not aware of adev-&gt;unique=
_id exists when I defined drm_amdgpu_info_vbios.<o:p></o:p></p>
<p class=3D"xmsonormal">I think it&#8217;s clearer to use original numeric =
variable than a string to expose serial.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">How about that?<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&gt;&gt; struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Best regards,<o:p></o:p></p>
<p class=3D"xmsonormal">Jiawei<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Nieto, David M &lt;<a href=3D"mailto:D=
avid.Nieto@amd.com">David.Nieto@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 11, 2021 4:20 AM<br>
<b>To:</b> Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;; Gu, JiaWei (Will) &lt;<=
a href=3D"mailto:JiaWei.Gu@amd.com">JiaWei.Gu@amd.com</a>&gt;<br>
<b>Cc:</b> Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;; Deng, Emily &lt;<a href=3D"mailto:Emily.Deng@amd.c=
om">Emily.Deng@amd.com</a>&gt;; Kees Cook &lt;<a href=3D"mailto:keescook@ch=
romium.org">keescook@chromium.org</a>&gt;; amd-gfx list
 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">One of the primary usecases is to add this informat=
ion to the renderer string, I am not sure if there are other cases of UMD d=
rivers accessing sysfs nodes, but I think if we think permissions, if a cli=
ent is authenticated and opens the
 render device then it can use the IOCTL, it is unclear to me we can make a=
 such an assumption for sysfs nodes&#8230;<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">I think there is value in having both tbh.<o:p></o:=
p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Regards,<o:p></o:p></p>
<p class=3D"xmsonormal">David<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b><span style=3D"font-size:12.0pt;color:black">Fro=
m: </span>
</b><span style=3D"font-size:12.0pt;color:black">Christian K=F6nig &lt;<a h=
ref=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmai=
l.com</a>&gt;<br>
<b>Date: </b>Monday, May 10, 2021 at 6:48 AM<br>
<b>To: </b>&quot;Nieto, David M&quot; &lt;<a href=3D"mailto:David.Nieto@amd=
.com">David.Nieto@amd.com</a>&gt;, &quot;Gu, JiaWei (Will)&quot; &lt;<a hre=
f=3D"mailto:JiaWei.Gu@amd.com">JiaWei.Gu@amd.com</a>&gt;<br>
<b>Cc: </b>Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gmail.com">alexde=
ucher@gmail.com</a>&gt;, &quot;Deng, Emily&quot; &lt;<a href=3D"mailto:Emil=
y.Deng@amd.com">Emily.Deng@amd.com</a>&gt;, Kees Cook &lt;<a href=3D"mailto=
:keescook@chromium.org">keescook@chromium.org</a>&gt;, amd-gfx list
 &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a>&gt;<br>
<b>Subject: </b>Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt">Well we could add bo=
th as sysfs file(s).<br>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">Am 10.05.21 um 15:42 schrieb Nieto, David M:<o:p></=
o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:bla=
ck">Then the application would need to issue the ioctl and then open a sysf=
s file to get all the information it needs. It makes little sense from a pr=
ogramming perspective to add an incomplete
 interface in my opinion&nbsp;</span><o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"100%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"color:black">From:</span></b><spa=
n style=3D"color:black"> Gu, JiaWei (Will)
<a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@amd.com&gt;</a><br>
<b>Sent:</b> Monday, May 10, 2021 12:13:07 AM<br>
<b>To:</b> Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.=
Nieto@amd.com&gt;</a><br>
<b>Cc:</b> Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexde=
ucher@gmail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>;=
 Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal">[AMD Official Use Only - Internal Distribution Only=
]<br>
<br>
Hi David,<br>
<br>
What I meant is to ONLY delete the serial[16] from drm_amdgpu_info_vbios, n=
ot the whole struct.<br>
<br>
struct drm_amdgpu_info_vbios {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dbdf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16]; // jiawei: shal=
l we delete this<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_ved_id;<br>
};<br>
<br>
serial[16] in drm_amdgpu_info_vbios&nbsp; copied from adev-&gt;serial, but =
there's already a sysfs named serial_number, which exposes it already.<br>
<br>
static ssize_t amdgpu_device_get_serial_number(struct device *dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *ddev =3D dev_=
get_drvdata(dev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D d=
dev-&gt;dev_private;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return snprintf(buf, PAGE_SIZE, =
&quot;%s\n&quot;, adev-&gt;serial);<br>
}<br>
<br>
Thanks,<br>
Jiawei<br>
<br>
<br>
-----Original Message-----<br>
From: Nieto, David M <a href=3D"mailto:David.Nieto@amd.com">&lt;David.Nieto=
@amd.com&gt;</a>
<br>
Sent: Monday, May 10, 2021 2:53 PM<br>
To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.Gu@am=
d.com&gt;</a><br>
Cc: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexdeucher@g=
mail.com&gt;</a>; amd-gfx list
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesk=
top.org&gt;</a>; Kees Cook
<a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;</a>;=
 Deng, Emily <a href=3D"mailto:Emily.Deng@amd.com">
&lt;Emily.Deng@amd.com&gt;</a><br>
Subject: Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios=
<br>
<br>
No, this structure contains all the details of the vbios: date, serial numb=
er, name, etc.<br>
<br>
The sysfs node only contains the vbios name string<br>
<br>
&gt; On May 9, 2021, at 23:33, Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.G=
u@amd.com">
&lt;JiaWei.Gu@amd.com&gt;</a> wrote:<br>
&gt; <br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt; <br>
&gt; With a second thought,<br>
&gt; __u8 serial[16] in drm_amdgpu_info_vbios is a bit redundant, sysfs ser=
ial_number already exposes it.<br>
&gt; <br>
&gt; Is it fine to abandon it from drm_amdgpu_info_vbios struct? @Alex <br>
&gt; Deucher @Nieto, David M<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Alex Deucher <a href=3D"mailto:alexdeucher@gmail.com">&lt;alexde=
ucher@gmail.com&gt;</a><br>
&gt; Sent: Sunday, May 9, 2021 11:59 PM<br>
&gt; To: Gu, JiaWei (Will) <a href=3D"mailto:JiaWei.Gu@amd.com">&lt;JiaWei.=
Gu@amd.com&gt;</a><br>
&gt; Cc: amd-gfx list <a href=3D"mailto:amd-gfx@lists.freedesktop.org">&lt;=
amd-gfx@lists.freedesktop.org&gt;</a>; Kees Cook
<br>
&gt; <a href=3D"mailto:keescook@chromium.org">&lt;keescook@chromium.org&gt;=
</a><br>
&gt; Subject: Re: [PATCH] drm/amdgpu: Align serial size in <br>
&gt; drm_amdgpu_info_vbios<br>
&gt; <br>
&gt;&gt; On Sat, May 8, 2021 at 2:48 AM Jiawei Gu <a href=3D"mailto:Jiawei.=
Gu@amd.com">&lt;Jiawei.Gu@amd.com&gt;</a> wrote:<br>
&gt;&gt; <br>
&gt;&gt; 20 should be serial char size now instead of 16.<br>
&gt;&gt; <br>
&gt;&gt; Signed-off-by: Jiawei Gu <a href=3D"mailto:Jiawei.Gu@amd.com">&lt;=
Jiawei.Gu@amd.com&gt;</a><br>
&gt; <br>
&gt; Please make sure this keeps proper 64 bit alignment in the structure.<=
br>
&gt; <br>
&gt; Alex<br>
&gt; <br>
&gt; <br>
&gt;&gt; ---<br>
&gt;&gt; include/uapi/drm/amdgpu_drm.h | 2 +-<br>
&gt;&gt; 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt;&gt; <br>
&gt;&gt; diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt;&gt; b/include/uapi/drm/amdgpu_drm.h index 2b487a8d2727..1c20721f90da<b=
r>
&gt;&gt; 100644<br>
&gt;&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt;&gt; @@ -957,7 +957,7 @@ struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[20];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --<br>
&gt;&gt; 2.17.1<br>
&gt;&gt; <br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; amd-gfx mailing list<br>
&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dh=
ttps%3A%2F%2Flis">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis</a>=
<br>
&gt;&gt; t <br>
&gt;&gt; s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7CJ<br>
&gt;&gt; i<br>
&gt;&gt; awei.Gu%40amd.com%7Ccea31833184c41e8574508d9130360cc%7C3dd8961fe48=
84e<br>
&gt;&gt; 6 <br>
&gt;&gt; 08e11a82d994e183d%7C0%7C0%7C637561727523880356%7CUnknown%7CTWFpbGZ=
sb3<br>
&gt;&gt; d <br>
&gt;&gt; 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7<br>
&gt;&gt; C <br>
&gt;&gt; 1000&amp;amp;sdata=3DkAJiC6WoJUTeExwk6ftrLfMoY2OTAwg9X7mGgJT3kLk%3=
D&amp;amp;res<br>
&gt;&gt; e<br>
&gt;&gt; rved=3D0<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt">&nbsp;<o:p></o:p></p=
>
<pre>_______________________________________________<o:p></o:p></pre>
<pre>amd-gfx mailing list<o:p></o:p></pre>
<pre><a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedes=
ktop.org</a><o:p></o:p></pre>
<pre><a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04=
%7C01%7CDavid.Nieto%40amd.com%7C3c0071a8a2a74127027408d913ba53e4%7C3dd8961f=
e4884e608e11a82d994e183d%7C0%7C0%7C637562513264718308%7CUnknown%7CTWFpbGZsb=
3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100=
0&amp;sdata=3Dg11aunC78b48N19Q%2FFXJBK%2B2Z0PZBWdqp%2FzhsPiqQ8Q%3D&amp;rese=
rved=3D0">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></=
o:p></pre>
</blockquote>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt">&nbsp;<o:p></o:p></p=
>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB515623C3A3BF12FB78ABD6D0F8539CH0PR12MB5156namp_--

--===============1417218715==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1417218715==--
