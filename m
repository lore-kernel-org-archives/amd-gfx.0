Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D58C6FD19
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Mar 2023 01:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6247010E157;
	Tue, 14 Mar 2023 01:04:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5432110E157
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Mar 2023 01:04:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcSQAXwZTDdpjNVEt66y1SJz9JJkqUDn/XCnTjDcBq+LsHMWXAFXK9C110hEztqflxger6GrR02vQ4kYbw6n4PN0/OevPj009NX8xlR5CmjlBDb1t4DTe/8iJF1PyFO1mqkBKKTrPjkWi4s3n3Z8cO7bvvLu30XPI0GeayU7AEAwkVSenJ8oUErP+m6ELqORK/RYaR6ZJVpcHS2+23i3wsjGWtrDT6PKGAb3W+YsZTP0PCqADDjw+HKicbJqTzDnXPUBz3JEmQPOt0o9dcgfHPR3TQCC1pc0uE7fqVcL72v+9ExELN4tSr3XqV18BX4EVOM0MMct5z6q1ypvRRUDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ealz/TQUm3yP0k1qveDMtkrhxGHUoOabMLgbSfRChSA=;
 b=KyWaWXSDSKoXiz3iRS+963CMj8bjOszJMBJXH+tTNTJ3kdNYewhCyV5tSaw8TssMRJ1XZDlFeVE9kVUFDnd68j8IG6R+Oj+IzXi+LlFaMhr341JzZjU63LpIvHg+Hl5NXjzijaOdo7CKuHLEW9sc/hhtVgIsiEJdqTlv5BZO6X4/0XZ2VUWfRDY+FnsYGjSrdYRzrA2rB9ji270kFhJDUIFQRlNcBHhBXbepb/RQJ7UusJvNTp8fvZGNfYakOSL/ntYunc8lhOqa832Aw4rQCYEmM18LA783pU+SLx7CsbGu4DBjyPLDzkmrP5sceNsElsbNhl011KKSQfEvkhqVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ealz/TQUm3yP0k1qveDMtkrhxGHUoOabMLgbSfRChSA=;
 b=zpTOYWuDR7i4MBFZgbNs0eLAak81Gd1qcohoZCIUOkJHsLqb7tQuWMaPyHfWXrr7b2ANuxepNd0RqepxL//p+LjPw/Kdu60RbMd/L4s5ai1RTEYfaW317AEO4NPJ8ksfopiBwVaQyLWc7D2V83F2ZBlzUY6JSJ+jybeu5nAOe30=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.24; Tue, 14 Mar 2023 01:04:47 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::5ca6:3a18:d6ee:c103%7]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 01:04:47 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Zhenneng Li <lizhenneng@kylinos.cn>
Subject: RE: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Topic: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
Thread-Index: AQHZVWchOYQLHNa2aE28tzC+yOJAD675dspA
Date: Tue, 14 Mar 2023 01:04:47 +0000
Message-ID: <DM5PR12MB2469106B445537FF8F7EBA19F1BE9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230313025648.3103971-1-lizhenneng@kylinos.cn>
 <20230313025648.3103971-2-lizhenneng@kylinos.cn>
