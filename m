Return-Path: <SRS0=Ao2y=GR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4FBC433E6
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 03:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6491A23741
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jan 2021 03:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6491A23741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E82C689D52;
	Thu, 14 Jan 2021 03:27:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD59F89D52
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jan 2021 03:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKv/NJ8auqQL07zWVkcWTCt+ytZCCGMg7LW17BXPRHtwtDREjavk80Q8XcSNlfQpnSRf0O/8AtYQgqNCAbA/86MgwBgNJCquTS7UBwJKdv7c/ChJnX6WciJAAcVXuYenuCswTAIAq2dBHtJ8iCVkO9tkKKnXrrJCAsTXHXGfPZc4ZzGFsEBZQOlb8kB8AQH5g97soizVdgtCNJYXaUhY3qkDBMrGqOlGQr3COPMH3UYvS7B8SkIVaerxXTF8Vr7/CFn82sIm4QWflaaAkXeHL0OlEJKw1AcLOqDxeOHRqdj/7uOfhs21q8L5z87r3szuWzJWnMCsXGUZ/YQuGCk0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB2j4yuEqai6oqXbaryPBYr+kLzaWafoLWeYfiIEtus=;
 b=NFDsD5RINOyPTSU9A4myeJw238QrbqnE23z5Hr1k7w3cm+sMG1Jbn9fZFuhg+ylZpKDTn8UknttGnQKdGLC5SegJDiQGGM0NUpw/QlXesP61CwdGfL2ig5F6Iq0FGEFnzuOcGupXeAdfaYb+TUeo7XfwYm2Hsj2PctUDhdTBXfnG/t5Jj1flGttOBSwSzqdshIWKLwNScsMMBZN/0A9J2Nxul6TmpG7QjeAsnOA4SdD6iKaWNVrcwntk9a2kAednBm0+exOo/VkChQlnLRXWPXLWaU7NULbu32R7PL4ni+s4TPr8iZsZsR93g/bgUue4vIkRycRIHogXe9w8EQX87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB2j4yuEqai6oqXbaryPBYr+kLzaWafoLWeYfiIEtus=;
 b=NcWoqwxOnGqlt3WQqdnINmGX0go9jnIueggdvicbU7SPjNiXY0RF6D3yftzZAtaZzRyb59Kc6oj6h692ufMAQxTMgSc/u3CCCSxBgGqdxn4ICuctqTSJVoYbxqU9GLvp+ZJU+RFoNu3XgkcVwEMjK/UJd85rCf4AMAXIaRSqrdU=
Received: from DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 14 Jan 2021 03:27:24 +0000
Received: from DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118]) by DM6PR12MB2812.namprd12.prod.outlook.com
 ([fe80::79e9:b52b:c230:6118%3]) with mapi id 15.20.3763.009; Thu, 14 Jan 2021
 03:27:24 +0000
From: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Topic: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs (v2)
Thread-Index: AQHW6iTMxI9z0y7XmUSbubWWJKp/9qomdfZQ
Date: Thu, 14 Jan 2021 03:27:24 +0000
Message-ID: <DM6PR12MB2812C14FDA19467A549E59DE90A80@DM6PR12MB2812.namprd12.prod.outlook.com>
References: <20210104175337.636270-1-alexander.deucher@amd.com>
 <CADnq5_NM4tVs+Mv6RmToa-BNNxnT_io0U145ZfwQK0e4a-y4_g@mail.gmail.com>
