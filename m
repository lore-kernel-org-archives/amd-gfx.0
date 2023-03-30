Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5D0C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 09:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5957A10E07A;
	Thu, 30 Mar 2023 09:15:14 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEFD10E07A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 09:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVHT9klU9AeLkAq/6XD+/YMfWwLhGFeJ1iupTUwWKkI0p5qNQ7xmzOKDF7QH+RtQ/oO1yCeVi5YyCIS2tFETIRcStTZHrpc9CNBbCsXt+ZpCMBwk5IEqgtNaBFCcyQoLFQNCEBBxcorlaCxJI28o521xcB3FOl6mWzjWJOtvEe3klHzmbvjj4QEsgg+nIKEw6rJoe7/BYYsrLWDHUF9KtyNDyRR5Wez947xAmzvFNbVN3tISku0Ahmw2S/42E58gro4hJYsHdcfVvNANnO9YWbwddVjT/szI+mbMSWJjgL2OtvejBRHksynguV9xcLviPRTi35kxSAOEXbxejcuRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byC1oHPksoJ4yl8z1ztmEnxG2BP0YYSgSeuPbQYED5c=;
 b=oWd7ZYEewqJrRK+Y9TFtJmZcJkJOf0PDb7c/RMmBNJzFcoNLib0payMqrrS0i9c5TAjrWTquVdCAFFtHxAZ/Oibr38Xx1qdK2eRJTNoNijrtoNzVonPbwLKwt+ZnQX0bBQRWkztLOEetRP6lomfVrmZ+bYq2xhb895MgGvHwHnTMrwphi2TDJw1GMebiSrufPxYFoSFhyORTauMpFquHQvm1pOSbn/EuruaFjpj1alDHFDEE9bEiXdVMNajcKhKbHJ0SNZ0HUMCJFvfswgSIGL6uqPjzF53s/k65/PSbDJkkf809VnNNWnrJLDVkBlUPMTB0H6eDmia+oMaeDfAEfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byC1oHPksoJ4yl8z1ztmEnxG2BP0YYSgSeuPbQYED5c=;
 b=oenWjdIhlwFR1J7kB2B+PlhVTI45lowco3UvDLLbo/ZB6TNt29T68EdHaPNIADhrzl/8aT1VpmRol6Xpf8unUQIjr+Zae4Dgj17gTEzSFhJJzKrlB5hHqFhDfEwMc3Zk6P/Ql4QfbAT+d7UDrTE8TVwMGGco7YR6Ox4X2vuf8I8=
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 09:15:08 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9%6]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 09:15:08 +0000
From: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Thread-Topic: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Thread-Index: AQHZYL+u0CSWOl4FhUCX0abAnaoJla8QC+QAgAL+iBA=
Date: Thu, 30 Mar 2023 09:15:07 +0000
Message-ID: <SN1PR12MB24455388D199AD581AC2FA5CF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
In-Reply-To: <76206089-39dd-c009-f0a3-415f3c02406a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T09:15:06Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b32db47c-f268-4bfd-98c1-d8512d3c6a34;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-30T09:15:06Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 33aa32cd-dc5a-4299-bbc3-b71bc3a01813
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_|SA0PR12MB7073:EE_
x-ms-office365-filtering-correlation-id: 5cd65907-ff96-42de-c49d-08db30ff419a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mz0ASBmjT6x9zgEiG0JPlITOr3yLWn6T02MX8xKpbU3DnYTSet4+dcwDMcrIEoahTz0YovMIW1VXFpE751mnCDwrzYwcYzfp89+g76YZ8J4VYKigJLKGCLjlIAhPO731BzwYpnTMonvgPsjqcF5sz8FY/KYrntwFhkisau8l1KF+nFVl9b1g4dmge06c6ZcTjWbtZeArmAROEDqqRb98F9xwI8HYRVLhCA2qAxdhwMzRmrt5PP8X23Csx9V6poJoxAUWzxwJ3jBggYQJPMYhtSbiIV2k5bwnx/LJJ2jho3wI3fAQ827eo3AmrvyTLQcm8KaeFsl+DCFs2GLkBq6S5UwETIj6pIs/KRBA+lL0HqNQYKuDRfql90XJExn1l7syBfQmB5CgacEtfOA76N3EYkExJhUHDmlc7Nu/2YwX9WKWOyX1/Hlv1dos0E6eC1AcNefSa2Eq6PAhwF7o09F77LhaPn3hFlJfyooin4O7YFDm73FamVPrkGn8Hcr08z5DDJnV3RbBItwcsms5UDQ0177iQDmzJrKdxKEHu+mgBSxtrDJB6JtuuF4gaEufdAeQkusFZHtJQ9m70eZrnCjkiL8E9g4NVe9j5aZwZ/LLR2qg/Uf/LziK2mfwOVnT9mNP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(66574015)(83380400001)(478600001)(7696005)(71200400001)(316002)(186003)(26005)(53546011)(9686003)(6506007)(2906002)(110136005)(8936002)(38100700002)(33656002)(122000001)(76116006)(66946007)(55016003)(64756008)(66446008)(66476007)(66556008)(41300700001)(8676002)(86362001)(52536014)(4326008)(38070700005)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?B/ktEtftts3shCIyC55CeWD7gFjUpS0YP2JpNFpl6+uuOSKEC8NruUrqSd?=
 =?iso-8859-1?Q?LUa1hlBGUziFV8rgDCdjAX6I2wKKmwMuxvin2RMEAEeoKsc9o7gxeHuowd?=
 =?iso-8859-1?Q?M5ISp4oZy+3itjIT3LbKkSuaV28SAAUkDx1LHGF1Z0UVmZ7fZMm6ThhU85?=
 =?iso-8859-1?Q?eGDsNcpB1JSesOK2PWrH1qj+yvqY+5cs8M3reuaYZyGrQAXhmIfqWAA6+s?=
 =?iso-8859-1?Q?dXjZdQ0daWzKihKnaCNA8yWWL7Iz4GVVb4RHWafBkkLjzLq/5GQjWHJu12?=
 =?iso-8859-1?Q?4QIV/rI6Pd2e9YQhkLbuatLNk6fPIsjuvWsIGoQLrTQZAMGdErvGfmlAwL?=
 =?iso-8859-1?Q?NwNsc7fkPFRgy0oV+qO006HBaqhRIZAUfhaB+6MRlfkoiKdJzce+EXoiRb?=
 =?iso-8859-1?Q?pZZSAXIQN1jomEW2cclBseShREzJ5F0ZI0QJLREJ9qKGVBHamsq9WxRHbN?=
 =?iso-8859-1?Q?Y7Ejcf/LEA6jTSULeSUQR2G1+dCPkH7SaSGL0S1YJQlw+LV3wt+9oxrd6G?=
 =?iso-8859-1?Q?W9c0XAu5ylJejzJ5ZkJxrEW6A707G9XLkowbx5BUxklnpUHQ7C2A2FH8zs?=
 =?iso-8859-1?Q?Euf9cTqS7NQgU0LZHEoBQvkCstUXEFWlxV0pUuQg/KMz8IwGizbW89+a8R?=
 =?iso-8859-1?Q?Ifq0EwWu0bNibY10mON3APCZcFTiVZf93qmKdMfzYHTZmH0mHASgBp3E4F?=
 =?iso-8859-1?Q?w0WxrAXEwPtYkdOr79teyMzVsbm4f2HB5qxTx/yLLJZyu3klJqdyFVOPG9?=
 =?iso-8859-1?Q?DybytMLv9ezAl85ZaEp7colwmmdbPYXEw6KXSaY0kBvmhaoe6nhtT6eAJo?=
 =?iso-8859-1?Q?+9+lsoow65sWsqFcS6bD3XHYe60k6tv7oo6JxXX9thOGq1sG9VLQ6G3fko?=
 =?iso-8859-1?Q?dwBicfKLGOGdn1Xw5T+MTO+C2YKO6kpRWehUATGg0bhpffk4wc6xzDNRTF?=
 =?iso-8859-1?Q?xL+hofFG7bPjvI67uP3ppurz93pydtl3E2VJ1ofaDf8IqfY8QAXsbgvDcB?=
 =?iso-8859-1?Q?U15WoNcFwTKXMrrRJmV31t3z/l9YoRwbnWWWnB/691pGrYRIcM233+F/pB?=
 =?iso-8859-1?Q?XYiCLEXCZzx9u38fqA3ATJi0x1/2MVNiO+KzsPpmO8S86SI1ow+9izOM7P?=
 =?iso-8859-1?Q?LdNeWZBb2cUb3MHQYUOZQ9oOBrNZaIseeh3Wd7jnnfuHkv2QI5o8UPzZsV?=
 =?iso-8859-1?Q?L0t5EucjZ2OhWB9HxoEV38NMfn0hu+YwGxJ/pJSrqbRBNzxSX1JAHZOaXp?=
 =?iso-8859-1?Q?TwFbSsv6ubTbE2/y/5MhZn7yyDCHjHAHfXxaWecEyofbESkRMX78cFVbpC?=
 =?iso-8859-1?Q?jzsTNxdLpl98DetmaBLzjv9L4eVFFdfVxeljBWtSn0Cwri9eoaPsRok/ll?=
 =?iso-8859-1?Q?NwVECuzwzrNiXzrCBZrRv67z45Jg+D81jPuPNTkxSidxGWp+5PCytfxk17?=
 =?iso-8859-1?Q?X2eprhM5yp+Lbf9ljxIXL77zLDjQGmngkyvfdZE/SkeVEVgAZGoL9sGmee?=
 =?iso-8859-1?Q?lz486VJ9caYns36F1YApqHwNIJw8u7kPC6wfz+Ma1S3l3ukUN2LGFHK/BF?=
 =?iso-8859-1?Q?CylTw+3rRcGcsE/T8JbWdwgpi5lqQfEk90qzyWHZNxpB2pgTz5IBy3JGeb?=
 =?iso-8859-1?Q?msOf9l2Pse7HQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN1PR12MB24455388D199AD581AC2FA5CF58E9SN1PR12MB2445namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd65907-ff96-42de-c49d-08db30ff419a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 09:15:07.7964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t79XIoVrC3i0BteKJZ3JrcCc/84ZKtGs3y+GiFKbqk5AsW8Q9/Y/VHswwB7fPyhZn4v3csiedx5GvjkQpTxltg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SN1PR12MB24455388D199AD581AC2FA5CF58E9SN1PR12MB2445namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Hi Christian,



