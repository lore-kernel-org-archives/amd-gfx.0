Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D6BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 03:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973F3611C4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 03:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 973F3611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F616EA98;
	Thu, 16 Sep 2021 03:15:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EFE56EA96
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 03:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxIrQOYgzgLSyGXdqrnfcrhC7wpvENkDn7tRNq4Bguy1lmoOodrGXpWaigezexx2fPRNBjug50AcE3vCLpspPAfB71YlJcic5R26s5i7ye+tkOj4rKiU1+2ecYP0msSbrVcfvba4fVVBepI4nHNSo4MwKwE+qP7x0o4DFmsUv7MoY+bfNxa5D3kF452/ulM9yz52HV3XlkyV5k5ec+93XxCuJiOIMjvUJz3Rq1GjA/J79QksA/i3BDA49VntMSM4uINZ9AIl50tKGrfZe/WP1581aGGpUEV9RIiNUv5Bv2hjcH+qtbEV0Sty2WXpgeuAF3BEart30IIG1uaX7xTRrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=M7v3ORn42DUfT6dVhnpHjRV4tb52cwdpx5siHRwZ+Nk=;
 b=f36W1kzSaVOu6baKC2cAr0M/g71jgEYUwxB+UAbeeb876lwLSYzAGXOXnTqn1N9IshYlYHoF6nU3niaXq/sSpYCZqZX6p8HkRpzsF09aCYWnSQOW+RdMsfbfXoibJOcFMXNt+7HCm8NYn6po76ugDvBSNceA52yd7u3k9bXaa5K1PWjZFtx6X9GVp8+JAukF3vtyxOfoqwSsKE/P573Wgc35vHgxUc63hpBIUsnynWOm5XL7kZ31OSur3B8lOphIrwNxsZi7hR0dv07PlHcZcnnWfrzn/5dmAKUL6Y1gKN1bO+oPkBmNOEgYasPt8oJ1jzM+GwJcUA2sF3tyVLvakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7v3ORn42DUfT6dVhnpHjRV4tb52cwdpx5siHRwZ+Nk=;
 b=RNn3qYzcpDQQd1kcuIBFCm3bOxqaYHozRXimXLMaunl30u9GRexPst16u2DbWn6/o1vV0Lwcudqmoqlxs622KdzTYfqeWaLkKnwPM3bQyasRzu0XHytB/LQWVe1f3+VfU7uhoH9g2h1yjKVB8q64ssxS8m1GmoMJ8Tl6sQmu9Ws=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB2504.namprd12.prod.outlook.com (2603:10b6:3:e3::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.14; Thu, 16 Sep 2021 03:15:51 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4500.018; Thu, 16 Sep 2021
 03:15:51 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: =?iso-8859-1?Q?=27Michel_D=E4nzer=27?= <michel@daenzer.net>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "'amd-gfx@lists.freedesktop.org'"
 <amd-gfx@lists.freedesktop.org>
Subject: DRM IOCTLS  come regularly(every minute) still even after screen off
Thread-Topic: DRM IOCTLS come regularly(every minute) still even after screen
 off
Thread-Index: AdeqpzmJfJwUM32PQa+HCKK6tNRnPw==
Date: Thu, 16 Sep 2021 03:15:51 +0000
Message-ID: <DM6PR12MB2619F306147E803C1C10FF8BE4DC9@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-16T03:15:48Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=52ed401f-7eb0-4c1d-877f-545a4f22aa00;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a011bd7-d50e-477c-0050-08d978c04981
x-ms-traffictypediagnostic: DM5PR1201MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2504AED0E39A1D7925BCF1FCE4DC9@DM5PR1201MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KUAun/D0RCCSYLdq9Mpt9S1qe1ddeqRRXpvtnf4PQHl1PN5lI8iZxLN+99jqwLynbjEJPVcofOGlo0vZhl2zS8KzuX2rmFm5rKEiWOTzVYQl7IIy2rK1I4njcURZWEsuWayPqp99UGdG2qVc5syYZK7U4hDAT+p1yMg0OKQndwPx+nK6yYk/c8m7Ivb/D9KPCZHHQhHWEzv8XZYOi6ACrX4nvFJ6mwSRVTtLgZsaIFP/FXKuE8hvF8CJ4JAmUlIJuCd/u/3xmBkCjGu/6OCClg3hetyk2ESFAsR1CteXfsKvLdSte7htaWDBju64DWtB1nHjendyCIFuP5SEj2+tVX4Zm0GCl8o53V4piQdV5g7heg6WlP/m/g1wCfkKGlwTcUnHAH1reyp0f09YfzjdxDv4rq0dJ0rmo7dQb5iPJ1sgAbv2DYlaw+OBAI0UVU8lKvBJuvSNCtGkgtR9XkG0aOCd5z+4eUeK2+Ek1hKImDUxzVsi4xvFZd/sw+OJoGSCwc31Ags9OF1lsoqYtf8ChdW9x2zDWl/+36chf6/FE/HaWKrXDmMlZxh0NqYio7sv9uRfO7PtEcjyZfrxvdf60vujI7+A7byjXmoNtAS1Oq+i70n4hmDFq1KSI8eCXlSlXnJjJjiInajmV56MOacDvc3/iepV1agYrbqIASWZu+g3uicxbSV9lbO9NvCWU6cyfLOjEqrWVuryqB+hQxXrbg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(66946007)(66556008)(66446008)(2906002)(76116006)(66476007)(64756008)(6506007)(8936002)(38100700002)(83380400001)(71200400001)(26005)(8676002)(186003)(33656002)(9686003)(316002)(122000001)(54906003)(55016002)(86362001)(38070700005)(478600001)(5660300002)(52536014)(6916009)(4326008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4fkCm9cIQeqrm+RAOQarO+6+VEZr6bV5HwdpX5zIuF1P8vDK/L8u439M07?=
 =?iso-8859-1?Q?44WKRSvAgyjeh/7pwMv3Vny0MnRqPJ4SVLB9sXv5eNuIuOnGRd1xeP0C9U?=
 =?iso-8859-1?Q?3CsiOpJ4pWesMYndKFDDboKbMtpsy61fPrw4BLGmVUmS28OIzPXAWriZxv?=
 =?iso-8859-1?Q?Hk+8GYh0hCVUD4PvKzcr7byZ9b7YkZ3Rsnvb4hMiUSI6sXztfAR8UgqYjR?=
 =?iso-8859-1?Q?E/5gXRNEs7P4ttSCYRbz2jOARxEBIvH0qyxsIzD+NtSTBIuj8TzJ+r4h/0?=
 =?iso-8859-1?Q?20/1xAa9oqULtDpbrXAHy8e5VsB/dTj1fHUXzuqOj5jtNJVPTB6JQmMrv1?=
 =?iso-8859-1?Q?LOSeEwEutLmHTAFmLx9zJYzWJyR/UqQKnKOIX+lYzm6ce6rNworOuHNECV?=
 =?iso-8859-1?Q?K3dQzll7heckDSOpxdn7zpc1S1z3dqLG0ngAH9Yofrput2zI4ZRU8pPj18?=
 =?iso-8859-1?Q?uQTacdvys71mGDcnb6q2xDuu5op3VYJDb8CufcH1IfcqtuiHzDu5xHQmiE?=
 =?iso-8859-1?Q?ROAJhF3wzOmxUuyxN9WQbr95wGaWCANf9x/20gJSPAxqOAY7K8KopLrtle?=
 =?iso-8859-1?Q?WWNsHisd40aYZ13szxunXQK0dAAu0YOvGYphRCkq/Ax83c0nlXI2o6c5g+?=
 =?iso-8859-1?Q?vyP5grjUWf3fZ6qtTVzCsIyTiGM1bhDmHKZFXPTlsfE4HM8dSQN6uZ5WkO?=
 =?iso-8859-1?Q?mORbW1S+Y6ivri0KtX/KFmmIrG9raTCEL+rKhHx54OB5Rj0zjFMAYvL2g/?=
 =?iso-8859-1?Q?NQRIjDMxvTI7HmG/wWx8K16Rds1ulZ5RPt8E/tJ57ow6C6MWE/ugdfL/J9?=
 =?iso-8859-1?Q?bqJ9DFpQT9YF/d1vbuNgsQeZkAdjjcvqNaJ9Fvam7a9viRyQiexZ50eINU?=
 =?iso-8859-1?Q?qLw/bl36RsMDFZq5EqP5+JIENCxtpXD7KFRBxnrCfZlg05PdtImfdogUR8?=
 =?iso-8859-1?Q?XXjDL7oZIFQKYpdhbOHlrvAePFKCmSslHxAxwFxfEzO40yk4pyZVyofkrC?=
 =?iso-8859-1?Q?5AYXHI31fCZUvzt/F4rTiQb47050WIyiSHusE+csd8suLcOKW/FRVftTBv?=
 =?iso-8859-1?Q?LkQ1QE8F1oHCLUNVjiJilF1egWvuKrPr/XwflQogTj2XQGD8I+qJR04Rsi?=
 =?iso-8859-1?Q?5Q9nDpD0x5aj9X267ONEHvHV1c7uUeGOibqMzHHgEMeUacJ5X5OTxMtukQ?=
 =?iso-8859-1?Q?ZJ1ymJ180qs2jJyiAtSTem5wCB9cPA1Ckjz3BxngXlNCWMWrQIcCERVYwA?=
 =?iso-8859-1?Q?2oEkzhF3rd1AS9ltXnH856rYdWAPztN3NSIAb+mI01i9d7WxQow6UKk14i?=
 =?iso-8859-1?Q?O2FtcfaPLBgWjveNX82G1VCovXHou9kHI0OZ4oRNUJAQNz7aW9E1rB9jDQ?=
 =?iso-8859-1?Q?KxB+LISd8Q?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB2619F306147E803C1C10FF8BE4DC9DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a011bd7-d50e-477c-0050-08d978c04981
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 03:15:51.1231 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nO6iLAPHCwuvg7An3U0dTAHee+Rpacmbu5CzOa6rOJeRIt9NcghMCWymvihoasRb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2504
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

--_000_DM6PR12MB2619F306147E803C1C10FF8BE4DC9DM6PR12MB2619namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Michel,

After the system idle for a while, the screen will be off(blank out) and AM=
D GPU will be put into a very low power state(BACO) due to runpm.
However, I found there will be still DRM IOCTLS(which I paste below) coming=
 regularly.
And those IOCTLS(especially those for AMDGPU) will wake and back our GPU in=
to normal state.
To me, that's a little weird as the system was just left there for nothing.=
 I do not know what and why these DRM IOCTLs come for.
Per Alex, it seems "desktop environments poll for display updates at regula=
r intervals". Do you also think so? Or any other insights?

[68528.542455] [drm] comm=3D"gnome-shel:cs0" pid=3D1306, dev=3D0xe281, auth=
=3D1, AMDGPU_CS
[68531.186534] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.197027] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.205649] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.216308] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.224912] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.233533] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.242097] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.250631] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.259269] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.267788] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.276401] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.284942] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.293477] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETRESOURCES
[68531.302091] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETRESOURCES
[68531.310689] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_LIST_LESSEES
[68531.319346] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_LIST_LESSEES
[68531.327880] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.336495] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.344985] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.355652] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.364217] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.372657] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.381089] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPBLOB
[68531.389519] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPBLOB
[68531.398702] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.407148] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.415572] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.424147] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.432682] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.441192] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.449754] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.458232] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.466723] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.475140] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.483608] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPBLOB
[68531.492056] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.500520] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.508919] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.517270] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.525752] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.534235] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.542665] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.551169] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.559684] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.568152] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.576624] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.585143] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.593620] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.602075] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.610515] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.618989] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETPROPERTY
[68531.627481] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.636060] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.644614] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.653131] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.661702] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.670250] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.678805] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.687356] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe201, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.695931] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.704526] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.713078] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.731981] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.740552] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.759552] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.768152] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETRESOURCES
[68531.776663] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETRESOURCES
[68531.785214] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_LIST_LESSEES
[68531.793774] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_LIST_LESSEES
[68531.802380] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.810882] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.819460] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.838377] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.847004] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.866051] [drm] comm=3D"Xorg" pid=3D1035, dev=3D0xe200, auth=3D1, DRM_=
IOCTL_MODE_GETCONNECTOR
[68531.874725] [drm] comm=3D"Xorg:cs0" pid=3D1133, dev=3D0xe201, auth=3D1, =
AMDGPU_CS


