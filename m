Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4857C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93C220657
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0V+B3jbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93C220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B24A6E3B0;
	Wed, 15 Jul 2020 05:50:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760082.outbound.protection.outlook.com [40.107.76.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD5936E3B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 05:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGJ/NzBKXe6usWlTJLPDmplzhKEaeDckIHR7SLnh0L9HvznEnSVm7U6dObNYze1Qi2uZojgYQMe7jjCsd+3P0B4VmX/xiGtT73IT3SijT/3oU9LWoYZaYXjmppqgU03pEB6Y/MS/H5ex7QCl72tQ/5WCBsLlodfK+I+b0h3/fuk4IuhKUO51Gdof0u1h+5GKQUQermQsKnROn3fVyt48d5+PTmIO1r1Urv1h6G8sRAYs+kEeyuREg7EUgNMYaRHzfVouOrxDBHuhBQ9hWIrUmVz2Eap5Fv1p2/Bb1+zeBF9eb7yTSSZNS1m2p6w3APSofO6mIb8/aptCVlLLNkerfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLbEf611K2uY9cQ2KmWg1QcLjp4QdROL/E4kj7Av0WE=;
 b=NyT2hN0KnTEVN7uh3pPqBHoJZeurY5MHWANrNLIYtrCD7rtP0ZRmw4lwR5tS3MEF4QcFKLDGTjMTPcZKyJtOCFg4zLWnf3AL9eqXAk6yXyWbFxPkJWeyXZ6TtqxZa5mKk1rly9lTT07CuzJYIvXKOvw2rG2qppiZ5L3O5VQB1z4d2J8UchDyK1+STdmIo+Nub6dgu1auUkrR3mTBCVKTk2InGVcRxzau06txF/pEZj01k3wcH9QLQ+qUOlTeKQl+pGXMuySde0P6wW5beAajo1PHS5iQZ+00+nwYtzI9sZiX4HFWnSq/fWeHmKVNXFpBc8Q9smACiEMBEokytoKqDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLbEf611K2uY9cQ2KmWg1QcLjp4QdROL/E4kj7Av0WE=;
 b=0V+B3jbIBjui6dh2KZpOwR/TaemsNkZg6rcr8pGS7axxyyCWWGaDrk9nB0denADlk/B+VZwRhty7URToG0i2O5ohUGfqUqqvpiGjLgsBIbiFV8Vnu4enbVkW70Nh2cTSz7pq5NEydME4VtXmOjhNDGjlKKqsqvB7frPzrNnOgc4=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4519.namprd12.prod.outlook.com (2603:10b6:208:262::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 15 Jul
 2020 05:50:11 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::a8dc:41c8:6812:d235%7]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 05:50:11 +0000
From: "Clements, John" <John.Clements@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>
Subject: RE: [PATCH] drm/amdgpu: load ta firmware for sienna cichlid
Thread-Topic: [PATCH] drm/amdgpu: load ta firmware for sienna cichlid
Thread-Index: AQHWWhNUavJekz+IzEOgk4t8f/c+w6kHeQ+AgAConfA=
Date: Wed, 15 Jul 2020 05:50:10 +0000
Message-ID: <MN2PR12MB4032201358F1EFED0C976C57FB7E0@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <20200714191629.28563-1-Bhawanpreet.Lakha@amd.com>
 <CADnq5_O7QEJ3hSqidhVjSMQCsFCBYPkaosDDsJhrm33s-ekYtA@mail.gmail.com>
In-Reply-To: <CADnq5_O7QEJ3hSqidhVjSMQCsFCBYPkaosDDsJhrm33s-ekYtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-07-15T05:49:55Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e299f465-00e9-4766-a166-00006be52553;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-07-15T05:49:26Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 317dffc0-23e4-49b0-b63d-000000cab8e2
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-07-15T05:50:06Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 84758de4-8e94-49af-9e29-00008c440303
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 190a60b8-46b3-4d77-fd1d-08d82882f00c
x-ms-traffictypediagnostic: MN2PR12MB4519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4519F1451EB7FAC0FABA6AAEFB7E0@MN2PR12MB4519.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Xjs9Ak+gdVnbu+lNQjkxHYiuBjoOUbZrWxj3HNGgzozArl1mR0b5xKMJ0FINIFlUpLRI9OkgiihEkmeOXalSMBpLNktOEvornkgmY1UGqsrf5tcPbavI50O+qzGVVykh2Ey/Tz3AeqkykA0LHep2ndnBJNMTkUJHLoOIVGCfTYg8doTE1hXO6lVGGHW+DNe6soRFu9gYuokCnIEkEd0wy6I9fRBYrY30CBMh+Y3py7l1CqZ3pHWvSqw/31TrRWSEKLwZqW/MYwXSjg/C4296d1FiR+XhPDu+bpEVtIg5r0IgeElgE10N8cD7wsCmthuyKNWwjc1Uchu1tOWsEnRypgdVBvK3h9nYLRoFM5VAA3DtYaBToDdfGU+xCgvUIzro7L3/Z1YPHn44IaA5fbxYQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(45080400002)(966005)(71200400001)(55016002)(53546011)(478600001)(2906002)(86362001)(66556008)(110136005)(52536014)(83080400001)(6506007)(54906003)(66946007)(5660300002)(7696005)(76116006)(66476007)(9686003)(66446008)(26005)(4326008)(64756008)(316002)(8936002)(6636002)(83380400001)(8676002)(33656002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 4KQmJmWaK8uDYJZQ6vqeBnuKP5lLua7Ev6Z7Iuxu9qnE3B/s3+O9FfiQVrG08L5Ci5ePJgR9hCPe8hFV/peJJfjosJZKrgKE9rW2OqKiWvkr1pHidzNcQ8vMMe/ypgzKFs4/YYMWQ4z8sHATlB9Bd/3v77TqHi3+6RlpXPowSsCBK9LtqCHmYLIOUf3e1DU5uk9XYWxgEBrvx5aNiHyDbX95wWQhCbPB1L3hoV2PkNS1Uw6b24QA+YCEbcD6ZnYIBMwdtSYgY7Z3naWSsgT4VdX2ZTrqnhEqb39fxt063W/G5fQ3VGi3K//qTkC5uJmMlqGwvRyOECiEL6mw51DvFd35Q4JhTDmGrxixXI/6+AdKrAqfLDY1LAfOhVUEik1SCxzm0c9kqxPYThMe2iVy/ih7z2+mQvDSYYQNS2cmJYrjfZMHj9xB/T/4fhhMPw2LPRAWEpBo4uuT6ulre3PzMaT3Avwa76XE6FFxD0Jj1WB68kUUfafY+8OTkH+cXWct
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190a60b8-46b3-4d77-fd1d-08d82882f00c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 05:50:10.9338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cjEje76tzAGayIwwJd17uAKUZVn9O6yE/oYNbggWqJzw17vyfbSvmTSEDV1tQUJMOuBoy6UeB+5v4tx+OYPE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4519
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Looks good to me Bhawanpreet,

If possible could you please also update the FW modules at the top of the source?
remove obsolete ASD path:
MODULE_FIRMWARE("amdgpu/sienna_cichlid_asd.bin");
Add TA path:
MODULE_FIRMWARE("amdgpu/sienna_cichlid_ta.bin");

Also for your information, there is a small bug in the  TA microcode init sequence that will prevent the TA FW from loading correctly, I'll submit a patch today to resolve it.

With above concerns resolved:
Reviewed-by: John Clements <John.Clements@amd.com>

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Wednesday, July 15, 2020 3:40 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>
Subject: Re: [PATCH] drm/amdgpu: load ta firmware for sienna cichlid

On Tue, Jul 14, 2020 at 3:16 PM Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com> wrote:
>
> call psp_int_ta_microcode() to parse the ta firmware.
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c 
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index 423386272920..798bc7b2db39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -173,6 +173,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>                 }
>                 break;
>         case CHIP_SIENNA_CICHLID:
> +               err = psp_init_ta_microcode(&adev->psp, chip_name);
> +               if (err)
> +                       return err;
>                 break;
>         default:
>                 BUG();
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cjo
> hn.clements%40amd.com%7Cc1b9c409e4f845c5a64808d8282dc590%7C3dd8961fe48
> 84e608e11a82d994e183d%7C0%7C0%7C637303524336189607&amp;sdata=BN6utDBMk
> 8qgzY7b%2FOloi0yKQ9hmOHDjXlb3fw9fHio%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