Thanks for the review. Please see inline.



Best Regards,

Alan



-----Original Message-----
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, March 28, 2023 7:16 PM
To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.or=
g
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset



Am 27.03.23 um 17:20 schrieb Alan Liu:

> [Why]

> After gpu-reset, sometimes the driver would fail to enable vblank irq,

> causing flip_done timed out and the desktop freezed.

>

> During gpu-reset, we will disable and enable vblank irq in

> dm_suspend() and dm_resume(). Later on in

> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and de=
cide to enable or disable the irqs again.

>

> However, we have 2 sets of API for controling vblank irq, one is

> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has

> its own refcount and flag to store the state of vblank irq, and they

> are not synchronized.



This is the source of the problem and you should address this instead.

The change you suggested below would break in some use cases.



In struct drm_vblank_crtc we have a vblank irq refcount controlled by drm l=
ayer, and in struct amdgpu_irq_src we have enabled_types as refcount for ea=
ch irq controlled by the dm.

I think the best solution will be to get rid of the refcount in drm and onl=
y maintain the dm one, and add a crtc function for the drm layer to get the=
 refcount/state of vblank.

But this may be dangerous since it's a change in drm layer. Do you have any=
 comments?



>

> In drm we use the first API to control vblank irq but in

> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.

>

> The failure happens when vblank irq was enabled by dm_vblank_get()