BR
Evan

--_000_DM6PR12MB2619F306147E803C1C10FF8BE4DC9DM6PR12MB2619namp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheadera4477989" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Michel,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After the system idle for a while, the screen will b=
e off(blank out) and AMD GPU will be put into a very low power state(BACO) =
due to runpm.<o:p></o:p></p>
<p class=3D"MsoNormal">However, I found there will be still DRM IOCTLS(whic=
h I paste below) coming regularly.<o:p></o:p></p>
<p class=3D"MsoNormal">And those IOCTLS(especially those for AMDGPU) will w=
ake and back our GPU into normal state.<o:p></o:p></p>
<p class=3D"MsoNormal">To me, that&#8217;s a little weird as the system was=
 just left there for nothing. I do not know what and why these DRM IOCTLs c=
ome for.<o:p></o:p></p>
<p class=3D"MsoNormal">Per Alex, it seems &#8220;<span style=3D"font-size:1=
2.0pt;color:black">desktop environments poll for display updates at regular=
 intervals&#8221;. Do you also think so? Or any other insights?</span><o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><i>[68528.542455] [drm] comm=3D&quot;gnome-shel:cs0&=
quot; pid=3D1306, dev=3D0xe281, auth=3D1, AMDGPU_CS<o:p></o:p></i></p>
<p class=3D"MsoNormal"><i>[68531.186534] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.197027] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.205649] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.216308] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.224912] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.233533] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.242097] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.250631] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.259269] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.267788] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.276401] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.284942] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.293477] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.302091] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.310689] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.319346] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.327880] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.336495] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.344985] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.355652] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.364217] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.372657] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.381089] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.389519] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.398702] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.407148] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.415572] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.424147] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.432682] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.441192] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.449754] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.458232] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.466723] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.475140] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.483608] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPBLOB<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.492056] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.500520] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.508919] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.517270] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.525752] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.534235] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.542665] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.551169] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.559684] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.568152] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.576624] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.585143] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.593620] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.602075] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.610515] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.618989] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETPROPERTY<o:p></o:p></i><=
/p>
<p class=3D"MsoNormal"><i>[68531.627481] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.636060] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.644614] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.653131] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.661702] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.670250] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.678805] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.687356] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe201, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.695931] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.704526] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.713078] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.731981] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.740552] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.759552] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.768152] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.776663] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETRESOURCES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.785214] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.793774] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_LIST_LESSEES<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.802380] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.810882] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.819460] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.838377] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.847004] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.866051] [drm] comm=3D&quot;Xorg&quot; pid=
=3D1035, dev=3D0xe200, auth=3D1, DRM_IOCTL_MODE_GETCONNECTOR<o:p></o:p></i>=
</p>
<p class=3D"MsoNormal"><i>[68531.874725] [drm] comm=3D&quot;Xorg:cs0&quot; =
pid=3D1133, dev=3D0xe201, auth=3D1, AMDGPU_CS<o:p></o:p></i></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
</div>
</body>
</html>

--_000_DM6PR12MB2619F306147E803C1C10FF8BE4DC9DM6PR12MB2619namp_--