In-Reply-To: <CADnq5_NM4tVs+Mv6RmToa-BNNxnT_io0U145ZfwQK0e4a-y4_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-14T03:27:12Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=bb378c7e-c6c0-426e-b8da-0000f9433f3e;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2021-01-14T03:27:12Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: d59a0b47-687c-4716-8412-0000ccda9851
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a6d911b-29e6-43e8-96d5-08d8b83c4fa3
x-ms-traffictypediagnostic: DM6PR12MB4250:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB425068AD82EF09DE9C570AC690A80@DM6PR12MB4250.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yxTLB415dVjr5GjvQeug4CU8U+R2zrFfP7K2i1LVEpolEj0aRIRwOaQ3QLWrrZ0ktvdnrU11eX+y1mex4OmjR3uY6SMY5H2L1oqsPqQyoE6bs6IKTYzJcQTgnOvtPxZhyi8rBRAnfAfgAdJKuGWyVIMJGMkJ9/gyZgZUYnqPS5wPFY5sQJ2FwFu0ewPo/rs5vwG4LDRITLKEiWoD38MaviXj0awoh/4froy/HWXe5yosbAKsS0KN9RvU/wYJg+oJNCltCsFfDvj/lhSn+JN+fRKzHFPyxpZofDfH9uatl5Z62ApDyEW1/ER1yUfjR+Ri1i7iY0oTVppxrtD28hZbhv9Rqtg4xoMrjE214LlgQqomRTRhk3sT2/+VKDyGzzs3ufzxtJZ6dk4vTTIjOIUJ1g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2812.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(9686003)(71200400001)(6506007)(83380400001)(4326008)(26005)(8936002)(478600001)(66946007)(8676002)(33656002)(186003)(86362001)(66476007)(316002)(66446008)(110136005)(64756008)(53546011)(2906002)(55016002)(7696005)(5660300002)(76116006)(66556008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VXMxeFFhQUN4aTVObnNYVTJkZDdkTDRUSTgrRVZ3U0dxL3pxUlFGTU9nNG4r?=
 =?utf-8?B?eGR2S256K1VhTldaRnR0bnRFOFFLYlNkVVJpYUlTT0xoUTQxWGREVVRkamNy?=
 =?utf-8?B?cnJUWW1RYmg4TSt3cGRTM0Fhd1UwL1BPQ1NXL3diZmtDUVNzOHMwdTlVOXIz?=
 =?utf-8?B?ekZzS0ZsM2d4ZStaWlhSUzBzL2hTazJWbkNNbGFWWWlFSE1scFFtQXlVRU1s?=
 =?utf-8?B?ME5Md2JBcUh4Y2IwREpUUjhwUzhJNWFPaUtuV1ZWakF4NjZEdDFUSC9zVlVE?=
 =?utf-8?B?QXl6UGd0dWwxMktiUkVjbkZFa3B3OC9WRjl5SzA1VmJWSWU4U3dZK1gzUTU5?=
 =?utf-8?B?bzAvdUd4UXVqOXdFcld3RUk4WExFOVBKQmdsbUR6cEV0MXR2SklaTXE3Y3hx?=
 =?utf-8?B?VzJubzNwc1c5NkljUWxNQmZWTU9XUnRiSGw5NWRKZW1LRmVLTG9uZk8yQkNG?=
 =?utf-8?B?eWQ5Um5XRVJFRE5nSHV5U1RWejFrUE1KT2dubUxMWDdYdGUwN3hhSUxPNVFl?=
 =?utf-8?B?SEFzOXk2SUNSZUhrcTZMWnVYb1RlR1RmYnMwUEVRMS9ZcncrVWhMNHhsM1l6?=
 =?utf-8?B?RStlRWg3bFQxUVI4MC9zaFVVeGNQSnlQWEdRU1F5cXV5WDRtNW9xbHVaeGJm?=
 =?utf-8?B?akhESUc2MkFGZGozanYyMWdiT2VpeE16OThFY2JhN3NIYTBXNU0wNFJFc1A5?=
 =?utf-8?B?YlZXZHJ3QWZ4Z0R3QjhibEs4Q0VRbjhkc0xFK3VUM3RuSHdYcG85aVlISndl?=
 =?utf-8?B?ZVZvZHowRXgyaHVwWURYNmJYVkJoZ0tUU3o0K3YveFNUOG1tcFJJMUp0N0hG?=
 =?utf-8?B?Ui9xZjRPeHA1dFU4MDFvS3BmRlVKbEtBdzg3bVRlQUZEYktNL1AyRmtDbCsw?=
 =?utf-8?B?UWxNTjRCak1XYmdsMm05RmJna3UxeDBWMllPeGJicTA5Zm9Uc29leHlBTXRY?=
 =?utf-8?B?NGdaVUJSYmJwZXJlQmludC9BTjFwNUM2bUs3bFJGUTJOWEp6UkRML2pJL3lt?=
 =?utf-8?B?UE9LQjZ1MHNTQWtEK0h5cGtVUFBRcmY0NDBCUlpjbzB4cUNUM0JpNUZZTzkx?=
 =?utf-8?B?UjV0YUNVMnQ5STIwMTBlRDRubHNwUExyVmJraUN6QzcwcU5KbEx5WFZmZGZl?=
 =?utf-8?B?QjUxQkFYQlB2c1NRYjBlQVlDUmd3MzFNdVFNZXFkall6bFZXMUE1Ly8rZHIr?=
 =?utf-8?B?c043K1FYY1pBNm1NbndhblV2VDVCY1AwLzJYb0VJYmIzV0h2YnhnNENpcS9w?=
 =?utf-8?B?UzcwdmNWRVhLSERqeTM1anE5SC9EZ09keWNvekRzTlZScDg2bm5LaVkrM0Rl?=
 =?utf-8?Q?MER1m4mBM3kVg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6d911b-29e6-43e8-96d5-08d8b83c4fa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 03:27:24.5511 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAbcfqtyZWhFT0NyQ9fzdxgtZxPbmcZWatmJWUJtdL1rRczpErV2lZvQis+Le5paRoemp2IAkpD8b56rFWu/5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks, Alex!

Regards,
Joe

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Thursday, January 14, 2021 11:24 AM
To: amd-gfx list <amd-gfx@lists.freedesktop.org>; Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: check the result of copy_from_user in secure display debugfs (v2)

+ Joe

On Mon, Jan 4, 2021 at 12:53 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Make sure the copy succeeded.  Also fixes a warning.
>
> v2: fix the error check
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 455978781380..b033344c5ce2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -101,7 +101,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
>                 return -EINVAL;
>
>         memset(str,  0, sizeof(str));
> -       copy_from_user(str, buf, size);
> +       ret = copy_from_user(str, buf, size);
> +       if (ret)
> +               return -EFAULT;
>
>         ret = pm_runtime_get_sync(dev->dev);
>         if (ret < 0) {
> --
> 2.29.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
