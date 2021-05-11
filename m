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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BCC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 02:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D716162B
	for <amd-gfx@archiver.kernel.org>; Tue, 11 May 2021 02:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D716162B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA4AE89C86;
	Tue, 11 May 2021 02:23:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0D889C53
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 May 2021 02:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCjSzhSuHZoxDuJDE4mpuJpagQdbJeEIvyWhBvUFv2twAn4VrWnwIWM3ETGk32YwFJiMZPwM8I7C2JyR7Fhxds9cDwWeTEfMKeWAYmk2wJIv0LhqAGCrKnfzND2Nbbigl8A3D75ogqoVLzzSiGgMvWN9C2YawdpFuRCEGMvBGUYmtujx/XkZwOBUPRJxezA4YF3d+KMysZbOWDL57msIQEH2DXZjCDGzWNUhZKRULomAPOAI9V3K8Lf7a4Z9Eg8HMe6CXtctnFdkfWFLG0wdk2HDEEr5L20yqF40V4vbrEx08VjnkFuuEu7TKCF8UoMMpB5KEhv92+KV233gPggoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJWuFBCik6unagb1zVqBsz7qs2UXknTq3PZ3aeeZft0=;
 b=G0DjfhXXOfCRKchP+Cqm6T6On2r+Q23NfXCnAP42vjzmWr6DVF4hl0hljo/SVt7OJLCfAqShqUs1tkf8EoccmfgrHoxLspxhuZ1NeOy4AuJ2Q0sFkWwaVOx+YCickF2Ofkq/xewddeNbv81fjK5XSw9/zyAks3ZPCJNtbT54JdLVi2QnzE0cqpZLH3we57Lx0L70VhVR2mgzwBHG8wXAXonZikN9w1lU7HiFW41cBp1Nyrofk9vT+qqjQN8fIcu13XvTY1tUuSz84inmN6a7FVXZkViDFJ+hJOsz6pL4NXwoScw6JfTXtlNbcck8y6yk1yQPT29b3j7AukKoJUM76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJWuFBCik6unagb1zVqBsz7qs2UXknTq3PZ3aeeZft0=;
 b=to7ycpuJpv++9/ZhyIuT1pFmuxJp14ZP1P5DPbZPvLVU2qwF4M4i9Fa1v4JToL6sjQKl+Tg9Pz4ba8L3ZDj2Kb80hQdsDsB2YDm8hQBhwNgdNNb40uexkPCVq0rOnqZOJwGNkfyAGbeY5eITpLy1DIeDOVW9vmpEuC5JJUQIy18=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31; Tue, 11 May
 2021 02:23:21 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 02:23:20 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Nieto, David M" <David.Nieto@amd.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Topic: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_info_vbios
Thread-Index: AQHXQ9Yf8LVbEME0wESo6KxpkiJJJqrbUMIAgADxAdCAAAjk7YAAA0iggABtf0iAAANEgP//9+aAgADU3gA=
Date: Tue, 11 May 2021 02:23:20 +0000
Message-ID: <CH0PR12MB5156416E8409EB41D0858D64F8539@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210508064740.7705-1-Jiawei.Gu@amd.com>
 <CADnq5_PEogZDyFV_NOzbsajJQ_0A1+Jui-Mx7N_xsyWR5wXb8Q@mail.gmail.com>
 <CH0PR12MB5156FA453692B69100C3ADE7F8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <D7E9BE46-8E25-4A62-BE91-947898903A04@amd.com>
 <CH0PR12MB5156AF69D9E04020FDA5354AF8549@CH0PR12MB5156.namprd12.prod.outlook.com>
 <BYAPR12MB2840BA4077C73311A671CCBEF4549@BYAPR12MB2840.namprd12.prod.outlook.com>
 <bbf8cdf1-00a7-3e2a-74b0-71e85f1c7697@gmail.com>
 <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
