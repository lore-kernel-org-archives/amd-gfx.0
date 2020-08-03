Return-Path: <SRS0=0vKA=BN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849C0C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC492070A
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2020 04:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cn+YFB1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC492070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AAD89E1D;
	Mon,  3 Aug 2020 04:50:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C703389E1D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2020 04:50:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iy9eJC9cau6u+oHuOOrfWLRLQD9lkmP4XX3WKd0P7BAVTcfXCQUejpjc7VAsfiX1OQk/m6IYYd/gpSk4hRixmBN6iC8CZmUBDtU5F+0Z00RXA9PCfjS6U3bPgAlVxIPDBeJdSXtBjBsd7v+4epveEGhwXngkeqAHFo4cG2S9My0IQQlNu4aGSWKWN+Auv4tooPEZ5BqAsAaOnjvkiDWu4lVsxKEzOu1Vf8SIGGXt2UwbHrgYyJJWGawpOGoY/2cG/f+EE8/4htSTzfGUSJJx6McAknzJde2PsYNzIL1DNhzfibSCCkyYiROrUXe4HEMIvTaTQ6FSNjATXXHyY77Ncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YODInUMPH+OZM1DEOddyjrV4pufQyMCbEzsa83Tdi7g=;
 b=jMfS6rzOdcwstCw5Sp09vBQNrgPxc+oe2QB3cyxH4YK+VE2KMYhtC9rcjE/RO5t68/die/Ve316qLrMDte7eT3r7vxmyJpRlfFzK2CoKCcJ+8QJrp04NEFvtEZFv8KiVBGlD7lKCS2w3Ir4TwKnGVvpYYdqnDlGVGWimNRajEIrItNpNiZfARbk0Rf4jLPMySDnLoGEKus6ODhHe05qE568TZdpnf6O9hfrXN/Wgs4swMmVxg1SiohHwssr6NeSZPhJMGjTEpke7J90CKBd2a7nI4/MOCOEt2jVjBI3NgOqYcKSnT9saLorOlG1YVcpTKkK/m3KGuuK/4HViQ7AAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YODInUMPH+OZM1DEOddyjrV4pufQyMCbEzsa83Tdi7g=;
 b=Cn+YFB1W0igMt9XCnj2WgpITunD11r/CqjsNgpPa4yR8QYNkutB4256MgkNC33/v7ozIU0nSiDp0G/d/HKcl6FrxteDrtgQ+mkhTDTh7hcfNl5cRIiQP5IGQsalw+gT41v4PoZTihF+ilM2i/mDrs/+QUQi1A+YcFD97ZS0ipMw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0218.namprd12.prod.outlook.com (2603:10b6:4:4d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Mon, 3 Aug 2020 04:50:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 04:50:56 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [Bug][Regression][Bisected] pp_table writes began to fail for
 Navi10 on amd-staging-drm-next
Thread-Topic: [Bug][Regression][Bisected] pp_table writes began to fail for
 Navi10 on amd-staging-drm-next
Thread-Index: AQHWZn1GQd42tbb/yka/ETmxecxGwqkg5FXAgATxQDA=
Date: Mon, 3 Aug 2020 04:50:56 +0000
Message-ID: <DM6PR12MB2619432DCDA1624DE36D7C97E44D0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <c9711af0-12c8-9da8-8a3f-859cdc26129f@gmail.com>
 <DM6PR12MB2619B3A4D4FF0BD91C594E09E44E0@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB2619B3A4D4FF0BD91C594E09E44E0@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=ea852cd8-1bd7-4cb5-ac8f-467a94fab1f3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-31T01:19:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e2bc82c-c733-4008-3b39-08d83768cf10
x-ms-traffictypediagnostic: DM5PR1201MB0218:
x-microsoft-antispam-prvs: <DM5PR1201MB0218A4576F4CDAE6C588A4D9E44D0@DM5PR1201MB0218.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgApqoJGyqb7lCjs3We2z3AuWuaZ+sJNOm8v7acqL8NWrn+9Cu3FqKslDwRxG5SZsKhM623K3C2yM6wk6ZSjU4/OFZb6kaggrYHUHhZxLsjXJq5PIK9CsFArjIWkJ9OuOM2I7/IwJrA3Z77ad3qry29tUaNCkTVD2F818U1RoN12+BXUr1vomX44UIP1OjUbhoScWqfPJxqrHb6PUY/xf9s2CFPwQ7CO/sVTjSnFUbbJNmxebVyMg/pSSCIzNvsSBFk/jDWxF3U/X0ASHDoFNkGqxn/Kyz6ESUWTphZaeE41WYFxKyjGBCm2wh5mtl1xGjw7c4DkLO49Tat4EMQdvgjy0qZyqRucyqbekedphn8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(186003)(5660300002)(316002)(7696005)(66476007)(64756008)(8936002)(55016002)(9686003)(4326008)(66946007)(66556008)(71200400001)(478600001)(66446008)(966005)(110136005)(52536014)(33656002)(86362001)(6506007)(53546011)(76116006)(26005)(2906002)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: krxKfiDA0ld0lqSzNn0JZzs3R2W5+fiiN0Dp94EutrYBxPIHxuhfOPuHfp5+p8lRHA53l3tzXuxxwpf7j5yjORJcgkzfnOOeHJ9nzbATMKCMgb6hMBsCJhXmR3UEZoW38z0Wvm3W4A2Ij/LcZ1z4yY6IXb/h+TQxrHJupowwnD38xkjDt2ydnWtdzUVgD4TU8KHlqsJZ4bADaT/lpf8UauHiN97zP3hjzijzlm7GPr2SPRNmC+05hB/NH3V+5voqWYpAccjsVQYYrbeJRUnxaG7mlWJgM9RefceX5+h+NaJ3gdxiywWFHVhskmhhZ2QOs2NmKeY8jWj7sc6KloUPmoMuIB5W2pjaSrplJHgY6VwPUnLr6OHNY1kYYxQRpC23NptSwhu27SfKE5maoArVgHuwj/805uAo2NGjdHq5zOJxzammmm6KLCaaIz7ec44K1/ZfdCUOCGzz3qSqVpG/5+tQgDFk0T9+WQIMQ8oBDJ9NEQzWjXHkQuna3hc4vtNaWe7VeNpcW4P9aH2yzEW7F5weZ8GOC+HeKLpuqhQYApi8d0/w01nSA/DWfDXFmgQXVz5DX5X6GcwLzpp6sgymsQbh1mo8+9TLhkM3pcI0ItrmjfKTq/+MEIojtATUGdujYGCy7D88DQaZRrnAs2eVkA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2bc82c-c733-4008-3b39-08d83768cf10
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 04:50:56.1699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0fisdf+pb2AcMbzcLioroCTFQcmsPK9+S+CnfUv0T1Mu3+9UE3Zdm/UGGVxpoHN2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0218
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
Cc: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Matt,

I just sent out two patches to fix the issue reported here. It worked on my local env.
Please confirm on your platform.
https://lists.freedesktop.org/archives/amd-gfx/2020-August/052245.html
https://lists.freedesktop.org/archives/amd-gfx/2020-August/052246.html

BR,
Evan
-----Original Message-----
From: Quan, Evan
Sent: Friday, July 31, 2020 9:20 AM
To: Matt Coffin <mcoffin13@gmail.com>; amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [Bug][Regression][Bisected] pp_table writes began to fail for Navi10 on amd-staging-drm-next

Thanks for reporting this. I will check it.

BR
Evan
-----Original Message-----
From: Matt Coffin <mcoffin13@gmail.com>
Sent: Thursday, July 30, 2020 10:25 PM
To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexdeucher@gmail.com>
Subject: [Bug][Regression][Bisected] pp_table writes began to fail for Navi10 on amd-staging-drm-next

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hey Evan,

I've been having an issue with uploading `pp_table`s on recent `amd-staging-drm-next` kernels. I bisected the issue, and it came back to a commit of yours - ec8ee23f610578c71885a36ddfcf58d35cccab67.

I didn't have your gitlab handle to CC you on the issue, so I thought I'd at least alert you to it.

Here's a link to the issue on GitLab:
https://gitlab.freedesktop.org/drm/amd/-/issues/1243

I'd appreciate any help or insight you could offer here as I work on a fix.

First bad commit header:

commit ec8ee23f610578c71885a36ddfcf58d35cccab67 (refs/bisect/bad)
Author: Evan Quan <evan.quan@amd.com>
Date:   Wed Jun 10 16:52:32 2020 +0800

    drm/amd/powerplay: update Navi10 default dpm table setup

    Cache all clocks levels for every dpm table. They are needed
    by other APIs.

    Change-Id: I8114cf31e6ec8c9af4578d51749eb213befdcc71
    Signed-off-by: Evan Quan <evan.quan@amd.com>
    Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Thanks everyone, and cheers,
Matt Coffin
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl8i2FAACgkQ4mzKau7F
yAfhzQ//a4EgvriD6AdSFUgYmmdMnf1iN+cIDj8JnTuoOgRs+hV2ObIywyE4HZCC
yd1+GdY8/P1VerdC6d5wpTozUBWQGvCnJRnF2kJ7ZKyjsITtpOh6qUWTPbKi7GrU
qz9DD+BIMIcRW/qp+sqVBE0z6vEJSbEkoCF4njV/Qzy178XFNnt0rrScGTsIa+yj
gvUw51m3T9qzMl9pglpUxZv9k3jQfirMZYDv2O2Ds7CIptPGeHDiCW7aNRAPYrmF
UYnt7a2W6fhOrG7x2In8sMECsE/uNa8GMqxAXenRPDok093owHs9zg5lVLbHvvA8
z3iB11n8VT6TknW6YpCm5uE3Lynq1acAIoVO/8m7z56SAIco+xxTkOKt5SWxZGvS
wQN9teaMXYSzHR/d/RTSZXjxBcOYgokIJrcb1hmJd5zw/gvZeeMfhCpyAbnhbOpR
wC6wbic39xNza9sIZrg5NCSx6UcBpfwjKygN7HSutua1nZi9WbvviY6LL69JYhmK
Jyg8RgjgiUPrLomtZx60vLi54dAupyDqJZv2FRHMQTxC+7HagHcDItK8a1KIoNIW
wsvUbonsyyMMxvrTbMPcrTm+yRkFmaP+1fnpgjL1WCHgd4imcl68sV22D64OCT/4
YzfWzhN+dIIUnfy0eWiiLMlOsEWGBN+YPVdLxodK0okjDcQJQTA=
=CzXz
-----END PGP SIGNATURE-----
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
