Return-Path: <SRS0=+arJ=BK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED23C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 01:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0209E2074B
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2020 01:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zoPSTguR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0209E2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A4216E985;
	Fri, 31 Jul 2020 01:20:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7128E6E985
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2020 01:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaRjiBhU02ie5fNIiL7myMZUSyPHhro4gCtvQgNiFviAYkNaQBDNe6n8fLwn/6ZII6ORyVf/O9GsikogmmSEXZzrFcNH7+xf45XlD0D3mNUSw4QqDTt7fxXZziTAcUe14Q9KPu/EnhDMfA/h5NrYVknmZtuDEeLxed/K1hOYo7nkm+BRNMP7e9XBZ2VBq/3tEO2kyuXS1AQHSrak5iAUY36VmtxGRvXKTgImbt6OIfkgu0DuDNoLiC3u0a79shQ2gxau0RA7Wd3YEXDz9pEa5cocW1zuJvu1r3mDvfj73CVBsepOZgvY/OP5kCAV5EeVRKws/oZrhXGMhfGsO49zGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEBmAezb1Q0GYyCmu6IVwg4tFgy9XNbAHK4D7/KaZag=;
 b=ThayxiJXExACt74qW13iy+paUQKubfLEb/Qet9wDHo5Rk78wYhSqHhmlb1gPQGH7WsIqdXpKw1z+je9VeoamYuEAcOj1ixLYPO07zDOfOsGxlQok+nzgD3kyDh0I71buRwa6EONzx9ZuDKSJZYR6DmhHQ0rokpIM3fOQMQjBmygJRicXbAk+0yz+sMnrMre462qmmYyRI1+nW9Kv04Rdkh+tE8wQaZXfVBzS3OoRycuIYxykTLxju+uNl9IJA6l44Zhh4ym26eDRu1lGzgZc2ONT6p06yGq0GW7/97Q9JU84EzzHs9liLZLjIgOl9PZ9+K9WC3Q2Soyz2i+EpDKqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEBmAezb1Q0GYyCmu6IVwg4tFgy9XNbAHK4D7/KaZag=;
 b=zoPSTguRzJwySgcnsAH+E8KrekirQZtlanGjrdLjVjqQrz0xZzBKf0Z6aGGTItwhHnjqb+6iaAmpMvokUTV0xiDuxsACHweGIR6DBX27aH9NAj8lgp17iZRjlRuZIUhHxjgiYkivUtRSxaIUDDjysYxQRzEjoehvdsVr9tLn+qs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20; Fri, 31 Jul 2020 01:20:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Fri, 31 Jul 2020
 01:20:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [Bug][Regression][Bisected] pp_table writes began to fail for
 Navi10 on amd-staging-drm-next
Thread-Topic: [Bug][Regression][Bisected] pp_table writes began to fail for
 Navi10 on amd-staging-drm-next
Thread-Index: AQHWZn1GQd42tbb/yka/ETmxecxGwqkg5FXA
Date: Fri, 31 Jul 2020 01:20:14 +0000
Message-ID: <DM6PR12MB2619B3A4D4FF0BD91C594E09E44E0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <c9711af0-12c8-9da8-8a3f-859cdc26129f@gmail.com>
In-Reply-To: <c9711af0-12c8-9da8-8a3f-859cdc26129f@gmail.com>
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
x-ms-office365-filtering-correlation-id: b92b13e5-0a3c-4618-30a2-08d834efe0e8
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-microsoft-antispam-prvs: <DM6PR12MB4124DD765DE2E3A3925207CCE44E0@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cz303v+RB/69msxGqE52ALL9+/CY6HeDUkI6BtHIa0XfqhMUOIg4I0k7/vlrPpNx+wqkTKQh8EykcHah5Y2Xj29Ay7Y28Bhc6YgApglXP0fUYhXgEvvwrPPv/rZhwuJxtzvn2BxJ1m17Of+ir+kqRRHhILjEWnOpyNLfa19oYUx31tk4QsODGSf0EgjEdKiZLhqa9sI9f/bxBBupvsGtH/qCdaB0G8YSwZWDmUXUoieI9PkrndPNdWQniZXm6tOvmY7Fe6d33mlgcFEGG+kU78521wLeQ2UbhAUZELd+0GjnP1H44IrFYwfAq7rRWjeyKBS3gldUpjnwusaLRyRrHV5NcDJ0J0ed2aIHRmNKUTY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(316002)(76116006)(66946007)(33656002)(2906002)(8676002)(83380400001)(55016002)(966005)(66556008)(110136005)(26005)(66446008)(4326008)(478600001)(64756008)(52536014)(186003)(6506007)(9686003)(86362001)(5660300002)(71200400001)(66476007)(8936002)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: EBLqgekCgr9l3y6V3BcCC5+96ovPRMLRJHnHWHISUJrbZHJ+iaxsrh7KXcXvcVfj8aPhlKyoGP6fe7MDWn/Q88hJLXeeYG6F/ZtAcO/9mklf+OdJ3dk6GngCduh6sk8/4I9PSfTNxnxBcqpKZngSa0EtLlW1FK6w/YFIDiroC5cTlRllJonFgVlraIzi6VNB+HBr6euqt1NHWBccEhxR2mkEI9qMO0693PmQK+yVIbsNr4dnrFtHP3FBVaOX1mxefDsgfruGi+9viNB1QgCDNTpiEHcJ2NiOeC7N6EnVLPKHYnDPdfjHossZWNGDWYmcaLRQFT0ylNL6I4n0RygCcUPtRgtRIeKUkoFEAw40dcAHCDKRY95Fkw8SR2C5JmmX6gE5Rnri75WokURr+x0nMl6fauaQUqG1vIz3jvg4TzhXrTY9XmhKUY2sb+viTcevmegyKlfMud9ETQOawQQ5jBO/ojF+Pypp2G6RsIuXZP8lP9HRg9iQVtzVqxYUR3Ab
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92b13e5-0a3c-4618-30a2-08d834efe0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 01:20:14.7097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tct7VwqKCUdwatZznXjA6bPiQrIyTmxdaV12uC3a3Z2frXfkixrUVTna09yG1C/s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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