> before gpu-reset, we have vblank->enabled true. However, during

> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state

> checked from

> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq

> again. After gpu-reset, if there is a cursor plane commit, the driver

> will try to enable vblank irq by calling drm_vblank_enable(), but the

> vblank->enabled is still true, so it fails to turn on vblank irq and

> causes flip_done can't be completed in vblank irq handler and desktop

> become freezed.

>

> [How]

> Combining the 2 vblank control APIs by letting drm's API finally calls

> amdgpu_irq's API, so the irq's refcount and state of both APIs can be

> synchronized. Also add a check to prevent refcount from being less

> then

> 0 in amdgpu_irq_put().

>

> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com<mailto:HaoPing.Liu@amd.com>>

> ---

>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++

>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14 ++++++++++----

>   2 files changed, 13 insertions(+), 4 deletions(-)

>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> index a6aef488a822..1b66003657e2 100644

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct=
 amdgpu_irq_src *src,

>            if (!src->enabled_types || !src->funcs->set)

>                           return -EINVAL;

>

> +         if (!amdgpu_irq_enabled(adev, src, type))

> +                       return 0;

> +



That is racy and won't work. The intention of amdgpu_irq_update() is to alw=
ays update the irq state, no matter what the status is.



This is a change to amdgpu_irq_put() to prevent the refcount from being cut=
 to less than 0. Does it break the intention of amdgpu_irq_update()?