In-Reply-To: <447046CE-6FB4-49D7-A74A-2188654F5D5C@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-11T02:23:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=244b768d-2e8b-4a5d-b702-9e7969cdafbf;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fc1eb29-4fb3-42da-db88-08d91423beea
x-ms-traffictypediagnostic: CH2PR12MB5531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB55312FDB52EE89DE797B0898F8539@CH2PR12MB5531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KQa49NQh4aX/MZIyAP+NqsTbsqWhABEebOJ5diebggH2yD625mtM+vNLfoH1Ht0gzVgDZjb4nKvi29ZtwuZTT4xn20sOLuNHMlxsrWWCWhH3eWa5VfM3QjshdLm+TPN7AE6qqYYfc9AhbChAums33je22CCSy35Kktiu4hpVzxORCuKW9YcDOf/ktGVWMtgm18vjFbiPwl/gmRK6pbGLRqWOfQbO+1qHPuXzEGXIuEu5S765Q5CwjfJRo+MdCyEwKHezWN6Iwf1wMBbA+TOruOZm8hfnVt0j1SO2dWyNuSABLRCjcV151BGbasHnX2/Vgdy0sZdevd9BQLnayLIQc8GbrNT3GfTQNk/s39vq+YdtGIguabwoMCJP1i+f2eBxziAc6VQClAuMU94qPlcF5xJ00X3q2xx+1+Zb/5+W0VfLq7uaB7TqPksnVpK9QW6osGiMtBwsA6Qp3jBbu/fYUqoR+Dp1roSH2UGihT2SbD1GTmL8mSi8vb8nCN/uhtpIhqjvbCeLwahGEeiBIG/oCMWZwUTi+P27CujmYZO0l56YG90gM6Udn4JKL3qeIrfuzS7ItAWsIFDz6Yv5qLVFJeVF+UHiWuef3qkNKY2qAloAYrEgBTlsRmDwoDxcvnWqa8glAkF4A/V3oy9RUAg3846eQ372QtCBlwBVhlUDmvlonso8Tc0x1wi88Tb+50qE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(8936002)(8676002)(478600001)(38100700002)(186003)(9686003)(33656002)(4326008)(66574015)(83380400001)(122000001)(55016002)(53546011)(7696005)(86362001)(26005)(66556008)(64756008)(66476007)(66946007)(76116006)(6506007)(71200400001)(66446008)(166002)(52536014)(2906002)(54906003)(5660300002)(966005)(110136005)(45080400002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6dDoxTSdX3sGeZiuf4MaD66CoGm+ExV0qiwRjXO+XeoNQj1U9qP8xFrPJy?=
 =?iso-8859-1?Q?6bxiyWQkfwgaEyfu1VEoQ1lFMhQpMotiByp2SZtk6P4MFcQB/6CoufkWQn?=
 =?iso-8859-1?Q?UgD5sCfLoP29vMch+FAY25TfVd+EhJHLyQrLZ0T5JdSft5/2YVSlPnEEpR?=
 =?iso-8859-1?Q?Ewls1XlcytHXapVjDnyt2DlCO3Ik6gDx5xUJLQbzPC0/KIIKpyvuVtsdLY?=
 =?iso-8859-1?Q?VioLXH/nKB2AmJrASgUXCAtm/OsDrgGhr8kGELLD3P/ux2sSVxDvNzOfAK?=
 =?iso-8859-1?Q?TOcHEviF6HSzIcimNr1TebR9i2N6K2RmOAxpN46PyWe7eJTBEFEbPsSmjA?=
 =?iso-8859-1?Q?KCOSVyJHGEa7SqYjqawgtaR+M/mx+Cgbo95pZRUXgbPi7Wscc8F5482edp?=
 =?iso-8859-1?Q?lo/y/pMbQWxEJB22n6STCLsoWDPoynCPN1pATPNfxxFaFql+4VHk2cRmUZ?=
 =?iso-8859-1?Q?16Mr1pcmCY7l3Ez55pVzXjivPnyO36L51KKmJxiW7B58mIuqpT+icRiBnl?=
 =?iso-8859-1?Q?O0YKxnpogzOQ94REBy0ND5wkobSXLzX3vqmA5r25T8TcCfiBqve89G2BTv?=
 =?iso-8859-1?Q?Ck5PehMUtJQLQ3mXzV8mNDL2C7WllShZFtEdMwfwIVAEnJhZtWHNlOz282?=
 =?iso-8859-1?Q?W59teV9XE8C4KI8ffTCG1HaLfcf+WOLI/t1Gq9jLUQzQaPTm7j1vnYuO51?=
 =?iso-8859-1?Q?jVfRTNkc//RPmgdBuu2dEEh77Dj04LD4Xlu7reUKytrsleXS7zHlFY/Hwa?=
 =?iso-8859-1?Q?8oDFkA742zsoALcyC91JKo5U2AX2jXQu9aT4A3gORweEfqBp3UVKTwX++a?=
 =?iso-8859-1?Q?U2Hhk7xKr1Yv2JQAx0oDmOMx8m0IDH4HJoyLLIo+MNjHrLiFTkPne+h8mH?=
 =?iso-8859-1?Q?EzGLtcQ10WM9K3c42HIAxfgPG/QZsf9s4uquOpUbKAuofgTVhEqLyuINR6?=
 =?iso-8859-1?Q?Zn6l3V+aWppFKF+gmU5iHcJGFv4rchSVN8uVKFu5DC9W40xZtkT8t2I2Ki?=
 =?iso-8859-1?Q?tscX27SWROeKOhoh2YD/H8BimEvmzKXv4ioLH43iTK0IDNvLpjmIwaJicm?=
 =?iso-8859-1?Q?3VckMI2xk9zXrK7rLXI7jQYNnecyGjaCnTICtpfkQSdKWupSMUsVpoqCGi?=
 =?iso-8859-1?Q?63LB7f4HooYvSIYo8PJ/1DCIR+ZBa55yGEZYEKD/RqnRK5lW6qzlxS7e05?=
 =?iso-8859-1?Q?qOr9xlKfnwudwAe9RlGkiwr9ufuCMIlW8sYcdTWUbG8toUWWBfnES2Xmv6?=
 =?iso-8859-1?Q?WoDWIE0ImE+FvXib7M36HzxtOnVwQ2SgFp6v2BNjqE2Yhsyj2ybhYxKzEe?=
 =?iso-8859-1?Q?FrXXAJBWXwSH1J02uazdCramRsdWNn/5eVVOwVUS5NzUEHXH/B8Izjuz07?=
 =?iso-8859-1?Q?LyVV/+28li?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc1eb29-4fb3-42da-db88-08d91423beea
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 02:23:20.7267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQVHrmxbP5K7LRKNXIE4PTY1IifZ/ZBqxyvT6BnYZjQsAMJPaEEURdhvjt4AJyvNBpxMG02hF+dX2aIZVMN6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
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
Content-Type: multipart/mixed; boundary="===============0104302070=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0104302070==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5156416E8409EB41D0858D64F8539CH0PR12MB5156namp_"

--_000_CH0PR12MB5156416E8409EB41D0858D64F8539CH0PR12MB5156namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

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


From: Nieto, David M <David.Nieto@amd.com>
Sent: Tuesday, May 11, 2021 4:20 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Gu, JiaWei (Will)=
 <JiaWei.Gu@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>; Deng, Emily <Emily.Deng@amd.com>;=
 Kees Cook <keescook@chromium.org>; amd-gfx list <amd-gfx@lists.freedesktop=
.org>
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


--_000_CH0PR12MB5156416E8409EB41D0858D64F8539CH0PR12MB5156namp_
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
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:Consolas;}
span.EmailStyle20
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
<p class=3D"MsoNormal">Got it. Let&#8217;s keep them both.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Another idea about drm_amdgpu_info_vbios is<o:p></o:=
p></p>
<p class=3D"MsoNormal">Does it make more sense to fill the &#8220;serial in=
fo&#8221; with uint64_t adev-&gt;unique_id, instead of the current char[] i=
n adev-&gt;serial?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry about that I was not aware of adev-&gt;unique_=
id exists when I defined drm_amdgpu_info_vbios.<o:p></o:p></p>
<p class=3D"MsoNormal">I think it&#8217;s clearer to use original numeric v=
ariable than a string to expose serial.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">How about that?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&gt;&gt; struct drm_amdgpu_info_vbios {<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 vbios_pn[64];<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 version;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 date[32];<br>
&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 serial[16];<br>
&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u64 serial;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 dev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 rev_id;<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sub_dev_id;<br>
&gt;&gt; --<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Jiawei<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Nieto, David M &lt;David.Nieto@amd.com&=
gt; <br>
<b>Sent:</b> Tuesday, May 11, 2021 4:20 AM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;; Gu, =
JiaWei (Will) &lt;JiaWei.Gu@amd.com&gt;<br>
<b>Cc:</b> Alex Deucher &lt;alexdeucher@gmail.com&gt;; Deng, Emily &lt;Emil=
y.Deng@amd.com&gt;; Kees Cook &lt;keescook@chromium.org&gt;; amd-gfx list &=
lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Align serial size in drm_amdgpu_inf=
o_vbios<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">One of the primary usecases is to add this informati=
on to the renderer string, I am not sure if there are other cases of UMD dr=
ivers accessing sysfs nodes, but I think if we think permissions, if a clie=
nt is authenticated and opens the
 render device then it can use the IOCTL, it is unclear to me we can make a=
 such an assumption for sysfs nodes&#8230;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think there is value in having both tbh.<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">David<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:12.0pt;color:black">From=
: </span></b><span style=3D"font-size:12.0pt;color:black">Christian K=F6nig=
 &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzume=
rken@gmail.com</a>&gt;<br>
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
o_vbios<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Well we could add bot=
h as sysfs file(s).<br>
<br>
Question here is rather what is the primary use case of this and if the app=
lication has the necessary access permissions to the sysfs files?<br>
<br>
Regards,<br>
Christian.<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 10.05.21 um 15:42 schrieb Nieto, David M:<o:p></o=
:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:blac=
k">Then the application would need to issue the ioctl and then open a sysfs=
 file to get all the information it needs. It makes little sense from a pro=
gramming perspective to add an incomplete
 interface in my opinion&nbsp;<o:p></o:p></span></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"1" width=3D"100%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Gu, JiaWei (Will)
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
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
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
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
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
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB5156416E8409EB41D0858D64F8539CH0PR12MB5156namp_--

--===============0104302070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0104302070==--