In-Reply-To: <20230313025648.3103971-2-lizhenneng@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|CY5PR12MB6528:EE_
x-ms-office365-filtering-correlation-id: 90433a64-65d7-43fd-b285-08db24281b24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wc9iVDRPre88YLlc58WgFc1CkopBOwaA9wDRbvd4PR67nzDiKYcP2HhoPaRCBPZNcKYMCuP6hfiPlfC85J10zUnIF2mepqtX2eTwRSEB8BvXO2B8pYe2UgR7OFg9T06MT/xcrXeyETIqk0BhfIxQLStZEzo40+vl+Cxy8K4l7nwalGV/xkHiJPMFM3CmwTH2VRsnCGy0IupNp8NSP41o1IdNqh7/MJDPKbbNA/rbza+cJWwJjc+U1+KpyaKQoKusiaBYr9/pv+FWyg4aoEo2CSutyYBmAh4XW1mlJ93fzA4pSmL+RwMMlefy6M+T8VVw4RLfp700ExcCQ+TELYUj83NxFILeVam6xVNrtkzqhf8Cm4m/GAVoqAUxnlBlUOTPk9+ORwa16wUoJO7xnhuJJrr3ffaEkWeNMtWXRlxnuxqIvVpnBtWKfP1DK26qgP1e3ScF5r1DjJFncSHigLpkNP3RiX8S5p1J4elhBCiqE+BbIurtceT23GTK/DfQbhqOp9JnrH/Mv80wVJdTfQFQ+TluluoqJGP1P8kZUuh1s2cnB8FJYE0vLEyFzpOz9w9E5es/a5Iw75/r57ikccdFz8Hxz+LIGWI6y/Ailvxvrn8hAxk1gSQf8/YauPpGGlZz9okrfo/+dnW+miXglk4lCts4ZNmItx/KpqXpD0WoBiB/eTFYyahPHli4nHPqDoZAMpwxQW/hus0J38dPxMnoxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199018)(478600001)(76116006)(54906003)(41300700001)(66446008)(8936002)(66476007)(8676002)(66556008)(64756008)(4326008)(66946007)(6916009)(33656002)(86362001)(38070700005)(55016003)(99936003)(38100700002)(122000001)(6506007)(186003)(71200400001)(53546011)(7696005)(26005)(9686003)(52536014)(5660300002)(2906002)(316002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w7Cgwufu3jRJIcsZBTA8Z/rIlrr46K3Z9vhqa1YNnvZkl596ZsEwoX9QhrBu?=
 =?us-ascii?Q?NugixiwcLwBkIXw0nja5Wj149NP+sRdUGIJDq2ff8hTq3yNQsXC5YzQwms8L?=
 =?us-ascii?Q?qt24rpYEWiv+usnr0qECuBrthNpNVvozqE/D1uPaC/GmSk+RvC9rtpaAELuR?=
 =?us-ascii?Q?G0yS5LM0qRJqCeuddelMvJV1Oo+w4fquMQRcNSsCbsEBZKf1QoTJ1c55FPVl?=
 =?us-ascii?Q?1RAoF5fPN3bipOVYNkt5r2jp/6+3pi07x+aZr1kyVfiSPYKYs8GzFHs4bsJc?=
 =?us-ascii?Q?nab6nNPMgGsRGHWVzBitkc9aBcWf+F/ag649nXiQM55FkZI0pLt4VUW/Oong?=
 =?us-ascii?Q?gbZ9s+QfsVmZLG6SFI/96OEm+8F20lmwrQFv9QuSPJPhaTXmCD6yFSU6y83P?=
 =?us-ascii?Q?tZkewvcjwsVVurtITDymQsWFNoXg/s66DDKHNtJ/G73TiMgPH31zs2tLKZXI?=
 =?us-ascii?Q?ftLv4UOra8D3Iyl0kuOYK+9A3zkrgzFtITi4ENMe+gNEwU1LZKyxIe+Rb95A?=
 =?us-ascii?Q?uxzOF7u2pZV4QmSJl2AkJbh5T/RQmJZIs+IfgWtenv4Ev/e0eWyMPSTAz6QA?=
 =?us-ascii?Q?yZwm9lJihpE7l8bOFEdiHpsfJEgg5daGHgTNMDkOohOQhH3heDr515XKp34d?=
 =?us-ascii?Q?FUwuxRBZsII67zjvYGdsJvCCWg1MBbQ72FJmdtxPufyrCU5CyEwlq0WLn2c3?=
 =?us-ascii?Q?2YEspGZUWumRkplq3Xsi5K/pKpV96nlv/DZTb3No5jhMFvqNjotN6xU6HGNW?=
 =?us-ascii?Q?g4z7iNhuIPBIiLwXltFgDkrURCkBKEIsorMnGttxXvwuO7YJHLipk3hSnG9F?=
 =?us-ascii?Q?eKKA85QZHIJOBL90YtqpUUOIFvpQicXyZMIbIj6+4+T2rXrDWYmjdcqJ5/Pp?=
 =?us-ascii?Q?NOFXDqnRD5mahWMNQqwEIbVw0RW3DueXqCwgTqy/A9vS3Ui6R52T0gr+cizK?=
 =?us-ascii?Q?ONT/7tGd6hhQujrMw5wne46xgrB+2QaYlpw3QmAze9xHSwFA5ZCSyWqYWT5N?=
 =?us-ascii?Q?AKK8Hp0ycS39Ehc+SFi2oeeCyrLfFzka9XTv+Nv7L6ct0lO7o3cjsF8Pvuzm?=
 =?us-ascii?Q?TSbbVxAp6cczuUWDffvXtLQDFKzMVFjnIhPdwlP2ukyqBNHGh0VBXQ1yGWBP?=
 =?us-ascii?Q?zF0bUz+wFeVRmFwHtpKEgmnV3DxITMqnFv+PePqM+4gfUTjKxgtMLp4NBeLl?=
 =?us-ascii?Q?WnTjutFOarByI+jSIWzvYYPfWUGFL0WgM5QJokzTuwO2Cb1JqNzcMTy43nUU?=
 =?us-ascii?Q?nMCOfjM2IxlhNULG78LWFc0glebaweLX2X5vDotLkSSYlLbojZOEvJGU7tqY?=
 =?us-ascii?Q?Ney/1cos/vF1f4j4ZIDr1j0FyEMYkezg4i8vu3m1yC2cmyMVVjDgVUl2pqpp?=
 =?us-ascii?Q?ZJZ5IYQl6tiSpe4JO6FnK6vb115xgWsz5U5FMn3vnOxGe7c1RlSIFHzndPuJ?=
 =?us-ascii?Q?SZzQc3XaNtt+5cMh4ZL7Plf4K44+1fGunYWh5p9RtHMxpUnmtbv+qiY+8lQk?=
 =?us-ascii?Q?UcXFE9VQp2JPHSTsCDDcK+nLtXK25ug5tEoyyt6YNLvI6ywMKuYIpyN08q/i?=
 =?us-ascii?Q?czwNVgFXW1ayHjSoF11k55V0zl7Q8qGgTJ27MnXe?=
Content-Type: multipart/mixed;
 boundary="_002_DM5PR12MB2469106B445537FF8F7EBA19F1BE9DM5PR12MB2469namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90433a64-65d7-43fd-b285-08db24281b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 01:04:47.5426 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZOZcKafpPI8j7Mk+kTY5nGygep7gkl3z3rIhKo9t2kHEPZiCN94tKtvfmDeXAOqeOpWgf2YXkFVkrULugnzhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_DM5PR12MB2469106B445537FF8F7EBA19F1BE9DM5PR12MB2469namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Will attached patch help?

Regards,
Guchun

> -----Original Message-----
> From: Zhenneng Li <lizhenneng@kylinos.cn>
> Sent: Monday, March 13, 2023 10:57 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David
> Airlie <airlied@linux.ie>; Daniel Vetter <daniel@ffwll.ch>; amd-
> gfx@lists.freedesktop.org; Zhenneng Li <lizhenneng@kylinos.cn>
> Subject: [PATCH v2] drm/amdgpu: resove reboot exception for si oland
>=20
> During reboot test on arm64 platform, it may failure on boot.
>=20
> The error message are as follows:
> [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
> *ERROR*
> 			    late_init of IP block <si_dpm> failed -22
> [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_in=
it
> failed
> [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU i=
nit
> ---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> index d6d9e3b1b2c0..ca9bce895dbe 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -7626,18 +7626,6 @@ static int si_dpm_process_interrupt(struct
> amdgpu_device *adev,
>=20
>  static int si_dpm_late_init(void *handle)  {
> -	int ret;
> -	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -
> -	if (!adev->pm.dpm_enabled)
> -		return 0;
> -
> -	ret =3D si_set_temperature_range(adev);
> -	if (ret)
> -		return ret;
> -#if 0 //TODO ?
> -	si_dpm_powergate_uvd(adev, true);
> -#endif
>  	return 0;
>  }
>=20
> --
> 2.25.1


--_002_DM5PR12MB2469106B445537FF8F7EBA19F1BE9DM5PR12MB2469namp_
Content-Type: application/octet-stream;
	name="0001-drm-amd-pm-ignore-all-in-si_dpm_late_init-once-enabl.patch"
Content-Description:  0001-drm-amd-pm-ignore-all-in-si_dpm_late_init-once-enabl.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-pm-ignore-all-in-si_dpm_late_init-once-enabl.patch";
	size=1107; creation-date="Tue, 14 Mar 2023 01:04:03 GMT";
	modification-date="Tue, 14 Mar 2023 01:04:46 GMT"
Content-Transfer-Encoding: base64

RnJvbSBmZjUzM2FmZDRhNWIxYjQxOWJjYmRhMDhhMjRmZjVmZGVlODUxYzVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHdWNodW4gQ2hlbiA8Z3VjaHVuLmNoZW5AYW1kLmNvbT4KRGF0
ZTogVHVlLCAxNCBNYXIgMjAyMyAwODo1NTowNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRybS9h
bWQvcG06IGlnbm9yZSBhbGwgaW4gc2lfZHBtX2xhdGVfaW5pdCBvbmNlIGVuYWJsaW5nIGRwbQoK
SW4gYm9vdCBzZXF1ZW5jZSwgYSByYW5kb20gZmFpbHVyZSB3aWxsIG9jY3VyIHdoZW4gc2V0dGlu
ZyB0ZW1wZXJhdHVyZQpyYW5nZSBjb250aW51b3VzbHkuIFNvIHNraXAgdGhlIHNlY29uZCBzZXR0
aW5nIGJ5IHJldHVybmluZyBlYXJseQphZnRlciBkcG1fZW5hYmxlZCBpbiBzZXQgaW4gaHdfaW5p
dCBwaGFzZS4KClNpZ25lZC1vZmYtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
PgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vbGVnYWN5LWRwbS9zaV9kcG0uYyB8IDMgKyst
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2RwbS5jCmluZGV4IGQ2ZDllM2IxYjJjMC4u
YWIzNTEyMzIwNDIyIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2xlZ2FjeS1k
cG0vc2lfZHBtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdhY3ktZHBtL3NpX2Rw
bS5jCkBAIC03NjI5LDcgKzc2MjksOCBAQCBzdGF0aWMgaW50IHNpX2RwbV9sYXRlX2luaXQodm9p
ZCAqaGFuZGxlKQogCWludCByZXQ7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAKLQlpZiAoIWFkZXYtPnBtLmRwbV9lbmFibGVk
KQorCS8qIHJldHVybiBlYXJseSB3aGVuIGRwbSBpcyBlbmFibGVkICovCisJaWYgKGFkZXYtPnBt
LmRwbV9lbmFibGVkKQogCQlyZXR1cm4gMDsKIAogCXJldCA9IHNpX3NldF90ZW1wZXJhdHVyZV9y
YW5nZShhZGV2KTsKLS0gCjIuMjUuMQoK

--_002_DM5PR12MB2469106B445537FF8F7EBA19F1BE9DM5PR12MB2469namp_--