Regards,

Christian.



>            if (atomic_dec_and_test(&src->enabled_types[type]))

>                           return amdgpu_irq_update(adev, src, type);

>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> index dc4f37240beb..e04f846b0b19 100644

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct

> work_struct *work)

>

>   static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)

>   {

> -          enum dc_irq_source irq_source;

> +         int irq_type;

>            struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);

>            struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);

>            struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crtc->s=
tate);

> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *cr=
tc, bool enable)

>            if (rc)

>                           return rc;

>

> -          irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;

> +         irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev,

> +acrtc->crtc_id);

> +

> +         if (enable)

> +                       rc =3D amdgpu_irq_get(adev, &adev->crtc_irq, irq_=
type);

> +

> +         else

> +                       rc =3D amdgpu_irq_put(adev, &adev->crtc_irq, irq_=
type);

>

> -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))

> -                        return -EBUSY;

> +         if (rc)

> +                       return rc;

>

>   skip:

>            if (amdgpu_in_reset(adev))



--_000_SN1PR12MB24455388D199AD581AC2FA5CF58E9SN1PR12MB2445namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:blue;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0cm"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Hi Christian,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks for the review. Please see <span style=3D"=
color:#00B050">
inline</span>.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Best Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Alan<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt; <br>
Sent: Tuesday, March 28, 2023 7:16 PM<br>
To: Liu, HaoPing (Alan) &lt;HaoPing.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
Cc: Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset<o:p></=
o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Am 27.03.23 um 17:20 schrieb Alan Liu:<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; [Why]<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; After gpu-reset, sometimes the driver would =
fail to enable vblank irq,
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; causing flip_done timed out and the desktop =
freezed.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; During gpu-reset, we will disable and enable=
 vblank irq in
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; dm_suspend() and dm_resume(). Later on in <o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_gpu_reset_resume_helper(), we wil=
l check irqs' refcount and decide to enable or disable the irqs again.<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; However, we have 2 sets of API for controlin=
g vblank irq, one is<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; dm_vblank_get/put() and another is amdgpu_ir=
q_get/put(). Each API has
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; its own refcount and flag to store the state=
 of vblank irq, and they
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; are not synchronized.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">This is the source of the problem and you should =
address this instead.
<o:p></o:p></p>
<p class=3D"MsoPlainText">The change you suggested below would break in som=
e use cases.<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">In struct drm_vblan=
k_crtc we have a vblank irq refcount controlled by drm layer, and in struct=
 amdgpu_irq_src we have enabled_types as refcount for each irq controlled b=
