Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C1C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D752086A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rKPKKqxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D752086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07CB66EB33;
	Fri, 25 Sep 2020 13:55:03 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B09526EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k40Iz7JpOTMjxX3/jG+ibSelVKZF+tjjRHyAIWvhe7sO/HdyW2bycBpe3zB7ih66Q5WZEFWHTDhHN82GcyDqe4BkAitHYUDp24rEEHoZ8GRcm+z2pt8Bf8sqYdGKrzUkUHf86pw8GxGOUQDTv/OzEJ32+BcKirRLh+JCDw/d/Pxwbn6rLzlV6pUBgabg25Xo1oxE9o5LIvssrkpoWFhabB2wYirvRYeY/i1EnYqlUUGVRrkWvTgZ2c+xiJxspl8LNV3qG1HDaWkYuU/K9z5Xff7DeHwIBZGRBzmv2L1O3Likh2bTQcwUgnRzCKn8iUiLbPe80ODE97hbwZRc0OktQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF4QkvNtoKrQz+ZyLBq26AyviClznPvMlVM8MB7Jn10=;
 b=eGAxUHy9GF1kgvT4vcoSIU95fA6L7jvw2f6uv+ePkEOXKjx37HbH0uxRtJa1Ae5oUs6ALh17ED+FUBtpmIgoX02LxHFosWTmU/DG8jAY13uPD0EFmQ+jeqmyxpm2w52Nbl7LVyVMPneE3NZ5cvxdT5l4lxIW5wzpQxaKuaJvEe4W9msYVyLm7xZhLeXpHAaxunyKotBNOuBsZh18zcanSXkt03c15I1uq17SfRTO0nqe1aOlUmhiu0DyAuKSMKkfAWgrolbDLl8xrZsypsIY3xyLpzrEr5ZxWrTEzZ2kPr3JuDry1IWmTfy8oZjsDExxvJB+LMyFpUdq1fO7ZPLqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF4QkvNtoKrQz+ZyLBq26AyviClznPvMlVM8MB7Jn10=;
 b=rKPKKqxVj24PCyplLf9yzplVRWDkc6pJOIkaVfKOd5P+xBMcGK7fyjgiVX/qyrOJwdMjU/HSPl2FsR1QCtqxrxxtbYENvCPuERhynqP4n8u8QD/MhPctSaR5/7I/h/zsRNH445i+d8SCwHwp7ST2Hx5tIdFQiidR0cAt21vAwpk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Fri, 25 Sep
 2020 13:55:00 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 13:55:00 +0000
Date: Fri, 25 Sep 2020 09:54:56 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: amd-staging-drm-next has a compilation issue
Message-ID: <20200925135456.sudcskvjvfqsfnc4@outlook.office365.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::8) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::980e) by
 YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 13:55:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4de5b4b-1f12-4943-2d77-08d8615a9839
X-MS-TrafficTypeDiagnostic: DM6PR12MB4153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB41538B08930181C65183AD1998360@DM6PR12MB4153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:949;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVr31gJzBgyTNBP7C76wD7QaxNSfRU6zAvvO/Ku1OWBrPpZ9D+fp6WkIAcXbZpmPnur2JcRS9eja07Gaxh7JhDgtE/fpbnYvXufPXsahErmw3MVLycUKrBpVkl0L3mv+z4uxSBonfE5fdsHntFp3rhG3x134VvBcpKECs1miSEFtuFQoa7veVFW1MzO8RWWst3y0IEYhyI7hLsc5WdlXzKLOVl3M0OMErBGPwnZjeL07+SREOhtcNJg7lb1VnKPmxPZ11VintKLYDI1K+5UmIy/OrZZsHI/b7U8o8MGKUSe2CEAhGPCk7gJfDl8QvIXTmodmj5QsulbOQE7N4IsepYQ72eqyWUMr5S15NL/mVjszCvz0TTR7HTk2OlF3burnQJXKk9FwqfcjltnAUB8bzcnm8raVq8TZBalGNcyLzhhv1CB1wRDYsOrTGUcMSBwTv4KKa1glV2kGV12dx9rP3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(6666004)(83380400001)(54906003)(52116002)(7696005)(966005)(6506007)(316002)(44144004)(33964004)(55016002)(66946007)(5660300002)(2906002)(4326008)(66556008)(86362001)(8936002)(8676002)(66476007)(9686003)(478600001)(1076003)(21480400003)(6916009)(16526019)(186003)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jOAPqet3GkRRp2L+72ev3QEMi1GA45jMDMb8RrTxo4rj0eyvu2Ukwcv2rbt5nTHrugzKJisQCyU7UAHm/FQIYx4+p/bAmBv6P/ss7yqEcvq70wMeYB2Sk3N8Hm6X8S4vICZA81mzd52SrplmMztIu4zVTSAqYlFlGWStHvQp7SKVO8rNcQuvi6uMq4yl3TvSnuGy14ZQw3jgcFqQu7CXy0HQ8BVeS+tBYtnVgsqLMDZzjmMmOnfdpcxmjibOOqg3hjDMn1/2XnpUIvAASVbeVlnf0JtaSmR3tNH5Kdc9IIk52fHhBLZvndUcKKJsu53PKqRrXcyw1Btq7vjigMYA401tJEFCMIhZ/LWwhpxAMHc9AMARdzt1fsZCBORMilHa730Lbf8Q0491xsG9sFfNsWQ2nELhwTUm4UAzOOn6E4L5H9HYuzK08L1rJXx3iO4ZXd6yAirqnZAu87X5Ey5DpMrxUSPG0vAC6VUnvDVF5stZLD//AMH0dgOKFAoDBWZXu2An8uyIjBdj1/b5dmuVKdYJwSggqOjnGg1i8KEvK+eGvcxowvds1jU3Ii8YkuEUOvEQhtKEhrwSXyx0/iH4OX62wbZvlv9Dm+NFv0lpAvCEksjaSiFq52fqgB4EWBtmxIXIxsRqfxAFlPOEaazd/EfBTZkZ+Ku2lvAglsps4ajDnVFRiVcsHvgPhjnTUvSZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4de5b4b-1f12-4943-2d77-08d8615a9839
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 13:55:00.3711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGlVIo9CbtSLw5FWtxfzhT8vljw7/5bdMChi1ZmRQUZEsrRVM0TIz/h5Zs6Ik3PbMqVHUl2QYheHuIKBqbpxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wheeler,
 Daniel" <Daniel.Wheeler@amd.com>