y the dm.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">I think the best so=
lution will be to get rid of the refcount in drm and only maintain the dm o=
ne, and add a crtc function for the drm layer to get the refcount/state of =
vblank.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">But this may be dan=
gerous since it&#8217;s a change in drm layer. Do you have any comments?
<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; In drm we use the first API to control vblan=
k irq but in<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_gpu_reset_resume_helper() we use =
the second set of API.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; The failure happens when vblank irq was enab=
led by dm_vblank_get()
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; before gpu-reset, we have vblank-&gt;enabled=
 true. However, during
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; gpu-reset, in amdgpu_irq_gpu_reset_resume_he=
lper(), vblank irq's state
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; checked from<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_update() is DISABLED. So finally =
it will disable vblank irq
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; again. After gpu-reset, if there is a cursor=
 plane commit, the driver
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; will try to enable vblank irq by calling drm=
_vblank_enable(), but the<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; vblank-&gt;enabled is still true, so it fail=
s to turn on vblank irq and<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; causes flip_done can't be completed in vblan=
k irq handler and desktop
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; become freezed.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; [How]<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Combining the 2 vblank control APIs by letti=
ng drm's API finally calls
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq's API, so the irq's refcount and =
state of both APIs can be
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; synchronized. Also add a check to prevent re=
fcount from being less
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; then<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 0 in amdgpu_irq_put().<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Alan Liu &lt;<a href=3D"mailt=
o:HaoPing.Liu@amd.com"><span style=3D"color:windowtext;text-decoration:none=
">HaoPing.Liu@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgp=
u_irq.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
&nbsp; 3 +++<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; .../gpu/drm/amd/display/amdgpu_d=
m/amdgpu_dm_crtc.c | 14 ++++++++++----<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; 2 files changed, 13 insertions(+=
), 4 deletions(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdg=
pu_irq.c <o:p>
</o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; index a6aef488a822..1b66003657e2 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -597,6 +597,9 @@ int amdgpu_irq_put(struc=
t amdgpu_device *adev, struct amdgpu_irq_src *src,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!src-&gt;enabled_types || !src-&gt;funcs-&gt;set)<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!amdgpu_irq_enabled(adev, src, type))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">That is racy and won't work. The intention of amd=
gpu_irq_update() is to always update the irq state, no matter what the stat=
us is.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">This is a change to=
 amdgpu_irq_put() to prevent the refcount from being cut to less than 0. Do=
es it break the intention of amdgpu_irq_update()?<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Christian.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (atomic_dec_and_test(&amp;src-&gt;enabled_types[type]))=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_update(adev, src, type);<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/display/amd=
gpu_dm/amdgpu_dm_crtc.c
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; index dc4f37240beb..e04f846b0b19 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -146,7 +146,7 @@ static void vblank_contr=
ol_worker(struct
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; work_struct *work)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; static inline int dm_set_vblank(=
struct drm_crtc *crtc, bool enable)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enum dc_irq_source irq_source;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int irq_type;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to_adev(crtc-&gt;dev);<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crt=
c-&gt;state);
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -169,10 +169,16 @@ static inline int dm_s=
et_vblank(struct drm_crtc *crtc, bool enable)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (rc)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; irq_source =3D IRQ_TYPE_VBLANK + acrtc-&gt;otg_inst;<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +acrtc-&gt;crtc_id);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (enable)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rc =3D amdgpu_irq_get(adev, &amp;adev-&gt;crtc_irq, irq_type=
);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; else<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rc =3D amdgpu_irq_put(adev, &amp;adev-&gt;crtc_irq, irq_type=
);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (!dc_interrupt_set(adev-&gt;dm.dc, irq_source, enable))<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return -EBUSY;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (rc)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return rc;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; skip:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN1PR12MB24455388D199AD581AC2FA5CF58E9SN1PR12MB2445namp_--