Content-Type: multipart/mixed; boundary="===============0470911611=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0470911611==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iguqaerr5zzszruj"
Content-Disposition: inline

--iguqaerr5zzszruj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When I tried to build the latest code from amd-staging-drm-next, I got
the following build failure:

drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c: In function =E2=80=98amdgpu_virt_=
init_data_exchange=E2=80=99:
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:586:10: error: =E2=80=98struct amd=
gpu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
  586 |  if (adev->fw_vram_usage.va !=3D NULL) {
      |          ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:591:9: error: =E2=80=98struct amdg=
pu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
  591 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
      |         ^~
drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c:594:9: error: =E2=80=98struct amdg=
pu_device=E2=80=99 has no member named =E2=80=98fw_vram_usage=E2=80=99
  594 |    (adev->fw_vram_usage.va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
      |         ^~
make[4]: *** [scripts/Makefile.build:283: drivers/gpu/drm/amd/amdgpu/amdgpu=
_virt.o] Error 1

The latest commit that I tried:

drm/amd/pm: fix screen flicker seen on Navi14 with 2*4K monitors

Does anyone has seen this issue?

Best Regards

--=20
Rodrigo Siqueira
https://siqueira.tech

--iguqaerr5zzszruj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl9t9qsACgkQWJzP/com
vP9ArRAAxBKpV/DTJmCcmELNelGw5xpnjuAzbNrJARe8fLK1SXmuYkZkUtdiP9le
Z3bu5KJTCQnE0TaV4PQdWSj15IqmK2vBaZ524BtBFmr55FMs+V0KJ+vNgZ4ly+FN
+EuMcBgeGGCzQqClZK4nn8WhVFl3AF5yroF/jiKLW4+QRnR4z6zExx4mylWiDKC2
hHSh/p6rAGl1S8L3yJs5cDT6WsniF7Ry/rV+xAZGIa8nRkYYX4b4q7FSY9b2lXhK
0zwccEvFJQxBKvkXvQvNtxa5v2knAUBnJY1NX2o/7r6F9N/O21+iB0dwXE/qDJuH
YeQaaDohUz7sM8dlg35mpJtPvJ21Jul02cEcJwYg61IhD2HQXyW74d1IhW4KlekA
qP/WxU26O4xcgW4gLu9Wyx+pkwhuESQXQbZlIYXjbFuHJ6SxB59qKkX3enM0+J0Y
p8QcxnugX3lSQKIoQlGyXLAy6Ivq+3G9XDCvdHyC5L6Ru5T9AEXETxTnLDTEoX7j
szGbYFnHnGBdb9A2BE/GAjeVTMitJ1lLM9Eqmn0K8Iuzcj868F2mJFuVhMzd8/Bv
BntRCaJRrzsA6+BqQ7r5XQtwkZzKdXRAIhb6NA9KaYcLaxE/LZZOFgesL6Rht8qW
PXAEmOFWWSTVSDwWlxgrPaFtEhBvsbOIdOuTJe0ryLntjMtMRxY=
=ZD7e
-----END PGP SIGNATURE-----

--iguqaerr5zzszruj--

--===============0470911611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0470911611==--
